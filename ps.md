File: libc.info,  Node: Signal Messages,  Prev: Miscellaneous Signals,  Up: Standard Signals

24.2.8 Signal Messages
----------------------

We mentioned above that the shell prints a message describing the signal
that terminated a child process.  The clean way to print a message
describing a signal is to use the functions 'strsignal' and 'psignal'.
These functions use a signal number to specify which kind of signal to
describe.  The signal number may come from the termination status of a
child process (*note Process Completion::) or it may come from a signal
handler in the same process.

 -- Function: char * strsignal (int SIGNUM)
     Preliminary: | MT-Unsafe race:strsignal locale | AS-Unsafe init
     i18n corrupt heap | AC-Unsafe init corrupt mem | *Note POSIX Safety
     Concepts::.

     This function returns a pointer to a statically-allocated string
     containing a message describing the signal SIGNUM.  You should not
     modify the contents of this string; and, since it can be rewritten
     on subsequent calls, you should save a copy of it if you need to
     reference it later.

     This function is a GNU extension, declared in the header file
     'string.h'.

 -- Function: void psignal (int SIGNUM, const char *MESSAGE)
     Preliminary: | MT-Safe locale | AS-Unsafe corrupt i18n heap |
     AC-Unsafe lock corrupt mem | *Note POSIX Safety Concepts::.

     This function prints a message describing the signal SIGNUM to the
     standard error output stream 'stderr'; see *note Standard
     Streams::.

     If you call 'psignal' with a MESSAGE that is either a null pointer
     or an empty string, 'psignal' just prints the message corresponding
     to SIGNUM, adding a trailing newline.

     If you supply a non-null MESSAGE argument, then 'psignal' prefixes
     its output with this string.  It adds a colon and a space character
     to separate the MESSAGE from the string corresponding to SIGNUM.

     This function is a BSD feature, declared in the header file
     'signal.h'.

   There is also an array 'sys_siglist' which contains the messages for
the various signal codes.  This array exists on BSD systems, unlike
'strsignal'.

