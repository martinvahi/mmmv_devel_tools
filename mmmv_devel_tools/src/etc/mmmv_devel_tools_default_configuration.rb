
# The mmmv_devel_tools core reads this file in as text
# and runs it with eval.

def mmmv_devel_tools_default_configuration(ht_config)

   s_fp="/tmp/mmmv_devel_tools_GUID_trace_errorstack.txt.or_some_smarter_path"
   ht_config["s_GUID_trace_errorstack_file_path"]=s_fp

   s_full_path_1="mmmv_devel_tools_keyword_project_config_not_set"
   s_full_path_2="/tmp/single_source_file.fileextension"
   s_full_path_3="/tmp/awesome_project_folder"
   ar=[s_full_path_1,s_full_path_2,s_full_path_3]
   # One path per element.
   # The GUIDs that are found from the error stack will be
   # searched from files that reside in those folders.
   ht_config["ar_GUID_trace_project_source_folder_paths"]=[] # might/should be ar

   # One path per element.
   # The GUIDs that are found from the error stack will be
   # searched from files that reside in those folders.
   ht_config["ar_GUID_trace_project_dependencies_source_folder_paths"]=[]

   ar_fns=["*.js","*.rb","*.php","*.java","*.cpp","*.c","*.h","*.hpp","*.py","*.bash"]
   ht_config["ar_GUID_trace_file_name_glob_patterns_according_to_Ruby_stdlib_class_Dir_method_glob"]=ar_fns

end # mmmv_devel_tools_default_configuration

