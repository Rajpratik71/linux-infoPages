File: speech-dispatcher.info,  Node: Top,  Next: Introduction,  Prev: (dir),  Up: (dir)

This manual documents Speech Dispatcher, version 0.8.8.

   Copyright (C) 2001, 2002, 2003, 2006 Brailcom, o.p.s.

     Permission is granted to copy, distribute and/or modify this
     document under the terms of the GNU Free Documentation License,
     Version 1.2 or any later version published by the Free Software
     Foundation; with no Invariant Sections, with no Front-Cover Texts
     and no Back-Cover Texts.  A copy of the license is included in the
     section entitled "GNU Free Documentation License."

   You can also (at your option) distribute this manual under the GNU
General Public License:

     Permission is granted to copy, distribute and/or modify this
     document under the terms of the GNU General Public License as
     published by the Free Software Foundation; either version 2 of the
     License, or (at your option) any later version.

     A copy of the license is included in the section entitled "GNU
     General Public License"

* Menu:

* Introduction::                What is Speech Dispatcher.
* User's Documentation::        Usage, Configuration...
* Technical Specifications::
* Client Programming::          Documentation for application developers.
* Server Programming::          Documentation for project contributors.

* Download and Contact::        How to get Speech Dispatcher and how to contact us
* Reporting Bugs::              How to report a bug
* How You Can Help::            What is needed

* Appendices::
* GNU General Public License::  Copying conditions for Speech Dispatcher
* GNU Free Documentation License::  Copying conditions for this manual

* Index of Concepts::

File: speech-dispatcher.info,  Node: Introduction,  Next: User's Documentation,  Prev: Top,  Up: Top

1 Introduction
**************

* Menu:

* Motivation::                  Why Speech Dispatcher?
* Basic Design::                How does it work?
* Features Overview::           What are the assets?
* Current State::               What is done?

File: speech-dispatcher.info,  Node: Motivation,  Next: Basic Design,  Prev: Introduction,  Up: Introduction

1.1 Motivation
==============

Speech Dispatcher is a device independent layer for speech synthesis
that provides a common easy to use interface for both client
applications (programs that want to speak) and for software synthesizers
(programs actually able to convert text to speech).

   High quality speech synthesis is now commonly available both as
propriatary and Free Software solutions.  It has a wide field of
possible uses from educational software to specialized systems, e.g.  in
hospitals or laboratories.  It is also a key compensation tool for the
visually impaired users.  For them, it is one of the two possible ways
of getting output from a computer (the second one being a Braille
display).

   The various speech synthesizers are quite different, both in their
interfaces and capabilities.  Thus a general common interface is needed
so that the client application programmers have an easy way to use
software speech synthesis and don't have to care about peculiar details
of the various synthesizers.

   The absence of such a common and standardized interface and thus the
difficulty for programmers to use software speech synthesis has been a
major reason why the potential of speech synthesis technology is still
not fully expoited.

   Ideally, there would be little distinction for applications whether
they output messages on the screen or via speech.  Speech Dispatcher can
be compared to what a GUI toolkit is for the graphical interface.  Not
only does it provide an easy to use interface, some kind of theming and
configuration mechanisms, but also it takes care of some of the issues
inherent with this particular mode of output, such as the need for
speech message serialization and interaction with the audio subsystem.

File: speech-dispatcher.info,  Node: Basic Design,  Next: Features Overview,  Prev: Motivation,  Up: Introduction

1.2 Design
==========

Current Design
==============

The communication between all applications and synthesizers, when
implemented directly, is a mess.  For this purpose, we wanted Speech
Dispatcher to be a layer separating applications and synthesizers so
that applications wouldn't have to care about synthesizers and
synthesizers wouldn't have to care about interaction with applications.

   We decided we would implement Speech Dispatcher as a server receiving
commands from applications over a protocol called 'SSIP', parsing them
if needed, and calling the appropriate functions of output modules
communicating with the different synthesizers.  These output modules are
implemented as plug-ins, so that the user can just load a new module if
he wants to use a new synthesizer.

   Each client (application that wants to speak) opens a socket
connection to Speech Dispatcher and calls functions like say(), stop(),
and pause() provided by a library implementing the protocol.  This
shared library is still on the client side and sends Speech Dispatcher
SSIP commands over the socket.  When the messages arrive at Speech
Dispatcher, it parses them, reads the text that should be said and puts
it in one of several queues according to the priority of the message and
other criteria.  It then decides when, with which parameters (set up by
the client and the user), and on which synthesizer it will say the
message.  These requests are handled by the output plug-ins (output
modules) for different hardware and software synthesizers and then said
aloud.

[Speech Dispatcher architecture]
   See also the detailed description *note Client Programming::
interfaces, and *note Server Programming:: documentation.

Future Design
=============

Speech Dispatcher currently mixes two important features: common
low-level interface to multiple speech synthesizers and message
management (including priorities and history).  This became even more
evident when we started thinking about handling messages intended for
output on braille devices.  Such messages of course need to be
synchronized with speech messages and there is little reason why the
accessibility tools should send the same message twice for these two
different kinds of output used by blind people (often simultaneously).
Outside the world of accessibility, applications also want to either
have full control over the sound (bypass prioritisation) or to only
retrieve the synthesized data, but not play them immediatelly.

   We want to eventually split Speech Dispatcher into two independent
components: one providing a low-level interface to speech synthesis
drivers, which we now call TTS API Provider and is already largely
implemented in the Free(b)Soft project, and the second doing message
managemenet, called Message Dispatcher.  This will allow Message
Dispatcher to also output on Braille as well as to use the TTS API
Provider separately.

   From implementation point of view, an opportunity for new design
based on our previous experiences allowed us to remove several
bottlenecks for speed (responsiveness), ease of use and ease of
implementation of extensions (particularly output modules for new
synthesizers).  From the architecture point of view and possibilities
for new developments, we are entirely convinced that both the new design
in general and the inner design of the new components is much better.

   While a good API and its implementation for Braille are already
existent in the form of BrlAPI, the API for speech is now under
developement.  Please see another architecture diagram showing how we
imagine Message Dispatcher in the future.

[Speech Dispatcher architecture]
   References: <http://www.freebsoft.org/tts-api/>
<http://www.freebsoft.org/tts-api-provider/>

File: speech-dispatcher.info,  Node: Features Overview,  Next: Current State,  Prev: Basic Design,  Up: Introduction

1.3 Features Overview
=====================

Speech Dispatcher from user's point of view:

   * ability to freely combine applications with your favorite
     synthesizer
   * message synchronization and coordination
   * less time devoted to configuration of applications

   Speech Dispatcher from application programmers's point of view:

   * easy way to make your applications speak
   * common interface to different synthesizers
   * higher level synchronization of messages (priorities)
   * no need to take care about configuration of voice(s)

File: speech-dispatcher.info,  Node: Current State,  Prev: Features Overview,  Up: Introduction

1.4 Current State
=================

In this version, most of the features of Speech Dispatcher are
implemented and we believe it is now useful for applications as a device
independent Text-to-Speech layer and an accessibility message
coordination layer.

   Currently, one of the most advanced applications that works with
Speech Dispatcher is 'speechd-el'.  This is a client for Emacs, targeted
primarily for blind people.  It is similar to Emacspeak, however the two
take a bit different approach and serve different user needs.  You can
find speechd-el on <http://www.freebsoft.org/speechd-el/>.  speechd-el
provides speech output when using nearly any GNU/Linux text interface,
like editing text, reading email, browsing the web, etc.

   Orca, the primary screen reader for the Gnome Desktop, supports
Speech Dispatcher directly since its version 2.19.0.  See
<http://live.gnome.org/Orca/SpeechDispatcher> for more information.

   We also provide a shared C library, a Python library, a Java, Guile
and a Common Lisp libraries that implement the SSIP functions of Speech
Dispatcher in higher level interfaces.  Writing client applications in
these languages should be quite easy.

   On the synthesis side, there is good support for Festival, eSpeak,
Flite, Cicero, IBM TTS, MBROLA, Epos, Dectalk software, Cepstral Swift
and others.  See *Note Supported Modules::.

   We decided not to interface the simple hardware speech devices as
they don't support synchronization and therefore cause serious problems
when handling multiple messages.  Also they are not extensible, they are
usually expensive and often hard to support.  Today's computers are fast
enough to perform software speech synthesis and Festival is a great
example.

File: speech-dispatcher.info,  Node: User's Documentation,  Next: Technical Specifications,  Prev: Introduction,  Up: Top

2 User's Documentation
**********************

* Menu:

* Installation::                How to get it installed in the best way.
* Running::                     The different ways to start it.
* Troubleshooting::             What to do if something doesn't work...
* Configuration::               How to configure Speech Dispatcher.
* Tools::                       What tools come with Speech Dispatcher.
* Synthesis Output Modules::    Drivers for different synthesizers.
* Security::                    Security mechanisms and restrictions.

File: speech-dispatcher.info,  Node: Installation,  Next: Running,  Prev: User's Documentation,  Up: User's Documentation

2.1 Installation
================

This part only deals with the general aspects of installing Speech
Dispatcher.  If you are compiling from source code (distribution tarball
or git), please refer to the file 'INSTALL' in your source tree.

2.1.1 The requirements
----------------------

You will need these components to run Speech Dispatcher:
   * glib 2.0 (<http://www.gtk.org>)
   * libdotconf 1.3 (<http://github.com/williamh/dotconf>)
   * pthreads

   We recommend to also install these packages:
   * Festival (<http://www.cstr.ed.ac.uk/projects/festival/>)
   * festival-freebsoft-utils 0.3+
     (<http://www.freebsoft.org/festival-freebsoft-utils>)
   * Sound icons library
     (<http://www.freebsoft.org/pub/projects/sound-icons/sound-icons-0.1.tar.gz>)

2.1.2 Recommended installation procedure
----------------------------------------

   * Install your software synthesizer

     Although we highly recommend to use Festival for its excellent
     extensibility, good quality voices, good responsiveness and best
     support in Speech Dispatcher, you might want to start with eSpeak,
     a lightweight multi-lingual feature-complete synthesizer, to get
     all the key components working and perhaps only then switch to
     Festival.  Installation of eSpeak should be easier and the default
     configuration of Speech Dispatcher is set up for eSpeak for this
     reason.

     You can of course also start with Epos or any other supported
     synthesizer.

   * Make sure your synthesizer works

     There is usually a way to test if the installation of your speech
     synthesizer works.  For eSpeak run 'espeak "test"', for Flite run
     'flite -t "Hello!"' and hear the speech.  For Festival run
     'festival' and type in

          (SayText "Hello!")
          (quit)

   * Install Speech Dispatcher

     Install the packages for Speech Dispatcher from your distribution
     or download the source tarball (or git) from
     <http://www.freebsoft.org/speechd> and follow the instructions in
     the file 'INSTALL' in the source tree.

   * Configure Speech Dispatcher

     You can skip this step in most cases.  If you however want to setup
     your own configuration of the Dispatchers default values, the
     easiest way to do so is through the 'spd-conf' configuration
     script.  It will guide you through the basic configuration.  It
     will also subsequently perform some diagnostics tests and offer
     some limited help with troubleshooting.  Just execute

          spd-conf

     under an ordinary user or system user like 'speech-dispatcher'
     depending on whether you like to setup Speech Dispatcher as user or
     system service respectively.  You might also want to explore the
     offered options or run some of its subsystems manually, type
     'spd-conf -h' for help.

     If you do not want to use this script, it doesn't work in your case
     or it doesn't provide enough configuration flexibility, please
     continue as described below and/or in *Note Running Under Ordinary
     Users::.

   * Test Speech Dispatcher

     The simplest way to test Speech Dispatcher is through 'spd-conf -d'
     or through the 'spd-say' tool.

     Example:
          spd-conf -d
          spd-say "Hello!"
          spd-say -l cs -r 90 "Ahoj"

     If you don't hear anything, please *Note Troubleshooting::.

2.1.3 How to use eSpeak with MBROLA
-----------------------------------

Please follow the guidelines at
<http://espeak.sourceforge.net/mbrola.html> for installing eSpeak with a
set of MBROLA voices that you want to use.

   Check the 'modules/espeak-mbrola-generic.conf' configuration files
for the 'AddVoice' lines.  If a line for any of the voices you have
installed (and it is supported by your version of eSpeak, e.g.  'ls
/usr/share/espeak-data/voices/mb/mb-*') is not contained here, please
add it.  Check if 'GenericExecuteString' contains the correct name of
your mbrola binary and correct path to its voice database.

   Uncomment the 'AddModule' line for 'espeak-mbrola-generic' in
'speechd.conf' in your configuration for Speech Dispatcher.

   Restart speech-dispatcher and in your client, select
'espeak-mbrola-generic' as your output module, or test it with the
following command

     spd-say -o espeak-mbrola-generic -l cs Testing

File: speech-dispatcher.info,  Node: Running,  Next: Troubleshooting,  Prev: Installation,  Up: User's Documentation

2.2 Running
===========

Speech Dispatcher is normally executed on a per-user basis.  This
provides more flexibility in user configuration, access rights and is
essential in any environment where multiple people use the computer at
the same time.  It used to be possible to run Speech Dispatcher as a
system service under a special user (and still is, with some
limitations), but this mode of execution is strongly discouraged.

* Menu:

* Running Under Ordinary Users::
* Running in a Custom Setup::
* Setting Communication Method::

File: speech-dispatcher.info,  Node: Running Under Ordinary Users,  Next: Running in a Custom Setup,  Prev: Running,  Up: Running

2.2.1 Running Under Ordinary Users
----------------------------------

No special provisions need to be done to run Speech Dispatcher under the
current user.  The Speech Dispatcher process will use (or create) a
'~/.cache/speech-dispatcher/' directory for its purposes (logging,
pidfile).

   Optionally, a user can place his own configuration file in
'~/.config/speech-dispatcher/speechd.conf' and it will be automatically
loaded by Speech Dispatcher.  The preferred way to do so is via the
'spd-conf' configuration command.  If this user configuration file is
not found, Speech Dispatcher will simply use the system wide
configuration file (e.g.  in '/etc/speech-dispatcher/speechd.conf').

     # speech-dispatcher
     # spd-say test

File: speech-dispatcher.info,  Node: Running in a Custom Setup,  Next: Setting Communication Method,  Prev: Running Under Ordinary Users,  Up: Running

2.2.2 Running in a Custom Setup
-------------------------------

Speech Dispatcher can be run in any other setup of executing users, port
numbers and system paths as well.  The path to configuration, pidfile
and logfiles can be specified separately via compilation flags,
configuration file options or command line options in this ascending
order of their priority.

   This way can also be used to start Speech Dispatcher as a system wide
service from /etc/init.d/ , although this approach is now discouraged.

File: speech-dispatcher.info,  Node: Setting Communication Method,  Prev: Running in a Custom Setup,  Up: Running

2.2.3 Setting Communication Method
----------------------------------

Currently, two different methods are supported for communication between
the server and its clients.

   For local communication, it's preferred to use _Unix sockets_, where
the communication takes place over a Unix socket with its driving file
located by default in the user's runtime directory as
'XDG_RUNTIME_DIR/speech-dispatcher/speechd.sock'.  In this way, there
can be no conflict between different user sessions using different
Speech Dispatchers in the same system.  By default, permissions are set
in such a way, that only the same user who started the server can access
it, and communication is hidden to all other users.

   The other supported mechanism is _Inet sockets_.  The server will
thus run on a given port, which can be made accessible either localy or
to other machines on the network as well.  This is very useful in a
network setup.  Be however aware that while using Inet sockets, both
parties (server and clients) must first agree on the communication port
number to use, which can create a lot of confusion in a setup where
multiple instances of the server serve multiple different users.  Also,
since there is currently no authentication mechanism, during Inet socket
communication, the server will make no distinction between the different
users connecting to it.  The default port is 6560 as set in the server
configuration.

   Client applications will respect the _SPEECHD_ADDRESS_ environment
variable.  The method (''unix_socket'' or ''inet_socket'') is optionally
followed by it's parameters separated by a colon.  For an exact
description, please *Note Address specification::.

   An example of launching Speech Dispatcher using unix_sockets for
communication on a non-standard destination and subsequently using
spd-say to speak a message:

     killall -u `whoami` speech-dispatcher
     speech-dispatcher -c unix_socket -S /tmp/my.sock
     SPEECHD_ADDRESS=unix_socket:/tmp/my.sock spd-say "test"

File: speech-dispatcher.info,  Node: Troubleshooting,  Next: Configuration,  Prev: Running,  Up: User's Documentation

2.3 Troubleshooting
===================

If you are experiencing problems when running Speech Dispatcher, please:

   * Use 'spd-conf' to run diagnostics:

          spd-conf -d

   * Check the appropriate logfile in
     '~/.cache/speech-dispatcher/log/speech-dispatcher.log' for user
     Speech Dispatcher or in
     '/var/log/speech-dispatcher/speech-dispatcher.log'.  Look for lines
     containing the string 'ERROR' and their surrounding contents.  If
     you hear no speech, restart Speech Dispatcher and look near the end
     of the log file - before any attempts for synthesis of any message.
     Usually, if something goes wrong with the initialization of the
     output modules, a textual description of the problem and a
     suggested solution can be found in the log file.

   * If this doesn't reveal the problem, please run
          spd-conf -D

     Which will genereate a very detailed logfile archive which you can
     examine yourself or send to us with a request for help.

   * You can also try to say some message directly through the utility
     'spd-say'.

     Example:
                  spd-say "Hello, does it work?"
                  spd-say --language=cs --rate=20 "Everything ok?"

   * Check if your configuration files (speechd.conf, modules/*.conf)
     are correct (some uninstalled synthesizer specified as the default,
     wrong values for default voice parameters etc.)

   * There is a know problem in some versions of Festival.  Please make
     sure that Festival server_access_list configuration variable and
     your /etc/hosts.conf are set properly.  server_access_list must
     contain the symbolic name of your machine and this name must be
     defined in /etc/hosts.conf and point to your IP address.  You can
     test if this is set correctly by trying to connect to the port
     Festival server is running on via an ordinary telnet (by default
     like this: 'telnet localhost 1314').  If you are not rejected, it
     works.

File: speech-dispatcher.info,  Node: Configuration,  Next: Tools,  Prev: Troubleshooting,  Up: User's Documentation

2.4 Configuration
=================

Speech Dispatcher can be configured on several different levels.  You
can configure the global settings through the server configuration file,
which can be placed either in the Speech Dispatcher default
configuration system path like /etc/speech-dispatcher/ or in your home
directory in '~/.config/speech-dispatcher/'.  There is also support for
per-client configuration, this is, specifying different default values
for different client applications.

   Furthermore, applications often come with their own means of
configuring speech related settings.  Please see the documentation of
your application for details about application specific configuration.

* Menu:

* Configuration file syntax::   Basic rules.
* Configuration options::       What to configure.
* Audio Output Configuration::  How to switch to ALSA, Pulse...
* Client Specific Configuration::  Specific default values for applications.
* Output Modules Configuration::  Adding and customizing output modules.
* Log Levels::                  Description of log levels.

File: speech-dispatcher.info,  Node: Configuration file syntax,  Next: Configuration options,  Prev: Configuration,  Up: Configuration

2.4.1 Configuration file syntax
-------------------------------

We use the DotConf library to read a permanent text-file based
configuration, so the syntax might be familiar to many users.

   Each of the string constants, if not otherwise stated differently,
should be encoded in UTF-8.  The option names use only the standard
ASCII charset restricted to upper- and lowercase characters ('a', 'b'),
dashes ('-') and underscores '_'.

   Comments and temporarily inactive options begin with '#'.  If such an
option should be turned on, just remove the comment character and set it
to the desired value.
     # this is a comment
     # InactiveOption "this option is turned off"

   Strings are enclosed in doublequotes.
     LogFile  "/var/log/speech-dispatcher.log"

   Numbers are written without any quotes.
     Port 6560

   Boolean values use On (for true) and Off (for false).
     Debug Off

File: speech-dispatcher.info,  Node: Configuration options,  Next: Audio Output Configuration,  Prev: Configuration file syntax,  Up: Configuration

2.4.2 Configuration options
---------------------------

All available options are documented directly in the file and examples
are provided.  Most of the options are set to their default value and
commented out.  If you want to change them, just change the value and
remove the comment symbol '#'.

File: speech-dispatcher.info,  Node: Audio Output Configuration,  Next: Client Specific Configuration,  Prev: Configuration options,  Up: Configuration

2.4.3 Audio Output Configuration
--------------------------------

Audio output method (ALSA, Pulse etc.)  can be configured centrally from
the main configuration file 'speechd.conf'.  The option
'AudioOutputMethod' selects the desired audio method and further options
labeled as 'AudioALSA...' or 'AudioPulse...' provide a more detailed
configuration of the given audio output method.

   It is possible to use a list of preferred audio output methods, in
which case each output module attempts to use the first availble in the
given order.

   The example below prefers Pulse Audio, but will use ALSA if unable to
connect to Pulse:
      AudioOutputMethod "pulse,alsa"

   Please note however that some more simple output modules or
synthesizers, like the generic output module, do not respect these
settings and use their own means of audio output which can't be
influenced this way.  On the other hand, the fallback dummy output
module tries to use any available means of audio output to deliver its
error message.

File: speech-dispatcher.info,  Node: Client Specific Configuration,  Next: Output Modules Configuration,  Prev: Audio Output Configuration,  Up: Configuration

2.4.4 Client Specific Configuration
-----------------------------------

It is possible to automatically set different default values of speech
parameters (e.g.  rate, volume, punctuation, default voice...)  for
different applications that connect to Speech Dispatcher.  This is
especially useful for simple applications that have no parameter setting
capabilities themselves or they don't support a parameter setting you
wish to change (e.g.  language).

   Using the commands 'BeginClient "IDENTIFICATION"' and 'EndClient' it
is possible to open and close a section of parameter settings that only
affects those client applications that identify themselves to Speech
Dispatcher under the specific identification code which is matched
against the string 'IDENTIFICATION'.  It is possible to use wildcards
('*' matches any number of characters and '?'  matches exactly one
character) in the string 'IDENTIFICATION'.

   The identification code normally consists of 3 parts:
'user:application:connection'.  'user' is the username of the one who
started the application, 'application' is the name of the application
(usually the name of the binary for it) and 'connection' is a name for
the connection (one application might use more connections for different
purposes).

   An example is provided in '/etc/speech-dispatcher/speechd.conf' (see
the line 'Include "clients/emacs.conf"' and
'/etc/speech-dispatcher/clients/emacs.conf'.

File: speech-dispatcher.info,  Node: Output Modules Configuration,  Next: Log Levels,  Prev: Client Specific Configuration,  Up: Configuration

2.4.5 Output Modules Configuration
----------------------------------

Each user should turn on at least one output module in his
configuration, if he wants Speech Dispatcher to produce any sound
output.  If no output module is loaded, Speech Dispatcher will start,
log messages into history and communicate with clients, but no sound is
produced.

   Each output module has an "AddModule" line in
'speech-dispatcher/speechd.conf'.  Additionally, each output module can
have its own configuration file.

   The audio output is handled by the output modules themselves, so this
can be switched in their own configuration files under
'etc/speech-dispatcher/modules/'.

* Menu:

* Loading Modules in speechd.conf::
* Configuration files of output modules::
* Configuration of the Generic Output Module::

File: speech-dispatcher.info,  Node: Loading Modules in speechd.conf,  Next: Configuration files of output modules,  Prev: Output Modules Configuration,  Up: Output Modules Configuration

2.4.5.1 Loading Modules in speechd.conf
.......................................

Each module that should be run when Speech Dispatcher starts must be
loaded by the 'AddModule' command in the configuration.  Note that you
can load one binary module multiple times under different names with
different configurations.  This is especially useful for loading the
generic output module.  *Note Configuration of the Generic Output
Module::.

     AddModule "MODULE_NAME" "MODULE_BINARY" "MODULE_CONFIG"

   MODULE_NAME is the name of the output module.

   MODULE_BINARY is the name of the binary executable of this output
module.  It can be either absolute or relative to
'bin/speechd-modules/'.

   MODULE_CONFIG is the file where the configuration for this output
module is stored.  It can be either absolute or relative to
'etc/speech-dispatcher/modules/'.  This parameter is optional.

File: speech-dispatcher.info,  Node: Configuration files of output modules,  Next: Configuration of the Generic Output Module,  Prev: Loading Modules in speechd.conf,  Up: Output Modules Configuration

2.4.5.2 Configuration Files of Output Modules
.............................................

Each output module is different and therefore has different
configuration options.  Please look at the comments in its configuration
file for a detailed description.  However, there are several options
which are common for some output modules.  Here is a short overview of
them.

   * AddVoice "LANGUAGE" "SYMBOLICNAME" "NAME"

     Each output module provides some voices and sometimes it even
     supports different languages.  For this reason, there is a common
     mechanism for specifying these in the configuration, although no
     module is obligated to use it.  Some synthesizers, e.g.  Festival,
     support the SSIP symbolic names directly, so the particular
     configuration of these voices is done in the synthesizer itself.

     For each voice, there is exactly one 'AddVoice' line.

     LANGUAGE is the ISO language code of the language of this voice.

     SYMBOLICNAME is a symbolic name under which you wish this voice to
     be available.  See *note Standard Voices: (ssip)Top. for the list
     of names you can use.

     NAME is a name specific for the given output module.  Please see
     the comments in the configuration file under the appropriate
     AddModule section for more info.

     For example our current definition of voices for Epos (file
     '/etc/speech-dispatcher/modules/generic-epos.conf' looks like this:

                  AddVoice        "cs"  "male1"   "kadlec"
                  AddVoice        "sk"  "male1"   "bob"

   * ModuleDelimiters "DELIMITERS", ModuleMaxChunkLength LENGTH

     Normally, the output module doesn't try to synthesize all incoming
     text at once, but instead it cuts it into smaller chunks
     (sentences, parts of sentences) and then synthesizes them one by
     one.  This second approach, used by some output modules, is much
     faster, however it limits the ability of the output module to
     provide good intonation.

     NOTE: The Festival module does not use ModuleDelimiters and
     ModuleMaxChunkLength.

     For this reason, you can configure at which characters (DELIMITERS)
     the text should be cut into smaller blocks or after how many
     characters (LENGTH) it should be cut, if there is no DELIMITER
     found.

     Making the two rules more strict, you will get better speed but
     give away some quality of intonation.  So for example for slower
     computers, we recommend to include comma (,) in DELIMITERS so that
     sentences are cut into phrases, while for faster computers, it's
     preferable not to include comma and synthesize the whole compound
     sentence.

     The same applies to 'MaxChunkLength', it's better to set higher
     values for faster computers.

     For example, curently the default for Flite is

              FestivalMaxChunkLength  500
              FestivalDelimiters  ".?!;"

     The output module may also decide to cut sentences on delimiters
     only if they are followed by a space.  This way for example
     "file123.tmp" would not be cut in two parts, but "The horse raced
     around the fence, that was lately painted green, fell."  would be.
     (This is an interesting sentence, by the way.)

File: speech-dispatcher.info,  Node: Configuration of the Generic Output Module,  Prev: Configuration files of output modules,  Up: Output Modules Configuration

2.4.5.3 Configuration files of the Generic Output Module
........................................................

The generic output module allows you to easily write your own output
module for synthesizers that have a simple command line interface by
modifying the configuration file.  This way, users can add support for
their device even if they don't know how to program.  *Note AddModule::.

   The core part of a generic output module is the command execution
line.

 -- Generic Module Configuration: GenericExecuteSynth "EXECUTION_STRING"

     'execution_string' is the command that should be executed in a
     shell when it's desired to say something.  In fact, it can be
     multiple commands concatenated by the '&&' operator.  To stop
     saying the message, the output module will send a KILL signal to
     the process group, so it's important that it immediately stops
     speaking after the processes are killed.  (On most GNU/Linux
     system, the 'play' utility has this property).

     In the execution string, you can use the following variables, which
     will be substituted by the desired values before executing the
     command.

        * '$DATA' The text data that should be said.  The string's
          characters that would interfere with bash processing are
          already escaped.  However, it may be necessary to put double
          quotes around it (like this: '\"$DATA\"').
        * '$LANG' The language identification string (it's defined by
          GenericLanguage).
        * '$VOICE' The voice identification string (it's defined by
          AddVoice).
        * '$PITCH' The desired pitch (a float number defined in
          GenericPitchAdd and GenericPitchMultiply).
        * '$RATE' The desired rate or speed (a float number defined in
          GenericRateAdd and GenericRateMultiply)

     Here is an example from
     'etc/speech-dispatcher/modules/epos-generic.conf'
          GenericExecuteSynth \
          "epos-say -o --language $LANG --voice $VOICE --init_f $PITCH --init_t $RATE \
          \"$DATA\" | sed -e s+unknown.*$++ >/tmp/epos-said.wav && play /tmp/epos-said.wav >/dev/null"

 -- GenericModuleConfiguration: AddVoice "LANGUAGE" "SYMBOLICNAME"
          "NAME"
     *Note AddVoice::.

 -- GenericModuleConfiguration: GenericLanguage "iso-code"
          "string-subst"

     Defines which string 'string-subst' should be substituted for
     '$LANG' given an 'iso-code' language code.

     Another example from Epos generic:
          GenericLanguage "en" "english"
          GenericLanguage "cs" "czech"
          GenericLanguage "sk" "slovak"

 -- GenericModuleConfiguration: GenericRateAdd NUM
 -- GenericModuleConfiguration: GenericRateMultiply NUM
 -- GenericModuleConfiguration: GenericPitchAdd NUM
 -- GenericModuleConfiguration: GenericPitchMultiply NUM
     These parameters set rate and pitch conversion to compute the value
     of '$RATE' and '$PITCH'.

     The resulting rate (or pitch) is calculated using the following
     formula:
             (speechd_rate * GenericRateMultiply) + GenericRateAdd
     where speechd_rate is a value between -100 (lowest) and +100
     (highest) Some meaningful conversion for the specific
     text-to-speech system used must by defined.

     (The values in GenericSthMultiply are multiplied by 100 because
     DotConf currently doesn't support floats.  So you can write 0.85 as
     85 and so on.)

File: speech-dispatcher.info,  Node: Log Levels,  Prev: Output Modules Configuration,  Up: Configuration

2.4.6 Log Levels
----------------

There are 6 different verbosity levels of Speech Dispatcher logging.  0
means no logging, while 5 means that nearly all the information about
Speech Dispatcher's operation is logged.

   * Level 0
        * No information.

   * Level 1
        * Information about loading and exiting.

   * Level 2
        * Information about errors that occurred.
        * Allocating and freeing resources on start and exit.

   * Level 3
        * Information about accepting/rejecting/closing clients'
          connections.
        * Information about invalid client commands.

   * Level 4
        * Every received command is output.
        * Information preceding the command output.
        * Information about queueing/allocating messages.
        * Information about the history, sound icons and other
          facilities.
        * Information about the work of the speak() thread.

   * Level 5 (This is only for debugging purposes and will output *a
     lot* of data.  Use with caution.)
        * Received data (messages etc.)  is output.
        * Debugging information.

File: speech-dispatcher.info,  Node: Tools,  Next: Synthesis Output Modules,  Prev: Configuration,  Up: User's Documentation

2.5 Tools
=========

Several small tools are distributed together with Speech Dispatcher.
'spd-say' is a small client that allows you to send messages to Speech
Dispatcher in an easy way and have them spoken, or cancel speech from
other applications.

* Menu:

* spd-say::                     Say a given text or cancel messages in Dispatcher.
* spd-conf::                    Configuration, diagnostics and troubleshooting tool
* spd-send::                    Direct SSIP communication from command line.

File: speech-dispatcher.info,  Node: spd-say,  Next: spd-conf,  Prev: Tools,  Up: Tools

2.5.1 spd-say
-------------

spd-say is documented in its own manual.  *Note (spd-say)Top::.

File: speech-dispatcher.info,  Node: spd-conf,  Next: spd-send,  Prev: spd-say,  Up: Tools

2.5.2 spd-conf
--------------

spd-conf is a tool for creating basic configuration, initial setup of
some basic settings (output module, audio method), diagnostics and
automated debugging with a possibility to send the debugging output to
the developers with a request for help.

   The available command options are self-documented through 'spd-say
-h'.  In any working mode, the tool asks the user about future actions
and preferred configuration of the basic options.

   Most useful ways of execution are:
   * 'spd-conf' Create new configuration and setup basic settings
     according to user answers.  Run diagnostics and if some problems
     occur, run debugging and offer to send a request for help to the
     developers.

   * 'spd-conf -d' Run diagnostics of problems.

   * 'spd-conf -D' Run debugging and offer to send a request for help to
     the developers.

File: speech-dispatcher.info,  Node: spd-send,  Prev: spd-conf,  Up: Tools

2.5.3 spd-send
--------------

spd-send is a small client/server application that allows you to
establish a connection to Speech Dispatcher and then use a simple
command line tool to send and receive SSIP protocol communication.

   Please see 'src/c/clients/spd-say/README' in the Speech Dispatcher's
source tree for more information.

File: speech-dispatcher.info,  Node: Synthesis Output Modules,  Next: Security,  Prev: Tools,  Up: User's Documentation

2.6 Synthesis Output Modules
============================

Speech Dispatcher supports concurrent use of multiple output modules.
If the output modules provide good synchronization, you can combine them
when reading messages.  For example if module1 can speak English and
Czech while module2 speaks only German, the idea is that if there is
some message in German, module2 is used, while module1 is used for the
other languages.  However the language is not the only criteria for the
decision.  The rules for selection of an output module can be influenced
through the configuration file 'speech-dispatcher/speechd.conf'.

* Menu:

* Provided Functionality::      Some synthesizers don't support the full set of SSIP features.

File: speech-dispatcher.info,  Node: Provided Functionality,  Prev: Synthesis Output Modules,  Up: Synthesis Output Modules

2.6.1 Provided functionality
----------------------------

Please note that some output modules don't support the full Speech
Dispatcher functionality (e.g.  spelling mode, sound icons).  If there
is no easy way around the missing functionality, we don't try to emulate
it in some complicated way and rather try to encourage the developers of
that particular synthesizer to add that functionality.  We are actively
working on adding the missing parts to Festival, so Festival supports
nearly all of the features of Speech Dispatcher and we encourage you to
use it.  Much progress has also been done with eSpeak.

* Menu:

* Supported Modules::

File: speech-dispatcher.info,  Node: Supported Modules,  Prev: Provided Functionality,  Up: Provided Functionality

2.6.1.1 Supported Modules
.........................

   * Festival Festival is a free software multi-language Text-to-Speech
     synthesis system that is very flexible and extensible using the
     Scheme scripting language.  Currently, it supports high quality
     synthesis for several languages, and on today's computers it runs
     reasonably fast.  If you are not sure which one to use and your
     language is supported by Festival, we advise you to use it.  See
     <http://www.cstr.ed.ac.uk/projects/festival/>.

   * eSpeak eSpeak is a newer very lightweight free software engine with
     a broad range of supported languages and a good quality of voice at
     high rates.  See <http://espeak.sourceforge.net/>.

   * Flite Flite (Festival Light) is a lightweight free software TTS
     synthesizer intended to run on systems with limited resources.  At
     this time, it has only one English voice and porting voices from
     Festival looks rather difficult.  With the caching mechanism
     provided by Speech Dispatcher, Festival is faster than Flite in
     most situations.  See <http://www.speech.cs.cmu.edu/flite/>.

   * Generic The Generic module can be used with any synthesizer that
     can be managed by a simple command line application.  *Note
     Configuration of the Generic Output Module::, for more details
     about how to use it.  However, it provides only very rudimentary
     support of speaking.

   * Pico The SVOX Pico engine is a software speech synthesizer for
     German, English (GB and US), Spanish, French and Italian.  SVOX
     produces clear and distinct speech output made possible by the use
     of Hidden Markov Model (HMM) algorithms.  See
     <http://git.debian.org/?p=collab-maint/svox.git>.  Pico
     documentation can be found at
     <http://android.git.kernel.org/?p=platform/external/svox.git;
     a=tree;f=pico_resources/docs> It includes three manuals: -
     SVOX_Pico_Lingware.pdf - SVOX_Pico_Manual.pdf -
     SVOX_Pico_architecture_and_design.pdf

File: speech-dispatcher.info,  Node: Security,  Prev: Synthesis Output Modules,  Up: User's Documentation

2.7 Security
============

Speech Dispatcher doesn't implement any special authentication
mechanisms but uses the standard system mechanisms to regulate access.

   If the default 'unix_socket' communication mechanism is used, only
the user who starts the server can connect to it due to imposed
restrictions on the unix socket file permissions.

   In case of the 'inet_socket' communication mechanism, where clients
connect to Speech Dispatcher on a specified port, theoretically everyone
could connect to it.  The access is by default restricted only for
connections originating on the same machine, which can be changed via
the LocalhostAccessOnly option in the server configuration file.  In
such a case, the user is reponsible to set appropriate security
restrictions on the access to the given port on his machine from the
outside network using a firewall or similar mechanism.

File: speech-dispatcher.info,  Node: Technical Specifications,  Next: Client Programming,  Prev: User's Documentation,  Up: Top

3 Technical Specifications
**************************

* Menu:

* Communication mechanisms::
* Address specification::
* Actions performed on startup::
* Accepted signals::

File: speech-dispatcher.info,  Node: Communication mechanisms,  Next: Address specification,  Prev: Technical Specifications,  Up: Technical Specifications

3.1 Communication mechanisms
============================

Speech Dispatcher supports two communicatino mechanisms: UNIX-style and
Inet sockets, which are refered as 'unix-socket' and 'inet-socket'
respectively.  The communication mechanism is decided on startup and
cannot be changed at runtime.  Unix sockets are now the default and
preferred variant for local communication, Inet sockets are necessary
for communication over network.

   The mechanism for the decision of which method to use is as follows
in this order of precedence: command-line option, configuration option,
the default value 'unix-socket'.

   _Unix sockets_ are associated with a file in the filesystem.  By
default, this file is placed in the user's runtime directory (as
determined by the value of the XDG_RUNTIME_DIR environment variable and
the system configuration for the given user).  It's default name is
constructed as 'XDG_RUNTIME_DIR/speech-dispatcher/speechd.sock'.  The
access permissions for this file are set to 600 so that it's restricted
to read/write by the current user.

   As such, access is handled properly and there are no conflicts
between the different instances of Speech Dispatcher run by the
different users.

   Client applications and libraries are supposed to independently
replicate the process of construction of the socket path and connect to
it, thus establishing a common communication channel in the default
setup.

   It should be however possible in the client libraries and is possible
in the server, to define a custom file as a socket name if needed.
Client libraries should respect the SPEECHD_ADDRESS environment
variable.

   _Inet sockets_ are based on communication over a given port on the
given host, two variables which must be previously agreed between the
server and client before a connection can be established.  The only
implicit security restriction is the server configuration option which
can allow or disallow access from machines other than localhost.

   By convention, the clients should use host and port given by one of
the following sources in the following order of precedence: its own
configuration, value of the SPEECHD_ADDRESS environment variable and the
default pair (localhost, 6560).

   *Note Setting Communication Method::.

File: speech-dispatcher.info,  Node: Address specification,  Next: Actions performed on startup,  Prev: Communication mechanisms,  Up: Technical Specifications

3.2 Address specification
=========================

Speech Dispatcher provies several methods of communication and can be
used both locally and over network.  *Note Communication mechanisms::.
Client applications and interface libraries need to recognize an
address, which specifies how and where to contact the appropriate
server.

   Address specification consits from the method and one or more of its
parameters, each item separated by a colon:

     method:parameter1:parameter2

   The method is either 'unix_socket' or 'inet_socket'.  Parameters are
optional.  If not used in the address line, their default value will be
used.

   Two forms are currently recognized:

     unix_socket:full/path/to/socket
     inet_socket:host_ip:port

   Examples of valid address lines are:
     unix_socket
     unix_socket:/tmp/test.sock
     inet_socket
     inet_socket:192.168.0.34
     inet_socket:192.168.0.34:6563

   Clients implement different mechanisms how the user can set the
address.  Clients should respect the SPEECHD_ADDRESS environment
variable *Note Setting Communication Method::, unless the user
ovverrides its value by settins in the client application itself.
Clients should fallback to the default address, if neither the
environment variable or their specific configuration is set.

   The default communication address currently is:

     unix_socket:/$XDG_RUNTIME_DIR/speech-dispatcher/speechd.sock

   where '~' stands for the path to the users home directory.

File: speech-dispatcher.info,  Node: Actions performed on startup,  Next: Accepted signals,  Prev: Address specification,  Up: Technical Specifications

3.3 Actions performed on startup
================================

What follows is an overview of the actions the server takes on startup
in this order:

   * Initialize logging stage 1

     Set loglevel to 1 and log destination to stderr (logfile is not
     ready yet).

   * Parse command line options

     Read preferred communication method, destinations for logfile and
     pidfile

   * Establish the '~/.config/speech-dispatcher/' and
     '~/.cache/speech-dispatcher/' directories

     If pid and conf paths were not given as command line options, the
     server will place them in '~/.config/speech-dispatcher/' and
     '~/.cache/speech-dispatcher/' by default.  If they are not
     specified AND the current user doesn't have a system home
     directory, the server will fail startup.

     The configuration file is pointed to
     '~/.config/speech-dispatcher/speechd.conf' if it exists, otherwise
     to '/etc/speech-dispatcher/speechd.conf' or a similar system
     location according to compile options.  One of these files must
     exists, otherwise Speech Dispatcher will not know where to find its
     output modules.

   * Create pid file

     Check the pid file in the determined location.  If an instance of
     the server is already running, log an error message and exit with
     error code 1, otherwise create and lock a new pid file.

   * Check for autospawning enabled

     If the server is started with -spawn, check whether autospawn is
     not disabled in the configuration (DisableAutoSpawn config option
     in speechd.conf).  If it is disabled, log an error message and exit
     with error code 1.

   * Install signal handlers

   * Create unix or inet sockets and start listening

   * Initialize Speech Dispatcher

     Read the configuration files, setup some lateral threads, start and
     initialize output modules.  Reinitialize logging (stage 2) into the
     final logfile destination (as determined by the command line
     option, the configuration option and the default location in this
     order of precedence).

     After this step, Speech Dispatcher is ready to accept new
     connections.

   * Daemonize the process

     Fork the process, disconnect from standard input and outputs,
     disconnect from parent process etc.  as prescribed by the POSIX
     standards.

   * Initialize the speaking lateral thread

     Initialize the second main thread which will process the speech
     request from the queues and pass them onto the Speech Dispatcher
     modules.

   * Start accepting new connections from clients

     Start listening for new connections from clients and processing
     them in a loop.

File: speech-dispatcher.info,  Node: Accepted signals,  Prev: Actions performed on startup,  Up: Technical Specifications

3.4 Accepted signals
====================

   * SIGINT

     Terminate the server

   * SIGHUP

     Reload configuration from config files but do not restart modules

   * SIGUSR1

     Reload dead output modules (modules which were previously working
     but crashed during runtime and marked as dead)

   * SIGPIPE

     Ignored

File: speech-dispatcher.info,  Node: Client Programming,  Next: Server Programming,  Prev: Technical Specifications,  Up: Top

4 Client Programming
********************

Clients communicate with Speech Dispatcher via the Speech Synthesis
Internet Protocol (SSIP) *Note (ssip)Top::.  The protocol is the actual
interface to Speech Dispatcher.

   Usually you don't need to use SSIP directly.  You can use one of the
supplied libraries, which wrap the SSIP interface.  This is the
recommended way of communicating with Speech Dispatcher.  We try so
support as many programming environments as possible.  This manual
(except SSIP) contains documentation for the C and Python libraries,
however there are also other libraries developed as external projects.
Please contact us for information about current external client
libraries.

* Menu:

* C API::                       Shared library for C/C++
* Python API::                  Python module.
* Guile API::
* Common Lisp API::
* Autospawning::                How server is started from clients

File: speech-dispatcher.info,  Node: C API,  Next: Python API,  Prev: Client Programming,  Up: Client Programming

4.1 C API
=========

* Menu:

* Initializing and Terminating in C::
* Speech Synthesis Commands in C::
* Speech output control commands in C::
* Characters and Keys in C::
* Sound Icons in C::
* Parameter Setting Commands in C::
* Other Functions in C::
* Information Retrieval Commands in C::
* Event Notification and Index Marking in C::
* History Commands in C::
* Direct SSIP Communication in C::

File: speech-dispatcher.info,  Node: Initializing and Terminating in C,  Next: Speech Synthesis Commands in C,  Prev: C API,  Up: C API

4.1.1 Initializing and Terminating
----------------------------------

 -- C API function: SPDConnection* spd_open(char* client_name, char*
          connection_name, char* user_name, SPDConnectionMode
          connection_mode)

     Opens a new connection to Speech Dispatcher and returns a socket
     file descriptor you will use to communicate with Speech Dispatcher.
     The socket file descriptor is a parameter used in all the other
     functions.  It now uses local communication via inet sockets.  See
     'spd_open2' for more details.

     The three parameters 'client_name', 'connection_name' and
     'username' are there only for informational and navigational
     purposes, they don't affect any settings or behavior of any
     functions.  The authentication mechanism has nothing to do with
     'username'.  These parameters are important for the user when he
     wants to set some parameters for a given session, when he wants to
     browse through history, etc.  The parameter 'connection_mode'
     specifies how this connection should be handled internally and if
     event notifications and index marking capabilities will be
     available.

     'client_name' is the name of the client that opens the connection.
     Normally, it should be the name of the executable, for example
     "lynx", "emacs", "bash", or "gcc".  It can be left as NULL.

     'connection_name' determines the particular use of that connection.
     If you use only one connection in your program, this should be set
     to "main" (passing a NULL pointer has the same effect).  If you use
     two or more connections in your program, their 'client_name's
     should be the same, but 'connection_name's should differ.  For
     example: "buffer", "command_line", "text", "menu".

     'username' should be set to the name of the user.  Normally, you
     should get this string from the system.  If set to NULL, libspeechd
     will try to determine it automatically by g_get_user_name().

     'connection_mode' has two possible values: 'SPD_MODE_SINGLE' and
     'SPD_MODE_THREADED'.  If the parameter is set to
     'SPD_MODE_THREADED', then 'spd_open()' will open an additional
     thread in your program which will handle asynchronous SSIP replies
     and will allow you to use callbacks for event notifications and
     index marking, allowing you to keep track of the progress of
     speaking the messages.  However, you must be aware that your
     program is now multi-threaded and care must be taken when
     using/handling signals.  If 'SPD_MODE_SINGLE' is chosen, the
     library won't execute any additional threads and SSIP will run only
     as a synchronous protocol, therefore event notifications and index
     marking won't be available.

     It returns a newly allocated SPDConnection* structure on success,
     or 'NULL' on error.

     Each connection you open should be closed by spd_close() before the
     end of the program, so that the associated connection descriptor is
     closed, threads are terminated and memory is freed.

 -- C API function: SPDConnection* spd_open2(char* client_name, char*
          connection_name, char* user_name, SPDConnectionMode
          connection_mode, SPDConnectionMethod method, int autospawn)

     Opens a new connection to Speech Dispatcher and returns a socket
     file descriptor.  This function is the same as 'spd_open' except
     that it gives more control of the communication method and
     autospawn functionality as described below.

     'method' is either 'SPD_METHOD_UNIX_SOCKET' or
     'SPD_METHOD_INET_SOCKET'.  By default, unix socket communication
     should be preferred, but inet sockets are necessary for
     cross-network communication.

     'autospawn' is a boolean flag specifying whether the function
     should try to autospawn (autostart) the Speech Dispatcher server
     process if it is not running already.  This is set to 1 by default,
     so this function should normally not fail even if the server is not
     yet running.

 -- C API function: void spd_close(SPDConnection *connection)

     Closes a Speech Dispatcher socket connection, terminates associated
     threads (if necessary) and frees the memory allocated by
     spd_open().  You should close every connection before the end of
     your program.

     'connection' is the SPDConnection connection obtained by
     spd_open().

File: speech-dispatcher.info,  Node: Speech Synthesis Commands in C,  Next: Speech output control commands in C,  Prev: Initializing and Terminating in C,  Up: C API

4.1.2 Speech Synthesis Commands
-------------------------------

 -- Variable: C API type SPDPriority

     'SPDPriority' is an enum type that represents the possible
     priorities that can be assigned to a message.

          typedef enum{
              SPD_IMPORTANT = 1,
              SPD_MESSAGE = 2,
              SPD_TEXT = 3,
              SPD_NOTIFICATION = 4,
              SPD_PROGRESS = 5
          }SPDPriority;

     *Note Message Priority Model: (ssip)Top.

 -- C API function: int spd_say(SPDConnection* connection, SPDPriority
          priority, char* text);

     Sends a message to Speech Dispatcher.  If this message isn't
     blocked by some message of higher priority and this CONNECTION
     isn't paused, it will be synthesized directly on one of the output
     devices.  Otherwise, the message will be discarded or delayed
     according to its priority.

     'connection' is the SPDConnection* connection created by
     spd_open().

     'priority' is the desired priority for this message.  *Note Message
     Priority Model: (ssip)Top.

     'text' is a null terminated string containing text you want sent to
     synthesis.  It must be encoded in UTF-8.  Note that this doesn't
     have to be what you will finally hear.  It can be affected by
     different settings, such as spelling, punctuation, text
     substitution etc.

     It returns a positive unique message identification number on
     success, -1 otherwise.  This message identification number can be
     saved and used for the purpose of event notification callbacks or
     history handling.

 -- C API function: int spd_sayf(SPDConnection* connection, SPDPriority
          priority, char* format, ...);

     Similar to 'spd_say()', simulates the behavior of printf().

     'format' is a string containing text and formatting of the
     parameters, such as "%d", "%s" etc.  It must be encoded in UTF-8.

     '...' is an arbitrary number of arguments.

     All other parameters are the same as for spd_say().

     For example:
                 spd_sayf(conn, SPD_TEXT, "Hello %s, how are you?", username);
                 spd_sayf(conn, SPD_IMPORTANT, "Fatal error on [%s:%d]", filename, line);

     But be careful with unicode!  For example this doesn't work:

                 spd_sayf(conn, SPD_NOTIFY, ``Pressed key is %c.'', key);

     Why?  Because you are supposing that key is a char, but that will
     fail with languages using multibyte charsets.  The proper solution
     is:

                 spd_sayf(conn, SPD_NOTIFY, ``Pressed key is %s'', key);
     where key is an encoded string.

     It returns a positive unique message identification number on
     success, -1 otherwise.  This message identification number can be
     saved and used for the purpose of event notification callbacks or
     history handling.

File: speech-dispatcher.info,  Node: Speech output control commands in C,  Next: Characters and Keys in C,  Prev: Speech Synthesis Commands in C,  Up: C API

4.1.3 Speech Output Control Commands
------------------------------------

Stop Commands
.............

 -- C API function: int spd_stop(SPDConnection* connection);

     Stops the message currently being spoken on a given connection.  If
     there is no message being spoken, does nothing.  (It doesn't touch
     the messages waiting in queues).  This is intended for stops
     executed by the user, not for automatic stops (because
     automatically you can't control how many messages are still waiting
     in queues on the server).

     'connection' is the SPDConnection* connection created by
     spd_open().

     It returns 0 on success, -1 otherwise.

 -- C API function: int spd_stop_all(SPDConnection* connection);

     The same as spd_stop(), but it stops every message being said,
     without distinguishing where it came from.

     It returns 0 on success, -1 if some of the stops failed.

 -- C API function: int spd_stop_uid(SPDConnection* connection, int
          target_uid);

     The same as spd_stop() except that it stops a client client
     different from the calling one.  You must specify this client in
     'target_uid'.

     'target_uid' is the unique ID of the connection you want to execute
     stop() on.  It can be obtained from spd_history_get_client_list().
     *Note History Commands in C::.

     It returns 0 on success, -1 otherwise.

Cancel Commands
...............

 -- C API function: int spd_cancel(SPDConnection* connection);

     Stops the currently spoken message from this connection (if there
     is any) and discards all the queued messages from this connection.
     This is probably what you want to do, when you call spd_cancel()
     automatically in your program.

 -- C API function: int spd_cancel_all(SPDConnection* connection);

     The same as spd_cancel(), but it cancels every message without
     distinguishing where it came from.

     It returns 0 on success, -1 if some of the stops failed.

 -- C API function: int spd_cancel_uid(SPDConnection* connection, int
          target_uid);

     The same as spd_cancel() except that it executes cancel for some
     other client than the calling one.  You must specify this client in
     'target_uid'.

     'target_uid' is the unique ID of the connection you want to execute
     cancel() on.  It can be obtained from
     spd_history_get_client_list().  *Note History Commands in C::.

     It returns 0 on success, -1 otherwise.

Pause Commands
..............

 -- C API function: int spd_pause(SPDConnection* connection);

     Pauses all messages received from the given connection.  No
     messages except for priority 'notification' and 'progress' are
     thrown away, they are all waiting in a separate queue for resume().
     Upon resume(), the message that was being said at the moment
     pause() was received will be continued from the place where it was
     paused.

     It returns immediately.  However, that doesn't mean that the speech
     output will stop immediately.  Instead, it can continue speaking
     the message for a while until a place where the position in the
     text can be determined exactly is reached.  This is necessary to be
     able to provide 'resume' without gaps and overlapping.

     When pause is on for the given client, all newly received messages
     are also queued and waiting for resume().

     It returns 0 on success, -1 if something failed.

 -- C API function: int spd_pause_all(SPDConnection* connection);

     The same as spd_pause(), but it pauses every message, without
     distinguishing where it came from.

     It returns 0 on success, -1 if some of the pauses failed.

 -- C API function: int spd_pause_uid(SPDConnection* connection, int
          target_uid);

     The same as spd_pause() except that it executes pause for a client
     different from the calling one.  You must specify the client in
     'target_uid'.

     'target_uid' is the unique ID of the connection you want to pause.
     It can be obtained from spd_history_get_client_list().  *Note
     History Commands in C::.

     It returns 0 on success, -1 otherwise.

Resume Commands
...............

 -- C API function: int spd_resume(SPDConnection* connection);

     Resumes all paused messages from the given connection.  The rest of
     the message that was being said at the moment pause() was received
     will be said and all the other messages are queued for synthesis
     again.

     'connection' is the SPDConnection* connection created by
     spd_open().

     It returns 0 on success, -1 otherwise.

 -- C API function: int spd_resume_all(SPDConnection* connection);

     The same as spd_resume(), but it resumes every paused message,
     without distinguishing where it came from.

     It returns 0 on success, -1 if some of the pauses failed.

 -- C API function: int spd_resume_uid(SPDConnection* connection, int
          target_uid);

     The same as spd_resume() except that it executes resume for a
     client different from the calling one.  You must specify the client
     in 'target_uid'.

     'target_uid' is the unique ID of the connection you want to resume.
     It can be obtained from spd_history_get_client_list().  *Note
     History Commands in C::.

     It returns 0 on success, -1 otherwise.

File: speech-dispatcher.info,  Node: Characters and Keys in C,  Next: Sound Icons in C,  Prev: Speech output control commands in C,  Up: C API

4.1.4 Characters and Keys
-------------------------

 -- C API function: int spd_char(SPDConnection* connection, SPDPriority
          priority, char* character);

     Says a character according to user settings for characters.  For
     example, this can be used for speaking letters under the cursor.

     'connection' is the SPDConnection* connection created by
     spd_open().

     'priority' is the desired priority for this message.  *Note Message
     Priority Model: (ssip)Top.

     'character' is a NULL terminated string of chars containing one
     UTF-8 character.  If it contains more characters, only the first
     one is processed.

     It returns 0 on success, -1 otherwise.

 -- C API function: int spd_wchar(SPDConnection* connection, SPDPriority
          priority, wchar_t wcharacter);

     The same as spd_char(), but it takes a wchar_t variable as its
     argument.

     It returns 0 on success, -1 otherwise.

 -- C API function: int spd_key(SPDConnection* connection, SPDPriority
          priority, char* key_name);

     Says a key according to user settings for keys.

     'connection' is the SPDConnection* connection created by
     spd_open().

     'priority' is the desired priority for this message.  *Note Message
     Priority Model: (ssip)Top.

     'key_name' is the name of the key in a special format.  *Note
     Speech Synthesis and Sound Output Commands: (ssip)Top, (KEY, the
     corresponding SSIP command) for description of the format of
     'key_name'

     It returns 0 on success, -1 otherwise.

File: speech-dispatcher.info,  Node: Sound Icons in C,  Next: Parameter Setting Commands in C,  Prev: Characters and Keys in C,  Up: C API

4.1.5 Sound Icons
-----------------

 -- C API function: int spd_sound_icon(SPDConnection* connection,
          SPDPriority priority, char* icon_name);

     Sends a sound icon ICON_NAME. These are symbolic names that are
     mapped to a sound or to a text string (in the particular language)
     according to Speech Dispatcher tables and user settings.  Each
     program can also define its own icons.

     'connection' is the SPDConnection* connection created by
     spd_open().

     'priority' is the desired priority for this message.  *Note Message
     Priority Model: (ssip)Top.

     'icon_name' is the name of the icon.  It can't contain spaces,
     instead use underscores ('_').  Icon names starting with an
     underscore are considered internal and shouldn't be used.

File: speech-dispatcher.info,  Node: Parameter Setting Commands in C,  Next: Other Functions in C,  Prev: Sound Icons in C,  Up: C API

4.1.6 Parameter Settings Commands
---------------------------------

The following parameter setting commands are available.  For
configuration and history clients there are also functions for setting
the value for some other connection and for all connections.  They are
listed separately below.

   Please see *note Parameter Setting Commands: (ssip)Top. for a general
description of what they mean.

 -- C API function: int spd_set_data_mode(SPDConnection *connection,
          SPDDataMode mode)

     Set Speech Dispatcher data mode.  Currently, plain text and SSML
     are supported.  SSML is especially useful if you want to use index
     marks or include changes of voice parameters in the text.

     'mode' is the requested data mode: 'SPD_DATA_TEXT' or
     'SPD_DATA_SSML'.

 -- C API function: int spd_set_language(SPDConnection* connection,
          char* language);

     Sets the language that should be used for synthesis.

     'connection' is the SPDConnection* connection created by
     spd_open().

     'language' is the language code as defined in RFC 1766 ("cs", "en",
     ...).

 -- C API function: int spd_set_output_module(SPDConnection* connection,
          char* output_module);

     Sets the output module that should be used for synthesis.  The
     parameter of this command should always be entered by the user in
     some way and not hardcoded anywhere in the code as the available
     synthesizers and their registration names may vary from machine to
     machine.

     'connection' is the SPDConnection* connection created by
     spd_open().

     'output_module' is the output module name under which the module
     was loaded into Speech Dispatcher in its configuration ("flite",
     "festival", "epos-generic"...  )

 -- C API function: char* spd_get_output_module(SPDConnection*
          connection);

     Gets the current output module in use for synthesis.

     'connection' is the SPDConnection* connection created by
     spd_open().

     It returns the output module name under which the module was loaded
     into Speech Dispatcher in its configuration ("flite", "festival",
     "espeak"...  )

 -- C API function: int spd_set_punctuation(SPDConnection* connection,
          SPDPunctuation type);

     Set punctuation mode to the given value.  'all' means speak all
     punctuation characters, 'none' menas speak no punctuation
     characters, 'some' means speak only punctuation characters given in
     the server configuration or defined by the client's last
     spd_set_punctuation_important().

     'connection' is the SPDConnection* connection created by
     spd_open().

     'type' is one of the following values: 'SPD_PUNCT_ALL',
     'SPD_PUNCT_NONE', 'SPD_PUNCT_SOME'.

     It returns 0 on success, -1 otherwise.

 -- C API function: int spd_set_spelling(SPDConnection* connection,
          SPDSpelling type);

     Switches spelling mode on and off.  If set to on, all incoming
     messages from this particular connection will be processed
     according to appropriate spelling tables (see
     spd_set_spelling_table()).

     'connection' is the SPDConnection* connection created by
     spd_open().

     'type' is one of the following values: 'SPD_SPELL_ON',
     'SPD_SPELL_OFF'.

 -- C API function: int spd_set_voice_type(SPDConnection* connection,
          SPDVoiceType voice);

     Set a preferred symbolic voice.

     'connection' is the SPDConnection* connection created by
     spd_open().

     'voice' is one of the following values: 'SPD_MALE1', 'SPD_MALE2',
     'SPD_MALE3', 'SPD_FEMALE1', 'SPD_FEMALE2', 'SPD_FEMALE3',
     'SPD_CHILD_MALE', 'SPD_CHILD_FEMALE'.

 -- C API function: int spd_set_synthesis_voice(SPDConnection*
          connection, char* voice_name);

     Set the speech synthesizer voice to use.  Please note that
     synthesis voices are an attribute of the synthesizer, so this
     setting only takes effect until the output module in use is changed
     (via 'spd_set_output_module()' or via 'spd_set_language').

     'connection' is the SPDConnection* connection created by
     spd_open().

     'voice_name' is any of the voice name values retrieved by *Note
     spd_list_synthesis_voices::.

 -- C API function: int spd_set_voice_rate(SPDConnection* connection,
          int rate);

     Set voice speaking rate.

     'connection' is the SPDConnection* connection created by
     spd_open().

     'rate' is a number between -100 and +100 which means the slowest
     and the fastest speech rate respectively.

 -- C API function: int spd_get_voice_rate(SPDConnection* connection);

     Get voice speaking rate.

     'connection' is the SPDConnection* connection created by
     spd_open().

     It returns the current voice rate.

 -- C API function: int spd_set_voice_pitch(SPDConnection* connection,
          int pitch);

     Set voice pitch.

     'connection' is the SPDConnection* connection created by
     spd_open().

     'pitch' is a number between -100 and +100, which means the lowest
     and the highest pitch respectively.

 -- C API function: int spd_get_voice_pitch(SPDConnection* connection);

     Get voice pitch.

     'connection' is the SPDConnection* connection created by
     spd_open().

     It returns the current voice pitch.

 -- C API function: int spd_set_volume(SPDConnection* connection, int
          volume);

     Set the volume of the voice and sounds produced by Speech
     Dispatcher's output modules.

     'connection' is the SPDConnection* connection created by
     spd_open().

     'volume' is a number between -100 and +100 which means the lowest
     and the loudest voice respectively.

 -- C API function: int spd_get_volume(SPDConnection* connection);

     Get the volume of the voice and sounds produced by Speech
     Dispatcher's output modules.

     'connection' is the SPDConnection* connection created by
     spd_open().

     It returns the current volume.

File: speech-dispatcher.info,  Node: Other Functions in C,  Next: Information Retrieval Commands in C,  Prev: Parameter Setting Commands in C,  Up: C API

4.1.7 Other Functions
---------------------

File: speech-dispatcher.info,  Node: Information Retrieval Commands in C,  Next: Event Notification and Index Marking in C,  Prev: Other Functions in C,  Up: C API

4.1.8 Information Retrieval Commands
------------------------------------

 -- C API function: char** spd_list_modules(SPDConnection* connection)

     Returns a null-terminated array of identification names of the
     available output modules.  You can subsequently set the desired
     output module with *Note spd_set_output_module::.  In case of
     error, the return value is a NULL pointer.

     'connection' is the SPDConnection* connection created by
     spd_open().

 -- C API function: char** spd_list_voices(SPDConnection* connection)

     Returns a null-terminated array of identification names of the
     symbolic voices.  You can subsequently set the desired voice with
     *Note spd_set_voice_type::.

     Please note that this is a fixed list independent of the
     synthesizer in use.  The given voices can be mapped to specific
     synthesizer voices according to user wish or may, for example, all
     be mapped to the same voice.  To choose directly from the raw list
     of voices as implemented in the synthesizer, *Note
     spd_list_synthesis_voices::.

     In case of error, the return value is a NULL pointer.

     'connection' is the SPDConnection* connection created by
     spd_open().

 -- C API function: char** spd_list_synthesis_voices(SPDConnection*
          connection)

     Returns a null-terminated array of identification names of
     'SPDVoice*' structures describing the available voices as given by
     the synthesizer.  You can subsequently set the desired voice with
     'spd_set_synthesis_voice()'.

          typedef struct{
            char *name;   /* Name of the voice (id) */
            char *language;  /* 2-letter ISO language code */
            char *variant;   /* a not-well defined string describing dialect etc. */
          }SPDVoice;

     Please note that the list returned is specific to each synthesizer
     in use (so when you switch to another output module, you must also
     retrieve a new list).  If you want instead to use symbolic voice
     names which are independent of the synthesizer in use, *Note
     spd_list_voices::.

     In case of error, the return value is a NULL pointer.

     'connection' is the SPDConnection* connection created by
     spd_open().

File: speech-dispatcher.info,  Node: Event Notification and Index Marking in C,  Next: History Commands in C,  Prev: Information Retrieval Commands in C,  Up: C API

4.1.9 Event Notification and Index Marking in C
-----------------------------------------------

When the SSIP connection is run in asynchronous mode, it is possible to
register callbacks for all the SSIP event notifications and index mark
notifications, as defined in *note (ssip)Message Event Notification and
Index Marking::

 -- Variable: C API type SPDNotification

     'SPDNotification' is an enum type that represents the possible base
     notification types that can be assigned to a message.

          typedef enum{
              SPD_BEGIN = 1,
              SPD_END = 2,
              SPD_INDEX_MARKS = 4,
              SPD_CANCEL = 8,
              SPD_PAUSE = 16,
              SPD_RESUME = 32
          }SPDNotification;

   There are currently two types of callbacks in the C API.

 -- Variable: C API type SPDCallback
     'void (*SPDCallback)(size_t msg_id, size_t client_id,
     SPDNotificationType state);'

     This one is used for notifications about the events: 'BEGIN',
     'END', 'PAUSE' and 'RESUME'.  When the callback is called, it
     provides three parameters for the event.

     'msg_id' unique identification number of the message the
     notification is about.

     'client_id' specifies the unique identification number of the
     client who sent the message.  This is usually the same connection
     as the connection which registered this callback, and therefore
     uninteresting.  However, in some special cases it might be useful
     to register this callback for other SSIP connections, or register
     the same callback for several connections originating from the same
     application.

     'state' is the 'SPD_Notification' type of this notification.  *Note
     SPDNotification::.

 -- Variable: C API type SPDCallbackIM
     'void (*SPDCallbackIM)(size_t msg_id, size_t client_id,
     SPDNotificationType state, char *index_mark);'

     'SPDCallbackIM' is used for notifications about index marks that
     have been reached in the message.  (A way to specify index marks is
     e.g.  through the SSML element <mark/> in ssml mode.)

     The syntax and meaning of these parameters are the same as for
     *note SPDCallback:: except for the additional parameter
     'index_mark'.

     'index_mark' is a NULL terminated string associated with the index
     mark.  Please note that this string is specified by client
     application and therefore it needn't be unique.

   One or more callbacks can be supplied for a given 'SPDConnection*'
connection by assigning the values of pointers to the appropriate
functions to the following connection members:

         SPDCallback callback_begin;
         SPDCallback callback_end;
         SPDCallback callback_cancel;
         SPDCallback callback_pause;
         SPDCallback callback_resume;
         SPDCallbackIM callback_im;

   There are three settings commands which will turn notifications on
and off for the current SSIP connection and cause the callbacks to be
called when the event is registered by Speech Dispatcher.

 -- C API function: int spd_set_notification_on(SPDConnection*
          connection, SPDNotification notification);
 -- C API function: int spd_set_notification_off(SPDConnection*
          connection, SPDNotification notification);
 -- C API function: int spd_set_notification(SPDConnection* connection,
          SPDNotification notification, const char* state);

     These functions will set the notification specified by the
     parameter 'notification' on or off (or to the given value)
     respectively.  Note that it is only safe to call these functions
     after the appropriate callback functions have been set in the
     'SPDCallback' structure.  Doing otherwise is not considered an
     error, but the application might miss some events due to callback
     functions not being executed (e.g.  the client might receive an
     'END' event without receiving the corresponding 'BEGIN' event in
     advance.

     'connection' is the SPDConnection* connection created by
     spd_open().

     'notification' is the requested type of notifications that should
     be reported by SSIP. *Note SPDNotification::.  Note that also '|'
     combinations are possible, as illustrated in the example below.

     'state' must be either the string "on" or "off", for switching the
     given notification on or off.

   The following example shows how to use callbacks for the simple
purpose of playing a message and waiting until its end.  (Please note
that checks of return values in this example as well as other code not
directly related to index marking, have been removed for the purpose of
clarity.)

     #include <semaphore.h>

     sem_t semaphore;

     /* Callback for Speech Dispatcher notifications */
     void end_of_speech(size_t msg_id, size_t client_id, SPDNotificationType type)
     {
        /* We don't check msg_id here since we will only send one
            message. */

        /* Callbacks are running in a separate thread, so let the
            (sleeping) main thread know about the event and wake it up. */
        sem_post(&semaphore);
     }

     int
     main(int argc, char **argv)
     {
        SPDConnection *conn;

        sem_init(&semaphore, 0, 0);

        /* Open Speech Dispatcher connection in THREADED mode. */
        conn = spd_open("say","main", NULL, SPD_MODE_THREADED);

        /* Set callback handler for 'end' and 'cancel' events. */
        conn->callback_end = con->callback_cancel = end_of_speech;

        /* Ask Speech Dispatcher to notify us about these events. */
        spd_set_notification_on(conn, SPD_END);
        spd_set_notification_on(conn, SPD_CANCEL);

        /* Say our message. */
        spd_sayf(conn, SPD_MESSAGE, (char*) argv[1]);

        /* Wait for 'end' or 'cancel' of the sent message.
           By SSIP specifications, we are guaranteed to get
           one of these two eventually. */
        sem_wait(&semaphore);

        return 0;
     }

File: speech-dispatcher.info,  Node: History Commands in C,  Next: Direct SSIP Communication in C,  Prev: Event Notification and Index Marking in C,  Up: C API

4.1.10 History Commands
-----------------------

File: speech-dispatcher.info,  Node: Direct SSIP Communication in C,  Prev: History Commands in C,  Up: C API

4.1.11 Direct SSIP Communication in C
-------------------------------------

It might happen that you want to use some SSIP function that is not
available through a library or you may want to use an available function
in a different manner.  (If you think there is something missing in a
library or you have some useful comment on the available functions,
please let us know.)  For this purpose, there are a few functions that
will allow you to send arbitrary SSIP commands on your connection and
read the replies.

 -- C API function: int spd_execute_command(SPDConnection* connection,
          char *command);

     You can send an arbitrary SSIP command specified in the parameter
     'command'.

     If the command is successful, the function returns a 0.  If there
     is no such command or the command failed for some reason, it
     returns -1.

     'connection' is the SPDConnection* connection created by
     spd_open().

     'command' is a null terminated string containing a full SSIP
     command without the terminating sequence '\r\n'.

     For example:
                  spd_execute_command(fd, "SET SELF RATE 60");
                  spd_execute_command(fd, "SOUND_ICON bell");

     It's not possible to use this function for compound commands like
     'SPEAK' where you are receiving more than one reply.  If this is
     your case, please see 'spd_send_data()'.

 -- C API function: char* spd_send_data(SPDConnection* connection, const
          char *message, int wfr);

     You can send an arbitrary SSIP string specified in the parameter
     'message' and, if specified, wait for the reply.  The string can be
     any SSIP command, but it can also be textual data or a command
     parameter.

     If 'wfr' (wait for reply) is set to SPD_WAIT_REPLY, you will
     receive the reply string as the return value.  If wfr is set to
     SPD_NO_REPLY, the return value is a NULL pointer.  If wfr is set to
     SPD_WAIT_REPLY, you should always free the returned string.

     'connection' is the SPDConnection* connection created by
     spd_open().

     'message' is a null terminated string containing a full SSIP
     string.  If this is a complete SSIP command, it must include the
     full terminating sequence '\r\n'.

     'wfr' is either SPD_WAIT_REPLY (integer value of 1) or SPD_NO_REPLY
     (0).  This specifies if you expect to get a reply on the sent data
     according to SSIP. For example, if you are sending ordinary text
     inside a 'SPEAK' command, you don't expect to get a reply, but you
     expect a reply after sending the final sequence '\r\n.\r\n'.

     For example (simplified by not checking and freeing the returned
     strings):
                  spd_send_data(conn, "SPEAK", SPD_WAIT_REPLY);
                  spd_send_data(conn, "Hello world!\n", SPD_NO_REPLY);
                  spd_send_data(conn, "How are you today?!", SPD_NO_REPLY);
                  spd_send_data(conn, "\r\n.\r\n.", SPD_WAIT_REPLY);

File: speech-dispatcher.info,  Node: Python API,  Next: Guile API,  Prev: C API,  Up: Client Programming

4.2 Python API
==============

There is a full Python API available in 'src/python/speechd/' in the
source tree.  Please see the Python docstrings for full reference about
the available objects and methods.

   Simple Python client:
     import speechd
     client = speechd.SSIPClient('test')
     client.set_output_module('festival')
     client.set_language('en')
     client.set_punctuation(speechd.PunctuationMode.SOME)
     client.speak("Hello World!")
     client.close()

   The Python API respects the environment variables SPEECHD_ADDRESS it
the communication address is not specified explicitly (see 'SSIPClient'
constructor arguments).

   Implementation of callbacks within the Python API tries to hide the
low level details of SSIP callback handling and provide a convenient
Pythonic interface.  You just pass a callable object (function) to the
'speak()' method and this function will be called whenever an event
occurs for the corresponding message.

   Callback example:
     import speechd, time
     called = []
     client = speechd.SSIPClient('callback-test')
     client.speak("Hi!", callback=lambda cb_type: called.append(cb_type))
     time.sleep(2) # Wait for the events to happen.
     print "Called callbacks:", called
     client.close()

   Real-world callback functions will most often need some sort of
context information to be able to distinguish for which message the
callback was called.  This can be simply done in Python.  The following
example uses the actual message text as the context information within
the callback function.

   Callback context example:
     import speechd, time

     class CallbackExample(object):
         def __init__(self):
             self._client = speechd.SSIPClient('callback-test')

         def speak(self, text):
             def callback(callback_type):
                 if callback_type == speechd.CallbackType.BEGIN:
                     print "Speech started:", text
                 elif callback_type == speechd.CallbackType.END:
                     print "Speech completed:", text
                 elif callback_type == speechd.CallbackType.CANCEL:
                     print "Speech interupted:", text
             self._client.speak(text, callback=callback,
                                event_types=(speechd.CallbackType.BEGIN,
                                             speechd.CallbackType.CANCEL,
                                             speechd.CallbackType.END))

         def go(self):
             self.speak("Hi!")
             self.speak("How are you?")
             time.sleep(4) # Wait for the events to happen.
             self._client.close()

     CallbackExample().go()

   _Important notice:_ The callback is called in Speech Dispatcher
listener thread.  No subsequent Speech Dispatcher interaction is allowed
from within the callback invocation.  If you need to do something more
complicated, do it in another thread to prevent deadlocks in SSIP
communication.

File: speech-dispatcher.info,  Node: Guile API,  Next: Common Lisp API,  Prev: Python API,  Up: Client Programming

4.3 Guile API
=============

The Guile API can be found 'src/guile/' in the source tree, however it's
still considered to be at the experimental stage.  Please read
'src/guile/README'.

File: speech-dispatcher.info,  Node: Common Lisp API,  Next: Autospawning,  Prev: Guile API,  Up: Client Programming

4.4 Common Lisp API
===================

The Common Lisp API can be found 'src/cl/' in the source tree, however
it's still considered to be at the experimental stage.  Please read
'src/cl/README'.

File: speech-dispatcher.info,  Node: Autospawning,  Prev: Common Lisp API,  Up: Client Programming

4.5 Autospawning
================

It is suggested that client libraries offer an autospawn functionality
to automatically start the server process when connecting locally and if
it is not already running.  E.g.  if the client application starts and
Speech Dispatcher is not running already, the client will start Speech
Dispatcher.

   The library API should provide a possibility to turn this
functionality off, but we suggest to set the default behavior to
autospawn.

   Autospawn is performed by executing Speech Dispatcher with the -spawn
parameter under the same user and permissions as the client process:

     speech-dispatcher --spawn

   With the '--spawn' parameter, the process will start and return with
an exit code of 0 only if a) it is not already running (pidfile check)
b) the server doesn't have autospawn disabled in its configuration c) no
other error preventing the start occurs.  Otherwise, Speech Dispatcher
is not started and the error code of 1 is returned.

   The client library should redirect its stdout and stderr outputs
either to nowhere or to its logging system.  It should subsequently
completely detach from the newly spawned process.

   Due to a bug in Speech Dispatcher, it is currently necessary to
include a wait statement after the autospawn for about 0.5 seconds
before attempting a connection.

   Please see how autospawn is implemented in the C API and in the
Python API for an example.

File: speech-dispatcher.info,  Node: Server Programming,  Next: Download and Contact,  Prev: Client Programming,  Up: Top

5 Server Programming
********************

* Menu:

* Server Core::                 Internal structure and functionality overview.
* Output Modules::              Plugins for various speech synthesizers.

File: speech-dispatcher.info,  Node: Server Core,  Next: Output Modules,  Prev: Server Programming,  Up: Server Programming

5.1 Server Core
===============

The main documentation for the server core is the code itself.  This
section is only a general introduction intended to give you some basic
information and hints where to look for things.  If you are going to
make some modifications in the server core, we will be happy if you get
in touch with us on <speechd@lists.freebsoft.org>.

   The server core is composed of two main parts, each of them
implemented in a separate thread.  The _server part_ handles the
communication with clients and, with the desired configuration options,
stores the messages in the priority queue.  The _speaking part_ takes
care of communicating with the output modules, pulls messages out of the
priority queue at the correct time and sends them to the appropriate
synthesizer.

   Synchronization between these two parts is done by thread mutexes.
Additionally, synchronization of the speaking part from both sides
(server part, output modules) is done via a SYSV/IPC semaphore.

Server part
-----------

After switching to the daemon mode (if required), it reads configuration
files and initializes the speaking part.  Then it opens the socket and
waits for incoming data.  This is implemented mainly in
'src/server/speechd.c' and 'src/server/server.c'.

   There are three types of events: new client connects to speechd, old
client disconnects, or a client sends some data.  In the third case, the
data is passed to the 'parse()' function defined in
'src/server/parse.c'.

   If the incoming data is a new message, it's stored in a queue
according to its priority.  If it is SSIP commands, it's handled by the
appropriate handlers.  Handling of the 'SET' family of commands can be
found in 'src/server/set.c' and 'HISTORY' commands are processed in
'src/server/history.c'.

   All reply messages of SSIP are defined in 'src/server/msg.h'.

Speaking part
-------------

This thread, the function 'speak()' defined in 'src/server/speaking.c',
is created from the server part process shortly after initialization.
Then it enters an infinite loop and waits on a SYSV/IPC semaphore until
one of the following actions happen:

   * The server adds a new message to the queue of messages waiting to
     be said.
   * The currently active output module signals that the message that
     was being spoken is done.
   * Pause or resume is requested.

   After handling the rest of the priority interaction (like actions
needed to repeat the last priority progress message) it decides which
action should be performed.  Usually it's picking up a message from the
queue and sending it to the desired output module (synthesizer), but
sometimes it's handling the pause or resume requests, and sometimes it's
doing nothing.

   As said before, this is the part of Speech Dispatcher that talks to
the output modules.  It does so by using the output interface defined in
'src/server/output.c'.

File: speech-dispatcher.info,  Node: Output Modules,  Prev: Server Core,  Up: Server Programming

5.2 Output Modules
==================

* Menu:

* Basic Structure::             The definition of an output module.
* Communication Protocol for Output Modules::
* How to Write New Output Module::  How to include support for new synthesizers
* The Skeleton of an Output Module::
* Output Module Functions::
* Module Utils Functions and Macros::
* Index Marks in Output Modules::

File: speech-dispatcher.info,  Node: Basic Structure,  Next: Communication Protocol for Output Modules,  Prev: Output Modules,  Up: Output Modules

5.2.1 Basic Structure
---------------------

Speech Dispatcher output modules are independent applications that,
using a simple common communication protocol, read commands from
standard input and then output replies on standard output, communicating
the requests to the particular software or hardware synthesizer.
Everything the output module writes on standard output or reads from
standard input should conform to the specifications of the communication
protocol.  Additionally, standard error output is used for logging of
the modules.

   Output module binaries are usually located in 'bin/speechd-modules/'
and are loaded automatically when Speech Dispatcher starts, according to
configuration.  Their standard input/output/error output is redirected
to a pipe to Speech Dispatcher and this way both sides can communicate.

   When the modules start, they are passed the name of a configuration
file that should be used for this particular output module.

   Each output module is started by Speech Dispatcher as:

     my_module "configfile"

   where 'configfile' is the full path to the desired configuration file
that the output module should parse.

File: speech-dispatcher.info,  Node: Communication Protocol for Output Modules,  Next: How to Write New Output Module,  Prev: Basic Structure,  Up: Output Modules

5.2.2 Communication Protocol for Output Modules
-----------------------------------------------

The protocol by which the output modules communicate on standard
input/output is based on *note SSIP: (ssip)Top, although it is highly
simplified and a little bit modified for the different purpose here.
Another difference is that event notification is obligatory in modules
communication, while in SSIP, this is an optional feature.  This is
because Speech Dispatcher has to know all the events happening in the
output modules for the purpose of synchronization of various messages.

   Since it's very similar to SSIP, *note General Rules: (ssip)Top, for
a general description of what the protocol looks like.  One of the
exceptions is that since the output modules communicate on standard
input/output, we use only 'LF' as the line separator.

   The return values are:
   * 2xx OK
   * 3xx CLIENT ERROR or BAD SYNTAX or INVALID VALUE
   * 4xx OUTPUT MODULE ERROR or INTERNAL ERROR

   * 700 EVENT INDEX MARK
   * 701 EVENT BEGIN
   * 702 EVENT END
   * 703 EVENT STOP
   * 704 EVENT PAUSE

'SPEAK'
     Start receiving a text message in the SSML format and synthesize
     it.  After sending a reply to the command, output module waits for
     the text of the message.  The text can spread over any number of
     lines and is finished by an end of line marker followed by the line
     containing the single character '.' (dot).  Thus the complete
     character sequence closing the input text is 'LF . LF'.  If any
     line within the sent text contains only a dot, an extra dot should
     be prepended before it.

     During reception of the text message, output module doesn't send a
     response to the particular lines sent.  The response line is sent
     only immediately after the 'SPEAK' command and after receiving the
     closing dot line.  This doesn't provide any means of
     synchronization, instead, event notification is used for this
     purpose.

     There is no explicit upper limit on the size of the text.

     If the 'SPEAK' command is received while the output module is
     already speaking, it is considered an error.

     Example:
          SPEAK
          202 OK SEND DATA
          <speak>
          Hello, GNU!
          </speak>
          .
          200 OK SPEAKING

     After receiving the full text (or the first part of it), the output
     module is supposed to start synthesizing it and take care of
     delivering it to an audio device.  When (or just before) the first
     synthesized samples are delivered to the audio and start playing,
     the output module must send the 'BEGIN' event over the
     communication socket to Speech Dispatcher, *Note Events
     notification and index marking::.  After the audio stops playing,
     the event 'STOP', 'PAUSE' or 'END' must be delivered to Speech
     Dispatcher.  Additionally, if supported by the given synthesizer,
     the output module can issue events associated with the included
     SSML index marks when they are reached in the audio output.

'CHAR'
     Synthesize a character.  If the synthesizer supports a different
     behavior for the event of "character", this should be used.

     It works like the command 'SPEAK' above, except that the argument
     has to be exactly one line long.  It contains the UTF-8 form of
     exactly one character.

'KEY'
     Synthesize a key name.  If the synthesizer supports a different
     behavior for the event of "key name", this should be used.

     It works like the command 'SPEAK' above, except that the argument
     has to be exactly one line long.  *Note SSIP KEY: (ssip)Top, for
     the description of the allowed arguments.

'SOUND_ICON'
     Produce a sound icon.  According to the configuration of the
     particular synthesizer, this can produce either a sound (e.g.
     .wav) or synthesize some text.

     It works like the command 'SPEAK' above, except that the argument
     has to be exactly one line long.  It contains the symbolic name of
     the icon that should be said.  *Note SSIP SOUND_ICON: (ssip)Top,
     for more detailed description of the sound icons mechanism.

'STOP'
     Immediately stop speaking on the output device and cancel
     synthesizing the current message so that the output module is
     prepared to receive a new message.  If there is currently no
     message being synthesized, it is not considered an error to call
     'STOP' anyway.

     This command is asynchronous.  The output module is not supposed to
     send any reply (not even error reply).

     It should return immediately, although stopping the synthesizer may
     require a little bit more time.  The module must issue one of the
     events 'STOPPED' or 'END' when the module is finally stopped.
     'END' is issued when the playing stopped by itself before the
     module could terminate it or if the architecture of the output
     module doesn't allow it to decide, otherwise 'STOPPED' should be
     used.

          STOP

'PAUSE'
     Stop speaking the current message at a place where we can exactly
     determine the position (preferably after a '__spd_' index mark).
     This doesn't have to be immediate and can be delayed even for a few
     seconds.  (Knowing the position exactly is important so that we can
     later continue the message without gaps or overlapping.)  It
     doesn't do anything else (like storing the message etc.).

     This command is asynchronous.  The output module is not supposed to
     send any reply (not even error reply).

     For example:
          PAUSE

'SET'
     Set one of several speech parameters for the future messages.

     Each of the parameters is written on a single line in the form
          name=value
     where 'value' can be either a number or a string, depending upon
     the name of the parameter.

     The 'SET' environment is terminated by a dot on a single line.
     Thus the complete character sequence closing the input text is 'LF
     . LF'

     During reception of the settings, output module doesn't send any
     response to the particular lines sent.  The response line is sent
     only immediately after the 'SET' command and after receiving the
     closing dot line.

     The available parameters that accept numerical values are 'rate'
     and 'pitch'.

     The available parameters that accept string values are
     'punctuation_mode', 'spelling_mode', 'cap_let_recogn', 'voice', and
     'language'.  The arguments are the same as for the corresponding
     SSIP commands, except that they are written with small letters.
     *Note Parameter Setting Commands: (ssip)Top.  The conversion
     between these string values and the corresponding C enum variables
     can be easily done using 'src/common/fdsetconv.c'.

     Not all of these parameters must be set and the value of the string
     arguments can also be 'NULL'.  If some of the parameters aren't
     set, the output module should use its default.

     It's not necessary to set these parameters on the synthesizer right
     away, instead, it can be postponed until some message to be spoken
     arrives.

     Here is an example:
          SET
          203 OK RECEIVING SETTINGS
          rate=20
          pitch=-10
          punctuation_mode=all
          spelling_mode=on
          punctuation_some=NULL
          .
          203 OK SETTINGS RECEIVED

'AUDIO'
     Audio has exactly the same structure as 'SET', but is transmitted
     only once immediatelly after 'INIT' to transmit the requested audio
     parameters and tell the output module to open the audio device.

'QUIT'
     Terminates the output module.  It should send the response,
     deallocate all the resources, close all descriptors, terminate all
     child processes etc.  Then the output module should exit itself.

          QUIT
          210 OK QUIT

5.2.2.1 Events notification and index marking
.............................................

Each output module must take care of sending asynchronous notifications
whenever the synthesizer (or the module) starts or stops output audio on
the speakers.  Additionally, whenever possible, the output module should
report back to Speech Dispatcher index marks found in the incoming SSML
text whenever they are reached while speaking.  See SSML specifications
for more details about the 'mark' element

   Event and index mark notifications are reported by simply writing
them to the standard output.  An event notification must never get in
between synchronous commands (those which require a reply) and their
reply.  Before Speech Dispatcher sends any new requests (like 'SET',
'SPEAK' etc.)  it waits for the previous request to be terminated by the
output module by signalling 'STOP', 'END' or 'PAUSE' index marks.  So
the only thing the output module must ensure in order to satisfy this
requirement is that it doesn't send any index marks until it
acknowledges the receival of the new message via '200 OK SPEAKING'.  It
must also ensure that index marks written to the pipe are well ordered -
of course it doesn't make any sense and it is an error to send any index
marks after 'STOP', 'END' or 'PAUSE' is sent.

'BEGIN'

     This event must be issued whenever the module starts to speak the
     given message.  If this is not possible, it can issue it when it
     starts to synthesize the message or when it receives the message.

     It is prepended by the code '701' and takes the form

          701 BEGIN

'END'

     This event must be issued whenever the module terminates speaking
     the given message because it reached its end.  If this is not
     possible, it can issue this event when it is ready to receive a new
     message after speaking the previous message.

     Each 'END' must always be preceeded (possibly not directly) by a
     'BEGIN'.

     It is prepended by the code '702' and takes the form

          702 END

'STOP'

     This event should be issued whenever the module terminates speaking
     the given message without reaching its end (as a consequence of
     receiving the STOP command or because of some error) not because of
     a 'PAUSE' command.  When the synthesizer in use doesn't allow the
     module to decide, the event 'END' can be used instead.

     Each 'STOP' must always be preceeded (possibly not directly) by a
     'BEGIN'.

     It is prepended by the code '703' and takes the form

          703 STOP

'PAUSE'

     This event should be issued whenever the module terminates speaking
     the given message without reaching its end because of receiving the
     'PAUSE' command.

     Each 'PAUSE' must always be preceeded (possibly not directly) by a
     'BEGIN'.

     It is prepended by the code '704' and takes the form

          704 PAUSE

'INDEX MARK'

     This event should be issued by the output module (if supported)
     whenever an index mark (SSML tag '<mark/>') is passed while
     speaking a message.  It is preceeded by the code '700' and takes
     the form

          700-name
          700 INDEX MARK

     where 'name' is the value of the SSML attribute 'name' in the tag
     '<mark/>'.

File: speech-dispatcher.info,  Node: How to Write New Output Module,  Next: The Skeleton of an Output Module,  Prev: Communication Protocol for Output Modules,  Up: Output Modules

5.2.3 How to Write New Output Module
------------------------------------

If you want to write your own output module, there are basically two
ways to do it.  Either you can program it all yourself, which is fine as
long as you stick to the definition of an output module and its
communication protocol, or you can use our 'module_*.c' tools.  If you
use these tools, you will only have to write the core functions like
module_speak() and module_stop etc.  and you will not have to worry
about the communication protocol and other formal things that are common
for all modules.  Here is how you can do it using the provided tools.

   We will recommend here a basic structure of the code for an output
module you should follow, although it's perfectly ok to establish your
own if you have reasons to do so, if all the necessary functions and
data are defined somewhere in the file.  For this purpose, we will use
examples from the output module for Flite (Festival Lite), so it's
recommended to keep looking at 'flite.c' for reference.

   A few rules you should respect:
   * The 'module_*.c' files should be included at the specified place
     and in the specified order, because they include directly some
     pieces of the code and won't work in other places.
   * If one or more new threads are used in the output module, they must
     block all signals.
   * On module_close(), all lateral threads and processes should be
     terminated, all memory freed.  Don't assume module_close() is
     always called before exit() and the sources will be freed
     automatically.
   * We will be happy if all the copyrights are assigned to Brailcom,
     o.p.s.  in order for us to be in a better legal position against
     possible intruders.

File: speech-dispatcher.info,  Node: The Skeleton of an Output Module,  Next: Output Module Functions,  Prev: How to Write New Output Module,  Up: Output Modules

5.2.4 The Skeleton of an Output Module
--------------------------------------

Each output module should include 'module_utils.h' where the
SPDMsgSettings structure is defined to be able to handle the different
speech synthesis settings.  This file also provides tools which help
with writing output modules and making the code simpler.

     #include "module_utils.h"

   If your plugin needs the audio tools (if you take care of the output
to the soundcard instead of the synthesizer), you also have to include
'spd_audio.h'

     #include "spd_audio.h"

   The definition of macros 'MODULE_NAME' and 'MODULE_VERSION' should
follow:

     #define MODULE_NAME     "flite"
     #define MODULE_VERSION  "0.1"

   If you want to use the 'DBG(message)' macro from 'module_utils.c' to
print out debugging messages, you should insert these two lines.
(Please don't use printf for debugging, this doesn't work with multiple
processes!)  (You will later have to actually start debugging in
'module_init()')

     DECLARE_DEBUG();

   You don't have to define the prototypes of the core functions like
module_speak() and module_stop(), these are already defined in
'module_utils.h'

   Optionally, if your output module requires some special
configuration, apart from defining voices and configuring debugging
(they are handled differently, see below), you can declare the requested
option here.  It will expand into a dotconf callback and declaration of
the variable.

   (You will later have to actually register these options for Speech
Dispatcher in 'module_load()')

   There are currently 4 types of possible configuration options:

   * 'MOD_OPTION_1_INT(name); /* Set up `int name' */'
   * 'MOD_OPTION_1_STR(name); /* Set up `char* name' */'
   * 'MOD_OPTION_2(name); /* Set up `char *name[2]' */'
   * 'MOD_OPTION_{2,3}_HT(name); /* Set up a hash table */'

   *Note Output Modules Configuration::.

   For example Flite uses 2 options:
     MOD_OPTION_1_INT(FliteMaxChunkLength);
     MOD_OPTION_1_STR(FliteDelimiters);

   Every output module is started in 2 phases: _loading_ and
_initialization_.

   The goal of loading is to initialize empty structures for storing
settings and declare the DotConf callbacks for parsing configuration
files.  In the second phase, initialization, all the configuration has
been read and the output module can accomplish the rest (check if the
synthesizer works, set up threads etc.).

   You should start with the definition of 'module_load()'.

     int
     module_load(void)
     {

   Then you should initialize the settings tables.  These are defined in
'module_utils.h' and will be used to store the settings received by the
'SET' command.
         INIT_SETTINGS_TABLES();

   Also, define the configuration callbacks for debugging if you use the
'DBG()' macro.

         REGISTER_DEBUG();

   Now you can finally register the options for the configuration file
parsing.  Just use these macros:
   * MOD_OPTION_1_INT_REG(name, default); /* for integer parameters */
   * MOD_OPTION_1_STR_REG(name, default); /* for string parameters */
   * MOD_OPTION_MORE_REG(name); /* for an array of strings */
   * MOD_OPTION_HT_REG(name); /* for hash tables */

   Again, an example from Flite:
         MOD_OPTION_1_INT_REG(FliteMaxChunkLength, 300);
         MOD_OPTION_1_STR_REG(FliteDelimiters, ".");

   If you want to enable the mechanism for setting voices through
AddVoice, use this function (for an example see 'generic.c'):

   Example from Festival:
         module_register_settings_voices();

   *Note Output Modules Configuration::.

   If everything went correctly, the function should return 0, otherwise
-1.

         return 0;
     }

   The second phase of starting an output module is handled by:

     int
     module_init(void)
     {

   If you use the DBG() macro, you should init debugging on the start of
this function.  From that moment on, you can use DBG().  Apart from
that, the body of this function is entirely up to you.  You should do
all the necessary initialization of the particular synthesizer.  All
declared configuration variables and configuration hash tables, together
with the definition of voices, are filled with their values (either
default or read from configuration), so you can use them already.

        INIT_DEBUG();
        DBG("FliteMaxChunkLength = %d\n", FliteMaxChunkLength);
        DBG("FliteDelimiters = %s\n", FliteDelimiters);

   This function should return 0 if the module was initialized
successfully, or -1 if some failure was encountered.  In this case, you
should clean up everything, cancel threads, deallocate memory etc.; no
more functions of this output module will be touched (except for other
tries to load and initialize the module).

   Example from Flite:

         /* Init flite and register a new voice */
         flite_init();
         flite_voice = register_cmu_us_kal();

         if (flite_voice == NULL){
             DBG("Couldn't register the basic kal voice.\n");
             return -1;
         }
         [...]

   The third part is opening the audio.  This is commanded by the
'AUDIO' protocol command.  If the synthesizer is able to retrieve audio
data, it is desirable to open the 'spd_audio' output according to the
requested parameters and then use this method for audio output.  Audio
initialization can be done as follows:

     int
     module_audio_init(char **status_info){
       DBG("Opening audio");
       return module_audio_init_spd(status_info);
     }

   If it is impossible to retrieve audio from the synthesizer and the
synthesizer itself is used for playback, than the module must still
contain this function, but it should just return 0 and do nothing.

   Now you have to define all the synthesis control functions
'module_speak', 'module_stop' etc.  See *note Output Module Functions::.

   At the end, this simple include provides the main() function and all
the functionality related to being an output module of Speech Dispatcher
(parsing argv[] parameters, communicating on stdin/stdout, ...).  It's
recommended to study this file carefully and try to understand what
exactly it does, as it will be part of the source code of your output
module.

     #include "module_main.c"

   If it doesn't work, it's most likely not your fault.  Complain!  This
manual is not complete and the instructions in this sections aren't
either.  Get in touch with us and together we can figure out what's
wrong, fix it and then warn others in this manual.

File: speech-dispatcher.info,  Node: Output Module Functions,  Next: Module Utils Functions and Macros,  Prev: The Skeleton of an Output Module,  Up: Output Modules

5.2.5 Output Module Functions
-----------------------------

 -- Output Module Functions: int module_speak (char *data, size_t bytes,
          EMessageType msgtype)

     This is the function where the actual speech output is produced.
     It is called every time Speech Dispatcher decides to send a message
     to synthesis.  The data of length BYTES are passed in a NULL
     terminated string DATA.  The argument MSGTYPE defines what type of
     message it is (different types should be handled differently, if
     the synthesizer supports it).

     Each output module should take care of setting the output device to
     the parameters from msg_settings (defined in module_utils.h) (See
     SPDMsgSettings in 'module_utils.h').  However, it is not an error
     if some of these values are ignored.  At least rate, pitch and
     language should be set correctly.

     Speed and pitch are values between -100 and 100 included.  0 is the
     default value that represents normal speech flow.  So -100 is the
     slowest (or lowest) and +100 is the fastest (or highest) speech.

     The language parameter is given as a null-terminated string
     containing the name of the language according to RFC 1766 (en, cs,
     fr, ...).  If the requested language is not supported by this
     synthesizer, it's ok to abort and return 0, because that's an error
     in user settings.

     An easy way to set the parameters is using the UPDATE_PARAMETER()
     and UPDATE_STRING_PARAMETER() macros.  *Note Module Utils Functions
     and Macros::.

     Example from festival:
              UPDATE_STRING_PARAMETER(language, festival_set_language);
              UPDATE_PARAMETER(voice, festival_set_voice);
              UPDATE_PARAMETER(rate, festival_set_rate);
              UPDATE_PARAMETER(pitch, festival_set_pitch);
              UPDATE_PARAMETER(punctuation_mode, festival_set_punctuation_mode);
              UPDATE_PARAMETER(cap_let_recogn, festival_set_cap_let_recogn);

     This function should return 0 if it fails and 1 if the delivery to
     the synthesizer is successful.  It should return immediately,
     because otherwise, it would block stopping, priority handling and
     other important things in Speech Dispatcher.

     If there is a need to stay longer, you should create a separate
     thread or process.  This is for example the case of some software
     synthesizers which use a blocking function (eg.  spd_audio_play) or
     hardware devices that have to send data to output modules at some
     particular speed.  Note that if you use threads for this purpose,
     you have to set them to ignore all signals.  The simplest way to do
     this is to call 'set_speaking_thread_parameters()' which is defined
     in module_utils.c.  Call it at the beginning of the thread code.

 -- Output module function: int module_stop (void)

     This function should stop the synthesis of the currently spoken
     message immediately and throw away the rest of the message.

     This function should return immediately.  Speech Dispatcher will
     not send another command until module_report_event_stop() is
     called.  Note that you cannot call module_report_event_stop() from
     within the call to module_stop().  The best thing to do is emit the
     stop event from another thread.

     It should return 0 on success, -1 otherwise.

 -- Output module function: size_t module_pause (void)

     This function should stop speaking on the synthesizer (or sending
     data to soundcard) just after sending an '__spd_' index mark so
     that Speech Dispatcher knows the position of stop.

     The pause can wait for a short time until an index mark is reached.
     However, if it's not possible to determine the exact position, this
     function should have the same effect as 'module_stop'.

     This function should return immediately.  Speech Dispatcher will
     not send another command until module_report_event_pause() is
     called.  Note that you cannot call module_report_event_pause() from
     within the call to module_pause().  The best thing to do is emit
     the pause event from another thread.

     For some software synthesizers, the desired effect can be archieved
     in this way: When 'module_speak()' is called, you execute a
     separate process and pass it the requested message.  This process
     cuts the message into sentences and then runs in a loop and sends
     the pieces to synthesis.  If a signal arrives from
     'module_pause()', you set a flag and stop the loop at the point
     where next piece of text would be synthesized.

     It's not an error if this function is called when the device is not
     speaking.  In this case, it should return 0.

     Note there is no module_resume() function.  The semantics of
     'module_pause()' is the same as 'module_stop()' except that your
     module should stop after reaching a '__spd_' index mark.  Just like
     'module_stop()', it should discard the rest of the message after
     pausing.  On the next 'module_speak()' call, Speech Dispatcher will
     resend the rest of the message after the index mark.

File: speech-dispatcher.info,  Node: Module Utils Functions and Macros,  Next: Index Marks in Output Modules,  Prev: Output Module Functions,  Up: Output Modules

5.2.6 Module Utils Functions and Macros
---------------------------------------

This section describes the various variables, functions and macros that
are available in the 'module_utils.h' file.  They are intended to make
writing new output modules easier and allow the programmer to reuse
existing pieces of code instead of writing everything from scratch.

* Menu:

* Initialization Macros and Functions::
* Generic Macros and Functions::
* Functions used by module_main.c::
* Functions for use when talking to synthesizer::
* Multi-process output modules::
* Memory Handling Functions::

File: speech-dispatcher.info,  Node: Initialization Macros and Functions,  Next: Generic Macros and Functions,  Prev: Module Utils Functions and Macros,  Up: Module Utils Functions and Macros

5.2.6.1 Initialization Macros and Functions
...........................................

 -- Module Utils macro: INIT_SETTINGS_TABLES ()
     This macro initializes the settings tables where the parameters
     received with the 'SET' command are stored.  You must call this
     macro if you want to use the 'UPDATE_PARAMETER()' and
     'UPDATE_STRING_PARAMETER()' macros.

     It is intended to be called from inside a function just after the
     output module starts.

5.2.6.2 Debugging Macros
........................

 -- Module Utils macro: DBG (format, ...)
     DBG() outputs a debugging message, if the 'Debug' option in
     module's configuration is set, to the file specified in
     configuration ad 'DebugFile'.  The parameter syntax is the same as
     for the printf() function.  In fact, it calls printf() internally.

 -- Module Utils macro: FATAL (text)
     Outputs a message specified as 'text' and calls exit() with the
     value EXIT_FAILURE. This terminates the whole output module without
     trying to kill the child processes or freeing other resources other
     than those that will be freed by the system.

     It is intended to be used after some severe error has occurred.

File: speech-dispatcher.info,  Node: Generic Macros and Functions,  Next: Functions used by module_main.c,  Prev: Initialization Macros and Functions,  Up: Module Utils Functions and Macros

5.2.6.3 Generic Macros and Functions
....................................

 -- Module Utils macro: UPDATE_PARAMETER (param, setter)
     Tests if the integer or enum parameter specified in 'param' (e.g.
     rate, pitch, cap_let_recogn, ...)  changed since the last time when
     the 'setter' function was called.

     If it changed, it calls the function 'setter' with the new value.
     (The new value is stored in the msg_settings structure that is
     created by module_utils.h, which you normally don't have to care
     about.)

     The function 'setter' should be defined as:
          void setter_name(type value);

     Please look at the 'SET' command in the communication protocol for
     the list of all available parameters.  *note Communication Protocol
     for Output Modules::.

     An example from Festival output module:
     static void
     festival_set_rate(signed int rate)
     {
         assert(rate >= -100 && rate <= +100);
         festivalSetRate(festival_info, rate);
     }
     [...]
     int
     module_speak(char *data, size_t bytes, EMessageType msgtype)
     {
         [...]
         UPDATE_PARAMETER(rate, festival_set_rate);
         UPDATE_PARAMETER(pitch, festival_set_pitch);
         [...]
     }

 -- Module Utils macro: UPDATE_STRING_PARAMETER (param, setter)
     The same as 'UPDATE_PARAMETER' except that it works for parameters
     with a string value.

File: speech-dispatcher.info,  Node: Functions used by module_main.c,  Next: Functions for use when talking to synthesizer,  Prev: Generic Macros and Functions,  Up: Module Utils Functions and Macros

5.2.6.4 Functions used by 'module_main.c'
.........................................

 -- Module Utils function: char* do_speak(void)
     Takes care of communication after the 'SPEAK' command was received.
     Calls 'module_speak()' when the full text is received.

     It returns a response according to the communication protocol.

 -- Module Utils function: char* do_stop(void)
     Calls the 'module_stop()' function of the particular output module.

     It returns a response according to the communication protocol.

 -- Module Utils function: char* do_pause(void)
     Calls the 'module_pause()' function of the particular output
     module.

     It returns a response according to the communication protocol and
     the value returned by 'module_pause()'.

 -- Module Utils function: char* do_set()
     Takes care of communication after the 'SET' command was received.
     Doesn't call any particular function of the output module, only
     sets the values in the settings tables.  (You should then call the
     'UPDATE_PARAMETER()' macro in module_speak() to actually set the
     synthesizer to these values.)

     It returns a response according to the communication protocol.

 -- Module Utils function: char* do_speaking()
     Calls the 'module_speaking()' function.

     It returns a response according to the communication protocol and
     the value returned by 'module_speaking()'.

 -- Module Utils function: void do_quit()
     Prints the farewell message to the standard output, according to
     the protocol.  Then it calls 'module_close()'.

File: speech-dispatcher.info,  Node: Functions for use when talking to synthesizer,  Next: Multi-process output modules,  Prev: Functions used by module_main.c,  Up: Module Utils Functions and Macros

5.2.6.5 Functions for use when talking to synthesizer
.....................................................

 -- Module Utils function: static int module_get_message_part ( const
          char* message, char* part, unsigned int *pos, size_t maxlen,
          const char* dividers)

     Gets a part of the 'message' according to the specified 'dividers'.

     It scans the text in 'message' from the byte specified by '*pos'
     and looks for one of the characters specified in 'dividers'
     followed by a whitespace character or the terminating NULL byte.
     If one of them is encountered, the read text is stored in 'part'
     and the number of bytes read is returned.  If end of 'message' is
     reached, the return value is -1.

     'message' is the text to process.  It must be a NULL-terminated
     uni-byte string.

     'part' is a pointer to the place where the output text should be
     stored.  It must contain at least 'maxlen' bytes of space.

     'maxlen' is the maximum number of bytes that should be written to
     'part'.

     'dividers' is a NULL-terminated uni-byte string containing the
     punctuation characters where the message should be divided into
     smaller parts (if they are followed by whitespace).

     After returning, 'pos' is the position where the function
     terminated in processing 'message'.

 -- Output module function: void module_report_index_mark(char *mark)
 -- Output module function: void module_report_event_*()

     The 'module_report_' functions serve for reporting event
     notifications and index marking events.  You should use them
     whenever you get an event from the synthesizer which is defined in
     the output module communication protocol.

     Note that you cannot call these functions from within a call to
     module_speak(), module_stop(), or module_pause().  The best way to
     do this is to emit the events from another thread.

 -- Output module function: int module_close(void)

     This function is called when Speech Dispatcher terminates.  The
     output module should terminate all threads and processes, free all
     resources, close all sockets etc.  Never assume this function is
     called only when Speech Dispatcher terminates and exit(0) will do
     the work for you.  It's perfectly ok for Speech Dispatcher to load,
     unload or reload output modules in the middle of its run.

File: speech-dispatcher.info,  Node: Multi-process output modules,  Next: Memory Handling Functions,  Prev: Functions for use when talking to synthesizer,  Up: Module Utils Functions and Macros

5.2.6.6 Multi-process output modules
....................................

 -- Module Utils function: size_t module_parent_wfork (
          TModuleDoublePipe dpipe,
     const char* message, SPDMessageType msgtype, const size_t maxlen,
     const char* dividers, int *pause_requested)

     It simply sends the data to the child in smaller pieces and waits
     for confirmation with a single 'C' character on the pipe from child
     to parent.

     'dpipe' is a parameter which contains the information necessary for
     communicating through pipes between the parent and the child and
     vice-versa.

          typedef struct{
              int pc[2];            /* Parent to child pipe */
              int cp[2];            /* Child to parent pipe */
          }TModuleDoublePipe;

     'message' is a pointer to a NULL-terminated string containing the
     message for synthesis.

     'msgtype' is the type of the message for synthesis.

     'maxlen' is the maximum number of bytes that should be transfered
     over the pipe.

     'dividers' is a NULL-terminated string containing the punctuation
     characters at which this function should divide the message into
     smaller pieces.

     'pause_requested' is a pointer to an integer flag, which is either
     0 if no pause request is pending, or 1 if the function should
     terminate at a convenient place in the message because a pause is
     requested.

     In the beginning, it initializes the pipes and then it enters a
     simple cycle:
       1. Reads a part of the message or an index mark using
          'module_get_message_part()'.
       2. Looks if there isn't a pending request for pause and handles
          it.
       3. Sends the current part of the message to the child using
          'module_parent_dp_write()'.
       4. Waits until a single character 'C' comes from the other pipe
          using 'module_parent_dp_read()'.
       5. Repeats the cycle or terminates, if there is no more data.

 -- Module Utils function: int
          module_parent_wait_continue(TModuleDoublePipe dpipe)
     Waits until the character 'C' (continue) is read from the pipe from
     child.  This function is intended to be run from the parent.

     'dpipe' is the double pipe used for communication between the child
     and parent.

     Returns 0 if the character was read or 1 if the pipe was broken
     before the character could be read.

 -- Module Utils function: void module_parent_dp_init (TModuleDoublePipe
          dpipe)
     Initializes pipes (dpipe) in the parent.  Currently it only closes
     the unnecessary ends.

 -- Module Utils function: void module_child_dp_close (TModuleDoublePipe
          dpipe)
     Initializes pipes (dpipe) in the child.  Currently it only closes
     the unnecessary ends.

 -- Module Utils function: void module_child_dp_write(TModuleDoublePipe
          dpipe, const char *msg, size_t bytes)
     Writes the specified number of 'bytes' from 'msg' to the pipe to
     the parent.  This function is intended, as the prefix says, to be
     run from the child.  Uses the pipes defined in 'dpipe'.

 -- Module Utils function: void module_parent_dp_write(TModuleDoublePipe
          dpipe, const char *msg, size_t bytes)
     Writes the specified number of 'bytes' from 'msg' into the pipe to
     the child.  This function is intended, as the prefix says, to be
     run from the parent.  Uses the pipes defined in 'dpipe'.

 -- Module Utils function: int module_child_dp_read(TModuleDoublePipe
          dpipe char *msg, size_t maxlen)
     Reads up to 'maxlen' bytes from the pipe from parent into the
     buffer 'msg'.  This function is intended, as the prefix says, to be
     run from the child.  Uses the pipes defined in 'dpipe'.

 -- Module Utils function: int module_parent_dp_read(TModuleDoublePipe
          dpipe, char *msg, size_t maxlen)
     Reads up to 'maxlen' bytes from the pipe from child into the buffer
     'msg'.  This function is intended, as the prefix says, to be run
     from the parent.  Uses the pipes defined in 'dpipe'.

 -- Module Utils function: void module_sigblockall(void)
     Blocks all signals.  This is intended to be run from the child
     processes and threads so that their signal handling won't interfere
     with the parent.

 -- Module Utils function: void module_sigunblockusr(sigset_t
          *some_signals)
     Use the set 'some_signals' to unblock SIGUSR1.

 -- Module Utils function: void module_sigblockusr(sigset_t
          *some_signals)
     Use the set 'some_signals' to block SIGUSR1.

File: speech-dispatcher.info,  Node: Memory Handling Functions,  Prev: Multi-process output modules,  Up: Module Utils Functions and Macros

5.2.6.7 Memory Handling Functions
.................................

 -- Module Utils function: static void* xmalloc (size_t size)
     The same as the classical 'malloc()' except that it executes
     'FATAL(``Not enough memory'')' on error.

 -- Module Utils function: static void* xrealloc (void *data, size_t
          size)
     The same as the classical 'realloc()' except that it also accepts
     'NULL' as 'data'.  In this case, it behaves as 'xmalloc'.

 -- Module Utils function: void xfree(void *data)
     The same as the classical 'free()' except that it checks if data
     isn't NULL before calling 'free()'.

File: speech-dispatcher.info,  Node: Index Marks in Output Modules,  Prev: Module Utils Functions and Macros,  Up: Output Modules

5.2.7 Index Marks in Output Modules
-----------------------------------

Output modules need to provide some kind of synchronization and they
have to give Speech Dispatcher back some information about what part of
the message is currently being said.  On the other hand, output modules
are not able to tell the exact position in the text because various
conversions and message processing take place (sometimes punctuation and
spelling substitution, the message needs to be recoded from multibyte to
unibyte coding etc.)  before the text reaches the synthesizer.

   For this reason, Speech Dispatcher places so-called index marks in
the text it sends to its output modules.  They have the form:

     <mark name="id"/>

   'id' is the identifier associated with each index mark.  Within a
'module_speak()' message, each identifer is unique.  It consists of the
string '__spd_' and a counter number.  Numbers begin from zero for each
message.  For example, the fourth index mark within a message looks like

     <mark name="__spd_id_3"/>

   When an index mark is reached, its identifier should be stored so
that the output module is able to tell Speech Dispatcher the identifier
of the last index mark.  Also, index marks are the best place to stop
when the module is requested to pause (although it's ok to stop at some
place close by and report the last index mark).

   Notice that index marks are in SSML format using the 'mark' tag.

File: speech-dispatcher.info,  Node: Download and Contact,  Next: Reporting Bugs,  Prev: Server Programming,  Up: Top

6 Download
**********

You can download Speech Dispatcher's latest release source code from
<http://www.freebsoft.org/speechd>.  There is also information on how to
set up anonymous access to our git repository.

   However, you may prefer to download Speech Dispatcher in a binary
package for your system.  We don't distribute such packages ourselves.
If you run Debian GNU/Linux, it should be in the central repository
under the name 'speech-dispatcher' or 'speechd'.  If you run an
rpm-based distribution like RedHat, Mandrake or SuSE Linux, please try
to look at <http://www.rpmfind.net/>.

   If you want to contact us, please look at
<http://www.freebsoft.org/contact> or use the email
<users@lists.freebsoft.org>.

File: speech-dispatcher.info,  Node: Reporting Bugs,  Next: How You Can Help,  Prev: Download and Contact,  Up: Top

7 Reporting Bugs
****************

If you believe you found a bug in Speech Dispatcher, we will be very
grateful if you let us know about it.  Please do it by email on the
address <speechd@bugs.freebsoft.org>, but please don't send us messages
larger than half a megabyte unless we ask you.

   To report a bug in a way that is useful for the developers is not as
easy as it may seem.  Here are some hints that you should follow in
order to give us the best information so that we can find and fix the
bug easily.

   First of all, please try to describe the problem as exactly as you
can.  We prefer raw data over speculations about where the problem may
lie.  Please try to explain in what situation the bug happens.  Even if
it's a general bug that happens in many situations, please try to
describe at least one case in as much detail, as possible.

   Also, please specify the versions of programs that you use when the
bug happens.  This is not only Speech Dispatcher, but also the client
application you use (speechd-el, say, etc.)  and the synthesizer name
and version.

   If you can reproduce the bug, please send us the log file also.  This
is very useful, because otherwise, we may not be able to reproduce the
bug with our configuration and program versions that differ from yours.
Configuration must be set to logging priority at least 4, but best 5, so
that it's useful for debugging purposes.  You can do so in
'etc/speech-dispatcher/speechd.conf' by modifying the variable
'LogLevel'.  Also, you may want to modify the log destination with
variable 'LogFile'.  After modifying these options, please restart
Speech Dispatcher and repeat the situation in which the bug happens.
After it happened, please take the log and attach it to the bug report,
preferably compressed using 'gzip'.  But note, that when logging with
level 5, all the data that come from Speech Dispatcher is also recorded,
so make sure there is no sensitive information when you are reproducing
the bug.  Please make sure you switch back to priority 3 or lower
logging, because priority 4 or 5 produces really huge logs.

   If you are a programmer and you find a bug that is reproducible in
SSIP, you can send us the sequence of SSIP commands that lead to the bug
(preferably from starting the connection).  You can also try to
reproduce the bug in a simple test-script under
'speech-dispatcher/src/tests' in the source tree.  Please check
'speech-dispatcher/src/tests/README' and see the other tests scripts
there for an example.

   When the bug is a SEGMENTATION FAULT, a backtrace from gdb is also
valuable, but if you are not familiar with gdb, don't bother with that,
we may ask you to do it later.

   Finally, you may also send us a guess of what you think happens in
Speech Dispatcher that causes the bug, but this is usually not very
helpful.  If you are able to provide additional technical information
instead, please do so.

File: speech-dispatcher.info,  Node: How You Can Help,  Next: Appendices,  Prev: Reporting Bugs,  Up: Top

8 How You Can Help
******************

If you want to contribute to the development of Speech Dispatcher, we
will be very happy if you do so.  Please contact us on
<users@lists.freebsoft.org>.

   Here is a short, definitively not exhaustive, list of how you can
help us and other users.

   * _Donate money:_ We are a non-profit organization and we can't work
     without funding.  Brailcom, o.p.s.  created Speech Dispatcher,
     speechd-el and also works on other projects to help blind and
     visually impaired users of computers.  We build on Free Software
     and GNU/Linux, because we believe this is the right way.  But it
     won't be possible when we have no money.
     <http://www.freebsoft.org/>

   * _Report bugs:_ Every user, even if he can't give us money and he is
     not a programmer, can help us very much by just using our software
     and telling us about the bugs and inconveniences he encounters.  A
     good user community that reports bugs is a crucial part of
     development of a good Free Software package.  We can't test our
     software under all circumstances and on all platforms, so each
     constructive bug report is highly appreciated.  You can report bugs
     in Speech Dispatcher on <speechd@bugs.freebsoft.org>.

   * _Write or modify an application to support synthesis:_ With Speech
     Dispatcher, we have provided an interface that allows applications
     easy access to speech synthesis.  However powerful, it's no more
     than an interface, and it's useless on its own.  Now it's time to
     write the particular client applications, or modify existing
     applications so that they can support speech synthesis.  It is
     useful if the application needs a specific interface for blind
     people or if it wants to use speech synthesis for educational or
     other purposes.

   * _Develop new voices and language definitions for Festival:_ In the
     world of Free Software, currently Festival is the most promising
     interface for Text-to-Speech processing and speech synthesis.  It's
     an extensible and highly configurable platform for developing
     synthetic voices.  If there is a lack of synthetic voices or no
     voices at all for some language, we believe the wisest solution is
     to try to develop a voice in Festival.  It's certainly not
     advisable to develop your own synthesizer if the goal is producing
     a quality voice system in a reasonable time.  Festival developers
     provide nice documentation about how to develop a voice and a lot
     of tools that help doing this.  We found that some language
     definitions can be constructed by canibalizing the already existing
     definitions and can be tuned later.  As for the voice samples, one
     can temporarily use the MBROLA project voices.  But please note
     that, although they are downloadable for free (as price), they are
     not Free Software and it would be wonderful if we could replace
     them by Free Software alternatives as soon as possible.  See
     <http://www.cstr.ed.ac.uk/projects/festival/>.

   * _Help us with this or other Free-b-Soft projects:_ Please look at
     <http://www.freebsoft.org> to find information about our projects.
     There is a plenty of work to be done for the blind and visually
     impaired people to make their work with computers easier.

   * _Spread the word about Speech Dispatcher and Free Software:_ You
     can help us, and the whole community around Free Software, just by
     telling your friends about the amazing world of Free Software.  It
     doesn't have to be just about Speech Dispatcher; you can tell them
     about other projects or about Free Software in general.  Remember
     that Speech Dispatcher could only arise out of understanding of
     some people of the principles and ideas behind Free Software.  And
     this is mostly the same for the rest of the Free Software world.
     See <http://www.gnu.org/> for more information about GNU/Linux and
     Free Software.

File: speech-dispatcher.info,  Node: Appendices,  Next: GNU General Public License,  Prev: How You Can Help,  Up: Top

Appendix A Appendices
*********************

File: speech-dispatcher.info,  Node: GNU General Public License,  Next: GNU Free Documentation License,  Prev: Appendices,  Up: Top

Appendix B GNU General Public License
*************************************

                         Version 2, June 1991

     Copyright (C) 1989, 1991 Free Software Foundation, Inc.
     51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA

     Everyone is permitted to copy and distribute verbatim copies
     of this license document, but changing it is not allowed.

Preamble
========

The licenses for most software are designed to take away your freedom to
share and change it.  By contrast, the GNU General Public License is
intended to guarantee your freedom to share and change free software--to
make sure the software is free for all its users.  This General Public
License applies to most of the Free Software Foundation's software and
to any other program whose authors commit to using it.  (Some other Free
Software Foundation software is covered by the GNU Library General
Public License instead.)  You can apply it to your programs, too.

   When we speak of free software, we are referring to freedom, not
price.  Our General Public Licenses are designed to make sure that you
have the freedom to distribute copies of free software (and charge for
this service if you wish), that you receive source code or can get it if
you want it, that you can change the software or use pieces of it in new
free programs; and that you know you can do these things.

   To protect your rights, we need to make restrictions that forbid
anyone to deny you these rights or to ask you to surrender the rights.
These restrictions translate to certain responsibilities for you if you
distribute copies of the software, or if you modify it.

   For example, if you distribute copies of such a program, whether
gratis or for a fee, you must give the recipients all the rights that
you have.  You must make sure that they, too, receive or can get the
source code.  And you must show them these terms so they know their
rights.

   We protect your rights with two steps: (1) copyright the software,
and (2) offer you this license which gives you legal permission to copy,
distribute and/or modify the software.

   Also, for each author's protection and ours, we want to make certain
that everyone understands that there is no warranty for this free
software.  If the software is modified by someone else and passed on, we
want its recipients to know that what they have is not the original, so
that any problems introduced by others will not reflect on the original
authors' reputations.

   Finally, any free program is threatened constantly by software
patents.  We wish to avoid the danger that redistributors of a free
program will individually obtain patent licenses, in effect making the
program proprietary.  To prevent this, we have made it clear that any
patent must be licensed for everyone's free use or not licensed at all.

   The precise terms and conditions for copying, distribution and
modification follow.

    TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION

  0. This License applies to any program or other work which contains a
     notice placed by the copyright holder saying it may be distributed
     under the terms of this General Public License.  The "Program,"
     below, refers to any such program or work, and a "work based on the
     Program" means either the Program or any derivative work under
     copyright law: that is to say, a work containing the Program or a
     portion of it, either verbatim or with modifications and/or
     translated into another language.  (Hereinafter, translation is
     included without limitation in the term "modification.")  Each
     licensee is addressed as "you."

     Activities other than copying, distribution and modification are
     not covered by this License; they are outside its scope.  The act
     of running the Program is not restricted, and the output from the
     Program is covered only if its contents constitute a work based on
     the Program (independent of having been made by running the
     Program).  Whether that is true depends on what the Program does.

  1. You may copy and distribute verbatim copies of the Program's source
     code as you receive it, in any medium, provided that you
     conspicuously and appropriately publish on each copy an appropriate
     copyright notice and disclaimer of warranty; keep intact all the
     notices that refer to this License and to the absence of any
     warranty; and give any other recipients of the Program a copy of
     this License along with the Program.

     You may charge a fee for the physical act of transferring a copy,
     and you may at your option offer warranty protection in exchange
     for a fee.

  2. You may modify your copy or copies of the Program or any portion of
     it, thus forming a work based on the Program, and copy and
     distribute such modifications or work under the terms of Section 1
     above, provided that you also meet all of these conditions:

       a. You must cause the modified files to carry prominent notices
          stating that you changed the files and the date of any change.

       b. You must cause any work that you distribute or publish, that
          in whole or in part contains or is derived from the Program or
          any part thereof, to be licensed as a whole at no charge to
          all third parties under the terms of this License.

       c. If the modified program normally reads commands interactively
          when run, you must cause it, when started running for such
          interactive use in the most ordinary way, to print or display
          an announcement including an appropriate copyright notice and
          a notice that there is no warranty (or else, saying that you
          provide a warranty) and that users may redistribute the
          program under these conditions, and telling the user how to
          view a copy of this License.  (Exception: if the Program
          itself is interactive but does not normally print such an
          announcement, your work based on the Program is not required
          to print an announcement.)

     These requirements apply to the modified work as a whole.  If
     identifiable sections of that work are not derived from the
     Program, and can be reasonably considered independent and separate
     works in themselves, then this License, and its terms, do not apply
     to those sections when you distribute them as separate works.  But
     when you distribute the same sections as part of a whole which is a
     work based on the Program, the distribution of the whole must be on
     the terms of this License, whose permissions for other licensees
     extend to the entire whole, and thus to each and every part
     regardless of who wrote it.

     Thus, it is not the intent of this section to claim rights or
     contest your rights to work written entirely by you; rather, the
     intent is to exercise the right to control the distribution of
     derivative or collective works based on the Program.

     In addition, mere aggregation of another work not based on the
     Program with the Program (or with a work based on the Program) on a
     volume of a storage or distribution medium does not bring the other
     work under the scope of this License.

  3. You may copy and distribute the Program (or a work based on it,
     under Section 2) in object code or executable form under the terms
     of Sections 1 and 2 above provided that you also do one of the
     following:

       a. Accompany it with the complete corresponding machine-readable
          source code, which must be distributed under the terms of
          Sections 1 and 2 above on a medium customarily used for
          software interchange; or,

       b. Accompany it with a written offer, valid for at least three
          years, to give any third party, for a charge no more than your
          cost of physically performing source distribution, a complete
          machine-readable copy of the corresponding source code, to be
          distributed under the terms of Sections 1 and 2 above on a
          medium customarily used for software interchange; or,

       c. Accompany it with the information you received as to the offer
          to distribute corresponding source code.  (This alternative is
          allowed only for noncommercial distribution and only if you
          received the program in object code or executable form with
          such an offer, in accord with Subsection b above.)

     The source code for a work means the preferred form of the work for
     making modifications to it.  For an executable work, complete
     source code means all the source code for all modules it contains,
     plus any associated interface definition files, plus the scripts
     used to control compilation and installation of the executable.
     However, as a special exception, the source code distributed need
     not include anything that is normally distributed (in either source
     or binary form) with the major components (compiler, kernel, and so
     on) of the operating system on which the executable runs, unless
     that component itself accompanies the executable.

     If distribution of executable or object code is made by offering
     access to copy from a designated place, then offering equivalent
     access to copy the source code from the same place counts as
     distribution of the source code, even though third parties are not
     compelled to copy the source along with the object code.

  4. You may not copy, modify, sublicense, or distribute the Program
     except as expressly provided under this License.  Any attempt
     otherwise to copy, modify, sublicense or distribute the Program is
     void, and will automatically terminate your rights under this
     License.  However, parties who have received copies, or rights,
     from you under this License will not have their licenses terminated
     so long as such parties remain in full compliance.

  5. You are not required to accept this License, since you have not
     signed it.  However, nothing else grants you permission to modify
     or distribute the Program or its derivative works.  These actions
     are prohibited by law if you do not accept this License.
     Therefore, by modifying or distributing the Program (or any work
     based on the Program), you indicate your acceptance of this License
     to do so, and all its terms and conditions for copying,
     distributing or modifying the Program or works based on it.

  6. Each time you redistribute the Program (or any work based on the
     Program), the recipient automatically receives a license from the
     original licensor to copy, distribute or modify the Program subject
     to these terms and conditions.  You may not impose any further
     restrictions on the recipients' exercise of the rights granted
     herein.  You are not responsible for enforcing compliance by third
     parties to this License.

  7. If, as a consequence of a court judgment or allegation of patent
     infringement or for any other reason (not limited to patent
     issues), conditions are imposed on you (whether by court order,
     agreement or otherwise) that contradict the conditions of this
     License, they do not excuse you from the conditions of this
     License.  If you cannot distribute so as to satisfy simultaneously
     your obligations under this License and any other pertinent
     obligations, then as a consequence you may not distribute the
     Program at all.  For example, if a patent license would not permit
     royalty-free redistribution of the Program by all those who receive
     copies directly or indirectly through you, then the only way you
     could satisfy both it and this License would be to refrain entirely
     from distribution of the Program.

     If any portion of this section is held invalid or unenforceable
     under any particular circumstance, the balance of the section is
     intended to apply and the section as a whole is intended to apply
     in other circumstances.

     It is not the purpose of this section to induce you to infringe any
     patents or other property right claims or to contest validity of
     any such claims; this section has the sole purpose of protecting
     the integrity of the free software distribution system, which is
     implemented by public license practices.  Many people have made
     generous contributions to the wide range of software distributed
     through that system in reliance on consistent application of that
     system; it is up to the author/donor to decide if he or she is
     willing to distribute software through any other system and a
     licensee cannot impose that choice.

     This section is intended to make thoroughly clear what is believed
     to be a consequence of the rest of this License.

  8. If the distribution and/or use of the Program is restricted in
     certain countries either by patents or by copyrighted interfaces,
     the original copyright holder who places the Program under this
     License may add an explicit geographical distribution limitation
     excluding those countries, so that distribution is permitted only
     in or among countries not thus excluded.  In such case, this
     License incorporates the limitation as if written in the body of
     this License.

  9. The Free Software Foundation may publish revised and/or new
     versions of the General Public License from time to time.  Such new
     versions will be similar in spirit to the present version, but may
     differ in detail to address new problems or concerns.

     Each version is given a distinguishing version number.  If the
     Program specifies a version number of this License which applies to
     it and "any later version," you have the option of following the
     terms and conditions either of that version or of any later version
     published by the Free Software Foundation.  If the Program does not
     specify a version number of this License, you may choose any
     version ever published by the Free Software Foundation.

  10. If you wish to incorporate parts of the Program into other free
     programs whose distribution conditions are different, write to the
     author to ask for permission.  For software which is copyrighted by
     the Free Software Foundation, write to the Free Software
     Foundation; we sometimes make exceptions for this.  Our decision
     will be guided by the two goals of preserving the free status of
     all derivatives of our free software and of promoting the sharing
     and reuse of software generally.

                              NO WARRANTY

  a. BECAUSE THE PROGRAM IS LICENSED FREE OF CHARGE, THERE IS NO
     WARRANTY FOR THE PROGRAM, TO THE EXTENT PERMITTED BY APPLICABLE
     LAW.  EXCEPT WHEN OTHERWISE STATED IN WRITING THE COPYRIGHT HOLDERS
     AND/OR OTHER PARTIES PROVIDE THE PROGRAM "AS IS" WITHOUT WARRANTY
     OF ANY KIND, EITHER EXPRESSED OR IMPLIED, INCLUDING, BUT NOT
     LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
     FOR A PARTICULAR PURPOSE.  THE ENTIRE RISK AS TO THE QUALITY AND
     PERFORMANCE OF THE PROGRAM IS WITH YOU.  SHOULD THE PROGRAM PROVE
     DEFECTIVE, YOU ASSUME THE COST OF ALL NECESSARY SERVICING, REPAIR
     OR CORRECTION.

  b. IN NO EVENT UNLESS REQUIRED BY APPLICABLE LAW OR AGREED TO IN
     WRITING WILL ANY COPYRIGHT HOLDER, OR ANY OTHER PARTY WHO MAY
     MODIFY AND/OR REDISTRIBUTE THE PROGRAM AS PERMITTED ABOVE, BE
     LIABLE TO YOU FOR DAMAGES, INCLUDING ANY GENERAL, SPECIAL,
     INCIDENTAL OR CONSEQUENTIAL DAMAGES ARISING OUT OF THE USE OR
     INABILITY TO USE THE PROGRAM (INCLUDING BUT NOT LIMITED TO LOSS OF
     DATA OR DATA BEING RENDERED INACCURATE OR LOSSES SUSTAINED BY YOU
     OR THIRD PARTIES OR A FAILURE OF THE PROGRAM TO OPERATE WITH ANY
     OTHER PROGRAMS), EVEN IF SUCH HOLDER OR OTHER PARTY HAS BEEN
     ADVISED OF THE POSSIBILITY OF SUCH DAMAGES.

                      END OF TERMS AND CONDITIONS

How to Apply These Terms to Your New Programs
=============================================

If you develop a new program, and you want it to be of the greatest
possible use to the public, the best way to achieve this is to make it
free software which everyone can redistribute and change under these
terms.

   To do so, attach the following notices to the program.  It is safest
to attach them to the start of each source file to most effectively
convey the exclusion of warranty; and each file should have at least the
"copyright" line and a pointer to where the full notice is found.

     ONE LINE TO GIVE THE PROGRAM'S NAME AND AN IDEA OF WHAT IT DOES.
     Copyright (C) 19YY  NAME OF AUTHOR

     This program is free software; you can redistribute it and/or
     modify it under the terms of the GNU General Public License
     as published by the Free Software Foundation; either version 2
     of the License, or (at your option) any later version.

     This program is distributed in the hope that it will be useful,
     but WITHOUT ANY WARRANTY; without even the implied warranty of
     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
     GNU General Public License for more details.

     You should have received a copy of the GNU General Public License along
     with this program; if not, write to the Free Software Foundation, Inc.,
     51 Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA.

   Also add information on how to contact you by electronic and paper
mail.

   If the program is interactive, make it output a short notice like
this when it starts in an interactive mode:

     Gnomovision version 69, Copyright (C) 20YY NAME OF AUTHOR
     Gnomovision comes with ABSOLUTELY NO WARRANTY; for details
     type `show w'.  This is free software, and you are welcome
     to redistribute it under certain conditions; type `show c'
     for details.

   The hypothetical commands 'show w' and 'show c' should show the
appropriate parts of the General Public License.  Of course, the
commands you use may be called something other than 'show w' and 'show
c'; they could even be mouse-clicks or menu items--whatever suits your
program.

   You should also get your employer (if you work as a programmer) or
your school, if any, to sign a "copyright disclaimer" for the program,
if necessary.  Here is a sample; alter the names:

     Yoyodyne, Inc., hereby disclaims all copyright
     interest in the program `Gnomovision'
     (which makes passes at compilers) written
     by James Hacker.

     SIGNATURE OF TY COON, 1 April 1989
     Ty Coon, President of Vice

   This General Public License does not permit incorporating your
program into proprietary programs.  If your program is a subroutine
library, you may consider it more useful to permit linking proprietary
applications with the library.  If this is what you want to do, use the
GNU Library General Public License instead of this License.

File: speech-dispatcher.info,  Node: GNU Free Documentation License,  Next: Index of Concepts,  Prev: GNU General Public License,  Up: Top

Appendix C GNU Free Documentation License
*****************************************

                      Version 1.2, November 2002

     Copyright (C) 2000,2001,2002 Free Software Foundation, Inc.
     51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA

     Everyone is permitted to copy and distribute verbatim copies
     of this license document, but changing it is not allowed.

  0. PREAMBLE

     The purpose of this License is to make a manual, textbook, or other
     functional and useful document "free" in the sense of freedom: to
     assure everyone the effective freedom to copy and redistribute it,
     with or without modifying it, either commercially or
     noncommercially.  Secondarily, this License preserves for the
     author and publisher a way to get credit for their work, while not
     being considered responsible for modifications made by others.

     This License is a kind of "copyleft", which means that derivative
     works of the document must themselves be free in the same sense.
     It complements the GNU General Public License, which is a copyleft
     license designed for free software.

     We have designed this License in order to use it for manuals for
     free software, because free software needs free documentation: a
     free program should come with manuals providing the same freedoms
     that the software does.  But this License is not limited to
     software manuals; it can be used for any textual work, regardless
     of subject matter or whether it is published as a printed book.  We
     recommend this License principally for works whose purpose is
     instruction or reference.

  1. APPLICABILITY AND DEFINITIONS

     This License applies to any manual or other work, in any medium,
     that contains a notice placed by the copyright holder saying it can
     be distributed under the terms of this License.  Such a notice
     grants a world-wide, royalty-free license, unlimited in duration,
     to use that work under the conditions stated herein.  The
     "Document", below, refers to any such manual or work.  Any member
     of the public is a licensee, and is addressed as "you".  You accept
     the license if you copy, modify or distribute the work in a way
     requiring permission under copyright law.

     A "Modified Version" of the Document means any work containing the
     Document or a portion of it, either copied verbatim, or with
     modifications and/or translated into another language.

     A "Secondary Section" is a named appendix or a front-matter section
     of the Document that deals exclusively with the relationship of the
     publishers or authors of the Document to the Document's overall
     subject (or to related matters) and contains nothing that could
     fall directly within that overall subject.  (Thus, if the Document
     is in part a textbook of mathematics, a Secondary Section may not
     explain any mathematics.)  The relationship could be a matter of
     historical connection with the subject or with related matters, or
     of legal, commercial, philosophical, ethical or political position
     regarding them.

     The "Invariant Sections" are certain Secondary Sections whose
     titles are designated, as being those of Invariant Sections, in the
     notice that says that the Document is released under this License.
     If a section does not fit the above definition of Secondary then it
     is not allowed to be designated as Invariant.  The Document may
     contain zero Invariant Sections.  If the Document does not identify
     any Invariant Sections then there are none.

     The "Cover Texts" are certain short passages of text that are
     listed, as Front-Cover Texts or Back-Cover Texts, in the notice
     that says that the Document is released under this License.  A
     Front-Cover Text may be at most 5 words, and a Back-Cover Text may
     be at most 25 words.

     A "Transparent" copy of the Document means a machine-readable copy,
     represented in a format whose specification is available to the
     general public, that is suitable for revising the document
     straightforwardly with generic text editors or (for images composed
     of pixels) generic paint programs or (for drawings) some widely
     available drawing editor, and that is suitable for input to text
     formatters or for automatic translation to a variety of formats
     suitable for input to text formatters.  A copy made in an otherwise
     Transparent file format whose markup, or absence of markup, has
     been arranged to thwart or discourage subsequent modification by
     readers is not Transparent.  An image format is not Transparent if
     used for any substantial amount of text.  A copy that is not
     "Transparent" is called "Opaque".

     Examples of suitable formats for Transparent copies include plain
     ASCII without markup, Texinfo input format, LaTeX input format,
     SGML or XML using a publicly available DTD, and standard-conforming
     simple HTML, PostScript or PDF designed for human modification.
     Examples of transparent image formats include PNG, XCF and JPG.
     Opaque formats include proprietary formats that can be read and
     edited only by proprietary word processors, SGML or XML for which
     the DTD and/or processing tools are not generally available, and
     the machine-generated HTML, PostScript or PDF produced by some word
     processors for output purposes only.

     The "Title Page" means, for a printed book, the title page itself,
     plus such following pages as are needed to hold, legibly, the
     material this License requires to appear in the title page.  For
     works in formats which do not have any title page as such, "Title
     Page" means the text near the most prominent appearance of the
     work's title, preceding the beginning of the body of the text.

     A section "Entitled XYZ" means a named subunit of the Document
     whose title either is precisely XYZ or contains XYZ in parentheses
     following text that translates XYZ in another language.  (Here XYZ
     stands for a specific section name mentioned below, such as
     "Acknowledgements", "Dedications", "Endorsements", or "History".)
     To "Preserve the Title" of such a section when you modify the
     Document means that it remains a section "Entitled XYZ" according
     to this definition.

     The Document may include Warranty Disclaimers next to the notice
     which states that this License applies to the Document.  These
     Warranty Disclaimers are considered to be included by reference in
     this License, but only as regards disclaiming warranties: any other
     implication that these Warranty Disclaimers may have is void and
     has no effect on the meaning of this License.

  2. VERBATIM COPYING

     You may copy and distribute the Document in any medium, either
     commercially or noncommercially, provided that this License, the
     copyright notices, and the license notice saying this License
     applies to the Document are reproduced in all copies, and that you
     add no other conditions whatsoever to those of this License.  You
     may not use technical measures to obstruct or control the reading
     or further copying of the copies you make or distribute.  However,
     you may accept compensation in exchange for copies.  If you
     distribute a large enough number of copies you must also follow the
     conditions in section 3.

     You may also lend copies, under the same conditions stated above,
     and you may publicly display copies.

  3. COPYING IN QUANTITY

     If you publish printed copies (or copies in media that commonly
     have printed covers) of the Document, numbering more than 100, and
     the Document's license notice requires Cover Texts, you must
     enclose the copies in covers that carry, clearly and legibly, all
     these Cover Texts: Front-Cover Texts on the front cover, and
     Back-Cover Texts on the back cover.  Both covers must also clearly
     and legibly identify you as the publisher of these copies.  The
     front cover must present the full title with all words of the title
     equally prominent and visible.  You may add other material on the
     covers in addition.  Copying with changes limited to the covers, as
     long as they preserve the title of the Document and satisfy these
     conditions, can be treated as verbatim copying in other respects.

     If the required texts for either cover are too voluminous to fit
     legibly, you should put the first ones listed (as many as fit
     reasonably) on the actual cover, and continue the rest onto
     adjacent pages.

     If you publish or distribute Opaque copies of the Document
     numbering more than 100, you must either include a machine-readable
     Transparent copy along with each Opaque copy, or state in or with
     each Opaque copy a computer-network location from which the general
     network-using public has access to download using public-standard
     network protocols a complete Transparent copy of the Document, free
     of added material.  If you use the latter option, you must take
     reasonably prudent steps, when you begin distribution of Opaque
     copies in quantity, to ensure that this Transparent copy will
     remain thus accessible at the stated location until at least one
     year after the last time you distribute an Opaque copy (directly or
     through your agents or retailers) of that edition to the public.

     It is requested, but not required, that you contact the authors of
     the Document well before redistributing any large number of copies,
     to give them a chance to provide you with an updated version of the
     Document.

  4. MODIFICATIONS

     You may copy and distribute a Modified Version of the Document
     under the conditions of sections 2 and 3 above, provided that you
     release the Modified Version under precisely this License, with the
     Modified Version filling the role of the Document, thus licensing
     distribution and modification of the Modified Version to whoever
     possesses a copy of it.  In addition, you must do these things in
     the Modified Version:

       A. Use in the Title Page (and on the covers, if any) a title
          distinct from that of the Document, and from those of previous
          versions (which should, if there were any, be listed in the
          History section of the Document).  You may use the same title
          as a previous version if the original publisher of that
          version gives permission.

       B. List on the Title Page, as authors, one or more persons or
          entities responsible for authorship of the modifications in
          the Modified Version, together with at least five of the
          principal authors of the Document (all of its principal
          authors, if it has fewer than five), unless they release you
          from this requirement.

       C. State on the Title page the name of the publisher of the
          Modified Version, as the publisher.

       D. Preserve all the copyright notices of the Document.

       E. Add an appropriate copyright notice for your modifications
          adjacent to the other copyright notices.

       F. Include, immediately after the copyright notices, a license
          notice giving the public permission to use the Modified
          Version under the terms of this License, in the form shown in
          the Addendum below.

       G. Preserve in that license notice the full lists of Invariant
          Sections and required Cover Texts given in the Document's
          license notice.

       H. Include an unaltered copy of this License.

       I. Preserve the section Entitled "History", Preserve its Title,
          and add to it an item stating at least the title, year, new
          authors, and publisher of the Modified Version as given on the
          Title Page.  If there is no section Entitled "History" in the
          Document, create one stating the title, year, authors, and
          publisher of the Document as given on its Title Page, then add
          an item describing the Modified Version as stated in the
          previous sentence.

       J. Preserve the network location, if any, given in the Document
          for public access to a Transparent copy of the Document, and
          likewise the network locations given in the Document for
          previous versions it was based on.  These may be placed in the
          "History" section.  You may omit a network location for a work
          that was published at least four years before the Document
          itself, or if the original publisher of the version it refers
          to gives permission.

       K. For any section Entitled "Acknowledgements" or "Dedications",
          Preserve the Title of the section, and preserve in the section
          all the substance and tone of each of the contributor
          acknowledgements and/or dedications given therein.

       L. Preserve all the Invariant Sections of the Document, unaltered
          in their text and in their titles.  Section numbers or the
          equivalent are not considered part of the section titles.

       M. Delete any section Entitled "Endorsements".  Such a section
          may not be included in the Modified Version.

       N. Do not retitle any existing section to be Entitled
          "Endorsements" or to conflict in title with any Invariant
          Section.

       O. Preserve any Warranty Disclaimers.

     If the Modified Version includes new front-matter sections or
     appendices that qualify as Secondary Sections and contain no
     material copied from the Document, you may at your option designate
     some or all of these sections as invariant.  To do this, add their
     titles to the list of Invariant Sections in the Modified Version's
     license notice.  These titles must be distinct from any other
     section titles.

     You may add a section Entitled "Endorsements", provided it contains
     nothing but endorsements of your Modified Version by various
     parties--for example, statements of peer review or that the text
     has been approved by an organization as the authoritative
     definition of a standard.

     You may add a passage of up to five words as a Front-Cover Text,
     and a passage of up to 25 words as a Back-Cover Text, to the end of
     the list of Cover Texts in the Modified Version.  Only one passage
     of Front-Cover Text and one of Back-Cover Text may be added by (or
     through arrangements made by) any one entity.  If the Document
     already includes a cover text for the same cover, previously added
     by you or by arrangement made by the same entity you are acting on
     behalf of, you may not add another; but you may replace the old
     one, on explicit permission from the previous publisher that added
     the old one.

     The author(s) and publisher(s) of the Document do not by this
     License give permission to use their names for publicity for or to
     assert or imply endorsement of any Modified Version.

  5. COMBINING DOCUMENTS

     You may combine the Document with other documents released under
     this License, under the terms defined in section 4 above for
     modified versions, provided that you include in the combination all
     of the Invariant Sections of all of the original documents,
     unmodified, and list them all as Invariant Sections of your
     combined work in its license notice, and that you preserve all
     their Warranty Disclaimers.

     The combined work need only contain one copy of this License, and
     multiple identical Invariant Sections may be replaced with a single
     copy.  If there are multiple Invariant Sections with the same name
     but different contents, make the title of each such section unique
     by adding at the end of it, in parentheses, the name of the
     original author or publisher of that section if known, or else a
     unique number.  Make the same adjustment to the section titles in
     the list of Invariant Sections in the license notice of the
     combined work.

     In the combination, you must combine any sections Entitled
     "History" in the various original documents, forming one section
     Entitled "History"; likewise combine any sections Entitled
     "Acknowledgements", and any sections Entitled "Dedications".  You
     must delete all sections Entitled "Endorsements."

  6. COLLECTIONS OF DOCUMENTS

     You may make a collection consisting of the Document and other
     documents released under this License, and replace the individual
     copies of this License in the various documents with a single copy
     that is included in the collection, provided that you follow the
     rules of this License for verbatim copying of each of the documents
     in all other respects.

     You may extract a single document from such a collection, and
     distribute it individually under this License, provided you insert
     a copy of this License into the extracted document, and follow this
     License in all other respects regarding verbatim copying of that
     document.

  7. AGGREGATION WITH INDEPENDENT WORKS

     A compilation of the Document or its derivatives with other
     separate and independent documents or works, in or on a volume of a
     storage or distribution medium, is called an "aggregate" if the
     copyright resulting from the compilation is not used to limit the
     legal rights of the compilation's users beyond what the individual
     works permit.  When the Document is included in an aggregate, this
     License does not apply to the other works in the aggregate which
     are not themselves derivative works of the Document.

     If the Cover Text requirement of section 3 is applicable to these
     copies of the Document, then if the Document is less than one half
     of the entire aggregate, the Document's Cover Texts may be placed
     on covers that bracket the Document within the aggregate, or the
     electronic equivalent of covers if the Document is in electronic
     form.  Otherwise they must appear on printed covers that bracket
     the whole aggregate.

  8. TRANSLATION

     Translation is considered a kind of modification, so you may
     distribute translations of the Document under the terms of section
     4.  Replacing Invariant Sections with translations requires special
     permission from their copyright holders, but you may include
     translations of some or all Invariant Sections in addition to the
     original versions of these Invariant Sections.  You may include a
     translation of this License, and all the license notices in the
     Document, and any Warranty Disclaimers, provided that you also
     include the original English version of this License and the
     original versions of those notices and disclaimers.  In case of a
     disagreement between the translation and the original version of
     this License or a notice or disclaimer, the original version will
     prevail.

     If a section in the Document is Entitled "Acknowledgements",
     "Dedications", or "History", the requirement (section 4) to
     Preserve its Title (section 1) will typically require changing the
     actual title.

  9. TERMINATION

     You may not copy, modify, sublicense, or distribute the Document
     except as expressly provided for under this License.  Any other
     attempt to copy, modify, sublicense or distribute the Document is
     void, and will automatically terminate your rights under this
     License.  However, parties who have received copies, or rights,
     from you under this License will not have their licenses terminated
     so long as such parties remain in full compliance.

  10. FUTURE REVISIONS OF THIS LICENSE

     The Free Software Foundation may publish new, revised versions of
     the GNU Free Documentation License from time to time.  Such new
     versions will be similar in spirit to the present version, but may
     differ in detail to address new problems or concerns.  See
     <http://www.gnu.org/copyleft/>.

     Each version of the License is given a distinguishing version
     number.  If the Document specifies that a particular numbered
     version of this License "or any later version" applies to it, you
     have the option of following the terms and conditions either of
     that specified version or of any later version that has been
     published (not as a draft) by the Free Software Foundation.  If the
     Document does not specify a version number of this License, you may
     choose any version ever published (not as a draft) by the Free
     Software Foundation.

C.1 ADDENDUM: How to use this License for your documents
========================================================

To use this License in a document you have written, include a copy of
the License in the document and put the following copyright and license
notices just after the title page:

       Copyright (C)  YEAR  YOUR NAME.
       Permission is granted to copy, distribute and/or modify this document
       under the terms of the GNU Free Documentation License, Version 1.2
       or any later version published by the Free Software Foundation;
       with no Invariant Sections, no Front-Cover Texts, and no Back-Cover Texts.
       A copy of the license is included in the section entitled ``GNU
       Free Documentation License''.

   If you have Invariant Sections, Front-Cover Texts and Back-Cover
Texts, replace the "with...Texts."  line with this:

         with the Invariant Sections being LIST THEIR TITLES, with
         the Front-Cover Texts being LIST, and with the Back-Cover Texts
         being LIST.

   If you have Invariant Sections without Cover Texts, or some other
combination of the three, merge those two alternatives to suit the
situation.

   If your document contains nontrivial examples of program code, we
recommend releasing these examples in parallel under your choice of free
software license, such as the GNU General Public License, to permit
their use in free software.

File: speech-dispatcher.info,  Node: Index of Concepts,  Prev: GNU Free Documentation License,  Up: Top

Index of Concepts
*****************


* Menu:

* AddVoice:                              Configuration of the Generic Output Module.
                                                              (line  47)
* Basic ideas, Motivation:               Motivation.          (line   6)
* C API type:                            Speech Synthesis Commands in C.
                                                              (line   6)
* C API type <1>:                        Event Notification and Index Marking in C.
                                                              (line  11)
* C API type <2>:                        Event Notification and Index Marking in C.
                                                              (line  27)
* C API type <3>:                        Event Notification and Index Marking in C.
                                                              (line  49)
* char*:                                 Parameter Setting Commands in C.
                                                              (line  51)
* char* <1>:                             Direct SSIP Communication in C.
                                                              (line  38)
* char* <2>:                             Functions used by module_main.c.
                                                              (line   6)
* char* <3>:                             Functions used by module_main.c.
                                                              (line  12)
* char* <4>:                             Functions used by module_main.c.
                                                              (line  17)
* char* <5>:                             Functions used by module_main.c.
                                                              (line  24)
* char* <6>:                             Functions used by module_main.c.
                                                              (line  33)
* char**:                                Information Retrieval Commands in C.
                                                              (line   6)
* char** <1>:                            Information Retrieval Commands in C.
                                                              (line  16)
* char** <2>:                            Information Retrieval Commands in C.
                                                              (line  34)
* configuration:                         Configuration.       (line   6)
* DBG:                                   Initialization Macros and Functions.
                                                              (line  18)
* DBG <1>:                               Initialization Macros and Functions.
                                                              (line  19)
* default values:                        Configuration.       (line   6)
* Design:                                Basic Design.        (line   6)
* different synthesizers:                Synthesis Output Modules.
                                                              (line   6)
* do_pause:                              Functions used by module_main.c.
                                                              (line  18)
* do_quit:                               Functions used by module_main.c.
                                                              (line  40)
* do_set:                                Functions used by module_main.c.
                                                              (line  25)
* do_speak:                              Functions used by module_main.c.
                                                              (line   7)
* do_speaking:                           Functions used by module_main.c.
                                                              (line  34)
* do_stop:                               Functions used by module_main.c.
                                                              (line  13)
* FATAL:                                 Initialization Macros and Functions.
                                                              (line  24)
* FATAL <1>:                             Initialization Macros and Functions.
                                                              (line  25)
* FDL, GNU Free Documentation License:   GNU Free Documentation License.
                                                              (line   7)
* GenericExecuteSynth:                   Configuration of the Generic Output Module.
                                                              (line  14)
* GenericLanguage:                       Configuration of the Generic Output Module.
                                                              (line  51)
* GenericPitchAdd:                       Configuration of the Generic Output Module.
                                                              (line  64)
* GenericPitchMultiply:                  Configuration of the Generic Output Module.
                                                              (line  65)
* GenericRateAdd:                        Configuration of the Generic Output Module.
                                                              (line  62)
* GenericRateMultiply:                   Configuration of the Generic Output Module.
                                                              (line  63)
* GPL, GNU General Public License:       GNU General Public License.
                                                              (line   7)
* INIT_SETTINGS_TABLES:                  Initialization Macros and Functions.
                                                              (line   6)
* INIT_SETTINGS_TABLES <1>:              Initialization Macros and Functions.
                                                              (line   7)
* int:                                   Speech Synthesis Commands in C.
                                                              (line  21)
* int <1>:                               Speech Synthesis Commands in C.
                                                              (line  47)
* int <2>:                               Speech output control commands in C.
                                                              (line   9)
* int <3>:                               Speech output control commands in C.
                                                              (line  23)
* int <4>:                               Speech output control commands in C.
                                                              (line  30)
* int <5>:                               Speech output control commands in C.
                                                              (line  46)
* int <6>:                               Speech output control commands in C.
                                                              (line  53)
* int <7>:                               Speech output control commands in C.
                                                              (line  60)
* int <8>:                               Speech output control commands in C.
                                                              (line  76)
* int <9>:                               Speech output control commands in C.
                                                              (line  96)
* int <10>:                              Speech output control commands in C.
                                                              (line 103)
* int <11>:                              Speech output control commands in C.
                                                              (line 119)
* int <12>:                              Speech output control commands in C.
                                                              (line 131)
* int <13>:                              Speech output control commands in C.
                                                              (line 138)
* int <14>:                              Characters and Keys in C.
                                                              (line   6)
* int <15>:                              Characters and Keys in C.
                                                              (line  24)
* int <16>:                              Characters and Keys in C.
                                                              (line  32)
* int <17>:                              Sound Icons in C.    (line   6)
* int <18>:                              Parameter Setting Commands in C.
                                                              (line  14)
* int <19>:                              Parameter Setting Commands in C.
                                                              (line  24)
* int <20>:                              Parameter Setting Commands in C.
                                                              (line  35)
* int <21>:                              Parameter Setting Commands in C.
                                                              (line  63)
* int <22>:                              Parameter Setting Commands in C.
                                                              (line  80)
* int <23>:                              Parameter Setting Commands in C.
                                                              (line  94)
* int <24>:                              Parameter Setting Commands in C.
                                                              (line 106)
* int <25>:                              Parameter Setting Commands in C.
                                                              (line 120)
* int <26>:                              Parameter Setting Commands in C.
                                                              (line 131)
* int <27>:                              Parameter Setting Commands in C.
                                                              (line 140)
* int <28>:                              Parameter Setting Commands in C.
                                                              (line 151)
* int <29>:                              Parameter Setting Commands in C.
                                                              (line 160)
* int <30>:                              Parameter Setting Commands in C.
                                                              (line 172)
* int <31>:                              Event Notification and Index Marking in C.
                                                              (line  80)
* int <32>:                              Event Notification and Index Marking in C.
                                                              (line  82)
* int <33>:                              Event Notification and Index Marking in C.
                                                              (line  84)
* int <34>:                              Direct SSIP Communication in C.
                                                              (line  14)
* int <35>:                              Output Module Functions.
                                                              (line   6)
* int <36>:                              Functions for use when talking to synthesizer.
                                                              (line  47)
* int <37>:                              Multi-process output modules.
                                                              (line  53)
* int <38>:                              Multi-process output modules.
                                                              (line  86)
* int <39>:                              Multi-process output modules.
                                                              (line  92)
* int module_stop:                       Output Module Functions.
                                                              (line  58)
* int spd_pause():                       Speech output control commands in C.
                                                              (line  77)
* int spd_resume():                      Speech output control commands in C.
                                                              (line 120)
* module_child_dp_init:                  Multi-process output modules.
                                                              (line  71)
* module_child_dp_read:                  Multi-process output modules.
                                                              (line  88)
* module_child_dp_write:                 Multi-process output modules.
                                                              (line  76)
* module_close:                          Functions for use when talking to synthesizer.
                                                              (line  48)
* module_get_message_part:               Functions for use when talking to synthesizer.
                                                              (line   9)
* module_parent_dp_init:                 Multi-process output modules.
                                                              (line  66)
* module_parent_dp_read:                 Multi-process output modules.
                                                              (line  94)
* module_parent_dp_write:                Multi-process output modules.
                                                              (line  82)
* module_parent_wait_continue:           Multi-process output modules.
                                                              (line  55)
* module_parent_wfork:                   Multi-process output modules.
                                                              (line   9)
* module_pause():                        Output Module Functions.
                                                              (line  72)
* module_report_event_*:                 Functions for use when talking to synthesizer.
                                                              (line  37)
* module_report_index_mark:              Functions for use when talking to synthesizer.
                                                              (line  36)
* module_sigblockall:                    Multi-process output modules.
                                                              (line  99)
* module_sigblockusr:                    Multi-process output modules.
                                                              (line 109)
* module_sigunblockusr:                  Multi-process output modules.
                                                              (line 105)
* module_speak():                        Output Module Functions.
                                                              (line   8)
* module_stop():                         Output Module Functions.
                                                              (line  59)
* Other programs:                        Current State.       (line   6)
* output module:                         Synthesis Output Modules.
                                                              (line   6)
* Philosophy:                            Motivation.          (line   6)
* size_t:                                Multi-process output modules.
                                                              (line   6)
* size_t module_pause:                   Output Module Functions.
                                                              (line  71)
* SPDCallback:                           Event Notification and Index Marking in C.
                                                              (line  28)
* SPDCallbackIM:                         Event Notification and Index Marking in C.
                                                              (line  50)
* SPDConnection*:                        Initializing and Terminating in C.
                                                              (line   6)
* SPDConnection* <1>:                    Initializing and Terminating in C.
                                                              (line  62)
* SPDNotification:                       Event Notification and Index Marking in C.
                                                              (line  12)
* SPDPriority:                           Speech Synthesis Commands in C.
                                                              (line   7)
* spd_cancel_all():                      Speech output control commands in C.
                                                              (line  54)
* spd_cancel_uid():                      Speech output control commands in C.
                                                              (line  62)
* spd_char():                            Characters and Keys in C.
                                                              (line   8)
* spd_close():                           Initializing and Terminating in C.
                                                              (line  83)
* spd_execute_command():                 Direct SSIP Communication in C.
                                                              (line  16)
* spd_get_client_list():                 History Commands in C.
                                                              (line   6)
* spd_get_message_list_fd():             History Commands in C.
                                                              (line   5)
* spd_get_output_module():               Parameter Setting Commands in C.
                                                              (line  53)
* spd_get_voice_pitch():                 Parameter Setting Commands in C.
                                                              (line 152)
* spd_get_voice_rate():                  Parameter Setting Commands in C.
                                                              (line 132)
* spd_get_volume():                      Parameter Setting Commands in C.
                                                              (line 173)
* spd_history_select_client():           History Commands in C.
                                                              (line   6)
* spd_key():                             Characters and Keys in C.
                                                              (line  34)
* spd_list_modules():                    Information Retrieval Commands in C.
                                                              (line   7)
* spd_list_synthesis_voices():           Information Retrieval Commands in C.
                                                              (line  36)
* spd_list_voices():                     Information Retrieval Commands in C.
                                                              (line  17)
* spd_open():                            Initializing and Terminating in C.
                                                              (line   9)
* spd_open2():                           Initializing and Terminating in C.
                                                              (line  65)
* spd_pause_all():                       Speech output control commands in C.
                                                              (line  97)
* spd_pause_uid():                       Speech output control commands in C.
                                                              (line 105)
* spd_resume_all():                      Speech output control commands in C.
                                                              (line 132)
* spd_resume_uid():                      Speech output control commands in C.
                                                              (line 140)
* spd_say():                             Speech Synthesis Commands in C.
                                                              (line  23)
* spd_sayf():                            Speech Synthesis Commands in C.
                                                              (line  49)
* spd_say_wchar():                       Characters and Keys in C.
                                                              (line  26)
* spd_send_data():                       Direct SSIP Communication in C.
                                                              (line  40)
* spd_set_data_mode():                   Parameter Setting Commands in C.
                                                              (line  16)
* spd_set_language():                    Parameter Setting Commands in C.
                                                              (line  26)
* spd_set_notification:                  Event Notification and Index Marking in C.
                                                              (line  86)
* spd_set_notification_off:              Event Notification and Index Marking in C.
                                                              (line  84)
* spd_set_notification_on:               Event Notification and Index Marking in C.
                                                              (line  82)
* spd_set_output_module():               Parameter Setting Commands in C.
                                                              (line  37)
* spd_set_punctuation():                 Parameter Setting Commands in C.
                                                              (line  65)
* spd_set_spelling():                    Parameter Setting Commands in C.
                                                              (line  82)
* spd_set_voice_pitch():                 Parameter Setting Commands in C.
                                                              (line 142)
* spd_set_voice_rate():                  Parameter Setting Commands in C.
                                                              (line 122)
* spd_set_voice_type():                  Parameter Setting Commands in C.
                                                              (line  96)
* spd_set_voice_type() <1>:              Parameter Setting Commands in C.
                                                              (line 108)
* spd_set_volume():                      Parameter Setting Commands in C.
                                                              (line 162)
* spd_sound_icon():                      Sound Icons in C.    (line   8)
* spd_stop():                            Speech output control commands in C.
                                                              (line  10)
* spd_stop_all():                        Speech output control commands in C.
                                                              (line  24)
* spd_stop_uid():                        Speech output control commands in C.
                                                              (line  32)
* static:                                Functions for use when talking to synthesizer.
                                                              (line   6)
* static <1>:                            Memory Handling Functions.
                                                              (line   6)
* static <2>:                            Memory Handling Functions.
                                                              (line  10)
* Synthesizers:                          Current State.       (line   6)
* tail recursion:                        Index of Concepts.   (line   6)
* UPDATE_PARAMETER:                      Generic Macros and Functions.
                                                              (line   6)
* UPDATE_PARAMETER <1>:                  Generic Macros and Functions.
                                                              (line   7)
* UPDATE_STRING_PARAMETER:               Generic Macros and Functions.
                                                              (line  40)
* UPDATE_STRING_PARAMETER <1>:           Generic Macros and Functions.
                                                              (line  41)
* void:                                  Initializing and Terminating in C.
                                                              (line  82)
* void <1>:                              Functions used by module_main.c.
                                                              (line  39)
* void <2>:                              Functions for use when talking to synthesizer.
                                                              (line  35)
* void <3>:                              Functions for use when talking to synthesizer.
                                                              (line  36)
* void <4>:                              Multi-process output modules.
                                                              (line  64)
* void <5>:                              Multi-process output modules.
                                                              (line  69)
* void <6>:                              Multi-process output modules.
                                                              (line  74)
* void <7>:                              Multi-process output modules.
                                                              (line  80)
* void <8>:                              Multi-process output modules.
                                                              (line  98)
* void <9>:                              Multi-process output modules.
                                                              (line 103)
* void <10>:                             Multi-process output modules.
                                                              (line 107)
* void <11>:                             Memory Handling Functions.
                                                              (line  15)
* xfree:                                 Memory Handling Functions.
                                                              (line  16)
* xmalloc:                               Memory Handling Functions.
                                                              (line   7)
* xrealloc:                              Memory Handling Functions.
                                                              (line  12)


