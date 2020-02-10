Prev: mktemp invocation,  Up: File name manipulation

18.5 ‘realpath’: Print the resolved file name.
==============================================

‘realpath’ expands all symbolic links and resolves references to ‘/./’,
‘/../’ and extra ‘/’ characters.  By default, all but the last component
of the specified files must exist.  Synopsis:

     realpath [OPTION]... FILE...

   The program accepts the following options.  Also see *note Common
options::.

‘-e’
‘--canonicalize-existing’
     Ensure that all components of the specified file names exist.  If
     any component is missing or unavailable, ‘realpath’ will output a
     diagnostic unless the ‘-q’ option is specified, and exit with a
     nonzero exit code.  A trailing slash requires that the name resolve
     to a directory.

‘-m’
‘--canonicalize-missing’
     If any component of a specified file name is missing or
     unavailable, treat it as a directory.

‘-L’
‘--logical’
     Symbolic links are resolved in the specified file names, but they
     are resolved after any subsequent ‘..’ components are processed.

‘-P’
‘--physical’
     Symbolic links are resolved in the specified file names, and they
     are resolved before any subsequent ‘..’ components are processed.
     This is the default mode of operation.

‘-q’
‘--quiet’
     Suppress diagnostic messages for specified file names.

‘--relative-to=FILE’
     Print the resolved file names relative to the specified file.  Note
     this option honors the ‘-m’ and ‘-e’ options pertaining to file
     existence.

‘--relative-base=BASE’
     This option is valid when used with ‘--relative-to’, and will
     restrict the output of ‘--relative-to’ so that relative names are
     output, only when FILEs are descendants of BASE.  Otherwise output
     the absolute file name.  If ‘--relative-to’ was not specified, then
     the descendants of BASE are printed relative to BASE.  If
     ‘--relative-to’ is specified, then that directory must be a
     descendant of BASE for this option to have an effect.  Note: this
     option honors the ‘-m’ and ‘-e’ options pertaining to file
     existence.  For example:

          realpath --relative-to=/usr /tmp /usr/bin
          ⇒ ../tmp
          ⇒ bin
          realpath --relative-base=/usr /tmp /usr/bin
          ⇒ /tmp
          ⇒ bin

‘-s’
‘--strip’
‘--no-symlinks’
     Do not resolve symbolic links.  Only resolve references to ‘/./’,
     ‘/../’ and remove extra ‘/’ characters.  When combined with the
     ‘-m’ option, realpath operates only on the file name, and does not
     touch any actual file.

‘-z’
‘--zero’
     Output a zero byte (ASCII NUL) at the end of each line, rather than
     a newline.  This option enables other programs to parse the output
     even when that output would contain data with embedded newlines.

   Exit status:

     0 if all file names were printed without issue.
     1 otherwise.

