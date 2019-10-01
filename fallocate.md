File: *manpages*,  Node: fallocate,  Up: (dir)

FALLOCATE(1)                     User Commands                    FALLOCATE(1)



NAME
       fallocate - preallocate or deallocate space to a file

SYNOPSIS
       fallocate [-c|-p|-z] [-o offset] -l length [-n] filename

       fallocate -d [-o offset] [-l length] filename

       fallocate -x [-o offset] -l length filename

DESCRIPTION
       fallocate  is  used  to manipulate the allocated disk space for a file,
       either to deallocate or preallocate it.  For filesystems which  support
       the  fallocate system call, preallocation is done quickly by allocating
       blocks and marking them as uninitialized, requiring no IO to  the  data
       blocks.   This  is  much faster than creating a file by filling it with
       zeroes.

       The exit code returned by fallocate is 0 on success and 1 on failure.

OPTIONS
       The length and offset arguments may be followed by  the  multiplicative
       suffixes  KiB  (=1024),  MiB (=1024*1024), and so on for GiB, TiB, PiB,
       EiB, ZiB, and YiB (the "iB" is optional, e.g., "K" has the same meaning
       as  "KiB")  or  the suffixes KB (=1000), MB (=1000*1000), and so on for
       GB, TB, PB, EB, ZB, and YB.

       The   options   --collapse-range,   --dig-holes,   --punch-hole,    and
       --zero-range are mutually exclusive.

       -c, --collapse-range
              Removes  a  byte range from a file, without leaving a hole.  The
              byte range to be collapsed starts at offset  and  continues  for
              length  bytes.  At the completion of the operation, the contents
              of the file starting  at  the  location  offset+length  will  be
              appended  at  the  location  offset, and the file will be length
              bytes smaller.  The option --keep-size may not be specified  for
              the collapse-range operation.

              Available  since  Linux  3.15  for  ext4  (only for extent-based
              files) and XFS.

       -d, --dig-holes
              Detect and dig holes.  This  makes  the  file  sparse  in-place,
              without  using  extra  disk space.  The minimum size of the hole
              depends on filesystem  I/O  block  size  (usually  4096  bytes).
              Also,  when  using  this  option, --keep-size is implied.  If no
              range is specified by --offset and  --length,  then  the  entire
              file is analyzed for holes.

              You  can  think of this option as doing a "cp --sparse" and then
              renaming the destination file to the original, without the  need
              for extra disk space.

              See --punch-hole for a list of supported filesystems.

       -i, --insert-range
              Insert  a  hole  of  length bytes from offset, shifting existing
              data.

       -l, --length length
              Specifies the length of the range, in bytes.

       -n, --keep-size
              Do not modify the apparent length of the file.  This may  effec‐
              tively  allocate  blocks  past  EOF, which can be removed with a
              truncate.

       -o, --offset offset
              Specifies the beginning offset of the range, in bytes.

       -p, --punch-hole
              Deallocates space (i.e., creates  a  hole)  in  the  byte  range
              starting  at offset and continuing for length bytes.  Within the
              specified range, partial filesystem blocks are zeroed, and whole
              filesystem blocks are removed from the file.  After a successful
              call, subsequent reads from this range will return zeroes.  This
              option may not be specified at the same time as the --zero-range
              option.  Also, when using this option, --keep-size is implied.

              Supported for XFS (since Linux 2.6.38), ext4 (since Linux  3.0),
              Btrfs (since Linux 3.7) and tmpfs (since Linux 3.5).

       -v, --verbose
              Enable verbose mode.

       -x, --posix
              Enable  POSIX operation mode.  In that mode allocation operation
              always completes, but it may take longer time when fast  alloca‐
              tion is not supported by the underlying filesystem.

       -z, --zero-range
              Zeroes space in the byte range starting at offset and continuing
              for length bytes.  Within the specified range, blocks are preal‐
              located  for the regions that span the holes in the file.  After
              a successful call, subsequent reads from this range will  return
              zeroes.

              Zeroing  is  done within the filesystem preferably by converting
              the range into unwritten extents.  This approach means that  the
              specified  range will not be physically zeroed out on the device
              (except for partial blocks at the either end of the range),  and
              I/O is (otherwise) required only to update metadata.

              Option --keep-size can be specified to prevent file length modi‐
              fication.

              Available since Linux  3.14  for  ext4  (only  for  extent-based
              files) and XFS.

       -V, --version
              Display version information and exit.

       -h, --help
              Display help text and exit.

AUTHORS
       Eric Sandeen ⟨sandeen@redhat.com⟩
       Karel Zak ⟨kzak@redhat.com⟩

SEE ALSO
       truncate(1), fallocate(2), posix_fallocate(3)

AVAILABILITY
       The  fallocate  command is part of the util-linux package and is avail‐
       able from Linux Kernel Archive  ⟨https://www.kernel.org/pub/linux/utils
       /util-linux/⟩.



util-linux                        April 2014                      FALLOCATE(1)
FALLOCATE(2)               Linux Programmer's Manual              FALLOCATE(2)



NAME
       fallocate - manipulate file space

SYNOPSIS
       #define _GNU_SOURCE             /* See feature_test_macros(7) */
       #include <fcntl.h>

       int fallocate(int fd, int mode, off_t offset, off_t len);

DESCRIPTION
       This  is  a nonportable, Linux-specific system call.  For the portable,
       POSIX.1-specified method of ensuring that  space  is  allocated  for  a
       file, see posix_fallocate(3).

       fallocate() allows the caller to directly manipulate the allocated disk
       space for the file referred to by fd for the  byte  range  starting  at
       offset and continuing for len bytes.

       The mode argument determines the operation to be performed on the given
       range.  Details of the supported operations are given  in  the  subsec‐
       tions below.

   Allocating disk space
       The default operation (i.e., mode is zero) of fallocate() allocates and
       initializes to zero the disk space within the range specified by offset
       and  len.   The  file  size (as reported by stat(2)) will be changed if
       offset+len is greater  than  the  file  size.   This  default  behavior
       closely  resembles the behavior of the posix_fallocate(3) library func‐
       tion, and is intended as a method of optimally implementing that  func‐
       tion.

       After  a successful call, subsequent writes into the range specified by
       offset and len are guaranteed not to  fail  because  of  lack  of  disk
       space.

       If  the  FALLOC_FL_KEEP_SIZE flag is specified in mode, the behavior of
       the call is similar, but the file size will not be changed even if off‐
       set+len  is  greater  than  the file size.  Preallocating zeroed blocks
       beyond the end of the file in this  manner  is  useful  for  optimizing
       append workloads.

       Because  allocation is done in block size chunks, fallocate() may allo‐
       cate a larger range of disk space than was specified.

   Deallocating file space
       Specifying the FALLOC_FL_PUNCH_HOLE flag (available since Linux 2.6.38)
       in  mode  deallocates  space  (i.e.,  creates a hole) in the byte range
       starting at offset and continuing for len bytes.  Within the  specified
       range,  partial  file  system  blocks are zeroed, and whole file system
       blocks are removed from the file.  After a successful call,  subsequent
       reads from this range will return zeroes.

       The  FALLOC_FL_PUNCH_HOLE flag must be ORed with FALLOC_FL_KEEP_SIZE in
       mode; in other words, even when punching off the end of the  file,  the
       file size (as reported by stat(2)) does not change.

       Not  all  file  systems  support FALLOC_FL_PUNCH_HOLE; if a file system
       doesn't support the operation, an error is returned.  The operation  is
       supported on at least the following filesystems:

       *  XFS (since Linux 2.6.38)

       *  ext4 (since Linux 3.0)

       *  Btrfs (since Linux 3.7)

       *  tmpfs (since Linux 3.5)

RETURN VALUE
       On  success,  fallocate()  returns  zero.  On error, -1 is returned and
       errno is set to indicate the error.

ERRORS
       EBADF  fd is not a valid file descriptor, or is not opened for writing.

       EFBIG  offset+len exceeds the maximum file size.

       EINTR  A signal was caught during execution.

       EINVAL offset was less than 0, or len was less than or equal to 0.

       EIO    An I/O error occurred while reading from or writing  to  a  file
              system.

       ENODEV fd does not refer to a regular file or a directory.  (If fd is a
              pipe or FIFO, a different error results.)

       ENOSPC There is not enough space left on the device containing the file
              referred to by fd.

       ENOSYS This kernel does not implement fallocate().

       EOPNOTSUPP
              The  file  system containing the file referred to by fd does not
              support this operation; or the mode is not supported by the file
              system containing the file referred to by fd.

       EPERM  The  file referred to by fd is marked immutable (see chattr(1)).
              Or: mode specifies FALLOC_FL_PUNCH_HOLE and the file referred to
              by fd is marked append-only (see chattr(1)).

       ESPIPE fd refers to a pipe or FIFO.

VERSIONS
       fallocate() is available on Linux since kernel 2.6.23.  Support is pro‐
       vided by glibc since version 2.10.  The FALLOC_FL_* flags  are  defined
       in glibc headers only since version 2.18.

CONFORMING TO
       fallocate() is Linux-specific.

SEE ALSO
       fallocate(1), ftruncate(2), posix_fadvise(3), posix_fallocate(3)

COLOPHON
       This  page  is  part of release 3.53 of the Linux man-pages project.  A
       description of the project, and information about reporting  bugs,  can
       be found at http://www.kernel.org/doc/man-pages/.



Linux                             2013-06-10                      FALLOCATE(2)
FALLOCATE(2)               Linux Programmer's Manual              FALLOCATE(2)



NAME
       fallocate - manipulate file space

SYNOPSIS
       #define _GNU_SOURCE             /* See feature_test_macros(7) */
       #include <fcntl.h>

       int fallocate(int fd, int mode, off_t offset, off_t len);

DESCRIPTION
       This  is  a nonportable, Linux-specific system call.  For the portable,
       POSIX.1-specified method of ensuring that  space  is  allocated  for  a
       file, see posix_fallocate(3).

       fallocate() allows the caller to directly manipulate the allocated disk
       space for the file referred to by fd for the  byte  range  starting  at
       offset and continuing for len bytes.

       The mode argument determines the operation to be performed on the given
       range.  Details of the supported operations are given  in  the  subsec‐
       tions below.

   Allocating disk space
       The default operation (i.e., mode is zero) of fallocate() allocates and
       initializes to zero the disk space within the range specified by offset
       and  len.   The  file  size (as reported by stat(2)) will be changed if
       offset+len is greater  than  the  file  size.   This  default  behavior
       closely  resembles the behavior of the posix_fallocate(3) library func‐
       tion, and is intended as a method of optimally implementing that  func‐
       tion.

       After  a successful call, subsequent writes into the range specified by
       offset and len are guaranteed not to  fail  because  of  lack  of  disk
       space.

       If  the  FALLOC_FL_KEEP_SIZE flag is specified in mode, the behavior of
       the call is similar, but the file size will not be changed even if off‐
       set+len  is  greater  than  the file size.  Preallocating zeroed blocks
       beyond the end of the file in this  manner  is  useful  for  optimizing
       append workloads.

       Because  allocation is done in block size chunks, fallocate() may allo‐
       cate a larger range of disk space than was specified.

   Deallocating file space
       Specifying the FALLOC_FL_PUNCH_HOLE flag (available since Linux 2.6.38)
       in  mode  deallocates  space  (i.e.,  creates a hole) in the byte range
       starting at offset and continuing for len bytes.  Within the  specified
       range,  partial  file  system  blocks are zeroed, and whole file system
       blocks are removed from the file.  After a successful call,  subsequent
       reads from this range will return zeroes.

       The  FALLOC_FL_PUNCH_HOLE flag must be ORed with FALLOC_FL_KEEP_SIZE in
       mode; in other words, even when punching off the end of the  file,  the
       file size (as reported by stat(2)) does not change.

       Not  all  file  systems  support FALLOC_FL_PUNCH_HOLE; if a file system
       doesn't support the operation, an error is returned.

RETURN VALUE
       On success, fallocate() returns zero.  On error,  -1  is  returned  and
       errno is set to indicate the error.

ERRORS
       EBADF  fd is not a valid file descriptor, or is not opened for writing.

       EFBIG  offset+len exceeds the maximum file size.

       EINTR  A signal was caught during execution.

       EINVAL offset was less than 0, or len was less than or equal to 0.

       EIO    An  I/O  error  occurred while reading from or writing to a file
              system.

       ENODEV fd does not refer to a regular file or a directory.  (If fd is a
              pipe or FIFO, a different error results.)

       ENOSPC There is not enough space left on the device containing the file
              referred to by fd.

       ENOSYS This kernel does not implement fallocate().

       EOPNOTSUPP
              The file system containing the file referred to by fd  does  not
              support this operation; or the mode is not supported by the file
              system containing the file referred to by fd.

       EPERM  The file referred to by fd is marked immutable (see  chattr(1)).
              Or: mode specifies FALLOC_FL_PUNCH_HOLE and the file referred to
              by fd is marked append-only (see chattr(1)).

       ESPIPE fd refers to a pipe or FIFO.

VERSIONS
       fallocate() is available on Linux since kernel 2.6.23.  Support is pro‐
       vided  by  glibc since version 2.10.  The FALLOC_FL_* flags are defined
       in glibc headers only since version 2.18.

CONFORMING TO
       fallocate() is Linux-specific.

SEE ALSO
       fallocate(1), ftruncate(2), posix_fadvise(3), posix_fallocate(3)

COLOPHON
       This page is part of release 3.53 of the Linux  man-pages  project.   A
       description  of  the project, and information about reporting bugs, can
       be found at http://www.kernel.org/doc/man-pages/.



Linux                             2013-06-10                      FALLOCATE(2)
