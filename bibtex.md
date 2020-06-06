File: web2c.info,  Node: bibtex invocation,  Next: Basic BibTeX style files,  Up: BibTeX

7.1 BibTeX invocation
=====================

BibTeX creates a printable bibliography (`.bbl') file from references
in a `.aux' file, generally written by TeX or LaTeX.  The `.bbl' file
is then incorporated on a subsequent run.  The basic bibliographic
information comes from `.bib' files, and a BibTeX style (`.bst') file
controls the precise contents of the `.bbl' file.  Synopsis:

     bibtex [OPTION]... AUXFILE[.aux]

The output goes to the basename of AUXFILE extended with `.bbl'; for
example, `bibtex /wherever/foo.aux' creates `./foo.bbl'.  BibTeX also
writes a log file to the basename of AUXFILE extended with `.blg'.

   The names of the `.bib' and `.bst' files are specified in the `.aux'
file as well, via the `\bibliography' and `\bibliographystyle' (La)TeX
macros.  BibTeX searches for `.bib' files using the `BIBINPUTS' and
`TEXBIB' paths, and for `.bst' files using `BSTINPUTS' (*note Supported
file formats: (kpathsea)Supported file formats.).  It does no path
searching for `.aux' files.

   The program accepts the following options, as well as the standard
`-help' and `-version' (*note Common options::):
`-terse'
     Suppress the program banner and progress reports normally output.

`-min-crossrefs=N'
     If at least N (2 by default) bibliography entries refer to another
     entry E via their `crossref' field, include E in the .bbl file,
     even if it was not explicitly referenced in the .aux file. For
     example, E might be a conference proceedings as a whole, with the
     cross-referencing entries being individual articles published in
     the proceedings.  In some circumstances, you may want to avoid
     these automatic inclusions altogether; to do this, make N a
     sufficiently large number.

   See also:
`btxdoc.tex'
     Basic LaTeXable documentation for general BibTeX users.

`btxhak.tex'
     LaTeXable documentation for style designers.

`btxdoc.bib'
     BibTeX database file for the two above documents.

`xampl.bib'
     Example database file with all the standard entry types.

``ftp://ftp.math.utah.edu/pub/tex/bib/''
     A very large `.bib' and `.bst' collection, including references
     for all the standard TeX books and a complete bibliography for
     TUGboat.

