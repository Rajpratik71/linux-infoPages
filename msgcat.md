Next: msgconv Invocation,  Prev: Manipulating,  Up: Manipulating

9.1 Invoking the ‘msgcat’ Program
=================================

     msgcat [OPTION] [INPUTFILE]...

   The ‘msgcat’ program concatenates and merges the specified PO files.
It finds messages which are common to two or more of the specified PO
files.  By using the ‘--more-than’ option, greater commonality may be
requested before messages are printed.  Conversely, the ‘--less-than’
option may be used to specify less commonality before messages are
printed (i.e. ‘--less-than=2’ will only print the unique messages).
Translations, comments, extracted comments, and file positions will be
cumulated, except that if ‘--use-first’ is specified, they will be taken
from the first PO file to define them.

9.1.1 Input file location
-------------------------

‘INPUTFILE …’
     Input files.

‘-f FILE’
‘--files-from=FILE’
     Read the names of the input files from FILE instead of getting them
     from the command line.

‘-D DIRECTORY’
‘--directory=DIRECTORY’
     Add DIRECTORY to the list of directories.  Source files are
     searched relative to this list of directories.  The resulting ‘.po’
     file will be written relative to the current directory, though.

   If INPUTFILE is ‘-’, standard input is read.

9.1.2 Output file location
--------------------------

‘-o FILE’
‘--output-file=FILE’
     Write output to specified file.

   The results are written to standard output if no output file is
specified or if it is ‘-’.

9.1.3 Message selection
-----------------------

‘-< NUMBER’
‘--less-than=NUMBER’
     Print messages with less than NUMBER definitions, defaults to
     infinite if not set.

‘-> NUMBER’
‘--more-than=NUMBER’
     Print messages with more than NUMBER definitions, defaults to 0 if
     not set.

‘-u’
‘--unique’
     Shorthand for ‘--less-than=2’.  Requests that only unique messages
     be printed.

9.1.4 Input file syntax
-----------------------

‘-P’
‘--properties-input’
     Assume the input files are Java ResourceBundles in Java
     ‘.properties’ syntax, not in PO file syntax.

‘--stringtable-input’
     Assume the input files are NeXTstep/GNUstep localized resource
     files in ‘.strings’ syntax, not in PO file syntax.

9.1.5 Output details
--------------------

‘-t’
‘--to-code=NAME’
     Specify encoding for output.

‘--use-first’
     Use first available translation for each message.  Don’t merge
     several translations into one.

‘--lang=CATALOGNAME’
     Specify the ‘Language’ field to be used in the header entry.  See
     *note Header Entry:: for the meaning of this field.  Note: The
     ‘Language-Team’ and ‘Plural-Forms’ fields are left unchanged.

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

9.1.6 Informative output
------------------------

‘-h’
‘--help’
     Display this help and exit.

‘-V’
‘--version’
     Output version information and exit.

