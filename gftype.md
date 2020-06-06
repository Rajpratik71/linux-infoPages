File: web2c.info,  Node: gftype invocation,  Next: tftopl invocation,  Prev: pktype invocation,  Up: Font utilities

10.5 GFtype: Plain text transliteration of generic fonts
========================================================

GFtype translates a generic font (GF) bitmap file (as output by
Metafont, for example) to a plain text file that humans can read.  It
also serves as a GF-validating program, i.e., if GFtype can read a file,
it's correct.  Synopsis:

     gftype [OPTION]... GFNAME.DPI[gf]

   The font GFNAME is searched for in the usual places (*note Glyph
lookup: (kpathsea)Glyph lookup.).  To see all the relevant paths, set
the environment variable `KPATHSEA_DEBUG' to `-1' before running the
program.

   The suffix `gf' is supplied if not already present.  This suffix is
not an extension; no `.' precedes it: for instance, `cmr10.600gf'.

   The translation is written to standard output.

   The program accepts the following options, as well as the standard
`-help' and `-version' (*note Common options::):
`-images'
     Show the characters' bitmaps using asterisks and spaces.

`-mnemonics'
     Translate all commands in the GF file.

   As an example of the output, here is the (abrdiged) translation of
the letter `K' in `cmr10', as rendered at 600dpi with the mode `ljfour'
from `modes.mf' (available from `ftp://ftp.tug.org/tex/modes.mf'), with
both `-mnemonics' and `-images' enabled.

   GFtype outputs the information about a character in two places: a
main definition and a one-line summary at the end. We show both.  Here
is the main definition:

     2033: beginning of char 75: 3<=m<=60 0<=n<=56
     (initially n=56) paint (0)24(12)20
     2043: newrow 0 (n=55) paint 24(12)20
     2047: newrow 0 (n=54) paint 24(12)20
     2051: newrow 0 (n=53) paint 24(12)20
     2055: newrow 7 (n=52) paint 10(21)13
     2059: newrow 8 (n=51) paint 8(23)9
     ...
     2249: newrow 8 (n=5) paint 8(23)11
     2253: newrow 7 (n=4) paint 10(22)12
     2257: newrow 0 (n=3) paint 24(11)22
     2261: newrow 0 (n=2) paint 24(11)22
     2265: newrow 0 (n=1) paint 24(11)22
     2269: newrow 0 (n=0) paint 24(11)22
     2273: eoc
     .<--This pixel's lower left corner is at (3,57) in METAFONT coordinates
     ************************            ********************
     ************************            ********************
     ************************            ********************
     ************************            ********************
            **********                     *************
             ********                       *********
     ...
             ********                       ***********
            **********                      ************
     ************************           **********************
     ************************           **********************
     ************************           **********************
     ************************           **********************
     .<--This pixel's upper left corner is at (3,0) in METAFONT coordinates

Explanation:

`2033'
`2043'
`...'
     The byte position in the file where each GF command starts.

`beginning of char 75'
     The character code, in decimal.

`3<=m<=60 0<=n<=56'
     The character's bitmap lies between 3 and 60 (inclusive)
     horizontally, and between 0 and 56 (inclusive) vertically. (m is a
     column position and n is a row position.)  Thus, 3 is the left side
     bearing.  The right side bearing is the horizontal escapement
     (given below) minus the maximum m.

`(initially n=56) paint (0)24(12)20'
     The first row of pixels: 0 white pixels, 24 black pixels, 12 white
     pixels, etc.

`newrow 0 (n=55) paint 24(12)20'
     The second row of pixels, with zero leading white pixels on the
     row.

`eoc'
     The end of the main character definition.


   Here is the GF postamble information that GFtype outputs at the end:

     Character 75: dx 4259840 (65), width 815562 (64.57289), loc 2033

   Explanation:

`dx'
     The device-dependent width, in "scaled pixels", i.e., units of
     horizontal pixels times 2^16.  The `(65)' is simply the same number
     rounded.  If the vertical escapement is nonzero, it would appear
     here as a `dy' value.

`width'
     The device-independent (TFM) width of this character.  It is 2^24
     times the ratio of the true width to the font's design size.  The
     `64.57289' is the same number converted to pixels.

`loc'
     The byte position in the file where this character starts.


