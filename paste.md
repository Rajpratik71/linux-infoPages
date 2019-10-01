File: coreutils.info,  Node: paste invocation,  Next: join invocation,  Prev: cut invocation,  Up: Operating on fields

8.2 'paste': Merge lines of files
=================================

'paste' writes to standard output lines consisting of sequentially
corresponding lines of each given file, separated by a TAB character.
Standard input is used for a file name of '-' or if no input files are
given.

   Synopsis:

     paste [OPTION]... [FILE]...

   For example, with:
     $ cat num2
     1
     2
     $ cat let3
     a
     b
     c

   Take lines sequentially from each file:
     $ paste num2 let3
     1       a
     2       b
             c

   Duplicate lines from a file:
     $ paste num2 let3 num2
     1       a      1
     2       b      2
             c

   Intermix lines from stdin:
     $ paste - let3 - < num2
     1       a      2
             b
             c

   Join consecutive lines with a space:
     $ seq 4 | paste -d ' ' - -
     1 2
     3 4

   The program accepts the following options.  Also see *note Common
options::.

'-s'
'--serial'
     Paste the lines of one file at a time rather than one line from
     each file.  Using the above example data:

          $ paste -s num2 let3
          1       2
          a       b       c

'-d DELIM-LIST'
'--delimiters=DELIM-LIST'
     Consecutively use the characters in DELIM-LIST instead of TAB to
     separate merged lines.  When DELIM-LIST is exhausted, start again
     at its beginning.  Using the above example data:

          $ paste -d '%_' num2 let3 num2
          1%a_1
          2%b_2
          %c_

   An exit status of zero indicates success, and a nonzero value
indicates failure.

