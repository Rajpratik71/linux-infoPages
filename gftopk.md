File: web2c.info,  Node: gftopk invocation,  Next: pktogf invocation,  Prev: Font file formats,  Up: Font utilities

10.2 GFtoPK: Generic to packed font conversion
==============================================

GFtoPK converts a generic font (GF) file output by, for example,
Metafont (*note mf invocation::) to a packed font (PK) file.  PK files
are considerably smaller than the corresponding gf files, so they are
generally the bitmap font format of choice.  Some DVI-processing
programs, notably Dvips, only support PK files and not GF files.
Synopsis:

     gftopk [OPTION]... GFNAME.DPI[gf] [PKFILE]

The font GFNAME is searched for in the usual places (*note Glyph
lookup: (kpathsea)Glyph lookup.).  To see all the relevant paths, set
the environment variable `KPATHSEA_DEBUG' to `-1' before running the
program.

   The suffix `gf' is supplied if not already present.  This suffix is
not an extension; no `.' precedes it: for instance, `cmr10.600gf'.

   If PKFILE is not specified, the output is written to the basename of
`GFNAME.DPIpk', e.g., `gftopk /wherever/cmr10.600gf' creates
`./cmr10.600pk'.

   The only options are `--verbose', `--help', and `--version' (*note
Common options::).

