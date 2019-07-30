LOGGER(1)                                                          User Commands                                                         LOGGER(1)

NAME
       logger - enter messages into the system log

SYNOPSIS
       logger [options] [message]

DESCRIPTION
       logger makes entries in the system log.

       When the optional message argument is present, it is written to the log.  If it is not present, and the -f option is not given either, then
       standard input is logged.

OPTIONS
       -d, --udp
              Use datagrams (UDP) only.  By default the connection is tried to the syslog port defined in /etc/services, which is often 514 .

       -e, --skip-empty
              Ignore empty lines when processing files.  An empty line is defined to be a line without any characters.   Thus  a  line  consisting
              only  of  whitespace is NOT considered empty.  Note that when the --prio-prefix option is specified, the priority is not part of the
              line.  Thus an empty line in this mode is a line that does not have any characters after the priority prefix (e.g. <13>).

       -f, --file file
              Log the contents of the specified file.  This option cannot be combined with a command-line message.

       -i     Log the PID of the logger process with each line.

       --id[=id]
              Log the PID of the logger process with each line.  When the optional argument id is specified, then it is used instead of the logger
              command's PID.  The use of --id=$$ (PPID) is recommended in scripts that send several messages.

              Note  that the system logging infrastructure (for example systemd when listening on /dev/log) may follow local socket credentials to
              overwrite the PID specified in the message.  logger(1) is able to set those socket credentials to the given id, but only if you have
              root  permissions  and a process with the specified PID exists, otherwise the socket credentials are not modified and the problem is
              silently ignored.

       --journald[=file]
              Write a systemd journal entry.  The entry is read from the given file, when specified, otherwise from  standard  input.   Each  line
              must  begin  with a field that is accepted by journald; see systemd.journal-fields(7) for details.  The use of a MESSAGE_ID field is
              generally a good idea, as it makes finding entries easy.  Examples:

                  logger --journald <<end
                  MESSAGE_ID=67feb6ffbaf24c5cbec13c008dd72309
                  MESSAGE=The dogs bark, but the caravan goes on.
                  DOGS=bark
                  CARAVAN=goes on
                  end

                  logger --journald=entry.txt

              Notice that --journald will ignore values of other options, such as priority.  If priority is needed it must be  within  input,  and
              use PRIORITY field.  The simple execution of journalctl will display MESSAGE field.  Use journalctl --output json-pretty to see rest
              of the fields.

       --msgid msgid
              Sets the RFC5424 MSGID field.  Note that the space character is not permitted  inside  of  msgid.   This  option  is  only  used  if
              --rfc5424 is specified as well; otherwise, it is silently ignored.

       -n, --server server
              Write  to  the  specified remote syslog server instead of to the system log socket.  Unless --udp or --tcp is specified, logger will
              first try to use UDP, but if this fails a TCP connection is attempted.

       --no-act
              Causes everything to be done except for writing the log message to the system log, and removing the connection or the journal.  This
              option can be used together with --stderr for testing purposes.

       --octet-count
              Use  the  RFC  6587  octet counting framing method for sending messages.  When this option is not used, the default is no framing on
              UDP, and RFC6587 non-transparent framing (also known as octet stuffing) on TCP.

       -P, --port port
              Use the specified port.  When this option is not specified, the port defaults to syslog for udp and to syslog-conn for  tcp  connec‐
              tions.

       -p, --priority priority
              Enter  the message into the log with the specified priority.  The priority may be specified numerically or as a facility.level pair.
              For example, -p local3.info logs the message as informational in the local3 facility.  The default is user.notice.

       --prio-prefix
              Look for a syslog prefix on every line read from standard input.  This prefix is a decimal number within angle brackets that encodes
              both  the  facility and the level.  The number is constructed by multiplying the facility by 8 and then adding the level.  For exam‐
              ple, local0.info, meaning facility=16 and level=6, becomes <134>.

              If the prefix contains no facility, the facility defaults to what is specified by the -p option.  Similarly, if no  prefix  is  pro‐
              vided, the line is logged using the priority given with -p.

              This option doesn't affect a command-line message.

       --rfc3164
              Use the RFC 3164 BSD syslog protocol to submit messages to a remote server.

       --rfc5424[=without]
              Use the RFC 5424 syslog protocol to submit messages to a remote server.  The optional without argument can be a comma-separated list
              of the following values: notq, notime, nohost.

              The notq value suppresses the time-quality structured data from the submitted message.  The time-quality information  shows  whether
              the local clock was synchronized plus the maximum number of microseconds the timestamp might be off.  The time quality is also auto‐
              matically suppressed when --sd-id timeQuality is specified.

              The notime value (which implies notq) suppresses the complete sender timestamp that is in ISO-8601  format,  including  microseconds
              and timezone.

              The nohost value suppresses gethostname(2) information from the message header.

              The RFC 5424 protocol has been the default for logger since version 2.26.

       -s, --stderr
              Output the message to standard error as well as to the system log.

       --sd-id name[@digits]
              Specifies  a  structured data element ID for an RFC 5424 message header.  The option has to be used before --sd-param to introduce a
              new element.  The number of structured data elements is unlimited.  The ID  (name  plus  possibly  @digits)  is  case-sensitive  and
              uniquely  identifies the type and purpose of the element.  The same ID must not exist more than once in a message.  The @digits part
              is required for user-defined non-standardized IDs.

              logger currently generates the timeQuality standardized element only.  RFC 5424 also describes the elements origin (with  parameters
              ip,  enterpriseId,  software and swVersion) and meta (with parameters sequenceId, sysUpTime and language).  These element IDs may be
              specified without the @digits suffix.

       --sd-param name="value"
              Specifies a structured data element parameter, a name and value pair.  The option has to be used after --sd-id and may be  specified
              more  than  once  for  the same element.  Note that the quotation marks around value are required and must be escaped on the command
              line.

                  logger --rfc5424 --sd-id zoo@123               \
                                   --sd-param tiger=\"hungry\"   \
                                   --sd-param zebra=\"running\"  \
                                   --sd-id manager@123           \
                                   --sd-param onMeeting=\"yes\"  \
                                   "this is message"

              produces:

                <13>1 2015-10-01T14:07:59.168662+02:00 ws kzak - - [timeQuality tzKnown="1" isSynced="1" syncAccuracy="218616"][zoo@123 tiger="hungry" zebra="running"][manager@123 onMeeting="yes"] this is message

       --size size
              Sets the maximum permitted message size to size.  The default is 1KiB characters, which is the limit traditionally used  and  speci‐
              fied in RFC 3164.  With RFC 5424, this limit has become flexible.  A good assumption is that RFC 5424 receivers can at least process
              4KiB messages.

              Most receivers accept messages larger than 1KiB over any type of syslog protocol.  As such, the --size option affects logger in  all
              cases (not only when --rfc5424 was used).

              Note:  the  message-size  limit  limits  the  overall message size, including the syslog header.  Header sizes vary depending on the
              selected options and the hostname length.  As a rule of thumb, headers are usually not  longer  than  50  to  80  characters.   When
              selecting  a maximum message size, it is important to ensure that the receiver supports the max size as well, otherwise messages may
              become truncated.  Again, as a rule of thumb two to four KiB message size should generally be OK, whereas anything larger should  be
              verified to work.

       --socket-errors[=mode]
              Print  errors about Unix socket connections.  The mode can be a value of off, on, or auto.  When the mode is auto logger will detect
              if the init process is systemd, and if so assumption is made /dev/log can be used  early  at  boot.   Other  init  systems  lack  of
              /dev/log  will  not  cause  errors that is identical with messaging using openlog(3) system call.  The logger(1) before version 2.26
              used openlog, and hence was unable to detected loss of messages sent to Unix sockets.

              The default mode is auto.  When errors are not enabled lost messages are not communicated and will result to successful return value
              of logger(1) invocation.

       -T, --tcp
              Use stream (TCP) only.  By default the connection is tried to the syslog-conn port defined in /etc/services, which is often 601.

       -t, --tag tag
              Mark  every  line to be logged with the specified tag.  The default tag is the name of the user logged in on the terminal (or a user
              name based on effective user ID).

       -u, --socket socket
              Write to the specified socket instead of to the system log socket.

       --     End the argument list.  This allows the message to start with a hyphen (-).

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

       For the priority order and intended purposes of these facilities and levels, see syslog(3).

EXAMPLES
       logger System rebooted
       logger -p local0.notice -t HOSTIDM -f /dev/idmc
       logger -n loghost.example.com System rebooted

SEE ALSO
       journalctl(1), syslog(3), systemd.journal-fields(7)

STANDARDS
       The logger command is expected to be IEEE Std 1003.2 ("POSIX.2") compatible.

AVAILABILITY
       The logger command is part of the util-linux package and is available from  Linux  Kernel  Archive  ⟨https://www.kernel.org/pub/linux/utils
       /util-linux/⟩.

util-linux                                                         November 2015                                                         LOGGER(1)
logger(3tcl)                                             Object Oriented logging facility                                             logger(3tcl)

__________________________________________________________________________________________________________________________________________________

NAME
       logger - System to control logging of events.

SYNOPSIS
       package require Tcl  8.2

       package require logger  ?0.9.4?

       logger::init service

       logger::import ?-all? ?-force? ?-prefix prefix? ?-namespace namespace? service

       logger::initNamespace ns ?level?

       logger::services

       logger::enable level

       logger::disable level

       logger::setlevel level

       logger::levels

       logger::servicecmd service

       ${log}::debug message

       ${log}::info message

       ${log}::notice message

       ${log}::warn message

       ${log}::error message

       ${log}::critical message

       ${log}::alert message

       ${log}::emergency message

       ${log}::setlevel level

       ${log}::enable level

       ${log}::disable level

       ${log}::lvlchangeproc command

       ${log}::lvlchangeproc

       ${log}::logproc level

       ${log}::logproc level command

       ${log}::logproc level argname body

       ${log}::services

       ${log}::servicename

       ${log}::currentloglevel

       ${log}::delproc command

       ${log}::delproc

       ${log}::delete

       ${log}::trace command

       ${log}::trace on

       ${log}::trace off

       ${log}::trace status ?procName? ?...?

       ${log}::trace add procName ?...?

       ${log}::trace add ?-ns? nsName ?...?

       ${log}::trace remove procName ?...?

       ${log}::trace remove ?-ns? nsName ?...?

__________________________________________________________________________________________________________________________________________________

DESCRIPTION
       The logger package provides a flexible system for logging messages from different services, at priority levels, with different commands.

       To begin using the logger package, we do the following:

                  package require logger
                  set log [logger::init myservice]
                  ${log}::notice "Initialized myservice logging"

                  ... code ...

                  ${log}::notice "Ending myservice logging"
                  ${log}::delete

       In the above code, after the package is loaded, the following things happen:

       logger::init service
              Initializes  the  service service for logging.  The service names are actually Tcl namespace names, so they are separated with '::'.
              The service name may not be the empty string or only ':'s.  When a logger service is initialized, it "inherits" properties from  its
              parents.   For  instance,  if there were a service foo, and we did a logger::init foo::bar (to create a bar service underneath foo),
              bar would copy the current configuration of the foo service, although it would of course, also be possible to then  separately  con‐
              figure  bar.  If a logger service is initialized and the parent does not yet exist, the parent is also created.  The new logger ser‐
              vice is initialized with the default loglevel set with logger::setlevel.

       logger::import ?-all? ?-force? ?-prefix prefix? ?-namespace namespace? service
              Import the logger service commands into the current namespace. Without the -all option only the commands corresponding  to  the  log
              levels  are  imported. If -all is given, all the ${log}::cmd style commands are imported. If the import would overwrite a command an
              error is returned and no command is imported. Use the -force option to force the import and overwrite existing commands without com‐
              plaining.  If the -prefix option is given, the commands are imported with the given prefix prepended to their names.  If the -names‐
              pace option is given, the commands are imported into the given namespace. If the namespace does not  exist,  it  is  created.  If  a
              namespace without a leading :: is given, it is interpreted as a child namespace to the current namespace.

       logger::initNamespace ns ?level?
              Convenience  command  for  setting up a namespace for logging. Creates a logger service named after the namespace ns (a :: prefix is
              stripped), imports all the log commands into the namespace, and sets the default logging level, either as  specified  by  level,  or
              inherited from a service in the parent namespace, or a hardwired default, warn.

       logger::services
              Returns a list of all the available services.

       logger::enable level
              Globally enables logging at and "above" the given level.  Levels are debug, info, notice, warn, error, critical, alert, emergency.

       logger::disable level
              Globally disables logging at and "below" the given level.  Levels are those listed above.

       logger::setlevel level
              Globally enable logging at and "above" the given level. Levels are those listed above. This command changes the default loglevel for
              new loggers created with logger::init.

       logger::levels
              Returns a list of the available log levels (also listed above under enable).

       logger::servicecmd service
              Returns the ${log} token created by logger::init for this service.

       ${log}::debug message

       ${log}::info message

       ${log}::notice message

       ${log}::warn message

       ${log}::error message

       ${log}::critical message

       ${log}::alert message

       ${log}::emergency message
              These are the commands called to actually log a message about an event.  ${log} is the variable obtained from logger::init.

       ${log}::setlevel level
              Enable logging, in the service referenced by ${log}, and its children, at and above the level specified, and disable  logging  below
              it.

       ${log}::enable level
              Enable  logging,  in  the service referenced by ${log}, and its children, at and above the level specified.  Note that this does not
              disable logging below this level, so you should probably use setlevel instead.

       ${log}::disable level
              Disable logging, in the service referenced by ${log}, and its children, at and below the level specified. Note that  this  does  not
              enable logging above this level, so you should probably use setlevel instead.  Disabling the loglevel emergency switches logging off
              for the service and its children.

       ${log}::lvlchangeproc command

       ${log}::lvlchangeproc
              Set the script to call when the log instance in question changes its log level.  If called without a command  it  returns  the  cur‐
              rently  registered command. The command gets two arguments appended, the old and the new loglevel. The callback is invoked after all
              changes have been done.  If child loggers are affected, their callbacks are called before their parents callback.

                proc lvlcallback {old new} {
                    puts "Loglevel changed from $old to $new"
                }
                ${log}::lvlchangeproc lvlcallback

       ${log}::logproc level

       ${log}::logproc level command

       ${log}::logproc level argname body
              This command comes in three forms - the third, older one is deprecated and may be removed from future versions of the  logger  pack‐
              age.   The current set version takes one argument, a command to be executed when the level is called.  The callback command takes on
              argument, the text to be logged. If called only with a valid level logproc returns the name of the command currently  registered  as
              callback command.  logproc specifies which command will perform the actual logging for a given level.  The logger package ships with
              default commands for all log levels, but with logproc it is possible to replace them with custom code.  This would let you send your
              logs over the network, to a database, or anything else.  For example:

                  proc logtoserver {txt} {
                      variable socket
                      puts $socket "Notice: $txt"
                  }

                  ${log}::logproc notice logtoserver

              Trace logs are slightly different: instead of a plain text argument, the argument provided to the logproc is a dictionary consisting
              of the enter or leave keyword along with another dictionary of details about the trace.  These include:

              ·      proc - Name of the procedure being traced.

              ·      level - The stack level for the procedure invocation (from info level).

              ·      script - The name of the file in which the procedure is defined, or an empty string if defined in interactive mode.

              ·      caller - The name of the procedure calling the procedure being traced, or an empty string if the procedure  was  called  from
                     the global scope (stack level 0).

              ·      procargs  -  A  dictionary consisting of the names of arguments to the procedure paired with values given for those arguments
                     (enter traces only).

              ·      status - The Tcl return code (e.g. ok, continue, etc.) (leave traces only).

              ·      result - The value returned by the procedure (leave traces only).

       ${log}::services
              Returns a list of the registered logging services which are children of this service.

       ${log}::servicename
              Returns the name of this service.

       ${log}::currentloglevel
              Returns the currently enabled log level for this service. If no logging is enabled returns none.

       ${log}::delproc command

       ${log}::delproc
              Set the script to call when the log instance in question is deleted.  If called without a command it returns  the  currently  regis‐
              tered command.  For example:

                  ${log}::delproc [list closesock $logsock]

       ${log}::delete
              This  command  deletes  a particular logging service, and its children.  You must call this to clean up the resources used by a ser‐
              vice.

       ${log}::trace command
              This command controls logging of enter/leave traces for specified procedures.  It is used to enable and disable tracing, query trac‐
              ing  status, and specify procedures are to be traced.  Trace handlers are unregistered when tracing is disabled.  As a result, there
              is not performance impact to a library when tracing is disabled, just as with other log level commands.

                proc tracecmd { dict } {
                    puts $dict
                }

                set log [::logger::init example]
                ${log}::logproc trace tracecmd

                proc foo { args } {
                    puts "In foo"
                    bar 1
                    return "foo_result"
                }

                proc bar { x } {
                    puts "In bar"
                    return "bar_result"
                }

                ${log}::trace add foo bar
                ${log}::trace on

                foo

              # Output:
              enter {proc ::foo level 1 script {} caller {} procargs {args {}}}
              In foo
              enter {proc ::bar level 2 script {} caller ::foo procargs {x 1}}
              In bar
              leave {proc ::bar level 2 script {} caller ::foo status ok result bar_result}
              leave {proc ::foo level 1 script {} caller {} status ok result foo_result}

       ${log}::trace on
              Turns on trace logging for procedures registered through the trace add command.  This is similar to the  enable  command  for  other
              logging  levels,  but allows trace logging to take place at any level.  The trace logging mechanism takes advantage of the execution
              trace feature of Tcl 8.4 and later.  The trace on command will return an error if called from earlier versions of Tcl.

       ${log}::trace off
              Turns off trace logging for procedures registered for trace logging through the trace add command.  This is similar to  the  disable
              command  for other logging levels, but allows trace logging to take place at any level.  Procedures are not unregistered, so logging
              for them can be turned back on with the trace on command.  There is no overhead imposed by trace registration when trace logging  is
              disabled.

       ${log}::trace status ?procName? ?...?
              This command returns a list of the procedures currently registered for trace logging, or a flag indicating whether or not a trace is
              registered for one or more specified procedures.

       ${log}::trace add procName ?...?

       ${log}::trace add ?-ns? nsName ?...?
              This command registers one or more procedures for logging of entry/exit traces.  Procedures can be specified via a list of procedure
              names or namespace names (in which case all procedure within the namespace are targeted by the operation).  By default, each name is
              first interpreted as a procedure name or glob-style search pattern, and if not found its interpreted as a namespace name.   The  -ns
              option can be used to force interpretation of all provided arguments as namespace names.  Procedures must be defined prior to regis‐
              tering them for tracing through the trace add command.  Any procedure or namespace names/patterns that don't match any existing pro‐
              cedures will be silently ignored.

       ${log}::trace remove procName ?...?

       ${log}::trace remove ?-ns? nsName ?...?
              This  command  unregisters  one  or more procedures so that they will no longer have trace logging performed, with the same matching
              rules as that of the trace add command.

IMPLEMENTATION
       The logger package is implemented in such a way as to optimize (for Tcl 8.4 and newer) log procedures which are disabled.  They are aliased
       to a proc which has no body, which is compiled to a no op in bytecode.  This should make the peformance hit minimal.  If you really want to
       pull out all the stops, you can replace the ${log} token in your code with the actual namespace and command  (${log}::warn  becomes  ::log‐
       ger::tree::myservice::warn),  so  that  no variable lookup is done.  This puts the performance of disabled logger commands very close to no
       logging at all.

       The "object orientation" is done through a hierarchy of namespaces.  Using an actual object oriented system would probably be a better  way
       of doing things, or at least provide for a cleaner implementation.

       The service "object orientation" is done with namespaces.

LOGPROCS AND CALLSTACK
       The  logger package takes extra care to keep the logproc out of the call stack.  This enables logprocs to execute code in the callers scope
       by using uplevel or linking to local variables by using upvar. This may fire traces with all usual side effects.

                   # Print caller and current vars in the calling proc
                   proc log_local_var {txt} {
                        set caller [info level -1]
                        set vars [uplevel 1 info vars]
                        foreach var [lsort $vars] {
                           if {[uplevel 1 [list array exists $var]] == 1} {
                           lappend val $var <Array>
                           } else {
                           lappend val $var [uplevel 1 [list set $var]]
                           }
                        }
                        puts "$txt"
                        puts "Caller: $caller"
                        puts "Variables in callers scope:"
                        foreach {var value} $val {
                        puts "$var = $value"
                        }
                   }

                   # install as logproc
                   ${log}::logproc debug log_local_var

BUGS, IDEAS, FEEDBACK
       This document, and the package it describes, will undoubtedly contain bugs and other problems.  Please report such in the  category  logger
       of the Tcllib Trackers [http://core.tcl.tk/tcllib/reportlist].  Please also report any ideas for enhancements you may have for either pack‐
       age and/or documentation.

KEYWORDS
       log, log level, logger, service

CATEGORY
       Programming tools

tcllib                                                                 0.9.4                                                          logger(3tcl)
