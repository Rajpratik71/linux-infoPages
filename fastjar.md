Next: Invoking grepjar,  Prev: Top,  Up: Top

1 Invoking fastjar
******************

`fastjar' is an implementation of Sun's jar utility that comes with the
JDK, written entirely in C, and runs in a fraction of the time while
being feature compatible.

   If any file is a directory then it is processed recursively.  The
manifest file name and the archive file name needs to be specified in
the same order the `-m' and `-f' flags are specified.

   Exactly one of the following actions must be specified:

`-c'
     Create new archive.

`-t'
     List table of contents for archive.

`-x'
     Extract named (or all) files from archive.

`-u'
     Update existing archive.


   The following parameters are optional:

`-@'
     Read the names of the files to add to the archive from stdin.  This
     option is supported only in combination with `-c' or `-u'.  Non
     standard option added in the GCC version.

`-C DIRECTORY'
     Change to the DIRECTORY and include the following file.

`-E'
     Prevent fastjar from reading the content of a directory when
     specifying one (and instead relying on the provided list of files
     to populate the archive with regard to the directory entry). Non
     standard option added in the GCC version.

`-M'
     Do not create a manifest file for the entries.

`-i'
     Generate an index of the packages in this jar and its Class-Path.

`-J'
     All options starting with `-J' are ignored.

`-0'
     Store only; use no ZIP compression.

`-V'
`--version'
     Display version information.

`-f ARCHIVE'
     Specify archive file name.

`-m MANIFEST'
     Include manifest information from specified MANIFEST file.

`-v'
     Generate verbose output on standard output.


   Parameters of the form `@'FILE are considered to be names of files,
and are expanded with the contents of the file.

   All remaining options are considered to be names of files.

