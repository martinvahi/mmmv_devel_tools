#!/usr/bin/env ruby
#==========================================================================
=begin

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
# Ruby language version related normalization:
#--------------------------------------------------------------------------
# Most Ruby versions prior to Ruby version 3.2.0
# had that method. This code makes old code that
# worked with those older Ruby versions
# work with the Ruby version 3.2.0 .
if !defined? File.exists?
   def File.exists? x
      b=File.exist? x
      return b
   end # File.exists?
end # if
# Ruby 2.4.0 introduced a change, where
# classes Fixnum and Bignum were deprecated
# their use triggered a warning text to stderr
# and their common parent class, Integer,
# was expected to be used instead of them.
# Ruby version 2.7.2 removed the warning from the stderr.
# Ruby version 3.2.0 missed the classes, Fixnum and Bignum.
# The following 2 if-clauses keep the old code working.
if !defined? Fixnum
   Fixnum=Integer
end # if
if !defined? Bignum
   Bignum=Integer
end # if
#==========================================================================

if !defined? KIBUVITS_HOME
   require 'pathname'
   ob_pth_0=Pathname.new(__FILE__).realpath
   ob_pth_1=ob_pth_0.parent.parent.parent
   s_KIBUVITS_HOME_b_fs=ob_pth_1.to_s
   require(s_KIBUVITS_HOME_b_fs+"/src/include/kibuvits_boot.rb")
   ob_pth_0=nil; ob_pth_1=nil; s_KIBUVITS_HOME_b_fs=nil
else
   # KIBUVITS_HOME is defined in application "main.rb",
   # where it is received from the environment variable.
   require(KIBUVITS_HOME+"/src/include/kibuvits_boot.rb")
end # if

def apply_to_genlist(s_mypath, a_file_path,s_list_for_gem)
   if a_file_path!=s_mypath
      s1=a_file_path[(KIBUVITS_HOME.length)..-1]
      s_list_for_gem=s_list_for_gem+"    require KIBUVITS_HOME+\""+s1+"\"\n"
      require a_file_path
   end # if
   return s_list_for_gem
end #apply_to_genlist

b_selfwriting=false
if defined? KIBUVITS_b_DEBUG
   # The TrueClass is used in stead of the boolean "true" to keep
   # this code working even, if some non-boolean value is
   # accidentally assigned to the KIBUVITS_b_DEBUG in the kibuvits_boot.rb.
   #
   # That solution hides a flaw, but the flaw/bug will probably
   # become visible at some other location and the
   # intentionally flaw-hiding solution here increases the probability that
   # the system is testable during debugging.
   b_selfwriting=KIBUVITS_b_DEBUG if KIBUVITS_b_DEBUG.class==TrueClass
end # if
if b_selfwriting
   kibuvits_home=KIBUVITS_HOME
   require kibuvits_home+"/src/include/kibuvits_msgc.rb"
   msgcs=Kibuvits_msgc_stack.new
   begin
      require  kibuvits_home+"/src/include/kibuvits_io.rb"
      s_mypath=Pathname.new(kibuvits_home+"/src/include/kibuvits_all.rb").realpath.to_s
      s_list_for_gem=""
      s0=""
      s1=""
      pthn=nil
      s_prefix=kibuvits_home+"/src/include/"
      Dir.glob(s_prefix+"*.rb").each do |a_file_path|
         s_list_for_gem=apply_to_genlist(s_mypath, a_file_path,s_list_for_gem)
      end # loop
      Dir.glob(kibuvits_home+"/src/include/wrappers/*.rb").each do |a_file_path|
         s_list_for_gem=apply_to_genlist(s_mypath, a_file_path,s_list_for_gem)
      end # loop
      Dir.glob(kibuvits_home+"/src/include/incomplete/*.rb").each do |a_file_path|
         s_list_for_gem=apply_to_genlist(s_mypath, a_file_path,s_list_for_gem)
      end # loop
      Dir.glob(kibuvits_home+"/src/include/brutal_workarounds/*.rb").each do |a_file_path|
         s_list_for_gem=apply_to_genlist(s_mypath, a_file_path,s_list_for_gem)
      end # loop
      Dir.glob(kibuvits_home+"/src/include/security/*.rb").each do |a_file_path|
         s_list_for_gem=apply_to_genlist(s_mypath, a_file_path,s_list_for_gem)
      end # loop
      Dir.glob(kibuvits_home+"/src/include/numerics/*.rb").each do |a_file_path|
         s_list_for_gem=apply_to_genlist(s_mypath, a_file_path,s_list_for_gem)
      end # loop
      Dir.glob(kibuvits_home+"/src/include/code_generation/*.rb").each do |a_file_path|
         s_list_for_gem=apply_to_genlist(s_mypath, a_file_path,s_list_for_gem)
      end # loop
      Dir.glob(kibuvits_home+"/src/include/bonnet/*.rb").each do |a_file_path|
         s_list_for_gem=apply_to_genlist(s_mypath, a_file_path,s_list_for_gem)
      end # loop
      s_start="SELFWRIGING_REGION_STAR"+"T"
      s_end="SELFWRIGING_REGION_EN"+"D"
      s_hay=file2str(s_mypath)
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
      "depends on, changed. msgcs.to_s==\n"+msgcs.to_s+
      "\n\nThe system exception message is:\n\n"+
      e.to_s) #+
   end # rescue
else
   # SELFWRIGING_REGION_START
    require KIBUVITS_HOME+"/src/include/kibuvits_htoper_t1.rb"
    require KIBUVITS_HOME+"/src/include/kibuvits_arraycursor_t1.rb"
    require KIBUVITS_HOME+"/src/include/kibuvits_io.rb"
    require KIBUVITS_HOME+"/src/include/kibuvits_graph.rb"
    require KIBUVITS_HOME+"/src/include/kibuvits_coords.rb"
    require KIBUVITS_HOME+"/src/include/kibuvits_i18n_msgs_t1.rb"
    require KIBUVITS_HOME+"/src/include/kibuvits_ix.rb"
    require KIBUVITS_HOME+"/src/include/kibuvits_argv_parser.rb"
    require KIBUVITS_HOME+"/src/include/kibuvits_GUID_generator.rb"
    require KIBUVITS_HOME+"/src/include/kibuvits_apparch_specific.rb"
    require KIBUVITS_HOME+"/src/include/kibuvits_refl.rb"
    require KIBUVITS_HOME+"/src/include/kibuvits_fs.rb"
    require KIBUVITS_HOME+"/src/include/kibuvits_formula.rb"
    require KIBUVITS_HOME+"/src/include/kibuvits_file_intelligence.rb"
    require KIBUVITS_HOME+"/src/include/kibuvits_str_concat_array_of_strings.rb"
    require KIBUVITS_HOME+"/src/include/kibuvits_msgc.rb"
    require KIBUVITS_HOME+"/src/include/kibuvits_keyboard.rb"
    require KIBUVITS_HOME+"/src/include/kibuvits_gstatement.rb"
    require KIBUVITS_HOME+"/src/include/kibuvits_IDstamp_registry_t1.rb"
    require KIBUVITS_HOME+"/src/include/kibuvits_ProgFTE.rb"
    require KIBUVITS_HOME+"/src/include/kibuvits_boot.rb"
    require KIBUVITS_HOME+"/src/include/kibuvits_comments_detector.rb"
    require KIBUVITS_HOME+"/src/include/kibuvits_dependencymetrics_t1.rb"
    require KIBUVITS_HOME+"/src/include/kibuvits_rake.rb"
    require KIBUVITS_HOME+"/src/include/kibuvits_str.rb"
    require KIBUVITS_HOME+"/src/include/kibuvits_graph_oper_t1.rb"
    require KIBUVITS_HOME+"/src/include/kibuvits_shell.rb"
    require KIBUVITS_HOME+"/src/include/kibuvits_finite_sets.rb"
    require KIBUVITS_HOME+"/src/include/kibuvits_eval.rb"
    require KIBUVITS_HOME+"/src/include/wrappers/kibuvits_data_transfer.rb"
    require KIBUVITS_HOME+"/src/include/wrappers/kibuvits_ImageMagick.rb"
    require KIBUVITS_HOME+"/src/include/wrappers/kibuvits_REDUCE.rb"
    require KIBUVITS_HOME+"/src/include/incomplete/kibuvits_whiteboard.rb"
    require KIBUVITS_HOME+"/src/include/incomplete/kibuvits_MUD.rb"
    require KIBUVITS_HOME+"/src/include/brutal_workarounds/kibuvits_configfileparser_t1.rb"
    require KIBUVITS_HOME+"/src/include/security/kibuvits_rng.rb"
    require KIBUVITS_HOME+"/src/include/security/kibuvits_cryptcodec_txor_t1.rb"
    require KIBUVITS_HOME+"/src/include/security/kibuvits_security_core.rb"
    require KIBUVITS_HOME+"/src/include/security/kibuvits_cleartext_length_normalization.rb"
    require KIBUVITS_HOME+"/src/include/security/kibuvits_hash_plaice_t1.rb"
    require KIBUVITS_HOME+"/src/include/numerics/kibuvits_numerics_set_0.rb"
    require KIBUVITS_HOME+"/src/include/code_generation/kibuvits_cg_php_t1.rb"
    require KIBUVITS_HOME+"/src/include/code_generation/kibuvits_cg_html_t1.rb"
    require KIBUVITS_HOME+"/src/include/code_generation/kibuvits_cg.rb"
    require KIBUVITS_HOME+"/src/include/bonnet/kibuvits_os_codelets.rb"

 # SELFWRIGING_REGION_END
end # if
#--------------------------------------------------------------------------
# S_VERSION_OF_THIS_FILE="af1e1745-ecd4-4809-b154-2111115037e7"
#==========================================================================
