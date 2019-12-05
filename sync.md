File: coreutils.info,  Node: sync invocation,  Next: truncate invocation,  Prev: stat invocation,  Up: Disk usage

14.4 ‘sync’: Synchronize cached writes to persistent storage
============================================================

‘sync’ synchronizes in memory files or file systems to persistent
storage.  Synopsis:

     sync [OPTION] [FILE]...

   ‘sync’ writes any data buffered in memory out to disk.  This can
include (but is not limited to) modified superblocks, modified inodes,
and delayed reads and writes.  This must be implemented by the kernel;
The ‘sync’ program does nothing but exercise the ‘sync’, ‘syncfs’,
‘fsync’, and ‘fdatasync’ system calls.

   The kernel keeps data in memory to avoid doing (relatively slow) disk
reads and writes.  This improves performance, but if the computer
crashes, data may be lost or the file system corrupted as a result.  The
‘sync’ command instructs the kernel to write data in memory to
persistent storage.

   If any argument is specified then only those files will be
synchronized using the fsync(2) syscall by default.

   If at least one file is specified, it is possible to change the
synchronization method with the following options.  Also see *note
Common options::.

‘-d’
‘--data’
     Use fdatasync(2) to sync only the data for the file, and any
     metadata required to maintain file system consistency.

‘-f’
‘--file-system’
     Synchronize all the I/O waiting for the file systems that contain
     the file, using the syscall syncfs(2).  Note you would usually
     _not_ specify this option if passing a device node like ‘/dev/sda’
     for example, as that would sync the containing file system rather
     than the referenced one.  Note also that depending on the system,
     passing individual device nodes or files may have different sync
     characteristics than using no arguments.  I.e., arguments passed to
     fsync(2) may provide greater guarantees through write barriers,
     than a global sync(2) used when no arguments are provided.

   An exit status of zero indicates success, and a nonzero value
indicates failure.

