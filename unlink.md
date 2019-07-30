Prev: rmdir invocation,  Up: Special file types

12.8 ‘unlink’: Remove files via the unlink syscall
==================================================

‘unlink’ deletes a single specified file name.  It is a minimalist
interface to the system-provided ‘unlink’ function.  *Note
(libc)Deleting Files::.  Synopsis: It avoids the bells and whistles of
the more commonly-used ‘rm’ command (*note rm invocation::).

     unlink FILENAME

   On some systems ‘unlink’ can be used to delete the name of a
directory.  On others, it can be used that way only by a privileged
user.  In the GNU system ‘unlink’ can never delete the name of a
directory.

   The ‘unlink’ command honors the ‘--help’ and ‘--version’ options.  To
remove a file whose name begins with ‘-’, prefix the name with ‘./’,
e.g., ‘unlink ./--help’.

   An exit status of zero indicates success, and a nonzero value
indicates failure.

