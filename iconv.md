ICONV(1)                                   Linux User Manual                                  ICONV(1)

NAME
       iconv - convert text from one character encoding to another

SYNOPSIS
       iconv [options] [-f from-encoding] [-t to-encoding] [inputfile]...

DESCRIPTION
       The  iconv  program reads in text in one encoding and outputs the text in another encoding.  If
       no input files are given, or if it is given as a dash (-), iconv reads from standard input.  If
       no output file is given, iconv writes to standard output.

       If no from-encoding is given, the default is derived from the current locale's character encod‐
       ing.  If no to-encoding is given, the default is derived from the  current  locale's  character
       encoding.

OPTIONS
       -f from-encoding, --from-code=from-encoding
              Use from-encoding for input characters.

       -t to-encoding, --to-code=to-encoding
              Use to-encoding for output characters.

              If  the  string //IGNORE is appended to to-encoding, characters that cannot be converted
              are discarded and an error is printed after conversion.

              If the string //TRANSLIT is appended to  to-encoding,  characters  being  converted  are
              transliterated  when  needed  and  possible.  This means that when a character cannot be
              represented in the target character set, it can be approximated through one  or  several
              similar looking characters.  Characters that are outside of the target character set and
              cannot be transliterated are replaced with a question mark (?) in the output.

       -l, --list
              List all known character set encodings.

       -c     Silently discard characters that cannot be converted instead of terminating when encoun‐
              tering such characters.

       -o outputfile, --output=outputfile
              Use outputfile for output.

       -s, --silent
              This option is ignored; it is provided only for compatibility.

       --verbose
              Print progress information on standard error when processing multiple files.

       -?, --help
              Print a usage summary and exit.

       --usage
              Print a short usage summary and exit.

       -V, --version
              Print the version number, license, and disclaimer of warranty for iconv.

EXIT STATUS
       Zero on success, nonzero on errors.

ENVIRONMENT
       Internally,  the iconv program uses the iconv(3) function which in turn uses gconv modules (dy‐
       namically loaded shared libraries) to convert to and from  a  character  set.   Before  calling
       iconv(3),  the  iconv  program must first allocate a conversion descriptor using iconv_open(3).
       The operation of the latter function is influenced by the setting of the GCONV_PATH environment
       variable:

       *  If  GCONV_PATH  is  not set, iconv_open(3) loads the system gconv module configuration cache
          file created by iconvconfig(8) and then, based on the configuration, loads the gconv modules
          needed  to  perform  the conversion.  If the system gconv module configuration cache file is
          not available then the system gconv module configuration file is used.

       *  If GCONV_PATH is defined (as a colon-separated list of pathnames), the system  gconv  module
          configuration  cache is not used.  Instead, iconv_open(3) first tries to load the configura‐
          tion files by searching the directories in GCONV_PATH in order, followed by the  system  de‐
          fault  gconv module configuration file.  If a directory does not contain a gconv module con‐
          figuration file, any gconv modules that it may contain are ignored.  If a directory contains
          a gconv module configuration file and it is determined that a module needed for this conver‐
          sion is available in the directory, then the needed module is loaded  from  that  directory,
          the  order  being such that the first suitable module found in GCONV_PATH is used.  This al‐
          lows users to use custom modules and even replace system-provided modules by providing  such
          modules in GCONV_PATH directories.

FILES
       /usr/lib/gconv
              Usual default gconv module path.

       /usr/lib/gconv/gconv-modules
              Usual system default gconv module configuration file.

       /usr/lib/gconv/gconv-modules.cache
              Usual system gconv module configuration cache.

CONFORMING TO
       POSIX.1-2001.

EXAMPLE
       Convert text from the ISO 8859-15 character encoding to UTF-8:

           $ iconv -f ISO-8859-15 -t UTF-8 < input.txt > output.txt

       The next example converts from UTF-8 to ASCII, transliterating when possible:

           $ echo abc ß α € àḃç | iconv -f UTF-8 -t ASCII//TRANSLIT
           abc ss ? EUR abc

SEE ALSO
       locale(1), uconv(1), iconv(3), nl_langinfo(3), charsets(7), iconvconfig(8)

COLOPHON
       This  page  is  part  of  release  5.02  of  the Linux man-pages project.  A description of the
       project, information about reporting bugs, and the latest version of this page, can be found at
       https://www.kernel.org/doc/man-pages/.

GNU                                           2019-03-06                                      ICONV(1)
ICONV(3)                               Linux Programmer's Manual                              ICONV(3)

NAME
       iconv - perform character set conversion

SYNOPSIS
       #include <iconv.h>

       size_t iconv(iconv_t cd,
                    char **inbuf, size_t *inbytesleft,
                    char **outbuf, size_t *outbytesleft);

DESCRIPTION
       The  iconv() function converts a sequence of characters in one character encoding to a sequence
       of characters in another character encoding.  The cd argument is a conversion descriptor,  pre‐
       viously created by a call to iconv_open(3); the conversion descriptor defines the character en‐
       codings that iconv() uses for the conversion.  The inbuf argument is the address of a  variable
       that  points  to the first character of the input sequence; inbytesleft indicates the number of
       bytes in that buffer.  The outbuf argument is the address of a  variable  that  points  to  the
       first byte available in the output buffer; outbytesleft indicates the number of bytes available
       in the output buffer.

       The main case is when inbuf is not NULL and *inbuf is not NULL.   In  this  case,  the  iconv()
       function converts the multibyte sequence starting at *inbuf to a multibyte sequence starting at
       *outbuf.  At most *inbytesleft bytes, starting at *inbuf, will be read.  At most  *outbytesleft
       bytes, starting at *outbuf, will be written.

       The iconv() function converts one multibyte character at a time, and for each character conver‐
       sion it increments *inbuf and decrements *inbytesleft by the number of converted  input  bytes,
       it increments *outbuf and decrements *outbytesleft by the number of converted output bytes, and
       it updates the conversion state contained in cd.  If the character encoding  of  the  input  is
       stateful,  the  iconv() function can also convert a sequence of input bytes to an update to the
       conversion state without producing any output bytes; such input is  called  a  shift  sequence.
       The conversion can stop for four reasons:

       1. An  invalid  multibyte sequence is encountered in the input.  In this case, it sets errno to
          EILSEQ and returns (size_t) -1.  *inbuf is left pointing to the  beginning  of  the  invalid
          multibyte sequence.

       2. The  input byte sequence has been entirely converted, that is, *inbytesleft has gone down to
          0.  In this case, iconv() returns the number of nonreversible conversions  performed  during
          this call.

       3. An  incomplete  multibyte  sequence is encountered in the input, and the input byte sequence
          terminates after it.  In this case, it sets errno to EINVAL and returns (size_t) -1.  *inbuf
          is left pointing to the beginning of the incomplete multibyte sequence.

       4. The  output buffer has no more room for the next converted character.  In this case, it sets
          errno to E2BIG and returns (size_t) -1.

       A different case is when inbuf is NULL or *inbuf is NULL, but outbuf is not NULL and *outbuf is
       not NULL.  In this case, the iconv() function attempts to set cd's conversion state to the ini‐
       tial state and store a corresponding shift sequence at *outbuf.  At most  *outbytesleft  bytes,
       starting at *outbuf, will be written.  If the output buffer has no more room for this reset se‐
       quence, it sets errno to E2BIG and returns (size_t) -1.  Otherwise, it increments  *outbuf  and
       decrements *outbytesleft by the number of bytes written.

       A  third  case  is when inbuf is NULL or *inbuf is NULL, and outbuf is NULL or *outbuf is NULL.
       In this case, the iconv() function sets cd's conversion state to the initial state.

RETURN VALUE
       The iconv() function returns the number of characters converted in a nonreversible  way  during
       this call; reversible conversions are not counted.  In case of error, it sets errno and returns
       (size_t) -1.

ERRORS
       The following errors can occur, among others:

       E2BIG  There is not sufficient room at *outbuf.

       EILSEQ An invalid multibyte sequence has been encountered in the input.

       EINVAL An incomplete multibyte sequence has been encountered in the input.

VERSIONS
       This function is available in glibc since version 2.1.

ATTRIBUTES
       For an explanation of the terms used in this section, see attributes(7).

       ┌──────────┬───────────────┬─────────────────┐
       │Interface │ Attribute     │ Value           │
       ├──────────┼───────────────┼─────────────────┤
       │iconv()   │ Thread safety │ MT-Safe race:cd │
       └──────────┴───────────────┴─────────────────┘
       The iconv() function is MT-Safe, as long as callers arrange for mutual exclusion on the cd  ar‐
       gument.

CONFORMING TO
       POSIX.1-2001, POSIX.1-2008.

NOTES
       In  each series of calls to iconv(), the last should be one with inbuf or *inbuf equal to NULL,
       in order to flush out any partially converted input.

       Although inbuf and outbuf are typed as char **, this does not mean that the objects they  point
       can  be  interpreted  as  C strings or as arrays of characters: the interpretation of character
       byte sequences is handled internally by the conversion functions.  In some  encodings,  a  zero
       byte may be a valid part of a multibyte character.

       The caller of iconv() must ensure that the pointers passed to the function are suitable for ac‐
       cessing characters in the appropriate character set.  This includes ensuring correct  alignment
       on platforms that have tight restrictions on alignment.

SEE ALSO
       iconv_close(3), iconv_open(3), iconvconfig(8)

COLOPHON
       This  page  is  part  of  release  5.02  of  the Linux man-pages project.  A description of the
       project, information about reporting bugs, and the latest version of this page, can be found at
       https://www.kernel.org/doc/man-pages/.

GNU                                           2017-09-15                                      ICONV(3)
