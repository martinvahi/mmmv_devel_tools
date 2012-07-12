#!/opt/ruby/bin/ruby -Ku
#=========================================================================
=begin

 Copyright 2010, martin.vahi@softf1.com that has an
 Estonian personal identification code of 38108050020.
 All rights reserved.

 Redistribution and use in source and binary forms, with or
 without modification, are permitted provided that the following
 conditions are met:

 * Redistributions of source code must retain the above copyright
   notice, this list of conditions and the following disclaimer.
 * Redistributions in binary form must reproduce the above copyright
   notice, this list of conditions and the following disclaimer
   in the documentation and/or other materials provided with the
   distribution.
 * Neither the name of the Martin Vahi nor the names of its
   contributors may be used to endorse or promote products derived
   from this software without specific prior written permission.

 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND
 CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES,
 INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
 MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR
 CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
 BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
 SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
 INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
 WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
 OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

=end
#=========================================================================
if !defined? KIBUVITS_HOME
   x=ENV['KIBUVITS_HOME']
   KIBUVITS_HOME=x if (x!=nil and x!="")
end # if

require "rubygems"
require "monitor"

if defined? KIBUVITS_HOME
   require  KIBUVITS_HOME+"/include/kibuvits_msgc.rb"
   require  KIBUVITS_HOME+"/include/kibuvits_ix.rb"
   require  KIBUVITS_HOME+"/include/kibuvits_str_concat_array_of_strings.rb"
else
   require  "kibuvits_msgc.rb"
   require  "kibuvits_ix.rb"
   require  "kibuvits_str_concat_array_of_strings.rb"
end # if

require "singleton"
require "time"
#==========================================================================

class Kibuvits_str
   attr_reader :i_unicode_maximum_codepoint

   @@cache=Hash.new
   @@mx_cache=Mutex.new

   def initialize
      # As of 2011 the valid range of Unicode points is U0000 to x2=U10FFFF
      # x2 = 16^5+15*16^3+15*16^2+15*16+15 = 1114111 ;
      @i_unicode_maximum_codepoint=1114111
      @b_kibuvits_bootfile_run=(defined? KIBUVITS_s_VERSION)
   end # initialize

   public

   #-----------------------------------------------------------------------

   # For ab, bb, ba it checks that there does not exist
   # any pairs, where one element is equal to or substring
   # of the other. It also checks that no element is
   # a substring of the pair concatenation. For example,
   # a pair (ab,ba) has concatenations abba, baab, and the
   # abba contains the element bb as its substring.
   def verify_noninclusion(array_of_strings)
      b_inclusion_present=false
      msg="Inclusions not found."
      ar_str=array_of_strings
      ht=Hash.new
      ar_str.each do |s_1|
         if ht.has_key?(s_1)
            b_inclusion_present=true
            msg="String \""+s_1+"\" is within the array more than once."
            return b_inclusion_present,msg
         end # if
      end # if
      # All of the pixels of a width*height sized image can
      # be encoded to a single array that has width*height elements.
      # The array index determines the X and Y of the pixel.
      # The pixel coordinates are pairs. The width of a square
      # equals its height. :-)
      i_side=ar_str.length
      s_1=""
      s_2=""
      s_concat=""
      s_elem=""
      i_side.times do |y|
         s_2=ar_str[y]
         i_side.times do |x|
            next if x==y
            s_1=ar_str[x]
            if (s_1.index(s_2)!=nil)
               b_inclusion_present=true
               msg="\""+s_1+"\" includes \""+s_2+"\""
               break
            end # if
            if (s_2.index(s_1)!=nil)
               b_inclusion_present=true
               msg="\""+s_2+"\" includes \""+s_1+"\""
               break
            end # if
            # abba+bball=abbABBAll, which contains abba twice, but
            # it is not a problem, because if the first abba is
            # removed, the second one also breaks.
            s_concat=s_1+s_2
            i_side.times do |i_elem|
               next if (i_elem==x)||(i_elem==y)
               s_elem=ar_str[i_elem]
               if (s_concat.index(s_elem)!=nil)
                  b_inclusion_present=true
                  msg="Concatenation \""+s_concat+"\" includes \""+
                  s_elem+"\""
                  break
               end # if
            end # loop
            break if b_inclusion_present
            s_concat=s_2+s_1
            i_side.times do |i_elem|
               next if (i_elem==x)||(i_elem==y)
               s_elem=ar_str[i_elem]
               if (s_concat.index(s_elem)!=nil)
                  b_inclusion_present=true
                  msg="Concatenation \""+s_concat+"\" includes \""+
                  s_elem+"\""
                  break
               end # if
            end # loop
            break if b_inclusion_present
         end # loop
         break if b_inclusion_present
      end # loop
      return b_inclusion_present,msg
   end # verify_noninclusion

   def Kibuvits_str.verify_noninclusion(array_of_strings)
      b_inclusion_present,msg=Kibuvits_str.instance.verify_noninclusion(
      array_of_strings)
      return b_inclusion_present,msg
   end # Kibuvits_str.verify_noninclusion

   #-----------------------------------------------------------------------

   private

   # It should be part of the pick_extraction_step, but
   # due to light speed optimization, it's not even called from there.
   def pick_extraction_step_input_verification(
      s_start, s_end, haystack, ht, s_block_substitution, s_new_ht_key)
      kibuvits_throw "s_start.length==0" if s_start.length==0
      kibuvits_throw "s_end.length==0" if s_end.length==0
      kibuvits_throw "s_block_substitution.length==0" if s_block_substitution.length==0
      if KIBUVITS_b_DEBUG
         kibuvits_typecheck binding(), Hash, ht
      end # if
      ar=Array.new
      ar<<s_start
      ar<<s_end
      ar<<s_block_substitution
      b_inclusion_present,msg=Kibuvits_str.verify_noninclusion ar
      ar.clear
      if b_inclusion_present
         kibuvits_throw "Inclusion present. msg=="+msg
      end # if
   end # pick_extraction_step_input_verification

   def pick_extraction_step(s_start, s_end, haystack, ht,
      s_block_substitution, s_new_ht_key)
      msg="ok";
      s_hay=haystack
      i_start=s_hay.index s_start
      if i_start==nil
         msg="done"
         msg="err_missing_start_or_multiple_end" if (s_hay.index s_end)!=nil
         return msg, s_hay
      end # if
      i_end=s_hay.index s_end
      if i_end==nil
         msg="err_missing_end"
         return msg, s_hay
      end # if
      s_left=""
      s_left=s_hay[0..(i_start-1)] if 0<i_start
      i_e2=i_end-1+s_end.length
      s_middle=s_hay[i_start..i_e2]
      s_right=""
      s_right=s_hay[(i_e2+1)..-1] if i_e2<(s_hay.length-1)
      kibuvits_throw "i_e2=="+i_e2.to_s if (s_hay.length-1)<i_e2
      s_hay=s_left+s_block_substitution+s_right
      s_block_content=""
      if((s_start.length+s_end.length)<s_middle.length)
         s_block_content=s_middle[(s_start.length)..((-1)-s_end.length)]
      end # if
      if (s_block_content.index s_start)!=nil
         msg="err_multiple_start";
         return msg, s_hay
      end # if
      ht[s_new_ht_key]=s_block_content
      return msg, s_hay
   end # pick_extraction_step

   public

   # Replaces each block that starts with s_start and ends with s_end,
   # with a Globally Unique Identifier (GUID). It does not guarantee
   # that the text before and after the s_start and s_end won't "blend in"
   # with the GUID like "para"+"dise"+"diseases"="paradise"+"dise+"ases"
   # or "under"+"stand"+"standpoint"="understand"+"stand"+"point"
   # The blocks are gathered
   # to a hashtable and prior to storing the blocks to the hashtable,
   # the s_start and s_end are removed from the block. The GUIDs are
   # used as hashtable keys.
   def pick_by_instance(s_start,s_end,s_haystack,
      msgcs=Kibuvits_msgc_stack.new)
      if KIBUVITS_b_DEBUG
         bn=binding()
         kibuvits_typecheck bn, String, s_start
         kibuvits_typecheck bn, String, s_end
         kibuvits_typecheck bn, String, s_haystack
         kibuvits_typecheck bn, Kibuvits_msgc_stack, msgcs
      end # if
      # TODO: refactor the msg out of here and use the Kibuvits_msgc_stack
      # instead.
      ht_out=Hash.new
      s_hay=s_haystack
      b_failure=false
      msg="ok"
      s_block_substitution=Kibuvits_GUID_generator.generate_GUID # for inclusion tests
      s_new_ht_key=""
      pick_extraction_step_input_verification(
      s_start, s_end, s_hay, ht_out, s_block_substitution, s_new_ht_key)
      while msg=="ok"
         s_block_substitution=Kibuvits_GUID_generator.generate_GUID
         s_new_ht_key=s_block_substitution
         msg, s_hay=pick_extraction_step(s_start, s_end,
         s_hay, ht_out,s_block_substitution,s_new_ht_key)
      end # loop
      msgcs.cre msg if msg!="done"
      return s_hay,ht_out
   end # pick_by_instance

   def Kibuvits_str.pick_by_instance(s_start,s_end,s_haystack,
      msgcs=Kibuvits_msgc_stack.new)
      s_hay,ht_out=Kibuvits_str.instance.pick_by_instance(
      s_start,s_end,s_haystack,msgcs)
      return s_hay,ht_out
   end # Kibuvits_str.pick_by_instance

   #-----------------------------------------------------------------------

   #	def Kibuvits_str.pick_by_type(
   #			s_start, s_end, haystack, ht, s_block_substitution)
   #   # May be this method/function is not even necessary?
   #		s_hay=haystack
   #		b_failure=false
   #		msg="ok"
   #		s_new_ht_key=""
   #		pick_extraction_step_input_verification(
   #			s_start, s_end, s_hay, ht, s_block_substitution, s_new_ht_key)
   #        while msg=="ok"
   #			s_new_ht_key=Kibuvits_GUID_generator.generate_GUID
   #			msg, s_hay=pick_extraction_step(s_start, s_end,
   #				s_hay, ht,s_block_substitution,s_new_ht_key)
   #		end # loop
   #		b_failure=true if msg!="done"
   #		return b_failure,s_hay,msg
   #	end # Kibuvits_str.pick_by_type

   #-----------------------------------------------------------------------

   private

   def Kibuvits_str.wholenumber_ASCII_2_whonenumber_Unicode_init1
      return if (@@cache.has_key? 'whncses')
      @@mx_cache.synchronize do
         break if (@@cache.has_key? 'whncses')
         whncses=Hash.new
         whncses[0x80]=0x20AC
         whncses[0x81]=0x81
         whncses[0x82]=0x201A
         whncses[0x83]=0x192
         whncses[0x84]=0x201E
         whncses[0x85]=0x2026
         whncses[0x86]=0x2020
         whncses[0x87]=0x2021
         whncses[0x88]=0x2C6
         whncses[0x89]=0x2030
         whncses[0x8A]=0x160
         whncses[0x8B]=0x2039
         whncses[0x8C]=0x152
         whncses[0x8D]=0x8D
         whncses[0x8E]=0x17D
         whncses[0x8F]=0x8F
         whncses[0x90]=0x90
         whncses[0x91]=0x2018
         whncses[0x92]=0x2019
         whncses[0x93]=0x201C
         whncses[0x94]=0x201D
         whncses[0x95]=0x2022
         whncses[0x96]=0x2013
         whncses[0x97]=0x2014
         whncses[0x98]=0x2DC
         whncses[0x99]=0x2122
         whncses[0x9A]=0x161
         whncses[0x9B]=0x203A
         whncses[0x9C]=0x153
         whncses[0x9D]=0x9D
         whncses[0x9E]=0x17E
         whncses[0x9F]=0x178
         @@cache['whncses']=whncses
      end # synchronize
   end # Kibuvits_str.wholenumber_ASCII_2_whonenumber_Unicode_init1

   public

   # According to http://www.alanwood.net/demos/ansi.html
   # there exist codepoints, where the integer representation of an
   # ASCII character does not match with the character's integer
   # representation in the Unicode.
   def wholenumber_ASCII_2_whonenumber_Unicode(i_ascii)
      if KIBUVITS_b_DEBUG
         kibuvits_typecheck binding(), Fixnum, i_ascii
      end # if
      b_failure=false
      msg="ASCII 2 Unicode conversion succeeded."
      i_out=0
      if (i_ascii<32)||(0xFF<i_ascii)
         if (i_ascii==0xA)||(i_ascii==0xD) # "\n" and "\r"
            i_out=i_ascii
            return b_failure, i_out, msg
         end # end
         msg="ASCII 2 Unicode conversion failed. i_ascii=="+i_ascii.to_s(16)
         b_failure=true
         return b_failure, i_out, msg
      end # end
      if (i_ascii<=0x7f)||(0xA0<=i_ascii)
         i_out=i_ascii
         return b_failure, i_out, msg
      end # if
      Kibuvits_str.wholenumber_ASCII_2_whonenumber_Unicode_init1
      whncses=@@cache['whncses']
      if whncses.has_key? i_ascii
         i_out=0+whncses[i_ascii]
         return b_failure, i_out, msg
      end # if
      b_failure=true
      msg="ASCII 2 Unicode conversion failed. i_ascii=="+i_ascii.to_s(16)
      return b_failure, i_out, msg
   end # wholenumber_ASCII_2_whonenumber_Unicode

   def Kibuvits_str.wholenumber_ASCII_2_whonenumber_Unicode(i_ascii)
      b_failure, i_out, msg=Kibuvits_str.instance.wholenumber_ASCII_2_whonenumber_Unicode(
      i_ascii)
      return b_failure, i_out, msg
   end # Kibuvits_str.wholenumber_ASCII_2_whonenumber_Unicode

   #-----------------------------------------------------------------------

   public

   # It modifies the input array.
   def Kibuvits_str.sort_by_length(array_of_strings, longest_strings_first=true)
      if longest_strings_first
         array_of_strings.sort!{|a,b| b.length<=>a.length}
      else
         array_of_strings.sort!{|a,b| a.length<=>b.length}
      end # if
      return nil
   end # Kibuvits_str.sort_by_length

   #-----------------------------------------------------------------------

   public

   # ribboncut("YY","xxYYmmmmYY")->["xx","mmmm",""]
   # ribboncut("YY","YYxxYYmmmm")->["","xx","mmmm"]
   # ribboncut("YY","YY")->["",""]
   # ribboncut("YY","YYYY")->["","",""]
   # ribboncut("YY","xxx")->["xxx"]
   #
   # One can think of a ribbon cutting ceremony, where a piece of cut
   # out of a ribbon.
   def ribboncut(s_needle, s_haystack)
      kibuvits_throw 's_needle==""' if s_needle==""
      if KIBUVITS_b_DEBUG
         bn=binding()
         kibuvits_typecheck bn, String, s_needle
         kibuvits_typecheck bn, String, s_haystack
      end # if
      ar_out=Array.new
      if !s_haystack.include? s_needle
         ar_out<<""+s_haystack
         return ar_out
      end # if
      if s_haystack==s_needle
         ar_out<<""
         ar_out<<""
         return ar_out
      end # if
      # YYxxxYYmmmmYY    xxxYYYYmmmm
      # 0123456789012    01234567890
      # STR::=(NEEDLE|TOKEN)
      ix_str_low=0
      ix_str_high=nil
      ix_str_start_candidate=0
      ix_hay_max=s_haystack.length-1
      i_needle_len=s_needle.length
      ix_needle_low=nil
      s1=""
      while true
         ix_needle_low=s_haystack.index(s_needle,ix_str_start_candidate)
         if ix_needle_low==nil
            s1=""
            if ix_str_start_candidate<=ix_hay_max
               s1=s_haystack[ix_str_start_candidate..(-1)]
            end # if
            ar_out<<s1
            break
         end # if
         ix_str_start_candidate=ix_needle_low+i_needle_len
         ix_str_high=ix_needle_low-1
         s1=""
         if ix_str_low<=ix_str_high
            s1=s_haystack[ix_str_low..ix_str_high]
            s1="" if s1==s_needle
         end # if
         ar_out<<s1
         ix_str_low=ix_str_start_candidate
      end # loop
      return ar_out
   end # ribboncut

   def Kibuvits_str.ribboncut(s_needle, s_haystack)
      ar_out=Kibuvits_str.instance.ribboncut s_needle, s_haystack
      return ar_out
   end # Kibuvits_str.ribboncut

   #-----------------------------------------------------------------------

   private

   def batchreplace_csnps_needle_is_key(ht_needles)
      ar_subst_needle_pairs=Array.new
      ar_pair1=nil
      ht_needles.each_pair do |key,s_subst|
         kibuvits_throw '<needle string>==""' if key==""
         kibuvits_throw '<substitution string>==""' if s_subst==""
         ar_pair1=[s_subst,key]
         ar_subst_needle_pairs<<ar_pair1
      end # loop
      return ar_subst_needle_pairs
   end #batchreplace_csnps_needle_is_key

   def batchreplace_csnps_subst_is_key(ht_needles)
      ar_subst_needle_pairs=Array.new
      ar_pair1=nil
      ht_needles.each_pair do |key,ar_value|
         kibuvits_throw '<substitution string>==""' if key==""
         ar_value.each do |s_needle|
            kibuvits_throw 's_needle==""' if s_needle==""
            ar_pair1=[key,s_needle]
            ar_subst_needle_pairs<<ar_pair1
         end # loop
      end # loop
      return ar_subst_needle_pairs
   end #batchreplace_csnps_subst_is_key


   def batchreplace_step(ar_piece,ar_subst_needle)
      s_hay=ar_piece[0]
      s_rightmost_subst=ar_piece[1]
      s_subst=ar_subst_needle[0]
      s_needle=ar_subst_needle[1]
      ar_pieces2=Array.new
      ar=Kibuvits_str.ribboncut s_needle, s_hay
      n=ar.length-1
      n.times {|i| ar_pieces2<<[ar[i],s_subst]}
      ar_pieces2<<[ar[n],s_rightmost_subst]
      return ar_pieces2
   end # batchreplace_step

   public

   # Makes it possible to replace all of the needle strings within
   # the haystack string with a substitution string that
   # contains at least one of the needle strings as one of its substrings.
   #
   # It's also useful, when at least one of the needle strings contains
   # at least one other needle string as its substring.
   #
   # By combining multiple substitutions into a single, "atomic",
   # operation, one can treat the needle strings of multiple
   # substitutions as a whole, single, set.
   #
   # An example of a case that is difficult to do properly with plain
   # substitutions:
   # needle-substitutionstring pairs:
   #         ("cat","Casanova")
   #         ("nova","catastrophe")
   # haystack: "A cat saw a nova."
   # Correct substitution result, as given by the Kibuvits_str.batchreplace:
   #           "A Casanova saw a catastrophe."
   # Incorrect versions as gained by sequential substitutions:
   #           "A Casacatastrophe saw a catastrophe."
   #           "A Casanova saw a Casanovaastrophe."
   #
   # if b_needle_is_key==true
   #     ht_needles[<needle string>]==<substitution string>
   # else
   #     ht_needles[<substitution string>]==<array of needle strings>
   def batchreplace(ht_needles, s_haystack, b_needle_is_key=true)
      # The idea is that "i" in the "Sci-Fi idea" can be replaced
      # with "X" by decomposing the haystack to ar=["Sc","-F"," ","dea"]
      # and treating each of the elements, except the last one, as
      # <a string><substitution string>. The substitution string always stays
      # at the right side, even if the <a string> is decomposed recursively.
      #
      # If the <substitution string> were temporarily replaced with a
      # Globally Unique Identifier (GUID) and concatenated to the <a string>,
      # then there might be difficulties separating the two because in
      # some very rare cases it would be like
      # "aaXXmm"+"XXmmXX"="aaXXmmXXmmXX"="aa"+"XXmmXX"+"mmXX".
      # That's why the <a string> and the <subsititution string> are kept
      # as a pair during the processing.
      #
      ar_subst_needle_pairs=nil
      if b_needle_is_key
         ar_subst_needle_pairs=batchreplace_csnps_needle_is_key(
         ht_needles)
      else
         ar_subst_needle_pairs=batchreplace_csnps_subst_is_key(
         ht_needles)
      end # if
      # One wants to replace the longest needles first. So they're
      # placed to the smallest indices of the array.
      # The idea is that for a haystack like "A cat saw a caterpillar",
      # one wants to remove the "caterpillar" from the sentence before
      # the "cat", because by removing the "cat" first one would break
      # the "caterpillar". Strings that have the same length, can't
      # possibly be eachothers' substrings without equaling with eachother.
      ar_subst_needle_pairs.sort!{|a,b| b[1].length<=>a[1].length}
      ar_pieces=Array.new
      ar_piece=[s_haystack, nil]
      ar_pieces<<ar_piece
      ar_subst_needle=""
      ar_piece=nil
      ar_pieces2=Array.new
      ar_subst_needle_pairs.length.times do |i|
         ar_subst_needle=ar_subst_needle_pairs[i]
         ar_pieces.length.times do |ii|
            ar_piece=ar_pieces[ii]
            ar_pieces2=ar_pieces2+
            batchreplace_step(ar_piece, ar_subst_needle)
         end # loop
         ar_pieces.clear # May be it facilitates memory reuse.
         ar_pieces=ar_pieces2
         ar_pieces2=Array.new
      end # loop
      s_out=""
      #s_out.force_encoding("utf-8")
      n=ar_pieces.length-1
      s_subst=""
      n.times do |i|
         ar_piece=ar_pieces[i]
         s_out<<ar_piece[0]
         s_out<<ar_piece[1]
      end # loop
      s_out<<(ar_pieces[n])[0]
      return s_out
   end # batchreplace

   def Kibuvits_str.batchreplace(ht_needles, s_haystack, b_needle_is_key=true)
      s_out=Kibuvits_str.instance.batchreplace(ht_needles,s_haystack,
      b_needle_is_key)
      return s_out
   end # Kibuvits_str.batchreplace

   #-----------------------------------------------------------------------
   public

   # A citation from http://en.wikipedia.org/wiki/Newline
   # (visit date: January 2010)
   #
   # The Unicode standard defines a large number of characters that
   # conforming applications should recognize as line terminators: [2]
   #
   #  LF:    Line Feed, U+000A
   #  CR:    Carriage Return, U+000D
   #  CR+LF: CR (U+000D) followed by LF (U+000A)
   #  NEL:   Next Line, U+0085
   #  FF:    Form Feed, U+000C
   #  LS:    Line Separator, U+2028
   #  PS:    Paragraph Separator, U+2029
   #
   # The ruby 1.8 string operations do not support Unicode code-points
   # properly
   # (http://blog.grayproductions.net/articles/bytes_and_characters_in_ruby_18 ),
   # TODO: this method is subject to completion after one can fully
   # move to ruby 1.9
   def get_array_of_linebreaks(b_ok_to_be_immutable=false)
      if (@@cache.has_key? 'ar_linebreaks')
         ar_linebreaks_immutable=@@cache['ar_linebreaks']
         ar_linebreaks=ar_linebreaks_immutable
         if !b_ok_to_be_immutable
            ar_linebreaks=Array.new
            ar_linebreaks_immutable.each{|x| ar_linebreaks<<""+x}
         end # if
         return ar_linebreaks
      end # if
      @@mx_cache.synchronize do
         break if (@@cache.has_key? 'ar_linebreaks')
         ar_linebreaks_immutable=["\r\n","\n","\r"]
         ar_linebreaks_immutable.freeze
         @@cache['ar_linebreaks']=ar_linebreaks_immutable
      end # synchronize
      ar_linebreaks_immutable=@@cache['ar_linebreaks']
      ar_linebreaks=ar_linebreaks_immutable
      if !b_ok_to_be_immutable
         ar_linebreaks=Array.new
         ar_linebreaks_immutable.each{|x| ar_linebreaks<<""+x}
      end # if
      return ar_linebreaks
   end # get_array_of_linebreaks

   def Kibuvits_str.get_array_of_linebreaks(b_ok_to_be_immutable=false)
      ar_linebreaks=Kibuvits_str.instance.get_array_of_linebreaks(
      b_ok_to_be_immutable)
      return ar_linebreaks
   end # Kibuvits_str.get_array_of_linebreaks

   #-----------------------------------------------------------------------
   public

   def normalise_linebreaks(s,substitution_string=$kibuvits_lc_linebreak)
      s_subst=substitution_string
      ar_special_cases=Kibuvits_str.get_array_of_linebreaks true
      ht_needles=Hash.new
      ht_needles[s_subst]=ar_special_cases
      s_hay=s
      s_out=Kibuvits_str.batchreplace ht_needles, s_hay, false
      return s_out
   end # normalise_linebreaks

   def Kibuvits_str.normalise_linebreaks(s,substitution_string=$kibuvits_lc_linebreak)
      s_out=Kibuvits_str.instance.normalise_linebreaks(s,substitution_string)
      return s_out
   end # Kibuvits_str.normalise_linebreaks

   #-----------------------------------------------------------------------
   public

   # It returns an array of 2 elements. If the separator is not
   # found, the array[0]==input_string and array[1]=="".
   #
   # The ar_output is for array instance reuse and is expected
   # to increase speed a tiny bit at "snatching".
   def bisect(input_string,separator_string,ar_output=Array.new(2,""))
      # If one updates this code, then one should also copy-paste
      # an updated version of this method to the the ProgFTE implemntation.
      # The idea behind such an arrangement is that the ProgFTE implementation
      # is not allowed to have any dependencies other than the library booting code.
      #
      # TODO: Optimize it to use smaller temporary string instances. For example,
      #       in stead of "a|b|c|d"->("a", "b|c|d"->("b","c|d"->("c","d")))
      #       one should: "a|b|c|d"->("a|b"->("a","d"),"c|d"->("c","d"))
      i_separator_stringlen=separator_string.length
      if i_separator_stringlen==0
         exc=Exception.new("separator_string==\"\"")
         if @b_kibuvits_bootfile_run
            kibuvits_throw(exc)
         else
            raise(exc)
         end # if
      end # if
      ar=ar_output
      i=input_string.index(separator_string)
      if(i==nil)
         ar[0]=input_string
         ar[1]=""
         return ar;
      end # if
      if i==0
         ar[0]=""
      else
         ar[0]=input_string[0..(i-1)]
      end # if
      i_input_stringlen=input_string.length
      if (i+i_separator_stringlen)==i_input_stringlen
         ar[1]=""
      else
         ar[1]=input_string[(i+i_separator_stringlen)..(-1)]
      end # if
      return ar
   end # bisect

   def Kibuvits_str.bisect(input_string, separator_string,
      ar_output=Array.new(2,""))
      ar=Kibuvits_str.instance.bisect(input_string,separator_string,
      ar_output)
      return ar
   end # Kibuvits_str.bisect

   #-----------------------------------------------------------------------
   public

   # Returns an array of strings that contains only the snatched string pieces.
   def snatch_n_times(haystack_string, separator_string,n)
      # If one updates this code, then one should also copy-paste
      # an updated version of this method to the the ProgFTE implemntation.
      # The idea behind such an arrangement is that the ProgFTE implementation
      # is not allowed to have any dependencies other than the library booting code.
      if @b_kibuvits_bootfile_run
         bn=binding()
         kibuvits_typecheck bn, String, haystack_string
         kibuvits_typecheck bn, String, separator_string
         kibuvits_typecheck bn, Fixnum, n
      end # if
      if(separator_string=="")
         exc=Exception.new("\nThe separator string had a "+
         "value of \"\", but empty strings are not "+
         "allowed to be used as separator strings.");
         if @b_kibuvits_bootfile_run
            kibuvits_throw(exc)
         else
            raise(exc)
         end # if
      end # if
      s_hay=haystack_string
      if s_hay.length==0
         exc=Exception.new("haystack_string.length==0")
         if @b_kibuvits_bootfile_run
            kibuvits_throw(exc)
         else
            raise(exc)
         end # if
      end # if
      # It's a bit vague, whether '' is also present at the
      # very end and very start of the string or only between
      # characters. That's why there's a limitation, that the
      # separator_string may not equal with the ''.
      if separator_string.length==0
         exc=Exception.new("separator_string.length==0")
         if @b_kibuvits_bootfile_run
            kibuvits_throw(exc)
         else
            raise(exc)
         end # if
      end # if
      s_hay=""+haystack_string
      ar=Array.new
      ar1=Array.new(2,"")
      n.times do |i|
         ar1=bisect(s_hay,separator_string,ar1)
         ar<<ar1[0]
         s_hay=ar1[1]
         if (s_hay=='') and ((i+1)<n)
            exc=Exception.new("Expected number of separators is "+n.to_s+
            ", but the haystack_string contained only "+(i+1).to_s+
            "separator strings.")
            if @b_kibuvits_bootfile_run
               kibuvits_throw(exc)
            else
               raise(exc)
            end # if
         end # if
      end # loop
      return ar;
   end # snatch_n_times

   def Kibuvits_str.snatch_n_times(haystack_string, separator_string,n)
      ar_out=Kibuvits_str.instance.snatch_n_times(haystack_string, separator_string,n)
      return ar_out
   end # Kibuvits_str.snatch_n_times

   #-----------------------------------------------------------------------
   public

   def count_substrings(s_haystack,s_needle)
      if KIBUVITS_b_DEBUG
         bn=binding()
         kibuvits_typecheck bn, String, s_haystack
         kibuvits_typecheck bn, String, s_needle
      end # if
      i_s_needlelen=s_needle.length
      kibuvits_throw "s_needle.length==0" if i_s_needlelen==0
      i_s_haystack=s_haystack.length
      i=s_haystack.gsub(s_needle,$kibuvits_lc_emptystring).length
      return 0 if i==i_s_haystack
      i_out=(i_s_haystack-i)/i_s_needlelen # It all stays in Fixnum domain.
      return i_out
   end # count_substrings

   def Kibuvits_str.count_substrings(s_haystack,s_needle)
      i_out=Kibuvits_str.instance.count_substrings s_haystack, s_needle
      return i_out
   end # Kibuvits_str.count_substrings

   #-----------------------------------------------------------------------
   public

   # It mimics the PHP explode function, but it's not a one to one copy of it.
   # Practically, it converts the s_haystack to an array
   # and uses the s_needle as a separator at repetitive bisection.
   def explode(s_haystack, s_needle)
      if KIBUVITS_b_DEBUG
         bn=binding()
         kibuvits_typecheck bn, String, s_haystack
         kibuvits_typecheck bn, String, s_needle
      end # if
      i_s_haystack=s_haystack.length
      return [""] if i_s_haystack==0
      i_s_needlelen=s_needle.length
      if i_s_needlelen==0
         ar_out=Array.new
         i_s_haystack.times{|i| ar_out<<s_haystack[i..i]}
         return ar_out
      end # if
      return [s_haystack] if i_s_haystack<i_s_needlelen
      ar_out=Array.new
      i_needlecount=Kibuvits_str.count_substrings(s_haystack, s_needle)
      s_hay=s_haystack+s_needle
      ar_out=Kibuvits_str.snatch_n_times(s_hay,s_needle,(i_needlecount+1))
      return ar_out
   end # explode

   def Kibuvits_str.explode(s_haystack, s_needle)
      ar_out=Kibuvits_str.instance.explode s_haystack, s_needle
      return ar_out
   end # Kibuvits_str.explode

   #-----------------------------------------------------------------------
   public

   def commaseparated_list_2_ht(s_haystack,s_separator=",")
      if KIBUVITS_b_DEBUG
         bn=binding()
         kibuvits_typecheck bn, String, s_haystack
         kibuvits_typecheck bn, String, s_separator
      end # if
      ar=explode(s_haystack,s_separator)
      ht_out=Hash.new
      s=nil
      i=42
      ar.each do |s_piece|
         s=trim(s_piece)
         ht_out[s]=i if 0<s.length
      end # loop
      return ht_out
   end # commaseparated_list_2_ht

   def Kibuvits_str.commaseparated_list_2_ht(s_haystack,s_separator=",")
      ht_out=Kibuvits_str.instance.commaseparated_list_2_ht(
      s_haystack,s_separator)
      return ht_out
   end # Kibuvits_str.commaseparated_list_2_ht

   #-----------------------------------------------------------------------
   public

   def character_is_escapable(s_character,
      s_characters_that_are_excluded_from_the_list_of_escapables="")
      bn=binding()
      if KIBUVITS_b_DEBUG
         kibuvits_typecheck bn, String, s_character
      end # if
      if s_character.length!=1
         kibuvits_throw "s_character==\""+s_character+"\", "+"s_character.length!=1"
      end # if
      s_xc=s_characters_that_are_excluded_from_the_list_of_escapables
      if KIBUVITS_b_DEBUG
         kibuvits_typecheck bn, String, s_xc
      end # if
      b=false
      if !s_xc.include? s_character
         s_escapables="\"'\n\r\t\\"
         b=s_escapables.include? s_character
      end # if
      return b
   end # character_is_escapable

   def Kibuvits_str.character_is_escapable(s_character,
      s_characters_that_are_excluded_from_the_list_of_escapables="")
      b=Kibuvits_str.instance.character_is_escapable(s_character,
      s_characters_that_are_excluded_from_the_list_of_escapables)
      return b
   end # Kibuvits_str.character_is_escapable

   #-----------------------------------------------------------------------
   public

   def index_is_outside_of_the_string(a_string,index)
      # TODO: Move this method to Kibuvits_ix and make it also work
      # with arrays and alike.
      if KIBUVITS_b_DEBUG
         bn=binding()
         kibuvits_typecheck bn, String, a_string
         kibuvits_typecheck bn, Fixnum, index
      end # if
      b=((index<0)||(a_string.length-1)<index)
      return b
   end # index_is_outside_of_the_string

   def Kibuvits_str.index_is_outside_of_the_string(a_string,index)
      b=Kibuvits_str.instance.index_is_outside_of_the_string a_string, index
      return b
   end # Kibuvits_str.index_is_outside_of_the_string

   #-----------------------------------------------------------------------
   public

   # Explanation by an example:
   # count_character_repetition("aXXaXXX",1)==2
   #                             0123456
   # count_character_repetition("aXXaXXX",4)==3
   #                             0123456
   # count_character_repetition("aXXaXXX",3)==1
   #                             0123456
   # count_character_repetition("aXXaXXX",6)==1
   #                             0123456
   def count_character_repetition(a_string,index_of_the_character)
      if KIBUVITS_b_DEBUG
         bn=binding()
         kibuvits_typecheck bn, String, a_string
         kibuvits_typecheck bn, Fixnum, index_of_the_character
      end # if
      i_ix=index_of_the_character
      i_smax=a_string.length-1
      if Kibuvits_str.index_is_outside_of_the_string(a_string,i_ix)
         kibuvits_throw "index_of_the_character=="+i_ix.to_s+" is outside of "+
         "string a_string==\""+a_string+"\"."
      end # if
      s_char=a_string[i_ix..i_ix]
      i_count=0
      if Kibuvits_str.character_is_escapable(s_char)
         i_iix=i_ix
         while i_iix<=i_smax
            break if a_string[i_iix..i_iix]!=s_char
            i_iix=i_iix+1
         end # loop
         i_count=i_iix-i_ix
      else
         s_hay=a_string[i_ix..(-1)]
         rg=Regexp.new("["+s_char+"]+")
         md=rg.match(s_hay)
         kibuvits_throw "md==nil" if md==nil
         i_count=md[0].length
      end # if
      kibuvits_throw "i_count=="+i_count.to_s+"<1" if i_count<1
      return i_count
   end # count_character_repetition

   def Kibuvits_str.count_character_repetition(a_string,index_of_the_character)
      i_count=Kibuvits_str.instance.count_character_repetition(a_string,
      index_of_the_character)
      return i_count
   end # Kibuvits_str.count_character_repetition

   #-----------------------------------------------------------------------
   public

   # The idea is that in "\n" and "\\\n" the n is escaped, but in
   # "\\n" and "\\\\\\n" the n is not escaped.
   def character_is_escaped(a_string,index_of_the_character)
      if KIBUVITS_b_DEBUG
         bn=binding()
         kibuvits_typecheck bn, String, a_string
         kibuvits_typecheck bn, Fixnum, index_of_the_character
      end # if
      i_ix=index_of_the_character
      if Kibuvits_str.index_is_outside_of_the_string(a_string,i_ix)
         kibuvits_throw "index_of_the_character=="+i_ix.to_s+" is outside of "+
         "string a_string==\""+a_string+"\"."
      end # if
      return false if i_ix==0
      i_prfx=i_ix-1
      return false if a_string[i_prfx..i_prfx]!="\\"
      s_az=(a_string[0..i_prfx]).reverse
      i_count=Kibuvits_str.count_character_repetition(s_az, 0)
      b_is_escaped=((i_count%2)==1)
      return b_is_escaped
   end # character_is_escaped

   def Kibuvits_str.character_is_escaped(a_string,index_of_the_character)
      b_is_escaped=Kibuvits_str.instance.character_is_escaped(a_string,
      index_of_the_character)
      return b_is_escaped
   end # Kibuvits_str.character_is_escaped

   #-----------------------------------------------------------------------
   public

   def clip_tail_by_str(s_haystack,s_needle)
      if KIBUVITS_b_DEBUG
         bn=binding()
         kibuvits_typecheck bn, String, s_haystack
         kibuvits_typecheck bn, String, s_needle
      end # if
      i_sh_len=s_haystack.length
      i_sn_len=s_needle.length
      return s_haystack if (i_sh_len<i_sn_len)||(i_sn_len==0)
      if i_sh_len==i_sn_len
         if s_haystack==s_needle
            return ""
         else
            # For speed only. There's no point of re-comparing.
            return s_haystack
         end # if
      end # if
      if s_haystack[(i_sh_len-i_sn_len)..(-1)]==s_needle
         return s_haystack[0..(i_sh_len-i_sn_len-1)]
      end # if
      return s_haystack
   end # clip_tail_by_str

   def Kibuvits_str.clip_tail_by_str(s_haystack,s_needle)
      s_haystack=Kibuvits_str.instance.clip_tail_by_str s_haystack, s_needle
      return s_haystack
   end # Kibuvits_str.clip_tail_by_str

   #-----------------------------------------------------------------------
   public

   # Removes spaces, line breaks and tabs from the start and end of the string.
   def trim(s_string)
      if KIBUVITS_b_DEBUG
         kibuvits_typecheck binding(), String, s_string
      end # if
      rgx=/^[\s\t\r\n]+/
      s_out=s_string.gsub(rgx,$kibuvits_lc_emptystring)
      s_out=s_out.reverse.gsub(rgx,$kibuvits_lc_emptystring).reverse
      return s_out
   end # trim

   def Kibuvits_str.trim(s_string)
      s_out=Kibuvits_str.instance.trim s_string
      return s_out
   end # Kibuvits_str.trim

   #-----------------------------------------------------------------------
   private

   def configstylestr_2_ht_collect_var(ht_opmem)
      ht_out=ht_opmem['ht_out']
      ht_out[ht_opmem['s_varname']]=ht_opmem['s_varvalue']
      ht_opmem['s_varvalue']=""
   end # configstylestr_2_ht_collect_var

   def configstylestr_2_ht_azl_heredoc(ht_opmem)
      s_line=ht_opmem['s_line']
      s_entag=ht_opmem['s_heredoc_endtag']
      if s_line.index(s_entag)==nil
         # It modifies the instance that resides in the hashtable.
         ht_opmem['s_varvalue']<<(s_line+$kibuvits_lc_linebreak)
         return
      end # if
      s_varvalue=ht_opmem['s_varvalue']
      # The next line gets rid of the very last linebreak in the s_varvalue.
      s_varvalue=Kibuvits_ix.sar(s_varvalue,0,(s_varvalue.length-1))
      ht_opmem['s_varvalue']=s_varvalue
      configstylestr_2_ht_collect_var ht_opmem
      ht_opmem['b_in_heredoc']=false
   end # configstylestr_2_ht_azl_heredoc

   # Answer of false means only, that the line is defenately not a
   # proper comment line.
   def configstylestr_2_ht_azl_nonheredoc_line_is_a_comment_line(s_line)
      b_out=true
      i_n_equals_signs=count_substrings(s_line,$kibuvits_lc_equalssign)
      return b_out if i_n_equals_signs==0
      i_n_commented_equals_signs=count_substrings(s_line,"\\=")
      return b_out if i_n_commented_equals_signs==i_n_equals_signs
      b_out=false
      return b_out
   end # configstylestr_2_ht_azl_nonheredoc_line_is_a_comment_line

   def configstylestr_2_ht_azl_nonheredoc(ht_opmem)
      s_line=ht_opmem['s_line']
      if KIBUVITS_b_DEBUG
         if s_line.index($kibuvits_lc_linebreak)!=nil
            kibuvits_throw "s_line contains a linebreak, s_line=="+s_line
         end # if
      end # if
      # The \= is used in comments and it can appear in the
      # value part of the non-heredoc assignment line.
      # The = can also appear in the
      # value part of the non-heredoc assignment line.
      if configstylestr_2_ht_azl_nonheredoc_line_is_a_comment_line(s_line)
         return
      end # if
      msgcs=ht_opmem['msgcs']
      # If we are here, then that means that the s_line has at least
      # one equals sign that is an assignment equals sign.
      #
      # Possible versions:
      # ^[=]
      # ^whatever_that_does_not_contain_an_assignmet_equals_sign [=] whatever_that_might_even_contain_assignment_equals_signs
      s_l=$kibuvits_lc_space+s_line # to match the ^[=] with ^[^\\][=]
      i_assignment_equals_sign_one_leftwards=s_l.index(/[^\\]=/)
      i_comments_equals_sign=s_l.index(/[\\]=/)
      if i_comments_equals_sign!=nil
         if i_comments_equals_sign<i_assignment_equals_sign_one_leftwards
            msgcs.cre "A nonheredoc line is not allowed "+
            "to have \"\\=\" to the left of the [^\\]= .\n"+
            "s_line==\""+s_line+"\".",10.to_s
            msgcs.last['Estonian']="Tsitaatsõne "+
            "koosseisu mitte kuuluval real ei või asuda sõne "+
            "\"\\=\" sõnest [^\\]= vasakul. \n"
            "s_line==\""+s_line+"\"."
            return
         end # if
      end # if
      # At this line all possible comments equals signs, if they exist,
      # reside to the right of the leftmost assignment equals sign.
      #
      #     |_|=|x|=|x
      #     0 1 2 3 4
      #
      #       |=|x|=|x
      #       0 1 2 3
      #
      s_left_with_equals_sign,s_right=Kibuvits_ix.bisect_at_sindex(s_line,
      (i_assignment_equals_sign_one_leftwards+1))
      s_left,s_right_with_equals_sign=Kibuvits_ix.bisect_at_sindex(s_line,
      i_assignment_equals_sign_one_leftwards)
      s_left=Kibuvits_str.trim(s_left)
      s_right=Kibuvits_str.trim(s_right)
      if s_left.length==0
         msgcs.cre "A nonheredoc line is not allowed "+
         "to have \"=\" as the first "+
         "character that differs from spaces and tabs. "+
         "s_line==\""+s_line+"\".",3.to_s
         msgcs.last['Estonian']="Tsitaatsõne "+
         "koosseisu mitte kuuluva rea esimene mitte-tühikust ning "+
         "mitte-tabulatsioonimärgist tähemärk ei või olla \"=\". "+
         "s_line==\""+s_line+"\"."
         return
      end # if
      if (s_left.gsub(/[\s\t]+/,$kibuvits_lc_emptystring).length)!=(s_left.length)
         msgcs.cre "Variable names are not allowed to contain "+
         "spaces and tabs."+
         "s_line==\""+s_line+"\".",4.to_s
         msgcs.last['Estonian']="Muutujate nimed "+
         "ei või sisaldada tühikuid ja tabulatsioonimärke. "+
         "s_line==\""+s_line+"\"."
         return
      end # if
      ht_out=ht_opmem["ht_out"]
      if ht_out.has_key? s_left
         msgcs.cre"Variable named \""+s_left+"\" has been "+
         "declared more than once. "+
         "s_line==\""+s_line+"\".",5.to_s
         msgcs.last['Estonian']="Muutujate nimega \""+s_left+
         "\" on deklareeritud rohkem kui üks kord. "+
         "s_line==\""+s_line+"\"."
         return
      end # if
      ht_opmem['s_varname']=s_left

      if s_right.length==0
         msgcs.cre "There is only an empty strings or "+
         "spaces and tabs after the \"=\" character "+
         "in a nonheredoc string. "+
         "s_line==\""+s_line+"\".",6.to_s
         msgcs.last['Estonian']="Tsitaatsõne "+
         "koosseisu mitte kuuluva rea \"=\" märgi järgi on kas "+
         "tühi sõne või ainult tühikud ning tabulatsioonimärgid. "+
         "s_line==\""+s_line+"\"."
         return
      end # if

      rgx_1=/HEREDOC/
      if s_right.index(rgx_1)==nil
         ht_opmem['s_varvalue']=s_right
         configstylestr_2_ht_collect_var ht_opmem
         return
      end # if
      # The s_right got trimmed earlier in this function.
      rgx_2=/.HEREDOC/
      if s_right.index(rgx_2)!=nil
         # s_right=="This sentence contains the word HEREDOC"
         msgcs.cre "Only spaces and tabs are allowed to be "+
         "present between the assignment equals sign and the HEREDOC "+
         "start tag.\n"+
         "s_line==\""+s_line+"\".",12.to_s
         msgcs.last['Estonian']="Omistusvõrdusmärgi ja Tsitaatsõne "+
         "algustunnuse vahel\n"+
         "tohib olla vaid tühikuid ning tabulatsioonimärke. \n"+
         "s_line==\""+s_line+"\"."
         return
      end # if
      # If there are 2 words that form a trimmed string, then
      # there is only a single gap, in this case, a single space character,
      # between them. "word1 word2", "word1 word2 word3".
      s_right_noralized=s_right.gsub(/([\s]|[\t])+/,$kibuvits_lc_space)

      # There are also faulty cases like
      #     x=HEREDOC42
      #         Spooky ghost
      #     HEREDOC_END
      #
      #     x=HEREDOC42 the_custom_end
      #         Spooky ghost
      #     the_custom_end
      #
      # but for the time being one just defines it so that the
      # x will have the value of HEREDOC42 and the rest of the
      # 2 lines will be comments.
      rgx_3=/HEREDOC[^\s]/
      if s_right_noralized.index(rgx_3)!=nil
         ht_opmem['b_in_heredoc']=false
         ht_opmem['s_varvalue']=s_right
         configstylestr_2_ht_collect_var ht_opmem
         return
      end # if

      i_n_of_spaces=count_substrings(s_right_noralized,$kibuvits_lc_space)
      if i_n_of_spaces==0
         ht_opmem['b_in_heredoc']=true
         ht_opmem['s_heredoc_endtag']=ht_opmem['s_hredoc_end_tag_default']
         return
      end # if
      if i_n_of_spaces==1
         i_space_ix=s_right_noralized.index($kibuvits_lc_space)
         s_irrelevant,s_heredoc_endtag=Kibuvits_ix.bisect_at_sindex(
         s_right_noralized,(i_space_ix+1)) # The +1 is for removing the space character.
         ht_opmem['b_in_heredoc']=true
         ht_opmem['s_heredoc_endtag']=s_heredoc_endtag
         return
      end # if
      # Here 1<i_n_of_spaces
      msgcs.cre "Heredoc end tag may not contain "+
      "spaces and tabs. "+
      "s_line==\""+s_line+"\".",8.to_s
      msgcs.last['Estonian']="Tsitaatsõne lõputunnus ei või "+
      "sisaldada tühikuid ning tabulatsioonimärke. "+
      "s_line==\""+s_line+"\"."
   end # configstylestr_2_ht_azl_nonheredoc

   def configstylestr_2_ht_create_ht_opmem(msgcs)
      ht_opmem=Hash.new
      ht_opmem['s_line']=""
      ht_opmem['b_in_heredoc']=false
      s_hredoc_end_tag_default="HEREDOC_END"
      ht_opmem['s_hredoc_end_tag_default']=s_hredoc_end_tag_default
      ht_opmem['s_hredoc_end_tag']=s_hredoc_end_tag_default
      ht_opmem['s_varname']=""
      ht_opmem['s_varvalue']=""
      ht_opmem['ht_out']=Hash.new
      ht_opmem['msgcs']=msgcs
      return ht_opmem
   end # configstylestr_2_ht_create_ht_opmem


   public
   # A word of warning is that unlike configurations utilities,
   # i.e. settings dialogs, configurations files do not check the
   # consistency of the configuration and do not assist the user.
   # For example, in the case of a configurations dialog, it's possible
   # to change the content of one menu based on the selection of the other.
   #
   # Configurations string format example:
   #
   #-the-start-of-the-configstylestr_2_ht-usage-example-DO-NOT-CHANGE-THIS-LINE
   # i_error_code=500
   # s_formal_explanation=HEREDOC
   #          Internal Error. The server encountered an unexpected condition
   #          which prevented it from fulfilling the request.
   # HEREDOC_END
   #
   # s_true_explanation=HEREDOC
   #
   #          The reason, why this software does not work the way
   #          You expected it to work, is that the developers obeyed their
   #          boss in stead of using their own heads.
   #
   #          Be prepared that in the future You'll get the same kind of
   #          quality from those developers, because they are willing to
   #          do a lousy job just to avoid getting dismissed. Probably
   #          they are going to keep on doing that till their retirement.
   #
   # HEREDOC_END
   #
   # Anything that is not part of heredoc and is not part of the
   # traditional assignment expression, is a comment. Equals signs
   # within comments must be escaped like \=
   #
   #     This\= 42 is a comment line.
   #     This0 = is an assignment line.
   #     This1 = is an assignment line that contains  = within its value.
   #     This2 = is an assignment line that contains \= within its value.
   #
   # demovar=HEREDOC Spooky
   #     The default heredoc end tag is the HEREDOC_END, but
   #     by declaring a custom, temporary, heredoc end tag it
   #     is possible to use the HEREDOC_END within the heredoc text.
   # Spooky
   #
   # demovar2=HEREDOC
   #     The heredoc format allows to use the keyword HEREDOC as
   #     part of the value. The reason, why the name of the variable
   #     here is demovar2 in stead of just demovar is that the
   #     variable demovar has been declared in the previous demo bloc
   #     and no variable is allowed to be declared more than once.
   # HEREDOC_END
   #
   # wow=HEREDOC42
   #     This line is not part of the heredoc, because
   #     HEREDOC42 is not a keyword. This line is just a comment.
   # HEREDOC_END
   #
   # wow2=HEREDOC
   #     HEREDOC is usually a keyword, but it is not a keyword,
   #     if it resides in the value part of the heredoc.
   # HEREDOC_END
   #
   # If the HEREDOC is not to the right of an unescaped equals sign,
   # then it is not interpreted as a key-word and is part of a comment.
   #
   # Actually this very same string string fragment is part of the
   # selftests. The configstylestr_2_ht selftest code extracts it
   # from the KRL ruby file, where the configstylestr_2_ht is defined.
   #
   #-the-end---of-the-configstylestr_2_ht-usage-example-DO-NOT-CHANGE-THIS-LINE
   #
   # The motive behind such a comment-sign-free configurations file
   # format is that usually parameter explanation comments have
   # more characters than parameter declarations themselves and
   # by making declarations "special" and comments "common", the "average"
   # amount of compulsory boiler-plate characters decreases.
   # Some of the credits go to the authors of the YAML specification,
   # because the YAML files are truly human friendly, if compared to
   # the JSON and the dinosaur of structured text formats, the XML.
   #
   def configstylestr_2_ht(s_a_config_file_style_string,
      msgcs=Kibuvits_msgc_stack.new)
      if KIBUVITS_b_DEBUG
         bn=binding()
         kibuvits_typecheck bn, String, s_a_config_file_style_string
         kibuvits_typecheck bn, Kibuvits_msgc_stack, msgcs
      end # if
      s_in=Kibuvits_str.normalise_linebreaks(s_a_config_file_style_string)
      ht_opmem=configstylestr_2_ht_create_ht_opmem msgcs
      s_in.each_line do |s_line_with_optional_linebreak_character|
         s_line=Kibuvits_str.clip_tail_by_str(
         s_line_with_optional_linebreak_character,$kibuvits_lc_linebreak)
         ht_opmem['s_line']=s_line
         if ht_opmem['b_in_heredoc']
            configstylestr_2_ht_azl_heredoc ht_opmem
         else
            configstylestr_2_ht_azl_nonheredoc ht_opmem
         end # if
         break if msgcs.b_failure
      end # loop
      ht_out=ht_opmem['ht_out']
      if msgcs.b_failure
         ht_out=Hash.new # == clear
         return ht_out
      end # if
      if ht_opmem['b_in_heredoc']
         s_varname=ht_opmem['s_varname'].to_s
         msgcs.cre "Heredoc for variable named \""+
         s_varname+"\" is incomplete.",9.to_s
         msgcs.last['Estonian']="Tsitaatsõne, mille muutuja "+
         "nimi on \""+s_varname+"\" on ilma tsitaatsõne lõpetustunnuseta."
      end # if
      return ht_out
   end # configstylestr_2_ht

   def Kibuvits_str.configstylestr_2_ht(s_a_config_file_style_string,
      msgcs=Kibuvits_msgc_stack.new)
      ht_out=Kibuvits_str.instance.configstylestr_2_ht(
      s_a_config_file_style_string,msgcs)
      return ht_out
   end # Kibuvits_str.configstylestr_2_ht

   #-----------------------------------------------------------------------
   public

   # The point behind this method is that if the array
   # has zero elements, the output is an empty string,
   # but there should not be any commas after the very last element.
   def array2xseparated_list(ar,s_separator=", ",
      s_left_brace="",s_right_brace="")
      if KIBUVITS_b_DEBUG
         bn=binding()
         kibuvits_typecheck bn, Array, ar
         kibuvits_typecheck bn, String, s_separator
         kibuvits_typecheck bn, String, s_left_brace
         kibuvits_typecheck bn, String, s_right_brace
      end # if
      s_out=""
      return s_out if ar.length==0
      b_at_least_one_element_is_already_in_the_list=false
      ar.each do |x|
         if b_at_least_one_element_is_already_in_the_list
            s_out=s_out+s_separator
         end # if
         s_out=s_out+s_left_brace+x.to_s+s_right_brace
         b_at_least_one_element_is_already_in_the_list=true
      end # end
      return s_out
   end # array2xseparated_list

   def Kibuvits_str.array2xseparated_list(ar,s_separator=", ",
      s_left_brace="",s_right_brace="")
      s_out=Kibuvits_str.instance.array2xseparated_list(
      ar,s_separator,s_left_brace,s_right_brace)
      return s_out
   end # Kibuvits_str.array2xseparated_list

   #-----------------------------------------------------------------------
   public

   # Returns a string. In many, but not all, cases it
   # doesn't stop the infinite recursion, if there's a
   # condition that a hashtable is an element of oneself
   # or an element of one of its elements.
   #
   # This method is useful for generating console output during debugging.
   def ht2str(ht, s_pair_prefix="",s_separator=$kibuvits_lc_linebreak)
      if KIBUVITS_b_DEBUG
         bn=binding()
         kibuvits_typecheck bn, Hash, ht
         kibuvits_typecheck bn, String, s_separator
      end # if
      s_out=""
      i_max_len=0
      i=nil
      ht.each_key do |a_key|
         i=a_key.to_s.length
         i_max_len=i if i_max_len<i
      end # loop
      s_x=""
      cl=nil
      b_first_line=true
      s_child_prefix=s_pair_prefix+"  "
      s_key=nil
      ht.each_pair do |a_key,a_value|
         s_out=s_out+s_separator if !b_first_line
         b_first_line=false
         cl=a_value.class.to_s
         s_key=a_key.to_s
         s_key=(" "*(i_max_len-s_key.length))+s_key
         case cl
         when "Array"
            s_x="["+Kibuvits_str.array2xseparated_list(a_value)+"]"
            s_out=s_out+s_pair_prefix+s_key+"="+s_x
         when "Hash"
            s_x=Kibuvits_str.ht2str(a_value,
            " "*(i_max_len+1)+s_child_prefix)
            s_out=s_out+s_key+"=Hash\n"+s_x
         when "NilClass"
            s_out=s_out+s_pair_prefix+s_key+"=nil"
         else
            s_x=a_value.to_s
            s_out=s_out+s_pair_prefix+s_key+"="+s_x
         end
      end # loop
      return s_out
   end # ht2str

   def Kibuvits_str.ht2str(ht, s_pair_prefix="",s_separator=$kibuvits_lc_linebreak)
      s=Kibuvits_str.instance.ht2str(ht,s_pair_prefix,s_separator)
      return s
   end # Kibuvits_str.ht2str

   #-----------------------------------------------------------------------
   public

   # The b_s_text_has_been_normalized_to_use_unix_line_breaks exists
   # only because the line-break normalization can be expensive, specially
   # if it is called very often, for example, during the processing of
   # a "big" set of "small" strings.
   def surround_lines(s_line_prefix,s_text,s_line_suffix,
      b_s_text_has_been_normalized_to_use_unix_line_breaks=false)
      if KIBUVITS_b_DEBUG
         bn=binding()
         kibuvits_typecheck bn, String, s_line_prefix
         kibuvits_typecheck bn, String, s_text
         kibuvits_typecheck bn, String, s_line_suffix
         kibuvits_typecheck bn, [TrueClass,FalseClass], b_s_text_has_been_normalized_to_use_unix_line_breaks
      end # if
      s_in=s_text
      if !b_s_text_has_been_normalized_to_use_unix_line_breaks
         s_in=Kibuvits_str.normalise_linebreaks(s_text, $kibuvits_lc_linebreak)
      end # if
      s_out=""
      s_cropped=nil
      b_nonfirst=false
      s_in.each_line do |s_line|
         s_out=s_out+$kibuvits_lc_linebreak if b_nonfirst
         b_nonfirst=true
         s_cropped=clip_tail_by_str(s_line, $kibuvits_lc_linebreak)
         s_out=s_out+s_line_prefix+s_cropped+s_line_suffix
      end # loop
      return s_out
   end # surround_lines

   def Kibuvits_str.surround_lines(s_line_prefix,s_text,s_line_suffix,
      b_s_text_has_been_normalized_to_use_unix_line_breaks=false)
      s_out=Kibuvits_str.instance.surround_lines(
      s_line_prefix,s_text,s_line_suffix,
      b_s_text_has_been_normalized_to_use_unix_line_breaks)
      return s_out
   end #Kibuvits_str.surround_lines

   #-----------------------------------------------------------------------
   public

   # The elements of the array "ar" do not have to
   # be strings, because prior to comparison their to_s
   # methods are called. If the output array
   # contains anyting at all, the output array will consists
   # of the references to the original array elements.
   #
   # If b_output_is_a_hashtable==false, the output is an array.
   # If b_output_is_a_hashtable==true, the output is a hashtable, where
   # the output is in the role of keys. The values are set to 42.
   def filter_array(condition_in_a_form_of_aregex_or_a_string, ar,
      b_condition_is_true_for_the_output_elements=true,
      b_output_is_a_hashtable=false)
      if KIBUVITS_b_DEBUG
         bn=binding()
         kibuvits_typecheck bn, [String,Regexp], condition_in_a_form_of_aregex_or_a_string
         kibuvits_typecheck bn, Array, ar
         kibuvits_typecheck bn, [TrueClass,FalseClass], b_condition_is_true_for_the_output_elements
         kibuvits_typecheck bn, [TrueClass,FalseClass], b_output_is_a_hashtable
      end # if
      md=nil
      rgx=condition_in_a_form_of_aregex_or_a_string
      if condition_in_a_form_of_aregex_or_a_string.class==String
         rgx=Regexp.compile(condition_in_a_form_of_aregex_or_a_string)
      end # if
      x_out=nil
      if b_output_is_a_hashtable # The branches are to keep if out of the loop.
         ht_out=Hash.new
         i_42=42 # One Fixnum instance per whole ht_out.
         if b_condition_is_true_for_the_output_elements
            ar.each do |x|
               ht_out[x]=i_42 if rgx.match(x.to_s)!=nil
            end # loop
         else
            ar.each do |x|
               ht_out[x]=i_42 if rgx.match(x.to_s)==nil
            end # loop
         end # if
         x_out=ht_out
      else
         ar_out=Array.new
         i_arlen=ar.length # To guarantee the order, wich is useful for testing.
         if b_condition_is_true_for_the_output_elements
            i_arlen.times do |i|
               x=ar[i]
               if rgx.match(x.to_s)!=nil
                  ar_out<<x
               end # if
            end # loop
         else
            i_arlen.times do |i|
               x=ar[i]
               if rgx.match(x.to_s)==nil
                  ar_out<<x
               end # if
            end # loop
         end # if
         x_out=ar_out
      end # if b_output_is_a_hashtable
      return x_out
   end # filter_array

   def Kibuvits_str.filter_array(condition_in_a_form_of_aregex_or_a_string, ar,
      b_condition_is_true_for_the_output_elements=true,
      b_output_is_a_hashtable=false)
      ar_out=Kibuvits_str.instance.filter_array(
      condition_in_a_form_of_aregex_or_a_string,
      ar, b_condition_is_true_for_the_output_elements,
      b_output_is_a_hashtable)
      return ar_out
   end # Kibuvits_str.filter_array

   #-----------------------------------------------------------------------
   private

   def verify_s_is_within_domain_check(s_to_test,ar_domain)
      b_verification_failed=true
      ar_domain.each do |s|
         kibuvits_throw "s.class=="+s.class.to_s if s.class!=String
         if s==s_to_test
            b_verification_failed=false
            break
         end # if
      end # loop
      return b_verification_failed
   end # verify_s_is_within_domain_check

   public

   # The s_actio_on_verification_failure has the following domain:
   # {"note_in_msgcs","throw","print_and_exit","exit"}
   def verify_s_is_within_domain(s_to_test,s_or_ar_of_domain_elements,
      msgcs,s_action_on_verification_failure="note_in_msgcs",
      s_language_to_use_for_printing="English")
      if KIBUVITS_b_DEBUG
         bn=binding()
         kibuvits_typecheck bn, String, s_to_test
         kibuvits_typecheck bn, [Array,String], s_or_ar_of_domain_elements
         kibuvits_typecheck bn, Kibuvits_msgc_stack, msgcs
         kibuvits_typecheck bn, String, s_action_on_verification_failure
         kibuvits_typecheck bn, String, s_language_to_use_for_printing
      end # if
      s_cache_key='verify_s_is_within_domain_actions'
      ht_action_domain=nil
      if !@@cache.has_key? s_cache_key
         ht_action_domain=Hash.new
         i=42
         ht_action_domain["note_in_msgcs"]=i
         ht_action_domain["throw"]=i
         ht_action_domain["print_and_exit"]=i
         ht_action_domain["exit"]=i
         @@cache[s_cache_key]=ht_action_domain
      else
         ht_action_domain=@@cache[s_cache_key]
      end # if
      if !ht_action_domain.has_key? s_action_on_verification_failure
         s="s_action_on_verification_failure==\""+
         s_action_on_verification_failure+"\", but supported values are: "
         ar=Array.new
         ht_action_domain.each_key{|x| ar<<x}
         s=s+array2xseparated_list(ar)
         kibuvits_throw s
      end # if
      ar_domain=Kibuvits_ix.normalize2array(s_or_ar_of_domain_elements)
      b_verification_failed=verify_s_is_within_domain_check(s_to_test,ar_domain)
      return if !b_verification_failed
      s_domain=array2xseparated_list(ar_domain)
      s_msg_en="s_to_test==\""+s_to_test+"\", but it is expected to be \n"+
      "one of the following: "+s_domain+" ."
      s_msg_ee="s_to_test==\""+s_to_test+"\", kuid ta peaks omama \n"+
      "ühte järgnevaist väärtustest: "+s_domain+" ."
      msgcs.cre(s_msg_en,1.to_s)
      msgcs.last["Estonian"]=s_msg_ee
      case s_action_on_verification_failure
      when "throw"
         kibuvits_throw msgcs.to_s(s_language_to_use_for_printing)
      when "note_in_msgcs"
         # One does nothing.
      when "print_and_exit"
         puts msgcs.to_s(s_language_to_use_for_printing)
         exit
      when "exit"
         exit
      else
         kibuvits_throw "s_action_on_verification_failure=="+s_action_on_verification_failure.to_s
      end # case
   end # verify_s_is_within_domain

   def Kibuvits_str.verify_s_is_within_domain(s_to_test,s_or_ar_of_domain_elements,
      msgcs,s_action_on_verification_failure="note_in_msgcs",
      s_language_to_use_for_printing="English")
      Kibuvits_str.instance.verify_s_is_within_domain(
      s_to_test,s_or_ar_of_domain_elements, msgcs,
      s_action_on_verification_failure,s_language_to_use_for_printing)
   end # Kibuvits_str.verify_s_is_within_domain

   #-----------------------------------------------------------------------
   public

   def str2strliteral(s_in,s_quotation_mark=$kibuvits_lc_doublequote,
      b_escape_quotation_marks=true, b_escape_backslashes=true,
      s_concatenation_mark="+")
      if KIBUVITS_b_DEBUG
         bn=binding()
         kibuvits_typecheck bn, String, s_in
         kibuvits_typecheck bn, String, s_quotation_mark
         kibuvits_typecheck bn, [FalseClass,TrueClass], b_escape_quotation_marks
         kibuvits_typecheck bn, [FalseClass,TrueClass], b_escape_backslashes
         kibuvits_typecheck bn, String, s_concatenation_mark
      end # if
      s=s_in
      s=s.gsub("\\","\\\\\\\\") if b_escape_backslashes
      s=s.gsub(s_quotation_mark,"\\"+s_quotation_mark) if b_escape_quotation_marks
      s_out=""
      b_nonfirst=false
      s_tmp=nil
      s_separator=s_concatenation_mark+$kibuvits_lc_linebreak
      s.each_line do |s_line|
         s_out=s_out+s_separator if b_nonfirst
         s_tmp=Kibuvits_str.clip_tail_by_str(s_line,$kibuvits_lc_linebreak)
         s_tmp=s_quotation_mark+s_tmp+s_quotation_mark
         s_out=s_out+s_tmp
         b_nonfirst=true
      end # loop
      return s_out
   end # str2strliteral

   def Kibuvits_str.str2strliteral(s_in,s_quotation_mark=$kibuvits_lc_doublequote,
      b_escape_quotation_marks=true, b_escape_backslashes=true,
      s_concatenation_mark="+")
      s_out=Kibuvits_str.instance.str2strliteral(s_in,s_quotation_mark,
      b_escape_quotation_marks,b_escape_backslashes,s_concatenation_mark)
      return s_out
   end # Kibuvits_str.str2strliteral

   #-----------------------------------------------------------------------
   public

   # Returns true, if the s_candidate contains at least one linebreak,
   # space or tabulation character.
   def str_contains_spacestabslinebreaks(s_candidate)
      if KIBUVITS_b_DEBUG
         bn=binding()
         kibuvits_typecheck bn, String, s_candidate
      end # if
      s=normalise_linebreaks(s_candidate)
      i_len1=s.length
      s=s.gsub(/[\s\t\n]/,"")
      i_len2=s.length
      b_out=(i_len1!=i_len2)
      return b_out;
   end # str_contains_spacestabslinebreaks

   def Kibuvits_str.str_contains_spacestabslinebreaks(s_candidate)
      b_out=Kibuvits_str.instance.str_contains_spacestabslinebreaks(
      s_candidate)
      return b_out
   end # Kibuvits_str.str_contains_spacestabslinebreaks

   #-----------------------------------------------------------------------
   public

   def datestring_for_fs_prefix(dt)
      if KIBUVITS_b_DEBUG
         bn=binding()
         kibuvits_typecheck bn, Time, dt
      end # if
      s_out=$kibuvits_lc_emptystring
      i=dt.month
      s=i.to_s
      s="0"+s if i<10
      s_out=(dt.year.to_s+$kibuvits_lc_underscore)+(s+$kibuvits_lc_underscore)
      i=dt.day
      s=i.to_s
      s="0"+s if i<10
      s_out=s_out+s
      return s_out
   end # datestring_for_fs_prefix

   def Kibuvits_str.datestring_for_fs_prefix(dt)
      s_out=Kibuvits_str.instance.datestring_for_fs_prefix(dt)
      return s_out
   end # Kibuvits_str.datestring_for_fs_prefix(dt)

   #-----------------------------------------------------------------------
   public

   # It converts a unicode codepoint to a single character string.
   #
   # It's partly derived from a Unicode utility written by David Flangan:
   # http://www.davidflanagan.com/2007/08/index.html#000136
   def s_i2unicode(i_codepoint)
      if KIBUVITS_b_DEBUG
         bn=binding()
         kibuvits_typecheck bn, Fixnum, i_codepoint
      end # if
      if (i_codepoint<0)||(@i_unicode_maximum_codepoint<i_codepoint)
         raise("i_codepoint=="+i_codepoint.to_s+
         ", but the valid range is 0 to "+@i_unicode_maximum_codepoint.to_s)
      end # end
      s_out=[i_codepoint].pack("U")
      return s_out
   end # s_i2unicode

   def Kibuvits_str.s_i2unicode(i_codepoint)
      s_out=Kibuvits_str.instance.s_i2unicode(i_codepoint)
      return s_out
   end # Kibuvits_str.s_i2unicode

   #-----------------------------------------------------------------------

   include Singleton
   # The Kibuvits_str.selftest analogue is
   # in a separate selftest file.

end # class Kibuvits_str

#==========================================================================
# Samples:
# POOLELI uue msgc spec'i peale on vaja yle minna
# puts Kibuvits_str.selftest.to_s
