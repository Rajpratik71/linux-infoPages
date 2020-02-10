Prev: vdir invocation,  Up: Directory listing

10.4 ‘dircolors’: Color setup for ‘ls’
======================================

‘dircolors’ outputs a sequence of shell commands to set up the terminal
for color output from ‘ls’ (and ‘dir’, etc.).  Typical usage:

     eval "$(dircolors [OPTION]... [FILE])"

   If FILE is specified, ‘dircolors’ reads it to determine which colors
to use for which file types and extensions.  Otherwise, a precompiled
database is used.  For details on the format of these files, run
‘dircolors --print-database’.

   To make ‘dircolors’ read a ‘~/.dircolors’ file if it exists, you can
put the following lines in your ‘~/.bashrc’ (or adapt them to your
favorite shell):

     d=.dircolors
     test -r $d && eval "$(dircolors $d)"

   The output is a shell command to set the ‘LS_COLORS’ environment
variable.  You can specify the shell syntax to use on the command line,
or ‘dircolors’ will guess it from the value of the ‘SHELL’ environment
variable.

   The program accepts the following options.  Also see *note Common
options::.

‘-b’
‘--sh’
‘--bourne-shell’
     Output Bourne shell commands.  This is the default if the ‘SHELL’
     environment variable is set and does not end with ‘csh’ or ‘tcsh’.

‘-c’
‘--csh’
‘--c-shell’
     Output C shell commands.  This is the default if ‘SHELL’ ends with
     ‘csh’ or ‘tcsh’.

‘-p’
‘--print-database’
     Print the (compiled-in) default color configuration database.  This
     output is itself a valid configuration file, and is fairly
     descriptive of the possibilities.

   An exit status of zero indicates success, and a nonzero value
indicates failure.

