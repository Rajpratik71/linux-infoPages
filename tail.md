Next: split invocation,  Prev: head invocation,  Up: Output of parts of files

5.2 ‘tail’: Output the last part of files
=========================================

‘tail’ prints the last part (10 lines by default) of each FILE; it reads
from standard input if no files are given or when given a FILE of ‘-’.
Synopsis:

     tail [OPTION]... [FILE]...

   If more than one FILE is specified, ‘tail’ prints a one-line header
before the output for each FILE, consisting of:

     ==> FILE NAME <==

   For further processing of tail output, it can be useful to convert
the file headers to line prefixes, which can be done like:

     tail ... |
     awk '
       /^==> .* <==$/ {prefix=substr($0,5,length-8)":"; next}
       {print prefix$0}
     ' | ...

   GNU ‘tail’ can output any amount of data (some other versions of
‘tail’ cannot).  It also has no ‘-r’ option (print in reverse), since
reversing a file is really a different job from printing the end of a
file; BSD ‘tail’ (which is the one with ‘-r’) can only reverse files
that are at most as large as its buffer, which is typically 32 KiB.  A
more reliable and versatile way to reverse files is the GNU ‘tac’
command.

   The program accepts the following options.  Also see *note Common
options::.

‘-c [+]NUM’
‘--bytes=[+]NUM’
     Output the last NUM bytes, instead of final lines.  However, if NUM
     is prefixed with a ‘+’, start printing with byte NUM from the start
     of each file, instead of from the end.  NUM may be, or may be an
     integer optionally followed by, one of the following multiplicative
     suffixes:
          ‘b’  =>            512 ("blocks")
          ‘KB’ =>           1000 (KiloBytes)
          ‘K’  =>           1024 (KibiBytes)
          ‘MB’ =>      1000*1000 (MegaBytes)
          ‘M’  =>      1024*1024 (MebiBytes)
          ‘GB’ => 1000*1000*1000 (GigaBytes)
          ‘G’  => 1024*1024*1024 (GibiBytes)
     and so on for ‘T’, ‘P’, ‘E’, ‘Z’, and ‘Y’.

‘-f’
‘--follow[=HOW]’
     Loop forever trying to read more characters at the end of the file,
     presumably because the file is growing.  If more than one file is
     given, ‘tail’ prints a header whenever it gets output from a
     different file, to indicate which file that output is from.

     There are two ways to specify how you’d like to track files with
     this option, but that difference is noticeable only when a followed
     file is removed or renamed.  If you’d like to continue to track the
     end of a growing file even after it has been unlinked, use
     ‘--follow=descriptor’.  This is the default behavior, but it is not
     useful if you’re tracking a log file that may be rotated (removed
     or renamed, then reopened).  In that case, use ‘--follow=name’ to
     track the named file, perhaps by reopening it periodically to see
     if it has been removed and recreated by some other program.  Note
     that the inotify-based implementation handles this case without the
     need for any periodic reopening.

     No matter which method you use, if the tracked file is determined
     to have shrunk, ‘tail’ prints a message saying the file has been
     truncated and resumes tracking the end of the file from the
     newly-determined endpoint.

     When a file is removed, ‘tail’’s behavior depends on whether it is
     following the name or the descriptor.  When following by name, tail
     can detect that a file has been removed and gives a message to that
     effect, and if ‘--retry’ has been specified it will continue
     checking periodically to see if the file reappears.  When following
     a descriptor, tail does not detect that the file has been unlinked
     or renamed and issues no message; even though the file may no
     longer be accessible via its original name, it may still be
     growing.

     The option values ‘descriptor’ and ‘name’ may be specified only
     with the long form of the option, not with ‘-f’.

     The ‘-f’ option is ignored if no FILE operand is specified and
     standard input is a FIFO or a pipe.  Likewise, the ‘-f’ option has
     no effect for any operand specified as ‘-’, when standard input is
     a FIFO or a pipe.

     With kernel inotify support, output is triggered by file changes
     and is generally very prompt.  Otherwise, ‘tail’ sleeps for one
     second between checks— use ‘--sleep-interval=N’ to change that
     default—which can make the output appear slightly less responsive
     or bursty.  When using tail without inotify support, you can make
     it more responsive by using a sub-second sleep interval, e.g., via
     an alias like this:

          alias tail='tail -s.1'

‘-F’
     This option is the same as ‘--follow=name --retry’.  That is, tail
     will attempt to reopen a file when it is removed.  Should this
     fail, tail will keep trying until it becomes accessible again.

‘--max-unchanged-stats=N’
     When tailing a file by name, if there have been N (default n=5)
     consecutive iterations for which the file has not changed, then
     ‘open’/‘fstat’ the file to determine if that file name is still
     associated with the same device/inode-number pair as before.  When
     following a log file that is rotated, this is approximately the
     number of seconds between when tail prints the last pre-rotation
     lines and when it prints the lines that have accumulated in the new
     log file.  This option is meaningful only when polling (i.e.,
     without inotify) and when following by name.

‘-n [+]NUM’
‘--lines=[+]’
     Output the last NUM lines.  However, if NUM is prefixed with a ‘+’,
     start printing with line NUM from the start of each file, instead
     of from the end.  Size multiplier suffixes are the same as with the
     ‘-c’ option.

‘--pid=PID’
     When following by name or by descriptor, you may specify the
     process ID, PID, of the sole writer of all FILE arguments.  Then,
     shortly after that process terminates, tail will also terminate.
     This will work properly only if the writer and the tailing process
     are running on the same machine.  For example, to save the output
     of a build in a file and to watch the file grow, if you invoke
     ‘make’ and ‘tail’ like this then the tail process will stop when
     your build completes.  Without this option, you would have had to
     kill the ‘tail -f’ process yourself.

          $ make >& makerr & tail --pid=$! -f makerr

     If you specify a PID that is not in use or that does not correspond
     to the process that is writing to the tailed files, then ‘tail’ may
     terminate long before any FILEs stop growing or it may not
     terminate until long after the real writer has terminated.  Note
     that ‘--pid’ cannot be supported on some systems; ‘tail’ will print
     a warning if this is the case.

‘-q’
‘--quiet’
‘--silent’
     Never print file name headers.

‘--retry’
     Indefinitely try to open the specified file.  This option is useful
     mainly when following (and otherwise issues a warning).

     When following by file descriptor (i.e., with
     ‘--follow=descriptor’), this option only affects the initial open
     of the file, as after a successful open, ‘tail’ will start
     following the file descriptor.

     When following by name (i.e., with ‘--follow=name’), ‘tail’
     infinitely retries to re-open the given files until killed.

     Without this option, when ‘tail’ encounters a file that doesn’t
     exist or is otherwise inaccessible, it reports that fact and never
     checks it again.

‘-s NUMBER’
‘--sleep-interval=NUMBER’
     Change the number of seconds to wait between iterations (the
     default is 1.0).  During one iteration, every specified file is
     checked to see if it has changed size.  Historical implementations
     of ‘tail’ have required that NUMBER be an integer.  However, GNU
     ‘tail’ accepts an arbitrary floating point number.  *Note Floating
     point::.  When ‘tail’ uses inotify, this polling-related option is
     usually ignored.  However, if you also specify ‘--pid=P’, ‘tail’
     checks whether process P is alive at least every NUMBER seconds.

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

   For compatibility ‘tail’ also supports an obsolete usage ‘tail
-[NUM][bcl][f] [FILE]’, which is recognized only if it does not conflict
with the usage described above.  This obsolete form uses exactly one
option and at most one file.  In the option, NUM is an optional decimal
number optionally followed by a size letter (‘b’, ‘c’, ‘l’) to mean
count by 512-byte blocks, bytes, or lines, optionally followed by ‘f’
which has the same meaning as ‘-f’.

   On older systems, the leading ‘-’ can be replaced by ‘+’ in the
obsolete option syntax with the same meaning as in counts, and obsolete
usage overrides normal usage when the two conflict.  This obsolete
behavior can be enabled or disabled with the ‘_POSIX2_VERSION’
environment variable (*note Standards conformance::).

   Scripts intended for use on standard hosts should avoid obsolete
syntax and should use ‘-c NUM[b]’, ‘-n NUM’, and/or ‘-f’ instead.  If
your script must also run on hosts that support only the obsolete
syntax, you can often rewrite it to avoid problematic usages, e.g., by
using ‘sed -n '$p'’ rather than ‘tail -1’.  If that’s not possible, the
script can use a test like ‘if tail -c +1 </dev/null >/dev/null 2>&1;
then ...’ to decide which syntax to use.

   Even if your script assumes the standard behavior, you should still
beware usages whose behaviors differ depending on the POSIX version.
For example, avoid ‘tail - main.c’, since it might be interpreted as
either ‘tail main.c’ or as ‘tail -- - main.c’; avoid ‘tail -c 4’, since
it might mean either ‘tail -c4’ or ‘tail -c 10 4’; and avoid ‘tail +4’,
since it might mean either ‘tail ./+4’ or ‘tail -n +4’.

   An exit status of zero indicates success, and a nonzero value
indicates failure.

