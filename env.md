File: coreutils.info,  Node: env invocation,  Next: nice invocation,  Prev: chroot invocation,  Up: Modified command invocation

23.2 'env': Run a command in a modified environment
===================================================

'env' runs a command with a modified environment.  Synopses:

     env [OPTION]... [NAME=VALUE]... [COMMAND [ARGS]...]
     env

   Operands of the form 'VARIABLE=VALUE' set the environment variable
VARIABLE to value VALUE.  VALUE may be empty ('VARIABLE=').  Setting a
variable to an empty value is different from unsetting it.  These
operands are evaluated left-to-right, so if two operands mention the
same variable the earlier is ignored.

   Environment variable names can be empty, and can contain any
characters other than '=' and ASCII NUL. However, it is wise to limit
yourself to names that consist solely of underscores, digits, and ASCII
letters, and that begin with a non-digit, as applications like the shell
do not work well with other names.

   The first operand that does not contain the character '=' specifies
the program to invoke; it is searched for according to the 'PATH'
environment variable.  Any remaining arguments are passed as arguments
to that program.  The program should not be a special built-in utility
(*note Special built-in utilities::).

   Modifications to 'PATH' take effect prior to searching for COMMAND.
Use caution when reducing 'PATH'; behavior is not portable when 'PATH'
is undefined or omits key directories such as '/bin'.

   In the rare case that a utility contains a '=' in the name, the only
way to disambiguate it from a variable assignment is to use an
intermediate command for COMMAND, and pass the problematic program name
via ARGS.  For example, if './prog=' is an executable in the current
'PATH':

     env prog= true # runs 'true', with prog= in environment
     env ./prog= true # runs 'true', with ./prog= in environment
     env -- prog= true # runs 'true', with prog= in environment
     env sh -c '\prog= true' # runs 'prog=' with argument 'true'
     env sh -c 'exec "$@"' sh prog= true # also runs 'prog='

   If no command name is specified following the environment
specifications, the resulting environment is printed.  This is like
specifying the 'printenv' program.

   For some examples, suppose the environment passed to 'env' contains
'LOGNAME=rms', 'EDITOR=emacs', and 'PATH=.:/gnubin:/hacks':

   * Output the current environment.
          $ env | LC_ALL=C sort
          EDITOR=emacs
          LOGNAME=rms
          PATH=.:/gnubin:/hacks

   * Run 'foo' with a reduced environment, preserving only the original
     'PATH' to avoid problems in locating 'foo'.
          env - PATH="$PATH" foo

   * Run 'foo' with the environment containing 'LOGNAME=rms',
     'EDITOR=emacs', and 'PATH=.:/gnubin:/hacks', and guarantees that
     'foo' was found in the file system rather than as a shell built-in.
          env foo

   * Run 'nemacs' with the environment containing 'LOGNAME=foo',
     'EDITOR=emacs', 'PATH=.:/gnubin:/hacks', and 'DISPLAY=gnu:0'.
          env DISPLAY=gnu:0 LOGNAME=foo nemacs

   * Attempt to run the program '/energy/--' (as that is the only
     possible path search result); if the command exists, the
     environment will contain 'LOGNAME=rms' and 'PATH=/energy', and the
     arguments will be 'e=mc2', 'bar', and 'baz'.
          env -u EDITOR PATH=/energy -- e=mc2 bar baz

   The program accepts the following options.  Also see *note Common
options::.  Options must precede operands.

'-0'
'--null'
     Output a zero byte (ASCII NUL) at the end of each line, rather than
     a newline.  This option enables other programs to parse the output
     of 'env' even when that output would contain data with embedded
     newlines.

'-u NAME'
'--unset=NAME'
     Remove variable NAME from the environment, if it was in the
     environment.

'-'
'-i'
'--ignore-environment'
     Start with an empty environment, ignoring the inherited
     environment.

   Exit status:

     0   if no COMMAND is specified and the environment is output
     125 if 'env' itself fails
     126 if COMMAND is found but cannot be invoked
     127 if COMMAND cannot be found
     the exit status of COMMAND otherwise

