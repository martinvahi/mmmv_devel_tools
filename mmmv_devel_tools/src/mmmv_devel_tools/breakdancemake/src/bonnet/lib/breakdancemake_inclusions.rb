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

=end
#==========================================================================
# The this file is a common place for all of the common external
# libraries, including the Kibuvits Rub Library, inclusion statements.

#--------------------------------------------------------------------------
if !defined? BREAKDANCEMAKE_INCLUSIONS_INCLUDED

   #require "rubygems"
   require 'pathname'
   require "monitor"
   require "find"
   require "singleton"
   require 'thread'

   if !defined? MMMV_DEVEL_TOOLS_HOME
      raise(Exception.new("The assumption is that this file is included after "+
      "the MMMV_DEVEL_TOOLS_HOME has been defined."))
   end # if
   if !defined? BREAKDANCEMAKE_HOME
      raise(Exception.new("The assumption is that this file is included after "+
      "the BREAKDANCEMAKE_HOME has been defined."))
   end # if

   require MMMV_DEVEL_TOOLS_HOME+"/src/bonnet/mmmv_devel_tools_initialization_t1.rb"

   # The "included" const. must reside before the "require" clauses, because
   # that way it is available by the time, when the code within the
   # require clauses probes for it.
   BREAKDANCEMAKE_INCLUSIONS_INCLUDED=true

   if !defined? KIBUVITS_HOME
      KIBUVITS_HOME=BREAKDANCEMAKE_HOME+"/src/bonnet/lib/KRL_local_copy/src"
   end # if

   if defined? KIBUVITS_HOME
      require  KIBUVITS_HOME+"/src/include/kibuvits_io.rb"
      require  KIBUVITS_HOME+"/src/include/kibuvits_fs.rb"
      require  KIBUVITS_HOME+"/src/include/kibuvits_ProgFTE.rb"
      require  KIBUVITS_HOME+"/src/include/kibuvits_str.rb"
      require  KIBUVITS_HOME+"/src/include/kibuvits_shell.rb"
      require  KIBUVITS_HOME+"/src/include/kibuvits_htoper.rb"
      require  KIBUVITS_HOME+"/src/include/kibuvits_i18n_msgs_t1.rb"
      require  KIBUVITS_HOME+"/src/include/kibuvits_dependencymetrics_t1.rb"
      require  KIBUVITS_HOME+"/src/include/kibuvits_apparch_specific.rb"
      require  KIBUVITS_HOME+"/src/include/kibuvits_finite_sets.rb"
   else
      require  "kibuvits_io.rb"
      require  "kibuvits_fs.rb"
      require  "kibuvits_ProgFTE.rb"
      require  "kibuvits_str.rb"
      require  "kibuvits_shell.rb"
      require  "kibuvits_htoper.rb"
      require  "kibuvits_i18n_msgs_t1.rb"
      require  "kibuvits_dependencymetrics_t1.rb"
      require  "kibuvits_apparch_specific.rb"
      require  "kibuvits_finite_sets.rb"
   end # if

   # The breakdancemake framework depends on the constants.
   $breakdancemake_lc_default_task="default_task".freeze

   require BREAKDANCEMAKE_HOME+"/src/bonnet/lib/breakdancemake_core_ui_texts.rb"
   require BREAKDANCEMAKE_HOME+"/src/bonnet/breakdancemake_bdmcomponent.rb"
   require BREAKDANCEMAKE_HOME+"/src/bonnet/breakdancemake_bdmroutine.rb"
   require BREAKDANCEMAKE_HOME+"/src/bonnet/breakdancemake_bdmservice_detector.rb"
   require BREAKDANCEMAKE_HOME+"/src/bonnet/breakdancemake_bdmprojectdescriptor_base.rb"

   # Due to the dependencies it must be the last one loaded.
   require BREAKDANCEMAKE_HOME+"/src/bonnet/breakdancemake_cl.rb"

end # if
#==========================================================================

