File: binutils.info,  Node: ranlib,  Next: size,  Prev: objdump,  Up: Top

5 ranlib
********

     ranlib [`--plugin' NAME] [`-DhHvVt'] ARCHIVE

   `ranlib' generates an index to the contents of an archive and stores
it in the archive.  The index lists each symbol defined by a member of
an archive that is a relocatable object file.

   You may use `nm -s' or `nm --print-armap' to list this index.

   An archive with such an index speeds up linking to the library and
allows routines in the library to call each other without regard to
their placement in the archive.

   The GNU `ranlib' program is another form of GNU `ar'; running
`ranlib' is completely equivalent to executing `ar -s'.  *Note ar::.

`-h'
`-H'
`--help'
     Show usage information for `ranlib'.

`-v'
`-V'
`--version'
     Show the version number of `ranlib'.

`-D'
     Operate in _deterministic_ mode.  The symbol map archive member's
     header will show zero for the UID, GID, and timestamp.  When this
     option is used, multiple runs will produce identical output files.

     If `binutils' was configured with
     `--enable-deterministic-archives', then this mode is on by
     default.  It can be disabled with the `-U' option, described below.

`-t'
     Update the timestamp of the symbol map of an archive.

`-U'
     Do _not_ operate in _deterministic_ mode.  This is the inverse of
     the `-D' option, above: the archive index will get actual UID,
     GID, timestamp, and file mode values.

     If `binutils' was configured _without_
     `--enable-deterministic-archives', then this mode is on by default.


