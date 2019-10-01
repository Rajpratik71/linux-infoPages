File: coreutils.info,  Node: chgrp invocation,  Next: chmod invocation,  Prev: chown invocation,  Up: Changing file attributes

13.2 'chgrp': Change group ownership
====================================

'chgrp' changes the group ownership of each given FILE to GROUP (which
can be either a group name or a numeric group ID) or to the group of an
existing reference file.  Synopsis:

     chgrp [OPTION]... {GROUP | --reference=REF_FILE} FILE...

   If GROUP is intended to represent a numeric group ID, then you may
specify it with a leading '+'.  *Note Disambiguating names and IDs::.

   The program accepts the following options.  Also see *note Common
options::.

'-c'
'--changes'
     Verbosely describe the action for each FILE whose group actually
     changes.

'-f'
'--silent'
'--quiet'
     Do not print error messages about files whose group cannot be
     changed.

'--dereference'
     Do not act on symbolic links themselves but rather on what they
     point to.  This is the default.

'-h'
'--no-dereference'
     Act on symbolic links themselves instead of what they point to.
     This mode relies on the 'lchown' system call.  On systems that do
     not provide the 'lchown' system call, 'chgrp' fails when a file
     specified on the command line is a symbolic link.  By default, no
     diagnostic is issued for symbolic links encountered during a
     recursive traversal, but see '--verbose'.

'--preserve-root'
     Fail upon any attempt to recursively change the root directory,
     '/'.  Without '--recursive', this option has no effect.  *Note
     Treating / specially::.

'--no-preserve-root'
     Cancel the effect of any preceding '--preserve-root' option.  *Note
     Treating / specially::.

'--reference=REF_FILE'
     Change the group of each FILE to be the same as that of REF_FILE.
     If REF_FILE is a symbolic link, do not use the group of the
     symbolic link, but rather that of the file it refers to.

'-v'
'--verbose'
     Output a diagnostic for every file processed.  If a symbolic link
     is encountered during a recursive traversal on a system without the
     'lchown' system call, and '--no-dereference' is in effect, then
     issue a diagnostic saying neither the symbolic link nor its
     referent is being changed.

'-R'
'--recursive'
     Recursively change the group ownership of directories and their
     contents.

'-H'
     If '--recursive' ('-R') is specified and a command line argument is
     a symbolic link to a directory, traverse it.  *Note Traversing
     symlinks::.

'-L'
     In a recursive traversal, traverse every symbolic link to a
     directory that is encountered.  *Note Traversing symlinks::.

'-P'
     Do not traverse any symbolic links.  This is the default if none of
     '-H', '-L', or '-P' is specified.  *Note Traversing symlinks::.

   An exit status of zero indicates success, and a nonzero value
indicates failure.

   Examples:

     # Change the group of /u to "staff".
     chgrp staff /u

     # Change the group of /u and subfiles to "staff".
     chgrp -hR staff /u

