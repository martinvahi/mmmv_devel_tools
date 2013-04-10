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

# The Breakdancemake_bdmprojectdescriptor_base is
# a parent class of all bdmprojectdescriptors.
#
# The names of all bdmprojectdescriptor instance classes
# must have a prefix of "Breakdancemake_bdmprojectdescriptor_".
class Breakdancemake_bdmprojectdescriptor_base < Breakdancemake_bdmcomponent
   def initialize(s_bdmcomponent_name=Breakdancemake.get_instance.s_lc_1)
      super() # The brackets are necessary due to different number of constructor attributes.
      @s_bdmcomponent_type="bdmprojectdescriptor"
      @s_bdmcomponent_name=s_bdmcomponent_name
      @ht_configurations=Hash.new
   end #initialize

   def ht_configurations
      # The reason, why the ht_configurations
      # is a method in stead of an attr_reader field
      # is that it's possible to refactor it to be
      # a field without changing the client code and
      # the existence of methods is a little bit easier to
      # verify than the existence of fields.
      return @ht_configurations
   end # ht_configurations

end # Breakdancemake_bdmprojectdescriptor_base

#==========================================================================

