UMOUNT(8)                                                      System Administration                                                     UMOUNT(8)

NAME
       umount - unmount file systems

SYNOPSIS
       umount -a [-dflnrv] [-t fstype] [-O option...]

       umount [-dflnrv] {directory|device}...

       umount -h|-V

DESCRIPTION
       The umount command detaches the mentioned file system(s) from the file hierarchy.  A file system is specified by giving the directory where
       it has been mounted.  Giving the special device on which the file system lives may also work, but is obsolete, mainly because it will  fail
       in case this device was mounted on more than one directory.

       Note  that a file system cannot be unmounted when it is 'busy' - for example, when there are open files on it, or when some process has its
       working directory there, or when a swap file on it is in use.  The offending process could even be umount itself - it opens libc, and  libc
       in its turn may open for example locale files.  A lazy unmount avoids this problem.

OPTIONS
       -a, --all
              All of the filesystems described in /proc/self/mountinfo (or in deprecated /etc/mtab) are unmounted, except the proc, devfs, devpts,
              sysfs, rpc_pipefs and nfsd filesystems. This list of the filesystems may be replaced by --types umount option.

       -A, --all-targets
              Unmount all mountpoints in the current namespace for the specified filesystem.  The filesystem can be specified by one of the mount‐
              points  or  the  device name (or UUID, etc.).  When this option is used together with --recursive, then all nested mounts within the
              filesystem are recursively unmounted.  This option is only supported on systems where /etc/mtab is a symlink to /proc/mounts.

       -c, --no-canonicalize
              Do not canonicalize paths.  The paths canonicalization is based on stat(2) and readlink(2) system calls. These system calls may hang
              in some cases (for example on NFS if server is not available). The option has to be used with canonical path to the mount point.

              For  more  details  about this option see the mount(8) man page. Note that umount does not pass this option to the /sbin/umount.type
              helpers.

       -d, --detach-loop
              When the unmounted device was a loop device, also free this loop device. This option  is  unnecessary  for  devices  initialized  by
              mount(8), in this case "autoclear" functionality is enabled by default.

       --fake Causes  everything  to be done except for the actual system call or umount helper execution; this 'fakes' unmounting the filesystem.
              It can be used to remove entries from the deprecated /etc/mtab that were unmounted earlier with the -n option.

       -f, --force
              Force an unmount (in case of an unreachable NFS system).  (Requires kernel 2.1.116 or later.)

              Note that this option does not guarantee that umount command does not hang.  It's strongly recommended to use absolute paths without
              symlinks to avoid unwanted readlink and stat system calls on unreachable NFS in umount.

       -i, --internal-only
              Do not call the /sbin/umount.filesystem helper even if it exists.  By default such a helper program is called if it exists.

       -l, --lazy
              Lazy  unmount.   Detach  the filesystem from the file hierarchy now, and clean up all references to this filesystem as soon as it is
              not busy anymore.  (Requires kernel 2.4.11 or later.)

       -n, --no-mtab
              Unmount without writing in /etc/mtab.

       -O, --test-opts option...
              Unmount only the filesystems that have the specified option set in /etc/fstab.  More than one option may be specified  in  a  comma-
              separated list.  Each option can be prefixed with no to indicate that no action should be taken for this option.

       -R, --recursive
              Recursively  unmount  each  specified directory.  Recursion for each directory will stop if any unmount operation in the chain fails
              for any reason.  The relationship between mountpoints is determined by /proc/self/mountinfo entries.  The filesystem must be  speci‐
              fied by mountpoint path; a recursive unmount by device name (or UUID) is unsupported.

       -r, --read-only
              When an unmount fails, try to remount the filesystem read-only.

       -t, --types type...
              Indicate  that  the  actions  should  only  be taken on filesystems of the specified type.  More than one type may be specified in a
              comma-separated list.  The list of filesystem types can be prefixed with no to indicate that no action should be taken  for  all  of
              the  mentioned types.   Note that umount reads information about mounted filesystems from kernel (/proc/mounts) and filesystem names
              may be different than filesystem names used in the /etc/fstab (e.g. "nfs4" vs. "nfs").

       -v, --verbose
              Verbose mode.

       -V, --version
              Display version information and exit.

       -h, --help
              Display help text and exit.

LOOP DEVICE
       The umount command will automatically detach loop device previously initialized by mount(8) command independently of /etc/mtab.

       In this case the device is initialized with "autoclear" flag (see losetup(8) output for more details), otherwise it's necessary to use  the
       option  --detach-loop or call losetup -d <device>. The autoclear feature is supported since Linux 2.6.25.

EXTERNAL HELPERS
       The syntax of external unmount helpers is:

              umount.suffix {directory|device} [-flnrv] [-t type.subtype]

       where  suffix  is  the  filesystem  type  (or the value from a uhelper= or helper= marker in the mtab file).  The -t option can be used for
       filesystems that have subtype support.  For example:

              umount.fuse -t fuse.sshfs

       A uhelper=something marker (unprivileged helper) can appear in the /etc/mtab file when ordinary users need to be able to unmount  a  mount‐
       point that is not defined in /etc/fstab (for example for a device that was mounted by udisks(1)).

       A helper=type marker in the mtab file will redirect all unmount requests to the /sbin/umount.type helper independently of UID.

       Note that /etc/mtab is currently deprecated and helper= and another userspace mount options are maintained by libmount.

FILES
       /etc/mtab
              table of mounted filesystems (deprecated and usually replaced by symlink to /proc/mounts)

       /etc/fstab
              table of known filesystems

       /proc/self/mountinfo
              table of mounted filesystems generated by kernel.

ENVIRONMENT
       LIBMOUNT_FSTAB=<path>
              overrides the default location of the fstab file (ignored for suid)

       LIBMOUNT_MTAB=<path>
              overrides the default location of the mtab file (ignored for suid)

       LIBMOUNT_DEBUG=all
              enables libmount debug output

SEE ALSO
       umount(2), losetup(8), mount(8)

HISTORY
       A umount command appeared in Version 6 AT&T UNIX.

AVAILABILITY
       The  umount  command  is  part of the util-linux package and is available from Linux Kernel Archive ⟨https://www.kernel.org/pub/linux/utils
       /util-linux/⟩.

util-linux                                                           July 2014                                                           UMOUNT(8)
UMOUNT(2)                                                    Linux Programmer's Manual                                                   UMOUNT(2)

NAME
       umount, umount2 - unmount filesystem

SYNOPSIS
       #include <sys/mount.h>

       int umount(const char *target);

       int umount2(const char *target, int flags);

DESCRIPTION
       umount() and umount2() remove the attachment of the (topmost) filesystem mounted on target.

       Appropriate privilege (Linux: the CAP_SYS_ADMIN capability) is required to unmount filesystems.

       Linux  2.1.116 added the umount2() system call, which, like umount(), unmounts a target, but allows additional flags controlling the behav‐
       ior of the operation:

       MNT_FORCE (since Linux 2.1.116)
              Force unmount even if busy.  This can cause data loss.  (Only for NFS mounts.)

       MNT_DETACH (since Linux 2.4.11)
              Perform a lazy unmount: make the mount point unavailable for new accesses, immediately disconnect the filesystem and all filesystems
              mounted below it from each other and from the mount table, and actually perform the unmount when the mount point ceases to be busy.

       MNT_EXPIRE (since Linux 2.6.8)
              Mark  the  mount point as expired.  If a mount point is not currently in use, then an initial call to umount2() with this flag fails
              with the error EAGAIN, but marks the mount point as expired.  The mount point remains expired as long as it isn't  accessed  by  any
              process.   A second umount2() call specifying MNT_EXPIRE unmounts an expired mount point.  This flag cannot be specified with either
              MNT_FORCE or MNT_DETACH.

       UMOUNT_NOFOLLOW (since Linux 2.6.34)
              Don't dereference target if it is a symbolic link.  This flag allows security problems to be avoided  in  set-user-ID-root  programs
              that allow unprivileged users to unmount filesystems.

RETURN VALUE
       On success, zero is returned.  On error, -1 is returned, and errno is set appropriately.

ERRORS
       The  error values given below result from filesystem type independent errors.  Each filesystem type may have its own special errors and its
       own special behavior.  See the Linux kernel source code for details.

       EAGAIN A call to umount2() specifying MNT_EXPIRE successfully marked an unbusy filesystem as expired.

       EBUSY  target could not be unmounted because it is busy.

       EFAULT target points outside the user address space.

       EINVAL target is not a mount point.

       EINVAL umount2() was called with MNT_EXPIRE and either MNT_DETACH or MNT_FORCE.

       EINVAL (since Linux 2.6.34)
              umount2() was called with an invalid flag value in flags.

       ENAMETOOLONG
              A pathname was longer than MAXPATHLEN.

       ENOENT A pathname was empty or had a nonexistent component.

       ENOMEM The kernel could not allocate a free page to copy filenames or data into.

       EPERM  The caller does not have the required privileges.

VERSIONS
       MNT_DETACH and MNT_EXPIRE are available in glibc since version 2.11.

CONFORMING TO
       These functions are Linux-specific and should not be used in programs intended to be portable.

NOTES
   umount() and shared mount points
       Shared mount points cause any mount activity on a mount point, including umount(2) operations, to be forwarded to every shared mount  point
       in the peer group and every slave mount of that peer group.  This means that umount(2) of any peer in a set of shared mounts will cause all
       of its peers to be unmounted and all of their slaves to be unmounted as well.

       This propagation of unmount activity can be particularly surprising on systems where every mount point is shared by default.  On such  sys‐
       tems,  recursively  bind mounting the root directory of the filesystem onto a subdirectory and then later unmounting that subdirectory with
       MNT_DETACH will cause every mount in the mount namespace to be lazily unmounted.

       To ensure umount(2) does not propagate in this fashion, the mount point may be remounted using a mount(2) call with a mount_flags  argument
       that includes both MS_REC and MS_PRIVATE prior to umount(2) being called.

   Historical details
       The  original umount() function was called as umount(device) and would return ENOTBLK when called with something other than a block device.
       In Linux 0.98p4, a call umount(dir) was added, in order to support anonymous devices.  In Linux 2.3.99-pre7, the  call  umount(device)  was
       removed, leaving only umount(dir) (since now devices can be mounted in more than one place, so specifying the device does not suffice).

SEE ALSO
       mount(2), path_resolution(7), mount(8), umount(8)

COLOPHON
       This  page is part of release 4.04 of the Linux man-pages project.  A description of the project, information about reporting bugs, and the
       latest version of this page, can be found at http://www.kernel.org/doc/man-pages/.

Linux                                                               2015-03-29                                                           UMOUNT(2)
