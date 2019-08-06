File: coreutils.info,  Node: chcon invocation,  Next: runcon invocation,  Up: SELinux context

22.1 `chcon': Change SELinux context of file
============================================

`chcon' changes the SELinux security context of the selected files.
Synopses:

     chcon [OPTION]... CONTEXT FILE...
     chcon [OPTION]... [-u USER] [-r ROLE] [-l RANGE] [-t TYPE] FILE...
     chcon [OPTION]... --reference=RFILE FILE...

   Change the SELinux security context of each FILE to CONTEXT.  With
`--reference', change the security context of each FILE to that of
RFILE.

   The program accepts the following options.  Also see *note Common
options::.

`--dereference'
     Do not affect symbolic links but what they refer to; this is the
     default.

`-h'
`--no-dereference'
     Affect the symbolic links themselves instead of any referenced
     file.

`--reference=RFILE'
     Use RFILE's security context rather than specifying a CONTEXT
     value.

`-R'
`--recursive'
     Operate on files and directories recursively.

`--preserve-root'
     Refuse to operate recursively on the root directory, `/', when
     used together with the `--recursive' option.  *Note Treating /
     specially::.

`--no-preserve-root'
     Do not treat the root directory, `/', specially when operating
     recursively; this is the default.  *Note Treating / specially::.

`-H'
     If `--recursive' (`-R') is specified and a command line argument
     is a symbolic link to a directory, traverse it.  *Note Traversing
     symlinks::.

`-L'
     In a recursive traversal, traverse every symbolic link to a
     directory that is encountered.  *Note Traversing symlinks::.

`-P'
     Do not traverse any symbolic links.  This is the default if none
     of `-H', `-L', or `-P' is specified.  *Note Traversing symlinks::.

`-v'
`--verbose'
     Output a diagnostic for every file processed.

`-u USER'
`--user=USER'
     Set user USER in the target security context.

`-r ROLE'
`--role=ROLE'
     Set role ROLE in the target security context.

`-t TYPE'
`--type=TYPE'
     Set type TYPE in the target security context.

`-l RANGE'
`--range=RANGE'
     Set range RANGE in the target security context.


   An exit status of zero indicates success, and a nonzero value
indicates failure.

