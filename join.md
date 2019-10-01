File: coreutils.info,  Node: join invocation,  Prev: paste invocation,  Up: Operating on fields

8.3 'join': Join lines on a common field
========================================

'join' writes to standard output a line for each pair of input lines
that have identical join fields.  Synopsis:

     join [OPTION]... FILE1 FILE2

   Either FILE1 or FILE2 (but not both) can be '-', meaning standard
input.  FILE1 and FILE2 should be sorted on the join fields.

   Normally, the sort order is that of the collating sequence specified
by the 'LC_COLLATE' locale.  Unless the '-t' option is given, the sort
comparison ignores blanks at the start of the join field, as in 'sort
-b'.  If the '--ignore-case' option is given, the sort comparison
ignores the case of characters in the join field, as in 'sort -f'.

   The 'sort' and 'join' commands should use consistent locales and
options if the output of 'sort' is fed to 'join'.  You can use a command
like 'sort -k 1b,1' to sort a file on its default join field, but if you
select a non-default locale, join field, separator, or comparison
options, then you should do so consistently between 'join' and 'sort'.
If 'join -t ''' is specified then the whole line is considered which
matches the default operation of sort.

   If the input has no unpairable lines, a GNU extension is available;
the sort order can be any order that considers two fields to be equal if
and only if the sort comparison described above considers them to be
equal.  For example:

     $ cat file1
     a a1
     c c1
     b b1
     $ cat file2
     a a2
     c c2
     b b2
     $ join file1 file2
     a a1 a2
     c c1 c2
     b b1 b2

   If the '--check-order' option is given, unsorted inputs will cause a
fatal error message.  If the option '--nocheck-order' is given, unsorted
inputs will never cause an error message.  If neither of these options
is given, wrongly sorted inputs are diagnosed only if an input file is
found to contain unpairable lines, and when both input files are non
empty.  If an input file is diagnosed as being unsorted, the 'join'
command will exit with a nonzero status (and the output should not be
used).

   Forcing 'join' to process wrongly sorted input files containing
unpairable lines by specifying '--nocheck-order' is not guaranteed to
produce any particular output.  The output will probably not correspond
with whatever you hoped it would be.

   The defaults are:
   * the join field is the first field in each line;
   * fields in the input are separated by one or more blanks, with
     leading blanks on the line ignored;
   * fields in the output are separated by a space;
   * each output line consists of the join field, the remaining fields
     from FILE1, then the remaining fields from FILE2.

   The program accepts the following options.  Also see *note Common
options::.

'-a FILE-NUMBER'
     Print a line for each unpairable line in file FILE-NUMBER (either
     '1' or '2'), in addition to the normal output.

'--check-order'
     Fail with an error message if either input file is wrongly ordered.

'--nocheck-order'
     Do not check that both input files are in sorted order.  This is
     the default.

'-e STRING'
     Replace those output fields that are missing in the input with
     STRING.  I.e., missing fields specified with the '-12jo' options.

'--header'
     Treat the first line of each input file as a header line.  The
     header lines will be joined and printed as the first output line.
     If '-o' is used to specify output format, the header line will be
     printed according to the specified format.  The header lines will
     not be checked for ordering even if '--check-order' is specified.
     Also if the header lines from each file do not match, the heading
     fields from the first file will be used.

'-i'
'--ignore-case'
     Ignore differences in case when comparing keys.  With this option,
     the lines of the input files must be ordered in the same way.  Use
     'sort -f' to produce this ordering.

'-1 FIELD'
     Join on field FIELD (a positive integer) of file 1.

'-2 FIELD'
     Join on field FIELD (a positive integer) of file 2.

'-j FIELD'
     Equivalent to '-1 FIELD -2 FIELD'.

'-o FIELD-LIST'
'-o auto'
     If the keyword 'auto' is specified, infer the output format from
     the first line in each file.  This is the same as the default
     output format but also ensures the same number of fields are output
     for each line.  Missing fields are replaced with the '-e' option
     and extra fields are discarded.

     Otherwise, construct each output line according to the format in
     FIELD-LIST.  Each element in FIELD-LIST is either the single
     character '0' or has the form M.N where the file number, M, is '1'
     or '2' and N is a positive field number.

     A field specification of '0' denotes the join field.  In most
     cases, the functionality of the '0' field spec may be reproduced
     using the explicit M.N that corresponds to the join field.
     However, when printing unpairable lines (using either of the '-a'
     or '-v' options), there is no way to specify the join field using
     M.N in FIELD-LIST if there are unpairable lines in both files.  To
     give 'join' that functionality, POSIX invented the '0' field
     specification notation.

     The elements in FIELD-LIST are separated by commas or blanks.
     Blank separators typically need to be quoted for the shell.  For
     example, the commands 'join -o 1.2,2.2' and 'join -o '1.2 2.2'' are
     equivalent.

     All output lines--including those printed because of any -a or -v
     option--are subject to the specified FIELD-LIST.

'-t CHAR'
     Use character CHAR as the input and output field separator.  Treat
     as significant each occurrence of CHAR in the input file.  Use
     'sort -t CHAR', without the '-b' option of 'sort', to produce this
     ordering.  If 'join -t ''' is specified, the whole line is
     considered, matching the default operation of sort.  If '-t '\0''
     is specified then the ASCII NUL character is used to delimit the
     fields.

'-v FILE-NUMBER'
     Print a line for each unpairable line in file FILE-NUMBER (either
     '1' or '2'), instead of the normal output.

'-z'
'--zero-terminated'
     Delimit items with a zero byte rather than a newline (ASCII LF).
     I.e., treat input as items separated by ASCII NUL and terminate
     output items with ASCII NUL. This option can be useful in
     conjunction with 'perl -0' or 'find -print0' and 'xargs -0' which
     do the same in order to reliably handle arbitrary file names (even
     those containing blanks or other special characters).

   An exit status of zero indicates success, and a nonzero value
indicates failure.

