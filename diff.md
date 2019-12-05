File: diffutils.info,  Node: Invoking diff,  Next: Invoking diff3,  Prev: Invoking cmp,  Up: Top

13 Invoking 'diff'
******************

The format for running the 'diff' command is:

     diff OPTIONS... FILES...

   In the simplest case, two file names FROM-FILE and TO-FILE are given,
and 'diff' compares the contents of FROM-FILE and TO-FILE.  A file name
of '-' stands for the standard input.

   If one file is a directory and the other is not, 'diff' compares the
file in the directory whose name is that of the non-directory.  The
non-directory file must not be '-'.

   If two file names are given and both are directories, 'diff' compares
corresponding files in both directories, in alphabetical order; this
comparison is not recursive unless the '--recursive' ('-r') option is
given.  'diff' never compares the actual contents of a directory as if
it were a file.  The file that is fully specified may not be standard
input, because standard input is nameless and the notion of "file with
the same name" does not apply.

   If the '--from-file=FILE' option is given, the number of file names
is arbitrary, and FILE is compared to each named file.  Similarly, if
the '--to-file=FILE' option is given, each named file is compared to
FILE.

   'diff' options begin with '-', so normally file names may not begin
with '-'.  However, '--' as an argument by itself treats the remaining
arguments as file names even if they begin with '-'.

   An exit status of 0 means no differences were found, 1 means some
differences were found, and 2 means trouble.

* Menu:

* diff Options:: Summary of options to 'diff'.

File: diffutils.info,  Node: diff Options,  Up: Invoking diff

13.1 Options to 'diff'
======================

Below is a summary of all of the options that GNU 'diff' accepts.  Most
options have two equivalent names, one of which is a single letter
preceded by '-', and the other of which is a long name preceded by '--'.
Multiple single letter options (unless they take an argument) can be
combined into a single command line word: '-ac' is equivalent to '-a
-c'.  Long named options can be abbreviated to any unique prefix of
their name.  Brackets ([ and ]) indicate that an option takes an
optional argument.

'-a'
'--text'
     Treat all files as text and compare them line-by-line, even if they
     do not seem to be text.  *Note Binary::.

'-b'
'--ignore-space-change'
     Ignore changes in amount of white space.  *Note White Space::.

'-B'
'--ignore-blank-lines'
     Ignore changes that just insert or delete blank lines.  *Note Blank
     Lines::.

'--binary'
     Read and write data in binary mode.  *Note Binary::.

'-c'
     Use the context output format, showing three lines of context.
     *Note Context Format::.

'--color [=WHEN]'
     Specify whether to use color for distinguishing different contexts,
     like header, added or removed lines.  WHEN may be omitted, or one
     of:
        * none Do not use color at all.  This is the default when no
          -color option is specified.
        * auto Use color only if standard output is a terminal.
        * always Always use color.
     Specifying '--color' and no WHEN is equivalent to '--color=auto'.

'-C LINES'
'--context[=LINES]'
     Use the context output format, showing LINES (an integer) lines of
     context, or three if LINES is not given.  *Note Context Format::.
     For proper operation, 'patch' typically needs at least two lines of
     context.

     For compatibility 'diff' also supports an obsolete option syntax
     '-LINES' that has effect when combined with '-c', '-p', or '-u'.
     New scripts should use '-U LINES' ('-C LINES') instead.

'--changed-group-format=FORMAT'
     Use FORMAT to output a line group containing differing lines from
     both files in if-then-else format.  *Note Line Group Formats::.

'-d'
'--minimal'
     Change the algorithm perhaps find a smaller set of changes.  This
     makes 'diff' slower (sometimes much slower).  *Note diff
     Performance::.

'-D NAME'
'--ifdef=NAME'
     Make merged '#ifdef' format output, conditional on the preprocessor
     macro NAME.  *Note If-then-else::.

'-e'
'--ed'
     Make output that is a valid 'ed' script.  *Note ed Scripts::.

'-E'
'--ignore-tab-expansion'
     Ignore changes due to tab expansion.  *Note White Space::.

'-f'
'--forward-ed'
     Make output that looks vaguely like an 'ed' script but has changes
     in the order they appear in the file.  *Note Forward ed::.

'-F REGEXP'
'--show-function-line=REGEXP'
     In context and unified format, for each hunk of differences, show
     some of the last preceding line that matches REGEXP.  *Note
     Specified Headings::.

'--from-file=FILE'
     Compare FILE to each operand; FILE may be a directory.

'--help'
     Output a summary of usage and then exit.

'--horizon-lines=LINES'
     Do not discard the last LINES lines of the common prefix and the
     first LINES lines of the common suffix.  *Note diff Performance::.

'-i'
'--ignore-case'
     Ignore changes in case; consider upper- and lower-case letters
     equivalent.  *Note Case Folding::.

'-I REGEXP'
'--ignore-matching-lines=REGEXP'
     Ignore changes that just insert or delete lines that match REGEXP.
     *Note Specified Lines::.

'--ignore-file-name-case'
     Ignore case when comparing file names.  For example, recursive
     comparison of 'd' to 'e' might compare the contents of 'd/Init' and
     'e/inIt'.  At the top level, 'diff d inIt' might compare the
     contents of 'd/Init' and 'inIt'.  *Note Comparing Directories::.

'-l'
'--paginate'
     Pass the output through 'pr' to paginate it.  *Note Pagination::.

'-L LABEL'
'--label=LABEL'
     Use LABEL instead of the file name in the context format (*note
     Context Format::) and unified format (*note Unified Format::)
     headers.  *Note RCS::.

'--left-column'
     Print only the left column of two common lines in side by side
     format.  *Note Side by Side Format::.

'--line-format=FORMAT'
     Use FORMAT to output all input lines in if-then-else format.  *Note
     Line Formats::.

'-n'
'--rcs'
     Output RCS-format diffs; like '-f' except that each command
     specifies the number of lines affected.  *Note RCS::.

'-N'
'--new-file'
     If one file is missing, treat it as present but empty.  *Note
     Comparing Directories::.

'--new-group-format=FORMAT'
     Use FORMAT to output a group of lines taken from just the second
     file in if-then-else format.  *Note Line Group Formats::.

'--new-line-format=FORMAT'
     Use FORMAT to output a line taken from just the second file in
     if-then-else format.  *Note Line Formats::.

'--no-dereference'
     Act on symbolic links themselves instead of what they point to.
     Two symbolic links are deemed equal only when each points to
     precisely the same name.

'--old-group-format=FORMAT'
     Use FORMAT to output a group of lines taken from just the first
     file in if-then-else format.  *Note Line Group Formats::.

'--old-line-format=FORMAT'
     Use FORMAT to output a line taken from just the first file in
     if-then-else format.  *Note Line Formats::.

'-p'
'--show-c-function'
     Show which C function each change is in.  *Note C Function
     Headings::.

'--palette=PALETTE'
     Specify what color palette to use when colored output is enabled.
     It defaults to 'rs=0:hd=1:ad=32:de=31:ln=36' for red deleted lines,
     green added lines, cyan line numbers, bold header.

     Supported capabilities are as follows.

     'ad=32'

          SGR substring for added lines.  The default is green
          foreground.

     'de=31'

          SGR substring for deleted lines.  The default is red
          foreground.

     'hd=1'

          SGR substring for chunk header.  The default is bold
          foreground.

     'ln=36'

          SGR substring for line numbers.  The default is cyan
          foreground.

'-q'
'--brief'
     Report only whether the files differ, not the details of the
     differences.  *Note Brief::.

'-r'
'--recursive'
     When comparing directories, recursively compare any subdirectories
     found.  *Note Comparing Directories::.

'-s'
'--report-identical-files'
     Report when two files are the same.  *Note Comparing Directories::.

'-S FILE'
'--starting-file=FILE'
     When comparing directories, start with the file FILE.  This is used
     for resuming an aborted comparison.  *Note Comparing Directories::.

'--speed-large-files'
     Use heuristics to speed handling of large files that have numerous
     scattered small changes.  *Note diff Performance::.

'--strip-trailing-cr'
     Strip any trailing carriage return at the end of an input line.
     *Note Binary::.

'--suppress-common-lines'
     Do not print common lines in side by side format.  *Note Side by
     Side Format::.

'-t'
'--expand-tabs'
     Expand tabs to spaces in the output, to preserve the alignment of
     tabs in the input files.  *Note Tabs::.

'-T'
'--initial-tab'
     Output a tab rather than a space before the text of a line in
     normal or context format.  This causes the alignment of tabs in the
     line to look normal.  *Note Tabs::.

'--tabsize=COLUMNS'
     Assume that tab stops are set every COLUMNS (default 8) print
     columns.  *Note Tabs::.

'--suppress-blank-empty'
     Suppress any blanks before newlines when printing the
     representation of an empty line, when outputting normal, context,
     or unified format.  *Note Trailing Blanks::.

'--to-file=FILE'
     Compare each operand to FILE; FILE may be a directory.

'-u'
     Use the unified output format, showing three lines of context.
     *Note Unified Format::.

'--unchanged-group-format=FORMAT'
     Use FORMAT to output a group of common lines taken from both files
     in if-then-else format.  *Note Line Group Formats::.

'--unchanged-line-format=FORMAT'
     Use FORMAT to output a line common to both files in if-then-else
     format.  *Note Line Formats::.

'--unidirectional-new-file'
     If a first file is missing, treat it as present but empty.  *Note
     Comparing Directories::.

'-U LINES'
'--unified[=LINES]'
     Use the unified output format, showing LINES (an integer) lines of
     context, or three if LINES is not given.  *Note Unified Format::.
     For proper operation, 'patch' typically needs at least two lines of
     context.

     On older systems, 'diff' supports an obsolete option '-LINES' that
     has effect when combined with '-u'.  POSIX 1003.1-2001 (*note
     Standards conformance::) does not allow this; use '-U LINES'
     instead.

'-v'
'--version'
     Output version information and then exit.

'-w'
'--ignore-all-space'
     Ignore white space when comparing lines.  *Note White Space::.

'-W COLUMNS'
'--width=COLUMNS'
     Output at most COLUMNS (default 130) print columns per line in side
     by side format.  *Note Side by Side Format::.

'-x PATTERN'
'--exclude=PATTERN'
     When comparing directories, ignore files and subdirectories whose
     basenames match PATTERN.  *Note Comparing Directories::.

'-X FILE'
'--exclude-from=FILE'
     When comparing directories, ignore files and subdirectories whose
     basenames match any pattern contained in FILE.  *Note Comparing
     Directories::.

'-y'
'--side-by-side'
     Use the side by side output format.  *Note Side by Side Format::.

'-Z'
'--ignore-trailing-space'
     Ignore white space at line end.  *Note White Space::.

