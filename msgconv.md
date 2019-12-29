File: gettext.info,  Node: msgconv Invocation,  Next: msggrep Invocation,  Prev: msgcat Invocation,  Up: Manipulating

9.2 Invoking the ‘msgconv’ Program
==================================

     msgconv [OPTION] [INPUTFILE]

   The ‘msgconv’ program converts a translation catalog to a different
character encoding.

9.2.1 Input file location
-------------------------

‘INPUTFILE’
     Input PO file.

‘-D DIRECTORY’
‘--directory=DIRECTORY’
     Add DIRECTORY to the list of directories.  Source files are
     searched relative to this list of directories.  The resulting ‘.po’
     file will be written relative to the current directory, though.

   If no INPUTFILE is given or if it is ‘-’, standard input is read.

9.2.2 Output file location
--------------------------

‘-o FILE’
‘--output-file=FILE’
     Write output to specified file.

   The results are written to standard output if no output file is
specified or if it is ‘-’.

9.2.3 Conversion target
-----------------------

‘-t’
‘--to-code=NAME’
     Specify encoding for output.

   The default encoding is the current locale’s encoding.

9.2.4 Input file syntax
-----------------------

‘-P’
‘--properties-input’
     Assume the input file is a Java ResourceBundle in Java
     ‘.properties’ syntax, not in PO file syntax.

‘--stringtable-input’
     Assume the input file is a NeXTstep/GNUstep localized resource file
     in ‘.strings’ syntax, not in PO file syntax.

9.2.5 Output details
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

9.2.6 Informative output
------------------------

‘-h’
‘--help’
     Display this help and exit.

‘-V’
‘--version’
     Output version information and exit.

