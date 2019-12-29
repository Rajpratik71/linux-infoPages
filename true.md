File: coreutils.info,  Node: true invocation,  Next: test invocation,  Prev: false invocation,  Up: Conditions

16.2 ‘true’: Do nothing, successfully
=====================================

‘true’ does nothing except return an exit status of 0, meaning
“success”.  It can be used as a place holder in shell scripts where a
successful command is needed, although the shell built-in command ‘:’
(colon) may do the same thing faster.  In most modern shells, ‘true’ is
a built-in command, so when you use ‘true’ in a script, you’re probably
using the built-in command, not the one documented here.

   ‘true’ honors the ‘--help’ and ‘--version’ options.

   Note, however, that it is possible to cause ‘true’ to exit with
nonzero status: with the ‘--help’ or ‘--version’ option, and with
standard output already closed or redirected to a file that evokes an
I/O error.  For example, using a Bourne-compatible shell:

     $ ./true --version >&-
     ./true: write error: Bad file number
     $ ./true --version > /dev/full
     ./true: write error: No space left on device

   This version of ‘true’ is implemented as a C program, and is thus
more secure and faster than a shell script implementation, and may
safely be used as a dummy shell for the purpose of disabling accounts.

