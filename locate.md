File: find.info,  Node: Invoking locate,  Next: Invoking updatedb,  Prev: Invoking find,  Up: Reference

8.2 Invoking 'locate'
=====================

     locate [OPTION...] PATTERN...

   For each PATTERN given 'locate' searches one or more file name
databases returning each match of PATTERN.

   For each PATTERN given 'locate' searches one or more file name
databases returning each match of PATTERN.

'--all'
'-A'
     Print only names which match all non-option arguments, not those
     matching one or more non-option arguments.

'--basename'
'-b'
     The specified pattern is matched against just the last component of
     the name of a file in the 'locate' database.  This last component
     is also called the "base name".  For example, the base name of
     '/tmp/mystuff/foo.old.c' is 'foo.old.c'.  If the pattern contains
     metacharacters, it must match the base name exactly.  If not, it
     must match part of the base name.

'--count'
'-c'
     Instead of printing the matched file names, just print the total
     number of matches found, unless '--print' ('-p') is also present.

'--database=PATH'
'-d PATH'
     'locate' searches the file name databases in PATH, which is a
     colon-separated list of database file names.  You can also use the
     environment variable 'LOCATE_PATH' to set the list of database
     files to search.  The option overrides the environment variable if
     both are used.  Empty elements in PATH (that is, a leading or
     trailing colon, or two colons in a row) are taken to stand for the
     default database.  A database can be supplied on stdin, using '-'
     as an element of 'path'.  If more than one element of 'path' is
     '-', later instances are ignored (but a warning message is
     printed).

'--existing'
'-e'
     Only print out such names which currently exist (instead of such
     names which existed when the database was created).  Note that this
     may slow down the program a lot, if there are many matches in the
     database.  The way in which broken symbolic links are treated is
     affected by the '-L', '-P' and '-H' options.  Please note that it
     is possible for the file to be deleted after 'locate' has checked
     that it exists, but before you use it.  This option is
     automatically turned on when reading an 'slocate' database in
     secure mode (*note slocate Database Format::).

'--non-existing'
'-E'
     Only print out such names which currently do not exist (instead of
     such names which existed when the database was created).  Note that
     this may slow down the program a lot, if there are many matches in
     the database.  The way in which broken symbolic links are treated
     is affected by the '-L', '-P' and '-H' options.  Please note that
     'locate' checks that the file does not exist, but a file of the
     same name might be created after 'locate''s check but before you
     read 'locate''s output.

'--follow'
'-L'
     If testing for the existence of files (with the '-e' or '-E'
     options), consider broken symbolic links to be non-existing.  This
     is the default behaviour.

'--nofollow'
'-P'
'-H'
     If testing for the existence of files (with the '-e' or '-E'
     options), treat broken symbolic links as if they were existing
     files.  The '-H' form of this option is provided purely for
     similarity with 'find'; the use of '-P' is recommended over '-H'.

'--ignore-case'
'-i'
     Ignore case distinctions in both the pattern and the file names.

'--limit=N'
'-l N'
     Limit the number of results printed to N. When used with the
     '--count' option, the value printed will never be larger than this
     limit.
'--max-database-age=D'
     Normally, 'locate' will issue a warning message when it searches a
     database which is more than 8 days old.  This option changes that
     value to something other than 8.  The effect of specifying a
     negative value is undefined.
'--mmap'
'-m'
     Accepted but does nothing.  The option is supported only to provide
     compatibility with BSD's 'locate'.

'--null'
'-0'
     Results are separated with the ASCII NUL character rather than the
     newline character.  To get the full benefit of this option, use the
     new 'locate' database format (that is the default anyway).

'--print'
'-p'
     Print search results when they normally would not be due to use of
     '--statistics' ('-S') or '--count' ('-c').

'--wholename'
'-w'
     The specified pattern is matched against the whole name of the file
     in the 'locate' database.  If the pattern contains metacharacters,
     it must match exactly.  If not, it must match part of the whole
     file name.  This is the default behaviour.

'--regex'
'-r'
     Instead of using substring or shell glob matching, the pattern
     specified on the command line is understood to be a regular
     expression.  GNU Emacs-style regular expressions are assumed unless
     the '--regextype' option is also given.  File names from the
     'locate' database are matched using the specified regular
     expression.  If the '-i' flag is also given, matching is
     case-insensitive.  Matches are performed against the whole path
     name, and so by default a pathname will be matched if any part of
     it matches the specified regular expression.  The regular
     expression may use '^' or '$' to anchor a match at the beginning or
     end of a pathname.

'--regextype'
     This option changes the regular expression syntax and behaviour
     used by the '--regex' option.  *note Regular Expressions:: for more
     information on the regular expression dialects understood by GNU
     findutils.

'--stdio'
'-s'
     Accepted but does nothing.  The option is supported only to provide
     compatibility with BSD's 'locate'.

'--statistics'
'-S'
     Print some summary information for each 'locate' database.  No
     search is performed unless non-option arguments are given.
     Although the BSD version of locate also has this option, the format
     of the output is different.

'--help'
     Print a summary of the command line usage for 'locate' and exit.

'--version'
     Print the version number of 'locate' and exit.

