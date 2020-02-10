init(8)                                                                                  System Manager's Manual                                                                                  init(8)

NAME
       init - Upstart process management daemon

SYNOPSIS
       init [OPTION]...

DESCRIPTION
       init  is the parent of all processes on the system, it is executed by the kernel and is responsible for starting all other processes; it is the parent of all processes whose natural parents have
       died and it is responsible for reaping those when they die.

       Processes managed by init are known as jobs and are defined by files in the /etc/init directory.  See init(5) for more details on configuring Upstart.

   Events
       init(8) is an event-based init daemon.  This means that jobs will be automatically started and stopped by changes that occur to the system state, including as a result of jobs starting and stop‐
       ping.

       This  is  different  to  dependency-based  init daemons which start a specified set of goal jobs, and resolve the order in which they should be started and other jobs required by iterating their
       dependencies.

       For more information on starting and stopping jobs, as well as emitting events that will automatically start and stop jobs, see the manual page for the initctl(8) tool.

       The primary event is the startup(7) event, emitted when the daemon has finished loading its configuration.  Other useful events are the starting(7), started(7), stopping(7) and stopped(7) events
       emitted as jobs change state.

   Job States
       Table 1: Job Goals and State Transitions.

       ┌───────────────┬──────────────────────────────────────────┐
       │               │                   Goal                   │
       │               ├───────────────┬──────────────────────────┤
       │Current State  │    start      │           stop           │
       ├───────────────┼───────────────┴──────────────────────────┤
       │waiting        │  starting        n/a                     │
       │starting       │  pre-start       stopping                │
       │pre-start      │  spawned         stopping                │
       │spawned        │  post-start      stopping                │
       │post-start     │  running         stopping                │
       │running        │  stopping        pre-stop / stopping (*) │
       │pre-stop       │  running         stopping                │
       │stopping       │  killed          killed                  │
       │killed         │  post-stop       post-stop               │
       │post-stop      │  starting        waiting                 │
       └───────────────┴──────────────────────────────────────────┘
       Key:
         (*) If there is a script or exec section and this process is running,
         state will be 'pre-stop', else it will be 'stopping'.

   Job Lifecycle
       Starting a Job

       1  Initially the job is "at rest" with a goal of 'stop' and a state of 'waiting' (shown as 'stop/waiting' by the initctl(8) list and status commands).

       2  The goal is changed from 'stop' to 'start' indicating the job is attempting to start.

       3  The state is changed from 'waiting' to 'starting'.

       4  The starting(7) event is emitted denoting the job is "about to start".

       5  Any jobs whose 'start on' (or 'stop on') condition would be satisfied by this job starting are started (or stopped respectively).

       6  The starting(7) event completes.

       7  The state is changed from 'starting' to 'pre-start'.

       8  If the pre-start stanza exists, the pre-start process is spawned.

       9  If the pre-start process fails, the goal is changed from 'start' to 'stop', and the stopping(7) and stopped(7) events are emitted with appropriate variables set denoting the error.

       10 Assuming the pre-start did not fail or did not call "stop", the main process is spawned.

       11 The state is changed from 'pre-start' to 'spawned'.

       12 Upstart then ascertains the final PID for the job which may be a descendent of the immediate child process if expect fork or expect daemon has been specified.

       13 The state is changed from 'spawned' to 'post-start'.

       14 If the post-start stanza exists, the post-start process is spawned.

       15 The state is changed from 'post-start' to 'running'.

       16 The started(7) event is emitted.

          For services, when this event completes the main process will now be fully running. If the job refers to a task, it will now have completed (successfully or otherwise).

       17 Any jobs whose 'start on' (or 'stop on') condition would be satisfied by this job being started are started (or stopped respectively).

       Stopping a Job

       1  Assuming the job is fully running, it will have a goal of 'start' and a state of 'running' (shown as 'start/running' by the initctl(8) list and status commands).

       2  The goal is changed from 'start' to 'stop' indicating the job is attempting to stop.

       3  The state is changed from 'running' to 'pre-stop'.

       4  If the pre-stop stanza exists, the pre-stop process is spawned.

       5  The state is changed from 'pre-stop' to 'stopping'.

       6  The stopping(7) event is emitted.

       7  Any jobs whose 'start on' (or 'stop on') condition would be satisfied by this job stopping are started (or stopped respectively).

       8  The main process is stopped:

          i  The  signal  specified  by the kill signal stanza is sent to the process group of the main process (such that all processes belonging to the jobs main process are killed).  By default this
             signal is SIGTERM.

             See signal(7) and init(5).

          ii Upstart waits for up to "kill timeout" seconds (default 5 seconds) for the process to end.

          iii
             If the process is still running after the timeout, a SIGKILL signal is sent to the process which cannot be ignored and will forcibly stop the processes in the process group.

       9  The state is changed from 'killed' to 'post-stop'.

       10 If the post-stop stanza exists, the post-stop process is spawned.

       11 The state is changed from 'post-stop' to 'waiting'.

       12 The stopped(7) event is emitted.

          When this event completes, the job is fully stopped.

       13 Any jobs whose 'start on' (or 'stop on') condition would be satisfied by this job being stopped are started (or stopped respectively).

   System V compatibility
       The Upstart init(8) daemon does not keep track of runlevels itself, instead they are implemented entirely by its userspace tools.  The event emitted to signify a change of runlevel is  the  run‐
       level(7) event.  For more information see its manual page.

OPTIONS
       Options are passed to init(8) by placing them on the kernel command-line.

       --append-confdir directory
              Add  the  specified  directory to the default directory or directories that job configuration files will be read from. This option may be specified multiple times which will result in job
              configuration files being loaded from each directory specified (which must exist).  Directories will be searched for jobs in the specified order after the default  directories  have  been
              searched.

              Note  that  if  this  option  is used in combination with --confdir, or --prepend-confdir, regardless of the order of the options on the command-line, the append directories will be added
              after the other directories.

       --confdir directory
              Read job configuration files from a directory other than the default (/etc/init for process ID 1). This option may be specified multiple times which will result in job configuration files
              being loaded from each directory specified (which must exist). Directories will be searched for jobs in the specified order.

              In the case that multiple directories specify a job of the same name, the first job encountered will be honoured.

              See section User Session Mode in init(5) for the ordered list of default configuration directories a Session Init will consider.

       --default-console value
              Default value for jobs that do not specify a 'console' stanza. This could be used for example to set the default to 'none' but still honour jobs that specify explicitly 'console log'. See
              init(5) for all possible values of console.

       --no-cgroups
              Do not honour the cgroup stanza. If specified, this stanza will be ignored for any job which specifies it: the job processes will not be placed in the cgroup specified by the  stanza  and
              the job itself will not wait until the cgroup manager has started before starting itself.  See init(5) for further details.

       --no-dbus
              Do not connect to a D-Bus bus.

       --no-inherit-env
              Stop jobs from inheriting the initial environment. Only meaningful when running in user mode.

       --logdir directory
              Write job output log files to a directory other than /var/log/upstart (system mode) or $XDG_CACHE_HOME/upstart (user session mode).

       --no-log
              Disable logging of job output. Note that jobs specifying 'console log' will be treated as if they had specified 'console none'.  See init(5) for further details.

       --no-sessions
              Disable chroot sessions.

       --no-startup-event
              Suppress emission of the initial startup event. This option should only be used for testing since it will stop the init(8) daemon from starting any jobs automatically.

       --prepend-confdir directory
              Add the specified directory to the directory or directories that job configuration files will be read from. This option may be specified multiple times which will result in job configura‐
              tion files being loaded from each directory specified (which must exist).  Directories will be searched for jobs in the specified order before the default directories have been searched.

              Note that if this option is used in combination with --confdir, or --append-confdir, regardless of the order of the options on the command-line, the  prepend  directories  will  be  added
              before the other directories.

       --session
              Connect to the D-Bus session bus. This should only be used for testing.

       --startup-event event
              Specify a different initial startup event from the standard startup(7).

       --user Starts  in  user  mode,  as used for user sessions. Upstart will be run as an unprivileged user, reading configuration files from configuration locations as per roughly XDG Base Directory
              Specification. See init(5) for further details.

       -q, --quiet
              Reduces output messages to errors only.

       -v, --verbose
              Outputs verbose messages about job state changes and event emissions to the system console or log, useful for debugging boot.

       --version
              Outputs version information and exits.

NOTES
       init is not normally executed by a user process, and expects to have a process id of 1.  If this is not the case, it will actually execute telinit(8) and pass all arguments to  that.   See  that
       manual  page  for  further details. However, if the --user option is specified, it will run as a Session Init and read alternative configuration files and manage the individual user session in a
       similar fashion.

       Sending a Session Init a SIGTERM signal is taken as a request to shutdown due to an impending system shutdown. In this scenario, the Session Init will emit the session-end event and  request all
       running  jobs stop. It will attempt to honour jobs kill timeout values (see init(5) for further details). Note however that system policy will prevail: if jobs request timeout values longer than
       the system policy allows for complete system shutdown, it will not be possible to honour them before the Session Init is killed by the system.

ENVIRONMENT VARIABLES
       When run as a user process, the following variables may be used to find job configuration files:

       ·   $XDG_CONFIG_HOME

       ·   $XDG_CONFIG_DIRS

       See User Session Mode in init(5) for further details.

FILES
       /etc/init.conf

       /etc/init/

       $HOME/.init/

       $XDG_CONFIG_DIRS/upstart/

       $XDG_CONFIG_HOME/upstart/

AUTHOR
       Written by Scott James Remnant <scott@netsplit.com>

REPORTING BUGS
       Report bugs at <https://launchpad.net/upstart/+bugs>

COPYRIGHT
       Copyright © 2009-2013 Canonical Ltd.
       This is free software; see the source for copying conditions.  There is NO warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

SEE ALSO
       all-swaps(7), control-alt-delete(7), dbus-daemon(1), dbus-event(7), dconf-event(7), file-event(7), filesystem(7), init(5), init(8), initctl(8), keyboard-request(7),  local-filesystems(7),  moun‐
       tall(8),  mounted(7),  mounting(7),  power-status-changed(7),  remote-filesystems(7),  runlevel(7),  shutdown(8),  socket-event(7),  started(7), starting(7), startup(7), stopped(7), stopping(7),
       telinit(8),   upstart-dbus-bridge(8),   upstart-dconf-bridge(8),   upstart-event-bridge(8),   upstart-events(7),   upstart-file-bridge(8),   upstart-local-bridge(8),    upstart-socket-bridge(8),
       upstart-udev-bridge(8), virtual-filesystems(7).

Upstart                                                                                         2014-05-09                                                                                        init(8)
init(5)                                                                                    File Formats Manual                                                                                    init(5)

NAME
       init - Upstart init daemon job configuration

SYNOPSIS
       /etc/init/
              Default location of system job configuration files.

       $XDG_CONFIG_HOME/upstart/, $XDG_CONFIG_DIRS/upstart/
              Default locations of user session job configuration files.

       $HOME/.init/
              Deprecated location of user job configuration files (still honoured by User Session Mode).

DESCRIPTION
       On startup, the Upstart init(8) daemon reads its job configuration from files in the /etc/init/ directory by default, and watches for future changes to these files using inotify(7).

       If Upstart was invoked as a user process with --user option, it will run in User Session mode. See User Session Mode for further details.

       To be considered by Upstart, files in this directory must have a recognized suffix and may also be present in sub-directories.  There are two recognized suffixes:

       ·   Files ending in .conf are called configuration files, or simply "conf files" for short.  These are the primary vehicle for specifying a job.

       ·   Files  ending in .override are called override files.  If an override file is present, the stanzas it contains take precedence over those equivalently named stanzas in the corresponding con‐
           figuration file contents for a particular job.  The main use for override files is to modify how a job will run without having to modify its configuration file  directly.   See  the  section
           Override File Handling below for further details.

       A job can thus be defined by either:

       · A single configuration file.

       · A single configuration file and a single override file.

       Unless explicitly stated otherwise, any reference to a jobs configuration can refer both to a configuration file or an override file.

       Each configuration file defines the template for a single service (long-running process or daemon) or task (short-lived process).

       Note that a configuration file is not itself a job: it is a description of an environment a job could be run in.  A job is the runtime embodiment of a configuration file.

       The  configuration  file  name  as  displayed  by  Upstart  and  associated  tooling is taken from its relative path within the directory without the extension.  For example a configuration file
       /etc/init/rc-sysinit.conf is named rc-sysinit, while a configuration file /etc/init/net/apache.conf is named net/apache.  Since override files only modify the way a configuration file is  inter‐
       preted, they are not named.

       Configuration files are plain text and should not be executable.

   Chroot Support
       Upstart  is able to manage jobs within a chroot(2). To control jobs within the chroot environment, use the standard initctl(8) facility. Note that it is not necessary to install D-Bus within the
       chroot (in fact it is not recommended).

       Note that this facility is distinct from the chroot stanza (see Process environment below).

   User Session Mode
       Upstart can manage complete User Sessions. In this mode it runs with a process id greater than 1 and will read job configuration files from the following list of directories in the order shown:

       ·   $XDG_CONFIG_HOME/upstart/

       ·   $HOME/.init/

       ·   $XDG_CONFIG_DIRS/upstart/

       ·   /usr/share/upstart/sessions/

       Note that the first directory to contain a job is considered the owner of that job name: any subsequently searched directory that contains a job of the  same  name  will  be  ignored.  The  same
       applies  for  override  files:  only the first override file found in the search order will be applied. Note that an override file can be in the same directory or earlier to that directory which
       contains the job file.

       Jobs in these locations are expected to launch the user's session.  Upstart will try to parent all spawned process with the aid of prctl(2).  If successful this will  ensure  that  even  double-
       forking daemons will be reparented to the User Session process, and not to the init(8) daemon running with process id 1.

       When running in User Session mode, Upstart will kill all job processes on session logout or shutdown.

       All log output will be in $XDG_CACHE_HOME/upstart which defaults to $HOME/.cache/upstart

   Configuration File Format
       Each  line  begins  with  a configuration stanza and continues until either the end of the line or a line containing a closing stanza.  Line breaks within a stanza are permitted within single or
       double quotes, or if preceded by a blackslash.

       If a stanza is duplicated, the last occurence will be used. Unrecognized stanzas will generate parse errors, which will stop a job from running.

       Stanzas and their arguments are delimited by whitespace, which consists of one or more space or tab characters which are otherwise ignored unless placed within single or double quotes.

       Comments begin with a `#' and continue until the end of the line.  Blank lines and lines consisting only of whitespace or comments are ignored.

   Process definition
       The primary use of jobs is to define services or tasks to be run by the init(8) daemon.  Each job may have one or more different processes run as part of its  lifecycle,  with  the  most  common
       known as the main process.

       The  main process is defined using either the exec or script stanzas, only one of which is permitted.  These specify the executable or shell script that will be run when the job is considered to
       be running.  Once this process terminates, the job stops.

       All processes are run with the full job environment available as environment variables in their process.

       exec COMMAND [ ARG ]...
              This stanza defines the process to be run as the name of an executable on the filesystem, and zero or more arguments to be passed to it.  Any special characters, e.g. quotes or `$' speci‐
              fied will result in the entire command being passed to a shell for expansion.

              exec /usr/sbin/acpid -c $EVENTSDIR -s $SOCKET

       script ... end script
              This stanza defines the process to be run as a shell script that will be executed using sh(1).  The -e shell option is always used, so any command that fails will terminate the script.

              The script stanza appears on its own on a line, the script is everything up until the first end script stanza appearing on its own on a line.

              script
                  dd bs=1 if=/proc/kmsg of=$KMSGSINK
                  exec /sbin/klogd -P $KMSGSINK
              end script

       There are an additional four processes that may be run as part of the job's lifecycle.  These are specified as the process name, followed by an exec or script stanza.

       pre-start exec|script...
              This  process  will  be  run after the job's starting(7) event has finished, but before the main process is run.  It is typically used to prepare the environment, such as making necessary
              directories, and it may also call the stop(8) command without arguments to cancel the start.

       post-start exec|script...
              This process will be run before the job's started(7) event is emitted, but after the main process has been spawned.  It is typically used to send necessary commands to the  main  process,
              or to delay the started(7) event until the main process is ready to receive clients.

       pre-stop exec|script...
              This  process is run if the job is stopped by an event listed in its stop on stanza or by the stop(8) command.  It will be run before the job's stopping(7) event is emitted and before the
              main process is killed.  It is typically used to send any necessary shutdown commands to the main process, and it may also call the start(8) command without arguments to cancel the stop.

       post-stop exec|script...
              This process is run after the main process has been killed and before the job's stopped(7) event is emitted.  It is typically used to clean up the environment, such as removing  temporary
              directories.

       All  of  these processes, including the main process, are optional.  Services without a main process will appear to be running until they are stopped: this is commonly used to define states such
       as runlevels.  It is permissible to have no main process, but to have pre-start and post-stop processes for the state.

              pre-start exec ifup -a
              post-stop exec ifdown -a

   Event definition
       Jobs can be manually started and stopped at any time by a system administrator using the start(8) and stop(8) tools, however it is far more useful for jobs to be started  and  stopped  automati‐
       cally by the init(8) daemon when necessary.

       This is done by specifying which events should cause your job to be started, and which cause your process to be stopped again.

       The set of possible events is limitless, however there are a number of standard events defined by the init(8) daemon and telinit(8) tools that you will want to use.

       When first started, the init(8) daemon will emit the startup(7) event.  This will activate jobs that implement System V compatibility and the runlevel(7) event.  As jobs are started and stopped,
       the init(8) daemon will emit the starting(7), started(7), stopping(7) and stopped(7) events on their behalf.

       start on EVENT [[KEY=]VALUE]... [and|or...]
              The start on stanza defines the set of events that will cause the job to be automatically started.  Each EVENT is given by its name.  Multiple events are permitted using the and & or log‐
              ical operators, and complex expressions may be performed with parentheses (within which line breaks are permitted).

              You  may  also match on the environment variables contained within the event by specifying the KEY and expected VALUE.  If you know the order in which the variables are given to the event
              you may omit the KEY.

              VALUE may contain wildcard matches and globs as permitted by fnmatch(3) and may expand the value of any variable defined with the env stanza.

              Negation is permitted by using != between the KEY and VALUE.

              If an event is emitted for which no jobs have registered interest (via either start on or stop on), the event is destroyed.

              If a job specifies a single event in its start condition and that event is emitted and matches any specifies event environment variables, the overall condition becomes true,  the  job  is
              started and -- assuming no other job has registered an interest in it -- the event is destroyed.

              However,  if  an  event  is  emitted  which  matches  part of a jobs start condition, the job is said to be blocking the event (since the event is unable to change state until the job has
              started) and will both cause the event to persist and the job start condition to be marked as partially completed. Once all events in the start condition have been  emitted,  the  overall
              job start condition becomes true and the job will be started. If no other jobs have registered interest in the events in the start condition, they will then be destroyed.

              Note that no job processes are started until the overall expression evaluates to true.

              Note that if a new job is created which specifies that it starts on one or more events that have already been destroyed, that job will not start automatically until those events are emit‐
              ted again. Depending on the event, this may not happen until the next time the system is booted.

              Although complex expressions are supported, it should be possible to specify the start condition for the majority of jobs with very simple expressions (between one and four  events  as  a
              very approximate guide). A large number or complex combination of events is often an indication that the condition should be refactored.

              Examples of start on conditions:

              start on started gdm or started kdm

              start on stopped JOB=foo RESULT=failed PROCESS=pre-start

              start on device-added SUBSYSTEM=tty DEVPATH=ttyS*

              start on net-device-added INTERFACE!=lo

              start on (A and B C=D and E F=G)

       stop on EVENT [[KEY=]VALUE]... [and|or...]
              The stop on stanza defines the set of events that will cause the job to be automatically stopped.  It has the same syntax as start on.

              VALUE may additionally expand the value of any variable that came from the job's start environment (either the event or the command that started it).

              Examples of stop on conditions:

              stop on A

              stop on starting B and stopped JOB=C

              stop on stopping gdm or stopping kdm

              stop on device-removed DEVPATH=$DEVPATH

       manual This  stanza  will  disregard  any  previously seen start on definition.  By adding this stanza on any line below the start on definition, it provides the ability to stop a job from being
              automatically started.  When specified, the only way to start such a job is via start (8).

   Job environment
       Each job is run with an environment constructed from the following categories:

       ·   A minimal set of standard system variables added by Upstart.

           All jobs contain the TERM and PATH variables.

       ·   Variables set using the initctl(8) job environment commands (such as set-env).

           These commands also allow unsetting of variables.

       ·   A set of special variables added by Upstart that relate to the job itself.

           All jobs also contain the UPSTART_JOB and UPSTART_INSTANCE environment variables, containing the name of the job and instance.  These are mostly used by the initctl(8) utility to default  to
           acting on the job the commands are called from.

       ·   Those variables introduced by the events or command that started the job.

           The special UPSTART_EVENTS environment variable contains the list of events that started the job, it will not be present if the job was started manually.

           The pre-stop and post-stop scripts are run with the environment of the events or commands that stopped the job.  The UPSTART_STOP_EVENTS environment variable contains the list of events that
           stopped the job, it will not be present if the job was stopped manually.

       ·   Variables set within the job itself using the env and export stanzas. These provide default values - if the command or event which causes the job to start specifies alternative values, those
           are given priority over the defaults.

           env KEY[=VALUE]
                  Defines  a  default environment variable, the value of which may be overridden by the event or command that starts the job.  If ´KEY=VALUE´ is specified, the variable KEY is given the
                  value VALUE.  If only ´KEY´ is given, then the value is taken from the init(8) daemon's own environment.

           export KEY...
                  Exports the value of one or more environment variables into the starting(7), started(7), stopping(7) and stopped(7) events for this job and to all resultant  events  (not  just  those
                  relating to the current job).

                  Note that each KEY is the name of a variable; it is not prefixed with a dollar ('$') sign.

       The first two categories above comprise the job environment table which is applied to all jobs. Note that changing the job environment table will only affect newly-started jobs.

   Services, tasks and respawning
       Jobs  are  services by default.  This means that the act of starting the job is considered to be finished when the job is running, and that even exiting with a zero exit status means the service
       will be respawned.

       task   This stanza may be used to specify that the job is a task instead.  This means that the act of starting the job is not considered to be finished until the job  itself  has  been  run  and
              stopped again, but that exiting with a zero exit status means the task has completed successfully and will not be respawned.

       The start(8) command, and any starting(7) or stopping(7) events will block only until a service is running or until a task has finished.

       respawn
              A  service  or  task  with  this  stanza will be automatically started if it should stop abnormally.  All reasons for a service stopping, except the stop(8) command itself, are considered
              abnormal.  Tasks may exit with a zero exit status to prevent being respawned.  Note that specifying this stanza without also specifying the respawn limit stanza  will  apply  the  default
              respawn limit as specified below.

       respawn limit [COUNT INTERVAL|unlimited]
              Respawning  is subject to a limit, if the job is respawned more than COUNT times in INTERVAL seconds, it will be considered to be having deeper problems and will be stopped. Default COUNT
              is 10. Default INTERVAL is 5 seconds.

              If the special argument unlimited is specified instead of a COUNT and INTERVAL value, no limit will be applied and the job will be  respawned  indefinitely.  Specifying  either  COUNT  or
              INTERVAL as zero implies unlimited.

              This stanza only applies to automatic respawns and not the restart(8) command.

       normal exit STATUS|SIGNAL...
              Additional  exit statuses or even signals may be added, if the job process terminates with any of these it will not be considered to have failed and will not be respawned. A signal can be
              specified either as a full name (for example "SIGTERM") or a partial name (for example "TERM").

              normal exit 0 1 TERM SIGHUP

   Instances
       By default, only one instance of any job is permitted to exist at one time.  Attempting to start a job when it's already starting or running results in an error. Note that a job is considered to
       be running if its pre-start process is running.

       Multiple  instances  may  be  permitted by defining the names of those instances.  If an instance with the same name is not already starting or running, a new instance will be started instead of
       returning an error.

       instance NAME
              This stanza defines the names of instances, on its own its not particularly useful since it would just define the name of the single permitted instance, however NAME expands any  variable
              defined in the job's environment.

              These will often be variables that you need to pass to the process anyway, so are an excellent way to limit the instances.

              instance $CONFFILE
              exec /sbin/httpd -c $CONFFILE

              instance $TTY
              exec /sbin/getty -8 38300 $TTY

              These jobs appear in the initctl(8) output with the instance name in parentheses, and have the INSTANCE environment variable set in their events.

   Documentation
       Upstart provides several stanzas useful for documentation and external tools.

       description DESCRIPTION
              This stanza may contain a description of the job.

              description "This does neat stuff"

       author AUTHOR
              This stanza may contain the author of the job, often used as a contact for bug reports.

              author "Scott James Remnant <scott@netsplit.com>"

       version VERSION
              This stanza may contain version information about the job, such as revision control or package version number.  It is not used or interpreted by init(8) in any way.

              version "$Id$"

       emits EVENT...
              All processes on the system are free to emit their own events by using the initctl(8) tool, or by communicating directly with the init(8) daemon.

              This stanza allows a job to document in its job configuration what events it emits itself, and may be useful for graphing possible transitions.

              The initctl(8) check-config command attempts to use this stanza to resolve events.

              EVENT  can  be  either a literal string or a string including shell wildcard meta-characters (asterisk ('*'), question mark ('?'), and square brackets ('[' and ']')).  Meta-characters are
              useful to allow initctl(8) check-config to resolve a class of events, such as those emitted by upstart-udev-bridge(8).

       usage USAGE
              This stanza may contain the text used by initctl(8) usage command. This text may be also shown when commands start(8), stop(8) or status(8) fail.

              usage "tty DEV=ttyX - where X is console id"

   Process environment
       Many common adjustments to the process environment, such as resource limits, may be configured directly in the job rather than having to handle them yourself.

       console none|log|output|owner
              none
                     If none is specified, the jobs standard input, standard output and standard error file descriptors are connected to /dev/null.  Any output generated by a  job  will  be  discarded.
                     This used to be the default prior to the introduction of log in Upstart 1.4.

              log
                     If log is specified, standard input is connected to /dev/null, and standard output and standard error are connected to a pseudo-tty which logs all job output.

                     Output is logged to file /var/log/upstart/<job-log-file> or $XDG_CACHE_HOME/upstart/<job-log-file> for system and user session jobs respectively.

                     If  a  job has specified instance, <job-log-file> will equate to <job>-<instance>.log where '<instance>' is replaced by the specific instance value and '<job>' is replaced with the
                     job name (job configuration file name, without the extension).  If instance is not specified, <job-log-file> will be <job>.log where '<job>' is replaced with the job name.

                     Jobs started from within a chroot will have their output logged to such a path within the chroot.

                     If log files already exist, they are appended to.

                     All slash ('/') characters in <job-log-file> are replaced with underscore ('_') characters. For example, any output from the 'wibble' instance of the 'foo/bar' job would be encoded
                     in file 'foo_bar-wibble.log' in the log file directory. This gives the log file directory a flat structure.

                     If  the  directory for system jobs does not exist, job output for each job will be cached until the job finishes. Thus, the boot process must ensure that the directory is available
                     as soon as possible since any job that finishes before a writeable disk is available will not be able to take advantage of this facility.

                     If it is not possible to write to any log file due to lack of disk space, the job will be considered to have specified a console value of none and all subsequent job output will be
                     discarded.

                     If the logger detects that the file it is about to write to was deleted, it will re-open the file first.

                     Care should be taken if the log directory is a mount point since any job that starts before that mount is available and which produces output will then attempt to write logs to the
                     mount point, not to the mounted directory. This may give the impression that log data has not been recorded. A strategy to handle this situation is to ensure the mount point direc‐
                     tory is not writeable such that logs will only be written when the mount has succeeded (assuming the mount itself is writeable and has sufficient space).

                     Note  that  since  log utilizes pseudo-ttys, your kernel must support these. If it does not, the console value will be modified automatically to none.  Further, note that it may be
                     necessary to increase the number of available pty devices; see pty(7) for details.

                     Under Linux, full Unix 98 pty support requires that the devpts filesystem be mounted.

                     If pty setup fails for any reason, an error message will be displayed and the job's console value will be reset to none.

              output
                     If output is specified, the standard input, standard output and standard error file descriptors are connected to /dev/console.

              owner
                     The owner value is special: it not only connects the job to the system console but sets the job to be the owner of the system console, which means it will receive  certain  signals
                     from the kernel when special key combinations such as Control-C are pressed.

       umask UMASK
              A common configuration is to set the file mode creation mask for the process.  UMASK should be an octal value for the mask, see umask(2) for more details.

       nice NICE
              Another common configuration is to adjust the process's nice value, see nice(1) for more details.

       oom score ADJUSTMENT|never
              Normally the OOM killer regards all processes equally, this stanza advises the kernel to treat this job differently.

              ADJUSTMENT  may  be  an  integer  value from -999 (very unlikely to be killed by the OOM killer) up to 1000 (very likely to be killed by the OOM killer).  It may also be the special value
              never to have the job ignored by the OOM killer entirely.

       chroot DIR
              Runs the job's processes in a chroot(8) environment underneath DIR

              Note that DIR must have all the necessary system libraries for the process to be run, often including /bin/sh

       chdir DIR
              Runs the job's processes with a working directory of DIR instead of the root of the filesystem.

       limit LIMIT SOFT|unlimited HARD|unlimited
              Sets initial system resource limits for the job's processes.  LIMIT may be one of core, cpu, data, fsize, memlock, msgqueue, nice, nofile, nproc, rss, rtprio, sigpending or stack.

              Limits are specified as both a SOFT value and a HARD value, both of which are integers.  The special value unlimited may be specified for either.

       setuid USERNAME
              Changes to the user USERNAME before running any job process.

              The job process will run with the primary group of user USERNAME unless the setgid stanza is also specified in which case that group will be used instead.

              For system jobs initgroups(3) will be called to set up supplementary group access.

              Failure to determine and/or set user and group details will result in the overall job failing to start.

              If this stanza is unspecified, all job processes will run with user ID 0 (root) in the case of system jobs, and as the user in the case of user jobs.

              Note that system jobs using the setuid stanza are still system jobs, and can not be controlled by an unprivileged user, even if the setuid stanza specifies that user.

       setgid GROUPNAME
              Changes to the group GROUPNAME before running any job process.

              For system jobs initgroups(3) will be called to set up supplementary group access.

              If this stanza is unspecified, the primary group of the user specified in the setuid block is used for all job processes. If both this and the setuid stanza are unspecified, all job  pro‐
              cesses will run with their group ID set to 0 (root) in the case of system jobs, and as the primary group of the user in the case of User Session jobs.

       cgroup CONTROLLER [ NAME ] [ KEY VALUE ]
              Specify the control group all job processes will run in and optionally specify a setting for the particular cgroup.

              This stanza will be ignored if the version of Upstart is new enough to support cgroups but has been built without cgroup support.

              This stanza will also be ignored if the init(8) daemon has had cgroup support disabled at boot time (see init (8)).

              A  job which specifies this stanza will not be started until both its start on condition is met and the address of the cgroup manager has been communicated to the init(8) daemon using the
              initctl(8) command notify-cgroup-manager-address.

              If only the cgroup controller (such as memory, cpuset, blkio) is specified, a job-specific cgroup will be created and the job processes placed in it. The form of this cgroup is

              upstart/$UPSTART_JOB

              or if the job specifies the instance stanza the group will be the expanded value of:

              upstart/$UPSTART_JOB-$UPSTART_INSTANCE

              Any forward slashes in $UPSTART_JOB and $UPSTART_INSTANCE will be replaced with underscore ('_') characters.

              This default cgroup for the job may be specified explicitly within a NAME using the special variable $UPSTART_CGROUP.  This variable is not an  environment  variable  and  is  only  valid
              within the context of the cgroup stanza.

              If NAME is not specified or does not contain $UPSTART_CGROUP, the job processes will not be placed in an upstart-specific

              Note that this special variable cannot be specified with enclosing braces around the name.

              No validation is performed on the specified values until the job is due to be started.

              If the CONTROLLER is invalid, or the NAME cannot be created or the KEY or VALUE are invalid, the job will be failed.

              The NAME argument may contain any valid variable and can also contain forward slashes to run the job processes in a sub-cgroup.

              If any argument contains space characters, it must be quoted.

              If a KEY is specified, a VALUE must also be specified (even it is simply an empty string).

              The stanza maybe specified multiple times. The last occurence will be used except in the scenario where each occurence specifies a different KEY in which case all the keys and values will
              be applied.

              It is not an error if NAME already exists.

              Valid syntax:

              Implicit NAME, no setting.
                     cgroup CONTROLLER

              Explicit name, no setting.
                     cgroup CONTROLLER NAME

              Implicit name with setting.
                     cgroup CONTROLLER KEY VALUE

              Explicit name with setting.
                     cgroup CONTROLLER NAME KEY VALUE

              Examples:

              ·      Run all job processes in the default cpu cgroup controller group.

                     cgroup cpu

              ·      As above.

                     cgroup cpu $UPSTART_CGROUP

              ·      As above.

                     cgroup cpu "$UPSTART_CGROUP"

              ·      Attempt to place the job processes in a non-job-specific cgroup.

                     cgroup cpu "a-well-known-cgroup"

              ·      The job will only start once the manager is up and running and will have a 50MB memory limit, be restricted to CPU ids 0 and 1 and have a 1MB/s write  limit  to  the  block  device
                     8:16. The job will fail to start if the system has less than 50MB of RAM or less than 2 CPUs.

                     cgroup memory $UPSTART_CGROUP limit_in_bytes 52428800
                     cgroup cpuset $UPSTART_CGROUP cpus 0-1
                     cgroup blkio slowio throttle.write_bps_device "8:16 1048576"

   Override File Handling
       Override files allow a jobs environment to be changed without modifying the jobs configuration file. Rules governing override files:

       · If a job is embodied with only a configuration file, the contents of this file define the job.

       · If an override files exists where there is no existing cofiguration file, the override file is ignored.

       · If both a configuration file and an override file exist for a job and both files are syntactically correct:

         · stanzas in the override file will take precedence over stanzas present in the corresponding configuration file.

         · stanzas in the override file which are not present in the corresponding configuration file will be honoured when the job runs.

       · If  both  a  configuration  file  and  an override file exist for a job and subsequently the override file is deleted, the configuration file is automatically reloaded with the effect that any
         changes introduced by the override file are undone and the configuration file alone now defines the job.

       · If both a configuration file and an override file exist for a job and subsequently the configuration file is deleted, a new instance of the job can no longer be started (since without a corre‐
         sponding configuration file an override file is ignored).

       · If both a configuration file and an override file exist for a job and any of the contents of the override file are invalid, the override file is ignored and only the contents of the configura‐
         tion file are considered.

   AppArmor support
       Upstart provides several stanzas for loading and switching to different AppArmor profiles. If AppArmor isn't enabled in the currently running kernel, the stanzas will be silently ignored.

       apparmor load PROFILE
              This stanza specifies an AppArmor profile to load into the Linux kernel at job start. The AppArmor profile will confine a main process automatically using path attachment, or manually  by
              using the apparmor switch stanza.  PROFILE must be an absolute path to a profile and a failure will occur if the file doesn't exist.

              apparmor load /etc/apparmor.d/usr.sbin.cupsd

       apparmor switch NAME
              This  stanza specifies the name of an AppArmor profile name to switch to before running the main process.  NAME must be the name of a profile already loaded into the running Linux kernel,
              and will result in a failure if not available.

              apparmor switch /usr/sbin/cupsd

   Miscellaneous
       kill signal SIGNAL
              Specifies the stopping signal, SIGTERM by default, a job's main process will receive when stopping the running job. The signal should be specified as a full name (for  example  "SIGTERM")
              or  a partial name (for example "TERM"). Note that it is possible to specify the signal as a number (for example "15") although this should be avoided if at all possible since signal num‐
              bers may differ between systems.

              kill signal INT

       reload signal SIGNAL
              Specifies the reload signal, SIGHUP by default, a job's main process will receive when reloading the running job. The signal should be specified as a full name (for example "SIGHUP") or a
              partial  name (for example "HUP"). Note that it is possible to specify the signal as a number (for example "1") although this should be avoided if at all possible since signal numbers may
              differ between systems.

              reload signal USR1

       kill timeout INTERVAL
              Specifies the interval between sending the job's main process the "stopping" (see above) and SIGKILL signals when stopping the running job. Default is 5 seconds.

       expect stop
              Specifies that the job's main process will raise the SIGSTOP signal to indicate that it is ready.  init(8) will wait for this signal before running the job's post-start script, or consid‐
              ering the job to be running.

              init(8) will send the process the SIGCONT signal to allow it to continue.

       expect daemon
              Specifies  that  the job's main process is a daemon, and will fork twice after being run.  init(8) will follow this daemonisation, and will wait for this to occur before running the job's
              post-start script or considering the job to be running.

              Without this stanza init(8) is unable to supervise daemon processes and will believe them to have stopped as soon as they daemonise on startup.

       expect fork
              Specifies that the job's main process will fork once after being run.  init(8) will follow this fork, and will wait for this to occur before running the job's post-start script or consid‐
              ering the job to be running.

              Without this stanza init(8) is unable to supervise forking processes and will believe them to have stopped as soon as they fork on startup.

RESTRICTIONS
       The use of symbolic links in job configuration file directories is not supported since it can lead to unpredictable behaviour resulting from broken or inaccessible links (such as would be caused
       by a link crossing a filesystem boundary to a filesystem that has not yet been mounted).

BUGS
       The and and or operators allowed with start on and stop on do not work intuitively: operands to the right of either operator are only evaluated once and state information is then discarded. This
       can lead to jobs with complex start on or stop on conditions not behaving as expected when restarted. For example, if a job encodes the following condition:

              start on A and (B or C)

       When  'A'  and  'B'  become true, the condition is satisfied so the job will be run. However, if the job ends and subsequently 'A' and 'C' become true, the job will not be re-run even though the
       condtion is satisfied.  Avoid using complex conditions with jobs which need to be restarted.

FILES
       /etc/init/*.conf
              System job configuration files.

       /etc/init/*.override
              System job override files.

       $HOME/.init/*.conf
              User job configuration files (deprecated).

       $HOME/.init/*.override
              User job override files.  (deprecated).

       $XDG_CONFIG_HOME/upstart/*.conf
              User session job configuration files. See User Session Mode for other locations.

       $XDG_CONFIG_HOME/upstart/*.override
              User session job override files. See User Session Mode for other locations.

       /var/log/upstart/*.log
              Default location of system job output logs.

       $XDG_CACHE_HOME/upstart/*.log
              Default location of user session job output logs.

       $XDG_RUNTIME_DIR/upstart/sessions/*.session
              Location of session files created when running in User Session mode.

AUTHOR
       Manual page written by Scott James Remnant <scott@netsplit.com> and James Hunt <james.hunt@canonical.com>.

REPORTING BUGS
       Report bugs at <https://launchpad.net/upstart/+bugs>

COPYRIGHT
       Copyright © 2009-2013 Canonical Ltd.
       This is free software; see the source for copying conditions.  There is NO warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

SEE ALSO
       apparmor(7), cgmanager(8), init(8), initctl(8), prctl(2), pty(7), sh(1), upstart-events(7).

Upstart                                                                                         2014-05-09                                                                                        init(5)
