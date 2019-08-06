File: diffutils.info-t,  Node: Invoking diff3,  Next: Invoking patch,  Prev: Invoking diff,  Up: Top

14 Invoking 'diff3'
*******************

The 'diff3' command compares three files and outputs descriptions of
their differences.  Its arguments are as follows:

     diff3 OPTIONS... MINE OLDER YOURS

   The files to compare are MINE, OLDER, and YOURS.  At most one of
these three file names may be '-', which tells 'diff3' to read the
standard input for that file.

   An exit status of 0 means 'diff3' was successful, 1 means some
conflicts were found, and 2 means trouble.

* Menu:

* diff3 Options:: Summary of options to 'diff3'.

File: diffutils.info-t,  Node: diff3 Options,  Up: Invoking diff3

14.1 Options to 'diff3'
=======================

Below is a summary of all of the options that GNU 'diff3' accepts.
Multiple single letter options (unless they take an argument) can be
combined into a single command line argument.

'-a'
'--text'
     Treat all files as text and compare them line-by-line, even if they
     do not appear to be text.  *Note Binary::.

'-A'
'--show-all'
     Incorporate all unmerged changes from OLDER to YOURS into MINE,
     surrounding conflicts with bracket lines.  *Note Marking
     Conflicts::.

'--diff-program=PROGRAM'
     Use the compatible comparison program PROGRAM to compare files
     instead of 'diff'.

'-e'
'--ed'
     Generate an 'ed' script that incorporates all the changes from
     OLDER to YOURS into MINE.  *Note Which Changes::.

'-E'
'--show-overlap'
     Like '-e', except bracket lines from overlapping changes' first and
     third files.  *Note Marking Conflicts::.  With '-E', an overlapping
     change looks like this:

          <<<<<<< MINE
          lines from MINE
          =======
          lines from YOURS
          >>>>>>> YOURS

'--help'
     Output a summary of usage and then exit.

'-i'
     Generate 'w' and 'q' commands at the end of the 'ed' script for
     System V compatibility.  This option must be combined with one of
     the '-AeExX3' options, and may not be combined with '-m'.  *Note
     Saving the Changed File::.

'--label=LABEL'
     Use the label LABEL for the brackets output by the '-A', '-E' and
     '-X' options.  This option may be given up to three times, one for
     each input file.  The default labels are the names of the input
     files.  Thus 'diff3 --label X --label Y --label Z -m A B C' acts
     like 'diff3 -m A B C', except that the output looks like it came
     from files named 'X', 'Y' and 'Z' rather than from files named 'A',
     'B' and 'C'.  *Note Marking Conflicts::.

'-m'
'--merge'
     Apply the edit script to the first file and send the result to
     standard output.  Unlike piping the output from 'diff3' to 'ed',
     this works even for binary files and incomplete lines.  '-A' is
     assumed if no edit script option is specified.  *Note Bypassing
     ed::.

'--strip-trailing-cr'
     Strip any trailing carriage return at the end of an input line.
     *Note Binary::.

'-T'
'--initial-tab'
     Output a tab rather than two spaces before the text of a line in
     normal format.  This causes the alignment of tabs in the line to
     look normal.  *Note Tabs::.

'-v'
'--version'
     Output version information and then exit.

'-x'
'--overlap-only'
     Like '-e', except output only the overlapping changes.  *Note Which
     Changes::.

'-X'
     Like '-E', except output only the overlapping changes.  In other
     words, like '-x', except bracket changes as in '-E'.  *Note Marking
     Conflicts::.

'-3'
'--easy-only'
     Like '-e', except output only the nonoverlapping changes.  *Note
     Which Changes::.

