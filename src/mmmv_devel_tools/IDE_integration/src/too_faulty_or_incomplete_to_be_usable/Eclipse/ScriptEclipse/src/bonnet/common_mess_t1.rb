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

---------------------------------------------------------------------------

This file is a mess, because it has to contain everything it needs.
The reason is that it is meant to be executed by a JRuby interpreter
that is embedded to an IDE and any kind of local gem repository
setup makes it difficult, time consuming, to get started. Another reason
is that the JRuby just crashes on Kibuvits Ruby Library due to 
weak UTF-8 support. 

The solution is that the JRuby is used for really minimal things
and a lot is delegated to the native Ruby by having the 
JRuby writing scripts for the native Ruby to execute.

=end
#==========================================================================

if !defined? KIBUVITS_RUBY_LIBRARY_IS_AVAILABLE
   KIBUVITS_RUBY_LIBRARY_IS_AVAILABLE=false
end # if




# Practically all of the content of this class has been
# Copy/pasted from the Kibuvits Ruby Library (KRL) and compacted/edited
# a little bit.
#
# There's no point of even trying to read this source from here, because
# the commented version resides in the KRL and some of the comments
# of the copy/pasted source have been removed.
class T_mmmv_devel_tools_IDE_integration_common_mess_core_KRL
   @@cache=Hash.new

   def initialize
   end # initialize

   def convert_2_GUID_format a_36_character_hexa_string
      s=a_36_character_hexa_string
      s[8..8]='-'
      s[13..13]='-'
      s[14..14]='4' # The GUID spec version
      s[18..18]='-'
      s[19..19]=(rand(4)+8).to_s(16) # the variant with bits 10xx
      s[23..23]='-'
      return s
   end #convert_2_GUID_format

   def s_generate_GUID
      t=Time.now
      #        3 characters    1 character
      s_guid=t.year.to_s(16)+t.month.to_s(16) # 3 digit year, 1 digit month
      s_guid=s_guid+"0" if t.day<16
      s_guid=s_guid+t.day.to_s(16)
      s_guid=s_guid+"0" if t.hour<16 # 60.to_s(16).length<=2
      s_guid=s_guid+t.hour.to_s(16)
      s_guid=s_guid+"0" if t.min<16
      s_guid=s_guid+t.min.to_s(16)
      s_guid=s_guid+"0" if t.sec<16
      s_guid=s_guid+t.sec.to_s(16)
      s_guid=s_guid+((t.usec*1.0)/1000).round.to_s(16)
      while s_guid.length<36 do
         s_guid=s_guid+rand(100000000).to_s(16)
      end # loop
      s_1=s_guid[0..35].reverse
      s_guid=convert_2_GUID_format(s_1)
      return s_guid
   end #s_generate_GUID

   def get_from_stdin
      an_stdin=STDIN.reopen($stdin)
      data=an_stdin.readlines(nil)
      an_stdin.close
      return data[0]
   end #get_from_stdin

   def write_to_stdout data
      an_io=STDOUT.reopen($stdout)
      an_io.write data
      an_io.flush
      an_io.close
   end # write_to_stdout

   #--------------------------------------------------------------------------
   def str2file(s_a_string, s_fp_osspecific)
      begin
         if defined? KIBUVITS_b_DEBUG
            if KIBUVITS_b_DEBUG
               bn=binding()
               kibuvits_typecheck bn, String, s_a_string
               kibuvits_typecheck bn, String, s_fp_osspecific
            end # if
         end # if
         file=File.open(s_fp_osspecific, "w")
         file.write(s_a_string)
         file.close
      rescue Exception =>err
         raise "No comments. s_a_string=="+s_a_string+"\n"+err.to_s+"\n\n"
      end # rescue
   end # str2file

   #--------------------------------------------------------------------------
   def kibuvits_hack_to_break_circular_dependency_between_io_and_str_kibuvits_s_concat_array_of_strings(ar_in)
      n=ar_in.size
      if defined? KIBUVITS_b_DEBUG
         if KIBUVITS_b_DEBUG
            bn=binding()
            kibuvits_typecheck bn, Array, ar_in
            s=nil
            n.times do |i|
               bn=binding()
               s=ar_in[i]
               kibuvits_typecheck bn, String, s
            end # loop
         end # if
      end # if
      s_out="";
      n.times{|i| s_out<<ar_in[i]}
      return s_out;
   end # kibuvits_hack_to_break_circular_dependency_between_io_and_str_kibuvits_s_concat_array_of_strings

   def file2str(s_file_path)
      if defined? KIBUVITS_b_DEBUG
         if KIBUVITS_b_DEBUG
            kibuvits_typecheck binding(), String, s_file_path
         end # if
      end # if
      s_fp=nil
      s_fp=s_file_path
      s_emptystring="" # to avoid repeated instantiation
      s_out=s_emptystring
      ar_lines=Array.new
      begin
         File.open(s_fp) do |file|
            while line = file.gets
               ar_lines<<s_emptystring+line
            end # while
         end # Open-file region.
         s_out=kibuvits_hack_to_break_circular_dependency_between_io_and_str_kibuvits_s_concat_array_of_strings(ar_lines)
      rescue Exception =>err
         raise "\n"+err.to_s+"\n\ns_file_path=="+s_file_path+"\n\n"
      end # rescue
      return s_out
   end # file2str

   #--------------------------------------------------------------------------
   def read_a_line_from_console
      # The IO.gets() treats console arguments as if they would have
      # been writeln as user input for a query. For some weird reason,
      # the current solution works.
      s_out=""+$stdin.gets
      return s_out
   end # read_a_line_from_console

   def write_2_console a_string
      # The "" is just for reducing the probability of
      # mysterious memory sharing related quirk-effects.
      $stdout.write ""+a_string.to_s
   end # write_2_console

   def writeln_2_console a_string,
      i_number_of_prefixing_linebreaks=0,
      i_number_of_suffixing_linebreaks=1
      s=("\n"*i_number_of_prefixing_linebreaks)+a_string.to_s+
      ("\n"*i_number_of_suffixing_linebreaks)
      write_2_console s
   end # write_2_console

   #---start--of--the--crappy--get-ostype--mess--

   def get_os_type
      s_key='os_type'
      if @@cache.has_key? s_key
         s_out=""+@@cache[s_key]
         return s_out
      end # if
      s=RUBY_PLATFORM
      s_out='not_determined'
      if 	s.include? 'linux'
         s_out="kibuvits_ostype_unixlike"
      elsif 	s.include? 'bsd' # on DesktopBSD it's "i386-freebsd7"
         s_out="kibuvits_ostype_unixlike"
      elsif 	s.include? 'java' # JRuby
         s_out="kibuvits_ostype_java"
      elsif (s.include? 'win')||(s.include? 'mingw')
         s_out="kibuvits_ostype_windows"
      else
         raise Exception.new('RUBY_PLATFORM=='+RUBY_PLATFORM+
         ' is not supported by this library.')
      end # elsif
      # There's no point of synchronizing it, because all
      # threads will insert a same result.
      @@cache[s_key]=""+s_out
      return s_out
   end # get_os_type

   #-----------------------------------------------------------------------
   def get_tmp_folder_path
      s_env_name="MMMV_DEVEL_TOOLS_HOME"
      s_mmmv_devel_tools_home=ENV[s_env_name]
      s_out=s_mmmv_devel_tools_home+"/src/bonnet/tmp"
      return s_out
   end # get_tmp_folder_path

   def generate_tmp_file_name s_file_name_prefix="tmp_file_"
      s=s_file_name_prefix+(Time.new.to_s).gsub!(/[\s;.\\\/:+]/,"_")
      # 2147483647==2^(32-1)-1, i.e. 0 included
      s=s+'r'+Kernel.rand(2147483647).to_s
      s=s+'r'+Kernel.rand(2147483647).to_s
      s=s+'r'+Kernel.rand(2147483647).to_s+'e.txt' # 'e' is a [^\d]
      return s
   end # generate_tmp_file_name

   #-----------------------------------------------------------------------
   def generate_tmp_file_absolute_path(s_file_name_prefix="tmp_file_")
      s_fp0=get_tmp_folder_path+"/"+generate_tmp_file_name(s_file_name_prefix)
      return s_fp0
   end # generate_tmp_file_absolute_path

   #---end----of--the--crappy--get-ostype--mess--

end # class T_mmmv_devel_tools_IDE_integration_common_mess_core_KRL


#--------------------------------------------------------------------------

class T_mmmv_devel_tools_IDE_integration_common_mess_t1
   @@core_KRL=T_mmmv_devel_tools_IDE_integration_common_mess_core_KRL.new

   def initialize
   end # initialize

   def T_mmmv_devel_tools_IDE_integration_common_mess_t1.ob_get_core_KRL
      ob_out=@@core_KRL
      return ob_out
   end # T_mmmv_devel_tools_IDE_integration_common_mess_t1.ob_get_core_KRL


   # The s_input_string_file_name_suffix is useful for cases, where the
   # the application that resides at s_console_app_path chooses
   # it's mode of operation according to a file extension.
   def T_mmmv_devel_tools_IDE_integration_common_mess_t1.filter_string_through_a_command_line_application(
      s_console_app_path,s_args, s_in, b_application_works_by_editing_input_files=false,
      s_input_string_file_name_suffix="txt")

      s_fp_in=@@core_KRL.generate_tmp_file_absolute_path+".s_in."+s_input_string_file_name_suffix
      s_fp_script=@@core_KRL.generate_tmp_file_absolute_path+".script"
      s_fp_stdout=@@core_KRL.generate_tmp_file_absolute_path+".stdout"
      s_fp_stderr=@@core_KRL.generate_tmp_file_absolute_path+".stderr"

      @@core_KRL.str2file(s_in,s_fp_in)
      if b_application_works_by_editing_input_files
         @@core_KRL.str2file(s_console_app_path+" "+s_args+"  "+s_fp_in+"\n", s_fp_script)
      else
         @@core_KRL.str2file(s_console_app_path+" "+s_args+" < "+s_fp_in+"\n", s_fp_script)
      end # if
      @@core_KRL.str2file("",s_fp_stdout)
      @@core_KRL.str2file("",s_fp_stderr)
      s_out=""
      begin
         cmd="/bin/bash "+s_fp_script+" 1> "+s_fp_stdout+" 2> "+s_fp_stderr+" "
         # It can probably be made to work on Windows, if the system(cmd)
         # is replaced with the KRL's sh(cmd), but the sh(cmd) has many
         # dependencies and given that the sh related part in the KRL is
         # a bit experimental, one just does not want to copy/paste them in
         # here yet.
         b_success,console_output=system(cmd)
         if b_application_works_by_editing_input_files
            s_out=@@core_KRL.file2str(s_fp_in)
         else
            s_out=@@core_KRL.file2str(s_fp_stdout)
         end # if
      rescue Exception => e
         raise e
      end # try-catch
      File.delete(s_fp_in) if File.exists? s_fp_in
      File.delete(s_fp_script) if File.exists? s_fp_script
      File.delete(s_fp_stdout) if File.exists? s_fp_stdout
      File.delete(s_fp_stderr) if File.exists? s_fp_stderr
      return s_out
   end # T_mmmv_devel_tools_IDE_integration_common_mess_t1.filter_string_through_a_command_line_application

end # class T_mmmv_devel_tools_IDE_integration_common_mess_t1


#==========================================================================


