File: libc.info,  Node: CPU Time,  Next: Processor Time,  Up: Processor And CPU Time

21.3.1 CPU Time Inquiry
-----------------------

To get a process' CPU time, you can use the 'clock' function.  This
facility is declared in the header file 'time.h'.

   In typical usage, you call the 'clock' function at the beginning and
end of the interval you want to time, subtract the values, and then
divide by 'CLOCKS_PER_SEC' (the number of clock ticks per second) to get
processor time, like this:

     #include <time.h>

     clock_t start, end;
     double cpu_time_used;

     start = clock();
     ... /* Do the work. */
     end = clock();
     cpu_time_used = ((double) (end - start)) / CLOCKS_PER_SEC;

   Do not use a single CPU time as an amount of time; it doesn't work
that way.  Either do a subtraction as shown above or query processor
time directly.  *Note Processor Time::.

   Different computers and operating systems vary wildly in how they
keep track of CPU time.  It's common for the internal processor clock to
have a resolution somewhere between a hundredth and millionth of a
second.

 -- Macro: int CLOCKS_PER_SEC
     The value of this macro is the number of clock ticks per second
     measured by the 'clock' function.  POSIX requires that this value
     be one million independent of the actual resolution.

 -- Data Type: clock_t
     This is the type of the value returned by the 'clock' function.
     Values of type 'clock_t' are numbers of clock ticks.

 -- Function: clock_t clock (void)
     Preliminary: | MT-Safe | AS-Safe | AC-Safe | *Note POSIX Safety
     Concepts::.

     This function returns the calling process' current CPU time.  If
     the CPU time is not available or cannot be represented, 'clock'
     returns the value '(clock_t)(-1)'.

