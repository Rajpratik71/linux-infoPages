File: coreutils.info,  Node: cp invocation,  Next: dd invocation,  Up: Basic operations

11.1 'cp': Copy files and directories
=====================================

'cp' copies files (or, optionally, directories).  The copy is completely
independent of the original.  You can either copy one file to another,
or copy arbitrarily many files to a destination directory.  Synopses:

     cp [OPTION]... [-T] SOURCE DEST
     cp [OPTION]... SOURCE... DIRECTORY
     cp [OPTION]... -t DIRECTORY SOURCE...

   * If two file names are given, 'cp' copies the first file to the
     second.

   * If the '--target-directory' ('-t') option is given, or failing that
     if the last file is a directory and the '--no-target-directory'
     ('-T') option is not given, 'cp' copies each SOURCE file to the
     specified directory, using the SOURCEs' names.

   Generally, files are written just as they are read.  For exceptions,
see the '--sparse' option below.

   By default, 'cp' does not copy directories.  However, the '-R', '-a',
and '-r' options cause 'cp' to copy recursively by descending into
source directories and copying files to corresponding destination
directories.

   When copying from a symbolic link, 'cp' normally follows the link
only when not copying recursively or when '--link' ('-l') is used.  This
default can be overridden with the '--archive' ('-a'), '-d',
'--dereference' ('-L'), '--no-dereference' ('-P'), and '-H' options.  If
more than one of these options is specified, the last one silently
overrides the others.

   When copying to a symbolic link, 'cp' follows the link only when it
refers to an existing regular file.  However, when copying to a dangling
symbolic link, 'cp' refuses by default, and fails with a diagnostic,
since the operation is inherently dangerous.  This behavior is contrary
to historical practice and to POSIX.  Set 'POSIXLY_CORRECT' to make 'cp'
attempt to create the target of a dangling destination symlink, in spite
of the possible risk.  Also, when an option like '--backup' or '--link'
acts to rename or remove the destination before copying, 'cp' renames or
removes the symbolic link rather than the file it points to.

   By default, 'cp' copies the contents of special files only when not
copying recursively.  This default can be overridden with the
'--copy-contents' option.

   'cp' generally refuses to copy a file onto itself, with the following
exception: if '--force --backup' is specified with SOURCE and DEST
identical, and referring to a regular file, 'cp' will make a backup
file, either regular or numbered, as specified in the usual ways (*note
Backup options::).  This is useful when you simply want to make a backup
of an existing file before changing it.

   The program accepts the following options.  Also see *note Common
options::.

'-a'
'--archive'
     Preserve as much as possible of the structure and attributes of the
     original files in the copy (but do not attempt to preserve internal
     directory structure; i.e., 'ls -U' may list the entries in a copied
     directory in a different order).  Try to preserve SELinux security
     context and extended attributes (xattr), but ignore any failure to
     do that and print no corresponding diagnostic.  Equivalent to '-dR
     --preserve=all' with the reduced diagnostics.

'--attributes-only'
     Copy only the specified attributes of the source file to the
     destination.  If the destination already exists, do not alter its
     contents.  See the '--preserve' option for controlling which
     attributes to copy.

'-b'
''--backup'[=METHOD]'
     *Note Backup options::.  Make a backup of each file that would
     otherwise be overwritten or removed.  As a special case, 'cp' makes
     a backup of SOURCE when the force and backup options are given and
     SOURCE and DEST are the same name for an existing, regular file.
     One useful application of this combination of options is this tiny
     Bourne shell script:

          #!/bin/sh
          # Usage: backup FILE...
          # Create a GNU-style backup of each listed FILE.
          fail=0
          for i; do
            cp --backup --force --preserve=all -- "$i" "$i" || fail=1
          done
          exit $fail

'-c'
     Preserve SELinux security context of the original files if
     possible.  Some file systems don't support storing of SELinux
     security context.

'--copy-contents'
     If copying recursively, copy the contents of any special files
     (e.g., FIFOs and device files) as if they were regular files.  This
     means trying to read the data in each source file and writing it to
     the destination.  It is usually a mistake to use this option, as it
     normally has undesirable effects on special files like FIFOs and
     the ones typically found in the '/dev' directory.  In most cases,
     'cp -R --copy-contents' will hang indefinitely trying to read from
     FIFOs and special files like '/dev/console', and it will fill up
     your destination disk if you use it to copy '/dev/zero'.  This
     option has no effect unless copying recursively, and it does not
     affect the copying of symbolic links.

'-d'
     Copy symbolic links as symbolic links rather than copying the files
     that they point to, and preserve hard links between source files in
     the copies.  Equivalent to '--no-dereference --preserve=links'.

'-f'
'--force'
     When copying without this option and an existing destination file
     cannot be opened for writing, the copy fails.  However, with
     '--force', when a destination file cannot be opened, 'cp' then
     removes it and tries to open it again.  Contrast this behavior with
     that enabled by '--link' and '--symbolic-link', whereby the
     destination file is never opened but rather is removed
     unconditionally.  Also see the description of
     '--remove-destination'.

     This option is independent of the '--interactive' or '-i' option:
     neither cancels the effect of the other.

     This option is ignored when the '--no-clobber' or '-n' option is
     also used.

'-H'
     If a command line argument specifies a symbolic link, then copy the
     file it points to rather than the symbolic link itself.  However,
     copy (preserving its nature) any symbolic link that is encountered
     via recursive traversal.

'-i'
'--interactive'
     When copying a file other than a directory, prompt whether to
     overwrite an existing destination file.  The '-i' option overrides
     a previous '-n' option.

'-l'
'--link'
     Make hard links instead of copies of non-directories.

'-L'
'--dereference'
     Follow symbolic links when copying from them.  With this option,
     'cp' cannot create a symbolic link.  For example, a symlink (to
     regular file) in the source tree will be copied to a regular file
     in the destination tree.

'-n'
'--no-clobber'
     Do not overwrite an existing file.  The '-n' option overrides a
     previous '-i' option.  This option is mutually exclusive with '-b'
     or '--backup' option.

'-P'
'--no-dereference'
     Copy symbolic links as symbolic links rather than copying the files
     that they point to.  This option affects only symbolic links in the
     source; symbolic links in the destination are always followed if
     possible.

'-p'
''--preserve'[=ATTRIBUTE_LIST]'
     Preserve the specified attributes of the original files.  If
     specified, the ATTRIBUTE_LIST must be a comma-separated list of one
     or more of the following strings:

     'mode'
          Preserve the file mode bits and access control lists.
     'ownership'
          Preserve the owner and group.  On most modern systems, only
          users with appropriate privileges may change the owner of a
          file, and ordinary users may preserve the group ownership of a
          file only if they happen to be a member of the desired group.
     'timestamps'
          Preserve the times of last access and last modification, when
          possible.  On older systems, it is not possible to preserve
          these attributes when the affected file is a symbolic link.
          However, many systems now provide the 'utimensat' function,
          which makes it possible even for symbolic links.
     'links'
          Preserve in the destination files any links between
          corresponding source files.  Note that with '-L' or '-H', this
          option can convert symbolic links to hard links.  For example,
               $ mkdir c; : > a; ln -s a b; cp -aH a b c; ls -i1 c
               74161745 a
               74161745 b
          Note the inputs: 'b' is a symlink to regular file 'a', yet the
          files in destination directory, 'c/', are hard-linked.  Since
          '-a' implies '--no-dereference' it would copy the symlink, but
          the later '-H' tells 'cp' to dereference the command line
          arguments where it then sees two files with the same inode
          number.  Then the '--preserve=links' option also implied by
          '-a' will preserve the perceived hard link.

          Here is a similar example that exercises 'cp''s '-L' option:
               $ mkdir b c; (cd b; : > a; ln -s a b); cp -aL b c; ls -i1 c/b
               74163295 a
               74163295 b

     'context'
          Preserve SELinux security context of the file, or fail with
          full diagnostics.
     'xattr'
          Preserve extended attributes of the file, or fail with full
          diagnostics.  If 'cp' is built without xattr support, ignore
          this option.  If SELinux context, ACLs or Capabilities are
          implemented using xattrs, they are preserved implicitly by
          this option as well, i.e., even without specifying
          '--preserve=mode' or '--preserve=context'.
     'all'
          Preserve all file attributes.  Equivalent to specifying all of
          the above, but with the difference that failure to preserve
          SELinux security context or extended attributes does not
          change 'cp''s exit status.  In contrast to '-a', all but
          'Operation not supported' warnings are output.

     Using '--preserve' with no ATTRIBUTE_LIST is equivalent to
     '--preserve=mode,ownership,timestamps'.

     In the absence of this option, the permissions of existing
     destination files are unchanged, while each new file is created
     with the mode bits of the corresponding source file, minus the bits
     set in the umask and minus the set-user-ID and set-group-ID bits.
     *Note File permissions::.

''--no-preserve'=ATTRIBUTE_LIST'
     Do not preserve the specified attributes.  The ATTRIBUTE_LIST has
     the same form as for '--preserve'.

'--parents'
     Form the name of each destination file by appending to the target
     directory a slash and the specified name of the source file.  The
     last argument given to 'cp' must be the name of an existing
     directory.  For example, the command:

          cp --parents a/b/c existing_dir

     copies the file 'a/b/c' to 'existing_dir/a/b/c', creating any
     missing intermediate directories.

'-R'
'-r'
'--recursive'
     Copy directories recursively.  By default, do not follow symbolic
     links in the source unless used together with the '--link' ('-l')
     option; see the '--archive' ('-a'), '-d', '--dereference' ('-L'),
     '--no-dereference' ('-P'), and '-H' options.  Special files are
     copied by creating a destination file of the same type as the
     source; see the '--copy-contents' option.  It is not portable to
     use '-r' to copy symbolic links or special files.  On some non-GNU
     systems, '-r' implies the equivalent of '-L' and '--copy-contents'
     for historical reasons.  Also, it is not portable to use '-R' to
     copy symbolic links unless you also specify '-P', as POSIX allows
     implementations that dereference symbolic links by default.

'--reflink[=WHEN]'
     Perform a lightweight, copy-on-write (COW) copy, if supported by
     the file system.  Once it has succeeded, beware that the source and
     destination files share the same disk data blocks as long as they
     remain unmodified.  Thus, if a disk I/O error affects data blocks
     of one of the files, the other suffers the same fate.

     The WHEN value can be one of the following:

     'always'
          The default behavior: if the copy-on-write operation is not
          supported then report the failure for each file and exit with
          a failure status.

     'auto'
          If the copy-on-write operation is not supported then fall back
          to the standard copy behaviour.

     This option is overridden by the '--link', '--symbolic-link' and
     '--attributes-only' options, thus allowing it to be used to
     configure the default data copying behavior for 'cp'.  For example,
     with the following alias, 'cp' will use the minimum amount of space
     supported by the file system.

          alias cp='cp --reflink=auto --sparse=always'

'--remove-destination'
     Remove each existing destination file before attempting to open it
     (contrast with '-f' above).

'--sparse=WHEN'
     A "sparse file" contains "holes"--a sequence of zero bytes that
     does not occupy any physical disk blocks; the 'read' system call
     reads these as zeros.  This can both save considerable disk space
     and increase speed, since many binary files contain lots of
     consecutive zero bytes.  By default, 'cp' detects holes in input
     source files via a crude heuristic and makes the corresponding
     output file sparse as well.  Only regular files may be sparse.

     The WHEN value can be one of the following:

     'auto'
          The default behavior: if the input file is sparse, attempt to
          make the output file sparse, too.  However, if an output file
          exists but refers to a non-regular file, then do not attempt
          to make it sparse.

     'always'
          For each sufficiently long sequence of zero bytes in the input
          file, attempt to create a corresponding hole in the output
          file, even if the input file does not appear to be sparse.
          This is useful when the input file resides on a file system
          that does not support sparse files (for example, 'efs' file
          systems in SGI IRIX 5.3 and earlier), but the output file is
          on a type of file system that does support them.  Holes may be
          created only in regular files, so if the destination file is
          of some other type, 'cp' does not even try to make it sparse.

     'never'
          Never make the output file sparse.  This is useful in creating
          a file for use with the 'mkswap' command, since such a file
          must not have any holes.

''--strip-trailing-slashes''
     Remove any trailing slashes from each SOURCE argument.  *Note
     Trailing slashes::.

'-s'
'--symbolic-link'
     Make symbolic links instead of copies of non-directories.  All
     source file names must be absolute (starting with '/') unless the
     destination files are in the current directory.  This option merely
     results in an error message on systems that do not support symbolic
     links.

'-S SUFFIX'
'--suffix=SUFFIX'
     Append SUFFIX to each backup file made with '-b'.  *Note Backup
     options::.

'-t DIRECTORY'
''--target-directory'=DIRECTORY'
     Specify the destination DIRECTORY.  *Note Target directory::.

'-T'
'--no-target-directory'
     Do not treat the last operand specially when it is a directory or a
     symbolic link to a directory.  *Note Target directory::.

'-u'
'--update'
     Do not copy a non-directory that has an existing destination with
     the same or newer modification time.  If time stamps are being
     preserved, the comparison is to the source time stamp truncated to
     the resolutions of the destination file system and of the system
     calls used to update time stamps; this avoids duplicate work if
     several 'cp -pu' commands are executed with the same source and
     destination.  If '--preserve=links' is also specified (like with
     'cp -au' for example), that will take precedence.  Consequently,
     depending on the order that files are processed from the source,
     newer files in the destination may be replaced, to mirror hard
     links in the source.

'-v'
'--verbose'
     Print the name of each file before copying it.

'-x'
'--one-file-system'
     Skip subdirectories that are on different file systems from the one
     that the copy started on.  However, mount point directories _are_
     copied.

'-Z'
'--context[=CONTEXT]'
     Without a specified CONTEXT, adjust the SELinux security context
     according to the system default type for destination files,
     similarly to the 'restorecon' command.  The long form of this
     option with a specific context specified, will set the context for
     newly created files only.  With a specified context, if SELinux is
     disabled, a warning is issued.  This option is mutually exclusive
     with the '--preserve=context' option, and overrides the
     '--preserve=all' and '-a' options.

   An exit status of zero indicates success, and a nonzero value
indicates failure.

