/*-----------------------------------------------------------------------
Copyright (c), martin.vahi@softf1.com that has an
Estonian national identification number of 38108050020.
This file is under the BSD license,
http://www.opensource.org/licenses/bsd-license.php

Also, this file is a mess and it's Linux/BSD specific,
but it works. It's written for KomodoIDE 6.
It depends on environment variables MMMV_DEVEL_TOOLS_HOME
and HOME.

------------------------------------------------------------------------*/
komodo.assertMacroVersion(3);
/*----------------------------------------------------------------------*/
var guidtrace={};
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
guidtrace.trim = function(s_in) { return s_in.replace(/^\s+|\s+$/g, ''); }
var s_home=guidtrace.trim(guidtrace.sh('echo "$HOME";'));
/*----------------------------------------------------------------------*/
// Run renessaator.
if (komodo.view) {
    komodo.view.setFocus();
} else {
    alert("The Renessaator KomodoIDE plugin\n" + "requires that the text editor \n" + "has the focus.");
    exit;
}
kdoc_current = ko.views.manager.currentView.koDoc;
editor = ko.views.manager.currentView.scimoz;
s_file_path_as_URI = kdoc_current.file.URI;

i_pos = editor.currentPos;
i_cursor_column = editor.getColumn(i_pos); // starts form 0
i_cursor_line = editor.lineFromPosition(i_pos); // starts from 0
//alert(i_cursor_line);
// file:///blabla -> /blabla
s_file_path = s_file_path_as_URI.substring(7);

if (kdoc_current.isDirty) {

} // if
//----------just-some-dirty-Copy-Paste-----START------------------------------
raudrohi = {}
raudrohi.base = {}
raudrohi.core = {}

raudrohi.core.pair = function() {
    this.a = null;
    this.b = null;
}; // raudrohi.core.pair
/// Returns null, if the needle_string does not exist within the
/// haystack_string or the needle_string=="" or the haystack_string==0.
/// Otherwise returns a raudrohi.core.pair instance that
/// consists of 2 strings:
/// the part before the first occurrence of the needle_string and
/// the part after the first occurrence of the needle string.
/// Example # 1:
///         haystack_string=='hi|||there|||everybody'
///         needle_string=='|||'
///         answer.a=='hi'     answer.b=='there|||everybody'
///
/// Example # 2:
///         haystack_string=='welcome|||'
///         needle_string=='|||'
///         answer.a=='welcome'     answer.b==''
raudrohi.base.bisect = function(haystack_string, needle_string) {
    try {
        var len_n = needle_string.length;
        var ix = haystack_string.indexOf(needle_string);
        if ((ix === ( - 1)) || (len_n === 0)) {
            // Covers also the case, where  len_h < len_n
            return null;
        } // if
        var len_h = haystack_string.length;
        if (len_h === 0) {
            return null;
        } // if
        var answer = new raudrohi.core.pair();
        var cache_func_hss = haystack_string.substr; // Function lookup optimization.
        if (ix === 0) {
            answer.a = '';
            if (len_n === len_h) {
                answer.b = '';
            } else {
                answer.b = cache_func_hss(ix, len_h);
            } // else
        } // if
        //answer.a=cache_func_hss(0,ix);
        ix += len_n;
        if (ix === len_h) {
            answer.b = '';
        } else {
            answer.b = cache_func_hss(ix, len_h);
        } // else
        return answer;
    } catch(err) {
        raudrohi.tmg('7daa1714-161c-4993-744a-2b280f569030', err + '  haystack_string==' + haystack_string + '  needle_string==' + needle_string);
    } // catch
}; // raudrohi.base.bisect
//----------just-some-dirty-Copy-Paste-----END------------------------------
// It's Copy-Pasted from http://www.javascripter.net/faq/operatin.htm
// and slightly modified.
function get_OS_type() {
    var OSName = "Unknown OS";
    if (navigator.appVersion.indexOf("Win") != -1) OSName = "Windows";
    if (navigator.appVersion.indexOf("Mac") != -1) OSName = "unix";
    if (navigator.appVersion.indexOf("X11") != -1) OSName = "unix";
    if (navigator.appVersion.indexOf("Linux") != -1) OSName = "unix";
    return OSName;
} // get_OS_type
function generate_tmp_file_path(s_file_name) {
    var s_ostype = get_OS_type();
    s_out = "";
    if (s_ostype == "Windows") {
        s_out = "C:\\Temp\\" + s_file_name;
    }
    if (s_ostype == "unix") {
        s_out = "/tmp/" + s_file_name;
    }
    if (s_out == "") {
        throw "Unsupported operationg system type.\n" + "s_ostype==" + s_ostype;
    }
    return s_out
} // generate_tmp_file_path
function extract_failure_message(s_thrown_message) {
    s_ceremony = "RENESSAATOR_INPUT_VERIFICATION_FAILURE_MESSAGE_";
    p1 = raudrohi.base.bisect(s_thrown_message, s_ceremony + "START");
    p2 = raudrohi.base.bisect(p1.b, s_ceremony + "END");
    s_out = p2.a;
    return s_out;
} // extract_failure_message
s_file_path_2_err_dump = generate_tmp_file_path("renessaator_KomodoIDE6_plugin_tmpfile.txt");
ko.commands.doCommand("cmd_save");
// One has to "refresh"/"reopen" the file,
// because otherwise the modifications that the
// Renessaator made, are present at the text
// file, if looked with some other tools, for
// example, with vim, but the KomodoIDE still
// displays the old, unmodified, version of
// the file.
//
// The only way, how I (martin.vahi@eesti.ee) figured
// to do the refresh in JavaScript is by literally switching
// tabs. On the other hand, one wants to display the Renessaator
// failure messages, if something went wrong. So, this function
// is kind of 2 in one. The refresh feature needs a tab-switch,
// which happens to be useful. :-)
function reload_the_file_to_show_changes() {
    try {
        if (komodo.view) {
            komodo.view.setFocus();
        }
        komodo.doCommand("cmd_bufferClose");
        ko.open.URI(s_file_path_as_URI);
        //ko.open.URI(s_file_path_2_err_dump);
        //editor.gotoLine(i_cursor_line);
        //i_pos2 = editor.currentPos + i_cursor_column;
        //editor.gotoPos(i_pos2);
        //komodo.doCommand('cmd_refreshStatus');
    } catch(err) {
        // It might be that the line or column, where
        // the cursor was, got deleted.
        alert("Something went wrong. err==\n" + err);
        //alert("It seems that the line or column,\n" + "where the cursor was, got deleted. :-)\n" + "err==" + err);
    } // catch
} // reload_the_file_to_show_changes
ko.run.runEncodedCommand(window,
                         '$MMMV_DEVEL_TOOLS_HOME/'+
                         'src/mmmv_devel_tools/renessaator/src/renessaator '+
                         '--throw_on_input_verification_failures -f ' +
                         s_file_path + " > " +
                         s_file_path_2_err_dump, reload_the_file_to_show_changes);

if (komodo.view) {
    komodo.view.setFocus();
}