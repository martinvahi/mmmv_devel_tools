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
#==========================================================================
S_FP_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
S_FP_ORIG="`pwd`"
S_TIMESTAMP="`date +%Y`_`date +%m`_`date +%d`_T_`date +%H`h_`date +%M`min_`date +%S`s"

#--------------------------------------------------------------------------
# Settings:
S_SCRIPT_VERSION="2016_07_16_a"
#--------------------------------------------------------------------------

SB_TMP_FOLDER_EXISTS="f" # to omit one useless and slow file system access
S_FP_TMP_FOLDER=""


func_mmmv_silktorrent_packager_t1_exit_without_any_errors() {
    local S_0=""
    local S_1=""
    if [ "$SB_TMP_FOLDER_EXISTS" == "t" ]; then
       S_0= 
    fi
    exit 0 # exit without an error
} # func_mmmv_silktorrent_packager_t1_exit_without_any_errors

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
        echo "  GUID=='33d63375-7582-49dd-aa88-71b3900170e7'"
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
        echo "GUID=='39128b22-8ba8-4037-bb88-71b3900170e7'"
        echo ""
        #----
        cd $S_FP_ORIG
        exit 1 # exit with error
    fi
    local S_TMP_0="`printf \"$S_NAME_OF_THE_EXECUTABLE_1\" | gawk '{gsub(/\s/,"");printf "%s", $1 }'`"
    if [ "$S_NAME_OF_THE_EXECUTABLE_1" != "$S_TMP_0" ] ; then
        echo ""
        echo "The Bash function "
        echo ""
        echo "    func_sb_exists_on_path_t1 "
        echo ""
        echo "is not designed to handle an argument value that contains "
        echo "spaces or tabulation characters."
        echo "The received value in parenthesis:($S_NAME_OF_THE_EXECUTABLE_1)."
        echo "GUID=='47c83d31-51ea-4119-ae88-71b3900170e7'"
        echo ""
        #----
        cd $S_FP_ORIG
        exit 1 # exit with error
    fi
    #--------
    S_TMP_0="\`which $S_NAME_OF_THE_EXECUTABLE_1 2>/dev/null\`"
    local S_TMP_1=""
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
        echo "empty strings preced non-empty strings."
        echo "GUID=='1ae7a9bd-e472-4344-8188-71b3900170e7'"
        echo ""
        #----
        cd $S_FP_ORIG
        exit 1 # exit with error
    fi
    if [ "$5" != "" ] ; then
        echo ""
        echo "This Bash function is designed to work with at most 4 input arguments"
        echo "GUID=='05af1c56-ee4e-485e-8388-71b3900170e7'"
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
        S_TMP_0="`printf \"$S_NAME_OF_THE_EXECUTABLE_1\" | gawk '{gsub(/\s/,"");printf "%s", $1 }'`"
        if [ "$S_NAME_OF_THE_EXECUTABLE_1" != "$S_TMP_0" ] ; then
            SB_THROW="t" 
            S_TMP_1="$S_NAME_OF_THE_EXECUTABLE_1"
            S_TMP_2="GUID=='eb3a821d-b300-4128-8588-71b3900170e7'"
        fi
    fi
    #----
    if [ "$SB_THROW" == "f" ] ; then
        S_TMP_0="`printf \"$S_NAME_OF_THE_EXECUTABLE_2\" | gawk '{gsub(/\s/,"");printf "%s", $1 }'`"
        if [ "$S_NAME_OF_THE_EXECUTABLE_2" != "$S_TMP_0" ] ; then
            SB_THROW="t" 
            S_TMP_1="$S_NAME_OF_THE_EXECUTABLE_2"
            S_TMP_2="GUID=='071590a7-41d2-467f-8888-71b3900170e7'"
        fi
    fi
    #----
    if [ "$SB_THROW" == "f" ] ; then
        S_TMP_0="`printf \"$S_NAME_OF_THE_EXECUTABLE_3\" | gawk '{gsub(/\s/,"");printf "%s", $1 }'`"
        if [ "$S_NAME_OF_THE_EXECUTABLE_3" != "$S_TMP_0" ] ; then
            SB_THROW="t" 
            S_TMP_1="$S_NAME_OF_THE_EXECUTABLE_3"
            S_TMP_2="GUID=='1beff945-939d-48f9-a178-71b3900170e7'"
        fi
    fi
    #----
    if [ "$SB_THROW" == "f" ] ; then
        S_TMP_0="`printf \"$S_NAME_OF_THE_EXECUTABLE_4\" | gawk '{gsub(/\s/,"");printf "%s", $1 }'`"
        if [ "$S_NAME_OF_THE_EXECUTABLE_4" != "$S_TMP_0" ] ; then
            SB_THROW="t" 
            S_TMP_1="$S_NAME_OF_THE_EXECUTABLE_4"
            S_TMP_2="GUID=='9bf9ca59-4c78-4fb6-8378-71b3900170e7'"
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
        echo "GUID=='24b11e55-b4ea-419c-8578-71b3900170e7'"
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
            echo "GUID=='62b54420-f8c0-4d4b-b278-71b3900170e7'"
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
            echo "GUID=='aa80d32e-c312-40b0-8478-71b3900170e7'"
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
            echo "GUID=='3ae0cfcc-0a10-45c5-8168-71b3900170e7'"
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
        echo "GUID=='64dba5fe-7564-4666-a468-71b3900170e7'"
        echo ""
        #----
        cd $S_FP_ORIG
        exit 1 # exit with error
    else
        return # at least one of the programs was available at the PATH
    fi
    #--------
} # func_assert_exists_on_path_t2

func_assert_exists_on_path_t2 "bash"     # this is a bash script, but it does not hurt
func_assert_exists_on_path_t2 "basename" # for extracting file names from full paths
func_assert_exists_on_path_t2 "cat"    # opposite to split
func_assert_exists_on_path_t2 "sha256sum" "sha256" "rhash"
func_assert_exists_on_path_t2 "tigerdeep" "rhash"
func_assert_exists_on_path_t2 "whirlpooldeep" "rhash"
func_assert_exists_on_path_t2 "tar"
#--------
func_assert_exists_on_path_t2 "file"   # for checking the MIME type of the potential tar file
func_assert_exists_on_path_t2 "filesize" "ruby"
func_assert_exists_on_path_t2 "gawk"
#func_assert_exists_on_path_t2 "grep"
#func_assert_exists_on_path_t2 "readlink"
func_assert_exists_on_path_t2 "ruby"  # anything over/equal v.2.1 will probably do
#func_assert_exists_on_path_t2 "split" # for cutting files
#func_assert_exists_on_path_t2 "test"
func_assert_exists_on_path_t2 "uname"  # to check the OS type
func_assert_exists_on_path_t2 "uuidgen" "uuid" # GUID generation on Linux and BSD
#func_assert_exists_on_path_t2 "xargs"   
func_assert_exists_on_path_t2 "wc" # for checking hash lengths   


#--------------------------------------------------------------------------

func_mmmv_exc_hash_function_input_verification_t1() { 
    local S_NAME_OF_THE_BASH_FUNCTION="$1" # The name of the Bash function.
    local S_FP_2_AN_EXISTING_FILE="$2" # The first argument of the Bash function.
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
        echo "GUID=='b91da738-c651-4c2a-8b68-71b3900170e7'"
        echo ""
        #----
        cd $S_FP_ORIG
        exit 1 # exit with error
    fi
    local S_TMP_0="`printf \"$S_NAME_OF_THE_BASH_FUNCTION\" | gawk '{gsub(/\s/,"");printf "%s", $1 }'`"
    if [ "$S_NAME_OF_THE_BASH_FUNCTION" != "$S_TMP_0" ] ; then
        echo ""
        echo "The implementation of the function that "
        echo "calls the "
        echo ""
        echo "    func_mmmv_exc_hash_function_input_verification_t1"
        echo ""
        echo "is flawed. Function names are not allowed to contain spaces or tabs."
        echo "GUID=='405b2523-bd54-463b-9368-71b3900170e7'"
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
    local S_TMP_0="`printf \"$S_FP_2_AN_EXISTING_FILE\" | gawk '{gsub(/\s/,"");printf "%s", $1 }'`"
    if [ "$S_TMP_0" == "" ] ; then
        echo ""
        echo "The Bash function "
        echo ""
        echo "    $S_NAME_OF_THE_BASH_FUNCTION"
        echo ""
        echo "is not designed to handle an argument that "
        echo "equals with an empty string or a series of spaces and tabs."
        echo "GUID=='7118e122-ef7a-43e6-af68-71b3900170e7'"
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
        echo "GUID=='1c0b3101-7922-42b3-ac68-71b3900170e7'"
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
        echo "GUID=='04596259-93f4-45f3-8368-71b3900170e7'"
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
            echo "GUID=='25286e58-fb76-41f5-8568-71b3900170e7'"
            echo ""
            #----
            cd $S_FP_ORIG
            exit 1 # exit with error
        fi
        #--------
        if [ "$?" != "0" ]; then
            echo ""
            echo "This script is flawed."
            echo "GUID=='31132449-5de3-431f-a258-71b3900170e7'"
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
            echo "----console--outut--citation--start-----"
            echo "`uuidgen`" # stdout and stderr
            echo "----console--outut--citation--end-------"
            echo ""
            echo "GUID=='2d8df7d1-9ef0-4531-b558-71b3900170e7'"
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
            echo "----console--outut--citation--start-----"
            echo "`uuid`" # stdout and stderr
            echo "----console--outut--citation--end-------"
            echo ""
            echo "GUID=='7616c855-15e3-4331-a158-71b3900170e7'"
            echo ""
            #----
            cd $S_FP_ORIG
            exit 1 # exit with error
        fi
        #---- 
        S_FUNC_MMMV_GUID_T1_RESULT="$S_TMP_0"
    fi
    #--------------------
    S_TMP_0="`printf \"$S_FUNC_MMMV_GUID_T1_RESULT\" | wc -m `"
    S_TMP_1="36"
    if [ "$S_TMP_0" != "$S_TMP_1" ]; then
        echo ""
        echo "According to the GUID specification, IETF RFC 4122,  "
        echo "the lenght of the GUID is "
        echo "$S_TMP_1 characters, but the result of the "
        echo ""
        echo "    func_mmmv_GUID_t1"
        echo ""
        echo "is something else. The flawed GUID candidate in parenthesis:"
        echo "($S_FUNC_MMMV_GUID_T1_RESULT)"
        echo ""
        echo "The lenght candidate of the flawed GUID candidate in parenthesis:"
        echo "($S_TMP_0)."
        echo ""
        echo "GUID=='7a226a41-91ce-4ab9-a258-71b3900170e7'"
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
            echo "GUID=='4aef5146-0d53-414e-b258-71b3900170e7'"
            echo ""
            #----
            cd $S_FP_ORIG
            exit 1 # exit with error
        fi
        #--------
        if [ "$?" != "0" ]; then
            echo ""
            echo "This script is flawed."
            echo "GUID=='852b0558-3ebd-4de9-a158-71b3900170e7'"
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
            echo "----console--outut--citation--start-----"
            echo "`sha256sum $S_FP_2_AN_EXISTING_FILE`" # stdout and stderr
            echo "----console--outut--citation--end-------"
            echo ""
            echo "GUID=='611e5732-c1cc-480a-a458-71b3900170e7'"
            echo ""
            #----
            cd $S_FP_ORIG
            exit 1 # exit with error
        fi
        #---- 
        # The gawk is used for selecting the 1. column because 
        # according to the
        #
        #     echo "aa bb" | time -v gawk '{printf $1}'
        #
        # the gawk takes about 3MiB, which is far less than the 
        #
        #     time -v ruby -e "puts 'hi'"
        #
        # indicated 16MiB
        #
        S_FUNC_MMMV_SHA256_T1_RESULT="`echo \"$S_TMP_0\" | gawk '{printf $1}'`"
    fi
    #--------------------
    if [ "$S_FUNC_MMMV_SHA256_T1_MODE" == "rhash" ]; then
        S_TMP_0="`rhash --sha256 $S_FP_2_AN_EXISTING_FILE 2>/dev/null`"
        if [ "$?" != "0" ]; then
            echo ""
            echo "The console application \"rhash\" "
            echo "exited with an error."
            echo ""
            echo "----console--outut--citation--start-----"
            echo "`rhash --sha256 $S_FP_2_AN_EXISTING_FILE `"
            echo "----console--outut--citation--end-------"
            echo ""
            echo "GUID=='f377bf45-4ea1-4fe6-9148-71b3900170e7'"
            echo ""
            #----
            cd $S_FP_ORIG
            exit 1 # exit with error
        fi
        S_FUNC_MMMV_SHA256_T1_RESULT="`echo \"$S_TMP_0\" | gawk '{printf $1}'`"
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
            echo "----console--outut--citation--start-----"
            echo \
            "`S_TMP_0=\"\`sha256 $S_FP_2_AN_EXISTING_FILE\`\" ruby -e \"s0=ENV['S_TMP_0'].to_s;ix_0=s0.index(') = ');print s0[(ix_0+4)..(-1)]\"`"
            echo "----console--outut--citation--end-------"
            echo ""
            echo "GUID=='22691ef3-f14b-4f46-bb48-71b3900170e7'"
            echo ""
            #----
            cd $S_FP_ORIG
            exit 1 # exit with error
        fi
    fi
    #--------------------
    S_TMP_0="`printf \"$S_FUNC_MMMV_SHA256_T1_RESULT\" | wc -m `"
    S_TMP_1="64"
    if [ "$S_TMP_0" != "$S_TMP_1" ]; then
        echo ""
        echo "According to the specification of the SHA-256 hash algorithm"
        echo "the lenght of the SHA-256 hash is "
        echo "$S_TMP_1 hexadecimal characters, but the result of the "
        echo ""
        echo "    func_mmmv_sha256_t1"
        echo ""
        echo "is something else. The flawed hash candidate in parenthesis:"
        echo "($S_FUNC_MMMV_SHA256_T1_RESULT)"
        echo ""
        echo "The lenght candidate of the flawed hash candidate in parenthesis:"
        echo "($S_TMP_0)."
        echo ""
        echo "GUID=='3e6b48bd-8a81-4f15-b148-71b3900170e7'"
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
            echo "GUID=='2bed8ba2-1f17-43d0-8b48-71b3900170e7'"
            echo ""
            #----
            cd $S_FP_ORIG
            exit 1 # exit with error
        fi
        #--------
        if [ "$?" != "0" ]; then
            echo ""
            echo "This script is flawed."
            echo "GUID=='401fae19-71e9-4c52-b148-71b3900170e7'"
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
            echo "----console--outut--citation--start-----"
            echo "`tigerdeep $S_FP_2_AN_EXISTING_FILE`" # stdout and stderr
            echo "----console--outut--citation--end-------"
            echo ""
            echo "GUID=='2bd1ed5f-5735-45d7-8248-71b3900170e7'"
            echo ""
            #----
            cd $S_FP_ORIG
            exit 1 # exit with error
        fi
        S_FUNC_MMMV_TIGERHASH_T1_RESULT="`echo \"$S_TMP_0\" | gawk '{printf $1}'`"
    fi
    #--------------------
    if [ "$S_FUNC_MMMV_TIGERHASH_T1_MODE" == "rhash" ]; then
        S_TMP_0="`rhash --tiger $S_FP_2_AN_EXISTING_FILE 2>/dev/null`"
        if [ "$?" != "0" ]; then
            echo ""
            echo "The console application \"rhash\" "
            echo "exited with an error."
            echo ""
            echo "----console--outut--citation--start-----"
            echo "`rhash --tiger $S_FP_2_AN_EXISTING_FILE `"
            echo "----console--outut--citation--end-------"
            echo ""
            echo "GUID=='51e5a1c5-292f-4bf1-8948-71b3900170e7'"
            echo ""
            #----
            cd $S_FP_ORIG
            exit 1 # exit with error
        fi
        S_FUNC_MMMV_TIGERHASH_T1_RESULT="`echo \"$S_TMP_0\" | gawk '{printf $1}'`"
    fi
    #--------------------
    S_TMP_0="`printf \"$S_FUNC_MMMV_TIGERHASH_T1_RESULT\" | wc -m `"
    S_TMP_1="48"
    if [ "$S_TMP_0" != "$S_TMP_1" ]; then
        echo ""
        echo "According to the specification of the Tiger hash algorithm"
        echo "the lenght of the Tiger hash is "
        echo "$S_TMP_1 hexadecimal characters, but the result of the "
        echo ""
        echo "    func_mmmv_tigerhash_t1"
        echo ""
        echo "is something else. The flawed hash candidate in parenthesis:"
        echo "($S_FUNC_MMMV_TIGERHASH_T1_RESULT)"
        echo ""
        echo "The lenght candidate of the flawed hash candidate in parenthesis:"
        echo "($S_TMP_0)."
        echo ""
        echo "GUID=='30fcf82d-5cb9-4c96-9148-71b3900170e7'"
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
            echo "GUID=='2a608859-8310-44b4-8338-71b3900170e7'"
            echo ""
            #----
            cd $S_FP_ORIG
            exit 1 # exit with error
        fi
        #--------
        if [ "$?" != "0" ]; then
            echo ""
            echo "This script is flawed."
            echo "GUID=='48097a1c-5e76-4dcc-b538-71b3900170e7'"
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
            echo "----console--outut--citation--start-----"
            echo "`whirlpooldeep $S_FP_2_AN_EXISTING_FILE`" # stdout and stderr
            echo "----console--outut--citation--end-------"
            echo ""
            echo "GUID=='46922d93-033d-44be-a438-71b3900170e7'"
            echo ""
            #----
            cd $S_FP_ORIG
            exit 1 # exit with error
        fi
        S_FUNC_MMMV_WHIRLPOOLHASH_T1_RESULT="`echo \"$S_TMP_0\" | gawk '{printf $1}'`"
    fi
    #--------------------
    if [ "$S_FUNC_MMMV_WHIRLPOOLHASH_T1_MODE" == "rhash" ]; then
        S_TMP_0="`rhash --whirlpool $S_FP_2_AN_EXISTING_FILE 2>/dev/null`"
        if [ "$?" != "0" ]; then
            echo ""
            echo "The console application \"rhash\" "
            echo "exited with an error."
            echo ""
            echo "----console--outut--citation--start-----"
            echo "`rhash --whirlpool $S_FP_2_AN_EXISTING_FILE `"
            echo "----console--outut--citation--end-------"
            echo ""
            echo "GUID=='22eb6a73-6762-4aa1-9538-71b3900170e7'"
            echo ""
            #----
            cd $S_FP_ORIG
            exit 1 # exit with error
        fi
        S_FUNC_MMMV_WHIRLPOOLHASH_T1_RESULT="`echo \"$S_TMP_0\" | gawk '{printf $1}'`"
    fi
    #--------------------
    S_TMP_0="`printf \"$S_FUNC_MMMV_WHIRLPOOLHASH_T1_RESULT\" | wc -m `"
    S_TMP_1="128"
    if [ "$S_TMP_0" != "$S_TMP_1" ]; then
        echo ""
        echo "According to the specification of the Whirlpool hash algorithm"
        echo "the lenght of the Tiger hash is "
        echo "$S_TMP_1 hexadecimal characters, but the result of the "
        echo ""
        echo "    func_mmmv_whirlpoolhash_t1"
        echo ""
        echo "is something else. The flawed hash candidate in parenthesis:"
        echo "($S_FUNC_MMMV_WHIRLPOOLHASH_T1_RESULT)"
        echo ""
        echo "The lenght candidate of the flawed hash candidate in parenthesis:"
        echo "($S_TMP_0)."
        echo ""
        echo "GUID=='712dc4a3-3fc9-40ca-9338-71b3900170e7'"
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
            echo "GUID=='3c1c971a-a8b6-4c5f-a238-71b3900170e7'"
            echo ""
            #----
            cd $S_FP_ORIG
            exit 1 # exit with error
        fi
        #--------
        if [ "$?" != "0" ]; then
            echo ""
            echo "This script is flawed."
            echo "GUID=='a54cc438-f608-4e38-b138-71b3900170e7'"
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
            echo "----console--outut--citation--start-----"
            echo "`filesize $S_FP_2_AN_EXISTING_FILE`" # stdout and stderr
            echo "----console--outut--citation--end-------"
            echo ""
            echo "GUID=='556a2e84-9d18-4e09-a338-71b3900170e7'"
            echo ""
            #----
            cd $S_FP_ORIG
            exit 1 # exit with error
        fi
        S_FUNC_MMMV_FILESIZE_T1_RESULT="`echo \"$S_TMP_0\" | gawk '{printf $1}'`"
    fi
    #--------------------
    if [ "$S_FUNC_MMMV_FILESIZE_T1_MODE" == "ruby" ]; then
        S_TMP_0="`ruby -e \"printf(File.size('$S_FP_2_AN_EXISTING_FILE').to_s)\" 2>/dev/null`"
        if [ "$?" != "0" ]; then
            echo ""
            echo "The console application \"ruby\" "
            echo "exited with an error."
            echo ""
            echo "----console--outut--citation--start-----"
            echo "`ruby -e \"printf(File.size('$S_FP_2_AN_EXISTING_FILE').to_s)\"`"
            echo "----console--outut--citation--end-------"
            echo ""
            echo "GUID=='855f9c25-6bb5-4f85-9428-71b3900170e7'"
            echo ""
            #----
            cd $S_FP_ORIG
            exit 1 # exit with error
        fi
        S_FUNC_MMMV_FILESIZE_T1_RESULT="$S_TMP_0"
    fi
    #--------------------
    S_TMP_0="`printf \"$S_FUNC_MMMV_FILESIZE_T1_RESULT\" | gawk '{gsub(/\s/,"");printf "%s", $1 }'`"
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
        echo "GUID=='1b8bc205-8c7e-40a4-a528-71b3900170e7'"
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
    echo "              VERIFY_PACKET_NAME_FORMAT_V1 | version "
    echo ""
    echo "                   WRAP :== wrap         <file path> "
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
        echo "GUID=='1eee6d46-d91c-4bfb-a228-71b3900170e7'"
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
            echo "GUID=='4c68cb15-2c2b-49fd-9218-71b3900170e7'"
            echo ""
        else
            echo ""
            echo "The file with the path of "
            echo ""
            echo "    $S_FP_0"
            echo ""
            echo "does not exist."
            echo "GUID=='428ff042-efd8-4566-a318-71b3900170e7'"
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
            echo "GUID=='b2d2a237-9fcb-46fe-8318-71b3900170e7'"
            echo ""
        else
            echo ""
            echo "The path "
            echo ""
            echo "    $S_FP_0"
            echo ""
            echo "references a folder, but it is expected to "
            echo "to reference a file."
            echo "GUID=='1dd79224-6a1e-44fd-b118-71b3900170e7'"
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
        echo "GUID=='7afe9e27-cee1-4ad1-b218-71b3900170e7'"
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
        echo "GUID=='227d93c4-61a6-42b7-b118-71b3900170e7'"
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
    local S_TMP_0="not set"
    # Mode selection:
    if [ "$S_FUNC_MMMV_SILKTORRENT_PACKAGER_T1_BASH_REVERSE_STRING_MODE" == "" ] ; then
        SB_EXISTS_ON_PATH_T1_RESULT="f"  # if-block init
        #----
        if [ "$SB_EXISTS_ON_PATH_T1_RESULT" == "f" ] ; then
            S_TMP_0="gawk" # usually available on Linux
            func_sb_exists_on_path_t1 "$S_TMP_0" 
            if [ "$SB_EXISTS_ON_PATH_T1_RESULT" == "t" ] ; then
                 S_FUNC_MMMV_SILKTORRENT_PACKAGER_T1_BASH_REVERSE_STRING_MODE="$S_TMP_0"
            fi
        fi
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
            echo "capable of using for finding out file size (gawk, ruby)"
            echo "are missing from the PATH."
            echo "GUID=='b55b1414-6247-47f6-9118-71b3900170e7'"
            echo ""
            #----
            cd $S_FP_ORIG
            exit 1 # exit with error
        fi
        #--------
        if [ "$?" != "0" ]; then
            echo ""
            echo "This script is flawed."
            echo "GUID=='109b82e1-8efb-49a4-b408-71b3900170e7'"
            echo ""
            #----
            cd $S_FP_ORIG
            exit 1 # exit with error
        fi
        #--------
    fi
    #--------------------
    #--------------------
    S_FUNC_MMMV_SILKTORRENT_PACKAGER_T1_BASH_REVERSE_STRING_REGISTER=""
    #--------
    if [ "$S_FUNC_MMMV_SILKTORRENT_PACKAGER_T1_BASH_REVERSE_STRING_MODE" == "gawk" ]; then
        # The awk code example originates from 
        # http://www.linuxandlife.com/2013/06/how-to-reverse-string.html
        # archival copy: https://archive.is/Cx0xF
        #----
        S_TMP_0="`printf "$S_IN" | \
            awk '{ for(i=length;i!=0;i--)x=x substr($0,i,1);}END{printf  x}'`"
        if [ "$?" != "0" ]; then
            echo ""
            echo "The console application \"gawk\" "
            echo "exited with an error."
            echo ""
            echo "----console--outut--citation--start-----"
            echo "`printf "$S_IN" | awk '{ for(i=length;i!=0;i--)x=x substr($0,i,1);}END{printf  x}'`"
            echo "----console--outut--citation--end-------"
            echo ""
            echo "GUID=='95dcc43d-90b7-4bfd-8408-71b3900170e7'"
            echo ""
            #----
            cd $S_FP_ORIG
            exit 1 # exit with error
        fi
        S_FUNC_MMMV_SILKTORRENT_PACKAGER_T1_BASH_REVERSE_STRING_REGISTER="$S_TMP_0"
    fi
    #--------
    if [ "$S_FUNC_MMMV_SILKTORRENT_PACKAGER_T1_BASH_REVERSE_STRING_MODE" == "ruby" ]; then
        #----
        S_TMP_0="`ruby -e \"puts(ARGV[0].to_s.reverse)\" "$S_IN" 2>/dev/null`"
        if [ "$?" != "0" ]; then
            echo ""
            echo "The console application \"ruby\" "
            echo "exited with an error."
            echo ""
            echo "----console--outut--citation--start-----"
            echo "`ruby -e \"puts('$S_IN'.reverse)\"`" # with the stderr
            echo "----console--outut--citation--end-------"
            echo ""
            echo "GUID=='59c56443-ab6c-4899-9408-71b3900170e7'"
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
# archieval copy: https://archive.is/UKBmd
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
        echo "GUID=='aa3a281b-e603-44e0-9208-71b3900170e7'"
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
    # the full path points to somehwere in the /tmp
    local S_FP_1="`cd $S_FP_0; pwd`"
    if [ ! -e "$S_FP_1" ]; then
        echo ""
        echo "This script is flawed. The folder "
        echo "    $S_FP_1"
        echo "is missing."
        echo "GUID=='f1c9d550-72d2-407d-9208-71b3900170e7'"
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
        echo "GUID=='ef812232-9359-4769-9208-71b3900170e7'"
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
        echo "GUID=='4604f696-2a07-4943-b508-71b3900170e7'"
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
        echo "GUID=='5e2970b5-eda5-4371-a208-71b3900170e7'"
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
        echo "GUID=='24c43d27-d0bf-4114-b5f7-71b3900170e7'"
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
            echo "GUID=='658b0135-9bb2-4a53-82f7-71b3900170e7'"
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
        echo "GUID=='75439f3e-59f7-4751-b2f7-71b3900170e7'"
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
        echo "GUID=='92a90266-13b1-4468-b5f7-71b3900170e7'"
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
        echo "GUID=='4c3fc054-3af8-4cb4-94f7-71b3900170e7'"
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
        echo "GUID=='864ea729-ebeb-488b-82f7-71b3900170e7'"
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
        echo "GUID=='54add286-d3ba-4fc9-81f7-71b3900170e7'"
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
        echo "GUID=='636ea139-ea1a-44ec-b1e7-71b3900170e7'"
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
        echo "GUID=='27e5ea85-56d2-40d2-93e7-71b3900170e7'"
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
        echo "GUID=='72ca4146-50f7-41ee-92e7-71b3900170e7'"
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
        echo "GUID=='36dee451-756e-49de-83e7-71b3900170e7'"
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
        echo "this is an older version of the Silktorrent implementaiton and "
        echo "the older version does not support "
        echo "newer Silktorrent packet formats. "
        echo "The file path of the Silktorrent packet candidate:"
        echo ""
        echo "    $S_FP_0"
        echo ""
        echo "GUID=='1158d282-b615-4c4c-93e7-71b3900170e7'"
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
        echo "GUID=='3aa4bc43-bbe8-440f-a2e7-71b3900170e7'"
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
        echo "GUID=='726a8332-1505-4018-b2e7-71b3900170e7'"
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
        echo "GUID=='f8fc342c-18e1-40b4-a3d7-71b3900170e7'"
        #----
        cd $S_FP_ORIG
        exit 1 # exit with error
    fi
    #--------
    local S_FP_TMP_SILKTORRENT_PACKET="$S_FP_TMP_0/silktorrent_packet"
    local S_FP_TMP_SILKTORRENT_PACKET_TAR="$S_FP_TMP_0/silktorrent_packet.tar"
    local S_FP_TMP_PAYLOAD="$S_FP_TMP_SILKTORRENT_PACKET/payload"
    local S_FP_TMP_HEADER="$S_FP_TMP_SILKTORRENT_PACKET/header"
    local S_FP_TMP_HEADER_SALT_TXT="$S_FP_TMP_HEADER/silktorrent_salt.txt"
    func_mmmv_create_folder_if_it_does_not_already_exist_t1 "$S_FP_TMP_PAYLOAD" # uses mkdir -p
    func_mmmv_create_folder_if_it_does_not_already_exist_t1 "$S_FP_TMP_HEADER"
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
    #--------
    # The file size/Silktorrent pakcket size must also be salted.
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
    #--------
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
        echo "GUID=='214ba8b2-3cff-420c-a4d7-71b3900170e7'"
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
        echo "GUID=='68428819-d399-43c8-a2d7-71b3900170e7'"
        echo ""
        #----
        cd $S_FP_ORIG
        exit 1 # exit with error
    fi
    #----
    func_mmmv_silktorrent_packager_t1_bash_blob2filename_t1 "$S_FP_TMP_SILKTORRENT_PACKET_TAR"
    local S_FP_TMP_SILKTORRENT_PACKET_PUBLISHINGNAME="$S_FP_ORIG/$S_FUNC_MMMV_SILKTORRENT_PACKAGER_T1_BASH_BLOB2FILENAME_T1_RESULT"
    mv $S_FP_TMP_SILKTORRENT_PACKET_TAR $S_FP_TMP_SILKTORRENT_PACKET_PUBLISHINGNAME
    if [ "$?" != "0" ]; then
        echo ""
        echo "Something went wrong."
        echo "The renaming and copying of "
        echo "    $S_FP_TMP_SILKTORRENT_PACKET_TAR "
        echo "to "
        echo "    $S_FP_TMP_SILKTORRENT_PACKET_PUBLISHINGNAME "
        echo "failed."
        echo "GUID=='c158ce46-9e8d-4bb9-a2d7-71b3900170e7'"
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
        echo "GUID=='7f7e1258-7c19-451f-91d7-71b3900170e7'"
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
        echo "GUID=='23b56e4e-b7c4-4668-85d7-71b3900170e7'"
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
        echo "this is an older version of the Silktorrent implementaiton and "
        echo "this, the older, version does not support "
        echo "newer Silktorrent packet formats. "
        echo "GUID=='1ea93ef2-0fb7-4cbb-8fd7-71b3900170e7'"
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
            echo "GUID=='df3e4c6e-045b-4163-bfc7-71b3900170e7'"
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
            echo "GUID=='07dfbc27-b793-4b68-93c7-71b3900170e7'"
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
            echo "GUID=='39c08e15-9cab-4585-8fc7-71b3900170e7'"
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
        echo "GUID=='b9f42610-010a-4a35-a1c7-71b3900170e7'"
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
        echo "Input verification should have cauht the "
        echo "\"\" case before the control flow reaches this line."
        echo "GUID=='eb6d4411-292c-40b6-a4c7-71b3900170e7'"
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
    local S_RUBY_REGEX="/^X[\\dabcdef]{48}i[_][\\dabcdef]{64}h[_][\\d]+s[_][\\d]{4}v.stblobX\$/"
    #                            Tiger             SHA-256       size     version
    # test cases: 
    #     ruby -e "puts(ARGV[0])" aa\ bb
    #     printf "%q" "AA BB CC $^ \ / '\`\" <>()[];.{}" | xargs ruby -e "puts(ARGV[0])"
    # 
    # The S_PACKET_NAME_CANDIDATE might contain various quotation marks.
    # If it does, then hopefully it crashes at least something so that
    # the crash can be detected from the "$?". 
    # The surrounding X-es, X<packet name candidate string>X, 
    # are to counter a situation, where the file name candidate ends
    # with a pspace, like "foo " and the Bash reads the console
    # argument in as "foo" in stead of the "foo ". 
    #----
    #local S_TMP_0="`printf \"%q\" \"'$S_PACKET_NAME_CANDIDATE'\" | xargs ruby -e \" \
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
        echo "GUID=='41352353-e739-4fd1-b1c7-71b3900170e7'"
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
S_SILKTORRENT_PACKAGER_T1_ACTION="" # is global to allow it to be used
# in the error messages of different functions.

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
    if [ "$S_ARGV_0" == "-?" ]; then
        SB_0="t"
    fi
    if [ "$S_ARGV_0" == "-h" ]; then
        SB_0="t"
    fi
    #----
    if [ "$SB_0" == "t" ]; then
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
    if [ "$S_ARGV_0" == "-v" ]; then
        SB_0="t"
    fi
    #----
    if [ "$SB_0" == "t" ]; then
        echo "$S_SCRIPT_VERSION"
        #----
        cd $S_FP_ORIG
        exit 0 # exit without an error
    fi
    #--------------------------
    # Start of actions that require the existance of at least one file.
    local SB_FILE_REQUIRED="t"
    local SB_REQUESTED_ACTION_EXISTS="f"
    local S_TMP_0=""
    local S_TMP_1=""
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
    #----
    S_TMP_0="verify" # checks the matche between the blob and the file name
    if [ "$S_ARGV_0" == "$S_TMP_0" ]; then
        S_SILKTORRENT_PACKAGER_T1_ACTION="$S_TMP_0"
        SB_REQUESTED_ACTION_EXISTS="t"
    fi
    #----
    S_TMP_0="test_hash_t1" 
    if [ "$S_ARGV_0" == "$S_TMP_0" ]; then
        S_SILKTORRENT_PACKAGER_T1_ACTION="$S_TMP_0"
        SB_REQUESTED_ACTION_EXISTS="t"
    fi
    #--------
    # Start of actions that do not require a file:
    S_TMP_0="verify_packet_name_format_v1" 
    if [ "$S_ARGV_0" == "$S_TMP_0" ]; then
        S_SILKTORRENT_PACKAGER_T1_ACTION="$S_TMP_0"
        SB_REQUESTED_ACTION_EXISTS="t"
        SB_FILE_REQUIRED="f"
    fi
    if [ "$S_ARGV_0" == "verify_package_name_format_v1" ]; then
        S_SILKTORRENT_PACKAGER_T1_ACTION="$S_TMP_0"
        SB_REQUESTED_ACTION_EXISTS="t"
        SB_FILE_REQUIRED="f"
    fi
    #--------
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
        echo "GUID=='e3af811a-93a7-4512-91b7-71b3900170e7'"
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


#==========================================================================

