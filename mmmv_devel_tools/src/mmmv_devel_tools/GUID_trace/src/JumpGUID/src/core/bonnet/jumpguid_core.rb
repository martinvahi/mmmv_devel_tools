#!/usr/bin/env ruby
#==========================================================================
=begin

 Copyright 2012, martin.vahi@softf1.com that has an
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

if !defined? JUMPGUID_CORE_RB_INCLUDED
   JUMPGUID_CORE_RB_INCLUDED=true
   if !defined? MMMV_DEVEL_TOOLS_HOME
      # The MMMV_DEVEL_TOOLS_HOME has to be derived
      # here, locally, because this way DumpGUID
      # implementation can save one extra bash process
      # creation per every call made to JumpGUID core.
      require 'pathname'
      ob_pth_1=Pathname.new(__FILE__).realpath.parent.parent.parent
      ob_pth_2=ob_pth_1.parent.parent.parent.parent.parent.parent
      MMMV_DEVEL_TOOLS_HOME=ob_pth_2.to_s.freeze
   end # if
   require MMMV_DEVEL_TOOLS_HOME+"/src/bonnet/mmmv_devel_tools_initialization_t1.rb"

   require KIBUVITS_HOME+"/src/include/kibuvits_io.rb"
   require KIBUVITS_HOME+"/src/include/kibuvits_shell.rb"
   require KIBUVITS_HOME+"/src/include/kibuvits_argv_parser.rb"
   require KIBUVITS_HOME+"/src/include/kibuvits_fs.rb"
   require KIBUVITS_HOME+"/src/include/kibuvits_finite_sets.rb"
end # if

#==========================================================================

class JumpGUID_core

   attr_reader  :msgcs
   private

   def ht_load_copy_of_ht_db(s_fp_db)
      ht_out=nil
      ht_stack=nil
      ht_searchhints=nil

      b_init_new_ht_db=true
      s_db_format_version="1"
      lc_s_db_format_version="s_db_format_version"

      s_config_ht_hash=nil

      # TODO: Multiple processes can still collide and
      # ruin the data at the disk. One should fix that.
      if File.exists? s_fp_db
         s_progfte=file2str(s_fp_db)
         ht_out=Kibuvits_ProgFTE.to_ht(s_progfte)

         if ht_out[lc_s_db_format_version]==s_db_format_version
            # Changes in mmmv_devel_tools configuration may
            # include changes in the set of project folders, which
            # may render some cached location info out of date.
            s_config_ht_hash=C_mmmv_devel_tools_global_singleton.s_config_hash_t1()
            if ht_out[@lc_s_config_hash]==s_config_ht_hash
               s_progfte=ht_out[@lc_s_ht_stack]
               ht_stack=Kibuvits_ProgFTE.to_ht(s_progfte)

               s_progfte=ht_out[@lc_s_ht_searchhints]
               if s_progfte.length <=10000
                  ht_searchhints=Kibuvits_ProgFTE.to_ht(s_progfte)
                  ht_searchhints.clear if @i_max_number_of_searchhints<=ht_searchhints.size
               else
                  ht_searchhints=Hash.new
               end # if

               i_cursor_position=ht_out[@lc_s_i_cursor_position].to_i
               ht_out[@lc_s_i_cursor_position]=i_cursor_position

               i_stack_length=ht_out[@lc_s_i_stack_length].to_i
               ht_out[@lc_s_i_stack_length]=i_stack_length

               fd_timestamp=ht_out[@lc_s_fd_timestamp].to_f
               ht_out[@lc_s_fd_timestamp]=fd_timestamp
               b_init_new_ht_db=false
            end # if
         end # if
      end # if
      if b_init_new_ht_db
         ht_out=Hash.new
         ht_out[@lc_s_errstack_ctime]="<file not scanned yet>"+
         Kibuvits_GUID_generator.generate_GUID # to force rescanning
         ht_out[lc_s_db_format_version]=s_db_format_version
         ht_out[@lc_s_i_cursor_position]=0.to_s
         ht_stack=Hash.new
         ht_searchhints=Hash.new
         ht_out[@lc_s_i_stack_length]=0
         ht_out[@lc_s_fd_timestamp]=Time.new(1991).to_f
         if s_config_ht_hash==nil
            s_config_ht_hash=C_mmmv_devel_tools_global_singleton.s_config_hash_t1()
         end # if
         ht_out[@lc_s_config_hash]=s_config_ht_hash
      end # if
      ht_out[@lc_s_ht_stack]=ht_stack
      ht_out[@lc_s_ht_searchhints]=ht_searchhints
      return ht_out
   end # ht_load_copy_of_ht_db

   public

   def initialize
      # The implementation assumes that all public
      # methods use the @mx. All private methods of this class
      # are designed for a single-threaded application.
      @mx=Mutex.new

      @lc_s_GUID="GUID_".freeze
      @lc_s_file_path="s_file_path_".freeze
      @lc_si_line_number="si_line_number_".freeze
      @lc_s_sb_location_avaliable="sb_location_avaliable_".freeze
      @lc_s_errstack_ctime="s_errstack_ctime".freeze
      @lc_s_i_cursor_position="i_cursor_position".freeze
      @lc_s_i_stack_length="i_stack_length".freeze
      @lc_s_ht_stack="ht_stack".freeze
      @lc_s_ht_searchhints="ht_searchhints".freeze
      @lc_s_fd_timestamp="fd_timestamp".freeze
      @lc_s_config_hash="s_config_hash".freeze

      @msgcs=C_mmmv_devel_tools_global_singleton.msgcs()
      @ht_mmmv_devel_tools_config=C_mmmv_devel_tools_global_singleton.ht_global_configuration
      s_key="s_GUID_trace_errorstack_file_path"
      @s_fp_errstack=@ht_mmmv_devel_tools_config[s_key].gsub(
      /[\s\n\r]/,$kibuvits_lc_emptystring)

      # The ht_load_copy_of_ht_db(...) adds additional
      # limitations to the ht_searchhints.
      @i_max_number_of_searchhints=100

      @s_fp_db=MMMV_DEVEL_TOOLS_HOME+"/src/bonnet/tmp/JumpGUID_core_db.txt"
      @s_fp_msgfile=MMMV_DEVEL_TOOLS_HOME+"/src/bonnet/tmp/JumpGUID_core_msgfile.txt"
      @ht_db=ht_load_copy_of_ht_db(@s_fp_db)
   end # initialize

   private

   #-----------------------------------------------------------------------

   def ar_assemble_list_of_source_files
      ar_0=@ht_mmmv_devel_tools_config["ar_GUID_trace_project_source_folder_paths"]+
      @ht_mmmv_devel_tools_config["ar_GUID_trace_project_dependencies_source_folder_paths"]
      ar_folders=Array.new
      ar_files=Array.new
      ar_0.each do |x_fp_file_or_folder|
         next if !File.exists? x_fp_file_or_folder
         if File.directory? x_fp_file_or_folder
            ar_folders << x_fp_file_or_folder
         else
            ar_files << x_fp_file_or_folder
         end # if
      end # loop
      ar_fn_globs=@ht_mmmv_devel_tools_config["ar_GUID_trace_file_name_glob_patterns_according_to_Ruby_stdlib_class_Dir_method_glob"]
      b_return_long_paths=true
      ar_out=Kibuvits_fs.ar_glob_recursively_t1(ar_folders,
      ar_fn_globs, b_return_long_paths)
      ar_out.concat(ar_files)
      return ar_out
   end # ar_assemble_list_of_source_files

   def s_get_grep_output(s_searchstring, ar_or_s_fp=nil)
      if KIBUVITS_b_DEBUG
         bn=binding()
         kibuvits_typecheck bn, String, s_searchstring
         kibuvits_typecheck bn, [NilClass,String,Array], ar_or_s_fp
         if ar_or_s_fp.class==Array
            kibuvits_typecheck_ar_content(bn,String,ar_or_s_fp)
         end # if
      end # if
      ar_fp=nil
      if ar_or_s_fp.class==NilClass
         ar_fp=ar_assemble_list_of_source_files()
      else
         ar_fp=Kibuvits_ix.normalize2array(ar_or_s_fp)
      end # if
      ar_s=Array.new
      ar_s<<("grep -F -H -n "+s_searchstring+$kibuvits_lc_space)
      ar_fp.each do |s_fp|
         ar_s<<(s_fp+$kibuvits_lc_space)
      end # loop
      ar_s<<(" ;")
      cmd=kibuvits_s_concat_array_of_strings(ar_s)
      ht_stdstreams=sh(cmd)
      s_stdout=ht_stdstreams[$kibuvits_lc_s_stdout]
      s_stderr=ht_stdstreams[$kibuvits_lc_s_stderr]
      return s_stdout
   end # s_get_grep_output

   #-----------------------------------------------------------------------

   def save_ht_db
      ht_stack=@ht_db[@lc_s_ht_stack]
      s_progfte=Kibuvits_ProgFTE.from_ht(ht_stack)
      @ht_db[@lc_s_ht_stack]=s_progfte

      # The i_stack_length!=ht_stack.size, because the
      # number of keys per stack element can vary and there
      # are more than one key per every stack element.
      i_stack_length=@ht_db[@lc_s_i_stack_length]
      @ht_db[@lc_s_i_stack_length]=i_stack_length.to_s

      i_cursor_position=@ht_db[@lc_s_i_cursor_position]
      @ht_db[@lc_s_i_cursor_position]=i_cursor_position.to_s

      ht_searchhints=@ht_db[@lc_s_ht_searchhints]
      if @i_max_number_of_searchhints<=ht_searchhints.size
         ht_searchhints.clear
      end # if
      s_progfte=Kibuvits_ProgFTE.from_ht(ht_searchhints)
      @ht_db[@lc_s_ht_searchhints]=s_progfte

      fd_timestamp_old=@ht_db[@lc_s_fd_timestamp]
      @ht_db[@lc_s_fd_timestamp]=Time.now.to_f.to_s

      s_config_hash_old=@ht_db[@lc_s_config_hash]
      @ht_db[@lc_s_config_hash]=C_mmmv_devel_tools_global_singleton.s_config_hash_t1()

      s_progfte=Kibuvits_ProgFTE.from_ht(@ht_db)
      str2file(s_progfte,@s_fp_db)
      # Restore the value types:
      @ht_db[@lc_s_ht_stack]=ht_stack
      @ht_db[@lc_s_i_stack_length]=i_stack_length
      @ht_db[@lc_s_i_cursor_position]=i_cursor_position
      @ht_db[@lc_s_ht_searchhints]=ht_searchhints
      @ht_db[@lc_s_fd_timestamp]=fd_timestamp_old
      @ht_db[@lc_s_config_hash]=s_config_hash_old
   end # save_ht_db

   # Untested
   def remove_from_stack_by_index(ix)
      ht_stack=@ht_db[@lc_s_ht_stack]
      s_ix=ix.to_s
      s_key_loc=@lc_s_sb_location_avaliable+s_ix
      return if !ht_stack.has_key? s_key_loc
      #-------------------
      ht_stack.delete(s_key_loc)
      ht_stack.delete(@lc_s_GUID+s_ix)
      ht_stack.delete(@lc_s_file_path+s_ix)
      ht_stack.delete(@lc_si_line_number+s_ix)
      #-------------------
      i_cursor_position=@ht_db[@lc_s_i_cursor_position]
      @ht_db[@lc_s_i_cursor_position]=0 if i_cursor_position==ix
      i_stack_length_new=@ht_db[@lc_s_i_stack_length]-1
      @ht_db[@lc_s_i_stack_length]=i_stack_length_new
   end # remove_from_stack_by_index

   # TODO: handle collision on disk.
   def scan_stack_if_stack_changed(s_core_cmd)
      if !File.exists? @s_fp_errstack
         str2file($kibuvits_lc_emptystring,@s_fp_errstack)
      end # if
      ht_stack=@ht_db[@lc_s_ht_stack]
      if s_core_cmd=="testmode_1"
         ht_stack.clear
         s_0=@lc_s_sb_location_avaliable+0.to_s
         ht_stack[s_0]=$kibuvits_lc_sb_false
         s_0=@lc_s_GUID+0.to_s
         ht_stack[s_0]=@x_testarg_1
         @ht_db[@lc_s_i_stack_length]=1
         @ht_db[@lc_s_i_cursor_position]=0
         return
      end # if
      s_ctime_db=@ht_db[@lc_s_errstack_ctime]
      s_ctime_disc=File.ctime(@s_fp_errstack)
      return if s_ctime_disc==s_ctime_db
      # Actually, there's a flaw: ctime gets changed
      # even if the file content does not get changed.
      # In that case it is necessary to retain the
      # cursor position and possible location
      # information in the stack.
      #ht_stack.clear
      ht_new_stack_candidate=Hash.new
      rgx_0=/.{8}[-].{4}[-].{4}[-].{4}[-].{12}/
      s_errstack=file2str(@s_fp_errstack)
      ar_GUIDS=s_errstack.scan(rgx_0)
      lc_s_GUIDsHash="s_GUIDsHash".freeze
      s_GUIDsHash_new=kibuvits_s_concat_array_of_strings(ar_GUIDS)
      s_GUIDsHash_old=ht_stack[lc_s_GUIDsHash]
      if s_GUIDsHash_new!=s_GUIDsHash_old
         ht_stack.clear
         ht_stack[lc_s_GUIDsHash]=s_GUIDsHash_new
         s_0=nil
         s_1=nil
         s_2=nil
         i_n=ar_GUIDS.size
         s_GUID_previous=$kibuvits_lc_emptystring
         s_GUID=nil
         ii=0
         i_n.times do |i|
            s_1=i.to_s
            s_GUID=ar_GUIDS[i]
            if s_GUID!=s_GUID_previous
               s_2=ii.to_s
               ht_stack[(@lc_s_GUID+s_2)]=s_GUID
               ht_stack[(@lc_s_sb_location_avaliable+s_2)]=$kibuvits_lc_sb_false;
               ii=ii+1
            end # if
            s_GUID_previous=s_GUID
         end # loop
         @ht_db[@lc_s_ht_stack]=ht_stack
         @ht_db[@lc_s_i_stack_length]=ii
         @ht_db[@lc_s_i_cursor_position]=ii-1
      end # if
   end # scan_stack_if_stack_changed

   #--------------------------------------------------------------------------

   #
   # Sample of a single line of the grep output:
   #
   # /home/cute/x.js:1036:	'1822e023-b96e-46e5-a4cf-029021f13dd7');
   #
   def update_location_record_t1_process_grep_output_line(
      ht_stack,s_line,rgx_1,rgx_2,s_errix,s_lc_locavail)
      ix=s_line.index(rgx_1)
      if ix==nil # It's OK for the search string to be missing.
         ht_stack[s_lc_locavail]=$kibuvits_lc_sb_false # just in case
         return
      end # if
      if ix==0 # contradictory situation, flawed grep output
         kibuvits_throw("\nix==0 s_line==\""+s_line+"\"\n"+
         "GUID='63e1e827-b1fa-4b87-94cf-029021f13dd7'\n")
      end # if
      s_fp=s_line[0..(ix-1)]
      ht_stack[@lc_s_file_path+s_errix]=s_fp
      md=s_line.match(rgx_2)
      if md==nil
         kibuvits_throw("\nmd==nil\n"+
         "GUID='a1a207ff-6f3f-44ae-a7cf-029021f13dd7'\n")
      end # if
      s_0=md[0] # like ":1036:"
      if s_0.length<=2
         kibuvits_throw("\ns_0==\""+s_0+"\"\n"+
         "GUID='2f9520d4-308e-4f9c-92bf-029021f13dd7'\n")
      end # if
      si_line_number=s_0[1..(-2)]
      ht_stack[@lc_si_line_number+s_errix]=si_line_number
      ht_stack[s_lc_locavail]=$kibuvits_lc_sb_true
   end # update_location_record_t1_process_grep_output_line

   def update_location_record_t1_search_location_info(
      ht_stack,rgx_1,rgx_2,s_errix,s_lc_locavail,s_GUID,s_fp_hint_or_nil)
      #
      # Sample of a single line of the grep output:
      #
      # /home/cute/x.js:1036:	'77f8cf17-d3e1-4000-b3bf-029021f13dd7');
      #
      s_grep_output=s_get_grep_output(s_GUID,s_fp_hint_or_nil)
      s_grep_output.each_line do |s_line|
         update_location_record_t1_process_grep_output_line(
         ht_stack,s_line,rgx_1,rgx_2,s_errix,s_lc_locavail)
         break if ht_stack[s_lc_locavail]==$kibuvits_lc_sb_true
      end # loop
   end # update_location_record_t1_search_location_info


   def update_location_record_t1(ar_argv)
      if KIBUVITS_b_DEBUG
         bn=binding()
         kibuvits_typecheck bn, Array, ar_argv
      end # if
      i_len=ar_argv.size
      if i_len<2
         kibuvits_throw("\nar_argv.size=="+i_len.to_s+
         "\nGUID='35c2cc54-5eec-4565-83bf-029021f13dd7'\n")
      end # if
      i_cursor_position=@ht_db[@lc_s_i_cursor_position]
      i_stack_length=@ht_db[@lc_s_i_stack_length]
      if i_stack_length==0
         kibuvits_throw("\ni_stack_length==0 \n"+
         "GUID='6b341d2f-4063-44f0-a5bf-029021f13dd7'\n")
      end # if
      if i_cursor_position<0
         kibuvits_throw("\ni_cursor_position=="+i_cursor_position.to_s+
         " < 0 \nGUID='4466fa4b-01d1-4790-a2bf-029021f13dd7'\n")
      end # if
      ix_max=i_stack_length-1
      if ix_max<i_cursor_position
         kibuvits_throw("\n(i_stack_length-1) == "+ix_max.to_s+
         " < i_cursor_position=="+i_cursor_position.to_s+
         " \nGUID='e592ec4f-9267-44ae-93bf-029021f13dd7'\n")
      end # if
      ht_stack=@ht_db[@lc_s_ht_stack]
      s_errix=i_cursor_position.to_s
      s_lc_locavail=@lc_s_sb_location_avaliable+s_errix
      #---------------------------------------------
      # Location data (file path and line number)
      # can not be reused between different runs
      # of the core, unless the query is for a
      # line number without cursor position change.
      # The reason, why the location data can not be
      # reused is that the file, where the GUID
      # existed, might heve been updated between
      # calls to the jumpguid_core.rb. The GUID
      # might heve been overwritten by UpGUID or
      # the code region with the GUID or the whole
      # file might have been removed.
      s_core_cmd=ar_argv[0]
      s_cursor_movement=ar_argv[1]
      if (s_core_cmd=="get_line_number")&&(s_cursor_movement=="no_cursor_movement")
         # This hack here can still provide flawed
         # results, but the alternative would be to
         # conduct the search and files can be edited
         # right after the end of search and before the
         # use of the search results. This solution here is not
         # that fault-tolerant, but the alternative would
         # probably involve locking and tighter
         # integration with IDE-s, which is currently
         # outside the scope of the JumpGUID project.
         fd_timestamp_last=@ht_db[@lc_s_fd_timestamp]
         fd_timestamp_now=Time.now.to_f
         if (fd_timestamp_now-fd_timestamp_last)<3 # seconds
            sb_location_avaliable=ht_stack[s_lc_locavail]
            return if sb_location_avaliable==$kibuvits_lc_sb_true
         end # if
      end # if
      ht_stack[s_lc_locavail]=$kibuvits_lc_sb_false
      #---------------------------------------------
      s_lc_2=@lc_s_GUID+s_errix
      s_GUID=ht_stack[s_lc_2]
      ht_searchhints=@ht_db[@lc_s_ht_searchhints]
      rgx_1=/[:][\d]+[:][\t\s]+/ # here only for instance reuse
      rgx_2=/[:][\d]+[:]/
      s_fp_hint=nil
      if ht_searchhints.has_key? s_GUID
         s_fp_hint=ht_searchhints[s_GUID]
         update_location_record_t1_search_location_info(
         ht_stack,rgx_1,rgx_2,s_errix,s_lc_locavail,s_GUID,s_fp_hint)
         sb_location_avaliable=ht_stack[s_lc_locavail]
         return if sb_location_avaliable==$kibuvits_lc_sb_true
         ht_searchhints.delete(s_GUID) # remove flawed hint
         s_fp_hint=nil
      end # if
      update_location_record_t1_search_location_info(
      ht_stack,rgx_1,rgx_2,s_errix,s_lc_locavail,s_GUID,s_fp_hint)
      sb_location_avaliable=ht_stack[s_lc_locavail]
      if sb_location_avaliable==$kibuvits_lc_sb_true
         s_0=@lc_s_file_path+s_errix
         ht_searchhints[s_GUID]=ht_stack[s_0]
      end # if
   end # update_location_record_t1

   #--------------------------------------------------------------------------
   def move_cursor_if_necessary(ar_argv)
      bn=binding()
      #s_core_cmd=ar_argv[0]
      s_cursor_movement=ar_argv[1]
      ar_valid_cursor_movement_values=["up","down","no_cursor_movement"]
      kibuvits_assert_is_among_values(bn,ar_valid_cursor_movement_values,
      s_cursor_movement)
      i_stack_length=@ht_db[@lc_s_i_stack_length]
      i_cursor_position=@ht_db[@lc_s_i_cursor_position]
      i_cursor_position_max=0
      i_cursor_position_max=i_stack_length-1 if 0<i_stack_length
      i_cursor_position_new=i_cursor_position
      case s_cursor_movement
      when "up"
         if 0<i_cursor_position
            i_cursor_position_new=i_cursor_position-1
         end # if
      when "down"
         if i_cursor_position<i_cursor_position_max
            i_cursor_position_new=i_cursor_position+1
         end # if
      when "no_cursor_movement"
         i_cursor_position_new=i_cursor_position
      else
         kibuvits_throw("\ns_cursor_movement==\""+s_cursor_movement+
         "\", is not yet supported by this function.\n"+
         "GUID='2b98dfb5-5401-48ad-82bf-029021f13dd7'\n")
      end # case s_cursor_movement
      @ht_db[@lc_s_i_cursor_position]=i_cursor_position_new
   end # move_cursor_if_necessary

   #--------------------------------------------------------------------------
   def s_core_cmd_get_line_number(ar_argv)
      bn=binding()
      s_out=nil
      ht_stack=@ht_db[@lc_s_ht_stack]
      i_cursor_position=@ht_db[@lc_s_i_cursor_position]
      i_stack_length=@ht_db[@lc_s_i_stack_length]
      if i_stack_length==0
         s_out="1";
         return s_out
      end # if
      update_location_record_t1(ar_argv)
      s_errix=i_cursor_position.to_s
      s_0=@lc_s_sb_location_avaliable+s_errix
      kibuvits_assert_ht_has_keys(bn,ht_stack,s_0,
      "GUID='26d4f542-aa48-4dc6-a3bf-029021f13dd7'\n\n")
      if ht_stack[s_0]==$kibuvits_lc_sb_false
         s_out="1";
         return s_out
      end # if
      s_0=@lc_si_line_number+s_errix
      kibuvits_assert_ht_has_keys(bn,ht_stack,s_0,
      "GUID='5215b556-d24b-49a1-b4bf-029021f13dd7'\n\n")
      s_out=ht_stack[s_0]
      return s_out
   end # s_core_cmd_get_line_number

   def s_core_cmd_get_file_path(ar_argv)
      bn=binding()
      s_out=@s_fp_msgfile
      ht_stack=@ht_db[@lc_s_ht_stack]
      i_cursor_position=@ht_db[@lc_s_i_cursor_position]
      i_stack_length=@ht_db[@lc_s_i_stack_length]
      if i_stack_length==0
         msg="\nThe stack of GUIDs is empty.\n\n"
         str2file(msg,@s_fp_msgfile)
         return s_out
      end # if
      update_location_record_t1(ar_argv)
      s_errix=i_cursor_position.to_s
      s_0=@lc_s_sb_location_avaliable+s_errix
      kibuvits_assert_ht_has_keys(bn,ht_stack,s_0,
      "GUID='6a20f226-6e30-481c-a2bf-029021f13dd7'\n\n")
      if ht_stack[s_0]==$kibuvits_lc_sb_false
         s_0=@lc_s_GUID+s_errix
         kibuvits_assert_ht_has_keys(bn,ht_stack,s_0,
         "GUID='38f48c23-eea4-46c9-b4af-029021f13dd7'\n\n")
         s_GUID=ht_stack[s_0]
         msg="\n"+s_GUID+"\ncould not be found.\n\n"+
         C_mmmv_devel_tools_global_singleton.s_configuration_summary()
         str2file(msg,@s_fp_msgfile)
         return s_out
      end # if
      s_0=@lc_s_file_path+s_errix
      kibuvits_assert_ht_has_keys(bn,ht_stack,s_0,
      "GUID='3b3ef2c1-761e-4601-95af-029021f13dd7'\n\n")
      s_out=ht_stack[s_0]
      return s_out
   end # s_core_cmd_get_file_path

   #--------------------------------------------------------------------------

   def act_core_cmd_testmode_t1(ar_argv)
      s_searchstring=ar_argv[1]
      s_grep_output=s_get_grep_output(s_searchstring)
      s_out="\n\n-------- testmode_1 output START -----------------------------\n"+
      s_grep_output+
      "\n-------- testmode_1 output END -------------------------------\n\n"
      puts s_out
   end # act_core_cmd_testmode_t1

   def act_core_cmd_ls(ar_argv)
      s_out=$kibuvits_lc_emptystring
      s_ls_param=ar_argv[1]
      case s_ls_param
      when "config"
         s_out="\n\n-------- ls config output START -----------------------------\n"+
         C_mmmv_devel_tools_global_singleton.s_configuration_summary()+
         "JumpGUID db txtfile path ==\n"+"     "+@s_fp_db+"\n"+
         "\n-------- ls config output END -------------------------------\n\n"
      when "guidstack_file_path"
         print @s_fp_errstack
      when "si_cursor_position"
         i_cursor_position=@ht_db[@lc_s_i_cursor_position]
         print i_cursor_position.to_s
      else
         kibuvits_throw("\n\n"+s_assemble_format_desc_msg()+
         "GUID='35632c05-3697-4412-baaf-029021f13dd7'\n\n")
      end # case s_ls_param
      puts s_out
   end # act_core_cmd_ls

   #--------------------------------------------------------------------------

   def s_assemble_format_desc_msg
      s_out="\n\n"+
      "<Command>           ::= GET_FILE_PARAMS | TESTMODE_1 | LS \n"+
      "GET_FILE_PARAMS     ::= (get_file_path | get_line_number) CURSOR_MOVEMENT_CMD\n"+
      "CURSOR_MOVEMENT_CMD ::= up | down | no_cursor_movement \n"+
      "TESTMODE_1          ::= testmode_1 <searchstring>\n"+
      "LS                  ::= ls LS_PARAM \n"+
      "LS_PARAM            ::= config | guidstack_file_path | si_cursor_position\n\n"
      return s_out
   end # s_assemble_format_desc_msg

   public

   #-----------------------------------------------------------------------
   #                Shell Commands that IDE Drivers use
   #-----------------------------------------------------------------------
   #
   #  jumpguid_core  get_file_path up
   #                               down
   #                               no_cursor_movement
   #
   #
   #  jumpguid_core  get_line_number up
   #                                 down
   #                                 no_cursor_movement
   #
   #-----------------------------------------------------------------------
   def s_run(ar_argv)
      s_out=$kibuvits_lc_emptystring
      i_len=ar_argv.size
      if i_len!=2
         kibuvits_throw("\n\nar_argv.size==\""+i_len.to_s+
         s_assemble_format_desc_msg+
         "GUID='36440639-4d0e-4147-b2af-029021f13dd7'\n\n")
      end
      s_core_cmd=ar_argv[0]
      s_out=$kibuvits_lc_emptystring
      @mx.synchronize do
         case s_core_cmd
         when "get_file_path"
            scan_stack_if_stack_changed(s_core_cmd)
            move_cursor_if_necessary(ar_argv)
            s_out=s_core_cmd_get_file_path(ar_argv)
         when "get_line_number"
            scan_stack_if_stack_changed(s_core_cmd)
            move_cursor_if_necessary(ar_argv)
            s_out=s_core_cmd_get_line_number(ar_argv)
         when "testmode_1"
            s_out=act_core_cmd_testmode_t1(ar_argv)
         when "ls"
            s_out=act_core_cmd_ls(ar_argv)
         else
            kibuvits_throw("\n\ns_core_cmd==\""+s_core_cmd+
            "\", is not yet supported by this function.\n"+
            "GUID='94af9b7f-b2c2-42f8-b9af-029021f13dd7'\n\n")
         end # case s_core_cmd
         save_ht_db()
      end # synchronize
      return s_out;
   end # s_run

end # class JumpGUID_core
#--------------------------------------------------------------------------
if 0<ARGV.size
   ob_core=JumpGUID_core.new
   s_out=ob_core.s_run(ARGV)
   print(s_out)
end # if

#==========================================================================

