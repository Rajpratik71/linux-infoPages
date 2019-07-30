Next: Invoking grub-mkpasswd-pbkdf2,  Prev: Invoking grub-install,  Up: Top

24 Invoking grub-mkconfig
*************************

The program 'grub-mkconfig' generates a configuration file for GRUB
(*note Simple configuration::).

     grub-mkconfig -o /boot/grub/grub.cfg

   'grub-mkconfig' accepts the following options:

'--help'
     Print a summary of the command-line options and exit.

'--version'
     Print the version number of GRUB and exit.

'-o FILE'
'--output=FILE'
     Send the generated configuration file to FILE.  The default is to
     send it to standard output.

