File: *manpages*,  Node: passwd,  Up: (dir)

PASSWD(1)                       User utilities                       PASSWD(1)



NAME
       passwd - update user's authentication tokens


SYNOPSIS
       passwd  [-k]  [-l]  [-u  [-f]]  [-d] [-e] [-n mindays] [-x maxdays] [-w
       warndays] [-i inactivedays] [-S] [--stdin] [username]



DESCRIPTION
       The passwd utility is used to update user's authentication token(s).

       This task is achieved through calls to the Linux-PAM and  Libuser  API.
       Essentially, it initializes itself as a "passwd" service with Linux-PAM
       and utilizes configured  password  modules  to  authenticate  and  then
       update a user's password.


       A simple entry in the global Linux-PAM configuration file for this ser‐
       vice would be:

        #
        # passwd service entry that does strength checking of
        # a proposed password before updating it.
        #
        passwd password requisite pam_cracklib.so retry=3
        passwd password required pam_unix.so use_authtok
        #


       Note, other module types are not required for this application to func‐
       tion correctly.


OPTIONS
       -k, --keep
              The option -k is used to indicate that the update should only be
              for expired authentication tokens (passwords); the  user  wishes
              to keep their non-expired tokens as before.


       -l, --lock
              This  option  is  used to lock the password of specified account
              and it is available to root only. The locking  is  performed  by
              rendering the encrypted password into an invalid string (by pre‐
              fixing the encrypted string with an !). Note that the account is
              not  fully  locked - the user can still log in by other means of
              authentication such as the ssh public  key  authentication.  Use
              chage -E 0 user command instead for full account locking.


       --stdin
              This  option is used to indicate that passwd should read the new
              password from standard input, which can be a pipe.


       -u, --unlock
              This is the reverse of the  -l  option  -  it  will  unlock  the
              account password by removing the ! prefix. This option is avail‐
              able to root only. By default passwd will  refuse  to  create  a
              passwordless  account  (it  will  not unlock an account that has
              only "!" as a password). The force option -f will override  this
              protection.


       -d, --delete
              This is a quick way to delete a password for an account. It will
              set the named account passwordless. Available to root only.


       -e, --expire
              This is a quick way to expire a password  for  an  account.  The
              user will be forced to change the password during the next login
              attempt.  Available to root only.


       -f, --force
              Force the specified operation.


       -n, --minimum DAYS
              This will set the minimum password lifetime,  in  days,  if  the
              user's  account  supports password lifetimes.  Available to root
              only.


       -x, --maximum DAYS
              This will set the maximum password lifetime,  in  days,  if  the
              user's  account  supports password lifetimes.  Available to root
              only.


       -w, --warning DAYS
              This will set the number of days in advance the user will  begin
              receiving  warnings that her password will expire, if the user's
              account supports password lifetimes.  Available to root only.


       -i, --inactive DAYS
              This will set the number of  days  which  will  pass  before  an
              expired password for this account will be taken to mean that the
              account is inactive  and  should  be  disabled,  if  the  user's
              account supports password lifetimes.  Available to root only.


       -S, --status
              This  will  output  a  short information about the status of the
              password for a given account. The status information consists of
              7  fields.  The first field is the user's login name. The second
              field indicates if the user account has a locked password  (LK),
              has  no  password (NP), or has a usable password (PS). The third
              field gives the date of the last password change. The next  four
              fields  are  the  minimum  age, maximum age, warning period, and
              inactivity period for the password. These ages are expressed  in
              days.

              Notes:  The date of the last password change is stored as a num‐
              ber of days since epoch. Depending on the current time zone, the
              passwd -S username may show the date of the last password change
              that is different from the real date of the last password change
              by ±1 day.

              This option is available to root only.


Remember the following two principles
       Protect your password.
              Don't  write  down  your password - memorize it.  In particular,
              don't write it down and leave it anywhere, and don't place it in
              an  unencrypted  file!  Use unrelated passwords for systems con‐
              trolled by different organizations.  Don't give  or  share  your
              password,  in particular to someone claiming to be from computer
              support or a vendor.  Don't let  anyone  watch  you  enter  your
              password.   Don't  enter  your  password to a computer you don't
              trust or if things "look funny"; someone may be trying to hijack
              your  password.   Use the password for a limited time and change
              it periodically.


       Choose a hard-to-guess password.
              passwd through the calls to the pam_cracklib PAM module will try
              to prevent you from choosing a really bad password, but it isn't
              foolproof; create your password  wisely.   Don't  use  something
              you'd  find  in a dictionary (in any language or jargon).  Don't
              use a name (including that of a spouse, parent, child, pet, fan‐
              tasy character, famous person, and location) or any variation of
              your personal or account name.  Don't use accessible information
              about  you  (such as your phone number, license plate, or social
              security number) or your environment.  Don't use a birthday or a
              simple  pattern  (such as "qwerty", "abc", or "aaa").  Don't use
              any of those backwards, followed by a digit, or  preceded  by  a
              digit.  Instead,  use a mixture of upper and lower case letters,
              as well as digits or punctuation.  When choosing a new password,
              make  sure  it's  unrelated  to  any previous password. Use long
              passwords (say at least 8 characters long).   You  might  use  a
              word  pair  with  punctuation  inserted, a passphrase (an under‐
              standable sequence of words), or the first letter of  each  word
              in a passphrase.



       These  principles are partially enforced by the system, but only partly
       so.  Vigilance on your part will make the system much more secure.


EXIT CODE
       The passwd command exits with the following codes:

       0
           success

       1
           passwd/libuser operation failed

       2
           unknown user

       252
           unknown user name

       253
           bad arguments or passwordless account

       254
           invalid application of arguments

       255
           libuser operation failed

       Error messages are written to the standard error stream.


CONFORMING TO
       Linux-PAM (Pluggable Authentication modules for Linux).


FILES
       /etc/pam.d/passwd - the Linux-PAM configuration file


BUGS
       None known.


SEE ALSO
       pam(8), pam.d(5), libuser.conf(5), and pam_chauthtok(3).


       For more complete information on how to configure this application with
       Linux-PAM, see the Linux-PAM System Administrators' Guide.


AUTHOR
       Cristian Gafton <gafton@redhat.com>



GNU/Linux                         Jun 20 2012                        PASSWD(1)
PASSWD(1)                           OpenSSL                          PASSWD(1)



NAME
       passwd - compute password hashes

SYNOPSIS
       openssl passwd [-crypt] [-1] [-apr1] [-salt string] [-in file] [-stdin]
       [-noverify] [-quiet] [-table] {password}

DESCRIPTION
       The passwd command computes the hash of a password typed at run-time or
       the hash of each password in a list.  The password list is taken from
       the named file for option -in file, from stdin for option -stdin, or
       from the command line, or from the terminal otherwise.  The Unix
       standard algorithm crypt and the MD5-based BSD password algorithm 1 and
       its Apache variant apr1 are available.

OPTIONS
       -crypt
           Use the crypt algorithm (default).

       -1  Use the MD5 based BSD password algorithm 1.

       -apr1
           Use the apr1 algorithm (Apache variant of the BSD algorithm).

       -salt string
           Use the specified salt.  When reading a password from the terminal,
           this implies -noverify.

       -in file
           Read passwords from file.

       -stdin
           Read passwords from stdin.

       -noverify
           Don't verify when reading a password from the terminal.

       -quiet
           Don't output warnings when passwords given at the command line are
           truncated.

       -table
           In the output list, prepend the cleartext password and a TAB
           character to each password hash.

EXAMPLES
       openssl passwd -crypt -salt xx password prints xxj31ZMTZzkVA.

       openssl passwd -1 -salt xxxxxxxx password prints
       $1$xxxxxxxx$UYCIxa628.9qXjpQCjM4a..

       openssl passwd -apr1 -salt xxxxxxxx password prints
       $apr1$xxxxxxxx$dxHfLAsjHkDRmG83UXe8K0.



1.0.2k                            2017-01-26                         PASSWD(1)
PASSWD(5)                  Linux Programmer's Manual                 PASSWD(5)



NAME
       passwd - password file

DESCRIPTION
       The  /etc/passwd file is a text file that describes user login accounts
       for the system.  It should have read permission allowed for  all  users
       (many  utilities,  like ls(1) use it to map user IDs to usernames), but
       write access only for the superuser.

       In the good old days there was no great problem with this general  read
       permission.   Everybody  could  read  the  encrypted passwords, but the
       hardware was too slow to crack a well-chosen password, and moreover the
       basic  assumption  used to be that of a friendly user-community.  These
       days many people run some version of the shadow password  suite,  where
       /etc/passwd  has  an  'x'  character  in  the  password  field, and the
       encrypted passwords are in /etc/shadow, which is readable by the  supe‐
       ruser only.

       If the encrypted password, whether in /etc/passwd or in /etc/shadow, is
       an empty string, login is allowed without even asking for  a  password.
       Note  that this functionality may be intentionally disabled in applica‐
       tions, or configurable (for example  using  the  "nullok"  or  "nonull"
       arguments to pam_unix.so).

       If  the  encrypted  password  in  /etc/passwd  is  "*NP*"  (without the
       quotes), the shadow record should be obtained from an NIS+ server.

       Regardless of whether shadow passwords are used, many  system  adminis‐
       trators  use  an  asterisk  (*) in the encrypted password field to make
       sure that this user can not authenticate him- or herself using a  pass‐
       word.  (But see NOTES below.)

       If  you  create  a new login, first put an asterisk (*) in the password
       field, then use passwd(1) to set it.

       Each line of the file describes  a  single  user,  and  contains  seven
       colon-separated fields:

              name:password:UID:GID:GECOS:directory:shell

       The field are as follows:

       name        This is the user's login name.  It should not contain capi‐
                   tal letters.

       password    This is either the encrypted  user  password,  an  asterisk
                   (*),  or the letter 'x'.  (See pwconv(8) for an explanation
                   of 'x'.)

       UID         The privileged root login account (superuser) has the  user
                   ID 0.

       GID         This is the numeric primary group ID for this user.  (Addi‐
                   tional groups for the user are defined in the system  group
                   file; see group(5)).

       GECOS       This  field  (sometimes  called  the  "comment  field")  is
                   optional and used only for  informational  purposes.   Usu‐
                   ally,  it  contains  the full username.  Some programs (for
                   example, finger(1)) display information from this field.

                   GECOS stands for "General Electric Comprehensive  Operating
                   System",  which was renamed to GCOS when GE's large systems
                   division  was  sold  to  Honeywell.   Dennis  Ritchie   has
                   reported:  "Sometimes  we sent printer output or batch jobs
                   to the GCOS machine.  The gcos field in the  password  file
                   was  a  place  to stash the information for the $IDENTcard.
                   Not elegant."

       directory   This is the user's home directory:  the  initial  directory
                   where  the  user  is placed after logging in.  The value in
                   this field is used to set the HOME environment variable.

       shell       This is  the  program  to  run  at  login  (if  empty,  use
                   /bin/sh).   If  set  to  a nonexistent executable, the user
                   will be unable to login through  login(1).   The  value  in
                   this field is used to set the SHELL environment variable.

FILES
       /etc/passwd

NOTES
       If  you  want  to  create  user  groups,  there  must  be  an  entry in
       /etc/group, or no group will exist.

       If the encrypted password is set to an asterisk (*), the user  will  be
       unable  to  login  using login(1), but may still login using rlogin(1),
       run existing processes and initiate new ones through  rsh(1),  cron(8),
       at(1),  or  mail  filters,  etc.   Trying  to lock an account by simply
       changing the shell field yields the same result and additionally allows
       the use of su(1).

SEE ALSO
       login(1),   passwd(1),   su(1),   getpwent(3),  getpwnam(3),  crypt(3),
       group(5), shadow(5)

COLOPHON
       This page is part of release 3.53 of the Linux  man-pages  project.   A
       description  of  the project, and information about reporting bugs, can
       be found at http://www.kernel.org/doc/man-pages/.



Linux                             2012-05-03                         PASSWD(5)
