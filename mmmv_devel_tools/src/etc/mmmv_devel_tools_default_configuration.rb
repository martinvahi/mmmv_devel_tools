
# The mmmv_devel_tools core reads this file in as text
# and runs it with eval.

def mmmv_devel_tools_default_configuration(ht_config)

   s_full_path_1="/tmp/single_source_file.fileextension"
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

   #-----tegeliku--seadistuse--algus-------
   #s_fp_raudrohi_doc="/home/ts2/Projektid/progremise_infrastruktuur/teeke/raudrohi"+
   #"/juur_liivakast/raudrohi/doc"
   s_fp_interact_1_index_php="/home/ts2/m_local/seif/Dokumendikogu/orjat66alane"+
   "/Kandideerimiseks_vajalik/resymeed/interact_1/index.php"
   s_fp_interact_1_main_js="/home/ts2/m_local/seif/Dokumendikogu/orjat66alane"+
   "/Kandideerimiseks_vajalik/resymeed/interact_1/bonnet/main.js"

   s_fp_raudrohi_src="/home/ts2/Projektid/progremise_infrastruktuur/teeke/raudrohi"+
   "/juur_liivakast/raudrohi/src/devel"

   s_fp_raudrohi_tests="/home/ts2/Projektid/progremise_infrastruktuur/teeke/raudrohi"+
   "/juur_liivakast/raudrohi/src/dev_tools/selftests/tests"
   s_fp_tests_main_js="/home/ts2/Projektid/progremise_infrastruktuur/teeke/raudrohi"+
   "/juur_liivakast/raudrohi/src/dev_tools/selftests/bonnet/raudrohi_selftests_main.js"
   ar=Array.new
   ar<<s_fp_raudrohi_tests
   ar<<s_fp_tests_main_js
   ar<<s_fp_raudrohi_src
   ar<<s_fp_interact_1_index_php
   ar<<s_fp_interact_1_main_js

   s_fp_sirel_home="/home/ts2/Projektid/progremise_infrastruktuur/teeke/sirel/juur_liivakast/sirel"
   s_fp_sirel_src=s_fp_sirel_home+"/src/src"
   s_fp_sirel_tests=s_fp_sirel_home+"/src/dev_tools/selftests"
   ar<<s_fp_sirel_src
   ar<<s_fp_sirel_tests
   ht_config["ar_GUID_trace_project_source_folder_paths"]=ar

   s_fp_mmmv_devel_tools_src=MMMV_DEVEL_TOOLS_HOME+"/src"
   s_fp_kibuvits_src=KIBUVITS_HOME+"/src/include"
   s_fp_kibuvits_tests=KIBUVITS_HOME+"/src/dev_tools/selftests"
   ar=[s_fp_kibuvits_src,s_fp_kibuvits_tests,s_fp_mmmv_devel_tools_src]
   ht_config["ar_GUID_trace_project_dependencies_source_folder_paths"]=ar
   #-----tegeliku--seadistuse--l8pp--------

end # mmmv_devel_tools_default_configuration

