Prev: sync invocation,  Up: Disk usage

14.5 ‘truncate’: Shrink or extend the size of a file
====================================================

‘truncate’ shrinks or extends the size of each FILE to the specified
size.  Synopsis:

     truncate OPTION... FILE...

   Any FILE that does not exist is created.

   If a FILE is larger than the specified size, the extra data is lost.
If a FILE is shorter, it is extended and the extended part (or hole)
reads as zero bytes.

   The program accepts the following options.  Also see *note Common
options::.

‘-c’
‘--no-create’
     Do not create files that do not exist.

‘-o’
‘--io-blocks’
     Treat SIZE as number of I/O blocks of the FILE rather than bytes.

‘-r RFILE’
‘--reference=RFILE’
     Base the size of each FILE on the size of RFILE.

‘-s SIZE’
‘--size=SIZE’
     Set or adjust the size of each FILE according to SIZE.  SIZE is in
     bytes unless ‘--io-blocks’ is specified.  SIZE may be, or may be an
     integer optionally followed by, one of the following multiplicative
     suffixes:
          ‘KB’ =>           1000 (KiloBytes)
          ‘K’  =>           1024 (KibiBytes)
          ‘MB’ =>      1000*1000 (MegaBytes)
          ‘M’  =>      1024*1024 (MebiBytes)
          ‘GB’ => 1000*1000*1000 (GigaBytes)
          ‘G’  => 1024*1024*1024 (GibiBytes)
     and so on for ‘T’, ‘P’, ‘E’, ‘Z’, and ‘Y’.

     SIZE may also be prefixed by one of the following to adjust the
     size of each FILE based on its current size:
          ‘+’  => extend by
          ‘-’  => reduce by
          ‘<’  => at most
          ‘>’  => at least
          ‘/’  => round down to multiple of
          ‘%’  => round up to multiple of

   An exit status of zero indicates success, and a nonzero value
indicates failure.

