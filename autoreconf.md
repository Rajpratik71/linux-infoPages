File: autoconf.info,  Node: autoreconf Invocation,  Prev: autoconf Invocation,  Up: Making configure Scripts

3.5 Using `autoreconf' to Update `configure' Scripts
====================================================

Installing the various components of the GNU Build System can be
tedious: running `autopoint' for Gettext, `automake' for `Makefile.in'
etc. in each directory.  It may be needed either because some tools
such as `automake' have been updated on your system, or because some of
the sources such as `configure.ac' have been updated, or finally,
simply in order to install the GNU Build System in a fresh tree.

   `autoreconf' runs `autoconf', `autoheader', `aclocal', `automake',
`libtoolize', and `autopoint' (when appropriate) repeatedly to update
the GNU Build System in the specified directories and their
subdirectories (*note Subdirectories::).  By default, it only remakes
those files that are older than their sources.  The environment
variables `AUTOM4TE', `AUTOCONF', `AUTOHEADER', `AUTOMAKE', `ACLOCAL',
`AUTOPOINT', `LIBTOOLIZE', `M4', and `MAKE' may be used to override the
invocation of the respective tools.

   If you install a new version of some tool, you can make `autoreconf'
remake _all_ of the files by giving it the `--force' option.

   *Note Automatic Remaking::, for Make rules to automatically rebuild
`configure' scripts when their source files change.  That method
handles the timestamps of configuration header templates properly, but
does not pass `--autoconf-dir=DIR' or `--localdir=DIR'.

   Gettext supplies the `autopoint' command to add translation
infrastructure to a source package.  If you use `autopoint', your
`configure.ac' should invoke both `AM_GNU_GETTEXT' and
`AM_GNU_GETTEXT_VERSION(GETTEXT-VERSION)'.  *Note Invoking the
`autopoint' Program: (gettext)autopoint Invocation, for further details.

`autoreconf' accepts the following options:

`--help'
`-h'
     Print a summary of the command line options and exit.

`--version'
`-V'
     Print the version number of Autoconf and exit.

`--verbose'
`-v'
     Print the name of each directory `autoreconf' examines and the
     commands it runs.  If given two or more times, pass `--verbose' to
     subordinate tools that support it.

`--debug'
`-d'
     Don't remove the temporary files.

`--force'
`-f'
     Remake even `configure' scripts and configuration headers that are
     newer than their input files (`configure.ac' and, if present,
     `aclocal.m4').

`--install'
`-i'
     Install the missing auxiliary files in the package.  By default,
     files are copied; this can be changed with `--symlink'.

     If deemed appropriate, this option triggers calls to `automake
     --add-missing', `libtoolize', `autopoint', etc.

`--no-recursive'
     Do not rebuild files in subdirectories to configure (see *note
     Subdirectories::, macro `AC_CONFIG_SUBDIRS').

`--symlink'
`-s'
     When used with `--install', install symbolic links to the missing
     auxiliary files instead of copying them.

`--make'
`-m'
     When the directories were configured, update the configuration by
     running `./config.status --recheck && ./config.status', and then
     run `make'.

`--include=DIR'
`-I DIR'
     Append DIR to the include path.  Multiple invocations accumulate.
     Passed on to `aclocal', `autoconf' and `autoheader' internally.

`--prepend-include=DIR'
`-B DIR'
     Prepend DIR to the include path.  Multiple invocations accumulate.
     Passed on to `autoconf' and `autoheader' internally.

`--warnings=CATEGORY'
`-W CATEGORY'
     Report the warnings related to CATEGORY (which can actually be a
     comma separated list).

    `cross'
          related to cross compilation issues.

    `obsolete'
          report the uses of obsolete constructs.

    `portability'
          portability issues

    `syntax'
          dubious syntactic constructs.

    `all'
          report all the warnings

    `none'
          report none

    `error'
          treats warnings as errors

    `no-CATEGORY'
          disable warnings falling into CATEGORY

     Warnings about `syntax' are enabled by default, and the environment
     variable `WARNINGS', a comma separated list of categories, is
     honored as well.  Passing `-W CATEGORY' actually behaves as if you
     had passed `--warnings syntax,$WARNINGS,CATEGORY'.  To disable the
     defaults and `WARNINGS', and then enable warnings about obsolete
     constructs, use `-W none,obsolete'.

   If you want `autoreconf' to pass flags that are not listed here on
to `aclocal', set `ACLOCAL_AMFLAGS' in your `Makefile.am'.  Due to a
limitation in the Autoconf implementation these flags currently must be
set on a single line in `Makefile.am', without any backslash-newlines.

