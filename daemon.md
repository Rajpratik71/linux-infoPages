DAEMON.C(1)                                                        User Commands                                                       DAEMON.C(1)

NAME
       daemon - turns other processes into daemons

SYNOPSIS
        usage: daemon [options] [--] [cmd arg...]
        options:

        -h, --help                - Print a help message then exit
        -V, --version             - Print a version message then exit
        -v, --verbose[=level]     - Set the verbosity level
        -d, --debug[=level]       - Set the debugging level

        -C, --config=path         - Specify the system configuration file
        -N, --noconfig            - Bypass the system configuration file
        -n, --name=name           - Guarantee a single named instance
        -X, --command=cmd         - Specify the client command as an option
        -P, --pidfiles=/dir       - Override standard pidfile location
        -F, --pidfile=/path       - Override standard pidfile name and location

        -u, --user=user[:[group]] - Run the client as user[:group]
        -R, --chroot=path         - Run the client with path as root
        -D, --chdir=path          - Run the client in directory path
        -m, --umask=umask         - Run the client with the given umask
        -e, --env="var=val"       - Set a client environment variable
        -i, --inherit             - Inherit environment variables
        -U, --unsafe              - Allow execution of unsafe executable
        -S, --safe                - Deny execution of unsafe executable
        -c, --core                - Allow core file generation

        -r, --respawn             - Respawn the client when it terminates
        -a, --acceptable=#        - Minimum acceptable client duration (seconds)
        -A, --attempts=#          - Respawn # times on error before delay
        -L, --delay=#             - Delay between spawn attempt bursts (seconds)
        -M, --limit=#             - Maximum number of spawn attempt bursts
            --idiot               - Idiot mode (trust root with the above)

        -f, --foreground          - Run the client in the foreground
        -p, --pty[=noecho]        - Allocate a pseudo terminal for the client

        -l, --errlog=spec         - Send daemon's error output to syslog or file
        -b, --dbglog=spec         - Send daemon's debug output to syslog or file
        -o, --output=spec         - Send client's output to syslog or file
        -O, --stdout=spec         - Send client's stdout to syslog or file
        -E, --stderr=spec         - Send client's stderr to syslog or file

            --running             - Check if a named daemon is running
            --restart             - Restart a named daemon client
            --stop                - Terminate a named daemon process

DESCRIPTION
       daemon(1) turns other processes into daemons. There are many tasks that need to be performed to correctly set up a daemon process. This can
       be tedious. daemon performs these tasks for other processes.

       The preparatory tasks that daemon performs for other processes are:

       ·   First revoke any setuid or setgid privileges that daemon may have been installed with (by system administrators who laugh in the face
           of danger).

       ·   Process command line options.

       ·   Change the root directory if the --chroot option was supplied.

       ·   Change the process uid and gid if the --user option was supplied. Only root can use this option. Note that the uid of daemon itself is
           changed, rather than just changing the uid of the client process.

       ·   Read the system configuration file (/etc/daemon.conf by default, or specified by the --config option) unless the --noconfig option was
           supplied. Then read the user's configuration file (~/.daemonrc), if any.  Generic options are processed first, then options specific to
           the daemon with the given name. Note: The root directory and the user must be set before access to the configuration file can be
           attempted so neither --chroot nor --user options may appear in the configuration file.

       ·   Disable core file generation to prevent leaking sensitive information in daemons run by root (unless the --core option was supplied).

       ·   Become a daemon process:

           ·   If daemon was not invoked by init(8) or inetd(8):

               ·   Background the process to lose process group leadership.

               ·   Start a new process session.

               ·   Under SVR4, background the process again to lose process session leadership. This prevents the process from ever gaining a
                   controlling terminal. This only happens when SVR4 is defined and NO_EXTRA_SVR4_FORK is not defined when libslack(3) is
                   compiled. Before doing this, ignore SIGHUP because when the session leader terminates, all processes in the foreground process
                   group are sent a SIGHUP signal (apparently). Note that this code may not execute (e.g. when started by init(8) or inetd(8) or
                   when either SVR4 was not defined or NO_EXTRA_SVR4_FORK was defined when libslack(3) was compiled). This means that the client
                   can't make any assumptions about the SIGHUP handler.

           ·   Change directory to the root directory so as not to hamper umounts.

           ·   Clear the umask to enable explicit file creation modes.

           ·   Close all open file descriptors. If daemon was invoked by inetd(8), stdin, stdout and stderr are left open since they are open to a
               socket.

           ·   Open stdin, stdout and stderr to /dev/null in case something requires them to be open. Of course, this is not done if daemon was
               invoked by inetd(8).

           ·   If the --name option was supplied, create and lock a file containing the process id of the daemon process. The presence of this
               locked file prevents two instances of a daemon with the same name from running at the same time. The standard location of the
               pidfile is /var/run for root or /tmp for ordinary users. If the --pidfiles option was supplied, its argument specifies the
               directory in which the pidfile will be placed.  If the --pidfile option was supplied, its argument specifies the name of the
               pidfile and the directory in which it will be placed.

       ·   If the --umask option was supplied, set the umask to its argument.  Otherwise, set the umask to 022 to prevent clients from
           accidentally creating group or world writable files.

       ·   Set the current directory if the --chdir option was supplied.

       ·   Spawn the client command and wait for it to terminate. The client command may be specified as command line arguments or as the argument
           of the --command option. If both the --command option and command line arguments are present, the client command is the result of
           appending the command line arguments to the argument of the --command option.

       ·   If the --syslog, --outlog and/or --errlog options were supplied, the client's standard output and/or standard error are captured by
           daemon and sent to the respective syslog destinations.

       ·   When the client terminates, daemon respawns it if the --respawn option was supplied. If the client ran for less than 300 seconds (or
           the value of the --acceptable option), then daemon sees this as an error. It will attempt to restart the client up to five times (or
           the value of the --attempts option) before waiting for 300 seconds (or the value of the --delay option). This gives the administrator
           the chance to correct whatever is preventing the client from running without overloading system resources. If the --limit option was
           supplied, daemon terminates after the specified number of spawn attempt bursts. The default is zero which means never give up, never
           surrender.

           When the client terminates and the --respawn option wasn't supplied, daemon terminates.

       ·   If daemon receives a SIGTERM signal, it propagates the signal to the client and then terminates.

       ·   If daemon receives a SIGUSR1 signal (from another invocation of daemon supplied with the --restart option), it sends a SIGTERM signal
           to the client. If started with the --respawn option, the client process will be restarted after it is killed by the SIGTERM signal.

       ·   If the --foreground option was supplied, the client process is run as a foreground process and is not turned into a daemon. If daemon
           is connected to a terminal, so will the client process. If daemon is not connected to a terminal but the client needs to be connected
           to a terminal, use the --pty option.

OPTIONS
       -h, --help
           Display a help message and exit.

       -V, --version
           Display a version message and exit.

       -v[level], --verbose[=level]
           Set the message verbosity level to level (or 1 if level is not supplied). daemon does not have any verbose messages so this has no
           effect unless the --running option is supplied.

       -d[level], --debug[=level]
           Set the debug message level to level (or 1 if level is not supplied).  Level 1 traces high level function calls. Level 2 traces lower
           level function calls and shows configuration information. Level 3 adds environment variables. Level 9 adds every return value from
           select(2) to the output.  Debug messages are sent to the destination specified by the --dbglog option (by default, the syslog(3)
           facility, daemon.debug).

       -C path, --config=path
           Specify the configuration file to use. By default, /etc/daemon.conf is the configuration file if it exists and is not group or world
           writable and does not exist in a group or world writable directory. The configuration file lets you predefine options that apply to all
           clients and to specifically named clients.

       -N, --noconfig
           Bypass the system configuration file, /etc/daemon.conf. Only the user's ~/.daemonrc configuration file will be read (if it exists).

       -n name, --name=name
           Create and lock a pid file (/var/run/name.pid), ensuring that only one daemon with the given name is active at the same time.

       -X cmd, --command=cmd
           Specify the client command as an option. If a command is specified along with its name in the configuration file, then daemons can be
           started merely by mentioning their name:

               daemon --name ftumpch

           Note: Specifying the client command in the configuration file means that no shell features are available (i.e. no meta characters).

       -P /dir, --pidfiles=/dir
           Override the standard pidfile location. The standard pidfile location is user dependent: root's pidfiles live in /var/run. Normal
           users' pidfiles live in /tmp. This option can only be used with the --name option. Use this option if these locations are unacceptable
           but make sure you don't forget where you put your pidfiles. This option is best used in configuration files or in shell scripts, not on
           the command line.

       -F /path, --pidfile=/path
           Override the standard pidfile name and location. The standard pidfile location is described immediately above. The standard pidfile
           name is the argument of the --name option followed by .pid. Use this option if the standard pidfile name and location are unacceptable
           but make sure you don't forget where you put your pidfile. This option should only be used in configuration files or in shell scripts,
           not on the command line.

       -u user[:[group]], --user=user[:[group]]
           Run the client as a different user (and group). This only works for root.  If the argument includes a :group specifier, daemon will
           assume the specified group and no other. Otherwise, daemon will assume all groups that the specified user is in. For backwards
           compatibility, "." may be used instead of ":" to separate the user and group but since "." may appear in user and group names,
           ambiguities can arise such as using --user=u.g with users u and u.g and group g. With such an ambiguity, daemon will assume the user u
           and group g. Use --user=u.g: instead for the other interpretation.

       -R path, --chroot=path
           Change the root directory to path before running the client. On some systems, only root can do this. Note that the path to the client
           program and to the configuration file (if any) must be relative to the new root path.

       -D path, --chdir=path
           Change the directory to path before running the client.

       -m umask, --umask=umask
           Change the umask to umask before running the client. umask must be a valid octal mode. The default umask is 022.

       -e var=val, --env=var=val
           Set an environment variable for the client process. This option can be used any number of times. If it is used, only the supplied
           environment variables are passed to the client process. Otherwise, the client process inherits the current set of environment
           variables.

       -i, --inherit
           Explicitly inherit environment variables. This is only needed when the --env option is used. When this option is used, the --env option
           adds to the inherited environment, rather than replacing it.

       -U, --unsafe
           Allow reading an unsafe configuration file and execution of an unsafe executable. A configuration file or executable is unsafe if it is
           group or world writable or is in a directory that is group or world writable (following symbolic links). If an executable is a script
           interpreted by another executable, then it is considered unsafe if the interpreter is unsafe. If the interpreter is /usr/bin/env (with
           an argument that is a command name to be searched for in $PATH), then that command must be safe. By default, daemon(1) will refuse to
           read an unsafe configuration file or to execute an unsafe executable when run by root. This option overrides that behaviour and hence
           should never be used.

       -S, --safe
           Deny reading an unsafe configuration file and execution of an unsafe executable. By default, daemon(1) will allow reading an unsafe
           configuration file and execution of an unsafe executable when run by ordinary users. This option overrides that behaviour.

       -c, --core
           Allow the client to create a core file. This should only be used for debugging as it could lead to security holes in daemons run by
           root.

       -r, --respawn
           Respawn the client when it terminates.

       -a #, --acceptable=#
           Specify the minimum acceptable duration in seconds of a client process. The default value is 300 seconds. It cannot be set to less than
           10 seconds except by root when used in conjunction with the --idiot option. This option can only be used with the --respawn option.

           less than this, it is considered to have failed.

       -A #, --attempts=#
           Number of attempts to spawn before delaying. The default value is 5. It cannot be set to more than 100 attempts except by root when
           used in conjunction with the --idiot option. This option can only be used with the --respawn option.

       -L #, --delay=#
           Delay in seconds between each burst of spawn attempts. The default value is 300 seconds. It cannot be set to less than 10 seconds
           except by root when used in conjunction with the --idiot option. This option can only be used with the --respawn option.

       -M #, ---limit=#
           Limit the number of spawn attempt bursts. The default value is zero which means no limit. This option can only be used with the
           --respawn option.

       --idiot
           Turn on idiot mode in which daemon will not enforce the minimum or maximum values normally imposed on the --acceptable, --attempts and
           --delay option arguments. The --idiot option must appear before any of these options. Only the root user may use this option because it
           can turn a slight misconfiguration into a lot of wasted CPU effort and log messages.

       -f, --foreground
           Run the client in the foreground. The client is not turned into a daemon.

       -p[noecho], --pty[=noecho]
           Connect the client to a pseudo terminal. This option can only be used with the --foreground option. This is the default when the
           --foreground option is supplied and daemon's standard input is connected to a terminal. This option is only necessary when the client
           process must be connected to a controlling terminal but daemon itself has been run without a controlling terminal (e.g. from cron(8) or
           a pipeline).

           If the noecho argument is supplied with this option, the client's side of the pseudo terminal will be set to noecho mode. Use this only
           if there really is a terminal involved and input is being echoed twice.

       -l spec, --errlog=spec
           Send daemon's standard output and error to the syslog destination or file specified by spec. If spec is of the form
           "facility.priority", then output is sent to syslog(3). Otherwise, output is appended to the file whose path is given in spec. By
           default, output is sent to daemon.err.

       -b spec, --dbglog=spec
           Send daemon's debug output to the syslog destination or file specified by spec. If spec is of the form "facility.priority", then output
           is sent to syslog(3). Otherwise, output is appended to the file whose path is given in spec. By default, output is sent to
           daemon.debug.

       -o spec, --output=spec
           Capture the client's standard output and error and send it to the syslog destination or file specified by spec. If spec is of the form
           "facility.priority", then output is sent to syslog(3). Otherwise, output is appended to the file whose path is given in spec. By
           default, output is discarded unless the --foreground option is present. In this case, the client's stdout and stderr are propagated to
           daemon's stdout and stderr respectively.

       -O spec, --stdout=spec
           Capture the client's standard output and send it to the syslog destination or file specified by spec. If spec is of the form
           "facility.priority", then output is sent to syslog(3). Otherwise, stdout is appended to the file whose path is given in spec. By
           default, stdout is discarded unless the --foreground option is present, in which case, the client's stdout is propagated to daemon's
           stdout.

       -E spec, --stderr=spec
           Capture the client's standard error and send it to the syslog destination specified by spec. If spec is of the form
           "facility.priority", then stderr is sent to syslog(3). Otherwise, stderr is appended to the file whose path is given in spec. By
           default, stderr is discarded unless the --foreground option is present, in this case, the client's stderr is propagated to daemon's
           stderr.

       --running
           Check whether or not a named daemon is running, then exit(3) with EXIT_SUCCESS if the named daemon is running or EXIT_FAILURE if it
           isn't. If the --verbose option is supplied, print a message before exiting. This option can only be used with the --name option. Note
           that the --chroot, --user, --name, --pidfiles and --pidfile (and possibly --config) options must be the same as for the target daemon.
           Note that the --running option must appear before any --pidfile or --pidfiles option when checking if another user's daemon is running
           otherwise you might get an error about the pidfile directory not being writable.

       --restart
           Instruct a named daemon to terminate and restart its client process. This option can only be used with the --name option. Note that the
           --chroot, --user, --name, --pidfiles and --pidfile (and possibly --config) options must be the same as for the target daemon.

       --stop
           Stop a named daemon then exit(3). This option can only be used with the --name option. Note that the --chroot, --user, --name,
           --pidfiles and --pidfile (and possibly --config) options must be the same as for the target daemon.

       As with all other programs, a -- argument signifies the end of options.  Any options that appear on the command line after -- are part of
       the client command.

FILES
       /etc/daemon.conf, ~/.daemonrc - define default options

       Each line of the configuration file consists of a client name or '*', followed by whitespace, followed by a comma separated list of
       options. Blank lines and comments ('#' to end of the line) are ignored. Lines may be continued with a '\' character at the end of the line.

       For example:

           *       errlog=daemon.err,output=local0.err,core
           test1   syslog=local0.debug,debug=9,verbose=9,respawn
           test2   syslog=local0.debug,debug=9,verbose=9,respawn

       The command line options are processed first to look for a --config option. If no --config option was supplied, the default file,
       /etc/daemon.conf, is used. If the user has their own configuration file (~/.daemonrc) it is also used. If the configuration files contain
       any generic ('*') entries, their options are applied in order of appearance.  If the --name option was supplied and the configuration files
       contain any entries with the given name, their options are then applied in order of appearance. Finally, the command line options are
       applied again. This ensures that any generic options apply to all clients by default. Client specific options override generic options.
       User options override system wide options. Command line options override everything else.

       Note that the configuration files are not opened and read until after any --chroot and/or --user command line options are processed. This
       means that the configuration file paths and the client's file path must be relative to the --chroot argument. It also means that the
       configuration files and the client executable must be readable/executable by the user specified by the --user argument. It also means that
       the --chroot and --user options must not appear in the configuration file. Also note that the --name must not appear in the configuration
       file either.

BUGS
       If you specify (in a configuration file) that all clients allow core file generation, there is no way to countermand that for any client
       (without using an alternative configuration file). So don't do that. The same applies to respawning and foreground.

       It is possible for the client process to obtain a controlling terminal under BSD. If anything calls open(2) on a terminal device without
       the O_NOCTTY flag, the process doing so will obtain a controlling terminal and then be susceptible to unintended termination by a SIGHUP.

       Clients run in the foreground with a pseudo terminal don't respond to job control (i.e. suspending with Control-Z doesn't work). This is
       because the client belongs to an orphaned process group (it starts in its own process session) so the kernel won't send it SIGSTOP signals.
       However, if the client is a shell that supports job control, it's subprocesses can be suspended.

       Clients can only be restarted if they were started with the --respawn option. Using --restart on a non-respawning daemon client is
       equivalent to using --stop.

MAILING LISTS
       The following mailing lists exist for daemon related discussion:

        daemon-announce@libslack.org - Announcements
        daemon-users@libslack.org    - User forum
        daemon-dev@libslack.org      - Development forum

       To subscribe to any of these mailing lists, send a mail message to listname-request@libslack.org with subscribe as the message body.  e.g.

        $ echo subscribe | mail daemon-announce-request@libslack.org
        $ echo subscribe | mail daemon-users-request@libslack.org
        $ echo subscribe | mail daemon-dev-request@libslack.org

       Or you can send a mail message to majordomo@libslack.org with subscribe listname in the message body. This way, you can subscribe to
       multiple lists at the same time.  e.g.

        $ mail majordomo@libslack.org
        subscribe daemon-announce
        subscribe daemon-users
        subscribe daemon-dev
        .

       A digest version of each mailing list is also available. Subscribe to digests as above but append -digest to the listname.

SEE ALSO
       libslack(3), daemon(3), coproc(3), pseudo(3), init(8), inetd(8), fork(2), umask(2), setsid(2), chdir(2), chroot(2), setrlimit(2),
       setgid(2), setuid(2), setgroups(2), initgroups(3), syslog(3), kill(2)

AUTHOR
       20100612 raf <raf@raf.org>

perl v5.10.1                                                        2010-06-13                                                         DAEMON.C(1)
DAEMON(3)                                                    Linux Programmer's Manual                                                   DAEMON(3)

NAME
       daemon - run in the background

SYNOPSIS
       #include <unistd.h>

       int daemon(int nochdir, int noclose);

   Feature Test Macro Requirements for glibc (see feature_test_macros(7)):

       daemon(): _BSD_SOURCE || (_XOPEN_SOURCE && _XOPEN_SOURCE < 500)

DESCRIPTION
       The  daemon()  function is for programs wishing to detach themselves from the controlling terminal and run in the background as system dae‐
       mons.

       If nochdir is zero, daemon() changes the process's current working directory to the root directory ("/"); otherwise,  the  current  working
       directory is left unchanged.

       If  noclose  is zero, daemon() redirects standard input, standard output and standard error to /dev/null; otherwise, no changes are made to
       these file descriptors.

RETURN VALUE
       (This function forks, and if the fork(2) succeeds, the parent calls _exit(2), so that further errors are seen by the child only.)  On  suc‐
       cess daemon() returns zero.  If an error occurs, daemon() returns -1 and sets errno to any of the errors specified for the fork(2) and set‐
       sid(2).

ATTRIBUTES
       For an explanation of the terms used in this section, see attributes(7).

       ┌──────────┬───────────────┬─────────┐
       │Interface │ Attribute     │ Value   │
       ├──────────┼───────────────┼─────────┤
       │daemon()  │ Thread safety │ MT-Safe │
       └──────────┴───────────────┴─────────┘
CONFORMING TO
       Not in POSIX.1.  A similar function appears on the BSDs.  The daemon() function first appeared in 4.4BSD.

NOTES
       The glibc implementation can also return -1 when /dev/null exists but is not a character device with the expected major and minor  numbers.
       In this case, errno need not be set.

BUGS
       The  GNU  C  library implementation of this function was taken from BSD, and does not employ the double-fork technique (i.e., fork(2), set‐
       sid(2), fork(2)) that is necessary to ensure that the resulting daemon process is not a session leader.  Instead, the resulting daemon is a
       session  leader.   On  systems  that  follow  System  V semantics (e.g., Linux), this means that if the daemon opens a terminal that is not
       already a controlling terminal for another session, then that terminal will inadvertently become the controlling terminal for the daemon.

SEE ALSO
       fork(2), setsid(2)

COLOPHON
       This page is part of release 4.04 of the Linux man-pages project.  A description of the project, information about reporting bugs, and  the
       latest version of this page, can be found at http://www.kernel.org/doc/man-pages/.

GNU                                                                 2015-12-05                                                           DAEMON(3)
DAEMON(7)                                                             daemon                                                             DAEMON(7)

NAME
       daemon - Writing and packaging system daemons

DESCRIPTION
       A daemon is a service process that runs in the background and supervises the system or provides functionality to other processes.
       Traditionally, daemons are implemented following a scheme originating in SysV Unix. Modern daemons should follow a simpler yet more
       powerful scheme (here called "new-style" daemons), as implemented by systemd(1). This manual page covers both schemes, and in particular
       includes recommendations for daemons that shall be included in the systemd init system.

   SysV Daemons
       When a traditional SysV daemon starts, it should execute the following steps as part of the initialization. Note that these steps are
       unnecessary for new-style daemons (see below), and should only be implemented if compatibility with SysV is essential.

        1. Close all open file descriptors except standard input, output, and error (i.e. the first three file descriptors 0, 1, 2). This ensures
           that no accidentally passed file descriptor stays around in the daemon process. On Linux, this is best implemented by iterating through
           /proc/self/fd, with a fallback of iterating from file descriptor 3 to the value returned by getrlimit() for RLIMIT_NOFILE.

        2. Reset all signal handlers to their default. This is best done by iterating through the available signals up to the limit of _NSIG and
           resetting them to SIG_DFL.

        3. Reset the signal mask using sigprocmask().

        4. Sanitize the environment block, removing or resetting environment variables that might negatively impact daemon runtime.

        5. Call fork(), to create a background process.

        6. In the child, call setsid() to detach from any terminal and create an independent session.

        7. In the child, call fork() again, to ensure that the daemon can never re-acquire a terminal again.

        8. Call exit() in the first child, so that only the second child (the actual daemon process) stays around. This ensures that the daemon
           process is re-parented to init/PID 1, as all daemons should be.

        9. In the daemon process, connect /dev/null to standard input, output, and error.

       10. In the daemon process, reset the umask to 0, so that the file modes passed to open(), mkdir() and suchlike directly control the access
           mode of the created files and directories.

       11. In the daemon process, change the current directory to the root directory (/), in order to avoid that the daemon involuntarily blocks
           mount points from being unmounted.

       12. In the daemon process, write the daemon PID (as returned by getpid()) to a PID file, for example /run/foobar.pid (for a hypothetical
           daemon "foobar") to ensure that the daemon cannot be started more than once. This must be implemented in race-free fashion so that the
           PID file is only updated when it is verified at the same time that the PID previously stored in the PID file no longer exists or
           belongs to a foreign process.

       13. In the daemon process, drop privileges, if possible and applicable.

       14. From the daemon process, notify the original process started that initialization is complete. This can be implemented via an unnamed
           pipe or similar communication channel that is created before the first fork() and hence available in both the original and the daemon
           process.

       15. Call exit() in the original process. The process that invoked the daemon must be able to rely on that this exit() happens after
           initialization is complete and all external communication channels are established and accessible.

       The BSD daemon() function should not be used, as it implements only a subset of these steps.

       A daemon that needs to provide compatibility with SysV systems should implement the scheme pointed out above. However, it is recommended to
       make this behavior optional and configurable via a command line argument to ease debugging as well as to simplify integration into systems
       using systemd.

   New-Style Daemons
       Modern services for Linux should be implemented as new-style daemons. This makes it easier to supervise and control them at runtime and
       simplifies their implementation.

       For developing a new-style daemon, none of the initialization steps recommended for SysV daemons need to be implemented. New-style init
       systems such as systemd make all of them redundant. Moreover, since some of these steps interfere with process monitoring, file descriptor
       passing and other functionality of the init system, it is recommended not to execute them when run as new-style service.

       Note that new-style init systems guarantee execution of daemon processes in a clean process context: it is guaranteed that the environment
       block is sanitized, that the signal handlers and mask is reset and that no left-over file descriptors are passed. Daemons will be executed
       in their own session, with standard input/output/error connected to /dev/null unless otherwise configured. The umask is reset.

       It is recommended for new-style daemons to implement the following:

        1. If SIGTERM is received, shut down the daemon and exit cleanly.

        2. If SIGHUP is received, reload the configuration files, if this applies.

        3. Provide a correct exit code from the main daemon process, as this is used by the init system to detect service errors and problems. It
           is recommended to follow the exit code scheme as defined in the LSB recommendations for SysV init scripts[1].

        4. If possible and applicable, expose the daemon's control interface via the D-Bus IPC system and grab a bus name as last step of
           initialization.

        5. For integration in systemd, provide a .service unit file that carries information about starting, stopping and otherwise maintaining
           the daemon. See systemd.service(5) for details.

        6. As much as possible, rely on the init system's functionality to limit the access of the daemon to files, services and other resources,
           i.e. in the case of systemd, rely on systemd's resource limit control instead of implementing your own, rely on systemd's privilege
           dropping code instead of implementing it in the daemon, and similar. See systemd.exec(5) for the available controls.

        7. If D-Bus is used, make your daemon bus-activatable by supplying a D-Bus service activation configuration file. This has multiple
           advantages: your daemon may be started lazily on-demand; it may be started in parallel to other daemons requiring it -- which maximizes
           parallelization and boot-up speed; your daemon can be restarted on failure without losing any bus requests, as the bus queues requests
           for activatable services. See below for details.

        8. If your daemon provides services to other local processes or remote clients via a socket, it should be made socket-activatable
           following the scheme pointed out below. Like D-Bus activation, this enables on-demand starting of services as well as it allows
           improved parallelization of service start-up. Also, for state-less protocols (such as syslog, DNS), a daemon implementing socket-based
           activation can be restarted without losing a single request. See below for details.

        9. If applicable, a daemon should notify the init system about startup completion or status updates via the sd_notify(3) interface.

       10. Instead of using the syslog() call to log directly to the system syslog service, a new-style daemon may choose to simply log to
           standard error via fprintf(), which is then forwarded to syslog by the init system. If log levels are necessary, these can be encoded
           by prefixing individual log lines with strings like "<4>" (for log level 4 "WARNING" in the syslog priority scheme), following a
           similar style as the Linux kernel's printk() level system. For details, see sd-daemon(3) and systemd.exec(5).

       These recommendations are similar but not identical to the Apple MacOS X Daemon Requirements[2].

ACTIVATION
       New-style init systems provide multiple additional mechanisms to activate services, as detailed below. It is common that services are
       configured to be activated via more than one mechanism at the same time. An example for systemd: bluetoothd.service might get activated
       either when Bluetooth hardware is plugged in, or when an application accesses its programming interfaces via D-Bus. Or, a print server
       daemon might get activated when traffic arrives at an IPP port, or when a printer is plugged in, or when a file is queued in the printer
       spool directory. Even for services that are intended to be started on system bootup unconditionally, it is a good idea to implement some of
       the various activation schemes outlined below, in order to maximize parallelization. If a daemon implements a D-Bus service or listening
       socket, implementing the full bus and socket activation scheme allows starting of the daemon with its clients in parallel (which speeds up
       boot-up), since all its communication channels are established already, and no request is lost because client requests will be queued by
       the bus system (in case of D-Bus) or the kernel (in case of sockets) until the activation is completed.

   Activation on Boot
       Old-style daemons are usually activated exclusively on boot (and manually by the administrator) via SysV init scripts, as detailed in the
       LSB Linux Standard Base Core Specification[1]. This method of activation is supported ubiquitously on Linux init systems, both old-style
       and new-style systems. Among other issues, SysV init scripts have the disadvantage of involving shell scripts in the boot process.
       New-style init systems generally employ updated versions of activation, both during boot-up and during runtime and using more minimal
       service description files.

       In systemd, if the developer or administrator wants to make sure that a service or other unit is activated automatically on boot, it is
       recommended to place a symlink to the unit file in the .wants/ directory of either multi-user.target or graphical.target, which are
       normally used as boot targets at system startup. See systemd.unit(5) for details about the .wants/ directories, and systemd.special(7) for
       details about the two boot targets.

   Socket-Based Activation
       In order to maximize the possible parallelization and robustness and simplify configuration and development, it is recommended for all
       new-style daemons that communicate via listening sockets to employ socket-based activation. In a socket-based activation scheme, the
       creation and binding of the listening socket as primary communication channel of daemons to local (and sometimes remote) clients is moved
       out of the daemon code and into the init system. Based on per-daemon configuration, the init system installs the sockets and then hands
       them off to the spawned process as soon as the respective daemon is to be started. Optionally, activation of the service can be delayed
       until the first inbound traffic arrives at the socket to implement on-demand activation of daemons. However, the primary advantage of this
       scheme is that all providers and all consumers of the sockets can be started in parallel as soon as all sockets are established. In
       addition to that, daemons can be restarted with losing only a minimal number of client transactions, or even any client request at all (the
       latter is particularly true for state-less protocols, such as DNS or syslog), because the socket stays bound and accessible during the
       restart, and all requests are queued while the daemon cannot process them.

       New-style daemons which support socket activation must be able to receive their sockets from the init system instead of creating and
       binding them themselves. For details about the programming interfaces for this scheme provided by systemd, see sd_listen_fds(3) and sd-
       daemon(3). For details about porting existing daemons to socket-based activation, see below. With minimal effort, it is possible to
       implement socket-based activation in addition to traditional internal socket creation in the same codebase in order to support both
       new-style and old-style init systems from the same daemon binary.

       systemd implements socket-based activation via .socket units, which are described in systemd.socket(5). When configuring socket units for
       socket-based activation, it is essential that all listening sockets are pulled in by the special target unit sockets.target. It is
       recommended to place a WantedBy=sockets.target directive in the "[Install]" section to automatically add such a dependency on installation
       of a socket unit. Unless DefaultDependencies=no is set, the necessary ordering dependencies are implicitly created for all socket units.
       For more information about sockets.target, see systemd.special(7). It is not necessary or recommended to place any additional dependencies
       on socket units (for example from multi-user.target or suchlike) when one is installed in sockets.target.

   Bus-Based Activation
       When the D-Bus IPC system is used for communication with clients, new-style daemons should employ bus activation so that they are
       automatically activated when a client application accesses their IPC interfaces. This is configured in D-Bus service files (not to be
       confused with systemd service unit files!). To ensure that D-Bus uses systemd to start-up and maintain the daemon, use the SystemdService=
       directive in these service files to configure the matching systemd service for a D-Bus service. e.g.: For a D-Bus service whose D-Bus
       activation file is named org.freedesktop.RealtimeKit.service, make sure to set SystemdService=rtkit-daemon.service in that file to bind it
       to the systemd service rtkit-daemon.service. This is needed to make sure that the daemon is started in a race-free fashion when activated
       via multiple mechanisms simultaneously.

   Device-Based Activation
       Often, daemons that manage a particular type of hardware should be activated only when the hardware of the respective kind is plugged in or
       otherwise becomes available. In a new-style init system, it is possible to bind activation to hardware plug/unplug events. In systemd,
       kernel devices appearing in the sysfs/udev device tree can be exposed as units if they are tagged with the string "systemd". Like any other
       kind of unit, they may then pull in other units when activated (i.e. plugged in) and thus implement device-based activation. systemd
       dependencies may be encoded in the udev database via the SYSTEMD_WANTS= property. See systemd.device(5) for details. Often, it is nicer to
       pull in services from devices only indirectly via dedicated targets. Example: Instead of pulling in bluetoothd.service from all the various
       bluetooth dongles and other hardware available, pull in bluetooth.target from them and bluetoothd.service from that target. This provides
       for nicer abstraction and gives administrators the option to enable bluetoothd.service via controlling a bluetooth.target.wants/ symlink
       uniformly with a command like enable of systemctl(1) instead of manipulating the udev ruleset.

   Path-Based Activation
       Often, runtime of daemons processing spool files or directories (such as a printing system) can be delayed until these file system objects
       change state, or become non-empty. New-style init systems provide a way to bind service activation to file system changes. systemd
       implements this scheme via path-based activation configured in .path units, as outlined in systemd.path(5).

   Timer-Based Activation
       Some daemons that implement clean-up jobs that are intended to be executed in regular intervals benefit from timer-based activation. In
       systemd, this is implemented via .timer units, as described in systemd.timer(5).

   Other Forms of Activation
       Other forms of activation have been suggested and implemented in some systems. However, there are often simpler or better alternatives, or
       they can be put together of combinations of the schemes above. Example: Sometimes, it appears useful to start daemons or .socket units when
       a specific IP address is configured on a network interface, because network sockets shall be bound to the address. However, an alternative
       to implement this is by utilizing the Linux IP_FREEBIND socket option, as accessible via FreeBind=yes in systemd socket files (see
       systemd.socket(5) for details). This option, when enabled, allows sockets to be bound to a non-local, not configured IP address, and hence
       allows bindings to a particular IP address before it actually becomes available, making such an explicit dependency to the configured
       address redundant. Another often suggested trigger for service activation is low system load. However, here too, a more convincing approach
       might be to make proper use of features of the operating system, in particular, the CPU or I/O scheduler of Linux. Instead of scheduling
       jobs from userspace based on monitoring the OS scheduler, it is advisable to leave the scheduling of processes to the OS scheduler itself.
       systemd provides fine-grained access to the CPU and I/O schedulers. If a process executed by the init system shall not negatively impact
       the amount of CPU or I/O bandwidth available to other processes, it should be configured with CPUSchedulingPolicy=idle and/or
       IOSchedulingClass=idle. Optionally, this may be combined with timer-based activation to schedule background jobs during runtime and with
       minimal impact on the system, and remove it from the boot phase itself.

INTEGRATION WITH SYSTEMD
   Writing Systemd Unit Files
       When writing systemd unit files, it is recommended to consider the following suggestions:

        1. If possible, do not use the Type=forking setting in service files. But if you do, make sure to set the PID file path using PIDFile=.
           See systemd.service(5) for details.

        2. If your daemon registers a D-Bus name on the bus, make sure to use Type=dbus in the service file if possible.

        3. Make sure to set a good human-readable description string with Description=.

        4. Do not disable DefaultDependencies=, unless you really know what you do and your unit is involved in early boot or late system
           shutdown.

        5. Normally, little if any dependencies should need to be defined explicitly. However, if you do configure explicit dependencies, only
           refer to unit names listed on systemd.special(7) or names introduced by your own package to keep the unit file operating
           system-independent.

        6. Make sure to include an "[Install]" section including installation information for the unit file. See systemd.unit(5) for details. To
           activate your service on boot, make sure to add a WantedBy=multi-user.target or WantedBy=graphical.target directive. To activate your
           socket on boot, make sure to add WantedBy=sockets.target. Usually, you also want to make sure that when your service is installed, your
           socket is installed too, hence add Also=foo.socket in your service file foo.service, for a hypothetical program foo.

   Installing Systemd Service Files
       At the build installation time (e.g.  make install during package build), packages are recommended to install their systemd unit files in
       the directory returned by pkg-config systemd --variable=systemdsystemunitdir (for system services) or pkg-config systemd
       --variable=systemduserunitdir (for user services). This will make the services available in the system on explicit request but not activate
       them automatically during boot. Optionally, during package installation (e.g.  rpm -i by the administrator), symlinks should be created in
       the systemd configuration directories via the enable command of the systemctl(1) tool to activate them automatically on boot.

       Packages using autoconf(1) are recommended to use a configure script excerpt like the following to determine the unit installation path
       during source configuration:

           PKG_PROG_PKG_CONFIG
           AC_ARG_WITH([systemdsystemunitdir],
                [AS_HELP_STRING([--with-systemdsystemunitdir=DIR], [Directory for systemd service files])],,
                [with_systemdsystemunitdir=auto])
           AS_IF([test "x$with_systemdsystemunitdir" = "xyes" -o "x$with_systemdsystemunitdir" = "xauto"], [
                def_systemdsystemunitdir=$($PKG_CONFIG --variable=systemdsystemunitdir systemd)

                AS_IF([test "x$def_systemdsystemunitdir" = "x"],
              [AS_IF([test "x$with_systemdsystemunitdir" = "xyes"],
               [AC_MSG_ERROR([systemd support requested but pkg-config unable to query systemd package])])
               with_systemdsystemunitdir=no],
              [with_systemdsystemunitdir="$def_systemdsystemunitdir"])])
           AS_IF([test "x$with_systemdsystemunitdir" != "xno"],
                 [AC_SUBST([systemdsystemunitdir], [$with_systemdsystemunitdir])])
           AM_CONDITIONAL([HAVE_SYSTEMD], [test "x$with_systemdsystemunitdir" != "xno"])

       This snippet allows automatic installation of the unit files on systemd machines, and optionally allows their installation even on machines
       lacking systemd. (Modification of this snippet for the user unit directory is left as an exercise for the reader.)

       Additionally, to ensure that make distcheck continues to work, it is recommended to add the following to the top-level Makefile.am file in
       automake(1)-based projects:

           DISTCHECK_CONFIGURE_FLAGS = \
             --with-systemdsystemunitdir=$$dc_install_base/$(systemdsystemunitdir)

       Finally, unit files should be installed in the system with an automake excerpt like the following:

           if HAVE_SYSTEMD
           systemdsystemunit_DATA = \
             foobar.socket \
             foobar.service
           endif

       In the rpm(8) .spec file, use snippets like the following to enable/disable the service during installation/deinstallation. This makes use
       of the RPM macros shipped along systemd. Consult the packaging guidelines of your distribution for details and the equivalent for other
       package managers.

       At the top of the file:

           BuildRequires: systemd
           %{?systemd_requires}

       And as scriptlets, further down:

           %post
           %systemd_post foobar.service foobar.socket

           %preun
           %systemd_preun foobar.service foobar.socket

           %postun
           %systemd_postun

       If the service shall be restarted during upgrades, replace the "%postun" scriptlet above with the following:

           %postun
           %systemd_postun_with_restart foobar.service

       Note that "%systemd_post" and "%systemd_preun" expect the names of all units that are installed/removed as arguments, separated by spaces.
       "%systemd_postun" expects no arguments.  "%systemd_postun_with_restart" expects the units to restart as arguments.

       To facilitate upgrades from a package version that shipped only SysV init scripts to a package version that ships both a SysV init script
       and a native systemd service file, use a fragment like the following:

           %triggerun -- foobar < 0.47.11-1
           if /sbin/chkconfig --level 5 foobar ; then
             /bin/systemctl --no-reload enable foobar.service foobar.socket >/dev/null 2>&1 || :
           fi

       Where 0.47.11-1 is the first package version that includes the native unit file. This fragment will ensure that the first time the unit
       file is installed, it will be enabled if and only if the SysV init script is enabled, thus making sure that the enable status is not
       changed. Note that chkconfig is a command specific to Fedora which can be used to check whether a SysV init script is enabled. Other
       operating systems will have to use different commands here.

PORTING EXISTING DAEMONS
       Since new-style init systems such as systemd are compatible with traditional SysV init systems, it is not strictly necessary to port
       existing daemons to the new style. However, doing so offers additional functionality to the daemons as well as simplifying integration into
       new-style init systems.

       To port an existing SysV compatible daemon, the following steps are recommended:

        1. If not already implemented, add an optional command line switch to the daemon to disable daemonization. This is useful not only for
           using the daemon in new-style init systems, but also to ease debugging.

        2. If the daemon offers interfaces to other software running on the local system via local AF_UNIX sockets, consider implementing
           socket-based activation (see above). Usually, a minimal patch is sufficient to implement this: Extend the socket creation in the daemon
           code so that sd_listen_fds(3) is checked for already passed sockets first. If sockets are passed (i.e. when sd_listen_fds() returns a
           positive value), skip the socket creation step and use the passed sockets. Secondly, ensure that the file system socket nodes for local
           AF_UNIX sockets used in the socket-based activation are not removed when the daemon shuts down, if sockets have been passed. Third, if
           the daemon normally closes all remaining open file descriptors as part of its initialization, the sockets passed from the init system
           must be spared. Since new-style init systems guarantee that no left-over file descriptors are passed to executed processes, it might be
           a good choice to simply skip the closing of all remaining open file descriptors if sockets are passed.

        3. Write and install a systemd unit file for the service (and the sockets if socket-based activation is used, as well as a path unit file,
           if the daemon processes a spool directory), see above for details.

        4. If the daemon exposes interfaces via D-Bus, write and install a D-Bus activation file for the service, see above for details.

PLACING DAEMON DATA
       It is recommended to follow the general guidelines for placing package files, as discussed in file-hierarchy(7).

SEE ALSO
       systemd(1), sd-daemon(3), sd_listen_fds(3), sd_notify(3), daemon(3), systemd.service(5), file-hierarchy(7)

NOTES
        1. LSB recommendations for SysV init scripts
           http://refspecs.linuxbase.org/LSB_3.1.1/LSB-Core-generic/LSB-Core-generic/iniscrptact.html

        2. Apple MacOS X Daemon Requirements
           https://developer.apple.com/library/mac/documentation/MacOSX/Conceptual/BPSystemStartup/Chapters/CreatingLaunchdJobs.html

systemd 229                                                                                                                              DAEMON(7)
