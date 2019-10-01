File: web2c.info,  Node: pktype invocation,  Next: gftype invocation,  Prev: pktogf invocation,  Up: Font utilities

10.4 PKtype: Plain text transliteration of packed fonts
=======================================================

PKtype translates a packed font (PK) bitmap file (as output by GFtoPK,
for example) to a plain text file that humans can read.  It also serves
as a PK-validating program, i.e., if PKtype can read a file, it's
correct.  Synopsis:

     pktype PKNAME.DPI[pk]

   The font PKNAME is searched for in the usual places (*note Glyph
lookup: (kpathsea)Glyph lookup.).  To see all the relevant paths, set
the environment variable `KPATHSEA_DEBUG' to `-1' before running the
program.

   The suffix `pk' is supplied if not already present.  This suffix is
not an extension; no `.' precedes it: for instance, `cmr10.600pk'.

   The translation is written to standard output.

   The only options are `-help' and `-version' (*note Common options::).

   As an example of the output, here is the (abridged) translation of
the letter `K' in `cmr10', as rendered at 600dpi with the mode `ljfour'
from `modes.mf' (available from `ftp://ftp.tug.org/tex/modes.mf').

     955:  Flag byte = 184  Character = 75  Packet length = 174
       Dynamic packing variable = 11
       TFM width = 815562  dx = 4259840
       Height = 57  Width = 57  X-offset = -3  Y-offset = 56
       [2]23(16)17(8)9(25)11(13)7(27)7(16)7(28)4(18)7(28)2(20)7(27)...
       ...
       (14)9(24)12(5)[2]23(13)21

Explanation:

`955'
     The byte position in the file where this character starts.

`Flag byte'
`Dynamic packing variable'
     Related to the packing for this character; see the source code.

`Character'
     The character code, in decimal.

`Packet length'
     The total length of this character definition, in bytes.

`TFM width'
     The device-independent (TFM) width of this character.  It is 2^24
     times the ratio of the true width to the font's design size.

`dx'
     The device-dependent width, in "scaled pixels", i.e., units of
     horizontal pixels times 2^16.

`Height'
`Width'
     The bitmap height and width, in pixels.

`X-offset'
`Y-offset'
     Horizontal and vertical offset from the upper left pixel to the
     reference (origin) pixel for this character, in pixels (right and
     down are positive).  The "reference pixel" is the pixel that
     occupies the unit square in Metafont; the Metafont reference point
     is the lower left hand corner of this pixel. Put another way, the
     x-offset is the negative of the left side bearing; the right side
     bearing is the horizontal escapement minus the bitmap width plus
     the x-offset.

`[2]23(16)...'
     Finally, run lengths of black pixels alternate with parenthesized
     run lengths of white pixels, and brackets indicate a repeated row.

