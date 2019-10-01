File: web2c.info,  Node: gftodvi invocation,  Next: mft invocation,  Prev: Online Metafont graphics,  Up: Metafont

5.5 GFtoDVI: Character proofs of fonts
======================================

GFtoDVI makes "proof sheets" from a GF bitmap file as output by, for
example, Metafont (*note Metafont::).  This is an indispensable aid for
font designers or Metafont hackers.  Synopsis:

     gftodvi [OPTION]... GFNAME[gf]

   The font GFNAME is searched for in the usual places (*note Glyph
lookup: (kpathsea)Glyph lookup.).  To see all the relevant paths, set
the environment variable `KPATHSEA_DEBUG' to `-1' before running the
program.

   The suffix `gf' is supplied if not already present.  This suffix is
not an extension, no `.' precedes it; for instance, `cmr10.600gf'.

   The output filename is the basename of GFNAME extended with `.dvi',
e.g., `gftodvi /wherever/foo.600gf' creates `./foo.dvi'.

   The characters from GFNAME appear one per page in the DVI output,
with labels, titles, and annotations, as specified in Appendix H
(Hardcopy Proofs) of `The Metafontbook'.

   GFtoDVI uses several fonts besides GFNAME itself:

   * "gray font" (default `gray'): for the pixels that actually make up
     the character.  Simply using black is not right, since then labels,
     key points, and other information could not be shown.

   * "title font" (default `cmr8'): for the header information at the
     top of each output page.

   * "label font" (default `cmtt10'): for the labels on key points of
     the figure.

   * "slant font" (no default): for diagonal lines, which are otherwise
     simulated using horizontal and vertical rules.

   To change the default fonts, you must use `special' commands in your
Metafont source file, typically via commands like `slantfont slantlj4'.
There is no default slant font since no one printer is suitable as a
default.  You can make your own by copying one of the existing files,
such as `.../fonts/source/public/misc/slantlj4.mf' and then running
`mf' on it.

   For testing purposes, you may it useful to run `mf-nowin rtest' (hit
RETURN when it stops) to get a `gf' file of a thorn glyph.  Or use `mf'
instead of `mf-nowin' to have the glyph(s) displayed on the screen.
After that, `gftodvi rtest.2602gf' should produce `rtest.dvi', which
you process as usual.

   The program accepts the following option, as well as the standard
`-verbose', `-help', and `-version' (*note Common options::):

`-overflow-label-offset=POINTS'
     Typeset the so-called overflow labels, if any, POINTS TeX points
     from the right edge of the character bounding box.  The default is
     a little over two inches (ten million scaled points, to be
     precise).  Overflow equations are used to locate coordinates when
     their actual position is too crowded with other information.

