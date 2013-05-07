#load 'lib/???.rb'
require "pathname"

class Mmmv_devel_tools_upguid_action_u< PMIPAction
   attr_accessor :ob_action_sync

   def initialize
      super()
      @ob_action_sync=nil
      @s_fp_bash=Mmmv_devel_tools_pmip_lib_globals.sh("which bash").gsub(/[\s]/,"")
   end # initialize

   def run(event, context)
      return if !context.has_editor?
      if  Mmmv_devel_tools_pmip_lib_globals.s_fp_project_root==nil
         Mmmv_devel_tools_pmip_lib_globals.s_fp_project_root=context.root().to_s
      end # if
      s_fp=context.editor_filepath.to_s
      s_fp_upg=Pathname.new(
      Mmmv_devel_tools_pmip_lib_globals.s_fp_upguid_bash).realpath.parent.to_s
      s_cmd=@s_fp_bash+" "+Mmmv_devel_tools_pmip_lib_globals.s_fp_upguid_bash+
      " -f "+s_fp+" ;"
      s_cmd=s_cmd.gsub(/[\n]/,"")
      s_new=Mmmv_devel_tools_pmip_lib_globals.sh(s_cmd)
      #s_new=Mmmv_devel_tools_pmip_lib_globals.sh("whoami")
      @ob_action_sync.run(event,context)
      #puts s_new
      #puts s_cmd
      #Balloon.new(context).info('Hello from PMIP!')
   end
end # class Mmmv_devel_tools_upguid_action_u

ob_mmmv_devel_tools_upguid_action_u=Mmmv_devel_tools_upguid_action_u.new

# According to the error message:
# "plugin_root only available during plugin initialisation"
ob_mmmv_devel_tools_upguid_action_u_sync=RunIntellijAction.new("Synchronize")

ob_mmmv_devel_tools_upguid_action_u.ob_action_sync=ob_mmmv_devel_tools_upguid_action_u_sync

bind "alt U", ob_mmmv_devel_tools_upguid_action_u

