Next: Adjusting Files,  Prev: Prerequisites,  Up: Maintainers

13.3 Invoking the ‘gettextize’ Program
======================================

   The ‘gettextize’ program is an interactive tool that helps the
maintainer of a package internationalized through GNU ‘gettext’.  It is
used for two purposes:

   • As a wizard, when a package is modified to use GNU ‘gettext’ for
     the first time.

   • As a migration tool, for upgrading the GNU ‘gettext’ support in a
     package from a previous to a newer version of GNU ‘gettext’.

   This program performs the following tasks:

   • It copies into the package some files that are consistently and
     identically needed in every package internationalized through GNU
     ‘gettext’.

   • It performs as many of the tasks mentioned in the next section
     *note Adjusting Files:: as can be performed automatically.

   • It removes obsolete files and idioms used for previous GNU
     ‘gettext’ versions to the form recommended for the current GNU
     ‘gettext’ version.

   • It prints a summary of the tasks that ought to be done manually and
     could not be done automatically by ‘gettextize’.

   It can be invoked as follows:

     gettextize [ OPTION… ] [ DIRECTORY ]

and accepts the following options:

‘-f’
‘--force’
     Force replacement of files which already exist.

‘--intl’
     Install the libintl sources in a subdirectory named ‘intl/’.  This
     libintl will be used to provide internationalization on systems
     that don’t have GNU libintl installed.  If this option is omitted,
     the call to ‘AM_GNU_GETTEXT’ in ‘configure.ac’ should read:
     ‘AM_GNU_GETTEXT([external])’, and internationalization will not be
     enabled on systems lacking GNU gettext.

‘--po-dir=DIR’
     Specify a directory containing PO files.  Such a directory contains
     the translations into various languages of a particular POT file.
     This option can be specified multiple times, once for each
     translation domain.  If it is not specified, the directory named
     ‘po/’ is updated.

‘--no-changelog’
     Don’t update or create ChangeLog files.  By default, ‘gettextize’
     logs all changes (file additions, modifications and removals) in a
     file called ‘ChangeLog’ in each affected directory.

‘--symlink’
     Make symbolic links instead of copying the needed files.  This can
     be useful to save a few kilobytes of disk space, but it requires
     extra effort to create self-contained tarballs, it may disturb some
     mechanism the maintainer applies to the sources, and it is likely
     to introduce bugs when a newer version of ‘gettext’ is installed on
     the system.

‘-n’
‘--dry-run’
     Print modifications but don’t perform them.  All actions that
     ‘gettextize’ would normally execute are inhibited and instead only
     listed on standard output.

‘--help’
     Display this help and exit.

‘--version’
     Output version information and exit.

   If DIRECTORY is given, this is the top level directory of a package
to prepare for using GNU ‘gettext’.  If not given, it is assumed that
the current directory is the top level directory of such a package.

   The program ‘gettextize’ provides the following files.  However, no
existing file will be replaced unless the option ‘--force’ (‘-f’) is
specified.

  1. The ‘ABOUT-NLS’ file is copied in the main directory of your
     package, the one being at the top level.  This file gives the main
     indications about how to install and use the Native Language
     Support features of your program.  You might elect to use a more
     recent copy of this ‘ABOUT-NLS’ file than the one provided through
     ‘gettextize’, if you have one handy.  You may also fetch a more
     recent copy of file ‘ABOUT-NLS’ from Translation Project sites, and
     from most GNU archive sites.

  2. A ‘po/’ directory is created for eventually holding all translation
     files, but initially only containing the file ‘po/Makefile.in.in’
     from the GNU ‘gettext’ distribution (beware the double ‘.in’ in the
     file name) and a few auxiliary files.  If the ‘po/’ directory
     already exists, it will be preserved along with the files it
     contains, and only ‘Makefile.in.in’ and the auxiliary files will be
     overwritten.

     If ‘--po-dir’ has been specified, this holds for every directory
     specified through ‘--po-dir’, instead of ‘po/’.

  3. Only if ‘--intl’ has been specified: A ‘intl/’ directory is created
     and filled with most of the files originally in the ‘intl/’
     directory of the GNU ‘gettext’ distribution.  Also, if option
     ‘--force’ (‘-f’) is given, the ‘intl/’ directory is emptied first.

  4. The file ‘config.rpath’ is copied into the directory containing
     configuration support files.  It is needed by the ‘AM_GNU_GETTEXT’
     autoconf macro.

  5. Only if the project is using GNU ‘automake’: A set of ‘autoconf’
     macro files is copied into the package’s ‘autoconf’ macro
     repository, usually in a directory called ‘m4/’.

   If your site support symbolic links, ‘gettextize’ will not actually
copy the files into your package, but establish symbolic links instead.
This avoids duplicating the disk space needed in all packages.  Merely
using the ‘-h’ option while creating the ‘tar’ archive of your
distribution will resolve each link by an actual copy in the
distribution archive.  So, to insist, you really should use ‘-h’ option
with ‘tar’ within your ‘dist’ goal of your main ‘Makefile.in’.

   Furthermore, ‘gettextize’ will update all ‘Makefile.am’ files in each
affected directory, as well as the top level ‘configure.ac’ or
‘configure.in’ file.

   It is interesting to understand that most new files for supporting
GNU ‘gettext’ facilities in one package go in ‘intl/’, ‘po/’ and ‘m4/’
subdirectories.  One distinction between ‘intl/’ and the two other
directories is that ‘intl/’ is meant to be completely identical in all
packages using GNU ‘gettext’, while the other directories will mostly
contain package dependent files.

   The ‘gettextize’ program makes backup files for all files it replaces
or changes, and also write ChangeLog entries about these changes.  This
way, the careful maintainer can check after running ‘gettextize’ whether
its changes are acceptable to him, and possibly adjust them.  An
exception to this rule is the ‘intl/’ directory, which is added or
replaced or removed as a whole.

   It is important to understand that ‘gettextize’ can not do the entire
job of adapting a package for using GNU ‘gettext’.  The amount of
remaining work depends on whether the package uses GNU ‘automake’ or
not.  But in any case, the maintainer should still read the section
*note Adjusting Files:: after invoking ‘gettextize’.

   In particular, if after using ‘gettexize’, you get an error
‘AC_COMPILE_IFELSE was called before AC_GNU_SOURCE’ or ‘AC_RUN_IFELSE
was called before AC_GNU_SOURCE’, you can fix it by modifying
‘configure.ac’, as described in *note configure.ac::.

   It is also important to understand that ‘gettextize’ is not part of
the GNU build system, in the sense that it should not be invoked
automatically, and not be invoked by someone who doesn’t assume the
responsibilities of a package maintainer.  For the latter purpose, a
separate tool is provided, see *note autopoint Invocation::.

