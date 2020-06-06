File: *manpages*,  Node: kpasswd,  Up: (dir)

KPASSWD(1)                       MIT Kerberos                       KPASSWD(1)



NAME
       kpasswd - change a user's Kerberos password

SYNOPSIS
       kpasswd [principal]

DESCRIPTION
       The  kpasswd command is used to change a Kerberos principal's password.
       kpasswd first prompts for the current Kerberos password,  then  prompts
       the user twice for the new password, and the password is changed.

       If  the  principal  is  governed  by a policy that specifies the length
       and/or number of character classes required in the  new  password,  the
       new  password  must conform to the policy.  (The five character classes
       are lower case, upper case, numbers, punctuation, and all other charac‐
       ters.)

OPTIONS
       principal
              Change  the password for the Kerberos principal principal.  Oth‐
              erwise, kpasswd uses the principal name from an existing  ccache
              if there is one; if not, the principal is derived from the iden‐
              tity of the user invoking the kpasswd command.

SEE ALSO
       kadmin(1), kadmind(8)

AUTHOR
       MIT

COPYRIGHT
       1985-2017, MIT




1.15.1                                                              KPASSWD(1)
