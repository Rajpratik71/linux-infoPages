File: *manpages*,  Node: tabs,  Up: (dir)

tabs(1)                     General Commands Manual                    tabs(1)



NAME
       tabs - set tabs on a terminal

SYNOPSIS
       tabs [options]] [tabstop-list]

DESCRIPTION
       The  tabs program clears and sets tab-stops on the terminal.  This uses
       the terminfo clear_all_tabs and set_tab  capabilities.   If  either  is
       absent,  tabs is unable to clear/set tab-stops.  The terminal should be
       configured to use hard tabs, e.g.,

              stty tab0

OPTIONS
   General Options
       -Tname
            Tell tabs which terminal type to  use.   If  this  option  is  not
            given,  tabs  will use the $TERM environment variable.  If that is
            not set, it will use the ansi+tabs entry.

       -d   The debugging option shows a ruler  line,  followed  by  two  data
            lines.   The  first  data line shows the expected tab-stops marked
            with asterisks.  The second data line shows the actual  tab-stops,
            marked with asterisks.

       -n   This  option tells tabs to check the options and run any debugging
            option, but not to modify the terminal settings.

       -V   reports the version of ncurses which was used in this program, and
            exits.

       The tabs program processes a single list of tab stops.  The last option
       to be processed which defines a list is the  one  that  determines  the
       list to be processed.

   Implicit Lists
       Use  a  single number as an option, e.g., "-5" to set tabs at the given
       interval (in this case 1, 6, 11, 16, 21, etc.).  Tabs are  repeated  up
       to the right margin of the screen.

       Use "-0" to clear all tabs.

       Use "-8" to set tabs to the standard interval.

   Explicit Lists
       An  explicit list can be defined after the options (this does not use a
       "-").  The values in the list must be in increasing numeric order,  and
       greater than zero.  They are separated by a comma or a blank, for exam-
       ple,

              tabs 1,6,11,16,21
              tabs 1 6 11 16 21
       Use a '+' to treat a number as an increment relative  to  the  previous
       value, e.g.,

              tabs 1,+5,+5,+5,+5
       which is equivalent to the 1,6,11,16,21 example.

   Predefined Tab-Stops
       X/Open defines several predefined lists of tab stops.

       -a   Assembler, IBM S/370, first format

       -a2  Assembler, IBM S/370, second format

       -c   COBOL, normal format

       -c2  COBOL compact format

       -c3  COBOL compact format extended

       -f   FORTRAN

       -p   PL/I

       -s   SNOBOL

       -u   UNIVAC 1100 Assembler

PORTABILITY
       X/Open  describes  a  +m option, to set a terminal's left-margin.  Very
       few of the entries in the terminal database provide this capability.

       The -d (debug) and -n (no-op) options are extensions  not  provided  by
       other implementations.

       Documentation for other implementations states that there is a limit on
       the number of tab stops.  While some terminals may not accept an  arbi-
       trary  number of tab stops, this implementation will attempt to set tab
       stops up to the right margin of the screen, if the given  list  happens
       to be that long.

SEE ALSO
       tset(1), infocmp(1), ncurses(3NCURSES), terminfo(5).

       This describes ncurses version 5.9 (patch 20140201).



                                                                       tabs(1)
TABS(1P)                   POSIX Programmer's Manual                  TABS(1P)



PROLOG
       This  manual  page is part of the POSIX Programmer's Manual.  The Linux
       implementation of this interface may differ (consult the  corresponding
       Linux  manual page for details of Linux behavior), or the interface may
       not be implemented on Linux.

NAME
       tabs - set terminal tabs

SYNOPSIS
       tabs [ -n| -a| -a2| -c| -c2| -c3| -f| -p| -s| -u][+m[n]] [-T type]

       tabs [-T type][ +[n]] n1[,n2,...]


DESCRIPTION
       The tabs utility shall display a series of characters that first clears
       the  hardware  terminal tab settings and then initializes the tab stops
       at the specified positions  and optionally adjusts the margin.

       The phrase "tab-stop position N" shall be taken to mean that, from  the
       start  of  a line of output, tabbing to position N shall cause the next
       character output to be in the ( N+1)th column position  on  that  line.
       The maximum number of tab stops allowed is terminal-dependent.

       It need not be possible to implement tabs on certain terminals.  If the
       terminal type obtained from the TERM environment variable or -T  option
       represents  such a terminal, an appropriate diagnostic message shall be
       written to standard error and tabs shall exit  with  a  status  greater
       than zero.

OPTIONS
       The  tabs  utility  shall  conform  to  the  Base Definitions volume of
       IEEE Std 1003.1-2001, Section 12.2, Utility Syntax Guidelines,   except
       for various extensions: the options -a2, -c2, and -c3 are multi-charac-
       ter.

       The following options shall be supported:

       -n     Specify repetitive tab stops separated by a  uniform  number  of
              column  positions,  n, where n is a single-digit decimal number.
              The default usage of tabs with no arguments shall be  equivalent
              to  tabs-8.  When -0 is used, the tab stops shall be cleared and
              no new ones set.

       -a     1,10,16,36,72
              Assembler, applicable to some mainframes.

       -a2    1,10,16,40,72
              Assembler, applicable to some mainframes.

       -c     1,8,12,16,20,55
              COBOL, normal format.

       -c2    1,6,10,14,49
              COBOL, compact format (columns 1 to 6 omitted).

       -c3    1,6,10,14,18,22,26,30,34,38,42,46,50,54,58,62,67
              COBOL compact format (columns 1 to 6 omitted),  with  more  tabs
              than -c2.

       -f     1,7,11,15,19,23
              FORTRAN

       -p     1,5,9,13,17,21,25,29,33,37,41,45,49,53,57,61
              PL/1

       -s     1,10,55
              SNOBOL

       -u     1,12,20,44
              Assembler, applicable to some mainframes.

       -T  type
              Indicate  the  type  of terminal. If this option is not supplied
              and the TERM variable is unset or null, an  unspecified  default
              terminal  type  shall  be  used.  The setting of type shall take
              precedence over the value in TERM.


OPERANDS
       The following operand shall be supported:

       n1[,n2,...]
              A single command line argument that consists of tab-stop  values
              separated using either commas or <blank>s. The application shall
              ensure that the tab-stop values are positive decimal integers in
              strictly  ascending  order. If any number (except the first one)
              is preceded by a plus sign, it is taken as an  increment  to  be
              added  to  the  previous  value.  For  example,  the  tab  lists
              1,10,20,30 and 1,10,+10,+10 are considered to be identical.


STDIN
       Not used.

INPUT FILES
       None.

ENVIRONMENT VARIABLES
       The following environment variables shall affect the execution of tabs:

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
              and contents of diagnostic messages written to standard error.

       NLSPATH
              Determine the location of message catalogs for the processing of
              LC_MESSAGES .

       TERM   Determine  the terminal type. If this variable is unset or null,
              and if the -T option is not specified,  an  unspecified  default
              terminal type shall be used.


ASYNCHRONOUS EVENTS
       Default.

STDOUT
       If standard output is a terminal, the appropriate sequence to clear and
       set the tab stops may be written to standard output in  an  unspecified
       format. If standard output is not a terminal, undefined results occur.

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
       Default.

       The following sections are informative.

APPLICATION USAGE
       This  utility  makes  use  of the terminal's hardware tabs and the stty
       tabs option.

       This utility is not recommended for application use.

       Some integrated display units might not have escape  sequences  to  set
       tab stops, but may be set by internal system calls. On these terminals,
       tabs works if standard output is directed to the terminal; if output is
       directed to another file, however, tabs fails.

EXAMPLES
       None.

RATIONALE
       Consideration  was  given  to having the tput utility handle all of the
       functions described in tabs. However, the  separate  tabs  utility  was
       retained  because  it  seems more intuitive to use a command named tabs
       than tput with a new option. The tput utility does not support  setting
       or  clearing tabs, and no known historical version of tabs supports the
       capability of setting arbitrary tab stops.

       The System V tabs interface is very complex; the version in this volume
       of  IEEE Std 1003.1-2001  has  a  reduced feature list, but many of the
       features omitted were restored as XSI extensions even though  the  sup-
       ported languages and coding styles are primarily historical.

       There  was considerable sentiment for specifying only a means of reset-
       ting the tabs back to a known state-presumably the "standard"  of  tabs
       every eight positions. The following features were omitted:

        * Setting  tab  stops  via  the  first  line in a file, using -- file.
          Since even the SVID has no complete explanation of this feature,  it
          is doubtful that it is in widespread use.

       In  an  early  proposal,  a -t tablist option was added for consistency
       with expand; this was later removed when inconsistencies with the  his-
       torical list of tabs were identified.

       Consideration  was  given  to  adding a -p option that would output the
       current tab settings so  that  they  could  be  saved  and  then  later
       restored.  This  was not accepted because querying the tab stops of the
       terminal is not a capability in historical terminfo or termcap  facili-
       ties and might not be supported on a wide range of terminals.

FUTURE DIRECTIONS
       None.

SEE ALSO
       expand, stty, tput, unexpand

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



IEEE/The Open Group                  2003                             TABS(1P)
