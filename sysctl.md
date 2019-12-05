SYSCTL(8)                                                                                   System Administration                                                                                   SYSCTL(8)

NAME
       sysctl - configure kernel parameters at runtime

SYNOPSIS
       sysctl [options] [variable[=value]] [...]
       sysctl -p [file or regexp] [...]

DESCRIPTION
       sysctl  is used to modify kernel parameters at runtime.  The parameters available are those listed under /proc/sys/.  Procfs is required for sysctl support in Linux.  You can use sysctl to both read
       and write sysctl data.

PARAMETERS
       variable
              The name of a key to read from.  An example is kernel.ostype.  The '/' separator is also accepted in place of a '.'.

       variable=value
              To set a key, use the form variable=value where variable is the key and value is the value to set it to.  If the value contains quotes or characters which are parsed by  the  shell,  you  may
              need to enclose the value in double quotes.

       -n, --values
              Use this option to disable printing of the key name when printing values.

       -e, --ignore
              Use this option to ignore errors about unknown keys.

       -N, --names
              Use this option to only print the names.  It may be useful with shells that have programmable completion.

       -q, --quiet
              Use this option to not display the values set to stdout.

       -w, --write
              Use this option when all arguments prescribe a key to be set.

       -p[FILE], --load[=FILE]
              Load  in sysctl settings from the file specified or /etc/sysctl.conf if none given.  Specifying - as filename means reading data from standard input.  Using this option will mean arguments to
              sysctl are files, which are read in the order they are specified.  The file argument may be specified as regular expression.

       -a, --all
              Display all values currently available.

       --deprecated
              Include deprecated parameters to --all values listing.

       -b, --binary
              Print value without new line.

       --system
              Load settings from all system configuration files. Files are read from directories in the following list in given order from top to bottom.  Once a file of a given  filename  is  loaded,  any
              file of the same name in subsequent directories is ignored.
              /run/sysctl.d/*.conf
              /etc/sysctl.d/*.conf
              /usr/local/lib/sysctl.d/*.conf
              /usr/lib/sysctl.d/*.conf
              /lib/sysctl.d/*.conf
              /etc/sysctl.conf

       -r, --pattern pattern
              Only apply settings that match pattern.  The pattern uses extended regular expression syntax.

       -A     Alias of -a

       -d     Alias of -h

       -f     Alias of -p

       -X     Alias of -a

       -o     Does nothing, exists for BSD compatibility.

       -x     Does nothing, exists for BSD compatibility.

       -h, --help
              Display help text and exit.

       -V, --version
              Display version information and exit.

EXAMPLES
       /sbin/sysctl -a
       /sbin/sysctl -n kernel.hostname
       /sbin/sysctl -w kernel.domainname="example.com"
       /sbin/sysctl -p/etc/sysctl.conf
       /sbin/sysctl -a --pattern forward
       /sbin/sysctl -a --pattern forward$
       /sbin/sysctl -a --pattern 'net.ipv4.conf.(eth|wlan)0.arp'
       /sbin/sysctl --system --pattern '^net.ipv6'

DEPRECATED PARAMETERS
       The  base_reachable_time  and  retrans_time  are deprecated.  The sysctl command does not allow changing values of these parameters.  Users who insist to use deprecated kernel interfaces should push
       values to /proc file system by other means.  For example:

       echo 256 > /proc/sys/net/ipv6/neigh/eth0/base_reachable_time

FILES
       /proc/sys
       /etc/sysctl.conf

SEE ALSO
       sysctl.conf(5) regex(7)

AUTHOR
       George Staikos ⟨staikos@0wned.org⟩

REPORTING BUGS
       Please send bug reports to ⟨procps@freelists.org⟩

procps-ng                                                                                         2018-02-19                                                                                        SYSCTL(8)
SYSCTL(2)                                                                                 Linux Programmer's Manual                                                                                 SYSCTL(2)

NAME
       sysctl - read/write system parameters

SYNOPSIS
       #include <unistd.h>
       #include <linux/sysctl.h>

       int _sysctl(struct __sysctl_args *args);

       Note: There is no glibc wrapper for this system call; see NOTES.

DESCRIPTION
       Do not use this system call!  See NOTES.

       The _sysctl() call reads and/or writes kernel parameters.  For example, the hostname, or the maximum number of open files.  The argument has the form

           struct __sysctl_args {
               int    *name;    /* integer vector describing variable */
               int     nlen;    /* length of this vector */
               void   *oldval;  /* 0 or address where to store old value */
               size_t *oldlenp; /* available room for old value,
                                   overwritten by actual size of old value */
               void   *newval;  /* 0 or address of new value */
               size_t  newlen;  /* size of new value */
           };

       This call does a search in a tree structure, possibly resembling a directory tree under /proc/sys, and if the requested item is found calls some appropriate routine to read or modify the value.

RETURN VALUE
       Upon successful completion, _sysctl() returns 0.  Otherwise, a value of -1 is returned and errno is set to indicate the error.

ERRORS
       EACCES, EPERM
              No search permission for one of the encountered "directories", or no read permission where oldval was nonzero, or no write permission where newval was nonzero.

       EFAULT The invocation asked for the previous value by setting oldval non-NULL, but allowed zero room in oldlenp.

       ENOTDIR
              name was not found.

CONFORMING TO
       This  call  is  Linux-specific, and should not be used in programs intended to be portable.  A sysctl() call has been present in Linux since version 1.3.57.  It originated in 4.4BSD.  Only Linux has
       the /proc/sys mirror, and the object naming schemes differ between Linux and 4.4BSD, but the declaration of the sysctl() function is the same in both.

NOTES
       Glibc does not provide a wrapper for this system call; call it using syscall(2).  Or rather...  don't call it: use of this system call has long been discouraged, and it is  so  unloved  that  it  is
       likely to disappear in a future kernel version.  Since Linux 2.6.24, uses of this system call result in warnings in the kernel log.  Remove it from your programs now; use the /proc/sys interface in‐
       stead.

       This system call is available only if the kernel was configured with the CONFIG_SYSCTL_SYSCALL option.

BUGS
       The object names vary between kernel versions, making this system call worthless for applications.

       Not all available objects are properly documented.

       It is not yet possible to change operating system by writing to /proc/sys/kernel/ostype.

EXAMPLE
       #define _GNU_SOURCE
       #include <unistd.h>
       #include <sys/syscall.h>
       #include <string.h>
       #include <stdio.h>
       #include <stdlib.h>
       #include <linux/sysctl.h>

       int _sysctl(struct __sysctl_args *args );

       #define OSNAMESZ 100

       int
       main(void)
       {
           struct __sysctl_args args;
           char osname[OSNAMESZ];
           size_t osnamelth;
           int name[] = { CTL_KERN, KERN_OSTYPE };

           memset(&args, 0, sizeof(struct __sysctl_args));
           args.name = name;
           args.nlen = sizeof(name)/sizeof(name[0]);
           args.oldval = osname;
           args.oldlenp = &osnamelth;

           osnamelth = sizeof(osname);

           if (syscall(SYS__sysctl, &args) == -1) {
               perror("_sysctl");
               exit(EXIT_FAILURE);
           }
           printf("This machine is running %*s\n", osnamelth, osname);
           exit(EXIT_SUCCESS);
       }

SEE ALSO
       proc(5)

COLOPHON
       This page is part of release 5.02 of the Linux man-pages project.  A description of the project,  information  about  reporting  bugs,  and  the  latest  version  of  this  page,  can  be  found  at
       https://www.kernel.org/doc/man-pages/.

Linux                                                                                             2019-03-06                                                                                        SYSCTL(2)
