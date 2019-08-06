File: coreutils.info,  Node: printenv invocation,  Next: tty invocation,  Prev: stty invocation,  Up: Working context

19.3 ‘printenv’: Print all or some environment variables
========================================================

‘printenv’ prints environment variable values.  Synopsis:

     printenv [OPTION] [VARIABLE]...

   If no VARIABLEs are specified, ‘printenv’ prints the value of every
environment variable.  Otherwise, it prints the value of each VARIABLE
that is set, and nothing for those that are not set.

   The program accepts the following option.  Also see *note Common
options::.

‘-0’
‘--null’
     Output a zero byte (ASCII NUL) at the end of each line, rather than
     a newline.  This option enables other programs to parse the output
     even when that output would contain data with embedded newlines.

   Exit status:

     0 if all variables specified were found
     1 if at least one specified variable was not found
     2 if a write error occurred

