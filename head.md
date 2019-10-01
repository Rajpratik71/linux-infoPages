File: coreutils.info,  Node: head invocation,  Next: tail invocation,  Up: Output of parts of files

5.1 'head': Output the first part of files
==========================================

'head' prints the first part (10 lines by default) of each FILE; it
reads from standard input if no files are given or when given a FILE of
'-'.  Synopsis:

     head [OPTION]... [FILE]...

   If more than one FILE is specified, 'head' prints a one-line header
consisting of:

     ==> FILE NAME <==

before the output for each FILE.

   The program accepts the following options.  Also see *note Common
options::.

'-c K'
'--bytes=K'
     Print the first K bytes, instead of initial lines.  However, if K
     starts with a '-', print all but the last K bytes of each file.  K
     may be, or may be an integer optionally followed by, one of the
     following multiplicative suffixes:
          'b'  =>            512 ("blocks")
          'KB' =>           1000 (KiloBytes)
          'K'  =>           1024 (KibiBytes)
          'MB' =>      1000*1000 (MegaBytes)
          'M'  =>      1024*1024 (MebiBytes)
          'GB' => 1000*1000*1000 (GigaBytes)
          'G'  => 1024*1024*1024 (GibiBytes)
     and so on for 'T', 'P', 'E', 'Z', and 'Y'.

'-n K'
'--lines=K'
     Output the first K lines.  However, if K starts with a '-', print
     all but the last K lines of each file.  Size multiplier suffixes
     are the same as with the '-c' option.

'-q'
'--quiet'
'--silent'
     Never print file name headers.

'-v'
'--verbose'
     Always print file name headers.

   For compatibility 'head' also supports an obsolete option syntax
'-COUNTOPTIONS', which is recognized only if it is specified first.
COUNT is a decimal number optionally followed by a size letter ('b',
'k', 'm') as in '-c', or 'l' to mean count by lines, or other option
letters ('cqv').  Scripts intended for standard hosts should use '-c
COUNT' or '-n COUNT' instead.  If your script must also run on hosts
that support only the obsolete syntax, it is usually simpler to avoid
'head', e.g., by using 'sed 5q' instead of 'head -5'.

   An exit status of zero indicates success, and a nonzero value
indicates failure.

