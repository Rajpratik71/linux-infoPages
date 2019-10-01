File: coreutils.info,  Node: base64 invocation,  Prev: od invocation,  Up: Output of entire files

3.5 'base64': Transform data into printable data
================================================

'base64' transforms data read from a file, or standard input, into (or
from) base64 encoded form.  The base64 encoded form uses printable ASCII
characters to represent binary data.  Synopses:

     base64 [OPTION]... [FILE]
     base64 --decode [OPTION]... [FILE]

   The base64 encoding expands data to roughly 133% of the original.
The format conforms to RFC 4648
(ftp://ftp.rfc-editor.org/in-notes/rfc4648.txt).

   The program accepts the following options.  Also see *note Common
options::.

'-w COLS'
'--wrap=COLS'
     During encoding, wrap lines after COLS characters.  This must be a
     positive number.

     The default is to wrap after 76 characters.  Use the value 0 to
     disable line wrapping altogether.

'-d'
'--decode'
     Change the mode of operation, from the default of encoding data, to
     decoding data.  Input is expected to be base64 encoded data, and
     the output will be the original data.

'-i'
'--ignore-garbage'
     When decoding, newlines are always accepted.  During decoding,
     ignore unrecognized bytes, to permit distorted data to be decoded.

   An exit status of zero indicates success, and a nonzero value
indicates failure.

