File: coreutils.info,  Node: tsort invocation,  Prev: ptx invocation,  Up: Operating on sorted files

7.6 'tsort': Topological sort
=============================

'tsort' performs a topological sort on the given FILE, or standard input
if no input file is given or for a FILE of '-'.  For more details and
some history, see *note tsort background::.  Synopsis:

     tsort [OPTION] [FILE]

   'tsort' reads its input as pairs of strings, separated by blanks,
indicating a partial ordering.  The output is a total ordering that
corresponds to the given partial ordering.

   For example

     tsort <<EOF
     a b c
     d
     e f
     b c d e
     EOF

will produce the output

     a
     b
     c
     d
     e
     f

   Consider a more realistic example.  You have a large set of functions
all in one file, and they may all be declared static except one.
Currently that one (say 'main') is the first function defined in the
file, and the ones it calls directly follow it, followed by those they
call, etc.  Let's say that you are determined to take advantage of
prototypes, so you have to choose between declaring all of those
functions (which means duplicating a lot of information from the
definitions) and rearranging the functions so that as many as possible
are defined before they are used.  One way to automate the latter
process is to get a list for each function of the functions it calls
directly.  Many programs can generate such lists.  They describe a call
graph.  Consider the following list, in which a given line indicates
that the function on the left calls the one on the right directly.

     main parse_options
     main tail_file
     main tail_forever
     tail_file pretty_name
     tail_file write_header
     tail_file tail
     tail_forever recheck
     tail_forever pretty_name
     tail_forever write_header
     tail_forever dump_remainder
     tail tail_lines
     tail tail_bytes
     tail_lines start_lines
     tail_lines dump_remainder
     tail_lines file_lines
     tail_lines pipe_lines
     tail_bytes xlseek
     tail_bytes start_bytes
     tail_bytes dump_remainder
     tail_bytes pipe_bytes
     file_lines dump_remainder
     recheck pretty_name

   then you can use 'tsort' to produce an ordering of those functions
that satisfies your requirement.

     example$ tsort call-graph | tac
     dump_remainder
     start_lines
     file_lines
     pipe_lines
     xlseek
     start_bytes
     pipe_bytes
     tail_lines
     tail_bytes
     pretty_name
     write_header
     tail
     recheck
     parse_options
     tail_file
     tail_forever
     main

   'tsort' detects any cycles in the input and writes the first cycle
encountered to standard error.

   Note that for a given partial ordering, generally there is no unique
total ordering.  In the context of the call graph above, the function
'parse_options' may be placed anywhere in the list as long as it
precedes 'main'.

   The only options are '--help' and '--version'.  *Note Common
options::.

   An exit status of zero indicates success, and a nonzero value
indicates failure.

* Menu:

* tsort background::            Where tsort came from.

File: coreutils.info,  Node: tsort background,  Up: tsort invocation

7.6.1 'tsort': Background
-------------------------

'tsort' exists because very early versions of the Unix linker processed
an archive file exactly once, and in order.  As 'ld' read each object in
the archive, it decided whether it was needed in the program based on
whether it defined any symbols which were undefined at that point in the
link.

   This meant that dependencies within the archive had to be handled
specially.  For example, 'scanf' probably calls 'read'.  That means that
in a single pass through an archive, it was important for 'scanf.o' to
appear before read.o, because otherwise a program which calls 'scanf'
but not 'read' might end up with an unexpected unresolved reference to
'read'.

   The way to address this problem was to first generate a set of
dependencies of one object file on another.  This was done by a shell
script called 'lorder'.  The GNU tools don't provide a version of
lorder, as far as I know, but you can still find it in BSD
distributions.

   Then you ran 'tsort' over the 'lorder' output, and you used the
resulting sort to define the order in which you added objects to the
archive.

   This whole procedure has been obsolete since about 1980, because Unix
archives now contain a symbol table (traditionally built by 'ranlib',
now generally built by 'ar' itself), and the Unix linker uses the symbol
table to effectively make multiple passes over an archive file.

   Anyhow, that's where tsort came from.  To solve an old problem with
the way the linker handled archive files, which has since been solved in
different ways.

