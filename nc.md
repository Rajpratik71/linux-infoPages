File: libc.info,  Node: Mode Data Types,  Next: Mode Functions,  Up: Terminal Modes

17.4.1 Terminal Mode Data Types
-------------------------------

The entire collection of attributes of a terminal is stored in a
structure of type `struct termios'.  This structure is used with the
functions `tcgetattr' and `tcsetattr' to read and set the attributes.

 -- Data Type: struct termios
     Structure that records all the I/O attributes of a terminal.  The
     structure includes at least the following members:

    `tcflag_t c_iflag'
          A bit mask specifying flags for input modes; see *note Input
          Modes::.

    `tcflag_t c_oflag'
          A bit mask specifying flags for output modes; see *note
          Output Modes::.

    `tcflag_t c_cflag'
          A bit mask specifying flags for control modes; see *note
          Control Modes::.

    `tcflag_t c_lflag'
          A bit mask specifying flags for local modes; see *note Local
          Modes::.

    `cc_t c_cc[NCCS]'
          An array specifying which characters are associated with
          various control functions; see *note Special Characters::.

     The `struct termios' structure also contains members which encode
     input and output transmission speeds, but the representation is
     not specified.  *Note Line Speed::, for how to examine and store
     the speed values.

   The following sections describe the details of the members of the
`struct termios' structure.

 -- Data Type: tcflag_t
     This is an unsigned integer type used to represent the various bit
     masks for terminal flags.

 -- Data Type: cc_t
     This is an unsigned integer type used to represent characters
     associated with various terminal control functions.

 -- Macro: int NCCS
     The value of this macro is the number of elements in the `c_cc'
     array.

