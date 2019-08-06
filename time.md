File: libc.info,  Node: Simple Calendar Time,  Next: High-Resolution Calendar,  Up: Calendar Time

21.4.1 Simple Calendar Time
---------------------------

This section describes the `time_t' data type for representing calendar
time as simple time, and the functions which operate on simple time
objects.  These facilities are declared in the header file `time.h'.  

 -- Data Type: time_t
     This is the data type used to represent simple time.  Sometimes,
     it also represents an elapsed time.  When interpreted as a
     calendar time value, it represents the number of seconds elapsed
     since 00:00:00 on January 1, 1970, Coordinated Universal Time.
     (This calendar time is sometimes referred to as the "epoch".)
     POSIX requires that this count not include leap seconds, but on
     some systems this count includes leap seconds if you set `TZ' to
     certain values (*note TZ Variable::).

     Note that a simple time has no concept of local time zone.
     Calendar Time T is the same instant in time regardless of where on
     the globe the computer is.

     In the GNU C Library, `time_t' is equivalent to `long int'.  In
     other systems, `time_t' might be either an integer or
     floating-point type.

   The function `difftime' tells you the elapsed time between two
simple calendar times, which is not always as easy to compute as just
subtracting.  *Note Elapsed Time::.

 -- Function: time_t time (time_t *RESULT)
     Preliminary: | MT-Safe | AS-Safe | AC-Safe | *Note POSIX Safety
     Concepts::.

     The `time' function returns the current calendar time as a value of
     type `time_t'.  If the argument RESULT is not a null pointer, the
     calendar time value is also stored in `*RESULT'.  If the current
     calendar time is not available, the value `(time_t)(-1)' is
     returned.

 -- Function: int stime (const time_t *NEWTIME)
     Preliminary: | MT-Safe | AS-Safe | AC-Safe | *Note POSIX Safety
     Concepts::.

     `stime' sets the system clock, i.e., it tells the system that the
     current calendar time is NEWTIME, where `newtime' is interpreted
     as described in the above definition of `time_t'.

     `settimeofday' is a newer function which sets the system clock to
     better than one second precision.  `settimeofday' is generally a
     better choice than `stime'.  *Note High-Resolution Calendar::.

     Only the superuser can set the system clock.

     If the function succeeds, the return value is zero.  Otherwise, it
     is `-1' and `errno' is set accordingly:

    `EPERM'
          The process is not superuser.

