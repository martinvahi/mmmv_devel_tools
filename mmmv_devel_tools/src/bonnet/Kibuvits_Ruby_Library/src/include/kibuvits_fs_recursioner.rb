#!/opt/ruby/bin/ruby -Ku
#==========================================================================
=begin

 Copyright 2011, martin.vahi@softf1.com that has an
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
if defined? KIBUVITS_HOME
   require  KIBUVITS_HOME+"/include/kibuvits_msgc.rb"
else
   require  "kibuvits_msgc.rb"
end # if
#==========================================================================

class Kibuvits_fs_recursioner

   private

   def normalize_path s_path
      s_out=""
      return s_out
   end # normalize_path

   def paths_collector ar_in
      b_is_folder=nil
      s_1=nil
      s_2=nil
      ar_in.each do |s_path_candidate|
         if KIBUVITS_b_DEBUG
            kibuvits_typecheck binding(), String, s_path_candidate
         end # if
         s_1=s_path_candidate.gsub(/[\n\r]/,"")
         next if  s_1.length==0
         b_is_folder=File.directory? s_1
         @ar_in_elem_b_is_folder<<b_is_folder
         s_2=Kibuvits_os_codelets.convert_file_path_2_unix_format(s_1)
         @ar_paths_in_unix_format<<s_2
         # POOLELI: muuta see Dir abil rekursiivseks
         raise "Subject to completion."
      end # loop
   end # paths_collector

   public
   def initialize ar_or_s_full_path_2_file_or_folder
      ar_in=Kibuvits_ix.normalize2array(ar_or_s_full_path_2_file_or_folder)
      @ar_in_elem_b_is_folder=Array.new
      @ar_paths_in_unix_format=Array.new
      paths_collector(ar_in)
   end #initialize

   def each_file
      b_is_folder=nil
      s_path=nil
      @ar_paths_in_unix_format.size.times do |i|
         next if @ar_in_elem_b_is_folder[i]
         s_path=@ar_paths_in_unix_format[i]
         yield(s_path)
      end # loop
   end # each_file

   def each_folder
      b_is_folder=nil
      s_path=nil
      @ar_paths_in_unix_format.size.times do |i|
         next if !@ar_in_elem_b_is_folder[i]
         s_path=@ar_paths_in_unix_format[i]
         yield(s_path)
      end # loop
   end # each_folder

   # It's the same as the each_folder
   def each_directory
      # The dumb copy-paste is just to avoid the
      # blocks related "magic" and experimentation
      b_is_folder=nil
      s_path=nil
      @ar_paths_in_unix_format.size.times do |i|
         next if !@ar_in_elem_b_is_folder[i]
         s_path=@ar_paths_in_unix_format[i]
         yield(s_path)
      end # loop
   end # each_directory

   def each_path
      s_path=nil
      @ar_paths_in_unix_format.size.times do |i|
         s_path=@ar_paths_in_unix_format[i]
         yield(s_path)
      end # loop
   end # each_path

   private
   def Kibuvits_fs_recursioner.test_normalize2array
      #x=Kibuvits_fs_recursioner.normalize2array("hi")
      #kibuvits_throw "test 1" if x.length!=1
      #x=Kibuvits_fs_recursioner.normalize2array(nil)
      #kibuvits_throw "test 2" if x.length!=1
   end # Kibuvits_fs_recursioner.test_normalize2array

   public
   include Singleton
   def Kibuvits_fs_recursioner.selftest
      ar_msgs=Array.new
      bn=binding()
      #kibuvits_testeval bn, "Kibuvits_fs_recursioner.test_sar"
      return ar_msgs
   end # Kibuvits_fs_recursioner.selftest
end # class Kibuvits_fs_recursioner

#==========================================================================
