File: coreutils.info,  Node: tr invocation,  Next: expand invocation,  Up: Operating on characters

9.1 ‘tr’: Translate, squeeze, and/or delete characters
======================================================

Synopsis:

     tr [OPTION]... SET1 [SET2]

   ‘tr’ copies standard input to standard output, performing one of the
following operations:

   • translate, and optionally squeeze repeated characters in the
     result,
   • squeeze repeated characters,
   • delete characters,
   • delete characters, then squeeze repeated characters from the
     result.

   The SET1 and (if given) SET2 arguments define ordered sets of
characters, referred to below as SET1 and SET2.  These sets are the
characters of the input that ‘tr’ operates on.  The ‘--complement’
(‘-c’, ‘-C’) option replaces SET1 with its complement (all of the
characters that are not in SET1).

   Currently ‘tr’ fully supports only single-byte characters.
Eventually it will support multibyte characters; when it does, the ‘-C’
option will cause it to complement the set of characters, whereas ‘-c’
will cause it to complement the set of values.  This distinction will
matter only when some values are not characters, and this is possible
only in locales using multibyte encodings when the input contains
encoding errors.

   The program accepts the ‘--help’ and ‘--version’ options.  *Note
Common options::.  Options must precede operands.

   An exit status of zero indicates success, and a nonzero value
indicates failure.

* Menu:

* Character sets::              Specifying sets of characters.
* Translating::                 Changing one set of characters to another.
* Squeezing and deleting::      Removing characters.

File: coreutils.info,  Node: Character sets,  Next: Translating,  Up: tr invocation

9.1.1 Specifying sets of characters
-----------------------------------

The format of the SET1 and SET2 arguments resembles the format of
regular expressions; however, they are not regular expressions, only
lists of characters.  Most characters simply represent themselves in
these strings, but the strings can contain the shorthands listed below,
for convenience.  Some of them can be used only in SET1 or SET2, as
noted below.

Backslash escapes

     The following backslash escape sequences are recognized:

     ‘\a’
          Control-G.
     ‘\b’
          Control-H.
     ‘\f’
          Control-L.
     ‘\n’
          Control-J.
     ‘\r’
          Control-M.
     ‘\t’
          Control-I.
     ‘\v’
          Control-K.
     ‘\OOO’
          The 8-bit character with the value given by OOO, which is 1 to
          3 octal digits.  Note that ‘\400’ is interpreted as the
          two-byte sequence, ‘\040’ ‘0’.
     ‘\\’
          A backslash.

     While a backslash followed by a character not listed above is
     interpreted as that character, the backslash also effectively
     removes any special significance, so it is useful to escape ‘[’,
     ‘]’, ‘*’, and ‘-’.

Ranges

     The notation ‘M-N’ expands to all of the characters from M through
     N, in ascending order.  M should collate before N; if it doesn’t,
     an error results.  As an example, ‘0-9’ is the same as
     ‘0123456789’.

     GNU ‘tr’ does not support the System V syntax that uses square
     brackets to enclose ranges.  Translations specified in that format
     sometimes work as expected, since the brackets are often
     transliterated to themselves.  However, they should be avoided
     because they sometimes behave unexpectedly.  For example, ‘tr -d
     '[0-9]'’ deletes brackets as well as digits.

     Many historically common and even accepted uses of ranges are not
     portable.  For example, on EBCDIC hosts using the ‘A-Z’ range will
     not do what most would expect because ‘A’ through ‘Z’ are not
     contiguous as they are in ASCII.  If you can rely on a POSIX
     compliant version of ‘tr’, then the best way to work around this is
     to use character classes (see below).  Otherwise, it is most
     portable (and most ugly) to enumerate the members of the ranges.

Repeated characters

     The notation ‘[C*N]’ in SET2 expands to N copies of character C.
     Thus, ‘[y*6]’ is the same as ‘yyyyyy’.  The notation ‘[C*]’ in
     STRING2 expands to as many copies of C as are needed to make SET2
     as long as SET1.  If N begins with ‘0’, it is interpreted in octal,
     otherwise in decimal.

Character classes

     The notation ‘[:CLASS:]’ expands to all of the characters in the
     (predefined) class CLASS.  The characters expand in no particular
     order, except for the ‘upper’ and ‘lower’ classes, which expand in
     ascending order.  When the ‘--delete’ (‘-d’) and
     ‘--squeeze-repeats’ (‘-s’) options are both given, any character
     class can be used in SET2.  Otherwise, only the character classes
     ‘lower’ and ‘upper’ are accepted in SET2, and then only if the
     corresponding character class (‘upper’ and ‘lower’, respectively)
     is specified in the same relative position in SET1.  Doing this
     specifies case conversion.  The class names are given below; an
     error results when an invalid class name is given.

     ‘alnum’
          Letters and digits.
     ‘alpha’
          Letters.
     ‘blank’
          Horizontal whitespace.
     ‘cntrl’
          Control characters.
     ‘digit’
          Digits.
     ‘graph’
          Printable characters, not including space.
     ‘lower’
          Lowercase letters.
     ‘print’
          Printable characters, including space.
     ‘punct’
          Punctuation characters.
     ‘space’
          Horizontal or vertical whitespace.
     ‘upper’
          Uppercase letters.
     ‘xdigit’
          Hexadecimal digits.

Equivalence classes

     The syntax ‘[=C=]’ expands to all of the characters that are
     equivalent to C, in no particular order.  Equivalence classes are a
     relatively recent invention intended to support non-English
     alphabets.  But there seems to be no standard way to define them or
     determine their contents.  Therefore, they are not fully
     implemented in GNU ‘tr’; each character’s equivalence class
     consists only of that character, which is of no particular use.

File: coreutils.info,  Node: Translating,  Next: Squeezing and deleting,  Prev: Character sets,  Up: tr invocation

9.1.2 Translating
-----------------

‘tr’ performs translation when SET1 and SET2 are both given and the
‘--delete’ (‘-d’) option is not given.  ‘tr’ translates each character
of its input that is in SET1 to the corresponding character in SET2.
Characters not in SET1 are passed through unchanged.  When a character
appears more than once in SET1 and the corresponding characters in SET2
are not all the same, only the final one is used.  For example, these
two commands are equivalent:

     tr aaa xyz
     tr a z

   A common use of ‘tr’ is to convert lowercase characters to uppercase.
This can be done in many ways.  Here are three of them:

     tr abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLMNOPQRSTUVWXYZ
     tr a-z A-Z
     tr '[:lower:]' '[:upper:]'

But note that using ranges like ‘a-z’ above is not portable.

   When ‘tr’ is performing translation, SET1 and SET2 typically have the
same length.  If SET1 is shorter than SET2, the extra characters at the
end of SET2 are ignored.

   On the other hand, making SET1 longer than SET2 is not portable;
POSIX says that the result is undefined.  In this situation, BSD ‘tr’
pads SET2 to the length of SET1 by repeating the last character of SET2
as many times as necessary.  System V ‘tr’ truncates SET1 to the length
of SET2.

   By default, GNU ‘tr’ handles this case like BSD ‘tr’.  When the
‘--truncate-set1’ (‘-t’) option is given, GNU ‘tr’ handles this case
like the System V ‘tr’ instead.  This option is ignored for operations
other than translation.

   Acting like System V ‘tr’ in this case breaks the relatively common
BSD idiom:

     tr -cs A-Za-z0-9 '\012'

because it converts only zero bytes (the first element in the complement
of SET1), rather than all non-alphanumerics, to newlines.

By the way, the above idiom is not portable because it uses ranges, and
it assumes that the octal code for newline is 012.  Assuming a POSIX
compliant ‘tr’, here is a better way to write it:

     tr -cs '[:alnum:]' '[\n*]'

File: coreutils.info,  Node: Squeezing and deleting,  Prev: Translating,  Up: tr invocation

9.1.3 Squeezing repeats and deleting
------------------------------------

When given just the ‘--delete’ (‘-d’) option, ‘tr’ removes any input
characters that are in SET1.

   When given just the ‘--squeeze-repeats’ (‘-s’) option and not
translating, ‘tr’ replaces each input sequence of a repeated character
that is in SET1 with a single occurrence of that character.

   When given both ‘--delete’ and ‘--squeeze-repeats’, ‘tr’ first
performs any deletions using SET1, then squeezes repeats from any
remaining characters using SET2.

   The ‘--squeeze-repeats’ option may also be used when translating, in
which case ‘tr’ first performs translation, then squeezes repeats from
any remaining characters using SET2.

   Here are some examples to illustrate various combinations of options:

   • Remove all zero bytes:

          tr -d '\0'

   • Put all words on lines by themselves.  This converts all
     non-alphanumeric characters to newlines, then squeezes each string
     of repeated newlines into a single newline:

          tr -cs '[:alnum:]' '[\n*]'

   • Convert each sequence of repeated newlines to a single newline.
     I.e., delete blank lines:

          tr -s '\n'

   • Find doubled occurrences of words in a document.  For example,
     people often write “the the” with the repeated words separated by a
     newline.  The Bourne shell script below works first by converting
     each sequence of punctuation and blank characters to a single
     newline.  That puts each “word” on a line by itself.  Next it maps
     all uppercase characters to lower case, and finally it runs ‘uniq’
     with the ‘-d’ option to print out only the words that were
     repeated.

          #!/bin/sh
          cat -- "$@" \
            | tr -s '[:punct:][:blank:]' '[\n*]' \
            | tr '[:upper:]' '[:lower:]' \
            | uniq -d

   • Deleting a small set of characters is usually straightforward.  For
     example, to remove all ‘a’s, ‘x’s, and ‘M’s you would do this:

          tr -d axM

     However, when ‘-’ is one of those characters, it can be tricky
     because ‘-’ has special meanings.  Performing the same task as
     above but also removing all ‘-’ characters, we might try ‘tr -d
     -axM’, but that would fail because ‘tr’ would try to interpret ‘-a’
     as a command-line option.  Alternatively, we could try putting the
     hyphen inside the string, ‘tr -d a-xM’, but that wouldn’t work
     either because it would make ‘tr’ interpret ‘a-x’ as the range of
     characters ‘a’...‘x’ rather than the three.  One way to solve the
     problem is to put the hyphen at the end of the list of characters:

          tr -d axM-

     Or you can use ‘--’ to terminate option processing:

          tr -d -- -axM

     More generally, use the character class notation ‘[=c=]’ with ‘-’
     (or any other character) in place of the ‘c’:

          tr -d '[=-=]axM'

     Note how single quotes are used in the above example to protect the
     square brackets from interpretation by a shell.

