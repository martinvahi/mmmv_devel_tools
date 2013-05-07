#!/usr/bin/env ruby
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

if !defined? BREAKDANCEMAKE_CL_INCLUDED
   BREAKDANCEMAKE_CL_INCLUDED=true
   if !defined? BREAKDANCEMAKE_HOME
      # Has to be derived here from __FILE__ for cases, where
      # a Rakefile loads mmmv_devel_tools.
      require 'pathname'
      s_0=Pathname.new(__FILE__).realpath.parent.parent.parent.to_s
      BREAKDANCEMAKE_HOME=s_0.freeze
   end # if
   require BREAKDANCEMAKE_HOME+"/src/bonnet/lib/breakdancemake_inclusions.rb"
end # if

#==========================================================================

class Breakdancemake
   attr_reader :s_lc_1, :s_lc_2
   attr_reader :msgcs
   attr_reader :s_version

   # The @ht_bdmroutines is publicly readable, because some
   # bdmroutines depend on other bdmroutines anyway and that way
   # one can reuse bdmroutine instances.
   #
   # Keys of the @ht_bdmroutines are the names of the loaded bdmroutines.
   # Keys of the @ht_bdmservice_detectors are the
   # names of the loaded bdmservice detectors.
   attr_reader :ht_bdmroutines, :ht_bdmservice_detectors

   # There are some user interface texts that are common
   # to more than one bdmroutine.
   attr_reader :ob_core_ui_texts

   attr_reader :b_bdmprojectdescriptor_rb_loaded
   def initialize
      @ht_bdmroutines=Hash.new
      @ht_bdmroutines_classes=Hash.new
      @ht_bdmservice_detectors=Hash.new
      @ht_bdmservice_detectors_classes=Hash.new
      @ht_bdmprojectdescriptors=Hash.new
      @ht_bdmprojectdescriptor_classes=Hash.new

      # It's useful for dependency analysis.
      @ht_bdmcomponents=Hash.new # ==
      # ==@ht_bdmroutines.merge(
      #     @ht_bdmservice_detectors).merge(@ht_bdmprojectdescriptors)

      @s_lc_1="<The @s_bdmcomponent_name is not yet properly initialized>".freeze
      @s_lc_2="<The @s_bdmcomponent_name is not yet properly initialized>".freeze
      @msgcs=C_mmmv_devel_tools_global_singleton.msgcs()
      @b_bdmroutine_classes_loaded=false
      @b_bdmservice_detector_classes_loaded=false

      # The @ht_configurations holds bdmcomponent specific
      # configuration instances.
      @ht_configurations=Hash.new

      @ob_core_ui_texts=Breakdancemake_core_ui_texts.new
      @s_language=$kibuvits_s_language

      @s_lc_runcount="runcount".freeze
      @s_lc_fp_bdmprojectdescriptor_rb="./bdmprojectdescriptor.rb".freeze

      @x_impl_b_bdmprojectdescriptor_rb_is_available_cache_set=false
      @x_impl_b_bdmprojectdescriptor_rb_is_available_cache=false
      @b_bdmprojectdescriptor_rb_loaded=false

      @mx_bdmcomponent_registration=Monitor.new
      @s_version="v_1_1_0"
   end #initialize


   def Breakdancemake.s_version
      s_version=""+Breakdancemake.instance.s_version
      return s_version
   end # Breakdancemake.

   def Breakdancemake.get_instance
      ob=Breakdancemake.instance
      return ob
   end # Breakdancemake.get_instance


   #-----------------------------------------------------------------------

   private

   def verify_bdmcomponent_interface(ob_bdmcomponent_candidate)
      if !ob_bdmcomponent_candidate.kind_of? Breakdancemake_bdmcomponent
         kibuvits_throw("The ob_bdmcomponent_candidate.class=="+
         ob_bdmcomponent_candidate.class.to_s+
         " is not derived from class Breakdancemake_bdmcomponent, but "+
         "to meet the specifications every bdmcomponent has to be "+
         "derived from the class Breakdancemake_bdmcomponent.")
      end # if

      s_bdmcomponent_name=ob_bdmcomponent_candidate.s_bdmcomponent_name
      if s_bdmcomponent_name==@s_lc_1
         kibuvits_throw("The ob_bdmcomponent_candidate.s_bdmcomponent_name "+
         "has not been properly initialized in the "+
         "ob_bdmcomponent_candidate.class=="+
         ob_bdmcomponent_candidate.class.to_s)
      end # if

      bn=binding()
      s_assertion_msg_suffix= $kibuvits_lc_emptystring+
      "The ob_bdmcomponent_candidate.class=="+
      ob_bdmcomponent_candidate.class.to_s+
      " is derived from the class Breakdancemake_bdmcomponent. "

      kibuvits_assert_responds_2_method(bn,ob_bdmcomponent_candidate,
      :b_ready_for_use,s_assertion_msg_suffix)
      kibuvits_assert_responds_2_method(bn,ob_bdmcomponent_candidate,
      :s_status,s_assertion_msg_suffix)
      kibuvits_assert_responds_2_method(bn,ob_bdmcomponent_candidate,
      :s_summary_for_identities,s_assertion_msg_suffix)
   end # verify_bdmcomponent_interface

   def verify_bdmroutine_interface(ob_bdmroutine_candidate)
      verify_bdmcomponent_interface(ob_bdmroutine_candidate)
      if !ob_bdmroutine_candidate.kind_of? Breakdancemake_bdmroutine
         kibuvits_throw("The ob_bdmroutine_candidate.class=="+
         ob_bdmroutine_candidate.class.to_s+
         " is not derived from class Breakdancemake_bdmroutine, but "+
         "to meet the bdmroutine specifications every bdmroutine has to be "+
         "derived from the class Breakdancemake_bdmroutine.")
      end # if

      bn=binding()
      kibuvits_assert_class_name_prefix(bn,ob_bdmroutine_candidate,
      "Breakdancemake_bdmroutine_")

      s_assertion_msg_suffix= $kibuvits_lc_emptystring+
      "The ob_bdmroutine_candidate.class=="+ob_bdmroutine_candidate.class.to_s+
      " is derived from the class Breakdancemake_bdmroutine. "

      kibuvits_assert_responds_2_method(bn,ob_bdmroutine_candidate,
      :update_deployment,s_assertion_msg_suffix)
      kibuvits_assert_responds_2_method(bn,ob_bdmroutine_candidate,
      :run_bdmroutine,s_assertion_msg_suffix)
   end # verify_bdmroutine_interface

   def verify_bdmservice_detector_interface(ob_bdmservice_detector)
      verify_bdmcomponent_interface(ob_bdmservice_detector)
      if !ob_bdmservice_detector.kind_of? Breakdancemake_bdmservice_detector
         kibuvits_throw("The ob_bdmservice_detector.class=="+ob_bdmservice_detector.class.to_s+
         " is not derived from class Breakdancemake_bdmservice_detector, but "+
         "to meet the bdmservice detector specifications every bdmservice detector has to be "+
         "derived from the class Breakdancemake_bdmservice_detector.")
      end # if
      bn=binding()
      kibuvits_assert_class_name_prefix(bn,ob_bdmservice_detector,
      "Breakdancemake_bdmservice_detector_")

      #s_assertion_msg_suffix= $kibuvits_lc_emptystring+
      #"The ob_bdmroutine.class=="+ob_bdmservice_detector.class.to_s+
      #" is derived from the class Breakdancemake_bdmservice_detector. "
   end # verify_bdmservice_detector_interface

   def verify_bdmprojectdescriptor(ob_bdmprojectdescriptor_candidate)
      verify_bdmcomponent_interface(ob_bdmprojectdescriptor_candidate)
      if !ob_bdmprojectdescriptor_candidate.kind_of? Breakdancemake_bdmprojectdescriptor_base
         kibuvits_throw("The ob_bdmprojectdescriptor_candidate.class=="+
         ob_bdmprojectdescriptor_candidate.class.to_s+
         " is not derived from class Breakdancemake_bdmprojectdescriptor_base, but "+
         "to meet the bdmprojectdescriptor specifications every "+
         "bdmprojectdescriptor has to be derived from the "+
         "class Breakdancemake_bdmprojectdescriptor_base.")
      end # if
      bn=binding()
      kibuvits_assert_class_name_prefix(bn,ob_bdmprojectdescriptor_candidate,
      "Breakdancemake_bdmprojectdescriptor_")

      s_assertion_msg_suffix= $kibuvits_lc_emptystring+
      "The ob_bdmprojectdescriptor_candidate.class=="+ob_bdmprojectdescriptor_candidate.class.to_s+
      " is derived from the class Breakdancemake_bdmprojectdescriptor_base. "

      kibuvits_assert_responds_2_method(bn,ob_bdmprojectdescriptor_candidate,
      :ht_configurations,s_assertion_msg_suffix)

      # The reason, why the content of the
      # ob_bdmprojectdescriptor_candidate.ht_dependency_relations
      # can not be automatically updated according to the
      # ob_bdmprojectdescriptor_candidate.ht_configuration() output
      # is that the bdmprojectdescriptor might contain
      # bdmprojectdescriptors that are still under development
      # or one might want to use only those bdmroutines and
      # bdmprojectdescriptors that are ready for use.
   end # verify_bdmprojectdescriptor

   #-----------------------------------------------------------------------

   def load_bdmroutine_classes_if_not_already_loaded
      return if @b_bdmroutine_classes_loaded
      fl_p1=BREAKDANCEMAKE_HOME+"/src/bdmroutines/"
      i_len1=fl_p1.length
      rgx=/\/bdmroutine.rb$/
      match_data=nil
      Find.find(fl_p1) do |s_entry1|
         next if s_entry1.length==i_len1 # infinite recursion avoidance
         if File.directory?(s_entry1)
            Find.find(s_entry1) do |s_entry2|
               if !File.directory?(s_entry2)
                  match_data=rgx.match(s_entry2)
                  if match_data!=nil
                     require s_entry2
                     # The bdmroutine.rb-s contain
                     # calls to the Breakdancemake.declare_bdmcomponent
                     break
                  end # if
               end # if
            end # loop
         end # if
      end # loop
      @b_bdmroutine_classes_loaded=true
      @ht_bdmcomponents=@ht_bdmroutines.merge(@ht_bdmservice_detectors).merge(@ht_bdmprojectdescriptors)
   end # load_bdmroutine_classes_if_not_already_loaded

   public

   # It's a public method, because the loading of the
   # bdmservice detectors is not always necessary, but
   # bdmroutines that depend on bdmservices do need to load
   # at least the bdmservice detectors that they depend on.
   # For the sake of overall architectural simplicity one
   # either does not load them at all or loads all of them.
   def load_bdmservice_detector_classes_if_not_already_loaded
      return if @b_bdmservice_detector_classes_loaded
      fl_p1=BREAKDANCEMAKE_HOME+"/src/bdmservice_detectors/"
      i_len1=fl_p1.length
      rgx=/\/bdmservice_detector.rb$/
      match_data=nil
      Find.find(fl_p1) do |s_entry1|
         next if s_entry1.length==i_len1 # infinite recursion avoidance
         if File.directory?(s_entry1)
            Find.find(s_entry1) do |s_entry2|
               if !File.directory?(s_entry2)
                  match_data=rgx.match(s_entry2)
                  if match_data!=nil
                     require s_entry2
                     # The bdmservice_detector.rb-s contain
                     # calls to the Breakdancemake.declare_bdmcomponent
                     break
                  end # if
               end # if
            end # loop
         end # if
      end # loop
      @b_bdmservice_detector_classes_loaded=true
      @ht_bdmcomponents=@ht_bdmroutines.merge(@ht_bdmservice_detectors).merge(@ht_bdmprojectdescriptors)
   end # load_bdmservice_detector_classes_if_not_already_loaded

   #-----------------------------------------------------------------------

   # Calls the update_deployment on all of the bdmroutines.
   def update_deployment(s_language)
      @ht_bdmroutines.each_pair do |s_bdmcomponent_name,ob_bdmroutine|
         ob_bdmroutine.send(:update_deployment,s_language)
      end # loop
   end # update_deployment

   def Breakdancemake.update_deployment(s_language)
      Breakdancemake.instance.update_deployment(s_language)
   end # Breakdancemake.update_deployment

   #-----------------------------------------------------------------------

   private

   def declare_bdmroutine(ob_bdmroutine)
      verify_bdmroutine_interface(ob_bdmroutine)

      cl=ob_bdmroutine.class
      @mx_bdmcomponent_registration.synchronize do
         if @ht_bdmroutines_classes.has_key? cl
            bn=binding()
            kibuvits_throw("There exist a collision of bdmroutine classes. "+
            "More than one bdmroutine is of class "+cl.to_s+
            ". bdmroutine class collisions are not allowed.",bn)
         end # if
         @ht_bdmroutines_classes[cl]=ob_bdmroutine

         s_bdmcomponent_name=ob_bdmroutine.s_bdmcomponent_name
         if @ht_bdmroutines.has_key? s_bdmcomponent_name
            bn=binding()
            kibuvits_throw("There exist a collision of bdmroutine names. "+
            "More than one bdmroutine has a name of \""+s_bdmcomponent_name+
            "\", but each bdmroutine must have a unique name. The collision might "+
            "have been introduced during development by copying the source of one "+
            "bdmroutine source to the second and then forgetting to edit the "+
            "value of the @s_bdmcomponent_name within the "+
            "constructor of the new bdmroutine.",bn)
         end # if
         if @ht_bdmservice_detectors.has_key? s_bdmcomponent_name
            bn=binding()
            #TODO: replace it with a "polite" puts(...);exit
            #      The quotes around the "polite" are
            #      due to Estonian language peculiarities.
            kibuvits_throw("There exist a collision between bdmservice detector names "+
            "and bdmroutine names. The colliding name is: \""+s_bdmcomponent_name+"\"",bn)
         end # if
         if @ht_bdmprojectdescriptors.has_key? s_bdmcomponent_name
            bn=binding()
            #TODO: replace it with a "polite" puts(...);exit
            #      The quotes around the "polite" are
            #      due to Estonian language peculiarities.
            kibuvits_throw("There exist a collision between bdmprojectdescriptor names "+
            "and bdmroutine names. The colliding name is: \""+s_bdmcomponent_name+"\"",bn)
         end # if

         @ht_bdmroutines[s_bdmcomponent_name]=ob_bdmroutine
      end # synchronize
   end # declare_bdmroutine

   def declare_bdmservice_detector(ob_bdmservice_detector)
      verify_bdmservice_detector_interface(ob_bdmservice_detector)

      cl=ob_bdmservice_detector.class
      @mx_bdmcomponent_registration.synchronize do
         if @ht_bdmservice_detectors_classes.has_key? cl
            bn=binding()
            kibuvits_throw("There exist a collision of bdmservice detector "+
            "classes. More than one bdmservice detector is of class "+cl.to_s+
            ". bdmservice detector class collisions are not allowed.",bn)
         end # if
         @ht_bdmservice_detectors_classes[cl]=ob_bdmservice_detector

         s_bdmcomponent_name=ob_bdmservice_detector.s_bdmcomponent_name
         if @ht_bdmservice_detectors.has_key? s_bdmcomponent_name
            bn=binding()
            #TODO: replace it with a "polite" puts(...);exit
            #      The quotes around the "polite" are
            #      due to Estonian language peculiarities.
            kibuvits_throw("There exist a collision of bdmservice detector names. "+
            "More than one bdmservice detector has a name of \""+s_bdmcomponent_name+
            "\", but each bdmservice detector must have a unique name. The collision might "+
            "have been introduced during development by copying the source of one "+
            "bdmservice detector source to the second and then forgetting to edit the "+
            "value of the @s_bdmcomponent_name within the "+
            "constructor of the new bdmservice detector.",bn)
         end # if
         if @ht_bdmroutines.has_key? s_bdmcomponent_name
            bn=binding()
            #TODO: replace it with a "polite" puts(...);exit
            #      The quotes around the "polite" are
            #      due to Estonian language peculiarities.
            kibuvits_throw("There exist a collision between bdmservice detector names "+
            "and bdmroutine names. The colliding name is: \""+s_bdmcomponent_name+"\"",bn)
         end # if
         if @ht_bdmprojectdescriptors.has_key? s_bdmcomponent_name
            bn=binding()
            #TODO: replace it with a "polite" puts(...);exit
            #      The quotes around the "polite" are
            #      due to Estonian language peculiarities.
            kibuvits_throw("There exist a collision between bdmprojectdescriptor "+
            "names and bdmservice detector names. The colliding name is: \""+
            s_bdmcomponent_name+"\"",bn)
         end # if
         @ht_bdmservice_detectors[s_bdmcomponent_name]=ob_bdmservice_detector
      end # synchronize
   end # declare_bdmservice_detector

   def declare_bdmprojectdescriptor(ob_bdmprojectdescriptor)
      verify_bdmprojectdescriptor(ob_bdmprojectdescriptor)
      cl=ob_bdmprojectdescriptor.class
      @mx_bdmcomponent_registration.synchronize do
         if @ht_bdmprojectdescriptor_classes.has_key? cl
            bn=binding()
            kibuvits_throw("There exist a collision of bdmprojectdescriptor "+
            "classes. More than one bdmprojectdescriptor is of class "+cl.to_s+
            ". bdmprojectdescriptor class collisions are not allowed.",bn)
         end # if
         @ht_bdmprojectdescriptor_classes[cl]=ob_bdmprojectdescriptor

         s_bdmcomponent_name=ob_bdmprojectdescriptor.s_bdmcomponent_name
         if @ht_bdmprojectdescriptors.has_key? s_bdmcomponent_name
            bn=binding()
            #TODO: replace it with a "polite" puts(...);exit
            #      The quotes around the "polite" are
            #      due to Estonian language peculiarities.
            kibuvits_throw("There exist a collision of bdmprojectdescriptor names. "+
            "More than one bdmprojectdescriptor has a name of \""+s_bdmcomponent_name+
            "\", but each bdmprojectdescriptor must have a unique name. The collision might "+
            "have been introduced during development by copying the source of one "+
            "bdmprojectdescriptor source to the second and then forgetting to edit the "+
            "value of the @s_bdmcomponent_name within the "+
            "constructor of the new bdmprojectdescriptor.",bn)
         end # if
         if @ht_bdmroutines.has_key? s_bdmcomponent_name
            bn=binding()
            #TODO: replace it with a "polite" puts(...);exit
            #      The quotes around the "polite" are
            #      due to Estonian language peculiarities.
            kibuvits_throw("There exist a collision between bdmprojectdescriptor names "+
            "and bdmroutine names. The colliding name is: \""+s_bdmcomponent_name+"\"",bn)
         end # if
         if @ht_bdmservice_detectors.has_key? s_bdmcomponent_name
            bn=binding()
            #TODO: replace it with a "polite" puts(...);exit
            #      The quotes around the "polite" are
            #      due to Estonian language peculiarities.
            kibuvits_throw("There exist a collision between bdmprojectdescriptor names "+
            "and bdmservice detector names. The colliding name is: \""+s_bdmcomponent_name+"\"",bn)
         end # if

         ht_intersection=Kibuvits_finite_sets.intersection(@ht_configurations,
         ob_bdmprojectdescriptor.ht_configurations)
         if 0<ht_intersection.size
            bn=binding()
            #TODO: replace it with a "polite" puts(...);exit
            #      The quotes around the "polite" are
            #      due to Estonian language peculiarities.
            kibuvits_throw("\nThere exist a collision, where multiple bdmprojectdescriptors \n"+
            "contain configuration for bdmservice \""+ht_intersection.keys[0].to_s+"\".\n"+
            "The name of one of the participating bdmcomponents is: \""+
            s_bdmcomponent_name+"\"\n\n"+
            "    Proposed solution: in stead of trying to do everything during a single \n"+
            "    Breakdancemake run, run the Breakdancemake multiple times and use \n"+
            "    the method Breakdancemake.undeclare_all_bdmprojectdescriptors() after every run.\n\n",bn)
         end # if
         #-------------------------------------------------
         @ht_bdmprojectdescriptors[s_bdmcomponent_name]=ob_bdmprojectdescriptor

         # The bdmroutines and bdmservice detectors have that line
         # in the load-blabla methods.
         @ht_bdmcomponents=@ht_bdmroutines.merge(@ht_bdmservice_detectors).merge(@ht_bdmprojectdescriptors)

         # The configurations merger is not a problem, because
         # all of the loaded configuration can be reset, deleted
         # with the method "undeclare_all_bdmprojectdescriptors".
         @ht_configurations.merge!(ob_bdmprojectdescriptor.ht_configurations)
      end # synchronize
   end # declare_bdmprojectdescriptor

   public

   def declare_bdmcomponent(ob_bdmcomponent)
      s_bdmcomponent_type=ob_bdmcomponent.s_bdmcomponent_type
      case s_bdmcomponent_type
      when "bdmroutine"
         declare_bdmroutine(ob_bdmcomponent)
      when "bdmservice_detector"
         declare_bdmservice_detector(ob_bdmcomponent)
      when "bdmprojectdescriptor"
         declare_bdmprojectdescriptor(ob_bdmcomponent)
      else
         kibuvits_throw("s_bdmcomponent_type=="+s_bdmcomponent_type.to_s+
         ", but this method does not yet support "+
         "that type of bdmcomponents.")
      end # case s_mode
   end # declare_bdmcomponent

   def Breakdancemake.declare_bdmcomponent(ob_bdmcomponent)
      Breakdancemake.instance.declare_bdmcomponent(ob_bdmcomponent)
   end # Breakdancemake.declare_bdmcomponent

   def undeclare_all_bdmprojectdescriptors
      @mx_bdmcomponent_registration.synchronize do
         @ht_bdmprojectdescriptors.keys.each do |s_bdmcomponent_name|
            @ht_bdmcomponents.delete(s_bdmcomponent_name)
         end # loop
         @ht_configurations.clear
         @ht_bdmprojectdescriptor_classes.clear
         @ht_bdmprojectdescriptors.clear
      end # synchronize
   end # undeclare_all_bdmprojectdescriptors

   def Breakdancemake.undeclare_all_bdmprojectdescriptors
      Breakdancemake.instance.undeclare_all_bdmprojectdescriptors()
   end # Breakdancemake.undeclare_all_bdmprojectdescriptors

   #-----------------------------------------------------------------------
   private

   def assert_bdmroutine_name_OK_and_bdmroutine_loaded(s_bdmcomponent_name)
      bn=binding()
      kibuvits_typecheck bn, String,s_bdmcomponent_name
      kibuvits_assert_string_min_length(bn,s_bdmcomponent_name,1)
      if !@ht_bdmroutines.has_key? s_bdmcomponent_name
         kibuvits_throw("bdmroutine with a name of \""+s_bdmcomponent_name.to_s+
         "\" does not exist.")
      end # if
   end # assert_bdmroutine_name_OK_and_bdmroutine_loaded

   #-----------------------------------------------------------------------
   public

   # Returns true, if the ./bdmprojectdescriptor.rb is
   # a regular file and is readable.
   #
   # As file system access can be expensive in terms
   # of delays, there exists an option to use a cached
   # result.
   def b_bdmprojectdescriptor_rb_is_available(b_use_cached_value=false)
      b_out=false
      b_do_it_slow=true
      if b_use_cached_value
         if @x_impl_b_bdmprojectdescriptor_rb_is_available_cache_set
            b_out=@x_impl_b_bdmprojectdescriptor_rb_is_available_cache
            b_do_it_slow=false
         end # if
      end # if

      if b_do_it_slow
         if File.exists? @s_lc_fp_bdmprojectdescriptor_rb
            if File.file? @s_lc_fp_bdmprojectdescriptor_rb
               if File.readable? @s_lc_fp_bdmprojectdescriptor_rb
                  b_out=true
               end # if
            end # if
         end # if
         @x_impl_b_bdmprojectdescriptor_rb_is_available_cache_set=true
         @x_impl_b_bdmprojectdescriptor_rb_is_available_cache=b_out
      end # if
      return b_out
   end # b_bdmprojectdescriptor_rb_is_available

   def Breakdancemake.b_bdmprojectdescriptor_rb_is_available(b_use_cached_value=false)
      b_out=Breakdancemake.instance.b_bdmprojectdescriptor_rb_is_available(
      b_use_cached_value)
      return b_out
   end # Breakdancemake.b_bdmprojectdescriptor_rb_is_available

   #-----------------------------------------------------------------------
   public

   # It throws, if the Breakdancemake.b_bdmprojectdescriptor_rb_is_available()==true .
   # Otherwise it returns a string.
   def s_bdmroutine_status_if_the_bdmprojectdescriptor_rb_is_not_available_t1(s_language,
      s_bdmcomponent_name)
      s_out=$kibuvits_lc_emptystring
      if KIBUVITS_b_DEBUG
         bn=binding()
         kibuvits_typecheck bn, String,s_language
         assert_bdmroutine_name_OK_and_bdmroutine_loaded(s_bdmcomponent_name)
         if b_bdmprojectdescriptor_rb_is_available() # expensive due to file system access
            kibuvits_throw("b_bdmprojectdescriptor_rb_is_available()==true, but \n"+
            "this method is expected to be called only, when the bdmprojectdescriptor.rb is not available.\n")
         end # if
      end # if
      if !File.exists? @s_lc_fp_bdmprojectdescriptor_rb
         s_out=@ob_core_ui_texts.s_msg_bdmprojectdescriptor_rb_missing_t1(
         s_language,@s_lc_fp_bdmprojectdescriptor_rb)
      else
         if !File.file? @s_lc_fp_bdmprojectdescriptor_rb
            s_file_candidate_type=File.ftype(@s_lc_fp_bdmprojectdescriptor_rb)
            s_out=@ob_core_ui_texts.s_msg_bdmprojectdescriptor_rb_is_not_a_regular_file_t1(
            s_language,@s_lc_fp_bdmprojectdescriptor_rb,s_file_candidate_type)
         else
            if !File.readable? @s_lc_fp_bdmprojectdescriptor_rb
               s_out=Kibuvits_i18n_msgs_t1.s_msg_regular_file_exists_but_it_is_not_readable_t1(
               s_language,@s_lc_fp_bdmprojectdescriptor_rb)
            else
               kibuvits_throw("b_bdmprojectdescriptor_rb_is_available()==false, but "+
               "the file candidate, \""+@s_lc_fp_bdmprojectdescriptor_rb.to_s+"\", is a regular "+
               "file that is properly readable. "+
               "GUID=='94fc6334-bb31-4c1f-91e4-012201b13dd7'")
            end # if
         end # if
      end # if
      return s_out
   end # s_bdmroutine_status_if_the_bdmprojectdescriptor_rb_is_not_available_t1

   #-----------------------------------------------------------------------
   private

   # Throws, if the b_bdmprojectdescriptor_rb_is_available()==false
   def thrx_load_bdmprojectdescriptor_rb()
      b_throw=false
      if @b_bdmprojectdescriptor_rb_loaded
         if b_bdmprojectdescriptor_rb_is_available(b_use_cached_value=false)
            return 42
         else
            b_throw=true
         end # if
      else
         b_throw=true if !b_bdmprojectdescriptor_rb_is_available(b_use_cached_value=true)
      end # if
      if b_throw
         kibuvits_throw("b_bdmprojectdescriptor_rb_is_available()==false, but \n"+
         "this method is expected to be called only, when the bdmprojectdescriptor.rb "+
         "is available.\n")
      end # if
      require(@s_lc_fp_bdmprojectdescriptor_rb)
      @b_bdmprojectdescriptor_rb_loaded=true
   end # thrx_load_bdmprojectdescriptor_rb

   #-----------------------------------------------------------------------

   private

   def load_bdmprojectdescriptor_rb_if_possible
      return 42 if @b_bdmprojectdescriptor_rb_loaded
      return 42 if !b_bdmprojectdescriptor_rb_is_available(b_use_cached_value=true)
      b_thrown=false
      s_msg=nil
      begin
         thrx_load_bdmprojectdescriptor_rb()
      rescue Exception => e
         s_msg=e.to_s
         b_thrown=true
      end # rescue
      if KIBUVITS_b_DEBUG
         if b_thrown
            #kibuvits_throw("GUID='aff0f157-7df7-4403-b4e4-012201b13dd7', "+
            #"s_msg=="+s_msg)
         end # if
      end # if
   end # load_bdmprojectdescriptor_rb_if_possible

   def b_bdmroutine_configuration_from_bdmprojectdescriptor_rb_is_available(
      s_bdmcomponent_name)
      if KIBUVITS_b_DEBUG
         bn=binding()
         kibuvits_typecheck bn, String,s_bdmcomponent_name
      end # if
      load_bdmprojectdescriptor_rb_if_possible()
      b_out=false
      return b_out if !@b_bdmprojectdescriptor_rb_loaded
      if @ht_configurations.has_key? s_bdmcomponent_name
         b_out=true
      end # if
      return b_out
   end # b_bdmroutine_configuration_from_bdmprojectdescriptor_rb_is_available

   def b_bdmprojectdescriptor_rb_has_been_loaded_and_the_bdmroutine_configuration_is_missing(
      s_bdmcomponent_name)
      if KIBUVITS_b_DEBUG
         bn=binding()
         assert_bdmroutine_name_OK_and_bdmroutine_loaded(s_bdmcomponent_name)
      end # if
      b_out=false
      return b_out if !@b_bdmprojectdescriptor_rb_loaded
      if !@ht_configurations.has_key? s_bdmcomponent_name
         b_out=true
      end # if
      return b_out
   end # b_bdmprojectdescriptor_rb_has_been_loaded_and_the_bdmroutine_configuration_is_missing

   #-----------------------------------------------------------------------

   public

   # Returns an object or nil, if the configuration is not present.
   def x_get_configuration_t1(s_bdmcomponent_name)
      if KIBUVITS_b_DEBUG
         bn=binding()
         kibuvits_typecheck bn, String,s_bdmcomponent_name
         kibuvits_assert_string_min_length(bn,s_bdmcomponent_name,1)
      end # if
      ob_config=nil
      @mx_bdmcomponent_registration.synchronize do
         if @ht_configurations.has_key? s_bdmcomponent_name
            ob_config=@ht_configurations[s_bdmcomponent_name]
            return ob_config
         end # if
         if b_bdmroutine_configuration_from_bdmprojectdescriptor_rb_is_available(
            s_bdmcomponent_name)
            if !@ht_configurations.has_key? s_bdmcomponent_name
               kibuvits_throw("s_bdmcomponent_name=="+s_bdmcomponent_name.to_s+
               "\nGUID='81fead5c-029d-47d1-b1d4-012201b13dd7'")
            end # if
            ob_config=@ht_configurations[s_bdmcomponent_name]
         end # if
      end # synchronize
      return ob_config
   end # x_get_configuration_t1

   def Breakdancemake.x_get_configuration_t1(s_bdmcomponent_name)
      ob_config=Breakdancemake.instance.x_get_configuration_t1(
      s_bdmcomponent_name)
   end # Breakdancemake.x_get_configuration_t1

   #-----------------------------------------------------------------------

   # Returns a hashtable with keys: s_mode, s_status
   #
   # s_status has always a value that is a string.
   # The s_mode can have only the following values:
   # "s_mode_inactive_due_to_undetermined_reason" ,
   # "s_mode_active",  "s_mode_inactive"
   def ht_bdmroutine_status_if_bdmprojectdescriptor_rb_is_compulsory_t1(s_language,
      ob_bdmroutine)
      if KIBUVITS_b_DEBUG
         bn=binding()
         kibuvits_typecheck bn, String,s_language
         if !ob_bdmroutine.kind_of? Breakdancemake_bdmroutine
            kibuvits_throw("ob_bdmroutine.class=="+
            ob_bdmroutine.class.to_s)
         end # if
      end # if
      ht_out=Hash.new
      s_bdmcomponent_name=ob_bdmroutine.s_bdmcomponent_name
      x_out=nil
      @mx_bdmcomponent_registration.synchronize do
         if ob_bdmroutine.b_ready_for_use()
            ht_out[$kibuvits_lc_s_mode]=$kibuvits_lc_s_mode_active
            ht_out[$kibuvits_lc_s_status]=@ob_core_ui_texts.s_breakdancemake_cl_bdmfunction_is_ready_for_use_t1(
            s_language)
         else
            if b_bdmprojectdescriptor_rb_is_available()
               s=s_bdmcomponent_name
               if b_bdmprojectdescriptor_rb_has_been_loaded_and_the_bdmroutine_configuration_is_missing(s)
                  ht_out[$kibuvits_lc_s_mode]=$kibuvits_lc_s_mode_inactive
                  ht_out[$kibuvits_lc_s_status]=@ob_core_ui_texts.s_breakdancemake_cl_bdmfunction_is_inactive_due_to_to_missing_config_t1(
                  s_language,s_bdmcomponent_name)
               else
                  # Something is wrong with the available config.
                  ht_out[$kibuvits_lc_s_mode]=$kibuvits_lc_s_mode_inactive_due_to_undetermined_reason
                  ht_out[$kibuvits_lc_s_status]=@ob_core_ui_texts.s_breakdancemake_cl_bdmfunction_is_inactive_despite_the_config_availability(
                  s_language,s_bdmcomponent_name)
                  #ht_out[$kibuvits_lc_s_status]=@ob_core_ui_texts.s_breakdancemake_cl_bdmfunction_is_inactive_for_undetermined_reasons_t1(
                  #s_language,s_bdmcomponent_name)
               end # if
            else
               ht_out[$kibuvits_lc_s_mode]=$kibuvits_lc_s_mode_inactive
               ht_out[$kibuvits_lc_s_status]=s_bdmroutine_status_if_the_bdmprojectdescriptor_rb_is_not_available_t1(
               s_language,s_bdmcomponent_name)
            end # if
         end # if
      end # synchronize
      return ht_out
   end # ht_bdmroutine_status_if_bdmprojectdescriptor_rb_is_compulsory_t1

   #-----------------------------------------------------------------------
   private

   def s_summary_for_identities(s_language)
      s_out=@ob_core_ui_texts.s_breakdancemake_cl_s_summary_for_identities(s_language)
      return s_out
   end # s_summary_for_identities

   def run_display_default_help_msg_and_exit_if_necessary(s_language,
      ar_console_arguments)
      i_len=ar_console_arguments.size
      b_display_default_help=false
      if i_len==0
         b_display_default_help=true
      else
         if 1<=i_len
            s_par2=ar_console_arguments[0]
            if s_par2=="-?"
               b_display_default_help=true
            elsif s_par2=="-h"
               b_display_default_help=true
            elsif s_par2=="--help"
               b_display_default_help=true
            end # if
         end # if
      end # if
      if b_display_default_help
         puts s_summary_for_identities(s_language)
         exit
      end # if
   end # run_display_default_help_msg_and_exit_if_necessary

   #-----------------------------------------------------------------------

   # Puts a message to console and exits, if a bdmroutine
   # with a name held by the s_bdmcomponent_name_candidate
   # does not exist.
   def verify_bdmroutine_existence(s_language,s_bdmcomponent_name_candidate,
      s_error_message_suffix=nil)
      if KIBUVITS_b_DEBUG
         bn=binding()
         kibuvits_typecheck bn, String,s_language
         kibuvits_typecheck bn, String,s_bdmcomponent_name_candidate
         kibuvits_typecheck bn, [NilClass,String],s_error_message_suffix
      end # if
      if !@ht_bdmroutines.has_key? s_bdmcomponent_name_candidate
         msg=@ob_core_ui_texts.s_breakdancemake_cl_msg_1(
         s_language,s_bdmcomponent_name_candidate)
         msg=msg+s_error_message_suffix if s_error_message_suffix!=nil
         puts msg
         exit
      end # if
   end # verify_bdmroutine_existence

   # Puts a message to console and exits, if a neither a bdmroutine
   # nor a bdmservice detector with a name held by the
   # s_bdmcomponent_name_candidate does not exist.
   def verify_routine_existence(s_language,s_routine_name_candidate,
      s_error_message_suffix=nil)
      if KIBUVITS_b_DEBUG
         bn=binding()
         kibuvits_typecheck bn, String,s_language
         kibuvits_typecheck bn, String,s_routine_name_candidate
         kibuvits_typecheck bn, [NilClass,String],s_error_message_suffix
      end # if
      if !@ht_bdmroutines.has_key? s_routine_name_candidate
         if !@ht_bdmservice_detectors.has_key? s_routine_name_candidate
            msg=@ob_core_ui_texts.s_breakdancemake_cl_msg_3(
            s_language,s_routine_name_candidate)
            msg=msg+s_error_message_suffix if s_error_message_suffix!=nil
            puts msg
            exit
         end # if
      end # if
   end # verify_routine_existence


   #--------------------------------------------------------------------------
   public

   # Returns the (<number of times the bdmroutine has been entered>)-
   # - (<number of times the bdmroutine has been exited>)
   #
   # If the application has only a single thread, then
   # the returned whole number matches with the
   # bdmroutine recursion depth.
   def i_get_bdmroutine_runcount(s_bdmcomponent_name,s_language)
      verify_bdmroutine_existence(s_language,s_bdmcomponent_name) # has type check
      ob_bdmroutine=@ht_bdmroutines[s_bdmcomponent_name]
      ht_bdmrec=ob_bdmroutine.ht_breakdancemake_records
      if !ht_bdmrec.has_key? @s_lc_runcount
         ht_bdmrec[@s_lc_runcount]=0
      end # if
      i_out=ht_bdmrec[@s_lc_runcount]
      return i_out
   end # i_get_bdmroutine_runcount

   def Breakdancemake.i_get_bdmroutine_runcount(s_bdmcomponent_name)
      i_out=Breakdancemake.instance.i_get_bdmroutine_runcount(
      s_bdmcomponent_name)
      return i_out
   end # Breakdancemake.i_get_bdmroutine_runcount

   def exec_task_from_bdmprojectdescriptor_rb_or_exit_with_msg(s_language,
      s_bdmcomponent_name,s_or_sym_method_name,a_binding)
      if KIBUVITS_b_DEBUG
         bn=binding()
         kibuvits_typecheck bn, String, s_language
         kibuvits_typecheck bn, [Symbol,String], s_or_sym_method_name
         kibuvits_typecheck bn, Binding, a_binding
         kibuvits_assert_string_min_length(a_binding,s_language,1)
         if s_or_sym_method_name.class==String
            kibuvits_assert_string_min_length(a_binding,s_or_sym_method_name,1)
         end # if
      end # if
      assert_bdmroutine_name_OK_and_bdmroutine_loaded(s_bdmcomponent_name)
      ob_bdmroutine_config=x_get_configuration_t1(s_bdmcomponent_name)
      sym=s_or_sym_method_name
      sym=s_or_sym_method_name.to_sym if s_or_sym_method_name.class==String
      if ob_bdmroutine_config.respond_to? sym
         ob_bdmroutine_config.method(sym).call
      else
         # TODO: improve the error message.
         msg=Kibuvits_i18n_msgs_t1.s_msg_method_is_missing_t1(
         s_language,ob_bdmroutine_config,sym.to_s,a_binding)
         puts(msg);exit
      end # if
   end # exec_task_from_bdmprojectdescriptor_rb_or_exit_with_msg

   def Breakdancemake.exec_task_from_bdmprojectdescriptor_rb_or_exit_with_msg(
      s_language,ob_config,s_or_sym_method_name,a_binding)
      Breakdancemake.instance.exec_task_from_bdmprojectdescriptor_rb_or_exit_with_msg(
      s_language,ob_config,s_or_sym_method_name,a_binding)
   end # Breakdancemake.exec_task_from_bdmprojectdescriptor_rb_or_exit_with_msg

   #--------------------------------------------------------------------------

   public

   # Returns
   #
   # b_dependencies_are_NOT_ready_for_use --- A boolean.
   #
   #       s_name_of_the_unmet_dependency --- Equals with an empty string,
   #                                          if a set of dependencies is
   #                                          ready for use.
   #
   def b_s_dependencies_are_met(s_bdmcomponent_name,
      ht_cycle_detection_opmem=Hash.new, fd_threshold=1.0)
      if KIBUVITS_b_DEBUG
         bn=binding()
         kibuvits_typecheck bn, String, s_bdmcomponent_name
      end # if
      b_dependencies_are_NOT_ready_for_use=false
      s_name_of_the_unmet_dependency=$kibuvits_lc_emptystring
      load_bdmroutine_classes_if_not_already_loaded
      load_bdmservice_detector_classes_if_not_already_loaded
      ht_objects=@ht_bdmcomponents
      s_ob_name=s_bdmcomponent_name
      if !ht_objects.has_key? s_ob_name
         kibuvits_throw("s_ob_name=="+s_ob_name.to_s+
         "\nGUID='2620fb26-93d6-42c1-95d4-012201b13dd7'")
      end # if
      ht_dependency_relations=ht_objects[s_ob_name].ht_dependency_relations
      sym_b_ready_for_use="b_ready_for_use".to_sym
      fd_availability, ht_selected_dependencies=Kibuvits_dependencymetrics_t1.fd_ht_get_availability(
      s_ob_name,ht_dependency_relations,ht_objects,sym_b_ready_for_use,
      ht_cycle_detection_opmem,fd_threshold)
      if 1<=fd_availability
         return b_dependencies_are_NOT_ready_for_use,s_name_of_the_unmet_dependency
      end # if
      b_dependencies_are_NOT_ready_for_use=true
      if ht_selected_dependencies.keys.length==0
         s_name_of_the_unmet_dependency=$kibuvits_lc_emptystring+s_ob_name
         return b_dependencies_are_NOT_ready_for_use,s_name_of_the_unmet_dependency
      end # if
      ht_selected_dependencies.each_pair do |s_key,s_value|
         if !ht_objects.has_key? s_value
            s_name_of_the_unmet_dependency=$kibuvits_lc_emptystring+s_value
            return b_dependencies_are_NOT_ready_for_use,s_name_of_the_unmet_dependency
         end # if
      end # loop
      ht_1=nil
      ht_selected_dependencies.each_pair do |s_key,s_value|
         ht_dependency_relations=ht_objects[s_value].ht_dependency_relations
         fd_availability,ht_1=Kibuvits_dependencymetrics_t1.fd_ht_get_availability(
         s_value,ht_dependency_relations,ht_objects,sym_b_ready_for_use)
         if fd_availability<1
            s_name_of_the_unmet_dependency=$kibuvits_lc_emptystring+s_value
            return b_dependencies_are_NOT_ready_for_use,s_name_of_the_unmet_dependency
         end # if
      end # loop
      kibuvits_throw("s_ob_name=="+s_ob_name.to_s+
      "\nGUID='d3f16a44-87e4-4489-a5d4-012201b13dd7'")
   end # b_s_dependencies_are_met

   def Breakdancemake.b_s_dependencies_are_met(s_bdmcomponent_name,
      ht_cycle_detection_opmem=Hash.new, fd_threshold=1.0)
      b_dependencies_are_NOT_ready_for_use,s_name_of_the_unmet_dependency=Breakdancemake.instance.b_s_dependencies_are_met(
      s_bdmcomponent_name,ht_cycle_detection_opmem,fd_threshold)
      return b_dependencies_are_NOT_ready_for_use,s_name_of_the_unmet_dependency
   end # Breakdancemake.b_s_dependencies_are_met

   #--------------------------------------------------------------------------

   # Returns the bdmroutine or bdmservice detector instance.
   def ob_get_routine(s_bdmroutine_or_bdmservice_detector_name)
      if KIBUVITS_b_DEBUG
         bn=binding()
         kibuvits_typecheck bn, String, s_bdmroutine_or_bdmservice_detector_name
      end # if
      s_x_name=s_bdmroutine_or_bdmservice_detector_name
      if @ht_bdmroutines.has_key?(s_x_name)
         ob_out=@ht_bdmroutines[s_x_name]
      else
         if @ht_bdmservice_detectors.has_key? s_x_name
            ob_out=@ht_bdmservice_detectors[s_x_name]
         else
            kibuvits_throw("Either this method is not updated to use "+
            "any other routine types but the bdmroutines and bdmservice detectors "+
            "or the routine with the name \""+s_x_name+"\" has not been loaded.")
         end # if
      end # if
      return ob_out
   end # ob_get_routine

   def Breakdancemake.ob_get_routine(s_bdmroutine_or_bdmservice_detector_name)
      ob_out=Breakdancemake.instance.ob_get_routine(
      s_bdmroutine_or_bdmservice_detector_name)
      return ob_out
   end # Breakdancemake.ob_get_routine

   #--------------------------------------------------------------------------

   # If it does not exit or throw, then it returns 2 values:
   # b_dependencies_met, msg
   #
   # If the b_dependencies_met==true, then the msg is an empty string.
   # If the b_dependencies_met==false, then the msg contains a message.
   #
   # s_mode inSet {"s_mode_throw", "s_mode_exit", "s_mode_return_msg"}
   #
   # Exiting or throwing occurs only, when at least one of the
   # bdmroutine or bdmservice detector dependencies is not met.
   def assertxmsg_dependencies_are_met(s_language,
      s_bdmroutine_or_bdmservice_detector_name,s_mode=$kibuvits_lc_s_mode_exit)
      if KIBUVITS_b_DEBUG
         bn=binding()
         kibuvits_typecheck bn, String, s_language
         kibuvits_typecheck bn, String, s_bdmroutine_or_bdmservice_detector_name
         kibuvits_typecheck bn, String, s_mode
      end # if
      s_x_name=s_bdmroutine_or_bdmservice_detector_name
      b_dependencies_are_NOT_ready_for_use,s_name_of_the_unmet_dependency=b_s_dependencies_are_met(
      s_x_name)
      b_deps_met=!b_dependencies_are_NOT_ready_for_use
      msg=$kibuvits_lc_emptystring
      if b_deps_met
         return b_deps_met, msg
      end # if
      s_name=s_name_of_the_unmet_dependency
      msg=@ob_core_ui_texts.s_breakdancemake_cl_dependencies_are_not_met_t1(
      s_language,s_x_name,s_name)

      case s_mode
      when $kibuvits_lc_s_mode_throw
         kibuvits_throw(msg)
      when $kibuvits_lc_s_mode_exit
         puts(msg);exit
      when $kibuvits_lc_s_mode_return_msg
         return b_deps_met, msg
      else
         kibuvits_throw("s_mode=="+s_mode+
         ", but this method does not yet support that mode.")
      end # case s_mode
      kibuvits_throw("GUID='2ecbc653-004c-4cbc-92d4-012201b13dd7'")
   end # assertxmsg_dependencies_are_met

   def Breakdancemake.assertxmsg_dependencies_are_met(s_language,
      s_bdmroutine_or_bdmservice_detector_name,s_mode=$kibuvits_lc_s_mode_exit)
      b_deps_met, msg=Breakdancemake.instance.assertxmsg_dependencies_are_met(
      s_language,s_bdmroutine_or_bdmservice_detector_name,s_mode)
      return b_deps_met, msg
   end # Breakdancemake.assertxmsg_dependencies_are_met

   #--------------------------------------------------------------------------

   # It's OK to re-declare the config objects.
   # A configuration redeclaration overwrites
   # the previously present configuration.
   def declare_configuration(s_bdmcomponent_name,ob_bdmroutine_configuration)
      if KIBUVITS_b_DEBUG
         bn=binding()
         kibuvits_typecheck bn, String, s_bdmcomponent_name
      end # if
      @mx_bdmcomponent_registration.synchronize do
         @ht_configurations[s_bdmcomponent_name]=ob_bdmroutine_configuration
      end # synchronize
   end # declare_configuration

   def Breakdancemake.declare_configuration(s_bdmcomponent_name,ob_bdmroutine_configuration)
      Breakdancemake.instance.declare_configuration(
      s_bdmcomponent_name,ob_bdmroutine_configuration)
   end # Breakdancemake.declare_configuration

   #--------------------------------------------------------------------------

   private

   def run_load_bdmprojectdescriptor_rb_if_needed(s_language,ob_bdmroutine)
      s_bdmcomponent_name=ob_bdmroutine.s_bdmcomponent_name
      @mx_bdmcomponent_registration.synchronize do
         if !@ht_configurations.has_key? s_bdmcomponent_name
            b_bdmprojectdescriptor_rb_is_available(b_use_cached_value=false) # for updating
            if ob_bdmroutine.b_requires_runtime_configuration()
               if !@b_bdmprojectdescriptor_rb_loaded
                  if !b_bdmprojectdescriptor_rb_is_available(b_use_cached_value=true)
                     s_msg=s_bdmroutine_status_if_the_bdmprojectdescriptor_rb_is_not_available_t1(
                     s_language,s_bdmcomponent_name)
                     puts(s_msg);exit
                  end # if
                  thrx_load_bdmprojectdescriptor_rb()
               end # if
               if !@ht_configurations.has_key? s_bdmcomponent_name
                  s_out=@ob_core_ui_texts.s_msg_bdmprojectdescriptor_rb_misses_configuration_t1(
                  s_language,s_bdmcomponent_name)
                  puts(s_out);exit
               end # if
            else
               if ob_bdmroutine.b_optionally_uses_runtime_configuration()
                  if !@b_bdmprojectdescriptor_rb_loaded
                     if b_bdmprojectdescriptor_rb_is_available(b_use_cached_value=true)
                        thrx_load_bdmprojectdescriptor_rb()
                     end # if
                  end # if
               end # if
            end # if
         end # if
         # One should not exit/throw, if one finds some
         # bdmroutine names in the @ht_configurations that
         # does not exist in the installation, because during
         # bdmroutine development one might want to draft the
         # "Makefile" content before actually completing the
         # bdmroutine code.
         #
         # However, for bdmroutines that are part of the installation
         # and really, never, use anything from the bdmprojectdescriptor.rb,
         # one should stop the execution with an error message,
         # because it takes just a few lines of publicly declared
         # and illustrated bdmroutines' interface code to declare
         # the bdmroutine as bdmprojectdescriptor.rb user and one might
         # have written the existing bdmroutine name as a mistake.
         #
         # For example: if one develops a bdmroutine named "is" that
         # uses the bdmprojectdescriptor.rb, but
         # accidentally writes to the bdmprojectdescriptor.rb its name as "ls",
         # while the "ls" is an existing bdmroutine that does not ever
         # use the bdmprojectdescriptor.rb, then one can detect the mis-naming
         # mistake and the following check comes handy:
         b_does_not_use_the_bdmprojectdescriptor_rb_at_all=nil
         @ht_bdmroutines.each_pair do |s_bdmcomponent_name,ob_bdmroutine|
            next if !@ht_configurations.has_key? s_bdmcomponent_name
            b_does_not_use_the_bdmprojectdescriptor_rb_at_all=true
            b_does_not_use_the_bdmprojectdescriptor_rb_at_all=false if ob_bdmroutine.b_requires_runtime_configuration()
            b_does_not_use_the_bdmprojectdescriptor_rb_at_all=false if ob_bdmroutine.b_optionally_uses_runtime_configuration()
            if b_does_not_use_the_bdmprojectdescriptor_rb_at_all
               s_out=@ob_core_ui_texts.s_msg_bdmprojectdescriptor_rb_contains_config_for_nonconfiguser_t1(
               s_language,s_bdmcomponent_name)
               puts(s_out);exit
            end # if
         end # loop
      end # synchronize
   end # run_load_bdmprojectdescriptor_rb_if_needed

   #--------------------------------------------------------------------------

   # The reason, why the Breakdancemake_bdmroutine.run_bdmroutine
   # is wrapped to this method is to allow various
   # kind of accountancy to take place without complicating
   # the Breakdancemake_bdmroutine API. If the accountancy is
   # outside of the Breakdancemake_bdmroutine API, then one
   # can refactor the accountancy without changing the
   # bdmroutine implementations.
   def run_bdmroutine_impl(s_language,s_bdmcomponent_name_candidate,
      ar_parameters,b_started_from_console)
      # The bdmroutine existence verification, like
      #     verify_bdmroutine_existence(s_language,s_bdmcomponent_name_candidate,
      #         s_summary_for_identities(s_bdmcomponent_name_candidate))
      # has to be done before entering this method.
      bn=binding()
      ob_bdmroutine=@ht_bdmroutines[s_bdmcomponent_name_candidate]
      run_load_bdmprojectdescriptor_rb_if_needed(s_language,ob_bdmroutine)
      ht_bdmrec=ob_bdmroutine.ht_breakdancemake_records
      if !ht_bdmrec.has_key? @s_lc_runcount
         ht_bdmrec[@s_lc_runcount]=1
      else
         Kibuvits_htoper.plus(ht_bdmrec,@s_lc_runcount,1,bn)
      end # if
      ob_bdmroutine.send(:run_bdmroutine,
      s_language,ar_parameters,b_started_from_console)
      # Decrementation is needed in stead of
      # raw zero assignment, because there could be cycles.
      Kibuvits_htoper.plus(ht_bdmrec,@s_lc_runcount,(-1),bn)
   end # run_bdmroutine_impl

   #--------------------------------------------------------------------------
   public

   # ar_parameters is passed on to the
   # Breakdancemake_bdmroutine.run_bdmroutine
   # without any modifications.
   #
   # The ar_parameters consists of the sub-part of the ARGV that
   # contains the bdmroutine specific console arguments.
   def run_bdmroutine(s_language,s_bdmcomponent_name_candidate,ar_parameters)
      if KIBUVITS_b_DEBUG
         bn=binding()
         kibuvits_typecheck bn, String, s_language
         kibuvits_typecheck bn, String, s_bdmcomponent_name_candidate
         kibuvits_typecheck bn, Array, ar_parameters
      end # if
      verify_bdmroutine_existence(s_language,s_bdmcomponent_name_candidate)
      run_bdmroutine_impl(s_language,s_bdmcomponent_name_candidate,
      ar_parameters,b_started_from_console=false)
   end # run_bdmroutine

   def Breakdancemake.run_bdmroutine(s_language,
      s_bdmcomponent_name_candidate,ar_parameters)
      Breakdancemake.instance.run_bdmroutine(s_language,
      s_bdmcomponent_name_candidate,ar_parameters)
   end # Breakdancemake.run_bdmroutine

   #--------------------------------------------------------------------------
   private

   # The ar_console_arguments[0]==<bdmroutine name>
   # and one wants to skip that from the ar_parameters
   def run_ar_extract_bdmroutine_arguments_from_console_arguments(
      ar_console_arguments)
      i_len=nil
      if KIBUVITS_b_DEBUG
         bn=binding()
         kibuvits_typecheck bn, Array,ar_console_arguments
         i_len=ar_console_arguments.size
         if i_len<1
            kibuvits_throw("i_len=="+i_len.to_s+" < 1 , but the "+
            "ar_console_arguments[0] has to contain the bdmroutine name.")
         end # if
      else
         i_len=ar_console_arguments.size
      end # if
      ar_parameters=nil
      if 1<i_len
         ar_parameters=ar_console_arguments[1..(-1)]
      else
         ar_parameters=Array.new
      end # if
      return ar_parameters
   end # run_ar_extract_bdmroutine_arguments_from_console_arguments

   public

   # The main and only entry to the breakdancemake.
   def run(ar_console_arguments, s_language=nil)
      bn=binding() # also used for other purposes than the type checks
      if KIBUVITS_b_DEBUG
         # The bn is declared a few lines upwards. It's not a totally silly comment. :-)
         kibuvits_typecheck bn, Array,ar_console_arguments
         kibuvits_typecheck bn, [NilClass,String],s_language
         if s_language.class==String
            kibuvits_assert_string_min_length(bn,s_language,1)
         end # if
      end # if
      if s_language.class==String
         @s_language=s_language
      else
         s_language=@s_language
      end # if
      run_display_default_help_msg_and_exit_if_necessary(
      s_language,ar_console_arguments)
      load_bdmroutine_classes_if_not_already_loaded
      s_bdmcomponent_name_candidate=ar_console_arguments[0].gsub(/\n\r/,
      $kibuvits_lc_emptystring)
      verify_bdmroutine_existence(s_language,s_bdmcomponent_name_candidate,
      s_summary_for_identities(s_language))
      ar_parameters=run_ar_extract_bdmroutine_arguments_from_console_arguments(
      ar_console_arguments)
      run_bdmroutine_impl(s_language,s_bdmcomponent_name_candidate,
      ar_parameters,b_started_from_console=true)
   end # run

   # In the most simplistic case the ar_console_arguments==ARGV
   def Breakdancemake.run(ar_console_arguments)
      Breakdancemake.instance.run(ar_console_arguments)
   end # Breakdancemake.run

   public
   include Singleton
end # class Breakdancemake

#--------------------------------------------------------------------------
# Breakdancemake.run(ARGV)
#puts "hobune breakdancemake_cl.rb's"
#==========================================================================

