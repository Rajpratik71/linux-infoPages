File: gettext.info,  Node: msgfilter Invocation,  Next: msguniq Invocation,  Prev: msggrep Invocation,  Up: Manipulating

9.4 Invoking the ‘msgfilter’ Program
====================================

     msgfilter [OPTION] FILTER [FILTER-OPTION]

   The ‘msgfilter’ program applies a filter to all translations of a
translation catalog.

   During each FILTER invocation, the environment variable
‘MSGFILTER_MSGID’ is bound to the message’s msgid, and the environment
variable ‘MSGFILTER_LOCATION’ is bound to the location in the PO file of
the message.  If the message has a context, the environment variable
‘MSGFILTER_MSGCTXT’ is bound to the message’s msgctxt, otherwise it is
unbound.  If the message has a plural form, environment variable
‘MSGFILTER_MSGID_PLURAL’ is bound to the message’s msgid_plural and
‘MSGFILTER_PLURAL_FORM’ is bound to the order number of the plural
actually processed (starting with 0), otherwise both are unbound.  If
the message has a previous msgid (added by ‘msgmerge’), environment
variable ‘MSGFILTER_PREV_MSGCTXT’ is bound to the message’s previous
msgctxt, ‘MSGFILTER_PREV_MSGID’ is bound to the previous msgid, and
‘MSGFILTER_PREV_MSGID_PLURAL’ is bound to the previous msgid_plural.

9.4.1 Input file location
-------------------------

‘-i INPUTFILE’
‘--input=INPUTFILE’
     Input PO file.

‘-D DIRECTORY’
‘--directory=DIRECTORY’
     Add DIRECTORY to the list of directories.  Source files are
     searched relative to this list of directories.  The resulting ‘.po’
     file will be written relative to the current directory, though.

   If no INPUTFILE is given or if it is ‘-’, standard input is read.

9.4.2 Output file location
--------------------------

‘-o FILE’
‘--output-file=FILE’
     Write output to specified file.

   The results are written to standard output if no output file is
specified or if it is ‘-’.

9.4.3 The filter
----------------

   The FILTER can be any program that reads a translation from standard
input and writes a modified translation to standard output.  A
frequently used filter is ‘sed’.  A few particular built-in filters are
also recognized.

‘--newline’
     Add newline at the end of each input line and also strip the ending
     newline from the output line.

   Note: If the filter is not a built-in filter, you have to care about
encodings: It is your responsibility to ensure that the FILTER can cope
with input encoded in the translation catalog’s encoding.  If the FILTER
wants input in a particular encoding, you can in a first step convert
the translation catalog to that encoding using the ‘msgconv’ program,
before invoking ‘msgfilter’.  If the FILTER wants input in the locale’s
encoding, but you want to avoid the locale’s encoding, then you can
first convert the translation catalog to UTF-8 using the ‘msgconv’
program and then make ‘msgfilter’ work in an UTF-8 locale, by using the
‘LC_ALL’ environment variable.

   Note: Most translations in a translation catalog don’t end with a
newline character.  For this reason, unless the ‘--newline’ option is
used, it is important that the FILTER recognizes its last input line
even if it ends without a newline, and that it doesn’t add an undesired
trailing newline at the end.  The ‘sed’ program on some platforms is
known to ignore the last line of input if it is not terminated with a
newline.  You can use GNU ‘sed’ instead; it does not have this
limitation.

9.4.4 Useful FILTER-OPTIONs when the FILTER is ‘sed’
----------------------------------------------------

‘-e SCRIPT’
‘--expression=SCRIPT’
     Add SCRIPT to the commands to be executed.

‘-f SCRIPTFILE’
‘--file=SCRIPTFILE’
     Add the contents of SCRIPTFILE to the commands to be executed.

‘-n’
‘--quiet’
‘--silent’
     Suppress automatic printing of pattern space.

9.4.5 Built-in FILTERs
----------------------

   The filter ‘recode-sr-latin’ is recognized as a built-in filter.  The
command ‘recode-sr-latin’ converts Serbian text, written in the Cyrillic
script, to the Latin script.  The command ‘msgfilter recode-sr-latin’
applies this conversion to the translations of a PO file.  Thus, it can
be used to convert an ‘sr.po’ file to an ‘sr@latin.po’ file.

   The filter ‘quot’ is recognized as a built-in filter.  The command
‘msgfilter quot’ converts any quotations surrounded by a pair of ‘"’,
‘'’, and ‘`’.

   The filter ‘boldquot’ is recognized as a built-in filter.  The
command ‘msgfilter boldquot’ converts any quotations surrounded by a
pair of ‘"’, ‘'’, and ‘`’, also adding the VT100 escape sequences to the
text to decorate it as bold.

   The use of built-in filters is not sensitive to the current locale’s
encoding.  Moreover, when used with a built-in filter, ‘msgfilter’ can
automatically convert the message catalog to the UTF-8 encoding when
needed.

9.4.6 Input file syntax
-----------------------

‘-P’
‘--properties-input’
     Assume the input file is a Java ResourceBundle in Java
     ‘.properties’ syntax, not in PO file syntax.

‘--stringtable-input’
     Assume the input file is a NeXTstep/GNUstep localized resource file
     in ‘.strings’ syntax, not in PO file syntax.

9.4.7 Output details
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

‘--keep-header’
     Keep the header entry, i.e. the message with ‘msgid ""’,
     unmodified, instead of filtering it.  By default, the header entry
     is subject to filtering like any other message.

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

9.4.8 Informative output
------------------------

‘-h’
‘--help’
     Display this help and exit.

‘-V’
‘--version’
     Output version information and exit.

9.4.9 Examples
--------------

   To convert German translations to Swiss orthography (in an UTF-8
locale):

     msgconv -t UTF-8 de.po | msgfilter sed -e 's/ß/ss/g'

   To convert Serbian translations in Cyrillic script to Latin script:

     msgfilter recode-sr-latin < sr.po

