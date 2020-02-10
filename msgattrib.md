Next: msgen Invocation,  Prev: msgcmp Invocation,  Up: Manipulating

9.8 Invoking the ‘msgattrib’ Program
====================================

     msgattrib [OPTION] [INPUTFILE]

   The ‘msgattrib’ program filters the messages of a translation catalog
according to their attributes, and manipulates the attributes.

9.8.1 Input file location
-------------------------

‘INPUTFILE’
     Input PO file.

‘-D DIRECTORY’
‘--directory=DIRECTORY’
     Add DIRECTORY to the list of directories.  Source files are
     searched relative to this list of directories.  The resulting ‘.po’
     file will be written relative to the current directory, though.

   If no INPUTFILE is given or if it is ‘-’, standard input is read.

9.8.2 Output file location
--------------------------

‘-o FILE’
‘--output-file=FILE’
     Write output to specified file.

   The results are written to standard output if no output file is
specified or if it is ‘-’.

9.8.3 Message selection
-----------------------

‘--translated’
     Keep translated messages, remove untranslated messages.

‘--untranslated’
     Keep untranslated messages, remove translated messages.

‘--no-fuzzy’
     Remove ‘fuzzy’ marked messages.

‘--only-fuzzy’
     Keep ‘fuzzy’ marked messages, remove all other messages.

‘--no-obsolete’
     Remove obsolete #~ messages.

‘--only-obsolete’
     Keep obsolete #~ messages, remove all other messages.

9.8.4 Attribute manipulation
----------------------------

   Attributes are modified after the message selection/removal has been
performed.  If the ‘--only-file’ or ‘--ignore-file’ option is specified,
the attribute modification is applied only to those messages that are
listed in the ONLY-FILE and not listed in the IGNORE-FILE.

‘--set-fuzzy’
     Set all messages ‘fuzzy’.

‘--clear-fuzzy’
     Set all messages non-‘fuzzy’.

‘--set-obsolete’
     Set all messages obsolete.

‘--clear-obsolete’
     Set all messages non-obsolete.

‘--previous’
     When setting ‘fuzzy’ mark, keep “previous msgid” of translated
     messages.

‘--clear-previous’
     Remove the “previous msgid” (‘#|’) comments from all messages.

‘--empty’
     When removing ‘fuzzy’ mark, also set msgstr empty.

‘--only-file=FILE’
     Limit the attribute changes to entries that are listed in FILE.
     FILE should be a PO or POT file.

‘--ignore-file=FILE’
     Limit the attribute changes to entries that are not listed in FILE.
     FILE should be a PO or POT file.

‘--fuzzy’
     Synonym for ‘--only-fuzzy --clear-fuzzy’: It keeps only the fuzzy
     messages and removes their ‘fuzzy’ mark.

‘--obsolete’
     Synonym for ‘--only-obsolete --clear-obsolete’: It keeps only the
     obsolete messages and makes them non-obsolete.

9.8.5 Input file syntax
-----------------------

‘-P’
‘--properties-input’
     Assume the input file is a Java ResourceBundle in Java
     ‘.properties’ syntax, not in PO file syntax.

‘--stringtable-input’
     Assume the input file is a NeXTstep/GNUstep localized resource file
     in ‘.strings’ syntax, not in PO file syntax.

9.8.6 Output details
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

‘-i’
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

‘-s’
‘--sort-output’
     Generate sorted output.  Note that using this option makes it much
     harder for the translator to understand each message’s context.

‘-F’
‘--sort-by-file’
     Sort output by file location.

9.8.7 Informative output
------------------------

‘-h’
‘--help’
     Display this help and exit.

‘-V’
‘--version’
     Output version information and exit.

