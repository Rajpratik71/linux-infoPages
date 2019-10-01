File: libc.info,  Node: Mount-Unmount-Remount,  Prev: Mount Information,  Up: Filesystem Handling

31.3.2 Mount, Unmount, Remount
------------------------------

This section describes the functions for mounting, unmounting, and
remounting filesystems.

   Only the superuser can mount, unmount, or remount a filesystem.

   These functions do not access the 'fstab' and 'mtab' files.  You
should maintain and use these separately.  *Note Mount Information::.

   The symbols in this section are declared in 'sys/mount.h'.

 -- Function: int mount (const char *SPECIAL_FILE, const char *DIR,
          const char *FSTYPE, unsigned long int OPTIONS, const void
          *DATA)
     Preliminary: | MT-Safe | AS-Safe | AC-Safe | *Note POSIX Safety
     Concepts::.

     'mount' mounts or remounts a filesystem.  The two operations are
     quite different and are merged rather unnaturally into this one
     function.  The 'MS_REMOUNT' option, explained below, determines
     whether 'mount' mounts or remounts.

     For a mount, the filesystem on the block device represented by the
     device special file named SPECIAL_FILE gets mounted over the mount
     point DIR.  This means that the directory DIR (along with any files
     in it) is no longer visible; in its place (and still with the name
     DIR) is the root directory of the filesystem on the device.

     As an exception, if the filesystem type (see below) is one which is
     not based on a device (e.g.  "proc"), 'mount' instantiates a
     filesystem and mounts it over DIR and ignores SPECIAL_FILE.

     For a remount, DIR specifies the mount point where the filesystem
     to be remounted is (and remains) mounted and SPECIAL_FILE is
     ignored.  Remounting a filesystem means changing the options that
     control operations on the filesystem while it is mounted.  It does
     not mean unmounting and mounting again.

     For a mount, you must identify the type of the filesystem as
     FSTYPE.  This type tells the kernel how to access the filesystem
     and can be thought of as the name of a filesystem driver.  The
     acceptable values are system dependent.  On a system with a Linux
     kernel and the 'proc' filesystem, the list of possible values is in
     the file 'filesystems' in the 'proc' filesystem (e.g.  type 'cat
     /proc/filesystems' to see the list).  With a Linux kernel, the
     types of filesystems that 'mount' can mount, and their type names,
     depends on what filesystem drivers are configured into the kernel
     or loaded as loadable kernel modules.  An example of a common value
     for FSTYPE is 'ext2'.

     For a remount, 'mount' ignores FSTYPE.

     OPTIONS specifies a variety of options that apply until the
     filesystem is unmounted or remounted.  The precise meaning of an
     option depends on the filesystem and with some filesystems, an
     option may have no effect at all.  Furthermore, for some
     filesystems, some of these options (but never 'MS_RDONLY') can be
     overridden for individual file accesses via 'ioctl'.

     OPTIONS is a bit string with bit fields defined using the following
     mask and masked value macros:

     'MS_MGC_MASK'
          This multibit field contains a magic number.  If it does not
          have the value 'MS_MGC_VAL', 'mount' assumes all the following
          bits are zero and the DATA argument is a null string,
          regardless of their actual values.

     'MS_REMOUNT'
          This bit on means to remount the filesystem.  Off means to
          mount it.

     'MS_RDONLY'
          This bit on specifies that no writing to the filesystem shall
          be allowed while it is mounted.  This cannot be overridden by
          'ioctl'.  This option is available on nearly all filesystems.

     'S_IMMUTABLE'
          This bit on specifies that no writing to the files in the
          filesystem shall be allowed while it is mounted.  This can be
          overridden for a particular file access by a properly
          privileged call to 'ioctl'.  This option is a relatively new
          invention and is not available on many filesystems.

     'S_APPEND'
          This bit on specifies that the only file writing that shall be
          allowed while the filesystem is mounted is appending.  Some
          filesystems allow this to be overridden for a particular
          process by a properly privileged call to 'ioctl'.  This is a
          relatively new invention and is not available on many
          filesystems.

     'MS_NOSUID'
          This bit on specifies that Setuid and Setgid permissions on
          files in the filesystem shall be ignored while it is mounted.

     'MS_NOEXEC'
          This bit on specifies that no files in the filesystem shall be
          executed while the filesystem is mounted.

     'MS_NODEV'
          This bit on specifies that no device special files in the
          filesystem shall be accessible while the filesystem is
          mounted.

     'MS_SYNCHRONOUS'
          This bit on specifies that all writes to the filesystem while
          it is mounted shall be synchronous; i.e., data shall be synced
          before each write completes rather than held in the buffer
          cache.

     'MS_MANDLOCK'
          This bit on specifies that mandatory locks on files shall be
          permitted while the filesystem is mounted.

     'MS_NOATIME'
          This bit on specifies that access times of files shall not be
          updated when the files are accessed while the filesystem is
          mounted.

     'MS_NODIRATIME'
          This bit on specifies that access times of directories shall
          not be updated when the directories are accessed while the
          filesystem in mounted.

     Any bits not covered by the above masks should be set off;
     otherwise, results are undefined.

     The meaning of DATA depends on the filesystem type and is
     controlled entirely by the filesystem driver in the kernel.

     Example:

          #include <sys/mount.h>

          mount("/dev/hdb", "/cdrom", MS_MGC_VAL | MS_RDONLY | MS_NOSUID, "");

          mount("/dev/hda2", "/mnt", MS_MGC_VAL | MS_REMOUNT, "");

     Appropriate arguments for 'mount' are conventionally recorded in
     the 'fstab' table.  *Note Mount Information::.

     The return value is zero if the mount or remount is successful.
     Otherwise, it is '-1' and 'errno' is set appropriately.  The values
     of 'errno' are filesystem dependent, but here is a general list:

     'EPERM'
          The process is not superuser.
     'ENODEV'
          The file system type FSTYPE is not known to the kernel.
     'ENOTBLK'
          The file DEV is not a block device special file.
     'EBUSY'

             * The device is already mounted.

             * The mount point is busy.  (E.g.  it is some process'
               working directory or has a filesystem mounted on it
               already).

             * The request is to remount read-only, but there are files
               open for write.

     'EINVAL'

             * A remount was attempted, but there is no filesystem
               mounted over the specified mount point.

             * The supposed filesystem has an invalid superblock.

     'EACCES'

             * The filesystem is inherently read-only (possibly due to a
               switch on the device) and the process attempted to mount
               it read/write (by setting the 'MS_RDONLY' bit off).

             * SPECIAL_FILE or DIR is not accessible due to file
               permissions.

             * SPECIAL_FILE is not accessible because it is in a
               filesystem that is mounted with the 'MS_NODEV' option.

     'EM_FILE'
          The table of dummy devices is full.  'mount' needs to create a
          dummy device (aka "unnamed" device) if the filesystem being
          mounted is not one that uses a device.

 -- Function: int umount2 (const char *FILE, int FLAGS)
     Preliminary: | MT-Safe | AS-Safe | AC-Safe | *Note POSIX Safety
     Concepts::.

     'umount2' unmounts a filesystem.

     You can identify the filesystem to unmount either by the device
     special file that contains the filesystem or by the mount point.
     The effect is the same.  Specify either as the string FILE.

     FLAGS contains the one-bit field identified by the following mask
     macro:

     'MNT_FORCE'
          This bit on means to force the unmounting even if the
          filesystem is busy, by making it unbusy first.  If the bit is
          off and the filesystem is busy, 'umount2' fails with 'errno' =
          'EBUSY'.  Depending on the filesystem, this may override all,
          some, or no busy conditions.

     All other bits in FLAGS should be set to zero; otherwise, the
     result is undefined.

     Example:

          #include <sys/mount.h>

          umount2("/mnt", MNT_FORCE);

          umount2("/dev/hdd1", 0);

     After the filesystem is unmounted, the directory that was the mount
     point is visible, as are any files in it.

     As part of unmounting, 'umount2' syncs the filesystem.

     If the unmounting is successful, the return value is zero.
     Otherwise, it is '-1' and 'errno' is set accordingly:

     'EPERM'
          The process is not superuser.
     'EBUSY'
          The filesystem cannot be unmounted because it is busy.  E.g.
          it contains a directory that is some process's working
          directory or a file that some process has open.  With some
          filesystems in some cases, you can avoid this failure with the
          'MNT_FORCE' option.

     'EINVAL'
          FILE validly refers to a file, but that file is neither a
          mount point nor a device special file of a currently mounted
          filesystem.

     This function is not available on all systems.

 -- Function: int umount (const char *FILE)
     Preliminary: | MT-Safe | AS-Safe | AC-Safe | *Note POSIX Safety
     Concepts::.

     'umount' does the same thing as 'umount2' with FLAGS set to zeroes.
     It is more widely available than 'umount2' but since it lacks the
     possibility to forcefully unmount a filesystem is deprecated when
     'umount2' is also available.

