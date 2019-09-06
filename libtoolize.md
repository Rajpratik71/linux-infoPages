File: libtool.info,  Node: Invoking libtoolize,  Next: Autoconf and LTLIBOBJS,  Up: Distributing

5.5.1 Invoking `libtoolize'
---------------------------

The `libtoolize' program provides a standard way to add libtool support
to your package.  In the future, it may implement better usage
checking, or other features to make libtool even easier to use.

   The `libtoolize' program has the following synopsis:

     libtoolize [OPTION]...

and accepts the following options:

`--copy'
`-c'
     Copy files from the libtool data directory rather than creating
     symlinks.

`--debug'
     Dump a trace of shell script execution to standard output.  This
     produces a lot of output, so you may wish to pipe it to `less' (or
     `more') or redirect to a file.

`--dry-run'
`-n'
     Don't run any commands that modify the file system, just print them
     out.

`--force'
`-f'
     Replace existing libtool files.  By default, `libtoolize' won't
     overwrite existing files.

`--help'
     Display a help message and exit.

`--ltdl [TARGET-DIRECTORY-NAME]'
     Install libltdl in the TARGET-DIRECTORY-NAME subdirectory of your
     package.  Normally, the directory is extracted from the argument
     to `LT_CONFIG_LTDL_DIR' in `configure.ac', though you can also
     specify a subdirectory name here if you are not using Autoconf for
     example.  If `libtoolize' can't determine the target directory,
     `libltdl' is used as the default.

`--no-warn'
     Normally, Libtoolize tries to diagnose use of deprecated libtool
     macros and other stylistic issues.  If you are deliberately using
     outdated calling conventions, this option prevents Libtoolize from
     explaining how to update your project's Libtool conventions.

`--nonrecursive'
     If passed in conjunction with `--ltdl', this option will cause the
     `libltdl' installed by `libtoolize' to be set up for use with a
     non-recursive `automake' build.  To make use of it, you will need
     to add the following to the `Makefile.am' of the parent project:

          ## libltdl/Makefile.inc appends to the following variables
          ## so we set them here before including it:
          BUILT_SOURCES   =

          AM_CPPFLAGS        =
          AM_LDFLAGS         =

          include_HEADERS    =
          noinst_LTLIBRARIES =
          lib_LTLIBRARIES   =
          EXTRA_LTLIBRARIES  =

          EXTRA_DIST   =

          CLEANFILES   =
          MOSTLYCLEANFILES   =

          include libltdl/Makefile.inc


`--quiet'
`-q'
     Work silently.  `libtoolize --quiet' is used by GNU Automake to
     add libtool files to your package if necessary.

`--recursive'
     If passed in conjunction with `--ltdl', this option will cause the
     `libtoolize' installed `libltdl' to be set up for use with a
     recursive `automake' build.  To make use of it, you will need to
     adjust the parent project's `configure.ac':

          AC_CONFIG_FILES([libltdl/Makefile])

     and `Makefile.am':

          SUBDIRS += libltdl

`--subproject'
     If passed in conjunction with `--ltdl', this option will cause the
     `libtoolize' installed `libltdl' to be set up for independent
     configuration and compilation as a self-contained subproject.  To
     make use of it, you should arrange for your build to call
     `libltdl/configure', and then run `make' in the `libltdl'
     directory (or the subdirectory you put libltdl into).  If your
     project uses Autoconf, you can use the supplied `LT_WITH_LTDL'
     macro, or else call `AC_CONFIG_SUBDIRS' directly.

     Previous releases of `libltdl' built exclusively in this mode, but
     now it is the default mode both for backwards compatibility and
     because, for example, it is suitable for use in projects that wish
     to use `libltdl', but not use the Autotools for their own build
     process.

`--verbose'
`-v'
     Work noisily!  Give a blow by blow account of what `libtoolize' is
     doing.

`--version'
     Print `libtoolize' version information and exit.

   Sometimes it can be useful to pass options to `libtoolize' even
though it is called by another program, such as `autoreconf'.  A
limited number of options are parsed from the environment variable
`LIBTOOLIZE_OPTIONS': currently `--debug', `--no-warn', `--quiet' and
`--verbose'.  Multiple options passed in `LIBTOOLIZE_OPTIONS' must be
separated with a space, comma or a colon.

   By default, a warning is issued for unknown options found in
`LIBTOOLIZE_OPTIONS' unless the first such option is `--no-warn'.
Where `libtoolize' has always quit on receipt of an unknown option at
the command line, this and all previous releases of `libtoolize' will
continue unabated whatever the content of `LIBTOOLIZE_OPTIONS' (modulo
some possible warning messages).

     trick$ LIBTOOLIZE_OPTIONS=--no-warn,--quiet autoreconf --install

   If `libtoolize' detects an explicit call to `AC_CONFIG_MACRO_DIR'
(*note The Autoconf Manual: (autoconf)Input.) in your `configure.ac',
it will put the Libtool macros in the specified directory.

   In the future other Autotools will automatically check the contents
of `AC_CONFIG_MACRO_DIR', but at the moment it is more portable to add
the macro directory to `ACLOCAL_AMFLAGS' in `Makefile.am', which is
where the tools currently look.  If `libtoolize' doesn't see
`AC_CONFIG_MACRO_DIR', it too will honour the first `-I' argument in
`ACLOCAL_AMFLAGS' when choosing a directory to store libtool
configuration macros in.  It is perfectly sensible to use both
`AC_CONFIG_MACRO_DIR' and `ACLOCAL_AMFLAGS', as long as they are kept
in synchronisation.

     ACLOCAL_AMFLAGS = -I m4

   When you bootstrap your project with `aclocal', then you will need
to explicitly pass the same macro directory with `aclocal''s `-I' flag:

     trick$ aclocal -I m4

   If `libtoolize' detects an explicit call to `AC_CONFIG_AUX_DIR'
(*note The Autoconf Manual: (autoconf)Input.) in your `configure.ac', it
will put the other support files in the specified directory.  Otherwise
they too end up in the project root directory.

   Unless `--no-warn' is passed, `libtoolize' displays hints for adding
libtool support to your package, as well.

