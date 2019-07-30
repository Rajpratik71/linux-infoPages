Next: Obtaining and Building GRUB,  Prev: Invoking grub-probe,  Up: Top

30 Invoking grub-script-check
*****************************

The program 'grub-script-check' takes a GRUB script file (*note
Shell-like scripting::) and checks it for syntax errors, similar to
commands such as 'sh -n'.  It may take a PATH as a non-option argument;
if none is supplied, it will read from standard input.

     grub-script-check /boot/grub/grub.cfg

   'grub-script-check' accepts the following options:

'--help'
     Print a summary of the command-line options and exit.

'--version'
     Print the version number of GRUB and exit.

'-v'
'--verbose'
     Print each line of input after reading it.

