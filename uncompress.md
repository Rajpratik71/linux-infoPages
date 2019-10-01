File: *manpages*,  Node: uncompress,  Up: (dir)

COMPRESS(1)                 General Commands Manual                COMPRESS(1)



NAME
       compress, uncompress, zcat - compress and expand data

SYNOPSIS
       compress [ -f ] [ -v ] [ -c ] [ -V ] [ -r ] [ -b bits ] [ name ...  ]
       uncompress [ -f ] [ -v ] [ -c ] [ -V ] [ name ...  ]
       zcat [ -V ] [ name ...  ]

DESCRIPTION
       Compress  reduces the size of the named files using adaptive Lempel-Ziv
       coding.  Whenever possible, each file  is  replaced  by  one  with  the
       extension  .Z, while keeping the same ownership modes, access and modi‐
       fication times.  If no files are specified, the standard input is  com‐
       pressed to the standard output.  Compress will only attempt to compress
       regular files.  In particular, it will ignore symbolic links. If a file
       has multiple hard links, compress will refuse to compress it unless the
       -f flag is given.

       If -f is not given and compress is run in the foreground, the  user  is
       prompted as to whether an existing file should be overwritten.

       Compressed  files  can  be restored to their original form using uncom‐
       press or zcat.

       uncompress takes a list of files on its command line and replaces  each
       file  whose  name  ends with .Z and which begins with the correct magic
       number with an uncompressed file without the .Z.  The uncompressed file
       will have the mode, ownership and timestamps of the compressed file.

       The  -c  option makes compress/uncompress write to the standard output;
       no files are changed.

       zcat is identical to uncompress -c.  zcat uncompresses either a list of
       files  on  the command line or its standard input and writes the uncom‐
       pressed data on standard output.  zcat will uncompress files that  have
       the correct magic number whether they have a .Z suffix or not.

       If  the -r flag is specified, compress will operate recursively. If any
       of the file names specified on the command line are  directories,  com‐
       press  will  descend  into  the directory and compress all the files it
       finds there.

       The -V flag tells each of these  programs  to  print  its  version  and
       patchlevel, along with any preprocessor flags specified during compila‐
       tion, on stderr before doing any compression or uncompression.

       Compress uses the modified Lempel-Ziv algorithm popularized in "A Tech‐
       nique for High Performance Data Compression", Terry A. Welch, IEEE Com‐
       puter, vol. 17, no. 6 (June 1984), pp. 8-19.  Common substrings in  the
       file  are  first  replaced by 9-bit codes 257 and up.  When code 512 is
       reached, the algorithm switches to 10-bit codes and  continues  to  use
       more  bits until the limit specified by the -b flag is reached (default
       16).  Bits must be between 9 and 16.  The default can be changed in the
       source to allow compress to be run on a smaller machine.

       After the bits limit is attained, compress periodically checks the com‐
       pression ratio.  If it is increasing, compress  continues  to  use  the
       existing code dictionary.  However, if the compression ratio decreases,
       compress discards the table of substrings and rebuilds it from scratch.
       This allows the algorithm to adapt to the next "block" of the file.

       Note that the -b flag is omitted for uncompress, since the bits parame‐
       ter specified during compression is encoded within  the  output,  along
       with a magic number to ensure that neither decompression of random data
       nor recompression of compressed data is attempted.

       The amount of compression obtained depends on the size  of  the  input,
       the number of bits per code, and the distribution of common substrings.
       Typically, text such as source code or English is  reduced  by  50-60%.
       Compression is generally much better than that achieved by Huffman cod‐
       ing (as used in pack), or adaptive Huffman coding (compact), and  takes
       less time to compute.

       Under  the  -v  option, a message is printed yielding the percentage of
       reduction for each file compressed.

DIAGNOSTICS
       Exit status is normally 0; if the last file is larger after (attempted)
       compression, the status is 2; if an error occurs, exit status is 1.

       Usage: compress [-dfvcVr] [-b maxbits] [file ...]
               Invalid options were specified on the command line.
       Missing maxbits
               Maxbits must follow -b.
       file: not in compressed format
               The file specified to uncompress has not been compressed.
       file: compressed with xx bits, can only handle yy bits
               File was compressed by a program that could deal with more bits
               than the compress code on this machine.   Recompress  the  file
               with smaller bits.
       file: already has .Z suffix -- no change
               The  file is assumed to be already compressed.  Rename the file
               and try again.
       file: filename too long to tack on .Z
               The file cannot be compressed because its name is  longer  than
               12  characters.   Rename  and try again.  This message does not
               occur on BSD systems.
       file already exists; do you wish to overwrite (y or n)?
               Respond "y" if you want the output file to be replaced; "n"  if
               not.
       uncompress: corrupt input
               A  SIGSEGV  violation was detected which usually means that the
               input file has been corrupted.
       Compression: xx.xx%
               Percentage of the input saved by compression.   (Relevant  only
               for -v.)
       -- not a regular file or directory: ignored
               When the input file is not a regular file or directory, (e.g. a
               symbolic link, socket, FIFO, device file),  it  is  left  unal‐
               tered.
       -- has xx other links: unchanged
               The  input file has links; it is left unchanged.  See ln(1) for
               more information. Use the -f flag to force compression of  mul‐
               tiply-linked files.
       -- file unchanged
               No  savings is achieved by compression.  The input remains vir‐
               gin.

BUGS
       Although compressed files are compatible between  machines  with  large
       memory,  -b12  should be used for file transfer to architectures with a
       small process data space (64KB or less, as exhibited  by  the  DEC  PDP
       series, the Intel 80286, etc.)

       Invoking  compress with a -r flag will occasionally cause it to produce
       spurious error warnings of the form

        "<filename>.Z already has .Z suffix - ignored"

       These warnings can be ignored. See the  comments  in  compress42.c:com‐
       pdir() in the source distribution for an explanation.

SEE ALSO
       pack(1), compact(1)



                                     local                         COMPRESS(1)
UNCOMPRESS(1P)             POSIX Programmer's Manual            UNCOMPRESS(1P)



PROLOG
       This  manual  page is part of the POSIX Programmer's Manual.  The Linux
       implementation of this interface may differ (consult the  corresponding
       Linux  manual page for details of Linux behavior), or the interface may
       not be implemented on Linux.

NAME
       uncompress - expand compressed data

SYNOPSIS
       uncompress [-cfv][file...]

DESCRIPTION
       The uncompress utility shall restore  files  to  their  original  state
       after  they  have  been  compressed  using the compress utility.  If no
       files are specified, the standard input shall be  uncompressed  to  the
       standard  output.  If  the invoking process has appropriate privileges,
       the ownership, modes, access time, and modification time of the  origi‐
       nal file shall be preserved.

       This  utility  shall support the uncompressing of any files produced by
       the compress utility on the same implementation. For files produced  by
       compress  on other systems, uncompress supports 9 to 14-bit compression
       (see compress, -b); it is implementation-defined whether values  of  -b
       greater than 14 are supported.

OPTIONS
       The  uncompress utility shall conform to the Base Definitions volume of
       IEEE Std 1003.1-2001, Section 12.2, Utility Syntax Guidelines.

       The following options shall be supported:

       -c     Write to standard output; no files are changed.

       -f     Do not prompt for overwriting files.  Except  when  run  in  the
              background,  if -f is not given the user shall be prompted as to
              whether an existing file should be overwritten. If the  standard
              input  is  not  a terminal and -f is not given, uncompress shall
              write a diagnostic message to standard error  and  exit  with  a
              status greater than zero.

       -v     Write  messages  to  standard  error concerning the expansion of
              each file.


OPERANDS
       The following operand shall be supported:

       file   A pathname of a file. If file already has the .Z  suffix  speci‐
              fied,  it  shall  be  used as the input file and the output file
              shall be named file with the .Z suffix removed.  Otherwise, file
              shall  be  used as the name of the output file and file with the
              .Z suffix appended shall be used as the input file.


STDIN
       The standard input shall be used only if no file  operands  are  speci‐
       fied, or if a file operand is '-' .

INPUT FILES
       Input files shall be in the format produced by the compress utility.

ENVIRONMENT VARIABLES
       The  following  environment  variables  shall  affect  the execution of
       uncompress:

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
       When  there  are  no  file  operands or the -c option is specified, the
       uncompressed output is written to standard output.

STDERR
       Prompts shall be written to the standard error output under the  condi‐
       tions  specified  in the DESCRIPTION and OPTIONS sections.  The prompts
       shall contain the file pathname, but their format is otherwise unspeci‐
       fied. Otherwise, the standard error output shall be used only for diag‐
       nostic messages.

OUTPUT FILES
       Output files are the same as the respective input files to compress.

EXTENDED DESCRIPTION
       None.

EXIT STATUS
       The following exit values shall be returned:

        0     Successful completion.

       >0     An error occurred.


CONSEQUENCES OF ERRORS
       The input file remains unmodified.

       The following sections are informative.

APPLICATION USAGE
       The limit of 14 on the compress -b bits argument is to  achieve  porta‐
       bility  to  all systems (within the restrictions imposed by the lack of
       an explicit published  file  format).  Some  implementations  based  on
       16-bit architectures cannot support 15 or 16-bit uncompression.

EXAMPLES
       None.

RATIONALE
       None.

FUTURE DIRECTIONS
       None.

SEE ALSO
       compress, zcat

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



IEEE/The Open Group                  2003                       UNCOMPRESS(1P)
