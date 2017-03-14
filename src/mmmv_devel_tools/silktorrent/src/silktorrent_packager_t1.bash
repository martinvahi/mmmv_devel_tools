#!/usr/bin/env bash
#==========================================================================
#
# The MIT license from the 
# http://www.opensource.org/licenses/mit-license.php
# 
# Copyright (c) 2016, Martin.Vahi@softf1.com that has an
# Estonian personal identification code of 38108050020.
#
# Permission is hereby granted, free of charge, to 
# any person obtaining a copy of this software and 
# associated documentation files (the "Software"), 
# to deal in the Software without restriction, including 
# without limitation the rights to use, copy, modify, merge, publish, 
# distribute, sublicense, and/or sell copies of the Software, and 
# to permit persons to whom the Software is furnished to do so, 
# subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included 
# in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, 
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF 
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. 
# IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY 
# CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, 
# TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE 
# SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
#
#--------------------------------------------------------------------------
# TODO: 
#     Due to the dumb re-initialization of the whole 
#     Ruby interpreter for every small string operation in this script,
#     the current version of this script is terribly slow.
#     It could be faster, if gawk/awk were used, but the 
#     gawk/awk has been intentionally thrown out, because the gawk and awk 
#     behave differently from each other. On BSD there tends to be only "awk",
#     while the Linux tends to have only the "gawk".
#     At some point most of this script must be re-written, reimplemented, 
#     in something more advanced than Bash. Most likely Ruby. 
#
#     The need for the rewrite comes mainly from the fact that 
#     the passing of string values as console parameters 
#     runs into the classical macro processing related problems. 
#     The slowness in the name of portability and correctness 
#     of this, first, reference implementation, 
#     can be tolerated for a while. The reason, why this script has been
#     written in Bash at first place is that at first the goal was to 
#     try to create something very "simple", something that
#     depends only on programs that are very likely available
#     on PATH, but as it turns out, the various tests and 
#     string processing and other operations require 
#     quite a lot of more advanced tools than the Bash is, so
#     the simplicity and short start-up time has been totally
#     lost and the current script bears a heavy penalty from 
#     the relatively huge number of operating system process start-ups,
#     including the relatively huge number of initializations of
#     the Ruby interpreter.   
#
#     The lesson to be learnt from this case is that 
#     because projects get far more complex than 
#     initially anticipated, more advanced programming languages 
#     should be preferred to less advanced programming languages 
#     from the very start of the project. The current case here
#     seems to be a more high level version of the microcontroller projects'
#     assembler versus C dilemma.
#
#
#==========================================================================
S_FP_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
S_FP_ORIG="`pwd`"
S_TIMESTAMP="`date +%Y`_`date +%m`_`date +%d`_T_`date +%H`h_`date +%M`min_`date +%S`s"

#--------------------------------------------------------------------------
# Semi-auto-stamps:

# RENESSAATOR_BLOCK_START
# RENESSAATOR_BLOCK_ID=block_15d8c335-b177-48d0-a3d6-12d261c031e7
# RENESSAATOR_SOURCE_LANGUAGE=Ruby
# RENESSAATOR_SOURCE_START
# #----------------------------------------------------------
# func_throw_t1=lambda do |s_in,s_guid_0|
# s_guid_1="01da8718-de97-44ce-a101-21b170e031e7"
# puts("\n")
# puts("echo \"\"")
# puts("echo \"Code generation script failed.\" \n")
# puts("echo \"GUID=='"+s_guid_1+"'\";  \n")
# puts("echo \"GUID=='"+s_guid_0+"'\";  \n")
# puts("echo \"\"")
# puts("exit 1 # exit with error \n")
# raise(Exception.new("\n\n s_in=="+s_in+"\n GUID=="+s_guid_0+"\n\n"))
# end # func_throw_t1
# #--------------
# # The problem is that neither the "uuid", nor the "uuidgen"
# # might be available on the PATH. The creation of the inital value of the
# # s_0 has been tested on both, Linux and BSD, but not with all shells.
# s_0=(`which uuidgen 2>/dev/null 1>/dev/null; echo $?`).to_s
# s_0=s_0.gsub(/[\n\s\r]/,"")
# s_guid_generation_program_name="#not_yet_set"
# #--------------
# func_assert_s_0_format_t1=lambda do |s_in|
# if (s_in!="0")&&(s_in!="1")
# s_guid_0="b4947c85-3148-4f0d-b101-21b170e031e7"
# func_throw_t1.call(s_in,s_guid_0)
# end # if
# end # func_assert_s_0_format_t1
# #--------------
# func_assert_s_0_format_t1.call(s_0)
# #--------------
# if s_0=="0"
# s_guid_generation_program_name="uuidgen"
# #----
# else
# #----
# s_0=(`which uuid 2>/dev/null 1>/dev/null; echo $?`).to_s
# s_0=s_0.gsub(/[\n\s\r]/,"")
# func_assert_s_0_format_t1.call(s_0)
# if s_0=="0"
# s_guid_generation_program_name="uuid"
# else
# s_guid_2="2f771037-9949-405b-9301-21b170e031e7"
# func_throw_t1.call(s_0,s_guid_2)
# end # if
# #-------------
# end # if
# #--------------
# # A test to find out, whether the GUID generation program
# # on the PATH exits with an error code 0.
# s_ruby="s_0=(`"+s_guid_generation_program_name+" 2>/dev/null 1>/dev/null; echo $?`).to_s"
# eval(s_ruby)
# s_0=s_0.gsub(/[\n\s\r]/,"")
# func_assert_s_0_format_t1.call(s_0)
# if s_0!="0"
# s_guid_3="35587944-1c7f-4e9f-b501-21b170e031e7"
# func_throw_t1.call(s_0,s_guid_3)
# end # if
# #--------------
# s_ruby="s_0=(`"+s_guid_generation_program_name+" 2>/dev/null`).to_s"
# eval(s_ruby)
# s_0=s_0.gsub(/[\n\s\r]/,"")
# s_script_version=s_0
# #----
# if s_script_version.length!=36
# s_guid_4="01895941-fb78-4960-8401-21b170e031e7"
# func_throw_t1.call(s_script_version,s_guid_4)
# end # if
# #--------------
# s="\n"
# s<<"# The S_SCRIPT_VERSION is in 2 parts to allow \n"
# s<<"# the error message GUIDs to be updated without \n"
# s<<"# unsyncing the S_SCRIPT_VERSION from the \n"
# s<<"# S_SCRIPT_VERSION_GENERATION_DATE.\n"
# i_0=12
# s<<"S_SCRIPT_VERSION_SUBPART_1=\""+s_script_version[0..i_0]+"\"\n"
# s<<"S_SCRIPT_VERSION_SUBPART_2=\""+s_script_version[(i_0+1)..(-1)]+"\"\n"
# s<<"S_SCRIPT_VERSION=\"$S_SCRIPT_VERSION_SUBPART_1$S_SCRIPT_VERSION_SUBPART_2\""
# puts(s)
# #----------------------------------------------------------
# ob_date=Time.new
# s=""
# s<<"\nS_SCRIPT_VERSION_GENERATION_DATE=\""
# s<<(ob_date.year.to_s+"y_")
# s<<(ob_date.month.to_s+"month_")
# s<<(ob_date.day.to_s+"day_")
# s<<(ob_date.hour.to_s+"h_")
# s<<(ob_date.min.to_s+"min_")
# s<<(ob_date.sec.to_s+"sec_")
# s<<(ob_date.usec.to_s+"usec")
# s<<"\"\n"
# puts(s)
# #----------------------------------------------------------
# RENESSAATOR_SOURCE_END
# 
# RENESSAATOR_AUTOGENERATED_TEXT_START

# The S_SCRIPT_VERSION is in 2 parts to allow 
# the error message GUIDs to be updated without 
# unsyncing the S_SCRIPT_VERSION from the 
# S_SCRIPT_VERSION_GENERATION_DATE.
S_SCRIPT_VERSION_SUBPART_1="2375db56-ee2a"
S_SCRIPT_VERSION_SUBPART_2="-4a48-ad91-25311e670560"
S_SCRIPT_VERSION="$S_SCRIPT_VERSION_SUBPART_1$S_SCRIPT_VERSION_SUBPART_2"

S_SCRIPT_VERSION_GENERATION_DATE="2017y_3month_14day_7h_27min_13sec_672869usec"

# RENESSAATOR_AUTOGENERATED_TEXT_END
# RENESSAATOR_BLOCK_END

#--------------------------------------------------------------------------

func_mmmv_exit_if_not_on_path_t2() { # S_COMMAND_NAME
    local S_COMMAND_NAME=$1
    local S_LOCAL_VARIABLE="`which $S_COMMAND_NAME 2>/dev/null`"
    if [ "$S_LOCAL_VARIABLE" == "" ]; then
        echo ""
        echo "Command \"$S_COMMAND_NAME\" could not be found from the PATH. "
        echo "The execution of the Bash script is aborted."
        echo "GUID=='1d1a537e-6d2f-4170-b111-21b170e031e7'"
        echo ""
        #----
        cd $S_FP_ORIG
        exit 1 # exit with error
    fi
} # func_mmmv_exit_if_not_on_path_t2


# A list of the console tools that the rest of the 
# verification functions in this Bash script depend on.
# The presence of the rest of the console applications
# are studied by the other verification functions. 

    func_mmmv_exit_if_not_on_path_t2 "grep"
    func_mmmv_exit_if_not_on_path_t2 "ruby"
    func_mmmv_exit_if_not_on_path_t2 "uname"
    func_mmmv_exit_if_not_on_path_t2 "which"

#--------------------------------------------------------------------------

# SB_USE_GAWK_IN_STEAD_OF_AWK="not_set_yet"
# func_mmmv_silktorrent_init_awk_versus_gawk() { 
#     local SB_AWK_AND_GAWK_ARE_BOTH_UNUSABLE="f"
#     #--------
#     local S_TMP_0="`which gawk 2>/dev/null`"
#     if [ "$S_TMP_0" == "" ]; then
#         S_TMP_0="`which awk 2>/dev/null`"
#         if [ "$S_TMP_0" == "" ]; then
#             SB_AWK_AND_GAWK_ARE_BOTH_UNUSABLE="t"
#         else
#             SB_USE_GAWK_IN_STEAD_OF_AWK="f"
#         fi
#     else
#         SB_USE_GAWK_IN_STEAD_OF_AWK="t"
#     fi
#     #--------
#     if [ "$SB_AWK_AND_GAWK_ARE_BOTH_UNUSABLE" == "t" ]; then
#         echo ""
#         echo "Neither \"awk\", nor \"gawk\" is usable,"
#         echo "but at least one of them is required to be usable."
#         echo "The execution of the Bash script is aborted."
#         echo "GUID=='3cdd7832-1e9c-46de-9301-21b170e031e7'"
#         echo ""
#         #----
#         cd $S_FP_ORIG
#         exit 1 # exit with error
#     fi
# } # func_mmmv_silktorrent_init_awk_versus_gawk
# 
# func_mmmv_silktorrent_init_awk_versus_gawk
# 
# if [ "$SB_USE_GAWK_IN_STEAD_OF_AWK" != "t" ]; then
#     if [ "$SB_USE_GAWK_IN_STEAD_OF_AWK" != "f" ]; then
#         echo ""
#         echo "This script is flawed."
#         echo ""
#         echo "    SB_USE_GAWK_IN_STEAD_OF_AWK=$SB_USE_GAWK_IN_STEAD_OF_AWK"
#         echo ""
#         echo "GUID=='dcd4a44e-7464-4d19-a301-21b170e031e7'"
#         echo ""
#         #----
#         cd $S_FP_ORIG
#         exit 1 # exit with error
#     fi
# fi

#--------------------------------------------------------------------------

S_FUNC_MMMV_OPERATING_SYSTEM_TYPE_T1_RESULT=""
func_mmmv_operating_system_type_t1() {
    if [ "$S_FUNC_MMMV_OPERATING_SYSTEM_TYPE_T1_RESULT" == "" ]; then
        S_TMP_0="`uname -a | grep -E [Ll]inux`"
        if [ "$S_TMP_0" != "" ]; then
            S_FUNC_MMMV_OPERATING_SYSTEM_TYPE_T1_RESULT="Linux"
        else
            S_TMP_0="`uname -a | grep BSD `"
            if [ "$S_TMP_0" != "" ]; then
                S_FUNC_MMMV_OPERATING_SYSTEM_TYPE_T1_RESULT="BSD"
            else
                S_FUNC_MMMV_OPERATING_SYSTEM_TYPE_T1_RESULT="undetermined"
            fi
        fi
    fi
} # func_mmmv_operating_system_type_t1

#--------------------------------------------------------------------------

func_mmmv_operating_system_type_t1
if [ "$S_FUNC_MMMV_OPERATING_SYSTEM_TYPE_T1_RESULT" != "Linux" ]; then
    if [ "$S_FUNC_MMMV_OPERATING_SYSTEM_TYPE_T1_RESULT" != "BSD" ]; then
        echo ""
        echo "  The classical command line utilities at "
        echo "  different operating systems, for example, Linux and BSD,"
        echo "  differ. This script is designed to run only on "
        echo "  Linux and some BSD variants."
        echo "  If You are willing to risk that some of Your data "
        echo "  is deleted and/or Your operating system instance"
        echo "  becomes permanently flawed, to the point that "
        echo "  it will not even boot, then You may edit the Bash script that "
        echo "  displays this error message by modifying the test that "
        echo "  checks for the operating system type."
        echo ""
        echo "  If You do decide to edit this Bash script, then "
        echo "  a recommendation is to test Your modifications "
        echo "  within a virtual machine or, if virtual machines are not"
        echo "  an option, as some new operating system user that does not have "
        echo "  any access to the vital data/files."
        echo "  GUID=='2d84a004-7553-4fde-b101-21b170e031e7'"
        echo ""
        echo "  Aborting script without doing anything."
        echo ""
        exit 1 # exit with error
    fi
fi


#--------------------------------------------------------------------------


SB_EXISTS_ON_PATH_T1_RESULT="f"
func_sb_exists_on_path_t1 () {
    local S_NAME_OF_THE_EXECUTABLE_1="$1" # first function argument
    #--------
    local S_TMP_0="" # declaration
    local S_TMP_1="" # declaration
    local S_TMP_2="" # declaration
    #--------
    # Function calls like
    #
    #     func_sb_exists_on_path_t1 ""
    #     func_sb_exists_on_path_t1 " "
    #     func_sb_exists_on_path_t1 "ls ps" # contains a space
    #
    # are not allowed.
    if [ "$S_NAME_OF_THE_EXECUTABLE_1" == "" ] ; then
        echo ""
        echo "The Bash function "
        echo ""
        echo "    func_sb_exists_on_path_t1 "
        echo ""
        echo "is not designed to handle an argument that "
        echo "equals with an empty string."
        echo "GUID=='276e63f4-5cd6-4024-8101-21b170e031e7'"
        echo ""
        #----
        cd $S_FP_ORIG
        exit 1 # exit with error
    fi
    S_TMP_0="`ruby -e \"print('$S_NAME_OF_THE_EXECUTABLE_1'.to_s.gsub(/[\s]+/,''));\" `"
    if [ "$S_NAME_OF_THE_EXECUTABLE_1" != "$S_TMP_0" ] ; then
        echo ""
        echo "The Bash function "
        echo ""
        echo "    func_sb_exists_on_path_t1 "
        echo ""
        echo "is not designed to handle an argument value that contains "
        echo "spaces or tabulation characters."
        echo "The received value in parenthesis:($S_NAME_OF_THE_EXECUTABLE_1)."
        echo "GUID=='4bbf0804-165e-484f-84f0-21b170e031e7'"
        echo ""
        #----
        cd $S_FP_ORIG
        exit 1 # exit with error
    fi
    #--------
    S_TMP_0="\`which $S_NAME_OF_THE_EXECUTABLE_1 2>/dev/null\`"
    local S_TMP_2="S_TMP_1=$S_TMP_0"
    eval ${S_TMP_2}
    #----
    if [ "$S_TMP_1" == "" ] ; then
        SB_EXISTS_ON_PATH_T1_RESULT="f"
    else
        SB_EXISTS_ON_PATH_T1_RESULT="t"
    fi
} # func_sb_exists_on_path_t1 



func_assert_exists_on_path_t2 () {
    local S_NAME_OF_THE_EXECUTABLE_1="$1" # first function argument
    local S_NAME_OF_THE_EXECUTABLE_2="$2" # optional argument
    local S_NAME_OF_THE_EXECUTABLE_3="$3" # optional argument
    local S_NAME_OF_THE_EXECUTABLE_4="$4" # optional argument
    #--------
    # Function calls like
    #
    #     func_assert_exists_on_path_t2  ""    ""  "ls"
    #     func_assert_exists_on_path_t2  "ls"  ""  "ps"
    #
    # are not allowed by the spec of this function, but it's OK to call
    #
    #     func_assert_exists_on_path_t2  "ls" "" 
    #     func_assert_exists_on_path_t2  "ls" "ps" ""
    #     func_assert_exists_on_path_t2  "ls" ""   "" ""
    #
    #
    local SB_THROW="f"
    if [ "$S_NAME_OF_THE_EXECUTABLE_1" == "" ] ; then
        SB_THROW="t"
    else
        if [ "$S_NAME_OF_THE_EXECUTABLE_2" == "" ] ; then
            if [ "$S_NAME_OF_THE_EXECUTABLE_3" != "" ] ; then
                SB_THROW="t"
            fi
            if [ "$S_NAME_OF_THE_EXECUTABLE_4" != "" ] ; then
                SB_THROW="t"
            fi
        else
            if [ "$S_NAME_OF_THE_EXECUTABLE_3" == "" ] ; then
                if [ "$S_NAME_OF_THE_EXECUTABLE_4" != "" ] ; then
                    SB_THROW="t"
                fi
            fi
        fi
    fi
    #----
    if [ "$SB_THROW" == "t" ] ; then
        echo ""
        echo "The Bash function "
        echo ""
        echo "    func_assert_exists_on_path_t2 "
        echo ""
        echo "is not designed to handle series of arguments, where "
        echo "empty strings precede non-empty strings."
        echo "GUID=='dfeabb47-2adc-41e8-b2f0-21b170e031e7'"
        echo ""
        #----
        cd $S_FP_ORIG
        exit 1 # exit with error
    fi
    if [ "$5" != "" ] ; then
        echo ""
        echo "This Bash function is designed to work with at most 4 input arguments"
        echo "GUID=='17e2c2c9-e24b-404d-b1f0-21b170e031e7'"
        echo ""
        #----
        cd $S_FP_ORIG
        exit 1 # exit with error
    fi
    #--------
    # Function calls like
    #
    #     func_assert_exists_on_path_t2 " "
    #     func_assert_exists_on_path_t2 "ls ps" # contains a space
    #
    # are not allowed.
    SB_THROW="f" 
    local S_TMP_0=""
    local S_TMP_1=""
    local S_TMP_2=""
    #----
    if [ "$SB_THROW" == "f" ] ; then
        S_TMP_0="`ruby -e \"print('$S_NAME_OF_THE_EXECUTABLE_1'.to_s.gsub(/[\s]+/,''));\" `"
        if [ "$S_NAME_OF_THE_EXECUTABLE_1" != "$S_TMP_0" ] ; then
            SB_THROW="t" 
            S_TMP_1="$S_NAME_OF_THE_EXECUTABLE_1"
            S_TMP_2="GUID=='484d2559-e6ad-4ed4-92f0-21b170e031e7'"
        fi
    fi
    #----
    if [ "$SB_THROW" == "f" ] ; then
        S_TMP_0="`ruby -e \"print('$S_NAME_OF_THE_EXECUTABLE_2'.to_s.gsub(/[\s]+/,''));\" `"
        if [ "$S_NAME_OF_THE_EXECUTABLE_2" != "$S_TMP_0" ] ; then
            SB_THROW="t" 
            S_TMP_1="$S_NAME_OF_THE_EXECUTABLE_2"
            S_TMP_2="GUID=='a487a993-9260-4e88-b5f0-21b170e031e7'"
        fi
    fi
    #----
    if [ "$SB_THROW" == "f" ] ; then
        S_TMP_0="`ruby -e \"print('$S_NAME_OF_THE_EXECUTABLE_3'.to_s.gsub(/[\s]+/,''));\" `"
        if [ "$S_NAME_OF_THE_EXECUTABLE_3" != "$S_TMP_0" ] ; then
            SB_THROW="t" 
            S_TMP_1="$S_NAME_OF_THE_EXECUTABLE_3"
            S_TMP_2="GUID=='09d1253f-ac94-4a23-91e0-21b170e031e7'"
        fi
    fi
    #----
    if [ "$SB_THROW" == "f" ] ; then
        S_TMP_0="`ruby -e \"print('$S_NAME_OF_THE_EXECUTABLE_4'.to_s.gsub(/[\s]+/,''));\" `"
        if [ "$S_NAME_OF_THE_EXECUTABLE_4" != "$S_TMP_0" ] ; then
            SB_THROW="t" 
            S_TMP_1="$S_NAME_OF_THE_EXECUTABLE_4"
            S_TMP_2="GUID=='ffbf5053-e7cd-4056-84e0-21b170e031e7'"
        fi
    fi
    #--------
    if [ "$SB_THROW" == "t" ] ; then
        echo ""
        echo "The Bash function "
        echo ""
        echo "    func_assert_exists_on_path_t2 "
        echo ""
        echo "is not designed to handle an argument value that contains "
        echo "spaces or tabulation characters."
        echo "The unaccepted value in parenthesis:($S_TMP_1)."
        echo "Branch $S_TMP_2."
        echo "GUID=='4579e24d-91d4-4a01-92e0-21b170e031e7'"
        echo ""
        #----
        cd $S_FP_ORIG
        exit 1 # exit with error
    fi
    SB_THROW="f" # Just a reset, should I forget to reset it later.
    #---------------
    S_TMP_0="\`which $S_NAME_OF_THE_EXECUTABLE_1 2>/dev/null\`"
    local S_TMP_1=""
    local S_TMP_2="S_TMP_1=$S_TMP_0"
    eval ${S_TMP_2}
    #----
    if [ "$S_TMP_1" == "" ] ; then
        if [ "$S_NAME_OF_THE_EXECUTABLE_2" == "" ] ; then
        if [ "$S_NAME_OF_THE_EXECUTABLE_3" == "" ] ; then
        if [ "$S_NAME_OF_THE_EXECUTABLE_4" == "" ] ; then
            echo ""
            echo "This bash script requires the \"$S_NAME_OF_THE_EXECUTABLE_1\" to be on the PATH."
            echo "GUID=='2175161e-23d9-475e-a4e0-21b170e031e7'"
            echo ""
            #----
            cd $S_FP_ORIG
            exit 1 # exit with error
        fi
        fi
        fi
    else
        return # at least one of the programs was available at the PATH
    fi
    #--------
    S_TMP_0="\`which $S_NAME_OF_THE_EXECUTABLE_2 2>/dev/null\`"
    S_TMP_1=""
    S_TMP_2="S_TMP_1=$S_TMP_0"
    eval ${S_TMP_2}
    #----
    if [ "$S_TMP_1" == "" ] ; then
        if [ "$S_NAME_OF_THE_EXECUTABLE_3" == "" ] ; then
        if [ "$S_NAME_OF_THE_EXECUTABLE_4" == "" ] ; then
            echo ""
            echo "This bash script requires that either \"$S_NAME_OF_THE_EXECUTABLE_1\" or "
            echo " \"$S_NAME_OF_THE_EXECUTABLE_2\" is available on the PATH."
            echo "GUID=='fd92845d-7441-46ab-b1e0-21b170e031e7'"
            echo ""
            #----
            cd $S_FP_ORIG
            exit 1 # exit with error
        fi
        fi
    else
        return # at least one of the programs was available at the PATH
    fi
    #--------
    S_TMP_0="\`which $S_NAME_OF_THE_EXECUTABLE_3 2>/dev/null\`"
    S_TMP_1=""
    S_TMP_2="S_TMP_1=$S_TMP_0"
    eval ${S_TMP_2}
    #----
    if [ "$S_TMP_1" == "" ] ; then
        if [ "$S_NAME_OF_THE_EXECUTABLE_4" == "" ] ; then
            echo ""
            echo "This bash script requires that either \"$S_NAME_OF_THE_EXECUTABLE_1\" or "
            echo " \"$S_NAME_OF_THE_EXECUTABLE_2\" or \"$S_NAME_OF_THE_EXECUTABLE_3\" "
            echo "is available on the PATH."
            echo "GUID=='94e16d22-b33f-430e-a6e0-21b170e031e7'"
            echo ""
            #----
            cd $S_FP_ORIG
            exit 1 # exit with error
        fi
    else
        return # at least one of the programs was available at the PATH
    fi
    #--------
    S_TMP_0="\`which $S_NAME_OF_THE_EXECUTABLE_4 2>/dev/null\`"
    S_TMP_1=""
    S_TMP_2="S_TMP_1=$S_TMP_0"
    eval ${S_TMP_2}
    #----
    if [ "$S_TMP_1" == "" ] ; then
        echo ""
        echo "This bash script requires that either \"$S_NAME_OF_THE_EXECUTABLE_1\" or "
        echo " \"$S_NAME_OF_THE_EXECUTABLE_2\" or \"$S_NAME_OF_THE_EXECUTABLE_3\" or "
        echo " \"$S_NAME_OF_THE_EXECUTABLE_4\" is available on the PATH."
        echo "GUID=='33d77c63-f841-49ff-add0-21b170e031e7'"
        echo ""
        #----
        cd $S_FP_ORIG
        exit 1 # exit with error
    else
        return # at least one of the programs was available at the PATH
    fi
    #--------
} # func_assert_exists_on_path_t2

func_assert_exists_on_path_t2 "bash"     # this is a bash script itself, but
                                         # it might have been executed by 
                                         # specifying the full path to the bash command,
                                         # without having the bash available on the PATH.

func_assert_exists_on_path_t2 "basename" # for extracting file names from full paths
func_assert_exists_on_path_t2 "cat"    # opposite to split
func_assert_exists_on_path_t2 "sha256sum" "sha256" "rhash"
func_assert_exists_on_path_t2 "tigerdeep" "rhash"
func_assert_exists_on_path_t2 "whirlpooldeep" "rhash"
func_assert_exists_on_path_t2 "tar"
#--------
func_assert_exists_on_path_t2 "file"   # for checking the MIME type of the potential tar file
func_assert_exists_on_path_t2 "filesize" "ruby"
#--------
# The following commands have been already checked at the start of this cript.
#     func_assert_exists_on_path_t2 "gawk" 
#     func_assert_exists_on_path_t2 "grep"
#     func_assert_exists_on_path_t2 "uname"  # to check the OS type
#--------
#func_assert_exists_on_path_t2 "readlink"
func_assert_exists_on_path_t2 "ruby"  # anything over/equal v.2.1 will probably do
#func_assert_exists_on_path_t2 "split" # for cutting files
#func_assert_exists_on_path_t2 "test"
func_assert_exists_on_path_t2 "uuidgen" "uuid" # GUID generation on Linux and BSD
#func_assert_exists_on_path_t2 "xargs"  # not in use yet 
func_assert_exists_on_path_t2 "wc" # for checking hash lengths   

#--------------------------------------------------------------------------

# If the S_CANDIDATE is a positive whole number, including 0 and 000042, 
# then it returns the positive whole number in a form, where 
# the leading zeros have been removed. Otherwise it returns
# an empty string. 
#
#     "00000" ->   "0"
#    "+00000" ->   "0"
#    "-00000" ->    ""
#     "00042" ->  "42"
#    "+00042" ->  "42"
#     "00420" -> "420"
#       "420" -> "420"
#       "+42" ->  "42"
#       "-42" ->    ""
#          "" ->    ""
#         " " ->    ""
#       "4.2" ->    ""
#     "a  bc" ->    ""
#
# A more detailed list of the conversion cases are described at the
# 
#     func_mmmv_x_positive_whole_number_or_an_emptystring_t1_tester_t2()
#
S_FUNC_MMMV_X_POSITIVE_WHOLE_NUMBER_OR_AN_EMPTYSTRING_T1_OUT=""
func_mmmv_x_positive_whole_number_or_an_emptystring_t1() { # S_CANDIDATE
    local S_CANDIDATE="$1" # TODO: fix it to handle a case, where the 
                           #       S_CANDIDATE contains spaces.
    #--------
    local S_TMP_0="" # declaration
    local S_TMP_1="" # declaration
    S_FUNC_MMMV_X_POSITIVE_WHOLE_NUMBER_OR_AN_EMPTYSTRING_T1_OUT=""
    local SB_FAILED='f'
    #--------
    if [ "$S_CANDIDATE" == "" ]; then
        SB_FAILED="t"
    fi
    #--------
    if [ "$SB_FAILED" == "f" ]; then
        # This is a bugfix/workarond that does not have almost anything 
        # to do with the algorithm itself, but it exists only to cope with 
        # with the Ruby macro line.
        # blabla="`ruby -e \"print('$S_CANDIDATE'.to_s. blabla
        S_TMP_0="`echo \"$S_CANDIDATE\" | ruby -e \"x=readline; print(x.to_s.gsub(/[\\\"\'\\s]+/,''));\" `"
        if [ "$S_TMP_0" != "$S_CANDIDATE" ]; then
            SB_FAILED="t"
        fi 
    fi
    #--------
    if [ "$SB_FAILED" == "f" ]; then
        # TODO: The next line is the funny one that does not make sense, but it documents the situation.
        S_TMP_0="`ruby -e \"print('$S_CANDIDATE'.to_s.gsub(/[\s]+/,''));\" `"
        if [ "$S_TMP_0" != "$S_CANDIDATE" ]; then
            SB_FAILED="t"
        fi 
    fi
    #--------
    if [ "$SB_FAILED" == "f" ]; then
        # Covers cases like "+","++42","++++++42","-42","4ab2","4,2","4.2","42.","42-","42+","4+2"
        S_TMP_0="`ruby -e \"print('$S_CANDIDATE'.to_s.gsub(/^[+]/,''));\" `"
        # At the previous line: "+" -> ""
        if [ "$S_TMP_0" == "" ]; then  
            # "$S_CANDIDATE" == "+"
            SB_FAILED="t"
        else
            S_TMP_1="`ruby -e \"print('$S_TMP_0'.to_s.gsub(/[\d]+/,''));\" `"
            if [ "$S_TMP_1" != "" ]; then
                SB_FAILED="t"
            fi 
        fi 
    fi
    #--------
    if [ "$SB_FAILED" == "f" ]; then
        # At this line the S_CANDIDATE is valid, but it may  have 
        # the following forms: 
        #
        #     "0","+0","+0000","+0042","+420","0000","42","0042"
        #
        # At this line the S_TMP_0 
        #
        #     "$S_CANDIDATE" -> "$S_TMP_0"
        #
        #           "+00042" -> "00042"
        #               "+0" ->     "0"
        #
        # at one of the previous if-blocks.
        S_TMP_1="`ruby -e \"print('$S_TMP_0'.to_s.gsub(/^[0]+/,''));\" `"
        if [ "$S_TMP_1" == "" ]; then
            S_FUNC_MMMV_X_POSITIVE_WHOLE_NUMBER_OR_AN_EMPTYSTRING_T1_OUT="0"
        else
            S_FUNC_MMMV_X_POSITIVE_WHOLE_NUMBER_OR_AN_EMPTYSTRING_T1_OUT="$S_TMP_1"
        fi 
    fi
} # func_mmmv_x_positive_whole_number_or_an_emptystring_t1


func_mmmv_x_positive_whole_number_or_an_emptystring_t1_tester_t1() { # S_IN S_EXPECTED
    local S_IN="$1"
    local S_EXPECTED="$2"
    #--------
    func_mmmv_x_positive_whole_number_or_an_emptystring_t1 "$S_IN"
    local S_FUNC="$S_FUNC_MMMV_X_POSITIVE_WHOLE_NUMBER_OR_AN_EMPTYSTRING_T1_OUT"
    if [ "$S_FUNC" != "$S_EXPECTED" ]; then
        echo ""
        echo "A test of the func_mmmv_x_positive_whole_number_or_an_emptystring_t1 failed."
        echo ""
        echo "    S_IN=$S_IN"
        echo ""
        echo "    S_FUNC=$S_FUNC"
        echo ""
        echo "    S_EXPECTED=$S_EXPECTED"
        echo ""
        #----
        cd $S_FP_ORIG
        exit 1 # exit with error
    fi
} # func_mmmv_x_positive_whole_number_or_an_emptystring_t1_tester_t1


func_mmmv_x_positive_whole_number_or_an_emptystring_t1_tester_t2() { 
#----------------------------------------
# RENESSAATOR_BLOCK_START
# RENESSAATOR_BLOCK_ID=block_0452757a-2b6f-4275-bc52-6320305021e7_city
# RENESSAATOR_SOURCE_LANGUAGE=Ruby
# RENESSAATOR_SOURCE_START
# #---------------------------
# ar=Array.new  # elements are arrays: [s_in, s_expected]
# ar<<["00000","0"]
# ar<<["+0000.0",""]
# ar<<["+00000","0"]
# ar<<["+0","0"]
# ar<<["0","0"]
# ar<<["0+",""]
# ar<<["+0000,0",""]
# ar<<["-00000",""]
# ar<<["-0000,0",""]
# ar<<["-0000.0",""]
# ar<<["-00000-",""]
# ar<<["00000-",""]
# ar<<["00000 ",""]
# ar<<[" 00000",""]
# ar<<["--00000",""]
# ar<<["++00000",""]
# ar<<["000-00",""]
# ar<<["-0",""]
# ar<<["0-",""]
# ar<<["0000-",""]
# ar<<["+0000-",""]
# ar<<["-0000-",""]
# ar<<["-0000+",""]
# ar<<["0000+",""]
# ar<<["000+00",""]
# ar<<["00042","42"]
# ar<<["+00042","42"]
# ar<<["00420","420"]
# ar<<["+00420","420"]
# ar<<["00420+",""]
# ar<<["004+20",""]
# ar<<["420","420"]
# ar<<["+420","420"]
# ar<<["420+",""]
# ar<<["1","1"]
# ar<<["-1",""]
# ar<<["1-",""]
# ar<<["+1","1"]
# ar<<["9","9"]
# ar<<["+9","9"]
# ar<<["9000","9000"]
# ar<<["09000","9000"]
# ar<<["+09000","9000"]
# ar<<["++09000",""]
# ar<<["09000+",""]
# ar<<["09000-",""]
# ar<<["09000--",""]
# ar<<["-9",""]
# ar<<["++9",""]
# ar<<["9+",""]
# ar<<["9++",""]
# ar<<["9+-",""]
# ar<<["+-9",""]
# ar<<["42","42"]
# ar<<["+42","42"]
# ar<<["++42",""]
# ar<<["+42 ",""]
# ar<<["+4 2",""]
# ar<<[" +4 2",""]
# ar<<[" +42",""]
# ar<<["-42",""]
# ar<<[" -42",""]
# ar<<[" -42 ",""]
# ar<<["--42",""]
# ar<<["----42",""]
# ar<<["+42---",""]
# ar<<["-4-2",""]
# ar<<["-4-2-",""]
# ar<<["4-2-",""]
# ar<<["42-",""]
# ar<<["42---",""]
# ar<<["+4+2",""]
# ar<<["4+2",""]
# ar<<["42+",""]
# ar<<["42+++",""]
# ar<<["+42+",""]
# ar<<["4.2",""]
# ar<<["4,2",""]
# ar<<["4 2",""]
# ar<<["4 +2",""]
# ar<<["4 2+",""]
# ar<<["42 ",""]
# ar<<["42.",""]
# ar<<["42,",""]
# ar<<["a  bc",""]
# ar<<["",""]
# ar<<["+",""]
# ar<<["++",""]
# ar<<["+++",""]
# ar<<["-",""]
# ar<<["--",""]
# ar<<["---",""]
# ar<<["-+",""]
# ar<<["+-",""]
# ar<<["+---",""]
# ar<<["\\\"",""]
# ar<<["'",""]
# ar<<["'42",""]
# ar<<["42'",""]
# ar<<[" ",""]
# ar<<["   ",""]
# #---------------------------
# ht=Hash.new
# ar.each do |ar_0|
# x_0=ar_0[0]
# if ht.has_key? x_0
# raise Exception.new("\nDuplicate:["+x_0.to_s+"]\n")
# else
# ht[x_0]=42
# end # if
# end # loop
# #--------
# s_test_func_name="func_mmmv_x_positive_whole_number_or_an_emptystring_t1_tester_t1"
# s_lc_0=s_test_func_name+"  \""
# s_lc_1="\"  \""
# s_lc_2="\""
# func_write_test=lambda do |s_in,s_expected|
# puts(s_lc_0+s_in+s_lc_1+s_expected+s_lc_2+"\n")
# end # func_write_test
# ar.each{|ar_0| func_write_test.call(ar_0[0],ar_0[1])}
# RENESSAATOR_SOURCE_END
# 
# RENESSAATOR_AUTOGENERATED_TEXT_START
func_mmmv_x_positive_whole_number_or_an_emptystring_t1_tester_t1  "00000"  "0"
func_mmmv_x_positive_whole_number_or_an_emptystring_t1_tester_t1  "+0000.0"  ""
func_mmmv_x_positive_whole_number_or_an_emptystring_t1_tester_t1  "+00000"  "0"
func_mmmv_x_positive_whole_number_or_an_emptystring_t1_tester_t1  "+0"  "0"
func_mmmv_x_positive_whole_number_or_an_emptystring_t1_tester_t1  "0"  "0"
func_mmmv_x_positive_whole_number_or_an_emptystring_t1_tester_t1  "0+"  ""
func_mmmv_x_positive_whole_number_or_an_emptystring_t1_tester_t1  "+0000,0"  ""
func_mmmv_x_positive_whole_number_or_an_emptystring_t1_tester_t1  "-00000"  ""
func_mmmv_x_positive_whole_number_or_an_emptystring_t1_tester_t1  "-0000,0"  ""
func_mmmv_x_positive_whole_number_or_an_emptystring_t1_tester_t1  "-0000.0"  ""
func_mmmv_x_positive_whole_number_or_an_emptystring_t1_tester_t1  "-00000-"  ""
func_mmmv_x_positive_whole_number_or_an_emptystring_t1_tester_t1  "00000-"  ""
func_mmmv_x_positive_whole_number_or_an_emptystring_t1_tester_t1  "00000 "  ""
func_mmmv_x_positive_whole_number_or_an_emptystring_t1_tester_t1  " 00000"  ""
func_mmmv_x_positive_whole_number_or_an_emptystring_t1_tester_t1  "--00000"  ""
func_mmmv_x_positive_whole_number_or_an_emptystring_t1_tester_t1  "++00000"  ""
func_mmmv_x_positive_whole_number_or_an_emptystring_t1_tester_t1  "000-00"  ""
func_mmmv_x_positive_whole_number_or_an_emptystring_t1_tester_t1  "-0"  ""
func_mmmv_x_positive_whole_number_or_an_emptystring_t1_tester_t1  "0-"  ""
func_mmmv_x_positive_whole_number_or_an_emptystring_t1_tester_t1  "0000-"  ""
func_mmmv_x_positive_whole_number_or_an_emptystring_t1_tester_t1  "+0000-"  ""
func_mmmv_x_positive_whole_number_or_an_emptystring_t1_tester_t1  "-0000-"  ""
func_mmmv_x_positive_whole_number_or_an_emptystring_t1_tester_t1  "-0000+"  ""
func_mmmv_x_positive_whole_number_or_an_emptystring_t1_tester_t1  "0000+"  ""
func_mmmv_x_positive_whole_number_or_an_emptystring_t1_tester_t1  "000+00"  ""
func_mmmv_x_positive_whole_number_or_an_emptystring_t1_tester_t1  "00042"  "42"
func_mmmv_x_positive_whole_number_or_an_emptystring_t1_tester_t1  "+00042"  "42"
func_mmmv_x_positive_whole_number_or_an_emptystring_t1_tester_t1  "00420"  "420"
func_mmmv_x_positive_whole_number_or_an_emptystring_t1_tester_t1  "+00420"  "420"
func_mmmv_x_positive_whole_number_or_an_emptystring_t1_tester_t1  "00420+"  ""
func_mmmv_x_positive_whole_number_or_an_emptystring_t1_tester_t1  "004+20"  ""
func_mmmv_x_positive_whole_number_or_an_emptystring_t1_tester_t1  "420"  "420"
func_mmmv_x_positive_whole_number_or_an_emptystring_t1_tester_t1  "+420"  "420"
func_mmmv_x_positive_whole_number_or_an_emptystring_t1_tester_t1  "420+"  ""
func_mmmv_x_positive_whole_number_or_an_emptystring_t1_tester_t1  "1"  "1"
func_mmmv_x_positive_whole_number_or_an_emptystring_t1_tester_t1  "-1"  ""
func_mmmv_x_positive_whole_number_or_an_emptystring_t1_tester_t1  "1-"  ""
func_mmmv_x_positive_whole_number_or_an_emptystring_t1_tester_t1  "+1"  "1"
func_mmmv_x_positive_whole_number_or_an_emptystring_t1_tester_t1  "9"  "9"
func_mmmv_x_positive_whole_number_or_an_emptystring_t1_tester_t1  "+9"  "9"
func_mmmv_x_positive_whole_number_or_an_emptystring_t1_tester_t1  "9000"  "9000"
func_mmmv_x_positive_whole_number_or_an_emptystring_t1_tester_t1  "09000"  "9000"
func_mmmv_x_positive_whole_number_or_an_emptystring_t1_tester_t1  "+09000"  "9000"
func_mmmv_x_positive_whole_number_or_an_emptystring_t1_tester_t1  "++09000"  ""
func_mmmv_x_positive_whole_number_or_an_emptystring_t1_tester_t1  "09000+"  ""
func_mmmv_x_positive_whole_number_or_an_emptystring_t1_tester_t1  "09000-"  ""
func_mmmv_x_positive_whole_number_or_an_emptystring_t1_tester_t1  "09000--"  ""
func_mmmv_x_positive_whole_number_or_an_emptystring_t1_tester_t1  "-9"  ""
func_mmmv_x_positive_whole_number_or_an_emptystring_t1_tester_t1  "++9"  ""
func_mmmv_x_positive_whole_number_or_an_emptystring_t1_tester_t1  "9+"  ""
func_mmmv_x_positive_whole_number_or_an_emptystring_t1_tester_t1  "9++"  ""
func_mmmv_x_positive_whole_number_or_an_emptystring_t1_tester_t1  "9+-"  ""
func_mmmv_x_positive_whole_number_or_an_emptystring_t1_tester_t1  "+-9"  ""
func_mmmv_x_positive_whole_number_or_an_emptystring_t1_tester_t1  "42"  "42"
func_mmmv_x_positive_whole_number_or_an_emptystring_t1_tester_t1  "+42"  "42"
func_mmmv_x_positive_whole_number_or_an_emptystring_t1_tester_t1  "++42"  ""
func_mmmv_x_positive_whole_number_or_an_emptystring_t1_tester_t1  "+42 "  ""
func_mmmv_x_positive_whole_number_or_an_emptystring_t1_tester_t1  "+4 2"  ""
func_mmmv_x_positive_whole_number_or_an_emptystring_t1_tester_t1  " +4 2"  ""
func_mmmv_x_positive_whole_number_or_an_emptystring_t1_tester_t1  " +42"  ""
func_mmmv_x_positive_whole_number_or_an_emptystring_t1_tester_t1  "-42"  ""
func_mmmv_x_positive_whole_number_or_an_emptystring_t1_tester_t1  " -42"  ""
func_mmmv_x_positive_whole_number_or_an_emptystring_t1_tester_t1  " -42 "  ""
func_mmmv_x_positive_whole_number_or_an_emptystring_t1_tester_t1  "--42"  ""
func_mmmv_x_positive_whole_number_or_an_emptystring_t1_tester_t1  "----42"  ""
func_mmmv_x_positive_whole_number_or_an_emptystring_t1_tester_t1  "+42---"  ""
func_mmmv_x_positive_whole_number_or_an_emptystring_t1_tester_t1  "-4-2"  ""
func_mmmv_x_positive_whole_number_or_an_emptystring_t1_tester_t1  "-4-2-"  ""
func_mmmv_x_positive_whole_number_or_an_emptystring_t1_tester_t1  "4-2-"  ""
func_mmmv_x_positive_whole_number_or_an_emptystring_t1_tester_t1  "42-"  ""
func_mmmv_x_positive_whole_number_or_an_emptystring_t1_tester_t1  "42---"  ""
func_mmmv_x_positive_whole_number_or_an_emptystring_t1_tester_t1  "+4+2"  ""
func_mmmv_x_positive_whole_number_or_an_emptystring_t1_tester_t1  "4+2"  ""
func_mmmv_x_positive_whole_number_or_an_emptystring_t1_tester_t1  "42+"  ""
func_mmmv_x_positive_whole_number_or_an_emptystring_t1_tester_t1  "42+++"  ""
func_mmmv_x_positive_whole_number_or_an_emptystring_t1_tester_t1  "+42+"  ""
func_mmmv_x_positive_whole_number_or_an_emptystring_t1_tester_t1  "4.2"  ""
func_mmmv_x_positive_whole_number_or_an_emptystring_t1_tester_t1  "4,2"  ""
func_mmmv_x_positive_whole_number_or_an_emptystring_t1_tester_t1  "4 2"  ""
func_mmmv_x_positive_whole_number_or_an_emptystring_t1_tester_t1  "4 +2"  ""
func_mmmv_x_positive_whole_number_or_an_emptystring_t1_tester_t1  "4 2+"  ""
func_mmmv_x_positive_whole_number_or_an_emptystring_t1_tester_t1  "42 "  ""
func_mmmv_x_positive_whole_number_or_an_emptystring_t1_tester_t1  "42."  ""
func_mmmv_x_positive_whole_number_or_an_emptystring_t1_tester_t1  "42,"  ""
func_mmmv_x_positive_whole_number_or_an_emptystring_t1_tester_t1  "a  bc"  ""
func_mmmv_x_positive_whole_number_or_an_emptystring_t1_tester_t1  ""  ""
func_mmmv_x_positive_whole_number_or_an_emptystring_t1_tester_t1  "+"  ""
func_mmmv_x_positive_whole_number_or_an_emptystring_t1_tester_t1  "++"  ""
func_mmmv_x_positive_whole_number_or_an_emptystring_t1_tester_t1  "+++"  ""
func_mmmv_x_positive_whole_number_or_an_emptystring_t1_tester_t1  "-"  ""
func_mmmv_x_positive_whole_number_or_an_emptystring_t1_tester_t1  "--"  ""
func_mmmv_x_positive_whole_number_or_an_emptystring_t1_tester_t1  "---"  ""
func_mmmv_x_positive_whole_number_or_an_emptystring_t1_tester_t1  "-+"  ""
func_mmmv_x_positive_whole_number_or_an_emptystring_t1_tester_t1  "+-"  ""
func_mmmv_x_positive_whole_number_or_an_emptystring_t1_tester_t1  "+---"  ""
func_mmmv_x_positive_whole_number_or_an_emptystring_t1_tester_t1  "\""  ""
func_mmmv_x_positive_whole_number_or_an_emptystring_t1_tester_t1  "'"  ""
func_mmmv_x_positive_whole_number_or_an_emptystring_t1_tester_t1  "'42"  ""
func_mmmv_x_positive_whole_number_or_an_emptystring_t1_tester_t1  "42'"  ""
func_mmmv_x_positive_whole_number_or_an_emptystring_t1_tester_t1  " "  ""
func_mmmv_x_positive_whole_number_or_an_emptystring_t1_tester_t1  "   "  ""

# RENESSAATOR_AUTOGENERATED_TEXT_END
# RENESSAATOR_BLOCK_END
#----------------------------------------
} # func_mmmv_x_positive_whole_number_or_an_emptystring_t1_tester_t2

# func_mmmv_x_positive_whole_number_or_an_emptystring_t1_tester_t2
# exit 1 # exit with an error, because the test code should be outcommented.

#--------------------------------------------------------------------------

# Throws, if the argument is present.
func_mmmv_assert_arg_is_absent_t1() {
    local S_ARG_X="$1" 
    local S_ARG_X_NAME="$2" 
    local S_GUID="$3" 
    #--------
    if [ "$S_GUID" == "" ] ; then
        echo ""
        echo "The implementation of the function that "
        echo "calls the "
        echo ""
        echo "    func_mmmv_assert_arg_is_absent_t1"
        echo ""
        echo "is flawed. The call to the "
        echo ""
        echo "    func_mmmv_assert_arg_is_absent_t1"
        echo ""
        echo "misses the third function argument, "
        echo "which is expected to be a GUID."
        echo "GUID=='4b17d249-3ea2-4b7d-a3d0-21b170e031e7'"
        echo ""
        #----
        cd $S_FP_ORIG
        exit 1 # exit with error
    fi
    if [ "$S_ARG_X_NAME" == "" ] ; then
        echo ""
        echo "The implementation of the function that "
        echo "calls the "
        echo ""
        echo "    func_mmmv_assert_arg_is_absent_t1"
        echo ""
        echo "is flawed. The call to the "
        echo ""
        echo "    func_mmmv_assert_arg_is_absent_t1"
        echo ""
        echo "misses the second function argument."
        echo "GUID=='61f89944-37b6-4110-b1d0-21b170e031e7'"
        echo "GUID=='$S_GUID'"
        echo ""
        #----
        cd $S_FP_ORIG
        exit 1 # exit with error
    fi
    #--------
    if [ "$S_ARG_X" != "" ] ; then
        echo ""
        echo "If the first console argument is \"$S_ARGV_0\", then "
        echo "the $S_ARG_X_NAME is required to be absent, "
        echo "but currently "
        echo ""
        echo "    <$S_ARG_X_NAME>=$S_ARG_X"
        echo ""
        echo "GUID=='495dd213-9b2a-45bc-93d0-21b170e031e7'"
        echo "GUID=='$S_GUID'"
        echo ""
        #----
        cd $S_FP_ORIG
        exit 1 # exit with error
    fi
} # func_mmmv_assert_arg_is_absent_t1


#--------------------------------------------------------------------------

func_mmmv_exc_hash_function_input_verification_t1() { 
    local S_NAME_OF_THE_BASH_FUNCTION="$1" # The name of the Bash function.
    local S_FP_2_AN_EXISTING_FILE="$2" # The first argument of the Bash function.
    #--------
    local S_TMP_0="" # declaration
    local S_TMP_1="" # declaration
    #--------
    if [ "$S_NAME_OF_THE_BASH_FUNCTION" == "" ] ; then
        echo ""
        echo "The implementation of the function that "
        echo "calls the "
        echo ""
        echo "    func_mmmv_exc_hash_function_input_verification_t1"
        echo ""
        echo "is flawed. The call to the "
        echo ""
        echo "    func_mmmv_exc_hash_function_input_verification_t1"
        echo ""
        echo "misses the first argument or the first argument is an empty string."
        echo "GUID=='4763d3c3-73c0-455a-91d0-21b170e031e7'"
        echo ""
        #----
        cd $S_FP_ORIG
        exit 1 # exit with error
    fi
    S_TMP_0="`ruby -e \"print('$S_NAME_OF_THE_BASH_FUNCTION'.to_s.gsub(/[\s]+/,''));\" `"
    if [ "$S_NAME_OF_THE_BASH_FUNCTION" != "$S_TMP_0" ] ; then
        echo ""
        echo "The implementation of the function that "
        echo "calls the "
        echo ""
        echo "    func_mmmv_exc_hash_function_input_verification_t1"
        echo ""
        echo "is flawed. Function names are not allowed to contain spaces or tabs."
        echo "GUID=='7d2fca19-9734-475a-b1d0-21b170e031e7'"
        echo ""
        #----
        cd $S_FP_ORIG
        exit 1 # exit with error
    fi
    #--------
    # Function calls like
    #
    #     <function name> ""
    #     <function name> " "
    #
    # are not allowed.
    S_TMP_0="`ruby -e \"print('$S_FP_2_AN_EXISTING_FILE'.to_s.gsub(/[\s]+/,''));\" `"
    if [ "$S_TMP_0" == "" ] ; then
        echo ""
        echo "The Bash function "
        echo ""
        echo "    $S_NAME_OF_THE_BASH_FUNCTION"
        echo ""
        echo "is not designed to handle an argument that "
        echo "equals with an empty string or a series of spaces and tabs."
        echo "GUID=='31815720-20b4-43a3-82d0-21b170e031e7'"
        echo ""
        #----
        cd $S_FP_ORIG
        exit 1 # exit with error
    fi
    #--------
    if [ ! -e $S_FP_2_AN_EXISTING_FILE ] ; then
        echo ""
        echo "The file "
        echo ""
        echo "    $S_FP_2_AN_EXISTING_FILE "
        echo ""
        echo "is missing or it is a broken link."
        echo "GUID=='823b9855-f6d3-4ed7-a4d0-21b170e031e7'"
        echo ""
        #----
        cd $S_FP_ORIG
        exit 1 # exit with error
    fi
    if [ -d $S_FP_2_AN_EXISTING_FILE ] ; then
        echo ""
        echo "The file path "
        echo ""
        echo "    $S_FP_2_AN_EXISTING_FILE "
        echo ""
        echo "references a folder, but a file is expected."
        echo "GUID=='c0bc2927-29c0-43ca-a1d0-21b170e031e7'"
        echo ""
        #----
        cd $S_FP_ORIG
        exit 1 # exit with error
    fi
    #--------------------
    # At this line the verifications have all passed.
    #--------------------
} # func_mmmv_exc_hash_function_input_verification_t1


#--------------------------------------------------------------------------

S_FUNC_MMMV_GUID_T1_RESULT="not_yet_set"
S_FUNC_MMMV_GUID_T1_MODE="" # optim. to skip repeating console tool selection
func_mmmv_GUID_t1() { 
    # Does not take any arguments.
    #--------
    #func_mmmv_exc_hash_function_input_verification_t1 "func_mmmv_GUID_t1" "$1"
    #--------------------
    # Mode selection:
    if [ "$S_FUNC_MMMV_GUID_T1_MODE" == "" ] ; then
        SB_EXISTS_ON_PATH_T1_RESULT="f"  # if-block init
        #----
        if [ "$SB_EXISTS_ON_PATH_T1_RESULT" == "f" ] ; then
            S_TMP_0="uuidgen" # Linux version
            func_sb_exists_on_path_t1 "$S_TMP_0" 
            if [ "$SB_EXISTS_ON_PATH_T1_RESULT" == "t" ] ; then
                 S_FUNC_MMMV_GUID_T1_MODE="$S_TMP_0"
            fi
        fi
        #----
        if [ "$SB_EXISTS_ON_PATH_T1_RESULT" == "f" ] ; then
            S_TMP_0="uuid"    # BSD version
            func_sb_exists_on_path_t1 "$S_TMP_0" 
            if [ "$SB_EXISTS_ON_PATH_T1_RESULT" == "t" ] ; then
                 S_FUNC_MMMV_GUID_T1_MODE="$S_TMP_0"
            fi
        fi
        #--------
        if [ "$S_FUNC_MMMV_GUID_T1_MODE" == "" ] ; then
            echo ""
            echo "All of the GUID generation implementations that this script " 
            echo "is capable of using (uuidgen, uuid) "
            echo "are missing from the PATH."
            echo "GUID=='45055ef0-ca54-456d-94c0-21b170e031e7'"
            echo ""
            #----
            cd $S_FP_ORIG
            exit 1 # exit with error
        fi
        #--------
        if [ "$?" != "0" ]; then
            echo ""
            echo "This script is flawed."
            echo "GUID=='23948835-b3b1-45ca-abc0-21b170e031e7'"
            echo ""
            #----
            cd $S_FP_ORIG
            exit 1 # exit with error
        fi
        #--------
    fi
    #--------------------
    S_FUNC_MMMV_GUID_T1_RESULT=""
    #--------------------
    if [ "$S_FUNC_MMMV_GUID_T1_MODE" == "uuidgen" ]; then
        S_TMP_0="`uuidgen`"
        if [ "$?" != "0" ]; then
            echo ""
            echo "The console application \"uuidgen\" "
            echo "exited with an error."
            echo ""
            echo "----console--output--citation--start-----"
            echo "`uuidgen`" # stdout and stderr
            echo "----console--output--citation--end-------"
            echo ""
            echo "GUID=='03b89341-916b-417a-b2c0-21b170e031e7'"
            echo ""
            #----
            cd $S_FP_ORIG
            exit 1 # exit with error
        fi
        #---- 
        S_FUNC_MMMV_GUID_T1_RESULT="$S_TMP_0"
    fi
    #--------------------
    if [ "$S_FUNC_MMMV_GUID_T1_MODE" == "uuid" ]; then
        S_TMP_0="`uuid`"
        if [ "$?" != "0" ]; then
            echo ""
            echo "The console application \"uuid\" "
            echo "exited with an error."
            echo ""
            echo "----console--output--citation--start-----"
            echo "`uuid`" # stdout and stderr
            echo "----console--output--citation--end-------"
            echo ""
            echo "GUID=='788ef224-c42f-4f11-b5c0-21b170e031e7'"
            echo ""
            #----
            cd $S_FP_ORIG
            exit 1 # exit with error
        fi
        #---- 
        S_FUNC_MMMV_GUID_T1_RESULT="$S_TMP_0"
    fi
    #--------------------
    # The reason, why everything is done with ruby at the next 
    # Bash assignment clause is that the "wc -m" pads its output
    # with spaces on BSD.
    S_TMP_0="`ruby -e \"print(ARGV[0].to_s.length.to_s);\" $S_FUNC_MMMV_GUID_T1_RESULT `"
    #--------
    S_TMP_1="36"
    if [ "$S_TMP_0" != "$S_TMP_1" ]; then
        echo ""
        echo "According to the GUID specification, IETF RFC 4122,  "
        echo "the length of the GUID is "
        echo "$S_TMP_1 characters, but the result of the "
        echo ""
        echo "    func_mmmv_GUID_t1"
        echo ""
        echo "is something else. The flawed GUID candidate in parenthesis:"
        echo "($S_FUNC_MMMV_GUID_T1_RESULT)"
        echo ""
        echo "The length candidate of the flawed GUID candidate in parenthesis:"
        echo "($S_TMP_0)."
        echo ""
        echo "GUID=='1bb6ef7a-3f57-493b-93c0-21b170e031e7'"
        echo ""
        #----
        cd $S_FP_ORIG
        exit 1 # exit with error
    fi
    #--------------------
} # func_mmmv_GUID_t1


#--------------------------------------------------------------------------

S_FUNC_MMMV_SHA256_T1_RESULT="not_yet_set"
S_FUNC_MMMV_SHA256_T1_MODE="" # optim. to skip repeating console tool selection
func_mmmv_sha256_t1() { # requires also ruby and gawk 
    local S_FP_2_AN_EXISTING_FILE="$1" # first function argument
    #--------
    func_mmmv_exc_hash_function_input_verification_t1 "func_mmmv_sha256_t1" "$1"
    #--------------------
    # Mode selection:
    if [ "$S_FUNC_MMMV_SHA256_T1_MODE" == "" ] ; then
        SB_EXISTS_ON_PATH_T1_RESULT="f"  # if-block init
        #----
        if [ "$SB_EXISTS_ON_PATH_T1_RESULT" == "f" ] ; then
            S_TMP_0="sha256sum" # usually available on Linux
            func_sb_exists_on_path_t1 "$S_TMP_0" 
            if [ "$SB_EXISTS_ON_PATH_T1_RESULT" == "t" ] ; then
                 S_FUNC_MMMV_SHA256_T1_MODE="$S_TMP_0"
            fi
        fi
        #----
        if [ "$SB_EXISTS_ON_PATH_T1_RESULT" == "f" ] ; then
            S_TMP_0="rhash"    # part of the BSD package collection in 2016
            func_sb_exists_on_path_t1 "$S_TMP_0" 
            if [ "$SB_EXISTS_ON_PATH_T1_RESULT" == "t" ] ; then
                 S_FUNC_MMMV_SHA256_T1_MODE="$S_TMP_0"
            fi
        fi
        #----
        if [ "$SB_EXISTS_ON_PATH_T1_RESULT" == "f" ] ; then
            S_TMP_0="sha256"    # usually available on BSD
            func_sb_exists_on_path_t1 "$S_TMP_0" 
            if [ "$SB_EXISTS_ON_PATH_T1_RESULT" == "t" ] ; then
                 S_FUNC_MMMV_SHA256_T1_MODE="$S_TMP_0"
            fi
        fi
        # The console application "rhash" is preferred to the "sha256"
        # because the "rhash" output can be simply processed with 
        # "gawk", which takes over 5x less memory than the Ruby interpreter,
        # not to mention the initialization cost of the Ruby interpreter.
        #--------
        if [ "$S_FUNC_MMMV_SHA256_T1_MODE" == "" ] ; then
            echo ""
            echo "All of the SHA-256 implementations that this script " 
            echo "is capable of using (sha256sum, rhash, sha256) "
            echo "are missing from the PATH."
            echo "GUID=='684c321f-4e75-465d-81c0-21b170e031e7'"
            echo ""
            #----
            cd $S_FP_ORIG
            exit 1 # exit with error
        fi
        #--------
        if [ "$?" != "0" ]; then
            echo ""
            echo "This script is flawed."
            echo "GUID=='2cc42f14-9cce-448a-94c0-21b170e031e7'"
            echo ""
            #----
            cd $S_FP_ORIG
            exit 1 # exit with error
        fi
        #--------
    fi
    #--------------------
    S_FUNC_MMMV_SHA256_T1_RESULT=""
    #--------------------
    if [ "$S_FUNC_MMMV_SHA256_T1_MODE" == "sha256sum" ]; then
        S_TMP_0="`sha256sum $S_FP_2_AN_EXISTING_FILE 2>/dev/null`"
        if [ "$?" != "0" ]; then
            echo ""
            echo "The console application \"sha256sum\" "
            echo "exited with an error."
            echo ""
            echo "----console--output--citation--start-----"
            echo "`sha256sum $S_FP_2_AN_EXISTING_FILE`" # stdout and stderr
            echo "----console--output--citation--end-------"
            echo ""
            echo "GUID=='af218748-2b29-4ab9-85c0-21b170e031e7'"
            echo ""
            #----
            cd $S_FP_ORIG
            exit 1 # exit with error
        fi
        S_FUNC_MMMV_SHA256_T1_RESULT="`ruby -e \"print(ARGV[0]);\" $S_TMP_0 `"
    fi
    #--------------------
    if [ "$S_FUNC_MMMV_SHA256_T1_MODE" == "rhash" ]; then
        S_TMP_0="`rhash --sha256 $S_FP_2_AN_EXISTING_FILE 2>/dev/null`"
        if [ "$?" != "0" ]; then
            echo ""
            echo "The console application \"rhash\" "
            echo "exited with an error."
            echo ""
            echo "----console--output--citation--start-----"
            echo "`rhash --sha256 $S_FP_2_AN_EXISTING_FILE `"
            echo "----console--output--citation--end-------"
            echo ""
            echo "GUID=='c047af35-1a2e-4e5e-94b0-21b170e031e7'"
            echo ""
            #----
            cd $S_FP_ORIG
            exit 1 # exit with error
        fi
        S_FUNC_MMMV_SHA256_T1_RESULT="`ruby -e \"print(ARGV[0]);\" $S_TMP_0 `"
    fi
    #--------------------
    if [ "$S_FUNC_MMMV_SHA256_T1_MODE" == "sha256" ]; then
        #----
        S_FUNC_MMMV_SHA256_T1_RESULT=\
        "`S_TMP_0=\"\`sha256 $S_FP_2_AN_EXISTING_FILE\`\" ruby -e \"s0=ENV['S_TMP_0'].to_s;ix_0=s0.index(') = ');print s0[(ix_0+4)..(-1)]\" 2>/dev/null`"
        #----
        if [ "$?" != "0" ]; then
            echo ""
            echo "The console application \"sha256\" "
            echo "exited with an error."
            echo ""
            echo "----console--output--citation--start-----"
            echo \
            "`S_TMP_0=\"\`sha256 $S_FP_2_AN_EXISTING_FILE\`\" ruby -e \"s0=ENV['S_TMP_0'].to_s;ix_0=s0.index(') = ');print s0[(ix_0+4)..(-1)]\"`"
            echo "----console--output--citation--end-------"
            echo ""
            echo "GUID=='37a0cab3-314b-4dd4-b1b0-21b170e031e7'"
            echo ""
            #----
            cd $S_FP_ORIG
            exit 1 # exit with error
        fi
    fi
    #--------------------
    # The reason, why everything is done with ruby at the next 
    # Bash assignment clause is that the "wc -m" pads its output
    # with spaces on BSD.
    S_TMP_0="`ruby -e \"print(ARGV[0].to_s.length.to_s);\" $S_FUNC_MMMV_SHA256_T1_RESULT `"
    #--------
    S_TMP_1="64"
    if [ "$S_TMP_0" != "$S_TMP_1" ]; then
        echo ""
        echo "According to the specification of the SHA-256 hash algorithm"
        echo "the length of the SHA-256 hash is "
        echo "$S_TMP_1 hexadecimal characters, but the result of the "
        echo ""
        echo "    func_mmmv_sha256_t1"
        echo ""
        echo "is something else. The flawed hash candidate in parenthesis:"
        echo "($S_FUNC_MMMV_SHA256_T1_RESULT)"
        echo ""
        echo "The length candidate of the flawed hash candidate in parenthesis:"
        echo "($S_TMP_0)."
        echo ""
        echo "GUID=='185aad45-4bb1-4749-b8b0-21b170e031e7'"
        echo ""
        #----
        cd $S_FP_ORIG
        exit 1 # exit with error
    fi
    #--------------------
} # func_mmmv_sha256_t1


#--------------------------------------------------------------------------

S_FUNC_MMMV_TIGERHASH_T1_RESULT="not_yet_set"
S_FUNC_MMMV_TIGERHASH_T1_MODE="" # optim. to skip repeating console tool selection
func_mmmv_tigerhash_t1() { # requires also ruby and gawk 
    local S_FP_2_AN_EXISTING_FILE="$1" # first function argument
    #--------
    local S_TMP_0 # declaration
    local S_TMP_1 # declaration
    func_mmmv_exc_hash_function_input_verification_t1 "func_mmmv_tigerhash_t1" "$1"
    #--------------------
    # Mode selection:
    if [ "$S_FUNC_MMMV_TIGERHASH_T1_MODE" == "" ] ; then
        SB_EXISTS_ON_PATH_T1_RESULT="f"  # if-block init
        #----
        if [ "$SB_EXISTS_ON_PATH_T1_RESULT" == "f" ] ; then
            S_TMP_0="tigerdeep" # usually available on Linux
            func_sb_exists_on_path_t1 "$S_TMP_0" 
            if [ "$SB_EXISTS_ON_PATH_T1_RESULT" == "t" ] ; then
                 S_FUNC_MMMV_TIGERHASH_T1_MODE="$S_TMP_0"
            fi
        fi
        #----
        if [ "$SB_EXISTS_ON_PATH_T1_RESULT" == "f" ] ; then
            S_TMP_0="rhash"    # part of the BSD package collection in 2016
            func_sb_exists_on_path_t1 "$S_TMP_0" 
            if [ "$SB_EXISTS_ON_PATH_T1_RESULT" == "t" ] ; then
                 S_FUNC_MMMV_TIGERHASH_T1_MODE="$S_TMP_0"
            fi
        fi
        #--------
        if [ "$S_FUNC_MMMV_TIGERHASH_T1_MODE" == "" ] ; then
            echo ""
            echo "All of the Tiger hash implementations that this script " 
            echo "is capable of using (tigerdeep, rhash) "
            echo "are missing from the PATH."
            echo "GUID=='4a5a0972-33b0-4a3e-85b0-21b170e031e7'"
            echo ""
            #----
            cd $S_FP_ORIG
            exit 1 # exit with error
        fi
        #--------
        if [ "$?" != "0" ]; then
            echo ""
            echo "This script is flawed."
            echo "GUID=='0e25c336-4bfb-418c-b3b0-21b170e031e7'"
            echo ""
            #----
            cd $S_FP_ORIG
            exit 1 # exit with error
        fi
        #--------
        func_sb_exists_on_path_t1 "ruby" 
        if [ "$SB_EXISTS_ON_PATH_T1_RESULT" == "f" ] ; then
            echo ""
            echo "\"ruby\" is missing from the PATH, but "
            echo "this function requires that it is on the PATH."
            echo "GUID=='3d1720a3-e2e7-4308-93b0-21b170e031e7'"
            echo ""
            #----
            cd $S_FP_ORIG
            exit 1 # exit with error
        fi
        #--------
        if [ "$?" != "0" ]; then
            echo ""
            echo "This script is flawed."
            echo "GUID=='53d96e4d-682c-4075-b6b0-21b170e031e7'"
            echo ""
            #----
            cd $S_FP_ORIG
            exit 1 # exit with error
        fi
        #--------
    fi
    #--------------------
    S_FUNC_MMMV_TIGERHASH_T1_RESULT=""
    #--------------------
    if [ "$S_FUNC_MMMV_TIGERHASH_T1_MODE" == "tigerdeep" ]; then
        S_TMP_0="`tigerdeep $S_FP_2_AN_EXISTING_FILE 2>/dev/null`"
        if [ "$?" != "0" ]; then
            echo ""
            echo "The console application \"tigerdeep\" "
            echo "exited with an error."
            echo ""
            echo "----console--output--citation--start-----"
            echo "`tigerdeep $S_FP_2_AN_EXISTING_FILE`" # stdout and stderr
            echo "----console--output--citation--end-------"
            echo ""
            echo "GUID=='3a31f72a-5ba0-4922-82b0-21b170e031e7'"
            echo ""
            #----
            cd $S_FP_ORIG
            exit 1 # exit with error
        fi
        # The "tigerdeep" returns a single line that has the format of 
        #
        #     <the hash> <path to the file>
        #
        # The following line is to pick the first column from that line.
        S_FUNC_MMMV_TIGERHASH_T1_RESULT="`ruby -e \"print(ARGV[0]);\" $S_TMP_0`"
    fi
    #--------------------
    if [ "$S_FUNC_MMMV_TIGERHASH_T1_MODE" == "rhash" ]; then
        S_TMP_0="`rhash --tiger $S_FP_2_AN_EXISTING_FILE 2>/dev/null`"
        if [ "$?" != "0" ]; then
            echo ""
            echo "The console application \"rhash\" "
            echo "exited with an error."
            echo ""
            echo "----console--output--citation--start-----"
            echo "`rhash --tiger $S_FP_2_AN_EXISTING_FILE `"
            echo "----console--output--citation--end-------"
            echo ""
            echo "GUID=='f24b6a22-a08c-447a-adb0-21b170e031e7'"
            echo ""
            #----
            cd $S_FP_ORIG
            exit 1 # exit with error
        fi
        S_FUNC_MMMV_TIGERHASH_T1_RESULT="`ruby -e \"print(ARGV[0]);\" $S_TMP_0`"
    fi
    #--------------------
    # The reason, why everything is done with ruby at the next 
    # Bash assignment clause is that the "wc -m" pads its output
    # with spaces on BSD.
    S_TMP_0="`ruby -e \"print(ARGV[0].to_s.length.to_s);\" $S_FUNC_MMMV_TIGERHASH_T1_RESULT `"
    #--------
    S_TMP_1="48"
    if [ "$S_TMP_0" != "$S_TMP_1" ]; then
        echo ""
        echo "According to the specification of the Tiger hash algorithm"
        echo "the length of the Tiger hash is "
        echo "$S_TMP_1 hexadecimal characters, but the result of the "
        echo ""
        echo "    func_mmmv_tigerhash_t1"
        echo ""
        echo "is something else. The flawed hash candidate in parenthesis:"
        echo "($S_FUNC_MMMV_TIGERHASH_T1_RESULT)"
        echo ""
        echo "The length candidate of the flawed hash candidate in parenthesis:"
        echo "($S_TMP_0)."
        echo ""
        echo "GUID=='b413bb3c-8911-47e7-b1a0-21b170e031e7'"
        echo ""
        #----
        cd $S_FP_ORIG
        exit 1 # exit with error
    fi
    #--------------------
} # func_mmmv_tigerhash_t1


#--------------------------------------------------------------------------

S_FUNC_MMMV_WHIRLPOOLHASH_T1_RESULT="not_yet_set"
S_FUNC_MMMV_WHIRLPOOLHASH_T1_MODE="" # optim. to skip repeating console tool selection
func_mmmv_whirlpoolhash_t1() { # requires also ruby and gawk 
    local S_FP_2_AN_EXISTING_FILE="$1" # first function argument
    #--------
    func_mmmv_exc_hash_function_input_verification_t1 "func_mmmv_whirlpoolhash_t1" "$1"
    #--------------------
    # Mode selection:
    if [ "$S_FUNC_MMMV_WHIRLPOOLHASH_T1_MODE" == "" ] ; then
        SB_EXISTS_ON_PATH_T1_RESULT="f"  # if-block init
        #----
        if [ "$SB_EXISTS_ON_PATH_T1_RESULT" == "f" ] ; then
            S_TMP_0="whirlpooldeep" # usually available on Linux
            func_sb_exists_on_path_t1 "$S_TMP_0" 
            if [ "$SB_EXISTS_ON_PATH_T1_RESULT" == "t" ] ; then
                 S_FUNC_MMMV_WHIRLPOOLHASH_T1_MODE="$S_TMP_0"
            fi
        fi
        #----
        if [ "$SB_EXISTS_ON_PATH_T1_RESULT" == "f" ] ; then
            S_TMP_0="rhash"    # part of the BSD package collection in 2016
            func_sb_exists_on_path_t1 "$S_TMP_0" 
            if [ "$SB_EXISTS_ON_PATH_T1_RESULT" == "t" ] ; then
                 S_FUNC_MMMV_WHIRLPOOLHASH_T1_MODE="$S_TMP_0"
            fi
        fi
        #--------
        if [ "$S_FUNC_MMMV_WHIRLPOOLHASH_T1_MODE" == "" ] ; then
            echo ""
            echo "All of the Whirlpool hash implementations that this script " 
            echo "is capable of using (whirlpooldeep, rhash) "
            echo "are missing from the PATH."
            echo "GUID=='3f740226-1e7e-4cf3-81a0-21b170e031e7'"
            echo ""
            #----
            cd $S_FP_ORIG
            exit 1 # exit with error
        fi
        #--------
        if [ "$?" != "0" ]; then
            echo ""
            echo "This script is flawed."
            echo "GUID=='df392514-316e-4ff6-94a0-21b170e031e7'"
            echo ""
            #----
            cd $S_FP_ORIG
            exit 1 # exit with error
        fi
        #--------
    fi
    #--------------------
    S_FUNC_MMMV_WHIRLPOOLHASH_T1_RESULT=""
    #--------------------
    if [ "$S_FUNC_MMMV_WHIRLPOOLHASH_T1_MODE" == "whirlpooldeep" ]; then
        S_TMP_0="`whirlpooldeep $S_FP_2_AN_EXISTING_FILE 2>/dev/null`"
        if [ "$?" != "0" ]; then
            echo ""
            echo "The console application \"whirlpooldeep\" "
            echo "exited with an error."
            echo ""
            echo "----console--output--citation--start-----"
            echo "`whirlpooldeep $S_FP_2_AN_EXISTING_FILE`" # stdout and stderr
            echo "----console--output--citation--end-------"
            echo ""
            echo "GUID=='63fc0642-9757-4781-85a0-21b170e031e7'"
            echo ""
            #----
            cd $S_FP_ORIG
            exit 1 # exit with error
        fi
        S_FUNC_MMMV_WHIRLPOOLHASH_T1_RESULT="`ruby -e \"print(ARGV[0]);\" $S_TMP_0 `"
    fi
    #--------------------
    if [ "$S_FUNC_MMMV_WHIRLPOOLHASH_T1_MODE" == "rhash" ]; then
        S_TMP_0="`rhash --whirlpool $S_FP_2_AN_EXISTING_FILE 2>/dev/null`"
        if [ "$?" != "0" ]; then
            echo ""
            echo "The console application \"rhash\" "
            echo "exited with an error."
            echo ""
            echo "----console--output--citation--start-----"
            echo "`rhash --whirlpool $S_FP_2_AN_EXISTING_FILE `"
            echo "----console--output--citation--end-------"
            echo ""
            echo "GUID=='e8f4bcc9-b30d-4b8b-a5a0-21b170e031e7'"
            echo ""
            #----
            cd $S_FP_ORIG
            exit 1 # exit with error
        fi
        S_FUNC_MMMV_WHIRLPOOLHASH_T1_RESULT="`ruby -e \"print(ARGV[0]);\" $S_TMP_0 `"
    fi
    #--------------------
    # The reason, why everything is done with ruby at the next 
    # Bash assignment clause is that the "wc -m" pads its output
    # with spaces on BSD.
    S_TMP_0="`ruby -e \"print(ARGV[0].to_s.length.to_s);\" $S_FUNC_MMMV_WHIRLPOOLHASH_T1_RESULT `"
    #--------
    S_TMP_1="128"
    if [ "$S_TMP_0" != "$S_TMP_1" ]; then
        echo ""
        echo "According to the specification of the Whirlpool hash algorithm"
        echo "the length of the Tiger hash is "
        echo "$S_TMP_1 hexadecimal characters, but the result of the "
        echo ""
        echo "    func_mmmv_whirlpoolhash_t1"
        echo ""
        echo "is something else. The flawed hash candidate in parenthesis:"
        echo "($S_FUNC_MMMV_WHIRLPOOLHASH_T1_RESULT)"
        echo ""
        echo "The length candidate of the flawed hash candidate in parenthesis:"
        echo "($S_TMP_0)."
        echo ""
        echo "GUID=='4615c816-fb53-4a2f-b5a0-21b170e031e7'"
        echo ""
        #----
        cd $S_FP_ORIG
        exit 1 # exit with error
    fi
    #--------------------
} # func_mmmv_whirlpoolhash_t1


#--------------------------------------------------------------------------

S_FUNC_MMMV_FILESIZE_T1_RESULT="not_yet_set"
S_FUNC_MMMV_FILESIZE_T1_MODE="" # optim. to skip repeating console tool selection
func_mmmv_filesize_t1() { 
    local S_FP_2_AN_EXISTING_FILE="$1" # first function argument
    #--------
    func_mmmv_exc_hash_function_input_verification_t1 "func_mmmv_filesize_t1" "$1"
    #--------------------
    # Mode selection:
    if [ "$S_FUNC_MMMV_FILESIZE_T1_MODE" == "" ] ; then
        SB_EXISTS_ON_PATH_T1_RESULT="f"  # if-block init
        #----
        if [ "$SB_EXISTS_ON_PATH_T1_RESULT" == "f" ] ; then
            S_TMP_0="filesize" # usually available on Linux
            func_sb_exists_on_path_t1 "$S_TMP_0" 
            if [ "$SB_EXISTS_ON_PATH_T1_RESULT" == "t" ] ; then
                 S_FUNC_MMMV_FILESIZE_T1_MODE="$S_TMP_0"
            fi
        fi
        #----
        if [ "$SB_EXISTS_ON_PATH_T1_RESULT" == "f" ] ; then
            S_TMP_0="ruby"    # helps on BSD
            func_sb_exists_on_path_t1 "$S_TMP_0" 
            if [ "$SB_EXISTS_ON_PATH_T1_RESULT" == "t" ] ; then
                 S_FUNC_MMMV_FILESIZE_T1_MODE="$S_TMP_0"
            fi
        fi
        #--------
        if [ "$S_FUNC_MMMV_FILESIZE_T1_MODE" == "" ] ; then
            echo ""
            echo "All of the applications that this function is " 
            echo "capable of using for finding out file size (filesize, ruby)"
            echo "are missing from the PATH."
            echo "GUID=='c2086757-332a-4965-b2a0-21b170e031e7'"
            echo ""
            #----
            cd $S_FP_ORIG
            exit 1 # exit with error
        fi
        #--------
        if [ "$?" != "0" ]; then
            echo ""
            echo "This script is flawed."
            echo "GUID=='3e3d3e21-3aee-4aa4-91a0-21b170e031e7'"
            echo ""
            #----
            cd $S_FP_ORIG
            exit 1 # exit with error
        fi
        #--------
    fi
    #--------------------
    S_FUNC_MMMV_FILESIZE_T1_RESULT=""
    #--------------------
    if [ "$S_FUNC_MMMV_FILESIZE_T1_MODE" == "filesize" ]; then
        S_TMP_0="`filesize $S_FP_2_AN_EXISTING_FILE 2>/dev/null`"
        if [ "$?" != "0" ]; then
            echo ""
            echo "The console application \"filesize\" "
            echo "exited with an error."
            echo ""
            echo "----console--output--citation--start-----"
            echo "`filesize $S_FP_2_AN_EXISTING_FILE`" # stdout and stderr
            echo "----console--output--citation--end-------"
            echo ""
            echo "GUID=='f72b001d-c581-426a-9590-21b170e031e7'"
            echo ""
            #----
            cd $S_FP_ORIG
            exit 1 # exit with error
        fi
        S_FUNC_MMMV_FILESIZE_T1_RESULT="`ruby -e \"print(ARGV[0]);\" $S_TMP_0 `"
    fi
    #--------------------
    if [ "$S_FUNC_MMMV_FILESIZE_T1_MODE" == "ruby" ]; then
        S_TMP_0="`ruby -e \"printf(File.size('$S_FP_2_AN_EXISTING_FILE').to_s)\" 2>/dev/null`"
        if [ "$?" != "0" ]; then
            echo ""
            echo "The console application \"ruby\" "
            echo "exited with an error."
            echo ""
            echo "----console--output--citation--start-----"
            echo "`ruby -e \"printf(File.size('$S_FP_2_AN_EXISTING_FILE').to_s)\"`"
            echo "----console--output--citation--end-------"
            echo ""
            echo "GUID=='3384863e-c0a1-4927-8590-21b170e031e7'"
            echo ""
            #----
            cd $S_FP_ORIG
            exit 1 # exit with error
        fi
        S_FUNC_MMMV_FILESIZE_T1_RESULT="$S_TMP_0"
    fi
    #--------------------
    S_TMP_0="`ruby -e \"print((''+ARGV[0]).gsub(/[\s]+/,''));\" $S_FUNC_MMMV_FILESIZE_T1_RESULT `"
    local SB_THROW="f"
    if [ "$S_TMP_0" != "$S_FUNC_MMMV_FILESIZE_T1_RESULT" ]; then
        SB_THROW="t"
    else
        if [ "$S_FUNC_MMMV_FILESIZE_T1_RESULT" == "" ]; then
            SB_THROW="t"
        fi
    fi
    #----
    if [ "$SB_THROW" == "t" ]; then
        echo ""
        echo "The result of the "
        echo ""
        echo "    func_mmmv_filesize_t1"
        echo ""
        echo "for "
        echo ""
        echo "($S_FUNC_MMMV_FILESIZE_T1_RESULT)"
        echo ""
        echo "either contain spaces, tabs or is an empty string," 
        echo "which is wrong, because even a file with the size of 0 "
        echo "should have a file size of \"0\", which is not an empty string."
        echo "GUID=='4a133b5e-c7bd-4cb1-a590-21b170e031e7'"
        echo ""
        #----
        cd $S_FP_ORIG
        exit 1 # exit with error
    fi
    #--------------------
} # func_mmmv_filesize_t1


#--------------------------------------------------------------------------

func_mmmv_silktorrent_packager_t1_bash_print_help_msg_t1() { 
    echo ""
    echo "Command line format: "
    echo ""
    echo "<the name of this script>  ARGLIST "
    echo ""
    echo "  ARGLIST :== help | WRAP | UNWRAP | RUN_SELFTEST | VERIFY |"
    echo "              VERIFY_PACKET_NAME_FORMAT_V1 | version | version_timestamp "
    echo ""
    echo "                   WRAP :== wrap         <file path> (N_OF_RANDOM_TEXT_BLOCKS)?"
    echo "N_OF_RANDOM_TEXT_BLOCKS :==                           <positive whole number> "
    echo ""
    echo "                 UNWRAP :== unwrap       <file path> "
    echo "           RUN_SELFTEST :== test_hash_t1 <file path> "
    echo "                 VERIFY :== verify       <file path> "
    echo ""
    echo "  VERIFY_PACKET_NAME_FORMAT_V1 :== verify_packet_name_format_v1 X<packet name "
    echo "                                                                 candidate string>X"
    echo ""
    echo ""
    echo "If this API is used correctly and there are no other "
    echo "reasons for the failure of this script, then "
    echo "all of the verification commands exit with error code 0 "
    echo "regardless of whether the verification fails or passes."
    echo "All verification commands return a string that "
    echo "belongs to the set {\"verification_passed\", "
    echo "                    \"verification_failed\"}."
    echo ""
    echo "If the working directory contains a folder named \"custom_headers\" and "
    echo "that folder is recursively readable/copyable, then the command \"wrap\" "
    echo "adds that folder to the header folder of the newly created Silktorrent packet."
    echo "If there is a failure at the recursive copying of the \"custom_headers\", "
    echo "then this script exits with a non-0 error code "
    echo "before the Silktorrent packet is created."
    echo ""
    echo ""
} # func_mmmv_silktorrent_packager_t1_bash_print_help_msg_t1

#--------------------------------------------------------------------------

func_mmmv_silktorrent_packager_t1_bash_exc_assert_wrappable_file_exists_t1() { 
    local S_FP_0="$1" # Path to the file. 
    #--------
    if [ "$S_FP_0" == "" ]; then
        echo ""
        echo "The 2. console argument is expected to be "
        echo "a path to a file, but currently "
        echo "the 2. console argument is missing."
        echo "GUID=='7a6f5f3f-e5a5-4413-a490-21b170e031e7'"
        echo ""
        #----
        cd $S_FP_ORIG
        exit 1 # exit with error
    fi
    #--------
    if [ ! -e "$S_FP_0" ]; then
        if [ -h "$S_FP_0" ]; then
            echo ""
            echo "The file path "
            echo ""
            echo "    $S_FP_0"
            echo ""
            echo "is a path of a broken symlink, but symlinks "
            echo "are not supported at all."
            echo "The reason, why symlinks to files are not supported is that "
            echo "the file size of symlinks can differ from "
            echo "the file size of the target of the symlink."
            echo "GUID=='bcfe8e4b-9c8c-4ea4-8390-21b170e031e7'"
            echo ""
        else
            echo ""
            echo "The file with the path of "
            echo ""
            echo "    $S_FP_0"
            echo ""
            echo "does not exist."
            echo "GUID=='2db4b292-d5d5-4286-8190-21b170e031e7'"
            echo ""
        fi
        #----
        cd $S_FP_ORIG
        exit 1 # exit with error
    fi
    #--------
    if [ -d "$S_FP_0" ]; then
        if [ -h "$S_FP_0" ]; then
            echo ""
            echo "The path "
            echo ""
            echo "    $S_FP_0"
            echo ""
            echo "references a symlink that references folder, but "
            echo "a file is expected."
            echo "GUID=='03516057-64fc-4913-8190-21b170e031e7'"
            echo ""
        else
            echo ""
            echo "The path "
            echo ""
            echo "    $S_FP_0"
            echo ""
            echo "references a folder, but it is expected to "
            echo "to reference a file."
            echo "GUID=='221d8e2b-c10b-42b9-a480-21b170e031e7'"
            echo ""
        fi
        #----
        cd $S_FP_ORIG
        exit 1 # exit with error
    fi
    #--------
    if [ -h "$S_FP_0" ]; then
        echo ""
        echo "The path "
        echo ""
        echo "    $S_FP_0"
        echo ""
        echo "references a symlink, a file is expected."
        echo "The reason, why symlinks to files are not supported is that "
        echo "the file size of symlinks can differ from "
        echo "the file size of the target of the symlink."
        echo "GUID=='4556d523-1e93-49f8-9380-21b170e031e7'"
        echo ""
        #----
        cd $S_FP_ORIG
        exit 1 # exit with error
    fi
} # func_mmmv_silktorrent_packager_t1_bash_exc_assert_wrappable_file_exists_t1


#--------------------------------------------------------------------------

func_mmmv_silktorrent_packager_t1_bash_exc_assert_packet_name_candidate_exists_t1() { 
    local S_FP_0="$1" # Path to the file. 
    #--------
    if [ "$S_FP_0" == "" ]; then
        echo ""
        echo "The 2. console argument is expected to be "
        echo "a Silktorrent packet name candidate, but currently "
        echo "the 2. console argument is missing."
        echo "GUID=='9dd80125-f4b8-40c5-b180-21b170e031e7'"
        echo ""
        #----
        cd $S_FP_ORIG
        exit 1 # exit with error
    fi
} # func_mmmv_silktorrent_packager_t1_bash_exc_assert_packet_name_candidate_exists_t1


#--------------------------------------------------------------------------

S_FUNC_MMMV_SILKTORRENT_PACKAGER_T1_BASH_REVERSE_STRING_REGISTER="for input and output"
S_FUNC_MMMV_SILKTORRENT_PACKAGER_T1_BASH_REVERSE_STRING_MODE="" # optim.  hack
func_mmmv_silktorrent_packager_t1_bash_reverse_string() { 
    local S_IN="$S_FUNC_MMMV_SILKTORRENT_PACKAGER_T1_BASH_REVERSE_STRING_REGISTER"
    #--------------------
    local S_TMP_0="" # declaration
    # Mode selection:
    if [ "$S_FUNC_MMMV_SILKTORRENT_PACKAGER_T1_BASH_REVERSE_STRING_MODE" == "" ] ; then
        SB_EXISTS_ON_PATH_T1_RESULT="f"  # if-block init
        #----
        if [ "$SB_EXISTS_ON_PATH_T1_RESULT" == "f" ] ; then
            S_TMP_0="ruby"    # helps on BSD
            func_sb_exists_on_path_t1 "$S_TMP_0" 
            if [ "$SB_EXISTS_ON_PATH_T1_RESULT" == "t" ] ; then
                 S_FUNC_MMMV_SILKTORRENT_PACKAGER_T1_BASH_REVERSE_STRING_MODE="$S_TMP_0"
            fi
        fi
        #--------
        if [ "$S_FUNC_MMMV_SILKTORRENT_PACKAGER_T1_BASH_REVERSE_STRING_MODE" == "" ] ; then
            echo ""
            echo "All of the applications that this function is " 
            echo "capable of using for reversing a string(ruby)"
            echo "are missing from the PATH."
            echo "GUID=='bc77b41d-6478-4e1a-9380-21b170e031e7'"
            echo ""
            #----
            cd $S_FP_ORIG
            exit 1 # exit with error
        fi
        #--------
        if [ "$?" != "0" ]; then
            echo ""
            echo "This script is flawed."
            echo "GUID=='4f324635-b98e-4198-a780-21b170e031e7'"
            echo ""
            #----
            cd $S_FP_ORIG
            exit 1 # exit with error
        fi
        #--------
    fi
    #--------------------
    S_FUNC_MMMV_SILKTORRENT_PACKAGER_T1_BASH_REVERSE_STRING_REGISTER=""
    #--------
    if [ "$S_FUNC_MMMV_SILKTORRENT_PACKAGER_T1_BASH_REVERSE_STRING_MODE" == "ruby" ]; then
        #----
        S_TMP_0="`ruby -e \"puts(ARGV[0].to_s.reverse)\" "$S_IN" 2>/dev/null`"
        if [ "$?" != "0" ]; then
            echo ""
            echo "The console application \"ruby\" "
            echo "exited with an error."
            echo ""
            echo "----console--output--citation--start-----"
            echo "`ruby -e \"puts('$S_IN'.reverse)\"`" # with the stderr
            echo "----console--output--citation--end-------"
            echo ""
            echo "GUID=='ccd82816-37c5-405c-823f-21b170e031e7'"
            echo ""
            #----
            cd $S_FP_ORIG
            exit 1 # exit with error
        fi
        S_FUNC_MMMV_SILKTORRENT_PACKAGER_T1_BASH_REVERSE_STRING_REGISTER="$S_TMP_0"
    fi
    #--------------------
} # func_mmmv_silktorrent_packager_t1_bash_reverse_string


#--------------------------------------------------------------------------

# As of 2016 the maximum file name length on Linux is 255 characters.
# At
#
#    http://unix.stackexchange.com/questions/32795/what-is-the-maximum-allowed-filename-and-folder-size-with-ecryptfs
#
# the eCryptfs related recommendation is to keep the lengths
# of file names to less than 140 characters. 
#
# A citation from 
# http://windows.microsoft.com/en-us/windows/file-names-extensions-faq#1TC=windows-7
# archival copy: https://archive.is/UKBmd
#     "Windows limits a single path to 260 characters."
#
# A citation from CygWin mailing list:
# https://cygwin.com/ml/cygwin/2004-10/msg01323.html
# archival copy: https://archive.is/GRvFK
#     "The Unicode versions of several functions permit a 
#     maximum path length of 32,767 characters, 
#     composed of components up to 255 characters in length. 
#     To specify such a path, use the "\\?\" prefix. For example, 
#     "\\?\D:\<path>". To specify such a UNC path, use the "\\?\UNC\" 
#     prefix. For example, "\\?\UNC\<server>\<share>". 
#     Note that these prefixes are not used as part of the path 
#     itself. They indicate that the path should be passed to the 
#     system with minimal modification. An implication of this is 
#     that you cannot use forward slashes to represent path separators 
#     or a period to represent the current directory."
# Related pages:
# https://msdn.microsoft.com/en-us/library/aa365247(VS.85).aspx
# archival copy: https://archive.is/p891y
#
# To allow database indexes that store the 
# file names of the blogs 
# to work as efficiently as possible, the first
# characters of the file name should be as 
# uniformly random set of characters as possible.
# If file name starts with a secure hash, then 
# that requirement is met. 
#
# The parser that dismantles the file name to relevant components 
# should be implementable in different programming languages
# without investing considerable amount of development time.
# The syntax of the file name should also allow the
# file name to be parsed computationally cheaply.
#
# As of 2016_05 the file extension  .stblob seems to be unused.
# Therefore the "silktorrent blob", .stblob, can be used for the 
# extension of the blob files.
#
# Compression of the blobs IS NOT ALLOWED, because the 
# blobs must be extractable without becoming a victim 
# of an attack, where 100GiB of zeros is packed to a
# small file. The container format is the tar format,
# without any compression.
S_FUNC_MMMV_SILKTORRENT_PACKAGER_T1_BASH_BLOB2FILENAME_T1_RESULT="not set"
func_mmmv_silktorrent_packager_t1_bash_blob2filename_t1() { 
    local S_FP_0="$1" # Path to the file. 
    #----
    func_mmmv_silktorrent_packager_t1_bash_exc_assert_wrappable_file_exists_t1 "$S_FP_0"
    #--------
    # The Tiger     hash has  48 characters.
    # The Whirlpool hash has 128 characters.
    # The SHA-256   hash has  64 characters.
    #
    # A file size of 1TiB is ~10^12 ~ 13 characters
    # A file size of 1PiB is ~10^15 ~ 14 characters
    # A file size of 1EiB is ~10^18 ~ 19 characters
    # A file size of 1ZiB is ~10^21 ~ 22 characters
    # A file size of 1YiB is ~10^24 ~ 25 characters
    # 
    # The max. file name length on Linux and 
    # Windows (Unicode API) is 255 characters.
    #----
    # The character budget:
    #        6 characters --- file name format type ID 
    #                         rgx_in_ruby=/v[\d]{4}[_]/
    # echo "v0034_s2342_" | gawk '{ gsub(/_/, "_\n"); print }' | \
    #                       gawk '/^v[0-9]{4}_/ {printf "%s",$1 }' | \
    #                       gawk '{gsub(/[v_]/,"");printf "%s", $1 }'
    #
    #   max 32 characters --- file size    
    #                         rgx_in_ruby=/s[\d]+[_]/
    #                         echo "v0034_" | gawk '/^v[0-9]{4}_/ {printf "%s",$1 }'
    # echo "v0034_s2342_" | gawk '{ gsub(/_/, "_\n"); print }' | \
    #                       gawk '/^s[0-9]+_/ {printf "%s",$1 }' | \
    #                       gawk '{gsub(/[s_]/,"");printf "%s", $1 }'
    #
    #
    #       66 characters --- SHA-256  
    #                         rgx_in_ruby=/h[\dabcdef]{64}[_]/
    # echo "h`sha256sum /dev/null | gawk '/[0-9abcdef]/ {printf "%s",$1}'`_" | \
    #                               gawk '/^h[0-9abcdef]+_/ {printf "%s",$1 }' | \
    #                               gawk '{gsub(/[h_]/,"");printf "%s", $1 }'
    #
    #
    #       50 characters --- Tiger
    #                         rgx_in_ruby=/i[\dabcdef]{48}$/   # lacks the ending "_" 
    #                                                          # for db index optimization
    #                         The gawk code is as with the sha256, 
    #                         except that sha256sum-> tigerdeep, "^h"->"^i",
    #                         "[h_]"->"[i_]"
    #
    #--------
    # As the current version of this script depends on Ruby anyway,
    # the gawk regex based branches that are really
    # complex and require multiple gawk calls can be left unimplemented.
    # That way this script becomes more succinct.
    #--------------------
    func_mmmv_tigerhash_t1 "$S_FP_0"
    #echo "       Tiger: $S_FUNC_MMMV_TIGERHASH_T1_RESULT"
    #func_mmmv_whirlpoolhash_t1 "$S_FP_0"
    #echo "   Whirlpool: $S_FUNC_MMMV_WHIRLPOOLHASH_T1_RESULT"
    func_mmmv_sha256_t1 "$S_FP_0"
    #echo "      SHA256: $S_FUNC_MMMV_SHA256_T1_RESULT"
    func_mmmv_filesize_t1 "$S_FP_0"
    #echo "   file size: $S_FUNC_MMMV_FILESIZE_T1_RESULT"
    #--------
    local S_NAME_REVERSED="bolbts." # ".stblob".reverse
    local S_0="v0001_s$S_FUNC_MMMV_FILESIZE_T1_RESULT"
    S_NAME_REVERSED="$S_NAME_REVERSED$S_0"
    S_0="_h$S_FUNC_MMMV_SHA256_T1_RESULT"
    S_NAME_REVERSED="$S_NAME_REVERSED$S_0"
    S_0="_i$S_FUNC_MMMV_TIGERHASH_T1_RESULT"
    S_NAME_REVERSED="$S_NAME_REVERSED$S_0"
    #----
    S_FUNC_MMMV_SILKTORRENT_PACKAGER_T1_BASH_REVERSE_STRING_REGISTER="$S_NAME_REVERSED"
    func_mmmv_silktorrent_packager_t1_bash_reverse_string
    S_0="$S_FUNC_MMMV_SILKTORRENT_PACKAGER_T1_BASH_REVERSE_STRING_REGISTER"
    S_FUNC_MMMV_SILKTORRENT_PACKAGER_T1_BASH_BLOB2FILENAME_T1_RESULT="$S_0"
} # func_mmmv_silktorrent_packager_t1_bash_blob2filename_t1


#--------------------------------------------------------------------------

func_mmmv_delete_tmp_folder_t1(){
    local S_FP_0="$1" # folder path
    #--------
    if [ ! -e "$S_FP_0" ]; then
        echo ""
        echo "This script is flawed. The folder "
        echo "    $S_FP_0"
        echo "is expected to exist during the "
        echo "call to this function."
        echo "GUID=='2e447df2-5321-4928-b73f-21b170e031e7'"
        echo ""
        #----
        cd $S_FP_ORIG
        exit 1 # exit with error
    fi
    #--------
    # To avoid a situation, where due to some 
    # flaw the home folder or something else important 
    # gets accidentally recursively deleted, 
    # the following test transforms the path from 
    # /tmp/../home/blabla
    # to a full path without the dots and then studies, whether
    # the full path points to somewhere in the /tmp
    local S_FP_1="`cd $S_FP_0; pwd`"
    if [ ! -e "$S_FP_1" ]; then
        echo ""
        echo "This script is flawed. The folder "
        echo "    $S_FP_1"
        echo "is missing."
        echo "GUID=='6aab1d10-8e8a-477c-b23f-21b170e031e7'"
        echo ""
        #----
        cd $S_FP_ORIG
        exit 1 # exit with error
    fi
    local S_TMP_0="`echo \"$S_FP_1\" | grep -E ^/home `"
    if [ "$S_TMP_0" != "" ]; then
        echo ""
        echo "This script is flawed."
        echo "The temporary sandbox folder must reside in /tmp."
        echo ""
        echo "S_FP_0==$S_FP_0"
        echo ""
        echo "S_FP_1==$S_FP_1"
        echo ""
        echo "S_TMP_0==$S_TMP_0"
        echo ""
        echo "GUID=='e1050d4e-34fd-46c0-b42f-21b170e031e7'"
        echo ""
        #----
        cd $S_FP_ORIG
        exit 1 # exit with error
    fi
    # Just to be sure, the same thing is checked by a slightly 
    # different regex and using the "==" in stead of the "!=".
    S_TMP_0="`echo \"$S_FP_1\" | grep -E ^/tmp/`" 
    if [ "$S_TMP_0" == "" ]; then
        echo ""
        echo "This script is flawed."
        echo "The temporary sandbox folder must reside in /tmp."
        echo ""
        echo "S_FP_0==$S_FP_0"
        echo ""
        echo "S_FP_1==$S_FP_1"
        echo ""
        echo "S_TMP_0==$S_TMP_0"
        echo ""
        echo "GUID=='5b136271-52e5-4c30-812f-21b170e031e7'"
        echo ""
        #----
        cd $S_FP_ORIG
        exit 1 # exit with error
    fi
    #--------
    rm -fr $S_FP_1
    if [ -e "$S_FP_1" ]; then
        echo ""
        echo "Something went wrong. The recursive deletion of the temporary folder, "
        echo "    $S_FP_1"
        echo "failed."
        echo "GUID=='40f04834-df5a-4bff-822f-21b170e031e7'"
        echo ""
        #----
        cd $S_FP_ORIG
        exit 1 # exit with error
    fi
} # func_mmmv_delete_tmp_folder_t1


#--------------------------------------------------------------------------

# Throws, if there exists a file with the same path.
func_mmmv_create_folder_if_it_does_not_already_exist_t1(){
    local S_FP_0="$1" # folder path
    #--------
    if [ "$S_FP_0" == "" ]; then
        # Using gawk and alike to cover also cases, where
        # $S_FP_0=="  "
        # is intentionally left out to avoid the overhead, but
        # due to some luck the mkdir exits with an error code greater than 0,
        # if it misses a path argument. 
        echo ""
        echo "S_FP_0==\"\""
        echo "GUID=='110c6012-b75d-4c23-832f-21b170e031e7'"
        echo ""
        #----
        cd $S_FP_ORIG
        exit 1 # exit with error
    fi
    #--------------------
    if [ -e "$S_FP_0" ]; then
        if [ ! -d "$S_FP_0" ]; then
            echo ""
            echo "The path that is suppose to reference either "
            echo "an existing folder or a non-existent folder, "
            echo "references a file."
            echo "GUID=='065bb01e-c77c-4f67-912f-21b170e031e7'"
            echo ""
            #----
            cd $S_FP_ORIG
            exit 1 # exit with error
        fi
    fi
    #--------
    mkdir -p $S_FP_0
    if [ "$?" != "0" ]; then 
        echo ""
        echo "mkdir for path "
        echo "    $S_FP_0"
        echo "failed."
        echo "GUID=='11ea94b4-e5a9-4891-a61f-21b170e031e7'"
        echo ""
        #----
        cd $S_FP_ORIG
        exit 1 # exit with error
    fi
    #----
    if [ ! -e "$S_FP_0" ]; then
        echo ""
        echo "mkdir execution succeeded, but for some other reason the folder "
        echo "    $S_FP_0"
        echo "does not exist."
        echo "GUID=='9ae79e10-eaae-4233-951f-21b170e031e7'"
        echo ""
        #----
        cd $S_FP_ORIG
        exit 1 # exit with error
    fi
} # func_mmmv_create_folder_if_it_does_not_already_exist_t1


#--------------------------------------------------------------------------

S_FUNC_FUNC_MMMV_CREATE_TMP_FOLDER_T1_RESULT="" # == "" on failure
                                                # otherwise full file path
func_mmmv_create_tmp_folder_t1(){
    # Does not take any arguments.
    #--------
    #func_mmmv_exc_hash_function_input_verification_t1 "func_mmmv_GUID_t1" "$1"
    #--------------------
    S_FUNC_FUNC_MMMV_CREATE_TMP_FOLDER_T1_RESULT="" # value for failure
    func_mmmv_GUID_t1
    if [ "$S_FUNC_MMMV_GUID_T1_RESULT" == "" ]; then
        echo ""
        echo "This script is flawed. GUID generation failed and "
        echo "the GUID generation function did not throw despite "
        echo "the fact that it should have detected its own failure."
        echo "GUID=='9664b33c-7123-482b-b11f-21b170e031e7'"
        echo ""
        #----
        cd $S_FP_ORIG
        exit 1 # exit with error
    fi
    #----
    local S_TMP_0="/tmp/tmp_silktorrent_$S_FUNC_MMMV_GUID_T1_RESULT"
    # The following few if-clauses form a short unrolled loop. The unrolling 
    # is for simplicity, because it is Bash, where loops are nasty.
    if [ -e "$S_TMP_0" ]; then
        func_mmmv_GUID_t1
        S_TMP_0="/tmp/tmp_silktorrent_$S_FUNC_MMMV_GUID_T1_RESULT"
    fi
    if [ -e "$S_TMP_0" ]; then
        func_mmmv_GUID_t1
        S_TMP_0="/tmp/tmp_silktorrent_$S_FUNC_MMMV_GUID_T1_RESULT"
    fi
    if [ -e "$S_TMP_0" ]; then
        func_mmmv_GUID_t1
        S_TMP_0="/tmp/tmp_silktorrent_$S_FUNC_MMMV_GUID_T1_RESULT"
    fi
    if [ -e "$S_TMP_0" ]; then
        func_mmmv_GUID_t1
        S_TMP_0="/tmp/tmp_silktorrent_$S_FUNC_MMMV_GUID_T1_RESULT"
    fi
    #----
    if [ -e "$S_TMP_0" ]; then
        echo ""
        echo "This script failed to generate a locally unique path."
        echo "GUID=='20353ff1-ac7d-40be-b11f-21b170e031e7'"
        echo ""
        #----
        cd $S_FP_ORIG
        exit 1 # exit with error
    fi
    func_mmmv_create_folder_if_it_does_not_already_exist_t1 "$S_TMP_0"
    if [ ! -e "$S_TMP_0" ]; then
        echo ""
        echo "mkdir for path "
        echo "    $S_TMP_0"
        echo "failed."
        echo "GUID=='316a2a61-32e2-4a0e-811f-21b170e031e7'"
        echo ""
        #----
        cd $S_FP_ORIG
        exit 1 # exit with error
    fi
    S_FUNC_FUNC_MMMV_CREATE_TMP_FOLDER_T1_RESULT="$S_TMP_0"
} # func_mmmv_create_tmp_folder_t1 


#--------------------------------------------------------------------------

S_FUNC_MMMV_SILKTORRENT_PACKAGER_T1_BASH_GET_PACKET_FORMAT_VERSION_T1_RESULT="not set"
func_mmmv_silktorrent_packager_t1_bash_get_packet_format_version_t1() { 
    local S_FP_0="$1" # Path to the file. 
    #----
    # It's not necessary for the file to actually exist,
    # because this function only analyzes the file path string.
    # func_mmmv_silktorrent_packager_t1_bash_exc_assert_wrappable_file_exists_t1 "$S_FP_0"
    if [ "$S_FP_0" == "" ]; then
        echo ""
        echo "The file path candidate must not be an empty string."
        echo "GUID=='21e00e39-7bd1-4595-910f-21b170e031e7'"
        echo ""
        #----
        cd $S_FP_ORIG
        exit 1 # exit with error
    fi 
    #----
    # The 
    #
    #     basename /tmp/foo/
    #
    # returns
    #
    #     foo
    #
    # That is to say, the "basename" ignores the rightmost slash.
    #----
    local S_TMP_0="`ruby -e \"\
        s='noslash';\
        if(('$S_FP_0'.reverse)[0..0]=='/') then \
            s='slash_present';\
        end;\
        puts(s);\
        \"`"
    if [ "$S_TMP_0" != "noslash" ]; then
        echo ""
        echo "The path candidate must not end with a slash."
        echo ""
        echo "    S_FP_0==$S_FP_0"
        echo ""
        echo "    S_TMP_0==$S_TMP_0"
        echo ""
        echo "GUID=='b511aafc-7d2e-4f17-b50f-21b170e031e7'"
        echo ""
        #----
        cd $S_FP_ORIG
        exit 1 # exit with error
    fi
    basename $S_FP_0 1>/dev/null # to set a value to the $? in this scope 
    if [ "$?" != "0" ]; then
        echo ""
        echo "The command "
        echo ""
        echo "    basename $S_FP_0 "
        echo ""
        echo "exited with an error."
        echo "GUID=='d58ce8a5-65c5-4d43-950f-21b170e031e7'"
        echo ""
        #----
        cd $S_FP_ORIG
        exit 1 # exit with error
    fi 
    S_TMP_0="`basename $S_FP_0`"
    if [ "$S_TMP_0" == "" ]; then
        echo ""
        echo "The file path candidate must be a string that "
        echo "is not an empty string after "
        echo "all of the spaces and tabs have been removed from it."
        echo "GUID=='d0ad852c-39f9-49d6-910f-21b170e031e7'"
        echo ""
        #----
        cd $S_FP_ORIG
        exit 1 # exit with error
    fi 
    #--------
    S_FUNC_MMMV_SILKTORRENT_PACKAGER_T1_BASH_GET_PACKET_FORMAT_VERSION_T1_RESULT=""
    local S_OUT="unsupported_by_this_script_version"
    #--------
    # In Ruby
    #     "foo.stblob"[0..(-8)]=="foo"
    #     "foo.stblob"[(-99)..(-1)]==nil
    # 
    local S_TMP_1="`ruby -e \"\
        x='$S_TMP_0'[0..(-8)];\
        if(x!=nil) then\
            md=x.reverse.match(/v[\\d]+/);\
            if(md!=nil) then\
                s_0=(md[0].to_s)[1..(-1)];\
                print(s_0.sub(/^[0]+/,''));\
            end;\
        end;\
        \"`"
    # echo "$S_TMP_0"
    # echo "$S_TMP_1"
    #----
    if [ "$S_TMP_1" != "" ]; then
        S_OUT="silktorrent_packet_format_version_$S_TMP_1"
    fi 
    S_FUNC_MMMV_SILKTORRENT_PACKAGER_T1_BASH_GET_PACKET_FORMAT_VERSION_T1_RESULT="$S_OUT"
} # func_mmmv_silktorrent_packager_t1_bash_get_packet_format_version_t1


#--------------------------------------------------------------------------

S_FUNC_MMMV_SILKTORRENT_PACKAGER_T1_BASH_VERIFY_FILE_NAME_T1_RESULT="not set"
func_mmmv_silktorrent_packager_t1_bash_verify_file_name_t1() { 
    local S_FP_0="$1" # Path to the file. 
    #----
    func_mmmv_silktorrent_packager_t1_bash_exc_assert_wrappable_file_exists_t1 "$S_FP_0"
    #--------
    func_mmmv_silktorrent_packager_t1_bash_get_packet_format_version_t1 "$S_FP_0"
    local S_PACKET_FORMAT="$S_FUNC_MMMV_SILKTORRENT_PACKAGER_T1_BASH_GET_PACKET_FORMAT_VERSION_T1_RESULT"
    if [ "$S_PACKET_FORMAT" == "unsupported_by_this_script_version" ]; then
        echo ""
        echo "There exists a possibility that the "
        echo "Silktorrent packet candidate is actually OK, but "
        echo "this is an older version of the Silktorrent implementation and "
        echo "the older version does not support "
        echo "newer Silktorrent packet formats. "
        echo "The file path of the Silktorrent packet candidate:"
        echo ""
        echo "    $S_FP_0"
        echo ""
        echo "GUID=='d9cc81e3-6682-4097-810f-21b170e031e7'"
        echo ""
        #----
        cd $S_FP_ORIG
        exit 1 # exit with error
    fi
    #--------
    local S_TMP_1=""
    if [ "$S_PACKET_FORMAT" == "silktorrent_packet_format_version_1" ]; then
        func_mmmv_silktorrent_packager_t1_bash_blob2filename_t1 "$S_FP_0"
        #echo "$S_FUNC_MMMV_SILKTORRENT_PACKAGER_T1_BASH_BLOB2FILENAME_T1_RESULT"
        S_TMP_1="$S_FUNC_MMMV_SILKTORRENT_PACKAGER_T1_BASH_BLOB2FILENAME_T1_RESULT"
    fi
    #----
    if [ "$S_TMP_1" == "" ]; then
        echo ""
        echo "This script is flawed."
        echo "It should have thrown before the control flow reaches this line."
        echo "GUID=='73ce445c-9318-49ba-81fe-21b170e031e7'"
        echo ""
        #----
        cd $S_FP_ORIG
        exit 1 # exit with error
    fi
    #--------
    local S_TMP_0="`basename $S_FP_0`" # The S_TMP_0 must be evaluated 
                                       # after the various functions to 
                                       # counter a situation, where 
                                       # the S_TMP_0 is overwritten 
                                       # by the name-calc function 
                                       # or by one of the sub-functions
                                       # of the name-calc function.
                                       # The flaw occurs, when the 
                                       # S_TMP_0 is used within the 
                                       # name-calc function without  
                                       # declaring it to be a local
                                       # variable.
    #--------
    #echo "S_FP_0==$S_FP_0"
    #echo "S_TMP_0==$S_TMP_0"
    #echo "S_TMP_1==$S_TMP_1"
    local S_OUT=""
    if [ "$S_TMP_1" == "$S_TMP_0" ]; then
        S_OUT="verification_passed"
    else
        S_OUT="verification_failed"
    fi
    S_FUNC_MMMV_SILKTORRENT_PACKAGER_T1_BASH_VERIFY_FILE_NAME_T1_RESULT="$S_OUT"
} # func_mmmv_silktorrent_packager_t1_bash_verify_file_name_t1


#--------------------------------------------------------------------------

func_mmmv_silktorrent_packager_t1_bash_test_1() { 
    local S_FP_0="$1" # Path to the file. 
    #----
    func_mmmv_silktorrent_packager_t1_bash_exc_assert_wrappable_file_exists_t1 "$S_FP_0"
    #--------
    echo ""
    #----
    func_mmmv_tigerhash_t1 "$S_FP_0"
    echo "       Tiger: $S_FUNC_MMMV_TIGERHASH_T1_RESULT"
    func_mmmv_whirlpoolhash_t1 "$S_FP_0"
    echo "   Whirlpool: $S_FUNC_MMMV_WHIRLPOOLHASH_T1_RESULT"
    func_mmmv_sha256_t1 "$S_FP_0"
    echo "      SHA256: $S_FUNC_MMMV_SHA256_T1_RESULT"
    func_mmmv_filesize_t1 "$S_FP_0"
    echo "   file size: $S_FUNC_MMMV_FILESIZE_T1_RESULT"
    #----
    echo ""
} # func_mmmv_silktorrent_packager_t1_bash_test_1


#--------------------------------------------------------------------------

func_mmmv_silktorrent_packager_t1_bash_wrap_t1() {
    local S_FP_0="$1" # Path to the file. 
    #----
    func_mmmv_silktorrent_packager_t1_bash_exc_assert_wrappable_file_exists_t1 "$S_FP_0"
    #--------
    func_mmmv_create_tmp_folder_t1
    if [ "$S_FUNC_FUNC_MMMV_CREATE_TMP_FOLDER_T1_RESULT" == "" ]; then
        echo "This script is flawed, because the folder "
        echo "creation function should have thrown "
        echo "before the control flow reaches this branch." 
        echo "GUID=='516b9b78-fe98-4f0d-95fe-21b170e031e7'"
        #----
        cd $S_FP_ORIG
        exit 1 # exit with error
    fi
    local S_FP_TMP_0="$S_FUNC_FUNC_MMMV_CREATE_TMP_FOLDER_T1_RESULT"
    if [ ! -e "$S_FP_TMP_0" ]; then
        echo "This script is flawed."
        echo "May be some other thread deleted the folder or"
        echo "the folder creation function returned a valid path, but"
        echo "did not actually create the folder that it was supposed create."
        echo "S_FP_TMP_0==$S_FP_TMP_0"
        echo "GUID=='ecbecd41-a615-4261-82fe-21b170e031e7'"
        #----
        cd $S_FP_ORIG
        exit 1 # exit with error
    fi
    #--------
    local S_TMP_0="" # declaration
    local S_TMP_1="" # declaration
    local S_FN_CUSTOM_HEADERS="custom_headers"
    local S_FP_TMP_SILKTORRENT_PACKET="$S_FP_TMP_0/silktorrent_packet"
    local S_FP_TMP_SILKTORRENT_PACKET_TAR="$S_FP_TMP_0/silktorrent_packet.tar"
    local S_FP_TMP_PAYLOAD="$S_FP_TMP_SILKTORRENT_PACKET/payload"
    local S_FP_TMP_HEADER="$S_FP_TMP_SILKTORRENT_PACKET/header"
    local S_FP_TMP_HEADER_SALT_TXT="$S_FP_TMP_HEADER/silktorrent_salt.txt"
    func_mmmv_create_folder_if_it_does_not_already_exist_t1 "$S_FP_TMP_PAYLOAD" # uses mkdir -p
    func_mmmv_create_folder_if_it_does_not_already_exist_t1 "$S_FP_TMP_HEADER"
    #--------
    S_TMP_0="`pwd`/$S_FN_CUSTOM_HEADERS"
    if [ -e "$S_TMP_0" ]; then
        if [ ! -d "$S_TMP_0" ]; then
            echo ""
            echo "The "
            echo ""
            echo "    $S_TMP_0"
            echo ""
            echo "exists, but it is not a folder."
            echo "GUID=='4499105f-06d7-477a-a3fe-21b170e031e7'"
            echo ""
            #----
            cd $S_FP_ORIG
            exit 1 # exit with error
        fi
        #----
        # Number of files/folders in the $S_TMP_0, if counted non-recursively.
        S_TMP_1="`cd $S_TMP_0; ruby -e \"print(Dir::glob('*').size.to_s)\"`" 
        #----
        if [ "$S_TMP_1" == "" ]; then
            echo ""
            echo "This script is flawed."
            echo ""
            echo "    pwd=`pwd`"
            echo "    S_TMP_0=$S_TMP_0"
            echo ""
            echo "GUID=='4588f6b7-8b7a-4531-b1fe-21b170e031e7'"
            echo ""
            #----
            cd $S_FP_ORIG
            exit 1 # exit with error
        fi
        if [ "$S_TMP_1" != "0" ]; then
            cp -f -R $S_TMP_0 $S_FP_TMP_HEADER/
            if [ "$?" != "0" ]; then
                echo ""
                echo "The recursive copying of the folder "
                echo ""
                echo "    $S_TMP_0 "
                echo ""
                echo "failed with an error code of $?."
                echo "GUID=='a4b8ae20-fddb-4243-84ee-21b170e031e7'"
                echo ""
                #----
                cd $S_FP_ORIG
                exit 1 # exit with error
            fi
        fi
    fi
    #--------
    # Salting makes sure that it is not possible to 
    # conclude the payload bitstream from the 
    # Silktorrent packet (file) name, forcing censoring
    # parties to download packages 
    # that they are not looking for and allowing
    # censorship dodgers to publish the same payload bitstream
    # in multiple, differet, Silktorrent packages.
    func_mmmv_GUID_t1
    echo "$S_FUNC_MMMV_GUID_T1_RESULT" >> $S_FP_TMP_HEADER_SALT_TXT
    func_mmmv_GUID_t1
    echo "$S_FUNC_MMMV_GUID_T1_RESULT" >> $S_FP_TMP_HEADER_SALT_TXT
    func_mmmv_GUID_t1
    echo "$S_FUNC_MMMV_GUID_T1_RESULT" >> $S_FP_TMP_HEADER_SALT_TXT
    func_mmmv_GUID_t1
    echo "$S_FUNC_MMMV_GUID_T1_RESULT" >> $S_FP_TMP_HEADER_SALT_TXT
    func_mmmv_GUID_t1
    echo "$S_FUNC_MMMV_GUID_T1_RESULT" >> $S_FP_TMP_HEADER_SALT_TXT
    func_mmmv_GUID_t1
    echo "$S_FUNC_MMMV_GUID_T1_RESULT" >> $S_FP_TMP_HEADER_SALT_TXT
    #-------------------------
    # The file size/Silktorrent pakcket size must also be salted.
    if [ "$S_SILKTORRENT_PACKAGER_T1_ACTION_WARP_NRAND" != "" ]; then
        ruby -e \
            "Random.new_seed;i=0;\
             puts '';\
             (10+$S_SILKTORRENT_PACKAGER_T1_ACTION_WARP_NRAND).times{\
                 i=i+1;\
                 print(rand(10**6).to_s(16));\
                 if((i%10)==0) then \
                     puts '';\
                     i=0;\
                 end;\
             }" \
             >> $S_FP_TMP_HEADER_SALT_TXT
    else 
        ruby -e \
            "Random.new_seed;i=0;\
             puts '';\
             rand(10**6).times{\
                 i=i+1;\
                 print(rand(10**6).to_s(16));\
                 if((i%10)==0) then \
                     puts '';\
                     i=0;\
                 end;\
             }" \
             >> $S_FP_TMP_HEADER_SALT_TXT
    fi
    if [ "$?" != "0" ]; then
        echo ""
        echo "Salting failed. \$?==$?"
        echo "GUID=='d25c74fd-d0a8-4cc9-94ee-21b170e031e7'"
        echo ""
        #----
        cd $S_FP_ORIG
        exit 1 # exit with error
    fi
    #-------------------------
    cp -f $S_FP_0 $S_FP_TMP_PAYLOAD/
    if [ "$?" != "0" ]; then
        echo ""
        echo "The command "
        echo ""
        echo "    cp -f \$S_FP_0 \$S_FP_TMP_PAYLOAD/ "
        echo ""
        echo "failed. Either this script is flawed or something else went wrong. "
        echo ""
        echo "    S_FP_0==$S_FP_0"
        echo ""
        echo "    S_FP_TMP_PAYLOAD=$S_FP_TMP_PAYLOAD"
        echo ""
        echo "GUID=='5217362e-6043-4bc2-94ee-21b170e031e7'"
        echo ""
        #----
        cd $S_FP_ORIG
        exit 1 # exit with error
    fi
    #--------
    local S_FP_TMP_ORIG_0="`pwd`"
    cd $S_FP_TMP_SILKTORRENT_PACKET/.. 
    tar -cf $S_FP_TMP_SILKTORRENT_PACKET_TAR ./`basename $S_FP_TMP_SILKTORRENT_PACKET` 2>/dev/null
    cd $S_FP_TMP_ORIG_0
    if [ "$?" != "0" ]; then
        echo ""
        echo "The command "
        echo ""
        echo "    tar -cf \$S_FP_TMP_SILKTORRENT_PACKET_TAR \$S_FP_TMP_SILKTORRENT_PACKET "
        echo ""
        echo "failed. Either this script is flawed or something else went wrong. "
        echo ""
        echo "    S_FP_TMP_SILKTORRENT_PACKET=$S_FP_TMP_SILKTORRENT_PACKET"
        echo ""
        echo "    S_FP_TMP_SILKTORRENT_PACKET_TAR==$S_FP_TMP_SILKTORRENT_PACKET_TAR"
        echo ""
        echo "GUID=='1ecc8ae3-16f1-4b7b-91ee-21b170e031e7'"
        echo ""
        #----
        cd $S_FP_ORIG
        exit 1 # exit with error
    fi
    #----
    func_mmmv_silktorrent_packager_t1_bash_blob2filename_t1 "$S_FP_TMP_SILKTORRENT_PACKET_TAR"
    local S_FP_TMP_SILKTORRENT_PACKET_PUBLISHINGNAME="$S_FP_ORIG/$S_FUNC_MMMV_SILKTORRENT_PACKAGER_T1_BASH_BLOB2FILENAME_T1_RESULT"
    #---------
    # The 2> /dev/null part is due some weird to BSD peculiarity. 
    # The actual success/failure of the mv command is tested after
    # its execution anyway.
    mv -f $S_FP_TMP_SILKTORRENT_PACKET_TAR $S_FP_TMP_SILKTORRENT_PACKET_PUBLISHINGNAME 2> /dev/null
    #---------
    if [ "$?" != "0" ]; then
        echo ""
        echo "Something went wrong."
        echo "The renaming and copying of "
        echo "    $S_FP_TMP_SILKTORRENT_PACKET_TAR "
        echo "to "
        echo "    $S_FP_TMP_SILKTORRENT_PACKET_PUBLISHINGNAME "
        echo "failed."
        echo "GUID=='24adbab5-2724-4b56-b1ee-21b170e031e7'"
        echo ""
        #----
        cd $S_FP_ORIG
        exit 1 # exit with error
    fi
    if [ ! -e "$S_FP_TMP_SILKTORRENT_PACKET_PUBLISHINGNAME" ]; then
        echo ""
        echo "Something went wrong."
        echo "The renaming and copying of "
        echo ""
        echo "    $S_FP_TMP_SILKTORRENT_PACKET_TAR "
        echo ""
        echo "to "
        echo ""
        echo "    $S_FP_TMP_SILKTORRENT_PACKET_PUBLISHINGNAME "
        echo ""
        echo "failed. The mv command succeed, but for some reason "
        echo "the destination file does not exist."
        echo "GUID=='6249805d-3970-4ae0-83de-21b170e031e7'"
        echo ""
        #----
        cd $S_FP_ORIG
        exit 1 # exit with error
    fi
    #--------
    func_mmmv_delete_tmp_folder_t1 "$S_FP_TMP_0"
    if [ -e "$S_FP_TMP_0" ]; then
        echo ""
        echo "Something went wrong."
        echo "The deletion of the temporary folder, "
        echo ""
        echo "    $S_FP_TMP_0"
        echo ""
        echo "failed."
        echo "GUID=='2b5ea76a-9cbc-4b17-a4de-21b170e031e7'"
        echo ""
        #----
        cd $S_FP_ORIG
        exit 1 # exit with error
    fi
} # func_mmmv_silktorrent_packager_t1_bash_wrap_t1


#--------------------------------------------------------------------------

func_mmmv_silktorrent_packager_t1_bash_unwrap_t1() {
    local S_FP_0="$1" # Path to the file. 
    #----
    func_mmmv_silktorrent_packager_t1_bash_exc_assert_wrappable_file_exists_t1 "$S_FP_0"
    #--------
    func_mmmv_silktorrent_packager_t1_bash_verify_file_name_t1 "$S_FP_0"
    local S_PACKET_FORMAT="$S_FUNC_MMMV_SILKTORRENT_PACKAGER_T1_BASH_GET_PACKET_FORMAT_VERSION_T1_RESULT"
    if [ "$S_FUNC_MMMV_SILKTORRENT_PACKAGER_T1_BASH_VERIFY_FILE_NAME_T1_RESULT" != "verification_passed" ]; then
        echo ""
        echo "The Silktorrent packet candidate, "
        echo ""
        echo "    $S_FP_0"
        echo ""
        echo "failed Silktorrent packet name verification."
        echo "There exists a possibility that the "
        echo "Silktorrent packet candidate is actually OK, but "
        echo "this is an older version of the Silktorrent implementation and "
        echo "this, the older, version does not support "
        echo "newer Silktorrent packet formats. "
        echo "GUID=='4963c1ad-f3b4-448b-b3de-21b170e031e7'"
        echo ""
        #----
        cd $S_FP_ORIG
        exit 1 # exit with error
    fi
    #--------
    local SB_FORMAT_BRANCH_EXISTS_IN_THIS_FUNCTION="f"
    if [ "$S_PACKET_FORMAT" == "silktorrent_packet_format_version_1" ]; then
        SB_FORMAT_BRANCH_EXISTS_IN_THIS_FUNCTION="t"
        #----
        local S_FP_TMP_SILKTORRENT_PACKET="`pwd`/silktorrent_packet"
        if [ -e $S_FP_TMP_SILKTORRENT_PACKET ]; then
            echo ""
            echo "To avoid accidental deletion of files, "
            echo "and some other types of flaws, "
            echo "there is a requirement that the folder "
            echo ""
            echo "    ./silktorrent_packet"
            echo ""
            echo "must be explicitly deleted before calling this script."
            echo "GUID=='23c45aa4-a11a-4465-b8de-21b170e031e7'"
            echo ""
            #----
            cd $S_FP_ORIG
            exit 1 # exit with error
        fi
        #----
        tar -xf $S_FP_0 2>/dev/null
        if [ "$?" != "0" ]; then
            echo ""
            echo "Something went wrong. The command "
            echo ""
            echo "    tar -xf $S_FP_0"
            echo ""
            echo "exited with an error code, which is $? ."
            echo "GUID=='a48be003-4597-4171-b5de-21b170e031e7'"
            echo ""
            #----
            cd $S_FP_ORIG
            exit 1 # exit with error
        fi
        rm -f $S_FP_TMP_SILKTORRENT_PACKET/header/silktorrent_salt.txt
        #----
        if [ ! -e $S_FP_TMP_SILKTORRENT_PACKET ]; then
            echo ""
            echo "Something went wrong. "
            echo "The unpacking of the Silktorrent packet with the path of "
            echo ""
            echo "    $S_FP_0"
            echo ""
            echo "failed. The folder \"silktorrent_packet\" "
            echo "is missing after the \"tar\" exited without any errors."
            echo "GUID=='fd13e654-54dc-4fc0-84ce-21b170e031e7'"
            echo ""
            #----
            cd $S_FP_ORIG
            exit 1 # exit with error
        fi
    fi # silktorrent_packet_format_version_1
    #--------
    if [ "$SB_FORMAT_BRANCH_EXISTS_IN_THIS_FUNCTION" != "t" ]; then
        echo ""
        echo "This script is flawed."
        echo "There is at least one branch missing from this function."
        echo "GUID=='1e48d97b-0cfd-419f-a2ce-21b170e031e7'"
        echo ""
        #----
        cd $S_FP_ORIG
        exit 1 # exit with error
    fi
    #--------
} # func_mmmv_silktorrent_packager_t1_bash_unwrap_t1


#--------------------------------------------------------------------------

func_mmmv_silktorrent_packager_t1_bash_verify_packet_name_format_v1(){
    local S_PACKET_NAME_CANDIDATE="$1" 
    if [ "$S_PACKET_NAME_CANDIDATE" == "" ]; then
        echo ""
        echo "This script is flawed."
        echo "Input verification should have caught the "
        echo "\"\" case before the control flow reaches this line."
        echo "GUID=='e455ec4a-e47b-4300-b2ce-21b170e031e7'"
        echo ""
        #----
        cd $S_FP_ORIG
        exit 1 # exit with error
    fi
    #--------
    local S_OUT="verification_failed" # opposite: "verification_passed"

    #                         rgx_in_ruby=/v[\d]{4}[_]/
    #                         rgx_in_ruby=/s[\d]+[_]/
    #                         rgx_in_ruby=/h[\dabcdef]{64}[_]/
    #                         rgx_in_ruby=/i[\dabcdef]{48}$/   # lacks the ending "_" 
    #                                                          # for db index optimization
    #------------------------------------------------------------------------------
    #local S_RUBY_REGEX="/^X[\\dabcdef]{48}i[_][\\dabcdef]{64}h[_][\\d]+s[_][\\d]{4}v.stblobX\$/"
    #                             Tiger             SHA-256       size     version
    local S_RUBY_REGEX="/^X[\\dabcdef]{48}i[_][\\dabcdef]{64}h[_][\\d]+s[_]1000v.stblobX\$/"
    #------------------------------------------------------------------------------
    # test cases: 
    #     ruby -e "puts(ARGV[0])" aa\ bb
    #     printf %s "%q" "AA BB CC $^ \ / '\`\" <>()[];.{}" | xargs ruby -e "puts(ARGV[0])"
    # 
    # The S_PACKET_NAME_CANDIDATE might contain various quotation marks.
    # If it does, then hopefully it crashes at least something so that
    # the crash can be detected from the "$?". 
    # The surrounding X-es, X<packet name candidate string>X, 
    # are to counter a situation, where the file name candidate ends
    # with a space, like "foo " and the Bash reads the console
    # argument in as "foo" in stead of the "foo ". 
    #----
    #local S_TMP_0="`printf  \"%q\" \"'$S_PACKET_NAME_CANDIDATE'\" | xargs ruby -e \" \
    local S_TMP_0="`ruby -e \" \
        s_in=ARGV[0];\
        rgx=$S_RUBY_REGEX;\
        md=s_in.match(rgx);\
        s_out='no_match';\
        if(md!=nil) then \
            s_out='match';\
        end;\
        printf(s_out);\
        \" \"$S_PACKET_NAME_CANDIDATE\" `"
    #----
    if [ "$?" != "0" ]; then
        echo ""
        echo "Something went wrong. \$?==$? "
        echo "    S_PACKET_NAME_CANDIDATE==$S_PACKET_NAME_CANDIDATE"
        echo "GUID=='14e79072-40db-4f61-9fce-21b170e031e7'"
        echo ""
        #----
        cd $S_FP_ORIG
        exit 1 # exit with error
    fi
    #--------
    # If the file name starts like "./foo" in stead of "foo", 
    # then the verification also fails, 
    # exactly as expected and demanded by the spec.
    if [ "$S_TMP_0" == "match" ]; then
        S_OUT="verification_passed" # opposite: "verification_failed"
    fi
    #--------
    echo "$S_OUT"
} # func_mmmv_silktorrent_packager_t1_bash_verify_packet_name_format_v1


#--------------------------------------------------------------------------

# The 
S_SILKTORRENT_PACKAGER_T1_ACTION="" # is global to allow it to be used in the 
                                    # error messages of different functions.
S_SILKTORRENT_PACKAGER_T1_ACTION_WARP_NRAND="" 

#--------------------------------------------------------------------------


func_mmmv_silktorrent_packager_t1_bash_determine_action() { 
    local S_ARGV_0="$1" # Ruby style ARGV, 0 is the first command line argument.
    local S_ARGV_1="$2" 
    local S_ARGV_2="$3" 
    local S_ARGV_3="$4" 
    #--------
    if [ "$S_ARGV_0" == "" ]; then
        func_mmmv_silktorrent_packager_t1_bash_print_help_msg_t1
        #----
        cd $S_FP_ORIG
        exit 1 # exit with an error
    fi
    #----
    local SB_0="f"
    if [ "$S_ARGV_0" == "help" ]; then
        SB_0="t"
    fi
    if [ "$S_ARGV_0" == "--help" ]; then
        SB_0="t"
    fi
    if [ "$S_ARGV_0" == "?" ]; then
        SB_0="t"
    fi
    if [ "$S_ARGV_0" == "-?" ]; then
        SB_0="t"
    fi
    if [ "$S_ARGV_0" == "h" ]; then
        SB_0="t"
    fi
    if [ "$S_ARGV_0" == "-h" ]; then
        SB_0="t"
    fi
    #----
    if [ "$SB_0" == "t" ]; then
        func_mmmv_assert_arg_is_absent_t1 \
                "$S_ARGV_1" \
                "2. console argument" \
                "6fc27b31-acd4-47e5-98f0-21b170e031e7"
        func_mmmv_silktorrent_packager_t1_bash_print_help_msg_t1
        #----
        cd $S_FP_ORIG
        exit 0 # exit without an error
    fi
    #--------------------------
    if [ "$S_ARGV_0" == "version" ]; then
        SB_0="t"
    fi
    if [ "$S_ARGV_0" == "--version" ]; then
        SB_0="t"
    fi
    if [ "$S_ARGV_0" == "-version" ]; then
        SB_0="t"
    fi
    if [ "$S_ARGV_0" == "v" ]; then
        SB_0="t"
    fi
    if [ "$S_ARGV_0" == "-v" ]; then
        SB_0="t"
    fi
    #----
    if [ "$SB_0" == "t" ]; then
        func_mmmv_assert_arg_is_absent_t1 \
                "$S_ARGV_1" \
                "2. console argument" \
                "f7d51543-a78b-4d25-84f0-21b170e031e7"
        echo "$S_SCRIPT_VERSION"
        #----
        cd $S_FP_ORIG
        exit 0 # exit without an error
    fi
    #--------------------------
    if [ "$S_ARGV_0" == "version_timestamp" ]; then
        SB_0="t"
    fi
    if [ "$S_ARGV_0" == "--version_timestamp" ]; then
        SB_0="t"
    fi
    if [ "$S_ARGV_0" == "-version_timestamp" ]; then
        SB_0="t"
    fi
    if [ "$S_ARGV_0" == "vt" ]; then
        SB_0="t"
    fi
    if [ "$S_ARGV_0" == "-vt" ]; then
        SB_0="t"
    fi
    #----
    if [ "$SB_0" == "t" ]; then
        func_mmmv_assert_arg_is_absent_t1 \
                "$S_ARGV_1" \
                "2. console argument" \
                "70144819-1b55-4635-92f0-21b170e031e7"
        echo "$S_SCRIPT_VERSION_GENERATION_DATE"
        #----
        cd $S_FP_ORIG
        exit 0 # exit without an error
    fi
    #--------------------------
    # Start of actions that require the existence of at least one file.
    local SB_FILE_REQUIRED="t"
    local SB_REQUESTED_ACTION_EXISTS="f"
    local S_TMP_0=""
    local S_TMP_1=""
    S_SILKTORRENT_PACKAGER_T1_ACTION_WARP_NRAND=""
    #----
    S_TMP_0="wrap" 
    if [ "$S_ARGV_0" == "$S_TMP_0" ]; then
        S_SILKTORRENT_PACKAGER_T1_ACTION="$S_TMP_0"
        SB_REQUESTED_ACTION_EXISTS="t"
    fi
    if [ "$S_ARGV_0" == "pack" ]; then   # alias
        S_SILKTORRENT_PACKAGER_T1_ACTION="$S_TMP_0"
        SB_REQUESTED_ACTION_EXISTS="t"
    fi
    if [ "$S_ARGV_0" == "w" ]; then   # alias
        S_SILKTORRENT_PACKAGER_T1_ACTION="$S_TMP_0"
        SB_REQUESTED_ACTION_EXISTS="t"
    fi
    if [ "$S_ARGV_0" == "-w" ]; then   # alias
        S_SILKTORRENT_PACKAGER_T1_ACTION="$S_TMP_0"
        SB_REQUESTED_ACTION_EXISTS="t"
    fi
    if [ "$S_SILKTORRENT_PACKAGER_T1_ACTION" == "$S_TMP_0" ]; then
        if [ "$S_ARGV_2" != "" ]; then
            func_mmmv_x_positive_whole_number_or_an_emptystring_t1 "$S_ARGV_2"
            S_TMP_1="$S_FUNC_MMMV_X_POSITIVE_WHOLE_NUMBER_OR_AN_EMPTYSTRING_T1_OUT"
            if [ "$S_TMP_1" == "" ]; then
                echo ""
                echo ""
                echo "The N_OF_RANDOM_TEXT_BLOCKS(==$S_ARGV_2) is expected "
                echo "to be a positive whole number."
                echo "GUID=='8060bc3b-8a91-4b14-93ce-21b170e031e7'"
                echo ""
                # func_mmmv_silktorrent_packager_t1_bash_print_help_msg_t1
                #----
                cd $S_FP_ORIG
                exit 1 # exit with an error
            fi
            #-------------------------
            # Sets a limit that files that 
            # have spaces and tabs in their names can not be packed
            # without renaming or wrapping them to some tar-file that 
            # has a space-tab-linebreak-free name.
            func_mmmv_assert_arg_is_absent_t1 \
                    "$S_ARGV_3" \
                    "4. console argument" \
                    "7237cea6-9a81-4a19-98f0-21b170e031e7"
            #-------------------------
            S_SILKTORRENT_PACKAGER_T1_ACTION_WARP_NRAND="$S_TMP_1" # ==N_OF_RANDOM_TEXT_BLOCKS
        fi
    fi
    #----
    S_TMP_0="unwrap" 
    if [ "$S_ARGV_0" == "$S_TMP_0" ]; then
        S_SILKTORRENT_PACKAGER_T1_ACTION="$S_TMP_0"
        SB_REQUESTED_ACTION_EXISTS="t"
    fi
    if [ "$S_ARGV_0" == "unpack" ]; then # alias
        S_SILKTORRENT_PACKAGER_T1_ACTION="$S_TMP_0"
        SB_REQUESTED_ACTION_EXISTS="t"
    fi
    if [ "$S_ARGV_0" == "uw" ]; then # alias
        S_SILKTORRENT_PACKAGER_T1_ACTION="$S_TMP_0"
        SB_REQUESTED_ACTION_EXISTS="t"
    fi
    if [ "$S_ARGV_0" == "-uw" ]; then # alias
        S_SILKTORRENT_PACKAGER_T1_ACTION="$S_TMP_0"
        SB_REQUESTED_ACTION_EXISTS="t"
    fi
    if [ "$S_SILKTORRENT_PACKAGER_T1_ACTION" == "$S_TMP_0" ]; then
        # A more streightforward check would be:
        #
        # func_mmmv_assert_arg_is_absent_t1 \
        #         "$S_ARGV_3" \
        #         "4. console argument" \
        #         "27f24511-05e7-4265-8be0-21b170e031e7"
        #
        # but in the case of the unwrap command the hack in this if-clause
        # gives a more informative error message for 
        # Silktorrent packet candidate files that have spaces in their name 
        if [ "$S_ARGV_2" != "" ]; then
            S_SILKTORRENT_PACKAGER_T1_ACTION="verify_packet_name_format_v1"
        fi
    fi
    #----
    S_TMP_0="verify" # checks the match between the blob and the file name
    if [ "$S_ARGV_0" == "$S_TMP_0" ]; then
        S_SILKTORRENT_PACKAGER_T1_ACTION="$S_TMP_0"
        SB_REQUESTED_ACTION_EXISTS="t"
    fi
    if [ "$S_SILKTORRENT_PACKAGER_T1_ACTION" == "$S_TMP_0" ]; then
        func_mmmv_assert_arg_is_absent_t1 \
                "$S_ARGV_2" \
                "3. console argument" \
                "f4a36b43-4b94-453f-81e0-21b170e031e7"
    fi
    #----
    S_TMP_0="test_hash_t1" 
    if [ "$S_ARGV_0" == "$S_TMP_0" ]; then
        S_SILKTORRENT_PACKAGER_T1_ACTION="$S_TMP_0"
        SB_REQUESTED_ACTION_EXISTS="t"
    fi
    if [ "$S_SILKTORRENT_PACKAGER_T1_ACTION" == "$S_TMP_0" ]; then
        func_mmmv_assert_arg_is_absent_t1 \
                "$S_ARGV_2" \
                "3. console argument" \
                "e49c8607-3481-4033-94e0-21b170e031e7"
    fi
    #--------
    # Start of actions that do not require a file:
    S_TMP_0="verify_packet_name_format_v1" 
    if [ "$S_ARGV_0" == "$S_TMP_0" ]; then
        S_SILKTORRENT_PACKAGER_T1_ACTION="$S_TMP_0"
        SB_REQUESTED_ACTION_EXISTS="t"
        SB_FILE_REQUIRED="f"
    fi
    if [ "$S_ARGV_0" == "--verify_packet_name_format_v1" ]; then 
        S_SILKTORRENT_PACKAGER_T1_ACTION="$S_TMP_0"
        SB_REQUESTED_ACTION_EXISTS="t"
        SB_FILE_REQUIRED="f"
    fi
    if [ "$S_ARGV_0" == "verify_package_name_format_v1" ]; then 
        #  differs from $S_TMP_0 at AAA
        #------------------------------------------------           
        S_SILKTORRENT_PACKAGER_T1_ACTION="$S_TMP_0"
        SB_REQUESTED_ACTION_EXISTS="t"
        SB_FILE_REQUIRED="f"
    fi
    if [ "$S_ARGV_0" == "--verify_package_name_format_v1" ]; then 
        #    differs from $S_TMP_0 at AAA
        #------------------------------------------------           
        S_SILKTORRENT_PACKAGER_T1_ACTION="$S_TMP_0"
        SB_REQUESTED_ACTION_EXISTS="t"
        SB_FILE_REQUIRED="f"
    fi
    if [ "$S_ARGV_0" == "vnf1" ]; then  # abbreviation of "verify name format v1"
        S_SILKTORRENT_PACKAGER_T1_ACTION="$S_TMP_0"
        SB_REQUESTED_ACTION_EXISTS="t"
        SB_FILE_REQUIRED="f"
    fi
    if [ "$S_ARGV_0" == "-vnf1" ]; then  # abbreviation of "verify name format v1"
        S_SILKTORRENT_PACKAGER_T1_ACTION="$S_TMP_0"
        SB_REQUESTED_ACTION_EXISTS="t"
        SB_FILE_REQUIRED="f"
    fi
    # The 3. console argument presence/absence check must be
    # intentionally skipped for the "verify_packet_name_format_v1", because 
    # the console output must return a specific string in the case of 
    # a packet name format verification failure and any string, 
    # including the strings that include spaces, must be allowed to be verified.
    # 
    # A thing to keep in mind is also that the "unwrap" command 
    # reverts to the "verify_packet_name_format_v1" command, if the 
    # file name of a Silktorrent packet candidate contains any spaces.
    #----------------------------------------------------------------------
    if [ "$SB_REQUESTED_ACTION_EXISTS" != "t" ]; then # lack of action included
        func_mmmv_silktorrent_packager_t1_bash_print_help_msg_t1
        #----
        cd $S_FP_ORIG
        exit 1 # exit with an error
    fi
    SB_REQUESTED_ACTION_EXISTS="f" # a reset to anticipate flaws elsewhere
    # The action name test above has to be before the 
    if [ "$SB_FILE_REQUIRED" == "t" ]; then
        func_mmmv_silktorrent_packager_t1_bash_exc_assert_wrappable_file_exists_t1 "$S_ARGV_1"
    else 
        func_mmmv_silktorrent_packager_t1_bash_exc_assert_packet_name_candidate_exists_t1 "$S_ARGV_1"
    fi
    # because otherwise the error messages would be incorrect.
    #--------
    # The following duplicating series of if-clauses is to allow 
    # actions to have aliases.
    if [ "$S_SILKTORRENT_PACKAGER_T1_ACTION" == "wrap" ]; then
        func_mmmv_silktorrent_packager_t1_bash_wrap_t1 "$S_ARGV_1"
        #----
        cd $S_FP_ORIG
        exit 0 # exit without an error
    fi
    #----
    if [ "$S_SILKTORRENT_PACKAGER_T1_ACTION" == "unwrap" ]; then
        func_mmmv_silktorrent_packager_t1_bash_unwrap_t1 "$S_ARGV_1"
        #----
        cd $S_FP_ORIG
        exit 0 # exit without an error
    fi
    #----
    if [ "$S_SILKTORRENT_PACKAGER_T1_ACTION" == "verify" ]; then
        func_mmmv_silktorrent_packager_t1_bash_verify_file_name_t1 "$S_ARGV_1"
        echo "$S_FUNC_MMMV_SILKTORRENT_PACKAGER_T1_BASH_VERIFY_FILE_NAME_T1_RESULT"
        #----
        cd $S_FP_ORIG
        exit 0 # exit without an error
    fi
    #----
    if [ "$S_SILKTORRENT_PACKAGER_T1_ACTION" == "test_hash_t1" ]; then
        func_mmmv_silktorrent_packager_t1_bash_test_1 "$S_ARGV_1"
        #----
        cd $S_FP_ORIG
        exit 0 # exit without an error
    fi
    #--------
    # Start of actions that do not require a file:
    if [ "$S_SILKTORRENT_PACKAGER_T1_ACTION" == "verify_packet_name_format_v1" ]; then
        func_mmmv_silktorrent_packager_t1_bash_verify_packet_name_format_v1 "$S_ARGV_1"
        #----
        cd $S_FP_ORIG
        exit 0 # exit without an error
    fi
    #--------------------------
        echo "" 
        echo "This bash script is flawed. The control flow " 
        echo "should have never reached this line."
        echo "GUID=='2c787ea3-4baa-4f6f-84be-21b170e031e7'"
        echo ""
        #----
        cd $S_FP_ORIG
        exit 1 # exit with an error
} # func_mmmv_silktorrent_packager_t1_bash_determine_action

func_mmmv_silktorrent_packager_t1_bash_determine_action $1 $2 $3 $4 $5 $6 $7


#--------------------------------------------------------------------------


#--------------------------------------------------------------------------
cd $S_FP_ORIG
exit 0 # 

#==========================================================================
# Fragments of comments and code that might find use some times later:
#--------------------------------------------------------------------------
#
#   max 55 characters --- package suggested deprecation date in nanoseconds
#                         relative to the Unix Epoch, 
#                         written in base 10. It can be negative.
#                         rgx_in_ruby=/t((y[-]?[\d]+)|n)[_]/
# echo "v0034_s2342_tn_" | gawk '{ gsub(/_/, "_\n"); print }' | \
#                          gawk '/^t(y[-]?[0-9]+|n)_/ {printf "%s",$1 }' |
#                          gawk '{gsub(/[tyn_]/,"");printf "%s", $1 }'
#                         
#
#--------
# The awk code example originates from 
# http://www.linuxandlife.com/2013/06/how-to-reverse-string.html
# archival copy: https://archive.is/Cx0xF
# S_TMP_0="`printf "$S_IN" | \
#    awk '{ for(i=length;i!=0;i--)x=x substr($0,i,1);}END{printf  x}'`"
#--------
#
#S_TMP_0="`printf \"$S_NAME_OF_THE_EXECUTABLE_2\" | gawk '{gsub(/\s/,"");printf "%s", $1 }'`"
#S_TMP_0=$( printf "$S_CANDIDATE" | gawk '{gsub(/^[+]/,""); printf "%s", $1}' )
#S_TMP_1=$( printf "$S_TMP_0"     | gawk '{gsub(/[0123456789]+/,""); printf "%s", $1}' )
#S_TMP_0=$( printf "$S_CANDIDATE" | gawk '{gsub(/\s+/,""); printf "%s", $1}' )
#S_TMP_1=$( printf "$S_TMP_0" | gawk '{gsub(/^[0]+/,""); printf "%s", $1}' )
#S_TMP_0="`printf  \"$S_NAME_OF_THE_BASH_FUNCTION\" | gawk '{gsub(/\s/,"");printf "%s", $1 }'`"
#S_TMP_0="`printf  \"$S_FP_2_AN_EXISTING_FILE\" | gawk '{gsub(/\s/,"");printf "%s", $1 }'`"
#S_TMP_0="`printf \"$S_NAME_OF_THE_EXECUTABLE_2\" | gawk '{gsub(/\s/,"");printf "%s", $1 }'`"

#==========================================================================

