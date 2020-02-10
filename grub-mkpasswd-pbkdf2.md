Next: Invoking grub-mkrelpath,  Prev: Invoking grub-mkconfig,  Up: Top

25 Invoking grub-mkpasswd-pbkdf2
********************************

The program 'grub-mkpasswd-pbkdf2' generates password hashes for GRUB
(*note Security::).

     grub-mkpasswd-pbkdf2

   'grub-mkpasswd-pbkdf2' accepts the following options:

'-c NUMBER'
'--iteration-count=NUMBER'
     Number of iterations of the underlying pseudo-random function.
     Defaults to 10000.

'-l NUMBER'
'--buflen=NUMBER'
     Length of the generated hash.  Defaults to 64.

'-s NUMBER'
'--salt=NUMBER'
     Length of the salt.  Defaults to 64.

