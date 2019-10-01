File: libc.info,  Node: Generic Conversion Interface,  Next: iconv Examples,  Up: Generic Charset Conversion

6.5.1 Generic Character Set Conversion Interface
------------------------------------------------

This set of functions follows the traditional cycle of using a resource:
open-use-close.  The interface consists of three functions, each of
which implements one step.

   Before the interfaces are described it is necessary to introduce a
data type.  Just like other open-use-close interfaces the functions
introduced here work using handles and the 'iconv.h' header defines a
special type for the handles used.

 -- Data Type: iconv_t
     This data type is an abstract type defined in 'iconv.h'.  The user
     must not assume anything about the definition of this type; it must
     be completely opaque.

     Objects of this type can get assigned handles for the conversions
     using the 'iconv' functions.  The objects themselves need not be
     freed, but the conversions for which the handles stand for have to.

The first step is the function to create a handle.

 -- Function: iconv_t iconv_open (const char *TOCODE, const char
          *FROMCODE)
     Preliminary: | MT-Safe locale | AS-Unsafe corrupt heap lock dlopen
     | AC-Unsafe corrupt lock mem fd | *Note POSIX Safety Concepts::.

     The 'iconv_open' function has to be used before starting a
     conversion.  The two parameters this function takes determine the
     source and destination character set for the conversion, and if the
     implementation has the possibility to perform such a conversion,
     the function returns a handle.

     If the wanted conversion is not available, the 'iconv_open'
     function returns '(iconv_t) -1'.  In this case the global variable
     'errno' can have the following values:

     'EMFILE'
          The process already has 'OPEN_MAX' file descriptors open.
     'ENFILE'
          The system limit of open file is reached.
     'ENOMEM'
          Not enough memory to carry out the operation.
     'EINVAL'
          The conversion from FROMCODE to TOCODE is not supported.

     It is not possible to use the same descriptor in different threads
     to perform independent conversions.  The data structures associated
     with the descriptor include information about the conversion state.
     This must not be messed up by using it in different conversions.

     An 'iconv' descriptor is like a file descriptor as for every use a
     new descriptor must be created.  The descriptor does not stand for
     all of the conversions from FROMSET to TOSET.

     The GNU C Library implementation of 'iconv_open' has one
     significant extension to other implementations.  To ease the
     extension of the set of available conversions, the implementation
     allows storing the necessary files with data and code in an
     arbitrary number of directories.  How this extension must be
     written will be explained below (*note glibc iconv
     Implementation::).  Here it is only important to say that all
     directories mentioned in the 'GCONV_PATH' environment variable are
     considered only if they contain a file 'gconv-modules'.  These
     directories need not necessarily be created by the system
     administrator.  In fact, this extension is introduced to help users
     writing and using their own, new conversions.  Of course, this does
     not work for security reasons in SUID binaries; in this case only
     the system directory is considered and this normally is
     'PREFIX/lib/gconv'.  The 'GCONV_PATH' environment variable is
     examined exactly once at the first call of the 'iconv_open'
     function.  Later modifications of the variable have no effect.

     The 'iconv_open' function was introduced early in the X/Open
     Portability Guide, version 2.  It is supported by all commercial
     Unices as it is required for the Unix branding.  However, the
     quality and completeness of the implementation varies widely.  The
     'iconv_open' function is declared in 'iconv.h'.

   The 'iconv' implementation can associate large data structure with
the handle returned by 'iconv_open'.  Therefore, it is crucial to free
all the resources once all conversions are carried out and the
conversion is not needed anymore.

 -- Function: int iconv_close (iconv_t CD)
     Preliminary: | MT-Safe | AS-Unsafe corrupt heap lock dlopen |
     AC-Unsafe corrupt lock mem | *Note POSIX Safety Concepts::.

     The 'iconv_close' function frees all resources associated with the
     handle CD, which must have been returned by a successful call to
     the 'iconv_open' function.

     If the function call was successful the return value is 0.
     Otherwise it is -1 and 'errno' is set appropriately.  Defined error
     are:

     'EBADF'
          The conversion descriptor is invalid.

     The 'iconv_close' function was introduced together with the rest of
     the 'iconv' functions in XPG2 and is declared in 'iconv.h'.

   The standard defines only one actual conversion function.  This has,
therefore, the most general interface: it allows conversion from one
buffer to another.  Conversion from a file to a buffer, vice versa, or
even file to file can be implemented on top of it.

 -- Function: size_t iconv (iconv_t CD, char **INBUF, size_t
          *INBYTESLEFT, char **OUTBUF, size_t *OUTBYTESLEFT)
     Preliminary: | MT-Safe race:cd | AS-Safe | AC-Unsafe corrupt |
     *Note POSIX Safety Concepts::.

     The 'iconv' function converts the text in the input buffer
     according to the rules associated with the descriptor CD and stores
     the result in the output buffer.  It is possible to call the
     function for the same text several times in a row since for
     stateful character sets the necessary state information is kept in
     the data structures associated with the descriptor.

     The input buffer is specified by '*INBUF' and it contains
     '*INBYTESLEFT' bytes.  The extra indirection is necessary for
     communicating the used input back to the caller (see below).  It is
     important to note that the buffer pointer is of type 'char' and the
     length is measured in bytes even if the input text is encoded in
     wide characters.

     The output buffer is specified in a similar way.  '*OUTBUF' points
     to the beginning of the buffer with at least '*OUTBYTESLEFT' bytes
     room for the result.  The buffer pointer again is of type 'char'
     and the length is measured in bytes.  If OUTBUF or '*OUTBUF' is a
     null pointer, the conversion is performed but no output is
     available.

     If INBUF is a null pointer, the 'iconv' function performs the
     necessary action to put the state of the conversion into the
     initial state.  This is obviously a no-op for non-stateful
     encodings, but if the encoding has a state, such a function call
     might put some byte sequences in the output buffer, which perform
     the necessary state changes.  The next call with INBUF not being a
     null pointer then simply goes on from the initial state.  It is
     important that the programmer never makes any assumption as to
     whether the conversion has to deal with states.  Even if the input
     and output character sets are not stateful, the implementation
     might still have to keep states.  This is due to the implementation
     chosen for the GNU C Library as it is described below.  Therefore
     an 'iconv' call to reset the state should always be performed if
     some protocol requires this for the output text.

     The conversion stops for one of three reasons.  The first is that
     all characters from the input buffer are converted.  This actually
     can mean two things: either all bytes from the input buffer are
     consumed or there are some bytes at the end of the buffer that
     possibly can form a complete character but the input is incomplete.
     The second reason for a stop is that the output buffer is full.
     And the third reason is that the input contains invalid characters.

     In all of these cases the buffer pointers after the last successful
     conversion, for input and output buffer, are stored in INBUF and
     OUTBUF, and the available room in each buffer is stored in
     INBYTESLEFT and OUTBYTESLEFT.

     Since the character sets selected in the 'iconv_open' call can be
     almost arbitrary, there can be situations where the input buffer
     contains valid characters, which have no identical representation
     in the output character set.  The behavior in this situation is
     undefined.  The _current_ behavior of the GNU C Library in this
     situation is to return with an error immediately.  This certainly
     is not the most desirable solution; therefore, future versions will
     provide better ones, but they are not yet finished.

     If all input from the input buffer is successfully converted and
     stored in the output buffer, the function returns the number of
     non-reversible conversions performed.  In all other cases the
     return value is '(size_t) -1' and 'errno' is set appropriately.  In
     such cases the value pointed to by INBYTESLEFT is nonzero.

     'EILSEQ'
          The conversion stopped because of an invalid byte sequence in
          the input.  After the call, '*INBUF' points at the first byte
          of the invalid byte sequence.

     'E2BIG'
          The conversion stopped because it ran out of space in the
          output buffer.

     'EINVAL'
          The conversion stopped because of an incomplete byte sequence
          at the end of the input buffer.

     'EBADF'
          The CD argument is invalid.

     The 'iconv' function was introduced in the XPG2 standard and is
     declared in the 'iconv.h' header.

   The definition of the 'iconv' function is quite good overall.  It
provides quite flexible functionality.  The only problems lie in the
boundary cases, which are incomplete byte sequences at the end of the
input buffer and invalid input.  A third problem, which is not really a
design problem, is the way conversions are selected.  The standard does
not say anything about the legitimate names, a minimal set of available
conversions.  We will see how this negatively impacts other
implementations, as demonstrated below.

