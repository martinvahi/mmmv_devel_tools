#!/usr/bin/env ruby
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

# The Breakdancemake_bdmroutine is a parent class of all bdmroutines.
#
# The bdmroutine named "ls", which resides in
# BREAKDANCEMAKE_HOME/src/bdmroutines/ls ,
# serves partly the purpose of being a bdmroutine implementation example.
class Breakdancemake_bdmroutine < Breakdancemake_bdmcomponent
   def initialize
      super
      @s_bdmcomponent_type="bdmroutine".freeze
   end #initialize

   # This method overrides a method from the class Breakdancemake_bdmcomponent.
   # Further comments reside in the source of the Breakdancemake_bdmcomponent.
   def s_summary_for_identities(s_language)
      kibuvits_throw("This method is expected to be over-ridden.")
   end # s_summary_for_identities

   # It returns true, if the bdmroutine is not usable
   # without runtime configuration. If the configuration
   # instance is not fed to the run_bdmroiutine(...), then
   # the breakdancemake will exit with an error message.
   def b_requires_runtime_configuration
      return false
   end # b_requires_runtime_configuration

   # It returns true, if the bdmroutine is executable
   # without a runtime configuration, but the
   # bdmroutine does use the runtime configuration if the
   # runtime configuration is fed to the run_bdmroutine(...).
   def b_optionally_uses_runtime_configuration
      return false
   end # b_optionally_uses_runtime_configuration

   #--------------------------------------------------------------------------

   # This method is called during installation and it
   # is meant for triggering bdmroutine specific installation
   # activities.
   #
   # The s_language is usually "uk", which stands for United Kingdom,
   # or "et", which stands for Estonian. The s_language is relevant
   # here due to a fact that the setup-routines might output
   # some messages or they might even be interactive.
   #
   # To trigger the calling of the update_deployment(...)
   # of all loaded bdmroutines one should use the Breakdancemake.update_deployment(...).
   def update_deployment(s_language)
      # By default there's nothing to be done for this bdmroutine.
   end # update_deployment

   #--------------------------------------------------------------------------

   protected

   # This method, the run_bdmroutine, is the only entry
   # that starts the execution of the bdmroutine.
   #
   # To call a bdmroutine's run_bdmroutine method, one
   # must use the Breakdancemake.run_bdmroutine(...), because
   # the breakdancemake framework applies some accountancy
   # right before and after the execution of this method, the
   # instance(Breakdancemake_bdmroutine).run_bdmroutine .
   #
   # The ar_parameters==ARGV[1..-1], i.e.
   # the ar_parameters misses the ARGV[0] and
   # ar_parameters.size==(ARGV.size-1)
   #
   # The s_language is usually "uk", which stands for United Kingdom,
   # or "et", which stands for Estonian.
   #
   def run_bdmroutine(s_language,ar_parameters,b_started_from_console,
      ht_or_ob_runtime_configuration=nil)
      kibuvits_throw("This method is expected to be over-ridden.")
   end # run_bdmroutine

   #--------------------------------------------------------------------------

   # An implementation of the s_status()
   # for convenience.
   def breakdancemake_bdmroutine_s_status_always_available_t1(s_language)
      s_out=nil
      #if b_ready_for_use()
      case s_language
      when $kibuvits_lc_et
         s_out="\n"+
         "bdmfunktsioon \""+@s_bdmcomponent_name+"\" on alati kasutusvalmis. \n\n"
      else # probably s_language=="uk"
         s_out="\n"+
         "bdmroutine \""+@s_bdmcomponent_name+"\" is always ready for use. \n\n"
      end # case s_language
      #else
      # An explanation, why the bdmroutine is not available.
      #end # if
      return s_out
   end # breakdancemake_bdmroutine_s_status_always_available_t1

   #--------------------------------------------------------------------------

   # Returns a mode name as a string or prints an error
   # message to console and exits.
   #
   # The ar_parameters is the same that the
   # Breakdancemake_bdmroutine.run_bdmroutine receives.
   #
   # The ht_modes is expected to have the valid ar_parameters[0] values as keys
   # and mode names as values, except that it does not have to
   # contain the key-value pair for the mode "s_default_mode", for which
   # the key might be nil.
   def breakdancemake_bdmroutine_s_determine_mode_t1(s_language,
      ar_parameters,ht_modes)
      if KIBUVITS_b_DEBUG
         bn=binding()
         kibuvits_typecheck bn, String, s_language
         kibuvits_typecheck bn, Array, ar_parameters
         kibuvits_typecheck bn, Hash, ht_modes
      end # if
      s_mode=nil
      i_par=ar_parameters.size
      if i_par==0
         s_mode=$kibuvits_lc_s_default_mode
      end # if
      if 1<=i_par
         s_par=ar_parameters[0]
         s_msg=nil
         if !ht_modes.has_key? s_par
            ar_valid_values=Array.new
            ht_modes.each_pair do |key,value|
               ar_valid_values<<key if key.class==String
            end # loop
            s_list=Kibuvits_str.array2xseparated_list(ar_valid_values,", ")
            case s_language
            when $kibuvits_lc_et
               s_msg="\n"+
               "bdmfunktsiooni \""+@s_bdmcomponent_name+"\" 1. parameeter "+
               "omas väärtust \""+s_par+"\",\nkuid toetatud on vaid järgnevad väärtused:\n"+
               s_list+" .\n\n"
            else # probably s_language=="uk"
               s_msg="\n"+
               "The first parameter of the bdmroutine \""+@s_bdmcomponent_name+
               "\" had \na value of \""+s_par+"\", but only the following values are supported:\n"+
               s_list+" .\n\n"
            end # case s_language
            puts s_msg
            exit
         else
            s_mode=ht_modes[s_par]
         end # if
      end # if
      return s_mode
   end # breakdancemake_bdmroutine_s_determine_mode_t1

   #--------------------------------------------------------------------------

   # The length of the ar_parameters is expected to be
   # verified before calling this method.
   # If the ar_parameters.size==0, then it returns the
   #  $breakdancemake_lc_default_task=="default_task"
   #
   # It also performs verification that the config
   # actually contains info about the tasks. It exits with
   # a console message, if the task description is not found.
   def breakdancemake_bdmroutine_s_determine_task_t1(s_language,
      ar_parameters)
      if KIBUVITS_b_DEBUG
         bn=binding()
         kibuvits_typecheck bn, String, s_language
         kibuvits_typecheck bn, Array, ar_parameters
      end # if
      # ob_config existence verification is performed by the
      # framework before running the bdmroutine.
      ob_config=@ob_breakdancemake.x_get_configuration_t1(@s_bdmcomponent_name)
      msg=@ob_core_ui_texts.s_breakdancemake_cl_config_is_present_but_ht_tasks_is_missing_or_of_wrong_type_t1(
      s_language,@s_bdmcomponent_name)
      if msg !=$kibuvits_lc_emptystring
         puts(msg);exit
      end # if
      ht_tasks=ob_config.instance_variable_get :@ht_tasks
      s_task_name=$breakdancemake_lc_default_task
      if !ht_tasks.has_key? s_task_name
         msg=@ob_core_ui_texts.s_breakdancemake_cl_config_present_but_task_description_is_missing_from_ht_tasks_t1(
         s_language,s_task_name,s_bdmcomponent_name)
         puts(msg);exit
      end # if
      return s_task_name if ar_parameters.size==0
      s_task_name=ar_parameters[0]
      if !ht_tasks.has_key? s_task_name
         msg=@ob_core_ui_texts.s_breakdancemake_cl_config_present_but_task_description_is_missing_from_ht_tasks_t1(
         s_language,s_task_name,s_bdmcomponent_name)
         puts(msg);exit
      end # if
      return s_task_name
   end # breakdancemake_bdmroutine_s_determine_task_t1

   #--------------------------------------------------------------------------

   # Outputs a message to console and exits, if the
   # number of bdmroutine parameters is outside of range.
   #
   # The ar_parameters is the same that the
   # Breakdancemake_bdmroutine.run_bdmroutine receives.
   #
   # i_min is the minimum valid number of bdmroutine parameters.
   # For example, if i_min==1, then 1<=ar_parameters.size
   #
   # i_max is the maximum valid number of bdmroutine parameters.
   # For example, if i_max==7, then ar_parameters.size<=7
   # (-1) marks positive infinity, i.e. greater or equal to zero.
   def breakdancemake_bdmroutine_verify_number_of_parameters_t1(s_language,
      ar_parameters,i_min,i_max,s_error_message_suffix=$kibuvits_lc_emptystring)
      if KIBUVITS_b_DEBUG
         bn=binding()
         kibuvits_typecheck bn, String,s_language
         kibuvits_typecheck bn, Array,ar_parameters
         kibuvits_typecheck bn, Fixnum,i_min
         kibuvits_typecheck bn, Fixnum,i_max
         kibuvits_typecheck bn, String,s_error_message_suffix
         if 0<=i_max
            if i_max<i_min
               kibuvits_throw("i_max=="+i_max.to_s+
               " < i_min=="+i_min.to_s)
            end # if
         end # if
         if i_max<(-1)
            kibuvits_throw("i_max=="+i_max.to_s+" < (-1) ")
         end # if
      end # if
      i_par=ar_parameters.size
      if i_par<i_min
         s_msg=nil
         # TODO: Refactor the texts from here to the i18n file
         case s_language
         when $kibuvits_lc_et
            s_msg="\n"+
            "bdmfunktsioonile \""+@s_bdmcomponent_name+"\" anti "+
            i_par.to_s+" parameetrit, kuid \n"+
            "minimaalne toetatud parameetrite arv bdmfunktsiooni \""+
            @s_bdmcomponent_name+"\" korral on "+i_min.to_s+" \n"+
            s_error_message_suffix+
            "\n"
         else # probably s_language=="uk"
            s_msg="\n"+
            "The bdmroutine \""+@s_bdmcomponent_name+"\" was given "+
            i_par.to_s+" parameters, but the\n"+
            "minimum number of parameters that the bdmroutine \""+
            @s_bdmcomponent_name+"\" accepts is "+i_min.to_s+".\n"+
            s_error_message_suffix+
            "\n"
         end # case s_language
         puts s_msg
         exit
      end # if
      if 0<=i_max
         if i_max<i_par
            s_msg=nil
            case s_language
            when $kibuvits_lc_et
               s_msg="\n"+
               "bdmfunktsioonile \""+@s_bdmcomponent_name+"\" anti "+
               i_par.to_s+" parameetrit, kuid \n"+
               "maksimaalne toetatud parameetrite arv bdmfunktsiooni \""+
               @s_bdmcomponent_name+"\" korral on "+i_max.to_s+". \n"+
               s_error_message_suffix+
               "\n"
            else # probably s_language=="uk"
               s_msg="\n"+
               "The bdmroutine \""+@s_bdmcomponent_name+"\" was given "+
               i_par.to_s+" parameters, but the\n"+
               "maximum number of parameters that the bdmroutine \""+
               @s_bdmcomponent_name+"\" accepts is "+i_max.to_s+".\n"+
               s_error_message_suffix+
               "\n"
            end # case s_language
            puts s_msg
            exit
         end # if
      end # if
   end # breakdancemake_bdmroutine_verify_number_of_parameters_t1

   # Exists only for convenience.
   def breakdancemake_b_assess_bdmroutine_availability_t1(
      ht_cycle_detection_opmem,fd_threshold)
      if b_requires_runtime_configuration()
         ob_configuration=Breakdancemake.x_get_configuration_t1(@s_bdmcomponent_name)
         return false if ob_configuration==nil
      end # if
      b_dependencies_are_NOT_ready_for_use,s_name_of_the_unmet_dependency=Breakdancemake.b_s_dependencies_are_met(
      @s_bdmcomponent_name,ht_cycle_detection_opmem,fd_threshold)
      b_ready_for_use=!b_dependencies_are_NOT_ready_for_use
      return b_ready_for_use
   end #breakdancemake_b_assess_bdmroutine_availability_t1

   #--------------------------------------------------------------------------
end # Breakdancemake_bdmroutine

#==========================================================================

