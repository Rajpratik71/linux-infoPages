File: libc.info,  Node: Formatted Output Functions,  Next: Dynamic Output,  Prev: Other Output Conversions,  Up: Formatted Output

12.12.7 Formatted Output Functions
----------------------------------

This section describes how to call 'printf' and related functions.
Prototypes for these functions are in the header file 'stdio.h'.
Because these functions take a variable number of arguments, you _must_
declare prototypes for them before using them.  Of course, the easiest
way to make sure you have all the right prototypes is to just include
'stdio.h'.

 -- Function: int printf (const char *TEMPLATE, ...)
     Preliminary: | MT-Safe locale | AS-Unsafe corrupt heap | AC-Unsafe
     mem lock corrupt | *Note POSIX Safety Concepts::.

     The 'printf' function prints the optional arguments under the
     control of the template string TEMPLATE to the stream 'stdout'.  It
     returns the number of characters printed, or a negative value if
     there was an output error.

 -- Function: int wprintf (const wchar_t *TEMPLATE, ...)
     Preliminary: | MT-Safe locale | AS-Unsafe corrupt heap | AC-Unsafe
     mem lock corrupt | *Note POSIX Safety Concepts::.

     The 'wprintf' function prints the optional arguments under the
     control of the wide template string TEMPLATE to the stream
     'stdout'.  It returns the number of wide characters printed, or a
     negative value if there was an output error.

 -- Function: int fprintf (FILE *STREAM, const char *TEMPLATE, ...)
     Preliminary: | MT-Safe locale | AS-Unsafe corrupt heap | AC-Unsafe
     mem lock corrupt | *Note POSIX Safety Concepts::.

     This function is just like 'printf', except that the output is
     written to the stream STREAM instead of 'stdout'.

 -- Function: int fwprintf (FILE *STREAM, const wchar_t *TEMPLATE, ...)
     Preliminary: | MT-Safe locale | AS-Unsafe corrupt heap | AC-Unsafe
     mem lock corrupt | *Note POSIX Safety Concepts::.

     This function is just like 'wprintf', except that the output is
     written to the stream STREAM instead of 'stdout'.

 -- Function: int sprintf (char *S, const char *TEMPLATE, ...)
     Preliminary: | MT-Safe locale | AS-Unsafe heap | AC-Unsafe mem |
     *Note POSIX Safety Concepts::.

     This is like 'printf', except that the output is stored in the
     character array S instead of written to a stream.  A null character
     is written to mark the end of the string.

     The 'sprintf' function returns the number of characters stored in
     the array S, not including the terminating null character.

     The behavior of this function is undefined if copying takes place
     between objects that overlap--for example, if S is also given as an
     argument to be printed under control of the '%s' conversion.  *Note
     Copying and Concatenation::.

     *Warning:* The 'sprintf' function can be *dangerous* because it can
     potentially output more characters than can fit in the allocation
     size of the string S.  Remember that the field width given in a
     conversion specification is only a _minimum_ value.

     To avoid this problem, you can use 'snprintf' or 'asprintf',
     described below.

 -- Function: int swprintf (wchar_t *S, size_t SIZE, const wchar_t
          *TEMPLATE, ...)
     Preliminary: | MT-Safe locale | AS-Unsafe heap | AC-Unsafe mem |
     *Note POSIX Safety Concepts::.

     This is like 'wprintf', except that the output is stored in the
     wide character array WS instead of written to a stream.  A null
     wide character is written to mark the end of the string.  The SIZE
     argument specifies the maximum number of characters to produce.
     The trailing null character is counted towards this limit, so you
     should allocate at least SIZE wide characters for the string WS.

     The return value is the number of characters generated for the
     given input, excluding the trailing null.  If not all output fits
     into the provided buffer a negative value is returned.  You should
     try again with a bigger output string.  _Note:_ this is different
     from how 'snprintf' handles this situation.

     Note that the corresponding narrow stream function takes fewer
     parameters.  'swprintf' in fact corresponds to the 'snprintf'
     function.  Since the 'sprintf' function can be dangerous and should
     be avoided the ISO C committee refused to make the same mistake
     again and decided to not define a function exactly corresponding to
     'sprintf'.

 -- Function: int snprintf (char *S, size_t SIZE, const char *TEMPLATE,
          ...)
     Preliminary: | MT-Safe locale | AS-Unsafe heap | AC-Unsafe mem |
     *Note POSIX Safety Concepts::.

     The 'snprintf' function is similar to 'sprintf', except that the
     SIZE argument specifies the maximum number of characters to
     produce.  The trailing null character is counted towards this
     limit, so you should allocate at least SIZE characters for the
     string S.  If SIZE is zero, nothing, not even the null byte, shall
     be written and S may be a null pointer.

     The return value is the number of characters which would be
     generated for the given input, excluding the trailing null.  If
     this value is greater or equal to SIZE, not all characters from the
     result have been stored in S.  You should try again with a bigger
     output string.  Here is an example of doing this:

          /* Construct a message describing the value of a variable
             whose name is NAME and whose value is VALUE. */
          char *
          make_message (char *name, char *value)
          {
            /* Guess we need no more than 100 chars of space. */
            int size = 100;
            char *buffer = (char *) xmalloc (size);
            int nchars;
            if (buffer == NULL)
              return NULL;

           /* Try to print in the allocated space. */
            nchars = snprintf (buffer, size, "value of %s is %s",
          		     name, value);
            if (nchars >= size)
              {
                /* Reallocate buffer now that we know
          	 how much space is needed. */
                size = nchars + 1;
                buffer = (char *) xrealloc (buffer, size);

                if (buffer != NULL)
          	/* Try again. */
          	snprintf (buffer, size, "value of %s is %s",
          		  name, value);
              }
            /* The last call worked, return the string. */
            return buffer;
          }

     In practice, it is often easier just to use 'asprintf', below.

     *Attention:* In versions of the GNU C Library prior to 2.1 the
     return value is the number of characters stored, not including the
     terminating null; unless there was not enough space in S to store
     the result in which case '-1' is returned.  This was changed in
     order to comply with the ISO C99 standard.

