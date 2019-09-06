File: libc.info,  Node: Making Special Files,  Next: Temporary Files,  Prev: File Attributes,  Up: File System Interface

14.10 Making Special Files
==========================

The `mknod' function is the primitive for making special files, such as
files that correspond to devices.  The GNU C Library includes this
function for compatibility with BSD.

   The prototype for `mknod' is declared in `sys/stat.h'.  

 -- Function: int mknod (const char *FILENAME, mode_t MODE, dev_t DEV)
     Preliminary: | MT-Safe | AS-Safe | AC-Safe | *Note POSIX Safety
     Concepts::.

     The `mknod' function makes a special file with name FILENAME.  The
     MODE specifies the mode of the file, and may include the various
     special file bits, such as `S_IFCHR' (for a character special file)
     or `S_IFBLK' (for a block special file).  *Note Testing File
     Type::.

     The DEV argument specifies which device the special file refers to.
     Its exact interpretation depends on the kind of special file being
     created.

     The return value is `0' on success and `-1' on error.  In addition
     to the usual file name errors (*note File Name Errors::), the
     following `errno' error conditions are defined for this function:

    `EPERM'
          The calling process is not privileged.  Only the superuser
          can create special files.

    `ENOSPC'
          The directory or file system that would contain the new file
          is full and cannot be extended.

    `EROFS'
          The directory containing the new file can't be modified
          because it's on a read-only file system.

    `EEXIST'
          There is already a file named FILENAME.  If you want to
          replace this file, you must remove the old file explicitly
          first.

