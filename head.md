File: coreutils.info,  Node: head invocation,  Next: tail invocation,  Up: Output of parts of files

5.1 ‘head’: Output the first part of files
==========================================

‘head’ prints the first part (10 lines by default) of each FILE; it
reads from standard input if no files are given or when given a FILE of
‘-’.  Synopsis:

     head [OPTION]... [FILE]...

   If more than one FILE is specified, ‘head’ prints a one-line header
consisting of:

     ==> FILE NAME <==

before the output for each FILE.

   The program accepts the following options.  Also see *note Common
options::.

‘-c [-]NUM’
‘--bytes=[-]NUM’
     Print the first NUM bytes, instead of initial lines.  However, if
     NUM is prefixed with a ‘-’, print all but the last NUM bytes of
     each file.  NUM may be, or may be an integer optionally followed
     by, one of the following multiplicative suffixes:
          ‘b’  =>            512 ("blocks")
          ‘KB’ =>           1000 (KiloBytes)
          ‘K’  =>           1024 (KibiBytes)
          ‘MB’ =>      1000*1000 (MegaBytes)
          ‘M’  =>      1024*1024 (MebiBytes)
          ‘GB’ => 1000*1000*1000 (GigaBytes)
          ‘G’  => 1024*1024*1024 (GibiBytes)
     and so on for ‘T’, ‘P’, ‘E’, ‘Z’, and ‘Y’.

‘-n [-]NUM’
‘--lines=[-]NUM’
     Output the first NUM lines.  However, if NUM is prefixed with a
     ‘-’, print all but the last NUM lines of each file.  Size
     multiplier suffixes are the same as with the ‘-c’ option.

‘-q’
‘--quiet’
‘--silent’
     Never print file name headers.

‘-v’
‘--verbose’
     Always print file name headers.

‘-z’
‘--zero-terminated’
     Delimit items with a zero byte rather than a newline (ASCII LF).
     I.e., treat input as items separated by ASCII NUL and terminate
     output items with ASCII NUL. This option can be useful in
     conjunction with ‘perl -0’ or ‘find -print0’ and ‘xargs -0’ which
     do the same in order to reliably handle arbitrary file names (even
     those containing blanks or other special characters).

   For compatibility ‘head’ also supports an obsolete option syntax
‘-[NUM][bkm][cqv]’, which is recognized only if it is specified first.
NUM is a decimal number optionally followed by a size letter (‘b’, ‘k’,
‘m’) as in ‘-c’, or ‘l’ to mean count by lines, or other option letters
(‘cqv’).  Scripts intended for standard hosts should use ‘-c NUM’ or ‘-n
NUM’ instead.  If your script must also run on hosts that support only
the obsolete syntax, it is usually simpler to avoid ‘head’, e.g., by
using ‘sed 5q’ instead of ‘head -5’.

   An exit status of zero indicates success, and a nonzero value
indicates failure.

