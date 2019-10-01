File: autoconf.info,  Node: autoscan Invocation,  Next: ifnames Invocation,  Prev: Writing Autoconf Input,  Up: Making configure Scripts

3.2 Using `autoscan' to Create `configure.ac'
=============================================

The `autoscan' program can help you create and/or maintain a
`configure.ac' file for a software package.  `autoscan' examines source
files in the directory tree rooted at a directory given as a command
line argument, or the current directory if none is given.  It searches
the source files for common portability problems and creates a file
`configure.scan' which is a preliminary `configure.ac' for that
package, and checks a possibly existing `configure.ac' for completeness.

   When using `autoscan' to create a `configure.ac', you should
manually examine `configure.scan' before renaming it to `configure.ac';
it probably needs some adjustments.  Occasionally, `autoscan' outputs a
macro in the wrong order relative to another macro, so that `autoconf'
produces a warning; you need to move such macros manually.  Also, if
you want the package to use a configuration header file, you must add a
call to `AC_CONFIG_HEADERS' (*note Configuration Headers::).  You might
also have to change or add some `#if' directives to your program in
order to make it work with Autoconf (*note ifnames Invocation::, for
information about a program that can help with that job).

   When using `autoscan' to maintain a `configure.ac', simply consider
adding its suggestions.  The file `autoscan.log' contains detailed
information on why a macro is requested.

   `autoscan' uses several data files (installed along with Autoconf)
to determine which macros to output when it finds particular symbols in
a package's source files.  These data files all have the same format:
each line consists of a symbol, one or more blanks, and the Autoconf
macro to output if that symbol is encountered.  Lines starting with `#'
are comments.

   `autoscan' accepts the following options:

`--help'
`-h'
     Print a summary of the command line options and exit.

`--version'
`-V'
     Print the version number of Autoconf and exit.

`--verbose'
`-v'
     Print the names of the files it examines and the potentially
     interesting symbols it finds in them.  This output can be
     voluminous.

`--debug'
`-d'
     Don't remove temporary files.

`--include=DIR'
`-I DIR'
     Append DIR to the include path.  Multiple invocations accumulate.

`--prepend-include=DIR'
`-B DIR'
     Prepend DIR to the include path.  Multiple invocations accumulate.

