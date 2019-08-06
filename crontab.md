File: *manpages*,  Node: crontab,  Up: (dir)

CRONTAB(1)                       User Commands                      CRONTAB(1)



NAME
       crontab - maintains crontab files for individual users

SYNOPSIS
       crontab [-u user] file
       crontab [-u user] [-l | -r | -e] [-i] [-s]
       crontab -n [ hostname ]
       crontab -c

DESCRIPTION
       Crontab  is the program used to install, remove or list the tables used
       to serve the cron(8) daemon.  Each user can have their own crontab, and
       though  these  are  files  in  /var/spool/, they are not intended to be
       edited directly.  For SELinux in MLS mode, you can define more crontabs
       for each range.  For more information, see selinux(8).

       In  this version of Cron it is possible to use a network-mounted shared
       /var/spool/cron across a cluster of hosts and specify that only one  of
       the  hosts  should  run the crontab jobs in the particular directory at
       any one time.  You may also use crontab(1) from any of these  hosts  to
       edit  the  same shared set of crontab files, and to set and query which
       host should run the crontab jobs.

       Running cron jobs can be allowed or  disallowed  for  different  users.
       For  this  purpose,  use  the  cron.allow  and cron.deny files.  If the
       cron.allow file exists, a user must be listed in it to  be  allowed  to
       use  cron  If the cron.allow file does not exist but the cron.deny file
       does exist, then a user must not be listed in  the  cron.deny  file  in
       order  to  use  cron.  If neither of these files exists, only the super
       user is allowed to use cron.  Another way to restrict access to cron is
       to use PAM authentication in /etc/security/access.conf to set up users,
       which are allowed or disallowed to use crontab or  modify  system  cron
       jobs in the /etc/cron.d/ directory.

       The  temporary  directory can be set in an environment variable.  If it
       is not set by the user, the /tmp directory is used.

OPTIONS
       -u     Appends the name of the user whose crontab is  to  be  modified.
              If  this  option  is  not used, crontab examines "your" crontab,
              i.e., the crontab of the person  executing  the  command.   Note
              that  su(8)  may  confuse crontab, thus, when executing commands
              under su(8) you should always use the -u option.  If no  crontab
              exists  for  a  particular user, it is created for him the first
              time the crontab -u command is used under his username.

       -l     Displays the current crontab on standard output.

       -r     Removes the current crontab.

       -e     Edits the current crontab using the editor specified by the VIS-
              UAL  or  EDITOR  environment variables.  After you exit from the
              editor, the modified crontab will be installed automatically.

       -i     This option modifies the -r option to  prompt  the  user  for  a
              'y/Y' response before actually removing the crontab.

       -s     Appends  the  current  SELinux  security  context  string  as an
              MLS_LEVEL setting to the crontab file before editing /  replace-
              ment occurs - see the documentation of MLS_LEVEL in crontab(5).

       -n     This  option is relevant only if cron(8) was started with the -c
              option, to enable clustering support.  It is  used  to  set  the
              host  in  the cluster which should run the jobs specified in the
              crontab files in the /var/spool/cron directory.  If  a  hostname
              is  supplied, the host whose hostname returned by gethostname(2)
              matches the supplied hostname,  will  be  selected  to  run  the
              selected  cron  jobs  subsequently.   If there is no host in the
              cluster matching the supplied hostname, or you explicitly  spec-
              ify an empty hostname, then the selected jobs will not be run at
              all.  If the hostname is omitted, the name  of  the  local  host
              returned  by  gethostname(2)  is used.  Using this option has no
              effect on the /etc/crontab file and the files in the /etc/cron.d
              directory,  which  are always run, and considered host-specific.
              For more information on clustering support, see cron(8).

       -c     This option is only relevant if cron(8) was started with the  -c
              option, to enable clustering support.  It is used to query which
              host in the cluster is currently set to run the  jobs  specified
              in  the  crontab files in the directory /var/spool/cron , as set
              using the -n option.

SEE ALSO
       crontab(5), cron(8)

FILES
       /etc/cron.allow
       /etc/cron.deny

STANDARDS
       The crontab command conforms to IEEE Std1003.2-1992 (``POSIX'').   This
       new  command  syntax  differs  from previous versions of Vixie Cron, as
       well as from the classic SVR3 syntax.

DIAGNOSTICS
       An informative usage message appears if you run a crontab with a faulty
       command defined in it.

AUTHOR
       Paul Vixie ⟨vixie@isc.org⟩
       Colin Dean ⟨colin@colin-dean.org⟩



cronie                            2012-11-22                        CRONTAB(1)
CRONTAB(5)                       File Formats                       CRONTAB(5)



NAME
       crontab - files used to schedule the execution of programs

DESCRIPTION
       A crontab file contains instructions for the cron(8) daemon in the fol-
       lowing simplified manner: "run this command at this time on this date".
       Each  user can define their own crontab.  Commands defined in any given
       crontab are executed under the user who owns that  particular  crontab.
       Uucp and News usually have their own crontabs, eliminating the need for
       explicitly running su(1) as part of a cron command.

       Blank lines, leading spaces, and tabs are ignored.  Lines  whose  first
       non-white space character is a pound-sign (#) are comments, and are not
       processed.  Note that comments are not allowed on the same line as cron
       commands,  since they are considered a part of the command.  Similarly,
       comments are not allowed on the same line as environment variable  set-
       tings.

       An  active line in a crontab is either an environment setting or a cron
       command.  An environment setting is of the form:

          name = value

       where the white spaces around the equal-sign (=) are optional, and  any
       subsequent  non-leading  white  spaces  in value is a part of the value
       assigned to name.  The value string may be placed in quotes (single  or
       double, but matching) to preserve leading or trailing white spaces.

       Several  environment  variables are set up automatically by the cron(8)
       daemon.  SHELL is set to /bin/sh, and LOGNAME and HOME are set from the
       /etc/passwd  line  of the crontab´s owner.  HOME and SHELL can be over-
       ridden by settings in the crontab; LOGNAME can not.

       (Note: the LOGNAME variable is sometimes called USER on BSD systems and
       is also automatically set).

       In  addition  to  LOGNAME, HOME, and SHELL, cron(8) looks at the MAILTO
       variable if a mail needs to be send as a result of running any commands
       in that particular crontab.  If MAILTO is defined (and non-empty), mail
       is sent to the specified address.   If  MAILTO  is  defined  but  empty
       (MAILTO=""),  no mail is sent.  Otherwise, mail is sent to the owner of
       the crontab.  This option is useful if  you  decide  to  use  /bin/mail
       instead  of /usr/lib/sendmail as your mailer.  Note that /bin/mail does
       not provide aliasing and UUCP usually does not read its mail.  If MAIL-
       FROM  is  defined  (and  non-empty),  it is used as the envelope sender
       address, otherwise, ``root'' is used.

       By default, cron sends a mail using the 'Content-Type:'  header  of  of
       the  locale  in  which crond(8) is started up, i.e., either the default
       system locale, if no LC_* environment variables are set, or the  locale
       specified by the LC_* environment variables (see locale(7)).  Different
       character encodings can be used for mailing cron job outputs by setting
       the  CONTENT_TYPE  and CONTENT_TRANSFER_ENCODING variables in a crontab
       to the correct values of the mail headers of those names.

       The CRON_TZ variable specifies the time zone specific for the cron  ta-
       ble.  The user should enter a time according to the specified time zone
       into the table.  The time used for writing into a  log  file  is  taken
       from the local time zone, where the daemon is running.

       The  MLS_LEVEL  environment variable provides support for multiple per-
       job SELinux security contexts in the same crontab.   By  default,  cron
       jobs execute with the default SELinux security context of the user that
       created the crontab file.  When  using  multiple  security  levels  and
       roles, this may not be sufficient, because the same user may be running
       in different roles or in different security levels.  For more  informa-
       tion  about  roles  and SELinux MLS/MCS, see selinux(8) and the crontab
       example mentioned later on in this text.  You  can  set  the  MLS_LEVEL
       variable to the SELinux security context string specifying the particu-
       lar SELinux security context in which you want jobs to be  run.   crond
       will  then set the execution context of those jobs that meet the speci-
       fications of the particular security context.   For  more  information,
       see crontab(1) -s option.

       The RANDOM_DELAY variable allows delaying job startups by random amount
       of minutes with upper limit specified by the variable. The random scal-
       ing  factor  is determined during the cron daemon startup so it remains
       constant for the whole run time of the daemon.

       The format of a cron command is similar to the V7 standard, with a num-
       ber  of upward-compatible extensions.  Each line has five time-and-date
       fields followed by a username (if this is the system crontab file), and
       followed  by  a  command.   Commands  are  executed by cron(8) when the
       'minute', 'hour', and 'month of the  year'  fields  match  the  current
       time, and at least one of the two 'day' fields ('day of month', or 'day
       of week') match the current time (see "Note" below).

       Note that this means that non-existent  times,  such  as  the  "missing
       hours"  during  the daylight savings time conversion, will never match,
       causing jobs scheduled during the "missing times" not to be run.  Simi-
       larly, times that occur more than once (again, during the daylight sav-
       ings time conversion) will cause matching jobs to be run twice.

       cron(8) examines cron entries every minute.

       The time and date fields are:

              field          allowed values
              -----          --------------
              minute         0-59
              hour           0-23
              day of month   1-31
              month          1-12 (or names, see below)
              day of week    0-7 (0 or 7 is Sunday, or use names)

       A  field  may  contain  an  asterisk  (*),  which  always  stands   for
       "first-last".

       Ranges of numbers are allowed.  Ranges are two numbers separated with a
       hyphen.  The specified range is inclusive.  For example, 8-11 for an

       Lists are allowed.  A list is a set of numbers (or ranges) separated by
       commas.  Examples: "1,2,5,9", "0-4,8-12".

       Step  values can be used in conjunction with ranges.  Following a range
       with "/<number>" specifies skips of  the  number's  value  through  the
       range.  For example, "0-23/2" can be used in the 'hours' field to spec-
       ify command execution for every other hour (the alternative in  the  V7
       standard  is  "0,2,4,6,8,10,12,14,16,18,20,22").   Step values are also
       permitted after an asterisk, so if specifying a job to be run every two
       hours, you can use "*/2".

       Names  can  also be used for the 'month' and 'day of week' fields.  Use
       the first three letters of the particular day or month (case  does  not
       matter).  Ranges or lists of names are not allowed.

       If  the uid of the owner is 0 (root), he can put a "-" as first charac-
       ter of a crontab entry.  This will prevent cron from writing  a  syslog
       message about this command getting executed.

       The  "sixth"  field  (the rest of the line) specifies the command to be
       run.  The entire command portion of the line, up to a newline or a  "%"
       character, will be executed by /bin/sh or by the shell specified in the
       SHELL variable of the cronfile.  A "%" character in the command, unless
       escaped  with a backslash (\), will be changed into newline characters,
       and all data after the first % will be sent to the command as  standard
       input.

       Note:  The day of a command's execution can be specified in the follow-
       ing two fields — 'day of month', and 'day of week'.  If both fields are
       restricted  (i.e.,  do not contain the "*" character), the command will
       be run when either field matches the current time.  For example,
       "30 4 1,15 * 5" would cause a command to be run at 4:30 am on  the  1st
       and 15th of each month, plus every Friday.

EXAMPLE CRON FILE
       # use /bin/sh to run commands, no matter what /etc/passwd says
       SHELL=/bin/sh
       # mail any output to `paul', no matter whose crontab this is
       MAILTO=paul
       #
       CRON_TZ=Japan
       # run five minutes after midnight, every day
       5 0 * * *       $HOME/bin/daily.job >> $HOME/tmp/out 2>&1
       # run at 2:15pm on the first of every month -- output mailed to paul
       15 14 1 * *     $HOME/bin/monthly
       # run at 10 pm on weekdays, annoy Joe
       0 22 * * 1-5    mail -s "It's 10pm" joe%Joe,%%Where are your kids?%
       23 0-23/2 * * * echo "run 23 minutes after midn, 2am, 4am ..., everyday"
       5 4 * * sun     echo "run at 5 after 4 every sunday"

Jobs in /etc/cron.d/
       The  jobs  in  cron.d  and /etc/crontab are system jobs, which are used
       usually for more than one  user,  thus,  additionaly  the  username  is
       needed.  MAILTO on the first line is optional.

EXAMPLE OF A JOB IN /etc/cron.d/job
       #login as root
       #create job with preferred editor (e.g. vim)
       MAILTO=root
       * * * * * root touch /tmp/file

SELinux with multi level security (MLS)
       In a crontab, it is important to specify a security level by crontab -s
       or specifying the required level on the  first  line  of  the  crontab.
       Each  level  is specified in /etc/selinux/targeted/seusers.  When using
       crontab in the MLS mode, it is especially important to:
       - check/change the actual role,
       - set correct role for directory, which is used for input/output.

EXAMPLE FOR SELINUX MLS
       # login as root
       newrole -r sysadm_r
       mkdir /tmp/SystemHigh
       chcon -l SystemHigh /tmp/SystemHigh
       crontab -e
       # write in crontab file
       MLS_LEVEL=SystemHigh
       0-59 * * * * id -Z > /tmp/SystemHigh/crontest

FILES
       /etc/crontab main system crontab file.   /var/spool/cron/  a  directory
       for  storing  crontabs  defined by users.  /etc/cron.d/ a directory for
       storing system crontabs.

SEE ALSO
       cron(8), crontab(1)

EXTENSIONS
       These special time specification "nicknames" which replace the  5  ini-
       tial time and date fields, and are prefixed with the '@' character, are
       supported:

       @reboot    :    Run once after reboot.
       @yearly    :    Run once a year, ie.  "0 0 1 1 *".
       @annually  :    Run once a year, ie.  "0 0 1 1 *".
       @monthly   :    Run once a month, ie. "0 0 1 * *".
       @weekly    :    Run once a week, ie.  "0 0 * * 0".
       @daily     :    Run once a day, ie.   "0 0 * * *".
       @hourly    :    Run once an hour, ie. "0 * * * *".

CAVEATS
       crontab files have to be regular files or symlinks  to  regular  files,
       they  must not be executable or writable for anyone else but the owner.
       This requirement can be overridden by using the -p option on the  crond
       command  line.   If inotify support is in use, changes in the symlinked
       crontabs are not automatically noticed by the cron  daemon.   The  cron
       daemon  must receive a SIGHUP signal to reload the crontabs.  This is a
       limitation of the inotify API.

AUTHOR
       Paul Vixie ⟨vixie@isc.org⟩



cronie                            2012-11-22                        CRONTAB(5)
CRONTAB(1P)                POSIX Programmer's Manual               CRONTAB(1P)



PROLOG
       This  manual  page is part of the POSIX Programmer's Manual.  The Linux
       implementation of this interface may differ (consult the  corresponding
       Linux  manual page for details of Linux behavior), or the interface may
       not be implemented on Linux.

NAME
       crontab - schedule periodic background work

SYNOPSIS
       crontab [file]

       crontab [ -e | -l | -r ]


DESCRIPTION
       The crontab utility shall create, replace, or  edit  a  user's  crontab
       entry;  a  crontab  entry  is a list of commands and the times at which
       they shall be executed. The new crontab entry can be input by  specify-
       ing  file or input from standard input if no file operand is specified,
       or by using an editor, if -e is specified.

       Upon execution of a command from a crontab  entry,  the  implementation
       shall  supply  a  default  environment, defining at least the following
       environment variables:

       HOME   A pathname of the user's home directory.

       LOGNAME
              The user's login name.

       PATH   A string representing a search path guaranteed to  find  all  of
              the standard utilities.

       SHELL  A  pathname  of the command interpreter. When crontab is invoked
              as specified by this volume of IEEE Std 1003.1-2001,  the  value
              shall be a pathname for sh.


       The  values  of these variables when crontab is invoked as specified by
       this volume of IEEE Std 1003.1-2001 shall not affect the default values
       provided when the scheduled command is run.

       If  standard  output  and standard error are not redirected by commands
       executed from the crontab entry, any generated output or  errors  shall
       be mailed, via an implementation-defined method, to the user.

       Users  shall  be  permitted to use crontab if their names appear in the
       file /usr/lib/cron/cron.allow. If that file does not  exist,  the  file
       /usr/lib/cron/cron.deny  shall be checked to determine whether the user
       shall be denied access to crontab.  If  neither  file  exists,  only  a
       process  with  appropriate privileges shall be allowed to submit a job.
       If only cron.deny exists and is empty, global usage shall be permitted.
       The  cron.allow  and cron.deny files shall consist of one user name per
       line.

OPTIONS
       The crontab utility shall conform to the  Base  Definitions  volume  of
       IEEE Std 1003.1-2001, Section 12.2, Utility Syntax Guidelines.

       The following options shall be supported:

       -e     Edit  a  copy of the invoking user's crontab entry, or create an
              empty entry to edit if the crontab entry does  not  exist.  When
              editing  is complete, the entry shall be installed as the user's
              crontab entry.

       -l     (The letter ell.) List the invoking user's crontab entry.

       -r     Remove the invoking user's crontab entry.


OPERANDS
       The following operand shall be supported:

       file   The pathname of a file that contains specifications, in the for-
              mat defined in the INPUT FILES section, for crontab entries.


STDIN
       See the INPUT FILES section.

INPUT FILES
       In  the  POSIX  locale,  the  user  or  application shall ensure that a
       crontab entry is a text file consisting of lines of  six  fields  each.
       The  fields shall be separated by <blank>s. The first five fields shall
       be integer patterns that specify the following:

        1. Minute [0,59]

        2. Hour [0,23]

        3. Day of the month [1,31]

        4. Month of the year [1,12]

        5. Day of the week ([0,6] with 0=Sunday)

       Each of these patterns can be either an  asterisk  (meaning  all  valid
       values), an element, or a list of elements separated by commas. An ele-
       ment shall be either a number or two  numbers  separated  by  a  hyphen
       (meaning  an inclusive range). The specification of days can be made by
       two fields (day of the month and day of the week).  If  month,  day  of
       month,  and  day of week are all asterisks, every day shall be matched.
       If either the month or day of month is specified as an element or list,
       but  the  day of week is an asterisk, the month and day of month fields
       shall specify the days that match. If both month and day of  month  are
       specified  as  an asterisk, but day of week is an element or list, then
       only the specified days of the week match. Finally, if either the month
       or day of month is specified as an element or list, and the day of week
       is also specified as an element or list, then any day  matching  either
       the month and day of month, or the day of week, shall be matched.

       The  sixth field of a line in a crontab entry is a string that shall be
       executed by sh at the specified times. A percent sign character in this
       field  shall  be translated to a <newline>. Any character preceded by a
       backslash (including the '%' ) shall cause that character to be treated
       literally. Only the first line (up to a '%' or end-of-line) of the com-
       mand field shall be executed by  the  command  interpreter.  The  other
       lines shall be made available to the command as standard input.

       Blank lines and those whose first non- <blank> is '#' shall be ignored.

       The  text  files  /usr/lib/cron/cron.allow  and /usr/lib/cron/cron.deny
       shall contain zero or more user names, one per line, of users who  are,
       respectively, authorized or denied access to the service underlying the
       crontab utility.

ENVIRONMENT VARIABLES
       The following environment  variables  shall  affect  the  execution  of
       crontab:

       EDITOR Determine  the editor to be invoked when the -e option is speci-
              fied.  The default editor shall be vi.

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
              opposed to multi-byte characters in arguments and input files).

       LC_MESSAGES
              Determine  the  locale  that should be used to affect the format
              and contents of diagnostic messages written to standard error.

       NLSPATH
              Determine the location of message catalogs for the processing of
              LC_MESSAGES .


ASYNCHRONOUS EVENTS
       Default.

STDOUT
       If  the  -l  option is specified, the crontab entry shall be written to
       the standard output.

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
       The user's crontab entry is not submitted, removed, edited, or listed.

       The following sections are informative.

APPLICATION USAGE
       The format of the crontab entry shown here is guaranteed only  for  the
       POSIX  locale.  Other cultures may be supported with substantially dif-
       ferent interfaces, although implementations are encouraged  to  provide
       comparable levels of functionality.

       The  default settings of the HOME,  LOGNAME,  PATH, and SHELL variables
       that are given to the scheduled job are not affected by the settings of
       those  variables when crontab is run; as stated, they are defaults. The
       text   about   "invoked   as    specified    by    this    volume    of
       IEEE Std 1003.1-2001"  means that the implementation may provide exten-
       sions that allow these variables to be affected at  runtime,  but  that
       the  user has to take explicit action in order to access the extension,
       such as give a new option flag or modify  the  format  of  the  crontab
       entry.

       A typical user error is to type only crontab; this causes the system to
       wait for the new crontab entry on standard input.   If  end-of-file  is
       typed  (generally  <control>-D),  the  crontab  entry is replaced by an
       empty file. In this case, the user should type the interrupt character,
       which prevents the crontab entry from being replaced.

EXAMPLES
        1. Clean up core files every weekday morning at 3:15 am:


           15 3 * * 1-5 find $HOME -name core 2>/dev/null | xargs rm -f

        2. Mail a birthday greeting:


           0 12 14 2 * mailx john%Happy Birthday!%Time for lunch.

        3. As an example of specifying the two types of days:


           0 0 1,15 * 1

       would  run  a command on the first and fifteenth of each month, as well
       as on every Monday. To specify days by only one field, the other  field
       should be set to '*' ; for example:


              0 0 * * 1

       would run a command only on Mondays.

RATIONALE
       All  references  to  a cron daemon and to cron files have been omitted.
       Although historical implementations have used this  arrangement,  there
       is no reason to limit future implementations.

       This description of crontab is designed to support only users with nor-
       mal privileges. The format of the  input  is  based  on  the  System  V
       crontab;  however,  there is no requirement here that the actual system
       database used by the cron daemon (or a similar mechanism) use this for-
       mat  internally.  For  example,  systems derived from BSD are likely to
       have an additional field appended that indicates the user  identity  to
       be used when the job is submitted.

       The -e option was adopted from the SVID as a user convenience, although
       it does not exist in all historical implementations.

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



IEEE/The Open Group                  2003                          CRONTAB(1P)
