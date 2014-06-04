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
require  KIBUVITS_HOME+"/src/include/kibuvits_shell.rb"

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
      when "htaccess"
         s_file_language="htaccess"
      else
         msgcs.cre "Either the file extension is not supported or "+
         "the file extension extraction failed.\n"+
         "File extension candidate is: "+s_file_extension, 1.to_s
         msgcs.last[$kibuvits_lc_Estonian]="Faililaiend on kas toetamata või ei õnnestunud "+
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

   #--------------------------------------------------------------------------

   def exm_b_files_have_bitwise_equal_content_t1(s_fp_file_1,s_fp_file_2,
      msgcs=nil)
      if KIBUVITS_b_DEBUG
         bn=binding()
         kibuvits_typecheck bn, String, s_fp_file_1
         kibuvits_typecheck bn, String, s_fp_file_2
         kibuvits_typecheck bn, [NilClass,Kibuvits_msgc_stack], msgcs
      end # if
      #----------------
      b_throw_on_failure=true
      if msgcs.class==Kibuvits_msgc_stack
         b_throw_on_failure=false
      else
         msgcs=Kibuvits_msgc_stack.new
      end # if
      #----------------
      rgx=/[\/]+/
      s_fp_1=s_fp_file_1.gsub(rgx,$kibuvits_lc_slash)
      s_fp_2=s_fp_file_2.gsub(rgx,$kibuvits_lc_slash)
      #----------------
      ht_test_failures=Kibuvits_fs.verify_access([s_fp_1,s_fp_1],
      "readable,is_file")
      s_output_message_language=$kibuvits_lc_English
      exit_if_any_of_the_filesystem_tests_failed(ht_test_failures,
      s_output_message_language,b_throw_on_failure,msgcs)
      return false if msgcs.b_failure
      #----------------
      i_size_1=File.size(s_fp_1)
      i_size_2=File.size(s_fp_2)
      return false if i_size_1!=i_size_2 # more frequent than
      return true if s_fp_1==s_fp_2      # this line
      #--------------
      cmd="diff --brief "+s_fp_1+$kibuvits_lc_space+s_fp_2
      ht_stdstreams=kibuvits_sh(cmd)
      Kibuvits_shell.throw_if_stderr_has_content_t1(ht_stdstreams,
      "GUID='83d20481-738e-4e11-b192-f1a251214ed7'\n")
      s_stdout=ht_stdstreams[$kibuvits_lc_s_stdout]
      return false if 0<s_stdout.length
      return true
   end # exm_b_files_have_bitwise_equal_content_t1

   def Kibuvits_file_intelligence.exm_b_files_have_bitwise_equal_content_t1(
      s_fp_file_1,s_fp_file_2,msgcs=nil)
      b_out=Kibuvits_file_intelligence.instance.exm_b_files_have_bitwise_equal_content_t1(
      s_fp_file_1,s_fp_file_2,msgcs)
      return b_out
   end # Kibuvits_file_intelligence.exm_b_files_have_bitwise_equal_content_t1

   #--------------------------------------------------------------------------

   private

   # Returns destination file or folder path or the path
   # of an existing, older, back-up file, if
   # one of the older back-up files has the same
   # content as the original. The current version
   # always forces folders to be re-backed up, because
   # the FileUtils.compare_file does not work with folders.
   #
   # TODO: Fix the exm_s_create_backup_copy_t1_create_s_fp_dest
   # so that it will not force folders to be recursively
   # backed up if the content of the backup equals with the
   # original.
   def exm_s_create_backup_copy_t1_create_s_fp_dest(
      s_fp_dest_parent_folder,s_backup_prefix,
      s_fp_file_or_folder,b_throw_on_failure,msgcs)
      if KIBUVITS_b_DEBUG
         # A bit of an overkill, but helps to locate problems.
         bn=binding()
         kibuvits_typecheck bn, String, s_fp_dest_parent_folder
         kibuvits_typecheck bn, String, s_backup_prefix
         kibuvits_typecheck bn, String, s_fp_file_or_folder
         kibuvits_typecheck bn, [TrueClass,FalseClass], b_throw_on_failure
         kibuvits_typecheck bn, Kibuvits_msgc_stack, msgcs
      end # if
      ar=Kibuvits_str.ar_bisect(s_fp_file_or_folder.reverse,$kibuvits_lc_slash)
      s_fp_forf_name=ar[0].reverse
      i_backup_version=0
      #----------------
      s_token_0=(s_fp_dest_parent_folder+$kibuvits_lc_slash).gsub(
      /[\/]+/,$kibuvits_lc_slash)
      s_token_1=s_fp_forf_name
      s_token_2_version=$kibuvits_lc_underscore+s_backup_prefix+i_backup_version.to_s
      s_token_3_dot_file_extension_if_file=$kibuvits_lc_emptystring
      if !File.directory? s_fp_file_or_folder
         # Supposedly does not match links to folders.
         md=s_fp_forf_name.match(/[.][^.]+$/)
         if md!=nil
            s_dot_file_ext=md[0]
            s_token_1=s_fp_forf_name[0..(-1-s_dot_file_ext.length)]
            s_token_3_dot_file_extension_if_file=s_dot_file_ext
         end # if
      end # if
      s_fp_dest_candidate_0=nil
      s_fp_dest_candidate_1=s_token_0+s_token_1+
      s_token_2_version+s_token_3_dot_file_extension_if_file
      while File.exist? s_fp_dest_candidate_1
         s_fp_dest_candidate_0=s_fp_dest_candidate_1
         i_backup_version=i_backup_version+1
         s_token_2_version=$kibuvits_lc_underscore+
         s_backup_prefix+i_backup_version.to_s
         s_fp_dest_candidate_1=s_token_0+s_token_1+
         s_token_2_version+s_token_3_dot_file_extension_if_file
      end # loop
      if !$kibuvits_var_b_module_fileutils_loaded
         # It's OK to load them more than once, so no need for Mutexes.
         # It just seems to be a corner case, where performance
         # has probably not been very well tested, i.e.
         # usually people do not have loops that try to reload a
         # module thousands of times. Hence this if-clause here.
         require "fileutils"
         $kibuvits_var_b_module_fileutils_loaded=true
      end # if
      return s_fp_dest_candidate_1 if s_fp_dest_candidate_0==nil
      return s_fp_dest_candidate_1 if File.directory? s_fp_file_or_folder
      b_old_backup_is_the_same_as_the_original=FileUtils.compare_file(
      s_fp_dest_candidate_0,s_fp_file_or_folder)
      if b_old_backup_is_the_same_as_the_original
         s_fp_dest_candidate_1=s_fp_dest_candidate_0
      end # if
      return s_fp_dest_candidate_1
   end # exm_s_create_backup_copy_t1_create_s_fp_dest

   public

   # Throws or returns with flaw description, if the destination
   # folder of the backup copy is not writable or the "cp -fr " fails.
   #
   # If the s_fp_backup_destination_folder==".", then the backup
   # copy is placed to the same folder, where the original resides.
   #
   # File extensions are retained. Non-file-extension part of
   # the file or folder name is suffixed with <"_"+s_backup_prefix><integer>.
   #
   # If the creation of the backup copy suceeded, returns
   # the full path of the backup copy. Otherwise returns an empty string.
   def exm_s_create_backup_copy_t1(
      s_fp_file_or_folder,s_fp_backup_destination_folder=$kibuvits_lc_dot,
      msgcs=nil,s_backup_prefix="old_v")
      bn=binding()
      if KIBUVITS_b_DEBUG
         kibuvits_typecheck bn, String, s_fp_file_or_folder
         kibuvits_typecheck bn, String, s_fp_backup_destination_folder
         kibuvits_typecheck bn, [NilClass,Kibuvits_msgc_stack], msgcs
         kibuvits_typecheck bn, String, s_backup_prefix
         if msgcs.class==Kibuvits_msgc_stack
            if msgcs.b_failure
               kibuvits_throw("msgcs.b_failure==true\n"+
               "GUID='b699704c-6af1-430c-94b2-f1a251214ed7'\n")
            end # if
         end # if
      end # if
      kibuvits_assert_does_not_contain_common_special_characters_t1(
      bn,s_backup_prefix)
      b_throw_on_failure=true
      if msgcs.class==Kibuvits_msgc_stack
         b_throw_on_failure=false
      else
         msgcs=Kibuvits_msgc_stack.new
      end # if
      #-----------------------
      # TODO: consider refactoring the next check to a separate function
      rgx_0=/[\/]$/
      if s_fp_file_or_folder.match(rgx_0)
         msg="s_fp_file_or_folder == \n"+s_fp_file_or_folder+
         "\nbut the file or folder name is not allowed to end with a slash\n"
         if b_throw_on_failure
            kibuvits_throw(msg+
            "GUID='76b54e3c-b200-483c-95b2-f1a251214ed7'\n")
         else
            s_default_msg=msg
            s_message_id="e_0"
            b_failure=true
            s_location_marker_GUID="823e793a-7a78-4ada-91b2-f1a251214ed7"
            msgcs.cre(s_default_msg,s_message_id,
            b_failure,s_location_marker_GUID)
            return $kibuvits_lc_emptystring
         end # if
      end # if
      #-----------------------
      Kibuvits_fs.verify_access(s_fp_file_or_folder,"readable",msgcs)
      if msgcs.b_failure
         kibuvits_throw(msgcs.to_s+$kibuvits_lc_linebreak+
         "GUID='10be5662-1f7a-4b0e-b9a2-f1a251214ed7'\n")
      end # if
      s_fp_dest_parent_folder=nil
      if s_fp_backup_destination_folder==$kibuvits_lc_dot
         s_fp=nil
         begin
            s_fp=Pathname.new(s_fp_file_or_folder).realpath.parent.to_s
         rescue Exception => e
            # It might be that the file or folder does
            # not exist and if that's the case, the "realpath"
            # part of the s_fp=... line throws.
            if b_throw_on_failure
               kibuvits_throw(e.to_s+$kibuvits_lc_linebreak+
               "GUID='1b69761d-e515-42ff-b5a2-f1a251214ed7'\n")
            else
               s_default_msg=e.to_s
               s_message_id="e_1"
               b_failure=true
               s_location_marker_GUID="202f6933-f9aa-47d9-8fa2-f1a251214ed7"
               msgcs.cre(s_default_msg,s_message_id,
               b_failure,s_location_marker_GUID)
               return $kibuvits_lc_emptystring
            end # if
         end # rescue
         Kibuvits_fs.verify_access(s_fp,"is_directory,writable",msgcs)
         if msgcs.b_failure
            if b_throw_on_failure
               kibuvits_throw(msgcs.to_s+$kibuvits_lc_linebreak+
               "GUID='d6f7992e-b3a9-4322-94a2-f1a251214ed7'\n")
            else
               return $kibuvits_lc_emptystring
            end # if
         end # if
         s_fp_dest_parent_folder=s_fp
      else # s_fp_backup_destination_folder != $kibuvits_lc_dot
         Kibuvits_fs.verify_access(s_fp_backup_destination_folder,
         "is_directory,writable",msgcs)
         if msgcs.b_failure
            if b_throw_on_failure
               kibuvits_throw(msgcs.to_s+$kibuvits_lc_linebreak+
               "GUID='39587e27-3cfd-46e9-b1a2-f1a251214ed7'\n")
            else
               return $kibuvits_lc_emptystring
            end # if
         end # if
         s_fp_dest_parent_folder=s_fp_backup_destination_folder
      end # if
      #-----------------------
      s_fp_backup_copy=exm_s_create_backup_copy_t1_create_s_fp_dest(
      s_fp_dest_parent_folder,s_backup_prefix,
      s_fp_file_or_folder,b_throw_on_failure,msgcs)
      #----
      if msgcs.b_failure
         if b_throw_on_failure
            kibuvits_throw(msgcs.to_s+$kibuvits_lc_linebreak+
            "GUID='47591733-3670-4b93-b1a2-f1a251214ed7'\n")
         else
            return $kibuvits_lc_emptystring
         end # if
      end # if
      #-----------------------
      return s_fp_backup_copy if File.exists? s_fp_backup_copy
      cmd=("cp -f -R "+s_fp_file_or_folder)+($kibuvits_lc_space+s_fp_backup_copy)
      ht_stdstreams=kibuvits_sh(cmd)
      s_stderr=ht_stdstreams[$kibuvits_lc_s_stderr]
      if 0<s_stderr.length
         if b_throw_on_failure
            Kibuvits_shell.throw_if_stderr_has_content_t1(ht_stdstreams,
            "GUID='ca24eefb-6f8e-468d-85a2-f1a251214ed7'\n")
         else
            s_default_msg=s_stderr
            s_message_id="e_2"
            b_failure=true
            s_location_marker_GUID="7a67671d-35d7-4812-83a2-f1a251214ed7"
            msgcs.cre(s_default_msg,s_message_id,
            b_failure,s_location_marker_GUID)
            return $kibuvits_lc_emptystring
         end # if
      end # if
      return s_fp_backup_copy
   end # exm_s_create_backup_copy_t1

   def Kibuvits_file_intelligence.exm_s_create_backup_copy_t1(
      s_fp_file_or_folder,s_fp_backup_destination_folder=$kibuvits_lc_dot,
      msgcs=nil,s_backup_prefix="old_v")
      s_fp_backup_copy=Kibuvits_file_intelligence.instance.exm_s_create_backup_copy_t1(
      s_fp_file_or_folder,s_fp_backup_destination_folder,
      msgcs,s_backup_prefix)
      return s_fp_backup_copy
   end # Kibuvits_file_intelligence.exm_s_create_backup_copy_t1

   #--------------------------------------------------------------------------

   include Singleton

end # class Kibuvits_file_intelligence

#==========================================================================
