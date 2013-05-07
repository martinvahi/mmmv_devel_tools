
require "pathname"

#--------------------------------------------------------------------------

class Mmmv_devel_tools_jumpguid_t1_action_base< PMIPAction
   attr_accessor :ob_action_sync

   def initialize
      super()
      @ob_action_sync=nil
      @s_fp_bash=Mmmv_devel_tools_pmip_lib_globals.sh("which bash").gsub(/[\s]/,"")

      # s_movement_cmd possible values: {"no_cursor_movement","up","down"}
      @s_movement_cmd="no_cursor_movement"
   end # initialize

   def run(event, context)
      return if !context.has_editor?
      if  Mmmv_devel_tools_pmip_lib_globals.s_fp_project_root==nil
         Mmmv_devel_tools_pmip_lib_globals.s_fp_project_root=context.root().to_s
      end # if
      s_fp=context.editor_filepath.to_s
      s_fp_upg=Pathname.new(
      Mmmv_devel_tools_pmip_lib_globals.s_fp_upguid_bash).realpath.parent.to_s
      #--------------
      s_cmd=@s_fp_bash+" "+Mmmv_devel_tools_pmip_lib_globals.s_fp_jumpguid_core_bash+
      " get_file_path  "+@s_movement_cmd+" ;"
      s_cmd=s_cmd.gsub(/[\n]/,"")
      s_fp_src=Mmmv_devel_tools_pmip_lib_globals.sh(s_cmd).gsub(
      /[\s]/,"")
      #puts s_fp_src
      #--------------
      s_cmd=@s_fp_bash+" "+Mmmv_devel_tools_pmip_lib_globals.s_fp_jumpguid_core_bash+
      " get_line_number "+@s_movement_cmd+" ;"
      s_cmd=s_cmd.gsub(/[\n]/,"")
      si_src_line_number=Mmmv_devel_tools_pmip_lib_globals.sh(s_cmd).gsub(
      /[\s]/,"")
      #puts si_src_line_number
      #--------------
      # once_one_get_to_know_the_func_OPEN_FILE_in_IntelliJ(s_fp_src)
      # The next 2 lines form a semi-random leftover from experimentation
      #ob_x=FileEditorManager.get_instance(context.project)
      #ob_fp=Filepath.new(s_fp_src)
      #--------------
      ob_editor=context.current_editor
      i_line=si_src_line_number.to_i
      #i_line=41 # for testing
      i_column=0
      ob_editor.move_to(i_line,i_column)
      #@ob_action_sync.run(event,context)
   end
end # class Mmmv_devel_tools_jumpguid_t1_action_base

#--------------------------------------------------------------------------

# According to the error message:
# "plugin_root only available during plugin initialisation"
# The list of action names:
# http://git.jetbrains.org/?p=idea/community.git;a=blob;f=platform/platform-api/src/com/intellij/openapi/actionSystem/IdeActions.java;hb=HEAD
ob_mmmv_devel_tools_jumpguid_t1_action_c_sync=RunIntellijAction.new("Synchronize")

#--------------------------------------------------------------------------

class Mmmv_devel_tools_jumpguid_t1_action_c< Mmmv_devel_tools_jumpguid_t1_action_base

   def initialize
      super()
      @s_movement_cmd="no_cursor_movement"
   end # initialize
end # class Mmmv_devel_tools_jumpguid_t1_action_c

ob_mmmv_devel_tools_jumpguid_t1_action_c=Mmmv_devel_tools_jumpguid_t1_action_c.new
ob_mmmv_devel_tools_jumpguid_t1_action_c.ob_action_sync=ob_mmmv_devel_tools_jumpguid_t1_action_c_sync
#bind "alt C", ob_mmmv_devel_tools_jumpguid_t1_action_c

#--------------------------------------------------------------------------

class Mmmv_devel_tools_jumpguid_t1_action_up <
   Mmmv_devel_tools_jumpguid_t1_action_base

   def initialize
      super()
      @s_movement_cmd="up"
   end # initialize
end # class Mmmv_devel_tools_jumpguid_t1_action_up

ob_mmmv_devel_tools_jumpguid_t1_action_up=Mmmv_devel_tools_jumpguid_t1_action_up.new
ob_mmmv_devel_tools_jumpguid_t1_action_up.ob_action_sync=ob_mmmv_devel_tools_jumpguid_t1_action_c_sync
#bind "alt K", ob_mmmv_devel_tools_jumpguid_t1_action_up

#--------------------------------------------------------------------------

class Mmmv_devel_tools_jumpguid_t1_action_down<Mmmv_devel_tools_jumpguid_t1_action_base

   def initialize
      super()
      @s_movement_cmd="down"
   end # initialize
end # class Mmmv_devel_tools_jumpguid_t1_action_down

ob_mmmv_devel_tools_jumpguid_t1_action_down=Mmmv_devel_tools_jumpguid_t1_action_down.new
ob_mmmv_devel_tools_jumpguid_t1_action_down.ob_action_sync=ob_mmmv_devel_tools_jumpguid_t1_action_c_sync
#bind "alt J", ob_mmmv_devel_tools_jumpguid_t1_action_down

#==========================================================================
