#!/usr/bin/env ruby
#==========================================================================
=begin
 Copyright since 2009,  martin.vahi@softf1.com that has an
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

if !defined? UPGUID_CORE_RB_INCLUDED
   UPGUID_CORE_RB_INCLUDED =true
   if !defined? MMMV_DEVEL_TOOLS_HOME
      require 'pathname'
      s_0=Pathname.new(__FILE__).realpath.parent.parent.parent.parent.parent.parent.parent.parent.to_s
      MMMV_DEVEL_TOOLS_HOME=s_0.freeze
   end # if

   require MMMV_DEVEL_TOOLS_HOME+"/src/bonnet/mmmv_devel_tools_initialization_t1.rb"

   require KIBUVITS_HOME+"/src/include/kibuvits_io.rb"
   require KIBUVITS_HOME+"/src/include/kibuvits_shell.rb"
   require KIBUVITS_HOME+"/src/include/kibuvits_argv_parser.rb"
   require KIBUVITS_HOME+"/src/include/kibuvits_fs.rb"
   require KIBUVITS_HOME+"/src/include/kibuvits_refl.rb"
   require KIBUVITS_HOME+"/src/include/kibuvits_apparch_specific.rb"
end # if

#==========================================================================

class GUID_trace_UpGUID_core
   def initialize
      @s_repl="AlL_oF_THe_OlD_GLObAlLY_UnIQuE_IDeNTI"+
      "fIErS_aRe_rePlAcEd_wIth_tHiS4"
   end # initialize

   def copyright
      return "Copyright (c) since 2009, martin.vahi@softf1.com"+
      "that has an \nEstonian national identification number "+
      "of 38108050020. This class "+
      "is under the BSD license."
   end # copyright


   def replace_guids source_file_content_as_a_string
      s_source=source_file_content_as_a_string
      ar_replacements=Array.new
      i=0
      s_tmprplmnt=""
      s_regex_core=".{8}[-].{4}[-].{4}[-].{4}[-].{12}"
      s_regex_single_quotes="[']"+s_regex_core+"[']"
      s_regex_double_quotes="[\"]"+s_regex_core+"[\"]"
      old_GUID=nil
      go_on=true
      while go_on do
         go_on=false
         # The String.match returns either nil or MatchData instance
         # That is to say, String.match DOES NOT, return a string.
         old_GUID=s_source.match(s_regex_single_quotes)
         if old_GUID!=nil
            old_GUID=old_GUID.to_s
            i=i+1
            s_tmprplmnt=@s_repl+i.to_s
            ar_replacements<<s_tmprplmnt
            s_source.sub!(old_GUID,"'"+s_tmprplmnt+"'")
            go_on=true
         end # if
         old_GUID=s_source.match(s_regex_double_quotes)
         if old_GUID!=nil
            old_GUID=old_GUID.to_s
            i=i+1
            s_tmprplmnt=@s_repl+i.to_s
            ar_replacements<<s_tmprplmnt
            s_source.sub!(old_GUID,"\""+s_tmprplmnt+"\"")
            go_on=true
         end # if
      end # while
      n=ar_replacements.length
      return s_source if n==0
      new_GUID=nil
      n.times do |i|
         new_GUID=Kibuvits_GUID_generator.generate_GUID
         s_source.sub!(ar_replacements.pop,new_GUID)
      end # loop
      return s_source
   end # replace_guids

   def xof_veirfy_file_path s_file_path_candidate
      ht_filesystemtest_failures=Kibuvits_fs.verify_access(
      s_file_path_candidate,'is_file,writable')
      Kibuvits_fs.exit_if_any_of_the_filesystem_tests_failed(
      ht_filesystemtest_failures)
   end #xof_veirfy_file_path

   public

   def do_it_on_a_file s_file_path
      xof_veirfy_file_path s_file_path
      s_source=file2str(s_file_path)
      s_source_new = replace_guids(s_source)
      File.delete(s_file_path)
      str2file(s_source_new,s_file_path)
   end # do_it_on_a_file

   #http://www.youtube.com/watch?v=OZCIKjYDf1g
   def do_it_to_the_stream
      s_source=get_from_stdin
      s_source_new = replace_guids(s_source)
      write_to_stdout s_source_new
   end # do_it_to_the_stream

end # class GUID_trace_UpGUID_core

#==========================================================================

