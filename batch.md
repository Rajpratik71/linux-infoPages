File: *manpages*,  Node: batch,  Up: (dir)

AT(1)                       General Commands Manual                      AT(1)



NAME
       at,  batch,  atq, atrm - queue, examine or delete jobs for later execu‐
       tion

SYNOPSIS
       at [-V] [-q queue] [-f file] [-mMlv] timespec...
       at [-V] [-q queue] [-f file] [-mMkv] [-t time]
       at -c job [job...]
       atq [-V] [-q queue]
       at [-rd] job [job...]
       atrm [-V] job [job...]
       batch
       at -b

DESCRIPTION
       at and batch read commands from standard  input  or  a  specified  file
       which are to be executed at a later time, using /bin/sh.

       at      executes commands at a specified time.

       atq     lists  the  user's  pending  jobs, unless the user is the supe‐
               ruser; in that case, everybody's jobs are listed.   The  format
               of  the  output  lines (one for each job) is: Job number, date,
               hour, queue, and username.

       atrm    deletes jobs, identified by their job number.

       batch   executes commands when system  load  levels  permit;  in  other
               words,  when  the  load  average  drops below 0.8, or the value
               specified in the invocation of atd.

       At allows fairly complex time  specifications,  extending  the  POSIX.2
       standard.   It  accepts  times of the form HH:MM to run a job at a spe‐
       cific time of day.  (If that time is already  past,  the  next  day  is
       assumed.)   You  may  also specify midnight, noon, or teatime (4pm) and
       you can have a time-of-day suffixed with AM or PM for  running  in  the
       morning or the evening.  You can also say what day the job will be run,
       by giving a date in the form month-name day with an optional  year,  or
       giving  a  date  of  the form MMDD[CC]YY, MM/DD/[CC]YY, DD.MM.[CC]YY or
       [CC]YY-MM-DD.  The specification of a date must follow  the  specifica‐
       tion  of  the  time  of  day.  You can also give times like now + count
       time-units, where the time-units can be minutes, hours, days, or  weeks
       and  you  can  tell  at to run the job today by suffixing the time with
       today and to run the job tomorrow by suffixing the time with tomorrow.

       For example, to run a job at 4pm three days from now, you would  do  at
       4pm  + 3 days, to run a job at 10:00am on July 31, you would do at 10am
       Jul 31 and to run a job at 1am tomorrow, you would do at 1am tomorrow.

       The  definition  of  the   time   specification   can   be   found   in
       /usr/share/doc/at-3.1.13/timespec.

       For  both  at  and  batch, commands are read from standard input or the
       file specified with the -f option and executed.  The working directory,
       the environment (except for the variables BASH_VERSINFO, DISPLAY, EUID,
       GROUPS, SHELLOPTS, TERM, UID, and _) and the umask  are  retained  from
       the time of invocation.

       As  at  is currently implemented as a setuid program, other environment
       variables (e.g.  LD_LIBRARY_PATH or LD_PRELOAD) are also not  exported.
       This  may  change  in the future.  As a workaround, set these variables
       explicitly in your job.

       An at - or batch - command invoked from a su(1) shell will  retain  the
       current  userid.   The  user will be mailed standard error and standard
       output from his commands, if any.  Mail will be sent using the  command
       /usr/sbin/sendmail.  If at is executed from a su(1) shell, the owner of
       the login shell will receive the mail.

       The superuser may use these commands in any  case.   For  other  users,
       permission  to  use  at  is  determined  by the files /etc/at.allow and
       /etc/at.deny.  See at.allow(5) for details.

OPTIONS
       -V      prints the version number to standard error and  exit  success‐
               fully.

       -q queue
               uses  the  specified  queue.  A queue designation consists of a
               single letter; valid queue designations range from a to z and A
               to  Z.   The  a queue is the default for at and the b queue for
               batch.  Queues with higher letters run with increased niceness.
               The  special queue "=" is reserved for jobs which are currently
               running.

               If a job is submitted to a queue designated with  an  uppercase
               letter,  the job is treated as if it were submitted to batch at
               the time of the job.  Once the time is reached, the batch  pro‐
               cessing  rules  with  respect to load average apply.  If atq is
               given a specific queue, it will only show jobs pending in  that
               queue.

       -m      Send  mail to the user when the job has completed even if there
               was no output.

       -M      Never send mail to the user.

       -f file Reads the job from file rather than standard input.

       -t time run the job at time, given in the format [[CC]YY]MMDDhhmm[.ss]

       -l      Is an alias for atq.

       -r      Is an alias for atrm.

       -d      Is an alias for atrm.

       -b      is an alias for batch.

       -v      Shows the time the job will be executed before reading the job.

               Times displayed will be in the  format  "Thu  Feb  20  14:50:00
               1997".

       -c      cats the jobs listed on the command line to standard output.

FILES
       /var/spool/at
       /var/spool/at/spool
       /proc/loadavg
       /var/run/utmp
       /etc/at.allow
       /etc/at.deny

SEE ALSO
       at.allow(5), at.deny(5), atd(8), cron(1), nice(1), sh(1), umask(2).

BUGS
       The  correct  operation of batch for Linux depends on the presence of a
       proc- type directory mounted on /proc.

       If the file /var/run/utmp is not available or corrupted, or if the user
       is  not  logged  on  at the time at is invoked, the mail is sent to the
       userid found in the environment variable LOGNAME.  If that is undefined
       or empty, the current userid is assumed.

       At  and  batch as presently implemented are not suitable when users are
       competing for resources.  If this is the case for your site, you  might
       want to consider another batch system, such as nqs.

AUTHOR
       At was mostly written by Thomas Koenig, ig25@rz.uni-karlsruhe.de.



                                  2009-11-14                             AT(1)
BATCH(1P)                  POSIX Programmer's Manual                 BATCH(1P)



PROLOG
       This  manual  page is part of the POSIX Programmer's Manual.  The Linux
       implementation of this interface may differ (consult the  corresponding
       Linux  manual page for details of Linux behavior), or the interface may
       not be implemented on Linux.

NAME
       batch - schedule commands to be executed in a batch queue

SYNOPSIS
        batch

DESCRIPTION
       The batch utility shall read commands from standard input and  schedule
       them  for execution in a batch queue. It shall be the equivalent of the
       command:


              at -q b -m now

       where queue b is a special at queue, specifically for batch jobs. Batch
       jobs shall be submitted to the batch queue with no time constraints and
       shall be run by the system using algorithms, based on unspecified  fac‐
       tors, that may vary with each invocation of batch.

       Users shall be permitted to use batch if their name appears in the file
       /usr/lib/cron/at.allow.  If  that  file  does  not  exist,   the   file
       /usr/lib/cron/at.deny  shall  be  checked to determine whether the user
       shall be denied access to  batch.   If  neither  file  exists,  only  a
       process  with  the  appropriate privileges shall be allowed to submit a
       job. If only at.deny exists and is empty, global usage shall be permit‐
       ted.  The at.allow and at.deny files shall consist of one user name per
       line.

OPTIONS
       None.

OPERANDS
       None.

STDIN
       The standard input shall be a text file consisting of commands  accept‐
       able  to the shell command language described in Shell Command Language
       .

INPUT FILES
       The text files /usr/lib/cron/at.allow and  /usr/lib/cron/at.deny  shall
       contain  zero  or  more  user  names,  one  per line, of users who are,
       respectively, authorized or denied access to the at  and  batch  utili‐
       ties.

ENVIRONMENT VARIABLES
       The  following  environment  variables  shall  affect  the execution of
       batch:

       LANG   Provide a default value for the  internationalization  variables
              that  are  unset  or  null.  (See the Base Definitions volume of
              IEEE Std 1003.1-2001, Section  8.2,  Internationalization  Vari‐
              ables  for the precedence of internationalization variables used
              to determine the values of locale categories.)

       LC_ALL If set to a non-empty string value, override the values  of  all
              the other internationalization variables.

       LC_CTYPE
              Determine  the  locale  for  the  interpretation of sequences of
              bytes of text data as characters (for  example,  single-byte  as
              opposed to multi-byte characters in arguments and input files).

       LC_MESSAGES
              Determine  the  locale  that should be used to affect the format
              and contents of diagnostic messages written  to  standard  error
              and informative messages written to standard output.

       LC_TIME
              Determine  the  format  and  contents  for date and time strings
              written by batch.

       NLSPATH
              Determine the location of message catalogs for the processing of
              LC_MESSAGES .

       SHELL  Determine the name of a command interpreter to be used to invoke
              the at-job. If the variable is unset or null, sh shall be  used.
              If  it is set to a value other than a name for sh, the implemen‐
              tation shall do one of the following: use that  shell;  use  sh;
              use the login shell from the user database; any of the preceding
              accompanied by a warning diagnostic about which was chosen.

       TZ     Determine the timezone. The job shall be submitted for execution
              at  the  time  specified  by timespec or -t time relative to the
              timezone specified by the TZ variable.  If timespec specifies  a
              timezone, it overrides TZ.  If timespec does not specify a time‐
              zone and TZ is unset or null, an  unspecified  default  timezone
              shall be used.


ASYNCHRONOUS EVENTS
       Default.

STDOUT
       When  standard  input  is a terminal, prompts of unspecified format for
       each line of the user input described in the STDIN section may be writ‐
       ten to standard output.

STDERR
       The  following  shall  be written to standard error when a job has been
       successfully submitted:


              "job %s at %s\n", at_job_id, <date>

       where date shall be equivalent in format to the output of:


              date +"%a %b %e %T %Y"

       The date and time written shall be adjusted so that they appear in  the
       timezone of the user (as determined by the TZ variable).

       Neither this, nor warning messages concerning the selection of the com‐
       mand interpreter, are considered a diagnostic  that  changes  the  exit
       status.

       Diagnostic messages, if any, shall be written to standard error.

OUTPUT FILES
       None.

EXTENDED DESCRIPTION
       None.

EXIT STATUS
       The following exit values shall be returned:

        0     Successful completion.

       >0     An error occurred.


CONSEQUENCES OF ERRORS
       The job shall not be scheduled.

       The following sections are informative.

APPLICATION USAGE
       It  may be useful to redirect standard output within the specified com‐
       mands.

EXAMPLES
        1. This sequence can be used at a terminal:


           batch
           sort < file >outfile
           EOT

        2. This sequence, which demonstrates redirecting standard error  to  a
           pipe,  is useful in a command procedure (the sequence of output re‐
           direction specifications is significant):


           batch <<
           ! diff file1 file2 2>&1 >outfile | mailx mygroup
           !

RATIONALE
       Early proposals described batch in a manner totally separated from  at,
       even  though the historical model treated it almost as a synonym for at
       -qb. A number of features were added to list  and  control  batch  work
       separately  from  those  in at. Upon further reflection, it was decided
       that the benefit of this did not merit the  change  to  the  historical
       interface.

       The  -m  option was included on the equivalent at command because it is
       historical practice to mail results to the submitter, even if all  job-
       produced  output  is  redirected. As explained in the RATIONALE for at,
       the now keyword submits the job for immediate execution (after schedul‐
       ing  delays),  despite  some historical systems where at now would have
       been considered an error.

FUTURE DIRECTIONS
       None.

SEE ALSO
       at

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



IEEE/The Open Group                  2003                            BATCH(1P)
