File: coreutils.info,  Node: shuf invocation,  Next: uniq invocation,  Prev: sort invocation,  Up: Operating on sorted files

7.2 'shuf': Shuffling text
==========================

'shuf' shuffles its input by outputting a random permutation of its
input lines.  Each output permutation is equally likely.  Synopses:

     shuf [OPTION]... [FILE]
     shuf -e [OPTION]... [ARG]...
     shuf -i LO-HI [OPTION]...

   'shuf' has three modes of operation that affect where it obtains its
input lines.  By default, it reads lines from standard input.  The
following options change the operation mode:

'-e'
'--echo'
     Treat each command-line operand as an input line.

'-i LO-HI'
'--input-range=LO-HI'
     Act as if input came from a file containing the range of unsigned
     decimal integers LO...HI, one per line.

   'shuf''s other options can affect its behavior in all operation
modes:

'-n LINES'
'--head-count=COUNT'
     Output at most COUNT lines.  By default, all input lines are
     output.

'-o OUTPUT-FILE'
'--output=OUTPUT-FILE'
     Write output to OUTPUT-FILE instead of standard output.  'shuf'
     reads all input before opening OUTPUT-FILE, so you can safely
     shuffle a file in place by using commands like 'shuf -o F <F' and
     'cat F | shuf -o F'.

'--random-source=FILE'
     Use FILE as a source of random data used to determine which
     permutation to generate.  *Note Random sources::.

'-r'
'--repeat'
     Repeat output values, that is, select with replacement.  With this
     option the output is not a permutation of the input; instead, each
     output line is randomly chosen from all the inputs.  This option is
     typically combined with '--head-count'; if '--head-count' is not
     given, 'shuf' repeats indefinitely.

'-z'
'--zero-terminated'
     Delimit items with a zero byte rather than a newline (ASCII LF).
     I.e., treat input as items separated by ASCII NUL and terminate
     output items with ASCII NUL. This option can be useful in
     conjunction with 'perl -0' or 'find -print0' and 'xargs -0' which
     do the same in order to reliably handle arbitrary file names (even
     those containing blanks or other special characters).

   For example:

     shuf <<EOF
     A man,
     a plan,
     a canal:
     Panama!
     EOF

might produce the output

     Panama!
     A man,
     a canal:
     a plan,

Similarly, the command:

     shuf -e clubs hearts diamonds spades

might output:

     clubs
     diamonds
     spades
     hearts

and the command 'shuf -i 1-4' might output:

     4
     2
     1
     3

The above examples all have four input lines, so 'shuf' might produce
any of the twenty-four possible permutations of the input.  In general,
if there are N input lines, there are N!  (i.e., N factorial, or N * (N
- 1) * ... * 1) possible output permutations.

To output 50 random numbers each in the range 0 through 9, use:

     shuf -r -n 50 -i 0-9

To simulate 100 coin flips, use:

     shuf -r -n 100 -e Head Tail

   An exit status of zero indicates success, and a nonzero value
indicates failure.

