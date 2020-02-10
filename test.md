Next: expr invocation,  Prev: true invocation,  Up: Conditions

16.3 ‘test’: Check file types and compare values
================================================

‘test’ returns a status of 0 (true) or 1 (false) depending on the
evaluation of the conditional expression EXPR.  Each part of the
expression must be a separate argument.

   ‘test’ has file status checks, string operators, and numeric
comparison operators.

   ‘test’ has an alternate form that uses opening and closing square
brackets instead a leading ‘test’.  For example, instead of ‘test -d /’,
you can write ‘[ -d / ]’.  The square brackets must be separate
arguments; for example, ‘[-d /]’ does not have the desired effect.
Since ‘test EXPR’ and ‘[ EXPR ]’ have the same meaning, only the former
form is discussed below.

   Synopses:

     test EXPRESSION
     test
     [ EXPRESSION ]
     [ ]
     [ OPTION

   Due to shell aliases and built-in ‘test’ functions, using an
unadorned ‘test’ interactively or in a script may get you different
functionality than that described here.  Invoke it via ‘env’ (i.e., ‘env
test ...’) to avoid interference from the shell.

   If EXPRESSION is omitted, ‘test’ returns false.  If EXPRESSION is a
single argument, ‘test’ returns false if the argument is null and true
otherwise.  The argument can be any string, including strings like ‘-d’,
‘-1’, ‘--’, ‘--help’, and ‘--version’ that most other programs would
treat as options.  To get help and version information, invoke the
commands ‘[ --help’ and ‘[ --version’, without the usual closing
brackets.  *Note Common options::.

   Exit status:

     0 if the expression is true,
     1 if the expression is false,
     2 if an error occurred.

* Menu:

* File type tests::             -[bcdfhLpSt]
* Access permission tests::     -[gkruwxOG]
* File characteristic tests::   -e -s -nt -ot -ef
* String tests::                -z -n = == !=
* Numeric tests::               -eq -ne -lt -le -gt -ge
* Connectives for test::        ! -a -o

Next: Access permission tests,  Up: test invocation

16.3.1 File type tests
----------------------

These options test for particular types of files.  (Everything’s a file,
but not all files are the same!)

‘-b FILE’
     True if FILE exists and is a block special device.

‘-c FILE’
     True if FILE exists and is a character special device.

‘-d FILE’
     True if FILE exists and is a directory.

‘-f FILE’
     True if FILE exists and is a regular file.

‘-h FILE’
‘-L FILE’
     True if FILE exists and is a symbolic link.  Unlike all other
     file-related tests, this test does not dereference FILE if it is a
     symbolic link.

‘-p FILE’
     True if FILE exists and is a named pipe.

‘-S FILE’
     True if FILE exists and is a socket.

‘-t FD’
     True if FD is a file descriptor that is associated with a terminal.

Next: File characteristic tests,  Prev: File type tests,  Up: test invocation

16.3.2 Access permission tests
------------------------------

These options test for particular access permissions.

‘-g FILE’
     True if FILE exists and has its set-group-ID bit set.

‘-k FILE’
     True if FILE exists and has its “sticky” bit set.

‘-r FILE’
     True if FILE exists and read permission is granted.

‘-u FILE’
     True if FILE exists and has its set-user-ID bit set.

‘-w FILE’
     True if FILE exists and write permission is granted.

‘-x FILE’
     True if FILE exists and execute permission is granted (or search
     permission, if it is a directory).

‘-O FILE’
     True if FILE exists and is owned by the current effective user ID.

‘-G FILE’
     True if FILE exists and is owned by the current effective group ID.

Next: String tests,  Prev: Access permission tests,  Up: test invocation

16.3.3 File characteristic tests
--------------------------------

These options test other file characteristics.

‘-e FILE’
     True if FILE exists.

‘-s FILE’
     True if FILE exists and has a size greater than zero.

‘FILE1 -nt FILE2’
     True if FILE1 is newer (according to modification date) than FILE2,
     or if FILE1 exists and FILE2 does not.

‘FILE1 -ot FILE2’
     True if FILE1 is older (according to modification date) than FILE2,
     or if FILE2 exists and FILE1 does not.

‘FILE1 -ef FILE2’
     True if FILE1 and FILE2 have the same device and inode numbers,
     i.e., if they are hard links to each other.

Next: Numeric tests,  Prev: File characteristic tests,  Up: test invocation

16.3.4 String tests
-------------------

These options test string characteristics.  You may need to quote STRING
arguments for the shell.  For example:

     test -n "$V"

   The quotes here prevent the wrong arguments from being passed to
‘test’ if ‘$V’ is empty or contains special characters.

‘-z STRING’
     True if the length of STRING is zero.

‘-n STRING’
‘STRING’
     True if the length of STRING is nonzero.

‘STRING1 = STRING2’
     True if the strings are equal.

‘STRING1 == STRING2’
     True if the strings are equal (synonym for =).

‘STRING1 != STRING2’
     True if the strings are not equal.

Next: Connectives for test,  Prev: String tests,  Up: test invocation

16.3.5 Numeric tests
--------------------

Numeric relational operators.  The arguments must be entirely numeric
(possibly negative), or the special expression ‘-l STRING’, which
evaluates to the length of STRING.

‘ARG1 -eq ARG2’
‘ARG1 -ne ARG2’
‘ARG1 -lt ARG2’
‘ARG1 -le ARG2’
‘ARG1 -gt ARG2’
‘ARG1 -ge ARG2’
     These arithmetic binary operators return true if ARG1 is equal,
     not-equal, less-than, less-than-or-equal, greater-than, or
     greater-than-or-equal than ARG2, respectively.

   For example:

     test -1 -gt -2 && echo yes
     ⇒ yes
     test -l abc -gt 1 && echo yes
     ⇒ yes
     test 0x100 -eq 1
     error→ test: integer expression expected before -eq

Prev: Numeric tests,  Up: test invocation

16.3.6 Connectives for ‘test’
-----------------------------

Note it’s preferred to use shell logical primitives rather than these
logical connectives internal to ‘test’, because an expression may become
ambiguous depending on the expansion of its parameters.

   For example, this becomes ambiguous when ‘$1’ is set to ‘'!'’ and
‘$2’ to the empty string ‘''’:

     test "$1" -a "$2"

   and should be written as:

     test "$1" && test "$2"

   Note the shell logical primitives also benefit from short circuit
operation, which can be significant for file attribute tests.

‘! EXPR’
     True if EXPR is false.  ‘!’ has lower precedence than all parts of
     EXPR.  Note ‘!’ needs to be specified to the left of a binary
     expression, I.e., ‘'!' 1 -gt 2’ rather than ‘1 '!' -gt 2’.  Also
     ‘!’ is often a shell special character and is best used quoted.

‘EXPR1 -a EXPR2’
     True if both EXPR1 and EXPR2 are true.  ‘-a’ is left associative,
     and has a higher precedence than ‘-o’.

‘EXPR1 -o EXPR2’
     True if either EXPR1 or EXPR2 is true.  ‘-o’ is left associative.

