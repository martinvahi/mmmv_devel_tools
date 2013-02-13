#!/home/zornilemma/m_local/bin_p/Ruby/1.8.7/bin/ruby
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
require "pathname";
LOCAL_PWD=Pathname.new($0).realpath.parent.to_s if not defined? LOCAL_PWD
DEPS_FOLDER_PATH=LOCAL_PWD+"/dependencies" if not defined? DEPS_FOLDER_PATH
require DEPS_FOLDER_PATH+"/io.rb"
require DEPS_FOLDER_PATH+"/ProgFTE.rb"
require DEPS_FOLDER_PATH+"/shell.rb";
#-----------------------------------------------------------------------

class WildText2GUIDS

   def initialize coords_file_path, wild_text_file_path
	  @fp_coords=ensure_absolute_path(coords_file_path)
	  @fp_wild_text=ensure_absolute_path(wild_text_file_path)
   end # initialize

   def copyright
	  return "Copyright (c) 2009, martin.vahi@eesti.ee that has an \n"+
	  "Estonian national identification number of 38108050020. \n"+
	  "This class is under the BSD license."
   end # copyright

   private
   def file_signature file_or_folder_path
	  ffp=file_or_folder_path
	  throw "File "+ffp+" doesn't exist" if !File.exists? ffp
	  is_regular_file=File.file? ffp
	  s=ffp+"__is_not_a_regular_file"
	  s=ffp+"__is_regular_file" if is_regular_file
	  creation_time=File.ctime ffp
	  s=s+"__creation_time=="+creation_time.to_f.to_s
	  if is_regular_file
		 modification_time=File.mtime ffp
		 s=s+"__modification_time=="+modification_time.to_f.to_s
		 s=s+"__size=="+File.size(ffp).to_s
	  end # if
	  return s
   end #file_signature

   def ensure_coordsfile_existence
	  return if File.exists? @fp_coords
	  ht_coords=Hash.new
	  ht_coords["wildtext_file_signature"]="indicates that the "+
	  "coords file has to be reset and created from scratch"
	  ht_coords["GUIDS_trace_length"]=0.to_s
	  ht_coords["GUIDS_trace_current_position"]=0.to_s
	  s_progfte=ProgFTE.from_ht(ht_coords)
	  str2file(s_progfte,@fp_coords)
   end #ensure_coordsfile_existence

   public
   def parse_wild_text
	  ensure_coordsfile_existence
	  s_coords=file2str(@fp_coords)
	  ht_coords=ProgFTE.to_ht(s_coords)
	  signature_on_disk=file_signature @fp_wild_text
	  return if signature_on_disk==ht_coords["wildtext_file_signature"]
	  # As the whild txt changed, the whole coords file has
	  # to be regenerated.
	  File.delete(@fp_coords)
	  ensure_coordsfile_existence
	  s_coords=file2str(@fp_coords)
	  ht_coords=ProgFTE.to_ht(s_coords)

	  ht_coords["wildtext_file_signature"]=signature_on_disk
	  s_wild=file2str(@fp_wild_text)
	  ar_guids=Array.new
	  s_regex_core=".{8}[-].{4}[-].{4}[-].{4}[-].{12}"
	  s_regex_single_quotes="[']"+s_regex_core+"[']"
	  s_regex_double_quotes="[\"]"+s_regex_core+"[\"]"

	  #       '22222222-2222-2222-2222-222222222222'
	  s_repl="THIS_STRING_HAS_GUID_LENGT_FOR_GIVING_"
	  # the in-place text replacement algorithm a chance to use
	  # a faster branch. The quotes are included, because
	  # one also replaces the quotes for simplicity.

	  old_GUID=nil
	  go_on=true
	  while go_on do
		 go_on=false
		 # The String.match returns either nil or MatchData
		 # instance. That is to say, String.match DOES NOT,
		 # return a string.
		 old_GUID=s_wild.match(s_regex_single_quotes)
		 if old_GUID!=nil
			old_GUID=old_GUID.to_s
			ar_guids<<old_GUID
			s_wild.sub!(old_GUID,s_repl)
			go_on=true
		 end # if
		 old_GUID=s_wild.match(s_regex_double_quotes)
		 if old_GUID!=nil
			old_GUID=old_GUID.to_s
			ar_guids<<old_GUID
			s_wild.sub!(old_GUID,s_repl)
			go_on=true
		 end # if
	  end # while
	  n=ar_guids.length
	  ht_coords["GUIDS_trace_length"]=n.to_s
	  ht_coords["GUIDS_trace_current_position"]=0.to_s
	  n=n-1;
	  ht_coords["GUIDS_trace_current_position"]=n.to_s if 0 < n
	  i=0; s="";
	  ar_guids.each do |a_guid|
		 s="trace_index_"+i.to_s
		 ht_coords[s]=a_guid
		 ht_coords[a_guid]=s
		 i=i+1
	  end # loop
	  s_progfte=ProgFTE.from_ht(ht_coords)
	  str2file(s_progfte,@fp_coords)
   end # parse_wild_text

end # class WildText2GUIDS

#-----------------------------------------------------------------------
class GUIDs2coords
   def initialize  coords_file_path, project_folder_path
	  @fp_coords=ensure_absolute_path(coords_file_path)
	  @fp_project_folder=ensure_absolute_path(project_folder_path)
	  if not File.directory? @fp_project_folder
		 throw "The "+@fp_project_folder+" is not a folder.\n"
	  end # if
	  if File.directory? @fp_coords
		 throw "The coords "+@fp_coords+" is a folder.\n"
	  end # if
	  if not File.exist? @fp_coords
		 throw "The coords file "+@fp_coords+" doesn't exist.\n"
	  end # if
	  s_coords=file2str(@fp_coords)
	  @ht_coords=ProgFTE.to_ht(s_coords)
   end # initialize
   private

   # Returns grep output. Verification is expected to happen elsewhere.
   def search_recursively_from_files searchstring, folder_path
	  abs_path=ensure_absolute_path(folder_path)
	  folder_p=bash_script_2_literal(abs_path)
	  s=bash_script_2_literal(searchstring)
	  cmd="cd "+folder_p+";grep --recursive -F -H -n "+s+" ./* ;"
	  console_output=sh(cmd)
	  return console_output
   end # search_recursively_from_files

   public
   def get_coordinate of_a_guid # with quotes included
	  if @ht_coords.has_key? "coordinates_"+of_a_guid
		 #coordinate=@ht_coords["coordinates_"+of_a_guid]
		 #s_progfte=ProgFTE.from_ht(@ht_coords)
		 #File.delete @fp_coords
		 #str2file(s_progfte,@fp_coords)
		 #return "coordinate_found|"+coordinate+"|"
	  end # if
	  # We'll go searching.
	  fp=@fp_project_folder
	  s_grep_output=search_recursively_from_files(of_a_guid,fp)
	  ar_lines=Array.new
	  s_grep_output.each_line{|x| ar_lines<<""+x[0..(-2)] ;}
	  if ar_lines.length==0
		 s_progfte=ProgFTE.from_ht(@ht_coords)
		 File.delete @fp_coords
		 str2file(s_progfte,@fp_coords)
		 return "coordinate_not_found|"+of_a_guid+
		 "|x|get_coordinate 1"
	  end # if
	  coordinate=(ar_lines[0].match("[^:]+[:][^:]+[:]")).to_s
	  if 2 < coordinate.length
		 if coordinate[0..1]=="./"
			coordinate=@fp_project_folder+"/"+coordinate[2..-1]
		 end # if
	  end # if
	  # The next few lines change
	  # "/nice/path.exe:42:" to "file:///nice/path.exe#42"
	  coordinate="file://"+
	  ((coordinate[0..-2]).reverse.sub(":","#").reverse)
	  @ht_coords["coordinates_"+of_a_guid]=coordinate
	  s_progfte=ProgFTE.from_ht(@ht_coords)
	  File.delete @fp_coords
	  str2file(s_progfte,@fp_coords)
	  return "coordinate_found|"+coordinate+"|"
   end #get_coordinate

   def increase_cursor
	  cursor_max=@ht_coords["GUIDS_trace_length"].to_i-1
	  cursor=@ht_coords["GUIDS_trace_current_position"].to_i
	  throw "cursor=="+cursor.to_s+" < 0" if cursor < 0
	  return "coordinate_not_found|x|x|increase_cursor 1" if cursor_max < 0
	  cursor_new=cursor
	  cursor_new=cursor+1 if cursor<cursor_max
	  s_guid=@ht_coords["trace_index_"+cursor_new.to_s]
	  @ht_coords["GUIDS_trace_current_position"]=cursor_new.to_s
	  coord=get_coordinate(s_guid)
	  return coord
   end #increase_cursor


   def decrease_cursor
	  cursor_max=@ht_coords["GUIDS_trace_length"].to_i-1
	  cursor=@ht_coords["GUIDS_trace_current_position"].to_i
	  throw "cursor=="+cursor.to_s+" < 0" if cursor < 0
	  return "coordinate_not_found|x|x|decrease_cursor 1" if cursor_max < 0
	  cursor_new=cursor
	  cursor_new=cursor-1 if 0<cursor
	  s_guid=@ht_coords["trace_index_"+cursor_new.to_s]
	  @ht_coords["GUIDS_trace_current_position"]=cursor_new.to_s
	  coord=get_coordinate(s_guid)
	  return coord
   end #decrease_cursor

   def current_cursor
	  cursor_max=@ht_coords["GUIDS_trace_length"].to_i-1
	  cursor=@ht_coords["GUIDS_trace_current_position"].to_i
	  throw "cursor=="+cursor.to_s+" < 0" if cursor < 0
	  return "coordinate_not_found|x|x|decrease_cursor 1" if cursor_max < 0
	  cursor_new=cursor
	  s_guid=@ht_coords["trace_index_"+cursor_new.to_s]
	  @ht_coords["GUIDS_trace_current_position"]=cursor_new.to_s
	  coord=get_coordinate(s_guid)
	  return coord
   end #current_cursor

   # ProgFTE class demo code:
   #ht=Hash.new
   #ht['Welcome']='to hell'
   #ht['with XML']='we all go'
   #s_progfte=ProgFTE.from_ht(ht)
   #ht.clear
   #ht2=ProgFTE.to_ht(s_progfte)
   #puts ht2['with XML']

end # class GUIDs2coords

#-----------------------------------------------------------------------
@err_msg=<<HERE

Console arguments in semi-BNF, where terminals are in quotes:

-----start--------
CONSOLARGS::=WILD_TEXT_2_GUIDS | GET_GUID_COORDINATE
GET_GUID_COORDINATE::= GUID_2_COORDINATE | DEC_CUR | CUR_CUR | INC_CUR 

WILD_TEXT_2_GUIDS::= "wild_text_2_guids" WT2G_PATHS
WT2G_PATHS::= PATH_2_GUIDS_TEXTFILE PATH_2_WILD_TEXT

GUID_2_COORDINATE::= "guid_2_coordinate" G2C_PATHS 
G2C_PATHS::= PATH_2_GUIDS_TEXTFILE PATH_2_PROJECT_FOLDER SEARCHSTRING_IdEst_GUID

DEC_CUR::= "decrease_cursor" PATH_2_GUIDS_TEXTFILE  PATH_2_PROJECT_FOLDER 
CUR_CUR::= "current_cursor"  PATH_2_GUIDS_TEXTFILE  PATH_2_PROJECT_FOLDER 
INC_CUR::= "increase_cursor" PATH_2_GUIDS_TEXTFILE  PATH_2_PROJECT_FOLDER 
-----end---------

In the case of the "wild_text_2_guids" the guids text file
will be created, if it does not exist.
The guids-textfile will be regenerated only, if the wild-text 
has changed after the last generation of the guids-textfile.

The porject folder is searched for the GUID location, recursively,
only, if the location is missing from the guids-textfile.

Theis script depends on Linux grep and bash.

HERE

mode="";
def verify_args
   err=true
   mode=ARGV[0]
   err=err&&(!(mode=="wild_text_2_guids"))
   err=err&&(!(mode=="guid_2_coordinate"))
   err=err&&(!(mode=="current_cursor"))
   err=err&&(!((mode=="increase_cursor")||(mode=="decrease_cursor")))

   err=true if(ARGV.length!=3)&&(mode=="wild_text_2_guids")
   err=true if(ARGV.length!=4)&&(mode=="guid_2_coordinate")
   err=true if(ARGV.length!=3)&&(mode=="increase_cursor")
   err=true if(ARGV.length!=3)&&(mode=="decrease_cursor")
   err=true if(ARGV.length!=3)&&(mode=="current_cursor")
   if err
	  puts @err_msg;
	  exit
   end # if
   return mode
end #verify_args
mode=verify_args
if(mode=="increase_cursor")
   g2gl=GUIDs2coords.new  ARGV[1], ARGV[2]
   puts g2gl.increase_cursor
   exit
end # if
if(mode=="decrease_cursor")
   g2gl=GUIDs2coords.new  ARGV[1], ARGV[2]
   puts g2gl.decrease_cursor
   exit
end # if
if(mode=="current_cursor")
   g2gl=GUIDs2coords.new  ARGV[1], ARGV[2]
   puts g2gl.current_cursor
   exit
end # if
if(mode=="wild_text_2_guids")
   wt2g=WildText2GUIDS.new ARGV[1], ARGV[2]
   wt2g.parse_wild_text
   exit
end # if
if(mode=="guid_2_coordinate")
   g2gl=GUIDs2coords.new  ARGV[1], ARGV[2]
   puts g2gl.get_coordinate  ARGV[3]
   exit
end # if
puts @err_msg;



