Next: MO Files,  Prev: msgfmt Invocation,  Up: Binaries

10.2 Invoking the ‘msgunfmt’ Program
====================================

     msgunfmt [OPTION] [FILE]...

   The ‘msgunfmt’ program converts a binary message catalog to a
Uniforum style .po file.

10.2.1 Operation mode
---------------------

‘-j’
‘--java’
     Java mode: input is a Java ‘ResourceBundle’ class.

‘--csharp’
     C# mode: input is a .NET .dll file containing a subclass of
     ‘GettextResourceSet’.

‘--csharp-resources’
     C# resources mode: input is a .NET ‘.resources’ file.

‘--tcl’
     Tcl mode: input is a tcl/msgcat ‘.msg’ file.

10.2.2 Input file location
--------------------------

‘FILE …’
     Input .mo files.

   If no input FILE is given or if it is ‘-’, standard input is read.

10.2.3 Input file location in Java mode
---------------------------------------

‘-r RESOURCE’
‘--resource=RESOURCE’
     Specify the resource name.

‘-l LOCALE’
‘--locale=LOCALE’
     Specify the locale name, either a language specification of the
     form LL or a combined language and country specification of the
     form LL_CC.

   The class name is determined by appending the locale name to the
resource name, separated with an underscore.  The class is located using
the ‘CLASSPATH’.

10.2.4 Input file location in C# mode
-------------------------------------

‘-r RESOURCE’
‘--resource=RESOURCE’
     Specify the resource name.

‘-l LOCALE’
‘--locale=LOCALE’
     Specify the locale name, either a language specification of the
     form LL or a combined language and country specification of the
     form LL_CC.

‘-d DIRECTORY’
     Specify the base directory for locale dependent ‘.dll’ files.

   The ‘-l’ and ‘-d’ options are mandatory.  The ‘.msg’ file is located
in a subdirectory of the specified directory whose name depends on the
locale.

10.2.5 Input file location in Tcl mode
--------------------------------------

‘-l LOCALE’
‘--locale=LOCALE’
     Specify the locale name, either a language specification of the
     form LL or a combined language and country specification of the
     form LL_CC.

‘-d DIRECTORY’
     Specify the base directory of ‘.msg’ message catalogs.

   The ‘-l’ and ‘-d’ options are mandatory.  The ‘.msg’ file is located
in the specified directory.

10.2.6 Output file location
---------------------------

‘-o FILE’
‘--output-file=FILE’
     Write output to specified file.

   The results are written to standard output if no output file is
specified or if it is ‘-’.

10.2.7 Output details
---------------------

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

10.2.8 Informative output
-------------------------

‘-h’
‘--help’
     Display this help and exit.

‘-V’
‘--version’
     Output version information and exit.

‘-v’
‘--verbose’
     Increase verbosity level.

