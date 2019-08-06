File: libc.info,  Node: Process Group Functions,  Next: Terminal Access Functions,  Prev: Identifying the Terminal,  Up: Functions for Job Control

28.7.2 Process Group Functions
------------------------------

Here are descriptions of the functions for manipulating process groups.
Your program should include the header files `sys/types.h' and
`unistd.h' to use these functions.  

 -- Function: pid_t setsid (void)
     Preliminary: | MT-Safe | AS-Safe | AC-Safe | *Note POSIX Safety
     Concepts::.

     The `setsid' function creates a new session.  The calling process
     becomes the session leader, and is put in a new process group whose
     process group ID is the same as the process ID of that process.
     There are initially no other processes in the new process group,
     and no other process groups in the new session.

     This function also makes the calling process have no controlling
     terminal.

     The `setsid' function returns the new process group ID of the
     calling process if successful.  A return value of `-1' indicates an
     error.  The following `errno' error conditions are defined for this
     function:

    `EPERM'
          The calling process is already a process group leader, or
          there is already another process group around that has the
          same process group ID.

 -- Function: pid_t getsid (pid_t PID)
     Preliminary: | MT-Safe | AS-Safe | AC-Safe | *Note POSIX Safety
     Concepts::.

     The `getsid' function returns the process group ID of the session
     leader of the specified process.  If a PID is `0', the process
     group ID of the session leader of the current process is returned.

     In case of error `-1' is returned and `errno' is set.  The
     following `errno' error conditions are defined for this function:

    `ESRCH'
          There is no process with the given process ID PID.

    `EPERM'
          The calling process and the process specified by PID are in
          different sessions, and the implementation doesn't allow to
          access the process group ID of the session leader of the
          process with ID PID from the calling process.

 -- Function: pid_t getpgrp (void)
     Preliminary: | MT-Safe | AS-Safe | AC-Safe | *Note POSIX Safety
     Concepts::.

     The `getpgrp' function returns the process group ID of the calling
     process.

 -- Function: int getpgid (pid_t PID)
     Preliminary: | MT-Safe | AS-Safe | AC-Safe | *Note POSIX Safety
     Concepts::.

     The `getpgid' function returns the process group ID of the process
     PID.  You can supply a value of `0' for the PID argument to get
     information about the calling process.

     In case of error `-1' is returned and `errno' is set.  The
     following `errno' error conditions are defined for this function:

    `ESRCH'
          There is no process with the given process ID PID.  The
          calling process and the process specified by PID are in
          different sessions, and the implementation doesn't allow to
          access the process group ID of the process with ID PID from
          the calling process.

 -- Function: int setpgid (pid_t PID, pid_t PGID)
     Preliminary: | MT-Safe | AS-Safe | AC-Safe | *Note POSIX Safety
     Concepts::.

     The `setpgid' function puts the process PID into the process group
     PGID.  As a special case, either PID or PGID can be zero to
     indicate the process ID of the calling process.

     This function fails on a system that does not support job control.
     *Note Job Control is Optional::, for more information.

     If the operation is successful, `setpgid' returns zero.  Otherwise
     it returns `-1'.  The following `errno' error conditions are
     defined for this function:

    `EACCES'
          The child process named by PID has executed an `exec'
          function since it was forked.

    `EINVAL'
          The value of the PGID is not valid.

    `ENOSYS'
          The system doesn't support job control.

    `EPERM'
          The process indicated by the PID argument is a session leader,
          or is not in the same session as the calling process, or the
          value of the PGID argument doesn't match a process group ID
          in the same session as the calling process.

    `ESRCH'
          The process indicated by the PID argument is not the calling
          process or a child of the calling process.

 -- Function: int setpgrp (pid_t PID, pid_t PGID)
     Preliminary: | MT-Safe | AS-Safe | AC-Safe | *Note POSIX Safety
     Concepts::.

     This is the BSD Unix name for `setpgid'.  Both functions do exactly
     the same thing.

