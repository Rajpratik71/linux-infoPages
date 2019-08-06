File: *manpages*,  Node: renice,  Up: (dir)

RENICE(1)                        User Commands                       RENICE(1)



NAME
       renice - alter priority of running processes

SYNOPSIS
       renice [-n] priority [-g|-p|-u] identifier...

DESCRIPTION
       renice alters the scheduling priority of one or more running processes.
       The first argument is the priority value to be used.  The  other  argu-
       ments  are  interpreted as process IDs (by default), process group IDs,
       user IDs, or user names.  renice'ing a process group  causes  all  pro-
       cesses  in the process group to have their scheduling priority altered.
       renice'ing a user causes all processes owned by the user to have  their
       scheduling priority altered.

OPTIONS
       -n, --priority priority
              Specify  the  scheduling  priority  to  be used for the process,
              process group, or user.  Use of the option -n or  --priority  is
              optional, but when used it must be the first argument.

       -g, --pgrp
              Interpret the succeeding arguments as process group IDs.

       -p, --pid
              Interpret the succeeding arguments as process IDs (the default).

       -u, --user
              Interpret the succeeding arguments as usernames or UIDs.

       -V, --version
              Display version information and exit.

       -h, --help
              Display help text and exit.

EXAMPLES
       The  following  command would change the priority of the processes with
       PIDs 987 and 32, plus all processes owned by the users daemon and root:

              renice +1 987 -u daemon root -p 32

NOTES
       Users other than the superuser may only alter the priority of processes
       they  own.   Furthermore,  an  unprivileged  user can only increase the
       ``nice value'' (i.e., choose a lower priority)  and  such  changes  are
       irreversible  unless  (since  Linux  2.6.12)  the  user  has a suitable
       ``nice'' resource limit (see ulimit(1) and getrlimit(2)).

       The superuser may alter the priority of any process and set the  prior-
       ity  to  any  value  in the range -20 to 19.  Useful priorities are: 19
       (the affected processes will run only when nothing else in  the  system
       wants  to), 0 (the ``base'' scheduling priority), anything negative (to
       make things go very fast).

FILES
       /etc/passwd
              to map user names to user IDs

SEE ALSO
       nice(1), getpriority(2), setpriority(2), credentials(7), sched(7)

HISTORY
       The renice command appeared in 4.0BSD.

AVAILABILITY
       The renice command is part of the util-linux package and  is  available
       from  Linux  Kernel Archive ⟨ftp://ftp.kernel.org/pub/linux/utils/util-
       linux/⟩.



util-linux                         July 2014                         RENICE(1)
RENICE(1P)                 POSIX Programmer's Manual                RENICE(1P)



PROLOG
       This  manual  page is part of the POSIX Programmer's Manual.  The Linux
       implementation of this interface may differ (consult the  corresponding
       Linux  manual page for details of Linux behavior), or the interface may
       not be implemented on Linux.

NAME
       renice - set nice values of running processes

SYNOPSIS
       renice -n increment [-g | -p | -u] ID ...

DESCRIPTION
       The renice utility shall request that the nice  values  (see  the  Base
       Definitions  volume of IEEE Std 1003.1-2001, Section 3.239, Nice Value)
       of one or more running processes be changed.  By default, the  applica-
       ble processes are specified by their process IDs.  When a process group
       is specified (see -g), the request shall apply to all processes in  the
       process group.

       The  nice  value  shall be bounded in an implementation-defined manner.
       If the requested increment would raise or lower the nice value  of  the
       executed  utility  beyond implementation-defined limits, then the limit
       whose value was exceeded shall be used.

       When a user is reniced, the request  applies  to  all  processes  whose
       saved set-user-ID matches the user ID corresponding to the user.

       Regardless  of  which  options are supplied or any other factor, renice
       shall not alter the nice values of any process unless the user request-
       ing such a change has appropriate privileges to do so for the specified
       process. If the  user  lacks  appropriate  privileges  to  perform  the
       requested action, the utility shall return an error status.

       The saved set-user-ID of the user's process shall be checked instead of
       its effective user ID when renice attempts to determine the user ID  of
       the  process  in  order  to  determine whether the user has appropriate
       privileges.

OPTIONS
       The renice utility shall conform to  the  Base  Definitions  volume  of
       IEEE Std 1003.1-2001, Section 12.2, Utility Syntax Guidelines.

       The following options shall be supported:

       -g     Interpret all operands as unsigned decimal integer process group
              IDs.

       -n  increment
              Specify how the nice value of the specified process or processes
              is  to  be adjusted. The increment option-argument is a positive
              or negative decimal integer that shall be  used  to  modify  the
              nice value of the specified process or processes.

       Positive  increment  values  shall  cause  a lower nice value. Negative
       increment values may require appropriate privileges and shall  cause  a
       higher nice value.

       -p     Interpret  all operands as unsigned decimal integer process IDs.
              The -p option is the default if no options are specified.

       -u     Interpret all operands as users. If a user exists  with  a  user
              name equal to the operand, then the user ID of that user is used
              in further processing. Otherwise, if the operand  represents  an
              unsigned  decimal  integer, it shall be used as the numeric user
              ID of the user.


OPERANDS
       The following operands shall be supported:

       ID     A process ID, process group ID, or user name/user ID,  depending
              on the option selected.


STDIN
       Not used.

INPUT FILES
       None.

ENVIRONMENT VARIABLES
       The  following  environment  variables  shall  affect  the execution of
       renice:

       LANG   Provide a default value for the  internationalization  variables
              that  are  unset  or  null.  (See the Base Definitions volume of
              IEEE Std 1003.1-2001, Section  8.2,  Internationalization  Vari-
              ables  for the precedence of internationalization variables used
              to determine the values of locale categories.)

       LC_ALL If set to a non-empty string value, override the values  of  all
              the other internationalization variables.

       LC_CTYPE
              Determine  the  locale  for  the  interpretation of sequences of
              bytes of text data as characters (for  example,  single-byte  as
              opposed to multi-byte characters in arguments).

       LC_MESSAGES
              Determine  the  locale  that should be used to affect the format
              and contents of diagnostic messages written to standard error.

       NLSPATH
              Determine the location of message catalogs for the processing of
              LC_MESSAGES .


ASYNCHRONOUS EVENTS
       Default.

STDOUT
       Not used.

STDERR
       The standard error shall be used only for diagnostic messages.

OUTPUT FILES
       None.

EXTENDED DESCRIPTION
       None.

EXIT STATUS
       The following exit values shall be returned:

        0     Successful completion.

       >0     An error occurred.


CONSEQUENCES OF ERRORS
       Default.

       The following sections are informative.

APPLICATION USAGE
       None.

EXAMPLES
        1. Adjust  the  nice value so that process IDs 987 and 32 would have a
           lower nice value:


           renice -n 5 -p 987 32

        2. Adjust the nice value so that group IDs 324 and  76  would  have  a
           higher nice value, if the user has the appropriate privileges to do
           so:


           renice -n -4 -g 324 76

        3. Adjust the nice value so that numeric user ID 8 and user sas  would
           have a lower nice value:


           renice -n 4 -u 8 sas

       Useful  nice  value  increments  on historical systems include 19 or 20
       (the affected processes run  only  when  nothing  else  in  the  system
       attempts  to  run)  and  any  negative  number  (to  make processes run
       faster).

RATIONALE
       The gid, pid, and user specifications do not fit either the  definition
       of  operand  or  option-argument.  However, for clarity, they have been
       included in the OPTIONS section, rather than the OPERANDS section.

       The definition of nice value is not intended to suggest that  all  pro-
       cesses  in  a  system  have priorities that are comparable.  Scheduling
       policy extensions such as the realtime priorities in the System  Inter-
       faces volume of IEEE Std 1003.1-2001 make the notion of a single under-
       lying priority for all scheduling policies problematic. Some  implemen-
       tations may implement the nice-related features to affect all processes
       on the system, others to affect just the general  time-sharing  activi-
       ties  implied  by  this  volume of IEEE Std 1003.1-2001, and others may
       have no effect at all. Because of the use  of  "implementation-defined"
       in  nice and renice, a wide range of implementation strategies are pos-
       sible.

       Originally, this utility was written in the  historical  manner,  using
       the  term  "nice  value". This was always a point of concern with users
       because it was never intuitively obvious what this meant.  With a newer
       version of renice, which used the term "system scheduling priority", it
       was hoped that novice users could better understand what  this  utility
       was  meant to do. Also, it would be easier to document what the utility
       was meant to do. Unfortunately, the  addition  of  the  POSIX  realtime
       scheduling  capabilities  introduced the concepts of process and thread
       scheduling priorities that were totally unaffected by the nice/  renice
       utilities or the nice()/ setpriority() functions. Continuing to use the
       term "system scheduling priority''  would  have  incorrectly  suggested
       that these utilities and functions were indeed affecting these realtime
       priorities. It was decided to  revert  to  the  historical  term  "nice
       value" to reference this unrelated process attribute.

       Although  this  utility  has  use by system administrators (and in fact
       appears in the system administration portion of the BSD documentation),
       the standard developers considered that it was very useful for individ-
       ual end users to control their own processes.

FUTURE DIRECTIONS
       None.

SEE ALSO
       nice()

COPYRIGHT
       Portions of this text are reprinted and reproduced in  electronic  form
       from IEEE Std 1003.1, 2003 Edition, Standard for Information Technology
       -- Portable Operating System Interface (POSIX),  The  Open  Group  Base
       Specifications  Issue  6,  Copyright  (C) 2001-2003 by the Institute of
       Electrical and Electronics Engineers, Inc and The Open  Group.  In  the
       event of any discrepancy between this version and the original IEEE and
       The Open Group Standard, the original IEEE and The Open Group  Standard
       is  the  referee document. The original Standard can be obtained online
       at http://www.opengroup.org/unix/online.html .



IEEE/The Open Group                  2003                           RENICE(1P)
