File: gettext.info,  Node: msgcmp Invocation,  Next: msgattrib Invocation,  Prev: msgcomm Invocation,  Up: Manipulating

9.7 Invoking the ‘msgcmp’ Program
=================================

     msgcmp [OPTION] DEF.po REF.pot

   The ‘msgcmp’ program compares two Uniforum style .po files to check
that both contain the same set of msgid strings.  The DEF.po file is an
existing PO file with the translations.  The REF.pot file is the last
created PO file, or a PO Template file (generally created by
‘xgettext’).  This is useful for checking that you have translated each
and every message in your program.  Where an exact match cannot be
found, fuzzy matching is used to produce better diagnostics.

9.7.1 Input file location
-------------------------

‘DEF.po’
     Translations.

‘REF.pot’
     References to the sources.

‘-D DIRECTORY’
‘--directory=DIRECTORY’
     Add DIRECTORY to the list of directories.  Source files are
     searched relative to this list of directories.

9.7.2 Operation modifiers
-------------------------

‘-m’
‘--multi-domain’
     Apply REF.pot to each of the domains in DEF.po.

‘-N’
‘--no-fuzzy-matching’
     Do not use fuzzy matching when an exact match is not found.  This
     may speed up the operation considerably.

‘--use-fuzzy’
     Consider fuzzy messages in the DEF.po file like translated
     messages.  Note that using this option is usually wrong, because
     fuzzy messages are exactly those which have not been validated by a
     human translator.

‘--use-untranslated’
     Consider untranslated messages in the DEF.po file like translated
     messages.  Note that using this option is usually wrong.

9.7.3 Input file syntax
-----------------------

‘-P’
‘--properties-input’
     Assume the input files are Java ResourceBundles in Java
     ‘.properties’ syntax, not in PO file syntax.

‘--stringtable-input’
     Assume the input files are NeXTstep/GNUstep localized resource
     files in ‘.strings’ syntax, not in PO file syntax.

9.7.4 Informative output
------------------------

‘-h’
‘--help’
     Display this help and exit.

‘-V’
‘--version’
     Output version information and exit.

