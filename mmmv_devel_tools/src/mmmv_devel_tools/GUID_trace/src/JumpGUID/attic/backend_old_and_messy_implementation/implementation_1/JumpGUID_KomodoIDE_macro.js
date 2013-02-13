/*-----------------------------------------------------------------------
Copyright (c), martin.vahi@eesti.ee that has an
Estonian national identification number of 38108050020.
This file is under the BSD license,
http://www.opensource.org/licenses/bsd-license.php
------------------------------------------------------------------------*/
komodo.assertMacroVersion(2);
/*----------------------------------------------------------------------*/
guidtrace = {};
guidtrace.setup = {};
ar_project_folder_paths = [];
/*--------------- SETUP START ------------------------------------------*/
/*Possible values: "decrease_cursor", "current_cursor", "increase_cursor"*/
guidtrace.setup.stack_of_GUIDS_cursor_movement = "decrease_cursor";
guidtrace.setup.JumpGUID_home_path = "/home/me/JumpGUID/src/implementation_1";
guidtrace.setup.wild_text_file_path = "/home/zornilemma/tmp/wild.txt";

ar_project_folder_paths.push("/home/nice/projectfolder/one");
ar_project_folder_paths.push("/home/nicer/proejctfolder/second");


/*--------------- SETUP END, LIBRARY CODE START ------------------------*/

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
/*----------------------------------------------------------------------*/
/* The following is just stuff that has been CopyPasted from one
other, tested, library.*/
if (window.raudrohi_exists !== true) {
    window.raudrohi = {};
    window.raudrohi_exists = true;
} // if
if (window.raudrohi_core_exists !== true) {
    window.raudrohi.core = {};
    window.raudrohi_core_exists = true;
} // if
if (window.raudrohi_base_exists !== true) {
    window.raudrohi.base = {};
    window.raudrohi_base_exists = true;
} // if
raudrohi.tmg = function(GUID, err) {
    /// The raudrohi.tmg will be overridden in the raudrohi_adapter_v1.js
    var msg = "\n\r------------------------\n\rGUID==\"" + GUID + "\"\n\r" + err;
    throw msg;
}; // raudrohi.tmg
raudrohi.core.pair = function() {
    this.a = null;
    this.b = null;
}; // raudrohi.core.pair
/*----------------------------------------------------------------------*/
/// Returns null, if the needle_string does not exist within the
/// haystack_string. Otherwise returns a raudrohi.core.pair instance that
/// consists of 2 strings: the part before the first occurrence of the
/// needle_string and the part after the first occurrence of the needle string.
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
    // Just for reference:
    // IE8 and Firefox:    ''.indexOf('')==0;
    // IE8 and Firefox:    ''.indexOf('x')==(-1);
    // IE8 and Firefox:    'x'.indexOf('')==0;
    // IE8 and Firefox:    'x'.indexOf('',7)==1;
    // IE8 and Firefox:    ''.indexOf('',7)==0;
    var ix = haystack_string.indexOf(needle_string);
    if (ix == ( - 1)) {
        return null;
    } // if
    var answer = new raudrohi.core.pair();
    var len_n = needle_string.length;
    var len_h = haystack_string.length;
    if (len_n == 0) {
        if (len_h == 0) {
            return null;
        } // if
        answer.a = '';
        answer.b = haystack_string;
        return answer;
    } // if
    if (ix == 0) {
        answer.a = '';
    } else {
        answer.a = haystack_string.substr(0, ix);
    } // else
    ix += needle_string.length;
    if (ix == len_h) {
        answer.b = '';
    } else {
        answer.b = haystack_string.substr(ix, len_h);
    } // else
    return answer;
}; // raudrohi.base.bisect
/// Applies the raudrohi.base.bisect n times and returns
/// an array of the prefix sides of the bisections. If it is
/// not possible to bisect the string n times, an exception is thrown.
raudrohi.base.snatchNtimes = function(haystack_string, needle_string, n) {
    try {
        if (n < 1) {
            throw 'n==' + n + '<1';
        } // if
        var modulus = n % 2;
        var a_pair;
        var a_pair1;
        var s_hay = haystack_string;
        var ar = [];
        if (2 <= n) {
            var nn = n;
            if (modulus == 1) {
                nn = nn - 1;
            } // if
            var nnn = nn / 2;
            var i = 0;
            for (i = 0; i < nnn; i++) {
                a_pair = raudrohi.base.bisect(s_hay, needle_string);
                if (a_pair == null) {
                    raudrohi.tmg('4bf0adf3-aad0-439f-3862-cf9835972fed', 'a_pair==null ' + 'haystack_string==' + haystack_string + 'needle_string==' + needle_string + ' n==' + n + ' ');
                } // if
                ar.push(a_pair.a);
                a_pair1 = raudrohi.base.bisect(a_pair.b, needle_string);
                if (a_pair1 == null) {
                    raudrohi.tmg('4bf0adf3-160e-41b5-fb32-51f17150e289', 'a_pair1==null ' + 'haystack_string==' + haystack_string + 'needle_string==' + needle_string + ' n==' + n + ' ');
                } // if
                ar.push(a_pair1.a);
                s_hay = a_pair1.b;
            } // for
        } // if
        if (modulus == 1) {
            a_pair = raudrohi.base.bisect(s_hay, needle_string);
            if (a_pair == null) {
                raudrohi.tmg('4bf0adf3-70c6-4813-fb2f-38cb36f5dc34', 'a_pair==null ' + 'haystack_string==' + haystack_string + 'needle_string==' + needle_string + ' n==' + n + ' ');
            } // if
            ar.push(a_pair.a);
        } // if
        return ar;
    } catch(err) {
        raudrohi.tmg('4bf0adf3-7c3d-42bf-7c93-143f2499db8b', err);
    } // catch
} // raudrohi.base.snatchNtimes
/*--------------- SETUP VERIFICATION START -------------------------------*/
/* The main motivation for the setup verification is that if any of the */
/* paths is wrong, then it might take quite a while to figure that out here.*/
/* So, the setup verification aims to decrease the time that it takes to */
/* find out that the mistake is not within some mysterious code region, but */
/* just in the file path description. Unfortunately the time-saving that */
/* it provides, is quite substantial. */

function file_exists_sev(a_file_path_candidate) {
    var cmd = guidtrace.setup.JumpGUID_home_path + "/file_exists.rb " + a_file_path_candidate
    var s_console = guidtrace.sh(cmd);
    if (s_console.length === 0) {
        alert('It seems that the guidtrace.setup.JumpGUID_home_path is wrong.')
    } // if
    var b_file_exists = false;
    if (s_console === "file_exists_indeed") {
        b_file_exists = true;
    } // if
    return b_file_exists;
} // file_exists_sev
if (file_exists_sev(guidtrace.setup.wild_text_file_path) === false) {
    alert("Path that is assigned to the \nguidtrace.setup.wild_text_file_path==\n" + guidtrace.setup.wild_text_file_path + "\ndoes not exist.");
    throw "We exited the JavaScript intentionally 1.";
} // if
var i_max = ar_project_folder_paths.length - 1
if (i_max < 0) {
    alert("Search paths are missing from the ar_project_folder_paths.");
    throw "We exited the JavaScript intentionally 2.";
} // if
var i = 0;
var s_path_candidate = "";
while (i <= i_max) {
    s_path_candidate = ar_project_folder_paths[i];
    i++;
    if (file_exists_sev(s_path_candidate) === false) {
        alert("A file or folder path that is inserted into the \n ar_project_folder_paths ,\n" + s_path_candidate + "\n, does not exist. ");
        throw "We exited the JavaScript intentionally 3.";
    } // if
} // while
/*---------- THE APPLICATION CODE START---------------------------------*/

var fp_coords = guidtrace.setup.JumpGUID_home_path + "/../tmp_/coords.txt";
var fp_wild_text = guidtrace.setup.wild_text_file_path;
var fp_rubyscript = guidtrace.setup.JumpGUID_home_path + "/wild_text_2_GUID_coordinates.rb";

var cm_cd2fp_rubyscript = " cd " + guidtrace.setup.JumpGUID_home_path + " ; ";
var cm_update_coords = cm_cd2fp_rubyscript + fp_rubyscript + " wild_text_2_guids " + fp_coords + " " + fp_wild_text + " ; ";
guidtrace.sh(cm_update_coords);

var b_search_on = true;
var b_location_found = false;
var uri = "";
while (b_search_on === true) {
    var fp_project = ar_project_folder_paths.pop();
    if (ar_project_folder_paths.length <= 0) {
        b_search_on = false;
    } // if
    var move_command = guidtrace.setup.stack_of_GUIDS_cursor_movement
    var cm_move = cm_cd2fp_rubyscript + fp_rubyscript + " " + move_command + " " + fp_coords + " " + fp_project + " ; ";

    var coordstring = guidtrace.sh(cm_move);
    var ar = raudrohi.base.snatchNtimes(coordstring, "|", 2);
    uri = ar[1];
    if (ar[0] == "coordinate_found") {
        b_location_found = true;
        b_search_on = false;
    } // if
} // while
if (b_location_found === true) {
    ko.open.URI(uri);
} else {
    alert("Recursive search did not find\nthe " + uri + " from the project folder.  ");
} // if
/*
ko.commands.doCommand(cmd_findInFiles);
ko.open.URI(uri_string#line_number)
*/
