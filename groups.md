File: coreutils.info,  Node: groups invocation,  Next: users invocation,  Prev: whoami invocation,  Up: User information

20.4 `groups': Print group names a user is in
=============================================

`groups' prints the names of the primary and any supplementary groups
for each given USERNAME, or the current process if no names are given.
If more than one name is given, the name of each user is printed before
the list of that user's groups and the user name is separated from the
group list by a colon.  Synopsis:

     groups [USERNAME]...

   The group lists are equivalent to the output of the command `id -Gn'.

   The only options are `--help' and `--version'.  *Note Common
options::.

   Primary and supplementary groups for a process are normally inherited
from its parent and are usually unchanged since login.  This means that
if you change the group database after logging in, `groups' will not
reflect your changes within your existing login session.  Running
`groups' with a list of users causes the user and group database to be
consulted afresh, and so will give a different result.

   An exit status of zero indicates success, and a nonzero value
indicates failure.

