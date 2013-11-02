#!/usr/bin/env ruby
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
   require 'pathname'
   ob_pth_0=Pathname.new(__FILE__).realpath
   ob_pth_1=ob_pth_0.parent.parent.parent
   s_KIBUVITS_HOME_b_fs=ob_pth_1.to_s
   require(s_KIBUVITS_HOME_b_fs+"/src/include/kibuvits_boot.rb")
   ob_pth_0=nil; ob_pth_1=nil; s_KIBUVITS_HOME_b_fs=nil
end # if

require  KIBUVITS_HOME+"/src/include/kibuvits_fs.rb"

#==========================================================================

# The class Kibuvits_file_intelligence is for various
# meta-data like cases, like infering file format by
# its extension, etc.
class Kibuvits_file_intelligence

   def initialize
   end # initialize

   # Returns a string.
   def file_language_by_file_extension s_file_path, msgcs
      if KIBUVITS_b_DEBUG
         bn=binding()
         kibuvits_typecheck bn, String, s_file_path
         kibuvits_typecheck bn, Kibuvits_msgc_stack, msgcs
      end # if
      ar_tokens=Kibuvits_str.ar_bisect(s_file_path.reverse, '.')
      s_file_extension=ar_tokens[0].reverse.downcase
      s_file_language="undetermined"
      case s_file_extension
      when "js"
         s_file_language="JavaScript"
      when "rb"
         s_file_language="Ruby"
      when "php"
         s_file_language="PHP"
      when "h"
         s_file_language="C"
      when "hpp"
         s_file_language="C++"
      when "c"
         s_file_language="C"
      when "cpp"
         s_file_language="C++"
      when "hs"
         s_file_language="Haskell"
      when "java"
         s_file_language="Java"
      when "scala"
         s_file_language="Scala"
      when "html"
         s_file_language="HTML"
      when "xml"
         s_file_language="XML"
      when "bash"
         s_file_language="Bash"
      else
         msgcs.cre "Either the file extension is not supported or "+
         "the file extension extraction failed.\n"+
         "File extension candidate is: "+s_file_extension, 1.to_s
         msgcs.last["Estonian"]="Faililaiend on kas toetamata või ei õnnestunud "+
         "faililaiendit eraldada. \n"+
         "Faililaiendi kandidaat on:"+s_file_extension
      end # case
      return s_file_language
   end # file_language_by_file_extension

   def Kibuvits_file_intelligence.file_language_by_file_extension(
      s_file_path, msgcs)
      s_file_language=Kibuvits_file_intelligence.instance.file_language_by_file_extension(
      s_file_path, msgcs)
      return s_file_language
   end # Kibuvits_file_intelligence.file_language_by_file_extension

   include Singleton

end # class Kibuvits_file_intelligence

#==========================================================================
