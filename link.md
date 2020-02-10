Next: ln invocation,  Up: Special file types

12.1 ‘link’: Make a hard link via the link syscall
==================================================

‘link’ creates a single hard link at a time.  It is a minimalist
interface to the system-provided ‘link’ function.  *Note (libc)Hard
Links::.  It avoids the bells and whistles of the more commonly-used
‘ln’ command (*note ln invocation::).  Synopsis:

     link FILENAME LINKNAME

   FILENAME must specify an existing file, and LINKNAME must specify a
nonexistent entry in an existing directory.  ‘link’ simply calls ‘link
(FILENAME, LINKNAME)’ to create the link.

   On a GNU system, this command acts like ‘ln --directory
--no-target-directory FILENAME LINKNAME’.  However, the ‘--directory’
and ‘--no-target-directory’ options are not specified by POSIX, and the
‘link’ command is more portable in practice.

   If FILENAME is a symbolic link, it is unspecified whether LINKNAME
will be a hard link to the symbolic link or to the target of the
symbolic link.  Use ‘ln -P’ or ‘ln -L’ to specify which behavior is
desired.

   An exit status of zero indicates success, and a nonzero value
indicates failure.

