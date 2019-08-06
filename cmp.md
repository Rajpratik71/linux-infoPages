File: diffutils.info-t,  Node: Invoking cmp,  Next: Invoking diff,  Prev: Making Patches,  Up: Top

12 Invoking 'cmp'
*****************

The 'cmp' command compares two files, and if they differ, tells the
first byte and line number where they differ or reports that one file is
a prefix of the other.  Bytes and lines are numbered starting with 1.
The arguments of 'cmp' are as follows:

     cmp OPTIONS... FROM-FILE [TO-FILE [FROM-SKIP [TO-SKIP]]]

   The file name '-' is always the standard input.  'cmp' also uses the
standard input if one file name is omitted.  The FROM-SKIP and TO-SKIP
operands specify how many bytes to ignore at the start of each file;
they are equivalent to the '--ignore-initial=FROM-SKIP:TO-SKIP' option.

   By default, 'cmp' outputs nothing if the two files have the same
contents.  If the two files have bytes that differ, 'cmp' reports the
location of the first difference to standard output:

     FROM-FILE TO-FILE differ: char BYTE-NUMBER, line LINE-NUMBER

If one file is a prefix of the other, 'cmp' reports the shorter file's
name to standard error, followed by a blank and extra information about
the shorter file:

     cmp: EOF on SHORTER-FILE EXTRA-INFO

   The message formats can differ outside the POSIX locale.  POSIX
allows but does not require the EOF diagnostic's file name to be
followed by a blank and additional information.

   An exit status of 0 means no differences were found, 1 means some
differences were found, and 2 means trouble.

* Menu:

* cmp Options:: Summary of options to 'cmp'.

File: diffutils.info-t,  Node: cmp Options,  Up: Invoking cmp

12.1 Options to 'cmp'
=====================

Below is a summary of all of the options that GNU 'cmp' accepts.  Most
options have two equivalent names, one of which is a single letter
preceded by '-', and the other of which is a long name preceded by '--'.
Multiple single letter options (unless they take an argument) can be
combined into a single command line word: '-bl' is equivalent to '-b
-l'.

'-b'
'--print-bytes'
     Print the differing bytes.  Display control bytes as a '^' followed
     by a letter of the alphabet and precede bytes that have the high
     bit set with 'M-' (which stands for "meta").

'--help'
     Output a summary of usage and then exit.

'-i SKIP'
'--ignore-initial=SKIP'
     Ignore any differences in the first SKIP bytes of the input files.
     Treat files with fewer than SKIP bytes as if they are empty.  If
     SKIP is of the form 'FROM-SKIP:TO-SKIP', skip the first FROM-SKIP
     bytes of the first input file and the first TO-SKIP bytes of the
     second.

'-l'
'--verbose'
     Output the (decimal) byte numbers and (octal) values of all
     differing bytes, instead of the default standard output.  Each
     output line contains a differing byte's number relative to the
     start of the input, followed by the differing byte values.  Byte
     numbers start at 1.  Also, output the EOF message if one file is
     shorter than the other.

'-n COUNT'
'--bytes=COUNT'
     Compare at most COUNT input bytes.

'-s'
'--quiet'
'--silent'
     Do not print anything; only return an exit status indicating
     whether the files differ.

'-v'
'--version'
     Output version information and then exit.

   In the above table, operands that are byte counts are normally
decimal, but may be preceded by '0' for octal and '0x' for hexadecimal.

   A byte count can be followed by a suffix to specify a multiple of
that count; in this case an omitted integer is understood to be 1.  A
bare size letter, or one followed by 'iB', specifies a multiple using
powers of 1024.  A size letter followed by 'B' specifies powers of 1000
instead.  For example, '-n 4M' and '-n 4MiB' are equivalent to '-n
4194304', whereas '-n 4MB' is equivalent to '-n 4000000'.  This notation
is upward compatible with the SI prefixes
(http://www.bipm.fr/enus/3_SI/si-prefixes.html) for decimal multiples
and with the IEC 60027-2 prefixes for binary multiples
(http://physics.nist.gov/cuu/Units/binary.html).

   The following suffixes are defined.  Large sizes like '1Y' may be
rejected by your computer due to limitations of its arithmetic.

'kB'
     kilobyte: 10^3 = 1000.
'k'
'K'
'KiB'
     kibibyte: 2^10 = 1024.  'K' is special: the SI prefix is 'k' and
     the IEC 60027-2 prefix is 'Ki', but tradition and POSIX use 'k' to
     mean 'KiB'.
'MB'
     megabyte: 10^6 = 1,000,000.
'M'
'MiB'
     mebibyte: 2^20 = 1,048,576.
'GB'
     gigabyte: 10^9 = 1,000,000,000.
'G'
'GiB'
     gibibyte: 2^30 = 1,073,741,824.
'TB'
     terabyte: 10^12 = 1,000,000,000,000.
'T'
'TiB'
     tebibyte: 2^40 = 1,099,511,627,776.
'PB'
     petabyte: 10^15 = 1,000,000,000,000,000.
'P'
'PiB'
     pebibyte: 2^50 = 1,125,899,906,842,624.
'EB'
     exabyte: 10^18 = 1,000,000,000,000,000,000.
'E'
'EiB'
     exbibyte: 2^60 = 1,152,921,504,606,846,976.
'ZB'
     zettabyte: 10^21 = 1,000,000,000,000,000,000,000
'Z'
'ZiB'
     2^70 = 1,180,591,620,717,411,303,424.  ('Zi' is a GNU extension to
     IEC 60027-2.)
'YB'
     yottabyte: 10^24 = 1,000,000,000,000,000,000,000,000.
'Y'
'YiB'
     2^80 = 1,208,925,819,614,629,174,706,176.  ('Yi' is a GNU extension
     to IEC 60027-2.)

