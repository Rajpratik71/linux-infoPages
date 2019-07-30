Next: od invocation,  Prev: tac invocation,  Up: Output of entire files

3.3 ‘nl’: Number lines and write files
======================================

‘nl’ writes each FILE (‘-’ means standard input), or standard input if
none are given, to standard output, with line numbers added to some or
all of the lines.  Synopsis:

     nl [OPTION]... [FILE]...

   ‘nl’ decomposes its input into (logical) pages; by default, the line
number is reset to 1 at the top of each logical page.  ‘nl’ treats all
of the input files as a single document; it does not reset line numbers
or logical pages between files.

   A logical page consists of three sections: header, body, and footer.
Any of the sections can be empty.  Each can be numbered in a different
style from the others.

   The beginnings of the sections of logical pages are indicated in the
input file by a line containing exactly one of these delimiter strings:

‘\:\:\:’
     start of header;
‘\:\:’
     start of body;
‘\:’
     start of footer.

   The two characters from which these strings are made can be changed
from ‘\’ and ‘:’ via options (see below), but the pattern and length of
each string cannot be changed.

   A section delimiter is replaced by an empty line on output.  Any text
that comes before the first section delimiter string in the input file
is considered to be part of a body section, so ‘nl’ treats a file that
contains no section delimiters as a single body section.

   The program accepts the following options.  Also see *note Common
options::.

‘-b STYLE’
‘--body-numbering=STYLE’
     Select the numbering style for lines in the body section of each
     logical page.  When a line is not numbered, the current line number
     is not incremented, but the line number separator character is
     still prepended to the line.  The styles are:

     ‘a’
          number all lines,
     ‘t’
          number only nonempty lines (default for body),
     ‘n’
          do not number lines (default for header and footer),
     ‘pBRE’
          number only lines that contain a match for the basic regular
          expression BRE.  *Note Regular Expressions: (grep)Regular
          Expressions.

‘-d CD’
‘--section-delimiter=CD’
     Set the section delimiter characters to CD; default is ‘\:’.  If
     only C is given, the second remains ‘:’.  (Remember to protect ‘\’
     or other metacharacters from shell expansion with quotes or extra
     backslashes.)

‘-f STYLE’
‘--footer-numbering=STYLE’
     Analogous to ‘--body-numbering’.

‘-h STYLE’
‘--header-numbering=STYLE’
     Analogous to ‘--body-numbering’.

‘-i NUMBER’
‘--line-increment=NUMBER’
     Increment line numbers by NUMBER (default 1).

‘-l NUMBER’
‘--join-blank-lines=NUMBER’
     Consider NUMBER (default 1) consecutive empty lines to be one
     logical line for numbering, and only number the last one.  Where
     fewer than NUMBER consecutive empty lines occur, do not number
     them.  An empty line is one that contains no characters, not even
     spaces or tabs.

‘-n FORMAT’
‘--number-format=FORMAT’
     Select the line numbering format (default is ‘rn’):

     ‘ln’
          left justified, no leading zeros;
     ‘rn’
          right justified, no leading zeros;
     ‘rz’
          right justified, leading zeros.

‘-p’
‘--no-renumber’
     Do not reset the line number at the start of a logical page.

‘-s STRING’
‘--number-separator=STRING’
     Separate the line number from the text line in the output with
     STRING (default is the TAB character).

‘-v NUMBER’
‘--starting-line-number=NUMBER’
     Set the initial line number on each logical page to NUMBER (default
     1).

‘-w NUMBER’
‘--number-width=NUMBER’
     Use NUMBER characters for line numbers (default 6).

   An exit status of zero indicates success, and a nonzero value
indicates failure.

