File: coreutils.info,  Node: expand invocation,  Next: unexpand invocation,  Prev: tr invocation,  Up: Operating on characters

9.2 `expand': Convert tabs to spaces
====================================

`expand' writes the contents of each given FILE, or standard input if
none are given or for a FILE of `-', to standard output, with tab
characters converted to the appropriate number of spaces.  Synopsis:

     expand [OPTION]... [FILE]...

   By default, `expand' converts all tabs to spaces.  It preserves
backspace characters in the output; they decrement the column count for
tab calculations.  The default action is equivalent to `-t 8' (set tabs
every 8 columns).

   The program accepts the following options.  Also see *note Common
options::.

`-t TAB1[,TAB2]...'
`--tabs=TAB1[,TAB2]...'
     If only one tab stop is given, set the tabs TAB1 spaces apart
     (default is 8).  Otherwise, set the tabs at columns TAB1, TAB2,
     ... (numbered from 0), and replace any tabs beyond the last tab
     stop given with single spaces.  Tab stops can be separated by
     blanks as well as by commas.

     For compatibility, GNU `expand' also accepts the obsolete option
     syntax, `-T1[,T2]...'.  New scripts should use `-t T1[,T2]...'
     instead.

`-i'
`--initial'
     Only convert initial tabs (those that precede all non-space or
     non-tab characters) on each line to spaces.


   An exit status of zero indicates success, and a nonzero value
indicates failure.

