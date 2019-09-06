File: coreutils.info,  Node: factor invocation,  Next: numfmt invocation,  Up: Numeric operations

25.1 `factor': Print prime factors
==================================

`factor' prints prime factors.  Synopses:

     factor [NUMBER]...
     factor OPTION

   If no NUMBER is specified on the command line, `factor' reads
numbers from standard input, delimited by newlines, tabs, or spaces.

   The `factor' command supports only a small number of options:

`--help'
     Print a short help on standard output, then exit without further
     processing.

`--version'
     Print the program version on standard output, then exit without
     further processing.

   Factoring the product of the eighth and ninth Mersenne primes takes
about 30 milliseconds of CPU time on a 2.2 GHz Athlon.

     M8=$(echo 2^31-1|bc)
     M9=$(echo 2^61-1|bc)
     n=$(echo "$M8 * $M9" | bc)
     /usr/bin/time -f %U factor $n
     4951760154835678088235319297: 2147483647 2305843009213693951
     0.03

   Similarly, factoring the eighth Fermat number 2^256+1 takes about 20
seconds on the same machine.

   Factoring large numbers is, in general, hard.  The Pollard-Brent rho
algorithm used by `factor' is particularly effective for numbers with
relatively small factors.  If you wish to factor large numbers which do
not have small factors (for example, numbers which are the product of
two large primes), other methods are far better.

   If `factor' is built without using GNU MP, only single-precision
arithmetic is available, and so large numbers (typically 2^128 and
above) will not be supported.  The single-precision code uses an
algorithm which is designed for factoring smaller numbers.

   An exit status of zero indicates success, and a nonzero value
indicates failure.

