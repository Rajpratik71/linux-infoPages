File: *manpages*,  Node: tput,  Up: (dir)

tput(1)                     General Commands Manual                    tput(1)



NAME
       tput, reset - initialize a terminal or query terminfo database

SYNOPSIS
       tput [-Ttype] capname [parms ... ]
       tput [-Ttype] init
       tput [-Ttype] reset
       tput [-Ttype] longname
       tput -S  <<
       tput -V

DESCRIPTION
       The  tput utility uses the terminfo database to make the values of ter‐
       minal-dependent capabilities and information  available  to  the  shell
       (see  sh(1)),  to  initialize or reset the terminal, or return the long
       name of the requested terminal type.  The result depends upon the capa‐
       bility's type:

              string
                   tput writes the string to the standard output.  No trailing
                   newline is supplied.

              integer
                   tput writes the decimal value to the standard output,  with
                   a trailing newline.

              boolean
                   tput  simply sets the exit code (0 for TRUE if the terminal
                   has the capability, 1 for FALSE if it does not), and writes
                   nothing to the standard output.

       Before  using  a value returned on the standard output, the application
       should test the exit code (e.g., $?, see sh(1)) to be  sure  it  is  0.
       (See  the EXIT CODES and DIAGNOSTICS sections.)  For a complete list of
       capabilities and the capname associated with each, see terminfo(5).

       -Ttype indicates the type of terminal.  Normally this option is  unnec‐
              essary,  because the default is taken from the environment vari‐
              able TERM.  If -T is specified, then the shell  variables  LINES
              and COLUMNS will also be ignored.

       capname
              indicates the capability from the terminfo database.  When term‐
              cap support is compiled in, the termcap name for the  capability
              is also accepted.

       parms  If  the  capability is a string that takes parameters, the argu‐
              ments parms will be instantiated into the string.

              Most parameters are numbers.  Only a few  terminfo  capabilities
              require  string parameters; tput uses a table to decide which to
              pass as strings.  Normally tput uses tparm (3X) to  perform  the
              substitution.   If  no  parameters are given for the capability,
              tput writes the string without performing the substitution.

       -S     allows more than one capability per  invocation  of  tput.   The
              capabilities  must  be  passed  to  tput from the standard input
              instead of from the command line (see example).  Only  one  cap‐
              name  is allowed per line.  The -S option changes the meaning of
              the 0 and 1 boolean and string exit codes (see  the  EXIT  CODES
              section).

              Again,  tput  uses a table and the presence of parameters in its
              input to decide whether to use tparm (3X), and how to  interpret
              the parameters.

       -V     reports  the  version of ncurses which was used in this program,
              and exits.

       init   If the terminfo database is present and an entry for the  user's
              terminal exists (see -Ttype, above), the following will occur:

              (1)    if present, the terminal's initialization strings will be
                     output as detailed in the terminfo(5) section on Tabs and
                     Initialization,

              (2)    any delays (e.g., newline) specified in the entry will be
                     set in the tty driver,

              (3)    tabs expansion will be turned on or off according to  the
                     specification in the entry, and

              (4)    if  tabs  are  not  expanded,  standard  tabs will be set
                     (every 8 spaces).

              If an entry does not contain the information needed for  any  of
              the  four  above  activities,  that  activity  will  silently be
              skipped.

       reset  Instead of putting out initialization  strings,  the  terminal's
              reset strings will be output if present (rs1, rs2, rs3, rf).  If
              the reset strings are not present,  but  initialization  strings
              are,  the  initialization  strings  will  be output.  Otherwise,
              reset acts identically to init.

       longname
              If the terminfo database is present and an entry for the  user's
              terminal  exists  (see  -Ttype above), then the long name of the
              terminal will be put out.  The long name is the last name in the
              first  line  of the terminal's description in the terminfo data‐
              base [see term(5)].

       If tput is invoked by a link named reset, this has the same  effect  as
       tput reset.  See tset for comparison, which has similar behavior.

EXAMPLES
       tput init
            Initialize  the  terminal according to the type of terminal in the
            environmental variable TERM.  This command should be  included  in
            everyone's .profile after the environmental variable TERM has been
            exported, as illustrated on the profile(5) manual page.

       tput -T5620 reset
            Reset an AT&T 5620 terminal, overriding the type  of  terminal  in
            the environmental variable TERM.

       tput cup 0 0
            Send the sequence to move the cursor to row 0, column 0 (the upper
            left corner of the screen, usually  known  as  the  "home"  cursor
            position).

       tput clear
            Echo the clear-screen sequence for the current terminal.

       tput cols
            Print the number of columns for the current terminal.

       tput -T450 cols
            Print the number of columns for the 450 terminal.

       bold=`tput smso` offbold=`tput rmso`
            Set  the  shell  variables bold, to begin stand-out mode sequence,
            and offbold, to end standout mode sequence, for the current termi‐
            nal.  This might be followed by a prompt: echo "${bold}Please type
            in your name: ${offbold}\c"

       tput hc
            Set exit code to indicate if the current terminal is a  hard  copy
            terminal.

       tput cup 23 4
            Send the sequence to move the cursor to row 23, column 4.

       tput cup
            Send  the  terminfo string for cursor-movement, with no parameters
            substituted.

       tput longname
            Print the long name from the terminfo database  for  the  type  of
            terminal specified in the environmental variable TERM.

            tput -S <<!
            > clear
            > cup 10 10
            > bold
            > !

            This  example  shows  tput  processing several capabilities in one
            invocation.  It clears the screen, moves the  cursor  to  position
            10,  10 and turns on bold (extra bright) mode.  The list is termi‐
            nated by an exclamation mark (!) on a line by itself.

FILES
       /usr/share/terminfo
              compiled terminal description database

       /usr/share/tabset/*
              tab settings for some terminals, in a format appropriate  to  be
              output  to  the  terminal (escape sequences that set margins and
              tabs); for more information, see the "Tabs  and  Initialization"
              section of terminfo(5)

EXIT CODES
       If the -S option is used, tput checks for errors from each line, and if
       any errors are found, will set the exit code to 4 plus  the  number  of
       lines  with  errors.   If  no errors are found, the exit code is 0.  No
       indication of which line failed can be given so exit code 1 will  never
       appear.   Exit codes 2, 3, and 4 retain their usual interpretation.  If
       the -S option is not used, the exit code depends on the  type  of  cap‐
       name:

            boolean
                   a value of 0 is set for TRUE and 1 for FALSE.

            string a value of 0 is set if the capname is defined for this ter‐
                   minal type (the value of capname is  returned  on  standard
                   output);  a value of 1 is set if capname is not defined for
                   this terminal type (nothing is written to standard output).

            integer
                   a value of 0 is always  set,  whether  or  not  capname  is
                   defined for this terminal type.  To determine if capname is
                   defined for this terminal type,  the  user  must  test  the
                   value written to standard output.  A value of -1 means that
                   capname is not defined for this terminal type.

            other  reset or init may fail to find their respective files.   In
                   that case, the exit code is set to 4 + errno.

       Any other exit code indicates an error; see the DIAGNOSTICS section.

DIAGNOSTICS
       tput  prints  the  following  error messages and sets the corresponding
       exit codes.

       exit code   error message
       ─────────────────────────────────────────────────────────────────────
       0           (capname is a numeric variable that is not specified  in
                   the  terminfo(5)  database  for this terminal type, e.g.
                   tput -T450 lines and tput -T2621 xmc)
       1           no error message is printed, see the EXIT CODES section.
       2           usage error
       3           unknown terminal type or no terminfo database
       4           unknown terminfo capability capname
       >4          error occurred in -S
       ─────────────────────────────────────────────────────────────────────

PORTABILITY
       The longname and -S options, and  the  parameter-substitution  features
       used in the cup example, are not supported in BSD curses or in AT&T/USL
       curses before SVr4.

       X/Open documents only the operands for clear, init and reset.  In  this
       implementation,  clear is part of the capname support.  Other implemen‐
       tations of tput on SVr4-based systems such as Solaris, IRIX64 and  HPUX
       as well as others such as AIX and Tru64 provide support for capname op‐
       erands.

       A few platforms such as FreeBSD  and  NetBSD  recognize  termcap  names
       rather  than  terminfo  capability  names in their respective tput com‐
       mands.

       Most implementations which provide support for capname operands use the
       tparm  function  to  expand  parameters in it.  That function expects a
       mixture of numeric and string parameters, requiring tput to know  which
       type  to  use.   This implementation uses a table to determine that for
       the standard capname operands, and an internal library function to ana‐
       lyze  nonstandard  capname  operands.  Other implementations may simply
       guess that an operand containing only digits is intended to be  a  num‐
       ber.

SEE ALSO
       clear(1), stty(1), tabs(1), terminfo(5), curs_termcap(3X).

       This describes ncurses version 5.9 (patch 20130511).



                                                                       tput(1)
TPUT(1P)                   POSIX Programmer's Manual                  TPUT(1P)



PROLOG
       This  manual  page is part of the POSIX Programmer's Manual.  The Linux
       implementation of this interface may differ (consult the  corresponding
       Linux  manual page for details of Linux behavior), or the interface may
       not be implemented on Linux.

NAME
       tput - change terminal characteristics

SYNOPSIS
       tput [-T type] operand...

DESCRIPTION
       The tput utility shall  display  terminal-dependent  information.   The
       manner  in  which  this  information  is  retrieved is unspecified. The
       information displayed shall clear the terminal screen,  initialize  the
       user's terminal, or reset the user's terminal, depending on the operand
       given. The  exact  consequences  of  displaying  this  information  are
       unspecified.

OPTIONS
       The  tput  utility  shall  conform  to  the  Base Definitions volume of
       IEEE Std 1003.1-2001, Section 12.2, Utility Syntax Guidelines.

       The following option shall be supported:

       -T  type
              Indicate the type of terminal. If this option  is  not  supplied
              and  the  TERM variable is unset or null, an unspecified default
              terminal type shall be used. The  setting  of  type  shall  take
              precedence over the value in TERM.


OPERANDS
       The following strings shall be supported as operands by the implementa‐
       tion in the POSIX locale:

       clear  Display the clear-screen sequence.

       init   Display the sequence that initializes the user's terminal in  an
              implementation-defined manner.

       reset  Display  the  sequence  that  resets  the  user's terminal in an
              implementation-defined manner.


       If a terminal does not support any of the operations described by these
       operands, this shall not be considered an error condition.

STDIN
       Not used.

INPUT FILES
       None.

ENVIRONMENT VARIABLES
       The following environment variables shall affect the execution of tput:

       LANG   Provide  a  default value for the internationalization variables
              that are unset or null. (See  the  Base  Definitions  volume  of
              IEEE Std 1003.1-2001,  Section  8.2,  Internationalization Vari‐
              ables for the precedence of internationalization variables  used
              to determine the values of locale categories.)

       LC_ALL If  set  to a non-empty string value, override the values of all
              the other internationalization variables.

       LC_CTYPE
              Determine the locale for  the  interpretation  of  sequences  of
              bytes  of  text  data as characters (for example, single-byte as
              opposed to multi-byte characters in arguments).

       LC_MESSAGES
              Determine the locale that should be used to  affect  the  format
              and contents of diagnostic messages written to standard error.

       NLSPATH
              Determine the location of message catalogs for the processing of
              LC_MESSAGES .

       TERM   Determine the terminal type. If this variable is unset or  null,
              and  if  the  -T option is not specified, an unspecified default
              terminal type shall be used.


ASYNCHRONOUS EVENTS
       Default.

STDOUT
       If standard output is a terminal device, it may be used for writing the
       appropriate  sequence  to  clear  the screen or reset or initialize the
       terminal. If standard  output  is  not  a  terminal  device,  undefined
       results occur.

STDERR
       The standard error shall be used only for diagnostic messages.

OUTPUT FILES
       None.

EXTENDED DESCRIPTION
       None.

EXIT STATUS
       The following exit values shall be returned:

        0     The requested string was written successfully.

        1     Unspecified.

        2     Usage error.

        3     No information is available about the specified terminal type.

        4     The specified operand is invalid.

       >4     An error occurred.


CONSEQUENCES OF ERRORS
       If  one of the operands is not available for the terminal, tput contin‐
       ues processing the remaining operands.

       The following sections are informative.

APPLICATION USAGE
       The difference between resetting and initializing a  terminal  is  left
       unspecified, as they vary greatly based on hardware types.  In general,
       resetting is a more severe action.

       Some terminals use control characters to perform the stated  functions,
       and on such terminals it might make sense to use tput to store the ini‐
       tialization strings in a file or environment variable  for  later  use.
       However,  because other terminals might rely on system calls to do this
       work, the standard output cannot be used in a portable manner, such  as
       the following non-portable constructs:


              ClearVar=`tput clear`
              tput reset | mailx -s "Wake Up" ddg

EXAMPLES
        1. Initialize  the  terminal  according to the type of terminal in the
           environmental variable TERM.  This command can  be  included  in  a
           .profile file.


           tput init

        2. Reset a 450 terminal.


           tput -T 450 reset

RATIONALE
       The  list  of  operands was reduced to a minimum for the following rea‐
       sons:

        * The only features chosen were those that were likely to be  used  by
          human users interacting with a terminal.

        * Specifying  the  full terminfo set was not considered desirable, but
          the standard developers did not want to select among operands.

        * This volume of IEEE Std 1003.1-2001  does  not  attempt  to  provide
          applications  with  sophisticated terminal handling capabilities, as
          that falls outside of its assigned scope  and  intersects  with  the
          responsibilities of other standards bodies.

       The  difference  between  resetting and initializing a terminal is left
       unspecified as this varies greatly based on hardware  types.   In  gen‐
       eral, resetting is a more severe action.

       The  exit  status  of  1  is historically reserved for finding out if a
       Boolean operand is not set. Although the operands  were  reduced  to  a
       minimum,  the exit status of 1 should still be reserved for the Boolean
       operands, for those sites that wish to support them.

FUTURE DIRECTIONS
       None.

SEE ALSO
       stty, tabs

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



IEEE/The Open Group                  2003                             TPUT(1P)
