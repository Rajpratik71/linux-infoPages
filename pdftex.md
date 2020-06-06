File: texinfo,  Node: PDF Output,  Next: Obtaining TeX,  Prev: Cropmarks and Magnification,  Up: Hardcopy

21.15 PDF Output
================

The simplest way to generate PDF output from Texinfo source is to run
the convenience script 'texi2pdf' (or 'pdftexi2dvi'); this executes the
'texi2dvi' script with the '--pdf' option (*note Format with
texi2dvi::).  If for some reason you want to process the document by
hand, you can run the 'pdftex' program instead of plain 'tex'.  That is,
run 'pdftex foo.texi' instead of 'tex foo.texi'.

  "PDF" stands for 'Portable Document Format'.  It was invented by Adobe
Systems some years ago for document interchange, based on their
PostScript language.  Related links:

   * GNU GV, a Ghostscript-based PDF reader
     (http://www.gnu.org/software/gv/).  (It can also preview PostScript
     documents.)

   * A freely available standalone PDF reader
     (http://www.foolabs.com/xpdf/) for the X window system.

   * PDF definition
     (http://partners.adobe.com/asn/acrobat/sdk/public/docs/).

  At present, Texinfo does not provide '@ifpdf' or '@pdf' commands as
for the other output formats, since PDF documents contain many internal
links that would be hard or impossible to get right at the Texinfo
source level.

  PDF files require special software to be displayed, unlike the plain
ASCII formats (Info, HTML) that Texinfo supports.  They also tend to be
much larger than the DVI files output by TeX by default.  Nevertheless,
a PDF file does define an actual typeset document in a self-contained
file, so it has its place.

