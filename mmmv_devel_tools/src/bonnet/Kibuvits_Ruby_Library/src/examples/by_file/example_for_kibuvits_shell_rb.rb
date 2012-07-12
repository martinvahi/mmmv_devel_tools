#!/opt/ruby/bin/ruby -Ku
=begin
 Copyright 2010, martin.vahi@softf1.com that has an
 Estonian personal identification code of 38108050020.

 This file is licensed under the BSD license:
 http://www.opensource.org/licenses/bsd-license.php
=end
#==========================================================================
require "rubygems"
require"kibuvits_shell.rb"

a_shell_script="dir"
shellscript_output_as_a_string=sh(a_shell_script)
puts shellscript_output_as_a_string

