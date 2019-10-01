File: web2c.info,  Node: pktogf invocation,  Next: pktype invocation,  Prev: gftopk invocation,  Up: Font utilities

10.3 PKtoGF: Packed to generic font conversion
==============================================

PKtoGF converts a packed font (PK) file to a generic font (GF) file.
Since PK format is much more compact than GF format, the most likely
reason to do this is to run GFtype (*note gftype invocation::) on the
result, so you can see the bitmap images.  Also, a few old utility
programs do not support PK format.  Synopsis:

     pktogf [OPTION]... PKNAME.DPI[pk] [GFFILE]

The font PKNAME is searched for in the usual places (*note Glyph
lookup: (kpathsea)Glyph lookup.).  To see all the relevant paths, set
the environment variable `KPATHSEA_DEBUG' to `-1' before running the
program.

   The suffix `pk' is supplied if not already present.  This suffix is
not an extension; no `.' precedes it: for instance, `cmr10.600pk'.

   If GFFILE is not specified, the output is written to the basename of
`PKNAME.DPIgf', e.g., `pktogf /wherever/cmr10.600pk' creates
`./cmr10.600gf'.

   The only options are `--verbose', `--help', and `--version' (*note
Common options::).

