File: coreutils.info,  Node: kill invocation,  Up: Process control

24.1 ‘kill’: Send a signal to processes
=======================================

The ‘kill’ command sends a signal to processes, causing them to
terminate or otherwise act upon receiving the signal in some way.
Alternatively, it lists information about signals.  Synopses:

     kill [-s SIGNAL | --signal SIGNAL | -SIGNAL] PID...
     kill [-l | --list | -t | --table] [SIGNAL]...

   Due to shell aliases and built-in ‘kill’ functions, using an
unadorned ‘kill’ interactively or in a script may get you different
functionality than that described here.  Invoke it via ‘env’ (i.e., ‘env
kill ...’) to avoid interference from the shell.

   The first form of the ‘kill’ command sends a signal to all PID
arguments.  The default signal to send if none is specified is ‘TERM’.
The special signal number ‘0’ does not denote a valid signal, but can be
used to test whether the PID arguments specify processes to which a
signal could be sent.

   If PID is positive, the signal is sent to the process with the
process ID PID.  If PID is zero, the signal is sent to all processes in
the process group of the current process.  If PID is −1, the signal is
sent to all processes for which the user has permission to send a
signal.  If PID is less than −1, the signal is sent to all processes in
the process group that equals the absolute value of PID.

   If PID is not positive, a system-dependent set of system processes is
excluded from the list of processes to which the signal is sent.

   If a negative PID argument is desired as the first one, it should be
preceded by ‘--’.  However, as a common extension to POSIX, ‘--’ is not
required with ‘kill -SIGNAL -PID’.  The following commands are
equivalent:

     kill -15 -1
     kill -TERM -1
     kill -s TERM -- -1
     kill -- -1

   The first form of the ‘kill’ command succeeds if every PID argument
specifies at least one process that the signal was sent to.

   The second form of the ‘kill’ command lists signal information.
Either the ‘-l’ or ‘--list’ option, or the ‘-t’ or ‘--table’ option must
be specified.  Without any SIGNAL argument, all supported signals are
listed.  The output of ‘-l’ or ‘--list’ is a list of the signal names,
one per line; if SIGNAL is already a name, the signal number is printed
instead.  The output of ‘-t’ or ‘--table’ is a table of signal numbers,
names, and descriptions.  This form of the ‘kill’ command succeeds if
all SIGNAL arguments are valid and if there is no output error.

   The ‘kill’ command also supports the ‘--help’ and ‘--version’
options.  *Note Common options::.

   A SIGNAL may be a signal name like ‘HUP’, or a signal number like
‘1’, or an exit status of a process terminated by the signal.  A signal
name can be given in canonical form or prefixed by ‘SIG’.  The case of
the letters is ignored, except for the ‘-SIGNAL’ option which must use
upper case to avoid ambiguity with lower case option letters.  *Note
Signal specifications::, for a list of supported signal names and
numbers.

