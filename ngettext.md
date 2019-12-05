File: gettext.info,  Node: ngettext Invocation,  Next: envsubst Invocation,  Prev: gettext Invocation,  Up: sh

15.5.2.4 Invoking the ‘ngettext’ program
........................................

     ngettext [OPTION] [TEXTDOMAIN] MSGID MSGID-PLURAL COUNT

   The ‘ngettext’ program displays the native language translation of a
textual message whose grammatical form depends on a number.

*Arguments*

‘-d TEXTDOMAIN’
‘--domain=TEXTDOMAIN’
     Retrieve translated messages from TEXTDOMAIN.  Usually a TEXTDOMAIN
     corresponds to a package, a program, or a module of a program.

‘-e’
     Enable expansion of some escape sequences.  This option is for
     compatibility with the ‘gettext’ program.  The escape sequences
     ‘\a’, ‘\b’, ‘\c’, ‘\f’, ‘\n’, ‘\r’, ‘\t’, ‘\v’, ‘\\’, and ‘\’
     followed by one to three octal digits, are interpreted like the
     System V ‘echo’ program did.

‘-E’
     This option is only for compatibility with the ‘gettext’ program.
     It has no effect.

‘-h’
‘--help’
     Display this help and exit.

‘-V’
‘--version’
     Output version information and exit.

‘TEXTDOMAIN’
     Retrieve translated message from TEXTDOMAIN.

‘MSGID MSGID-PLURAL’
     Translate MSGID (English singular) / MSGID-PLURAL (English plural).

‘COUNT’
     Choose singular/plural form based on this value.

   If the TEXTDOMAIN parameter is not given, the domain is determined
from the environment variable ‘TEXTDOMAIN’.  If the message catalog is
not found in the regular directory, another location can be specified
with the environment variable ‘TEXTDOMAINDIR’.

   Note: ‘xgettext’ supports only the three-arguments form of the
‘ngettext’ invocation, where no options are present and the TEXTDOMAIN
is implicit, from the environment.

