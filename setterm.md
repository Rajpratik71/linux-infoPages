File: *manpages*,  Node: setterm,  Up: (dir)


SETTERM(1)                       User Commands                      SETTERM(1)



NAME
       setterm - set terminal attributes

SYNOPSIS
       setterm [options]

DESCRIPTION
       setterm  writes  to standard output a character string that will invoke
       the specified terminal capabilities.  Where possible terminfo  is  con‐
       sulted  to  find the string to use.  Some options however (marked "vir‐
       tual consoles only" below) do not correspond to a terminfo(5)  capabil‐
       ity.  In this case, if the terminal type is "con" or "linux" the string
       that invokes the specified capabilities on the PC Minix virtual console
       driver is output.  Options that are not implemented by the terminal are
       ignored.

OPTIONS
       For boolean options (on or off), the default is on.

       For conciseness, an 8-color below is black, red, green,  yellow,  blue,
       magenta, cyan, or white.

       A  16-color is an 8-color, grey, or bright followed by red, green, yel‐
       low, blue, magenta, cyan, or white.

       The various color options may be set independently, at least at virtual
       consoles,  though  the  results of setting multiple modes (for example,
       -underline and -half-bright) are hardware-dependent.

       -appcursorkeys [on|off] (virtual consoles only)
              Sets Cursor Key Application Mode on or off. When on,  ESC  O  A,
              ESC O B, etc.  will be sent for the cursor keys instead of ESC [
              A, ESC [ B, etc.  See the "vi and Cursor-Keys"  section  of  the
              Text-Terminal-HOWTO  for  how  this  can  cause  problems for vi
              users.

       -append [1-NR_CONS]
              Like -dump, but appends to the snapshot file  instead  of  over‐
              writing it.  Only works if no -dump options are given.

       -background 8-color|default (virtual consoles only)
              Sets the background text color.

       -blank [0-60|force|poke] (virtual consoles only)
              Sets  the  interval  of  inactivity, in minutes, after which the
              screen will be automatically blanked (using APM  if  available).
              Without an argument, gets the blank status (returns which vt was
              blanked or zero for unblanked vt).

              The force option keeps screen blank even if a key is pressed.

              The poke option unblank the screen.

       -bfreq [freqnumber]
              Sets the bell frequency in Hz.  Without an argument, defaults to
              0.

       -blength [0-2000]
              Sets  the  bell  duration in milliseconds.  Without an argument,
              defaults to 0.

       -blink [on|off]
              Turns blink mode on or off.  Except at a virtual console, -blink
              off  turns  off  all  attributes  (bold, half-brightness, blink,
              reverse).

       -bold [on|off]
              Turns bold (extra bright) mode on or off.  Except at  a  virtual
              console,  -bold off turns off all attributes (bold, half-bright‐
              ness, blink, reverse).

       -clear [all]
              Clears the screen and "homes" the cursor, as clear(1).

       -clear rest
              Clears from the current  cursor  position  to  the  end  of  the
              screen.

       -clrtabs [tab1 tab2 tab3 ...] (virtual consoles only)
              Clears  tab stops from the given horizontal cursor positions, in
              the range 1-160.  Without arguments, clears all tab stops.

       -cursor [on|off]
              Turns the terminal's cursor on or off.

       -default
              Sets the terminal's rendering options to the default values.

       -dump [1-NR_CONS]
              Writes a snapshot of the given virtual console (with attributes)
              to  the file specified in the -file option, overwriting its con‐
              tents; the default is screen.dump.  Without an  argument,  dumps
              the current virtual console.  Overrides -append.

       -append [1-NR_CONS]
              Like  -dump,  but  appends to the snapshot file instead of over‐
              writing it.  Only works if no -dump options are given.

       -file dumpfilename
              Sets the snapshot file name for any -dump or -append options  on
              the  same  command  line.   If  this  option is not present, the
              default is screen.dump in the current directory.   A  path  name
              that exceeds system maximum will be truncated, see PATH_MAX from
              linux/limits.h for the value.

       -msg [on|off] (virtual consoles only)
              Enables or disables the sending of kernel printk()  messages  to
              the console.

       -msglevel 1-8 (virtual consoles only)
              Sets  the  console  logging  level for kernel printk() messages.
              All messages strictly more important than this will be  printed,
              so  a  logging  level  of 0 has the same effect as -msg on and a
              logging level of 8 will print all kernel messages.  klogd(8) may
              be  a  more  convenient  interface to the logging of kernel mes‐
              sages.

       -powerdown [0-60]
              Sets the VESA powerdown interval in minutes.  Without  an  argu‐
              ment,  defaults  to  0  (disable  powerdown).  If the console is
              blanked or the monitor is in suspend mode, then the monitor will
              go  into vsync suspend mode or powerdown mode respectively after
              this period of time has elapsed.

       -underline [on|off]
              Turns underline mode on or off (see -ulcolor).

       -powersave [off]
              Turns off monitor VESA powersaving features.

       -powersave on|vsync
              Puts the monitor into VESA vsync suspend mode.

       -powersave powerdown
              Puts the monitor into VESA powerdown mode.

       -powersave hsync
              Puts the monitor into VESA hsync suspend mode.

       -regtabs [1-160] (virtual consoles only)
              Clears all tab stops, then sets a regular tab stop pattern, with
              one  tab  every specified number of positions.  Without an argu‐
              ment, defaults to 8.

       -repeat [on|off] (virtual consoles only)
              Turns keyboard repeat on or off.

       -reset Displays the terminal reset string, which typically  resets  the
              terminal to its power on state.

       -reverse [on|off]
              Turns  reverse  video  mode on or off.  Except at a virtual con‐
              sole, -reverse off turns off all attributes (bold,  half-bright‐
              ness, blink, reverse).

       -store (virtual consoles only)
              Stores  the terminal's current rendering options (foreground and
              background colors) as the values to be used at reset-to-default.

       -tabs [tab1 tab2 tab3 ...] (virtual consoles only)
              Sets tab stops at the given horizontal cursor positions, in  the
              range 1-160.  Without arguments, shows the current tab stop set‐
              tings.

       -term terminal_name
              Overrides the TERM environment variable.

       -ulcolor 16-color (virtual consoles only)
              Sets the color for underlined characters.

       -version
              Output version information and exit.

       -help  Output help screen and exit.

SEE ALSO
       tput(1), stty(1), terminfo(5), tty(4)

BUGS
       Differences between the Minix and Linux versions are not documented.

AVAILABILITY
       The setterm command is part of the util-linux package and is  available
       from ftp://ftp.kernel.org/pub/linux/utils/util-linux/.



util-linux                       January 2000                       SETTERM(1)
curs_terminfo(3X)                                            curs_terminfo(3X)



NAME
       del_curterm, mvcur, putp, restartterm, set_curterm, setterm, setupterm,
       tigetflag, tigetnum, tigetstr, tiparm, tparm, tputs, vid_attr,
       vid_puts, vidattr, vidputs - curses interfaces to terminfo database

SYNOPSIS
       #include <curses.h>
       #include <term.h>

       int setupterm(char *term, int fildes, int *errret);
       int setterm(char *term);
       TERMINAL *set_curterm(TERMINAL *nterm);
       int del_curterm(TERMINAL *oterm);
       int restartterm(char *term, int fildes, int *errret);
       char *tparm(char *str, ...);
       int tputs(const char *str, int affcnt, int (*putc)(int));
       int putp(const char *str);
       int vidputs(chtype attrs, int (*putc)(int));
       int vidattr(chtype attrs);
       int vid_puts(attr_t attrs, short pair, void *opts, int (*putc)(int));
       int vid_attr(attr_t attrs, short pair, void *opts);
       int mvcur(int oldrow, int oldcol, int newrow, int newcol);
       int tigetflag(char *capname);
       int tigetnum(char *capname);
       char *tigetstr(char *capname);
       char *tiparm(const char *str, ...);

DESCRIPTION
       These  low-level  routines must be called by programs that have to deal
       directly with the terminfo database to handle certain terminal capabil‐
       ities, such as programming function keys.  For all other functionality,
       curses routines are more suitable and their use is recommended.

       Initially, setupterm should be called.  Note that setupterm is automat‐
       ically  called  by initscr and newterm.  This defines the set of termi‐
       nal-dependent variables [listed in terminfo(5)].   The  terminfo  vari‐
       ables lines and columns are initialized by setupterm as follows:

              If  use_env(FALSE) has been called, values for lines and columns
              specified in terminfo are used.

              Otherwise, if the environment variables LINES and COLUMNS exist,
              their  values  are  used.  If these environment variables do not
              exist and the program is running in a window, the current window
              size  is  used.   Otherwise, if the environment variables do not
              exist, the values for lines and columns specified in the termin‐
              fo database are used.

       The header files curses.h and term.h should be included (in this order)
       to get the definitions for these strings, numbers, and flags.   Parame‐
       terized  strings  should  be  passed through tparm to instantiate them.
       All terminfo strings [including the output of tparm] should be  printed
       with tputs or putp.  Call the reset_shell_mode to restore the tty modes
       before exiting [see curs_kernel(3X)].  Programs which  use  cursor  ad‐
       dressing should output enter_ca_mode upon startup and should output ex‐
       it_ca_mode before exiting.  Programs desiring shell escapes should call

       reset_shell_mode and output exit_ca_mode before the shell is called and
       should  output  enter_ca_mode  and call reset_prog_mode after returning
       from the shell.

       The setupterm routine reads in the terminfo database, initializing  the
       terminfo  structures,  but  does  not  set up the output virtualization
       structures used by curses.  The terminal type is the  character  string
       term; if term is null, the environment variable TERM is used.  All out‐
       put is to file descriptor fildes which is initialized for  output.   If
       errret  is not null, then setupterm returns OK or ERR and stores a sta‐
       tus value in the integer pointed to by errret.  A return  value  of  OK
       combined with status of 1 in errret is normal.  If ERR is returned, ex‐
       amine errret:

              1    means that the terminal is hardcopy,  cannot  be  used  for
                   curses applications.

              0    means that the terminal could not be found, or that it is a
                   generic type, having too little information for curses  ap‐
                   plications to run.

              -1   means that the terminfo database could not be found.

       If  errret  is  null, setupterm prints an error message upon finding an
       error and exits.  Thus, the simplest call is:

             setupterm((char *)0, 1, (int *)0);,

       which uses all the defaults and sends the output to stdout.

       The setterm routine is being replaced by setupterm.  The call:

             setupterm(term, 1, (int *)0)

       provides the same functionality as setterm(term).  The setterm  routine
       is  included here for BSD compatibility, and is not recommended for new
       programs.

       The set_curterm routine sets the variable cur_term to nterm, and  makes
       all of the terminfo boolean, numeric, and string variables use the val‐
       ues from nterm.  It returns the old value of cur_term.

       The del_curterm routine frees the space pointed to by oterm  and  makes
       it available for further use.  If oterm is the same as cur_term, refer‐
       ences to any of the terminfo boolean,  numeric,  and  string  variables
       thereafter  may  refer  to  invalid  memory locations until another se‐
       tupterm has been called.

       The restartterm routine is similar to  setupterm  and  initscr,  except
       that it is called after restoring memory to a previous state (for exam‐
       ple, when reloading a game saved as a core  image  dump).   It  assumes
       that  the windows and the input and output options are the same as when
       memory was saved, but the terminal type and baud rate may be different.
       Accordingly, it saves various tty state bits, calls setupterm, and then
       restores the bits.

       The tparm routine instantiates the string str with  parameters  pi.   A
       pointer is returned to the result of str with the parameters applied.

       tiparm  is  a  newer  form of tparm which uses <stdarg.h> rather than a
       fixed-parameter list.  Its numeric parameters are integers (int) rather
       than longs.

       The  tputs  routine  applies  padding information to the string str and
       outputs it.  The str must be a terminfo string variable or  the  return
       value from tparm, tgetstr, or tgoto.  affcnt is the number of lines af‐
       fected, or 1 if not applicable.  putc  is  a  putchar-like  routine  to
       which the characters are passed, one at a time.

       The putp routine calls tputs(str, 1, putchar).  Note that the output of
       putp always goes to stdout, not to the fildes specified in setupterm.

       The vidputs routine displays the string on the terminal  in  the  video
       attribute mode attrs, which is any combination of the attributes listed
       in curses(3X).  The characters are passed to the  putchar-like  routine
       putc.

       The vidattr routine is like the vidputs routine, except that it outputs
       through putchar.

       The vid_attr and vid_puts routines correspond to vidattr  and  vidputs,
       respectively.   They  use a set of arguments for representing the video
       attributes plus color, i.e., one of type attr_t for the attributes  and
       one of short for the color_pair number.  The vid_attr and vid_puts rou‐
       tines are designed to use the attribute constants with the WA_  prefix.
       The  opts argument is reserved for future use.  Currently, applications
       must provide a null pointer for that argument.

       The mvcur routine provides low-level cursor motion.   It  takes  effect
       immediately (rather than at the next refresh).

       The  tigetflag,  tigetnum and tigetstr routines return the value of the
       capability corresponding to the terminfo capname passed to  them,  such
       as xenl.

       The  tigetflag routine returns the value -1 if capname is not a boolean
       capability, or 0 if it is canceled or absent from the terminal descrip‐
       tion.

       The  tigetnum  routine returns the value -2 if capname is not a numeric
       capability, or -1 if it is canceled or absent  from  the  terminal  de‐
       scription.

       The  tigetstr  routine returns the value (char *)-1 if capname is not a
       string capability, or 0 if it is canceled or absent from  the  terminal
       description.

       The  capname  for each capability is given in the table column entitled
       capname code in the capabilities section of terminfo(5).

              char *boolnames[], *boolcodes[], *boolfnames[]

              char *numnames[], *numcodes[], *numfnames[]

              char *strnames[], *strcodes[], *strfnames[]

       These null-terminated arrays contain the capnames, the  termcap  codes,
       and the full C names, for each of the terminfo variables.

RETURN VALUE
       Routines  that  return  an integer return ERR upon failure and OK (SVr4
       only specifies "an integer value other than ERR") upon successful  com‐
       pletion, unless otherwise noted in the preceding routine descriptions.

       Routines that return pointers always return NULL on error.

       X/Open defines no error conditions.  In this implementation

              del_curterm
                   returns an error if its terminal parameter is null.

              putp calls tputs, returning the same error-codes.

              restartterm
                   returns  an  error  if the associated call to setupterm re‐
                   turns an error.

              setupterm
                   returns an error if it cannot allocate  enough  memory,  or
                   create the initial windows (stdscr, curscr, newscr).  Other
                   error conditions are documented above.

              tputs
                   returns an error if the string parameter is null.  It  does
                   not detect I/O errors: X/Open states that tputs ignores the
                   return value of the output function putc.

NOTES
       The setupterm routine should be used in place of setterm.   It  may  be
       useful  when you want to test for terminal capabilities without commit‐
       ting to the allocation of storage involved in initscr.

       Note that vidattr and vidputs may be macros.

PORTABILITY
       The function setterm is not described by X/Open and must be  considered
       non-portable.  All other functions are as described by X/Open.

       setupterm  copies  the terminal name to the array ttytype.  This is not
       part of X/Open Curses, but is assumed by some applications.

       In System V Release 4, set_curterm has an int return type  and  returns
       OK or ERR.  We have chosen to implement the X/Open Curses semantics.

       In  System  V  Release  4, the third argument of tputs has the type int
       (*putc)(char).

       At least one implementation of X/Open Curses (Solaris) returns a  value
       other  than  OK/ERR from tputs.  That returns the length of the string,
       and does no error-checking.

       X/Open Curses prototypes tparm  with  a  fixed  number  of  parameters,
       rather than a variable argument list.  This implementation uses a vari‐
       able argument list, but can be configured to  use  the  fixed-parameter
       list.  Portable applications should provide 9 parameters after the for‐
       mat; zeroes are fine for this purpose.

       In response to comments by Thomas E. Dickey, X/Open Curses Issue 7 pro‐
       posed the tiparam function in mid-2009.

       X/Open  notes  that after calling mvcur, the curses state may not match
       the actual terminal state, and that an application should touch and re‐
       fresh the window before resuming normal curses calls.  Both ncurses and
       System V Release 4 curses implement mvcur using the SCREEN  data  allo‐
       cated  in  either  initscr or newterm.  So though it is documented as a
       terminfo function, mvcur is really a curses function which is not  well
       specified.

       X/Open  states that the old location must be given for mvcur.  This im‐
       plementation allows the caller to use -1's for the old  ordinates.   In
       that case, the old location is unknown.

       Extended terminal capability names, e.g., as defined by tic -x, are not
       stored in the arrays described in this section.

SEE ALSO
       curses(3X),   curs_initscr(3X),   curs_kernel(3X),    curs_termcap(3X),
       curs_variables(3X), term_variables(3X), putc(3), terminfo(5)



                                                             curs_terminfo(3X)
