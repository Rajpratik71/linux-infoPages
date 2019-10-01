File: coreutils.info,  Node: users invocation,  Next: who invocation,  Prev: groups invocation,  Up: User information

20.5 'users': Print login names of users currently logged in
============================================================

'users' prints on a single line a blank-separated list of user names of
users currently logged in to the current host.  Each user name
corresponds to a login session, so if a user has more than one login
session, that user's name will appear the same number of times in the
output.  Synopsis:

     users [FILE]

   With no FILE argument, 'users' extracts its information from a
system-maintained file (often '/var/run/utmp' or '/var/run/utmp').  If a
file argument is given, 'users' uses that file instead.  A common choice
is '/var/log/wtmp'.

   The only options are '--help' and '--version'.  *Note Common
options::.

   An exit status of zero indicates success, and a nonzero value
indicates failure.

