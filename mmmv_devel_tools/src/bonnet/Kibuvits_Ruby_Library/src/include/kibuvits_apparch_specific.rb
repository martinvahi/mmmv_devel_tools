#!/opt/ruby/bin/ruby -Ku
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
   x=ENV['KIBUVITS_HOME']
   KIBUVITS_HOME=x if (x!=nil and x!="")
end # if

require "rubygems"
require "monitor"
if defined? KIBUVITS_HOME
   require  KIBUVITS_HOME+"/include/kibuvits_str.rb"
   require  KIBUVITS_HOME+"/include/kibuvits_shell.rb"
   require  KIBUVITS_HOME+"/include/kibuvits_fs.rb"
else
   require  "kibuvits_str.rb"
   require  "kibuvits_shell.rb"
   require  "kibuvits_fs.rb"
end # if
require "singleton"
#==========================================================================

# The class Kibuvits_apparch_specific is a namespace for
# code fragmetns that are somewhat specific to
# an application architecture, but as the architectures are
# shared by more than one application, it saves time by
# writing them only once in stead of rewriting the parts
# in every application.
class Kibuvits_apparch_specific
   def initialize
   end #initialize

   # Makes a copy of a file that is pointed by the
   # s_template_file_path and executes
   # a block that gets 2 block arguments: s_tmp_file_path, ob
   #
   # The file paths are converted to absolute paths according to the
   # value of the Dir.pwd, i.e. working directory, unless the paths,
   # s_template_file_path and s_temporary_folder_path are already absolute.
   def xof_run_bloc_on_a_copy_of_a_template(
      s_template_file_path, s_temporary_folder_path,ob,
      b_delete_temporary_file=true)
      bn=binding()
      kibuvits_typecheck bn, String, s_template_file_path
      kibuvits_typecheck bn, String, s_temporary_folder_path
      kibuvits_typecheck bn, [TrueClass,FalseClass], b_delete_temporary_file

      s_pwd=Dir.pwd
      s_template_fp_orig=Kibuvits_fs.ensure_absolute_path(
      s_template_file_path,s_pwd)
      s_tmpfolder_fp_orig=Kibuvits_fs.ensure_absolute_path(
      s_temporary_folder_path,s_pwd)

      s_template_fp_orig=Kibuvits_os_codelets.convert_file_path_2_os_specific_format(
      s_template_fp_orig)
      s_tmpfolder_fp_orig=Kibuvits_os_codelets.convert_file_path_2_os_specific_format(
      s_tmpfolder_fp_orig)

      ht_filesystemtest_failures=Kibuvits_fs.verify_access(
      s_template_fp_orig,'is_file,writable')
      Kibuvits_fs.exit_if_any_of_the_filesystem_tests_failed(
      ht_filesystemtest_failures)
      ht_filesystemtest_failures=Kibuvits_fs.verify_access(
      s_tmpfolder_fp_orig,'is_directory,writable')
      Kibuvits_fs.exit_if_any_of_the_filesystem_tests_failed(
      ht_filesystemtest_failures)

      s=Kibuvits_os_codelets.convert_file_path_2_unix_format(
      s_tmpfolder_fp_orig)
      s_tmp_file_path=s+"/subject_to_removal_"+
      Kibuvits_GUID_generator.generate_GUID+".txt"
      s_tmp_file_path=Kibuvits_os_codelets.convert_file_path_2_os_specific_format(
      s_tmp_file_path)

      # The next line works also on binary files, which is important.
      sh "cp "+s_template_fp_orig+" "+s_tmp_file_path
      b_exception_in_block=false
      s_xs_msg=""
      begin
         yield(s_tmp_file_path,ob)
      rescue Exception => e
         b_exception_in_block=true
         s_xs_msg=e.message
      end # end
      if b_delete_temporary_file
         File.delete(s_tmp_file_path) if File.exists? s_tmp_file_path
      end # if
      kibuvits_throw s_xs_msg if b_exception_in_block
   end # xof_run_bloc_on_a_copy_of_a_template,

   def Kibuvits_apparch_specific.xof_run_bloc_on_a_copy_of_a_template(
      s_template_file_path, s_temporary_folder_path,ob,
      b_delete_temporary_file=true,&a_block)
      Kibuvits_apparch_specific.instance.xof_run_bloc_on_a_copy_of_a_template(
      s_template_file_path, s_temporary_folder_path,ob,
      b_delete_temporary_file,&a_block)
   end # Kibuvits_apparch_specific.xof_run_bloc_on_a_copy_of_a_template

   private

   def Kibuvits_apparch_specific.test_xof_run_bloc_on_a_copy_of_a_template
      s_fp=Kibuvits_os_codelets.generate_tmp_file_absolute_path
      str2file("Test text",s_fp)
      s_tmp_folder_path=Kibuvits_os_codelets.get_tmp_folder_path
      if kibuvits_block_throws{Kibuvits_apparch_specific.xof_run_bloc_on_a_copy_of_a_template(s_fp,s_tmp_folder_path,nil){}}
         File.delete(s_fp)
         kibuvits_throw "test 1"
      end # if
      if !kibuvits_block_throws{Kibuvits_apparch_specific.xof_run_bloc_on_a_copy_of_a_template(42,s_tmp_folder_path,nil){}}
         File.delete(s_fp)
         kibuvits_throw "test 2"
      end # if
      if !kibuvits_block_throws{Kibuvits_apparch_specific.xof_run_bloc_on_a_copy_of_a_template(s_fp,42,nil){}}
         File.delete(s_fp)
         kibuvits_throw "test 3"
      end # if
      if !kibuvits_block_throws{Kibuvits_apparch_specific.xof_run_bloc_on_a_copy_of_a_template(s_fp,s_tmp_folder_path,nil,42){}}
         File.delete(s_fp)
         kibuvits_throw "test 4"
      end # if
      File.delete(s_fp) if File.exist? s_fp
   end # Kibuvits_apparch_specific.test_xof_run_bloc_on_a_copy_of_a_template

   public
   include Singleton
   def Kibuvits_apparch_specific.selftest
      ar_msgs=Array.new
      kibuvits_testeval binding(), "Kibuvits_apparch_specific.test_xof_run_bloc_on_a_copy_of_a_template"
      return ar_msgs
   end # Kibuvits_apparch_specific.selftest
end # class Kibuvits_apparch_specific
#=========================================================================
