puts 'Hello PMIP 0.3.2! - Please see http://code.google.com/p/pmip/ for full instructions and plugin helper bundles.'
#==========================================================================

plugin 'core'
plugin 'upguid'
plugin 'renessaator'
#plugin 'jumpguid_t1'

require "pathname"
require "singleton"

class Mmmv_devel_tools_pmip_lib_globals
   attr_accessor :s_fp_project_root_

   attr_reader :mmmv_devel_tools_home_
   attr_reader :s_fp_renessaator_bash_
   attr_reader :s_fp_breakdancemake_bash_
   attr_reader :s_fp_upguid_bash_
   attr_reader :s_fp_jumpguid_core_bash_

   def initialize
      ob_pth_0=Pathname.new(__FILE__).realpath.parent
      ob_pth_1=ob_pth_0.parent.parent.parent.parent.parent.parent
      @mmmv_devel_tools_home_=ob_pth_1.to_s.freeze
      @s_fp_project_root_=nil

      @s_fp_renessaator_bash_=nil
      @s_fp_breakdancemake_bash_=nil
      @s_fp_upguid_bash_=nil
      @s_fp_jumpguid_core_bash_=nil

      s_0=@mmmv_devel_tools_home_+"/src/mmmv_devel_tools"
      @s_fp_renessaator_bash_=s_0+"/renessaator/src/renessaator"
      @s_fp_breakdancemake_bash_=s_0+"/breakdancemake/src/breakdancemake"
      @s_fp_upguid_bash_=s_0+"/GUID_trace/src/UpGUID/src/upguid"
      @s_fp_jumpguid_core_bash_=s_0+"/GUID_trace/src/JumpGUID/src/core/jumpguid_core"

   end # initialize

   #-----------------------------------------------------

   #def intellij_action_sync
   #end # intellij_action_sync

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

   # Derivated form the PMIP Command class.
   def self.sh(s_cmd, b_hide_window = false)
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

   #-----------------------------------------------------
   def just_init
   end # just_init
   include Singleton
end # class Mmmv_devel_tools_pmip_lib_globals
Mmmv_devel_tools_pmip_lib_globals.instance.just_init

#==========================================================================

