#!/opt/ruby/bin/ruby -Ku
#==========================================================================
=begin

 Copyright 2012, martin.vahi@softf1.com that has an
 Estonian personal identification code of 38108050020.
 All rights reserved.

 Redistribution and use in source and binary forms, with or
 without modification, are permitted provided that the following
 conditions are met:

 * Redistributions of source code must retain the above copyright
   notice, this list of conditions and the following disclaimer.
 * Redistributions in binary form must reproduce the above copyright
   notice, this list of conditions and the following disclaimer
   in the documentation and/or other materials provided with the
   distribution.
 * Neither the name of the Martin Vahi nor the names of its
   contributors may be used to endorse or promote products derived
   from this software without specific prior written permission.

 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND
 CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES,
 INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
 MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR
 CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
 BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
 SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
 INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
 WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
 OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

---------------------------------------------------------------------------

=end
#==========================================================================

require "singleton"

# The reason, why the following if-else blocks are not within a function
# is that the Ruby interpreter requires the constant initialization to be
# in the global scope. That does not stop the programmers to try to
# reinitialize the constants, like
#  A_CAT="Miisu"
#  A_CAT="Tom"
# , but, those are the rules.

x=ENV["MMMV_DEVEL_TOOLS_HOME"]
if (x==nil)||(x=="")
   puts("\nMandatory environment variable, MMMV_DEVEL_TOOLS_HOME, \n"+
   "has not been set.\n\n")
   exit
end # if
if !defined? MMMV_DEVEL_TOOLS_HOME
   raise(Exception.new("The Ruby constant, MMMV_DEVEL_TOOLS_HOME, "+
   "should have been defined before the control flow reaches the "+
   "file, from where this exception is thrown."))
   exit
end # if

b_KIBUVITS_HOME_derived_from_environment_variable=false
if !defined? KIBUVITS_HOME
   x=ENV["KIBUVITS_HOME"]
   if (x!=nil and x!="")
      KIBUVITS_HOME=x
      b_KIBUVITS_HOME_derived_from_environment_variable=true
   else
      # use the local copy of the KRL
      KIBUVITS_HOME=MMMV_DEVEL_TOOLS_HOME+
      "/src/bonnet/lib/Kibuvits_Ruby_Library/src"
   end # if
end # if

# A hazy, very brief, test to see, whether the KIBUVITS_HOME
# might have a wrong value.
if !File.exists? KIBUVITS_HOME+"/include/kibuvits_boot.rb"
   msg="\nIt seems, that the Ruby constant, KIBUVITS_HOME(==\n"+
   KIBUVITS_HOME.to_s+"\n), has a wrong value.\n\n"
   if b_KIBUVITS_HOME_derived_from_environment_variable
      msg<<"The value of the Ruby constant, KIBUVITS_HOME, \n"+
      "equals with the environment variable named KIBUVITS_HOME, \n"+
      "which means that the environment variable, the KIBUVITS_HOME, \n"+
      "has a wrong value.\n\n"
   end # if
   puts msg
   exit
end # if

s_kibuvits_boot_path=KIBUVITS_HOME+"/include/kibuvits_boot.rb"
require s_kibuvits_boot_path

# Due to a fact that the API of the
# Kibuvits Ruby Library (KRL, http://kibuvits.rubyforge.org/ )
# is allowed to change between different versions, 
# applications that use the KRL must be tied to a specific
# version of the KRL.
if !defined? KIBUVITS_s_NUMERICAL_VERSION
   msg="\nThe Ruby constant, KIBUVITS_s_NUMERICAL_VERSION, has not \n"+
   "been defined in the \n"+
   s_kibuvits_boot_path+
   ". That indicates a Kibuvits Ruby Library version mismatch.\n\n"
   puts msg
   exit
end # if
s_expected_KIBUVITS_s_NUMERICAL_VERSION="1.1.0"
if KIBUVITS_s_NUMERICAL_VERSION!=s_expected_KIBUVITS_s_NUMERICAL_VERSION
   msg="\nThis version of the mmmv_devel_tools expects the Ruby constant, \n"+
   "KIBUVITS_s_NUMERICAL_VERSION, to have the value of \""+s_expected_KIBUVITS_s_NUMERICAL_VERSION+"\", \n"+
   "but the KIBUVITS_s_NUMERICAL_VERSION=="+KIBUVITS_s_NUMERICAL_VERSION.to_s+"\n\n"
   puts msg
   exit
end # if

require KIBUVITS_HOME+"/include/kibuvits_msgc.rb"


class C_mmmv_devel_tools_global_singleton

   private

   # The KRL io and str are needed for the config file
   # related things, but one wants to use lazy loading.
   def load_KRL_io_str_ix
      if (defined? @b_KRL_io_str_ix_loaded).class!=NilClass
         return if @b_KRL_io_str_ix_loaded
      end # if
      require KIBUVITS_HOME+"/include/kibuvits_io.rb"
      require KIBUVITS_HOME+"/include/kibuvits_str.rb"
      require KIBUVITS_HOME+"/include/kibuvits_ix.rb"
      @b_KRL_io_str_ix_loaded=true
   end # load_KRL_io_str_ix

   public

   def initialize
      @msgcs_=Kibuvits_msgc_stack.new
   end # initialize

   #-----------------------------------------------------------------------

   def msgcs()
      return @msgcs_
   end # msgcs

   def C_mmmv_devel_tools_global_singleton.msgcs()
      msgcs=C_mmmv_devel_tools_global_singleton.instance.msgcs()
      return msgcs
   end # C_mmmv_devel_tools_global_singleton.msgcs()

   #-----------------------------------------------------------------------

   def ht_global_configuration
      # The ht_global_configuration is intentionally
      # not cached, because in case of tools that are running in some
      # daemon mode one might want to reparse the config more than
      # once during a single run.
      msgcs=@msgcs_
      load_KRL_io_str_ix()
      ht_out=Hash.new
      s_fallback_config_file_name="mmmv_devel_tools_fallback_configuration.txt"
      s_default_config_file_name="mmmv_devel_tools_default_configuration.txt"
      s_fp_prefix=MMMV_DEVEL_TOOLS_HOME+"/src/etc/"
      s_fp_fallback_config=s_fp_prefix+s_fallback_config_file_name
      s_fp_default_config=s_fp_prefix+s_default_config_file_name

      s_msg_fallback_fp="$MMMV_DEVEL_TOOLS_HOME/src/etc/"+s_fallback_config_file_name
      s_msg_default_fp="$MMMV_DEVEL_TOOLS_HOME/src/etc/"+s_default_config_file_name
      if !File.exists? s_fp_fallback_config
         puts "\nFile "+s_msg_fallback_fp+" is missing.\n\n"
         exit
      end # if
      s_fallback=file2str(s_fp_fallback_config)
      ht_fallback=Kibuvits_str.configstylestr_2_ht(s_fallback,msgcs)
      if msgcs.b_failure
         puts "\nThe parsing of the "+s_msg_fallback_fp+" failed. Message:\n"+
         msgcs.last.to_s+"\n"
         exit
      end # if

      ht_default=Hash.new
      if !File.exists? s_fp_default_config
         s_default=file2str(s_fp_default_config)
         ht_default=Kibuvits_str.configstylestr_2_ht(s_default,msgcs)
         if msgcs.b_failure
            puts "\nThe parsing of the "+s_msg_default_fp+" failed. Message:\n"+
            msgcs.last.to_s+"\n"
            exit
         end # if
      end # if
      ar=[ht_fallback,ht_default]
      ht_out=Kibuvits_ix.ht_merge_by_overriding_t1(ar)
      return ht_out
   end # ht_global_configuration

   def C_mmmv_devel_tools_global_singleton.ht_global_configuration
      ht_out=C_mmmv_devel_tools_global_singleton.instance.ht_global_configuration
      return ht_out
   end # C_mmmv_devel_tools_global_singleton.ht_global_configuration

   #-----------------------------------------------------------------------
   include Singleton
end # class C_mmmv_devel_tools_global_singleton


#==========================================================================

