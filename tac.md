File: coreutils.info,  Node: tac invocation,  Next: nl invocation,  Prev: cat invocation,  Up: Output of entire files

3.2 ‘tac’: Concatenate and write files in reverse
=================================================

‘tac’ copies each FILE (‘-’ means standard input), or standard input if
none are given, to standard output, reversing the records (lines by
default) in each separately.  Synopsis:

     tac [OPTION]... [FILE]...

   “Records” are separated by instances of a string (newline by
default).  By default, this separator string is attached to the end of
the record that it follows in the file.

   The program accepts the following options.  Also see *note Common
options::.

‘-b’
‘--before’
     The separator is attached to the beginning of the record that it
     precedes in the file.

‘-r’
‘--regex’
     Treat the separator string as a regular expression.

‘-s SEPARATOR’
‘--separator=SEPARATOR’
     Use SEPARATOR as the record separator, instead of newline.  Note an
     empty SEPARATOR is treated as a zero byte.  I.e., input and output
     items are delimited with ASCII NUL.

   On systems like MS-DOS that distinguish between text and binary
files, ‘tac’ reads and writes in binary mode.

   An exit status of zero indicates success, and a nonzero value
indicates failure.

   Example:

     # Reverse a file character by character.
     tac -r -s 'x\|[^x]'

