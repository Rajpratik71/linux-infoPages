File: texinfo,  Node: Invoking install-info,  Prev: Installing Dir Entries,  Up: Installing an Info File

23.2.5 Invoking 'install-info'
------------------------------

'install-info' inserts menu entries from an Info file into the top-level
'dir' file in the Info system (see the previous sections for an
explanation of how the 'dir' file works).  'install-info' also removes
menu entries from the 'dir' file.  It's most often run as part of
software installation, or when constructing a 'dir' file for all manuals
on a system.  Synopsis:

     install-info [OPTION]... [INFO-FILE [DIR-FILE]]

  If INFO-FILE or DIR-FILE are not specified, the options (described
below) that define them must be.  There are no compile-time defaults,
and standard input is never used.  'install-info' can read only one Info
file and write only one 'dir' file per invocation.

  If DIR-FILE (however specified) does not exist, 'install-info' creates
it if possible (with no entries).

  If any input file is compressed with 'gzip' (*note (gzip)Top::),
'install-info' automatically uncompresses it for reading.  And if
DIR-FILE is compressed, 'install-info' also automatically leaves it
compressed after writing any changes.  If DIR-FILE itself does not
exist, 'install-info' tries to open 'DIR-FILE.gz', 'DIR-FILE.xz',
'DIR-FILE.bz2', 'DIR-FILE.lz', and 'DIR-FILE.lzma', in that order.

  Options:

'--add-once'
     Specifies that the entry or entries will only be put into a single
     section.

'--align=COLUMN'
     Specifies the column that the second and subsequent lines of menu
     entry's description will be formatted to begin at.  The default for
     this option is '35'.  It is used in conjunction with the
     '--max-width' option.  COLUMN starts counting at 1.

'--append-new-sections'
     Instead of alphabetizing new sections, place them at the end of the
     DIR file.

'--calign=COLUMN'
     Specifies the column that the first line of menu entry's
     description will be formatted to begin at.  The default for this
     option is '33'.  It is used in conjunction with the '--max-width'
     option.  When the name of the menu entry exceeds this column,
     entry's description will start on the following line.  COLUMN
     starts counting at 1.

'--debug'
     Report what is being done.

'--delete'
     Delete the entries in INFO-FILE from DIR-FILE.  The file name in
     the entry in DIR-FILE must be INFO-FILE (except for an optional
     '.info' in either one).  Don't insert any new entries.  Any empty
     sections that result from the removal are also removed.

'--description=TEXT'
     Specify the explanatory portion of the menu entry.  If you don't
     specify a description (either via '--entry', '--item' or this
     option), the description is taken from the Info file itself.

'--dir-file=NAME'
     Specify file name of the Info directory file.  This is equivalent
     to using the DIR-FILE argument.

'--dry-run'
     Same as '--test'.

'--entry=TEXT'
     Insert TEXT as an Info directory entry; TEXT should have the form
     of an Info menu item line plus zero or more extra lines starting
     with whitespace.  If you specify more than one entry, they are all
     added.  If you don't specify any entries, they are determined from
     information in the Info file itself.

'--help'
     Display a usage message with basic usage and all available options,
     then exit successfully.

'--info-file=FILE'
     Specify Info file to install in the directory.  This is equivalent
     to using the INFO-FILE argument.

'--info-dir=DIR'
     Specify the directory where the directory file 'dir' resides.
     Equivalent to '--dir-file=DIR/dir'.

'--infodir=DIR'
     Same as '--info-dir'.

'--item=TEXT'
     Same as '--entry=TEXT'.  An Info directory entry is actually a menu
     item.

'--keep-old'
     Do not replace pre-existing menu entries.  When '--remove' is
     specified, this option means that empty sections are not removed.

'--max-width=COLUMN'
     Specifies the column that the menu entry's description will be
     word-wrapped at.  COLUMN starts counting at 1.

'--maxwidth=COLUMN'
     Same as '--max-width'.

'--menuentry=TEXT'
     Same as '--name'.

'--name=TEXT'
     Specify the name portion of the menu entry.  If the TEXT does not
     start with an asterisk '*', it is presumed to be the text after the
     '*' and before the parentheses that specify the Info file.
     Otherwise TEXT is taken verbatim, and is taken as defining the text
     up to and including the first period (a space is appended if
     necessary).  If you don't specify the name (either via '--entry',
     '--item' or this option), it is taken from the Info file itself.
     If the Info does not contain the name, the basename of the Info
     file is used.

'--no-indent'
     Suppress formatting of new entries into the 'dir' file.

'--quiet'
'--silent'
     Suppress warnings, etc., for silent operation.

'--remove'
     Same as '--delete'.

'--remove-exactly'
     Also like '--delete', but only entries if the Info file name
     matches exactly; '.info' and/or '.gz' suffixes are _not_ ignored.

'--section=SEC'
     Put this file's entries in section SEC of the directory.  If you
     specify more than one section, all the entries are added in each of
     the sections.  If you don't specify any sections, they are
     determined from information in the Info file itself.  If the Info
     file doesn't specify a section, the menu entries are put into the
     Miscellaneous section.

'--section REGEX SEC'
     Same as '--regex=REGEX --section=SEC --add-once'.

     'install-info' tries to detect when this alternate syntax is used,
     but does not always guess correctly.  Here is the heuristic that
     'install-info' uses:
       1. If the second argument to '--section' starts with a hyphen,
          the original syntax is presumed.

       2. If the second argument to '--section' is a file that can be
          opened, the original syntax is presumed.

       3. Otherwise the alternate syntax is used.

     When the heuristic fails because your section title starts with a
     hyphen, or it happens to be a filename that can be opened, the
     syntax should be changed to '--regex=REGEX --section=SEC
     --add-once'.

'--regex=REGEX'
     Put this file's entries into any section that matches REGEX.  If
     more than one section matches, all of the entries are added in each
     of the sections.  Specify REGEX using basic regular expression
     syntax, more or less as used with 'grep', for example.

'--test'
     Suppress updating of the directory file.

'--version'
     Display version information and exit successfully.

