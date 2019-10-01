File: dvips.info,  Node: Invoking afm2tfm,  Next: psfonts.map,  Prev: Making a font available,  Up: PostScript fonts

6.3 Invoking Afm2tfm
====================

The Afm2tfm program converts an AFM file for a PostScript font to a TFM
file and a VPL file for a corresponding virtual font (or, in its
simplest form, to a TFM file for the PostScript font itself).  The
results of the conversion are affected by the command-line options and
especially by the reencodings you can specify with those options.  You
can also obtain special effects such as an oblique font.

   An alternative to Afm2tfm for creating virtual fonts is Alan
Jeffrey's `fontinst' program, available from
`CTAN:fonts/utilities/fontinst' (for CTAN info, *note unixtex.ftp:
(kpathsea)unixtex.ftp.).

* Menu:

* Changing font encodings::     Reencoding with -t, -p, -T.
* Special font effects::        Oblique fonts, small caps, and such.
* Afm2tfm options::             afm2tfm command-line options.

File: dvips.info,  Node: Changing font encodings,  Next: Special font effects,  Up: Invoking afm2tfm

6.3.1 Changing font encodings
-----------------------------

Afm2tfm allows you to specify a different encoding for a PostScript font
(for a general introduction to encodings, *note Encodings::). The `-t'
option changes the TeX encoding, `-p' changes the PostScript encoding,
and `-T' changes both simultaneously, as detailed in the sections below.

* Menu:

* Changing TeX encodings::      Where TeX finds a character.
* Changing PostScript encodings::  Where PostScript finds a character.
* Changing both encodings::     One and the same, simultaneously.
* Reencoding with Afm2tfm::     Problems with the default encoding.
* Encoding file format::        Syntax of an encoding file.

File: dvips.info,  Node: Changing TeX encodings,  Next: Changing PostScript encodings,  Up: Changing font encodings

6.3.1.1 `-t': Changing TeX encodings
....................................

To build a virtual font with Afm2tfm, you specify the `-v' or `-V'
option. You can then specify an encoding for that virtual font with `-t
TEX-ENC'.  (`-t' is ignored if neither `-v' nor `-V' is present.)  Any
ligature and kerning information you specify in TEX-ENC will be used in
the VPL, in addition to the ligature and kerning information from the
AFM file.

   If the AFM file has no entry for a character specified in TEX-ENC,
that character will be omitted from the output VPL.

   The `-t' option is likely to be needed when you have a PostScript
font corresponding to a TeX font other than a normal text font such as
Computer Modern.  For instance, if you have a PostScript font that
contains math symbols, you'd probably want to use the encoding in the
`texmsym.enc' file supplied with Dvips. (For a start; to actually get
usable math fonts, you have to define much more than just an encoding.)

File: dvips.info,  Node: Changing PostScript encodings,  Next: Changing both encodings,  Prev: Changing TeX encodings,  Up: Changing font encodings

6.3.1.2 `-p': Changing PostScript encodings
...........................................

By default, Afm2tfm uses the encoding it finds in the AFM file.  You can
specify a different PostScript encoding with `-p PS-ENC'.  This makes
the raw TFM file (the one output by Afm2tfm) have the encoding
specified in the encoding file PS-ENC.  Any ligature or kern
information specified in PS-ENC is ignored by Afm2tfm, since ligkern
info is always omitted from the raw TFM.

   If you use this option, you must also arrange to download PS-ENC as
part of any document that uses this font.  You do this by adding a line
like the following one to `psfonts.map' (*note psfonts.map::):
     zpopr Optima "MyEncoding ReEncodeFont" <myenc.enc

   Using `-p' is the only way to access characters in a PostScript font
that are neither encoded in the AFM file nor constructed from other
characters.  For instance, Adobe's `Times-Roman' font contains the
extra characters `trademark' and `registered' (among others); these can
only be accessed through such a PostScript reencoding.

   The `8r' base encoding used for the current PostScript font
distribution does do this reencoding, for precisely this reason.

File: dvips.info,  Node: Changing both encodings,  Next: Reencoding with Afm2tfm,  Prev: Changing PostScript encodings,  Up: Changing font encodings

6.3.1.3 `-T': Changing both TeX and PostScript encodings
........................................................

The option `-T ENC-FILE' is equivalent to `-p ENC-FILE -t ENC-FILE'.
If you make regular use of a private non-standard reencoding `-T' is
usually a better idea than the individual options, to avoid unexpected
inconsistencies in mapping otherwise.  An example of when you might use
this option is a dingbats font: when you have a TeX encoding that is
designed to be used with a particular PostScript font.

File: dvips.info,  Node: Reencoding with Afm2tfm,  Next: Encoding file format,  Prev: Changing both encodings,  Up: Changing font encodings

6.3.1.4 Reencoding with Afm2tfm
...............................

The Afm2tfm program creates the TFM and VF files for the virtual font
corresponding to a PostScript font by "reencoding" the PostScript font.
Afm2tfm generates these files from two encodings: one for TeX and one
for PostScript.  The TeX encoding is used to map character numbers to
character names while the PostScript encoding is used to map each
character name to a possibly different number.  In combination, you can
get access to any character of a PostScript font at any position for
TeX typesetting.

   In the default case, when you specify none of the `-t', `-p', or
`-T' options, Afm2tfm uses a default TeX encoding (which mostly
corresponds to the Computer Modern text fonts) and the PostScript
encoding found in the AFM file being read.  The reencoding is also
sometimes called a "remapping".

   For example, the default encodings reencode the acute accent in two
steps: first the default TeX encoding maps the number 19 to the
character name `acute'; then the default PostScript encoding, as found
in the AFM file for an ordinary PostScript font, maps the character
name `acute' to the number 194.  (The PostScript encoding works in
reverse, by looking in the encoding vector for the name and then
yielding the corresponding number.)  The combined mapping of 19 to 194
shows up explicitly in the VF file and also implicitly in the fact that
the properties of PostScript character 194 appear in position 19 of the
TFM file for the virtual font.

   The default encoding of the distributed fonts (e.g., `ptmr.tfm')
mostly follows plain TeX conventions for accents.  The exceptions: the
Hungarian umlaut (which is at position `0x7D' in `cmr10', but position
`0xCD' in `ptmr'); the dot accent (at positions `0x5F' and `0xC7',
respectively); and the Scandinavian A ring `\AA', whose definition
needs different tweaking.  In order to use these accents with
PostScript fonts or in math mode when `\textfont0' is a PostScript
font, you will need to use the following definitions.  These
definitions will not work with the Computer Modern fonts for the
relevant accents.  They are already part of the distributed
`psfonts.sty' for use with LaTeX.

     \def\H#1{{\accent"CD #1}}
     \def\.#1{{\accent"C7 #1}}
     \def\dot{\mathaccent"70C7 }
     \newdimen\aadimen
     \def\AA{\leavevmode\setbox0\hbox{h}\aadimen\ht0
       \advance\aadimen-1ex\setbox0\hbox{A}\rlap{\raise.67\aadimen
       \hbox to \wd0{\hss\char'27\hss}}A}

   As a kind of summary, here are the `CODINGSCHEME's that result from
the various possible choices for reencoding.

default encoding
          (CODINGSCHEME TeX text + AdobeStandardEncoding)

`-p dc.enc'
          (CODINGSCHEME TeX text + DCEncoding)

`-t dc.enc'
          (CODINGSCHEME DCEncoding + AdobeStandardEncoding)

`-T dc.enc'
          (CODINGSCHEME DCEncoding + DCEncoding)


The `CODINGSCHEME' line appears in the VPL file but is ignored by Dvips.

File: dvips.info,  Node: Encoding file format,  Prev: Reencoding with Afm2tfm,  Up: Changing font encodings

6.3.1.5 Encoding file format
............................

Afm2tfm's encoding files have the same format as an encoding vector in a
PostScript font.  Here is a skeletal example:

     % Comments are ignored, unless the first word after the percent sign
     % is `LIGKERN'; see below.
     /MyEncoding [ % exactly 256 entries follow, each with a leading `/'
       /Alpha /Beta /Gamma /Delta ...
       /A /B ... /Z
       ...  /.notdef /xfooaccent /yfooaccent /zfooaccent
     ] def

   These encoding files are downloaded as part of changing the encoding
at the PostScript level (see the previous section).

   Comments, which start with a percent sign and continue until the end
of the line, are ignored unless they start with `LIGKERN' (see below).

   The first non-comment word of the file must start with a forward
slash `/' (i.e., a PostScript literal name) and defines the name of the
encoding.  The next word must be an left bracket `['.  Following that
must be precisely 256 character names; use `/.notdef' for any that you
want to leave undefined.  Then there must be a matching right bracket
`]'.  A final `def' token is optional.  All names are case-sensitive.

   Any ligature or kern information is given as a comment.  If the first
word after the `%' is `LIGKERN', then the entire rest of the line is
parsed for ligature and kern information.  This ligature and kern
information is given in groups of words: each group is terminated by a
space and a semicolon and (unless the semicolon is at the end of a
line) another space.

   In these `LIGKERN' statements, three types of information may be
specified.  These three types are ligature pairs, kerns to ignore, and
the character value of this font's boundary character.

   Throughout a `LIGKERN' statement, the boundary character is
specified as `||'. To set the font's boundary character value for TeX:

     % LIGKERN || = 39 ;

   To indicate a kern to remove, give the names of the two characters
(without the leading slash) separated by `{}', as in `one {} one ;'.
This is intended to be reminiscent of the way you might use `{}' in a
TeX file to turn off ligatures or kerns at a particular location.
Either or both of the character names can be given as `*', which is a
wild card matching any character; thus, all kerns can be removed with
`* {} * ;'.

   To specify a ligature, specify the names of the pair of characters,
followed by the ligature operation (as in Metafont), followed by the
replacing character name.  Either (but not both) of the first two
characters can be `||' to indicate a word boundary.

   The most common operation is `=:' meaning that both characters are
removed and replaced by the third character, but by adding the `|'
character on either side of the `=:', you can retain either or both of
the two leading characters.  In addition, by suffixing the ligature
operation with one or two `>' signs, you can make the ligature scanning
operation skip that many resulting characters before proceeding.  This
works just like in Metafont.  For example, the `fi' ligature is
specified with `f i =: fi ;'.  A more convoluted ligature is `one one
|=:|>> exclam ;' which separates a pair of adjacent `1''s with an
exclamation point, and then skips over two of the resulting characters
before continuing searching for ligatures and kerns.  You cannot give
more >'s than |'s in an ligature operation, so there are a total of
eight possibilities:

     =: |=: |=:> =:| =:|> |=:| |=:|> |=:|>>

   The default set of ligatures and kerns built in to Afm2tfm is:

     % LIGKERN question quoteleft =: questiondown ;
     % LIGKERN exclam quoteleft =: exclamdown ;
     % LIGKERN hyphen hyphen =: endash ; endash hyphen =: emdash ;
     % LIGKERN quoteleft quoteleft =: quotedblleft ;
     % LIGKERN quoteright quoteright =: quotedblright ;
     % LIGKERN space {} * ; * {} space ; 0 {} * ; * {} 0 ;
     % LIGKERN 1 {} * ; * {} 1 ; 2 {} * ; * {} 2 ; 3 {} * ; * {} 3 ;
     % LIGKERN 4 {} * ; * {} 4 ; 5 {} * ; * {} 5 ; 6 {} * ; * {} 6 ;
     % LIGKERN 7 {} * ; * {} 7 ; 8 {} * ; * {} 8 ; 9 {} * ; * {} 9 ;

File: dvips.info,  Node: Special font effects,  Next: Afm2tfm options,  Prev: Changing font encodings,  Up: Invoking afm2tfm

6.3.2 Special font effects
--------------------------

Besides the reencodings described in the previous section, Afm2tfm can
do other manipulations.  (Again, it's best to use the prebuilt fonts
rather than attempting to remake them.)

   `-s SLANT' makes an obliqued variant, as in:

     afm2tfm Times-Roman -s .167 -v ptmro rptmro

This creates `ptmro.vpl' and `rptmro.tfm'.  To use this font, put the
line

     rptmro Times-Roman ".167 SlantFont"

into `psfonts.map'.  Then `rptmro' (our name for the obliqued Times)
will act as if it were a resident font, although it is actually
constructed from Times-Roman via the PostScript routine `SlantFont'
(which will slant everything 1/6 to the right, in this case).

   Similarly, you can get an expanded font with

     afm2tfm Times-Roman -e 1.2 -v ptmrre rptmrre

and by recording the pseudo-resident font 

     rptmrre Times-Roman "1.2 ExtendFont"

in `psfonts.map'.

   You can also create a small caps font with a command such as 

     afm2tfm Times-Roman -V ptmrc rptmrc

This will generate a set of pseudo-small caps mapped into the usual
lowercase positions and scaled down to 0.8 of the normal cap
dimensions.  You can also specify the scaling as something other than
the default 0.8:

     afm2tfm Times-Roman -c 0.7 -V ptmrc rptmrc

   It is unfortunately not possible to increase the width of the small
caps independently of the rest of the font.  If you want a really
professional looking set of small caps, you need to acquire a small caps
font.

   To change the `PaintType' in a font from filled (0) to outlined (2),
you can add `"/PaintType 2 store"' to `psfonts.map', as in the
following:

     rphvrl   Helvetica "/PaintType 2 store"

   Afm2tfm writes to standard output the line you need to add to
`psfonts.map' to use that font, assuming the font is resident in the
printer; if the font is not resident, you must add the `<FILENAME'
command to download the font.  Each identical line only needs to be
specified once in the `psfonts.map' file, even though many different
fonts (small caps variants, or ones with different output encodings)
may be based on it.

File: dvips.info,  Node: Afm2tfm options,  Prev: Special font effects,  Up: Invoking afm2tfm

6.3.3 Afm2tfm options
---------------------

Synopsis:
     afm2tfm [OPTION]... AFMFILE[.afm] [TFMFILE[.tfm]]

   Afm2tfm reads AFMFILE and writes a corresponding (but raw) TFM file.
If TFMFILE is not supplied, the base name of the AFM file is extended
with `.tfm' to get the output filename.

   The simplest example:

     afm2tfm Times-Roman rptmr

The TFM file thus created is "raw" because it omits ligature and kern
information, and does no character remapping; it simply contains the
character information in the AFM file in TFM form, which is the form
that TeX understands.  The characters have the same code in the TFM
file as in the AFM file.  For text fonts, this means printable ASCII
characters will work ok, but little else, because standard PostScript
fonts have a different encoding scheme than the one that plain TeX
expects (*note Encodings::).  Although both schemes agree for the
printable ASCII characters, other characters such as ligatures and
accents vary.  Thus, in practice, it's almost always desirable to create
a virtual font as well with the `-v' or `-V' option.  *Note Making a
font available::.

   The command line options to Afm2tfm:

`-c RATIO'
     See `-V'; overrides the default ratio of 0.8 for the scaling of
     small caps.

`-e RATIO'
     Stretch characters horizontally by RATIO; if less than 1.0, you
     get a condensed font.

`-O'
     Output all character codes in the `vpl' file as octal numbers, not
     names; this is useful for symbol or other special-purpose fonts
     where character names such as `A' have no meaning.

`-p PS-ENC'
     Use PS-ENC for the destination (PostScript) encoding of the font;
     PS-ENC must be mentioned as a header file for the font in
     `psfonts.map'.  *Note Changing PostScript encodings::.

`-s SLANT'
     Slant characters to the right by SLANT.  If SLANT is negative, the
     letters slope to the left (or they might be upright if you start
     with an italic font).

`-t TEX-ENC'
     Use TEX-ENC for the target (TeX) encoding of the font.  Ligature
     and kern information may also be specified in FILE.  FILE is not
     mentioned in `psfonts.map'.

`-T PS-TEX-ENC'
     Use PS-TEX-ENC for both the PostScript and target TeX encodings of
     the font.  Equivalent to `-p FILE -t FILE'.

`-u'
     Use only those characters specified in the TeX encoding, and no
     others.  By default, Afm2tfm tries to include all characters in the
     input font, even those not present in the TeX encoding (it puts
     them into otherwise-unused positions, arbitrarily).

`-v VPL-FILE'
     Output a VPL (virtual property list) file, as well as a TFM file.

`-V VPL-FILE'
     Same as `-v', but the virtual font generated is a pseudo small caps
     font obtained by scaling uppercase letters by 0.8 to typeset
     lowercase. This font handles accented letters and retains proper
     kerning.

