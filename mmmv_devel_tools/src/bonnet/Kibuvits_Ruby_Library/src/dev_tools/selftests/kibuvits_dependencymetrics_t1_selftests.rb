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
if !defined? KIBUVITS_HOME
   x=ENV['KIBUVITS_HOME']
   KIBUVITS_HOME=x if (x!=nil and x!="")
end # if

require "rubygems"
require "monitor"
if defined? KIBUVITS_HOME
   require  KIBUVITS_HOME+"/include/kibuvits_boot.rb"
   require  KIBUVITS_HOME+"/include/kibuvits_msgc.rb"
   require  KIBUVITS_HOME+"/include/kibuvits_dependencymetrics_t1.rb"
else
   require  "kibuvits_boot.rb"
   require  "kibuvits_msgc.rb"
   require  "kibuvits_dependencymetrics_t1.rb"
end # if
#==========================================================================

class Kibuvits_dependencymetrics_t1_testclass_1
   def initialize i_availability
      @i_availability=i_availability
   end # initialize

   def i_get_availability
      return @i_availability
   end # i_get_availability
end # class Kibuvits_dependencymetrics_t1_testclass_1

#--------------------------------------------------------------------------

class Kibuvits_dependencymetrics_t1_selftests

   def initialize
   end #initialize

   private
   #-----------------------------------------------------------------------

   def Kibuvits_dependencymetrics_t1_selftests.test_set_1

      #-----------------------------------------------------
      s_dependent_object_name="ob_1"
      ht_dependency_relations=Hash.new
      ht_objects=Hash.new
      s_or_sym_method=:i_get_availability
      b_availability_is_expressed_by_using_boolean_values=false
      i_threshold=9
      #------------
      # ob_1:?
      # ob_2:5   |  ob_3:8 ob_4:9
      ht_objects[s_dependent_object_name]=Kibuvits_dependencymetrics_t1_testclass_1.new(0)
      ht_objects["ob_2"]=Kibuvits_dependencymetrics_t1_testclass_1.new(5)
      ht_objects["ob_3"]=Kibuvits_dependencymetrics_t1_testclass_1.new(8)
      ht_objects["ob_4"]=Kibuvits_dependencymetrics_t1_testclass_1.new(9)
      ht_dependency_relations["ob_2"]=["ob_3", "ob_4"]
      #------------
      ar_x=Kibuvits_dependencymetrics_t1.ar_get_availability_value(
      s_dependent_object_name,
      ht_dependency_relations,ht_objects,s_or_sym_method,
      b_availability_is_expressed_by_using_boolean_values)
      i_x=ar_x[1]
      kibuvits_throw "test 1 i_x=="+i_x.to_s if i_x!=9
      return

      #-----------------------------------------------------
      s_dependent_object_name="ob_1"
      ht_dependency_relations=Hash.new
      ht_objects=Hash.new
      s_or_sym_method=:i_get_availability
      b_availability_is_expressed_by_using_boolean_values=false
      i_threshold=700
      #------------
      # ob_1:?
      ht_objects[s_dependent_object_name]=Kibuvits_dependencymetrics_t1_testclass_1.new(54)
      #------------
      ar_x=Kibuvits_dependencymetrics_t1.ar_get_availability_value(
      s_dependent_object_name,
      ht_dependency_relations,ht_objects,s_or_sym_method,
      b_availability_is_expressed_by_using_boolean_values)
      i_x=ar_x[1]
      kibuvits_throw "test 2 i_x=="+i_x.to_s if i_x!=54

      #-----------------------------------------------------
      s_dependent_object_name="ob_1"
      ht_dependency_relations=Hash.new
      ht_objects=Hash.new
      s_or_sym_method=:i_get_availability
      b_availability_is_expressed_by_using_boolean_values=false
      i_threshold=3
      #------------
      # ob_1:?
      # ob_2:2   |  ob_3:4 ob_4:9
      ht_objects[s_dependent_object_name]=Kibuvits_dependencymetrics_t1_testclass_1.new(0)
      ht_objects["ob_2"]=Kibuvits_dependencymetrics_t1_testclass_1.new(2)
      ht_objects["ob_3"]=Kibuvits_dependencymetrics_t1_testclass_1.new(4)
      ht_objects["ob_4"]=Kibuvits_dependencymetrics_t1_testclass_1.new(9)
      ht_dependency_relations=Hash["ob_2", ["ob_3","ob_4"] ]
      #------------
      ar_x=Kibuvits_dependencymetrics_t1.ar_get_availability_value(
      s_dependent_object_name,
      ht_dependency_relations,ht_objects,s_or_sym_method,
      b_availability_is_expressed_by_using_boolean_values)
      i_x=ar_x[1]
      kibuvits_throw "test 3 " if i_x!=4
      return
      #-----------------------------------------------------


      #-----------------------------------------------------
      s_dependent_object_name="ob_1"
      ht_dependency_relations=Hash.new
      ht_objects=Hash.new
      s_or_sym_method=:i_get_availability
      b_availability_is_expressed_by_using_boolean_values=false
      i_threshold=1
      #------------
      # ob_1:?
      # ob_2:1   |  ob_3:0
      # ob_4:0   |  ob_5:1
      # ob_6:0   |  ob_7:8   ob_8:0
      # ob_9:0   |  ob_10:0  ob_11:0  ob_12:1
      # ob_13:4  |  nil
      ht_objects[s_dependent_object_name]=Kibuvits_dependencymetrics_t1_testclass_1.new(0)
      ht_objects["ob_2"]=Kibuvits_dependencymetrics_t1_testclass_1.new(1)
      ht_objects["ob_3"]=Kibuvits_dependencymetrics_t1_testclass_1.new(0)
      ht_objects["ob_4"]=Kibuvits_dependencymetrics_t1_testclass_1.new(0)
      ht_objects["ob_5"]=Kibuvits_dependencymetrics_t1_testclass_1.new(1)
      ht_objects["ob_6"]=Kibuvits_dependencymetrics_t1_testclass_1.new(0)
      ht_objects["ob_7"]=Kibuvits_dependencymetrics_t1_testclass_1.new(8)
      ht_objects["ob_8"]=Kibuvits_dependencymetrics_t1_testclass_1.new(0)
      ht_objects["ob_9"]=Kibuvits_dependencymetrics_t1_testclass_1.new(0)
      ht_objects["ob_10"]=Kibuvits_dependencymetrics_t1_testclass_1.new(0)
      ht_objects["ob_11"]=Kibuvits_dependencymetrics_t1_testclass_1.new(0)
      ht_objects["ob_12"]=Kibuvits_dependencymetrics_t1_testclass_1.new(1)
      ht_objects["ob_13"]=Kibuvits_dependencymetrics_t1_testclass_1.new(4)
      ht_dependency_relations["ob_2"]="ob_3"
      ht_dependency_relations["ob_4"]=["ob_5"]
      ht_dependency_relations["ob_6"]=["ob_7","ob_8"]
      ht_dependency_relations["ob_9"]=["ob_10","ob_11","ob_12"]
      ht_dependency_relations["ob_13"]=nil
      #------------
      ar_x=Kibuvits_dependencymetrics_t1.ar_get_availability_value(
      s_dependent_object_name,
      ht_dependency_relations,ht_objects,s_or_sym_method,
      b_availability_is_expressed_by_using_boolean_values)
      i_x=ar_x[1]
      kibuvits_throw "test 4 " if i_x!=1
      #-----------------------------------------------------
   end # Kibuvits_dependencymetrics_t1_selftests.test_set_1


   #-----------------------------------------------------------------------

   #-----------------------------------------------------------------------
   public
   def Kibuvits_dependencymetrics_t1_selftests.selftest
      ar_msgs=Array.new
      bn=binding()
      kibuvits_testeval bn, "Kibuvits_dependencymetrics_t1_selftests.test_set_1"
      return ar_msgs
   end # Kibuvits_dependencymetrics_t1_selftests.selftest

end # class Kibuvits_dependencymetrics_t1_selftests_stack

#--------------------------------------------------------------------------

#==========================================================================
puts Kibuvits_dependencymetrics_t1_selftests.selftest.to_s

