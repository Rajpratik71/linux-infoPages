File: coreutils.info,  Node: cksum invocation,  Next: md5sum invocation,  Prev: sum invocation,  Up: Summarizing files

6.3 `cksum': Print CRC checksum and byte counts
===============================================

`cksum' computes a cyclic redundancy check (CRC) checksum for each
given FILE, or standard input if none are given or for a FILE of `-'.
Synopsis:

     cksum [OPTION]... [FILE]...

   `cksum' prints the CRC checksum for each file along with the number
of bytes in the file, and the file name unless no arguments were given.

   `cksum' is typically used to ensure that files transferred by
unreliable means (e.g., netnews) have not been corrupted, by comparing
the `cksum' output for the received files with the `cksum' output for
the original files (typically given in the distribution).

   The CRC algorithm is specified by the POSIX standard.  It is not
compatible with the BSD or System V `sum' algorithms (see the previous
section); it is more robust.

   The only options are `--help' and `--version'.  *Note Common
options::.

   An exit status of zero indicates success, and a nonzero value
indicates failure.

