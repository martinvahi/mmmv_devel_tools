#!/opt/ruby/bin/ruby -Ku
#==========================================================================
=begin

 Copyright 2009, martin.vahi@softf1.com that has an
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

------------------------------------------------------------------------
This file adds ProgFTE support to Ruby. The reason, why it
contains the testing related extra code is that this way
this file is almost self-contained.

As of 05.2010 one can say
that the code here is too verbose, and bloated, but,
as I said earlier, the mess here is almost self-contained and
one doesn't want to fix, what's isn't broken. :-> The public
API here is as simple as it can get.

=end
#==========================================================================
if !defined? KIBUVITS_HOME
   x=ENV['KIBUVITS_HOME']
   KIBUVITS_HOME=x if (x!=nil and x!="")
end # if

require "rubygems"
require "monitor"
if defined? KIBUVITS_HOME
   # As the Kibuvits_ProgFTE is used for serialization, the
   # Kibuvits_ProgFTE  may not depend on anything else than
   # the booting code.
   require  KIBUVITS_HOME+"/include/kibuvits_boot.rb"
else
   # To allow the Kibuvits Ruby Library (KRL) ProgFTE implentation
   # to be used without using any part of the rest of the KRL, 
   # this file should not include any of the KRL files, if it is
   # used outside of the KRL.
   require("kibuvits_boot.rb") if false 
end # if
KIBUVITS_RUBY_LIBRARY_IS_AVAILABLE=false if !defined? KIBUVITS_RUBY_LIBRARY_IS_AVAILABLE
require "singleton"
#==========================================================================
# The ProgFTE is a text format for serializing hashtables that
# contain only strings and use only strings for keys. The
# ProgFTE stands for Programmer Friendly Text Exchange.
#
# The class Kibuvits_ProgFTE is used for both,
# serializing, and deserializing the hashtables.
# If linebreaks are used within the values, the ProgFTE
# file format can be used for creating a config file that is readable
# from any programming language that has a ProgFTE library.
class Kibuvits_ProgFTE

   def initialize
      @b_kibuvits_bootfile_run=(defined? KIBUVITS_s_VERSION)
   end #initialize


   def Kibuvits_ProgFTE.selftest_failure(a,b)
      exc=Exception.new(a.to_s+b.to_s)
      # One can't use the instance variable, @b_kibuvits_bootfile_run
      # here, because it is a static method.
      b_kibuvits_bootfile_run=(defined? KIBUVITS_s_VERSION)
      if b_kibuvits_bootfile_run then kibuvits_throw(exc) else raise(exc) end
   end # Kibuvits_ProgFTE.selftest_failure

   def Kibuvits_ProgFTE.throw_if_not_in_KRL
      if !@b_kibuvits_bootfile_run
         raise(Exception.new("The method that calls the "+
         "Kibuvits_ProgFTE.throw_if_not_in_KRL() is meant to be run only, "+
         "if the Kibuvits Ruby Library boot code has been run."))
      end # if
   end # Kibuvits_ProgFTE.throw_if_not_in_KRL

   private

   # It's copy-pasted from the Kibuvits_str. The testing
   # code of it resides also there. The
   # dumb duplication is to eliminate the dependency.
   #
   # It returns an array of 2 elements. If the separator is not
   # found, the array[0]==input_string and array[1]=="".
   #
   # The ar_output is for array instance reuse and is expected
   # to increase speed a tiny bit at "snatching".
   def bisect(input_string, separator_string,ar_output=Array.new(2,""))
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

   # Returns an array of strings that contains only the snatched string pieces.
   def snatch_n_times(haystack_string, separator_string,n)
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

   public
   def ht_to_s(a_hashtable)
      if @b_kibuvits_bootfile_run
         kibuvits_typecheck binding(), Hash, a_hashtable
      end # if
      s=""
      a_hashtable.keys.each do |a_key|
         s=s+a_key.to_s
         s=s+(a_hashtable[a_key].to_s) # Ruby 1.9. bug workaround
      end # loop
      return s;
   end # ht_to_s

   def Kibuvits_ProgFTE.ht_to_s(a_hashtable)
      s=Kibuvits_ProgFTE.instance.ht_to_s(a_hashtable)
      return s;
   end # Kibuvits_ProgFTE.ht_to_s

   private
   def Kibuvits_ProgFTE.test_ht_to_s
      Kibuvits_ProgFTE.throw_if_not_in_KRL
      tf='Kibuvits_ProgFTE.test_ht_to_s'
      if not kibuvits_block_throws{ Kibuvits_ProgFTE.ht_to_s('XXX')}
         Kibuvits_ProgFTE.selftest_failure(tf,1)
      end # if
      ht=Hash.new
      ht['abc']='def'
      ht['ghi']='jklm'
      ht['nop']='rst'
      s=Kibuvits_ProgFTE.ht_to_s(ht)
      # The keys of the hashtable are not ordered alphabetically.
      # That explains, why there's no check here, but only execution test.

      ht=Hash.new
      ht['abc']='def'
      s=Kibuvits_ProgFTE.ht_to_s(ht)
      Kibuvits_ProgFTE.selftest_failure(tf,2) if s!="abcdef"
   end # Kibuvits_ProgFTE.test_ht_to_s

   def create_nonexisting_needle(haystack_string)
      if @b_kibuvits_bootfile_run
         kibuvits_typecheck binding(), String, haystack_string
      end # if
      n=0
      s_needle='^0'
      while haystack_string.include? s_needle do
         n=n+1;
         s_needle='^'+n.to_s
      end # loop
      return s_needle
   end # create_nonexisting_needle

   def Kibuvits_ProgFTE.create_nonexisting_needle(haystack_string)
      s_needle=Kibuvits_ProgFTE.instance.create_nonexisting_needle(
      haystack_string)
      return s_needle
   end # Kibuvits_ProgFTE.create_nonexisting_needle

   def Kibuvits_ProgFTE.test_create_nonexisting_needle
      Kibuvits_ProgFTE.throw_if_not_in_KRL
      tf='Kibuvits_ProgFTE.test_create_nonexisting_needle'
      if not kibuvits_block_throws{ Kibuvits_ProgFTE.create_nonexisting_needle(4)}
         Kibuvits_ProgFTE.selftest_failure(tf,1)
      end # if
      s=Kibuvits_ProgFTE.create_nonexisting_needle('abcdefg')
      Kibuvits_ProgFTE.selftest_failure(tf,2) if s!='^0'
      s=Kibuvits_ProgFTE.create_nonexisting_needle('ab^0cdefg')
      Kibuvits_ProgFTE.selftest_failure(tf,3) if s!='^1'
      s=Kibuvits_ProgFTE.create_nonexisting_needle('')
      Kibuvits_ProgFTE.selftest_failure(tf,4) if s!='^0'
   end # Kibuvits_ProgFTE.test_create_nonexisting_needle


   public
   def from_ht(a_hashtable)
      if @b_kibuvits_bootfile_run
         kibuvits_typecheck binding(), Hash, a_hashtable
      end # if
      ht=a_hashtable
      s_subst=create_nonexisting_needle(self.ht_to_s(ht))
      s_progfte=''+ht.size.to_s+'|||'+s_subst+'|||'
      s_key=''; s_value=''; # for a possible, slight, speed improvement
      ht.keys.each do |key|
         a_key=key.to_s # Ruby 1.9 bug workaround
         if @b_kibuvits_bootfile_run
            kibuvits_typecheck binding(), String, a_key
         end # if
         s_key=a_key.gsub('|',s_subst)
         s_value=(ht[a_key]).to_s
         if @b_kibuvits_bootfile_run
            kibuvits_typecheck binding(), String, s_value
         end # if
         s_value=s_value.gsub('|',s_subst)
         s_progfte=s_progfte+s_key+'|||'+s_value+'|||'
      end # loop
      return s_progfte
   end # from_ht

   def Kibuvits_ProgFTE.from_ht(a_hashtable)
      s_progfte=Kibuvits_ProgFTE.instance.from_ht(a_hashtable)
      return s_progfte
   end # Kibuvits_ProgFTE.from_ht

   private
   def Kibuvits_ProgFTE.test_from_ht
      Kibuvits_ProgFTE.throw_if_not_in_KRL
      tf='Kibuvits_ProgFTE.test_from_ht'
      if not kibuvits_block_throws{ Kibuvits_ProgFTE.from_ht(4)}
         Kibuvits_ProgFTE.selftest_failure(tf,1)
      end # if
      if not kibuvits_block_throws{ Kibuvits_ProgFTE.from_ht('xx')}
         Kibuvits_ProgFTE.selftest_failure(tf,2)
      end # if
      ht=Hash.new
      s=Kibuvits_ProgFTE.from_ht(ht)
      Kibuvits_ProgFTE.selftest_failure(tf,3) if s!='0|||^0|||'

      ht['ab']='cd|'
      s_progfte='1|||^0|||ab|||cd^0|||'
      s=Kibuvits_ProgFTE.from_ht(ht)
      Kibuvits_ProgFTE.selftest_failure(tf,4) if s!=s_progfte

      ht=Hash.new
      ht['|ef']='gh'
      s_progfte='1|||^0|||^0ef|||gh|||'
      s=Kibuvits_ProgFTE.from_ht(ht)
      Kibuvits_ProgFTE.selftest_failure(tf,5) if s!=s_progfte

      ht=Hash.new
      ht['^0x']='gh'
      s_progfte='1|||^1|||^0x|||gh|||'
      s=Kibuvits_ProgFTE.from_ht(ht)
      Kibuvits_ProgFTE.selftest_failure(tf,6) if s!=s_progfte
   end # Kibuvits_ProgFTE.test_from_ht


   public
   def to_ht(a_string)
      if @b_kibuvits_bootfile_run
         kibuvits_typecheck binding(), String, a_string
      end # if
      ar=bisect(a_string,'|||')
      tf='Kibuvits_ProgFTE.to_ht'
      Kibuvits_ProgFTE.selftest_failure(tf,1) if ar[1]==""
      n=Integer(ar[0])
      s_subst=''
      err_no=2
      ht=Hash.new
      begin
         ar1=bisect(ar[1],'|||')
         s_subst=ar1[0]
         err_no=3
         Kibuvits_ProgFTE.selftest_failure(tf,err_no) if s_subst==''
         err_no=4
         # ar1[1]=='', if n==0 and it's legal in here
         ar=snatch_n_times(ar1[1],'|||',n*2) if 0<n
         err_no=5
         n.times do |x|
            key=ar[x*2].gsub(s_subst,'|')
            value=(ar[x*2+1]).gsub(s_subst,'|')
            ht[key]=value
         end # loop
      rescue Exception => e
         Kibuvits_ProgFTE.selftest_failure(tf.to_s+e.to_s,err_no)
      end # try-catch
      return ht
   end # to_ht

   def Kibuvits_ProgFTE.to_ht(a_string)
      ht=Kibuvits_ProgFTE.instance.to_ht(a_string)
      return ht
   end # Kibuvits_ProgFTE.to_ht

   private
   def Kibuvits_ProgFTE.test_to_ht
      Kibuvits_ProgFTE.throw_if_not_in_KRL
      tf='Kibuvits_ProgFTE.test_to_ht'
      if not kibuvits_block_throws{ Kibuvits_ProgFTE.to_ht(4)}
         Kibuvits_ProgFTE.selftest_failure(tf,1)
      end # if
      ht=Hash.new
      if not kibuvits_block_throws{ Kibuvits_ProgFTE.to_ht(ht)}
         Kibuvits_ProgFTE.selftest_failure(tf,2)
      end # if
      s_progfte='3|||^1|||ab|||cd^1|||^0x|||gh|||^1ef|||gh|||'
      ht=Kibuvits_ProgFTE.to_ht(s_progfte)
      Kibuvits_ProgFTE.selftest_failure(tf,3) if ht['^0x']!='gh'
      Kibuvits_ProgFTE.selftest_failure(tf,4) if ht['ab']!='cd|'
      Kibuvits_ProgFTE.selftest_failure(tf,5) if ht['|ef']!='gh'
      Kibuvits_ProgFTE.selftest_failure(tf,6) if ht.size!=3
      s_progfte='0|||^0|||'
      ht=Kibuvits_ProgFTE.to_ht(s_progfte)
      Kibuvits_ProgFTE.selftest_failure(tf,7) if ht.size!=0
   end # Kibuvits_ProgFTE.test_to_ht

   def Kibuvits_ProgFTE.test_s_to_ht_to_s
      Kibuvits_ProgFTE.throw_if_not_in_KRL
      ht0=Hash.new
      ht0['|||']='xxx'
      ht0['|||x']='|||'
      ht0['x']='|g'
      s_ht0=Kibuvits_ProgFTE.from_ht(ht0)
      ht1=Hash.new
      ht1['ab']='cd|'
      ht1['|ef']='gh'
      ht1['ht0']=s_ht0
      ht1['z']='y'
      s_ht1=Kibuvits_ProgFTE.from_ht(ht1)
      ht0.clear
      ht1.clear
      ht2=Kibuvits_ProgFTE.to_ht(s_ht1)
      ht3=Kibuvits_ProgFTE.to_ht(ht2['ht0'])
      tf='Kibuvits_ProgFTE.test_s_to_ht_to_s'
      Kibuvits_ProgFTE.selftest_failure(tf,1) if ht3.size!=3
      Kibuvits_ProgFTE.selftest_failure(tf,2) if ht2.size!=4
      Kibuvits_ProgFTE.selftest_failure(tf,3) if ht3['|||']!='xxx'
      Kibuvits_ProgFTE.selftest_failure(tf,4) if ht3['|||x']!='|||'
      Kibuvits_ProgFTE.selftest_failure(tf,5) if ht3['x']!='|g'
      Kibuvits_ProgFTE.selftest_failure(tf,6) if ht2['ab']!='cd|'
      Kibuvits_ProgFTE.selftest_failure(tf,7) if ht2['|ef']!='gh'
      Kibuvits_ProgFTE.selftest_failure(tf,8) if ht2['z']!='y'

      # The test version with a space within a key seems to catch
      # some weird flaws that would otherwise be unnoticed.
      ht=Hash.new
      ht['Welcome']='to hell'
      ht['with XML']='we all go'
      s_progfte=Kibuvits_ProgFTE.from_ht(ht)
      ht.clear
      ht2=Kibuvits_ProgFTE.to_ht(s_progfte)
      Kibuvits_ProgFTE.selftest_failure(tf,9) if ht2['with XML']!='we all go'
   end # Kibuvits_ProgFTE.test_s_to_ht_to_s

   public
   include Singleton
   def Kibuvits_ProgFTE.selftest
      Kibuvits_ProgFTE.throw_if_not_in_KRL
      ar_msgs=Array.new
      kibuvits_testeval binding(), "Kibuvits_ProgFTE.test_ht_to_s"
      kibuvits_testeval binding(), "Kibuvits_ProgFTE.test_create_nonexisting_needle"
      kibuvits_testeval binding(), "Kibuvits_ProgFTE.test_from_ht"
      kibuvits_testeval binding(), "Kibuvits_ProgFTE.test_to_ht"
      kibuvits_testeval binding(), "Kibuvits_ProgFTE.test_s_to_ht_to_s"
      return ar_msgs
   end # Kibuvits_ProgFTE.selftest

end #class Kibuvits_ProgFTE

#==========================================================================
# Sample code:
# ht=Hash.new
# ht['Welcome']='to hell'
# ht['with XML']='we all go'
# s_progfte=Kibuvits_ProgFTE.from_ht(ht)
# ht.clear
# ht2=Kibuvits_ProgFTE.to_ht(s_progfte)
# puts ht2['Welcome']
# puts ht2['with XML']

