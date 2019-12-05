SWAPON(8)                                                                                   System Administration                                                                                   SWAPON(8)

NAME
       swapon, swapoff - enable/disable devices and files for paging and swapping

SYNOPSIS
       swapon [options] [specialfile...]
       swapoff [-va] [specialfile...]

DESCRIPTION
       swapon is used to specify devices on which paging and swapping are to take place.

       The device or file used is given by the specialfile parameter.  It may be of the form -L label or -U uuid to indicate a device by label or uuid.

       Calls to swapon normally occur in the system boot scripts making all swap devices available, so that the paging and swapping activity is interleaved across several devices and files.

       swapoff disables swapping on the specified devices and files.  When the -a flag is given, swapping is disabled on all known swap devices and files (as found in /proc/swaps or /etc/fstab).

OPTIONS
       -a, --all
              All devices marked as ``swap'' in /etc/fstab are made available, except for those with the ``noauto'' option.  Devices that are already being used as swap are silently skipped.

       -d, --discard[=policy]
              Enable  swap  discards, if the swap backing device supports the discard or trim operation.  This may improve performance on some Solid State Devices, but often it does not.  The option allows
              one to select between two available swap discard policies: --discard=once to perform a single-time discard operation for the whole swap area at swapon; or  --discard=pages  to  asynchronously
              discard  freed  swap  pages  before  they are available for reuse.  If no policy is selected, the default behavior is to enable both discard types.  The /etc/fstab mount options discard, dis‐
              card=once, or discard=pages may also be used to enable discard flags.

       -e, --ifexists
              Silently skip devices that do not exist.  The /etc/fstab mount option nofail may also be used to skip non-existing device.

       -f, --fixpgsz
              Reinitialize (exec mkswap) the swap space if its page size does not match that of the current running kernel.  mkswap(2) initializes the whole device and does not check for bad blocks.

       -h, --help
              Display help text and exit.

       -L label
              Use the partition that has the specified label.  (For this, access to /proc/partitions is needed.)

       -o, --options opts
              Specify swap options by an fstab-compatible comma-separated string.  For example:

                     swapon -o pri=1,discard=pages,nofail /dev/sda2

              The opts string is evaluated last and overrides all other command line options.

       -p, --priority priority
              Specify the priority of the swap device.  priority is a value between -1 and 32767.  Higher numbers indicate higher priority.  See swapon(2) for a full description of  swap  priorities.   Add
              pri=value to the option field of /etc/fstab for use with swapon -a.  When no priority is defined, it defaults to -1.

       -s, --summary
              Display swap usage summary by device.  Equivalent to "cat /proc/swaps".  This output format is DEPRECATED in favour of --show that provides better control on output data.

       --show[=column...]
              Display a definable table of swap areas.  See the --help output for a list of available columns.

       --output-all
              Output all available columns.

       --noheadings
              Do not print headings when displaying --show output.

       --raw  Display --show output without aligning table columns.

       --bytes
              Display swap size in bytes in --show output instead of in user-friendly units.

       -U uuid
              Use the partition that has the specified uuid.

       -v, --verbose
              Be verbose.

       -V, --version
              Display version information and exit.

NOTES
   Files with holes
       The  swap  file  implementation  in  the kernel expects to be able to write to the file directly, without the assistance of the filesystem.  This is a problem on files with holes or on copy-on-write
       files on filesystems like Btrfs.

       Commands like cp(1) or truncate(1) create files with holes.  These files will be rejected by swapon.

       Preallocated files created by fallocate(1) may be interpreted as files with holes too depending of the filesystem.  Preallocated swap files are supported on XFS since Linux 4.18.

       The most portable solution to create a swap file is to use dd(1) and /dev/zero.

   Btrfs
       Swap files on Btrfs are supported since Linux 5.0 on files with nocow attribute.  See the btrfs(5) manual page for more details.

   NFS
       Swap over NFS may not work.

   Suspend
       swapon automatically detects and rewrites a swap space signature with old software suspend data (e.g. S1SUSPEND, S2SUSPEND, ...). The problem is that if we don't do it, then we get  data  corruption
       the next time an attempt at unsuspending is made.

ENVIRONMENT
       LIBMOUNT_DEBUG=all
              enables libmount debug output.

       LIBBLKID_DEBUG=all
              enables libblkid debug output.

SEE ALSO
       swapoff(2), swapon(2), fstab(5), init(8), fallocate(1), mkswap(8), mount(8), rc(8)

FILES
       /dev/sd??  standard paging devices
       /etc/fstab ascii filesystem description table

HISTORY
       The swapon command appeared in 4.0BSD.

AVAILABILITY
       The swapon command is part of the util-linux package and is available from https://www.kernel.org/pub/linux/utils/util-linux/.

util-linux                                                                                       October 2014                                                                                       SWAPON(8)
SWAPON(2)                                                                                 Linux Programmer's Manual                                                                                 SWAPON(2)

NAME
       swapon, swapoff - start/stop swapping to file/device

SYNOPSIS
       #include <unistd.h>
       #include <sys/swap.h>

       int swapon(const char *path, int swapflags);
       int swapoff(const char *path);

DESCRIPTION
       swapon() sets the swap area to the file or block device specified by path.  swapoff() stops swapping to the file or block device specified by path.

       If the SWAP_FLAG_PREFER flag is specified in the swapon() swapflags argument, the new swap area will have a higher priority than default.  The priority is encoded within swapflags as:

           (prio << SWAP_FLAG_PRIO_SHIFT) & SWAP_FLAG_PRIO_MASK

       If  the  SWAP_FLAG_DISCARD flag is specified in the swapon() swapflags argument, freed swap pages will be discarded before they are reused, if the swap device supports the discard or trim operation.
       (This may improve performance on some Solid State Devices, but often it does not.)  See also NOTES.

       These functions may be used only by a privileged process (one having the CAP_SYS_ADMIN capability).

   Priority
       Each swap area has a priority, either high or low.  The default priority is low.  Within the low-priority areas, newer areas are even lower priority than older areas.

       All priorities set with swapflags are high-priority, higher than default.  They may have any nonnegative value chosen by the caller.  Higher numbers mean higher priority.

       Swap pages are allocated from areas in priority order, highest priority first.  For areas with different priorities, a higher-priority area is exhausted before using a lower-priority area.   If  two
       or more areas have the same priority, and it is the highest priority available, pages are allocated on a round-robin basis between them.

       As of Linux 1.3.6, the kernel usually follows these rules, but there are exceptions.

RETURN VALUE
       On success, zero is returned.  On error, -1 is returned, and errno is set appropriately.

ERRORS
       EBUSY  (for swapon()) The specified path is already being used as a swap area.

       EINVAL The file path exists, but refers neither to a regular file nor to a block device;

       EINVAL (swapon()) The indicated path does not contain a valid swap signature or resides on an in-memory filesystem such as tmpfs(5).

       EINVAL (since Linux 3.4)
              (swapon()) An invalid flag value was specified in flags.

       EINVAL (swapoff()) path is not currently a swap area.

       ENFILE The system-wide limit on the total number of open files has been reached.

       ENOENT The file path does not exist.

       ENOMEM The system has insufficient memory to start swapping.

       EPERM  The caller does not have the CAP_SYS_ADMIN capability.  Alternatively, the maximum number of swap files are already in use; see NOTES below.

CONFORMING TO
       These functions are Linux-specific and should not be used in programs intended to be portable.  The second swapflags argument was introduced in Linux 1.3.2.

NOTES
       The partition or path must be prepared with mkswap(8).

       There  is an upper limit on the number of swap files that may be used, defined by the kernel constant MAX_SWAPFILES.  Before kernel 2.4.10, MAX_SWAPFILES has the value 8; since kernel 2.4.10, it has
       the value 32.  Since kernel 2.6.18, the limit is decreased by 2 (thus: 30) if the kernel is built with the CONFIG_MIGRATION option (which reserves two swap table entries for the page migration  fea‐
       tures of mbind(2) and migrate_pages(2)).  Since kernel 2.6.32, the limit is further decreased by 1 if the kernel is built with the CONFIG_MEMORY_FAILURE option.

       Discard  of  swap pages was introduced in kernel 2.6.29, then made conditional on the SWAP_FLAG_DISCARD flag in kernel 2.6.36, which still discards the entire swap area when swapon() is called, even
       if that flag bit is not set.

SEE ALSO
       mkswap(8), swapoff(8), swapon(8)

COLOPHON
       This page is part of release 5.02 of the Linux man-pages project.  A description of the project,  information  about  reporting  bugs,  and  the  latest  version  of  this  page,  can  be  found  at
       https://www.kernel.org/doc/man-pages/.

Linux                                                                                             2017-09-15                                                                                        SWAPON(2)
