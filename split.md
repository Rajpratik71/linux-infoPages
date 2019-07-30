Next: csplit invocation,  Prev: tail invocation,  Up: Output of parts of files

5.3 ‘split’: Split a file into pieces.
======================================

‘split’ creates output files containing consecutive or interleaved
sections of INPUT (standard input if none is given or INPUT is ‘-’).
Synopsis:

     split [OPTION] [INPUT [PREFIX]]

   By default, ‘split’ puts 1000 lines of INPUT (or whatever is left
over for the last section), into each output file.

   The output files’ names consist of PREFIX (‘x’ by default) followed
by a group of characters (‘aa’, ‘ab’, ... by default), such that
concatenating the output files in traditional sorted order by file name
produces the original input file (except ‘-nr/N’).  By default split
will initially create files with two generated suffix characters, and
will increase this width by two when the next most significant position
reaches the last character.  (‘yz’, ‘zaaa’, ‘zaab’, ...).  In this way
an arbitrary number of output files are supported, which sort as
described above, even in the presence of an ‘--additional-suffix’
option.  If the ‘-a’ option is specified and the output file names are
exhausted, ‘split’ reports an error without deleting the output files
that it did create.

   The program accepts the following options.  Also see *note Common
options::.

‘-l LINES’
‘--lines=LINES’
     Put LINES lines of INPUT into each output file.  If ‘--separator’
     is specified, then LINES determines the number of records.

     For compatibility ‘split’ also supports an obsolete option syntax
     ‘-LINES’.  New scripts should use ‘-l LINES’ instead.

‘-b SIZE’
‘--bytes=SIZE’
     Put SIZE bytes of INPUT into each output file.  SIZE may be, or may
     be an integer optionally followed by, one of the following
     multiplicative suffixes:
          ‘b’  =>            512 ("blocks")
          ‘KB’ =>           1000 (KiloBytes)
          ‘K’  =>           1024 (KibiBytes)
          ‘MB’ =>      1000*1000 (MegaBytes)
          ‘M’  =>      1024*1024 (MebiBytes)
          ‘GB’ => 1000*1000*1000 (GigaBytes)
          ‘G’  => 1024*1024*1024 (GibiBytes)
     and so on for ‘T’, ‘P’, ‘E’, ‘Z’, and ‘Y’.

‘-C SIZE’
‘--line-bytes=SIZE’
     Put into each output file as many complete lines of INPUT as
     possible without exceeding SIZE bytes.  Individual lines or records
     longer than SIZE bytes are broken into multiple files.  SIZE has
     the same format as for the ‘--bytes’ option.  If ‘--separator’ is
     specified, then LINES determines the number of records.

‘--filter=COMMAND’
     With this option, rather than simply writing to each output file,
     write through a pipe to the specified shell COMMAND for each output
     file.  COMMAND should use the $FILE environment variable, which is
     set to a different output file name for each invocation of the
     command.  For example, imagine that you have a 1TiB compressed file
     that, if uncompressed, would be too large to reside on disk, yet
     you must split it into individually-compressed pieces of a more
     manageable size.  To do that, you might run this command:

          xz -dc BIG.xz | split -b200G --filter='xz > $FILE.xz' - big-

     Assuming a 10:1 compression ratio, that would create about fifty
     20GiB files with names ‘big-aa.xz’, ‘big-ab.xz’, ‘big-ac.xz’, etc.

‘-n CHUNKS’
‘--number=CHUNKS’

     Split INPUT to CHUNKS output files where CHUNKS may be:

          N      generate N files based on current size of INPUT
          K/N    only output Kth of N to stdout
          l/N    generate N files without splitting lines or records
          l/K/N  likewise but only output Kth of N to stdout
          r/N    like ‘l’ but use round robin distribution
          r/K/N  likewise but only output Kth of N to stdout

     Any excess bytes remaining after dividing the INPUT into N chunks,
     are assigned to the last chunk.  Any excess bytes appearing after
     the initial calculation are discarded (except when using ‘r’ mode).

     All N files are created even if there are fewer than N lines, or
     the INPUT is truncated.

     For ‘l’ mode, chunks are approximately INPUT size / N.  The INPUT
     is partitioned into N equal sized portions, with the last assigned
     any excess.  If a line _starts_ within a partition it is written
     completely to the corresponding file.  Since lines or records are
     not split even if they overlap a partition, the files written can
     be larger or smaller than the partition size, and even empty if a
     line/record is so long as to completely overlap the partition.

     For ‘r’ mode, the size of INPUT is irrelevant, and so can be a pipe
     for example.

‘-a LENGTH’
‘--suffix-length=LENGTH’
     Use suffixes of length LENGTH.  If a LENGTH of 0 is specified, this
     is the same as if (any previous) ‘-a’ was not specified, and thus
     enables the default behavior, which starts the suffix length at 2,
     and unless ‘-n’ or ‘--numeric-suffixes=FROM’ is specified, will
     auto increase the length by 2 as required.

‘-d’
‘--numeric-suffixes[=FROM]’
     Use digits in suffixes rather than lower-case letters.  The
     numerical suffix counts from FROM if specified, 0 otherwise.

     FROM is supported with the long form option, and is used to either
     set the initial suffix for a single run, or to set the suffix
     offset for independently split inputs, and consequently the auto
     suffix length expansion described above is disabled.  Therefore you
     may also want to use option ‘-a’ to allow suffixes beyond ‘99’.
     Note if option ‘--number’ is specified and the number of files is
     less than FROM, a single run is assumed and the minimum suffix
     length required is automatically determined.

‘--additional-suffix=SUFFIX’
     Append an additional SUFFIX to output file names.  SUFFIX must not
     contain slash.

‘-e’
‘--elide-empty-files’
     Suppress the generation of zero-length output files.  This can
     happen with the ‘--number’ option if a file is (truncated to be)
     shorter than the number requested, or if a line is so long as to
     completely span a chunk.  The output file sequence numbers, always
     run consecutively even when this option is specified.

‘-t SEPARATOR’
‘--separator=SEPARATOR’
     Use character SEPARATOR as the record separator instead of the
     default newline character (ASCII LF). To specify ASCII NUL as the
     separator, use the two-character string ‘\0’, e.g., ‘split -t
     '\0'’.

‘-u’
‘--unbuffered’
     Immediately copy input to output in ‘--number r/...’ mode, which is
     a much slower mode of operation.

‘--verbose’
     Write a diagnostic just before each output file is opened.

   An exit status of zero indicates success, and a nonzero value
indicates failure.

   Here are a few examples to illustrate how the ‘--number’ (‘-n’)
option works:

   Notice how, by default, one line may be split onto two or more:

     $ seq -w 6 10 > k; split -n3 k; head xa?
     ==> xaa <==
     06
     07
     ==> xab <==

     08
     0
     ==> xac <==
     9
     10

   Use the "l/" modifier to suppress that:

     $ seq -w 6 10 > k; split -nl/3 k; head xa?
     ==> xaa <==
     06
     07

     ==> xab <==
     08
     09

     ==> xac <==
     10

   Use the "r/" modifier to distribute lines in a round-robin fashion:

     $ seq -w 6 10 > k; split -nr/3 k; head xa?
     ==> xaa <==
     06
     09

     ==> xab <==
     07
     10

     ==> xac <==
     08

   You can also extract just the Kth chunk.  This extracts and prints
just the 7th "chunk" of 33:

     $ seq 100 > k; split -nl/7/33 k
     20
     21
     22

