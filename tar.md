File: tar.info,  Node: tar invocation,  Next: operations,  Prev: Tutorial,  Up: Top

3 Invoking GNU `tar'
********************

This chapter is about how one invokes the GNU `tar' command, from the
command synopsis (*note Synopsis::).  There are numerous options, and
many styles for writing them.  One mandatory option specifies the
operation `tar' should perform (*note Operation Summary::), other
options are meant to detail how this operation should be performed
(*note Option Summary::).  Non-option arguments are not always
interpreted the same way, depending on what the operation is.

   You will find in this chapter everything about option styles and
rules for writing them (*note Styles::).  On the other hand, operations
and options are fully described elsewhere, in other chapters.  Here,
you will find only synthetic descriptions for operations and options,
together with pointers to other parts of the `tar' manual.

   Some options are so special they are fully described right in this
chapter.  They have the effect of inhibiting the normal operation of
`tar' or else, they globally alter the amount of feedback the user
receives about what is going on.  These are the `--help' and
`--version' (*note help::), `--verbose' (*note verbose::) and
`--interactive' options (*note interactive::).

* Menu:

* Synopsis::
* using tar options::
* Styles::
* All Options::           All `tar' Options.
* help::                  Where to Get Help.
* defaults::              What are the Default Values.
* verbose::               Checking `tar' progress.
* checkpoints::           Checkpoints.
* warnings::              Controlling Warning Messages.
* interactive::           Asking for Confirmation During Operations.
* external::              Running External Commands.

File: tar.info,  Node: Synopsis,  Next: using tar options,  Up: tar invocation

3.1 General Synopsis of `tar'
=============================

The GNU `tar' program is invoked as either one of:

     tar OPTION... [NAME]...
     tar LETTER... [ARGUMENT]... [OPTION]... [NAME]...

   The second form is for when old options are being used.

   You can use `tar' to store files in an archive, to extract them from
an archive, and to do other types of archive manipulation.  The primary
argument to `tar', which is called the "operation", specifies which
action to take.  The other arguments to `tar' are either "options",
which change the way `tar' performs an operation, or file names or
archive members, which specify the files or members `tar' is to act on.

   You can actually type in arguments in any order, even if in this
manual the options always precede the other arguments, to make examples
easier to understand.  Further, the option stating the main operation
mode (the `tar' main command) is usually given first.

   Each NAME in the synopsis above is interpreted as an archive member
name when the main command is one of `--compare' (`--diff', `-d'),
`--delete', `--extract' (`--get', `-x'), `--list' (`-t') or `--update'
(`-u').  When naming archive members, you must give the exact name of
the member in the archive, as it is printed by `--list'.  For
`--append' (`-r') and `--create' (`-c'), these NAME arguments specify
the names of either files or directory hierarchies to place in the
archive.  These files or hierarchies should already exist in the file
system, prior to the execution of the `tar' command.

   `tar' interprets relative file names as being relative to the
working directory.  `tar' will make all file names relative (by
removing leading slashes when archiving or restoring files), unless you
specify otherwise (using the `--absolute-names' option).  *Note
absolute::, for more information about `--absolute-names'.

   If you give the name of a directory as either a file name or a member
name, then `tar' acts recursively on all the files and directories
beneath that directory.  For example, the name `/' identifies all the
files in the file system to `tar'.

   The distinction between file names and archive member names is
especially important when shell globbing is used, and sometimes a
source of confusion for newcomers.  *Note wildcards::, for more
information about globbing.  The problem is that shells may only glob
using existing files in the file system.  Only `tar' itself may glob on
archive members, so when needed, you must ensure that wildcard
characters reach `tar' without being interpreted by the shell first.
Using a backslash before `*' or `?', or putting the whole argument
between quotes, is usually sufficient for this.

   Even if NAMEs are often specified on the command line, they can also
be read from a text file in the file system, using the
`--files-from=FILE-OF-NAMES' (`-T FILE-OF-NAMES') option.

   If you don't use any file name arguments, `--append' (`-r'),
`--delete' and `--concatenate' (`--catenate', `-A') will do nothing,
while `--create' (`-c') will usually yield a diagnostic and inhibit
`tar' execution.  The other operations of `tar' (`--list', `--extract',
`--compare', and `--update') will act on the entire contents of the
archive.

   Besides successful exits, GNU `tar' may fail for many reasons.  Some
reasons correspond to bad usage, that is, when the `tar' command line
is improperly written.  Errors may be encountered later, while
processing the archive or the files.  Some errors are recoverable, in
which case the failure is delayed until `tar' has completed all its
work.  Some errors are such that it would be not meaningful, or at
least risky, to continue processing: `tar' then aborts processing
immediately.  All abnormal exits, whether immediate or delayed, should
always be clearly diagnosed on `stderr', after a line stating the
nature of the error.

   Possible exit codes of GNU `tar' are summarized in the following
table:

0
     `Successful termination'.

1
     `Some files differ'.  If tar was invoked with `--compare'
     (`--diff', `-d') command line option, this means that some files
     in the archive differ from their disk counterparts (*note
     compare::).  If tar was given `--create', `--append' or `--update'
     option, this exit code means that some files were changed while
     being archived and so the resulting archive does not contain the
     exact copy of the file set.

2
     `Fatal error'.  This means that some fatal, unrecoverable error
     occurred.

   If `tar' has invoked a subprocess and that subprocess exited with a
nonzero exit code, `tar' exits with that code as well.  This can
happen, for example, if `tar' was given some compression option (*note
gzip::) and the external compressor program failed.  Another example is
`rmt' failure during backup to the remote device (*note Remote Tape
Server::).

File: tar.info,  Node: using tar options,  Next: Styles,  Prev: Synopsis,  Up: tar invocation

3.2 Using `tar' Options
=======================

GNU `tar' has a total of eight operating modes which allow you to
perform a variety of tasks.  You are required to choose one operating
mode each time you employ the `tar' program by specifying one, and only
one operation as an argument to the `tar' command (the corresponding
options may be found at *note frequent operations:: and *note
Operations::).  Depending on circumstances, you may also wish to
customize how the chosen operating mode behaves.  For example, you may
wish to change the way the output looks, or the format of the files
that you wish to archive may require you to do something special in
order to make the archive look right.

   You can customize and control `tar''s performance by running `tar'
with one or more options (such as `--verbose' (`-v'), which we used in
the tutorial).  As we said in the tutorial, "options" are arguments to
`tar' which are (as their name suggests) optional. Depending on the
operating mode, you may specify one or more options. Different options
will have different effects, but in general they all change details of
the operation, such as archive format, archive name, or level of user
interaction.  Some options make sense with all operating modes, while
others are meaningful only with particular modes. You will likely use
some options frequently, while you will only use others infrequently, or
not at all.  (A full list of options is available in *note All
Options::.)

   The `TAR_OPTIONS' environment variable specifies default options to
be placed in front of any explicit options.  For example, if
`TAR_OPTIONS' is `-v --unlink-first', `tar' behaves as if the two
options `-v' and `--unlink-first' had been specified before any
explicit options.  Option specifications are separated by whitespace.
A backslash escapes the next character, so it can be used to specify an
option containing whitespace or a backslash.

   Note that `tar' options are case sensitive.  For example, the
options `-T' and `-t' are different; the first requires an argument for
stating the name of a file providing a list of NAMEs, while the second
does not require an argument and is another way to write `--list'
(`-t').

   In addition to the eight operations, there are many options to
`tar', and three different styles for writing both: long (mnemonic)
form, short form, and old style.  These styles are discussed below.
Both the options and the operations can be written in any of these three
styles.

File: tar.info,  Node: Styles,  Next: All Options,  Prev: using tar options,  Up: tar invocation

3.3 The Three Option Styles
===========================

There are three styles for writing operations and options to the command
line invoking `tar'.  The different styles were developed at different
times during the history of `tar'.  These styles will be presented
below, from the most recent to the oldest.

   Some options must take an argument(1).  Where you _place_ the
arguments generally depends on which style of options you choose.  We
will detail specific information relevant to each option style in the
sections on the different option styles, below.  The differences are
subtle, yet can often be very important; incorrect option placement can
cause you to overwrite a number of important files.  We urge you to
note these differences, and only use the option style(s) which makes
the most sense to you until you feel comfortable with the others.

   Some options _may_ take an argument.  Such options may have at most
long and short forms, they do not have old style equivalent.  The rules
for specifying an argument for such options are stricter than those for
specifying mandatory arguments.  Please, pay special attention to them.

* Menu:

* Long Options::                Long Option Style
* Short Options::               Short Option Style
* Old Options::                 Old Option Style
* Mixing::                      Mixing Option Styles

   ---------- Footnotes ----------

   (1) For example, `--file' (`-f') takes the name of an archive file
as an argument.  If you do not supply an archive file name, `tar' will
use a default, but this can be confusing; thus, we recommend that you
always supply a specific archive file name.

File: tar.info,  Node: Long Options,  Next: Short Options,  Up: Styles

3.3.1 Long Option Style
-----------------------

Each option has at least one "long" (or "mnemonic") name starting with
two dashes in a row, e.g., `--list'.  The long names are more clear than
their corresponding short or old names.  It sometimes happens that a
single long option has many different names which are synonymous, such
as `--compare' and `--diff'.  In addition, long option names can be
given unique abbreviations.  For example, `--cre' can be used in place
of `--create' because there is no other long option which begins with
`cre'.  (One way to find this out is by trying it and seeing what
happens; if a particular abbreviation could represent more than one
option, `tar' will tell you that that abbreviation is ambiguous and
you'll know that that abbreviation won't work.  You may also choose to
run `tar --help' to see a list of options.  Be aware that if you run
`tar' with a unique abbreviation for the long name of an option you
didn't want to use, you are stuck; `tar' will perform the command as
ordered.)

   Long options are meant to be obvious and easy to remember, and their
meanings are generally easier to discern than those of their
corresponding short options (see below).  For example:

     $ tar --create --verbose --blocking-factor=20 --file=/dev/rmt0

gives a fairly good set of hints about what the command does, even for
those not fully acquainted with `tar'.

   Long options which require arguments take those arguments
immediately following the option name.  There are two ways of
specifying a mandatory argument.  It can be separated from the option
name either by an equal sign, or by any amount of white space
characters.  For example, the `--file' option (which tells the name of
the `tar' archive) is given a file such as `archive.tar' as argument by
using any of the following notations: `--file=archive.tar' or `--file
archive.tar'.

   In contrast, optional arguments must always be introduced using an
equal sign.  For example, the `--backup' option takes an optional
argument specifying backup type.  It must be used as
`--backup=BACKUP-TYPE'.

File: tar.info,  Node: Short Options,  Next: Old Options,  Prev: Long Options,  Up: Styles

3.3.2 Short Option Style
------------------------

Most options also have a "short option" name.  Short options start with
a single dash, and are followed by a single character, e.g., `-t'
(which is equivalent to `--list').  The forms are absolutely identical
in function; they are interchangeable.

   The short option names are faster to type than long option names.

   Short options which require arguments take their arguments
immediately following the option, usually separated by white space.  It
is also possible to stick the argument right after the short option
name, using no intervening space.  For example, you might write
`-f archive.tar' or `-farchive.tar' instead of using
`--file=archive.tar'.  Both `--file=ARCHIVE-NAME' and `-f ARCHIVE-NAME'
denote the option which indicates a specific archive, here named
`archive.tar'.

   Short options which take optional arguments take their arguments
immediately following the option letter, _without any intervening white
space characters_.

   Short options' letters may be clumped together, but you are not
required to do this (as compared to old options; see below).  When
short options are clumped as a set, use one (single) dash for them all,
e.g., ``tar' -cvf'.  Only the last option in such a set is allowed to
have an argument(1).

   When the options are separated, the argument for each option which
requires an argument directly follows that option, as is usual for Unix
programs.  For example:

     $ tar -c -v -b 20 -f /dev/rmt0

   If you reorder short options' locations, be sure to move any
arguments that belong to them.  If you do not move the arguments
properly, you may end up overwriting files.

   ---------- Footnotes ----------

   (1) Clustering many options, the last of which has an argument, is a
rather opaque way to write options.  Some wonder if GNU `getopt' should
not even be made helpful enough for considering such usages as invalid.

File: tar.info,  Node: Old Options,  Next: Mixing,  Prev: Short Options,  Up: Styles

3.3.3 Old Option Style
----------------------

As far as we know, all `tar' programs, GNU and non-GNU, support "old
options": that is, if the first argument does not start with `-', it is
assumed to specify option letters.  GNU `tar' supports old options not
only for historical reasons, but also because many people are used to
them.  If the first argument does not start with a dash, you are
announcing the old option style instead of the short option style; old
options are decoded differently.

   Like short options, old options are single letters.  However, old
options must be written together as a single clumped set, without
spaces separating them or dashes preceding them.  This set of letters
must be the first to appear on the command line, after the `tar'
program name and some white space; old options cannot appear anywhere
else.  The letter of an old option is exactly the same letter as the
corresponding short option.  For example, the old option `t' is the
same as the short option `-t', and consequently, the same as the long
option `--list'.  So for example, the command `tar cv' specifies the
option `-v' in addition to the operation `-c'.

   When options that need arguments are given together with the command,
all the associated arguments follow, in the same order as the options.
Thus, the example given previously could also be written in the old
style as follows:

     $ tar cvbf 20 /dev/rmt0

Here, `20' is the argument of `-b' and `/dev/rmt0' is the argument of
`-f'.

   The old style syntax can make it difficult to match option letters
with their corresponding arguments, and is often confusing.  In the
command `tar cvbf 20 /dev/rmt0', for example, `20' is the argument for
`-b', `/dev/rmt0' is the argument for `-f', and `-v' does not have a
corresponding argument.  Even using short options like in
`tar -c -v -b 20 -f /dev/rmt0' is clearer, putting all arguments next
to the option they pertain to.

   If you want to reorder the letters in the old option argument, be
sure to reorder any corresponding argument appropriately.

   This old way of writing `tar' options can surprise even experienced
users.  For example, the two commands:

     tar cfz archive.tar.gz file
     tar -cfz archive.tar.gz file

are quite different.  The first example uses `archive.tar.gz' as the
value for option `f' and recognizes the option `z'.  The second
example, however, uses `z' as the value for option `f' -- probably not
what was intended.

   This second example could be corrected in many ways, among which the
following are equivalent:

     tar -czf archive.tar.gz file
     tar -cf archive.tar.gz -z file
     tar cf archive.tar.gz -z file

File: tar.info,  Node: Mixing,  Prev: Old Options,  Up: Styles

3.3.4 Mixing Option Styles
--------------------------

All three styles may be intermixed in a single `tar' command, so long
as the rules for each style are fully respected(1).  Old style options
and either of the modern styles of options may be mixed within a single
`tar' command.  However, old style options must be introduced as the
first arguments only, following the rule for old options (old options
must appear directly after the `tar' command and some white space).
Modern options may be given only after all arguments to the old options
have been collected.  If this rule is not respected, a modern option
might be falsely interpreted as the value of the argument to one of the
old style options.

   For example, all the following commands are wholly equivalent, and
illustrate the many combinations and orderings of option styles.

     tar --create --file=archive.tar
     tar --create -f archive.tar
     tar --create -farchive.tar
     tar --file=archive.tar --create
     tar --file=archive.tar -c
     tar -c --file=archive.tar
     tar -c -f archive.tar
     tar -c -farchive.tar
     tar -cf archive.tar
     tar -cfarchive.tar
     tar -f archive.tar --create
     tar -f archive.tar -c
     tar -farchive.tar --create
     tar -farchive.tar -c
     tar c --file=archive.tar
     tar c -f archive.tar
     tar c -farchive.tar
     tar cf archive.tar
     tar f archive.tar --create
     tar f archive.tar -c
     tar fc archive.tar

   On the other hand, the following commands are _not_ equivalent to
the previous set:

     tar -f -c archive.tar
     tar -fc archive.tar
     tar -fcarchive.tar
     tar -farchive.tarc
     tar cfarchive.tar

These last examples mean something completely different from what the
user intended (judging based on the example in the previous set which
uses long options, whose intent is therefore very clear).  The first
four specify that the `tar' archive would be a file named `-c', `c',
`carchive.tar' or `archive.tarc', respectively.  The first two examples
also specify a single non-option, NAME argument having the value
`archive.tar'.  The last example contains only old style option letters
(repeating option `c' twice), not all of which are meaningful (eg., `.',
`h', or `i'), with no argument value.

   ---------- Footnotes ----------

   (1) Before GNU `tar' version 1.11.6, a bug prevented intermixing old
style options with long options in some cases.

File: tar.info,  Node: All Options,  Next: help,  Prev: Styles,  Up: tar invocation

3.4 All `tar' Options
=====================

The coming manual sections contain an alphabetical listing of all `tar'
operations and options, with brief descriptions and cross-references to
more in-depth explanations in the body of the manual.  They also
contain an alphabetically arranged table of the short option forms with
their corresponding long option.  You can use this table as a reference
for deciphering `tar' commands in scripts.

* Menu:

* Operation Summary::
* Option Summary::
* Short Option Summary::

File: tar.info,  Node: Operation Summary,  Next: Option Summary,  Up: All Options

3.4.1 Operations
----------------

`--append'
`-r'
     Appends files to the end of the archive.  *Note append::.

`--catenate'
`-A'
     Same as `--concatenate'.  *Note concatenate::.

`--compare'
`-d'
     Compares archive members with their counterparts in the file
     system, and reports differences in file size, mode, owner,
     modification date and contents.  *Note compare::.

`--concatenate'
`-A'
     Appends other `tar' archives to the end of the archive.  *Note
     concatenate::.

`--create'
`-c'
     Creates a new `tar' archive.  *Note create::.

`--delete'
     Deletes members from the archive.  Don't try this on an archive on
     a tape!  *Note delete::.

`--diff'
`-d'
     Same `--compare'.  *Note compare::.

`--extract'
`-x'
     Extracts members from the archive into the file system.  *Note
     extract::.

`--get'
`-x'
     Same as `--extract'.  *Note extract::.

`--list'
`-t'
     Lists the members in an archive.  *Note list::.

`--update'
`-u'
     Adds files to the end of the archive, but only if they are newer
     than their counterparts already in the archive, or if they do not
     already exist in the archive. *Note update::.


File: tar.info,  Node: Option Summary,  Next: Short Option Summary,  Prev: Operation Summary,  Up: All Options

3.4.2 `tar' Options
-------------------

`--absolute-names'
`-P'
     Normally when creating an archive, `tar' strips an initial `/'
     from member names, and when extracting from an archive `tar'
     treats names specially if they have initial `/' or internal `..'.
     This option disables that behavior.  *Note absolute::.

`--after-date'
     (See `--newer', *note after::)

`--anchored'
     A pattern must match an initial subsequence of the name's
     components.  *Note controlling pattern-matching::.

`--atime-preserve'
`--atime-preserve=replace'
`--atime-preserve=system'
     Attempt to preserve the access time of files when reading them.
     This option currently is effective only on files that you own,
     unless you have superuser privileges.

     `--atime-preserve=replace' remembers the access time of a file
     before reading it, and then restores the access time afterwards.
     This may cause problems if other programs are reading the file at
     the same time, as the times of their accesses will be lost.  On
     most platforms restoring the access time also requires `tar' to
     restore the data modification time too, so this option may also
     cause problems if other programs are writing the file at the same
     time (`tar' attempts to detect this situation, but cannot do so
     reliably due to race conditions).  Worse, on most platforms
     restoring the access time also updates the status change time,
     which means that this option is incompatible with incremental
     backups.

     `--atime-preserve=system' avoids changing time stamps on files,
     without interfering with time stamp updates caused by other
     programs, so it works better with incremental backups.  However,
     it requires a special `O_NOATIME' option from the underlying
     operating and file system implementation, and it also requires
     that searching directories does not update their access times.  As
     of this writing (November 2005) this works only with Linux, and
     only with Linux kernels 2.6.8 and later.  Worse, there is
     currently no reliable way to know whether this feature actually
     works.  Sometimes `tar' knows that it does not work, and if you use
     `--atime-preserve=system' then `tar' complains and exits right
     away.  But other times `tar' might think that the option works
     when it actually does not.

     Currently `--atime-preserve' with no operand defaults to
     `--atime-preserve=replace', but this may change in the future as
     support for `--atime-preserve=system' improves.

     If your operating or file system does not support
     `--atime-preserve=system', you might be able to preserve access
     times reliably by using the `mount' command.  For example, you can
     mount the file system read-only, or access the file system via a
     read-only loopback mount, or use the `noatime' mount option
     available on some systems.  However, mounting typically requires
     superuser privileges and can be a pain to manage.

`--auto-compress'
`-a'
     During a `--create' operation, enables automatic compressed format
     recognition based on the archive suffix.  The effect of this
     option is cancelled by `--no-auto-compress'.  *Note gzip::.

`--backup=BACKUP-TYPE'
     Rather than deleting files from the file system, `tar' will back
     them up using simple or numbered backups, depending upon
     BACKUP-TYPE.  *Note backup::.

`--block-number'
`-R'
     With this option present, `tar' prints error messages for read
     errors with the block number in the archive file.  *Note
     block-number::.

`--blocking-factor=BLOCKING'
`-b BLOCKING'
     Sets the blocking factor `tar' uses to BLOCKING x 512 bytes per
     record.  *Note Blocking Factor::.

`--bzip2'
`-j'
     This option tells `tar' to read or write archives through `bzip2'.
     *Note gzip::.

`--check-device'
     Check device numbers when creating a list of modified files for
     incremental archiving.  This is the default.  *Note device
     numbers::, for a detailed description.

`--checkpoint[=NUMBER]'
     This option directs `tar' to print periodic checkpoint messages as
     it reads through the archive.  It is intended for when you want a
     visual indication that `tar' is still running, but don't want to
     see `--verbose' output.  You can also instruct `tar' to execute a
     list of actions on each checkpoint, see `--checkpoint-action'
     below.  For a detailed description, see *note checkpoints::.

`--checkpoint-action=ACTION'
     Instruct `tar' to execute an action upon hitting a breakpoint.
     Here we give only a brief outline.  *Note checkpoints::, for a
     complete description.

     The ACTION argument can be one of the following:

    bell
          Produce an audible bell on the console.

    dot
    .
          Print a single dot on the standard listing stream.

    echo
          Display a textual message on the standard error, with the
          status and number of the checkpoint.  This is the default.

    echo=STRING
          Display STRING on the standard error.  Before output, the
          string is subject to meta-character expansion.

    exec=COMMAND
          Execute the given COMMAND.

    sleep=TIME
          Wait for TIME seconds.

    ttyout=STRING
          Output STRING on the current console (`/dev/tty').

     Several `--checkpoint-action' options can be specified.  The
     supplied actions will be executed in order of their appearance in
     the command line.

     Using `--checkpoint-action' without `--checkpoint' assumes default
     checkpoint frequency of one checkpoint per 10 records.

`--check-links'
`-l'
     If this option was given, `tar' will check the number of links
     dumped for each processed file.  If this number does not match the
     total number of hard links for the file, a warning message will be
     output (1).

     *Note hard links::.

`--compress'
`--uncompress'
`-Z'
     `tar' will use the `compress' program when reading or writing the
     archive.  This allows you to directly act on archives while saving
     space.  *Note gzip::.

`--confirmation'
     (See `--interactive'.)  *Note interactive::.

`--delay-directory-restore'
     Delay setting modification times and permissions of extracted
     directories until the end of extraction. *Note Directory
     Modification Times and Permissions::.

`--dereference'
`-h'
     When reading or writing a file to be archived, `tar' accesses the
     file that a symbolic link points to, rather than the symlink
     itself.  *Note dereference::.

`--directory=DIR'
`-C DIR'
     When this option is specified, `tar' will change its current
     directory to DIR before performing any operations.  When this
     option is used during archive creation, it is order sensitive.
     *Note directory::.

`--exclude=PATTERN'
     When performing operations, `tar' will skip files that match
     PATTERN.  *Note exclude::.

`--exclude-backups'
     Exclude backup and lock files.  *Note exclude-backups: exclude.

`--exclude-from=FILE'
`-X FILE'
     Similar to `--exclude', except `tar' will use the list of patterns
     in the file FILE.  *Note exclude::.

`--exclude-caches'
     Exclude from dump any directory containing a valid cache directory
     tag file, but still dump the directory node and the tag file
     itself.

     *Note exclude-caches: exclude.

`--exclude-caches-under'
     Exclude from dump any directory containing a valid cache directory
     tag file, but still dump the directory node itself.

     *Note exclude::.

`--exclude-caches-all'
     Exclude from dump any directory containing a valid cache directory
     tag file.  *Note exclude::.

`--exclude-tag=FILE'
     Exclude from dump any directory containing file named FILE, but
     dump the directory node and FILE itself.  *Note exclude-tag:
     exclude.

`--exclude-tag-under=FILE'
     Exclude from dump the contents of any directory containing file
     named FILE, but dump the directory node itself.  *Note
     exclude-tag-under: exclude.

`--exclude-tag-all=FILE'
     Exclude from dump any directory containing file named FILE.  *Note
     exclude-tag-all: exclude.

`--exclude-vcs'
     Exclude from dump directories and files, that are internal for some
     widely used version control systems.

     *Note exclude-vcs: exclude.

`--file=ARCHIVE'
`-f ARCHIVE'
     `tar' will use the file ARCHIVE as the `tar' archive it performs
     operations on, rather than `tar''s compilation dependent default.
     *Note file tutorial::.

`--files-from=FILE'
`-T FILE'
     `tar' will use the contents of FILE as a list of archive members
     or files to operate on, in addition to those specified on the
     command-line.  *Note files::.

`--force-local'
     Forces `tar' to interpret the file name given to `--file' as a
     local file, even if it looks like a remote tape drive name.  *Note
     local and remote archives::.

`--format=FORMAT'
`-H FORMAT'
     Selects output archive format.  FORMAT may be one of the following:

    `v7'
          Creates an archive that is compatible with Unix V7 `tar'.

    `oldgnu'
          Creates an archive that is compatible with GNU `tar' version
          1.12 or earlier.

    `gnu'
          Creates archive in GNU tar 1.13 format.  Basically it is the
          same as `oldgnu' with the only difference in the way it
          handles long numeric fields.

    `ustar'
          Creates a POSIX.1-1988 compatible archive.

    `posix'
          Creates a POSIX.1-2001 archive.


     *Note Formats::, for a detailed discussion of these formats.

`--full-time'
     This option instructs `tar' to print file times to their full
     resolution.  Usually this means 1-second resolution, but that
     depends on the underlying file system.  The `--full-time' option
     takes effect only when detailed output (verbosity level 2 or
     higher) has been requested using the `--verbose' option, e.g.,
     when listing or extracting archives:

          $ tar -t -v --full-time -f archive.tar

     or, when creating an archive:

          $ tar -c -vv --full-time -f archive.tar .

     Notice, thar when creating the archive you need to specify
     `--verbose' twice to get a detailed output (*note verbose
     tutorial::).

`--group=GROUP'
     Files added to the `tar' archive will have a group ID of GROUP,
     rather than the group from the source file.  GROUP can specify a
     symbolic name, or a numeric ID, or both as NAME:ID.  *Note
     override::.

     Also see the comments for the `--owner=USER' option.

`--gzip'
`--gunzip'
`--ungzip'
`-z'
     This option tells `tar' to read or write archives through `gzip',
     allowing `tar' to directly operate on several kinds of compressed
     archives transparently.  *Note gzip::.

`--hard-dereference'
     When creating an archive, dereference hard links and store the
     files they refer to, instead of creating usual hard link members.

     *Note hard links::.

`--help'
`-?'
     `tar' will print out a short message summarizing the operations and
     options to `tar' and exit. *Note help::.

`--ignore-case'
     Ignore case when matching member or file names with patterns.
     *Note controlling pattern-matching::.

`--ignore-command-error'
     Ignore exit codes of subprocesses. *Note Writing to an External
     Program::.

`--ignore-failed-read'
     Do not exit unsuccessfully merely because an unreadable file was
     encountered.  *Note Ignore Failed Read::.

`--ignore-zeros'
`-i'
     With this option, `tar' will ignore zeroed blocks in the archive,
     which normally signals EOF.  *Note Reading::.

`--incremental'
`-G'
     Informs `tar' that it is working with an old GNU-format
     incremental backup archive.  It is intended primarily for
     backwards compatibility only.  *Note Incremental Dumps::, for a
     detailed discussion of incremental archives.

`--index-file=FILE'
     Send verbose output to FILE instead of to standard output.

`--info-script=COMMAND'
`--new-volume-script=COMMAND'
`-F COMMAND'
     When `tar' is performing multi-tape backups, COMMAND is run at the
     end of each tape.  If it exits with nonzero status, `tar' fails
     immediately.  *Note info-script::, for a detailed discussion of
     this feature.

`--interactive'
`--confirmation'
`-w'
     Specifies that `tar' should ask the user for confirmation before
     performing potentially destructive options, such as overwriting
     files.  *Note interactive::.

`--keep-directory-symlink'
     This option changes the behavior of tar when it encounters a
     symlink with the same name as the directory that it is about to
     extract.  By default, in this case tar would first remove the
     symlink and then proceed extracting the directory.

     The `--keep-directory-symlink' option disables this behavior and
     instructs tar to follow symlinks to directories when extracting
     from the archive.

     It is mainly intended to provide compatibility with the Slackware
     installation scripts.

`--keep-newer-files'
     Do not replace existing files that are newer than their archive
     copies when extracting files from an archive.

`--keep-old-files'
`-k'
     Do not overwrite existing files when extracting files from an
     archive.  Return error if such files exist.  See also *note
     --skip-old-files::.

     *Note Keep Old Files::.

`--label=NAME'
`-V NAME'
     When creating an archive, instructs `tar' to write NAME as a name
     record in the archive.  When extracting or listing archives, `tar'
     will only operate on archives that have a label matching the
     pattern specified in NAME.  *Note Tape Files::.

`--level=N'
     Force incremental backup of level N.  As of GNU `tar' version
     1.27.1, the option `--level=0' truncates the snapshot file,
     thereby forcing the level 0 dump.  Other values of N are
     effectively ignored.  *Note --level=0::, for details and examples.

     The use of this option is valid only in conjunction with the
     `--listed-incremental' option.  *Note Incremental Dumps::, for a
     detailed description.

`--listed-incremental=SNAPSHOT-FILE'
`-g SNAPSHOT-FILE'
     During a `--create' operation, specifies that the archive that
     `tar' creates is a new GNU-format incremental backup, using
     SNAPSHOT-FILE to determine which files to backup.  With other
     operations, informs `tar' that the archive is in incremental
     format.  *Note Incremental Dumps::.

`--lzip'
     This option tells `tar' to read or write archives through `lzip'.
     *Note gzip::.

`--lzma'
     This option tells `tar' to read or write archives through `lzma'.
     *Note gzip::.

`--lzop'
     This option tells `tar' to read or write archives through `lzop'.
     *Note gzip::.

`--mode=PERMISSIONS'
     When adding files to an archive, `tar' will use PERMISSIONS for
     the archive members, rather than the permissions from the files.
     PERMISSIONS can be specified either as an octal number or as
     symbolic permissions, like with `chmod'. *Note override::.

`--mtime=DATE'
     When adding files to an archive, `tar' will use DATE as the
     modification time of members when creating archives, instead of
     their actual modification times.  The value of DATE can be either
     a textual date representation (*note Date input formats::) or a
     name of the existing file, starting with `/' or `.'.  In the
     latter case, the modification time of that file is used. *Note
     override::.

`--multi-volume'
`-M'
     Informs `tar' that it should create or otherwise operate on a
     multi-volume `tar' archive.  *Note Using Multiple Tapes::.

`--new-volume-script'
     (see `--info-script')

`--newer=DATE'
`--after-date=DATE'
`-N'
     When creating an archive, `tar' will only add files that have
     changed since DATE.  If DATE begins with `/' or `.', it is taken
     to be the name of a file whose data modification time specifies
     the date.  *Note after::.

`--newer-mtime=DATE'
     Like `--newer', but add only files whose contents have changed (as
     opposed to just `--newer', which will also back up files for which
     any status information has changed).  *Note after::.

`--no-anchored'
     An exclude pattern can match any subsequence of the name's
     components.  *Note controlling pattern-matching::.

`--no-auto-compress'
     Disables automatic compressed format recognition based on the
     archive suffix.  *Note --auto-compress::.  *Note gzip::.

`--no-check-device'
     Do not check device numbers when creating a list of modified files
     for incremental archiving.  *Note device numbers::, for a detailed
     description.

`--no-delay-directory-restore'
     Modification times and permissions of extracted directories are
     set when all files from this directory have been extracted.  This
     is the default.  *Note Directory Modification Times and
     Permissions::.

`--no-ignore-case'
     Use case-sensitive matching.  *Note controlling pattern-matching::.

`--no-ignore-command-error'
     Print warnings about subprocesses that terminated with a nonzero
     exit code. *Note Writing to an External Program::.

`--no-null'
     If the `--null' option was given previously, this option cancels
     its effect, so that any following `--files-from' options will
     expect their file lists to be newline-terminated.

`--no-overwrite-dir'
     Preserve metadata of existing directories when extracting files
     from an archive.  *Note Overwrite Old Files::.

`--no-quote-chars=STRING'
     Remove characters listed in STRING from the list of quoted
     characters set by the previous `--quote-chars' option (*note
     quoting styles::).

`--no-recursion'
     With this option, `tar' will not recurse into directories.  *Note
     recurse::.

`--no-same-owner'
`-o'
     When extracting an archive, do not attempt to preserve the owner
     specified in the `tar' archive.  This the default behavior for
     ordinary users.

`--no-same-permissions'
     When extracting an archive, subtract the user's umask from files
     from the permissions specified in the archive.  This is the
     default behavior for ordinary users.

`--no-seek'
     The archive media does not support seeks to arbitrary locations.
     Usually `tar' determines automatically whether the archive can be
     seeked or not.  Use this option to disable this mechanism.

`--no-unquote'
     Treat all input file or member names literally, do not interpret
     escape sequences.  *Note input name quoting::.

`--no-wildcards'
     Do not use wildcards.  *Note controlling pattern-matching::.

`--no-wildcards-match-slash'
     Wildcards do not match `/'.  *Note controlling pattern-matching::.

`--null'
     When `tar' is using the `--files-from' option, this option
     instructs `tar' to expect file names terminated with NUL, so `tar'
     can correctly work with file names that contain newlines.  *Note
     nul::.

`--numeric-owner'
     This option will notify `tar' that it should use numeric user and
     group IDs when creating a `tar' file, rather than names.  *Note
     Attributes::.

`-o'
     The function of this option depends on the action `tar' is
     performing.  When extracting files, `-o' is a synonym for
     `--no-same-owner', i.e., it prevents `tar' from restoring
     ownership of files being extracted.

     When creating an archive, it is a synonym for `--old-archive'.
     This behavior is for compatibility with previous versions of GNU
     `tar', and will be removed in future releases.

     *Note Changes::, for more information.

`--occurrence[=NUMBER]'
     This option can be used in conjunction with one of the subcommands
     `--delete', `--diff', `--extract' or `--list' when a list of files
     is given either on the command line or via `-T' option.

     This option instructs `tar' to process only the NUMBERth
     occurrence of each named file.  NUMBER defaults to 1, so

          tar -x -f archive.tar --occurrence filename

     will extract the first occurrence of the member `filename' from
     `archive.tar' and will terminate without scanning to the end of
     the archive.

`--old-archive'
     Synonym for `--format=v7'.

`--one-file-system'
     Used when creating an archive.  Prevents `tar' from recursing into
     directories that are on different file systems from the current
     directory.

`--overwrite'
     Overwrite existing files and directory metadata when extracting
     files from an archive.  *Note Overwrite Old Files::.

`--overwrite-dir'
     Overwrite the metadata of existing directories when extracting
     files from an archive.  *Note Overwrite Old Files::.

`--owner=USER'
     Specifies that `tar' should use USER as the owner of members when
     creating archives, instead of the user associated with the source
     file.  USER can specify a symbolic name, or a numeric ID, or both
     as NAME:ID.  *Note override::.

     This option does not affect extraction from archives.

`--pax-option=KEYWORD-LIST'
     This option enables creation of the archive in POSIX.1-2001 format
     (*note posix::) and modifies the way `tar' handles the extended
     header keywords.  KEYWORD-LIST is a comma-separated list of
     keyword options.  *Note PAX keywords::, for a detailed discussion.

`--portability'
`--old-archive'
     Synonym for `--format=v7'.

`--posix'
     Same as `--format=posix'.

`--preserve'
     Synonymous with specifying both `--preserve-permissions' and
     `--same-order'.  *Note Setting Access Permissions::.

`--preserve-order'
     (See `--same-order'; *note Reading::.)

`--preserve-permissions'
`--same-permissions'
`-p'
     When `tar' is extracting an archive, it normally subtracts the
     users' umask from the permissions specified in the archive and uses
     that number as the permissions to create the destination file.
     Specifying this option instructs `tar' that it should use the
     permissions directly from the archive.  *Note Setting Access
     Permissions::.

`--quote-chars=STRING'
     Always quote characters from STRING, even if the selected quoting
     style would not quote them (*note quoting styles::).

`--quoting-style=STYLE'
     Set quoting style to use when printing member and file names
     (*note quoting styles::). Valid STYLE values are: `literal',
     `shell', `shell-always', `c', `escape', `locale', and `clocale'.
     Default quoting style is `escape', unless overridden while
     configuring the package.

`--read-full-records'
`-B'
     Specifies that `tar' should reblock its input, for reading from
     pipes on systems with buggy implementations.  *Note Reading::.

`--record-size=SIZE[SUF]'
     Instructs `tar' to use SIZE bytes per record when accessing the
     archive.  The argument can be suffixed with a "size suffix", e.g.
     `--record-size=10K' for 10 Kilobytes.  *Note size-suffixes::, for
     a list of valid suffixes.   *Note Blocking Factor::, for a detailed
     description of this option.

`--recursion'
     With this option, `tar' recurses into directories (default).
     *Note recurse::.

`--recursive-unlink'
     Remove existing directory hierarchies before extracting
     directories of the same name from the archive.  *Note Recursive
     Unlink::.

`--remove-files'
     Directs `tar' to remove the source file from the file system after
     appending it to an archive.  *Note remove files::.

`--restrict'
     Disable use of some potentially harmful `tar' options.  Currently
     this option disables shell invocation from multi-volume menu
     (*note Using Multiple Tapes::).

`--rmt-command=CMD'
     Notifies `tar' that it should use CMD instead of the default
     `/usr/libexec/rmt' (*note Remote Tape Server::).

`--rsh-command=CMD'
     Notifies `tar' that is should use CMD to communicate with remote
     devices.  *Note Device::.

`--same-order'
`--preserve-order'
`-s'
     This option is an optimization for `tar' when running on machines
     with small amounts of memory.  It informs `tar' that the list of
     file arguments has already been sorted to match the order of files
     in the archive.  *Note Reading::.

`--same-owner'
     When extracting an archive, `tar' will attempt to preserve the
     owner specified in the `tar' archive with this option present.
     This is the default behavior for the superuser; this option has an
     effect only for ordinary users.  *Note Attributes::.

`--same-permissions'
     (See `--preserve-permissions'; *note Setting Access Permissions::.)

`--seek'
`-n'
     Assume that the archive media supports seeks to arbitrary
     locations.  Usually `tar' determines automatically whether the
     archive can be seeked or not.  This option is intended for use in
     cases when such recognition fails.  It takes effect only if the
     archive is open for reading (e.g. with `--list' or `--extract'
     options).

`--show-defaults'
     Displays the default options used by `tar' and exits successfully.
     This option is intended for use in shell scripts.  Here is an
     example of what you can see using this option:

          $ tar --show-defaults
          --format=gnu -f- -b20 --quoting-style=escape
          --rmt-command=/usr/libexec/rmt --rsh-command=/usr/bin/rsh

     Notice, that this option outputs only one line.  The example output
     above has been split to fit page boundaries. *Note defaults::.

`--show-omitted-dirs'
     Instructs `tar' to mention the directories it is skipping when
     operating on a `tar' archive.  *Note show-omitted-dirs::.

`--show-snapshot-field-ranges'
     Displays the range of values allowed by this version of `tar' for
     each field in the snapshot file, then exits successfully.  *Note
     Snapshot Files::.

`--show-transformed-names'
`--show-stored-names'
     Display file or member names after applying any transformations
     (*note transform::).  In particular, when used in conjunction with
     one of the archive creation operations it instructs `tar' to list
     the member names stored in the archive, as opposed to the actual
     file names.  *Note listing member and file names::.

`--skip-old-files'
     Do not overwrite existing files when extracting files from an
     archive.  *Note Keep Old Files::.

     This option differs from `--keep-old-files' in that it does not
     treat such files as an error, instead it just silently avoids
     overwriting them.

     The `--warning=existing-file' option can be used together with
     this option to produce warning messages about existing old files
     (*note warnings::).

`--sparse'
`-S'
     Invokes a GNU extension when adding files to an archive that
     handles sparse files efficiently.  *Note sparse::.

`--sparse-version=VERSION'
     Specifies the "format version" to use when archiving sparse files.
     Implies `--sparse'.  *Note sparse::. For the description of the
     supported sparse formats, *Note Sparse Formats::.

`--starting-file=NAME'
`-K NAME'
     This option affects extraction only; `tar' will skip extracting
     files in the archive until it finds one that matches NAME.  *Note
     Scarce::.

`--strip-components=NUMBER'
     Strip given NUMBER of leading components from file names before
     extraction.  For example, if archive `archive.tar' contained
     `/some/file/name', then running

          tar --extract --file archive.tar --strip-components=2

     would extract this file to file `name'.

`--suffix=SUFFIX'
     Alters the suffix `tar' uses when backing up files from the default
     `~'.  *Note backup::.

`--tape-length=NUM[SUF]'
`-L NUM[SUF]'
     Specifies the length of tapes that `tar' is writing as being
     NUM x 1024 bytes long.  If optional SUF is given, it specifies a
     multiplicative factor to be used instead of 1024.  For example,
     `-L2M' means 2 megabytes.  *Note size-suffixes::, for a list of
     allowed suffixes.  *Note Using Multiple Tapes::, for a detailed
     discussion of this option.

`--test-label'
     Reads the volume label.  If an argument is specified, test whether
     it matches the volume label.  *Note --test-label option::.

`--to-command=COMMAND'
     During extraction `tar' will pipe extracted files to the standard
     input of COMMAND.  *Note Writing to an External Program::.

`--to-stdout'
`-O'
     During extraction, `tar' will extract files to stdout rather than
     to the file system.  *Note Writing to Standard Output::.

`--totals[=SIGNO]'
     Displays the total number of bytes transferred when processing an
     archive.  If an argument is given, these data are displayed on
     request, when signal SIGNO is delivered to `tar'.  *Note totals::.

`--touch'
`-m'
     Sets the data modification time of extracted files to the
     extraction time, rather than the data modification time stored in
     the archive.  *Note Data Modification Times::.

`--transform=SED-EXPR'
`--xform=SED-EXPR'
     Transform file or member names using `sed' replacement expression
     SED-EXPR.  For example,

          $ tar cf archive.tar --transform 's,^\./,usr/,' .

     will add to `archive' files from the current working directory,
     replacing initial `./' prefix with `usr/'. For the detailed
     discussion, *Note transform::.

     To see transformed member names in verbose listings, use
     `--show-transformed-names' option (*note show-transformed-names::).

`--uncompress'
     (See `--compress', *note gzip::)

`--ungzip'
     (See `--gzip', *note gzip::)

`--unlink-first'
`-U'
     Directs `tar' to remove the corresponding file from the file
     system before extracting it from the archive.  *Note Unlink
     First::.

`--unquote'
     Enable unquoting input file or member names (default).  *Note
     input name quoting::.

`--use-compress-program=PROG'
`-I=PROG'
     Instructs `tar' to access the archive through PROG, which is
     presumed to be a compression program of some sort.  *Note gzip::.

`--utc'
     Display file modification dates in UTC.  This option implies
     `--verbose'.

`--verbose'
`-v'
     Specifies that `tar' should be more verbose about the operations
     it is performing.  This option can be specified multiple times for
     some operations to increase the amount of information displayed.
     *Note verbose::.

`--verify'
`-W'
     Verifies that the archive was correctly written when creating an
     archive.  *Note verify::.

`--version'
     Print information about the program's name, version, origin and
     legal status, all on standard output, and then exit successfully.
     *Note help::.

`--volno-file=FILE'
     Used in conjunction with `--multi-volume'.  `tar' will keep track
     of which volume of a multi-volume archive it is working in FILE.
     *Note volno-file::.

`--warning=KEYWORD'
     Enable or disable warning messages identified by KEYWORD.  The
     messages are suppressed if KEYWORD is prefixed with `no-'.  *Note
     warnings::.

`--wildcards'
     Use wildcards when matching member names with patterns.  *Note
     controlling pattern-matching::.

`--wildcards-match-slash'
     Wildcards match `/'.  *Note controlling pattern-matching::.

`--xz'
`-J'
     Use `xz' for compressing or decompressing the archives.  *Note
     gzip::.


   ---------- Footnotes ----------

   (1) Earlier versions of GNU `tar' understood `-l' as a synonym for
`--one-file-system'.  The current semantics, which complies to UNIX98,
was introduced with version 1.15.91. *Note Changes::, for more
information.

File: tar.info,  Node: Short Option Summary,  Prev: Option Summary,  Up: All Options

3.4.3 Short Options Cross Reference
-----------------------------------

Here is an alphabetized list of all of the short option forms, matching
them with the equivalent long option.

Short Option   Reference
-------------------------------------------------------------------------- 
-A             *note --concatenate::.
-B             *note --read-full-records::.
-C             *note --directory::.
-F             *note --info-script::.
-G             *note --incremental::.
-J             *note --xz::.
-K             *note --starting-file::.
-L             *note --tape-length::.
-M             *note --multi-volume::.
-N             *note --newer::.
-O             *note --to-stdout::.
-P             *note --absolute-names::.
-R             *note --block-number::.
-S             *note --sparse::.
-T             *note --files-from::.
-U             *note --unlink-first::.
-V             *note --label::.
-W             *note --verify::.
-X             *note --exclude-from::.
-Z             *note --compress::.
-b             *note --blocking-factor::.
-c             *note --create::.
-d             *note --compare::.
-f             *note --file::.
-g             *note --listed-incremental::.
-h             *note --dereference::.
-i             *note --ignore-zeros::.
-j             *note --bzip2::.
-k             *note --keep-old-files::.
-l             *note --check-links::.
-m             *note --touch::.
-o             When creating, *note --no-same-owner::, when extracting --
               *note --portability::.
               
                  The latter usage is deprecated.  It is retained for
               compatibility with the earlier versions of GNU `tar'.  In
               future releases `-o' will be equivalent to
               `--no-same-owner' only.
-p             *note --preserve-permissions::.
-r             *note --append::.
-s             *note --same-order::.
-t             *note --list::.
-u             *note --update::.
-v             *note --verbose::.
-w             *note --interactive::.
-x             *note --extract::.
-z             *note --gzip::.

File: tar.info,  Node: help,  Next: defaults,  Prev: All Options,  Up: tar invocation

3.5 GNU `tar' documentation
===========================

Being careful, the first thing is really checking that you are using
GNU `tar', indeed.  The `--version' option causes `tar' to print
information about its name, version, origin and legal status, all on
standard output, and then exit successfully.  For example,
`tar --version' might print:

     tar (GNU tar) 1.27.1
     Copyright (C) 2013 Free Software Foundation, Inc.
     License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>.
     This is free software: you are free to change and redistribute it.
     There is NO WARRANTY, to the extent permitted by law.

     Written by John Gilmore and Jay Fenlason.

The first occurrence of `tar' in the result above is the program name
in the package (for example, `rmt' is another program), while the
second occurrence of `tar' is the name of the package itself,
containing possibly many programs.  The package is currently named
`tar', after the name of the main program it contains(1).

   Another thing you might want to do is checking the spelling or
meaning of some particular `tar' option, without resorting to this
manual, for once you have carefully read it.  GNU `tar' has a short
help feature, triggerable through the `--help' option.  By using this
option, `tar' will print a usage message listing all available options
on standard output, then exit successfully, without doing anything else
and ignoring all other options.  Even if this is only a brief summary,
it may be several screens long.  So, if you are not using some kind of
scrollable window, you might prefer to use something like:

     $ tar --help | less

presuming, here, that you like using `less' for a pager.  Other popular
pagers are `more' and `pg'.  If you know about some KEYWORD which
interests you and do not want to read all the `--help' output, another
common idiom is doing:

     tar --help | grep KEYWORD

for getting only the pertinent lines.  Notice, however, that some `tar'
options have long description lines and the above command will list
only the first of them.

   The exact look of the option summary displayed by `tar --help' is
configurable. *Note Configuring Help Summary::, for a detailed
description.

   If you only wish to check the spelling of an option, running `tar
--usage' may be a better choice.  This will display a terse list of
`tar' options without accompanying explanations.

   The short help output is quite succinct, and you might have to get
back to the full documentation for precise points.  If you are reading
this paragraph, you already have the `tar' manual in some form.  This
manual is available in a variety of forms from
`http://www.gnu.org/software/tar/manual'.  It may be printed out of the
GNU `tar' distribution, provided you have TeX already installed
somewhere, and a laser printer around.  Just configure the
distribution, execute the command `make dvi', then print `doc/tar.dvi'
the usual way (contact your local guru to know how).  If GNU `tar' has
been conveniently installed at your place, this manual is also
available in interactive, hypertextual form as an Info file.  Just call
`info tar' or, if you do not have the `info' program handy, use the
Info reader provided within GNU Emacs, calling `tar' from the main Info
menu.

   There is currently no `man' page for GNU `tar'.  If you observe such
a `man' page on the system you are running, either it does not belong
to GNU `tar', or it has not been produced by GNU.  Some package
maintainers convert `tar --help' output to a man page, using
`help2man'.  In any case, please bear in mind that the authoritative
source of information about GNU `tar' is this Texinfo documentation.

   ---------- Footnotes ----------

   (1) There are plans to merge the `cpio' and `tar' packages into a
single one which would be called `paxutils'.  So, who knows if, one of
this days, the `--version' would not output `tar (GNU paxutils) 3.2'.

File: tar.info,  Node: defaults,  Next: verbose,  Prev: help,  Up: tar invocation

3.6 Obtaining GNU `tar' default values
======================================

GNU `tar' has some predefined defaults that are used when you do not
explicitly specify another values.  To obtain a list of such defaults,
use `--show-defaults' option.  This will output the values in the form
of `tar' command line options:

     $ tar --show-defaults
     --format=gnu -f- -b20 --quoting-style=escape
     --rmt-command=/etc/rmt --rsh-command=/usr/bin/rsh

Notice, that this option outputs only one line.  The example output
above has been split to fit page boundaries.

The above output shows that this version of GNU `tar' defaults to using
`gnu' archive format (*note Formats::), it uses standard output as the
archive, if no `--file' option has been given (*note file tutorial::),
the default blocking factor is 20 (*note Blocking Factor::).  It also
shows the default locations where `tar' will look for `rmt' and `rsh'
binaries.

File: tar.info,  Node: verbose,  Next: checkpoints,  Prev: defaults,  Up: tar invocation

3.7 Checking `tar' progress
===========================

Typically, `tar' performs most operations without reporting any
information to the user except error messages.  When using `tar' with
many options, particularly ones with complicated or
difficult-to-predict behavior, it is possible to make serious mistakes.
`tar' provides several options that make observing `tar' easier.  These
options cause `tar' to print information as it progresses in its job,
and you might want to use them just for being more careful about what
is going on, or merely for entertaining yourself.  If you have
encountered a problem when operating on an archive, however, you may
need more information than just an error message in order to solve the
problem.  The following options can be helpful diagnostic tools.

   Normally, the `--list' (`-t') command to list an archive prints just
the file names (one per line) and the other commands are silent. When
used with most operations, the `--verbose' (`-v') option causes `tar'
to print the name of each file or archive member as it is processed.
This and the other options which make `tar' print status information
can be useful in monitoring `tar'.

   With `--create' or `--extract', `--verbose' used once just prints
the names of the files or members as they are processed.  Using it
twice causes `tar' to print a longer listing (*Note verbose member
listing::, for the description) for each member.  Since `--list'
already prints  the names of the members, `--verbose' used once with
`--list' causes `tar' to print an `ls -l' type listing of the files in
the archive.  The following examples both extract members with long
list output:

     $ tar --extract --file=archive.tar --verbose --verbose
     $ tar xvvf archive.tar

   Verbose output appears on the standard output except when an archive
is being written to the standard output, as with `tar --create --file=-
--verbose' (`tar cvf -', or even `tar cv'--if the installer let
standard output be the default archive).  In that case `tar' writes
verbose output to the standard error stream.

   If `--index-file=FILE' is specified, `tar' sends verbose output to
FILE rather than to standard output or standard error.

   The `--totals' option causes `tar' to print on the standard error
the total amount of bytes transferred when processing an archive.  When
creating or appending to an archive, this option prints the number of
bytes written to the archive and the average speed at which they have
been written, e.g.:

     $ tar -c -f archive.tar --totals /home
     Total bytes written: 7924664320 (7.4GiB, 85MiB/s)

   When reading an archive, this option displays the number of bytes
read:

     $ tar -x -f archive.tar --totals
     Total bytes read: 7924664320 (7.4GiB, 95MiB/s)

   Finally, when deleting from an archive, the `--totals' option
displays both numbers plus number of bytes removed from the archive:

     $ tar --delete -f foo.tar --totals --wildcards '*~'
     Total bytes read: 9543680 (9.2MiB, 201MiB/s)
     Total bytes written: 3829760 (3.7MiB, 81MiB/s)
     Total bytes deleted: 1474048

   You can also obtain this information on request.  When `--totals' is
used with an argument, this argument is interpreted as a symbolic name
of a signal, upon delivery of which the statistics is to be printed:

`--totals=SIGNO'
     Print statistics upon delivery of signal SIGNO.  Valid arguments
     are: `SIGHUP', `SIGQUIT', `SIGINT', `SIGUSR1' and `SIGUSR2'.
     Shortened names without `SIG' prefix are also accepted.

   Both forms of `--totals' option can be used simultaneously.  Thus,
`tar -x --totals --totals=USR1' instructs `tar' to extract all members
from its default archive and print statistics after finishing the
extraction, as well as when receiving signal `SIGUSR1'.

   The `--checkpoint' option prints an occasional message as `tar'
reads or writes the archive.  It is designed for those who don't need
the more detailed (and voluminous) output of `--block-number' (`-R'),
but do want visual confirmation that `tar' is actually making forward
progress.  By default it prints a message each 10 records read or
written.  This can be changed by giving it a numeric argument after an
equal sign:

     $ tar -c --checkpoint=1000 /var
     tar: Write checkpoint 1000
     tar: Write checkpoint 2000
     tar: Write checkpoint 3000

   This example shows the default checkpoint message used by `tar'.  If
you place a dot immediately after the equal sign, it will print a `.'
at each checkpoint(1).  For example:

     $ tar -c --checkpoint=.1000 /var
     ...

   The `--checkpoint' option provides a flexible mechanism for
executing arbitrary actions upon hitting checkpoints, see the next
section (*note checkpoints::), for more information on it.

   The `--show-omitted-dirs' option, when reading an archive--with
`--list' or `--extract', for example--causes a message to be printed
for each directory in the archive which is skipped.  This happens
regardless of the reason for skipping: the directory might not have
been named on the command line (implicitly or explicitly), it might be
excluded by the use of the `--exclude=PATTERN' option, or some other
reason.

   If `--block-number' (`-R') is used, `tar' prints, along with every
message it would normally produce, the block number within the archive
where the message was triggered.  Also, supplementary messages are
triggered when reading blocks full of NULs, or when hitting end of file
on the archive.  As of now, if the archive is properly terminated with
a NUL block, the reading of the file may stop before end of file is
met, so the position of end of file will not usually show when
`--block-number' (`-R') is used.  Note that GNU `tar' drains the
archive before exiting when reading the archive from a pipe.

   This option is especially useful when reading damaged archives, since
it helps pinpoint the damaged sections.  It can also be used with
`--list' (`-t') when listing a file-system backup tape, allowing you to
choose among several backup tapes when retrieving a file later, in
favor of the tape where the file appears earliest (closest to the front
of the tape).  *Note backup::.

   ---------- Footnotes ----------

   (1) This is actually a shortcut for `--checkpoint=N
--checkpoint-action=dot'.  *Note dot: checkpoints.

File: tar.info,  Node: checkpoints,  Next: warnings,  Prev: verbose,  Up: tar invocation

3.8 Checkpoints
===============

A "checkpoint" is a moment of time before writing Nth record to the
archive (a "write checkpoint"), or before reading Nth record from the
archive (a "read checkpoint").  Checkpoints allow to periodically
execute arbitrary actions.

   The checkpoint facility is enabled using the following option:

`--checkpoint[=N]'
     Schedule checkpoints before writing or reading each Nth record.
     The default value for N is 10.

   A list of arbitrary "actions" can be executed at each checkpoint.
These actions include: pausing, displaying textual messages, and
executing arbitrary external programs.  Actions are defined using the
`--checkpoint-action' option.

`--checkpoint-action=ACTION'
     Execute an ACTION at each checkpoint.

   The simplest value of ACTION is `echo'.  It instructs `tar' to
display the default message on the standard error stream upon arriving
at each checkpoint.  The default message is (in POSIX locale) `Write
checkpoint N', for write checkpoints, and `Read checkpoint N', for read
checkpoints.  Here, N represents ordinal number of the checkpoint.

   In another locales, translated versions of this message are used.

   This is the default action, so running:

     $ tar -c --checkpoint=1000 --checkpoint-action=echo /var

is equivalent to:

     $ tar -c --checkpoint=1000 /var

   The `echo' action also allows to supply a customized message.  You
do so by placing an equals sign and the message right after it, e.g.:

     --checkpoint-action="echo=Hit %s checkpoint #%u"

   The `%s' and `%u' in the above example are "meta-characters".  The
`%s' meta-character is replaced with the "type" of the checkpoint:
`write' or `read' (or a corresponding translated version in locales
other than POSIX).  The `%u' meta-character is replaced with the
ordinal number of the checkpoint.  Thus, the above example could
produce the following output when used with the `--create' option:

     tar: Hit write checkpoint #10
     tar: Hit write checkpoint #20
     tar: Hit write checkpoint #30

   Aside from meta-character expansion, the message string is subject to
"unquoting", during which the backslash "escape sequences" are replaced
with their corresponding ASCII characters (*note escape sequences::).
E.g. the following action will produce an audible bell and the message
described above at each checkpoint:

     --checkpoint-action='echo=\aHit %s checkpoint #%u'

   There is also a special action which produces an audible signal:
`bell'.  It is not equivalent to `echo='\a'', because `bell' sends the
bell directly to the console (`/dev/tty'), whereas `echo='\a'' sends it
to the standard error.

   The `ttyout=STRING' action outputs STRING to `/dev/tty', so it can
be used even if the standard output is redirected elsewhere.  The
STRING is subject to the same modifications as with `echo' action.  In
contrast to the latter, `ttyout' does not prepend `tar' executable name
to the string, nor does it output a newline after it.  For example, the
following action will print the checkpoint message at the same screen
line, overwriting any previous message:

     --checkpoint-action="ttyout=\rHit %s checkpoint #%u"

   Another available checkpoint action is `dot' (or `.').  It instructs
`tar' to print a single dot on the standard listing stream, e.g.:

     $ tar -c --checkpoint=1000 --checkpoint-action=dot /var
     ...

   For compatibility with previous GNU `tar' versions, this action can
be abbreviated by placing a dot in front of the checkpoint frequency,
as shown in the previous section.

   Yet another action, `sleep', pauses `tar' for a specified amount of
seconds.  The following example will stop for 30 seconds at each
checkpoint:

     $ tar -c --checkpoint=1000 --checkpoint-action=sleep=30

   Finally, the `exec' action executes a given external command.  For
example:

     $ tar -c --checkpoint=1000 --checkpoint-action=exec=/sbin/cpoint

   The supplied command can be any valid command invocation, with or
without additional command line arguments.  If it does contain
arguments, don't forget to quote it to prevent it from being split by
the shell.  *Note Running External Commands: external, for more detail.

   The command gets a copy of `tar''s environment plus the following
variables:

`TAR_VERSION'
     GNU `tar' version number.

`TAR_ARCHIVE'
     The name of the archive `tar' is processing.

`TAR_BLOCKING_FACTOR'
     Current blocking factor (*note Blocking::).

`TAR_CHECKPOINT'
     Number of the checkpoint.

`TAR_SUBCOMMAND'
     A short option describing the operation `tar' is executing.  *Note
     Operations::, for a complete list of subcommand options.

`TAR_FORMAT'
     Format of the archive being processed. *Note Formats::, for a
     complete list of archive format names.

   These environment variables can also be passed as arguments to the
command, provided that they are properly escaped, for example:

     tar -c -f arc.tar \
          --checkpoint-action='exec=/sbin/cpoint $TAR_FILENAME'

Notice single quotes to prevent variable names from being expanded by
the shell when invoking `tar'.

   Any number of actions can be defined, by supplying several
`--checkpoint-action' options in the command line.  For example, the
command below displays two messages, pauses execution for 30 seconds
and executes the `/sbin/cpoint' script:

     $ tar -c -f arc.tar \
            --checkpoint-action='\aecho=Hit %s checkpoint #%u' \
            --checkpoint-action='echo=Sleeping for 30 seconds' \
            --checkpoint-action='sleep=30' \
            --checkpoint-action='exec=/sbin/cpoint'

   This example also illustrates the fact that `--checkpoint-action'
can be used without `--checkpoint'.  In this case, the default
checkpoint frequency (at each 10th record) is assumed.

File: tar.info,  Node: warnings,  Next: interactive,  Prev: checkpoints,  Up: tar invocation

3.9 Controlling Warning Messages
================================

Sometimes, while performing the requested task, GNU `tar' notices some
conditions that are not exactly errors, but which the user should be
aware of.  When this happens, `tar' issues a "warning message"
describing the condition.  Warning messages are output to the standard
error and they do not affect the exit code of `tar' command.

   GNU `tar' allows the user to suppress some or all of its warning
messages:

`--warning=KEYWORD'
     Control display of the warning messages identified by KEYWORD.  If
     KEYWORD starts with the prefix `no-', such messages are
     suppressed.  Otherwise, they are enabled.

     Multiple `--warning' messages accumulate.

     The tables below list allowed values for KEYWORD along with the
     warning messages they control.

Keywords controlling `tar' operation
------------------------------------

all
     Enable all warning messages.  This is the default.  

none
     Disable all warning messages.  

filename-with-nuls
     `%s: file name read contains nul character' 

alone-zero-block
     `A lone zero block at %s'

Keywords applicable for `tar --create'
--------------------------------------

cachedir
     `%s: contains a cache directory tag %s; %s' 

file-shrank
     `%s: File shrank by %s bytes; padding with zeros' 

xdev
     `%s: file is on a different filesystem; not dumped' 

file-ignored
     `%s: Unknown file type; file ignored'
     `%s: socket ignored'
     `%s: door ignored' 

file-unchanged
     `%s: file is unchanged; not dumped' 

ignore-archive
     `%s: file is the archive; not dumped' 

file-removed
     `%s: File removed before we read it' 

file-changed
     `%s: file changed as we read it'

Keywords applicable for `tar --extract'
---------------------------------------

timestamp
     `%s: implausibly old time stamp %s'
     `%s: time stamp %s is %s s in the future' 

contiguous-cast
     `Extracting contiguous files as regular files' 

symlink-cast
     `Attempting extraction of symbolic links as hard links' 

unknown-cast
     `%s: Unknown file type '%c', extracted as normal file' 

ignore-newer
     `Current %s is newer or same age' 

unknown-keyword
     `Ignoring unknown extended header keyword '%s'' 

decompress-program
     Controls verbose description of failures occurring when trying to
     run alternative decompressor programs (*note alternative
     decompression programs::).  This warning is disabled by default
     (unless `--verbose' is used).  A common example of what you can get
     when using this warning is:

          $ tar --warning=decompress-program -x -f archive.Z
          tar (child): cannot run compress: No such file or directory
          tar (child): trying gzip

     This means that `tar' first tried to decompress `archive.Z' using
     `compress', and, when that failed, switched to `gzip'.  

record-size
     `Record size = %lu blocks'

Keywords controlling incremental extraction:
--------------------------------------------

rename-directory
     `%s: Directory has been renamed from %s'
     `%s: Directory has been renamed' 

new-directory
     `%s: Directory is new' 

xdev
     `%s: directory is on a different device: not purging' 

bad-dumpdir
     `Malformed dumpdir: 'X' never used'

File: tar.info,  Node: interactive,  Next: external,  Prev: warnings,  Up: tar invocation

3.10 Asking for Confirmation During Operations
==============================================

Typically, `tar' carries out a command without stopping for further
instructions.  In some situations however, you may want to exclude some
files and archive members from the operation (for instance if disk or
storage space is tight).  You can do this by excluding certain files
automatically (*note Choosing::), or by performing an operation
interactively, using the `--interactive' (`-w') option.  `tar' also
accepts `--confirmation' for this option.

   When the `--interactive' (`-w') option is specified, before reading,
writing, or deleting files, `tar' first prints a message for each such
file, telling what operation it intends to take, then asks for
confirmation on the terminal.  The actions which require confirmation
include adding a file to the archive, extracting a file from the
archive, deleting a file from the archive, and deleting a file from
disk.  To confirm the action, you must type a line of input beginning
with `y'.  If your input line begins with anything other than `y',
`tar' skips that file.

   If `tar' is reading the archive from the standard input, `tar' opens
the file `/dev/tty' to support the interactive communications.

   Verbose output is normally sent to standard output, separate from
other error messages.  However, if the archive is produced directly on
standard output, then verbose output is mixed with errors on `stderr'.
Producing the archive on standard output may be used as a way to avoid
using disk space, when the archive is soon to be consumed by another
process reading it, say.  Some people felt the need of producing an
archive on stdout, still willing to segregate between verbose output
and error output.  A possible approach would be using a named pipe to
receive the archive, and having the consumer process to read from that
named pipe.  This has the advantage of letting standard output free to
receive verbose output, all separate from errors.

File: tar.info,  Node: external,  Prev: interactive,  Up: tar invocation

3.11 Running External Commands
==============================

Certain GNU `tar' operations imply running external commands that you
supply on the command line.  One of such operations is checkpointing,
described above (*note checkpoint exec::).  Another example of this
feature is the `-I' option, which allows you to supply the program to
use for compressing or decompressing the archive (*note
use-compress-program::).

   Whenever such operation is requested, `tar' first splits the
supplied command into words much like the shell does.  It then treats
the first word as the name of the program or the shell script to execute
and the rest of words as its command line arguments.  The program,
unless given as an absolute file name, is searched in the shell's
`PATH'.

   Any additional information is normally supplied to external commands
in environment variables, specific to each particular operation.  For
example, the `--checkpoint-action=exec' option, defines the
`TAR_ARCHIVE' variable to the name of the archive being worked upon.
You can, should the need be, use these variables in the command line of
the external command.  For example:

     $ tar -x -f archive.tar \
         --checkpoint=exec='printf "%04d in %32s\r" $TAR_CHECKPOINT $TAR_ARCHIVE'

This command prints for each checkpoint its number and the name of the
archive, using the same output line on the screen.

   Notice the use of single quotes to prevent variable names from being
expanded by the shell when invoking `tar'.

