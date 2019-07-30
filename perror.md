PERROR(1)                                                      MySQL Database System                                                     PERROR(1)

NAME
       perror - display MySQL error message information

SYNOPSIS
       perror [options] errorcode ...

DESCRIPTION
       For most system errors, MySQL displays, in addition to an internal text message, the system error code in one of the following styles:

           message ... (errno: #)
           message ... (Errcode: #)

       You can find out what the error code means by examining the documentation for your system or by using the perror utility.

       perror prints a description for a system error code or for a storage engine (table handler) error code.

       Invoke perror like this:

           shell> perror [options] errorcode ...

       Examples:

           shell> perror 1231
           MySQL error code 1231 (ER_WRONG_VALUE_FOR_VAR): Variable '%-.64s' can't
           be set to the value of '%-.200s'

           shell> perror 13 64
           OS error code  13:  Permission denied
           OS error code  64:  Machine is not on the network

       To obtain the error message for a MySQL Cluster error code, use the ndb_perror utility.

       The meaning of system error messages may be dependent on your operating system. A given error code may mean different things on different
       operating systems.

       perror supports the following options.

       ·   --help, --info, -I, -?

           Display a help message and exit.

       ·   --ndb

           Print the error message for an NDB Cluster error code.

           This option is deprecated in NDB 7.6.4 and later, where perror prints a warning if it is used, and is removed in NDB Cluster 8.0. Use
           the ndb_perror utility instead.

       ·   --silent, -s

           Silent mode. Print only the error message.

       ·   --verbose, -v

           Verbose mode. Print error code and message. This is the default behavior.

       ·   --version, -V

           Display version information and exit.

COPYRIGHT
       Copyright © 1997, 2019, Oracle and/or its affiliates. All rights reserved.

       This documentation is free software; you can redistribute it and/or modify it only under the terms of the GNU General Public License as
       published by the Free Software Foundation; version 2 of the License.

       This documentation is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of
       MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

       You should have received a copy of the GNU General Public License along with the program; if not, write to the Free Software Foundation,
       Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA or see http://www.gnu.org/licenses/.

SEE ALSO
       For more information, please refer to the MySQL Reference Manual, which may already be installed locally and which is also available online
       at http://dev.mysql.com/doc/.

AUTHOR
       Oracle Corporation (http://dev.mysql.com/).

MySQL 5.7                                                           06/08/2019                                                           PERROR(1)
PERROR(3)                                                    Linux Programmer's Manual                                                   PERROR(3)

NAME
       perror - print a system error message

SYNOPSIS
       #include <stdio.h>

       void perror(const char *s);

       #include <errno.h>

       const char * const sys_errlist[];
       int sys_nerr;
       int errno;       /* Not really declared this way; see errno(3) */

   Feature Test Macro Requirements for glibc (see feature_test_macros(7)):

       sys_errlist, sys_nerr: _BSD_SOURCE

DESCRIPTION
       The perror() function produces a message on standard error describing the last error encountered during a call to a system or library func‐
       tion.

       First (if s is not NULL and *s is not a null byte ('\0')), the argument string s is printed, followed by a colon  and  a  blank.   Then  an
       error message corresponding to the current value of errno and a new-line.

       To be of most use, the argument string should include the name of the function that incurred the error.

       The  global  error  list  sys_errlist[],  which  can be indexed by errno, can be used to obtain the error message without the newline.  The
       largest message number provided in the table is sys_nerr-1.  Be careful when directly accessing this list, because new error values may not
       have been added to sys_errlist[].  The use of sys_errlist[] is nowadays deprecated.

       When  a  system  call fails, it usually returns -1 and sets the variable errno to a value describing what went wrong.  (These values can be
       found in <errno.h>.)  Many library functions do likewise.  The function perror() serves to translate this error  code  into  human-readable
       form.   Note  that errno is undefined after a successful sysme call or library function call: this call may well change this variable, even
       though it succeeds, for example because it internally used some other library function that failed.  Thus, if a failing call is not immedi‐
       ately followed by a call to perror(), the value of errno should be saved.

ATTRIBUTES
       For an explanation of the terms used in this section, see attributes(7).

       ┌──────────┬───────────────┬─────────────────────┐
       │Interface │ Attribute     │ Value               │
       ├──────────┼───────────────┼─────────────────────┤
       │perror()  │ Thread safety │ MT-Safe race:stderr │
       └──────────┴───────────────┴─────────────────────┘

CONFORMING TO
       perror(), errno: POSIX.1-2001, POSIX.1-2008, C89, C99, 4.3BSD.

       The externals sys_nerr and sys_errlist derive from BSD, but are not specified in POSIX.1.

NOTES
       The externals sys_nerr and sys_errlist are defined by glibc, but in <stdio.h>.

SEE ALSO
       err(3), errno(3), error(3), strerror(3)

COLOPHON
       This  page is part of release 4.04 of the Linux man-pages project.  A description of the project, information about reporting bugs, and the
       latest version of this page, can be found at http://www.kernel.org/doc/man-pages/.

                                                                    2015-07-23                                                           PERROR(3)
