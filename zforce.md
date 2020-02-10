Next: Sample,  Prev: Top,  Up: Top

1 Overview
**********

'gzip' reduces the size of the named files using Lempel-Ziv coding
(LZ77).  Whenever possible, each file is replaced by one with the
extension '.gz', while keeping the same ownership modes, access and
modification times.  (The default extension is '-gz' for VMS, 'z' for
MSDOS, OS/2 FAT and Atari.)  If no files are specified or if a file name
is "-", the standard input is compressed to the standard output.  'gzip'
will only attempt to compress regular files.  In particular, it will
ignore symbolic links.

   If the new file name is too long for its file system, 'gzip'
truncates it.  'gzip' attempts to truncate only the parts of the file
name longer than 3 characters.  (A part is delimited by dots.)  If the
name consists of small parts only, the longest parts are truncated.  For
example, if file names are limited to 14 characters, gzip.msdos.exe is
compressed to gzi.msd.exe.gz.  Names are not truncated on systems which
do not have a limit on file name length.

   By default, 'gzip' keeps the original file name and time stamp in the
compressed file.  These are used when decompressing the file with the
'-N' option.  This is useful when the compressed file name was truncated
or when the time stamp was not preserved after a file transfer.
However, due to limitations in the current 'gzip' file format,
fractional seconds are discarded.  Also, time stamps must fall within
the range 1970-01-01 00:00:00 through 2106-02-07 06:28:15 UTC, and hosts
whose operating systems use 32-bit time stamps are further restricted to
time stamps no later than 2038-01-19 03:14:07 UTC.  The upper bounds
assume the typical case where leap seconds are ignored.

   Compressed files can be restored to their original form using 'gzip
-d' or 'gunzip' or 'zcat'.  If the original name saved in the compressed
file is not suitable for its file system, a new name is constructed from
the original one to make it legal.

   'gunzip' takes a list of files on its command line and replaces each
file whose name ends with '.gz', '.z' '-gz', '-z', or '_z' (ignoring
case) and which begins with the correct magic number with an
uncompressed file without the original extension.  'gunzip' also
recognizes the special extensions '.tgz' and '.taz' as shorthands for
'.tar.gz' and '.tar.Z' respectively.  When compressing, 'gzip' uses the
'.tgz' extension if necessary instead of truncating a file with a '.tar'
extension.

   'gunzip' can currently decompress files created by 'gzip', 'zip',
'compress' or 'pack'.  The detection of the input format is automatic.
When using the first two formats, 'gunzip' checks a 32 bit CRC (cyclic
redundancy check).  For 'pack', 'gunzip' checks the uncompressed length.
The 'compress' format was not designed to allow consistency checks.
However 'gunzip' is sometimes able to detect a bad '.Z' file.  If you
get an error when uncompressing a '.Z' file, do not assume that the '.Z'
file is correct simply because the standard 'uncompress' does not
complain.  This generally means that the standard 'uncompress' does not
check its input, and happily generates garbage output.  The SCO
'compress -H' format (LZH compression method) does not include a CRC but
also allows some consistency checks.

   Files created by 'zip' can be uncompressed by 'gzip' only if they
have a single member compressed with the 'deflation' method.  This
feature is only intended to help conversion of 'tar.zip' files to the
'tar.gz' format.  To extract a 'zip' file with a single member, use a
command like 'gunzip <foo.zip' or 'gunzip -S .zip foo.zip'.  To extract
'zip' files with several members, use 'unzip' instead of 'gunzip'.

   'zcat' is identical to 'gunzip -c'.  'zcat' uncompresses either a
list of files on the command line or its standard input and writes the
uncompressed data on standard output.  'zcat' will uncompress files that
have the correct magic number whether they have a '.gz' suffix or not.

   'gzip' uses the Lempel-Ziv algorithm used in 'zip' and PKZIP.  The
amount of compression obtained depends on the size of the input and the
distribution of common substrings.  Typically, text such as source code
or English is reduced by 60-70%.  Compression is generally much better
than that achieved by LZW (as used in 'compress'), Huffman coding (as
used in 'pack'), or adaptive Huffman coding ('compact').

   Compression is always performed, even if the compressed file is
slightly larger than the original.  The worst case expansion is a few
bytes for the 'gzip' file header, plus 5 bytes every 32K block, or an
expansion ratio of 0.015% for large files.  Note that the actual number
of used disk blocks almost never increases.  'gzip' normally preserves
the mode, ownership and time stamps of files when compressing or
decompressing.

   The 'gzip' file format is specified in P. Deutsch, GZIP file format
specification version 4.3, Internet RFC 1952
(http://www.ietf.org/rfc/rfc1952.txt) (May 1996).  The 'zip' deflation
format is specified in P. Deutsch, DEFLATE Compressed Data Format
Specification version 1.3, Internet RFC 1951
(http://www.ietf.org/rfc/rfc1951.txt) (May 1996).

