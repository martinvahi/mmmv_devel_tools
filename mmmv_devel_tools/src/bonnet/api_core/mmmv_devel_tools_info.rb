#!/usr/bin/env ruby
#==========================================================================

#require "singleton"
require "pathname"

if !defined? MMMV_DEVEL_TOOLS_HOME
   ob_pth=Pathname.new(__FILE__).realpath.parent
   MMMV_DEVEL_TOOLS_HOME=ob_pth.parent.parent.parent.to_s
end # if

require MMMV_DEVEL_TOOLS_HOME+"/src/bonnet/mmmv_devel_tools_initialization_t1.rb"

class C_mmmv_devel_tools_info
   def initialize
   end # initialize

   def get_config(s_config_ht_key)
      ht_config=C_mmmv_devel_tools_global_singleton.ht_global_configuration
      s_out=ht_config[s_config_ht_key]
      if s_out==nil
         kibuvits_throw("\nGUID=='e9806153-24c1-4a83-85da-e26051415dd7'\n\n")
      end # if
      return s_out
   end # get_config

   def s_doc(s_optional_GUID="")
      s_out="\n\nCommand line arguments: "+
      "\n"+
      "\n        (get_config <ht_config key>)"+
      "\n\n"
      if 0<s_optional_GUID.length
         s_out=s_out+
         "Current message branch GUID=="+s_optional_GUID+"\n\n"
      end #
      return s_out
   end # s_doc

end # class C_mmmv_devel_tools_info

ob_info=C_mmmv_devel_tools_info.new

if ARGV.size==0
   kibuvits_writeln(ob_info.s_doc("'7e6a6e33-e96a-4759-83da-e26051415dd7'"))
   exit
end # if

s_cmd=ARGV[0].to_s


case s_cmd
when "get_config"
   if ARGV.size!=2
      kibuvits_writeln(ob_info.s_doc("'2719835a-fda1-4738-b4da-e26051415dd7'"))
      exit
   end # if
   s_config_key=ARGV[1]
   s_out=ob_info.get_config(s_config_key)
   kibuvits_write s_out
else
   kibuvits_writeln(ob_info.s_doc("'449ffda3-44b1-4c5d-95da-e26051415dd7'"))
   exit
end # case s_cmd

#==========================================================================

