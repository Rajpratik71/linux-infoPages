File: *manpages*,  Node: uudecode,  Up: (dir)

uuencode(1)                 General Commands Manual                uuencode(1)



NAME
       uuencode, uudecode - encode a binary file, or decode its representation

SYNOPSIS
       uuencode [-m] [ file ] name

       uudecode [-o outfile] [ file ]...

DESCRIPTION
       Uuencode  and  uudecode are used to transmit binary files over channels
       that support only simple ASCII data.

       Uuencode reads file (or by default the standard input)  and  writes  an
       encoded  version  to  the  standard  output, using only printable ASCII
       characters.  The encoded output begins with a header, for use by  uude-
       code,  which  records  the mode of the input file and suggests name for
       the decoded file that will be created.  (If name  is  /dev/stdout  then
       uudecode  will decode to standard output.)  The encoding has the format
       documented at uuencode(5), unless the option -m is given,  when  base64
       encoding is used instead.

       Note:  uuencode  uses  buffered  input  and assumes that it is not hand
       typed from a tty.  The consequence is that at a tty, you  may  need  to
       hit Ctl-D several times to terminate input.

       Uudecode transforms uuencoded files (or standard input) into the origi-
       nal form.  The resulting file is named  name  (or  outfile  if  the  -o
       option  is  given)  and  will have the mode of the original file except
       that setuid and execute bits are not retained.  If outfile or  name  is
       /dev/stdout  the  result  will be written to standard output.  Uudecode
       ignores any leading and trailing lines.  The  program  determines  from
       the header which of the two supported encoding schemes was used.

EXAMPLES
       The  following  example packages up a source tree, compresses it, uuen-
       codes it and mails it to a user on another system.   When  uudecode  is
       run  on  the target system, the file ``src_tree.tar.Z'' will be created
       which may then be uncompressed and extracted into the original tree.

              tar cf - src_tree | compress |
              uuencode src_tree.tar.Z | mail sys1!sys2!user

SEE ALSO
       compress(1), mail(1), uucp(1), uuencode(5)

STANDARDS
       This implementation is compliant with P1003.2b/D11.

BUGS
       If more than one file is given to uudecode and the -o option  is  given
       or  more  than one name in the encoded files are the same the result is
       probably not what is expected.

       The encoded form of the file is expanded by 37% for UU encoding and  by
       35% for base64 encoding (3 bytes become 4 plus control information).

REPORTING BUGS
       Report  bugs to <bug-gnu-utils@gnu.org>.  Please put sharutils or uuen-
       code in the subject line.  It helps to spot the message.

HISTORY
       The uuencode command appeared in BSD 4.0.



                                                                   uuencode(1)
UUDECODE(1P)               POSIX Programmer's Manual              UUDECODE(1P)



PROLOG
       This  manual  page is part of the POSIX Programmer's Manual.  The Linux
       implementation of this interface may differ (consult the  corresponding
       Linux  manual page for details of Linux behavior), or the interface may
       not be implemented on Linux.

NAME
       uudecode - decode a binary file

SYNOPSIS
       uudecode [-o outfile][file]

DESCRIPTION
       The uudecode utility shall read a file, or standard input if no file is
       specified,  that  includes  data  created  by the uuencode utility. The
       uudecode utility shall scan the input file, searching for data compati-
       ble  with one of the formats specified in uuencode, and attempt to cre-
       ate or overwrite the file described by the data (or overridden  by  the
       -o option). The pathname shall be contained in the data or specified by
       the -o option. The file access permission bits  and  contents  for  the
       file  to  be produced shall be contained in that data. The mode bits of
       the created file (other than standard output) shall  be  set  from  the
       file  access  permission  bits  contained  in  the data; that is, other
       attributes of the mode, including the  file  mode  creation  mask  (see
       umask()), shall not affect the file being produced.

       If  the  pathname  of the file to be produced exists, and the user does
       not have write permission on that file, uudecode shall  terminate  with
       an  error.  If  the pathname of the file to be produced exists, and the
       user has write permission on that file,  the  existing  file  shall  be
       overwritten.

       If the input data was produced by uuencode on a system with a different
       number of bits per byte than on the target system, the results of uude-
       code are unspecified.

OPTIONS
       The  uudecode  utility  shall conform to the Base Definitions volume of
       IEEE Std 1003.1-2001, Section 12.2, Utility Syntax Guidelines.

       The following option shall be supported by the implementation:

       -o  outfile
              A pathname of a file that shall be used instead of any  pathname
              contained  in the input data. Specifying an outfile option-argu-
              ment of /dev/stdout shall indicate standard output.


OPERANDS
       The following operand shall be supported:

       file   The pathname of a file containing the output of uuencode.


STDIN
       See the INPUT FILES section.

INPUT FILES
       The input files shall be files containing the output of uuencode.

ENVIRONMENT VARIABLES
       The following environment variables shall affect the execution of uude-
       code:

       LANG   Provide  a  default value for the internationalization variables
              that are unset or null. (See  the  Base  Definitions  volume  of
              IEEE Std 1003.1-2001,  Section  8.2,  Internationalization Vari-
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
              and contents of diagnostic messages written to standard error.

       NLSPATH
              Determine the location of message catalogs for the processing of
              LC_MESSAGES .


ASYNCHRONOUS EVENTS
       Default.

STDOUT
       If the file data header encoded by uuencode is - or /dev/stdout, or the
       -o  /dev/stdout  option  overrides  the  file data, the standard output
       shall be in the same format as the file originally encoded by uuencode.
       Otherwise, the standard output shall not be used.

STDERR
       The standard error shall be used only for diagnostic messages.

OUTPUT FILES
       The  output  file  shall  be  in the same format as the file originally
       encoded by uuencode.

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
       The user who is invoking uudecode must have  write  permission  on  any
       file being created.

       The output of uuencode is essentially an encoded bit stream that is not
       cognizant of byte boundaries. It is possible that a 9-bit  byte  target
       machine  can  process input from an 8-bit source, if it is aware of the
       requirement, but the reverse is unlikely to be satisfying.  Of  course,
       the  only data that is meaningful for such a transfer between architec-
       tures is generally character data.

EXAMPLES
       None.

RATIONALE
       Input files are not necessarily text files, as stated by an early  pro-
       posal.  Although  the uuencode output is a text file, that output could
       have been wrapped within another file or mail message  that  is  not  a
       text file.

       The  -o option is not historical practice, but was added at the request
       of WG15 so that the user could override  the  target  pathname  without
       having to edit the input data itself.

       In early drafts, the [ -o outfile] option-argument allowed the use of -
       to mean standard output. The symbol - has only been used previously  in
       IEEE Std 1003.1-2001  as  a standard input indicator. The developers of
       the standard did not wish to overload the meaning of - in this  manner.
       The  /dev/stdout concept exists on most modern systems. The /dev/stdout
       syntax does not refer to a new special file. It is just a magic  cookie
       to specify standard output.

FUTURE DIRECTIONS
       None.

SEE ALSO
       umask(), uuencode

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



IEEE/The Open Group                  2003                         UUDECODE(1P)
