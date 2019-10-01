File: libc.info,  Node: System Parameters,  Prev: Filesystem Handling,  Up: System Management

31.4 System Parameters
======================

This section describes the 'sysctl' function, which gets and sets a
variety of system parameters.

   The symbols used in this section are declared in the file
'sys/sysctl.h'.

 -- Function: int sysctl (int *NAMES, int NLEN, void *OLDVAL, size_t
          *OLDLENP, void *NEWVAL, size_t NEWLEN)
     Preliminary: | MT-Safe | AS-Safe | AC-Safe | *Note POSIX Safety
     Concepts::.

     'sysctl' gets or sets a specified system parameter.  There are so
     many of these parameters that it is not practical to list them all
     here, but here are some examples:

        * network domain name
        * paging parameters
        * network Address Resolution Protocol timeout time
        * maximum number of files that may be open
        * root filesystem device
        * when kernel was built

     The set of available parameters depends on the kernel configuration
     and can change while the system is running, particularly when you
     load and unload loadable kernel modules.

     The system parameters with which 'syslog' is concerned are arranged
     in a hierarchical structure like a hierarchical filesystem.  To
     identify a particular parameter, you specify a path through the
     structure in a way analogous to specifying the pathname of a file.
     Each component of the path is specified by an integer and each of
     these integers has a macro defined for it by 'sys/sysctl.h'.  NAMES
     is the path, in the form of an array of integers.  Each component
     of the path is one element of the array, in order.  NLEN is the
     number of components in the path.

     For example, the first component of the path for all the paging
     parameters is the value 'CTL_VM'.  For the free page thresholds,
     the second component of the path is 'VM_FREEPG'.  So to get the
     free page threshold values, make NAMES an array containing the two
     elements 'CTL_VM' and 'VM_FREEPG' and make NLEN = 2.

     The format of the value of a parameter depends on the parameter.
     Sometimes it is an integer; sometimes it is an ASCII string;
     sometimes it is an elaborate structure.  In the case of the free
     page thresholds used in the example above, the parameter value is a
     structure containing several integers.

     In any case, you identify a place to return the parameter's value
     with OLDVAL and specify the amount of storage available at that
     location as *OLDLENP.  *OLDLENP does double duty because it is also
     the output location that contains the actual length of the returned
     value.

     If you don't want the parameter value returned, specify a null
     pointer for OLDVAL.

     To set the parameter, specify the address and length of the new
     value as NEWVAL and NEWLEN.  If you don't want to set the
     parameter, specify a null pointer as NEWVAL.

     If you get and set a parameter in the same 'sysctl' call, the value
     returned is the value of the parameter before it was set.

     Each system parameter has a set of permissions similar to the
     permissions for a file (including the permissions on directories in
     its path) that determine whether you may get or set it.  For the
     purposes of these permissions, every parameter is considered to be
     owned by the superuser and Group 0 so processes with that effective
     uid or gid may have more access to system parameters.  Unlike with
     files, the superuser does not invariably have full permission to
     all system parameters, because some of them are designed not to be
     changed ever.

     'sysctl' returns a zero return value if it succeeds.  Otherwise, it
     returns '-1' and sets 'errno' appropriately.  Besides the failures
     that apply to all system calls, the following are the 'errno' codes
     for all possible failures:

     'EPERM'
          The process is not permitted to access one of the components
          of the path of the system parameter or is not permitted to
          access the system parameter itself in the way (read or write)
          that it requested.
     'ENOTDIR'
          There is no system parameter corresponding to NAME.
     'EFAULT'
          OLDVAL is not null, which means the process wanted to read the
          parameter, but *OLDLENP is zero, so there is no place to
          return it.
     'EINVAL'
             * The process attempted to set a system parameter to a
               value that is not valid for that parameter.
             * The space provided for the return of the system parameter
               is not the right size for that parameter.
     'ENOMEM'
          This value may be returned instead of the more correct
          'EINVAL' in some cases where the space provided for the return
          of the system parameter is too small.

   If you have a Linux kernel with the 'proc' filesystem, you can get
and set most of the same parameters by reading and writing to files in
the 'sys' directory of the 'proc' filesystem.  In the 'sys' directory,
the directory structure represents the hierarchical structure of the
parameters.  E.g.  you can display the free page thresholds with
     cat /proc/sys/vm/freepages

   Some more traditional and more widely available, though less general,
GNU C Library functions for getting and setting some of the same system
parameters are:

   * 'getdomainname', 'setdomainname'
   * 'gethostname', 'sethostname' (*Note Host Identification::.)
   * 'uname' (*Note Platform Type::.)
   * 'bdflush'

