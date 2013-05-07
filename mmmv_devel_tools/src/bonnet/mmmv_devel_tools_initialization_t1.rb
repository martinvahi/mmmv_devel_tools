#!/opt/ruby/bin/ruby -Ku
#==========================================================================

require "singleton"

# The reason, why the following if-else blocks are not within a function
# is that the Ruby interpreter requires the constant initialization to be
# in the global scope. That does not stop the programmers to try to
# reinitialize the constants, like
#  A_CAT="Miisu"
#  A_CAT="Tom"
# , but, those are the rules.

if !defined? MMMV_DEVEL_TOOLS_HOME
   raise(Exception.new("The Ruby constant, MMMV_DEVEL_TOOLS_HOME, "+
   "should have been defined before the control flow reaches the "+
   "file, from where this exception is thrown."))
   exit
end # if

if !defined? MMMV_DEVEL_TOOLS_VERSION
   MMMV_DEVEL_TOOLS_VERSION="2.0.0"
end # if

if !defined? KIBUVITS_HOME
   # use the local copy of the KRL
   KIBUVITS_HOME=MMMV_DEVEL_TOOLS_HOME+
   "/src/bonnet/lib/kibuvits_ruby_library"
end # if

# A hazy, very brief, test to see, whether the KIBUVITS_HOME
# might have a wrong value.
if !File.exists? KIBUVITS_HOME+"/src/include/kibuvits_boot.rb"
   msg="\nIt seems that the Ruby constant, KIBUVITS_HOME(==\n"+
   KIBUVITS_HOME.to_s+"\n), has a wrong value.\n\n"
   puts msg
   exit
end # if

s_kibuvits_boot_path=KIBUVITS_HOME+"/src/include/kibuvits_boot.rb"
require s_kibuvits_boot_path
require KIBUVITS_HOME+"/src/include/kibuvits_fs.rb"

# Due to a fact that the API of the
# Kibuvits Ruby Library (KRL, http://kibuvits.rubyforge.org/ )
# is allowed to change between different versions,
# applications that use the KRL must be tied to a specific
# version of the KRL.
if !defined? KIBUVITS_s_NUMERICAL_VERSION
   msg="\nThe Ruby constant, KIBUVITS_s_NUMERICAL_VERSION, has not \n"+
   "been defined in the \n"+
   s_kibuvits_boot_path+
   ". That indicates a Kibuvits Ruby Library version mismatch.\n\n"
   puts msg
   exit
end # if
s_expected_KIBUVITS_s_NUMERICAL_VERSION="1.4.0"
if KIBUVITS_s_NUMERICAL_VERSION!=s_expected_KIBUVITS_s_NUMERICAL_VERSION
   msg="\nThis version of the mmmv_devel_tools expects the Ruby constant, \n"+
   "KIBUVITS_s_NUMERICAL_VERSION, to have the value of \""+s_expected_KIBUVITS_s_NUMERICAL_VERSION+"\", \n"+
   "but the KIBUVITS_s_NUMERICAL_VERSION=="+KIBUVITS_s_NUMERICAL_VERSION.to_s+"\n\n"
   puts msg
   exit
end # if

require KIBUVITS_HOME+"/src/include/kibuvits_msgc.rb"


class C_mmmv_devel_tools_global_singleton

   private

   # The KRL io and str are needed for the config file
   # related things, but one wants to use lazy loading.
   def load_KRL_io_str_ix
      if (defined? @b_KRL_io_str_ix_loaded).class!=NilClass
         return if @b_KRL_io_str_ix_loaded
      end # if
      require KIBUVITS_HOME+"/src/include/kibuvits_io.rb"
      require KIBUVITS_HOME+"/src/include/kibuvits_str.rb"
      require KIBUVITS_HOME+"/src/include/kibuvits_ProgFTE.rb"
      @b_KRL_io_str_ix_loaded=true
   end # load_KRL_io_str_ix

   public

   def initialize
      @msgcs_=Kibuvits_msgc_stack.new
      @ht_global_configuration_cache=nil
      @fd_config_reading_time=Time.new(1981).to_f
   end # initialize

   #-----------------------------------------------------------------------
   private

   def mmmv_devel_tools_fallback_configuration(ht_config)
      s_fp=MMMV_DEVEL_TOOLS_HOME+"/src/bonnet/tmp/mmmv_devel_tools_GUID_trace_error_stack.txt"
      ht_config["s_GUID_trace_errorstack_file_path"]=s_fp

      # One path per element.
      # The GUIDs that are found from the error stack will be
      # searched from files that reside in those folders.
      ht_config["ar_GUID_trace_project_source_folder_paths"]=$kibuvits_lc_emptyarray

      # One path per element.
      # The GUIDs that are found from the error stack will be
      # searched from files that reside in those folders.
      ht_config["ar_GUID_trace_project_dependencies_source_folder_paths"]=$kibuvits_lc_emptyarray

      ar_fns=["*.js","*.rb","*.php","*.java","*.cpp","*.c","*.h","*.hpp","*.py","*.bash"]
      ht_config["ar_GUID_trace_file_name_glob_patterns_according_to_Ruby_stdlib_class_Dir_method_glob"]=ar_fns
   end # mmmv_devel_tools_fallback_configuration

   private

   def parse_mmmv_devel_tools_default_configuration(ht_config)
      load_KRL_io_str_ix()
      s_fp_config=MMMV_DEVEL_TOOLS_HOME+"/src/etc/mmmv_devel_tools_default_configuration.rb"
      s_ruby_src=file2str(s_fp_config)
      ar_in=[ht_config]
      s_script=s_ruby_src+$kibuvits_lc_linebreak+
      "ht_config=ar_in[0]\n"+
      "mmmv_devel_tools_default_configuration(ht_config)\n"+
      "ar_out<<ht_config\n"
      ar_out=kibuvits_eval_t1(s_script, ar_in)
      # The ht_config is passed to the eval script by reference,
      # which means that there's no need to "obtain" it "back out".
      # That's achieved by the "magic" of Ruby reflection.
   end # parse_mmmv_devel_tools_default_configuration

   #-----------------------------------------------------------------------

   public

   def msgcs()
      x_out=@msgcs_
      return x_out
   end # msgcs

   def C_mmmv_devel_tools_global_singleton.msgcs()
      msgcs=C_mmmv_devel_tools_global_singleton.instance.msgcs()
      return msgcs
   end # C_mmmv_devel_tools_global_singleton.msgcs()

   #-----------------------------------------------------------------------

   # For displaying in error messages.
   def s_configuration_summary
      ht_config=ht_global_configuration()
      s_ar_1=$kibuvits_lc_emptystring
      ht_config["ar_GUID_trace_project_source_folder_paths"].each do |s_fp|
         s_ar_1=s_ar_1+("     "+s_fp+$kibuvits_lc_linebreak)
      end # loop
      s_ar_2=$kibuvits_lc_emptystring
      ht_config["ar_GUID_trace_project_dependencies_source_folder_paths"].each do |s_fp|
         s_ar_2=s_ar_2+("     "+s_fp+$kibuvits_lc_linebreak)
      end # loop
      i=0;
      s_ar_3="     "
      ht_config["ar_GUID_trace_file_name_glob_patterns_according_to_Ruby_stdlib_class_Dir_method_glob"].each do |s_glob|
         s_ar_3=s_ar_3+(s_glob+"  ")
         i=i+1
         if i==5
            s_ar_3=s_ar_3+($kibuvits_lc_linebreak+"     ")
            i=0;
         end # if
      end # loop

      s_out="\ns_GUID_trace_errorstack_file_path==\n     "+
      ht_config["s_GUID_trace_errorstack_file_path"]+
      "\n\nar_GUID_trace_project_source_folder_paths==\n"+s_ar_1+
      "\n\nar_GUID_trace_project_dependencies_source_folder_paths==\n"+s_ar_2+
      "\nar_GUID_trace_file_name_glob_patterns_according_to_Ruby_stdlib_class_Dir_method_glob==\n"+s_ar_3+
      "\n\n";
      return s_out;
   end # s_configuration_summary

   def C_mmmv_devel_tools_global_singleton.s_configuration_summary()
      s_out=C_mmmv_devel_tools_global_singleton.instance.s_configuration_summary()
      return s_out
   end # C_mmmv_devel_tools_global_singleton.s_configuration_summary()

   #-----------------------------------------------------------------------

   def ht_global_configuration
      # The ht_global_configuration is intentionally not totally cached,
      # because in case of tools that are running in some
      # daemon mode one might want to reparse the config more than
      # once during a single run.
      ht_out=nil
      fd_t_now=Time.now.to_f
      b_parse=false
      b_parse=true if 3<(fd_t_now-@fd_config_reading_time)
      if (b_parse==false) && (@ht_global_configuration_cache==nil)
         kibuvits_throw("\n\nThis code has a flaw. \n"+
         "GUID='7d915146-46e8-4d97-92f7-90a021f13dd7'\n\n")
      end # if
      if b_parse
         ht_out=Hash.new
         mmmv_devel_tools_fallback_configuration(ht_out)
         parse_mmmv_devel_tools_default_configuration(ht_out)
         # Not fully fault tolerant, because client code
         # can still modify the elements of the hashtable,
         # but it's a compromize here.
         ht_cache=Hash.new
         ar=nil
         i_len=nil
         ht_out.each_pair do |x_key,x_value|
            if x_value.class==Array
               ar=Array.new
               i_len=x_value.size
               i_len.times{|i| ar<<x_value[i].freeze }
               ht_cache[x_key]=ar.freeze
            else
               ht_cache[x_key]=x_value
            end # if
         end # loop
         @ht_global_configuration_cache=ht_cache
         @fd_config_reading_time=fd_t_now
      else
         ht_out=@ht_global_configuration_cache.freeze
      end # if
      return ht_out
   end # ht_global_configuration

   def C_mmmv_devel_tools_global_singleton.ht_global_configuration
      ht_out=C_mmmv_devel_tools_global_singleton.instance.ht_global_configuration
      return ht_out
   end # C_mmmv_devel_tools_global_singleton.ht_global_configuration

   def s_config_hash_t1
      ht_config=ht_global_configuration()
      # The ht_config contains arrays, which means
      # that if ProgFTE were used here, the arrays
      # would have to be converted to strings before
      # the Kibuvits_ProgFTE.from_ht(...) could be called.
      s_signature=Marshal.dump(ht_config)
      s_out=kibuvits_s_hash(s_signature)
      return s_out
   end # s_config_hash_t1

   def C_mmmv_devel_tools_global_singleton.s_config_hash_t1
      s_out=C_mmmv_devel_tools_global_singleton.instance.s_config_hash_t1
      return s_out
   end # C_mmmv_devel_tools_global_singleton.s_config_hash_t1

   #-----------------------------------------------------------------------
   private
   def run_renessaator_t1_b_run_on_unmodified_files(
      ar_or_s_fp_additional_folders_and_files_to_watch_for_changes,
      i_observable_files_cache_max_size)
      b_run_on_unmodified_files=true
      b_run_on_unmodified_files=Kibuvits_fs.b_files_that_exist_changed_after_last_check_t1(
      ar_or_s_fp_additional_folders_and_files_to_watch_for_changes,
      i_observable_files_cache_max_size)
      return b_run_on_unmodified_files
   end # run_renessaator_t1_b_run_on_unmodified_files

   public
   # Renessaator code generation blocks may include, depend, on
   # files that are not listed in the ar_or_s_file_paths.
   # Those files should be listed in the
   # ar_or_s_fp_additional_folders_and_files_to_watch_for_changes
   def run_renessaator_t1(ar_or_s_file_paths,
      ar_or_s_fp_additional_folders_and_files_to_watch_for_changes,
      i_observable_files_cache_max_size)
      if KIBUVITS_b_DEBUG
         bn=binding()
         kibuvits_typecheck bn, [Array,String], ar_or_s_file_paths
         kibuvits_typecheck bn, [Array,String], ar_or_s_fp_additional_folders_and_files_to_watch_for_changes
         kibuvits_typecheck bn, [Fixnum,Bignum], i_observable_files_cache_max_size
         if ar_or_s_file_paths.class==String
            kibuvits_assert_string_min_length(bn,ar_or_s_file_paths,2)
         else  # ar_or_s_file_paths.class==Array
            kibuvits_typecheck_ar_content(bn,String,ar_or_s_file_paths)
            # Lazy-hack: one just hopes that
            # the string lengths in the ar_or_s_file_paths are OK.
         end # if
         ar_short=ar_or_s_fp_additional_folders_and_files_to_watch_for_changes
         if ar_short.class==String
            kibuvits_assert_string_min_length(bn,ar_short,2)
         else  # ar_short.class==Array
            kibuvits_typecheck_ar_content(bn,String,ar_short)
         end # if
      end # if
      b_run_on_unmodified_files=run_renessaator_t1_b_run_on_unmodified_files(
      ar_or_s_fp_additional_folders_and_files_to_watch_for_changes,
      i_observable_files_cache_max_size)
      if !defined? @s_run_renessaator_t1_cache_fp
         @s_run_renessaator_t1_cache_fp=MMMV_DEVEL_TOOLS_HOME+
         "/src/bonnet/tmp/mmmv_devel_tools_sys_run_renessaator_t1_cache.txt"
      end # if
      ht_cache=nil
      ar_fp_2_renessaator=nil
      ar_fp=Kibuvits_ix.normalize2array(ar_or_s_file_paths)
      if b_run_on_unmodified_files
         ar_fp_2_renessaator=ar_fp
      else
         if File.exists? @s_run_renessaator_t1_cache_fp
            s_progfte=file2str(@s_run_renessaator_t1_cache_fp)
            ht_cache=Kibuvits_ProgFTE.to_ht(s_progfte)
         else
            ht_cache=Hash.new
         end # if
         ar_fp_2_renessaator=Array.new
         ht_failures=Kibuvits_fs.verify_access(ar_fp,"readable,is_file")
         s_output_message_language="English"
         b_throw=false
         Kibuvits_fs.exit_if_any_of_the_filesystem_tests_failed(ht_failures,
         s_output_message_language, b_throw)
         s_mtime=nil
         ar_fp.each do |s_fp|
            s_mtime=File.mtime(s_fp).to_s
            if ht_cache.has_key? s_fp
               if s_mtime!=ht_cache[s_fp]
                  ar_fp_2_renessaator<<s_fp
               end # if
            else
               ar_fp_2_renessaator<<s_fp
            end # if
         end # loop
      end # if

      if ar_fp_2_renessaator.size==0
         # There's no point for letting the renessaator throw here.
         return
      end # if
      if !defined? @ob_renessaator_ui
         # One of the benefits for creating an instance of the Renessaator
         # over here in stead calling it from console is that this
         # way the startup of a new instance of ruby interpreter
         # is avoided and reparsing of a huge portion of the
         # Kibuvits Ruby Library is avoided.
         require(MMMV_DEVEL_TOOLS_HOME+
         "/src/mmmv_devel_tools/renessaator/src/bonnet/renessaator.rb")
         @ob_renessaator_ui=Renessaator_console_UI.new
      end # if
      #----------------------------------
      # "+" is used in stead of the "concat(...)" due to a Ruby memory corruption flaw
      ar_argv=["--files"]+ar_fp_2_renessaator
      #----------------------------------
      @ob_renessaator_ui.run_by_ar_argv(ar_argv,@msgcs_)
      #------------------------------------------------------
      if ht_cache==nil
         if File.exists? @s_run_renessaator_t1_cache_fp
            s_progfte=file2str(@s_run_renessaator_t1_cache_fp)
            ht_cache=Kibuvits_ProgFTE.to_ht(s_progfte)
         else
            ht_cache=Hash.new
         end # if
      end # if
      # The next line allows more than i_observable_files_cache_max_size files to be cached.
      ht_cache=Hash.new if i_observable_files_cache_max_size<ht_cache.keys.size
      s_mtime=nil
      ar_fp_2_renessaator.each do |s_fp|
         s_mtime=File.mtime(s_fp).to_s
         ht_cache[s_fp]=s_mtime
      end # loop
      s_progfte=Kibuvits_ProgFTE.from_ht(ht_cache)
      str2file(s_progfte,@s_run_renessaator_t1_cache_fp)
   end # run_renessaator_t1

   def C_mmmv_devel_tools_global_singleton.run_renessaator_t1(
      ar_or_s_file_paths,
      ar_or_s_fp_additional_folders_and_files_to_watch_for_changes,
      i_observable_files_cache_max_size)
      C_mmmv_devel_tools_global_singleton.instance.run_renessaator_t1(
      ar_or_s_file_paths,
      ar_or_s_fp_additional_folders_and_files_to_watch_for_changes,
      i_observable_files_cache_max_size)
   end # C_mmmv_devel_tools_global_singleton.run_renessaator_t1

   #-----------------------------------------------------------------------
   private
   def load_breakdancemake_if_not_already_loaded
      return if defined? @b_breakdancemake_loaded
      require(MMMV_DEVEL_TOOLS_HOME+
      "/src/mmmv_devel_tools/breakdancemake/src/bonnet/breakdancemake_cl.rb")
      @b_breakdancemake_loaded=true
   end # load_breakdancemake_if_not_already_loaded

   public

   def run_breakdancemake_concat_t1(
      s_output_file_path,ar_or_s_input_file_paths,s_compress_mode)
      if KIBUVITS_b_DEBUG
         bn=binding()
         kibuvits_typecheck bn, String, s_output_file_path
         kibuvits_typecheck bn, [Array,String], ar_or_s_input_file_paths
         kibuvits_typecheck bn, String, s_compress_mode
         kibuvits_assert_string_min_length(bn,s_output_file_path,1)
         if ar_or_s_input_file_paths.class==String
            kibuvits_assert_string_min_length(bn,ar_or_s_input_file_paths,1)
         else  # ar_or_s_input_file_paths.class==Array
            kibuvits_typecheck_ar_content(bn,String,ar_or_s_input_file_paths)
         end # if
      end # if
      load_breakdancemake_if_not_already_loaded()
      if !defined? @ob_breakdancemake_wrapperhack
         s_bdmcomponent_name="breakdancemake_bdmprojectdescriptor_"+
         "wrapping_hack_for_the_mmmv_devel_tools_singleton_1"
         @ob_breakdancemake_wrapperhack=Breakdancemake_bdmprojectdescriptor_base.new(s_bdmcomponent_name)
      end # if
      ar_fp=Kibuvits_ix.normalize2array(ar_or_s_input_file_paths)
      Breakdancemake.undeclare_all_bdmprojectdescriptors
      ht_config=Hash.new
      ht_config["ar_paths_of_concatenable_files"]=ar_fp
      ht_config["s_concatenation_output_file_path"]=s_output_file_path
      ht_concat_t1=@ob_breakdancemake_wrapperhack.ht_configurations
      ht_concat_t1.clear # should I forget to do it outside of this func
      s_cl_concat_t1="concat_t1"
      ht_concat_t1[s_cl_concat_t1]=ht_config
      ar_argv=[s_cl_concat_t1]
      ar_argv<<($kibuvits_lc_minusminus+s_compress_mode)
      Breakdancemake.declare_bdmcomponent(@ob_breakdancemake_wrapperhack)
      Breakdancemake.run(ar_argv)
      Breakdancemake.undeclare_all_bdmprojectdescriptors
      ht_concat_t1.clear
   end # run_breakdancemake_concat_t1

   def C_mmmv_devel_tools_global_singleton.run_breakdancemake_concat_t1(
      s_output_file_path,ar_or_s_input_file_paths,s_compress_mode)
      C_mmmv_devel_tools_global_singleton.instance.run_breakdancemake_concat_t1(
      s_output_file_path,ar_or_s_input_file_paths,s_compress_mode)
   end # C_mmmv_devel_tools_global_singleton.run_breakdancemake_concat_t1

   #-----------------------------------------------------------------------
   include Singleton
end # class C_mmmv_devel_tools_global_singleton


#==========================================================================

