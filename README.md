mmmv_devel_tools
===========================================================================

The mmmv_devel_tools is a collection of software development
utilities and IDE integration scripts.

The tools depends on Ruby, Bash and
a set of common Linux/BSD command line tools.  

mmmv_devel_tools subprojects MIGHT work with Ruby versions 1.8 till 2.3.x,
but as of 2023_03 they have NOT been tested with so old versions for a while.
mmmv_devel_tools subprojects will probably NOT work with Ruby versions 2.4.0 till 2.7.1,
because those versions put the Fixnum and Bignum deprecation
warnings to stderr and the included Kibuvits Ruby Library (hereafter: KRL)
is designed to throw, whenever the KRL code finds anything from the stderr.
mmmv_devel_tools subprojects MIGHT work with Ruby versions 2.7.2 and greater,
because since the Ruby version 2.7.2 the Fixnum and Bignum deprecation
warnings were removed from the stderr.

The mmmv_devel_tools is Linux/BSD specific, but
it has worked with some Ruby versions
under the Windows Subsystem for Linux (WSL).
Some sub-parts of the KRL MIGHT work with 
some Windows specific Ruby binaries, so at least some of the the 
mmmv_devel_tools components MIGHT occasionally work with 
those Windows specific Ruby binaries, but officially 
WINDOWS IS NOT SUPPORTED. 

Almost all of the mmmv_devel_tools has been written by
the Martin.Vahi@softf1.com and is licensed under the BSD license:
http://www.opensource.org/licenses/BSD-3-Clause
SPDX-License-Identifier: BSD-3-Clause-Clear

Backwards compatibility between different mmmv_devel_tools
versions IS NOT EVEN A GOAL. Projects that depend on the 
mmmv_devel_tools should have a project specific copy 
of it as part of their development deliverables.

---------------------------------------------------------------------------

##                            Setup

Some parts of the mmmv_devel_tools depend on the
environment variable

    MMMV_DEVEL_TOOLS_HOME

which is expected to point to to the folder that
contains the README.md that You are currently reading.

The environment variable, MMMV_DEVEL_TOOLS_HOME,
is useful in situations, where the
location of the mmmv_devel_tools home folder
can not be reliably derived from file paths
that are known within an operating system process.
For example, mmmv_devel_tools component, JumpGUID
runs JavaScript code within the process of

http://www.openkomodo.com/

and the only way to find the mmmv_devel_tools
installation folder in that script without
editing the script, nor editing/creating some
pre-hard-coded configuration file, is to ask
questions from operating system (or
something on the net, etc.).


The rest of the setup instructions reside in the

    $MMMV_DEVEL_TOOLS_HOME/src/etc/COMMENTS.txt

(and those are scary. 8)

---------------------------------------------------------------------------

##                      Remarks for Integrators

Projects that depend on mmmv_devel_tools, can interact with the
mmmv_devel_tools by its public API, which resides at

    $MMMV_DEVEL_TOOLS_HOME/src/api

Client programs have the option to interact with the tools
individually by executing the tools' bash based gate.

The

    $MMMV_DEVEL_TOOLS_HOME/src/api/COMMENTS.txt

describes the public API.

---------------------------------------------------------------------------

##                      Remarks for Newcomers

Officially the mmmv_devel_tools is not supported on Windows,
but some of its sub-projects (renessaator, UpGUID) might work
under Windows, if they are started in the CygWin(http://www.cygwin.com/ )
Bash environment and the CygWin has been installed to

    c:\cygwin

The current version of mmmv_devel_tools Eclipse IDE integration
does not work under windows, because the IDE_integration Ruby scripts
have not been updated. As of 2012 the JRuby that is used in
the Eclipse IDE scripting environment
(ScriptEclipse, http://www.viplugin.com/scripteclipse.htm , but
it is not a ScriptEclipse specific flaw) does not support full
set of Unicode characters.

A side note about the JRuby:

The probable reason, why the JRuby does not have
full Unicode support is the fact that Java (and hence the JVM)
supports Unicode by an after-birth-hack-on. The genuine Ruby
has support to multiple encoding formats, probably even the
TRON strings (http://www.ertl.jp/ITRON/SPEC/mitron4-e.html ),
by attaching string formatting information to every string instance.


---------------------------------------------------------------------------

##                            License

All of the components of the mmmv_devel_tools have some
license that is compatible with the BSD license. The parts that
I, Martin.Vahi@softf1.com, have written, are under the
following BSD license:

Copyright from the inception of this software till 3000,
martin.vahi@softf1.com that has an
Estonian personal identification code of 38108050020.
All rights reserved.

Redistribution and use in source and binary forms, with or
without modification, are permitted provided that the following
conditions are met:

*   Redistributions of source code must retain the above copyright
    notice, this list of conditions and the following disclaimer.

*   Redistributions in binary form must reproduce the above copyright
    notice, this list of conditions and the following disclaimer
    in the documentation and/or other materials provided with the
    distribution.

*   Neither the name of the Martin Vahi nor the names of its
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


---------------------------------------------------------------------------
S_VERSION_OF_THIS_FILE="46dc9635-7ead-47de-b3d1-3232115037e7"
---------------------------------------------------------------------------
