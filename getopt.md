GETOPT(1)                                                          User Commands                                                         GETOPT(1)

NAME
       getopt - parse command options (enhanced)

SYNOPSIS
       getopt optstring parameters
       getopt [options] [--] optstring parameters
       getopt [options] -o|--options optstring [options] [--] parameters

DESCRIPTION
       getopt  is used to break up (parse) options in command lines for easy parsing by shell procedures, and to check for legal options.  It uses
       the GNU getopt(3) routines to do this.

       The parameters getopt is called with can be divided into two parts: options which modify the way getopt will do the  parsing  (the  options
       and  the optstring in the SYNOPSIS), and the parameters which are to be parsed (parameters in the SYNOPSIS).  The second part will start at
       the first non-option parameter that is not an option argument, or after the first occurrence of '--'.  If no '-o' or '--options' option  is
       found in the first part, the first parameter of the second part is used as the short options string.

       If the environment variable GETOPT_COMPATIBLE is set, or if the first parameter is not an option (does not start with a '-', the first for‐
       mat in the SYNOPSIS), getopt will generate output that is compatible with that of other versions of getopt(1).  It will still do  parameter
       shuffling and recognize optional arguments (see section COMPATIBILITY for more information).

       Traditional  implementations of getopt(1) are unable to cope with whitespace and other (shell-specific) special characters in arguments and
       non-option parameters.  To solve this problem, this implementation can generate quoted output which must once again be interpreted  by  the
       shell  (usually  by using the eval command).  This has the effect of preserving those characters, but you must call getopt in a way that is
       no longer compatible with other versions (the second or third format in the SYNOPSIS).  To  determine  whether  this  enhanced  version  of
       getopt(1) is installed, a special test option (-T) can be used.

OPTIONS
       -a, --alternative
              Allow long options to start with a single '-'.

       -h, --help
              Display help text and exit.  No other output is generated.

       -l, --longoptions longopts
              The  long  (multi-character)  options to be recognized.  More than one option name may be specified at once, by separating the names
              with commas.  This option may be given more than once, the longopts are cumulative.  Each long option name in longopts may  be  fol‐
              lowed by one colon to indicate it has a required argument, and by two colons to indicate it has an optional argument.

       -n, --name progname
              The  name  that  will be used by the getopt(3) routines when it reports errors.  Note that errors of getopt(1) are still reported as
              coming from getopt.

       -o, --options shortopts
              The short (one-character) options to be recognized.  If this option is not found, the first parameter of getopt that does not  start
              with  a  '-'  (and  is not an option argument) is used as the short options string.  Each short option character in shortopts may be
              followed by one colon to indicate it has a required argument, and by two colons to indicate it has an optional argument.  The  first
              character of shortopts may be '+' or '-' to influence the way options are parsed and output is generated (see section SCANNING MODES
              for details).

       -q, --quiet
              Disable error reporting by getopt(3).

       -Q, --quiet-output
              Do not generate normal output.  Errors are still reported by getopt(3), unless you also use -q.

       -s, --shell shell
              Set quoting conventions to those of shell.  If the -s option is not given, the BASH conventions are used.  Valid arguments are  cur‐
              rently 'sh' 'bash', 'csh', and 'tcsh'.

       -T, --test
              Test if your getopt(1) is this enhanced version or an old version.  This generates no output, and sets the error status to 4.  Other
              implementations of getopt(1), and this version if the environment variable GETOPT_COMPATIBLE is set, will return '--' and error sta‐
              tus 0.

       -u, --unquoted
              Do  not  quote the output.  Note that whitespace and special (shell-dependent) characters can cause havoc in this mode (like they do
              with other getopt(1) implementations).

       -V, --version
              Display version information and exit.  No other output is generated.

PARSING
       This section specifies the format of the second part of the parameters of getopt (the parameters in the SYNOPSIS).  The next section  (OUT‐
       PUT)  describes  the output that is generated.  These parameters were typically the parameters a shell function was called with.  Care must
       be taken that each parameter the shell function was called with corresponds to exactly one parameter in the parameter list of  getopt  (see
       the EXAMPLES).  All parsing is done by the GNU getopt(3) routines.

       The  parameters are parsed from left to right.  Each parameter is classified as a short option, a long option, an argument to an option, or
       a non-option parameter.

       A simple short option is a '-' followed by a short option character.  If the option has a required argument, it  may  be  written  directly
       after  the  option  character  or  as the next parameter (i.e. separated by whitespace on the command line).  If the option has an optional
       argument, it must be written directly after the option character if present.

       It is possible to specify several short options after one '-', as long as all (except possibly the last) do not have required  or  optional
       arguments.

       A  long  option  normally  begins  with  '--'  followed  by the long option name.  If the option has a required argument, it may be written
       directly after the long option name, separated by '=', or as the next argument (i.e. separated by whitespace on the command line).  If  the
       option  has  an optional argument, it must be written directly after the long option name, separated by '=', if present (if you add the '='
       but nothing behind it, it is interpreted as if no argument was present; this is a slight bug, see the BUGS).  Long options may be  abbrevi‐
       ated, as long as the abbreviation is not ambiguous.

       Each  parameter not starting with a '-', and not a required argument of a previous option, is a non-option parameter.  Each parameter after
       a '--' parameter is always interpreted as a non-option parameter.  If the environment variable POSIXLY_CORRECT is  set,  or  if  the  short
       option string started with a '+', all remaining parameters are interpreted as non-option parameters as soon as the first non-option parame‐
       ter is found.

OUTPUT
       Output is generated for each element described in the previous section.  Output is done in the same order as the elements are specified  in
       the  input,  except  for non-option parameters.  Output can be done in compatible (unquoted) mode, or in such way that whitespace and other
       special characters within arguments and non-option parameters are preserved (see QUOTING).  When the  output  is  processed  in  the  shell
       script,  it  will  seem to be composed of distinct elements that can be processed one by one (by using the shift command in most shell lan‐
       guages).  This is imperfect in unquoted mode, as elements can be split at unexpected places if they contain whitespace or  special  charac‐
       ters.

       If there are problems parsing the parameters, for example because a required argument is not found or an option is not recognized, an error
       will be reported on stderr, there will be no output for the offending element, and a non-zero error status is returned.

       For a short option, a single '-' and the option character are generated as one parameter.  If the option has an argument, the next  parame‐
       ter  will be the argument.  If the option takes an optional argument, but none was found, the next parameter will be generated but be empty
       in quoting mode, but no second parameter will be generated in unquoted (compatible) mode.  Note that many other  getopt(1)  implementations
       do not support optional arguments.

       If several short options were specified after a single '-', each will be present in the output as a separate parameter.

       For  a  long option, '--' and the full option name are generated as one parameter.  This is done regardless whether the option was abbrevi‐
       ated or specified with a single '-' in the input.  Arguments are handled as with short options.

       Normally, no non-option parameters output is generated until all options and their arguments have been generated.  Then '--'  is  generated
       as  a  single  parameter,  and  after it the non-option parameters in the order they were found, each as a separate parameter.  Only if the
       first character of the short options string was a '-', non-option parameter output is generated at the place they are found  in  the  input
       (this is not supported if the first format of the SYNOPSIS is used; in that case all preceding occurrences of '-' and '+' are ignored).

QUOTING
       In  compatible  mode, whitespace or 'special' characters in arguments or non-option parameters are not handled correctly.  As the output is
       fed to the shell script, the script does not know how it is supposed to break the output into  separate  parameters.   To  circumvent  this
       problem,  this implementation offers quoting.  The idea is that output is generated with quotes around each parameter.  When this output is
       once again fed to the shell (usually by a shell eval command), it is split correctly into separate parameters.

       Quoting is not enabled if the environment variable GETOPT_COMPATIBLE is set, if the first form of the SYNOPSIS is used, or  if  the  option
       '-u' is found.

       Different  shells  use different quoting conventions.  You can use the '-s' option to select the shell you are using.  The following shells
       are currently supported: 'sh', 'bash', 'csh' and 'tcsh'.  Actually, only two 'flavors' are distinguished: sh-like quoting  conventions  and
       csh-like quoting conventions.  Chances are that if you use another shell script language, one of these flavors can still be used.

SCANNING MODES
       The  first  character  of the short options string may be a '-' or a '+' to indicate a special scanning mode.  If the first calling form in
       the SYNOPSIS is used they are ignored; the environment variable POSIXLY_CORRECT is still examined, though.

       If the first character is '+', or if the environment variable POSIXLY_CORRECT is set, parsing stops as soon as the first non-option parame‐
       ter  (i.e.  a  parameter  that does not start with a '-') is found that is not an option argument.  The remaining parameters are all inter‐
       preted as non-option parameters.

       If the first character is a '-', non-option parameters are outputted at the place where they are found; in normal operation, they  are  all
       collected  at  the  end of output after a '--' parameter has been generated.  Note that this '--' parameter is still generated, but it will
       always be the last parameter in this mode.

COMPATIBILITY
       This version of getopt(1) is written to be as compatible as possible to other versions.  Usually you can just replace them with  this  ver‐
       sion without any modifications, and with some advantages.

       If  the  first  character  of the first parameter of getopt is not a '-', getopt goes into compatibility mode.  It will interpret its first
       parameter as the string of short options, and all other arguments will  be  parsed.   It  will  still  do  parameter  shuffling  (i.e.  all
       non-option parameters are output at the end), unless the environment variable POSIXLY_CORRECT is set.

       The  environment variable GETOPT_COMPATIBLE forces getopt into compatibility mode.  Setting both this environment variable and POSIXLY_COR‐
       RECT offers 100% compatibility for 'difficult' programs.  Usually, though, neither is needed.

       In compatibility mode, leading '-' and '+' characters in the short options string are ignored.

RETURN CODES
       getopt returns error code 0 for successful parsing, 1 if getopt(3) returns errors, 2 if it does not understand its own parameters, 3 if  an
       internal error occurs like out-of-memory, and 4 if it is called with -T.

EXAMPLES
       Example  scripts  for (ba)sh and (t)csh are provided with the getopt(1) distribution, and are optionally installed in /usr/share/getopt/ or
       /usr/share/doc/ in the util-linux subdirectory.

ENVIRONMENT
       POSIXLY_CORRECT
              This environment variable is examined by the getopt(3) routines.  If it is set, parsing stops as soon as a parameter is  found  that
              is  not an option or an option argument.  All remaining parameters are also interpreted as non-option parameters, regardless whether
              they start with a '-'.

       GETOPT_COMPATIBLE
              Forces getopt to use the first calling format as specified in the SYNOPSIS.

BUGS
       getopt(3) can parse long options with optional arguments that are given an empty optional argument (but cannot do this for short  options).
       This getopt(1) treats optional arguments that are empty as if they were not present.

       The  syntax  if  you  do  not  want  any  short option variables at all is not very intuitive (you have to set them explicitly to the empty
       string).

AUTHOR
       Frodo Looijaard ⟨frodo@frodo.looijaard.name⟩

SEE ALSO
       bash(1), tcsh(1), getopt(3)

AVAILABILITY
       The getopt command is part of the util-linux package and is available from  Linux  Kernel  Archive  ⟨https://www.kernel.org/pub/linux/utils
       /util-linux/⟩.

util-linux                                                         December 2014                                                         GETOPT(1)
GETOPT(3)                                                    Linux Programmer's Manual                                                   GETOPT(3)

NAME
       getopt, getopt_long, getopt_long_only, optarg, optind, opterr, optopt - Parse command-line options

SYNOPSIS
       #include <unistd.h>

       int getopt(int argc, char * const argv[],
                  const char *optstring);

       extern char *optarg;
       extern int optind, opterr, optopt;

       #include <getopt.h>

       int getopt_long(int argc, char * const argv[],
                  const char *optstring,
                  const struct option *longopts, int *longindex);

       int getopt_long_only(int argc, char * const argv[],
                  const char *optstring,
                  const struct option *longopts, int *longindex);

   Feature Test Macro Requirements for glibc (see feature_test_macros(7)):

       getopt(): _POSIX_C_SOURCE >= 2 || _XOPEN_SOURCE
       getopt_long(), getopt_long_only(): _GNU_SOURCE

DESCRIPTION
       The  getopt()  function  parses  the command-line arguments.  Its arguments argc and argv are the argument count and array as passed to the
       main() function on program invocation.  An element of argv that starts with '-' (and is not exactly "-" or "--") is an option element.  The
       characters  of  this element (aside from the initial '-') are option characters.  If getopt() is called repeatedly, it returns successively
       each of the option characters from each of the option elements.

       The variable optind is the index of the next element to be processed in argv.  The system initializes this value  to  1.   The  caller  can
       reset it to 1 to restart scanning of the same argv, or when scanning a new argument vector.

       If getopt() finds another option character, it returns that character, updating the external variable optind and a static variable nextchar
       so that the next call to getopt() can resume the scan with the following option character or argv-element.

       If there are no more option characters, getopt() returns -1.  Then optind is the index in argv of the first argv-element  that  is  not  an
       option.

       optstring  is  a  string  containing  the legitimate option characters.  If such a character is followed by a colon, the option requires an
       argument, so getopt() places a pointer to the following text in the same argv-element, or  the  text  of  the  following  argv-element,  in
       optarg.   Two  colons  mean  an  option  takes an optional arg; if there is text in the current argv-element (i.e., in the same word as the
       option name itself, for example, "-oarg"), then it is returned in optarg, otherwise optarg is set to zero.  This is a  GNU  extension.   If
       optstring  contains  W followed by a semicolon, then -W foo is treated as the long option --foo.  (The -W option is reserved by POSIX.2 for
       implementation extensions.)  This behavior is a GNU extension, not available with libraries before glibc 2.

       By default, getopt() permutes the contents of argv as it scans, so that eventually all the nonoptions are at the end.  Two other modes  are
       also  implemented.   If  the first character of optstring is '+' or the environment variable POSIXLY_CORRECT is set, then option processing
       stops as soon as a nonoption argument is encountered.  If the first character of optstring is '-', then each nonoption argv-element is han‐
       dled  as  if  it  were  the argument of an option with character code 1.  (This is used by programs that were written to expect options and
       other argv-elements in any order and that care about the ordering of the two.)  The special argument "--" forces an end of  option-scanning
       regardless of the scanning mode.

       If  getopt() does not recognize an option character, it prints an error message to stderr, stores the character in optopt, and returns '?'.
       The calling program may prevent the error message by setting opterr to 0.

       If getopt() finds an option character in argv that was not included in optstring, or if it detects a missing option  argument,  it  returns
       '?'  and  sets  the  external  variable  optopt  to the actual option character.  If the first character (following any optional '+' or '-'
       described above) of optstring is a colon (':'), then getopt() returns ':' instead of '?' to indicate a  missing  option  argument.   If  an
       error  was  detected,  and  the  first  character  of  optstring  is not a colon, and the external variable opterr is nonzero (which is the
       default), getopt() prints an error message.

   getopt_long() and getopt_long_only()
       The getopt_long() function works like getopt() except that it also accepts long options, started with two dashes.  (If the program  accepts
       only  long  options,  then  optstring  should be specified as an empty string (""), not NULL.)  Long option names may be abbreviated if the
       abbreviation is unique or is an exact match for some defined option.  A long option may take a parameter, of the form --arg=param or  --arg
       param.

       longopts is a pointer to the first element of an array of struct option declared in <getopt.h> as

           struct option {
               const char *name;
               int         has_arg;
               int        *flag;
               int         val;
           };

       The meanings of the different fields are:

       name   is the name of the long option.

       has_arg
              is:  no_argument  (or  0)  if  the option does not take an argument; required_argument (or 1) if the option requires an argument; or
              optional_argument (or 2) if the option takes an optional argument.

       flag   specifies how results are returned for a long option.  If flag is NULL, then getopt_long() returns val.  (For example,  the  calling
              program  may  set  val to the equivalent short option character.)  Otherwise, getopt_long() returns 0, and flag points to a variable
              which is set to val if the option is found, but left unchanged if the option is not found.

       val    is the value to return, or to load into the variable pointed to by flag.

       The last element of the array has to be filled with zeros.

       If longindex is not NULL, it points to a variable which is set to the index of the long option relative to longopts.

       getopt_long_only() is like getopt_long(), but '-' as well as "--" can indicate a long option.  If an option that starts with '-' (not "--")
       doesn't match a long option, but does match a short option, it is parsed as a short option instead.

RETURN VALUE
       If  an  option  was  successfully  found,  then  getopt() returns the option character.  If all command-line options have been parsed, then
       getopt() returns -1.  If getopt() encounters an option character that was not in optstring, then '?' is returned.  If  getopt()  encounters
       an  option  with a missing argument, then the return value depends on the first character in optstring: if it is ':', then ':' is returned;
       otherwise '?' is returned.

       getopt_long() and getopt_long_only() also return the option character when a short option is recognized.  For a long  option,  they  return
       val  if flag is NULL, and 0 otherwise.  Error and -1 returns are the same as for getopt(), plus '?' for an ambiguous match or an extraneous
       parameter.

ENVIRONMENT
       POSIXLY_CORRECT
              If this is set, then option processing stops as soon as a nonoption argument is encountered.

       _<PID>_GNU_nonoption_argv_flags_
              This variable was used by bash(1) 2.0 to communicate to glibc which arguments are the results of wildcard expansion  and  so  should
              not be considered as options.  This behavior was removed in bash(1) version 2.01, but the support remains in glibc.

ATTRIBUTES
       For an explanation of the terms used in this section, see attributes(7).

       ┌─────────────────────────┬───────────────┬───────────────────────────┐
       │Interface                │ Attribute     │ Value                     │
       ├─────────────────────────┼───────────────┼───────────────────────────┤
       │getopt(), getopt_long(), │ Thread safety │ MT-Unsafe race:getopt env │
       │getopt_long_only()       │               │                           │
       └─────────────────────────┴───────────────┴───────────────────────────┘
CONFORMING TO
       getopt():
              POSIX.1-2001, POSIX.1-2008, and POSIX.2, provided the environment variable POSIXLY_CORRECT is set.  Otherwise, the elements of  argv
              aren't really const, because we permute them.  We pretend they're const in the prototype to be compatible with other systems.

              The use of '+' and '-' in optstring is a GNU extension.

              On  some  older implementations, getopt() was declared in <stdio.h>.  SUSv1 permitted the declaration to appear in either <unistd.h>
              or <stdio.h>.  POSIX.1-2001 marked the use of <stdio.h> for this purpose as LEGACY.  POSIX.1-2001 does not allow the declaration  to
              appear in <stdio.h>.

       getopt_long() and getopt_long_only():
              These functions are GNU extensions.

NOTES
       A  program that scans multiple argument vectors, or rescans the same vector more than once, and wants to make use of GNU extensions such as
       '+' and '-' at the start of optstring, or changes the value of POSIXLY_CORRECT between  scans,  must  reinitialize  getopt()  by  resetting
       optind  to  0,  rather  than  the traditional value of 1.  (Resetting to 0 forces the invocation of an internal initialization routine that
       rechecks POSIXLY_CORRECT and checks for GNU extensions in optstring.)

EXAMPLE
   getopt()
       The following trivial example program uses getopt() to handle two program options: -n, with no associated value; and -t val, which  expects
       an associated value.

       #include <unistd.h>
       #include <stdlib.h>
       #include <stdio.h>

       int
       main(int argc, char *argv[])
       {
           int flags, opt;
           int nsecs, tfnd;

           nsecs = 0;
           tfnd = 0;
           flags = 0;
           while ((opt = getopt(argc, argv, "nt:")) != -1) {
               switch (opt) {
               case 'n':
                   flags = 1;
                   break;
               case 't':
                   nsecs = atoi(optarg);
                   tfnd = 1;
                   break;
               default: /* '?' */
                   fprintf(stderr, "Usage: %s [-t nsecs] [-n] name\n",
                           argv[0]);
                   exit(EXIT_FAILURE);
               }
           }

           printf("flags=%d; tfnd=%d; nsecs=%d; optind=%d\n",
                   flags, tfnd, nsecs, optind);

           if (optind >= argc) {
               fprintf(stderr, "Expected argument after options\n");
               exit(EXIT_FAILURE);
           }

           printf("name argument = %s\n", argv[optind]);

           /* Other code omitted */

           exit(EXIT_SUCCESS);
       }

   getopt_long()
       The following example program illustrates the use of getopt_long() with most of its features.

       #include <stdio.h>     /* for printf */
       #include <stdlib.h>    /* for exit */
       #include <getopt.h>

       int
       main(int argc, char **argv)
       {
           int c;
           int digit_optind = 0;

           while (1) {
               int this_option_optind = optind ? optind : 1;
               int option_index = 0;
               static struct option long_options[] = {
                   {"add",     required_argument, 0,  0 },
                   {"append",  no_argument,       0,  0 },
                   {"delete",  required_argument, 0,  0 },
                   {"verbose", no_argument,       0,  0 },
                   {"create",  required_argument, 0, 'c'},
                   {"file",    required_argument, 0,  0 },
                   {0,         0,                 0,  0 }
               };

               c = getopt_long(argc, argv, "abc:d:012",
                        long_options, &option_index);
               if (c == -1)
                   break;

               switch (c) {
               case 0:
                   printf("option %s", long_options[option_index].name);
                   if (optarg)
                       printf(" with arg %s", optarg);
                   printf("\n");
                   break;

               case '0':
               case '1':
               case '2':
                   if (digit_optind != 0 && digit_optind != this_option_optind)
                     printf("digits occur in two different argv-elements.\n");
                   digit_optind = this_option_optind;
                   printf("option %c\n", c);
                   break;

               case 'a':
                   printf("option a\n");
                   break;

               case 'b':
                   printf("option b\n");
                   break;

               case 'c':
                   printf("option c with value '%s'\n", optarg);
                   break;

               case 'd':
                   printf("option d with value '%s'\n", optarg);
                   break;

               case '?':
                   break;

               default:
                   printf("?? getopt returned character code 0%o ??\n", c);
               }
           }

           if (optind < argc) {
               printf("non-option ARGV-elements: ");
               while (optind < argc)
                   printf("%s ", argv[optind++]);
               printf("\n");
           }

           exit(EXIT_SUCCESS);
       }

SEE ALSO
       getopt(1), getsubopt(3)

COLOPHON
       This  page is part of release 4.04 of the Linux man-pages project.  A description of the project, information about reporting bugs, and the
       latest version of this page, can be found at http://www.kernel.org/doc/man-pages/.

GNU                                                                 2015-08-08                                                           GETOPT(3)
