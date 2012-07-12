#!/opt/ruby/bin/ruby -Ku
#=========================================================================
=begin

 Copyright 2011, martin.vahi@softf1.com that has an
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
#=========================================================================
if !defined? KIBUVITS_HOME
   x=ENV['KIBUVITS_HOME']
   KIBUVITS_HOME=x if (x!=nil and x!="")
end # if

require "rubygems"
require "monitor"
if defined? KIBUVITS_HOME
   require  KIBUVITS_HOME+"/include/kibuvits_msgc.rb"
   require  KIBUVITS_HOME+"/include/kibuvits_GUID_generator.rb"
   require  KIBUVITS_HOME+"/include/incomplete/kibuvits_graph.rb"
else
   require  "kibuvits_msgc.rb"
   require  "kibuvits_GUID_generator.rb"
   require  "kibuvits_graph.rb"
end # if
require "singleton"
#==========================================================================



# The selftests of Kibuvits_graph_vertex, Kibuvits_graph_hyperedge
# and Kibuvits_graph_handler are wrapped to this class, because
# the classes Kibuvits_graph_<...> tend to depend on eachother
# and that seems to confuse the interpreter.
class Kibuvits_graph_selftests

   def initialize
   end #initialize

   #--------------------------------------------------------------------------
   private
   def Kibuvits_graph_selftests.test_1
      vx_1=Kibuvits_graph_vertex.new
      vx_2=Kibuvits_graph_vertex.new
      kibuvits_throw "test 1" if vx_1.i_degree!=0
      kibuvits_throw "test 2" if vx_2.i_degree!=0
      ed_1=Kibuvits_graph_hyperedge.new
      ed_1.connect_vertex(vx_1,KIBUVITS_GRAPH_EDGE_CAP_NIL)
      kibuvits_throw "test 3" if vx_1.i_degree!=1
      ed_1.connect_vertex vx_2
      kibuvits_throw "test 4" if vx_2.i_degree!=1

      ed_1.disconnect_all_vertices
      kibuvits_throw "test 5" if vx_1.i_degree!=0
      kibuvits_throw "test 6" if vx_2.i_degree!=0

      ed_1.connect_vertex vx_1
      ed_1.connect_vertex vx_2
      kibuvits_throw "test 7" if vx_1.i_degree!=1
      kibuvits_throw "test 8" if vx_2.i_degree!=1
      vx_3=Kibuvits_graph_vertex.new
      ed_2=Kibuvits_graph_hyperedge.new
      ed_2.connect_vertex vx_1
      ed_2.connect_vertex vx_3
      kibuvits_throw "test 9" if vx_1.i_degree!=2
      kibuvits_throw "test 10" if vx_2.i_degree!=1
      kibuvits_throw "test 11" if vx_3.i_degree!=1

      kibuvits_throw "test 12" if ed_1.number_of_vertices!=2
      kibuvits_throw "test 13" if ed_2.number_of_vertices!=2

      vx_1.disconnect_all_edges
      kibuvits_throw "test 14" if vx_1.i_degree!=0
      kibuvits_throw "test 15" if ed_1.number_of_vertices!=1
      kibuvits_throw "test 16" if ed_2.number_of_vertices!=1

      ed_1.disconnect_all_vertices
      ed_2.disconnect_all_vertices
      kibuvits_throw "test 17" if ed_1.number_of_vertices!=0
      kibuvits_throw "test 18" if ed_2.number_of_vertices!=0
   end # Kibuvits_graph_selftests.test_1

   #--------------------------------------------------------------------------
   def Kibuvits_graph_selftests.test_2
   end # Kibuvits_graph_selftests.test_2
   #--------------------------------------------------------------------------
   public
   include Singleton
   def Kibuvits_graph_selftests.selftest
      ar_msgs=Array.new
      bn=binding()
      kibuvits_testeval bn, "Kibuvits_graph_selftests.test_1"
      kibuvits_testeval bn, "Kibuvits_graph_selftests.test_2"
      #Kibuvits_graph_handler
      return ar_msgs
   end # Kibuvits_graph_selftests.selftest

end # class Kibuvits_graph_selftests

#=========================================================================
