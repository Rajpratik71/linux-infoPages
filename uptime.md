File: coreutils.info,  Node: uptime invocation,  Prev: hostid invocation,  Up: System context

21.7 'uptime': Print system uptime and load
===========================================

'uptime' prints the current time, the system's uptime, the number of
logged-in users and the current load average.

   If an argument is specified, it is used as the file to be read to
discover how many users are logged in.  If no argument is specified, a
system default is used ('uptime --help' indicates the default setting).

   The only options are '--help' and '--version'.  *Note Common
options::.

   For example, here's what it prints right now on one system I use:

     $ uptime
      14:07  up   3:35,  3 users,  load average: 1.39, 1.15, 1.04

   The precise method of calculation of load average varies somewhat
between systems.  Some systems calculate it as the average number of
runnable processes over the last 1, 5 and 15 minutes, but some systems
also include processes in the uninterruptible sleep state (that is,
those processes which are waiting for disk I/O). The Linux kernel
includes uninterruptible processes.

