TORSOCKS(1)                                                                                                                            TORSOCKS(1)

NAME
       torsocks — Shell wrapper to simplify the use of the torsocks(8) library to transparently torify an application.

SYNOPSIS
       torsocks [OPTIONS] [COMMAND [ARG ...]]

DESCRIPTION
       torsocks  is  a  wrapper  between the torsocks library and the application in order to make every Internet communication go through the Tor
       network.

       By default, torsocks will assume that it should connect to the Tor SOCKS proxy running at 127.0.0.1 on port 9050 being the defaults of  the
       Tor daemon.

       In  order  to  use  a  configuration file, torsocks tries to read the /etc/tor/torsocks.conf file or look for the environment variable TOR‐
       SOCKS_CONF_FILE with the location of the file. If that file cannot be read, torsocks will use sensible defaults for most Tor installations.

       For further information on configuration, see torsocks.conf(5).

OPTIONS
       -h, --help
              Show summary of possible options and commands.

       --shell
              Create a new shell with LD_PRELOAD including torsocks(8).

       --version
              Show version.

       -u, --user
              Set username for the SOCKS5 authentication. Use for circuit isolation in Tor.  Note that you MUST have a password set either by  the
              command line, environment variable or configuration file (torsocks.conf(5).

       -p, --pass
              Set  password for the SOCKS5 authentication. Use for circuit isolation in Tor.  Note that you MUST have a username set either by the
              command line, environment variable or configuration file (torsocks.conf(5)).

       -a, --address
              Set Tor address.

       -P, --port
              Set Tor port.

       -i, --isolate
              Automatic tor isolation. Set the username and password for the SOCKS5 authentication method to a PID/current time based value  auto‐
              matically. Username and Password MUST NOT be set.

       -d, --debug
              Activate the debug mode. Output will be written on stderr.

       -q, --quiet
              Suppress every log messages (even errors).

       on | off
              This  option  adds  or  removes  torsocks(8) from the LD_PRELOAD environment variable for the current shell. If you want to use this
              option, you HAVE to source torsocks from your shell.

              Add the torsocks library to LD_PRELOAD
              $ . torsocks on
              Remove the torsocks library from LD_PRELOAD
              $ . torsocks off

       show | sh
              Show the current value of the LD_PRELOAD environment variable.

ENVIRONMENT VARIABLES
       Please see torsocks(8) for more detail on possible environment variables.

SEE ALSO
       torsocks(8), torsocks.conf(5)

CREDITS
       torsocks is distributed under the GNU General Public License version 2.

       A Web site is available at https://www.torproject.org for more information.

       You can also find the source code at https://git.torproject.org.

       Mailing list for help is <tor-talk@lists.torproject.org> and for development use <tor-dev@lists.torproject.org>. You can find  the  project
       also on IRC server irc.oftc.net (OFTC) in #tor and #tor-dev.

AUTHOR
       torsocks was originally written by Robert Hogan and has been rewritten by David Goulet <dgoulet@torproject.org> in 2013.

                                                                  March 3rd, 2014                                                      TORSOCKS(1)
TORSOCKS(8)                                                                                                                            TORSOCKS(8)

NAME
       torsocks — Library for intercepting outgoing network connections and redirecting them through the Tor SOCKS proxy.

DESCRIPTION
       Torsocks  library  overloads  the  libc  symbols  use  for Internet communication such as connect(2) system call. Using that technique, the
       library sends everything through the Tor network including DNS resolution done by the application.

       For DNS, gethostbyname(3) family functions are rerouted through Tor.  Please note that the ISC res_* API is currently not supported.

       Here is an example on how to use torsocks library with ssh(1):

       $ LD_PRELOAD=/path/to/libtorsocks.so ssh -l kalexander -p 1234 prism.nsa.gov [...]

SHELL USAGE
       Set LD_PRELOAD to load the library then use applications as normal. The syntax to force preload of the  library  for  different  shells  is
       specified below:

       Bash, Ksh and Bourne shell:

       $ export LD_PRELOAD=/path/to/libtorsocks.so

       C Shell:

       $ setenv LD_PRELOAD=/path/to/libtorsocks.so

       This  process can be automated (for Bash, Bourne and Korn shell users) for a single command or for all commands in a shell session by using
       the torsocks(1) script.

       You can also setup torsocks(1) in such a way that all processes automatically use it, a very useful configuration. Please refer to the tor‐
       socks script documentation for more information.

ENVIRONMENT VARIABLES
       TORSOCKS_CONF_FILE
              This  environment  variable  overrides  the default location of the torsocks configuration file. This variable is not honored if the
              program torsocks is embedded in is setuid.

       TORSOCKS_LOG_LEVEL
              Enable logging level of torsocks library. By default, warnings and errors are printed (level 3). Note that each level  includes  the
              lower ones except the 1 which disables any possible logging. (default: 3)

              1   No log at all.
              2   Error messages.
              3   Warning messages.
              4   Notice messages.
              5   Debug messages.

       TORSOCKS_LOG_TIME
              Control whether or not the time is added to each logging line. (default: 1)

       TORSOCKS_LOG_FILE_PATH
              If set, torsocks will log in the file set by this variable. (default: stderr)

       TORSOCKS_USERNAME
              Set the username for the SOCKS5 authentication method. Password MUST be set also with the variable below.

       TORSOCKS_PASSWORD
              Set the password for the SOCKS5 authentication method. Username MUST be set also with the variable above.

       TORSOCKS_TOR_ADDRESS
              Set the Tor address. (default: 127.0.0.1)

       TORSOCKS_TOR_PORT
              Set the Tor port. (default: 9050)

       TORSOCKS_ALLOW_INBOUND
              Allow inbound connections so the application can accept and listen for connections.

       TORSOCKS_ISOLATE_PID
              Set  the  username  and  password for the SOCKS5 authentication method to a PID/current time based value automatically. Username and
              Password MUST NOT be set.

KNOWN ISSUES
   DNS
       Torsocks is not able to send DNS queries through Tor since UDP is not supported. Thus, any UDP socket is denied. However, DNS queries  that
       can be intercept are sent to Tor and sent back to the caller.

   ERRORS
       Torsocks  might  generate error messages and print them to stderr when there are problems with the configuration file or the SOCKS negotia‐
       tion with the Tor daemon. The TORSOCKS_LOG_LEVEL environment variable controls that behavior as well as the log file option. Keep  in  mind
       that this library can output on the stderr of the application.

LIMITATIONS
       Outgoing TCP connections can only be proxified through the Tor network.

       Torsocks  forces  the  libc  resolver  to  use  TCP for name queries, if it does this it does it regardless of whether or not the DNS to be
       queried is local or not.  This introduces overhead and should only be used when needed.

       Torsocks uses ELF dynamic loader features to intercept dynamic function calls from programs in which it is embedded. As a  result,  non-ELF
       executables, or executables that make system calls directly with the system call trap (int 0x80) are not supported.

FILES
       /etc/tor/torsocks.conf - default torsocks configuration file

SEE ALSO
       torsocks.conf(5), torsocks(1)

AUTHOR
       David Goulet <dgoulet@ev0ke.net>

                                                                 August 24th, 2013                                                     TORSOCKS(8)
