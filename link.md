File: libc.info,  Node: Hard Links,  Next: Symbolic Links,  Prev: Working with Directory Trees,  Up: File System Interface

14.4 Hard Links
===============

In POSIX systems, one file can have many names at the same time.  All of
the names are equally real, and no one of them is preferred to the
others.

   To add a name to a file, use the `link' function.  (The new name is
also called a "hard link" to the file.)  Creating a new link to a file
does not copy the contents of the file; it simply makes a new name by
which the file can be known, in addition to the file's existing name or
names.

   One file can have names in several directories, so the organization
of the file system is not a strict hierarchy or tree.

   In most implementations, it is not possible to have hard links to the
same file in multiple file systems.  `link' reports an error if you try
to make a hard link to the file from another file system when this
cannot be done.

   The prototype for the `link' function is declared in the header file
`unistd.h'.  

 -- Function: int link (const char *OLDNAME, const char *NEWNAME)
     Preliminary: | MT-Safe | AS-Safe | AC-Safe | *Note POSIX Safety
     Concepts::.

     The `link' function makes a new link to the existing file named by
     OLDNAME, under the new name NEWNAME.

     This function returns a value of `0' if it is successful and `-1'
     on failure.  In addition to the usual file name errors (*note File
     Name Errors::) for both OLDNAME and NEWNAME, the following `errno'
     error conditions are defined for this function:

    `EACCES'
          You are not allowed to write to the directory in which the
          new link is to be written.

    `EEXIST'
          There is already a file named NEWNAME.  If you want to replace
          this link with a new link, you must remove the old link
          explicitly first.

    `EMLINK'
          There are already too many links to the file named by OLDNAME.
          (The maximum number of links to a file is `LINK_MAX'; see
          *note Limits for Files::.)

    `ENOENT'
          The file named by OLDNAME doesn't exist.  You can't make a
          link to a file that doesn't exist.

    `ENOSPC'
          The directory or file system that would contain the new link
          is full and cannot be extended.

    `EPERM'
          On GNU/Linux and GNU/Hurd systems and some others, you cannot
          make links to directories.  Many systems allow only
          privileged users to do so.  This error is used to report the
          problem.

    `EROFS'
          The directory containing the new link can't be modified
          because it's on a read-only file system.

    `EXDEV'
          The directory specified in NEWNAME is on a different file
          system than the existing file.

    `EIO'
          A hardware error occurred while trying to read or write the
          to filesystem.

