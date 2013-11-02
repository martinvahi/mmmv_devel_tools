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

# A bdmservice (Estonian: bdmteenus) is an application
# that is not part of the breakdancemake.
# For example bdmroutines are not bdmservices.
# The bdmservices are either available over a network or
# reside on the PATH or are accessible by some other means.
#
# The Breakdancemake_bdmservice_detector is
# a parent class of all bdmservice detector-s.
#
# The bdmservice_detector named "git", which resides in
# BREAKDANCEMAKE_HOME/src/bdmservice_detectors/git,
# serves partly the purpose of being a bdmservice detector
# implementation example.
class Breakdancemake_bdmservice_detector < Breakdancemake_bdmcomponent
   def initialize
      super
      @s_bdmcomponent_type="bdmservice_detector"
   end #initialize

   # This method overrides a method from the class Breakdancemake_bdmcomponent.
   # Further comments reside in the source of the Breakdancemake_bdmcomponent.
   def s_summary_for_identities(s_language)
      kibuvits_throw("This method is expected to be over-ridden.")
   end # s_summary_for_identities

   protected

   # An implementation of the s_status() for convenience.
   def breakdancemake_s_bdmservice_status_by_PATH_only_t1(s_language)
      s_out=nil
      if b_ready_for_use()
         case s_language
         when $kibuvits_lc_et
            s_out="\n"+
            "bdmteenus nimega \""+@s_bdmcomponent_name+
            "\" on rajalt (PATH) leitav. \n\n"
         else # probably s_language=="uk"
            s_out="\n"+
            "bdmservice named \""+@s_bdmcomponent_name+
            "\" is available on the PATH. \n\n"
         end # case s_language
      else
         case s_language
         when $kibuvits_lc_et
            s_out="\n"+
            "bdmteenus nimega \""+@s_bdmcomponent_name+
            "\", mis peaks asuma rajal (PATH), ei ole kättesaadav. \n\n"
         else # probably s_language=="uk"
            s_out="\n"+
            "bdmservice named \""+@s_bdmcomponent_name+
            "\", which is expected to be available on the PATH, "+
            "is not available. \n\n"
         end # case s_language
      end # if
      return s_out
   end # breakdancemake_s_bdmservice_status_by_PATH_only_t1

end # Breakdancemake_bdmservice_detector

#==========================================================================

