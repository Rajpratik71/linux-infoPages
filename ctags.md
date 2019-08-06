File: *manpages*,  Node: ctags,  Up: (dir)

etags(1)                           GNU Tools                          etags(1)



NAME
       etags, gnuctags - generate tag file for Emacs, vi

SYNOPSIS
       etags [-aCDGIRVh] [-i file] [-l language]
       [-o tagfile] [-r regexp] [--parse-stdin=file]
       [--append] [--no-defines] [--globals] [--no-globals] [--include=file]
       [--ignore-indentation] [--language=language] [--members] [--no-members]
       [--output=tagfile] [--regex=regexp] [--no-regex] [--help] [--version]
       file ...

       gnuctags [-aCdgIRVh] [-BtTuvwx] [-l language]
       [-o tagfile] [-r regexp] [--parse-stdin=file]
       [--append] [--backward-search] [--cxref] [--no-defines] [--globals]
       [--no-globals] [--ignore-indentation] [--language=language] [--members]
       [--no-members] [--output=tagfile] [--regex=regexp] [--update] [--help]
       [--version] file ...

DESCRIPTION
       The  etags  program is used to create a tag table file, in a format un-
       derstood by emacs(1); the gnuctags program is used to create a  similar
       table  in  a format understood by vi(1).  Both forms of the program un-
       derstand the syntax of C, Objective C, C++, Java, Fortran, Ada,  Cobol,
       Erlang, Forth, HTML, LaTeX, Emacs Lisp/Common Lisp, Lua, Makefile, Pas-
       cal, Perl, PHP, PostScript, Python,  Prolog,  Scheme  and  most  assem-
       bler-like syntaxes.  Both forms read the files specified on the command
       line, and write a tag table (defaults: TAGS for etags, tags  for  gnuc-
       tags)  in the current working directory.  Files specified with relative
       file names will be recorded in the tag table with file  names  relative
       to  the  directory where the tag table resides.  If the tag table is in
       /dev or is the standard output, however, the file names are made  rela-
       tive  to  the  working  directory.   Files specified with absolute file
       names will be recorded with absolute file names.  Files generated  from
       a source file--like a C file generated from a source Cweb file--will be
       recorded with the name of the source file.  Compressed files  are  sup-
       ported  using gzip, bzip2, and xz.  The programs recognize the language
       used in an input file based on its file name and contents.  The  --lan-
       guage  switch  can be used to force parsing of the file names following
       the switch according to the given language, overriding guesses based on
       filename extensions.

OPTIONS
       Some  options  make  sense  only for the vi style tag files produced by
       gnuctags; etags does not recognize them.  The programs accept unambigu-
       ous abbreviations for long option names.

       -a, --append
              Append to existing tag file.  (For vi-format tag files, see also
              --update.)

       -B, --backward-search
              Tag files written in the format expected by vi  contain  regular
              expression  search instructions; the -B option writes them using
              the delimiter `?', to search backwards through files.   The  de-
              fault  is  to  use the delimiter `/', to search forwards through
              files.  Only gnuctags accepts this option.

       --declarations
              In C and derived languages, create tags  for  function  declara-
              tions,  and create tags for extern variables unless --no-globals
              is used.

       -D, --no-defines
              Do not create tag entries for C  preprocessor  constant  defini-
              tions  and  enum  constants.   This  may make the tags file much
              smaller if many header files are tagged.

       --globals
              Create tag entries for global variables in  Perl  and  Makefile.
              This is the default in C and derived languages.

       --no-globals
              Do  not  tag global variables in C and derived languages.  Typi-
              cally this reduces the file size by one fourth.

       -i file, --include=file
              Include a note in the tag file indicating that,  when  searching
              for  a  tag,  one  should  also consult the tags file file after
              checking the current file.  Only etags accepts this option.

       -I, --ignore-indentation
              Don't rely on indentation as much as we normally do.  Currently,
              this  means not to assume that a closing brace in the first col-
              umn is the final brace of a function or structure definition  in
              C and C++.

       -l language, --language=language
              Parse the following files according to the given language.  More
              than one such options may be  intermixed  with  filenames.   Use
              --help  to  get  a list of the available languages and their de-
              fault filename extensions.  The `auto' language can be  used  to
              restore  automatic detection of language based on the file name.
              The `none' language may be used to disable language parsing  al-
              together;  only  regexp  matching  is done in this case (see the
              --regex option).

       --members
              Create tag entries for variables that are members of  structure-
              like  constructs  in PHP.  This is the default for C and derived
              languages.

       --no-members
              Do not tag member variables.

       --packages-only
              Only tag packages in Ada files.

       --parse-stdin=file
              May be used (only once) in place of a file name on  the  command
              line.  etags will read from standard input and mark the produced
              tags as belonging to the file FILE.

       -o tagfile, --output=tagfile
              Explicit name of file for tag table; for etags only, a file name
              of  -  means  standard  output;  overrides default TAGS or tags.
              (But ignored with -v or -x.)

       -r regexp, --regex=regexp

              Make tags based on regexp matching for the files following  this
              option,  in  addition to the tags made with the standard parsing
              based on language. May be freely intermixed with  filenames  and
              the  -R option.  The regexps are cumulative, i.e., each such op-
              tion will add to the previous ones.  The regexps are of  one  of
              the forms:
                   [{language}]/tagregexp/[nameregexp/]modifiers
                   @regexfile

              where  tagregexp  is used to match the tag.  It should not match
              useless characters.  If the match is such that  more  characters
              than needed are unavoidably matched by tagregexp, it may be use-
              ful to add a nameregexp, to narrow down the tag scope.  gnuctags
              ignores  regexps without a nameregexp.  The syntax of regexps is
              the same as in emacs.  The following character escape  sequences
              are supported: \a, \b, \d, \e, \f, \n, \r, \t, \v, which respec-
              tively stand for the ASCII characters BEL, BS, DEL, ESC, FF, NL,
              CR, TAB, VT.
              The  modifiers  are  a sequence of 0 or more characters among i,
              which means to ignore case when matching; m,  which  means  that
              the tagregexp will be matched against the whole file contents at
              once, rather than line by line, and the  matching  sequence  can
              match  multiple lines; and s, which implies m and means that the
              dot character in tagregexp matches the newline char as well.
              The separator, which is / in the examples, can be any  character
              different from space, tab, braces and @.  If the separator char-
              acter is needed inside the regular expression, it must be quoted
              by preceding it with \.
              The optional {language} prefix means that the tag should be cre-
              ated only for files of language language, and ignored otherwise.
              This is particularly useful when storing many predefined regexps
              in a file.
              In its second form, regexfile is the name of a  file  that  con-
              tains  a  number  of  arguments  to the --regex= option, one per
              line.  Lines beginning with a space or tab  are  assumed  to  be
              comments, and ignored.

              Here  are  some examples.  All the regexps are quoted to protect
              them from shell interpretation.

              Tag the DEFVAR macros in the emacs source files:
              --regex='/[ \t]*DEFVAR_[A-Z_ \t(]+"\([^"]+\)"/'

              Tag VHDL files (this example is a single long line, broken  here
              for formatting reasons):
              --language=none --regex='/[ \t]*\(ARCHITECTURE\|\     CONFIGURA-
              TION\) +[^ ]* +OF/' --regex='/[ \t]*\ \(ATTRIBUTE\|ENTITY\|FUNC-
              TION\|PACKAGE\( BODY\)?\                                \|PROCE-
              DURE\|PROCESS\|TYPE\)[ \t]+\([^ \t(]+\)/\3/'

              Tag TCL files (this last example shows the usage  of  a  tagreg-
              exp):
              --lang=none --regex='/proc[ \t]+\([^ \t]+\)/\1/'

              A regexp can be preceded by {lang}, thus restricting it to match
              lines of files of the specified language.  Use etags  --help  to
              obtain a list of the recognized languages.  This feature is par-
              ticularly useful inside regex files.  A regex file contains  one
              regex  per  line.   Empty  lines, and those lines beginning with
              space or tab are ignored.  Lines beginning with @ are references
              to  regex  files whose name follows the @ sign.  Other lines are
              considered regular expressions like those following --regex.
              For example, the command
              etags --regex=@regex.file *.c
              reads the regexes contained in the file regex.file.

       -R, --no-regex
              Don't do any more regexp matching on the following  files.   May
              be freely intermixed with filenames and the --regex option.

       -u, --update
              Update  tag entries for files specified on command line, leaving
              tag entries for other files in place.  Currently, this is imple-
              mented  by deleting the existing entries for the given files and
              then rewriting the new entries at the end of the tags file.   It
              is  often  faster  to simply rebuild the entire tag file than to
              use this.  Only gnuctags accepts this option.

       -v, --vgrind
              Instead of generating a tag file, write index (in vgrind format)
              to standard output.  Only gnuctags accepts this option.

       -x, --cxref
              Instead  of  generating  a tag file, write a cross reference (in
              cxref format) to standard output.  Only  gnuctags  accepts  this
              option.

       -h, -H, --help
              Print  usage  information.   Followed  by  one  or  more  --lan-
              guage=LANG prints detailed information about how tags are creat-
              ed for LANG.

       -V, --version
              Print the current version of the program (same as the version of
              the emacs etags is shipped with).


SEE ALSO
       `emacs' entry in info; GNU Emacs Manual, Richard Stallman.
       cxref(1), emacs(1), vgrind(1), vi(1).


COPYING
       Copyright (C) 1992, 1999, 2001-2013 Free Software Foundation, Inc.

       Permission is granted to make and distribute verbatim  copies  of  this
       document  provided  the copyright notice and this permission notice are
       preserved on all copies.

       Permission is granted to copy and distribute modified versions of  this
       document  under  the conditions for verbatim copying, provided that the
       entire resulting derived work is distributed under the terms of a  per-
       mission notice identical to this one.

       Permission is granted to copy and distribute translations of this docu-
       ment into another language, under the  above  conditions  for  modified
       versions,  except that this permission notice may be stated in a trans-
       lation approved by the Free Software Foundation.



GNU Tools                          23nov2001                          etags(1)
CTAGS(1P)                  POSIX Programmer's Manual                 CTAGS(1P)



PROLOG
       This  manual  page is part of the POSIX Programmer's Manual.  The Linux
       implementation of this interface may differ (consult the  corresponding
       Linux  manual page for details of Linux behavior), or the interface may
       not be implemented on Linux.

NAME
       ctags - create a tags file (DEVELOPMENT, FORTRAN)

SYNOPSIS
       ctags [-a][-f tagsfile] pathname ...

       ctags -x pathname ...


DESCRIPTION
       The ctags utility shall be provided on systems that  support  the  User
       Portability   Utilities  option,  the  Software  Development  Utilities
       option, and either or both  of  the  C-Language  Development  Utilities
       option  and  FORTRAN Development Utilities option. On other systems, it
       is optional.

       The ctags utility shall write a tagsfile or an index of objects from C-
       language  or  FORTRAN  source files specified by the pathname operands.
       The tagsfile shall  list  the  locators  of  language-specific  objects
       within  the  source files.  A locator consists of a name, pathname, and
       either a search pattern or a line number that can be used in  searching
       for  the  object  definition.  The objects that shall be recognized are
       specified in the EXTENDED DESCRIPTION section.

OPTIONS
       The ctags utility shall conform  to  the  Base  Definitions  volume  of
       IEEE Std 1003.1-2001, Section 12.2, Utility Syntax Guidelines.

       The following options shall be supported:

       -a     Append to tagsfile.

       -f  tagsfile
              Write  the  object  locator  lists  into tagsfile instead of the
              default file named tags in the current directory.

       -x     Produce a list of object names, the line number, and filename in
              which  each  is  defined,  as well as the text of that line, and
              write this to the standard output. A tagsfile shall not be  cre-
              ated when -x is specified.


OPERANDS
       The following pathname operands are supported:

       file.c Files  with basenames ending with the .c suffix shall be treated
              as C-language source code. Such files that are not  valid  input
              to c99 produce unspecified results.

       file.h Files  with basenames ending with the .h suffix shall be treated
              as C-language source code. Such files that are not  valid  input
              to c99 produce unspecified results.

       file.f Files  with basenames ending with the .f suffix shall be treated
              as FORTRAN-language source code. Such files that are  not  valid
              input to fort77 produce unspecified results.


       The handling of other files is implementation-defined.

STDIN
       See the INPUT FILES section.

INPUT FILES
       The  input files shall be text files containing source code in the lan-
       guage indicated by the operand filename suffixes.

ENVIRONMENT VARIABLES
       The following environment  variables  shall  affect  the  execution  of
       ctags:

       LANG   Provide  a  default value for the internationalization variables
              that are unset or null. (See  the  Base  Definitions  volume  of
              IEEE Std 1003.1-2001,  Section  8.2,  Internationalization Vari-
              ables for the precedence of internationalization variables  used
              to determine the values of locale categories.)

       LC_ALL If  set  to a non-empty string value, override the values of all
              the other internationalization variables.

       LC_COLLATE

              Determine the order in which output is sorted for the -x option.
              The  POSIX  locale determines the order in which the tagsfile is
              written.

       LC_CTYPE
              Determine the locale for  the  interpretation  of  sequences  of
              bytes  of  text  data as characters (for example, single-byte as
              opposed to multi-byte characters in arguments and input  files).
              When  processing  C-language  source  code, if the locale is not
              compatible with the C locale described by  the  ISO C  standard,
              the results are unspecified.

       LC_MESSAGES
              Determine  the  locale  that should be used to affect the format
              and contents of diagnostic messages written to standard error.

       NLSPATH
              Determine the location of message catalogs for the processing of
              LC_MESSAGES .


ASYNCHRONOUS EVENTS
       Default.

STDOUT
       The  list of object name information produced by the -x option shall be
       written to standard output in the following format:


              "%s %d %s %s", <object-name>, <line-number>, <filename>, <text>

       where <text> is the text of line <line-number> of file <filename>.

STDERR
       The standard error shall be used only for diagnostic messages.

OUTPUT FILES
       When the -x option is not specified, the  format  of  the  output  file
       shall be:


              "%s\t%s\t/%s/\n", <identifier>, <filename>, <pattern>

       where  <pattern> is a search pattern that could be used by an editor to
       find the defining instance of <identifier> in <filename> (where  defin-
       ing  instance  is  indicated by the declarations listed in the EXTENDED
       DESCRIPTION).

       An optional circumflex ( '^' ) can be added as a prefix  to  <pattern>,
       and  an  optional  dollar sign can be appended to <pattern> to indicate
       that the pattern is anchored to the beginning (end) of a line of  text.
       Any  slash  or backslash characters in <pattern> shall be preceded by a
       backslash character. The anchoring circumflex, dollar sign, and  escap-
       ing  backslash  characters  shall  not be considered part of the search
       pattern. All other characters in the search pattern shall be considered
       literal characters.

       An alternative format is:


              "%s\t%s\t?%s?\n", <identifier>, <filename>, <pattern>

       which is identical to the first format except that slashes in <pattern>
       shall not be preceded by escaping backslash  characters,  and  question
       mark characters in <pattern> shall be preceded by backslash characters.

       A second alternative format is:


              "%s\t%s\t%d\n", <identifier>, <filename>, <lineno>

       where <lineno> is a decimal line number that could be used by an editor
       to find <identifier> in <filename>.

       Neither alternative format shall be produced by ctags when it  is  used
       as  described  by IEEE Std 1003.1-2001, but the standard utilities that
       process tags files shall be able to process those formats  as  well  as
       the first format.

       In  any of these formats, the file shall be sorted by identifier, based
       on the collation sequence in the POSIX locale.

EXTENDED DESCRIPTION
       If the operand identifies C-language source, the  ctags  utility  shall
       attempt to produce an output line for each of the following objects:

        * Function definitions

        * Type definitions

        * Macros with arguments

       It may also produce output for any of the following objects:

        * Function prototypes

        * Structures

        * Unions

        * Global variable definitions

        * Enumeration types

        * Macros without arguments

        * #define statements

        * #line statements

       Any #if and #ifdef statements shall produce no output.  The tag main is
       treated specially in C programs. The tag formed  shall  be  created  by
       prefixing  M to the name of the file, with the trailing .c, and leading
       pathname components (if any) removed.

       On systems that do not support  the  C-Language  Development  Utilities
       option,  ctags  produces unspecified results for C-language source code
       files. It should write to standard error  a  message  identifying  this
       condition and cause a non-zero exit status to be produced.

       If  the operand identifies FORTRAN source, the ctags utility shall pro-
       duce an output line for each function definition. It may  also  produce
       output for any of the following objects:

        * Subroutine definitions

        * COMMON statements

        * PARAMETER statements

        * DATA and BLOCK DATA statements

        * Statement numbers

       On  systems  that  do  not  support  the  FORTRAN Development Utilities
       option, ctags produces unspecified  results  for  FORTRAN  source  code
       files.  It  should  write  to standard error a message identifying this
       condition and cause a non-zero exit status to be produced.

       It is implementation-defined what other  objects  (including  duplicate
       identifiers) produce output.

EXIT STATUS
       The following exit values shall be returned:

        0     Successful completion.

       >0     An error occurred.


CONSEQUENCES OF ERRORS
       Default.

       The following sections are informative.

APPLICATION USAGE
       The  output  with  -x is meant to be a simple index that can be written
       out as an off-line readable function index. If the input files to ctags
       (such  as  .c  files) were not created using the same locale as that in
       effect when ctags -x is run, results might not be as expected.

       The description of C-language processing says "attempts to" because the
       C  language  can  be  greatly  confused,  especially through the use of
       #defines, and this utility would be of no use if the real C  preproces-
       sor  were run to identify them. The output from ctags may be fooled and
       incorrect for various constructs.

EXAMPLES
       None.

RATIONALE
       The option list was significantly reduced from that provided by histor-
       ical  implementations. The -F option was omitted as redundant, since it
       is the default. The -B option was omitted as being of very limited use-
       fulness. The -t option was omitted since the recognition of typedefs is
       now required for C source files. The -u option was omitted because  the
       update  function was judged to be not only inefficient, but also rarely
       needed.

       An early proposal included a -w option to suppress warning diagnostics.
       Since  the types of such diagnostics could not be described, the option
       was omitted as being not useful.

       The text for LC_CTYPE about compatibility with the  C  locale  acknowl-
       edges  that  the ISO C standard imposes requirements on the locale used
       to process C source. This could easily be a superset of that  known  as
       "the  C  locale"  by  way of implementation extensions, or one of a few
       alternative locales  for  systems  supporting  different  codesets.  No
       statement is made for FORTRAN because the ANSI X3.9-1978 standard (FOR-
       TRAN 77) does not (yet) define a similar  locale  concept.  However,  a
       general  rule  in  this volume of IEEE Std 1003.1-2001 is that any time
       that locales do not match (preparing a file for one locale and process-
       ing it in another), the results are suspect.

       The  collation  sequence of the tags file is not affected by LC_COLLATE
       because it is typically not used by human readers, but only by programs
       such  as  vi to locate the tag within the source files. Using the POSIX
       locale eliminates some of the problems of coordinating locales  between
       the ctags file creator and the vi file reader.

       Historically,  the tags file has been used only by ex and vi.  However,
       the format of the tags file has been published to encourage other  pro-
       grams to use the tags in new ways. The format allows either patterns or
       line numbers to find the identifiers because the historical  vi  recog-
       nizes  either. The ctags utility does not produce the format using line
       numbers because it is not useful following any source file changes that
       add  or  delete  lines. The documented search patterns match historical
       practice. It should be noted that literal leading circumflex or  trail-
       ing  dollar-sign characters in the search pattern will only behave cor-
       rectly if anchored to the beginning of the line or end of the  line  by
       an additional circumflex or dollar-sign character.

       Historical implementations also understand the objects used by the lan-
       guages Pascal and sometimes LISP, and they understand the C source out-
       put  by  lex and yacc. The ctags utility is not required to accommodate
       these languages, although implementors are encouraged to do so.

       The following historical option was not specified,  as  vgrind  is  not
       included in this volume of IEEE Std 1003.1-2001:

       -v     If the -v flag is given, an index of the form expected by vgrind
              is produced on the standard output. This  listing  contains  the
              function  name,  filename,  and  page  number  (assuming 64-line
              pages). Since the output is sorted into lexicographic order,  it
              may be desired to run the output through sort -f.  Sample use:


              ctags -v files | sort -f > index vgrind -x index


       The  special treatment of the tag main makes the use of ctags practical
       in directories with more than one program.

FUTURE DIRECTIONS
       None.

SEE ALSO
       c99, fort77, vi

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



IEEE/The Open Group                  2003                            CTAGS(1P)
