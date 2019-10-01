File: diffutils.info-t,  Node: Invoking sdiff,  Next: Standards conformance,  Prev: Invoking patch,  Up: Top

16 Invoking `sdiff'
*******************

The `sdiff' command merges two files and interactively outputs the
results.  Its arguments are as follows:

     sdiff -o OUTFILE OPTIONS... FROM-FILE TO-FILE

   This merges FROM-FILE with TO-FILE, with output to OUTFILE.  If
FROM-FILE is a directory and TO-FILE is not, `sdiff' compares the file
in FROM-FILE whose file name is that of TO-FILE, and vice versa.
FROM-FILE and TO-FILE may not both be directories.

   `sdiff' options begin with `-', so normally FROM-FILE and TO-FILE
may not begin with `-'.  However, `--' as an argument by itself treats
the remaining arguments as file names even if they begin with `-'.  You
may not use `-' as an input file.

   `sdiff' without `--output' (`-o') produces a side-by-side
difference.  This usage is obsolete; use the `--side-by-side' (`-y')
option of `diff' instead.

   An exit status of 0 means no differences were found, 1 means some
differences were found, and 2 means trouble.

* Menu:

* sdiff Options:: Summary of options to `diff'.

File: diffutils.info-t,  Node: sdiff Options,  Up: Invoking sdiff

16.1 Options to `sdiff'
=======================

Below is a summary of all of the options that GNU `sdiff' accepts.
Each option has two equivalent names, one of which is a single letter
preceded by `-', and the other of which is a long name preceded by
`--'.  Multiple single letter options (unless they take an argument)
can be combined into a single command line argument.  Long named
options can be abbreviated to any unique prefix of their name.

`-a'
`--text'
     Treat all files as text and compare them line-by-line, even if they
     do not appear to be text.  *Note Binary::.

`-b'
`--ignore-space-change'
     Ignore changes in amount of white space.  *Note White Space::.

`-B'
`--ignore-blank-lines'
     Ignore changes that just insert or delete blank lines.  *Note
     Blank Lines::.

`-d'
`--minimal'
     Change the algorithm to perhaps find a smaller set of changes.
     This makes `sdiff' slower (sometimes much slower).  *Note diff
     Performance::.

`--diff-program=PROGRAM'
     Use the compatible comparison program PROGRAM to compare files
     instead of `diff'.

`-E'
`--ignore-tab-expansion'
     Ignore changes due to tab expansion.  *Note White Space::.

`--help'
     Output a summary of usage and then exit.

`-i'
`--ignore-case'
     Ignore changes in case; consider upper- and lower-case to be the
     same.  *Note Case Folding::.

`-I REGEXP'
`--ignore-matching-lines=REGEXP'
     Ignore changes that just insert or delete lines that match REGEXP.
     *Note Specified Lines::.

`-l'
`--left-column'
     Print only the left column of two common lines.  *Note Side by
     Side Format::.

`-o FILE'
`--output=FILE'
     Put merged output into FILE.  This option is required for merging.

`-s'
`--suppress-common-lines'
     Do not print common lines.  *Note Side by Side Format::.

`--speed-large-files'
     Use heuristics to speed handling of large files that have numerous
     scattered small changes.  *Note diff Performance::.

`--strip-trailing-cr'
     Strip any trailing carriage return at the end of an input line.
     *Note Binary::.

`-t'
`--expand-tabs'
     Expand tabs to spaces in the output, to preserve the alignment of
     tabs in the input files.  *Note Tabs::.

`--tabsize=COLUMNS'
     Assume that tab stops are set every COLUMNS (default 8) print
     columns.  *Note Tabs::.

`-v'
`--version'
     Output version information and then exit.

`-w COLUMNS'
`--width=COLUMNS'
     Output at most COLUMNS (default 130) print columns per line.
     *Note Side by Side Format::.  Note that for historical reasons,
     this option is `-W' in `diff', `-w' in `sdiff'.

`-W'
`--ignore-all-space'
     Ignore white space when comparing lines.  *Note White Space::.
     Note that for historical reasons, this option is `-w' in `diff',
     `-W' in `sdiff'.

`-Z'
`--ignore-trailing-space'
     Ignore white space at line end.  *Note White Space::.

