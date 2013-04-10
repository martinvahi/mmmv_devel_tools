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

if !defined? UPGUID_HOME
   x=ENV["UPGUID_HOME"]
   if (x==nil)||(x=="")
      puts "\nThe environment variable, UPGUID_HOME, \n"+
      "should have been defined in the bash script that calls this ruby file.\n"+
      "GUID=='e23a143c-57a6-4150-a0fe-a11011b13dd7'\n\n"
      exit
   end # if
   UPGUID_HOME=x
end # if

require UPGUID_HOME+"/src/bonnet/upguid_core.rb"

#==========================================================================

class GUID_trace_UpGUID_console_UI
   private
   def init_constants
      @lc_ar_file_paths="ar_file_paths"
      @lc_msgcs="msgcs"
      @lc_guidreplacer_core="lc_guidreplacer_core"
      @lc_run_test='--run-test'
      @lc_dashf='-f'
      @lc_ht_args='ht_args'
      @lc_ht_grammar='ht_grammar'
   end # init_constants

   public
   def initialize
      init_constants
      @s_fp_tests_folder=APPLICATION_STARTERRUBYFILE_PWD+"/files_for_test"
   end #initialize

   private

   def create_ht_opmem
      ht_opmem=Hash.new
      msgcs=Kibuvits_msgc_stack.new
      ht_opmem[@lc_msgcs]=msgcs
      ht_opmem[@lc_guidreplacer_core]=GUID_trace_UpGUID_core.new
      return ht_opmem
   end # create_ht_opmem

   def get_help_message
      s="Console arguments: (-| -f <list of file paths>)"
   end # get_help_message

   def exit_if_failure ht_opmem
      msgcs=ht_opmem[@lc_msgcs]
      return if !msgcs.b_failure
      s=msgcs.to_s+"\n"+get_help_message+"\n\n"
      puts s
      exit
   end # exit_if_failure

   def xo_run_test ht_opmem
      msgcs=ht_opmem[@lc_msgcs]
      ht_grammar=ht_opmem[@lc_ht_grammar]
      ht_args=ht_opmem[@lc_ht_args]
      return if !ht_args.has_key? @lc_run_test
      if ht_args[@lc_run_test]==nil
         ht_grammar.delete(@lc_run_test)
         ht_args.delete(@lc_run_test)
         return
      end # if
      s_test_name=ht_args[@lc_run_test][0]
      ht=Kibuvits_refl.get_methods_by_name(/test_.+/,
      self, 'private', msgcs)
      exit_if_failure ht_opmem
      if !ht.has_key? s_test_name
         ar=Array.new
         ht.each_key{|x| ar<<x}
         s_valid_list=Kibuvits_str.array2xseparated_list(ar)
         s="\nThere is no test with a name of \""+
         s_test_name+"\".\n\n"+
         "Supported values are: "+s_valid_list+".\n\n"
         puts s
         exit
      end # if
      eval(s_test_name,binding())
      exit
   end # xo_run_test

   def xof_do_it_on_files_or_run_test ht_opmem
      msgcs=ht_opmem[@lc_msgcs]
      ht_grammar=Hash.new
      ht_grammar[@lc_dashf]=(-1)
      ht_grammar[@lc_run_test]=1
      ht_opmem[@lc_ht_grammar]=ht_grammar
      ht_args=Kibuvits_argv_parser.run(ht_grammar,ARGV,msgcs)
      exit_if_failure ht_opmem
      ht_opmem[@lc_ht_args]=ht_args
      xo_run_test ht_opmem
      Kibuvits_argv_parser.verify_parsed_input(ht_grammar,ht_args,msgcs)
      exit_if_failure ht_opmem
      guidreplacer_core=ht_opmem[@lc_guidreplacer_core]
      ar_filepath_candidates=ht_args[@lc_dashf]
      ar_filepath_candidates.each do |s_file_path_candidate|
         guidreplacer_core.do_it_on_a_file(s_file_path_candidate)
      end # loop
   end # xof_do_it_on_files_or_run_test

   def test_1
      s_template_file_path=@s_fp_tests_folder+"/template1.txt"
      Kibuvits_apparch_specific.xof_run_bloc_on_a_copy_of_a_template(
      s_template_file_path,@s_fp_tests_folder,self) do |s_tmp_file_path,ob_self|
         sh "ruby "+__FILE__+" -f "+s_tmp_file_path
         s=file2str(s_tmp_file_path)
         puts s
      end # block
   end # test_1

   def test_2
      if Kibuvits_os_codelets.get_os_type!="kibuvits_ostype_unixlike"
         puts "\ntest_2 is supported only on unixlike operating systems.\n\n"
         return
      end # if
      s_template_file_path=@s_fp_tests_folder+"/template1.txt"
      Kibuvits_apparch_specific.xof_run_bloc_on_a_copy_of_a_template(
      s_template_file_path,@s_fp_tests_folder,self) do |s_tmp_file_path,ob_self|
         ht_stdstreams=sh ""+__FILE__+" - < "+s_tmp_file_path
         puts "\nstdout==\n\n"+ht_stdstreams['s_stdout'].to_s+"\n\n"
         puts "\nstderr==\n\n"+ht_stdstreams['s_stderr'].to_s+"\n\n"
      end # block
   end # test_2

   # The same as test_1, except that it feeds in more than
   # one file path candidate.
   def test_3
      s_template_file_path=@s_fp_tests_folder+"/template1.txt"
      Kibuvits_apparch_specific.xof_run_bloc_on_a_copy_of_a_template(
      s_template_file_path,@s_fp_tests_folder,self) do |s_tmp_file_path,ob_self|
         sh "ruby "+__FILE__+" -f "+s_tmp_file_path+" "+s_tmp_file_path
         s=file2str(s_tmp_file_path)
         puts s
      end # block
   end # test_3

   public
   def run
      if ARGV.length==0
         puts get_help_message
         exit
      end # if
      ht_opmem=create_ht_opmem
      if ARGV[0] == "-"
         guidreplacer_core=ht_opmem[@lc_guidreplacer_core]
         guidreplacer_core.do_it_to_the_stream
         exit
      end # if
      xof_do_it_on_files_or_run_test ht_opmem
   end # run

end # class GUID_trace_UpGUID_console_UI

#==========================================================================
rsc=GUID_trace_UpGUID_console_UI.new
s_out=rsc.run


#==========================================================================
