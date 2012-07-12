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
   require  KIBUVITS_HOME+"/include/kibuvits_msgc.rb"
   require  KIBUVITS_HOME+"/include/kibuvits_str.rb"
   require  KIBUVITS_HOME+"/bonnet/kibuvits_os_codelets.rb"
   require  KIBUVITS_HOME+"/include/kibuvits_io.rb"
else
   require  "kibuvits_msgc.rb"
   require  "kibuvits_str.rb"
   require  "kibuvits_os_codelets.rb"
   require  "kibuvits_io.rb"
end # if
require "singleton"
require "fileutils"
#==========================================================================

# The class Kibuvits_fs is a namespace for functions that
# deal with filesystem related activities, EXCEPT the IO, which
# is considered to be more general and depends on the filesystem.
class Kibuvits_fs
   @@lc_s_emptystring=""
   @@lc_s_slash="/"
   @@cache=Hash.new
   def initialize
   end #initialize

   private

   def verify_access_create_flagset
      ht_out=Hash.new
      ht_out['exists']=false
      ht_out['does_not_exist']=false
      ht_out['is_directory']=false
      ht_out['is_file']=false
      ht_out['readable']=false
      ht_out['writable']=false
      ht_out['executable']=false
      ht_out['not_readable']=false
      ht_out['not_writable']=false
      ht_out['not_executable']=false
      return ht_out
   end # verify_access_create_flagset

   def verify_access_spec2ht s_checks_specification
      ar=Kibuvits_str.explode s_checks_specification, ","
      # TODO: Make sure that it does not throw with
      # command specifications of ",,,writable", "writable,,readable",
      # "writable,readable,,,,", etc. On the other hand, it must
      # kibuvits_throw with a command specification of ",,,,,".
      ar_cmds=[]
      ar.each{|s| ar_cmds<<Kibuvits_str.trim(s)}
      ht_out=verify_access_create_flagset
      ar_cmds.each do |s_cmd|
         if ht_out.has_key? s_cmd
            ht_out[s_cmd]=true
         else
            kibuvits_throw "The Kibuvits_fs.verify_access does not "+
            "have a command of \""+s_cmd+"\"."
         end # if
      end # loop
      if ht_out['exists']&&ht_out['does_not_exist']
         kibuvits_throw "Kibuvits_fs.verify_access commands "+
         "\"exists\" and \"does_not_exist\" contradict."
      end # if
      if ht_out['is_directory']&&ht_out['is_file']
         kibuvits_throw "Kibuvits_fs.verify_access commands "+
         "\"is_directory\" and \"is_file\" contradict."
      end # if
      if ht_out['readable']&&ht_out['not_readable']
         kibuvits_throw "Kibuvits_fs.verify_access commands "+
         "\"readable\" and \"not_readable\" contradict."
      end # if
      if ht_out['writable']&&ht_out['not_writable']
         kibuvits_throw "Kibuvits_fs.verify_access commands "+
         "\"writable\" and \"not_writable\" contradict."
      end # if
      if ht_out['executable']&&ht_out['not_executable']
         kibuvits_throw "Kibuvits_fs.verify_access commands "+
         "\"executable\" and \"not_executable\" contradict."
      end # if
      #-----the-start-of-policy-based-conflict-checks--
      if ht_out['readable']&&ht_out['does_not_exist']
         kibuvits_throw "Kibuvits_fs.verify_access commands "+
         "\"readable\" and \"does_not_exist\" contradict."
      end # if
      if ht_out['writable']&&ht_out['does_not_exist']
         kibuvits_throw "Kibuvits_fs.verify_access commands "+
         "\"writable\" and \"does_not_exist\" contradict."
      end # if
      if ht_out['executable']&&ht_out['does_not_exist']
         kibuvits_throw "Kibuvits_fs.verify_access commands "+
         "\"executable\" and \"does_not_exist\" contradict."
      end # if
      #---------change-of-group--
      if ht_out['is_directory']&&ht_out['does_not_exist']
         kibuvits_throw "Kibuvits_fs.verify_access commands "+
         "\"is_directory\" and \"does_not_exist\" contradict."
      end # if
      if ht_out['does_not_exist']&&ht_out['is_file']
         kibuvits_throw "Kibuvits_fs.verify_access commands "+
         "\"does_not_exist\" and \"is_file\" contradict."
      end # if
      return ht_out
   end # verify_access_spec2ht

   def verify_access_register_failure(ht_out,s_file_path_candidate,
      s_command, msgc)
      ht_desc=Hash.new
      ht_desc['command']=s_command
      ht_desc['msgc']=msgc
      ar_of_ht_descs=nil
      if ht_out.has_key? s_file_path_candidate
         ar_of_ht_descs=ht_out[s_file_path_candidate]
      else
         ar_of_ht_descs=Array.new
         ht_out[s_file_path_candidate]=ar_of_ht_descs
      end # if
      ar_of_ht_descs<<ht_desc
   end # verify_access_register_failure


   # Edits the ht_out.
   def verify_access_verification_step(s_file_path_candidate,
      ht_cmds, ht_out)
      # There's a command precedence, because one can not
      # check for writability for files that do not exist, etc.
      b_existence_required=ht_cmds['exists']
      b_existence_required=b_existence_required||(ht_cmds['is_directory'])
      b_existence_required=b_existence_required||(ht_cmds['is_file'])
      b_existence_required=b_existence_required||(ht_cmds['readable'])
      b_existence_required=b_existence_required||(ht_cmds['writable'])
      b_existence_required=b_existence_required||(ht_cmds['executable'])
      if !b_existence_required
         if File.exists?(s_file_path_candidate)
            b_is_directory=File.directory?(s_file_path_candidate)
            msgc=Kibuvits_msgc.new
            s_en="File "
            s_en="Directory " if b_is_directory
            msgc['English']=s_en+"with a path of\n\""+s_file_path_candidate+
            "\"\nis required to be missing, but it exists."
            s_ee="Fail "
            s_ee="Kataloog " if b_is_directory
            msgc['Estonian']=s_ee+" rajaga \""+s_file_path_candidate+
            "\" eksisteerib, kuid nõutud on tema puudumine."
            verify_access_register_failure(ht_out,
            s_file_path_candidate, 'does_not_exist', msgc)
         end # if
         return
      end # if
      if !File.exists?(s_file_path_candidate)
         msgc=Kibuvits_msgc.new
         msgc['English']="File or folder with a path of\n\""+
         s_file_path_candidate+"\"\ndoes not exist."
         msgc['Estonian']="Faili ega kataloogi rajaga \""+
         s_file_path_candidate+"\" ei eksisteeri."
         verify_access_register_failure(ht_out,
         s_file_path_candidate, 'exists', msgc)
         return
      end # if
      b_is_directory=File.directory?(s_file_path_candidate)
      s_en="File "
      s_ee="Fail "
      if b_is_directory
         s_en="Folder "
         s_ee="Kataloog "
      end # if
      ht_cmds.each_pair do |s_cmd,b_value|
         if b_value
            case s_cmd
            when "is_directory"
               if !b_is_directory
                  msgc=Kibuvits_msgc.new
                  msgc['English']="\""+s_file_path_candidate+
                  "\" is a file, but a foder is required."
                  msgc['Estonian']=s_ee+" rajaga \""+s_file_path_candidate+
                  "\" on fail, kuid nõutud on kataloog."
                  verify_access_register_failure(
                  ht_out, s_file_path_candidate, s_cmd, msgc)
               end # if
            when "is_file"
               if b_is_directory
                  msgc=Kibuvits_msgc.new
                  msgc['English']="\""+s_file_path_candidate+
                  "\" is a folder, but a file is required."
                  msgc['Estonian']=s_ee+" rajaga \""+s_file_path_candidate+
                  "\" on kataloog, kuid nõutud on fail."
                  verify_access_register_failure(
                  ht_out, s_file_path_candidate, s_cmd, msgc)
               end # if
            when "readable"
               if !File.readable?(s_file_path_candidate)
                  msgc=Kibuvits_msgc.new
                  msgc['English']=s_en+"with the path of\n\""+
                  s_file_path_candidate+"\"\nis not readable."
                  msgc['Estonian']=s_ee+" rajaga \n\""+
                  s_file_path_candidate+"\"\nei ole loetav."
                  verify_access_register_failure(
                  ht_out, s_file_path_candidate, s_cmd, msgc)
               end # if
            when "not_readable"
               if File.readable?(s_file_path_candidate)
                  msgc=Kibuvits_msgc.new
                  msgc['English']=s_en+"with the path of\n\""+
                  s_file_path_candidate+"\"\nis readable."
                  msgc['Estonian']=s_ee+" rajaga \n\""+
                  s_file_path_candidate+"\"\non loetav."
                  verify_access_register_failure(
                  ht_out, s_file_path_candidate, s_cmd, msgc)
               end # if
            when "writable"
               if !File.writable?(s_file_path_candidate)
                  msgc=Kibuvits_msgc.new
                  msgc['English']=s_en+"with the path of\n\""+
                  s_file_path_candidate+"\"\nis not writable."
                  msgc['Estonian']=s_ee+" rajaga \n\""+
                  s_file_path_candidate+"\"\nei ole kirjutatav."
                  verify_access_register_failure(
                  ht_out, s_file_path_candidate, s_cmd, msgc)
               end # if
            when "not_writable"
               if File.writable?(s_file_path_candidate)
                  msgc=Kibuvits_msgc.new
                  msgc['English']=s_en+"with the path of\n\""+
                  s_file_path_candidate+"\"\nis writable."
                  msgc['Estonian']=s_ee+" rajaga \n\""+
                  s_file_path_candidate+"\"\non kirjutatav."
                  verify_access_register_failure(
                  ht_out, s_file_path_candidate, s_cmd, msgc)
               end # if
            when "executable"
               if !File.executable?(s_file_path_candidate)
                  msgc=Kibuvits_msgc.new
                  msgc['English']=s_en+"with the path of\n\""+
                  s_file_path_candidate+"\"\nis not executable."
                  msgc['Estonian']=s_ee+" rajaga \n\""+
                  s_file_path_candidate+"\"\nei ole jookstav."
                  verify_access_register_failure(
                  ht_out, s_file_path_candidate, s_cmd, msgc)
               end # if
            when "not_executable"
               if File.executable?(s_file_path_candidate)
                  msgc=Kibuvits_msgc.new
                  msgc['English']=s_en+"with the path of\n\""+
                  s_file_path_candidate+"\"\nis executable."
                  msgc['Estonian']=s_ee+" rajaga \n\""+
                  s_file_path_candidate+"\"\non jookstav."
                  verify_access_register_failure(
                  ht_out, s_file_path_candidate, s_cmd, msgc)
               end # if
            else
            end # case
         end # if
      end # loop
   end # verify_access_verification_step


   public
   # The s_checks_specification is a commaseparated list of the following
   # flagstrings, but in a way that no conflicting flagstrings reside in
   # the list:
   #
   # exists, does_not_exist, is_directory, is_file,
   #     readable,     writable,     executable,
   # not_readable, not_writable, not_executable
   #
   # An example of a conflicting set is "does_not_exist,writable", because
   # a non-existing file can not possibly be be writable. However,
   # a commandset of "exists,writable" is considered non-conflicting and
   # equivalent to a commandset of "writable", because a folder or a file
   # must exist to be writable.
   #
   # For the sake of helping the software developer to detect
   # logic mistakes, or just plain coding mistakes, a commandset
   # of "does_not_exist,not_readable" is considered to be conflicting, even
   # though it is not conflicting in the real world sense.
   #
   # The Kibuvits_fs.verify_access returns a hashtable.
   #
   # The keys of the hashtable are the file path
   # candidates, in which case at least one of the check commands
   # failed. The values of the hashtable are arrays of hashtables, where
   # ht['command']==<the Kibuvits_fs.verify_access check command>
   # ht['msgc']==<An instance of the Kibuvits_msgc>.
   # The b_failure flag of the msgc is set to true.
   #
   # If all verifications passed, the hashtable length==0.
   def verify_access(arry_of_file_paths_or_a_file_path_string,
      s_checks_specification)
      if KIBUVITS_b_DEBUG
         bn=binding()
         kibuvits_typecheck bn, [Array,String], arry_of_file_paths_or_a_file_path_string
         kibuvits_typecheck bn, String, s_checks_specification
      end # if
      ar_path_candidates=arry_of_file_paths_or_a_file_path_string
      if ar_path_candidates.class==String
         x=ar_path_candidates.length
         kibuvits_throw("String paths can not be empty strings.")if x==0
         ar_path_candidates=[ar_path_candidates]
      else
         ar_path_candidates.each do |s_file_path_candidate|
            x=s_file_path_candidate.length
            kibuvits_throw("String paths can not be empty strings.")if x==0
         end # loop
      end # if
      ht_cmds=verify_access_spec2ht s_checks_specification
      ht_filesystemtest_failures=Hash.new
      ar_path_candidates.each do |s_file_path_candidate|
         verify_access_verification_step(s_file_path_candidate,
         ht_cmds, ht_filesystemtest_failures)
      end # loop
      return ht_filesystemtest_failures
   end # verify_access

   def Kibuvits_fs.verify_access(arry_of_file_paths_or_a_file_path_string,
      s_checks_specification)
      ht_filesystemtest_failures=Kibuvits_fs.instance.verify_access(
      arry_of_file_paths_or_a_file_path_string,s_checks_specification)
      return ht_filesystemtest_failures
   end # Kibuvits_fs.verify_access

   #-----------------------------------------------------------------------

   # The format of the ht_failures matches with the output of the
   # Kibuvits_fs.test_verify_access.
   def access_verification_results_to_string(ht_failures,
      s_language="English")
      if KIBUVITS_b_DEBUG
         bn=binding()
         kibuvits_typecheck bn, Hash, ht_failures
         kibuvits_typecheck bn, String, s_language
      end # if
      s_out=""
      if ht_failures.length==0
         case s_language
         when "Estonian"
            s_out="\nFailisüsteemiga seonduvad testid läbiti edukalt.\n"
         else
            s_out="\nFilesystem related verifications passed.\n"
         end # case
         return s_out
      end # if
      case s_language
      when "Estonian"
         s_out="\nVähemalt osad failisüsteemiga seonduvatest "+
         "testidest põrusid.\n"
      else
         s_out="\nAt least some of the filesystem related tests failed. \n"
      end # case
      ht_failures.each_value do |ar_failures|
         ar_failures.each do |ht_failure|
            s_out=s_out+"\n"+(ht_failure['msgc'])[s_language]+"\n"
         end #loop
      end #loop
      return s_out
   end # access_verification_results_to_string

   def Kibuvits_fs.access_verification_results_to_string(ht_failures,
      s_language="English")
      s_out=Kibuvits_fs.instance.access_verification_results_to_string(
      ht_failures, s_language)
      return s_out
   end # Kibuvits_fs.access_verification_results_to_string

   #-----------------------------------------------------------------------

   def exit_if_any_of_the_filesystem_tests_failed(ht_filesystemtest_failures,
      s_output_message_language="English",b_throw=false)
      if KIBUVITS_b_DEBUG
         bn=binding()
         kibuvits_typecheck bn, Hash, ht_filesystemtest_failures
         kibuvits_typecheck bn, String, s_output_message_language
      end # if
      return if ht_filesystemtest_failures.length==0
      s_msg=Kibuvits_fs.access_verification_results_to_string(
      ht_filesystemtest_failures, s_output_message_language)
      if b_throw
         kibuvits_throw(s_msg+$kibuvits_lc_linebreak)
      else
         puts s_msg+$kibuvits_lc_linebreak
         exit
      end # if
   end # exit_if_any_of_the_filesystem_tests_failed

   def Kibuvits_fs.exit_if_any_of_the_filesystem_tests_failed(
      ht_filesystemtest_failures,s_output_message_language="English",
      b_throw=false)
      Kibuvits_fs.instance.exit_if_any_of_the_filesystem_tests_failed(
      ht_filesystemtest_failures, s_output_message_language,b_throw)
   end # Kibuvits_fs.exit_if_any_of_the_filesystem_tests_failed

   #-----------------------------------------------------------------------

   # This method will probably go through heavy refactoring.
   # It's probably wise to place it to a separate file, because
   # it's seldom needed and will probably take up relatively huge amount
   # of memory due to all of the information that is added about
   # the different file formats.
   def file_extension_2_file_type s_file_extension
      if KIBUVITS_b_DEBUG
         bn=binding()
         kibuvits_typecheck bn, String, s_file_extension
      end # if
      s_key='file_extension_2_file_type_ht_of_relations'
      ht_relations=nil
      if @@cache.has_key? s_key
         ht_relations=@@cache[s_key]
      else
         ht_relations=Hash.new
         ht_relations['rb']='Ruby'
         ht_relations['js']='JavaScript'
         ht_relations['exe']='Windows Executable'
         ht_relations['out']='Linux Executable'
         ht_relations['txt']='Text'
         ht_relations['h']='C Header'
         ht_relations['hpp']='C++ Header'
         ht_relations['c']='C Nonheader'
         ht_relations['cpp']='C++ Nonheader'
         ht_relations['dll']='Windows DLL'
         ht_relations['so']='Linux Binary Library'
         ht_relations['conf']='Configuration file'
         ht_relations['am']='GNU Automake Source'
         ht_relations['py']='Python'
         ht_relations['java']='Java'
         ht_relations['class']='Java Virtual Machine'
         ht_relations['scala']='Scala'
         ht_relations['hs']='Haskell'
         ht_relations['htm']='HTML'
         ht_relations['html']='HTML'
         ht_relations['php']='PHP'
         ht_relations['bat']='Windows Batch'
         ht_relations['xml']='XML'
         ht_relations['json']='JSON'
         ht_relations['yaml']='YAML'
         ht_relations['hdf']='Hierarchical data Format'# http://www.hdfgroup.org/
         ht_relations['hdf5']='Hierarchical data Format 5'
         ht_relations['hdf4']='Hierarchical data Format 4'
         ht_relations['script']='Acapella' # From PerkinElmer's Estonian/German department.
         ht_relations['css']='Cascading Style Sheet'
         ht_relations['jpeg']='Joint Photographic Experts Group'
         ht_relations['jpg']='Joint Photographic Experts Group'
         ht_relations['png']='Portable Network Graphics'
         ht_relations['bmp']='Windows Bitmap'
         ht_relations['ico']='Windows Icon'
         ht_relations['svg']='Scalable Vector Graphics'
         ht_relations['xcf']='GIMP Image'
         ht_relations['tar']='Tape Archive'
         ht_relations['gz']='GNU zip'
         ht_relations['tgz']='GNU zip Compressed tape Archive'
         # TODO: continue the list with bzip2, zip, pdf, doc,odf, etc.
         # This whole thing probably has to be refactored for
         # type classification, like document formats, compression
         # formats, image formats, software sources, binaries, etc.
      end # if
      s_out="undetermined"
      if ht_relations.has_key? s_file_extension.downcase
         s_out=ht_relations[s_file_extension]
      end # if
      return s_out
   end # file_extension_2_file_type

   #-----------------------------------------------------------------------

   def ensure_absolute_path(s_file_path, s_local_pwd_where_the_file_resides)
      if KIBUVITS_b_DEBUG
         bn=binding()
         kibuvits_typecheck bn, String, s_file_path
         kibuvits_typecheck bn, String, s_local_pwd_where_the_file_resides
      end # if
      s_p=s_file_path
      s_local_pwd=s_local_pwd_where_the_file_resides
      s_p=s_local_pwd+"/"+s_p.sub(/^[.][\/]/,"") if s_p[0..0]!="/"
      s_p=s_p.gsub(/[\/]+/,"/")
      # TODO: check, whether the path goes higher than the root.
      # for example, "/../something" is illegal.
      return s_p
   end #ensure_absolute_path

   def Kibuvits_fs.ensure_absolute_path(s_file_path,
      s_local_pwd_where_the_file_resides)
      s_path=Kibuvits_fs.instance.ensure_absolute_path(s_file_path,
      s_local_pwd_where_the_file_resides)
      return s_path
   end # Kibuvits_fs.ensure_absolute_path

   #-----------------------------------------------------------------------

   # An empty array corresponds to a path to the root, i.e. "/".
   #
   # If the s_force_ostype==nil, then the operating system
   # type, i.e. file paths style, is determined by OS detection.
   # Some of the possible s_operating_system_type values are
   # held by the globals $kibuvits_lc_kibuvits_ostype_unixlike and
   # $kibuvits_lc_kibuvits_ostype_windows
   def path2array s_path,s_operating_system_type=nil
      if KIBUVITS_b_DEBUG
         kibuvits_typecheck binding(), String, s_path
      end # if
      ar=nil
      s_ostype=s_operating_system_type
      s_ostype=Kibuvits_os_codelets.get_os_type if s_ostype==nil
      case s_ostype
      when $kibuvits_lc_kibuvits_ostype_unixlike
         ar=Kibuvits_str.explode(s_path,$kibuvits_lc_slash)
      when $kibuvits_lc_kibuvits_ostype_windows
         ar=Kibuvits_str.explode(s_path,$kibuvits_lc_backslash)
      else
         kibuvits_throw("Ostype \""+s_ostype+
         "\" is not yet supported by this method.")
      end # case s_ostype

      # The explosion has side effects: "/x/" is converted to
      # ["","x",""]. The loop below is for compensating them.
      ar_out=Array.new
      i_len=ar.length
      i_max=i_len-1
      i_len.times do |i|
         if i==0
            ar_out<<ar[i] if ar[i]!=""
            next
         end # if
         if i==i_max
            ar_out<<ar[i] if ar[i]!=""
            break # might as well be "next"
         end # if
         if ar[i].length==0
            kibuvits_throw "Empty strings can not be file or "+
            "folder names."
         end # if
         ar_out<<ar[i]
      end # loop
      return ar_out
   end # path2array

   def Kibuvits_fs.path2array(s_path,s_operating_system_type=nil)
      ar_out=Kibuvits_fs.instance.path2array(s_path,s_operating_system_type)
      return ar_out
   end # Kibuvits_fs.path2array

   #-----------------------------------------------------------------------

   def array2path ar
      if KIBUVITS_b_DEBUG
         kibuvits_typecheck binding(), Array, ar
      end # if
      s_p=Kibuvits_str.array2xseparated_list(ar,$kibuvits_lc_slash)
      # ["xx",""]      --> "xx/"
      # ["xx","","yy"] --> "xx//yy"
      s_tmp=s_p+$kibuvits_lc_slash # creates a double-slash from "/xx/".
      i1=s_tmp.length
      i2=s_tmp.gsub(/[\/]+/,$kibuvits_lc_slash).length
      if i1!=i2
         kibuvits_throw "Array contained an empty string, which violates "+
         "the array-encoded path specification. ar==["+
         $kibuvits_lc_slash+Kibuvits_str.array2xseparated_list(ar,", ")+"]."
      end # if
      # Due to a Ruby quirk the next line works also, if s_p==""
      s_p=$kibuvits_lc_slash+s_p if s_p[0..0]!="."
      return s_p
   end # array2path

   def Kibuvits_fs.array2path ar
      s_p=Kibuvits_fs.instance.array2path(ar)
      return s_p
   end # Kibuvits_fs.array2path

   #-----------------------------------------------------------------------

   private

   # The rgx_slash is fed in for speed, because this func is in a loop.
   def array2folders_verify_folder_name_candidate_t1 s_folder_name0, rgx_slash
      if KIBUVITS_b_DEBUG
         kibuvits_typecheck binding(), String, s_folder_name0
      end # if
      if Kibuvits_str.str_contains_spacestabslinebreaks(s_folder_name0)
         kibuvits_throw "Folder name, '"+s_folder_name0+
         "', contained a space or a tab."
      end # if
      s_folder_name1=s_folder_name0.gsub(rgx_slash,@@lc_s_emptystring)
      if s_folder_name0.length!=s_folder_name1.length
         kibuvits_throw "Folder name, '"+s_folder_name0+
         "', contained a slash. For the sake of unambiguity "+
         "the slashes are not allowed."
      end # if
      if s_folder_name1.length==0
         # For some reason the error message is something other than the one here.
         kibuvits_throw "Folder name is not allowed to be an empty string, "+
         " nor is it allowed to consist of only spaces and tabs."
      end # if
   end # array2folders_verify_folder_name_candidate_t1

   public

   # If s_path2folder=='/home/xxx'
   # and ar_folder_names==["aa","bb"]
   # then this method will be equivalent to:
   # "mkdir /home/xxx/aa;"
   # "mkdir /home/xxx/aa/bb;"
   def array2folders_sequential(s_path2folder,ar_folder_names)
      if KIBUVITS_b_DEBUG
         bn=binding()
         kibuvits_typecheck bn, [String], s_path2folder
         kibuvits_typecheck bn, [Array], ar_folder_names
      end # if
      s_base_unix=s_path2folder
      ht_filesystemtest_failures=Kibuvits_fs.verify_access(
      s_base_unix,"is_directory,writable")
      exit_if_any_of_the_filesystem_tests_failed(ht_filesystemtest_failures)
      i_len=ar_folder_names.length
      s_folder_name0=nil
      s_folder_name1=nil
      s_left=s_base_unix.reverse.gsub(/^[\/]/,@@lc_s_emptystring).reverse
      rgx_slash=/\//
      i_len.times do |i|
         s_folder_name0=ar_folder_names[i]
         array2folders_verify_folder_name_candidate_t1 s_folder_name0, rgx_slash
         s_left=s_left+@@lc_s_slash+s_folder_name0
         s_folder_name1=s_left
         Dir.mkdir(s_folder_name1) if !File.exists? s_folder_name1
         ht_filesystemtest_failures=Kibuvits_fs.verify_access(
         s_folder_name1,"is_directory,writable")
         exit_if_any_of_the_filesystem_tests_failed(ht_filesystemtest_failures)
      end # loop
   end # array2folders_sequential

   def Kibuvits_fs.array2folders_sequential(s_path2folder,ar)
      Kibuvits_fs.instance.array2folders_sequential(s_path2folder,ar)
   end # Kibuvits_fs.array2folders_sequential

   #-----------------------------------------------------------------------

   # Reads in the files as strings and concatenates
   # them in the order as the file paths appear in the
   # ar_file_paths
   def s_concat_files(ar_file_paths)
      if KIBUVITS_b_DEBUG
         bn=binding()
         kibuvits_typecheck bn, [Array], ar_file_paths
         ar_file_paths.each do |s_file_path|
            bn=binding()
            kibuvits_typecheck bn, String, s_file_path
            ht_filesystemtest_failures=Kibuvits_fs.verify_access(
            s_file_path,"is_file,readable")
            exit_if_any_of_the_filesystem_tests_failed(ht_filesystemtest_failures,
            s_output_message_language="English",b_throw=false)
         end # loop
      end # if
      ar_s=Array.new
      ar_file_paths.each do |s_file_path|
         ar_s<<file2str(s_file_path)
      end # loop
      s_out=kibuvits_s_concat_array_of_strings(ar_s)
      return s_out
   end # s_concat_files

   def Kibuvits_fs.s_concat_files(ar_file_paths)
      s_out=Kibuvits_fs.instance.s_concat_files(ar_file_paths)
      return s_out
   end # Kibuvits_fs.s_concat_files

   #-----------------------------------------------------------------------

   public
   include Singleton

end # class Kibuvits_fs

#==========================================================================
