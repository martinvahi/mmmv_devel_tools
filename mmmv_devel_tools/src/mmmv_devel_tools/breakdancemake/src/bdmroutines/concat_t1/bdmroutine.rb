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
BREAKDANCEMAKE_ROUTINE_CONCAT_T1_INCLUDED=true

require 'pathname'

if !defined? BREAKDANCEMAKE_HOME
   BREAKDANCEMAKE_HOME=Pathname.new($0).realpath.parent.parent.parent.parent.to_s
end # if
require BREAKDANCEMAKE_HOME+"/src/bonnet/lib/breakdancemake_inclusions.rb"

#==========================================================================
if !defined? BREAKDANCEMAKE_ROUTINE_CONCAT_T1_UI_TEXTS_INCLUDED
   require BREAKDANCEMAKE_HOME+"/src/bdmroutines/concat_t1/lib/bdmroutine_ui_texts.rb"
end # if

#--------------------------------------------------------------------------

class Breakdancemake_bdmroutine_concat_t1 < Breakdancemake_bdmroutine
   def initialize
      super
      @s_bdmcomponent_name="concat_t1".freeze

      @s_lc_mode_plain="mode_plain".freeze
      @s_lc_mode_yui_compressor_t1="mode_yui_compressor_t1".freeze
      #@s_lc_mode_google_closure_t1="mode_google_closure_t1".freeze

      @ht_modes_t1=Hash.new
      @ht_modes_t1["--plain"]=@s_lc_mode_plain
      @ht_modes_t1["--yui_compressor_t1"]=@s_lc_mode_yui_compressor_t1
      #@ht_modes_t1["--google_closure_t1"]=@s_lc_mode_google_closure_t1

      @ob_ui_texts=Breakdancemake_bdmroutine_concat_t1_ui_texts.new(
      @s_bdmcomponent_name)

      @s_lc_b_dependencies_are_met="b_dependencies_are_met".freeze
      @s_lc_s_name_of_the_unmet_dependency="s_name_of_the_unmet_dependency".freeze

      @ht_dependency_relations["sun_java"]=nil
   end #initialize

   #-----------------------------------------------------------------------
   protected

   def b_assess_bdmcomponent_availability(ht_cycle_detection_opmem,
      fd_threshold)
      b_ready_for_use=breakdancemake_b_assess_bdmroutine_availability_t1(
      ht_cycle_detection_opmem,fd_threshold)
      return b_ready_for_use
      #s_name=ht_x[@s_lc_s_name_of_the_unmet_dependency]
      # TODO: add bdmroutine "concat_t1" config object specific
      #       tests here, i.e. whether all files that are listed, exist.
   end # b_assess_bdmcomponent_availability

   public

   def s_status(s_language)
      ht_x=@ob_breakdancemake.ht_bdmroutine_status_if_bdmprojectdescriptor_rb_is_compulsory_t1(
      s_language,self)
      s_out=ht_x[$kibuvits_lc_s_status]
      s_mode_1=ht_x[$kibuvits_lc_s_mode]
      if (s_mode_1==$kibuvits_lc_s_mode_inactive)
         return s_out
      end # if
      s_mode_2=$kibuvits_lc_s_mode_return_msg
      b_deps_met, msg=Breakdancemake.assertxmsg_dependencies_are_met(
      s_language,@s_bdmcomponent_name,s_mode_2)
      return msg if !b_deps_met
      if s_mode_1==$kibuvits_lc_s_mode_inactive_due_to_undetermined_reason
         # The general version of the flaw:the config object has been
         # loaded, but for some reason the config is not available.
         #
         # The actual reason is that the b_ready_for_use returns false,
         # if the "sun_java" is not available and that that causes the
         # bdmroutine to be unavailable even, if the bdmprojectdescriptor.rb is
         # correctly available with a proper config instance, etc.
         # That's why it's placed after the other dependency checks.
         return s_out
      end # if
      s_out=@ob_core_ui_texts.s_breakdancemake_cl_bdmfunction_is_ready_for_use_t1(
      s_language)
      return s_out
   end # s_status

   def s_summary_for_identities(s_language)
      s_out=@ob_ui_texts.s_summary_for_identities(s_language)
      return s_out
   end # s_summary_for_identities

   def b_requires_runtime_configuration
      return true
   end # b_requires_runtime_configuration

   #-----------------------------------------------------------------------
   private

   def run_b_assemble_a_single_file(ht_bdmroutine_config,b_place_to_tmp_file)
      ar_paths_of_concatenable_files=ht_bdmroutine_config["ar_paths_of_concatenable_files"]
      s_concatenation_output_file_path=ht_bdmroutine_config["s_concatenation_output_file_path"]
      s_content=Kibuvits_fs.s_concat_files(ar_paths_of_concatenable_files)
      if File.exists? s_concatenation_output_file_path
         File.delete(s_concatenation_output_file_path)
      end # if
      s_path=nil
      if b_place_to_tmp_file
         s_path=Kibuvits_os_codelets.generate_tmp_file_absolute_path
      else
         s_path=s_concatenation_output_file_path
      end # if
      str2file(s_content,s_path)
      return s_path
   end # run_b_assemble_a_single_file

   #-----------------------------------------------------------------------

   def run_postprocess_yui_compressor_t1(
      s_concatenation_output_file_path,s_tmp_file_path)
      #s_jarfile_name="yuicompressor-2.4.2.jar" # tried and tested.
      s_jarfile_name="yuicompressor-2.4.8pre.jar"
      s_bash="java -jar "+BREAKDANCEMAKE_HOME+
      "/src/bdmroutines/concat_t1/lib/Yahoo_YUI_Compressor/"+
      s_jarfile_name+" --nomunge --preserve-semi --type js "+
      s_tmp_file_path+" -o "+s_concatenation_output_file_path+
      " ; rm -f "+s_tmp_file_path+" ;"
      ht_stdstreams=sh(s_bash)
      s_stdout=ht_stdstreams[$kibuvits_lc_s_stdout]
      s_stderr=ht_stdstreams[$kibuvits_lc_s_stderr]
      puts s_stdout.to_s+s_stderr.to_s
   end # run_postprocess_yui_compressor_t1

   def run_postprocess_google_closure_t1(
      s_concatenation_output_file_path,s_tmp_file_path)
      # Please do not forget to update the self.s_status()
      # output, when the Google closure compiler option becomes
      # available.
      #
      #java -jar $RAUDROHI_HOME/src/devel/dev_tools/lib/Google_Closure_Compiler_a_version_from_11_2009/compiler.jar --third_party --compilation_level=SIMPLE_OPTIMIZATIONS  --js=$FULL_PATH_TO_THE_NEWLY_ASSEMBLED_FILE --js_output_file=$FULL_PATH_TO_THE_TMP_FILE
      #mv $FULL_PATH_TO_THE_TMP_FILE $FULL_PATH_TO_THE_NEWLY_ASSEMBLED_FILE;
      #rm -f $FULL_PATH_TO_THE_TMP_FILE
      raise(Exception.new( "This method is subject to completion, "+
      "at least some day... :-D "))
   end # run_postprocess_google_closure_t1


   #-----------------------------------------------------------------------
   public

   def run_bdmroutine(s_language,ar_parameters,b_started_from_console)
      breakdancemake_bdmroutine_verify_number_of_parameters_t1(s_language,
      ar_parameters,1,1)
      s_mode=breakdancemake_bdmroutine_s_determine_mode_t1(s_language,
      ar_parameters,@ht_modes_t1)
      @ob_breakdancemake.load_bdmservice_detector_classes_if_not_already_loaded()
      @ob_breakdancemake.assertxmsg_dependencies_are_met(
      s_language,@s_bdmcomponent_name)
      if !b_ready_for_use
         puts s_status(s_language)
         exit
      end # if
      ht_bdmroutine_config=@ob_breakdancemake.x_get_configuration_t1(
      @s_bdmcomponent_name)
      s_concatenation_output_file_path=ht_bdmroutine_config["s_concatenation_output_file_path"]
      case s_mode
      when @s_lc_mode_plain
         b_place_to_tmp_file=false
         run_b_assemble_a_single_file(ht_bdmroutine_config,b_place_to_tmp_file)
         # no postprocessing
      when @s_lc_mode_yui_compressor_t1
         b_place_to_tmp_file=true
         s_tmp_file_path=run_b_assemble_a_single_file(ht_bdmroutine_config,b_place_to_tmp_file)
         run_postprocess_yui_compressor_t1(
         s_concatenation_output_file_path,s_tmp_file_path)
         #when @s_lc_mode_google_closure_t1
         #   b_place_to_tmp_file=true
         #   s_tmp_file_path=run_b_assemble_a_single_file(ht_bdmroutine_config,b_place_to_tmp_file)
         #   run_postprocess_google_closure_t1(
         #   s_concatenation_output_file_path,s_tmp_file_path)
      else # $kibuvits_lc_s_default_mode
         kibuvits_throw("The bdmroutine \""+@s_bdmcomponent_name+
         "\" does not have a mode named \""+s_mode+"\".")
      end # case s_mode

   end # run_bdmroutine

end # class Breakdancemake_bdmroutine_concat_t1

#--------------------------------------------------------------------------
ob_bdmroutine=Breakdancemake_bdmroutine_concat_t1.new
Breakdancemake.declare_bdmcomponent(ob_bdmroutine)

#==========================================================================

