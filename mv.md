Next: rm invocation,  Prev: install invocation,  Up: Basic operations

11.4 ‘mv’: Move (rename) files
==============================

‘mv’ moves or renames files (or directories).  Synopses:

     mv [OPTION]... [-T] SOURCE DEST
     mv [OPTION]... SOURCE... DIRECTORY
     mv [OPTION]... -t DIRECTORY SOURCE...

   • If two file names are given, ‘mv’ moves the first file to the
     second.

   • If the ‘--target-directory’ (‘-t’) option is given, or failing that
     if the last file is a directory and the ‘--no-target-directory’
     (‘-T’) option is not given, ‘mv’ moves each SOURCE file to the
     specified directory, using the SOURCEs’ names.

   ‘mv’ can move any type of file from one file system to another.
Prior to version ‘4.0’ of the fileutils, ‘mv’ could move only regular
files between file systems.  For example, now ‘mv’ can move an entire
directory hierarchy including special device files from one partition to
another.  It first uses some of the same code that’s used by ‘cp -a’ to
copy the requested directories and files, then (assuming the copy
succeeded) it removes the originals.  If the copy fails, then the part
that was copied to the destination partition is removed.  If you were to
copy three directories from one partition to another and the copy of the
first directory succeeded, but the second didn’t, the first would be
left on the destination partition and the second and third would be left
on the original partition.

   ‘mv’ always tries to copy extended attributes (xattr), which may
include SELinux context, ACLs or Capabilities.  Upon failure all but
‘Operation not supported’ warnings are output.

   If a destination file exists but is normally unwritable, standard
input is a terminal, and the ‘-f’ or ‘--force’ option is not given, ‘mv’
prompts the user for whether to replace the file.  (You might own the
file, or have write permission on its directory.)  If the response is
not affirmative, the file is skipped.

   _Warning_: Avoid specifying a source name with a trailing slash, when
it might be a symlink to a directory.  Otherwise, ‘mv’ may do something
very surprising, since its behavior depends on the underlying rename
system call.  On a system with a modern Linux-based kernel, it fails
with ‘errno=ENOTDIR’.  However, on other systems (at least FreeBSD 6.1
and Solaris 10) it silently renames not the symlink but rather the
directory referenced by the symlink.  *Note Trailing slashes::.

   _Note_: ‘mv’ will only replace empty directories in the destination.
Conflicting populated directories are skipped with a diagnostic.

   The program accepts the following options.  Also see *note Common
options::.

‘-b’
‘--backup[=METHOD]’
     *Note Backup options::.  Make a backup of each file that would
     otherwise be overwritten or removed.

‘-f’
‘--force’
     Do not prompt the user before removing a destination file.  If you
     specify more than one of the ‘-i’, ‘-f’, ‘-n’ options, only the
     final one takes effect.

‘-i’
‘--interactive’
     Prompt whether to overwrite each existing destination file,
     regardless of its permissions.  If the response is not affirmative,
     the file is skipped.  If you specify more than one of the ‘-i’,
     ‘-f’, ‘-n’ options, only the final one takes effect.

‘-n’
‘--no-clobber’
     Do not overwrite an existing file.  If you specify more than one of
     the ‘-i’, ‘-f’, ‘-n’ options, only the final one takes effect.
     This option is mutually exclusive with ‘-b’ or ‘--backup’ option.

‘-u’
‘--update’
     Do not move a non-directory that has an existing destination with
     the same or newer modification time.  If the move is across file
     system boundaries, the comparison is to the source time stamp
     truncated to the resolutions of the destination file system and of
     the system calls used to update time stamps; this avoids duplicate
     work if several ‘mv -u’ commands are executed with the same source
     and destination.

‘-v’
‘--verbose’
     Print the name of each file before moving it.

‘--strip-trailing-slashes’
     Remove any trailing slashes from each SOURCE argument.  *Note
     Trailing slashes::.

‘-S SUFFIX’
‘--suffix=SUFFIX’
     Append SUFFIX to each backup file made with ‘-b’.  *Note Backup
     options::.

‘-t DIRECTORY’
‘--target-directory=DIRECTORY’
     Specify the destination DIRECTORY.  *Note Target directory::.

‘-T’
‘--no-target-directory’
     Do not treat the last operand specially when it is a directory or a
     symbolic link to a directory.  *Note Target directory::.

‘-Z’
‘--context’
     This option functions similarly to the ‘restorecon’ command, by
     adjusting the SELinux security context according to the system
     default type for destination files.

   An exit status of zero indicates success, and a nonzero value
indicates failure.

