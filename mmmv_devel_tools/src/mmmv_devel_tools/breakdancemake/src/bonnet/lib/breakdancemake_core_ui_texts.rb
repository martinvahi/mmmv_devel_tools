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
BREAKDANCEMAKE_CORE_UI_TEXTS_INCLUDED=true
#==========================================================================
# For the i18n.
class Breakdancemake_core_ui_texts
   def initialize
   end # initialize

   def s_breakdancemake_cl_msg_1(s_language,s_bdmcomponent_name_candidate)
      s_out=nil
      case s_language
      when $kibuvits_lc_et
         s_out="\nbdmfunktsiooni nimega \""+s_bdmcomponent_name_candidate+
         "\" ei leidu. \n"
      else # probably the s_language=="uk"
         s_out="\nbdmroutine named \""+s_bdmcomponent_name_candidate+
         "\" does not exist. \n"
      end # case s_language
      return s_out
   end # s_breakdancemake_cl_msg_1

   #-----------------------------------------------------------------------

   def s_breakdancemake_cl_s_summary_for_identities(s_language)
      s_out=nil
      case s_language
      when $kibuvits_lc_et
         s_out="\nKäsu formaat:\n"+
         "        breakdancemake <bdmfunktsiooni nimi> <bdmfunktsiooni argumendid>\n"+
         "\n"+
         "Käsu formaat kuvamaks kasutusvalmis bdmfunktsioonide nimekirja:\n"+
         "        breakdancemake ls \n"+
         "\n"+
         "Käsu formaat kuvamaks bdmfunktsiooni kirjeldust:\n"+
         "        breakdancemake help <bdmfunktsiooni nimi> \n"+
         "\n\n"
      else # probably the s_language=="uk"
         s_out="\nCall format:\n"+
         "        breakdancemake <bdmroutine name> <bdmroutine arguments>\n"+
         "\n"+
         "Call format for displaying all ready-to-use bdmroutines:\n"+
         "        breakdancemake ls \n"+
         "\n"+
         "Call format for displaying bdmroutine description:\n"+
         "        breakdancemake help <bdmroutine name> \n"+
         "\n\n"
      end # case s_language
      return s_out
   end # s_breakdancemake_cl_s_summary_for_identities

   #-----------------------------------------------------------------------

   def s_breakdancemake_cl_msg_3(s_language,s_routine_name)
      s_out=nil
      case s_language
      when $kibuvits_lc_et
         s_out="\nPaigaldatud breakdancemake versioon ei sisalda \n"+
         "bdmfunktsiooni ega bdmteenuse tuvastajat nimega \""+
         s_routine_name+"\".\n\n"
      else # probably the s_language=="uk"
         s_out="\nThe installed version of the breakdancemake does not \n"+
         "have a bdmroutine or bdmservice detector named \""+
         s_routine_name+"\".\n\n"
      end # case s_language
      return s_out
   end # s_breakdancemake_cl_msg_3

   #-----------------------------------------------------------------------

   def s_breakdancemake_cl_msg_4(s_language,s_routine_name)
      s_out=nil
      case s_language
      when $kibuvits_lc_et
         s_out="\nIga bdmfunktsiooni ning bdmteenuse tuvastaja kohta on lubatud\n"+
         "vaid üks seadistuse deklareerimiskutsung ühe breakdancemake käivituse kohta.\n"+
         "bdmfunktsiooni või bdmteenuse tuvastaja, \""+s_routine_name+"\", korral\n"+
         "üritati antud breakdancemake käivituse korral deklareerida\n"+
         "seadistust rohkem kui üks kord. \n\n"
      else # probably the s_language=="uk"
         s_out="Every bdmroutine and bdmservice detector is allowed to have \n"+
         "at most one configuration declaration attempt per breakdancemake run.\n"+
         "For a bdmroutine or bdmservice detector named \""+s_routine_name+"\"\n"+
         "the number of configuration delcaration attempts exceeded one.\n\n"
      end # case s_language
      return s_out
   end # s_breakdancemake_cl_msg_4

   #-----------------------------------------------------------------------

   def s_breakdancemake_cl_bdmfunction_is_ready_for_use_t1(s_language)
      s_out=nil
      case s_language
      when $kibuvits_lc_et
         s_out="\nAntud bdmfunktsioon on hetkel kasutusvalmis.\n\n"
      else # probably s_language=="uk"
         s_out="\nThis bdmroutine is currently ready for use.\n\n"
      end # case s_language
      return s_out
   end # s_breakdancemake_cl_bdmfunction_is_ready_for_use_t1

   #-----------------------------------------------------------------------

   def s_breakdancemake_cl_bdmfunction_is_inactive_for_undetermined_reasons_t1(
      s_language,s_bdmcomponent_name)
      if KIBUVITS_b_DEBUG
         bn=binding()
         kibuvits_typecheck bn, String, s_language
         kibuvits_typecheck bn, String, s_bdmcomponent_name
      end # if
      s_out=nil
      case s_language
      when $kibuvits_lc_et
         s_out="\nMääratlemata põhjusel ei ole hetkel bdmfunktsioon, \""+
         s_bdmcomponent_name+"\", kasutusvalmis.\n\n"
      else # probably s_language=="uk"
         s_out="\nFor unspecified reasons the bdmroutine, \""+s_bdmcomponent_name+
         "\",\nis currently NOT ready for use.\n\n"
      end # case s_language
      return s_out
   end # s_breakdancemake_cl_bdmfunction_is_inactive_for_undetermined_reasons_t1

   #--------------------------------------------------------------------------

   def s_msg_bdmprojectdescriptor_rb_missing_t1(s_language,s_bdmprojectdescriptor_rb_path)
      s_out=nil
      s_wd=Dir.getwd
      case s_language
      when $kibuvits_lc_et
         s_out="\nFail \""+s_bdmprojectdescriptor_rb_path+
         "\" ei ole töökataloogist (working directory) leitav.\n"+
         "Töökataloogi rada:\n"+s_wd+"\n\n"
      else # probably s_language=="uk"
         s_out="\nThe file \""+s_bdmprojectdescriptor_rb_path+
         "\" could not be found from the working directory.\n"+
         "The path of the working directory:\n"+s_wd+"\n\n"
      end # case s_language
      return s_out
   end # s_msg_bdmprojectdescriptor_rb_missing_t1

   #--------------------------------------------------------------------------

   # The s_file_candidate_type is expected to be
   # an output of the File.ftype(...)
   def s_msg_bdmprojectdescriptor_rb_is_not_a_regular_file_t1(s_language,
      s_path_to_the_bdmprojectdescriptor_rb_candidate,s_file_candidate_type)
      if KIBUVITS_b_DEBUG
         bn=binding()
         kibuvits_typecheck bn, String, s_language
         kibuvits_typecheck bn, String, s_path_to_the_bdmprojectdescriptor_rb_candidate
         kibuvits_typecheck bn, String, s_file_candidate_type
      end # if
      # It's not in the breakdance general set of i18n
      # functions, because it includes the working directory
      # in its message and has a bit more specialized wording.
      s_out=nil
      s_wd=Dir.getwd
      s_ft=Kibuvits_i18n_msgs_t1.s_filetype_to_humanlanguage_t1(s_language,
      s_path_to_the_bdmprojectdescriptor_rb_candidate,s_file_candidate_type)
      case s_language
      when $kibuvits_lc_et
         s_out="\nbdmprojectdescriptor.rb kandidaat, \""+s_path_to_the_bdmprojectdescriptor_rb_candidate+
         "\", ei ole\noperatsioonisüsteemi kontekstis tavapärane fail.\n"+
         "Failikandidaadi tüüp: "+s_ft+"\n\n"
      else # probably s_language=="uk"
         s_out="\nIn the context of an operating system the "+
         "bdmprojectdescriptor.rb\ncandidate, \""+s_path_to_the_bdmprojectdescriptor_rb_candidate+
         "\", is not a regular file.\n"+
         "Detected type of the bdmprojectdescriptor.rb candidate: "+s_ft+"\n\n"
      end # case s_language
      return s_out
   end # s_msg_bdmprojectdescriptor_rb_is_not_a_regular_file_t1

   #-----------------------------------------------------------------------

   def s_msg_bdmprojectdescriptor_rb_misses_configuration_t1(s_language,s_bdmcomponent_name)
      if KIBUVITS_b_DEBUG
         bn=binding()
         kibuvits_typecheck bn, String, s_language
         kibuvits_typecheck bn, String, s_bdmcomponent_name
      end # if
      s_out=nil
      case s_language
      when $kibuvits_lc_et
         s_out="\nFailis bdmprojectdescriptor.rb ei ole korrektselt deklareeritud,\n"+
         "konfiguratsiooni bdmfunktsioonile nimega \""+
         s_bdmcomponent_name+"\".\n\n";
      else # probably s_language=="uk"
         s_out="\nThe file bdmprojectdescriptor.rb does not contain a properly\n"+
         "declared configuration for the bdmfunction named \""+
         s_bdmcomponent_name+"\".\n\n";
      end # case s_language
      return s_out
   end # s_msg_bdmprojectdescriptor_rb_misses_configuration_t1

   #-----------------------------------------------------------------------

   def s_msg_bdmprojectdescriptor_rb_contains_config_for_nonconfiguser_t1(
      s_language,s_bdmcomponent_name)
      if KIBUVITS_b_DEBUG
         bn=binding()
         kibuvits_typecheck bn, String, s_language
         kibuvits_typecheck bn, String, s_bdmcomponent_name
      end # if
      s_out=nil
      case s_language
      when $kibuvits_lc_et
         s_out="\nProjekti seadistustes on deklareeritud,\n"+
         "konfiguratsioon bdmfunktsioonile nimega \""+s_bdmcomponent_name+"\",\n"+
         "kuid antud bdmfunktsiooni isend deklareerib, et ta enda spetsiifilist \n"+
         "konfiguratsiooni projekti seadistustest ühelgi juhtumil ei kasuta.\n\n";
      else # probably s_language=="uk"
         s_out="\nThe file project configuration contains bdmfunction specific \n"+
         "configuration for bdmfunction named \""+s_bdmcomponent_name+"\", but the \n"+
         "bdmfunction instance declares that it does not have any cases, where \n"+
         "it uses self-specific configuration from the project configuration.\n\n"
      end # case s_language
      return s_out
   end # s_msg_bdmprojectdescriptor_rb_contains_config_for_nonconfiguser_t1

   #-----------------------------------------------------------------------

   def s_breakdancemake_cl_bdmfunction_is_inactive_due_to_to_missing_config_t1(
      s_language,s_bdmcomponent_name)
      if KIBUVITS_b_DEBUG
         bn=binding()
         kibuvits_typecheck bn, String, s_language
         kibuvits_typecheck bn, String, s_bdmcomponent_name
      end # if
      s_out=nil
      case s_language
      when $kibuvits_lc_et
         s_out="\nprojektispetsiifilise konfiguratsiooni laadimine õnnestus, kuid sealt puudub bdmfunktsiooni\n"+
         "\""+s_bdmcomponent_name+"\" spetsiifiline konfiguratsiooni deklaratsioon.\n\n"
      else # probably s_language=="uk"
         s_out="\nThe loading of the project specific configuration succeeded, but \n"+
         "it did not contain a bdmfunction specific configuration for \n"+
         "bdmfunction named \""+s_bdmcomponent_name+"\".\n\n"
      end # case s_language
      return s_out
   end # s_breakdancemake_cl_bdmfunction_is_inactive_due_to_to_missing_config_t1

   #-----------------------------------------------------------------------

   def s_breakdancemake_cl_bdmfunction_is_inactive_despite_the_config_availability(
      s_language,s_bdmcomponent_name)
      if KIBUVITS_b_DEBUG
         bn=binding()
         kibuvits_typecheck bn, String, s_language
         kibuvits_typecheck bn, String, s_bdmcomponent_name
      end # if
      s_out=nil
      case s_language
      when $kibuvits_lc_et
         s_out="\nbdmprojectdescriptor.rb laadimine õnnestus, ning \""+s_bdmcomponent_name+"\"\n"+
         "spetsiifilise konfiguratsiooni deklaratsioon samuti leiti, kuid \n"+
         "mingil määratlemata põhjusel ei ole antud bdmfunktsioon kasutusvalmis.\n\n"
      else # probably s_language=="uk"
         s_out="\nThe loading of the file bdmprojectdescriptor.rb succeeded, and \n"+
         "a bdmfunction specific configuration is also found, but for \n"+
         "some undetermined reason the bdmfunction is still not ready for use.\n\n"
      end # case s_language
      return s_out
   end # s_breakdancemake_cl_bdmfunction_is_inactive_despite_the_config_availability

   #-----------------------------------------------------------------------

   def s_breakdancemake_cl_mainconfig_not_derived_from_correct_base_t1(
      s_language,ob_configuration)
      if KIBUVITS_b_DEBUG
         bn=binding()
         kibuvits_typecheck bn, String, s_language
         if ob_configuration.kind_of? Breakdancemake_bdmakefile_base
            kibuvits_throw("ob_configuration.kind_of?"+
            "(Breakdancemake_bdmakefile_base)==true",bn)
         end # if
      end # if
      s_cl_name_1=ob_configuration.class.to_s
      s_out=nil
      case s_language
      when $kibuvits_lc_et
         s_out="\nBreakdancemake.declare_from_bdmakefile aksepteerib sisendina vaid konfiguratsiooni-isendeid, \n"+
         "mis on päritud klassist Breakdancemake_bdmakefile_base, kuid \n"+
         "klass "+s_cl_name_1+" ei ole klassi Breakdancemake_bdmakefile_base alamklass.\n\n"
      else # probably s_language=="uk"
         s_out="\nThe Breakdancemake.declare_from_bdmakefile accepts only configuration instances \n"+
         "that are inherited from the class Breakdancemake_bdmakefile_base, but the class \n"+
         s_cl_name_1+" is not inherited from the Breakdancemake_bdmakefile_base.\n\n"
      end # case s_language
      return s_out
   end # s_breakdancemake_cl_mainconfig_not_derived_from_correct_base_t1

   #-----------------------------------------------------------------------

   def s_breakdancemake_cl_dependencies_are_not_met_t1(
      s_language,s_depending_routine_name,s_name_of_the_dependency)
      if KIBUVITS_b_DEBUG
         bn=binding()
         kibuvits_typecheck bn, String, s_language
         kibuvits_typecheck bn, String, s_depending_routine_name
         kibuvits_typecheck bn, String, s_name_of_the_dependency
      end # if
      ob_depending=Breakdancemake.ob_get_routine(s_depending_routine_name)
      ob_dependency=Breakdancemake.ob_get_routine(s_name_of_the_dependency)
      s_dependency_status=ob_dependency.s_status(s_language)
      s_out=nil
      case s_language
      when $kibuvits_lc_et
         if ob_depending.kind_of? Breakdancemake_bdmroutine
            s_out=$kibuvits_lc_linebreak+
            "Vähemalt üks bdmfunktsiooni, \""+
            s_depending_routine_name+"\", sõltuvustest, \n\""+
            s_name_of_the_dependency+"\", ei ole kasutusvalmis. \n"+
            "\n-----"+s_name_of_the_dependency+"---staatuse--kirjelduse--algus----\n"+
            s_dependency_status+
            "-----"+s_name_of_the_dependency+"---staatuse--kirjelduse--lõpp-----\n"+
            "\n"
         else
            if ob_depending.kind_of? Breakdancemake_bdmservice_detector
               s_out=$kibuvits_lc_linebreak+
               "Vähemalt üks bdmteenuse tuvastaja, \""+
               s_depending_routine_name+"\", sõltuvustest, \n\""+
               s_name_of_the_dependency+"\", ei ole kasutusvalmis. \n"+
               "\n-----"+s_name_of_the_dependency+"---staatuse--kirjelduse--algus----\n"+
               s_dependency_status+
               "-----"+s_name_of_the_dependency+"---staatuse--kirjelduse--lõpp-----\n"+
               "\n"
            else
               s_out=$kibuvits_lc_linebreak+
               "Vähemalt üks \""+s_depending_routine_name+"\" sõltuvustest, \n\""+
               s_name_of_the_dependency+"\", ei ole kasutusvalmis. \n"+
               "\n-----"+s_name_of_the_dependency+"---staatuse--kirjelduse--algus----\n"+
               s_dependency_status+
               "-----"+s_name_of_the_dependency+"---staatuse--kirjelduse--lõpp-----\n"+
               "\n"
            end # if
         end # if
      else # probably s_language=="uk"
         if ob_depending.kind_of? Breakdancemake_bdmroutine
            s_out=$kibuvits_lc_linebreak+
            "The bdmroutine, \""+s_depending_routine_name+"\", \n"+
            "has at least one unmet dependency, \""+s_name_of_the_dependency+"\". \n"+
            "\n-----the--start--of--the--"+s_name_of_the_dependency+"---status--description---\n"+
            s_dependency_status+
            "-----the--end----of--the--"+s_name_of_the_dependency+"---status--description---\n"+
            "\n"
         else
            if ob_depending.kind_of? Breakdancemake_bdmservice_detector
               s_out=$kibuvits_lc_linebreak+
               "The bdmservice detector, \""+s_depending_routine_name+"\", \n"+
               "has at least one unmet dependency, \""+s_name_of_the_dependency+"\". \n"+
               "\n-----the--start--of--the--"+s_name_of_the_dependency+"---status--description---\n"+
               s_dependency_status+
               "-----the--end----of--the--"+s_name_of_the_dependency+"---status--description---\n"+
               "\n"
            else
               s_out=$kibuvits_lc_linebreak+
               "The \""+s_depending_routine_name+"\" "+
               "has at least one unmet dependency, \""+s_name_of_the_dependency+"\". \n"+
               "\n-----the--start--of--the--"+s_name_of_the_dependency+"---status--description---\n"+
               s_dependency_status+
               "-----the--end----of--the--"+s_name_of_the_dependency+"---status--description---\n"+
               "\n"
            end # if
         end # if
      end # case s_language
      return s_out
   end # s_breakdancemake_cl_dependencies_are_not_met_t1

   #-----------------------------------------------------------------------

   def s_breakdancemake_cl_config_is_present_but_ht_tasks_is_missing_or_of_wrong_type_t1(
      s_language,s_bdmcomponent_name)
      if KIBUVITS_b_DEBUG
         bn=binding()
         kibuvits_typecheck bn, String, s_language
      end # if
      ob_config=Breakdancemake.get_instance.x_get_configuration_t1(
      s_bdmcomponent_name)
      s_out=$kibuvits_lc_emptystring
      s_sym=:@ht_tasks
      if ob_config.instance_variable_defined? s_sym
         ht_tasks=ob_config.instance_variable_get s_sym
         if ht_tasks.class!=Hash
            case s_language
            when $kibuvits_lc_et
               s_out="\nbdmfunktsiooni, \""+s_bdmcomponent_name+
               "\" seadistus failis bdmprojectdescriptor.rb eksisteerib, ja \nsee sisaldab "+
               "isendivälja nimega \"ht_tasks\", kuid \nht_tasks.class == "+
               ht_tasks.class.to_s+" != Hash.\n\n"
            else # probably s_language=="uk"
               s_out="\nThe configuration for bdmroutine \""+s_bdmcomponent_name+
               "\" exists in the file bdmprojectdescriptor.rb and \nit does contain "+
               "an instance field named \"ht_tasks\", but the \nht_tasks.class=="+
               ht_tasks.class.to_s+" != Hash.\n\n"
            end # case s_language
         end # if
      else
         case s_language
         when $kibuvits_lc_et
            s_out="\nbdmfunktsiooni, \""+s_bdmcomponent_name+
            "\" seadistus failis bdmprojectdescriptor.rb eksisteerib, \nkuid "+
            "see ei sisalda isendivälja nimega \"ht_tasks\".\n\n"
         else # probably s_language=="uk"
            s_out="\nThe configuration for bdmroutine \""+s_bdmcomponent_name+
            "\" exists in the file bdmprojectdescriptor.rb, \nbut it does not contain "+
            "an instance field named \"ht_tasks\".\n\n "
         end # case s_language
      end # if
      return s_out
   end # s_breakdancemake_cl_config_is_present_but_ht_tasks_is_missing_or_of_wrong_type_t1

   #-----------------------------------------------------------------------

   def s_breakdancemake_cl_config_present_but_task_description_is_missing_from_ht_tasks_t1(
      s_language,s_task_name,s_bdmcomponent_name)
      if KIBUVITS_b_DEBUG
         bn=binding()
         kibuvits_typecheck bn, String, s_language
         kibuvits_typecheck bn, String, s_task_name
         kibuvits_typecheck bn, String, s_bdmcomponent_name
      end # if
      s_out=nil
      case s_language
      when $kibuvits_lc_et
         s_out="\nbdmfunktsiooni, \""+s_bdmcomponent_name+
         "\" seadistus failis bdmprojectdescriptor.rb eksisteerib, kuid \n"+
         "seadistusisendi väli, @ht_tasks, ei sisalda ülesande, \""+
         s_task_name+"\", kirjeldust.\n\n"
      else # probably s_language=="uk"
         s_out="\nThe configuration for bdmroutine \""+s_bdmcomponent_name+
         "\" is present in the file bdmprojectdescriptor.rb, but\n"+
         "the configuration instance field, the @ht_tasks, does not contain "+
         "a description for a task named \""+s_task_name+"\".\n\n"
      end # case s_language
      return s_out
   end # s_breakdancemake_cl_config_present_but_task_description_is_missing_from_ht_tasks_t1

   #-----------------------------------------------------------------------

end # class Breakdancemake_core_ui_texts


#==========================================================================

