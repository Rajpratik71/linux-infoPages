File: *manpages*,  Node: man,  Up: (dir)

MAN(1)                        Manual pager utils                        MAN(1)



NAME
       man - an interface to the on-line reference manuals

SYNOPSIS
       man  [-C  file]  [-d]  [-D]  [--warnings[=warnings]]  [-R encoding] [-L
       locale] [-m system[,...]] [-M path] [-S list]  [-e  extension]  [-i|-I]
       [--regex|--wildcard]   [--names-only]  [-a]  [-u]  [--no-subpages]  [-P
       pager] [-r prompt] [-7] [-E encoding] [--no-hyphenation] [--no-justifi‐
       cation]  [-p  string]  [-t]  [-T[device]]  [-H[browser]] [-X[dpi]] [-Z]
       [[section] page ...] ...
       man -k [apropos options] regexp ...
       man -K [-w|-W] [-S list] [-i|-I] [--regex] [section] term ...
       man -f [whatis options] page ...
       man -l [-C file] [-d] [-D] [--warnings[=warnings]]  [-R  encoding]  [-L
       locale]  [-P  pager]  [-r  prompt]  [-7] [-E encoding] [-p string] [-t]
       [-T[device]] [-H[browser]] [-X[dpi]] [-Z] file ...
       man -w|-W [-C file] [-d] [-D] page ...
       man -c [-C file] [-d] [-D] page ...
       man [-?V]

DESCRIPTION
       man is the system's manual pager. Each page argument given  to  man  is
       normally  the  name of a program, utility or function.  The manual page
       associated with each of these arguments is then found and displayed.  A
       section,  if  provided, will direct man to look only in that section of
       the manual.  The default action is to search in all  of  the  available
       sections, following a pre-defined order and to show only the first page
       found, even if page exists in several sections.

       The table below shows the section numbers of the manual followed by the
       types of pages they contain.


       1   Executable programs or shell commands
       2   System calls (functions provided by the kernel)
       3   Library calls (functions within program libraries)
       4   Special files (usually found in /dev)
       5   File formats and conventions eg /etc/passwd
       6   Games
       7   Miscellaneous  (including  macro  packages  and  conventions), e.g.
           man(7), groff(7)
       8   System administration commands (usually only for root)
       9   Kernel routines [Non standard]

       A manual page consists of several sections.

       Conventional  section  names  include  NAME,  SYNOPSIS,  CONFIGURATION,
       DESCRIPTION,  OPTIONS,  EXIT STATUS, RETURN VALUE, ERRORS, ENVIRONMENT,
       FILES, VERSIONS, CONFORMING TO,  NOTES,  BUGS,  EXAMPLE,  AUTHORS,  and
       SEE ALSO.

       The following conventions apply to the SYNOPSIS section and can be used
       as a guide in other sections.


       bold text          type exactly as shown.
       italic text        replace with appropriate argument.
       [-abc]             any or all arguments within [ ] are optional.
       -a|-b              options delimited by | cannot be used together.
       argument ...       argument is repeatable.
       [expression] ...   entire expression within [ ] is repeatable.

       Exact rendering may vary depending on the output device.  For instance,
       man will usually not be able to render italics when running in a termi‐
       nal, and will typically use underlined or coloured text instead.

       The command or function illustration is a pattern that should match all
       possible invocations.  In some cases it is advisable to illustrate sev‐
       eral exclusive invocations as is shown in the SYNOPSIS section of  this
       manual page.

EXAMPLES
       man ls
           Display the manual page for the item (program) ls.

       man -a intro
           Display,  in  succession,  all  of the available intro manual pages
           contained within the manual.  It is possible to quit  between  suc‐
           cessive displays or skip any of them.

       man -t alias | lpr -Pps
           Format  the manual page referenced by `alias', usually a shell man‐
           ual page, into the default troff or groff format and pipe it to the
           printer  named  ps.   The default output for groff is usually Post‐
           Script.  man --help should advise as to which processor is bound to
           the -t option.

       man -l -Tdvi ./foo.1x.gz > ./foo.1x.dvi
           This  command  will  decompress  and format the nroff source manual
           page ./foo.1x.gz into a device independent (dvi) file.   The  redi‐
           rection is necessary as the -T flag causes output to be directed to
           stdout with no pager.  The output could be viewed  with  a  program
           such  as  xdvi or further processed into PostScript using a program
           such as dvips.

       man -k printf
           Search the short descriptions and manual page names for the keyword
           printf  as  regular expression.  Print out any matches.  Equivalent
           to apropos -r printf.

       man -f smail
           Lookup the manual pages referenced by smail and print out the short
           descriptions of any found.  Equivalent to whatis -r smail.

OVERVIEW
       Many  options are available to man in order to give as much flexibility
       as possible to the user.  Changes can be made to the search path,  sec‐
       tion  order,  output  processor,  and  other  behaviours and operations
       detailed below.

       If set, various environment variables are interrogated to determine the
       operation  of  man.   It  is  possible  to set the `catch all' variable
       $MANOPT to any string in command line format with  the  exception  that
       any  spaces  used as part of an option's argument must be escaped (pre‐
       ceded by a backslash).  man will parse $MANOPT prior to parsing its own
       command  line.   Those options requiring an argument will be overridden
       by the same options found on the command line.  To  reset  all  of  the
       options set in $MANOPT, -D can be specified as the initial command line
       option.  This will allow man to `forget' about the options specified in
       $MANOPT although they must still have been valid.

       The  manual  pager  utilities  packaged as man-db make extensive use of
       index database caches.  These caches contain information such as  where
       each  manual  page  can  be found on the filesystem and what its whatis
       (short one line description of the man page) contains, and allow man to
       run  faster  than  if it had to search the filesystem each time to find
       the appropriate manual page.  If requested using  the  -u  option,  man
       will  ensure  that  the caches remain consistent, which can obviate the
       need to manually run software to update traditional whatis  text  data‐
       bases.

       If  man  cannot  find a mandb initiated index database for a particular
       manual page hierarchy, it will still search for  the  requested  manual
       pages,  although  file globbing will be necessary to search within that
       hierarchy.  If whatis or apropos fails to find an index it will try  to
       extract information from a traditional whatis database instead.

       These  utilities  support  compressed  source  nroff  files  having, by
       default, the extensions of .Z, .z and .gz.  It is possible to deal with
       any  compression  extension, but this information must be known at com‐
       pile time.  Also, by default, any cat  pages  produced  are  compressed
       using gzip.  Each `global' manual page hierarchy such as /usr/share/man
       or /usr/X11R6/man may have any directory as  its  cat  page  hierarchy.
       Traditionally  the cat pages are stored under the same hierarchy as the
       man pages, but for reasons such as those specified in the File  Hierar‐
       chy  Standard  (FHS),  it  may  be better to store them elsewhere.  For
       details on how to do this, please read manpath(5).  For details on  why
       to do this, read the standard.

       International  support is available with this package.  Native language
       manual pages are accessible (if available on your system)  via  use  of
       locale  functions.   To  activate  such support, it is necessary to set
       either $LC_MESSAGES, $LANG  or  another  system  dependent  environment
       variable to your language locale, usually specified in the POSIX 1003.1
       based format:

       <language>[_<territory>[.<character-set>[,<version>]]]

       If the desired page is available in your locale, it will  be  displayed
       in lieu of the standard (usually American English) page.

       Support  for  international message catalogues is also featured in this
       package and can be activated in the same way, again if  available.   If
       you  find  that  the  manual pages and message catalogues supplied with
       this package are not available in your native language  and  you  would
       like  to supply them, please contact the maintainer who will be coordi‐
       nating such activity.

       For information regarding other features and extensions available  with
       this manual pager, please read the documents supplied with the package.

DEFAULTS
       man  will search for the desired manual pages within the index database
       caches. If the -u option is given, a cache consistency  check  is  per‐
       formed  to  ensure the databases accurately reflect the filesystem.  If
       this option is always given, it is not generally necessary to run mandb
       after the caches are initially created, unless a cache becomes corrupt.
       However, the cache consistency check can be slow on systems  with  many
       manual  pages  installed, so it is not performed by default, and system
       administrators may wish to run mandb every week or so to keep the data‐
       base  caches  fresh.   To forestall problems caused by outdated caches,
       man will fall back to file globbing if a cache lookup fails, just as it
       would if no cache was present.

       Once  a  manual page has been located, a check is performed to find out
       if a relative preformatted `cat' file already exists and is newer  than
       the nroff file.  If it does and is, this preformatted file is (usually)
       decompressed and then displayed, via use of a pager.  The pager can  be
       specified  in  a number of ways, or else will fall back to a default is
       used (see option -P for details).  If no cat is found or is older  than
       the  nroff  file, the nroff is filtered through various programs and is
       shown immediately.

       If a cat file can be produced (a relative cat directory exists and  has
       appropriate  permissions),  man will compress and store the cat file in
       the background.

       The filters are deciphered by a number of means. Firstly,  the  command
       line option -p or the environment variable $MANROFFSEQ is interrogated.
       If -p was not used and the environment variable was not set,  the  ini‐
       tial  line  of  the nroff file is parsed for a preprocessor string.  To
       contain a valid preprocessor string, the first line must resemble

       '\" <string>

       where string can be any combination of letters described by  option  -p
       below.

       If  none of the above methods provide any filter information, a default
       set is used.

       A formatting pipeline is formed from the filters and the  primary  for‐
       matter  (nroff or [tg]roff with -t) and executed.  Alternatively, if an
       executable program mandb_nfmt (or mandb_tfmt with -t) exists in the man
       tree  root,  it  is executed instead.  It gets passed the manual source
       file, the preprocessor string, and optionally the device specified with
       -T or -E as arguments.

OPTIONS
       Non argument options that are duplicated either on the command line, in
       $MANOPT, or both, are not harmful.  For options that require  an  argu‐
       ment, each duplication will override the previous argument value.

   General options
       -C file, --config-file=file
              Use  this  user  configuration  file  rather than the default of
              ~/.manpath.

       -d, --debug
              Print debugging information.

       -D, --default
              This option is normally issued as  the  very  first  option  and
              resets  man's  behaviour  to  its  default.  Its use is to reset
              those options that may have been set in  $MANOPT.   Any  options
              that follow -D will have their usual effect.

       --warnings[=warnings]
              Enable  warnings from groff.  This may be used to perform sanity
              checks on the source text of manual pages.  warnings is a comma-
              separated  list  of  warning  names;  if it is not supplied, the
              default is "mac".  See the “Warnings” node in info groff  for  a
              list of available warning names.

   Main modes of operation
       -f, --whatis
              Equivalent to whatis.  Display a short description from the man‐
              ual page, if available. See whatis(1) for details.

       -k, --apropos
              Equivalent to apropos.  Search the short  manual  page  descrip‐
              tions  for keywords and display any matches.  See apropos(1) for
              details.

       -K, --global-apropos
              Search for text in all manual  pages.   This  is  a  brute-force
              search,  and is likely to take some time; if you can, you should
              specify a section to reduce the number of pages that need to  be
              searched.   Search terms may be simple strings (the default), or
              regular expressions if the --regex option is used.

       -l, --local-file
              Activate `local' mode.  Format and display  local  manual  files
              instead  of  searching  through  the system's manual collection.
              Each manual page argument will be interpreted as an nroff source
              file in the correct format.  No cat file is produced.  If '-' is
              listed as one of the arguments, input will be taken from  stdin.
              When  this  option  is  not used, and man fails to find the page
              required, before displaying the error message,  it  attempts  to
              act as if this option was supplied, using the name as a filename
              and looking for an exact match.

       -w, --where, --path, --location
              Don't actually display the manual pages, but do print the  loca‐
              tion(s) of the source nroff files that would be formatted.

       -W, --where-cat, --location-cat
              Don't  actually display the manual pages, but do print the loca‐
              tion(s) of the cat files that would be displayed.  If -w and  -W
              are both specified, print both separated by a space.

       -c, --catman
              This  option  is  not for general use and should only be used by
              the catman program.

       -R encoding, --recode=encoding
              Instead of formatting the manual page in the usual  way,  output
              its  source converted to the specified encoding.  If you already
              know the encoding of the source file,  you  can  also  use  man‐
              conv(1)  directly.   However,  this option allows you to convert
              several manual pages to a  single  encoding  without  having  to
              explicitly  state  the encoding of each, provided that they were
              already installed in a structure similar to a manual page  hier‐
              archy.

   Finding manual pages
       -L locale, --locale=locale
              man will normally determine your current locale by a call to the
              C function setlocale(3) which interrogates  various  environment
              variables, possibly including $LC_MESSAGES and $LANG.  To tempo‐
              rarily override the determined value, use this option to  supply
              a  locale  string  directly  to man.  Note that it will not take
              effect until the search for pages actually begins.  Output  such
              as  the  help  message will always be displayed in the initially
              determined locale.

       -m system[,...], --systems=system[,...]
              If this system has access to  other  operating  system's  manual
              pages,  they can be accessed using this option.  To search for a
              manual page from NewOS's manual page collection, use the  option
              -m NewOS.

              The  system  specified  can  be a combination of comma delimited
              operating system names.  To include a search of the native oper‐
              ating  system's manual pages, include the system name man in the
              argument string.  This option will override the $SYSTEM environ‐
              ment variable.

       -M path, --manpath=path
              Specify  an alternate manpath to use.  By default, man uses man‐
              path derived code to determine the path to search.  This  option
              overrides the $MANPATH environment variable and causes option -m
              to be ignored.

              A path specified as a manpath must be the root of a manual  page
              hierarchy  structured  into  sections as described in the man-db
              manual (under "The manual page system").  To view  manual  pages
              outside such hierarchies, see the -l option.

       -S list, -s list, --sections=list
              List  is  a  colon-  or comma-separated list of `order specific'
              manual sections to search.  This option overrides  the  $MANSECT
              environment  variable.   (The  -s  spelling is for compatibility
              with System V.)

       -e sub-extension, --extension=sub-extension
              Some systems incorporate large packages of manual pages, such as
              those  that accompany the Tcl package, into the main manual page
              hierarchy.  To get around the problem of having two manual pages
              with  the  same name such as exit(3), the Tcl pages were usually
              all assigned to section l.  As this is unfortunate,  it  is  now
              possible  to put the pages in the correct section, and to assign
              a specific `extension' to them, in this case, exit(3tcl).  Under
              normal  operation,  man  will  display  exit(3) in preference to
              exit(3tcl).  To negotiate this situation and to avoid having  to
              know  which  section  the page you require resides in, it is now
              possible to give man a  sub-extension  string  indicating  which
              package  the page must belong to.  Using the above example, sup‐
              plying the option -e tcl to man  will  restrict  the  search  to
              pages having an extension of *tcl.

       -i, --ignore-case
              Ignore  case  when  searching  for  manual  pages.   This is the
              default.

       -I, --match-case
              Search for manual pages case-sensitively.

       --regex
              Show all pages with any part of  either  their  names  or  their
              descriptions  matching  each  page argument as a regular expres‐
              sion, as with apropos(1).  Since there is usually no  reasonable
              way  to  pick a "best" page when searching for a regular expres‐
              sion, this option implies -a.

       --wildcard
              Show all pages with any part of  either  their  names  or  their
              descriptions matching each page argument using shell-style wild‐
              cards, as with apropos(1) --wildcard.  The  page  argument  must
              match  the  entire  name or description, or match on word bound‐
              aries in the description.  Since there is usually no  reasonable
              way  to  pick  a "best" page when searching for a wildcard, this
              option implies -a.

       --names-only
              If the --regex or --wildcard option is  used,  match  only  page
              names,  not page descriptions, as with whatis(1).  Otherwise, no
              effect.

       -a, --all
              By default, man will exit after  displaying  the  most  suitable
              manual  page  it finds.  Using this option forces man to display
              all the manual pages with names that match the search criteria.

       -u, --update
              This option causes man to perform an `inode  level'  consistency
              check on its database caches to ensure that they are an accurate
              representation of the filesystem.  It will only  have  a  useful
              effect if man is installed with the setuid bit set.

       --no-subpages
              By default, man will try to interpret pairs of manual page names
              given on the command line as equivalent to a single manual  page
              name  containing  a  hyphen or an underscore.  This supports the
              common pattern of programs that implement a  number  of  subcom‐
              mands,  allowing  them to provide manual pages for each that can
              be accessed using similar syntax as would be used to invoke  the
              subcommands themselves.  For example:

                $ man -aw git diff
                /usr/share/man/man1/git-diff.1.gz

              To disable this behaviour, use the --no-subpages option.

                $ man -aw --no-subpages git diff
                /usr/share/man/man1/git.1.gz
                /usr/share/man/man3/Git.3pm.gz
                /usr/share/man/man1/diff.1.gz

   Controlling formatted output
       -P pager, --pager=pager
              Specify  which  output  pager to use.  By default, man uses less
              -s.  This option overrides the $MANPAGER  environment  variable,
              which  in turn overrides the $PAGER environment variable.  It is
              not used in conjunction with -f or -k.

              The value may be a simple command name or a command  with  argu‐
              ments, and may use shell quoting (backslashes, single quotes, or
              double quotes).  It may not use pipes to connect  multiple  com‐
              mands;  if  you  need that, use a wrapper script, which may take
              the file to display either as an argument or on standard input.

       -r prompt, --prompt=prompt
              If a recent version of less is  used  as  the  pager,  man  will
              attempt  to  set  its  prompt  and  some  sensible options.  The
              default prompt looks like

               Manual page name(sec) line x

              where name denotes the manual page name, sec denotes the section
              it  was  found  under  and  x  the current line number.  This is
              achieved by using the $LESS environment variable.

              Supplying -r with a string  will  override  this  default.   The
              string  may  contain  the text $MAN_PN which will be expanded to
              the name of the current manual page and its  section  name  sur‐
              rounded  by `(' and `)'.  The string used to produce the default
              could be expressed as

              \ Manual\ page\ \$MAN_PN\ ?ltline\ %lt?L/%L.:
              byte\ %bB?s/%s..?\ (END):?pB\ %pB\\%..
              (press h for help or q to quit)

              It is broken into three lines here for the sake  of  readability
              only.   For its meaning see the less(1) manual page.  The prompt
              string is first evaluated by  the  shell.   All  double  quotes,
              back-quotes  and  backslashes in the prompt must be escaped by a
              preceding backslash.  The prompt string may end in an escaped  $
              which  may  be followed by further options for less.  By default
              man sets the -ix8 options.

              If you want to override  man's  prompt  string  processing  com‐
              pletely, use the $MANLESS environment variable described below.

       -7, --ascii
              When  viewing a pure ascii(7) manual page on a 7 bit terminal or
              terminal emulator, some characters  may  not  display  correctly
              when  using  the  latin1(7)  device  description with GNU nroff.
              This option allows pure ascii manual pages to  be  displayed  in
              ascii  with the latin1 device.  It will not translate any latin1
              text.  The following table  shows  the  translations  performed:
              some  parts  of it may only be displayed properly when using GNU
              nroff's latin1(7) device.


              Description        Octal   latin1   ascii
              ──────────────────────────────────────────
              continuation        255      ‐        -
              hyphen
              bullet   (middle    267      ·        o
              dot)
              acute accent        264      ´        '
              multiplication      327      ×        x
              sign

              If  the  latin1  column displays correctly, your terminal may be
              set up for latin1 characters and this option is  not  necessary.
              If  the  latin1 and ascii columns are identical, you are reading
              this page using this option or man  did  not  format  this  page
              using  the  latin1  device description.  If the latin1 column is
              missing or corrupt, you may need to view manual pages with  this
              option.

              This  option is ignored when using options -t, -H, -T, or -Z and
              may be useless for nroff other than GNU's.

       -E encoding, --encoding=encoding
              Generate output for a character encoding other than the default.
              For backward compatibility, encoding may be an nroff device such
              as ascii, latin1, or utf8 as well as a true  character  encoding
              such as UTF-8.

       --no-hyphenation, --nh
              Normally, nroff will automatically hyphenate text at line breaks
              even in words that do not contain hyphens, if it is necessary to
              do  so  to  lay  out  words on a line without excessive spacing.
              This option disables automatic hyphenation, so words  will  only
              be hyphenated if they already contain hyphens.

              If  you  are  writing  a  manual page and simply want to prevent
              nroff from hyphenating a word at an inappropriate point, do  not
              use  this  option,  but consult the nroff documentation instead;
              for instance, you can put "\%" inside a word to indicate that it
              may  be  hyphenated at that point, or put "\%" at the start of a
              word to prevent it from being hyphenated.

       --no-justification, --nj
              Normally, nroff will automatically justify text to both margins.
              This  option disables full justification, leaving justified only
              to the left margin, sometimes called "ragged-right" text.

              If you are writing a manual page  and  simply  want  to  prevent
              nroff  from  justifying  certain  paragraphs,  do  not  use this
              option,  but  consult  the  nroff  documentation  instead;   for
              instance,  you  can  use  the  ".na",  ".nf",  ".fi",  and ".ad"
              requests to temporarily disable adjusting and filling.

       -p string, --preprocessor=string
              Specify the sequence of preprocessors to  run  before  nroff  or
              troff/groff.  Not all installations will have a full set of pre‐
              processors.  Some of the preprocessors and the letters  used  to
              designate  them are: eqn (e), grap (g), pic (p), tbl (t), vgrind
              (v), refer (r).  This option overrides the $MANROFFSEQ  environ‐
              ment  variable.   zsoelim  is  always run as the very first pre‐
              processor.

       -t, --troff
              Use groff -mandoc to format the manual  page  to  stdout.   This
              option is not required in conjunction with -H, -T, or -Z.

       -T[device], --troff-device[=device]
              This option is used to change groff (or possibly troff's) output
              to be suitable for a device other than the default.  It  implies
              -t.   Examples  (provided  with Groff-1.17) include dvi, latin1,
              ps, utf8, X75 and X100.

       -H[browser], --html[=browser]
              This option will cause groff to produce HTML  output,  and  will
              display  that output in a web browser.  The choice of browser is
              determined by the optional browser argument if one is  provided,
              by  the  $BROWSER  environment  variable,  or  by a compile-time
              default if that is unset (usually lynx).   This  option  implies
              -t, and will only work with GNU troff.

       -X[dpi], --gxditview[=dpi]
              This  option  displays the output of groff in a graphical window
              using the gxditview program.  The dpi (dots per inch) may be 75,
              75-12,  100, or 100-12, defaulting to 75; the -12 variants use a
              12-point base font.   This  option  implies  -T  with  the  X75,
              X75-12, X100, or X100-12 device respectively.

       -Z, --ditroff
              groff  will run troff and then use an appropriate post-processor
              to produce output suitable for  the  chosen  device.   If  groff
              -mandoc  is  groff, this option is passed to groff and will sup‐
              press the use of a post-processor.  It implies -t.

   Getting help
       -?, --help
              Print a help message and exit.

       --usage
              Print a short usage message and exit.

       -V, --version
              Display version information.

EXIT STATUS
       0      Successful program execution.

       1      Usage, syntax or configuration file error.

       2      Operational error.

       3      A child process returned a non-zero exit status.

       16     At least one of the pages/files/keywords didn't exist or  wasn't
              matched.

ENVIRONMENT
       MANPATH
              If  $MANPATH is set, its value is used as the path to search for
              manual pages.

       MANROFFOPT
              The contents of $MANROFFOPT are added to the command line  every
              time man invokes the formatter (nroff, troff, or groff).

       MANROFFSEQ
              If $MANROFFSEQ is set, its value is used to determine the set of
              preprocessors to pass each manual  page  through.   The  default
              preprocessor list is system dependent.

       MANSECT
              If  $MANSECT is set, its value is a colon-delimited list of sec‐
              tions and it is used  to  determine  which  manual  sections  to
              search and in what order.

       MANPAGER, PAGER
              If $MANPAGER or $PAGER is set ($MANPAGER is used in preference),
              its value is used as the name of the program used to display the
              manual page.  By default, less -s is used.

              The  value  may be a simple command name or a command with argu‐
              ments, and may use shell quoting (backslashes, single quotes, or
              double  quotes).   It may not use pipes to connect multiple com‐
              mands; if you need that, use a wrapper script,  which  may  take
              the file to display either as an argument or on standard input.

       MANLESS
              If  $MANLESS  is set, man will not perform any of its usual pro‐
              cessing to set up a prompt string for the less pager.   Instead,
              the  value  of $MANLESS will be copied verbatim into $LESS.  For
              example, if you want to set the prompt string unconditionally to
              “my prompt string”, set $MANLESS to ‘-Psmy prompt string’.

       BROWSER
              If  $BROWSER is set, its value is a colon-delimited list of com‐
              mands, each of which in turn is used  to  try  to  start  a  web
              browser  for  man  --html.  In each command, %s is replaced by a
              filename containing the HTML output from groff, %%  is  replaced
              by a single percent sign (%), and %c is replaced by a colon (:).

       SYSTEM If  $SYSTEM  is  set,  it will have the same effect as if it had
              been specified as the argument to the -m option.

       MANOPT If $MANOPT is set, it will be parsed prior to man's command line
              and  is expected to be in a similar format.  As all of the other
              man specific environment variables can be expressed  as  command
              line  options,  and  are  thus  candidates for being included in
              $MANOPT it is expected that they will become obsolete.  N.B. All
              spaces  that  should be interpreted as part of an option's argu‐
              ment must be escaped.

       MANWIDTH
              If $MANWIDTH is set, its value is used as the  line  length  for
              which  manual pages should be formatted.  If it is not set, man‐
              ual pages will be formatted with a line  length  appropriate  to
              the  current terminal (using an ioctl(2) if available, the value
              of $COLUMNS, or falling back to  80  characters  if  neither  is
              available).   Cat pages will only be saved when the default for‐
              matting can be used, that is when the terminal  line  length  is
              between 66 and 80 characters.

       MAN_KEEP_FORMATTING
              Normally,  when output is not being directed to a terminal (such
              as to a file or a pipe), formatting characters are discarded  to
              make  it  easier to read the result without special tools.  How‐
              ever, if $MAN_KEEP_FORMATTING is set  to  any  non-empty  value,
              these  formatting  characters  are retained.  This may be useful
              for wrappers around man that can  interpret  formatting  charac‐
              ters.

       MAN_KEEP_STDERR
              Normally,  when  output is being directed to a terminal (usually
              to a pager), any error output from the command used  to  produce
              formatted  versions of manual pages is discarded to avoid inter‐
              fering with the pager's display.  Programs such as  groff  often
              produce  relatively  minor  error  messages  about typographical
              problems such as poor alignment, which are unsightly and  gener‐
              ally  confusing when displayed along with the manual page.  How‐
              ever,  some  users   want   to   see   them   anyway,   so,   if
              $MAN_KEEP_STDERR  is  set  to  any non-empty value, error output
              will be displayed as usual.

       LANG, LC_MESSAGES
              Depending on system and implementation, either or both of  $LANG
              and  $LC_MESSAGES  will  be interrogated for the current message
              locale.  man will display its messages in that locale (if avail‐
              able).  See setlocale(3) for precise details.

FILES
       /etc/man_db.conf
              man-db configuration file.

       /usr/share/man
              A global manual page hierarchy.

       /usr/share/man/index.(bt|db|dir|pag)
              A traditional global index database cache.

       /var/cache/man/index.(bt|db|dir|pag)
              An FHS compliant global index database cache.

SEE ALSO
       apropos(1),   groff(1),   less(1),   manpath(1),   nroff(1),  troff(1),
       whatis(1), zsoelim(1), setlocale(3), manpath(5),  ascii(7),  latin1(7),
       man(7), catman(8), mandb(8), the man-db package manual, FSSTND

HISTORY
       1990, 1991 - Originally written by John W. Eaton (jwe@che.utexas.edu).

       Dec 23 1992: Rik Faith (faith@cs.unc.edu) applied bug fixes supplied by
       Willem Kasdorp (wkasdo@nikhefk.nikef.nl).

       30th April 1994 - 23rd February 2000: Wilf. (G.Wilford@ee.surrey.ac.uk)
       has been developing and maintaining this package with the help of a few
       dedicated people.

       30th  October  1996  -  30th  March  2001:   Fabrizio   Polacco   <fpo‐
       lacco@debian.org>  maintained  and enhanced this package for the Debian
       project, with the help of all the community.

       31st March 2001 - present day: Colin  Watson  <cjwatson@debian.org>  is
       now developing and maintaining man-db.



2.6.3                             2012-09-17                            MAN(1)
MAN(1P)                    POSIX Programmer's Manual                   MAN(1P)



PROLOG
       This  manual  page is part of the POSIX Programmer's Manual.  The Linux
       implementation of this interface may differ (consult the  corresponding
       Linux  manual page for details of Linux behavior), or the interface may
       not be implemented on Linux.

NAME
       man - display system documentation

SYNOPSIS
       man [-k] name...

DESCRIPTION
       The man utility shall write information about each of  the  name  oper‐
       ands. If name is the name of a standard utility, man at a minimum shall
       write a message describing the syntax used by the standard utility, its
       options,  and operands. If more information is available, the man util‐
       ity shall provide it in an implementation-defined manner.

       An implementation may provide information for values of name other than
       the  standard utilities. Standard utilities that are listed as optional
       and that are not supported by the implementation either shall  cause  a
       brief  message  indicating  that  fact to be displayed or shall cause a
       full display of information as described previously.

OPTIONS
       The man utility  shall  conform  to  the  Base  Definitions  volume  of
       IEEE Std 1003.1-2001, Section 12.2, Utility Syntax Guidelines.

       The following option shall be supported:

       -k     Interpret  name  operands  as keywords to be used in searching a
              utilities summary database that contains a brief  purpose  entry
              for each standard utility and write lines from the summary data‐
              base that match any of the keywords. The  keyword  search  shall
              produce  results  that  are  the equivalent of the output of the
              following command:


              grep -Ei 'name name...'  summary-database

       This assumes that the summary-database is a text  file  with  a  single
       entry per line; this organization is not required and the example using
       grep -Ei is merely illustrative of the type  of  search  intended.  The
       purpose  entry  to be included in the database shall consist of a terse
       description of the purpose of the utility.


OPERANDS
       The following operand shall be supported:

       name   A keyword or the name of a standard  utility.  When  -k  is  not
              specified and name does not represent one of the standard utili‐
              ties, the results are unspecified.


STDIN
       Not used.

INPUT FILES
       None.

ENVIRONMENT VARIABLES
       The following environment variables shall affect the execution of man:

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
              opposed to multi-byte characters in arguments and in the summary
              database).  The value of LC_CTYPE need not affect the format  of
              the information written about the name operands.

       LC_MESSAGES
              Determine  the  locale  that should be used to affect the format
              and contents of diagnostic messages written  to  standard  error
              and informative messages written to standard output.

       NLSPATH
              Determine the location of message catalogs for the processing of
              LC_MESSAGES .

       PAGER  Determine an output filtering command for writing the output  to
              a terminal. Any string acceptable as a command_string operand to
              the sh -c command shall be valid. When standard output is a ter‐
              minal  device,  the reference page output shall be piped through
              the command.  If the PAGER variable is null or not set, the com‐
              mand  shall  be  either  more or another paginator utility docu‐
              mented in the system documentation.


ASYNCHRONOUS EVENTS
       Default.

STDOUT
       The man utility shall write text describing the syntax of  the  utility
       name,  its  options  and  its operands, or, when -k is specified, lines
       from the summary database. The format of this text  is  implementation-
       defined.

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
       None.

EXAMPLES
       None.

RATIONALE
       It  is recognized that the man utility is only of minimal usefulness as
       specified. The opinion of the standard developers was strongly  divided
       as to how much or how little information man should be required to pro‐
       vide. They considered, however, that the provision of some portable way
       of  accessing  documentation  would aid user portability. The arguments
       against a fuller specification were:

        * Large quantities of documentation should not be required on a system
          that does not have excess disk space.

        * The  current  manual system does not present information in a manner
          that greatly aids user portability.

        * A "better help system" is currently an area in  which  vendors  feel
          that they can add value to their POSIX implementations.

       The -f option was considered, but due to implementation differences, it
       was not included in this volume of IEEE Std 1003.1-2001.

       The description was changed to be more specific about what  has  to  be
       displayed for a utility. The standard developers considered it insuffi‐
       cient to allow a display of only the synopsis without  giving  a  short
       description of what each option and operand does.

       The  "purpose"  entry  to be included in the database can be similar to
       the section title  (less  the  numeric  prefix)  from  this  volume  of
       IEEE Std 1003.1-2001  for  each  utility.  These  titles are similar to
       those used in historical systems for this purpose.

       See mailx for rationale concerning the default paginator.

       The caveat in the LC_CTYPE description was added because it  is  not  a
       requirement  that  an implementation provide reference pages for all of
       its supported locales on each system; changing LC_CTYPE does not neces‐
       sarily  translate  the  reference  page  into another language. This is
       equivalent    to    the    current    state    of    LC_MESSAGES     in
       IEEE Std 1003.1-2001-locale-specific  messages  are  not yet a require‐
       ment.

       The historical MANPATH variable is not included  in  POSIX  because  no
       attempt is made to specify naming conventions for reference page files,
       nor even to mandate that they are files at all.   On  some  implementa‐
       tions  they  could  be a true database, a hypertext file, or even fixed
       strings within the man executable.  The standard developers  considered
       the  portability  of reference pages to be outside their scope of work.
       However, users should be aware that MANPATH is implemented on a  number
       of historical systems and that it can be used to tailor the search pat‐
       tern for reference pages from the various categories (utilities,  func‐
       tions,  file  formats, and so on) when the system administrator reveals
       the location and conventions for reference pages on the system.

       The keyword search can rely on at least the text of the section  titles
       from  these  utility  descriptions, and the implementation may add more
       keywords. The term "section titles" refers to the strings such as:


              man - Display system documentation
              ps - Report process status

FUTURE DIRECTIONS
       None.

SEE ALSO
       more

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



IEEE/The Open Group                  2003                              MAN(1P)
MAN(7)                     Linux Programmer's Manual                    MAN(7)



NAME
       man - macros to format man pages

SYNOPSIS
       groff -Tascii -man file ...

       groff -Tps -man file ...

       man [section] title

DESCRIPTION
       This manual page explains the groff an.tmac macro package (often called
       the man macro package).  This macro package should be used by  develop‐
       ers when writing or porting man pages for Linux.  It is fairly compati‐
       ble with other versions of this macro package,  so  porting  man  pages
       should  not  be  a  major  problem  (exceptions  include  the NET-2 BSD
       release, which uses a totally different macro package called mdoc;  see
       mdoc(7)).

       Note  that  NET-2  BSD  mdoc man pages can be used with groff simply by
       specifying the -mdoc option instead of  the  -man  option.   Using  the
       -mandoc  option is, however, recommended, since this will automatically
       detect which macro package is in use.

       For conventions that should be employed when writing man pages for  the
       Linux man-pages package, see man-pages(7).

   Title line
       The  first  command  in a man page (after comment lines, that is, lines
       that start with .\") should be

              .TH title section date source manual

       For details of the arguments that should be supplied to the TH command,
       see man-pages(7).

       Note  that  BSD mdoc-formatted pages begin with the Dd command, not the
       TH command.

   Sections
       Sections are started with .SH followed by the heading name.

       The only mandatory heading is NAME, which should be the  first  section
       and  be followed on the next line by a one-line description of the pro‐
       gram:

              .SH NAME
              item \- description

       It is extremely important that this format is followed, and that  there
       is  a  backslash  before  the  single dash which follows the item name.
       This syntax is used by the mandb(8) program to  create  a  database  of
       short  descriptions  for  the  whatis(1) and apropos(1) commands.  (See
       lexgrog(1) for further details on the syntax of the NAME section.)

       For a list of other sections that might appear in a  manual  page,  see
       man-pages(7).

   Fonts
       The commands to select the type face are:

       .B  Bold

       .BI Bold alternating with italics (especially useful for function spec‐
           ifications)

       .BR Bold alternating with Roman (especially  useful  for  referring  to
           other manual pages)

       .I  Italics

       .IB Italics alternating with bold

       .IR Italics alternating with Roman

       .RB Roman alternating with bold

       .RI Roman alternating with italics

       .SB Small alternating with bold

       .SM Small (useful for acronyms)

       Traditionally,  each  command can have up to six arguments, but the GNU
       implementation removes this limitation (you might still want  to  limit
       yourself  to 6 arguments for portability's sake).  Arguments are delim‐
       ited by spaces.  Double quotes can be used to specify an argument which
       contains  spaces.   All  of  the arguments will be printed next to each
       other without intervening spaces, so that the .BR command can  be  used
       to  specify  a word in bold followed by a mark of punctuation in Roman.
       If no arguments are given, the command is applied to the following line
       of text.

   Other macros and strings
       Below  are  other relevant macros and predefined strings.  Unless noted
       otherwise, all macros cause a break (end the  current  line  of  text).
       Many of these macros set or use the "prevailing indent."  The "prevail‐
       ing indent" value is set by any  macro  with  the  parameter  i  below;
       macros  may  omit i in which case the current prevailing indent will be
       used.  As a result, successive indented paragraphs  can  use  the  same
       indent  without  respecifying the indent value.  A normal (nonindented)
       paragraph resets the prevailing indent value to its default value  (0.5
       inches).   By default a given indent is measured in ens; try to use ens
       or ems as units for indents, since these will automatically  adjust  to
       font size changes.  The other key macro definitions are:

   Normal paragraphs
       .LP      Same as .PP (begin a new paragraph).

       .P       Same as .PP (begin a new paragraph).

       .PP      Begin a new paragraph and reset prevailing indent.

   Relative margin indent
       .RS i    Start  relative  margin indent: moves the left margin i to the
                right (if i is omitted, the prevailing indent value is  used).
                A  new  prevailing  indent is set to 0.5 inches.  As a result,
                all following paragraph(s) will be indented until  the  corre‐
                sponding .RE.

       .RE      End  relative margin indent and restores the previous value of
                the prevailing indent.

   Indented paragraph macros
       .HP i    Begin paragraph with a hanging indent (the first line  of  the
                paragraph  is at the left margin of normal paragraphs, and the
                rest of the paragraph's lines are indented).

       .IP x i  Indented paragraph with optional hanging tag.  If the tag x is
                omitted,  the entire following paragraph is indented by i.  If
                the tag x is provided, it is hung at the  left  margin  before
                the following indented paragraph (this is just like .TP except
                the tag is included with the command instead of being  on  the
                following  line).   If the tag is too long, the text after the
                tag will be moved down to the next line (text will not be lost
                or  garbled).   For  bulleted  lists, use this macro with \(bu
                (bullet) or \(em (em dash) as the tag, and for numbered lists,
                use the number or letter followed by a period as the tag; this
                simplifies translation to other formats.

       .TP i    Begin paragraph with hanging tag.  The tag  is  given  on  the
                next line, but its results are like those of the .IP command.

   Hypertext link macros
       (Feature  supported  with  groff only.)  In order to use hypertext link
       macros, it is necessary to load the www.tmac macro  package.   Use  the
       request .mso www.tmac to do this.

       .URL url link trailer
                Inserts  a  hypertext  link to the URI (URL) url, with link as
                the text of the link.  The trailer will be printed immediately
                afterward.   When  generating  HTML this should translate into
                the HTML command <A HREF="url">link</A>trailer.

                This and other related macros are new, and many tools won't do
                anything  with  them,  but  since many tools (including troff)
                will simply ignore undefined macros (or at worst insert  their
                text) these are safe to insert.

                It  can be useful to define your own URL macro in manual pages
                for the benefit of those viewing it with a roff  viewer  other
                than  groff.   That  way, the URL, link text, and trailer text
                (if any) are still visible.

                Here's an example:
                      .de URL
                      \\$2 \(laURL: \\$1 \(ra\\$3
                      ..
                      .if \n[.g] .mso www.tmac
                      .TH ...
                      (later in the page)
                      This software comes from the
                      .URL "http://www.gnu.org/" "GNU Project" " of the"
                      .URL "http://www.fsf.org/" "Free Software Foundation" .

                In the above, if groff is being used, the www.tmac macro pack‐
                age's  definition  of the URL macro will supersede the locally
                defined one.

       A number of other link macros are available.  See groff_www(7) for more
       details.

   Miscellaneous macros
       .DT      Reset  tabs to default tab values (every 0.5 inches); does not
                cause a break.

       .PD d    Set  inter-paragraph  vertical  distance  to  d  (if  omitted,
                d=0.4v); does not cause a break.

       .SS t    Subheading  t  (like  .SH,  but used for a subsection inside a
                section).

   Predefined strings
       The man package has the following predefined strings:

       \*R    Registration Symbol: ®

       \*S    Change to default font size

       \*(Tm  Trademark Symbol: ™

       \*(lq  Left angled double quote: “

       \*(rq  Right angled double quote: ”

   Safe subset
       Although technically man is a troff macro package, in reality  a  large
       number  of  other tools process man page files that don't implement all
       of troff's abilities.  Thus, it's best to avoid some  of  troff's  more
       exotic  abilities  where  possible  to permit these other tools to work
       correctly.  Avoid using the various troff preprocessors (if  you  must,
       go  ahead and use tbl(1), but try to use the IP and TP commands instead
       for two-column tables).  Avoid using  computations;  most  other  tools
       can't  process them.  Use simple commands that are easy to translate to
       other formats.  The following troff macros  are  believed  to  be  safe
       (though  in many cases they will be ignored by translators): \", ., ad,
       bp, br, ce, de, ds, el, ie, if, fi, ft, hy, ig, in, na, ne, nf, nh, ps,
       so, sp, ti, tr.

       You may also use many troff escape sequences (those sequences beginning
       with \).  When you need to include the backslash  character  as  normal
       text, use \e.  Other sequences you may use, where x or xx are any char‐
       acters and N is any digit, include: \', \`, \-, \., \", \%, \*x, \*(xx,
       \(xx,  \$N,  \nx,  \n(xx,  \fx,  and  \f(xx.   Avoid  using  the escape
       sequences for drawing graphics.

       Do not use the optional parameter for bp (break page).  Use only  posi‐
       tive  values  for  sp (vertical space).  Don't define a macro (de) with
       the same name as a macro in this or the mdoc macro package with a  dif‐
       ferent  meaning;  it's  likely that such redefinitions will be ignored.
       Every positive indent (in) should be paired with  a  matching  negative
       indent  (although  you  should  be using the RS and RE macros instead).
       The condition test (if,ie) should only have 't' or 'n'  as  the  condi‐
       tion.  Only translations (tr) that can be ignored should be used.  Font
       changes (ft and the \f escape sequence) should only have the values  1,
       2,  3,  4,  R,  I, B, P, or CW (the ft command may also have no parame‐
       ters).

       If you use capabilities beyond these, check the  results  carefully  on
       several tools.  Once you've confirmed that the additional capability is
       safe, let the maintainer of this document know about the  safe  command
       or sequence that should be added to this list.

FILES
       /usr/share/groff/[*/]tmac/an.tmac
       /usr/man/whatis

NOTES
       By all means include full URLs (or URIs) in the text itself; some tools
       such as man2html(1) can automatically turn them into  hypertext  links.
       You  can also use the new URL macro to identify links to related infor‐
       mation.    If   you   include   URLs,   use   the   full   URL   (e.g.,
       ⟨http://www.kernelnotes.org⟩)  to  ensure  that tools can automatically
       find the URLs.

       Tools processing these files should open the file and examine the first
       nonwhitespace  character.   A  period  (.)  or  single quote (') at the
       beginning of a line indicates a troff-based file (such as man or mdoc).
       A left angle bracket (<) indicates an SGML/XML-based file (such as HTML
       or Docbook).  Anything else suggests simple ASCII text (e.g.,  a  "cat‐
       man" result).

       Many man pages begin with ´\" followed by a space and a list of charac‐
       ters, indicating how the page is to be preprocessed.  For portability's
       sake  to  non-troff  translators we recommend that you avoid using any‐
       thing other than tbl(1), and Linux can detect that automatically.  How‐
       ever,  you  might want to include this information so your man page can
       be handled by other (less capable) systems.  Here are  the  definitions
       of the preprocessors invoked by these characters:

       e  eqn(1)

       g  grap(1)

       p  pic(1)

       r  refer(1)

       t  tbl(1)

       v  vgrind(1)

BUGS
       Most  of  the  macros describe formatting (e.g., font type and spacing)
       instead of marking semantic content (e.g., this text is a reference  to
       another page), compared to formats like mdoc and DocBook (even HTML has
       more semantic markings).  This situation makes it harder  to  vary  the
       man format for different media, to make the formatting consistent for a
       given media, and to automatically insert cross-references.  By sticking
       to  the  safe  subset  described above, it should be easier to automate
       transitioning to a different reference page format in the future.

       The Sun macro TX is not implemented.

SEE ALSO
       apropos(1),  groff(1),  lexgrog(1),  man(1),  man2html(1),   whatis(1),
       groff_man(7), groff_www(7), man-pages(7), mdoc(7), mdoc.samples(7)

COLOPHON
       This  page  is  part of release 3.53 of the Linux man-pages project.  A
       description of the project, and information about reporting  bugs,  can
       be found at http://www.kernel.org/doc/man-pages/.



Linux                             2012-08-05                            MAN(7)
