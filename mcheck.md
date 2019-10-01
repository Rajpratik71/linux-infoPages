File: libc.info,  Node: Heap Consistency Checking,  Next: Hooks for Malloc,  Prev: Malloc Tunable Parameters,  Up: Unconstrained Allocation

3.2.2.9 Heap Consistency Checking
.................................

You can ask 'malloc' to check the consistency of dynamic memory by using
the 'mcheck' function.  This function is a GNU extension, declared in
'mcheck.h'.

 -- Function: int mcheck (void (*ABORTFN) (enum mcheck_status STATUS))
     Preliminary: | MT-Unsafe race:mcheck const:malloc_hooks | AS-Unsafe
     corrupt | AC-Unsafe corrupt | *Note POSIX Safety Concepts::.

     Calling 'mcheck' tells 'malloc' to perform occasional consistency
     checks.  These will catch things such as writing past the end of a
     block that was allocated with 'malloc'.

     The ABORTFN argument is the function to call when an inconsistency
     is found.  If you supply a null pointer, then 'mcheck' uses a
     default function which prints a message and calls 'abort' (*note
     Aborting a Program::).  The function you supply is called with one
     argument, which says what sort of inconsistency was detected; its
     type is described below.

     It is too late to begin allocation checking once you have allocated
     anything with 'malloc'.  So 'mcheck' does nothing in that case.
     The function returns '-1' if you call it too late, and '0'
     otherwise (when it is successful).

     The easiest way to arrange to call 'mcheck' early enough is to use
     the option '-lmcheck' when you link your program; then you don't
     need to modify your program source at all.  Alternatively you might
     use a debugger to insert a call to 'mcheck' whenever the program is
     started, for example these gdb commands will automatically call
     'mcheck' whenever the program starts:

          (gdb) break main
          Breakpoint 1, main (argc=2, argv=0xbffff964) at whatever.c:10
          (gdb) command 1
          Type commands for when breakpoint 1 is hit, one per line.
          End with a line saying just "end".
          >call mcheck(0)
          >continue
          >end
          (gdb) ...

     This will however only work if no initialization function of any
     object involved calls any of the 'malloc' functions since 'mcheck'
     must be called before the first such function.

 -- Function: enum mcheck_status mprobe (void *POINTER)
     Preliminary: | MT-Unsafe race:mcheck const:malloc_hooks | AS-Unsafe
     corrupt | AC-Unsafe corrupt | *Note POSIX Safety Concepts::.

     The 'mprobe' function lets you explicitly check for inconsistencies
     in a particular allocated block.  You must have already called
     'mcheck' at the beginning of the program, to do its occasional
     checks; calling 'mprobe' requests an additional consistency check
     to be done at the time of the call.

     The argument POINTER must be a pointer returned by 'malloc' or
     'realloc'.  'mprobe' returns a value that says what inconsistency,
     if any, was found.  The values are described below.

 -- Data Type: enum mcheck_status
     This enumerated type describes what kind of inconsistency was
     detected in an allocated block, if any.  Here are the possible
     values:

     'MCHECK_DISABLED'
          'mcheck' was not called before the first allocation.  No
          consistency checking can be done.
     'MCHECK_OK'
          No inconsistency detected.
     'MCHECK_HEAD'
          The data immediately before the block was modified.  This
          commonly happens when an array index or pointer is decremented
          too far.
     'MCHECK_TAIL'
          The data immediately after the block was modified.  This
          commonly happens when an array index or pointer is incremented
          too far.
     'MCHECK_FREE'
          The block was already freed.

   Another possibility to check for and guard against bugs in the use of
'malloc', 'realloc' and 'free' is to set the environment variable
'MALLOC_CHECK_'.  When 'MALLOC_CHECK_' is set, a special (less
efficient) implementation is used which is designed to be tolerant
against simple errors, such as double calls of 'free' with the same
argument, or overruns of a single byte (off-by-one bugs).  Not all such
errors can be protected against, however, and memory leaks can result.
If 'MALLOC_CHECK_' is set to '0', any detected heap corruption is
silently ignored; if set to '1', a diagnostic is printed on 'stderr'; if
set to '2', 'abort' is called immediately.  This can be useful because
otherwise a crash may happen much later, and the true cause for the
problem is then very hard to track down.

   There is one problem with 'MALLOC_CHECK_': in SUID or SGID binaries
it could possibly be exploited since diverging from the normal programs
behavior it now writes something to the standard error descriptor.
Therefore the use of 'MALLOC_CHECK_' is disabled by default for SUID and
SGID binaries.  It can be enabled again by the system administrator by
adding a file '/etc/suid-debug' (the content is not important it could
be empty).

   So, what's the difference between using 'MALLOC_CHECK_' and linking
with '-lmcheck'?  'MALLOC_CHECK_' is orthogonal with respect to
'-lmcheck'.  '-lmcheck' has been added for backward compatibility.  Both
'MALLOC_CHECK_' and '-lmcheck' should uncover the same bugs - but using
'MALLOC_CHECK_' you don't need to recompile your application.

