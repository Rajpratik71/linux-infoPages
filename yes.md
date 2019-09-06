File: coreutils.info,  Node: yes invocation,  Prev: printf invocation,  Up: Printing text

15.3 `yes': Print a string until interrupted
============================================

`yes' prints the command line arguments, separated by spaces and
followed by a newline, forever until it is killed.  If no arguments are
given, it prints `y' followed by a newline forever until killed.

   Upon a write error, `yes' exits with status `1'.

   The only options are a lone `--help' or `--version'.  To output an
argument that begins with `-', precede it with `--', e.g., `yes --
--help'.  *Note Common options::.

