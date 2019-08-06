File: coreutils.info,  Node: fmt invocation,  Next: pr invocation,  Up: Formatting file contents

4.1 ‘fmt’: Reformat paragraph text
==================================

‘fmt’ fills and joins lines to produce output lines of (at most) a given
number of characters (75 by default).  Synopsis:

     fmt [OPTION]... [FILE]...

   ‘fmt’ reads from the specified FILE arguments (or standard input if
none are given), and writes to standard output.

   By default, blank lines, spaces between words, and indentation are
preserved in the output; successive input lines with different
indentation are not joined; tabs are expanded on input and introduced on
output.

   ‘fmt’ prefers breaking lines at the end of a sentence, and tries to
avoid line breaks after the first word of a sentence or before the last
word of a sentence.  A “sentence break” is defined as either the end of
a paragraph or a word ending in any of ‘.?!’, followed by two spaces or
end of line, ignoring any intervening parentheses or quotes.  Like TeX,
‘fmt’ reads entire “paragraphs” before choosing line breaks; the
algorithm is a variant of that given by Donald E. Knuth and Michael F.
Plass in “Breaking Paragraphs Into Lines”, ‘Software—Practice &
Experience’ 11, 11 (November 1981), 1119–1184.

   The program accepts the following options.  Also see *note Common
options::.

‘-c’
‘--crown-margin’
     “Crown margin” mode: preserve the indentation of the first two
     lines within a paragraph, and align the left margin of each
     subsequent line with that of the second line.

‘-t’
‘--tagged-paragraph’
     “Tagged paragraph” mode: like crown margin mode, except that if
     indentation of the first line of a paragraph is the same as the
     indentation of the second, the first line is treated as a one-line
     paragraph.

‘-s’
‘--split-only’
     Split lines only.  Do not join short lines to form longer ones.
     This prevents sample lines of code, and other such “formatted” text
     from being unduly combined.

‘-u’
‘--uniform-spacing’
     Uniform spacing.  Reduce spacing between words to one space, and
     spacing between sentences to two spaces.

‘-WIDTH’
‘-w WIDTH’
‘--width=WIDTH’
     Fill output lines up to WIDTH characters (default 75 or GOAL plus
     10, if GOAL is provided).

‘-g GOAL’
‘--goal=GOAL’
     ‘fmt’ initially tries to make lines GOAL characters wide.  By
     default, this is 7% shorter than WIDTH.

‘-p PREFIX’
‘--prefix=PREFIX’
     Only lines beginning with PREFIX (possibly preceded by whitespace)
     are subject to formatting.  The prefix and any preceding whitespace
     are stripped for the formatting and then re-attached to each
     formatted output line.  One use is to format certain kinds of
     program comments, while leaving the code unchanged.

   An exit status of zero indicates success, and a nonzero value
indicates failure.

