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

# A bdmcomponent (Estonian: bdmkomponent) is a generalized name for
# bdmroutines, bdmservice detectors and bdmprojectdescriptors.
class Breakdancemake_bdmcomponent
   attr_reader :s_bdmcomponent_type
   attr_reader :s_bdmcomponent_name

   # The @ht_breakdancemake_records is meant to be used
   # only by the Breakdancemake framework implementation.
   # The content format of the @ht_breakdancemake_records
   # is subject to change and bdmroutine developers must
   # never depend directly on the @ht_breakdancemake_records.
   #
   # One way to look at the @ht_breakdancemake_records is
   # that it allows the Breakdancemake implementation to
   # apply various runtime tags to the bdmroutines.
   #
   # The reason, why one declares a hashtable, the
   # @ht_breakdancemake_records, in the bdmroutine interface
   # description class Breakdancemake_bdmroutine, in stead
   # of deriving the Breakdancemake_bdmroutine from some
   # Breakdancemake bdmroutines' common implementation class,
   # like Breakdancemake_bdmroutine < Breakdancemake_bdmroutine_bonnet,
   # is that there could be name clashes between the
   # Breakdancemake_bdmroutine_bonnet and field names that the
   # bdmroutine developers use. If a field that contains all
   # of the implementation specific data is declared as part of the
   # interface, then bdmroutine developers only need to avoid one
   # field name and automated documentation generators
   # will not show Breakdancemake framework specific methods,
   # i.e. the Breakdancemake_bdmroutine_bonnet methods, as part of
   # bdmroutine class methods. That is to say, by keeping framework
   # implementation specific methods outside of the bdmroutine
   # class hierarchy, one keeps the bdmroutine API cleaner.
   attr_reader :ht_breakdancemake_records

   # The format of the ht_dependency_relations matches with the format that the
   # Kibuvits_dependencymetrics_t1.fd_ht_get_availability uses.
   #
   # The names within the ht_dependency_relations are expected to be
   # bdmroutine and bdmservice names.
   attr_reader :ht_dependency_relations

   attr_accessor :b_bdmcomponent_availability_is_static
   def initialize
      @ob_breakdancemake=Breakdancemake.get_instance
      @s_bdmcomponent_name=@ob_breakdancemake.s_lc_1
      @msgcs=@ob_breakdancemake.msgcs
      @ht_breakdancemake_records=Hash.new # described next to the attr_reader
      @ht_dependency_relations=Hash.new # described next to the attr_reader

      # The @ob_core_ui_texts references an instance of
      # the class Breakdancemake_core_ui_texts, which contains
      # user interface (hence the acronym: UI) texts of the
      # breakdancemake core and some common texts that might
      # be useful as bdmroutine or bdmroutine detector output messages.
      # The UI text wrapper classes are for i18n.
      @ob_core_ui_texts=@ob_breakdancemake.ob_core_ui_texts

      # If a bdmservice is a web service,
      # then a loss of a network connection renders the
      # bdmservice to be unavailable. Applications that
      # have been installed to the local machine and
      # are available by the PATH, are "usually"
      # available all the time, except when they reside
      # in network folders, etc. The availability of bdmcomponents
      # that do not depend on web services can be considered to be
      # constant during a single breakdancemake run.
      @b_bdmcomponent_availability_is_static=true

      # The @b_ready_for_use_cache is mostly
      # meant to be used only with statically available bdmservices.
      @b_ready_for_use_cache=false
      @b_ready_for_use_cache_set=false

      # Alternative values: "bdmroutine", "bdmservice_detector"
      @s_bdmcomponent_type="bdmprojectdescriptor".freeze
   end #initialize


   protected

   # Returns a boolean value of true, if the bdmcomponent is
   # available. Otherwise returns the boolean value of false.
   #
   # This method MUST NOT use the variables
   # @b_ready_for_use_cache and  @b_ready_for_use_cache_set
   # because if the @b_bdmcomponent_availability_is_static==true, then
   # it is used for initializing the @b_ready_for_use_cache .
   # The default implementation of the b_ready_for_use(...) explains it.
   #
   # The semantics of the ht_cycle_detection_opmem and the 
   # fd_threshold matches with the semantics that is used 
   # in the Kibuvits_dependencymetrics_t1.fd_ht_get_availability
   def b_assess_bdmcomponent_availability(ht_cycle_detection_opmem,
      fd_threshold)
      kibuvits_throw("This method is expected to be over-ridden.")
   end # b_assess_bdmcomponent_availability

   public

   # bdmroutines, bdmservices, etc. may depend on other installed
   # bdmcomponents, which might be missing from the system. For example,
   # an interpreter or a compiler might have not been installed yet.
   #
   # The semantics of the ht_cycle_detection_opmem and the 
   # fd_threshold matches with the semantics that is used 
   # in the Kibuvits_dependencymetrics_t1.fd_ht_get_availability
   def b_ready_for_use(ht_cycle_detection_opmem=Hash.new,fd_threshold=1.0)
      # In case of bdmroutines this method tends to be overridden.
      b_out=nil
      if @b_bdmcomponent_availability_is_static
         if !@b_ready_for_use_cache_set
            @b_ready_for_use_cache=b_assess_bdmcomponent_availability(
				ht_cycle_detection_opmem,fd_threshold)
            @b_ready_for_use_cache_set=true
         end # if
         b_out=@b_ready_for_use_cache
      else
         b_out=b_assess_bdmcomponent_availability(
			 ht_cycle_detection_opmem,fd_threshold)
      end # if
      return b_out
   end # b_ready_for_use

   # The main purpose of the method s_status
   # is to give feedback about the reasons, why the
   # bdmcomponent is not available, i.e.
   # why the method b_ready_for_use() returns a
   # boolean value of false.
   #
   # If the b_ready_for_use() returns the boolean value of true,
   # then the s_status should just return some polite text that
   # says that things are running smoothly and the text may,
   # is encouraged to, but does not necessarily have to,
   # contain some reasonable status details.
   #
   # The s_language is usually "uk", which stands for United Kingdom,
   # or "et", which stands for Estonian.
   def s_status(s_language)
      kibuvits_throw("This method is expected to be over-ridden.")
   end # s_status

   # Returns a string that is displayed to humans/self-aware-robots.
   # It should consist of a summary and an a short explanation
   # of parameters.
   #
   # The s_language is usually "uk", which stands for United Kingdom,
   # or "et", which stands for Estonian.
   def s_summary_for_identities(s_language)
      # The bdmroutines and bdmservice detectors
      # must override this method.
      s_out="\nThis is a bdmcomponent of type "+@s_bdmcomponent_type.to_s+
      " and its name is "+@s_bdmcomponent_name.to_s
      return s_out
   end # s_summary_for_identities
   
end # Breakdancemake_bdmcomponent

#==========================================================================

