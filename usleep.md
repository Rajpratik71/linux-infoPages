File: *manpages*,  Node: usleep,  Up: (dir)

USLEEP(1)                   General Commands Manual                  USLEEP(1)



NAME
       usleep - sleep some number of microseconds

SYNOPSIS
       usleep [number]

DESCRIPTION
       usleep sleeps some number of microseconds.  The default is 1.

OPTIONS
       --usage Show short usage message.

       --help, -?
              Print help information.

       -v, --version
              Print version information.

BUGS
       Probably  not accurate on many machines down to the microsecond.  Count
       on precision only to -4 or maybe -5.

AUTHOR
       Donald Barnes <djb@redhat.com>
       Erik Troan <ewt@redhat.com>



                                 Red Hat, Inc                        USLEEP(1)
USLEEP(3)                  Linux Programmer's Manual                 USLEEP(3)



NAME
       usleep - suspend execution for microsecond intervals

SYNOPSIS
       #include <unistd.h>

       int usleep(useconds_t usec);

   Feature Test Macro Requirements for glibc (see feature_test_macros(7)):

       usleep():
           Since glibc 2.12:
               _BSD_SOURCE ||
                   (_XOPEN_SOURCE >= 500 ||
                       _XOPEN_SOURCE && _XOPEN_SOURCE_EXTENDED) &&
                   !(_POSIX_C_SOURCE >= 200809L || _XOPEN_SOURCE >= 700)
           Before glibc 2.12:
               _BSD_SOURCE || _XOPEN_SOURCE >= 500 ||
               _XOPEN_SOURCE && _XOPEN_SOURCE_EXTENDED

DESCRIPTION
       The usleep() function suspends execution of the calling thread for  (at
       least)  usec microseconds.  The sleep may be lengthened slightly by any
       system activity or by the time spent processing  the  call  or  by  the
       granularity of system timers.

RETURN VALUE
       The  usleep() function returns 0 on success.  On error, -1 is returned,
       with errno set to indicate the cause of the error.

ERRORS
       EINTR  Interrupted by a signal; see signal(7).

       EINVAL usec is not smaller than 1000000.  (On  systems  where  that  is
              considered an error.)

ATTRIBUTES
       For   an   explanation   of   the  terms  used  in  this  section,  see
       attributes(7).

       ┌──────────┬───────────────┬─────────┐
       │Interface │ Attribute     │ Value   │
       ├──────────┼───────────────┼─────────┤
       │usleep()  │ Thread safety │ MT-Safe │
       └──────────┴───────────────┴─────────┘
CONFORMING TO
       4.3BSD, POSIX.1-2001.  POSIX.1-2001 declares  this  function  obsolete;
       use  nanosleep(2)  instead.   POSIX.1-2008 removes the specification of
       usleep().

       On the original BSD implementation, and in glibc before version  2.2.2,
       the  return  type  of this function is void.  The POSIX version returns
       int, and this is also the prototype used since glibc 2.2.2.

       Only the EINVAL error return is documented by SUSv2 and POSIX.1-2001.

NOTES
       The type useconds_t is an unsigned  integer  type  capable  of  holding
       integers  in  the range [0,1000000].  Programs will be more portable if
       they never mention this type explicitly.  Use

           #include <unistd.h>
           ...
               unsigned int usecs;
           ...
               usleep(usecs);

       The interaction of this function with  the  SIGALRM  signal,  and  with
       other   timer  functions  such  as  alarm(2),  sleep(3),  nanosleep(2),
       setitimer(2),  timer_create(2),  timer_delete(2),  timer_getoverrun(2),
       timer_gettime(2), timer_settime(2), ualarm(3) is unspecified.

SEE ALSO
       alarm(2),    getitimer(2),   nanosleep(2),   select(2),   setitimer(2),
       sleep(3), ualarm(3), time(7)

COLOPHON
       This page is part of release 3.53 of the Linux  man-pages  project.   A
       description  of  the project, and information about reporting bugs, can
       be found at http://www.kernel.org/doc/man-pages/.



                                  2013-04-19                         USLEEP(3)
USLEEP(3)                  Linux Programmer's Manual                 USLEEP(3)



NAME
       usleep - suspend execution for microsecond intervals

SYNOPSIS
       #include <unistd.h>

       int usleep(useconds_t usec);

   Feature Test Macro Requirements for glibc (see feature_test_macros(7)):

       usleep():
           Since glibc 2.12:
               _BSD_SOURCE ||
                   (_XOPEN_SOURCE >= 500 ||
                       _XOPEN_SOURCE && _XOPEN_SOURCE_EXTENDED) &&
                   !(_POSIX_C_SOURCE >= 200809L || _XOPEN_SOURCE >= 700)
           Before glibc 2.12:
               _BSD_SOURCE || _XOPEN_SOURCE >= 500 ||
               _XOPEN_SOURCE && _XOPEN_SOURCE_EXTENDED

DESCRIPTION
       The usleep() function suspends execution of the calling thread for  (at
       least)  usec microseconds.  The sleep may be lengthened slightly by any
       system activity or by the time spent processing  the  call  or  by  the
       granularity of system timers.

RETURN VALUE
       The  usleep() function returns 0 on success.  On error, -1 is returned,
       with errno set to indicate the cause of the error.

ERRORS
       EINTR  Interrupted by a signal; see signal(7).

       EINVAL usec is not smaller than 1000000.  (On  systems  where  that  is
              considered an error.)

CONFORMING TO
       4.3BSD,  POSIX.1-2001.   POSIX.1-2001  declares this function obsolete;
       use nanosleep(2) instead.  POSIX.1-2008 removes  the  specification  of
       usleep().

       On  the original BSD implementation, and in glibc before version 2.2.2,
       the return type of this function is void.  The  POSIX  version  returns
       int, and this is also the prototype used since glibc 2.2.2.

       Only the EINVAL error return is documented by SUSv2 and POSIX.1-2001.

NOTES
       The  type  useconds_t  is  an  unsigned integer type capable of holding
       integers in the range [0,1000000].  Programs will be more  portable  if
       they never mention this type explicitly.  Use

           #include <unistd.h>
           ...
               unsigned int usecs;
           ...
               usleep(usecs);

       The  interaction  of  this  function  with the SIGALRM signal, and with
       other  timer  functions  such  as  alarm(2),  sleep(3),   nanosleep(2),
       setitimer(2),  timer_create(2),  timer_delete(2),  timer_getoverrun(2),
       timer_gettime(2), timer_settime(2), ualarm(3) is unspecified.

SEE ALSO
       alarm(2),   getitimer(2),   nanosleep(2),   select(2),    setitimer(2),
       sleep(3), ualarm(3), time(7)

COLOPHON
       This  page  is  part of release 3.53 of the Linux man-pages project.  A
       description of the project, and information about reporting  bugs,  can
       be found at http://www.kernel.org/doc/man-pages/.



                                  2013-04-19                         USLEEP(3)
USLEEP(3P)                 POSIX Programmer's Manual                USLEEP(3P)



PROLOG
       This  manual  page is part of the POSIX Programmer's Manual.  The Linux
       implementation of this interface may differ (consult the  corresponding
       Linux  manual page for details of Linux behavior), or the interface may
       not be implemented on Linux.

NAME
       usleep - suspend execution for an interval

SYNOPSIS
       #include <unistd.h>

       int usleep(useconds_t useconds);


DESCRIPTION
       The usleep() function shall cause the calling thread  to  be  suspended
       from  execution until either the number of realtime microseconds speci‐
       fied by the argument useconds has elapsed or a signal is  delivered  to
       the  calling thread and its action is to invoke a signal-catching func‐
       tion or to terminate the process.  The suspension time  may  be  longer
       than requested due to the scheduling of other activity by the system.

       The  useconds  argument shall be less than one million. If the value of
       useconds is 0, then the call has no effect.

       If a SIGALRM signal is generated for the calling process during  execu‐
       tion  of usleep() and if the SIGALRM signal is being ignored or blocked
       from delivery, it is unspecified  whether  usleep()  returns  when  the
       SIGALRM signal is scheduled. If the signal is being blocked, it is also
       unspecified whether it remains pending after usleep() returns or it  is
       discarded.

       If  a SIGALRM signal is generated for the calling process during execu‐
       tion of usleep(), except as a result of a prior call to alarm(), and if
       the SIGALRM signal is not being ignored or blocked from delivery, it is
       unspecified whether that signal  has  any  effect  other  than  causing
       usleep() to return.

       If  a  signal-catching  function  interrupts  usleep()  and examines or
       changes either the time a SIGALRM is scheduled  to  be  generated,  the
       action  associated with the SIGALRM signal, or whether the SIGALRM sig‐
       nal is blocked from delivery, the results are unspecified.

       If a  signal-catching  function  interrupts  usleep()  and  calls  sig‐
       longjmp()  or  longjmp()  to  restore an environment saved prior to the
       usleep() call, the action associated with the SIGALRM  signal  and  the
       time at which a SIGALRM signal is scheduled to be generated are unspec‐
       ified. It is also unspecified whether the SIGALRM  signal  is  blocked,
       unless the process' signal mask is restored as part of the environment.

       Implementations  may place limitations on the granularity of timer val‐
       ues. For each interval timer, if the requested timer value  requires  a
       finer  granularity  than  the implementation supports, the actual timer
       value shall be rounded up to the next supported value.

       Interactions between usleep() and any of the following are unspecified:


              nanosleep()
              setitimer()
              timer_create()
              timer_delete()
              timer_getoverrun()
              timer_gettime()
              timer_settime()
              ualarm()
              sleep()

RETURN VALUE
       Upon successful completion, usleep()  shall  return  0;  otherwise,  it
       shall return -1 and set errno to indicate the error.

ERRORS
       The usleep() function may fail if:

       EINVAL The time interval specified one million or more microseconds.


       The following sections are informative.

EXAMPLES
       None.

APPLICATION USAGE
       Applications are recommended to use nanosleep() if the Timers option is
       supported,    or    setitimer(),    timer_create(),     timer_delete(),
       timer_getoverrun(), timer_gettime(), or timer_settime() instead of this
       function.

RATIONALE
       None.

FUTURE DIRECTIONS
       None.

SEE ALSO
       alarm(), getitimer(),  nanosleep(),  sigaction(),  sleep(),  timer_cre‐
       ate(),  timer_delete(), timer_getoverrun(), the Base Definitions volume
       of IEEE Std 1003.1-2001, <unistd.h>

COPYRIGHT
       Portions of this text are reprinted and reproduced in  electronic  form
       from IEEE Std 1003.1, 2003 Edition, Standard for Information Technology
       -- Portable Operating System Interface (POSIX),  The  Open  Group  Base
       Specifications  Issue  6,  Copyright  (C) 2001-2003 by the Institute of
       Electrical and Electronics Engineers, Inc and The Open  Group.  In  the
       event of any discrepancy between this version and the original IEEE and
       The Open Group Standard, the original IEEE and The Open Group  Standard
       is  the  referee document. The original Standard can be obtained online
       at http://www.opengroup.org/unix/online.html .



IEEE/The Open Group                  2003                           USLEEP(3P)
