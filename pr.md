File: coreutils.info,  Node: pr invocation,  Next: fold invocation,  Prev: numfmt invocation,  Up: Formatting file contents

4.3 'pr': Paginate or columnate files for printing
==================================================

'pr' writes each FILE ('-' means standard input), or standard input if
none are given, to standard output, paginating and optionally outputting
in multicolumn format; optionally merges all FILEs, printing all in
parallel, one per column.  Synopsis:

     pr [OPTION]... [FILE]...

   By default, a 5-line header is printed at each page: two blank lines;
a line with the date, the file name, and the page count; and two more
blank lines.  A footer of five blank lines is also printed.  The default
PAGE_LENGTH is 66 lines.  The default number of text lines is therefore
56.  The text line of the header takes the form 'DATE STRING PAGE', with
spaces inserted around STRING so that the line takes up the full
PAGE_WIDTH.  Here, DATE is the date (see the '-D' or '--date-format'
option for details), STRING is the centered header string, and PAGE
identifies the page number.  The 'LC_MESSAGES' locale category affects
the spelling of PAGE; in the default C locale, it is 'Page NUMBER' where
NUMBER is the decimal page number.

   Form feeds in the input cause page breaks in the output.  Multiple
form feeds produce empty pages.

   Columns are of equal width, separated by an optional string (default
is 'space').  For multicolumn output, lines will always be truncated to
PAGE_WIDTH (default 72), unless you use the '-J' option.  For single
column output no line truncation occurs by default.  Use '-W' option to
truncate lines in that case.

   The program accepts the following options.  Also see *note Common
options::.

'+FIRST_PAGE[:LAST_PAGE]'
'--pages=FIRST_PAGE[:LAST_PAGE]'
     Begin printing with page FIRST_PAGE and stop with LAST_PAGE.
     Missing ':LAST_PAGE' implies end of file.  While estimating the
     number of skipped pages each form feed in the input file results in
     a new page.  Page counting with and without '+FIRST_PAGE' is
     identical.  By default, counting starts with the first page of
     input file (not first page printed).  Line numbering may be altered
     by '-N' option.

'-COLUMN'
'--columns=COLUMN'
     With each single FILE, produce COLUMN columns of output (default is
     1) and print columns down, unless '-a' is used.  The column width
     is automatically decreased as COLUMN increases; unless you use the
     '-W/-w' option to increase PAGE_WIDTH as well.  This option might
     well cause some lines to be truncated.  The number of lines in the
     columns on each page are balanced.  The options '-e' and '-i' are
     on for multiple text-column output.  Together with '-J' option
     column alignment and line truncation is turned off.  Lines of full
     length are joined in a free field format and '-S' option may set
     field separators.  '-COLUMN' may not be used with '-m' option.

'-a'
'--across'
     With each single FILE, print columns across rather than down.  The
     '-COLUMN' option must be given with COLUMN greater than one.  If a
     line is too long to fit in a column, it is truncated.

'-c'
'--show-control-chars'
     Print control characters using hat notation (e.g., '^G'); print
     other nonprinting characters in octal backslash notation.  By
     default, nonprinting characters are not changed.

'-d'
'--double-space'
     Double space the output.

'-D FORMAT'
'--date-format=FORMAT'
     Format header dates using FORMAT, using the same conventions as for
     the command 'date +FORMAT'.  *Note date invocation::.  Except for
     directives, which start with '%', characters in FORMAT are printed
     unchanged.  You can use this option to specify an arbitrary string
     in place of the header date, e.g., '--date-format="Monday
     morning"'.

     The default date format is '%Y-%m-%d %H:%M' (for example,
     '2001-12-04 23:59'); but if the 'POSIXLY_CORRECT' environment
     variable is set and the 'LC_TIME' locale category specifies the
     POSIX locale, the default is '%b %e %H:%M %Y' (for example, 'Dec  4
     23:59 2001'.

     Time stamps are listed according to the time zone rules specified
     by the 'TZ' environment variable, or by the system default rules if
     'TZ' is not set.  *Note Specifying the Time Zone with 'TZ':
     (libc)TZ Variable.

'-e[IN-TABCHAR[IN-TABWIDTH]]'
'--expand-tabs[=IN-TABCHAR[IN-TABWIDTH]]'
     Expand TABs to spaces on input.  Optional argument IN-TABCHAR is
     the input tab character (default is the TAB character).  Second
     optional argument IN-TABWIDTH is the input tab character's width
     (default is 8).

'-f'
'-F'
'--form-feed'
     Use a form feed instead of newlines to separate output pages.  This
     does not alter the default page length of 66 lines.

'-h HEADER'
'--header=HEADER'
     Replace the file name in the header with the centered string
     HEADER.  When using the shell, HEADER should be quoted and should
     be separated from '-h' by a space.

'-i[OUT-TABCHAR[OUT-TABWIDTH]]'
'--output-tabs[=OUT-TABCHAR[OUT-TABWIDTH]]'
     Replace spaces with TABs on output.  Optional argument OUT-TABCHAR
     is the output tab character (default is the TAB character).  Second
     optional argument OUT-TABWIDTH is the output tab character's width
     (default is 8).

'-J'
'--join-lines'
     Merge lines of full length.  Used together with the column options
     '-COLUMN', '-a -COLUMN' or '-m'.  Turns off '-W/-w' line
     truncation; no column alignment used; may be used with
     '--sep-string[=STRING]'.  '-J' has been introduced (together with
     '-W' and '--sep-string') to disentangle the old (POSIX-compliant)
     options '-w' and '-s' along with the three column options.

'-l PAGE_LENGTH'
'--length=PAGE_LENGTH'
     Set the page length to PAGE_LENGTH (default 66) lines, including
     the lines of the header [and the footer].  If PAGE_LENGTH is less
     than or equal to 10, the header and footer are omitted, as if the
     '-t' option had been given.

'-m'
'--merge'
     Merge and print all FILEs in parallel, one in each column.  If a
     line is too long to fit in a column, it is truncated, unless the
     '-J' option is used.  '--sep-string[=STRING]' may be used.  Empty
     pages in some FILEs (form feeds set) produce empty columns, still
     marked by STRING.  The result is a continuous line numbering and
     column marking throughout the whole merged file.  Completely empty
     merged pages show no separators or line numbers.  The default
     header becomes 'DATE PAGE' with spaces inserted in the middle; this
     may be used with the '-h' or '--header' option to fill up the
     middle blank part.

'-n[NUMBER-SEPARATOR[DIGITS]]'
'--number-lines[=NUMBER-SEPARATOR[DIGITS]]'
     Provide DIGITS digit line numbering (default for DIGITS is 5).
     With multicolumn output the number occupies the first DIGITS column
     positions of each text column or only each line of '-m' output.
     With single column output the number precedes each line just as
     '-m' does.  Default counting of the line numbers starts with the
     first line of the input file (not the first line printed, compare
     the '--page' option and '-N' option).  Optional argument
     NUMBER-SEPARATOR is the character appended to the line number to
     separate it from the text followed.  The default separator is the
     TAB character.  In a strict sense a TAB is always printed with
     single column output only.  The TAB width varies with the TAB
     position, e.g., with the left MARGIN specified by '-o' option.
     With multicolumn output priority is given to 'equal width of output
     columns' (a POSIX specification).  The TAB width is fixed to the
     value of the first column and does not change with different values
     of left MARGIN.  That means a fixed number of spaces is always
     printed in the place of the NUMBER-SEPARATOR TAB.  The tabification
     depends upon the output position.

'-N LINE_NUMBER'
'--first-line-number=LINE_NUMBER'
     Start line counting with the number LINE_NUMBER at first line of
     first page printed (in most cases not the first line of the input
     file).

'-o MARGIN'
'--indent=MARGIN'
     Indent each line with a margin MARGIN spaces wide (default is
     zero).  The total page width is the size of the margin plus the
     PAGE_WIDTH set with the '-W/-w' option.  A limited overflow may
     occur with numbered single column output (compare '-n' option).

'-r'
'--no-file-warnings'
     Do not print a warning message when an argument FILE cannot be
     opened.  (The exit status will still be nonzero, however.)

'-s[CHAR]'
'--separator[=CHAR]'
     Separate columns by a single character CHAR.  The default for CHAR
     is the TAB character without '-w' and 'no character' with '-w'.
     Without '-s' the default separator 'space' is set.  '-s[char]'
     turns off line truncation of all three column options
     ('-COLUMN'|'-a -COLUMN'|'-m') unless '-w' is set.  This is a
     POSIX-compliant formulation.

'-S[STRING]'
'--sep-string[=STRING]'
     Use STRING to separate output columns.  The '-S' option doesn't
     affect the '-W/-w' option, unlike the '-s' option which does.  It
     does not affect line truncation or column alignment.  Without '-S',
     and with '-J', 'pr' uses the default output separator, TAB.
     Without '-S' or '-J', 'pr' uses a 'space' (same as '-S" "').  If no
     'STRING' argument is specified, '""' is assumed.

'-t'
'--omit-header'
     Do not print the usual header [and footer] on each page, and do not
     fill out the bottom of pages (with blank lines or a form feed).  No
     page structure is produced, but form feeds set in the input files
     are retained.  The predefined pagination is not changed.  '-t' or
     '-T' may be useful together with other options; e.g.: '-t -e4',
     expand TAB characters in the input file to 4 spaces but don't make
     any other changes.  Use of '-t' overrides '-h'.

'-T'
'--omit-pagination'
     Do not print header [and footer].  In addition eliminate all form
     feeds set in the input files.

'-v'
'--show-nonprinting'
     Print nonprinting characters in octal backslash notation.

'-w PAGE_WIDTH'
'--width=PAGE_WIDTH'
     Set page width to PAGE_WIDTH characters for multiple text-column
     output only (default for PAGE_WIDTH is 72).  '-s[CHAR]' turns off
     the default page width and any line truncation and column
     alignment.  Lines of full length are merged, regardless of the
     column options set.  No PAGE_WIDTH setting is possible with single
     column output.  A POSIX-compliant formulation.

'-W PAGE_WIDTH'
'--page_width=PAGE_WIDTH'
     Set the page width to PAGE_WIDTH characters.  That's valid with and
     without a column option.  Text lines are truncated, unless '-J' is
     used.  Together with one of the three column options ('-COLUMN',
     '-a -COLUMN' or '-m') column alignment is always used.  The
     separator options '-S' or '-s' don't affect the '-W' option.
     Default is 72 characters.  Without '-W PAGE_WIDTH' and without any
     of the column options NO line truncation is used (defined to keep
     downward compatibility and to meet most frequent tasks).  That's
     equivalent to '-W 72 -J'.  The header line is never truncated.

   An exit status of zero indicates success, and a nonzero value
indicates failure.

