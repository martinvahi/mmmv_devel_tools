#!/usr/bin/env ruby
#==========================================================================
=begin

 Copyright 2013, martin.vahi@softf1.com that has an
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

if !defined? MMMV_CRYPT_T1_RB_INCLUDED
   MMMV_CRYPT_T1_RB_INCLUDED=true
   if !defined? MMMV_DEVEL_TOOLS_HOME
      require 'pathname'
      s_0=Pathname.new(__FILE__).realpath.parent.parent.parent.parent.parent.parent.to_s
      MMMV_DEVEL_TOOLS_HOME=s_0.freeze
   end # if

   require MMMV_DEVEL_TOOLS_HOME+"/src/bonnet/mmmv_devel_tools_initialization_t1.rb"

   require KIBUVITS_HOME+"/src/include/kibuvits_shell.rb"
   require KIBUVITS_HOME+"/src/include/kibuvits_argv_parser.rb"
   require KIBUVITS_HOME+"/src/include/kibuvits_fs.rb"
   require KIBUVITS_HOME+"/src/include/security/kibuvits_cryptcodec_txor_t1.rb"
end # if

#==========================================================================

i_0=ARGV.size
if i_0!=3
   kibuvits_writeln("\nARGV.size == "+i_0.to_s+" != 3 \n"+
   "  first argument: path to key file \n"+
   " second argument: path to ciphertext file\n"+
   "  third argument: path to cleartext  file \n\n")
   exit
end # if
ht_failures=Kibuvits_fs.verify_access(ARGV[0],"is_file")
Kibuvits_fs.exit_if_any_of_the_filesystem_tests_failed(ht_failures)
ht_failures=Kibuvits_fs.verify_access(ARGV[1],"is_file")
Kibuvits_fs.exit_if_any_of_the_filesystem_tests_failed(ht_failures)
if File.exists? ARGV[2]
   ht_failures=Kibuvits_fs.verify_access(ARGV[2],"is_file,writable")
   Kibuvits_fs.exit_if_any_of_the_filesystem_tests_failed(ht_failures)
end # if
msgcs=Kibuvits_msgc_stack.new
#------------
s_key=file2str(ARGV[0])
ht_key=Kibuvits_cryptcodec_txor_t1.ht_deserialize_key(s_key)
#------------
s_ciphertext_with_doubleheader=file2str(ARGV[1]) # ciphertext is plain text
s_header2_data,s_ciphertext_with_header=Kibuvits_str.s_s_bisect_by_header_t1(
s_ciphertext_with_doubleheader,msgcs)
if msgcs.b_failure
   kibuvits_writeln(msgcs.to_s)
   exit
end # if
ht_header2=Kibuvits_ProgFTE.to_ht(s_header2_data)
s_cleartext_armoured=nil
s_cryptocodec_type_t1=ht_header2["s_cryptocodec_type_t1"]
case s_cryptocodec_type_t1
when "kibuvits_wearlevelling_t1"
   s_cleartext_armoured=Kibuvits_cryptcodec_txor_t1.s_decrypt_wearlevelling_t1(
   s_ciphertext_with_header,ht_key,msgcs)
else
   kibuvits_throw("s_cryptocodec_type_t1 == "+s_cryptocodec_type_t1+
   " is not yet supported.\n"+
   "Supported cryptocodecs: \"kibuvits_wearlevelling_t1\"."+
   "\n GUID='34478529-bf56-42fd-8544-b2e07020bdd7'\n\n")
end # case s_cryptocodec_type_t1
if msgcs.b_failure
   kibuvits_writeln(msgcs.to_s+
   "\n GUID='15c7241a-17b2-45d5-8334-b2e07020bdd7'\n\n")
   exit
end # if
#------------
s_armouring_type=ht_header2["s_armouring_type"]
case s_armouring_type
when "bytestream_armour_t1"
   kibuvits_str2file_by_dearmour_t1(s_cleartext_armoured,ARGV[2])
when "plain_text_armour_t1" # cleartext is pure Unicode
   str2file(s_cleartext_armoured,ARGV[2])
else
   kibuvits_throw("s_armouring_type == "+s_armouring_type+
   " is not yet supported.\n"+
   "Supported armouring types: \"plain_text_armour_t1\",\n"+
   "                           \"bytestream_armour_t1\"."+
   "\n GUID='0fc3b834-7808-4760-a234-b2e07020bdd7'\n\n")
end # case s_armouring_type
#==========================================================================

