#!/opt/ruby/bin/ruby -Ku
#==========================================================================
=begin
 Copyright 2010, martin.vahi@softf1.com that has an
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

--------------------------------------------------------------------------
The reason, why the name of this file is kibuvits_all.rb in stead of
just kibuvits.rb, is that there was some sort of trouble loading the
kibuvits.rb from a gem.

The ultimate reason, why it's such a self-writing quirk, is that
one could not figure out, how to elegantly use absolute file
paths within a gem. So relative paths have to be used, but if
one does not use absolute paths, the Dir.glob(stuff) is a bit
difficult to use, which leads to a pre-written list of
require statements, and usefulness of the the swlf-writing quirk,
which frees one from the manual list-assembling.

=end
#==========================================================================

def apply_to_genlist(s_mypath, a_file_path,s_list_for_gem)
   s0=Pathname.new(a_file_path).realpath.parent.to_s
   s1=a_file_path[(s0.length+1)..-1]
   if a_file_path!=s_mypath
      s_list_for_gem=s_list_for_gem+"    require \""+s1+"\"\n"
      require a_file_path
   end # if
   return s_list_for_gem
end #apply_to_genlist

kibuvits_home=ENV['KIBUVITS_HOME']
b_selfwriting=(kibuvits_home!=nil and kibuvits_home!="")
if b_selfwriting
   begin
      KIBUVITS_HOME=kibuvits_home unless defined? KIBUVITS_HOME
      require  kibuvits_home+"/include/kibuvits_io.rb"
      s_mypath=Pathname.new(kibuvits_home+"/include/kibuvits_all.rb").realpath.to_s
      s_list_for_gem=""
      s0=""
      s1=""
      pthn=nil
      Dir.glob(kibuvits_home+"/include/*.rb").each do |a_file_path|
         s_list_for_gem=apply_to_genlist(s_mypath, a_file_path,s_list_for_gem)
      end # loop
      Dir.glob(kibuvits_home+"/include/incomplete/*.rb").each do |a_file_path|
         s_list_for_gem=apply_to_genlist(s_mypath, a_file_path,s_list_for_gem)
      end # loop
      Dir.glob(kibuvits_home+"/bonnet/*.rb").each do |a_file_path|
         s_list_for_gem=apply_to_genlist(s_mypath, a_file_path,s_list_for_gem)
      end # loop
      s_start="SELFWRIGING_REGION_STAR"+"T"
      s_end="SELFWRIGING_REGION_EN"+"D"
      s_hay=file2str(s_mypath)
      msgcs=Kibuvits_msgc_stack.new
      s_hay,ht_picks=Kibuvits_str.pick_by_instance(s_start,s_end,
      s_hay,msgcs)
      if msgcs.b_failure
         raise Exception.new("Selfwriting in kibuvits_all.rb failed. t1 msg=="+msgcs.to_s)
      end # if
      if 1!=ht_picks.keys.length
         raise Exception.new("Selfwriting in kibuvits_all.rb failed. t2")
      end # if
      s_key=ht_picks.keys[0]
      s_block=s_start+"\n"+s_list_for_gem+"\n # "+s_end
      s_hay.sub!(s_key,s_block)
      str2file(s_hay,s_mypath)
   rescue Exception => e
      # The kibuvits_throw should not be used here, because
      # it resides in the kibuvits_boot.rb, which is not loaded,
      # if any of the kibuvits_io.rb or alike has not been loaded
      # sucessfully for rewriting this file here.
      raise Exception.new("\n\nkibuvits_all.rb selfwriting failed.\n"+
      "It might be that the API of some function that the selfwriting \n"+
      "depends on, changed. The system exception message is:\n\n"+
      e.to_s) #+
   end # rescue
else
   # SELFWRIGING_REGION_START
    require "kibuvits_arraycursor_t1.rb"
    require "kibuvits_io.rb"
    require "kibuvits_graph.rb"
    require "kibuvits_htoper.rb"
    require "kibuvits_coords.rb"
    require "kibuvits_i18n_msgs_t1.rb"
    require "kibuvits_ix.rb"
    require "kibuvits_argv_parser.rb"
    require "kibuvits_GUID_generator.rb"
    require "kibuvits_apparch_specific.rb"
    require "kibuvits_refl.rb"
    require "kibuvits_fs.rb"
    require "kibuvits_formula.rb"
    require "kibuvits_file_intelligence.rb"
    require "kibuvits_str_concat_array_of_strings.rb"
    require "kibuvits_msgc.rb"
    require "kibuvits_gstatement.rb"
    require "kibuvits_IDstamp_registry_t1.rb"
    require "kibuvits_ProgFTE.rb"
    require "kibuvits_boot.rb"
    require "kibuvits_comments_detector.rb"
    require "kibuvits_dependencymetrics_t1.rb"
    require "kibuvits_str.rb"
    require "kibuvits_graph_oper_t1.rb"
    require "kibuvits_cg.rb"
    require "kibuvits_shell.rb"
    require "kibuvits_finite_sets.rb"
    require "kibuvits_eval.rb"
    require "kibuvits_whiteboard.rb"
    require "kibuvits_MUD.rb"
    require "kibuvits_szr.rb"
    require "kibuvits_os_codelets.rb"

 # SELFWRIGING_REGION_END
end # if
#==========================================================================
