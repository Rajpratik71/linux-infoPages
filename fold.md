File: coreutils.info,  Node: fold invocation,  Prev: pr invocation,  Up: Formatting file contents

4.3 `fold': Wrap input lines to fit in specified width
======================================================

`fold' writes each FILE (`-' means standard input), or standard input
if none are given, to standard output, breaking long lines.  Synopsis:

     fold [OPTION]... [FILE]...

   By default, `fold' breaks lines wider than 80 columns.  The output
is split into as many lines as necessary.

   `fold' counts screen columns by default; thus, a tab may count more
than one column, backspace decreases the column count, and carriage
return sets the column to zero.

   The program accepts the following options.  Also see *note Common
options::.

`-b'
`--bytes'
     Count bytes rather than columns, so that tabs, backspaces, and
     carriage returns are each counted as taking up one column, just
     like other characters.

`-s'
`--spaces'
     Break at word boundaries: the line is broken after the last blank
     before the maximum line length.  If the line contains no such
     blanks, the line is broken at the maximum line length as usual.

`-w WIDTH'
`--width=WIDTH'
     Use a maximum line length of WIDTH columns instead of 80.

     For compatibility `fold' supports an obsolete option syntax
     `-WIDTH'.  New scripts should use `-w WIDTH' instead.


   An exit status of zero indicates success, and a nonzero value
indicates failure.

