File: *manpages*,  Node: logger,  Up: (dir)

LOGGER(1)                        User Commands                       LOGGER(1)



NAME
       logger - enter messages into the system log

SYNOPSIS
       logger [options] [message]

DESCRIPTION
       logger makes entries in the system log.

       When  the  optional  message  argument is present, it is written to the
       log.  If it is not present, and the -f option is not given either, then
       standard input is logged.

OPTIONS
       -d, --udp
              Use datagrams (UDP) only.  By default the connection is tried to
              the syslog port defined in /etc/services, which is often 514 .

       -e, --skip-empty
              Ignore empty lines when processing  files.   An  empty  line  is
              defined  to  be a line without any characters.  Thus a line con-
              sisting only of whitespace is NOT considered empty.   Note  that
              when  the --prio-prefix option is specified, the priority is not
              part of the line.  Thus an empty line in this  mode  is  a  line
              that  does  not  have  any  characters after the priority prefix
              (e.g. <13>).

       -f, --file file
              Log the contents of the specified file.  This option  cannot  be
              combined with a command-line message.

       -i     Log the PID of the logger process with each line.

       --id[=id]
              Log  the  PID  of  the  logger process with each line.  When the
              optional argument id is specified, then it is  used  instead  of
              the  logger  command's PID.  The use of --id=$$ (PPID) is recom-
              mended in scripts that send several messages.

              Note that the system logging infrastructure (for example systemd
              when  listening on /dev/log) may follow local socket credentials
              to overwrite the PID specified in  the  message.   logger(1)  is
              able  to  set those socket credentials to the given id, but only
              if you have root permissions and a process  with  the  specified
              PID  exists,  otherwise  the socket credentials are not modified
              and the problem is silently ignored.

       --journald[=file]
              Write a systemd journal entry.  The entry is read from the given
              file,  when specified, otherwise from standard input.  Each line
              must begin with a field that is accepted by journald;  see  sys-
              temd.journal-fields(7)  for  details.   The  use of a MESSAGE_ID
              field is generally a good idea,  as  it  makes  finding  entries
              easy.  Examples:

                  logger --journald <<end
                  MESSAGE_ID=67feb6ffbaf24c5cbec13c008dd72309
                  MESSAGE=The dogs bark, but the caravan goes on.
                  DOGS=bark
                  CARAVAN=goes on
                  end

                  logger --journald=entry.txt

              Notice that --journald will ignore values of other options, such
              as priority.  If priority is needed it must be within input, and
              use  PRIORITY  field.   The  simple execution of journalctl will
              display MESSAGE field.  Use journalctl --output  json-pretty  to
              see rest of the fields.

       --msgid msgid
              Sets  the RFC5424 MSGID field.  Note that the space character is
              not permitted inside of msgid.  This  option  is  only  used  if
              --rfc5424  is  specified  as  well;  otherwise,  it  is silently
              ignored.

       -n, --server server
              Write to the specified remote syslog server instead  of  to  the
              system  log  socket.  Unless --udp or --tcp is specified, logger
              will first try to use UDP, but if this fails a TCP connection is
              attempted.

       --no-act
              Causes  everything to be done except for writing the log message
              to the system log, and removing the connection or  the  journal.
              This  option can be used together with --stderr for testing pur-
              poses.

       --octet-count
              Use the RFC 6587 octet counting framing method for sending  mes-
              sages.   When this option is not used, the default is no framing
              on UDP, and RFC6587 non-transparent framing (also known as octet
              stuffing) on TCP.

       -P, --port port
              Use  the specified port.  When this option is not specified, the
              port defaults to syslog for udp and to syslog-conn for tcp  con-
              nections.

       -p, --priority priority
              Enter the message into the log with the specified priority.  The
              priority may be specified numerically  or  as  a  facility.level
              pair.   For example, -p local3.info logs the message as informa-
              tional in the local3 facility.  The default is user.notice.

       --prio-prefix
              Look for a syslog prefix on every line read from standard input.
              This  prefix  is  a  decimal  number  within angle brackets that
              encodes both the facility and the level.   The  number  is  con-
              structed  by  multiplying  the facility by 8 and then adding the
              level.   For  example,  local0.info,  meaning  facility=16   and
              level=6, becomes <134>.

              If  the  prefix  contains  no facility, the facility defaults to
              what is specified by the -p option.  Similarly, if no prefix  is
              provided, the line is logged using the priority given with -p.

              This option doesn't affect a command-line message.

       --rfc3164
              Use  the  RFC  3164  BSD syslog protocol to submit messages to a
              remote server.

       --rfc5424[=without]
              Use the RFC 5424 syslog protocol to submit messages to a  remote
              server.   The optional without argument can be a comma-separated
              list of the following values: notq, notime, nohost.

              The notq value suppresses the time-quality structured data  from
              the  submitted  message.   The  time-quality  information  shows
              whether the local clock was synchronized plus the maximum number
              of microseconds the timestamp might be off.  The time quality is
              also automatically suppressed when --sd-id timeQuality is speci-
              fied.

              The  notime  value  (which implies notq) suppresses the complete
              sender timestamp that is in ISO-8601 format, including microsec-
              onds and timezone.

              The  nohost value suppresses gethostname(2) information from the
              message header.

              The RFC 5424 protocol has been the default for logger since ver-
              sion 2.26.

       -s, --stderr
              Output  the  message  to standard error as well as to the system
              log.

       --sd-id name[@digits]
              Specifies a structured data element ID for an RFC  5424  message
              header.   The  option has to be used before --sd-param to intro-
              duce a new element.  The number of structured data  elements  is
              unlimited.   The  ID (name plus possibly @digits) is case-sensi-
              tive and uniquely identifies the type and purpose  of  the  ele-
              ment.   The  same ID must not exist more than once in a message.
              The @digits part is required for  user-defined  non-standardized
              IDs.

              logger  currently generates the timeQuality standardized element
              only.  RFC 5424 also describes the elements origin (with parame-
              ters  ip,  enterpriseId,  software and swVersion) and meta (with
              parameters sequenceId, sysUpTime and language).   These  element
              IDs may be specified without the @digits suffix.


       --sd-param name="value"
              Specifies  a structured data element parameter, a name and value
              pair.  The option has to be used after --sd-id and may be speci-
              fied  more than once for the same element.  Note that the quota-
              tion marks around value are required and must be escaped on  the
              command line.

                  logger --rfc5424 --sd-id zoo@123               \
                                   --sd-param tiger=\"hungry\"   \
                                   --sd-param zebra=\"running\"  \
                                   --sd-id manager@123           \
                                   --sd-param onMeeting=\"yes\"  \
                                   "this is message"

              produces:

                <13>1 2015-10-01T14:07:59.168662+02:00 ws kzak - - [timeQuality tzKnown="1" isSynced="1" syncAccuracy="218616"][zoo@123 tiger="hungry" zebra="running"][manager@123 onMeeting="yes"] this is message

       --size size
              Sets the maximum permitted message size to size.  The default is
              1KiB characters, which is the limit traditionally used and spec-
              ified  in RFC 3164.  With RFC 5424, this limit has become flexi-
              ble.  A good assumption is that RFC 5424 receivers can at  least
              process 4KiB messages.

              Most receivers accept messages larger than 1KiB over any type of
              syslog protocol.  As such, the --size option affects  logger  in
              all cases (not only when --rfc5424 was used).

              Note:  the  message-size  limit limits the overall message size,
              including the syslog header.  Header sizes vary depending on the
              selected  options  and the hostname length.  As a rule of thumb,
              headers are usually not longer than 50 to 80  characters.   When
              selecting a maximum message size, it is important to ensure that
              the receiver supports the max size as well,  otherwise  messages
              may become truncated.  Again, as a rule of thumb two to four KiB
              message size should generally be  OK,  whereas  anything  larger
              should be verified to work.


       --socket-errors[=mode]
              Print  errors  about Unix socket connections.  The mode can be a
              value of off, on, or auto.  When the mode is  auto  logger  will
              detect  if  the init process is systemd, and if so assumption is
              made /dev/log can be used early at  boot.   Other  init  systems
              lack  of  /dev/log  will not cause errors that is identical with
              messaging using openlog(3) system call.   The  logger(1)  before
              version 2.26 used openlog, and hence was unable to detected loss
              of messages sent to Unix sockets.

              The default mode is auto.  When errors are not enabled lost mes-
              sages  are not communicated and will result to successful return
              value of logger(1) invocation.

       -T, --tcp
              Use stream (TCP) only.  By default the connection  is  tried  to
              the  syslog-conn  port  defined in /etc/services, which is often
              601.

       -t, --tag tag
              Mark every line to  be  logged  with  the  specified  tag.   The
              default  tag  is  the name of the user logged in on the terminal
              (or a user name based on effective user ID).

       -u, --socket socket
              Write to the specified socket  instead  of  to  the  system  log
              socket.

       --     End  the argument list.  This allows the message to start with a
              hyphen (-).

       -V, --version
              Display version information and exit.

       -h, --help
              Display help text and exit.

RETURN VALUE
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

       For the priority order and intended purposes of  these  facilities  and
       levels, see syslog(3).

EXAMPLES
       logger System rebooted
       logger -p local0.notice -t HOSTIDM -f /dev/idmc
       logger -n loghost.example.com System rebooted

SEE ALSO
       journalctl(1), syslog(3), systemd.journal-fields(7)

STANDARDS
       The  logger  command is expected to be IEEE Std 1003.2 ("POSIX.2") com-
       patible.

AVAILABILITY
       The logger command is part of the util-linux package and  is  available
       from  Linux  Kernel Archive ⟨ftp://ftp.kernel.org/pub/linux/utils/util-
       linux/⟩.



util-linux                       November 2015                       LOGGER(1)
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
       The logger utility saves a message, in an unspecified manner  and  for-
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
       The  following environment variables shall affect the execution of log-
       ger:

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
       administrator  or  programmer in determining why non-interactive utili-
       ties have failed. The locations of the saved  messages,  their  format,
       and  retention  period  are  all unspecified.  There is no method for a
       conforming application to read messages, once written.

EXAMPLES
       A batch application, running non-interactively, tries to read a config-
       uration file and fails; it may attempt to notify the system administra-
       tor with:


              logger myname: unable to read file foo. [timestamp]

RATIONALE
       The standard developers believed strongly that some method of  alerting
       administrators  to errors was necessary. The obvious example is a batch
       utility, running non-interactively, that is unable to read its configu-
       ration  files  or  that  is unable to create or write its results file.
       However, the standard developers did not wish to define the  format  or
       delivery  mechanisms  as they have historically been (and will probably
       continue to be) very system-specific, as well as involving  functional-
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
