Next: dirname invocation,  Up: File name manipulation

18.1 ‘basename’: Strip directory and suffix from a file name
============================================================

‘basename’ removes any leading directory components from NAME.
Synopsis:

     basename NAME [SUFFIX]
     basename OPTION... NAME...

   If SUFFIX is specified and is identical to the end of NAME, it is
removed from NAME as well.  Note that since trailing slashes are removed
prior to suffix matching, SUFFIX will do nothing if it contains slashes.
‘basename’ prints the result on standard output.

   Together, ‘basename’ and ‘dirname’ are designed such that if ‘ls
"$name"’ succeeds, then the command sequence ‘cd "$(dirname "$name")";
ls "$(basename "$name")"’ will, too.  This works for everything except
file names containing a trailing newline.

   POSIX allows the implementation to define the results if NAME is
empty or ‘//’.  In the former case, GNU ‘basename’ returns the empty
string.  In the latter case, the result is ‘//’ on platforms where // is
distinct from /, and ‘/’ on platforms where there is no difference.

   The program accepts the following options.  Also see *note Common
options::.  Options must precede operands.

‘-a’
‘--multiple’
     Support more than one argument.  Treat every argument as a NAME.
     With this, an optional SUFFIX must be specified using the ‘-s’
     option.

‘-s SUFFIX’
‘--suffix=SUFFIX’
     Remove a trailing SUFFIX.  This option implies the ‘-a’ option.

‘-z’
‘--zero’
     Output a zero byte (ASCII NUL) at the end of each line, rather than
     a newline.  This option enables other programs to parse the output
     even when that output would contain data with embedded newlines.

   An exit status of zero indicates success, and a nonzero value
indicates failure.

   Examples:

     # Output "sort".
     basename /usr/bin/sort

     # Output "stdio".
     basename include/stdio.h .h

     # Output "stdio".
     basename -s .h include/stdio.h

     # Output "stdio" followed by "stdlib"
     basename -a -s .h include/stdio.h include/stdlib.h

