File: dvips.info,  Node: Invoking Dvips,  Next: Paper size and landscape,  Prev: Installation,  Up: Top

3 Invoking Dvips
****************

Dvips reads a DVI file as output by (for example) TeX, and converts it
to PostScript, taking care of builtin or downloaded PostScript fonts,
font reencoding, color, etc.  These features are described in other
chapters in this document.

   There many ways to control Dvips' behavior: configuration files,
environment variables, and command-line options.

* Menu:

* Basic usage::
* Command-line options::
* Environment variables::
* Config files::

File: dvips.info,  Node: Basic usage,  Next: Command-line options,  Up: Invoking Dvips

3.1 Basic usage of Dvips
========================

To use Dvips at its simplest, simply type

     dvips foo

where `foo.dvi' is the output of TeX that you want to print.  The
default output is to a corresponding file `foo.ps'; Dvips may also have
been locally configured to output directly to a printer by default.

   If you use fonts that have not been used on your system before, they
may be automatically generated; this process can take a few minutes, so
progress reports appear by default.  The next time that document is
printed, these fonts will have been saved in the proper directories, so
printing will go much faster.  (If Dvips tries to endlessly generate the
same fonts over and over again, it hasn't been installed properly.
*Note Unable to generate fonts: (kpathsea)Unable to generate fonts.)

   Many options are available (see the next section).  For a brief
summary of available options, just type

     dvips --help

File: dvips.info,  Node: Command-line options,  Next: Environment variables,  Prev: Basic usage,  Up: Invoking Dvips

3.2 Command-line options
========================

Dvips has a plethora of command line options.  Reading through this
section will give a good idea of the capabilities of the driver.

* Menu:

* Option summary::              Quick listing, from Dvips --help.
* Option details::              More information about each option.

File: dvips.info,  Node: Option summary,  Next: Option details,  Up: Command-line options

3.2.1 Option summary
--------------------

Here is a handy summary of the options; it is printed out when you run
Dvips with no arguments or with the standard `--help' option.  

Usage: dvips [OPTION]... FILENAME[.dvi]
Convert DVI input files to PostScript.
See http://tug.org/dvips/ for the full manual and other information.

Options:
-a*  Conserve memory, not time       -A   Print only odd (TeX) pages
-b # Page copies, for posters e.g.   -B   Print only even (TeX) pages
-c # Uncollated copies               -C # Collated copies
-d # Debugging                       -D # Resolution
-e # Maxdrift value                  -E*  Try to create EPSF
-f*  Run as filter                   -F*  Send control-D at end
                                     -G*  Shift low chars to higher pos.
-h f Add header file
-i*  Separate file per section
-j*  Download fonts partially
-k*  Print crop marks                -K*  Pull comments from inclusions
-l # Last page
-m*  Manual feed                     -M*  Don't make fonts
-mode s Metafont device name
-n # Maximum number of pages         -N*  No structured comments
-noomega  Disable Omega extensions
-noptex   Disable pTeX extensions
-o f Output file                     -O c Set/change paper offset
-p # First page                      -P s Load config.$s
-pp l Print only pages listed
-q*  Run quietly
-r*  Reverse order of pages          -R*  Run securely
-s*  Enclose output in save/restore  -S # Max section size in pages
-t s Paper format                    -T c Specify desired page size
-u s PS mapfile                      -U*  Disable string param trick
-v   Print version number and quit   -V*  Send downloadable PS fonts as PK
-x # Override dvi magnification      -X # Horizontal resolution
-y # Multiply by dvi magnification   -Y # Vertical resolution
-z*  Hyper PS                        -Z*  Compress bitmap fonts
    # = number   f = file   s = string  * = suffix, `0' to turn off
    c = comma-separated dimension pair (e.g., 3.2in,-32.1cm)
    l = comma-separated list of page ranges (e.g., 1-4,7-9)

Email bug reports to tex-k@mail.tug.org.

File: dvips.info,  Node: Option details,  Prev: Option summary,  Up: Command-line options

3.2.2 Option details
--------------------

Many of the parameterless options listed here can be turned off by
suffixing the option with a zero (`0'); for instance, to turn off page
reversal, use `-r0'.  Such options are marked with a trailing `*'.

`-'
     Read additional options from standard input after processing the
     command line.

`--help'
     Print a usage message and exit.

`--version'
     Print the version number and exit.

`-a*'
     Conserve memory by making three passes over the DVI file instead
     of two and only loading those characters actually used.  Generally
     only useful on machines with a very limited amount of memory, like
     some PCs.

`-A'
     Print only the odd pages.  This option uses TeX page numbers, not
     physical page numbers.

`-b NUM'
     Generate NUM copies of each page, but duplicating the page body
     rather than using the `/#copies' PostScript variable.  This can be
     useful in conjunction with a header file setting `bop-hook' to do
     color separations or other neat tricks.

`-B'
     Print only the even pages.  This option uses TeX page numbers, not
     physical page numbers.

`-c NUM'
     Generate NUM consecutive copies of every page, i.e., the output is
     uncollated.  This merely sets the builtin PostScript variable
     `/#copies'.

`-C NUM'
     Generate NUM copies, but collated (by replicating the data in the
     PostScript file).  Slower than the `-c' option, but easier on the
     hands, and faster than resubmitting the same PostScript file
     multiple times.

`-d NUM'
     Set the debug flags, showing what Dvips (thinks it) is doing.
     This will work unless Dvips has been compiled without the `DEBUG'
     option (not recommended).  *Note Debug options::, for the possible
     values of NUM.  Use `-d -1' as the first option for maximum output.

`-D NUM'
     Set both the horizontal and vertical resolution to NUM, given in
     dpi (dots per inch). This affects the choice of bitmap fonts that
     are loaded and also the positioning of letters in resident
     PostScript fonts. Must be between 10 and 10000.  This affects both
     the horizontal and vertical resolution.  If a high resolution
     (something greater than 400 dpi, say) is selected, the `-Z' flag
     should probably also be used.  If you are using fonts made with
     Metafont, such as Computer Modern, `mktexpk' needs to know about
     the value for NUM that you use or Metafont will fail.  See the file
     `ftp://ftp.tug.org/tex/modes.mf' for a list of resolutions and mode
     names for most devices.

`-e NUM'
     Maximum drift in pixels of each character from its `true'
     resolution-independent position on the page. The default value of
     this parameter is resolution dependent (it is the number of
     entries in the list [100, 200, 300, 400, 500, 600, 800, 1000,
     1200, 1600, 2000, 2400, 2800, 3200, ...] that are less than or
     equal to the resolution in dots per inch). Allowing individual
     characters to `drift' from their correctly rounded positions by a
     few pixels, while regaining the true position at the beginning of
     each new word, improves the spacing of letters in words.

`-E*'
     Generate an EPSF file with a tight bounding box.  This only looks
     at marks made by characters and rules, not by any included
     graphics.  In addition, it gets the glyph metrics from the TFM
     file, so characters that print outside their enclosing TFM box may
     confuse it.  In addition, the bounding box might be a bit too
     loose if the character glyph has significant left or right side
     bearings.  Nonetheless, this option works well enough for creating
     small EPSF files for equations or tables or the like.  (Of course,
     Dvips output, especially when using bitmap fonts, is
     resolution-dependent and thus does not make very good EPSF files,
     especially if the images are to be scaled; use these EPSF files
     with care.)  For multiple page input files, also specify `-i' to
     get each page as a separate EPSF file; otherwise, all the pages
     are overlaid in the single output file.

`-f*'
     Run as a filter.  Read the DVI file from standard input and write
     the PostScript to standard output.  The standard input must be
     seekable, so it cannot be a pipe.  If your input must be a pipe,
     write a shell script that copies the pipe output to a temporary
     file and then points Dvips at this file.  This option also
     disables the automatic reading of the `PRINTER' environment
     variable; use `-P$PRINTER' after the `-f' to read it anyway.  It
     also turns off the automatic sending of control-D if it was turned
     on with the `-F' option or in the configuration file; use `-F'
     after the `-f' to send it anyway.

`-F*'
     Write control-D (ASCII code 4) as the very last character of the
     PostScript file.  This is useful when Dvips is driving the printer
     directly instead of working through a spooler, as is common on
     personal systems.  On systems shared by more than one person, this
     is not recommended.

`-G*'
     Shift non-printing characters (ASCII 0-32, 127) to higher-numbered
     positions.  This was useful to work around bugs in old versions of
     Adobe's PDF reader.  It's more likely to cause problems nowadays.

`-h NAME'
     Prepend NAME as an additional header file, or, if NAME is `-',
     suppress all header files.  Any definitions in the header file get
     added to the PostScript `userdict'.

`-i*'
     Make each section be a separate file; a "section" is a part of the
     document processed independently, most often created to avoid
     memory overflow.  The filenames are created replacing the suffix
     of the supplied output file name by a three-digit sequence number.
     This option is most often used in conjunction with the `-S' option
     which sets the maximum section length in pages; if `-i' is
     specified and `-S' is not, each page is output as a separate file.
     For instance, some phototypesetters cannot print more than ten or
     so consecutive pages before running out of steam; these options
     can be used to automatically split a book into ten-page sections,
     each to its own file.

`-j*'
     Download only needed characters from Type 1 fonts. This is the
     default in the current release.  Some debugging flags trace this
     operation (*note Debug options::).  You can also control partial
     downloading on a per-font basis (*note psfonts.map::).

`-k*'
     Print crop marks.  This option increases the paper size (which
     should be specified, either with a paper size special or with the
     `-T' option) by a half inch in each dimension.  It translates each
     page by a quarter inch and draws cross-style crop marks.  It is
     mostly useful with typesetters that can set the page size
     automatically.  This works by downloading `crop.pro'.

`-K*'
     Remove comments in included PostScript graphics, font files, and
     headers; only necessary to get around bugs in spoolers or
     PostScript post-processing programs.  Specifically, the `%%Page'
     comments, when left in, often cause difficulties.  Use of this
     flag can cause other graphics to fail, however, since the
     PostScript header macros from some software packages read portion
     the input stream line by line, searching for a particular comment.

`-l [=]NUM'
     The last page printed will be the first one numbered NUM. Default
     is the last page in the document.  If NUM is prefixed by an equals
     sign, then it (and the argument to the `-p' option, if specified)
     is treated as a physical (absolute) page number, rather than a
     value to compare with the TeX `\count0' values stored in the DVI
     file.  Thus, using `-l =9' will end with the ninth page of the
     document, no matter what the pages are actually numbered.

`-m*'
     Specify manual feed, if supported by the output device.

`-mode MODE'
     Use MODE as the Metafont device name for path searching and font
     generation.  This overrides any value from configuration files.
     With the default paths, explicitly specifying the mode also makes
     the program assume the fonts are in a subdirectory named MODE.
     *Note TeX directory structure: (kpathsea)TeX directory structure.
     If Metafont does not understand the MODE name, see *note Unable to
     generate fonts: (kpathsea)Unable to generate fonts.

`-M*'
     Turns off automatic font generation (`mktexpk').  If `mktexpk',
     the invocation is appended to a file `missfont.log' (by default)
     in the current directory.  You can then execute the log file to
     create the missing files after fixing the problem.  If the current
     directory is not writable and the environment variable or
     configuration file value `TEXMFOUTPUT' is set, its value is used.
     Otherwise, nothing is written.  The name `missfont.log' is
     overridden by the `MISSFONT_LOG' environment variable or
     configuration file value.

`-n NUM'
     Print at most NUM pages. Default is 100000.

`-N*'
     Turns off generation of structured comments such as `%%Page'; this
     may be necessary on some systems that try to interpret PostScript
     comments in weird ways, or on some PostScript printers.  Old
     versions of TranScript in particular cannot handle modern
     Encapsulated PostScript.  Beware: This also disables page
     movement, etc., in PostScript viewers such as Ghostview.

`-noomega'
     Disable the use of Omega extensions when interpreting DVI files.
     By default, the additional opcodes `129' and `134' are recognized
     by Dvips as Omega or pTeX extensions and interpreted as requests
     to set 2-byte characters.

`-noptex'
     Disable the use of pTeX extensions when interpreting DVI files.  By
     default, the additional opcodes `130' and `135' are recognized by
     Dvips as Omega extensions and interpreted as requests to set
     3-byte characters, and `255' as request to change the typesetting
     direction.

     The only drawback is that the virtual font array will (at least
     temporarily) require 65536 or more positions instead of the default
     256 positions, i.e., the memory requirements of Dvips will be
     somewhat larger.  If you find this unacceptable or encounter
     another problem with the Omega or pTeX extensions, you can switch
     off the pTeX extension by using `-noptex', or both by using
     `-noomega' (but please do send a bug report if you find such
     problems, *note Bugs: (kpathsea)Bugs.).

`-o NAME'
     Send output to the file NAME.  If `-o' is specified without NAME
     (i.e., it is the last thing on the command line), the default is
     `FILE.ps' where the input DVI file was `FILE.dvi'.  If `-o' isn't
     given at all, the configuration file default is used.

     If NAME is `-', output goes to standard output.  If the first
     character of NAME is `!' or `|', then the remainder will be used
     as an argument to `popen'; thus, specifying `|lpr' as the output
     file will automatically queue the file for printing as usual.
     (The MS-DOS version will print to the local printer device `PRN'
     when NAME is `|lpr' and a program by that name cannot be found.)

     `-o' disables the automatic reading of the `PRINTER' environment
     variable, and turns off the automatic sending of control-D.  See
     the `-f' option for how to override this.

`-O X-OFFSET,Y-OFFSET'
     Move the origin by X-OFFSET,Y-OFFSET, a comma-separated pair of
     dimensions such as `.1in,-.3cm' (*note papersize special::).  The
     origin of the page is shifted from the default position (of one
     inch down, one inch to the right from the upper left corner of the
     paper) by this amount.  This is usually best specified in the
     printer-specific configuration file.

     This is useful for a printer that consistently offsets output
     pages by a certain amount.  You can use the file `testpage.tex' to
     determine the correct value for your printer.  Be sure to do
     several runs with the same `O' value--some printers vary widely
     from run to run.

     If your printer offsets every other page consistently, instead of
     every page, your best recourse is to use `bop-hook' (*note
     PostScript hooks::).

`-p [=]NUM'
     The first page printed will be the first one numbered NUM. Default
     is the first page in the document.  If NUM is prefixed by an
     equals sign, then it (and the argument to the `-l' option, if
     specified) is treated as a physical (absolute) page number, rather
     than a value to compare with the TeX `\count0' values stored in the
     DVI file.  Thus, using `-p =3' will start with the third page of
     the document, no matter what the pages are actually numbered.

`-pp FIRST-LAST'
     Print pages FIRST through LAST; equivalent to `-p FIRST -l LAST',
     except that multiple `-pp' options accumulate, unlike `-p' and
     `-l'.  The `-' separator can also be `:'.

`-P PRINTER'
     Read the configuration file `config.PRINTER' (`PRINTER.cfg' on
     MS-DOS), which can set the output name (most likely `o |lpr
     -PPRINTER'), resolution, Metafont mode, and perhaps font paths and
     other printer-specific defaults.  It works best to put sitewide
     defaults in the one master `config.ps' file and only things that
     vary printer to printer in the `config.PRINTER' files; `config.ps'
     is read before `config.PRINTER'.

     A configuration file for creating Adobe PDF files is provided in
     `config.pdf' and can be loaded with `-Ppdf', it will try to
     include Type1 outline fonts into the PostScript file (*note
     Hypertext caveats::).

     If no `-P' or `-o' is given, the environment variable `PRINTER' is
     checked.  If that variable exists, and a corresponding
     `config.PRINTER' (`PRINTER.cfg' on MS-DOS) file exists, it is read.
     *Note Configuration file searching::.

`-q*'
     Run quietly.  Don't chatter about pages converted, etc. to standard
     output; report no warnings (only errors) to standard error.

`-r*'
     Output pages in reverse order.  By default, page 1 is output first.

`-R'
     Run securely.  `-R2' disables both shell command execution in
     `\special' (via ``', *note Dynamic creation of graphics::) and
     config files (via the `E' option, *note Configuration file
     commands::) and opening of any absolute or `..'-relative
     filenames.  `-R1', the default, forbids shell escapes but allows
     absolute filenames.  `-R0' allows both.

`-s*'
     Enclose the output in a global save/restore pair.  This causes the
     file to not be truly conformant, and is thus not recommended, but
     is useful if you are driving a deficient printer directly and thus
     don't care too much about the portability of the output to other
     environments.

`-S NUM'
     Set the maximum number of pages in each `section'.  This option is
     most commonly used with the `-i' option; see its description above
     for more information.

`-t PAPERTYPE'
     Set the paper type to PAPERTYPE, usually defined in one of the
     configuration files, along with the appropriate PostScript code to
     select it (*note Config file paper sizes::).
        - You can also specify a PAPERTYPE of `landscape', which
          rotates a document by 90 degrees.

        - To rotate a document whose paper type is not the default, you
          can use the `-t' option twice, once for the paper type, and
          once for `landscape'.

        - In general, you should not use any `-t' option when using a
          `papersize' special, which some LaTeX packages (e.g.,
          `hyperref') insert.

        - One exception is when using a nonstandard paper size that is
          not already defined in `config.ps'; in this case, you need to
          specify `-t unknown'.

        - Another exception is when producing multi-page files for
          further processing; use `-t nopaper' to omit any paper size
          information in the output.  (If you just have a single page
          document, you can use `-E' to get pure EPSF output.)

`-T HSIZE,VSIZE'
     Set the paper size to (HSIZE,VSIZE), a comma-separated pair of
     dimensions such as `.1in,-.3cm' (*note papersize special::).  It
     overrides any paper size special in the DVI file.  Be careful, as
     the paper size will stick to a predefined size if there is one
     close enough. To disable this behavior, use `-tunknown'.

`-u PSMAPFILE'
     Set PSMAPFILE to be the file that dvips uses for looking up
     PostScript font aliases.  If PSMAPFILE begins with a `+'
     character, then the rest of the name is used as the name of the
     map file, and the map file is appended to the list of map files
     (instead of replacing the list).  In either case, if the name has
     no extension, then `.map' is added at the end.

`-U*'
     Disable a PostScript virtual memory-saving optimization that
     stores the character metric information in the same string that is
     used to store the bitmap information.  This is only necessary when
     driving the Xerox 4045 PostScript interpreter, which has a bug
     that puts garbage on the bottom of each character.  Not
     recommended unless you must drive this printer.

`-v'
     Print the dvips version number and exit.

`-V*'
     Download non-resident PostScript fonts as bitmaps.  This requires
     use of `mtpk' or `gsftopk' or `pstopk' or some combination thereof
     to generate the required bitmap fonts; these programs are supplied
     with Dvips.  The bitmap must be put into `psfonts.map' as the
     downloadable file for that font.  This is useful only for those
     fonts for which you do not have real outlines, being downloaded to
     printers that have no resident fonts, i.e., very rarely.

`-x NUM'
     Set the magnification ratio to NUM/1000. Overrides the
     magnification specified in the DVI file.  Must be between 10 and
     100000.  It is recommended that you use standard magstep values
     (1095, 1200, 1440, 1728, 2074, 2488, 2986, and so on) to help
     reduce the total number of PK files generated.  NUM may be a real
     number, not an integer, for increased precision.

`-X NUM'
     Set the horizontal resolution in dots per inch to NUM.

`-y NUM'
     Set the magnification ratio to NUM/1000 times the magnification
     specified in the DVI file.  See `-x' above.

`-Y NUM'
     Set the vertical resolution in dots per inch to NUM.  

`-z*'
     Pass `html' hyperdvi specials through to the output for eventual
     distillation into PDF.  This is not enabled by default to avoid
     including the header files unnecessarily, and use of temporary
     files in creating the output.  *Note Hypertext::.

`-Z*'
     Compress bitmap fonts in the output file, thereby reducing the
     size of what gets downloaded.  Especially useful at high
     resolutions or when very large fonts are used.  May slow down
     printing, especially on early 68000-based PostScript printers.
     Generally recommend today, and can be enabled in the configuration
     file (*note Configuration file commands::).


File: dvips.info,  Node: Environment variables,  Next: Config files,  Prev: Command-line options,  Up: Invoking Dvips

3.3 Environment variables
=========================

Dvips looks for many environment variables, to define search paths and
other things.  The path variables are read as needed, after all
configuration files are read, so they override values in the
configuration files.  (Except for `TEXCONFIG', which defines where the
configuration files themselves are found.)

   *Note Path specifications: (kpathsea)Path specifications, for
details of interpretation of path and other environment variables
common to all Kpathsea-using programs.  Only the environment variables
specific to Dvips are mentioned here.

`DVIPSDEBUG'
     Write the absolute path names of any configuration or map files to
     standard output, for debugging.  This isn't done by default because
     these files are read even before the banner is printed.  For
     voluminous additional debugging, set the environment variable
     `KPATHSEA_DEBUG' to `-1' (*note Debugging: (kpathsea)Debugging.).
     (If `KPATHSEA_DEBUG' is set to any value, it automatically turns
     on `DVIPSDEBUG'.)

`DVIPSFONTS'
     Default path to search for all fonts.  Overrides all the font path
     config file options and other environment variables (*note
     Supported file formats: (kpathsea)Supported file formats.).

`DVIPSHEADERS'
     Default path to search for PostScript header files.  Overrides the
     `H' config file option (*note Configuration file commands::).

`DVIPSMAKEPK'
     Overrides `mktexpk' as the name of the program to invoke to create
     missing PK fonts.  You can change the arguments passed to the
     `mktexpk' program with the `MAKETEXPK' environment variable; *note
     MakeTeX script arguments: (kpathsea)MakeTeX script arguments.

`DVIPSRC'
     Specifies the name of the startup file (*note Configuration file
     searching::) which is read after `config.ps' but before any
     printer-specific configuration files.

`DVIPSSIZES'
     Last-resort sizes for scaling of unfound fonts.  Overrides the `R'
     definition in config files (*note Configuration file commands::).

`PRINTER'
     Determine the default printer configuration file.  (Dvips itself
     does not use `PRINTER' to determine the output destination in any
     way.)

`TEXCONFIG'
     Path to search for Dvips' `config.PRINTER' configuration files,
     including the base `config.ps'.  Using this single environment
     variable, you can override everything else.  (The printer-specific
     configuration files are called `PRINTER.cfg' on MS-DOS, but
     `config.ps' is called by that name on all platforms.)

`TEXPICTS'
     Path to search for included graphics files.  Overrides the `S'
     config file option (*note Configuration file commands::).  If not
     set, `TEXINPUTS' is looked for.  *Note Supported file formats:
     (kpathsea)Supported file formats.


File: dvips.info,  Node: Config files,  Prev: Environment variables,  Up: Invoking Dvips

3.4 Dvips configuration files
=============================

This section describes in detail the Dvips-specific `config.*' device
configuration files (called `*.cfg' on MS-DOS), which override the
`texmf.cnf' configuration files generic to Kpathsea which Dvips also
reads (*note Config files: (kpathsea)Config files.).

   For information about installing these files, including a prototype
file you can copy, *note config.ps installation::.

* Menu:

* Configuration file searching:: Where config.* files are searched for.
* Configuration file commands::  What can go in a config.* file.

File: dvips.info,  Node: Configuration file searching,  Next: Configuration file commands,  Up: Config files

3.4.1 Configuration file searching
----------------------------------

The Dvips program loads many different configuration files, so that
parameters can be set globally across the system, on a per-device basis,
or individually by each user.

  1. Dvips first reads (if it exists) `config.ps'; it is searched for
     along the path for Dvips configuration files, as described in
     *note Supported file formats: (kpathsea)Supported file formats.

  2. A user-specific startup file is loaded, so individual users can
     override any options set in the global file.  The environment
     variable `DVIPSRC', if defined, is used as the specification of
     the startup file.  If this variable is undefined, Dvips uses a
     platform-specific default name.  On Unix Dvips looks for the
     default startup file under the name `$HOME/.dvipsrc', which is in
     the user's home directory.  On MS-DOS and MS-Windows, where users
     generally don't have their private directories, the startup file
     is called `dvips.ini' and it is searched for along the path for
     Dvips configuration files (as described in *note Supported file
     formats: (kpathsea)Supported file formats.); users are expected to
     set this path as they see fit for their taste.

  3. The command line is read and parsed: if the `-PDEVICE' option is
     encountered, at that point `config.DEVICE' is loaded.  Thus, the
     printer configuration file can override anything in the site-wide
     or user configuration file, and it can also override options in
     the command line up to the point that the `-P' option was
     encountered.  (On MS-DOS, the printer configuration files are
     called `DEVICE.cfg', since DOS doesn't allow more than 3 characters
     after the dot in filenames.)

  4. If no `-P' option was specified, and also the `-o' and `-f'
     command line options were not used, Dvips checks the environment
     variable `PRINTER'.  If it exists, then `config.$PRINTER'
     (`$PRINTER.cfg' on MS-DOS) is loaded (if it exists).


   Because the `.dvipsrc' file is read before the printer-specific
configuration files, individual users cannot override settings in the
latter.  On the other hand, the `TEXCONFIG' path usually includes the
current directory, and can in any case be set to anything, so the users
can always define their own printer-specific configuration files to be
found before the system's.

   A few command-line options are treated specially, in that they are
not overridden by configuration files:

`-D'
     As well as setting the resolution, this unsets the mode, if the
     mode was previously set from a configuration file.  If
     `config.$PRINTER' is read, however, any `D' or `M' lines from
     there will take effect.

`-mode'
     This overrides any mode setting (`M' line) in configuration files.
     `-mode' does not affect the resolution.

`-o'
     This overrides any output setting (`o' line) in configuration
     files.


   The purpose of these special cases is to (1) minimize the chance of
having a mismatched mode and resolution (which `mktexpk' cannot
resolve), and (2) let command-line options override config files where
possible.

File: dvips.info,  Node: Configuration file commands,  Prev: Configuration file searching,  Up: Config files

3.4.2 Configuration file commands
---------------------------------

Most of the configuration file commands are similar to corresponding
command line options, but there are a few exceptions.  When they are the
same, we omit the description here.

   As with command line options, many may be turned off by suffixing the
letter with a zero (`0').

   Within a configuration file, empty lines, and lines starting with a
space, asterisk, equal sign, percent sign, or pound sign are ignored.
There is no provision for continuation lines.

`@ NAME HSIZE VSIZE'
     Define paper sizes.  *Note Config file paper sizes::.

`a*'
     Memory conservation.  Same as `-a', *note Option details::.

`b #COPIES'
     Multiple copies.  Same as `-b', *note Option details::.

`c FILENAME'
     Include FILENAME as an additional configuration file, read
     immediately.

`D DPI'
     Output resolution.  Same as `-D', *note Option details::.

`e NUM'
     Max drift.  Same as `-e', *note Option details::.

`E COMMAND'
     Executes the command listed with `system'(3); can be used to get
     the current date into a header file for inclusion, for instance.
     Possibly dangerous; this may be disabled, in which case a warning
     will be printed if the option is used (and warnings are not
     suppressed).

`f*'
`F'
     Run as a filter.  Same as `-f', *note Option details::.

`G*'
     Shift low-numbered characters; obsolete.  Same as `-G', *note
     Option details::.

`h HEADER'
     Prepend HEADER to output.  Same as `h-', *note Option details::.

`H PATH'
     Use PATH to search for PostScript header files.  The environment
     variable `DVIPSHEADERS' overrides this.

`i N'
     Make multiple output files.  Same as `-i -S N', *note Option
     details::.

`j*'
     Partially download Type 1 fonts.  Same as `-j', *note Option
     details::.

`K*'
     Remove comments from included PostScript files.  Same as `-K',
     *note Option details::.

`m NUM'
     Declare NUM as the memory available for fonts and strings in the
     printer.  Default is 180000.  This value must be accurate if memory
     conservation and document splitting is to work correctly.  To
     determine this value, send the following file to the printer:

          %! Hey, we're PostScript
          /Times-Roman findfont 30 scalefont setfont 144 432 moveto
          vmstatus exch sub 40 string cvs show pop showpage

     The number printed by this file is the total memory free; it is
     usually best to tell Dvips that the printer has slightly less
     memory, because many programs download permanent macros that can
     reduce the memory in the printer.  Some systems or printers can
     dynamically increase the memory available to a PostScript
     interpreter, in which case this file might return a ridiculously
     low number; for example, the NeXT computer and Ghostscript.  In
     these cases, a value of one million works fine.

`M MODE'
     Metafont mode.  Same as `-mode', *note Option details::.

`N*'
     Disable structured comments.  Beware: This also turns off
     displaying page numbers or changing to specific pagenumbers in
     PostScript viewers.  Same as `-N', *note Option details::.

`o NAME'
     Send output to NAME.  Same as `-o', *note Option details::.  In
     the file `config.foo', a setting like this is probably appropriate:
          o |lpr -Pfoo
     The MS-DOS version will emulate spooling to `lpr' by printing to
     the local printer device `PRN' if it doesn't find an executable
     program by that name in the current directory or along the `PATH'.

`O XOFF,YOFF'
     Origin offset.  Same as `-O', *note Option details::.

`p [+]NAME'
     Examine NAME for PostScript font aliases.  Default is
     `psfonts.map'.  This option allows you to specify different
     resident fonts that different printers may have.  If NAME starts
     with a `+' character, then the rest of the name (after any leading
     spaces) is used as an additional map file; thus, it is possible to
     have local map files pointed to by local configuration files that
     append to the global map file.  This can be used for font families.

`P PATH'
     Use PATH to search for bitmap PK font files is PATH.  The
     `PKFONTS', `TEXPKS', `GLYPHFONTS', and `TEXFONTS' environment
     variables override this.  *Note Supported file formats:
     (kpathsea)Supported file formats.

`q*'
`Q'
     Run quietly.  Same as `-q', *note Option details::.

`r*'
     Page reversal.  Same as `-r', *note Option details::.

`R NUM1 NUM2 ...'
     Define the list of default resolutions for PK fonts.  If a font
     size actually used in a document is not available and cannot be
     created, Dvips will scale the font found at the closest of these
     resolutions to the requested size, using PostScript scaling.  The
     resulting output may be ugly, and thus a warning is issued.  To
     turn this last-resort scaling off, use a line with just the `R'
     and no numbers.

     The given numbers must be sorted in increasing order; any number
     smaller than the preceding one is ignored.  This is because it is
     better to scale a font up than down; scaling down can obliterate
     small features in the character shape.

     The environment and config file values `DVIPSSIZES' or `TEXSIZES'
     override this configuration file setting.

     If no `R' settings or environment variables are specified, a list
     compiled in during installation is used. This default list is
     defined by the Makefile variable `default_texsizes', defined in
     the file `make/paths.make'.

`s*'
     Output global save/restore.  Same as `-s', *note Option details::.

`S PATH'
     Use PATH to search for special illustrations (Encapsulated
     PostScript files or psfiles).  The `TEXPICTS' and then `TEXINPUTS'
     environment variables override this.

`T PATH'
     Use PATH to search for TFM files.  The `TFMFONTS' and then
     `TEXFONTS' environment variables overrides this.  This path is used
     for resident fonts and fonts that can't otherwise be found.

`U*'
     Work around bug in Xerox 4045 printer.  Same as `-U', *note Option
     details::.

`V PATH'
     Use PATH to search for virtual font files.  This may be
     device-dependent if you use virtual fonts to simulate actual fonts
     on different devices.

`W [STRING]'
     If STRING is supplied, write it to standard error after reading
     all the configuration files; with no STRING, cancel any previous
     `W' message.  This is useful in the default configuration file to
     remind users to specify a printer, for instance, or to notify users
     about special characteristics of a particular printer.

`X NUM'
     Horizontal resolution.  Same as `-X' (*note Option details::).

`Y NUM'
     Vertical resolution.  Same as `-Y' (*note Option details::).

`Z*'
     Compress bitmap fonts.  Same as `-Z' (*note Option details::).

`z*'
     Disables execution of system commands, like `-R' (*note Option
     details::).  If `-R' is specified on the command line, that takes
     precedence.


