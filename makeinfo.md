File: texinfo,  Node: Invoking texi2any,  Next: texi2any Printed Output,  Prev: Reference Implementation,  Up: Generic Translator texi2any

22.2 Invoking 'texi2any'/'makeinfo' from a Shell
================================================

To process a Texinfo file, invoke 'texi2any' or 'makeinfo' (the two
names are synonyms for the same program; we'll use the names
interchangeably) followed by the name of the Texinfo file.  Also select
the format you want to output with the appropriate command line option
(default is Info).  Thus, to create the Info file for Bison, type the
following to the shell:

     texi2any --info bison.texinfo

  You can specify more than one input file name; each is processed in
turn.  If an input file name is '-', standard input is read.

  The 'texi2any' program accept many options.  Perhaps the most basic
are those that change the output format.  By default, 'texi2any' outputs
Info.

  Each command line option is either a long name preceded by '--' or a
single letter preceded by '-'.  You can use abbreviations for the long
option names as long as they are unique.

  For example, you could use the following shell command to create an
Info file for 'bison.texinfo' in which lines are filled to only 68
columns:

     texi2any --fill-column=68 bison.texinfo

  You can write two or more options in sequence, like this:

     texi2any --no-split --fill-column=70 ...

(This would keep the Info file together as one possibly very long file
and would also set the fill column to 70.)

  The options are (approximately in alphabetical order):

'--commands-in-node-names'
     This option now does nothing, but remains for compatibility.  (It
     used to ensure that @-commands in node names were expanded
     throughout the document, especially '@value'.  This is now done by
     default.)

'--conf-dir=PATH'
     Prepend PATH to the directory search list for finding customization
     files that may be loaded with '--init-file' (see below).  The PATH
     value can be a single directory, or a list of several directories
     separated by the usual path separator character (':' on Unix-like
     systems, ';' on Windows).

'--css-include=FILE'
     When producing HTML, literally include the contents of FILE, which
     should contain W3C cascading style sheets specifications, in the
     '<style>' block of the HTML output.  If FILE is '-', read standard
     input.  *Note HTML CSS::.

'--css-ref=URL'
     When producing HTML, add a '<link>' tag to the output which
     references a cascading style sheet at URL.  This allows using
     standalone style sheets.

'-D VAR'
     Cause the Texinfo variable VAR to be defined.  This is equivalent
     to '@set VAR' in the Texinfo file (*note @set @clear @value::).

'--disable-encoding'
'--enable-encoding'
     By default, or with '--enable-encoding', output accented and
     special characters in Info and plain text output based on
     '@documentencoding'.  With '--disable-encoding', 7-bit ASCII
     transliterations are output.  *Note @documentencoding::, and *note
     Inserting Accents::.

'--docbook'
     Generate Docbook output (rather than Info).

'--document-language=LANG'
     Use LANG to translate Texinfo keywords which end up in the output
     document.  The default is the locale specified by the
     '@documentlanguage' command if there is one, otherwise English
     (*note @documentlanguage::).

'--dvi'
     Generate a TeX DVI file using 'texi2dvi', rather than Info (*note
     texi2any Printed Output::).

'--dvipdf'
     Generate a PDF file using 'texi2dvi --dvipdf', rather than Info
     (*note texi2any Printed Output::).

'--error-limit=LIMIT'
'-e LIMIT'
     Report LIMIT errors before aborting (on the assumption that
     continuing would be useless); default 100.

'--fill-column=WIDTH'
'-f WIDTH'
     Specify the maximum number of columns in a line; this is the
     right-hand edge of a line.  Paragraphs that are filled will be
     filled to this width.  (Filling is the process of breaking up and
     connecting lines so that lines are the same length as or shorter
     than the number specified as the fill column.  Lines are broken
     between words.)  The default value is 72.

'--footnote-style=STYLE'
'-s STYLE'
     Set the footnote style to STYLE: either 'end' for the end node
     style (the default) or 'separate' for the separate node style.  The
     value set by this option overrides the value set in a Texinfo file
     by an '@footnotestyle' command (*note Footnote Styles::).

     When the footnote style is 'separate', 'makeinfo' makes a new node
     containing the footnotes found in the current node.  When the
     footnote style is 'end', 'makeinfo' places the footnote references
     at the end of the current node.

     In HTML, when the footnote style is 'end', or if the output is not
     split, footnotes are put at the end of the output.  If set to
     'separate', and the output is split, they are placed in a separate
     file.

'--force'
'-F'
     Ordinarily, if the input file has errors, the output files are not
     created.  With this option, they are preserved.

'--help'
'-h'
     Print a message with available options and basic usage, then exit
     successfully.

'--html'
     Generate HTML output (rather than Info).  By default, the HTML
     output is split into one output file per Texinfo source node, and
     the split output is written into a subdirectory based on the name
     of the top-level Info file.  *Note Generating HTML::.

'-I PATH'
     Append PATH to the directory search list for finding files that are
     included using the '@include' command.  By default, 'texi2any'
     searches only the current directory.  If PATH is not given, the
     current directory is appended.  The PATH value can be a single
     directory or a list of several directories separated by the usual
     path separator character (':' on Unix-like systems, ';' on
     Windows).

'--ifdocbook'
'--ifhtml'
'--ifinfo'
'--ifplaintext'
'--iftex'
'--ifxml'
     For the given format, process '@ifFORMAT' and '@FORMAT' commands,
     and do not process '@ifnotFORMAT', regardless of the format being
     output.  For instance, if '--iftex' is given, then '@iftex' and
     '@tex' blocks will be read, and '@ifnottex' blocks will be ignored.

'--info'
     Generate Info output.  By default, if the output file contains more
     than about 300,000 bytes, it is split into shorter subfiles of
     about that size.  The name of the output file and any subfiles is
     determined by '@setfilename' (*note @setfilename::).  *Note Tag and
     Split Files::.

'--init-file=FILE'
     Load FILE as code to modify the behavior and output of the
     generated manual.  It is customary to use the '.pm' or the '.init'
     extensions for these customization files, but that is not enforced;
     the FILE name can be anything.  The '--conf-dir' option (see above)
     can be used to add to the list of directories in which these
     customization files are searched for.

'--internal-links=FILE'
     In HTML mode, output a tab-separated file containing three columns:
     the internal link to an indexed item or item in the table of
     contents, the name of the index (or table of contents) in which it
     occurs, and the term which was indexed or entered.  The items are
     in the natural sorting order for the given element.  This dump can
     be useful for post-processors.

'--macro-expand=FILE'
'-E FILE'
     Output the Texinfo source, with all Texinfo macros expanded, to
     FILE.  Normally, the result of macro expansion is used internally
     by 'makeinfo' and then discarded.

'--no-headers'
     Do not include menus or node separator lines in the output.

     When generating Info, this is the same as using '--plaintext',
     resulting in a simple plain text file.  Furthermore, '@setfilename'
     is ignored, and output is to standard output unless overridden with
     '-o'.  (This behavior is for backward compatibility.)

     When generating HTML, and output is split, also output navigation
     links only at the beginning of each file.  If output is not split,
     do not include navigation links at the top of each node at all.
     *Note Generating HTML::.

'--no-ifdocbook'
'--no-ifhtml'
'--no-ifinfo'
'--no-ifplaintext'
'--no-iftex'
'--no-ifxml'
     For the given format, do not process '@ifFORMAT' and '@FORMAT'
     commands, and do process '@ifnotFORMAT', regardless of the format
     being output.  For instance, if '--no-ifhtml' is given, then
     '@ifhtml' and '@html' blocks will not be read, and '@ifnothtml'
     blocks will be.

'--no-node-files'
'--node-files'
     When generating HTML, create redirection files for anchors and any
     nodes not already output with the file name corresponding to the
     node name (*note HTML Xref Node Name Expansion::).  This makes it
     possible for section- and chapter-level cross-manual references to
     succeed (*note HTML Xref Configuration::).

     If the output is split, this is enabled by default.  If the output
     is not split, '--node-files' enables the creation of the
     redirection files, in addition to the monolithic main output file.
     '--no-node-files' suppresses the creation of redirection files in
     any case.  This option has no effect with any output format other
     than HTML.  *Note Generating HTML::.

'--no-number-footnotes'
     Suppress automatic footnote numbering.  By default, footnotes are
     numbered sequentially within a node, i.e., the current footnote
     number is reset to 1 at the start of each node.

'--no-number-sections'
'--number-sections'
     With '--number_sections' (the default), output chapter, section,
     and appendix numbers as in printed manuals.  This works only with
     hierarchically-structured manuals.  You should specify
     '--no-number-sections' if your manual is not normally structured.

'--no-pointer-validate'
'--no-validate'
     Suppress the pointer-validation phase of 'makeinfo'--a dangerous
     thing to do.  This can also be done with the '@novalidate' command
     (*note Use TeX::).  Normally, consistency checks are made to ensure
     that cross references can be resolved, etc.  *Note Pointer
     Validation::.

'--no-warn'
     Suppress warning messages (but not error messages).

'--output=FILE'
'-o FILE'
     Specify that the output should be directed to FILE.  This overrides
     any file name specified in an '@setfilename' command found in the
     Texinfo source.  If neither '@setfilename' nor this option are
     specified, the input file name is used to determine the output
     name.  *Note @setfilename::.

     If FILE is '-', output goes to standard output and '--no-split' is
     implied.

     If FILE is a directory or ends with a '/' the usual rules are used
     to determine the output file name (namely, use '@setfilename' or
     the input file name) but the files are written to the FILE
     directory.  For example, 'makeinfo -o bar/ foo.texi', with or
     without '--no-split', will write 'bar/foo.info', and possibly other
     files, under 'bar/'.

     When generating HTML and output is split, FILE is used as the name
     for the directory into which all files are written.  For example,
     'makeinfo -o bar --html foo.texi' will write 'bar/index.html',
     among other files.

'--output-indent=VAL'
     This option now does nothing, but remains for compatibility.  (It
     used to alter indentation in XML/Docbook output.)

'-P PATH'
     Prepend PATH to the directory search list for '@include'.  If PATH
     is not given, the current directory is prepended.  See '-I' above.

'--paragraph-indent=INDENT'
'-p INDENT'
     Set the paragraph indentation style to INDENT.  The value set by
     this option overrides the value set in a Texinfo file by an
     '@paragraphindent' command (*note @paragraphindent::).  The value
     of INDENT is interpreted as follows:

     'asis'
          Preserve any existing indentation (or lack thereof) at the
          beginnings of paragraphs.

     '0' or 'none'
          Delete any existing indentation.

     NUM
          Indent each paragraph by NUM spaces.

     The default is to indent by two spaces, except for paragraphs
     following a section heading, which are not indented.

'--pdf'
     Generate a PDF file using 'texi2dvi --pdf', rather than Info (*note
     texi2any Printed Output::).

'--plaintext'
     Output a plain text file (rather than Info): do not include menus
     or node separator lines in the output.  This results in a
     straightforward plain text file that you can (for example) send in
     email without complications, or include in a distribution (for
     example, an 'INSTALL' file).

     With this option, '@setfilename' is ignored and the output goes to
     standard output by default; this can be overridden with '-o'.

'--ps'
     Generate a PostScript file using 'texi2dvi --ps', rather than Info
     (*note texi2any Printed Output::).

'--set-customization-variable VAR=VALUE'
'-c VAR=VALUE'
     Set the customization variable VAR to VALUE.  The '=' is optional,
     but both VAR and VALUE must be quoted to the shell as necessary so
     the result is a single word.  Many aspects of 'texi2any' behavior
     and output may be controlled by customization variables, beyond
     what can be set in the document by @-commands and with other
     command line switches.  *Note Customization Variables::.

'--split=HOW'
'--no-split'
     When generating Info, by default large output files are split into
     smaller subfiles, of approximately 300k bytes.  When generating
     HTML, by default each output file contains one node (*note
     Generating HTML::).  '--no-split' suppresses this splitting of the
     output.

     Alternatively, '--split=HOW' may be used to specify at which level
     the HTML output should be split.  The possible values for HOW are:

     'chapter'
          The output is split at '@chapter' and other sectioning
          @-commands at this level ('@appendix', etc.).

     'section'
          The output is split at '@section' and similar.

     'node'
          The output is split at every node.  This is the default.

'--split-size=NUM'
     Keep Info files to at most NUM characters if possible; default is
     300,000.  (However, a single node will never be split across Info
     files.)

'--transliterate-file-names'
     Enable transliteration of 8-bit characters in node names for the
     purpose of file name creation.  *Note HTML Xref 8-bit Character
     Expansion::.

'-U VAR'
     Cause VAR to be undefined.  This is equivalent to '@clear VAR' in
     the Texinfo file (*note @set @clear @value::).

'--verbose'
     Cause 'makeinfo' to display messages saying what it is doing.
     Normally, 'makeinfo' only outputs messages if there are errors or
     warnings.

'--version'
'-V'
     Print the version number, then exit successfully.

'--Xopt STR'
     Pass STR (a single shell word) to 'texi2dvi'; may be repeated
     (*note texi2any Printed Output::).

'--xml'
     Generate Texinfo XML output (rather than Info).

  'makeinfo' also reads the environment variable 'TEXINFO_OUTPUT_FORMAT'
to determine the output format, if not overridden by a command line
option.  The value should be one of:

     docbook  dvi  dvipdf  html  info  pdf  plaintext  ps  xml

  If not set or otherwise specified, Info output is the default.

  The customization variable of the same name is also read; if set, that
overrides an environment variable setting, but not a command-line
option.  *Note Customization Variables for @-Commands::.

