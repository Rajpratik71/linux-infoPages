File: web2c.info,  Node: mf invocation,  Next: Initial Metafont,  Up: Metafont

5.1 `mf' invocation
===================

Metafont (usually invoked as `mf') reads character definitions
specified in the Metafont programming language, and outputs the
corresponding font.  This section merely describes the options available
in the Web2c implementation.  For a complete description of the Metafont
language, see `The Metafontbook' (*note References::).

   Metafont processes its command line and determines its memory dump
(base) file in a way exactly analogous to MetaPost and TeX (*note tex
invocation::, and *note Memory dumps::).  Synopses:

     mf [OPTION]... [MFNAME[.mf]] [MF-COMMANDS]
     mf [OPTION]... \FIRST-LINE
     mf [OPTION]... &BASE ARGS

   Most commonly, a Metafont invocation looks like this:
     mf '\mode:=MODE; mag:=MAGNIFICATION; input MFNAME'
   (The single quotes avoid unwanted interpretation by the shell.)

   Metafont searches the usual places for the main input file MFNAME
(*note Supported file formats: (kpathsea)Supported file formats.),
extending MFNAME with `.mf' if necessary.  To see all the relevant
paths, set the environment variable `KPATHSEA_DEBUG' to `-1' before
running the program.  By default, Metafont runs an external program
named `mktexmf' to create any nonexistent Metafont source files you
input.  You can disable this at configure-time or runtime (*note mktex
configuration: (kpathsea)mktex configuration.).  This is mostly for the
sake of the EC fonts, which can be generated at any size.

   Metafont writes the main GF output to the file `BASEMFNAME.NNNgf',
where NNN is the font resolution in pixels per inch, and BASEMFNAME is
the basename of MFNAME, or `mfput' if no input file was specified.  A
GF file contains bitmaps of the actual character shapes.  Usually GF
files are converted immediately to PK files with GFtoPK (*note gftopk
invocation::), since PK files contain equivalent information, but are
more compact.  (Metafont output in GF format rather than PK for only
historical reasons.)

   Metafont also usually writes a metric file in TFM format to
`BASEMFNAME.tfm'.  A TFM file contains character dimensions, kerns, and
ligatures, and spacing parameters.  TeX reads only this .tfm file, not
the GF file.

   The MODE in the example command above is a name referring to a
device definition (*note Modes::); for example, `localfont' or
`ljfour'.  These device definitions must generally be precompiled into
the base file.  If you leave this out, the default is `proof' mode, as
stated in `The Metafontbook', in which Metafont outputs at a resolution
of 2602dpi; this is usually not what you want.  The remedy is simply to
assign a different mode--`localfont', for example.

   The MAGNIFICATION assignment in the example command above is a
magnification factor; for example, if the device is 600dpi and you
specify `mag:=2', Metafont will produce output at 1200dpi.  Very often,
the MAGNIFICATION is an expression such as `magstep(.5)', corresponding
to a TeX "magstep", which are factors of 1.2 * sqrt(2).

   After running Metafont, you can use the font in a TeX document as
usual.  For example:
     \font\myfont = newfont
     \myfont Now I am typesetting in my new font (minimum hamburgers).

   The program accepts the following options, as well as the standard
`-help' and `-version' (*note Common options::):
`-[no]-file-line-error'
`-fmt=FMTNAME'
`-halt-on-error'
`-ini'
`-interaction=STRING'
`-jobname=STRING'
`-kpathsea-debug=NUMBER'
`-[no]parse-first-line'
`-output-directory'
`-progname=STRING'
`-recorder'
`-translate-file=TCXFILE'
`-8bit'
     These options are common to TeX, Metafont, and MetaPost.  *Note
     Common options::.

`-mktex=FILETYPE'
`-no-mktex=FILETYPE'
     Turn on or off the `mktex' script associated with FILETYPE.  The
     only value that makes sense for FILETYPE is `mf'.

