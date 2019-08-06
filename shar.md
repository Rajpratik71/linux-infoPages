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


