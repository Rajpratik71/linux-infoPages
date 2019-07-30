Prev: Template,  Up: Template

5.1 Invoking the ‘xgettext’ Program
===================================

     xgettext [OPTION] [INPUTFILE] …

   The ‘xgettext’ program extracts translatable strings from given input
files.

5.1.1 Input file location
-------------------------

‘INPUTFILE …’
     Input files.

‘-f FILE’
‘--files-from=FILE’
     Read the names of the input files from FILE instead of getting them
     from the command line.

‘-D DIRECTORY’
‘--directory=DIRECTORY’
     Add DIRECTORY to the list of directories.  Source files are
     searched relative to this list of directories.  The resulting ‘.po’
     file will be written relative to the current directory, though.

   If INPUTFILE is ‘-’, standard input is read.

5.1.2 Output file location
--------------------------

‘-d NAME’
‘--default-domain=NAME’
     Use ‘NAME.po’ for output (instead of ‘messages.po’).

‘-o FILE’
‘--output=FILE’
     Write output to specified file (instead of ‘NAME.po’ or
     ‘messages.po’).

‘-p DIR’
‘--output-dir=DIR’
     Output files will be placed in directory DIR.

   If the output FILE is ‘-’ or ‘/dev/stdout’, the output is written to
standard output.

5.1.3 Choice of input file language
-----------------------------------

‘-L NAME’
‘--language=NAME’
     Specifies the language of the input files.  The supported languages
     are ‘C’, ‘C++’, ‘ObjectiveC’, ‘PO’, ‘Shell’, ‘Python’, ‘Lisp’,
     ‘EmacsLisp’, ‘librep’, ‘Scheme’, ‘Smalltalk’, ‘Java’,
     ‘JavaProperties’, ‘C#’, ‘awk’, ‘YCP’, ‘Tcl’, ‘Perl’, ‘PHP’,
     ‘GCC-source’, ‘NXStringTable’, ‘RST’, ‘Glade’, ‘Lua’, ‘JavaScript’,
     ‘Vala’, ‘GSettings’, ‘Desktop’.

‘-C’
‘--c++’
     This is a shorthand for ‘--language=C++’.

   By default the language is guessed depending on the input file name
extension.

5.1.4 Input file interpretation
-------------------------------

‘--from-code=NAME’
     Specifies the encoding of the input files.  This option is needed
     only if some untranslated message strings or their corresponding
     comments contain non-ASCII characters.  Note that Tcl and Glade
     input files are always assumed to be in UTF-8, regardless of this
     option.

   By default the input files are assumed to be in ASCII.

5.1.5 Operation mode
--------------------

‘-j’
‘--join-existing’
     Join messages with existing file.

‘-x FILE’
‘--exclude-file=FILE’
     Entries from FILE are not extracted.  FILE should be a PO or POT
     file.

‘-c[TAG]’
‘--add-comments[=TAG]’
     Place comment blocks starting with TAG and preceding keyword lines
     in the output file.  Without a TAG, the option means to put _all_
     comment blocks preceding keyword lines in the output file.

     Note that comment blocks supposed to be extracted must be adjacent
     to keyword lines.  For example, in the following C source code:

          /* This is the first comment.  */
          gettext ("foo");

          /* This is the second comment: not extracted  */
          gettext (
            "bar");

          gettext (
            /* This is the third comment.  */
            "baz");

     The second comment line will not be extracted, because there is one
     blank line between the comment line and the keyword.

‘--check[=CHECK]’
     Perform a syntax check on msgid and msgid_plural.  The supported
     checks are:

     ‘ellipsis-unicode’
          Prefer Unicode ellipsis character over ASCII ‘...’

     ‘space-ellipsis’
          Prohibit whitespace before an ellipsis character

     ‘quote-unicode’
          Prefer Unicode quotation marks over ASCII ‘"'`’

     ‘bullet-unicode’
          Prefer Unicode bullet character over ASCII ‘*’ or ‘-’

     The option has an effect on all input files.  To enable or disable
     checks for a certain string, you can mark it with an ‘xgettext:’
     special comment in the source file.  For example, if you specify
     the ‘--check=space-ellipsis’ option, but want to suppress the check
     on a particular string, add the following comment:

          /* xgettext: no-space-ellipsis-check */
          gettext ("We really want a space before ellipsis here ...");

     The ‘xgettext:’ comment can be followed by flags separated with a
     comma.  The possible flags are of the form ‘[no-]NAME-check’, where
     NAME is the name of a valid syntax check.  If a flag is prefixed by
     ‘no-’, the meaning is negated.

     Some tests apply the checks to each sentence within the msgid,
     rather than the whole string.  xgettext detects the end of sentence
     by performing a pattern match, which usually looks for a period
     followed by a certain number of spaces.  The number is specified
     with the ‘--sentence-end’ option.

‘--sentence-end[=TYPE]’
     The supported values are:

     ‘single-space’
          Expect at least one whitespace after a period

     ‘double-space’
          Expect at least two whitespaces after a period

5.1.6 Language specific options
-------------------------------

‘-a’
‘--extract-all’
     Extract all strings.

     This option has an effect with most languages, namely C, C++,
     ObjectiveC, Shell, Python, Lisp, EmacsLisp, librep, Java, C#, awk,
     Tcl, Perl, PHP, GCC-source, Glade, Lua, JavaScript, Vala,
     GSettings.

‘-k[KEYWORDSPEC]’
‘--keyword[=KEYWORDSPEC]’
     Specify KEYWORDSPEC as an additional keyword to be looked for.
     Without a KEYWORDSPEC, the option means to not use default
     keywords.

     If KEYWORDSPEC is a C identifier ID, ‘xgettext’ looks for strings
     in the first argument of each call to the function or macro ID.  If
     KEYWORDSPEC is of the form ‘ID:ARGNUM’, ‘xgettext’ looks for
     strings in the ARGNUMth argument of the call.  If KEYWORDSPEC is of
     the form ‘ID:ARGNUM1,ARGNUM2’, ‘xgettext’ looks for strings in the
     ARGNUM1st argument and in the ARGNUM2nd argument of the call, and
     treats them as singular/plural variants for a message with plural
     handling.  Also, if KEYWORDSPEC is of the form
     ‘ID:CONTEXTARGNUMc,ARGNUM’ or ‘ID:ARGNUM,CONTEXTARGNUMc’,
     ‘xgettext’ treats strings in the CONTEXTARGNUMth argument as a
     context specifier.  And, as a special-purpose support for GNOME, if
     KEYWORDSPEC is of the form ‘ID:ARGNUMg’, ‘xgettext’ recognizes the
     ARGNUMth argument as a string with context, using the GNOME ‘glib’
     syntax ‘"msgctxt|msgid"’.
     Furthermore, if KEYWORDSPEC is of the form ‘ID:…,TOTALNUMARGSt’,
     ‘xgettext’ recognizes this argument specification only if the
     number of actual arguments is equal to TOTALNUMARGS.  This is
     useful for disambiguating overloaded function calls in C++.
     Finally, if KEYWORDSPEC is of the form ‘ID:ARGNUM...,"XCOMMENT"’,
     ‘xgettext’, when extracting a message from the specified argument
     strings, adds an extracted comment XCOMMENT to the message.  Note
     that when used through a normal shell command line, the
     double-quotes around the XCOMMENT need to be escaped.

     This option has an effect with most languages, namely C, C++,
     ObjectiveC, Shell, Python, Lisp, EmacsLisp, librep, Java, C#, awk,
     Tcl, Perl, PHP, GCC-source, Glade, Lua, JavaScript, Vala,
     GSettings, Desktop.

     The default keyword specifications, which are always looked for if
     not explicitly disabled, are language dependent.  They are:

        • For C, C++, and GCC-source: ‘gettext’, ‘dgettext:2’,
          ‘dcgettext:2’, ‘ngettext:1,2’, ‘dngettext:2,3’,
          ‘dcngettext:2,3’, ‘gettext_noop’, and ‘pgettext:1c,2’,
          ‘dpgettext:2c,3’, ‘dcpgettext:2c,3’, ‘npgettext:1c,2,3’,
          ‘dnpgettext:2c,3,4’, ‘dcnpgettext:2c,3,4’.

        • For Objective C: Like for C, and also ‘NSLocalizedString’,
          ‘_’, ‘NSLocalizedStaticString’, ‘__’.

        • For Shell scripts: ‘gettext’, ‘ngettext:1,2’, ‘eval_gettext’,
          ‘eval_ngettext:1,2’.

        • For Python: ‘gettext’, ‘ugettext’, ‘dgettext:2’,
          ‘ngettext:1,2’, ‘ungettext:1,2’, ‘dngettext:2,3’, ‘_’.

        • For Lisp: ‘gettext’, ‘ngettext:1,2’, ‘gettext-noop’.

        • For EmacsLisp: ‘_’.

        • For librep: ‘_’.

        • For Scheme: ‘gettext’, ‘ngettext:1,2’, ‘gettext-noop’.

        • For Java: ‘GettextResource.gettext:2’,
          ‘GettextResource.ngettext:2,3’,
          ‘GettextResource.pgettext:2c,3’,
          ‘GettextResource.npgettext:2c,3,4’, ‘gettext’, ‘ngettext:1,2’,
          ‘pgettext:1c,2’, ‘npgettext:1c,2,3’, ‘getString’.

        • For C#: ‘GetString’, ‘GetPluralString:1,2’,
          ‘GetParticularString:1c,2’,
          ‘GetParticularPluralString:1c,2,3’.

        • For awk: ‘dcgettext’, ‘dcngettext:1,2’.

        • For Tcl: ‘::msgcat::mc’.

        • For Perl: ‘gettext’, ‘%gettext’, ‘$gettext’, ‘dgettext:2’,
          ‘dcgettext:2’, ‘ngettext:1,2’, ‘dngettext:2,3’,
          ‘dcngettext:2,3’, ‘gettext_noop’.

        • For PHP: ‘_’, ‘gettext’, ‘dgettext:2’, ‘dcgettext:2’,
          ‘ngettext:1,2’, ‘dngettext:2,3’, ‘dcngettext:2,3’.

        • For Glade 1: ‘label’, ‘title’, ‘text’, ‘format’, ‘copyright’,
          ‘comments’, ‘preview_text’, ‘tooltip’.

        • For Lua: ‘_’, ‘gettext.gettext’, ‘gettext.dgettext:2’,
          ‘gettext.dcgettext:2’, ‘gettext.ngettext:1,2’,
          ‘gettext.dngettext:2,3’, ‘gettext.dcngettext:2,3’.

        • For JavaScript: ‘_’, ‘gettext’, ‘dgettext:2’, ‘dcgettext:2’,
          ‘ngettext:1,2’, ‘dngettext:2,3’, ‘pgettext:1c,2’,
          ‘dpgettext:2c,3’.

        • For Vala: ‘_’, ‘Q_’, ‘N_’, ‘NC_’, ‘dgettext:2’, ‘dcgettext:2’,
          ‘ngettext:1,2’, ‘dngettext:2,3’, ‘dpgettext:2c,3’,
          ‘dpgettext2:2c,3’.

        • For Desktop: ‘Name’, ‘GenericName’, ‘Comment’, ‘Icon’,
          ‘Keywords’.

     To disable the default keyword specifications, the option ‘-k’ or
     ‘--keyword’ or ‘--keyword=’, without a KEYWORDSPEC, can be used.

‘--flag=WORD:ARG:FLAG’
     Specifies additional flags for strings occurring as part of the
     ARGth argument of the function WORD.  The possible flags are the
     possible format string indicators, such as ‘c-format’, and their
     negations, such as ‘no-c-format’, possibly prefixed with ‘pass-’.
     The meaning of ‘--flag=FUNCTION:ARG:LANG-format’ is that in
     language LANG, the specified FUNCTION expects as ARGth argument a
     format string.  (For those of you familiar with GCC function
     attributes, ‘--flag=FUNCTION:ARG:c-format’ is roughly equivalent to
     the declaration ‘__attribute__ ((__format__ (__printf__, ARG,
     ...)))’ attached to FUNCTION in a C source file.)  For example, if
     you use the ‘error’ function from GNU libc, you can specify its
     behaviour through ‘--flag=error:3:c-format’.  The effect of this
     specification is that ‘xgettext’ will mark as format strings all
     ‘gettext’ invocations that occur as ARGth argument of FUNCTION.
     This is useful when such strings contain no format string
     directives: together with the checks done by ‘msgfmt -c’ it will
     ensure that translators cannot accidentally use format string
     directives that would lead to a crash at runtime.
     The meaning of ‘--flag=FUNCTION:ARG:pass-LANG-format’ is that in
     language LANG, if the FUNCTION call occurs in a position that must
     yield a format string, then its ARGth argument must yield a format
     string of the same type as well.  (If you know GCC function
     attributes, the ‘--flag=FUNCTION:ARG:pass-c-format’ option is
     roughly equivalent to the declaration ‘__attribute__
     ((__format_arg__ (ARG)))’ attached to FUNCTION in a C source file.)
     For example, if you use the ‘_’ shortcut for the ‘gettext’
     function, you should use ‘--flag=_:1:pass-c-format’.  The effect of
     this specification is that ‘xgettext’ will propagate a format
     string requirement for a ‘_("string")’ call to its first argument,
     the literal ‘"string"’, and thus mark it as a format string.  This
     is useful when such strings contain no format string directives:
     together with the checks done by ‘msgfmt -c’ it will ensure that
     translators cannot accidentally use format string directives that
     would lead to a crash at runtime.
     This option has an effect with most languages, namely C, C++,
     ObjectiveC, Shell, Python, Lisp, EmacsLisp, librep, Scheme, Java,
     C#, awk, YCP, Tcl, Perl, PHP, GCC-source, Lua, JavaScript, Vala.

‘-T’
‘--trigraphs’
     Understand ANSI C trigraphs for input.
     This option has an effect only with the languages C, C++,
     ObjectiveC.

‘--qt’
     Recognize Qt format strings.
     This option has an effect only with the language C++.

‘--kde’
     Recognize KDE 4 format strings.
     This option has an effect only with the language C++.

‘--boost’
     Recognize Boost format strings.
     This option has an effect only with the language C++.

‘--debug’
     Use the flags ‘c-format’ and ‘possible-c-format’ to show who was
     responsible for marking a message as a format string.  The latter
     form is used if the ‘xgettext’ program decided, the former form is
     used if the programmer prescribed it.

     By default only the ‘c-format’ form is used.  The translator should
     not have to care about these details.

   This implementation of ‘xgettext’ is able to process a few awkward
cases, like strings in preprocessor macros, ANSI concatenation of
adjacent strings, and escaped end of lines for continued strings.

5.1.7 Output details
--------------------

‘--color’
‘--color=WHEN’
     Specify whether or when to use colors and other text attributes.
     See *note The --color option:: for details.

‘--style=STYLE_FILE’
     Specify the CSS style rule file to use for ‘--color’.  See *note
     The --style option:: for details.

‘--force-po’
     Always write an output file even if no message is defined.

‘-i’
‘--indent’
     Write the .po file using indented style.

‘--no-location’
     Do not write ‘#: FILENAME:LINE’ lines.  Note that using this option
     makes it harder for technically skilled translators to understand
     each message’s context.

‘-n’
‘--add-location=TYPE’
     Generate ‘#: FILENAME:LINE’ lines (default).

     The optional TYPE can be either ‘full’, ‘file’, or ‘never’.  If it
     is not given or ‘full’, it generates the lines with both file name
     and line number.  If it is ‘file’, the line number part is omitted.
     If it is ‘never’, it completely suppresses the lines (same as
     ‘--no-location’).

‘--strict’
     Write out a strict Uniforum conforming PO file.  Note that this
     Uniforum format should be avoided because it doesn’t support the
     GNU extensions.

‘--properties-output’
     Write out a Java ResourceBundle in Java ‘.properties’ syntax.  Note
     that this file format doesn’t support plural forms and silently
     drops obsolete messages.

‘--stringtable-output’
     Write out a NeXTstep/GNUstep localized resource file in ‘.strings’
     syntax.  Note that this file format doesn’t support plural forms.

‘--its=FILE’
     Use ITS rules defined in FILE.  Note that this is only effective
     with XML files.

‘--itstool’
     Write out comments recognized by itstool (<http://itstool.org>).
     Note that this is only effective with XML files.

‘-w NUMBER’
‘--width=NUMBER’
     Set the output page width.  Long strings in the output files will
     be split across multiple lines in order to ensure that each line’s
     width (= number of screen columns) is less or equal to the given
     NUMBER.

‘--no-wrap’
     Do not break long message lines.  Message lines whose width exceeds
     the output page width will not be split into several lines.  Only
     file reference lines which are wider than the output page width
     will be split.

‘-s’
‘--sort-output’
     Generate sorted output.  Note that using this option makes it much
     harder for the translator to understand each message’s context.

‘-F’
‘--sort-by-file’
     Sort output by file location.

‘--omit-header’
     Don’t write header with ‘msgid ""’ entry.

     This is useful for testing purposes because it eliminates a source
     of variance for generated ‘.gmo’ files.  With ‘--omit-header’, two
     invocations of ‘xgettext’ on the same files with the same options
     at different times are guaranteed to produce the same results.

     Note that using this option will lead to an error if the resulting
     file would not entirely be in ASCII.

‘--copyright-holder=STRING’
     Set the copyright holder in the output.  STRING should be the
     copyright holder of the surrounding package.  (Note that the msgstr
     strings, extracted from the package’s sources, belong to the
     copyright holder of the package.)  Translators are expected to
     transfer or disclaim the copyright for their translations, so that
     package maintainers can distribute them without legal risk.  If
     STRING is empty, the output files are marked as being in the public
     domain; in this case, the translators are expected to disclaim
     their copyright, again so that package maintainers can distribute
     them without legal risk.

     The default value for STRING is the Free Software Foundation, Inc.,
     simply because ‘xgettext’ was first used in the GNU project.

‘--foreign-user’
     Omit FSF copyright in output.  This option is equivalent to
     ‘--copyright-holder=''’.  It can be useful for packages outside the
     GNU project that want their translations to be in the public
     domain.

‘--package-name=PACKAGE’
     Set the package name in the header of the output.

‘--package-version=VERSION’
     Set the package version in the header of the output.  This option
     has an effect only if the ‘--package-name’ option is also used.

‘--msgid-bugs-address=EMAIL@ADDRESS’
     Set the reporting address for msgid bugs.  This is the email
     address or URL to which the translators shall report bugs in the
     untranslated strings:

        - Strings which are not entire sentences; see the maintainer
          guidelines in *note Preparing Strings::.
        - Strings which use unclear terms or require additional context
          to be understood.
        - Strings which make invalid assumptions about notation of date,
          time or money.
        - Pluralisation problems.
        - Incorrect English spelling.
        - Incorrect formatting.

     It can be your email address, or a mailing list address where
     translators can write to without being subscribed, or the URL of a
     web page through which the translators can contact you.

     The default value is empty, which means that translators will be
     clueless!  Don’t forget to specify this option.

‘-m[STRING]’
‘--msgstr-prefix[=STRING]’
     Use STRING (or "" if not specified) as prefix for msgstr values.

‘-M[STRING]’
‘--msgstr-suffix[=STRING]’
     Use STRING (or "" if not specified) as suffix for msgstr values.

5.1.8 Informative output
------------------------

‘-h’
‘--help’
     Display this help and exit.

‘-V’
‘--version’
     Output version information and exit.

