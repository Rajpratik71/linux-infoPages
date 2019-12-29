File: coreutils.info,  Node: mkfifo invocation,  Next: mknod invocation,  Prev: mkdir invocation,  Up: Special file types

12.4 ‘mkfifo’: Make FIFOs (named pipes)
=======================================

‘mkfifo’ creates FIFOs (also called “named pipes”) with the specified
names.  Synopsis:

     mkfifo [OPTION] NAME...

   A “FIFO” is a special file type that permits independent processes to
communicate.  One process opens the FIFO file for writing, and another
for reading, after which data can flow as with the usual anonymous pipe
in shells or elsewhere.

   The program accepts the following options.  Also see *note Common
options::.

‘-m MODE’
‘--mode=MODE’
     Set the mode of created FIFOs to MODE, which is symbolic as in
     ‘chmod’ and uses ‘a=rw’ (read and write allowed for everyone) for
     the point of departure.  MODE should specify only file permission
     bits.  *Note File permissions::.

‘-Z’
‘--context[=CONTEXT]’
     Without a specified CONTEXT, adjust the SELinux security context
     according to the system default type for destination files,
     similarly to the ‘restorecon’ command.  The long form of this
     option with a specific context specified, will set the context for
     newly created files only.  With a specified context, if both
     SELinux and SMACK are disabled, a warning is issued.

   An exit status of zero indicates success, and a nonzero value
indicates failure.

