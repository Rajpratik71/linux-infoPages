Next: sync invocation,  Prev: du invocation,  Up: Disk usage

14.3 ‘stat’: Report file or file system status
==============================================

‘stat’ displays information about the specified file(s).  Synopsis:

     stat [OPTION]... [FILE]...

   With no option, ‘stat’ reports all information about the given files.
But it also can be used to report the information of the file systems
the given files are located on.  If the files are links, ‘stat’ can also
give information about the files the links point to.

   Due to shell aliases and built-in ‘stat’ functions, using an
unadorned ‘stat’ interactively or in a script may get you different
functionality than that described here.  Invoke it via ‘env’ (i.e., ‘env
stat ...’) to avoid interference from the shell.

‘-L’
‘--dereference’
     Change how ‘stat’ treats symbolic links.  With this option, ‘stat’
     acts on the file referenced by each symbolic link argument.
     Without it, ‘stat’ acts on any symbolic link argument directly.

‘-f’
‘--file-system’
     Report information about the file systems where the given files are
     located instead of information about the files themselves.  This
     option implies the ‘-L’ option.

‘-c’
‘--format=FORMAT’
     Use FORMAT rather than the default format.  FORMAT is automatically
     newline-terminated, so running a command like the following with
     two or more FILE operands produces a line of output for each
     operand:
          $ stat --format=%d:%i / /usr
          2050:2
          2057:2

‘--printf=FORMAT’
     Use FORMAT rather than the default format.  Like ‘--format’, but
     interpret backslash escapes, and do not output a mandatory trailing
     newline.  If you want a newline, include ‘\n’ in the FORMAT.
     Here’s how you would use ‘--printf’ to print the device and inode
     numbers of ‘/’ and ‘/usr’:
          $ stat --printf='%d:%i\n' / /usr
          2050:2
          2057:2

‘-t’
‘--terse’
     Print the information in terse form, suitable for parsing by other
     programs.

     The output of the following commands are identical and the
     ‘--format’ also identifies the items printed (in fuller form) in
     the default format.  Note the format string would include another
     ‘%C’ at the end with an active SELinux security context.
          $ stat --format="%n %s %b %f %u %g %D %i %h %t %T %X %Y %Z %W %o" ...
          $ stat --terse ...

     The same illustrating terse output in ‘--file-system’ mode:
          $ stat -f --format="%n %i %l %t %s %S %b %f %a %c %d" ...
          $ stat -f --terse ...

   The valid FORMAT directives for files with ‘--format’ and ‘--printf’
are:

   • %a - Access rights in octal (note ‘#’ and ‘0’ printf flags)
   • %A - Access rights in human readable form
   • %b - Number of blocks allocated (see ‘%B’)
   • %B - The size in bytes of each block reported by ‘%b’
   • %C - The SELinux security context of a file, if available
   • %d - Device number in decimal
   • %D - Device number in hex
   • %f - Raw mode in hex
   • %F - File type
   • %g - Group ID of owner
   • %G - Group name of owner
   • %h - Number of hard links
   • %i - Inode number
   • %m - Mount point (See note below)
   • %n - File name
   • %N - Quoted file name with dereference if symbolic link
   • %o - Optimal I/O transfer size hint
   • %s - Total size, in bytes
   • %t - Major device type in hex (see below)
   • %T - Minor device type in hex (see below)
   • %u - User ID of owner
   • %U - User name of owner
   • %w - Time of file birth, or ‘-’ if unknown
   • %W - Time of file birth as seconds since Epoch, or ‘0’
   • %x - Time of last access
   • %X - Time of last access as seconds since Epoch
   • %y - Time of last data modification
   • %Y - Time of last data modification as seconds since Epoch
   • %z - Time of last status change
   • %Z - Time of last status change as seconds since Epoch

   The ‘%a’ format prints the octal mode, and so it is useful to control
the zero padding of the output with the ‘#’ and ‘0’ printf flags.  For
example to pad to at least 3 wide while making larger numbers
unambiguously octal, you can use ‘%#03a’.

   The ‘%t’ and ‘%T’ formats operate on the st_rdev member of the
stat(2) structure, and are only defined for character and block special
files.  On some systems or file types, st_rdev may be used to represent
other quantities.

   The ‘%W’, ‘%X’, ‘%Y’, and ‘%Z’ formats accept a precision preceded by
a period to specify the number of digits to print after the decimal
point.  For example, ‘%.3X’ outputs the last access time to millisecond
precision.  If a period is given but no precision, ‘stat’ uses 9 digits,
so ‘%.X’ is equivalent to ‘%.9X’.  When discarding excess precision,
time stamps are truncated toward minus infinity.

     zero pad:
       $ stat -c '[%015Y]' /usr
       [000001288929712]
     space align:
       $ stat -c '[%15Y]' /usr
       [     1288929712]
       $ stat -c '[%-15Y]' /usr
       [1288929712     ]
     precision:
       $ stat -c '[%.3Y]' /usr
       [1288929712.114]
       $ stat -c '[%.Y]' /usr
       [1288929712.114951834]

   The mount point printed by ‘%m’ is similar to that output by ‘df’,
except that:
   • stat does not dereference symlinks by default (unless ‘-L’ is
     specified)
   • stat does not search for specified device nodes in the file system
     list, instead operating on them directly
   • stat outputs the alias for a bind mounted file, rather than the
     initial mount point of its backing device.  One can recursively
     call stat until there is no change in output, to get the current
     base mount point

   When listing file system information (‘--file-system’ (‘-f’)), you
must use a different set of FORMAT directives:

   • %a - Free blocks available to non-super-user
   • %b - Total data blocks in file system
   • %c - Total file nodes in file system
   • %d - Free file nodes in file system
   • %f - Free blocks in file system
   • %i - File System ID in hex
   • %l - Maximum length of file names
   • %n - File name
   • %s - Block size (for faster transfers)
   • %S - Fundamental block size (for block counts)
   • %t - Type in hex
   • %T - Type in human readable form

   Time stamps are listed according to the time zone rules specified by
the ‘TZ’ environment variable, or by the system default rules if ‘TZ’ is
not set.  *Note Specifying the Time Zone with ‘TZ’: (libc)TZ Variable.

   An exit status of zero indicates success, and a nonzero value
indicates failure.

