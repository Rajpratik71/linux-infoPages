File: coreutils.info,  Node: who invocation,  Prev: users invocation,  Up: User information

20.6 ‘who’: Print who is currently logged in
============================================

‘who’ prints information about users who are currently logged on.
Synopsis:

     who [OPTION] [FILE] [am i]

   If given no non-option arguments, ‘who’ prints the following
information for each user currently logged on: login name, terminal
line, login time, and remote hostname or X display.

   If given one non-option argument, ‘who’ uses that instead of a
default system-maintained file (often ‘/var/run/utmp’ or ‘/etc/utmp’) as
the name of the file containing the record of users logged on.
‘/var/log/wtmp’ is commonly given as an argument to ‘who’ to look at who
has previously logged on.

   If given two non-option arguments, ‘who’ prints only the entry for
the user running it (determined from its standard input), preceded by
the hostname.  Traditionally, the two arguments given are ‘am i’, as in
‘who am i’.

   Timestamps are listed according to the time zone rules specified by
the ‘TZ’ environment variable, or by the system default rules if ‘TZ’ is
not set.  *Note Specifying the Time Zone with ‘TZ’: (libc)TZ Variable.

   The program accepts the following options.  Also see *note Common
options::.

‘-a’
‘--all’
     Same as ‘-b -d --login -p -r -t -T -u’.

‘-b’
‘--boot’
     Print the date and time of last system boot.

‘-d’
‘--dead’
     Print information corresponding to dead processes.

‘-H’
‘--heading’
     Print a line of column headings.

‘-l’
‘--login’
     List only the entries that correspond to processes via which the
     system is waiting for a user to login.  The user name is always
     ‘LOGIN’.

‘--lookup’
     Attempt to canonicalize hostnames found in utmp through a DNS
     lookup.  This is not the default because it can cause significant
     delays on systems with automatic dial-up internet access.

‘-m’
     Same as ‘who am i’.

‘-p’
‘--process’
     List active processes spawned by init.

‘-q’
‘--count’
     Print only the login names and the number of users logged on.
     Overrides all other options.

‘-r’
‘--runlevel’
     Print the current (and maybe previous) run-level of the init
     process.

‘-s’
     Ignored; for compatibility with other versions of ‘who’.

‘-t’
‘--time’
     Print last system clock change.

‘-u’
     After the login time, print the number of hours and minutes that
     the user has been idle.  ‘.’ means the user was active in the last
     minute.  ‘old’ means the user has been idle for more than 24 hours.

‘-w’
‘-T’
‘--mesg’
‘--message’
‘--writable’
     After each login name print a character indicating the user’s
     message status:

          ‘+’ allowing ‘write’ messages
          ‘-’ disallowing ‘write’ messages
          ‘?’ cannot find terminal device

   The ‘who’ command is installed only on platforms with the POSIX
‘<utmpx.h>’ include file or equivalent, so portable scripts should not
rely on its existence on non-POSIX platforms.

   An exit status of zero indicates success, and a nonzero value
indicates failure.

