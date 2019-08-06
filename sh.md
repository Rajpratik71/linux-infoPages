File: sharutils.info,  Node: Top,  Next: Introduction,  Prev: (dir),  Up: (dir)

GNU `shar' utilities
********************

This manual documents version 4.11.1 of the GNU shar utilities.

   Copyright (C) 1994, 1995, 1996, 1997, 1998, 1999, 2000, 2001, 2002,
2003, 2004, 2005, 2006, 2008, 2009, 2010 Free Software Foundation, Inc.

     Permission is granted to copy, distribute and/or modify this
     document under the terms of the GNU Free Documentation License,
     Version 1.3 or any later version published by the Free Software
     Foundation; with no Invariant Sections, with no Front-Cover Texts,
     and with no Back-Cover Texts.  A copy of the license is included
     in the section entitled "GNU Free Documentation License".

   GNU `shar' makes so-called shell archives out of many files,
preparing them for transmission by electronic mail services, while
`unshar' helps unpacking shell archives after reception.  Other tools
help using `shar' with the electronic mail system, and even allow
synchronization of remote directory trees.  This is release 4.11.1.

   This manual documents version 4.11.1 of the GNU shar utilities.

   Copyright (C) 1994, 1995, 1996, 1997, 1998, 1999, 2000, 2001, 2002,
2003, 2004, 2005, 2006, 2008, 2009, 2010 Free Software Foundation, Inc.

     Permission is granted to copy, distribute and/or modify this
     document under the terms of the GNU Free Documentation License,
     Version 1.3 or any later version published by the Free Software
     Foundation; with no Invariant Sections, with no Front-Cover Texts,
     and with no Back-Cover Texts.  A copy of the license is included
     in the section entitled "GNU Free Documentation License".

* Menu:

* Introduction::                Introduction to this toolset
* Basic::                       The basic `shar' utilities
* GNU Free Documentation License:: GNU Free Documentation License

 --- The Detailed Node Listing ---

The basic `shar' utilities

* shar invocation::             Invoking the `shar' program
* unshar invocation::           Invoking the `unshar' program
* uuencode::                    Invoking the `uuencode' program
* uudecode::                    Invoking the `uudecode' program
* Miscellaneous::               Miscellaneous considerations

Invoking the `shar' program

* Selecting::                   Selecting files
* Splitting::                   Splitting output
* Headers::                     Controlling the shar headers
* Stocking::                    Selecting how files are stocked
* Transmission::                Protecting against transmission
* Kinds::                       Producing different kinds of shar

File: sharutils.info,  Node: Introduction,  Next: Basic,  Prev: Top,  Up: Top

1 Introduction to this toolset
******************************

GNU `uuencode' and `uudecode' have an history which roots are lost in
ages, and we will not even try to trace it.  The current versions were
brought into GNU by Ian Lance Taylor, and later modernized by Ulrich
Drepper.  GNU `shar' surely has a long history, too.  All along this
long road, numerous users contributed various improvements.  The file
`THANKS' in the distribution, as far as we know, contain the names of
all contributors we could identify, and for which email addresses are
seemingly valid.

   Please help us getting the history straight, for the following
information is somewhat approximative.  James Gosling wrote the public
domain `shar 1.x'.  William Davidsen rewrote it as `shar 2.x'.  Warren
Tucker implemented modifications and called it `shar 3.x'.  Richard
Gumpertz maintained it until 1990.  Franc,ois Pinard, from the public
domain `shar 3.49', made `GNU shar 4.x', in 1994.  Some modules and
other code sections were freely borrowed from other GNU distributions,
bringing this `shar' under the terms of the GNU General Public License.

   The few wrapper scripts have been contributed more recently by
Franc,ois Pinard, just as an attempt for making this GNU `sharutils'
toolset more useful.

   Your feedback helps us to make a better and more portable product.
Mail suggestions and bug reports (including documentation errors) for
these programs to `bug-gnu-utils@prep.ai.mit.edu'.

File: sharutils.info,  Node: Basic,  Prev: Introduction,  Up: Top

2 The basic `shar' utilities
****************************

GNU `shar' makes so-called shell archives out of many files, preparing
them for transmission by electronic mail services.  A "shell archive"
is a collection of files that can be unpacked by `/bin/sh'.  A wide
range of features provide extensive flexibility in manufacturing shars
and in specifying shar _smartness_.  For example, `shar' may compress
files, uuencode binary files, split long files and construct multi-part
mailings, ensure correct unsharing order, and provide simplistic
checksums.  *Note shar invocation::.

   GNU `unshar' scans a set of mail messages looking for the start of
shell archives.  It will automatically strip off the mail headers and
other introductory text.  The archive bodies are then unpacked by a
copy of the shell.  `unshar' may also process files containing
concatenated shell archives.  *Note unshar invocation::.

* Menu:

* shar invocation::             Invoking the `shar' program
* unshar invocation::           Invoking the `unshar' program
* uuencode::                    Invoking the `uuencode' program
* uudecode::                    Invoking the `uudecode' program
* Miscellaneous::               Miscellaneous considerations

File: sharutils.info,  Node: shar invocation,  Next: unshar invocation,  Prev: Basic,  Up: Basic

2.1 Invoking the `shar' program
===============================

The format of the `shar' command is one of:

     shar [ OPTION ] ... FILE ...
     shar -S [ OPTION ] ...

   In the first form, the file list is given as command arguments.  In
the second form, the file list is read from standard input.  The
resulting archive is sent to standard output unless the `-o' option is
given.

   Options can be given in any order.  Some options depend on each
other: the `-o' option is required if the `-l' or `-L' option is used.
The `-n' option is required if the `-a' option is used.  Also see `-V'
below.

   Some options are special purpose:

`--help'
     Print a help summary on standard output, then immediately exit.

`--version'
     Print the version number of the program on standard output, then
     immediately exit.

`-q'
`--quiet'
     Verbose _off_ at `shar' time.  Messages are usually issued on
     standard error to let the user follow the progress, while making
     the archives.  This option inhibits these messages.


* Menu:

* Selecting::                   Selecting files
* Splitting::                   Splitting output
* Headers::                     Controlling the shar headers
* Stocking::                    Selecting how files are stocked
* Transmission::                Protecting against transmission
* Kinds::                       Producing different kinds of shar

File: sharutils.info,  Node: Selecting,  Next: Splitting,  Prev: shar invocation,  Up: shar invocation

2.1.1 Selecting files
---------------------

`-p'
`--intermix-type'
     Allow positional parameter options.  The options `-M', `-B', `-T',
     `-z' and `-Z' may be embedded, and files to the right of the
     option will be processed in the specified mode.  Without the `-p'
     option, embedded options would be interpreted as file names.
     *Note Stocking::.

`-S'
`--stdin-file-list'
     Read list of files to be packed from the standard input rather
     than from the command line.  Input must be one file name per line.
     This switch is especially useful when the command line will not
     hold the list of files to be packed.  For example:

          find . -type f -print | \
            shar -S -o /somewhere/big.shar

     If `-p' is specified on the command line, then the options `-M',
     `-B', `-T', `-z' and `-Z' may be included in the standard input
     (on a line separate from file names).  The maximum number of lines
     of standard input, file names and options, may not exceed 1024.


File: sharutils.info,  Node: Splitting,  Next: Headers,  Prev: Selecting,  Up: shar invocation

2.1.2 Splitting output
----------------------

`-o PREFIX'
`--output-prefix=PREFIX'
     Save the archive to files `PREFIX.01' through `PREFIX.NNN' instead
     of standard output.  This option _must_ be used when the `-l' or
     the `-L' switches are used.

     When PREFIX contains any `%' character, PREFIX is then interpreted
     as a `sprintf' format, which should be able to display a single
     decimal number.  When PREFIX does not contain such a `%'
     character, the string `.%02d' is internally appended.

`-l SIZE'
`--whole-size-limit=SIZE'
     Limit the output file size to SIZE times 1024 bytes but don't
     split input files.  This allows the recipient of the shell archives
     to unpack them in any order.

`-L SIZE'
`--split-size-limit=SIZE'
     Limit output file size to SIZE times 1024 bytes and split files if
     necessary.  The archives created with this option must be unpacked
     in the correct order.  If the recipient of the shell archives
     wants to put all of them in a single folder, she shall save them
     in the correct order for `unshar', used with option `-e', to
     unpack them all at once.  *Note unshar invocation::.

     For people used to saving all the shell archives into a single mail
     folder, care must be taken to save them in the appropriate order.
     For those having the appropriate tools (like Masanobu Umeda's
     `rmailsort' package for GNU Emacs), shell archives can be saved in
     any order, then sorted by increasing date (or send time) before
     massive unpacking.


File: sharutils.info,  Node: Headers,  Next: Stocking,  Prev: Splitting,  Up: shar invocation

2.1.3 Controlling the shar headers
----------------------------------

`-n NAME'
`--archive-name=NAME'
     Name of archive to be included in the header of the shar files.
     Also see the `-a' switch further down.

`-s ADDRESS'
`--submitter=ADDRESS'
     The `-s' option allows for overriding the email address for the
     submitter, for when the default is not appropriate.  The
     automatically determined address looks like `USERNAME@HOSTNAME'.

`-a'
`--net-headers'
     Allows automatic generation of headers:

          Submitted-by: ADDRESS
          Archive-name: NAME/partNN

     The NAME must be given with the `-n' switch.  If name includes a
     `/', then `/part' isn't used. Thus `-n xyzzy' produces:
          xyzzy/part01
          xyzzy/part02

     while `-n xyzzy/patch' produces:
          xyzzy/patch01
          xyzzy/patch02

     and `-n xyzzy/patch01.' produces:
          xyzzy/patch01.01
          xyzzy/patch01.02

`-c'
`--cut-mark'
     Start the shar with a cut line.  A line saying `Cut here' is
     placed at the start of each output file.

`-t'
`--translate'
     Translate messages in the script.  If you have set the `LANG'
     environment variable, messages printed by `shar' will be in the
     specified language.  The produced script will still be emitted
     using messages in the lingua franca of the computer world:
     English.  This option will cause the script messages to appear in
     the languages specified by the `LANG' environment variable set
     when the script is produced.


File: sharutils.info,  Node: Stocking,  Next: Transmission,  Prev: Headers,  Up: shar invocation

2.1.4 Selecting how files are stocked
-------------------------------------

`-T'
`--text-files'
     Treat all files as text, regardless of their contents.

`-B'
`--uuencode'
     Treat all files as binary, use `uuencode' prior to packing. This
     increases the size of the archive. The recipient must have
     `uudecode' in order to unpack.

          Use of `uuencode' is not appreciated by many on the net, because
          people like to readily see, by mere inspection of a shell archive,
          what it is about.

`-M'
`--mixed-uuencode'
     Mixed mode.  Automatically determine if the files are text or
     binary and archive correctly.  Files found to be binary are
     uuencoded prior to packing.  This option is selected by default.

     For a file is considered to be a text file, instead of a binary
     file, all the following should be true simultaneously:
       1. The file does not contain any ASCII control character besides
          <BS> (backspace), <HT> (horizontal tab), <LF> (new line) or
          <FF> (form feed).

       2. The file does not contains a <DEL> (delete).

       3. The file contains no character with its eighth-bit set.

       4. The file, unless totally empty, terminates with a <LF>
          (newline).

       5. No line in the file contains more than 200 characters.  For
          counting purpose, lines are separated by a <LF> (newline).

`-z'
`--gzip'
     Use `gzip' and `uuencode' on all files prior to packing.  The
     recipient must have `uudecode' and `gzip' (used with `-d') in
     order to unpack.

     Usage of `-z' in net shars will cause you to be flamed off the
     earth.

`-g LEVEL'
`--level-for-gzip=LEVEL'
     When doing compression, use `-LEVEL' as a parameter to `gzip'.
     The `-g' option turns on the `-z' option by default.  The default
     value is 9, that is, maximum compression.

`-j'
`--bzip2'
     Use `bzip2' and `uuencode' on all files prior to packing.  The
     recipient must have `uudecode' and `bzip2' (used with `-d') in
     order to unpack.

     Usage of `-j' in net shars will cause you to be flamed off to hell.

`-Z'
`--compress'
     Use `compress' and `uuencode' on all files prior to packing.  The
     recipient must have `uudecode' and `compress' (used with `-d') in
     order to unpack.  Option `-C' is a synonymous for `-Z', but is
     deprecated.

     Usage of `-Z' in net shars will cause you to be flamed off the
     earth.

`-b BITS'
`--bits-per-code=BITS'
     When doing compression, use `-bX' as a parameter to `compress'.
     The `-b' option turns on the `-Z' option by default.  The default
     value is 12, foreseeing the memory limitations of some `compress'
     programs on smallish systems, at `unshar' time.


File: sharutils.info,  Node: Transmission,  Next: Kinds,  Prev: Stocking,  Up: shar invocation

2.1.5 Protecting against transmission errors
--------------------------------------------

Transmission of shell archives is not always free of errors.  So one
should make consistency checks on the receiving site.  A very simple
(and unreliable) method is running the UNIX `wc' tool on the output
file.  This can report the number of characters in the file.

   As one can guess this does not catch all errors.  Especially
changing of a character value does not change the computed check sum.
To achieve this goal better method were invented and standardized.  One
very strong is MD5 (MD = message digests).  This is standardized in RFC
1321.  The produced shell scripts do not force the `md5sum' program to
be installed on the system.  This is necessary because it is not yet
part of every UNIX.  The program is however not necessary for producing
the shell archive.

`-w'
`--no-character-count'
     Do _not_ check with `wc -c' after unpack.  The default is to check.

`-D'
`--no-md5-digest'
     Do _not_ check with `md5sum' after unpack.  The default is to
     check.

`-F'
`--force-prefix'
     Prepend the prefix character to every line even if not required.
     This option may slightly increase the size of the archive,
     especially if `-B' or `-Z' is used.  Normally, the prefix character
     is `X'.  If the parameter to the `-d' option starts with `X', then
     the prefix character becomes `Y'.

`-d STRING'
`--here-delimiter=STRING'
     Use STRING to delimit the files in the shar instead of `SHAR_EOF'.
     This is for those who want to personalize their shar files.


File: sharutils.info,  Node: Kinds,  Prev: Transmission,  Up: shar invocation

2.1.6 Producing different kinds of shars
----------------------------------------

`-V'
`--vanilla-operation'
     This option produces "vanilla" shars which rely only upon the
     existence of `echo', `test' and `sed' in the unpacking environment.

     The `-V' disables options offensive to the "network cop" (or
     "brown shirt").  It also changes the default from mixed mode `-M'
     to text mode `-T'.  Warnings are produced if option `-B', `-z',
     `-j', `-Z', `-p' or `-M' is specified (any of which does or might
     require `uudecode', `gzip', `bzip2' or `compress' in the unpacking
     environment).

`-P'
`--no-piping'
     In the shar file, use a temporary file to hold the file to
     `uudecode', instead of using pipes.  This option is mandatory when
     you know the unpacking `uudecode' is unwilling to merely read its
     standard input.  Richard Marks wrote what is certainly the most
     (in)famous of these, for MSDOS :-).

     (Here is a side note from the maintainer.  Why isnt't this option
     the default?  In the past history of `shar', it was decided that
     piping was better, surely because it is less demanding on disk
     space, and people seem to be happy with this.  Besides, I think
     that the `uudecode' from Richard Marks, on MSDOS, is wrong in
     refusing to handle `stdin'.  So far that I remember, he has the
     strong opinion that a program without any parameters should give
     its `--help' output.  Besides that, should I say, his `uuencode'
     and `uudecode' programs are full-featured, one of the most
     complete set I ever saw.  But Richard will not release his
     sources, he wants to stay in control.)

`-x'
`--no-check-existing'
     Overwrite existing files without checking.  If neither `-x' nor
     `-X' is specified, when unpacking itself, the shell archive will
     check for and not overwrite existing files (unless `-c' is passed
     as a parameter to the script when unpacking).

`-X'
`--query-user'
     Interactively overwrite existing files.

     Use of `-X' produces shars which _will_ cause problems with some
     `unshar'-style procedures, particularily when used together with
     vanilla mode (`-V').  Use this feature mainly for archives to be
     passed among agreeable parties.  Certainly, `-X' is _not_ for
     shell archives which are to be submitted to Usenet or other public
     networks.

     The problem is that `unshar' programs or procedures often feed
     `/bin/sh' from its standard input, thus putting `/bin/sh' and the
     shell archive script in competition for input lines.  As an
     attempt to alleviate this problem, `shar' will try to detect if
     `/dev/tty' exists at the receiving site and will use it to read
     user replies.  But this does not work in all cases, it may happen
     that the receiving user will have to avoid using `unshar' programs
     or procedures, and call `/bin/sh' directly.  In vanilla mode,
     using `/dev/tty' is not even attempted.

`-m'
`--no-timestamp'
     Avoid generating `touch' commands to restore the file modification
     dates when unpacking files from the archive.

     When the timestamp relationship is not preserved, some files like
     `configure' or `*.info' may be uselessly remade after unpacking.
     This is why, when this option is not used, a special effort is
     made to restore timestamps,

`-Q'
`--quiet-unshar'
     Verbose _off_ at `unshar' time.  Disables the inclusion of
     comments to be output when the archive is unpacked.

`-f'
`--basename'
     Use only the last file name component of each input file name,
     ignoring any prefix directories.  This is sometimes useful when
     building a shar from several directories, or another directory.
     If a directory name is passed to `shar', the substructure of that
     directory will be restored whether `-f' is specified or not.


File: sharutils.info,  Node: unshar invocation,  Next: uuencode,  Prev: shar invocation,  Up: Basic

2.2 Invoking the `unshar' program
=================================

The format of the `unshar' command is:

     unshar [ OPTION ] ... [ FILE ... ]

   Each FILE is processed in turn, as a shell archive or a collection
of shell archives.  If no files are given, then standard input is
processed instead.

   Options:

`--version'
     Print the version number of the program on standard output, then
     immediately exit.

`--help'
     Print an help summary on standard output, then immediately exit.

`-d DIRECTORY'
`--directory=DIRECTORY'
     Change directory to DIRECTORY before unpacking any files.

`-c'
`--overwrite'

`-f'
`--force'
     Passed as an option to the shar file.  Many shell archive scripts
     (including those produced by `shar' 3.40 and newer) accepts a `-c'
     argument to indicate that existing files should be overwritten.

     The option `-f' is provided for a more unique interface.  Many
     programs (such as `cp' and `mv') use this option to trigger the
     very same action.

`-e'
`--exit-0'
     This option exists mainly for people who collect many shell
     archives into a single mail folder.  With this option, `unshar'
     isolates each different shell archive from the others which have
     been put in the same file, unpacking each in turn, from the
     beginning of the file towards its end.  Its proper operation
     relies on the fact that many shar files are terminated by a
     `exit 0' at the beginning of a line.

     Option `-e' is internally equivalent to `-E "exit 0"'.

`-E STRING'
`--split-at=STRING'
     This option works like `-e', but it allows you to specify the
     string that separates archives if `exit 0' isn't appropriate.

     For example, noticing that most `.signatures' have a `--' on a
     line right before them, one can sometimes use `--split-at=--' for
     splitting shell archives which lack the `exit 0' line at end.  The
     signature will then be skipped altogether with the headers of the
     following message.


File: sharutils.info,  Node: uuencode,  Next: uudecode,  Prev: unshar invocation,  Up: Basic

2.3 Invoking the `uuencode' program
===================================

This program converts a binary file into printable ASCII characters.
This is done a byte at a time, using six bits from each byte.

     uuencode [<option>] [<infile>] <remote-file-name>

   Options:

`-m'
`--base64'
     use base64 encoding, per RFC1521

`--help'
     Print an help summary on standard output, then immediately exit.

`--version'
     Print the version number of the program on standard output, then
     immediately exit.


File: sharutils.info,  Node: uudecode,  Next: Miscellaneous,  Prev: uuencode,  Up: Basic

2.4 Invoking the `uudecode' program
===================================

This program converts a printable ASCII character encoding of a file
back into the original binary data.

     uudecode [<option>] [<infile> ...]

   Options:

`-o'
`--output-file'
     Specify an output file.  This may only be used if there is only
     one input file, either standard in or command line specified.

`--help'
     Print an help summary on standard output, then immediately exit.

`--version'
     Print the version number of the program on standard output, then
     immediately exit.


File: sharutils.info,  Node: Miscellaneous,  Next: GNU Free Documentation License,  Prev: uudecode,  Up: Basic

2.5 Miscellaneous considerations
================================

Here is a place-holder for many considerations which do not fit
elsewhere, while not worth a section for themselves.

   Be careful that the output file(s) are not included in the inputs or
`shar' may loop until the disk fills up.  Be particularly careful when
a directory is passed to `shar' that the output files are not in that
directory (or a subdirectory of that directory).

   When a directory is passed to `shar', it may be scanned more than
once, to conserve memory.  Therefore, one should be careful to not
change the directory contents while `shar' is running.

   No attempt is made to restore the protection and modification dates
for directories, even if this is done by default for files.  Thus, if a
directory is given to `shar', the protection and modification dates of
corresponding unpacked directory may not match those of the original.

   Use of the `-M' or `-B' options will slow down the archive process.
Use of the `-z' or `-Z' options may slow the archive process
considerably.

   Let us conclude by a showing a few examples of `shar' usage:

     shar *.c > cprog.shar
     shar -Q *.[ch] > cprog.shar
     shar -B -l28 -oarc.sh. *.arc
     shar -f /lcl/src/u*.c > u.sh

The first shows how to make a shell archive out of all C program
sources.  The second produces a shell archive with all `.c' and `.h'
files, which unpacks silently.  The third gives a shell archive of all
uuencoded `.arc' files, into files `arc.sh.01' through to `arc.sh.NNN'.
The last example gives a shell archive which will use only the file
names at unpack time.

     TODO:
     - interrogates the user if missing receiving directory in `ident'.
     - allow `remote.sum' to be empty or non-existent.

File: sharutils.info,  Node: GNU Free Documentation License,  Prev: Miscellaneous,  Up: Top

Appendix A GNU Free Documentation License
*****************************************

                     Version 1.3, 3 November 2008

     Copyright (C) 2000, 2001, 2002, 2007, 2008 Free Software Foundation, Inc.
     `http://fsf.org/'

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
     of subject matter or whether it is published as a printed book.
     We recommend this License principally for works whose purpose is
     instruction or reference.

  1. APPLICABILITY AND DEFINITIONS

     This License applies to any manual or other work, in any medium,
     that contains a notice placed by the copyright holder saying it
     can be distributed under the terms of this License.  Such a notice
     grants a world-wide, royalty-free license, unlimited in duration,
     to use that work under the conditions stated herein.  The
     "Document", below, refers to any such manual or work.  Any member
     of the public is a licensee, and is addressed as "you".  You
     accept the license if you copy, modify or distribute the work in a
     way requiring permission under copyright law.

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
     titles are designated, as being those of Invariant Sections, in
     the notice that says that the Document is released under this
     License.  If a section does not fit the above definition of
     Secondary then it is not allowed to be designated as Invariant.
     The Document may contain zero Invariant Sections.  If the Document
     does not identify any Invariant Sections then there are none.

     The "Cover Texts" are certain short passages of text that are
     listed, as Front-Cover Texts or Back-Cover Texts, in the notice
     that says that the Document is released under this License.  A
     Front-Cover Text may be at most 5 words, and a Back-Cover Text may
     be at most 25 words.

     A "Transparent" copy of the Document means a machine-readable copy,
     represented in a format whose specification is available to the
     general public, that is suitable for revising the document
     straightforwardly with generic text editors or (for images
     composed of pixels) generic paint programs or (for drawings) some
     widely available drawing editor, and that is suitable for input to
     text formatters or for automatic translation to a variety of
     formats suitable for input to text formatters.  A copy made in an
     otherwise Transparent file format whose markup, or absence of
     markup, has been arranged to thwart or discourage subsequent
     modification by readers is not Transparent.  An image format is
     not Transparent if used for any substantial amount of text.  A
     copy that is not "Transparent" is called "Opaque".

     Examples of suitable formats for Transparent copies include plain
     ASCII without markup, Texinfo input format, LaTeX input format,
     SGML or XML using a publicly available DTD, and
     standard-conforming simple HTML, PostScript or PDF designed for
     human modification.  Examples of transparent image formats include
     PNG, XCF and JPG.  Opaque formats include proprietary formats that
     can be read and edited only by proprietary word processors, SGML or
     XML for which the DTD and/or processing tools are not generally
     available, and the machine-generated HTML, PostScript or PDF
     produced by some word processors for output purposes only.

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
     distribute a large enough number of copies you must also follow
     the conditions in section 3.

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
     front cover must present the full title with all words of the
     title equally prominent and visible.  You may add other material
     on the covers in addition.  Copying with changes limited to the
     covers, as long as they preserve the title of the Document and
     satisfy these conditions, can be treated as verbatim copying in
     other respects.

     If the required texts for either cover are too voluminous to fit
     legibly, you should put the first ones listed (as many as fit
     reasonably) on the actual cover, and continue the rest onto
     adjacent pages.

     If you publish or distribute Opaque copies of the Document
     numbering more than 100, you must either include a
     machine-readable Transparent copy along with each Opaque copy, or
     state in or with each Opaque copy a computer-network location from
     which the general network-using public has access to download
     using public-standard network protocols a complete Transparent
     copy of the Document, free of added material.  If you use the
     latter option, you must take reasonably prudent steps, when you
     begin distribution of Opaque copies in quantity, to ensure that
     this Transparent copy will remain thus accessible at the stated
     location until at least one year after the last time you
     distribute an Opaque copy (directly or through your agents or
     retailers) of that edition to the public.

     It is requested, but not required, that you contact the authors of
     the Document well before redistributing any large number of
     copies, to give them a chance to provide you with an updated
     version of the Document.

  4. MODIFICATIONS

     You may copy and distribute a Modified Version of the Document
     under the conditions of sections 2 and 3 above, provided that you
     release the Modified Version under precisely this License, with
     the Modified Version filling the role of the Document, thus
     licensing distribution and modification of the Modified Version to
     whoever possesses a copy of it.  In addition, you must do these
     things in the Modified Version:

       A. Use in the Title Page (and on the covers, if any) a title
          distinct from that of the Document, and from those of
          previous versions (which should, if there were any, be listed
          in the History section of the Document).  You may use the
          same title as a previous version if the original publisher of
          that version gives permission.

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
          authors, and publisher of the Modified Version as given on
          the Title Page.  If there is no section Entitled "History" in
          the Document, create one stating the title, year, authors,
          and publisher of the Document as given on its Title Page,
          then add an item describing the Modified Version as stated in
          the previous sentence.

       J. Preserve the network location, if any, given in the Document
          for public access to a Transparent copy of the Document, and
          likewise the network locations given in the Document for
          previous versions it was based on.  These may be placed in
          the "History" section.  You may omit a network location for a
          work that was published at least four years before the
          Document itself, or if the original publisher of the version
          it refers to gives permission.

       K. For any section Entitled "Acknowledgements" or "Dedications",
          Preserve the Title of the section, and preserve in the
          section all the substance and tone of each of the contributor
          acknowledgements and/or dedications given therein.

       L. Preserve all the Invariant Sections of the Document,
          unaltered in their text and in their titles.  Section numbers
          or the equivalent are not considered part of the section
          titles.

       M. Delete any section Entitled "Endorsements".  Such a section
          may not be included in the Modified Version.

       N. Do not retitle any existing section to be Entitled
          "Endorsements" or to conflict in title with any Invariant
          Section.

       O. Preserve any Warranty Disclaimers.

     If the Modified Version includes new front-matter sections or
     appendices that qualify as Secondary Sections and contain no
     material copied from the Document, you may at your option
     designate some or all of these sections as invariant.  To do this,
     add their titles to the list of Invariant Sections in the Modified
     Version's license notice.  These titles must be distinct from any
     other section titles.

     You may add a section Entitled "Endorsements", provided it contains
     nothing but endorsements of your Modified Version by various
     parties--for example, statements of peer review or that the text
     has been approved by an organization as the authoritative
     definition of a standard.

     You may add a passage of up to five words as a Front-Cover Text,
     and a passage of up to 25 words as a Back-Cover Text, to the end
     of the list of Cover Texts in the Modified Version.  Only one
     passage of Front-Cover Text and one of Back-Cover Text may be
     added by (or through arrangements made by) any one entity.  If the
     Document already includes a cover text for the same cover,
     previously added by you or by arrangement made by the same entity
     you are acting on behalf of, you may not add another; but you may
     replace the old one, on explicit permission from the previous
     publisher that added the old one.

     The author(s) and publisher(s) of the Document do not by this
     License give permission to use their names for publicity for or to
     assert or imply endorsement of any Modified Version.

  5. COMBINING DOCUMENTS

     You may combine the Document with other documents released under
     this License, under the terms defined in section 4 above for
     modified versions, provided that you include in the combination
     all of the Invariant Sections of all of the original documents,
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
     rules of this License for verbatim copying of each of the
     documents in all other respects.

     You may extract a single document from such a collection, and
     distribute it individually under this License, provided you insert
     a copy of this License into the extracted document, and follow
     this License in all other respects regarding verbatim copying of
     that document.

  7. AGGREGATION WITH INDEPENDENT WORKS

     A compilation of the Document or its derivatives with other
     separate and independent documents or works, in or on a volume of
     a storage or distribution medium, is called an "aggregate" if the
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
     provisionally, unless and until the copyright holder explicitly
     and finally terminates your license, and (b) permanently, if the
     copyright holder fails to notify you of the violation by some
     reasonable means prior to 60 days after the cessation.

     Moreover, your license from a particular copyright holder is
     reinstated permanently if the copyright holder notifies you of the
     violation by some reasonable means, this is the first time you have
     received notice of violation of this License (for any work) from
     that copyright holder, and you cure the violation prior to 30 days
     after your receipt of the notice.

     Termination of your rights under this section does not terminate
     the licenses of parties who have received copies or rights from
     you under this License.  If your rights have been terminated and
     not permanently reinstated, receipt of a copy of some or all of
     the same material does not give you any rights to use it.

 10. FUTURE REVISIONS OF THIS LICENSE

     The Free Software Foundation may publish new, revised versions of
     the GNU Free Documentation License from time to time.  Such new
     versions will be similar in spirit to the present version, but may
     differ in detail to address new problems or concerns.  See
     `http://www.gnu.org/copyleft/'.

     Each version of the License is given a distinguishing version
     number.  If the Document specifies that a particular numbered
     version of this License "or any later version" applies to it, you
     have the option of following the terms and conditions either of
     that specified version or of any later version that has been
     published (not as a draft) by the Free Software Foundation.  If
     the Document does not specify a version number of this License,
     you may choose any version ever published (not as a draft) by the
     Free Software Foundation.  If the Document specifies that a proxy
     can decide which future versions of this License can be used, that
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
recommend releasing these examples in parallel under your choice of
free software license, such as the GNU General Public License, to
permit their use in free software.


