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
BREAKDANCEMAKE_ROUTINE_SLS_INCLUDED=true

require "rubygems"
require 'pathname'
if !defined? BREAKDANCEMAKE_HOME
   BREAKDANCEMAKE_HOME=Pathname.new($0).realpath.parent.parent.parent.parent.to_s
end # if
require BREAKDANCEMAKE_HOME+"/src/bonnet/lib/breakdancemake_inclusions.rb"

#==========================================================================

class Breakdancemake_bdmroutine_sls < Breakdancemake_bdmroutine

   def initialize
      super
      @s_bdmcomponent_name="sls".freeze
   end #initialize

   def b_ready_for_use(ht_cycle_detection_opmem=Hash.new,fd_threshold=1.0)
      return true # The ls bdmroutine is always available.
   end # b_ready_for_use

   def s_status(s_language)
      s_out=breakdancemake_bdmroutine_s_status_always_available_t1(s_language)
      return s_out
   end # s_status

   private

   def s_determine_mode(s_language,ar_parameters)
      breakdancemake_bdmroutine_verify_number_of_parameters_t1(s_language,
      ar_parameters,0,1)
      ht_modes=Hash.new
      ht_modes["--inactive"]=$kibuvits_lc_s_mode_inactive
      ht_modes["--active"]=$kibuvits_lc_s_mode_active
      s_mode=breakdancemake_bdmroutine_s_determine_mode_t1(s_language,
      ar_parameters,ht_modes)
      s_mode=$kibuvits_lc_s_mode_active if s_mode==$kibuvits_lc_s_default_mode
      return s_mode
   end # s_determine_mode

   def run_bdmroutine_s_list_value1(s_language,s_mode)
      s_out=nil
      if s_mode==$kibuvits_lc_s_mode_active
         case s_language
         when $kibuvits_lc_et
            s_out="\n"+
            "Kasutusvalmis bdmteenused:\n"+
            "\n"
         else # probably s_language=="uk"
            s_out="\n"+
            "A list of bdmservices that are ready for use:\n"+
            "\n"
         end # case s_language
      elsif s_mode==$kibuvits_lc_s_mode_inactive
         case s_language
         when $kibuvits_lc_et
            s_out="\n"+
            "bdmteenused, mis ei ole kasutusvalmis:\n"+
            "\n"
         else # probably s_language=="uk"
            s_out="\n"+
            "A list of bdmservices that are NOT ready for use:\n"+
            "\n"
         end # case s_language
      else
         kibuvits_throw("s_mode==\""+s_mode+
         "\" is not supported by this method.")
      end # if
      return s_out
   end # run_bdmroutine_s_list_value1

   def run_bdmroutine_s_list_value2(s_language,s_mode)
      s_out=nil
      if s_mode==$kibuvits_lc_s_mode_active
         case s_language
         when $kibuvits_lc_et
            s_list="\n"+
            "Kasutusvalmis bdmteenuseid ei leitud.\n"+
            "\n"
         else # probably s_language=="uk"
            s_list="\n"+
            "bdmservices that are ready for use could not be found.\n"+
            "\n"
         end # case s_language
      elsif s_mode==$kibuvits_lc_s_mode_inactive
         case s_language
         when $kibuvits_lc_et
            s_out="\n"+
            "Kõik bdmteenused, mille jaoks eksisteerib bdmteenuse tuvastaja, on kasutusvalmis.\n"+
            "\n"
         else # probably s_language=="uk"
            s_out="\n"+
            "All of the bdmservices that have a bdmdetector are ready for use.\n"+
            "\n"
         end # case s_language
      else
         kibuvits_throw("s_mode==\""+s_mode+
         "\" is not supported by this method.")
      end # if
      return s_out
   end # run_bdmroutine_s_list_value2

   public

   def s_summary_for_identities(s_language)
      s_out=nil
      case s_language
      when $kibuvits_lc_et
         s_out="\n"+
         "Käsk kõikgi kasutusvalmis bdmteenuste kuvamiseks:\n"+
         "\n"+
         "        breakdancemake "+@s_bdmcomponent_name+"\n"+
         "\n"+
         "Andes argumendiks \"--inactive\", kuvatakse loendis vaid \n"+
         "bdmteenuseid, mille kasutusvalmiduse test põrus. Käsu näide:\n"+
         "\n"+
         "        breakdancemake "+@s_bdmcomponent_name+" --inactive\n"+
         "\n"
      else # probably s_language=="uk"
         s_out="\n"+
         "A command for displaying a list of bdmservices that are ready for use:\n"+
         "\n"+
         "        breakdancemake "+@s_bdmcomponent_name+"\n"+
         "\n"+
         "Argument \"--inactive\" triggers a mode, where \n"+
         "the list of bdmservices consists of only those bdmservices that \n"+
         "are considered unavailable. Command example:\n"+
         "\n"+
         "        breakdancemake "+@s_bdmcomponent_name+" --inactive\n"+
         "\n"
      end # case s_language
      return s_out
   end # s_summary_for_identities

   def run_bdmroutine(s_language,ar_parameters,b_started_from_console)
      s_list=nil
      s_mode=s_determine_mode(s_language,ar_parameters)
      s_list=run_bdmroutine_s_list_value1(s_language,s_mode)
      ar_msg=[s_list]
      ar=Array.new
      @ob_breakdancemake.load_bdmservice_detector_classes_if_not_already_loaded()
      ht_bdmservice_detectors=@ob_breakdancemake.ht_bdmservice_detectors
      if s_mode==$kibuvits_lc_s_mode_active
         ht_bdmservice_detectors.each_pair do |s_bdmcomponent_name,ob_bdmservice_detector|
            ar<<s_bdmcomponent_name if ob_bdmservice_detector.b_ready_for_use
         end # loop
      elsif s_mode==$kibuvits_lc_s_mode_inactive
         ht_bdmservice_detectors.each_pair do |s_bdmcomponent_name,ob_bdmservice_detector|
            ar<<s_bdmcomponent_name if !ob_bdmservice_detector.b_ready_for_use
         end # loop
      else
         kibuvits_throw("s_mode==\""+s_mode+
         "\" is not supported by this method.")
      end # if
      b_first=true
      ar.each do |s_bdmcomponent_name|
         if (b_first)
            ar_msg<<s_bdmcomponent_name
            b_first=false
         else
            ar_msg<<(", "+s_bdmcomponent_name)
         end # if
      end # loop
      if ar.size==0
         s_list=run_bdmroutine_s_list_value2(s_language,s_mode)
      else # 0<ar.size
         s_list=kibuvits_s_concat_array_of_strings(ar_msg)+"\n\n"
      end # if
      puts s_list
   end # run_bdmroutine

end # class Breakdancemake_bdmroutine_sls

#--------------------------------------------------------------------------
ob_bdmroutine=Breakdancemake_bdmroutine_sls.new
Breakdancemake.declare_bdmcomponent(ob_bdmroutine)

#==========================================================================

