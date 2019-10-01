File: coreutils.info,  Node: timeout invocation,  Prev: stdbuf invocation,  Up: Modified command invocation

23.6 'timeout': Run a command with a time limit
===============================================

'timeout' runs the given COMMAND and kills it if it is still running
after the specified time interval.  Synopsis:

     timeout [OPTION] DURATION COMMAND [ARG]...

   COMMAND must not be a special built-in utility (*note Special
built-in utilities::).

   The program accepts the following options.  Also see *note Common
options::.  Options must precede operands.

'--preserve-status'
     Return the exit status of the managed COMMAND on timeout, rather
     than a specific exit status indicating a timeout.  This is useful
     if the managed COMMAND supports running for an indeterminite amount
     of time.

'--foreground'
     Don't create a separate background program group, so that the
     managed COMMAND can use the foreground TTY normally.  This is
     needed to support timing out commands not started directly from an
     interactive shell, in two situations.
       1. COMMAND is interactive and needs to read from the terminal for
          example
       2. the user wants to support sending signals directly to COMMAND
          from the terminal (like Ctrl-C for example)

     Note in this mode of operation, any children of COMMAND will not be
     timed out.

'-k DURATION'
'--kill-after=DURATION'
     Ensure the monitored COMMAND is killed by also sending a 'KILL'
     signal, after the specified DURATION.  Without this option, if the
     selected signal proves not to be fatal, 'timeout' does not kill the
     COMMAND.

'-s SIGNAL'
'--signal=SIGNAL'
     Send this SIGNAL to COMMAND on timeout, rather than the default
     'TERM' signal.  SIGNAL may be a name like 'HUP' or a number.  *Note
     Signal specifications::.

   DURATION is a floating point number followed by an optional unit:
     's' for seconds (the default)
     'm' for minutes
     'h' for hours
     'd' for days
   A duration of 0 disables the associated timeout.  Note that the
actual timeout duration is dependent on system conditions, which should
be especially considered when specifying sub-second timeouts.

   Exit status:

     124 if COMMAND times out
     125 if 'timeout' itself fails
     126 if COMMAND is found but cannot be invoked
     127 if COMMAND cannot be found
     137 if COMMAND is sent the KILL(9) signal (128+9)
     the exit status of COMMAND otherwise

