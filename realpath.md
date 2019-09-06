File: libc.info,  Node: Symbolic Links,  Next: Deleting Files,  Prev: Hard Links,  Up: File System Interface

14.5 Symbolic Links
===================

GNU systems support "soft links" or "symbolic links".  This is a kind
of "file" that is essentially a pointer to another file name.  Unlike
hard links, symbolic links can be made to directories or across file
systems with no restrictions.  You can also make a symbolic link to a
name which is not the name of any file.  (Opening this link will fail
until a file by that name is created.)  Likewise, if the symbolic link
points to an existing file which is later deleted, the symbolic link
continues to point to the same file name even though the name no longer
names any file.

   The reason symbolic links work the way they do is that special things
happen when you try to open the link.  The `open' function realizes you
have specified the name of a link, reads the file name contained in the
link, and opens that file name instead.  The `stat' function likewise
operates on the file that the symbolic link points to, instead of on
the link itself.

   By contrast, other operations such as deleting or renaming the file
operate on the link itself.  The functions `readlink' and `lstat' also
refrain from following symbolic links, because their purpose is to
obtain information about the link.  `link', the function that makes a
hard link, does too.  It makes a hard link to the symbolic link, which
one rarely wants.

   Some systems have for some functions operating on files have a limit
on how many symbolic links are followed when resolving a path name.  The
limit if it exists is published in the `sys/param.h' header file.

 -- Macro: int MAXSYMLINKS
     The macro `MAXSYMLINKS' specifies how many symlinks some function
     will follow before returning `ELOOP'.  Not all functions behave the
     same and this value is not the same a that returned for
     `_SC_SYMLOOP' by `sysconf'.  In fact, the `sysconf' result can
     indicate that there is no fixed limit although `MAXSYMLINKS'
     exists and has a finite value.

   Prototypes for most of the functions listed in this section are in
`unistd.h'.  

 -- Function: int symlink (const char *OLDNAME, const char *NEWNAME)
     Preliminary: | MT-Safe | AS-Safe | AC-Safe | *Note POSIX Safety
     Concepts::.

     The `symlink' function makes a symbolic link to OLDNAME named
     NEWNAME.

     The normal return value from `symlink' is `0'.  A return value of
     `-1' indicates an error.  In addition to the usual file name
     syntax errors (*note File Name Errors::), the following `errno'
     error conditions are defined for this function:

    `EEXIST'
          There is already an existing file named NEWNAME.

    `EROFS'
          The file NEWNAME would exist on a read-only file system.

    `ENOSPC'
          The directory or file system cannot be extended to make the
          new link.

    `EIO'
          A hardware error occurred while reading or writing data on
          the disk.


 -- Function: ssize_t readlink (const char *FILENAME, char *BUFFER,
          size_t SIZE)
     Preliminary: | MT-Safe | AS-Safe | AC-Safe | *Note POSIX Safety
     Concepts::.

     The `readlink' function gets the value of the symbolic link
     FILENAME.  The file name that the link points to is copied into
     BUFFER.  This file name string is _not_ null-terminated;
     `readlink' normally returns the number of characters copied.  The
     SIZE argument specifies the maximum number of characters to copy,
     usually the allocation size of BUFFER.

     If the return value equals SIZE, you cannot tell whether or not
     there was room to return the entire name.  So make a bigger buffer
     and call `readlink' again.  Here is an example:

          char *
          readlink_malloc (const char *filename)
          {
            int size = 100;
            char *buffer = NULL;

            while (1)
              {
                buffer = (char *) xrealloc (buffer, size);
                int nchars = readlink (filename, buffer, size);
                if (nchars < 0)
                  {
                    free (buffer);
                    return NULL;
                  }
                if (nchars < size)
                  return buffer;
                size *= 2;
              }
          }

     A value of `-1' is returned in case of error.  In addition to the
     usual file name errors (*note File Name Errors::), the following
     `errno' error conditions are defined for this function:

    `EINVAL'
          The named file is not a symbolic link.

    `EIO'
          A hardware error occurred while reading or writing data on
          the disk.

   In some situations it is desirable to resolve all the symbolic links
to get the real name of a file where no prefix names a symbolic link
which is followed and no filename in the path is `.' or `..'.  This is
for instance desirable if files have to be compare in which case
different names can refer to the same inode.

 -- Function: char * canonicalize_file_name (const char *NAME)
     Preliminary: | MT-Safe | AS-Unsafe heap | AC-Unsafe mem fd | *Note
     POSIX Safety Concepts::.

     The `canonicalize_file_name' function returns the absolute name of
     the file named by NAME which contains no `.', `..' components nor
     any repeated path separators (`/') or symlinks.  The result is
     passed back as the return value of the function in a block of
     memory allocated with `malloc'.  If the result is not used anymore
     the memory should be freed with a call to `free'.

     If any of the path components is missing the function returns a
     NULL pointer.  This is also what is returned if the length of the
     path reaches or exceeds `PATH_MAX' characters.  In any case
     `errno' is set accordingly.

    `ENAMETOOLONG'
          The resulting path is too long.  This error only occurs on
          systems which have a limit on the file name length.

    `EACCES'
          At least one of the path components is not readable.

    `ENOENT'
          The input file name is empty.

    `ENOENT'
          At least one of the path components does not exist.

    `ELOOP'
          More than `MAXSYMLINKS' many symlinks have been followed.

     This function is a GNU extension and is declared in `stdlib.h'.

   The Unix standard includes a similar function which differs from
`canonicalize_file_name' in that the user has to provide the buffer
where the result is placed in.

 -- Function: char * realpath (const char *restrict NAME, char
          *restrict RESOLVED)
     Preliminary: | MT-Safe | AS-Unsafe heap | AC-Unsafe mem fd | *Note
     POSIX Safety Concepts::.

     A call to `realpath' where the RESOLVED parameter is `NULL'
     behaves exactly like `canonicalize_file_name'.  The function
     allocates a buffer for the file name and returns a pointer to it.
     If RESOLVED is not `NULL' it points to a buffer into which the
     result is copied.  It is the callers responsibility to allocate a
     buffer which is large enough.  On systems which define `PATH_MAX'
     this means the buffer must be large enough for a pathname of this
     size.  For systems without limitations on the pathname length the
     requirement cannot be met and programs should not call `realpath'
     with anything but `NULL' for the second parameter.

     One other difference is that the buffer RESOLVED (if nonzero) will
     contain the part of the path component which does not exist or is
     not readable if the function returns `NULL' and `errno' is set to
     `EACCES' or `ENOENT'.

     This function is declared in `stdlib.h'.

   The advantage of using this function is that it is more widely
available.  The drawback is that it reports failures for long path on
systems which have no limits on the file name length.

