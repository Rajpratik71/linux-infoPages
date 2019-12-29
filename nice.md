File: coreutils.info,  Node: nice invocation,  Next: nohup invocation,  Prev: env invocation,  Up: Modified command invocation

23.3 ‘nice’: Run a command with modified niceness
=================================================

‘nice’ prints a process’s “niceness”, or runs a command with modified
niceness.  “niceness” affects how favorably the process is scheduled in
the system.  Synopsis:

     nice [OPTION]... [COMMAND [ARG]...]

   If no arguments are given, ‘nice’ prints the current niceness.
Otherwise, ‘nice’ runs the given COMMAND with its niceness adjusted.  By
default, its niceness is incremented by 10.

   Niceness values range at least from −20 (process has high priority
and gets more resources, thus slowing down other processes) through 19
(process has lower priority and runs slowly itself, but has less impact
on the speed of other running processes).  Some systems may have a wider
range of niceness values; conversely, other systems may enforce more
restrictive limits.  An attempt to set the niceness outside the
supported range is treated as an attempt to use the minimum or maximum
supported value.

   A niceness should not be confused with a scheduling priority, which
lets applications determine the order in which threads are scheduled to
run.  Unlike a priority, a niceness is merely advice to the scheduler,
which the scheduler is free to ignore.  Also, as a point of terminology,
POSIX defines the behavior of ‘nice’ in terms of a “nice value”, which
is the non-negative difference between a niceness and the minimum
niceness.  Though ‘nice’ conforms to POSIX, its documentation and
diagnostics use the term “niceness” for compatibility with historical
practice.

   COMMAND must not be a special built-in utility (*note Special
built-in utilities::).

   Due to shell aliases and built-in ‘nice’ functions, using an
unadorned ‘nice’ interactively or in a script may get you different
functionality than that described here.  Invoke it via ‘env’ (i.e., ‘env
nice ...’) to avoid interference from the shell.

   Note to change the “niceness” of an existing process, one needs to
use the ‘renice’ command.

   The program accepts the following option.  Also see *note Common
options::.  Options must precede operands.

‘-n ADJUSTMENT’
‘--adjustment=ADJUSTMENT’
     Add ADJUSTMENT instead of 10 to the command’s niceness.  If
     ADJUSTMENT is negative and you lack appropriate privileges, ‘nice’
     issues a warning but otherwise acts as if you specified a zero
     adjustment.

     For compatibility ‘nice’ also supports an obsolete option syntax
     ‘-ADJUSTMENT’.  New scripts should use ‘-n ADJUSTMENT’ instead.

   ‘nice’ is installed only on systems that have the POSIX ‘setpriority’
function, so portable scripts should not rely on its existence on
non-POSIX platforms.

   Exit status:

     0   if no COMMAND is specified and the niceness is output
     125 if ‘nice’ itself fails
     126 if COMMAND is found but cannot be invoked
     127 if COMMAND cannot be found
     the exit status of COMMAND otherwise

   It is sometimes useful to run a non-interactive program with reduced
niceness.

     $ nice factor 4611686018427387903

   Since ‘nice’ prints the current niceness, you can invoke it through
itself to demonstrate how it works.

   The default behavior is to increase the niceness by ‘10’:

     $ nice
     0
     $ nice nice
     10
     $ nice -n 10 nice
     10

   The ADJUSTMENT is relative to the current niceness.  In the next
example, the first ‘nice’ invocation runs the second one with niceness
10, and it in turn runs the final one with a niceness that is 3 more:

     $ nice nice -n 3 nice
     13

   Specifying a niceness larger than the supported range is the same as
specifying the maximum supported value:

     $ nice -n 10000000000 nice
     19

   Only a privileged user may run a process with lower niceness:

     $ nice -n -1 nice
     nice: cannot set niceness: Permission denied
     0
     $ sudo nice -n -1 nice
     -1

