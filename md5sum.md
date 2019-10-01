File: coreutils.info,  Node: md5sum invocation,  Next: sha1sum invocation,  Prev: cksum invocation,  Up: Summarizing files

6.4 'md5sum': Print or check MD5 digests
========================================

'md5sum' computes a 128-bit checksum (or "fingerprint" or
"message-digest") for each specified FILE.

   Note: The MD5 digest is more reliable than a simple CRC (provided by
the 'cksum' command) for detecting accidental file corruption, as the
chances of accidentally having two files with identical MD5 are
vanishingly small.  However, it should not be considered secure against
malicious tampering: although finding a file with a given MD5
fingerprint is considered infeasible at the moment, it is known how to
modify certain files, including digital certificates, so that they
appear valid when signed with an MD5 digest.  For more secure hashes,
consider using SHA-2.  *Note sha2 utilities::.

   If a FILE is specified as '-' or if no files are given 'md5sum'
computes the checksum for the standard input.  'md5sum' can also
determine whether a file and checksum are consistent.  Synopsis:

     md5sum [OPTION]... [FILE]...

   For each FILE, 'md5sum' outputs the MD5 checksum, a flag indicating
binary or text input mode, and the file name.  If FILE contains a
backslash or newline, the line is started with a backslash, and each
problematic character in the file name is escaped with a backslash,
making the output unambiguous even in the presence of arbitrary file
names.  If FILE is omitted or specified as '-', standard input is read.

   The program accepts the following options.  Also see *note Common
options::.

'-b'
'--binary'
     Treat each input file as binary, by reading it in binary mode and
     outputting a '*' flag.  This is the inverse of '--text'.  On
     systems like GNU that do not distinguish between binary and text
     files, this option merely flags each input mode as binary: the MD5
     checksum is unaffected.  This option is the default on systems like
     MS-DOS that distinguish between binary and text files, except for
     reading standard input when standard input is a terminal.

'-c'
'--check'
     Read file names and checksum information (not data) from each FILE
     (or from stdin if no FILE was specified) and report whether the
     checksums match the contents of the named files.  The input to this
     mode of 'md5sum' is usually the output of a prior,
     checksum-generating run of 'md5sum'.  Each valid line of input
     consists of an MD5 checksum, a binary/text flag, and then a file
     name.  Binary mode is indicated with '*', text with ' ' (space).
     For each such line, 'md5sum' reads the named file and computes its
     MD5 checksum.  Then, if the computed message digest does not match
     the one on the line with the file name, the file is noted as having
     failed the test.  Otherwise, the file passes the test.  By default,
     for each valid line, one line is written to standard output
     indicating whether the named file passed the test.  After all
     checks have been performed, if there were any failures, a warning
     is issued to standard error.  Use the '--status' option to inhibit
     that output.  If any listed file cannot be opened or read, if any
     valid line has an MD5 checksum inconsistent with the associated
     file, or if no valid line is found, 'md5sum' exits with nonzero
     status.  Otherwise, it exits successfully.

'--quiet'
     This option is useful only when verifying checksums.  When
     verifying checksums, don't generate an 'OK' message per
     successfully checked file.  Files that fail the verification are
     reported in the default one-line-per-file format.  If there is any
     checksum mismatch, print a warning summarizing the failures to
     standard error.

'--status'
     This option is useful only when verifying checksums.  When
     verifying checksums, don't generate the default one-line-per-file
     diagnostic and don't output the warning summarizing any failures.
     Failures to open or read a file still evoke individual diagnostics
     to standard error.  If all listed files are readable and are
     consistent with the associated MD5 checksums, exit successfully.
     Otherwise exit with a status code indicating there was a failure.

'--tag'
     Output BSD style checksums, which indicate the checksum algorithm
     used.  As a GNU extension, file names with problematic characters
     are escaped as described above, with the same escaping indicator of
     '\' at the start of the line, being used.  The '--tag' option
     implies binary mode, and is disallowed with '--text' mode as
     supporting that would unnecessarily complicate the output format,
     while providing little benefit.

'-t'
'--text'
     Treat each input file as text, by reading it in text mode and
     outputting a ' ' flag.  This is the inverse of '--binary'.  This
     option is the default on systems like GNU that do not distinguish
     between binary and text files.  On other systems, it is the default
     for reading standard input when standard input is a terminal.  This
     mode is never defaulted to if '--tag' is used.

'-w'
'--warn'
     When verifying checksums, warn about improperly formatted MD5
     checksum lines.  This option is useful only if all but a few lines
     in the checked input are valid.

'--strict'
     When verifying checksums, if one or more input line is invalid,
     exit nonzero after all warnings have been issued.

   An exit status of zero indicates success, and a nonzero value
indicates failure.

