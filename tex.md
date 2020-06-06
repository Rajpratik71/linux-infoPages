File: web2c.info,  Node: tex invocation,  Next: Initial TeX,  Up: TeX

4.1 `tex' invocation
====================

TeX (usually invoked as `tex') formats the given text and commands, and
outputs a corresponding device-independent representation of the
typeset document.  This section merely describes the options available
in the Web2c implementation.  For a complete description of the TeX
typesetting language, see `The TeXbook' (*note References::).

   TeX, Metafont, and MetaPost process the command line (described
here) and determine their memory dump (fmt) file in the same way (*note
Memory dumps::).  Synopses:

     tex [OPTION]... [TEXNAME[.tex]] [TEX-COMMANDS]
     tex [OPTION]... \FIRST-LINE
     tex [OPTION]... &FMT ARGS

   TeX searches the usual places for the main input file TEXNAME (*note
Supported file formats: (kpathsea)Supported file formats.), extending
TEXNAME with `.tex' if necessary.  To see all the relevant paths, set
the environment variable `KPATHSEA_DEBUG' to `-1' before running the
program.

   After TEXNAME is read, TeX processes any remaining TEX-COMMANDS on
the command line as regular TeX input.  Also, if the first non-option
argument begins with a TeX escape character (usually `\'), TeX
processes all non-option command-line arguments as a line of regular
TeX input.

   If no arguments or options are specified, TeX prompts for an input
file name with `**'.

   TeX writes the main DVI output to the file `BASETEXNAME.dvi', where
BASETEXNAME is the basename of TEXNAME, or `texput' if no input file
was specified.  A DVI file is a device-independent binary
representation of your TeX document.  The idea is that after running
TeX, you translate the DVI file using a separate program to the
commands for a particular output device, such as a PostScript printer
(*note Introduction: (dvips)Top.) or an X Window System display (see
xdvi(1)).

   TeX also reads TFM files for any fonts you load in your document with
the `\font' primitive.  By default, it runs an external program named
`mktextfm' to create any nonexistent TFM files.  You can disable this
at configure-time or runtime (*note mktex configuration:
(kpathsea)mktex configuration.).  This is enabled mostly for the sake
of the EC fonts, which can be generated at any size.

   TeX can write output files, via the `\openout' primitive; this opens
a security hole vulnerable to Trojan horse attack: an unwitting user
could run a TeX program that overwrites, say, `~/.rhosts'.  (MetaPost
has a `write' primitive with similar implications).  To alleviate this
and similar problems the functions `kpathsea_out_name_ok' and
`kpathsea_in_name_ok' from the Kpathse library (*note Calling sequence:
(kpathsea)Calling sequence.) are used to determine if a given filename
is acceptable to be opened for output or input, depending on the
setting of the configuration variables `openout_any' and `openin_any':
`a' (for "any", the default for `openin_any'), `r' (for "restricted"),
or `p' (for "paranoid", the default for `openout_any').

   In any case, all `\openout' filenames are recorded in the log file,
except those opened on the first line of input, which is processed when
the log file has not yet been opened.

   The program accepts the following options, as well as the standard
`-help' and `-version' (*note Common options::):
`-enc'
`-[no]-file-line-error'
`-fmt=FMTNAME'
`-halt-on-error'
`-ini'
`-interaction=STRING'
`-ipc'
`-ipc-start'
`-jobname=STRING'
`-kpathsea-debug=NUMBER'
`-[no]parse-first-line'
`-output-directory'
`-progname=STRING'
`-recorder'
`-translate-file=TCXFILE'
`-8bit'
     These options are common to TeX, Metafont, and MetaPost.  *Note
     Common options::.

`-enc'
     Enable encTeX extensions, such as `\mubyte'.  This can be used to
     support Unicode UTF-8 input encoding.  See
     `http://www.olsak.net/enctex.html'.

`-ipc'
`-ipc-start'
     With either option, TeX writes its DVI output to a socket as well
     as to the usual `.dvi' file.  With `-ipc-start', TeX also opens a
     server program at the other end to read the output.  *Note IPC and
     TeX: IPC and TeX.

     These options are available only if the `--enable-ipc' option was
     specified to `configure' during installation of Web2c.

`-mktex=FILETYPE'
`-no-mktex=FILETYPE'
     Turn on or off the `mktex' script associated with FILETYPE.  For
     TeX proper, FILETYPE can only be `tex' and `tfm', but for pdfTeX
     and luaTeX, it can also be `pk'.

`-mltex'
     If we are `INITEX' (*note Initial and virgin::), enable MLTeX
     extensions such as `\charsubdef'.  Implicitly set if the program
     name is `mltex'.  *Note MLTeX: MLTeX.

`-output-comment=STRING'
     Use STRING as the DVI file comment.  Ordinarily, this comment
     records the date and time of the TeX run, but if you are doing
     regression testing, you may not want the DVI file to have this
     spurious difference.  This is also taken from the environment
     variable and config file value `output_comment'.

`-shell-escape'
`-no-shell-escape'
`-shell-restricted'
     Enable, or disable, or enable with restrictions the
     `\write18{SHELL-COMMAND}' feature for external executing shell
     commands.  *Note Shell escapes::.

`-enable-write18'
`-disable-write18'
     Synonyms for `-shell-escape' and `-no-shell-escape', for
     compatibility with MiKTeX.  (MiKTeX also accepts both pairs of
     options.)  *Note Shell escapes::.

`-src-specials'
`-src-specials=STRING'
     This option makes TeX output specific source information using
     `\special' commands in the DVI file. These `\special' track the
     current file name and line number.

     Using the first form of this option, the `\special' commands are
     inserted automatically.

     In the second form of the option, STRING is a comma separated list
     of the following values: `cr', `display', `hbox', `math', `par',
     `parend', `vbox'. You can use this list to specify where you want
     TeX to output such commands. For example, `-src-specials=cr,math'
     will output source information every line and every math formula.

     These commands  can  be used with  the  appropriate DVI viewer and
     text editor to switch from the current position in the editor to
     the same position in the viewer and back from the viewer to the
     editor.

     This option works by inserting `\special' commands into the token
     stream, and thus in principle these additional tokens can be
     recovered or seen by the tricky-enough macros.  If you run across
     a case, let us know, because this counts as a bug.  However, such
     bugs are very hard to fix, requiring significant changes to TeX,
     so please don't count on it.

     Redefining `\special' will not affect the functioning of this
     option.  The commands inserted into the token stream are
     hard-coded to always use the `\special' primitive.

     TeX does not pass the trip test when this option is enabled.


