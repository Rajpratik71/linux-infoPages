File: libc.info,  Node: Accepting Connections,  Next: Who is Connected,  Prev: Listening,  Up: Connections

16.9.3 Accepting Connections
----------------------------

When a server receives a connection request, it can complete the
connection by accepting the request.  Use the function `accept' to do
this.

   A socket that has been established as a server can accept connection
requests from multiple clients.  The server's original socket _does not
become part of the connection_; instead, `accept' makes a new socket
which participates in the connection.  `accept' returns the descriptor
for this socket.  The server's original socket remains available for
listening for further connection requests.

   The number of pending connection requests on a server socket is
finite.  If connection requests arrive from clients faster than the
server can act upon them, the queue can fill up and additional requests
are refused with an `ECONNREFUSED' error.  You can specify the maximum
length of this queue as an argument to the `listen' function, although
the system may also impose its own internal limit on the length of this
queue.

 -- Function: int accept (int SOCKET, struct sockaddr *ADDR, socklen_t
          *LENGTH_PTR)
     Preliminary: | MT-Safe | AS-Safe | AC-Safe fd | *Note POSIX Safety
     Concepts::.

     This function is used to accept a connection request on the server
     socket SOCKET.

     The `accept' function waits if there are no connections pending,
     unless the socket SOCKET has nonblocking mode set.  (You can use
     `select' to wait for a pending connection, with a nonblocking
     socket.)  *Note File Status Flags::, for information about
     nonblocking mode.

     The ADDR and LENGTH-PTR arguments are used to return information
     about the name of the client socket that initiated the connection.
     *Note Socket Addresses::, for information about the format of the
     information.

     Accepting a connection does not make SOCKET part of the
     connection.  Instead, it creates a new socket which becomes
     connected.  The normal return value of `accept' is the file
     descriptor for the new socket.

     After `accept', the original socket SOCKET remains open and
     unconnected, and continues listening until you close it.  You can
     accept further connections with SOCKET by calling `accept' again.

     If an error occurs, `accept' returns `-1'.  The following `errno'
     error conditions are defined for this function:

    `EBADF'
          The SOCKET argument is not a valid file descriptor.

    `ENOTSOCK'
          The descriptor SOCKET argument is not a socket.

    `EOPNOTSUPP'
          The descriptor SOCKET does not support this operation.

    `EWOULDBLOCK'
          SOCKET has nonblocking mode set, and there are no pending
          connections immediately available.

     This function is defined as a cancellation point in multi-threaded
     programs, so one has to be prepared for this and make sure that
     allocated resources (like memory, files descriptors, semaphores or
     whatever) are freed even if the thread is canceled.

   The `accept' function is not allowed for sockets using
connectionless communication styles.

