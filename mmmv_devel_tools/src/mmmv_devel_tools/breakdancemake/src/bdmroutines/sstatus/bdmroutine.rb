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
BREAKDANCEMAKE_ROUTINE_SSTATUS_INCLUDED=true

require "rubygems"
require 'pathname'
if !defined? BREAKDANCEMAKE_HOME
   BREAKDANCEMAKE_HOME=Pathname.new($0).realpath.parent.parent.parent.parent.to_s
end # if
require BREAKDANCEMAKE_HOME+"/src/bonnet/lib/breakdancemake_inclusions.rb"

#==========================================================================

# Displays the status of a bdmservice.
class Breakdancemake_bdmroutine_sstatus < Breakdancemake_bdmroutine

   def initialize
      super
      @s_bdmcomponent_name="sstatus".freeze
   end #initialize

   def b_ready_for_use(ht_cycle_detection_opmem=Hash.new,fd_threshold=1.0)
      return true
   end # b_ready_for_use

   def s_status(s_language)
      s_out=breakdancemake_bdmroutine_s_status_always_available_t1(s_language)
      return s_out
   end # s_status

   def s_summary_for_identities(s_language)
      s_out=nil
      case s_language
      when $kibuvits_lc_et
         s_out="\n"+
         "Käsk bdmteenuse seisundi kuvamiseks:\n"+
         "\n"+
         "        breakdancemake "+@s_bdmcomponent_name+" <bdmteenuse nimi>\n"+
         "\n"
      else # probably s_language=="uk"
         s_out="\n"+
         "A command for displaying a bdmservice status:\n"+
         "\n"+
         "        breakdancemake "+@s_bdmcomponent_name+" <bdmservice name>\n"+
         "\n"
      end # case s_language
      return s_out
   end # s_summary_for_identities

   private

   def run_display_default_status_msg_and_exit_if_necessary(s_language,ar_parameters)
      i_len=ar_parameters.size
      s_msg=nil
      b_display_default_status=false
      if i_len==0
         s_msg=s_summary_for_identities(s_language)
         puts s_msg
         exit
      else
         breakdancemake_bdmroutine_verify_number_of_parameters_t1(s_language,
         ar_parameters,1,1,
         s_error_message_suffix=s_summary_for_identities(s_language))
      end # if
      if b_display_default_status
      end # if
   end # run_display_default_status_msg_and_exit_if_necessary

   def run_bdmroutine_attempt_to_serve(s_language,ar_parameters)
      @ob_breakdancemake.load_bdmservice_detector_classes_if_not_already_loaded()
      s_bdmcomponent_name_candidate=ar_parameters[0].gsub(/\n\r/,
      $kibuvits_lc_emptystring)
      s_msg=nil
      ht_bdmservice_detectors=@ob_breakdancemake.ht_bdmservice_detectors
      if !ht_bdmservice_detectors.has_key? s_bdmcomponent_name_candidate
         case s_language
         when $kibuvits_lc_et
            s_msg="\n"+
            "bdmteenust nimega \""+s_bdmcomponent_name_candidate+
            "\" ei leidu.\n\n"
         else # probably s_language=="uk"
            s_msg="\n"+
            "bdmservice named \""+s_bdmcomponent_name_candidate+
            "\" could not be found.\n\n"
         end # case s_language
      else
         ob_bdmservice_detector=ht_bdmservice_detectors[s_bdmcomponent_name_candidate]
         s_msg=ob_bdmservice_detector.s_status(s_language)
      end # if
      puts s_msg
   end # run_bdmroutine_attempt_to_serve

   public

   def run_bdmroutine(s_language,ar_parameters,b_started_from_console)
      run_display_default_status_msg_and_exit_if_necessary(
      s_language,ar_parameters)
      run_bdmroutine_attempt_to_serve(s_language,ar_parameters)
   end # run_bdmroutine

end # class Breakdancemake_bdmroutine_sstatus

#--------------------------------------------------------------------------
ob_bdmroutine=Breakdancemake_bdmroutine_sstatus.new
Breakdancemake.declare_bdmcomponent(ob_bdmroutine)

#==========================================================================

