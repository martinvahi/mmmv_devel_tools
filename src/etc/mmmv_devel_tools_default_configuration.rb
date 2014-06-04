
# The mmmv_devel_tools core reads this file in as text
# and runs it with eval.
if !defined? RAUDROHI_HOME
   RAUDROHI_HOME=ENV["RAUDROHI_HOME"]
end # if

def mmmv_devel_tools_default_configuration(ht_config)

   s_full_path_1="/tmp/single_source_file.fileextension"
   s_full_path_2="/tmp/single_source_file.fileextension"
   s_full_path_3="/tmp/awesome_project_folder"
   ar=[s_full_path_1,s_full_path_2,s_full_path_3]

   # One path per element.
   # The GUIDs that are found from the error stack will be
   # searched from files that reside in those folders.
   ht_config["ar_GUID_trace_folders_and_files_that_will_be_searched_for_GUIDs"]=[] # must be an Array

   # Will override the
   #
   #     ar_GUID_trace_folders_and_files_that_will_be_searched_for_GUIDs
   #
   # It's practically mandatory to use it for excluding
   # the scanning of dependencies that are created by third parites.
   ht_config["ar_GUID_trace_path_prefixes_of_ignorable_folders_and_files"]=[]

   ar_fns=["*.js","*.rb","*.php","*.java","*.cpp","*.c","*.h","*.hpp","*.py","*.bash"]
   ht_config["ar_GUID_trace_file_name_glob_patterns_according_to_Ruby_stdlib_class_Dir_method_glob"]=ar_fns


   #----start-of-an-example-of-a-messy-real-life-case-of-the-configuration---------
   # which is quite messy, but true
   #
   #    #s_fp_raudrohi_doc="/home/ts2/Projektid/progremise_infrastruktuur/teeke/raudrohi"+
   #    #"/juur_liivakast/raudrohi/doc"
   #    s_fp_interact_1_index_php="/home/ts2/m_local/seif/Dokumendikogu/orjat66alane"+
   #    "/Kandideerimiseks_vajalik/resymeed/interact_1/index.php"
   #    s_fp_interact_1_main_js="/home/ts2/m_local/seif/Dokumendikogu/orjat66alane"+
   #    "/Kandideerimiseks_vajalik/resymeed/interact_1/bonnet/main.js"
   #
   #    s_fp_raudrohi_doc_lesson_04=RAUDROHI_HOME+"/doc/examples/lesson_04a_custom_widgets"
   #    s_fp_raudrohi_src=RAUDROHI_HOME+"/src/devel"
   #    s_fp_raudrohi_dev_tools_lib=RAUDROHI_HOME+"/src/dev_tools/lib"
   #    s_fp_raudrohi_tests=RAUDROHI_HOME+"/src/dev_tools/selftests/tests"
   #
   #    s_fp_raudrohi_tests_main_js=RAUDROHI_HOME+
   #    "/src/dev_tools/selftests/bonnet/raudrohi_selftests_main.js"
   #
   #    s_fp_raudrohi_devel_third_party=RAUDROHI_HOME+"/src/devel/third_party"
   #    s_fp_raudrohi_lesson_01a=RAUDROHI_HOME+"doc/examples/lesson_01a_hello_world/bonnet/lib"
   #
   #
   #    s_fp_sirel_home="/home/ts2/Projektid/progremise_infrastruktuur/teeke/sirel/juur_liivakast/sirel"
   #    s_fp_sirel_src=s_fp_sirel_home+"/src/src"
   #    s_fp_sirel_tests=s_fp_sirel_home+"/src/dev_tools/selftests"
   #
   #    s_fp_mmmv_devel_tools_src=MMMV_DEVEL_TOOLS_HOME+"/src"
   #
   #    s_fp_kibuvits_src=KIBUVITS_HOME+"/src/include"
   #    s_fp_kibuvits_tests=KIBUVITS_HOME+"/src/dev_tools/selftests"
   #
   #    s_fp_opt_jetbrains_pmip="/opt/kodukataloogide_k8vaketas/ts2/Projektid/progremise_infrastruktuur/progremise_t66vahendid/mmmv_devel_tools/juur_liivakast/mmmv_devel_tools/src/mmmv_devel_tools/IDE_integration/src/JetBrains/pmip/plugins"
   #
   #    #----------------------------------------
   #
   #    ar=Array.new
   #    ar<<s_fp_raudrohi_tests
   #    ar<<s_fp_raudrohi_tests_main_js
   #    ar<<s_fp_raudrohi_doc_lesson_04
   #    ar<<s_fp_raudrohi_src
   #
   #    ar<<s_fp_interact_1_index_php
   #    ar<<s_fp_interact_1_main_js
   #
   #    ar<<s_fp_sirel_src
   #    ar<<s_fp_sirel_tests
   #
   #
   #    ar<<s_fp_kibuvits_src
   #    ar<<s_fp_kibuvits_tests
   #    #ar<<s_fp_mmmv_devel_tools_src
   #    ht_config["ar_GUID_trace_folders_and_files_that_will_be_searched_for_GUIDs"]=ar
   #
   #    #----------------------------------------
   #
   #    ar=Array.new
   #    ar<<s_fp_raudrohi_devel_third_party
   #    ar<<s_fp_raudrohi_lesson_01a # due to raudrohi
   #    ar<<s_fp_raudrohi_dev_tools_lib # due to the mmmv_devel_tools in the lib
   #    ar<<s_fp_mmmv_devel_tools_src
   #    ar<<s_fp_opt_jetbrains_pmip
   #    ht_config["ar_GUID_trace_path_prefixes_of_ignorable_folders_and_files"]=ar
   #
   #----the-end--of-the--messy-configuration---example----------

end # mmmv_devel_tools_default_configuration
