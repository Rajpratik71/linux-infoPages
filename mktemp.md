Next: realpath invocation,  Prev: pathchk invocation,  Up: File name manipulation

18.4 ‘mktemp’: Create temporary file or directory
=================================================

‘mktemp’ manages the creation of temporary files and directories.
Synopsis:

     mktemp [OPTION]... [TEMPLATE]

   Safely create a temporary file or directory based on TEMPLATE, and
print its name.  If given, TEMPLATE must include at least three
consecutive ‘X’s in the last component.  If omitted, the template
‘tmp.XXXXXXXXXX’ is used, and option ‘--tmpdir’ is implied.  The final
run of ‘X’s in the TEMPLATE will be replaced by alpha-numeric
characters; thus, on a case-sensitive file system, and with a TEMPLATE
including a run of N instances of ‘X’, there are ‘62**N’ potential file
names.

   Older scripts used to create temporary files by simply joining the
name of the program with the process id (‘$$’) as a suffix.  However,
that naming scheme is easily predictable, and suffers from a race
condition where the attacker can create an appropriately named symbolic
link, such that when the script then opens a handle to what it thought
was an unused file, it is instead modifying an existing file.  Using the
same scheme to create a directory is slightly safer, since the ‘mkdir’
will fail if the target already exists, but it is still inferior because
it allows for denial of service attacks.  Therefore, modern scripts
should use the ‘mktemp’ command to guarantee that the generated name
will be unpredictable, and that knowledge of the temporary file name
implies that the file was created by the current script and cannot be
modified by other users.

   When creating a file, the resulting file has read and write
permissions for the current user, but no permissions for the group or
others; these permissions are reduced if the current umask is more
restrictive.

   Here are some examples (although note that if you repeat them, you
will most likely get different file names):

   • Create a temporary file in the current directory.
          $ mktemp file.XXXX
          file.H47c

   • Create a temporary file with a known suffix.
          $ mktemp --suffix=.txt file-XXXX
          file-H08W.txt
          $ mktemp file-XXXX-XXXX.txt
          file-XXXX-eI9L.txt

   • Create a secure fifo relative to the user’s choice of ‘TMPDIR’, but
     falling back to the current directory rather than ‘/tmp’.  Note
     that ‘mktemp’ does not create fifos, but can create a secure
     directory in which the fifo can live.  Exit the shell if the
     directory or fifo could not be created.
          $ dir=$(mktemp -p "${TMPDIR:-.}" -d dir-XXXX) || exit 1
          $ fifo=$dir/fifo
          $ mkfifo "$fifo" || { rmdir "$dir"; exit 1; }

   • Create and use a temporary file if possible, but ignore failure.
     The file will reside in the directory named by ‘TMPDIR’, if
     specified, or else in ‘/tmp’.
          $ file=$(mktemp -q) && {
          >   # Safe to use $file only within this block.  Use quotes,
          >   # since $TMPDIR, and thus $file, may contain whitespace.
          >   echo ... > "$file"
          >   rm "$file"
          > }

   • Act as a semi-random character generator (it is not fully random,
     since it is impacted by the contents of the current directory).  To
     avoid security holes, do not use the resulting names to create a
     file.
          $ mktemp -u XXX
          Gb9
          $ mktemp -u XXX
          nzC

   The program accepts the following options.  Also see *note Common
options::.

‘-d’
‘--directory’
     Create a directory rather than a file.  The directory will have
     read, write, and search permissions for the current user, but no
     permissions for the group or others; these permissions are reduced
     if the current umask is more restrictive.

‘-q’
‘--quiet’
     Suppress diagnostics about failure to create a file or directory.
     The exit status will still reflect whether a file was created.

‘-u’
‘--dry-run’
     Generate a temporary name that does not name an existing file,
     without changing the file system contents.  Using the output of
     this command to create a new file is inherently unsafe, as there is
     a window of time between generating the name and using it where
     another process can create an object by the same name.

‘-p DIR’
‘--tmpdir[=DIR]’
     Treat TEMPLATE relative to the directory DIR.  If DIR is not
     specified (only possible with the long option ‘--tmpdir’) or is the
     empty string, use the value of ‘TMPDIR’ if available, otherwise use
     ‘/tmp’.  If this is specified, TEMPLATE must not be absolute.
     However, TEMPLATE can still contain slashes, although intermediate
     directories must already exist.

‘--suffix=SUFFIX’
     Append SUFFIX to the TEMPLATE.  SUFFIX must not contain slash.  If
     ‘--suffix’ is specified, TEMPLATE must end in ‘X’; if it is not
     specified, then an appropriate ‘--suffix’ is inferred by finding
     the last ‘X’ in TEMPLATE.  This option exists for use with the
     default TEMPLATE and for the creation of a SUFFIX that starts with
     ‘X’.

‘-t’
     Treat TEMPLATE as a single file relative to the value of ‘TMPDIR’
     if available, or to the directory specified by ‘-p’, otherwise to
     ‘/tmp’.  TEMPLATE must not contain slashes.  This option is
     deprecated; the use of ‘-p’ without ‘-t’ offers better defaults (by
     favoring the command line over ‘TMPDIR’) and more flexibility (by
     allowing intermediate directories).

   Exit status:

     0 if the file was created,
     1 otherwise.

