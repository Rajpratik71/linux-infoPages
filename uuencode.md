File: *manpages*,  Node: uuencode,  Up: (dir)

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
UUENCODE(5)                   File Formats Manual                  UUENCODE(5)



NAME
       uuencode - format of an encoded uuencode file

DESCRIPTION
       Files  output  by  uuencode(1)  consist of a header line, followed by a
       number of body lines, and a trailer line.  The uudecode(1) command will
       ignore  any lines preceding the header or following the trailer.  Lines
       preceding a header must not, of course, look like a header.

       The header line is distinguished  by  having  the  first  6  characters
       begin   The  word  begin is followed by a mode (in octal), and a string
       which names the remote file.  A space separates the three items in  the
       header line.

       The body consists of a number of lines, each at most 62 characters long
       (including the trailing newline).  These consist of a character  count,
       followed  by  encoded characters, followed by a newline.  The character
       count is a single printing character, and represents  an  integer,  the
       number  of  bytes  the  rest of the line represents.  Such integers are
       always in the range from 0 to 63 and can be determined  by  subtracting
       the character space (octal 40) from the character.

       Groups  of  3  bytes  are stored in 4 characters, 6 bits per character.
       All are offset by a space to make the characters  printing.   The  last
       line  may  be  shorter  than the normal 45 bytes.  If the size is not a
       multiple of 3, this fact can be determined by the value of the count on
       the  last  line.   Extra garbage will be included to make the character
       count a multiple of 4.  The body is terminated by a line with  a  count
       of zero.  This line consists of one ASCII space.

       The trailer line consists of end on a line by itself.

SEE ALSO
       uuencode(1), uudecode(1), uusend(1), uucp(1), mail(1)

HISTORY
       The uuencode file format appeared in BSD 4.0 .



                                                                   UUENCODE(5)
UUENCODE(1P)               POSIX Programmer's Manual              UUENCODE(1P)



PROLOG
       This  manual  page is part of the POSIX Programmer's Manual.  The Linux
       implementation of this interface may differ (consult the  corresponding
       Linux  manual page for details of Linux behavior), or the interface may
       not be implemented on Linux.

NAME
       uuencode - encode a binary file

SYNOPSIS
       uuencode [-m][file] decode_pathname

DESCRIPTION
       The uuencode utility shall write an encoded version of the named  input
       file,  or  standard  input if no file is specified, to standard output.
       The output shall be encoded using one of the  algorithms  described  in
       the  STDOUT  section  and shall include the file access permission bits
       (in chmod octal or  symbolic  notation)  of  the  input  file  and  the
       decode_pathname,  for  re-creation  of  the file on another system that
       conforms to this volume of IEEE Std 1003.1-2001.

OPTIONS
       The uuencode utility shall conform to the Base  Definitions  volume  of
       IEEE Std 1003.1-2001, Section 12.2, Utility Syntax Guidelines.

       The following option shall be supported by the implementation:

       -m     Encode  the  output using the MIME Base64 algorithm described in
              STDOUT.  If  -m  is  not  specified,  the  historical  algorithm
              described in STDOUT shall be used.


OPERANDS
       The following operands shall be supported:

       decode_pathname

              The  pathname  of the file into which the uudecode utility shall
              place the decoded file. Specifying a decode_pathname operand  of
              /dev/stdout shall indicate that uudecode is to use standard out-
              put. If there are characters in decode_pathname that are not  in
              the portable filename character set the results are unspecified.

       file   A pathname of the file to be encoded.


STDIN
       See the INPUT FILES section.

INPUT FILES
       Input files can be files of any type.

ENVIRONMENT VARIABLES
       The following environment variables shall affect the execution of uuen-
       code:

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
              opposed to multi-byte characters in arguments and input files).

       LC_MESSAGES
              Determine  the  locale  that should be used to affect the format
              and contents of diagnostic messages written to standard error.

       NLSPATH
              Determine the location of message catalogs for the processing of
              LC_MESSAGES .


ASYNCHRONOUS EVENTS
       Default.

STDOUT
   uuencode Base64 Algorithm
       The  standard output shall be a text file (encoded in the character set
       of the current locale) that begins with the line:


              "begin-base64 %s %s\n", <mode>, <decode_pathname>

       and ends with the line:


              "====\n"

       In both cases, the lines shall have no preceding or trailing <blank>s.

       The encoding process represents 24-bit groups of input bits  as  output
       strings  of  four  encoded characters. Proceeding from left to right, a
       24-bit input group shall be formed by concatenating three  8-bit  input
       groups.  Each 24-bit input group then shall be treated as four concate-
       nated 6-bit groups, each of which shall be  translated  into  a  single
       digit in the Base64 alphabet. When encoding a bit stream via the Base64
       encoding, the bit stream shall be presumed to be ordered with the most-
       significant  bit  first.  That is, the first bit in the stream shall be
       the high-order bit in the first byte, and the eighth bit shall  be  the
       low-order bit in the first byte, and so on. Each 6-bit group is used as
       an index into an array of 64 printable characters, as shown in uuencode
       Base64 Values .

                            Table: uuencode Base64 Values

          Value Encoding Value Encoding Value Encoding Value Encoding
          0     A        17    R        34    i        51    z
          1     B        18    S        35    j        52    0
          2     C        19    T        36    k        53    1
          3     D        20    U        37    l        54    2
          4     E        21    V        38    m        55    3
          5     F        22    W        39    n        56    4
          6     G        23    X        40    o        57    5
          7     H        24    Y        41    p        58    6
          8     I        25    Z        42    q        59    7
          9     J        26    a        43    r        60    8
          10    K        27    b        44    s        61    9
          11    L        28    c        45    t        62    +
          12    M        29    d        46    u        63    /
          13    N        30    e        47    v

          14    O        31    f        48    w        (pad)──────────
          15    P        32    g        49    x
          16    Q        33    h        50    y

       The  character  referenced  by  the index shall be placed in the output
       string.

       The output stream (encoded bytes) shall be represented in lines  of  no
       more  than  76 characters each. All line breaks or other characters not
       found in the table shall be ignored by decoding software (see  uudecode
       ).

       Special  processing shall be performed if fewer than 24 bits are avail-
       able at the end of a message or encapsulated part of a message. A  full
       encoding  quantum  shall  always  be completed at the end of a message.
       When fewer than 24 input bits are available in  an  input  group,  zero
       bits  shall be added (on the right) to form an integral number of 6-bit
       groups. Output character positions that are not required  to  represent
       actual  input data shall be set to the character '=' . Since all Base64
       input is an integral number of octets, only  the  following  cases  can
       arise:

        1. The  final  quantum of encoding input is an integral multiple of 24
           bits; here, the final unit of encoded output shall be  an  integral
           multiple of 4 characters with no '=' padding.

        2. The  final  quantum of encoding input is exactly 16 bits; here, the
           final unit of encoded output shall be three characters followed  by
           one '=' padding character.

        3. The  final  quantum  of encoding input is exactly 8 bits; here, the
           final unit of encoded output shall be two  characters  followed  by
           two '=' padding characters.

       A  terminating  "===="  evaluates to nothing and denotes the end of the
       encoded data.

   uuencode Historical Algorithm
       The standard output shall be a text file (encoded in the character  set
       of the current locale) that begins with the line:


              "begin %s %s\n" <mode>, <decode_pathname>

       and ends with the line:


              "end\n"

       In both cases, the lines shall have no preceding or trailing <blank>s.

       The  algorithm  that  shall  be used for lines in between begin and end
       takes three octets as input and writes four  characters  of  output  by
       splitting  the  input at six-bit intervals into four octets, containing
       data in the lower six bits only.  These octets shall  be  converted  to
       characters  by adding a value of 0x20 to each octet, so that each octet
       is in the range [0x20,0x5f], and then it shall be assumed to  represent
       a  printable character in the ISO/IEC 646:1991 standard encoded charac-
       ter set. It then shall be translated into the  corresponding  character
       codes  for the codeset in use in the current locale.  (For example, the
       octet 0x41, representing 'A', would be translated to 'A' in the current
       codeset, such as 0xc1 if it were EBCDIC.)

       Where  the  bits of two octets are combined, the least significant bits
       of the first octet shall be shifted left and  combined  with  the  most
       significant  bits  of  the  second  octet shifted right. Thus the three
       octets A, B, C shall be converted into the four octets:


              0x20 + (( A >> 2                    ) & 0x3F)
              0x20 + (((A << 4) | ((B >> 4) & 0xF)) & 0x3F)
              0x20 + (((B << 2) | ((C >> 6) & 0x3)) & 0x3F)
              0x20 + (( C                         ) & 0x3F)

       These octets then shall be translated into the local character set.

       Each encoded line contains a length character, equal to the  number  of
       characters  to  be  decoded plus 0x20 translated to the local character
       set as described above, followed by the encoded characters.  The  maxi-
       mum number of octets to be encoded on each line shall be 45.

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
       The file is expanded by 35 percent (each three octets become four, plus
       control information) causing it to take longer to transmit.

       Since this utility is intended to create files  to  be  used  for  data
       interchange  between  systems  with possibly different codesets, and to
       represent binary data as a text file, the ISO/IEC 646:1991 standard was
       chosen  for a midpoint in the algorithm as a known reference point. The
       output from uuencode is a text file on the local system. If the  output
       were  in  the ISO/IEC 646:1991 standard codeset, it might not be a text
       file (at least because the <newline>s might not match), and the goal of
       creating a text file would be defeated. If this text file was then car-
       ried to another machine with the same codeset, it  would  be  perfectly
       compatible  with  that  system's uudecode. If it was transmitted over a
       mail system or sent to a  machine  with  a  different  codeset,  it  is
       assumed  that, as for every other text file, some translation mechanism
       would convert it (by the time it reached a user on  the  other  system)
       into an appropriate codeset. This translation only makes sense from the
       local codeset, not if the file has been  put  into  a  ISO/IEC 646:1991
       standard  representation  first. Similarly, files processed by uuencode
       can be placed in pax archives, intermixed with other text files in  the
       same codeset.

EXAMPLES
       None.

RATIONALE
       A new algorithm was added at the request of the international community
       to parallel work in RFC 2045 (MIME). As with  the  historical  uuencode
       format,  the  Base64 Content-Transfer-Encoding is designed to represent
       arbitrary sequences of octets in a form that is not humanly readable. A
       65-character  subset of the ISO/IEC 646:1991 standard is used, enabling
       6 bits to be represented per printable character. (The extra 65th char-
       acter, '=', is used to signify a special processing function.)

       This  subset  has the important property that it is represented identi-
       cally in all versions of the ISO/IEC 646:1991  standard,  including  US
       ASCII,  and  all  characters in the subset are also represented identi-
       cally in all versions of EBCDIC. The historical uuencode algorithm does
       not  share  this  property, which is the reason that a second algorithm
       was added to the ISO POSIX-2 standard.

       The string "====" was used for the termination instead of the end  used
       in  the  original  format  because the latter is a string that could be
       valid encoded input.

       In an early draft, the -m option was named -b (for Base64), but it  was
       renamed  to  reflect  its  relationship  to the RFC 2045. A -u was also
       present to invoke the default algorithm, but since this was not histor-
       ical practice, it was omitted as being unnecessary.

       See  the  RATIONALE  section  in  uudecode  for  the  derivation of the
       /dev/stdout symbol.

FUTURE DIRECTIONS
       None.

SEE ALSO
       chmod(), mailx, uudecode

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



IEEE/The Open Group                  2003                         UUENCODE(1P)
