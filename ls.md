File: coreutils.info,  Node: ls invocation,  Next: dir invocation,  Up: Directory listing

10.1 ‘ls’: List directory contents
==================================

The ‘ls’ program lists information about files (of any type, including
directories).  Options and file arguments can be intermixed arbitrarily,
as usual.

   For non-option command-line arguments that are directories, by
default ‘ls’ lists the contents of directories, not recursively, and
omitting files with names beginning with ‘.’.  For other non-option
arguments, by default ‘ls’ lists just the file name.  If no non-option
argument is specified, ‘ls’ operates on the current directory, acting as
if it had been invoked with a single argument of ‘.’.

   By default, the output is sorted alphabetically, according to the
locale settings in effect.(1)  If standard output is a terminal, the
output is in columns (sorted vertically) and control characters are
output as question marks; otherwise, the output is listed one per line
and control characters are output as-is.

   Because ‘ls’ is such a fundamental program, it has accumulated many
options over the years.  They are described in the subsections below;
within each section, options are listed alphabetically (ignoring case).
The division of options into the subsections is not absolute, since some
options affect more than one aspect of ‘ls’’s operation.

   Exit status:

     0 success
     1 minor problems  (e.g., failure to access a file or directory not
       specified as a command line argument.  This happens when listing a
       directory in which entries are actively being removed or renamed.)
     2 serious trouble (e.g., memory exhausted, invalid option, failure
       to access a file or directory specified as a command line argument
       or a directory loop)

   Also see *note Common options::.

* Menu:

* Which files are listed::
* What information is listed::
* Sorting the output::
* Details about version sort::
* General output formatting::
* Formatting file timestamps::
* Formatting the file names::

   ---------- Footnotes ----------

   (1) If you use a non-POSIX locale (e.g., by setting ‘LC_ALL’ to
‘en_US’), then ‘ls’ may produce output that is sorted differently than
you’re accustomed to.  In that case, set the ‘LC_ALL’ environment
variable to ‘C’.

File: coreutils.info,  Node: Which files are listed,  Next: What information is listed,  Up: ls invocation

10.1.1 Which files are listed
-----------------------------

These options determine which files ‘ls’ lists information for.  By
default, ‘ls’ lists files and the contents of any directories on the
command line, except that in directories it ignores files whose names
start with ‘.’.

‘-a’
‘--all’
     In directories, do not ignore file names that start with ‘.’.

‘-A’
‘--almost-all’
     In directories, do not ignore all file names that start with ‘.’;
     ignore only ‘.’ and ‘..’.  The ‘--all’ (‘-a’) option overrides this
     option.

‘-B’
‘--ignore-backups’
     In directories, ignore files that end with ‘~’.  This option is
     equivalent to ‘--ignore='*~' --ignore='.*~'’.

‘-d’
‘--directory’
     List just the names of directories, as with other types of files,
     rather than listing their contents.  Do not follow symbolic links
     listed on the command line unless the ‘--dereference-command-line’
     (‘-H’), ‘--dereference’ (‘-L’), or
     ‘--dereference-command-line-symlink-to-dir’ options are specified.

‘-H’
‘--dereference-command-line’
     If a command line argument specifies a symbolic link, show
     information for the file the link references rather than for the
     link itself.

‘--dereference-command-line-symlink-to-dir’
     Do not dereference symbolic links, with one exception: if a command
     line argument specifies a symbolic link that refers to a directory,
     show information for that directory rather than for the link
     itself.  This is the default behavior when no other
     dereferencing-related option has been specified (‘--classify’
     (‘-F’), ‘--directory’ (‘-d’), (‘-l’), ‘--dereference’ (‘-L’), or
     ‘--dereference-command-line’ (‘-H’)).

‘--group-directories-first’
     Group all the directories before the files and then sort the
     directories and the files separately using the selected sort key
     (see –sort option).  That is, this option specifies a primary sort
     key, and the –sort option specifies a secondary key.  However, any
     use of ‘--sort=none’ (‘-U’) disables this option altogether.

‘--hide=PATTERN’
     In directories, ignore files whose names match the shell pattern
     PATTERN, unless the ‘--all’ (‘-a’) or ‘--almost-all’ (‘-A’) is also
     given.  This option acts like ‘--ignore=PATTERN’ except that it has
     no effect if ‘--all’ (‘-a’) or ‘--almost-all’ (‘-A’) is also given.

     This option can be useful in shell aliases.  For example, if ‘lx’
     is an alias for ‘ls --hide='*~'’ and ‘ly’ is an alias for ‘ls
     --ignore='*~'’, then the command ‘lx -A’ lists the file ‘README~’
     even though ‘ly -A’ would not.

‘-I PATTERN’
‘--ignore=PATTERN’
     In directories, ignore files whose names match the shell pattern
     (not regular expression) PATTERN.  As in the shell, an initial ‘.’
     in a file name does not match a wildcard at the start of PATTERN.
     Sometimes it is useful to give this option several times.  For
     example,

          $ ls --ignore='.??*' --ignore='.[^.]' --ignore='#*'

     The first option ignores names of length 3 or more that start with
     ‘.’, the second ignores all two-character names that start with ‘.’
     except ‘..’, and the third ignores names that start with ‘#’.

‘-L’
‘--dereference’
     When showing file information for a symbolic link, show information
     for the file the link references rather than the link itself.
     However, even with this option, ‘ls’ still prints the name of the
     link itself, not the name of the file that the link points to.

‘-R’
‘--recursive’
     List the contents of all directories recursively.

File: coreutils.info,  Node: What information is listed,  Next: Sorting the output,  Prev: Which files are listed,  Up: ls invocation

10.1.2 What information is listed
---------------------------------

These options affect the information that ‘ls’ displays.  By default,
only file names are shown.

‘--author’
     List each file’s author when producing long format directory
     listings.  In GNU/Hurd, file authors can differ from their owners,
     but in other operating systems the two are the same.

‘-D’
‘--dired’
     With the long listing (‘-l’) format, print an additional line after
     the main output:

          //DIRED// BEG1 END1 BEG2 END2 ...

     The BEGN and ENDN are unsigned integers that record the byte
     position of the beginning and end of each file name in the output.
     This makes it easy for Emacs to find the names, even when they
     contain unusual characters such as space or newline, without fancy
     searching.

     If directories are being listed recursively (‘-R’), output a
     similar line with offsets for each subdirectory name:

          //SUBDIRED// BEG1 END1 ...

     Finally, output a line of the form:

          //DIRED-OPTIONS// --quoting-style=WORD

     where WORD is the quoting style (*note Formatting the file
     names::).

     Here is an actual example:

          $ mkdir -p a/sub/deeper a/sub2
          $ touch a/f1 a/f2
          $ touch a/sub/deeper/file
          $ ls -gloRF --dired a
            a:
            total 8
            -rw-r--r-- 1    0 Jun 10 12:27 f1
            -rw-r--r-- 1    0 Jun 10 12:27 f2
            drwxr-xr-x 3 4096 Jun 10 12:27 sub/
            drwxr-xr-x 2 4096 Jun 10 12:27 sub2/

            a/sub:
            total 4
            drwxr-xr-x 2 4096 Jun 10 12:27 deeper/

            a/sub/deeper:
            total 0
            -rw-r--r-- 1 0 Jun 10 12:27 file

            a/sub2:
            total 0
          //DIRED// 48 50 84 86 120 123 158 162 217 223 282 286
          //SUBDIRED// 2 3 167 172 228 240 290 296
          //DIRED-OPTIONS// --quoting-style=literal

     Note that the pairs of offsets on the ‘//DIRED//’ line above
     delimit these names: ‘f1’, ‘f2’, ‘sub’, ‘sub2’, ‘deeper’, ‘file’.
     The offsets on the ‘//SUBDIRED//’ line delimit the following
     directory names: ‘a’, ‘a/sub’, ‘a/sub/deeper’, ‘a/sub2’.

     Here is an example of how to extract the fifth entry name,
     ‘deeper’, corresponding to the pair of offsets, 222 and 228:

          $ ls -gloRF --dired a > out
          $ dd bs=1 skip=222 count=6 < out 2>/dev/null; echo
          deeper

     Note that although the listing above includes a trailing slash for
     the ‘deeper’ entry, the offsets select the name without the
     trailing slash.  However, if you invoke ‘ls’ with ‘--dired’ along
     with an option like ‘--escape’ (aka ‘-b’) and operate on a file
     whose name contains special characters, notice that the backslash
     _is_ included:

          $ touch 'a b'
          $ ls -blog --dired 'a b'
            -rw-r--r-- 1 0 Jun 10 12:28 a\ b
          //DIRED// 30 34
          //DIRED-OPTIONS// --quoting-style=escape

     If you use a quoting style that adds quote marks (e.g.,
     ‘--quoting-style=c’), then the offsets include the quote marks.  So
     beware that the user may select the quoting style via the
     environment variable ‘QUOTING_STYLE’.  Hence, applications using
     ‘--dired’ should either specify an explicit
     ‘--quoting-style=literal’ option (aka ‘-N’ or ‘--literal’) on the
     command line, or else be prepared to parse the escaped names.

‘--full-time’
     Produce long format directory listings, and list times in full.  It
     is equivalent to using ‘--format=long’ with ‘--time-style=full-iso’
     (*note Formatting file timestamps::).

‘-g’
     Produce long format directory listings, but don’t display owner
     information.

‘-G’
‘--no-group’
     Inhibit display of group information in a long format directory
     listing.  (This is the default in some non-GNU versions of ‘ls’, so
     we provide this option for compatibility.)

‘-h’
‘--human-readable’
     Append a size letter to each size, such as ‘M’ for mebibytes.
     Powers of 1024 are used, not 1000; ‘M’ stands for 1,048,576 bytes.
     This option is equivalent to ‘--block-size=human-readable’.  Use
     the ‘--si’ option if you prefer powers of 1000.

‘-i’
‘--inode’
     Print the inode number (also called the file serial number and
     index number) of each file to the left of the file name.  (This
     number uniquely identifies each file within a particular file
     system.)

‘-l’
‘--format=long’
‘--format=verbose’
     In addition to the name of each file, print the file type, file
     mode bits, number of hard links, owner name, group name, size, and
     timestamp (*note Formatting file timestamps::), normally the
     modification timestamp (the mtime, *note File timestamps::).  Print
     question marks for information that cannot be determined.

     Normally the size is printed as a byte count without punctuation,
     but this can be overridden (*note Block size::).  For example, ‘-h’
     prints an abbreviated, human-readable count, and
     ‘--block-size="'1"’ prints a byte count with the thousands
     separator of the current locale.

     For each directory that is listed, preface the files with a line
     ‘total BLOCKS’, where BLOCKS is the total disk allocation for all
     files in that directory.  The block size currently defaults to 1024
     bytes, but this can be overridden (*note Block size::).  The BLOCKS
     computed counts each hard link separately; this is arguably a
     deficiency.

     The file type is one of the following characters:

     ‘-’
          regular file
     ‘b’
          block special file
     ‘c’
          character special file
     ‘C’
          high performance (“contiguous data”) file
     ‘d’
          directory
     ‘D’
          door (Solaris 2.5 and up)
     ‘l’
          symbolic link
     ‘M’
          off-line (“migrated”) file (Cray DMF)
     ‘n’
          network special file (HP-UX)
     ‘p’
          FIFO (named pipe)
     ‘P’
          port (Solaris 10 and up)
     ‘s’
          socket
     ‘?’
          some other file type

     The file mode bits listed are similar to symbolic mode
     specifications (*note Symbolic Modes::).  But ‘ls’ combines
     multiple bits into the third character of each set of permissions
     as follows:

     ‘s’
          If the set-user-ID or set-group-ID bit and the corresponding
          executable bit are both set.

     ‘S’
          If the set-user-ID or set-group-ID bit is set but the
          corresponding executable bit is not set.

     ‘t’
          If the restricted deletion flag or sticky bit, and the
          other-executable bit, are both set.  The restricted deletion
          flag is another name for the sticky bit.  *Note Mode
          Structure::.

     ‘T’
          If the restricted deletion flag or sticky bit is set but the
          other-executable bit is not set.

     ‘x’
          If the executable bit is set and none of the above apply.

     ‘-’
          Otherwise.

     Following the file mode bits is a single character that specifies
     whether an alternate access method such as an access control list
     applies to the file.  When the character following the file mode
     bits is a space, there is no alternate access method.  When it is a
     printing character, then there is such a method.

     GNU ‘ls’ uses a ‘.’ character to indicate a file with a security
     context, but no other alternate access method.

     A file with any other combination of alternate access methods is
     marked with a ‘+’ character.

‘-n’
‘--numeric-uid-gid’
     Produce long format directory listings, but display numeric user
     and group IDs instead of the owner and group names.

‘-o’
     Produce long format directory listings, but don’t display group
     information.  It is equivalent to using ‘--format=long’ with
     ‘--no-group’ .

‘-s’
‘--size’
     Print the disk allocation of each file to the left of the file
     name.  This is the amount of disk space used by the file, which is
     usually a bit more than the file’s size, but it can be less if the
     file has holes.

     Normally the disk allocation is printed in units of 1024 bytes, but
     this can be overridden (*note Block size::).

     For files that are NFS-mounted from an HP-UX system to a BSD
     system, this option reports sizes that are half the correct values.
     On HP-UX systems, it reports sizes that are twice the correct
     values for files that are NFS-mounted from BSD systems.  This is
     due to a flaw in HP-UX; it also affects the HP-UX ‘ls’ program.

‘--si’
     Append an SI-style abbreviation to each size, such as ‘M’ for
     megabytes.  Powers of 1000 are used, not 1024; ‘M’ stands for
     1,000,000 bytes.  This option is equivalent to ‘--block-size=si’.
     Use the ‘-h’ or ‘--human-readable’ option if you prefer powers of
     1024.

‘-Z’
‘--context’
     Display the SELinux security context or ‘?’ if none is found.  When
     used with the ‘-l’ option, print the security context to the left
     of the size column.

File: coreutils.info,  Node: Sorting the output,  Next: Details about version sort,  Prev: What information is listed,  Up: ls invocation

10.1.3 Sorting the output
-------------------------

These options change the order in which ‘ls’ sorts the information it
outputs.  By default, sorting is done by character code (e.g., ASCII
order).

‘-c’
‘--time=ctime’
‘--time=status’
     If the long listing format (e.g., ‘-l’, ‘-o’) is being used, print
     the status change timestamp (the ctime) instead of the mtime.  When
     explicitly sorting by time (‘--sort=time’ or ‘-t’) or when not
     using a long listing format, sort according to the ctime.  *Note
     File timestamps::.

‘-f’
     Primarily, like ‘-U’—do not sort; list the files in whatever order
     they are stored in the directory.  But also enable ‘-a’ (list all
     files) and disable ‘-l’, ‘--color’, and ‘-s’ (if they were
     specified before the ‘-f’).

‘-r’
‘--reverse’
     Reverse whatever the sorting method is—e.g., list files in reverse
     alphabetical order, youngest first, smallest first, or whatever.

‘-S’
‘--sort=size’
     Sort by file size, largest first.

‘-t’
‘--sort=time’
     Sort by modification timestamp (mtime), newest first.  *Note File
     timestamps::.

‘-u’
‘--time=atime’
‘--time=access’
‘--time=use’
     If the long listing format (e.g., ‘--format=long’) is being used,
     print the last access timestamp (the atime).  When explicitly
     sorting by time (‘--sort=time’ or ‘-t’) or when not using a long
     listing format, sort according to the atime.  *Note File
     timestamps::.

‘-U’
‘--sort=none’
     Do not sort; list the files in whatever order they are stored in
     the directory.  (Do not do any of the other unrelated things that
     ‘-f’ does.)  This is especially useful when listing very large
     directories, since not doing any sorting can be noticeably faster.

‘-v’
‘--sort=version’
     Sort by version name and number, lowest first.  It behaves like a
     default sort, except that each sequence of decimal digits is
     treated numerically as an index/version number.  (*Note Details
     about version sort::.)

‘-X’
‘--sort=extension’
     Sort directory contents alphabetically by file extension
     (characters after the last ‘.’); files with no extension are sorted
     first.

File: coreutils.info,  Node: Details about version sort,  Next: General output formatting,  Prev: Sorting the output,  Up: ls invocation

10.1.4 Details about version sort
---------------------------------

Version sorting handles the fact that file names frequently include
indices or version numbers.  Standard sorting usually does not produce
the order that one expects because comparisons are made on a
character-by-character basis.  Version sorting is especially useful when
browsing directories that contain many files with indices/version
numbers in their names:

     $ ls -1            $ ls -1v
     abc.zml-1.gz       abc.zml-1.gz
     abc.zml-12.gz      abc.zml-2.gz
     abc.zml-2.gz       abc.zml-12.gz

   Version-sorted strings are compared such that if VER1 and VER2 are
version numbers and PREFIX and SUFFIX (SUFFIX matching the regular
expression ‘(\.[A-Za-z~][A-Za-z0-9~]*)*’) are strings then VER1 < VER2
implies that the name composed of “PREFIX VER1 SUFFIX” sorts before
“PREFIX VER2 SUFFIX”.

   Note also that leading zeros of numeric parts are ignored:

     $ ls -1            $ ls -1v
     abc-1.007.tgz      abc-1.01a.tgz
     abc-1.012b.tgz     abc-1.007.tgz
     abc-1.01a.tgz      abc-1.012b.tgz

   This functionality is implemented using gnulib’s ‘filevercmp’
function, which has some caveats worth noting.

   • ‘LC_COLLATE’ is ignored, which means ‘ls -v’ and ‘sort -V’ will
     sort non-numeric prefixes as if the ‘LC_COLLATE’ locale category
     was set to ‘C’.
   • Some suffixes will not be matched by the regular expression
     mentioned above.  Consequently these examples may not sort as you
     expect:

          abc-1.2.3.4.7z
          abc-1.2.3.7z

          abc-1.2.3.4.x86_64.rpm
          abc-1.2.3.x86_64.rpm

File: coreutils.info,  Node: General output formatting,  Next: Formatting file timestamps,  Prev: Details about version sort,  Up: ls invocation

10.1.5 General output formatting
--------------------------------

These options affect the appearance of the overall output.

‘-1’
‘--format=single-column’
     List one file per line.  This is the default for ‘ls’ when standard
     output is not a terminal.  See also the ‘-b’ and ‘-q’ options to
     suppress direct output of newline characters within a file name.

‘-C’
‘--format=vertical’
     List files in columns, sorted vertically.  This is the default for
     ‘ls’ if standard output is a terminal.  It is always the default
     for the ‘dir’ program.  GNU ‘ls’ uses variable width columns to
     display as many files as possible in the fewest lines.

‘--color [=WHEN]’
     Specify whether to use color for distinguishing file types.  WHEN
     may be omitted, or one of:
        • none - Do not use color at all.  This is the default.
        • auto - Only use color if standard output is a terminal.
        • always - Always use color.
     Specifying ‘--color’ and no WHEN is equivalent to ‘--color=always’.
     If piping a colorized listing through a pager like ‘less’, use the
     ‘-R’ option to pass the color codes to the terminal.

     Note that using the ‘--color’ option may incur a noticeable
     performance penalty when run in a directory with very many entries,
     because the default settings require that ‘ls’ ‘stat’ every single
     file it lists.  However, if you would like most of the file-type
     coloring but can live without the other coloring options (e.g.,
     executable, orphan, sticky, other-writable, capability), use
     ‘dircolors’ to set the ‘LS_COLORS’ environment variable like this,
          eval $(dircolors -p | perl -pe \
            's/^((CAP|S[ET]|O[TR]|M|E)\w+).*/$1 00/' | dircolors -)
     and on a ‘dirent.d_type’-capable file system, ‘ls’ will perform
     only one ‘stat’ call per command line argument.

‘-F’
‘--classify’
‘--indicator-style=classify’
     Append a character to each file name indicating the file type.
     Also, for regular files that are executable, append ‘*’.  The file
     type indicators are ‘/’ for directories, ‘@’ for symbolic links,
     ‘|’ for FIFOs, ‘=’ for sockets, ‘>’ for doors, and nothing for
     regular files.  Do not follow symbolic links listed on the command
     line unless the ‘--dereference-command-line’ (‘-H’),
     ‘--dereference’ (‘-L’), or
     ‘--dereference-command-line-symlink-to-dir’ options are specified.

‘--file-type’
‘--indicator-style=file-type’
     Append a character to each file name indicating the file type.
     This is like ‘-F’, except that executables are not marked.

‘--hyperlink [=WHEN]’
     Output codes recognized by some terminals to link to files using
     the ‘file://’ URI format.  WHEN may be omitted, or one of:
        • none - Do not use hyperlinks at all.  This is the default.
        • auto - Only use hyperlinks if standard output is a terminal.
        • always - Always use hyperlinks.
     Specifying ‘--hyperlink’ and no WHEN is equivalent to
     ‘--hyperlink=always’.

‘--indicator-style=WORD’
     Append a character indicator with style WORD to entry names, as
     follows:

     ‘none’
          Do not append any character indicator; this is the default.
     ‘slash’
          Append ‘/’ for directories.  This is the same as the ‘-p’
          option.
     ‘file-type’
          Append ‘/’ for directories, ‘@’ for symbolic links, ‘|’ for
          FIFOs, ‘=’ for sockets, and nothing for regular files.  This
          is the same as the ‘--file-type’ option.
     ‘classify’
          Append ‘*’ for executable regular files, otherwise behave as
          for ‘file-type’.  This is the same as the ‘-F’ or ‘--classify’
          option.

‘-k’
‘--kibibytes’
     Set the default block size to its normal value of 1024 bytes,
     overriding any contrary specification in environment variables
     (*note Block size::).  This option is in turn overridden by the
     ‘--block-size’, ‘-h’ or ‘--human-readable’, and ‘--si’ options.

     The ‘-k’ or ‘--kibibytes’ option affects the per-directory block
     count written by the ‘-l’ and similar options, and the size written
     by the ‘-s’ or ‘--size’ option.  It does not affect the file size
     written by ‘-l’.

‘-m’
‘--format=commas’
     List files horizontally, with as many as will fit on each line,
     separated by ‘, ’ (a comma and a space).

‘-p’
‘--indicator-style=slash’
     Append a ‘/’ to directory names.

‘-x’
‘--format=across’
‘--format=horizontal’
     List the files in columns, sorted horizontally.

‘-T COLS’
‘--tabsize=COLS’
     Assume that each tab stop is COLS columns wide.  The default is 8.
     ‘ls’ uses tabs where possible in the output, for efficiency.  If
     COLS is zero, do not use tabs at all.

     Some terminal emulators might not properly align columns to the
     right of a TAB following a non-ASCII byte.  You can avoid that
     issue by using the ‘-T0’ option or put ‘TABSIZE=0’ in your
     environment, to tell ‘ls’ to align using spaces, not tabs.

‘-w COLS’
‘--width=COLS’
     Assume the screen is COLS columns wide.  The default is taken from
     the terminal settings if possible; otherwise the environment
     variable ‘COLUMNS’ is used if it is set; otherwise the default is
     80.  With a COLS value of ‘0’, there is no limit on the length of
     the output line, and that single output line will be delimited with
     spaces, not tabs.

File: coreutils.info,  Node: Formatting file timestamps,  Next: Formatting the file names,  Prev: General output formatting,  Up: ls invocation

10.1.6 Formatting file timestamps
---------------------------------

By default, file timestamps are listed in abbreviated form, using a date
like ‘Mar 30  2002’ for non-recent timestamps, and a date-without-year
and time like ‘Mar 30 23:45’ for recent timestamps.  This format can
change depending on the current locale as detailed below.

   A timestamp is considered to be “recent” if it is less than six
months old, and is not dated in the future.  If a timestamp dated today
is not listed in recent form, the timestamp is in the future, which
means you probably have clock skew problems which may break programs
like ‘make’ that rely on file timestamps.  *Note File timestamps::.

   Timestamps are listed according to the time zone rules specified by
the ‘TZ’ environment variable, or by the system default rules if ‘TZ’ is
not set.  *Note Specifying the Time Zone with ‘TZ’: (libc)TZ Variable.

   The following option changes how file timestamps are printed.

‘--time-style=STYLE’
     List timestamps in style STYLE.  The STYLE should be one of the
     following:

     ‘+FORMAT’
          List timestamps using FORMAT, where FORMAT is interpreted like
          the format argument of ‘date’ (*note date invocation::).  For
          example, ‘--time-style="+%Y-%m-%d %H:%M:%S"’ causes ‘ls’ to
          list timestamps like ‘2002-03-30 23:45:56’.  As with ‘date’,
          FORMAT’s interpretation is affected by the ‘LC_TIME’ locale
          category.

          If FORMAT contains two format strings separated by a newline,
          the former is used for non-recent files and the latter for
          recent files; if you want output columns to line up, you may
          need to insert spaces in one of the two formats.

     ‘full-iso’
          List timestamps in full using ISO 8601-like date, time, and
          time zone components with nanosecond precision, e.g.,
          ‘2002-03-30 23:45:56.477817180 -0700’.  This style is
          equivalent to ‘+%Y-%m-%d %H:%M:%S.%N %z’.

          This is useful because the time output includes all the
          information that is available from the operating system.  For
          example, this can help explain ‘make’’s behavior, since GNU
          ‘make’ uses the full timestamp to determine whether a file is
          out of date.

     ‘long-iso’
          List ISO 8601 date and time components with minute precision,
          e.g., ‘2002-03-30 23:45’.  These timestamps are shorter than
          ‘full-iso’ timestamps, and are usually good enough for
          everyday work.  This style is equivalent to ‘+%Y-%m-%d %H:%M’.

     ‘iso’
          List ISO 8601 dates for non-recent timestamps (e.g.,
          ‘2002-03-30 ’), and ISO 8601-like month, day, hour, and minute
          for recent timestamps (e.g., ‘03-30 23:45’).  These timestamps
          are uglier than ‘long-iso’ timestamps, but they carry nearly
          the same information in a smaller space and their brevity
          helps ‘ls’ output fit within traditional 80-column output
          lines.  The following two ‘ls’ invocations are equivalent:

               newline='
               '
               ls -l --time-style="+%Y-%m-%d $newline%m-%d %H:%M"
               ls -l --time-style="iso"

     ‘locale’
          List timestamps in a locale-dependent form.  For example, a
          Finnish locale might list non-recent timestamps like ‘maalis
          30  2002’ and recent timestamps like ‘maalis 30 23:45’.
          Locale-dependent timestamps typically consume more space than
          ‘iso’ timestamps and are harder for programs to parse because
          locale conventions vary so widely, but they are easier for
          many people to read.

          The ‘LC_TIME’ locale category specifies the timestamp format.
          The default POSIX locale uses timestamps like ‘Mar 30  2002’
          and ‘Mar 30 23:45’; in this locale, the following two ‘ls’
          invocations are equivalent:

               newline='
               '
               ls -l --time-style="+%b %e  %Y$newline%b %e %H:%M"
               ls -l --time-style="locale"

          Other locales behave differently.  For example, in a German
          locale, ‘--time-style="locale"’ might be equivalent to
          ‘--time-style="+%e. %b %Y $newline%e. %b %H:%M"’ and might
          generate timestamps like ‘30. Mär 2002 ’ and ‘30. Mär 23:45’.

     ‘posix-STYLE’
          List POSIX-locale timestamps if the ‘LC_TIME’ locale category
          is POSIX, STYLE timestamps otherwise.  For example, the
          ‘posix-long-iso’ style lists timestamps like ‘Mar 30  2002’
          and ‘Mar 30 23:45’ when in the POSIX locale, and like
          ‘2002-03-30 23:45’ otherwise.

   You can specify the default value of the ‘--time-style’ option with
the environment variable ‘TIME_STYLE’; if ‘TIME_STYLE’ is not set the
default style is ‘locale’.  GNU Emacs 21.3 and later use the ‘--dired’
option and therefore can parse any date format, but if you are using
Emacs 21.1 or 21.2 and specify a non-POSIX locale you may need to set
‘TIME_STYLE="posix-long-iso"’.

   To avoid certain denial-of-service attacks, timestamps that would be
longer than 1000 bytes may be treated as errors.

File: coreutils.info,  Node: Formatting the file names,  Prev: Formatting file timestamps,  Up: ls invocation

10.1.7 Formatting the file names
--------------------------------

These options change how file names themselves are printed.

‘-b’
‘--escape’
‘--quoting-style=escape’
     Quote nongraphic characters in file names using alphabetic and
     octal backslash sequences like those used in C.

‘-N’
‘--literal’
‘--quoting-style=literal’
     Do not quote file names.  However, with ‘ls’ nongraphic characters
     are still printed as question marks if the output is a terminal and
     you do not specify the ‘--show-control-chars’ option.

‘-q’
‘--hide-control-chars’
     Print question marks instead of nongraphic characters in file
     names.  This is the default if the output is a terminal and the
     program is ‘ls’.

‘-Q’
‘--quote-name’
‘--quoting-style=c’
     Enclose file names in double quotes and quote nongraphic characters
     as in C.

‘--quoting-style=WORD’
     Use style WORD to quote file names and other strings that may
     contain arbitrary characters.  The WORD should be one of the
     following:

     ‘literal’
          Output strings as-is; this is the same as the ‘-N’ or
          ‘--literal’ option.
     ‘shell’
          Quote strings for the shell if they contain shell
          metacharacters or would cause ambiguous output.  The quoting
          is suitable for POSIX-compatible shells like ‘bash’, but it
          does not always work for incompatible shells like ‘csh’.
     ‘shell-always’
          Quote strings for the shell, even if they would normally not
          require quoting.
     ‘shell-escape’
          Like ‘shell’, but also quoting non-printable characters using
          the POSIX proposed ‘$''’ syntax suitable for most shells.
     ‘shell-escape-always’
          Like ‘shell-escape’, but quote strings even if they would
          normally not require quoting.
     ‘c’
          Quote strings as for C character string literals, including
          the surrounding double-quote characters; this is the same as
          the ‘-Q’ or ‘--quote-name’ option.
     ‘escape’
          Quote strings as for C character string literals, except omit
          the surrounding double-quote characters; this is the same as
          the ‘-b’ or ‘--escape’ option.
     ‘clocale’
          Quote strings as for C character string literals, except use
          surrounding quotation marks appropriate for the locale.
     ‘locale’
          Quote strings as for C character string literals, except use
          surrounding quotation marks appropriate for the locale, and
          quote 'like this' instead of "like this" in the default C
          locale.  This looks nicer on many displays.

     You can specify the default value of the ‘--quoting-style’ option
     with the environment variable ‘QUOTING_STYLE’.  If that environment
     variable is not set, the default value is ‘shell-escape’ when the
     output is a terminal, and ‘literal’ otherwise.

‘--show-control-chars’
     Print nongraphic characters as-is in file names.  This is the
     default unless the output is a terminal and the program is ‘ls’.

