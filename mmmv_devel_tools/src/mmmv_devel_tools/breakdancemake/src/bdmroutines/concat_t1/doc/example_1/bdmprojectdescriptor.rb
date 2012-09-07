#!/opt/ruby/bin/ruby -Ku
#==========================================================================
=begin

 Copyright 2012, martin.vahi@softf1.com that has an
 Estonian personal identification code of 38108050020.

Permission is hereby granted, free of charge, to any 
person obtaining a copy of this software and associated 
documentation files (the "Software"), to deal in the 
Software without restriction, including without limitation 
the rights to use, copy, modify, merge, publish, distribute, 
sublicense, and/or sell copies of the Software, and to 
permit persons to whom the Software is furnished to do so, 
subject to the following conditions: 

The above copyright notice and this permission notice shall 
be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF 
ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED 
TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE 
AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT 
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, 
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, 
ARISING FROM, OUT OF OR IN CONNECTION WITH THE 
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

Exception: if this file is used as a template, then
everything in this file is in public domain and the deletion
of this MIT-license header is encouraged.

=end
#==========================================================================

ar_paths_of_concatenable_files=["./demo_data/kitty_1.txt","./demo_data/kitty_2.txt"]
s_concatenation_output_file_path="./demo_data/kitty_1_plus_kitty_2.js"

ht_bdmroutine_config=Hash.new
ht_bdmroutine_config["ar_paths_of_concatenable_files"]=ar_paths_of_concatenable_files
ht_bdmroutine_config["s_concatenation_output_file_path"]=s_concatenation_output_file_path

#--------------------------------------------------------------------------
Breakdancemake.declare_configuration("concat_t1",ht_bdmroutine_config)
#==========================================================================

