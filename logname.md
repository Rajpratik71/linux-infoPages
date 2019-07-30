Next: whoami invocation,  Prev: id invocation,  Up: User information

20.2 ‘logname’: Print current login name
========================================

‘logname’ prints the calling user’s name, as found in a
system-maintained file (often ‘/var/run/utmp’ or ‘/etc/utmp’), and exits
with a status of 0.  If there is no entry for the calling process,
‘logname’ prints an error message and exits with a status of 1.

   The only options are ‘--help’ and ‘--version’.  *Note Common
options::.

   An exit status of zero indicates success, and a nonzero value
indicates failure.

