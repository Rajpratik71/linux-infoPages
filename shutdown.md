SHUTDOWN(8)                                                                                    shutdown                                                                                    SHUTDOWN(8)

NAME
       shutdown - Halt, power-off or reboot the machine

SYNOPSIS
       shutdown [OPTIONS...] [TIME] [WALL...]

DESCRIPTION
       shutdown may be used to halt, power-off or reboot the machine.

       The first argument may be a time string (which is usually "now"). Optionally, this may be followed by a wall message to be sent to all logged-in users before going down.

       The time string may either be in the format "hh:mm" for hour/minutes specifying the time to execute the shutdown at, specified in 24h clock format. Alternatively it may be in the syntax "+m"
       referring to the specified number of minutes m from now.  "now" is an alias for "+0", i.e. for triggering an immediate shutdown. If no time argument is specified, "+1" is implied.

       Note that to specify a wall message you must specify a time argument, too.

       If the time argument is used, 5 minutes before the system goes down the /run/nologin file is created to ensure that further logins shall not be allowed.

OPTIONS
       The following options are understood:

       --help
           Print a short help text and exit.

       -H, --halt
           Halt the machine.

       -P, --poweroff
           Power-off the machine (the default).

       -r, --reboot
           Reboot the machine.

       -h
           Equivalent to --poweroff, unless --halt is specified.

       -k
           Do not halt, power-off, reboot, just write wall message.

       --no-wall
           Do not send wall message before halt, power-off, reboot.

       -c
           Cancel a pending shutdown. This may be used cancel the effect of an invocation of shutdown with a time argument that is not "+0" or "now".

EXIT STATUS
       On success, 0 is returned, a non-zero failure code otherwise.

SEE ALSO
       systemd(1), systemctl(1), halt(8), wall(1)

systemd 237                                                                                                                                                                                SHUTDOWN(8)
SHUTDOWN(2)                                                                            Linux Programmer's Manual                                                                           SHUTDOWN(2)

NAME
       shutdown - shut down part of a full-duplex connection

SYNOPSIS
       #include <sys/socket.h>

       int shutdown(int sockfd, int how);

DESCRIPTION
       The  shutdown() call causes all or part of a full-duplex connection on the socket associated with sockfd to be shut down.  If how is SHUT_RD, further receptions will be disallowed.  If how is
       SHUT_WR, further transmissions will be disallowed.  If how is SHUT_RDWR, further receptions and transmissions will be disallowed.

RETURN VALUE
       On success, zero is returned.  On error, -1 is returned, and errno is set appropriately.

ERRORS
       EBADF  sockfd is not a valid file descriptor.

       EINVAL An invalid value was specified in how (but see BUGS).

       ENOTCONN
              The specified socket is not connected.

       ENOTSOCK
              The file descriptor sockfd does not refer to a socket.

CONFORMING TO
       POSIX.1-2001, POSIX.1-2008, 4.4BSD (shutdown() first appeared in 4.2BSD).

NOTES
       The constants SHUT_RD, SHUT_WR, SHUT_RDWR have the value 0, 1, 2, respectively, and are defined in <sys/socket.h> since glibc-2.1.91.

BUGS
       Checks for the validity of how are done in domain-specific code, and before Linux 3.7 not all domains performed these checks.  Most notably, UNIX domain sockets simply ignored invalid values.
       This problem was fixed for UNIX domain sockets in Linux 3.7.

SEE ALSO
       connect(2), socket(2), socket(7)

COLOPHON
       This  page  is  part  of  release  4.15  of  the Linux man-pages project.  A description of the project, information about reporting bugs, and the latest version of this page, can be found at
       https://www.kernel.org/doc/man-pages/.

Linux                                                                                         2016-03-15                                                                                   SHUTDOWN(2)
