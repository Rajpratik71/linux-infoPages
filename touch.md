File: coreutils.info,  Node: touch invocation,  Prev: chmod invocation,  Up: Changing file attributes

13.4 'touch': Change file timestamps
====================================

'touch' changes the access and/or modification times of the specified
files.  Synopsis:

     touch [OPTION]... FILE...

   Any FILE argument that does not exist is created empty, unless option
'--no-create' ('-c') or '--no-dereference' ('-h') was in effect.

   A FILE argument string of '-' is handled specially and causes 'touch'
to change the times of the file associated with standard output.

   By default, 'touch' sets file timestamps to the current time.
Because 'touch' acts on its operands left to right, the resulting
timestamps of earlier and later operands may disagree.  Also, the
determination of what time is "current" depends on the platform.
Platforms with network file systems often use different clocks for the
operating system and for file systems; because 'touch' typically uses
file systems' clocks by default, clock skew can cause the resulting file
timestamps to appear to be in a program's "future" or "past".

   The 'touch' command sets the file's timestamp to the greatest
representable value that is not greater than the requested time.  This
can differ from the requested time for several reasons.  First, the
requested time may have a higher resolution than supported.  Second, a
file system may use different resolutions for different types of times.
Third, file timestamps may use a different resolution than operating
system timestamps.  Fourth, the operating system primitives used to
update timestamps may employ yet a different resolution.  For example,
in theory a file system might use 10-microsecond resolution for access
time and 100-nanosecond resolution for modification time, and the
operating system might use nanosecond resolution for the current time
and microsecond resolution for the primitive that 'touch' uses to set a
file's timestamp to an arbitrary value.

   When setting file timestamps to the current time, 'touch' can change
the timestamps for files that the user does not own but has write
permission for.  Otherwise, the user must own the files.  Some older
systems have a further restriction: the user must own the files unless
both the access and modification times are being set to the current
time.

   Although 'touch' provides options for changing two of the times--the
times of last access and modification--of a file, there is actually a
standard third one as well: the inode change time.  This is often
referred to as a file's 'ctime'.  The inode change time represents the
time when the file's meta-information last changed.  One common example
of this is when the permissions of a file change.  Changing the
permissions doesn't access the file, so the atime doesn't change, nor
does it modify the file, so the mtime doesn't change.  Yet, something
about the file itself has changed, and this must be noted somewhere.
This is the job of the ctime field.  This is necessary, so that, for
example, a backup program can make a fresh copy of the file, including
the new permissions value.  Another operation that modifies a file's
ctime without affecting the others is renaming.  In any case, it is not
possible, in normal operations, for a user to change the ctime field to
a user-specified value.  Some operating systems and file systems support
a fourth time: the birth time, when the file was first created; by
definition, this timestamp never changes.

   Time stamps assume the time zone rules specified by the 'TZ'
environment variable, or by the system default rules if 'TZ' is not set.
*Note Specifying the Time Zone with 'TZ': (libc)TZ Variable.  You can
avoid ambiguities during daylight saving transitions by using UTC time
stamps.

   The program accepts the following options.  Also see *note Common
options::.

'-a'
'--time=atime'
'--time=access'
'--time=use'
     Change the access time only.

'-c'
'--no-create'
     Do not warn about or create files that do not exist.

'-d'
'--date=TIME'
     Use TIME instead of the current time.  It can contain month names,
     time zones, 'am' and 'pm', 'yesterday', etc.  For example,
     '--date="2004-02-27 14:19:13.489392193 +0530"' specifies the
     instant of time that is 489,392,193 nanoseconds after February 27,
     2004 at 2:19:13 PM in a time zone that is 5 hours and 30 minutes
     east of UTC.  *Note Date input formats::.  File systems that do not
     support high-resolution time stamps silently ignore any excess
     precision here.

'-f'
     Ignored; for compatibility with BSD versions of 'touch'.

'-h'
'--no-dereference'
     Attempt to change the timestamps of a symbolic link, rather than
     what the link refers to.  When using this option, empty files are
     not created, but option '-c' must also be used to avoid warning
     about files that do not exist.  Not all systems support changing
     the timestamps of symlinks, since underlying system support for
     this action was not required until POSIX 2008.  Also, on some
     systems, the mere act of examining a symbolic link changes the
     access time, such that only changes to the modification time will
     persist long enough to be observable.  When coupled with option
     '-r', a reference timestamp is taken from a symbolic link rather
     than the file it refers to.

'-m'
'--time=mtime'
'--time=modify'
     Change the modification time only.

'-r FILE'
'--reference=FILE'
     Use the times of the reference FILE instead of the current time.
     If this option is combined with the '--date=TIME' ('-d TIME')
     option, the reference FILE's time is the origin for any relative
     TIMEs given, but is otherwise ignored.  For example, '-r foo -d '-5
     seconds'' specifies a time stamp equal to five seconds before the
     corresponding time stamp for 'foo'.  If FILE is a symbolic link,
     the reference timestamp is taken from the target of the symlink,
     unless '-h' was also in effect.

'-t [[CC]YY]MMDDHHMM[.SS]'
     Use the argument (optional four-digit or two-digit years, months,
     days, hours, minutes, optional seconds) instead of the current
     time.  If the year is specified with only two digits, then CC is 20
     for years in the range 0 ... 68, and 19 for years in 69 ... 99.  If
     no digits of the year are specified, the argument is interpreted as
     a date in the current year.  On the atypical systems that support
     leap seconds, SS may be '60'.

   On older systems, 'touch' supports an obsolete syntax, as follows.
If no timestamp is given with any of the '-d', '-r', or '-t' options,
and if there are two or more FILEs and the first FILE is of the form
'MMDDHHMM[YY]' and this would be a valid argument to the '-t' option (if
the YY, if any, were moved to the front), and if the represented year is
in the range 1969-1999, that argument is interpreted as the time for the
other files instead of as a file name.  This obsolete behavior can be
enabled or disabled with the '_POSIX2_VERSION' environment variable
(*note Standards conformance::), but portable scripts should avoid
commands whose behavior depends on this variable.  For example, use
'touch ./12312359 main.c' or 'touch -t 12312359 main.c' rather than the
ambiguous 'touch 12312359 main.c'.

   An exit status of zero indicates success, and a nonzero value
indicates failure.

