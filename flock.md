FLOCK(1)                                                           User Commands                                                          FLOCK(1)

NAME
       flock - manage locks from shell scripts

SYNOPSIS
       flock [options] file|directory command [arguments]
       flock [options] file|directory -c command
       flock [options] number

DESCRIPTION
       This utility manages flock(2) locks from within shell scripts or from the command line.

       The  first  and second of the above forms wrap the lock around the execution of a command, in a manner similar to su(1) or newgrp(1).  They
       lock a specified file or directory, which is created (assuming appropriate permissions) if it does not already exist.  By default,  if  the
       lock cannot be immediately acquired, flock waits until the lock is available.

       The third form uses an open file by its file descriptor number.  See the examples below for how that can be used.

OPTIONS
       -c, --command command
              Pass a single command, without arguments, to the shell with -c.

       -E, --conflict-exit-code number
              The  exit  code  used  when the -n option is in use, and the conflicting lock exists, or the -w option is in use, and the timeout is
              reached.  The default value is 1.

       -F, --no-fork
              Do not fork before executing command.  Upon execution the flock process is replaced by command which continues  to  hold  the  lock.
              This option is incompatible with --close as there would otherwise be nothing left to hold the lock.

       -e, -x, --exclusive
              Obtain an exclusive lock, sometimes called a write lock.  This is the default.

       -n, --nb, --nonblock
              Fail rather than wait if the lock cannot be immediately acquired.  See the -E option for the exit code used.

       -o, --close
              Close  the  file  descriptor  on  which the lock is held before executing command.  This is useful if command spawns a child process
              which should not be holding the lock.

       -s, --shared
              Obtain a shared lock, sometimes called a read lock.

       -u, --unlock
              Drop a lock.  This is usually not required, since a lock is automatically dropped when the file  is  closed.   However,  it  may  be
              required  in special cases, for example if the enclosed command group may have forked a background process which should not be hold‐
              ing the lock.

       -w, --wait, --timeout seconds
              Fail if the lock cannot be acquired within seconds.  Decimal fractional values are allowed.  See the -E option  for  the  exit  code
              used. The zero number of seconds is interpreted as --nonblock.

       --verbose
              Report how long it took to acquire the lock, or why the lock could not be obtained.

       -V, --version
              Display version information and exit.

       -h, --help
              Display help text and exit.

EXAMPLES
       shell1> flock /tmp -c cat
       shell2> flock -w .007 /tmp -c echo; /bin/echo $?
              Set exclusive lock to directory /tmp and the second command will fail.

       shell1> flock -s /tmp -c cat
       shell2> flock -s -w .007 /tmp -c echo; /bin/echo $?
              Set  shared  lock  to directory /tmp and the second command will not fail.  Notice that attempting to get exclusive lock with second
              command would fail.

       shell> flock -x local-lock-file echo 'a b c'
              Grab the exclusive lock "local-lock-file" before running echo with 'a b c'.

       (
         flock -n 9 || exit 1
         # ... commands executed under lock ...
       ) 9>/var/lock/mylockfile
              The form is convenient inside shell scripts.  The mode used to open the file doesn't matter to flock; using > or >> allows the lock‐
              file  to  be  created  if  it does not already exist, however, write permission is required.  Using < requires that the file already
              exists but only read permission is required.

       [ "${FLOCKER}" != "$0" ] && exec env FLOCKER="$0" flock -en "$0" "$0" "$@" || :
              This is useful boilerplate code for shell scripts.  Put it at the top of the shell script you want to lock and  it'll  automatically
              lock itself on the first run.  If the env var $FLOCKER is not set to the shell script that is being run, then execute flock and grab
              an exclusive non-blocking lock (using the script itself as the lock file) before re-execing itself with  the  right  arguments.   It
              also sets the FLOCKER env var to the right value so it doesn't run again.

EXIT STATUS
       The  command  uses  sysexits.h  return  values  for  everything, except when using either of the options -n or -w which report a failure to
       acquire the lock with a return value given by the -E option, or 1 by default.

       When using the command variant, and executing the child worked, then the exit status is that of the child command.

AUTHOR
       H. Peter Anvin ⟨hpa@zytor.com⟩

COPYRIGHT
       Copyright © 2003-2006 H. Peter Anvin.
       This is free software; see the source for copying conditions.  There is NO warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICU‐
       LAR PURPOSE.

SEE ALSO
       flock(2)

AVAILABILITY
       The  flock  command  is  part  of the util-linux package and is available from Linux Kernel Archive ⟨https://www.kernel.org/pub/linux/utils
       /util-linux/⟩.

util-linux                                                           July 2014                                                            FLOCK(1)
FLOCK(2)                                                     Linux Programmer's Manual                                                    FLOCK(2)

NAME
       flock - apply or remove an advisory lock on an open file

SYNOPSIS
       #include <sys/file.h>

       int flock(int fd, int operation);

DESCRIPTION
       Apply or remove an advisory lock on the open file specified by fd.  The argument operation is one of the following:

           LOCK_SH  Place a shared lock.  More than one process may hold a shared lock for a given file at a given time.

           LOCK_EX  Place an exclusive lock.  Only one process may hold an exclusive lock for a given file at a given time.

           LOCK_UN  Remove an existing lock held by this process.

       A  call to flock() may block if an incompatible lock is held by another process.  To make a nonblocking request, include LOCK_NB (by ORing)
       with any of the above operations.

       A single file may not simultaneously have both shared and exclusive locks.

       Locks created by flock() are associated with an open file description (see open(2)).  This means that duplicate file  descriptors  (created
       by, for example, fork(2) or dup(2)) refer to the same lock, and this lock may be modified or released using any of these descriptors.  Fur‐
       thermore, the lock is released either by an explicit LOCK_UN operation on any of these duplicate descriptors, or when all such  descriptors
       have been closed.

       If a process uses open(2) (or similar) to obtain more than one descriptor for the same file, these descriptors are treated independently by
       flock().  An attempt to lock the file using one of these file descriptors may be denied by a lock that  the  calling  process  has  already
       placed via another descriptor.

       A  process may hold only one type of lock (shared or exclusive) on a file.  Subsequent flock() calls on an already locked file will convert
       an existing lock to the new lock mode.

       Locks created by flock() are preserved across an execve(2).

       A shared or exclusive lock can be placed on a file regardless of the mode in which the file was opened.

RETURN VALUE
       On success, zero is returned.  On error, -1 is returned, and errno is set appropriately.

ERRORS
       EBADF  fd is not an open file descriptor.

       EINTR  While waiting to acquire a lock, the call was interrupted by delivery of a signal caught by a handler; see signal(7).

       EINVAL operation is invalid.

       ENOLCK The kernel ran out of memory for allocating lock records.

       EWOULDBLOCK
              The file is locked and the LOCK_NB flag was selected.

CONFORMING TO
       4.4BSD (the flock() call first appeared in 4.2BSD).  A version of flock(), possibly implemented in terms of fcntl(2), appears on most  UNIX
       systems.

NOTES
       Since  kernel  2.0,  flock()  is implemented as a system call in its own right rather than being emulated in the GNU C library as a call to
       fcntl(2).  With this implementation, there is no interaction between the types of lock placed by flock() and fcntl(2), and flock() does not
       detect deadlock.  (Note, however, that on some systems, such as the modern BSDs, flock() and fcntl(2) locks do interact with one another.)

       In  Linux  kernels up to 2.6.11, flock() does not lock files over NFS (i.e., the scope of locks was limited to the local system).  Instead,
       one could use fcntl(2) byte-range locking, which does work over NFS, given a sufficiently recent version of Linux and a server  which  sup‐
       ports locking.  Since Linux 2.6.12, NFS clients support flock() locks by emulating them as byte-range locks on the entire file.  This means
       that fcntl(2) and flock() locks do interact with one another over NFS.  Since Linux 2.6.37, the kernel supports a compatibility  mode  that
       allows flock() locks (and also fcntl(2) byte region locks) to be treated as local; see the discussion of the local_lock option in nfs(5).

       flock() places advisory locks only; given suitable permissions on a file, a process is free to ignore the use of flock() and perform I/O on
       the file.

       flock() and fcntl(2) locks have different semantics with respect to forked processes and dup(2).  On systems that implement  flock()  using
       fcntl(2), the semantics of flock() will be different from those described in this manual page.

       Converting  a  lock (shared to exclusive, or vice versa) is not guaranteed to be atomic: the existing lock is first removed, and then a new
       lock is established.  Between these two steps, a pending lock request by another process may be granted, with the result that  the  conver‐
       sion either blocks, or fails if LOCK_NB was specified.  (This is the original BSD behavior, and occurs on many other implementations.)

SEE ALSO
       flock(1), close(2), dup(2), execve(2), fcntl(2), fork(2), open(2), lockf(3)

       Documentation/filesystems/locks.txt in the Linux kernel source tree (Documentation/locks.txt in older kernels)

COLOPHON
       This  page is part of release 4.04 of the Linux man-pages project.  A description of the project, information about reporting bugs, and the
       latest version of this page, can be found at http://www.kernel.org/doc/man-pages/.

Linux                                                               2014-09-21                                                            FLOCK(2)
