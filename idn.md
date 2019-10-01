File: libidn.info,  Node: Invoking idn,  Next: Emacs API,  Prev: Examples,  Up: Top

10 Invoking idn
***************

10.1 Name
=========

GNU Libidn (idn) - Internationalized Domain Names command line tool

10.2 Description
================

`idn' allows internationalized string preparation (`stringprep'),
encoding and decoding of punycode data, and IDNA ToASCII/ToUnicode
operations to be performed on the command line.

   If strings are specified on the command line, they are used as input
and the computed output is printed to standard output `stdout'.  If no
strings are specified on the command line, the program read data, line
by line, from the standard input `stdin', and print the computed output
to standard output.  What processing is performed (e.g., ToASCII, or
Punycode encode) is indicated by options.  If any errors are
encountered, the execution of the applications is aborted.

   All strings are expected to be encoded in the preferred charset used
by your locale.  Use `--debug' to find out what this charset is.  You
can override the charset used by setting environment variable `CHARSET'.

   To process a string that starts with `-', for example `-foo', use
`--' to signal the end of parameters, as in `idn --quiet -a -- -foo'.

10.3 Options
============

`idn' recognizes these commands:

  -h, --help               Print help and exit

  -V, --version            Print version and exit

  -s, --stringprep         Prepare string according to nameprep profile

  -d, --punycode-decode    Decode Punycode

  -e, --punycode-encode    Encode Punycode

  -a, --idna-to-ascii      Convert to ACE according to IDNA (default mode)

  -u, --idna-to-unicode    Convert from ACE according to IDNA

      --allow-unassigned   Toggle IDNA AllowUnassigned flag (default off)

      --usestd3asciirules  Toggle IDNA UseSTD3ASCIIRules flag (default off)

      --no-tld             Don't check string for TLD specific rules
                             Only for --idna-to-ascii and --idna-to-unicode

  -n, --nfkc               Normalize string according to Unicode v3.2 NFKC

  -p, --profile=STRING     Use specified stringprep profile instead
                             Valid stringprep profiles: `Nameprep',
                             `iSCSI', `Nodeprep', `Resourceprep',
                             `trace', `SASLprep'

      --debug              Print debugging information

      --quiet              Silent operation

10.4 Environment Variables
==========================

The CHARSET environment variable can be used to override what character
set to be used for decoding incoming data (i.e., on the command line or
on the standard input stream), and to encode data to the standard
output.  If your system is set up correctly, however, the application
will guess which character set is used automatically.  Example usage:

     $ CHARSET=ISO-8859-1 idn --punycode-encode
     ...

10.5 Examples
=============

Standard usage, reading input from standard input:

     jas@latte:~$ idn
     libidn 0.3.5
     Copyright 2002, 2003 Simon Josefsson.
     GNU Libidn comes with NO WARRANTY, to the extent permitted by law.
     You may redistribute copies of GNU Libidn under the terms of
     the GNU Lesser General Public License.  For more information
     about these matters, see the file named COPYING.LIB.
     Type each input string on a line by itself, terminated by a newline character.
     rÃ¤ksmÃ¶rgÃ¥s.se
     xn--rksmrgs-5wao1o.se
     jas@latte:~$

   Reading input from command line, and disable printing copyright and
license information:

     jas@latte:~$ idn --quiet rÃ¤ksmÃ¶rgÃ¥s.se blÃ¥bÃ¦rgrÃ¸d.no
     xn--rksmrgs-5wao1o.se
     xn--blbrgrd-fxak7p.no
     jas@latte:~$

   Accessing a specific StringPrep profile directly:

     jas@latte:~$ idn --quiet --profile=SASLprep --stringprep teÃtÂª
     teÃta
     jas@latte:~$

10.6 Troubleshooting
====================

Getting character data encoded right, and making sure Libidn use the
same encoding, can be difficult.  The reason for this is that most
systems encode character data in more than one character encoding,
i.e., using `UTF-8' together with `ISO-8859-1' or `ISO-2022-JP'.  This
problem is likely to continue to exist until only one character
encoding come out as the evolutionary winner, or (more likely, at least
to some extents) forever.

   The first step to troubleshooting character encoding problems with
Libidn is to use the `--debug' parameter to find out which character
set encoding `idn' believe your locale uses.

     jas@latte:~$ idn --debug --quiet ""
     system locale uses charset `UTF-8'.

     jas@latte:~$

   If it prints `ANSI_X3.4-1968' (i.e., `US-ASCII'), this indicate you
have not configured your locale properly.  To configure the locale, you
can, for example, use `LANG=sv_SE.UTF-8; export LANG' at a `/bin/sh'
prompt, to set up your locale for a Swedish environment using `UTF-8'
as the encoding.

   Sometimes `idn' appear to be unable to translate from your system
locale into `UTF-8' (which is used internally), and you get an error
like the following:

     jas@latte:~$ idn --quiet foo
     idn: could not convert from ISO-8859-1 to UTF-8.
     jas@latte:~$

   The simplest explanation is that you haven't installed the `iconv'
conversion tools.  You can find it as a standalone library in GNU
Libiconv (`http://www.gnu.org/software/libiconv/').  On many GNU/Linux
systems, this library is part of the system, but you may have to
install additional packages (e.g., `glibc-locale' for Debian) to be
able to use it.

   Another explanation is that the error is correct and you are feeding
`idn' invalid data.  This can happen inadvertently if you are not
careful with the character set encoding you use.  For example, if your
shell run in a `ISO-8859-1' environment, and you invoke `idn' with the
`CHARSET' environment variable as follows, you will feed it
`ISO-8859-1' characters but force it to believe they are `UTF-8'.
Naturally this will lead to an error, unless the byte sequences happen
to be valid `UTF-8'.  Note that even if you don't get an error, the
output may be incorrect in this situation, because `ISO-8859-1' and
`UTF-8' does not in general encode the same characters as the same byte
sequences.

     jas@latte:~$ idn --quiet --debug ""
     system locale uses charset `ISO-8859-1'.

     jas@latte:~$ CHARSET=UTF-8 idn --quiet --debug rÃ¤ksmÃ¶rgÃ¥s
     system locale uses charset `UTF-8'.
     input[0] = U+0072
     input[1] = U+4af3
     input[2] = U+006d
     input[3] = U+1b29e5
     input[4] = U+0073
     output[0] = U+0078
     output[1] = U+006e
     output[2] = U+002d
     output[3] = U+002d
     output[4] = U+0072
     output[5] = U+006d
     output[6] = U+0073
     output[7] = U+002d
     output[8] = U+0068
     output[9] = U+0069
     output[10] = U+0036
     output[11] = U+0064
     output[12] = U+0035
     output[13] = U+0039
     output[14] = U+0037
     output[15] = U+0035
     output[16] = U+0035
     output[17] = U+0032
     output[18] = U+0061
     xn--rms-hi6d597552a
     jas@latte:~$

   The sense moral here is to forget about `CHARSET' (configure your
locales properly instead) unless you know what you are doing, and if
you want to use it, do it carefully, after verifying with `--debug'
that you get the desired results.

