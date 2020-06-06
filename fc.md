File: libc.info,  Node: Working Directory,  Next: Accessing Directories,  Up: File System Interface

14.1 Working Directory
======================

Each process has associated with it a directory, called its "current
working directory" or simply "working directory", that is used in the
resolution of relative file names (*note File Name Resolution::).

   When you log in and begin a new session, your working directory is
initially set to the home directory associated with your login account
in the system user database.  You can find any user's home directory
using the 'getpwuid' or 'getpwnam' functions; see *note User Database::.

   Users can change the working directory using shell commands like
'cd'.  The functions described in this section are the primitives used
by those commands and by other programs for examining and changing the
working directory.

   Prototypes for these functions are declared in the header file
'unistd.h'.

 -- Function: char * getcwd (char *BUFFER, size_t SIZE)
     Preliminary: | MT-Safe | AS-Unsafe heap | AC-Unsafe mem fd | *Note
     POSIX Safety Concepts::.

     The 'getcwd' function returns an absolute file name representing
     the current working directory, storing it in the character array
     BUFFER that you provide.  The SIZE argument is how you tell the
     system the allocation size of BUFFER.

     The GNU C Library version of this function also permits you to
     specify a null pointer for the BUFFER argument.  Then 'getcwd'
     allocates a buffer automatically, as with 'malloc' (*note
     Unconstrained Allocation::).  If the SIZE is greater than zero,
     then the buffer is that large; otherwise, the buffer is as large as
     necessary to hold the result.

     The return value is BUFFER on success and a null pointer on
     failure.  The following 'errno' error conditions are defined for
     this function:

     'EINVAL'
          The SIZE argument is zero and BUFFER is not a null pointer.

     'ERANGE'
          The SIZE argument is less than the length of the working
          directory name.  You need to allocate a bigger array and try
          again.

     'EACCES'
          Permission to read or search a component of the file name was
          denied.

   You could implement the behavior of GNU's 'getcwd (NULL, 0)' using
only the standard behavior of 'getcwd':

     char *
     gnu_getcwd ()
     {
       size_t size = 100;

       while (1)
         {
           char *buffer = (char *) xmalloc (size);
           if (getcwd (buffer, size) == buffer)
             return buffer;
           free (buffer);
           if (errno != ERANGE)
             return 0;
           size *= 2;
         }
     }

*Note Malloc Examples::, for information about 'xmalloc', which is not a
library function but is a customary name used in most GNU software.

 -- Deprecated Function: char * getwd (char *BUFFER)
     Preliminary: | MT-Safe | AS-Unsafe heap i18n | AC-Unsafe mem fd |
     *Note POSIX Safety Concepts::.

     This is similar to 'getcwd', but has no way to specify the size of
     the buffer.  The GNU C Library provides 'getwd' only for backwards
     compatibility with BSD.

     The BUFFER argument should be a pointer to an array at least
     'PATH_MAX' bytes long (*note Limits for Files::).  On GNU/Hurd
     systems there is no limit to the size of a file name, so this is
     not necessarily enough space to contain the directory name.  That
     is why this function is deprecated.

 -- Function: char * get_current_dir_name (void)
     Preliminary: | MT-Safe env | AS-Unsafe heap | AC-Unsafe mem fd |
     *Note POSIX Safety Concepts::.

     This 'get_current_dir_name' function is basically equivalent to
     'getcwd (NULL, 0)'.  The only difference is that the value of the
     'PWD' variable is returned if this value is correct.  This is a
     subtle difference which is visible if the path described by the
     'PWD' value is using one or more symbol links in which case the
     value returned by 'getcwd' can resolve the symbol links and
     therefore yield a different result.

     This function is a GNU extension.

 -- Function: int chdir (const char *FILENAME)
     Preliminary: | MT-Safe | AS-Safe | AC-Safe | *Note POSIX Safety
     Concepts::.

     This function is used to set the process's working directory to
     FILENAME.

     The normal, successful return value from 'chdir' is '0'.  A value
     of '-1' is returned to indicate an error.  The 'errno' error
     conditions defined for this function are the usual file name syntax
     errors (*note File Name Errors::), plus 'ENOTDIR' if the file
     FILENAME is not a directory.

 -- Function: int fchdir (int FILEDES)
     Preliminary: | MT-Safe | AS-Safe | AC-Safe | *Note POSIX Safety
     Concepts::.

     This function is used to set the process's working directory to
     directory associated with the file descriptor FILEDES.

     The normal, successful return value from 'fchdir' is '0'.  A value
     of '-1' is returned to indicate an error.  The following 'errno'
     error conditions are defined for this function:

     'EACCES'
          Read permission is denied for the directory named by
          'dirname'.

     'EBADF'
          The FILEDES argument is not a valid file descriptor.

     'ENOTDIR'
          The file descriptor FILEDES is not associated with a
          directory.

     'EINTR'
          The function call was interrupt by a signal.

     'EIO'
          An I/O error occurred.

