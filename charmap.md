File: *manpages*,  Node: charmap,  Up: (dir)

CHARMAP(5)                 Linux Programmer's Manual                CHARMAP(5)



NAME
       charmap - character set description file

DESCRIPTION
       A  character set description (charmap) defines all available characters
       and their encodings in a character set.  localedef(1) can use  charmaps
       to create locale variants for different character sets.

   Syntax
       The charmap file starts with a header that may consist of the following
       keywords:

       <code_set_name>
              is followed by the name of the character map.

       <comment_char>
              is followed by a character that will  be  used  as  the  comment
              character  for  the rest of the file.  It defaults to the number
              sign (#).

       <escape_char>
              is followed by a character that should be  used  as  the  escape
              character  for  the  rest  of  the  file to mark characters that
              should be interpreted in a special  way.   It  defaults  to  the
              backslash (\).

       <mb_cur_max>
              is followed by the maximum number of bytes for a character.  The
              default value is 1.

       <mb_cur_min>
              is followed by the minimum number  of  bytes  for  a  character.
              This value must be less than or equal than <mb_cur_max>.  If not
              specified, it defaults to <mb_cur_max>.

       The character set definition section starts with the keyword CHARMAP in
       the first column.

       The  following  lines may have one of the two following forms to define
       the character set:

       <character> byte-sequence comment
              This form defines exactly one character and its  byte  sequence,
              comment being optional.

       <character>..<character> byte-sequence comment
              This  form defines a character range and its byte sequence, com‐
              ment being optional.

       The character set definition section ends with the string END CHARMAP.

       The character set definition section may optionally be  followed  by  a
       section to define widths of characters.

       The  WIDTH_DEFAULT  keyword can be used to define the default width for
       all characters not explicitly listed.  The default character  width  is
       1.

       The  width  section  for  individual characters starts with the keyword
       WIDTH in the first column.

       The following lines may have one of the two following forms  to  define
       the widths of the characters:

       <character> width
              This form defines the width of exactly one character.

       <character>...<character> width
              This form defines the width for all the characters in the range.

       The width definition section ends with the string END WIDTH.

FILES
       /usr/share/i18n/charmaps
              Usual default character map path.

CONFORMING TO
       POSIX.2.

EXAMPLE
       The Euro sign is defined as follows in the UTF-8 charmap:

       <U20AC>     /xe2/x82/xac EURO SIGN

SEE ALSO
       iconv(1), locale(1), localedef(1), locale(5), charsets(7)



GNU                               2014-07-08                        CHARMAP(5)
CHARMAP(5)                     Linux User Manual                    CHARMAP(5)



NAME
       charmap - character symbols to define character encodings

DESCRIPTION
       A character set description (charmap) defines a character set of avail‐
       able characters and their  encodings.   All  supported  character  sets
       should have the portable character set as a proper subset.

   Syntax
       The  charmap file starts with a header, that may consist of the follow‐
       ing keywords:

       <codeset>
              is followed by the name of the codeset.

       <mb_cur_max>
              is followed by the max number of bytes for  a  multibyte-charac‐
              ter.   Multibyte  characters  are  currently not supported.  The
              default value is 1.

       <mb_cur_min>
              is followed by the min number of bytes for  a  character.   This
              value  must be less or equal than mb_cur_max.  If not specified,
              it defaults to mb_cur_max.

       <escape_char>
              is followed by a character that should be used  as  the  escape-
              character  for  the  rest  of  the  file to mark characters that
              should be interpreted in a special  way.   It  defaults  to  the
              backslash ( \ ).

       <comment_char>
              is  followed  by  a  character that will be used as the comment-
              character for the rest of the file.  It defaults to  the  number
              sign ( # ).

       The charmap-definition itself starts with the keyword CHARMAP in column
       1.

       The following lines may have one of the two following forms  to  define
       the character-encodings:

       <symbolic-name> <encoding> <comments>
              This form defines exactly one character and its encoding.

       <symbolic-name>...<symbolic-name> <encoding> <comments>
              This  form  defines a couple of characters.  This is useful only
              for multibyte-characters, which are currently not implemented.

       The last line in a charmap-definition file must contain END CHARMAP.

   Symbolic names
       A symbolic name for a character contains only characters of the  porta‐
       ble character set.  The name itself is enclosed between angle brackets.
       Characters following an <escape_char> are interpreted  as  itself;  for
       example,  the  sequence <\\\>> represents the symbolic name \> enclosed
       in angle brackets.

   Character encoding
       The encoding may be in each of the following three forms:

       <escape_char>d<number>
              with a decimal number

       <escape_char>x<number>
              with a hexadecimal number

       <escape_char><number>
              with an octal number.

FILES
       /usr/share/i18n/charmaps/*

CONFORMING TO
       POSIX.2.

SEE ALSO
       locale(1), localedef(1), localeconv(3), setlocale(3), locale(5)

COLOPHON
       This page is part of release 3.53 of the Linux  man-pages  project.   A
       description  of  the project, and information about reporting bugs, can
       be found at http://www.kernel.org/doc/man-pages/.



                                  1994-11-28                        CHARMAP(5)
