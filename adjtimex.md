File: libc.info,  Node: High-Resolution Calendar,  Next: Broken-down Time,  Prev: Simple Calendar Time,  Up: Calendar Time

21.4.2 High-Resolution Calendar
-------------------------------

The `time_t' data type used to represent simple times has a resolution
of only one second.  Some applications need more precision.

   So, the GNU C Library also contains functions which are capable of
representing calendar times to a higher resolution than one second.  The
functions and the associated data types described in this section are
declared in `sys/time.h'.  

 -- Data Type: struct timezone
     The `struct timezone' structure is used to hold minimal information
     about the local time zone.  It has the following members:

    `int tz_minuteswest'
          This is the number of minutes west of UTC.

    `int tz_dsttime'
          If nonzero, Daylight Saving Time applies during some part of
          the year.

     The `struct timezone' type is obsolete and should never be used.
     Instead, use the facilities described in *note Time Zone
     Functions::.

 -- Function: int gettimeofday (struct timeval *TP, struct timezone
          *TZP)
     Preliminary: | MT-Safe | AS-Safe | AC-Safe | *Note POSIX Safety
     Concepts::.

     The `gettimeofday' function returns the current calendar time as
     the elapsed time since the epoch in the `struct timeval' structure
     indicated by TP.  (*note Elapsed Time:: for a description of
     `struct timeval').  Information about the time zone is returned in
     the structure pointed at TZP.  If the TZP argument is a null
     pointer, time zone information is ignored.

     The return value is `0' on success and `-1' on failure.  The
     following `errno' error condition is defined for this function:

    `ENOSYS'
          The operating system does not support getting time zone
          information, and TZP is not a null pointer.  GNU systems do
          not support using `struct timezone' to represent time zone
          information; that is an obsolete feature of 4.3 BSD.
          Instead, use the facilities described in *note Time Zone
          Functions::.

 -- Function: int settimeofday (const struct timeval *TP, const struct
          timezone *TZP)
     Preliminary: | MT-Safe | AS-Safe | AC-Safe | *Note POSIX Safety
     Concepts::.

     The `settimeofday' function sets the current calendar time in the
     system clock according to the arguments.  As for `gettimeofday',
     the calendar time is represented as the elapsed time since the
     epoch.  As for `gettimeofday', time zone information is ignored if
     TZP is a null pointer.

     You must be a privileged user in order to use `settimeofday'.

     Some kernels automatically set the system clock from some source
     such as a hardware clock when they start up.  Others, including
     Linux, place the system clock in an "invalid" state (in which
     attempts to read the clock fail).  A call of `stime' removes the
     system clock from an invalid state, and system startup scripts
     typically run a program that calls `stime'.

     `settimeofday' causes a sudden jump forwards or backwards, which
     can cause a variety of problems in a system.  Use `adjtime' (below)
     to make a smooth transition from one time to another by temporarily
     speeding up or slowing down the clock.

     With a Linux kernel, `adjtimex' does the same thing and can also
     make permanent changes to the speed of the system clock so it
     doesn't need to be corrected as often.

     The return value is `0' on success and `-1' on failure.  The
     following `errno' error conditions are defined for this function:

    `EPERM'
          This process cannot set the clock because it is not
          privileged.

    `ENOSYS'
          The operating system does not support setting time zone
          information, and TZP is not a null pointer.

 -- Function: int adjtime (const struct timeval *DELTA, struct timeval
          *OLDDELTA)
     Preliminary: | MT-Safe | AS-Safe | AC-Safe | *Note POSIX Safety
     Concepts::.

     This function speeds up or slows down the system clock in order to
     make a gradual adjustment.  This ensures that the calendar time
     reported by the system clock is always monotonically increasing,
     which might not happen if you simply set the clock.

     The DELTA argument specifies a relative adjustment to be made to
     the clock time.  If negative, the system clock is slowed down for a
     while until it has lost this much elapsed time.  If positive, the
     system clock is speeded up for a while.

     If the OLDDELTA argument is not a null pointer, the `adjtime'
     function returns information about any previous time adjustment
     that has not yet completed.

     This function is typically used to synchronize the clocks of
     computers in a local network.  You must be a privileged user to
     use it.

     With a Linux kernel, you can use the `adjtimex' function to
     permanently change the clock speed.

     The return value is `0' on success and `-1' on failure.  The
     following `errno' error condition is defined for this function:

    `EPERM'
          You do not have privilege to set the time.

   *Portability Note:*  The `gettimeofday', `settimeofday', and
`adjtime' functions are derived from BSD.

   Symbols for the following function are declared in `sys/timex.h'.

 -- Function: int adjtimex (struct timex *TIMEX)
     Preliminary: | MT-Safe | AS-Safe | AC-Safe | *Note POSIX Safety
     Concepts::.

     `adjtimex' is functionally identical to `ntp_adjtime'.  *Note High
     Accuracy Clock::.

     This function is present only with a Linux kernel.


