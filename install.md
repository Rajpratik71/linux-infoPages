Next: mv invocation,  Prev: dd invocation,  Up: Basic operations

11.3 ‘install’: Copy files and set attributes
=============================================

‘install’ copies files while setting their file mode bits and, if
possible, their owner and group.  Synopses:

     install [OPTION]... [-T] SOURCE DEST
     install [OPTION]... SOURCE... DIRECTORY
     install [OPTION]... -t DIRECTORY SOURCE...
     install [OPTION]... -d DIRECTORY...

   • If two file names are given, ‘install’ copies the first file to the
     second.

   • If the ‘--target-directory’ (‘-t’) option is given, or failing that
     if the last file is a directory and the ‘--no-target-directory’
     (‘-T’) option is not given, ‘install’ copies each SOURCE file to
     the specified directory, using the SOURCEs’ names.

   • If the ‘--directory’ (‘-d’) option is given, ‘install’ creates each
     DIRECTORY and any missing parent directories.  Parent directories
     are created with mode ‘u=rwx,go=rx’ (755), regardless of the ‘-m’
     option or the current umask.  *Note Directory Setuid and Setgid::,
     for how the set-user-ID and set-group-ID bits of parent directories
     are inherited.

   ‘install’ is similar to ‘cp’, but allows you to control the
attributes of destination files.  It is typically used in Makefiles to
copy programs into their destination directories.  It refuses to copy
files onto themselves.

   ‘install’ never preserves extended attributes (xattr).

   The program accepts the following options.  Also see *note Common
options::.

‘-b’
‘--backup[=METHOD]’
     *Note Backup options::.  Make a backup of each file that would
     otherwise be overwritten or removed.

‘-C’
‘--compare’
     Compare each pair of source and destination files, and if the
     destination has identical content and any specified owner, group,
     permissions, and possibly SELinux context, then do not modify the
     destination at all.  Note this option is best used in conjunction
     with ‘--user’, ‘--group’ and ‘--mode’ options, lest ‘install’
     incorrectly determines the default attributes that installed files
     would have (as it doesn’t consider setgid directories and POSIX
     default ACLs for example).  This could result in redundant copies
     or attributes that are not reset to the correct defaults.

‘-c’
     Ignored; for compatibility with old Unix versions of ‘install’.

‘-D’
     Create any missing parent directories of DEST, then copy SOURCE to
     DEST.  Explicitly specifying the ‘--target-directory=DIR’ will
     similarly ensure the presence of that hierarchy before copying
     SOURCE arguments.

‘-d’
‘--directory’
     Create any missing parent directories, giving them the default
     attributes.  Then create each given directory, setting their owner,
     group and mode as given on the command line or to the defaults.

‘-g GROUP’
‘--group=GROUP’
     Set the group ownership of installed files or directories to GROUP.
     The default is the process’s current group.  GROUP may be either a
     group name or a numeric group ID.

‘-m MODE’
‘--mode=MODE’
     Set the file mode bits for the installed file or directory to MODE,
     which can be either an octal number, or a symbolic mode as in
     ‘chmod’, with ‘a=’ (no access allowed to anyone) as the point of
     departure (*note File permissions::).  The default mode is
     ‘u=rwx,go=rx,a-s’—read, write, and execute for the owner, read and
     execute for group and other, and with set-user-ID and set-group-ID
     disabled.  This default is not quite the same as ‘755’, since it
     disables instead of preserving set-user-ID and set-group-ID on
     directories.  *Note Directory Setuid and Setgid::.

‘-o OWNER’
‘--owner=OWNER’
     If ‘install’ has appropriate privileges (is run as root), set the
     ownership of installed files or directories to OWNER.  The default
     is ‘root’.  OWNER may be either a user name or a numeric user ID.

‘--preserve-context’
     Preserve the SELinux security context of files and directories.
     Failure to preserve the context in all of the files or directories
     will result in an exit status of 1.  If SELinux is disabled then
     print a warning and ignore the option.

‘-p’
‘--preserve-timestamps’
     Set the time of last access and the time of last modification of
     each installed file to match those of each corresponding original
     file.  When a file is installed without this option, its last
     access and last modification times are both set to the time of
     installation.  This option is useful if you want to use the last
     modification times of installed files to keep track of when they
     were last built as opposed to when they were last installed.

‘-s’
‘--strip’
     Strip the symbol tables from installed binary executables.

‘--strip-program=PROGRAM’
     Program used to strip binaries.

‘-S SUFFIX’
‘--suffix=SUFFIX’
     Append SUFFIX to each backup file made with ‘-b’.  *Note Backup
     options::.

‘-t DIRECTORY’
‘--target-directory=DIRECTORY’
     Specify the destination DIRECTORY.  *Note Target directory::.  Also
     specifying the ‘-D’ option will ensure the directory is present.

‘-T’
‘--no-target-directory’
     Do not treat the last operand specially when it is a directory or a
     symbolic link to a directory.  *Note Target directory::.

‘-v’
‘--verbose’
     Print the name of each file before copying it.

‘-Z’
‘--context[=CONTEXT]’
     Without a specified CONTEXT, adjust the SELinux security context
     according to the system default type for destination files,
     similarly to the ‘restorecon’ command.  The long form of this
     option with a specific context specified, will set the context for
     newly created files only.  With a specified context, if both
     SELinux and SMACK are disabled, a warning is issued.  This option
     is mutually exclusive with the ‘--preserve-context’ option.

   An exit status of zero indicates success, and a nonzero value
indicates failure.

