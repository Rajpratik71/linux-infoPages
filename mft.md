File: web2c.info,  Node: mft invocation,  Prev: gftodvi invocation,  Up: Metafont

5.6 MFT: Prettyprinting Metafont source
=======================================

MFT translates a Metafont program into a TeX document suitable for
typesetting, with the aid of TeX macros defined in the file
`mftmac.tex'.  Synopsis:

     mft [OPTION]... MFNAME[.mf]

   MFT searches the usual places for MFNAME (*note Supported file
formats: (kpathsea)Supported file formats.).  To see all the relevant
paths, set the environment variable `KPATHSEA_DEBUG' to `-1' before
running the program.  The output goes to the basename of MFNAME extended
with `.tex', e.g., `mft /wherever/foo.mf' creates `./foo.tex'.

   Line breaks in the input are carried over into the output; moreover,
blank spaces at the beginning of a line are converted to quads of
indentation in the output. Thus, you have full control over the
indentation and line breaks. Each line of input is translated
independently of the others.

   Further control is allowed via Metafont comments: 
   * Metafont comments following a single `%' should be valid TeX
     input.  But Metafont material can be included within vertical bars
     in a comment; this will be translated by MFT as if it were regular
     Metafont code.  For example, a comment like `% |x2r| is the tip of
     the bowl' will be translated into the TeX `% $x_{2r}$ is the ...',
     i.e., the `x2r' is treated as an identifier.

   * `%%' indicates that the remainder of an input line should be copied
     verbatim to the output.  This is typically used to introduce
     additional TeX material at the beginning or an MFT job, e.g. code
     to modify the standard layout or the formatting macros defined in
     `mftmac.tex', or to add a line saying `%%\bye' at the end of the
     job.  (MFT doesn't add this automatically in order to allow
     processing several files produces by MFT in the same TeX job.)

   * `%%% TOKEN1 OTHER-TOKENS' introduces a change in MFT's formatting
     rules; all the OTHER-TOKENS will henceforth be translated
     according to the current conventions for TOKEN1. The tokens must
     be symbolic (i.e., not numeric or string tokens). For example, the
     input line
          %%% addto fill draw filldraw
     says to format the `fill', `draw', and `filldraw' operations of
     plain Metafont just like the primitive token `addto', i.e., in
     boldface type.  Without such reformatting commands, MFT would
     treat `fill' like an ordinary tag or variable name.  In fact, you
     need a `%%%' command even to get parentheses to act like
     delimiters.

   * `%%%%' introduces an MFT comment, i.e., MFT ignores the remainder
     of such a line.

   * Five or more `%' signs should not be used.

   (The above description was edited from `mft.web', written by
D.E. Knuth.)

   The program accepts the following options, as well as the standard
`-help' and `-version' (*note Common options::):
`-change=CHFILE[.ch]'
     Apply the change file CHFILE as with Tangle and Weave (*note
     WEB::).

`-style=MFTFILE[.mft]'
     Read MFTFILE before anything else; a MFT style file typically
     contains only MFT directives as described above.  The default
     style file is named `plain.mft', which defines this properly for
     programs using plain Metafont.  The MFT files is searched along the
     `MFTINPUTS' path; see *note Supported file formats:
     (kpathsea)Supported file formats.

     Other examples of MFT style files are `cmbase.mft', which defines
     formatting rules for the macros defined in `cm.base', and `e.mft',
     which was used in the production of Knuth's Volume E, `Computer
     Modern Typefaces'.

     Using an appropriate MFT style file, it is also possible to
     configure MFT for typesetting MetaPost sources.  However, MFT does
     not search the usual places for MetaPost input files.

   If you use eight-bit characters in the input file, they are passed
on verbatim to the TeX output file; it is up to you to configure TeX to
print these properly.

