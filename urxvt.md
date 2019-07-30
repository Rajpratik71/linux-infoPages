urxvt(1)                                                           RXVT-UNICODE                                                           urxvt(1)

NAME
       rxvt-unicode - (ouR XVT, unicode), a VT102 emulator for the X window system

SYNOPSIS
       urxvt [options] [-e command [ args ]]

DESCRIPTION
       rxvt-unicode, version 9.22, is a colour vt102 terminal emulator intended as an xterm(1) replacement for users who do not require features
       such as Tektronix 4014 emulation and toolkit-style configurability. As a result, rxvt-unicode uses much less swap space -- a significant
       advantage on a machine serving many X sessions.

       This document is also available on the World-Wide-Web at <http://pod.tst.eu/http://cvs.schmorp.de/rxvt-unicode/doc/rxvt.1.pod>.

FREQUENTLY ASKED QUESTIONS
       See urxvt(7) (try "man 7 urxvt") for a list of frequently asked questions and answer to them and some common problems. That document is
       also accessible on the World-Wide-Web at <http://pod.tst.eu/http://cvs.schmorp.de/rxvt-unicode/doc/rxvt.7.pod>.

RXVT-UNICODE VS. RXVT
       Unlike the original rxvt, rxvt-unicode stores all text in Unicode internally. That means it can store and display most scripts in the
       world. Being a terminal emulator, however, some things are very difficult, especially cursive scripts such as arabic, vertically written
       scripts like mongolian or scripts requiring extremely complex combining rules, like tibetan or devanagari. Don't expect pretty output when
       using these scripts. Most other scripts, latin, cyrillic, kanji, thai etc. should work fine, though. A somewhat difficult case are right-
       to-left scripts, such as hebrew: rxvt-unicode adopts the view that bidirectional algorithms belong in the application, not the terminal
       emulator (too many things -- such as cursor-movement while editing -- break otherwise), but that might change.

       If you are looking for a terminal that supports more exotic scripts, let me recommend "mlterm", which is a very user friendly, lean and
       clean terminal emulator. In fact, the reason rxvt-unicode was born was solely because the author couldn't get "mlterm" to use one font for
       latin1 and another for japanese.

       Therefore another design rationale was the use of multiple fonts to display characters: The idea of a single unicode font which many other
       programs force onto its users never made sense to me: You should be able to choose any font for any script freely.

       Apart from that, rxvt-unicode is also much better internationalised than its predecessor, supports things such as XFT and ISO 14755 that
       are handy in i18n-environments, is faster, and has a lot bugs less than the original rxvt. This all in addition to dozens of other small
       improvements.

       It is still faithfully following the original rxvt idea of being lean and nice on resources: for example, you can still configure rxvt-
       unicode without most of its features to get a lean binary. It also comes with a client/daemon pair that lets you open any number of
       terminal windows from within a single process, which makes startup time very fast and drastically reduces memory usage. See urxvtd(1)
       (daemon) and urxvtc(1) (client).

       It also makes technical information about escape sequences (which have been extended) more accessible: see urxvt(7) for technical reference
       documentation (escape sequences etc.).

OPTIONS
       The urxvt options (mostly a subset of xterm's) are listed below. In keeping with the smaller-is-better philosophy, options may be
       eliminated or default values chosen at compile-time, so options and defaults listed may not accurately reflect the version installed on
       your system. `urxvt -h' gives a list of major compile-time options on the Options line. Option descriptions may be prefixed with which
       compile option each is dependent upon. e.g. `Compile XIM:' requires XIM on the Options line. Note: `urxvt -help' gives a list of all
       command-line options compiled into your version.

       Note that urxvt permits the resource name to be used as a long-option (--/++ option) so the potential command-line options are far greater
       than those listed. For example: `urxvt --loginShell --color1 Orange'.

       The following options are available:

       -help, --help
           Print out a message describing available options.

       -display displayname
           Attempt to open a window on the named X display (the older form -d is still respected. but deprecated). In the absence of this option,
           the display specified by the DISPLAY environment variable is used.

       -depth bitdepth
           Compile frills: Attempt to find a visual with the given bit depth; resource depth.

           [Please note that many X servers (and libXft) are buggy with respect to "-depth 32" and/or alpha channels, and will cause all sorts of
           graphical corruption. This is harmless, but we can't do anything about this, so watch out]

       -visual visualID
           Compile frills: Use the given visual (see e.g. "xdpyinfo" for possible visual ids) instead of the default, and also allocate a private
           colormap. All visual types except for DirectColor are supported.

       -geometry geom
           Window geometry (-g still respected); resource geometry.

       -rv|+rv
           Turn on/off simulated reverse video; resource reverseVideo.

       -j|+j
           Turn on/off jump scrolling (allow multiple lines per refresh); resource jumpScroll.

       -ss|+ss
           Turn on/off skip scrolling (allow multiple screens per refresh); resource skipScroll.

       -fade number
           Fade the text by the given percentage when focus is lost. Small values fade a little only, 100 completely replaces all colours by the
           fade colour; resource fading.

       -fadecolor colour
           Fade to this colour when fading is used (see -fade). The default colour is opaque black. resource fadeColor.

       -icon file
           Compile pixbuf: Use the specified image as application icon. This is used by many window managers, taskbars and pagers to represent the
           application window; resource iconFile.

       -bg colour
           Window background colour; resource background.

       -fg colour
           Window foreground colour; resource foreground.

       -cr colour
           The cursor colour; resource cursorColor.

       -pr colour
           The mouse pointer foreground colour; resource pointerColor.

       -pr2 colour
           The mouse pointer background colour; resource pointerColor2.

       -bd colour
           The colour of the border around the text area and between the scrollbar and the text; resource borderColor.

       -fn fontlist
           Select the fonts to be used. This is a comma separated list of font names that are checked in order when trying to find glyphs for
           characters. The first font defines the cell size for characters; other fonts might be smaller, but not (in general) larger. A
           (hopefully) reasonable default font list is always appended to it. See resource font for more details.

           In short, to specify an X11 core font, just specify its name or prefix it with "x:". To specify an XFT-font, you need to prefix it with
           "xft:", e.g.:

              urxvt -fn "xft:Bitstream Vera Sans Mono:pixelsize=15"
              urxvt -fn "9x15bold,xft:Bitstream Vera Sans Mono"

           See also the question "How does rxvt-unicode choose fonts?" in the FAQ section of urxvt(7).

       -fb fontlist
           Compile font-styles: The bold font list to use when bold characters are to be printed. See resource boldFont for details.

       -fi fontlist
           Compile font-styles: The italic font list to use when italic characters are to be printed. See resource italicFont for details.

       -fbi fontlist
           Compile font-styles: The bold italic font list to use when bold italic characters are to be printed. See resource boldItalicFont for
           details.

       -is|+is
           Compile font-styles: Bold/Blink font styles imply high intensity foreground/background (default). See resource intensityStyles for
           details.

       -name name
           Specify the application name under which resources are to be obtained, rather than the default executable file name. Name should not
           contain `.' or `*' characters. Also sets the icon and title name.

       -ls|+ls
           Start as a login-shell/sub-shell; resource loginShell.

       -mc milliseconds
           Specify the maximum time between multi-click selections.

       -ut|+ut
           Compile utmp: Inhibit/enable writing a utmp entry; resource utmpInhibit.

       -vb|+vb
           Turn on/off visual bell on receipt of a bell character; resource visualBell.

       -sb|+sb
           Turn on/off scrollbar; resource scrollBar.

       -sr|+sr
           Put scrollbar on right/left; resource scrollBar_right.

       -st|+st
           Display rxvt (non XTerm/NeXT) scrollbar without/with a trough; resource scrollBar_floating.

       -si|+si
           Turn on/off scroll-to-bottom on TTY output inhibit; resource scrollTtyOutput has opposite effect.

       -sk|+sk
           Turn on/off scroll-to-bottom on keypress; resource scrollTtyKeypress.

       -sw|+sw
           Turn on/off scrolling with the scrollback buffer as new lines appear.  This only takes effect if -si is also given; resource
           scrollWithBuffer.

       -ptab|+ptab
           If enabled (default), "Horizontal Tab" characters are being stored as actual wide characters in the screen buffer, which makes it
           possible to select and paste them. Since a horizontal tab is a cursor movement and not an actual glyph, this can sometimes be visually
           annoying as the cursor on a tab character is displayed as a wide cursor; resource pastableTabs.

       -bc|+bc
           Blink the cursor; resource cursorBlink.

       -uc|+uc
           Make the cursor underlined; resource cursorUnderline.

       -iconic
           Start iconified, if the window manager supports that option.  Alternative form is -ic.

       -sl number
           Save number lines in the scrollback buffer. See resource entry for limits; resource saveLines.

       -b number
           Compile frills: Internal border of number pixels. See resource entry for limits; resource internalBorder.

       -w number
           Compile frills: External border of number pixels. Also, -bw and -borderwidth. See resource entry for limits; resource externalBorder.

       -bl Compile frills: Set MWM hints to request a borderless window, i.e.  if honoured by the WM, the rxvt-unicode window will not have window
           decorations; resource borderLess. If the window manager does not support MWM hints (e.g. kwin), enables override-redirect mode.

       -override-redirect
           Compile frills: Sets override-redirect on the window; resource override-redirect.

       -dockapp
           Sets the initial state of the window to WithdrawnState, which makes window managers that support this extension treat it as a dockapp.

       -sbg
           Compile frills: Disable the usage of the built-in block graphics/line drawing characters and just rely on what the specified fonts
           provide. Use this if you have a good font and want to use its block graphic glyphs; resource skipBuiltinGlyphs.

       -lsp number
           Compile frills: Lines (pixel height) to insert between each row of the display. Useful to work around font rendering problems; resource
           lineSpace.

       -letsp number
           Compile frills: Amount to adjust the computed character width by to control overall letter spacing. Negative values will tighten up the
           letter spacing, positive values will space letters out more. Useful to work around odd font metrics; resource letterSpace.

       -tn termname
           This option specifies the name of the terminal type to be set in the TERM environment variable. This terminal type must exist in the
           termcap(5) database and should have li# and co# entries; resource termName.

       -e command [arguments]
           Run the command with its command-line arguments in the urxvt window; also sets the window title and icon name to be the basename of the
           program being executed if neither -title (-T) nor -n are given on the command line. If this option is used, it must be the last on the
           command-line. If there is no -e option then the default is to run the program specified by the SHELL environment variable or, failing
           that, sh(1).

           Please note that you must specify a program with arguments. If you want to run shell commands, you have to specify the shell, like
           this:

             urxvt -e sh -c "shell commands"

       -title text
           Window title (-T still respected); the default title is the basename of the program specified after the -e option, if any, otherwise
           the application name; resource title.

       -n text
           Icon name; the default name is the basename of the program specified after the -e option, if any, otherwise the application name;
           resource iconName.

       -C  Capture system console messages.

       -pt style
           Compile XIM: input style for input method; OverTheSpot, OffTheSpot, Root; resource preeditType.

           If the perl extension "xim-onthespot" is used (which is the default), then additionally the "OnTheSpot" preedit type is available.

       -im text
           Compile XIM: input method name. resource inputMethod.

       -imlocale string
           The locale to use for opening the IM. You can use an "LC_CTYPE" of e.g.  "de_DE.UTF-8" for normal text processing but "ja_JP.EUC-JP"
           for the input extension to be able to input japanese characters while staying in another locale. resource imLocale.

       -imfont fontset
           Set the font set to use for the X Input Method, see resource imFont for more info.

       -tcw
           Change the meaning of triple-click selection with the left mouse button. Only effective when the original (non-perl) selection code is
           in-use. Instead of selecting a full line it will extend the selection to the end of the logical line only. resource tripleclickwords.

       -insecure
           Enable "insecure" mode, which currently enables most of the escape sequences that echo strings. See the resource insecure for more
           info.

       -mod modifier
           Override detection of Meta modifier with specified key: alt, meta, hyper, super, mod1, mod2, mod3, mod4, mod5; resource modifier.

       -ssc|+ssc
           Turn on/off secondary screen (default enabled); resource secondaryScreen.

       -ssr|+ssr
           Turn on/off secondary screen scroll (default enabled); resource secondaryScroll.

       -hold|+hold
           Turn on/off hold window after exit support. If enabled, urxvt will not immediately destroy its window when the program executed within
           it exits. Instead, it will wait till it is being killed or closed by the user; resource hold.

       -cd path
           Sets the working directory for the shell (or the command specified via -e). The path must be an absolute path and it must exist for
           urxvt to start; resource chdir.

       -xrm string
           Works like the X Toolkit option of the same name, by adding the string as if it were specified in a resource file. Resource values
           specified this way take precedence over all other resource specifications.

           Note that you need to use the same syntax as in the .Xdefaults file, e.g. "*.background: black". Also note that all urxvt-specific
           options can be specified as long-options on the commandline, so use of -xrm is mostly limited to cases where you want to specify other
           resources (e.g. for input methods) or for compatibility with other programs.

       -keysym.sym string
           Remap a key symbol. See resource keysym.

       -embed windowid
           Tells urxvt to embed its windows into an already-existing window, which enables applications to easily embed a terminal.

           Right now, urxvt will first unmap/map the specified window, so it shouldn't be a top-level window. urxvt will also reconfigure it quite
           a bit, so don't expect it to keep some specific state. It's best to create an extra subwindow for urxvt and leave it alone.

           The window will not be destroyed when urxvt exits.

           It might be useful to know that urxvt will not close file descriptors passed to it (except for stdin/out/err, of course), so you can
           use file descriptors to communicate with the programs within the terminal. This works regardless of whether the "-embed" option was
           used or not.

           Here is a short Gtk2-perl snippet that illustrates how this option can be used (a longer example is in doc/embed):

              my $rxvt = new Gtk2::Socket;
              $rxvt->signal_connect_after (realize => sub {
                 my $xid = $_[0]->window->get_xid;
                 system "urxvt -embed $xid &";
              });

       -pty-fd file descriptor
           Tells urxvt NOT to execute any commands or create a new pty/tty pair but instead use the given file descriptor as the tty master. This
           is useful if you want to drive urxvt as a generic terminal emulator without having to run a program within it.

           If this switch is given, urxvt will not create any utmp/wtmp entries and will not tinker with pty/tty permissions - you have to do that
           yourself if you want that.

           As an extremely special case, specifying "-1" will completely suppress pty/tty operations, which is probably only useful in conjunction
           with some perl extension that manages the terminal.

           Here is a example in perl that illustrates how this option can be used (a longer example is in doc/pty-fd):

              use IO::Pty;
              use Fcntl;

              my $pty = new IO::Pty;
              fcntl $pty, F_SETFD, 0; # clear close-on-exec
              system "urxvt -pty-fd " . (fileno $pty) . "&";
              close $pty;

              # now communicate with rxvt
              my $slave = $pty->slave;
              while (<$slave>) { print $slave "got <$_>\n" }

       -pe string
           Comma-separated list of perl extension scripts to use (or not to use) in this terminal instance. See resource perl-ext for details.

RESOURCES
       Note: `urxvt --help' gives a list of all resources (long options) compiled into your version. All resources are also available as long-
       options.

       You can set and change the resources using X11 tools like xrdb. Many distribution do also load settings from the ~/.Xresources file when X
       starts. urxvt will consult the following files/resources in order, with later settings overwriting earlier ones:

         1. app-defaults file in $XAPPLRESDIR
         2. $HOME/.Xdefaults
         3. RESOURCE_MANAGER property on root-window of screen 0
         4. SCREEN_RESOURCES property on root-window of the current screen
         5. $XENVIRONMENT file OR $HOME/.Xdefaults-<nodename>
         6. resources specified via -xrm on the commandline

       Note that when reading X resources, urxvt recognizes two class names: Rxvt and URxvt. The class name Rxvt allows resources common to both
       urxvt and the original rxvt to be easily configured, while the class name URxvt allows resources unique to urxvt, to be shared between
       different urxvt configurations. If no resources are specified, suitable defaults will be used. Command-line arguments can be used to
       override resource settings. The following resources are supported (you might want to check the urxvtperl(3) manpage for additional settings
       by perl extensions not documented here):

       depth: bitdepth
           Compile xft: Attempt to find a visual with the given bit depth; option -depth.

       buffered: boolean
           Compile xft: Turn on/off double-buffering for xft (default enabled).  On some card/driver combination enabling it slightly decreases
           performance, on most it greatly helps it. The slowdown is small, so it should normally be enabled.

       geometry: geom
           Create the window with the specified X window geometry [default 80x24]; option -geometry.

       background: colour
           Use the specified colour as the window's background colour [default White]; option -bg.

       foreground: colour
           Use the specified colour as the window's foreground colour [default Black]; option -fg.

       colorn: colour
           Use the specified colour for the colour value n, where 0-7 corresponds to low-intensity (normal) colours and 8-15 corresponds to high-
           intensity (bold = bright foreground, blink = bright background) colours. The canonical names are as follows: 0=black, 1=red, 2=green,
           3=yellow, 4=blue, 5=magenta, 6=cyan, 7=white, but the actual colour names used are listed in the COLOURS AND GRAPHICS section.

           Colours higher than 15 cannot be set using resources (yet), but can be changed using an escape command (see urxvt(7)).

           Colours 16-79 form a standard 4x4x4 colour cube (the same as xterm with 88 colour support). Colours 80-87 are evenly spaces grey steps.

       colorBD: colour
       colorIT: colour
           Use the specified colour to display bold or italic characters when the foreground colour is the default. If font styles are not
           available (Compile styles) and this option is unset, reverse video is used instead.

       colorUL: colour
           Use the specified colour to display underlined characters when the foreground colour is the default.

       underlineColor: colour
           If set, use the specified colour as the colour for the underline itself. If unset, use the foreground colour.

       highlightColor: colour
           If set, use the specified colour as the background for highlighted characters. If unset, use reverse video.

       highlightTextColor: colour
           If set and highlightColor is set, use the specified colour as the foreground for highlighted characters.

       cursorColor: colour
           Use the specified colour for the cursor. The default is to use the foreground colour; option -cr.

       cursorColor2: colour
           Use the specified colour for the colour of the cursor text. For this to take effect, cursorColor must also be specified. The default is
           to use the background colour.

       reverseVideo: boolean
           True: simulate reverse video by foreground and background colours; option -rv. False: regular screen colours [default]; option +rv. See
           note in COLOURS AND GRAPHICS section.

       jumpScroll: boolean
           True: specify that jump scrolling should be used. When receiving lots of lines, urxvt will only scroll once a whole screen height of
           lines has been read, resulting in fewer updates while still displaying every received line; option -j.

           False: specify that smooth scrolling should be used. urxvt will force a screen refresh on each new line it received; option +j.

       skipScroll: boolean
           True: (the default) specify that skip scrolling should be used. When receiving lots of lines, urxvt will only scroll once in a while
           (around 60 times per second), resulting in far fewer updates. This can result in urxvt not ever displaying some of the lines it
           receives; option -ss.

           False: specify that everything is to be displayed, even if the refresh is too fast for the human eye to read anything (or the monitor
           to display anything); option +ss.

       fading: number
           Fade the text by the given percentage when focus is lost; option -fade.

       fadeColor: colour
           Fade to this colour, when fading is used (see fading:). The default colour is black; option -fadecolor.

       iconFile: file
           Set the application icon pixmap; option -icon.

       scrollColor: colour
           Use the specified colour for the scrollbar [default #B2B2B2].

       troughColor: colour
           Use the specified colour for the scrollbar's trough area [default #969696]. Only relevant for rxvt (non XTerm/NeXT) scrollbar.

       borderColor: colour
           The colour of the border around the text area and between the scrollbar and the text.

       font: fontlist
           Select the fonts to be used. This is a comma separated list of font names that are checked in order when trying to find glyphs for
           characters. The first font defines the cell size for characters; other fonts might be smaller, but not (in general) larger. A
           (hopefully) reasonable default font list is always appended to it; option -fn.

           Each font can either be a standard X11 core font (XLFD) name, with optional prefix "x:" or a Xft font (Compile xft), prefixed with
           "xft:".

           In addition, each font can be prefixed with additional hints and specifications enclosed in square brackets ("[]"). The only available
           hint currently is "codeset=codeset-name", and this is only used for Xft fonts.

           For example, this font resource

              URxvt.font: 9x15bold,\
                          -misc-fixed-bold-r-normal--15-140-75-75-c-90-iso10646-1,\
                          -misc-fixed-medium-r-normal--15-140-75-75-c-90-iso10646-1, \
                          [codeset=JISX0208]xft:Kochi Gothic:antialias=false, \
                          xft:Code2000:antialias=false

           specifies five fonts to be used. The first one is "9x15bold" (actually the iso8859-1 version of the second font), which is the base
           font (because it is named first) and thus defines the character cell grid to be 9 pixels wide and 15 pixels high.

           The second font is just used to add additional unicode characters not in the base font, likewise the third, which is unfortunately non-
           bold, but the bold version of the font does contain fewer characters, so this is a useful supplement.

           The third font is an Xft font with aliasing turned off, and the characters are limited to the JIS 0208 codeset (i.e. japanese kanji).
           The font contains other characters, but we are not interested in them.

           The last font is a useful catch-all font that supplies most of the remaining unicode characters.

       boldFont: fontlist
       italicFont: fontlist
       boldItalicFont: fontlist
           The font list to use for displaying bold, italic or bold italic characters, respectively.

           If specified and non-empty, then the syntax is the same as for the font-resource, and the given font list will be used as is, which
           makes it possible to substitute completely different font styles for bold and italic.

           If unset (the default), a suitable font list will be synthesized by "morphing" the normal text font list into the desired shape. If
           that is not possible, replacement fonts of the desired shape will be tried.

           If set, but empty, then this specific style is disabled and the normal text font will being used for the given style.

       intensityStyles: boolean
           When font styles are not enabled, or this option is enabled (True, option -is, the default), bold/blink font styles imply high
           intensity foreground/background colours. Disabling this option (False, option +is) disables this behaviour, the high intensity colours
           are not reachable.

       title: string
           Set window title string, the default title is the command-line specified after the -e option, if any, otherwise the application name;
           option -title.

       iconName: string
           Set the name used to label the window's icon or displayed in an icon manager window, it also sets the window's title unless it is
           explicitly set; option -n.

       mapAlert: boolean
           True: de-iconify (map) on receipt of a bell character. False: no de-iconify (map) on receipt of a bell character [default].

       urgentOnBell: boolean
           True: set the urgency hint for the wm on receipt of a bell character.  False: do not set the urgency hint [default].

           urxvt resets the urgency hint on every focus change.

       visualBell: boolean
           True: use visual bell on receipt of a bell character; option -vb.  False: no visual bell [default]; option +vb.

       loginShell: boolean
           True: start as a login shell by prepending a `-' to argv[0] of the shell; option -ls. False: start as a normal sub-shell [default];
           option +ls.

       multiClickTime: number
           Specify the maximum time in milliseconds between multi-click select events. The default is 500 milliseconds; option -mc.

       utmpInhibit: boolean
           True: inhibit writing record into the system log file utmp; option -ut. False: write record into the system log file utmp [default];
           option +ut.

       print-pipe: string
           Specify a command pipe for vt100 printer [default lpr(1)]. Use Print to initiate a screen dump to the printer and Ctrl-Print or Shift-
           Print to include the scrollback as well.

           The string will be interpreted as if typed into the shell as-is.

           Example:

              URxvt.print-pipe: cat > $(TMPDIR=$HOME mktemp urxvt.XXXXXX)

           This creates a new file in your home directory with the screen contents every time you hit "Print".

       scrollstyle: mode
           Set scrollbar style to rxvt, plain, next or xterm. plain is the author's favourite.

       thickness: number
           Set the scrollbar width in pixels.

       scrollBar: boolean
           True: enable the scrollbar [default]; option -sb. False: disable the scrollbar; option +sb.

       scrollBar_right: boolean
           True: place the scrollbar on the right of the window; option -sr.  False: place the scrollbar on the left of the window; option +sr.

       scrollBar_floating: boolean
           True: display an rxvt scrollbar without a trough; option -st.  False: display an rxvt scrollbar with a trough; option +st.

       scrollBar_align: mode
           Align the top, bottom or centre [default] of the scrollbar thumb with the pointer on middle button press/drag.

       scrollTtyOutput: boolean
           True: scroll to bottom when tty receives output; option -si.  False: do not scroll to bottom when tty receives output; option +si.

       scrollWithBuffer: boolean
           True: scroll with scrollback buffer when tty receives new lines (i.e.  try to show the same lines) and scrollTtyOutput is False; option
           -sw. False: do not scroll with scrollback buffer when tty receives new lines; option +sw.

       scrollTtyKeypress: boolean
           True: scroll to bottom when a non-special key is pressed. Special keys are those which are intercepted by rxvt-unicode for special
           handling and are not passed onto the shell; option -sk. False: do not scroll to bottom when a non-special key is pressed; option +sk.

       saveLines: number
           Save number lines in the scrollback buffer [default 1000]; option -sl.

       internalBorder: number
           Internal border of number pixels. This resource is limited to 100; option -b.

       externalBorder: number
           External border of number pixels. This resource is limited to 100; option -w, -bw, -borderwidth.

       borderLess: boolean
           Set MWM hints to request a borderless window, i.e. if honoured by the WM, the rxvt-unicode window will not have window decorations;
           option -bl.

       skipBuiltinGlyphs: boolean
           Compile frills: Disable the usage of the built-in block graphics/line drawing characters and just rely on what the specified fonts
           provide. Use this if you have a good font and want to use its block graphic glyphs; option -sbg.

       termName: termname
           Specifies the terminal type name to be set in the TERM environment variable; option -tn.

       lineSpace: number
           Specifies number of lines (pixel height) to insert between each row of the display [default 0]; option -lsp.

       meta8: boolean
           True: handle Meta (Alt) + keypress to set the 8th bit. False: handle Meta (Alt) + keypress as an escape prefix [default].

       mouseWheelScrollPage: boolean
           True: the mouse wheel scrolls a page full. False: the mouse wheel scrolls five lines [default].

       pastableTabs: boolean
           True: store tabs as wide characters. False: interpret tabs as cursor movement only; option "-ptab".

       cursorBlink: boolean
           True: blink the cursor. False: do not blink the cursor [default]; option -bc.

       cursorUnderline: boolean
           True: Make the cursor underlined. False: Make the cursor a box [default]; option -uc.

       pointerBlank: boolean
           True: blank the pointer when a key is pressed or after a set number of seconds of inactivity. False: the pointer is always visible
           [default].

       pointerColor: colour
           Mouse pointer foreground colour.

       pointerColor2: colour
           Mouse pointer background colour.

       pointerShape: string
           Compile frills: Specifies the name of the mouse pointer shape [default xterm]. See the macros in the X11/cursorfont.h include file for
           possible values (omit the "XC_" prefix).

       pointerBlankDelay: number
           Specifies number of seconds before blanking the pointer [default 2]. Use a large number (e.g. 987654321) to effectively disable the
           timeout.

       backspacekey: string
           The string to send when the backspace key is pressed. If set to DEC or unset it will send Delete (code 127) or, with control, Backspace
           (code 8) - which can be reversed with the appropriate DEC private mode escape sequence.

       deletekey: string
           The string to send when the delete key (not the keypad delete key) is pressed. If unset it will send the sequence traditionally
           associated with the Execute key.

       cutchars: string
           The characters used as delimiters for double-click word selection (whitespace delimiting is added automatically if resource is given).

           When the perl selection extension is in use (the default if compiled in, see the urxvtperl(3) manpage), a suitable regex using these
           characters will be created (if the resource exists, otherwise, no regex will be created). In this mode, characters outside ISO-8859-1
           can be used.

           When the selection extension is not used, only ISO-8859-1 characters can be used. If not specified, the built-in default is used:

           BACKSLASH `"'&()*,;<=>?@[]^{|}

       preeditType: style
           OnTheSpot, OverTheSpot, OffTheSpot, Root; option -pt.

       inputMethod: name
           name of inputMethod to use; option -im.

       imLocale: name
           The locale to use for opening the IM. You can use an "LC_CTYPE" of e.g.  "de_DE.UTF-8" for normal text processing but "ja_JP.EUC-JP"
           for the input extension to be able to input japanese characters while staying in another locale; option -imlocale.

       imFont: fontset
           Specify the font-set used for XIM styles "OverTheSpot" or "OffTheSpot". It must be a standard X font set (XLFD patterns separated by
           commas), i.e. it's not in the same format as the other font lists used in urxvt. The default will be set-up to chose *any* suitable
           found found, preferably one or two pixels differing in size to the base font.  option -imfont.

       tripleclickwords: boolean
           Change the meaning of triple-click selection with the left mouse button. Instead of selecting a full line it will extend the selection
           to the end of the logical line only; option -tcw.

       insecure: boolean
           Enables "insecure" mode. Rxvt-unicode offers some escape sequences that echo arbitrary strings like the icon name or the locale. This
           could be abused if somebody gets 8-bit-clean access to your display, whether through a mail client displaying mail bodies unfiltered or
           through write(1) or any other means. Therefore, these sequences are disabled by default. (Note that many other terminals, including
           xterm, have these sequences enabled by default, which doesn't make it safer, though).

           You can enable them by setting this boolean resource or specifying -insecure as an option. At the moment, this enables display-answer,
           locale, findfont, icon label and window title requests.

       modifier: modifier
           Set the key to be interpreted as the Meta key to: alt, meta, hyper, super, mod1, mod2, mod3, mod4, mod5; option -mod.

       answerbackString: string
           Specify the reply rxvt-unicode sends to the shell when an ENQ (control-E) character is passed through. It may contain escape values as
           described in the entry on keysym following.

       secondaryScreen: boolean
           Turn on/off secondary screen (default enabled).

       secondaryScroll: boolean
           Turn on/off secondary screen scroll (default enabled). If this option is enabled, scrolls on the secondary screen will change the
           scrollback buffer and, when secondaryScreen is off, switching to/from the secondary screen will instead scroll the screen up.

       hold: boolean
           Turn on/off hold window after exit support. If enabled, urxvt will not immediately destroy its window when the program executed within
           it exits. Instead, it will wait till it is being killed or closed by the user.

       chdir: path
           Sets the working directory for the shell (or the command specified via -e). The path must be an absolute path and it must exist for
           urxvt to start. If it isn't specified then the current working directory will be used; option -cd.

       keysym.sym: action
           Compile frills: Associate action with keysym sym. The intervening resource name keysym. cannot be omitted.

           Using this resource, you can map key combinations such as "Ctrl-Shift-BackSpace" to various actions, such as outputting a different
           string than would normally result from that combination, making the terminal scroll up or down the way you want it, or any other thing
           an extension might provide.

           The key combination that triggers the action, sym, has the following format:

              (modifiers-)key

           Where modifiers can be any combination of ISOLevel3, AppKeypad, Control, NumLock, Shift, Meta, Lock, Mod1, Mod2, Mod3, Mod4, Mod5, and
           the abbreviated I, K, C, N, S, M, A, L, 1, 2, 3, 4, 5.

           The NumLock, Meta and ISOLevel3 modifiers are usually aliased to whatever modifier the NumLock key, Meta/Alt keys or ISO Level3
           Shift/AltGr keys are being mapped. AppKeypad is a synthetic modifier mapped to the current application keymap mode state.

           Due the the large number of modifier combinations, a key mapping will match if at least the specified identifiers are being set, and no
           other key mappings with those and more bits are being defined. That means that defining a mapping for "a" will automatically provide
           definitions for "Meta-a", "Shift-a" and so on, unless some of those are defined mappings themselves. See the "builtin:" action, below,
           for a way to work around this when this is a problem.

           The spelling of key depends on your implementation of X. An easy way to find a key name is to use the xev(1) command. You can find a
           list by looking for the "XK_" macros in the X11/keysymdef.h include file (omit the "XK_" prefix). Alternatively you can specify key by
           its hex keysym value (0x0000 - 0xFFFF).

           As with any resource value, the action string may contain backslash escape sequences ("\n": newline, "\\": backslash, "\000": octal
           number), see RESOURCES in "man 7 X" for further details.

           An action starts with an action prefix that selects a certain type of action, followed by a colon. An action string without colons is
           interpreted as a literal string to pass to the tty (as if it was prefixed with "string:").

           The following action prefixes are known - extensions can provide additional prefixes:

           string:STRING
               If the action starts with "string:" (or otherwise contains no colons), then the remaining "STRING" will be passed to the program
               running in the terminal. For example, you could replace whatever Shift-Tab outputs by the string "echo rm -rf /" followed by a
               newline:

                  URxvt.keysym.Shift-Tab: string:echo rm -rf /\n

               This could in theory be used to completely redefine your keymap.

               In addition, for actions of this type, you can define a range of keysyms in one shot by loading the "keysym-list" perl extension
               and providing an action with pattern list/PREFIX/MIDDLE/SUFFIX, where the delimiter `/' should be a character not used by the
               strings.

               Its usage can be demonstrated by an example:

                 URxvt.keysym.M-C-0x61:    list|\033<|abc|>

               The above line is equivalent to the following three lines:

                 URxvt.keysym.Meta-Control-0x61:    string:\033<a>
                 URxvt.keysym.Meta-Control-0x62:    string:\033<b>
                 URxvt.keysym.Meta-Control-0x63:    string:\033<c>

           command:STRING
               If action takes the form of "command:STRING", the specified STRING is interpreted and executed as urxvt's control sequence
               (basically the opposite of "string:" - instead of sending it to the program running in the terminal, it will be treated as if it
               were program output). This is most useful to feed command sequences into urxvt.

               For example the following means "change the current locale to "zh_CN.GBK" when Control-Meta-c is being pressed":

                 URxvt.keysym.M-C-c: command:\033]701;zh_CN.GBK\007

               The following example will map Control-Meta-1 and Control-Meta-2 to the fonts "suxuseuro" and "9x15bold", so you can have some
               limited font-switching at runtime:

                 URxvt.keysym.M-C-1: command:\033]50;suxuseuro\007
                 URxvt.keysym.M-C-2: command:\033]50;9x15bold\007

               Other things are possible, e.g. resizing (see urxvt(7) for more info):

                 URxvt.keysym.M-C-3: command:\033[8;25;80t
                 URxvt.keysym.M-C-4: command:\033[8;48;110t

           builtin:
               The builtin action is the action that urxvt would execute if no key binding existed for the key combination. The obvious use is to
               undo the effect of existing bindings. The not so obvious use is to reinstate bindings when another binding overrides too many
               modifiers.

               For example if you overwrite the "Insert" key you will disable urxvt's "Shift-Insert" mapping. To re-enable that, you can poke
               "holes" into the user-defined keymap using the "builtin:" replacement:

                 URxvt.keysym.Insert: <my insert key sequence>
                 URxvt.keysym.S-Insert: builtin:

               The first line defines a mapping for "Insert" and any combination of modifiers. The second line re-establishes the default mapping
               for "Shift-Insert".

           builtin-string:
               This action is mainly useful to restore string mappings for keys that have predefined actions in urxvt. The exact semantics are a
               bit difficult to explain - basically, this action will send the string to the application that would be sent if urxvt wouldn't have
               a built-in action for it.

               An example might make it clearer: urxvt normally pastes the selection when you press "Shift-Insert". With the following bindings,
               it would instead emit the (undocumented, but what applications running in the terminal might expect) sequence "ESC [ 2 $" instead:

                  URxvt.keysym.S-Insert: builtin-string:
                  URxvt.keysym.C-S-Insert: builtin:

               The first line disables the paste functionality for that key combination, and the second reinstates the default behaviour for
               "Control-Shift-Insert", which would otherwise be overridden.

               Similarly, to let applications gain access to the "C-M-c" (copy to clipboard) and "C-M-v" (paste clipboard) key combination, you
               can do this:

                  URxvt.keysym.C-M-c: builtin-string:
                  URxvt.keysym.C-M-v: builtin-string:

           EXTENSION:STRING
               An action of this form invokes the action STRING, if any, provided by the urxvtperl(3) extension EXTENSION. The extension will be
               loaded automatically if necessary.

               Not all extensions define actions, but popular extensions that do include the selection and matcher extensions (documented in their
               own manpages, urxvt-selection(1) and urxvt-matcher(1), respectively).

               From the silly examples department, this will rot13-"encrypt" urxvt's selection when Alt-Control-c is pressed on typical PC
               keyboards:

                 URxvt.keysym.M-C-c: selection:rot13

           perl:STRING *DEPRECATED*
               This is a deprecated way of invoking commands provided by perl extensions. It is still supported, but should not be used anymore.

       perl-ext-common: string
       perl-ext: string
           Comma-separated list(s) of perl extension scripts (default: "default") to use in this terminal instance; option -pe.

           Extension names can be prefixed with a "-" sign to prohibit using them. This can be useful to selectively disable some extensions
           loaded by default, or specified via the "perl-ext-common" resource. For example, "default,-selection" will use all the default
           extensions except "selection".

           The default set includes the "selection", "option-popup", "selection-popup", "readline" and "searchable-scrollback" extensions, and
           extensions which are mentioned in keysym resources.

           Any extension such that a corresponding resource is given on the command line is automatically appended to perl-ext.

           Each extension is looked up in the library directories, loaded if necessary, and bound to the current terminal instance. When the
           library search path contains multiple extension files of the same name, then the first one found will be used.

           If both of these resources are the empty string, then the perl interpreter will not be initialized. The rationale for having two
           options is that perl-ext-common will be used for extensions that should be available to all instances, while perl-ext is used for
           specific instances.

       perl-eval: string
           Perl code to be evaluated when all extensions have been registered. See the urxvtperl(3) manpage.

       perl-lib: path
           Colon-separated list of additional directories that hold extension scripts. When looking for perl extensions, urxvt will first look in
           these directories, then in $URXVT_PERL_LIB, $HOME/.urxvt/ext and lastly in /usr/lib/urxvt/perl/.

           See the urxvtperl(3) manpage.

       selection.pattern-idx: perl-regex
           Additional selection patterns, see the urxvtperl(3) manpage for details.

       selection-autotransform.idx: perl-transform
           Selection auto-transform patterns, see the urxvtperl(3) manpage for details.

       searchable-scrollback: keysym *DEPRECATED*
           This resource is deprecated and will be removed. Use a keysym resource instead, e.g.:

              URxvt.keysym.M-s: searchable-scrollback:start

       url-launcher: string
           Specifies the program to be started with a URL argument. Used by the "selection-popup" and "matcher" perl extensions.

       transient-for: windowid
           Compile frills: Sets the WM_TRANSIENT_FOR property to the given window id.

       override-redirect: boolean
           Compile frills: Sets override-redirect for the terminal window, making it almost invisible to window managers; option
           -override-redirect.

       iso14755: boolean
           Turn on/off ISO 14755 (default enabled).

       iso14755_52: boolean
           Turn on/off ISO 14755 5.2 mode (default enabled).

BACKGROUND IMAGE OPTIONS AND RESOURCES
       -pixmap file[;oplist]
       backgroundPixmap: file[;oplist]
           Compile pixbuf: Use the specified image file as the window's background and also optionally specify a colon separated list of
           operations to modify it. Note that you may need to quote the ";" character when using the command line option, as ";" is usually a
           metacharacter in shells. Supported operations are:

           WxH+X+Y
               sets scale and position. "W" / "H" specify the horizontal/vertical scale (percent), and "X" / "Y" locate the image centre
               (percent). A scale of 0 disables scaling.

           op=tile
               enables tiling

           op=keep-aspect
               maintain the image aspect ratio when scaling

           op=root-align
               use the position of the terminal window relative to the root window as the image offset, simulating a root window background

           The default scale and position setting is "100x100+50+50".  Alternatively, a predefined set of templates can be used to achieve the
           most common setups:

           style=tiled
               the image is tiled with no scaling. Equivalent to 0x0+0+0:op=tile

           style=aspect-stretched
               the image is scaled to fill the whole window maintaining the aspect ratio and centered. Equivalent to 100x100+50+50:op=keep-aspect

           style=stretched
               the image is scaled to fill the whole window. Equivalent to 100x100

           style=centered
               the image is centered with no scaling. Equivalent to 0x0+50+50

           style=root-tiled
               the image is tiled with no scaling and using 'root' positioning.  Equivalent to 0x0:op=tile:op=root-align

           If multiple templates are specified the last one wins. Note that a template overrides all the scale, position and operations settings.

           If used in conjunction with pseudo-transparency, the specified pixmap will be blended over the transparent background using alpha-
           blending.

       -tr|+tr
       transparent: boolean
           Turn on/off pseudo-transparency by using the root pixmap as background.

           -ip (inheritPixmap) is still accepted as an obsolete alias but will be removed in future versions.

       -tint colour
       tintColor: colour
           Tint the transparent background with the given colour. Note that a black tint yields a completely black image while a white tint yields
           the image unchanged.

       -sh number
       shading: number
           Darken (0 .. 99) or lighten (101 .. 200) the transparent background.  A value of 100 means no shading.

       -blr HxV
       blurRadius: HxV
           Apply gaussian blur with the specified radius to the transparent background. If a single number is specified, the vertical and
           horizontal radii are considered to be the same. Setting one of the radii to 1 and the other to a large number creates interesting
           effects on some backgrounds. The maximum radius value is 128. An horizontal or vertical radius of 0 disables blurring.

       path: path
           Specify the colon-delimited search path for finding background image files.

THE SCROLLBAR
       Lines of text that scroll off the top of the urxvt window (resource: saveLines) and can be scrolled back using the scrollbar or by
       keystrokes. The normal urxvt scrollbar has arrows and its behaviour is fairly intuitive. The xterm-scrollbar is without arrows and its
       behaviour mimics that of xterm

       Scroll down with Button1 (xterm-scrollbar) or Shift-Next.  Scroll up with Button3 (xterm-scrollbar) or Shift-Prior.  Continuous scroll with
       Button2.

MOUSE REPORTING
       To temporarily override mouse reporting, for either the scrollbar or the normal text selection/insertion, hold either the Shift or the Meta
       (Alt) key while performing the desired mouse action.

       If mouse reporting mode is active, the normal scrollbar actions are disabled -- on the assumption that we are using a fullscreen
       application. Instead, pressing Button1 and Button3 sends ESC [ 6 ~ (Next) and ESC [ 5 ~ (Prior), respectively. Similarly, clicking on the
       up and down arrows sends ESC [ A (Up) and ESC [ B (Down), respectively.

THE SELECTION: SELECTING AND PASTING TEXT
       The behaviour of text selection and insertion/pasting mechanism is similar to xterm(1).

       Selecting:
           Left click at the beginning of the region, drag to the end of the region and release; Right click to extend the marked region; Left
           double-click to select a word; Left triple-click to select the entire logical line (which can span multiple screen lines), unless
           modified by resource tripleclickwords.

           Starting a selection while pressing the Meta key (or Meta+Ctrl keys) (Compile: frills) will create a rectangular selection instead of a
           normal one. In this mode, every selected row becomes its own line in the selection, and trailing whitespace is visually underlined and
           removed from the selection.

       Pasting:
           Pressing and releasing the Middle mouse button in an urxvt window causes the value of the PRIMARY selection (or CLIPBOARD with the Meta
           modifier) to be inserted as if it had been typed on the keyboard.

           Pressing Shift-Insert causes the value of the PRIMARY selection to be inserted too.

           rxvt-unicode also provides the bindings Ctrl-Meta-c and <Ctrl-Meta-v> to interact with the CLIPBOARD selection. The first binding
           causes the value of the internal selection to be copied to the CLIPBOARD selection, while the second binding causes the value of the
           CLIPBOARD selection to be inserted.

CHANGING FONTS
       Changing fonts (or font sizes, respectively) via the keypad is not yet supported in rxvt-unicode. Bug me if you need this.

       You can, however, switch fonts at runtime using escape sequences, e.g.:

          printf '\e]710;%s\007' "9x15bold,xft:Kochi Gothic"

       You can use keyboard shortcuts, too:

          URxvt.keysym.M-C-1: command:\033]710;suxuseuro\007\033]711;suxuseuro\007
          URxvt.keysym.M-C-2: command:\033]710;9x15bold\007\033]711;9x15bold\007

       rxvt-unicode will automatically re-apply these fonts to the output so far.

ISO 14755 SUPPORT
       ISO 14755 is a standard for entering and viewing unicode characters and character codes using the keyboard. It consists of 4 parts. The
       first part is available if rxvt-unicode has been compiled with "--enable-frills", the rest is available when rxvt-unicode was compiled with
       "--enable-iso14755".

       ·   5.1: Basic method

           This allows you to enter unicode characters using their hexcode.

           Start by pressing and holding both "Control" and "Shift", then enter hex-digits (between one and six). Releasing "Control" and "Shift"
           will commit the character as if it were typed directly. While holding down "Control" and "Shift" you can also enter multiple characters
           by pressing "Space", which will commit the current character and lets you start a new one.

           As an example of use, imagine a business card with a japanese e-mail address, which you cannot type. Fortunately, the card has the
           e-mail address printed as hexcodes, e.g. "671d 65e5". You can enter this easily by pressing "Control" and "Shift", followed by
           "6-7-1-D-SPACE-6-5-E-5", followed by releasing the modifier keys.

       ·   5.2: Keyboard symbols entry method

           This mode lets you input characters representing the keycap symbols of your keyboard, if representable in the current locale encoding.

           Start by pressing "Control" and "Shift" together, then releasing them. The next special key (cursor keys, home etc.) you enter will not
           invoke its usual function but instead will insert the corresponding keycap symbol. The symbol will only be entered when the key has
           been released, otherwise pressing e.g. "Shift" would enter the symbol for "ISO Level 2 Switch", although your intention might have been
           to enter a reverse tab (Shift-Tab).

       ·   5.3: Screen-selection entry method

           While this is implemented already (it's basically the selection mechanism), it could be extended by displaying a unicode character map.

       ·   5.4: Feedback method for identifying displayed characters for later input

           This method lets you display the unicode character code associated with characters already displayed.

           You enter this mode by holding down "Control" and "Shift" together, then pressing and holding the left mouse button and moving around.
           The unicode hex code(s) (it might be a combining character) of the character under the pointer is displayed until you release "Control"
           and "Shift".

           In addition to the hex codes it will display the font used to draw this character - due to implementation reasons, characters combined
           with combining characters, line drawing characters and unknown characters will always be drawn using the built-in support font.

       With respect to conformance, rxvt-unicode is supposed to be compliant to both scenario A and B of ISO 14755, including part 5.2.

LOGIN STAMP
       urxvt tries to write an entry into the utmp(5) file so that it can be seen via the who(1) command, and can accept messages.  To allow this
       feature, urxvt may need to be installed setuid root on some systems or setgid to root or to some other group on others.

COLOURS AND GRAPHICS
       In addition to the default foreground and background colours, urxvt can display up to 88/256 colours: 8 ANSI colours plus high-intensity
       (potentially bold/blink) versions of the same, and 72 (or 240 in 256 colour mode) colours arranged in an 4x4x4 (or 6x6x6) colour RGB cube
       plus a 8 (24) colour greyscale ramp.

       Here is a list of the ANSI colours with their names.

       color0       (black)            = Black
       color1       (red)              = Red3
       color2       (green)            = Green3
       color3       (yellow)           = Yellow3
       color4       (blue)             = Blue3
       color5       (magenta)          = Magenta3
       color6       (cyan)             = Cyan3
       color7       (white)            = AntiqueWhite
       color8       (bright black)     = Grey25
       color9       (bright red)       = Red
       color10      (bright green)     = Green
       color11      (bright yellow)    = Yellow
       color12      (bright blue)      = Blue
       color13      (bright magenta)   = Magenta
       color14      (bright cyan)      = Cyan
       color15      (bright white)     = White
       foreground                      = Black
       background                      = White

       It is also possible to specify the colour values of foreground, background, cursorColor, cursorColor2, colorBD, colorUL as a number 0-15,
       as a convenient shorthand to reference the colour name of color0-color15.

       The following text gives values for the standard 88 colour mode (and values for the 256 colour mode in parentheses).

       The RGB cube uses indices 16..79 (16..231) using the following formulas:

          index_88  = (r * 4 + g) * 4 + b + 16   # r, g, b = 0..3
          index_256 = (r * 6 + g) * 6 + b + 16   # r, g, b = 0..5

       The grayscale ramp uses indices 80..87 (232..239), from 10% to 90% in 10% steps (1/26 to 25/26 in 1/26 steps) - black and white are already
       part of the RGB cube.

       Together, all those colours implement the 88 (256) colour xterm colours. Only the first 16 can be changed using resources currently, the
       rest can only be changed via command sequences ("escape codes").

       Applications are advised to use terminfo or command sequences to discover number and RGB values of all colours (yes, you can query
       this...).

       Note that -rv ("reverseVideo: True") simulates reverse video by always swapping the foreground/background colours. This is in contrast to
       xterm(1) where the colours are only swapped if they have not otherwise been specified. For example,

          urxvt -fg Black -bg White -rv

       would yield White on Black, while on xterm(1) it would yield Black on White.

   ALPHA CHANNEL SUPPORT
       If Xft support has been compiled in and as long as Xft/Xrender/X don't get their act together, rxvt-unicode will do its own alpha channel
       management:

       You can prefix any colour with an opaqueness percentage enclosed in brackets, i.e. "[percent]", where "percent" is a decimal percentage
       (0-100) that specifies the opacity of the colour, where 0 is completely transparent and 100 is completely opaque. For example, "[50]red" is
       a half-transparent red, while "[95]#00ff00" is an almost opaque green. This is the recommended format to specify transparency values, and
       works with all ways to specify a colour.

       For complete control, rxvt-unicode also supports "rgba:rrrr/gggg/bbbb/aaaa" (exactly four hex digits/component) colour specifications,
       where the additional "aaaa" component specifies opacity (alpha) values. The minimum value of 0000 is completely transparent, while "ffff"
       is completely opaque). The two example colours from earlier could also be specified as "rgba:ff00/0000/0000/8000" and
       "rgba:0000/ff00/0000/f332".

       You probably need to specify "-depth 32", too, to force a visual with alpha channels, and have the luck that your X-server uses ARGB pixel
       layout, as X is far from just supporting ARGB visuals out of the box, and rxvt-unicode just fudges around.

       For example, the following selects an almost completely transparent black background, and an almost opaque pink foreground:

          urxvt -depth 32 -bg rgba:0000/0000/0000/4444 -fg "[80]pink"

       When not using a background image, then the interpretation of the alpha channel is up to your compositing manager (most interpret it as
       transparency of course).

       When using a background pixmap or pseudo-transparency, then the background colour will always behave as if it were completely transparent
       (so the background image shows instead), regardless of how it was specified, while other colours will either be transparent as specified
       (the background image will show through) on servers supporting the RENDER extension, or fully opaque on servers not supporting the RENDER
       EXTENSION.

       Please note that due to bugs in Xft, specifying alpha values might result in garbage being displayed when the X-server does not support the
       RENDER extension.

ENVIRONMENT
       urxvt sets and/or uses the following environment variables:

       TERM
           Normally set to "rxvt-unicode", unless overwritten at configure time, via resources or on the command line.

       COLORTERM
           Either "rxvt", "rxvt-xpm", depending on whether urxvt was compiled with background image support, and optionally with the added
           extension "-mono" to indicate that rxvt-unicode runs on a monochrome screen.

       COLORFGBG
           Set to a string of the form "fg;bg" or "fg;xpm;bg", where "fg" is the colour code used as default foreground/text colour (or the string
           "default" to indicate that the default-colour escape sequence is to be used), "bg" is the colour code used as default background colour
           (or the string "default"), and "xpm" is the string "default" if urxvt was compiled with background image support. Libraries like
           "ncurses" and "slang" can (and do) use this information to optimize screen output.

       WINDOWID
           Set to the (decimal) X Window ID of the urxvt window (the toplevel window, which usually has subwindows for the scrollbar, the terminal
           window and so on).

       TERMINFO
           Set to the terminfo directory iff urxvt was configured with "--with-terminfo=PATH".

       DISPLAY
           Used by urxvt to connect to the display and set to the correct display in its child processes if "-display" isn't used to override. It
           defaults to ":0" if it doesn't exist.

       SHELL
           The shell to be used for command execution, defaults to "/bin/sh".

       RXVT_SOCKET [sic]
           The unix domain socket path used by urxvtc(1) and urxvtd(1).

           Default $HOME/.urxvt/urxvtd-<nodename>.

       URXVT_PERL_LIB
           Additional :-separated library search path for perl extensions. Will be searched after -perl-lib but before ~/.urxvt/ext and the system
           library directory.

       URXVT_PERL_VERBOSITY
           See urxvtperl(3).

       HOME
           Used to locate the default directory for the unix domain socket for daemon communications and to locate various resource files (such as
           ".Xdefaults")

       XAPPLRESDIR
           Directory where application-specific X resource files are located.

       XENVIRONMENT
           If set and accessible, gives the name of a X resource file to be loaded by urxvt.

FILES
       /etc/X11/rgb.txt
           Colour names.

SEE ALSO
       urxvt(7), urxvtc(1), urxvtd(1), urxvt-extensions(1), urxvtperl(3), xterm(1), sh(1), resize(1), X(1), pty(4), tty(4), utmp(5)

CURRENT PROJECT COORDINATOR
       Project Coordinator
           Marc A. Lehmann <rxvt-unicode@schmorp.de>.

           <http://software.schmorp.de/pkg/rxvt-unicode.html>

AUTHORS
       John Bovey
           University of Kent, 1992, wrote the original Xvt.

       Rob Nation <nation@rocket.sanders.lockheed.com>
           very heavily modified Xvt and came up with Rxvt

       Angelo Haritsis <ah@doc.ic.ac.uk>
           wrote the Greek Keyboard Input (no longer in code)

       mj olesen <olesen@me.QueensU.CA>
           Wrote the menu system.

           Project Coordinator (changes.txt 2.11 to 2.21)

       Oezguer Kesim <kesim@math.fu-berlin.de>
           Project Coordinator (changes.txt 2.21a to 2.4.5)

       Geoff Wing <gcw@pobox.com>
           Rewrote screen display and text selection routines.

           Project Coordinator (changes.txt 2.4.6 - rxvt-unicode)

       Marc Alexander Lehmann <rxvt-unicode@schmorp.de>
           Forked rxvt-unicode, unicode support, rewrote almost all the code, perl extension, random hacks, numerous bugfixes and extensions.

           Project Coordinator (Changes 1.0 -)

       Emanuele Giaquinta <emanuele.giaquinta@gmail.com>
           pty/utmp code rewrite, image code improvements, many random hacks and bugfixes.

9.22                                                                2016-06-26                                                            urxvt(1)
urxvt(7)                                                           RXVT-UNICODE                                                           urxvt(7)

NAME
       RXVT_REFERENCE - FAQ, command sequences and other background information

SYNOPSIS
          # set a new font set
          printf '\33]50;%s\007' 9x15,xft:Kochi" Mincho"

          # change the locale and tell rxvt-unicode about it
          export LC_CTYPE=ja_JP.EUC-JP; printf "\33]701;$LC_CTYPE\007"

          # set window title
          printf '\33]2;%s\007' "new window title"

DESCRIPTION
       This document contains the FAQ, the RXVT TECHNICAL REFERENCE documenting all escape sequences, and other background information.

       The newest version of this document is also available on the World Wide Web at
       <http://pod.tst.eu/http://cvs.schmorp.de/rxvt-unicode/doc/rxvt.7.pod>.

       The main manual page for urxvt itself is available at <http://pod.tst.eu/http://cvs.schmorp.de/rxvt-unicode/doc/rxvt.1.pod>.

RXVT-UNICODE/URXVT FREQUENTLY ASKED QUESTIONS
   Meta, Features & Commandline Issues
       My question isn't answered here, can I ask a human?

       Before sending me mail, you could go to IRC: "irc.freenode.net", channel "#rxvt-unicode" has some rxvt-unicode enthusiasts that might be
       interested in learning about new and exciting problems (but not FAQs :).

       I use Gentoo, and I have a problem...

       There are two big problems with Gentoo Linux: first, most if not all Gentoo systems are completely broken (missing or mismatched header
       files, broken compiler etc. are just the tip of the iceberg); secondly, it should be called Gentoo GNU/Linux.

       For these reasons, it is impossible to support rxvt-unicode on Gentoo. Problems appearing on Gentoo systems will usually simply be ignored
       unless they can be reproduced on non-Gentoo systems.

       Does it support tabs, can I have a tabbed rxvt-unicode?

       Beginning with version 7.3, there is a perl extension that implements a simple tabbed terminal. It is installed by default, so any of these
       should give you tabs:

          urxvt -pe tabbed

          URxvt.perl-ext-common: default,tabbed

       It will also work fine with tabbing functionality of many window managers or similar tabbing programs, and its embedding-features allow it
       to be embedded into other programs, as witnessed by doc/rxvt-tabbed or the upcoming "Gtk2::URxvt" perl module, which features a tabbed
       urxvt (murxvt) terminal as an example embedding application.

       How do I know which rxvt-unicode version I'm using?

       The version number is displayed with the usage (-h). Also the escape sequence "ESC [ 8 n" sets the window title to the version number. When
       using the urxvtc client, the version displayed is that of the daemon.

       Rxvt-unicode uses gobs of memory, how can I reduce that?

       Rxvt-unicode tries to obey the rule of not charging you for something you don't use. One thing you should try is to configure out all
       settings that you don't need, for example, Xft support is a resource hog by design, when used. Compiling it out ensures that no Xft font
       will be loaded accidentally when rxvt-unicode tries to find a font for your characters.

       Also, many people (me included) like large windows and even larger scrollback buffers: Without "--enable-unicode3", rxvt-unicode will use 6
       bytes per screen cell. For a 160x?? window this amounts to almost a kilobyte per line. A scrollback buffer of 10000 lines will then (if
       full) use 10 Megabytes of memory. With "--enable-unicode3" it gets worse, as rxvt-unicode then uses 8 bytes per screen cell.

       How can I start urxvtd in a race-free way?

       Try "urxvtd -f -o", which tells urxvtd to open the display, create the listening socket and then fork.

       How can I start urxvtd automatically when I run urxvtc?

       If you want to start urxvtd automatically whenever you run urxvtc and the daemon isn't running yet, use this script:

          #!/bin/sh
          urxvtc "$@"
          if [ $? -eq 2 ]; then
             urxvtd -q -o -f
             urxvtc "$@"
          fi

       This tries to create a new terminal, and if fails with exit status 2, meaning it couldn't connect to the daemon, it will start the daemon
       and re-run the command. Subsequent invocations of the script will re-use the existing daemon.

       How do I distinguish whether I'm running rxvt-unicode or a regular xterm? I need this to decide about setting colours etc.

       The original rxvt and rxvt-unicode always export the variable "COLORTERM", so you can check and see if that is set. Note that several
       programs, JED, slrn, Midnight Commander automatically check this variable to decide whether or not to use colour.

       How do I set the correct, full IP address for the DISPLAY variable?

       If you've compiled rxvt-unicode with DISPLAY_IS_IP and have enabled insecure mode then it is possible to use the following shell script
       snippets to correctly set the display. If your version of rxvt-unicode wasn't also compiled with ESCZ_ANSWER (as assumed in these snippets)
       then the COLORTERM variable can be used to distinguish rxvt-unicode from a regular xterm.

       Courtesy of Chuck Blake <cblake@BBN.COM> with the following shell script snippets:

          # Bourne/Korn/POSIX family of shells:
          [ ${TERM:-foo} = foo ] && TERM=xterm # assume an xterm if we don't know
          if [ ${TERM:-foo} = xterm ]; then
             stty -icanon -echo min 0 time 15 # see if enhanced rxvt or not
             printf "\eZ"
             read term_id
             stty icanon echo
             if [ ""${term_id} = '^[[?1;2C' -a ${DISPLAY:-foo} = foo ]; then
                printf '\e[7n'        # query the rxvt we are in for the DISPLAY string
                read DISPLAY          # set it in our local shell
             fi
          fi

       How do I compile the manual pages on my own?

       You need to have a recent version of perl installed as /usr/bin/perl, one that comes with pod2man, pod2text and pod2xhtml (from
       Pod::Xhtml). Then go to the doc subdirectory and enter "make alldoc".

       Isn't rxvt-unicode supposed to be small? Don't all those features bloat?

       I often get asked about this, and I think, no, they didn't cause extra bloat. If you compare a minimal rxvt and a minimal urxvt, you can
       see that the urxvt binary is larger (due to some encoding tables always being compiled in), but it actually uses less memory (RSS) after
       startup. Even with "--disable-everything", this comparison is a bit unfair, as many features unique to urxvt (locale, encoding conversion,
       iso14755 etc.) are already in use in this mode.

           text    data     bss     drs     rss filename
          98398    1664      24   15695    1824 rxvt --disable-everything
         188985    9048   66616   18222    1788 urxvt --disable-everything

       When you "--enable-everything" (which is unfair, as this involves xft and full locale/XIM support which are quite bloaty inside libX11 and
       my libc), the two diverge, but not unreasonably so.

           text    data     bss     drs     rss filename
         163431    2152      24   20123    2060 rxvt --enable-everything
        1035683   49680   66648   29096    3680 urxvt --enable-everything

       The very large size of the text section is explained by the east-asian encoding tables, which, if unused, take up disk space but nothing
       else and can be compiled out unless you rely on X11 core fonts that use those encodings. The BSS size comes from the 64k emergency buffer
       that my c++ compiler allocates (but of course doesn't use unless you are out of memory). Also, using an xft font instead of a core font
       immediately adds a few megabytes of RSS. Xft indeed is responsible for a lot of RSS even when not used.

       Of course, due to every character using two or four bytes instead of one, a large scrollback buffer will ultimately make rxvt-unicode use
       more memory.

       Compared to e.g. Eterm (5112k), aterm (3132k) and xterm (4680k), this still fares rather well. And compared to some monsters like gnome-
       terminal (21152k + extra 4204k in separate processes) or konsole (22200k + extra 43180k in daemons that stay around after exit, plus half a
       minute of startup time, including the hundreds of warnings it spits out), it fares extremely well *g*.

       Why C++, isn't that unportable/bloated/uncool?

       Is this a question? :) It comes up very often. The simple answer is: I had to write it, and C++ allowed me to write and maintain it in a
       fraction of the time and effort (which is a scarce resource for me). Put even shorter: It simply wouldn't exist without C++.

       My personal stance on this is that C++ is less portable than C, but in the case of rxvt-unicode this hardly matters, as its portability
       limits are defined by things like X11, pseudo terminals, locale support and unix domain sockets, which are all less portable than C++
       itself.

       Regarding the bloat, see the above question: It's easy to write programs in C that use gobs of memory, and certainly possible to write
       programs in C++ that don't. C++ also often comes with large libraries, but this is not necessarily the case with GCC. Here is what rxvt
       links against on my system with a minimal config:

          libX11.so.6 => /usr/X11R6/lib/libX11.so.6 (0x00002aaaaabc3000)
          libc.so.6 => /lib/libc.so.6 (0x00002aaaaadde000)
          libdl.so.2 => /lib/libdl.so.2 (0x00002aaaab01d000)
          /lib64/ld-linux-x86-64.so.2 (0x00002aaaaaaab000)

       And here is rxvt-unicode:

          libX11.so.6 => /usr/X11R6/lib/libX11.so.6 (0x00002aaaaabc3000)
          libgcc_s.so.1 => /lib/libgcc_s.so.1 (0x00002aaaaada2000)
          libc.so.6 => /lib/libc.so.6 (0x00002aaaaaeb0000)
          libdl.so.2 => /lib/libdl.so.2 (0x00002aaaab0ee000)
          /lib64/ld-linux-x86-64.so.2 (0x00002aaaaaaab000)

       No large bloated libraries (of course, none were linked in statically), except maybe libX11 :)

   Rendering, Font & Look and Feel Issues
       I can't get transparency working, what am I doing wrong?

       First of all, transparency isn't officially supported in rxvt-unicode, so you are mostly on your own. Do not bug the author about it (but
       you may bug everybody else). Also, if you can't get it working consider it a rite of passage: ... and you failed.

       Here are four ways to get transparency. Do read the manpage and option descriptions for the programs mentioned and rxvt-unicode. Really, do
       it!

       1. Use transparent mode:

          Esetroot wallpaper.jpg
          urxvt -tr -tint red -sh 40

       That works. If you think it doesn't, you lack transparency and tinting support, or you are unable to read.  This method requires that the
       background-setting program sets the _XROOTPMAP_ID or ESETROOT_PMAP_ID property. Compatible programs are Esetroot, hsetroot and feh.

       2. Use a simple pixmap and emulate pseudo-transparency. This enables you to use effects other than tinting and shading: Just
       shade/tint/whatever your picture with gimp or any other tool:

          convert wallpaper.jpg -blur 20x20 -modulate 30 background.jpg
          urxvt -pixmap "background.jpg;:root"

       That works. If you think it doesn't, you lack GDK-PixBuf support, or you are unable to read.

       3. Use an ARGB visual:

          urxvt -depth 32 -fg grey90 -bg rgba:0000/0000/4444/cccc

       This requires XFT support, and the support of your X-server. If that doesn't work for you, blame Xorg and Keith Packard. ARGB visuals
       aren't there yet, no matter what they claim. Rxvt-Unicode contains the necessary bugfixes and workarounds for Xft and Xlib to make it work,
       but that doesn't mean that your WM has the required kludges in place.

       4. Use xcompmgr and let it do the job:

         xprop -frame -f _NET_WM_WINDOW_OPACITY 32c \
               -set _NET_WM_WINDOW_OPACITY 0xc0000000

       Then click on a window you want to make transparent. Replace 0xc0000000 by other values to change the degree of opacity. If it doesn't work
       and your server crashes, you got to keep the pieces.

       Why does rxvt-unicode sometimes leave pixel droppings?

       Most fonts were not designed for terminal use, which means that character size varies a lot. A font that is otherwise fine for terminal use
       might contain some characters that are simply too wide. Rxvt-unicode will avoid these characters. For characters that are just "a bit" too
       wide a special "careful" rendering mode is used that redraws adjacent characters.

       All of this requires that fonts do not lie about character sizes, however: Xft fonts often draw glyphs larger than their acclaimed bounding
       box, and rxvt-unicode has no way of detecting this (the correct way is to ask for the character bounding box, which unfortunately is wrong
       in these cases).

       It's not clear (to me at least), whether this is a bug in Xft, freetype, or the respective font. If you encounter this problem you might
       try using the "-lsp" option to give the font more height. If that doesn't work, you might be forced to use a different font.

       All of this is not a problem when using X11 core fonts, as their bounding box data is correct.

       How can I keep rxvt-unicode from using reverse video so much?

       First of all, make sure you are running with the right terminal settings ("TERM=rxvt-unicode"), which will get rid of most of these
       effects. Then make sure you have specified colours for italic and bold, as otherwise rxvt-unicode might use reverse video to simulate the
       effect:

          URxvt.colorBD:  white
          URxvt.colorIT:  green

       Some programs assume totally weird colours (red instead of blue), how can I fix that?

       For some unexplainable reason, some rare programs assume a very weird colour palette when confronted with a terminal with more than the
       standard 8 colours (rxvt-unicode supports 88). The right fix is, of course, to fix these programs not to assume non-ISO colours without
       very good reasons.

       In the meantime, you can either edit your "rxvt-unicode" terminfo definition to only claim 8 colour support or use "TERM=rxvt", which will
       fix colours but keep you from using other rxvt-unicode features.

       Can I switch the fonts at runtime?

       Yes, using an escape sequence. Try something like this, which has the same effect as using the "-fn" switch, and takes effect immediately:

          printf '\33]50;%s\007' "9x15bold,xft:Kochi Gothic"

       This is useful if you e.g. work primarily with japanese (and prefer a japanese font), but you have to switch to chinese temporarily, where
       japanese fonts would only be in your way.

       You can think of this as a kind of manual ISO-2022 switching.

       Why do italic characters look as if clipped?

       Many fonts have difficulties with italic characters and hinting. For example, the otherwise very nicely hinted font "xft:Bitstream Vera
       Sans Mono" completely fails in its italic face. A workaround might be to enable freetype autohinting, i.e. like this:

          URxvt.italicFont:        xft:Bitstream Vera Sans Mono:italic:autohint=true
          URxvt.boldItalicFont:    xft:Bitstream Vera Sans Mono:bold:italic:autohint=true

       Can I speed up Xft rendering somehow?

       Yes, the most obvious way to speed it up is to avoid Xft entirely, as it is simply slow. If you still want Xft fonts you might try to
       disable antialiasing (by appending ":antialias=false"), which saves lots of memory and also speeds up rendering considerably.

       Rxvt-unicode doesn't seem to anti-alias its fonts, what is wrong?

       Rxvt-unicode will use whatever you specify as a font. If it needs to fall back to its default font search list it will prefer X11 core
       fonts, because they are small and fast, and then use Xft fonts. It has antialiasing disabled for most of them, because the author thinks
       they look best that way.

       If you want antialiasing, you have to specify the fonts manually.

       What's with this bold/blink stuff?

       If no bold colour is set via "colorBD:", bold will invert text using the standard foreground colour.

       For the standard background colour, blinking will actually make the text blink when compiled with "--enable-text-blink". Without
       "--enable-text-blink", the blink attribute will be ignored.

       On ANSI colours, bold/blink attributes are used to set high-intensity foreground/background colours.

       color0-7 are the low-intensity colours.

       color8-15 are the corresponding high-intensity colours.

       I don't like the screen colours.  How do I change them?

       You can change the screen colours at run-time using ~/.Xdefaults resources (or as long-options).

       Here are values that are supposed to resemble a VGA screen, including the murky brown that passes for low-intensity yellow:

          URxvt.color0:   #000000
          URxvt.color1:   #A80000
          URxvt.color2:   #00A800
          URxvt.color3:   #A8A800
          URxvt.color4:   #0000A8
          URxvt.color5:   #A800A8
          URxvt.color6:   #00A8A8
          URxvt.color7:   #A8A8A8

          URxvt.color8:   #000054
          URxvt.color9:   #FF0054
          URxvt.color10:  #00FF54
          URxvt.color11:  #FFFF54
          URxvt.color12:  #0000FF
          URxvt.color13:  #FF00FF
          URxvt.color14:  #00FFFF
          URxvt.color15:  #FFFFFF

       And here is a more complete set of non-standard colours.

          URxvt.cursorColor:  #dc74d1
          URxvt.pointerColor: #dc74d1
          URxvt.background:   #0e0e0e
          URxvt.foreground:   #4ad5e1
          URxvt.color0:       #000000
          URxvt.color8:       #8b8f93
          URxvt.color1:       #dc74d1
          URxvt.color9:       #dc74d1
          URxvt.color2:       #0eb8c7
          URxvt.color10:      #0eb8c7
          URxvt.color3:       #dfe37e
          URxvt.color11:      #dfe37e
          URxvt.color5:       #9e88f0
          URxvt.color13:      #9e88f0
          URxvt.color6:       #73f7ff
          URxvt.color14:      #73f7ff
          URxvt.color7:       #e1dddd
          URxvt.color15:      #e1dddd

       They have been described (not by me) as "pretty girly".

       Why do some characters look so much different than others?

       See next entry.

       How does rxvt-unicode choose fonts?

       Most fonts do not contain the full range of Unicode, which is fine. Chances are that the font you (or the admin/package maintainer of your
       system/os) have specified does not cover all the characters you want to display.

       rxvt-unicode makes a best-effort try at finding a replacement font. Often the result is fine, but sometimes the chosen font looks
       bad/ugly/wrong. Some fonts have totally strange characters that don't resemble the correct glyph at all, and rxvt-unicode lacks the
       artificial intelligence to detect that a specific glyph is wrong: it has to believe the font that the characters it claims to contain
       indeed look correct.

       In that case, select a font of your taste and add it to the font list, e.g.:

          urxvt -fn basefont,font2,font3...

       When rxvt-unicode sees a character, it will first look at the base font. If the base font does not contain the character, it will go to the
       next font, and so on. Specifying your own fonts will also speed up this search and use less resources within rxvt-unicode and the X-server.

       The only limitation is that none of the fonts may be larger than the base font, as the base font defines the terminal character cell size,
       which must be the same due to the way terminals work.

       Why do some chinese characters look so different than others?

       This is because there is a difference between script and language -- rxvt-unicode does not know which language the text that is output is,
       as it only knows the unicode character codes. If rxvt-unicode first sees a japanese/chinese character, it might choose a japanese font for
       display. Subsequent japanese characters will use that font. Now, many chinese characters aren't represented in japanese fonts, so when the
       first non-japanese character comes up, rxvt-unicode will look for a chinese font -- unfortunately at this point, it will still use the
       japanese font for chinese characters that are also in the japanese font.

       The workaround is easy: just tag a chinese font at the end of your font list (see the previous question). The key is to view the font list
       as a preference list: If you expect more japanese, list a japanese font first. If you expect more chinese, put a chinese font first.

       In the future it might be possible to switch language preferences at runtime (the internal data structure has no problem with using
       different fonts for the same character at the same time, but no interface for this has been designed yet).

       Until then, you might get away with switching fonts at runtime (see "Can I switch the fonts at runtime?" later in this document).

       How can I make mplayer display video correctly?

       We are working on it, in the meantime, as a workaround, use something like:

          urxvt -b 600 -geometry 20x1 -e sh -c 'mplayer -wid $WINDOWID file...'

       Why is the cursor now blinking in emacs/vi/...?

       This is likely caused by your editor/program's use of the "cvvis" terminfo capability. Emacs uses it by default, as well as some versions
       of vi and possibly other programs.

       In emacs, you can switch that off by adding this to your ".emacs" file:

          (setq visible-cursor nil)

       For other programs, if they do not have an option, your have to remove the "cvvis" capability from the terminfo description.

       When urxvt first added the blinking cursor option, it didn't add a "cvvis" capability, which served no purpose before. Version 9.21
       introduced "cvvis" (and the ability to control blinking independent of cursor shape) for compatibility with other terminals, which
       traditionally use a blinking cursor for "cvvis". This also reflects the intent of programs such as emacs, who expect "cvvis" to enable a
       blinking cursor.

   Keyboard, Mouse & User Interaction
       The new selection selects pieces that are too big, how can I select single words?

       If you want to select e.g. alphanumeric words, you can use the following setting:

          URxvt.selection.pattern-0: ([[:word:]]+)

       If you click more than twice, the selection will be extended more and more.

       To get a selection that is very similar to the old code, try this pattern:

          URxvt.selection.pattern-0: ([^"&'()*,;<=>?@[\\\\]^`{|})]+)

       Please also note that the LeftClick Shift-LeftClick combination also selects words like the old code.

       I don't like the new selection/popups/hotkeys/perl, how do I change/disable it?

       You can disable the perl extension completely by setting the perl-ext-common resource to the empty string, which also keeps rxvt-unicode
       from initialising perl, saving memory.

       If you only want to disable specific features, you first have to identify which perl extension is responsible. For this, read the section
       PREPACKAGED EXTENSIONS in the urxvtperl(3) manpage. For example, to disable the selection-popup and option-popup, specify this perl-ext-
       common resource:

          URxvt.perl-ext-common: default,-selection-popup,-option-popup

       This will keep the default extensions, but disable the two popup extensions. Some extensions can also be configured, for example,
       scrollback search mode is triggered by M-s. You can move it to any other combination by adding a keysym resource that binds the desired
       combination to the "start" action of "searchable-scrollback" and another one that binds M-s to the "builtin:" action:

          URxvt.keysym.CM-s: searchable-scrollback:start
          URxvt.keysym.M-s: builtin:

       The cursor moves when selecting text in the current input line, how do I switch this off?

       See next entry.

       During rlogin/ssh/telnet/etc. sessions, clicking near the cursor outputs strange escape sequences, how do I fix this?

       These are caused by the "readline" perl extension. Under normal circumstances, it will move your cursor around when you click into the line
       that contains it. It tries hard not to do this at the wrong moment, but when running a program that doesn't parse cursor movements or in
       some cases during rlogin sessions, it fails to detect this properly.

       You can permanently switch this feature off by disabling the "readline" extension:

          URxvt.perl-ext-common: default,-readline

       My numeric keypad acts weird and generates differing output?

       Some Debian GNU/Linux users seem to have this problem, although no specific details were reported so far. It is possible that this is
       caused by the wrong "TERM" setting, although the details of whether and how this can happen are unknown, as "TERM=rxvt" should offer a
       compatible keymap. See the answer to the previous question, and please report if that helped.

       My Compose (Multi_key) key is no longer working.

       The most common causes for this are that either your locale is not set correctly, or you specified a preeditType that is not supported by
       your input method. For example, if you specified OverTheSpot and your input method (e.g. the default input method handling Compose keys)
       does not support this (for instance because it is not visual), then rxvt-unicode will continue without an input method.

       In this case either do not specify a preeditType or specify more than one pre-edit style, such as OverTheSpot,Root,None.

       If it still doesn't work, then maybe your input method doesn't support compose sequences - to fall back to the built-in one, make sure you
       don't specify an input method via "-im" or "XMODIFIERS".

       I cannot type "Ctrl-Shift-2" to get an ASCII NUL character due to ISO 14755

       Either try "Ctrl-2" alone (it often is mapped to ASCII NUL even on international keyboards) or simply use ISO 14755 support to your
       advantage, typing <Ctrl-Shift-0> to get a ASCII NUL. This works for other codes, too, such as "Ctrl-Shift-1-d" to type the default telnet
       escape character and so on.

       Mouse cut/paste suddenly no longer works.

       Make sure that mouse reporting is actually turned off since killing some editors prematurely may leave it active. I've heard that tcsh may
       use mouse reporting unless it is otherwise specified. A quick check is to see if cut/paste works when the Alt or Shift keys are pressed.

       What's with the strange Backspace/Delete key behaviour?

       Assuming that the physical Backspace key corresponds to the Backspace keysym (not likely for Linux ... see the following question) there
       are two standard values that can be used for Backspace: "^H" and "^?".

       Historically, either value is correct, but rxvt-unicode adopts the debian policy of using "^?" when unsure, because it's the one and only
       correct choice :).

       It is possible to toggle between "^H" and "^?" with the DECBKM private mode:

          # use Backspace = ^H
          $ stty erase ^H
          $ printf "\e[?67h"

          # use Backspace = ^?
          $ stty erase ^?
          $ printf "\e[?67l"

       This helps satisfy some of the Backspace discrepancies that occur, but if you use Backspace = "^H", make sure that the termcap/terminfo
       value properly reflects that.

       The Delete key is a another casualty of the ill-defined Backspace problem.  To avoid confusion between the Backspace and Delete keys, the
       Delete key has been assigned an escape sequence to match the vt100 for Execute ("ESC [ 3 ~") and is in the supplied termcap/terminfo.

       Some other Backspace problems:

       some editors use termcap/terminfo, some editors (vim I'm told) expect Backspace = ^H, GNU Emacs (and Emacs-like editors) use ^H for help.

       Perhaps someday this will all be resolved in a consistent manner.

       I don't like the key-bindings.  How do I change them?

       There are some compile-time selections available via configure. Unless you have run "configure" with the "--disable-resources" option you
       can use the `keysym' resource to alter the keystrings associated with keysyms.

       Here's an example for a URxvt session started using "urxvt -name URxvt"

          URxvt.keysym.Prior:         \033[5~
          URxvt.keysym.Next:          \033[6~
          URxvt.keysym.Home:          \033[7~
          URxvt.keysym.End:           \033[8~
          URxvt.keysym.Up:            \033[A
          URxvt.keysym.Down:          \033[B
          URxvt.keysym.Right:         \033[C
          URxvt.keysym.Left:          \033[D

       See some more examples in the documentation for the keysym resource.

       I'm using keyboard model XXX that has extra Prior/Next/Insert keys. How do I make use of them? For example, the Sun Keyboard type 4 has the
       following map

          KP_Insert == Insert
          F22 == Print
          F27 == Home
          F29 == Prior
          F33 == End
          F35 == Next

       Rather than have rxvt-unicode try to accommodate all the various possible keyboard mappings, it is better to use `xmodmap' to remap the
       keys as required for your particular machine.

   Terminal Configuration
       Can I see a typical configuration?

       The default configuration tries to be xterm-like, which I don't like that much, but it's least surprise to regular users.

       As a rxvt or rxvt-unicode user, you are practically supposed to invest time into customising your terminal. To get you started, here is the
       author's .Xdefaults entries, with comments on what they do. It's certainly not typical, but what's typical...

          URxvt.cutchars: "()*,<>[]{}|'
          URxvt.print-pipe: cat >/tmp/xxx

       These are just for testing stuff.

          URxvt.imLocale: ja_JP.UTF-8
          URxvt.preeditType: OnTheSpot,None

       This tells rxvt-unicode to use a special locale when communicating with the X Input Method, and also tells it to only use the OnTheSpot
       pre-edit type, which requires the "xim-onthespot" perl extension but rewards me with correct-looking fonts.

          URxvt.perl-lib: /root/lib/urxvt
          URxvt.perl-ext-common: default,selection-autotransform,selection-pastebin,xim-onthespot,remote-clipboard
          URxvt.selection.pattern-0: ( at .*? line \\d+)
          URxvt.selection.pattern-1: ^(/[^:]+):\
          URxvt.selection-autotransform.0: s/^([^:[:space:]]+):(\\d+):?$/:e \\Q$1\\E\\x0d:$2\\x0d/
          URxvt.selection-autotransform.1: s/^ at (.*?) line (\\d+)$/:e \\Q$1\\E\\x0d:$2\\x0d/

       This is my perl configuration. The first two set the perl library directory and also tells urxvt to use a large number of extensions. I
       develop for myself mostly, so I actually use most of the extensions I write.

       The selection stuff mainly makes the selection perl-error-message aware and tells it to convert perl error messages into vi-commands to
       load the relevant file and go to the error line number.

          URxvt.scrollstyle:      plain
          URxvt.secondaryScroll:  true

       As the documentation says: plain is the preferred scrollbar for the author. The "secondaryScroll" configures urxvt to scroll in full-screen
       apps, like screen, so lines scrolled out of screen end up in urxvt's scrollback buffer.

          URxvt.background:       #000000
          URxvt.foreground:       gray90
          URxvt.color7:           gray90
          URxvt.colorBD:          #ffffff
          URxvt.cursorColor:      #e0e080
          URxvt.throughColor:     #8080f0
          URxvt.highlightColor:   #f0f0f0

       Some colours. Not sure which ones are being used or even non-defaults, but these are in my .Xdefaults. Most notably, they set
       foreground/background to light gray/black, and also make sure that the colour 7 matches the default foreground colour.

          URxvt.underlineColor:   yellow

       Another colour, makes underline lines look different. Sometimes hurts, but is mostly a nice effect.

          URxvt.geometry:         154x36
          URxvt.loginShell:       false
          URxvt.meta:             ignore
          URxvt.utmpInhibit:      true

       Uh, well, should be mostly self-explanatory. By specifying some defaults manually, I can quickly switch them for testing.

          URxvt.saveLines:        8192

       A large scrollback buffer is essential. Really.

          URxvt.mapAlert:         true

       The only case I use it is for my IRC window, which I like to keep iconified till people msg me (which beeps).

          URxvt.visualBell:       true

       The audible bell is often annoying, especially when in a crowd.

          URxvt.insecure:         true

       Please don't hack my mutt! Ooops...

          URxvt.pastableTabs:     false

       I once thought this is a great idea.

          urxvt.font:             9x15bold,\
                                  -misc-fixed-bold-r-normal--15-140-75-75-c-90-iso10646-1,\
                                  -misc-fixed-medium-r-normal--15-140-75-75-c-90-iso10646-1, \
                                  [codeset=JISX0208]xft:Kochi Gothic, \
                                  xft:Bitstream Vera Sans Mono:autohint=true, \
                                  xft:Code2000:antialias=false
          urxvt.boldFont:         -xos4-terminus-bold-r-normal--14-140-72-72-c-80-iso8859-15
          urxvt.italicFont:       xft:Bitstream Vera Sans Mono:italic:autohint=true
          urxvt.boldItalicFont:   xft:Bitstream Vera Sans Mono:bold:italic:autohint=true

       I wrote rxvt-unicode to be able to specify fonts exactly. So don't be overwhelmed. A special note: the "9x15bold" mentioned above is
       actually the version from XFree-3.3, as XFree-4 replaced it by a totally different font (different glyphs for ";" and many other harmless
       characters), while the second font is actually the "9x15bold" from XFree4/XOrg. The bold version has less chars than the medium version, so
       I use it for rare characters, too. When editing sources with vim, I use italic for comments and other stuff, which looks quite good with
       Bitstream Vera anti-aliased.

       Terminus is a quite bad font (many very wrong glyphs), but for most of my purposes, it works, and gives a different look, as my normal
       (Non-bold) font is already bold, and I want to see a difference between bold and normal fonts.

       Please note that I used the "urxvt" instance name and not the "URxvt" class name. That is because I use different configs for different
       purposes, for example, my IRC window is started with "-name IRC", and uses these defaults:

          IRC*title:              IRC
          IRC*geometry:           87x12+535+542
          IRC*saveLines:          0
          IRC*mapAlert:           true
          IRC*font:               suxuseuro
          IRC*boldFont:           suxuseuro
          IRC*colorBD:            white
          IRC*keysym.M-C-1:       command:\033]710;suxuseuro\007\033]711;suxuseuro\007
          IRC*keysym.M-C-2:       command:\033]710;9x15bold\007\033]711;9x15bold\007

       "Alt-Ctrl-1" and "Alt-Ctrl-2" switch between two different font sizes. "suxuseuro" allows me to keep an eye (and actually read) stuff while
       keeping a very small window. If somebody pastes something complicated (e.g. japanese), I temporarily switch to a larger font.

       The above is all in my ".Xdefaults" (I don't use ".Xresources" nor "xrdb"). I also have some resources in a separate ".Xdefaults-hostname"
       file for different hosts, for example, on my main desktop, I use:

          URxvt.keysym.C-M-q: command:\033[3;5;5t
          URxvt.keysym.C-M-y: command:\033[3;5;606t
          URxvt.keysym.C-M-e: command:\033[3;1605;5t
          URxvt.keysym.C-M-c: command:\033[3;1605;606t
          URxvt.keysym.C-M-p: perl:test

       The first for keysym definitions allow me to quickly bring some windows in the layout I like most. Ion users might start laughing but will
       stop immediately when I tell them that I use my own Fvwm2 module for much the same effect as Ion provides, and I only very rarely use the
       above key combinations :->

       Why doesn't rxvt-unicode read my resources?

       Well, why, indeed? It does, in a way very similar to other X applications. Most importantly, this means that if you or your OS loads
       resources into the X display (the right way to do it), rxvt-unicode will ignore any resource files in your home directory. It will only
       read $HOME/.Xdefaults when no resources are attached to the display.

       If you have or use an $HOME/.Xresources file, chances are that resources are loaded into your X-server. In this case, you have to re-login
       after every change (or run xrdb -merge $HOME/.Xresources).

       Also consider the form resources have to use:

         URxvt.resource: value

       If you want to use another form (there are lots of different ways of specifying resources), make sure you understand whether and why it
       works. If unsure, use the form above.

       When I log-in to another system it tells me about missing terminfo data?

       The terminal description used by rxvt-unicode is not as widely available as that for xterm, or even rxvt (for which the same problem often
       arises).

       The correct solution for this problem is to install the terminfo, this can be done by simply installing rxvt-unicode on the remote system
       as well (in case you have a nice package manager ready), or you can install the terminfo database manually like this (with ncurses infocmp.
       works as user and root):

          REMOTE=remotesystem.domain
          infocmp rxvt-unicode | ssh $REMOTE "mkdir -p .terminfo && cat >/tmp/ti && tic /tmp/ti"

       One some systems you might need to set $TERMINFO to the full path of $HOME/.terminfo for this to work.

       If you cannot or do not want to do this, then you can simply set "TERM=rxvt" or even "TERM=xterm", and live with the small number of
       problems arising, which includes wrong keymapping, less and different colours and some refresh errors in fullscreen applications. It's a
       nice quick-and-dirty workaround for rare cases, though.

       If you always want to do this (and are fine with the consequences) you can either recompile rxvt-unicode with the desired TERM value or use
       a resource to set it:

          URxvt.termName: rxvt

       If you don't plan to use rxvt (quite common...) you could also replace the rxvt terminfo file with the rxvt-unicode one and use
       "TERM=rxvt".

       nano fails with "Error opening terminal: rxvt-unicode"

       This exceptionally confusing and useless error message is printed by nano when it can't find the terminfo database. Nothing is wrong with
       your terminal, read the previous answer for a solution.

       "tic" outputs some error when compiling the terminfo entry.

       Most likely it's the empty definition for "enacs=". Just replace it by "enacs=\E[0@" and try again.

       "bash"'s readline does not work correctly under urxvt.

       See next entry.

       I need a termcap file entry.

       One reason you might want this is that some distributions or operating systems still compile some programs using the long-obsoleted termcap
       library (Fedora's bash is one example) and rely on a termcap entry for "rxvt-unicode".

       You could use rxvt's termcap entry with reasonable results in many cases.  You can also create a termcap entry by using terminfo's infocmp
       program like this:

          infocmp -C rxvt-unicode

       Or you could use the termcap entry in doc/etc/rxvt-unicode.termcap, generated by the command above.

       Why does "ls" no longer have coloured output?

       The "ls" in the GNU coreutils unfortunately doesn't use terminfo to decide whether a terminal has colour, but uses its own configuration
       file. Needless to say, "rxvt-unicode" is not in its default file (among with most other terminals supporting colour). Either add:

          TERM rxvt-unicode

       to "/etc/DIR_COLORS" or simply add:

          alias ls='ls --color=auto'

       to your ".profile" or ".bashrc".

       Why doesn't vim/emacs etc. use the 88 colour mode?

       See next entry.

       Why doesn't vim/emacs etc. make use of italic?

       See next entry.

       Why are the secondary screen-related options not working properly?

       Make sure you are using "TERM=rxvt-unicode". Some pre-packaged distributions break rxvt-unicode by setting "TERM" to "rxvt", which doesn't
       have these extra features. Unfortunately, some of these furthermore fail to even install the "rxvt-unicode" terminfo file, so you will need
       to install it on your own (See the question When I log-in to another system it tells me about missing terminfo data? on how to do this).

   Encoding / Locale / Input Method Issues
       Rxvt-unicode does not seem to understand the selected encoding?

       See next entry.

       Unicode does not seem to work?

       If you encounter strange problems like typing an accented character but getting two unrelated other characters or similar, or if program
       output is subtly garbled, then you should check your locale settings.

       Rxvt-unicode must be started with the same "LC_CTYPE" setting as the programs running in it. Often rxvt-unicode is started in the "C"
       locale, while the login script running within the rxvt-unicode window changes the locale to something else, e.g. "en_GB.UTF-8". Needless to
       say, this is not going to work, and is the most common cause for problems.

       The best thing is to fix your startup environment, as you will likely run into other problems. If nothing works you can try this in your
       .profile.

         printf '\33]701;%s\007' "$LC_CTYPE"   # $LANG or $LC_ALL are worth a try, too

       If this doesn't work, then maybe you use a "LC_CTYPE" specification not supported on your systems. Some systems have a "locale" command
       which displays this (also, "perl -e0" can be used to check locale settings, as it will complain loudly if it cannot set the locale). If it
       displays something like:

         locale: Cannot set LC_CTYPE to default locale: ...

       Then the locale you specified is not supported on your system.

       If nothing works and you are sure that everything is set correctly then you will need to remember a little known fact: Some programs just
       don't support locales :(

       How does rxvt-unicode determine the encoding to use?

       See next entry.

       Is there an option to switch encodings?

       Unlike some other terminals, rxvt-unicode has no encoding switch, and no specific "utf-8" mode, such as xterm. In fact, it doesn't even
       know about UTF-8 or any other encodings with respect to terminal I/O.

       The reasons is that there exists a perfectly fine mechanism for selecting the encoding, doing I/O and (most important) communicating this
       to all applications so everybody agrees on character properties such as width and code number. This mechanism is the locale. Applications
       not using that info will have problems (for example, "xterm" gets the width of characters wrong as it uses its own, locale-independent
       table under all locales).

       Rxvt-unicode uses the "LC_CTYPE" locale category to select encoding. All programs doing the same (that is, most) will automatically agree
       in the interpretation of characters.

       Unfortunately, there is no system-independent way to select locales, nor is there a standard on how locale specifiers will look like.

       On most systems, the content of the "LC_CTYPE" environment variable contains an arbitrary string which corresponds to an already-installed
       locale. Common names for locales are "en_US.UTF-8", "de_DE.ISO-8859-15", "ja_JP.EUC-JP", i.e. "language_country.encoding", but other forms
       (i.e. "de" or "german") are also common.

       Rxvt-unicode ignores all other locale categories, and except for the encoding, ignores country or language-specific settings, i.e.
       "de_DE.UTF-8" and "ja_JP.UTF-8" are the normally same to rxvt-unicode.

       If you want to use a specific encoding you have to make sure you start rxvt-unicode with the correct "LC_CTYPE" category.

       Can I switch locales at runtime?

       Yes, using an escape sequence. Try something like this, which sets rxvt-unicode's idea of "LC_CTYPE".

         printf '\33]701;%s\007' ja_JP.SJIS

       See also the previous answer.

       Sometimes this capability is rather handy when you want to work in one locale (e.g. "de_DE.UTF-8") but some programs don't support it (e.g.
       UTF-8). For example, I use this script to start "xjdic", which first switches to a locale supported by xjdic and back later:

          printf '\33]701;%s\007' ja_JP.SJIS
          xjdic -js
          printf '\33]701;%s\007' de_DE.UTF-8

       You can also use xterm's "luit" program, which usually works fine, except for some locales where character width differs between program-
       and rxvt-unicode-locales.

       I have problems getting my input method working.

       Try a search engine, as this is slightly different for every input method server.

       Here is a checklist:

       - Make sure your locale and the imLocale are supported on your OS.
           Try "locale -a" or check the documentation for your OS.

       - Make sure your locale or imLocale matches a locale supported by your XIM.
           For example, kinput2 does not support UTF-8 locales, you should use "ja_JP.EUC-JP" or equivalent.

       - Make sure your XIM server is actually running.
       - Make sure the "XMODIFIERS" environment variable is set correctly when starting rxvt-unicode.
           When you want to use e.g. kinput2, it must be set to "@im=kinput2". For scim, use "@im=SCIM". You can see what input method servers are
           running with this command:

              xprop -root XIM_SERVERS

       My input method wants <some encoding> but I want UTF-8, what can I do?

       You can specify separate locales for the input method and the rest of the terminal, using the resource "imlocale":

          URxvt.imlocale: ja_JP.EUC-JP

       Now you can start your terminal with "LC_CTYPE=ja_JP.UTF-8" and still use your input method. Please note, however, that, depending on your
       Xlib version, you may not be able to input characters outside "EUC-JP" in a normal way then, as your input method limits you.

       Rxvt-unicode crashes when the X Input Method changes or exits.

       Unfortunately, this is unavoidable, as the XIM protocol is racy by design. Applications can avoid some crashes at the expense of memory
       leaks, and Input Methods can avoid some crashes by careful ordering at exit time. kinput2 (and derived input methods) generally succeeds,
       while SCIM (or similar input methods) fails. In the end, however, crashes cannot be completely avoided even if both sides cooperate.

       So the only workaround is not to kill your Input Method Servers.

   Operating Systems / Package Maintaining
       I am maintaining rxvt-unicode for distribution/OS XXX, any recommendation?

       You should build one binary with the default options. configure now enables most useful options, and the trend goes to making them runtime-
       switchable, too, so there is usually no drawback to enabling them, except higher disk and possibly memory usage. The perl interpreter
       should be enabled, as important functionality (menus, selection, likely more in the future) depends on it.

       You should not overwrite the "perl-ext-common" and "perl-ext" resources system-wide (except maybe with "defaults"). This will result in
       useful behaviour. If your distribution aims at low memory, add an empty "perl-ext-common" resource to the app-defaults file. This will keep
       the perl interpreter disabled until the user enables it.

       If you can/want build more binaries, I recommend building a minimal one with "--disable-everything" (very useful) and a maximal one with
       "--enable-everything" (less useful, it will be very big due to a lot of encodings built-in that increase download times and are rarely
       used).

       I need to make it setuid/setgid to support utmp/ptys on my OS, is this safe?

       It should be, starting with release 7.1. You are encouraged to properly install urxvt with privileges necessary for your OS now.

       When rxvt-unicode detects that it runs setuid or setgid, it will fork into a helper process for privileged operations (pty handling on some
       systems, utmp/wtmp/lastlog handling on others) and drop privileges immediately. This is much safer than most other terminals that keep
       privileges while running (but is more relevant to urxvt, as it contains things as perl interpreters, which might be "helpful" to
       attackers).

       This forking is done as the very first within main(), which is very early and reduces possible bugs to initialisation code run before
       main(), or things like the dynamic loader of your system, which should result in very little risk.

       I am on FreeBSD and rxvt-unicode does not seem to work at all.

       Rxvt-unicode requires the symbol "__STDC_ISO_10646__" to be defined in your compile environment, or an implementation that implements it,
       whether it defines the symbol or not. "__STDC_ISO_10646__" requires that wchar_t is represented as unicode.

       As you might have guessed, FreeBSD does neither define this symbol nor does it support it. Instead, it uses its own internal representation
       of wchar_t. This is, of course, completely fine with respect to standards.

       However, that means rxvt-unicode only works in "POSIX", "ISO-8859-1" and "UTF-8" locales under FreeBSD (which all use Unicode as wchar_t).

       "__STDC_ISO_10646__" is the only sane way to support multi-language apps in an OS, as using a locale-dependent (and non-standardized)
       representation of wchar_t makes it impossible to convert between wchar_t (as used by X11 and your applications) and any other encoding
       without implementing OS-specific-wrappers for each and every locale. There simply are no APIs to convert wchar_t into anything except the
       current locale encoding.

       Some applications (such as the formidable mlterm) work around this by carrying their own replacement functions for character set handling
       with them, and either implementing OS-dependent hacks or doing multiple conversions (which is slow and unreliable in case the OS implements
       encodings slightly different than the terminal emulator).

       The rxvt-unicode author insists that the right way to fix this is in the system libraries once and for all, instead of forcing every app to
       carry complete replacements for them :)

       How can I use rxvt-unicode under cygwin?

       rxvt-unicode should compile and run out of the box on cygwin, using the X11 libraries that come with cygwin. libW11 emulation is no longer
       supported (and makes no sense, either, as it only supported a single font). I recommend starting the X-server in "-multiwindow" or
       "-rootless" mode instead, which will result in similar look&feel as the old libW11 emulation.

       At the time of this writing, cygwin didn't seem to support any multi-byte encodings (you might try "LC_CTYPE=C-UTF-8"), so you are likely
       limited to 8-bit encodings.

       Character widths are not correct.

       urxvt uses the system wcwidth function to know the information about the width of characters, so on systems with incorrect locale data you
       will likely get bad results. Two notorious examples are Solaris 9, where single-width characters like U+2514 are reported as double-width,
       and Darwin 8, where combining chars are reported having width 1.

       The solution is to upgrade your system or switch to a better one. A possibly working workaround is to use a wcwidth implementation like

       http://www.cl.cam.ac.uk/~mgk25/ucs/wcwidth.c

RXVT-UNICODE TECHNICAL REFERENCE
       The rest of this document describes various technical aspects of rxvt-unicode. First the description of supported command sequences,
       followed by pixmap support and last by a description of all features selectable at "configure" time.

   Definitions
       "c" The literal character c (potentially a multi-byte character).

       "C" A single (required) character.

       "Ps"
           A single (usually optional) numeric parameter, composed of one or more digits.

       "Pm"
           A multiple numeric parameter composed of any number of single numeric parameters, separated by ";" character(s).

       "Pt"
           A text parameter composed of printable characters.

   Values
       "ENQ"
           Enquiry (Ctrl-E) = Send Device Attributes (DA) request attributes from terminal. See "ESC [ Ps c".

       "BEL"
           Bell (Ctrl-G)

       "BS"
           Backspace (Ctrl-H)

       "TAB"
           Horizontal Tab (HT) (Ctrl-I)

       "LF"
           Line Feed or New Line (NL) (Ctrl-J)

       "VT"
           Vertical Tab (Ctrl-K) same as "LF"

       "FF"
           Form Feed or New Page (NP) (Ctrl-L) same as "LF"

       "CR"
           Carriage Return (Ctrl-M)

       "SO"
           Shift Out (Ctrl-N), invokes the G1 character set.  Switch to Alternate Character Set

       "SI"
           Shift In (Ctrl-O), invokes the G0 character set (the default).  Switch to Standard Character Set

       "SP"
           Space Character

   Escape Sequences
       "ESC # 8"
           DEC Screen Alignment Test (DECALN)

       "ESC 7"
           Save Cursor (SC)

       "ESC 8"
           Restore Cursor

       "ESC ="
           Application Keypad (SMKX). See also next sequence.

       "ESC >"
           Normal Keypad (RMKX)

           Note: numbers or control functions are generated by the numeric keypad in normal or application mode, respectively (see Key Codes).

       "ESC D"
           Index (IND)

       "ESC E"
           Next Line (NEL)

       "ESC H"
           Tab Set (HTS)

       "ESC M"
           Reverse Index (RI)

       "ESC N"
           Single Shift Select of G2 Character Set (SS2): affects next character only unimplemented

       "ESC O"
           Single Shift Select of G3 Character Set (SS3): affects next character only unimplemented

       "ESC Z"
           Obsolete form of returns: "ESC [ ? 1 ; 2 C" rxvt-unicode compile-time option

       "ESC c"
           Full reset (RIS)

       "ESC n"
           Invoke the G2 Character Set (LS2)

       "ESC o"
           Invoke the G3 Character Set (LS3)

       "ESC ( C"
           Designate G0 Character Set (ISO 2022), see below for values of "C".

       "ESC ) C"
           Designate G1 Character Set (ISO 2022), see below for values of "C".

       "ESC * C"
           Designate G2 Character Set (ISO 2022), see below for values of "C".

       "ESC + C"
           Designate G3 Character Set (ISO 2022), see below for values of "C".

       "ESC $ C"
           Designate Kanji Character Set

           Where "C" is one of:

           C = 0   DEC Special Character and Line Drawing Set
           C = A   United Kingdom (UK)
           C = B   United States (USASCII)
           C = <   Multinational character set unimplemented
           C = 5   Finnish character set unimplemented
           C = C   Finnish character set unimplemented
           C = K   German character set unimplemented

   CSI (Command Sequence Introducer) Sequences
       "ESC [ Ps @"
           Insert "Ps" (Blank) Character(s) [default: 1] (ICH)

       "ESC [ Ps A"
           Cursor Up "Ps" Times [default: 1] (CUU)

       "ESC [ Ps B"
           Cursor Down "Ps" Times [default: 1] (CUD)

       "ESC [ Ps C"
           Cursor Forward "Ps" Times [default: 1] (CUF)

       "ESC [ Ps D"
           Cursor Backward "Ps" Times [default: 1] (CUB)

       "ESC [ Ps E"
           Cursor Down "Ps" Times [default: 1] and to first column

       "ESC [ Ps F"
           Cursor Up "Ps" Times [default: 1] and to first column

       "ESC [ Ps G"
           Cursor to Column "Ps" (HPA)

       "ESC [ Ps;Ps H"
           Cursor Position [row;column] [default: 1;1] (CUP)

       "ESC [ Ps I"
           Move forward "Ps" tab stops [default: 1]

       "ESC [ Ps J"
           Erase in Display (ED)

           Ps = 0   Clear Right and Below (default)
           Ps = 1   Clear Left and Above
           Ps = 2   Clear All

       "ESC [ Ps K"
           Erase in Line (EL)

           Ps = 0   Clear to Right (default)
           Ps = 1   Clear to Left
           Ps = 2   Clear All
           Ps = 3   Like Ps = 0, but is ignored when wrapped
                                                                   (urxvt extension)

       "ESC [ Ps L"
           Insert "Ps" Line(s) [default: 1] (IL)

       "ESC [ Ps M"
           Delete "Ps" Line(s) [default: 1] (DL)

       "ESC [ Ps P"
           Delete "Ps" Character(s) [default: 1] (DCH)

       "ESC [ Ps;Ps;Ps;Ps;Ps T"
           Initiate . unimplemented Parameters are [func;startx;starty;firstrow;lastrow].

       "ESC [ Ps W"
           Tabulator functions

           Ps = 0   Tab Set (HTS)
           Ps = 2   Tab Clear (TBC), Clear Current Column (default)
           Ps = 5   Tab Clear (TBC), Clear All

       "ESC [ Ps X"
           Erase "Ps" Character(s) [default: 1] (ECH)

       "ESC [ Ps Z"
           Move backward "Ps" [default: 1] tab stops

       "ESC [ Ps '"
           See "ESC [ Ps G"

       "ESC [ Ps a"
           See "ESC [ Ps C"

       "ESC [ Ps c"
           Send Device Attributes (DA) "Ps = 0" (or omitted): request attributes from terminal returns: "ESC [ ? 1 ; 2 c" (``I am a VT100 with
           Advanced Video Option'')

       "ESC [ Ps d"
           Cursor to Line "Ps" (VPA)

       "ESC [ Ps e"
           See "ESC [ Ps A"

       "ESC [ Ps;Ps f"
           Horizontal and Vertical Position [row;column] (HVP) [default: 1;1]

       "ESC [ Ps g"
           Tab Clear (TBC)

           Ps = 0   Clear Current Column (default)
           Ps = 3   Clear All (TBC)

       "ESC [ Pm h"
           Set Mode (SM). See "ESC [ Pm l" sequence for description of "Pm".

       "ESC [ Ps i"
           Printing. See also the "print-pipe" resource.

           Ps = 0   print screen (MC0)
           Ps = 4   disable transparent print mode (MC4)
           Ps = 5   enable transparent print mode (MC5)

       "ESC [ Pm l"
           Reset Mode (RM)

           "Ps = 4"

               h   Insert Mode (SMIR)
               l   Replace Mode (RMIR)
           "Ps = 20" (partially implemented)
               h   Automatic Newline (LNM)
               l   Normal Linefeed (LNM)
       "ESC [ Pm m"
           Character Attributes (SGR)

           Pm = 0             Normal (default)

           Pm = 1 / 21        On / Off Bold (bright fg)
           Pm = 3 / 23        On / Off Italic
           Pm = 4 / 24        On / Off Underline
           Pm = 5 / 25        On / Off Slow Blink (bright bg)
           Pm = 6 / 26        On / Off Rapid Blink (bright bg)
           Pm = 7 / 27        On / Off Inverse
           Pm = 8 / 27        On / Off Invisible (NYI)
           Pm = 30 / 40       fg/bg Black
           Pm = 31 / 41       fg/bg Red
           Pm = 32 / 42       fg/bg Green
           Pm = 33 / 43       fg/bg Yellow
           Pm = 34 / 44       fg/bg Blue
           Pm = 35 / 45       fg/bg Magenta
           Pm = 36 / 46       fg/bg Cyan
           Pm = 37 / 47       fg/bg White
           Pm = 38;5 / 48;5   set fg/bg to colour #m (ISO 8613-6)
           Pm = 39 / 49       fg/bg Default
           Pm = 90 / 100      fg/bg Bright Black
           Pm = 91 / 101      fg/bg Bright Red
           Pm = 92 / 102      fg/bg Bright Green
           Pm = 93 / 103      fg/bg Bright Yellow
           Pm = 94 / 104      fg/bg Bright Blue
           Pm = 95 / 105      fg/bg Bright Magenta
           Pm = 96 / 106      fg/bg Bright Cyan
           Pm = 97 / 107      fg/bg Bright White
           Pm = 99 / 109      fg/bg Bright Default

       "ESC [ Ps n"
           Device Status Report (DSR)

           Ps = 5   Status Report ESC [ 0 n (``OK'')
           Ps = 6   Report Cursor Position (CPR) [row;column] as ESC [ r ; c R
           Ps = 7   Request Display Name
           Ps = 8   Request Version Number (place in window title)

       "ESC [ Ps SP q"
           Set Cursor Style (DECSCUSR)

           Ps = 0   Blink Block
           Ps = 1   Blink Block
           Ps = 2   Steady Block
           Ps = 3   Blink Underline
           Ps = 4   Steady Underline
           Ps = 5   Blink Bar (XTerm)
           Ps = 6   Steady Bar (XTerm)

       "ESC [ Ps;Ps r"
           Set Scrolling Region [top;bottom] [default: full size of window] (CSR)

       "ESC [ s"
           Save Cursor (SC)

       "ESC [ Ps;Pt t"
           Window Operations

           Ps = 1      Deiconify (map) window
           Ps = 2      Iconify window
           Ps = 3      ESC [ 3 ; X ; Y t Move window to (X|Y)
           Ps = 4      ESC [ 4 ; H ; W t Resize to WxH pixels
           Ps = 5      Raise window
           Ps = 6      Lower window
           Ps = 7      Refresh screen once
           Ps = 8      ESC [ 8 ; R ; C t Resize to R rows and C columns
           Ps = 11     Report window state (responds with Ps = 1 or Ps = 2)
           Ps = 13     Report window position (responds with Ps = 3)
           Ps = 14     Report window pixel size (responds with Ps = 4)
           Ps = 18     Report window text size (responds with Ps = 7)
           Ps = 19     Currently the same as Ps = 18, but responds with Ps = 9
           Ps = 20     Reports icon label (ESC ] L NAME 234)
           Ps = 21     Reports window title (ESC ] l NAME 234)
           Ps = 24..   Set window height to Ps rows

       "ESC [ u"
           Restore Cursor

       "ESC [ Ps x"
           Request Terminal Parameters (DECREQTPARM)

   DEC Private Modes
       "ESC [ ? Pm h"
           DEC Private Mode Set (DECSET)

       "ESC [ ? Pm l"
           DEC Private Mode Reset (DECRST)

       "ESC [ ? Pm r"
           Restore previously saved DEC Private Mode Values.

       "ESC [ ? Pm s"
           Save DEC Private Mode Values.

       "ESC [ ? Pm t"
           Toggle DEC Private Mode Values (rxvt extension). where

           "Pm = 1" (DECCKM)

               h   Application Cursor Keys
               l   Normal Cursor Keys
           "Pm = 2" (DECANM)
               h   Enter VT52 mode
               l   Enter VT52 mode
           "Pm = 3" (DECCOLM)
               h   132 Column Mode
               l   80 Column Mode
           "Pm = 4" (DECSCLM)
               h   Smooth (Slow) Scroll
               l   Jump (Fast) Scroll
           "Pm = 5" (DECSCNM)
               h   Reverse Video
               l   Normal Video
           "Pm = 6" (DECOM)
               h   Origin Mode
               l   Normal Cursor Mode
           "Pm = 7" (DECAWM)
               h   Wraparound Mode
               l   No Wraparound Mode
           "Pm = 8" (DECARM) unimplemented
               h   Auto-repeat Keys
               l   No Auto-repeat Keys
           "Pm = 9" (X10 XTerm mouse protocol)
               h   Send Mouse X & Y on button press.
               l   No mouse reporting.
           "Pm = 12" (AT&T 610, XTerm)
               h   Blinking cursor (cvvis)
               l   Steady cursor (cnorm)
           "Pm = 25" (DECTCEM)
               h   Visible cursor {cnorm/cvvis}
               l   Invisible cursor {civis}
           "Pm = 30" (rxvt)
               h   scrollBar visible
               l   scrollBar invisible
           "Pm = 35" (rxvt)
               h   Allow XTerm Shift+key sequences
               l   Disallow XTerm Shift+key sequences
           "Pm = 38" unimplemented
               Enter Tektronix Mode (DECTEK)

           "Pm = 40"

               h   Allow 80/132 Mode
               l   Disallow 80/132 Mode
           "Pm = 44" unimplemented
               h   Turn On Margin Bell
               l   Turn Off Margin Bell
           "Pm = 45" unimplemented
               h   Reverse-wraparound Mode
               l   No Reverse-wraparound Mode
           "Pm = 46" unimplemented
           "Pm = 47"
               h   Use Alternate Screen Buffer
               l   Use Normal Screen Buffer

           "Pm = 66" (DECNKM)

               h   Application Keypad (DECKPAM/DECPAM) == ESC =
               l   Normal Keypad (DECKPNM/DECPNM) == ESC >
           "Pm = 67" (DECBKM)
               h   Backspace key sends BS
               l   Backspace key sends DEL
           "Pm = 1000" (X11 XTerm mouse protocol)
               h   Send Mouse X & Y on button press and release.
               l   No mouse reporting.
           "Pm = 1001" (X11 XTerm) unimplemented
               h   Use Hilite Mouse Tracking.

               l   No mouse reporting.
           "Pm = 1002" (X11 XTerm cell motion mouse tracking)
               h   Send Mouse X & Y on button press and release, and motion with a button pressed.
               l   No mouse reporting.
           "Pm = 1003" (X11 XTerm all motion mouse tracking)
               h   Send Mouse X & Y on button press and release, and motion.
               l   No mouse reporting.
           "Pm = 1004" (X11 XTerm focus in/focus out events) unimplemented
               h   Send Mouse focus in/focus out events.
               l   Don'T send focus events.
           "Pm = 1005" (X11 XTerm UTF-8 mouse mode) (Compile frills)
               Try to avoid this mode, it doesn't work sensibly in non-UTF-8 locales. Use mode 1015 instead.

               Unlike XTerm, coordinates larger than 2015) will work fine.

               h   Enable mouse coordinates in locale-specific encoding.
               l   Enable mouse coordinates as binary octets.

           "Pm = 1010" (rxvt)

               h   Don't scroll to bottom on TTY output
               l   Scroll to bottom on TTY output
           "Pm = 1011" (rxvt)
               h   Scroll to bottom when a key is pressed
               l   Don't scroll to bottom when a key is pressed
           "Pm = 1015" (rxvt-unicode) (Compile frills)
               h   Enable urxvt mouse coordinate reporting.
               l   Use old-style CSI M C C C encoding.
               Changes all mouse reporting codes to use decimal parameters instead of octets or characters.

               This mode should be enabled before actually enabling mouse reporting, for semi-obvious reasons.

               The sequences received for various modes are as follows:

                  ESC [ M o o o    !1005, !1015 (three octets)
                  ESC [ M c c c    1005, !1015 (three characters)
                  ESC [ Pm M       1015 (three or more numeric parameters)

               The first three parameters are "code", "x" and "y". Code is the numeric code as for the other modes (but encoded as a decimal
               number, including the additional offset of 32, so you have to subtract 32 first), "x" and "y" are the coordinates (1|1 is the upper
               left corner, just as with cursor positioning).

               Example: Shift-Button-1 press at top row, column 80.

                  ESC [ 37 ; 80 ; 1 M

               One can use this feature by simply enabling it and then looking for parameters to the "ESC [ M" reply - if there are any, this mode
               is active, otherwise one of the old reporting styles is used.

               Other (to be implemented) reply sequences will use a similar encoding.

               In the future, more parameters might get added (pixel coordinates for example - anybody out there who needs this?).

           "Pm = 1021" (rxvt)

               h   Bold/italic implies high intensity (see option -is)
               l   Font styles have no effect on intensity (Compile styles)
           "Pm = 1047" (X11 XTerm alternate screen buffer)
               h   Use Alternate Screen Buffer
               l   Use Normal Screen Buffer - clear Alternate Screen Buffer if returning from it
           "Pm = 1048" (X11 XTerm alternate DECSC)
               h   Save cursor position
               l   Restore cursor position
           "Pm = 1049" (X11 XTerm 1047 + 1048)
               h   Use Alternate Screen Buffer - clear Alternate Screen Buffer if switching to it
               l   Use Normal Screen Buffer
           "Pm = 2004" (X11 XTerm bracketed paste mode)
               h   Enable bracketed paste mode - prepend / append to the pasted text the control sequences ESC [ 200 ~ / ESC [ 201 ~
               l   Disable bracketed paste mode

   XTerm Operating System Commands
       "ESC ] Ps;Pt ST"
           Set XTerm Parameters. 8-bit ST: 0x9c, 7-bit ST sequence: ESC \ (0x1b, 0x5c), backwards compatible terminator BEL (0x07) is also
           accepted. any octet can be escaped by prefixing it with SYN (0x16, ^V).

           Ps = 0     Change Icon Name and Window Title to Pt
           Ps = 1     Change Icon Name to Pt
           Ps = 2     Change Window Title to Pt
           Ps = 3     If Pt starts with a ?, query the (STRING) property of the window and return it. If Pt contains a =, set the named property to the given value, else delete the specified property.
           Ps = 4     Pt is a semi-colon separated sequence of one or more semi-colon separated number/name pairs, where number is an index to a colour and name is the name of a colour. Each pair causes the numbered colour to be changed to name. Numbers 0-7 corresponds to low-intensity (normal) colours and 8-15 corresponds to high-intensity colours. 0=black, 1=red, 2=green, 3=yellow, 4=blue, 5=magenta, 6=cyan, 7=white
           Ps = 10    Change colour of text foreground to Pt
           Ps = 11    Change colour of text background to Pt
           Ps = 12    Change colour of text cursor foreground to Pt

           Ps = 13    Change colour of mouse foreground to Pt
           Ps = 17    Change background colour of highlight characters to Pt
           Ps = 19    Change foreground colour of highlight characters to Pt
           Ps = 20    Change background pixmap parameters (see section BACKGROUND IMAGE) (Compile pixbuf).
           Ps = 39    Change default foreground colour to Pt. [deprecated, use 10]
           Ps = 46    Change Log File to Pt unimplemented
           Ps = 49    Change default background colour to Pt. [deprecated, use 11]
           Ps = 50    Set fontset to Pt, with the following special values of Pt (rxvt) #+n change up n #-n change down n if n is missing of 0, a value of 1 is used empty change to font0 n change to font n
           Ps = 55    Log all scrollback buffer and all of screen to Pt [disabled]
           Ps = 701   Change current locale to Pt, or, if Pt is ?, return the current locale (Compile frills).
           Ps = 702   Request version if Pt is ?, returning rxvt-unicode, the resource name, the major and minor version numbers, e.g. ESC ] 702 ; rxvt-unicode ; urxvt ; 7 ; 4 ST.
           Ps = 704   Change colour of italic characters to Pt
           Ps = 705   Change background pixmap tint colour to Pt (Compile transparency).
           Ps = 706   Change colour of bold characters to Pt
           Ps = 707   Change colour of underlined characters to Pt
           Ps = 708   Change colour of the border to Pt
           Ps = 710   Set normal fontset to Pt. Same as Ps = 50.
           Ps = 711   Set bold fontset to Pt. Similar to Ps = 50 (Compile styles).
           Ps = 712   Set italic fontset to Pt. Similar to Ps = 50 (Compile styles).
           Ps = 713   Set bold-italic fontset to Pt. Similar to Ps = 50 (Compile styles).
           Ps = 720   Move viewing window up by Pt lines, or clear scrollback buffer if Pt = 0 (Compile frills).
           Ps = 721   Move viewing window down by Pt lines, or clear scrollback buffer if Pt = 0 (Compile frills).
           Ps = 777   Call the perl extension with the given string, which should be of the form extension:parameters (Compile perl).

BACKGROUND IMAGE
       For the BACKGROUND IMAGE XTerm escape sequence "ESC ] 20 ; Pt ST" the value of "Pt" can be one of the following commands:

       "?" display scale and position in the title

       ";WxH+X+Y"
           change scale and/or position

       "FILE;WxH+X+Y"
           change background image

Mouse Reporting
       "ESC [ M <b> <x> <y>"
           report mouse position

       The lower 2 bits of "<b>" indicate the button:

       Button = "(<b> - SPACE) & 3"

           0   Button1 pressed
           1   Button2 pressed
           2   Button3 pressed
           3   button released (X11 mouse report)

       The upper bits of "<b>" indicate the modifiers when the button was pressed and are added together (X11 mouse report only):

       State = "(<b> - SPACE) & ~3"

           4    Shift
           8    Meta
           16   Control
           32   Motion Notify
           32   Double Click (rxvt extension), disabled by default
           64   Button1 is actually Button4, Button2 is actually Button5 etc.
           Col = "<x> - SPACE"

           Row = "<y> - SPACE"

Key Codes
       Note: Shift + F1-F10 generates F11-F20

       For the keypad, use Shift to temporarily toggle Application Keypad mode and use Num_Lock to override Application Keypad mode, i.e. if
       Num_Lock is on the keypad is in normal mode. Also note that the values of BackSpace, Delete may have been compiled differently on your
       system.

                      Normal       Shift         Control      Ctrl+Shift
       Tab            ^I           ESC [ Z       ^I           ESC [ Z
       BackSpace      ^?           ^?            ^H           ^H
       Find           ESC [ 1 ~    ESC [ 1 $     ESC [ 1 ^    ESC [ 1 @
       Insert         ESC [ 2 ~    paste         ESC [ 2 ^    ESC [ 2 @
       Execute        ESC [ 3 ~    ESC [ 3 $     ESC [ 3 ^    ESC [ 3 @
       Select         ESC [ 4 ~    ESC [ 4 $     ESC [ 4 ^    ESC [ 4 @
       Prior          ESC [ 5 ~    scroll-up     ESC [ 5 ^    ESC [ 5 @
       Next           ESC [ 6 ~    scroll-down   ESC [ 6 ^    ESC [ 6 @
       Home           ESC [ 7 ~    ESC [ 7 $     ESC [ 7 ^    ESC [ 7 @
       End            ESC [ 8 ~    ESC [ 8 $     ESC [ 8 ^    ESC [ 8 @
       Delete         ESC [ 3 ~    ESC [ 3 $     ESC [ 3 ^    ESC [ 3 @
       F1             ESC [ 11 ~   ESC [ 23 ~    ESC [ 11 ^   ESC [ 23 ^
       F2             ESC [ 12 ~   ESC [ 24 ~    ESC [ 12 ^   ESC [ 24 ^

       F3             ESC [ 13 ~   ESC [ 25 ~    ESC [ 13 ^   ESC [ 25 ^
       F4             ESC [ 14 ~   ESC [ 26 ~    ESC [ 14 ^   ESC [ 26 ^
       F5             ESC [ 15 ~   ESC [ 28 ~    ESC [ 15 ^   ESC [ 28 ^
       F6             ESC [ 17 ~   ESC [ 29 ~    ESC [ 17 ^   ESC [ 29 ^
       F7             ESC [ 18 ~   ESC [ 31 ~    ESC [ 18 ^   ESC [ 31 ^
       F8             ESC [ 19 ~   ESC [ 32 ~    ESC [ 19 ^   ESC [ 32 ^
       F9             ESC [ 20 ~   ESC [ 33 ~    ESC [ 20 ^   ESC [ 33 ^
       F10            ESC [ 21 ~   ESC [ 34 ~    ESC [ 21 ^   ESC [ 34 ^
       F11            ESC [ 23 ~   ESC [ 23 $    ESC [ 23 ^   ESC [ 23 @
       F12            ESC [ 24 ~   ESC [ 24 $    ESC [ 24 ^   ESC [ 24 @
       F13            ESC [ 25 ~   ESC [ 25 $    ESC [ 25 ^   ESC [ 25 @
       F14            ESC [ 26 ~   ESC [ 26 $    ESC [ 26 ^   ESC [ 26 @
       F15 (Help)     ESC [ 28 ~   ESC [ 28 $    ESC [ 28 ^   ESC [ 28 @
       F16 (Menu)     ESC [ 29 ~   ESC [ 29 $    ESC [ 29 ^   ESC [ 29 @
       F17            ESC [ 31 ~   ESC [ 31 $    ESC [ 31 ^   ESC [ 31 @
       F18            ESC [ 32 ~   ESC [ 32 $    ESC [ 32 ^   ESC [ 32 @
       F19            ESC [ 33 ~   ESC [ 33 $    ESC [ 33 ^   ESC [ 33 @
       F20            ESC [ 34 ~   ESC [ 34 $    ESC [ 34 ^   ESC [ 34 @
                                                              Application
       Up             ESC [ A      ESC [ a       ESC O a      ESC O A
       Down           ESC [ B      ESC [ b       ESC O b      ESC O B
       Right          ESC [ C      ESC [ c       ESC O c      ESC O C
       Left           ESC [ D      ESC [ d       ESC O d      ESC O D
       KP_Enter       ^M                                      ESC O M
       KP_F1          ESC O P                                 ESC O P
       KP_F2          ESC O Q                                 ESC O Q
       KP_F3          ESC O R                                 ESC O R
       KP_F4          ESC O S                                 ESC O S
       KP_Multiply    *                                       ESC O j
       KP_Add         +                                       ESC O k
       KP_Separator   ,                                       ESC O l
       KP_Subtract    -                                       ESC O m
       KP_Decimal     .                                       ESC O n
       KP_Divide      /                                       ESC O o
       KP_0           0                                       ESC O p
       KP_1           1                                       ESC O q
       KP_2           2                                       ESC O r
       KP_3           3                                       ESC O s
       KP_4           4                                       ESC O t
       KP_5           5                                       ESC O u
       KP_6           6                                       ESC O v
       KP_7           7                                       ESC O w
       KP_8           8                                       ESC O x
       KP_9           9                                       ESC O y

CONFIGURE OPTIONS
       General hint: if you get compile errors, then likely your configuration hasn't been tested well. Either try with "--enable-everything" or
       use the default configuration (i.e. no "--enable-xxx" or "--disable-xxx" switches). Of course, you should always report when a combination
       doesn't work, so it can be fixed. Marc Lehmann <rxvt@schmorp.de>.

       All

       --enable-everything
           Add (or remove) support for all non-multichoice options listed in "./configure --help", except for "--enable-assert" and
           "--enable-256-color".

           You can specify this and then disable options you do not like by following this with the appropriate "--disable-..." arguments, or you
           can start with a minimal configuration by specifying "--disable-everything" and than adding just the "--enable-..." arguments you want.

       --enable-xft (default: on)
           Add support for Xft (anti-aliased, among others) fonts. Xft fonts are slower and require lots of memory, but as long as you don't use
           them, you don't pay for them.

       --enable-font-styles (default: on)
           Add support for bold, italic and bold italic font styles. The fonts can be set manually or automatically.

       --with-codesets=CS,... (default: all)
           Compile in support for additional codeset (encoding) groups ("eu", "vn" are always compiled in, which includes most 8-bit character
           sets). These codeset tables are used for driving X11 core fonts, they are not required for Xft fonts, although having them compiled in
           lets rxvt-unicode choose replacement fonts more intelligently. Compiling them in will make your binary bigger (all of together cost
           about 700kB), but it doesn't increase memory usage unless you use a font requiring one of these encodings.

           all      all available codeset groups
           zh       common chinese encodings
           zh_ext   rarely used but very big chinese encodings
           jp       common japanese encodings
           jp_ext   rarely used but big japanese encodings
           kr       korean encodings

       --enable-xim (default: on)
           Add support for XIM (X Input Method) protocol. This allows using alternative input methods (e.g. kinput2) and will also correctly set
           up the input for people using dead keys or compose keys.

       --enable-unicode3 (default: off)
           Recommended to stay off unless you really need non-BMP characters.

           Enable direct support for displaying unicode codepoints above 65535 (the basic multilingual page). This increases storage requirements
           per character from 2 to 4 bytes. X11 fonts do not yet support these extra characters, but Xft does.

           Please note that rxvt-unicode can store unicode code points >65535 even without this flag, but the number of such characters is limited
           to a few thousand (shared with combining characters, see next switch), and right now rxvt-unicode cannot display them (input/output and
           cut&paste still work, though).

       --enable-combining (default: on)
           Enable automatic composition of combining characters into composite characters. This is required for proper viewing of text where
           accents are encoded as separate unicode characters. This is done by using precomposed characters when available or creating new pseudo-
           characters when no precomposed form exists.

           Without --enable-unicode3, the number of additional precomposed characters is somewhat limited (the 6400 private use characters will be
           (ab-)used). With --enable-unicode3, no practical limit exists.

           This option will also enable storage (but not display) of characters beyond plane 0 (>65535) when --enable-unicode3 was not specified.

           The combining table also contains entries for arabic presentation forms, but these are not currently used. Bug me if you want these to
           be used (and tell me how these are to be used...).

       --enable-fallback[=CLASS] (default: Rxvt)
           When reading resource settings, also read settings for class CLASS. To disable resource fallback use --disable-fallback.

       --with-res-name=NAME (default: urxvt)
           Use the given name as default application name when reading resources. Specify --with-res-name=rxvt to replace rxvt.

       --with-res-class=CLASS (default: URxvt)
           Use the given class as default application class when reading resources. Specify --with-res-class=Rxvt to replace rxvt.

       --enable-utmp (default: on)
           Write user and tty to utmp file (used by programs like w) at start of rxvt execution and delete information when rxvt exits.

       --enable-wtmp (default: on)
           Write user and tty to wtmp file (used by programs like last) at start of rxvt execution and write logout when rxvt exits.  This option
           requires --enable-utmp to also be specified.

       --enable-lastlog (default: on)
           Write user and tty to lastlog file (used by programs like lastlogin) at start of rxvt execution.  This option requires --enable-utmp to
           also be specified.

       --enable-pixbuf (default: on)
           Add support for GDK-PixBuf to be used for background images.  It adds support for many file formats including JPG, PNG, TIFF, GIF, XPM,
           BMP, ICO and TGA.

       --enable-startup-notification (default: on)
           Add support for freedesktop startup notifications. This allows window managers to display some kind of progress indicator during
           startup.

       --enable-transparency (default: on)
           Add support for using the root pixmap as background to simulate transparency.  Note that this feature depends on libXrender and on the
           availability of the RENDER extension in the X server.

       --enable-fading (default: on)
           Add support for fading the text when focus is lost.

       --enable-rxvt-scroll (default: on)
           Add support for the original rxvt scrollbar.

       --enable-next-scroll (default: on)
           Add support for a NeXT-like scrollbar.

       --enable-xterm-scroll (default: on)
           Add support for an Xterm-like scrollbar.

       --disable-backspace-key
           Removes any handling of the backspace key by us - let the X server do it.

       --disable-delete-key
           Removes any handling of the delete key by us - let the X server do it.

       --disable-resources
           Removes any support for resource checking.

       --disable-swapscreen
           Remove support for secondary/swap screen.

       --enable-frills (default: on)
           Add support for many small features that are not essential but nice to have. Normally you want this, but for very small binaries you
           may want to disable this.

           A non-exhaustive list of features enabled by "--enable-frills" (possibly in combination with other switches) is:

             MWM-hints
             EWMH-hints (pid, utf8 names) and protocols (ping)
             urgency hint
             separate underline colour (-underlineColor)
             settable border widths and borderless switch (-w, -b, -bl)
             visual depth selection (-depth)
             settable extra linespacing (-lsp)
             iso-14755 5.1 (basic) support
             tripleclickwords (-tcw)
             settable insecure mode (-insecure)
             keysym remapping support
             cursor blinking and underline cursor (-bc, -uc)
             XEmbed support (-embed)
             user-pty (-pty-fd)
             hold on exit (-hold)
             compile in built-in block graphics
             skip builtin block graphics (-sbg)
             separate highlight colour (-highlightColor, -highlightTextColor)
             extended mouse reporting modes (1005 and 1015).
             visual selection via -visual and -depth.

           It also enables some non-essential features otherwise disabled, such as:

             some round-trip time optimisations
             nearest colour allocation on pseudocolor screens
             UTF8_STRING support for selection
             sgr modes 90..97 and 100..107
             backindex and forwardindex escape sequences
             view change/zero scrollback escape sequences
             locale switching escape sequence
             window op and some xterm/OSC escape sequences
             rectangular selections
             trailing space removal for selections
             verbose X error handling

       --enable-iso14755 (default: on)
           Enable extended ISO 14755 support (see urxvt(1)).  Basic support (section 5.1) is enabled by "--enable-frills", while support for 5.2,
           5.3 and 5.4 is enabled with this switch.

       --enable-keepscrolling (default: on)
           Add support for continual scrolling of the display when you hold the mouse button down on a scrollbar arrow.

       --enable-selectionscrolling (default: on)
           Add support for scrolling when the selection moves to the top or bottom of the screen.

       --enable-mousewheel (default: on)
           Add support for scrolling via mouse wheel or buttons 4 & 5.

       --enable-slipwheeling (default: on)
           Add support for continual scrolling (using the mouse wheel as an accelerator) while the control key is held down.  This option requires
           --enable-mousewheel to also be specified.

       --enable-smart-resize (default: off)
           Add smart growth/shrink behaviour when resizing.  This should keep the window corner which is closest to a corner of the screen in a
           fixed position.

       --enable-text-blink (default: on)
           Add support for blinking text.

       --enable-pointer-blank (default: on)
           Add support to have the pointer disappear when typing or inactive.

       --enable-perl (default: on)
           Enable an embedded perl interpreter. See the urxvtperl(3) manpage for more info on this feature, or the files in src/perl/ for the
           extensions that are installed by default.  The perl interpreter that is used can be specified via the "PERL" environment variable when
           running configure. Even when compiled in, perl will not be initialised when all extensions have been disabled "-pe "" --perl-ext-common
           """, so it should be safe to enable from a resource standpoint.

       --enable-assert (default: off)
           Enables the assertions in the code, normally disabled. This switch is only useful when developing rxvt-unicode.

       --enable-256-color (default: off)
           Force use of so-called 256 colour mode, to work around buggy applications that do not support termcap/terminfo, or simply improve
           support for applications hardcoding the xterm 256 colour table.

           This switch breaks termcap/terminfo compatibility to "TERM=rxvt-unicode", and consequently sets "TERM" to "rxvt-unicode-256color" by
           default (doc/etc/ contains termcap/terminfo definitions for both).

           It also results in higher memory usage and can slow down urxvt dramatically when more than six fonts are in use by a terminal instance.

       --with-name=NAME (default: urxvt)
           Set the basename for the installed binaries, resulting in "urxvt", "urxvtd" etc.). Specify "--with-name=rxvt" to replace with "rxvt".

       --with-term=NAME (default: rxvt-unicode)
           Change the environmental variable for the terminal to NAME.

       --with-terminfo=PATH
           Change the environmental variable for the path to the terminfo tree to PATH.

       --with-x
           Use the X Window System (pretty much default, eh?).

AUTHORS
       Marc Lehmann <rxvt@schmorp.de> converted this document to pod and reworked it from the original Rxvt documentation, which was done by Geoff
       Wing <gcw@pobox.com>, who in turn used the XTerm documentation and other sources.

9.22                                                                2016-06-26                                                            urxvt(7)
