File: coreutils.info,  Node: Common options,  Next: Output of entire files,  Prev: Introduction,  Up: Top

2 Common options
****************

Certain options are available in all of these programs.  Rather than
writing identical descriptions for each of the programs, they are
described here.  (In fact, every GNU program accepts (or should accept)
these options.)

   Normally options and operands can appear in any order, and programs
act as if all the options appear before any operands.  For example,
'sort -r passwd -t :' acts like 'sort -r -t : passwd', since ':' is an
option-argument of '-t'.  However, if the 'POSIXLY_CORRECT' environment
variable is set, options must appear before operands, unless otherwise
specified for a particular command.

   A few programs can usefully have trailing operands with leading '-'.
With such a program, options must precede operands even if
'POSIXLY_CORRECT' is not set, and this fact is noted in the program
description.  For example, the 'env' command's options must appear
before its operands, since in some cases the operands specify a command
that itself contains options.

   Most programs that accept long options recognize unambiguous
abbreviations of those options.  For example, 'rmdir
--ignore-fail-on-non-empty' can be invoked as 'rmdir --ignore-fail' or
even 'rmdir --i'.  Ambiguous options, such as 'ls --h', are identified
as such.

   Some of these programs recognize the '--help' and '--version' options
only when one of them is the sole command line argument.  For these
programs, abbreviations of the long options are not always recognized.

'--help'
     Print a usage message listing all available options, then exit
     successfully.

'--version'
     Print the version number, then exit successfully.

'--'
     Delimit the option list.  Later arguments, if any, are treated as
     operands even if they begin with '-'.  For example, 'sort -- -r'
     reads from the file named '-r'.

   A single '-' operand is not really an option, though it looks like
one.  It stands for standard input, or for standard output if that is
clear from the context.  For example, 'sort -' reads from standard
input, and is equivalent to plain 'sort', and 'tee -' writes an extra
copy of its input to standard output.  Unless otherwise specified, '-'
can appear as any operand that requires a file name.

* Menu:

* Exit status::                 Indicating program success or failure.
* Backup options::              -b -S, in some programs.
* Block size::                  BLOCK_SIZE and -block-size, in some programs.
* Floating point::              Floating point number representation.
* Signal specifications::       Specifying signals using the -signal option.
* Disambiguating names and IDs:: chgrp and chown owner and group syntax
* Random sources::              -random-source, in some programs.
* Target directory::            Specifying a target directory, in some programs.
* Trailing slashes::            -strip-trailing-slashes, in some programs.
* Traversing symlinks::         -H, -L, or -P, in some programs.
* Treating / specially::        -preserve-root and -no-preserve-root.
* Special built-in utilities::  'break', ':', ...
* Standards conformance::       Conformance to the POSIX standard.

File: coreutils.info,  Node: Exit status,  Next: Backup options,  Up: Common options

2.1 Exit status
===============

Nearly every command invocation yields an integral "exit status" that
can be used to change how other commands work.  For the vast majority of
commands, an exit status of zero indicates success.  Failure is
indicated by a nonzero value--typically '1', though it may differ on
unusual platforms as POSIX requires only that it be nonzero.

   However, some of the programs documented here do produce other exit
status values and a few associate different meanings with the values '0'
and '1'.  Here are some of the exceptions: 'chroot', 'env', 'expr',
'nice', 'nohup', 'numfmt', 'printenv', 'sort', 'stdbuf', 'test',
'timeout', 'tty'.

File: coreutils.info,  Node: Backup options,  Next: Block size,  Prev: Exit status,  Up: Common options

2.2 Backup options
==================

Some GNU programs (at least 'cp', 'install', 'ln', and 'mv') optionally
make backups of files before writing new versions.  These options
control the details of these backups.  The options are also briefly
mentioned in the descriptions of the particular programs.

'-b'
''--backup'[=METHOD]'
     Make a backup of each file that would otherwise be overwritten or
     removed.  Without this option, the original versions are destroyed.
     Use METHOD to determine the type of backups to make.  When this
     option is used but METHOD is not specified, then the value of the
     'VERSION_CONTROL' environment variable is used.  And if
     'VERSION_CONTROL' is not set, the default backup type is
     'existing'.

     Note that the short form of this option, '-b' does not accept any
     argument.  Using '-b' is equivalent to using '--backup=existing'.

     This option corresponds to the Emacs variable 'version-control';
     the values for METHOD are the same as those used in Emacs.  This
     option also accepts more descriptive names.  The valid METHODs are
     (unique abbreviations are accepted):

     'none'
     'off'
          Never make backups.

     'numbered'
     't'
          Always make numbered backups.

     'existing'
     'nil'
          Make numbered backups of files that already have them, simple
          backups of the others.

     'simple'
     'never'
          Always make simple backups.  Please note 'never' is not to be
          confused with 'none'.

'-S SUFFIX'
'--suffix=SUFFIX'
     Append SUFFIX to each backup file made with '-b'.  If this option
     is not specified, the value of the 'SIMPLE_BACKUP_SUFFIX'
     environment variable is used.  And if 'SIMPLE_BACKUP_SUFFIX' is not
     set, the default is '~', just as in Emacs.

File: coreutils.info,  Node: Block size,  Next: Floating point,  Prev: Backup options,  Up: Common options

2.3 Block size
==============

Some GNU programs (at least 'df', 'du', and 'ls') display sizes in
"blocks".  You can adjust the block size and method of display to make
sizes easier to read.  The block size used for display is independent of
any file system block size.  Fractional block counts are rounded up to
the nearest integer.

   The default block size is chosen by examining the following
environment variables in turn; the first one that is set determines the
block size.

'DF_BLOCK_SIZE'
     This specifies the default block size for the 'df' command.
     Similarly, 'DU_BLOCK_SIZE' specifies the default for 'du' and
     'LS_BLOCK_SIZE' for 'ls'.

'BLOCK_SIZE'
     This specifies the default block size for all three commands, if
     the above command-specific environment variables are not set.

'BLOCKSIZE'
     This specifies the default block size for all values that are
     normally printed as blocks, if neither 'BLOCK_SIZE' nor the above
     command-specific environment variables are set.  Unlike the other
     environment variables, 'BLOCKSIZE' does not affect values that are
     normally printed as byte counts, e.g., the file sizes contained in
     'ls -l' output.

'POSIXLY_CORRECT'
     If neither 'COMMAND_BLOCK_SIZE', nor 'BLOCK_SIZE', nor 'BLOCKSIZE'
     is set, but this variable is set, the block size defaults to 512.

   If none of the above environment variables are set, the block size
currently defaults to 1024 bytes in most contexts, but this number may
change in the future.  For 'ls' file sizes, the block size defaults to 1
byte.

   A block size specification can be a positive integer specifying the
number of bytes per block, or it can be 'human-readable' or 'si' to
select a human-readable format.  Integers may be followed by suffixes
that are upward compatible with the SI prefixes
(http://www.bipm.org/en/si/si_brochure/chapter3/prefixes.html) for
decimal multiples and with the ISO/IEC 80000-13 (formerly IEC 60027-2)
prefixes (http://physics.nist.gov/cuu/Units/binary.html) for binary
multiples.

   With human-readable formats, output sizes are followed by a size
letter such as 'M' for megabytes.  'BLOCK_SIZE=human-readable' uses
powers of 1024; 'M' stands for 1,048,576 bytes.  'BLOCK_SIZE=si' is
similar, but uses powers of 1000 and appends 'B'; 'MB' stands for
1,000,000 bytes.

   A block size specification preceded by ''' causes output sizes to be
displayed with thousands separators.  The 'LC_NUMERIC' locale specifies
the thousands separator and grouping.  For example, in an American
English locale, '--block-size="'1kB"' would cause a size of 1234000
bytes to be displayed as '1,234'.  In the default C locale, there is no
thousands separator so a leading ''' has no effect.

   An integer block size can be followed by a suffix to specify a
multiple of that size.  A bare size letter, or one followed by 'iB',
specifies a multiple using powers of 1024.  A size letter followed by
'B' specifies powers of 1000 instead.  For example, '1M' and '1MiB' are
equivalent to '1048576', whereas '1MB' is equivalent to '1000000'.

   A plain suffix without a preceding integer acts as if '1' were
prepended, except that it causes a size indication to be appended to the
output.  For example, '--block-size="kB"' displays 3000 as '3kB'.

   The following suffixes are defined.  Large sizes like '1Y' may be
rejected by your computer due to limitations of its arithmetic.

'kB'
     kilobyte: 10^3 = 1000.
'k'
'K'
'KiB'
     kibibyte: 2^{10} = 1024.  'K' is special: the SI prefix is 'k' and
     the ISO/IEC 80000-13 prefix is 'Ki', but tradition and POSIX use
     'k' to mean 'KiB'.
'MB'
     megabyte: 10^6 = 1,000,000.
'M'
'MiB'
     mebibyte: 2^{20} = 1,048,576.
'GB'
     gigabyte: 10^9 = 1,000,000,000.
'G'
'GiB'
     gibibyte: 2^{30} = 1,073,741,824.
'TB'
     terabyte: 10^{12} = 1,000,000,000,000.
'T'
'TiB'
     tebibyte: 2^{40} = 1,099,511,627,776.
'PB'
     petabyte: 10^{15} = 1,000,000,000,000,000.
'P'
'PiB'
     pebibyte: 2^{50} = 1,125,899,906,842,624.
'EB'
     exabyte: 10^{18} = 1,000,000,000,000,000,000.
'E'
'EiB'
     exbibyte: 2^{60} = 1,152,921,504,606,846,976.
'ZB'
     zettabyte: 10^{21} = 1,000,000,000,000,000,000,000
'Z'
'ZiB'
     2^{70} = 1,180,591,620,717,411,303,424.
'YB'
     yottabyte: 10^{24} = 1,000,000,000,000,000,000,000,000.
'Y'
'YiB'
     2^{80} = 1,208,925,819,614,629,174,706,176.

   Block size defaults can be overridden by an explicit
'--block-size=SIZE' option.  The '-k' option is equivalent to
'--block-size=1K', which is the default unless the 'POSIXLY_CORRECT'
environment variable is set.  The '-h' or '--human-readable' option is
equivalent to '--block-size=human-readable'.  The '--si' option is
equivalent to '--block-size=si'.  Note for 'ls' the '-k' option does not
control the display of the apparent file sizes, whereas the
'--block-size' option does.

File: coreutils.info,  Node: Floating point,  Next: Signal specifications,  Prev: Block size,  Up: Common options

2.4 Floating point numbers
==========================

Commands that accept or produce floating point numbers employ the
floating point representation of the underlying system, and suffer from
rounding error, overflow, and similar floating-point issues.  Almost all
modern systems use IEEE-754 floating point, and it is typically portable
to assume IEEE-754 behavior these days.  IEEE-754 has positive and
negative infinity, distinguishes positive from negative zero, and uses
special values called NaNs to represent invalid computations such as
dividing zero by itself.  For more information, please see David
Goldberg's paper What Every Computer Scientist Should Know About
Floating-Point Arithmetic (http://www.validlab.com/goldberg/paper.pdf).

   Commands that accept floating point numbers as options, operands or
input use the standard C functions 'strtod' and 'strtold' to convert
from text to floating point numbers.  These floating point numbers
therefore can use scientific notation like '1.0e-34' and '-10e100'.
Modern C implementations also accept hexadecimal floating point numbers
such as '-0x.ep-3', which stands for -14/16 times 2^-3, which equals
-0.109375.  The 'LC_NUMERIC' locale determines the decimal-point
character.  *Note (libc)Parsing of Floats::.

File: coreutils.info,  Node: Signal specifications,  Next: Disambiguating names and IDs,  Prev: Floating point,  Up: Common options

2.5 Signal specifications
=========================

A SIGNAL may be a signal name like 'HUP', or a signal number like '1',
or an exit status of a process terminated by the signal.  A signal name
can be given in canonical form or prefixed by 'SIG'.  The case of the
letters is ignored.  The following signal names and numbers are
supported on all POSIX compliant systems:

'HUP'
     1.  Hangup.
'INT'
     2.  Terminal interrupt.
'QUIT'
     3.  Terminal quit.
'ABRT'
     6.  Process abort.
'KILL'
     9.  Kill (cannot be caught or ignored).
'ALRM'
     14.  Alarm Clock.
'TERM'
     15.  Termination.

Other supported signal names have system-dependent corresponding
numbers.  All systems conforming to POSIX 1003.1-2001 also support the
following signals:

'BUS'
     Access to an undefined portion of a memory object.
'CHLD'
     Child process terminated, stopped, or continued.
'CONT'
     Continue executing, if stopped.
'FPE'
     Erroneous arithmetic operation.
'ILL'
     Illegal Instruction.
'PIPE'
     Write on a pipe with no one to read it.
'SEGV'
     Invalid memory reference.
'STOP'
     Stop executing (cannot be caught or ignored).
'TSTP'
     Terminal stop.
'TTIN'
     Background process attempting read.
'TTOU'
     Background process attempting write.
'URG'
     High bandwidth data is available at a socket.
'USR1'
     User-defined signal 1.
'USR2'
     User-defined signal 2.

POSIX 1003.1-2001 systems that support the XSI extension also support
the following signals:

'POLL'
     Pollable event.
'PROF'
     Profiling timer expired.
'SYS'
     Bad system call.
'TRAP'
     Trace/breakpoint trap.
'VTALRM'
     Virtual timer expired.
'XCPU'
     CPU time limit exceeded.
'XFSZ'
     File size limit exceeded.

POSIX 1003.1-2001 systems that support the XRT extension also support at
least eight real-time signals called 'RTMIN', 'RTMIN+1', ..., 'RTMAX-1',
'RTMAX'.

File: coreutils.info,  Node: Disambiguating names and IDs,  Next: Random sources,  Prev: Signal specifications,  Up: Common options

2.6 chown and chgrp: Disambiguating user names and IDs
======================================================

Since the OWNER and GROUP arguments to 'chown' and 'chgrp' may be
specified as names or numeric IDs, there is an apparent ambiguity.  What
if a user or group _name_ is a string of digits?  (1) Should the command
interpret it as a user name or as an ID?  POSIX requires that 'chown'
and 'chgrp' first attempt to resolve the specified string as a name, and
only once that fails, then try to interpret it as an ID.  This is
troublesome when you want to specify a numeric ID, say 42, and it must
work even in a pathological situation where '42' is a user name that
maps to some other user ID, say 1000.  Simply invoking 'chown 42 F',
will set 'F's owner ID to 1000--not what you intended.

   GNU 'chown' and 'chgrp' provide a way to work around this, that at
the same time may result in a significant performance improvement by
eliminating a database look-up.  Simply precede each numeric user ID
and/or group ID with a '+', in order to force its interpretation as an
integer:

     chown +42 F
     chgrp +$numeric_group_id another-file
     chown +0:+0 /

   GNU 'chown' and 'chgrp' skip the name look-up process for each
'+'-prefixed string, because a string containing '+' is never a valid
user or group name.  This syntax is accepted on most common Unix
systems, but not on Solaris 10.

   ---------- Footnotes ----------

   (1) Using a number as a user name is common in some environments.

File: coreutils.info,  Node: Random sources,  Next: Target directory,  Prev: Disambiguating names and IDs,  Up: Common options

2.7 Sources of random data
==========================

The 'shuf', 'shred', and 'sort' commands sometimes need random data to
do their work.  For example, 'sort -R' must choose a hash function at
random, and it needs random data to make this selection.

   By default these commands use an internal pseudorandom generator
initialized by a small amount of entropy, but can be directed to use an
external source with the '--random-source=FILE' option.  An error is
reported if FILE does not contain enough bytes.

   For example, the device file '/dev/urandom' could be used as the
source of random data.  Typically, this device gathers environmental
noise from device drivers and other sources into an entropy pool, and
uses the pool to generate random bits.  If the pool is short of data,
the device reuses the internal pool to produce more bits, using a
cryptographically secure pseudorandom number generator.  But be aware
that this device is not designed for bulk random data generation and is
relatively slow.

   '/dev/urandom' suffices for most practical uses, but applications
requiring high-value or long-term protection of private data may require
an alternate data source like '/dev/random' or '/dev/arandom'.  The set
of available sources depends on your operating system.

   To reproduce the results of an earlier invocation of a command, you
can save some random data into a file and then use that file as the
random source in earlier and later invocations of the command.

File: coreutils.info,  Node: Target directory,  Next: Trailing slashes,  Prev: Random sources,  Up: Common options

2.8 Target directory
====================

The 'cp', 'install', 'ln', and 'mv' commands normally treat the last
operand specially when it is a directory or a symbolic link to a
directory.  For example, 'cp source dest' is equivalent to 'cp source
dest/source' if 'dest' is a directory.  Sometimes this behavior is not
exactly what is wanted, so these commands support the following options
to allow more fine-grained control:

'-T'
'--no-target-directory'
     Do not treat the last operand specially when it is a directory or a
     symbolic link to a directory.  This can help avoid race conditions
     in programs that operate in a shared area.  For example, when the
     command 'mv /tmp/source /tmp/dest' succeeds, there is no guarantee
     that '/tmp/source' was renamed to '/tmp/dest': it could have been
     renamed to '/tmp/dest/source' instead, if some other process
     created '/tmp/dest' as a directory.  However, if 'mv -T /tmp/source
     /tmp/dest' succeeds, there is no question that '/tmp/source' was
     renamed to '/tmp/dest'.

     In the opposite situation, where you want the last operand to be
     treated as a directory and want a diagnostic otherwise, you can use
     the '--target-directory' ('-t') option.

'-t DIRECTORY'
''--target-directory'=DIRECTORY'
     Use DIRECTORY as the directory component of each destination file
     name.

     The interface for most programs is that after processing options
     and a finite (possibly zero) number of fixed-position arguments,
     the remaining argument list is either expected to be empty, or is a
     list of items (usually files) that will all be handled identically.
     The 'xargs' program is designed to work well with this convention.

     The commands in the 'mv'-family are unusual in that they take a
     variable number of arguments with a special case at the _end_
     (namely, the target directory).  This makes it nontrivial to
     perform some operations, e.g., "move all files from here to ../d/",
     because 'mv * ../d/' might exhaust the argument space, and 'ls |
     xargs ...' doesn't have a clean way to specify an extra final
     argument for each invocation of the subject command.  (It can be
     done by going through a shell command, but that requires more human
     labor and brain power than it should.)

     The '--target-directory' ('-t') option allows the 'cp', 'install',
     'ln', and 'mv' programs to be used conveniently with 'xargs'.  For
     example, you can move the files from the current directory to a
     sibling directory, 'd' like this:

          ls | xargs mv -t ../d --

     However, this doesn't move files whose names begin with '.'.  If
     you use the GNU 'find' program, you can move those files too, with
     this command:

          find . -mindepth 1 -maxdepth 1 \
            | xargs mv -t ../d

     But both of the above approaches fail if there are no files in the
     current directory, or if any file has a name containing a blank or
     some other special characters.  The following example removes those
     limitations and requires both GNU 'find' and GNU 'xargs':

          find . -mindepth 1 -maxdepth 1 -print0 \
            | xargs --null --no-run-if-empty \
                mv -t ../d

The '--target-directory' ('-t') and '--no-target-directory' ('-T')
options cannot be combined.

File: coreutils.info,  Node: Trailing slashes,  Next: Traversing symlinks,  Prev: Target directory,  Up: Common options

2.9 Trailing slashes
====================

Some GNU programs (at least 'cp' and 'mv') allow you to remove any
trailing slashes from each SOURCE argument before operating on it.  The '--strip-trailing-slashes'
option enables this behavior.

   This is useful when a SOURCE argument may have a trailing slash and
specify a symbolic link to a directory.  This scenario is in fact rather
common because some shells can automatically append a trailing slash
when performing file name completion on such symbolic links.  Without
this option, 'mv', for example, (via the system's rename function) must
interpret a trailing slash as a request to dereference the symbolic link
and so must rename the indirectly referenced _directory_ and not the
symbolic link.  Although it may seem surprising that such behavior be
the default, it is required by POSIX and is consistent with other parts
of that standard.

File: coreutils.info,  Node: Traversing symlinks,  Next: Treating / specially,  Prev: Trailing slashes,  Up: Common options

2.10 Traversing symlinks
========================

The following options modify how 'chown' and 'chgrp' traverse a
hierarchy when the '--recursive' ('-R') option is also specified.  If
more than one of the following options is specified, only the final one
takes effect.  These options specify whether processing a symbolic link
to a directory entails operating on just the symbolic link or on all
files in the hierarchy rooted at that directory.

   These options are independent of '--dereference' and
'--no-dereference' ('-h'), which control whether to modify a symlink or
its referent.

'-H'
     If '--recursive' ('-R') is specified and a command line argument is
     a symbolic link to a directory, traverse it.

'-L'
     In a recursive traversal, traverse every symbolic link to a
     directory that is encountered.

'-P'
     Do not traverse any symbolic links.  This is the default if none of
     '-H', '-L', or '-P' is specified.

File: coreutils.info,  Node: Treating / specially,  Next: Special built-in utilities,  Prev: Traversing symlinks,  Up: Common options

2.11 Treating '/' specially
===========================

Certain commands can operate destructively on entire hierarchies.  For
example, if a user with appropriate privileges mistakenly runs 'rm -rf /
tmp/junk', that may remove all files on the entire system.  Since there
are so few legitimate uses for such a command, GNU 'rm' normally
declines to operate on any directory that resolves to '/'.  If you
really want to try to remove all the files on your system, you can use
the '--no-preserve-root' option, but the default behavior, specified by
the '--preserve-root' option, is safer for most purposes.

   The commands 'chgrp', 'chmod' and 'chown' can also operate
destructively on entire hierarchies, so they too support these options.
Although, unlike 'rm', they don't actually unlink files, these commands
are arguably more dangerous when operating recursively on '/', since
they often work much more quickly, and hence damage more files before an
alert user can interrupt them.  Tradition and POSIX require these
commands to operate recursively on '/', so they default to
'--no-preserve-root', but using the '--preserve-root' option makes them
safer for most purposes.  For convenience you can specify
'--preserve-root' in an alias or in a shell function.

   Note that the '--preserve-root' option also ensures that 'chgrp' and
'chown' do not modify '/' even when dereferencing a symlink pointing to
'/'.

File: coreutils.info,  Node: Special built-in utilities,  Next: Standards conformance,  Prev: Treating / specially,  Up: Common options

2.12 Special built-in utilities
===============================

Some programs like 'nice' can invoke other programs; for example, the
command 'nice cat file' invokes the program 'cat' by executing the
command 'cat file'.  However, "special built-in utilities" like 'exit'
cannot be invoked this way.  For example, the command 'nice exit' does
not have a well-defined behavior: it may generate an error message
instead of exiting.

   Here is a list of the special built-in utilities that are
standardized by POSIX 1003.1-2004.

     . : break continue eval exec exit export readonly return set shift
     times trap unset

   For example, because '.', ':', and 'exec' are special, the commands
'nice . foo.sh', 'nice :', and 'nice exec pwd' do not work as you might
expect.

   Many shells extend this list.  For example, Bash has several extra
special built-in utilities like 'history', and 'suspend', and with Bash
the command 'nice suspend' generates an error message instead of
suspending.

File: coreutils.info,  Node: Standards conformance,  Prev: Special built-in utilities,  Up: Common options

2.13 Standards conformance
==========================

In a few cases, the GNU utilities' default behavior is incompatible with
the POSIX standard.  To suppress these incompatibilities, define the
'POSIXLY_CORRECT' environment variable.  Unless you are checking for
POSIX conformance, you probably do not need to define 'POSIXLY_CORRECT'.

   Newer versions of POSIX are occasionally incompatible with older
versions.  For example, older versions of POSIX required the command
'sort +1' to sort based on the second and succeeding fields in each
input line, but starting with POSIX 1003.1-2001 the same command is
required to sort the file named '+1', and you must instead use the
command 'sort -k 2' to get the field-based sort.

   The GNU utilities normally conform to the version of POSIX that is
standard for your system.  To cause them to conform to a different
version of POSIX, define the '_POSIX2_VERSION' environment variable to a
value of the form YYYYMM specifying the year and month the standard was
adopted.  Three values are currently supported for '_POSIX2_VERSION':
'199209' stands for POSIX 1003.2-1992, '200112' stands for POSIX
1003.1-2001, and '200809' stands for POSIX 1003.1-2008.  For example, if
you have a newer system but are running software that assumes an older
version of POSIX and uses 'sort +1' or 'tail +10', you can work around
any compatibility problems by setting '_POSIX2_VERSION=199209' in your
environment.

