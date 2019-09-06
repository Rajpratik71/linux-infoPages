File: coreutils.info,  Node: ptx invocation,  Next: tsort invocation,  Prev: comm invocation,  Up: Operating on sorted files

7.5 `ptx': Produce permuted indexes
===================================

`ptx' reads a text file and essentially produces a permuted index, with
each keyword in its context.  The calling sketch is either one of:

     ptx [OPTION ...] [FILE ...]
     ptx -G [OPTION ...] [INPUT [OUTPUT]]

   The `-G' (or its equivalent: `--traditional') option disables all
GNU extensions and reverts to traditional mode, thus introducing some
limitations and changing several of the program's default option values.
When `-G' is not specified, GNU extensions are always enabled.  GNU
extensions to `ptx' are documented wherever appropriate in this
document.  *Note Compatibility in ptx::, for the full list.

   Individual options are explained in the following sections.

   When GNU extensions are enabled, there may be zero, one or several
FILEs after the options.  If there is no FILE, the program reads the
standard input.  If there is one or several FILEs, they give the name
of input files which are all read in turn, as if all the input files
were concatenated.  However, there is a full contextual break between
each file and, when automatic referencing is requested, file names and
line numbers refer to individual text input files.  In all cases, the
program outputs the permuted index to the standard output.

   When GNU extensions are _not_ enabled, that is, when the program
operates in traditional mode, there may be zero, one or two parameters
besides the options.  If there are no parameters, the program reads the
standard input and outputs the permuted index to the standard output.
If there is only one parameter, it names the text INPUT to be read
instead of the standard input.  If two parameters are given, they give
respectively the name of the INPUT file to read and the name of the
OUTPUT file to produce.  _Be very careful_ to note that, in this case,
the contents of file given by the second parameter is destroyed.  This
behavior is dictated by System V `ptx' compatibility; GNU Standards
normally discourage output parameters not introduced by an option.

   Note that for _any_ file named as the value of an option or as an
input text file, a single dash `-' may be used, in which case standard
input is assumed.  However, it would not make sense to use this
convention more than once per program invocation.

* Menu:

* General options in ptx::      Options which affect general program behavior.
* Charset selection in ptx::    Underlying character set considerations.
* Input processing in ptx::     Input fields, contexts, and keyword selection.
* Output formatting in ptx::    Types of output format, and sizing the fields.
* Compatibility in ptx::

File: coreutils.info,  Node: General options in ptx,  Next: Charset selection in ptx,  Up: ptx invocation

7.5.1 General options
---------------------

`-G'
`--traditional'
     As already explained, this option disables all GNU extensions to
     `ptx' and switches to traditional mode.

`--help'
     Print a short help on standard output, then exit without further
     processing.

`--version'
     Print the program version on standard output, then exit without
     further processing.


   An exit status of zero indicates success, and a nonzero value
indicates failure.

File: coreutils.info,  Node: Charset selection in ptx,  Next: Input processing in ptx,  Prev: General options in ptx,  Up: ptx invocation

7.5.2 Charset selection
-----------------------

As it is set up now, the program assumes that the input file is coded
using 8-bit ISO 8859-1 code, also known as Latin-1 character set,
_unless_ it is compiled for MS-DOS, in which case it uses the character
set of the IBM-PC.  (GNU `ptx' is not known to work on smaller MS-DOS
machines anymore.)  Compared to 7-bit ASCII, the set of characters
which are letters is different; this alters the behavior of regular
expression matching.  Thus, the default regular expression for a
keyword allows foreign or diacriticized letters.  Keyword sorting,
however, is still crude; it obeys the underlying character set ordering
quite blindly.

`-f'
`--ignore-case'
     Fold lower case letters to upper case for sorting.


File: coreutils.info,  Node: Input processing in ptx,  Next: Output formatting in ptx,  Prev: Charset selection in ptx,  Up: ptx invocation

7.5.3 Word selection and input processing
-----------------------------------------

`-b FILE'
`--break-file=FILE'
     This option provides an alternative (to `-W') method of describing
     which characters make up words.  It introduces the name of a file
     which contains a list of characters which can_not_ be part of one
     word; this file is called the "Break file".  Any character which
     is not part of the Break file is a word constituent.  If both
     options `-b' and `-W' are specified, then `-W' has precedence and
     `-b' is ignored.

     When GNU extensions are enabled, the only way to avoid newline as a
     break character is to write all the break characters in the file
     with no newline at all, not even at the end of the file.  When GNU
     extensions are disabled, spaces, tabs and newlines are always
     considered as break characters even if not included in the Break
     file.

`-i FILE'
`--ignore-file=FILE'
     The file associated with this option contains a list of words
     which will never be taken as keywords in concordance output.  It
     is called the "Ignore file".  The file contains exactly one word
     in each line; the end of line separation of words is not subject
     to the value of the `-S' option.

`-o FILE'
`--only-file=FILE'
     The file associated with this option contains a list of words
     which will be retained in concordance output; any word not
     mentioned in this file is ignored.  The file is called the "Only
     file".  The file contains exactly one word in each line; the end
     of line separation of words is not subject to the value of the
     `-S' option.

     There is no default for the Only file.  When both an Only file and
     an Ignore file are specified, a word is considered a keyword only
     if it is listed in the Only file and not in the Ignore file.

`-r'
`--references'
     On each input line, the leading sequence of non-white space
     characters will be taken to be a reference that has the purpose of
     identifying this input line in the resulting permuted index.
     *Note Output formatting in ptx::, for more information about
     reference production.  Using this option changes the default value
     for option `-S'.

     Using this option, the program does not try very hard to remove
     references from contexts in output, but it succeeds in doing so
     _when_ the context ends exactly at the newline.  If option `-r' is
     used with `-S' default value, or when GNU extensions are disabled,
     this condition is always met and references are completely
     excluded from the output contexts.

`-S REGEXP'
`--sentence-regexp=REGEXP'
     This option selects which regular expression will describe the end
     of a line or the end of a sentence.  In fact, this regular
     expression is not the only distinction between end of lines or end
     of sentences, and input line boundaries have no special
     significance outside this option.  By default, when GNU extensions
     are enabled and if `-r' option is not used, end of sentences are
     used.  In this case, this REGEX is imported from GNU Emacs:

          [.?!][]\"')}]*\\($\\|\t\\|  \\)[ \t\n]*

     Whenever GNU extensions are disabled or if `-r' option is used, end
     of lines are used; in this case, the default REGEXP is just:

          \n

     Using an empty REGEXP is equivalent to completely disabling end of
     line or end of sentence recognition.  In this case, the whole file
     is considered to be a single big line or sentence.  The user might
     want to disallow all truncation flag generation as well, through
     option `-F ""'.  *Note Syntax of Regular Expressions:
     (emacs)Regexps.

     When the keywords happen to be near the beginning of the input
     line or sentence, this often creates an unused area at the
     beginning of the output context line; when the keywords happen to
     be near the end of the input line or sentence, this often creates
     an unused area at the end of the output context line.  The program
     tries to fill those unused areas by wrapping around context in
     them; the tail of the input line or sentence is used to fill the
     unused area on the left of the output line; the head of the input
     line or sentence is used to fill the unused area on the right of
     the output line.

     As a matter of convenience to the user, many usual backslashed
     escape sequences from the C language are recognized and converted
     to the corresponding characters by `ptx' itself.

`-W REGEXP'
`--word-regexp=REGEXP'
     This option selects which regular expression will describe each
     keyword.  By default, if GNU extensions are enabled, a word is a
     sequence of letters; the REGEXP used is `\w+'.  When GNU
     extensions are disabled, a word is by default anything which ends
     with a space, a tab or a newline; the REGEXP used is `[^ \t\n]+'.

     An empty REGEXP is equivalent to not using this option.  *Note
     Syntax of Regular Expressions: (emacs)Regexps.

     As a matter of convenience to the user, many usual backslashed
     escape sequences, as found in the C language, are recognized and
     converted to the corresponding characters by `ptx' itself.


File: coreutils.info,  Node: Output formatting in ptx,  Next: Compatibility in ptx,  Prev: Input processing in ptx,  Up: ptx invocation

7.5.4 Output formatting
-----------------------

Output format is mainly controlled by the `-O' and `-T' options
described in the table below.  When neither `-O' nor `-T' are selected,
and if GNU extensions are enabled, the program chooses an output format
suitable for a dumb terminal.  Each keyword occurrence is output to the
center of one line, surrounded by its left and right contexts.  Each
field is properly justified, so the concordance output can be readily
observed.  As a special feature, if automatic references are selected
by option `-A' and are output before the left context, that is, if
option `-R' is _not_ selected, then a colon is added after the
reference; this nicely interfaces with GNU Emacs `next-error'
processing.  In this default output format, each white space character,
like newline and tab, is merely changed to exactly one space, with no
special attempt to compress consecutive spaces.  This might change in
the future.  Except for those white space characters, every other
character of the underlying set of 256 characters is transmitted
verbatim.

   Output format is further controlled by the following options.

`-g NUMBER'
`--gap-size=NUMBER'
     Select the size of the minimum white space gap between the fields
     on the output line.

`-w NUMBER'
`--width=NUMBER'
     Select the maximum output width of each final line.  If references
     are used, they are included or excluded from the maximum output
     width depending on the value of option `-R'.  If this option is not
     selected, that is, when references are output before the left
     context, the maximum output width takes into account the maximum
     length of all references.  If this option is selected, that is,
     when references are output after the right context, the maximum
     output width does not take into account the space taken by
     references, nor the gap that precedes them.

`-A'
`--auto-reference'
     Select automatic references.  Each input line will have an
     automatic reference made up of the file name and the line ordinal,
     with a single colon between them.  However, the file name will be
     empty when standard input is being read.  If both `-A' and `-r'
     are selected, then the input reference is still read and skipped,
     but the automatic reference is used at output time, overriding the
     input reference.

`-R'
`--right-side-refs'
     In the default output format, when option `-R' is not used, any
     references produced by the effect of options `-r' or `-A' are
     placed to the far right of output lines, after the right context.
     With default output format, when the `-R' option is specified,
     references are rather placed at the beginning of each output line,
     before the left context.  For any other output format, option `-R'
     is ignored, with one exception:  with `-R' the width of references
     is _not_ taken into account in total output width given by `-w'.

     This option is automatically selected whenever GNU extensions are
     disabled.

`-F STRING'
`--flag-truncation=STRING'
     This option will request that any truncation in the output be
     reported using the string STRING.  Most output fields
     theoretically extend towards the beginning or the end of the
     current line, or current sentence, as selected with option `-S'.
     But there is a maximum allowed output line width, changeable
     through option `-w', which is further divided into space for
     various output fields.  When a field has to be truncated because
     it cannot extend beyond the beginning or the end of the current
     line to fit in, then a truncation occurs.  By default, the string
     used is a single slash, as in `-F /'.

     STRING may have more than one character, as in `-F ...'.  Also, in
     the particular case when STRING is empty (`-F ""'), truncation
     flagging is disabled, and no truncation marks are appended in this
     case.

     As a matter of convenience to the user, many usual backslashed
     escape sequences, as found in the C language, are recognized and
     converted to the corresponding characters by `ptx' itself.

`-M STRING'
`--macro-name=STRING'
     Select another STRING to be used instead of `xx', while generating
     output suitable for `nroff', `troff' or TeX.

`-O'
`--format=roff'
     Choose an output format suitable for `nroff' or `troff'
     processing.  Each output line will look like:

          .xx "TAIL" "BEFORE" "KEYWORD_AND_AFTER" "HEAD" "REF"

     so it will be possible to write a `.xx' roff macro to take care of
     the output typesetting.  This is the default output format when GNU
     extensions are disabled.  Option `-M' can be used to change `xx'
     to another macro name.

     In this output format, each non-graphical character, like newline
     and tab, is merely changed to exactly one space, with no special
     attempt to compress consecutive spaces.  Each quote character `"'
     is doubled so it will be correctly processed by `nroff' or `troff'.

`-T'
`--format=tex'
     Choose an output format suitable for TeX processing.  Each output
     line will look like:

          \xx {TAIL}{BEFORE}{KEYWORD}{AFTER}{HEAD}{REF}

     so it will be possible to write a `\xx' definition to take care of
     the output typesetting.  Note that when references are not being
     produced, that is, neither option `-A' nor option `-r' is
     selected, the last parameter of each `\xx' call is inhibited.
     Option `-M' can be used to change `xx' to another macro name.

     In this output format, some special characters, like `$', `%',
     `&', `#' and `_' are automatically protected with a backslash.
     Curly brackets `{', `}' are protected with a backslash and a pair
     of dollar signs (to force mathematical mode).  The backslash
     itself produces the sequence `\backslash{}'.  Circumflex and tilde
     diacritical marks produce the sequence `^\{ }' and `~\{ }'
     respectively.  Other diacriticized characters of the underlying
     character set produce an appropriate TeX sequence as far as
     possible.  The other non-graphical characters, like newline and
     tab, and all other characters which are not part of ASCII, are
     merely changed to exactly one space, with no special attempt to
     compress consecutive spaces.  Let me know how to improve this
     special character processing for TeX.


File: coreutils.info,  Node: Compatibility in ptx,  Prev: Output formatting in ptx,  Up: ptx invocation

7.5.5 The GNU extensions to `ptx'
---------------------------------

This version of `ptx' contains a few features which do not exist in
System V `ptx'.  These extra features are suppressed by using the `-G'
command line option, unless overridden by other command line options.
Some GNU extensions cannot be recovered by overriding, so the simple
rule is to avoid `-G' if you care about GNU extensions.  Here are the
differences between this program and System V `ptx'.

   * This program can read many input files at once, it always writes
     the resulting concordance on standard output.  On the other hand,
     System V `ptx' reads only one file and sends the result to
     standard output or, if a second FILE parameter is given on the
     command, to that FILE.

     Having output parameters not introduced by options is a dangerous
     practice which GNU avoids as far as possible.  So, for using `ptx'
     portably between GNU and System V, you should always use it with a
     single input file, and always expect the result on standard
     output.  You might also want to automatically configure in a `-G'
     option to `ptx' calls in products using `ptx', if the configurator
     finds that the installed `ptx' accepts `-G'.

   * The only options available in System V `ptx' are options `-b',
     `-f', `-g', `-i', `-o', `-r', `-t' and `-w'.  All other options
     are GNU extensions and are not repeated in this enumeration.
     Moreover, some options have a slightly different meaning when GNU
     extensions are enabled, as explained below.

   * By default, concordance output is not formatted for `troff' or
     `nroff'.  It is rather formatted for a dumb terminal.  `troff' or
     `nroff' output may still be selected through option `-O'.

   * Unless `-R' option is used, the maximum reference width is
     subtracted from the total output line width.  With GNU extensions
     disabled, width of references is not taken into account in the
     output line width computations.

   * All 256 bytes, even ASCII NUL bytes, are always read and processed
     from input file with no adverse effect, even if GNU extensions are
     disabled.  However, System V `ptx' does not accept 8-bit
     characters, a few control characters are rejected, and the tilde
     `~' is also rejected.

   * Input line length is only limited by available memory, even if GNU
     extensions are disabled.  However, System V `ptx' processes only
     the first 200 characters in each line.

   * The break (non-word) characters default to be every character
     except all letters of the underlying character set, diacriticized
     or not.  When GNU extensions are disabled, the break characters
     default to space, tab and newline only.

   * The program makes better use of output line width.  If GNU
     extensions are disabled, the program rather tries to imitate
     System V `ptx', but still, there are some slight disposition
     glitches this program does not completely reproduce.

   * The user can specify both an Ignore file and an Only file.  This
     is not allowed with System V `ptx'.


