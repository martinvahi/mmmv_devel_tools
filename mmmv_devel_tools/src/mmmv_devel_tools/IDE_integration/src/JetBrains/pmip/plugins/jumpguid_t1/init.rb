
require "pathname"

#--------------------------------------------------------------------------

class Mmmv_devel_tools_jumpguid_t1_action_base< PMIPAction
   attr_accessor :ob_action_sync

   def initialize(s_movement_cmd="no_cursor_movement")
      super()
      @ob_action_sync=nil
      @s_fp_bash=Mmmv_devel_tools_pmip_lib_globals.s_fp_bash()
      @s_fp_jumpguid_core=Mmmv_devel_tools_pmip_lib_globals.s_fp_jumpguid_core_bash

      # s_movement_cmd possible values: {"no_cursor_movement","up","down"}
      @s_movement_cmd=s_movement_cmd
   end # initialize

   def run(event, context)
      puts("The code is complete, except that "+
      "the file opening routine, the "+
      "\nMmmv_devel_tools_pmip_lib_globals.open_file_in_editor "+
      "\n needs to be completed."+
      "\nGUID='1fd77513-2eb0-4914-a273-62a120716dd7'\n"
      )
      return # because exception throwing does not cause message displaying.
      #--------------------------------
      return if !context.has_editor?
      if  Mmmv_devel_tools_pmip_lib_globals.s_fp_project_root==nil
         s_fp_project_root=context.root().to_s
         Mmmv_devel_tools_pmip_lib_globals.s_fp_project_root=s_fp_project_root
      end # if
      #s_fp=context.editor_filepath.to_s
      #s_fp_upg=Pathname.new(
      #Mmmv_devel_tools_pmip_lib_globals.s_fp_upguid_bash).realpath.parent.to_s
      #--------------
      s_cmd=@s_fp_bash+" "+@s_fp_jumpguid_core+" get_file_path  "+@s_movement_cmd+" ;"
      s_cmd=s_cmd.gsub(/[\n]/,"")
      s_fp_src=Mmmv_devel_tools_pmip_lib_globals.sh(s_cmd).gsub(
      /[\s]/,"")
      #puts s_fp_src
      #--------------
      s_cmd=@s_fp_bash+" "+@s_fp_jumpguid_core+" get_line_number "+@s_movement_cmd+" ;"
      s_cmd=s_cmd.gsub(/[\n]/,"")
      si_src_line_number=Mmmv_devel_tools_pmip_lib_globals.sh(s_cmd).gsub(
      /[\s]/,"")
      #puts si_src_line_number
      #si_src_line_number=41
      #--------------
      # The next 2 lines form a semi-random leftover from experimentation
      #ob_x=FileEditorManager.get_instance(context.project)
      #ob_fp=Filepath.new(s_fp_src)
      #--------------
      Mmmv_devel_tools_pmip_lib_globals.open_file_in_editor(s_fp_src,context)
      @ob_action_sync.run(event,context)
      #puts ob_fp.to_s
      #--------------
      ob_editor=context.current_editor
      i_line=si_src_line_number.to_i
      #i_line=41 # for testing
      i_column=0
      ob_editor.move_to(i_line,i_column)
      @ob_action_sync.run(event,context)
   end # run

end # class Mmmv_devel_tools_jumpguid_t1_action_base

#--------------------------------------------------------------------------

# According to the error message:
# "plugin_root only available during plugin initialisation"
# The list of action names:
# http://git.jetbrains.org/?p=idea/community.git;a=blob;f=platform/platform-api/src/com/intellij/openapi/actionSystem/IdeActions.java;hb=HEAD
ob_mmmv_devel_tools_jumpguid_t1_action_c_sync=RunIntellijAction.new("Synchronize")

#--------------------------------------------------------------------------
# The clutter at the next lines is explained by the fact that
# the key binding mechanism requires that each key comgination is
# bound to its own, unique, class.

class Mmmv_devel_tools_jumpguid_t1_action_no_cursor_movement<Mmmv_devel_tools_jumpguid_t1_action_base
   def initialize
      super("no_cursor_movement")
   end # initialize
end # Mmmv_devel_tools_jumpguid_t1_action_no_cursor_movement

ob_mmmv_devel_tools_jumpguid_t1_action_c=Mmmv_devel_tools_jumpguid_t1_action_no_cursor_movement.new
ob_mmmv_devel_tools_jumpguid_t1_action_c.ob_action_sync=ob_mmmv_devel_tools_jumpguid_t1_action_c_sync
bind("alt C", ob_mmmv_devel_tools_jumpguid_t1_action_c)

#--------------------------------------------------------------------------

class Mmmv_devel_tools_jumpguid_t1_action_up<Mmmv_devel_tools_jumpguid_t1_action_base
   def initialize
      super("up")
   end # initialize
end # Mmmv_devel_tools_jumpguid_t1_action_up

ob_mmmv_devel_tools_jumpguid_t1_action_up=Mmmv_devel_tools_jumpguid_t1_action_up.new
ob_mmmv_devel_tools_jumpguid_t1_action_up.ob_action_sync=ob_mmmv_devel_tools_jumpguid_t1_action_c_sync
bind "alt K", ob_mmmv_devel_tools_jumpguid_t1_action_up

#--------------------------------------------------------------------------
class Mmmv_devel_tools_jumpguid_t1_action_down<Mmmv_devel_tools_jumpguid_t1_action_base
   def initialize
      super("down")
   end # initialize
end # Mmmv_devel_tools_jumpguid_t1_action_down

ob_mmmv_devel_tools_jumpguid_t1_action_down=Mmmv_devel_tools_jumpguid_t1_action_down.new
ob_mmmv_devel_tools_jumpguid_t1_action_down.ob_action_sync=ob_mmmv_devel_tools_jumpguid_t1_action_c_sync
bind "alt J", ob_mmmv_devel_tools_jumpguid_t1_action_down

#==========================================================================

