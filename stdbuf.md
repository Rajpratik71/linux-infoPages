File: coreutils.info,  Node: stdbuf invocation,  Next: timeout invocation,  Prev: nohup invocation,  Up: Modified command invocation

23.5 ‘stdbuf’: Run a command with modified I/O stream buffering
===============================================================

‘stdbuf’ allows one to modify the buffering operations of the three
standard I/O streams associated with a program.  Synopsis:

     stdbuf OPTION... COMMAND

   COMMAND must start with the name of a program that
  1. uses the ISO C ‘FILE’ streams for input/output (note the programs
     ‘dd’ and ‘cat’ don’t do that),

  2. does not adjust the buffering of its standard streams (note the
     program ‘tee’ is not in this category).

   Any additional ARGs are passed as additional arguments to the
COMMAND.

   The program accepts the following options.  Also see *note Common
options::.

‘-i MODE’
‘--input=MODE’
     Adjust the standard input stream buffering.

‘-o MODE’
‘--output=MODE’
     Adjust the standard output stream buffering.

‘-e MODE’
‘--error=MODE’
     Adjust the standard error stream buffering.

   The MODE can be specified as follows:

‘L’
     Set the stream to line buffered mode.  In this mode data is
     coalesced until a newline is output or input is read from any
     stream attached to a terminal device.  This option is invalid with
     standard input.

‘0’
     Disable buffering of the selected stream.  In this mode, data is
     output immediately and only the amount of data requested is read
     from input.  Note the difference in function for input and output.
     Disabling buffering for input will not influence the responsiveness
     or blocking behavior of the stream input functions.  For example
     ‘fread’ will still block until ‘EOF’ or error, even if the
     underlying ‘read’ returns less data than requested.

‘SIZE’
     Specify the size of the buffer to use in fully buffered mode.  SIZE
     may be, or may be an integer optionally followed by, one of the
     following multiplicative suffixes:
          ‘KB’ =>           1000 (KiloBytes)
          ‘K’  =>           1024 (KibiBytes)
          ‘MB’ =>      1000*1000 (MegaBytes)
          ‘M’  =>      1024*1024 (MebiBytes)
          ‘GB’ => 1000*1000*1000 (GigaBytes)
          ‘G’  => 1024*1024*1024 (GibiBytes)
     and so on for ‘T’, ‘P’, ‘E’, ‘Z’, and ‘Y’.

   ‘stdbuf’ is installed only on platforms that use the Executable and
Linkable Format (ELF) and support the ‘constructor’ attribute, so
portable scripts should not rely on its existence.

   Exit status:

     125 if ‘stdbuf’ itself fails
     126 if COMMAND is found but cannot be invoked
     127 if COMMAND cannot be found
     the exit status of COMMAND otherwise

