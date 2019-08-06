File: coreutils.info,  Node: readlink invocation,  Next: rmdir invocation,  Prev: mknod invocation,  Up: Special file types

12.6 ‘readlink’: Print value of a symlink or canonical file name
================================================================

‘readlink’ may work in one of two supported modes:

‘Readlink mode’

     ‘readlink’ outputs the value of the given symbolic links.  If
     ‘readlink’ is invoked with an argument other than the name of a
     symbolic link, it produces no output and exits with a nonzero exit
     code.

‘Canonicalize mode’

     ‘readlink’ outputs the absolute name of the given files which
     contain no ‘.’, ‘..’ components nor any repeated separators (‘/’)
     or symbolic links.  Note the ‘realpath’ command is the preferred
     command to use for canonicalization.  *Note realpath invocation::.

     readlink [OPTION]... FILE...

   By default, ‘readlink’ operates in readlink mode.

   The program accepts the following options.  Also see *note Common
options::.

‘-f’
‘--canonicalize’
     Activate canonicalize mode.  If any component of the file name
     except the last one is missing or unavailable, ‘readlink’ produces
     no output and exits with a nonzero exit code.  A trailing slash is
     ignored.

‘-e’
‘--canonicalize-existing’
     Activate canonicalize mode.  If any component is missing or
     unavailable, ‘readlink’ produces no output and exits with a nonzero
     exit code.  A trailing slash requires that the name resolve to a
     directory.

‘-m’
‘--canonicalize-missing’
     Activate canonicalize mode.  If any component is missing or
     unavailable, ‘readlink’ treats it as a directory.

‘-n’
‘--no-newline’
     Do not print the output delimiter, when a single FILE is specified.
     Print a warning if specified along with multiple FILEs.

‘-s’
‘-q’
‘--silent’
‘--quiet’
     Suppress most error messages.  On by default.

‘-v’
‘--verbose’
     Report error messages.

‘-z’
‘--zero’
     Output a zero byte (ASCII NUL) at the end of each line, rather than
     a newline.  This option enables other programs to parse the output
     even when that output would contain data with embedded newlines.

   The ‘readlink’ utility first appeared in OpenBSD 2.1.

   The ‘realpath’ command without options, operates like ‘readlink’ in
canonicalize mode.

   An exit status of zero indicates success, and a nonzero value
indicates failure.

