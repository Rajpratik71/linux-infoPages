File: libc.info,  Node: File Size,  Next: Storage Allocation,  Prev: File Times,  Up: File Attributes

14.9.10 File Size
-----------------

Normally file sizes are maintained automatically.  A file begins with a
size of 0 and is automatically extended when data is written past its
end.  It is also possible to empty a file completely by an 'open' or
'fopen' call.

   However, sometimes it is necessary to _reduce_ the size of a file.
This can be done with the 'truncate' and 'ftruncate' functions.  They
were introduced in BSD Unix.  'ftruncate' was later added to POSIX.1.

   Some systems allow you to extend a file (creating holes) with these
functions.  This is useful when using memory-mapped I/O (*note
Memory-mapped I/O::), where files are not automatically extended.
However, it is not portable but must be implemented if 'mmap' allows
mapping of files (i.e., '_POSIX_MAPPED_FILES' is defined).

   Using these functions on anything other than a regular file gives
_undefined_ results.  On many systems, such a call will appear to
succeed, without actually accomplishing anything.

 -- Function: int truncate (const char *FILENAME, off_t LENGTH)
     Preliminary: | MT-Safe | AS-Safe | AC-Safe | *Note POSIX Safety
     Concepts::.

     The 'truncate' function changes the size of FILENAME to LENGTH.  If
     LENGTH is shorter than the previous length, data at the end will be
     lost.  The file must be writable by the user to perform this
     operation.

     If LENGTH is longer, holes will be added to the end.  However, some
     systems do not support this feature and will leave the file
     unchanged.

     When the source file is compiled with '_FILE_OFFSET_BITS == 64' the
     'truncate' function is in fact 'truncate64' and the type 'off_t'
     has 64 bits which makes it possible to handle files up to 2^63
     bytes in length.

     The return value is 0 for success, or -1 for an error.  In addition
     to the usual file name errors, the following errors may occur:

     'EACCES'
          The file is a directory or not writable.

     'EINVAL'
          LENGTH is negative.

     'EFBIG'
          The operation would extend the file beyond the limits of the
          operating system.

     'EIO'
          A hardware I/O error occurred.

     'EPERM'
          The file is "append-only" or "immutable".

     'EINTR'
          The operation was interrupted by a signal.

 -- Function: int truncate64 (const char *NAME, off64_t LENGTH)
     Preliminary: | MT-Safe | AS-Safe | AC-Safe | *Note POSIX Safety
     Concepts::.

     This function is similar to the 'truncate' function.  The
     difference is that the LENGTH argument is 64 bits wide even on 32
     bits machines, which allows the handling of files with sizes up to
     2^63 bytes.

     When the source file is compiled with '_FILE_OFFSET_BITS == 64' on
     a 32 bits machine this function is actually available under the
     name 'truncate' and so transparently replaces the 32 bits
     interface.

 -- Function: int ftruncate (int FD, off_t LENGTH)
     Preliminary: | MT-Safe | AS-Safe | AC-Safe | *Note POSIX Safety
     Concepts::.

     This is like 'truncate', but it works on a file descriptor FD for
     an opened file instead of a file name to identify the object.  The
     file must be opened for writing to successfully carry out the
     operation.

     The POSIX standard leaves it implementation defined what happens if
     the specified new LENGTH of the file is bigger than the original
     size.  The 'ftruncate' function might simply leave the file alone
     and do nothing or it can increase the size to the desired size.  In
     this later case the extended area should be zero-filled.  So using
     'ftruncate' is no reliable way to increase the file size but if it
     is possible it is probably the fastest way.  The function also
     operates on POSIX shared memory segments if these are implemented
     by the system.

     'ftruncate' is especially useful in combination with 'mmap'.  Since
     the mapped region must have a fixed size one cannot enlarge the
     file by writing something beyond the last mapped page.  Instead one
     has to enlarge the file itself and then remap the file with the new
     size.  The example below shows how this works.

     When the source file is compiled with '_FILE_OFFSET_BITS == 64' the
     'ftruncate' function is in fact 'ftruncate64' and the type 'off_t'
     has 64 bits which makes it possible to handle files up to 2^63
     bytes in length.

     The return value is 0 for success, or -1 for an error.  The
     following errors may occur:

     'EBADF'
          FD does not correspond to an open file.

     'EACCES'
          FD is a directory or not open for writing.

     'EINVAL'
          LENGTH is negative.

     'EFBIG'
          The operation would extend the file beyond the limits of the
          operating system.

     'EIO'
          A hardware I/O error occurred.

     'EPERM'
          The file is "append-only" or "immutable".

     'EINTR'
          The operation was interrupted by a signal.

 -- Function: int ftruncate64 (int ID, off64_t LENGTH)
     Preliminary: | MT-Safe | AS-Safe | AC-Safe | *Note POSIX Safety
     Concepts::.

     This function is similar to the 'ftruncate' function.  The
     difference is that the LENGTH argument is 64 bits wide even on 32
     bits machines which allows the handling of files with sizes up to
     2^63 bytes.

     When the source file is compiled with '_FILE_OFFSET_BITS == 64' on
     a 32 bits machine this function is actually available under the
     name 'ftruncate' and so transparently replaces the 32 bits
     interface.

   As announced here is a little example of how to use 'ftruncate' in
combination with 'mmap':

     int fd;
     void *start;
     size_t len;

     int
     add (off_t at, void *block, size_t size)
     {
       if (at + size > len)
         {
           /* Resize the file and remap.  */
           size_t ps = sysconf (_SC_PAGESIZE);
           size_t ns = (at + size + ps - 1) & ~(ps - 1);
           void *np;
           if (ftruncate (fd, ns) < 0)
             return -1;
           np = mmap (NULL, ns, PROT_READ|PROT_WRITE, MAP_SHARED, fd, 0);
           if (np == MAP_FAILED)
             return -1;
           start = np;
           len = ns;
         }
       memcpy ((char *) start + at, block, size);
       return 0;
     }

   The function 'add' writes a block of memory at an arbitrary position
in the file.  If the current size of the file is too small it is
extended.  Note the it is extended by a round number of pages.  This is
a requirement of 'mmap'.  The program has to keep track of the real
size, and when it has finished a final 'ftruncate' call should set the
real size of the file.

