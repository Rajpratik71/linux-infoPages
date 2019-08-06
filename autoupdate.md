File: autoconf.info,  Node: autoupdate Invocation,  Next: Obsolete Macros,  Prev: acconfig Header,  Up: Obsolete Constructs

18.3 Using `autoupdate' to Modernize `configure.ac'
===================================================

The `autoupdate' program updates a `configure.ac' file that calls
Autoconf macros by their old names to use the current macro names.  In
version 2 of Autoconf, most of the macros were renamed to use a more
uniform and descriptive naming scheme.  *Note Macro Names::, for a
description of the new scheme.  Although the old names still work
(*note Obsolete Macros::, for a list of the old macros and the
corresponding new names), you can make your `configure.ac' files more
readable and make it easier to use the current Autoconf documentation
if you update them to use the new macro names.

   If given no arguments, `autoupdate' updates `configure.ac', backing
up the original version with the suffix `~' (or the value of the
environment variable `SIMPLE_BACKUP_SUFFIX', if that is set).  If you
give `autoupdate' an argument, it reads that file instead of
`configure.ac' and writes the updated file to the standard output.

`autoupdate' accepts the following options:

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
     Don't remove the temporary files.

`--force'
`-f'
     Force the update even if the file has not changed.  Disregard the
     cache.

`--include=DIR'
`-I DIR'
     Also look for input files in DIR.  Multiple invocations accumulate.
     Directories are browsed from last to first.

`--prepend-include=DIR'
`-B DIR'
     Prepend directory DIR to the search path.  This is used to include
     the language-specific files before any third-party macros.

