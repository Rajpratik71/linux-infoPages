File: libc.info,  Node: Finding Tokens in a String,  Next: strfry,  Prev: Search Functions,  Up: String and Array Utilities

5.8 Finding Tokens in a String
==============================

It's fairly common for programs to have a need to do some simple kinds
of lexical analysis and parsing, such as splitting a command string up
into tokens.  You can do this with the 'strtok' function, declared in
the header file 'string.h'.

 -- Function: char * strtok (char *restrict NEWSTRING, const char
          *restrict DELIMITERS)
     Preliminary: | MT-Unsafe race:strtok | AS-Unsafe | AC-Safe | *Note
     POSIX Safety Concepts::.

     A string can be split into tokens by making a series of calls to
     the function 'strtok'.

     The string to be split up is passed as the NEWSTRING argument on
     the first call only.  The 'strtok' function uses this to set up
     some internal state information.  Subsequent calls to get
     additional tokens from the same string are indicated by passing a
     null pointer as the NEWSTRING argument.  Calling 'strtok' with
     another non-null NEWSTRING argument reinitializes the state
     information.  It is guaranteed that no other library function ever
     calls 'strtok' behind your back (which would mess up this internal
     state information).

     The DELIMITERS argument is a string that specifies a set of
     delimiters that may surround the token being extracted.  All the
     initial characters that are members of this set are discarded.  The
     first character that is _not_ a member of this set of delimiters
     marks the beginning of the next token.  The end of the token is
     found by looking for the next character that is a member of the
     delimiter set.  This character in the original string NEWSTRING is
     overwritten by a null character, and the pointer to the beginning
     of the token in NEWSTRING is returned.

     On the next call to 'strtok', the searching begins at the next
     character beyond the one that marked the end of the previous token.
     Note that the set of delimiters DELIMITERS do not have to be the
     same on every call in a series of calls to 'strtok'.

     If the end of the string NEWSTRING is reached, or if the remainder
     of string consists only of delimiter characters, 'strtok' returns a
     null pointer.

     Note that "character" is here used in the sense of byte.  In a
     string using a multibyte character encoding (abstract) character
     consisting of more than one byte are not treated as an entity.
     Each byte is treated separately.  The function is not
     locale-dependent.

 -- Function: wchar_t * wcstok (wchar_t *NEWSTRING, const wchar_t
          *DELIMITERS, wchar_t **SAVE_PTR)
     Preliminary: | MT-Safe | AS-Safe | AC-Safe | *Note POSIX Safety
     Concepts::.

     A string can be split into tokens by making a series of calls to
     the function 'wcstok'.

     The string to be split up is passed as the NEWSTRING argument on
     the first call only.  The 'wcstok' function uses this to set up
     some internal state information.  Subsequent calls to get
     additional tokens from the same wide character string are indicated
     by passing a null pointer as the NEWSTRING argument, which causes
     the pointer previously stored in SAVE_PTR to be used instead.

     The DELIMITERS argument is a wide character string that specifies a
     set of delimiters that may surround the token being extracted.  All
     the initial wide characters that are members of this set are
     discarded.  The first wide character that is _not_ a member of this
     set of delimiters marks the beginning of the next token.  The end
     of the token is found by looking for the next wide character that
     is a member of the delimiter set.  This wide character in the
     original wide character string NEWSTRING is overwritten by a null
     wide character, the pointer past the overwritten wide character is
     saved in SAVE_PTR, and the pointer to the beginning of the token in
     NEWSTRING is returned.

     On the next call to 'wcstok', the searching begins at the next wide
     character beyond the one that marked the end of the previous token.
     Note that the set of delimiters DELIMITERS do not have to be the
     same on every call in a series of calls to 'wcstok'.

     If the end of the wide character string NEWSTRING is reached, or if
     the remainder of string consists only of delimiter wide characters,
     'wcstok' returns a null pointer.

   *Warning:* Since 'strtok' and 'wcstok' alter the string they is
parsing, you should always copy the string to a temporary buffer before
parsing it with 'strtok'/'wcstok' (*note Copying and Concatenation::).
If you allow 'strtok' or 'wcstok' to modify a string that came from
another part of your program, you are asking for trouble; that string
might be used for other purposes after 'strtok' or 'wcstok' has modified
it, and it would not have the expected value.

   The string that you are operating on might even be a constant.  Then
when 'strtok' or 'wcstok' tries to modify it, your program will get a
fatal signal for writing in read-only memory.  *Note Program Error
Signals::.  Even if the operation of 'strtok' or 'wcstok' would not
require a modification of the string (e.g., if there is exactly one
token) the string can (and in the GNU C Library case will) be modified.

   This is a special case of a general principle: if a part of a program
does not have as its purpose the modification of a certain data
structure, then it is error-prone to modify the data structure
temporarily.

   The function 'strtok' is not reentrant, whereas 'wcstok' is.  *Note
Nonreentrancy::, for a discussion of where and why reentrancy is
important.

   Here is a simple example showing the use of 'strtok'.

     #include <string.h>
     #include <stddef.h>

     ...

     const char string[] = "words separated by spaces -- and, punctuation!";
     const char delimiters[] = " .,;:!-";
     char *token, *cp;

     ...

     cp = strdupa (string);                /* Make writable copy.  */
     token = strtok (cp, delimiters);      /* token => "words" */
     token = strtok (NULL, delimiters);    /* token => "separated" */
     token = strtok (NULL, delimiters);    /* token => "by" */
     token = strtok (NULL, delimiters);    /* token => "spaces" */
     token = strtok (NULL, delimiters);    /* token => "and" */
     token = strtok (NULL, delimiters);    /* token => "punctuation" */
     token = strtok (NULL, delimiters);    /* token => NULL */

   The GNU C Library contains two more functions for tokenizing a string
which overcome the limitation of non-reentrancy.  They are only
available for multibyte character strings.

 -- Function: char * strtok_r (char *NEWSTRING, const char *DELIMITERS,
          char **SAVE_PTR)
     Preliminary: | MT-Safe | AS-Safe | AC-Safe | *Note POSIX Safety
     Concepts::.

     Just like 'strtok', this function splits the string into several
     tokens which can be accessed by successive calls to 'strtok_r'.
     The difference is that, as in 'wcstok', the information about the
     next token is stored in the space pointed to by the third argument,
     SAVE_PTR, which is a pointer to a string pointer.  Calling
     'strtok_r' with a null pointer for NEWSTRING and leaving SAVE_PTR
     between the calls unchanged does the job without hindering
     reentrancy.

     This function is defined in POSIX.1 and can be found on many
     systems which support multi-threading.

 -- Function: char * strsep (char **STRING_PTR, const char *DELIMITER)
     Preliminary: | MT-Safe | AS-Safe | AC-Safe | *Note POSIX Safety
     Concepts::.

     This function has a similar functionality as 'strtok_r' with the
     NEWSTRING argument replaced by the SAVE_PTR argument.  The
     initialization of the moving pointer has to be done by the user.
     Successive calls to 'strsep' move the pointer along the tokens
     separated by DELIMITER, returning the address of the next token and
     updating STRING_PTR to point to the beginning of the next token.

     One difference between 'strsep' and 'strtok_r' is that if the input
     string contains more than one character from DELIMITER in a row
     'strsep' returns an empty string for each pair of characters from
     DELIMITER.  This means that a program normally should test for
     'strsep' returning an empty string before processing it.

     This function was introduced in 4.3BSD and therefore is widely
     available.

   Here is how the above example looks like when 'strsep' is used.

     #include <string.h>
     #include <stddef.h>

     ...

     const char string[] = "words separated by spaces -- and, punctuation!";
     const char delimiters[] = " .,;:!-";
     char *running;
     char *token;

     ...

     running = strdupa (string);
     token = strsep (&running, delimiters);    /* token => "words" */
     token = strsep (&running, delimiters);    /* token => "separated" */
     token = strsep (&running, delimiters);    /* token => "by" */
     token = strsep (&running, delimiters);    /* token => "spaces" */
     token = strsep (&running, delimiters);    /* token => "" */
     token = strsep (&running, delimiters);    /* token => "" */
     token = strsep (&running, delimiters);    /* token => "" */
     token = strsep (&running, delimiters);    /* token => "and" */
     token = strsep (&running, delimiters);    /* token => "" */
     token = strsep (&running, delimiters);    /* token => "punctuation" */
     token = strsep (&running, delimiters);    /* token => "" */
     token = strsep (&running, delimiters);    /* token => NULL */

 -- Function: char * basename (const char *FILENAME)
     Preliminary: | MT-Safe | AS-Safe | AC-Safe | *Note POSIX Safety
     Concepts::.

     The GNU version of the 'basename' function returns the last
     component of the path in FILENAME.  This function is the preferred
     usage, since it does not modify the argument, FILENAME, and
     respects trailing slashes.  The prototype for 'basename' can be
     found in 'string.h'.  Note, this function is overriden by the XPG
     version, if 'libgen.h' is included.

     Example of using GNU 'basename':

          #include <string.h>

          int
          main (int argc, char *argv[])
          {
            char *prog = basename (argv[0]);

            if (argc < 2)
              {
                fprintf (stderr, "Usage %s <arg>\n", prog);
                exit (1);
              }

            ...
          }

     *Portability Note:* This function may produce different results on
     different systems.

 -- Function: char * basename (const char *PATH)
     Preliminary: | MT-Safe | AS-Safe | AC-Safe | *Note POSIX Safety
     Concepts::.

     This is the standard XPG defined 'basename'.  It is similar in
     spirit to the GNU version, but may modify the PATH by removing
     trailing '/' characters.  If the PATH is made up entirely of '/'
     characters, then "/" will be returned.  Also, if PATH is 'NULL' or
     an empty string, then "."  is returned.  The prototype for the XPG
     version can be found in 'libgen.h'.

     Example of using XPG 'basename':

          #include <libgen.h>

          int
          main (int argc, char *argv[])
          {
            char *prog;
            char *path = strdupa (argv[0]);

            prog = basename (path);

            if (argc < 2)
              {
                fprintf (stderr, "Usage %s <arg>\n", prog);
                exit (1);
              }

            ...

          }

 -- Function: char * dirname (char *PATH)
     Preliminary: | MT-Safe | AS-Safe | AC-Safe | *Note POSIX Safety
     Concepts::.

     The 'dirname' function is the compliment to the XPG version of
     'basename'.  It returns the parent directory of the file specified
     by PATH.  If PATH is 'NULL', an empty string, or contains no '/'
     characters, then "."  is returned.  The prototype for this function
     can be found in 'libgen.h'.

