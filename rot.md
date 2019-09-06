TRANSFORMER(1)                                              BSD General Commands Manual                                             TRANSFORMER(1)

NAME
     xor — apply bytes to the pipeline using XOR
     rot — apply bytes to the pipeline using ROT
     rol — apply bytes to the pipeline using ROL
     caesar — apply bytes to the pipeline using Caesar's Cipher

SYNOPSIS
     <transform> {-h | -v}
     <transform> [-u] [-x] BYTE [BYTE ...]
     <transform> [-u] -s STRING [STRING ...]

DESCRIPTION
     The basic concept for this utility is to apply a set of bytes, repeatedly, to a stream of input.

     The available options are as follows:

     -h      usage information
     -v      the program's version
     -x      explicitly interpret bytes as hexadecimal digits
     -s      use a string of characters as the byte source
     -u      undo - reverse the transform (this is ignored for xor)
     BYTE [BYTE ...]
             a list of bytes to apply to the input stream
     STRING [STRING ...]
             use every character in every given string as the byte mask

IMPLEMENTATION NOTES
     The application of the key bytes is accomplished using one of the following transforms:

     ┌───────┬──────────────────────┬───────┬─────────────┬──────────────┐
     │Name   │ Description          │ Subj  │ Argument    │ Undo         │
     ├───────┼──────────────────────┼───────┼─────────────┼──────────────┤
     │xor    │ bitwise exclusive OR │ bytes │ int [0-255] │ N/A          │
     │rot    │ rotate left          │ bits  │ int [0-7]   │ rotate right │
     │rol    │ rotate (-)           │ bytes │ int [0-255] │ rotate (+)   │
     │caesar │ shift (+)            │ alpha │ int [0-26]  │ shift (-)    │
     └───────┴──────────────────────┴───────┴─────────────┴──────────────┘
EXAMPLES
     As a filter with the hexadecimal bytes [0x20, 0x2f] applied to the input stream using xor.  The bytes are applied repeatedly until the end-
     of-file (i.e., [0x20, 0x2f, 0x20, 0x2f, ...]).
           $ ... | xor -x 20 2f | ...

     As a filter with a string of characters used as a byte source (i.e., "key" becomes [0x6b, 0x65, 0x79, ...]).
           $ ... | xor -s "key" | ...

SEE ALSO
     hdng(1), unhex(1)

AUTHORS
     Zephyr <zephyr@dirtbags.net>,
     pi-rho <pi-rho@tyr.cx>

BUGS
     Bugs may be submitted at ⟨https://bugs.launchpad.net/netre-tools⟩

Network RE Toolkit 1.1337                                        February 1, 2013                                        Network RE Toolkit 1.1337
tcl::transform::rot(3tcl)                                Reflected/virtual channel support                               tcl::transform::rot(3tcl)

__________________________________________________________________________________________________________________________________________________

NAME
       tcl::transform::rot - rot-encryption

SYNOPSIS
       package require Tcl  8.6

       package require tcl::transform::core  ?1?

       package require tcl::transform::rot  ?1?

       ::tcl::transform::rot chan key

__________________________________________________________________________________________________________________________________________________

DESCRIPTION
       The  tcl::transform::rot  package provides a command creating a channel transformation which performs primitive encryption (on writing) and
       decryption (on reading) on the alphabetic characters. The algorithm is the Caesar-cipher, a specific variant of which is rot13.

       A related transformations in this module is tcl::transform::otp.

       The internal TclOO class implementing the transform handler is a sub-class of the tcl::transform::core framework.

API
       ::tcl::transform::rot chan key
              This command creates a rot encryption transformation on top of the channel chan and returns its handle.

              The "key" specifies how far characters are rotated in the alphabet, and is wrapped to the range "0...25".

              Note that this transformation affects only bytes in the ranges ASCII 65...90, and 97...122, i.e. the upper-  and  lower-case  alpha‐
              betic characters, i.e. "A...Z" and "a...z". All other bytes are passed through unchanged.

BUGS, IDEAS, FEEDBACK
       This  document,  and  the  package  it  describes,  will  undoubtedly  contain bugs and other problems.  Please report such in the category
       virtchannel of the Tcllib Trackers [http://core.tcl.tk/tcllib/reportlist].  Please also report any ideas for enhancements you may have  for
       either package and/or documentation.

KEYWORDS
       caesar  cipher,  channel  transformation,  cipher,  decryption, encryption, reflected channel, rot, rot13, tip 230, transformation, virtual
       channel

CATEGORY
       Channels

COPYRIGHT
       Copyright (c) 2009 Andreas Kupries <andreas_kupries@users.sourceforge.net>

tcllib                                                                   1                                               tcl::transform::rot(3tcl)
