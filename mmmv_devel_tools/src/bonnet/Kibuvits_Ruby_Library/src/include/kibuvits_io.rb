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
if !defined? KIBUVITS_HOME
   x=ENV['KIBUVITS_HOME']
   KIBUVITS_HOME=x if (x!=nil and x!="")
end # if

require "rubygems"
require "monitor"
if defined? KIBUVITS_HOME
   require KIBUVITS_HOME+"/include/kibuvits_boot.rb"
else
   require "kibuvits_boot.rb"
end # if

KIBUVITS_RUBY_LIBRARY_IS_AVAILABLE=false if !defined? KIBUVITS_RUBY_LIBRARY_IS_AVAILABLE

require "singleton"

#==========================================================================
def get_from_stdin
   an_stdin=STDIN.reopen($stdin)
   data=an_stdin.readlines(nil)
   an_stdin.close
   return data[0]
end #get_from_stdin

def write_to_stdout data
   # It's like the puts, but without the linebreak
   an_io=STDOUT.reopen($stdout)
   an_io.write data
   an_io.flush
   an_io.close
end # write_to_stdout

#--------------------------------------------------------------------------
# DEPRECATED
def kibuvits_hack_to_break_circular_dependency_between_io_and_fs_ensure_absolute_path(
   s_file_path, s_local_pwd_where_the_file_resides)
   raise Exception.new("This function is expected to be deprecated. "+
   "This exception message exists only to allow one to detect the regions of "+
   "code that need to be updated.")
   # The code below is here just in case the test-period results
   # lead to a conclusion that this fuction here is useful after all.
   s_p=nil
   s_local_pwd=nil
   if KIBUVITS_RUBY_LIBRARY_IS_AVAILABLE
      if KIBUVITS_b_DEBUG
         bn=binding()
         kibuvits_typecheck bn, String, s_file_path
         kibuvits_typecheck bn, String, s_local_pwd_where_the_file_resides
      end # if
   end # if
   s_p=s_file_path
   s_local_pwd=s_local_pwd_where_the_file_resides
   s_p=s_local_pwd+"/"+s_p.sub(/^[.][\/]/,"") if s_p[0..0]!="/"
   s_p=s_p.gsub(/[\/]+/,"/")
   # DEPRECATED TODO: check, whether the path goes higher than the root.
   # for example, "/../something" is illegal.
   return s_p
end # kibuvits_hack_to_break_circular_dependency_between_io_and_fs_ensure_absolute_path

#--------------------------------------------------------------------------
def str2file(s_a_string, s_fp)
   begin
      if KIBUVITS_RUBY_LIBRARY_IS_AVAILABLE
         if KIBUVITS_b_DEBUG
            bn=binding()
            kibuvits_typecheck bn, String, s_a_string
            kibuvits_typecheck bn, String, s_fp
         end # if
      end # if
      #s_fp=kibuvits_hack_to_break_circular_dependency_between_io_and_fs_ensure_absolute_path(
      #s_fp, Dir.pwd.to_s)
      file=File.open(s_fp, "w")
      file.write(s_a_string)
      file.close
   rescue Exception =>err
      raise "No comments. s_a_string=="+s_a_string+"\n"+err.to_s+"\n\n"
   end # rescure
end # str2file

#--------------------------------------------------------------------------
# It's actually a copy of a TESTED version of
# kibuvits_s_concat_array_of_strings
# and this copy here is made to avoid making the
# kibuvits_io.rb to depend on the kibuvits_str.rb
def kibuvits_hack_to_break_circular_dependency_between_io_and_str_kibuvits_s_concat_array_of_strings(ar_in)
   n=ar_in.size
   if KIBUVITS_RUBY_LIBRARY_IS_AVAILABLE
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
   if KIBUVITS_RUBY_LIBRARY_IS_AVAILABLE
      if KIBUVITS_b_DEBUG
         kibuvits_typecheck binding(), String, s_file_path
         if !defined? kibuvits_hack_to_break_circular_dependency_between_io_and_fs_ensure_absolute_path
            s="3ff80352-1591-43af-b61c-5023b0d11cd7" # a var to make the GUID match a regex
            kibuvits_throw("If the control flow is in this area, \""+
            s+"\", it is expected that the file2str is called while it is part of the "+
            "Kibuvits Ruby Library. In here the tested method must exist.")
         end # if
      end # if
   end # if
   # The idea here is to make the file2str easily copyable to projects that
   # do not use the Kibuvits Ruby Library.
   s_fp=nil
   if defined? kibuvits_hack_to_break_circular_dependency_between_io_and_fs_ensure_absolute_path
      #s_fp=kibuvits_hack_to_break_circular_dependency_between_io_and_fs_ensure_absolute_path(
      #s_file_path,Dir.pwd)
      s_fp=s_file_path
   else
      s_fp=s_file_path
   end # if
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
   end # rescure
   return s_out
end # file2str

#--------------------------------------------------------------------------
# The main purpose of this method is to encapsulate the console
# reading code, because there's just too many unanswered questions about
# the console reading.
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

class Kibuvits_io
   @@cache=Hash.new
   def initialize
   end #initialize

   def creat_empty_ht_stdstreams
      ht_stdstreams=Hash.new
      ht_stdstreams['s_stdout']=""
      ht_stdstreams['s_stderr']=""
      return 	ht_stdstreams
   end # creat_empty_ht_stdstreams

   def Kibuvits_io.creat_empty_ht_stdstreams
      ht_stdstreams=Kibuvits_io.instance.creat_empty_ht_stdstreams
      return ht_stdstreams
   end # Kibuvits_io.creat_empty_ht_stdstreams

   public
   include Singleton
   def Kibuvits_io.selftest
      ar_msgs=Array.new
      #kibuvits_testeval binding(), "Kibuvits_io.test_verify_access"
      return ar_msgs
   end # Kibuvits_io.selftest

end # class Kibuvits_io

#--------------------------------------------------------------------------
