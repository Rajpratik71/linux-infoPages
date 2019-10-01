File: libc.info,  Node: Translation with gettext,  Next: Locating gettext catalog,  Up: Message catalogs with gettext

8.2.1.1 What has to be done to translate a message?
...................................................

The 'gettext' functions have a very simple interface.  The most basic
function just takes the string which shall be translated as the argument
and it returns the translation.  This is fundamentally different from
the 'catgets' approach where an extra key is necessary and the original
string is only used for the error case.

   If the string which has to be translated is the only argument this of
course means the string itself is the key.  I.e., the translation will
be selected based on the original string.  The message catalogs must
therefore contain the original strings plus one translation for any such
string.  The task of the 'gettext' function is it to compare the
argument string with the available strings in the catalog and return the
appropriate translation.  Of course this process is optimized so that
this process is not more expensive than an access using an atomic key
like in 'catgets'.

   The 'gettext' approach has some advantages but also some
disadvantages.  Please see the GNU 'gettext' manual for a detailed
discussion of the pros and cons.

   All the definitions and declarations for 'gettext' can be found in
the 'libintl.h' header file.  On systems where these functions are not
part of the C library they can be found in a separate library named
'libintl.a' (or accordingly different for shared libraries).

 -- Function: char * gettext (const char *MSGID)
     Preliminary: | MT-Safe env | AS-Unsafe corrupt heap lock dlopen |
     AC-Unsafe corrupt lock fd mem | *Note POSIX Safety Concepts::.

     The 'gettext' function searches the currently selected message
     catalogs for a string which is equal to MSGID.  If there is such a
     string available it is returned.  Otherwise the argument string
     MSGID is returned.

     Please note that although the return value is 'char *' the returned
     string must not be changed.  This broken type results from the
     history of the function and does not reflect the way the function
     should be used.

     Please note that above we wrote "message catalogs" (plural).  This
     is a specialty of the GNU implementation of these functions and we
     will say more about this when we talk about the ways message
     catalogs are selected (*note Locating gettext catalog::).

     The 'gettext' function does not modify the value of the global
     ERRNO variable.  This is necessary to make it possible to write
     something like

            printf (gettext ("Operation failed: %m\n"));

     Here the ERRNO value is used in the 'printf' function while
     processing the '%m' format element and if the 'gettext' function
     would change this value (it is called before 'printf' is called) we
     would get a wrong message.

     So there is no easy way to detect a missing message catalog beside
     comparing the argument string with the result.  But it is normally
     the task of the user to react on missing catalogs.  The program
     cannot guess when a message catalog is really necessary since for a
     user who speaks the language the program was developed in does not
     need any translation.

   The remaining two functions to access the message catalog add some
functionality to select a message catalog which is not the default one.
This is important if parts of the program are developed independently.
Every part can have its own message catalog and all of them can be used
at the same time.  The C library itself is an example: internally it
uses the 'gettext' functions but since it must not depend on a currently
selected default message catalog it must specify all ambiguous
information.

 -- Function: char * dgettext (const char *DOMAINNAME, const char
          *MSGID)
     Preliminary: | MT-Safe env | AS-Unsafe corrupt heap lock dlopen |
     AC-Unsafe corrupt lock fd mem | *Note POSIX Safety Concepts::.

     The 'dgettext' functions acts just like the 'gettext' function.  It
     only takes an additional first argument DOMAINNAME which guides the
     selection of the message catalogs which are searched for the
     translation.  If the DOMAINNAME parameter is the null pointer the
     'dgettext' function is exactly equivalent to 'gettext' since the
     default value for the domain name is used.

     As for 'gettext' the return value type is 'char *' which is an
     anachronism.  The returned string must never be modified.

 -- Function: char * dcgettext (const char *DOMAINNAME, const char
          *MSGID, int CATEGORY)
     Preliminary: | MT-Safe env | AS-Unsafe corrupt heap lock dlopen |
     AC-Unsafe corrupt lock fd mem | *Note POSIX Safety Concepts::.

     The 'dcgettext' adds another argument to those which 'dgettext'
     takes.  This argument CATEGORY specifies the last piece of
     information needed to localize the message catalog.  I.e., the
     domain name and the locale category exactly specify which message
     catalog has to be used (relative to a given directory, see below).

     The 'dgettext' function can be expressed in terms of 'dcgettext' by
     using

          dcgettext (domain, string, LC_MESSAGES)

     instead of

          dgettext (domain, string)

     This also shows which values are expected for the third parameter.
     One has to use the available selectors for the categories available
     in 'locale.h'.  Normally the available values are 'LC_CTYPE',
     'LC_COLLATE', 'LC_MESSAGES', 'LC_MONETARY', 'LC_NUMERIC', and
     'LC_TIME'.  Please note that 'LC_ALL' must not be used and even
     though the names might suggest this, there is no relation to the
     environments variables of this name.

     The 'dcgettext' function is only implemented for compatibility with
     other systems which have 'gettext' functions.  There is not really
     any situation where it is necessary (or useful) to use a different
     value but 'LC_MESSAGES' in for the CATEGORY parameter.  We are
     dealing with messages here and any other choice can only be
     irritating.

     As for 'gettext' the return value type is 'char *' which is an
     anachronism.  The returned string must never be modified.

   When using the three functions above in a program it is a frequent
case that the MSGID argument is a constant string.  So it is worth to
optimize this case.  Thinking shortly about this one will realize that
as long as no new message catalog is loaded the translation of a message
will not change.  This optimization is actually implemented by the
'gettext', 'dgettext' and 'dcgettext' functions.

