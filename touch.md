File: coreutils.info,  Node: touch invocation,  Prev: chmod invocation,  Up: Changing file attributes

13.4 ‘touch’: Change file timestamps
====================================

‘touch’ changes the access and/or modification timestamps of the
specified files.  Synopsis:

     touch [OPTION]... FILE...

   Any FILE argument that does not exist is created empty, unless option
‘--no-create’ (‘-c’) or ‘--no-dereference’ (‘-h’) was in effect.

   A FILE argument string of ‘-’ is handled specially and causes ‘touch’
to change the times of the file associated with standard output.

   By default, ‘touch’ sets file timestamps to the current time.
Because ‘touch’ acts on its operands left to right, the resulting
timestamps of earlier and later operands may disagree.

   When setting file timestamps to the current time, ‘touch’ can change
the timestamps for files that the user does not own but has write
permission for.  Otherwise, the user must own the files.  Some older
systems have a further restriction: the user must own the files unless
both the access and modification timestamps are being set to the current
time.

   The ‘touch’ command cannot set a file’s status change timestamp to a
user-specified value, and cannot change the file’s birth time (if
supported) at all.  Also, ‘touch’ has issues similar to those affecting
all programs that update file timestamps.  For example, ‘touch’ may set
a file’s timestamp to a value that differs slightly from the requested
time.  *Note File timestamps::.

   Timestamps assume the time zone rules specified by the ‘TZ’
environment variable, or by the system default rules if ‘TZ’ is not set.
*Note Specifying the Time Zone with ‘TZ’: (libc)TZ Variable.  You can
avoid ambiguities during daylight saving transitions by using UTC
timestamps.

   The program accepts the following options.  Also see *note Common
options::.

‘-a’
‘--time=atime’
‘--time=access’
‘--time=use’
     Change the access timestamp only.  *Note File timestamps::.

‘-c’
‘--no-create’
     Do not warn about or create files that do not exist.

‘-d TIME’
‘--date=TIME’
     Use TIME instead of the current time.  It can contain month names,
     time zones, ‘am’ and ‘pm’, ‘yesterday’, etc.  For example,
     ‘--date="2004-02-27 14:19:13.489392193 +0530"’ specifies the
     instant of time that is 489,392,193 nanoseconds after February 27,
     2004 at 2:19:13 PM in a time zone that is 5 hours and 30 minutes
     east of UTC.  *Note Date input formats::.  File systems that do not
     support high-resolution timestamps silently ignore any excess
     precision here.

‘-f’
     Ignored; for compatibility with BSD versions of ‘touch’.

‘-h’
‘--no-dereference’
     Attempt to change the timestamps of a symbolic link, rather than
     what the link refers to.  When using this option, empty files are
     not created, but option ‘-c’ must also be used to avoid warning
     about files that do not exist.  Not all systems support changing
     the timestamps of symlinks, since underlying system support for
     this action was not required until POSIX 2008.  Also, on some
     systems, the mere act of examining a symbolic link changes the
     access timestamp, such that only changes to the modification
     timestamp will persist long enough to be observable.  When coupled
     with option ‘-r’, a reference timestamp is taken from a symbolic
     link rather than the file it refers to.

‘-m’
‘--time=mtime’
‘--time=modify’
     Change the modification timestamp only.

‘-r FILE’
‘--reference=FILE’
     Use the times of the reference FILE instead of the current time.
     If this option is combined with the ‘--date=TIME’ (‘-d TIME’)
     option, the reference FILE’s time is the origin for any relative
     TIMEs given, but is otherwise ignored.  For example, ‘-r foo -d '-5
     seconds'’ specifies a timestamp equal to five seconds before the
     corresponding timestamp for ‘foo’.  If FILE is a symbolic link, the
     reference timestamp is taken from the target of the symlink, unless
     ‘-h’ was also in effect.

‘-t [[CC]YY]MMDDHHMM[.SS]’
     Use the argument (optional four-digit or two-digit years, months,
     days, hours, minutes, optional seconds) instead of the current
     time.  If the year is specified with only two digits, then CC is 20
     for years in the range 0 ... 68, and 19 for years in 69 ... 99.  If
     no digits of the year are specified, the argument is interpreted as
     a date in the current year.  On the atypical systems that support
     leap seconds, SS may be ‘60’.

   On systems predating POSIX 1003.1-2001, ‘touch’ supports an obsolete
syntax, as follows.  If no timestamp is given with any of the ‘-d’,
‘-r’, or ‘-t’ options, and if there are two or more FILEs and the first
FILE is of the form ‘MMDDHHMM[YY]’ and this would be a valid argument to
the ‘-t’ option (if the YY, if any, were moved to the front), and if the
represented year is in the range 1969–1999, that argument is interpreted
as the time for the other files instead of as a file name.  Although
this obsolete behavior can be controlled with the ‘_POSIX2_VERSION’
environment variable (*note Standards conformance::), portable scripts
should avoid commands whose behavior depends on this variable.  For
example, use ‘touch ./12312359 main.c’ or ‘touch -t 12312359 main.c’
rather than the ambiguous ‘touch 12312359 main.c’.

   An exit status of zero indicates success, and a nonzero value
indicates failure.

