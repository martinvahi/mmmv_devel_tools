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
BREAKDANCEMAKE_ROUTINE_PSEUDOCRON_INCLUDED=true

require 'pathname'

if !defined? BREAKDANCEMAKE_HOME
   BREAKDANCEMAKE_HOME=Pathname.new(__FILE__).realpath.parent.parent.parent.parent.to_s.freeze
end # if
require BREAKDANCEMAKE_HOME+"/src/bonnet/lib/breakdancemake_inclusions.rb"

#==========================================================================
if !defined? BREAKDANCEMAKE_ROUTINE_PSEUDOCRON_INCLUDED_UI_TEXTS_INCLUDED
   require Pathname.new(__FILE__).realpath.parent.to_s+"/lib/bdmroutine_ui_texts.rb"
end # if

#--------------------------------------------------------------------------

class Breakdancemake_bdmroutine_pseudocron < Breakdancemake_bdmroutine
   def initialize
      super
      @s_bdmcomponent_name="pseudocron".freeze
      @s_lc_mode_run_bash_t1="run_bash_t1".freeze
      #-------------------------

      @ht_job_names_t1=Hash.new
      @ht_job_names_t1[@s_lc_mode_run_bash_t1]=@s_lc_mode_run_bash_t1

      @ob_ui_texts=Breakdancemake_bdmroutine_pseudocron_ui_texts.new(
      @s_bdmcomponent_name)
      #-------------
      # The ht_dependency_relations conforms to the
      # dependency graph format of the Kibuvits_dependencymetrics_t1
      #@ht_dependency_relations[@s_bdmcomponent_name]=[]
      #@ht_dependency_relations["sun_java"]=nil
      #-------------
      @ht_grammar_run_bash_t1=Hash.new
      @ht_grammar_run_bash_t1[$kibuvits_lc_mm_i_n_of_seconds]=1
      @ht_grammar_run_bash_t1[$kibuvits_lc_mm_i_n_of_minutes]=1
      @ht_grammar_run_bash_t1[$kibuvits_lc_mm_i_n_of_hours]=1
      @ht_grammar_run_bash_t1[$kibuvits_lc_mm_i_n_of_days]=1
      @ht_grammar_run_bash_t1[$kibuvits_lc_mm_i_interval_in_seconds]=1

      @ht_grammar_build_from_templates_t1=Kibuvits_htoper.ht_clone_with_shared_references(
      @ht_grammar_run_bash_t1)
      @ht_grammar_run_bash_t1[$kibuvits_lc_mm_s_bash_command]=1
      @s_lc_s_fp_project_home="--s_fp_project_home".freeze
      @ht_grammar_build_from_templates_t1[@s_lc_s_fp_project_home]=1
      #-------------
      ar_s_intkeys=Array.new
      ar_s_intkeys<<$kibuvits_lc_mm_i_n_of_seconds
      ar_s_intkeys<<$kibuvits_lc_mm_i_n_of_minutes
      ar_s_intkeys<<$kibuvits_lc_mm_i_n_of_hours
      ar_s_intkeys<<$kibuvits_lc_mm_i_n_of_days
      ar_s_intkeys<<$kibuvits_lc_mm_i_interval_in_seconds
      @ar_s_intkeys=ar_s_intkeys
   end #initialize

   #-----------------------------------------------------------------------
   protected

   def b_assess_bdmcomponent_availability(ht_cycle_detection_opmem,
      fd_threshold)
      # TODO: the answer depends on jobs, so job specific
      # checks have to be added here.
      b_ready_for_use=true
      return b_ready_for_use
   end # b_assess_bdmcomponent_availability

   public

   def s_status(s_language)
      # The status message depends on the jobs.
      # Currently this bdmroutine is always available.
      s_out=breakdancemake_bdmroutine_s_status_always_available_t1(s_language)
      return s_out
   end # s_status

   def s_summary_for_identities(s_language)
      s_out=@ob_ui_texts.s_summary_for_identities(s_language)
      return s_out
   end # s_summary_for_identities

   def b_requires_runtime_configuration
      return false
   end # b_requires_runtime_configuration

   #-----------------------------------------------------------------------

   private

   def argv2var(s_language,ar_parameters,ht_grammar)
      ht_args=Kibuvits_argv_parser.run(ht_grammar,ar_parameters,@msgcs)
      #------------
      i_n_of_seconds=7200
      if ht_args[$kibuvits_lc_mm_i_n_of_seconds]!=nil
         i_n_of_seconds=ht_args[$kibuvits_lc_mm_i_n_of_seconds][0].to_i
      end # if
      i_n_of_minutes=0
      if ht_args[$kibuvits_lc_mm_i_n_of_minutes]!=nil
         i_n_of_minutes=ht_args[$kibuvits_lc_mm_i_n_of_minutes][0].to_i
      end # if
      i_n_of_hours=0
      if ht_args[$kibuvits_lc_mm_i_n_of_hours]!=nil
         i_n_of_hours=ht_args[$kibuvits_lc_mm_i_n_of_hours][0].to_i
      end # if
      i_n_of_days=0
      if ht_args[$kibuvits_lc_mm_i_n_of_days]!=nil
         i_n_of_days=ht_args[$kibuvits_lc_mm_i_n_of_days][0].to_i
      end # if
      i_interval_in_seconds=5
      if ht_args[$kibuvits_lc_mm_i_interval_in_seconds]!=nil
         i_interval_in_seconds=ht_args[$kibuvits_lc_mm_i_interval_in_seconds][0].to_i
      end # if
      s_bash_command=""
      if ht_args.has_key? $kibuvits_lc_mm_s_bash_command
         if ht_args[$kibuvits_lc_mm_s_bash_command]!=nil
            s_bash_command=ht_args[$kibuvits_lc_mm_s_bash_command][0].to_s
         end # if
      end # if
      s_fp_project_home=Pathname.new(Dir.getwd).realpath.to_s
      if ht_args.has_key? @s_lc_s_fp_project_home
         if ht_args[@s_lc_s_fp_project_home]!=nil
            s_fp_project_home=ht_args[@s_lc_s_fp_project_home][0].to_s
         end # if
      end # if
      #------------
      ht_out=Hash.new
      ht_out[$kibuvits_lc_mm_i_n_of_seconds]=i_n_of_seconds
      ht_out[$kibuvits_lc_mm_i_n_of_minutes]=i_n_of_minutes
      ht_out[$kibuvits_lc_mm_i_n_of_hours]=i_n_of_hours
      ht_out[$kibuvits_lc_mm_i_n_of_days]=i_n_of_days
      ht_out[$kibuvits_lc_mm_i_interval_in_seconds]=i_interval_in_seconds
      ht_out[$kibuvits_lc_mm_s_bash_command]=s_bash_command
      ht_out[@s_lc_s_fp_project_home]=s_fp_project_home
      #------------
      i_x=nil
      @ar_s_intkeys.each do |s_key|
         i_x=ht_out[s_key]
         if i_x<0
            s_msg=Kibuvits_i18n_msgs_t1.s_msg_negative_value_not_allowed_t1(
            s_language,s_key,i_x)
            kibuvits_writeln s_msg+$kibuvits_lc_doublelinebreak
            exit
         end # if
      end # loop
      #------------
      return ht_out
   end # argv2var

   #-----------------------------------------------------------------------

   def cronloop(ht_vars,s_exit_string,&ob_block)
      ob_func=ob_block
      #----------------
      i_n_of_seconds=ht_vars[$kibuvits_lc_mm_i_n_of_seconds]
      i_n_of_minutes=ht_vars[$kibuvits_lc_mm_i_n_of_minutes]
      i_n_of_hours=ht_vars[$kibuvits_lc_mm_i_n_of_hours]
      i_n_of_days=ht_vars[$kibuvits_lc_mm_i_n_of_days]
      i_interval_in_seconds=ht_vars[$kibuvits_lc_mm_i_interval_in_seconds]
      #----------------
      # THE following, out-commented, code is ready for
      # testing, but the preliminary testing results of the multithreaded
      # version of this code lead to a a memory corruption flaw of
      # the Ruby Virtual Machine.
      #----------------
      # ar_lambthreads=Array.new
      # ob_wolfthread=Thread.new do
      # ar_lambthreads.each{|ob_lambthread| ob_lambthread.kill}
      # end # do
      #----------------
      #ob_lambthread_cronloop=Thread.new do
      i_n_of_hours_impl=i_n_of_days*24+i_n_of_hours
      i_n_of_seconds_impl=i_n_of_hours_impl*3600+
      i_n_of_minutes*60+i_n_of_seconds
      i_n=0
      fd_t_0=nil
      fd_t_1=nil
      s_lc_0="s"
      kibuvits_write "pseudocron iterations:"
      while(i_n<i_n_of_seconds_impl)
         i_n=i_n+i_interval_in_seconds
         kibuvits_write $kibuvits_lc_lschevron
         fd_t_0=Time.now.to_f
         ob_func.call
         fd_t_1=Time.now.to_f
         kibuvits_write((fd_t_1-fd_t_0).round(3).to_s+s_lc_0)
         kibuvits_write $kibuvits_lc_rschevron
         sleep(i_interval_in_seconds)
      end # while
      #ob_wolfthread.run
      #end # thread
      #ar_lambthreads<<ob_lambthread_cronloop
      #----------------
      # Due to a lack of nonblocking keyboard
      # input reader there's no possibility to
      # to use keyboard reading in parallel with
      # threads that write to console or read/write files.
      #
      #
      #ht_str2func=Hash.new
      #ht_str2func[s_exit_string]=kibuvits_dec_lambda do
      #ob_wolfthread.run
      #end # func
      #ob_lambthread_keylogger=Kibuvits_keyboard.ob_thread_gets_t1(ht_str2func)
      #ar_lambthreads<<ob_lambthread_keylogger
      #----------------
      #ar_lambthreads.each{|ob_lambthread| ob_lambthread.run}
      #ob_lambthread_keylogger.join # with current thread
      #ob_lambthread_cronloop.join # with current thread
   end # cronloop

   #-----------------------------------------------------------------------

   def run_bash_t1(s_language,ar_modespecific_params)
      ht_vars=argv2var(s_language,ar_modespecific_params,@ht_grammar_run_bash_t1)
      # The dumb copying is due to the ruby-lang.org flaw #8438, which
      # makes it impossible to use the Kibuvits_htoper.ht2binding(...).
      i_n_of_seconds=ht_vars[$kibuvits_lc_mm_i_n_of_seconds]
      i_n_of_minutes=ht_vars[$kibuvits_lc_mm_i_n_of_minutes]
      i_n_of_hours=ht_vars[$kibuvits_lc_mm_i_n_of_hours]
      i_n_of_days=ht_vars[$kibuvits_lc_mm_i_n_of_days]
      i_interval_in_seconds=ht_vars[$kibuvits_lc_mm_i_interval_in_seconds]
      s_bash_command=ht_vars[$kibuvits_lc_mm_s_bash_command]
      #------------
      s_exit_string="quit"
      s_msg="\n"+
      "\nCurrent parameters:"+ # TODO: i18n it
      "\n"+
      "\n    i_n_of_seconds=="+i_n_of_seconds.to_s+
      "\n    i_n_of_minutes=="+i_n_of_minutes.to_s+
      "\n    i_n_of_hours=="+i_n_of_hours.to_s+
      "\n    i_n_of_days=="+i_n_of_days.to_s+
      "\n    i_interval_in_seconds=="+i_interval_in_seconds.to_s+
      "\n    s_bash_command==\""+s_bash_command.to_s+"\" "+
      "\n"+
      "\n"
      kibuvits_writeln s_msg
      #------------
      s_shell_cmd="cd "+Dir.getwd+" ; nice -n30 "+s_bash_command
      s_cmd="`"+s_shell_cmd+"`"
      s_0=s_bash_command.gsub(/[\s]/,$kibuvits_lc_emptystring)
      s_0=s_0.gsub($kibuvits_lc_semicolon,$kibuvits_lc_emptystring)
      if 0<s_0.length
         cronloop(ht_vars,s_exit_string) do
            eval(s_cmd)
         end # cronloop
      else
         # TODO: i18n it
         kibuvits_writeln "Nothing to execute in Bash.\n\n"
      end # if
   end # run_bash_t1

   #-----------------------------------------------------------------------

   public

   def run_bdmroutine(s_language,ar_parameters,b_started_from_console)
      i_min_n_of_bdmroutine_params=1 # the job name is compulsory
      i_max_n_of_bdmroutine_params=(-1) # params of different jobs may differ
      @ob_breakdancemake.bdmroutine_init_t1(s_language,ar_parameters,
      i_min_n_of_bdmroutine_params,i_max_n_of_bdmroutine_params,self)
      s_job_name=breakdancemake_bdmroutine_s_determine_mode_t1(s_language,
      ar_parameters,@ht_job_names_t1)
      ar_modespecific_params=ar_parameters[1..(-1)]
      case s_job_name
      when @s_lc_mode_run_bash_t1
         run_bash_t1(s_language,ar_modespecific_params);
      else # $kibuvits_lc_s_default_mode
         kibuvits_throw("The bdmroutine \""+@s_bdmcomponent_name+
         "\" does not have an integrated job named \""+s_job_name+"\".")
      end # case s_job_name
   end # run_bdmroutine

end # class Breakdancemake_bdmroutine_pseudocron

#--------------------------------------------------------------------------
ob_bdmroutine=Breakdancemake_bdmroutine_pseudocron.new
Breakdancemake.declare_bdmcomponent(ob_bdmroutine)

#==========================================================================

