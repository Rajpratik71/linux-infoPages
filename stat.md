File: libc.info,  Node: Reading Attributes,  Next: Testing File Type,  Prev: Attribute Meanings,  Up: File Attributes

14.9.2 Reading the Attributes of a File
---------------------------------------

To examine the attributes of files, use the functions `stat', `fstat'
and `lstat'.  They return the attribute information in a `struct stat'
object.  All three functions are declared in the header file
`sys/stat.h'.

 -- Function: int stat (const char *FILENAME, struct stat *BUF)
     Preliminary: | MT-Safe | AS-Safe | AC-Safe | *Note POSIX Safety
     Concepts::.

     The `stat' function returns information about the attributes of the
     file named by FILENAME in the structure pointed to by BUF.

     If FILENAME is the name of a symbolic link, the attributes you get
     describe the file that the link points to.  If the link points to a
     nonexistent file name, then `stat' fails reporting a nonexistent
     file.

     The return value is `0' if the operation is successful, or `-1' on
     failure.  In addition to the usual file name errors (*note File
     Name Errors::, the following `errno' error conditions are defined
     for this function:

    `ENOENT'
          The file named by FILENAME doesn't exist.

     When the sources are compiled with `_FILE_OFFSET_BITS == 64' this
     function is in fact `stat64' since the LFS interface transparently
     replaces the normal implementation.

 -- Function: int stat64 (const char *FILENAME, struct stat64 *BUF)
     Preliminary: | MT-Safe | AS-Safe | AC-Safe | *Note POSIX Safety
     Concepts::.

     This function is similar to `stat' but it is also able to work on
     files larger than 2^31 bytes on 32-bit systems.  To be able to do
     this the result is stored in a variable of type `struct stat64' to
     which BUF must point.

     When the sources are compiled with `_FILE_OFFSET_BITS == 64' this
     function is available under the name `stat' and so transparently
     replaces the interface for small files on 32-bit machines.

 -- Function: int fstat (int FILEDES, struct stat *BUF)
     Preliminary: | MT-Safe | AS-Safe | AC-Safe | *Note POSIX Safety
     Concepts::.

     The `fstat' function is like `stat', except that it takes an open
     file descriptor as an argument instead of a file name.  *Note
     Low-Level I/O::.

     Like `stat', `fstat' returns `0' on success and `-1' on failure.
     The following `errno' error conditions are defined for `fstat':

    `EBADF'
          The FILEDES argument is not a valid file descriptor.

     When the sources are compiled with `_FILE_OFFSET_BITS == 64' this
     function is in fact `fstat64' since the LFS interface transparently
     replaces the normal implementation.

 -- Function: int fstat64 (int FILEDES, struct stat64 *BUF)
     Preliminary: | MT-Safe | AS-Safe | AC-Safe | *Note POSIX Safety
     Concepts::.

     This function is similar to `fstat' but is able to work on large
     files on 32-bit platforms.  For large files the file descriptor
     FILEDES should be obtained by `open64' or `creat64'.  The BUF
     pointer points to a variable of type `struct stat64' which is able
     to represent the larger values.

     When the sources are compiled with `_FILE_OFFSET_BITS == 64' this
     function is available under the name `fstat' and so transparently
     replaces the interface for small files on 32-bit machines.

 -- Function: int lstat (const char *FILENAME, struct stat *BUF)
     Preliminary: | MT-Safe | AS-Safe | AC-Safe | *Note POSIX Safety
     Concepts::.

     The `lstat' function is like `stat', except that it does not
     follow symbolic links.  If FILENAME is the name of a symbolic
     link, `lstat' returns information about the link itself; otherwise
     `lstat' works like `stat'.  *Note Symbolic Links::.

     When the sources are compiled with `_FILE_OFFSET_BITS == 64' this
     function is in fact `lstat64' since the LFS interface transparently
     replaces the normal implementation.

 -- Function: int lstat64 (const char *FILENAME, struct stat64 *BUF)
     Preliminary: | MT-Safe | AS-Safe | AC-Safe | *Note POSIX Safety
     Concepts::.

     This function is similar to `lstat' but it is also able to work on
     files larger than 2^31 bytes on 32-bit systems.  To be able to do
     this the result is stored in a variable of type `struct stat64' to
     which BUF must point.

     When the sources are compiled with `_FILE_OFFSET_BITS == 64' this
     function is available under the name `lstat' and so transparently
     replaces the interface for small files on 32-bit machines.

