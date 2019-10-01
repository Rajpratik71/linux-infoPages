File: coreutils.info,  Node: echo invocation,  Next: printf invocation,  Up: Printing text

15.1 'echo': Print a line of text
=================================

'echo' writes each given STRING to standard output, with a space between
each and a newline after the last one.  Synopsis:

     echo [OPTION]... [STRING]...

   Due to shell aliases and built-in 'echo' functions, using an
unadorned 'echo' interactively or in a script may get you different
functionality than that described here.  Invoke it via 'env' (i.e., 'env
echo ...') to avoid interference from the shell.

   The program accepts the following options.  Also see *note Common
options::.  Options must precede operands, and the normally-special
argument '--' has no special meaning and is treated like any other
STRING.

'-n'
     Do not output the trailing newline.

'-e'
     Enable interpretation of the following backslash-escaped characters
     in each STRING:

     '\a'
          alert (bell)
     '\b'
          backspace
     '\c'
          produce no further output
     '\e'
          escape
     '\f'
          form feed
     '\n'
          newline
     '\r'
          carriage return
     '\t'
          horizontal tab
     '\v'
          vertical tab
     '\\'
          backslash
     '\0NNN'
          the eight-bit value that is the octal number NNN (zero to
          three octal digits), if NNN is a nine-bit value, the ninth bit
          is ignored
     '\NNN'
          the eight-bit value that is the octal number NNN (one to three
          octal digits), if NNN is a nine-bit value, the ninth bit is
          ignored
     '\xHH'
          the eight-bit value that is the hexadecimal number HH (one or
          two hexadecimal digits)

'-E'
     Disable interpretation of backslash escapes in each STRING.  This
     is the default.  If '-e' and '-E' are both specified, the last one
     given takes effect.

   If the 'POSIXLY_CORRECT' environment variable is set, then when
'echo''s first argument is not '-n' it outputs option-like arguments
instead of treating them as options.  For example, 'echo -ne hello'
outputs '-ne hello' instead of plain 'hello'.

   POSIX does not require support for any options, and says that the
behavior of 'echo' is implementation-defined if any STRING contains a
backslash or if the first argument is '-n'.  Portable programs can use
the 'printf' command if they need to omit trailing newlines or output
control characters or backslashes.  *Note printf invocation::.

   An exit status of zero indicates success, and a nonzero value
indicates failure.

