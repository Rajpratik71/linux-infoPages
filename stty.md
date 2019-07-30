Next: printenv invocation,  Prev: pwd invocation,  Up: Working context

19.2 ‘stty’: Print or change terminal characteristics
=====================================================

‘stty’ prints or changes terminal characteristics, such as baud rate.
Synopses:

     stty [OPTION] [SETTING]...
     stty [OPTION]

   If given no line settings, ‘stty’ prints the baud rate, line
discipline number (on systems that support it), and line settings that
have been changed from the values set by ‘stty sane’.  By default, mode
reading and setting are performed on the tty line connected to standard
input, although this can be modified by the ‘--file’ option.

   ‘stty’ accepts many non-option arguments that change aspects of the
terminal line operation, as described below.

   The program accepts the following options.  Also see *note Common
options::.

‘-a’
‘--all’
     Print all current settings in human-readable form.  This option may
     not be used in combination with any line settings.

‘-F DEVICE’
‘--file=DEVICE’
     Set the line opened by the file name specified in DEVICE instead of
     the tty line connected to standard input.  This option is necessary
     because opening a POSIX tty requires use of the ‘O_NONDELAY’ flag
     to prevent a POSIX tty from blocking until the carrier detect line
     is high if the ‘clocal’ flag is not set.  Hence, it is not always
     possible to allow the shell to open the device in the traditional
     manner.

‘-g’
‘--save’
     Print all current settings in a form that can be used as an
     argument to another ‘stty’ command to restore the current settings.
     This option may not be used in combination with any line settings.

   Many settings can be turned off by preceding them with a ‘-’.  Such
arguments are marked below with “May be negated” in their description.
The descriptions themselves refer to the positive case, that is, when
_not_ negated (unless stated otherwise, of course).

   Some settings are not available on all POSIX systems, since they use
extensions.  Such arguments are marked below with “Non-POSIX” in their
description.  On non-POSIX systems, those or other settings also may not
be available, but it’s not feasible to document all the variations: just
try it and see.

   ‘stty’ is installed only on platforms with the POSIX terminal
interface, so portable scripts should not rely on its existence on
non-POSIX platforms.

   An exit status of zero indicates success, and a nonzero value
indicates failure.

* Menu:

* Control::                     Control settings
* Input::                       Input settings
* Output::                      Output settings
* Local::                       Local settings
* Combination::                 Combination settings
* Characters::                  Special characters
* Special::                     Special settings

Next: Input,  Up: stty invocation

19.2.1 Control settings
-----------------------

Control settings:

‘parenb’
     Generate parity bit in output and expect parity bit in input.  May
     be negated.

‘parodd’
     Set odd parity (even if negated).  May be negated.

‘cmspar’
     Use "stick" (mark/space) parity.  If parodd is set, the parity bit
     is always 1; if parodd is not set, the parity bit is always zero.
     Non-POSIX.  May be negated.

‘cs5’
‘cs6’
‘cs7’
‘cs8’
     Set character size to 5, 6, 7, or 8 bits.

‘hup’
‘hupcl’
     Send a hangup signal when the last process closes the tty.  May be
     negated.

‘cstopb’
     Use two stop bits per character (one if negated).  May be negated.

‘cread’
     Allow input to be received.  May be negated.

‘clocal’
     Disable modem control signals.  May be negated.

‘crtscts’
     Enable RTS/CTS flow control.  Non-POSIX.  May be negated.

‘cdtrdsr’
     Enable DTR/DSR flow control.  Non-POSIX.  May be negated.

Next: Output,  Prev: Control,  Up: stty invocation

19.2.2 Input settings
---------------------

These settings control operations on data received from the terminal.

‘ignbrk’
     Ignore break characters.  May be negated.

‘brkint’
     Make breaks cause an interrupt signal.  May be negated.

‘ignpar’
     Ignore characters with parity errors.  May be negated.

‘parmrk’
     Mark parity errors (with a 255-0-character sequence).  May be
     negated.

‘inpck’
     Enable input parity checking.  May be negated.

‘istrip’
     Clear high (8th) bit of input characters.  May be negated.

‘inlcr’
     Translate newline to carriage return.  May be negated.

‘igncr’
     Ignore carriage return.  May be negated.

‘icrnl’
     Translate carriage return to newline.  May be negated.

‘iutf8’
     Assume input characters are UTF-8 encoded.  May be negated.

‘ixon’
     Enable XON/XOFF flow control (that is, ‘Ctrl-S’/‘Ctrl-Q’).  May be
     negated.

‘ixoff’
‘tandem’
     Enable sending of ‘stop’ character when the system input buffer is
     almost full, and ‘start’ character when it becomes almost empty
     again.  May be negated.

‘iuclc’
     Translate uppercase characters to lowercase.  Non-POSIX.  May be
     negated.  Note ilcuc is not implemented, as one would not be able
     to issue almost any (lowercase) Unix command, after invoking it.

‘ixany’
     Allow any character to restart output (only the start character if
     negated).  Non-POSIX.  May be negated.

‘imaxbel’
     Enable beeping and not flushing input buffer if a character arrives
     when the input buffer is full.  Non-POSIX.  May be negated.

Next: Local,  Prev: Input,  Up: stty invocation

19.2.3 Output settings
----------------------

These settings control operations on data sent to the terminal.

‘opost’
     Postprocess output.  May be negated.

‘olcuc’
     Translate lowercase characters to uppercase.  Non-POSIX.  May be
     negated.  (Note ouclc is not currently implemented.)

‘ocrnl’
     Translate carriage return to newline.  Non-POSIX.  May be negated.

‘onlcr’
     Translate newline to carriage return-newline.  Non-POSIX.  May be
     negated.

‘onocr’
     Do not print carriage returns in the first column.  Non-POSIX.  May
     be negated.

‘onlret’
     Newline performs a carriage return.  Non-POSIX.  May be negated.

‘ofill’
     Use fill (padding) characters instead of timing for delays.
     Non-POSIX.  May be negated.

‘ofdel’
     Use ASCII DEL characters for fill instead of ASCII NUL characters.
     Non-POSIX.  May be negated.

‘nl1’
‘nl0’
     Newline delay style.  Non-POSIX.

‘cr3’
‘cr2’
‘cr1’
‘cr0’
     Carriage return delay style.  Non-POSIX.

‘tab3’
‘tab2’
‘tab1’
‘tab0’
     Horizontal tab delay style.  Non-POSIX.

‘bs1’
‘bs0’
     Backspace delay style.  Non-POSIX.

‘vt1’
‘vt0’
     Vertical tab delay style.  Non-POSIX.

‘ff1’
‘ff0’
     Form feed delay style.  Non-POSIX.

Next: Combination,  Prev: Output,  Up: stty invocation

19.2.4 Local settings
---------------------

‘isig’
     Enable ‘interrupt’, ‘quit’, and ‘suspend’ special characters.  May
     be negated.

‘icanon’
     Enable ‘erase’, ‘kill’, ‘werase’, and ‘rprnt’ special characters.
     May be negated.

‘iexten’
     Enable non-POSIX special characters.  May be negated.

‘echo’
     Echo input characters.  May be negated.

‘echoe’
‘crterase’
     Echo ‘erase’ characters as backspace-space-backspace.  May be
     negated.

‘echok’
     Echo a newline after a ‘kill’ character.  May be negated.

‘echonl’
     Echo newline even if not echoing other characters.  May be negated.

‘noflsh’
     Disable flushing after ‘interrupt’ and ‘quit’ special characters.
     May be negated.

‘xcase’
     Enable input and output of uppercase characters by preceding their
     lowercase equivalents with ‘\’, when ‘icanon’ is set.  Non-POSIX.
     May be negated.

‘tostop’
     Stop background jobs that try to write to the terminal.  Non-POSIX.
     May be negated.

‘echoprt’
‘prterase’
     Echo erased characters backward, between ‘\’ and ‘/’.  Non-POSIX.
     May be negated.

‘echoctl’
‘ctlecho’
     Echo control characters in hat notation (‘^C’) instead of
     literally.  Non-POSIX.  May be negated.

‘echoke’
‘crtkill’
     Echo the ‘kill’ special character by erasing each character on the
     line as indicated by the ‘echoprt’ and ‘echoe’ settings, instead of
     by the ‘echoctl’ and ‘echok’ settings.  Non-POSIX.  May be negated.

‘extproc’
     Enable ‘LINEMODE’, which is used to avoid echoing each character
     over high latency links.  See also Internet RFC 1116
     (ftp://ftp.rfc-editor.org/in-notes/rfc1116.txt).  Non-POSIX.  May
     be negated.

‘flusho’
     Discard output.  Note this setting is currently ignored on
     GNU/Linux systems.  Non-POSIX.  May be negated.

Next: Characters,  Prev: Local,  Up: stty invocation

19.2.5 Combination settings
---------------------------

Combination settings:

‘evenp’
‘parity’
     Same as ‘parenb -parodd cs7’.  May be negated.  If negated, same as
     ‘-parenb cs8’.

‘oddp’
     Same as ‘parenb parodd cs7’.  May be negated.  If negated, same as
     ‘-parenb cs8’.

‘nl’
     Same as ‘-icrnl -onlcr’.  May be negated.  If negated, same as
     ‘icrnl -inlcr -igncr onlcr -ocrnl -onlret’.

‘ek’
     Reset the ‘erase’ and ‘kill’ special characters to their default
     values.

‘sane’
     Same as:

          cread -ignbrk brkint -inlcr -igncr icrnl
          icanon iexten echo echoe echok -echonl -noflsh
          -ixoff -iutf8 -iuclc -ixany imaxbel -xcase -olcuc -ocrnl
          opost -ofill onlcr -onocr -onlret nl0 cr0 tab0 bs0 vt0 ff0
          isig -tostop -ofdel -echoprt echoctl echoke -extproc

     and also sets all special characters to their default values.

‘cooked’
     Same as ‘brkint ignpar istrip icrnl ixon opost isig icanon’, plus
     sets the ‘eof’ and ‘eol’ characters to their default values if they
     are the same as the ‘min’ and ‘time’ characters.  May be negated.
     If negated, same as ‘raw’.

‘raw’
     Same as:

          -ignbrk -brkint -ignpar -parmrk -inpck -istrip
          -inlcr -igncr -icrnl -ixon -ixoff -icanon -opost
          -isig -iuclc -ixany -imaxbel -xcase min 1 time 0

     May be negated.  If negated, same as ‘cooked’.

‘cbreak’
     Same as ‘-icanon’.  May be negated.  If negated, same as ‘icanon’.

‘pass8’
     Same as ‘-parenb -istrip cs8’.  May be negated.  If negated, same
     as ‘parenb istrip cs7’.

‘litout’
     Same as ‘-parenb -istrip -opost cs8’.  May be negated.  If negated,
     same as ‘parenb istrip opost cs7’.

‘decctlq’
     Same as ‘-ixany’.  Non-POSIX.  May be negated.

‘tabs’
     Same as ‘tab0’.  Non-POSIX.  May be negated.  If negated, same as
     ‘tab3’.

‘lcase’
‘LCASE’
     Same as ‘xcase iuclc olcuc’.  Non-POSIX.  May be negated.  (Used
     for terminals with uppercase characters only.)

‘crt’
     Same as ‘echoe echoctl echoke’.

‘dec’
     Same as ‘echoe echoctl echoke -ixany intr ^C erase ^? kill C-u’.

Next: Special,  Prev: Combination,  Up: stty invocation

19.2.6 Special characters
-------------------------

The special characters’ default values vary from system to system.  They
are set with the syntax ‘name value’, where the names are listed below
and the value can be given either literally, in hat notation (‘^C’), or
as an integer which may start with ‘0x’ to indicate hexadecimal, ‘0’ to
indicate octal, or any other digit to indicate decimal.

   For GNU stty, giving a value of ‘^-’ or ‘undef’ disables that special
character.  (This is incompatible with Ultrix ‘stty’, which uses a value
of ‘u’ to disable a special character.  GNU ‘stty’ treats a value ‘u’
like any other, namely to set that special character to <U>.)

‘intr’
     Send an interrupt signal.

‘quit’
     Send a quit signal.

‘erase’
     Erase the last character typed.

‘kill’
     Erase the current line.

‘eof’
     Send an end of file (terminate the input).

‘eol’
     End the line.

‘eol2’
     Alternate character to end the line.  Non-POSIX.

‘discard’
     Alternate character to toggle discarding of output.  Non-POSIX.

‘swtch’
     Switch to a different shell layer.  Non-POSIX.

‘status’
     Send an info signal.  Not currently supported on Linux.  Non-POSIX.

‘start’
     Restart the output after stopping it.

‘stop’
     Stop the output.

‘susp’
     Send a terminal stop signal.

‘dsusp’
     Send a terminal stop signal after flushing the input.  Non-POSIX.

‘rprnt’
     Redraw the current line.  Non-POSIX.

‘werase’
     Erase the last word typed.  Non-POSIX.

‘lnext’
     Enter the next character typed literally, even if it is a special
     character.  Non-POSIX.

Prev: Characters,  Up: stty invocation

19.2.7 Special settings
-----------------------

‘min N’
     Set the minimum number of characters that will satisfy a read until
     the time value has expired, when ‘-icanon’ is set.

‘time N’
     Set the number of tenths of a second before reads time out if the
     minimum number of characters have not been read, when ‘-icanon’ is
     set.

‘ispeed N’
     Set the input speed to N.

‘ospeed N’
     Set the output speed to N.

‘rows N’
     Tell the tty kernel driver that the terminal has N rows.
     Non-POSIX.

‘cols N’
‘columns N’
     Tell the kernel that the terminal has N columns.  Non-POSIX.

‘drain’
     Apply settings after first waiting for pending output to be
     transmitted.  This is enabled by default for GNU ‘stty’.  It is
     useful to disable this option in cases where the system may be in a
     state where serial transmission is not possible.  For example, if
     the system has received the ‘DC3’ character with ‘ixon’ (software
     flow control) enabled, then ‘stty’ would block without ‘-drain’
     being specified.  May be negated.  Non-POSIX.

‘size’
     Print the number of rows and columns that the kernel thinks the
     terminal has.  (Systems that don’t support rows and columns in the
     kernel typically use the environment variables ‘LINES’ and
     ‘COLUMNS’ instead; however, GNU ‘stty’ does not know anything about
     them.)  Non-POSIX.

‘line N’
     Use line discipline N.  Non-POSIX.

‘speed’
     Print the terminal speed.

‘N’
     Set the input and output speeds to N.  N can be one of: 0 50 75 110
     134 134.5 150 200 300 600 1200 1800 2400 4800 9600 19200 38400
     ‘exta’ ‘extb’.  ‘exta’ is the same as 19200; ‘extb’ is the same as
     38400.  Many systems, including GNU/Linux, support higher speeds.
     The ‘stty’ command includes support for speeds of 57600, 115200,
     230400, 460800, 500000, 576000, 921600, 1000000, 1152000, 1500000,
     2000000, 2500000, 3000000, 3500000, or 4000000 where the system
     supports these.  0 hangs up the line if ‘-clocal’ is set.

