MANPATH(1)                                Manual pager utils                                MANPATH(1)

NAME
       manpath - determine search path for manual pages

SYNOPSIS
       manpath [-qgdc?V] [-m system[,...]] [-C file]

DESCRIPTION
       If $MANPATH is set, manpath will simply display its contents and issue a warning.  If not, man‐
       path will determine a suitable manual page hierarchy search path and display the results.

       The colon-delimited path is determined using information gained from the  man-db  configuration
       file - (/etc/manpath.config) and the user's environment.

OPTIONS
       -q, --quiet
              Do not issue warnings.

       -d, --debug
              Print debugging information.

       -c, --catpath
              Produce  a  catpath  as opposed to a manpath.  Once the manpath is determined, each path
              element is converted to its relative catpath.

       -g, --global
              Produce a manpath consisting of all paths named as `global' within the man-db configura‐
              tion file.

       -m system[,...], --systems=system[,...]
              If  this  system  has access to other operating system's manual hierarchies, this option
              can be used to include them in the output of manpath.  To include  NewOS's  manual  page
              hierarchies use the option -m NewOS.

              The system specified can be a combination of comma delimited operating system names.  To
              include the native operating system's manual page hierarchies, the system name man  must
              be  included  in the argument string.  This option will override the $SYSTEM environment
              variable.

       -C file, --config-file=file
              Use this user configuration file rather than the default of ~/.manpath.

       -?, --help
              Print a help message and exit.

       --usage
              Print a short usage message and exit.

       -V, --version
              Display version information.

ENVIRONMENT
       MANPATH
              If $MANPATH is set, manpath displays its value rather than determining it  on  the  fly.
              If  $MANPATH  is  prefixed by a colon, then the value of the variable is appended to the
              list determined from the content of the configuration files.  If the colon comes at  the
              end of the value in the variable, then the determined list is appended to the content of
              the variable.  If the value of the variable contains a double colon (::), then  the  de‐
              termined list is inserted in the middle of the value, between the two colons.

       SYSTEM If $SYSTEM is set, it will have the same effect as if it had been specified as the argu‐
              ment to the -m option.

FILES
       /etc/manpath.config  man-db configuration file.

SEE ALSO
       apropos(1), man(1), whatis(1)

AUTHOR
       Wilf. (G.Wilford@ee.surrey.ac.uk).
       Fabrizio Polacco (fpolacco@debian.org).
       Colin Watson (cjwatson@debian.org).

2.8.7                                         2019-08-26                                    MANPATH(1)
MANPATH(5)                                /etc/manpath.config                               MANPATH(5)

NAME
       manpath - format of the /etc/manpath.config file

DESCRIPTION
       The  manpath  configuration file is used by the manual page utilities to assess users' manpaths
       at run time, to indicate which manual page hierarchies (manpaths) are to be treated  as  system
       hierarchies and to assign them directories to be used for storing cat files.

       If the environment variable $MANPATH is already set, the information contained within /etc/man‐
       path.config will not override it.

FORMAT
       The following field types are currently recognised:

       # comment
              Blank lines or those beginning with a # will be treated as comments and ignored.

       MANDATORY_MANPATH manpath_element
              Lines of this form indicate manpaths that every automatically generated $MANPATH  should
              contain.  This will typically include /usr/man.

       MANPATH_MAP path_element manpath_element
              Lines  of  this  form set up $PATH to $MANPATH mappings.  For each path_element found in
              the user's $PATH, manpath_element will be added to the $MANPATH.

       MANDB_MAP manpath_element [ catpath_element ]
              Lines of this form indicate which manpaths are to be treated as system manpaths, and op‐
              tionally where their cat files should be stored.  This field type is particularly impor‐
              tant if man is a setuid program, as (when in the  system  configuration  file  /etc/man‐
              path.config  rather  than  the  per-user configuration file .manpath) it indicates which
              manual page hierarchies to access as the setuid user and which as the invoking user.

              The system manual page hierarchies are usually those stored under /usr such as /usr/man,
              /usr/local/man and /usr/X11R6/man.

              If  cat pages from a particular manpath_element are not to be stored or are to be stored
              in the traditional location, catpath_element may be omitted.

              Traditional cat placement would be impossible for read only mounted manual page  hierar‐
              chies  and  because  of this it is possible to specify any valid directory hierarchy for
              their storage.  To observe the Linux FSSTND the keyword `FSSTND can be used in place  of
              an actual directory.

              Unfortunately, it is necessary to specify all system man tree paths, including alternate
              operating  system  paths  such  as  /usr/man/sun  and  any  NLS  locale  paths  such  as
              /usr/man/de_DE.88591.

              As  the information is parsed line by line in the order written, it is necessary for any
              manpath that is a sub-hierarchy of another hierarchy to be listed  first,  otherwise  an
              incorrect  match will be made.  An example is that /usr/man/de_DE.88591 must come before
              /usr/man.

       DEFINE key value
              Lines of this form define miscellaneous configuration variables; see the default config‐
              uration  file  for those variables used by the manual pager utilities.  They include de‐
              fault paths to various programs (such as grep and tbl), and default sets of arguments to
              those programs.

       SECTION section ...
              Lines  of  this  form  define the order in which manual sections should be searched.  If
              there are no SECTION directives in the configuration file, the default is:

                     SECTION 1 n l 8 3 0 2 5 4 9 6 7

              If multiple SECTION directives are given, their section lists will be concatenated.

              If a particular extension is not in this list (say, 1mh) it will be displayed  with  the
              rest  of the section it belongs to.  The effect of this is that you only need to explic‐
              itly list extensions if you want to force a particular order.  Sections with  extensions
              should usually be adjacent to their main section (e.g. "1 1mh 8 ...").

              SECTIONS is accepted as an alternative name for this directive.

       MINCATWIDTH width
              If  the terminal width is less than width, cat pages will not be created (if missing) or
              displayed.  The default is 80.

       MAXCATWIDTH width
              If the terminal width is greater than width, cat pages will not be created (if  missing)
              or displayed.  The default is 80.

       CATWIDTH width
              If  width  is  non-zero,  cat pages will always be formatted for a terminal of the given
              width, regardless of the width of the terminal actually being used.  This should  gener‐
              ally be within the range set by MINCATWIDTH and MAXCATWIDTH.

       NOCACHE
              This flag prevents man(1) from creating cat pages automatically.

BUGS
       Unless the rules above are followed and observed precisely, the manual pager utilities will not
       function as desired.  The rules are overly complicated.

2.8.7                                         2019-08-26                                    MANPATH(5)
