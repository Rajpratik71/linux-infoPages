File: coreutils.info,  Node: hostname invocation,  Next: hostid invocation,  Prev: uname invocation,  Up: System context

21.5 'hostname': Print or set system name
=========================================

With no arguments, 'hostname' prints the name of the current host
system.  With one argument, it sets the current host name to the
specified string.  You must have appropriate privileges to set the host
name.  Synopsis:

     hostname [NAME]

   The only options are '--help' and '--version'.  *Note Common
options::.

   An exit status of zero indicates success, and a nonzero value
indicates failure.

