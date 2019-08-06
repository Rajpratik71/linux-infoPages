File: coreutils.info,  Node: realpath invocation,  Prev: mktemp invocation,  Up: File name manipulation

18.5 ‘realpath’: Print the resolved file name.
==============================================

‘realpath’ expands all symbolic links and resolves references to ‘/./’,
‘/../’ and extra ‘/’ characters.  By default, all but the last component
of the specified files must exist.  Synopsis:

     realpath [OPTION]... FILE...

   The file name canonicalization functionality overlaps with that of
the ‘readlink’ command.  This is the preferred command for
canonicalization as it’s a more suitable and standard name.  In addition
this command supports relative file name processing functionality.

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

‘--relative-to=DIR’
     Print the resolved file names relative to the specified directory.
     Note this option honors the ‘-m’ and ‘-e’ options pertaining to
     file existence.

‘--relative-base=DIR’
     Print the resolved file names as relative _if_ the files are
     descendants of DIR.  Otherwise, print the resolved file names as
     absolute.  Note this option honors the ‘-m’ and ‘-e’ options
     pertaining to file existence.  For details about combining
     ‘--relative-to’ and ‘--relative-base’, *note Realpath usage
     examples::.

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

* Menu:

* Realpath usage examples::

File: coreutils.info,  Node: Realpath usage examples,  Up: realpath invocation

18.5.1 Realpath usage examples
------------------------------

By default, ‘realpath’ prints the absolute file name of given files
(symlinks are resolved, ‘words’ is resolved to ‘american-english’):

     cd /home/user
     realpath /usr/bin/sort /tmp/foo /usr/share/dict/words 1.txt
     ⇒ /usr/bin/sort
     ⇒ /tmp/foo
     ⇒ /usr/share/dict/american-english
     ⇒ /home/user/1.txt

   With ‘--relative-to’, file names are printed relative to the given
directory:

     realpath --relative-to=/usr/bin \
              /usr/bin/sort /tmp/foo /usr/share/dict/words 1.txt
     ⇒ sort
     ⇒ ../../tmp/foo
     ⇒ ../share/dict/american-english
     ⇒ ../../home/user/1.txt

   With ‘--relative-base’, relative file names are printed _if_ the
resolved file name is below the given base directory.  For files outside
the base directory absolute file names are printed:

     realpath --relative-base=/usr \
              /usr/bin/sort /tmp/foo /usr/share/dict/words 1.txt
     ⇒ bin/sort
     ⇒ /tmp/foo
     ⇒ share/dict/american-english
     ⇒ /home/user/1.txt

   When both ‘--relative-to=DIR1’ and ‘--relative-base=DIR2’ are used,
file names are printed relative to DIR1 _if_ they are located below
DIR2.  If the files are not below DIR2, they are printed as absolute
file names:

     realpath --relative-to=/usr/bin --relative-base=/usr \
              /usr/bin/sort /tmp/foo /usr/share/dict/words 1.txt
     ⇒ sort
     ⇒ /tmp/foo
     ⇒ ../share/dict/american-english
     ⇒ /home/user/1.txt

   When both ‘--relative-to=DIR1’ and ‘--relative-base=DIR2’ are used,
DIR1 _must_ be a subdirectory of DIR2.  Otherwise, ‘realpath’ prints
absolutes file names.

