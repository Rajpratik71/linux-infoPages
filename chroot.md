Next: env invocation,  Up: Modified command invocation

23.1 ‘chroot’: Run a command with a different root directory
============================================================

‘chroot’ runs a command with a specified root directory.  On many
systems, only the super-user can do this.(1).  Synopses:

     chroot OPTION NEWROOT [COMMAND [ARGS]...]
     chroot OPTION

   Ordinarily, file names are looked up starting at the root of the
directory structure, i.e., ‘/’.  ‘chroot’ changes the root to the
directory NEWROOT (which must exist), then changes the working directory
to ‘/’, and finally runs COMMAND with optional ARGS.  If COMMAND is not
specified, the default is the value of the ‘SHELL’ environment variable
or ‘/bin/sh’ if not set, invoked with the ‘-i’ option.  COMMAND must not
be a special built-in utility (*note Special built-in utilities::).

   The program accepts the following options.  Also see *note Common
options::.  Options must precede operands.

‘--groups=GROUPS’
     Use this option to override the supplementary GROUPS to be used by
     the new process.  The items in the list (names or numeric IDs) must
     be separated by commas.  Use ‘--groups=''’ to disable the
     supplementary group look-up implicit in the ‘--userspec’ option.

‘--userspec=USER[:GROUP]’
     By default, COMMAND is run with the same credentials as the
     invoking process.  Use this option to run it as a different USER
     and/or with a different primary GROUP.  If a USER is specified then
     the supplementary groups are set according to the system defined
     list for that user, unless overridden with the ‘--groups’ option.

‘--skip-chdir’
     Use this option to not change the working directory to ‘/’ after
     changing the root directory to NEWROOT, i.e., inside the chroot.
     This option is only permitted when NEWROOT is the old ‘/’
     directory, and therefore is mostly useful together with the
     ‘--groups’ and ‘--userspec’ options to retain the previous working
     directory.

   The user and group name look-up performed by the ‘--userspec’ and
‘--groups’ options, is done both outside and inside the chroot, with
successful look-ups inside the chroot taking precedence.  If the
specified user or group items are intended to represent a numeric ID,
then a name to ID resolving step is avoided by specifying a leading ‘+’.
*Note Disambiguating names and IDs::.

   Here are a few tips to help avoid common problems in using chroot.
To start with a simple example, make COMMAND refer to a statically
linked binary.  If you were to use a dynamically linked executable, then
you’d have to arrange to have the shared libraries in the right place
under your new root directory.

   For example, if you create a statically linked ‘ls’ executable, and
put it in ‘/tmp/empty’, you can run this command as root:

     $ chroot /tmp/empty /ls -Rl /

   Then you’ll see output like this:

     /:
     total 1023
     -rwxr-xr-x 1 0 0 1041745 Aug 16 11:17 ls

   If you want to use a dynamically linked executable, say ‘bash’, then
first run ‘ldd bash’ to see what shared objects it needs.  Then, in
addition to copying the actual binary, also copy the listed files to the
required positions under your intended new root directory.  Finally, if
the executable requires any other files (e.g., data, state, device
files), copy them into place, too.

   ‘chroot’ is installed only on systems that have the ‘chroot’
function, so portable scripts should not rely on its existence.

   Exit status:

     125 if ‘chroot’ itself fails
     126 if COMMAND is found but cannot be invoked
     127 if COMMAND cannot be found
     the exit status of COMMAND otherwise

   ---------- Footnotes ----------

   (1) However, some systems (e.g., FreeBSD) can be configured to allow
certain regular users to use the ‘chroot’ system call, and hence to run
this program.  Also, on Cygwin, anyone can run the ‘chroot’ command,
because the underlying function is non-privileged due to lack of support
in MS-Windows.  Furthermore, the ‘chroot’ command avoids the ‘chroot’
system call when NEWROOT is identical to the old ‘/’ directory for
consistency with systems where this is allowed for non-privileged users.

