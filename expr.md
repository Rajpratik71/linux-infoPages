File: coreutils.info,  Node: expr invocation,  Prev: test invocation,  Up: Conditions

16.4 'expr': Evaluate expressions
=================================

'expr' evaluates an expression and writes the result on standard output.
Each token of the expression must be a separate argument.

   Operands are either integers or strings.  Integers consist of one or
more decimal digits, with an optional leading '-'.  'expr' converts
anything appearing in an operand position to an integer or a string
depending on the operation being applied to it.

   Strings are not quoted for 'expr' itself, though you may need to
quote them to protect characters with special meaning to the shell,
e.g., spaces.  However, regardless of whether it is quoted, a string
operand should not be a parenthesis or any of 'expr''s operators like
'+', so you cannot safely pass an arbitrary string '$str' to expr merely
by quoting it to the shell.  One way to work around this is to use the
GNU extension '+', (e.g., '+ "$str" = foo'); a more portable way is to
use '" $str"' and to adjust the rest of the expression to take the
leading space into account (e.g., '" $str" = " foo"').

   You should not pass a negative integer or a string with leading '-'
as 'expr''s first argument, as it might be misinterpreted as an option;
this can be avoided by parenthesization.  Also, portable scripts should
not use a string operand that happens to take the form of an integer;
this can be worked around by inserting leading spaces as mentioned
above.

   Operators may be given as infix symbols or prefix keywords.
Parentheses may be used for grouping in the usual manner.  You must
quote parentheses and many operators to avoid the shell evaluating them,
however.

   When built with support for the GNU MP library, 'expr' uses
arbitrary-precision arithmetic; otherwise, it uses native arithmetic
types and may fail due to arithmetic overflow.

   The only options are '--help' and '--version'.  *Note Common
options::.  Options must precede operands.

   Exit status:

     0 if the expression is neither null nor 0,
     1 if the expression is null or 0,
     2 if the expression is invalid,
     3 if an internal error occurred (e.g., arithmetic overflow).

* Menu:

* String expressions::          + : match substr index length
* Numeric expressions::         + - * / %
* Relations for expr::          | & < <= = == != >= >
* Examples of expr::            Examples.

File: coreutils.info,  Node: String expressions,  Next: Numeric expressions,  Up: expr invocation

16.4.1 String expressions
-------------------------

'expr' supports pattern matching and other string operators.  These have
higher precedence than both the numeric and relational operators (in the
next sections).

'STRING : REGEX'
     Perform pattern matching.  The arguments are converted to strings
     and the second is considered to be a (basic, a la GNU 'grep')
     regular expression, with a '^' implicitly prepended.  The first
     argument is then matched against this regular expression.

     If the match succeeds and REGEX uses '\(' and '\)', the ':'
     expression returns the part of STRING that matched the
     subexpression; otherwise, it returns the number of characters
     matched.

     If the match fails, the ':' operator returns the null string if
     '\(' and '\)' are used in REGEX, otherwise 0.

     Only the first '\( ... \)' pair is relevant to the return value;
     additional pairs are meaningful only for grouping the regular
     expression operators.

     In the regular expression, '\+', '\?', and '\|' are operators which
     respectively match one or more, zero or one, or separate
     alternatives.  SunOS and other 'expr''s treat these as regular
     characters.  (POSIX allows either behavior.)  *Note Regular
     Expression Library: (regex)Top, for details of regular expression
     syntax.  Some examples are in *note Examples of expr::.

'match STRING REGEX'
     An alternative way to do pattern matching.  This is the same as
     'STRING : REGEX'.

'substr STRING POSITION LENGTH'
     Returns the substring of STRING beginning at POSITION with length
     at most LENGTH.  If either POSITION or LENGTH is negative, zero, or
     non-numeric, returns the null string.

'index STRING CHARSET'
     Returns the first position in STRING where the first character in
     CHARSET was found.  If no character in CHARSET is found in STRING,
     return 0.

'length STRING'
     Returns the length of STRING.

'+ TOKEN'
     Interpret TOKEN as a string, even if it is a keyword like MATCH or
     an operator like '/'.  This makes it possible to test 'expr length
     + "$x"' or 'expr + "$x" : '.*/\(.\)'' and have it do the right
     thing even if the value of $X happens to be (for example) '/' or
     'index'.  This operator is a GNU extension.  Portable shell scripts
     should use '" $token" : ' \(.*\)'' instead of '+ "$token"'.

   To make 'expr' interpret keywords as strings, you must use the
'quote' operator.

File: coreutils.info,  Node: Numeric expressions,  Next: Relations for expr,  Prev: String expressions,  Up: expr invocation

16.4.2 Numeric expressions
--------------------------

'expr' supports the usual numeric operators, in order of increasing
precedence.  These numeric operators have lower precedence than the
string operators described in the previous section, and higher
precedence than the connectives (next section).

'+ -'
     Addition and subtraction.  Both arguments are converted to
     integers; an error occurs if this cannot be done.

'* / %'
     Multiplication, division, remainder.  Both arguments are converted
     to integers; an error occurs if this cannot be done.

File: coreutils.info,  Node: Relations for expr,  Next: Examples of expr,  Prev: Numeric expressions,  Up: expr invocation

16.4.3 Relations for 'expr'
---------------------------

'expr' supports the usual logical connectives and relations.  These have
lower precedence than the string and numeric operators (previous
sections).  Here is the list, lowest-precedence operator first.

'|'
     Returns its first argument if that is neither null nor zero,
     otherwise its second argument if it is neither null nor zero,
     otherwise 0.  It does not evaluate its second argument if its first
     argument is neither null nor zero.

'&'
     Return its first argument if neither argument is null or zero,
     otherwise 0.  It does not evaluate its second argument if its first
     argument is null or zero.

'< <= = == != >= >'
     Compare the arguments and return 1 if the relation is true, 0
     otherwise.  '==' is a synonym for '='.  'expr' first tries to
     convert both arguments to integers and do a numeric comparison; if
     either conversion fails, it does a lexicographic comparison using
     the character collating sequence specified by the 'LC_COLLATE'
     locale.

File: coreutils.info,  Node: Examples of expr,  Prev: Relations for expr,  Up: expr invocation

16.4.4 Examples of using 'expr'
-------------------------------

Here are a few examples, including quoting for shell metacharacters.

   To add 1 to the shell variable 'foo', in Bourne-compatible shells:

     foo=$(expr $foo + 1)

   To print the non-directory part of the file name stored in '$fname',
which need not contain a '/':

     expr $fname : '.*/\(.*\)' '|' $fname

   An example showing that '\+' is an operator:

     expr aaa : 'a\+'
     => 3

     expr abc : 'a\(.\)c'
     => b
     expr index abcdef cz
     => 3
     expr index index a
     error-> expr: syntax error
     expr index + index a
     => 0

