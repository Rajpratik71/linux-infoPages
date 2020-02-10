Next: Invoking locate,  Up: Reference

8.1 Invoking 'find'
===================

     find [-H] [-L] [-P] [-D DEBUGOPTIONS] [-OLEVEL] [FILE...] [EXPRESSION]

   'find' searches the directory tree rooted at each file name FILE by
evaluating the EXPRESSION on each file it finds in the tree.

   The command line may begin with the '-H', '-L', '-P', '-D' and '-O'
options.  These are followed by a list of files or directories that
should be searched.  If no files to search are specified, the current
directory ('.') is used.

   This list of files to search is followed by a list of expressions
describing the files we wish to search for.  The first part of the
expression is recognised by the fact that it begins with '-' followed by
some other letters (for example '-print'), or is either '(' or '!'.  Any
arguments after it are the rest of the expression.

   If no expression is given, the expression '-print' is used.

   The 'find' command exits with status zero if all files matched are
processed successfully, greater than zero if errors occur.

   The 'find' program also recognises two options for administrative
use:

'--help'
     Print a summary of the command line usage and exit.
'--version'
     Print the version number of 'find' and exit.

   The '-version' option is a synonym for '--version'

* Menu:

* Filesystem Traversal Options::
* Warning Messages::
* Optimisation Options::
* Debug Options::
* Find Expressions::

Next: Warning Messages,  Up: Invoking find

8.1.1 Filesystem Traversal Options
----------------------------------

The options '-H', '-L' or '-P' may be specified at the start of the
command line (if none of these is specified, '-P' is assumed).  If you
specify more than one of these options, the last one specified takes
effect (but note that the '-follow' option is equivalent to '-L').

'-P'
     Never follow symbolic links (this is the default), except in the
     case of the '-xtype' predicate.
'-L'
     Always follow symbolic links, except in the case of the '-xtype'
     predicate.
'-H'
     Follow symbolic links specified in the list of files to search, or
     which are otherwise specified on the command line.

   If 'find' would follow a symbolic link, but cannot for any reason
(for example, because it has insufficient permissions or the link is
broken), it falls back on using the properties of the symbolic link
itself.  *note Symbolic Links:: for a more complete description of how
symbolic links are handled.

Next: Optimisation Options,  Prev: Filesystem Traversal Options,  Up: Invoking find

8.1.2 Warning Messages
----------------------

If there is an error on the 'find' command line, an error message is
normally issued.  However, there are some usages that are inadvisable
but which 'find' should still accept.  Under these circumstances, 'find'
may issue a warning message.

   By default, warnings are enabled only if 'find' is being run
interactively (specifically, if the standard input is a terminal) and
the 'POSIXLY_CORRECT' environment variable is not set.  Warning messages
can be controlled explicitly by the use of options on the command line:

'-warn'
     Issue warning messages where appropriate.
'-nowarn'
     Do not issue warning messages.

   These options take effect at the point on the command line where they
are specified.  Therefore it's not useful to specify '-nowarn' at the
end of the command line.  The warning messages affected by the above
options are triggered by:

   - Use of the '-d' option which is deprecated; please use '-depth'
     instead, since the latter is POSIX-compliant.
   - Use of the '-ipath' option which is deprecated; please use
     '-iwholename' instead.
   - Specifying an option (for example '-mindepth') after a non-option
     (for example '-type' or '-print') on the command line.
   - Use of the '-name' or '-iname' option with a slash character in the
     pattern.  Since the name predicates only compare against the
     basename of the visited files, the only file that can match a slash
     is the root directory itself.

   The default behaviour above is designed to work in that way so that
existing shell scripts don't generate spurious errors, but people will
be made aware of the problem.

   Some warning messages are issued for less common or more serious
problems, and consequently cannot be turned off:

   - Use of an unrecognised backslash escape sequence with '-fprintf'
   - Use of an unrecognised formatting directive with '-fprintf'

Next: Debug Options,  Prev: Warning Messages,  Up: Invoking find

8.1.3 Optimisation Options
--------------------------

The '-OLEVEL' option sets 'find''s optimisation level to LEVEL.  The
default optimisation level is 1.

   At certain optimisation levels, 'find' reorders tests to speed up
execution while preserving the overall effect; that is, predicates with
side effects are not reordered relative to each other.  The
optimisations performed at each optimisation level are as follows.

'0'
     Currently equivalent to optimisation level 1.

'1'
     This is the default optimisation level and corresponds to the
     traditional behaviour.  Expressions are reordered so that tests
     based only on the names of files (for example' -name' and '-regex')
     are performed first.

'2'
     Any '-type' or '-xtype' tests are performed after any tests based
     only on the names of files, but before any tests that require
     information from the inode.  On many modern versions of Unix, file
     types are returned by 'readdir()' and so these predicates are
     faster to evaluate than predicates which need to stat the file
     first.

     If you use the '-fstype FOO' predicate and specify a filsystem type
     'FOO' which is not known (that is, present in '/etc/mtab') at the
     time 'find' starts, that predicate is equivalent to '-false'.

'3'
     At this optimisation level, the full cost-based query optimiser is
     enabled.  The order of tests is modified so that cheap (i.e., fast)
     tests are performed first and more expensive ones are performed
     later, if necessary.  Within each cost band, predicates are
     evaluated earlier or later according to whether they are likely to
     succeed or not.  For '-o', predicates which are likely to succeed
     are evaluated earlier, and for '-a', predicates which are likely to
     fail are evaluated earlier.

Next: Find Expressions,  Prev: Optimisation Options,  Up: Invoking find

8.1.4 Debug Options
-------------------

The '-D' option makes 'find' produce diagnostic output.  Much of the
information is useful only for diagnosing problems, and so most people
will not find this option helpful.

   The list of debug options should be comma separated.  Compatibility
of the debug options is not guaranteed between releases of findutils.
For a complete list of valid debug options, see the output of 'find -D
help'.  Valid debug options include:
'help'
     Explain the debugging options.
'tree'
     Show the expression tree in its original and optimised form.
'stat'
     Print messages as files are examined with the stat and lstat system
     calls.  The find program tries to minimise such calls.
'opt'
     Prints diagnostic information relating to the optimisation of the
     expression tree; see the '-O' option.
'rates'
     Prints a summary indicating how often each predicate succeeded or
     failed.

Prev: Debug Options,  Up: Invoking find

8.1.5 Find Expressions
----------------------

The final part of the 'find' command line is a list of expressions.
*Note Primary Index::, for a summary of all of the tests, actions, and
options that the expression can contain.  If the expression is missing,
'-print' is assumed.

