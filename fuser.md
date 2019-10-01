File: *manpages*,  Node: fuser,  Up: (dir)

FUSER(1)                         User Commands                        FUSER(1)



NAME
       fuser - identify processes using files or sockets

SYNOPSIS
       fuser [-fuv] [-a|-s] [-4|-6] [-c|-m|-n space] [ -k [-i] [-M] [-w]
       [-SIGNAL] ] name ...
       fuser -l
       fuser -V

DESCRIPTION
       fuser displays the PIDs of processes using the specified files or  file
       systems.   In the default display mode, each file name is followed by a
       letter denoting the type of access:

              c      current directory.
              e      executable being run.
              f      open file.  f is omitted in default display mode.
              F      open file for writing.  F is omitted in  default  display
                     mode.
              r      root directory.
              m      mmap'ed file or shared library.

       fuser  returns a non-zero return code if none of the specified files is
       accessed or in case of a fatal error.  If at least one access has  been
       found, fuser returns zero.

       In  order  to  look  up processes using TCP and UDP sockets, the corre‐
       sponding name space has to be selected with the -n option.  By  default
       fuser  will look in both IPv6 and IPv4 sockets.  To change the default,
       behavior, use the -4 and -6 options.  The socket(s) can be specified by
       the  local  and  remote  port,  and the remote address.  All fields are
       optional, but commas in front of missing fields must be present:

       [lcl_port][,[rmt_host][,[rmt_port]]]

       Either symbolic or numeric values can be used for IP addresses and port
       numbers.

       fuser  outputs  only  the  PIDs  to  stdout, everything else is sent to
       stderr.

OPTIONS
       -a, --all
              Show all files specified on the command line.  By default,  only
              files that are accessed by at least one process are shown.

       -c     Same as -m option, used for POSIX compatibility.

       -f     Silently ignored, used for POSIX compatibility.

       -k, --kill
              Kill processes accessing the file.  Unless changed with -SIGNAL,
              SIGKILL is sent.  An fuser process never kills itself,  but  may
              kill  other  fuser  processes.   The  effective  user  ID of the
              process executing fuser is  set  to  its  real  user  ID  before
              attempting to kill.

       -i, --interactive
              Ask  the  user  for  confirmation before killing a process. This
              option is silently ignored if -k is not present too.

       -l, --list-signals
              List all known signal names.

       -m NAME, --mount NAME
              NAME specifies a file on a mounted file system or a block device
              that  is  mounted.   All  processes accessing files on that file
              system are listed.  If a directory  file  is  specified,  it  is
              automatically  changed  to  NAME/.   to use any file system that
              might be mounted on that directory.

       -M --ismountpoint
              Request will be fulfilled only if NAME specifies  a  mountpoint.
              This  is  an invaluable seatbelt which prevents you from killing
              the machine if NAME happens to not be a filesystem.

       -w     Kill only processes which have write  access.   This  option  is
              silently ignored if -k is not present too.

       -n SPACE, --namespace SPACE
              Select  a  different  name  space.   The  name spaces file (file
              names, the default), udp (local UDP ports), and tcp  (local  TCP
              ports)  are supported.  For ports, either the port number or the
              symbolic name can be specified.  If there is no  ambiguity,  the
              shortcut notation name/space (e.g. 80/tcp) can be used.

       -s, --silent
              Silent  operation.  -u and -v are ignored in this mode.  -a must
              not be used with -s.

       -SIGNAL
              Use the specified signal instead of SIGKILL  when  killing  pro‐
              cesses.  Signals can be specified either by name (e.g.  -HUP) or
              by number (e.g.  -1).  This option is silently ignored if the -k
              option is not used.

       -u, --user
              Append the user name of the process owner to each PID.

       -v, --verbose

              Verbose  mode.   Processes  are  shown  in a ps-like style.  The
              fields PID, USER and COMMAND are similar to  ps.   ACCESS  shows
              how  the process accesses the file.  Verbose mode will also show
              when a particular file is being access as a  mount  point,  knfs
              export  or  swap  file.  In this case kernel is shown instead of
              the PID.

       -V, --version
              Display version information.

       -4, --ipv4
              Search only for IPv4 sockets.  This option must not be used with
              the -6 option and only has an effect with the tcp and udp names‐
              paces.

       -6, --ipv6
              Search only for IPv6 sockets.  This option must not be used with
              the -4 option and only has an effect with the tcp and udp names‐
              paces.

       -      Reset all options and set the signal back to SIGKILL.

FILES
       /proc  location of the proc file system

EXAMPLES
       fuser -km /home
              kills all processes accessing the file system /home in any way.

       if fuser -s /dev/ttyS1; then :; else something; fi
              invokes something if no other process is using /dev/ttyS1.

       fuser telnet/tcp
              shows all processes at the (local) TELNET port.

RESTRICTIONS
       Processes accessing the same file or file system several times  in  the
       same way are only shown once.

       If the same object is specified several times on the command line, some
       of those entries may be ignored.

       fuser may only be able to gather partial information  unless  run  with
       privileges.   As  a consequence, files opened by processes belonging to
       other users may not be listed and  executables  may  be  classified  as
       mapped only.

       fuser cannot report on any processes that it doesn't have permission to
       look at the file descriptor table for.  The most common time this prob‐
       lem occurs is when looking for TCP or UDP sockets when running fuser as
       a non-root user.  In this case fuser will report no access.

       Installing fuser SUID root will avoid problems associated with  partial
       information, but may be undesirable for security and privacy reasons.

       udp and tcp name spaces, and UNIX domain sockets can't be searched with
       kernels older than 1.3.78.

       Accesses by the kernel are only shown with the -v option.

       The -k option only works on processes.  If  the  user  is  the  kernel,
       fuser will print an advice, but take no action beyond that.

BUGS
       fuser  -m  /dev/sgX will show (or kill with the -k flag) all processes,
       even if you don't have that device  configured.   There  may  be  other
       devices it does this for too.

       The  mount  -m option will match any file within the save device as the
       specified file, use the -M option as well if you mean to  specify  only
       the mount point.

SEE ALSO
       kill(1), killall(1), lsof(8), pkill(1), ps(1), kill(2).



psmisc                            2012-07-28                          FUSER(1)
FUSER(1P)                  POSIX Programmer's Manual                 FUSER(1P)



PROLOG
       This  manual  page is part of the POSIX Programmer's Manual.  The Linux
       implementation of this interface may differ (consult the  corresponding
       Linux  manual page for details of Linux behavior), or the interface may
       not be implemented on Linux.

NAME
       fuser - list process IDs of all processes that have one or  more  files
       open

SYNOPSIS
       fuser [ -cfu ] file ...

DESCRIPTION
       The  fuser  utility  shall  write to standard output the process IDs of
       processes running on the local system that have one or more named files
       open.  For  block special devices, all processes using any file on that
       device are listed.

       The fuser utility shall write to standard error additional  information
       about the named files indicating how the file is being used.

       Any  output  for  processes running on remote systems that have a named
       file open is unspecified.

       A user may need appropriate privilege to invoke the fuser utility.

OPTIONS
       The fuser utility shall conform  to  the  Base  Definitions  volume  of
       IEEE Std 1003.1-2001, Section 12.2, Utility Syntax Guidelines.

       The following options shall be supported:

       -c     The  file  is  treated  as  a  mount point and the utility shall
              report on any files open in the file system.

       -f     The report shall be only for the named files.

       -u     The user name, in parentheses, associated with each  process  ID
              written to standard output shall be written to standard error.


OPERANDS
       The following operand shall be supported:

       file   A pathname on which the file or file system is to be reported.


STDIN
       Not used.

INPUT FILES
       The user database.

ENVIRONMENT VARIABLES
       The  following  environment  variables  shall  affect  the execution of
       fuser:

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
              and contents of diagnostic messages written to standard error.

       NLSPATH
              Determine the location of message catalogs for the processing of
              LC_MESSAGES .


ASYNCHRONOUS EVENTS
       Default.

STDOUT
       The  fuser  utility  shall  write the process ID for each process using
       each file given as an operand to standard output in the following  for‐
       mat:


              "%d", <process_id>

STDERR
       The fuser utility shall write diagnostic messages to standard error.

       The fuser utility also shall write the following to standard error:

        * The pathname of each named file is written followed immediately by a
          colon.

        * For each process ID written to standard output,  the  character  'c'
          shall  be written to standard error if the process is using the file
          as its current directory and the character 'r' shall be  written  to
          standard  error  if the process is using the file as its root direc‐
          tory. Implementations may write other alphabetic characters to indi‐
          cate other uses of files.

        * When  the  -u  option is specified, characters indicating the use of
          the file shall be followed immediately by the user name,  in  paren‐
          theses,  corresponding  to  the  process' real user ID.  If the user
          name cannot be resolved from the process' real user ID, the process'
          real user ID shall be written instead of the user name.

       When  standard output and standard error are directed to the same file,
       the output shall be interleaved so that the  filename  appears  at  the
       start  of each line, followed by the process ID and characters indicat‐
       ing the use of the file. Then, if the -u option is specified, the  user
       name or user ID for each process using that file shall be written.

       A  <newline>  shall  be written to standard error after the last output
       described above for each file operand.

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
       The command:


              fuser -fu .

       writes to standard output the process IDs of processes that  are  using
       the current directory and writes to standard error an indication of how
       those processes are using the directory and the user  names  associated
       with the processes that are using the current directory.

RATIONALE
       The definition of the fuser utility follows existing practice.

FUTURE DIRECTIONS
       None.

SEE ALSO
       None.

COPYRIGHT
       Portions  of  this text are reprinted and reproduced in electronic form
       from IEEE Std 1003.1, 2003 Edition, Standard for Information Technology
       --  Portable  Operating  System  Interface (POSIX), The Open Group Base
       Specifications Issue 6, Copyright (C) 2001-2003  by  the  Institute  of
       Electrical  and  Electronics  Engineers, Inc and The Open Group. In the
       event of any discrepancy between this version and the original IEEE and
       The  Open Group Standard, the original IEEE and The Open Group Standard
       is the referee document. The original Standard can be  obtained  online
       at http://www.opengroup.org/unix/online.html .



IEEE/The Open Group                  2003                            FUSER(1P)
