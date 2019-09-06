File: automake.info,  Node: aclocal Invocation,  Next: Macros,  Prev: Optional,  Up: configure

6.3 Auto-generating aclocal.m4
==============================

Automake includes a number of Autoconf macros that can be used in your
package (*note Macros::); some of them are actually required by Automake
in certain situations.  These macros must be defined in your
'aclocal.m4'; otherwise they will not be seen by 'autoconf'.

   The 'aclocal' program will automatically generate 'aclocal.m4' files
based on the contents of 'configure.ac'.  This provides a convenient way
to get Automake-provided macros, without having to search around.  The
'aclocal' mechanism allows other packages to supply their own macros
(*note Extending aclocal::).  You can also use it to maintain your own
set of custom macros (*note Local Macros::).

   At startup, 'aclocal' scans all the '.m4' files it can find, looking
for macro definitions (*note Macro Search Path::).  Then it scans
'configure.ac'.  Any mention of one of the macros found in the first
step causes that macro, and any macros it in turn requires, to be put
into 'aclocal.m4'.

   _Putting_ the file that contains the macro definition into
'aclocal.m4' is usually done by copying the entire text of this file,
including unused macro definitions as well as both '#' and 'dnl'
comments.  If you want to make a comment that will be completely ignored
by 'aclocal', use '##' as the comment leader.

   When a file selected by 'aclocal' is located in a subdirectory
specified as a relative search path with 'aclocal''s '-I' argument,
'aclocal' assumes the file belongs to the package and uses 'm4_include'
instead of copying it into 'aclocal.m4'.  This makes the package
smaller, eases dependency tracking, and cause the file to be distributed
automatically.  (*Note Local Macros::, for an example.)  Any macro that
is found in a system-wide directory, or via an absolute search path will
be copied.  So use '-I `pwd`/reldir' instead of '-I reldir' whenever
some relative directory should be considered outside the package.

   The contents of 'acinclude.m4', if this file exists, are also
automatically included in 'aclocal.m4'.  We recommend against using
'acinclude.m4' in new packages (*note Local Macros::).

   While computing 'aclocal.m4', 'aclocal' runs 'autom4te' (*note Using
'Autom4te': (autoconf)Using autom4te.) in order to trace the macros that
are really used, and omit from 'aclocal.m4' all macros that are
mentioned but otherwise unexpanded (this can happen when a macro is
called conditionally).  'autom4te' is expected to be in the 'PATH', just
as 'autoconf'.  Its location can be overridden using the 'AUTOM4TE'
environment variable.

* Menu:

* aclocal Options::             Options supported by aclocal
* Macro Search Path::           How aclocal finds .m4 files
* Extending aclocal::           Writing your own aclocal macros
* Local Macros::                Organizing local macros
* Serials::                     Serial lines in Autoconf macros
* Future of aclocal::           aclocal's scheduled death

File: automake.info,  Node: aclocal Options,  Next: Macro Search Path,  Up: aclocal Invocation

6.3.1 aclocal Options
---------------------

'aclocal' accepts the following options:

'--automake-acdir=DIR'
     Look for the automake-provided macro files in DIR instead of in the
     installation directory.  This is typically used for debugging.

'--system-acdir=DIR'
     Look for the system-wide third-party macro files (and the special
     'dirlist' file) in DIR instead of in the installation directory.
     This is typically used for debugging.

'--diff[=COMMAND]'
     Run COMMAND on M4 file that would be installed or overwritten by
     '--install'.  The default COMMAND is 'diff -u'.  This option
     implies '--install' and '--dry-run'.

'--dry-run'
     Do not actually overwrite (or create) 'aclocal.m4' and M4 files
     installed by '--install'.

'--help'
     Print a summary of the command line options and exit.

'-I DIR'
     Add the directory DIR to the list of directories searched for '.m4'
     files.

'--install'
     Install system-wide third-party macros into the first directory
     specified with '-I DIR' instead of copying them in the output file.
     Note that this will happen also if DIR is an absolute path.

     When this option is used, and only when this option is used,
     'aclocal' will also honor '#serial NUMBER' lines that appear in
     macros: an M4 file is ignored if there exists another M4 file with
     the same basename and a greater serial number in the search path
     (*note Serials::).

'--force'
     Always overwrite the output file.  The default is to overwrite the
     output file only when really needed, i.e., when its contents
     changes or if one of its dependencies is younger.

     This option forces the update of 'aclocal.m4' (or the file
     specified with '--output' below) and only this file, it has
     absolutely no influence on files that may need to be installed by
     '--install'.

'--output=FILE'
     Cause the output to be put into FILE instead of 'aclocal.m4'.

'--print-ac-dir'
     Prints the name of the directory that 'aclocal' will search to find
     third-party '.m4' files.  When this option is given, normal
     processing is suppressed.  This option was used _in the past_ by
     third-party packages to determine where to install '.m4' macro
     files, but _this usage is today discouraged_, since it causes
     '$(prefix)' not to be thoroughly honoured (which violates the GNU
     Coding Standards), and a similar semantics can be better obtained
     with the 'ACLOCAL_PATH' environment variable; *note Extending
     aclocal::.

'--verbose'
     Print the names of the files it examines.

'--version'
     Print the version number of Automake and exit.

'-W CATEGORY'
'--warnings=CATEGORY'
     Output warnings falling in CATEGORY.  CATEGORY can be one of:
     'syntax'
          dubious syntactic constructs, underquoted macros, unused
          macros, etc.
     'unsupported'
          unknown macros
     'all'
          all the warnings, this is the default
     'none'
          turn off all the warnings
     'error'
          treat warnings as errors

     All warnings are output by default.

     The environment variable 'WARNINGS' is honored in the same way as
     it is for 'automake' (*note automake Invocation::).

File: automake.info,  Node: Macro Search Path,  Next: Extending aclocal,  Prev: aclocal Options,  Up: aclocal Invocation

6.3.2 Macro Search Path
-----------------------

By default, 'aclocal' searches for '.m4' files in the following
directories, in this order:

'ACDIR-APIVERSION'
     This is where the '.m4' macros distributed with Automake itself are
     stored.  APIVERSION depends on the Automake release used; for
     example, for Automake 1.11.x, APIVERSION = '1.11'.

'ACDIR'
     This directory is intended for third party '.m4' files, and is
     configured when 'automake' itself is built.  This is
     '@datadir@/aclocal/', which typically expands to
     '${prefix}/share/aclocal/'.  To find the compiled-in value of
     ACDIR, use the '--print-ac-dir' option (*note aclocal Options::).

   As an example, suppose that 'automake-1.11.2' was configured with
'--prefix=/usr/local'.  Then, the search path would be:

  1. '/usr/local/share/aclocal-1.11.2/'
  2. '/usr/local/share/aclocal/'

   The paths for the ACDIR and ACDIR-APIVERSION directories can be
changed respectively through aclocal options '--system-acdir' and
'--automake-acdir' (*note aclocal Options::).  Note however that these
options are only intended for use by the internal Automake test suite,
or for debugging under highly unusual situations; they are not
ordinarily needed by end-users.

   As explained in (*note aclocal Options::), there are several options
that can be used to change or extend this search path.

Modifying the Macro Search Path: '-I DIR'
.........................................

Any extra directories specified using '-I' options (*note aclocal
Options::) are _prepended_ to this search list.  Thus, 'aclocal -I /foo
-I /bar' results in the following search path:

  1. '/foo'
  2. '/bar'
  3. ACDIR-APIVERSION
  4. ACDIR

Modifying the Macro Search Path: 'dirlist'
..........................................

There is a third mechanism for customizing the search path.  If a
'dirlist' file exists in ACDIR, then that file is assumed to contain a
list of directory patterns, one per line.  'aclocal' expands these
patterns to directory names, and adds them to the search list _after_
all other directories.  'dirlist' entries may use shell wildcards such
as '*', '?', or '[...]'.

   For example, suppose 'ACDIR/dirlist' contains the following:

     /test1
     /test2
     /test3*

and that 'aclocal' was called with the '-I /foo -I /bar' options.  Then,
the search path would be

  1. '/foo'
  2. '/bar'
  3. ACDIR-APIVERSION
  4. ACDIR
  5. '/test1'
  6. '/test2'

and all directories with path names starting with '/test3'.

   If the '--system-acdir=DIR' option is used, then 'aclocal' will
search for the 'dirlist' file in DIR; but remember the warnings above
against the use of '--system-acdir'.

   'dirlist' is useful in the following situation: suppose that
'automake' version '1.11.2' is installed with '--prefix=/usr' by the
system vendor.  Thus, the default search directories are

  1. '/usr/share/aclocal-1.11/'
  2. '/usr/share/aclocal/'

   However, suppose further that many packages have been manually
installed on the system, with $prefix=/usr/local, as is typical.  In
that case, many of these "extra" '.m4' files are in
'/usr/local/share/aclocal'.  The only way to force '/usr/bin/aclocal' to
find these "extra" '.m4' files is to always call 'aclocal -I
/usr/local/share/aclocal'.  This is inconvenient.  With 'dirlist', one
may create a file '/usr/share/aclocal/dirlist' containing only the
single line

     /usr/local/share/aclocal

   Now, the "default" search path on the affected system is

  1. '/usr/share/aclocal-1.11/'
  2. '/usr/share/aclocal/'
  3. '/usr/local/share/aclocal/'

   without the need for '-I' options; '-I' options can be reserved for
project-specific needs ('my-source-dir/m4/'), rather than using it to
work around local system-dependent tool installation directories.

   Similarly, 'dirlist' can be handy if you have installed a local copy
of Automake in your account and want 'aclocal' to look for macros
installed at other places on the system.

Modifying the Macro Search Path: 'ACLOCAL_PATH'
...............................................

The fourth and last mechanism to customize the macro search path is also
the simplest.  Any directory included in the colon-separated environment
variable 'ACLOCAL_PATH' is added to the search path and takes precedence
over system directories (including those found via 'dirlist'), with the
exception of the versioned directory ACDIR-APIVERSION (*note Macro
Search Path::).  However, directories passed via '-I' will take
precedence over directories in 'ACLOCAL_PATH'.

   Also note that, if the '--install' option is used, any '.m4' file
containing a required macro that is found in a directory listed in
'ACLOCAL_PATH' will be installed locally.  In this case, serial numbers
in '.m4' are honoured too, *note Serials::.

   Conversely to 'dirlist', 'ACLOCAL_PATH' is useful if you are using a
global copy of Automake and want 'aclocal' to look for macros somewhere
under your home directory.

Planned future incompatibilities
................................

The order in which the directories in the macro search path are
currently looked up is confusing and/or suboptimal in various aspects,
and is probably going to be changed in the future Automake release.  In
particular, directories in 'ACLOCAL_PATH' and 'ACDIR' might end up
taking precedence over 'ACDIR-APIVERSION', and directories in
'ACDIR/dirlist' might end up taking precedence over 'ACDIR'.  _This is a
possible future incompatibility!_

File: automake.info,  Node: Extending aclocal,  Next: Local Macros,  Prev: Macro Search Path,  Up: aclocal Invocation

6.3.3 Writing your own aclocal macros
-------------------------------------

The 'aclocal' program doesn't have any built-in knowledge of any macros,
so it is easy to extend it with your own macros.

   This can be used by libraries that want to supply their own Autoconf
macros for use by other programs.  For instance, the 'gettext' library
supplies a macro 'AM_GNU_GETTEXT' that should be used by any package
using 'gettext'.  When the library is installed, it installs this macro
so that 'aclocal' will find it.

   A macro file's name should end in '.m4'.  Such files should be
installed in '$(datadir)/aclocal'.  This is as simple as writing:

     aclocaldir = $(datadir)/aclocal
     aclocal_DATA = mymacro.m4 myothermacro.m4

Please do use '$(datadir)/aclocal', and not something based on the
result of 'aclocal --print-ac-dir' (*note Hard-Coded Install Paths::,
for arguments).  It might also be helpful to suggest to the user to add
the '$(datadir)/aclocal' directory to his 'ACLOCAL_PATH' variable (*note
ACLOCAL_PATH::) so that 'aclocal' will find the '.m4' files installed by
your package automatically.

   A file of macros should be a series of properly quoted 'AC_DEFUN''s
(*note (autoconf)Macro Definitions::).  The 'aclocal' programs also
understands 'AC_REQUIRE' (*note (autoconf)Prerequisite Macros::), so it
is safe to put each macro in a separate file.  Each file should have no
side effects but macro definitions.  Especially, any call to 'AC_PREREQ'
should be done inside the defined macro, not at the beginning of the
file.

   Starting with Automake 1.8, 'aclocal' will warn about all underquoted
calls to 'AC_DEFUN'.  We realize this will annoy a lot of people,
because 'aclocal' was not so strict in the past and many third party
macros are underquoted; and we have to apologize for this temporary
inconvenience.  The reason we have to be stricter is that a future
implementation of 'aclocal' (*note Future of aclocal::) will have to
temporarily include all of these third party '.m4' files, maybe several
times, including even files that are not actually needed.  Doing so
should alleviate many problems of the current implementation, however it
requires a stricter style from the macro authors.  Hopefully it is easy
to revise the existing macros.  For instance,

     # bad style
     AC_PREREQ(2.68)
     AC_DEFUN(AX_FOOBAR,
     [AC_REQUIRE([AX_SOMETHING])dnl
     AX_FOO
     AX_BAR
     ])

should be rewritten as

     AC_DEFUN([AX_FOOBAR],
     [AC_PREREQ([2.68])dnl
     AC_REQUIRE([AX_SOMETHING])dnl
     AX_FOO
     AX_BAR
     ])

   Wrapping the 'AC_PREREQ' call inside the macro ensures that Autoconf
2.68 will not be required if 'AX_FOOBAR' is not actually used.  Most
importantly, quoting the first argument of 'AC_DEFUN' allows the macro
to be redefined or included twice (otherwise this first argument would
be expanded during the second definition).  For consistency we like to
quote even arguments such as '2.68' that do not require it.

   If you have been directed here by the 'aclocal' diagnostic but are
not the maintainer of the implicated macro, you will want to contact the
maintainer of that macro.  Please make sure you have the latest version
of the macro and that the problem hasn't already been reported before
doing so: people tend to work faster when they aren't flooded by mails.

   Another situation where 'aclocal' is commonly used is to manage
macros that are used locally by the package, *note Local Macros::.

File: automake.info,  Node: Local Macros,  Next: Serials,  Prev: Extending aclocal,  Up: aclocal Invocation

6.3.4 Handling Local Macros
---------------------------

Feature tests offered by Autoconf do not cover all needs.  People often
have to supplement existing tests with their own macros, or with
third-party macros.

   There are two ways to organize custom macros in a package.

   The first possibility (the historical practice) is to list all your
macros in 'acinclude.m4'.  This file will be included in 'aclocal.m4'
when you run 'aclocal', and its macro(s) will henceforth be visible to
'autoconf'.  However if it contains numerous macros, it will rapidly
become difficult to maintain, and it will be almost impossible to share
macros between packages.

   The second possibility, which we do recommend, is to write each macro
in its own file and gather all these files in a directory.  This
directory is usually called 'm4/'.  Then it's enough to update
'configure.ac' by adding a proper call to 'AC_CONFIG_MACRO_DIRS':

     AC_CONFIG_MACRO_DIRS([m4])

   'aclocal' will then take care of automatically adding 'm4/' to its
search path for m4 files.

   When 'aclocal' is run, it will build an 'aclocal.m4' that
'm4_include's any file from 'm4/' that defines a required macro.  Macros
not found locally will still be searched in system-wide directories, as
explained in *note Macro Search Path::.

   Custom macros should be distributed for the same reason that
'configure.ac' is: so that other people have all the sources of your
package if they want to work on it.  Actually, this distribution happens
automatically because all 'm4_include'd files are distributed.

   However there is no consensus on the distribution of third-party
macros that your package may use.  Many libraries install their own
macro in the system-wide 'aclocal' directory (*note Extending
aclocal::).  For instance, Guile ships with a file called 'guile.m4'
that contains the macro 'GUILE_FLAGS' that can be used to define setup
compiler and linker flags appropriate for using Guile.  Using
'GUILE_FLAGS' in 'configure.ac' will cause 'aclocal' to copy 'guile.m4'
into 'aclocal.m4', but as 'guile.m4' is not part of the project, it will
not be distributed.  Technically, that means a user who needs to rebuild
'aclocal.m4' will have to install Guile first.  This is probably OK, if
Guile already is a requirement to build the package.  However, if Guile
is only an optional feature, or if your package might run on
architectures where Guile cannot be installed, this requirement will
hinder development.  An easy solution is to copy such third-party macros
in your local 'm4/' directory so they get distributed.

   Since Automake 1.10, 'aclocal' offers the option '--install' to copy
these system-wide third-party macros in your local macro directory,
helping to solve the above problem.

   With this setup, system-wide macros will be copied to 'm4/' the first
time you run 'aclocal'.  Then the locally installed macros will have
precedence over the system-wide installed macros each time 'aclocal' is
run again.

   One reason why you should keep '--install' in the flags even after
the first run is that when you later edit 'configure.ac' and depend on a
new macro, this macro will be installed in your 'm4/' automatically.
Another one is that serial numbers (*note Serials::) can be used to
update the macros in your source tree automatically when new system-wide
versions are installed.  A serial number should be a single line of the
form

     #serial NNN

where NNN contains only digits and dots.  It should appear in the M4
file before any macro definition.  It is a good practice to maintain a
serial number for each macro you distribute, even if you do not use the
'--install' option of 'aclocal': this allows other people to use it.

File: automake.info,  Node: Serials,  Next: Future of aclocal,  Prev: Local Macros,  Up: aclocal Invocation

6.3.5 Serial Numbers
--------------------

Because third-party macros defined in '*.m4' files are naturally shared
between multiple projects, some people like to version them.  This makes
it easier to tell which of two M4 files is newer.  Since at least 1996,
the tradition is to use a '#serial' line for this.

   A serial number should be a single line of the form

     # serial VERSION

where VERSION is a version number containing only digits and dots.
Usually people use a single integer, and they increment it each time
they change the macro (hence the name of "serial").  Such a line should
appear in the M4 file before any macro definition.

   The '#' must be the first character on the line, and it is OK to have
extra words after the version, as in

     #serial VERSION GARBAGE

   Normally these serial numbers are completely ignored by 'aclocal' and
'autoconf', like any genuine comment.  However when using 'aclocal''s
'--install' feature, these serial numbers will modify the way 'aclocal'
selects the macros to install in the package: if two files with the same
basename exist in your search path, and if at least one of them uses a
'#serial' line, 'aclocal' will ignore the file that has the older
'#serial' line (or the file that has none).

   Note that a serial number applies to a whole M4 file, not to any
macro it contains.  A file can contains multiple macros, but only one
serial.

   Here is a use case that illustrates the use of '--install' and its
interaction with serial numbers.  Let's assume we maintain a package
called MyPackage, the 'configure.ac' of which requires a third-party
macro 'AX_THIRD_PARTY' defined in '/usr/share/aclocal/thirdparty.m4' as
follows:

     # serial 1
     AC_DEFUN([AX_THIRD_PARTY], [...])

   MyPackage uses an 'm4/' directory to store local macros as explained
in *note Local Macros::, and has

     AC_CONFIG_MACRO_DIRS([m4])

in its 'configure.ac'.

   Initially the 'm4/' directory is empty.  The first time we run
'aclocal --install', it will notice that

   * 'configure.ac' uses 'AX_THIRD_PARTY'
   * No local macros define 'AX_THIRD_PARTY'
   * '/usr/share/aclocal/thirdparty.m4' defines 'AX_THIRD_PARTY' with
     serial 1.

Because '/usr/share/aclocal/thirdparty.m4' is a system-wide macro and
'aclocal' was given the '--install' option, it will copy this file in
'm4/thirdparty.m4', and output an 'aclocal.m4' that contains
'm4_include([m4/thirdparty.m4])'.

   The next time 'aclocal --install' is run, something different
happens.  'aclocal' notices that

   * 'configure.ac' uses 'AX_THIRD_PARTY'
   * 'm4/thirdparty.m4' defines 'AX_THIRD_PARTY' with serial 1.
   * '/usr/share/aclocal/thirdparty.m4' defines 'AX_THIRD_PARTY' with
     serial 1.

Because both files have the same serial number, 'aclocal' uses the first
it found in its search path order (*note Macro Search Path::).
'aclocal' therefore ignores '/usr/share/aclocal/thirdparty.m4' and
outputs an 'aclocal.m4' that contains 'm4_include([m4/thirdparty.m4])'.

   Local directories specified with '-I' are always searched before
system-wide directories, so a local file will always be preferred to the
system-wide file in case of equal serial numbers.

   Now suppose the system-wide third-party macro is changed.  This can
happen if the package installing this macro is updated.  Let's suppose
the new macro has serial number 2.  The next time 'aclocal --install' is
run the situation is the following:

   * 'configure.ac' uses 'AX_THIRD_PARTY'
   * 'm4/thirdparty.m4' defines 'AX_THIRD_PARTY' with serial 1.
   * '/usr/share/aclocal/thirdparty.m4' defines 'AX_THIRD_PARTY' with
     serial 2.

When 'aclocal' sees a greater serial number, it immediately forgets
anything it knows from files that have the same basename and a smaller
serial number.  So after it has found '/usr/share/aclocal/thirdparty.m4'
with serial 2, 'aclocal' will proceed as if it had never seen
'm4/thirdparty.m4'.  This brings us back to a situation similar to that
at the beginning of our example, where no local file defined the macro.
'aclocal' will install the new version of the macro in
'm4/thirdparty.m4', in this case overriding the old version.  MyPackage
just had its macro updated as a side effect of running 'aclocal'.

   If you are leery of letting 'aclocal' update your local macro, you
can run 'aclocal --diff' to review the changes 'aclocal --install' would
perform on these macros.

   Finally, note that the '--force' option of 'aclocal' has absolutely
no effect on the files installed by '--install'.  For instance, if you
have modified your local macros, do not expect '--install --force' to
replace the local macros by their system-wide versions.  If you want to
do so, simply erase the local macros you want to revert, and run
'aclocal --install'.

File: automake.info,  Node: Future of aclocal,  Prev: Serials,  Up: aclocal Invocation

6.3.6 The Future of 'aclocal'
-----------------------------

'aclocal' is expected to disappear.  This feature really should not be
offered by Automake.  Automake should focus on generating 'Makefile's;
dealing with M4 macros really is Autoconf's job.  The fact that some
people install Automake just to use 'aclocal', but do not use 'automake'
otherwise is an indication of how that feature is misplaced.

   The new implementation will probably be done slightly differently.
For instance, it could enforce the 'm4/'-style layout discussed in *note
Local Macros::.

   We have no idea when and how this will happen.  This has been
discussed several times in the past, but someone still has to commit to
that non-trivial task.

   From the user point of view, 'aclocal''s removal might turn out to be
painful.  There is a simple precaution that you may take to make that
switch more seamless: never call 'aclocal' yourself.  Keep this guy
under the exclusive control of 'autoreconf' and Automake's rebuild
rules.  Hopefully you won't need to worry about things breaking, when
'aclocal' disappears, because everything will have been taken care of.
If otherwise you used to call 'aclocal' directly yourself or from some
script, you will quickly notice the change.

   Many packages come with a script called 'bootstrap.sh' or
'autogen.sh', that will just call 'aclocal', 'libtoolize', 'gettextize'
or 'autopoint', 'autoconf', 'autoheader', and 'automake' in the right
order.  Actually this is precisely what 'autoreconf' can do for you.  If
your package has such a 'bootstrap.sh' or 'autogen.sh' script, consider
using 'autoreconf'.  That should simplify its logic a lot (less things
to maintain, yum!), it's even likely you will not need the script
anymore, and more to the point you will not call 'aclocal' directly
anymore.

   For the time being, third-party packages should continue to install
public macros into '/usr/share/aclocal/'.  If 'aclocal' is replaced by
another tool it might make sense to rename the directory, but supporting
'/usr/share/aclocal/' for backward compatibility should be really easy
provided all macros are properly written (*note Extending aclocal::).

