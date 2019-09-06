File: *manpages*,  Node: vhangup,  Up: (dir)

VHANGUP(8)                   The SuSE boot concept                  VHANGUP(8)



NAME
       Vhangup - Cause a virtually hangup on the specified terminals

SYNOPSIS
       vhangup [/dev/<terminal> [/dev/<terminal>]]

DESCRIPTION
       vhangup  simulates  a  hangup on the specified terminals.  Not existing
       device files or devices will be ignored.

EXAMPLES
       vhangup /dev/tty1 /dev/tty2 /dev/tty3 /dev/tty4 /dev/tty5 /dev/tty6 /dev/ttyS1

       This will replace all open file descriptors in the kernel  that  points
       to the listed ttys by a dummy that will deny further reading/writing to
       the device. It also send the signals SIGHUP/SIGCONT  to  the  processes
       which have file descriptors open on the listed ttys.

RETURN VALUE
       On success, zero is returned.  On error, 1 is returned.

SEE ALSO
       vhangup(2), tty(4), ttyS(4), pts(4).

COPYRIGHT
       2008 Werner Fink, 2008 SUSE LINUX Products GmbH, Germany.

AUTHOR
       Werner Fink <werner@suse.de>



3rd Berkeley Distribution        Jan 31, 2008                       VHANGUP(8)
VHANGUP(2)                 Linux Programmer's Manual                VHANGUP(2)



NAME
       vhangup - virtually hangup the current terminal

SYNOPSIS
       #include <unistd.h>

       int vhangup(void);

   Feature Test Macro Requirements for glibc (see feature_test_macros(7)):

       vhangup(): _BSD_SOURCE || (_XOPEN_SOURCE && _XOPEN_SOURCE < 500)

DESCRIPTION
       vhangup()  simulates  a  hangup  on  the  current  terminal.  This call
       arranges for other users to have a “clean” terminal at login time.

RETURN VALUE
       On success, zero is returned.  On error, -1 is returned, and  errno  is
       set appropriately.

ERRORS
       EPERM  The   calling   process   has  insufficient  privilege  to  call
              vhangup(); the CAP_SYS_TTY_CONFIG capability is required.

CONFORMING TO
       This call is  Linux-specific,  and  should  not  be  used  in  programs
       intended to be portable.

SEE ALSO
       capabilities(7), init(1)

COLOPHON
       This  page  is  part of release 4.02 of the Linux man-pages project.  A
       description of the project, information about reporting bugs,  and  the
       latest     version     of     this    page,    can    be    found    at
       http://www.kernel.org/doc/man-pages/.



Linux                             2007-07-26                        VHANGUP(2)
