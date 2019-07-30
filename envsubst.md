Next: eval_gettext Invocation,  Prev: ngettext Invocation,  Up: sh

15.5.2.5 Invoking the ‘envsubst’ program
........................................

     envsubst [OPTION] [SHELL-FORMAT]

   The ‘envsubst’ program substitutes the values of environment
variables.

*Operation mode*

‘-v’
‘--variables’
     Output the variables occurring in SHELL-FORMAT.

*Informative output*

‘-h’
‘--help’
     Display this help and exit.

‘-V’
‘--version’
     Output version information and exit.

   In normal operation mode, standard input is copied to standard
output, with references to environment variables of the form ‘$VARIABLE’
or ‘${VARIABLE}’ being replaced with the corresponding values.  If a
SHELL-FORMAT is given, only those environment variables that are
referenced in SHELL-FORMAT are substituted; otherwise all environment
variables references occurring in standard input are substituted.

   These substitutions are a subset of the substitutions that a shell
performs on unquoted and double-quoted strings.  Other kinds of
substitutions done by a shell, such as ‘${VARIABLE-DEFAULT}’ or
‘$(COMMAND-LIST)’ or ‘`COMMAND-LIST`’, are not performed by the
‘envsubst’ program, due to security reasons.

   When ‘--variables’ is used, standard input is ignored, and the output
consists of the environment variables that are referenced in
SHELL-FORMAT, one per line.

