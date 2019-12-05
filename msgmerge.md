File: gettext.info,  Node: msgmerge Invocation,  Prev: Updating,  Up: Updating

7.1 Invoking the ‘msgmerge’ Program
===================================

     msgmerge [OPTION] DEF.po REF.pot

   The ‘msgmerge’ program merges two Uniforum style .po files together.
The DEF.po file is an existing PO file with translations which will be
taken over to the newly created file as long as they still match;
comments will be preserved, but extracted comments and file positions
will be discarded.  The REF.pot file is the last created PO file with
up-to-date source references but old translations, or a PO Template file
(generally created by ‘xgettext’); any translations or comments in the
file will be discarded, however dot comments and file positions will be
preserved.  Where an exact match cannot be found, fuzzy matching is used
to produce better results.

7.1.1 Input file location
-------------------------

‘DEF.po’
     Translations referring to old sources.

‘REF.pot’
     References to the new sources.

‘-D DIRECTORY’
‘--directory=DIRECTORY’
     Add DIRECTORY to the list of directories.  Source files are
     searched relative to this list of directories.  The resulting ‘.po’
     file will be written relative to the current directory, though.

‘-C FILE’
‘--compendium=FILE’
     Specify an additional library of message translations.  *Note
     Compendium::.  This option may be specified more than once.

7.1.2 Operation mode
--------------------

‘-U’
‘--update’
     Update DEF.po.  Do nothing if DEF.po is already up to date.

7.1.3 Output file location
--------------------------

‘-o FILE’
‘--output-file=FILE’
     Write output to specified file.

   The results are written to standard output if no output file is
specified or if it is ‘-’.

7.1.4 Output file location in update mode
-----------------------------------------

   The result is written back to DEF.po.

‘--backup=CONTROL’
     Make a backup of DEF.po

‘--suffix=SUFFIX’
     Override the usual backup suffix.

   The version control method may be selected via the ‘--backup’ option
or through the ‘VERSION_CONTROL’ environment variable.  Here are the
values:

‘none’
‘off’
     Never make backups (even if ‘--backup’ is given).

‘numbered’
‘t’
     Make numbered backups.

‘existing’
‘nil’
     Make numbered backups if numbered backups for this file already
     exist, otherwise make simple backups.

‘simple’
‘never’
     Always make simple backups.

   The backup suffix is ‘~’, unless set with ‘--suffix’ or the
‘SIMPLE_BACKUP_SUFFIX’ environment variable.

7.1.5 Operation modifiers
-------------------------

‘-m’
‘--multi-domain’
     Apply REF.pot to each of the domains in DEF.po.

‘-N’
‘--no-fuzzy-matching’
     Do not use fuzzy matching when an exact match is not found.  This
     may speed up the operation considerably.

‘--previous’
     Keep the previous msgids of translated messages, marked with ‘#|’,
     when adding the fuzzy marker to such messages.

7.1.6 Input file syntax
-----------------------

‘-P’
‘--properties-input’
     Assume the input files are Java ResourceBundles in Java
     ‘.properties’ syntax, not in PO file syntax.

‘--stringtable-input’
     Assume the input files are NeXTstep/GNUstep localized resource
     files in ‘.strings’ syntax, not in PO file syntax.

7.1.7 Output details
--------------------

‘--lang=CATALOGNAME’
     Specify the ‘Language’ field to be used in the header entry.  See
     *note Header Entry:: for the meaning of this field.  Note: The
     ‘Language-Team’ and ‘Plural-Forms’ fields are left unchanged.  If
     this option is not specified, the ‘Language’ field is inferred, as
     best as possible, from the ‘Language-Team’ field.

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

7.1.8 Informative output
------------------------

‘-h’
‘--help’
     Display this help and exit.

‘-V’
‘--version’
     Output version information and exit.

‘-v’
‘--verbose’
     Increase verbosity level.

‘-q’
‘--quiet’
‘--silent’
     Suppress progress indicators.

