#!/usr/bin/env ruby
#==========================================================================
=begin
 Copyright 2013, martin.vahi@softf1.com that has an
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
#==========================================================================

if !defined? KIBUVITS_HOME
   require 'pathname'
   ob_pth_0=Pathname.new(__FILE__).realpath
   ob_pth_1=ob_pth_0.parent.parent.parent.parent
   s_KIBUVITS_HOME_b_fs=ob_pth_1.to_s
   require(s_KIBUVITS_HOME_b_fs+"/src/include/kibuvits_boot.rb")
   ob_pth_0=nil; ob_pth_1=nil; s_KIBUVITS_HOME_b_fs=nil
end # if

require  KIBUVITS_HOME+"/src/include/kibuvits_file_intelligence.rb"

#==========================================================================

class Kibuvits_file_intelligence_selftests

   def initialize
   end #initialize

   private

   #-----------------------------------------------------------------------

   def Kibuvits_file_intelligence_selftests.test_file_language_by_file_extension
      msgcs=Kibuvits_msgc_stack.new
      if kibuvits_block_throws{Kibuvits_file_intelligence.file_language_by_file_extension("./x.rb",msgcs)}
         kibuvits_throw "test 1"
      end # if
      if KIBUVITS_b_DEBUG
         if !kibuvits_block_throws{Kibuvits_file_intelligence.file_language_by_file_extension(42,msgcs)}
            kibuvits_throw "test 2"
         end # if
         if !kibuvits_block_throws{Kibuvits_file_intelligence.file_language_by_file_extension("./x.rb",42)}
            kibuvits_throw "test 3"
         end # if
      end # if
      msgcs.clear
      s=Kibuvits_file_intelligence.file_language_by_file_extension(
      "./x.rb",msgcs)
      kibuvits_throw "test 4" if msgcs.b_failure
      kibuvits_throw "test 5" if s.downcase!="ruby".downcase
   end # Kibuvits_file_intelligence_selftests.test_file_language_by_file_extension

   #-----------------------------------------------------------------------

   public
   def Kibuvits_file_intelligence_selftests.selftest
      ar_msgs=Array.new
      bn=binding()
      kibuvits_testeval bn, "Kibuvits_file_intelligence_selftests.test_file_language_by_file_extension"
      return ar_msgs
   end # Kibuvits_file_intelligence_selftests.selftest

end # class Kibuvits_file_intelligence_selftests

#==========================================================================

