#!/usr/bin/ruby1.9 -Ku
#==========================================================================
=begin

 Copyright 2012, martin.vahi@softf1.com that has an
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
BREAKDANCEMAKE_UPDATE_DEPLOYMENT_INCLUDED=true

KIBUVITS_RUBY_LIBRARY_IS_AVAILABLE=false
KIBUVITS_b_DEBUG=false

#--------------------------------------------------------------------------
require "rubygems"
require 'pathname'
if !defined? BREAKDANCEMAKE_HOME
   BREAKDANCEMAKE_HOME=Pathname.new($0).realpath.parent.parent.parent.to_s
end # if
require BREAKDANCEMAKE_HOME+"/src/bonnet/lib/breakdancemake_inclusions.rb"

#--------------------------------------------------------------------------

class Breakbeatdance_update_deployment
   def initialize
   end # initialize

   private

   def exit_if_operating_system_type_not_supported(s_language)
      s_ostype=Kibuvits_os_codelets.get_os_type
      return if s_ostype=="kibuvits_ostype_unixlike"
      s_msg=nil
      case s_language
      when $kibuvits_lc_et
         s_msg="\n"+
         "RUBY_PLATFORM==\""+RUBY_PLATFORM.to_s+
         "\",\nkuid breakdancemake on kasutuskõlbulik vaid UNIX-ilaadsetel süsteemidel ning \n"+
         "sõltub bash'ist.\n\n"
      else # probably s_language=="uk"
         s_msg="\n"+
         "RUBY_PLATFORM==\""+RUBY_PLATFORM.to_s+
         "\",\nbut the breakdancemake is usable only on UNIX-like systems and \n"+
         "depends on the bash shell.\n\n"
      end # case s_language
      puts s_msg
      exit
   end # exit_if_operating_system_type_not_supported

   public
   def update_src_breakdancemake(s_language)
      fp=BREAKDANCEMAKE_HOME+"/src/breakdancemake"
      s_in=file2str(fp)
      ar_s_out=Array.new
      b_first_line=true
      s_in.each_line do |s_line|
         if b_first_line
            s_0=(`which ruby`).to_s.gsub(/[\n\r]/,$kibuvits_lc_emptystring)
            s="#!"+s_0+" -Ku \n"
            ar_s_out<<s
            b_first_line=false
         else
            ar_s_out<<s_line
         end # if
      end # loop
      s_out=kibuvits_s_concat_array_of_strings(ar_s_out)
      str2file(s_out,fp)
   end # update_src_breakdancemake

   def run
      s_language=$kibuvits_s_language
      exit_if_operating_system_type_not_supported(s_language)
      update_src_breakdancemake(s_language)
      Breakdancemake.update_deployment(s_language)
   end # run

end # class Breakbeatdance_update_deployment
#--------------------------------------------------------------------------
Breakbeatdance_update_deployment.new.run

#==========================================================================

