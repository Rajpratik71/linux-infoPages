File: libc.info,  Node: Creating Directories,  Next: File Attributes,  Prev: Renaming Files,  Up: File System Interface

14.8 Creating Directories
=========================

Directories are created with the `mkdir' function.  (There is also a
shell command `mkdir' which does the same thing.)

 -- Function: int mkdir (const char *FILENAME, mode_t MODE)
     Preliminary: | MT-Safe | AS-Safe | AC-Safe | *Note POSIX Safety
     Concepts::.

     The `mkdir' function creates a new, empty directory with name
     FILENAME.

     The argument MODE specifies the file permissions for the new
     directory file.  *Note Permission Bits::, for more information
     about this.

     A return value of `0' indicates successful completion, and `-1'
     indicates failure.  In addition to the usual file name syntax
     errors (*note File Name Errors::), the following `errno' error
     conditions are defined for this function:

    `EACCES'
          Write permission is denied for the parent directory in which
          the new directory is to be added.

    `EEXIST'
          A file named FILENAME already exists.

    `EMLINK'
          The parent directory has too many links (entries).

          Well-designed file systems never report this error, because
          they permit more links than your disk could possibly hold.
          However, you must still take account of the possibility of
          this error, as it could result from network access to a file
          system on another machine.

    `ENOSPC'
          The file system doesn't have enough room to create the new
          directory.

    `EROFS'
          The parent directory of the directory being created is on a
          read-only file system and cannot be modified.

     To use this function, your program should include the header file
     `sys/stat.h'.  

