#!/opt/ruby/bin/ruby -Ku
=begin
 Copyright 2010, martin.vahi@softf1.com that has an
 Estonian personal identification code of 38108050020.

 This file is licensed under the BSD license:
 http://www.opensource.org/licenses/bsd-license.php
=end
#==========================================================================
require "rubygems"
require "kibuvits_comments_detector.rb"

s_language="ruby"
s_script=""+
  " # By changing the boolean parameter of the \n"+
  "    # Kibuvits_comments_detector.extract_commentstrings to true\n"+
  "# the oneliner comments that follow only spaces and tabs, \n"+
  "      # are packed to a single string.\n"+
  "a=1+1 # So, this line will be in a separate string.\n"+
  " # But these 2 lines \n"+
  "  # will be in a single string.\n"+
  "\n"+
  " # And this line will be in its private string again."

msgcs=Kibuvits_msgc_stack.new
ar_comments=Kibuvits_comments_detector.run(s_language,s_script,msgcs)
ar_commentstrings=Kibuvits_comments_detector.extract_commentstrings(
	ar_comments,true)

s=""
ar_commentstrings.each{|s_comment| s=s+"{"+s_comment+"}\n"}
puts s

=begin
 Expected console output:

{ By changing the boolean parameter of the
 Kibuvits_comments_detector.extract_commentstrings to true
 the oneliner comments that follow only spaces and tabs,
 are packed to a single string.}
{ So, this line will be in a separate string.}
{ But these 2 lines
 will be in a single string.}
{ And this line will be in its private string again.}

=end

