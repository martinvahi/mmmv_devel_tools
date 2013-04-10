/*----------------------------------------------------------
 Copyright (c), martin.vahi@softf1.com that has an
 Estonian national identification number of 38108050020.
 This file is under the BSD license,
 http://www.opensource.org/licenses/bsd-license.php
 ---------------------------------------------------------*/
// Settings that have to be set manually:

// Possible values: "no_cursor_movement","up","down"
// The "no_cursor_movement" can be seen as "cursor current position"
// The "up-most" position within the stack is at stack index 0,
// i.e. the very first GUID that got printed to console.
var s_stack_navigation_command="no_cursor_movement";

var s_full_path_to_jumpguid_core_bash_cript="";

//--everythin-below-this-line-is-part-of-IDE-driver-implementation--

komodo.assertMacroVersion(3);
//----------------------------------------------------------
guidtrace = {};
guidtrace.sh = function(command) {
	/* The following has been mostly copy-pasted from
	 http://community.activestate.com/forum-topic/executing-command-from-ex#comment-1118
	 */
	var cmd = command;
	var cwd = "";
	var env = "";
	var input = "";
	var o_output = new Object();
	var o_error = new Object();

	var _gRunSvc = Components.classes["@activestate.com/koRunService;1"].getService(Components.interfaces.koIRunService);
	var result = _gRunSvc.RunAndCaptureOutput(cmd, cwd, env, input, o_output, o_error);
	//alert("Output: " + o_output.value);
	return o_output.value;
} // guidtrace.sh
guidtrace.trim = function(s_in) { return s_in.replace(/^\s+|\s+$/g,''); }
//----------------------------------------------------------
var cmd=null;
var s_0=null;
var s_1=null;
s_full_path_to_jumpguid_core_bash_cript=guidtrace.trim(
	s_full_path_to_jumpguid_core_bash_cript);

//----------------------------------------------------------
// A hack to make life easier for those,
// who know, what they are doing:

if (s_full_path_to_jumpguid_core_bash_cript.length==0) {
	cmd="echo $MMMV_DEVEL_TOOLS_HOME";
        s_0=guidtrace.sh(cmd);
	if (2<s_0.length) {
		s_1=guidtrace.trim(s_0);
		s_full_path_to_jumpguid_core_bash_cript=s_1+
		"/src/mmmv_devel_tools/GUID_trace/src/JumpGUID"+
		"/src/core/jumpguid_core";
	} // if
} // if

//----------------------------------------------------------
// The "core" of this IDE driver.
//
// The core always returns a line number and a file path.
// If no results are found from project files then the
// core writes/overwrites a message to a temporary file
// and returns its path. The core gets the list of
// searchable folders from mmmv_devel_tools configuration
// file.
//
// Line numbering starts from 1, not 0.
// Every file, including empty ones have line 1. In case
// of empty files, the line 1 is "empty".

if (s_full_path_to_jumpguid_core_bash_cript.length==0) {
	alert("The KomodoEdit macro is either flawed or "+
	      "lacks essential configuration.");
	exit();
} // if

cmd=s_full_path_to_jumpguid_core_bash_cript+
" get_file_path "+ s_stack_navigation_command;
//alert(cmd);
s_0=guidtrace.sh(cmd);
s_fp=guidtrace.trim(s_0);

cmd=s_full_path_to_jumpguid_core_bash_cript+" get_line_number no_cursor_movement ";
s_0=guidtrace.sh(cmd);
si_line_number=guidtrace.trim(s_0);
//alert(si_line_number);

ko.open.URI("file://"+s_fp+"#"+si_line_number);

//==========================================================
