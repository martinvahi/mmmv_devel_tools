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

require "monitor"
if defined? KIBUVITS_HOME
   require  KIBUVITS_HOME+"/include/kibuvits_msgc.rb"
   require  KIBUVITS_HOME+"/include/kibuvits_GUID_generator.rb"
else
   require  "kibuvits_msgc.rb"
   require  "kibuvits_GUID_generator.rb"
end # if
require "singleton"
#==========================================================================

KIBUVITS_GRAPH_EDGE_CAP_IN_ARROW=1
KIBUVITS_GRAPH_EDGE_CAP_OUT_ARROW=2
KIBUVITS_GRAPH_EDGE_CAP_OUTIN_ARROW=3
KIBUVITS_GRAPH_EDGE_CAP_NIL=4
KIBUVITS_GRAPH_EDGE_CAP_STAR=5
KIBUVITS_GRAPH_EDGE_CAP_PLUS=6


# According to http://mathworld.wolfram.com/Hyperedge.html
# an hyperedge is an edge that connects two or more vertices.
#
# The Kibuvits_graph_hyperedge is like a line segment
# (http://mathworld.wolfram.com/LineSegment.html ), except
# that in stead of having exactly 2 endpoints, it can have
# an arbritrary nonnegative number of endpoints.
#
# Each of the endpoints is always connected to a vertex, but a
# single edge can not have more than one of its endpoints
# connected to a same vertex, i.e. each vertex is
# connected to an edge by at most one edge endpoint.
#
# The endpoints have caps. For example, inbound or outbound
# arrow symbols.
#
# As each vertex can be connected to a single edge by at most
# one of the edge's endpoints, an edge that leaves and arrives
# to the same vertex is implemented by connecting the vertex
# with the edge by only one endpoint and applying a special
# cap to the endpoint: KIBUVITS_GRAPH_EDGE_CAP_OUTIN_ARROW.
#
class Kibuvits_graph_hyperedge

   attr_reader :s_id
   attr_accessor :data

   # The x_existence is for fuzzy edges. It's up to the
   # application to determine, how to normalize it, but
   # one might want to interpret 0 as nonexistent and 1 as
   # 100% existent.  For sake of simplicity and speed,
   # one can use CPU supported floats, but one can use
   # other numeric formats, like absolute precision rationals, etc.
   # In the classical cases one can just ignore that the
   # field x_existence is present. In some
   # case the existence might depend on the path, how this
   # edge was reached. So, the format of the x_existence is
   # totally application specific.
   attr_accessor :x_existence

   # The x_label and x_colour are a bit redundant, but they
   # exist for convenience.
   attr_accessor :x_label
   attr_accessor :x_colour

   attr_reader :ht_vertices # It's not frozen, one can modify the content.

   def initialize s_id=Kibuvits_GUID_generator.generate_GUID()
      # One skips some of the traditional input verification
      # in favour of speed.
      @ht_vertices=Hash.new
      @s_id=s_id
      @data=nil;
      @x_label=nil
      @x_existence=nil
      @x_colour=nil
   end #initialize

   def connected? vertex
      b_out=@ht_vertices.has_key? vertex.s_id
      return b_out
   end # connected

   def connect_vertex(vertex,
      edge_cap_next_to_the_vertex=KIBUVITS_GRAPH_EDGE_CAP_NIL)
      return if connected? vertex # stops recursion
      @ht_vertices[vertex.s_id]=vertex
      vertex.connect_edge self,edge_cap_next_to_the_vertex
   end # connect_vertex

   def disconnect_vertex vertex
      return if !connected? vertex # stops recursion
      @ht_vertices.delete(vertex.s_id)
      vertex.disconnect_edge self
   end # disconnect_vertex

   def number_of_vertices
      i_out=@ht_vertices.keys.count
      return i_out
   end # number_of_vertices

   def disconnect_all_vertices
      @ht_vertices.each_value{|vertex| disconnect_vertex(vertex)}
   end # disconnect_all_vertices

   # Due to interdependencies of the classes Kibuvits_graph_<...>
   # the selftests of the Kibuvits_graph_<...> reside in the
   # Kibuvits_graph_selftests.

end # class Kibuvits_graph_hyperedge

#--------------------------------------------------------------------------

# The class Kibuvits_graph_vertex is meant to be used in
# conjunction with the Kibuvits_graph_hyperedge.
#
# One consideres a graph to be a set of vertices and that's why
# there is no separate "graph class". This allows a vertex to
# belong to more than one set, regardless of whether the set
# is a classical one or a fuzzy set.
#
# Due to speed considerations the Kibuvits_graph_vertex
# implementation does not allow an edge to be
# connected to a vertex by more than one of the edge's endpoints.
# The mechanism, how to implement edges that leave and arrive
# to the same vertex is described in the documentation of the
# Kibuvits_graph_hyperedge.
class Kibuvits_graph_vertex
   @@lc_s_plain="plain"
   @@lc_s_directed="directed"
   @@lc_s_custom="custom"

   attr_reader :s_id
   attr_accessor :data
   attr_accessor :x_label  # Could be data, but exists for comfort.
   attr_accessor :x_colour # Could be data, but exists for comfort.

   attr_reader :ht_edges
   attr_reader :i_degree # http://mathworld.wolfram.com/VertexDegree.html

   def initialize s_id=Kibuvits_GUID_generator.generate_GUID
      @s_id=s_id
      @data=nil;
      @x_label=nil
      @ht_edges=Hash.new
      @i_degree=0
      @x_colour=nil
   end #initialize

   def connected? edge
      b_out=@ht_edges.has_key? edge.s_id
      return b_out
   end # connected

   def connect_edge(edge,
      edge_cap_next_to_the_vertex=KIBUVITS_GRAPH_EDGE_CAP_NIL)
      return if connected? edge # stops recursion
      @ht_edges[edge.s_id]=edge
      @i_degree=@i_degree+1
      edge.connect_vertex self,edge_cap_next_to_the_vertex
   end # connect_edge

   def disconnect_edge edge
      return if !connected? edge # stops recursion
      @ht_edges.delete(edge.s_id)
      @i_degree=@i_degree-1
      edge.disconnect_vertex self
   end # disconnect_edge

   def disconnect_all_edges
      @ht_edges.each_value{|edge| disconnect_edge(edge)}
   end # disconnect_all_edges

   # Due to interdependencies of the classes Kibuvits_graph_<...>
   # the selftests of the Kibuvits_graph_<...> reside in the
   # Kibuvits_graph_selftests.

end # class Kibuvits_graph_vertex

#--------------------------------------------------------------------------

# It's a convenience class for assembling, editing, graphs that
# consist of Kibuvits_graph_vertex and Kibuvits_graph_hyperedge instances.
# It's a singleton.
class Kibuvits_graph_handler

   def initialize
   end # initialize

   # s_new_edge_caps={"plain","directed","custom"}
   # If s_edge_type=="directed", the arrow leads from the first vertex to
   # all other vertices.
   #
   # If s_edge_type=="directed" and there's only one vertex, then
   # the arrow leaves from and arrives to the single vertex.
   #
   # Edges are generalized and unlike the classical case in math,
   # a single edge can connect more than 2 vertices at once. This method always
   # consumes exactly one edge for connecting all of the vertices.
   #
   def connect_vertices(vertex_or_ar_vertices, s_new_edge_caps=@@lc_s_plain,
      ht_custom=nil)

      kibuvits_throw "This method is subject to completion. POOLELI"

      bn=binding()
      kibuvits_typecheck bn, [Array,Kibuvits_graph_vertex], vertex_or_ar_vertices
      kibuvits_typecheck bn, String, s_new_edge_caps
      kibuvits_typecheck bn, [NilClass,Hash], ht_custom
      ar_vertices=Kibuvits_ix.normalize2array(vertex_or_ar_vertices)
      ar_vertices.each do |x|
         kibuvits_typecheck binding(), Kibuvits_graph_vertex, x
      end # loop

      ed=nil
      ar_caps=nil
      if ht_custom!=nil
      end # if
      if s_edge_type==@@lc_s_plain
      elsif s_edge_type==@@lc_s_directed
      elsif s_edge_type==@@lc_s_custom
         if ht_custom==nil
            kibuvits_throw "s_edge_type==\""+@@lc_s_custom+"\", but "+
            "ht_custom==nil."
         end # if
      else
         kibuvits_throw "\ns_edge_type==\""+s_edge_type+
         "\", but only \"plain\", \"directed\" and \"custom\" are supported.\n"
      end # else
   end # connect_vertex

   public
   include Singleton

   # Due to interdependencies of the classes Kibuvits_graph_<...>
   # the selftests of the Kibuvits_graph_<...> reside in the
   # Kibuvits_graph_selftests.

end # class Kibuvits_graph_handler

#=========================================================================
