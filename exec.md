File: libc.info,  Node: Executing a File,  Next: Process Completion,  Prev: Creating a Process,  Up: Processes

26.5 Executing a File
=====================

This section describes the `exec' family of functions, for executing a
file as a process image.  You can use these functions to make a child
process execute a new program after it has been forked.

   To see the effects of `exec' from the point of view of the called
program, see *note Program Basics::.

   The functions in this family differ in how you specify the arguments,
but otherwise they all do the same thing.  They are declared in the
header file `unistd.h'.

 -- Function: int execv (const char *FILENAME, char *const ARGV[])
     Preliminary: | MT-Safe | AS-Safe | AC-Safe | *Note POSIX Safety
     Concepts::.

     The `execv' function executes the file named by FILENAME as a new
     process image.

     The ARGV argument is an array of null-terminated strings that is
     used to provide a value for the `argv' argument to the `main'
     function of the program to be executed.  The last element of this
     array must be a null pointer.  By convention, the first element of
     this array is the file name of the program sans directory names.
     *Note Program Arguments::, for full details on how programs can
     access these arguments.

     The environment for the new process image is taken from the
     `environ' variable of the current process image; see *note
     Environment Variables::, for information about environments.

 -- Function: int execl (const char *FILENAME, const char *ARG0, ...)
     Preliminary: | MT-Safe | AS-Unsafe heap | AC-Unsafe mem | *Note
     POSIX Safety Concepts::.

     This is similar to `execv', but the ARGV strings are specified
     individually instead of as an array.  A null pointer must be
     passed as the last such argument.

 -- Function: int execve (const char *FILENAME, char *const ARGV[],
          char *const ENV[])
     Preliminary: | MT-Safe | AS-Safe | AC-Safe | *Note POSIX Safety
     Concepts::.

     This is similar to `execv', but permits you to specify the
     environment for the new program explicitly as the ENV argument.
     This should be an array of strings in the same format as for the
     `environ' variable; see *note Environment Access::.

 -- Function: int execle (const char *FILENAME, const char *ARG0, ...,
          char *const ENV[])
     Preliminary: | MT-Safe | AS-Unsafe heap | AC-Unsafe mem | *Note
     POSIX Safety Concepts::.

     This is similar to `execl', but permits you to specify the
     environment for the new program explicitly.  The environment
     argument is passed following the null pointer that marks the last
     ARGV argument, and should be an array of strings in the same
     format as for the `environ' variable.

 -- Function: int execvp (const char *FILENAME, char *const ARGV[])
     Preliminary: | MT-Safe env | AS-Unsafe heap | AC-Unsafe mem |
     *Note POSIX Safety Concepts::.

     The `execvp' function is similar to `execv', except that it
     searches the directories listed in the `PATH' environment variable
     (*note Standard Environment::) to find the full file name of a
     file from FILENAME if FILENAME does not contain a slash.

     This function is useful for executing system utility programs,
     because it looks for them in the places that the user has chosen.
     Shells use it to run the commands that users type.

 -- Function: int execlp (const char *FILENAME, const char *ARG0, ...)
     Preliminary: | MT-Safe env | AS-Unsafe heap | AC-Unsafe mem |
     *Note POSIX Safety Concepts::.

     This function is like `execl', except that it performs the same
     file name searching as the `execvp' function.

   The size of the argument list and environment list taken together
must not be greater than `ARG_MAX' bytes.  *Note General Limits::.  On
GNU/Hurd systems, the size (which compares against `ARG_MAX') includes,
for each string, the number of characters in the string, plus the size
of a `char *', plus one, rounded up to a multiple of the size of a
`char *'.  Other systems may have somewhat different rules for counting.

   These functions normally don't return, since execution of a new
program causes the currently executing program to go away completely.
A value of `-1' is returned in the event of a failure.  In addition to
the usual file name errors (*note File Name Errors::), the following
`errno' error conditions are defined for these functions:

`E2BIG'
     The combined size of the new program's argument list and
     environment list is larger than `ARG_MAX' bytes.  GNU/Hurd systems
     have no specific limit on the argument list size, so this error
     code cannot result, but you may get `ENOMEM' instead if the
     arguments are too big for available memory.

`ENOEXEC'
     The specified file can't be executed because it isn't in the right
     format.

`ENOMEM'
     Executing the specified file requires more storage than is
     available.

   If execution of the new file succeeds, it updates the access time
field of the file as if the file had been read.  *Note File Times::,
for more details about access times of files.

   The point at which the file is closed again is not specified, but is
at some point before the process exits or before another process image
is executed.

   Executing a new process image completely changes the contents of
memory, copying only the argument and environment strings to new
locations.  But many other attributes of the process are unchanged:

   * The process ID and the parent process ID.  *Note Process Creation
     Concepts::.

   * Session and process group membership.  *Note Concepts of Job
     Control::.

   * Real user ID and group ID, and supplementary group IDs.  *Note
     Process Persona::.

   * Pending alarms.  *Note Setting an Alarm::.

   * Current working directory and root directory.  *Note Working
     Directory::.  On GNU/Hurd systems, the root directory is not
     copied when executing a setuid program; instead the system default
     root directory is used for the new program.

   * File mode creation mask.  *Note Setting Permissions::.

   * Process signal mask; see *note Process Signal Mask::.

   * Pending signals; see *note Blocking Signals::.

   * Elapsed processor time associated with the process; see *note
     Processor Time::.

   If the set-user-ID and set-group-ID mode bits of the process image
file are set, this affects the effective user ID and effective group ID
(respectively) of the process.  These concepts are discussed in detail
in *note Process Persona::.

   Signals that are set to be ignored in the existing process image are
also set to be ignored in the new process image.  All other signals are
set to the default action in the new process image.  For more
information about signals, see *note Signal Handling::.

   File descriptors open in the existing process image remain open in
the new process image, unless they have the `FD_CLOEXEC'
(close-on-exec) flag set.  The files that remain open inherit all
attributes of the open file description from the existing process image,
including file locks.  File descriptors are discussed in *note
Low-Level I/O::.

   Streams, by contrast, cannot survive through `exec' functions,
because they are located in the memory of the process itself.  The new
process image has no streams except those it creates afresh.  Each of
the streams in the pre-`exec' process image has a descriptor inside it,
and these descriptors do survive through `exec' (provided that they do
not have `FD_CLOEXEC' set).  The new process image can reconnect these
to new streams using `fdopen' (*note Descriptors and Streams::).

