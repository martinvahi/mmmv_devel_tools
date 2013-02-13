#!/opt/ruby/bin/ruby -Ku
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

x=ENV["MMMV_DEVEL_TOOLS_HOME"]
if (x==nil)||(x=="")
   puts "Mandatory environment variable, MMMV_DEVEL_TOOLS_HOME, "+
   "has not been set. "
   exit
end # if
MMMV_DEVEL_TOOLS_HOME=x

require MMMV_DEVEL_TOOLS_HOME+"/src/bonnet/mmmv_devel_tools_initialization_t1.rb"

require KIBUVITS_HOME+"/include/kibuvits_io.rb"
require KIBUVITS_HOME+"/include/kibuvits_shell.rb"
require KIBUVITS_HOME+"/include/kibuvits_argv_parser.rb"
require KIBUVITS_HOME+"/include/kibuvits_fs.rb"

require "singleton"
#==========================================================================

class JumpGUID_core

attr_reader :s_fp_err

   def initialize s_path_to_the_textfile_that_contains_the_stderr_content
      @b_err_file_path_set=false
   end # initialize

   # The text file does not have to exist during initialization.
   def set_err_file_path
      if KIBUVITS_b_DEBUG
         bn=binding()
         kibuvits_assert_string_min_length(bn,
         s_path_to_the_textfile_that_contains_the_stderr_content,2)
         #kibuvits_typecheck bn, String, s_path_to_the_textfile_that_contains_the_stderr_content
      end # if
      @s_fp_err=s_path_to_the_textfile_that_contains_the_stderr_content
      @b_err_file_path_set=true
   end # set_err_file_path

   private

   # Will exit, if the err file does not exist.
   def s_scan_err_file_exc
   end # s_scan_err_file_exc


   public

   def run(s_command)
      bn=binding()
      ar_valid_command_values=["up","down","current"]
      kibuvits_assert_is_among_values(bn,ar_valid_command_values,
      s_command)
      case s_command
      when "up"
      when "down"
      when "current"
      else
         kibuvits_throw("\ns_command==\""+s_command+
         "\", which is not yet supported by this function.\n"+
         "GUID='26732a12-5f77-4f72-843c-60f23020bcd7'\n")
      end # case s_command
# POOLELI, see JumpGUID on hetkel totaalselt pooleli.
   end # run

end # class JumpGUID_core

#==========================================================================

