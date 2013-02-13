#!/usr/bin/ruby
#
## encoding: utf-8
#-----------------------------------------------------------------------
require "pathname";
LOCAL_PWD=Pathname.new($0).realpath.parent.to_s 
DEPS_FOLDER_PATH=LOCAL_PWD+"/dependencies" 
require DEPS_FOLDER_PATH+"/io.rb";
require DEPS_FOLDER_PATH+"/shell.rb";
#-----------------------------------------------------------------------
path_tmp_=LOCAL_PWD+"/../tmp_"
path_test_data=LOCAL_PWD+"/../test_data"


fp_wildtext=path_tmp_+"/wild_text1.txt"
fp_coords=path_tmp_+"/coords.txt"
sh "cp -f "+path_test_data+"/wild_text1.txt "+fp_wildtext+" ;"
sh "ruby "+LOCAL_PWD+
	"/wild_text_2_GUID_coordinates.rb wild_text_2_guids "+
	fp_coords+" "+fp_wildtext+" ;"
#-----------------------------------------------------------------------

