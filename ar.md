File: binutils.info,  Node: ar,  Next: nm,  Prev: Top,  Up: Top

1 ar
****

     ar [-]P[MOD] [`--plugin' NAME] [`--target' BFDNAME] [RELPOS] [COUNT] ARCHIVE [MEMBER...]
     ar -M [ <mri-script ]

   The GNU `ar' program creates, modifies, and extracts from archives.
An "archive" is a single file holding a collection of other files in a
structure that makes it possible to retrieve the original individual
files (called "members" of the archive).

   The original files' contents, mode (permissions), timestamp, owner,
and group are preserved in the archive, and can be restored on
extraction.

   GNU `ar' can maintain archives whose members have names of any
length; however, depending on how `ar' is configured on your system, a
limit on member-name length may be imposed for compatibility with
archive formats maintained with other tools.  If it exists, the limit
is often 15 characters (typical of formats related to a.out) or 16
characters (typical of formats related to coff).

   `ar' is considered a binary utility because archives of this sort
are most often used as "libraries" holding commonly needed subroutines.

   `ar' creates an index to the symbols defined in relocatable object
modules in the archive when you specify the modifier `s'.  Once
created, this index is updated in the archive whenever `ar' makes a
change to its contents (save for the `q' update operation).  An archive
with such an index speeds up linking to the library, and allows
routines in the library to call each other without regard to their
placement in the archive.

   You may use `nm -s' or `nm --print-armap' to list this index table.
If an archive lacks the table, another form of `ar' called `ranlib' can
be used to add just the table.

   GNU `ar' can optionally create a _thin_ archive, which contains a
symbol index and references to the original copies of the member files
of the archive.  This is useful for building libraries for use within a
local build tree, where the relocatable objects are expected to remain
available, and copying the contents of each object would only waste
time and space.

   An archive can either be _thin_ or it can be normal.  It cannot be
both at the same time.  Once an archive is created its format cannot be
changed without first deleting it and then creating a new archive in
its place.

   Thin archives are also _flattened_, so that adding one thin archive
to another thin archive does not nest it, as would happen with a normal
archive.  Instead the elements of the first archive are added
individually to the second archive.

   The paths to the elements of the archive are stored relative to the
archive itself.

   GNU `ar' is designed to be compatible with two different facilities.
You can control its activity using command-line options, like the
different varieties of `ar' on Unix systems; or, if you specify the
single command-line option `-M', you can control it with a script
supplied via standard input, like the MRI "librarian" program.

* Menu:

* ar cmdline::                  Controlling `ar' on the command line
* ar scripts::                  Controlling `ar' with a script

File: binutils.info,  Node: ar cmdline,  Next: ar scripts,  Up: ar

1.1 Controlling `ar' on the Command Line
========================================

     ar [`-X32_64'] [`-']P[MOD] [`--plugin' NAME] [`--target' BFDNAME] [RELPOS] [COUNT] ARCHIVE [MEMBER...]

   When you use `ar' in the Unix style, `ar' insists on at least two
arguments to execute: one keyletter specifying the _operation_
(optionally accompanied by other keyletters specifying _modifiers_),
and the archive name to act on.

   Most operations can also accept further MEMBER arguments, specifying
particular files to operate on.

   GNU `ar' allows you to mix the operation code P and modifier flags
MOD in any order, within the first command-line argument.

   If you wish, you may begin the first command-line argument with a
dash.

   The P keyletter specifies what operation to execute; it may be any
of the following, but you must specify only one of them:

`d'
     _Delete_ modules from the archive.  Specify the names of modules to
     be deleted as MEMBER...; the archive is untouched if you specify
     no files to delete.

     If you specify the `v' modifier, `ar' lists each module as it is
     deleted.

`m'
     Use this operation to _move_ members in an archive.

     The ordering of members in an archive can make a difference in how
     programs are linked using the library, if a symbol is defined in
     more than one member.

     If no modifiers are used with `m', any members you name in the
     MEMBER arguments are moved to the _end_ of the archive; you can
     use the `a', `b', or `i' modifiers to move them to a specified
     place instead.

`p'
     _Print_ the specified members of the archive, to the standard
     output file.  If the `v' modifier is specified, show the member
     name before copying its contents to standard output.

     If you specify no MEMBER arguments, all the files in the archive
     are printed.

`q'
     _Quick append_; Historically, add the files MEMBER... to the end of
     ARCHIVE, without checking for replacement.

     The modifiers `a', `b', and `i' do _not_ affect this operation;
     new members are always placed at the end of the archive.

     The modifier `v' makes `ar' list each file as it is appended.

     Since the point of this operation is speed, implementations of
     `ar' have the option of not updating the archive's symbol table if
     one exists.  Too many different systems however assume that symbol
     tables are always up-to-date, so GNU `ar' will rebuild the table
     even with a quick append.

     Note - GNU `ar' treats the command `qs' as a synonym for `r' -
     replacing already existing files in the archive and appending new
     ones at the end.

`r'
     Insert the files MEMBER... into ARCHIVE (with _replacement_). This
     operation differs from `q' in that any previously existing members
     are deleted if their names match those being added.

     If one of the files named in MEMBER... does not exist, `ar'
     displays an error message, and leaves undisturbed any existing
     members of the archive matching that name.

     By default, new members are added at the end of the file; but you
     may use one of the modifiers `a', `b', or `i' to request placement
     relative to some existing member.

     The modifier `v' used with this operation elicits a line of output
     for each file inserted, along with one of the letters `a' or `r'
     to indicate whether the file was appended (no old member deleted)
     or replaced.

`s'
     Add an index to the archive, or update it if it already exists.
     Note this command is an exception to the rule that there can only
     be one command letter, as it is possible to use it as either a
     command or a modifier.  In either case it does the same thing.

`t'
     Display a _table_ listing the contents of ARCHIVE, or those of the
     files listed in MEMBER... that are present in the archive.
     Normally only the member name is shown; if you also want to see
     the modes (permissions), timestamp, owner, group, and size, you can
     request that by also specifying the `v' modifier.

     If you do not specify a MEMBER, all files in the archive are
     listed.

     If there is more than one file with the same name (say, `fie') in
     an archive (say `b.a'), `ar t b.a fie' lists only the first
     instance; to see them all, you must ask for a complete listing--in
     our example, `ar t b.a'.

`x'
     _Extract_ members (named MEMBER) from the archive.  You can use
     the `v' modifier with this operation, to request that `ar' list
     each name as it extracts it.

     If you do not specify a MEMBER, all files in the archive are
     extracted.

     Files cannot be extracted from a thin archive.

`--help'
     Displays the list of command line options supported by `ar' and
     then exits.

`--version'
     Displays the version information of `ar' and then exits.


   A number of modifiers (MOD) may immediately follow the P keyletter,
to specify variations on an operation's behavior:

`a'
     Add new files _after_ an existing member of the archive.  If you
     use the modifier `a', the name of an existing archive member must
     be present as the RELPOS argument, before the ARCHIVE
     specification.

`b'
     Add new files _before_ an existing member of the archive.  If you
     use the modifier `b', the name of an existing archive member must
     be present as the RELPOS argument, before the ARCHIVE
     specification.  (same as `i').

`c'
     _Create_ the archive.  The specified ARCHIVE is always created if
     it did not exist, when you request an update.  But a warning is
     issued unless you specify in advance that you expect to create it,
     by using this modifier.

`D'
     Operate in _deterministic_ mode.  When adding files and the archive
     index use zero for UIDs, GIDs, timestamps, and use consistent file
     modes for all files.  When this option is used, if `ar' is used
     with identical options and identical input files, multiple runs
     will create identical output files regardless of the input files'
     owners, groups, file modes, or modification times.

     If `binutils' was configured with
     `--enable-deterministic-archives', then this mode is on by default.
     It can be disabled with the `U' modifier, below.

`f'
     Truncate names in the archive.  GNU `ar' will normally permit file
     names of any length.  This will cause it to create archives which
     are not compatible with the native `ar' program on some systems.
     If this is a concern, the `f' modifier may be used to truncate file
     names when putting them in the archive.

`i'
     Insert new files _before_ an existing member of the archive.  If
     you use the modifier `i', the name of an existing archive member
     must be present as the RELPOS argument, before the ARCHIVE
     specification.  (same as `b').

`l'
     This modifier is accepted but not used.

`N'
     Uses the COUNT parameter.  This is used if there are multiple
     entries in the archive with the same name.  Extract or delete
     instance COUNT of the given name from the archive.

`o'
     Preserve the _original_ dates of members when extracting them.  If
     you do not specify this modifier, files extracted from the archive
     are stamped with the time of extraction.

`P'
     Use the full path name when matching names in the archive.  GNU
     `ar' can not create an archive with a full path name (such archives
     are not POSIX complaint), but other archive creators can.  This
     option will cause GNU `ar' to match file names using a complete
     path name, which can be convenient when extracting a single file
     from an archive created by another tool.

`s'
     Write an object-file index into the archive, or update an existing
     one, even if no other change is made to the archive.  You may use
     this modifier flag either with any operation, or alone.  Running
     `ar s' on an archive is equivalent to running `ranlib' on it.

`S'
     Do not generate an archive symbol table.  This can speed up
     building a large library in several steps.  The resulting archive
     can not be used with the linker.  In order to build a symbol
     table, you must omit the `S' modifier on the last execution of
     `ar', or you must run `ranlib' on the archive.

`T'
     Make the specified ARCHIVE a _thin_ archive.  If it already exists
     and is a regular archive, the existing members must be present in
     the same directory as ARCHIVE.

`u'
     Normally, `ar r'... inserts all files listed into the archive.  If
     you would like to insert _only_ those of the files you list that
     are newer than existing members of the same names, use this
     modifier.  The `u' modifier is allowed only for the operation `r'
     (replace).  In particular, the combination `qu' is not allowed,
     since checking the timestamps would lose any speed advantage from
     the operation `q'.

`U'
     Do _not_ operate in _deterministic_ mode.  This is the inverse of
     the `D' modifier, above: added files and the archive index will
     get their actual UID, GID, timestamp, and file mode values.

     This is the default unless `binutils' was configured with
     `--enable-deterministic-archives'.

`v'
     This modifier requests the _verbose_ version of an operation.  Many
     operations display additional information, such as filenames
     processed, when the modifier `v' is appended.

`V'
     This modifier shows the version number of `ar'.

   `ar' ignores an initial option spelt `-X32_64', for compatibility
with AIX.  The behaviour produced by this option is the default for GNU
`ar'.  `ar' does not support any of the other `-X' options; in
particular, it does not support `-X32' which is the default for AIX
`ar'.

   The optional command line switch `--plugin' NAME causes `ar' to load
the plugin called NAME which adds support for more file formats.  This
option is only available if the toolchain has been built with plugin
support enabled.

   The optional command line switch `--target' BFDNAME specifies that
the archive members are in an object code format different from your
system's default format.  See *Note Target Selection::, for more
information.

File: binutils.info,  Node: ar scripts,  Prev: ar cmdline,  Up: ar

1.2 Controlling `ar' with a Script
==================================

     ar -M [ <SCRIPT ]

   If you use the single command-line option `-M' with `ar', you can
control its operation with a rudimentary command language.  This form
of `ar' operates interactively if standard input is coming directly
from a terminal.  During interactive use, `ar' prompts for input (the
prompt is `AR >'), and continues executing even after errors.  If you
redirect standard input to a script file, no prompts are issued, and
`ar' abandons execution (with a nonzero exit code) on any error.

   The `ar' command language is _not_ designed to be equivalent to the
command-line options; in fact, it provides somewhat less control over
archives.  The only purpose of the command language is to ease the
transition to GNU `ar' for developers who already have scripts written
for the MRI "librarian" program.

   The syntax for the `ar' command language is straightforward:
   * commands are recognized in upper or lower case; for example, `LIST'
     is the same as `list'.  In the following descriptions, commands are
     shown in upper case for clarity.

   * a single command may appear on each line; it is the first word on
     the line.

   * empty lines are allowed, and have no effect.

   * comments are allowed; text after either of the characters `*' or
     `;' is ignored.

   * Whenever you use a list of names as part of the argument to an `ar'
     command, you can separate the individual names with either commas
     or blanks.  Commas are shown in the explanations below, for
     clarity.

   * `+' is used as a line continuation character; if `+' appears at
     the end of a line, the text on the following line is considered
     part of the current command.

   Here are the commands you can use in `ar' scripts, or when using
`ar' interactively.  Three of them have special significance:

   `OPEN' or `CREATE' specify a "current archive", which is a temporary
file required for most of the other commands.

   `SAVE' commits the changes so far specified by the script.  Prior to
`SAVE', commands affect only the temporary copy of the current archive.

`ADDLIB ARCHIVE'
`ADDLIB ARCHIVE (MODULE, MODULE, ... MODULE)'
     Add all the contents of ARCHIVE (or, if specified, each named
     MODULE from ARCHIVE) to the current archive.

     Requires prior use of `OPEN' or `CREATE'.

`ADDMOD MEMBER, MEMBER, ... MEMBER'
     Add each named MEMBER as a module in the current archive.

     Requires prior use of `OPEN' or `CREATE'.

`CLEAR'
     Discard the contents of the current archive, canceling the effect
     of any operations since the last `SAVE'.  May be executed (with no
     effect) even if  no current archive is specified.

`CREATE ARCHIVE'
     Creates an archive, and makes it the current archive (required for
     many other commands).  The new archive is created with a temporary
     name; it is not actually saved as ARCHIVE until you use `SAVE'.
     You can overwrite existing archives; similarly, the contents of any
     existing file named ARCHIVE will not be destroyed until `SAVE'.

`DELETE MODULE, MODULE, ... MODULE'
     Delete each listed MODULE from the current archive; equivalent to
     `ar -d ARCHIVE MODULE ... MODULE'.

     Requires prior use of `OPEN' or `CREATE'.

`DIRECTORY ARCHIVE (MODULE, ... MODULE)'
`DIRECTORY ARCHIVE (MODULE, ... MODULE) OUTPUTFILE'
     List each named MODULE present in ARCHIVE.  The separate command
     `VERBOSE' specifies the form of the output: when verbose output is
     off, output is like that of `ar -t ARCHIVE MODULE...'.  When
     verbose output is on, the listing is like `ar -tv ARCHIVE
     MODULE...'.

     Output normally goes to the standard output stream; however, if you
     specify OUTPUTFILE as a final argument, `ar' directs the output to
     that file.

`END'
     Exit from `ar', with a `0' exit code to indicate successful
     completion.  This command does not save the output file; if you
     have changed the current archive since the last `SAVE' command,
     those changes are lost.

`EXTRACT MODULE, MODULE, ... MODULE'
     Extract each named MODULE from the current archive, writing them
     into the current directory as separate files.  Equivalent to `ar -x
     ARCHIVE MODULE...'.

     Requires prior use of `OPEN' or `CREATE'.

`LIST'
     Display full contents of the current archive, in "verbose" style
     regardless of the state of `VERBOSE'.  The effect is like `ar tv
     ARCHIVE'.  (This single command is a GNU `ar' enhancement, rather
     than present for MRI compatibility.)

     Requires prior use of `OPEN' or `CREATE'.

`OPEN ARCHIVE'
     Opens an existing archive for use as the current archive (required
     for many other commands).  Any changes as the result of subsequent
     commands will not actually affect ARCHIVE until you next use
     `SAVE'.

`REPLACE MODULE, MODULE, ... MODULE'
     In the current archive, replace each existing MODULE (named in the
     `REPLACE' arguments) from files in the current working directory.
     To execute this command without errors, both the file, and the
     module in the current archive, must exist.

     Requires prior use of `OPEN' or `CREATE'.

`VERBOSE'
     Toggle an internal flag governing the output from `DIRECTORY'.
     When the flag is on, `DIRECTORY' output matches output from `ar
     -tv '....

`SAVE'
     Commit your changes to the current archive, and actually save it
     as a file with the name specified in the last `CREATE' or `OPEN'
     command.

     Requires prior use of `OPEN' or `CREATE'.


