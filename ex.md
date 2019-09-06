File: libc.info,  Node: Error Codes,  Next: Error Messages,  Prev: Checking for Errors,  Up: Error Reporting

2.2 Error Codes
===============

The error code macros are defined in the header file `errno.h'.  All of
them expand into integer constant values.  Some of these error codes
can't occur on GNU systems, but they can occur using the GNU C Library
on other systems.

 -- Macro: int EPERM
     Operation not permitted; only the owner of the file (or other
     resource) or processes with special privileges can perform the
     operation.

 -- Macro: int ENOENT
     No such file or directory.  This is a "file doesn't exist" error
     for ordinary files that are referenced in contexts where they are
     expected to already exist.

 -- Macro: int ESRCH
     No process matches the specified process ID.

 -- Macro: int EINTR
     Interrupted function call; an asynchronous signal occurred and
     prevented completion of the call.  When this happens, you should
     try the call again.

     You can choose to have functions resume after a signal that is
     handled, rather than failing with `EINTR'; see *note Interrupted
     Primitives::.

 -- Macro: int EIO
     Input/output error; usually used for physical read or write errors.

 -- Macro: int ENXIO
     No such device or address.  The system tried to use the device
     represented by a file you specified, and it couldn't find the
     device.  This can mean that the device file was installed
     incorrectly, or that the physical device is missing or not
     correctly attached to the computer.

 -- Macro: int E2BIG
     Argument list too long; used when the arguments passed to a new
     program being executed with one of the `exec' functions (*note
     Executing a File::) occupy too much memory space.  This condition
     never arises on GNU/Hurd systems.

 -- Macro: int ENOEXEC
     Invalid executable file format.  This condition is detected by the
     `exec' functions; see *note Executing a File::.

 -- Macro: int EBADF
     Bad file descriptor; for example, I/O on a descriptor that has been
     closed or reading from a descriptor open only for writing (or vice
     versa).

 -- Macro: int ECHILD
     There are no child processes.  This error happens on operations
     that are supposed to manipulate child processes, when there aren't
     any processes to manipulate.

 -- Macro: int EDEADLK
     Deadlock avoided; allocating a system resource would have resulted
     in a deadlock situation.  The system does not guarantee that it
     will notice all such situations.  This error means you got lucky
     and the system noticed; it might just hang.  *Note File Locks::,
     for an example.

 -- Macro: int ENOMEM
     No memory available.  The system cannot allocate more virtual
     memory because its capacity is full.

 -- Macro: int EACCES
     Permission denied; the file permissions do not allow the attempted
     operation.

 -- Macro: int EFAULT
     Bad address; an invalid pointer was detected.  On GNU/Hurd
     systems, this error never happens; you get a signal instead.

 -- Macro: int ENOTBLK
     A file that isn't a block special file was given in a situation
     that requires one.  For example, trying to mount an ordinary file
     as a file system in Unix gives this error.

 -- Macro: int EBUSY
     Resource busy; a system resource that can't be shared is already
     in use.  For example, if you try to delete a file that is the root
     of a currently mounted filesystem, you get this error.

 -- Macro: int EEXIST
     File exists; an existing file was specified in a context where it
     only makes sense to specify a new file.

 -- Macro: int EXDEV
     An attempt to make an improper link across file systems was
     detected.  This happens not only when you use `link' (*note Hard
     Links::) but also when you rename a file with `rename' (*note
     Renaming Files::).

 -- Macro: int ENODEV
     The wrong type of device was given to a function that expects a
     particular sort of device.

 -- Macro: int ENOTDIR
     A file that isn't a directory was specified when a directory is
     required.

 -- Macro: int EISDIR
     File is a directory; you cannot open a directory for writing, or
     create or remove hard links to it.

 -- Macro: int EINVAL
     Invalid argument.  This is used to indicate various kinds of
     problems with passing the wrong argument to a library function.

 -- Macro: int EMFILE
     The current process has too many files open and can't open any
     more.  Duplicate descriptors do count toward this limit.

     In BSD and GNU, the number of open files is controlled by a
     resource limit that can usually be increased.  If you get this
     error, you might want to increase the `RLIMIT_NOFILE' limit or
     make it unlimited; *note Limits on Resources::.

 -- Macro: int ENFILE
     There are too many distinct file openings in the entire system.
     Note that any number of linked channels count as just one file
     opening; see *note Linked Channels::.  This error never occurs on
     GNU/Hurd systems.

 -- Macro: int ENOTTY
     Inappropriate I/O control operation, such as trying to set terminal
     modes on an ordinary file.

 -- Macro: int ETXTBSY
     An attempt to execute a file that is currently open for writing, or
     write to a file that is currently being executed.  Often using a
     debugger to run a program is considered having it open for writing
     and will cause this error.  (The name stands for "text file
     busy".)  This is not an error on GNU/Hurd systems; the text is
     copied as necessary.

 -- Macro: int EFBIG
     File too big; the size of a file would be larger than allowed by
     the system.

 -- Macro: int ENOSPC
     No space left on device; write operation on a file failed because
     the disk is full.

 -- Macro: int ESPIPE
     Invalid seek operation (such as on a pipe).

 -- Macro: int EROFS
     An attempt was made to modify something on a read-only file system.

 -- Macro: int EMLINK
     Too many links; the link count of a single file would become too
     large.  `rename' can cause this error if the file being renamed
     already has as many links as it can take (*note Renaming Files::).

 -- Macro: int EPIPE
     Broken pipe; there is no process reading from the other end of a
     pipe.  Every library function that returns this error code also
     generates a `SIGPIPE' signal; this signal terminates the program
     if not handled or blocked.  Thus, your program will never actually
     see `EPIPE' unless it has handled or blocked `SIGPIPE'.

 -- Macro: int EDOM
     Domain error; used by mathematical functions when an argument
     value does not fall into the domain over which the function is
     defined.

 -- Macro: int ERANGE
     Range error; used by mathematical functions when the result value
     is not representable because of overflow or underflow.

 -- Macro: int EAGAIN
     Resource temporarily unavailable; the call might work if you try
     again later.  The macro `EWOULDBLOCK' is another name for `EAGAIN';
     they are always the same in the GNU C Library.

     This error can happen in a few different situations:

        * An operation that would block was attempted on an object that
          has non-blocking mode selected.  Trying the same operation
          again will block until some external condition makes it
          possible to read, write, or connect (whatever the operation).
          You can use `select' to find out when the operation will be
          possible; *note Waiting for I/O::.

          *Portability Note:* In many older Unix systems, this condition
          was indicated by `EWOULDBLOCK', which was a distinct error
          code different from `EAGAIN'.  To make your program portable,
          you should check for both codes and treat them the same.

        * A temporary resource shortage made an operation impossible.
          `fork' can return this error.  It indicates that the shortage
          is expected to pass, so your program can try the call again
          later and it may succeed.  It is probably a good idea to
          delay for a few seconds before trying it again, to allow time
          for other processes to release scarce resources.  Such
          shortages are usually fairly serious and affect the whole
          system, so usually an interactive program should report the
          error to the user and return to its command loop.

 -- Macro: int EWOULDBLOCK
     In the GNU C Library, this is another name for `EAGAIN' (above).
     The values are always the same, on every operating system.

     C libraries in many older Unix systems have `EWOULDBLOCK' as a
     separate error code.

 -- Macro: int EINPROGRESS
     An operation that cannot complete immediately was initiated on an
     object that has non-blocking mode selected.  Some functions that
     must always block (such as `connect'; *note Connecting::) never
     return `EAGAIN'.  Instead, they return `EINPROGRESS' to indicate
     that the operation has begun and will take some time.  Attempts to
     manipulate the object before the call completes return `EALREADY'.
     You can use the `select' function to find out when the pending
     operation has completed; *note Waiting for I/O::.

 -- Macro: int EALREADY
     An operation is already in progress on an object that has
     non-blocking mode selected.

 -- Macro: int ENOTSOCK
     A file that isn't a socket was specified when a socket is required.

 -- Macro: int EMSGSIZE
     The size of a message sent on a socket was larger than the
     supported maximum size.

 -- Macro: int EPROTOTYPE
     The socket type does not support the requested communications
     protocol.

 -- Macro: int ENOPROTOOPT
     You specified a socket option that doesn't make sense for the
     particular protocol being used by the socket.  *Note Socket
     Options::.

 -- Macro: int EPROTONOSUPPORT
     The socket domain does not support the requested communications
     protocol (perhaps because the requested protocol is completely
     invalid).  *Note Creating a Socket::.

 -- Macro: int ESOCKTNOSUPPORT
     The socket type is not supported.

 -- Macro: int EOPNOTSUPP
     The operation you requested is not supported.  Some socket
     functions don't make sense for all types of sockets, and others
     may not be implemented for all communications protocols.  On
     GNU/Hurd systems, this error can happen for many calls when the
     object does not support the particular operation; it is a generic
     indication that the server knows nothing to do for that call.

 -- Macro: int EPFNOSUPPORT
     The socket communications protocol family you requested is not
     supported.

 -- Macro: int EAFNOSUPPORT
     The address family specified for a socket is not supported; it is
     inconsistent with the protocol being used on the socket.  *Note
     Sockets::.

 -- Macro: int EADDRINUSE
     The requested socket address is already in use.  *Note Socket
     Addresses::.

 -- Macro: int EADDRNOTAVAIL
     The requested socket address is not available; for example, you
     tried to give a socket a name that doesn't match the local host
     name.  *Note Socket Addresses::.

 -- Macro: int ENETDOWN
     A socket operation failed because the network was down.

 -- Macro: int ENETUNREACH
     A socket operation failed because the subnet containing the remote
     host was unreachable.

 -- Macro: int ENETRESET
     A network connection was reset because the remote host crashed.

 -- Macro: int ECONNABORTED
     A network connection was aborted locally.

 -- Macro: int ECONNRESET
     A network connection was closed for reasons outside the control of
     the local host, such as by the remote machine rebooting or an
     unrecoverable protocol violation.

 -- Macro: int ENOBUFS
     The kernel's buffers for I/O operations are all in use.  In GNU,
     this error is always synonymous with `ENOMEM'; you may get one or
     the other from network operations.

 -- Macro: int EISCONN
     You tried to connect a socket that is already connected.  *Note
     Connecting::.

 -- Macro: int ENOTCONN
     The socket is not connected to anything.  You get this error when
     you try to transmit data over a socket, without first specifying a
     destination for the data.  For a connectionless socket (for
     datagram protocols, such as UDP), you get `EDESTADDRREQ' instead.

 -- Macro: int EDESTADDRREQ
     No default destination address was set for the socket.  You get
     this error when you try to transmit data over a connectionless
     socket, without first specifying a destination for the data with
     `connect'.

 -- Macro: int ESHUTDOWN
     The socket has already been shut down.

 -- Macro: int ETOOMANYREFS
     ???

 -- Macro: int ETIMEDOUT
     A socket operation with a specified timeout received no response
     during the timeout period.

 -- Macro: int ECONNREFUSED
     A remote host refused to allow the network connection (typically
     because it is not running the requested service).

 -- Macro: int ELOOP
     Too many levels of symbolic links were encountered in looking up a
     file name.  This often indicates a cycle of symbolic links.

 -- Macro: int ENAMETOOLONG
     Filename too long (longer than `PATH_MAX'; *note Limits for
     Files::) or host name too long (in `gethostname' or `sethostname';
     *note Host Identification::).

 -- Macro: int EHOSTDOWN
     The remote host for a requested network connection is down.

 -- Macro: int EHOSTUNREACH
     The remote host for a requested network connection is not
     reachable.

 -- Macro: int ENOTEMPTY
     Directory not empty, where an empty directory was expected.
     Typically, this error occurs when you are trying to delete a
     directory.

 -- Macro: int EPROCLIM
     This means that the per-user limit on new process would be
     exceeded by an attempted `fork'.  *Note Limits on Resources::, for
     details on the `RLIMIT_NPROC' limit.

 -- Macro: int EUSERS
     The file quota system is confused because there are too many users.

 -- Macro: int EDQUOT
     The user's disk quota was exceeded.

 -- Macro: int ESTALE
     Stale file handle.  This indicates an internal confusion in the
     file system which is due to file system rearrangements on the
     server host for NFS file systems or corruption in other file
     systems.  Repairing this condition usually requires unmounting,
     possibly repairing and remounting the file system.

 -- Macro: int EREMOTE
     An attempt was made to NFS-mount a remote file system with a file
     name that already specifies an NFS-mounted file.  (This is an
     error on some operating systems, but we expect it to work properly
     on GNU/Hurd systems, making this error code impossible.)

 -- Macro: int EBADRPC
     ???

 -- Macro: int ERPCMISMATCH
     ???

 -- Macro: int EPROGUNAVAIL
     ???

 -- Macro: int EPROGMISMATCH
     ???

 -- Macro: int EPROCUNAVAIL
     ???

 -- Macro: int ENOLCK
     No locks available.  This is used by the file locking facilities;
     see *note File Locks::.  This error is never generated by GNU/Hurd
     systems, but it can result from an operation to an NFS server
     running another operating system.

 -- Macro: int EFTYPE
     Inappropriate file type or format.  The file was the wrong type
     for the operation, or a data file had the wrong format.

     On some systems `chmod' returns this error if you try to set the
     sticky bit on a non-directory file; *note Setting Permissions::.

 -- Macro: int EAUTH
     ???

 -- Macro: int ENEEDAUTH
     ???

 -- Macro: int ENOSYS
     Function not implemented.  This indicates that the function called
     is not implemented at all, either in the C library itself or in the
     operating system.  When you get this error, you can be sure that
     this particular function will always fail with `ENOSYS' unless you
     install a new version of the C library or the operating system.

 -- Macro: int ENOTSUP
     Not supported.  A function returns this error when certain
     parameter values are valid, but the functionality they request is
     not available.  This can mean that the function does not implement
     a particular command or option value or flag bit at all.  For
     functions that operate on some object given in a parameter, such
     as a file descriptor or a port, it might instead mean that only
     _that specific object_ (file descriptor, port, etc.) is unable to
     support the other parameters given; different file descriptors
     might support different ranges of parameter values.

     If the entire function is not available at all in the
     implementation, it returns `ENOSYS' instead.

 -- Macro: int EILSEQ
     While decoding a multibyte character the function came along an
     invalid or an incomplete sequence of bytes or the given wide
     character is invalid.

 -- Macro: int EBACKGROUND
     On GNU/Hurd systems, servers supporting the `term' protocol return
     this error for certain operations when the caller is not in the
     foreground process group of the terminal.  Users do not usually
     see this error because functions such as `read' and `write'
     translate it into a `SIGTTIN' or `SIGTTOU' signal.  *Note Job
     Control::, for information on process groups and these signals.

 -- Macro: int EDIED
     On GNU/Hurd systems, opening a file returns this error when the
     file is translated by a program and the translator program dies
     while starting up, before it has connected to the file.

 -- Macro: int ED
     The experienced user will know what is wrong.

 -- Macro: int EGREGIOUS
     You did *what*?

 -- Macro: int EIEIO
     Go home and have a glass of warm, dairy-fresh milk.

 -- Macro: int EGRATUITOUS
     This error code has no purpose.

 -- Macro: int EBADMSG

 -- Macro: int EIDRM

 -- Macro: int EMULTIHOP

 -- Macro: int ENODATA

 -- Macro: int ENOLINK

 -- Macro: int ENOMSG

 -- Macro: int ENOSR

 -- Macro: int ENOSTR

 -- Macro: int EOVERFLOW

 -- Macro: int EPROTO

 -- Macro: int ETIME

 -- Macro: int ECANCELED
     Operation canceled; an asynchronous operation was canceled before
     it completed.  *Note Asynchronous I/O::.  When you call
     `aio_cancel', the normal result is for the operations affected to
     complete with this error; *note Cancel AIO Operations::.

   _The following error codes are defined by the Linux/i386 kernel.
They are not yet documented._

 -- Macro: int ERESTART

 -- Macro: int ECHRNG

 -- Macro: int EL2NSYNC

 -- Macro: int EL3HLT

 -- Macro: int EL3RST

 -- Macro: int ELNRNG

 -- Macro: int EUNATCH

 -- Macro: int ENOCSI

 -- Macro: int EL2HLT

 -- Macro: int EBADE

 -- Macro: int EBADR

 -- Macro: int EXFULL

 -- Macro: int ENOANO

 -- Macro: int EBADRQC

 -- Macro: int EBADSLT

 -- Macro: int EDEADLOCK

 -- Macro: int EBFONT

 -- Macro: int ENONET

 -- Macro: int ENOPKG

 -- Macro: int EADV

 -- Macro: int ESRMNT

 -- Macro: int ECOMM

 -- Macro: int EDOTDOT

 -- Macro: int ENOTUNIQ

 -- Macro: int EBADFD

 -- Macro: int EREMCHG

 -- Macro: int ELIBACC

 -- Macro: int ELIBBAD

 -- Macro: int ELIBSCN

 -- Macro: int ELIBMAX

 -- Macro: int ELIBEXEC

 -- Macro: int ESTRPIPE

 -- Macro: int EUCLEAN

 -- Macro: int ENOTNAM

 -- Macro: int ENAVAIL

 -- Macro: int EISNAM

 -- Macro: int EREMOTEIO

 -- Macro: int ENOMEDIUM

 -- Macro: int EMEDIUMTYPE

 -- Macro: int ENOKEY

 -- Macro: int EKEYEXPIRED

 -- Macro: int EKEYREVOKED

 -- Macro: int EKEYREJECTED

 -- Macro: int EOWNERDEAD

 -- Macro: int ENOTRECOVERABLE

 -- Macro: int ERFKILL

 -- Macro: int EHWPOISON

