
#                            Silktorrent

---------------------------------------------------------------------------

The current version of the Silktorrent is 
**INCOMPLETE** and **VERY EXPERIMENTAL**. 

Up to date Silktorrent documentation **MIGHT**
resides at [silktorrent.ch](http://www.silktorrent.ch).


The Silktorrent is meant to be a doomsday last resort network software
infrastructure that allows to create reliable information systems
that can withstand a situation, where Police/adversaries have
taken down literally all servers of the authors of the censored
files and, at the same time, have access to all of the encryption
keys of the authors of the censored files and, at the same time,
have taken down internet connections of the general public.


---------------------------------------------------------------------------

##              The Ideas that are used in this Version

This version of the Silktorrent is based on the idea that 
**tar-files can be named according to their secure hash and size**. 
Applications that use the Silktorrent system for "networking", 
write and read the tar-files from some local folder
and that folder is then filled with or emptied from
tar-files by some Silktorrent "P2P agent".
In the simplest case the "P2P agent" can be 
literally a human, who copies tar-files
between a USB-stick and the local folder,
but in practice there can be more automated
solutions. Due to the fact that the 
names of the tar-files contain their 
size and secure hash, it does not matter,
which foes help to transport the files. From
Silktorrent architecture point of view, it is
perfectly OK for the NSA to offer a Dropbox service
to privacy advocates, as long as the timing and
location based metadata is hidden from the NSA.


Redundancy is achieved by just having a copy of a
collection of the tar-files at multiple locations.
It's a lot like the software package 
collections of various Linux distributions. 
The path, how the software packages reach the computer, 
copied from a DVD, downloaded from a local server,
etc. does not matter. The tar-files can be delivered
by pigeons that have memory cards attached to their
feet, mail-drones, commuters, who just pick up and
dump files through their cellphone WiFi, etc.
**Silktorrent e-mail or an instant messaging
service can be implemented by saving extra
records to a separate database, where there is a
relation between the tar-file name, recipient ID and 
suggested-deletion-date.** 
Counter-measures for Denial-of-Service attacks is 
based on authentication, timing, location(channel).


One of the core ideas of the Silktorrent is that 
the Silktorrent applications must assume that the 
location of the tar-file can not be concluded from
its name. Silktorrent applications ask for tar-files
from agents, who might not have the asked tar-file 
available and the agents might not even be able to 
retrieve the asked tar-file. The agents are free to
use whatever [crazy](http://longterm.softf1.com/specifications/lightmsgp/v2/)
addressing scheme that they want.


---------------------------------------------------------------------------

##             Further Censorship Countermeasures

In practice a relatively short fixed width string, for example, a 
[GUID](http://longterm.softf1.com/specifications/third_party/ietf/mmmv_highlighted_RFCs/RFC_00004122_GUID_spec.txt)
can be searched from a database table in a fraction of a second. 
Even the [SQLite](https://www.sqlite.org/)
database engine is that fast.
That makes it feasible for people to use a set of 
one-time ID-s, user-names, with every person that they 
exchange Silktorrent based e-mails with. An e-mail server
tells an e-mail client that it has a set of encrypted blobs
that are addressed to Joe, Micky, Jill, Jack and it's up to You
to figure out, which one You are. Each e-mail has a 
suggested-deletion-date attached to it, either in the 
tar-file, which contains folders

* payload
* header

or the e-mail client, which gave the tar-file to the 
e-mail server, told the e-mail server the 
suggested-deletion-date. The header contains a file
named 

    ./silktorrent_salt.txt
    
which probabilistically guarantees that the 
size and bits-tream of the payload can not be
fully deduced from the tar-file name, forcing
censoring parties to download a considerable 
amount of tar-files that they do not need.


---------------------------------------------------------------------------

##          The Silktorrent is Licensed Under the MIT License

 The MIT license from the 
 http://www.opensource.org/licenses/mit-license.php

 Copyright 2016, martin.vahi@softf1.com that has an
 Estonian personal identification code of 38108050020.

 Permission is hereby granted, free of charge, to 
 any person obtaining a copy of this software and 
 associated documentation files (the "Software"), 
 to deal in the Software without restriction, including 
 without limitation the rights to use, copy, modify, merge, publish, 
 distribute, sublicense, and/or sell copies of the Software, and 
 to permit persons to whom the Software is furnished to do so, 
 subject to the following conditions:

 The above copyright notice and this permission notice shall be included 
 in all copies or substantial portions of the Software.

 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, 
 EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF 
 MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. 
 IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY 
 CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, 
 TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE 
 SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.


---------------------------------------------------------------------------

