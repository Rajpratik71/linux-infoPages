File: libc.info,  Node: Signaling Yourself,  Next: Signaling Another Process,  Up: Generating Signals

24.6.1 Signaling Yourself
-------------------------

A process can send itself a signal with the 'raise' function.  This
function is declared in 'signal.h'.

 -- Function: int raise (int SIGNUM)
     Preliminary: | MT-Safe | AS-Safe | AC-Safe | *Note POSIX Safety
     Concepts::.

     The 'raise' function sends the signal SIGNUM to the calling
     process.  It returns zero if successful and a nonzero value if it
     fails.  About the only reason for failure would be if the value of
     SIGNUM is invalid.

 -- Function: int gsignal (int SIGNUM)
     Preliminary: | MT-Safe | AS-Safe | AC-Safe | *Note POSIX Safety
     Concepts::.

     The 'gsignal' function does the same thing as 'raise'; it is
     provided only for compatibility with SVID.

   One convenient use for 'raise' is to reproduce the default behavior
of a signal that you have trapped.  For instance, suppose a user of your
program types the SUSP character (usually 'C-z'; *note Special
Characters::) to send it an interactive stop signal ('SIGTSTP'), and you
want to clean up some internal data buffers before stopping.  You might
set this up like this:

     #include <signal.h>

     /* When a stop signal arrives, set the action back to the default
        and then resend the signal after doing cleanup actions. */

     void
     tstp_handler (int sig)
     {
       signal (SIGTSTP, SIG_DFL);
       /* Do cleanup actions here. */
       ...
       raise (SIGTSTP);
     }

     /* When the process is continued again, restore the signal handler. */

     void
     cont_handler (int sig)
     {
       signal (SIGCONT, cont_handler);
       signal (SIGTSTP, tstp_handler);
     }

     /* Enable both handlers during program initialization. */

     int
     main (void)
     {
       signal (SIGCONT, cont_handler);
       signal (SIGTSTP, tstp_handler);
       ...
     }

   *Portability note:* 'raise' was invented by the ISO C committee.
Older systems may not support it, so using 'kill' may be more portable.
*Note Signaling Another Process::.

