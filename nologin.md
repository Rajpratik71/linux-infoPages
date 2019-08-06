File: *manpages*,  Node: nologin,  Up: (dir)

NOLOGIN(8)                   System Administration                  NOLOGIN(8)



NAME
       nologin - politely refuse a login

SYNOPSIS
       nologin [-V] [-h]

DESCRIPTION
       nologin  displays  a message that an account is not available and exits
       non-zero.  It is intended as a replacement shell field  to  deny  login
       access to an account.

       If  the  file /etc/nologin.txt exists, nologin displays its contents to
       the user instead of the default message.

       The exit code returned by nologin is always 1.

OPTIONS
       -h, --help
              Display help text and exit.

       -V, --version
              Display version information and exit.

NOTES
       nologin is a per-account way to disable login (usually used for  system
       accounts  like  http  or  ftp).  nologin(8) uses /etc/nologin.txt as an
       optional source for a non-default message, the login access  is  always
       refused independently of the file.

       pam_nologin(8) PAM module usually prevents all non-root users from log-
       ging into the system.  pam_nologin(8) functionality  is  controlled  by
       /var/run/nologin or the /etc/nologin file.

AUTHORS
       Karel Zak ⟨kzak@redhat.com⟩

SEE ALSO
       login(1), passwd(5), pam_nologin(8)

HISTORY
       The nologin command appeared in 4.4BSD.

AVAILABILITY
       The  nologin command is part of the util-linux package and is available
       from Linux Kernel  Archive  ⟨ftp://ftp.kernel.org/pub/linux/utils/util-
       linux/⟩.



util-linux                      September 2013                      NOLOGIN(8)
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
       This  page  is  part of release 4.02 of the Linux man-pages project.  A
       description of the project, information about reporting bugs,  and  the
       latest     version     of     this    page,    can    be    found    at
       http://www.kernel.org/doc/man-pages/.



Linux                             2012-04-16                        NOLOGIN(5)
