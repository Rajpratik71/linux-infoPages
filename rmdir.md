File: coreutils.info,  Node: rmdir invocation,  Next: unlink invocation,  Prev: readlink invocation,  Up: Special file types

12.7 ‘rmdir’: Remove empty directories
======================================

‘rmdir’ removes empty directories.  Synopsis:

     rmdir [OPTION]... DIRECTORY...

   If any DIRECTORY argument does not refer to an existing empty
directory, it is an error.

   The program accepts the following options.  Also see *note Common
options::.

‘--ignore-fail-on-non-empty’
     Ignore each failure to remove a directory that is solely because
     the directory is non-empty.

‘-p’
‘--parents’
     Remove DIRECTORY, then try to remove each component of DIRECTORY.
     So, for example, ‘rmdir -p a/b/c’ is similar to ‘rmdir a/b/c a/b
     a’.  As such, it fails if any of those directories turns out not to
     be empty.  Use the ‘--ignore-fail-on-non-empty’ option to make it
     so such a failure does not evoke a diagnostic and does not cause
     ‘rmdir’ to exit unsuccessfully.

‘-v’
‘--verbose’
     Give a diagnostic for each successful removal.  DIRECTORY is
     removed.

   *Note rm invocation::, for how to remove non-empty directories
(recursively).

   An exit status of zero indicates success, and a nonzero value
indicates failure.

