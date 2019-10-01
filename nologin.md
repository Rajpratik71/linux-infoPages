File: *manpages*,  Node: nologin,  Up: (dir)

NOLOGIN(8)                BSD System Manager's Manual               NOLOGIN(8)

NAME
     nologin — politely refuse a login

SYNOPSIS
     nologin

DESCRIPTION
     nologin displays a message that an account is not available and exits
     non-zero.  It is intended as a replacement shell field for accounts that
     have been disabled.

     If the file /etc/nologin.txt exists, nologin displays its contents to the
     user instead of the default message.

SEE ALSO
     login(1)

HISTORY
     The nologin command appeared in 4.4BSD.

BSD                            February 15, 1997                           BSD
NOLOGIN(5)                 Linux Programmer's Manual                NOLOGIN(5)



NAME
       nologin - prevent unprivileged users from logging into the system

DESCRIPTION
       If  the  file  /etc/nologin exists and is readable, login(1) will allow
       access only to root.  Other users will be shown the  contents  of  this
       file and their logins will be refused.

FILES
       /etc/nologin

SEE ALSO
       login(1), shutdown(8)

COLOPHON
       This  page  is  part of release 3.53 of the Linux man-pages project.  A
       description of the project, and information about reporting  bugs,  can
       be found at http://www.kernel.org/doc/man-pages/.



Linux                             2012-04-16                        NOLOGIN(5)
