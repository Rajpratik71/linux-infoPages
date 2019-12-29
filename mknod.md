File: coreutils.info,  Node: mknod invocation,  Next: readlink invocation,  Prev: mkfifo invocation,  Up: Special file types

12.5 ‘mknod’: Make block or character special files
===================================================

‘mknod’ creates a FIFO, character special file, or block special file
with the specified name.  Synopsis:

     mknod [OPTION]... NAME TYPE [MAJOR MINOR]

   Unlike the phrase “special file type” above, the term “special file”
has a technical meaning on Unix: something that can generate or receive
data.  Usually this corresponds to a physical piece of hardware, e.g., a
printer or a disk.  (These files are typically created at
system-configuration time.)  The ‘mknod’ command is what creates files
of this type.  Such devices can be read either a character at a time or
a “block” (many characters) at a time, hence we say there are “block
special” files and “character special” files.

   Due to shell aliases and built-in ‘mknod’ functions, using an
unadorned ‘mknod’ interactively or in a script may get you different
functionality than that described here.  Invoke it via ‘env’ (i.e., ‘env
mknod ...’) to avoid interference from the shell.

   The arguments after NAME specify the type of file to make:

‘p’
     for a FIFO

‘b’
     for a block special file

‘c’
     for a character special file

   When making a block or character special file, the major and minor
device numbers must be given after the file type.  If a major or minor
device number begins with ‘0x’ or ‘0X’, it is interpreted as
hexadecimal; otherwise, if it begins with ‘0’, as octal; otherwise, as
decimal.

   The program accepts the following options.  Also see *note Common
options::.

‘-m MODE’
‘--mode=MODE’
     Set the mode of created files to MODE, which is symbolic as in
     ‘chmod’ and uses ‘a=rw’ as the point of departure.  MODE should
     specify only file permission bits.  *Note File permissions::.

‘-Z’
‘--context[=CONTEXT]’
     Without a specified CONTEXT, adjust the SELinux security context
     according to the system default type for destination files,
     similarly to the ‘restorecon’ command.  The long form of this
     option with a specific context specified, will set the context for
     newly created files only.  With a specified context, if both
     SELinux and SMACK are disabled, a warning is issued.

   An exit status of zero indicates success, and a nonzero value
indicates failure.

