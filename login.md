File: libc.info,  Node: Logging In and Out,  Prev: XPG Functions,  Up: User Accounting Database

30.12.3 Logging In and Out
--------------------------

These functions, derived from BSD, are available in the separate
'libutil' library, and declared in 'utmp.h'.

   Note that the 'ut_user' member of 'struct utmp' is called 'ut_name'
in BSD. Therefore, 'ut_name' is defined as an alias for 'ut_user' in
'utmp.h'.

 -- Function: int login_tty (int FILEDES)
     Preliminary: | MT-Unsafe race:ttyname | AS-Unsafe heap lock |
     AC-Unsafe lock fd mem | *Note POSIX Safety Concepts::.

     This function makes FILEDES the controlling terminal of the current
     process, redirects standard input, standard output and standard
     error output to this terminal, and closes FILEDES.

     This function returns '0' on successful completion, and '-1' on
     error.

 -- Function: void login (const struct utmp *ENTRY)
     Preliminary: | MT-Unsafe race:utent sig:ALRM timer | AS-Unsafe lock
     heap | AC-Unsafe lock corrupt fd mem | *Note POSIX Safety
     Concepts::.

     The 'login' functions inserts an entry into the user accounting
     database.  The 'ut_line' member is set to the name of the terminal
     on standard input.  If standard input is not a terminal 'login'
     uses standard output or standard error output to determine the name
     of the terminal.  If 'struct utmp' has a 'ut_type' member, 'login'
     sets it to 'USER_PROCESS', and if there is an 'ut_pid' member, it
     will be set to the process ID of the current process.  The
     remaining entries are copied from ENTRY.

     A copy of the entry is written to the user accounting log file.

 -- Function: int logout (const char *UT_LINE)
     Preliminary: | MT-Unsafe race:utent sig:ALRM timer | AS-Unsafe lock
     heap | AC-Unsafe lock fd mem | *Note POSIX Safety Concepts::.

     This function modifies the user accounting database to indicate
     that the user on UT_LINE has logged out.

     The 'logout' function returns '1' if the entry was successfully
     written to the database, or '0' on error.

 -- Function: void logwtmp (const char *UT_LINE, const char *UT_NAME,
          const char *UT_HOST)
     Preliminary: | MT-Unsafe sig:ALRM timer | AS-Unsafe | AC-Unsafe fd
     | *Note POSIX Safety Concepts::.

     The 'logwtmp' function appends an entry to the user accounting log
     file, for the current time and the information provided in the
     UT_LINE, UT_NAME and UT_HOST arguments.

   *Portability Note:* The BSD 'struct utmp' only has the 'ut_line',
'ut_name', 'ut_host' and 'ut_time' members.  Older systems do not even
have the 'ut_host' member.

