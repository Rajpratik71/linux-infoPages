File: *manpages*,  Node: logger,  Up: (dir)

LOGGER(1)                        User Commands                       LOGGER(1)



NAME
       logger - a shell command interface to the syslog(3) system log module

SYNOPSIS
       logger [options] [message]

DESCRIPTION
       logger  makes  entries  in the system log.  It provides a shell command
       interface to the syslog(3) system log module.

OPTIONS
       -n, --server server
              Write to the specified remote syslog server instead  of  to  the
              builtin syslog routines.  Unless --udp or --tcp is specified the
              logger will first try to use UDP, but if it fails a TCP  connec‐
              tion is attempted.

       -d, --udp
              Use  datagram (UDP) only.  By default the connection is tried to
              syslog port defined in /etc/services, which is often 514.

       -T, --tcp
              Use stream (TCP) only.  By default the connection  is  tried  to
              syslog-conn port defined in /etc/services, which is often 601.

       -P, --port port
              Use  the specified port.  When this option is not specified, the
              port defaults to syslog for udp and to syslog-conn for tcp  con‐
              nections.

       -i, --id
              Log the process ID of the logger process with each line.

       -f, --file file
              Log  the  contents of the specified file.  This option cannot be
              combined with a command-line message.

       -h, --help
              Display a help text and exit.

       -p, --priority priority
              Enter the message into the log with the specified priority.  The
              priority  may  be  specified  numerically or as a facility.level
              pair.  For example, -p local3.info logs the message as  informa‐
              tional in the local3 facility.  The default is user.notice.

       -S, --size size
              Sets  the  maximum  permitted message size. The default is 1KiB,
              which is the limit traditionally used and specified in RFC 3164.
              When selecting a maximum message size, it is important to ensure
              that the receiver supports the max size as well, otherwise  mes‐
              sages may become truncated.

       -s, --stderr
              Output  the  message  to standard error as well as to the system
              log.

       -t, --tag tag
              Mark every line to  be  logged  with  the  specified  tag.   The
              default  tag  is  the name of the user logged in on the terminal
              (or a user name based on effective user ID).

       -u, --socket socket
              Write to the specified socket instead of to the  builtin  syslog
              routines.

       -V, --version
              Display version information and exit.

       --     End  the  argument  list.  This is to allow the message to start
              with a hyphen (-).

       message
              Write the message to log; if not specified, and the -f  flag  is
              not provided, standard input is logged.

       The logger utility exits 0 on success, and >0 if an error occurs.

FACILITIES AND LEVELS
       Valid facility names are:

              auth
              authpriv   for security information of a sensitive nature
              cron
              daemon
              ftp
              kern       cannot be generated from userspace process, automatically converted to user
              lpr
              mail
              news
              syslog
              user
              uucp
              local0
                to
              local7
              security   deprecated synonym for auth

       Valid level names are:

              emerg
              alert
              crit
              err
              warning
              notice
              info
              debug
              panic     deprecated synonym for emerg
              error     deprecated synonym for err
              warn      deprecated synonym for warning

       For  the  priority  order and intended purposes of these facilities and
       levels, see syslog(3).

EXAMPLES
       logger System rebooted
       logger -p local0.notice -t HOSTIDM -f /dev/idmc
       logger -n loghost.example.com System rebooted

SEE ALSO
       syslog(3), syslogd(8)

STANDARDS
       The logger command is expected to be IEEE Std 1003.2  ("POSIX.2")  com‐
       patible.

AVAILABILITY
       The  logger  command is part of the util-linux package and is available
       from Linux Kernel  Archive  ⟨ftp://ftp.kernel.org/pub/linux/utils/util-
       linux/⟩.



util-linux                        April 2013                         LOGGER(1)
LOGGER(1P)                 POSIX Programmer's Manual                LOGGER(1P)



PROLOG
       This  manual  page is part of the POSIX Programmer's Manual.  The Linux
       implementation of this interface may differ (consult the  corresponding
       Linux  manual page for details of Linux behavior), or the interface may
       not be implemented on Linux.

NAME
       logger - log messages

SYNOPSIS
       logger string ...

DESCRIPTION
       The logger utility saves a message, in an unspecified manner  and  for‐
       mat,  containing the string operands provided by the user. The messages
       are expected to be  evaluated  later  by  personnel  performing  system
       administration tasks.

       It  is implementation-defined whether messages written in locales other
       than the POSIX locale are effective.

OPTIONS
       None.

OPERANDS
       The following operand shall be supported:

       string One of the string  arguments  whose  contents  are  concatenated
              together, in the order specified, separated by single <space>s.


STDIN
       Not used.

INPUT FILES
       None.

ENVIRONMENT VARIABLES
       The  following environment variables shall affect the execution of log‐
       ger:

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
              opposed to multi-byte characters in arguments).

       LC_MESSAGES
              Determine  the  locale  that should be used to affect the format
              and contents of diagnostic messages written to  standard  error.
              (This  means diagnostics from logger to the user or application,
              not diagnostic messages that the user is sending to  the  system
              administrator.)

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
       Unspecified.

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
       This utility allows logging of information for later use  by  a  system
       administrator  or  programmer in determining why non-interactive utili‐
       ties have failed. The locations of the saved  messages,  their  format,
       and  retention  period  are  all unspecified.  There is no method for a
       conforming application to read messages, once written.

EXAMPLES
       A batch application, running non-interactively, tries to read a config‐
       uration file and fails; it may attempt to notify the system administra‐
       tor with:


              logger myname: unable to read file foo. [timestamp]

RATIONALE
       The standard developers believed strongly that some method of  alerting
       administrators  to errors was necessary. The obvious example is a batch
       utility, running non-interactively, that is unable to read its configu‐
       ration  files  or  that  is unable to create or write its results file.
       However, the standard developers did not wish to define the  format  or
       delivery  mechanisms  as they have historically been (and will probably
       continue to be) very system-specific, as well as involving  functional‐
       ity clearly outside the scope of this volume of IEEE Std 1003.1-2001.

       The  text  with LC_MESSAGES about diagnostic messages means diagnostics
       from logger to the user or application, not  diagnostic  messages  that
       the user is sending to the system administrator.

       Multiple  string  arguments  are allowed, similar to echo, for ease-of-
       use.

       Like the utilities mailx and lp,  logger  is  admittedly  difficult  to
       test.  This  was  not  deemed sufficient justification to exclude these
       utilities from this volume of IEEE Std 1003.1-2001. It is also arguable
       that they are, in fact, testable, but that the tests themselves are not
       portable.

FUTURE DIRECTIONS
       None.

SEE ALSO
       lp, mailx, write()

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



IEEE/The Open Group                  2003                           LOGGER(1P)
