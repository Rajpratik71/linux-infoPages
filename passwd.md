File: *manpages*,  Node: passwd,  Up: (dir)

PASSWD(1)                        User Commands                       PASSWD(1)



NAME
       passwd - change user password

SYNOPSIS
       passwd [options] [LOGIN]

DESCRIPTION
       The passwd command changes passwords for user accounts. A normal user
       may only change the password for his/her own account, while the
       superuser may change the password for any account.  passwd also changes
       the account or associated password validity period.

   Password Changes
       The user is first prompted for his/her old password, if one is present.
       This password is then encrypted and compared against the stored
       password. The user has only one chance to enter the correct password.
       The superuser is permitted to bypass this step so that forgotten
       passwords may be changed.

       After the password has been entered, password aging information is
       checked to see if the user is permitted to change the password at this
       time. If not, passwd refuses to change the password and exits.

       The user is then prompted twice for a replacement password. The second
       entry is compared against the first and both are required to match in
       order for the password to be changed.

       Then, the password is tested for complexity. As a general guideline,
       passwords should consist of 6 to 8 characters including one or more
       characters from each of the following sets:

       ·   lower case alphabetics

       ·   digits 0 thru 9

       ·   punctuation marks

       Care must be taken not to include the system default erase or kill
       characters.  passwd will reject any password which is not suitably
       complex.

   Hints for user passwords
       The security of a password depends upon the strength of the encryption
       algorithm and the size of the key space. The legacy UNIX System
       encryption method is based on the NBS DES algorithm. More recent
       methods are now recommended (see ENCRYPT_METHOD). The size of the key
       space depends upon the randomness of the password which is selected.

       Compromises in password security normally result from careless password
       selection or handling. For this reason, you should not select a
       password which appears in a dictionary or which must be written down.
       The password should also not be a proper name, your license number,
       birth date, or street address. Any of these may be used as guesses to
       violate system security.

       You can find advices on how to choose a strong password on
       http://en.wikipedia.org/wiki/Password_strength

OPTIONS
       The options which apply to the passwd command are:

       -a, --all
           This option can be used only with -S and causes show status for all
           users.

       -d, --delete
           Delete a user's password (make it empty). This is a quick way to
           disable a password for an account. It will set the named account
           passwordless.

       -e, --expire
           Immediately expire an account's password. This in effect can force
           a user to change his/her password at the user's next login.

       -h, --help
           Display help message and exit.

       -i, --inactive INACTIVE
           This option is used to disable an account after the password has
           been expired for a number of days. After a user account has had an
           expired password for INACTIVE days, the user may no longer sign on
           to the account.

       -k, --keep-tokens
           Indicate password change should be performed only for expired
           authentication tokens (passwords). The user wishes to keep their
           non-expired tokens as before.

       -l, --lock
           Lock the password of the named account. This option disables a
           password by changing it to a value which matches no possible
           encrypted value (it adds a ´!´ at the beginning of the password).

           Note that this does not disable the account. The user may still be
           able to login using another authentication token (e.g. an SSH key).
           To disable the account, administrators should use usermod
           --expiredate 1 (this set the account's expire date to Jan 2, 1970).

           Users with a locked password are not allowed to change their
           password.

       -n, --mindays MIN_DAYS
           Set the minimum number of days between password changes to
           MIN_DAYS. A value of zero for this field indicates that the user
           may change his/her password at any time.

       -q, --quiet
           Quiet mode.

       -r, --repository REPOSITORY
           change password in REPOSITORY repository

       -R, --root CHROOT_DIR
           Apply changes in the CHROOT_DIR directory and use the configuration
           files from the CHROOT_DIR directory.

       -S, --status
           Display account status information. The status information consists
           of 7 fields. The first field is the user's login name. The second
           field indicates if the user account has a locked password (L), has
           no password (NP), or has a usable password (P). The third field
           gives the date of the last password change. The next four fields
           are the minimum age, maximum age, warning period, and inactivity
           period for the password. These ages are expressed in days.

       -u, --unlock
           Unlock the password of the named account. This option re-enables a
           password by changing the password back to its previous value (to
           the value before using the -l option).

       -w, --warndays WARN_DAYS
           Set the number of days of warning before a password change is
           required. The WARN_DAYS option is the number of days prior to the
           password expiring that a user will be warned that his/her password
           is about to expire.

       -x, --maxdays MAX_DAYS
           Set the maximum number of days a password remains valid. After
           MAX_DAYS, the password is required to be changed.

CAVEATS
       Password complexity checking may vary from site to site. The user is
       urged to select a password as complex as he or she feels comfortable
       with.

       Users may not be able to change their password on a system if NIS is
       enabled and they are not logged into the NIS server.

CONFIGURATION
       The following configuration variables in /etc/login.defs change the
       behavior of this tool:

       ENCRYPT_METHOD (string)
           This defines the system default encryption algorithm for encrypting
           passwords (if no algorithm are specified on the command line).

           It can take one of these values: DES (default), MD5, SHA256,
           SHA512.

           Note: this parameter overrides the MD5_CRYPT_ENAB variable.

       MD5_CRYPT_ENAB (boolean)
           Indicate if passwords must be encrypted using the MD5-based
           algorithm. If set to yes, new passwords will be encrypted using the
           MD5-based algorithm compatible with the one used by recent releases
           of FreeBSD. It supports passwords of unlimited length and longer
           salt strings. Set to no if you need to copy encrypted passwords to
           other systems which don't understand the new algorithm. Default is
           no.

           This variable is superseded by the ENCRYPT_METHOD variable or by
           any command line option used to configure the encryption algorithm.

           This variable is deprecated. You should use ENCRYPT_METHOD.

       OBSCURE_CHECKS_ENAB (boolean)
           Enable additional checks upon password changes.

       PASS_ALWAYS_WARN (boolean)
           Warn about weak passwords (but still allow them) if you are root.

       PASS_CHANGE_TRIES (number)
           Maximum number of attempts to change password if rejected (too
           easy).

       PASS_MAX_LEN (number), PASS_MIN_LEN (number)
           Number of significant characters in the password for crypt().
           PASS_MAX_LEN is 8 by default. Don't change unless your crypt() is
           better. This is ignored if MD5_CRYPT_ENAB set to yes.

       SHA_CRYPT_MIN_ROUNDS (number), SHA_CRYPT_MAX_ROUNDS (number)
           When ENCRYPT_METHOD is set to SHA256 or SHA512, this defines the
           number of SHA rounds used by the encryption algorithm by default
           (when the number of rounds is not specified on the command line).

           With a lot of rounds, it is more difficult to brute forcing the
           password. But note also that more CPU resources will be needed to
           authenticate users.

           If not specified, the libc will choose the default number of rounds
           (5000).

           The values must be inside the 1000-999,999,999 range.

           If only one of the SHA_CRYPT_MIN_ROUNDS or SHA_CRYPT_MAX_ROUNDS
           values is set, then this value will be used.

           If SHA_CRYPT_MIN_ROUNDS > SHA_CRYPT_MAX_ROUNDS, the highest value
           will be used.

FILES
       /etc/passwd
           User account information.

       /etc/shadow
           Secure user account information.

       /etc/login.defs
           Shadow password suite configuration.

EXIT VALUES
       The passwd command exits with the following values:

       0
           success

       1
           permission denied

       2
           invalid combination of options

       3
           unexpected failure, nothing done

       4
           unexpected failure, passwd file missing

       5
           passwd file busy, try again

       6
           invalid argument to option

SEE ALSO
       chpasswd(8), passwd(5), shadow(5), login.defs(5),usermod(8).



shadow-utils 4.2.1                05/09/2014                         PASSWD(1)
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
       encrypted passwords are in /etc/shadow, which is readable by the  supe-
       ruser only.

       If the encrypted password, whether in /etc/passwd or in /etc/shadow, is
       an empty string, login is allowed without even asking for  a  password.
       Note  that this functionality may be intentionally disabled in applica-
       tions, or configurable (for example  using  the  "nullok"  or  "nonull"
       arguments to pam_unix.so).

       If  the  encrypted  password  in  /etc/passwd  is  "*NP*"  (without the
       quotes), the shadow record should be obtained from an NIS+ server.

       Regardless of whether shadow passwords are used, many  system  adminis-
       trators  use  an  asterisk  (*) in the encrypted password field to make
       sure that this user can not authenticate him- or herself using a  pass-
       word.  (But see NOTES below.)

       If  you  create  a new login, first put an asterisk (*) in the password
       field, then use passwd(1) to set it.

       Each line of the file describes  a  single  user,  and  contains  seven
       colon-separated fields:

              name:password:UID:GID:GECOS:directory:shell

       The field are as follows:

       name        This is the user's login name.  It should not contain capi-
                   tal letters.

       password    This is either the encrypted  user  password,  an  asterisk
                   (*),  or the letter 'x'.  (See pwconv(8) for an explanation
                   of 'x'.)

       UID         The privileged root login account (superuser) has the  user
                   ID 0.

       GID         This is the numeric primary group ID for this user.  (Addi-
                   tional groups for the user are defined in the system  group
                   file; see group(5)).

       GECOS       This  field  (sometimes  called  the  "comment  field")  is
                   optional and used only for  informational  purposes.   Usu-
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
       chfn(1),  chsh(1),  login(1),  passwd(1), su(1), crypt(3), getpwent(3),
       getpwnam(3), group(5), shadow(5)

COLOPHON
       This page is part of release 4.02 of the Linux  man-pages  project.   A
       description  of  the project, information about reporting bugs, and the
       latest    version    of    this    page,    can     be     found     at
       http://www.kernel.org/doc/man-pages/.



Linux                             2015-02-01                         PASSWD(5)
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



1.0.2j                            2016-09-26                         PASSWD(1)
