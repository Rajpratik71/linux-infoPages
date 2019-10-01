File: libc.info,  Node: BSD Terminal Modes,  Next: Line Control,  Prev: Terminal Modes,  Up: Low-Level Terminal Interface

17.5 BSD Terminal Modes
=======================

The usual way to get and set terminal modes is with the functions
described in *note Terminal Modes::.  However, on some systems you can
use the BSD-derived functions in this section to do some of the same
thing.  On many systems, these functions do not exist.  Even with the
GNU C Library, the functions simply fail with 'errno' = 'ENOSYS' with
many kernels, including Linux.

   The symbols used in this section are declared in 'sgtty.h'.

 -- Data Type: struct sgttyb
     This structure is an input or output parameter list for 'gtty' and
     'stty'.

     'char sg_ispeed'
          Line speed for input
     'char sg_ospeed'
          Line speed for output
     'char sg_erase'
          Erase character
     'char sg_kill'
          Kill character
     'int sg_flags'
          Various flags

 -- Function: int gtty (int FILEDES, struct sgttyb *ATTRIBUTES)
     Preliminary: | MT-Safe | AS-Safe | AC-Safe | *Note POSIX Safety
     Concepts::.

     This function gets the attributes of a terminal.

     'gtty' sets *ATTRIBUTES to describe the terminal attributes of the
     terminal which is open with file descriptor FILEDES.

 -- Function: int stty (int FILEDES, const struct sgttyb *ATTRIBUTES)
     Preliminary: | MT-Safe | AS-Safe | AC-Safe | *Note POSIX Safety
     Concepts::.

     This function sets the attributes of a terminal.

     'stty' sets the terminal attributes of the terminal which is open
     with file descriptor FILEDES to those described by *FILEDES.

