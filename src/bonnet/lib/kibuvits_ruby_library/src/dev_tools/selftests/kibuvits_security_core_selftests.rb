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

if !defined? KIBUVITS_HOME
   require 'pathname'
   ob_pth_0=Pathname.new(__FILE__).realpath
   ob_pth_1=ob_pth_0.parent.parent.parent.parent
   s_KIBUVITS_HOME_b_fs=ob_pth_1.to_s
   require(s_KIBUVITS_HOME_b_fs+"/src/include/kibuvits_boot.rb")
   ob_pth_0=nil; ob_pth_1=nil; s_KIBUVITS_HOME_b_fs=nil
end # if

require  KIBUVITS_HOME+"/src/include/security/kibuvits_security_core.rb"

#==========================================================================

class Kibuvits_security_core_selftests

   def initialize
   end #initialize

   private

   #-----------------------------------------------------------------------

   def Kibuvits_security_core_selftests.test_1
      #msgcs=Kibuvits_msgc_stack.new
      i_m=256**4
      #---------
      s_0="abc"
      i_number_of_columns=3
      s_x=Kibuvits_security_core.s_mmmv_checksum_t1(s_0,i_number_of_columns,i_m)
      s_expected="97_98_99"
      kibuvits_throw "test 1 s_x==\""+s_x.to_s+"\"" if s_x!=s_expected
      #---------
      s_0=""
      i_number_of_columns=3
      s_x=Kibuvits_security_core.s_mmmv_checksum_t1(s_0,i_number_of_columns,i_m)
      s_expected=""
      kibuvits_throw "test 2 s_x==\""+s_x.to_s+"\"" if s_x!=s_expected
      #---------
      s_0="abc"
      i_number_of_columns=1
      s_x=Kibuvits_security_core.s_mmmv_checksum_t1(s_0,i_number_of_columns,i_m)
      s_expected=(97+98+99).to_s
      kibuvits_throw "test 3 s_x==\""+s_x.to_s+"\"" if s_x!=s_expected
      #---------
      s_0=""
      i_number_of_columns=1
      s_x=Kibuvits_security_core.s_mmmv_checksum_t1(s_0,i_number_of_columns,i_m)
      s_expected=""
      kibuvits_throw "test 4 s_x==\""+s_x.to_s+"\"" if s_x!=s_expected
      #---------
      s_0="a"
      i_number_of_columns=1
      s_x=Kibuvits_security_core.s_mmmv_checksum_t1(s_0,i_number_of_columns,i_m)
      s_expected="97"
      kibuvits_throw "test 5 s_x==\""+s_x.to_s+"\"" if s_x!=s_expected
      #---------
      s_0="ab"
      i_number_of_columns=5
      s_x=Kibuvits_security_core.s_mmmv_checksum_t1(s_0,i_number_of_columns,i_m)
      s_expected="97_98_97_98_97"
      kibuvits_throw "test 6 s_x==\""+s_x.to_s+"\"" if s_x!=s_expected
      #---------
      i_0=472
      s_0="ab"*i_0
      i_number_of_columns=2
      s_x=Kibuvits_security_core.s_mmmv_checksum_t1(s_0,i_number_of_columns,i_m)
      s_expected=(97*i_0).to_s+"_"+(98*i_0).to_s
      kibuvits_throw "test 7 s_x==\""+s_x.to_s+"\"" if s_x!=s_expected
      #---------
   end # Kibuvits_security_core_selftests.test_1

   #-----------------------------------------------------------------------

   def Kibuvits_security_core_selftests.test_ht_gen_substitution_box_t1
      func_gen=lambda do |ix|
         ar_out=Array.new
         if (ix%4)==0           # 0,4,8,12,16
            ar_out<<[ix,(ix+1)] # 1,5,9,13,17
         end # if
         if (ix%4)==1           # 1,5,9,13,17
            ar_out<<[ix,(ix-1)] # 0,4,8,12,16
         end # if
         return ar_out
      end # func
      i_alphabet_length=20
      i_n_of_passes=2
      ht_x=Kibuvits_security_core.ht_gen_substitution_box_t1(
      func_gen,i_alphabet_length)

      ar_keys_x=ht_x.keys
      i_ar_keys_x_len=ar_keys_x.size
      if i_ar_keys_x_len!=10
         kibuvits_throw "test 1a i_ar_keys_x_len=="+i_ar_keys_x_len.to_s
      end # if
      ar_keys_expected=[0,1,4,5,8,9,12,13,16,17]
      ar_values_expected=[1,0,5,4,9,8,13,12,17,16]
      i_key=nil
      x_value=nil
      i_key_expected=nil
      i_value_expected=nil
      ar_keys_expected.size.times do |ix|
         i_key_expected=ar_keys_expected[ix]
         i_value_expected=ar_values_expected[ix]
         x_value=ht_x[i_key_expected]
         if x_value!=i_value_expected
            x_value="nil" if x_value==nil
            kibuvits_throw("test 1b ht_x["+i_key_expected.to_s+"] == "+
            x_value.to_s+" != "+i_value_expected.to_s)
         end # if
      end # loop
      # The initial ht_x is frozen. The clone is not.
      #ht_x=Kibuvits_htoper_t1.ht_clone_with_shared_references(ht_x)
      #ht_x.delete(1) # for testing the tests
      ar_keys_expected.each do |i_key_expected|
         if !ht_x.has_key? i_key_expected
            kibuvits_throw("test 1c The key "+i_key_expected.to_s+
            " is missing from the substitution box hashtable.")
         end # if
      end # loop
   end # Kibuvits_security_core_selftests.test_ht_gen_substitution_box_t1

   #-----------------------------------------------------------------------

   def Kibuvits_security_core_selftests.test_i_nsa_cpu_cycles_per_second_t1
      bn=binding()
      i_x=Kibuvits_security_core.i_nsa_cpu_cycles_per_second_t1()
      kibuvits_typecheck bn, [Fixnum,Bignum], i_x
   end # Kibuvits_security_core_selftests.test_i_nsa_cpu_cycles_per_second_t1

   #-----------------------------------------------------------------------

   def Kibuvits_security_core_selftests.test_txor
      m=50
      i_cleartext=42
      i_key=28
      i_chiphertext=Kibuvits_security_core.txor(i_cleartext,i_key,m)
      i_x=Kibuvits_security_core.txor(i_chiphertext,i_key,m)
      kibuvits_throw "test 1a i_x=="+i_x.to_s if i_cleartext!=i_x
      kibuvits_throw "test 1b i_x=="+i_x.to_s if i_cleartext==i_chiphertext
      #---------
   end # Kibuvits_security_core_selftests.test_txor

   #-----------------------------------------------------------------------

   def Kibuvits_security_core_selftests.test_kibuvits_hash_plaice_t1
      i_headerless_hash_length=8
      s_data="TEre!ff"
      s_x1=kibuvits_hash_plaice_t1(s_data,i_headerless_hash_length)
      s_x2=kibuvits_hash_plaice_t1(s_data,i_headerless_hash_length)
      kibuvits_throw "test 1a s_x1=="+s_x1.to_s if s_x1!=s_x2
      #---------
      i_headerless_hash_length=1
      s_x1=kibuvits_hash_plaice_t1(s_data,i_headerless_hash_length)
      s_x1=kibuvits_hash_plaice_t1("",i_headerless_hash_length)
      i_headerless_hash_length=30
      s_x1=kibuvits_hash_plaice_t1(s_data,i_headerless_hash_length)
      #---------
      i_headerless_hash_length=5
      s_data="longer than the 40 rounds times i_headerless_hash_length"*40
      s_x1=kibuvits_hash_plaice_t1(s_data,i_headerless_hash_length)
      #---------
   end # Kibuvits_security_core_selftests.test_kibuvits_hash_plaice_t1


   #-----------------------------------------------------------------------

   public
   def Kibuvits_security_core_selftests.selftest
      ar_msgs=Array.new
      bn=binding()
      kibuvits_testeval bn, "Kibuvits_security_core_selftests.test_1"
      kibuvits_testeval bn, "Kibuvits_security_core_selftests.test_ht_gen_substitution_box_t1"
      kibuvits_testeval bn, "Kibuvits_security_core_selftests.test_i_nsa_cpu_cycles_per_second_t1"
      kibuvits_testeval bn, "Kibuvits_security_core_selftests.test_txor"
      kibuvits_testeval bn, "Kibuvits_security_core_selftests.test_kibuvits_hash_plaice_t1"
      return ar_msgs
   end # Kibuvits_security_core_selftests.selftest

end # class Kibuvits_security_core_selftests

#==========================================================================
# Kibuvits_security_core_selftests.test_1
