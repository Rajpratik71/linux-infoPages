File: *manpages*,  Node: lp,  Up: (dir)

lp(1)                             Apple Inc.                             lp(1)



NAME
       lp - print files

SYNOPSIS
       lp  [  -E  ]  [ -U username ] [ -c ] [ -d destination[/instance] ] [ -h
       hostname[:port] ] [ -m ] [ -n num-copies ] [ -o option[=value] ]  [  -q
       priority  ] [ -s ] [ -t title ] [ -H handling ] [ -P page-list ] [ -- ]
       [ file(s) ]
       lp [ -E ] [ -U username ] [ -c ] [ -h hostname[:port] ] [ -i job-id ] [
       -n num-copies ] [ -o option[=value] ] [ -q priority ] [ -t title ] [ -H
       handling ] [ -P page-list ]

DESCRIPTION
       lp submits files for printing or alters a pending job. Use  a  filename
       of "-" to force printing from the standard input.

THE DEFAULT DESTINATION
       CUPS  provides  many  ways to set the default destination. The "LPDEST"
       and "PRINTER" environment variables are consulted first. If neither are
       set,  the  current  default set using the lpoptions(1) command is used,
       followed by the default set using the lpadmin(8) command.

OPTIONS
       The following options are recognized by lp:

       --
            Marks the end of options; use this to  print  a  file  whose  name
            begins with a dash (-).

       -E
            Forces encryption when connecting to the server.

       -U username
            Specifies the username to use when connecting to the server.

       -c
            This  option is provided for backwards-compatibility only. On sys‐
            tems that support it, this option forces  the  print  file  to  be
            copied  to  the  spool  directory  before printing. In CUPS, print
            files are always sent to the scheduler via IPP which has the  same
            effect.

       -d destination
            Prints files to the named printer.

       -h hostname[:port]
            Chooses an alternate server.

       -i job-id
            Specifies an existing job to modify.

       -m
            Sends an email when the job is completed.

       -n copies
            Sets the number of copies to print from 1 to 100.

       -o "name=value [name=value ...]"
            Sets one or more job options.

       -q priority
            Sets  the  job  priority  from  1  (lowest)  to 100 (highest). The
            default priority is 50.

       -s
            Do not report the resulting job IDs (silent mode.)

       -t "name"
            Sets the job name.

       -H hh:mm

       -H hold

       -H immediate

       -H restart

       -H resume
            Specifies when the job should be printed.  A  value  of  immediate
            will print the file immediately, a value of hold will hold the job
            indefinitely, and a UTC time value (HH:MM) will hold the job until
            the specified UTC (not local) time. Use a value of resume with the
            -i option to resume a held job.  Use a value of restart  with  the
            -i option to restart a completed job.

       -P page-list
            Specifies  which pages to print in the document. The list can con‐
            tain a list of numbers and ranges (#-#) separated by commas  (e.g.
            1,3-5,16).  The page numbers refer to the output pages and not the
            document's original pages - options like  "number-up"  can  affect
            the numbering of the pages.

COMMON JOB OPTIONS
       Aside  from  the  printer-specific options reported by the lpoptions(1)
       command, the following generic options are available:

       -o media=size
            Sets the page size to size. Most printers  support  at  least  the
            size names "a4", "letter", and "legal".

       -o landscape

       -o orientation-requested=4
            Prints the job in landscape (rotated 90 degrees).

       -o sides=one-sided

       -o sides=two-sided-long-edge

       -o sides=two-sided-short-edge
            Prints  on  one  or  two sides of the paper. The value "two-sided-
            long-edge" is normally used  when  printing  portrait  (unrotated)
            pages, while "two-sided-short-edge" is used for landscape pages.

       -o fit-to-page
            Scales the print file to fit on the page.

       -o number-up=2

       -o number-up=4

       -o number-up=6

       -o number-up=9

       -o number-up=16
            Prints multiple document pages on each output page.

       -o cpi=N
            Sets the number of characters per inch to use when printing a text
            file. The default is 10.

       -o lpi=N
            Sets the number of lines per inch to  use  when  printing  a  text
            file. The default is 6.

       -o page-bottom=N

       -o page-left=N

       -o page-right=N

       -o page-top=N
            Sets  the page margins when printing text files. The values are in
            points - there are 72 points to the inch.

EXAMPLES
       Print a double-sided legal document to a printer called "foo":
           lp -d foo -o media=legal -o sides=two-sided-long-edge filename

       Print an image across 4 pages:
           lp -d bar -o scaling=200 filename

       Print a text file with 12 characters per inch, 8 lines per inch, and  a
       1 inch left margin:
           lp -d bar -o cpi=12 -o lpi=8 -o page-left=72 filename

COMPATIBILITY
       Unlike  the System V printing system, CUPS allows printer names to con‐
       tain any printable character except SPACE, TAB,  "/",  or  "#".   Also,
       printer and class names are not case-sensitive.

       The  "q" option accepts a different range of values than the Solaris lp
       command, matching the IPP job priority values (1-100,  100  is  highest
       priority) instead of the Solaris values (0-39, 0 is highest priority).

SEE ALSO
       cancel(1), lpadmin(8), lpmove(8), lpoptions(1), lpstat(1),
       http://localhost:631/help

COPYRIGHT
       Copyright 2007-2013 by Apple Inc.



16 July 2012                         CUPS                                lp(1)
LP(1P)                     POSIX Programmer's Manual                    LP(1P)



PROLOG
       This  manual  page is part of the POSIX Programmer's Manual.  The Linux
       implementation of this interface may differ (consult the  corresponding
       Linux  manual page for details of Linux behavior), or the interface may
       not be implemented on Linux.

NAME
       lp - send files to a printer

SYNOPSIS
       lp [-c][-d dest][-n copies][-msw][-o option]...  [-t title][file...]

DESCRIPTION
       The lp utility shall copy the input files to an output  destination  in
       an  unspecified  manner.  The default output destination should be to a
       hardcopy device, such as a printer or microfilm recorder, that produces
       non-volatile,  human-readable documents. If such a device is not avail‐
       able to the application, or if the system provides no such device,  the
       lp utility shall exit with a non-zero exit status.

       The  actual  writing to the output device may occur some time after the
       lp utility successfully exits. During the portion of the  writing  that
       corresponds  to  each  input  file,  the implementation shall guarantee
       exclusive access to the device.

       The lp utility shall associate a unique request ID with each request.

       Normally, a banner page is produced to separate and identify each print
       job.  This page may be suppressed by implementation-defined conditions,
       such as an operator command or one of the -o option values.

OPTIONS
       The lp  utility  shall  conform  to  the  Base  Definitions  volume  of
       IEEE Std 1003.1-2001, Section 12.2, Utility Syntax Guidelines.

       The following options shall be supported:

       -c     Exit  only  after further access to any of the input files is no
              longer required. The application can then safely delete or  mod‐
              ify  the files without affecting the output operation. Normally,
              files are not copied, but are linked whenever possible.  If  the
              -c  option  is not given, then the user should be careful not to
              remove any of the files before the request has been  printed  in
              its entirety. It should also be noted that in the absence of the
              -c option, any changes made to the named files after the request
              is made but before it is printed may be reflected in the printed
              output. On some implementations, -c may be on by default.

       -d  dest
              Specify a string that names the destination ( dest). If dest  is
              a  printer,  the  request shall be printed only on that specific
              printer. If dest is a class of printers, the  request  shall  be
              printed  on  the first available printer that is a member of the
              class. Under certain conditions  (printer  unavailability,  file
              space limitation, and so on), requests for specific destinations
              need not be accepted. Destination names vary between systems.

       If -d is not specified, and neither the LPDEST nor PRINTER  environment
       variable is set, an unspecified destination is used. The -d dest option
       shall take precedence over LPDEST,  which in turn shall take precedence
       over PRINTER.  Results are undefined when dest contains a value that is
       not a valid destination name.

       -m     Send mail (see mailx ) after the files  have  been  printed.  By
              default,  no  mail  is  sent upon normal completion of the print
              request.

       -n  copies
              Write copies number of copies of the files, where  copies  is  a
              positive  decimal  integer.  The  methods for producing multiple
              copies and for arranging the multiple copies when multiple  file
              operands  are  used are unspecified, except that each file shall
              be output as an integral whole, not interleaved with portions of
              other files.

       -o  option
              Specify  printer-dependent  or  class-dependent options. Several
              such options may be collected by specifying the -o  option  more
              than once.

       -s     Suppress messages from lp.

       -t  title
              Write title on the banner page of the output.

       -w     Write a message on the user's terminal after the files have been
              printed.  If the user is not logged in, then mail shall be  sent
              instead.


OPERANDS
       The following operand shall be supported:

       file   A pathname of a file to be output. If no file operands are spec‐
              ified, or if a file operand is '-', the standard input shall  be
              used. If a file operand is used, but the -c option is not speci‐
              fied, the process performing the writing to  the  output  device
              may have user and group permissions that differ from that of the
              process invoking lp.


STDIN
       The standard input shall be used only if no file  operands  are  speci‐
       fied, or if a file operand is '-' .  See the INPUT FILES section.

INPUT FILES
       The input files shall be text files.

ENVIRONMENT VARIABLES
       The following environment variables shall affect the execution of lp:

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
              opposed to multi-byte characters in arguments and input files).

       LC_MESSAGES
              Determine the locale that should be used to  affect  the  format
              and  contents  of  diagnostic messages written to standard error
              and informative messages written to standard output.

       LC_TIME
              Determine the format and contents of date and time strings  dis‐
              played in the lp banner page, if any.

       LPDEST Determine the destination. If the LPDEST environment variable is
              not set, the PRINTER environment variable shall be used. The  -d
              dest option takes precedence over LPDEST . Results are undefined
              when -d is not specified and LPDEST contains a value that is not
              a valid destination name.

       NLSPATH
              Determine the location of message catalogs for the processing of
              LC_MESSAGES .

       PRINTER
              Determine the output device or destination. If  the  LPDEST  and
              PRINTER environment variables are not set, an unspecified output
              device is used. The -d dest option and  the  LPDEST  environment
              variable  shall take precedence over PRINTER.  Results are unde‐
              fined when -d is not specified, LPDEST  is  unset,  and  PRINTER
              contains a value that is not a valid device or destination name.

       TZ     Determine  the  timezone used to calculate date and time strings
              displayed in the lp banner page, if any. If TZ is unset or null,
              an unspecified default timezone shall be used.


ASYNCHRONOUS EVENTS
       Default.

STDOUT
       The  lp utility shall write a request ID to the standard output, unless
       -s is specified. The format of the message is unspecified. The  request
       ID  can  be used on systems supporting the historical cancel and lpstat
       utilities.

STDERR
       The standard error shall be used only for diagnostic messages.

OUTPUT FILES
       None.

EXTENDED DESCRIPTION
       None.

EXIT STATUS
       The following exit values shall be returned:

        0     All input files were processed successfully.

       >0     No output device was available, or an error occurred.


CONSEQUENCES OF ERRORS
       Default.

       The following sections are informative.

APPLICATION USAGE
       The pr and fold utilities can be used to achieve reasonable  formatting
       for the implementation's default page size.

       A conforming application can use one of the file operands only with the
       -c option or if the file is publicly  readable  and  guaranteed  to  be
       available at the time of printing. This is because IEEE Std 1003.1-2001
       gives the implementation the freedom to queue up the request for print‐
       ing at some later time by a different process that might not be able to
       access the file.

EXAMPLES
        1. To print file file:


           lp -c file

        2. To print multiple files with headers:


           pr file1 file2 | lp

RATIONALE
       The lp utility was designed to be a basic version of a utility that  is
       already  available  in  many  historical  implementations. The standard
       developers considered that it should be implementable simply as:


              cat "$@" > /dev/lp

       after appropriate processing of options, if that is how the implementa‐
       tion  chose  to do it and if exclusive access could be granted (so that
       two users did not write to the device simultaneously).  Although in the
       future  the  standard developers may add other options to this utility,
       it should always be able to execute with no  options  or  operands  and
       send the standard input to an unspecified output device.

       This volume of IEEE Std 1003.1-2001 makes no representations concerning
       the format of the printed output, except that it must  be  "human-read‐
       able"  and  "non-volatile".  Thus, writing by default to a disk or tape
       drive or a display terminal would not qualify. (Such  destinations  are
       not prohibited when -d dest, LPDEST,  or PRINTER are used, however.)

       This  volume  of IEEE Std 1003.1-2001 is worded such that a "print job"
       consisting of multiple input files, possibly  in  multiple  copies,  is
       guaranteed  to  print  so  that  any  one  file  is not intermixed with
       another, but there is no statement that all the files or copies have to
       print out together.

       The -c option may imply a spooling operation, but this is not required.
       The utility can be implemented to wait until the printer is  ready  and
       then wait until it is finished. Because of that, there is no attempt to
       define a queuing mechanism (priorities, classes of output, and so on).

       On some historical systems, the request ID reported on the  STDOUT  can
       be used to later cancel or find the status of a request using utilities
       not defined in this volume of IEEE Std 1003.1-2001.

       Although the historical System V lp and BSD lpr utilities have provided
       similar  functionality,  they  used different names for the environment
       variable specifying the destination printer.  Since  the  name  of  the
       utility  here is lp, LPDEST (used by the System V lp utility) was given
       precedence over PRINTER (used by the BSD lpr utility).  Since  environ‐
       ments  of  users  frequently contain one or the other environment vari‐
       able, the lp utility is required to recognize both.  If  this  was  not
       done,  many applications would send output to unexpected output devices
       when users moved from system to system.

       Some have commented that lp has far too little functionality to make it
       worthwhile.  Requests  have  proposed additional options or operands or
       both that added functionality. The requests included:

        * Wording requiring the output to be "hardcopy"

        * A requirement for multiple printers

        * Options for supporting various page-description languages

       Given that a compliant system is not required to even have  a  printer,
       placing  further  restrictions  upon the behavior of the printer is not
       useful. Since hardcopy format is so application-dependent, it is diffi‐
       cult, if not impossible, to select a reasonable subset of functionality
       that should be required on all compliant systems.

       The term unspecified is used in this section in lieu of implementation-
       defined as most known implementations would not be able to make defini‐
       tive statements in their conformance documents; the existence and usage
       of  printers  is very dependent on how the system administrator config‐
       ures each individual system.

       Since the default destination, device  type,  queuing  mechanisms,  and
       acceptable  forms  of  input  are all unspecified, usage guidelines for
       what a conforming application can do are as follows:

        * Use the command in a pipeline, or with -c, so that there are no per‐
          mission problems and the files can be safely deleted or modified.

        * Limit  output to text files of reasonable line lengths and printable
          characters and include no  device-specific  formatting  information,
          such  as a page description language. The meaning of "reasonable" in
          this context can only be  answered  as  a  quality-of-implementation
          issue,  but  it should be apparent from historical usage patterns in
          the industry and the locale. The pr and fold utilities can  be  used
          to  achieve  reasonable  formatting for the default page size of the
          implementation.

       Alternatively, the application can arrange its installation in  such  a
       way  that  it  requires the system administrator or operator to provide
       the appropriate information on lp options and environment variable val‐
       ues.

       At    a    minimum,   having   this   utility   in   this   volume   of
       IEEE Std 1003.1-2001 tells the industry  that  conforming  applications
       require  a  means  to print output and provides at least a command name
       and LPDEST routing mechanism that can be used for  discussions  between
       vendors,  application  writers,  and users.  The use of "should" in the
       DESCRIPTION of lp clearly shows the intent of the standard  developers,
       even  if  they  cannot  mandate that all systems (such as laptops) have
       printers.

       This volume of IEEE Std 1003.1-2001 does not specify what the ownership
       of  the  process performing the writing to the output device may be. If
       -c is not used, it is unspecified whether the  process  performing  the
       writing  to  the output device has permission to read file if there are
       any restrictions in place on who  may  read  file  until  after  it  is
       printed.   Also, if -c is not used, the results of deleting file before
       it is printed are unspecified.

FUTURE DIRECTIONS
       None.

SEE ALSO
       mailx

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



IEEE/The Open Group                  2003                               LP(1P)
LP(4)                      Linux Programmer's Manual                     LP(4)



NAME
       lp - line printer devices

SYNOPSIS
       #include <linux/lp.h>

CONFIGURATION
       lp[0–2] are character devices for the parallel line printers; they have
       major number 6 and minor number 0–2.  The minor numbers  correspond  to
       the  printer  port  base  addresses 0x03bc, 0x0378 and 0x0278.  Usually
       they have mode 220 and are owned by root and group  lp.   You  can  use
       printer  ports  either with polling or with interrupts.  Interrupts are
       recommended when high traffic  is  expected,  for  example,  for  laser
       printers.   For  usual  dot  matrix  printers  polling  will usually be
       enough.  The default is polling.

DESCRIPTION
       The following ioctl(2) calls are supported:

       int ioctl(int fd, LPTIME, int arg)
              Sets the amount of time that the driver sleeps before rechecking
              the  printer  when  the printer's buffer appears to be filled to
              arg.  If you have a fast printer, decrease this number;  if  you
              have  a slow printer then increase it.  This is in hundredths of
              a second, the default 2 being 0.02 seconds.  It only  influences
              the polling driver.

       int ioctl(int fd, LPCHAR, int arg)
              Sets  the  maximum  number  of  busy-wait  iterations  which the
              polling driver does while waiting for the printer to  get  ready
              for  receiving  a  character  to  arg.  If printing is too slow,
              increase this number; if the system gets too slow, decrease this
              number.   The  default  is 1000.  It only influences the polling
              driver.

       int ioctl(int fd, LPABORT, int arg)
              If arg is 0, the printer driver will retry on errors,  otherwise
              it will abort.  The default is 0.

       int ioctl(int fd, LPABORTOPEN, int arg)
              If  arg  is 0, open(2) will be aborted on error, otherwise error
              will be ignored.  The default is to ignore it.

       int ioctl(int fd, LPCAREFUL, int arg)
              If arg is 0, then the out-of-paper, offline  and  error  signals
              are  required  to  be  false  on  all writes, otherwise they are
              ignored.  The default is to ignore them.

       int ioctl(int fd, LPWAIT, int arg)
              Sets the number of busy waiting iterations to wait before strob‐
              ing the printer to accept a just-written character, and the num‐
              ber of iterations to wait before turning the strobe  off  again,
              to  arg.   The  specification  says  this  time  should  be  0.5
              microseconds, but experience has shown the delay caused  by  the
              code  is  already enough.  For that reason, the default value is
              0.  This is used for both the polling and the interrupt driver.

       int ioctl(int fd, LPSETIRQ, int arg)
              This ioctl(2) requires superuser privileges.  It  takes  an  int
              containing  the  new  IRQ  as  argument.   As a side effect, the
              printer will be reset.  When arg is 0, the polling  driver  will
              be used, which is also default.

       int ioctl(int fd, LPGETIRQ, int *arg)
              Stores the currently used IRQ in arg.

       int ioctl(int fd, LPGETSTATUS, int *arg)
              Stores  the  value of the status port in arg.  The bits have the
              following meaning:

              LP_PBUSY     inverted busy input, active high
              LP_PACK      unchanged acknowledge input, active low
              LP_POUTPA    unchanged out-of-paper input, active high
              LP_PSELECD   unchanged selected input, active high
              LP_PERRORP   unchanged error input, active low

              Refer to your printer manual for the  meaning  of  the  signals.
              Note  that  undocumented bits may also be set, depending on your
              printer.

       int ioctl(int fd, LPRESET)
              Resets the printer.  No argument is used.

FILES
       /dev/lp*

SEE ALSO
       chmod(1), chown(1), mknod(1), lpcntl(8), tunelp(8)

COLOPHON
       This page is part of release 3.53 of the Linux  man-pages  project.   A
       description  of  the project, and information about reporting bugs, can
       be found at http://www.kernel.org/doc/man-pages/.



Linux                             1995-01-15                             LP(4)
