File: coreutils.info,  Node: runcon invocation,  Prev: chcon invocation,  Up: SELinux context

22.2 `runcon': Run a command in specified SELinux context
=========================================================

`runcon' runs file in specified SELinux security context.

   Synopses:
     runcon CONTEXT COMMAND [ARGS]
     runcon [ -c ] [-u USER] [-r ROLE] [-t TYPE] [-l RANGE] COMMAND [ARGS]

   Run COMMAND with completely-specified CONTEXT, or with current or
transitioned security context modified by one or more of LEVEL, ROLE,
TYPE and USER.

   If none of `-c', `-t', `-u', `-r', or `-l' is specified, the first
argument is used as the complete context.  Any additional arguments
after COMMAND are interpreted as arguments to the command.

   With neither CONTEXT nor COMMAND, print the current security context.

   The program accepts the following options.  Also see *note Common
options::.

`-c'
`--compute'
     Compute process transition context before modifying.

`-u USER'
`--user=USER'
     Set user USER in the target security context.

`-r ROLE'
`--role=ROLE'
     Set role ROLE in the target security context.

`-t TYPE'
`--type=TYPE'
     Set type TYPE in the target security context.

`-l RANGE'
`--range=RANGE'
     Set range RANGE in the target security context.


   Exit status:

     126 if COMMAND is found but cannot be invoked
     127 if `runcon' itself fails or if COMMAND cannot be found
     the exit status of COMMAND otherwise

