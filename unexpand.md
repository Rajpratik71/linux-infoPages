File: coreutils.info,  Node: unexpand invocation,  Prev: expand invocation,  Up: Operating on characters

9.3 ‘unexpand’: Convert spaces to tabs
======================================

‘unexpand’ writes the contents of each given FILE, or standard input if
none are given or for a FILE of ‘-’, to standard output, converting
blanks at the beginning of each line into as many tab characters as
needed.  In the default POSIX locale, a “blank” is a space or a tab;
other locales may specify additional blank characters.  Synopsis:

     unexpand [OPTION]... [FILE]...

   By default, ‘unexpand’ converts only initial blanks (those that
precede all non-blank characters) on each line.  It preserves backspace
characters in the output; they decrement the column count for tab
calculations.  By default, tabs are set at every 8th column.

   The program accepts the following options.  Also see *note Common
options::.

‘-t TAB1[,TAB2]...’
‘--tabs=TAB1[,TAB2]...’
     If only one tab stop is given, set the tabs TAB1 columns apart
     instead of the default 8.  Otherwise, set the tabs at columns TAB1,
     TAB2, ... (numbered from 0), and leave blanks beyond the tab stops
     given unchanged.  Tab stops can be separated by blanks as well as
     by commas.

     As a GNU extension the last TAB specified can be prefixed with a
     ‘/’ to indicate a tab size to use for remaining positions.  For
     example, ‘--tabs=2,4,/8’ will set tab stops at position 2 and 4,
     and every multiple of 8 after that.

     Also the last TAB specified can be prefixed with a ‘+’ to indicate
     a tab size to use for remaining positions, offset from the final
     explicitly specified tab stop.  For example, to ignore the 1
     character gutter present in diff output, one can specify a 1
     character offset using ‘--tabs=1,+8’, which will set tab stops at
     positions 1,9,17,...

     This option implies the ‘-a’ option.

     For compatibility, GNU ‘unexpand’ supports the obsolete option
     syntax, ‘-TAB1[,TAB2]...’, where tab stops must be separated by
     commas.  (Unlike ‘-t’, this obsolete option does not imply ‘-a’.)
     New scripts should use ‘--first-only -t TAB1[,TAB2]...’ instead.

‘-a’
‘--all’
     Also convert all sequences of two or more blanks just before a tab
     stop, even if they occur after non-blank characters in a line.

   An exit status of zero indicates success, and a nonzero value
indicates failure.

