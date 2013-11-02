# Call Eclipse action
# @@name mmmv_devel_tools/run_renessaator_t1
# @@shortcut ALT+SHIFT+r

require 'java'
java_import com.mbartl.scripteclipse.EclipseUtils

s_env_name="MMMV_DEVEL_TOOLS_HOME"
s_mmmv_devel_tools_home=ENV[s_env_name]
if s_mmmv_devel_tools_home.class==NilClass
   puts "The environment variable, "+s_env_name+
   ", is not set."
   exit
end # if
MMMV_DEVEL_TOOLS_HOME=s_mmmv_devel_tools_home if !defined? MMMV_DEVEL_TOOLS_HOME

s_path_1=MMMV_DEVEL_TOOLS_HOME+
"/src/mmmv_devel_tools/IDE_integration/src/Eclipse/ScriptEclipse/src/bonnet/common_mess_t1.rb"
require s_path_1

#ob_mess_common=T_mmmv_devel_tools_IDE_integration_common_mess_t1.ob_get_core_KRL


ob_editor=EclipseUtils.getActiveEditor()
ob_editor_input=ob_editor.getEditorInput()
s_file_name=ob_editor_input.getName().gsub(/[\s]/,"")

s_args=" --files "
s_console_app_path=MMMV_DEVEL_TOOLS_HOME+
"/src/mmmv_devel_tools/renessaator/src/renessaator "

s_old=EclipseUtils.getTextOfActiveEditor()
b_application_works_by_editing_input_files=true

s_new=T_mmmv_devel_tools_IDE_integration_common_mess_t1.filter_string_through_a_command_line_application(
s_console_app_path,s_args, s_old,b_application_works_by_editing_input_files,
s_file_name)

EclipseUtils.replaceTextOfActiveEditor(0,s_old.length,s_new)
#EclipseUtils.showConsole()
