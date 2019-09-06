bcrontab(1)                                                   General Commands Manual                                                  bcrontab(1)

NAME
       bcrontab - Manage users crontab files

SYNOPSIS
       bcrontab [ -u user ] file

       bcrontab [ -u user ] { -l | -r | -e }

DESCRIPTION
       bcrontab interfaces with the bcron-spool daemon to manage crontab files in the privileged spool directory.

OPTIONS
       -u user
              Tell  bcron-spool  that we are acting on behalf of the named user.  bcron-spool will only accept the username if bcrontab is running
              as either root or the same user ID as the named user.

       -l     List the cronab crontab to standard output.

       -r     Remove the user's crontab.

       -e     Edit the current crontab.

ENVIRONMENT
       VISUAL If this is set, it is used as the editor to invoke to edit a crontab.

       EDITOR If $VISUAL is not set and this is, it is used as the editor to invoke to edit a crontab.  If neither are set, /bin/vi is used.

       BCRON_SOCKET
              The path to the named socket used to communicate with bcron-spool.  Defaults to /var/run/bcron-spool.

       LOGNAME

       USER   These two variables are used, in order, to determine the user name invoking the program.  One must be set if the -u  option  is  not
              used.

FILES
       bcrontab  tries  to  writes  a  temporary  file  into the current directory, and then into /tmp if that fails, in order to edit the current
       crontab.

SEE ALSO
       bcron-spool(8), crontab(5)

AUTHOR
       Bruce Guenter <bruce@untroubled.org>

                                                                                                                                       bcrontab(1)
CRONTAB(5)                                                      File Formats Manual                                                     CRONTAB(5)

NAME
       crontab - tables for driving bcron

DESCRIPTION
       A  crontab  file  contains  instructions  to the bcron-sched(8) daemon of the general form: ``run this command at this time on this date''.
       Each user has their own crontab, and commands in any given crontab will be executed as the user who owns the crontab.

       Blank lines and leading spaces and tabs are ignored.  Lines whose first non-space character is a  pound-sign  (#)  are  comments,  and  are
       ignored.   Note that comments are not allowed on the same line as cron commands, since they will be taken to be part of the command.  Simi‐
       larly, comments are not allowed on the same line as environment variable settings.

       An active line in a crontab will be either an environment setting or a cron command.  An environment setting is of the form,

           name = value

       where the spaces around the equal-sign (=) are optional, and any subsequent non-leading spaces in value will be part of the value  assigned
       to name.  The value string may be placed in quotes (single or double, but matching) to preserve leading or trailing blanks.

       Several  environment variables are set up automatically by the bcron-exec(8) program.  SHELL is set to /bin/sh, and LOGNAME, USER, and HOME
       are set from the /etc/passwd line of the crontab's owner.

       In addition to LOGNAME, USER, HOME, and SHELL, bcron-exec(8) will look at MAILTO if it has any reason to send mail as a result  of  running
       commands  in  ``this''  crontab.   If MAILTO is defined (and non-empty), mail is sent to the user so named.  If MAILTO is defined but empty
       (MAILTO=""), no mail will be sent.  Otherwise mail is sent to the owner of the crontab.  This option is useful if you decide  on  /bin/mail
       instead of /usr/lib/sendmail as your mailer when you install cron -- /bin/mail doesn't do aliasing, and UUCP usually doesn't read its mail.

       The format of a cron command is very much the V7 standard, with a number of upward-compatible extensions.  Each line has five time and date
       fields, followed by a user name if this is the system crontab file, followed by a command.  Commands are executed  by  bcron-sched(8)  when
       the  minute,  hour,  and month of year fields match the current time, and at least one of the two day fields (day of month, or day of week)
       match the current time (see ``Note'' below).  Jobs scheduled during non-existent times, such as "missing  hours"  during  daylight  savings
       conversion, will be scheduled at some point shortly after the non-existent time.  Jobs scheduled during repeating times, such as "duplicate
       hours" during daylight savings conversion, will be scheduled only once (unless they would repeat anyways,  such  as  jobs  that  run  every
       minute or hour).

       The time and date fields are:

              field          allowed values
              -----          --------------
              minute         0-59
              hour           0-23
              day of month   1-31
              month          1-12 (or names, see below)
              day of week    0-7 (0 or 7 is Sun, or use names)

       A field may be an asterisk (*), which always stands for ``first-last''.

       Ranges  of  numbers are allowed.  Ranges are two numbers separated with a hyphen.  The specified range is inclusive.  For example, 8-11 for
       an ``hours'' entry specifies execution at hours 8, 9, 10 and 11.

       Lists are allowed.  A list is a set of numbers (or ranges) separated by commas.  Examples: ``1,2,5,9'', ``0-4,8-12''.

       Step values can be used in conjunction with ranges.  Following a range with ``/<number>'' specifies skips of the number's value through the
       range.   For  example,  ``0-23/2''  can be used in the hours field to specify command execution every other hour (the alternative in the V7
       standard is ``0,2,4,6,8,10,12,14,16,18,20,22'').  Steps are also permitted after an asterisk, so if you want to say  ``every  two  hours'',
       just use ``*/2''.

       Names  can  also  be  used  for the ``month'' and ``day of week'' fields.  Use the first three letters of the particular day or month (case
       doesn't matter).  Ranges or lists of names are not allowed.

       The ``sixth'' field (the rest of the line) specifies the command to be run.  The entire command portion of the line  will  be  executed  by
       /bin/sh or by the shell specified in the SHELL variable of the cronfile.

       Note:  The day of a command's execution can be specified by two fields — day of month, and day of week.  If both fields are restricted (ie,
       aren't *), the command will be run when either field matches the current time.  For example,
       ``30 4 1,15 * 5'' would cause a command to be run at 4:30 am on the 1st and 15th of each month, plus every Friday.

EXAMPLE CRON FILE
       # use /bin/sh to run commands, no matter what /etc/passwd says
       SHELL=/bin/sh
       # mail any output to `bruce@example.com', no matter whose crontab this is
       MAILTO=bruce@example.com
       #
       # run five minutes after midnight, every day
       5 0 * * *       $HOME/bin/daily.job >> $HOME/tmp/out 2>&1
       # run at 2:15pm on the first of every month -- output mailed to bruce (above)
       15 14 1 * *     $HOME/bin/monthly
       23 0-23/2 * * * echo "run 23 minutes after midn, 2am, 4am ..., everyday"
       5 4 * * sun     echo "run at 5 after 4 every sunday"

FILES
       /etc/crontab        System crontab file

       /etc/cron.d/        System crontab directory

SEE ALSO
       bcron-sched(8), bcron-spool(8), bcrontab(1)

EXTENSIONS
       When specifying day of week, both day 0 and day 7 will be considered Sunday.  BSD and ATT seem to disagree about this.

       Lists and ranges are allowed to co-exist in the same field.  "1-3,7-9" would be rejected by ATT or BSD cron -- they want to  see  "1-3"  or
       "7,8,9" ONLY.

       Ranges can include "steps", so "1-9/2" is the same as "1,3,5,7,9".

       Names of months or days of the week can be specified by name.

       Environment  variables  can  be  set  in  the  crontab.  In BSD or ATT, the environment handed to child processes is basically the one from
       /etc/rc.

       Command output is mailed to the crontab owner (BSD can't do this), can be mailed to a person other than the crontab owner  (SysV  can't  do
       this), or the feature can be turned off and no mail will be sent at all (SysV can't do this either).

AUTHOR
       Paul Vixie <vixie@isc.org>
       Charles Cazabon <charlesc-cronman @ discworld.dyndns.org>
       Bruce Guenter <bruce@untroubled.org>

                                                                       bcron                                                            CRONTAB(5)
