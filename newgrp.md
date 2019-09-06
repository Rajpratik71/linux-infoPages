File: *manpages*,  Node: newgrp,  Up: (dir)

NEWGRP(1)                        User Commands                       NEWGRP(1)



NAME
       newgrp - log in to a new group

SYNOPSIS
       newgrp [-] [group]

DESCRIPTION
       The newgrp command is used to change the current group ID during a
       login session. If the optional - flag is given, the user's environment
       will be reinitialized as though the user had logged in, otherwise the
       current environment, including current working directory, remains
       unchanged.

       newgrp changes the current real group ID to the named group, or to the
       default group listed in /etc/passwd if no group name is given.  newgrp
       also tries to add the group to the user groupset. If not root, the user
       will be prompted for a password if she does not have a password (in
       /etc/shadow if this user has an entry in the shadowed password file, or
       in /etc/passwd otherwise) and the group does, or if the user is not
       listed as a member and the group has a password. The user will be
       denied access if the group password is empty and the user is not listed
       as a member.

       If there is an entry for this group in /etc/gshadow, then the list of
       members and the password of this group will be taken from this file,
       otherwise, the entry in /etc/group is considered.

CONFIGURATION
       The following configuration variables in /etc/login.defs change the
       behavior of this tool:

       SYSLOG_SG_ENAB (boolean)
           Enable "syslog" logging of sg activity.

FILES
       /etc/passwd
           User account information.

       /etc/shadow
           Secure user account information.

       /etc/group
           Group account information.

       /etc/gshadow
           Secure group account information.

SEE ALSO
       id(1), login(1), su(1), sg(1), gpasswd(1), group(5), gshadow(5).



shadow-utils 4.2.1                05/09/2014                         NEWGRP(1)
NEWGRP(1P)                 POSIX Programmer's Manual                NEWGRP(1P)



PROLOG
       This  manual  page is part of the POSIX Programmer's Manual.  The Linux
       implementation of this interface may differ (consult the  corresponding
       Linux  manual page for details of Linux behavior), or the interface may
       not be implemented on Linux.

NAME
       newgrp - change to a new group

SYNOPSIS
       newgrp [-l][group]

DESCRIPTION
       The newgrp utility shall create a new shell execution environment  with
       a new real and effective group identification. Of the attributes listed
       in Shell Execution Environment, the  new  shell  execution  environment
       shall  retain  the  working directory, file creation mask, and exported
       variables from the previous environment (that is,  open  files,  traps,
       unexported  variables,  alias  definitions,  shell  functions,  and set
       options may be lost). All other aspects of the process environment that
       are  preserved  by  the  exec family of functions defined in the System
       Interfaces volume of IEEE Std 1003.1-2001 shall also  be  preserved  by
       newgrp; whether other aspects are preserved is unspecified.

       A  failure  to  assign  the new group identifications (for example, for
       security or password-related reasons) shall not prevent the  new  shell
       execution environment from being created.

       The newgrp utility shall affect the supplemental groups for the process
       as follows:

        * On systems where the effective group ID is normally in  the  supple-
          mentary  group list (or whenever the old effective group ID actually
          is in the supplementary group list):

           * If the new effective group ID is also in the supplementary  group
             list, newgrp shall change the effective group ID.

           * If  the  new effective group ID is not in the supplementary group
             list, newgrp shall add the new effective group ID to the list, if
             there is room to add it.

        * On  systems where the effective group ID is not normally in the sup-
          plementary group list (or whenever the old effective group ID is not
          in the supplementary group list):

           * If the new effective group ID is in the supplementary group list,
             newgrp shall delete it.

           * If the old effective group ID is not in the  supplementary  list,
             newgrp shall add it if there is room.

       Note:  The  System  Interfaces  volume of IEEE Std 1003.1-2001 does not
              specify whether the effective group ID of a process is  included
              in its supplementary group list.


       With  no  operands, newgrp shall change the effective group back to the
       groups identified in the user's user entry, and shall set the  list  of
       supplementary groups to that set in the user's group database entries.

       If  a password is required for the specified group, and the user is not
       listed as a member of that group in the group database, the user  shall
       be  prompted  to enter the correct password for that group. If the user
       is listed as a member of that group, no password shall be requested. If
       no  password is required for the specified group, it is implementation-
       defined whether users not listed as members of that group can change to
       that  group.  Whether  or  not  a password is required, implementation-
       defined system accounting or security mechanisms may impose  additional
       authorization  restrictions that may cause newgrp to write a diagnostic
       message and suppress the changing of the group identification.

OPTIONS
       The newgrp utility shall conform to  the  Base  Definitions  volume  of
       IEEE Std 1003.1-2001, Section 12.2, Utility Syntax Guidelines.

       The following option shall be supported:

       -l     (The  letter  ell.)  Change  the  environment  to  what would be
              expected if the user actually logged in again.


OPERANDS
       The following operand shall be supported:

       group  A group name from the group database or a  non-negative  numeric
              group ID. Specifies the group ID to which the real and effective
              group IDs shall be set.  If  group  is  a  non-negative  numeric
              string  and  exists  in  the group database as a group name (see
              getgrnam()), the numeric group ID  associated  with  that  group
              name shall be used as the group ID.


STDIN
       Not used.

INPUT FILES
       The file /dev/tty shall be used to read a single line of text for pass-
       word checking, when one is required.

ENVIRONMENT VARIABLES
       The following environment variables shall affect the execution of  new-
       grp:

       LANG   Provide  a  default value for the internationalization variables
              that are unset or null. (See  the  Base  Definitions  volume  of
              IEEE Std 1003.1-2001,  Section  8.2,  Internationalization Vari-
              ables for the precedence of internationalization variables  used
              to determine the values of locale categories.)

       LC_ALL If  set  to a non-empty string value, override the values of all
              the other internationalization variables.

       LC_CTYPE
              Determine the locale for  the  interpretation  of  sequences  of
              bytes  of  text  data as characters (for example, single-byte as
              opposed to multi-byte characters in arguments).

       LC_MESSAGES
              Determine the locale that should be used to  affect  the  format
              and contents of diagnostic messages written to standard error.

       NLSPATH
              Determine the location of message catalogs for the processing of
              LC_MESSAGES .


ASYNCHRONOUS EVENTS
       Default.

STDOUT
       Not used.

STDERR
       The standard error shall be used for diagnostic messages and  a  prompt
       string  for  a password, if one is required. Diagnostic messages may be
       written in cases where the exit status is not available.  See the  EXIT
       STATUS section.

OUTPUT FILES
       None.

EXTENDED DESCRIPTION
       None.

EXIT STATUS
       If  newgrp  succeeds  in  creating  a  new shell execution environment,
       whether or not the group identification was changed  successfully,  the
       exit status shall be the exit status of the shell.  Otherwise, the fol-
       lowing exit value shall be returned:

       >0     An error occurred.


CONSEQUENCES OF ERRORS
       The invoking shell may terminate.

       The following sections are informative.

APPLICATION USAGE
       There is no convenient way to enter a password into the group database.
       Use  of group passwords is not encouraged, because by their very nature
       they encourage poor security practices. Group passwords  may  disappear
       in the future.

       A  common  implementation of newgrp is that the current shell uses exec
       to overlay itself with newgrp, which in turn overlays itself with a new
       shell  after changing group. On some implementations, however, this may
       not occur and newgrp may be invoked as a subprocess.

       The newgrp command is intended only for use from an interactive  termi-
       nal.  It  does not offer a useful interface for the support of applica-
       tions.

       The exit status of newgrp is generally inapplicable. If newgrp is  used
       in  a script, in most cases it successfully invokes a new shell and the
       rest of the original shell script is bypassed when the new shell exits.
       Used  interactively,  newgrp  displays  diagnostic messages to indicate
       problems. But usage such as:


              newgrp foo
              echo $?

       is not useful because the new shell might not have access to any status
       newgrp  may  have generated (and most historical systems do not provide
       this status). A zero status echoed here does not  necessarily  indicate
       that the user has changed to the new group successfully. Following new-
       grp with the id  command  provides  a  portable  means  of  determining
       whether the group change was successful or not.

EXAMPLES
       None.

RATIONALE
       Most historical implementations use one of the exec functions to imple-
       ment the behavior of newgrp. Errors detected before the exec leave  the
       environment  unchanged,  while errors detected after the exec leave the
       user in a changed environment. While it would be useful to have  newgrp
       issue  a  diagnostic  message  to  tell  the  user that the environment
       changed, it would be inappropriate to require this change to some  his-
       torical implementations.

       The  password  mechanism is allowed in the group database, but how this
       would be implemented is not specified.

       The newgrp utility was retained in this volume of IEEE Std 1003.1-2001,
       even  given  the existence of the multiple group permissions feature in
       the System Interfaces volume of IEEE Std 1003.1-2001, for several  rea-
       sons.  First,  in  some implementations, the group ownership of a newly
       created file is determined by the group of the directory in  which  the
       file  is  created,  as  allowed  by  the  System  Interfaces  volume of
       IEEE Std 1003.1-2001; on other implementations, the group ownership  of
       a newly created file is determined by the effective group ID. On imple-
       mentations of the latter type, newgrp allows files to be created with a
       specific  group  ownership.  Finally, many implementations use the real
       group ID in accounting, and on such systems, newgrp allows the account-
       ing identity of the user to be changed.

FUTURE DIRECTIONS
       None.

SEE ALSO
       Shell   Command   Language,   sh,   the  System  Interfaces  volume  of
       IEEE Std 1003.1-2001, exec, getgrnam()

COPYRIGHT
       Portions of this text are reprinted and reproduced in  electronic  form
       from IEEE Std 1003.1, 2003 Edition, Standard for Information Technology
       -- Portable Operating System Interface (POSIX),  The  Open  Group  Base
       Specifications  Issue  6,  Copyright  (C) 2001-2003 by the Institute of
       Electrical and Electronics Engineers, Inc and The Open  Group.  In  the
       event of any discrepancy between this version and the original IEEE and
       The Open Group Standard, the original IEEE and The Open Group  Standard
       is  the  referee document. The original Standard can be obtained online
       at http://www.opengroup.org/unix/online.html .



IEEE/The Open Group                  2003                           NEWGRP(1P)
