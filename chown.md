Next: chgrp invocation,  Up: Changing file attributes

13.1 ‘chown’: Change file owner and group
=========================================

‘chown’ changes the user and/or group ownership of each given FILE to
NEW-OWNER or to the user and group of an existing reference file.
Synopsis:

     chown [OPTION]... {NEW-OWNER | --reference=REF_FILE} FILE...

   If used, NEW-OWNER specifies the new owner and/or group as follows
(with no embedded white space):

     [OWNER] [ : [GROUP] ]

   Specifically:

OWNER
     If only an OWNER (a user name or numeric user ID) is given, that
     user is made the owner of each given file, and the files’ group is
     not changed.

OWNER‘:’GROUP
     If the OWNER is followed by a colon and a GROUP (a group name or
     numeric group ID), with no spaces between them, the group ownership
     of the files is changed as well (to GROUP).

OWNER‘:’
     If a colon but no group name follows OWNER, that user is made the
     owner of the files and the group of the files is changed to OWNER’s
     login group.

‘:’GROUP
     If the colon and following GROUP are given, but the owner is
     omitted, only the group of the files is changed; in this case,
     ‘chown’ performs the same function as ‘chgrp’.

‘:’
     If only a colon is given, or if NEW-OWNER is empty, neither the
     owner nor the group is changed.

   If OWNER or GROUP is intended to represent a numeric user or group
ID, then you may specify it with a leading ‘+’.  *Note Disambiguating
names and IDs::.

   Some older scripts may still use ‘.’ in place of the ‘:’ separator.
POSIX 1003.1-2001 (*note Standards conformance::) does not require
support for that, but for backward compatibility GNU ‘chown’ supports
‘.’ so long as no ambiguity results.  New scripts should avoid the use
of ‘.’ because it is not portable, and because it has undesirable
results if the entire OWNER‘.’GROUP happens to identify a user whose
name contains ‘.’.

   It is system dependent whether a user can change the group to an
arbitrary one, or the more portable behavior of being restricted to
setting a group of which the user is a member.

   The ‘chown’ command sometimes clears the set-user-ID or set-group-ID
permission bits.  This behavior depends on the policy and functionality
of the underlying ‘chown’ system call, which may make system-dependent
file mode modifications outside the control of the ‘chown’ command.  For
example, the ‘chown’ command might not affect those bits when invoked by
a user with appropriate privileges, or when the bits signify some
function other than executable permission (e.g., mandatory locking).
When in doubt, check the underlying system behavior.

   The program accepts the following options.  Also see *note Common
options::.

‘-c’
‘--changes’
     Verbosely describe the action for each FILE whose ownership
     actually changes.

‘-f’
‘--silent’
‘--quiet’
     Do not print error messages about files whose ownership cannot be
     changed.

‘--from=OLD-OWNER’
     Change a FILE’s ownership only if it has current attributes
     specified by OLD-OWNER.  OLD-OWNER has the same form as NEW-OWNER
     described above.  This option is useful primarily from a security
     standpoint in that it narrows considerably the window of potential
     abuse.  For example, to reflect a user ID numbering change for one
     user’s files without an option like this, ‘root’ might run

          find / -owner OLDUSER -print0 | xargs -0 chown -h NEWUSER

     But that is dangerous because the interval between when the ‘find’
     tests the existing file’s owner and when the ‘chown’ is actually
     run may be quite large.  One way to narrow the gap would be to
     invoke chown for each file as it is found:

          find / -owner OLDUSER -exec chown -h NEWUSER {} \;

     But that is very slow if there are many affected files.  With this
     option, it is safer (the gap is narrower still) though still not
     perfect:

          chown -h -R --from=OLDUSER NEWUSER /

‘--dereference’
     Do not act on symbolic links themselves but rather on what they
     point to.  This is the default.

‘-h’
‘--no-dereference’
     Act on symbolic links themselves instead of what they point to.
     This mode relies on the ‘lchown’ system call.  On systems that do
     not provide the ‘lchown’ system call, ‘chown’ fails when a file
     specified on the command line is a symbolic link.  By default, no
     diagnostic is issued for symbolic links encountered during a
     recursive traversal, but see ‘--verbose’.

‘--preserve-root’
     Fail upon any attempt to recursively change the root directory,
     ‘/’.  Without ‘--recursive’, this option has no effect.  *Note
     Treating / specially::.

‘--no-preserve-root’
     Cancel the effect of any preceding ‘--preserve-root’ option.  *Note
     Treating / specially::.

‘--reference=REF_FILE’
     Change the user and group of each FILE to be the same as those of
     REF_FILE.  If REF_FILE is a symbolic link, do not use the user and
     group of the symbolic link, but rather those of the file it refers
     to.

‘-v’
‘--verbose’
     Output a diagnostic for every file processed.  If a symbolic link
     is encountered during a recursive traversal on a system without the
     ‘lchown’ system call, and ‘--no-dereference’ is in effect, then
     issue a diagnostic saying neither the symbolic link nor its
     referent is being changed.

‘-R’
‘--recursive’
     Recursively change ownership of directories and their contents.

‘-H’
     If ‘--recursive’ (‘-R’) is specified and a command line argument is
     a symbolic link to a directory, traverse it.  *Note Traversing
     symlinks::.

‘-L’
     In a recursive traversal, traverse every symbolic link to a
     directory that is encountered.  *Note Traversing symlinks::.

‘-P’
     Do not traverse any symbolic links.  This is the default if none of
     ‘-H’, ‘-L’, or ‘-P’ is specified.  *Note Traversing symlinks::.

   An exit status of zero indicates success, and a nonzero value
indicates failure.

   Examples:

     # Change the owner of /u to "root".
     chown root /u

     # Likewise, but also change its group to "staff".
     chown root:staff /u

     # Change the owner of /u and subfiles to "root".
     chown -hR root /u

