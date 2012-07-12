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

if !defined? KIBUVITS_DEPENDENCYMETRICS_T1_RB_INCLUDED
   KIBUVITS_DEPENDENCYMETRICS_T1_RB_INCLUDED=true

   if !defined? KIBUVITS_HOME
      x=ENV['KIBUVITS_HOME']
      KIBUVITS_HOME=x if (x!=nil and x!="")
   end # if

   require "rubygems"
   require "singleton"
   if defined? KIBUVITS_HOME
      require  KIBUVITS_HOME+"/include/kibuvits_msgc.rb"
   else
      require  "kibuvits_msgc.rb"
   end # if
end # if

#==========================================================================

# The class Kibuvits_dependencymetrics_t1 is a namespace for methods
# that provide answers about a instances that have their
# dependency graph described and acessible according to
# the specification that the Kibuvits_dependencymetrics_t1
# is designed to use. The specification is described by the
# following example:
#
# The dependencies graph is described in the format of a hashtable:
#
# ht_dependency_relations=Hash.new
# ht_dependency_relations["Micky"]=["Donald","Pluto"]
# ht_dependency_relations["Swan"]=[]
# ht_dependency_relations["Horse"]=["Mule"]
# ht_dependency_relations["Frog"]=nil
# ht_dependency_relations["Butterfly"]="Beetle"
#
# Part of the semantics of the ht_dependency_relations content is that
# the dependencies are considered to be met, if the
# following boolean expression has the value of true:
#
#                       ( <Micky> OR <Donald> OR <Pluto> ) AND
#                   AND   <Swan> AND
#                   AND ( <Horse> OR <Mule> ) AND
#                   AND   <Frog> AND
#                   AND ( <Butterfly> OR <Beetle> )
#
# The chevrons denote a function that
# returns a boolean value.
#
# The other part of the semantics of the ht_dependency_relations
# is that the order of the names in the arrays is
# important, because the replacement dependencies
# are searched by starting from the smallest
# index. For example, in the case of the illustration,
# if the Pluto is available and the Donald
# is available, but the Micky is not available, then
# the Donald is used, because its index in the
# array is smaller than that of the Pluto.
#
# The previous, boolean, example was equivalent to a situation,
# where the dependency fulfillment has only 2 values,
#       "met"  ,  "unmet",
# i.e.  "yes"  ,   "no",
# i.e.    1   and   0,
# i.e. "true"  ,  "false
# and the fulfillment threshold equals one.
#
# A generalized version of that is that there is a range of
# integers, [0,n], where 1<=n, and the question, whether
# all dependencies have been met, is equivalent to a question:
# do all of the dependencies have their availability value
# equal to or greater than the threshold?
#
# For example, in the case of the classical, boolean,
# version, the n==1, i.e. the range of integers is [0,1], and
# all dependencies are considered to be met, if all of the
# dependencies have their availability value
# "greater than" or equal to one. That is to say, in the
# case of the boolean version the threshold equals 1 .
#
class Kibuvits_dependencymetrics_t1
   def initialize
   end # initialize

   private
   def verify_ht_dependency_relations_format(s_dependent_object_name,
      ht_dependency_relations)
      bn=binding()
      kibuvits_assert_string_min_length(bn,s_dependent_object_name,1)
      kibuvits_typecheck bn, Hash, ht_dependency_relations
      bn=nil
      s_clname=nil
      ht_dependency_relations.each_pair do |s_key,x_value|
         bn=binding()
         kibuvits_typecheck bn, String, s_key
         kibuvits_assert_string_min_length(bn,s_key,1)
         s_clname=x_value.class.to_s
         case s_clname
         when "String"
            # Any string is OK. An empty string
            # indicates that the dependency s_key
            # does not have any substitutes.
         when "Array"
            # An empty array indicates that the dependency s_key
            # does not have any substitutes.
            x_value.each do |s_key_substitute_name|
               bn_1=binding()
               kibuvits_typecheck bn_1, String, s_key_substitute_name
               kibuvits_assert_string_min_length(bn_1,
               s_key_substitute_name,1)
            end # loop
         when "NilClass"
            # x_value==nil indicates that the dependency s_key
            # does not have any substitutes.
         else
            kibuvits_throw("ht_dependency_relations[\""+s_key+"\"].class=="+
            s_clname+", which is not supported in this role.")
         end # case x_value.class
      end # loop
      if ht_dependency_relations.has_key? s_dependent_object_name
         kibuvits_throw("ht_dependency_relations.has_key?("+
         "s_dependent_object_name)==true, "+
         "s_dependent_object_name=="+s_dependent_object_name)
      end # if
   end # verify_ht_dependency_relations_format

   private

   def ar_get_availability_value_impl(s_dependent_object_name,
      ht_dependency_relations,ht_objects,sym_get_avail,
      b_availability_is_expressed_by_using_boolean_values,i_threshold,
      ht_availability_values,ht_cycle_breaker)
      if KIBUVITS_b_DEBUG
         bn=binding()
         verify_ht_dependency_relations_format(s_dependent_object_name,
         ht_dependency_relations)
         kibuvits_typecheck bn, Hash, ht_objects
         kibuvits_typecheck bn, Symbol, sym_get_avail
         kibuvits_typecheck bn, [TrueClass,FalseClass], b_availability_is_expressed_by_using_boolean_values
         kibuvits_typecheck bn, [Fixnum,Float,Rational], i_threshold
         if i_threshold<1
            kibuvits_throw("i_threshold=="+i_threshold.to_s+" < 1 ")
         end # if
         kibuvits_assert_ht_has_keys(bn,ht_objects,
         s_dependent_object_name,
         " The ht_objects must contain contain "+
         "<object name> --> <object instance> "+
         "relations for all objects.")
         kibuvits_typecheck bn, Hash, ht_availability_values
      end # if
      ht_dependency_names_after_substitutions=Hash.new
      ht_dependency_relations.each_key do |s_key|
         ht_dependency_names_after_substitutions[s_key]=s_key
      end # loop
      fdx_availability_out=0

      if ht_cycle_breaker.has_key? s_dependent_object_name
         ar_out=[ht_dependency_names_after_substitutions,fdx_availability_out]
         return ar_out
      end # if

      ar_htdepr_keys=ht_dependency_relations.keys
      if ar_htdepr_keys.size==0
         ob_dpendent_object=ht_objects[s_dependent_object_name]
         x_1=ob_dpendent_object.method(sym_get_avail).call
         if b_availability_is_expressed_by_using_boolean_values
            fdx_availability_out=0
            fdx_availability_out=1 if x_1
         else
            fdx_availability_out=x_1
         end # if
         ar_out=[ht_dependency_names_after_substitutions,fdx_availability_out]
         return ar_out
      end # if

      ht_cycle_breaker[s_dependent_object_name]=42
      fdx_1=nil
      ar_x_value=nil
      cl_1=nil
      ht_tmp_1=Hash.new
      ob_1=nil
      ar_1=nil
      Kibuvits_ix.normalize2array_insert_2_ht(ht_tmp_1,$kibuvits_lc_emptystring)
      Kibuvits_ix.normalize2array_insert_2_ht(ht_tmp_1,nil)
      ht_dependency_relations.each_pair do |s_key,x_value|
         if KIBUVITS_b_DEBUG
            bn=binding()
            kibuvits_typecheck bn, [NilClass,String,Array], x_value
            cl=x_value.class
            if cl==Array
               x_value.each do |x|
                  bn_1=binding()
                  kibuvits_typecheck bn_1, String, x
               end # loop
            else
               if cl==String
                  kibuvits_assert_string_min_length(bn,x_value,1)
               end # if
            end # if
         end # if
         if ht_availability_values.has_key? s_key
            fdx_1=ht_availability_values[s_key]
         else
            ob_1=ht_objects[s_key]
            # POOLELI, muuta API-t nii, et isendi s8ltuvusrelatsioonid on
            # tema endaga seotud. Sisuliselt lisada veel yks Symbol meetodile,
            # mis tagastab paisktabeli.
            ar_1=ar_get_availability_value_impl(s_key,
            ht_dependency_relations,ht_objects,sym_get_avail,
            b_availability_is_expressed_by_using_boolean_values,i_threshold,
            ht_availability_values,ht_cycle_breaker)
            fdx_1=ob_1.method(sym_get_avail).call # POOLELI siin peaks olema  rekurs
            ht_availability_values[s_key]=fdx_1
         end # if
         if i_threshold<=fdx_1
            ht_dependency_names_after_substitutions[s_key]=s_key
            next
         end # if
         ar_x_value=Kibuvits_ix.normalize2array(x_value,
         ht_values_that_result_an_empty_array)
         # POOLELI
         # substitution code
      end # loop
      # POOLELI siin yle ht_dependency_names_after_substitutions suurim yhisosa leida, a la leida m2gede vahele j22va maismaa k8rgus merepinnast
      #fdx_availability_out=   ....
      ar_out=[ht_dependency_names_after_substitutions,fdx_availability_out]
      ht_cycle_breaker.delete(s_dependent_object_name)
      return ar_out
   end # ar_get_availability_value_impl

   public

   # The ht_objects has object names as keys and the objects as values.
   # The objects in the ht_objects must have a
   # method that corresponds to the s_or_sym_method.
   # If the b_availability_is_expressed_by_using_boolean_values==true, then
   # the method is expected to return only boolean values:
   # true if available and false if unavailable.
   #
   # Cyclic dependencies ARE allowed, but if the dependency
   # substitutions within the ht_dependency_relations
   # lead to a situation, where the availability
   # of the ht_objects[s_dependent_object_name] is determined
   # by its own availability, then 0 is returned.
   #
   # If the ht_objects[s_dependent_object_name] does not
   # depend on any of the other instances that are listed
   # in the ht_objects, i.e. if the
   # ht_dependency_relations.keys.size==0, then the
   # ar_get_availability_value(...) returns
   # ht_objects[s_dependent_object_name].method(s_or_sym_method).call
   #
   # The i_threshold is related to substitutions.
   # For example, if
   # ht_dependency_relations=Hash["ob_2", ["ob_3","ob_4"] ] and
   # i_threshold==72 and
   # ht_objects["ob_2"].method(s_or_sym_method).call == 42 and
   # ht_objects["ob_3"].method(s_or_sym_method).call == 73 and
   # ht_objects["ob_4"].method(s_or_sym_method).call == 99 then
   # the ar_get_availability_value(...) returns 73 , because 42 is
   # smaller than the i_threshold, but the first substitution, the
   # ht_objects["ob_2"], has an availability value of 73 and 72<=73 .
   # The reason, why the availability value of the ht_objects["ob_3"] is
   # used in stead of the availability value of the ht_objects["ob_4"], is
   # that the substitution order is determined by the array indices, not
   # availability values.
   #
   # Explanetory code examples, illustrations, reside
   # within the Kibuvits_dependencymetrics_t1 selftests.
   #
   # The ar_get_availability_value(...) returns an array, where
   # ar[0]==ht_dependency_names_after_substitutions
   # ar[1]==<A number that depicts the greatest common availability value
   #         that the resultant subset of the ht_objects is able to provide.>
   # The set of keys of the ht_dependency_names_after_substitutions matches
   # that of the ht_dependency_relations. The values of the
   # ht_dependency_names_after_substitutions are the names of the
   # instances, the ht_objects elements, that are chosen to meet
   # the dependency requirements.
   def ar_get_availability_value(s_dependent_object_name,
      ht_dependency_relations,ht_objects,s_or_sym_method,
      b_availability_is_expressed_by_using_boolean_values=true,
      i_threshold=1)
      if KIBUVITS_b_DEBUG
         bn=binding()
         kibuvits_typecheck bn, [Symbol,String], s_or_sym_method
         if s_or_sym_method.class==String
            kibuvits_assert_string_min_length(bn,s_or_sym_method,1)
         end # if
      end # if
      sym_get_avail=s_or_sym_method
      sym_get_avail=s_or_sym_method.to_sym if s_or_sym_method.class==String
      ht_availability_values=Hash.new
      ht_cycle_breaker=Hash.new
      i_out=ar_get_availability_value_impl(s_dependent_object_name,
      ht_dependency_relations,ht_objects,sym_get_avail,
      b_availability_is_expressed_by_using_boolean_values,i_threshold,
      ht_availability_values,ht_cycle_breaker)
      return i_out
   end # ar_get_availability_value

   def Kibuvits_dependencymetrics_t1.ar_get_availability_value(
      s_dependent_object_name,
      ht_dependency_relations,ht_objects,s_or_sym_method,
      b_availability_is_expressed_by_using_boolean_values=true,
      i_threshold=1)
      i_out=Kibuvits_dependencymetrics_t1.instance.ar_get_availability_value(
      s_dependent_object_name,
      ht_dependency_relations,ht_objects,s_or_sym_method,
      b_availability_is_expressed_by_using_boolean_values,
      i_threshold)
      return i_out
   end # Kibuvits_dependencymetrics_t1.ar_get_availability_value


   public
   include Singleton
   # The Kibuvits_dependencymetrics_t1.selftest analogue is
   # in a separate selftest file.

end # class Kibuvits_dependencymetrics_t1

#==========================================================================
