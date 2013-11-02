# Call Eclipse action
# @@name mmmv_devel_tools/UpGUID_t1
# @@shortcut ALT+u

require 'java'
java_import com.mbartl.scripteclipse.EclipseUtils


s_env_name="MMMV_DEVEL_TOOLS_HOME"
s_mmmv_devel_tools_home=ENV[s_env_name]
if s_mmmv_devel_tools_home.class==NilClass
   puts "\nThe environment variable, "+s_env_name+", is not set.\n\n"
   exit
end # if
MMMV_DEVEL_TOOLS_HOME=s_mmmv_devel_tools_home if !defined? MMMV_DEVEL_TOOLS_HOME

s_path_1=MMMV_DEVEL_TOOLS_HOME+
"/src/mmmv_devel_tools/IDE_integration/src/Eclipse/ScriptEclipse/src/bonnet/common_mess_t1.rb"
require s_path_1
ob_mess_common=T_mmmv_devel_tools_IDE_integration_common_mess_t1.ob_get_core_KRL

s_args=" - "
s_console_app_path=MMMV_DEVEL_TOOLS_HOME+
"/src/mmmv_devel_tools/GUID_trace/src/UpGUID/src/upguid "

s_old=EclipseUtils.getTextOfActiveEditor()

s_new=T_mmmv_devel_tools_IDE_integration_common_mess_t1.filter_string_through_a_command_line_application(
s_console_app_path,s_args, s_old)

#EclipseUtils.showConsole()
EclipseUtils.replaceTextOfActiveEditor(0,s_old.length,s_new)



