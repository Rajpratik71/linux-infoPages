File: coreutils.info,  Node: seq invocation,  Prev: factor invocation,  Up: Numeric operations

26.2 'seq': Print numeric sequences
===================================

'seq' prints a sequence of numbers to standard output.  Synopses:

     seq [OPTION]... LAST
     seq [OPTION]... FIRST LAST
     seq [OPTION]... FIRST INCREMENT LAST

   'seq' prints the numbers from FIRST to LAST by INCREMENT.  By
default, each number is printed on a separate line.  When INCREMENT is
not specified, it defaults to '1', even when FIRST is larger than LAST.
FIRST also defaults to '1'.  So 'seq 1' prints '1', but 'seq 0' and 'seq
10 5' produce no output.  The sequence of numbers ends when the sum of
the current number and INCREMENT would become greater than LAST, so 'seq
1 10 10' only produces '1'.  Floating-point numbers may be specified.
*Note Floating point::.

   The program accepts the following options.  Also see *note Common
options::.  Options must precede operands.

'-f FORMAT'
'--format=FORMAT'
     Print all numbers using FORMAT.  FORMAT must contain exactly one of
     the 'printf'-style floating point conversion specifications '%a',
     '%e', '%f', '%g', '%A', '%E', '%F', '%G'.  The '%' may be followed
     by zero or more flags taken from the set '-+#0 '', then an optional
     width containing one or more digits, then an optional precision
     consisting of a '.' followed by zero or more digits.  FORMAT may
     also contain any number of '%%' conversion specifications.  All
     conversion specifications have the same meaning as with 'printf'.

     The default format is derived from FIRST, STEP, and LAST.  If these
     all use a fixed point decimal representation, the default format is
     '%.Pf', where P is the minimum precision that can represent the
     output numbers exactly.  Otherwise, the default format is '%g'.

'-s STRING'
'--separator=STRING'
     Separate numbers with STRING; default is a newline.  The output
     always terminates with a newline.

'-w'
'--equal-width'
     Print all numbers with the same width, by padding with leading
     zeros.  FIRST, STEP, and LAST should all use a fixed point decimal
     representation.  (To have other kinds of padding, use '--format').

   You can get finer-grained control over output with '-f':

     $ seq -f '(%9.2E)' -9e5 1.1e6 1.3e6
     (-9.00E+05)
     ( 2.00E+05)
     ( 1.30E+06)

   If you want hexadecimal integer output, you can use 'printf' to
perform the conversion:

     $ printf '%x\n' $(seq 1048575 1024 1050623)
     fffff
     1003ff
     1007ff

   For very long lists of numbers, use xargs to avoid system limitations
on the length of an argument list:

     $ seq 1000000 | xargs printf '%x\n' | tail -n 3
     f423e
     f423f
     f4240

   To generate octal output, use the printf '%o' format instead of '%x'.

   On most systems, seq can produce whole-number output for values up to
at least 2^{53}.  Larger integers are approximated.  The details differ
depending on your floating-point implementation.  *Note Floating
point::.  A common case is that 'seq' works with integers through
2^{64}, and larger integers may not be numerically correct:

     $ seq 50000000000000000000 2 50000000000000000004
     50000000000000000000
     50000000000000000000
     50000000000000000004

   However, note that when limited to non-negative whole numbers, an
increment of 1 and no format-specifying option, seq can print
arbitrarily large numbers.

   Be careful when using 'seq' with outlandish values: otherwise you may
see surprising results, as 'seq' uses floating point internally.  For
example, on the x86 platform, where the internal representation uses a
64-bit fraction, the command:

     seq 1 0.0000000000000000001 1.0000000000000000009

   outputs 1.0000000000000000007 twice and skips 1.0000000000000000008.

   An exit status of zero indicates success, and a nonzero value
indicates failure.

