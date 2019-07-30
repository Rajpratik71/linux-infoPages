Next: Introduction,  Prev: (dir),  Up: (dir)

GNU troff
*********

* Menu:

* Introduction::
* Invoking groff::
* Tutorial for Macro Users::
* Macro Packages::
* gtroff Reference::
* Preprocessors::
* Output Devices::
* File formats::
* Installation::
* Copying This Manual::
* Request Index::
* Escape Index::
* Operator Index::
* Register Index::
* Macro Index::
* String Index::
* Glyph Name Index::
* Font File Keyword Index::
* Program and File Index::
* Concept Index::

This manual documents GNU 'troff' version 1.22.3.

   Copyright © 1994-2014 Free Software Foundation, Inc.

     Permission is granted to copy, distribute and/or modify this
     document under the terms of the GNU Free Documentation License,
     Version 1.3 or any later version published by the Free Software
     Foundation; with no Invariant Sections, with the Front-Cover texts
     being "A GNU Manual," and with the Back-Cover Texts as in (a)
     below.  A copy of the license is included in the section entitled
     "GNU Free Documentation License."

     (a) The FSF's Back-Cover Text is: "You have the freedom to copy and
     modify this GNU manual.  Buying copies from the FSF supports it in
     developing GNU and promoting software freedom."

Next: Invoking groff,  Prev: Top,  Up: Top

1 Introduction
**************

GNU 'troff' (or 'groff') is a system for typesetting documents.  'troff'
is very flexible and has been used extensively for some thirty years.
It is well entrenched in the UNIX community.

* Menu:

* What Is groff?::
* History::
* groff Capabilities::
* Macro Package Intro::
* Preprocessor Intro::
* Output device intro::
* Credits::

Next: History,  Prev: Introduction,  Up: Introduction

1.1 What Is 'groff'?
====================

'groff' belongs to an older generation of document preparation systems,
which operate more like compilers than the more recent interactive
WYSIWYG(1) (*note What Is groff?-Footnote-1::) systems.  'groff' and its
contemporary counterpart, TeX, both work using a "batch" paradigm: The
input (or "source") files are normal text files with embedded formatting
commands.  These files can then be processed by 'groff' to produce a
typeset document on a variety of devices.

   'groff' should not be confused with a "word processor", an integrated
system of editor and text formatter.  Also, many word processors follow
the WYSIWYG paradigm discussed earlier.

   Although WYSIWYG systems may be easier to use, they have a number of
disadvantages compared to 'troff':

   * They must be used on a graphics display to work on a document.

   * Most of the WYSIWYG systems are either non-free or are not very
     portable.

   * 'troff' is firmly entrenched in all UNIX systems.

   * It is difficult to have a wide range of capabilities within the
     confines of a GUI/window system.

   * It is more difficult to make global changes to a document.

     "GUIs normally make it simple to accomplish simple actions and
     impossible to accomplish complex actions."  -Doug Gwyn (22/Jun/91
     in 'comp.unix.wizards')

Next: groff Capabilities,  Prev: What Is groff?,  Up: Introduction

1.2 History
===========

'troff' can trace its origins back to a formatting program called
'RUNOFF', written by Jerry Saltzer, which ran on the CTSS (_Compatible
Time Sharing System_, a project of MIT, the Massachusetts Institute of
Technology) in the mid-sixties.(1)  (*note History-Footnote-1::) The
name came from the use of the phrase "run off a document", meaning to
print it out.  Bob Morris ported it to the 635 architecture and called
the program 'roff' (an abbreviation of 'runoff').  It was rewritten as
'rf' for the PDP-7 (before having UNIX), and at the same time (1969),
Doug McIllroy rewrote an extended and simplified version of 'roff' in
the BCPL programming language.

   In 1971, the UNIX developers wanted to get a PDP-11, and to justify
the cost, proposed the development of a document formatting system for
the AT&T patents division.  This first formatting program was a
reimplementation of McIllroy's 'roff', written by J. F. Ossanna.

   When they needed a more flexible language, a new version of 'roff'
called 'nroff' ("Newer 'roff'") was written.  It had a much more
complicated syntax, but provided the basis for all future versions.
When they got a Graphic Systems CAT Phototypesetter, Ossanna wrote a
version of 'nroff' that would drive it.  It was dubbed 'troff', for
"typesetter 'roff'", although many people have speculated that it
actually means "Times 'roff'" because of the use of the Times font
family in 'troff' by default.  As such, the name 'troff' is pronounced
't-roff' rather than 'trough'.

   With 'troff' came 'nroff' (they were actually the same program except
for some '#ifdef's), which was for producing output for line printers
and character terminals.  It understood everything 'troff' did, and
ignored the commands that were not applicable (e.g. font changes).

   Since there are several things that cannot be done easily in 'troff',
work on several preprocessors began.  These programs would transform
certain parts of a document into 'troff', which made a very natural use
of pipes in UNIX.

   The 'eqn' preprocessor allowed mathematical formulæ to be specified
in a much simpler and more intuitive manner.  'tbl' is a preprocessor
for formatting tables.  The 'refer' preprocessor (and the similar
program, 'bib') processes citations in a document according to a
bibliographic database.

   Unfortunately, Ossanna's 'troff' was written in PDP-11 assembly
language and produced output specifically for the CAT phototypesetter.
He rewrote it in C, although it was now 7000 lines of uncommented code
and still dependent on the CAT.  As the CAT became less common, and was
no longer supported by the manufacturer, the need to make it support
other devices became a priority.  However, before this could be done,
Ossanna died by a severe heart attack in a hospital while recovering
from a previous one.

   So, Brian Kernighan took on the task of rewriting 'troff'.  The newly
rewritten version produced device independent code that was very easy
for postprocessors to read and translate to the appropriate printer
codes.  Also, this new version of 'troff' (called 'ditroff' for "device
independent 'troff'") had several extensions, which included drawing
functions.

   Due to the additional abilities of the new version of 'troff',
several new preprocessors appeared.  The 'pic' preprocessor provides a
wide range of drawing functions.  Likewise the 'ideal' preprocessor did
the same, although via a much different paradigm.  The 'grap'
preprocessor took specifications for graphs, but, unlike other
preprocessors, produced 'pic' code.

   James Clark began work on a GNU implementation of 'ditroff' in
early 1989.  The first version, 'groff' 0.3.1, was released June 1990.
'groff' included:

   * A replacement for 'ditroff' with many extensions.

   * The 'soelim', 'pic', 'tbl', and 'eqn' preprocessors.

   * Postprocessors for character devices, POSTSCRIPT, TeX DVI, and
     X Windows.  GNU 'troff' also eliminated the need for a separate
     'nroff' program with a postprocessor that would produce ASCII
     output.

   * A version of the 'me' macros and an implementation of the 'man'
     macros.

   Also, a front-end was included that could construct the, sometimes
painfully long, pipelines required for all the post- and preprocessors.

   Development of GNU 'troff' progressed rapidly, and saw the additions
of a replacement for 'refer', an implementation of the 'ms' and 'mm'
macros, and a program to deduce how to format a document ('grog').

   It was declared a stable (i.e. non-beta) package with the release of
version 1.04 around November 1991.

   Beginning in 1999, 'groff' has new maintainers (the package was an
orphan for a few years).  As a result, new features and programs like
'grn', a preprocessor for gremlin images, and an output device to
produce HTML and XHTML have been added.

Next: Macro Package Intro,  Prev: History,  Up: Introduction

1.3 'groff' Capabilities
========================

So what exactly is 'groff' capable of doing?  'groff' provides a wide
range of low-level text formatting operations.  Using these, it is
possible to perform a wide range of formatting tasks, such as footnotes,
table of contents, multiple columns, etc.  Here's a list of the most
important operations supported by 'groff':

   * text filling, adjusting, and centering

   * hyphenation

   * page control

   * font and glyph size control

   * vertical spacing (e.g. double-spacing)

   * line length and indenting

   * macros, strings, diversions, and traps

   * number registers

   * tabs, leaders, and fields

   * input and output conventions and character translation

   * overstrike, bracket, line drawing, and zero-width functions

   * local horizontal and vertical motions and the width function

   * three-part titles

   * output line numbering

   * conditional acceptance of input

   * environment switching

   * insertions from the standard input

   * input/output file switching

   * output and error messages

Next: Preprocessor Intro,  Prev: groff Capabilities,  Up: Introduction

1.4 Macro Packages
==================

Since 'groff' provides such low-level facilities, it can be quite
difficult to use by itself.  However, 'groff' provides a "macro"
facility to specify how certain routine operations (e.g. starting
paragraphs, printing headers and footers, etc.) should be done.  These
macros can be collected together into a "macro package".  There are a
number of macro packages available; the most common (and the ones
described in this manual) are 'man', 'mdoc', 'me', 'ms', and 'mm'.

Next: Output device intro,  Prev: Macro Package Intro,  Up: Introduction

1.5 Preprocessors
=================

Although 'groff' provides most functions needed to format a document,
some operations would be unwieldy (e.g. to draw pictures).  Therefore,
programs called "preprocessors" were written that understand their own
language and produce the necessary 'groff' operations.  These
preprocessors are able to differentiate their own input from the rest of
the document via markers.

   To use a preprocessor, UNIX pipes are used to feed the output from
the preprocessor into 'groff'.  Any number of preprocessors may be used
on a given document; in this case, the preprocessors are linked together
into one pipeline.  However, with 'groff', the user does not need to
construct the pipe, but only tell 'groff' what preprocessors to use.

   'groff' currently has preprocessors for producing tables ('tbl'),
typesetting equations ('eqn'), drawing pictures ('pic' and 'grn'),
processing bibliographies ('refer'), and drawing chemical structures
('chem').  An associated program that is useful when dealing with
preprocessors is 'soelim'.

   A free implementation of 'grap', a preprocessor for drawing graphs,
can be obtained as an extra package; 'groff' can use 'grap' also.

   Unique to 'groff' is the 'preconv' preprocessor that enables 'groff'
to handle documents in various input encodings.

   There are other preprocessors in existence, but, unfortunately, no
free implementations are available.  Among them is a preprocessor for
drawing mathematical pictures ('ideal').

Next: Credits,  Prev: Preprocessor Intro,  Up: Introduction

1.6 Output Devices
==================

'groff' actually produces device independent code that may be fed into a
postprocessor to produce output for a particular device.  Currently,
'groff' has postprocessors for POSTSCRIPT devices, character terminals,
X Windows (for previewing), TeX DVI format, HP LaserJet 4 and Canon LBP
printers (which use CAPSL), HTML, XHTML, and PDF.

Prev: Output device intro,  Up: Introduction

1.7 Credits
===========

Large portions of this manual were taken from existing documents, most
notably, the manual pages for the 'groff' package by James Clark, and
Eric Allman's papers on the 'me' macro package.

   The section on the 'man' macro package is partly based on Susan G.
Kleinmann's 'groff_man' manual page written for the Debian GNU/Linux
system.

   Larry Kollar contributed the section in the 'ms' macro package.

Next: Tutorial for Macro Users,  Prev: Introduction,  Up: Top

2 Invoking 'groff'
******************

This section focuses on how to invoke the 'groff' front end.  This front
end takes care of the details of constructing the pipeline among the
preprocessors, 'gtroff' and the postprocessor.

   It has become a tradition that GNU programs get the prefix 'g' to
distinguish it from its original counterparts provided by the host (see
*note Environment::, for more details).  Thus, for example, 'geqn' is
GNU 'eqn'.  On operating systems like GNU/Linux or the Hurd, which don't
contain proprietary versions of 'troff', and on MS-DOS/MS-Windows, where
'troff' and associated programs are not available at all, this prefix is
omitted since GNU 'troff' is the only used incarnation of 'troff'.
Exception: 'groff' is never replaced by 'roff'.

   In this document, we consequently say 'gtroff' when talking about the
GNU 'troff' program.  All other implementations of 'troff' are called
AT&T 'troff', which is the common origin of all 'troff' derivates (with
more or less compatible changes).  Similarly, we say 'gpic', 'geqn',
etc.

* Menu:

* Groff Options::
* Environment::
* Macro Directories::
* Font Directories::
* Paper Size::
* Invocation Examples::

Next: Environment,  Prev: Invoking groff,  Up: Invoking groff

2.1 Options
===========

'groff' normally runs the 'gtroff' program and a postprocessor
appropriate for the selected device.  The default device is 'ps' (but it
can be changed when 'groff' is configured and built).  It can optionally
preprocess with any of 'gpic', 'geqn', 'gtbl', 'ggrn', 'grap', 'gchem',
'grefer', 'gsoelim', or 'preconv'.

   This section only documents options to the 'groff' front end.  Many
of the arguments to 'groff' are passed on to 'gtroff', therefore those
are also included.  Arguments to pre- or postprocessors can be found in
*note Invoking gpic::, *note Invoking geqn::, *note Invoking gtbl::,
*note Invoking ggrn::, *note Invoking grefer::, *note Invoking gchem::,
*note Invoking gsoelim::, *note Invoking preconv::, *note Invoking
grotty::, *note Invoking grops::, *note Invoking gropdf::, *note
Invoking grohtml::, *note Invoking grodvi::, *note Invoking grolj4::,
*note Invoking grolbp::, and *note Invoking gxditview::.

   The command line format for 'groff' is:

     groff [ -abceghijklpstvzCEGNRSUVXZ ] [ -dCS ] [ -DARG ]
           [ -fFAM ] [ -FDIR ] [ -IDIR ] [ -KARG ]
           [ -LARG ] [ -mNAME ] [ -MDIR ] [ -nNUM ]
           [ -oLIST ] [ -PARG ] [ -rCN ] [ -TDEV ]
           [ -wNAME ] [ -WNAME ] [ FILES... ]

   The command line format for 'gtroff' is as follows.

     gtroff [ -abcivzCERU ] [ -dCS ] [ -fFAM ] [ -FDIR ]
            [ -mNAME ] [ -MDIR ] [ -nNUM ] [ -oLIST ]
            [ -rCN ] [ -TNAME ] [ -wNAME ] [ -WNAME ]
            [ FILES... ]

Obviously, many of the options to 'groff' are actually passed on to
'gtroff'.

   Options without an argument can be grouped behind a single '-'.  A
filename of '-' denotes the standard input.  It is possible to have
whitespace between an option and its parameter.

   The 'grog' command can be used to guess the correct 'groff' command
to format a file.

   Here's the description of the command-line options:

'-a'
     Generate an ASCII approximation of the typeset output.  The
     read-only register '.A' is then set to 1.  *Note Built-in
     Registers::.  A typical example is

          groff -a -man -Tdvi troff.man | less

     which shows how lines are broken for the DVI device.  Note that
     this option is rather useless today since graphic output devices
     are available virtually everywhere.

'-b'
     Print a backtrace with each warning or error message.  This
     backtrace should help track down the cause of the error.  The line
     numbers given in the backtrace may not always be correct: 'gtroff'
     can get confused by 'as' or 'am' requests while counting line
     numbers.

'-c'
     Suppress color output.

'-C'
     Enable compatibility mode.  *Note Implementation Differences::, for
     the list of incompatibilities between 'groff' and AT&T 'troff'.

'-dCS'
'-dNAME=S'
     Define C or NAME to be a string S.  C must be a one-letter name;
     NAME can be of arbitrary length.  All string assignments happen
     before loading any macro file (including the start-up file).

'-DARG'
     Set default input encoding used by 'preconv' to ARG.  Implies '-k'.

'-e'
     Preprocess with 'geqn'.

'-E'
     Inhibit all error messages.

'-fFAM'
     Use FAM as the default font family.  *Note Font Families::.

'-FDIR'
     Search 'DIR' for subdirectories 'devNAME' (NAME is the name of the
     device), for the 'DESC' file, and for font files before looking in
     the standard directories (*note Font Directories::).  This option
     is passed to all pre- and postprocessors using the
     'GROFF_FONT_PATH' environment variable.

'-g'
     Preprocess with 'ggrn'.

'-G'
     Preprocess with 'grap'.  Implies '-p'.

'-h'
     Print a help message.

'-i'
     Read the standard input after all the named input files have been
     processed.

'-IDIR'
     This option may be used to specify a directory to search for files.
     It is passed to the following programs:

        * 'gsoelim' (see *note gsoelim:: for more details); it also
          implies 'groff''s '-s' option.

        * 'gtroff'; it is used to search files named in the 'psbb' and
          'so' requests.

        * 'grops'; it is used to search files named in the
          '\X'ps: import' and '\X'ps: file' escapes.

     The current directory is always searched first.  This option may be
     specified more than once; the directories are searched in the order
     specified.  No directory search is performed for files specified
     using an absolute path.

'-j'
     Preprocess with 'gchem'.  Implies '-p'.

'-k'
     Preprocess with 'preconv'.  This is run before any other
     preprocessor.  Please refer to 'preconv''s manual page for its
     behaviour if no '-K' (or '-D') option is specified.

'-KARG'
     Set input encoding used by preconv to ARG.  Implies '-k'.

'-l'
     Send the output to a spooler for printing.  The command used for
     this is specified by the 'print' command in the device description
     file (see *note Font Files::, for more info).  If not present, '-l'
     is ignored.

'-LARG'
     Pass ARG to the spooler.  Each argument should be passed with a
     separate '-L' option.  Note that 'groff' does not prepend a '-' to
     ARG before passing it to the postprocessor.  If the 'print' keyword
     in the device description file is missing, '-L' is ignored.

'-mNAME'
     Read in the file 'NAME.tmac'.  Normally 'groff' searches for this
     in its macro directories.  If it isn't found, it tries 'tmac.NAME'
     (searching in the same directories).

'-MDIR'
     Search directory 'DIR' for macro files before the standard
     directories (*note Macro Directories::).

'-nNUM'
     Number the first page NUM.

'-N'
     Don't allow newlines with 'eqn' delimiters.  This is the same as
     the '-N' option in 'geqn'.

'-oLIST'
     Output only pages in LIST, which is a comma-separated list of page
     ranges; 'N' means print page N, 'M-N' means print every page
     between M and N, '-N' means print every page up to N, 'N-' means
     print every page beginning with N.  'gtroff' exits after printing
     the last page in the list.  All the ranges are inclusive on both
     ends.

     Within 'gtroff', this information can be extracted with the '.P'
     register.  *Note Built-in Registers::.

     If your document restarts page numbering at the beginning of each
     chapter, then 'gtroff' prints the specified page range for each
     chapter.

'-p'
     Preprocess with 'gpic'.

'-PARG'
     Pass ARG to the postprocessor.  Each argument should be passed with
     a separate '-P' option.  Note that 'groff' does not prepend '-' to
     ARG before passing it to the postprocessor.

'-rCN'
'-rNAME=N'
     Set number register C or NAME to the value N.  C must be a
     one-letter name; NAME can be of arbitrary length.  N can be any
     'gtroff' numeric expression.  All register assignments happen
     before loading any macro file (including the start-up file).

'-R'
     Preprocess with 'grefer'.  No mechanism is provided for passing
     arguments to 'grefer' because most 'grefer' options have equivalent
     commands that can be included in the file.  *Note grefer::, for
     more details.

     Note that 'gtroff' also accepts a '-R' option, which is not
     accessible via 'groff'.  This option prevents the loading of the
     'troffrc' and 'troffrc-end' files.

'-s'
     Preprocess with 'gsoelim'.

'-S'
     Safer mode.  Pass the '-S' option to 'gpic' and disable the 'open',
     'opena', 'pso', 'sy', and 'pi' requests.  For security reasons,
     this is enabled by default.

'-t'
     Preprocess with 'gtbl'.

'-TDEV'
     Prepare output for device DEV.  The default device is 'ps', unless
     changed when 'groff' was configured and built.  The following are
     the output devices currently available:

     'ps'
          For POSTSCRIPT printers and previewers.

     'pdf'
          For PDF viewers or printers.

     'dvi'
          For TeX DVI format.

     'X75'
          For a 75dpi X11 previewer.

     'X75-12'
          For a 75dpi X11 previewer with a 12pt base font in the
          document.

     'X100'
          For a 100dpi X11 previewer.

     'X100-12'
          For a 100dpi X11 previewer with a 12pt base font in the
          document.

     'ascii'
          For typewriter-like devices using the (7-bit) ASCII character
          set.

     'latin1'
          For typewriter-like devices that support the Latin-1
          (ISO 8859-1) character set.

     'utf8'
          For typewriter-like devices that use the Unicode (ISO 10646)
          character set with UTF-8 encoding.

     'cp1047'
          For typewriter-like devices that use the EBCDIC encoding IBM
          cp1047.

     'lj4'
          For HP LaserJet4-compatible (or other PCL5-compatible)
          printers.

     'lbp'
          For Canon CAPSL printers (LBP-4 and LBP-8 series laser
          printers).

     'html'
     'xhtml'
          To produce HTML and XHTML output, respectively.  Note that
          this driver consists of two parts, a preprocessor
          ('pre-grohtml') and a postprocessor ('post-grohtml').

     The predefined 'gtroff' string register '.T' contains the current
     output device; the read-only number register '.T' is set to 1 if
     this option is used (which is always true if 'groff' is used to
     call 'gtroff').  *Note Built-in Registers::.

     The postprocessor to be used for a device is specified by the
     'postpro' command in the device description file.  (*Note Font
     Files::, for more info.)  This can be overridden with the '-X'
     option.

'-U'
     Unsafe mode.  This enables the 'open', 'opena', 'pso', 'sy', and
     'pi' requests.

'-wNAME'
     Enable warning NAME.  Available warnings are described in *note
     Debugging::.  Multiple '-w' options are allowed.

'-WNAME'
     Inhibit warning NAME.  Multiple '-W' options are allowed.

'-v'
     Make programs run by 'groff' print out their version number.

'-V'
     Print the pipeline on 'stdout' instead of executing it.  If
     specified more than once, print the pipeline on 'stderr' and
     execute it.

'-X'
     Preview with 'gxditview' instead of using the usual postprocessor.
     This is unlikely to produce good results except with '-Tps'.

     Note that this is not the same as using '-TX75' or '-TX100' to view
     a document with 'gxditview': The former uses the metrics of the
     specified device, whereas the latter uses X-specific fonts and
     metrics.

'-z'
     Suppress output from 'gtroff'.  Only error messages are printed.

'-Z'
     Do not postprocess the output of 'gtroff'.  Normally 'groff'
     automatically runs the appropriate postprocessor.

Next: Macro Directories,  Prev: Groff Options,  Up: Invoking groff

2.2 Environment
===============

There are also several environment variables (of the operating system,
not within 'gtroff') that can modify the behavior of 'groff'.

'GROFF_BIN_PATH'
     This search path, followed by 'PATH', is used for commands executed
     by 'groff'.

'GROFF_COMMAND_PREFIX'
     If this is set to X, then 'groff' runs 'Xtroff' instead of
     'gtroff'.  This also applies to 'tbl', 'pic', 'eqn', 'grn', 'chem',
     'refer', and 'soelim'.  It does not apply to 'grops', 'grodvi',
     'grotty', 'pre-grohtml', 'post-grohtml', 'preconv', 'grolj4',
     'gropdf', and 'gxditview'.

     The default command prefix is determined during the installation
     process.  If a non-GNU troff system is found, prefix 'g' is used,
     none otherwise.

'GROFF_ENCODING'
     The value of this environment value is passed to the 'preconv'
     preprocessor to select the encoding of input files.  Setting this
     option implies 'groff''s command line option '-k' (this is, 'groff'
     actually always calls 'preconv').  If set without a value, 'groff'
     calls 'preconv' without arguments.  An explicit '-K' command line
     option overrides the value of 'GROFF_ENCODING'.  See the manual
     page of 'preconv' for details.

'GROFF_FONT_PATH'
     A colon-separated list of directories in which to search for the
     'dev'NAME directory (before the default directories are tried).
     *Note Font Directories::.

'GROFF_TMAC_PATH'
     A colon-separated list of directories in which to search for macro
     files (before the default directories are tried).  *Note Macro
     Directories::.

'GROFF_TMPDIR'
     The directory in which 'groff' creates temporary files.  If this is
     not set and 'TMPDIR' is set, temporary files are created in that
     directory.  Otherwise temporary files are created in a
     system-dependent default directory (on Unix and GNU/Linux systems,
     this is usually '/tmp').  'grops', 'grefer', 'pre-grohtml', and
     'post-grohtml' can create temporary files in this directory.

'GROFF_TYPESETTER'
     The default output device.

   Note that MS-DOS and MS-Windows ports of 'groff' use semi-colons,
rather than colons, to separate the directories in the lists described
above.

Next: Font Directories,  Prev: Environment,  Up: Invoking groff

2.3 Macro Directories
=====================

All macro file names must be named 'NAME.tmac' or 'tmac.NAME' to make
the '-mNAME' command line option work.  The 'mso' request doesn't have
this restriction; any file name can be used, and 'gtroff' won't try to
append or prepend the 'tmac' string.

   Macro files are kept in the "tmac directories", all of which
constitute the "tmac path".  The elements of the search path for macro
files are (in that order):

   * The directories specified with 'gtroff''s or 'groff''s '-M' command
     line option.

   * The directories given in the 'GROFF_TMAC_PATH' environment
     variable.

   * The current directory (only if in unsafe mode using the '-U'
     command line switch).

   * The home directory.

   * A platform-dependent directory, a site-specific
     (platform-independent) directory, and the main tmac directory; the
     default locations are

          /usr/local/lib/groff/site-tmac
          /usr/local/share/groff/site-tmac
          /usr/local/share/groff/1.22.3/tmac

     assuming that the version of 'groff' is 1.22.3, and the
     installation prefix was '/usr/local'.  It is possible to fine-tune
     those directories during the installation process.

Next: Paper Size,  Prev: Macro Directories,  Up: Invoking groff

2.4 Font Directories
====================

Basically, there is no restriction how font files for 'groff' are named
and how long font names are; however, to make the font family mechanism
work (*note Font Families::), fonts within a family should start with
the family name, followed by the shape.  For example, the Times family
uses 'T' for the family name and 'R', 'B', 'I', and 'BI' to indicate the
shapes 'roman', 'bold', 'italic', and 'bold italic', respectively.  Thus
the final font names are 'TR', 'TB', 'TI', and 'TBI'.

   All font files are kept in the "font directories", which constitute
the "font path".  The file search functions always append the directory
'dev'NAME, where NAME is the name of the output device.  Assuming, say,
DVI output, and '/foo/bar' as a font directory, the font files for
'grodvi' must be in '/foo/bar/devdvi'.

   The elements of the search path for font files are (in that order):

   * The directories specified with 'gtroff''s or 'groff''s '-F' command
     line option.  All device drivers and some preprocessors also have
     this option.

   * The directories given in the 'GROFF_FONT_PATH' environment
     variable.

   * A site-specific directory and the main font directory; the default
     locations are

          /usr/local/share/groff/site-font
          /usr/local/share/groff/1.22.3/font

     assuming that the version of 'groff' is 1.22.3, and the
     installation prefix was '/usr/local'.  It is possible to fine-tune
     those directories during the installation process.

Next: Invocation Examples,  Prev: Font Directories,  Up: Invoking groff

2.5 Paper Size
==============

In groff, the page size for 'gtroff' and for output devices are handled
separately.  *Note Page Layout::, for vertical manipulation of the page
size.  *Note Line Layout::, for horizontal changes.

   A default paper size can be set in the device's 'DESC' file.  Most
output devices also have a command line option '-p' to override the
default paper size and option '-l' to use landscape orientation.  *Note
DESC File Format::, for a description of the 'papersize' keyword, which
takes the same argument as '-p'.

   A convenient shorthand to set a particular paper size for 'gtroff' is
command line option '-dpaper=SIZE'.  This defines string 'paper', which
is processed in file 'papersize.tmac' (loaded in the start-up file
'troffrc' by default).  Possible values for SIZE are the same as the
predefined values for the 'papersize' keyword (but only in lowercase)
except 'a7'-'d7'.  An appended 'l' (ell) character denotes landscape
orientation.

   For example, use the following for PS output on A4 paper in landscape
orientation:

     groff -Tps -dpaper=a4l -P-pa4 -P-l -ms foo.ms > foo.ps

   Note that it is up to the particular macro package to respect default
page dimensions set in this way (most do).

Prev: Paper Size,  Up: Invoking groff

2.6 Invocation Examples
=======================

This section lists several common uses of 'groff' and the corresponding
command lines.

     groff file

This command processes 'file' without a macro package or a preprocessor.
The output device is the default, 'ps', and the output is sent to
'stdout'.

     groff -t -mandoc -Tascii file | less

This is basically what a call to the 'man' program does.  'gtroff'
processes the manual page 'file' with the 'mandoc' macro file (which in
turn either calls the 'man' or the 'mdoc' macro package), using the
'tbl' preprocessor and the ASCII output device.  Finally, the 'less'
pager displays the result.

     groff -X -m me file

Preview 'file' with 'gxditview', using the 'me' macro package.  Since no
'-T' option is specified, use the default device ('ps').  Note that you
can either say '-m me' or '-me'; the latter is an anachronism from the
early days of UNIX.(1)  (*note Invocation Examples-Footnote-1::)

     groff -man -rD1 -z file

Check 'file' with the 'man' macro package, forcing double-sided printing
- don't produce any output.

* Menu:

* grog::

Prev: Invocation Examples,  Up: Invocation Examples

2.6.1 'grog'
------------

'grog' reads files, guesses which of the 'groff' preprocessors and/or
macro packages are required for formatting them, and prints the 'groff'
command including those options on the standard output.  It generates
one or more of the options '-e', '-man', '-me', '-mm', '-mom', '-ms',
'-mdoc', '-mdoc-old', '-p', '-R', '-g', '-G', '-s', and '-t'.

   A special file name '-' refers to the standard input.  Specifying no
files also means to read the standard input.  Any specified options are
included in the printed command.  No space is allowed between options
and their arguments.  The only options recognized are '-C' (which is
also passed on) to enable compatibility mode, and '-v' to print the
version number and exit.

   For example,

     grog -Tdvi paper.ms

guesses the appropriate command to print 'paper.ms' and then prints it
to the command line after adding the '-Tdvi' option.  For direct
execution, enclose the call to 'grog' in backquotes at the UNIX shell
prompt:

     `grog -Tdvi paper.ms` > paper.dvi

As seen in the example, it is still necessary to redirect the output to
something meaningful (i.e. either a file or a pager program like
'less').

Next: Macro Packages,  Prev: Invoking groff,  Up: Top

3 Tutorial for Macro Users
**************************

Most users tend to use a macro package to format their papers.  This
means that the whole breadth of 'groff' is not necessary for most
people.  This chapter covers the material needed to efficiently use a
macro package.

* Menu:

* Basics::
* Common Features::

Next: Common Features,  Prev: Tutorial for Macro Users,  Up: Tutorial for Macro Users

3.1 Basics
==========

This section covers some of the basic concepts necessary to understand
how to use a macro package.(1)  (*note Basics-Footnote-1::) References
are made throughout to more detailed information, if desired.

   'gtroff' reads an input file prepared by the user and outputs a
formatted document suitable for publication or framing.  The input
consists of text, or words to be printed, and embedded commands
("requests" and "escapes"), which tell 'gtroff' how to format the
output.  For more detail on this, see *note Embedded Commands::.

   The word "argument" is used in this chapter to mean a word or number
that appears on the same line as a request, and which modifies the
meaning of that request.  For example, the request

     .sp

spaces one line, but

     .sp 4

spaces four lines.  The number 4 is an argument to the 'sp' request,
which says to space four lines instead of one.  Arguments are separated
from the request and from each other by spaces (_no_ tabs).  More
details on this can be found in *note Request and Macro Arguments::.

   The primary function of 'gtroff' is to collect words from input
lines, fill output lines with those words, justify the right-hand margin
by inserting extra spaces in the line, and output the result.  For
example, the input:

     Now is the time
     for all good men
     to come to the aid
     of their party.
     Four score and seven
     years ago, etc.

is read, packed onto output lines, and justified to produce:

     Now is the time for all good men to come to the aid of their party.
     Four score and seven years ago, etc.

   Sometimes a new output line should be started even though the current
line is not yet full; for example, at the end of a paragraph.  To do
this it is possible to cause a "break", which starts a new output line.
Some requests cause a break automatically, as normally do blank input
lines and input lines beginning with a space.

   Not all input lines are text to be formatted.  Some input lines are
requests that describe how to format the text.  Requests always have a
period ('.') or an apostrophe (''') as the first character of the input
line.

   The text formatter also does more complex things, such as
automatically numbering pages, skipping over page boundaries, putting
footnotes in the correct place, and so forth.

   Here are a few hints for preparing text for input to 'gtroff'.

   * First, keep the input lines short.  Short input lines are easier to
     edit, and 'gtroff' packs words onto longer lines anyhow.

   * In keeping with this, it is helpful to begin a new line after every
     comma or phrase, since common corrections are to add or delete
     sentences or phrases.

   * End each sentence with two spaces - or better, start each sentence
     on a new line.  'gtroff' recognizes characters that usually end a
     sentence, and inserts sentence space accordingly.

   * Do not hyphenate words at the end of lines - 'gtroff' is smart
     enough to hyphenate words as needed, but is not smart enough to
     take hyphens out and join a word back together.  Also, words such
     as "mother-in-law" should not be broken over a line, since then a
     space can occur where not wanted, such as "mother- in-law".

   'gtroff' double-spaces output text automatically if you use the
request '.ls 2'.  Reactivate single-spaced mode by typing '.ls 1'.(2)
(*note Basics-Footnote-2::)

   A number of requests allow to change the way the output looks,
sometimes called the "layout" of the output page.  Most of these
requests adjust the placing of "whitespace" (blank lines or spaces).

   The 'bp' request starts a new page, causing a line break.

   The request '.sp N' leaves N lines of blank space.  N can be omitted
(meaning skip a single line) or can be of the form Ni (for N inches) or
Nc (for N centimeters).  For example, the input:

     .sp 1.5i
     My thoughts on the subject
     .sp

leaves one and a half inches of space, followed by the line "My thoughts
on the subject", followed by a single blank line (more measurement units
are available, see *note Measurements::).

   Text lines can be centered by using the 'ce' request.  The line after
'ce' is centered (horizontally) on the page.  To center more than one
line, use '.ce N' (where N is the number of lines to center), followed
by the N lines.  To center many lines without counting them, type:

     .ce 1000
     lines to center
     .ce 0

The '.ce 0' request tells 'groff' to center zero more lines, in other
words, stop centering.

   All of these requests cause a break; that is, they always start a new
line.  To start a new line without performing any other action, use
'br'.

Prev: Basics,  Up: Tutorial for Macro Users

3.2 Common Features
===================

'gtroff' provides very low-level operations for formatting a document.
There are many common routine operations that are done in all documents.
These common operations are written into "macros" and collected into a
"macro package".

   All macro packages provide certain common capabilities that fall into
the following categories.

* Menu:

* Paragraphs::
* Sections and Chapters::
* Headers and Footers::
* Page Layout Adjustment::
* Displays::
* Footnotes and Annotations::
* Table of Contents::
* Indices::
* Paper Formats::
* Multiple Columns::
* Font and Size Changes::
* Predefined Strings::
* Preprocessor Support::
* Configuration and Customization::

Next: Sections and Chapters,  Prev: Common Features,  Up: Common Features

3.2.1 Paragraphs
----------------

One of the most common and most used capability is starting a paragraph.
There are a number of different types of paragraphs, any of which can be
initiated with macros supplied by the macro package.  Normally,
paragraphs start with a blank line and the first line indented, like the
text in this manual.  There are also block style paragraphs, which omit
the indentation:

     Some   men  look   at  constitutions   with  sanctimonious
     reverence, and deem them like the ark of the covenant, too
     sacred to be touched.

And there are also indented paragraphs, which begin with a tag or label
at the margin and the remaining text indented.

     one   This is  the first paragraph.  Notice  how the first
           line of  the resulting  paragraph lines up  with the
           other lines in the paragraph.

     longlabel
           This  paragraph   had  a  long   label.   The  first
           character of text on the first line does not line up
           with  the  text  on  second  and  subsequent  lines,
           although they line up with each other.

   A variation of this is a bulleted list.

     .     Bulleted lists start with a bullet.   It is possible
           to use other glyphs instead of the bullet.  In nroff
           mode using the ASCII character set for output, a dot
           is used instead of a real bullet.

Next: Headers and Footers,  Prev: Paragraphs,  Up: Common Features

3.2.2 Sections and Chapters
---------------------------

Most macro packages supply some form of section headers.  The simplest
kind is simply the heading on a line by itself in bold type.  Others
supply automatically numbered section heading or different heading
styles at different levels.  Some, more sophisticated, macro packages
supply macros for starting chapters and appendices.

Next: Page Layout Adjustment,  Prev: Sections and Chapters,  Up: Common Features

3.2.3 Headers and Footers
-------------------------

Every macro package gives some way to manipulate the "headers" and
"footers" (also called "titles") on each page.  This is text put at the
top and bottom of each page, respectively, which contain data like the
current page number, the current chapter title, and so on.  Its
appearance is not affected by the running text.  Some packages allow for
different ones on the even and odd pages (for material printed in a book
form).

   The titles are called "three-part titles", that is, there is a
left-justified part, a centered part, and a right-justified part.  An
automatically generated page number may be put in any of these fields
with the '%' character (see *note Page Layout::, for more details).

Next: Displays,  Prev: Headers and Footers,  Up: Common Features

3.2.4 Page Layout
-----------------

Most macro packages let the user specify top and bottom margins and
other details about the appearance of the printed pages.

Next: Footnotes and Annotations,  Prev: Page Layout Adjustment,  Up: Common Features

3.2.5 Displays
--------------

"Displays" are sections of text to be set off from the body of the
paper.  Major quotes, tables, and figures are types of displays, as are
all the examples used in this document.

   "Major quotes" are quotes that are several lines long, and hence are
set in from the rest of the text without quote marks around them.

   A "list" is an indented, single-spaced, unfilled display.  Lists
should be used when the material to be printed should not be filled and
justified like normal text, such as columns of figures or the examples
used in this paper.

   A "keep" is a display of lines that are kept on a single page if
possible.  An example for a keep might be a diagram.  Keeps differ from
lists in that lists may be broken over a page boundary whereas keeps are
not.

   "Floating keeps" move relative to the text.  Hence, they are good for
things that are referred to by name, such as "See figure 3".  A floating
keep appears at the bottom of the current page if it fits; otherwise, it
appears at the top of the next page.  Meanwhile, the surrounding text
'flows' around the keep, thus leaving no blank areas.

Next: Table of Contents,  Prev: Displays,  Up: Common Features

3.2.6 Footnotes and Annotations
-------------------------------

There are a number of requests to save text for later printing.

   "Footnotes" are printed at the bottom of the current page.

   "Delayed text" is very similar to a footnote except that it is
printed when called for explicitly.  This allows a list of references to
appear (for example) at the end of each chapter, as is the convention in
some disciplines.

   Most macro packages that supply this functionality also supply a
means of automatically numbering either type of annotation.

Next: Indices,  Prev: Footnotes and Annotations,  Up: Common Features

3.2.7 Table of Contents
-----------------------

"Tables of contents" are a type of delayed text having a tag (usually
the page number) attached to each entry after a row of dots.  The table
accumulates throughout the paper until printed, usually after the paper
has ended.  Many macro packages provide the ability to have several
tables of contents (e.g. a standard table of contents, a list of tables,
etc).

Next: Paper Formats,  Prev: Table of Contents,  Up: Common Features

3.2.8 Indices
-------------

While some macro packages use the term "index", none actually provide
that functionality.  The facilities they call indices are actually more
appropriate for tables of contents.

   To produce a real index in a document, external tools like the
'makeindex' program are necessary.

Next: Multiple Columns,  Prev: Indices,  Up: Common Features

3.2.9 Paper Formats
-------------------

Some macro packages provide stock formats for various kinds of
documents.  Many of them provide a common format for the title and
opening pages of a technical paper.  The 'mm' macros in particular
provide formats for letters and memoranda.

Next: Font and Size Changes,  Prev: Paper Formats,  Up: Common Features

3.2.10 Multiple Columns
-----------------------

Some macro packages (but not 'man') provide the ability to have two or
more columns on a page.

Next: Predefined Strings,  Prev: Multiple Columns,  Up: Common Features

3.2.11 Font and Size Changes
----------------------------

The built-in font and size functions are not always intuitive, so all
macro packages provide macros to make these operations simpler.

Next: Preprocessor Support,  Prev: Font and Size Changes,  Up: Common Features

3.2.12 Predefined Strings
-------------------------

Most macro packages provide various predefined strings for a variety of
uses; examples are sub- and superscripts, printable dates, quotes and
various special characters.

Next: Configuration and Customization,  Prev: Predefined Strings,  Up: Common Features

3.2.13 Preprocessor Support
---------------------------

All macro packages provide support for various preprocessors and may
extend their functionality.

   For example, all macro packages mark tables (which are processed with
'gtbl') by placing them between 'TS' and 'TE' macros.  The 'ms' macro
package has an option, '.TS H', that prints a caption at the top of a
new page (when the table is too long to fit on a single page).

Prev: Preprocessor Support,  Up: Common Features

3.2.14 Configuration and Customization
--------------------------------------

Some macro packages provide means of customizing many of the details of
how the package behaves.  This ranges from setting the default type size
to changing the appearance of section headers.

Next: gtroff Reference,  Prev: Tutorial for Macro Users,  Up: Top

4 Macro Packages
****************

This chapter documents the main macro packages that come with 'groff'.

   Different main macro packages can't be used at the same time; for
example

     groff -m man foo.man -m ms bar.doc

doesn't work.  Note that option arguments are processed before
non-option arguments; the above (failing) sample is thus reordered to

     groff -m man -m ms foo.man bar.doc

* Menu:

* man::
* mdoc::
* ms::
* me::
* mm::
* mom::

Next: mdoc,  Prev: Macro Packages,  Up: Macro Packages

4.1 'man'
=========

This is the most popular and probably the most important macro package
of 'groff'.  It is easy to use, and a vast majority of manual pages are
based on it.

* Menu:

* Man options::
* Man usage::
* Man font macros::
* Miscellaneous man macros::
* Predefined man strings::
* Preprocessors in man pages::
* Optional man extensions::

Next: Man usage,  Prev: man,  Up: man

4.1.1 Options
-------------

The command line format for using the 'man' macros with 'groff' is:

     groff -m man [ -rLL=LENGTH ] [ -rLT=LENGTH ] [ -rFT=DIST ]
           [ -rcR=1 ] [ -rC1 ] [ -rD1 ] [-rHY=FLAGS ]
           [ -rPNNN ] [ -rSXX ] [ -rXNNN ]
           [ -rIN=LENGTH ] [ -rSN=LENGTH ] [ FILES... ]

It is possible to use '-man' instead of '-m man'.

'-rcR=1'
     This option (the default if a TTY output device is used) creates a
     single, very long page instead of multiple pages.  Use '-rcR=0' to
     disable it.

'-rC1'
     If more than one manual page is given on the command line, number
     the pages continuously, rather than starting each at 1.

'-rD1'
     Double-sided printing.  Footers for even and odd pages are
     formatted differently.

'-rFT=DIST'
     Set the position of the footer text to DIST.  If positive, the
     distance is measured relative to the top of the page, otherwise it
     is relative to the bottom.  The default is -0.5i.

'-rHY=FLAGS'
     Set hyphenation flags.  Possible values are 1 to hyphenate without
     restrictions, 2 to not hyphenate the last word on a page, 4 to not
     hyphenate the last two characters of a word, and 8 to not hyphenate
     the first two characters of a word.  These values are additive; the
     default is 14.

'-rIN=LENGTH'
     Set the body text indentation to LENGTH.  If not specified, the
     indentation defaults to 7n (7 characters) in nroff mode and 7.2n
     otherwise.  For nroff, this value should always be an integer
     multiple of unit 'n' to get consistent indentation.

'-rLL=LENGTH'
     Set line length to LENGTH.  If not specified, the line length is
     set to respect any value set by a prior 'll' request (which _must_
     be in effect when the 'TH' macro is invoked), if this differs from
     the built-in default for the formatter; otherwise it defaults to
     78n in nroff mode (this is 78 characters per line) and 6.5i in
     troff mode.(1)  (*note Man options-Footnote-1::)

'-rLT=LENGTH'
     Set title length to LENGTH.  If not specified, the title length
     defaults to the line length.

'-rPNNN'
     Page numbering starts with NNN rather than with 1.

'-rSXX'
     Use XX (which can be 10, 11, or 12pt) as the base document font
     size instead of the default value of 10pt.

'-rSN=LENGTH'
     Set the indentation for sub-subheadings to LENGTH.  If not
     specified, the indentation defaults to 3n.

'-rXNNN'
     After page NNN, number pages as NNNa, NNNb, NNNc, etc.  For
     example, the option '-rX2' produces the following page numbers: 1,
     2, 2a, 2b, 2c, etc.

Next: Man font macros,  Prev: Man options,  Up: man

4.1.2 Usage
-----------

This section describes the available macros for manual pages.  For
further customization, put additional macros and requests into the file
'man.local', which is loaded immediately after the 'man' package.

 -- Macro: .TH title section [extra1 [extra2 [extra3]]]
     Set the title of the man page to TITLE and the section to SECTION,
     which must have a value between 1 and 8.  The value of SECTION may
     also have a string appended, e.g. '.pm', to indicate a specific
     subsection of the man pages.

     Both TITLE and SECTION are positioned at the left and right in the
     header line (with SECTION in parentheses immediately appended to
     TITLE.  EXTRA1 is positioned in the middle of the footer line.
     EXTRA2 is positioned at the left in the footer line (or at the left
     on even pages and at the right on odd pages if double-sided
     printing is active).  EXTRA3 is centered in the header line.

     For HTML and XHTML output, headers and footers are completely
     suppressed.

     Additionally, this macro starts a new page; the new line number
     is 1 again (except if the '-rC1' option is given on the command
     line) - this feature is intended only for formatting multiple man
     pages; a single man page should contain exactly one 'TH' macro at
     the beginning of the file.

 -- Macro: .SH [heading]
     Set up an unnumbered section heading sticking out to the left.
     Prints out all the text following 'SH' up to the end of the line
     (or the text in the next line if there is no argument to 'SH') in
     bold face (or the font specified by the string 'HF'), one size
     larger than the base document size.  Additionally, the left margin
     and the indentation for the following text is reset to its default
     value.

 -- Macro: .SS [heading]
     Set up an unnumbered (sub)section heading.  Prints out all the text
     following 'SS' up to the end of the line (or the text in the next
     line if there is no argument to 'SS') in bold face (or the font
     specified by the string 'HF'), at the same size as the base
     document size.  Additionally, the left margin and the indentation
     for the following text is reset to its default value.

 -- Macro: .TP [nnn]
     Set up an indented paragraph with label.  The indentation is set to
     NNN if that argument is supplied (the default unit is 'n' if
     omitted), otherwise it is set to the previous indentation value
     specified with 'TP', 'IP', or 'HP' (or to the default value if none
     of them have been used yet).

     The first line of text following this macro is interpreted as a
     string to be printed flush-left, as it is appropriate for a label.
     It is not interpreted as part of a paragraph, so there is no
     attempt to fill the first line with text from the following input
     lines.  Nevertheless, if the label is not as wide as the
     indentation the paragraph starts at the same line (but indented),
     continuing on the following lines.  If the label is wider than the
     indentation the descriptive part of the paragraph begins on the
     line following the label, entirely indented.  Note that neither
     font shape nor font size of the label is set to a default value; on
     the other hand, the rest of the text has default font settings.

 -- Macro: .LP
 -- Macro: .PP
 -- Macro: .P
     These macros are mutual aliases.  Any of them causes a line break
     at the current position, followed by a vertical space downwards by
     the amount specified by the 'PD' macro.  The font size and shape
     are reset to the default value (10pt roman if no '-rS' option is
     given on the command line).  Finally, the current left margin and
     the indentation is restored.

 -- Macro: .IP [designator [nnn]]
     Set up an indented paragraph, using DESIGNATOR as a tag to mark its
     beginning.  The indentation is set to NNN if that argument is
     supplied (default unit is 'n'), otherwise it is set to the previous
     indentation value specified with 'TP', 'IP', or 'HP' (or the
     default value if none of them have been used yet).  Font size and
     face of the paragraph (but not the designator) are reset to their
     default values.

     To start an indented paragraph with a particular indentation but
     without a designator, use '""' (two double quotes) as the first
     argument of 'IP'.

     For example, to start a paragraph with bullets as the designator
     and 4 en indentation, write

          .IP \(bu 4

 -- Macro: .HP [nnn]
     Set up a paragraph with hanging left indentation.  The indentation
     is set to NNN if that argument is supplied (default unit is 'n'),
     otherwise it is set to the previous indentation value specified
     with 'TP', 'IP', or 'HP' (or the default value if non of them have
     been used yet).  Font size and face are reset to their default
     values.

 -- Macro: .RS [nnn]
     Move the left margin to the right by the value NNN if specified
     (default unit is 'n'); otherwise it is set to the previous
     indentation value specified with 'TP', 'IP', or 'HP' (or to the
     default value if none of them have been used yet).  The indentation
     value is then set to the default.

     Calls to the 'RS' macro can be nested.

 -- Macro: .RE [nnn]
     Move the left margin back to level NNN, restoring the previous left
     margin.  If no argument is given, it moves one level back.  The
     first level (i.e., no call to 'RS' yet) has number 1, and each call
     to 'RS' increases the level by 1.

   To summarize, the following macros cause a line break with the
insertion of vertical space (which amount can be changed with the 'PD'
macro): 'SH', 'SS', 'TP', 'LP' ('PP', 'P'), 'IP', and 'HP'.

   The macros 'RS' and 'RE' also cause a break but do not insert
vertical space.

   Finally, the macros 'SH', 'SS', 'LP' ('PP', 'P'), and 'RS' reset the
indentation to its default value.

Next: Miscellaneous man macros,  Prev: Man usage,  Up: man

4.1.3 Macros to set fonts
-------------------------

The standard font is roman; the default text size is 10 point.  If
command line option '-rS=N' is given, use Npt as the default text size.

 -- Macro: .SM [text]
     Set the text on the same line or the text on the next line in a
     font that is one point size smaller than the default font.

 -- Macro: .SB [text]
     Set the text on the same line or the text on the next line in bold
     face font, one point size smaller than the default font.

 -- Macro: .BI text
     Set its arguments alternately in bold face and italic, without a
     space between the arguments.  Thus,

          .BI this "word and" that

     produces "thisword andthat" with "this" and "that" in bold face,
     and "word and" in italics.

 -- Macro: .IB text
     Set its arguments alternately in italic and bold face, without a
     space between the arguments.

 -- Macro: .RI text
     Set its arguments alternately in roman and italic, without a space
     between the arguments.

 -- Macro: .IR text
     Set its arguments alternately in italic and roman, without a space
     between the arguments.

 -- Macro: .BR text
     Set its arguments alternately in bold face and roman, without a
     space between the arguments.

 -- Macro: .RB text
     Set its arguments alternately in roman and bold face, without a
     space between the arguments.

 -- Macro: .B [text]
     Set TEXT in bold face.  If no text is present on the line where the
     macro is called, then the text of the next line appears in bold
     face.

 -- Macro: .I [text]
     Set TEXT in italic.  If no text is present on the line where the
     macro is called, then the text of the next line appears in italic.

Next: Predefined man strings,  Prev: Man font macros,  Up: man

4.1.4 Miscellaneous macros
--------------------------

The default indentation is 7.2n in troff mode and 7n in nroff mode
except for 'grohtml', which ignores indentation.

 -- Macro: .DT
     Set tabs every 0.5 inches.  Since this macro is always executed
     during a call to the 'TH' macro, it makes sense to call it only if
     the tab positions have been changed.

 -- Macro: .PD [nnn]
     Adjust the empty space before a new paragraph (or section).  The
     optional argument gives the amount of space (default unit is 'v');
     without parameter, the value is reset to its default value (1 line
     in nroff mode, 0.4v otherwise).

     This affects the macros 'SH', 'SS', 'TP', 'LP' (as well as 'PP' and
     'P'), 'IP', and 'HP'.

   The following two macros are included for BSD compatibility.

 -- Macro: .AT [system [release]]
     Alter the footer for use with AT&T manpages.  This command exists
     only for compatibility; don't use it.  The first argument SYSTEM
     can be:

     '3'
          7th Edition (the default)

     '4'
          System III

     '5'
          System V

     An optional second argument RELEASE to 'AT' specifies the release
     number (such as "System V Release 3").

 -- Macro: .UC [version]
     Alters the footer for use with BSD manpages.  This command exists
     only for compatibility; don't use it.  The argument can be:

     '3'
          3rd Berkeley Distribution (the default)

     '4'
          4th Berkeley Distribution

     '5'
          4.2 Berkeley Distribution

     '6'
          4.3 Berkeley Distribution

     '7'
          4.4 Berkeley Distribution

Next: Preprocessors in man pages,  Prev: Miscellaneous man macros,  Up: man

4.1.5 Predefined strings
------------------------

The following strings are defined:

 -- String: \*[S]
     Switch back to the default font size.

 -- String: \*[HF]
     The typeface used for headings.  The default is 'B'.

 -- String: \*[R]
     The 'registered' sign.

 -- String: \*[Tm]
     The 'trademark' sign.

 -- String: \*[lq]
 -- String: \*[rq]
     Left and right quote.  This is equal to '\(lq' and '\(rq',
     respectively.

Next: Optional man extensions,  Prev: Predefined man strings,  Up: man

4.1.6 Preprocessors in 'man' pages
----------------------------------

If a preprocessor like 'gtbl' or 'geqn' is needed, it has become common
usage to make the first line of the man page look like this:

     '\" WORD

Note the single space character after the double quote.  WORD consists
of letters for the needed preprocessors: 'e' for 'geqn', 'r' for
'grefer', 't' for 'gtbl'.  Modern implementations of the 'man' program
read this first line and automatically call the right preprocessor(s).

Prev: Preprocessors in man pages,  Up: man

4.1.7 Optional 'man' extensions
-------------------------------

Use the file 'man.local' for local extensions to the 'man' macros or for
style changes.

Custom headers and footers
..........................

In groff versions 1.18.2 and later, you can specify custom headers and
footers by redefining the following macros in 'man.local'.

 -- Macro: .PT
     Control the content of the headers.  Normally, the header prints
     the command name and section number on either side, and the
     optional fifth argument to 'TH' in the center.

 -- Macro: .BT
     Control the content of the footers.  Normally, the footer prints
     the page number and the third and fourth arguments to 'TH'.

     Use the 'FT' number register to specify the footer position.  The
     default is -0.5i.

Ultrix-specific man macros
..........................

The 'groff' source distribution includes a file named 'man.ultrix',
containing macros compatible with the Ultrix variant of 'man'.  Copy
this file into 'man.local' (or use the 'mso' request to load it) to
enable the following macros.

 -- Macro: .CT key
     Print '<CTRL/KEY>'.

 -- Macro: .CW
     Print subsequent text using the constant width (Courier) typeface.

 -- Macro: .Ds
     Begin a non-filled display.

 -- Macro: .De
     End a non-filled display started with 'Ds'.

 -- Macro: .EX [indent]
     Begin a non-filled display using the constant width (Courier)
     typeface.  Use the optional INDENT argument to indent the display.

 -- Macro: .EE
     End a non-filled display started with 'EX'.

 -- Macro: .G [text]
     Set TEXT in Helvetica.  If no text is present on the line where the
     macro is called, then the text of the next line appears in
     Helvetica.

 -- Macro: .GL [text]
     Set TEXT in Helvetica Oblique.  If no text is present on the line
     where the macro is called, then the text of the next line appears
     in Helvetica Oblique.

 -- Macro: .HB [text]
     Set TEXT in Helvetica Bold.  If no text is present on the line
     where the macro is called, then all text up to the next 'HB'
     appears in Helvetica Bold.

 -- Macro: .TB [text]
     Identical to 'HB'.

 -- Macro: .MS title sect [punct]
     Set a manpage reference in Ultrix format.  The TITLE is in Courier
     instead of italic.  Optional punctuation follows the section number
     without an intervening space.

 -- Macro: .NT ['C'] [title]
     Begin a note.  Print the optional title, or the word "Note",
     centered on the page.  Text following the macro makes up the body
     of the note, and is indented on both sides.  If the first argument
     is 'C', the body of the note is printed centered (the second
     argument replaces the word "Note" if specified).

 -- Macro: .NE
     End a note begun with 'NT'.

 -- Macro: .PN path [punct]
     Set the path name in constant width (Courier), followed by optional
     punctuation.

 -- Macro: .Pn [punct] path [punct]
     If called with two arguments, identical to 'PN'.  If called with
     three arguments, set the second argument in constant width
     (Courier), bracketed by the first and third arguments in the
     current font.

 -- Macro: .R
     Switch to roman font and turn off any underlining in effect.

 -- Macro: .RN
     Print the string '<RETURN>'.

 -- Macro: .VS ['4']
     Start printing a change bar in the margin if the number '4' is
     specified.  Otherwise, this macro does nothing.

 -- Macro: .VE
     End printing the change bar begun by 'VS'.

Simple example
..............

The following example 'man.local' file alters the 'SH' macro to add some
extra vertical space before printing the heading.  Headings are printed
in Helvetica Bold.

     .\" Make the heading fonts Helvetica
     .ds HF HB
     .
     .\" Put more whitespace in front of headings.
     .rn SH SH-orig
     .de SH
     .  if t .sp (u;\\n[PD]*2)
     .  SH-orig \\$*
     ..

Next: ms,  Prev: man,  Up: Macro Packages

4.2 'mdoc'
==========

See the 'groff_mdoc(7)' man page (type 'man groff_mdoc' at the command
line).

Next: me,  Prev: mdoc,  Up: Macro Packages

4.3 'ms'
========

The '-ms' macros are suitable for reports, letters, books, user manuals,
and so forth.  The package provides macros for cover pages, section
headings, paragraphs, lists, footnotes, pagination, and a table of
contents.

* Menu:

* ms Intro::
* General ms Structure::
* ms Document Control Registers::
* ms Cover Page Macros::
* ms Body Text::
* ms Page Layout::
* Differences from AT&T ms::
* Naming Conventions::

Next: General ms Structure,  Prev: ms,  Up: ms

4.3.1 Introduction to 'ms'
--------------------------

The original '-ms' macros were included with AT&T 'troff' as well as the
'man' macros.  While the 'man' package is intended for brief documents
that can be read on-line as well as printed, the 'ms' macros are
suitable for longer documents that are meant to be printed rather than
read on-line.

   The 'ms' macro package included with 'groff' is a complete, bottom-up
re-implementation.  Several macros (specific to AT&T or Berkeley) are
not included, while several new commands are.  *Note Differences from
AT&T ms::, for more information.

Next: ms Document Control Registers,  Prev: ms Intro,  Up: ms

4.3.2 General structure of an 'ms' document
-------------------------------------------

The 'ms' macro package expects a certain amount of structure, but not as
much as packages such as 'man' or 'mdoc'.

   The simplest documents can begin with a paragraph macro (such as 'LP'
or 'PP'), and consist of text separated by paragraph macros or even
blank lines.  Longer documents have a structure as follows:

*Document type*
     If you invoke the 'RP' (report) macro on the first line of the
     document, 'groff' prints the cover page information on its own
     page; otherwise it prints the information on the first page with
     your document text immediately following.  Other document formats
     found in AT&T 'troff' are specific to AT&T or Berkeley, and are not
     supported in 'groff'.

*Format and layout*
     By setting number registers, you can change your document's type
     (font and size), margins, spacing, headers and footers, and
     footnotes.  *Note ms Document Control Registers::, for more
     details.

*Cover page*
     A cover page consists of a title, the author's name and
     institution, an abstract, and the date.(1)  (*note General ms
     Structure-Footnote-1::) *Note ms Cover Page Macros::, for more
     details.

*Body*
     Following the cover page is your document.  You can use the 'ms'
     macros to write reports, letters, books, and so forth.  The package
     is designed for structured documents, consisting of paragraphs
     interspersed with headings and augmented by lists, footnotes,
     tables, and other common constructs.  *Note ms Body Text::, for
     more details.

*Table of contents*
     Longer documents usually include a table of contents, which you can
     invoke by placing the 'TC' macro at the end of your document.  The
     'ms' macros have minimal indexing facilities, consisting of the
     'IX' macro, which prints an entry on standard error.  Printing the
     table of contents at the end is necessary since 'groff' is a
     single-pass text formatter, thus it cannot determine the page
     number of each section until that section has actually been set and
     printed.  Since 'ms' output is intended for hardcopy, you can
     manually relocate the pages containing the table of contents
     between the cover page and the body text after printing.

Next: ms Cover Page Macros,  Prev: General ms Structure,  Up: ms

4.3.3 Document control registers
--------------------------------

The following is a list of document control number registers.  For the
sake of consistency, set registers related to margins at the beginning
of your document, or just after the 'RP' macro.  You can set other
registers later in your document, but you should keep them together at
the beginning to make them easy to find and edit as necessary.

Margin Settings
...............

 -- Register: \n[PO]
     Defines the page offset (i.e., the left margin).  There is no
     explicit right margin setting; the combination of the 'PO' and 'LL'
     registers implicitly define the right margin width.

     Effective: next page.

     Default value: 1i.

 -- Register: \n[LL]
     Defines the line length (i.e., the width of the body text).

     Effective: next paragraph.

     Default: 6i.

 -- Register: \n[LT]
     Defines the title length (i.e., the header and footer width).  This
     is usually the same as 'LL', but not necessarily.

     Effective: next paragraph.

     Default: 6i.

 -- Register: \n[HM]
     Defines the header margin height at the top of the page.

     Effective: next page.

     Default: 1i.

 -- Register: \n[FM]
     Defines the footer margin height at the bottom of the page.

     Effective: next page.

     Default: 1i.

Text Settings
.............

 -- Register: \n[PS]
     Defines the point size of the body text.  If the value is larger
     than or equal to 1000, divide it by 1000 to get a fractional point
     size.  For example, '.nr PS 10250' sets the document's point size
     to 10.25p.

     Effective: next paragraph.

     Default: 10p.

 -- Register: \n[VS]
     Defines the space between lines (line height plus leading).  If the
     value is larger than or equal to 1000, divide it by 1000 to get a
     fractional point size.  Due to backwards compatibility, 'VS' must
     be smaller than 40000 (this is 40.0p).

     Effective: next paragraph.

     Default: 12p.

 -- Register: \n[PSINCR]
     Defines an increment in point size, which is applied to section
     headings at nesting levels below the value specified in 'GROWPS'.
     The value of 'PSINCR' should be specified in points, with the p
     scaling factor, and may include a fractional component; for
     example, '.nr PSINCR 1.5p' sets a point size increment of 1.5p.

     Effective: next section heading.

     Default: 1p.

 -- Register: \n[GROWPS]
     Defines the heading level below which the point size increment set
     by 'PSINCR' becomes effective.  Section headings at and above the
     level specified by 'GROWPS' are printed at the point size set by
     'PS'; for each level below the value of 'GROWPS', the point size is
     increased in steps equal to the value of 'PSINCR'.  Setting
     'GROWPS' to any value less than 2 disables the incremental heading
     size feature.

     Effective: next section heading.

     Default: 0.

 -- Register: \n[HY]
     Defines the hyphenation level.  'HY' sets safely the value of the
     low-level 'hy' register.  Setting the value of 'HY' to 0 is
     equivalent to using the 'nh' request.

     Effective: next paragraph.

     Default: 14.

 -- Register: \n[FAM]
     Defines the font family used to typeset the document.

     Effective: next paragraph.

     Default: as defined in the output device.

Paragraph Settings
..................

 -- Register: \n[PI]
     Defines the initial indentation of a ('PP' macro) paragraph.

     Effective: next paragraph.

     Default: 5n.

 -- Register: \n[PD]
     Defines the space between paragraphs.

     Effective: next paragraph.

     Default: 0.3v.

 -- Register: \n[QI]
     Defines the indentation on both sides of a quoted ('QP' macro)
     paragraph.

     Effective: next paragraph.

     Default: 5n.

 -- Register: \n[PORPHANS]
     Defines the minimum number of initial lines of any paragraph that
     should be kept together, to avoid orphan lines at the bottom of a
     page.  If a new paragraph is started close to the bottom of a page,
     and there is insufficient space to accommodate 'PORPHANS' lines
     before an automatic page break, then the page break is forced,
     before the start of the paragraph.

     Effective: next paragraph.

     Default: 1.

 -- Register: \n[HORPHANS]
     Defines the minimum number of lines of the following paragraph that
     should be kept together with any section heading introduced by the
     'NH' or 'SH' macros.  If a section heading is placed close to the
     bottom of a page, and there is insufficient space to accommodate
     both the heading and at least 'HORPHANS' lines of the following
     paragraph, before an automatic page break, then the page break is
     forced before the heading.

     Effective: next paragraph.

     Default: 1.

Footnote Settings
.................

 -- Register: \n[FL]
     Defines the length of a footnote.

     Effective: next footnote.

     Default: '\n[LL]' * 5 / 6.

 -- Register: \n[FI]
     Defines the footnote indentation.

     Effective: next footnote.

     Default: 2n.

 -- Register: \n[FF]
     The footnote format:
     '0'
          Print the footnote number as a superscript; indent the
          footnote (default).

     '1'
          Print the number followed by a period (like 1.) and indent the
          footnote.

     '2'
          Like 1, without an indentation.

     '3'
          Like 1, but print the footnote number as a hanging paragraph.

     Effective: next footnote.

     Default: 0.

 -- Register: \n[FPS]
     Defines the footnote point size.  If the value is larger than or
     equal to 1000, divide it by 1000 to get a fractional point size.

     Effective: next footnote.

     Default: '\n[PS]' - 2.

 -- Register: \n[FVS]
     Defines the footnote vertical spacing.  If the value is larger than
     or equal to 1000, divide it by 1000 to get a fractional point size.

     Effective: next footnote.

     Default: '\n[FPS]' + 2.

 -- Register: \n[FPD]
     Defines the footnote paragraph spacing.

     Effective: next footnote.

     Default: '\n[PD]' / 2.

Miscellaneous Number Registers
..............................

 -- Register: \n[MINGW]
     Defines the minimum width between columns in a multi-column
     document.

     Effective: next page.

     Default: 2n.

 -- Register: \n[DD]
     Sets the vertical spacing before and after a display, a 'tbl'
     table, an 'eqn' equation, or a 'pic' image.

     Effective: next paragraph.

     Default: 0.5v.

Next: ms Body Text,  Prev: ms Document Control Registers,  Up: ms

4.3.4 Cover page macros
-----------------------

Use the following macros to create a cover page for your document in the
order shown.

 -- Macro: .RP ['no']
     Specifies the report format for your document.  The report format
     creates a separate cover page.  The default action (no 'RP' macro)
     is to print a subset of the cover page on page 1 of your document.

     If you use the word 'no' as an optional argument, 'groff' prints a
     title page but does not repeat any of the title page information
     (title, author, abstract, etc.) on page 1 of the document.

 -- Macro: .P1
     (P-one) Prints the header on page 1.  The default is to suppress
     the header.

 -- Macro: .DA [...]
     (optional) Prints the current date, or the arguments to the macro
     if any, on the title page (if specified) and in the footers.  This
     is the default for 'nroff'.

 -- Macro: .ND [...]
     (optional) Prints the current date, or the arguments to the macro
     if any, on the title page (if specified) but not in the footers.
     This is the default for 'troff'.

 -- Macro: .TL
     Specifies the document title.  'groff' collects text following the
     'TL' macro into the title, until reaching the author name or
     abstract.

 -- Macro: .AU
     Specifies the author's name, which appears on the line (or lines)
     immediately following.  You can specify multiple authors as
     follows:

          .AU
          John Doe
          .AI
          University of West Bumblefuzz
          .AU
          Martha Buck
          .AI
          Monolithic Corporation

          ...

 -- Macro: .AI
     Specifies the author's institution.  You can specify multiple
     institutions in the same way that you specify multiple authors.

 -- Macro: .AB ['no']
     Begins the abstract.  The default is to print the word ABSTRACT,
     centered and in italics, above the text of the abstract.  The word
     'no' as an optional argument suppresses this heading.

 -- Macro: .AE
     Ends the abstract.

   The following is example mark-up for a title page.

     .RP
     .TL
     The Inevitability of Code Bloat
     in Commercial and Free Software
     .AU
     J. Random Luser
     .AI
     University of West Bumblefuzz
     .AB
     This report examines the long-term growth
     of the code bases in two large, popular software
     packages; the free Emacs and the commercial
     Microsoft Word.
     While differences appear in the type or order
     of features added, due to the different
     methodologies used, the results are the same
     in the end.
     .PP
     The free software approach is shown to be
     superior in that while free software can
     become as bloated as commercial offerings,
     free software tends to have fewer serious
     bugs and the added features are in line with
     user demand.
     .AE

     ... the rest of the paper follows ...

Next: ms Page Layout,  Prev: ms Cover Page Macros,  Up: ms

4.3.5 Body text
---------------

This section describes macros used to mark up the body of your document.
Examples include paragraphs, sections, and other groups.

* Menu:

* Paragraphs in ms::
* Headings in ms::
* Highlighting in ms::
* Lists in ms::
* Indentation values in ms::
* Tabstops in ms::
* ms Displays and Keeps::
* ms Insertions::
* Example multi-page table::
* ms Footnotes::

Next: Headings in ms,  Prev: ms Body Text,  Up: ms Body Text

4.3.5.1 Paragraphs
..................

The following paragraph types are available.

 -- Macro: .PP
     Sets a paragraph with an initial indentation.

 -- Macro: .LP
     Sets a paragraph without an initial indentation.

 -- Macro: .QP
     Sets a paragraph that is indented at both left and right margins.
     The effect is identical to the HTML '<BLOCKQUOTE>' element.  The
     next paragraph or heading returns margins to normal.

 -- Macro: .XP
     Sets a paragraph whose lines are indented, except for the first
     line.  This is a Berkeley extension.

   The following markup uses all four paragraph macros.

     .NH 2
     Cases used in the study
     .LP
     The following software and versions were
     considered for this report.
     .PP
     For commercial software, we chose
     .B "Microsoft Word for Windows" ,
     starting with version 1.0 through the
     current version (Word 2000).
     .PP
     For free software, we chose
     .B Emacs ,
     from its first appearance as a standalone
     editor through the current version (v20).
     See [Bloggs 2002] for details.
     .QP
     Franklin's Law applied to software:
     software expands to outgrow both
     RAM and disk space over time.
     .LP
     Bibliography:
     .XP
     Bloggs, Joseph R.,
     .I "Everyone's a Critic" ,
     Underground Press, March 2002.
     A definitive work that answers all questions
     and criticisms about the quality and usability of
     free software.

   The 'PORPHANS' register (*note ms Document Control Registers::)
operates in conjunction with each of these macros, to inhibit the
printing of orphan lines at the bottom of any page.

Next: Highlighting in ms,  Prev: Paragraphs in ms,  Up: ms Body Text

4.3.5.2 Headings
................

Use headings to create a hierarchical structure for your document.  The
'ms' macros print headings in *bold*, using the same font family and
point size as the body text.

   The following describes the heading macros:

 -- Macro: .NH curr-level
 -- Macro: .NH S level0 ...
     Numbered heading.  The argument is either a numeric argument to
     indicate the level of the heading, or the letter 'S' followed by
     numeric arguments to set the heading level explicitly.

     If you specify heading levels out of sequence, such as invoking
     '.NH 3' after '.NH 1', 'groff' prints a warning on standard error.

 -- String: \*[SN]
 -- String: \*[SN-DOT]
 -- String: \*[SN-NO-DOT]
     After invocation of 'NH', the assigned section number is made
     available in the strings 'SN-DOT' (as it appears in a printed
     section heading with default formatting, followed by a terminating
     period), and 'SN-NO-DOT' (with the terminating period omitted).
     The string 'SN' is also defined, as an alias for 'SN-DOT'; if
     preferred, you may redefine it as an alias for 'SN-NO-DOT', by
     including the initialization
          .als SN SN-NO-DOT

     at any time *before* you would like the change to take effect.

 -- String: \*[SN-STYLE]
     You may control the style used to print section numbers, within
     numbered section headings, by defining an appropriate alias for the
     string 'SN-STYLE'.  The default style, in which the printed section
     number is followed by a terminating period, is obtained by defining
     the alias

          .als SN-STYLE SN-DOT

     If you prefer to omit the terminating period, from section numbers
     appearing in numbered section headings, you may define the alias

          .als SN-STYLE SN-NO-DOT

     Any such change in section numbering style becomes effective from
     the next use of '.NH', following redefinition of the alias for
     'SN-STYLE'.

 -- Macro: .SH [match-level]
     Unnumbered subheading.

     The optional MATCH-LEVEL argument is a GNU extension.  It is a
     number indicating the level of the heading, in a manner analogous
     to the CURR-LEVEL argument to '.NH'.  Its purpose is to match the
     point size, at which the heading is printed, to the size of a
     numbered heading at the same level, when the 'GROWPS' and 'PSINCR'
     heading size adjustment mechanism is in effect.  *Note ms Document
     Control Registers::.

   The 'HORPHANS' register (*note ms Document Control Registers::)
operates in conjunction with the 'NH' and 'SH' macros, to inhibit the
printing of orphaned section headings at the bottom of any page.

Next: Lists in ms,  Prev: Headings in ms,  Up: ms Body Text

4.3.5.3 Highlighting
....................

The 'ms' macros provide a variety of methods to highlight or emphasize
text:

 -- Macro: .B [txt [post [pre]]]
     Sets its first argument in *bold type*.  If you specify a second
     argument, 'groff' prints it in the previous font after the bold
     text, with no intervening space (this allows you to set punctuation
     after the highlighted text without highlighting the punctuation).
     Similarly, it prints the third argument (if any) in the previous
     font *before* the first argument.  For example,

          .B foo ) (

     prints (*foo*).

     If you give this macro no arguments, 'groff' prints all text
     following in bold until the next highlighting, paragraph, or
     heading macro.

 -- Macro: .R [txt [post [pre]]]
     Sets its first argument in roman (or regular) type.  It operates
     similarly to the 'B' macro otherwise.

 -- Macro: .I [txt [post [pre]]]
     Sets its first argument in _italic type_.  It operates similarly to
     the 'B' macro otherwise.

 -- Macro: .CW [txt [post [pre]]]
     Sets its first argument in a 'constant width face'.  It operates
     similarly to the 'B' macro otherwise.

 -- Macro: .BI [txt [post [pre]]]
     Sets its first argument in bold italic type.  It operates similarly
     to the 'B' macro otherwise.

 -- Macro: .BX [txt]
     Prints its argument and draws a box around it.  If you want to box
     a string that contains spaces, use a digit-width space ('\0').

 -- Macro: .UL [txt [post]]
     Prints its first argument with an underline.  If you specify a
     second argument, 'groff' prints it in the previous font after the
     underlined text, with no intervening space.

 -- Macro: .LG
     Prints all text following in larger type (two points larger than
     the current point size) until the next font size, highlighting,
     paragraph, or heading macro.  You can specify this macro multiple
     times to enlarge the point size as needed.

 -- Macro: .SM
     Prints all text following in smaller type (two points smaller than
     the current point size) until the next type size, highlighting,
     paragraph, or heading macro.  You can specify this macro multiple
     times to reduce the point size as needed.

 -- Macro: .NL
     Prints all text following in the normal point size (that is, the
     value of the 'PS' register).

 -- String: \*[{]
 -- String: \*[}]
     Text enclosed with '\*{' and '\*}' is printed as a superscript.

Next: Indentation values in ms,  Prev: Highlighting in ms,  Up: ms Body Text

4.3.5.4 Lists
.............

The 'IP' macro handles duties for all lists.

 -- Macro: .IP [marker [width]]
     The MARKER is usually a bullet glyph ('\[bu]') for unordered lists,
     a number (or auto-incrementing number register) for numbered lists,
     or a word or phrase for indented (glossary-style) lists.

     The WIDTH specifies the indentation for the body of each list item;
     its default unit is 'n'.  Once specified, the indentation remains
     the same for all list items in the document until specified again.

     The 'PORPHANS' register (*note ms Document Control Registers::)
     operates in conjunction with the 'IP' macro, to inhibit the
     printing of orphaned list markers at the bottom of any page.

   The following is an example of a bulleted list.

     A bulleted list:
     .IP \[bu] 2
     lawyers
     .IP \[bu]
     guns
     .IP \[bu]
     money

   Produces:

     A bulleted list:

     o lawyers

     o guns

     o money

   The following is an example of a numbered list.

     .nr step 1 1
     A numbered list:
     .IP \n[step] 3
     lawyers
     .IP \n+[step]
     guns
     .IP \n+[step]
     money

   Produces:

     A numbered list:

     1. lawyers

     2. guns

     3. money

   Note the use of the auto-incrementing number register in this
example.

   The following is an example of a glossary-style list.

     A glossary-style list:
     .IP lawyers 0.4i
     Two or more attorneys.
     .IP guns
     Firearms, preferably
     large-caliber.
     .IP money
     Gotta pay for those
     lawyers and guns!

   Produces:

     A glossary-style list:

     lawyers
           Two or more attorneys.

     guns  Firearms, preferably large-caliber.

     money
           Gotta pay for those lawyers and guns!

   In the last example, the 'IP' macro places the definition on the same
line as the term if it has enough space; otherwise, it breaks to the
next line and starts the definition below the term.  This may or may not
be the effect you want, especially if some of the definitions break and
some do not.  The following examples show two possible ways to force a
break.

   The first workaround uses the 'br' request to force a break after
printing the term or label.

     A glossary-style list:
     .IP lawyers 0.4i
     Two or more attorneys.
     .IP guns
     .br
     Firearms, preferably large-caliber.
     .IP money
     Gotta pay for those lawyers and guns!

   The second workaround uses the '\p' escape to force the break.  Note
the space following the escape; this is important.  If you omit the
space, 'groff' prints the first word on the same line as the term or
label (if it fits) *then* breaks the line.

     A glossary-style list:
     .IP lawyers 0.4i
     Two or more attorneys.
     .IP guns
     \p Firearms, preferably large-caliber.
     .IP money
     Gotta pay for those lawyers and guns!

   To set nested lists, use the 'RS' and 'RE' macros.  *Note Indentation
values in ms::, for more information.

   For example:

     .IP \[bu] 2
     Lawyers:
     .RS
     .IP \[bu]
     Dewey,
     .IP \[bu]
     Cheatham,
     .IP \[bu]
     and Howe.
     .RE
     .IP \[bu]
     Guns

   Produces:

     o Lawyers:

       o  Dewey,

       o  Cheatham,

       o  and Howe.

     o Guns

Next: Tabstops in ms,  Prev: Lists in ms,  Up: ms Body Text

4.3.5.5 Indentation values
..........................

In many situations, you may need to indentation a section of text while
still wrapping and filling.  *Note Lists in ms::, for an example of
nested lists.

 -- Macro: .RS
 -- Macro: .RE
     These macros begin and end an indented section.  The 'PI' register
     controls the amount of indentation, allowing the indented text to
     line up under hanging and indented paragraphs.

   *Note ms Displays and Keeps::, for macros to indentation and turn off
filling.

Next: ms Displays and Keeps,  Prev: Indentation values in ms,  Up: ms Body Text

4.3.5.6 Tab Stops
.................

Use the 'ta' request to define tab stops as needed.  *Note Tabs and
Fields::.

 -- Macro: .TA
     Use this macro to reset the tab stops to the default for 'ms'
     (every 5n).  You can redefine the 'TA' macro to create a different
     set of default tab stops.

Next: ms Insertions,  Prev: Tabstops in ms,  Up: ms Body Text

4.3.5.7 Displays and keeps
..........................

Use displays to show text-based examples or figures (such as code
listings).

   Displays turn off filling, so lines of code are displayed as-is
without inserting 'br' requests in between each line.  Displays can be
"kept" on a single page, or allowed to break across pages.

 -- Macro: .DS L
 -- Macro: .LD
 -- Macro: .DE
     Left-justified display.  The '.DS L' call generates a page break,
     if necessary, to keep the entire display on one page.  The 'LD'
     macro allows the display to break across pages.  The 'DE' macro
     ends the display.

 -- Macro: .DS I
 -- Macro: .ID
 -- Macro: .DE
     Indents the display as defined by the 'DI' register.  The '.DS I'
     call generates a page break, if necessary, to keep the entire
     display on one page.  The 'ID' macro allows the display to break
     across pages.  The 'DE' macro ends the display.

 -- Macro: .DS B
 -- Macro: .BD
 -- Macro: .DE
     Sets a block-centered display: the entire display is
     left-justified, but indented so that the longest line in the
     display is centered on the page.  The '.DS B' call generates a page
     break, if necessary, to keep the entire display on one page.  The
     'BD' macro allows the display to break across pages.  The 'DE'
     macro ends the display.

 -- Macro: .DS C
 -- Macro: .CD
 -- Macro: .DE
     Sets a centered display: each line in the display is centered.  The
     '.DS C' call generates a page break, if necessary, to keep the
     entire display on one page.  The 'CD' macro allows the display to
     break across pages.  The 'DE' macro ends the display.

 -- Macro: .DS R
 -- Macro: .RD
 -- Macro: .DE
     Right-justifies each line in the display.  The '.DS R' call
     generates a page break, if necessary, to keep the entire display on
     one page.  The 'RD' macro allows the display to break across pages.
     The 'DE' macro ends the display.

 -- Macro: .Ds
 -- Macro: .De
     These two macros were formerly provided as aliases for 'DS' and
     'DE', respectively.  They have been removed, and should no longer
     be used.  The original implementations of 'DS' and 'DE' are
     retained, and should be used instead.  X11 documents that actually
     use 'Ds' and 'De' always load a specific macro file from the X11
     distribution ('macros.t') that provides proper definitions for the
     two macros.

   On occasion, you may want to "keep" other text together on a page.
For example, you may want to keep two paragraphs together, or a
paragraph that refers to a table (or list, or other item) immediately
following.  The 'ms' macros provide the 'KS' and 'KE' macros for this
purpose.

 -- Macro: .KS
 -- Macro: .KE
     The 'KS' macro begins a block of text to be kept on a single page,
     and the 'KE' macro ends the block.

 -- Macro: .KF
 -- Macro: .KE
     Specifies a "floating keep"; if the keep cannot fit on the current
     page, 'groff' holds the contents of the keep and allows text
     following the keep (in the source file) to fill in the remainder of
     the current page.  When the page breaks, whether by an explicit
     'bp' request or by reaching the end of the page, 'groff' prints the
     floating keep at the top of the new page.  This is useful for
     printing large graphics or tables that do not need to appear
     exactly where specified.

   You can also use the 'ne' request to force a page break if there is
not enough vertical space remaining on the page.

   Use the following macros to draw a box around a section of text (such
as a display).

 -- Macro: .B1
 -- Macro: .B2
     Marks the beginning and ending of text that is to have a box drawn
     around it.  The 'B1' macro begins the box; the 'B2' macro ends it.
     Text in the box is automatically placed in a diversion (keep).

Next: Example multi-page table,  Prev: ms Displays and Keeps,  Up: ms Body Text

4.3.5.8 Tables, figures, equations, and references
..................................................

The 'ms' macros support the standard 'groff' preprocessors: 'tbl',
'pic', 'eqn', and 'refer'.  You mark text meant for preprocessors by
enclosing it in pairs of tags as follows.

 -- Macro: .TS ['H']
 -- Macro: .TE
     Denotes a table, to be processed by the 'tbl' preprocessor.  The
     optional argument 'H' to 'TS' instructs 'groff' to create a running
     header with the information up to the 'TH' macro.  'groff' prints
     the header at the beginning of the table; if the table runs onto
     another page, 'groff' prints the header on the next page as well.

 -- Macro: .PS
 -- Macro: .PE
     Denotes a graphic, to be processed by the 'pic' preprocessor.  You
     can create a 'pic' file by hand, using the AT&T 'pic' manual
     available on the Web as a reference, or by using a graphics program
     such as 'xfig'.

 -- Macro: .EQ [align]
 -- Macro: .EN
     Denotes an equation, to be processed by the 'eqn' preprocessor.
     The optional ALIGN argument can be 'C', 'L', or 'I' to center (the
     default), left-justify, or indent the equation.

 -- Macro: .[
 -- Macro: .]
     Denotes a reference, to be processed by the 'refer' preprocessor.
     The GNU 'refer(1)' man page provides a comprehensive reference to
     the preprocessor and the format of the bibliographic database.

* Menu:

* Example multi-page table::

Next: ms Footnotes,  Prev: ms Insertions,  Up: ms Body Text

4.3.5.9 An example multi-page table
...................................

The following is an example of how to set up a table that may print
across two or more pages.

     .TS H
     allbox expand;
     cb | cb .
     Text      ...of heading...
     _
     .TH
     .T&
     l | l .
     ... the rest of the table follows...
     .CW
     .TE

Prev: Example multi-page table,  Up: ms Body Text

4.3.5.10 Footnotes
..................

The 'ms' macro package has a flexible footnote system.  You can specify
either numbered footnotes or symbolic footnotes (that is, using a marker
such as a dagger symbol).

 -- String: \*[*]
     Specifies the location of a numbered footnote marker in the text.

 -- Macro: .FS
 -- Macro: .FE
     Specifies the text of the footnote.  The default action is to
     create a numbered footnote; you can create a symbolic footnote by
     specifying a "mark" glyph (such as '\[dg]' for the dagger glyph) in
     the body text and as an argument to the 'FS' macro, followed by the
     text of the footnote and the 'FE' macro.

   You can control how 'groff' prints footnote numbers by changing the
value of the 'FF' register.  *Note ms Document Control Registers::.

   Footnotes can be safely used within keeps and displays, but you
should avoid using numbered footnotes within floating keeps.  You can
set a second '\**' marker between a '\**' and its corresponding '.FS'
entry; as long as each 'FS' macro occurs _after_ the corresponding '\**'
and the occurrences of '.FS' are in the same order as the corresponding
occurrences of '\**'.

Next: Differences from AT&T ms,  Prev: ms Body Text,  Up: ms

4.3.6 Page layout
-----------------

The default output from the 'ms' macros provides a minimalist page
layout: it prints a single column, with the page number centered at the
top of each page.  It prints no footers.

   You can change the layout by setting the proper number registers and
strings.

* Menu:

* ms Headers and Footers::
* ms Margins::
* ms Multiple Columns::
* ms TOC::
* ms Strings and Special Characters::

Next: ms Margins,  Prev: ms Page Layout,  Up: ms Page Layout

4.3.6.1 Headers and footers
...........................

For documents that do not distinguish between odd and even pages, set
the following strings:

 -- String: \*[LH]
 -- String: \*[CH]
 -- String: \*[RH]
     Sets the left, center, and right headers.

 -- String: \*[LF]
 -- String: \*[CF]
 -- String: \*[RF]
     Sets the left, center, and right footers.

   For documents that need different information printed in the even and
odd pages, use the following macros:

 -- Macro: .OH 'left'center'right'
 -- Macro: .EH 'left'center'right'
 -- Macro: .OF 'left'center'right'
 -- Macro: .EF 'left'center'right'
     The 'OH' and 'EH' macros define headers for the odd and even pages;
     the 'OF' and 'EF' macros define footers for the odd and even pages.
     This is more flexible than defining the individual strings.

     You can replace the quote (''') marks with any character not
     appearing in the header or footer text.

   To specify custom header and footer processing, redefine the
following macros:

 -- Macro: .PT
 -- Macro: .HD
 -- Macro: .BT
     The 'PT' macro defines a custom header; the 'BT' macro defines a
     custom footer.  These macros must handle odd/even/first page
     differences if necessary.

     The 'HD' macro defines additional header processing to take place
     after executing the 'PT' macro.

Next: ms Multiple Columns,  Prev: ms Headers and Footers,  Up: ms Page Layout

4.3.6.2 Margins
...............

You control margins using a set of number registers.  *Note ms Document
Control Registers::, for details.

Next: ms TOC,  Prev: ms Margins,  Up: ms Page Layout

4.3.6.3 Multiple columns
........................

The 'ms' macros can set text in as many columns as do reasonably fit on
the page.  The following macros are available; all of them force a page
break if a multi-column mode is already set.  However, if the current
mode is single-column, starting a multi-column mode does _not_ force a
page break.

 -- Macro: .1C
     Single-column mode.

 -- Macro: .2C
     Two-column mode.

 -- Macro: .MC [width [gutter]]
     Multi-column mode.  If you specify no arguments, it is equivalent
     to the '2C' macro.  Otherwise, WIDTH is the width of each column
     and GUTTER is the space between columns.  The 'MINGW' number
     register controls the default gutter width.

Next: ms Strings and Special Characters,  Prev: ms Multiple Columns,  Up: ms Page Layout

4.3.6.4 Creating a table of contents
....................................

The facilities in the 'ms' macro package for creating a table of
contents are semi-automated at best.  Assuming that you want the table
of contents to consist of the document's headings, you need to repeat
those headings wrapped in 'XS' and 'XE' macros.

 -- Macro: .XS [page]
 -- Macro: .XA [page]
 -- Macro: .XE
     These macros define a table of contents or an individual entry in
     the table of contents, depending on their use.  The macros are very
     simple; they cannot indent a heading based on its level.  The
     easiest way to work around this is to add tabs to the table of
     contents string.  The following is an example:

          .NH 1
          Introduction
          .XS
          Introduction
          .XE
          .LP
          ...
          .CW
          .NH 2
          Methodology
          .XS
          Methodology
          .XE
          .LP
          ...

     You can manually create a table of contents by beginning with the
     'XS' macro for the first entry, specifying the page number for that
     entry as the argument to 'XS'.  Add subsequent entries using the
     'XA' macro, specifying the page number for that entry as the
     argument to 'XA'.  The following is an example:

          .XS 1
          Introduction
          .XA 2
          A Brief History of the Universe
          .XA 729
          Details of Galactic Formation
          ...
          .XE

 -- Macro: .TC ['no']
     Prints the table of contents on a new page, setting the page number
     to *i* (Roman lowercase numeral one).  You should usually place
     this macro at the end of the file, since 'groff' is a single-pass
     formatter and can only print what has been collected up to the
     point that the 'TC' macro appears.

     The optional argument 'no' suppresses printing the title specified
     by the string register 'TOC'.

 -- Macro: .PX ['no']
     Prints the table of contents on a new page, using the current page
     numbering sequence.  Use this macro to print a manually-generated
     table of contents at the beginning of your document.

     The optional argument 'no' suppresses printing the title specified
     by the string register 'TOC'.

   The 'Groff and Friends HOWTO' includes a 'sed' script that
automatically inserts 'XS' and 'XE' macro entries after each heading in
a document.

   Altering the 'NH' macro to automatically build the table of contents
is perhaps initially more difficult, but would save a great deal of time
in the long run if you use 'ms' regularly.

Prev: ms TOC,  Up: ms Page Layout

4.3.6.5 Strings and Special Characters
......................................

The 'ms' macros provide the following predefined strings.  You can
change the string definitions to help in creating documents in languages
other than English.

 -- String: \*[REFERENCES]
     Contains the string printed at the beginning of the references
     (bibliography) page.  The default is 'References'.

 -- String: \*[ABSTRACT]
     Contains the string printed at the beginning of the abstract.  The
     default is 'ABSTRACT'.

 -- String: \*[TOC]
     Contains the string printed at the beginning of the table of
     contents.

 -- String: \*[MONTH1]
 -- String: \*[MONTH2]
 -- String: \*[MONTH3]
 -- String: \*[MONTH4]
 -- String: \*[MONTH5]
 -- String: \*[MONTH6]
 -- String: \*[MONTH7]
 -- String: \*[MONTH8]
 -- String: \*[MONTH9]
 -- String: \*[MONTH10]
 -- String: \*[MONTH11]
 -- String: \*[MONTH12]
     Prints the full name of the month in dates.  The default is
     'January', 'February', etc.

   The following special characters are available(1) (*note ms Strings
and Special Characters-Footnote-1::):

 -- String: \*[-]
     Prints an em dash.

 -- String: \*[Q]
 -- String: \*[U]
     Prints typographer's quotes in troff, and plain quotes in nroff.
     '\*Q' is the left quote and '\*U' is the right quote.

   Improved accent marks are available in the 'ms' macros.

 -- Macro: .AM
     Specify this macro at the beginning of your document to enable
     extended accent marks and special characters.  This is a Berkeley
     extension.

     To use the accent marks, place them *after* the character being
     accented.

     Note that groff's native support for accents is superior to the
     following definitions.

   The following accent marks are available after invoking the 'AM'
macro:

 -- String: \*[']
     Acute accent.

 -- String: \*[`]
     Grave accent.

 -- String: \*[^]
     Circumflex.

 -- String: \*[,]
     Cedilla.

 -- String: \*[~]
     Tilde.

 -- String: \*[:]
     Umlaut.

 -- String: \*[v]
     Hacek.

 -- String: \*[_]
     Macron (overbar).

 -- String: \*[.]
     Underdot.

 -- String: \*[o]
     Ring above.

   The following are standalone characters available after invoking the
'AM' macro:

 -- String: \*[?]
     Upside-down question mark.

 -- String: \*[!]
     Upside-down exclamation point.

 -- String: \*[8]
     German ß ligature.

 -- String: \*[3]
     Yogh.

 -- String: \*[Th]
     Uppercase thorn.

 -- String: \*[th]
     Lowercase thorn.

 -- String: \*[D-]
     Uppercase eth.

 -- String: \*[d-]
     Lowercase eth.

 -- String: \*[q]
     Hooked o.

 -- String: \*[ae]
     Lowercase æ ligature.

 -- String: \*[Ae]
     Uppercase Æ ligature.

Next: Naming Conventions,  Prev: ms Page Layout,  Up: ms

4.3.7 Differences from AT&T 'ms'
--------------------------------

This section lists the (minor) differences between the 'groff -ms'
macros and AT&T 'troff -ms' macros.

   * The internals of 'groff -ms' differ from the internals of AT&T
     'troff -ms'.  Documents that depend upon implementation details of
     AT&T 'troff -ms' may not format properly with 'groff -ms'.

   * The general error-handling policy of 'groff -ms' is to detect and
     report errors, rather than silently to ignore them.

   * 'groff -ms' does not work in compatibility mode (this is, with the
     '-C' option).

   * There is no special support for typewriter-like devices.

   * 'groff -ms' does not provide cut marks.

   * Multiple line spacing is not supported.  Use a larger vertical
     spacing instead.

   * Some UNIX 'ms' documentation says that the 'CW' and 'GW' number
     registers can be used to control the column width and gutter width,
     respectively.  These number registers are not used in 'groff -ms'.

   * Macros that cause a reset (paragraphs, headings, etc.) may change
     the indentation.  Macros that change the indentation do not
     increment or decrement the indentation, but rather set it
     absolutely.  This can cause problems for documents that define
     additional macros of their own.  The solution is to use not the
     'in' request but instead the 'RS' and 'RE' macros.

   * To make 'groff -ms' use the default page offset (which also
     specifies the left margin), the 'PO' register must stay undefined
     until the first '-ms' macro is evaluated.  This implies that 'PO'
     should not be used early in the document, unless it is changed
     also: Remember that accessing an undefined register automatically
     defines it.

 -- Register: \n[GS]
     This number register is set to 1 by the 'groff -ms' macros, but it
     is not used by the 'AT&T' 'troff -ms' macros.  Documents that need
     to determine whether they are being formatted with 'AT&T' 'troff
     -ms' or 'groff -ms' should use this number register.

   Emulations of a few ancient Bell Labs macros can be re-enabled by
calling the otherwise undocumented 'SC' section-header macro.  Calling
'SC' enables 'UC' for marking up a product or application name, and the
pair 'P1'/'P2' for surrounding code example displays.

   These are not enabled by default because (a) they were not
documented, in the original 'ms' manual, and (b) the 'P1' and 'UC'
macros collide with different macros with the same names in the Berkeley
version of 'ms'.

   These 'groff' emulations are sufficient to give back the 1976
Kernighan & Cherry paper 'Typsetting Mathematics - User's Guide' its
section headings, and restore some text that had gone missing as
arguments of undefined macros.  No warranty express or implied is given
as to how well the typographic details these produce match the original
Bell Labs macros.

* Menu:

* Missing ms Macros::
* Additional ms Macros::

Next: Additional ms Macros,  Prev: Differences from AT&T ms,  Up: Differences from AT&T ms

4.3.7.1 'troff' macros not appearing in 'groff'
...............................................

Macros missing from 'groff -ms' are cover page macros specific to Bell
Labs and Berkeley.  The macros known to be missing are:

'.TM'
     Technical memorandum; a cover sheet style

'.IM'
     Internal memorandum; a cover sheet style

'.MR'
     Memo for record; a cover sheet style

'.MF'
     Memo for file; a cover sheet style

'.EG'
     Engineer's notes; a cover sheet style

'.TR'
     Computing Science Tech Report; a cover sheet style

'.OK'
     Other keywords

'.CS'
     Cover sheet information

'.MH'
     A cover sheet macro

Prev: Missing ms Macros,  Up: Differences from AT&T ms

4.3.7.2 'groff' macros not appearing in AT&T 'troff'
....................................................

The 'groff -ms' macros have a few minor extensions compared to the AT&T
'troff -ms' macros.

 -- Macro: .AM
     Improved accent marks.  *Note ms Strings and Special Characters::,
     for details.

 -- Macro: .DS I
     Indented display.  The default behavior of AT&T 'troff -ms' was to
     indent; the 'groff' default prints displays flush left with the
     body text.

 -- Macro: .CW
     Print text in 'constant width' (Courier) font.

 -- Macro: .IX
     Indexing term (printed on standard error).  You can write a script
     to capture and process an index generated in this manner.

   The following additional number registers appear in 'groff -ms':

 -- Register: \n[MINGW]
     Specifies a minimum space between columns (for multi-column
     output); this takes the place of the 'GW' register that was
     documented but apparently not implemented in AT&T 'troff'.

   Several new string registers are available as well.  You can change
these to handle (for example) the local language.  *Note ms Strings and
Special Characters::, for details.

Prev: Differences from AT&T ms,  Up: ms

4.3.8 Naming Conventions
------------------------

The following conventions are used for names of macros, strings and
number registers.  External names available to documents that use the
'groff -ms' macros contain only uppercase letters and digits.

   Internally the macros are divided into modules; naming conventions
are as follows:

   * Names used only within one module are of the form MODULE'*'NAME.

   * Names used outside the module in which they are defined are of the
     form MODULE'@'NAME.

   * Names associated with a particular environment are of the form
     ENVIRONMENT':'NAME; these are used only within the 'par' module.

   * NAME does not have a module prefix.

   * Constructed names used to implement arrays are of the form
     ARRAY'!'INDEX.

   Thus the groff ms macros reserve the following names:

   * Names containing the characters '*', '@', and ':'.

   * Names containing only uppercase letters and digits.

Next: mm,  Prev: ms,  Up: Macro Packages

4.4 'me'
========

See the 'meintro.me' and 'meref.me' documents in groff's 'doc'
directory.

Next: mom,  Prev: me,  Up: Macro Packages

4.5 'mm'
========

See the 'groff_mm(7)' man page (type 'man groff_mm' at the command
line).

Prev: mm,  Up: Macro Packages

4.6 'mom'
=========

See the 'groff_mom(7)' man page (type 'man groff_mom' at the command
line), which gives a short overview and a link to its extensive
documentation in HTML format.

Next: Preprocessors,  Prev: Macro Packages,  Up: Top

5 'gtroff' Reference
********************

This chapter covers *all* of the facilities of 'gtroff'.  Users of macro
packages may skip it if not interested in details.

* Menu:

* Text::
* Measurements::
* Expressions::
* Identifiers::
* Embedded Commands::
* Registers::
* Manipulating Filling and Adjusting::
* Manipulating Hyphenation::
* Manipulating Spacing::
* Tabs and Fields::
* Character Translations::
* Troff and Nroff Mode::
* Line Layout::
* Line Control::
* Page Layout::
* Page Control::
* Fonts and Symbols::
* Sizes::
* Strings::
* Conditionals and Loops::
* Writing Macros::
* Page Motions::
* Drawing Requests::
* Traps::
* Diversions::
* Environments::
* Suppressing output::
* Colors::
* I/O::
* Postprocessor Access::
* Miscellaneous::
* Gtroff Internals::
* Debugging::
* Implementation Differences::

Next: Measurements,  Prev: gtroff Reference,  Up: gtroff Reference

5.1 Text
========

'gtroff' input files contain text with control commands interspersed
throughout.  But, even without control codes, 'gtroff' still does
several things with the input text:

   * filling and adjusting

   * adding additional space after sentences

   * hyphenating

   * inserting implicit line breaks

* Menu:

* Filling and Adjusting::
* Hyphenation::
* Sentences::
* Tab Stops::
* Implicit Line Breaks::
* Input Conventions::
* Input Encodings::

Next: Hyphenation,  Prev: Text,  Up: Text

5.1.1 Filling and Adjusting
---------------------------

When 'gtroff' reads text, it collects words from the input and fits as
many of them together on one output line as it can.  This is known as
"filling".

   Once 'gtroff' has a "filled" line, it tries to "adjust" it.  This
means it widens the spacing between words until the text reaches the
right margin (in the default adjustment mode).  Extra spaces between
words are preserved, but spaces at the end of lines are ignored.  Spaces
at the front of a line cause a "break" (breaks are explained in *note
Implicit Line Breaks::).

   *Note Manipulating Filling and Adjusting::.

Next: Sentences,  Prev: Filling and Adjusting,  Up: Text

5.1.2 Hyphenation
-----------------

Since the odds are not great for finding a set of words, for every
output line, which fit nicely on a line without inserting excessive
amounts of space between words, 'gtroff' hyphenates words so that it can
justify lines without inserting too much space between words.  It uses
an internal hyphenation algorithm (a simplified version of the algorithm
used within TeX) to indicate which words can be hyphenated and how to do
so.  When a word is hyphenated, the first part of the word is added to
the current filled line being output (with an attached hyphen), and the
other portion is added to the next line to be filled.

   *Note Manipulating Hyphenation::.

Next: Tab Stops,  Prev: Hyphenation,  Up: Text

5.1.3 Sentences
---------------

Although it is often debated, some typesetting rules say there should be
different amounts of space after various punctuation marks.  For
example, the 'Chicago typsetting manual' says that a period at the end
of a sentence should have twice as much space following it as would a
comma or a period as part of an abbreviation.

   'gtroff' does this by flagging certain characters (normally '!', '?',
and '.') as "end-of-sentence" characters.  When 'gtroff' encounters one
of these characters at the end of a line, it appends a normal space
followed by a "sentence space" in the formatted output.  (This justifies
one of the conventions mentioned in *note Input Conventions::.)

   In addition, the following characters and symbols are treated
transparently while handling end-of-sentence characters: '"', ''', ')',
']', '*', '\[dg]', '\[rq]', and '\[cq]'.

   See the 'cflags' request in *note Using Symbols::, for more details.

   To prevent the insertion of extra space after an end-of-sentence
character (at the end of a line), append '\&'.

Next: Implicit Line Breaks,  Prev: Sentences,  Up: Text

5.1.4 Tab Stops
---------------

'gtroff' translates "tabulator characters", also called "tabs" (normally
code point ASCII '0x09' or EBCDIC '0x05'), in the input into movements
to the next tabulator stop.  These tab stops are initially located every
half inch across the page.  Using this, simple tables can be made
easily.  However, it can often be deceptive as the appearance (and
width) of the text on a terminal and the results from 'gtroff' can vary
greatly.

   Also, a possible sticking point is that lines beginning with tab
characters are still filled, again producing unexpected results.  For
example, the following input

           1          2          3
                      4          5

produces

           1          2          3                     4          5

   *Note Tabs and Fields::.

Next: Input Conventions,  Prev: Tab Stops,  Up: Text

5.1.5 Implicit Line Breaks
--------------------------

An important concept in 'gtroff' is the "break".  When a break occurs,
'gtroff' outputs the partially filled line (unjustified), and resumes
collecting and filling text on the next output line.

   There are several ways to cause a break in 'gtroff'.  A blank line
not only causes a break, but it also outputs a one-line vertical space
(effectively a blank line).  Note that this behaviour can be modified
with the blank line macro request 'blm'.  *Note Blank Line Traps::.

   A line that begins with a space causes a break and the space is
output at the beginning of the next line.  Note that this space isn't
adjusted, even in fill mode; however, the behaviour can be modified with
the leading spaces macro request 'lsm'.  *Note Leading Spaces Traps::.

   The end of file also causes a break - otherwise the last line of the
document may vanish!

   Certain requests also cause breaks, implicitly or explicitly.  This
is discussed in *note Manipulating Filling and Adjusting::.

Next: Input Encodings,  Prev: Implicit Line Breaks,  Up: Text

5.1.6 Input Conventions
-----------------------

Since 'gtroff' does filling automatically, it is traditional in 'groff'
not to try and type things in as nicely formatted paragraphs.  These are
some conventions commonly used when typing 'gtroff' text:

   * Break lines after punctuation, particularly at the end of a
     sentence and in other logical places.  Keep separate phrases on
     lines by themselves, as entire phrases are often added or deleted
     when editing.

   * Try to keep lines less than 40-60 characters, to allow space for
     inserting more text.

   * Do not try to do any formatting in a WYSIWYG manner (i.e., don't
     try using spaces to get proper indentation).

Prev: Input Conventions,  Up: Text

5.1.7 Input Encodings
---------------------

Currently, the following input encodings are available.

cp1047
     This input encoding works only on EBCDIC platforms (and vice versa,
     the other input encodings don't work with EBCDIC); the file
     'cp1047.tmac' is by default loaded at start-up.

latin-1
     This is the default input encoding on non-EBCDIC platforms; the
     file 'latin1.tmac' is loaded at start-up.

latin-2
     To use this encoding, either say '.mso latin2.tmac' at the very
     beginning of your document or use '-mlatin2' as a command line
     argument for 'groff'.

latin-5
     For Turkish.  Either say '.mso latin9.tmac' at the very beginning
     of your document or use '-mlatin9' as a command line argument for
     'groff'.

latin-9 (latin-0)
     This encoding is intended (at least in Europe) to replace latin-1
     encoding.  The main difference to latin-1 is that latin-9 contains
     the Euro character.  To use this encoding, either say
     '.mso latin9.tmac' at the very beginning of your document or use
     '-mlatin9' as a command line argument for 'groff'.

   Note that it can happen that some input encoding characters are not
available for a particular output device.  For example, saying

     groff -Tlatin1 -mlatin9 ...

fails if you use the Euro character in the input.  Usually, this
limitation is present only for devices that have a limited set of output
glyphs (e.g. '-Tascii' and '-Tlatin1'); for other devices it is usually
sufficient to install proper fonts that contain the necessary glyphs.

   Due to the importance of the Euro glyph in Europe, the groff package
now comes with a POSTSCRIPT font called 'freeeuro.pfa', which provides
various glyph shapes for the Euro.  In other words, latin-9 encoding is
supported for the '-Tps' device out of the box (latin-2 isn't).

   By its very nature, '-Tutf8' supports all input encodings; '-Tdvi'
has support for both latin-2 and latin-9 if the command line '-mec' is
used also to load the file 'ec.tmac' (which flips to the EC fonts).

Next: Expressions,  Prev: Text,  Up: gtroff Reference

5.2 Measurements
================

'gtroff' (like many other programs) requires numeric parameters to
specify various measurements.  Most numeric parameters(1) (*note
Measurements-Footnote-1::) may have a "measurement unit" attached.
These units are specified as a single character that immediately follows
the number or expression.  Each of these units are understood, by
'gtroff', to be a multiple of its "basic unit".  So, whenever a
different measurement unit is specified 'gtroff' converts this into its
"basic units".  This basic unit, represented by a 'u', is a device
dependent measurement, which is quite small, ranging from 1/75th to
1/72000th of an inch.  The values may be given as fractional numbers;
however, fractional basic units are always rounded to integers.

   Some of the measurement units are completely independent of any of
the current settings (e.g. type size) of 'gtroff'.

'i'
     Inches.  An antiquated measurement unit still in use in certain
     backwards countries with incredibly low-cost computer equipment.
     One inch is equal to 2.54cm.

'c'
     Centimeters.  One centimeter is equal to 0.3937in.

'p'
     Points.  This is a typesetter's measurement used for measure type
     size.  It is 72 points to an inch.

'P'
     Pica.  Another typesetting measurement.  6 Picas to an inch (and
     12 points to a pica).

's'
'z'
     *Note Fractional Type Sizes::, for a discussion of these units.

'f'
     Fractions.  Value is 65536.  *Note Colors::, for usage.

   The other measurements understood by 'gtroff' depend on settings
currently in effect in 'gtroff'.  These are very useful for specifying
measurements that should look proper with any size of text.

'm'
     Ems.  This unit is equal to the current font size in points.  So
     called because it is _approximately_ the width of the letter 'm' in
     the current font.

'n'
     Ens.  In 'groff', this is half of an em.

'v'
     Vertical space.  This is equivalent to the current line spacing.
     *Note Sizes::, for more information about this.

'M'
     100ths of an em.

* Menu:

* Default Units::

Prev: Measurements,  Up: Measurements

5.2.1 Default Units
-------------------

Many requests take a default unit.  While this can be helpful at times,
it can cause strange errors in some expressions.  For example, the line
length request expects em units.  Here are several attempts to get a
line length of 3.5 inches and their results:

     3.5i      =>   3.5i
     7/2       =>   0i
     7/2i      =>   0i
     (7 / 2)u  =>   0i
     7i/2      =>   0.1i
     7i/2u     =>   3.5i

Everything is converted to basic units first.  In the above example it
is assumed that 1i equals 240u, and 1m equals 10p (thus 1m equals 33u).
The value 7i/2 is first handled as 7i/2m, then converted to 1680u/66u,
which is 25u, and this is approximately 0.1i.  As can be seen, a scaling
indicator after a closing parenthesis is simply ignored.

   Thus, the safest way to specify measurements is to always attach a
scaling indicator.  If you want to multiply or divide by a certain
scalar value, use 'u' as the unit for that value.

Next: Identifiers,  Prev: Measurements,  Up: gtroff Reference

5.3 Expressions
===============

'gtroff' has most arithmetic operators common to other languages:

   * Arithmetic: '+' (addition), '-' (subtraction), '/' (division), '*'
     (multiplication), '%' (modulo).

     'gtroff' only provides integer arithmetic.  The internal type used
     for computing results is 'int', which is usually a 32bit signed
     integer.

   * Comparison: '<' (less than), '>' (greater than), '<=' (less than or
     equal), '>=' (greater than or equal), '=' (equal), '==' (the same
     as '=').

   * Logical: '&' (logical and), ':' (logical or).

   * Unary operators: '-' (negating, i.e. changing the sign), '+' (just
     for completeness; does nothing in expressions), '!' (logical not;
     this works only within 'if' and 'while' requests).(1)  (*note
     Expressions-Footnote-1::) See below for the use of unary operators
     in motion requests.

     The logical not operator, as described above, works only within
     'if' and 'while' requests.  Furthermore, it may appear only at the
     beginning of an expression, and negates the entire expression.
     Attempting to insert the '!' operator within the expression results
     in a 'numeric expression expected' warning.  This maintains
     compatibility with old versions of 'troff'.

     Example:

          .nr X 1
          .nr Y 0
          .\" This does not work as expected
          .if (\n[X])&(!\n[Y]) .nop X only
          .
          .\" Use this construct instead
          .if (\n[X]=1)&(\n[Y]=0) .nop X only

   * Extrema: '>?' (maximum), '<?' (minimum).

     Example:

          .nr x 5
          .nr y 3
          .nr z (\n[x] >? \n[y])

     The register 'z' now contains 5.

   * Scaling: '(C;E)'.  Evaluate E using C as the default scaling
     indicator.  If C is missing, ignore scaling indicators in the
     evaluation of E.

   Parentheses may be used as in any other language.  However, in
'gtroff' they are necessary to ensure order of evaluation.  'gtroff' has
no operator precedence; expressions are evaluated left to right.  This
means that 'gtroff' evaluates '3+5*4' as if it were parenthesized like
'(3+5)*4', not as '3+(5*4)', as might be expected.

   For many requests that cause a motion on the page, the unary
operators '+' and '-' work differently if leading an expression.  They
then indicate a motion relative to the current position (down or up,
respectively).

   Similarly, a leading '|' operator indicates an absolute position.
For vertical movements, it specifies the distance from the top of the
page; for horizontal movements, it gives the distance from the beginning
of the _input_ line.

   '+' and '-' are also treated differently by the following requests
and escapes: 'bp', 'in', 'll', 'lt', 'nm', 'nr', 'pl', 'pn', 'po', 'ps',
'pvs', 'rt', 'ti', '\H', '\R', and '\s'.  Here, leading plus and minus
signs indicate increments and decrements.

   *Note Setting Registers::, for some examples.

 -- Escape: \B'anything'
     Return 1 if ANYTHING is a valid numeric expression; or 0 if
     ANYTHING is empty or not a valid numeric expression.

   Due to the way arguments are parsed, spaces are not allowed in
expressions, unless the entire expression is surrounded by parentheses.

   *Note Request and Macro Arguments::, and *note Conditionals and
Loops::.

Next: Embedded Commands,  Prev: Expressions,  Up: gtroff Reference

5.4 Identifiers
===============

Like any other language, 'gtroff' has rules for properly formed
"identifiers".  In 'gtroff', an identifier can be made up of almost any
printable character, with the exception of the following characters:

   * Whitespace characters (spaces, tabs, and newlines).

   * Backspace (ASCII '0x08' or EBCDIC '0x16') and character code
     '0x01'.

   * The following input characters are invalid and are ignored if
     'groff' runs on a machine based on ASCII, causing a warning message
     of type 'input' (see *note Debugging::, for more details): '0x00',
     '0x0B', '0x0D'-'0x1F', '0x80'-'0x9F'.

     And here are the invalid input characters if 'groff' runs on an
     EBCDIC host: '0x00', '0x08', '0x09', '0x0B', '0x0D'-'0x14',
     '0x17'-'0x1F', '0x30'-'0x3F'.

     Currently, some of these reserved codepoints are used internally,
     thus making it non-trivial to extend 'gtroff' to cover Unicode or
     other character sets and encodings that use characters of these
     ranges.

     Note that invalid characters are removed before parsing; an
     identifier 'foo', followed by an invalid character, followed by
     'bar' is treated as 'foobar'.

   For example, any of the following is valid.

     br
     PP
     (l
     end-list
     @_

Note that identifiers longer than two characters with a closing bracket
(']') in its name can't be accessed with escape sequences that expect an
identifier as a parameter.  For example, '\[foo]]' accesses the glyph
'foo', followed by ']', whereas '\C'foo]'' really asks for glyph 'foo]'.

   To avoid problems with the 'refer' preprocessor, macro names should
not start with '[' or ']'.  Due to backwards compatibility, everything
after '.[' and '.]' is handled as a special argument to 'refer'.  For
example, '.[foo' makes 'refer' to start a reference, using 'foo' as a
parameter.

 -- Escape: \A'ident'
     Test whether an identifier IDENT is valid in 'gtroff'.  It expands
     to the character 1 or 0 according to whether its argument (usually
     delimited by quotes) is or is not acceptable as the name of a
     string, macro, diversion, number register, environment, or font.
     It returns 0 if no argument is given.  This is useful for looking
     up user input in some sort of associative table.

          \A'end-list'
              => 1

   *Note Escapes::, for details on parameter delimiting characters.

   Identifiers in 'gtroff' can be any length, but, in some contexts,
'gtroff' needs to be told where identifiers end and text begins (and in
different ways depending on their length):

   * Single character.

   * Two characters.  Must be prefixed with '(' in some situations.

   * Arbitrary length ('gtroff' only).  Must be bracketed with '['
     and ']' in some situations.  Any length identifier can be put in
     brackets.

   Unlike many other programming languages, undefined identifiers are
silently ignored or expanded to nothing.  When 'gtroff' finds an
undefined identifier, it emits a warning, doing the following:

   * If the identifier is a string, macro, or diversion, 'gtroff'
     defines it as empty.

   * If the identifier is a number register, 'gtroff' defines it with a
     value of 0.

   *Note Warnings::., *note Interpolating Registers::, and *note
Strings::.

   Note that macros, strings, and diversions share the same name space.

     .de xxx
     .  nop foo
     ..
     .
     .di xxx
     bar
     .br
     .di
     .
     .xxx
         => bar

As can be seen in the previous example, 'gtroff' reuses the identifier
'xxx', changing it from a macro to a diversion.  No warning is emitted!
The contents of the first macro definition is lost.

   *Note Interpolating Registers::, and *note Strings::.

Next: Registers,  Prev: Identifiers,  Up: gtroff Reference

5.5 Embedded Commands
=====================

Most documents need more functionality beyond filling, adjusting and
implicit line breaking.  In order to gain further functionality,
'gtroff' allows commands to be embedded into the text, in two ways.

   The first is a "request" that takes up an entire line, and does some
large-scale operation (e.g. break lines, start new pages).

   The other is an "escape" that can be usually embedded anywhere in the
text; most requests can accept it even as an argument.  Escapes
generally do more minor operations like sub- and superscripts, print a
symbol, etc.

* Menu:

* Requests::
* Macros::
* Escapes::

Next: Macros,  Prev: Embedded Commands,  Up: Embedded Commands

5.5.1 Requests
--------------

A request line begins with a control character, which is either a single
quote (''', the "no-break control character") or a period ('.', the
normal "control character").  These can be changed; see *note Character
Translations::, for details.  After this there may be optional tabs or
spaces followed by an identifier, which is the name of the request.
This may be followed by any number of space-separated arguments (_no_
tabs here).

   Since a control character followed by whitespace only is ignored, it
is common practice to use this feature for structuring the source code
of documents or macro packages.

     .de foo
     .  tm This is foo.
     ..
     .
     .
     .de bar
     .  tm This is bar.
     ..

   Another possibility is to use the blank line macro request 'blm' by
assigning an empty macro to it.

     .de do-nothing
     ..
     .blm do-nothing  \" activate blank line macro

     .de foo
     .  tm This is foo.
     ..


     .de bar
     .  tm This is bar.
     ..

     .blm             \" deactivate blank line macro

   *Note Blank Line Traps::.

   To begin a line with a control character without it being
interpreted, precede it with '\&'.  This represents a zero width space,
which means it does not affect the output.

   In most cases the period is used as a control character.  Several
requests cause a break implicitly; using the single quote control
character prevents this.

 -- Register: \n[.br]
     A read-only number register, which is set to 1 if a macro is called
     with the normal control character (as defined with the 'cc'
     request), and set to 0 otherwise.

     This allows to reliably modify requests.

          .als bp*orig bp
          .de bp
          .  tm before bp
          .  ie \\n[.br] .bp*orig
          .  el 'bp*orig
          .  tm after bp
          ..

     Using this register outside of a macro makes no sense (it always
     returns zero in such cases).

     If a macro is called as a string (this is, using '\*'), the value
     of the '.br' register is inherited from the calling macro.

* Menu:

* Request and Macro Arguments::

Prev: Requests,  Up: Requests

5.5.1.1 Request and Macro Arguments
...................................

Arguments to requests and macros are processed much like the shell: The
line is split into arguments according to spaces.(1)  (*note Request and
Macro Arguments-Footnote-1::)

   An argument to a macro that is intended to contain spaces can either
be enclosed in double quotes, or have the spaces "escaped" with
backslashes.  This is _not_ true for requests.

   Here are a few examples for a hypothetical macro 'uh':

     .uh The Mouse Problem
     .uh "The Mouse Problem"
     .uh The\ Mouse\ Problem

The first line is the 'uh' macro being called with 3 arguments, 'The',
'Mouse', and 'Problem'.  The latter two have the same effect of calling
the 'uh' macro with one argument, 'The Mouse Problem'.(2)  (*note
Request and Macro Arguments-Footnote-2::)

   A double quote that isn't preceded by a space doesn't start a macro
argument.  If not closing a string, it is printed literally.

   For example,

     .xxx a" "b c" "de"fg"

has the arguments 'a"', 'b c', 'de', and 'fg"'.  Don't rely on this
obscure behaviour!

   There are two possibilities to get a double quote reliably.

   * Enclose the whole argument with double quotes and use two
     consecutive double quotes to represent a single one.  This
     traditional solution has the disadvantage that double quotes don't
     survive argument expansion again if called in compatibility mode
     (using the '-C' option of 'groff'):

          .de xx
          .  tm xx: `\\$1' `\\$2' `\\$3'
          .
          .  yy "\\$1" "\\$2" "\\$3"
          ..
          .de yy
          .  tm yy: `\\$1' `\\$2' `\\$3'
          ..
          .xx A "test with ""quotes""" .
              => xx: `A' `test with "quotes"' `.'
              => yy: `A' `test with ' `quotes""'

     If not in compatibility mode, you get the expected result

          xx: `A' `test with "quotes"' `.'
          yy: `A' `test with "quotes"' `.'

     since 'gtroff' preserves the input level.

   * Use the double quote glyph '\(dq'.  This works with and without
     compatibility mode enabled since 'gtroff' doesn't convert '\(dq'
     back to a double quote input character.

     Note that this method won't work with UNIX 'troff' in general since
     the glyph 'dq' isn't defined normally.

   Double quotes in the 'ds' request are handled differently.  *Note
Strings::, for more details.

Next: Escapes,  Prev: Requests,  Up: Embedded Commands

5.5.2 Macros
------------

'gtroff' has a "macro" facility for defining a series of lines that can
be invoked by name.  They are called in the same manner as requests -
arguments also may be passed basically in the same manner.

   *Note Writing Macros::, and *note Request and Macro Arguments::.

Prev: Macros,  Up: Embedded Commands

5.5.3 Escapes
-------------

Escapes may occur anywhere in the input to 'gtroff'.  They usually begin
with a backslash and are followed by a single character, which indicates
the function to be performed.  The escape character can be changed; see
*note Character Translations::.

   Escape sequences that require an identifier as a parameter accept
three possible syntax forms.

   * The next single character is the identifier.

   * If this single character is an opening parenthesis, take the
     following two characters as the identifier.  Note that there is no
     closing parenthesis after the identifier.

   * If this single character is an opening bracket, take all characters
     until a closing bracket as the identifier.

Examples:

     \fB
     \n(XX
     \*[TeX]

   Other escapes may require several arguments and/or some special
format.  In such cases the argument is traditionally enclosed in single
quotes (and quotes are always used in this manual for the definitions of
escape sequences).  The enclosed text is then processed according to
what that escape expects.  Example:

     \l'1.5i\(bu'

   Note that the quote character can be replaced with any other
character that does not occur in the argument (even a newline or a space
character) in the following escapes: '\o', '\b', and '\X'.  This makes
e.g.

     A caf
     \o
     e\'


     in Paris
       => A café in Paris

possible, but it is better not to use this feature to avoid confusion.

   The following escapes sequences (which are handled similarly to
characters since they don't take a parameter) are also allowed as
delimiters: '\%', '\ ', '\|', '\^', '\{', '\}', '\'', '\`', '\-', '\_',
'\!', '\?', '\)', '\/', '\,', '\&', '\:', '\~', '\0', '\a', '\c', '\d',
'\e', '\E', '\p', '\r', '\t', and '\u'.  Again, don't use these if
possible.

   No newline characters as delimiters are allowed in the following
escapes: '\A', '\B', '\Z', '\C', and '\w'.

   Finally, the escapes '\D', '\h', '\H', '\l', '\L', '\N', '\R', '\s',
'\S', '\v', and '\x' can't use the following characters as delimiters:

   * The digits '0'-'9'.

   * The (single-character) operators '+-/*%<>=&:().'.

   * The space, tab, and newline characters.

   * All escape sequences except '\%', '\:', '\{', '\}', '\'', '\`',
     '\-', '\_', '\!', '\/', '\c', '\e', and '\p'.

   To have a backslash (actually, the current escape character) appear
in the output several escapes are defined: '\\', '\e' or '\E'.  These
are very similar, and only differ with respect to being used in macros
or diversions.  *Note Character Translations::, for an exact description
of those escapes.

   *Note Implementation Differences::, *note Copy-in Mode::, and *note
Diversions::, *note Identifiers::, for more information.

* Menu:

* Comments::

Prev: Escapes,  Up: Escapes

5.5.3.1 Comments
................

Probably one of the most(1) (*note Comments-Footnote-1::) common forms
of escapes is the comment.

 -- Escape: \"
     Start a comment.  Everything to the end of the input line is
     ignored.

     This may sound simple, but it can be tricky to keep the comments
     from interfering with the appearance of the final output.

     If the escape is to the right of some text or a request, that
     portion of the line is ignored, but the space leading up to it is
     noticed by 'gtroff'.  This only affects the 'ds' and 'as' request
     and its variants.

     One possibly irritating idiosyncracy is that tabs must not be used
     to line up comments.  Tabs are not treated as whitespace between
     the request and macro arguments.

     A comment on a line by itself is treated as a blank line, because
     after eliminating the comment, that is all that remains:

          Test
          \" comment
          Test

     produces

          Test

          Test

     To avoid this, it is common to start the line with '.\"', which
     causes the line to be treated as an undefined request and thus
     ignored completely.

     Another commenting scheme seen sometimes is three consecutive
     single quotes (''''') at the beginning of a line.  This works, but
     'gtroff' gives a warning about an undefined macro (namely ''''),
     which is harmless, but irritating.

 -- Escape: \#
     To avoid all this, 'gtroff' has a new comment mechanism using the
     '\#' escape.  This escape works the same as '\"' except that the
     newline is also ignored:

          Test
          \# comment
          Test

     produces

          Test Test

     as expected.

 -- Request: .ig [end]
     Ignore all input until 'gtroff' encounters the macro named '.'END
     on a line by itself (or '..' if END is not specified).  This is
     useful for commenting out large blocks of text:

          text text text...
          .ig
          This is part of a large block
          of text that has been
          temporarily(?) commented out.

          We can restore it simply by removing
          the .ig request and the ".." at the
          end of the block.
          ..
          More text text text...

     produces

          text text text...  More text text text...

     Note that the commented-out block of text does not cause a break.

     The input is read in copy-mode; auto-incremented registers _are_
     affected (*note Auto-increment::).

Next: Manipulating Filling and Adjusting,  Prev: Embedded Commands,  Up: gtroff Reference

5.6 Registers
=============

Numeric variables in 'gtroff' are called "registers".  There are a
number of built-in registers, supplying anything from the date to
details of formatting parameters.

   *Note Identifiers::, for details on register identifiers.

* Menu:

* Setting Registers::
* Interpolating Registers::
* Auto-increment::
* Assigning Formats::
* Built-in Registers::

Next: Interpolating Registers,  Prev: Registers,  Up: Registers

5.6.1 Setting Registers
-----------------------

Define or set registers using the 'nr' request or the '\R' escape.

   Although the following requests and escapes can be used to create
registers, simply using an undefined register will cause it to be set to
zero.

 -- Request: .nr ident value
 -- Escape: \R'ident value'
     Set number register IDENT to VALUE.  If IDENT doesn't exist,
     'gtroff' creates it.

     The argument to '\R' usually has to be enclosed in quotes.  *Note
     Escapes::, for details on parameter delimiting characters.

     The '\R' escape doesn't produce an input token in 'gtroff'; in
     other words, it vanishes completely after 'gtroff' has processed
     it.

     For example, the following two lines are equivalent:

          .nr a (((17 + (3 * 4))) % 4)
          \R'a (((17 + (3 * 4))) % 4)'
              => 1

     Note that the complete transparency of '\R' can cause surprising
     effects if you use number registers like '.k', which get evaluated
     at the time they are accessed.

          .ll 1.6i
          .
          aaa bbb ccc ddd eee fff ggg hhh\R':k \n[.k]'
          .tm :k == \n[:k]
              => :k == 126950
          .
          .br
          .
          aaa bbb ccc ddd eee fff ggg hhh\h'0'\R':k \n[.k]'
          .tm :k == \n[:k]
              => :k == 15000

     If you process this with the POSTSCRIPT device ('-Tps'), there will
     be a line break eventually after 'ggg' in both input lines.
     However, after processing the space after 'ggg', the partially
     collected line is not overfull yet, so 'troff' continues to collect
     input until it sees the space (or in this case, the newline) after
     'hhh'.  At this point, the line is longer than the line length, and
     the line gets broken.

     In the first input line, since the '\R' escape leaves no traces,
     the check for the overfull line hasn't been done yet at the point
     where '\R' gets handled, and you get a value for the '.k' number
     register that is even greater than the current line length.

     In the second input line, the insertion of '\h'0'' to emit an
     invisible zero-width space forces 'troff' to check the line length,
     which in turn causes the start of a new output line.  Now '.k'
     returns the expected value.

   Both 'nr' and '\R' have two additional special forms to increment or
decrement a register.

 -- Request: .nr ident +value
 -- Request: .nr ident -value
 -- Escape: \R'ident +value'
 -- Escape: \R'ident -value'
     Increment (decrement) register IDENT by VALUE.

          .nr a 1
          .nr a +1
          \na
              => 2

     To assign the negated value of a register to another register, some
     care must be taken to get the desired result:

          .nr a 7
          .nr b 3
          .nr a -\nb
          \na
              => 4
          .nr a (-\nb)
          \na
              => -3

     The surrounding parentheses prevent the interpretation of the minus
     sign as a decrementing operator.  An alternative is to start the
     assignment with a '0':

          .nr a 7
          .nr b -3
          .nr a \nb
          \na
              => 4
          .nr a 0\nb
          \na
              => -3

 -- Request: .rr ident
     Remove number register IDENT.  If IDENT doesn't exist, the request
     is ignored.

 -- Request: .rnn ident1 ident2
     Rename number register IDENT1 to IDENT2.  If either IDENT1 or
     IDENT2 doesn't exist, the request is ignored.

 -- Request: .aln ident1 ident2
     Create an alias IDENT1 for a number register IDENT2.  The new name
     and the old name are exactly equivalent.  If IDENT1 is undefined, a
     warning of type 'reg' is generated, and the request is ignored.
     *Note Debugging::, for information about warnings.

Next: Auto-increment,  Prev: Setting Registers,  Up: Registers

5.6.2 Interpolating Registers
-----------------------------

Numeric registers can be accessed via the '\n' escape.

 -- Escape: \ni
 -- Escape: \n(id
 -- Escape: \n[ident]
     Interpolate number register with name IDENT (one-character name I,
     two-character name ID).  This means that the value of the register
     is expanded in-place while 'gtroff' is parsing the input line.
     Nested assignments (also called indirect assignments) are possible.

          .nr a 5
          .nr as \na+\na
          \n(as
              => 10

          .nr a1 5
          .nr ab 6
          .ds str b
          .ds num 1
          \n[a\n[num]]
              => 5
          \n[a\*[str]]
              => 6

Next: Assigning Formats,  Prev: Interpolating Registers,  Up: Registers

5.6.3 Auto-increment
--------------------

Number registers can also be auto-incremented and auto-decremented.  The
increment or decrement value can be specified with a third argument to
the 'nr' request or '\R' escape.

 -- Request: .nr ident value incr
     Set number register IDENT to VALUE; the increment for
     auto-incrementing is set to INCR.  Note that the '\R' escape
     doesn't support this notation.

   To activate auto-incrementing, the escape '\n' has a special syntax
form.

 -- Escape: \n+i
 -- Escape: \n-i
 -- Escape: \n(+id
 -- Escape: \n(-id
 -- Escape: \n+(id
 -- Escape: \n-(id
 -- Escape: \n[+ident]
 -- Escape: \n[-ident]
 -- Escape: \n+[ident]
 -- Escape: \n-[ident]
     Before interpolating, increment or decrement IDENT (one-character
     name I, two-character name ID) by the auto-increment value as
     specified with the 'nr' request (or the '\R' escape).  If no
     auto-increment value has been specified, these syntax forms are
     identical to '\n'.

   For example,

     .nr a 0 1
     .nr xx 0 5
     .nr foo 0 -2
     \n+a, \n+a, \n+a, \n+a, \n+a
     .br
     \n-(xx, \n-(xx, \n-(xx, \n-(xx, \n-(xx
     .br
     \n+[foo], \n+[foo], \n+[foo], \n+[foo], \n+[foo]

produces

     1, 2, 3, 4, 5
     -5, -10, -15, -20, -25
     -2, -4, -6, -8, -10

   To change the increment value without changing the value of a
register (A in the example), the following can be used:

     .nr a \na 10

Next: Built-in Registers,  Prev: Auto-increment,  Up: Registers

5.6.4 Assigning Formats
-----------------------

When a register is used, it is always textually replaced (or
interpolated) with a representation of that number.  This output format
can be changed to a variety of formats (numbers, Roman numerals, etc.).
This is done using the 'af' request.

 -- Request: .af ident format
     Change the output format of a number register.  The first argument
     IDENT is the name of the number register to be changed, and the
     second argument FORMAT is the output format.  The following output
     formats are available:

     '1'
          Decimal arabic numbers.  This is the default format: 0, 1, 2,
          3, ...

     '0...0'
          Decimal numbers with as many digits as specified.  So, '00'
          would result in printing numbers as 01, 02, 03, ...

          In fact, any digit instead of zero does work; 'gtroff' only
          counts how many digits are specified.  As a consequence,
          'af''s default format '1' could be specified as '0' also (and
          exactly this is returned by the '\g' escape, see below).

     'I'
          Upper-case Roman numerals: 0, I, II, III, IV, ...

     'i'
          Lower-case Roman numerals: 0, i, ii, iii, iv, ...

     'A'
          Upper-case letters: 0, A, B, C, ..., Z, AA, AB, ...

     'a'
          Lower-case letters: 0, a, b, c, ..., z, aa, ab, ...

     Omitting the number register format causes a warning of type
     'missing'.  *Note Debugging::, for more details.  Specifying a
     nonexistent format causes an error.

     The following example produces '10, X, j, 010':

          .nr a 10
          .af a 1           \" the default format
          \na,
          .af a I
          \na,
          .af a a
          \na,
          .af a 001
          \na

     The largest number representable for the 'i' and 'I' formats is
     39999 (or -39999); UNIX 'troff' uses 'z' and 'w' to represent 10000
     and 5000 in Roman numerals, and so does 'gtroff'.  Currently, the
     correct glyphs of Roman numeral five thousand and Roman numeral ten
     thousand (Unicode code points 'U+2182' and 'U+2181', respectively)
     are not available.

     If IDENT doesn't exist, it is created.

     Changing the output format of a read-only register causes an error.
     It is necessary to first copy the register's value to a writeable
     register, then apply the 'af' request to this other register.

 -- Escape: \gi
 -- Escape: \g(id
 -- Escape: \g[ident]
     Return the current format of the specified register IDENT
     (one-character name I, two-character name ID).  For example, '\ga'
     after the previous example would produce the string '000'.  If the
     register hasn't been defined yet, nothing is returned.

Prev: Assigning Formats,  Up: Registers

5.6.5 Built-in Registers
------------------------

The following lists some built-in registers that are not described
elsewhere in this manual.  Any register that begins with a '.' is
read-only.  A complete listing of all built-in registers can be found in
*note Register Index::.

'\n[.F]'
     This string-valued register returns the current input file name.

'\n[.H]'
     Horizontal resolution in basic units.

'\n[.R]'
     The number of number registers available.  This is always 10000 in
     GNU 'troff'; it exists for backward compatibility.

'\n[.U]'
     If 'gtroff' is called with the '-U' command line option to activate
     unsafe mode, the number register '.U' is set to 1, and to zero
     otherwise.  *Note Groff Options::.

'\n[.V]'
     Vertical resolution in basic units.

'\n[seconds]'
     The number of seconds after the minute, normally in the range 0
     to 59, but can be up to 61 to allow for leap seconds.  Initialized
     at start-up of 'gtroff'.

'\n[minutes]'
     The number of minutes after the hour, in the range 0 to 59.
     Initialized at start-up of 'gtroff'.

'\n[hours]'
     The number of hours past midnight, in the range 0 to 23.
     Initialized at start-up of 'gtroff'.

'\n[dw]'
     Day of the week (1-7).

'\n[dy]'
     Day of the month (1-31).

'\n[mo]'
     Current month (1-12).

'\n[year]'
     The current year.

'\n[yr]'
     The current year minus 1900.  Unfortunately, the documentation of
     UNIX Version 7's 'troff' had a year 2000 bug: It incorrectly
     claimed that 'yr' contains the last two digits of the year.  That
     claim has never been true of either AT&T 'troff' or GNU 'troff'.
     Old 'troff' input that looks like this:

          '\" The following line stopped working after 1999
          This document was formatted in 19\n(yr.

     can be corrected as follows:

          This document was formatted in \n[year].

     or, to be portable to older 'troff' versions, as follows:

          .nr y4 1900+\n(yr
          This document was formatted in \n(y4.

'\n[.c]'
'\n[c.]'
     The current _input_ line number.  Register '.c' is read-only,
     whereas 'c.' (a 'gtroff' extension) is writable also, affecting
     both '.c' and 'c.'.

'\n[ln]'
     The current _output_ line number after a call to the 'nm' request
     to activate line numbering.

     *Note Miscellaneous::, for more information about line numbering.

'\n[.x]'
     The major version number.  For example, if the version number is
     1.03 then '.x' contains '1'.

'\n[.y]'
     The minor version number.  For example, if the version number is
     1.03 then '.y' contains '03'.

'\n[.Y]'
     The revision number of 'groff'.

'\n[$$]'
     The process ID of 'gtroff'.

'\n[.g]'
     Always 1.  Macros should use this to determine whether they are
     running under GNU 'troff'.

'\n[.A]'
     If the command line option '-a' is used to produce an ASCII
     approximation of the output, this is set to 1, zero otherwise.
     *Note Groff Options::.

'\n[.O]'
     This read-only register is set to the suppression nesting level
     (see escapes '\O').  *Note Suppressing output::.

'\n[.P]'
     This register is set to 1 (and to 0 otherwise) if the current page
     is actually being printed, i.e., if the '-o' option is being used
     to only print selected pages.  *Note Groff Options::, for more
     information.

'\n[.T]'
     If 'gtroff' is called with the '-T' command line option, the number
     register '.T' is set to 1, and zero otherwise.  *Note Groff
     Options::.

'\*[.T]'
     A single read-write string register that contains the current
     output device (for example, 'latin1' or 'ps').  This is the only
     string register defined by 'gtroff'.

Next: Manipulating Hyphenation,  Prev: Registers,  Up: gtroff Reference

5.7 Manipulating Filling and Adjusting
======================================

Various ways of causing "breaks" were given in *note Implicit Line
Breaks::.  The 'br' request likewise causes a break.  Several other
requests also cause breaks, but implicitly.  These are 'bp', 'ce', 'cf',
'fi', 'fl', 'in', 'nf', 'rj', 'sp', 'ti', and 'trf'.

 -- Request: .br
     Break the current line, i.e., the input collected so far is emitted
     without adjustment.

     If the no-break control character is used, 'gtroff' suppresses the
     break:

          a
          'br
          b
              => a b

   Initially, 'gtroff' fills and adjusts text to both margins.  Filling
can be disabled via the 'nf' request and re-enabled with the 'fi'
request.

 -- Request: .fi
 -- Register: \n[.u]
     Activate fill mode (which is the default).  This request implicitly
     enables adjusting; it also inserts a break in the text currently
     being filled.  The read-only number register '.u' is set to 1.

     The fill mode status is associated with the current environment
     (*note Environments::).

     See *note Line Control::, for interaction with the '\c' escape.

 -- Request: .nf
     Activate no-fill mode.  Input lines are output as-is, retaining
     line breaks and ignoring the current line length.  This command
     implicitly disables adjusting; it also causes a break.  The number
     register '.u' is set to 0.

     The fill mode status is associated with the current environment
     (*note Environments::).

     See *note Line Control::, for interaction with the '\c' escape.

 -- Request: .ad [mode]
 -- Register: \n[.j]
     Set adjusting mode.

     Activation and deactivation of adjusting is done implicitly with
     calls to the 'fi' or 'nf' requests.

     MODE can have one of the following values:

     'l'
          Adjust text to the left margin.  This produces what is
          traditionally called ragged-right text.

     'r'
          Adjust text to the right margin, producing ragged-left text.

     'c'
          Center filled text.  This is different to the 'ce' request,
          which only centers text without filling.

     'b'
     'n'
          Justify to both margins.  This is the default used by
          'gtroff'.

     Finally, MODE can be the numeric argument returned by the '.j'
     register.

     Using 'ad' without argument is the same as saying '.ad \[.j]'.  In
     particular, 'gtroff' adjusts lines in the same way it did before
     adjusting was deactivated (with a call to 'na', say).  For example,
     this input code

          .de AD
          .  br
          .  ad \\$1
          ..
          .
          .de NA
          .  br
          .  na
          ..
          .
          textA
          .AD r
          .nr ad \n[.j]
          textB
          .AD c
          textC
          .NA
          textD
          .AD         \" back to centering
          textE
          .AD \n[ad]  \" back to right justifying
          textF

     produces the following output:

          textA
                                                              textB
                                    textC
          textD
                                    textE
                                                              textF

     As just demonstrated, the current adjustment mode is available in
     the read-only number register '.j'; it can be stored and
     subsequently used to set adjustment.

     The adjustment mode status is associated with the current
     environment (*note Environments::).

 -- Request: .na
     Disable adjusting.  This request won't change the current
     adjustment mode: A subsequent call to 'ad' uses the previous
     adjustment setting.

     The adjustment mode status is associated with the current
     environment (*note Environments::).

 -- Request: .brp
 -- Escape: \p
     Adjust the current line and cause a break.

     In most cases this produces very ugly results since 'gtroff'
     doesn't have a sophisticated paragraph building algorithm (as TeX
     have, for example); instead, 'gtroff' fills and adjusts a paragraph
     line by line:

          This is an uninteresting sentence.
          This is an uninteresting sentence.\p
          This is an uninteresting sentence.

     is formatted as

          This is  an uninteresting  sentence.   This  is an
          uninteresting                            sentence.
          This is an uninteresting sentence.

 -- Request: .ss word_space_size [sentence_space_size]
 -- Register: \n[.ss]
 -- Register: \n[.sss]
     Change the size of a space between words.  It takes its units as
     one twelfth of the space width parameter for the current font.
     Initially both the WORD_SPACE_SIZE and SENTENCE_SPACE_SIZE are 12.
     In fill mode, the values specify the minimum distance.

     If two arguments are given to the 'ss' request, the second argument
     sets the sentence space size.  If the second argument is not given,
     sentence space size is set to WORD_SPACE_SIZE.  The sentence space
     size is used in two circumstances: If the end of a sentence occurs
     at the end of a line in fill mode, then both an inter-word space
     and a sentence space are added; if two spaces follow the end of a
     sentence in the middle of a line, then the second space is a
     sentence space.  If a second argument is never given to the 'ss'
     request, the behaviour of UNIX 'troff' is the same as that
     exhibited by GNU 'troff'.  In GNU 'troff', as in UNIX 'troff', a
     sentence should always be followed by either a newline or two
     spaces.

     The read-only number registers '.ss' and '.sss' hold the values of
     the parameters set by the first and second arguments of the 'ss'
     request.

     The word space and sentence space values are associated with the
     current environment (*note Environments::).

     Contrary to AT&T 'troff', this request is _not_ ignored if a TTY
     output device is used; the given values are then rounded down to a
     multiple of 12 (*note Implementation Differences::).

     The request is ignored if there is no parameter.

     Another useful application of the 'ss' request is to insert
     discardable horizontal space, i.e., space that is discarded at a
     line break.  For example, paragraph-style footnotes could be
     separated this way:

          .ll 4.5i
          1.\ This is the first footnote.\c
          .ss 48
          .nop
          .ss 12
          2.\ This is the second footnote.

     The result:

          1. This is the first footnote.        2. This
          is the second footnote.

     Note that the '\h' escape produces unbreakable space.

 -- Request: .ce [nnn]
 -- Register: \n[.ce]
     Center text.  While the '.ad c' request also centers text, it fills
     the text as well.  'ce' does not fill the text it affects.  This
     request causes a break.  The number of lines still to be centered
     is associated with the current environment (*note Environments::).

     The following example demonstrates the differences.  Here the
     input:

          .ll 4i
          .ce 1000
          This is a small text fragment that shows the differences
          between the `.ce' and the `.ad c' request.
          .ce 0

          .ad c
          This is a small text fragment that shows the differences
          between the `.ce' and the `.ad c' request.

     And here the result:

            This is a small text fragment that
                   shows the differences
          between the `.ce' and the `.ad c' request.

            This is a small text fragment that
          shows the differences between the `.ce'
                  and the `.ad c' request.

     With no arguments, 'ce' centers the next line of text.  NNN
     specifies the number of lines to be centered.  If the argument is
     zero or negative, centering is disabled.

     The basic length for centering text is the line length (as set with
     the 'll' request) minus the indentation (as set with the 'in'
     request).  Temporary indentation is ignored.

     As can be seen in the previous example, it is a common idiom to
     turn on centering for a large number of lines, and to turn off
     centering after text to be centered.  This is useful for any
     request that takes a number of lines as an argument.

     The '.ce' read-only number register contains the number of lines
     remaining to be centered, as set by the 'ce' request.

 -- Request: .rj [nnn]
 -- Register: \n[.rj]
     Justify unfilled text to the right margin.  Arguments are identical
     to the 'ce' request.  The '.rj' read-only number register is the
     number of lines to be right-justified as set by the 'rj' request.
     This request causes a break.  The number of lines still to be
     right-justified is associated with the current environment (*note
     Environments::).

Next: Manipulating Spacing,  Prev: Manipulating Filling and Adjusting,  Up: gtroff Reference

5.8 Manipulating Hyphenation
============================

Here a description of requests that influence hyphenation.

 -- Request: .hy [mode]
 -- Register: \n[.hy]
     Enable hyphenation.  The request has an optional numeric argument,
     MODE, to restrict hyphenation if necessary:

     '1'
          The default argument if MODE is omitted.  Hyphenate without
          restrictions.  This is also the start-up value of 'gtroff'.

     '2'
          Do not hyphenate the last word on a page or column.

     '4'
          Do not hyphenate the last two characters of a word.

     '8'
          Do not hyphenate the first two characters of a word.

     Values in the previous table are additive.  For example, the
     value 12 causes 'gtroff' to neither hyphenate the last two nor the
     first two characters of a word.

     The current hyphenation restrictions can be found in the read-only
     number register '.hy'.

     The hyphenation mode is associated with the current environment
     (*note Environments::).

 -- Request: .nh
     Disable hyphenation (i.e., set the hyphenation mode to zero).  Note
     that the hyphenation mode of the last call to 'hy' is not
     remembered.

     The hyphenation mode is associated with the current environment
     (*note Environments::).

 -- Request: .hlm [nnn]
 -- Register: \n[.hlm]
 -- Register: \n[.hlc]
     Set the maximum number of consecutive hyphenated lines to NNN.  If
     this number is negative, there is no maximum.  The default value
     is -1 if NNN is omitted.  This value is associated with the current
     environment (*note Environments::).  Only lines output from a given
     environment count towards the maximum associated with that
     environment.  Hyphens resulting from '\%' are counted; explicit
     hyphens are not.

     The current setting of 'hlm' is available in the '.hlm' read-only
     number register.  Also the number of immediately preceding
     consecutive hyphenated lines are available in the read-only number
     register '.hlc'.

 -- Request: .hw word1 word2 ...
     Define how WORD1, WORD2, etc. are to be hyphenated.  The words must
     be given with hyphens at the hyphenation points.  For example:

          .hw in-sa-lub-rious

     Besides the space character, any character whose hyphenation code
     value is zero can be used to separate the arguments of 'hw' (see
     the documentation for the 'hcode' request below for more
     information).  In addition, this request can be used more than
     once.

     Hyphenation exceptions specified with the 'hw' request are
     associated with the current hyphenation language; it causes an
     error if there is no current hyphenation language.

     This request is ignored if there is no parameter.

     In old versions of 'troff' there was a limited amount of space to
     store such information; fortunately, with 'gtroff', this is no
     longer a restriction.

 -- Escape: \%
 -- Escape: \:
     To tell 'gtroff' how to hyphenate words on the fly, use the '\%'
     escape, also known as the "hyphenation character".  Preceding a
     word with this character prevents it from being hyphenated; putting
     it inside a word indicates to 'gtroff' that the word may be
     hyphenated at that point.  Note that this mechanism only affects
     that one occurrence of the word; to change the hyphenation of a
     word for the entire document, use the 'hw' request.

     The '\:' escape inserts a zero-width break point (that is, the word
     breaks but without adding a hyphen).

          ... check the /var/log/\:httpd/\:access_log file ...

     Note that '\X' and '\Y' start a word, that is, the '\%' escape in
     (say) '\X'...'\%foobar' and '\Y'...'\%foobar' no longer prevents
     hyphenation but inserts a hyphenation point at the beginning of
     'foobar'; most likely this isn't what you want to do.

 -- Request: .hc [char]
     Change the hyphenation character to CHAR.  This character then
     works the same as the '\%' escape, and thus, no longer appears in
     the output.  Without an argument, 'hc' resets the hyphenation
     character to be '\%' (the default) only.

     The hyphenation character is associated with the current
     environment (*note Environments::).

 -- Request: .hpf pattern_file
 -- Request: .hpfa pattern_file
 -- Request: .hpfcode a b [c d ...]
     Read in a file of hyphenation patterns.  This file is searched for
     in the same way as 'NAME.tmac' (or 'tmac.NAME') is searched for if
     the '-mNAME' option is specified.

     It should have the same format as (simple) TeX patterns files.
     More specifically, the following scanning rules are implemented.

        * A percent sign starts a comment (up to the end of the line)
          even if preceded by a backslash.

        * No support for 'digraphs' like '\$'.

        * '^^XX' (X is 0-9 or a-f) and '^^X' (character code of X in the
          range 0-127) are recognized; other use of '^' causes an error.

        * No macro expansion.

        * 'hpf' checks for the expression '\patterns{...}' (possibly
          with whitespace before and after the braces).  Everything
          between the braces is taken as hyphenation patterns.
          Consequently, '{' and '}' are not allowed in patterns.

        * Similarly, '\hyphenation{...}' gives a list of hyphenation
          exceptions.

        * '\endinput' is recognized also.

        * For backwards compatibility, if '\patterns' is missing, the
          whole file is treated as a list of hyphenation patterns (only
          recognizing the '%' character as the start of a comment).

     If no 'hpf' request is specified (either in the document or in a
     macro package), 'gtroff' won't hyphenate at all.

     The 'hpfa' request appends a file of patterns to the current list.

     The 'hpfcode' request defines mapping values for character codes in
     hyphenation patterns.  'hpf' or 'hpfa' then apply the mapping
     (after reading the patterns) before replacing or appending them to
     the current list of patterns.  Its arguments are pairs of character
     codes - integers from 0 to 255.  The request maps character code A
     to code B, code C to code D, and so on.  You can use character
     codes that would be invalid otherwise.  By default, everything maps
     to itself except letters 'A' to 'Z', which map to 'a' to 'z'.

     The set of hyphenation patterns is associated with the current
     language set by the 'hla' request.  The 'hpf' request is usually
     invoked by the 'troffrc' or 'troffrc-end' file; by default,
     'troffrc' loads hyphenation patterns and exceptions for American
     English (in files 'hyphen.us' and 'hyphenex.us').

     A second call to 'hpf' (for the same language) replaces the
     hyphenation patterns with the new ones.

     Invoking 'hpf' causes an error if there is no current hyphenation
     language.

 -- Request: .hcode c1 code1 [c2 code2 ...]
     Set the hyphenation code of character C1 to CODE1, that of C2 to
     CODE2, etc.  A hyphenation code must be a single input character
     (not a special character) other than a digit or a space.

     To make hyphenation work, hyphenation codes must be set up.  At
     start-up, groff only assigns hyphenation codes to the letters
     'a'-'z' (mapped to themselves) and to the letters 'A'-'Z' (mapped
     to 'a'-'z'); all other hyphenation codes are set to zero.
     Normally, hyphenation patterns contain only lowercase letters,
     which should be applied regardless of case.  In other words, the
     words 'FOO' and 'Foo' should be hyphenated exactly the same way as
     the word 'foo' is hyphenated, and this is what 'hcode' is good for.
     Words that contain other letters won't be hyphenated properly if
     the corresponding hyphenation patterns actually do contain them.
     For example, the following 'hcode' requests are necessary to assign
     hyphenation codes to the letters 'ÄäÖöÜüß' (this is needed for
     German):

          .hcode ä ä  Ä ä
          .hcode ö ö  Ö ö
          .hcode ü ü  Ü ü
          .hcode ß ß

     Without those assignments, groff treats German words like
     'Kindergärten' (the plural form of 'kindergarten') as two
     substrings 'kinderg' and 'rten' because the hyphenation code of the
     umlaut a is zero by default.  There is a German hyphenation pattern
     that covers 'kinder', so groff finds the hyphenation 'kin-der'.
     The other two hyphenation points ('kin-der-gär-ten') are missed.

     This request is ignored if it has no parameter.

 -- Request: .hym [length]
 -- Register: \n[.hym]
     Set the (right) hyphenation margin to LENGTH.  If the current
     adjustment mode is not 'b' or 'n', the line is not hyphenated if it
     is shorter than LENGTH.  Without an argument, the hyphenation
     margin is reset to its default value, which is 0.  The default
     scaling indicator for this request is 'm'.  The hyphenation margin
     is associated with the current environment (*note Environments::).

     A negative argument resets the hyphenation margin to zero, emitting
     a warning of type 'range'.

     The current hyphenation margin is available in the '.hym' read-only
     number register.

 -- Request: .hys [hyphenation_space]
 -- Register: \n[.hys]
     Set the hyphenation space to HYPHENATION_SPACE.  If the current
     adjustment mode is 'b' or 'n', don't hyphenate the line if it can
     be justified by adding no more than HYPHENATION_SPACE extra space
     to each word space.  Without argument, the hyphenation space is set
     to its default value, which is 0.  The default scaling indicator
     for this request is 'm'.  The hyphenation space is associated with
     the current environment (*note Environments::).

     A negative argument resets the hyphenation space to zero, emitting
     a warning of type 'range'.

     The current hyphenation space is available in the '.hys' read-only
     number register.

 -- Request: .shc [glyph]
     Set the "soft hyphen character" to GLYPH.(1)  (*note Manipulating
     Hyphenation-Footnote-1::) If the argument is omitted, the soft
     hyphen character is set to the default glyph '\(hy' (this is the
     start-up value of 'gtroff' also).  The soft hyphen character is the
     glyph that is inserted when a word is hyphenated at a line break.
     If the soft hyphen character does not exist in the font of the
     character immediately preceding a potential break point, then the
     line is not broken at that point.  Neither definitions (specified
     with the 'char' request) nor translations (specified with the 'tr'
     request) are considered when finding the soft hyphen character.

 -- Request: .hla language
 -- Register: \n[.hla]
     Set the current hyphenation language to the string LANGUAGE.
     Hyphenation exceptions specified with the 'hw' request and
     hyphenation patterns specified with the 'hpf' and 'hpfa' requests
     are both associated with the current hyphenation language.  The
     'hla' request is usually invoked by the 'troffrc' or the
     'troffrc-end' files; 'troffrc' sets the default language to 'us'.

     The current hyphenation language is available as a string in the
     read-only number register '.hla'.

          .ds curr_language \n[.hla]
          \*[curr_language]
              => us

Next: Tabs and Fields,  Prev: Manipulating Hyphenation,  Up: gtroff Reference

5.9 Manipulating Spacing
========================

 -- Request: .sp [distance]
     Space downwards DISTANCE.  With no argument it advances 1 line.  A
     negative argument causes 'gtroff' to move up the page the specified
     distance.  If the argument is preceded by a '|' then 'gtroff' moves
     that distance from the top of the page.  This request causes a line
     break, and that adds the current line spacing to the space you have
     just specified.  The default scaling indicator is 'v'.

     For convenience you may wish to use the following macros to set the
     height of the next line at a given distance from the top or the
     bottom of the page:

          .de y-from-top-down
          .  sp |\\$1-\\n[.v]u
          ..
          .
          .de y-from-bot-up
          .  sp |\\n[.p]u-\\$1-\\n[.v]u
          ..

     A call to '.y-from-bot-up 10c' means that the bottom of the next
     line will be at 10cm from the paper edge at the bottom.

     If a vertical trap is sprung during execution of 'sp', the amount
     of vertical space after the trap is discarded.  For example, this

          .de xxx
          ..
          .
          .wh 0 xxx
          .
          .pl 5v
          foo
          .sp 2
          bar
          .sp 50
          baz

     results in

          foo


          bar

          baz

     The amount of discarded space is available in the number register
     '.trunc'.

     To protect 'sp' against vertical traps, use the 'vpt' request:

          .vpt 0
          .sp -3
          .vpt 1

 -- Request: .ls [nnn]
 -- Register: \n[.L]
     Output NNN-1 blank lines after each line of text.  With no
     argument, 'gtroff' uses the previous value before the last 'ls'
     call.

          .ls 2    \" This causes double-spaced output
          .ls 3    \" This causes triple-spaced output
          .ls      \" Again double-spaced

     The line spacing is associated with the current environment (*note
     Environments::).

     The read-only number register '.L' contains the current line
     spacing setting.

   *Note Changing Type Sizes::, for the requests 'vs' and 'pvs' as
alternatives to 'ls'.

 -- Escape: \x'spacing'
 -- Register: \n[.a]
     Sometimes, extra vertical spacing is only needed occasionally, e.g.
     to allow space for a tall construct (like an equation).  The '\x'
     escape does this.  The escape is given a numerical argument,
     usually enclosed in quotes (like '\x'3p''); the default scaling
     indicator is 'v'.  If this number is positive extra vertical space
     is inserted below the current line.  A negative number adds space
     above.  If this escape is used multiple times on the same line, the
     maximum of the values is used.

     *Note Escapes::, for details on parameter delimiting characters.

     The '.a' read-only number register contains the most recent
     (nonnegative) extra vertical line space.

     Using '\x' can be necessary in combination with the '\b' escape, as
     the following example shows.

          This is a test with the \[rs]b escape.
          .br
          This is a test with the \[rs]b escape.
          .br
          This is a test with \b'xyz'\x'-1m'\x'1m'.
          .br
          This is a test with the \[rs]b escape.
          .br
          This is a test with the \[rs]b escape.

     produces

          This is a test with the \b escape.
          This is a test with the \b escape.
                              x
          This is a test with y.
                              z
          This is a test with the \b escape.
          This is a test with the \b escape.

 -- Request: .ns
 -- Request: .rs
 -- Register: \n[.ns]
     Enable "no-space mode".  In this mode, spacing (either via 'sp' or
     via blank lines) is disabled.  The 'bp' request to advance to the
     next page is also disabled, except if it is accompanied by a page
     number (see *note Page Control::, for more information).  This mode
     ends when actual text is output or the 'rs' request is encountered,
     which ends no-space mode.  The read-only number register '.ns' is
     set to 1 as long as no-space mode is active.

     This request is useful for macros that conditionally insert
     vertical space before the text starts (for example, a paragraph
     macro could insert some space except when it is the first paragraph
     after a section header).

Next: Character Translations,  Prev: Manipulating Spacing,  Up: gtroff Reference

5.10 Tabs and Fields
====================

A tab character (ASCII char 9, EBCDIC char 5) causes a horizontal
movement to the next tab stop (much like it did on a typewriter).

 -- Escape: \t
     This escape is a non-interpreted tab character.  In copy mode
     (*note Copy-in Mode::), '\t' is the same as a real tab character.

 -- Request: .ta [n1 n2 ... nn T r1 r2 ... rn]
 -- Register: \n[.tabs]
     Change tab stop positions.  This request takes a series of tab
     specifiers as arguments (optionally divided into two groups with
     the letter 'T') that indicate where each tab stop is to be
     (overriding any previous settings).

     Tab stops can be specified absolutely, i.e., as the distance from
     the left margin.  For example, the following sets 6 tab stops every
     one inch.

          .ta 1i 2i 3i 4i 5i 6i

     Tab stops can also be specified using a leading '+', which means
     that the specified tab stop is set relative to the previous tab
     stop.  For example, the following is equivalent to the previous
     example.

          .ta 1i +1i +1i +1i +1i +1i

     'gtroff' supports an extended syntax to specify repeat values after
     the 'T' mark (these values are always taken as relative) - this is
     the usual way to specify tabs set at equal intervals.  The
     following is, yet again, the same as the previous examples.  It
     does even more since it defines an infinite number of tab stops
     separated by one inch.

          .ta T 1i

     Now we are ready to interpret the full syntax given at the
     beginning: Set tabs at positions N1, N2, ..., NN and then set tabs
     at NN+R1, NN+R2, ..., NN+RN and then at NN+RN+R1, NN+RN+R2, ...,
     NN+RN+RN, and so on.

     Example: '4c +6c T 3c 5c 2c' is equivalent to '4c 10c 13c 18c 20c
     23c 28c 30c ...'.

     The material in each tab column (i.e., the column between two tab
     stops) may be justified to the right or left or centered in the
     column.  This is specified by appending 'R', 'L', or 'C' to the tab
     specifier.  The default justification is 'L'.  Example:

          .ta 1i 2iC 3iR

     Some notes:

        * The default unit of the 'ta' request is 'm'.

        * A tab stop is converted into a non-breakable horizontal
          movement that can be neither stretched nor squeezed.  For
          example,

               .ds foo a\tb\tc
               .ta T 5i
               \*[foo]

          creates a single line, which is a bit longer than 10 inches (a
          string is used to show exactly where the tab characters are).
          Now consider the following:

               .ds bar a\tb b\tc
               .ta T 5i
               \*[bar]

          'gtroff' first converts the tab stops of the line into
          unbreakable horizontal movements, then splits the line after
          the second 'b' (assuming a sufficiently short line length).
          Usually, this isn't what the user wants.

        * Superfluous tabs (i.e., tab characters that do not correspond
          to a tab stop) are ignored except the first one, which
          delimits the characters belonging to the last tab stop for
          right-justifying or centering.  Consider the following example

               .ds Z   foo\tbar\tfoo
               .ds ZZ  foo\tbar\tfoobar
               .ds ZZZ foo\tbar\tfoo\tbar
               .ta 2i 4iR
               \*[Z]
               .br
               \*[ZZ]
               .br
               \*[ZZZ]
               .br

          which produces the following output:

               foo                 bar              foo
               foo                 bar           foobar
               foo                 bar              foobar

          The first line right-justifies the second 'foo' relative to
          the tab stop.  The second line right-justifies 'foobar'.  The
          third line finally right-justifies only 'foo' because of the
          additional tab character, which marks the end of the string
          belonging to the last defined tab stop.

        * Tab stops are associated with the current environment (*note
          Environments::).

        * Calling 'ta' without an argument removes all tab stops.

        * The start-up value of 'gtroff' is 'T 0.8i'.

     The read-only number register '.tabs' contains a string
     representation of the current tab settings suitable for use as an
     argument to the 'ta' request.

          .ds tab-string \n[.tabs]
          \*[tab-string]
              => T120u

     The 'troff' version of the Plan 9 operating system uses register
     '.S' for the same purpose.

 -- Request: .tc [fill-glyph]
     Normally 'gtroff' fills the space to the next tab stop with
     whitespace.  This can be changed with the 'tc' request.  With no
     argument 'gtroff' reverts to using whitespace, which is the
     default.  The value of this "tab repetition character" is
     associated with the current environment (*note Environments::).(1)
     (*note Tabs and Fields-Footnote-1::)

 -- Request: .linetabs n
 -- Register: \n[.linetabs]
     If N is missing or not zero, enable "line-tabs" mode, or disable it
     otherwise (the default).  In line-tabs mode, 'gtroff' computes tab
     distances relative to the (current) output line instead of the
     input line.

     For example, the following code:

          .ds x a\t\c
          .ds y b\t\c
          .ds z c
          .ta 1i 3i
          \*x
          \*y
          \*z

     in normal mode, results in the output

          a         b         c

     in line-tabs mode, the same code outputs

          a         b                   c

     Line-tabs mode is associated with the current environment.  The
     read-only register '.linetabs' is set to 1 if in line-tabs mode,
     and 0 in normal mode.

* Menu:

* Leaders::
* Fields::

Next: Fields,  Prev: Tabs and Fields,  Up: Tabs and Fields

5.10.1 Leaders
--------------

Sometimes it may may be desirable to use the 'tc' request to fill a
particular tab stop with a given glyph (for example dots in a table of
contents), but also normal tab stops on the rest of the line.  For this
'gtroff' provides an alternate tab mechanism, called "leaders", which
does just that.

   A leader character (character code 1) behaves similarly to a tab
character: It moves to the next tab stop.  The only difference is that
for this movement, the fill glyph defaults to a period character and not
to space.

 -- Escape: \a
     This escape is a non-interpreted leader character.  In copy mode
     (*note Copy-in Mode::), '\a' is the same as a real leader
     character.

 -- Request: .lc [fill-glyph]
     Declare the "leader repetition character".(1)  (*note
     Leaders-Footnote-1::) Without an argument, leaders act the same as
     tabs (i.e., using whitespace for filling).  'gtroff''s start-up
     value is a dot ('.').  The value of the leader repetition character
     is associated with the current environment (*note Environments::).

   For a table of contents, to name an example, tab stops may be defined
so that the section number is one tab stop, the title is the second with
the remaining space being filled with a line of dots, and then the page
number slightly separated from the dots.

     .ds entry 1.1\tFoo\a\t12
     .lc .
     .ta 1i 5i +.25i
     \*[entry]

This produces

     1.1  Foo..........................................  12

Prev: Leaders,  Up: Tabs and Fields

5.10.2 Fields
-------------

"Fields" are a more general way of laying out tabular data.  A field is
defined as the data between a pair of "delimiting characters".  It
contains substrings that are separated by "padding characters".  The
width of a field is the distance on the _input_ line from the position
where the field starts to the next tab stop.  A padding character
inserts stretchable space similar to TeX's '\hss' command (thus it can
even be negative) to make the sum of all substring lengths plus the
stretchable space equal to the field width.  If more than one padding
character is inserted, the available space is evenly distributed among
them.

 -- Request: .fc [delim-char [padding-char]]
     Define a delimiting and a padding character for fields.  If the
     latter is missing, the padding character defaults to a space
     character.  If there is no argument at all, the field mechanism is
     disabled (which is the default).  Note that contrary to e.g. the
     tab repetition character, delimiting and padding characters are
     _not_ associated to the current environment (*note Environments::).

     Example:

          .fc # ^
          .ta T 3i
          #foo^bar^smurf#
          .br
          #foo^^bar^smurf#

     and here the result:

          foo         bar          smurf
          foo            bar       smurf

Next: Troff and Nroff Mode,  Prev: Tabs and Fields,  Up: gtroff Reference

5.11 Character Translations
===========================

The control character ('.') and the no-break control character (''') can
be changed with the 'cc' and 'c2' requests, respectively.

 -- Request: .cc [c]
     Set the control character to C.  With no argument the default
     control character '.' is restored.  The value of the control
     character is associated with the current environment (*note
     Environments::).

 -- Request: .c2 [c]
     Set the no-break control character to C.  With no argument the
     default control character ''' is restored.  The value of the
     no-break control character is associated with the current
     environment (*note Environments::).

   *Note Requests::.

 -- Request: .eo
     Disable the escape mechanism completely.  After executing this
     request, the backslash character '\' no longer starts an escape
     sequence.

     This request can be very helpful in writing macros since it is not
     necessary then to double the escape character.  Here an example:

          .\" This is a simplified version of the
          .\" .BR request from the man macro package
          .eo
          .de BR
          .  ds result \&
          .  while (\n[.$] >= 2) \{\
          .    as result \fB\$1\fR\$2
          .    shift 2
          .  \}
          .  if \n[.$] .as result \fB\$1
          \*[result]
          .  ft R
          ..
          .ec

 -- Request: .ec [c]
     Set the escape character to C.  With no argument the default escape
     character '\' is restored.  It can be also used to re-enable the
     escape mechanism after an 'eo' request.

     Note that changing the escape character globally likely breaks
     macro packages since 'gtroff' has no mechanism to 'intern' macros,
     i.e., to convert a macro definition into an internal form that is
     independent of its representation (TeX has this mechanism).  If a
     macro is called, it is executed literally.

 -- Request: .ecs
 -- Request: .ecr
     The 'ecs' request saves the current escape character in an internal
     register.  Use this request in combination with the 'ec' request to
     temporarily change the escape character.

     The 'ecr' request restores the escape character saved with 'ecs'.
     Without a previous call to 'ecs', this request sets the escape
     character to '\'.

 -- Escape: \\
 -- Escape: \e
 -- Escape: \E
     Print the current escape character (which is the backslash
     character '\' by default).

     '\\' is a 'delayed' backslash; more precisely, it is the default
     escape character followed by a backslash, which no longer has
     special meaning due to the leading escape character.  It is _not_
     an escape sequence in the usual sense!  In any unknown escape
     sequence '\X' the escape character is ignored and X is printed.
     But if X is equal to the current escape character, no warning is
     emitted.

     As a consequence, only at top-level or in a diversion a backslash
     glyph is printed; in copy-in mode, it expands to a single
     backslash, which then combines with the following character to an
     escape sequence.

     The '\E' escape differs from '\e' by printing an escape character
     that is not interpreted in copy mode.  Use this to define strings
     with escapes that work when used in copy mode (for example, as a
     macro argument).  The following example defines strings to begin
     and end a superscript:

          .ds { \v'-.3m'\s'\En[.s]*60/100'
          .ds } \s0\v'.3m'

     Another example to demonstrate the differences between the various
     escape sequences, using a strange escape character, '-'.

          .ec -
          .de xxx
          --A'123'
          ..
          .xxx
              => -A'foo'

     The result is surprising for most users, expecting '1' since 'foo'
     is a valid identifier.  What has happened?  As mentioned above, the
     leading escape character makes the following character ordinary.
     Written with the default escape character the sequence '--' becomes
     '\-' - this is the minus sign.

     If the escape character followed by itself is a valid escape
     sequence, only '\E' yields the expected result:

          .ec -
          .de xxx
          -EA'123'
          ..
          .xxx
              => 1

 -- Escape: \.
     Similar to '\\', the sequence '\.' isn't a real escape sequence.
     As before, a warning message is suppressed if the escape character
     is followed by a dot, and the dot itself is printed.

          .de foo
          .  nop foo
          .
          .  de bar
          .    nop bar
          \\..
          .
          ..
          .foo
          .bar
              => foo bar

     The first backslash is consumed while the macro is read, and the
     second is swallowed while executing macro 'foo'.

   A "translation" is a mapping of an input character to an output
glyph.  The mapping occurs at output time, i.e., the input character
gets assigned the metric information of the mapped output character
right before input tokens are converted to nodes (*note Gtroff
Internals::, for more on this process).

 -- Request: .tr abcd...
 -- Request: .trin abcd...
     Translate character A to glyph B, character C to glyph D, etc.  If
     there is an odd number of arguments, the last one is translated to
     an unstretchable space ('\ ').

     The 'trin' request is identical to 'tr', but when you unformat a
     diversion with 'asciify' it ignores the translation.  *Note
     Diversions::, for details about the 'asciify' request.

     Some notes:

        * Special characters ('\(XX', '\[XXX]', '\C'XXX'', '\'', '\`',
          '\-', '\_'), glyphs defined with the 'char' request, and
          numbered glyphs ('\N'XXX'') can be translated also.

        * The '\e' escape can be translated also.

        * Characters can be mapped onto the '\%' and '\~' escapes (but
          '\%' and '\~' can't be mapped onto another glyph).

        * The following characters can't be translated: space (with one
          exception, see below), backspace, newline, leader (and '\a'),
          tab (and '\t').

        * Translations are not considered for finding the soft hyphen
          character set with the 'shc' request.

        * The pair 'C\&' (this is an arbitrary character C followed by
          the zero width space character) maps this character to
          nothing.

               .tr a\&
               foo bar
                   => foo br

          It is even possible to map the space character to nothing:

               .tr aa \&
               foo bar
                   => foobar

          As shown in the example, the space character can't be the
          first character/glyph pair as an argument of 'tr'.
          Additionally, it is not possible to map the space character to
          any other glyph; requests like '.tr aa x' undo '.tr aa \&'
          instead.

          If justification is active, lines are justified in spite of
          the 'empty' space character (but there is no minimal distance,
          i.e. the space character, between words).

        * After an output glyph has been constructed (this happens at
          the moment immediately before the glyph is appended to an
          output glyph list, either by direct output, in a macro,
          diversion, or string), it is no longer affected by 'tr'.

        * Translating character to glyphs where one of them or both are
          undefined is possible also; 'tr' does not check whether the
          entities in its argument do exist.

          *Note Gtroff Internals::.

        * 'troff' no longer has a hard-coded dependency on Latin-1; all
          'charXXX' entities have been removed from the font description
          files.  This has a notable consequence that shows up in
          warnings like 'can't find character with input code XXX' if
          the 'tr' request isn't handled properly.

          Consider the following translation:

               .tr éÉ

          This maps input character 'é' onto glyph 'É', which is
          identical to glyph 'char201'.  But this glyph intentionally
          doesn't exist!  Instead, '\[char201]' is treated as an input
          character entity and is by default mapped onto '\['E]', and
          'gtroff' doesn't handle translations of translations.

          The right way to write the above translation is

               .tr é\['E]

          In other words, the first argument of 'tr' should be an input
          character or entity, and the second one a glyph entity.

        * Without an argument, the 'tr' request is ignored.

 -- Request: .trnt abcd...
     'trnt' is the same as the 'tr' request except that the translations
     do not apply to text that is transparently throughput into a
     diversion with '\!'.  *Note Diversions::, for more information.

     For example,

          .tr ab
          .di x
          \!.tm a
          .di
          .x

     prints 'b' to the standard error stream; if 'trnt' is used instead
     of 'tr' it prints 'a'.

Next: Line Layout,  Prev: Character Translations,  Up: gtroff Reference

5.12 Troff and Nroff Mode
=========================

Originally, 'nroff' and 'troff' were two separate programs, the former
for TTY output, the latter for everything else.  With GNU 'troff', both
programs are merged into one executable, sending its output to a device
driver ('grotty' for TTY devices, 'grops' for POSTSCRIPT, etc.) which
interprets the intermediate output of 'gtroff'.  For UNIX 'troff' it
makes sense to talk about "Nroff mode" and "Troff mode" since the
differences are hardcoded.  For GNU 'troff', this distinction is not
appropriate because 'gtroff' simply takes the information given in the
font files for a particular device without handling requests specially
if a TTY output device is used.

   Usually, a macro package can be used with all output devices.
Nevertheless, it is sometimes necessary to make a distinction between
TTY and non-TTY devices: 'gtroff' provides two built-in conditions 'n'
and 't' for the 'if', 'ie', and 'while' requests to decide whether
'gtroff' shall behave like 'nroff' or like 'troff'.

 -- Request: .troff
     Make the 't' built-in condition true (and the 'n' built-in
     condition false) for 'if', 'ie', and 'while' conditional requests.
     This is the default if 'gtroff' (_not_ 'groff') is started with the
     '-R' switch to avoid loading of the start-up files 'troffrc' and
     'troffrc-end'.  Without '-R', 'gtroff' stays in troff mode if the
     output device is not a TTY (e.g. 'ps').

 -- Request: .nroff
     Make the 'n' built-in condition true (and the 't' built-in
     condition false) for 'if', 'ie', and 'while' conditional requests.
     This is the default if 'gtroff' uses a TTY output device; the code
     for switching to nroff mode is in the file 'tty.tmac', which is
     loaded by the start-up file 'troffrc'.

   *Note Conditionals and Loops::, for more details on built-in
conditions.

Next: Line Control,  Prev: Troff and Nroff Mode,  Up: gtroff Reference

5.13 Line Layout
================

The following drawing shows the dimensions that 'gtroff' uses for
placing a line of output onto the page.  They are labeled with the
request that manipulates each dimension.

          -->| in |<--
             |<-----------ll------------>|
        +----+----+----------------------+----+
        |    :    :                      :    |
        +----+----+----------------------+----+
     -->| po |<--
        |<--------paper width---------------->|

These dimensions are:

'po'
     "Page offset" - this is the leftmost position of text on the final
     output, defining the "left margin".

'in'
     "Indentation" - this is the distance from the left margin where
     text is printed.

'll'
     "Line length" - this is the distance from the left margin to right
     margin.

   A simple demonstration:

     .ll 3i
     This is text without indentation.
     The line length has been set to 3\~inch.
     .in +.5i
     .ll -.5i
     Now the left and right margins are both increased.
     .in
     .ll
     Calling .in and .ll without parameters restore
     the previous values.

   Result:

     This  is text without indenta-
     tion.   The  line  length  has
     been set to 3 inch.
          Now   the  left  and
          right  margins   are
          both increased.
     Calling  .in  and  .ll without
     parameters restore the  previ-
     ous values.

 -- Request: .po [offset]
 -- Request: .po +offset
 -- Request: .po -offset
 -- Register: \n[.o]
     Set horizontal page offset to OFFSET (or increment or decrement the
     current value by OFFSET).  Note that this request does not cause a
     break, so changing the page offset in the middle of text being
     filled may not yield the expected result.  The initial value is 1i.
     For TTY output devices, it is set to 0 in the startup file
     'troffrc'; the default scaling indicator is 'm' (and not 'v' as
     incorrectly documented in the original UNIX troff manual).

     The current page offset can be found in the read-only number
     register '.o'.

     If 'po' is called without an argument, the page offset is reset to
     the previous value before the last call to 'po'.

          .po 3i
          \n[.o]
              => 720
          .po -1i
          \n[.o]
              => 480
          .po
          \n[.o]
              => 720

 -- Request: .in [indent]
 -- Request: .in +indent
 -- Request: .in -indent
 -- Register: \n[.i]
     Set indentation to INDENT (or increment or decrement the current
     value by INDENT).  This request causes a break.  Initially, there
     is no indentation.

     If 'in' is called without an argument, the indentation is reset to
     the previous value before the last call to 'in'.  The default
     scaling indicator is 'm'.

     The indentation is associated with the current environment (*note
     Environments::).

     If a negative indentation value is specified (which is not
     allowed), 'gtroff' emits a warning of type 'range' and sets the
     indentation to zero.

     The effect of 'in' is delayed until a partially collected line (if
     it exists) is output.  A temporary indentation value is reset to
     zero also.

     The current indentation (as set by 'in') can be found in the
     read-only number register '.i'.

 -- Request: .ti offset
 -- Request: .ti +offset
 -- Request: .ti -offset
 -- Register: \n[.in]
     Temporarily indent the next output line by OFFSET.  If an increment
     or decrement value is specified, adjust the temporary indentation
     relative to the value set by the 'in' request.

     This request causes a break; its value is associated with the
     current environment (*note Environments::).  The default scaling
     indicator is 'm'.  A call of 'ti' without an argument is ignored.

     If the total indentation value is negative (which is not allowed),
     'gtroff' emits a warning of type 'range' and sets the temporary
     indentation to zero.  'Total indentation' is either OFFSET if
     specified as an absolute value, or the temporary plus normal
     indentation, if OFFSET is given as a relative value.

     The effect of 'ti' is delayed until a partially collected line (if
     it exists) is output.

     The read-only number register '.in' is the indentation that applies
     to the current output line.

     The difference between '.i' and '.in' is that the latter takes into
     account whether a partially collected line still uses the old
     indentation value or a temporary indentation value is active.

 -- Request: .ll [length]
 -- Request: .ll +length
 -- Request: .ll -length
 -- Register: \n[.l]
 -- Register: \n[.ll]
     Set the line length to LENGTH (or increment or decrement the
     current value by LENGTH).  Initially, the line length is set to
     6.5i.  The effect of 'll' is delayed until a partially collected
     line (if it exists) is output.  The default scaling indicator is
     'm'.

     If 'll' is called without an argument, the line length is reset to
     the previous value before the last call to 'll'.  If a negative
     line length is specified (which is not allowed), 'gtroff' emits a
     warning of type 'range' and sets the line length to zero.

     The line length is associated with the current environment (*note
     Environments::).

     The current line length (as set by 'll') can be found in the
     read-only number register '.l'.  The read-only number register
     '.ll' is the line length that applies to the current output line.

     Similar to '.i' and '.in', the difference between '.l' and '.ll' is
     that the latter takes into account whether a partially collected
     line still uses the old line length value.

Next: Page Layout,  Prev: Line Layout,  Up: gtroff Reference

5.14 Line Control
=================

It is important to understand how 'gtroff' handles input and output
lines.

   Many escapes use positioning relative to the input line.  For
example, this

     This is a \h'|1.2i'test.

     This is a
     \h'|1.2i'test.

produces

     This is a   test.

     This is a             test.

   The main usage of this feature is to define macros that act exactly
at the place where called.

     .\" A simple macro to underline a word
     .de underline
     .  nop \\$1\l'|0\[ul]'
     ..

In the above example, '|0' specifies a negative distance from the
current position (at the end of the just emitted argument '\$1') back to
the beginning of the input line.  Thus, the '\l' escape draws a line
from right to left.

   'gtroff' makes a difference between input and output line
continuation; the latter is also called "interrupting" a line.

 -- Escape: \<RET>
 -- Escape: \c
 -- Register: \n[.int]
     Continue a line.  '\<RET>' (this is a backslash at the end of a
     line immediately followed by a newline) works on the input level,
     suppressing the effects of the following newline in the input.

          This is a \
          .test
              => This is a .test

     The '|' operator is also affected.

     '\c' works on the output level.  Anything after this escape on the
     same line is ignored except '\R', which works as usual.  Anything
     before '\c' on the same line is appended to the current partial
     output line.  The next non-command line after an interrupted line
     counts as a new input line.

     The visual results depend on whether no-fill mode is active.

        * If no-fill mode is active (using the 'nf' request), the next
          input text line after '\c' is handled as a continuation of the
          same input text line.

               .nf
               This is a \c
               test.
                   => This is a test.

        * If fill mode is active (using the 'fi' request), a word
          interrupted with '\c' is continued with the text on the next
          input text line, without an intervening space.

               This is a te\c
               st.
                   => This is a test.

     Note that an intervening control line that causes a break is
     stronger than '\c', flushing out the current partial line in the
     usual way.

     The '.int' register contains a positive value if the last output
     line was interrupted with '\c'; this is associated with the current
     environment (*note Environments::).

Next: Page Control,  Prev: Line Control,  Up: gtroff Reference

5.15 Page Layout
================

'gtroff' provides some very primitive operations for controlling page
layout.

 -- Request: .pl [length]
 -- Request: .pl +length
 -- Request: .pl -length
 -- Register: \n[.p]
     Set the "page length" to LENGTH (or increment or decrement the
     current value by LENGTH).  This is the length of the physical
     output page.  The default scaling indicator is 'v'.

     The current setting can be found in the read-only number register
     '.p'.

     Note that this only specifies the size of the page, not the top and
     bottom margins.  Those are not set by 'gtroff' directly.  *Note
     Traps::, for further information on how to do this.

     Negative 'pl' values are possible also, but not very useful: No
     trap is sprung, and each line is output on a single page (thus
     suppressing all vertical spacing).

     If no argument or an invalid argument is given, 'pl' sets the page
     length to 11i.

   'gtroff' provides several operations that help in setting up top and
bottom titles (or headers and footers).

 -- Request: .tl 'left'center'right'
     Print a "title line".  It consists of three parts: a left justified
     portion, a centered portion, and a right justified portion.  The
     argument separator ''' can be replaced with any character not
     occurring in the title line.  The '%' character is replaced with
     the current page number.  This character can be changed with the
     'pc' request (see below).

     Without argument, 'tl' is ignored.

     Some notes:

        * The line length set by the 'll' request is not honoured by
          'tl'; use the 'lt' request (described below) instead, to
          control line length for text set by 'tl'.

        * A title line is not restricted to the top or bottom of a page.

        * 'tl' prints the title line immediately, ignoring a partially
          filled line (which stays untouched).

        * It is not an error to omit closing delimiters.  For example,
          '.tl /foo' is equivalent to '.tl /foo///': It prints a title
          line with the left justified word 'foo'; the centered and
          right justfied parts are empty.

        * 'tl' accepts the same parameter delimiting characters as the
          '\A' escape; see *note Escapes::.

 -- Request: .lt [length]
 -- Request: .lt +length
 -- Request: .lt -length
 -- Register: \n[.lt]
     The title line is printed using its own line length, which is
     specified (or incremented or decremented) with the 'lt' request.
     Initially, the title line length is set to 6.5i.  If a negative
     line length is specified (which is not allowed), 'gtroff' emits a
     warning of type 'range' and sets the title line length to zero.
     The default scaling indicator is 'm'.  If 'lt' is called without an
     argument, the title length is reset to the previous value before
     the last call to 'lt'.

     The current setting of this is available in the '.lt' read-only
     number register; it is associated with the current environment
     (*note Environments::).

 -- Request: .pn page
 -- Request: .pn +page
 -- Request: .pn -page
 -- Register: \n[.pn]
     Change (increase or decrease) the page number of the _next_ page.
     The only argument is the page number; the request is ignored
     without a parameter.

     The read-only number register '.pn' contains the number of the next
     page: either the value set by a 'pn' request, or the number of the
     current page plus 1.

 -- Request: .pc [char]
     Change the page number character (used by the 'tl' request) to a
     different character.  With no argument, this mechanism is disabled.
     Note that this doesn't affect the number register '%'.

   *Note Traps::.

Next: Fonts and Symbols,  Prev: Page Layout,  Up: gtroff Reference

5.16 Page Control
=================

 -- Request: .bp [page]
 -- Request: .bp +page
 -- Request: .bp -page
 -- Register: \n[%]
     Stop processing the current page and move to the next page.  This
     request causes a break.  It can also take an argument to set
     (increase, decrease) the page number of the next page (which
     actually becomes the current page after 'bp' has finished).  The
     difference between 'bp' and 'pn' is that 'pn' does not cause a
     break or actually eject a page.  *Note Page Layout::.

          .de newpage                         \" define macro
          'bp                                 \" begin page
          'sp .5i                             \" vertical space
          .tl 'left top'center top'right top' \" title
          'sp .3i                             \" vertical space
          ..                                  \" end macro

     'bp' has no effect if not called within the top-level diversion
     (*note Diversions::).

     The read-write register '%' holds the current page number.

     The number register '.pe' is set to 1 while 'bp' is active.  *Note
     Page Location Traps::.

 -- Request: .ne [space]
     It is often necessary to force a certain amount of space before a
     new page occurs.  This is most useful to make sure that there is
     not a single "orphan" line left at the bottom of a page.  The 'ne'
     request ensures that there is a certain distance, specified by the
     first argument, before the next page is triggered (see *note
     Traps::, for further information).  The default scaling indicator
     for 'ne' is 'v'; the default value of SPACE is 1v if no argument is
     given.

     For example, to make sure that no fewer than 2 lines get orphaned,
     do the following before each paragraph:

          .ne 2
          text text text

     'ne' then automatically causes a page break if there is space for
     one line only.

 -- Request: .sv [space]
 -- Request: .os
     'sv' is similar to the 'ne' request; it reserves the specified
     amount of vertical space.  If the desired amount of space exists
     before the next trap (or the bottom page boundary if no trap is
     set), the space is output immediately (ignoring a partially filled
     line, which stays untouched).  If there is not enough space, it is
     stored for later output via the 'os' request.  The default value
     is 1v if no argument is given; the default scaling indicator is
     'v'.

     Both 'sv' and 'os' ignore no-space mode.  While the 'sv' request
     allows negative values for SPACE, 'os' ignores them.

 -- Register: \n[nl]
     This register contains the current vertical position.  If the
     vertical position is zero and the top of page transition hasn't
     happened yet, 'nl' is set to negative value.  'gtroff' itself does
     this at the very beginning of a document before anything has been
     printed, but the main usage is to plant a header trap on a page if
     this page has already started.

     Consider the following:

          .de xxx
          .  sp
          .  tl ''Header''
          .  sp
          ..
          .
          First page.
          .bp
          .wh 0 xxx
          .nr nl (-1)
          Second page.

     Result:

          First page.

          ...

                                       Header

          Second page.

          ...

     Without resetting 'nl' to a negative value, the just planted trap
     would be active beginning with the _next_ page, not the current
     one.

     *Note Diversions::, for a comparison with the '.h' and '.d'
     registers.

Next: Sizes,  Prev: Page Control,  Up: gtroff Reference

5.17 Fonts and Symbols
======================

'gtroff' can switch fonts at any point in the text.

   The basic set of fonts is 'R', 'I', 'B', and 'BI'.  These are Times
Roman, Italic, Bold, and Bold Italic.  For non-TTY devices, there is
also at least one symbol font that contains various special symbols
(Greek, mathematics).

* Menu:

* Changing Fonts::
* Font Families::
* Font Positions::
* Using Symbols::
* Character Classes::
* Special Fonts::
* Artificial Fonts::
* Ligatures and Kerning::

Next: Font Families,  Prev: Fonts and Symbols,  Up: Fonts and Symbols

5.17.1 Changing Fonts
---------------------

 -- Request: .ft [font]
 -- Escape: \ff
 -- Escape: \f(fn
 -- Escape: \f[font]
 -- Register: \n[.sty]
     The 'ft' request and the '\f' escape change the current font to
     FONT (one-character name F, two-character name FN).

     If FONT is a style name (as set with the 'sty' request or with the
     'styles' command in the 'DESC' file), use it within the current
     font family (as set with the 'fam' request, '\F' escape, or with
     the 'family' command in the 'DESC' file).

     It is not possible to switch to a font with the name 'DESC'
     (whereas this name could be used as a style name; however, this is
     not recommended).

     With no argument or using 'P' as an argument, '.ft' switches to the
     previous font.  Use '\f[]' to do this with the escape.  The old
     syntax forms '\fP' or '\f[P]' are also supported.

     Fonts are generally specified as upper-case strings, which are
     usually 1 to 4 characters representing an abbreviation or acronym
     of the font name.  This is no limitation, just a convention.

     The example below produces two identical lines.

          eggs, bacon,
          .ft B
          spam
          .ft
          and sausage.

          eggs, bacon, \fBspam\fP and sausage.

     Note that '\f' doesn't produce an input token in 'gtroff'.  As a
     consequence, it can be used in requests like 'mc' (which expects a
     single character as an argument) to change the font on the fly:

          .mc \f[I]x\f[]

     The current style name is available in the read-only number
     register '.sty' (this is a string-valued register); if the current
     font isn't a style, the empty string is returned.  It is associated
     with the current environment.

     *Note Font Positions::, for an alternative syntax.

 -- Request: .ftr f [g]
     Translate font F to font G.  Whenever a font named F is referred to
     in a '\f' escape sequence, in the 'F' and 'S' conditional
     operators, or in the 'ft', 'ul', 'bd', 'cs', 'tkf', 'special',
     'fspecial', 'fp', or 'sty' requests, font G is used.  If G is
     missing or equal to F the translation is undone.

     Note that it is not possible to chain font translations.  Example:

          .ftr XXX TR
          .ftr XXX YYY
          .ft XXX
              => warning: can't find font `XXX'

 -- Request: .fzoom f [zoom]
 -- Register: \n[.zoom]
     Set magnification of font F to factor ZOOM, which must be a
     non-negative integer multiple of 1/1000th.  This request is useful
     to adjust the optical size of a font in relation to the others.  In
     the example below, font 'CR' is magnified by 10% (the zoom factor
     is thus 1.1).

          .fam P
          .fzoom CR 1100
          .ps 12
          Palatino and \f[CR]Courier\f[]

     A missing or zero value of ZOOM is the same as a value of 1000,
     which means no magnification.  F must be a real font name, not a
     style.

     Note that the magnification of a font is completely transparent to
     troff; a change of the zoom factor doesn't cause any effect except
     that the dimensions of glyphs, (word) spaces, kerns, etc., of the
     affected font are adjusted accordingly.

     The zoom factor of the current font is available in the read-only
     number register '.zoom', in multiples of 1/1000th.  It returns zero
     if there is no magnification.

Next: Font Positions,  Prev: Changing Fonts,  Up: Fonts and Symbols

5.17.2 Font Families
--------------------

Due to the variety of fonts available, 'gtroff' has added the concept of
"font families" and "font styles".  The fonts are specified as the
concatenation of the font family and style.  Specifying a font without
the family part causes 'gtroff' to use that style of the current family.

   Currently, fonts for the devices '-Tps', '-Tpdf', '-Tdvi', '-Tlj4',
'-Tlbp', and the X11 fonts are set up to this mechanism.  By default,
'gtroff' uses the Times family with the four styles 'R', 'I', 'B', and
'BI'.

   This way, it is possible to use the basic four fonts and to select a
different font family on the command line (*note Groff Options::).

 -- Request: .fam [family]
 -- Register: \n[.fam]
 -- Escape: \Ff
 -- Escape: \F(fm
 -- Escape: \F[family]
 -- Register: \n[.fn]
     Switch font family to FAMILY (one-character name F, two-character
     name FM).  If no argument is given, switch back to the previous
     font family.  Use '\F[]' to do this with the escape.  Note that
     '\FP' doesn't work; it selects font family 'P' instead.

     The value at start-up is 'T'.  The current font family is available
     in the read-only number register '.fam' (this is a string-valued
     register); it is associated with the current environment.

          spam,
          .fam H    \" helvetica family
          spam,     \" used font is family H + style R = HR
          .ft B     \" family H + style B = font HB
          spam,
          .fam T    \" times family
          spam,     \" used font is family T + style B = TB
          .ft AR    \" font AR (not a style)
          baked beans,
          .ft R     \" family T + style R = font TR
          and spam.

     Note that '\F' doesn't produce an input token in 'gtroff'.  As a
     consequence, it can be used in requests like 'mc' (which expects a
     single character as an argument) to change the font family on the
     fly:

          .mc \F[P]x\F[]

     The '.fn' register contains the current "real font name" of the
     current font.  This is a string-valued register.  If the current
     font is a style, the value of '\n[.fn]' is the proper concatenation
     of family and style name.

 -- Request: .sty n style
     Associate STYLE with font position N.  A font position can be
     associated either with a font or with a style.  The current font is
     the index of a font position and so is also either a font or a
     style.  If it is a style, the font that is actually used is the
     font which name is the concatenation of the name of the current
     family and the name of the current style.  For example, if the
     current font is 1 and font position 1 is associated with style 'R'
     and the current font family is 'T', then font 'TR' is used.  If the
     current font is not a style, then the current family is ignored.
     If the requests 'cs', 'bd', 'tkf', 'uf', or 'fspecial' are applied
     to a style, they are instead applied to the member of the current
     family corresponding to that style.

     N must be a non-negative integer value.

     The default family can be set with the '-f' option (*note Groff
     Options::).  The 'styles' command in the 'DESC' file controls which
     font positions (if any) are initially associated with styles rather
     than fonts.  For example, the default setting for POSTSCRIPT fonts

          styles R I B BI

     is equivalent to

          .sty 1 R
          .sty 2 I
          .sty 3 B
          .sty 4 BI

     'fam' and '\F' always check whether the current font position is
     valid; this can give surprising results if the current font
     position is associated with a style.

     In the following example, we want to access the POSTSCRIPT font
     'FooBar' from the font family 'Foo':

          .sty \n[.fp] Bar
          .fam Foo
              => warning: can't find font `FooR'

     The default font position at start-up is 1; for the POSTSCRIPT
     device, this is associated with style 'R', so 'gtroff' tries to
     open 'FooR'.

     A solution to this problem is to use a dummy font like the
     following:

          .fp 0 dummy TR    \" set up dummy font at position 0
          .sty \n[.fp] Bar  \" register style `Bar'
          .ft 0             \" switch to font at position 0
          .fam Foo          \" activate family `Foo'
          .ft Bar           \" switch to font `FooBar'

     *Note Font Positions::.

Next: Using Symbols,  Prev: Font Families,  Up: Fonts and Symbols

5.17.3 Font Positions
---------------------

For the sake of old phototypesetters and compatibility with old versions
of 'troff', 'gtroff' has the concept of font "positions", on which
various fonts are mounted.

 -- Request: .fp pos font [external-name]
 -- Register: \n[.f]
 -- Register: \n[.fp]
     Mount font FONT at position POS (which must be a non-negative
     integer).  This numeric position can then be referred to with font
     changing commands.  When 'gtroff' starts it is using font
     position 1 (which must exist; position 0 is unused usually at
     start-up).

     The current font in use, as a font position, is available in the
     read-only number register '.f'.  This can be useful to remember the
     current font for later recall.  It is associated with the current
     environment (*note Environments::).

          .nr save-font \n[.f]
          .ft B
          ... text text text ...
          .ft \n[save-font]

     The number of the next free font position is available in the
     read-only number register '.fp'.  This is useful when mounting a
     new font, like so:

          .fp \n[.fp] NEATOFONT

     Fonts not listed in the 'DESC' file are automatically mounted on
     the next available font position when they are referenced.  If a
     font is to be mounted explicitly with the 'fp' request on an unused
     font position, it should be mounted on the first unused font
     position, which can be found in the '.fp' register.  Although
     'gtroff' does not enforce this strictly, it is not allowed to mount
     a font at a position whose number is much greater (approx. 1000
     positions) than that of any currently used position.

     The 'fp' request has an optional third argument.  This argument
     gives the external name of the font, which is used for finding the
     font description file.  The second argument gives the internal name
     of the font, which is used to refer to the font in 'gtroff' after
     it has been mounted.  If there is no third argument then the
     internal name is used as the external name.  This feature makes it
     possible to use fonts with long names in compatibility mode.

   Both the 'ft' request and the '\f' escape have alternative syntax
forms to access font positions.

 -- Request: .ft nnn
 -- Escape: \fn
 -- Escape: \f(nn
 -- Escape: \f[nnn]
     Change the current font position to NNN (one-digit position N,
     two-digit position NN), which must be a non-negative integer.

     If NNN is associated with a style (as set with the 'sty' request or
     with the 'styles' command in the 'DESC' file), use it within the
     current font family (as set with the 'fam' request, the '\F'
     escape, or with the 'family' command in the 'DESC' file).

          this is font 1
          .ft 2
          this is font 2
          .ft                   \" switch back to font 1
          .ft 3
          this is font 3
          .ft
          this is font 1 again

     *Note Changing Fonts::, for the standard syntax form.

Next: Character Classes,  Prev: Font Positions,  Up: Fonts and Symbols

5.17.4 Using Symbols
--------------------

A "glyph" is a graphical representation of a "character".  While a
character is an abstract entity containing semantic information, a glyph
is something that can be actually seen on screen or paper.  It is
possible that a character has multiple glyph representation forms (for
example, the character 'A' can be either written in a roman or an italic
font, yielding two different glyphs); sometimes more than one character
maps to a single glyph (this is a "ligature" - the most common is 'fi').

   A "symbol" is simply a named glyph.  Within 'gtroff', all glyph names
of a particular font are defined in its font file.  If the user requests
a glyph not available in this font, 'gtroff' looks up an ordered list of
"special fonts".  By default, the POSTSCRIPT output device supports the
two special fonts 'SS' (slanted symbols) and 'S' (symbols) (the former
is looked up before the latter).  Other output devices use different
names for special fonts.  Fonts mounted with the 'fonts' keyword in the
'DESC' file are globally available.  To install additional special fonts
locally (i.e. for a particular font), use the 'fspecial' request.

   Here the exact rules how 'gtroff' searches a given symbol:

   * If the symbol has been defined with the 'char' request, use it.
     This hides a symbol with the same name in the current font.

   * Check the current font.

   * If the symbol has been defined with the 'fchar' request, use it.

   * Check whether the current font has a font-specific list of special
     fonts; test all fonts in the order of appearance in the last
     'fspecial' call if appropriate.

   * If the symbol has been defined with the 'fschar' request for the
     current font, use it.

   * Check all fonts in the order of appearance in the last 'special'
     call.

   * If the symbol has been defined with the 'schar' request, use it.

   * As a last resort, consult all fonts loaded up to now for special
     fonts and check them, starting with the lowest font number.  Note
     that this can sometimes lead to surprising results since the
     'fonts' line in the 'DESC' file often contains empty positions,
     which are filled later on.  For example, consider the following:

          fonts 3 0 0 FOO

     This mounts font 'foo' at font position 3.  We assume that 'FOO' is
     a special font, containing glyph 'foo', and that no font has been
     loaded yet.  The line

          .fspecial BAR BAZ

     makes font 'BAZ' special only if font 'BAR' is active.  We further
     assume that 'BAZ' is really a special font, i.e., the font
     description file contains the 'special' keyword, and that it also
     contains glyph 'foo' with a special shape fitting to font 'BAR'.
     After executing 'fspecial', font 'BAR' is loaded at font
     position 1, and 'BAZ' at position 2.

     We now switch to a new font 'XXX', trying to access glyph 'foo'
     that is assumed to be missing.  There are neither font-specific
     special fonts for 'XXX' nor any other fonts made special with the
     'special' request, so 'gtroff' starts the search for special fonts
     in the list of already mounted fonts, with increasing font
     positions.  Consequently, it finds 'BAZ' before 'FOO' even for
     'XXX', which is not the intended behaviour.

   *Note Font Files::, and *note Special Fonts::, for more details.

   The list of available symbols is device dependent; see the
'groff_char(7)' man page for a complete list of all glyphs.  For
example, say

     man -Tdvi groff_char > groff_char.dvi

for a list using the default DVI fonts (not all versions of the 'man'
program support the '-T' option).  If you want to use an additional
macro package to change the used fonts, 'groff' must be called directly:

     groff -Tdvi -mec -man groff_char.7 > groff_char.dvi

   Glyph names not listed in groff_char(7) are derived algorithmically,
using a simplified version of the Adobe Glyph List (AGL) algorithm,
which is described in
<http://partners.adobe.com/public/developer/opentype/index_glyph.html>.
The (frozen) set of glyph names that can't be derived algorithmically is
called "groff glyph list (GGL)".

   * A glyph for Unicode character U+XXXX[X[X]], which is not a
     composite character is named 'uXXXX[X[X]]'.  X must be an uppercase
     hexadecimal digit.  Examples: 'u1234', 'u008E', 'u12DB8'.  The
     largest Unicode value is 0x10FFFF. There must be at least four 'X'
     digits; if necessary, add leading zeroes (after the 'u').  No zero
     padding is allowed for character codes greater than 0xFFFF.
     Surrogates (i.e., Unicode values greater than 0xFFFF represented
     with character codes from the surrogate area U+D800-U+DFFF) are not
     allowed too.

   * A glyph representing more than a single input character is named

          'u' COMPONENT1 '_' COMPONENT2 '_' COMPONENT3 ...

     Example: 'u0045_0302_0301'.

     For simplicity, all Unicode characters that are composites must be
     decomposed maximally (this is normalization form D in the Unicode
     standard); for example, 'u00CA_0301' is not a valid glyph name
     since U+00CA (LATIN CAPITAL LETTER E WITH CIRCUMFLEX) can be
     further decomposed into U+0045 (LATIN CAPITAL LETTER E) and U+0302
     (COMBINING CIRCUMFLEX ACCENT).  'u0045_0302_0301' is thus the glyph
     name for U+1EBE, LATIN CAPITAL LETTER E WITH CIRCUMFLEX AND ACUTE.

   * groff maintains a table to decompose all algorithmically derived
     glyph names that are composites itself.  For example, 'u0100'
     (LATIN LETTER A WITH MACRON) is automatically decomposed into
     'u0041_0304'.  Additionally, a glyph name of the GGL is preferred
     to an algorithmically derived glyph name; groff also automatically
     does the mapping.  Example: The glyph 'u0045_0302' is mapped to
     '^E'.

   * glyph names of the GGL can't be used in composite glyph names; for
     example, '^E_u0301' is invalid.

 -- Escape: \(nm
 -- Escape: \[name]
 -- Escape: \[component1 component2 ...]
     Insert a symbol NAME (two-character name NM) or a composite glyph
     with component glyphs COMPONENT1, COMPONENT2, ...  There is no
     special syntax for one-character names - the natural form '\N'
     would collide with escapes.(1)  (*note Using Symbols-Footnote-1::)

     If NAME is undefined, a warning of type 'char' is generated, and
     the escape is ignored.  *Note Debugging::, for information about
     warnings.

     groff resolves '\[...]' with more than a single component as
     follows:

        * Any component that is found in the GGL is converted to the
          'uXXXX' form.

        * Any component 'uXXXX' that is found in the list of
          decomposable glyphs is decomposed.

        * The resulting elements are then concatenated with '_' in
          between, dropping the leading 'u' in all elements but the
          first.

     No check for the existence of any component (similar to 'tr'
     request) is done.

     Examples:

     '\[A ho]'
          'A' maps to 'u0041', 'ho' maps to 'u02DB', thus the final
          glyph name would be 'u0041_02DB'.  Note this is not the
          expected result: The ogonek glyph 'ho' is a spacing ogonek,
          but for a proper composite a non-spacing ogonek (U+0328) is
          necessary.  Looking into the file 'composite.tmac' one can
          find '.composite ho u0328', which changes the mapping of 'ho'
          while a composite glyph name is constructed, causing the final
          glyph name to be 'u0041_0328'.

     '\[^E u0301]'
     '\[^E aa]'
     '\[E a^ aa]'
     '\[E ^ ']'
          '^E' maps to 'u0045_0302', thus the final glyph name is
          'u0045_0302_0301' in all forms (assuming proper calls of the
          'composite' request).

     It is not possible to define glyphs with names like 'A ho' within a
     groff font file.  This is not really a limitation; instead, you
     have to define 'u0041_0328'.

 -- Escape: \C'xxx'
     Typeset the glyph named XXX.(2)  (*note Using Symbols-Footnote-2::)
     Normally it is more convenient to use '\[XXX]', but '\C' has the
     advantage that it is compatible with newer versions of AT&T 'troff'
     and is available in compatibility mode.

 -- Request: .composite from to
     Map glyph name FROM to glyph name TO if it is used in '\[...]' with
     more than one component.  See above for examples.

     This mapping is based on glyph names only; no check for the
     existence of either glyph is done.

     A set of default mappings for many accents can be found in the file
     'composite.tmac', which is loaded at start-up.

 -- Escape: \N'n'
     Typeset the glyph with code N in the current font ('n' is *not* the
     input character code).  The number N can be any non-negative
     decimal integer.  Most devices only have glyphs with codes between
     0 and 255; the Unicode output device uses codes in the range
     0-65535.  If the current font does not contain a glyph with that
     code, special fonts are _not_ searched.  The '\N' escape sequence
     can be conveniently used in conjunction with the 'char' request:

          .char \[phone] \f[ZD]\N'37'

     The code of each glyph is given in the fourth column in the font
     description file after the 'charset' command.  It is possible to
     include unnamed glyphs in the font description file by using a name
     of '---'; the '\N' escape sequence is the only way to use these.

     No kerning is applied to glyphs accessed with '\N'.

   Some escape sequences directly map onto special glyphs.

 -- Escape: \'
     This is a backslash followed by the apostrophe character, ASCII
     character '0x27' (EBCDIC character '0x7D').  The same as '\[aa]',
     the acute accent.

 -- Escape: \`
     This is a backslash followed by ASCII character '0x60' (EBCDIC
     character '0x79' usually).  The same as '\[ga]', the grave accent.

 -- Escape: \-
     This is the same as '\[-]', the minus sign in the current font.

 -- Escape: \_
     This is the same as '\[ul]', the underline character.

 -- Request: .cflags n c1 c2 ...
     Input characters and symbols have certain properties associated
     with it.(3)  (*note Using Symbols-Footnote-3::) These properties
     can be modified with the 'cflags' request.  The first argument is
     the sum of the desired flags and the remaining arguments are the
     characters or symbols to have those properties.  It is possible to
     omit the spaces between the characters or symbols.  Instead of
     single characters or symbols you can also use character classes
     (see *note Character Classes:: for more details).

     '1'
          The character ends sentences (initially characters '.?!' have
          this property).

     '2'
          Lines can be broken before the character (initially no
          characters have this property).  This only works if both the
          characters before and after have non-zero hyphenation codes
          (as set with the 'hcode' request).  Use value 64 to override
          this behaviour.

     '4'
          Lines can be broken after the character (initially the
          character '-' and the symbols '\[hy]' and '\[em]' have this
          property).  This only works if both the characters before and
          after have non-zero hyphenation codes (as set with the 'hcode'
          request).  Use value 64 to override this behaviour.

     '8'
          The character overlaps horizontally if used as a horizontal
          line building element.  Initially the symbols '\[ul]',
          '\[rn]', '\[ru]', '\[radicalex]', and '\[sqrtex]' have this
          property.

     '16'
          The character overlaps vertically if used as vertical line
          building element.  Initially symbol '\[br]' has this property.

     '32'
          An end-of-sentence character followed by any number of
          characters with this property is treated as the end of a
          sentence if followed by a newline or two spaces; in other
          words the character is "transparent" for the purposes of
          end-of-sentence recognition - this is the same as having a
          zero space factor in TeX (initially characters '"')]*' and the
          symbols '\[dg]', '\[rq]', and '\[cq]' have this property).

     '64'
          Ignore hyphenation code values of the surrounding characters.
          Use this in combination with values 2 and 4 (initially no
          characters have this property).  For example, if you need an
          automatic break point after the hyphen in number ranges like
          '3000-5000', insert

               .cflags 68 -

          into your document.  Note, however, that this can lead to bad
          layout if done without thinking; in most situations, a better
          solution instead of changing the 'cflags' value is to insert
          '\:' right after the hyphen at the places that really need a
          break point.

     '128'
          Prohibit a line break before the character, but allow a line
          break after the character.  This works only in combination
          with flags 256 and 512 (see below) and has no effect
          otherwise.

     '256'
          Prohibit a line break after the character, but allow a line
          break before the character.  This works only in combination
          with flags 128 and 512 (see below) and has no effect
          otherwise.

     '512'
          Allow line break before or after the character.  This works
          only in combination with flags 128 and 256 and has no effect
          otherwise.

          Contrary to flag values 2 and 4, the flags 128, 256, and 512
          work pairwise.  If, for example, the left character has value
          512, and the right character 128, no line break gets inserted.
          If we use value 6 instead for the left character, a line break
          after the character can't be suppressed since the right
          neighbour character doesn't get examined.

 -- Request: .char g [string]
 -- Request: .fchar g [string]
 -- Request: .fschar f g [string]
 -- Request: .schar g [string]
     Define a new glyph G to be STRING (which can be empty).(4)  (*note
     Using Symbols-Footnote-4::) Every time glyph G needs to be printed,
     STRING is processed in a temporary environment and the result is
     wrapped up into a single object.  Compatibility mode is turned off
     and the escape character is set to '\' while STRING is being
     processed.  Any emboldening, constant spacing or track kerning is
     applied to this object rather than to individual characters in
     STRING.

     A glyph defined by these requests can be used just like a normal
     glyph provided by the output device.  In particular, other
     characters can be translated to it with the 'tr' or 'trin'
     requests; it can be made the leader character by the 'lc' request;
     repeated patterns can be drawn with the glyph using the '\l' and
     '\L' escape sequences; words containing the glyph can be hyphenated
     correctly if the 'hcode' request is used to give the glyph's symbol
     a hyphenation code.

     There is a special anti-recursion feature: Use of 'g' within the
     glyph's definition is handled like normal characters and symbols
     not defined with 'char'.

     Note that the 'tr' and 'trin' requests take precedence if 'char'
     accesses the same symbol.

          .tr XY
          X
              => Y
          .char X Z
          X
              => Y
          .tr XX
          X
              => Z

     The 'fchar' request defines a fallback glyph: 'gtroff' only checks
     for glyphs defined with 'fchar' if it cannot find the glyph in the
     current font.  'gtroff' carries out this test before checking
     special fonts.

     'fschar' defines a fallback glyph for font F: 'gtroff' checks for
     glyphs defined with 'fschar' after the list of fonts declared as
     font-specific special fonts with the 'fspecial' request, but before
     the list of fonts declared as global special fonts with the
     'special' request.

     Finally, the 'schar' request defines a global fallback glyph:
     'gtroff' checks for glyphs defined with 'schar' after the list of
     fonts declared as global special fonts with the 'special' request,
     but before the already mounted special fonts.

     *Note Using Symbols::, for a detailed description of the glyph
     searching mechanism in 'gtroff'.

 -- Request: .rchar c1 c2 ...
 -- Request: .rfschar f c1 c2 ...
     Remove the definitions of glyphs C1, C2, ...  This undoes the
     effect of a 'char', 'fchar', or 'schar' request.

     It is possible to omit the whitespace between arguments.

     The request 'rfschar' removes glyph definitions defined with
     'fschar' for glyph f.

   *Note Special Characters::.

Next: Special Fonts,  Prev: Using Symbols,  Up: Fonts and Symbols

5.17.5 Character Classes
------------------------

Classes are particularly useful for East Asian languages such as
Chinese, Japanese, and Korean, where the number of needed characters is
much larger than in European languages, and where large sets of
characters share the same properties.

 -- Request: .class n c1 c2 ...
     In 'groff', a "character class" (or simply "class") is a set of
     characters, grouped by some user aspect.  The 'class' request
     defines such classes so that other requests can refer to all
     characters belonging to this set with a single class name.
     Currently, only the 'cflags' request can handle character classes.

     A 'class' request takes a class name followed by a list of
     entities.  In its simplest form, the entities are characters or
     symbols:

          .class [prepunct] , : ; > }

     Since class and glyph names share the same namespace, it is
     recommended to start and end the class name with '[' and ']',
     respectively, to avoid collisions with normal 'groff' symbols (and
     symbols defined by the user).  In particular, the presence of ']'
     in the symbol name intentionally prevents the usage of '\[...]',
     thus you must use the '\C' escape to access a class with such a
     name.

     You can also use a special character range notation, consisting of
     a start character or symbol, followed by '-', and an end character
     or symbol.  Internally, 'gtroff' converts these two symbol names to
     Unicode values (according to the groff glyph gist), which then give
     the start and end value of the range.  If that fails, the class
     definition is skipped.

     Finally, classes can be nested, too.

     Here is a more complex example:

          .class [prepunctx] \C'[prepunct]' \[u2013]-\[u2016]

     The class 'prepunctx' now contains the contents of the class
     'prepunct' as defined above (the set ', : ; > }'), and characters
     in the range between 'U+2013' and 'U+2016'.

     If you want to add '-' to a class, it must be the first character
     value in the argument list, otherwise it gets misinterpreted as a
     range.

     Note that it is not possible to use class names within range
     definitions.

     Typical use of the 'class' request is to control line-breaking and
     hyphenation rules as defined by the 'cflags' request.  For example,
     to inhibit line breaks before the characters belonging to the
     'prepunctx' class, you can write:

          .cflags 2 \C'[prepunctx]'

     See the 'cflags' request in *note Using Symbols::, for more
     details.

Next: Artificial Fonts,  Prev: Character Classes,  Up: Fonts and Symbols

5.17.6 Special Fonts
--------------------

Special fonts are those that 'gtroff' searches when it cannot find the
requested glyph in the current font.  The Symbol font is usually a
special font.

   'gtroff' provides the following two requests to add more special
fonts.  *Note Using Symbols::, for a detailed description of the glyph
searching mechanism in 'gtroff'.

   Usually, only non-TTY devices have special fonts.

 -- Request: .special [s1 s2 ...]
 -- Request: .fspecial f [s1 s2 ...]
     Use the 'special' request to define special fonts.  Initially, this
     list is empty.

     Use the 'fspecial' request to designate special fonts only when
     font F is active.  Initially, this list is empty.

     Previous calls to 'special' or 'fspecial' are overwritten; without
     arguments, the particular list of special fonts is set to empty.
     Special fonts are searched in the order they appear as arguments.

     All fonts that appear in a call to 'special' or 'fspecial' are
     loaded.

     *Note Using Symbols::, for the exact search order of glyphs.

Next: Ligatures and Kerning,  Prev: Special Fonts,  Up: Fonts and Symbols

5.17.7 Artificial Fonts
-----------------------

There are a number of requests and escapes for artificially creating
fonts.  These are largely vestiges of the days when output devices did
not have a wide variety of fonts, and when 'nroff' and 'troff' were
separate programs.  Most of them are no longer necessary in GNU 'troff'.
Nevertheless, they are supported.

 -- Escape: \H'height'
 -- Escape: \H'+height'
 -- Escape: \H'-height'
 -- Register: \n[.height]
     Change (increment, decrement) the height of the current font, but
     not the width.  If HEIGHT is zero, restore the original height.
     Default scaling indicator is 'z'.

     The read-only number register '.height' contains the font height as
     set by '\H'.

     Currently, only the '-Tps' and '-Tpdf' devices support this
     feature.

     Note that '\H' doesn't produce an input token in 'gtroff'.  As a
     consequence, it can be used in requests like 'mc' (which expects a
     single character as an argument) to change the font on the fly:

          .mc \H'+5z'x\H'0'

     In compatibility mode, 'gtroff' behaves differently: If an
     increment or decrement is used, it is always taken relative to the
     current point size and not relative to the previously selected font
     height.  Thus,

          .cp 1
          \H'+5'test \H'+5'test

     prints the word 'test' twice with the same font height (five points
     larger than the current font size).

 -- Escape: \S'slant'
 -- Register: \n[.slant]
     Slant the current font by SLANT degrees.  Positive values slant to
     the right.  Only integer values are possible.

     The read-only number register '.slant' contains the font slant as
     set by '\S'.

     Currently, only the '-Tps' and '-Tpdf' devices support this
     feature.

     Note that '\S' doesn't produce an input token in 'gtroff'.  As a
     consequence, it can be used in requests like 'mc' (which expects a
     single character as an argument) to change the font on the fly:

          .mc \S'20'x\S'0'

     This request is incorrectly documented in the original UNIX troff
     manual; the slant is always set to an absolute value.

 -- Request: .ul [lines]
     The 'ul' request normally underlines subsequent lines if a TTY
     output device is used.  Otherwise, the lines are printed in italics
     (only the term 'underlined' is used in the following).  The single
     argument is the number of input lines to be underlined; with no
     argument, the next line is underlined.  If LINES is zero or
     negative, stop the effects of 'ul' (if it was active).  Requests
     and empty lines do not count for computing the number of underlined
     input lines, even if they produce some output like 'tl'.  Lines
     inserted by macros (e.g. invoked by a trap) do count.

     At the beginning of 'ul', the current font is stored and the
     underline font is activated.  Within the span of a 'ul' request, it
     is possible to change fonts, but after the last line affected by
     'ul' the saved font is restored.

     This number of lines still to be underlined is associated with the
     current environment (*note Environments::).  The underline font can
     be changed with the 'uf' request.

     The 'ul' request does not underline spaces.

 -- Request: .cu [lines]
     The 'cu' request is similar to 'ul' but underlines spaces as well
     (if a TTY output device is used).

 -- Request: .uf font
     Set the underline font (globally) used by 'ul' and 'cu'.  By
     default, this is the font at position 2.  FONT can be either a
     non-negative font position or the name of a font.

 -- Request: .bd font [offset]
 -- Request: .bd font1 font2 [offset]
 -- Register: \n[.b]
     Artificially create a bold font by printing each glyph twice,
     slightly offset.

     Two syntax forms are available.

        * Imitate a bold font unconditionally.  The first argument
          specifies the font to embolden, and the second is the number
          of basic units, minus one, by which the two glyphs are offset.
          If the second argument is missing, emboldening is turned off.

          FONT can be either a non-negative font position or the name of
          a font.

          OFFSET is available in the '.b' read-only register if a
          special font is active; in the 'bd' request, its default unit
          is 'u'.

        * Imitate a bold form conditionally.  Embolden FONT1 by OFFSET
          only if font FONT2 is the current font.  This command can be
          issued repeatedly to set up different emboldening values for
          different current fonts.  If the second argument is missing,
          emboldening is turned off for this particular current font.

          This affects special fonts only (either set up with the
          'special' command in font files or with the 'fspecial'
          request).

 -- Request: .cs font [width [em-size]]
     Switch to and from "constant glyph space mode".  If activated, the
     width of every glyph is WIDTH/36 ems.  The em size is given
     absolutely by EM-SIZE; if this argument is missing, the em value is
     taken from the current font size (as set with the 'ps' request)
     when the font is effectively in use.  Without second and third
     argument, constant glyph space mode is deactivated.

     Default scaling indicator for EM-SIZE is 'z'; WIDTH is an integer.

Prev: Artificial Fonts,  Up: Fonts and Symbols

5.17.8 Ligatures and Kerning
----------------------------

Ligatures are groups of characters that are run together, i.e, producing
a single glyph.  For example, the letters 'f' and 'i' can form a
ligature 'fi' as in the word 'file'.  This produces a cleaner look
(albeit subtle) to the printed output.  Usually, ligatures are not
available in fonts for TTY output devices.

   Most POSTSCRIPT fonts support the fi and fl ligatures.  The C/A/T
typesetter that was the target of AT&T 'troff' also supported 'ff',
'ffi', and 'ffl' ligatures.  Advanced typesetters or 'expert' fonts may
include ligatures for 'ft' and 'ct', although GNU 'troff' does not
support these (yet).

   Only the current font is checked for ligatures and kerns; neither
special fonts nor entities defined with the 'char' request (and its
siblings) are taken into account.

 -- Request: .lg [flag]
 -- Register: \n[.lg]
     Switch the ligature mechanism on or off; if the parameter is
     non-zero or missing, ligatures are enabled, otherwise disabled.
     Default is on.  The current ligature mode can be found in the
     read-only number register '.lg' (set to 1 or 2 if ligatures are
     enabled, 0 otherwise).

     Setting the ligature mode to 2 enables the two-character ligatures
     (fi, fl, and ff) and disables the three-character ligatures (ffi
     and ffl).

   "Pairwise kerning" is another subtle typesetting mechanism that
modifies the distance between a glyph pair to improve readability.  In
most cases (but not always) the distance is decreased.  Typewriter-like
fonts and fonts for terminals where all glyphs have the same width don't
use kerning.

 -- Request: .kern [flag]
 -- Register: \n[.kern]
     Switch kerning on or off.  If the parameter is non-zero or missing,
     enable pairwise kerning, otherwise disable it.  The read-only
     number register '.kern' is set to 1 if pairwise kerning is enabled,
     0 otherwise.

     If the font description file contains pairwise kerning information,
     glyphs from that font are kerned.  Kerning between two glyphs can
     be inhibited by placing '\&' between them: 'V\&A'.

     *Note Font File Format::.

   "Track kerning" expands or reduces the space between glyphs.  This
can be handy, for example, if you need to squeeze a long word onto a
single line or spread some text to fill a narrow column.  It must be
used with great care since it is usually considered bad typography if
the reader notices the effect.

 -- Request: .tkf f s1 n1 s2 n2
     Enable track kerning for font F.  If the current font is F the
     width of every glyph is increased by an amount between N1 and N2
     (N1, N2 can be negative); if the current point size is less than or
     equal to S1 the width is increased by N1; if it is greater than or
     equal to S2 the width is increased by N2; if the point size is
     greater than or equal to S1 and less than or equal to S2 the
     increase in width is a linear function of the point size.

     The default scaling indicator is 'z' for S1 and S2, 'p' for N1 and
     N2.

     Note that the track kerning amount is added even to the rightmost
     glyph in a line; for large values it is thus recommended to
     increase the line length by the same amount to compensate it.

   Sometimes, when typesetting letters of different fonts, more or less
space at such boundaries are needed.  There are two escapes to help with
this.

 -- Escape: \/
     Increase the width of the preceding glyph so that the spacing
     between that glyph and the following glyph is correct if the
     following glyph is a roman glyph.  For example, if an italic 'f' is
     immediately followed by a roman right parenthesis, then in many
     fonts the top right portion of the 'f' overlaps the top left of the
     right parenthesis.  Use this escape sequence whenever an italic
     glyph is immediately followed by a roman glyph without any
     intervening space.  This small amount of space is also called
     "italic correction".

 -- Escape: \,
     Modify the spacing of the following glyph so that the spacing
     between that glyph and the preceding glyph is correct if the
     preceding glyph is a roman glyph.  Use this escape sequence
     whenever a roman glyph is immediately followed by an italic glyph
     without any intervening space.  In analogy to above, this space
     could be called "left italic correction", but this term isn't used
     widely.

 -- Escape: \&
     Insert a zero-width character, which is invisible.  Its intended
     use is to stop interaction of a character with its surrounding.

        * It prevents the insertion of extra space after an
          end-of-sentence character.

               Test.
               Test.
                   => Test.  Test.
               Test.\&
               Test.
                   => Test. Test.

        * It prevents interpretation of a control character at the
          beginning of an input line.

               .Test
                   => warning: `Test' not defined
               \&.Test
                   => .Test

        * It prevents kerning between two glyphs.

        * It is needed to map an arbitrary character to nothing in the
          'tr' request (*note Character Translations::).

 -- Escape: \)
     This escape is similar to '\&' except that it behaves like a
     character declared with the 'cflags' request to be transparent for
     the purposes of an end-of-sentence character.

     Its main usage is in macro definitions to protect against arguments
     starting with a control character.

          .de xxx
          \)\\$1
          ..
          .de yyy
          \&\\$1
          ..
          This is a test.\c
          .xxx '
          This is a test.
              =>This is a test.'  This is a test.
          This is a test.\c
          .yyy '
          This is a test.
              =>This is a test.' This is a test.

Next: Strings,  Prev: Fonts and Symbols,  Up: gtroff Reference

5.18 Sizes
==========

'gtroff' uses two dimensions with each line of text, type size and
vertical spacing.  The "type size" is approximately the height of the
tallest glyph.(1)  (*note Sizes-Footnote-1::) "Vertical spacing" is the
amount of space 'gtroff' allows for a line of text; normally, this is
about 20% larger than the current type size.  Ratios smaller than this
can result in hard-to-read text; larger than this, it spreads the text
out more vertically (useful for term papers).  By default, 'gtroff' uses
10 point type on 12 point spacing.

   The difference between type size and vertical spacing is known, by
typesetters, as "leading" (this is pronounced 'ledding').

* Menu:

* Changing Type Sizes::
* Fractional Type Sizes::

Next: Fractional Type Sizes,  Prev: Sizes,  Up: Sizes

5.18.1 Changing Type Sizes
--------------------------

 -- Request: .ps [size]
 -- Request: .ps +size
 -- Request: .ps -size
 -- Escape: \ssize
 -- Register: \n[.s]
     Use the 'ps' request or the '\s' escape to change (increase,
     decrease) the type size (in points).  Specify SIZE as either an
     absolute point size, or as a relative change from the current size.
     The size 0 (for both '.ps' and '\s'), or no argument (for '.ps'
     only), goes back to the previous size.

     Default scaling indicator of 'size' is 'z'.  If 'size' is negative,
     it is set to 1u.

     The read-only number register '.s' returns the point size in points
     as a decimal fraction.  This is a string.  To get the point size in
     scaled points, use the '.ps' register instead.

     '.s' is associated with the current environment (*note
     Environments::).

          snap, snap,
          .ps +2
          grin, grin,
          .ps +2
          wink, wink, \s+2nudge, nudge,\s+8 say no more!
          .ps 10

     The '\s' escape may be called in a variety of ways.  Much like
     other escapes there must be a way to determine where the argument
     ends and the text begins.  Any of the following forms are valid:

     '\sN'
          Set the point size to N points.  N must be either 0 or in the
          range 4 to 39.

     '\s+N'
     '\s-N'
          Increase or decrease the point size by N points.  N must be
          exactly one digit.

     '\s(NN'
          Set the point size to NN points.  NN must be exactly two
          digits.

     '\s+(NN'
     '\s-(NN'
     '\s(+NN'
     '\s(-NN'
          Increase or decrease the point size by NN points.  NN must be
          exactly two digits.

     Note that '\s' doesn't produce an input token in 'gtroff'.  As a
     consequence, it can be used in requests like 'mc' (which expects a
     single character as an argument) to change the font on the fly:

          .mc \s[20]x\s[0]

     *Note Fractional Type Sizes::, for yet another syntactical form of
     using the '\s' escape.

 -- Request: .sizes s1 s2 ... sn [0]
     Some devices may only have certain permissible sizes, in which case
     'gtroff' rounds to the nearest permissible size.  The 'DESC' file
     specifies which sizes are permissible for the device.

     Use the 'sizes' request to change the permissible sizes for the
     current output device.  Arguments are in scaled points; the
     'sizescale' line in the 'DESC' file for the output device provides
     the scaling factor.  For example, if the scaling factor is 1000,
     then the value 12000 is 12 points.

     Each argument can be a single point size (such as '12000'), or a
     range of sizes (such as '4000-72000').  You can optionally end the
     list with a zero.

 -- Request: .vs [space]
 -- Request: .vs +space
 -- Request: .vs -space
 -- Register: \n[.v]
     Change (increase, decrease) the vertical spacing by SPACE.  The
     default scaling indicator is 'p'.

     If 'vs' is called without an argument, the vertical spacing is
     reset to the previous value before the last call to 'vs'.

     'gtroff' creates a warning of type 'range' if SPACE is negative;
     the vertical spacing is then set to smallest positive value, the
     vertical resolution (as given in the '.V' register).

     Note that '.vs 0' isn't saved in a diversion since it doesn't
     result in a vertical motion.  You explicitly have to repeat this
     command before inserting the diversion.

     The read-only number register '.v' contains the current vertical
     spacing; it is associated with the current environment (*note
     Environments::).

   The effective vertical line spacing consists of four components.
Breaking a line causes the following actions (in the given order).

   * Move the current point vertically by the "extra pre-vertical line
     space".  This is the minimum value of all '\x' escapes with a
     negative argument in the current output line.

   * Move the current point vertically by the vertical line spacing as
     set with the 'vs' request.

   * Output the current line.

   * Move the current point vertically by the "extra post-vertical line
     space".  This is the maximum value of all '\x' escapes with a
     positive argument in the line that has just been output.

   * Move the current point vertically by the "post-vertical line
     spacing" as set with the 'pvs' request.

   It is usually better to use 'vs' or 'pvs' instead of 'ls' to produce
double-spaced documents: 'vs' and 'pvs' have a finer granularity for the
inserted vertical space compared to 'ls'; furthermore, certain
preprocessors assume single-spacing.

   *Note Manipulating Spacing::, for more details on the '\x' escape and
the 'ls' request.

 -- Request: .pvs [space]
 -- Request: .pvs +space
 -- Request: .pvs -space
 -- Register: \n[.pvs]
     Change (increase, decrease) the post-vertical spacing by SPACE.
     The default scaling indicator is 'p'.

     If 'pvs' is called without an argument, the post-vertical spacing
     is reset to the previous value before the last call to 'pvs'.

     'gtroff' creates a warning of type 'range' if SPACE is zero or
     negative; the vertical spacing is then set to zero.

     The read-only number register '.pvs' contains the current
     post-vertical spacing; it is associated with the current
     environment (*note Environments::).

Prev: Changing Type Sizes,  Up: Sizes

5.18.2 Fractional Type Sizes
----------------------------

A "scaled point" is equal to 1/SIZESCALE points, where SIZESCALE is
specified in the 'DESC' file (1 by default).  There is a new scale
indicator 'z', which has the effect of multiplying by SIZESCALE.
Requests and escape sequences in 'gtroff' interpret arguments that
represent a point size as being in units of scaled points, but they
evaluate each such argument using a default scale indicator of 'z'.
Arguments treated in this way are the argument to the 'ps' request, the
third argument to the 'cs' request, the second and fourth arguments to
the 'tkf' request, the argument to the '\H' escape sequence, and those
variants of the '\s' escape sequence that take a numeric expression as
their argument (see below).

   For example, suppose SIZESCALE is 1000; then a scaled point is
equivalent to a millipoint; the request '.ps 10.25' is equivalent to
'.ps 10.25z' and thus sets the point size to 10250 scaled points, which
is equal to 10.25 points.

   'gtroff' disallows the use of the 'z' scale indicator in instances
where it would make no sense, such as a numeric expression whose default
scale indicator was neither 'u' nor 'z'.  Similarly it would make no
sense to use a scaling indicator other than 'z' or 'u' in a numeric
expression whose default scale indicator was 'z', and so 'gtroff'
disallows this as well.

   There is also new scale indicator 's', which multiplies by the number
of units in a scaled point.  So, for example, '\n[.ps]s' is equal to
'1m'.  Be sure not to confuse the 's' and 'z' scale indicators.

 -- Register: \n[.ps]
     A read-only number register returning the point size in scaled
     points.

     '.ps' is associated with the current environment (*note
     Environments::).

 -- Register: \n[.psr]
 -- Register: \n[.sr]
     The last-requested point size in scaled points is contained in the
     '.psr' read-only number register.  The last requested point size in
     points as a decimal fraction can be found in '.sr'.  This is a
     string-valued read-only number register.

     Note that the requested point sizes are device-independent, whereas
     the values returned by the '.ps' and '.s' registers are not.  For
     example, if a point size of 11pt is requested, and a 'sizes'
     request (or a 'sizescale' line in a 'DESC' file) specifies 10.95pt
     instead, this value is actually used.

     Both registers are associated with the current environment (*note
     Environments::).

   The '\s' escape has the following syntax for working with fractional
type sizes:

'\s[N]'
'\s'N''
     Set the point size to N scaled points; N is a numeric expression
     with a default scale indicator of 'z'.

'\s[+N]'
'\s[-N]'
'\s+[N]'
'\s-[N]'
'\s'+N''
'\s'-N''
'\s+'N''
'\s-'N''
     Increase or or decrease the point size by N scaled points; N is a
     numeric expression (which may start with a minus sign) with a
     default scale indicator of 'z'.

   *Note Font Files::.

Next: Conditionals and Loops,  Prev: Sizes,  Up: gtroff Reference

5.19 Strings
============

'gtroff' has string variables, which are entirely for user convenience
(i.e. there are no built-in strings exept '.T', but even this is a
read-write string variable).

   Although the following requests can be used to create strings, simply
using an undefined string will cause it to be defined as empty.  *Note
Identifiers::.

 -- Request: .ds name [string]
 -- Request: .ds1 name [string]
 -- Escape: \*n
 -- Escape: \*(nm
 -- Escape: \*[name arg1 arg2 ...]
     Define and access a string variable NAME (one-character name N,
     two-character name NM).  If NAME already exists, 'ds' overwrites
     the previous definition.  Only the syntax form using brackets can
     take arguments that are handled identically to macro arguments; the
     single exception is that a closing bracket as an argument must be
     enclosed in double quotes.  *Note Request and Macro Arguments::,
     and *note Parameters::.

     Example:

          .ds foo a \\$1 test
          .
          This is \*[foo nice].
              => This is a nice test.

     The '\*' escape "interpolates" (expands in-place) a
     previously-defined string variable.  To be more precise, the stored
     string is pushed onto the input stack, which is then parsed by
     'gtroff'.  Similar to number registers, it is possible to nest
     strings, i.e., string variables can be called within string
     variables.

     If the string named by the '\*' escape does not exist, it is
     defined as empty, and a warning of type 'mac' is emitted (see *note
     Debugging::, for more details).

     *Caution:* Unlike other requests, the second argument to the 'ds'
     request takes up the entire line including trailing spaces.  This
     means that comments on a line with such a request can introduce
     unwanted space into a string.

          .ds UX \s-1UNIX\s0\u\s-3tm\s0\d \" UNIX trademark

     Instead the comment should be put on another line or have the
     comment escape adjacent with the end of the string.

          .ds UX \s-1UNIX\s0\u\s-3tm\s0\d\"  UNIX trademark

     To produce leading space the string can be started with a double
     quote.  No trailing quote is needed; in fact, any trailing quote is
     included in your string.

          .ds sign "           Yours in a white wine sauce,

     Strings are not limited to a single line of text.  A string can
     span several lines by escaping the newlines with a backslash.  The
     resulting string is stored _without_ the newlines.

          .ds foo lots and lots \
          of text are on these \
          next several lines

     It is not possible to have real newlines in a string.  To put a
     single double quote character into a string, use two consecutive
     double quote characters.

     The 'ds1' request turns off compatibility mode while interpreting a
     string.  To be more precise, a "compatibility save" input token is
     inserted at the beginning of the string, and a "compatibility
     restore" input token at the end.

          .nr xxx 12345
          .ds aa The value of xxx is \\n[xxx].
          .ds1 bb The value of xxx ix \\n[xxx].
          .
          .cp 1
          .
          \*(aa
              => warning: number register `[' not defined
              => The value of xxx is 0xxx].
          \*(bb
              => The value of xxx ix 12345.

     Strings, macros, and diversions (and boxes) share the same name
     space.  Internally, even the same mechanism is used to store them.
     This has some interesting consequences.  For example, it is
     possible to call a macro with string syntax and vice versa.

          .de xxx
          a funny test.
          ..
          This is \*[xxx]
              => This is a funny test.

          .ds yyy a funny test
          This is
          .yyy
              => This is a funny test.

     In particular, interpolating a string does not hide existing macro
     arguments.  Thus in a macro, a more efficient way of doing

          .xx \\$@

     is

          \\*[xx]\\

     Note that the latter calling syntax doesn't change the value of
     '\$0', which is then inherited from the calling macro.

     Diversions and boxes can be also called with string syntax.

     Another consequence is that you can copy one-line diversions or
     boxes to a string.

          .di xxx
          a \fItest\fR
          .br
          .di
          .ds yyy This is \*[xxx]\c
          \*[yyy].
              => This is a test.

     As the previous example shows, it is possible to store formatted
     output in strings.  The '\c' escape prevents the insertion of an
     additional blank line in the output.

     Copying diversions longer than a single output line produces
     unexpected results.

          .di xxx
          a funny
          .br
          test
          .br
          .di
          .ds yyy This is \*[xxx]\c
          \*[yyy].
              => test This is a funny.

     Usually, it is not predictable whether a diversion contains one or
     more output lines, so this mechanism should be avoided.  With UNIX
     'troff', this was the only solution to strip off a final newline
     from a diversion.  Another disadvantage is that the spaces in the
     copied string are already formatted, making them unstretchable.
     This can cause ugly results.

     A clean solution to this problem is available in GNU 'troff', using
     the requests 'chop' to remove the final newline of a diversion, and
     'unformat' to make the horizontal spaces stretchable again.

          .box xxx
          a funny
          .br
          test
          .br
          .box
          .chop xxx
          .unformat xxx
          This is \*[xxx].
              => This is a funny test.

     *Note Gtroff Internals::, for more information.

 -- Request: .as name [string]
 -- Request: .as1 name [string]
     The 'as' request is similar to 'ds' but appends STRING to the
     string stored as NAME instead of redefining it.  If NAME doesn't
     exist yet, it is created.

          .as sign " with shallots, onions and garlic,

     The 'as1' request is similar to 'as', but compatibility mode is
     switched off while the appended string is interpreted.  To be more
     precise, a "compatibility save" input token is inserted at the
     beginning of the appended string, and a "compatibility restore"
     input token at the end.

   Rudimentary string manipulation routines are given with the next two
requests.

 -- Request: .substring str n1 [n2]
     Replace the string named STR with the substring defined by the
     indices N1 and N2.  The first character in the string has index 0.
     If N2 is omitted, it is implicitly set to the largest valid value
     (the string length minus one).  If the index value N1 or N2 is
     negative, it is counted from the end of the string, going
     backwards: The last character has index -1, the character before
     the last character has index -2, etc.

          .ds xxx abcdefgh
          .substring xxx 1 -4
          \*[xxx]
              => bcde
          .substring xxx 2
          \*[xxx]
              => de

 -- Request: .length reg str
     Compute the number of characters of STR and return it in the number
     register REG.  If REG doesn't exist, it is created.  'str' is read
     in copy mode.

          .ds xxx abcd\h'3i'efgh
          .length yyy \*[xxx]
          \n[yyy]
              => 14

 -- Request: .rn xx yy
     Rename the request, macro, diversion, or string XX to YY.

 -- Request: .rm xx
     Remove the request, macro, diversion, or string XX.  'gtroff'
     treats subsequent invocations as if the object had never been
     defined.

 -- Request: .als new old
     Create an alias named NEW for the request, string, macro, or
     diversion object named OLD.  The new name and the old name are
     exactly equivalent (it is similar to a hard rather than a soft
     link).  If OLD is undefined, 'gtroff' generates a warning of type
     'mac' and ignores the request.

     To understand how the 'als' request works it is probably best to
     think of two different pools: one pool for objects (macros,
     strings, etc.), and another one for names.  As soon as an object is
     defined, 'gtroff' adds it to the object pool, adds its name to the
     name pool, and creates a link between them.  When 'als' creates an
     alias, it adds a new name to the name pool that gets linked to the
     same object as the old name.

     Now consider this example.

          .de foo
          ..
          .
          .als bar foo
          .
          .de bar
          .  foo
          ..
          .
          .bar
              => input stack limit exceeded

     The definition of macro 'bar' replaces the old object this name is
     linked to.  However, the alias to 'foo' is still active!  In other
     words, 'foo' is still linked to the same object as 'bar', and the
     result of calling 'bar' is an infinite, recursive loop that finally
     leads to an error.

     To undo an alias, simply call 'rm' on the aliased name.  The object
     itself is not destroyed until there are no more aliases.

 -- Request: .chop xx
     Remove (chop) the last character from the macro, string, or
     diversion named XX.  This is useful for removing the newline from
     the end of diversions that are to be interpolated as strings.  This
     command can be used repeatedly; see *note Gtroff Internals::, for
     details on nodes inserted additionally by 'gtroff'.

   *Note Identifiers::, and *note Comments::.

Next: Writing Macros,  Prev: Strings,  Up: gtroff Reference

5.20 Conditionals and Loops
===========================

* Menu:

* Operators in Conditionals::
* if-else::
* while::

Next: if-else,  Prev: Conditionals and Loops,  Up: Conditionals and Loops

5.20.1 Operators in Conditionals
--------------------------------

In 'if', 'ie', and 'while' requests, in addition to ordinary *note
Expressions::, there are several more operators available:

'e'
'o'
     True if the current page is even or odd numbered (respectively).

'n'
     True if the document is being processed in nroff mode (i.e., the
     '.nroff' command has been issued).  *Note Troff and Nroff Mode::.

't'
     True if the document is being processed in troff mode (i.e., the
     '.troff' command has been issued).  *Note Troff and Nroff Mode::.

'v'
     Always false.  This condition is for compatibility with other
     'troff' versions only (identifying a '-Tversatec' device).

''XXX'YYY''
     True if the output produced by XXX is equal to the output produced
     by YYY.  Other characters can be used in place of the single
     quotes; the same set of delimiters as for the '\D' escape is used
     (*note Escapes::).  'gtroff' formats XXX and YYY in separate
     environments; after the comparison the resulting data is discarded.

          .ie "|"\fR|\fP" \
          true
          .el \
          false
              => true

     The resulting motions, glyph sizes, and fonts have to match,(1)
     (*note Operators in Conditionals-Footnote-1::) and not the
     individual motion, size, and font requests.  In the previous
     example, '|' and '\fR|\fP' both result in a roman '|' glyph with
     the same point size and at the same location on the page, so the
     strings are equal.  If '.ft I' had been added before the '.ie', the
     result would be "false" because (the first) '|' produces an italic
     '|' rather than a roman one.

     To compare strings without processing, surround the data with '\?'.

          .ie "\?|\?"\?\fR|\fP\?" \
          true
          .el \
          false
              => false

     Since data protected with '\?' is read in copy-in mode it is even
     possible to use incomplete input without causing an error.

          .ds a \[
          .ds b \[
          .ie '\?\*a\?'\?\*b\?' \
          true
          .el \
          false
              => true

'r XXX'
     True if there is a number register named XXX.

'd XXX'
     True if there is a string, macro, diversion, or request named XXX.

'm XXX'
     True if there is a color named XXX.

'c G'
     True if there is a glyph G available(2) (*note Operators in
     Conditionals-Footnote-2::); G is either an ASCII character or a
     special character ('\N'XXX'', '\(GG' or '\[GGG]'); the condition is
     also true if G has been defined by the 'char' request.

'F FONT'
     True if a font named FONT exists.  FONT is handled as if it was
     opened with the 'ft' request (this is, font translation and styles
     are applied), without actually mounting it.

     This test doesn't load the complete font but only its header to
     verify its validity.

'S STYLE'
     True if style STYLE has been registered.  Font translation is
     applied.

   Note that these operators can't be combined with other operators like
':' or '&'; only a leading '!' (without whitespace between the
exclamation mark and the operator) can be used to negate the result.

     .nr xxx 1
     .ie !r xxx \
     true
     .el \
     false
         => false

   A whitespace after '!' always evaluates to zero (this bizarre
behaviour is due to compatibility with UNIX 'troff').

     .nr xxx 1
     .ie ! r xxx \
     true
     .el \
     false
         => r xxx true

   It is possible to omit the whitespace before the argument to the 'r',
'd', and 'c' operators.

   *Note Expressions::.

Next: while,  Prev: Operators in Conditionals,  Up: Conditionals and Loops

5.20.2 if-else
--------------

'gtroff' has if-then-else constructs like other languages, although the
formatting can be painful.

 -- Request: .if expr anything

     Evaluate the expression EXPR, and executes ANYTHING (the remainder
     of the line) if EXPR evaluates to a value greater than zero (true).
     ANYTHING is interpreted as though it was on a line by itself
     (except that leading spaces are swallowed).  *Note Operators in
     Conditionals::, for more info.

          .nr xxx 1
          .nr yyy 2
          .if ((\n[xxx] == 1) & (\n[yyy] == 2)) true
              => true

 -- Request: .nop anything
     Executes ANYTHING.  This is similar to '.if 1'.

 -- Request: .ie expr anything
 -- Request: .el anything
     Use the 'ie' and 'el' requests to write an if-then-else.  The first
     request is the 'if' part and the latter is the 'else' part.

          .ie n .ls 2 \" double-spacing in nroff
          .el   .ls 1 \" single-spacing in troff

 -- Escape: \{
 -- Escape: \}
     In many cases, an if (or if-else) construct needs to execute more
     than one request.  This can be done using the escapes '\{' (which
     must start the first line) and '\}' (which must end the last line).

          .ie t \{\
          .    ds lq ``
          .    ds rq ''
          .\}
          .el \{\
          .    ds lq ""
          .    ds rq ""
          .\}

   *Note Expressions::.

Prev: if-else,  Up: Conditionals and Loops

5.20.3 while
------------

'gtroff' provides a looping construct using the 'while' request, which
is used much like the 'if' (and related) requests.

 -- Request: .while expr anything
     Evaluate the expression EXPR, and repeatedly execute ANYTHING (the
     remainder of the line) until EXPR evaluates to 0.

          .nr a 0 1
          .while (\na < 9) \{\
          \n+a,
          .\}
          \n+a
              => 1, 2, 3, 4, 5, 6, 7, 8, 9, 10

     Some remarks.

        * The body of a 'while' request is treated like the body of a
          'de' request: 'gtroff' temporarily stores it in a macro that
          is deleted after the loop has been exited.  It can
          considerably slow down a macro if the body of the 'while'
          request (within the macro) is large.  Each time the macro is
          executed, the 'while' body is parsed and stored again as a
          temporary macro.

               .de xxx
               .  nr num 10
               .  while (\\n[num] > 0) \{\
               .    \" many lines of code
               .    nr num -1
               .  \}
               ..

          The traditional and ofter better solution (UNIX 'troff'
          doesn't have the 'while' request) is to use a recursive macro
          instead that is parsed only once during its definition.

               .de yyy
               .  if (\\n[num] > 0) \{\
               .    \" many lines of code
               .    nr num -1
               .    yyy
               .  \}
               ..
               .
               .de xxx
               .  nr num 10
               .  yyy
               ..

          Note that the number of available recursion levels is set
          to 1000 (this is a compile-time constant value of 'gtroff').

        * The closing brace of a 'while' body must end a line.

               .if 1 \{\
               .  nr a 0 1
               .  while (\n[a] < 10) \{\
               .    nop \n+[a]
               .\}\}
                   => unbalanced \{ \}

 -- Request: .break
     Break out of a 'while' loop.  Be sure not to confuse this with the
     'br' request (causing a line break).

 -- Request: .continue
     Finish the current iteration of a 'while' loop, immediately
     restarting the next iteration.

   *Note Expressions::.

Next: Page Motions,  Prev: Conditionals and Loops,  Up: gtroff Reference

5.21 Writing Macros
===================

A "macro" is a collection of text and embedded commands that can be
invoked multiple times.  Use macros to define common operations.  *Note
Strings::, for a (limited) alternative syntax to call macros.

   Although the following requests can be used to create macros, simply
using an undefined macro will cause it to be defined as empty.  *Note
Identifiers::.

 -- Request: .de name [end]
 -- Request: .de1 name [end]
 -- Request: .dei name [end]
 -- Request: .dei1 name [end]
     Define a new macro named NAME.  'gtroff' copies subsequent lines
     (starting with the next one) into an internal buffer until it
     encounters the line '..' (two dots).  If the optional second
     argument to 'de' is present it is used as the macro closure request
     instead of '..'.

     There can be whitespace after the first dot in the line containing
     the ending token (either '.' or macro 'END').  Don't insert a tab
     character immediately after the '..', otherwise it isn't recognized
     as the end-of-macro symbol.(1)  (*note Writing Macros-Footnote-1::)

     Here a small example macro called 'P' that causes a break and
     inserts some vertical space.  It could be used to separate
     paragraphs.

          .de P
          .  br
          .  sp .8v
          ..

     The following example defines a macro within another.  Remember
     that expansion must be protected twice; once for reading the macro
     and once for executing.

          \# a dummy macro to avoid a warning
          .de end
          ..
          .
          .de foo
          .  de bar end
          .    nop \f[B]Hallo \\\\$1!\f[]
          .  end
          ..
          .
          .foo
          .bar Joe
              => Hallo Joe!

     Since '\f' has no expansion, it isn't necessary to protect its
     backslash.  Had we defined another macro within 'bar' that takes a
     parameter, eight backslashes would be necessary before '$1'.

     The 'de1' request turns off compatibility mode while executing the
     macro.  On entry, the current compatibility mode is saved and
     restored at exit.

          .nr xxx 12345
          .
          .de aa
          The value of xxx is \\n[xxx].
          ..
          .de1 bb
          The value of xxx ix \\n[xxx].
          ..
          .
          .cp 1
          .
          .aa
              => warning: number register `[' not defined
              => The value of xxx is 0xxx].
          .bb
              => The value of xxx ix 12345.

     The 'dei' request defines a macro indirectly.  That is, it expands
     strings whose names are NAME or END before performing the append.

     This:

          .ds xx aa
          .ds yy bb
          .dei xx yy

     is equivalent to:

          .de aa bb

     The 'dei1' request is similar to 'dei' but with compatibility mode
     switched off during execution of the defined macro.

     If compatibility mode is on, 'de' (and 'dei') behave similar to
     'de1' (and 'dei1'): A 'compatibility save' token is inserted at the
     beginning, and a 'compatibility restore' token at the end, with
     compatibility mode switched on during execution.  *Note Gtroff
     Internals::, for more information on switching compatibility mode
     on and off in a single document.

     Using 'trace.tmac', you can trace calls to 'de' and 'de1'.

     Note that macro identifiers are shared with identifiers for strings
     and diversions.

     *Note the description of the 'als' request: als, for possible
     pitfalls if redefining a macro that has been aliased.

 -- Request: .am name [end]
 -- Request: .am1 name [end]
 -- Request: .ami name [end]
 -- Request: .ami1 name [end]
     Works similarly to 'de' except it appends onto the macro named
     NAME.  So, to make the previously defined 'P' macro actually do
     indented instead of block paragraphs, add the necessary code to the
     existing macro like this:

          .am P
          .ti +5n
          ..

     The 'am1' request turns off compatibility mode while executing the
     appended macro piece.  To be more precise, a "compatibility save"
     input token is inserted at the beginning of the appended code, and
     a "compatibility restore" input token at the end.

     The 'ami' request appends indirectly, meaning that 'gtroff' expands
     strings whose names are NAME or END before performing the append.

     The 'ami1' request is similar to 'ami' but compatibility mode is
     switched off during execution of the defined macro.

     Using 'trace.tmac', you can trace calls to 'am' and 'am1'.

   *Note Strings::, for the 'als' and 'rn' request to create an alias
and rename a macro, respectively.

   The 'de', 'am', 'di', 'da', 'ds', and 'as' requests (together with
its variants) only create a new object if the name of the macro,
diversion or string diversion is currently undefined or if it is defined
to be a request; normally they modify the value of an existing object.

 -- Request: .return [anything]
     Exit a macro, immediately returning to the caller.

     If called with an argument, exit twice, namely the current macro
     and the macro one level higher.  This is used to define a wrapper
     macro for 'return' in 'trace.tmac'.

* Menu:

* Copy-in Mode::
* Parameters::

Next: Parameters,  Prev: Writing Macros,  Up: Writing Macros

5.21.1 Copy-in Mode
-------------------

When 'gtroff' reads in the text for a macro, string, or diversion, it
copies the text (including request lines, but excluding escapes) into an
internal buffer.  Escapes are converted into an internal form, except
for '\n', '\$', '\*', '\\' and '\<RET>', which are evaluated and
inserted into the text where the escape was located.  This is known as
"copy-in" mode or "copy" mode.

   What this means is that you can specify when these escapes are to be
evaluated (either at copy-in time or at the time of use) by insulating
the escapes with an extra backslash.  Compare this to the '\def' and
'\edef' commands in TeX.

   The following example prints the numbers 20 and 10:

     .nr x 20
     .de y
     .nr x 10
     \&\nx
     \&\\nx
     ..
     .y

Prev: Copy-in Mode,  Up: Writing Macros

5.21.2 Parameters
-----------------

The arguments to a macro or string can be examined using a variety of
escapes.

 -- Register: \n[.$]
     The number of arguments passed to a macro or string.  This is a
     read-only number register.

     Note that the 'shift' request can change its value.

   Any individual argument can be retrieved with one of the following
escapes:

 -- Escape: \$n
 -- Escape: \$(nn
 -- Escape: \$[nnn]
     Retrieve the Nth, NNth or NNNth argument.  As usual, the first form
     only accepts a single number (larger than zero), the second a
     two-digit number (larger or equal to 10), and the third any
     positive integer value (larger than zero).  Macros and strings can
     have an unlimited number of arguments.  Note that due to copy-in
     mode, use two backslashes on these in actual use to prevent
     interpolation until the macro is actually invoked.

 -- Request: .shift [n]
     Shift the arguments 1 position, or as many positions as specified
     by its argument.  After executing this request, argument I becomes
     argument I-N; arguments 1 to N are no longer available.  Shifting
     by negative amounts is currently undefined.

     The register '.$' is adjusted accordingly.

 -- Escape: \$*
 -- Escape: \$@
     In some cases it is convenient to use all of the arguments at once
     (for example, to pass the arguments along to another macro).  The
     '\$*' escape concatenates all the arguments separated by spaces.  A
     similar escape is '\$@', which concatenates all the arguments with
     each surrounded by double quotes, and separated by spaces.  If not
     in compatibility mode, the input level of double quotes is
     preserved (see *note Request and Macro Arguments::).

 -- Escape: \$^
     Handle the parameters of a macro as if they were an argument to the
     'ds' or similar requests.

          .de foo
          .  tm $1=`\\$1'
          .  tm $2=`\\$2'
          .  tm $*=`\\$*'
          .  tm $@=`\\$@'
          .  tm $^=`\\$^'
          ..
          .foo " This is a "test"
              => $1=` This is a '
              => $2=`test"'
              => $*=` This is a  test"'
              => $@=`" This is a " "test""'
              => $^=`" This is a "test"'

     This escape is useful mainly for macro packages like 'trace.tmac',
     which redefines some requests and macros for debugging purposes.

 -- Escape: \$0
     The name used to invoke the current macro.  The 'als' request can
     make a macro have more than one name.

     If a macro is called as a string (within another macro), the value
     of '\$0' isn't changed.

          .de foo
          .  tm \\$0
          ..
          .als foo bar
          .
          .de aaa
          .  foo
          ..
          .de bbb
          .  bar
          ..
          .de ccc
          \\*[foo]\\
          ..
          .de ddd
          \\*[bar]\\
          ..
          .
          .aaa
              => foo
          .bbb
              => bar
          .ccc
              => ccc
          .ddd
              => ddd

   *Note Request and Macro Arguments::.

Next: Drawing Requests,  Prev: Writing Macros,  Up: gtroff Reference

5.22 Page Motions
=================

*Note Manipulating Spacing::, for a discussion of the main request for
vertical motion, 'sp'.

 -- Request: .mk [reg]
 -- Request: .rt [dist]
     The request 'mk' can be used to mark a location on a page, for
     movement to later.  This request takes a register name as an
     argument in which to store the current page location.  With no
     argument it stores the location in an internal register.  The
     results of this can be used later by the 'rt' or the 'sp' request
     (or the '\v' escape).

     The 'rt' request returns _upwards_ to the location marked with the
     last 'mk' request.  If used with an argument, return to a position
     which distance from the top of the page is DIST (no previous call
     to 'mk' is necessary in this case).  Default scaling indicator is
     'v'.

     Here a primitive solution for a two-column macro.

          .nr column-length 1.5i
          .nr column-gap 4m
          .nr bottom-margin 1m
          .
          .de 2c
          .  br
          .  mk
          .  ll \\n[column-length]u
          .  wh -\\n[bottom-margin]u 2c-trap
          .  nr right-side 0
          ..
          .
          .de 2c-trap
          .  ie \\n[right-side] \{\
          .    nr right-side 0
          .    po -(\\n[column-length]u + \\n[column-gap]u)
          .    \" remove trap
          .    wh -\\n[bottom-margin]u
          .  \}
          .  el \{\
          .    \" switch to right side
          .    nr right-side 1
          .    po +(\\n[column-length]u + \\n[column-gap]u)
          .    rt
          .  \}
          ..
          .
          .pl 1.5i
          .ll 4i
          This is a small test that shows how the
          rt request works in combination with mk.

          .2c
          Starting here, text is typeset in two columns.
          Note that this implementation isn't robust
          and thus not suited for a real two-column
          macro.

     Result:

          This is a small test that shows how the
          rt request works in combination with mk.

          Starting  here,    isn't    robust
          text is typeset    and   thus  not
          in two columns.    suited  for   a
          Note that  this    real two-column
          implementation     macro.

   The following escapes give fine control of movements about the page.

 -- Escape: \v'e'
     Move vertically, usually from the current location on the page (if
     no absolute position operator '|' is used).  The argument E
     specifies the distance to move; positive is downwards and negative
     upwards.  The default scaling indicator for this escape is 'v'.
     Beware, however, that 'gtroff' continues text processing at the
     point where the motion ends, so you should always balance motions
     to avoid interference with text processing.

     '\v' doesn't trigger a trap.  This can be quite useful; for
     example, consider a page bottom trap macro that prints a marker in
     the margin to indicate continuation of a footnote or something
     similar.

   There are some special-case escapes for vertical motion.

 -- Escape: \r
     Move upwards 1v.

 -- Escape: \u
     Move upwards .5v.

 -- Escape: \d
     Move down .5v.

 -- Escape: \h'e'
     Move horizontally, usually from the current location (if no
     absolute position operator '|' is used).  The expression E
     indicates how far to move: positive is rightwards and negative
     leftwards.  The default scaling indicator for this escape is 'm'.

     This horizontal space is not discarded at the end of a line.  To
     insert discardable space of a certain length use the 'ss' request.

   There are a number of special-case escapes for horizontal motion.

 -- Escape: \<SP>
     An unbreakable and unpaddable (i.e. not expanded during filling)
     space.  (Note: This is a backslash followed by a space.)

 -- Escape: \~
     An unbreakable space that stretches like a normal inter-word space
     when a line is adjusted.

 -- Escape: \|
     A 1/6th em space.  Ignored for TTY output devices (rounded to
     zero).

     However, if there is a glyph defined in the current font file with
     name '\|' (note the leading backslash), the width of this glyph is
     used instead (even for TTYs).

 -- Escape: \^
     A 1/12th em space.  Ignored for TTY output devices (rounded to
     zero).

     However, if there is a glyph defined in the current font file with
     name '\^' (note the leading backslash), the width of this glyph is
     used instead (even for TTYs).

 -- Escape: \0
     A space the size of a digit.

   The following string sets the TeX logo:

     .ds TeX T\h'-.1667m'\v'.224m'E\v'-.224m'\h'-.125m'X

 -- Escape: \w'text'
 -- Register: \n[st]
 -- Register: \n[sb]
 -- Register: \n[rst]
 -- Register: \n[rsb]
 -- Register: \n[ct]
 -- Register: \n[ssc]
 -- Register: \n[skw]
     Return the width of the specified TEXT in basic units.  This allows
     horizontal movement based on the width of some arbitrary text (e.g.
     given as an argument to a macro).

          The length of the string `abc' is \w'abc'u.
              => The length of the string `abc' is 72u.

     Font changes may occur in TEXT, which don't affect current
     settings.

     After use, '\w' sets several registers:

     'st'
     'sb'
          The highest and lowest point of the baseline, respectively, in
          TEXT.

     'rst'
     'rsb'
          Like the 'st' and 'sb' registers, but takes account of the
          heights and depths of glyphs.  In other words, this gives the
          highest and lowest point of TEXT.  Values below the baseline
          are negative.

     'ct'
          Defines the kinds of glyphs occurring in TEXT:

          0
               only short glyphs, no descenders or tall glyphs.

          1
               at least one descender.

          2
               at least one tall glyph.

          3
               at least one each of a descender and a tall glyph.

     'ssc'
          The amount of horizontal space (possibly negative) that should
          be added to the last glyph before a subscript.

     'skw'
          How far to right of the center of the last glyph in the '\w'
          argument, the center of an accent from a roman font should be
          placed over that glyph.

 -- Escape: \kp
 -- Escape: \k(ps
 -- Escape: \k[position]
     Store the current horizontal position in the _input_ line in number
     register with name POSITION (one-character name P, two-character
     name PS).  Use this, for example, to return to the beginning of a
     string for highlighting or other decoration.

 -- Register: \n[hp]
     The current horizontal position at the input line.

 -- Register: \n[.k]
     A read-only number register containing the current horizontal
     output position (relative to the current indentation).

 -- Escape: \o'abc'
     Overstrike glyphs A, B, C, ...; the glyphs are centered, and the
     resulting spacing is the largest width of the affected glyphs.

 -- Escape: \zg
     Print glyph G with zero width, i.e., without spacing.  Use this to
     overstrike glyphs left-aligned.

 -- Escape: \Z'anything'
     Print ANYTHING, then restore the horizontal and vertical position.
     The argument may not contain tabs or leaders.

     The following is an example of a strike-through macro:

          .de ST
          .nr ww \w'\\$1'
          \Z@\v'-.25m'\l'\\n[ww]u'@\\$1
          ..
          .
          This is
          .ST "a test"
          an actual emergency!

Next: Traps,  Prev: Page Motions,  Up: gtroff Reference

5.23 Drawing Requests
=====================

'gtroff' provides a number of ways to draw lines and other figures on
the page.  Used in combination with the page motion commands (see *note
Page Motions::, for more info), a wide variety of figures can be drawn.
However, for complex drawings these operations can be quite cumbersome,
and it may be wise to use graphic preprocessors like 'gpic' or 'ggrn'.
*Note gpic::, and *note ggrn::, for more information.

   All drawing is done via escapes.

 -- Escape: \l'l'
 -- Escape: \l'lg'
     Draw a line horizontally.  L is the length of the line to be drawn.
     If it is positive, start the line at the current location and draw
     to the right; its end point is the new current location.  Negative
     values are handled differently: The line starts at the current
     location and draws to the left, but the current location doesn't
     move.

     L can also be specified absolutely (i.e. with a leading '|'), which
     draws back to the beginning of the input line.  Default scaling
     indicator is 'm'.

     The optional second parameter G is a glyph to draw the line with.
     If this second argument is not specified, 'gtroff' uses the
     underscore glyph, '\[ru]'.

     To separate the two arguments (to prevent 'gtroff' from
     interpreting a drawing glyph as a scaling indicator if the glyph is
     represented by a single character) use '\&'.

     Here a small useful example:

          .de box
          \[br]\\$*\[br]\l'|0\[rn]'\l'|0\[ul]'
          ..

     Note that this works by outputting a box rule (a vertical line),
     then the text given as an argument and then another box rule.
     Finally, the line drawing escapes both draw from the current
     location to the beginning of the _input_ line - this works because
     the line length is negative, not moving the current point.

 -- Escape: \L'l'
 -- Escape: \L'lg'
     Draw vertical lines.  Its parameters are similar to the '\l'
     escape, except that the default scaling indicator is 'v'.  The
     movement is downwards for positive values, and upwards for negative
     values.  The default glyph is the box rule glyph, '\[br]'.  As with
     the vertical motion escapes, text processing blindly continues
     where the line ends.

          This is a \L'3v'test.

     Here the result, produced with 'grotty'.

          This is a
                    |
                    |
                    |test.

 -- Escape: \D'command arg ...'
     The '\D' escape provides a variety of drawing functions.  Note that
     on character devices, only vertical and horizontal lines are
     supported within 'grotty'; other devices may only support a subset
     of the available drawing functions.

     The default scaling indicator for all subcommands of '\D' is 'm'
     for horizontal distances and 'v' for vertical ones.  Exceptions are
     '\D'f ...'' and '\D't ...'', which use 'u' as the default, and
     '\D'FX ...'', which arguments are treated similar to the 'defcolor'
     request.

     '\D'l DX DY''
          Draw a line from the current location to the relative point
          specified by (DX,DY), where positive values mean down and
          right, respectively.  The end point of the line is the new
          current location.

          The following example is a macro for creating a box around a
          text string; for simplicity, the box margin is taken as a
          fixed value, 0.2m.

               .de BOX
               .  nr @wd \w'\\$1'
               \h'.2m'\
               \h'-.2m'\v'(.2m - \\n[rsb]u)'\
               \D'l 0 -(\\n[rst]u - \\n[rsb]u + .4m)'\
               \D'l (\\n[@wd]u + .4m) 0'\
               \D'l 0 (\\n[rst]u - \\n[rsb]u + .4m)'\
               \D'l -(\\n[@wd]u + .4m) 0'\
               \h'.2m'\v'-(.2m - \\n[rsb]u)'\
               \\$1\
               \h'.2m'
               ..

          First, the width of the string is stored in register '@wd'.
          Then, four lines are drawn to form a box, properly offset by
          the box margin.  The registers 'rst' and 'rsb' are set by the
          '\w' escape, containing the largest height and depth of the
          whole string.

     '\D'c D''
          Draw a circle with a diameter of D with the leftmost point at
          the current position.  After drawing, the current location is
          positioned at the rightmost point of the circle.

     '\D'C D''
          Draw a solid circle with the same parameters and behaviour as
          an outlined circle.  No outline is drawn.

     '\D'e X Y''
          Draw an ellipse with a horizontal diameter of X and a vertical
          diameter of Y with the leftmost point at the current position.
          After drawing, the current location is positioned at the
          rightmost point of the ellipse.

     '\D'E X Y''
          Draw a solid ellipse with the same parameters and behaviour as
          an outlined ellipse.  No outline is drawn.

     '\D'a DX1 DY1 DX2 DY2''
          Draw an arc clockwise from the current location through the
          two specified relative locations (DX1,DY1) and (DX2,DY2).  The
          coordinates of the first point are relative to the current
          position, and the coordinates of the second point are relative
          to the first point.  After drawing, the current position is
          moved to the final point of the arc.

     '\D'~ DX1 DY1 DX2 DY2 ...''
          Draw a spline from the current location to the relative point
          (DX1,DY1) and then to (DX2,DY2), and so on.  The current
          position is moved to the terminal point of the drawn curve.

     '\D'f N''
          Set the shade of gray to be used for filling solid objects
          to N; N must be an integer between 0 and 1000, where 0
          corresponds solid white and 1000 to solid black, and values in
          between correspond to intermediate shades of gray.  This
          applies only to solid circles, solid ellipses, and solid
          polygons.  By default, a level of 1000 is used.

          Despite of being silly, the current point is moved
          horizontally to the right by N.

          Don't use this command!  It has the serious drawback that it
          is always rounded to the next integer multiple of the
          horizontal resolution (the value of the 'hor' keyword in the
          'DESC' file).  Use '\M' (*note Colors::) or '\D'Fg ...''
          instead.

     '\D'p DX1 DY1 DX2 DY2 ...''
          Draw a polygon from the current location to the relative
          position (DX1,DY1) and then to (DX2,DY2) and so on.  When the
          specified data points are exhausted, a line is drawn back to
          the starting point.  The current position is changed by adding
          the sum of all arguments with odd index to the actual
          horizontal position and the even ones to the vertical
          position.

     '\D'P DX1 DY1 DX2 DY2 ...''
          Draw a solid polygon with the same parameters and behaviour as
          an outlined polygon.  No outline is drawn.

          Here a better variant of the box macro to fill the box with
          some color.  Note that the box must be drawn before the text
          since colors in 'gtroff' are not transparent; the filled
          polygon would hide the text completely.

               .de BOX
               .  nr @wd \w'\\$1'
               \h'.2m'\
               \h'-.2m'\v'(.2m - \\n[rsb]u)'\
               \M[lightcyan]\
               \D'P 0 -(\\n[rst]u - \\n[rsb]u + .4m) \
                    (\\n[@wd]u + .4m) 0 \
                    0 (\\n[rst]u - \\n[rsb]u + .4m) \
                    -(\\n[@wd]u + .4m) 0'\
               \h'.2m'\v'-(.2m - \\n[rsb]u)'\
               \M[]\
               \\$1\
               \h'.2m'
               ..

          If you want a filled polygon that has exactly the same size as
          an unfilled one, you must draw both an unfilled and a filled
          polygon.  A filled polygon is always smaller than an unfilled
          one because the latter uses straight lines with a given line
          thickness to connect the polygon's corners, while the former
          simply fills the area defined by the coordinates.

               \h'1i'\v'1i'\
               \# increase line thickness
               \Z'\D't 5p''\
               \# draw unfilled polygon
               \Z'\D'p 3 3 -6 0''\
               \# draw filled polygon
               \Z'\D'P 3 3 -6 0''

     '\D't N''
          Set the current line thickness to N machine units.  A value of
          zero selects the smallest available line thickness.  A
          negative value makes the line thickness proportional to the
          current point size (this is the default behaviour of AT&T
          'troff').

          Despite of being silly, the current point is moved
          horizontally to the right by N.

     '\D'FSCHEME COLOR_COMPONENTS''
          Change current fill color.  SCHEME is a single letter denoting
          the color scheme: 'r' (rgb), 'c' (cmy), 'k' (cmyk), 'g'
          (gray), or 'd' (default color).  The color components use
          exactly the same syntax as in the 'defcolor' request (*note
          Colors::); the command '\D'Fd'' doesn't take an argument.

          _No_ position changing!

          Examples:

               \D'Fg .3'      \" same gray as \D'f 700'
               \D'Fr #0000ff' \" blue

   *Note Graphics Commands::.

 -- Escape: \b'string'
     "Pile" a sequence of glyphs vertically, and center it vertically on
     the current line.  Use it to build large brackets and braces.

     Here an example how to create a large opening brace:

          \b'\[lt]\[bv]\[lk]\[bv]\[lb]'

     The first glyph is on the top, the last glyph in STRING is at the
     bottom.  Note that 'gtroff' separates the glyphs vertically by 1m,
     and the whole object is centered 0.5m above the current baseline;
     the largest glyph width is used as the width for the whole object.
     This rather unflexible positioning algorithm doesn't work with
     '-Tdvi' since the bracket pieces vary in height for this device.
     Instead, use the 'eqn' preprocessor.

     *Note Manipulating Spacing::, how to adjust the vertical spacing
     with the '\x' escape.

Next: Diversions,  Prev: Drawing Requests,  Up: gtroff Reference

5.24 Traps
==========

"Traps" are locations that, when reached, call a specified macro.  These
traps can occur at a given location on the page, at a given location in
the current diversion, at a blank line, after a certain number of input
lines, or at the end of input.

   Setting a trap is also called "planting".  It is also said that a
trap is "sprung" if the associated macro is executed.

* Menu:

* Page Location Traps::
* Diversion Traps::
* Input Line Traps::
* Blank Line Traps::
* Leading Spaces Traps::
* End-of-input Traps::

Next: Diversion Traps,  Prev: Traps,  Up: Traps

5.24.1 Page Location Traps
--------------------------

"Page location traps" perform an action when 'gtroff' reaches or passes
a certain vertical location on the page.  Page location traps have a
variety of purposes, including:

   * setting headers and footers

   * setting body text in multiple columns

   * setting footnotes

 -- Request: .vpt flag
 -- Register: \n[.vpt]
     Enable vertical position traps if FLAG is non-zero, or disables
     them otherwise.  Vertical position traps are traps set by the 'wh'
     or 'dt' requests.  Traps set by the 'it' request are not vertical
     position traps.  The parameter that controls whether vertical
     position traps are enabled is global.  Initially vertical position
     traps are enabled.  The current setting of this is available in the
     '.vpt' read-only number register.

     Note that a page can't be ejected if 'vpt' is set to zero.

 -- Request: .wh dist [macro]
     Set a page location trap.  Non-negative values for DIST set the
     trap relative to the top of the page; negative values set the trap
     relative to the bottom of the page.  Default scaling indicator is
     'v'; values of DIST are always rounded to be multiples of the
     vertical resolution (as given in register '.V').

     MACRO is the name of the macro to execute when the trap is sprung.
     If MACRO is missing, remove the first trap (if any) at DIST.

     The following is a simple example of how many macro packages set
     headers and footers.

          .de hd                \" Page header
          '  sp .5i
          .  tl 'Title''date'
          '  sp .3i
          ..
          .
          .de fo                \" Page footer
          '  sp 1v
          .  tl ''%''
          '  bp
          ..
          .
          .wh 0   hd            \" trap at top of the page
          .wh -1i fo            \" trap one inch from bottom

     A trap at or below the bottom of the page is ignored; it can be
     made active by either moving it up or increasing the page length so
     that the trap is on the page.

     Negative trap values always use the _current_ page length; they are
     not converted to an absolute vertical position:

          .pl 5i
          .wh -1i xx
          .ptr
              => xx      -240
          .pl 100i
          .ptr
              => xx      -240

     It is possible to have more than one trap at the same location; to
     do so, the traps must be defined at different locations, then moved
     together with the 'ch' request; otherwise the second trap would
     replace the first one.  Earlier defined traps hide later defined
     traps if moved to the same position (the many empty lines caused by
     the 'bp' request are omitted in the following example):

          .de a
          .  nop a
          ..
          .de b
          .  nop b
          ..
          .de c
          .  nop c
          ..
          .
          .wh 1i a
          .wh 2i b
          .wh 3i c
          .bp
              => a b c
          .ch b 1i
          .ch c 1i
          .bp
              => a
          .ch a 0.5i
          .bp
              => a b

 -- Register: \n[.t]
     A read-only number register holding the distance to the next trap.

     If there are no traps between the current position and the bottom
     of the page, it contains the distance to the page bottom.  In a
     diversion, the distance to the page bottom is infinite (the
     returned value is the biggest integer that can be represented in
     'groff') if there are no diversion traps.

 -- Request: .ch macro [dist]
     Change the location of a trap.  The first argument is the name of
     the macro to be invoked at the trap, and the second argument is the
     new location for the trap (note that the parameters are specified
     in opposite order as in the 'wh' request).  This is useful for
     building up footnotes in a diversion to allow more space at the
     bottom of the page for them.

     Default scaling indicator for DIST is 'v'.  If DIST is missing, the
     trap is removed.

 -- Register: \n[.ne]
     The read-only number register '.ne' contains the amount of space
     that was needed in the last 'ne' request that caused a trap to be
     sprung.  Useful in conjunction with the '.trunc' register.  *Note
     Page Control::, for more information.

     Since the '.ne' register is only set by traps it doesn't make much
     sense to use it outside of trap macros.

 -- Register: \n[.trunc]
     A read-only register containing the amount of vertical space
     truncated by the most recently sprung vertical position trap, or,
     if the trap was sprung by an 'ne' request, minus the amount of
     vertical motion produced by the 'ne' request.  In other words, at
     the point a trap is sprung, it represents the difference of what
     the vertical position would have been but for the trap, and what
     the vertical position actually is.

     Since the '.trunc' register is only set by traps it doesn't make
     much sense to use it outside of trap macros.

 -- Register: \n[.pe]
     A read-only register that is set to 1 while a page is ejected with
     the 'bp' request (or by the end of input).

     Outside of traps this register is always zero.  In the following
     example, only the second call to 'x' is caused by 'bp'.

          .de x
          \&.pe=\\n[.pe]
          .br
          ..
          .wh 1v x
          .wh 4v x
          A line.
          .br
          Another line.
          .br
              => A line.
                 .pe=0
                 Another line.

                 .pe=1

   An important fact to consider while designing macros is that
diversions and traps do not interact normally.  For example, if a trap
invokes a header macro (while outputting a diversion) that tries to
change the font on the current page, the effect is not visible before
the diversion has completely been printed (except for input protected
with '\!' or '\?') since the data in the diversion is already formatted.
In most cases, this is not the expected behaviour.

Next: Input Line Traps,  Prev: Page Location Traps,  Up: Traps

5.24.2 Diversion Traps
----------------------

 -- Request: .dt [dist macro]
     Set a trap _within_ a diversion.  DIST is the location of the trap
     (identical to the 'wh' request; default scaling indicator is 'v')
     and MACRO is the name of the macro to be invoked.  If called
     without arguments, the diversion trap is removed.

     Note that there exists only a single diversion trap.

     The number register '.t' still works within diversions.  *Note
     Diversions::, for more information.

Next: Blank Line Traps,  Prev: Diversion Traps,  Up: Traps

5.24.3 Input Line Traps
-----------------------

 -- Request: .it n macro
 -- Request: .itc n macro
     Set an input line trap.  N is the number of lines of input that may
     be read before springing the trap, MACRO is the macro to be
     invoked.  Request lines are not counted as input lines.

     For example, one possible use is to have a macro that prints the
     next N lines in a bold font.

          .de B
          .  it \\$1 B-end
          .  ft B
          ..
          .
          .de B-end
          .  ft R
          ..

     The 'itc' request is identical except that an interrupted text line
     (ending with '\c') is not counted as a separate line.

     Both requests are associated with the current environment (*note
     Environments::); switching to another environment disables the
     current input trap, and going back reactivates it, restoring the
     number of already processed lines.

Next: Leading Spaces Traps,  Prev: Input Line Traps,  Up: Traps

5.24.4 Blank Line Traps
-----------------------

 -- Request: .blm macro
     Set a blank line trap.  'gtroff' executes MACRO when it encounters
     a blank line in the input file.

Next: End-of-input Traps,  Prev: Blank Line Traps,  Up: Traps

5.24.5 Leading Spaces Traps
---------------------------

 -- Request: .lsm macro
 -- Register: \n[lsn]
 -- Register: \n[lss]
     Set a leading spaces trap.  'gtroff' executes MACRO when it
     encounters leading spaces in an input line; the implicit line break
     that normally happens in this case is suppressed.  A line
     consisting of spaces only, however, is treated as an empty line,
     possibly subject to an empty line macro set with the 'blm' request.

     Leading spaces are removed from the input line before calling the
     leading spaces macro.  The number of removed spaces is stored in
     register 'lsn'; the horizontal space that would be emitted if there
     was no leading space macro is stored in register 'lss'.  Note that
     'lsn' and 'lss' are available even if no leading space macro has
     been set.

     The first thing a leading space macro sees is a token.  However,
     some escapes like '\f' or '\m' are handled on the fly (see *note
     Gtroff Internals::, for a complete list) without creating a token
     at all.  Consider that a line starts with two spaces followed by
     '\fIfoo'.  While skipping the spaces '\fI' is handled too so that
     groff's current font is properly set to 'I', but the leading space
     macro only sees 'foo', without the preceding '\fI'.  If the macro
     should see the font escape you have to 'protect' it with something
     that creates a token, for example with '\&\fIfoo'.

Prev: Leading Spaces Traps,  Up: Traps

5.24.6 End-of-input Traps
-------------------------

 -- Request: .em macro
     Set a trap at the end of input.  MACRO is executed after the last
     line of the input file has been processed.

     For example, if the document had to have a section at the bottom of
     the last page for someone to approve it, the 'em' request could be
     used.

          .de approval
          \c
          .  ne 3v
          .  sp (\\n[.t]u - 3v)
          .  in +4i
          .  lc _
          .  br
          Approved:\t\a
          .  sp
          Date:\t\t\a
          ..
          .
          .em approval

     The '\c' in the above example needs explanation.  For historical
     reasons (and for compatibility with AT&T 'troff'), the end macro
     exits as soon as it causes a page break and no remaining data is in
     the partially collected line.

     Let us assume that there is no '\c' in the above 'approval' macro,
     and that the page is full and has been ended with, say, a 'br'
     request.  The 'ne' request now causes the start of a new page,
     which in turn makes 'troff' exit immediately for the reasons just
     described.  In most situations this is not intended.

     To always force processing the whole end macro independently of
     this behaviour it is thus advisable to insert something that starts
     an empty partially filled line ('\c') whenever there is a chance
     that a page break can happen.  In the above example, the call of
     the 'ne' request assures that the remaining code stays on the same
     page, so we have to insert '\c' only once.

     The next example shows how to append three lines, then starting a
     new page unconditionally.  Since '.ne 1' doesn't give the desired
     effect - there is always one line available or we are already at
     the beginning of the next page - we temporarily increase the page
     length by one line so that we can use '.ne 2'.

          .de EM
          .pl +1v
          \c
          .ne 2
          line one
          .br
          \c
          .ne 2
          line two
          .br
          \c
          .ne 2
          line three
          .br
          .pl -1v
          \c
          'bp
          ..
          .em EM

     Note that this specific feature affects only the first potential
     page break caused by the end macro; further page breaks emitted by
     the end macro are handled normally.

     Another possible use of the 'em' request is to make 'gtroff' emit a
     single large page instead of multiple pages.  For example, one may
     want to produce a long plain-text file for reading on-screen.  The
     idea is to set the page length at the beginning of the document to
     a very large value to hold all the text, and automatically adjust
     it to the exact height of the document after the text has been
     output.

          .de adjust-page-length
          .  br
          .  pl \\n[nl]u   \" \n[nl] holds the current page length
          ..
          .
          .de single-page-mode
          .  pl 99999
          .  em adjust-page-length
          ..
          .
          .\" activate the above code
          .single-page-mode

     Since only one end-of-input trap does exist and other macro
     packages may already use it, care must be taken not to break the
     mechanism.  A simple solution would be to append the above macro to
     the macro package's end-of-input macro using the '.am' request.

Next: Environments,  Prev: Traps,  Up: gtroff Reference

5.25 Diversions
===============

In 'gtroff' it is possible to "divert" text into a named storage area.
Due to the similarity to defining macros it is sometimes said to be
stored in a macro.  This is used for saving text for output at a later
time, which is useful for keeping blocks of text on the same page,
footnotes, tables of contents, and indices.

   For orthogonality it is said that 'gtroff' is in the "top-level
diversion" if no diversion is active (i.e., the data is diverted to the
output device).

   Although the following requests can be used to create diversions,
simply using an undefined diversion will cause it to be defined as
empty.  *Note Identifiers::.

 -- Request: .di macro
 -- Request: .da macro
     Begin a diversion.  Like the 'de' request, it takes an argument of
     a macro name to divert subsequent text into.  The 'da' macro
     appends to an existing diversion.

     'di' or 'da' without an argument ends the diversion.

     The current partially-filled line is included into the diversion.
     See the 'box' request below for an example.  Note that switching to
     another (empty) environment (with the 'ev' request) avoids the
     inclusion of the current partially-filled line.

 -- Request: .box macro
 -- Request: .boxa macro
     Begin (or append to) a diversion like the 'di' and 'da' requests.
     The difference is that 'box' and 'boxa' do not include a
     partially-filled line in the diversion.

     Compare this:

          Before the box.
          .box xxx
          In the box.
          .br
          .box
          After the box.
          .br
              => Before the box.  After the box.
          .xxx
              => In the box.

     with this:

          Before the diversion.
          .di yyy
          In the diversion.
          .br
          .di
          After the diversion.
          .br
              => After the diversion.
          .yyy
              => Before the diversion.  In the diversion.

     'box' or 'boxa' without an argument ends the diversion.

 -- Register: \n[.z]
 -- Register: \n[.d]
     Diversions may be nested.  The read-only number register '.z'
     contains the name of the current diversion (this is a string-valued
     register).  The read-only number register '.d' contains the current
     vertical place in the diversion.  If not in a diversion it is the
     same as register 'nl'.

 -- Register: \n[.h]
     The "high-water mark" on the current page.  It corresponds to the
     text baseline of the lowest line on the page.  This is a read-only
     register.

          .tm .h==\n[.h], nl==\n[nl]
              => .h==0, nl==-1
          This is a test.
          .br
          .sp 2
          .tm .h==\n[.h], nl==\n[nl]
              => .h==40, nl==120

     As can be seen in the previous example, empty lines are not
     considered in the return value of the '.h' register.

 -- Register: \n[dn]
 -- Register: \n[dl]
     After completing a diversion, the read-write number registers 'dn'
     and 'dl' contain the vertical and horizontal size of the diversion.
     Note that only the just processed lines are counted: For the
     computation of 'dn' and 'dl', the requests 'da' and 'boxa' are
     handled as if 'di' and 'box' had been used - lines that have been
     already stored in a macro are not taken into account.

          .\" Center text both horizontally & vertically
          .
          .\" Enclose macro definitions in .eo and .ec
          .\" to avoid the doubling of the backslash
          .eo
          .\" macro .(c starts centering mode
          .de (c
          .  br
          .  ev (c
          .  evc 0
          .  in 0
          .  nf
          .  di @c
          ..
          .\" macro .)c terminates centering mode
          .de )c
          .  br
          .  ev
          .  di
          .  nr @s (((\n[.t]u - \n[dn]u) / 2u) - 1v)
          .  sp \n[@s]u
          .  ce 1000
          .  @c
          .  ce 0
          .  sp \n[@s]u
          .  br
          .  fi
          .  rr @s
          .  rm @s
          .  rm @c
          ..
          .\" End of macro definitions, restore escape mechanism
          .ec

 -- Escape: \!
 -- Escape: \?anything\?
     Prevent requests, macros, and escapes from being interpreted when
     read into a diversion.  Both escapes take the given text and
     "transparently" embed it into the diversion.  This is useful for
     macros that shouldn't be invoked until the diverted text is
     actually output.

     The '\!' escape transparently embeds text up to and including the
     end of the line.  The '\?' escape transparently embeds text until
     the next occurrence of the '\?' escape.  Example:

          \?ANYTHING\?

     ANYTHING may not contain newlines; use '\!' to embed newlines in a
     diversion.  The escape sequence '\?' is also recognized in copy
     mode and turned into a single internal code; it is this code that
     terminates ANYTHING.  Thus the following example prints 4.

          .nr x 1
          .nf
          .di d
          \?\\?\\\\?\\\\\\\\nx\\\\?\\?\?
          .di
          .nr x 2
          .di e
          .d
          .di
          .nr x 3
          .di f
          .e
          .di
          .nr x 4
          .f

     Both escapes read the data in copy mode.

     If '\!' is used in the top-level diversion, its argument is
     directly embedded into the 'gtroff' intermediate output.  This can
     be used for example to control a postprocessor that processes the
     data before it is sent to the device driver.

     The '\?' escape used in the top-level diversion produces no output
     at all; its argument is simply ignored.

 -- Request: .output string
     Emit STRING directly to the 'gtroff' intermediate output (subject
     to copy mode interpretation); this is similar to '\!' used at the
     top level.  An initial double quote in STRING is stripped off to
     allow initial blanks.

     This request can't be used before the first page has started - if
     you get an error, simply insert '.br' before the 'output' request.

     Without argument, 'output' is ignored.

     Use with caution!  It is normally only needed for mark-up used by a
     postprocessor that does something with the output before sending it
     to the output device, filtering out STRING again.

 -- Request: .asciify div
     "Unformat" the diversion specified by DIV in such a way that ASCII
     characters, characters translated with the 'trin' request, space
     characters, and some escape sequences that were formatted and
     diverted are treated like ordinary input characters when the
     diversion is reread.  It can be also used for gross hacks; for
     example, the following sets register 'n' to 1.

          .tr @.
          .di x
          @nr n 1
          .br
          .di
          .tr @@
          .asciify x
          .x

     Note that 'asciify' cannot return all items in a diversion back to
     their source equivalent, nodes such as '\N[...]' will still remain
     as nodes, so the result cannot be guaranteed to be a pure string.

     *Note Copy-in Mode::.

 -- Request: .unformat div
     Like 'asciify', unformat the specified diversion.  However,
     'unformat' only unformats spaces and tabs between words.
     Unformatted tabs are treated as input tokens, and spaces are
     stretchable again.

     The vertical size of lines is not preserved; glyph information
     (font, font size, space width, etc.) is retained.

Next: Suppressing output,  Prev: Diversions,  Up: gtroff Reference

5.26 Environments
=================

It happens frequently that some text should be printed in a certain
format regardless of what may be in effect at the time, for example, in
a trap invoked macro to print headers and footers.  To solve this
'gtroff' processes text in "environments".  An environment contains most
of the parameters that control text processing.  It is possible to
switch amongst these environments; by default 'gtroff' processes text in
environment 0.  The following is the information kept in an environment.

   * font parameters (size, family, style, glyph height and slant, space
     and sentence space size)

   * page parameters (line length, title length, vertical spacing, line
     spacing, indentation, line numbering, centering, right-justifying,
     underlining, hyphenation data)

   * fill and adjust mode

   * tab stops, tab and leader characters, escape character, no-break
     and hyphen indicators, margin character data

   * partially collected lines

   * input traps

   * drawing and fill colours

   These environments may be given arbitrary names (see *note
Identifiers::, for more info).  Old versions of 'troff' only had
environments named '0', '1', and '2'.

 -- Request: .ev [env]
 -- Register: \n[.ev]
     Switch to another environment.  The argument ENV is the name of the
     environment to switch to.  With no argument, 'gtroff' switches back
     to the previous environment.  There is no limit on the number of
     named environments; they are created the first time that they are
     referenced.  The '.ev' read-only register contains the name or
     number of the current environment.  This is a string-valued
     register.

     Note that a call to 'ev' (with argument) pushes the previously
     active environment onto a stack.  If, say, environments 'foo',
     'bar', and 'zap' are called (in that order), the first 'ev' request
     without parameter switches back to environment 'bar' (which is
     popped off the stack), and a second call switches back to
     environment 'foo'.

     Here is an example:

          .ev footnote-env
          .fam N
          .ps 6
          .vs 8
          .ll -.5i
          .ev

          ...

          .ev footnote-env
          \(dg Note the large, friendly letters.
          .ev

 -- Request: .evc env
     Copy the environment ENV into the current environment.

     The following environment data is not copied:

        * Partially filled lines.

        * The status whether the previous line was interrupted.

        * The number of lines still to center, or to right-justify, or
          to underline (with or without underlined spaces); they are set
          to zero.

        * The status whether a temporary indentation is active.

        * Input traps and its associated data.

        * Line numbering mode is disabled; it can be reactivated with
          '.nm +0'.

        * The number of consecutive hyphenated lines (set to zero).

 -- Register: \n[.w]
 -- Register: \n[.cht]
 -- Register: \n[.cdp]
 -- Register: \n[.csk]
     The '\n[.w]' register contains the width of the last glyph added to
     the current environment.

     The '\n[.cht]' register contains the height of the last glyph added
     to the current environment.

     The '\n[.cdp]' register contains the depth of the last glyph added
     to the current environment.  It is positive for glyphs extending
     below the baseline.

     The '\n[.csk]' register contains the "skew" (how far to the right
     of the glyph's center that 'gtroff' should place an accent) of the
     last glyph added to the current environment.

 -- Register: \n[.n]
     The '\n[.n]' register contains the length of the previous output
     line in the current environment.

Next: Colors,  Prev: Environments,  Up: gtroff Reference

5.27 Suppressing output
=======================

 -- Escape: \Onum
     Disable or enable output depending on the value of NUM:

     '\O0'
          Disable any glyphs from being emitted to the device driver,
          provided that the escape occurs at the outer level (see
          '\O[3]' and '\O[4]').  Motion is not suppressed so effectively
          '\O[0]' means _pen up_.

     '\O1'
          Enable output of glyphs, provided that the escape occurs at
          the outer level.

     '\O0' and '\O1' also reset the four registers 'opminx', 'opminy',
     'opmaxx', and 'opmaxy' to -1.  *Note Register Index::.  These four
     registers mark the top left and bottom right hand corners of a box
     that encompasses all written glyphs.

     For example the input text:

          Hello \O[0]world \O[1]this is a test.

     produces the following output:

          Hello       this is a test.

     '\O2'
          Provided that the escape occurs at the outer level, enable
          output of glyphs and also write out to 'stderr' the page
          number and four registers encompassing the glyphs previously
          written since the last call to '\O'.

     '\O3'
          Begin a nesting level.  At start-up, 'gtroff' is at outer
          level.  The current level is contained within the read-only
          register '.O'.  *Note Built-in Registers::.

     '\O4'
          End a nesting level.  The current level is contained within
          the read-only register '.O'.  *Note Built-in Registers::.

     '\O[5PFILENAME]'
          This escape is 'grohtml' specific.  Provided that this escape
          occurs at the outer nesting level write the 'filename' to
          'stderr'.  The position of the image, P, must be specified and
          must be one of 'l', 'r', 'c', or 'i' (left, right, centered,
          inline).  FILENAME is associated with the production of the
          next inline image.

Next: I/O,  Prev: Suppressing output,  Up: gtroff Reference

5.28 Colors
===========

 -- Request: .color [n]
 -- Register: \n[.color]
     If N is missing or non-zero, activate colors (this is the default);
     otherwise, turn it off.

     The read-only number register '.color' is 1 if colors are active,
     0 otherwise.

     Internally, 'color' sets a global flag; it does not produce a
     token.  Similar to the 'cp' request, you should use it at the
     beginning of your document to control color output.

     Colors can be also turned off with the '-c' command line option.

 -- Request: .defcolor ident scheme color_components
     Define color with name IDENT.  SCHEME can be one of the following
     values: 'rgb' (three components), 'cmy' (three components), 'cmyk'
     (four components), and 'gray' or 'grey' (one component).

     Color components can be given either as a hexadecimal string or as
     positive decimal integers in the range 0-65535.  A hexadecimal
     string contains all color components concatenated.  It must start
     with either '#' or '##'; the former specifies hex values in the
     range 0-255 (which are internally multiplied by 257), the latter in
     the range 0-65535.  Examples: '#FFC0CB' (pink), '##ffff0000ffff'
     (magenta).  The default color name value is device-specific
     (usually black).  It is possible that the default color for '\m'
     and '\M' is not identical.

     A new scaling indicator 'f' has been introduced, which multiplies
     its value by 65536; this makes it convenient to specify color
     components as fractions in the range 0 to 1 (1f equals 65536u).
     Example:

          .defcolor darkgreen rgb 0.1f 0.5f 0.2f

     Note that 'f' is the default scaling indicator for the 'defcolor'
     request, thus the above statement is equivalent to

          .defcolor darkgreen rgb 0.1 0.5 0.2

 -- Request: .gcolor [color]
 -- Escape: \mc
 -- Escape: \m(co
 -- Escape: \m[color]
 -- Register: \n[.m]
     Set (glyph) drawing color.  The following examples show how to turn
     the next four words red.

          .gcolor red
          these are in red
          .gcolor
          and these words are in black.

          \m[red]these are in red\m[] and these words are in black.

     The escape '\m[]' returns to the previous color, as does a call to
     'gcolor' without an argument.

     The name of the current drawing color is available in the
     read-only, string-valued number register '.m'.

     The drawing color is associated with the current environment (*note
     Environments::).

     Note that '\m' doesn't produce an input token in 'gtroff'.  As a
     consequence, it can be used in requests like 'mc' (which expects a
     single character as an argument) to change the color on the fly:

          .mc \m[red]x\m[]

 -- Request: .fcolor [color]
 -- Escape: \Mc
 -- Escape: \M(co
 -- Escape: \M[color]
 -- Register: \n[.M]
     Set fill (background) color for filled objects drawn with the
     '\D'...'' commands.

     A red ellipse can be created with the following code:

          \M[red]\h'0.5i'\D'E 2i 1i'\M[]

     The escape '\M[]' returns to the previous fill color, as does a
     call to 'fcolor' without an argument.

     The name of the current fill (background) color is available in the
     read-only, string-valued number register '.M'.

     The fill color is associated with the current environment (*note
     Environments::).

     Note that '\M' doesn't produce an input token in 'gtroff'.

Next: Postprocessor Access,  Prev: Colors,  Up: gtroff Reference

5.29 I/O
========

'gtroff' has several requests for including files:

 -- Request: .so file
     Read in the specified FILE and includes it in place of the 'so'
     request.  This is quite useful for large documents, e.g. keeping
     each chapter in a separate file.  *Note gsoelim::, for more
     information.

     Since 'gtroff' replaces the 'so' request with the contents of
     'file', it makes a difference whether the data is terminated with a
     newline or not: Assuming that file 'xxx' contains the word 'foo'
     without a final newline, this

          This is
          .so xxx
          bar

     yields 'This is foobar'.

     The search path for FILE can be controlled with the '-I' command
     line option.

 -- Request: .pso command
     Read the standard output from the specified COMMAND and includes it
     in place of the 'pso' request.

     This request causes an error if used in safer mode (which is the
     default).  Use 'groff''s or 'troff''s '-U' option to activate
     unsafe mode.

     The comment regarding a final newline for the 'so' request is valid
     for 'pso' also.

 -- Request: .mso file
     Identical to the 'so' request except that 'gtroff' searches for the
     specified FILE in the same directories as macro files for the the
     '-m' command line option.  If the file name to be included has the
     form 'NAME.tmac' and it isn't found, 'mso' tries to include
     'tmac.NAME' and vice versa.  If the file does not exist, a warning
     of type 'file' is emitted.  *Note Debugging::, for information
     about warnings.

 -- Request: .trf file
 -- Request: .cf file
     Transparently output the contents of FILE.  Each line is output as
     if it were preceded by '\!'; however, the lines are _not_ subject
     to copy mode interpretation.  If the file does not end with a
     newline, then a newline is added ('trf' only).  For example, to
     define a macro 'x' containing the contents of file 'f', use

          .ev 1
          .di x
          .trf f
          .di
          .ev

     The calls to 'ev' prevent that the current partial input line
     becomes part of the diversion.

     Both 'trf' and 'cf', when used in a diversion, embeds an object in
     the diversion which, when reread, causes the contents of FILE to be
     transparently copied through to the output.  In UNIX 'troff', the
     contents of FILE is immediately copied through to the output
     regardless of whether there is a current diversion; this behaviour
     is so anomalous that it must be considered a bug.

     While 'cf' copies the contents of FILE completely unprocessed,
     'trf' disallows characters such as NUL that are not valid 'gtroff'
     input characters (*note Identifiers::).

     For 'cf', within a diversion, 'completely unprocessed' means that
     each line of a file to be inserted is handled as if it were
     preceded by '\!\\!'.

     Both requests cause a line break.

 -- Request: .nx [file]
     Force 'gtroff' to continue processing of the file specified as an
     argument.  If no argument is given, immediately jump to the end of
     file.

 -- Request: .rd [prompt [arg1 arg2 ...]]
     Read from standard input, and include what is read as though it
     were part of the input file.  Text is read until a blank line is
     encountered.

     If standard input is a TTY input device (keyboard), write PROMPT to
     standard error, followed by a colon (or send BEL for a beep if no
     argument is given).

     Arguments after PROMPT are available for the input.  For example,
     the line

          .rd data foo bar

     with the input 'This is \$2.' prints

          This is bar.

   Using the 'nx' and 'rd' requests, it is easy to set up form letters.
The form letter template is constructed like this, putting the following
lines into a file called 'repeat.let':

     .ce
     \*(td
     .sp 2
     .nf
     .rd
     .sp
     .rd
     .fi
     Body of letter.
     .bp
     .nx repeat.let

When this is run, a file containing the following lines should be
redirected in.  Note that requests included in this file are executed as
though they were part of the form letter.  The last block of input is
the 'ex' request, which tells 'groff' to stop processing.  If this was
not there, 'groff' would not know when to stop.

     Trent A. Fisher
     708 NW 19th Av., #202
     Portland, OR  97209

     Dear Trent,

     Len Adollar
     4315 Sierra Vista
     San Diego, CA  92103

     Dear Mr. Adollar,

     .ex

 -- Request: .pi pipe
     Pipe the output of 'gtroff' to the shell command(s) specified by
     PIPE.  This request must occur before 'gtroff' has a chance to
     print anything.

     'pi' causes an error if used in safer mode (which is the default).
     Use 'groff''s or 'troff''s '-U' option to activate unsafe mode.

     Multiple calls to 'pi' are allowed, acting as a chain.  For
     example,

          .pi foo
          .pi bar
          ...

     is the same as '.pi foo | bar'.

     Note that the intermediate output format of 'gtroff' is piped to
     the specified commands.  Consequently, calling 'groff' without the
     '-Z' option normally causes a fatal error.

 -- Request: .sy cmds
 -- Register: \n[systat]
     Execute the shell command(s) specified by CMDS.  The output is not
     saved anyplace, so it is up to the user to do so.

     This request causes an error if used in safer mode (which is the
     default).  Use 'groff''s or 'troff''s '-U' option to activate
     unsafe mode.

     For example, the following code fragment introduces the current
     time into a document:

          .sy perl -e 'printf ".nr H %d\\n.nr M %d\\n.nr S %d\\n",\
                       (localtime(time))[2,1,0]' > /tmp/x\n[$$]
          .so /tmp/x\n[$$]
          .sy rm /tmp/x\n[$$]
          \nH:\nM:\nS

     Note that this works by having the 'perl' script (run by 'sy')
     print out the 'nr' requests that set the number registers 'H', 'M',
     and 'S', and then reads those commands in with the 'so' request.

     For most practical purposes, the number registers 'seconds',
     'minutes', and 'hours', which are initialized at start-up of
     'gtroff', should be sufficient.  Use the 'af' request to get a
     formatted output:

          .af hours 00
          .af minutes 00
          .af seconds 00
          \n[hours]:\n[minutes]:\n[seconds]

     The 'systat' read-write number register contains the return value
     of the 'system()' function executed by the last 'sy' request.

 -- Request: .open stream file
 -- Request: .opena stream file
     Open the specified FILE for writing and associates the specified
     STREAM with it.

     The 'opena' request is like 'open', but if the file exists, append
     to it instead of truncating it.

     Both 'open' and 'opena' cause an error if used in safer mode (which
     is the default).  Use 'groff''s or 'troff''s '-U' option to
     activate unsafe mode.

 -- Request: .write stream data
 -- Request: .writec stream data
     Write to the file associated with the specified STREAM.  The stream
     must previously have been the subject of an open request.  The
     remainder of the line is interpreted as the 'ds' request reads its
     second argument: A leading '"' is stripped, and it is read in
     copy-in mode.

     The 'writec' request is like 'write', but only 'write' appends a
     newline to the data.

 -- Request: .writem stream xx
     Write the contents of the macro or string XX to the file associated
     with the specified STREAM.

     XX is read in copy mode, i.e., already formatted elements are
     ignored.  Consequently, diversions must be unformatted with the
     'asciify' request before calling 'writem'.  Usually, this means a
     loss of information.

 -- Request: .close stream
     Close the specified STREAM; the stream is no longer an acceptable
     argument to the 'write' request.

     Here a simple macro to write an index entry.

          .open idx test.idx
          .
          .de IX
          .  write idx \\n[%] \\$*
          ..
          .
          .IX test entry
          .
          .close idx

 -- Escape: \Ve
 -- Escape: \V(ev
 -- Escape: \V[env]
     Interpolate the contents of the specified environment variable ENV
     (one-character name E, two-character name EV) as returned by the
     function 'getenv'.  '\V' is interpreted in copy-in mode.

Next: Miscellaneous,  Prev: I/O,  Up: gtroff Reference

5.30 Postprocessor Access
=========================

There are two escapes that give information directly to the
postprocessor.  This is particularly useful for embedding POSTSCRIPT
into the final document.

 -- Request: .device xxx
 -- Escape: \X'xxx'
     Embeds its argument into the 'gtroff' output preceded with 'x X'.

     The escapes '\&', '\)', '\%', and '\:' are ignored within '\X',
     '\ ' and '\~' are converted to single space characters.  All other
     escapes (except '\\', which produces a backslash) cause an error.

     Contrary to '\X', the 'device' request simply processes its
     argument in copy mode (*note Copy-in Mode::).

     If the 'use_charnames_in_special' keyword is set in the 'DESC'
     file, special characters no longer cause an error; they are simply
     output verbatim.  Additionally, the backslash is represented as
     '\\'.

     'use_charnames_in_special' is currently used by 'grohtml' only.

 -- Request: .devicem xx
 -- Escape: \Yn
 -- Escape: \Y(nm
 -- Escape: \Y[name]
     This is approximately equivalent to '\X'\*[NAME]'' (one-character
     name N, two-character name NM).  However, the contents of the
     string or macro NAME are not interpreted; also it is permitted for
     NAME to have been defined as a macro and thus contain newlines (it
     is not permitted for the argument to '\X' to contain newlines).
     The inclusion of newlines requires an extension to the UNIX 'troff'
     output format, and confuses drivers that do not know about this
     extension (*note Device Control Commands::).

   *Note Output Devices::.

Next: Gtroff Internals,  Prev: Postprocessor Access,  Up: gtroff Reference

5.31 Miscellaneous
==================

This section documents parts of 'gtroff' that cannot (yet) be
categorized elsewhere in this manual.

 -- Request: .nm [start [inc [space [indent]]]]
     Print line numbers.  START is the line number of the _next_ output
     line.  INC indicates which line numbers are printed.  For example,
     the value 5 means to emit only line numbers that are multiples
     of 5; this defaults to 1.  SPACE is the space to be left between
     the number and the text; this defaults to one digit space.  The
     fourth argument is the indentation of the line numbers, defaulting
     to zero.  Both SPACE and INDENT are given as multiples of digit
     spaces; they can be negative also.  Without any arguments, line
     numbers are turned off.

     'gtroff' reserves three digit spaces for the line number (which is
     printed right-justified) plus the amount given by INDENT; the
     output lines are concatenated to the line numbers, separated by
     SPACE, and _without_ reducing the line length.  Depending on the
     value of the horizontal page offset (as set with the 'po' request),
     line numbers that are longer than the reserved space stick out to
     the left, or the whole line is moved to the right.

     Parameters corresponding to missing arguments are not changed; any
     non-digit argument (to be more precise, any argument starting with
     a character valid as a delimiter for identifiers) is also treated
     as missing.

     If line numbering has been disabled with a call to 'nm' without an
     argument, it can be reactivated with '.nm +0', using the previously
     active line numbering parameters.

     The parameters of 'nm' are associated with the current environment
     (*note Environments::).  The current output line number is
     available in the number register 'ln'.

          .po 1m
          .ll 2i
          This test shows how line numbering works with groff.
          .nm 999
          This test shows how line numbering works with groff.
          .br
          .nm xxx 3 2
          .ll -\w'0'u
          This test shows how line numbering works with groff.
          .nn 2
          This test shows how line numbering works with groff.

     And here the result:

           This  test shows how
           line numbering works
           999 with   groff.   This
          1000 test shows how  line
          1001 numbering works with
          1002 groff.
                This test shows how
                line      numbering
           works  with  groff.
           This test shows how
          1005  line      numbering
                works with groff.

 -- Request: .nn [skip]
     Temporarily turn off line numbering.  The argument is the number of
     lines not to be numbered; this defaults to 1.

 -- Request: .mc glyph [dist]
     Print a "margin character" to the right of the text.(1)  (*note
     Miscellaneous-Footnote-1::) The first argument is the glyph to be
     printed.  The second argument is the distance away from the right
     margin.  If missing, the previously set value is used; default is
     10pt).  For text lines that are too long (that is, longer than the
     text length plus DIST), the margin character is directly appended
     to the lines.

     With no arguments the margin character is turned off.  If this
     occurs before a break, no margin character is printed.

     For compatibility with AT&T 'troff', a call to 'mc' to set the
     margin character can't be undone immediately; at least one line
     gets a margin character.  Thus

          .ll 1i
          .mc \[br]
          .mc
          xxx
          .br
          xxx

     produces

          xxx        |
          xxx

     For empty lines and lines produced by the 'tl' request no margin
     character is emitted.

     The margin character is associated with the current environment
     (*note Environments::).

     This is quite useful for indicating text that has changed, and, in
     fact, there are programs available for doing this (they are called
     'nrchbar' and 'changebar' and can be found in any
     'comp.sources.unix' archive).

          .ll 3i
          .mc |
          This paragraph is highlighted with a margin
          character.
          .sp
          Note that vertical space isn't marked.
          .br
          \&
          .br
          But we can fake it with `\&'.

     Result:

          This  paragraph is highlighted |
          with a margin character.       |

          Note that vertical space isn't |
          marked.                        |
                                         |
          But we can fake it with `\&'.  |

 -- Request: .psbb filename
 -- Register: \n[llx]
 -- Register: \n[lly]
 -- Register: \n[urx]
 -- Register: \n[ury]
     Retrieve the bounding box of the POSTSCRIPT image found in
     FILENAME.  The file must conform to Adobe's "Document Structuring
     Conventions" (DSC); the command searches for a '%%BoundingBox'
     comment and extracts the bounding box values into the number
     registers 'llx', 'lly', 'urx', and 'ury'.  If an error occurs (for
     example, 'psbb' cannot find the '%%BoundingBox' comment), it sets
     the four number registers to zero.

     The search path for FILENAME can be controlled with the '-I'
     command line option.

Next: Debugging,  Prev: Miscellaneous,  Up: gtroff Reference

5.32 'gtroff' Internals
=======================

'gtroff' processes input in three steps.  One or more input characters
are converted to an "input token".(1)  (*note Gtroff
Internals-Footnote-1::) Then, one or more input tokens are converted to
an "output node".  Finally, output nodes are converted to the
intermediate output language understood by all output devices.

   Actually, before step one happens, 'gtroff' converts certain escape
sequences into reserved input characters (not accessible by the user);
such reserved characters are used for other internal processing also -
this is the very reason why not all characters are valid input.  *Note
Identifiers::, for more on this topic.

   For example, the input string 'fi\[:u]' is converted into a character
token 'f', a character token 'i', and a special token ':u' (representing
u umlaut).  Later on, the character tokens 'f' and 'i' are merged to a
single output node representing the ligature glyph 'fi' (provided the
current font has a glyph for this ligature); the same happens with ':u'.
All output glyph nodes are 'processed', which means that they are
invariably associated with a given font, font size, advance width, etc.
During the formatting process, 'gtroff' itself adds various nodes to
control the data flow.

   Macros, diversions, and strings collect elements in two chained
lists: a list of input tokens that have been passed unprocessed, and a
list of output nodes.  Consider the following the diversion.

     .di xxx
     a
     \!b
     c
     .br
     .di

It contains these elements.

node list            token list   element number
                                  
line start node      --           1
glyph node 'a'       --           2
word space node      --           3
--                   'b'          4
--                   '\n'         5
glyph node 'c'       --           6
vertical size node   --           7
vertical size node   --           8
--                   '\n'         9

Elements 1, 7, and 8 are inserted by 'gtroff'; the latter two (which are
always present) specify the vertical extent of the last line, possibly
modified by '\x'.  The 'br' request finishes the current partial line,
inserting a newline input token, which is subsequently converted to a
space when the diversion is reread.  Note that the word space node has a
fixed width that isn't stretchable anymore.  To convert horizontal space
nodes back to input tokens, use the 'unformat' request.

   Macros only contain elements in the token list (and the node list is
empty); diversions and strings can contain elements in both lists.

   Note that the 'chop' request simply reduces the number of elements in
a macro, string, or diversion by one.  Exceptions are "compatibility
save" and "compatibility ignore" input tokens, which are ignored.  The
'substring' request also ignores those input tokens.

   Some requests like 'tr' or 'cflags' work on glyph identifiers only;
this means that the associated glyph can be changed without destroying
this association.  This can be very helpful for substituting glyphs.  In
the following example, we assume that glyph 'foo' isn't available by
default, so we provide a substitution using the 'fchar' request and map
it to input character 'x'.

     .fchar \[foo] foo
     .tr x \[foo]

Now let us assume that we install an additional special font 'bar' that
has glyph 'foo'.

     .special bar
     .rchar \[foo]

Since glyphs defined with 'fchar' are searched before glyphs in special
fonts, we must call 'rchar' to remove the definition of the fallback
glyph.  Anyway, the translation is still active; 'x' now maps to the
real glyph 'foo'.

   Macro and request arguments preserve the compatibility mode:

     .cp 1     \" switch to compatibility mode
     .de xx
     \\$1
     ..
     .cp 0     \" switch compatibility mode off
     .xx caf\['e]
         => café

Since compatibility mode is on while 'de' is called, the macro 'xx'
activates compatibility mode while executing.  Argument '$1' can still
be handled properly because it inherits the compatibility mode status
which was active at the point where 'xx' is called.

   After expansion of the parameters, the compatibility save and restore
tokens are removed.

Next: Implementation Differences,  Prev: Gtroff Internals,  Up: gtroff Reference

5.33 Debugging
==============

'gtroff' is not easy to debug, but there are some useful features and
strategies for debugging.

 -- Request: .lf line [filename]
     Change the line number and optionally the file name 'gtroff' shall
     use for error and warning messages.  LINE is the input line number
     of the _next_ line.

     Without argument, the request is ignored.

     This is a debugging aid for documents that are split into many
     files, then put together with 'soelim' and other preprocessors.
     Usually, it isn't invoked manually.

     Note that other 'troff' implementations (including the original
     AT&T version) handle 'lf' differently.  For them, LINE changes the
     line number of the _current_ line.

 -- Request: .tm string
 -- Request: .tm1 string
 -- Request: .tmc string
     Send STRING to the standard error output; this is very useful for
     printing debugging messages among other things.

     STRING is read in copy mode.

     The 'tm' request ignores leading spaces of STRING; 'tm1' handles
     its argument similar to the 'ds' request: a leading double quote in
     STRING is stripped to allow initial blanks.

     The 'tmc' request is similar to 'tm1' but does not append a newline
     (as is done in 'tm' and 'tm1').

 -- Request: .ab [string]
     Similar to the 'tm' request, except that it causes 'gtroff' to stop
     processing.  With no argument it prints 'User Abort.' to standard
     error.

 -- Request: .ex
     The 'ex' request also causes 'gtroff' to stop processing; see also
     *note I/O::.

   When doing something involved it is useful to leave the debugging
statements in the code and have them turned on by a command line flag.

     .if \n(DB .tm debugging output

To activate these statements say

     groff -rDB=1 file

   If it is known in advance that there are many errors and no useful
output, 'gtroff' can be forced to suppress formatted output with the
'-z' flag.

 -- Request: .pev
     Print the contents of the current environment and all the currently
     defined environments (both named and numbered) on 'stderr'.

 -- Request: .pm
     Print the entire symbol table on 'stderr'.  Names of all defined
     macros, strings, and diversions are print together with their size
     in bytes.  Since 'gtroff' sometimes adds nodes by itself, the
     returned size can be larger than expected.

     This request differs from UNIX 'troff': 'gtroff' reports the sizes
     of diversions, ignores an additional argument to print only the
     total of the sizes, and the size isn't returned in blocks of 128
     characters.

 -- Request: .pnr
     Print the names and contents of all currently defined number
     registers on 'stderr'.

 -- Request: .ptr
     Print the names and positions of all traps (not including input
     line traps and diversion traps) on 'stderr'.  Empty slots in the
     page trap list are printed as well, because they can affect the
     priority of subsequently planted traps.

 -- Request: .fl
     Instruct 'gtroff' to flush its output immediately.  The intent is
     for interactive use, but this behaviour is currently not
     implemented in 'gtroff'.  Contrary to UNIX 'troff', TTY output is
     sent to a device driver also ('grotty'), making it non-trivial to
     communicate interactively.

     This request causes a line break.

 -- Request: .backtrace
     Print a backtrace of the input stack to the standard error stream.

     Consider the following in file 'test':

          .de xxx
          .  backtrace
          ..
          .de yyy
          .  xxx
          ..
          .
          .yyy

     On execution, 'gtroff' prints the following:

          test:2: backtrace: macro `xxx'
          test:5: backtrace: macro `yyy'
          test:8: backtrace: file `test'

     The option '-b' of 'gtroff' internally calls a variant of this
     request on each error and warning.

 -- Register: \n[slimit]
     Use the 'slimit' number register to set the maximum number of
     objects on the input stack.  If 'slimit' is less than or equal
     to 0, there is no limit set.  With no limit, a buggy recursive
     macro can exhaust virtual memory.

     The default value is 1000; this is a compile-time constant.

 -- Request: .warnscale si
     Set the scaling indicator used in warnings to SI.  Valid values for
     SI are 'u', 'i', 'c', 'p', and 'P'.  At startup, it is set to 'i'.

 -- Request: .spreadwarn [limit]
     Make 'gtroff' emit a warning if the additional space inserted for
     each space between words in an output line is larger or equal to
     LIMIT.  A negative value is changed to zero; no argument toggles
     the warning on and off without changing LIMIT.  The default scaling
     indicator is 'm'.  At startup, 'spreadwarn' is deactivated, and
     LIMIT is set to 3m.

     For example,

          .spreadwarn 0.2m

     causes a warning if 'gtroff' must add 0.2m or more for each
     interword space in a line.

     This request is active only if text is justified to both margins
     (using '.ad b').

   'gtroff' has command line options for printing out more warnings
('-w') and for printing backtraces ('-b') when a warning or an error
occurs.  The most verbose level of warnings is '-ww'.

 -- Request: .warn [flags]
 -- Register: \n[.warn]
     Control the level of warnings checked for.  The FLAGS are the sum
     of the numbers associated with each warning that is to be enabled;
     all other warnings are disabled.  The number associated with each
     warning is listed below.  For example, '.warn 0' disables all
     warnings, and '.warn 1' disables all warnings except that about
     missing glyphs.  If no argument is given, all warnings are enabled.

     The read-only number register '.warn' contains the current warning
     level.

* Menu:

* Warnings::

Prev: Debugging,  Up: Debugging

5.33.1 Warnings
---------------

The warnings that can be given to 'gtroff' are divided into the
following categories.  The name associated with each warning is used by
the '-w' and '-W' options; the number is used by the 'warn' request and
by the '.warn' register.

'char'
'1'
     Non-existent glyphs.(1)  (*note Warnings-Footnote-1::) This is
     enabled by default.

'number'
'2'
     Invalid numeric expressions.  This is enabled by default.  *Note
     Expressions::.

'break'
'4'
     In fill mode, lines that could not be broken so that their length
     was less than the line length.  This is enabled by default.

'delim'
'8'
     Missing or mismatched closing delimiters.

'el'
'16'
     Use of the 'el' request with no matching 'ie' request.  *Note
     if-else::.

'scale'
'32'
     Meaningless scaling indicators.

'range'
'64'
     Out of range arguments.

'syntax'
'128'
     Dubious syntax in numeric expressions.

'di'
'256'
     Use of 'di' or 'da' without an argument when there is no current
     diversion.

'mac'
'512'
     Use of undefined strings, macros and diversions.  When an undefined
     string, macro, or diversion is used, that string is automatically
     defined as empty.  So, in most cases, at most one warning is given
     for each name.

'reg'
'1024'
     Use of undefined number registers.  When an undefined number
     register is used, that register is automatically defined to have a
     value of 0.  So, in most cases, at most one warning is given for
     use of a particular name.

'tab'
'2048'
     Use of a tab character where a number was expected.

'right-brace'
'4096'
     Use of '\}' where a number was expected.

'missing'
'8192'
     Requests that are missing non-optional arguments.

'input'
'16384'
     Invalid input characters.

'escape'
'32768'
     Unrecognized escape sequences.  When an unrecognized escape
     sequence '\X' is encountered, the escape character is ignored, and
     X is printed.

'space'
'65536'
     Missing space between a request or macro and its argument.  This
     warning is given when an undefined name longer than two characters
     is encountered, and the first two characters of the name make a
     defined name.  The request or macro is not invoked.  When this
     warning is given, no macro is automatically defined.  This is
     enabled by default.  This warning never occurs in compatibility
     mode.

'font'
'131072'
     Non-existent fonts.  This is enabled by default.

'ig'
'262144'
     Invalid escapes in text ignored with the 'ig' request.  These are
     conditions that are errors when they do not occur in ignored text.

'color'
'524288'
     Color related warnings.

'file'
'1048576'
     Missing files.  The 'mso' request gives this warning when the
     requested macro file does not exist.  This is enabled by default.

'all'
     All warnings except 'di', 'mac' and 'reg'.  It is intended that
     this covers all warnings that are useful with traditional macro
     packages.

'w'
     All warnings.

Prev: Debugging,  Up: gtroff Reference

5.34 Implementation Differences
===============================

GNU 'troff' has a number of features that cause incompatibilities with
documents written with old versions of 'troff'.

   Long names cause some incompatibilities.  UNIX 'troff' interprets

     .dsabcd

as defining a string 'ab' with contents 'cd'.  Normally, GNU 'troff'
interprets this as a call of a macro named 'dsabcd'.  Also UNIX 'troff'
interprets '\*[' or '\n[' as references to a string or number register
called '['.  In GNU 'troff', however, this is normally interpreted as
the start of a long name.  In compatibility mode GNU 'troff' interprets
long names in the traditional way (which means that they are not
recognized as names).

 -- Request: .cp [n]
 -- Request: .do cmd
 -- Register: \n[.C]
     If N is missing or non-zero, turn on compatibility mode; otherwise,
     turn it off.

     The read-only number register '.C' is 1 if compatibility mode is
     on, 0 otherwise.

     Compatibility mode can be also turned on with the '-C' command line
     option.

     The 'do' request turns off compatibility mode while executing its
     arguments as a 'gtroff' command.  However, it does not turn off
     compatibility mode while processing the macro itself.  To do that,
     use the 'de1' request (or manipulate the '.C' register manually).
     *Note Writing Macros::.

          .do fam T

     executes the 'fam' request when compatibility mode is enabled.

     'gtroff' restores the previous compatibility setting before
     interpreting any files sourced by the CMD.

   Two other features are controlled by '-C'.  If not in compatibility
mode, GNU 'troff' preserves the input level in delimited arguments:

     .ds xx '
     \w'abc\*(xxdef'

In compatibility mode, the string '72def'' is returned; without '-C' the
resulting string is '168' (assuming a TTY output device).

   Finally, the escapes '\f', '\H', '\m', '\M', '\R', '\s', and '\S' are
transparent for recognizing the beginning of a line only in
compatibility mode (this is a rather obscure feature).  For example, the
code

     .de xx
     Hallo!
     ..
     \fB.xx\fP

prints 'Hallo!' in bold face if in compatibility mode, and '.xx' in bold
face otherwise.

   GNU 'troff' does not allow the use of the escape sequences '\|',
'\^', '\&', '\{', '\}', '\<SP>', '\'', '\`', '\-', '\_', '\!', '\%', and
'\c' in names of strings, macros, diversions, number registers, fonts or
environments; UNIX 'troff' does.  The '\A' escape sequence (*note
Identifiers::) may be helpful in avoiding use of these escape sequences
in names.

   Fractional point sizes cause one noteworthy incompatibility.  In UNIX
'troff' the 'ps' request ignores scale indicators and thus

     .ps 10u

sets the point size to 10 points, whereas in GNU 'troff' it sets the
point size to 10 scaled points.  *Note Fractional Type Sizes::, for more
information.

   In GNU 'troff' there is a fundamental difference between
(unformatted) input characters and (formatted) output glyphs.
Everything that affects how a glyph is output is stored with the glyph
node; once a glyph node has been constructed it is unaffected by any
subsequent requests that are executed, including 'bd', 'cs', 'tkf',
'tr', or 'fp' requests.  Normally glyphs are constructed from input
characters at the moment immediately before the glyph is added to the
current output line.  Macros, diversions and strings are all, in fact,
the same type of object; they contain lists of input characters and
glyph nodes in any combination.  A glyph node does not behave like an
input character for the purposes of macro processing; it does not
inherit any of the special properties that the input character from
which it was constructed might have had.  For example,

     .di x
     \\\\
     .br
     .di
     .x

prints '\\' in GNU 'troff'; each pair of input backslashes is turned
into one output backslash and the resulting output backslashes are not
interpreted as escape characters when they are reread.  UNIX 'troff'
would interpret them as escape characters when they were reread and
would end up printing one '\'.  The correct way to obtain a printable
backslash is to use the '\e' escape sequence: This always prints a
single instance of the current escape character, regardless of whether
or not it is used in a diversion; it also works in both GNU 'troff' and
UNIX 'troff'.(1)  (*note Implementation Differences-Footnote-1::) To
store, for some reason, an escape sequence in a diversion that is
interpreted when the diversion is reread, either use the traditional
'\!' transparent output facility, or, if this is unsuitable, the new
'\?' escape sequence.

   *Note Diversions::, and *note Gtroff Internals::, for more
information.

Next: Output Devices,  Prev: gtroff Reference,  Up: Top

6 Preprocessors
***************

This chapter describes all preprocessors that come with 'groff' or which
are freely available.

* Menu:

* geqn::
* gtbl::
* gpic::
* ggrn::
* grap::
* gchem::
* grefer::
* gsoelim::
* preconv::

Next: gtbl,  Prev: Preprocessors,  Up: Preprocessors

6.1 'geqn'
==========

* Menu:

* Invoking geqn::

Prev: geqn,  Up: geqn

6.1.1 Invoking 'geqn'
---------------------

Next: gpic,  Prev: geqn,  Up: Preprocessors

6.2 'gtbl'
==========

* Menu:

* Invoking gtbl::

Prev: gtbl,  Up: gtbl

6.2.1 Invoking 'gtbl'
---------------------

Next: ggrn,  Prev: gtbl,  Up: Preprocessors

6.3 'gpic'
==========

* Menu:

* Invoking gpic::

Prev: gpic,  Up: gpic

6.3.1 Invoking 'gpic'
---------------------

Next: grap,  Prev: gpic,  Up: Preprocessors

6.4 'ggrn'
==========

* Menu:

* Invoking ggrn::

Prev: ggrn,  Up: ggrn

6.4.1 Invoking 'ggrn'
---------------------

Next: gchem,  Prev: ggrn,  Up: Preprocessors

6.5 'grap'
==========

A free implementation of 'grap', written by Ted Faber, is available as
an extra package from the following address:

     <http://www.lunabase.org/~faber/Vault/software/grap/>

Next: grefer,  Prev: grap,  Up: Preprocessors

6.6 'gchem'
===========

* Menu:

* Invoking gchem::

Prev: gchem,  Up: gchem

6.6.1 Invoking 'gchem'
----------------------

Next: gsoelim,  Prev: gchem,  Up: Preprocessors

6.7 'grefer'
============

* Menu:

* Invoking grefer::

Prev: grefer,  Up: grefer

6.7.1 Invoking 'grefer'
-----------------------

Next: preconv,  Prev: grefer,  Up: Preprocessors

6.8 'gsoelim'
=============

* Menu:

* Invoking gsoelim::

Prev: gsoelim,  Up: gsoelim

6.8.1 Invoking 'gsoelim'
------------------------

Prev: gsoelim,  Up: Preprocessors

6.9 'preconv'
=============

* Menu:

* Invoking preconv::

Prev: preconv,  Up: preconv

6.9.1 Invoking 'preconv'
------------------------

Next: File formats,  Prev: Preprocessors,  Up: Top

7 Output Devices
****************

* Menu:

* Special Characters::
* grotty::
* grops::
* gropdf::
* grodvi::
* grolj4::
* grolbp::
* grohtml::
* gxditview::

Next: grotty,  Prev: Output Devices,  Up: Output Devices

7.1 Special Characters
======================

*Note Font Files::.

Next: grops,  Prev: Special Characters,  Up: Output Devices

7.2 'grotty'
============

The postprocessor 'grotty' translates the output from GNU 'troff' into a
form suitable for typewriter-like devices.  It is fully documented on
its manual page, 'grotty(1)'.

* Menu:

* Invoking grotty::

Prev: grotty,  Up: grotty

7.2.1 Invoking 'grotty'
-----------------------

The postprocessor 'grotty' accepts the following command-line options:

'-b'
     Do not overstrike bold glyphs.  Ignored if '-c' isn't used.

'-B'
     Do not underline bold-italic glyphs.  Ignored if '-c' isn't used.

'-c'
     Use overprint and disable colours for printing on legacy Teletype
     printers (see below).

'-d'
     Do not render lines (this is, ignore all '\D' escapes).

'-f'
     Use form feed control characters in the output.

'-FDIR'
     Put the directory 'DIR/devNAME' in front of the search path for the
     font and device description files, given the target device NAME.

'-h'
     Use horizontal tabs for sequences of 8 space characters.

'-i'
     Request italic glyphs from the terminal.  Ignored if '-c' is
     active.

'-o'
     Do not overstrike.

'-r'
     Highlight italic glyphs.  Ignored if '-c' is active.

'-u'
     Do not underline italic glyphs.  Ignored if '-c' isn't used.

'-U'
     Do not overstrike bold-italic glyphs.  Ignored if '-c' isn't used.

'-v'
     Print the version number.

   The '-c' mode for TTY output devices means that underlining is done
by emitting sequences of '_' and '^H' (the backspace character) before
the actual character.  Literally, this is printing an underline
character, then moving the caret back one character position, and
printing the actual character at the same position as the underline
character (similar to a typewriter).  Usually, a modern terminal can't
interpret this (and the original Teletype machines for which this
sequence was appropriate are no longer in use).  You need a pager
program like 'less' that translates this into ISO 6429 SGR sequences to
control terminals.

Next: gropdf,  Prev: grotty,  Up: Output Devices

7.3 'grops'
===========

The postprocessor 'grops' translates the output from GNU 'troff' into a
form suitable for Adobe POSTSCRIPT devices.  It is fully documented on
its manual page, 'grops(1)'.

* Menu:

* Invoking grops::
* Embedding PostScript::

Next: Embedding PostScript,  Prev: grops,  Up: grops

7.3.1 Invoking 'grops'
----------------------

The postprocessor 'grops' accepts the following command-line options:

'-bFLAGS'
     Use backward compatibility settings given by FLAGS as documented in
     the 'grops(1)' manual page.  Overrides the command 'broken' in the
     'DESC' file.

'-cN'
     Print N copies of each page.

'-FDIR'
     Put the directory 'DIR/devNAME' in front of the search path for the
     font, prologue and device description files, given the target
     device NAME, usually *ps*.

'-g'
     Tell the printer to guess the page length.  Useful for printing
     vertically centered pages when the paper dimensions are determined
     at print time.

'-IPATH ...'
     Consider the directory 'PATH' for searching included files
     specified with relative paths.  The current directory is searched
     as fallback.

'-l'
     Use landscape orientation.

'-m'
     Use manual feed.

'-pPAPERSIZE'
     Set the page dimensions.  Overrides the commands 'papersize',
     'paperlength', and 'paperwidth' in the 'DESC' file.  See the
     'groff_font(5)' manual page for details.

'-PPROLOGUE'
     Use the PROLOGUE in the font path as the prologue instead of the
     default 'prologue'.  Overrides the environment variable
     'GROPS_PROLOGUE'.

'-wN'
     Set the line thickness to N/1000em.  Overrides the default value N
     = 40.

'-v'
     Print the version number.

Prev: Invoking grops,  Up: grops

7.3.2 Embedding POSTSCRIPT
--------------------------

The escape sequence

   '\X'ps: import FILE LLX LLY URX URY WIDTH [HEIGHT]''

places a rectangle of the specified WIDTH containing the POSTSCRIPT
drawing from file FILE bound by the box from LLX LLY to URX URY (in
POSTSCRIPT coordinates) at the insertion point.  If HEIGHT is not
specified, the embedded drawing is scaled proportionally.

   *Note Miscellaneous::, for the 'psbb' request, which automatically
generates the bounding box.

   This escape sequence is used internally by the macro 'PSPIC' (see the
'groff_tmac(5)' manual page).

Next: grodvi,  Prev: grops,  Up: Output Devices

7.4 'gropdf'
============

The postprocessor 'gropdf' translates the output from GNU 'troff' into a
form suitable for Adobe PDF devices.  It is fully documented on its
manual page, 'gropdf(1)'.

* Menu:

* Invoking gropdf::
* Embedding PDF::

Next: Embedding PDF,  Prev: gropdf,  Up: gropdf

7.4.1 Invoking 'gropdf'
-----------------------

The postprocessor 'gropdf' accepts the following command-line options:

'-d'
     Produce uncompressed PDFs that include debugging comments.

'-e'
     This forces 'gropdf' to embed all used fonts in the PDF, even if
     they are one of the 14 base Adobe fonts.

'-FDIR'
     Put the directory 'DIR/devNAME' in front of the search path for the
     font, prologue and device description files, given the target
     device NAME, usually *pdf*.

'-yFOUNDRY'
     This forces the use of a different font foundry.

'-l'
     Use landscape orientation.

'-pPAPERSIZE'
     Set the page dimensions.  Overrides the commands 'papersize',
     'paperlength', and 'paperwidth' in the 'DESC' file.  See the
     'groff_font(5)' manual page for details.

'-v'
     Print the version number.

'-s'
     Append a comment line to end of PDF showing statistics, i.e.
     number of pages in document.  Ghostscript's 'ps2pdf(1)' complains
     about this line if it is included, but works anyway.

'-uFILENAME'
     'gropdf' normally includes a ToUnicode CMap with any font created
     using 'text.enc' as the encoding file, this makes it easier to
     search for words that contain ligatures.  You can include your own
     CMap by specifying a FILENAME or have no CMap at all by omitting
     the FILENAME.

Prev: Invoking gropdf,  Up: gropdf

7.4.2 Embedding PDF
-------------------

The escape sequence

   '\X'pdf: pdfpic FILE ALIGNMENT WIDTH [HEIGHT] [LINELENGTH]''

places a rectangle of the specified WIDTH containing the PDF drawing
from file FILE of desired WIDTH and HEIGHT (if HEIGHT is missing or zero
then it is scaled proportionally).  If ALIGNMENT is '-L' the drawing is
left aligned.  If it is '-C' or '-R' a LINELENGTH greater than the width
of the drawing is required as well.  If WIDTH is specified as zero then
the width is scaled in proportion to the height.

Next: grolj4,  Prev: gropdf,  Up: Output Devices

7.5 'grodvi'
============

The postprocessor 'grodvi' translates the output from GNU 'troff' into
the *DVI* output format compatible with the *TeX* document preparation
system.  It is fully documented on its manual page, 'grodvi(1)'.

* Menu:

* Invoking grodvi::

Prev: grodvi,  Up: grodvi

7.5.1 Invoking 'grodvi'
-----------------------

The postprocessor 'grodvi' accepts the following command-line options:

'-d'
     Do not use *tpic* specials to implement drawing commands.

'-FDIR'
     Put the directory 'DIR/devNAME' in front of the search path for the
     font and device description files, given the target device NAME,
     usually *dvi*.

'-l'
     Use landscape orientation.

'-pPAPERSIZE'
     Set the page dimensions.  Overrides the commands 'papersize',
     'paperlength', and 'paperwidth' in the 'DESC' file.  See
     'groff_font(5)' manual page for details.

'-v'
     Print the version number.

'-wN'
     Set the line thickness to N/1000em.  Overrides the default value N
     = 40.

Next: grolbp,  Prev: grodvi,  Up: Output Devices

7.6 'grolj4'
============

The postprocessor 'grolj4' translates the output from GNU 'troff' into
the *PCL5* output format suitable for printing on a *HP LaserJet 4*
printer.  It is fully documented on its manual page, 'grolj4(1)'.

* Menu:

* Invoking grolj4::

Prev: grolj4,  Up: grolj4

7.6.1 Invoking 'grolj4'
-----------------------

The postprocessor 'grolj4' accepts the following command-line options:

'-cN'
     Print N copies of each page.

'-FDIR'
     Put the directory 'DIR/devNAME' in front of the search path for the
     font and device description files, given the target device NAME,
     usually *lj4*.

'-l'
     Use landscape orientation.

'-pSIZE'
     Set the page dimensions.  Valid values for SIZE are: 'letter',
     'legal', 'executive', 'a4', 'com10', 'monarch', 'c5', 'b5', 'd1'.

'-v'
     Print the version number.

'-wN'
     Set the line thickness to N/1000em.  Overrides the default value N
     = 40.

   The special drawing command '\D'R DH DV'' draws a horizontal
rectangle from the current position to the position at offset (DH,DV).

Next: grohtml,  Prev: grolj4,  Up: Output Devices

7.7 'grolbp'
============

The postprocessor 'grolbp' translates the output from GNU 'troff' into
the *LBP* output format suitable for printing on *Canon CAPSL* printers.
It is fully documented on its manual page, 'grolbp(1)'.

* Menu:

* Invoking grolbp::

Prev: grolbp,  Up: grolbp

7.7.1 Invoking 'grolbp'
-----------------------

The postprocessor 'grolbp' accepts the following command-line options:

'-cN'
     Print N copies of each page.

'-FDIR'
     Put the directory 'DIR/devNAME' in front of the search path for the
     font, prologue and device description files, given the target
     device NAME, usually *lbp*.

'-l'
     Use landscape orientation.

'-oORIENTATION'
     Use the ORIENTATION specified: 'portrait' or 'landscape'.

'-pPAPERSIZE'
     Set the page dimensions.  See 'groff_font(5)' manual page for
     details.

'-wN'
     Set the line thickness to N/1000em.  Overrides the default value N
     = 40.

'-v'
     Print the version number.

'-h'
     Print command-line help.

Next: gxditview,  Prev: grolbp,  Up: Output Devices

7.8 'grohtml'
=============

The 'grohtml' front end (which consists of a preprocessor,
'pre-grohtml', and a device driver, 'post-grohtml') translates the
output of GNU 'troff' to HTML.  Users should always invoke 'grohtml' via
the 'groff' command with a '\-Thtml' option.  If no files are given,
'grohtml' will read the standard input.  A filename of '-' will also
cause 'grohtml' to read the standard input.  HTML output is written to
the standard output.  When 'grohtml' is run by 'groff', options can be
passed to 'grohtml' using 'groff''s '-P' option.

   'grohtml' invokes 'groff' twice.  In the first pass, pictures,
equations, and tables are rendered using the 'ps' device, and in the
second pass HTML output is generated by the 'html' device.

   'grohtml' always writes output in 'UTF-8' encoding and has built-in
entities for all non-composite unicode characters.  In spite of this,
'groff' may issue warnings about unknown special characters if they
can't be found during the first pass.  Such warnings can be safely
ignored unless the special characters appear inside a table or equation,
in which case glyphs for these characters must be defined for the 'ps'
device as well.

   This output device is fully documented on its manual page,
'grohtml(1)'.

* Menu:

* Invoking grohtml::
* grohtml specific registers and strings::

Next: grohtml specific registers and strings,  Prev: grohtml,  Up: grohtml

7.8.1 Invoking 'grohtml'
------------------------

The postprocessor 'grohtml' accepts the following command-line options:

'-aBITS'
     Use this number of BITS (= 1, 2 or 4) for text antialiasing.
     Default: BITS = 4.

'-a0'
     Do not use text antialiasing.

'-b'
     Use white background.

'-DDIR'
     Store rendered images in the directory 'DIR'.

'-FDIR'
     Put the directory 'DIR/devNAME' in front of the search path for the
     font, prologue and device description files, given the target
     device NAME, usually *html*.

'-gBITS'
     Use this number of BITS (= 1, 2 or 4) for antialiasing of drawings.
     Default: BITS = 4.

'-g0'
     Do not use antialiasing for drawings.

'-h'
     Use the 'B' element for section headings.

'-iRESOLUTION'
     Use the RESOLUTION for rendered images.  Default: RESOLUTION =
     100dpi.

'-ISTEM'
     Set the images' STEM NAME.  Default: STEM = 'grohtml-XXX' (XXX is
     the process ID).

'-jSTEM'
     Place each section in a separate file called 'STEM-N.html' (where N
     is a generated section number).

'-l'
     Do not generate the table of contents.

'-n'
     Generate simple fragment identifiers.

'-oOFFSET'
     Use vertical paddding OFFSET for images.

'-p'
     Display the page rendering progress to 'stderr'.

'-r'
     Do not use horizontal rules to separate headers and footers.

'-sSIZE'
     Set the base font size, to be modified using the elements 'BIG' and
     'SMALL'.

'-SLEVEL'
     Generate separate files for sections at level LEVEL.

'-v'
     Print the version number.

'-V'
     Generate a validator button at the bottom.

'-y'
     Generate a signature of groff after the validator button, if any.

Prev: Invoking grohtml,  Up: grohtml

7.8.2 'grohtml' specific registers and strings
----------------------------------------------

 -- Register: \n[ps4html]
 -- String: \*[www-image-template]
     The registers 'ps4html' and 'www-image-template' are defined by the
     'pre-grohtml' preprocessor.  'pre-grohtml' reads in the 'troff'
     input, marks up the inline equations and passes the result firstly
     to

          troff -Tps -rps4html=1 -dwww-image-template=TEMPLATE

     and secondly to

          troff -Thtml

     or

          troff -Txhtml

     The POSTSCRIPT device is used to create all the image files (for
     '-Thtml'; if '-Txhtml' is used, all equations are passed to 'geqn'
     to produce MathML, and the register 'ps4html' enables the macro
     sets to ignore floating keeps, footers, and headings.

     The register 'www-image-template' is set to the user specified
     template name or the default name.

Prev: grohtml,  Up: Output Devices

7.9 'gxditview'
===============

* Menu:

* Invoking gxditview::

Prev: gxditview,  Up: gxditview

7.9.1 Invoking 'gxditview'
--------------------------

Next: Installation,  Prev: Output Devices,  Up: Top

8 File formats
**************

All files read and written by 'gtroff' are text files.  The following
two sections describe their format.

* Menu:

* gtroff Output::
* Font Files::

Next: Font Files,  Prev: File formats,  Up: File formats

8.1 'gtroff' Output
===================

This section describes the intermediate output format of GNU 'troff'.
This output is produced by a run of 'gtroff' before it is fed into a
device postprocessor program.

   As 'groff' is a wrapper program around 'gtroff' that automatically
calls a postprocessor, this output does not show up normally.  This is
why it is called "intermediate".  'groff' provides the option '-Z' to
inhibit postprocessing, such that the produced intermediate output is
sent to standard output just like calling 'gtroff' manually.

   Here, the term "troff output" describes what is output by 'gtroff',
while "intermediate output" refers to the language that is accepted by
the parser that prepares this output for the postprocessors.  This
parser is smarter on whitespace and implements obsolete elements for
compatibility, otherwise both formats are the same.(1)  (*note gtroff
Output-Footnote-1::)

   The main purpose of the intermediate output concept is to facilitate
the development of postprocessors by providing a common programming
interface for all devices.  It has a language of its own that is
completely different from the 'gtroff' language.  While the 'gtroff'
language is a high-level programming language for text processing, the
intermediate output language is a kind of low-level assembler language
by specifying all positions on the page for writing and drawing.

   The intermediate output produced by 'gtroff' is fairly readable,
while output from AT&T 'troff' is rather hard to understand because of
strange habits that are still supported, but not used any longer by
'gtroff'.

* Menu:

* Language Concepts::
* Command Reference::
* Intermediate Output Examples::
* Output Language Compatibility::

Next: Command Reference,  Prev: gtroff Output,  Up: gtroff Output

8.1.1 Language Concepts
-----------------------

During the run of 'gtroff', the input data is cracked down to the
information on what has to be printed at what position on the intended
device.  So the language of the intermediate output format can be quite
small.  Its only elements are commands with and without arguments.  In
this section, the term "command" always refers to the intermediate
output language, and never to the 'gtroff' language used for document
formatting.  There are commands for positioning and text writing, for
drawing, and for device controlling.

* Menu:

* Separation::
* Argument Units::
* Document Parts::

Next: Argument Units,  Prev: Language Concepts,  Up: Language Concepts

8.1.1.1 Separation
..................

AT&T 'troff' output has strange requirements on whitespace.  The
'gtroff' output parser, however, is smart about whitespace by making it
maximally optional.  The whitespace characters, i.e., the tab, space,
and newline characters, always have a syntactical meaning.  They are
never printable because spacing within the output is always done by
positioning commands.

   Any sequence of space or tab characters is treated as a single
"syntactical space".  It separates commands and arguments, but is only
required when there would occur a clashing between the command code and
the arguments without the space.  Most often, this happens when
variable-length command names, arguments, argument lists, or command
clusters meet.  Commands and arguments with a known, fixed length need
not be separated by syntactical space.

   A line break is a syntactical element, too.  Every command argument
can be followed by whitespace, a comment, or a newline character.  Thus
a "syntactical line break" is defined to consist of optional syntactical
space that is optionally followed by a comment, and a newline character.

   The normal commands, those for positioning and text, consist of a
single letter taking a fixed number of arguments.  For historical
reasons, the parser allows to stack such commands on the same line, but
fortunately, in 'gtroff''s intermediate output, every command with at
least one argument is followed by a line break, thus providing excellent
readability.

   The other commands - those for drawing and device controlling - have
a more complicated structure; some recognize long command names, and
some take a variable number of arguments.  So all 'D' and 'x' commands
were designed to request a syntactical line break after their last
argument.  Only one command, 'x X', has an argument that can stretch
over several lines; all other commands must have all of their arguments
on the same line as the command, i.e., the arguments may not be split by
a line break.

   Empty lines (these are lines containing only space and/or a comment),
can occur everywhere.  They are just ignored.

Next: Document Parts,  Prev: Separation,  Up: Language Concepts

8.1.1.2 Argument Units
......................

Some commands take integer arguments that are assumed to represent
values in a measurement unit, but the letter for the corresponding scale
indicator is not written with the output command arguments.  Most
commands assume the scale indicator 'u', the basic unit of the device,
some use 'z', the scaled point unit of the device, while others, such as
the color commands, expect plain integers.

   Note that single characters can have the eighth bit set, as can the
names of fonts and special characters.  The names of characters and
fonts can be of arbitrary length.  A character that is to be printed is
always in the current font.

   A string argument is always terminated by the next whitespace
character (space, tab, or newline); an embedded '#' character is
regarded as part of the argument, not as the beginning of a comment
command.  An integer argument is already terminated by the next
non-digit character, which then is regarded as the first character of
the next argument or command.

Prev: Argument Units,  Up: Language Concepts

8.1.1.3 Document Parts
......................

A correct intermediate output document consists of two parts, the
"prologue" and the "body".

   The task of the prologue is to set the general device parameters
using three exactly specified commands.  'gtroff''s prologue is
guaranteed to consist of the following three lines (in that order):

     x T DEVICE
     x res N H V
     x init

with the arguments set as outlined in *note Device Control Commands::.
Note that the parser for the intermediate output format is able to
swallow additional whitespace and comments as well even in the prologue.

   The body is the main section for processing the document data.
Syntactically, it is a sequence of any commands different from the ones
used in the prologue.  Processing is terminated as soon as the first
'x stop' command is encountered; the last line of any 'gtroff'
intermediate output always contains such a command.

   Semantically, the body is page oriented.  A new page is started by a
'p' command.  Positioning, writing, and drawing commands are always done
within the current page, so they cannot occur before the first 'p'
command.  Absolute positioning (by the 'H' and 'V' commands) is done
relative to the current page; all other positioning is done relative to
the current location within this page.

Next: Intermediate Output Examples,  Prev: Language Concepts,  Up: gtroff Output

8.1.2 Command Reference
-----------------------

This section describes all intermediate output commands, both from AT&T
'troff' as well as the 'gtroff' extensions.

* Menu:

* Comment Command::
* Simple Commands::
* Graphics Commands::
* Device Control Commands::
* Obsolete Command::

Next: Simple Commands,  Prev: Command Reference,  Up: Command Reference

8.1.2.1 Comment Command
.......................

'#ANYTHING<end of line>'
     A comment.  Ignore any characters from the '#' character up to the
     next newline character.

     This command is the only possibility for commenting in the
     intermediate output.  Each comment can be preceded by arbitrary
     syntactical space; every command can be terminated by a comment.

Next: Graphics Commands,  Prev: Comment Command,  Up: Command Reference

8.1.2.2 Simple Commands
.......................

The commands in this subsection have a command code consisting of a
single character, taking a fixed number of arguments.  Most of them are
commands for positioning and text writing.  These commands are smart
about whitespace.  Optionally, syntactical space can be inserted before,
after, and between the command letter and its arguments.  All of these
commands are stackable, i.e., they can be preceded by other simple
commands or followed by arbitrary other commands on the same line.  A
separating syntactical space is only necessary when two integer
arguments would clash or if the preceding argument ends with a string
argument.

'C XXX<whitespace>'
     Print a special character named XXX.  The trailing syntactical
     space or line break is necessary to allow glyph names of arbitrary
     length.  The glyph is printed at the current print position; the
     glyph's size is read from the font file.  The print position is not
     changed.

'c G'
     Print glyph G at the current print position;(1) (*note Simple
     Commands-Footnote-1::) the glyph's size is read from the font file.
     The print position is not changed.

'f N'
     Set font to font number N (a non-negative integer).

'H N'
     Move right to the absolute vertical position N (a non-negative
     integer in basic units 'u' relative to left edge of current page.

'h N'
     Move N (a non-negative integer) basic units 'u' horizontally to the
     right.  The original UNIX troff manual allows negative values for N
     also, but 'gtroff' doesn't use this.

'm COLOR-SCHEME [COMPONENT ...]'
     Set the color for text (glyphs), line drawing, and the outline of
     graphic objects using different color schemes; the analoguous
     command for the filling color of graphic objects is 'DF'.  The
     color components are specified as integer arguments between 0 and
     65536.  The number of color components and their meaning vary for
     the different color schemes.  These commands are generated by
     'gtroff''s escape sequence '\m'.  No position changing.  These
     commands are a 'gtroff' extension.

     'mc CYAN MAGENTA YELLOW'
          Set color using the CMY color scheme, having the 3 color
          components CYAN, MAGENTA, and YELLOW.

     'md'
          Set color to the default color value (black in most cases).
          No component arguments.

     'mg GRAY'
          Set color to the shade of gray given by the argument, an
          integer between 0 (black) and 65536 (white).

     'mk CYAN MAGENTA YELLOW BLACK'
          Set color using the CMYK color scheme, having the 4 color
          components CYAN, MAGENTA, YELLOW, and BLACK.

     'mr RED GREEN BLUE'
          Set color using the RGB color scheme, having the 3 color
          components RED, GREEN, and BLUE.

'N N'
     Print glyph with index N (a non-negative integer) of the current
     font.  This command is a 'gtroff' extension.

'n B A'
     Inform the device about a line break, but no positioning is done by
     this command.  In AT&T 'troff', the integer arguments B and A
     informed about the space before and after the current line to make
     the intermediate output more human readable without performing any
     action.  In 'groff', they are just ignored, but they must be
     provided for compatibility reasons.

'p N'
     Begin a new page in the outprint.  The page number is set to N.
     This page is completely independent of pages formerly processed
     even if those have the same page number.  The vertical position on
     the outprint is automatically set to 0.  All positioning, writing,
     and drawing is always done relative to a page, so a 'p' command
     must be issued before any of these commands.

's N'
     Set point size to N scaled points (this is unit 'z').  AT&T 'troff'
     used the unit points ('p') instead.  *Note Output Language
     Compatibility::.

't XXX<whitespace>'
't XXX DUMMY-ARG<whitespace>'
     Print a word, i.e., a sequence of characters XXX representing
     output glyphs which names are single characters, terminated by a
     space character or a line break; an optional second integer
     argument is ignored (this allows the formatter to generate an even
     number of arguments).  The first glyph should be printed at the
     current position, the current horizontal position should then be
     increased by the width of the first glyph, and so on for each
     glyph.  The widths of the glyphs are read from the font file,
     scaled for the current point size, and rounded to a multiple of the
     horizontal resolution.  Special characters cannot be printed using
     this command (use the 'C' command for special characters).  This
     command is a 'gtroff' extension; it is only used for devices whose
     'DESC' file contains the 'tcommand' keyword (*note DESC File
     Format::).

'u N XXX<whitespace>'
     Print word with track kerning.  This is the same as the 't' command
     except that after printing each glyph, the current horizontal
     position is increased by the sum of the width of that glyph and N
     (an integer in basic units 'u').  This command is a 'gtroff'
     extension; it is only used for devices whose 'DESC' file contains
     the 'tcommand' keyword (*note DESC File Format::).

'V N'
     Move down to the absolute vertical position N (a non-negative
     integer in basic units 'u') relative to upper edge of current page.

'v N'
     Move N basic units 'u' down (N is a non-negative integer).  The
     original UNIX troff manual allows negative values for N also, but
     'gtroff' doesn't use this.

'w'
     Informs about a paddable white space to increase readability.  The
     spacing itself must be performed explicitly by a move command.

Next: Device Control Commands,  Prev: Simple Commands,  Up: Command Reference

8.1.2.3 Graphics Commands
.........................

Each graphics or drawing command in the intermediate output starts with
the letter 'D', followed by one or two characters that specify a
subcommand; this is followed by a fixed or variable number of integer
arguments that are separated by a single space character.  A 'D' command
may not be followed by another command on the same line (apart from a
comment), so each 'D' command is terminated by a syntactical line break.

   'gtroff' output follows the classical spacing rules (no space between
command and subcommand, all arguments are preceded by a single space
character), but the parser allows optional space between the command
letters and makes the space before the first argument optional.  As
usual, each space can be any sequence of tab and space characters.

   Some graphics commands can take a variable number of arguments.  In
this case, they are integers representing a size measured in basic units
'u'.  The arguments called H1, H2, ..., HN stand for horizontal
distances where positive means right, negative left.  The arguments
called V1, V2, ..., VN stand for vertical distances where positive means
down, negative up.  All these distances are offsets relative to the
current location.

   Each graphics command directly corresponds to a similar 'gtroff' '\D'
escape sequence.  *Note Drawing Requests::.

   Unknown 'D' commands are assumed to be device-specific.  Its
arguments are parsed as strings; the whole information is then sent to
the postprocessor.

   In the following command reference, the syntax element <line break>
means a syntactical line break as defined above.

'D~ H1 V1 H2 V2 ... HN VN<line break>'
     Draw B-spline from current position to offset (H1,V1), then to
     offset (H2,V2), if given, etc. up to (HN,VN).  This command takes a
     variable number of argument pairs; the current position is moved to
     the terminal point of the drawn curve.

'Da H1 V1 H2 V2<line break>'
     Draw arc from current position to (H1,V1)+(H2,V2) with center at
     (H1,V1); then move the current position to the final point of the
     arc.

'DC D<line break>'
'DC D DUMMY-ARG<line break>'
     Draw a solid circle using the current fill color with diameter D
     (integer in basic units 'u') with leftmost point at the current
     position; then move the current position to the rightmost point of
     the circle.  An optional second integer argument is ignored (this
     allows the formatter to generate an even number of arguments).
     This command is a 'gtroff' extension.

'Dc D<line break>'
     Draw circle line with diameter D (integer in basic units 'u') with
     leftmost point at the current position; then move the current
     position to the rightmost point of the circle.

'DE H V<line break>'
     Draw a solid ellipse in the current fill color with a horizontal
     diameter of H and a vertical diameter of V (both integers in basic
     units 'u') with the leftmost point at the current position; then
     move to the rightmost point of the ellipse.  This command is a
     'gtroff' extension.

'De H V<line break>'
     Draw an outlined ellipse with a horizontal diameter of H and a
     vertical diameter of V (both integers in basic units 'u') with the
     leftmost point at current position; then move to the rightmost
     point of the ellipse.

'DF COLOR-SCHEME [COMPONENT ...]<line break>'
     Set fill color for solid drawing objects using different color
     schemes; the analoguous command for setting the color of text, line
     graphics, and the outline of graphic objects is 'm'.  The color
     components are specified as integer arguments between 0 and 65536.
     The number of color components and their meaning vary for the
     different color schemes.  These commands are generated by
     'gtroff''s escape sequences '\D'F ...'' and '\M' (with no other
     corresponding graphics commands).  No position changing.  This
     command is a 'gtroff' extension.

     'DFc CYAN MAGENTA YELLOW<line break>'
          Set fill color for solid drawing objects using the CMY color
          scheme, having the 3 color components CYAN, MAGENTA, and
          YELLOW.

     'DFd<line break>'
          Set fill color for solid drawing objects to the default fill
          color value (black in most cases).  No component arguments.

     'DFg GRAY<line break>'
          Set fill color for solid drawing objects to the shade of gray
          given by the argument, an integer between 0 (black) and 65536
          (white).

     'DFk CYAN MAGENTA YELLOW BLACK<line break>'
          Set fill color for solid drawing objects using the CMYK color
          scheme, having the 4 color components CYAN, MAGENTA, YELLOW,
          and BLACK.

     'DFr RED GREEN BLUE<line break>'
          Set fill color for solid drawing objects using the RGB color
          scheme, having the 3 color components RED, GREEN, and BLUE.

'Df N<line break>'
     The argument N must be an integer in the range -32767 to 32767.

     0 <= N <= 1000
          Set the color for filling solid drawing objects to a shade of
          gray, where 0 corresponds to solid white, 1000 (the default)
          to solid black, and values in between to intermediate shades
          of gray; this is obsoleted by command 'DFg'.

     N < 0 or N > 1000
          Set the filling color to the color that is currently being
          used for the text and the outline, see command 'm'.  For
          example, the command sequence

               mg 0 0 65536
               Df -1

          sets all colors to blue.

     No position changing.  This command is a 'gtroff' extension.

'Dl H V<line break>'
     Draw line from current position to offset (H,V) (integers in basic
     units 'u'); then set current position to the end of the drawn line.

'Dp H1 V1 H2 V2 ... HN VN<line break>'
     Draw a polygon line from current position to offset (H1,V1), from
     there to offset (H2,V2), etc. up to offset (HN,VN), and from there
     back to the starting position.  For historical reasons, the
     position is changed by adding the sum of all arguments with odd
     index to the actual horizontal position and the even ones to the
     vertical position.  Although this doesn't make sense it is kept for
     compatibility.  This command is a 'gtroff' extension.

'Dp H1 V1 H2 V2 ... HN VN<line break>'
     Draw a solid polygon in the current fill color rather than an
     outlined polygon, using the same arguments and positioning as the
     corresponding 'Dp' command.  This command is a 'gtroff' extension.

'Dt N<line break>'
     Set the current line thickness to N (an integer in basic units 'u')
     if N>0; if N=0 select the smallest available line thickness; if N<0
     set the line thickness proportional to the point size (this is the
     default before the first 'Dt' command was specified).  For
     historical reasons, the horizontal position is changed by adding
     the argument to the actual horizontal position, while the vertical
     position is not changed.  Although this doesn't make sense it is
     kept for compatibility.  This command is a 'gtroff' extension.

Next: Obsolete Command,  Prev: Graphics Commands,  Up: Command Reference

8.1.2.4 Device Control Commands
...............................

Each device control command starts with the letter 'x', followed by a
space character (optional or arbitrary space or tab in 'gtroff') and a
subcommand letter or word; each argument (if any) must be preceded by a
syntactical space.  All 'x' commands are terminated by a syntactical
line break; no device control command can be followed by another command
on the same line (except a comment).

   The subcommand is basically a single letter, but to increase
readability, it can be written as a word, i.e., an arbitrary sequence of
characters terminated by the next tab, space, or newline character.  All
characters of the subcommand word but the first are simply ignored.  For
example, 'gtroff' outputs the initialization command 'x i' as 'x init'
and the resolution command 'x r' as 'x res'.

   In the following, the syntax element <line break> means a syntactical
line break (*note Separation::).

'xF NAME<line break>'
     The 'F' stands for FILENAME.

     Use NAME as the intended name for the current file in error
     reports.  This is useful for remembering the original file name
     when 'gtroff' uses an internal piping mechanism.  The input file is
     not changed by this command.  This command is a 'gtroff' extension.

'xf N S<line break>'
     The 'f' stands for FONT.

     Mount font position N (a non-negative integer) with font named S (a
     text word).  *Note Font Positions::.

'xH N<line break>'
     The 'H' stands for HEIGHT.

     Set glyph height to N (a positive integer in scaled points 'z').
     AT&T 'troff' uses the unit points ('p') instead.  *Note Output
     Language Compatibility::.

'xi<line break>'
     The 'i' stands for INIT.

     Initialize device.  This is the third command of the prologue.

'xp<line break>'
     The 'p' stands for PAUSE.

     Parsed but ignored.  The original UNIX troff manual writes

          pause device, can be restarted

'xr N H V<line break>'
     The 'r' stands for RESOLUTION.

     Resolution is N, while H is the minimal horizontal motion, and V
     the minimal vertical motion possible with this device; all
     arguments are positive integers in basic units 'u' per inch.  This
     is the second command of the prologue.

'xS N<line break>'
     The 'S' stands for SLANT.

     Set slant to N (an integer in basic units 'u').

'xs<line break>'
     The 's' stands for STOP.

     Terminates the processing of the current file; issued as the last
     command of any intermediate troff output.

'xt<line break>'
     The 't' stands for TRAILER.

     Generate trailer information, if any.  In GTROFF, this is actually
     just ignored.

'xT XXX<line break>'
     The 'T' stands for TYPESETTER.

     Set name of device to word XXX, a sequence of characters ended by
     the next white space character.  The possible device names coincide
     with those from the 'groff' '-T' option.  This is the first command
     of the prologue.

'xu N<line break>'
     The 'u' stands for UNDERLINE.

     Configure underlining of spaces.  If N is 1, start underlining of
     spaces; if N is 0, stop underlining of spaces.  This is needed for
     the 'cu' request in nroff mode and is ignored otherwise.  This
     command is a 'gtroff' extension.

'xX ANYTHING<line break>'
     The 'x' stands for X-ESCAPE.

     Send string ANYTHING uninterpreted to the device.  If the line
     following this command starts with a '+' character this line is
     interpreted as a continuation line in the following sense.  The '+'
     is ignored, but a newline character is sent instead to the device,
     the rest of the line is sent uninterpreted.  The same applies to
     all following lines until the first character of a line is not a
     '+' character.  This command is generated by the 'gtroff' escape
     sequence '\X'.  The line-continuing feature is a 'gtroff'
     extension.

Prev: Device Control Commands,  Up: Command Reference

8.1.2.5 Obsolete Command
........................

In AT&T 'troff' output, the writing of a single glyph is mostly done by
a very strange command that combines a horizontal move and a single
character giving the glyph name.  It doesn't have a command code, but is
represented by a 3-character argument consisting of exactly 2 digits and
a character.

DDG
     Move right DD (exactly two decimal digits) basic units 'u', then
     print glyph G (represented as a single character).

     In 'gtroff', arbitrary syntactical space around and within this
     command is allowed to be added.  Only when a preceding command on
     the same line ends with an argument of variable length a separating
     space is obligatory.  In AT&T 'troff', large clusters of these and
     other commands are used, mostly without spaces; this made such
     output almost unreadable.

   For modern high-resolution devices, this command does not make sense
because the width of the glyphs can become much larger than two decimal
digits.  In 'gtroff', this is only used for the devices 'X75', 'X75-12',
'X100', and 'X100-12'.  For other devices, the commands 't' and 'u'
provide a better functionality.

Next: Output Language Compatibility,  Prev: Command Reference,  Up: gtroff Output

8.1.3 Intermediate Output Examples
----------------------------------

This section presents the intermediate output generated from the same
input for three different devices.  The input is the sentence 'hell
world' fed into 'gtroff' on the command line.

High-resolution device 'ps'

     This is the standard output of 'gtroff' if no '-T' option is given.

          shell> echo "hell world" | groff -Z -T ps

          x T ps
          x res 72000 1 1
          x init
          p1
          x font 5 TR
          f5
          s10000
          V12000
          H72000
          thell
          wh2500
          tw
          H96620
          torld
          n12000 0
          x trailer
          V792000
          x stop

     This output can be fed into 'grops' to get its representation as a
     POSTSCRIPT file.

Low-resolution device 'latin1'

     This is similar to the high-resolution device except that the
     positioning is done at a minor scale.  Some comments (lines
     starting with '#') were added for clarification; they were not
     generated by the formatter.

          shell> echo "hell world" | groff -Z -T latin1

          # prologue
          x T latin1
          x res 240 24 40
          x init
          # begin a new page
          p1
          # font setup
          x font 1 R
          f1
          s10
          # initial positioning on the page
          V40
          H0
          # write text `hell'
          thell
          # inform about space, and issue a horizontal jump
          wh24
          # write text `world'
          tworld
          # announce line break, but do nothing because ...
          n40 0
          # ... the end of the document has been reached
          x trailer
          V2640
          x stop

     This output can be fed into 'grotty' to get a formatted text
     document.

AT&T 'troff' output
     Since a computer monitor has a very low resolution compared to
     modern printers the intermediate output for the X Window devices
     can use the jump-and-write command with its 2-digit displacements.

          shell> echo "hell world" | groff -Z -T X100

          x T X100
          x res 100 1 1
          x init
          p1
          x font 5 TR
          f5
          s10
          V16
          H100
          # write text with jump-and-write commands
          ch07e07l03lw06w11o07r05l03dh7
          n16 0
          x trailer
          V1100
          x stop

     This output can be fed into 'xditview' or 'gxditview' for
     displaying in X.

     Due to the obsolete jump-and-write command, the text clusters in
     the AT&T 'troff' output are almost unreadable.

Prev: Intermediate Output Examples,  Up: gtroff Output

8.1.4 Output Language Compatibility
-----------------------------------

The intermediate output language of AT&T 'troff' was first documented in
the UNIX troff manual, with later additions documented in 'A
Typesetter-indenpendent TROFF', written by Brian Kernighan.

   The 'gtroff' intermediate output format is compatible with this
specification except for the following features.

   * The classical quasi device independence is not yet implemented.

   * The old hardware was very different from what we use today.  So the
     'groff' devices are also fundamentally different from the ones in
     AT&T 'troff'.  For example, the AT&T POSTSCRIPT device is called
     'post' and has a resolution of only 720 units per inch, suitable
     for printers 20 years ago, while 'groff''s 'ps' device has a
     resolution of 72000 units per inch.  Maybe, by implementing some
     rescaling mechanism similar to the classical quasi device
     independence, 'groff' could emulate AT&T's 'post' device.

   * The B-spline command 'D~' is correctly handled by the intermediate
     output parser, but the drawing routines aren't implemented in some
     of the postprocessor programs.

   * The argument of the commands 's' and 'x H' has the implicit unit
     scaled point 'z' in 'gtroff', while AT&T 'troff' has point ('p').
     This isn't an incompatibility but a compatible extension, for both
     units coincide for all devices without a 'sizescale' parameter in
     the 'DESC' file, including all postprocessors from AT&T and
     'groff''s text devices.  The few 'groff' devices with a 'sizescale'
     parameter either do not exist for AT&T 'troff', have a different
     name, or seem to have a different resolution.  So conflicts are
     very unlikely.

   * The position changing after the commands 'Dp', 'DP', and 'Dt' is
     illogical, but as old versions of 'gtroff' used this feature it is
     kept for compatibility reasons.

Prev: gtroff Output,  Up: File formats

8.2 Font Files
==============

The 'gtroff' font format is roughly a superset of the 'ditroff' font
format (as used in later versions of AT&T 'troff' and its descendants).
Unlike the 'ditroff' font format, there is no associated binary format;
all files are text files.(1)  (*note Font Files-Footnote-1::) The font
files for device NAME are stored in a directory 'devNAME'.  There are
two types of file: a device description file called 'DESC' and for each
font F a font file called 'F'.

* Menu:

* DESC File Format::
* Font File Format::

Next: Font File Format,  Prev: Font Files,  Up: Font Files

8.2.1 'DESC' File Format
------------------------

The 'DESC' file can contain the following types of line.  Except for the
'charset' keyword, which must comes last (if at all), the order of the
lines is not important.  Later entries in the file, however, override
previous values.

'charset'
     This line and everything following in the file are ignored.  It is
     allowed for the sake of backwards compatibility.

'family FAM'
     The default font family is FAM.

'fonts N F1 F2 F3 ... FN'
     Fonts F1 ... FN are mounted in the font positions M+1, ..., M+N
     where M is the number of styles.  This command may extend over more
     than one line.  A font name of 0 means no font is mounted on the
     corresponding font position.

'hor N'
     The horizontal resolution is N machine units.  All horizontal
     quantities are rounded to be multiples of this value.

'image_generator STRING'
     Needed for 'grohtml' only.  It specifies the program to generate
     PNG images from POSTSCRIPT input.  Under GNU/Linux this is usually
     'gs' but under other systems (notably cygwin) it might be set to
     another name.

'paperlength N'
     The physical vertical dimension of the output medium in machine
     units.  This isn't used by 'troff' itself but by output devices.
     Deprecated.  Use 'papersize' instead.

'papersize STRING ...'
     Select a paper size.  Valid values for STRING are the ISO paper
     types 'A0'-'A7', 'B0'-'B7', 'C0'-'C7', 'D0'-'D7', 'DL', and the US
     paper types 'letter', 'legal', 'tabloid', 'ledger', 'statement',
     'executive', 'com10', and 'monarch'.  Case is not significant for
     STRING if it holds predefined paper types.  Alternatively, STRING
     can be a file name (e.g. '/etc/papersize'); if the file can be
     opened, 'groff' reads the first line and tests for the above paper
     sizes.  Finally, STRING can be a custom paper size in the format
     'LENGTH,WIDTH' (no spaces before and after the comma).  Both LENGTH
     and WIDTH must have a unit appended; valid values are 'i' for
     inches, 'C' for centimeters, 'p' for points, and 'P' for picas.
     Example: '12c,235p'.  An argument that starts with a digit is
     always treated as a custom paper format.  'papersize' sets both the
     vertical and horizontal dimension of the output medium.

     More than one argument can be specified; 'groff' scans from left to
     right and uses the first valid paper specification.

'paperwidth N'
     The physical horizontal dimension of the output medium in machine
     units.  This isn't used by 'troff' itself but by output devices.
     Deprecated.  Use 'papersize' instead.

'pass_filenames'
     Tell 'gtroff' to emit the name of the source file currently being
     processed.  This is achieved by the intermediate output command
     'F'.  Currently, this is only used by the 'grohtml' output device.

'postpro PROGRAM'
     Call PROGRAM as a postprocessor.  For example, the line

          postpro grodvi

     in the file 'devdvi/DESC' makes 'groff' call 'grodvi' if option
     '-Tdvi' is given (and '-Z' isn't used).

'prepro PROGRAM'
     Call PROGRAM as a preprocessor.  Currently, this keyword is used by
     'groff' with option '-Thtml' or '-Txhtml' only.

'print PROGRAM'
     Use PROGRAM as a spooler program for printing.  If omitted, the
     '-l' and '-L' options of 'groff' are ignored.

'res N'
     There are N machine units per inch.

'sizes S1 S2 ... SN 0'
     This means that the device has fonts at S1, S2, ... SN scaled
     points.  The list of sizes must be terminated by 0 (this is digit
     zero).  Each SI can also be a range of sizes M-N.  The list can
     extend over more than one line.

'sizescale N'
     The scale factor for point sizes.  By default this has a value
     of 1.  One scaled point is equal to one point/N.  The arguments to
     the 'unitwidth' and 'sizes' commands are given in scaled points.
     *Note Fractional Type Sizes::, for more information.

'styles S1 S2 ... SM'
     The first M font positions are associated with styles S1 ... SM.

'tcommand'
     This means that the postprocessor can handle the 't' and 'u'
     intermediate output commands.

'unicode'
     Indicate that the output device supports the complete Unicode
     repertoire.  Useful only for devices that produce _character
     entities_ instead of glyphs.

     If 'unicode' is present, no 'charset' section is required in the
     font description files since the Unicode handling built into
     'groff' is used.  However, if there are entries in a 'charset'
     section, they either override the default mappings for those
     particular characters or add new mappings (normally for composite
     characters).

     This is used for '-Tutf8', '-Thtml', and '-Txhtml'.

'unitwidth N'
     Quantities in the font files are given in machine units for fonts
     whose point size is N scaled points.

'unscaled_charwidths'
     Make the font handling module always return unscaled character
     widths.  Needed for the 'grohtml' device.

'use_charnames_in_special'
     This command indicates that 'gtroff' should encode special
     characters inside special commands.  Currently, this is only used
     by the 'grohtml' output device.  *Note Postprocessor Access::.

'vert N'
     The vertical resolution is N machine units.  All vertical
     quantities are rounded to be multiples of this value.

   The 'res', 'unitwidth', 'fonts', and 'sizes' lines are mandatory.
Other commands are ignored by 'gtroff' but may be used by postprocessors
to store arbitrary information about the device in the 'DESC' file.

   Here a list of obsolete keywords that are recognized by 'groff' but
completely ignored: 'spare1', 'spare2', 'biggestfont'.

Prev: DESC File Format,  Up: Font Files

8.2.2 Font File Format
----------------------

A "font file", also (and probably better) called a "font description
file", has two sections.  The first section is a sequence of lines each
containing a sequence of blank delimited words; the first word in the
line is a key, and subsequent words give a value for that key.

'name F'
     The name of the font is F.

'spacewidth N'
     The normal width of a space is N.

'slant N'
     The glyphs of the font have a slant of N degrees.  (Positive means
     forward.)

'ligatures LIG1 LIG2 ... LIGN [0]'
     Glyphs LIG1, LIG2, ..., LIGN are ligatures; possible ligatures are
     'ff', 'fi', 'fl', 'ffi' and 'ffl'.  For backwards compatibility,
     the list of ligatures may be terminated with a 0.  The list of
     ligatures may not extend over more than one line.

'special'
     The font is "special"; this means that when a glyph is requested
     that is not present in the current font, it is searched for in any
     special fonts that are mounted.

   Other commands are ignored by 'gtroff' but may be used by
postprocessors to store arbitrary information about the font in the font
file.

   The first section can contain comments, which start with the '#'
character and extend to the end of a line.

   The second section contains one or two subsections.  It must contain
a 'charset' subsection and it may also contain a 'kernpairs' subsection.
These subsections can appear in any order.  Each subsection starts with
a word on a line by itself.

   The word 'charset' starts the character set subsection.(1)  (*note
Font File Format-Footnote-1::) The 'charset' line is followed by a
sequence of lines.  Each line gives information for one glyph.  A line
comprises a number of fields separated by blanks or tabs.  The format is

     NAME METRICS TYPE CODE [ENTITY-NAME] ['--' COMMENT]

NAME identifies the glyph name(2) (*note Font File Format-Footnote-2::):
If NAME is a single character C then it corresponds to the 'gtroff'
input character C; if it is of the form '\C' where C is a single
character, then it corresponds to the special character '\[C]';
otherwise it corresponds to the special character '\[NAME]'.  If it is
exactly two characters XX it can be entered as '\(XX'.  Note that
single-letter special characters can't be accessed as '\C'; the only
exception is '\-', which is identical to '\[-]'.

   'gtroff' supports 8-bit input characters; however some utilities have
difficulties with eight-bit characters.  For this reason, there is a
convention that the entity name 'charN' is equivalent to the single
input character whose code is N.  For example, 'char163' would be
equivalent to the character with code 163, which is the pounds sterling
sign in the ISO Latin-1 character set.  You shouldn't use 'charN'
entities in font description files since they are related to input, not
output.  Otherwise, you get hard-coded connections between input and
output encoding, which prevents use of different (input) character sets.

   The name '---' is special and indicates that the glyph is unnamed;
such glyphs can only be used by means of the '\N' escape sequence in
'gtroff'.

   The TYPE field gives the glyph type:

'1'
     the glyph has a descender, for example, 'p';

'2'
     the glyph has an ascender, for example, 'b';

'3'
     the glyph has both an ascender and a descender, for example, '('.

   The CODE field gives the code that the postprocessor uses to print
the glyph.  The glyph can also be input to 'gtroff' using this code by
means of the '\N' escape sequence.  CODE can be any integer.  If it
starts with '0' it is interpreted as octal; if it starts with '0x' or
'0X' it is interpreted as hexadecimal.  Note, however, that the '\N'
escape sequence only accepts a decimal integer.

   The ENTITY-NAME field gives an ASCII string identifying the glyph
that the postprocessor uses to print the 'gtroff' glyph NAME.  This
field is optional and has been introduced so that the 'grohtml' device
driver can encode its character set.  For example, the glyph '\[Po]' is
represented as '&pound;' in HTML 4.0.

   Anything on the line after the ENTITY-NAME field resp. after '--' is
ignored.

   The METRICS field has the form:

     WIDTH[','HEIGHT[','DEPTH[','ITALIC-CORRECTION
       [','LEFT-ITALIC-CORRECTION[','SUBSCRIPT-CORRECTION]]]]]

There must not be any spaces between these subfields (it has been split
here into two lines for better legibility only).  Missing subfields are
assumed to be 0.  The subfields are all decimal integers.  Since there
is no associated binary format, these values are not required to fit
into a variable of type 'char' as they are in 'ditroff'.  The WIDTH
subfield gives the width of the glyph.  The HEIGHT subfield gives the
height of the glyph (upwards is positive); if a glyph does not extend
above the baseline, it should be given a zero height, rather than a
negative height.  The DEPTH subfield gives the depth of the glyph, that
is, the distance from the baseline to the lowest point below the
baseline to which the glyph extends (downwards is positive); if a glyph
does not extend below the baseline, it should be given a zero depth,
rather than a negative depth.  The ITALIC-CORRECTION subfield gives the
amount of space that should be added after the glyph when it is
immediately to be followed by a glyph from a roman font.  The
LEFT-ITALIC-CORRECTION subfield gives the amount of space that should be
added before the glyph when it is immediately to be preceded by a glyph
from a roman font.  The SUBSCRIPT-CORRECTION gives the amount of space
that should be added after a glyph before adding a subscript.  This
should be less than the italic correction.

   A line in the 'charset' section can also have the format

     NAME "

This indicates that NAME is just another name for the glyph mentioned in
the preceding line.

   The word 'kernpairs' starts the kernpairs section.  This contains a
sequence of lines of the form:

     C1 C2 N

This means that when glyph C1 appears next to glyph C2 the space between
them should be increased by N.  Most entries in the kernpairs section
have a negative value for N.

Next: Copying This Manual,  Prev: File formats,  Up: Top

9 Installation
**************

Next: Request Index,  Prev: Installation,  Up: Top

Appendix A Copying This Manual
******************************

                     Version 1.3, 3 November 2008

     Copyright © 2000, 2001, 2002, 2007, 2008 Free Software Foundation, Inc.
     <http://fsf.org/>

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

     The "publisher" means any person or entity that distributes copies
     of the Document to the public.

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
     except as expressly provided under this License.  Any attempt
     otherwise to copy, modify, sublicense, or distribute it is void,
     and will automatically terminate your rights under this License.

     However, if you cease all violation of this License, then your
     license from a particular copyright holder is reinstated (a)
     provisionally, unless and until the copyright holder explicitly and
     finally terminates your license, and (b) permanently, if the
     copyright holder fails to notify you of the violation by some
     reasonable means prior to 60 days after the cessation.

     Moreover, your license from a particular copyright holder is
     reinstated permanently if the copyright holder notifies you of the
     violation by some reasonable means, this is the first time you have
     received notice of violation of this License (for any work) from
     that copyright holder, and you cure the violation prior to 30 days
     after your receipt of the notice.

     Termination of your rights under this section does not terminate
     the licenses of parties who have received copies or rights from you
     under this License.  If your rights have been terminated and not
     permanently reinstated, receipt of a copy of some or all of the
     same material does not give you any rights to use it.

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
     Software Foundation.  If the Document specifies that a proxy can
     decide which future versions of this License can be used, that
     proxy's public statement of acceptance of a version permanently
     authorizes you to choose that version for the Document.

  11. RELICENSING

     "Massive Multiauthor Collaboration Site" (or "MMC Site") means any
     World Wide Web server that publishes copyrightable works and also
     provides prominent facilities for anybody to edit those works.  A
     public wiki that anybody can edit is an example of such a server.
     A "Massive Multiauthor Collaboration" (or "MMC") contained in the
     site means any set of copyrightable works thus published on the MMC
     site.

     "CC-BY-SA" means the Creative Commons Attribution-Share Alike 3.0
     license published by Creative Commons Corporation, a not-for-profit
     corporation with a principal place of business in San Francisco,
     California, as well as future copyleft versions of that license
     published by that same organization.

     "Incorporate" means to publish or republish a Document, in whole or
     in part, as part of another Document.

     An MMC is "eligible for relicensing" if it is licensed under this
     License, and if all works that were first published under this
     License somewhere other than this MMC, and subsequently
     incorporated in whole or in part into the MMC, (1) had no cover
     texts or invariant sections, and (2) were thus incorporated prior
     to November 1, 2008.

     The operator of an MMC Site may republish an MMC contained in the
     site under CC-BY-SA on the same site at any time before August 1,
     2009, provided the MMC is eligible for relicensing.

ADDENDUM: How to use this License for your documents
====================================================

To use this License in a document you have written, include a copy of
the License in the document and put the following copyright and license
notices just after the title page:

       Copyright (C)  YEAR  YOUR NAME.
       Permission is granted to copy, distribute and/or modify this document
       under the terms of the GNU Free Documentation License, Version 1.3
       or any later version published by the Free Software Foundation;
       with no Invariant Sections, no Front-Cover Texts, and no Back-Cover
       Texts.  A copy of the license is included in the section entitled ``GNU
       Free Documentation License''.

   If you have Invariant Sections, Front-Cover Texts and Back-Cover
Texts, replace the "with...Texts." line with this:

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

Next: Escape Index,  Prev: Copying This Manual,  Up: Top

Appendix B Request Index
************************

Requests appear without the leading control character (normally either
'.' or ''').


* Menu:

* ab:                                    Debugging.           (line  40)
* ad:                                    Manipulating Filling and Adjusting.
                                                              (line  50)
* af:                                    Assigning Formats.   (line  12)
* aln:                                   Setting Registers.   (line 112)
* als:                                   Strings.             (line 229)
* am:                                    Writing Macros.      (line 113)
* am1:                                   Writing Macros.      (line 114)
* ami:                                   Writing Macros.      (line 115)
* ami1:                                  Writing Macros.      (line 116)
* as:                                    Strings.             (line 175)
* as1:                                   Strings.             (line 176)
* asciify:                               Diversions.          (line 195)
* backtrace:                             Debugging.           (line  96)
* bd:                                    Artificial Fonts.    (line  96)
* blm:                                   Blank Line Traps.    (line   7)
* box:                                   Diversions.          (line  34)
* boxa:                                  Diversions.          (line  35)
* bp:                                    Page Control.        (line   7)
* br:                                    Manipulating Filling and Adjusting.
                                                              (line  12)
* break:                                 while.               (line  68)
* brp:                                   Manipulating Filling and Adjusting.
                                                              (line 130)
* c2:                                    Character Translations.
                                                              (line  16)
* cc:                                    Character Translations.
                                                              (line  10)
* ce:                                    Manipulating Filling and Adjusting.
                                                              (line 203)
* cf:                                    I/O.                 (line  50)
* cflags:                                Using Symbols.       (line 237)
* ch:                                    Page Location Traps. (line 111)
* char:                                  Using Symbols.       (line 323)
* chop:                                  Strings.             (line 267)
* class:                                 Character Classes.   (line  12)
* close:                                 I/O.                 (line 231)
* color:                                 Colors.              (line   7)
* composite:                             Using Symbols.       (line 191)
* continue:                              while.               (line  72)
* cp:                                    Implementation Differences.
                                                              (line  22)
* cs:                                    Artificial Fonts.    (line 126)
* cu:                                    Artificial Fonts.    (line  86)
* da:                                    Diversions.          (line  22)
* de:                                    Writing Macros.      (line  15)
* de1:                                   Writing Macros.      (line  16)
* defcolor:                              Colors.              (line  22)
* dei:                                   Writing Macros.      (line  17)
* dei1:                                  Writing Macros.      (line  18)
* device:                                Postprocessor Access.
                                                              (line  11)
* devicem:                               Postprocessor Access.
                                                              (line  30)
* di:                                    Diversions.          (line  21)
* do:                                    Implementation Differences.
                                                              (line  23)
* ds:                                    Strings.             (line  15)
* ds1:                                   Strings.             (line  16)
* dt:                                    Diversion Traps.     (line   7)
* ec:                                    Character Translations.
                                                              (line  47)
* ecr:                                   Character Translations.
                                                              (line  59)
* ecs:                                   Character Translations.
                                                              (line  58)
* el:                                    if-else.             (line  27)
* em:                                    End-of-input Traps.  (line   7)
* eo:                                    Character Translations.
                                                              (line  24)
* ev:                                    Environments.        (line  38)
* evc:                                   Environments.        (line  70)
* ex:                                    Debugging.           (line  45)
* fam:                                   Font Families.       (line  20)
* fc:                                    Fields.              (line  18)
* fchar:                                 Using Symbols.       (line 324)
* fcolor:                                Colors.              (line  80)
* fi:                                    Manipulating Filling and Adjusting.
                                                              (line  28)
* fl:                                    Debugging.           (line  87)
* fp:                                    Font Positions.      (line  11)
* fschar:                                Using Symbols.       (line 325)
* fspecial:                              Special Fonts.       (line  18)
* ft:                                    Changing Fonts.      (line   7)
* ft <1>:                                Font Positions.      (line  57)
* ftr:                                   Changing Fonts.      (line  55)
* fzoom:                                 Changing Fonts.      (line  70)
* gcolor:                                Colors.              (line  50)
* hc:                                    Manipulating Hyphenation.
                                                              (line 105)
* hcode:                                 Manipulating Hyphenation.
                                                              (line 175)
* hla:                                   Manipulating Hyphenation.
                                                              (line 255)
* hlm:                                   Manipulating Hyphenation.
                                                              (line  45)
* hpf:                                   Manipulating Hyphenation.
                                                              (line 114)
* hpfa:                                  Manipulating Hyphenation.
                                                              (line 115)
* hpfcode:                               Manipulating Hyphenation.
                                                              (line 116)
* hw:                                    Manipulating Hyphenation.
                                                              (line  62)
* hy:                                    Manipulating Hyphenation.
                                                              (line   9)
* hym:                                   Manipulating Hyphenation.
                                                              (line 210)
* hys:                                   Manipulating Hyphenation.
                                                              (line 226)
* ie:                                    if-else.             (line  26)
* if:                                    if-else.             (line  10)
* ig:                                    Comments.            (line  63)
* in:                                    Line Layout.         (line  86)
* it:                                    Input Line Traps.    (line   7)
* itc:                                   Input Line Traps.    (line   8)
* kern:                                  Ligatures and Kerning.
                                                              (line  41)
* lc:                                    Leaders.             (line  23)
* length:                                Strings.             (line 211)
* lf:                                    Debugging.           (line  10)
* lg:                                    Ligatures and Kerning.
                                                              (line  23)
* linetabs:                              Tabs and Fields.     (line 137)
* ll:                                    Line Layout.         (line 140)
* ls:                                    Manipulating Spacing.
                                                              (line  63)
* lsm:                                   Leading Spaces Traps.
                                                              (line   7)
* lt:                                    Page Layout.         (line  64)
* mc:                                    Miscellaneous.       (line  75)
* mk:                                    Page Motions.        (line  10)
* mso:                                   I/O.                 (line  40)
* na:                                    Manipulating Filling and Adjusting.
                                                              (line 122)
* ne:                                    Page Control.        (line  33)
* nf:                                    Manipulating Filling and Adjusting.
                                                              (line  39)
* nh:                                    Manipulating Hyphenation.
                                                              (line  37)
* nm:                                    Miscellaneous.       (line  10)
* nn:                                    Miscellaneous.       (line  71)
* nop:                                   if-else.             (line  23)
* nr:                                    Setting Registers.   (line  13)
* nr <1>:                                Setting Registers.   (line  68)
* nr <2>:                                Auto-increment.      (line  11)
* nroff:                                 Troff and Nroff Mode.
                                                              (line  32)
* ns:                                    Manipulating Spacing.
                                                              (line 121)
* nx:                                    I/O.                 (line  84)
* open:                                  I/O.                 (line 199)
* opena:                                 I/O.                 (line 200)
* os:                                    Page Control.        (line  53)
* output:                                Diversions.          (line 180)
* pc:                                    Page Layout.         (line  94)
* pev:                                   Debugging.           (line  62)
* pi:                                    I/O.                 (line 143)
* pl:                                    Page Layout.         (line  10)
* pm:                                    Debugging.           (line  66)
* pn:                                    Page Layout.         (line  81)
* pnr:                                   Debugging.           (line  77)
* po:                                    Line Layout.         (line  58)
* ps:                                    Changing Type Sizes. (line   7)
* psbb:                                  Miscellaneous.       (line 135)
* pso:                                   I/O.                 (line  29)
* ptr:                                   Debugging.           (line  81)
* pvs:                                   Changing Type Sizes. (line 134)
* rchar:                                 Using Symbols.       (line 381)
* rd:                                    I/O.                 (line  89)
* return:                                Writing Macros.      (line 147)
* rfschar:                               Using Symbols.       (line 382)
* rj:                                    Manipulating Filling and Adjusting.
                                                              (line 249)
* rm:                                    Strings.             (line 224)
* rn:                                    Strings.             (line 221)
* rnn:                                   Setting Registers.   (line 108)
* rr:                                    Setting Registers.   (line 104)
* rs:                                    Manipulating Spacing.
                                                              (line 122)
* rt:                                    Page Motions.        (line  11)
* schar:                                 Using Symbols.       (line 326)
* shc:                                   Manipulating Hyphenation.
                                                              (line 243)
* shift:                                 Parameters.          (line  31)
* sizes:                                 Changing Type Sizes. (line  69)
* so:                                    I/O.                 (line   9)
* sp:                                    Manipulating Spacing.
                                                              (line   7)
* special:                               Special Fonts.       (line  17)
* spreadwarn:                            Debugging.           (line 131)
* ss:                                    Manipulating Filling and Adjusting.
                                                              (line 149)
* sty:                                   Font Families.       (line  59)
* substring:                             Strings.             (line 192)
* sv:                                    Page Control.        (line  52)
* sy:                                    I/O.                 (line 164)
* ta:                                    Tabs and Fields.     (line  14)
* tc:                                    Tabs and Fields.     (line 129)
* ti:                                    Line Layout.         (line 112)
* tkf:                                   Ligatures and Kerning.
                                                              (line  60)
* tl:                                    Page Layout.         (line  35)
* tm:                                    Debugging.           (line  25)
* tm1:                                   Debugging.           (line  26)
* tmc:                                   Debugging.           (line  27)
* tr:                                    Character Translations.
                                                              (line 148)
* trf:                                   I/O.                 (line  49)
* trin:                                  Character Translations.
                                                              (line 149)
* trnt:                                  Character Translations.
                                                              (line 237)
* troff:                                 Troff and Nroff Mode.
                                                              (line  24)
* uf:                                    Artificial Fonts.    (line  90)
* ul:                                    Artificial Fonts.    (line  64)
* unformat:                              Diversions.          (line 218)
* vpt:                                   Page Location Traps. (line  17)
* vs:                                    Changing Type Sizes. (line  85)
* warn:                                  Debugging.           (line 154)
* warnscale:                             Debugging.           (line 127)
* wh:                                    Page Location Traps. (line  29)
* while:                                 while.               (line  10)
* write:                                 I/O.                 (line 211)
* writec:                                I/O.                 (line 212)
* writem:                                I/O.                 (line 222)

Next: Operator Index,  Prev: Request Index,  Up: Top

Appendix C Escape Index
***********************

Any escape sequence '\X' with X not in the list below emits a warning,
printing glyph X.


* Menu:

* \:                                     Using Symbols.       (line 132)
* \!:                                    Diversions.          (line 135)
* \":                                    Comments.            (line  10)
* \#:                                    Comments.            (line  48)
* \$:                                    Parameters.          (line  19)
* \$*:                                   Parameters.          (line  40)
* \$0:                                   Parameters.          (line  71)
* \$@:                                   Parameters.          (line  41)
* \$^:                                   Parameters.          (line  50)
* \%:                                    Manipulating Hyphenation.
                                                              (line  84)
* \&:                                    Ligatures and Kerning.
                                                              (line 100)
* \':                                    Using Symbols.       (line 222)
* \):                                    Ligatures and Kerning.
                                                              (line 127)
* \*:                                    Strings.             (line  17)
* \,:                                    Ligatures and Kerning.
                                                              (line  91)
* \-:                                    Using Symbols.       (line 231)
* \.:                                    Character Translations.
                                                              (line 122)
* \/:                                    Ligatures and Kerning.
                                                              (line  80)
* \0:                                    Page Motions.        (line 138)
* \<colon>:                              Manipulating Hyphenation.
                                                              (line  85)
* \?:                                    Diversions.          (line 136)
* \A:                                    Identifiers.         (line  53)
* \a:                                    Leaders.             (line  18)
* \B:                                    Expressions.         (line  83)
* \b:                                    Drawing Requests.    (line 232)
* \c:                                    Line Control.        (line  41)
* \C:                                    Using Symbols.       (line 185)
* \d:                                    Page Motions.        (line 100)
* \D:                                    Drawing Requests.    (line  67)
* \e:                                    Character Translations.
                                                              (line  69)
* \E:                                    Character Translations.
                                                              (line  70)
* \f:                                    Changing Fonts.      (line   8)
* \F:                                    Font Families.       (line  22)
* \f <1>:                                Font Positions.      (line  58)
* \g:                                    Assigning Formats.   (line  73)
* \H:                                    Artificial Fonts.    (line  13)
* \h:                                    Page Motions.        (line 103)
* \k:                                    Page Motions.        (line 201)
* \l:                                    Drawing Requests.    (line  16)
* \L:                                    Drawing Requests.    (line  49)
* \m:                                    Colors.              (line  51)
* \M:                                    Colors.              (line  81)
* \n:                                    Interpolating Registers.
                                                              (line   9)
* \n <1>:                                Auto-increment.      (line  19)
* \N:                                    Using Symbols.       (line 201)
* \o:                                    Page Motions.        (line 216)
* \O:                                    Suppressing output.  (line   7)
* \p:                                    Manipulating Filling and Adjusting.
                                                              (line 131)
* \R:                                    Setting Registers.   (line  14)
* \R <1>:                                Setting Registers.   (line  70)
* \r:                                    Page Motions.        (line  94)
* \<RET>:                                Line Control.        (line  40)
* \S:                                    Artificial Fonts.    (line  44)
* \s:                                    Changing Type Sizes. (line  10)
* \<SP>:                                 Page Motions.        (line 114)
* \t:                                    Tabs and Fields.     (line  10)
* \u:                                    Page Motions.        (line  97)
* \v:                                    Page Motions.        (line  78)
* \V:                                    I/O.                 (line 247)
* \w:                                    Page Motions.        (line 145)
* \x:                                    Manipulating Spacing.
                                                              (line  82)
* \X:                                    Postprocessor Access.
                                                              (line  12)
* \Y:                                    Postprocessor Access.
                                                              (line  31)
* \z:                                    Page Motions.        (line 220)
* \Z:                                    Page Motions.        (line 224)
* \\:                                    Character Translations.
                                                              (line  68)
* \^:                                    Page Motions.        (line 130)
* \_:                                    Using Symbols.       (line 234)
* \`:                                    Using Symbols.       (line 227)
* \{:                                    if-else.             (line  35)
* \|:                                    Page Motions.        (line 122)
* \}:                                    if-else.             (line  35)
* \~:                                    Page Motions.        (line 118)

Next: Register Index,  Prev: Escape Index,  Up: Top

Appendix D Operator Index
*************************


* Menu:

* !:                                     Expressions.          (line 21)
* %:                                     Expressions.          (line  8)
* &:                                     Expressions.          (line 19)
* (:                                     Expressions.          (line 59)
* ):                                     Expressions.          (line 59)
* *:                                     Expressions.          (line  8)
* +:                                     Expressions.          (line  8)
* + <1>:                                 Expressions.          (line 21)
* -:                                     Expressions.          (line  8)
* - <1>:                                 Expressions.          (line 21)
* /:                                     Expressions.          (line  8)
* <:                                     Expressions.          (line 15)
* <=:                                    Expressions.          (line 15)
* <?:                                    Expressions.          (line 44)
* <colon>:                               Expressions.          (line 19)
* =:                                     Expressions.          (line 15)
* ==:                                    Expressions.          (line 15)
* >:                                     Expressions.          (line 15)
* >=:                                    Expressions.          (line 15)
* >?:                                    Expressions.          (line 44)

Next: Macro Index,  Prev: Operator Index,  Up: Top

Appendix E Register Index
*************************

The macro package or program a specific register belongs to is appended
in brackets.

   A register name 'x' consisting of exactly one character can be
accessed as '\nx'.  A register name 'xx' consisting of exactly two
characters can be accessed as '\n(xx'.  Register names 'xxx' of any
length can be accessed as '\n[xxx]'.


* Menu:

* $$:                                    Built-in Registers.  (line  99)
* %:                                     Page Layout.         (line  94)
* % <1>:                                 Page Control.        (line  10)
* .$:                                    Parameters.          (line  10)
* .A:                                    Built-in Registers.  (line 106)
* .a:                                    Manipulating Spacing.
                                                              (line  83)
* .b:                                    Artificial Fonts.    (line  98)
* .br:                                   Requests.            (line  56)
* .c:                                    Built-in Registers.  (line  76)
* .C:                                    Implementation Differences.
                                                              (line  24)
* .cdp:                                  Environments.        (line  94)
* .ce:                                   Manipulating Filling and Adjusting.
                                                              (line 204)
* .cht:                                  Environments.        (line  93)
* .color:                                Colors.              (line   8)
* .csk:                                  Environments.        (line  95)
* .d:                                    Diversions.          (line  69)
* .ev:                                   Environments.        (line  39)
* .F:                                    Built-in Registers.  (line  12)
* .f:                                    Font Positions.      (line  12)
* .fam:                                  Font Families.       (line  21)
* .fn:                                   Font Families.       (line  25)
* .fp:                                   Font Positions.      (line  13)
* .g:                                    Built-in Registers.  (line 102)
* .H:                                    Built-in Registers.  (line  15)
* .h:                                    Diversions.          (line  76)
* .height:                               Artificial Fonts.    (line  16)
* .hla:                                  Manipulating Hyphenation.
                                                              (line 256)
* .hlc:                                  Manipulating Hyphenation.
                                                              (line  47)
* .hlm:                                  Manipulating Hyphenation.
                                                              (line  46)
* .hy:                                   Manipulating Hyphenation.
                                                              (line  10)
* .hym:                                  Manipulating Hyphenation.
                                                              (line 211)
* .hys:                                  Manipulating Hyphenation.
                                                              (line 227)
* .i:                                    Line Layout.         (line  89)
* .in:                                   Line Layout.         (line 115)
* .int:                                  Line Control.        (line  42)
* .j:                                    Manipulating Filling and Adjusting.
                                                              (line  51)
* .k:                                    Page Motions.        (line 212)
* .kern:                                 Ligatures and Kerning.
                                                              (line  42)
* .L:                                    Manipulating Spacing.
                                                              (line  64)
* .l:                                    Line Layout.         (line 143)
* .lg:                                   Ligatures and Kerning.
                                                              (line  24)
* .linetabs:                             Tabs and Fields.     (line 138)
* .ll:                                   Line Layout.         (line 144)
* .lt:                                   Page Layout.         (line  67)
* .m:                                    Colors.              (line  54)
* .M:                                    Colors.              (line  84)
* .n:                                    Environments.        (line 110)
* .ne:                                   Page Location Traps. (line 122)
* .ns:                                   Manipulating Spacing.
                                                              (line 123)
* .O:                                    Built-in Registers.  (line 112)
* .o:                                    Line Layout.         (line  61)
* .P:                                    Built-in Registers.  (line 116)
* .p:                                    Page Layout.         (line  13)
* .pe:                                   Page Location Traps. (line 143)
* .pn:                                   Page Layout.         (line  84)
* .ps:                                   Fractional Type Sizes.
                                                              (line  37)
* .psr:                                  Fractional Type Sizes.
                                                              (line  44)
* .pvs:                                  Changing Type Sizes. (line 137)
* .R:                                    Built-in Registers.  (line  18)
* .rj:                                   Manipulating Filling and Adjusting.
                                                              (line 250)
* .s:                                    Changing Type Sizes. (line  11)
* .slant:                                Artificial Fonts.    (line  45)
* .sr:                                   Fractional Type Sizes.
                                                              (line  45)
* .ss:                                   Manipulating Filling and Adjusting.
                                                              (line 150)
* .sss:                                  Manipulating Filling and Adjusting.
                                                              (line 151)
* .sty:                                  Changing Fonts.      (line  11)
* .T:                                    Built-in Registers.  (line 122)
* .t:                                    Page Location Traps. (line 102)
* .tabs:                                 Tabs and Fields.     (line  15)
* .trunc:                                Page Location Traps. (line 131)
* .U:                                    Built-in Registers.  (line  23)
* .u:                                    Manipulating Filling and Adjusting.
                                                              (line  29)
* .V:                                    Built-in Registers.  (line  28)
* .v:                                    Changing Type Sizes. (line  88)
* .vpt:                                  Page Location Traps. (line  18)
* .w:                                    Environments.        (line  92)
* .warn:                                 Debugging.           (line 155)
* .x:                                    Built-in Registers.  (line  88)
* .y:                                    Built-in Registers.  (line  92)
* .Y:                                    Built-in Registers.  (line  96)
* .z:                                    Diversions.          (line  68)
* .zoom:                                 Changing Fonts.      (line  71)
* c.:                                    Built-in Registers.  (line  77)
* ct:                                    Page Motions.        (line 150)
* DD [ms]:                               ms Document Control Registers.
                                                              (line 239)
* dl:                                    Diversions.          (line  93)
* dn:                                    Diversions.          (line  92)
* dw:                                    Built-in Registers.  (line  45)
* dy:                                    Built-in Registers.  (line  48)
* FAM [ms]:                              ms Document Control Registers.
                                                              (line 111)
* FF [ms]:                               ms Document Control Registers.
                                                              (line 185)
* FI [ms]:                               ms Document Control Registers.
                                                              (line 178)
* FL [ms]:                               ms Document Control Registers.
                                                              (line 171)
* FM [ms]:                               ms Document Control Registers.
                                                              (line  47)
* FPD [ms]:                              ms Document Control Registers.
                                                              (line 221)
* FPS [ms]:                              ms Document Control Registers.
                                                              (line 205)
* FVS [ms]:                              ms Document Control Registers.
                                                              (line 213)
* GROWPS [ms]:                           ms Document Control Registers.
                                                              (line  89)
* GS [ms]:                               Differences from AT&T ms.
                                                              (line  45)
* HM [ms]:                               ms Document Control Registers.
                                                              (line  40)
* HORPHANS [ms]:                         ms Document Control Registers.
                                                              (line 155)
* hours:                                 Built-in Registers.  (line  41)
* hp:                                    Page Motions.        (line 209)
* HY [ms]:                               ms Document Control Registers.
                                                              (line 102)
* LL [ms]:                               ms Document Control Registers.
                                                              (line  25)
* llx:                                   Miscellaneous.       (line 136)
* lly:                                   Miscellaneous.       (line 137)
* ln:                                    Built-in Registers.  (line  82)
* lsn:                                   Leading Spaces Traps.
                                                              (line   8)
* lss:                                   Leading Spaces Traps.
                                                              (line   9)
* LT [ms]:                               ms Document Control Registers.
                                                              (line  32)
* MINGW [ms]:                            ms Document Control Registers.
                                                              (line 231)
* MINGW [ms] <1>:                        Additional ms Macros.
                                                              (line  28)
* minutes:                               Built-in Registers.  (line  37)
* mo:                                    Built-in Registers.  (line  51)
* nl:                                    Page Control.        (line  67)
* opmaxx:                                Suppressing output.  (line  19)
* opmaxy:                                Suppressing output.  (line  19)
* opminx:                                Suppressing output.  (line  19)
* opminy:                                Suppressing output.  (line  19)
* PD [ms]:                               ms Document Control Registers.
                                                              (line 128)
* PI [ms]:                               ms Document Control Registers.
                                                              (line 121)
* PO [ms]:                               ms Document Control Registers.
                                                              (line  16)
* PORPHANS [ms]:                         ms Document Control Registers.
                                                              (line 143)
* PS [ms]:                               ms Document Control Registers.
                                                              (line  57)
* ps4html [grohtml]:                     grohtml specific registers and strings.
                                                              (line   7)
* PSINCR [ms]:                           ms Document Control Registers.
                                                              (line  77)
* QI [ms]:                               ms Document Control Registers.
                                                              (line 135)
* rsb:                                   Page Motions.        (line 149)
* rst:                                   Page Motions.        (line 148)
* sb:                                    Page Motions.        (line 147)
* seconds:                               Built-in Registers.  (line  31)
* skw:                                   Page Motions.        (line 152)
* slimit:                                Debugging.           (line 119)
* ssc:                                   Page Motions.        (line 151)
* st:                                    Page Motions.        (line 146)
* systat:                                I/O.                 (line 165)
* urx:                                   Miscellaneous.       (line 138)
* ury:                                   Miscellaneous.       (line 139)
* VS [ms]:                               ms Document Control Registers.
                                                              (line  67)
* year:                                  Built-in Registers.  (line  54)
* yr:                                    Built-in Registers.  (line  57)

Next: String Index,  Prev: Register Index,  Up: Top

Appendix F Macro Index
**********************

The macro package a specific macro belongs to is appended in brackets.
They appear without the leading control character (normally '.').


* Menu:

* 1C [ms]:                               ms Multiple Columns. (line  13)
* 2C [ms]:                               ms Multiple Columns. (line  16)
* [ [ms]:                                ms Insertions.       (line  33)
* ] [ms]:                                ms Insertions.       (line  34)
* AB [ms]:                               ms Cover Page Macros.
                                                              (line  59)
* AE [ms]:                               ms Cover Page Macros.
                                                              (line  64)
* AI [ms]:                               ms Cover Page Macros.
                                                              (line  55)
* AM [ms]:                               ms Strings and Special Characters.
                                                              (line  51)
* AM [ms] <1>:                           Additional ms Macros.
                                                              (line  10)
* AT [man]:                              Miscellaneous man macros.
                                                              (line  27)
* AU [ms]:                               ms Cover Page Macros.
                                                              (line  39)
* B [man]:                               Man font macros.     (line  47)
* B [ms]:                                Highlighting in ms.  (line  10)
* B1 [ms]:                               ms Displays and Keeps.
                                                              (line  94)
* B2 [ms]:                               ms Displays and Keeps.
                                                              (line  95)
* BD [ms]:                               ms Displays and Keeps.
                                                              (line  31)
* BI [man]:                              Man font macros.     (line  18)
* BI [ms]:                               Highlighting in ms.  (line  38)
* BR [man]:                              Man font macros.     (line  39)
* BT [man]:                              Optional man extensions.
                                                              (line  21)
* BT [ms]:                               ms Headers and Footers.
                                                              (line  39)
* BX [ms]:                               Highlighting in ms.  (line  42)
* CD [ms]:                               ms Displays and Keeps.
                                                              (line  41)
* CT [man]:                              Optional man extensions.
                                                              (line  36)
* CW [man]:                              Optional man extensions.
                                                              (line  39)
* CW [ms]:                               Highlighting in ms.  (line  34)
* CW [ms] <1>:                           Additional ms Macros.
                                                              (line  19)
* DA [ms]:                               ms Cover Page Macros.
                                                              (line  24)
* De [man]:                              Optional man extensions.
                                                              (line  45)
* DE [ms]:                               ms Displays and Keeps.
                                                              (line  16)
* DE [ms] <1>:                           ms Displays and Keeps.
                                                              (line  24)
* DE [ms] <2>:                           ms Displays and Keeps.
                                                              (line  32)
* DE [ms] <3>:                           ms Displays and Keeps.
                                                              (line  42)
* DE [ms] <4>:                           ms Displays and Keeps.
                                                              (line  50)
* De [ms]:                               ms Displays and Keeps.
                                                              (line  57)
* Ds [man]:                              Optional man extensions.
                                                              (line  42)
* DS [ms]:                               ms Displays and Keeps.
                                                              (line  14)
* DS [ms] <1>:                           ms Displays and Keeps.
                                                              (line  22)
* DS [ms] <2>:                           ms Displays and Keeps.
                                                              (line  30)
* DS [ms] <3>:                           ms Displays and Keeps.
                                                              (line  40)
* DS [ms] <4>:                           ms Displays and Keeps.
                                                              (line  48)
* Ds [ms]:                               ms Displays and Keeps.
                                                              (line  56)
* DS [ms] <5>:                           Additional ms Macros.
                                                              (line  14)
* DT [man]:                              Miscellaneous man macros.
                                                              (line  10)
* EE [man]:                              Optional man extensions.
                                                              (line  52)
* EF [ms]:                               ms Headers and Footers.
                                                              (line  26)
* EH [ms]:                               ms Headers and Footers.
                                                              (line  24)
* EN [ms]:                               ms Insertions.       (line  28)
* EQ [ms]:                               ms Insertions.       (line  27)
* EX [man]:                              Optional man extensions.
                                                              (line  48)
* FE [ms]:                               ms Footnotes.        (line  15)
* FS [ms]:                               ms Footnotes.        (line  14)
* G [man]:                               Optional man extensions.
                                                              (line  55)
* GL [man]:                              Optional man extensions.
                                                              (line  60)
* HB [man]:                              Optional man extensions.
                                                              (line  65)
* HD [ms]:                               ms Headers and Footers.
                                                              (line  38)
* HP [man]:                              Man usage.           (line  98)
* I [man]:                               Man font macros.     (line  52)
* I [ms]:                                Highlighting in ms.  (line  30)
* IB [man]:                              Man font macros.     (line  27)
* ID [ms]:                               ms Displays and Keeps.
                                                              (line  23)
* IP [man]:                              Man usage.           (line  80)
* IP [ms]:                               Lists in ms.         (line   9)
* IR [man]:                              Man font macros.     (line  35)
* IX [ms]:                               Additional ms Macros.
                                                              (line  22)
* KE [ms]:                               ms Displays and Keeps.
                                                              (line  73)
* KE [ms] <1>:                           ms Displays and Keeps.
                                                              (line  78)
* KF [ms]:                               ms Displays and Keeps.
                                                              (line  77)
* KS [ms]:                               ms Displays and Keeps.
                                                              (line  72)
* LD [ms]:                               ms Displays and Keeps.
                                                              (line  15)
* LG [ms]:                               Highlighting in ms.  (line  51)
* LP [man]:                              Man usage.           (line  70)
* LP [ms]:                               Paragraphs in ms.    (line  12)
* MC [ms]:                               ms Multiple Columns. (line  19)
* MS [man]:                              Optional man extensions.
                                                              (line  73)
* ND [ms]:                               ms Cover Page Macros.
                                                              (line  29)
* NE [man]:                              Optional man extensions.
                                                              (line  85)
* NH [ms]:                               Headings in ms.      (line  13)
* NL [ms]:                               Highlighting in ms.  (line  63)
* NT [man]:                              Optional man extensions.
                                                              (line  78)
* OF [ms]:                               ms Headers and Footers.
                                                              (line  25)
* OH [ms]:                               ms Headers and Footers.
                                                              (line  23)
* P [man]:                               Man usage.           (line  72)
* P1 [ms]:                               ms Cover Page Macros.
                                                              (line  20)
* PD [man]:                              Miscellaneous man macros.
                                                              (line  15)
* PE [ms]:                               ms Insertions.       (line  21)
* PN [man]:                              Optional man extensions.
                                                              (line  88)
* Pn [man]:                              Optional man extensions.
                                                              (line  92)
* PP [man]:                              Man usage.           (line  71)
* PP [ms]:                               Paragraphs in ms.    (line   9)
* PS [ms]:                               ms Insertions.       (line  20)
* PT [man]:                              Optional man extensions.
                                                              (line  16)
* PT [ms]:                               ms Headers and Footers.
                                                              (line  37)
* PX [ms]:                               ms TOC.              (line  62)
* QP [ms]:                               Paragraphs in ms.    (line  15)
* R [man]:                               Optional man extensions.
                                                              (line  98)
* R [ms]:                                Highlighting in ms.  (line  26)
* RB [man]:                              Man font macros.     (line  43)
* RD [ms]:                               ms Displays and Keeps.
                                                              (line  49)
* RE [man]:                              Man usage.           (line 115)
* RE [ms]:                               Indentation values in ms.
                                                              (line  12)
* RI [man]:                              Man font macros.     (line  31)
* RN [man]:                              Optional man extensions.
                                                              (line 101)
* RP [ms]:                               ms Cover Page Macros.
                                                              (line  10)
* RS [man]:                              Man usage.           (line 106)
* RS [ms]:                               Indentation values in ms.
                                                              (line  11)
* SB [man]:                              Man font macros.     (line  14)
* SH [man]:                              Man usage.           (line  34)
* SH [ms]:                               Headings in ms.      (line  54)
* SM [man]:                              Man font macros.     (line  10)
* SM [ms]:                               Highlighting in ms.  (line  57)
* SS [man]:                              Man usage.           (line  43)
* TA [ms]:                               Tabstops in ms.      (line  10)
* TB [man]:                              Optional man extensions.
                                                              (line  70)
* TC [ms]:                               ms TOC.              (line  52)
* TE [ms]:                               ms Insertions.       (line  12)
* TH [man]:                              Man usage.           (line  11)
* TL [ms]:                               ms Cover Page Macros.
                                                              (line  34)
* TP [man]:                              Man usage.           (line  51)
* TS [ms]:                               ms Insertions.       (line  11)
* UC [man]:                              Miscellaneous man macros.
                                                              (line  44)
* UL [ms]:                               Highlighting in ms.  (line  46)
* VE [man]:                              Optional man extensions.
                                                              (line 108)
* VS [man]:                              Optional man extensions.
                                                              (line 104)
* XA [ms]:                               ms TOC.              (line  13)
* XE [ms]:                               ms TOC.              (line  14)
* XP [ms]:                               Paragraphs in ms.    (line  20)
* XS [ms]:                               ms TOC.              (line  12)

Next: Glyph Name Index,  Prev: Macro Index,  Up: Top

Appendix G String Index
***********************

The macro package or program a specific string belongs to is appended in
brackets.

   A string name 'x' consisting of exactly one character can be accessed
as '\*x'.  A string name 'xx' consisting of exactly two characters can
be accessed as '\*(xx'.  String names 'xxx' of any length can be
accessed as '\*[xxx]'.


* Menu:

* ! [ms]:                                ms Strings and Special Characters.
                                                              (line 101)
* ' [ms]:                                ms Strings and Special Characters.
                                                              (line  65)
* * [ms]:                                ms Footnotes.        (line  11)
* , [ms]:                                ms Strings and Special Characters.
                                                              (line  74)
* - [ms]:                                ms Strings and Special Characters.
                                                              (line  41)
* . [ms]:                                ms Strings and Special Characters.
                                                              (line  89)
* .T:                                    Built-in Registers.  (line 127)
* 3 [ms]:                                ms Strings and Special Characters.
                                                              (line 107)
* 8 [ms]:                                ms Strings and Special Characters.
                                                              (line 104)
* ? [ms]:                                ms Strings and Special Characters.
                                                              (line  98)
* \*[<colon>] [ms]:                      ms Strings and Special Characters.
                                                              (line  80)
* ^ [ms]:                                ms Strings and Special Characters.
                                                              (line  71)
* _ [ms]:                                ms Strings and Special Characters.
                                                              (line  86)
* ` [ms]:                                ms Strings and Special Characters.
                                                              (line  68)
* { [ms]:                                Highlighting in ms.  (line  67)
* } [ms]:                                Highlighting in ms.  (line  68)
* ~ [ms]:                                ms Strings and Special Characters.
                                                              (line  77)
* ABSTRACT [ms]:                         ms Strings and Special Characters.
                                                              (line  15)
* ae [ms]:                               ms Strings and Special Characters.
                                                              (line 125)
* Ae [ms]:                               ms Strings and Special Characters.
                                                              (line 128)
* CF [ms]:                               ms Headers and Footers.
                                                              (line  16)
* CH [ms]:                               ms Headers and Footers.
                                                              (line  11)
* D- [ms]:                               ms Strings and Special Characters.
                                                              (line 116)
* d- [ms]:                               ms Strings and Special Characters.
                                                              (line 119)
* HF [man]:                              Predefined man strings.
                                                              (line  12)
* LF [ms]:                               ms Headers and Footers.
                                                              (line  15)
* LH [ms]:                               ms Headers and Footers.
                                                              (line  10)
* lq [man]:                              Predefined man strings.
                                                              (line  21)
* MONTH1 [ms]:                           ms Strings and Special Characters.
                                                              (line  23)
* MONTH10 [ms]:                          ms Strings and Special Characters.
                                                              (line  32)
* MONTH11 [ms]:                          ms Strings and Special Characters.
                                                              (line  33)
* MONTH12 [ms]:                          ms Strings and Special Characters.
                                                              (line  34)
* MONTH2 [ms]:                           ms Strings and Special Characters.
                                                              (line  24)
* MONTH3 [ms]:                           ms Strings and Special Characters.
                                                              (line  25)
* MONTH4 [ms]:                           ms Strings and Special Characters.
                                                              (line  26)
* MONTH5 [ms]:                           ms Strings and Special Characters.
                                                              (line  27)
* MONTH6 [ms]:                           ms Strings and Special Characters.
                                                              (line  28)
* MONTH7 [ms]:                           ms Strings and Special Characters.
                                                              (line  29)
* MONTH8 [ms]:                           ms Strings and Special Characters.
                                                              (line  30)
* MONTH9 [ms]:                           ms Strings and Special Characters.
                                                              (line  31)
* o [ms]:                                ms Strings and Special Characters.
                                                              (line  92)
* Q [ms]:                                ms Strings and Special Characters.
                                                              (line  44)
* q [ms]:                                ms Strings and Special Characters.
                                                              (line 122)
* R [man]:                               Predefined man strings.
                                                              (line  15)
* REFERENCES [ms]:                       ms Strings and Special Characters.
                                                              (line  11)
* RF [ms]:                               ms Headers and Footers.
                                                              (line  17)
* RH [ms]:                               ms Headers and Footers.
                                                              (line  12)
* rq [man]:                              Predefined man strings.
                                                              (line  22)
* S [man]:                               Predefined man strings.
                                                              (line   9)
* SN [ms]:                               Headings in ms.      (line  22)
* SN-DOT [ms]:                           Headings in ms.      (line  23)
* SN-NO-DOT [ms]:                        Headings in ms.      (line  24)
* SN-STYLE [ms]:                         Headings in ms.      (line  36)
* Th [ms]:                               ms Strings and Special Characters.
                                                              (line 110)
* th [ms]:                               ms Strings and Special Characters.
                                                              (line 113)
* Tm [man]:                              Predefined man strings.
                                                              (line  18)
* TOC [ms]:                              ms Strings and Special Characters.
                                                              (line  19)
* U [ms]:                                ms Strings and Special Characters.
                                                              (line  45)
* v [ms]:                                ms Strings and Special Characters.
                                                              (line  83)
* www-image-template [grohtml]:          grohtml specific registers and strings.
                                                              (line   8)

Next: Font File Keyword Index,  Prev: String Index,  Up: Top

Appendix H Glyph Name Index
***************************

A glyph name 'xx' consisting of exactly two characters can be accessed
as '\(xx'.  Glyph names 'xxx' of any length can be accessed as '\[xxx]'.

Next: Program and File Index,  Prev: Glyph Name Index,  Up: Top

Appendix I Font File Keyword Index
**********************************


* Menu:

* #:                                     Font File Format.    (line  36)
* ---:                                   Font File Format.    (line  51)
* biggestfont:                           DESC File Format.    (line 142)
* charset:                               DESC File Format.    (line  12)
* charset <1>:                           Font File Format.    (line  44)
* family:                                Changing Fonts.      (line  11)
* family <1>:                            Font Positions.      (line  60)
* family <2>:                            DESC File Format.    (line  16)
* fonts:                                 Using Symbols.       (line  14)
* fonts <1>:                             Special Fonts.       (line  18)
* fonts <2>:                             DESC File Format.    (line  19)
* hor:                                   DESC File Format.    (line  25)
* image_generator:                       DESC File Format.    (line  29)
* kernpairs:                             Font File Format.    (line 139)
* ligatures:                             Font File Format.    (line  22)
* name:                                  Font File Format.    (line  12)
* paperlength:                           DESC File Format.    (line  35)
* papersize:                             DESC File Format.    (line  40)
* paperwidth:                            DESC File Format.    (line  59)
* pass_filenames:                        DESC File Format.    (line  64)
* postpro:                               DESC File Format.    (line  69)
* prepro:                                DESC File Format.    (line  77)
* print:                                 DESC File Format.    (line  81)
* res:                                   DESC File Format.    (line  85)
* sizes:                                 DESC File Format.    (line  88)
* sizescale:                             DESC File Format.    (line  95)
* slant:                                 Font File Format.    (line  18)
* spacewidth:                            Font File Format.    (line  15)
* spare1:                                DESC File Format.    (line 142)
* spare2:                                DESC File Format.    (line 142)
* special:                               Artificial Fonts.    (line 115)
* special <1>:                           Font File Format.    (line  28)
* styles:                                Changing Fonts.      (line  11)
* styles <1>:                            Font Families.       (line  75)
* styles <2>:                            Font Positions.      (line  60)
* styles <3>:                            DESC File Format.    (line 101)
* tcommand:                              DESC File Format.    (line 104)
* unicode:                               DESC File Format.    (line 108)
* unitwidth:                             DESC File Format.    (line 122)
* unscaled_charwidths:                   DESC File Format.    (line 126)
* use_charnames_in_special:              Postprocessor Access.
                                                              (line  22)
* use_charnames_in_special <1>:          DESC File Format.    (line 130)
* vert:                                  DESC File Format.    (line 135)

Next: Concept Index,  Prev: Font File Keyword Index,  Up: Top

Appendix J Program and File Index
*********************************


* Menu:

* an.tmac:                               man.                 (line   6)
* changebar:                             Miscellaneous.       (line 108)
* composite.tmac:                        Using Symbols.       (line 191)
* cp1047.tmac:                           Input Encodings.     (line   9)
* DESC:                                  Changing Fonts.      (line  11)
* DESC <1>:                              Font Families.       (line  75)
* DESC <2>:                              Font Positions.      (line  60)
* DESC <3>:                              Using Symbols.       (line  14)
* DESC <4>:                              Using Symbols.       (line 212)
* DESC <5>:                              Special Fonts.       (line  18)
* DESC file format:                      DESC File Format.    (line   6)
* DESC, and font mounting:               Font Positions.      (line  36)
* DESC, and 'use_charnames_in_special':  Postprocessor Access.
                                                              (line  22)
* ditroff:                               History.             (line  59)
* ec.tmac:                               Input Encodings.     (line  46)
* eqn:                                   ms Insertions.       (line   7)
* freeeuro.pfa:                          Input Encodings.     (line  46)
* gchem:                                 Groff Options.       (line   6)
* geqn:                                  Groff Options.       (line   6)
* geqn, invocation in manual pages:      Preprocessors in man pages.
                                                              (line  11)
* ggrn:                                  Groff Options.       (line   6)
* gpic:                                  Groff Options.       (line   6)
* grap:                                  Groff Options.       (line   6)
* grefer:                                Groff Options.       (line   6)
* grefer, invocation in manual pages:    Preprocessors in man pages.
                                                              (line  11)
* groff:                                 Groff Options.       (line   6)
* grog:                                  grog.                (line   6)
* grohtml:                               Miscellaneous man macros.
                                                              (line   6)
* gsoelim:                               Groff Options.       (line   6)
* gtbl:                                  Groff Options.       (line   6)
* gtbl, invocation in manual pages:      Preprocessors in man pages.
                                                              (line  11)
* gtroff:                                Groff Options.       (line   6)
* hyphen.us:                             Manipulating Hyphenation.
                                                              (line 162)
* hyphenex.us:                           Manipulating Hyphenation.
                                                              (line 162)
* latin1.tmac:                           Input Encodings.     (line  14)
* latin2.tmac:                           Input Encodings.     (line  18)
* latin2.tmac <1>:                       Input Encodings.     (line  23)
* latin9.tmac:                           Input Encodings.     (line  28)
* less:                                  Invoking grotty.     (line  50)
* makeindex:                             Indices.             (line  10)
* man, invocation of preprocessors:      Preprocessors in man pages.
                                                              (line  11)
* man-old.tmac:                          man.                 (line   6)
* man.local:                             Man usage.           (line   6)
* man.local <1>:                         Optional man extensions.
                                                              (line   6)
* man.tmac:                              man.                 (line   6)
* man.ultrix:                            Optional man extensions.
                                                              (line  30)
* nrchbar:                               Miscellaneous.       (line 108)
* papersize.tmac:                        Paper Size.          (line  16)
* perl:                                  I/O.                 (line 175)
* pic:                                   ms Insertions.       (line   7)
* post-grohtml:                          Groff Options.       (line 275)
* pre-grohtml:                           Groff Options.       (line 275)
* preconv:                               Groff Options.       (line   6)
* refer:                                 ms Insertions.       (line   7)
* soelim:                                Debugging.           (line  10)
* tbl:                                   ms Insertions.       (line   7)
* trace.tmac:                            Writing Macros.      (line 104)
* trace.tmac <1>:                        Writing Macros.      (line 136)
* troffrc:                               Groff Options.       (line 206)
* troffrc <1>:                           Paper Size.          (line  16)
* troffrc <2>:                           Manipulating Hyphenation.
                                                              (line 162)
* troffrc <3>:                           Manipulating Hyphenation.
                                                              (line 256)
* troffrc <4>:                           Troff and Nroff Mode.
                                                              (line  24)
* troffrc <5>:                           Line Layout.         (line  61)
* troffrc-end:                           Groff Options.       (line 206)
* troffrc-end <1>:                       Manipulating Hyphenation.
                                                              (line 162)
* troffrc-end <2>:                       Manipulating Hyphenation.
                                                              (line 256)
* troffrc-end <3>:                       Troff and Nroff Mode.
                                                              (line  24)
* tty.tmac:                              Troff and Nroff Mode.
                                                              (line  32)

Prev: Program and File Index,  Up: Top

Appendix K Concept Index
************************


* Menu:

* '"', at end of sentence:               Sentences.           (line  18)
* '"', at end of sentence <1>:           Using Symbols.       (line 275)
* '"', in a macro argument:              Request and Macro Arguments.
                                                              (line  25)
* '%', as delimiter:                     Escapes.             (line  67)
* '&', as delimiter:                     Escapes.             (line  67)
* ''', as a comment:                     Comments.            (line  42)
* ''', at end of sentence:               Sentences.           (line  18)
* ''', at end of sentence <1>:           Using Symbols.       (line 275)
* ''', delimiting arguments:             Escapes.             (line  29)
* '(', as delimiter:                     Escapes.             (line  67)
* '(', starting a two-character identifier: Identifiers.      (line  73)
* '(', starting a two-character identifier <1>: Escapes.      (line  16)
* ')', as delimiter:                     Escapes.             (line  67)
* ')', at end of sentence:               Sentences.           (line  18)
* ')', at end of sentence <1>:           Using Symbols.       (line 275)
* '*', as delimiter:                     Escapes.             (line  67)
* '*', at end of sentence:               Sentences.           (line  18)
* '*', at end of sentence <1>:           Using Symbols.       (line 275)
* '+', and page motion:                  Expressions.         (line  65)
* '+', as delimiter:                     Escapes.             (line  67)
* '-', and page motion:                  Expressions.         (line  65)
* '-', as delimiter:                     Escapes.             (line  67)
* '.', as delimiter:                     Escapes.             (line  67)
* '.h' register, difference to 'nl':     Diversions.          (line  88)
* '.ps' register, in comparison with '.psr': Fractional Type Sizes.
                                                              (line  45)
* '.s' register, in comparison with '.sr': Fractional Type Sizes.
                                                              (line  45)
* '.S' register, Plan 9 alias for '.tabs': Tabs and Fields.   (line 125)
* '.t' register, and diversions:         Diversion Traps.     (line   7)
* '.tabs' register, Plan 9 alias ('.S'): Tabs and Fields.     (line 125)
* '.V' register, and 'vs':               Changing Type Sizes. (line  94)
* '/', as delimiter:                     Escapes.             (line  67)
* 8-bit input:                           Font File Format.    (line  51)
* '<', as delimiter:                     Escapes.             (line  67)
* <colon>, as delimiter:                 Escapes.             (line  67)
* '=', as delimiter:                     Escapes.             (line  67)
* '>', as delimiter:                     Escapes.             (line  67)
* '[', macro names starting with, and 'refer': Identifiers.   (line  46)
* '[', starting an identifier:           Identifiers.         (line  75)
* '[', starting an identifier <1>:       Escapes.             (line  20)
* '\!', and copy-in mode:                Diversions.          (line 148)
* '\!', and 'output' request:            Diversions.          (line 179)
* '\!', and 'trnt':                      Character Translations.
                                                              (line 237)
* '\!', in top-level diversion:          Diversions.          (line 171)
* '\!', incompatibilities with AT&T 'troff': Implementation Differences.
                                                              (line  69)
* '\!', incompatibilities with AT&T 'troff' <1>: Implementation Differences.
                                                              (line 106)
* '\!', used as delimiter:               Escapes.             (line  52)
* '\!', used as delimiter <1>:           Escapes.             (line  71)
* '\$', when reading text for a macro:   Copy-in Mode.        (line   6)
* '\%', and translations:                Character Translations.
                                                              (line 166)
* '\%', following '\X' or '\Y':          Manipulating Hyphenation.
                                                              (line  98)
* '\%', in '\X':                         Postprocessor Access.
                                                              (line  14)
* '\%', incompatibilities with AT&T 'troff': Implementation Differences.
                                                              (line  69)
* '\%', used as delimiter:               Escapes.             (line  52)
* '\%', used as delimiter <1>:           Escapes.             (line  71)
* '\&', and glyph definitions:           Using Symbols.       (line 326)
* '\&', and translations:                Character Translations.
                                                              (line 176)
* '\&', at end of sentence:              Sentences.           (line  24)
* '\&', escaping control characters:     Requests.            (line  47)
* '\&', in '\X':                         Postprocessor Access.
                                                              (line  14)
* '\&', incompatibilities with AT&T 'troff': Implementation Differences.
                                                              (line  69)
* '\&', used as delimiter:               Escapes.             (line  52)
* '\'', and translations:                Character Translations.
                                                              (line 160)
* '\'', incompatibilities with AT&T 'troff': Implementation Differences.
                                                              (line  69)
* '\'', used as delimiter:               Escapes.             (line  52)
* '\'', used as delimiter <1>:           Escapes.             (line  71)
* '\(', and translations:                Character Translations.
                                                              (line 160)
* '\)', in '\X':                         Postprocessor Access.
                                                              (line  14)
* '\)', used as delimiter:               Escapes.             (line  52)
* '\*', and warnings:                    Warnings.            (line  54)
* '\*', incompatibilities with AT&T 'troff': Implementation Differences.
                                                              (line  13)
* '\*', when reading text for a macro:   Copy-in Mode.        (line   6)
* '\', disabling ('eo'):                 Character Translations.
                                                              (line  24)
* '\,', used as delimiter:               Escapes.             (line  52)
* '\-', and translations:                Character Translations.
                                                              (line 160)
* '\-', incompatibilities with AT&T 'troff': Implementation Differences.
                                                              (line  69)
* '\-', used as delimiter:               Escapes.             (line  52)
* '\-', used as delimiter <1>:           Escapes.             (line  71)
* '\/', used as delimiter:               Escapes.             (line  52)
* '\/', used as delimiter <1>:           Escapes.             (line  71)
* '\0', used as delimiter:               Escapes.             (line  52)
* '\<colon>', in '\X':                   Postprocessor Access.
                                                              (line  14)
* '\<colon>', used as delimiter:         Escapes.             (line  52)
* '\<colon>', used as delimiter <1>:     Escapes.             (line  71)
* '\?', and copy-in mode:                Operators in Conditionals.
                                                              (line  55)
* '\?', and copy-in mode <1>:            Diversions.          (line 148)
* '\?', in top-level diversion:          Diversions.          (line 176)
* '\?', incompatibilities with AT&T 'troff': Implementation Differences.
                                                              (line 106)
* '\?', used as delimiter:               Escapes.             (line  52)
* '\A', allowed delimiters:              Escapes.             (line  59)
* '\a', and copy-in mode:                Leaders.             (line  18)
* '\a', and translations:                Character Translations.
                                                              (line 169)
* '\A', incompatibilities with AT&T 'troff': Implementation Differences.
                                                              (line  69)
* '\a', used as delimiter:               Escapes.             (line  52)
* '\B', allowed delimiters:              Escapes.             (line  59)
* '\b', limitations:                     Drawing Requests.    (line 239)
* '\b', possible quote characters:       Escapes.             (line  37)
* '\C', allowed delimiters:              Escapes.             (line  59)
* '\c', and fill mode:                   Line Control.        (line  69)
* '\c', and no-fill mode:                Line Control.        (line  60)
* '\C', and translations:                Character Translations.
                                                              (line 160)
* '\c', incompatibilities with AT&T 'troff': Implementation Differences.
                                                              (line  69)
* '\c', used as delimiter:               Escapes.             (line  52)
* '\c', used as delimiter <1>:           Escapes.             (line  71)
* '\D'f ...'' and horizontal resolution: Drawing Requests.    (line 151)
* '\D', allowed delimiters:              Escapes.             (line  62)
* '\d', used as delimiter:               Escapes.             (line  52)
* '\E', and copy-in mode:                Character Translations.
                                                              (line  81)
* '\e', and glyph definitions:           Using Symbols.       (line 326)
* '\e', and translations:                Character Translations.
                                                              (line 164)
* '\e', incompatibilities with AT&T 'troff': Implementation Differences.
                                                              (line 106)
* '\e', used as delimiter:               Escapes.             (line  52)
* '\E', used as delimiter:               Escapes.             (line  52)
* '\e', used as delimiter <1>:           Escapes.             (line  71)
* '\F', and changing fonts:              Changing Fonts.      (line  11)
* '\F', and font positions:              Font Positions.      (line  60)
* '\f', and font translations:           Changing Fonts.      (line  55)
* '\f', incompatibilities with AT&T 'troff': Implementation Differences.
                                                              (line  56)
* '\h', allowed delimiters:              Escapes.             (line  62)
* '\H', allowed delimiters:              Escapes.             (line  62)
* '\H', incompatibilities with AT&T 'troff': Implementation Differences.
                                                              (line  56)
* '\H', using '+' and '-':               Expressions.         (line  75)
* '\H', with fractional type sizes:      Fractional Type Sizes.
                                                              (line   6)
* '\l', allowed delimiters:              Escapes.             (line  62)
* '\L', allowed delimiters:              Escapes.             (line  62)
* '\l', and glyph definitions:           Using Symbols.       (line 326)
* '\L', and glyph definitions:           Using Symbols.       (line 326)
* '\N', allowed delimiters:              Escapes.             (line  62)
* '\N', and translations:                Character Translations.
                                                              (line 160)
* '\n', and warnings:                    Warnings.            (line  61)
* '\n', incompatibilities with AT&T 'troff': Implementation Differences.
                                                              (line  13)
* '\n', when reading text for a macro:   Copy-in Mode.        (line   6)
* '\o', possible quote characters:       Escapes.             (line  37)
* '\p', used as delimiter:               Escapes.             (line  52)
* '\p', used as delimiter <1>:           Escapes.             (line  71)
* '\R', after '\c':                      Line Control.        (line  52)
* '\R', allowed delimiters:              Escapes.             (line  62)
* '\R', and warnings:                    Warnings.            (line  61)
* '\R', difference to 'nr':              Auto-increment.      (line  11)
* '\r', used as delimiter:               Escapes.             (line  52)
* '\R', using '+' and '-':               Expressions.         (line  75)
* \<RET>, when reading text for a macro: Copy-in Mode.        (line   6)
* '\s', allowed delimiters:              Escapes.             (line  62)
* '\S', allowed delimiters:              Escapes.             (line  62)
* '\s', incompatibilities with AT&T 'troff': Implementation Differences.
                                                              (line  56)
* '\S', incompatibilities with AT&T 'troff': Implementation Differences.
                                                              (line  56)
* '\s', using '+' and '-':               Expressions.         (line  75)
* '\s', with fractional type sizes:      Fractional Type Sizes.
                                                              (line   6)
* '\<SP>', difference to '\~':           Request and Macro Arguments.
                                                              (line  20)
* '\<SP>', incompatibilities with AT&T 'troff': Implementation Differences.
                                                              (line  69)
* '\<SP>', used as delimiter:            Escapes.             (line  52)
* '\t', and copy-in mode:                Tabs and Fields.     (line  10)
* '\t', and translations:                Character Translations.
                                                              (line 169)
* '\t', and warnings:                    Warnings.            (line  69)
* '\t', used as delimiter:               Escapes.             (line  52)
* '\u', used as delimiter:               Escapes.             (line  52)
* '\v', allowed delimiters:              Escapes.             (line  62)
* '\V', and copy-in mode:                I/O.                 (line 249)
* '\v', internal representation:         Gtroff Internals.    (line  54)
* '\w', allowed delimiters:              Escapes.             (line  59)
* '\x', allowed delimiters:              Escapes.             (line  62)
* '\X', and special characters:          Postprocessor Access.
                                                              (line  22)
* '\X', followed by '\%':                Manipulating Hyphenation.
                                                              (line  98)
* '\X', possible quote characters:       Escapes.             (line  37)
* '\Y', followed by '\%':                Manipulating Hyphenation.
                                                              (line  98)
* '\Z', allowed delimiters:              Escapes.             (line  59)
* '\[', and translations:                Character Translations.
                                                              (line 160)
* '\\', when reading text for a macro:   Copy-in Mode.        (line   6)
* '\^', incompatibilities with AT&T 'troff': Implementation Differences.
                                                              (line  69)
* '\^', used as delimiter:               Escapes.             (line  52)
* '\_', and translations:                Character Translations.
                                                              (line 160)
* '\_', incompatibilities with AT&T 'troff': Implementation Differences.
                                                              (line  69)
* '\_', used as delimiter:               Escapes.             (line  52)
* '\_', used as delimiter <1>:           Escapes.             (line  71)
* '\`', and translations:                Character Translations.
                                                              (line 160)
* '\`', incompatibilities with AT&T 'troff': Implementation Differences.
                                                              (line  69)
* '\`', used as delimiter:               Escapes.             (line  52)
* '\`', used as delimiter <1>:           Escapes.             (line  71)
* '\{', incompatibilities with AT&T 'troff': Implementation Differences.
                                                              (line  69)
* '\{', used as delimiter:               Escapes.             (line  52)
* '\{', used as delimiter <1>:           Escapes.             (line  71)
* '\|', incompatibilities with AT&T 'troff': Implementation Differences.
                                                              (line  69)
* '\|', used as delimiter:               Escapes.             (line  52)
* '\}', and warnings:                    Warnings.            (line  73)
* '\}', incompatibilities with AT&T 'troff': Implementation Differences.
                                                              (line  69)
* '\}', used as delimiter:               Escapes.             (line  52)
* '\}', used as delimiter <1>:           Escapes.             (line  71)
* '\~', and translations:                Character Translations.
                                                              (line 166)
* '\~', difference to '\<SP>':           Request and Macro Arguments.
                                                              (line  20)
* '\~', used as delimiter:               Escapes.             (line  52)
* ']', as part of an identifier:         Identifiers.         (line  41)
* ']', at end of sentence:               Sentences.           (line  18)
* ']', at end of sentence <1>:           Using Symbols.       (line 275)
* ']', ending an identifier:             Identifiers.         (line  75)
* ']', ending an identifier <1>:         Escapes.             (line  20)
* ']', macro names starting with, and 'refer': Identifiers.   (line  46)
* '|', and page motion:                  Expressions.         (line  70)
* aborting ('ab'):                       Debugging.           (line  40)
* absolute position operator ('|'):      Expressions.         (line  70)
* accent marks ['ms']:                   ms Strings and Special Characters.
                                                              (line   6)
* access of postprocessor:               Postprocessor Access.
                                                              (line   6)
* accessing unnamed glyphs with '\N':    Font File Format.    (line  51)
* activating kerning ('kern'):           Ligatures and Kerning.
                                                              (line  42)
* activating ligatures ('lg'):           Ligatures and Kerning.
                                                              (line  24)
* activating track kerning ('tkf'):      Ligatures and Kerning.
                                                              (line  60)
* 'ad' request, and hyphenation margin:  Manipulating Hyphenation.
                                                              (line 211)
* 'ad' request, and hyphenation space:   Manipulating Hyphenation.
                                                              (line 227)
* adjusting:                             Filling and Adjusting.
                                                              (line   6)
* adjusting and filling, manipulating:   Manipulating Filling and Adjusting.
                                                              (line   6)
* adjustment mode register ('.j'):       Manipulating Filling and Adjusting.
                                                              (line 114)
* adobe glyph list (AGL):                Using Symbols.       (line  88)
* AGL (adobe glyph list):                Using Symbols.       (line  88)
* alias, diversion, creating ('als'):    Strings.             (line 229)
* alias, diversion, removing ('rm'):     Strings.             (line 263)
* alias, macro, creating ('als'):        Strings.             (line 229)
* alias, macro, removing ('rm'):         Strings.             (line 263)
* alias, number register, creating ('aln'): Setting Registers.
                                                              (line 112)
* alias, string, creating ('als'):       Strings.             (line 229)
* alias, string, removing ('rm'):        Strings.             (line 263)
* 'als' request, and '\$0':              Parameters.          (line  71)
* 'am', 'am1', 'ami' requests, and warnings: Warnings.        (line  54)
* annotations:                           Footnotes and Annotations.
                                                              (line   6)
* appending to a diversion ('da'):       Diversions.          (line  22)
* appending to a file ('opena'):         I/O.                 (line 200)
* appending to a macro ('am'):           Writing Macros.      (line 116)
* appending to a string ('as'):          Strings.             (line 176)
* arc, drawing ('\D'a ...''):            Drawing Requests.    (line 128)
* argument delimiting characters:        Escapes.             (line  29)
* arguments to macros, and tabs:         Request and Macro Arguments.
                                                              (line   6)
* arguments to requests and macros:      Request and Macro Arguments.
                                                              (line   6)
* arguments, and compatibility mode:     Gtroff Internals.    (line  91)
* arguments, macro ('\$'):               Parameters.          (line  21)
* arguments, of strings:                 Strings.             (line  19)
* arithmetic operators:                  Expressions.         (line   8)
* artificial fonts:                      Artificial Fonts.    (line   6)
* 'as', 'as1' requests, and comments:    Comments.            (line  16)
* 'as', 'as1' requests, and warnings:    Warnings.            (line  54)
* ASCII approximation output register ('.A'): Groff Options.  (line  51)
* ASCII approximation output register ('.A') <1>: Built-in Registers.
                                                              (line 106)
* ASCII, output encoding:                Groff Options.       (line 250)
* 'asciify' request, and 'writem':       I/O.                 (line 222)
* assigning formats ('af'):              Assigning Formats.   (line   6)
* assignments, indirect:                 Interpolating Registers.
                                                              (line  11)
* assignments, nested:                   Interpolating Registers.
                                                              (line  11)
* AT&T 'troff', 'ms' macro package differences: Differences from AT&T ms.
                                                              (line   6)
* auto-increment:                        Auto-increment.      (line   6)
* auto-increment, and 'ig' request:      Comments.            (line  85)
* available glyphs, list ('groff_char(7)' man page): Using Symbols.
                                                              (line  76)
* background color name register ('.M'): Colors.              (line  94)
* backslash, printing ('\\', '\e', '\E', '\[rs]'): Escapes.   (line  74)
* backslash, printing ('\\', '\e', '\E', '\[rs]') <1>: Implementation Differences.
                                                              (line 106)
* backspace character:                   Identifiers.         (line  12)
* backspace character, and translations: Character Translations.
                                                              (line 169)
* backtrace of input stack ('backtrace'): Debugging.          (line  96)
* baseline:                              Sizes.               (line   6)
* basic unit ('u'):                      Measurements.        (line   6)
* basics of macros:                      Basics.              (line   6)
* 'bd' request, and font styles:         Font Families.       (line  59)
* 'bd' request, and font translations:   Changing Fonts.      (line  55)
* 'bd' request, incompatibilities with AT&T 'troff': Implementation Differences.
                                                              (line  86)
* begin of conditional block ('\{'):     if-else.             (line  35)
* beginning diversion ('di'):            Diversions.          (line  22)
* blank line:                            Implicit Line Breaks.
                                                              (line  10)
* blank line <1>:                        Requests.            (line  27)
* blank line ('sp'):                     Basics.              (line  93)
* blank line macro ('blm'):              Implicit Line Breaks.
                                                              (line  10)
* blank line macro ('blm') <1>:          Requests.            (line  27)
* blank line macro ('blm') <2>:          Blank Line Traps.    (line   7)
* blank line traps:                      Blank Line Traps.    (line   6)
* blank lines, disabling:                Manipulating Spacing.
                                                              (line 123)
* block, conditional, begin ('\{'):      if-else.             (line  35)
* block, condititional, end ('\}'):      if-else.             (line  35)
* bold face ['man']:                     Man font macros.     (line  14)
* bold face, imitating ('bd'):           Artificial Fonts.    (line  98)
* bottom margin:                         Page Layout.         (line  20)
* bounding box:                          Miscellaneous.       (line 139)
* box rule glyph ('\[br]'):              Drawing Requests.    (line  50)
* 'box', 'boxa' requests, and warnings:  Warnings.            (line  54)
* 'boxa' request, and 'dn' ('dl'):       Diversions.          (line  93)
* 'bp' request, and top-level diversion: Page Control.        (line  24)
* 'bp' request, and traps ('.pe'):       Page Location Traps. (line 143)
* 'bp' request, causing implicit linebreak: Manipulating Filling and Adjusting.
                                                              (line   6)
* 'bp' request, using '+' and '-':       Expressions.         (line  75)
* 'br' glyph, and 'cflags':              Using Symbols.       (line 271)
* break:                                 Basics.              (line  48)
* break <1>:                             Manipulating Filling and Adjusting.
                                                              (line   6)
* break ('br'):                          Basics.              (line 118)
* 'break' request, in a 'while' loop:    while.               (line  68)
* break, implicit:                       Implicit Line Breaks.
                                                              (line   6)
* built-in registers:                    Built-in Registers.  (line   6)
* bulleted list, example markup ['ms']:  Lists in ms.         (line  21)
* 'c' unit:                              Measurements.        (line  27)
* calling convention of preprocessors:   Preprocessors in man pages.
                                                              (line   6)
* capabilities of 'groff':               groff Capabilities.  (line   6)
* 'ce' request, causing implicit linebreak: Manipulating Filling and Adjusting.
                                                              (line   6)
* 'ce' request, difference to '.ad c':   Manipulating Filling and Adjusting.
                                                              (line  66)
* centered text:                         Manipulating Filling and Adjusting.
                                                              (line  66)
* centering lines ('ce'):                Basics.              (line 105)
* centering lines ('ce') <1>:            Manipulating Filling and Adjusting.
                                                              (line 204)
* centimeter unit ('c'):                 Measurements.        (line  27)
* 'cf' request, and copy-in mode:        I/O.                 (line  50)
* 'cf' request, causing implicit linebreak: Manipulating Filling and Adjusting.
                                                              (line   6)
* changing font family ('fam', '\F'):    Font Families.       (line  25)
* changing font position ('\f'):         Font Positions.      (line  60)
* changing font style ('sty'):           Font Families.       (line  59)
* changing fonts ('ft', '\f'):           Changing Fonts.      (line  11)
* changing format, and read-only registers: Assigning Formats.
                                                              (line  68)
* changing the font height ('\H'):       Artificial Fonts.    (line  16)
* changing the font slant ('\S'):        Artificial Fonts.    (line  45)
* changing the page number character ('pc'): Page Layout.     (line  94)
* changing trap location ('ch'):         Page Location Traps. (line 111)
* changing type sizes ('ps', '\s'):      Changing Type Sizes. (line  11)
* changing vertical line spacing ('vs'): Changing Type Sizes. (line  88)
* 'char' request, and soft hyphen character: Manipulating Hyphenation.
                                                              (line 243)
* 'char' request, and translations:      Character Translations.
                                                              (line 160)
* 'char' request, used with '\N':        Using Symbols.       (line 201)
* character:                             Using Symbols.       (line   6)
* character class ('class'):             Character Classes.   (line  12)
* character classes:                     Character Classes.   (line   6)
* character properties ('cflags'):       Using Symbols.       (line 237)
* character translations:                Character Translations.
                                                              (line   6)
* character, backspace:                  Identifiers.         (line  12)
* character, backspace, and translations: Character Translations.
                                                              (line 169)
* character, control ('.'):              Requests.            (line   6)
* character, control, changing ('cc'):   Character Translations.
                                                              (line   6)
* character, defining ('char'):          Using Symbols.       (line 326)
* character, defining fallback ('fchar', 'fschar', 'schar'): Using Symbols.
                                                              (line 326)
* character, escape, changing ('ec'):    Character Translations.
                                                              (line  47)
* character, escape, while defining glyph: Using Symbols.     (line 326)
* character, field delimiting ('fc'):    Fields.              (line   6)
* character, field padding ('fc'):       Fields.              (line   6)
* character, hyphenation ('\%'):         Manipulating Hyphenation.
                                                              (line  85)
* character, leader repetition ('lc'):   Leaders.             (line  23)
* character, leader, and translations:   Character Translations.
                                                              (line 169)
* character, leader, non-interpreted ('\a'): Leaders.         (line  18)
* character, named ('\C'):               Using Symbols.       (line 185)
* character, newline:                    Escapes.             (line  69)
* character, newline, and translations:  Character Translations.
                                                              (line 169)
* character, no-break control ('''):     Requests.            (line   6)
* character, no-break control, changing ('c2'): Character Translations.
                                                              (line   6)
* character, soft hyphen, setting ('shc'): Manipulating Hyphenation.
                                                              (line 243)
* character, space:                      Escapes.             (line  69)
* character, special:                    Character Translations.
                                                              (line 160)
* character, tab:                        Escapes.             (line  69)
* character, tab repetition ('tc'):      Tabs and Fields.     (line 129)
* character, tab, and translations:      Character Translations.
                                                              (line 169)
* character, tab, non-interpreted ('\t'): Tabs and Fields.    (line  10)
* character, tabulator:                  Tab Stops.           (line   6)
* character, transparent:                Sentences.           (line  18)
* character, transparent <1>:            Using Symbols.       (line 275)
* character, whitespace:                 Identifiers.         (line  10)
* character, zero width space ('\&'):    Requests.            (line  47)
* character, zero width space ('\&') <1>: Ligatures and Kerning.
                                                              (line  47)
* character, zero width space ('\&') <2>: Drawing Requests.   (line  32)
* characters, argument delimiting:       Escapes.             (line  29)
* characters, end-of-sentence:           Using Symbols.       (line 247)
* characters, hyphenation:               Using Symbols.       (line 251)
* characters, input, and output glyphs, compatibility with AT&T 'troff': Implementation Differences.
                                                              (line  86)
* characters, invalid for 'trf' request: I/O.                 (line  73)
* characters, invalid input:             Identifiers.         (line  15)
* characters, overlapping:               Using Symbols.       (line 265)
* characters, special:                   Special Characters.  (line   6)
* characters, unnamed, accessing with '\N': Font File Format. (line  51)
* 'chem', the program:                   gchem.               (line   6)
* circle, drawing ('\D'c ...''):         Drawing Requests.    (line 109)
* circle, solid, drawing ('\D'C ...''):  Drawing Requests.    (line 114)
* class of characters ('class'):         Character Classes.   (line  12)
* classes, character:                    Character Classes.   (line   6)
* closing file ('close'):                I/O.                 (line 231)
* code, hyphenation ('hcode'):           Manipulating Hyphenation.
                                                              (line 175)
* color name, background, register ('.M'): Colors.            (line  94)
* color name, drawing, register ('.m'):  Colors.              (line  67)
* color name, fill, register ('.M'):     Colors.              (line  94)
* color, default:                        Colors.              (line  26)
* colors:                                Colors.              (line   6)
* colors, fill, unnamed ('\D'F...''):    Drawing Requests.    (line 216)
* command prefix:                        Environment.         (line  14)
* command-line options:                  Groff Options.       (line  50)
* commands, embedded:                    Embedded Commands.   (line   6)
* comments:                              Comments.            (line   6)
* comments in font files:                Font File Format.    (line  36)
* comments, lining up with tabs:         Comments.            (line  21)
* comments, with 'ds':                   Strings.             (line  45)
* common features:                       Common Features.     (line   6)
* common name space of macros, diversions, and strings: Strings.
                                                              (line  92)
* comparison of strings:                 Operators in Conditionals.
                                                              (line  47)
* comparison operators:                  Expressions.         (line  15)
* compatibility mode:                    Warnings.            (line  91)
* compatibility mode <1>:                Implementation Differences.
                                                              (line   6)
* compatibility mode, and parameters:    Gtroff Internals.    (line  91)
* composite glyph names:                 Using Symbols.       (line  88)
* conditional block, begin ('\{'):       if-else.             (line  35)
* conditional block, end ('\}'):         if-else.             (line  35)
* conditional output for terminal (TTY): Operators in Conditionals.
                                                              (line  14)
* conditional page break ('ne'):         Page Control.        (line  33)
* conditionals and loops:                Conditionals and Loops.
                                                              (line   6)
* consecutive hyphenated lines ('hlm'):  Manipulating Hyphenation.
                                                              (line  47)
* constant glyph space mode ('cs'):      Artificial Fonts.    (line 126)
* contents, table of:                    Table of Contents.   (line   6)
* contents, table of <1>:                Leaders.             (line  29)
* continuation, input line ('\'):        Line Control.        (line  36)
* continuation, output line ('\c'):      Line Control.        (line  36)
* 'continue' request, in a 'while' loop: while.               (line  68)
* continuous underlining ('cu'):         Artificial Fonts.    (line  86)
* control character ('.'):               Requests.            (line   6)
* control character, changing ('cc'):    Character Translations.
                                                              (line   6)
* control character, no-break ('''):     Requests.            (line   6)
* control character, no-break, changing ('c2'): Character Translations.
                                                              (line   6)
* control sequences, for terminals:      Invoking grotty.     (line  50)
* control, line:                         Line Control.        (line   6)
* control, page:                         Page Control.        (line   6)
* conventions for input:                 Input Conventions.   (line   6)
* copy mode:                             Copy-in Mode.        (line   6)
* copy-in mode:                          Copy-in Mode.        (line   6)
* copy-in mode, and 'cf' request:        I/O.                 (line  50)
* copy-in mode, and 'device' request:    Postprocessor Access.
                                                              (line  19)
* copy-in mode, and 'ig' request:        Comments.            (line  85)
* copy-in mode, and 'length' request:    Strings.             (line 211)
* copy-in mode, and macro arguments:     Parameters.          (line  21)
* copy-in mode, and 'output' request:    Diversions.          (line 179)
* copy-in mode, and 'tm' request:        Debugging.           (line  30)
* copy-in mode, and 'tm1' request:       Debugging.           (line  30)
* copy-in mode, and 'tmc' request:       Debugging.           (line  30)
* copy-in mode, and 'trf' request:       I/O.                 (line  50)
* copy-in mode, and 'write' request:     I/O.                 (line 212)
* copy-in mode, and 'writec' request:    I/O.                 (line 212)
* copy-in mode, and 'writem' request:    I/O.                 (line 225)
* copy-in mode, and '\!':                Diversions.          (line 148)
* copy-in mode, and '\?':                Operators in Conditionals.
                                                              (line  55)
* copy-in mode, and '\?' <1>:            Diversions.          (line 148)
* copy-in mode, and '\a':                Leaders.             (line  18)
* copy-in mode, and '\E':                Character Translations.
                                                              (line  81)
* copy-in mode, and '\t':                Tabs and Fields.     (line  10)
* copy-in mode, and '\V':                I/O.                 (line 249)
* copying environment ('evc'):           Environments.        (line  70)
* correction between italic and roman glyph ('\/', '\,'): Ligatures and Kerning.
                                                              (line  80)
* correction, italic ('\/'):             Ligatures and Kerning.
                                                              (line  80)
* correction, left italic ('\,'):        Ligatures and Kerning.
                                                              (line  91)
* cover page macros, ['ms']:             ms Cover Page Macros.
                                                              (line   6)
* 'cp' request, and glyph definitions:   Using Symbols.       (line 326)
* cp1047, input encoding:                Input Encodings.     (line   9)
* cp1047, output encoding:               Groff Options.       (line 264)
* 'cq' glyph, at end of sentence:        Sentences.           (line  18)
* 'cq' glyph, at end of sentence <1>:    Using Symbols.       (line 275)
* creating alias, for diversion ('als'): Strings.             (line 229)
* creating alias, for macro ('als'):     Strings.             (line 229)
* creating alias, for number register ('aln'): Setting Registers.
                                                              (line 112)
* creating alias, for string ('als'):    Strings.             (line 229)
* creating new characters ('char'):      Using Symbols.       (line 326)
* credits:                               Credits.             (line   6)
* 'cs' request, and font styles:         Font Families.       (line  59)
* 'cs' request, and font translations:   Changing Fonts.      (line  55)
* 'cs' request, incompatibilities with AT&T 'troff': Implementation Differences.
                                                              (line  86)
* 'cs' request, with fractional type sizes: Fractional Type Sizes.
                                                              (line   6)
* current directory:                     Macro Directories.   (line  21)
* current input file name register ('.F'): Built-in Registers.
                                                              (line  12)
* current page number ('%'):             Page Control.        (line  27)
* current time:                          I/O.                 (line 175)
* current time, hours ('hours'):         Built-in Registers.  (line  41)
* current time, minutes ('minutes'):     Built-in Registers.  (line  37)
* current time, seconds ('seconds'):     Built-in Registers.  (line  31)
* current vertical position ('nl'):      Page Control.        (line  67)
* 'da' request, and 'dn' ('dl'):         Diversions.          (line  93)
* 'da' request, and warnings:            Warnings.            (line  49)
* 'da' request, and warnings <1>:        Warnings.            (line  54)
* date, day of the month register ('dy'): Built-in Registers. (line  48)
* date, day of the week register ('dw'): Built-in Registers.  (line  45)
* date, month of the year register ('mo'): Built-in Registers.
                                                              (line  51)
* date, year register ('year', 'yr'):    Built-in Registers.  (line  54)
* day of the month register ('dy'):      Built-in Registers.  (line  48)
* day of the week register ('dw'):       Built-in Registers.  (line  45)
* 'de' request, and 'while':             while.               (line  22)
* 'de', 'de1', 'dei' requests, and warnings: Warnings.        (line  54)
* debugging:                             Debugging.           (line   6)
* default color:                         Colors.              (line  26)
* default indentation ['man']:           Miscellaneous man macros.
                                                              (line   6)
* default indentation, resetting ['man']: Man usage.          (line 127)
* default units:                         Default Units.       (line   6)
* defining character ('char'):           Using Symbols.       (line 326)
* defining character class ('class'):    Character Classes.   (line  12)
* defining fallback character ('fchar', 'fschar', 'schar'): Using Symbols.
                                                              (line 326)
* defining glyph ('char'):               Using Symbols.       (line 326)
* defining symbol ('char'):              Using Symbols.       (line 326)
* delayed text:                          Footnotes and Annotations.
                                                              (line  10)
* delimited arguments, incompatibilities with AT&T 'troff': Implementation Differences.
                                                              (line  47)
* delimiting character, for fields ('fc'): Fields.            (line   6)
* delimiting characters for arguments:   Escapes.             (line  29)
* depth, of last glyph ('.cdp'):         Environments.        (line  95)
* 'DESC' file, format:                   DESC File Format.    (line   6)
* 'device' request, and copy-in mode:    Postprocessor Access.
                                                              (line  19)
* device resolution:                     DESC File Format.    (line  85)
* devices for output:                    Output device intro. (line   6)
* devices for output <1>:                Output Devices.      (line   6)
* 'dg' glyph, at end of sentence:        Sentences.           (line  18)
* 'dg' glyph, at end of sentence <1>:    Using Symbols.       (line 275)
* 'di' request, and warnings:            Warnings.            (line  49)
* 'di' request, and warnings <1>:        Warnings.            (line  54)
* differences in implementation:         Implementation Differences.
                                                              (line   6)
* digit width space ('\0'):              Page Motions.        (line 138)
* digits, and delimiters:                Escapes.             (line  65)
* dimensions, line:                      Line Layout.         (line   6)
* directories for fonts:                 Font Directories.    (line   6)
* directories for macros:                Macro Directories.   (line   6)
* directory, current:                    Macro Directories.   (line  21)
* directory, for tmac files:             Macro Directories.   (line  11)
* directory, home:                       Macro Directories.   (line  24)
* directory, platform-specific:          Macro Directories.   (line  26)
* directory, site-specific:              Macro Directories.   (line  26)
* directory, site-specific <1>:          Font Directories.    (line  29)
* disabling hyphenation ('\%'):          Manipulating Hyphenation.
                                                              (line  85)
* disabling '\' ('eo'):                  Character Translations.
                                                              (line  24)
* discardable horizontal space:          Manipulating Filling and Adjusting.
                                                              (line 183)
* discarded space in traps:              Manipulating Spacing.
                                                              (line  53)
* displays:                              Displays.            (line   6)
* displays ['ms']:                       ms Displays and Keeps.
                                                              (line   6)
* displays, and footnotes ['ms']:        ms Footnotes.        (line  24)
* distance to next trap register ('.t'): Page Location Traps. (line 102)
* 'ditroff', the program:                History.             (line  59)
* diversion name register ('.z'):        Diversions.          (line  69)
* diversion trap, setting ('dt'):        Diversion Traps.     (line   7)
* diversion traps:                       Diversion Traps.     (line   6)
* diversion, appending ('da'):           Diversions.          (line  22)
* diversion, beginning ('di'):           Diversions.          (line  22)
* diversion, creating alias ('als'):     Strings.             (line 229)
* diversion, ending ('di'):              Diversions.          (line  22)
* diversion, nested:                     Diversions.          (line  69)
* diversion, removing ('rm'):            Strings.             (line 224)
* diversion, removing alias ('rm'):      Strings.             (line 263)
* diversion, renaming ('rn'):            Strings.             (line 221)
* diversion, stripping final newline:    Strings.             (line 157)
* diversion, top-level:                  Diversions.          (line  12)
* diversion, top-level, and 'bp':        Page Control.        (line  24)
* diversion, top-level, and '\!':        Diversions.          (line 171)
* diversion, top-level, and '\?':        Diversions.          (line 176)
* diversion, unformatting ('asciify'):   Diversions.          (line 195)
* diversion, vertical position in, register ('.d'): Diversions.
                                                              (line  69)
* diversions:                            Diversions.          (line   6)
* diversions, and traps:                 Page Location Traps. (line 166)
* diversions, shared name space with macros and strings: Strings.
                                                              (line  92)
* 'dl' register, and 'da' ('boxa'):      Diversions.          (line  93)
* 'dn' register, and 'da' ('boxa'):      Diversions.          (line  93)
* documents, multi-file:                 Debugging.           (line  10)
* documents, structuring the source code: Requests.           (line  14)
* double quote, in a macro argument:     Request and Macro Arguments.
                                                              (line  25)
* double-spacing ('ls'):                 Basics.              (line  82)
* double-spacing ('ls') <1>:             Manipulating Spacing.
                                                              (line  64)
* double-spacing ('vs', 'pvs'):          Changing Type Sizes. (line 125)
* drawing a circle ('\D'c ...''):        Drawing Requests.    (line 109)
* drawing a line ('\D'l ...''):          Drawing Requests.    (line  80)
* drawing a polygon ('\D'p ...''):       Drawing Requests.    (line 158)
* drawing a solid circle ('\D'C ...''):  Drawing Requests.    (line 114)
* drawing a solid ellipse ('\D'E ...''): Drawing Requests.    (line 124)
* drawing a solid polygon ('\D'P ...''): Drawing Requests.    (line 167)
* drawing a spline ('\D'~ ...''):        Drawing Requests.    (line 136)
* drawing an arc ('\D'a ...''):          Drawing Requests.    (line 128)
* drawing an ellipse ('\D'e ...''):      Drawing Requests.    (line 118)
* drawing color name register ('.m'):    Colors.              (line  67)
* drawing horizontal lines ('\l'):       Drawing Requests.    (line  17)
* drawing requests:                      Drawing Requests.    (line   6)
* drawing vertical lines ('\L'):         Drawing Requests.    (line  50)
* 'ds' request, and comments:            Strings.             (line  45)
* 'ds' request, and double quotes:       Request and Macro Arguments.
                                                              (line  69)
* 'ds' request, and leading spaces:      Strings.             (line  57)
* 'ds', 'ds1' requests, and comments:    Comments.            (line  16)
* 'ds', 'ds1' requests, and warnings:    Warnings.            (line  54)
* dumping environments ('pev'):          Debugging.           (line  62)
* dumping number registers ('pnr'):      Debugging.           (line  77)
* dumping symbol table ('pm'):           Debugging.           (line  66)
* dumping traps ('ptr'):                 Debugging.           (line  81)
* EBCDIC encoding:                       Tab Stops.           (line   6)
* EBCDIC encoding of a tab:              Tabs and Fields.     (line   6)
* EBCDIC encoding of backspace:          Identifiers.         (line  12)
* EBCDIC, input encoding:                Input Encodings.     (line   9)
* EBCDIC, output encoding:               Groff Options.       (line 264)
* 'el' request, and warnings:            Warnings.            (line  32)
* ellipse, drawing ('\D'e ...''):        Drawing Requests.    (line 118)
* ellipse, solid, drawing ('\D'E ...''): Drawing Requests.    (line 124)
* 'em' glyph, and 'cflags':              Using Symbols.       (line 258)
* em unit ('m'):                         Measurements.        (line  50)
* embedded commands:                     Embedded Commands.   (line   6)
* embedding PDF:                         Embedding PDF.       (line   6)
* embedding PostScript:                  Embedding PostScript.
                                                              (line   6)
* embolding of special fonts:            Artificial Fonts.    (line 115)
* empty line:                            Implicit Line Breaks.
                                                              (line  10)
* empty line ('sp'):                     Basics.              (line  93)
* empty space before a paragraph ['man']: Miscellaneous man macros.
                                                              (line  15)
* en unit ('n'):                         Measurements.        (line  55)
* enabling vertical position traps ('vpt'): Page Location Traps.
                                                              (line  18)
* encoding, EBCDIC:                      Tab Stops.           (line   6)
* encoding, input, cp1047:               Input Encodings.     (line   9)
* encoding, input, EBCDIC:               Input Encodings.     (line   9)
* encoding, input, latin-1 (ISO 8859-1): Input Encodings.     (line  14)
* encoding, input, latin-2 (ISO 8859-2): Input Encodings.     (line  18)
* encoding, input, latin-5 (ISO 8859-9): Input Encodings.     (line  23)
* encoding, input, latin-9 (latin-0, ISO 8859-15): Input Encodings.
                                                              (line  28)
* encoding, output, ASCII:               Groff Options.       (line 250)
* encoding, output, cp1047:              Groff Options.       (line 264)
* encoding, output, EBCDIC:              Groff Options.       (line 264)
* encoding, output, latin-1 (ISO 8859-1): Groff Options.      (line 254)
* encoding, output, utf-8:               Groff Options.       (line 259)
* end of conditional block ('\}'):       if-else.             (line  35)
* end-of-input macro ('em'):             End-of-input Traps.  (line   7)
* end-of-input trap, setting ('em'):     End-of-input Traps.  (line   7)
* end-of-input traps:                    End-of-input Traps.  (line   6)
* end-of-sentence characters:            Using Symbols.       (line 247)
* ending diversion ('di'):               Diversions.          (line  22)
* environment number/name register ('.ev'): Environments.     (line  39)
* environment variables:                 Environment.         (line   6)
* environment, copying ('evc'):          Environments.        (line  70)
* environment, dimensions of last glyph ('.w', '.cht', '.cdp', '.csk'): Environments.
                                                              (line  95)
* environment, previous line length ('.n'): Environments.     (line 110)
* environment, switching ('ev'):         Environments.        (line  39)
* environments:                          Environments.        (line   6)
* environments, dumping ('pev'):         Debugging.           (line  62)
* 'eqn', the program:                    geqn.                (line   6)
* equations ['ms']:                      ms Insertions.       (line   6)
* escape character, changing ('ec'):     Character Translations.
                                                              (line  47)
* escape character, while defining glyph: Using Symbols.      (line 326)
* escapes:                               Escapes.             (line   6)
* escaping newline characters, in strings: Strings.           (line  63)
* 'ex' request, use in debugging:        Debugging.           (line  45)
* 'ex' request, used with 'nx' and 'rd': I/O.                 (line 122)
* example markup, bulleted list ['ms']:  Lists in ms.         (line  21)
* example markup, glossary-style list ['ms']: Lists in ms.    (line  65)
* example markup, multi-page table ['ms']: Example multi-page table.
                                                              (line   6)
* example markup, numbered list ['ms']:  Lists in ms.         (line  41)
* example markup, title page:            ms Cover Page Macros.
                                                              (line  66)
* examples of invocation:                Invocation Examples. (line   6)
* exiting ('ex'):                        Debugging.           (line  45)
* expansion of strings ('\*'):           Strings.             (line  19)
* explicit hyphen ('\%'):                Manipulating Hyphenation.
                                                              (line  47)
* expression, limitation of logical not in: Expressions.      (line  27)
* expression, order of evaluation:       Expressions.         (line  59)
* expressions:                           Expressions.         (line   6)
* expressions, and space characters:     Expressions.         (line  86)
* extra post-vertical line space ('\x'): Changing Type Sizes. (line 118)
* extra post-vertical line space register ('.a'): Manipulating Spacing.
                                                              (line  94)
* extra pre-vertical line space ('\x'):  Changing Type Sizes. (line 109)
* extra spaces:                          Filling and Adjusting.
                                                              (line  10)
* extremum operators ('>?', '<?'):       Expressions.         (line  44)
* 'f' unit:                              Measurements.        (line  43)
* 'f' unit, and colors:                  Colors.              (line  36)
* factor, zoom, of a font ('fzoom'):     Changing Fonts.      (line  71)
* fallback character, defining ('fchar', 'fschar', 'schar'): Using Symbols.
                                                              (line 326)
* fallback glyph, removing definition ('rchar', 'rfschar'): Using Symbols.
                                                              (line 382)
* 'fam' request, and changing fonts:     Changing Fonts.      (line  11)
* 'fam' request, and font positions:     Font Positions.      (line  60)
* families, font:                        Font Families.       (line   6)
* features, common:                      Common Features.     (line   6)
* 'fi' request, causing implicit linebreak: Manipulating Filling and Adjusting.
                                                              (line   6)
* field delimiting character ('fc'):     Fields.              (line   6)
* field padding character ('fc'):        Fields.              (line   6)
* fields:                                Fields.              (line   6)
* fields, and tabs:                      Tabs and Fields.     (line   6)
* figures ['ms']:                        ms Insertions.       (line   6)
* file formats:                          File formats.        (line   6)
* file, appending to ('opena'):          I/O.                 (line 200)
* file, closing ('close'):               I/O.                 (line 231)
* file, inclusion ('so'):                I/O.                 (line   9)
* file, opening ('open'):                I/O.                 (line 200)
* file, processing next ('nx'):          I/O.                 (line  84)
* file, writing to ('write', 'writec'):  I/O.                 (line 212)
* files, font:                           Font Files.          (line   6)
* files, macro, searching:               Macro Directories.   (line  11)
* fill color name register ('.M'):       Colors.              (line  94)
* fill colors, unnamed ('\D'F...''):     Drawing Requests.    (line 216)
* fill mode:                             Implicit Line Breaks.
                                                              (line  15)
* fill mode <1>:                         Manipulating Filling and Adjusting.
                                                              (line 156)
* fill mode <2>:                         Warnings.            (line  23)
* fill mode ('fi'):                      Manipulating Filling and Adjusting.
                                                              (line  29)
* fill mode, and '\c':                   Line Control.        (line  69)
* filling:                               Filling and Adjusting.
                                                              (line   6)
* filling and adjusting, manipulating:   Manipulating Filling and Adjusting.
                                                              (line   6)
* final newline, stripping in diversions: Strings.            (line 157)
* 'fl' request, causing implicit linebreak: Manipulating Filling and Adjusting.
                                                              (line   6)
* floating keep:                         Displays.            (line  23)
* flush output ('fl'):                   Debugging.           (line  87)
* font description file, format:         DESC File Format.    (line   6)
* font description file, format <1>:     Font File Format.    (line   6)
* font directories:                      Font Directories.    (line   6)
* font families:                         Font Families.       (line   6)
* font family, changing ('fam', '\F'):   Font Families.       (line  25)
* font file, format:                     Font File Format.    (line   6)
* font files:                            Font Files.          (line   6)
* font files, comments:                  Font File Format.    (line  36)
* font for underlining ('uf'):           Artificial Fonts.    (line  90)
* font height, changing ('\H'):          Artificial Fonts.    (line  16)
* font path:                             Font Directories.    (line  14)
* font position register ('.f'):         Font Positions.      (line  20)
* font position, changing ('\f'):        Font Positions.      (line  60)
* font positions:                        Font Positions.      (line   6)
* font selection ['man']:                Man font macros.     (line   6)
* font slant, changing ('\S'):           Artificial Fonts.    (line  45)
* font style, changing ('sty'):          Font Families.       (line  59)
* font styles:                           Font Families.       (line   6)
* font translation ('ftr'):              Changing Fonts.      (line  55)
* font, magnification ('fzoom'):         Changing Fonts.      (line  71)
* font, mounting ('fp'):                 Font Positions.      (line  13)
* font, optical size:                    Changing Fonts.      (line  71)
* font, previous ('ft', '\f[]', '\fP'):  Changing Fonts.      (line  23)
* font, zoom factor ('fzoom'):           Changing Fonts.      (line  71)
* fonts:                                 Fonts and Symbols.   (line   6)
* fonts <1>:                             Changing Fonts.      (line   6)
* fonts, artificial:                     Artificial Fonts.    (line   6)
* fonts, changing ('ft', '\f'):          Changing Fonts.      (line  11)
* fonts, PostScript:                     Font Families.       (line  11)
* fonts, searching:                      Font Directories.    (line   6)
* fonts, special:                        Special Fonts.       (line   6)
* footers:                               Page Layout.         (line  31)
* footers <1>:                           Page Location Traps. (line  38)
* footers ['ms']:                        ms Headers and Footers.
                                                              (line   6)
* footnotes:                             Footnotes and Annotations.
                                                              (line   6)
* footnotes ['ms']:                      ms Footnotes.        (line   6)
* footnotes, and displays ['ms']:        ms Footnotes.        (line  24)
* footnotes, and keeps ['ms']:           ms Footnotes.        (line  24)
* form letters:                          I/O.                 (line 106)
* format of font description file:       DESC File Format.    (line   6)
* format of font description files:      Font File Format.    (line   6)
* format of font files:                  Font File Format.    (line   6)
* format of register ('\g'):             Assigning Formats.   (line  75)
* formats, assigning ('af'):             Assigning Formats.   (line   6)
* formats, file:                         File formats.        (line   6)
* 'fp' request, and font translations:   Changing Fonts.      (line  55)
* 'fp' request, incompatibilities with AT&T 'troff': Implementation Differences.
                                                              (line  86)
* fractional point sizes:                Fractional Type Sizes.
                                                              (line   6)
* fractional point sizes <1>:            Implementation Differences.
                                                              (line  76)
* fractional type sizes:                 Fractional Type Sizes.
                                                              (line   6)
* fractional type sizes <1>:             Implementation Differences.
                                                              (line  76)
* french-spacing:                        Sentences.           (line  12)
* 'fspecial' request, and font styles:   Font Families.       (line  59)
* 'fspecial' request, and font translations: Changing Fonts.  (line  55)
* 'fspecial' request, and glyph search order: Using Symbols.  (line  14)
* 'fspecial' request, and imitating bold: Artificial Fonts.   (line 115)
* 'ft' request, and font translations:   Changing Fonts.      (line  55)
* 'gchem', invoking:                     Invoking gchem.      (line   5)
* 'gchem', the program:                  gchem.               (line   6)
* 'geqn', invoking:                      Invoking geqn.       (line   5)
* 'geqn', the program:                   geqn.                (line   6)
* GGL (groff glyph list):                Using Symbols.       (line  88)
* GGL (groff glyph list) <1>:            Character Classes.   (line  32)
* 'ggrn', invoking:                      Invoking ggrn.       (line   5)
* 'ggrn', the program:                   ggrn.                (line   6)
* glossary-style list, example markup ['ms']: Lists in ms.    (line  65)
* glyph:                                 Using Symbols.       (line   6)
* glyph for line drawing:                Drawing Requests.    (line  50)
* glyph names, composite:                Using Symbols.       (line  88)
* glyph pile ('\b'):                     Drawing Requests.    (line 232)
* glyph properties ('cflags'):           Using Symbols.       (line 237)
* glyph, box rule ('\[br]'):             Drawing Requests.    (line  50)
* glyph, constant space:                 Artificial Fonts.    (line 126)
* glyph, defining ('char'):              Using Symbols.       (line 326)
* glyph, for line drawing:               Drawing Requests.    (line  28)
* glyph, for margins ('mc'):             Miscellaneous.       (line  75)
* glyph, italic correction ('\/'):       Ligatures and Kerning.
                                                              (line  80)
* glyph, last, dimensions ('.w', '.cht', '.cdp', '.csk'): Environments.
                                                              (line  95)
* glyph, leader repetition ('lc'):       Leaders.             (line  23)
* glyph, left italic correction ('\,'):  Ligatures and Kerning.
                                                              (line  91)
* glyph, numbered ('\N'):                Character Translations.
                                                              (line 160)
* glyph, numbered ('\N') <1>:            Using Symbols.       (line 201)
* glyph, removing definition ('rchar', 'rfschar'): Using Symbols.
                                                              (line 382)
* glyph, soft hyphen ('hy'):             Manipulating Hyphenation.
                                                              (line 243)
* glyph, tab repetition ('tc'):          Tabs and Fields.     (line 129)
* glyph, underscore ('\[ru]'):           Drawing Requests.    (line  28)
* glyphs, available, list ('groff_char(7)' man page): Using Symbols.
                                                              (line  76)
* glyphs, output, and input characters, compatibility with AT&T 'troff': Implementation Differences.
                                                              (line  86)
* glyphs, overstriking ('\o'):           Page Motions.        (line 216)
* glyphs, unnamed:                       Using Symbols.       (line 212)
* glyphs, unnamed, accessing with '\N':  Font File Format.    (line  51)
* GNU-specific register ('.g'):          Built-in Registers.  (line 102)
* 'gpic', invoking:                      Invoking gpic.       (line   5)
* 'gpic', the program:                   gpic.                (line   6)
* 'grap', the program:                   grap.                (line   6)
* gray shading ('\D'f ...''):            Drawing Requests.    (line 141)
* 'grefer', invoking:                    Invoking grefer.     (line   5)
* 'grefer', the program:                 grefer.              (line   6)
* 'grn', the program:                    ggrn.                (line   6)
* 'grodvi', invoking:                    Invoking grodvi.     (line   6)
* 'grodvi', the program:                 grodvi.              (line   6)
* 'groff' - what is it?:                 What Is groff?.      (line   6)
* 'groff' capabilities:                  groff Capabilities.  (line   6)
* groff glyph list (GGL):                Using Symbols.       (line  88)
* groff glyph list (GGL) <1>:            Character Classes.   (line  32)
* 'groff' invocation:                    Invoking groff.      (line   6)
* 'groff', and 'pi' request:             I/O.                 (line 159)
* GROFF_BIN_PATH, environment variable:  Environment.         (line  10)
* GROFF_COMMAND_PREFIX, environment variable: Environment.    (line  14)
* GROFF_ENCODING, environment variable:  Environment.         (line  25)
* GROFF_FONT_PATH, environment variable: Environment.         (line  34)
* GROFF_FONT_PATH, environment variable <1>: Font Directories.
                                                              (line  26)
* GROFF_TMAC_PATH, environment variable: Environment.         (line  39)
* GROFF_TMAC_PATH, environment variable <1>: Macro Directories.
                                                              (line  18)
* GROFF_TMPDIR, environment variable:    Environment.         (line  44)
* GROFF_TYPESETTER, environment variable: Environment.        (line  52)
* 'grohtml', invoking:                   Invoking grohtml.    (line   6)
* 'grohtml', registers and strings:      grohtml specific registers and strings.
                                                              (line   6)
* 'grohtml', the program:                Groff Options.       (line 275)
* 'grohtml', the program <1>:            grohtml.             (line   6)
* 'grolbp', invoking:                    Invoking grolbp.     (line   6)
* 'grolbp', the program:                 grolbp.              (line   6)
* 'grolj4', invoking:                    Invoking grolj4.     (line   6)
* 'grolj4', the program:                 grolj4.              (line   6)
* 'gropdf', invoking:                    Invoking gropdf.     (line   6)
* 'gropdf', the program:                 gropdf.              (line   6)
* 'grops', invoking:                     Invoking grops.      (line   6)
* 'grops', the program:                  grops.               (line   6)
* 'grotty', invoking:                    Invoking grotty.     (line   6)
* 'grotty', the program:                 grotty.              (line   6)
* 'gsoelim', invoking:                   Invoking gsoelim.    (line   5)
* 'gsoelim', the program:                gsoelim.             (line   6)
* 'gtbl', invoking:                      Invoking gtbl.       (line   5)
* 'gtbl', the program:                   gtbl.                (line   6)
* 'gtroff', identification register ('.g'): Built-in Registers.
                                                              (line 102)
* 'gtroff', interactive use:             Debugging.           (line  87)
* 'gtroff', output:                      gtroff Output.       (line   6)
* 'gtroff', process ID register ('$$'):  Built-in Registers.  (line  99)
* 'gtroff', reference:                   gtroff Reference.    (line   6)
* 'gxditview', invoking:                 Invoking gxditview.  (line   5)
* 'gxditview', the program:              gxditview.           (line   6)
* hanging indentation ['man']:           Man usage.           (line  98)
* 'hcode' request, and glyph definitions: Using Symbols.      (line 326)
* headers:                               Page Layout.         (line  31)
* headers <1>:                           Page Location Traps. (line  38)
* headers ['ms']:                        ms Headers and Footers.
                                                              (line   6)
* height, font, changing ('\H'):         Artificial Fonts.    (line  16)
* height, of last glyph ('.cht'):        Environments.        (line  95)
* high-water mark register ('.h'):       Diversions.          (line  76)
* history:                               History.             (line   6)
* home directory:                        Macro Directories.   (line  24)
* horizontal discardable space:          Manipulating Filling and Adjusting.
                                                              (line 183)
* horizontal input line position register ('hp'): Page Motions.
                                                              (line 209)
* horizontal input line position, saving ('\k'): Page Motions.
                                                              (line 203)
* horizontal line, drawing ('\l'):       Drawing Requests.    (line  17)
* horizontal motion ('\h'):              Page Motions.        (line 103)
* horizontal output line position register ('.k'): Page Motions.
                                                              (line 212)
* horizontal resolution:                 DESC File Format.    (line  25)
* horizontal resolution register ('.H'): Built-in Registers.  (line  15)
* horizontal space ('\h'):               Page Motions.        (line 103)
* horizontal space, unformatting:        Strings.             (line 157)
* hours, current time ('hours'):         Built-in Registers.  (line  41)
* 'hpf' request, and hyphenation language: Manipulating Hyphenation.
                                                              (line 256)
* 'hw' request, and hyphenation language: Manipulating Hyphenation.
                                                              (line 256)
* 'hy' glyph, and 'cflags':              Using Symbols.       (line 258)
* hyphen, explicit ('\%'):               Manipulating Hyphenation.
                                                              (line  47)
* hyphenated lines, consecutive ('hlm'): Manipulating Hyphenation.
                                                              (line  47)
* hyphenating characters:                Using Symbols.       (line 251)
* hyphenation:                           Hyphenation.         (line   6)
* hyphenation character ('\%'):          Manipulating Hyphenation.
                                                              (line  85)
* hyphenation code ('hcode'):            Manipulating Hyphenation.
                                                              (line 175)
* hyphenation language register ('.hla'): Manipulating Hyphenation.
                                                              (line 263)
* hyphenation margin ('hym'):            Manipulating Hyphenation.
                                                              (line 211)
* hyphenation margin register ('.hym'):  Manipulating Hyphenation.
                                                              (line 222)
* hyphenation patterns ('hpf'):          Manipulating Hyphenation.
                                                              (line 116)
* hyphenation restrictions register ('.hy'): Manipulating Hyphenation.
                                                              (line  30)
* hyphenation space ('hys'):             Manipulating Hyphenation.
                                                              (line 227)
* hyphenation space register ('.hys'):   Manipulating Hyphenation.
                                                              (line 239)
* hyphenation, disabling ('\%'):         Manipulating Hyphenation.
                                                              (line  85)
* hyphenation, manipulating:             Manipulating Hyphenation.
                                                              (line   6)
* 'i' unit:                              Measurements.        (line  22)
* i/o:                                   I/O.                 (line   6)
* IBM cp1047 input encoding:             Input Encodings.     (line   9)
* IBM cp1047 output encoding:            Groff Options.       (line 264)
* identifiers:                           Identifiers.         (line   6)
* identifiers, undefined:                Identifiers.         (line  79)
* 'ie' request, and font translations:   Changing Fonts.      (line  55)
* 'ie' request, and warnings:            Warnings.            (line  32)
* 'ie' request, operators to use with:   Operators in Conditionals.
                                                              (line   6)
* 'if' request, and font translations:   Changing Fonts.      (line  55)
* 'if' request, and the '!' operator:    Expressions.         (line  21)
* 'if' request, operators to use with:   Operators in Conditionals.
                                                              (line   6)
* if-else:                               if-else.             (line   6)
* 'ig' request, and auto-increment:      Comments.            (line  85)
* 'ig' request, and copy-in mode:        Comments.            (line  85)
* imitating bold face ('bd'):            Artificial Fonts.    (line  98)
* implementation differences:            Implementation Differences.
                                                              (line   6)
* implicit breaks of lines:              Implicit Line Breaks.
                                                              (line   6)
* implicit line breaks:                  Implicit Line Breaks.
                                                              (line   6)
* 'in' request, causing implicit linebreak: Manipulating Filling and Adjusting.
                                                              (line   6)
* 'in' request, using '+' and '-':       Expressions.         (line  75)
* inch unit ('i'):                       Measurements.        (line  22)
* including a file ('so'):               I/O.                 (line   9)
* incompatibilities with AT&T 'troff':   Implementation Differences.
                                                              (line   6)
* increment value without changing the register: Auto-increment.
                                                              (line  52)
* increment, automatic:                  Auto-increment.      (line   6)
* indentaion, resetting to default ['man']: Man usage.        (line 127)
* indentation ('in'):                    Line Layout.         (line  25)
* index, in macro package:               Indices.             (line   6)
* indicator, scaling:                    Measurements.        (line   6)
* indirect assignments:                  Interpolating Registers.
                                                              (line  11)
* input and output requests:             I/O.                 (line   6)
* input characters and output glyphs, compatibility with AT&T 'troff': Implementation Differences.
                                                              (line  86)
* input characters, invalid:             Identifiers.         (line  15)
* input conventions:                     Input Conventions.   (line   6)
* input encoding, cp1047:                Input Encodings.     (line   9)
* input encoding, EBCDIC:                Input Encodings.     (line   9)
* input encoding, latin-1 (ISO 8859-1):  Input Encodings.     (line  14)
* input encoding, latin-2 (ISO 8859-2):  Input Encodings.     (line  18)
* input encoding, latin-2 (ISO 8859-9):  Input Encodings.     (line  23)
* input encoding, latin-9 (latin-9, ISO 8859-15): Input Encodings.
                                                              (line  28)
* input file name, current, register ('.F'): Built-in Registers.
                                                              (line  12)
* input level in delimited arguments:    Implementation Differences.
                                                              (line  47)
* input line continuation ('\'):         Line Control.        (line  36)
* input line number register ('.c', 'c.'): Built-in Registers.
                                                              (line  77)
* input line number, setting ('lf'):     Debugging.           (line  10)
* input line position, horizontal, saving ('\k'): Page Motions.
                                                              (line 203)
* input line trap, setting ('it'):       Input Line Traps.    (line   8)
* input line traps:                      Input Line Traps.    (line   6)
* input line traps and interrupted lines ('itc'): Input Line Traps.
                                                              (line  24)
* input line, horizontal position, register ('hp'): Page Motions.
                                                              (line 209)
* input stack, backtrace ('backtrace'):  Debugging.           (line  96)
* input stack, setting limit:            Debugging.           (line 119)
* input token:                           Gtroff Internals.    (line   6)
* input, 8-bit:                          Font File Format.    (line  51)
* input, standard, reading from ('rd'):  I/O.                 (line  89)
* inserting horizontal space ('\h'):     Page Motions.        (line 103)
* installation:                          Installation.        (line   5)
* interactive use of 'gtroff':           Debugging.           (line  87)
* intermediate output:                   gtroff Output.       (line  16)
* interpolating registers ('\n'):        Interpolating Registers.
                                                              (line   6)
* interpolation of strings ('\*'):       Strings.             (line  19)
* interrupted line:                      Line Control.        (line  36)
* interrupted line register ('.int'):    Line Control.        (line  81)
* interrupted lines and input line traps ('itc'): Input Line Traps.
                                                              (line  24)
* introduction:                          Introduction.        (line   6)
* invalid characters for 'trf' request:  I/O.                 (line  73)
* invalid input characters:              Identifiers.         (line  15)
* invocation examples:                   Invocation Examples. (line   6)
* invoking 'gchem':                      Invoking gchem.      (line   6)
* invoking 'geqn':                       Invoking geqn.       (line   6)
* invoking 'ggrn':                       Invoking ggrn.       (line   6)
* invoking 'gpic':                       Invoking gpic.       (line   6)
* invoking 'grefer':                     Invoking grefer.     (line   6)
* invoking 'grodvi':                     Invoking grodvi.     (line   6)
* invoking 'groff':                      Invoking groff.      (line   6)
* invoking 'grohtml':                    Invoking grohtml.    (line   6)
* invoking 'grolbp':                     Invoking grolbp.     (line   6)
* invoking 'grolj4':                     Invoking grolj4.     (line   6)
* invoking 'gropdf':                     Invoking gropdf.     (line   6)
* invoking 'grops':                      Invoking grops.      (line   6)
* invoking 'grotty':                     Invoking grotty.     (line   6)
* invoking 'gsoelim':                    Invoking gsoelim.    (line   6)
* invoking 'gtbl':                       Invoking gtbl.       (line   6)
* invoking 'gxditview':                  Invoking gxditview.  (line   6)
* invoking 'preconv':                    Invoking preconv.    (line   6)
* ISO 6249 SGR:                          Invoking grotty.     (line  50)
* ISO 8859-1 (latin-1), input encoding:  Input Encodings.     (line  14)
* ISO 8859-1 (latin-1), output encoding: Groff Options.       (line 254)
* ISO 8859-15 (latin-9, latin-0), input encoding: Input Encodings.
                                                              (line  28)
* ISO 8859-2 (latin-2), input encoding:  Input Encodings.     (line  18)
* ISO 8859-9 (latin-2), input encoding:  Input Encodings.     (line  23)
* italic correction ('\/'):              Ligatures and Kerning.
                                                              (line  80)
* italic fonts ['man']:                  Man font macros.     (line  52)
* italic glyph, correction after roman glyph ('\,'): Ligatures and Kerning.
                                                              (line  91)
* italic glyph, correction before roman glyph ('\/'): Ligatures and Kerning.
                                                              (line  80)
* justifying text:                       Manipulating Filling and Adjusting.
                                                              (line   6)
* justifying text ('rj'):                Manipulating Filling and Adjusting.
                                                              (line 250)
* keep:                                  Displays.            (line  18)
* keep, floating:                        Displays.            (line  23)
* keeps ['ms']:                          ms Displays and Keeps.
                                                              (line   6)
* keeps, and footnotes ['ms']:           ms Footnotes.        (line  24)
* kerning and ligatures:                 Ligatures and Kerning.
                                                              (line   6)
* kerning enabled register ('.kern'):    Ligatures and Kerning.
                                                              (line  42)
* kerning, activating ('kern'):          Ligatures and Kerning.
                                                              (line  42)
* kerning, track:                        Ligatures and Kerning.
                                                              (line  53)
* landscape page orientation:            Paper Size.          (line   6)
* last glyph, dimensions ('.w', '.cht', '.cdp', '.csk'): Environments.
                                                              (line  95)
* last-requested point size registers ('.psr', '.sr'): Fractional Type Sizes.
                                                              (line  45)
* latin-1 (ISO 8859-1), input encoding:  Input Encodings.     (line  14)
* latin-1 (ISO 8859-1), output encoding: Groff Options.       (line 254)
* latin-2 (ISO 8859-2), input encoding:  Input Encodings.     (line  18)
* latin-2 (ISO 8859-9), input encoding:  Input Encodings.     (line  23)
* latin-9 (latin-0, ISO 8859-15), input encoding: Input Encodings.
                                                              (line  28)
* layout, line:                          Line Layout.         (line   6)
* layout, page:                          Page Layout.         (line   6)
* 'lc' request, and glyph definitions:   Using Symbols.       (line 326)
* leader character:                      Leaders.             (line  12)
* leader character, and translations:    Character Translations.
                                                              (line 169)
* leader character, non-interpreted ('\a'): Leaders.          (line  18)
* leader repetition character ('lc'):    Leaders.             (line  23)
* leaders:                               Leaders.             (line   6)
* leading:                               Sizes.               (line  17)
* leading spaces:                        Filling and Adjusting.
                                                              (line  10)
* leading spaces macro ('lsm'):          Implicit Line Breaks.
                                                              (line  15)
* leading spaces macro ('lsm') <1>:      Leading Spaces Traps.
                                                              (line   9)
* leading spaces traps:                  Leading Spaces Traps.
                                                              (line   6)
* leading spaces with 'ds':              Strings.             (line  57)
* left italic correction ('\,'):         Ligatures and Kerning.
                                                              (line  91)
* left margin ('po'):                    Line Layout.         (line  21)
* left margin, how to move ['man']:      Man usage.           (line 106)
* length of a string ('length'):         Strings.             (line 211)
* length of line ('ll'):                 Line Layout.         (line  29)
* length of page ('pl'):                 Page Layout.         (line  13)
* length of previous line ('.n'):        Environments.        (line 110)
* length of title line ('lt'):           Page Layout.         (line  67)
* 'length' request, and copy-in mode:    Strings.             (line 211)
* letters, form:                         I/O.                 (line 106)
* level of warnings ('warn'):            Debugging.           (line 155)
* ligature:                              Using Symbols.       (line   6)
* ligatures and kerning:                 Ligatures and Kerning.
                                                              (line   6)
* ligatures enabled register ('.lg'):    Ligatures and Kerning.
                                                              (line  24)
* ligatures, activating ('lg'):          Ligatures and Kerning.
                                                              (line  24)
* limitations of '\b' escape:            Drawing Requests.    (line 239)
* line break:                            Basics.              (line  48)
* line break <1>:                        Implicit Line Breaks.
                                                              (line   6)
* line break <2>:                        Manipulating Filling and Adjusting.
                                                              (line   6)
* line break ('br'):                     Basics.              (line 118)
* line breaks, with vertical space ['man']: Man usage.        (line 120)
* line breaks, without vertical space ['man']: Man usage.     (line 124)
* line control:                          Line Control.        (line   6)
* line dimensions:                       Line Layout.         (line   6)
* line drawing glyph:                    Drawing Requests.    (line  28)
* line drawing glyph <1>:                Drawing Requests.    (line  50)
* line indentation ('in'):               Line Layout.         (line  25)
* line layout:                           Line Layout.         (line   6)
* line length ('ll'):                    Line Layout.         (line  29)
* line length register ('.l'):           Line Layout.         (line 158)
* line length, previous ('.n'):          Environments.        (line 110)
* line number, input, register ('.c', 'c.'): Built-in Registers.
                                                              (line  77)
* line number, output, register ('ln'):  Built-in Registers.  (line  82)
* line numbers, printing ('nm'):         Miscellaneous.       (line  10)
* line space, extra post-vertical ('\x'): Changing Type Sizes.
                                                              (line 118)
* line space, extra pre-vertical ('\x'): Changing Type Sizes. (line 109)
* line spacing register ('.L'):          Manipulating Spacing.
                                                              (line  75)
* line spacing, post-vertical ('pvs'):   Changing Type Sizes. (line 122)
* line thickness ('\D't ...''):          Drawing Requests.    (line 206)
* line, blank:                           Implicit Line Breaks.
                                                              (line  10)
* line, drawing ('\D'l ...''):           Drawing Requests.    (line  80)
* line, empty ('sp'):                    Basics.              (line  93)
* line, horizontal, drawing ('\l'):      Drawing Requests.    (line  17)
* line, implicit breaks:                 Implicit Line Breaks.
                                                              (line   6)
* line, input, continuation ('\'):       Line Control.        (line  36)
* line, input, horizontal position, register ('hp'): Page Motions.
                                                              (line 209)
* line, input, horizontal position, saving ('\k'): Page Motions.
                                                              (line 203)
* line, interrupted:                     Line Control.        (line  36)
* line, output, continuation ('\c'):     Line Control.        (line  36)
* line, output, horizontal position, register ('.k'): Page Motions.
                                                              (line 212)
* line, vertical, drawing ('\L'):        Drawing Requests.    (line  50)
* line-tabs mode:                        Tabs and Fields.     (line 138)
* lines, blank, disabling:               Manipulating Spacing.
                                                              (line 123)
* lines, centering ('ce'):               Basics.              (line 105)
* lines, centering ('ce') <1>:           Manipulating Filling and Adjusting.
                                                              (line 204)
* lines, consecutive hyphenated ('hlm'): Manipulating Hyphenation.
                                                              (line  47)
* lines, interrupted, and input line traps ('itc'): Input Line Traps.
                                                              (line  24)
* list:                                  Displays.            (line  13)
* list of available glyphs ('groff_char(7)' man page): Using Symbols.
                                                              (line  76)
* 'll' request, using '+' and '-':       Expressions.         (line  75)
* location, vertical, page, marking ('mk'): Page Motions.     (line  11)
* location, vertical, page, returning to marked ('rt'): Page Motions.
                                                              (line  11)
* logical not, limitation in expression: Expressions.         (line  27)
* logical operators:                     Expressions.         (line  19)
* long names:                            Implementation Differences.
                                                              (line   9)
* loops and conditionals:                Conditionals and Loops.
                                                              (line   6)
* 'lq' glyph, and 'lq' string ['man']:   Predefined man strings.
                                                              (line  22)
* 'ls' request, alternative to ('pvs'):  Changing Type Sizes. (line 137)
* 'lt' request, using '+' and '-':       Expressions.         (line  75)
* 'm' unit:                              Measurements.        (line  50)
* 'M' unit:                              Measurements.        (line  62)
* machine unit ('u'):                    Measurements.        (line   6)
* macro arguments:                       Request and Macro Arguments.
                                                              (line   6)
* macro arguments, and compatibility mode: Gtroff Internals.  (line  91)
* macro arguments, and tabs:             Request and Macro Arguments.
                                                              (line   6)
* macro basics:                          Basics.              (line   6)
* macro directories:                     Macro Directories.   (line   6)
* macro files, searching:                Macro Directories.   (line  11)
* macro name register ('\$0'):           Parameters.          (line  71)
* macro names, starting with '[' or ']', and 'refer': Identifiers.
                                                              (line  46)
* macro packages:                        Macro Package Intro. (line   6)
* macro packages <1>:                    Macro Packages.      (line   6)
* macro packages, structuring the source code: Requests.      (line  14)
* macro, appending ('am'):               Writing Macros.      (line 116)
* macro, arguments ('\$'):               Parameters.          (line  21)
* macro, creating alias ('als'):         Strings.             (line 229)
* macro, end-of-input ('em'):            End-of-input Traps.  (line   7)
* macro, removing ('rm'):                Strings.             (line 224)
* macro, removing alias ('rm'):          Strings.             (line 263)
* macro, renaming ('rn'):                Strings.             (line 221)
* macros:                                Macros.              (line   6)
* macros for manual pages ['man']:       Man usage.           (line   6)
* macros, recursive:                     while.               (line  38)
* macros, searching:                     Macro Directories.   (line   6)
* macros, shared name space with strings and diversions: Strings.
                                                              (line  92)
* macros, tutorial for users:            Tutorial for Macro Users.
                                                              (line   6)
* macros, writing:                       Writing Macros.      (line   6)
* magnification of a font ('fzoom'):     Changing Fonts.      (line  71)
* major quotes:                          Displays.            (line  10)
* major version number register ('.x'):  Built-in Registers.  (line  88)
* 'man' macros:                          Man usage.           (line   6)
* 'man' macros, bold face:               Man font macros.     (line  14)
* 'man' macros, custom headers and footers: Optional man extensions.
                                                              (line  12)
* 'man' macros, default indentation:     Miscellaneous man macros.
                                                              (line   6)
* 'man' macros, empty space before a paragraph: Miscellaneous man macros.
                                                              (line  15)
* 'man' macros, hanging indentation:     Man usage.           (line  98)
* 'man' macros, how to set fonts:        Man font macros.     (line   6)
* 'man' macros, italic fonts:            Man font macros.     (line  52)
* 'man' macros, line breaks with vertical space: Man usage.   (line 120)
* 'man' macros, line breaks without vertical space: Man usage.
                                                              (line 124)
* 'man' macros, moving left margin:      Man usage.           (line 106)
* 'man' macros, resetting default indentation: Man usage.     (line 127)
* 'man' macros, tab stops:               Miscellaneous man macros.
                                                              (line  10)
* 'man' macros, Ultrix-specific:         Optional man extensions.
                                                              (line  30)
* man pages:                             man.                 (line   6)
* manipulating filling and adjusting:    Manipulating Filling and Adjusting.
                                                              (line   6)
* manipulating hyphenation:              Manipulating Hyphenation.
                                                              (line   6)
* manipulating spacing:                  Manipulating Spacing.
                                                              (line   6)
* 'man'macros, BSD compatibility:        Miscellaneous man macros.
                                                              (line  27)
* 'man'macros, BSD compatibility <1>:    Miscellaneous man macros.
                                                              (line  44)
* manual pages:                          man.                 (line   6)
* margin for hyphenation ('hym'):        Manipulating Hyphenation.
                                                              (line 211)
* margin glyph ('mc'):                   Miscellaneous.       (line  75)
* margin, bottom:                        Page Layout.         (line  20)
* margin, left ('po'):                   Line Layout.         (line  21)
* margin, top:                           Page Layout.         (line  20)
* mark, high-water, register ('.h'):     Diversions.          (line  76)
* marking vertical page location ('mk'): Page Motions.        (line  11)
* MathML:                                grohtml specific registers and strings.
                                                              (line  23)
* maximum values of Roman numerals:      Assigning Formats.   (line  59)
* 'mdoc' macros:                         mdoc.                (line   6)
* 'me' macro package:                    me.                  (line   6)
* measurement unit:                      Measurements.        (line   6)
* measurements:                          Measurements.        (line   6)
* measurements, specifying safely:       Default Units.       (line  25)
* minimum values of Roman numerals:      Assigning Formats.   (line  59)
* minor version number register ('.y'):  Built-in Registers.  (line  92)
* minutes, current time ('minutes'):     Built-in Registers.  (line  37)
* 'mm' macro package:                    mm.                  (line   6)
* mode for constant glyph space ('cs'):  Artificial Fonts.    (line 126)
* mode, compatibility:                   Implementation Differences.
                                                              (line   6)
* mode, compatibility, and parameters:   Gtroff Internals.    (line  91)
* mode, copy:                            Copy-in Mode.        (line   6)
* mode, copy-in:                         Copy-in Mode.        (line   6)
* mode, copy-in, and 'cf' request:       I/O.                 (line  50)
* mode, copy-in, and 'device' request:   Postprocessor Access.
                                                              (line  19)
* mode, copy-in, and 'ig' request:       Comments.            (line  85)
* mode, copy-in, and 'length' request:   Strings.             (line 211)
* mode, copy-in, and macro arguments:    Parameters.          (line  21)
* mode, copy-in, and 'output' request:   Diversions.          (line 179)
* mode, copy-in, and 'tm' request:       Debugging.           (line  30)
* mode, copy-in, and 'tm1' request:      Debugging.           (line  30)
* mode, copy-in, and 'tmc' request:      Debugging.           (line  30)
* mode, copy-in, and 'trf' request:      I/O.                 (line  50)
* mode, copy-in, and 'write' request:    I/O.                 (line 212)
* mode, copy-in, and 'writec' request:   I/O.                 (line 212)
* mode, copy-in, and 'writem' request:   I/O.                 (line 225)
* mode, copy-in, and '\!':               Diversions.          (line 148)
* mode, copy-in, and '\?':               Operators in Conditionals.
                                                              (line  55)
* mode, copy-in, and '\?' <1>:           Diversions.          (line 148)
* mode, copy-in, and '\a':               Leaders.             (line  18)
* mode, copy-in, and '\E':               Character Translations.
                                                              (line  81)
* mode, copy-in, and '\t':               Tabs and Fields.     (line  10)
* mode, copy-in, and '\V':               I/O.                 (line 249)
* mode, fill:                            Implicit Line Breaks.
                                                              (line  15)
* mode, fill <1>:                        Manipulating Filling and Adjusting.
                                                              (line 156)
* mode, fill <2>:                        Warnings.            (line  23)
* mode, fill ('fi'):                     Manipulating Filling and Adjusting.
                                                              (line  29)
* mode, fill, and '\c':                  Line Control.        (line  69)
* mode, line-tabs:                       Tabs and Fields.     (line 138)
* mode, no-fill ('nf'):                  Manipulating Filling and Adjusting.
                                                              (line  39)
* mode, no-fill, and '\c':               Line Control.        (line  60)
* mode, no-space ('ns'):                 Manipulating Spacing.
                                                              (line 123)
* mode, nroff:                           Troff and Nroff Mode.
                                                              (line   6)
* mode, safer:                           Groff Options.       (line 214)
* mode, safer <1>:                       Macro Directories.   (line  21)
* mode, safer <2>:                       Built-in Registers.  (line  23)
* mode, safer <3>:                       I/O.                 (line  32)
* mode, safer <4>:                       I/O.                 (line 147)
* mode, safer <5>:                       I/O.                 (line 168)
* mode, safer <6>:                       I/O.                 (line 206)
* mode, troff:                           Troff and Nroff Mode.
                                                              (line   6)
* mode, unsafe:                          Groff Options.       (line 292)
* mode, unsafe <1>:                      Macro Directories.   (line  21)
* mode, unsafe <2>:                      Built-in Registers.  (line  23)
* mode, unsafe <3>:                      I/O.                 (line  32)
* mode, unsafe <4>:                      I/O.                 (line 147)
* mode, unsafe <5>:                      I/O.                 (line 168)
* mode, unsafe <6>:                      I/O.                 (line 206)
* modifying requests:                    Requests.            (line  61)
* 'mom' macro package:                   mom.                 (line   6)
* month of the year register ('mo'):     Built-in Registers.  (line  51)
* motion operators:                      Expressions.         (line  65)
* motion, horizontal ('\h'):             Page Motions.        (line 103)
* motion, vertical ('\v'):               Page Motions.        (line  78)
* motions, page:                         Page Motions.        (line   6)
* mounting font ('fp'):                  Font Positions.      (line  13)
* 'ms' macros:                           ms.                  (line   6)
* 'ms' macros, accent marks:             ms Strings and Special Characters.
                                                              (line   6)
* 'ms' macros, body text:                ms Body Text.        (line   6)
* 'ms' macros, cover page:               ms Cover Page Macros.
                                                              (line   6)
* 'ms' macros, creating table of contents: ms TOC.            (line   6)
* 'ms' macros, differences from AT&T:    Differences from AT&T ms.
                                                              (line   6)
* 'ms' macros, displays:                 ms Displays and Keeps.
                                                              (line   6)
* 'ms' macros, document control registers: ms Document Control Registers.
                                                              (line   6)
* 'ms' macros, equations:                ms Insertions.       (line   6)
* 'ms' macros, figures:                  ms Insertions.       (line   6)
* 'ms' macros, footers:                  ms Headers and Footers.
                                                              (line   6)
* 'ms' macros, footnotes:                ms Footnotes.        (line   6)
* 'ms' macros, general structure:        General ms Structure.
                                                              (line   6)
* 'ms' macros, headers:                  ms Headers and Footers.
                                                              (line   6)
* 'ms' macros, headings:                 Headings in ms.      (line   6)
* 'ms' macros, highlighting:             Highlighting in ms.  (line   6)
* 'ms' macros, keeps:                    ms Displays and Keeps.
                                                              (line   6)
* 'ms' macros, lists:                    Lists in ms.         (line   6)
* 'ms' macros, margins:                  ms Margins.          (line   6)
* 'ms' macros, multiple columns:         ms Multiple Columns. (line   6)
* 'ms' macros, naming conventions:       Naming Conventions.  (line   6)
* 'ms' macros, nested lists:             Lists in ms.         (line 122)
* 'ms' macros, page layout:              ms Page Layout.      (line   6)
* 'ms' macros, paragraph handling:       Paragraphs in ms.    (line   6)
* 'ms' macros, references:               ms Insertions.       (line   6)
* 'ms' macros, special characters:       ms Strings and Special Characters.
                                                              (line   6)
* 'ms' macros, strings:                  ms Strings and Special Characters.
                                                              (line   6)
* 'ms' macros, tables:                   ms Insertions.       (line   6)
* multi-file documents:                  Debugging.           (line  10)
* multi-line strings:                    Strings.             (line  63)
* multi-page table, example markup ['ms']: Example multi-page table.
                                                              (line   6)
* multiple columns ['ms']:               ms Multiple Columns. (line   6)
* 'n' unit:                              Measurements.        (line  55)
* name space, common, of macros, diversions, and strings: Strings.
                                                              (line  92)
* name, background color, register ('.M'): Colors.            (line  94)
* name, drawing color, register ('.m'):  Colors.              (line  67)
* name, fill color, register ('.M'):     Colors.              (line  94)
* named character ('\C'):                Using Symbols.       (line 185)
* names, long:                           Implementation Differences.
                                                              (line   9)
* naming conventions, 'ms' macros:       Naming Conventions.  (line   6)
* 'ne' request, and the '.trunc' register: Page Location Traps.
                                                              (line 131)
* 'ne' request, comparison with 'sv':    Page Control.        (line  53)
* negating register values:              Setting Registers.   (line  78)
* nested assignments:                    Interpolating Registers.
                                                              (line  11)
* nested diversions:                     Diversions.          (line  69)
* nested lists ['ms']:                   Lists in ms.         (line 122)
* new page ('bp'):                       Basics.              (line  91)
* new page ('bp') <1>:                   Page Control.        (line  10)
* newline character:                     Identifiers.         (line  10)
* newline character <1>:                 Escapes.             (line  69)
* newline character, and translations:   Character Translations.
                                                              (line 169)
* newline character, in strings, escaping: Strings.           (line  63)
* newline, final, stripping in diversions: Strings.           (line 157)
* next file, processing ('nx'):          I/O.                 (line  84)
* next free font position register ('.fp'): Font Positions.   (line  30)
* 'nf' request, causing implicit linebreak: Manipulating Filling and Adjusting.
                                                              (line   6)
* 'nl' register, and '.d':               Diversions.          (line  69)
* 'nl' register, difference to '.h':     Diversions.          (line  88)
* 'nm' request, using '+' and '-':       Expressions.         (line  75)
* no-break control character ('''):      Requests.            (line   6)
* no-break control character, changing ('c2'): Character Translations.
                                                              (line   6)
* no-fill mode ('nf'):                   Manipulating Filling and Adjusting.
                                                              (line  39)
* no-fill mode, and '\c':                Line Control.        (line  60)
* no-space mode ('ns'):                  Manipulating Spacing.
                                                              (line 123)
* node, output:                          Gtroff Internals.    (line   6)
* 'nr' request, and warnings:            Warnings.            (line  61)
* 'nr' request, using '+' and '-':       Expressions.         (line  75)
* nroff mode:                            Troff and Nroff Mode.
                                                              (line   6)
* 'nroff', the program:                  History.             (line  22)
* number of arguments register ('.$'):   Parameters.          (line  10)
* number of registers register ('.R'):   Built-in Registers.  (line  18)
* number register, creating alias ('aln'): Setting Registers. (line 112)
* number register, removing ('rr'):      Setting Registers.   (line 104)
* number register, renaming ('rnn'):     Setting Registers.   (line 108)
* number registers, dumping ('pnr'):     Debugging.           (line  77)
* number, input line, setting ('lf'):    Debugging.           (line  10)
* number, page ('pn'):                   Page Layout.         (line  84)
* numbered glyph ('\N'):                 Character Translations.
                                                              (line 160)
* numbered glyph ('\N') <1>:             Using Symbols.       (line 201)
* numbered list, example markup ['ms']:  Lists in ms.         (line  41)
* numbers, and delimiters:               Escapes.             (line  65)
* numbers, line, printing ('nm'):        Miscellaneous.       (line  10)
* numerals, Roman:                       Assigning Formats.   (line  32)
* numeric expression, valid:             Expressions.         (line  83)
* offset, page ('po'):                   Line Layout.         (line  21)
* 'open' request, and safer mode:        Groff Options.       (line 214)
* 'opena' request, and safer mode:       Groff Options.       (line 214)
* opening file ('open'):                 I/O.                 (line 200)
* operator, scaling:                     Expressions.         (line  54)
* operators, arithmetic:                 Expressions.         (line   8)
* operators, as delimiters:              Escapes.             (line  67)
* operators, comparison:                 Expressions.         (line  15)
* operators, extremum ('>?', '<?'):      Expressions.         (line  44)
* operators, logical:                    Expressions.         (line  19)
* operators, motion:                     Expressions.         (line  65)
* operators, unary:                      Expressions.         (line  21)
* optical size of a font:                Changing Fonts.      (line  71)
* options:                               Groff Options.       (line   6)
* order of evaluation in expressions:    Expressions.         (line  59)
* orientation, landscape:                Paper Size.          (line   6)
* orphan lines, preventing with 'ne':    Page Control.        (line  33)
* 'os' request, and no-space mode:       Page Control.        (line  63)
* output and input requests:             I/O.                 (line   6)
* output device name string register ('.T'): Groff Options.   (line 281)
* output device name string register ('.T') <1>: Built-in Registers.
                                                              (line 127)
* output device usage number register ('.T'): Groff Options.  (line 281)
* output devices:                        Output device intro. (line   6)
* output devices <1>:                    Output Devices.      (line   6)
* output encoding, ASCII:                Groff Options.       (line 250)
* output encoding, cp1047:               Groff Options.       (line 264)
* output encoding, EBCDIC:               Groff Options.       (line 264)
* output encoding, latin-1 (ISO 8859-1): Groff Options.       (line 254)
* output encoding, utf-8:                Groff Options.       (line 259)
* output glyphs, and input characters,compatibility with AT&T 'troff': Implementation Differences.
                                                              (line  86)
* output line number register ('ln'):    Built-in Registers.  (line  82)
* output line, continuation ('\c'):      Line Control.        (line  36)
* output line, horizontal position, register ('.k'): Page Motions.
                                                              (line 212)
* output node:                           Gtroff Internals.    (line   6)
* 'output' request, and copy-in mode:    Diversions.          (line 179)
* 'output' request, and '\!':            Diversions.          (line 179)
* output, flush ('fl'):                  Debugging.           (line  87)
* output, 'gtroff':                      gtroff Output.       (line   6)
* output, intermediate:                  gtroff Output.       (line  16)
* output, suppressing ('\O'):            Suppressing output.  (line   7)
* output, transparent ('cf', 'trf'):     I/O.                 (line  50)
* output, transparent ('\!', '\?'):      Diversions.          (line 136)
* output, transparent, incompatibilities with AT&T 'troff': Implementation Differences.
                                                              (line 106)
* output, troff:                         gtroff Output.       (line  16)
* overlapping characters:                Using Symbols.       (line 265)
* overstriking glyphs ('\o'):            Page Motions.        (line 216)
* 'p' unit:                              Measurements.        (line  30)
* 'P' unit:                              Measurements.        (line  34)
* packages, macros:                      Macro Packages.      (line   6)
* padding character, for fields ('fc'):  Fields.              (line   6)
* page break, conditional ('ne'):        Page Control.        (line  33)
* page control:                          Page Control.        (line   6)
* page ejecting register ('.pe'):        Page Location Traps. (line 143)
* page footers:                          Page Location Traps. (line  38)
* page headers:                          Page Location Traps. (line  38)
* page layout:                           Page Layout.         (line   6)
* page layout ['ms']:                    ms Page Layout.      (line   6)
* page length ('pl'):                    Page Layout.         (line  13)
* page length register ('.p'):           Page Layout.         (line  17)
* page location traps:                   Page Location Traps. (line   6)
* page location, vertical, marking ('mk'): Page Motions.      (line  11)
* page location, vertical, returning to marked ('rt'): Page Motions.
                                                              (line  11)
* page motions:                          Page Motions.        (line   6)
* page number ('pn'):                    Page Layout.         (line  84)
* page number character ('%'):           Page Layout.         (line  35)
* page number character, changing ('pc'): Page Layout.        (line  94)
* page number register ('%'):            Page Control.        (line  27)
* page offset ('po'):                    Line Layout.         (line  21)
* page orientation, landscape:           Paper Size.          (line   6)
* page, new ('bp'):                      Page Control.        (line  10)
* paper formats:                         Paper Formats.       (line   6)
* paper size:                            Paper Size.          (line   6)
* paragraphs:                            Paragraphs.          (line   6)
* parameters:                            Parameters.          (line   6)
* parameters, and compatibility mode:    Gtroff Internals.    (line  91)
* parentheses:                           Expressions.         (line  59)
* path, for font files:                  Font Directories.    (line  14)
* path, for tmac files:                  Macro Directories.   (line  11)
* patterns for hyphenation ('hpf'):      Manipulating Hyphenation.
                                                              (line 116)
* PDF, embedding:                        Embedding PDF.       (line   6)
* 'pi' request, and 'groff':             I/O.                 (line 159)
* 'pi' request, and safer mode:          Groff Options.       (line 214)
* 'pic', the program:                    gpic.                (line   6)
* pica unit ('P'):                       Measurements.        (line  34)
* pile, glyph ('\b'):                    Drawing Requests.    (line 232)
* 'pl' request, using '+' and '-':       Expressions.         (line  75)
* planting a trap:                       Traps.               (line  11)
* platform-specific directory:           Macro Directories.   (line  26)
* 'pn' request, using '+' and '-':       Expressions.         (line  75)
* PNG image generation from PostScript:  DESC File Format.    (line  29)
* 'po' request, using '+' and '-':       Expressions.         (line  75)
* point size registers ('.s', '.ps'):    Changing Type Sizes. (line  20)
* point size registers, last-requested ('.psr', '.sr'): Fractional Type Sizes.
                                                              (line  45)
* point sizes, changing ('ps', '\s'):    Changing Type Sizes. (line  11)
* point sizes, fractional:               Fractional Type Sizes.
                                                              (line   6)
* point sizes, fractional <1>:           Implementation Differences.
                                                              (line  76)
* point unit ('p'):                      Measurements.        (line  30)
* polygon, drawing ('\D'p ...''):        Drawing Requests.    (line 158)
* polygon, solid, drawing ('\D'P ...''): Drawing Requests.    (line 167)
* position of lowest text line ('.h'):   Diversions.          (line  76)
* position, absolute, operator ('|'):    Expressions.         (line  70)
* position, horizontal input line, saving ('\k'): Page Motions.
                                                              (line 203)
* position, horizontal, in input line, register ('hp'): Page Motions.
                                                              (line 209)
* position, horizontal, in output line, register ('.k'): Page Motions.
                                                              (line 212)
* position, vertical, current ('nl'):    Page Control.        (line  67)
* position, vertical, in diversion, register ('.d'): Diversions.
                                                              (line  69)
* positions, font:                       Font Positions.      (line   6)
* post-vertical line spacing:            Changing Type Sizes. (line 122)
* post-vertical line spacing register ('.pvs'): Changing Type Sizes.
                                                              (line 137)
* post-vertical line spacing, changing ('pvs'): Changing Type Sizes.
                                                              (line 137)
* postprocessor access:                  Postprocessor Access.
                                                              (line   6)
* postprocessors:                        Output device intro. (line   6)
* PostScript fonts:                      Font Families.       (line  11)
* PostScript, bounding box:              Miscellaneous.       (line 139)
* PostScript, embedding:                 Embedding PostScript.
                                                              (line   6)
* PostScript, PNG image generation:      DESC File Format.    (line  29)
* 'preconv', invoking:                   Invoking preconv.    (line   5)
* 'preconv', the program:                preconv.             (line   6)
* prefix, for commands:                  Environment.         (line  14)
* preprocessor, calling convention:      Preprocessors in man pages.
                                                              (line   6)
* preprocessors:                         Preprocessor Intro.  (line   6)
* preprocessors <1>:                     Preprocessors.       (line   6)
* previous font ('ft', '\f[]', '\fP'):   Changing Fonts.      (line  23)
* previous line length ('.n'):           Environments.        (line 110)
* print current page register ('.P'):    Groff Options.       (line 171)
* printing backslash ('\\', '\e', '\E', '\[rs]'): Escapes.    (line  74)
* printing backslash ('\\', '\e', '\E', '\[rs]') <1>: Implementation Differences.
                                                              (line 106)
* printing line numbers ('nm'):          Miscellaneous.       (line  10)
* printing to stderr ('tm', 'tm1', 'tmc'): Debugging.         (line  27)
* printing, zero-width ('\z', '\Z'):     Page Motions.        (line 220)
* printing, zero-width ('\z', '\Z') <1>: Page Motions.        (line 224)
* process ID of 'gtroff' register ('$$'): Built-in Registers. (line  99)
* processing next file ('nx'):           I/O.                 (line  84)
* properties of characters ('cflags'):   Using Symbols.       (line 237)
* properties of glyphs ('cflags'):       Using Symbols.       (line 237)
* 'ps' request, and constant glyph space mode: Artificial Fonts.
                                                              (line 126)
* 'ps' request, incompatibilities with AT&T 'troff': Implementation Differences.
                                                              (line  76)
* 'ps' request, using '+' and '-':       Expressions.         (line  75)
* 'ps' request, with fractional type sizes: Fractional Type Sizes.
                                                              (line   6)
* 'pso' request, and safer mode:         Groff Options.       (line 214)
* 'pvs' request, using '+' and '-':      Expressions.         (line  75)
* quotes, major:                         Displays.            (line  10)
* quotes, trailing:                      Strings.             (line  57)
* 'radicalex' glyph, and 'cflags':       Using Symbols.       (line 265)
* ragged-left:                           Manipulating Filling and Adjusting.
                                                              (line  63)
* ragged-right:                          Manipulating Filling and Adjusting.
                                                              (line  59)
* 'rc' request, and glyph definitions:   Using Symbols.       (line 326)
* read-only register, changing format:   Assigning Formats.   (line  68)
* reading from standard input ('rd'):    I/O.                 (line  89)
* recursive macros:                      while.               (line  38)
* 'refer', and macro names starting with '[' or ']': Identifiers.
                                                              (line  46)
* 'refer', the program:                  grefer.              (line   6)
* reference, 'gtroff':                   gtroff Reference.    (line   6)
* references ['ms']:                     ms Insertions.       (line   6)
* register, creating alias ('aln'):      Setting Registers.   (line 112)
* register, format ('\g'):               Assigning Formats.   (line  75)
* register, removing ('rr'):             Setting Registers.   (line 104)
* register, renaming ('rnn'):            Setting Registers.   (line 108)
* registers:                             Registers.           (line   6)
* registers specific to 'grohtml':       grohtml specific registers and strings.
                                                              (line   6)
* registers, built-in:                   Built-in Registers.  (line   6)
* registers, interpolating ('\n'):       Interpolating Registers.
                                                              (line   6)
* registers, number of, register ('.R'): Built-in Registers.  (line  18)
* registers, setting ('nr', '\R'):       Setting Registers.   (line   6)
* removing alias, for diversion ('rm'):  Strings.             (line 263)
* removing alias, for macro ('rm'):      Strings.             (line 263)
* removing alias, for string ('rm'):     Strings.             (line 263)
* removing diversion ('rm'):             Strings.             (line 224)
* removing glyph definition ('rchar', 'rfschar'): Using Symbols.
                                                              (line 382)
* removing macro ('rm'):                 Strings.             (line 224)
* removing number register ('rr'):       Setting Registers.   (line 104)
* removing request ('rm'):               Strings.             (line 224)
* removing string ('rm'):                Strings.             (line 224)
* renaming diversion ('rn'):             Strings.             (line 221)
* renaming macro ('rn'):                 Strings.             (line 221)
* renaming number register ('rnn'):      Setting Registers.   (line 108)
* renaming request ('rn'):               Strings.             (line 221)
* renaming string ('rn'):                Strings.             (line 221)
* request arguments:                     Request and Macro Arguments.
                                                              (line   6)
* request arguments, and compatibility mode: Gtroff Internals.
                                                              (line  91)
* request, removing ('rm'):              Strings.             (line 224)
* request, renaming ('rn'):              Strings.             (line 221)
* request, undefined:                    Comments.            (line  25)
* requests:                              Requests.            (line   6)
* requests for drawing:                  Drawing Requests.    (line   6)
* requests for input and output:         I/O.                 (line   6)
* requests, modifying:                   Requests.            (line  61)
* resolution, device:                    DESC File Format.    (line  85)
* resolution, horizontal:                DESC File Format.    (line  25)
* resolution, horizontal, register ('.H'): Built-in Registers.
                                                              (line  15)
* resolution, vertical:                  DESC File Format.    (line 135)
* resolution, vertical, register ('.V'): Built-in Registers.  (line  28)
* returning to marked vertical page location ('rt'): Page Motions.
                                                              (line  11)
* revision number register ('.Y'):       Built-in Registers.  (line  96)
* 'rf', the program:                     History.             (line   6)
* right-justifying ('rj'):               Manipulating Filling and Adjusting.
                                                              (line 250)
* 'rj' request, causing implicit linebreak: Manipulating Filling and Adjusting.
                                                              (line   6)
* 'rn' glyph, and 'cflags':              Using Symbols.       (line 265)
* 'roff', the program:                   History.             (line  17)
* roman glyph, correction after italic glyph ('\/'): Ligatures and Kerning.
                                                              (line  80)
* roman glyph, correction before italic glyph ('\,'): Ligatures and Kerning.
                                                              (line  91)
* Roman numerals:                        Assigning Formats.   (line  32)
* Roman numerals, maximum and minimum:   Assigning Formats.   (line  59)
* 'rq' glyph, and 'rq' string ['man']:   Predefined man strings.
                                                              (line  22)
* 'rq' glyph, at end of sentence:        Sentences.           (line  18)
* 'rq' glyph, at end of sentence <1>:    Using Symbols.       (line 275)
* 'rt' request, using '+' and '-':       Expressions.         (line  75)
* 'ru' glyph, and 'cflags':              Using Symbols.       (line 265)
* 'RUNOFF', the program:                 History.             (line   6)
* 's' unit:                              Measurements.        (line  40)
* 's' unit <1>:                          Fractional Type Sizes.
                                                              (line   6)
* safer mode:                            Groff Options.       (line 214)
* safer mode <1>:                        Macro Directories.   (line  21)
* safer mode <2>:                        Built-in Registers.  (line  23)
* safer mode <3>:                        I/O.                 (line  32)
* safer mode <4>:                        I/O.                 (line 147)
* safer mode <5>:                        I/O.                 (line 168)
* safer mode <6>:                        I/O.                 (line 206)
* saving horizontal input line position ('\k'): Page Motions. (line 203)
* scaling indicator:                     Measurements.        (line   6)
* scaling operator:                      Expressions.         (line  54)
* searching fonts:                       Font Directories.    (line   6)
* searching macro files:                 Macro Directories.   (line  11)
* searching macros:                      Macro Directories.   (line   6)
* seconds, current time ('seconds'):     Built-in Registers.  (line  31)
* sentence space:                        Sentences.           (line  12)
* sentence space size register ('.sss'): Manipulating Filling and Adjusting.
                                                              (line 151)
* sentences:                             Sentences.           (line   6)
* setting diversion trap ('dt'):         Diversion Traps.     (line   7)
* setting end-of-input trap ('em'):      End-of-input Traps.  (line   7)
* setting input line number ('lf'):      Debugging.           (line  10)
* setting input line trap ('it'):        Input Line Traps.    (line   8)
* setting registers ('nr', '\R'):        Setting Registers.   (line   6)
* shading filled objects ('\D'f ...''):  Drawing Requests.    (line 141)
* 'shc' request, and translations:       Character Translations.
                                                              (line 173)
* site-specific directory:               Macro Directories.   (line  26)
* site-specific directory <1>:           Font Directories.    (line  29)
* size of sentence space register ('.sss'): Manipulating Filling and Adjusting.
                                                              (line 151)
* size of type:                          Sizes.               (line   6)
* size of word space register ('.ss'):   Manipulating Filling and Adjusting.
                                                              (line 151)
* size, optical, of a font:              Changing Fonts.      (line  71)
* size, paper:                           Paper Size.          (line   6)
* sizes:                                 Sizes.               (line   6)
* sizes, fractional:                     Fractional Type Sizes.
                                                              (line   6)
* sizes, fractional <1>:                 Implementation Differences.
                                                              (line  76)
* skew, of last glyph ('.csk'):          Environments.        (line  95)
* slant, font, changing ('\S'):          Artificial Fonts.    (line  45)
* 'soelim', the program:                 gsoelim.             (line   6)
* soft hyphen character, setting ('shc'): Manipulating Hyphenation.
                                                              (line 243)
* soft hyphen glyph ('hy'):              Manipulating Hyphenation.
                                                              (line 243)
* solid circle, drawing ('\D'C ...''):   Drawing Requests.    (line 114)
* solid ellipse, drawing ('\D'E ...''):  Drawing Requests.    (line 124)
* solid polygon, drawing ('\D'P ...''):  Drawing Requests.    (line 167)
* 'sp' request, and no-space mode:       Manipulating Spacing.
                                                              (line 123)
* 'sp' request, and traps:               Manipulating Spacing.
                                                              (line  53)
* 'sp' request, causing implicit linebreak: Manipulating Filling and Adjusting.
                                                              (line   6)
* space between sentences:               Sentences.           (line  12)
* space between sentences register ('.sss'): Manipulating Filling and Adjusting.
                                                              (line 151)
* space between words register ('.ss'):  Manipulating Filling and Adjusting.
                                                              (line 151)
* space character:                       Escapes.             (line  69)
* space character, zero width ('\&'):    Requests.            (line  47)
* space character, zero width ('\&') <1>: Ligatures and Kerning.
                                                              (line  47)
* space character, zero width ('\&') <2>: Drawing Requests.   (line  32)
* space characters, in expressions:      Expressions.         (line  86)
* space, discardable, horizontal:        Manipulating Filling and Adjusting.
                                                              (line 183)
* space, discarded, in traps:            Manipulating Spacing.
                                                              (line  53)
* space, horizontal ('\h'):              Page Motions.        (line 103)
* space, horizontal, unformatting:       Strings.             (line 157)
* space, unbreakable:                    Page Motions.        (line 114)
* space, vertical, unit ('v'):           Measurements.        (line  58)
* space, width of a digit ('\0'):        Page Motions.        (line 138)
* spaces with 'ds':                      Strings.             (line  57)
* spaces, in a macro argument:           Request and Macro Arguments.
                                                              (line  10)
* spaces, leading and trailing:          Filling and Adjusting.
                                                              (line  10)
* spacing:                               Basics.              (line  82)
* spacing, manipulating:                 Manipulating Spacing.
                                                              (line   6)
* spacing, vertical:                     Sizes.               (line   6)
* special characters:                    Character Translations.
                                                              (line 160)
* special characters <1>:                Special Characters.  (line   6)
* special characters ['ms']:             ms Strings and Special Characters.
                                                              (line   6)
* special fonts:                         Using Symbols.       (line  14)
* special fonts <1>:                     Special Fonts.       (line   6)
* special fonts <2>:                     Font File Format.    (line  28)
* special fonts, emboldening:            Artificial Fonts.    (line 115)
* 'special' request, and font translations: Changing Fonts.   (line  55)
* 'special' request, and glyph search order: Using Symbols.   (line  14)
* spline, drawing ('\D'~ ...''):         Drawing Requests.    (line 136)
* springing a trap:                      Traps.               (line  11)
* 'sqrtex' glyph, and 'cflags':          Using Symbols.       (line 265)
* stacking glyphs ('\b'):                Drawing Requests.    (line 232)
* standard input, reading from ('rd'):   I/O.                 (line  89)
* stderr, printing to ('tm', 'tm1', 'tmc'): Debugging.        (line  27)
* stops, tabulator:                      Tab Stops.           (line   6)
* string arguments:                      Strings.             (line  19)
* string comparison:                     Operators in Conditionals.
                                                              (line  47)
* string expansion ('\*'):               Strings.             (line  19)
* string interpolation ('\*'):           Strings.             (line  19)
* string, appending ('as'):              Strings.             (line 176)
* string, creating alias ('als'):        Strings.             (line 229)
* string, length of ('length'):          Strings.             (line 211)
* string, removing ('rm'):               Strings.             (line 224)
* string, removing alias ('rm'):         Strings.             (line 263)
* string, renaming ('rn'):               Strings.             (line 221)
* strings:                               Strings.             (line   6)
* strings specific to 'grohtml':         grohtml specific registers and strings.
                                                              (line   6)
* strings ['ms']:                        ms Strings and Special Characters.
                                                              (line   6)
* strings, multi-line:                   Strings.             (line  63)
* strings, shared name space with macros and diversions: Strings.
                                                              (line  92)
* stripping final newline in diversions: Strings.             (line 157)
* structuring source code of documents or macro packages: Requests.
                                                              (line  14)
* 'sty' request, and changing fonts:     Changing Fonts.      (line  11)
* 'sty' request, and font positions:     Font Positions.      (line  60)
* 'sty' request, and font translations:  Changing Fonts.      (line  55)
* styles, font:                          Font Families.       (line   6)
* substring ('substring'):               Strings.             (line 192)
* suppressing output ('\O'):             Suppressing output.  (line   7)
* 'sv' request, and no-space mode:       Page Control.        (line  63)
* switching environments ('ev'):         Environments.        (line  39)
* 'sy' request, and safer mode:          Groff Options.       (line 214)
* symbol:                                Using Symbols.       (line  14)
* symbol table, dumping ('pm'):          Debugging.           (line  66)
* symbol, defining ('char'):             Using Symbols.       (line 326)
* symbols, using:                        Using Symbols.       (line   6)
* 'system()' return value register ('systat'): I/O.           (line 195)
* tab character:                         Tab Stops.           (line   6)
* tab character <1>:                     Escapes.             (line  69)
* tab character, and translations:       Character Translations.
                                                              (line 169)
* tab character, non-interpreted ('\t'): Tabs and Fields.     (line  10)
* tab repetition character ('tc'):       Tabs and Fields.     (line 129)
* tab settings register ('.tabs'):       Tabs and Fields.     (line 117)
* tab stops:                             Tab Stops.           (line   6)
* tab stops ['man']:                     Miscellaneous man macros.
                                                              (line  10)
* tab stops, for TTY output devices:     Tabs and Fields.     (line 115)
* tab, line-tabs mode:                   Tabs and Fields.     (line 138)
* table of contents:                     Table of Contents.   (line   6)
* table of contents <1>:                 Leaders.             (line  29)
* table of contents, creating ['ms']:    ms TOC.              (line   6)
* tables ['ms']:                         ms Insertions.       (line   6)
* tabs, and fields:                      Tabs and Fields.     (line   6)
* tabs, and macro arguments:             Request and Macro Arguments.
                                                              (line   6)
* tabs, before comments:                 Comments.            (line  21)
* 'tbl', the program:                    gtbl.                (line   6)
* Teletype:                              Invoking grotty.     (line  50)
* terminal control sequences:            Invoking grotty.     (line  50)
* terminal, conditional output for:      Operators in Conditionals.
                                                              (line  14)
* text line, position of lowest ('.h'):  Diversions.          (line  76)
* text, 'gtroff' processing:             Text.                (line   6)
* text, justifying:                      Manipulating Filling and Adjusting.
                                                              (line   6)
* text, justifying ('rj'):               Manipulating Filling and Adjusting.
                                                              (line 250)
* thickness of lines ('\D't ...''):      Drawing Requests.    (line 206)
* three-part title ('tl'):               Page Layout.         (line  35)
* 'ti' request, causing implicit linebreak: Manipulating Filling and Adjusting.
                                                              (line   6)
* 'ti' request, using '+' and '-':       Expressions.         (line  75)
* time, current:                         I/O.                 (line 175)
* time, current, hours ('hours'):        Built-in Registers.  (line  41)
* time, current, minutes ('minutes'):    Built-in Registers.  (line  37)
* time, current, seconds ('seconds'):    Built-in Registers.  (line  31)
* title line ('tl'):                     Page Layout.         (line  35)
* title line length register ('.lt'):    Page Layout.         (line  67)
* title line, length ('lt'):             Page Layout.         (line  67)
* title page, example markup:            ms Cover Page Macros.
                                                              (line  66)
* titles:                                Page Layout.         (line  31)
* 'tkf' request, and font styles:        Font Families.       (line  59)
* 'tkf' request, and font translations:  Changing Fonts.      (line  55)
* 'tkf' request, with fractional type sizes: Fractional Type Sizes.
                                                              (line   6)
* 'tl' request, and 'mc':                Miscellaneous.       (line 102)
* 'tm' request, and copy-in mode:        Debugging.           (line  30)
* 'tm1' request, and copy-in mode:       Debugging.           (line  30)
* tmac, directory:                       Macro Directories.   (line  11)
* tmac, path:                            Macro Directories.   (line  11)
* 'tmc' request, and copy-in mode:       Debugging.           (line  30)
* TMPDIR, environment variable:          Environment.         (line  44)
* token, input:                          Gtroff Internals.    (line   6)
* top margin:                            Page Layout.         (line  20)
* top-level diversion:                   Diversions.          (line  12)
* top-level diversion, and 'bp':         Page Control.        (line  24)
* top-level diversion, and '\!':         Diversions.          (line 171)
* top-level diversion, and '\?':         Diversions.          (line 176)
* 'tr' request, and glyph definitions:   Using Symbols.       (line 326)
* 'tr' request, and soft hyphen character: Manipulating Hyphenation.
                                                              (line 243)
* 'tr' request, incompatibilities with AT&T 'troff': Implementation Differences.
                                                              (line  86)
* track kerning:                         Ligatures and Kerning.
                                                              (line  53)
* track kerning, activating ('tkf'):     Ligatures and Kerning.
                                                              (line  60)
* trailing quotes:                       Strings.             (line  57)
* trailing spaces:                       Filling and Adjusting.
                                                              (line  10)
* translations of characters:            Character Translations.
                                                              (line   6)
* transparent characters:                Sentences.           (line  18)
* transparent characters <1>:            Using Symbols.       (line 275)
* transparent output ('cf', 'trf'):      I/O.                 (line  50)
* transparent output ('\!', '\?'):       Diversions.          (line 136)
* transparent output, incompatibilities with AT&T 'troff': Implementation Differences.
                                                              (line 106)
* trap, changing location ('ch'):        Page Location Traps. (line 111)
* trap, distance, register ('.t'):       Page Location Traps. (line 102)
* trap, diversion, setting ('dt'):       Diversion Traps.     (line   7)
* trap, end-of-input, setting ('em'):    End-of-input Traps.  (line   7)
* trap, input line, setting ('it'):      Input Line Traps.    (line   8)
* trap, planting:                        Traps.               (line  11)
* trap, springing:                       Traps.               (line  11)
* traps:                                 Traps.               (line   6)
* traps, and discarded space:            Manipulating Spacing.
                                                              (line  53)
* traps, and diversions:                 Page Location Traps. (line 166)
* traps, blank line:                     Blank Line Traps.    (line   6)
* traps, diversion:                      Diversion Traps.     (line   6)
* traps, dumping ('ptr'):                Debugging.           (line  81)
* traps, end-of-input:                   End-of-input Traps.  (line   6)
* traps, input line:                     Input Line Traps.    (line   6)
* traps, input line, and interrupted lines ('itc'): Input Line Traps.
                                                              (line  24)
* traps, leading spaces:                 Leading Spaces Traps.
                                                              (line   6)
* traps, page location:                  Page Location Traps. (line   6)
* traps, sprung by 'bp' request ('.pe'): Page Location Traps. (line 143)
* 'trf' request, and copy-in mode:       I/O.                 (line  50)
* 'trf' request, and invalid characters: I/O.                 (line  73)
* 'trf' request, causing implicit linebreak: Manipulating Filling and Adjusting.
                                                              (line   6)
* 'trin' request, and 'asciify':         Diversions.          (line 195)
* troff mode:                            Troff and Nroff Mode.
                                                              (line   6)
* troff output:                          gtroff Output.       (line  16)
* truncated vertical space register ('.trunc'): Page Location Traps.
                                                              (line 131)
* TTY, conditional output for:           Operators in Conditionals.
                                                              (line  14)
* tutorial for macro users:              Tutorial for Macro Users.
                                                              (line   6)
* type size:                             Sizes.               (line   6)
* type size registers ('.s', '.ps'):     Changing Type Sizes. (line  20)
* type sizes, changing ('ps', '\s'):     Changing Type Sizes. (line  11)
* type sizes, fractional:                Fractional Type Sizes.
                                                              (line   6)
* type sizes, fractional <1>:            Implementation Differences.
                                                              (line  76)
* 'u' unit:                              Measurements.        (line   6)
* 'uf' request, and font styles:         Font Families.       (line  59)
* 'ul' glyph, and 'cflags':              Using Symbols.       (line 265)
* 'ul' request, and font translations:   Changing Fonts.      (line  55)
* Ultrix-specific 'man' macros:          Optional man extensions.
                                                              (line  30)
* unary operators:                       Expressions.         (line  21)
* unbreakable space:                     Page Motions.        (line 114)
* undefined identifiers:                 Identifiers.         (line  79)
* undefined request:                     Comments.            (line  25)
* underline font ('uf'):                 Artificial Fonts.    (line  90)
* underlining ('ul'):                    Artificial Fonts.    (line  64)
* underlining, continuous ('cu'):        Artificial Fonts.    (line  86)
* underscore glyph ('\[ru]'):            Drawing Requests.    (line  28)
* unformatting diversions ('asciify'):   Diversions.          (line 195)
* unformatting horizontal space:         Strings.             (line 157)
* Unicode:                               Identifiers.         (line  15)
* Unicode <1>:                           Using Symbols.       (line 201)
* unit, 'c':                             Measurements.        (line  27)
* unit, 'f':                             Measurements.        (line  43)
* unit, 'f', and colors:                 Colors.              (line  36)
* unit, 'i':                             Measurements.        (line  22)
* unit, 'm':                             Measurements.        (line  50)
* unit, 'M':                             Measurements.        (line  62)
* unit, 'n':                             Measurements.        (line  55)
* unit, 'p':                             Measurements.        (line  30)
* unit, 'P':                             Measurements.        (line  34)
* unit, 's':                             Measurements.        (line  40)
* unit, 's' <1>:                         Fractional Type Sizes.
                                                              (line   6)
* unit, 'u':                             Measurements.        (line   6)
* unit, 'v':                             Measurements.        (line  58)
* unit, 'z':                             Measurements.        (line  40)
* unit, 'z' <1>:                         Fractional Type Sizes.
                                                              (line   6)
* units of measurement:                  Measurements.        (line   6)
* units, default:                        Default Units.       (line   6)
* unnamed fill colors ('\D'F...''):      Drawing Requests.    (line 216)
* unnamed glyphs:                        Using Symbols.       (line 212)
* unnamed glyphs, accessing with '\N':   Font File Format.    (line  51)
* unsafe mode:                           Groff Options.       (line 292)
* unsafe mode <1>:                       Macro Directories.   (line  21)
* unsafe mode <2>:                       Built-in Registers.  (line  23)
* unsafe mode <3>:                       I/O.                 (line  32)
* unsafe mode <4>:                       I/O.                 (line 147)
* unsafe mode <5>:                       I/O.                 (line 168)
* unsafe mode <6>:                       I/O.                 (line 206)
* user's macro tutorial:                 Tutorial for Macro Users.
                                                              (line   6)
* user's tutorial for macros:            Tutorial for Macro Users.
                                                              (line   6)
* using symbols:                         Using Symbols.       (line   6)
* utf-8, output encoding:                Groff Options.       (line 259)
* 'v' unit:                              Measurements.        (line  58)
* valid numeric expression:              Expressions.         (line  83)
* value, incrementing without changing the register: Auto-increment.
                                                              (line  52)
* variables in environment:              Environment.         (line   6)
* version number, major, register ('.x'): Built-in Registers. (line  88)
* version number, minor, register ('.y'): Built-in Registers. (line  92)
* vertical line drawing ('\L'):          Drawing Requests.    (line  50)
* vertical line spacing register ('.v'): Changing Type Sizes. (line  88)
* vertical line spacing, changing ('vs'): Changing Type Sizes.
                                                              (line  88)
* vertical line spacing, effective value: Changing Type Sizes.
                                                              (line 106)
* vertical motion ('\v'):                Page Motions.        (line  78)
* vertical page location, marking ('mk'): Page Motions.       (line  11)
* vertical page location, returning to marked ('rt'): Page Motions.
                                                              (line  11)
* vertical position in diversion register ('.d'): Diversions. (line  69)
* vertical position trap enable register ('.vpt'): Page Location Traps.
                                                              (line  18)
* vertical position traps, enabling ('vpt'): Page Location Traps.
                                                              (line  18)
* vertical position, current ('nl'):     Page Control.        (line  67)
* vertical resolution:                   DESC File Format.    (line 135)
* vertical resolution register ('.V'):   Built-in Registers.  (line  28)
* vertical space unit ('v'):             Measurements.        (line  58)
* vertical spacing:                      Sizes.               (line   6)
* warnings:                              Debugging.           (line 149)
* warnings <1>:                          Warnings.            (line   6)
* warnings, level ('warn'):              Debugging.           (line 155)
* what is 'groff'?:                      What Is groff?.      (line   6)
* while:                                 while.               (line   6)
* 'while' request, and font translations: Changing Fonts.     (line  55)
* 'while' request, and the '!' operator: Expressions.         (line  21)
* 'while' request, confusing with 'br':  while.               (line  68)
* 'while' request, operators to use with: Operators in Conditionals.
                                                              (line   6)
* whitespace characters:                 Identifiers.         (line  10)
* width escape ('\w'):                   Page Motions.        (line 152)
* width, of last glyph ('.w'):           Environments.        (line  95)
* word space size register ('.ss'):      Manipulating Filling and Adjusting.
                                                              (line 151)
* 'write' request, and copy-in mode:     I/O.                 (line 212)
* 'writec' request, and copy-in mode:    I/O.                 (line 212)
* 'writem' request, and copy-in mode:    I/O.                 (line 225)
* writing macros:                        Writing Macros.      (line   6)
* writing to file ('write', 'writec'):   I/O.                 (line 212)
* year, current, register ('year', 'yr'): Built-in Registers. (line  54)
* 'z' unit:                              Measurements.        (line  40)
* 'z' unit <1>:                          Fractional Type Sizes.
                                                              (line   6)
* zero width space character ('\&'):     Requests.            (line  47)
* zero width space character ('\&') <1>: Ligatures and Kerning.
                                                              (line  47)
* zero width space character ('\&') <2>: Drawing Requests.    (line  32)
* zero-width printing ('\z', '\Z'):      Page Motions.        (line 220)
* zero-width printing ('\z', '\Z') <1>:  Page Motions.        (line 224)
* zoom factor of a font ('fzoom'):       Changing Fonts.      (line  71)

