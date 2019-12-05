File: coreutils.info,  Node: uname invocation,  Next: hostname invocation,  Prev: nproc invocation,  Up: System context

21.4 ‘uname’: Print system information
======================================

‘uname’ prints information about the machine and operating system it is
run on.  If no options are given, ‘uname’ acts as if the ‘-s’ option
were given.  Synopsis:

     uname [OPTION]...

   If multiple options or ‘-a’ are given, the selected information is
printed in this order:

     KERNEL-NAME NODENAME KERNEL-RELEASE KERNEL-VERSION
     MACHINE PROCESSOR HARDWARE-PLATFORM OPERATING-SYSTEM

   The information may contain internal spaces, so such output cannot be
parsed reliably.  In the following example, RELEASE is
‘2.2.18ss.e820-bda652a #4 SMP Tue Jun 5 11:24:08 PDT 2001’:

     uname -a
     ⇒ Linux dumdum 2.2.18 #4 SMP Tue Jun 5 11:24:08 PDT 2001 i686 unknown unknown GNU/Linux

   The program accepts the following options.  Also see *note Common
options::.

‘-a’
‘--all’
     Print all of the below information, except omit the processor type
     and the hardware platform name if they are unknown.

‘-i’
‘--hardware-platform’
     Print the hardware platform name (sometimes called the hardware
     implementation).  Print ‘unknown’ if this information is not
     available.  Note this is non-portable (even across GNU/Linux
     distributions).

‘-m’
‘--machine’
     Print the machine hardware name (sometimes called the hardware
     class or hardware type).

‘-n’
‘--nodename’
     Print the network node hostname.

‘-p’
‘--processor’
     Print the processor type (sometimes called the instruction set
     architecture or ISA). Print ‘unknown’ if this information is not
     available.  Note this is non-portable (even across GNU/Linux
     distributions).

‘-o’
‘--operating-system’
     Print the name of the operating system.

‘-r’
‘--kernel-release’
     Print the kernel release.

‘-s’
‘--kernel-name’
     Print the kernel name.  POSIX 1003.1-2001 (*note Standards
     conformance::) calls this “the implementation of the operating
     system”, because the POSIX specification itself has no notion of
     “kernel”.  The kernel name might be the same as the operating
     system name printed by the ‘-o’ or ‘--operating-system’ option, but
     it might differ.  Some operating systems (e.g., FreeBSD, HP-UX)
     have the same name as their underlying kernels; others (e.g.,
     GNU/Linux, Solaris) do not.

‘-v’
‘--kernel-version’
     Print the kernel version.

   An exit status of zero indicates success, and a nonzero value
indicates failure.

