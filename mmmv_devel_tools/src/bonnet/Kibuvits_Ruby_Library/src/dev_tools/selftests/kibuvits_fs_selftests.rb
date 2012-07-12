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
if !defined? KIBUVITS_HOME
   x=ENV['KIBUVITS_HOME']
   KIBUVITS_HOME=x if (x!=nil and x!="")
end # if

require "rubygems"
require "monitor"
if defined? KIBUVITS_HOME
   require  KIBUVITS_HOME+"/include/kibuvits_boot.rb"
   require  KIBUVITS_HOME+"/include/kibuvits_msgc.rb"
   require  KIBUVITS_HOME+"/include/kibuvits_fs.rb"
else
   require  "kibuvits_boot.rb"
   require  "kibuvits_msgc.rb"
   require  "kibuvits_fs.rb"
end # if
#==========================================================================

class Kibuvits_fs_selftests

   def initialize
   end #initialize

   private
   #-----------------------------------------------------------------------

   def Kibuvits_fs_selftests.test_verify_access
      if !kibuvits_block_throws{Kibuvits_fs.verify_access(42,"exists")}
         kibuvits_throw "test 1"
      end # if
      if !kibuvits_block_throws{Kibuvits_fs.verify_access("","exists")}
         kibuvits_throw "test 2"
      end # if
      if !kibuvits_block_throws{Kibuvits_fs.verify_access(["x",""],"exists")}
         kibuvits_throw "test 3"
      end # if
      if !kibuvits_block_throws{Kibuvits_fs.verify_access(["x","s"],42)}
         kibuvits_throw "test 4"
      end # if
      if kibuvits_block_throws{Kibuvits_fs.verify_access(["x","s"],"is_file")}
         kibuvits_throw "test 5"
      end # if
      if kibuvits_block_throws{Kibuvits_fs.verify_access("x","is_file")}
         #Because the rest of the "kibuvits_throw up tests" assume that "x" is OK.
         kibuvits_throw "test 6"
      end # if
      if !kibuvits_block_throws{Kibuvits_fs.verify_access("x","is_file,does_not_exist")}
         kibuvits_throw "test 7"
      end # if
      if !kibuvits_block_throws{Kibuvits_fs.verify_access("x","is_directory,does_not_exist")}
         kibuvits_throw "test 8"
      end # if
      if !kibuvits_block_throws{Kibuvits_fs.verify_access("x","this_command_does_not_exist")}
         kibuvits_throw "test 9"
      end # if
      if !kibuvits_block_throws{Kibuvits_fs.verify_access("x","readable,does_not_exist")}
         kibuvits_throw "test 10"
      end # if
      if !kibuvits_block_throws{Kibuvits_fs.verify_access("x","writable,does_not_exist")}
         kibuvits_throw "test 11"
      end # if
      if !kibuvits_block_throws{Kibuvits_fs.verify_access("x","executable,does_not_exist")}
         kibuvits_throw "test 12"
      end # if
      if !kibuvits_block_throws{Kibuvits_fs.verify_access("x","readable,not_readable")}
         kibuvits_throw "test 13"
      end # if
      if !kibuvits_block_throws{Kibuvits_fs.verify_access("x","writable,not_writable")}
         kibuvits_throw "test 14"
      end # if
      if !kibuvits_block_throws{Kibuvits_fs.verify_access("x","executable,not_executable")}
         kibuvits_throw "test 15"
      end # if
      if !kibuvits_block_throws{Kibuvits_fs.verify_access("x","exists,does_not_exist")}
         kibuvits_throw "test 16"
      end # if
      s_tmp_folder_path=Kibuvits_os_codelets.instance.get_tmp_folder_path
      ht_failures=Kibuvits_fs.verify_access([s_tmp_folder_path],"exists")
      kibuvits_throw "test 17" if ht_failures.length!=0
      s=s_tmp_folder_path+"_nonsense_that42_CaNnotProbablyExist4"
      ht_failures=Kibuvits_fs.verify_access(s,"exists")
      kibuvits_throw "test 18" if ht_failures.length!=1
      ht_failures=Kibuvits_fs.verify_access(s,"exists")
      kibuvits_throw "test 18" if ht_failures.length!=1
      ht_failures=Kibuvits_fs.verify_access(s_tmp_folder_path,"is_directory")
      kibuvits_throw "test 19" if ht_failures.length!=0

      ht_failures=Kibuvits_fs.verify_access(s_tmp_folder_path,"is_file")
      kibuvits_throw "test 20" if ht_failures.length!=1
      ar_failures=ht_failures[s_tmp_folder_path]
      ht_failure=ar_failures[0]
      kibuvits_throw "test 21" if ht_failure['command']!="is_file"
      kibuvits_throw "test 22" if !ht_failure['msgc'].b_failure


=begin
		s_fp=Kibuvits_os_codelets.instance.generate_tmp_file_absolute_path
		str2file("A temporary file created by the "+
			  "Kibuvits_fs.test_verify_access. ",s_fp)
		ht_failures=Kibuvits_fs.verify_access(s_fp,"is_file")
		File.delete(s_fp) # Cleans up before throwing.
		kibuvits_throw "test 23" if ht_failures.length!=0
		ht_failures=Kibuvits_fs.verify_access(s_fp,"does_not_exist")
		kibuvits_throw "test 24" if ht_failures.length!=0
=end
   end # Kibuvits_fs_selftests.test_verify_access

   #-----------------------------------------------------------------------

   def Kibuvits_fs_selftests.test_ensure_absolute_path
      s_fp="./x.txt"
      s_pwd="/tmp"
      if !kibuvits_block_throws{Kibuvits_fs.ensure_absolute_path(42,"/tmp")}
         kibuvits_throw "test 1"
      end # if
      if !kibuvits_block_throws{Kibuvits_fs.ensure_absolute_path("./x.txt",42)}
         kibuvits_throw "test 2"
      end # if
      s=Kibuvits_fs.ensure_absolute_path("./x.txt","/tmp")
      kibuvits_throw "test 3" if s!="/tmp/x.txt"
   end # Kibuvits_fs_selftests.test_ensure_absolute_path

   #-----------------------------------------------------------------------

   def Kibuvits_fs_selftests.test_path2array
      if !kibuvits_block_throws{ Kibuvits_fs.path2array(42)}
         kibuvits_throw "test 1"
      end # if
      ar=Kibuvits_fs.path2array('/a/b')
      kibuvits_throw "test 2" if ar.length!=2
      kibuvits_throw "test 3" if ar[0]!="a"
      kibuvits_throw "test 4" if ar[1]!="b"
      ar=Kibuvits_fs.path2array('/')
      kibuvits_throw "test 5" if ar.length!=0
      ar=Kibuvits_fs.path2array('/a/')
      kibuvits_throw "test 6" if ar.length!=1
      kibuvits_throw "test 7" if ar[0]!="a"
      ar=Kibuvits_fs.path2array("C:\\a\\b",$kibuvits_lc_kibuvits_ostype_windows)
      kibuvits_throw "test 8" if ar.length!=3
      kibuvits_throw "test 9" if ar[0]!="C:"
      kibuvits_throw "test 10" if ar[1]!="a"
      kibuvits_throw "test 11" if ar[2]!="b"
      ar=Kibuvits_fs.path2array("C:\\",$kibuvits_lc_kibuvits_ostype_windows)
      kibuvits_throw "test 13" if ar[0]!="C:"
   end # Kibuvits_fs_selftests.test_path2array

   #-----------------------------------------------------------------------

   def Kibuvits_fs_selftests.test_array2path
      if !kibuvits_block_throws{ Kibuvits_fs.array2path(42)}
         kibuvits_throw "test 1"
      end # if
      if !kibuvits_block_throws{ Kibuvits_fs.array2path(['xx',''])}
         kibuvits_throw "test 2"
      end # if
      ar_results=Array.new
      ar_results<<Kibuvits_fs.array2path(['aa','bb'])
      ar_results<<Kibuvits_fs.array2path([])
      ar_results<<Kibuvits_fs.array2path(['ff'])
      ar_results<<Kibuvits_fs.array2path(['.','gg'])
      ar_results<<Kibuvits_fs.array2path(['..','gg','..'])
      kibuvits_throw "test 3" if ar_results[0]!="/aa/bb"
      kibuvits_throw "test 4" if ar_results[1]!="/"
      kibuvits_throw "test 5" if ar_results[2]!="/ff"
      kibuvits_throw "test 6" if ar_results[3]!="./gg"
      kibuvits_throw "test 7" if ar_results[4]!="../gg/.."
   end # Kibuvits_fs_selftests.test_array2path

   #-----------------------------------------------------------------------

   def Kibuvits_fs_selftests.test_array2folders_sequential
      if !kibuvits_block_throws{Kibuvits_fs.array2folders_sequential(42,["aa"])}
         kibuvits_throw "test 1"
      end # if

      s_tmp_fldr=Kibuvits_os_codelets.get_tmp_folder_path
      s_tmp_fldr_unix=s_tmp_fldr

      # One is not able to do the tests, if the system's temporary
      # folder either does not exist or is not writable.
      ht_filesystemtest_failures=Kibuvits_fs.verify_access(
      s_tmp_fldr,"is_directory,writable")
      if ht_filesystemtest_failures.length!=0
         s_msg=Kibuvits_fs.access_verification_results_to_string(
         ht_filesystemtest_failures)
         kibuvits_throw "test 2, "+s_msg+"\n"
      end # if

      if !kibuvits_block_throws{ Kibuvits_fs.array2folders_sequential(s_tmp_fldr,42)}
         kibuvits_throw "test 3"
      end # if
      if !kibuvits_block_throws{ Kibuvits_fs.array2folders_sequential(s_tmp_fldr,["ff/g"])}
         kibuvits_throw "test 4"
      end # if

      s_tmp_aa=s_tmp_fldr_unix+"/aa"
      if !kibuvits_block_throws{ Kibuvits_fs.array2folders_sequential(s_tmp_fldr,["aa",""])}
         FileUtils::remove_dir(s_tmp_aa)
         kibuvits_throw "test 5"
      end # if
      FileUtils::remove_dir(s_tmp_aa)

      Kibuvits_fs.array2folders_sequential(s_tmp_fldr,["bb","cc"])

      s_pth0=s_tmp_fldr_unix+"/bb"
      s_testcreated_folder_path=s_pth0
      if !File.exists? s_pth0
         kibuvits_throw "test 6"
      end # if
      if !File.directory? s_pth0
         kibuvits_throw "test 7"
      end # if

      s_pth0=s_pth0+"/cc"
      if !File.exists? s_pth0
         FileUtils::remove_dir(s_testcreated_folder_path)
         kibuvits_throw "test 8"
      end # if
      if !File.directory? s_pth0
         FileUtils::remove_dir(s_testcreated_folder_path)
         kibuvits_throw "test 9"
      end # if
      #Dir.rmdir(s_testcreated_folder_path)
      FileUtils::remove_dir(s_testcreated_folder_path)
   end # Kibuvits_fs_selftests.test_array2folders_sequential

   #-----------------------------------------------------------------------

   def Kibuvits_fs_selftests.test_s_concat_files
      s_fp=KIBUVITS_HOME+"/dev_tools/selftests/data_for_selftests/kitty_1.txt"
      s_file_content=file2str(s_fp)
      ar=[s_fp,s_fp+$kibuvits_lc_emptystring,s_fp]
      s_x=Kibuvits_fs.s_concat_files(ar)
      s_2x=s_file_content+s_file_content+s_file_content
      kibuvits_throw "test 1" if s_2x!=s_x
   end # Kibuvits_fs_selftests.test_s_concat_files

   #-----------------------------------------------------------------------

   public
   def Kibuvits_fs_selftests.selftest
      ar_msgs=Array.new
      kibuvits_testeval binding(), "Kibuvits_fs_selftests.test_verify_access"
      kibuvits_testeval binding(), "Kibuvits_fs_selftests.test_ensure_absolute_path"
      kibuvits_testeval binding(), "Kibuvits_fs_selftests.test_path2array"
      kibuvits_testeval binding(), "Kibuvits_fs_selftests.test_array2path"
      kibuvits_testeval binding(), "Kibuvits_fs_selftests.test_array2folders_sequential"
      kibuvits_testeval binding(), "Kibuvits_fs_selftests.test_s_concat_files"
      return ar_msgs
   end # Kibuvits_fs_selftests.selftest

end # class Kibuvits_fs_selftests

#--------------------------------------------------------------------------

#==========================================================================
ar=Kibuvits_fs_selftests.selftest
ar.each{|s| puts s}

