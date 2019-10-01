File: libc.info,  Node: Signaling Another Process,  Next: Permission for kill,  Prev: Signaling Yourself,  Up: Generating Signals

24.6.2 Signaling Another Process
--------------------------------

The 'kill' function can be used to send a signal to another process.  In
spite of its name, it can be used for a lot of things other than causing
a process to terminate.  Some examples of situations where you might
want to send signals between processes are:

   * A parent process starts a child to perform a task--perhaps having
     the child running an infinite loop--and then terminates the child
     when the task is no longer needed.

   * A process executes as part of a group, and needs to terminate or
     notify the other processes in the group when an error or other
     event occurs.

   * Two processes need to synchronize while working together.

   This section assumes that you know a little bit about how processes
work.  For more information on this subject, see *note Processes::.

   The 'kill' function is declared in 'signal.h'.

 -- Function: int kill (pid_t PID, int SIGNUM)
     Preliminary: | MT-Safe | AS-Safe | AC-Safe | *Note POSIX Safety
     Concepts::.

     The 'kill' function sends the signal SIGNUM to the process or
     process group specified by PID.  Besides the signals listed in
     *note Standard Signals::, SIGNUM can also have a value of zero to
     check the validity of the PID.

     The PID specifies the process or process group to receive the
     signal:

     'PID > 0'
          The process whose identifier is PID.

     'PID == 0'
          All processes in the same process group as the sender.

     'PID < -1'
          The process group whose identifier is -PID.

     'PID == -1'
          If the process is privileged, send the signal to all processes
          except for some special system processes.  Otherwise, send the
          signal to all processes with the same effective user ID.

     A process can send a signal to itself with a call like
     'kill (getpid(), SIGNUM)'.  If 'kill' is used by a process to send
     a signal to itself, and the signal is not blocked, then 'kill'
     delivers at least one signal (which might be some other pending
     unblocked signal instead of the signal SIGNUM) to that process
     before it returns.

     The return value from 'kill' is zero if the signal can be sent
     successfully.  Otherwise, no signal is sent, and a value of '-1' is
     returned.  If PID specifies sending a signal to several processes,
     'kill' succeeds if it can send the signal to at least one of them.
     There's no way you can tell which of the processes got the signal
     or whether all of them did.

     The following 'errno' error conditions are defined for this
     function:

     'EINVAL'
          The SIGNUM argument is an invalid or unsupported number.

     'EPERM'
          You do not have the privilege to send a signal to the process
          or any of the processes in the process group named by PID.

     'ESRCH'
          The PID argument does not refer to an existing process or
          group.

 -- Function: int killpg (int PGID, int SIGNUM)
     Preliminary: | MT-Safe | AS-Safe | AC-Safe | *Note POSIX Safety
     Concepts::.

     This is similar to 'kill', but sends signal SIGNUM to the process
     group PGID.  This function is provided for compatibility with BSD;
     using 'kill' to do this is more portable.

   As a simple example of 'kill', the call 'kill (getpid (), SIG)' has
the same effect as 'raise (SIG)'.

