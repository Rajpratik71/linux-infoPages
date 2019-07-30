Next: Regular Expressions,  Prev: Invoking updatedb,  Up: Reference

8.4 Invoking 'xargs'
====================

     xargs [OPTION...] [COMMAND [INITIAL-ARGUMENTS]]

   'xargs' exits with the following status:

0
     if it succeeds
123
     if any invocation of the command exited with status 1-125
124
     if the command exited with status 255
125
     if the command is killed by a signal
126
     if the command cannot be run
127
     if the command is not found
1
     if some other error occurred.

   Exit codes greater than 128 are used by the shell to indicate that a
program died due to a fatal signal.

* Menu:

* xargs options::
* Invoking the shell from xargs::

Next: Invoking the shell from xargs,  Up: Invoking xargs

8.4.1 xargs options
-------------------

'--arg-file=INPUTFILE'
'-a INPUTFILE'
     Read names from the file INPUTFILE instead of standard input.  If
     you use this option, the standard input stream remains unchanged
     when commands are run.  Otherwise, stdin is redirected from
     '/dev/null'.

'--null'
'-0'
     Input file names are terminated by a null character instead of by
     whitespace, and any quotes and backslash characters are not
     considered special (every character is taken literally).  Disables
     the end of file string, which is treated like any other argument.

'--delimiter DELIM'
'-d DELIM'

     Input file names are terminated by the specified character DELIM
     instead of by whitespace, and any quotes and backslash characters
     are not considered special (every character is taken literally).
     Disables the logical end of file marker string, which is treated
     like any other argument.

     The specified delimiter may be a single character, a C-style
     character escape such as '\n', or an octal or hexadecimal escape
     code.  Octal and hexadecimal escape codes are understood as for the
     'printf' command.  Multibyte characters are not supported.

'-E EOF-STR'
'--eof[=EOF-STR]'
'-e[EOF-STR]'

     Set the logical end of file marker string to EOF-STR.  If the
     logical end of file marker string occurs as a line of input, the
     rest of the input is ignored.  If EOF-STR is omitted ('-e') or
     blank (either '-e' or '-E'), there is no logical end of file marker
     string.  The '-e' form of this option is deprecated in favour of
     the POSIX-compliant '-E' option, which you should use instead.  As
     of GNU 'xargs' version 4.2.9, the default behaviour of 'xargs' is
     not to have a logical end of file marker string.  The POSIX
     standard (IEEE Std 1003.1, 2004 Edition) allows this.

     The logical end of file marker string is not treated specially if
     the '-d' or the '-0' options are in effect.  That is, when either
     of these options are in effect, the whole input file will be read
     even if '-E' was used.

'--help'
     Print a summary of the options to 'xargs' and exit.

'-I REPLACE-STR'
'--replace[=REPLACE-STR]'
'-i[REPLACE-STR]'
     Replace occurrences of REPLACE-STR in the initial arguments with
     names read from standard input.  Also, unquoted blanks do not
     terminate arguments; instead, the input is split at newlines only.
     If REPLACE-STR is omitted (omitting it is allowed only for '-i'),
     it defaults to '{}' (like for 'find -exec').  Implies '-x' and '-l
     1'.  The '-i' option is deprecated in favour of the '-I' option.

'-L MAX-LINES'
'--max-lines[=MAX-LINES]'
'-l[MAX-LINES]'
     Use at most MAX-LINES non-blank input lines per command line.  For
     '-l', MAX-LINES defaults to 1 if omitted.  For '-L', the argument
     is mandatory.  Trailing blanks cause an input line to be logically
     continued on the next input line, for the purpose of counting the
     lines.  Implies '-x'.  The '-l' form of this option is deprecated
     in favour of the POSIX-compliant '-L' option.

'--max-args=MAX-ARGS'
'-n MAX-ARGS'
     Use at most MAX-ARGS arguments per command line.  Fewer than
     MAX-ARGS arguments will be used if the size (see the '-s' option)
     is exceeded, unless the '-x' option is given, in which case 'xargs'
     will exit.

'--interactive'
'-p'
     Prompt the user about whether to run each command line and read a
     line from the terminal.  Only run the command line if the response
     starts with 'y' or 'Y'.  Implies '-t'.

'--no-run-if-empty'
'-r'
     If the standard input is completely empty, do not run the command.
     By default, the command is run once even if there is no input.

'--max-chars=MAX-CHARS'
'-s MAX-CHARS'
     Use at most MAX-CHARS characters per command line, including the
     command, initial arguments and any terminating nulls at the ends of
     the argument strings.

'--show-limits'
     Display the limits on the command-line length which are imposed by
     the operating system, 'xargs'' choice of buffer size and the '-s'
     option.  Pipe the input from '/dev/null' (and perhaps specify
     '--no-run-if-empty') if you don't want 'xargs' to do anything.

'--verbose'
'-t'
     Print the command line on the standard error output before
     executing it.

'--version'
     Print the version number of 'xargs' and exit.

'--exit'
'-x'
     Exit if the size (see the '-s' option) is exceeded.

'--max-procs=MAX-PROCS'
'-P MAX-PROCS'
     Run simultaneously up to MAX-PROCS processes at once; the default
     is 1.  If MAX-PROCS is 0, 'xargs' will run as many processes as
     possible simultaneously.  *Note Controlling Parallelism::, for
     information on dynamically controlling parallelism.

'--process-slot-var=ENVIRONMENT-VARIABLE-NAME'
     Set the environment variable ENVIRONMENT-VARIABLE-NAME to a unique
     value in each running child process.  Each value is a decimal
     integer.  Values are reused once child processes exit.  This can be
     used in a rudimentary load distribution scheme, for example.

Prev: xargs options,  Up: Invoking xargs

8.4.2 Invoking the shell from xargs
-----------------------------------

Normally, 'xargs' will exec the command you specified directly, without
invoking a shell.  This is normally the behaviour one would want.  It's
somewhat more efficient and avoids problems with shell metacharacters,
for example.  However, sometimes it is necessary to manipulate the
environment of a command before it is run, in a way that 'xargs' does
not directly support.

   Invoking a shell from 'xargs' is a good way of performing such
manipulations.  However, some care must be taken to prevent problems,
for example unwanted interpretation of shell metacharacters.

   This command moves a set of files into an archive directory:

     find /foo -maxdepth 1 -atime +366 -exec mv {} /archive \;

   However, this will only move one file at a time.  We cannot in this
case use '-exec ... +' because the matched file names are added at the
end of the command line, while the destination directory would need to
be specified last.  We also can't use 'xargs' in the obvious way for the
same reason.  One way of working around this problem is to make use of
the special properties of GNU 'mv'; it has a '-t' option that allows the
target directory to be specified before the list of files to be moved.
However, while this technique works for GNU 'mv', it doesn't solve the
more general problem.

   Here is a more general technique for solving this problem:

     find /foo -maxdepth 1 -atime +366 -print0 |
     xargs -r0 sh -c 'mv "$@" /archive' move

   Here, a shell is being invoked.  There are two shell instances to
think about.  The first is the shell which launches the 'xargs' command
(this might be the shell into which you are typing, for example).  The
second is the shell launched by 'xargs' (in fact it will probably launch
several, one after the other, depending on how many files need to be
archived).  We'll refer to this second shell as a subshell.

   Our example uses the '-c' option of 'sh'.  Its argument is a shell
command to be executed by the subshell.  Along with the rest of that
command, the $@ is enclosed by single quotes to make sure it is passed
to the subshell without being expanded by the parent shell.  It is also
enclosed with double quotes so that the subshell will expand '$@'
correctly even if one of the file names contains a space or newline.

   The subshell will use any non-option arguments as positional
parameters (that is, in the expansion of '$@').  Because 'xargs'
launches the 'sh -c' subshell with a list of files, those files will end
up as the expansion of '$@'.

   You may also notice the 'move' at the end of the command line.  This
is used as the value of '$0' by the subshell.  We include it because
otherwise the name of the first file to be moved would be used instead.
If that happened it would not be included in the subshell's expansion of
'$@', and so it wouldn't actually get moved.

   Another reason to use the 'sh -c' construct could be to perform
redirection:

     find /usr/include -name '*.h' | xargs grep -wl mode_t |
     xargs -r sh -c 'exec emacs "$@" < /dev/tty' Emacs

   Notice that we use the shell builtin 'exec' here.  That's simply
because the subshell needs to do nothing once Emacs has been invoked.
Therefore instead of keeping a 'sh' process around for no reason, we
just arrange for the subshell to exec Emacs, saving an extra process
creation.

   Sometimes, though, it can be helpful to keep the shell process
around:

     find /foo -maxdepth 1 -atime +366 -print0 |
     xargs -r0 sh -c 'mv "$@" /archive || exit 255' move

   Here, the shell will exit with status 255 if any 'mv' failed.  This
causes 'xargs' to stop immediately.

