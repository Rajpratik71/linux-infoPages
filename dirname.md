Next: pathchk invocation,  Prev: basename invocation,  Up: File name manipulation

18.2 ‘dirname’: Strip last file name component
==============================================

‘dirname’ prints all but the final slash-delimited component of each
NAME.  Slashes on either side of the final component are also removed.
If the string contains no slash, ‘dirname’ prints ‘.’ (meaning the
current directory).  Synopsis:

     dirname [OPTION] NAME...

   NAME need not be a file name, but if it is, this operation
effectively lists the directory that contains the final component,
including the case when the final component is itself a directory.

   Together, ‘basename’ and ‘dirname’ are designed such that if ‘ls
"$name"’ succeeds, then the command sequence ‘cd "$(dirname "$name")";
ls "$(basename "$name")"’ will, too.  This works for everything except
file names containing a trailing newline.

   POSIX allows the implementation to define the results if NAME is
‘//’.  With GNU ‘dirname’, the result is ‘//’ on platforms where // is
distinct from /, and ‘/’ on platforms where there is no difference.

   The program accepts the following option.  Also see *note Common
options::.

‘-z’
‘--zero’
     Output a zero byte (ASCII NUL) at the end of each line, rather than
     a newline.  This option enables other programs to parse the output
     even when that output would contain data with embedded newlines.

   An exit status of zero indicates success, and a nonzero value
indicates failure.

   Examples:

     # Output "/usr/bin".
     dirname /usr/bin/sort
     dirname /usr/bin//.//

     # Output "dir1" followed by "dir2"
     dirname dir1/str dir2/str

     # Output ".".
     dirname stdio.h

