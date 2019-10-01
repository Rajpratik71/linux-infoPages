File: libc.info,  Node: Search Functions,  Next: Finding Tokens in a String,  Prev: Collation Functions,  Up: String and Array Utilities

5.7 Search Functions
====================

This section describes library functions which perform various kinds of
searching operations on strings and arrays.  These functions are
declared in the header file 'string.h'.

 -- Function: void * memchr (const void *BLOCK, int C, size_t SIZE)
     Preliminary: | MT-Safe | AS-Safe | AC-Safe | *Note POSIX Safety
     Concepts::.

     This function finds the first occurrence of the byte C (converted
     to an 'unsigned char') in the initial SIZE bytes of the object
     beginning at BLOCK.  The return value is a pointer to the located
     byte, or a null pointer if no match was found.

 -- Function: wchar_t * wmemchr (const wchar_t *BLOCK, wchar_t WC,
          size_t SIZE)
     Preliminary: | MT-Safe | AS-Safe | AC-Safe | *Note POSIX Safety
     Concepts::.

     This function finds the first occurrence of the wide character WC
     in the initial SIZE wide characters of the object beginning at
     BLOCK.  The return value is a pointer to the located wide
     character, or a null pointer if no match was found.

 -- Function: void * rawmemchr (const void *BLOCK, int C)
     Preliminary: | MT-Safe | AS-Safe | AC-Safe | *Note POSIX Safety
     Concepts::.

     Often the 'memchr' function is used with the knowledge that the
     byte C is available in the memory block specified by the
     parameters.  But this means that the SIZE parameter is not really
     needed and that the tests performed with it at runtime (to check
     whether the end of the block is reached) are not needed.

     The 'rawmemchr' function exists for just this situation which is
     surprisingly frequent.  The interface is similar to 'memchr' except
     that the SIZE parameter is missing.  The function will look beyond
     the end of the block pointed to by BLOCK in case the programmer
     made an error in assuming that the byte C is present in the block.
     In this case the result is unspecified.  Otherwise the return value
     is a pointer to the located byte.

     This function is of special interest when looking for the end of a
     string.  Since all strings are terminated by a null byte a call
     like

             rawmemchr (str, '\0')

     will never go beyond the end of the string.

     This function is a GNU extension.

 -- Function: void * memrchr (const void *BLOCK, int C, size_t SIZE)
     Preliminary: | MT-Safe | AS-Safe | AC-Safe | *Note POSIX Safety
     Concepts::.

     The function 'memrchr' is like 'memchr', except that it searches
     backwards from the end of the block defined by BLOCK and SIZE
     (instead of forwards from the front).

     This function is a GNU extension.

 -- Function: char * strchr (const char *STRING, int C)
     Preliminary: | MT-Safe | AS-Safe | AC-Safe | *Note POSIX Safety
     Concepts::.

     The 'strchr' function finds the first occurrence of the character C
     (converted to a 'char') in the null-terminated string beginning at
     STRING.  The return value is a pointer to the located character, or
     a null pointer if no match was found.

     For example,
          strchr ("hello, world", 'l')
              => "llo, world"
          strchr ("hello, world", '?')
              => NULL

     The terminating null character is considered to be part of the
     string, so you can use this function get a pointer to the end of a
     string by specifying a null character as the value of the C
     argument.

     When 'strchr' returns a null pointer, it does not let you know the
     position of the terminating null character it has found.  If you
     need that information, it is better (but less portable) to use
     'strchrnul' than to search for it a second time.

 -- Function: wchar_t * wcschr (const wchar_t *WSTRING, int WC)
     Preliminary: | MT-Safe | AS-Safe | AC-Safe | *Note POSIX Safety
     Concepts::.

     The 'wcschr' function finds the first occurrence of the wide
     character WC in the null-terminated wide character string beginning
     at WSTRING.  The return value is a pointer to the located wide
     character, or a null pointer if no match was found.

     The terminating null character is considered to be part of the wide
     character string, so you can use this function get a pointer to the
     end of a wide character string by specifying a null wude character
     as the value of the WC argument.  It would be better (but less
     portable) to use 'wcschrnul' in this case, though.

 -- Function: char * strchrnul (const char *STRING, int C)
     Preliminary: | MT-Safe | AS-Safe | AC-Safe | *Note POSIX Safety
     Concepts::.

     'strchrnul' is the same as 'strchr' except that if it does not find
     the character, it returns a pointer to string's terminating null
     character rather than a null pointer.

     This function is a GNU extension.

 -- Function: wchar_t * wcschrnul (const wchar_t *WSTRING, wchar_t WC)
     Preliminary: | MT-Safe | AS-Safe | AC-Safe | *Note POSIX Safety
     Concepts::.

     'wcschrnul' is the same as 'wcschr' except that if it does not find
     the wide character, it returns a pointer to wide character string's
     terminating null wide character rather than a null pointer.

     This function is a GNU extension.

   One useful, but unusual, use of the 'strchr' function is when one
wants to have a pointer pointing to the NUL byte terminating a string.
This is often written in this way:

       s += strlen (s);

This is almost optimal but the addition operation duplicated a bit of
the work already done in the 'strlen' function.  A better solution is
this:

       s = strchr (s, '\0');

   There is no restriction on the second parameter of 'strchr' so it
could very well also be the NUL character.  Those readers thinking very
hard about this might now point out that the 'strchr' function is more
expensive than the 'strlen' function since we have two abort criteria.
This is right.  But in the GNU C Library the implementation of 'strchr'
is optimized in a special way so that 'strchr' actually is faster.

 -- Function: char * strrchr (const char *STRING, int C)
     Preliminary: | MT-Safe | AS-Safe | AC-Safe | *Note POSIX Safety
     Concepts::.

     The function 'strrchr' is like 'strchr', except that it searches
     backwards from the end of the string STRING (instead of forwards
     from the front).

     For example,
          strrchr ("hello, world", 'l')
              => "ld"

 -- Function: wchar_t * wcsrchr (const wchar_t *WSTRING, wchar_t C)
     Preliminary: | MT-Safe | AS-Safe | AC-Safe | *Note POSIX Safety
     Concepts::.

     The function 'wcsrchr' is like 'wcschr', except that it searches
     backwards from the end of the string WSTRING (instead of forwards
     from the front).

 -- Function: char * strstr (const char *HAYSTACK, const char *NEEDLE)
     Preliminary: | MT-Safe | AS-Safe | AC-Safe | *Note POSIX Safety
     Concepts::.

     This is like 'strchr', except that it searches HAYSTACK for a
     substring NEEDLE rather than just a single character.  It returns a
     pointer into the string HAYSTACK that is the first character of the
     substring, or a null pointer if no match was found.  If NEEDLE is
     an empty string, the function returns HAYSTACK.

     For example,
          strstr ("hello, world", "l")
              => "llo, world"
          strstr ("hello, world", "wo")
              => "world"

 -- Function: wchar_t * wcsstr (const wchar_t *HAYSTACK, const wchar_t
          *NEEDLE)
     Preliminary: | MT-Safe | AS-Safe | AC-Safe | *Note POSIX Safety
     Concepts::.

     This is like 'wcschr', except that it searches HAYSTACK for a
     substring NEEDLE rather than just a single wide character.  It
     returns a pointer into the string HAYSTACK that is the first wide
     character of the substring, or a null pointer if no match was
     found.  If NEEDLE is an empty string, the function returns
     HAYSTACK.

 -- Function: wchar_t * wcswcs (const wchar_t *HAYSTACK, const wchar_t
          *NEEDLE)
     Preliminary: | MT-Safe | AS-Safe | AC-Safe | *Note POSIX Safety
     Concepts::.

     'wcswcs' is a deprecated alias for 'wcsstr'.  This is the name
     originally used in the X/Open Portability Guide before the Amendment 1
     to ISO C90 was published.

 -- Function: char * strcasestr (const char *HAYSTACK, const char
          *NEEDLE)
     Preliminary: | MT-Safe locale | AS-Safe | AC-Safe | *Note POSIX
     Safety Concepts::.

     This is like 'strstr', except that it ignores case in searching for
     the substring.  Like 'strcasecmp', it is locale dependent how
     uppercase and lowercase characters are related.

     For example,
          strcasestr ("hello, world", "L")
              => "llo, world"
          strcasestr ("hello, World", "wo")
              => "World"

 -- Function: void * memmem (const void *HAYSTACK, size_t HAYSTACK-LEN,
          const void *NEEDLE, size_t NEEDLE-LEN)
     Preliminary: | MT-Safe | AS-Safe | AC-Safe | *Note POSIX Safety
     Concepts::.

     This is like 'strstr', but NEEDLE and HAYSTACK are byte arrays
     rather than null-terminated strings.  NEEDLE-LEN is the length of
     NEEDLE and HAYSTACK-LEN is the length of HAYSTACK.

     This function is a GNU extension.

 -- Function: size_t strspn (const char *STRING, const char *SKIPSET)
     Preliminary: | MT-Safe | AS-Safe | AC-Safe | *Note POSIX Safety
     Concepts::.

     The 'strspn' ("string span") function returns the length of the
     initial substring of STRING that consists entirely of characters
     that are members of the set specified by the string SKIPSET.  The
     order of the characters in SKIPSET is not important.

     For example,
          strspn ("hello, world", "abcdefghijklmnopqrstuvwxyz")
              => 5

     Note that "character" is here used in the sense of byte.  In a
     string using a multibyte character encoding (abstract) character
     consisting of more than one byte are not treated as an entity.
     Each byte is treated separately.  The function is not
     locale-dependent.

 -- Function: size_t wcsspn (const wchar_t *WSTRING, const wchar_t
          *SKIPSET)
     Preliminary: | MT-Safe | AS-Safe | AC-Safe | *Note POSIX Safety
     Concepts::.

     The 'wcsspn' ("wide character string span") function returns the
     length of the initial substring of WSTRING that consists entirely
     of wide characters that are members of the set specified by the
     string SKIPSET.  The order of the wide characters in SKIPSET is not
     important.

 -- Function: size_t strcspn (const char *STRING, const char *STOPSET)
     Preliminary: | MT-Safe | AS-Safe | AC-Safe | *Note POSIX Safety
     Concepts::.

     The 'strcspn' ("string complement span") function returns the
     length of the initial substring of STRING that consists entirely of
     characters that are _not_ members of the set specified by the
     string STOPSET.  (In other words, it returns the offset of the
     first character in STRING that is a member of the set STOPSET.)

     For example,
          strcspn ("hello, world", " \t\n,.;!?")
              => 5

     Note that "character" is here used in the sense of byte.  In a
     string using a multibyte character encoding (abstract) character
     consisting of more than one byte are not treated as an entity.
     Each byte is treated separately.  The function is not
     locale-dependent.

 -- Function: size_t wcscspn (const wchar_t *WSTRING, const wchar_t
          *STOPSET)
     Preliminary: | MT-Safe | AS-Safe | AC-Safe | *Note POSIX Safety
     Concepts::.

     The 'wcscspn' ("wide character string complement span") function
     returns the length of the initial substring of WSTRING that
     consists entirely of wide characters that are _not_ members of the
     set specified by the string STOPSET.  (In other words, it returns
     the offset of the first character in STRING that is a member of the
     set STOPSET.)

 -- Function: char * strpbrk (const char *STRING, const char *STOPSET)
     Preliminary: | MT-Safe | AS-Safe | AC-Safe | *Note POSIX Safety
     Concepts::.

     The 'strpbrk' ("string pointer break") function is related to
     'strcspn', except that it returns a pointer to the first character
     in STRING that is a member of the set STOPSET instead of the length
     of the initial substring.  It returns a null pointer if no such
     character from STOPSET is found.

     For example,

          strpbrk ("hello, world", " \t\n,.;!?")
              => ", world"

     Note that "character" is here used in the sense of byte.  In a
     string using a multibyte character encoding (abstract) character
     consisting of more than one byte are not treated as an entity.
     Each byte is treated separately.  The function is not
     locale-dependent.

 -- Function: wchar_t * wcspbrk (const wchar_t *WSTRING, const wchar_t
          *STOPSET)
     Preliminary: | MT-Safe | AS-Safe | AC-Safe | *Note POSIX Safety
     Concepts::.

     The 'wcspbrk' ("wide character string pointer break") function is
     related to 'wcscspn', except that it returns a pointer to the first
     wide character in WSTRING that is a member of the set STOPSET
     instead of the length of the initial substring.  It returns a null
     pointer if no such character from STOPSET is found.

5.7.1 Compatibility String Search Functions
-------------------------------------------

 -- Function: char * index (const char *STRING, int C)
     Preliminary: | MT-Safe | AS-Safe | AC-Safe | *Note POSIX Safety
     Concepts::.

     'index' is another name for 'strchr'; they are exactly the same.
     New code should always use 'strchr' since this name is defined in ISO C
     while 'index' is a BSD invention which never was available on System V
     derived systems.

 -- Function: char * rindex (const char *STRING, int C)
     Preliminary: | MT-Safe | AS-Safe | AC-Safe | *Note POSIX Safety
     Concepts::.

     'rindex' is another name for 'strrchr'; they are exactly the same.
     New code should always use 'strrchr' since this name is defined in ISO C
     while 'rindex' is a BSD invention which never was available on System V
     derived systems.

