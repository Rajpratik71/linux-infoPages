File: autoconf.info,  Node: autoheader Invocation,  Next: Autoheader Macros,  Prev: Header Templates,  Up: Configuration Headers

4.9.2 Using `autoheader' to Create `config.h.in'
------------------------------------------------

The `autoheader' program can create a template file of C `#define'
statements for `configure' to use.  It searches for the first
invocation of `AC_CONFIG_HEADERS' in `configure' sources to determine
the name of the template.  (If the first call of `AC_CONFIG_HEADERS'
specifies more than one input file name, `autoheader' uses the first
one.)

   It is recommended that only one input file is used.  If you want to
append a boilerplate code, it is preferable to use `AH_BOTTOM([#include
<conf_post.h>])'.  File `conf_post.h' is not processed during the
configuration then, which make things clearer.  Analogically, `AH_TOP'
can be used to prepend a boilerplate code.

   In order to do its job, `autoheader' needs you to document all of
the symbols that you might use.  Typically this is done via an
`AC_DEFINE' or `AC_DEFINE_UNQUOTED' call whose first argument is a
literal symbol and whose third argument describes the symbol (*note
Defining Symbols::).  Alternatively, you can use `AH_TEMPLATE' (*note
Autoheader Macros::), or you can supply a suitable input file for a
subsequent configuration header file.  Symbols defined by Autoconf's
builtin tests are already documented properly; you need to document
only those that you define yourself.

   You might wonder why `autoheader' is needed: after all, why would
`configure' need to "patch" a `config.h.in' to produce a `config.h'
instead of just creating `config.h' from scratch?  Well, when
everything rocks, the answer is just that we are wasting our time
maintaining `autoheader': generating `config.h' directly is all that is
needed.  When things go wrong, however, you'll be thankful for the
existence of `autoheader'.

   The fact that the symbols are documented is important in order to
_check_ that `config.h' makes sense.  The fact that there is a
well-defined list of symbols that should be defined (or not) is also
important for people who are porting packages to environments where
`configure' cannot be run: they just have to _fill in the blanks_.

   But let's come back to the point: the invocation of `autoheader'...

   If you give `autoheader' an argument, it uses that file instead of
`configure.ac' and writes the header file to the standard output
instead of to `config.h.in'.  If you give `autoheader' an argument of
`-', it reads the standard input instead of `configure.ac' and writes
the header file to the standard output.

   `autoheader' accepts the following options:

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
     Remake the template file even if newer than its input files.

`--include=DIR'
`-I DIR'
     Append DIR to the include path.  Multiple invocations accumulate.

`--prepend-include=DIR'
`-B DIR'
     Prepend DIR to the include path.  Multiple invocations accumulate.

`--warnings=CATEGORY'
`-W CATEGORY'
     Report the warnings related to CATEGORY (which can actually be a
     comma separated list).  Current categories include:

    `obsolete'
          report the uses of obsolete constructs

    `all'
          report all the warnings

    `none'
          report none

    `error'
          treats warnings as errors

    `no-CATEGORY'
          disable warnings falling into CATEGORY


