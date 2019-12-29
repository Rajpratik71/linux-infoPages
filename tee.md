File: coreutils.info,  Node: tee invocation,  Up: Redirection

17.1 ‘tee’: Redirect output to multiple files or processes
==========================================================

The ‘tee’ command copies standard input to standard output and also to
any files given as arguments.  This is useful when you want not only to
send some data down a pipe, but also to save a copy.  Synopsis:

     tee [OPTION]... [FILE]...

   If a file being written to does not already exist, it is created.  If
a file being written to already exists, the data it previously contained
is overwritten unless the ‘-a’ option is used.

   In previous versions of GNU coreutils (v5.3.0 - v8.23), a FILE of ‘-’
caused ‘tee’ to send another copy of input to standard output.  However,
as the interleaved output was not very useful, ‘tee’ now conforms to
POSIX which explicitly mandates it to treat ‘-’ as a file with such
name.

   The program accepts the following options.  Also see *note Common
options::.

‘-a’
‘--append’
     Append standard input to the given files rather than overwriting
     them.

‘-i’
‘--ignore-interrupts’
     Ignore interrupt signals.

‘-p’
‘--output-error[=MODE]’
     Adjust the behavior with errors on the outputs, with the long form
     option supporting selection between the following MODEs:

     ‘warn’
          Warn on error opening or writing any output, including pipes.
          Writing is continued to still open files/pipes.  Exit status
          indicates failure if any output has an error.

     ‘warn-nopipe’
          This is the default MODE when not specified, or when the short
          form ‘-p’ is used.  Warn on error opening or writing any
          output, except pipes.  Writing is continued to still open
          files/pipes.  Exit status indicates failure if any non pipe
          output had an error.

     ‘exit’
          Exit on error opening or writing any output, including pipes.

     ‘exit-nopipe’
          Exit on error opening or writing any output, except pipes.

   The ‘tee’ command is useful when you happen to be transferring a
large amount of data and also want to summarize that data without
reading it a second time.  For example, when you are downloading a DVD
image, you often want to verify its signature or checksum right away.
The inefficient way to do it is simply:

     wget https://example.com/some.iso && sha1sum some.iso

   One problem with the above is that it makes you wait for the download
to complete before starting the time-consuming SHA1 computation.
Perhaps even more importantly, the above requires reading the DVD image
a second time (the first was from the network).

   The efficient way to do it is to interleave the download and SHA1
computation.  Then, you’ll get the checksum for free, because the entire
process parallelizes so well:

     # slightly contrived, to demonstrate process substitution
     wget -O - https://example.com/dvd.iso \
       | tee >(sha1sum > dvd.sha1) > dvd.iso

   That makes ‘tee’ write not just to the expected output file, but also
to a pipe running ‘sha1sum’ and saving the final checksum in a file
named ‘dvd.sha1’.

   Note, however, that this example relies on a feature of modern shells
called “process substitution” (the ‘>(command)’ syntax, above; *Note
Process Substitution: (bash)Process Substitution.), so it works with
‘zsh’, ‘bash’, and ‘ksh’, but not with ‘/bin/sh’.  So if you write code
like this in a shell script, be sure to start the script with
‘#!/bin/bash’.

   Note also that if any of the process substitutions (or piped stdout)
might exit early without consuming all the data, the ‘-p’ option is
needed to allow ‘tee’ to continue to process the input to any remaining
outputs.

   Since the above example writes to one file and one process, a more
conventional and portable use of ‘tee’ is even better:

     wget -O - https://example.com/dvd.iso \
       | tee dvd.iso | sha1sum > dvd.sha1

   You can extend this example to make ‘tee’ write to two processes,
computing MD5 and SHA1 checksums in parallel.  In this case, process
substitution is required:

     wget -O - https://example.com/dvd.iso \
       | tee >(sha1sum > dvd.sha1) \
             >(md5sum > dvd.md5) \
       > dvd.iso

   This technique is also useful when you want to make a _compressed_
copy of the contents of a pipe.  Consider a tool to graphically
summarize disk usage data from ‘du -ak’.  For a large hierarchy, ‘du
-ak’ can run for a long time, and can easily produce terabytes of data,
so you won’t want to rerun the command unnecessarily.  Nor will you want
to save the uncompressed output.

   Doing it the inefficient way, you can’t even start the GUI until
after you’ve compressed all of the ‘du’ output:

     du -ak | gzip -9 > /tmp/du.gz
     gzip -d /tmp/du.gz | xdiskusage -a

   With ‘tee’ and process substitution, you start the GUI right away and
eliminate the decompression completely:

     du -ak | tee >(gzip -9 > /tmp/du.gz) | xdiskusage -a

   Finally, if you regularly create more than one type of compressed
tarball at once, for example when ‘make dist’ creates both
‘gzip’-compressed and ‘bzip2’-compressed tarballs, there may be a better
way.  Typical ‘automake’-generated ‘Makefile’ rules create the two
compressed tar archives with commands in sequence, like this (slightly
simplified):

     tardir=your-pkg-M.N
     tar chof - "$tardir" | gzip  -9 -c > your-pkg-M.N.tar.gz
     tar chof - "$tardir" | bzip2 -9 -c > your-pkg-M.N.tar.bz2

   However, if the hierarchy you are archiving and compressing is larger
than a couple megabytes, and especially if you are using a
multi-processor system with plenty of memory, then you can do much
better by reading the directory contents only once and running the
compression programs in parallel:

     tardir=your-pkg-M.N
     tar chof - "$tardir" \
       | tee >(gzip -9 -c > your-pkg-M.N.tar.gz) \
       | bzip2 -9 -c > your-pkg-M.N.tar.bz2

   If you want to further process the output from process substitutions,
and those processes write atomically (i.e., write less than the system’s
PIPE_BUF size at a time), that’s possible with a construct like:

     tardir=your-pkg-M.N
     tar chof - "$tardir" \
       | tee >(md5sum --tag) > >(sha256sum --tag) \
       | sort | gpg --clearsign > your-pkg-M.N.tar.sig

   An exit status of zero indicates success, and a nonzero value
indicates failure.

