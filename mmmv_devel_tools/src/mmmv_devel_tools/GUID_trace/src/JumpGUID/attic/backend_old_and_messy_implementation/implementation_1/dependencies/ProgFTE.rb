#!/usr/bin/ruby
##
## encoding: utf-8
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

------------------------------------------------------------------------
This file adds ProgFTE support to Ruby. The reason, why it 
contains the testing related extra code is that this way it is
self-contained.

=end
#-----------------------------------------------------------------------
# The ProgFTE is a text format for serializing hashtables that 
# contain only strings and use only strings for keys. The 
# ProgFTE stands for Programmer Friendly Text Exchange.
#
# The class ProgFTE is used for both, serializing, and deserializing
# the hashtables. If linebreaks are used within the values, the ProgFTE
# file format can be used for creating a config file that is readable
# from any programming language that has a ProgFTE library.
class ProgFTE

def initialize
end #initialize

private

def ProgFTE.selftest_failure(a,b)
	throw Exception.new(a.to_s+b.to_s).to_s
end # selftest_failure

# Returns a boolean value.
def ProgFTE.block_throws
	answer=false;
	begin
		yield
	rescue Exception => e
		answer=true
	end # try-catc
	return answer
end # block_throws


def ProgFTE.is_string(a_string_candidate)
	answer=false;
	answer=true if(a_string_candidate.class.to_s=='String')
	return answer
end # is_string

def ProgFTE.assert_type_string(a_string_candidate)
	if(not ProgFTE.is_string(a_string_candidate))
		throw Exception.new("\na_string_candidate had a value "+
			'of '+a_string_candidate.to_s+' and it was of '+
			'type '+a_string_candidate.class.to_s+'.');
		end # if
end #assert_type_string 

def ProgFTE.is_of_type(a_candidate, type_name)
	ProgFTE.assert_type_string(type_name);
	answer=false;
	answer=true if(a_candidate.class.to_s==type_name)
	return answer
end # is_of_type


def ProgFTE.assert_type(a_candidate, type_name)
	if(not ProgFTE.is_of_type(a_candidate,type_name))
		throw Exception.new("\na_candidate had a value "+
			'of '+a_candidate.to_s+' and it was of '+
			'type '+a_candidate.class.to_s+'.');
		end # if
end #assert_type

# As thhe string bisection is something that is done multiple
# times duering string snatching, there's no point of executing
# the assertion code every time.
def ProgFTE.bisect_str_assertionfree(input_string,separator_string)
	ar=Array.new(2,"")
	i=input_string.index(separator_string)
	if(i==nil)
		ar[0]=input_string
		return ar;
		end # if
	ar[0]=input_string[0..(i-1)]
	ar[1]=input_string[(i+separator_string.length)..(-1)]
	return ar	
end # bisect_str 

public

# It returns an array of 2 elements. If the separator is not
# found, the array[0]==input_string and array[1]=="".
def ProgFTE.bisect_str(input_string,separator_string)
	ProgFTE.assert_type_string(input_string)
	ProgFTE.assert_type_string(separator_string)
	if(separator_string=="")
		throw Exception.new("\nThe separator string had a "+
			"value of \"\", but empty strings are not "+
			"allowed to be used as separator strings.");
		end # if
	x=ProgFTE.bisect_str_assertionfree(input_string,separator_string)
	return x
end # bisect_str 

private
def ProgFTE.test_bisect_str
	s='AhXXhoo'
	ar=ProgFTE.bisect_str(s,'XX');
	tf='ProgFTE.test_bisect_str '
	ProgFTE.selftest_failure(tf,0) if ar.length!=2
	ProgFTE.selftest_failure(tf,1) if ar[0]!="Ah"
	ProgFTE.selftest_failure(tf,2) if ar[1]!="hoo"
	ar=ProgFTE.bisect_str(s,'XXX');
	ProgFTE.selftest_failure(tf,3) if ar[0]!=s
	ProgFTE.selftest_failure(tf,4) if ar[1]!=""
	s='AhXXhooXX'
	ar=ProgFTE.bisect_str(s,'XX');
	ProgFTE.selftest_failure(tf,5) if ar[0]!="Ah"
	ProgFTE.selftest_failure(tf,6) if ar[1]!="hooXX"
	if not ProgFTE.block_throws{ ProgFTE.bisect_str(s,7)}
		ProgFTE.selftest_failure(tf,7) 
		end # if
	if not ProgFTE.block_throws{ ProgFTE.bisect_str(9,'XX')}
		ProgFTE.selftest_failure(tf,8) 
		end # if
	if not ProgFTE.block_throws{ ProgFTE.bisect_str(11,11)}
		ProgFTE.selftest_failure(tf,9) 
		end # if
	if not ProgFTE.block_throws{ ProgFTE.bisect_str(s,"")}
		ProgFTE.selftest_failure(tf,10) 
		end # if
	if ProgFTE.block_throws{ ProgFTE.bisect_str("","XX")}
		ProgFTE.selftest_failure(tf,11) 
		end # if
end # test_bisect_str

public
# Returns an array of strings that contains only the snatched 
# string pieces.
def ProgFTE.snatch_n_times(haystack_string, separator_string,n)
	ProgFTE.assert_type_string(haystack_string)
	ProgFTE.assert_type_string(separator_string)
	ProgFTE.assert_type(n,'Fixnum')
	if(separator_string=="")
		throw Exception.new("\nThe separator string had a "+
			"value of \"\", but empty strings are not "+
			"allowed to be used as separator strings.");
		end # if
	tf='ProgFTE.snatch_n_times'
	s_hay=haystack_string
	ProgFTE.selftest_failure(tf,1) if s_hay.length==0
	# It's a bit vague, wheter '' is also present at the 
	# very end and very start of the string or only between
	# characters. That's why there's a limitation, that the 
	# separator_string may not equal with the ''.
	ProgFTE.selftest_failure(tf,2) if separator_string.length==0
	s_hay=""+haystack_string
	ar=Array.new
	ar1=nil
	n.times do |x|
		ar1=ProgFTE.bisect_str(s_hay,separator_string)
		ar<<ar1[0]
		s_hay=ar1[1]	
		# The following line assumes that the 
		# separator_string is not allowed to equal '' 
		ProgFTE.selftest_failure(tf,3) if (s_hay=='') and ((x+1)<n)
		end # loop
	return ar;	
end # snatch_n_times

private
def ProgFTE.test_snatch_n_times
	s='AhXXhooXXBooXXCooXXDoo'
	ar=ProgFTE.snatch_n_times(s,'XX',4);
	tf='ProgFTE.test_snatch_n_times '
	ProgFTE.selftest_failure(tf,0) if ar.length!=4
	ProgFTE.selftest_failure(tf,1) if ar[0]!="Ah"
	ProgFTE.selftest_failure(tf,2) if ar[1]!="hoo"
	ProgFTE.selftest_failure(tf,3) if ar[2]!="Boo"
	ProgFTE.selftest_failure(tf,4) if ar[3]!="Coo"
	s='AzXXiooXX'
	ar=ProgFTE.snatch_n_times(s,'XX',2);
	ProgFTE.selftest_failure(tf,5) if ar.length!=2
	ProgFTE.selftest_failure(tf,6) if ar[0]!="Az"
	ProgFTE.selftest_failure(tf,7) if ar[1]!="ioo"
	if not ProgFTE.block_throws{ ProgFTE.snatch_n_times(s,'XX',3)}
		ProgFTE.selftest_failure(tf,8) 
		end # if
	if not ProgFTE.block_throws{ ProgFTE.snatch_n_times(11,11,1)}
		ProgFTE.selftest_failure(tf,9) 
		end # if
	if not ProgFTE.block_throws{ ProgFTE.snatch_n_times(s,11,1)}
		ProgFTE.selftest_failure(tf,10) 
		end # if
	if not ProgFTE.block_throws{ ProgFTE.snatch_n_times(44,"XX",1)}
		ProgFTE.selftest_failure(tf,11) 
		end # if
end # test_snatch_n_times

public
def ProgFTE.ht_to_s(a_hashtable)
	ProgFTE.assert_type(a_hashtable,'Hash')
	s=""
	a_hashtable.keys.each do |a_key| 
		s=s+a_key.to_s
		s=s+(a_hashtable[a_key].to_s) # Ruby 1.9. bug workaround
		end # loop
	return s;
end # ht_to_s

private
def ProgFTE.test_ht_to_s
	tf='ProgFTE.test_ht_to_s'
	if not ProgFTE.block_throws{ ProgFTE.ht_to_s('XXX')}
		ProgFTE.selftest_failure(tf,1) 
		end # if
	ht=Hash.new
	ht['abc']='def'
	ht['ghi']='jklm'
	ht['nop']='rst'
	s=ProgFTE.ht_to_s(ht)
	# The keys of the hashtable are not ordered alphabetically.
	ProgFTE.selftest_failure(tf,2) if s!="abcdefnoprstghijklm"
end # test_ht_to_s

public
def ProgFTE.create_nonexisting_needle(haystack_string)
	ProgFTE.assert_type_string(haystack_string)
	n=0   
	s_needle='^0'
	while haystack_string.include? s_needle do 
		n=n+1;	
		s_needle='^'+n.to_s
		end # loop
	return s_needle
end # create_nonexisting_needle

private
def ProgFTE.test_create_nonexisting_needle
	tf='ProgFTE.test_create_nonexisting_needle'
	if not ProgFTE.block_throws{ ProgFTE.create_nonexisting_needle(4)}
		ProgFTE.selftest_failure(tf,1) 
		end # if
	s=ProgFTE.create_nonexisting_needle('abcdefg')
	ProgFTE.selftest_failure(tf,2) if s!='^0'
	s=ProgFTE.create_nonexisting_needle('ab^0cdefg')
	ProgFTE.selftest_failure(tf,3) if s!='^1'
	s=ProgFTE.create_nonexisting_needle('')
	ProgFTE.selftest_failure(tf,4) if s!='^0'
end # test_create_nonexisting_needle


public
def ProgFTE.from_ht(a_hashtable)
	ProgFTE.assert_type(a_hashtable,'Hash')
	ht=a_hashtable
	s_subst=ProgFTE.create_nonexisting_needle(ProgFTE.ht_to_s(ht))
	s_progfte=''+ht.size.to_s+'|||'+s_subst+'|||'
	s_key=''; s_value=''; # for a possible, slight, speed improvement 
	ht.keys.each do |key| 
		a_key=key.to_s # Ruby 1.9 bug workaround
		ProgFTE.assert_type_string(a_key)
		s_key=a_key.gsub('|',s_subst)
		s_value=(ht[a_key]).to_s
		ProgFTE.assert_type_string(s_value)
		s_value=s_value.gsub('|',s_subst)
		s_progfte=s_progfte+s_key+'|||'+s_value+'|||' 
		end # loop
	return s_progfte
end # from_ht

private
def ProgFTE.test_from_ht
	tf='ProgFTE.test_from_ht'
	if not ProgFTE.block_throws{ ProgFTE.from_ht(4)}
		ProgFTE.selftest_failure(tf,1) 
		end # if
	if not ProgFTE.block_throws{ ProgFTE.from_ht('xx')}
		ProgFTE.selftest_failure(tf,2) 
		end # if
	ht=Hash.new
	s=ProgFTE.from_ht(ht)
	ProgFTE.selftest_failure(tf,3) if s!='0|||^0|||'
	ht['ab']='cd|'
	ht['|ef']='gh'
	s_progfte='2|||^0|||ab|||cd^0|||^0ef|||gh|||'
	s=ProgFTE.from_ht(ht)
	ProgFTE.selftest_failure(tf,4) if s!=s_progfte
	ht['^0x']='gh'
	s_progfte='3|||^1|||ab|||cd^1|||^0x|||gh|||^1ef|||gh|||'
	s=ProgFTE.from_ht(ht)
	ProgFTE.selftest_failure(tf,5) if s!=s_progfte
end # test_from_ht


public
def ProgFTE.to_ht(a_string)
	ProgFTE.assert_type_string(a_string)
	ar=ProgFTE.bisect_str(a_string,'|||')
	tf='ProgFTE.to_ht'
	ProgFTE.selftest_failure(tf,1) if ar[1]==""
	n=Integer(ar[0])
	s_subst=''
	err_no=2
	ht=Hash.new
	begin
		ar1=ProgFTE.bisect_str(ar[1],'|||')
		s_subst=ar1[0]
		err_no=3
		ProgFTE.selftest_failure(tf,err_no) if s_subst==''
		err_no=4
		# ar1[1]=='', if n==0 and it's legal in here
		ar=ProgFTE.snatch_n_times(ar1[1],'|||',n*2) if 0<n 
		err_no=5
		n.times do |x| 
			key=ar[x*2].gsub(s_subst,'|')
			value=(ar[x*2+1]).gsub(s_subst,'|')
			ht[key]=value
			end # loop
	rescue
		ProgFTE.selftest_failure(tf,err_no) 
		end # try-catch 
	return ht 
end # to_ht

private
def ProgFTE.test_to_ht
	tf='ProgFTE.test_to_ht'
	if not ProgFTE.block_throws{ ProgFTE.to_ht(4)}
		ProgFTE.selftest_failure(tf,1) 
		end # if
	ht=Hash.new
	if not ProgFTE.block_throws{ ProgFTE.to_ht(ht)}
		ProgFTE.selftest_failure(tf,2) 
		end # if
	s_progfte='3|||^1|||ab|||cd^1|||^0x|||gh|||^1ef|||gh|||'
	ht=ProgFTE.to_ht(s_progfte)
	ProgFTE.selftest_failure(tf,3) if ht['^0x']!='gh'
	ProgFTE.selftest_failure(tf,4) if ht['ab']!='cd|'
	ProgFTE.selftest_failure(tf,5) if ht['|ef']!='gh'
	ProgFTE.selftest_failure(tf,6) if ht.size!=3
	s_progfte='0|||^0|||'
	ht=ProgFTE.to_ht(s_progfte)
	ProgFTE.selftest_failure(tf,7) if ht.size!=0
end # test_to_ht

def ProgFTE.test_s_to_ht_to_s
	ht0=Hash.new
	ht0['|||']='xxx'
	ht0['|||x']='|||'
	ht0['x']='|g'
	s_ht0=ProgFTE.from_ht(ht0)
	ht1=Hash.new
	ht1['ab']='cd|'
	ht1['|ef']='gh'
	ht1['ht0']=s_ht0
	ht1['z']='y'
	s_ht1=ProgFTE.from_ht(ht1)
	ht0.clear
	ht1.clear
	ht2=ProgFTE.to_ht(s_ht1)
	ht3=ProgFTE.to_ht(ht2['ht0'])
	tf='ProgFTE.test_s_to_ht_to_s'
	ProgFTE.selftest_failure(tf,1) if ht3.size!=3
	ProgFTE.selftest_failure(tf,2) if ht2.size!=4
	ProgFTE.selftest_failure(tf,3) if ht3['|||']!='xxx'
	ProgFTE.selftest_failure(tf,4) if ht3['|||x']!='|||'
	ProgFTE.selftest_failure(tf,5) if ht3['x']!='|g'
	ProgFTE.selftest_failure(tf,6) if ht2['ab']!='cd|'
	ProgFTE.selftest_failure(tf,7) if ht2['|ef']!='gh'
	ProgFTE.selftest_failure(tf,8) if ht2['z']!='y'

	# The test version with a space within a key seems to catch 
	# some weird flaws that would otherwise be unnoticed.
	ht=Hash.new
	ht['Welcome']='to hell'
	ht['with XML']='we all go'
	s_progfte=ProgFTE.from_ht(ht)
	ht.clear
	ht2=ProgFTE.to_ht(s_progfte)
	ProgFTE.selftest_failure(tf,9) if ht2['with XML']!='we all go'
end # test_s_to_ht_to_s

# Executes a selftest
def ProgFTE.selftest
	ProgFTE.test_bisect_str
	ProgFTE.test_snatch_n_times
	ProgFTE.test_ht_to_s
	ProgFTE.test_create_nonexisting_needle
	ProgFTE.test_from_ht
	ProgFTE.test_to_ht
	ProgFTE.test_s_to_ht_to_s
end # selftest

end #ProgFTE

#--------------------------------------------------------------------------
#ProgFTE.selftest

# Usage demo code:
#ht=Hash.new
#ht['Welcome']='to hell'
#ht['with XML']='we all go'
#s_progfte=ProgFTE.from_ht(ht)
#ht.clear
#ht2=ProgFTE.to_ht(s_progfte)
#puts ht2['with XML']
