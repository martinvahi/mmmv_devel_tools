#!/usr/bin/ruby
#
#### encoding: utf-8 
#-----------------------------------------------------------------------
=begin

 Copyright (c) 2009, martin.vahi@eesti.ee that has an
 Estonian national identification number of 38108050020.
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
#-----------------------------------------------------------------------
LOCAL_PWD=Pathname.new($0).realpath.parent.to_s if not defined? LOCAL_PWD
#-----------------------------------------------------------------------

def ensure_absolute_path(file_path)
   f_path=file_path
   throw "\nLOCAL_PWD not defined\n" if not defined? LOCAL_PWD
   f_path=LOCAL_PWD+"/"+f_path if file_path[0..0]!="/"
   return f_path
end #ensure_absolute_path

def get_from_stdin
   an_stdin=STDIN.reopen($stdin)
   data=an_stdin.readlines(nil)
   an_stdin.close
   return data[0]
end #get_from_stdin

def write_to_stdout data
   # It's like the puts, but without the linebreak
   an_io=STDOUT.reopen($stdout)
   an_io.write data
   an_io.flush
   an_io.close
end # write_to_stdout

def str2file(a_string, full_path2file)
   if full_path2file[0..0]!="/"
	  raise "\n\n\"full_path2file\" had a value of:\n" +
	  full_path2file +
	  "\n but a full path is required instead.\n\n"
   end # if
   file=File.open(full_path2file, "w")
   lines=a_string.split("\n")
   lines.length.times do |line_index|
	  if (line_index +1) < lines.length
		 file.puts lines[line_index]
	  else
		 file.printf lines[line_index]
	  end # if
   end # loop
   first_nonlinebreak=a_string.reverse.index(/[^\n]/)
   #puts "\n--------\n"
   #puts "{" + a_string + "}"
   #puts "{" + first_nonlinebreak.to_s + "}"
   if first_nonlinebreak!=nil
	  if 0 < first_nonlinebreak
		 (first_nonlinebreak).times do
			file.printf "\n"
		 end # loop
	  end # if
   end # if
   file.close
end #str2file()

def file2str(full_path2file)
   if full_path2file[0..0]!="/"
	  raise "\n\n\"full_path2file\" had a value of:\n" +
	  full_path2file +
	  "\n but a full path is required instead.\n\n"
   end # if
   output=""
   File.open(full_path2file) do |file|
	  while line = file.gets
		 output+=line
	  end # while
   end # Open-file region.
   return output
end #file2str()

