File: *manpages*,  Node: unshare,  Up: (dir)

UNSHARE(1)                       User Commands                      UNSHARE(1)



NAME
       unshare - run program with some namespaces unshared from parent

SYNOPSIS
       unshare [options] program [arguments]

DESCRIPTION
       Unshares the indicated namespaces from the parent process and then exe‐
       cutes the specified program.  The namespaces to be unshared  are  indi‐
       cated via options.  Unshareable namespaces are:

       mount namespace
              Mounting  and unmounting filesystems will not affect the rest of
              the system (CLONE_NEWNS flag), except for filesystems which  are
              explicitly  marked  as  shared  (with  mount  --make-shared; see
              /proc/self/mountinfo or findmnt -o+PROPAGATION  for  the  shared
              flags).

              unshare  automatically  sets  propagation  to private in the new
              mount namespace to make sure that the new  namespace  is  really
              unshared. This feature is possible to disable by option --propa‐
              gation unchanged.  Note that private is the kernel default.

       UTS namespace
              Setting hostname or domainname will not affect the rest  of  the
              system.  (CLONE_NEWUTS flag)

       IPC namespace
              The process will have an independent namespace for System V mes‐
              sage  queues,  semaphore  sets  and  shared   memory   segments.
              (CLONE_NEWIPC flag)

       network namespace
              The process will have independent IPv4 and IPv6 stacks, IP rout‐
              ing tables, firewall rules,  the  /proc/net  and  /sys/class/net
              directory trees, sockets, etc.  (CLONE_NEWNET flag)

       pid namespace
              Children  will  have  a  distinct set of PID to process mappings
              from their parent.  (CLONE_NEWPID flag)

       user namespace
              The process will have a distinct set of UIDs, GIDs and capabili‐
              ties.  (CLONE_NEWUSER flag)

       See clone(2) for the exact semantics of the flags.

OPTIONS
       -i, --ipc
              Unshare the IPC namespace.

       -m, --mount
              Unshare the mount namespace.

       -n, --net
              Unshare the network namespace.

       -p, --pid
              Unshare the pid namespace.  See also the --fork and --mount-proc
              options.

       -u, --uts
              Unshare the UTS namespace.

       -U, --user
              Unshare the user namespace.

       -f, --fork
              Fork the specified program as a child process of unshare  rather
              than  running  it  directly.  This is useful when creating a new
              pid namespace.

       --mount-proc[=mountpoint]
              Just before running the program, mount the  proc  filesystem  at
              mountpoint  (default  is /proc).  This is useful when creating a
              new pid namespace.  It also implies creating a new mount  names‐
              pace since the /proc mount would otherwise mess up existing pro‐
              grams on the system.  The  new  proc  filesystem  is  explicitly
              mounted as private (by MS_PRIVATE|MS_REC).

       -r, --map-root-user
              Run  the program only after the current effective user and group
              IDs have been mapped to the superuser UID and GID in  the  newly
              created  user namespace.  This makes it possible to conveniently
              gain capabilities needed to manage various aspects of the  newly
              created  namespaces  (such as configuring interfaces in the net‐
              work namespace or mounting filesystems in the  mount  namespace)
              even  when  run unprivileged.  As a mere convenience feature, it
              does not support more sophisticated use cases, such  as  mapping
              multiple  ranges  of  UIDs and GIDs.  This option implies --set‐
              groups=deny.

       --propagation private|shared|slave|unchanged
              Recursively sets mount propagation flag in the new mount  names‐
              pace.  The  default  is  to set the propagation to private, this
              feature is  possible  to  disable  by  unchanged  argument.  The
              options  is  silently  ignored when mount namespace (--mount) is
              not requested.

       --setgroups allow|deny
              Allow or deny setgroups(2) syscall in user namespaces.

              setgroups(2) is only callable with CAP_SETGID and CAP_SETGID  in
              a user namespace (since Linux 3.19) does not give you permission
              to call setgroups(2) until after GID map has been set.  The  GID
              map is writable by root when setgroups(2) is enabled and GID map
              becomes writable by unprivileged processes when setgroups(2)  is
              permanently disabled.

       -V, --version
              Display version information and exit.

       -h, --help
              Display help text and exit.

EXAMPLES
       # unshare --fork --pid --mount-proc readlink /proc/self
       1
              Establish  a  PID  namespace,  ensure  we're PID 1 in it against
              newly mounted procfs instance.

       $ unshare --map-root-user --user sh -c whoami
       root
              Establish a user namespace as an unprivileged user with  a  root
              user within it.

SEE ALSO
       unshare(2), clone(2), mount(8)

BUGS
       None known so far.

AUTHOR
       Mikhail Gusarov <dottedmag@dottedmag.net>

AVAILABILITY
       The  unshare command is part of the util-linux package and is available
       from ftp://ftp.kernel.org/pub/linux/utils/util-linux/.



util-linux                         July 2014                        UNSHARE(1)
UNSHARE(2)                 Linux Programmer's Manual                UNSHARE(2)



NAME
       unshare - disassociate parts of the process execution context

SYNOPSIS
       #include <sched.h>

       int unshare(int flags);

   Feature Test Macro Requirements for glibc (see feature_test_macros(7)):

       unshare():
           Since glibc 2.14:
               _GNU_SOURCE
           Before glibc 2.14:
               _BSD_SOURCE || _SVID_SOURCE
                   /* _GNU_SOURCE also suffices */

DESCRIPTION
       unshare()  allows a process to disassociate parts of its execution con‐
       text that are currently being shared with other processes.  Part of the
       execution  context,  such  as the mount namespace, is shared implicitly
       when a new process is created using fork(2) or  vfork(2),  while  other
       parts,  such  as virtual memory, may be shared by explicit request when
       creating a process using clone(2).

       The main use of unshare() is to allow a process to control  its  shared
       execution context without creating a new process.

       The flags argument is a bit mask that specifies which parts of the exe‐
       cution context should be unshared.  This argument is specified by ORing
       together zero or more of the following constants:

       CLONE_FILES
              Reverse  the  effect  of the clone(2) CLONE_FILES flag.  Unshare
              the file descriptor table, so that the calling process no longer
              shares its file descriptors with any other process.

       CLONE_FS
              Reverse  the effect of the clone(2) CLONE_FS flag.  Unshare file
              system attributes, so that the calling process no longer  shares
              its root directory (chroot(2)), current directory (chdir(2)), or
              umask (umask(2)) attributes with any other process.

       CLONE_NEWIPC (since Linux 2.6.19)
              This flag has the same effect as the clone(2) CLONE_NEWIPC flag.
              Unshare  the System V IPC namespace, so that the calling process
              has a private copy of the System V IPC namespace  which  is  not
              shared  with  any other process.  Specifying this flag automati‐
              cally  implies  CLONE_SYSVSEM  as  well.   Use  of  CLONE_NEWIPC
              requires the CAP_SYS_ADMIN capability.

       CLONE_NEWNET (since Linux 2.6.24)
              This flag has the same effect as the clone(2) CLONE_NEWNET flag.
              Unshare the network namespace, so that the  calling  process  is
              moved  into a new network namespace which is not shared with any
              previously existing process.  Use of CLONE_NEWNET  requires  the
              CAP_SYS_ADMIN capability.

       CLONE_NEWNS
              This  flag has the same effect as the clone(2) CLONE_NEWNS flag.
              Unshare the mount namespace, so that the calling process  has  a
              private copy of its namespace which is not shared with any other
              process.  Specifying this flag automatically implies CLONE_FS as
              well.  Use of CLONE_NEWNS requires the CAP_SYS_ADMIN capability.

       CLONE_NEWUTS (since Linux 2.6.19)
              This flag has the same effect as the clone(2) CLONE_NEWUTS flag.
              Unshare the UTS IPC namespace, so that the calling process has a
              private  copy  of the UTS namespace which is not shared with any
              other process.  Use of CLONE_NEWUTS requires  the  CAP_SYS_ADMIN
              capability.

       CLONE_SYSVSEM (since Linux 2.6.26)
              This  flag  reverses  the  effect  of the clone(2) CLONE_SYSVSEM
              flag.  Unshare System V semaphore undo values, so that the call‐
              ing  process  has  a  private  copy which is not shared with any
              other process.  Use of CLONE_SYSVSEM requires the  CAP_SYS_ADMIN
              capability.

       If  flags  is  specified as zero, then unshare() is a no-op; no changes
       are made to the calling process's execution context.

RETURN VALUE
       On success, zero returned.  On failure, -1 is returned and errno is set
       to indicate the error.

ERRORS
       EINVAL An invalid bit was specified in flags.

       ENOMEM Cannot allocate sufficient memory to copy parts of caller's con‐
              text that need to be unshared.

       EPERM  The calling process did not have  the  required  privileges  for
              this operation.

VERSIONS
       The unshare() system call was added to Linux in kernel 2.6.16.

CONFORMING TO
       The unshare() system call is Linux-specific.

NOTES
       Not all of the process attributes that can be shared when a new process
       is created using clone(2) can be unshared using unshare().  In particu‐
       lar,  as at kernel 3.8, unshare() does not implement flags that reverse
       the effects of CLONE_SIGHAND, CLONE_THREAD, or  CLONE_VM.   Such  func‐
       tionality may be added in the future, if required.

SEE ALSO
       clone(2), fork(2), kcmp(2), setns(2), vfork(2)

       Documentation/unshare.txt in the Linux kernel source tree

COLOPHON
       This  page  is  part of release 3.53 of the Linux man-pages project.  A
       description of the project, and information about reporting  bugs,  can
       be found at http://www.kernel.org/doc/man-pages/.



Linux                             2013-04-17                        UNSHARE(2)
