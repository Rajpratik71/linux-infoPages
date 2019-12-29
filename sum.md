File: coreutils.info,  Node: sum invocation,  Next: cksum invocation,  Prev: wc invocation,  Up: Summarizing files

6.2 ‘sum’: Print checksum and block counts
==========================================

‘sum’ computes a 16-bit checksum for each given FILE, or standard input
if none are given or for a FILE of ‘-’.  Synopsis:

     sum [OPTION]... [FILE]...

   ‘sum’ prints the checksum for each FILE followed by the number of
blocks in the file (rounded up).  If more than one FILE is given, file
names are also printed (by default).  (With the ‘--sysv’ option,
corresponding file names are printed when there is at least one file
argument.)

   By default, GNU ‘sum’ computes checksums using an algorithm
compatible with BSD ‘sum’ and prints file sizes in units of 1024-byte
blocks.

   The program accepts the following options.  Also see *note Common
options::.

‘-r’
     Use the default (BSD compatible) algorithm.  This option is
     included for compatibility with the System V ‘sum’.  Unless ‘-s’
     was also given, it has no effect.

‘-s’
‘--sysv’
     Compute checksums using an algorithm compatible with System V
     ‘sum’’s default, and print file sizes in units of 512-byte blocks.

   ‘sum’ is provided for compatibility; the ‘cksum’ program (see next
section) is preferable in new applications.

   An exit status of zero indicates success, and a nonzero value
indicates failure.

