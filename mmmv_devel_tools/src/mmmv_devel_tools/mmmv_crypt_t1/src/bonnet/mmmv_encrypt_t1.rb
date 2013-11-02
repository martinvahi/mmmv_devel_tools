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
if (i_0<3)||(4<i_0)
   kibuvits_writeln("\nARGV.size == "+i_0.to_s+" not in range [3,4] \n"+
   "   first argument: path to key file \n"+
   "  second argument: path to cleartext  file \n"+
   "   third argument: path to ciphertext file \n"+
   "\n"+
   "Optional:\n"+
   "  fourth argument: armouring type {\"plain_text_armour_t1\",\n"+
   "                                   \"bytestream_armour_t1\"},\n"+
   "                          default: \"bytestream_armour_t1\".\n"+
   "\n"+
   "Encrypted files are about 100x (hundred times) the size of \n"+
   "their respective cleartext files. \n"+
   "\n"+
   "If \"bytestream_armour_t1\" is used, then bytes are \n"+
   "converted to letters of an artificial alphabet that consists \n"+
   "of 256 letters (a range of Unicode code points, where \n"+
   "all code points have a character assigned to it).\n"+
   "As bytes can have only 256 different values, which is \n"+
   "significantly less than the number of existing Unicode characters,\n"+
   "it is recommended that plain text files are encrypted \n"+
   "by using the \"plain_text_armour_t1\", which omits the \n"+
   "byte to character conversion.\n"+
   "\n\n")
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
#------------
s_armouring_type="bytestream_armour_t1"
# The strings in the ARGV are frozen.
s_armouring_type=$kibuvits_lc_emptystring+ARGV[3] if 3<ARGV.size
# The following 2 regexes are applied to avoid documenting,
# whether the quotation marks are compulsory. It's just to
# keep things simpler.
s_armouring_type.sub!(/^"/,$kibuvits_lc_emptystring)
s_armouring_type.sub!(/"$/,$kibuvits_lc_emptystring)
#----
s_cryptocodec_type_t1="kibuvits_wearlevelling_t1"
# For later, when tere is more than one cyrpto algorithm to choose from:
#s_cryptocodec_type_t1=$kibuvits_lc_emptystring+ARGV[4] if 4<ARGV.size
#s_cryptocodec_type_t1.sub!(/^"/,$kibuvits_lc_emptystring)
#s_cryptocodec_type_t1.sub!(/"$/,$kibuvits_lc_emptystring)
#------------
s_cleartext_armoured=nil
case s_armouring_type
when "bytestream_armour_t1" # binary file
   s_cleartext_armoured=kibuvits_file2str_by_armour_t1(ARGV[1])
when "plain_text_armour_t1" # text file
   s_cleartext_armoured=file2str(ARGV[1])
else
   kibuvits_throw("s_armouring_type == "+s_armouring_type+
   " is not yet supported.\n"+
   "Supported armouring types: \"plain_text_armour_t1\",\n"+
   "                           \"bytestream_armour_t1\"."+
   "\n GUID='2c5879e5-305e-48cf-b1f8-82e07020bdd7'\n\n")
end # case s_armouring_type
#------------
s_key=file2str(ARGV[0])
ht_key=Kibuvits_cryptcodec_txor_t1.ht_deserialize_key(s_key)
#------------
ht_header2=Hash.new
ht_header2["s_armouring_type"]=s_armouring_type
ht_header2["s_cryptocodec_type_t1"]=s_cryptocodec_type_t1
s_header2_data=Kibuvits_ProgFTE.from_ht(ht_header2)
s_header2=s_header2_data.length.to_s+$kibuvits_lc_pillar+
s_header2_data+$kibuvits_lc_pillar
ar_speedhack=[s_header2]
#------------
case s_cryptocodec_type_t1
when "kibuvits_wearlevelling_t1"
   s_ciphertext_with_doubleheader=Kibuvits_cryptcodec_txor_t1.s_encrypt_wearlevelling_t1(
   s_cleartext_armoured,ht_key,ar_speedhack)
else
   kibuvits_throw("s_cryptocodec_type_t1 == "+s_cryptocodec_type_t1+
   "\n GUID='51231039-1100-43dc-97e8-82e07020bdd7'\n\n")
end # case s_cryptocodec_type_t1
#------------
str2file(s_ciphertext_with_doubleheader,ARGV[2])

#==========================================================================
