#!/opt/ruby/bin/ruby -Ku
#==========================================================================
=begin

 Copyright 2013, martin.vahi@softf1.com that has an
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
BREAKDANCEMAKE_ROUTINE_PSEUDOCRON_INCLUDED_UI_TEXTS_INCLUDED=true
#==========================================================================

# For the i18n.
class Breakdancemake_bdmroutine_pseudocron_ui_texts
   def initialize(s_bdmcomponent_name)
      @s_bdmcomponent_name=s_bdmcomponent_name
   end #initialize

   #--------------------------------------------------------------------------

   def s_summary_for_identities(s_language)
      s_out=nil
      s_EBNF_1=""+ # TODO: i18n it properly.
      "\n"+
      "\n        RUN_BASH_T1:== run_bash_t1 --s_bash_command=<a string> TIMESPEC "+
      "\n"+
      "\n        TIMESPEC:==  TIMESPEC_PART_1 TIMESPEC_PART_2 TIMESPEC_PART_3"+
      "\n        TIMESPEC_PART_1:==  (i_n_of_seconds=<an integer>)? (i_n_of_minutes=<an integer>)?"+
      "\n        TIMESPEC_PART_2:==  (i_n_of_hours=<an integer>)? (i_n_of_days=<an integer>)?"+
      "\n        TIMESPEC_PART_3:==  (i_interval_in_seconds=<an integer>)? "+
      "\n"
      case s_language
      when $kibuvits_lc_et
         s_out="\n"+
         "bdmfunktsioon \""+@s_bdmcomponent_name+"\" on operatsioonisüsteemi \n"+
         "tavaprotsessi põhine cron'i analoog, mis jooksutab vaid endasse  \n"+
         "integreeritud regulaartöid. \n"+
         "\n"+
         "Käivitamine:\n"+
         "\n"+
         "\n        breakdancemake "+@s_bdmcomponent_name+" REGULAARTÖÖKIRJELDUS "+
         "\n"+
         "\n        REGULAARTÖÖKIRJELDUS:== RUN_BASH_T1 "+
         s_EBNF_1+
         "\n"+
         "\n"+
         "\n"
      else # probably s_language=="uk"
         s_out="\n"+
         "The bdmroutine \""+@s_bdmcomponent_name+"\" is a cron analogue that \n"+
         "is based on operating system regular processes and \n"+
         "is able to execute only the jobs that have been integrated with it.\n"+
         "\n"+
         "A command for executing a job:\n"+
         "\n"+
         "\n        breakdancemake "+@s_bdmcomponent_name+" REGULARJOBDESCRIPTION"+
         "\n"+
         "\n        REGULARJOBDESCRIPTION:== RUN_BASH_T1 "+
         s_EBNF_1+
         "\n"+
         "\n"+
         "\n"
      end # case s_language
      return s_out
   end # s_summary_for_identities

   #--------------------------------------------------------------------------

end # class Breakdancemake_bdmroutine_pseudocron_ui_texts
#==========================================================================

