File: *manpages*,  Node: setterm,  Up: (dir)

SETTERM(1)                       User Commands                      SETTERM(1)



NAME
       setterm - set terminal attributes

SYNOPSIS
       setterm [options]

DESCRIPTION
       setterm  writes  to standard output a character string that will invoke
       the specified terminal capabilities.  Where possible terminfo  is  con-
       sulted  to  find the string to use.  Some options however (marked "vir-
       tual consoles only" below) do not correspond to a terminfo(5)  capabil-
       ity.  In this case, if the terminal type is "con" or "linux" the string
       that invokes the specified capabilities on the PC Minix virtual console
       driver is output.  Options that are not implemented by the terminal are
       ignored.

OPTIONS
       For boolean options (on or off), the default is on.

       Below, an 8-color can be black,  red,  green,  yellow,  blue,  magenta,
       cyan, or white.

       A  16-color  can  be  an  8-color,  or grey, or bright followed by red,
       green, yellow, blue, magenta, cyan, or white.

       The various color options may be set independently, at least on virtual
       consoles,  though  the  results of setting multiple modes (for example,
       --underline and --half-bright) are hardware-dependent.

       --appcursorkeys [on|off]  (virtual consoles only)
              Sets Cursor Key Application Mode on or off.  When on, ESC  O  A,
              ESC O B, etc.  will be sent for the cursor keys instead of ESC [
              A, ESC [ B, etc.  See the vi  and  Cursor-Keys  section  of  the
              Text-Terminal-HOWTO  for  how  this  can  cause  problems for vi
              users.

       --append [console_number]
              Like --dump, but appends to the snapshot file instead  of  over-
              writing it.  Only works if no --dump options are given.

       --background 8-color|default
              Sets the background text color.

       --blank [0-60|force|poke]  (virtual consoles only)
              Sets  the  interval  of  inactivity, in minutes, after which the
              screen will be automatically blanked (using APM  if  available).
              Without  an argument, it gets the blank status (returns which vt
              was blanked, or zero for an unblanked vt).

              The force option keeps  the  screen  blank  even  if  a  key  is
              pressed.

              The poke option unblanks the screen.

       --bfreq [number]  (virtual consoles only)
              Sets  the  bell  frequency  in  Hertz.   Without an argument, it
              defaults to 0.

       --blength [0-2000]  (virtual consoles only)
              Sets the bell duration in milliseconds.  Without an argument, it
              defaults to 0.

       --blink [on|off]
              Turns  blink  mode  on  or  off.   Except  on a virtual console,
              --blink off turns off  all  attributes  (bold,  half-brightness,
              blink, reverse).

       --bold [on|off]
              Turns  bold  (extra bright) mode on or off.  Except on a virtual
              console, --bold off turns off all attributes (bold, half-bright-
              ness, blink, reverse).

       --clear [all|rest]
              Without  an argument or with the argument all, the entire screen
              is cleared and the cursor is set to the home position, just like
              clear(1)  does.   With  the argument rest, the screen is cleared
              from the current cursor position to the end.

       --clrtabs [tab1 tab2 tab3 ...]  (virtual consoles only)
              Clears tab stops from the given horizontal cursor positions,  in
              the range 1-160.  Without arguments, it clears all tab stops.

       --cursor [on|off]
              Turns the terminal's cursor on or off.

       --default
              Sets the terminal's rendering options to the default values.

       --dump [console_number]
              Writes  a  snapshot of the virtual console with the given number
              to the file specified with the --file  option,  overwriting  its
              contents;  the  default is screen.dump.  Without an argument, it
              dumps the current virtual console.  This overrides --append.

       --file filename
              Sets the snapshot file name for any --dump or  --append  options
              on  the  same  command line.  If this option is not present, the
              default is screen.dump in the current directory.   A  path  name
              that  exceeds the system maximum will be truncated, see PATH_MAX
              from linux/limits.h for the value.

       --foreground 8-color|default
              Sets the foreground text color.

       --half-bright [on|off]
              Turns dim (half-brightness) mode on or off.  Except on a virtual
              console, --half-bright off turns off all attributes (bold, half-
              brightness, blink, reverse).

       --hbcolor 16-color
              Sets the color for bold characters.

       --initialize
              Displays the terminal  initialization  string,  which  typically
              sets  the  terminal's rendering options, and other attributes to
              the default values.

       --inversescreen [on|off]
              Swaps foreground and background colors for the whole screen.

       --linewrap [on|off]
              Makes the terminal continue on a new line when a line is full.

       --msg [on|off]  (virtual consoles only)
              Enables or disables the sending of kernel printk()  messages  to
              the console.

       --msglevel 0-8  (virtual consoles only)
              Sets  the  console  logging  level for kernel printk() messages.
              All messages strictly more important than this will be  printed,
              so  a  logging  level of 0 has the same effect as --msg on and a
              logging level of 8 will print all kernel messages.  klogd(8) may
              be  a  more  convenient  interface to the logging of kernel mes-
              sages.

       --powerdown [0-60]
              Sets the VESA powerdown interval in minutes.  Without  an  argu-
              ment,  it  defaults to 0 (disable powerdown).  If the console is
              blanked or the monitor is in suspend mode, then the monitor will
              go  into vsync suspend mode or powerdown mode respectively after
              this period of time has elapsed.

       --powersave off
              Turns off monitor VESA powersaving features.

       --powersave on|vsync
              Puts the monitor into VESA vsync suspend mode.

       --powersave powerdown
              Puts the monitor into VESA powerdown mode.

       --powersave hsync
              Puts the monitor into VESA hsync suspend mode.

       --regtabs [1-160]  (virtual consoles only)
              Clears all tab stops, then sets a regular tab stop pattern, with
              one  tab  every specified number of positions.  Without an argu-
              ment, it defaults to 8.

       --repeat [on|off]  (virtual consoles only)
              Turns keyboard repeat on or off.

       --reset
              Displays the terminal reset string, which typically  resets  the
              terminal to its power-on state.

       --reverse [on|off]
              Turns  reverse  video  mode on or off.  Except on a virtual con-
              sole, --reverse off turns off all attributes (bold, half-bright-
              ness, blink, reverse).

       --store  (virtual consoles only)
              Stores  the terminal's current rendering options (foreground and
              background colors) as the values to be used at reset-to-default.

       --tabs [tab1 tab2 tab3 ...]
              Sets tab stops at the given horizontal cursor positions, in  the
              range  1-160.   Without arguments, it shows the current tab stop
              settings.

       --term terminal_name
              Overrides the TERM environment variable.

       --ulcolor 16-color  (virtual consoles only)
              Sets the color for underlined characters.

       --underline [on|off]
              Turns underline mode on or off.

       --version
              Displays version information and exits.

       --help Displays a help text and exits.

COMPATIBILITY
       Since version 2.25 setterm  has  support  for  long  options  with  two
       hyphens,  for example --help, beside the historical long options with a
       single hyphen, for example -help.  In scripts it is better to  use  the
       backward-compatible  single hyphen rather than the double hyphen.  Cur-
       rently there are no plans nor good reasons to discontinue single-hyphen
       compatibility.

SEE ALSO
       stty(1), tput(1), tty(4), terminfo(5)

BUGS
       Differences between the Minix and Linux versions are not documented.

AVAILABILITY
       The  setterm command is part of the util-linux package and is available
       from Linux Kernel  Archive  ⟨ftp://ftp.kernel.org/pub/linux/utils/util-
       linux/⟩.



util-linux                         May 2014                         SETTERM(1)
terminfo(3NCURSES)                                          terminfo(3NCURSES)



NAME
       del_curterm, mvcur, putp, restartterm, set_curterm, setterm, setupterm,
       tigetflag, tigetnum, tigetstr, tiparm, tparm, tputs, vid_attr,
       vid_puts, vidattr, vidputs - curses interfaces to terminfo database

SYNOPSIS
       #include <ncurses/curses.h>
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
       directly with the terminfo database to handle certain terminal capabil-
       ities, such as programming function keys.  For all other functionality,
       curses routines are more suitable and their use is recommended.

   Initialization
       Initially, setupterm should be called.  Note that setupterm is automat-
       ically  called  by initscr and newterm.  This defines the set of termi-
       nal-dependent variables [listed in terminfo(5)].

       Each initialization routine provides applications with the terminal ca-
       pabilities  either  directly  (via  header  definitions), or by special
       functions.  The header files curses.h and term.h should be included (in
       this  order)  to  get  the  definitions for these strings, numbers, and
       flags.

       The terminfo variables lines and columns are initialized  by  setupterm
       as follows:

       ·   If  use_env(FALSE)  has  been  called, values for lines and columns
           specified in terminfo are used.

       ·   Otherwise, if the environment variables LINES  and  COLUMNS  exist,
           their values are used.  If these environment variables do not exist
           and the program is running in a window, the current window size  is
           used.   Otherwise,  if  the environment variables do not exist, the
           values for lines and columns specified in the terminfo database are
           used.

       Parameterized  strings  should  be  passed through tparm to instantiate
       them.  All terminfo strings [including the output of tparm]  should  be
       printed  with  tputs or putp.  Call reset_shell_mode to restore the tty
       modes before exiting [see kernel(3NCURSES)].

       Programs which use cursor addressing should

       ·   output enter_ca_mode upon startup and

       ·   output exit_ca_mode before exiting.

       Programs which execute shell subprocesses should

       ·   call reset_shell_mode and output exit_ca_mode before the  shell  is
           called and

       ·   output  enter_ca_mode and call reset_prog_mode after returning from
           the shell.

       The setupterm routine reads in the terminfo database, initializing  the
       terminfo  structures,  but  does  not  set up the output virtualization
       structures used by curses.  The terminal type is the  character  string
       term; if term is null, the environment variable TERM is used.  All out-
       put is to file descriptor fildes which is initialized for  output.   If
       errret  is not null, then setupterm returns OK or ERR and stores a sta-
       tus value in the integer pointed to by errret.  A return  value  of  OK
       combined with status of 1 in errret is normal.  If ERR is returned, ex-
       amine errret:

       1    means that the terminal is hardcopy, cannot be used for curses ap-
            plications.

            setupterm  determines  if the entry is a hardcopy type by checking
            the hc (hardcopy) capability.

       0    means that the terminal could not be found, or that it is a gener-
            ic  type, having too little information for curses applications to
            run.

            setupterm determines if the entry is a generic  type  by  checking
            the gn (generic) capability.

       -1   means that the terminfo database could not be found.

       If  errret  is  null, setupterm prints an error message upon finding an
       error and exits.  Thus, the simplest call is:

             setupterm((char *)0, 1, (int *)0);,

       which uses all the defaults and sends the output to stdout.

       The setterm routine was replaced by setupterm.  The call:

             setupterm(term, 1, (int *)0)

       provides the same functionality as setterm(term).  The setterm  routine
       is  provided for BSD compatibility, and is not recommended for new pro-
       grams.

   The Terminal State
       The setupterm routine stores its information about the  terminal  in  a
       TERMINAL  structure  pointed to by the global variable cur_term.  If it
       detects an error, or decides that the terminal is unsuitable  (hardcopy
       or  generic),  it discards this information, making it not available to
       applications.

       If setupterm is called repeatedly for the same terminal type,  it  will
       reuse  the  information.   It maintains only one copy of a given termi-
       nal's capabilities in memory.  If it is called for  different  terminal
       types,  setupterm  allocates new storage for each set of terminal capa-
       bilities.

       The set_curterm routine sets cur_term to nterm, and makes  all  of  the
       terminfo  boolean,  numeric,  and  string variables use the values from
       nterm.  It returns the old value of cur_term.

       The del_curterm routine frees the space pointed to by oterm  and  makes
       it available for further use.  If oterm is the same as cur_term, refer-
       ences to any of the terminfo boolean,  numeric,  and  string  variables
       thereafter  may  refer  to  invalid  memory locations until another se-
       tupterm has been called.

       The restartterm routine is similar to  setupterm  and  initscr,  except
       that it is called after restoring memory to a previous state (for exam-
       ple, when reloading a game saved as a core  image  dump).   restartterm
       assumes  that the windows and the input and output options are the same
       as when memory was saved, but the terminal type and baud  rate  may  be
       different.   Accordingly,  restartterm  saves  various  tty state bits,
       calls setupterm, and then restores the bits.

   Formatting Output
       The tparm routine instantiates the string str with  parameters  pi.   A
       pointer is returned to the result of str with the parameters applied.

       tiparm  is  a  newer  form of tparm which uses <stdarg.h> rather than a
       fixed-parameter list.  Its numeric parameters are integers (int) rather
       than longs.

   Output Functions
       The  tputs  routine  applies  padding information to the string str and
       outputs it.  The str must be a terminfo string variable or  the  return
       value from tparm, tgetstr, or tgoto.  affcnt is the number of lines af-
       fected, or 1 if not applicable.  putc  is  a  putchar-like  routine  to
       which the characters are passed, one at a time.

       The putp routine calls tputs(str, 1, putchar).  Note that the output of
       putp always goes to stdout, not to the fildes specified in setupterm.

       The vidputs routine displays the string on the terminal  in  the  video
       attribute mode attrs, which is any combination of the attributes listed
       in ncurses(3NCURSES).  The characters are passed  to  the  putchar-like
       routine putc.

       The vidattr routine is like the vidputs routine, except that it outputs
       through putchar.

       The vid_attr and vid_puts routines correspond to vidattr  and  vidputs,
       respectively.   They  use a set of arguments for representing the video
       attributes plus color, i.e., one of type attr_t for the attributes  and
       one of short for the color_pair number.  The vid_attr and vid_puts rou-
       tines are designed to use the attribute constants with the WA_  prefix.
       The  opts argument is reserved for future use.  Currently, applications
       must provide a null pointer for that argument.

       The mvcur routine provides low-level cursor motion.   It  takes  effect
       immediately (rather than at the next refresh).

   Terminal Capability Functions
       The  tigetflag,  tigetnum and tigetstr routines return the value of the
       capability corresponding to the terminfo capname passed to  them,  such
       as  xenl.  The capname for each capability is given in the table column
       entitled capname code in the capabilities section of terminfo(5).

       These routines return special values to denote errors.

       The tigetflag routine returns

       -1     if capname is not a boolean capability, or

       0      if it is canceled or absent from the terminal description.

       The tigetnum routine returns

       -2     if capname is not a numeric capability, or

       -1     if it is canceled or absent from the terminal description.

       The tigetstr routine returns

       (char *)-1
              if capname is not a string capability, or

       0      if it is canceled or absent from the terminal description.

   Terminal Capability Names
       These  null-terminated  arrays  contain  the   short   terminfo   names
       ("codes"),  the  termcap  names, and the long terminfo names ("fnames")
       for each of the predefined terminfo variables:
              char *boolnames[], *boolcodes[], *boolfnames[]

              char *numnames[], *numcodes[], *numfnames[]

              char *strnames[], *strcodes[], *strfnames[]

RETURN VALUE
       Routines that return an integer return ERR upon failure  and  OK  (SVr4
       only  specifies "an integer value other than ERR") upon successful com-
       pletion, unless otherwise noted in the preceding routine descriptions.

       Routines that return pointers always return NULL on error.

       X/Open defines no error conditions.  In this implementation

            del_curterm
                 returns an error if its terminal parameter is null.

            putp calls tputs, returning the same error-codes.

            restartterm
                 returns an error if the associated call to setupterm  returns
                 an error.

            setupterm
                 returns an error if it cannot allocate enough memory, or cre-
                 ate the initial windows (stdscr, curscr, newscr).  Other  er-
                 ror conditions are documented above.

            tputs
                 returns  an  error  if the string parameter is null.  It does
                 not detect I/O errors: X/Open states that tputs  ignores  the
                 return value of the output function putc.

PORTABILITY
       X/Open notes that vidattr and vidputs may be macros.

       The  function setterm is not described by X/Open and must be considered
       non-portable.  All other functions are as described by X/Open.

       setupterm copies the terminal name to the array ttytype.  This  is  not
       part of X/Open Curses, but is assumed by some applications.

       If configured to use the terminal-driver, e.g., for the MinGW port,

       ·   setupterm  interprets  a missing/empty TERM variable as the special
           value “unknown”.

       ·   setupterm allows explicit use of the the windows console driver  by
           checking  if $TERM is set to “#win32con” or an abbreviation of that
           string.

       Older versions of ncurses assumed that the file  descriptor  passed  to
       setupterm from initscr or newterm uses buffered I/O, and would write to
       the corresponding stream.  In addition to the limitation that the  ter-
       minal was left in block-buffered mode on exit (like SystemV curses), it
       was problematic because ncurses did not allow a reliable way to cleanup
       on  receiving SIGTSTP.  The current version uses output buffers managed
       directly by ncurses.  Some of the low-level functions described in this
       manual  page  write  to the standard output.  They are not signal-safe.
       The high-level functions in ncurses use  alternate  versions  of  these
       functions using the more reliable buffering scheme.

       In  System  V Release 4, set_curterm has an int return type and returns
       OK or ERR.  We have chosen to implement the X/Open Curses semantics.

       In System V Release 4, the third argument of tputs  has  the  type  int
       (*putc)(char).

       At  least one implementation of X/Open Curses (Solaris) returns a value
       other than OK/ERR from tputs.  That returns the length of  the  string,
       and does no error-checking.

       X/Open  Curses  prototypes  tparm  with  a  fixed number of parameters,
       rather than a variable argument list.  This implementation uses a vari-
       able  argument  list,  but can be configured to use the fixed-parameter
       list.  Portable applications should provide 9 parameters after the for-
       mat; zeroes are fine for this purpose.

       In response to comments by Thomas E. Dickey, X/Open Curses Issue 7 pro-
       posed the tiparm function in mid-2009.

       X/Open notes that after calling mvcur, the curses state may  not  match
       the actual terminal state, and that an application should touch and re-
       fresh the window before resuming normal curses calls.  Both ncurses and
       System  V  Release 4 curses implement mvcur using the SCREEN data allo-
       cated in either initscr or newterm.  So though it is  documented  as  a
       terminfo  function, mvcur is really a curses function which is not well
       specified.

       X/Open states that the old location must be given for mvcur.  This  im-
       plementation  allows  the caller to use -1's for the old ordinates.  In
       that case, the old location is unknown.

       Other implementions may not declare the capability name  arrays.   Some
       provide them without declaring them.  X/Open does not specify them.

       Extended terminal capability names, e.g., as defined by tic -x, are not
       stored in the arrays described here.

SEE ALSO
       ncurses(3NCURSES), initscr(3NCURSES), kernel(3NCURSES), termcap(3NCURS-
       ES), curses_variables(3NCURSES), terminfo_variables(3NCURSES), putc(3),
       terminfo(5)



                                                            terminfo(3NCURSES)
