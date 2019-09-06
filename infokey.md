File: info-stnd.info,  Node: Invoking infokey,  Next: infokey source format,  Up: Custom Key Bindings

12.1 Invoking `infokey'
=======================

`infokey' compiles a source file (`$HOME/.infokey'(1) by default)
containing Info customizations into a binary format (`$HOME/.info' by
default).  GNU Info reads the binary file at startup to override the
default key bindings and variable definitions.  Synopsis:

     infokey [OPTION...] [INPUT-FILE]

   Besides the standard `--help' and `--version', the only option is
`--output FILE'.  This tells `infokey' to write the binary data to FILE
instead of `$HOME/.info'.

   ---------- Footnotes ----------

   (1) This file is named `_infokey' in the MS-DOS version, and is
looked for in the current directory if `HOME' is undefined.

