File: autoconf.info,  Node: autom4te Invocation,  Next: Customizing autom4te,  Up: Using autom4te

8.2.1 Invoking `autom4te'
-------------------------

The command line arguments are modeled after M4's:

     autom4te OPTIONS FILES

where the FILES are directly passed to `m4'.  By default, GNU M4 is
found during configuration, but the environment variable `M4' can be
set to tell `autom4te' where to look.  In addition to the regular
expansion, it handles the replacement of the quadrigraphs (*note
Quadrigraphs::), and of `__oline__', the current line in the output.
It supports an extended syntax for the FILES:

`FILE.m4f'
     This file is an M4 frozen file.  Note that _all the previous files
     are ignored_.  See the option `--melt' for the rationale.

`FILE?'
     If found in the library path, the FILE is included for expansion,
     otherwise it is ignored instead of triggering a failure.


   Of course, it supports the Autoconf common subset of options:

`--help'
`-h'
     Print a summary of the command line options and exit.

`--version'
`-V'
     Print the version number of Autoconf and exit.

`--verbose'
`-v'
     Report processing steps.

`--debug'
`-d'
     Don't remove the temporary files and be even more verbose.

`--include=DIR'
`-I DIR'
     Also look for input files in DIR.  Multiple invocations accumulate.

`--output=FILE'
`-o FILE'
     Save output (script or trace) to FILE.  The file `-' stands for
     the standard output.


   As an extension of `m4', it includes the following options:

`--warnings=CATEGORY'
`-W CATEGORY'
     Report the warnings related to CATEGORY (which can actually be a
     comma separated list).  *Note Reporting Messages::, macro
     `AC_DIAGNOSE', for a comprehensive list of categories.  Special
     values include:

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
     honored.  `autom4te -W CATEGORY' actually behaves as if you had
     run:

          autom4te --warnings=syntax,$WARNINGS,CATEGORY

     For example, if you want to disable defaults and `WARNINGS' of
     `autom4te', but enable the warnings about obsolete constructs, you
     would use `-W none,obsolete'.

     `autom4te' displays a back trace for errors, but not for warnings;
     if you want them, just pass `-W error'.

`--melt'
`-M'
     Do not use frozen files.  Any argument `FILE.m4f' is replaced by
     `FILE.m4'.  This helps tracing the macros which are executed only
     when the files are frozen, typically `m4_define'.  For instance,
     running:

          autom4te --melt 1.m4 2.m4f 3.m4 4.m4f input.m4

     is roughly equivalent to running:

          m4 1.m4 2.m4 3.m4 4.m4 input.m4

     while

          autom4te 1.m4 2.m4f 3.m4 4.m4f input.m4

     is equivalent to:

          m4 --reload-state=4.m4f input.m4

`--freeze'
`-F'
     Produce a frozen state file.  `autom4te' freezing is stricter than
     M4's: it must produce no warnings, and no output other than empty
     lines (a line with white space is _not_ empty) and comments
     (starting with `#').  Unlike `m4''s similarly-named option, this
     option takes no argument:

          autom4te 1.m4 2.m4 3.m4 --freeze --output=3.m4f

     corresponds to

          m4 1.m4 2.m4 3.m4 --freeze-state=3.m4f

`--mode=OCTAL-MODE'
`-m OCTAL-MODE'
     Set the mode of the non-traces output to OCTAL-MODE; by default
     `0666'.


   As another additional feature over `m4', `autom4te' caches its
results.  GNU M4 is able to produce a regular output and traces at the
same time.  Traces are heavily used in the GNU Build System:
`autoheader' uses them to build `config.h.in', `autoreconf' to
determine what GNU Build System components are used, `automake' to
"parse" `configure.ac' etc.  To avoid recomputation, traces are cached
while performing regular expansion, and conversely.  This cache is
(actually, the caches are) stored in the directory `autom4te.cache'.
_It can safely be removed_ at any moment (especially if for some reason
`autom4te' considers it trashed).

`--cache=DIRECTORY'
`-C DIRECTORY'
     Specify the name of the directory where the result should be
     cached.  Passing an empty value disables caching.  Be sure to pass
     a relative file name, as for the time being, global caches are not
     supported.

`--no-cache'
     Don't cache the results.

`--force'
`-f'
     If a cache is used, consider it obsolete (but update it anyway).


   Because traces are so important to the GNU Build System, `autom4te'
provides high level tracing features as compared to M4, and helps
exploiting the cache:

`--trace=MACRO[:FORMAT]'
`-t MACRO[:FORMAT]'
     Trace the invocations of MACRO according to the FORMAT.  Multiple
     `--trace' arguments can be used to list several macros.  Multiple
     `--trace' arguments for a single macro are not cumulative;
     instead, you should just make FORMAT as long as needed.

     The FORMAT is a regular string, with newlines if desired, and
     several special escape codes.  It defaults to `$f:$l:$n:$%'.  It
     can use the following special escapes:

    `$$'
          The character `$'.

    `$f'
          The file name from which MACRO is called.

    `$l'
          The line number from which MACRO is called.

    `$d'
          The depth of the MACRO call.  This is an M4 technical detail
          that you probably don't want to know about.

    `$n'
          The name of the MACRO.

    `$NUM'
          The NUMth argument of the call to MACRO.

    `$@'
    `$SEP@'
    `${SEPARATOR}@'
          All the arguments passed to MACRO, separated by the character
          SEP or the string SEPARATOR (`,' by default).  Each argument
          is quoted, i.e., enclosed in a pair of square brackets.

    `$*'
    `$SEP*'
    `${SEPARATOR}*'
          As above, but the arguments are not quoted.

    `$%'
    `$SEP%'
    `${SEPARATOR}%'
          As above, but the arguments are not quoted, all new line
          characters in the arguments are smashed, and the default
          separator is `:'.

          The escape `$%' produces single-line trace outputs (unless
          you put newlines in the `separator'), while `$@' and `$*' do
          not.

     *Note autoconf Invocation::, for examples of trace uses.

`--preselect=MACRO'
`-p MACRO'
     Cache the traces of MACRO, but do not enable traces.  This is
     especially important to save CPU cycles in the future.  For
     instance, when invoked, `autoconf' preselects all the macros that
     `autoheader', `automake', `autoreconf', etc., trace, so that
     running `m4' is not needed to trace them: the cache suffices.
     This results in a huge speed-up.


   Finally, `autom4te' introduces the concept of "Autom4te libraries".
They consists in a powerful yet extremely simple feature: sets of
combined command line arguments:

`--language=LANGUAGE'
`-l LANGUAGE'
     Use the LANGUAGE Autom4te library.  Current languages include:

    `M4sugar'
          create M4sugar output.

    `M4sh'
          create M4sh executable shell scripts.

    `Autotest'
          create Autotest executable test suites.

    `Autoconf-without-aclocal-m4'
          create Autoconf executable configure scripts without reading
          `aclocal.m4'.

    `Autoconf'
          create Autoconf executable configure scripts.  This language
          inherits all the characteristics of
          `Autoconf-without-aclocal-m4' and additionally reads
          `aclocal.m4'.

`--prepend-include=DIR'
`-B DIR'
     Prepend directory DIR to the search path.  This is used to include
     the language-specific files before any third-party macros.


   As an example, if Autoconf is installed in its default location,
`/usr/local', the command `autom4te -l m4sugar foo.m4' is strictly
equivalent to the command:

     autom4te --prepend-include /usr/local/share/autoconf \
       m4sugar/m4sugar.m4f --warnings syntax foo.m4

Recursive expansion applies here: the command `autom4te -l m4sh foo.m4'
is the same as `autom4te --language M4sugar m4sugar/m4sh.m4f foo.m4',
i.e.:

     autom4te --prepend-include /usr/local/share/autoconf \
       m4sugar/m4sugar.m4f m4sugar/m4sh.m4f --mode 777 foo.m4

The definition of the languages is stored in `autom4te.cfg'.

