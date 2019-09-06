File: coreutils.info,  Node: id invocation,  Next: logname invocation,  Up: User information

20.1 `id': Print user identity
==============================

`id' prints information about the given user, or the process running it
if no user is specified.  Synopsis:

     id [OPTION]... [USER]

   USER can be either a user ID or a name, with name look-up taking
precedence unless the ID is specified with a leading `+'.  *Note
Disambiguating names and IDs::.

   By default, it prints the real user ID, real group ID, effective
user ID if different from the real user ID, effective group ID if
different from the real group ID, and supplemental group IDs.  In
addition, if SELinux is enabled and the `POSIXLY_CORRECT' environment
variable is not set, then print `context=C', where C is the security
context.

   Each of these numeric values is preceded by an identifying string and
followed by the corresponding user or group name in parentheses.

   The options cause `id' to print only part of the above information.
Also see *note Common options::.

`-g'
`--group'
     Print only the group ID.

`-G'
`--groups'
     Print only the group ID and the supplementary groups.

`-n'
`--name'
     Print the user or group name instead of the ID number.  Requires
     `-u', `-g', or `-G'.

`-r'
`--real'
     Print the real, instead of effective, user or group ID.  Requires
     `-u', `-g', or `-G'.

`-u'
`--user'
     Print only the user ID.

`-Z'
`--context'
     Print only the security context of the process, which is generally
     the user's security context inherited from the parent process.  If
     neither SELinux or SMACK is enabled then print a warning and set
     the exit status to 1.

`-z'
`--zero'
     Delimit output items with NUL characters.  This option is not
     permitted when using the default format.

     Example:
          $ id -Gn --zero
          users <NUL> devs <NUL>


   Primary and supplementary groups for a process are normally inherited
from its parent and are usually unchanged since login.  This means that
if you change the group database after logging in, `id' will not
reflect your changes within your existing login session.  Running `id'
with a user argument causes the user and group database to be consulted
afresh, and so will give a different result.

   An exit status of zero indicates success, and a nonzero value
indicates failure.

