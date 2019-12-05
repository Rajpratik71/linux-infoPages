File: gettext.info,  Node: msginit Invocation,  Next: Header Entry,  Prev: Creating,  Up: Creating

6.1 Invoking the ‘msginit’ Program
==================================

     msginit [OPTION]

   The ‘msginit’ program creates a new PO file, initializing the meta
information with values from the user’s environment.

   Here are more details.  The following header fields of a PO file are
automatically filled, when possible.

‘Project-Id-Version’
     The value is guessed from the ‘configure’ script or any other files
     in the current directory.

‘PO-Revision-Date’
     The value is taken from the ‘PO-Creation-Data’ in the input POT
     file, or the current date is used.

‘Last-Translator’
     The value is taken from user’s password file entry and the mailer
     configuration files.

‘Language-Team, Language’
     These values are set according to the current locale and the
     predefined list of translation teams.

‘MIME-Version, Content-Type, Content-Transfer-Encoding’
     These values are set according to the content of the POT file and
     the current locale.  If the POT file contains charset=UTF-8, it
     means that the POT file contains non-ASCII characters, and we keep
     the UTF-8 encoding.  Otherwise, when the POT file is plain ASCII,
     we use the locale’s encoding.

‘Plural-Forms’
     The value is first looked up from the embedded table.

     As an experimental feature, you can instruct ‘msginit’ to use the
     information from Unicode CLDR, by setting the ‘GETTEXTCLDRDIR’
     environment variable.

6.1.1 Input file location
-------------------------

‘-i INPUTFILE’
‘--input=INPUTFILE’
     Input POT file.

   If no INPUTFILE is given, the current directory is searched for the
POT file.  If it is ‘-’, standard input is read.

6.1.2 Output file location
--------------------------

‘-o FILE’
‘--output-file=FILE’
     Write output to specified PO file.

   If no output file is given, it depends on the ‘--locale’ option or
the user’s locale setting.  If it is ‘-’, the results are written to
standard output.

6.1.3 Input file syntax
-----------------------

‘-P’
‘--properties-input’
     Assume the input file is a Java ResourceBundle in Java
     ‘.properties’ syntax, not in PO file syntax.

‘--stringtable-input’
     Assume the input file is a NeXTstep/GNUstep localized resource file
     in ‘.strings’ syntax, not in PO file syntax.

6.1.4 Output details
--------------------

‘-l LL_CC’
‘--locale=LL_CC’
     Set target locale.  LL should be a language code, and CC should be
     a country code.  The command ‘locale -a’ can be used to output a
     list of all installed locales.  The default is the user’s locale
     setting.

‘--no-translator’
     Declares that the PO file will not have a human translator and is
     instead automatically generated.

‘--color’
‘--color=WHEN’
     Specify whether or when to use colors and other text attributes.
     See *note The --color option:: for details.

‘--style=STYLE_FILE’
     Specify the CSS style rule file to use for ‘--color’.  See *note
     The --style option:: for details.

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

6.1.5 Informative output
------------------------

‘-h’
‘--help’
     Display this help and exit.

‘-V’
‘--version’
     Output version information and exit.

