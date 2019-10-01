File: libc.info,  Node: Aborting a Program,  Next: Termination Internals,  Prev: Cleanups on Exit,  Up: Program Termination

25.7.4 Aborting a Program
-------------------------

You can abort your program using the 'abort' function.  The prototype
for this function is in 'stdlib.h'.

 -- Function: void abort (void)
     Preliminary: | MT-Safe | AS-Unsafe corrupt | AC-Unsafe lock corrupt
     | *Note POSIX Safety Concepts::.

     The 'abort' function causes abnormal program termination.  This
     does not execute cleanup functions registered with 'atexit' or
     'on_exit'.

     This function actually terminates the process by raising a
     'SIGABRT' signal, and your program can include a handler to
     intercept this signal; see *note Signal Handling::.

