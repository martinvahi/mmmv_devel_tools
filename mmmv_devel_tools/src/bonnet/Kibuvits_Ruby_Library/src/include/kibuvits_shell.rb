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

=end
#==========================================================================

if !defined? KIBUVITS_SHELL_RB_INCLUDED
   KIBUVITS_SHELL_RB_INCLUDED=true

   if !defined? KIBUVITS_HOME
      x=ENV['KIBUVITS_HOME']
      KIBUVITS_HOME=x if (x!=nil and x!="")
   end # if

   require "rubygems"
   require "monitor"
   require "singleton"
   if defined? KIBUVITS_HOME
      require  KIBUVITS_HOME+"/include/kibuvits_io.rb"
      require  KIBUVITS_HOME+"/include/kibuvits_msgc.rb"
      require  KIBUVITS_HOME+"/bonnet/kibuvits_os_codelets.rb"
      require  KIBUVITS_HOME+"/include/kibuvits_str.rb"
   else
      require  "kibuvits_io.rb"
      require  "kibuvits_msgc.rb"
      require  "kibuvits_os_codelets.rb"
      require  "kibuvits_str.rb"
   end # if
end # if

#==========================================================================

# Writes a script to a file and executes it. Returns a hashtable with
# keys "s_stdout" and "s_stderr". The values that are pointed by the keys
# are always strings.
#
# The line breaks within the s_stdout, s_stderr have been normalized
# to the "\n". In case of Windows the 2 header lines and the footer line
# have been removed from the s_stdout.
def sh(s_shell_script)
   if KIBUVITS_b_DEBUG
      kibuvits_typecheck binding(), String, s_shell_script
   end # if
   s_fp_script=Kibuvits_os_codelets.instance.generate_tmp_file_absolute_path
   s_fp_stdout=Kibuvits_os_codelets.instance.generate_tmp_file_absolute_path
   s_fp_stderr=Kibuvits_os_codelets.instance.generate_tmp_file_absolute_path
   s_ostype=Kibuvits_os_codelets.instance.get_os_type
   cmd=nil
   case s_ostype
   when "kibuvits_ostype_unixlike"
      cmd="bash "+s_fp_script+" 1>"+s_fp_stdout+" 2>"+s_fp_stderr+" ;"
   when "kibuvits_ostype_windows"
      cmd=s_fp_script+" 1>"+s_fp_stdout+" 2>"+s_fp_stderr+" "
      # It's probably more fault tolerant to feed
      # only windows line breaks to the windows console/batch file
      # processor.
      s_shell_script=Kibuvits_str.normalise_linebreaks(s_shell_script,"\r\n")
   else
   end # case
   str2file(s_shell_script,s_fp_script)
   str2file($kibuvits_lc_emptystring,s_fp_stdout)
   str2file($kibuvits_lc_emptystring,s_fp_stderr)
   ht_stdstreams=Kibuvits_io.creat_empty_ht_stdstreams
   begin
      b_success,console_output=system(cmd)
   rescue Exception=>e
      File.delete(s_fp_script)
      File.delete(s_fp_stdout)
      File.delete(s_fp_stderr)
      kibuvits_throw e.message.to_s
   end # try-catch
   s_stdout=Kibuvits_str.normalise_linebreaks(
   file2str(s_fp_stdout),$kibuvits_lc_linebreak)
   s_stderr=Kibuvits_str.normalise_linebreaks(
   file2str(s_fp_stderr),$kibuvits_lc_linebreak)
   File.delete(s_fp_script)
   File.delete(s_fp_stdout)
   File.delete(s_fp_stderr)
   if s_ostype=="kibuvits_ostype_windows"
      # The windows stdout contains 2 header lines and one footer line.
      i_number_of_lines=Kibuvits_str.count_substrings(
      s_stdout,$kibuvits_lc_linebreak)+1
      if i_number_of_lines<3
         kibuvits_throw "On Windows there should be at least "+
         "3 lines in the stdout. i_number_of_lines=="+
         i_number_of_lines.to_s
      end # if
      i_last_copyable_line_number=i_number_of_lines-1
      s=""
      i=0
      s_stdout.each_line do |s_line|
         i=i+1
         break if i_last_copyable_line_number<i
         next if i<=2
         s=s+$kibuvits_lc_linebreak if 3<i
         s=s+Kibuvits_str.clip_tail_by_str(s_line,$kibuvits_lc_linebreak)
      end # loop
      s_stdout=s
   end # if
   ht_stdstreams[$kibuvits_lc_s_stdout]=s_stdout
   ht_stdstreams[$kibuvits_lc_s_stderr]=s_stderr
   return ht_stdstreams
end # sh

#--------------------------------------------------------------------------

class Kibuvits_shell
   def initialize
      @s_lc_which="which ".freeze
      @s_lc_1="[/]".freeze
   end # initialize

   # Returns boolean true, if the script or binary named
   # valueof(s_executable_name) is available on the path.
   def b_available_on_path(s_executable_name)
      if KIBUVITS_b_DEBUG
         bn=binding()
         kibuvits_typecheck bn, String, s_executable_name
      end # if
      b_out=false
      ht=sh(@s_lc_which+s_executable_name)
      s_from_console=ht[$kibuvits_lc_s_stdout].to_s
      rgx=Regexp.new(@s_lc_1+s_executable_name+$kibuvits_lc_dollarsign)
      if (rgx.match(s_from_console))!=nil
         b_out=true
      end # if
      return b_out
   end # b_available_on_path

   def Kibuvits_shell.b_available_on_path(s_executable_name)
      b_out=Kibuvits_shell.instance.b_available_on_path(s_executable_name)
      return b_out
   end # Kibuvits_shell.b_available_on_path

   public
   include Singleton
   # The Kibuvits_shell.selftest analogue is
   # in a separate selftest file.

end # class Kibuvits_shell

#==========================================================================
