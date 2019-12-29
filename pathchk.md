File: coreutils.info,  Node: pathchk invocation,  Next: mktemp invocation,  Prev: dirname invocation,  Up: File name manipulation

18.3 ‘pathchk’: Check file name validity and portability
========================================================

‘pathchk’ checks validity and portability of file names.  Synopsis:

     pathchk [OPTION]... NAME...

   For each NAME, ‘pathchk’ prints an error message if any of these
conditions is true:

  1. One of the existing directories in NAME does not have search
     (execute) permission,
  2. The length of NAME is larger than the maximum supported by the
     operating system.
  3. The length of one component of NAME is longer than its file
     system’s maximum.

   A nonexistent NAME is not an error, so long a file with that name
could be created under the above conditions.

   The program accepts the following options.  Also see *note Common
options::.  Options must precede operands.

‘-p’
     Instead of performing checks based on the underlying file system,
     print an error message if any of these conditions is true:

       1. A file name is empty.

       2. A file name contains a character outside the POSIX portable
          file name character set, namely, the ASCII letters and digits,
          ‘.’, ‘_’, ‘-’, and ‘/’.

       3. The length of a file name or one of its components exceeds the
          POSIX minimum limits for portability.

‘-P’
     Print an error message if a file name is empty, or if it contains a
     component that begins with ‘-’.

‘--portability’
     Print an error message if a file name is not portable to all POSIX
     hosts.  This option is equivalent to ‘-p -P’.

   Exit status:

     0 if all specified file names passed all checks,
     1 otherwise.

