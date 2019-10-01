File: libc.info,  Node: Memory-mapped I/O,  Next: Waiting for I/O,  Prev: Scatter-Gather,  Up: Low-Level I/O

13.7 Memory-mapped I/O
======================

On modern operating systems, it is possible to "mmap" (pronounced
"em-map") a file to a region of memory.  When this is done, the file can
be accessed just like an array in the program.

   This is more efficient than 'read' or 'write', as only the regions of
the file that a program actually accesses are loaded.  Accesses to
not-yet-loaded parts of the mmapped region are handled in the same way
as swapped out pages.

   Since mmapped pages can be stored back to their file when physical
memory is low, it is possible to mmap files orders of magnitude larger
than both the physical memory _and_ swap space.  The only limit is
address space.  The theoretical limit is 4GB on a 32-bit machine -
however, the actual limit will be smaller since some areas will be
reserved for other purposes.  If the LFS interface is used the file size
on 32-bit systems is not limited to 2GB (offsets are signed which
reduces the addressable area of 4GB by half); the full 64-bit are
available.

   Memory mapping only works on entire pages of memory.  Thus, addresses
for mapping must be page-aligned, and length values will be rounded up.
To determine the size of a page the machine uses one should use

     size_t page_size = (size_t) sysconf (_SC_PAGESIZE);

These functions are declared in 'sys/mman.h'.

 -- Function: void * mmap (void *ADDRESS, size_t LENGTH, int PROTECT,
          int FLAGS, int FILEDES, off_t OFFSET)
     Preliminary: | MT-Safe | AS-Safe | AC-Safe | *Note POSIX Safety
     Concepts::.

     The 'mmap' function creates a new mapping, connected to bytes
     (OFFSET) to (OFFSET + LENGTH - 1) in the file open on FILEDES.  A
     new reference for the file specified by FILEDES is created, which
     is not removed by closing the file.

     ADDRESS gives a preferred starting address for the mapping.  'NULL'
     expresses no preference.  Any previous mapping at that address is
     automatically removed.  The address you give may still be changed,
     unless you use the 'MAP_FIXED' flag.

     PROTECT contains flags that control what kind of access is
     permitted.  They include 'PROT_READ', 'PROT_WRITE', and
     'PROT_EXEC', which permit reading, writing, and execution,
     respectively.  Inappropriate access will cause a segfault (*note
     Program Error Signals::).

     Note that most hardware designs cannot support write permission
     without read permission, and many do not distinguish read and
     execute permission.  Thus, you may receive wider permissions than
     you ask for, and mappings of write-only files may be denied even if
     you do not use 'PROT_READ'.

     FLAGS contains flags that control the nature of the map.  One of
     'MAP_SHARED' or 'MAP_PRIVATE' must be specified.

     They include:

     'MAP_PRIVATE'
          This specifies that writes to the region should never be
          written back to the attached file.  Instead, a copy is made
          for the process, and the region will be swapped normally if
          memory runs low.  No other process will see the changes.

          Since private mappings effectively revert to ordinary memory
          when written to, you must have enough virtual memory for a
          copy of the entire mmapped region if you use this mode with
          'PROT_WRITE'.

     'MAP_SHARED'
          This specifies that writes to the region will be written back
          to the file.  Changes made will be shared immediately with
          other processes mmaping the same file.

          Note that actual writing may take place at any time.  You need
          to use 'msync', described below, if it is important that other
          processes using conventional I/O get a consistent view of the
          file.

     'MAP_FIXED'
          This forces the system to use the exact mapping address
          specified in ADDRESS and fail if it can't.

     'MAP_ANONYMOUS'
     'MAP_ANON'
          This flag tells the system to create an anonymous mapping, not
          connected to a file.  FILEDES and OFF are ignored, and the
          region is initialized with zeros.

          Anonymous maps are used as the basic primitive to extend the
          heap on some systems.  They are also useful to share data
          between multiple tasks without creating a file.

          On some systems using private anonymous mmaps is more
          efficient than using 'malloc' for large blocks.  This is not
          an issue with the GNU C Library, as the included 'malloc'
          automatically uses 'mmap' where appropriate.

     'mmap' returns the address of the new mapping, or 'MAP_FAILED' for
     an error.

     Possible errors include:

     'EINVAL'

          Either ADDRESS was unusable, or inconsistent FLAGS were given.

     'EACCES'

          FILEDES was not open for the type of access specified in
          PROTECT.

     'ENOMEM'

          Either there is not enough memory for the operation, or the
          process is out of address space.

     'ENODEV'

          This file is of a type that doesn't support mapping.

     'ENOEXEC'

          The file is on a filesystem that doesn't support mapping.

 -- Function: void * mmap64 (void *ADDRESS, size_t LENGTH, int PROTECT,
          int FLAGS, int FILEDES, off64_t OFFSET)
     Preliminary: | MT-Safe | AS-Safe | AC-Safe | *Note POSIX Safety
     Concepts::.

     The 'mmap64' function is equivalent to the 'mmap' function but the
     OFFSET parameter is of type 'off64_t'.  On 32-bit systems this
     allows the file associated with the FILEDES descriptor to be larger
     than 2GB. FILEDES must be a descriptor returned from a call to
     'open64' or 'fopen64' and 'freopen64' where the descriptor is
     retrieved with 'fileno'.

     When the sources are translated with '_FILE_OFFSET_BITS == 64' this
     function is actually available under the name 'mmap'.  I.e., the
     new, extended API using 64 bit file sizes and offsets transparently
     replaces the old API.

 -- Function: int munmap (void *ADDR, size_t LENGTH)
     Preliminary: | MT-Safe | AS-Safe | AC-Safe | *Note POSIX Safety
     Concepts::.

     'munmap' removes any memory maps from (ADDR) to (ADDR + LENGTH).
     LENGTH should be the length of the mapping.

     It is safe to unmap multiple mappings in one command, or include
     unmapped space in the range.  It is also possible to unmap only
     part of an existing mapping.  However, only entire pages can be
     removed.  If LENGTH is not an even number of pages, it will be
     rounded up.

     It returns 0 for success and -1 for an error.

     One error is possible:

     'EINVAL'
          The memory range given was outside the user mmap range or
          wasn't page aligned.

 -- Function: int msync (void *ADDRESS, size_t LENGTH, int FLAGS)
     Preliminary: | MT-Safe | AS-Safe | AC-Safe | *Note POSIX Safety
     Concepts::.

     When using shared mappings, the kernel can write the file at any
     time before the mapping is removed.  To be certain data has
     actually been written to the file and will be accessible to
     non-memory-mapped I/O, it is necessary to use this function.

     It operates on the region ADDRESS to (ADDRESS + LENGTH).  It may be
     used on part of a mapping or multiple mappings, however the region
     given should not contain any unmapped space.

     FLAGS can contain some options:

     'MS_SYNC'

          This flag makes sure the data is actually written _to disk_.
          Normally 'msync' only makes sure that accesses to a file with
          conventional I/O reflect the recent changes.

     'MS_ASYNC'

          This tells 'msync' to begin the synchronization, but not to
          wait for it to complete.

     'msync' returns 0 for success and -1 for error.  Errors include:

     'EINVAL'
          An invalid region was given, or the FLAGS were invalid.

     'EFAULT'
          There is no existing mapping in at least part of the given
          region.

 -- Function: void * mremap (void *ADDRESS, size_t LENGTH, size_t
          NEW_LENGTH, int FLAG)
     Preliminary: | MT-Safe | AS-Safe | AC-Safe | *Note POSIX Safety
     Concepts::.

     This function can be used to change the size of an existing memory
     area.  ADDRESS and LENGTH must cover a region entirely mapped in
     the same 'mmap' statement.  A new mapping with the same
     characteristics will be returned with the length NEW_LENGTH.

     One option is possible, 'MREMAP_MAYMOVE'.  If it is given in FLAGS,
     the system may remove the existing mapping and create a new one of
     the desired length in another location.

     The address of the resulting mapping is returned, or -1.  Possible
     error codes include:

     'EFAULT'
          There is no existing mapping in at least part of the original
          region, or the region covers two or more distinct mappings.

     'EINVAL'
          The address given is misaligned or inappropriate.

     'EAGAIN'
          The region has pages locked, and if extended it would exceed
          the process's resource limit for locked pages.  *Note Limits
          on Resources::.

     'ENOMEM'
          The region is private writable, and insufficient virtual
          memory is available to extend it.  Also, this error will occur
          if 'MREMAP_MAYMOVE' is not given and the extension would
          collide with another mapped region.

   This function is only available on a few systems.  Except for
performing optional optimizations one should not rely on this function.

   Not all file descriptors may be mapped.  Sockets, pipes, and most
devices only allow sequential access and do not fit into the mapping
abstraction.  In addition, some regular files may not be mmapable, and
older kernels may not support mapping at all.  Thus, programs using
'mmap' should have a fallback method to use should it fail.  *Note
(standards)Mmap::.

 -- Function: int madvise (void *ADDR, size_t LENGTH, int ADVICE)
     Preliminary: | MT-Safe | AS-Safe | AC-Safe | *Note POSIX Safety
     Concepts::.

     This function can be used to provide the system with ADVICE about
     the intended usage patterns of the memory region starting at ADDR
     and extending LENGTH bytes.

     The valid BSD values for ADVICE are:

     'MADV_NORMAL'
          The region should receive no further special treatment.

     'MADV_RANDOM'
          The region will be accessed via random page references.  The
          kernel should page-in the minimal number of pages for each
          page fault.

     'MADV_SEQUENTIAL'
          The region will be accessed via sequential page references.
          This may cause the kernel to aggressively read-ahead,
          expecting further sequential references after any page fault
          within this region.

     'MADV_WILLNEED'
          The region will be needed.  The pages within this region may
          be pre-faulted in by the kernel.

     'MADV_DONTNEED'
          The region is no longer needed.  The kernel may free these
          pages, causing any changes to the pages to be lost, as well as
          swapped out pages to be discarded.

     The POSIX names are slightly different, but with the same meanings:

     'POSIX_MADV_NORMAL'
          This corresponds with BSD's 'MADV_NORMAL'.

     'POSIX_MADV_RANDOM'
          This corresponds with BSD's 'MADV_RANDOM'.

     'POSIX_MADV_SEQUENTIAL'
          This corresponds with BSD's 'MADV_SEQUENTIAL'.

     'POSIX_MADV_WILLNEED'
          This corresponds with BSD's 'MADV_WILLNEED'.

     'POSIX_MADV_DONTNEED'
          This corresponds with BSD's 'MADV_DONTNEED'.

     'madvise' returns 0 for success and -1 for error.  Errors include:

     'EINVAL'
          An invalid region was given, or the ADVICE was invalid.

     'EFAULT'
          There is no existing mapping in at least part of the given
          region.

 -- Function: int shm_open (const char *NAME, int OFLAG, mode_t MODE)
     Preliminary: | MT-Safe locale | AS-Unsafe init heap lock |
     AC-Unsafe lock mem fd | *Note POSIX Safety Concepts::.

     This function returns a file descriptor that can be used to
     allocate shared memory via mmap.  Unrelated processes can use same
     NAME to create or open existing shared memory objects.

     A NAME argument specifies the shared memory object to be opened.
     In the GNU C Library it must be a string smaller than 'NAME_MAX'
     bytes starting with an optional slash but containing no other
     slashes.

     The semantics of OFLAG and MODE arguments is same as in 'open'.

     'shm_open' returns the file descriptor on success or -1 on error.
     On failure 'errno' is set.

 -- Function: int shm_unlink (const char *NAME)
     Preliminary: | MT-Safe locale | AS-Unsafe init heap lock |
     AC-Unsafe lock mem fd | *Note POSIX Safety Concepts::.

     This function is inverse of 'shm_open' and removes the object with
     the given NAME previously created by 'shm_open'.

     'shm_unlink' returns 0 on success or -1 on error.  On failure
     'errno' is set.

