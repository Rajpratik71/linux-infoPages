File: libc.info,  Node: Inverse Trig Functions,  Next: Exponents and Logarithms,  Prev: Trig Functions,  Up: Mathematics

19.3 Inverse Trigonometric Functions
====================================

These are the usual arc sine, arc cosine and arc tangent functions,
which are the inverses of the sine, cosine and tangent functions
respectively.

 -- Function: double asin (double X)
 -- Function: float asinf (float X)
 -- Function: long double asinl (long double X)
     Preliminary: | MT-Safe | AS-Safe | AC-Safe | *Note POSIX Safety
     Concepts::.

     These functions compute the arc sine of X--that is, the value whose
     sine is X.  The value is in units of radians.  Mathematically,
     there are infinitely many such values; the one actually returned is
     the one between '-pi/2' and 'pi/2' (inclusive).

     The arc sine function is defined mathematically only over the
     domain '-1' to '1'.  If X is outside the domain, 'asin' signals a
     domain error.

 -- Function: double acos (double X)
 -- Function: float acosf (float X)
 -- Function: long double acosl (long double X)
     Preliminary: | MT-Safe | AS-Safe | AC-Safe | *Note POSIX Safety
     Concepts::.

     These functions compute the arc cosine of X--that is, the value
     whose cosine is X.  The value is in units of radians.
     Mathematically, there are infinitely many such values; the one
     actually returned is the one between '0' and 'pi' (inclusive).

     The arc cosine function is defined mathematically only over the
     domain '-1' to '1'.  If X is outside the domain, 'acos' signals a
     domain error.

 -- Function: double atan (double X)
 -- Function: float atanf (float X)
 -- Function: long double atanl (long double X)
     Preliminary: | MT-Safe | AS-Safe | AC-Safe | *Note POSIX Safety
     Concepts::.

     These functions compute the arc tangent of X--that is, the value
     whose tangent is X.  The value is in units of radians.
     Mathematically, there are infinitely many such values; the one
     actually returned is the one between '-pi/2' and 'pi/2'
     (inclusive).

 -- Function: double atan2 (double Y, double X)
 -- Function: float atan2f (float Y, float X)
 -- Function: long double atan2l (long double Y, long double X)
     Preliminary: | MT-Safe | AS-Safe | AC-Safe | *Note POSIX Safety
     Concepts::.

     This function computes the arc tangent of Y/X, but the signs of
     both arguments are used to determine the quadrant of the result,
     and X is permitted to be zero.  The return value is given in
     radians and is in the range '-pi' to 'pi', inclusive.

     If X and Y are coordinates of a point in the plane, 'atan2' returns
     the signed angle between the line from the origin to that point and
     the x-axis.  Thus, 'atan2' is useful for converting Cartesian
     coordinates to polar coordinates.  (To compute the radial
     coordinate, use 'hypot'; see *note Exponents and Logarithms::.)

     If both X and Y are zero, 'atan2' returns zero.

   ISO C99 defines complex versions of the inverse trig functions.

 -- Function: complex double casin (complex double Z)
 -- Function: complex float casinf (complex float Z)
 -- Function: complex long double casinl (complex long double Z)
     Preliminary: | MT-Safe | AS-Safe | AC-Safe | *Note POSIX Safety
     Concepts::.

     These functions compute the complex arc sine of Z--that is, the
     value whose sine is Z.  The value returned is in radians.

     Unlike the real-valued functions, 'casin' is defined for all values
     of Z.

 -- Function: complex double cacos (complex double Z)
 -- Function: complex float cacosf (complex float Z)
 -- Function: complex long double cacosl (complex long double Z)
     Preliminary: | MT-Safe | AS-Safe | AC-Safe | *Note POSIX Safety
     Concepts::.

     These functions compute the complex arc cosine of Z--that is, the
     value whose cosine is Z.  The value returned is in radians.

     Unlike the real-valued functions, 'cacos' is defined for all values
     of Z.

 -- Function: complex double catan (complex double Z)
 -- Function: complex float catanf (complex float Z)
 -- Function: complex long double catanl (complex long double Z)
     Preliminary: | MT-Safe | AS-Safe | AC-Safe | *Note POSIX Safety
     Concepts::.

     These functions compute the complex arc tangent of Z--that is, the
     value whose tangent is Z.  The value is in units of radians.

