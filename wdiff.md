Next: wdiff Examples,  Up: wdiff

2.1 Invoking ‘wdiff’
====================

The format for running the ‘wdiff’ program is:

     wdiff OPTION … OLD_FILE NEW_FILE
     wdiff OPTION … -d [DIFF_FILE]

   ‘wdiff’ compares files OLD_FILE and NEW_FILE and produces an
annotated copy of NEW_FILE on standard output.  The empty string or the
string ‘-’ denotes standard input, but standard input cannot be used
twice in the same invocation.  The complete path of a file should be
given, a directory name is not accepted.  ‘wdiff’ will exit with a
status of 0 if no differences were found, a status of 1 if any
differences were found, or a status of 2 for any error.

   In this documentation, “deleted text” refers to text in OLD_FILE
which is not in NEW_FILE, while “inserted text” refers to text on
NEW_FILE which is not in OLD_FILE.

   ‘wdiff’ supports the following command line options:

‘--help’
‘-h’
     Print an informative help message describing the options.

‘--version’
‘-v’
     Print the version number of ‘wdiff’ on the standard error output.

‘--no-deleted’
‘-1’
     Avoid producing deleted words on the output.  If neither ‘-1’ or
     ‘-2’ is selected, the original right margin may be exceeded for
     some lines.

‘--no-inserted’
‘-2’
     Avoid producing inserted words on the output.  When this flag is
     given, the whitespace in the output is taken from OLD_FILE instead
     of NEW_FILE.  If neither ‘-1’ or ‘-2’ is selected, the original
     right margin may be exceeded for some lines.

‘--no-common’
‘-3’
     Avoid producing common words on the output.  When this option is
     not selected, common words and whitespace are taken from NEW_FILE,
     unless option ‘-2’ is given, in which case common words and
     whitespace are rather taken from OLD_FILE.  When selected,
     differences are separated from one another by lines of dashes.
     Moreover, if this option is selected at the same time as ‘-1’ or
     ‘-2’, then none of the output will have any emphasis, i.e.  no bold
     or underlining.  Finally, if this option is not selected, but both
     ‘-1’ and ‘-2’ are, then sections of common words between
     differences are segregated by lines of dashes.

‘--ignore-case’
‘-i’
     Do not consider case difference while comparing words.  Each lower
     case letter is seen as identical to its upper case equivalent for
     the purpose of deciding if two words are the same.

‘--statistics’
‘-s’
     On completion, for each file, the total number of words, the number
     of common words between the files, the number of words deleted or
     inserted and the number of words that have changed is output.  (A
     changed word is one that has been replaced or is part of a
     replacement.)  Except for the total number of words, all of the
     numbers are followed by a percentage relative to the total number
     of words in the file.

‘--auto-pager’
‘-a’
     Some initiatives which were previously automatically taken in
     previous versions of ‘wdiff’ are now put under the control of this
     option.  By using it, a pager is interposed whenever the ‘wdiff’
     output is directed to the user’s terminal.  Without this option, no
     pager will be called, the user is then responsible for explicitly
     piping ‘wdiff’ output into a pager, if required.

     The pager is selected by the value of the PAGER environment
     variable when ‘wdiff’ is run.  If PAGER is not defined at run time,
     then a default pager, selected at installation time, will be used
     instead.  A defined but empty value of PAGER means no pager at all.

     When a pager is interposed through the use of this option, one of
     the options ‘-l’ or ‘-t’ is also selected, depending on whether the
     string ‘less’ appears in the pager’s name or not.

     It is often useful to define ‘wdiff’ as an alias for ‘wdiff -a’.
     However, this _hides_ the normal ‘wdiff’ behaviour.  The default
     behaviour may be restored simply by piping the output from ‘wdiff’
     through ‘cat’.  This dissociates the output from the user’s
     terminal.

‘--printer’
‘-p’
     Use over-striking to emphasize parts of the output.  Each character
     of the deleted text is underlined by writing an underscore ‘_’
     first, then a backspace and then the letter to be underlined.  Each
     character of the inserted text is emboldened by writing it twice,
     with a backspace in between.  This option is not selected by
     default.

‘--less-mode’
‘-l’
     Use over-striking to emphasize parts of output.  This option works
     as option ‘-p’, but also over-strikes whitespace associated with
     inserted text.  ‘less’ shows such whitespace using reverse video.
     This option is not selected by default.  However, it is
     automatically turned on whenever ‘wdiff’ launches the pager ‘less’.
     See option ‘-a’.

     This option is commonly used in conjunction with ‘less’:

          wdiff -l OLD_FILE NEW_FILE | less

‘--terminal’
‘-t’
     Force the production of ‘termcap’ strings for emphasising parts of
     output, even if the standard output is not associated with a
     terminal.  The ‘TERM’ environment variable must contain the name of
     a valid ‘termcap’ entry.  If the terminal description permits,
     underlining is used for marking deleted text, while bold or reverse
     video is used for marking inserted text.  This option is not
     selected by default.  However, it is automatically turned on
     whenever ‘wdiff’ launches a pager, and it is known that the pager
     is _not_ ‘less’.  See option ‘-a’.

     This option is commonly used when ‘wdiff’ output is not redirected,
     but sent directly to the user terminal, as in:

          wdiff -t OLD_FILE NEW_FILE

     A common kludge uses ‘wdiff’ together with the pager ‘more’, as in:

          wdiff -t OLD_FILE NEW_FILE | more

     However, some versions of ‘more’ use ‘termcap’ emphasis for their
     own purposes, so strange interactions are possible.

‘--start-delete ARGUMENT’
‘-w ARGUMENT’
     Use ARGUMENT as the “start delete” string.  This string will be
     output prior to any sequence of deleted text, to mark where it
     starts.  By default, no start delete string is used unless there is
     no other means of distinguishing where such text starts; in this
     case the default start delete string is ‘[-’.

‘--end-delete ARGUMENT’
‘-x ARGUMENT’
     Use ARGUMENT as the “end delete” string.  This string will be
     output after any sequence of deleted text, to mark where it ends.
     By default, no end delete string is used unless there is no other
     means of distinguishing where such text ends; in this case the
     default end delete string is ‘-]’.

‘--start-insert ARGUMENT’
‘-y ARGUMENT’
     Use ARGUMENT as the “start insert” string.  This string will be
     output prior to any sequence of inserted text, to mark where it
     starts.  By default, no start insert string is used unless there is
     no other means of distinguishing where such text starts; in this
     case the default start insert string is ‘{+’.

‘--end-insert ARGUMENT’
‘-z ARGUMENT’
     Use ARGUMENT as the “end insert” string.  This string will be
     output after any sequence of inserted text, to mark where it ends.
     By default, no end insert string is used unless there is no other
     means of distinguishing where such text ends; in this case the
     default end insert string is ‘+}’.

‘--avoid-wraps’
‘-n’
     Avoid spanning the end of line while showing deleted or inserted
     text.  Any single fragment of deleted or inserted text spanning
     many lines will be considered as being made up of many smaller
     fragments not containing a newline.  So deleted text, for example,
     will have an end delete string at the end of each line, just before
     the new line, and a start delete string at the beginning of the
     next line.  A long paragraph of inserted text will have each line
     bracketed between start insert and end insert strings.  This
     behaviour is not selected by default.

‘--diff-input’
‘-d’
     Use single unified diff as input.  If no input file is specified,
     standard input is used instead.  This can be used to post-process
     diffs generated form other applications, like version control
     systems:

          svn diff | wdiff -d

   Note that options ‘-p’, ‘-t’, and ‘-[wxyz]’ are not mutually
exclusive.  If you use a combination of them, you will merely accumulate
the effect of each.  Option ‘-l’ is a variant of option ‘-p’.

