File: libc.info,  Node: Receiving Data,  Next: Socket Data Options,  Prev: Sending Data,  Up: Transferring Data

16.9.5.2 Receiving Data
.......................

The 'recv' function is declared in the header file 'sys/socket.h'.  If
your FLAGS argument is zero, you can just as well use 'read' instead of
'recv'; see *note I/O Primitives::.

 -- Function: ssize_t recv (int SOCKET, void *BUFFER, size_t SIZE, int
          FLAGS)
     Preliminary: | MT-Safe | AS-Safe | AC-Safe | *Note POSIX Safety
     Concepts::.

     The 'recv' function is like 'read', but with the additional flags
     FLAGS.  The possible values of FLAGS are described in *note Socket
     Data Options::.

     If nonblocking mode is set for SOCKET, and no data are available to
     be read, 'recv' fails immediately rather than waiting.  *Note File
     Status Flags::, for information about nonblocking mode.

     This function returns the number of bytes received, or '-1' on
     failure.  The following 'errno' error conditions are defined for
     this function:

     'EBADF'
          The SOCKET argument is not a valid file descriptor.

     'ENOTSOCK'
          The descriptor SOCKET is not a socket.

     'EWOULDBLOCK'
          Nonblocking mode has been set on the socket, and the read
          operation would block.  (Normally, 'recv' blocks until there
          is input available to be read.)

     'EINTR'
          The operation was interrupted by a signal before any data was
          read.  *Note Interrupted Primitives::.

     'ENOTCONN'
          You never connected this socket.

     This function is defined as a cancellation point in multi-threaded
     programs, so one has to be prepared for this and make sure that
     allocated resources (like memory, files descriptors, semaphores or
     whatever) are freed even if the thread is canceled.

