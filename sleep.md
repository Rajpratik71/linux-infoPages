Up: Delaying

25.1 ‘sleep’: Delay for a specified time
========================================

‘sleep’ pauses for an amount of time specified by the sum of the values
of the command line arguments.  Synopsis:

     sleep NUMBER[smhd]...

   Each argument is a number followed by an optional unit; the default
is seconds.  The units are:

‘s’
     seconds
‘m’
     minutes
‘h’
     hours
‘d’
     days

   Historical implementations of ‘sleep’ have required that NUMBER be an
integer, and only accepted a single argument without a suffix.  However,
GNU ‘sleep’ accepts arbitrary floating point numbers.  *Note Floating
point::.

   The only options are ‘--help’ and ‘--version’.  *Note Common
options::.

   Due to shell aliases and built-in ‘sleep’ functions, using an
unadorned ‘sleep’ interactively or in a script may get you different
functionality than that described here.  Invoke it via ‘env’ (i.e., ‘env
sleep ...’) to avoid interference from the shell.

   An exit status of zero indicates success, and a nonzero value
indicates failure.

