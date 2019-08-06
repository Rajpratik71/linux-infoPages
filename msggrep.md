File: gettext.info,  Node: msggrep Invocation,  Next: msgfilter Invocation,  Prev: msgconv Invocation,  Up: Manipulating

9.3 Invoking the ‘msggrep’ Program
==================================

     msggrep [OPTION] [INPUTFILE]

   The ‘msggrep’ program extracts all messages of a translation catalog
that match a given pattern or belong to some given source files.

9.3.1 Input file location
-------------------------

‘INPUTFILE’
     Input PO file.

‘-D DIRECTORY’
‘--directory=DIRECTORY’
     Add DIRECTORY to the list of directories.  Source files are
     searched relative to this list of directories.  The resulting ‘.po’
     file will be written relative to the current directory, though.

   If no INPUTFILE is given or if it is ‘-’, standard input is read.

9.3.2 Output file location
--------------------------

‘-o FILE’
‘--output-file=FILE’
     Write output to specified file.

   The results are written to standard output if no output file is
specified or if it is ‘-’.

9.3.3 Message selection
-----------------------

       [-N SOURCEFILE]... [-M DOMAINNAME]...
       [-J MSGCTXT-PATTERN] [-K MSGID-PATTERN] [-T MSGSTR-PATTERN]
       [-C COMMENT-PATTERN]

   A message is selected if
   • it comes from one of the specified source files,
   • or if it comes from one of the specified domains,
   • or if ‘-J’ is given and its context (msgctxt) matches
     MSGCTXT-PATTERN,
   • or if ‘-K’ is given and its key (msgid or msgid_plural) matches
     MSGID-PATTERN,
   • or if ‘-T’ is given and its translation (msgstr) matches
     MSGSTR-PATTERN,
   • or if ‘-C’ is given and the translator’s comment matches
     COMMENT-PATTERN.

   When more than one selection criterion is specified, the set of
selected messages is the union of the selected messages of each
criterion.

   MSGCTXT-PATTERN or MSGID-PATTERN or MSGSTR-PATTERN syntax:
       [-E | -F] [-e PATTERN | -f FILE]...
   PATTERNs are basic regular expressions by default, or extended
regular expressions if -E is given, or fixed strings if -F is given.

‘-N SOURCEFILE’
‘--location=SOURCEFILE’
     Select messages extracted from SOURCEFILE.  SOURCEFILE can be
     either a literal file name or a wildcard pattern.

‘-M DOMAINNAME’
‘--domain=DOMAINNAME’
     Select messages belonging to domain DOMAINNAME.

‘-J’
‘--msgctxt’
     Start of patterns for the msgctxt.

‘-K’
‘--msgid’
     Start of patterns for the msgid.

‘-T’
‘--msgstr’
     Start of patterns for the msgstr.

‘-C’
‘--comment’
     Start of patterns for the translator’s comment.

‘-X’
‘--extracted-comment’
     Start of patterns for the extracted comments.

‘-E’
‘--extended-regexp’
     Specify that PATTERN is an extended regular expression.

‘-F’
‘--fixed-strings’
     Specify that PATTERN is a set of newline-separated strings.

‘-e PATTERN’
‘--regexp=PATTERN’
     Use PATTERN as a regular expression.

‘-f FILE’
‘--file=FILE’
     Obtain PATTERN from FILE.

‘-i’
‘--ignore-case’
     Ignore case distinctions.

‘-v’
‘--invert-match’
     Output only the messages that do not match any selection criterion,
     instead of the messages that match a selection criterion.

9.3.4 Input file syntax
-----------------------

‘-P’
‘--properties-input’
     Assume the input file is a Java ResourceBundle in Java
     ‘.properties’ syntax, not in PO file syntax.

‘--stringtable-input’
     Assume the input file is a NeXTstep/GNUstep localized resource file
     in ‘.strings’ syntax, not in PO file syntax.

9.3.5 Output details
--------------------

‘--color’
‘--color=WHEN’
     Specify whether or when to use colors and other text attributes.
     See *note The --color option:: for details.

‘--style=STYLE_FILE’
     Specify the CSS style rule file to use for ‘--color’.  See *note
     The --style option:: for details.

‘--force-po’
     Always write an output file even if it contains no message.

‘--indent’
     Write the .po file using indented style.

‘--no-location’
     Do not write ‘#: FILENAME:LINE’ lines.

‘-n’
‘--add-location=TYPE’
     Generate ‘#: FILENAME:LINE’ lines (default).

     The optional TYPE can be either ‘full’, ‘file’, or ‘never’.  If it
     is not given or ‘full’, it generates the lines with both file name
     and line number.  If it is ‘file’, the line number part is omitted.
     If it is ‘never’, it completely suppresses the lines (same as
     ‘--no-location’).

‘--strict’
     Write out a strict Uniforum conforming PO file.  Note that this
     Uniforum format should be avoided because it doesn’t support the
     GNU extensions.

‘-p’
‘--properties-output’
     Write out a Java ResourceBundle in Java ‘.properties’ syntax.  Note
     that this file format doesn’t support plural forms and silently
     drops obsolete messages.

‘--stringtable-output’
     Write out a NeXTstep/GNUstep localized resource file in ‘.strings’
     syntax.  Note that this file format doesn’t support plural forms.

‘-w NUMBER’
‘--width=NUMBER’
     Set the output page width.  Long strings in the output files will
     be split across multiple lines in order to ensure that each line’s
     width (= number of screen columns) is less or equal to the given
     NUMBER.

‘--no-wrap’
     Do not break long message lines.  Message lines whose width exceeds
     the output page width will not be split into several lines.  Only
     file reference lines which are wider than the output page width
     will be split.

‘--sort-output’
     Generate sorted output.  Note that using this option makes it much
     harder for the translator to understand each message’s context.

‘--sort-by-file’
     Sort output by file location.

9.3.6 Informative output
------------------------

‘-h’
‘--help’
     Display this help and exit.

‘-V’
‘--version’
     Output version information and exit.

9.3.7 Examples
--------------

   To extract the messages that come from the source files
‘gnulib-lib/error.c’ and ‘gnulib-lib/getopt.c’:

     msggrep -N gnulib-lib/error.c -N gnulib-lib/getopt.c input.po

   To extract the messages that contain the string “Please specify” in
the original string:

     msggrep --msgid -F -e 'Please specify' input.po

   To extract the messages that have a context specifier of either
“Menu>File” or “Menu>Edit” or a submenu of them:

     msggrep --msgctxt -E -e '^Menu>(File|Edit)' input.po

   To extract the messages whose translation contains one of the strings
in the file ‘wordlist.txt’:

     msggrep --msgstr -F -f wordlist.txt input.po

