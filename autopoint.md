Prev: Translations under Version Control,  Up: Version Control Issues

13.6.4 Invoking the ‘autopoint’ Program
---------------------------------------

     autopoint [OPTION]...

   The ‘autopoint’ program copies standard gettext infrastructure files
into a source package.  It extracts from a macro call of the form
‘AM_GNU_GETTEXT_VERSION(VERSION)’, found in the package’s ‘configure.in’
or ‘configure.ac’ file, the gettext version used by the package, and
copies the infrastructure files belonging to this version into the
package.

   To extract the latest available infrastructure which satisfies a
version requirement, then you can use the form
‘AM_GNU_GETTEXT_REQUIRE_VERSION(VERSION)’ instead.  For example, if
gettext 0.19.8 is installed on your system and ‘0.19.1’ is requested,
then the infrastructure files of version 0.19.8 will be copied into a
source package.

13.6.4.1 Options
................

‘-f’
‘--force’
     Force overwriting of files that already exist.

‘-n’
‘--dry-run’
     Print modifications but don’t perform them.  All file copying
     actions that ‘autopoint’ would normally execute are inhibited and
     instead only listed on standard output.

13.6.4.2 Informative output
...........................

‘--help’
     Display this help and exit.

‘--version’
     Output version information and exit.

   ‘autopoint’ supports the GNU ‘gettext’ versions from 0.10.35 to the
current one, 0.19.8.  In order to apply ‘autopoint’ to a package using a
‘gettext’ version newer than 0.19.8, you need to install this same
version of GNU ‘gettext’ at least.

   In packages using GNU ‘automake’, an invocation of ‘autopoint’ should
be followed by invocations of ‘aclocal’ and then ‘autoconf’ and
‘autoheader’.  The reason is that ‘autopoint’ installs some autoconf
macro files, which are used by ‘aclocal’ to create ‘aclocal.m4’, and the
latter is used by ‘autoconf’ to create the package’s ‘configure’ script
and by ‘autoheader’ to create the package’s ‘config.h.in’ include file
template.

   The name ‘autopoint’ is an abbreviation of ‘auto-po-intl-m4’; the
tool copies or updates mostly files in the ‘po’, ‘intl’, ‘m4’
directories.

