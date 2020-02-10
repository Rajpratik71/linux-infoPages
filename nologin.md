NOLOGIN(8)                                                                              System Management Commands                                                                             NOLOGIN(8)

NAME
       nologin - politely refuse a login

SYNOPSIS
       nologin

DESCRIPTION
       The nologin command displays a message that an account is not available and exits non-zero. It is intended as a replacement shell field for accounts that have been disabled.

       To disable all logins, investigate nologin(5).

SEE ALSO
       login(1), nologin(5).

HISTORY
       The nologin command appearred in BSD 4.4.

shadow-utils 4.2                                                                                03/26/2019                                                                                     NOLOGIN(8)
NOLOGIN(5)                                                                              Linux Programmer's Manual                                                                              NOLOGIN(5)

NAME
       nologin - prevent unprivileged users from logging into the system

DESCRIPTION
       If the file /etc/nologin exists and is readable, login(1) will allow access only to root.  Other users will be shown the contents of this file and their logins will be refused.

FILES
       /etc/nologin

SEE ALSO
       login(1), shutdown(8)

COLOPHON
       This  page  is  part  of  release  4.04  of  the  Linux  man-pages  project.  A description of the project, information about reporting bugs, and the latest version of this page, can be found at
       http://www.kernel.org/doc/man-pages/.

Linux                                                                                           2012-04-16                                                                                     NOLOGIN(5)
