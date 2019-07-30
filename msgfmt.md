Next: msgunfmt Invocation,  Prev: Binaries,  Up: Binaries

10.1 Invoking the ‘msgfmt’ Program
==================================

     msgfmt [OPTION] FILENAME.po …

   The ‘msgfmt’ programs generates a binary message catalog from a
textual translation description.

10.1.1 Input file location
--------------------------

‘FILENAME.po …’

‘-D DIRECTORY’
‘--directory=DIRECTORY’
     Add DIRECTORY to the list of directories.  Source files are
     searched relative to this list of directories.  The resulting
     binary file will be written relative to the current directory,
     though.

   If an input file is ‘-’, standard input is read.

10.1.2 Operation mode
---------------------

‘-j’
‘--java’
     Java mode: generate a Java ‘ResourceBundle’ class.

‘--java2’
     Like –java, and assume Java2 (JDK 1.2 or higher).

‘--csharp’
     C# mode: generate a .NET .dll file containing a subclass of
     ‘GettextResourceSet’.

‘--csharp-resources’
     C# resources mode: generate a .NET ‘.resources’ file.

‘--tcl’
     Tcl mode: generate a tcl/msgcat ‘.msg’ file.

‘--qt’
     Qt mode: generate a Qt ‘.qm’ file.

‘--desktop’
     Desktop Entry mode: generate a ‘.desktop’ file.

‘--xml’
     XML mode: generate an XML file.

10.1.3 Output file location
---------------------------

‘-o FILE’
‘--output-file=FILE’
     Write output to specified file.

‘--strict’
     Direct the program to work strictly following the Uniforum/Sun
     implementation.  Currently this only affects the naming of the
     output file.  If this option is not given the name of the output
     file is the same as the domain name.  If the strict Uniforum mode
     is enabled the suffix ‘.mo’ is added to the file name if it is not
     already present.

     We find this behaviour of Sun’s implementation rather silly and so
     by default this mode is _not_ selected.

   If the output FILE is ‘-’, output is written to standard output.

10.1.4 Output file location in Java mode
----------------------------------------

‘-r RESOURCE’
‘--resource=RESOURCE’
     Specify the resource name.

‘-l LOCALE’
‘--locale=LOCALE’
     Specify the locale name, either a language specification of the
     form LL or a combined language and country specification of the
     form LL_CC.

‘-d DIRECTORY’
     Specify the base directory of classes directory hierarchy.

‘--source’
     Produce a .java source file, instead of a compiled .class file.

   The class name is determined by appending the locale name to the
resource name, separated with an underscore.  The ‘-d’ option is
mandatory.  The class is written under the specified directory.

10.1.5 Output file location in C# mode
--------------------------------------

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

   The ‘-l’ and ‘-d’ options are mandatory.  The ‘.dll’ file is written
in a subdirectory of the specified directory whose name depends on the
locale.

10.1.6 Output file location in Tcl mode
---------------------------------------

‘-l LOCALE’
‘--locale=LOCALE’
     Specify the locale name, either a language specification of the
     form LL or a combined language and country specification of the
     form LL_CC.

‘-d DIRECTORY’
     Specify the base directory of ‘.msg’ message catalogs.

   The ‘-l’ and ‘-d’ options are mandatory.  The ‘.msg’ file is written
in the specified directory.

10.1.7 Desktop Entry mode operations
------------------------------------

‘--template=TEMPLATE’
     Specify a .desktop file used as a template.

‘-k[KEYWORDSPEC]’
‘--keyword[=KEYWORDSPEC]’
     Specify KEYWORDSPEC as an additional keyword to be looked for.
     Without a KEYWORDSPEC, the option means to not use default
     keywords.

‘-l LOCALE’
‘--locale=LOCALE’
     Specify the locale name, either a language specification of the
     form LL or a combined language and country specification of the
     form LL_CC.

‘-d DIRECTORY’
     Specify the directory where PO files are read.  The directory must
     contain the ‘LINGUAS’ file.

   To generate a ‘.desktop’ file for a single locale, you can use it as
follows.

     msgfmt --desktop --template=TEMPLATE --locale=LOCALE \
       -o FILE FILENAME.po …

   msgfmt provides a special "bulk" operation mode to process multiple
‘.po’ files at a time.

     msgfmt --desktop --template=TEMPLATE -d DIRECTORY -o FILE

   msgfmt first reads the ‘LINGUAS’ file under DIRECTORY, and then
processes all ‘.po’ files listed there.  You can also limit the locales
to a subset, through the ‘LINGUAS’ environment variable.

   For either operation modes, the ‘-o’ and ‘--template’ options are
mandatory.

10.1.8 XML mode operations
--------------------------

‘--template=TEMPLATE’
     Specify an XML file used as a template.

‘-L NAME’
‘--language=NAME’
     Specifies the language of the input files.

‘-l LOCALE’
‘--locale=LOCALE’
     Specify the locale name, either a language specification of the
     form LL or a combined language and country specification of the
     form LL_CC.

‘-d DIRECTORY’
     Specify the base directory of ‘.po’ message catalogs.

   To generate an XML file for a single locale, you can use it as
follows.

     msgfmt --xml --template=TEMPLATE --locale=LOCALE \
       -o FILE FILENAME.po …

   msgfmt provides a special "bulk" operation mode to process multiple
‘.po’ files at a time.

     msgfmt --xml --template=TEMPLATE -d DIRECTORY -o FILE

   msgfmt first reads the ‘LINGUAS’ file under DIRECTORY, and then
processes all ‘.po’ files listed there.  You can also limit the locales
to a subset, through the ‘LINGUAS’ environment variable.

   For either operation modes, the ‘-o’ and ‘--template’ options are
mandatory.

10.1.9 Input file syntax
------------------------

‘-P’
‘--properties-input’
     Assume the input files are Java ResourceBundles in Java
     ‘.properties’ syntax, not in PO file syntax.

‘--stringtable-input’
     Assume the input files are NeXTstep/GNUstep localized resource
     files in ‘.strings’ syntax, not in PO file syntax.

10.1.10 Input file interpretation
---------------------------------

‘-c’
‘--check’
     Perform all the checks implied by ‘--check-format’,
     ‘--check-header’, ‘--check-domain’.

‘--check-format’
     Check language dependent format strings.

     If the string represents a format string used in a ‘printf’-like
     function both strings should have the same number of ‘%’ format
     specifiers, with matching types.  If the flag ‘c-format’ or
     ‘possible-c-format’ appears in the special comment <#,> for this
     entry a check is performed.  For example, the check will diagnose
     using ‘%.*s’ against ‘%s’, or ‘%d’ against ‘%s’, or ‘%d’ against
     ‘%x’.  It can even handle positional parameters.

     Normally the ‘xgettext’ program automatically decides whether a
     string is a format string or not.  This algorithm is not perfect,
     though.  It might regard a string as a format string though it is
     not used in a ‘printf’-like function and so ‘msgfmt’ might report
     errors where there are none.

     To solve this problem the programmer can dictate the decision to
     the ‘xgettext’ program (*note c-format::).  The translator should
     not consider removing the flag from the <#,> line.  This "fix"
     would be reversed again as soon as ‘msgmerge’ is called the next
     time.

‘--check-header’
     Verify presence and contents of the header entry.  *Note Header
     Entry::, for a description of the various fields in the header
     entry.

‘--check-domain’
     Check for conflicts between domain directives and the
     ‘--output-file’ option

‘-C’
‘--check-compatibility’
     Check that GNU msgfmt behaves like X/Open msgfmt.  This will give
     an error when attempting to use the GNU extensions.

‘--check-accelerators[=CHAR]’
     Check presence of keyboard accelerators for menu items.  This is
     based on the convention used in some GUIs that a keyboard
     accelerator in a menu item string is designated by an immediately
     preceding ‘&’ character.  Sometimes a keyboard accelerator is also
     called "keyboard mnemonic".  This check verifies that if the
     untranslated string has exactly one ‘&’ character, the translated
     string has exactly one ‘&’ as well.  If this option is given with a
     CHAR argument, this CHAR should be a non-alphanumeric character and
     is used as keyboard accelerator mark instead of ‘&’.

‘-f’
‘--use-fuzzy’
     Use fuzzy entries in output.  Note that using this option is
     usually wrong, because fuzzy messages are exactly those which have
     not been validated by a human translator.

10.1.11 Output details
----------------------

‘-a NUMBER’
‘--alignment=NUMBER’
     Align strings to NUMBER bytes (default: 1).

‘--endianness=BYTEORDER’
     Write out 32-bit numbers in the given byte order.  The possible
     values are ‘big’ and ‘little’.  The default is ‘little’.

     MO files of any endianness can be used on any platform.  When a MO
     file has an endianness other than the platform’s one, the 32-bit
     numbers from the MO file are swapped at runtime.  The performance
     impact is negligible.

     This option can be useful to produce MO files that are optimized
     for one platform.

‘--no-hash’
     Don’t include a hash table in the binary file.  Lookup will be more
     expensive at run time (binary search instead of hash table lookup).

10.1.12 Informative output
--------------------------

‘-h’
‘--help’
     Display this help and exit.

‘-V’
‘--version’
     Output version information and exit.

‘--statistics’
     Print statistics about translations.  When the option ‘--verbose’
     is used in combination with ‘--statistics’, the input file name is
     printed in front of the statistics line.

‘-v’
‘--verbose’
     Increase verbosity level.

