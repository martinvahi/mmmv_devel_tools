#!/usr/bin/env bash
#==========================================================================
#
# Copyright 2016, martin.vahi@softf1.com that has an
# Estonian personal identification code of 38108050020.
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or
# without modification, are permitted provided that the following
# conditions are met:
#
# * Redistributions of source code must retain the above copyright
#   notice, this list of conditions and the following disclaimer.
# * Redistributions in binary form must reproduce the above copyright
#   notice, this list of conditions and the following disclaimer
#   in the documentation and/or other materials provided with the
#   distribution.
# * Neither the name of the Martin Vahi nor the names of its
#   contributors may be used to endorse or promote products derived
#   from this software without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND
# CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES,
# INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
# MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
# DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR
# CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
# SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
# BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
# SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
# INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
# WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
# NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
# OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#
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
# s_guid_1="401ec65f-5b1f-4504-a37f-802070e031e7"
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
# s_guid_0="4a232c25-89db-4ec7-b57f-802070e031e7"
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
# s_guid_2="35309005-bf20-49ac-b27f-802070e031e7"
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
# s_guid_3="77ae3663-07ab-4e74-976f-802070e031e7"
# func_throw_t1.call(s_0,s_guid_3)
# end # if
# #--------------
# s_ruby="s_0=(`"+s_guid_generation_program_name+" 2>/dev/null`).to_s"
# eval(s_ruby)
# s_0=s_0.gsub(/[\n\s\r]/,"")
# s_script_version=s_0
# #----
# if s_script_version.length!=36
# s_guid_4="a24d2e3c-f4d4-49b4-956f-802070e031e7"
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
S_SCRIPT_VERSION_SUBPART_1="cd56e610-cc52"
S_SCRIPT_VERSION_SUBPART_2="-4776-b024-9ec382af71d4"
S_SCRIPT_VERSION="$S_SCRIPT_VERSION_SUBPART_1$S_SCRIPT_VERSION_SUBPART_2"

S_SCRIPT_VERSION_GENERATION_DATE="2017y_3month_14day_7h_2min_4sec_547231usec"

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
        echo "GUID=='1ab9ed41-0d69-4aa5-b77f-802070e031e7'"
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
#         echo "GUID=='979a642b-6b93-436c-a47f-802070e031e7'"
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
#         echo "GUID=='375e9340-6011-4561-927f-802070e031e7'"
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
        echo "  GUID=='0e2ad440-7a2b-42a7-a27f-802070e031e7'"
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
        echo "GUID=='419b1786-df9e-4f50-856f-802070e031e7'"
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
        echo "GUID=='84cd9645-2a1b-4881-a56f-802070e031e7'"
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
        echo "GUID=='1f7ef235-2182-44c7-a26f-802070e031e7'"
        echo ""
        #----
        cd $S_FP_ORIG
        exit 1 # exit with error
    fi
    if [ "$5" != "" ] ; then
        echo ""
        echo "This Bash function is designed to work with at most 4 input arguments"
        echo "GUID=='794ad84b-a08a-424e-816f-802070e031e7'"
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
            S_TMP_2="GUID=='13f85894-0f63-4f5d-855f-802070e031e7'"
        fi
    fi
    #----
    if [ "$SB_THROW" == "f" ] ; then
        S_TMP_0="`ruby -e \"print('$S_NAME_OF_THE_EXECUTABLE_2'.to_s.gsub(/[\s]+/,''));\" `"
        if [ "$S_NAME_OF_THE_EXECUTABLE_2" != "$S_TMP_0" ] ; then
            SB_THROW="t" 
            S_TMP_1="$S_NAME_OF_THE_EXECUTABLE_2"
            S_TMP_2="GUID=='58d3e782-de58-4948-955f-802070e031e7'"
        fi
    fi
    #----
    if [ "$SB_THROW" == "f" ] ; then
        S_TMP_0="`ruby -e \"print('$S_NAME_OF_THE_EXECUTABLE_3'.to_s.gsub(/[\s]+/,''));\" `"
        if [ "$S_NAME_OF_THE_EXECUTABLE_3" != "$S_TMP_0" ] ; then
            SB_THROW="t" 
            S_TMP_1="$S_NAME_OF_THE_EXECUTABLE_3"
            S_TMP_2="GUID=='458621df-baae-44b3-845f-802070e031e7'"
        fi
    fi
    #----
    if [ "$SB_THROW" == "f" ] ; then
        S_TMP_0="`ruby -e \"print('$S_NAME_OF_THE_EXECUTABLE_4'.to_s.gsub(/[\s]+/,''));\" `"
        if [ "$S_NAME_OF_THE_EXECUTABLE_4" != "$S_TMP_0" ] ; then
            SB_THROW="t" 
            S_TMP_1="$S_NAME_OF_THE_EXECUTABLE_4"
            S_TMP_2="GUID=='e47b0f21-ca52-4c16-925f-802070e031e7'"
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
        echo "GUID=='7f763031-0dfe-4ae6-835f-802070e031e7'"
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
            echo "GUID=='7f2264f1-a416-4f98-834f-802070e031e7'"
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
            echo "GUID=='7bad5248-aedd-4b92-b24f-802070e031e7'"
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
            echo "GUID=='52da2cb7-f5d3-4ada-b14f-802070e031e7'"
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
        echo "GUID=='0f19542b-b29f-48cb-a44f-802070e031e7'"
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
        echo "GUID=='34b848b2-0751-425d-bf4f-802070e031e7'"
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
        echo "GUID=='53caac5b-c560-4e59-844f-802070e031e7'"
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
        echo "GUID=='3fba6917-df0d-4112-b14f-802070e031e7'"
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
        echo "GUID=='bc69232e-5669-4d65-a34f-802070e031e7'"
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
        echo "GUID=='8b227e42-7961-4605-a34f-802070e031e7'"
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
        echo "GUID=='006fc725-72b5-4cfb-833f-802070e031e7'"
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
        echo "GUID=='a2497139-9757-4665-b23f-802070e031e7'"
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
        echo "GUID=='eeb1bb35-bb83-49f9-823f-802070e031e7'"
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
            echo "GUID=='206f4814-201e-4a2f-b33f-802070e031e7'"
            echo ""
            #----
            cd $S_FP_ORIG
            exit 1 # exit with error
        fi
        #--------
        if [ "$?" != "0" ]; then
            echo ""
            echo "This script is flawed."
            echo "GUID=='bb150913-c9b9-499d-843f-802070e031e7'"
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
            echo "GUID=='eda70544-4dbf-4cb7-a13f-802070e031e7'"
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
            echo "GUID=='e209473a-96ba-41df-b23f-802070e031e7'"
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
        echo "GUID=='a37e5410-207d-4349-953f-802070e031e7'"
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
            echo "GUID=='d0bda5b5-afe3-4d98-a33f-802070e031e7'"
            echo ""
            #----
            cd $S_FP_ORIG
            exit 1 # exit with error
        fi
        #--------
        if [ "$?" != "0" ]; then
            echo ""
            echo "This script is flawed."
            echo "GUID=='8dbe0d5b-49d9-4ff1-912f-802070e031e7'"
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
            echo "GUID=='beca8510-daa3-4e5d-952f-802070e031e7'"
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
            echo "GUID=='ab91f85a-ec98-4500-852f-802070e031e7'"
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
            echo "GUID=='f962bf2d-cc00-49b0-922f-802070e031e7'"
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
        echo "GUID=='43a74951-a648-48c6-8d2f-802070e031e7'"
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
            echo "GUID=='90b8e050-605e-4739-a12f-802070e031e7'"
            echo ""
            #----
            cd $S_FP_ORIG
            exit 1 # exit with error
        fi
        #--------
        if [ "$?" != "0" ]; then
            echo ""
            echo "This script is flawed."
            echo "GUID=='1493164d-7f39-403d-a52f-802070e031e7'"
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
            echo "GUID=='6ae5d3c3-8172-4f53-a42f-802070e031e7'"
            echo ""
            #----
            cd $S_FP_ORIG
            exit 1 # exit with error
        fi
        #--------
        if [ "$?" != "0" ]; then
            echo ""
            echo "This script is flawed."
            echo "GUID=='12a86372-9c15-497a-922f-802070e031e7'"
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
            echo "GUID=='e181fb22-837b-43a1-851f-802070e031e7'"
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
            echo "GUID=='a33c823b-57d7-4cd0-a11f-802070e031e7'"
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
        echo "GUID=='cc5bba27-d0cb-4b45-841f-802070e031e7'"
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
            echo "GUID=='1057ae42-12a7-4a43-9b1f-802070e031e7'"
            echo ""
            #----
            cd $S_FP_ORIG
            exit 1 # exit with error
        fi
        #--------
        if [ "$?" != "0" ]; then
            echo ""
            echo "This script is flawed."
            echo "GUID=='254cbf85-edf6-470f-a11f-802070e031e7'"
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
            echo "GUID=='25b4bd13-b0b6-4d0d-941f-802070e031e7'"
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
            echo "GUID=='2eaf4542-d700-4137-931f-802070e031e7'"
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
        echo "GUID=='a34afc59-ecee-4d4d-850f-802070e031e7'"
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
            echo "GUID=='2406f8f2-b4d4-4a87-810f-802070e031e7'"
            echo ""
            #----
            cd $S_FP_ORIG
            exit 1 # exit with error
        fi
        #--------
        if [ "$?" != "0" ]; then
            echo ""
            echo "This script is flawed."
            echo "GUID=='f8128f65-9fbd-4d2c-b30f-802070e031e7'"
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
            echo "GUID=='35da64ce-6da9-4143-920f-802070e031e7'"
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
            echo "GUID=='6efcd543-0ae5-4369-950f-802070e031e7'"
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
        echo "GUID=='14ab3053-b0f1-4c5c-930f-802070e031e7'"
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
        echo "GUID=='4ca91a2f-28bd-4347-810f-802070e031e7'"
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
            echo "GUID=='5740b6b3-90b4-4500-810f-802070e031e7'"
            echo ""
        else
            echo ""
            echo "The file with the path of "
            echo ""
            echo "    $S_FP_0"
            echo ""
            echo "does not exist."
            echo "GUID=='87c16d21-e78b-48af-b6fe-802070e031e7'"
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
            echo "GUID=='9ad6cd5d-5668-435f-b5fe-802070e031e7'"
            echo ""
        else
            echo ""
            echo "The path "
            echo ""
            echo "    $S_FP_0"
            echo ""
            echo "references a folder, but it is expected to "
            echo "to reference a file."
            echo "GUID=='3e955ea5-497b-4d25-81fe-802070e031e7'"
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
        echo "GUID=='95383c69-07f5-47c0-89fe-802070e031e7'"
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
        echo "GUID=='31e54d03-8016-436b-85bd-802070e031e7'"
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
            echo "GUID=='85bbf612-0a2b-485f-b4bd-802070e031e7'"
            echo ""
            #----
            cd $S_FP_ORIG
            exit 1 # exit with error
        fi
        #--------
        if [ "$?" != "0" ]; then
            echo ""
            echo "This script is flawed."
            echo "GUID=='e779be52-3b1a-402e-91bd-802070e031e7'"
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
            echo "GUID=='32b59258-f7d6-4a83-95bd-802070e031e7'"
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
        echo "GUID=='7574bf34-b0c4-4ba9-a5bd-802070e031e7'"
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
        echo "GUID=='89fc6c50-6a1b-4e68-b4bd-802070e031e7'"
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
        echo "GUID=='33f9e721-d141-4a15-93ad-802070e031e7'"
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
        echo "GUID=='5322e2c5-5408-456c-96ad-802070e031e7'"
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
        echo "GUID=='53d85f13-83de-4ab2-85ad-802070e031e7'"
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
        echo "GUID=='7a6a8222-46a8-4fc2-a3ad-802070e031e7'"
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
            echo "GUID=='568dee95-94ef-4508-b5ad-802070e031e7'"
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
        echo "GUID=='47dbaf49-8151-467d-939d-802070e031e7'"
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
        echo "GUID=='87415d1b-e2b5-4f0e-829d-802070e031e7'"
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
        echo "GUID=='594ff3b3-10bd-42db-b19d-802070e031e7'"
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
        echo "GUID=='59d91812-4ab7-4c2a-879d-802070e031e7'"
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
        echo "GUID=='5c8e3d01-c703-4ea0-a28d-802070e031e7'"
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
        echo "GUID=='ef933b2b-a50e-4957-818d-802070e031e7'"
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
        echo "GUID=='6a5dc354-4293-4c9f-b28d-802070e031e7'"
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
        echo "GUID=='ec6c175c-bab0-408a-b38d-802070e031e7'"
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
        echo "GUID=='1b402ae2-09dd-45fc-b28d-802070e031e7'"
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
        echo "GUID=='5aa78147-2c10-4f63-947d-802070e031e7'"
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
        echo "GUID=='318cca35-4f39-4a2c-937d-802070e031e7'"
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
        echo "GUID=='dc42402d-7e17-46e1-b57d-802070e031e7'"
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
        echo "GUID=='3511389d-bb47-4185-a57d-802070e031e7'"
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
            echo "GUID=='46e9e734-c3b4-44f5-847d-802070e031e7'"
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
            echo "GUID=='65b01b46-fdbb-4aa0-b46d-802070e031e7'"
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
                echo "GUID=='2a2c784c-31d4-4c87-816d-802070e031e7'"
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
        echo "GUID=='39232452-bcfd-42cb-915d-802070e031e7'"
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
        echo "GUID=='786ab828-2356-4699-a55d-802070e031e7'"
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
        echo "GUID=='b1be543c-0c81-42c8-825d-802070e031e7'"
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
        echo "GUID=='cd0cd93e-d77d-4baf-925d-802070e031e7'"
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
        echo "GUID=='c9a3b13f-36b4-4aac-955d-802070e031e7'"
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
        echo "GUID=='a2020c3b-30cf-49ee-a44d-802070e031e7'"
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
        echo "GUID=='64351e84-6947-4dd0-954d-802070e031e7'"
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
            echo "GUID=='571e3875-32e0-48d8-933d-802070e031e7'"
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
            echo "GUID=='1485b83e-0109-401a-b13d-802070e031e7'"
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
            echo "GUID=='56860551-0d8f-4d2e-a32d-802070e031e7'"
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
        echo "GUID=='12813f55-2652-4329-a42d-802070e031e7'"
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
        echo "GUID=='dcdaa214-e5cf-4d89-a32d-802070e031e7'"
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
        echo "GUID=='7ad3893e-ac0a-4e5f-b22d-802070e031e7'"
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
                "adf5cf2f-6fb0-4e01-836f-802070e031e7"
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
                "546a64c2-96fe-41fa-8c6f-802070e031e7"
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
                "39de2191-edc0-4e2a-b26f-802070e031e7"
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
                echo "GUID=='3e1e0843-9eb1-44ce-a51d-802070e031e7'"
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
                    "1357302b-c0e2-4951-835f-802070e031e7"
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
        #         "cefb292e-5c50-4f00-b45f-802070e031e7"
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
                "23069114-3e88-40ca-b55f-802070e031e7"
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
                "f4081fa5-06ca-440d-915f-802070e031e7"
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
        echo "GUID=='30c24214-2845-45ad-841d-802070e031e7'"
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

