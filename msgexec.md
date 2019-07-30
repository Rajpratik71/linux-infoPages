Next: Colorizing,  Prev: msgen Invocation,  Up: Manipulating

9.10 Invoking the ‘msgexec’ Program
===================================

     msgexec [OPTION] COMMAND [COMMAND-OPTION]

   The ‘msgexec’ program applies a command to all translations of a
translation catalog.  The COMMAND can be any program that reads a
translation from standard input.  It is invoked once for each
translation.  Its output becomes msgexec’s output.  ‘msgexec’’s return
code is the maximum return code across all invocations.

   A special builtin command called ‘0’ outputs the translation,
followed by a null byte.  The output of ‘msgexec 0’ is suitable as input
for ‘xargs -0’.

‘--newline’
     Add newline at the end of each input line.

   During each COMMAND invocation, the environment variable
‘MSGEXEC_MSGID’ is bound to the message’s msgid, and the environment
variable ‘MSGEXEC_LOCATION’ is bound to the location in the PO file of
the message.  If the message has a context, the environment variable
‘MSGEXEC_MSGCTXT’ is bound to the message’s msgctxt, otherwise it is
unbound.  If the message has a plural form, environment variable
‘MSGEXEC_MSGID_PLURAL’ is bound to the message’s msgid_plural and
‘MSGEXEC_PLURAL_FORM’ is bound to the order number of the plural
actually processed (starting with 0), otherwise both are unbound.  If
the message has a previous msgid (added by ‘msgmerge’), environment
variable ‘MSGEXEC_PREV_MSGCTXT’ is bound to the message’s previous
msgctxt, ‘MSGEXEC_PREV_MSGID’ is bound to the previous msgid, and
‘MSGEXEC_PREV_MSGID_PLURAL’ is bound to the previous msgid_plural.

   Note: It is your responsibility to ensure that the COMMAND can cope
with input encoded in the translation catalog’s encoding.  If the
COMMAND wants input in a particular encoding, you can in a first step
convert the translation catalog to that encoding using the ‘msgconv’
program, before invoking ‘msgexec’.  If the COMMAND wants input in the
locale’s encoding, but you want to avoid the locale’s encoding, then you
can first convert the translation catalog to UTF-8 using the ‘msgconv’
program and then make ‘msgexec’ work in an UTF-8 locale, by using the
‘LC_ALL’ environment variable.

9.10.1 Input file location
--------------------------

‘-i INPUTFILE’
‘--input=INPUTFILE’
     Input PO file.

‘-D DIRECTORY’
‘--directory=DIRECTORY’
     Add DIRECTORY to the list of directories.  Source files are
     searched relative to this list of directories.  The resulting ‘.po’
     file will be written relative to the current directory, though.

   If no INPUTFILE is given or if it is ‘-’, standard input is read.

9.10.2 Input file syntax
------------------------

‘-P’
‘--properties-input’
     Assume the input file is a Java ResourceBundle in Java
     ‘.properties’ syntax, not in PO file syntax.

‘--stringtable-input’
     Assume the input file is a NeXTstep/GNUstep localized resource file
     in ‘.strings’ syntax, not in PO file syntax.

9.10.3 Informative output
-------------------------

‘-h’
‘--help’
     Display this help and exit.

‘-V’
‘--version’
     Output version information and exit.

