puts 'Hello PMIP 0.3.2! - Please see http://code.google.com/p/pmip/ for full instructions and plugin helper bundles.'
#==========================================================================

plugin 'core'
plugin 'upguid'
plugin 'renessaator'
#plugin 'jumpguid_t1'

require "pathname"
require "singleton"

class Mmmv_devel_tools_pmip_lib_globals

   attr_reader :s_fp_bash_
   attr_reader :s_fp_renessaator_bash_
   attr_reader :s_fp_breakdancemake_bash_
   attr_reader :s_fp_upguid_bash_
   attr_reader :s_fp_jumpguid_core_bash_
   attr_accessor :s_fp_project_root_


   #-----------------------------------------------------

   # Derivated form the PMIP Command class.
   def sh(s_cmd, b_hide_window = false)
      path="/tmp"
      s_out="";
      if OS.windows?
         s_out=Run.later { Thread.new {`start /D#{path.to_s.gsub('/',
         "\\")} #{b_hide_window ? "/B " : ""}#{s_cmd}` } }
      else
         s_cmd_0="`cd "+path+" ; "+s_cmd+" `"
         s_cmd_0.gsub!(/[\n]/,"")
         s_out=eval(s_cmd_0)
      end # else
      return s_out
   end # sh

   def Mmmv_devel_tools_pmip_lib_globals.sh(s_cmd, b_hide_window = false)
      s_out=Mmmv_devel_tools_pmip_lib_globals.instance.sh(s_cmd, b_hide_window)
      return s_out
   end # Mmmv_devel_tools_pmip_lib_globals.sh

   #-----------------------------------------------------

   def initialize
      ob_pth_0=Pathname.new(__FILE__).realpath.parent
      ob_pth_1=ob_pth_0.parent.parent.parent.parent.parent.parent
      @mmmv_devel_tools_home_=ob_pth_1.to_s.freeze

      s_0=@mmmv_devel_tools_home_+"/src/mmmv_devel_tools"

      @s_fp_bash_=self.sh("which bash").gsub(/[\s]/,"").freeze
      @s_fp_renessaator_bash_=s_0+"/renessaator/src/renessaator".freeze
      @s_fp_breakdancemake_bash_=s_0+"/breakdancemake/src/breakdancemake".freeze
      @s_fp_upguid_bash_=s_0+"/GUID_trace/src/UpGUID/src/upguid".freeze
      @s_fp_jumpguid_core_bash_=s_0+"/GUID_trace/src/JumpGUID/src/core/jumpguid_core".freeze

      @s_fp_project_root_=nil
   end # initialize

   #-----------------------------------------------------

   #def intellij_action_sync
   #end # intellij_action_sync

   #-----------------------------------------------------

   def Mmmv_devel_tools_pmip_lib_globals.s_fp_bash()
      s_out=Mmmv_devel_tools_pmip_lib_globals.instance.s_fp_bash_
      return s_out
   end # Mmmv_devel_tools_pmip_lib_globals.s_fp_bash

   #-----------------------------------------------------

   def Mmmv_devel_tools_pmip_lib_globals.mmmv_devel_tools_home
      s_out=Mmmv_devel_tools_pmip_lib_globals.instance.mmmv_devel_tools_home_
      return s_out
   end # Mmmv_devel_tools_pmip_lib_globals.mmmv_devel_tools_home

   #-----------------------------------------------------

   def Mmmv_devel_tools_pmip_lib_globals.s_fp_project_root
      s_out=Mmmv_devel_tools_pmip_lib_globals.instance.s_fp_project_root_
      return s_out
   end # Mmmv_devel_tools_pmip_lib_globals.s_fp_project_root

   def Mmmv_devel_tools_pmip_lib_globals.s_fp_project_root=(s_in)
      ob=Mmmv_devel_tools_pmip_lib_globals.instance
      ob.s_fp_project_root_=""+s_in.freeze
   end # Mmmv_devel_tools_pmip_lib_globals.s_fp_project_root=

   #-----------------------------------------------------

   def Mmmv_devel_tools_pmip_lib_globals.s_fp_renessaator_bash
      s_out=Mmmv_devel_tools_pmip_lib_globals.instance.s_fp_renessaator_bash_
      return s_out
   end
   def Mmmv_devel_tools_pmip_lib_globals.s_fp_breakdancemake_bash
      s_out=Mmmv_devel_tools_pmip_lib_globals.instance.s_fp_breakdancemake_bash_
      return s_out
   end
   def Mmmv_devel_tools_pmip_lib_globals.s_fp_upguid_bash
      s_out=Mmmv_devel_tools_pmip_lib_globals.instance.s_fp_upguid_bash_
      return s_out
   end
   def Mmmv_devel_tools_pmip_lib_globals.s_fp_jumpguid_core_bash
      s_out=Mmmv_devel_tools_pmip_lib_globals.instance.s_fp_jumpguid_core_bash_
      return s_out
   end # Mmmv_devel_tools_pmip_lib_globals.s_fp_jumpguid_core_bash

   #-----------------------------------------------------

   def Mmmv_devel_tools_pmip_lib_globals.open_file_in_editor(s_fp,context)
      puts("Currently this method works, "+
      "somewhat vaguely, non-exactly, with file paths that "+
      "are within the open project. However, it needs to be "+
      "refactored to work with anty file paht."+
      "\nGUID='526e1222-fd6e-409c-815c-e0b030716dd7'\n")
      return # because exception throwing does not cause message displaying.
      #-------------------------------------
      # Sample code resides at:
      # http://code.google.com/p/pmip/issues/detail?id=13
      #-------------------------------------
      #ob_fp=Filepath.new(s_fp)
      ob_fp= PMIPContext.new.filepath_from_root(s_fp)
      #---------------------
      b_include_external=true
      ar_elements=GotoFileModel.new(context.project).getElementsByName(
      ob_fp.filename, b_include_external, '')
      if  0< ar_elements.size
         #puts "kull "+ar_elements.class.to_s
         Navigator.new.open(ar_elements.first)
      else
         raise(Exception.new("ar_elements==0 "+
         "\nGUID='70832944-ab8d-4d55-815c-e0b030716dd7'\n"))
      end # else
   end # Mmmv_devel_tools_pmip_lib_globals.open_file_in_editor

   #-----------------------------------------------------
   include Singleton
end # class Mmmv_devel_tools_pmip_lib_globals

# The next line initializes the singleton.
Mmmv_devel_tools_pmip_lib_globals.s_fp_jumpguid_core_bash()

#==========================================================================

