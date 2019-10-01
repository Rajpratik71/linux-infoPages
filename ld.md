File: libc.info,  Node: Normalization Functions,  Next: Rounding Functions,  Prev: Absolute Value,  Up: Arithmetic Functions

20.8.2 Normalization Functions
------------------------------

The functions described in this section are primarily provided as a way
to efficiently perform certain low-level manipulations on floating point
numbers that are represented internally using a binary radix; see *note
Floating Point Concepts::.  These functions are required to have
equivalent behavior even if the representation does not use a radix of
2, but of course they are unlikely to be particularly efficient in those
cases.

   All these functions are declared in 'math.h'.

 -- Function: double frexp (double VALUE, int *EXPONENT)
 -- Function: float frexpf (float VALUE, int *EXPONENT)
 -- Function: long double frexpl (long double VALUE, int *EXPONENT)
     Preliminary: | MT-Safe | AS-Safe | AC-Safe | *Note POSIX Safety
     Concepts::.

     These functions are used to split the number VALUE into a
     normalized fraction and an exponent.

     If the argument VALUE is not zero, the return value is VALUE times
     a power of two, and its magnitude is always in the range 1/2
     (inclusive) to 1 (exclusive).  The corresponding exponent is stored
     in '*EXPONENT'; the return value multiplied by 2 raised to this
     exponent equals the original number VALUE.

     For example, 'frexp (12.8, &exponent)' returns '0.8' and stores '4'
     in 'exponent'.

     If VALUE is zero, then the return value is zero and zero is stored
     in '*EXPONENT'.

 -- Function: double ldexp (double VALUE, int EXPONENT)
 -- Function: float ldexpf (float VALUE, int EXPONENT)
 -- Function: long double ldexpl (long double VALUE, int EXPONENT)
     Preliminary: | MT-Safe | AS-Safe | AC-Safe | *Note POSIX Safety
     Concepts::.

     These functions return the result of multiplying the floating-point
     number VALUE by 2 raised to the power EXPONENT.  (It can be used to
     reassemble floating-point numbers that were taken apart by
     'frexp'.)

     For example, 'ldexp (0.8, 4)' returns '12.8'.

   The following functions, which come from BSD, provide facilities
equivalent to those of 'ldexp' and 'frexp'.  See also the ISO C function
'logb' which originally also appeared in BSD.

 -- Function: double scalb (double VALUE, double EXPONENT)
 -- Function: float scalbf (float VALUE, float EXPONENT)
 -- Function: long double scalbl (long double VALUE, long double
          EXPONENT)
     Preliminary: | MT-Safe | AS-Safe | AC-Safe | *Note POSIX Safety
     Concepts::.

     The 'scalb' function is the BSD name for 'ldexp'.

 -- Function: double scalbn (double X, int N)
 -- Function: float scalbnf (float X, int N)
 -- Function: long double scalbnl (long double X, int N)
     Preliminary: | MT-Safe | AS-Safe | AC-Safe | *Note POSIX Safety
     Concepts::.

     'scalbn' is identical to 'scalb', except that the exponent N is an
     'int' instead of a floating-point number.

 -- Function: double scalbln (double X, long int N)
 -- Function: float scalblnf (float X, long int N)
 -- Function: long double scalblnl (long double X, long int N)
     Preliminary: | MT-Safe | AS-Safe | AC-Safe | *Note POSIX Safety
     Concepts::.

     'scalbln' is identical to 'scalb', except that the exponent N is a
     'long int' instead of a floating-point number.

 -- Function: double significand (double X)
 -- Function: float significandf (float X)
 -- Function: long double significandl (long double X)
     Preliminary: | MT-Safe | AS-Safe | AC-Safe | *Note POSIX Safety
     Concepts::.

     'significand' returns the mantissa of X scaled to the range [1, 2).
     It is equivalent to 'scalb (X, (double) -ilogb (X))'.

     This function exists mainly for use in certain standardized tests
     of IEEE 754 conformance.

