File: libc.info,  Node: The Lame Way to Locale Data,  Next: The Elegant and Fast Way,  Up: Locale Information

7.7.1 `localeconv': It is portable but ...
------------------------------------------

Together with the `setlocale' function the ISO C people invented the
`localeconv' function.  It is a masterpiece of poor design.  It is
expensive to use, not extendable, and not generally usable as it
provides access to only `LC_MONETARY' and `LC_NUMERIC' related
information.  Nevertheless, if it is applicable to a given situation it
should be used since it is very portable.  The function `strfmon'
formats monetary amounts according to the selected locale using this
information.  

 -- Function: struct lconv * localeconv (void)
     Preliminary: | MT-Unsafe race:localeconv locale | AS-Unsafe |
     AC-Safe | *Note POSIX Safety Concepts::.

     The `localeconv' function returns a pointer to a structure whose
     components contain information about how numeric and monetary
     values should be formatted in the current locale.

     You should not modify the structure or its contents.  The
     structure might be overwritten by subsequent calls to
     `localeconv', or by calls to `setlocale', but no other function in
     the library overwrites this value.

 -- Data Type: struct lconv
     `localeconv''s return value is of this data type.  Its elements are
     described in the following subsections.

   If a member of the structure `struct lconv' has type `char', and the
value is `CHAR_MAX', it means that the current locale has no value for
that parameter.

* Menu:

* General Numeric::             Parameters for formatting numbers and
                                 currency amounts.
* Currency Symbol::             How to print the symbol that identifies an
                                 amount of money (e.g. `$').
* Sign of Money Amount::        How to print the (positive or negative) sign
                                 for a monetary amount, if one exists.

File: libc.info,  Node: General Numeric,  Next: Currency Symbol,  Up: The Lame Way to Locale Data

7.7.1.1 Generic Numeric Formatting Parameters
.............................................

These are the standard members of `struct lconv'; there may be others.

`char *decimal_point'
`char *mon_decimal_point'
     These are the decimal-point separators used in formatting
     non-monetary and monetary quantities, respectively.  In the `C'
     locale, the value of `decimal_point' is `"."', and the value of
     `mon_decimal_point' is `""'.  

`char *thousands_sep'
`char *mon_thousands_sep'
     These are the separators used to delimit groups of digits to the
     left of the decimal point in formatting non-monetary and monetary
     quantities, respectively.  In the `C' locale, both members have a
     value of `""' (the empty string).

`char *grouping'
`char *mon_grouping'
     These are strings that specify how to group the digits to the left
     of the decimal point.  `grouping' applies to non-monetary
     quantities and `mon_grouping' applies to monetary quantities.  Use
     either `thousands_sep' or `mon_thousands_sep' to separate the digit
     groups.  

     Each member of these strings is to be interpreted as an integer
     value of type `char'.  Successive numbers (from left to right)
     give the sizes of successive groups (from right to left, starting
     at the decimal point.)  The last member is either `0', in which
     case the previous member is used over and over again for all the
     remaining groups, or `CHAR_MAX', in which case there is no more
     grouping--or, put another way, any remaining digits form one large
     group without separators.

     For example, if `grouping' is `"\04\03\02"', the correct grouping
     for the number `123456787654321' is `12', `34', `56', `78', `765',
     `4321'.  This uses a group of 4 digits at the end, preceded by a
     group of 3 digits, preceded by groups of 2 digits (as many as
     needed).  With a separator of `,', the number would be printed as
     `12,34,56,78,765,4321'.

     A value of `"\03"' indicates repeated groups of three digits, as
     normally used in the U.S.

     In the standard `C' locale, both `grouping' and `mon_grouping'
     have a value of `""'.  This value specifies no grouping at all.

`char int_frac_digits'
`char frac_digits'
     These are small integers indicating how many fractional digits (to
     the right of the decimal point) should be displayed in a monetary
     value in international and local formats, respectively.  (Most
     often, both members have the same value.)

     In the standard `C' locale, both of these members have the value
     `CHAR_MAX', meaning "unspecified".  The ISO standard doesn't say
     what to do when you find this value; we recommend printing no
     fractional digits.  (This locale also specifies the empty string
     for `mon_decimal_point', so printing any fractional digits would be
     confusing!)

File: libc.info,  Node: Currency Symbol,  Next: Sign of Money Amount,  Prev: General Numeric,  Up: The Lame Way to Locale Data

7.7.1.2 Printing the Currency Symbol
....................................

These members of the `struct lconv' structure specify how to print the
symbol to identify a monetary value--the international analog of `$'
for US dollars.

   Each country has two standard currency symbols.  The "local currency
symbol" is used commonly within the country, while the "international
currency symbol" is used internationally to refer to that country's
currency when it is necessary to indicate the country unambiguously.

   For example, many countries use the dollar as their monetary unit,
and when dealing with international currencies it's important to specify
that one is dealing with (say) Canadian dollars instead of U.S. dollars
or Australian dollars.  But when the context is known to be Canada,
there is no need to make this explicit--dollar amounts are implicitly
assumed to be in Canadian dollars.

`char *currency_symbol'
     The local currency symbol for the selected locale.

     In the standard `C' locale, this member has a value of `""' (the
     empty string), meaning "unspecified".  The ISO standard doesn't
     say what to do when you find this value; we recommend you simply
     print the empty string as you would print any other string pointed
     to by this variable.

`char *int_curr_symbol'
     The international currency symbol for the selected locale.

     The value of `int_curr_symbol' should normally consist of a
     three-letter abbreviation determined by the international standard
     `ISO 4217 Codes for the Representation of Currency and Funds',
     followed by a one-character separator (often a space).

     In the standard `C' locale, this member has a value of `""' (the
     empty string), meaning "unspecified".  We recommend you simply
     print the empty string as you would print any other string pointed
     to by this variable.

`char p_cs_precedes'
`char n_cs_precedes'
`char int_p_cs_precedes'
`char int_n_cs_precedes'
     These members are `1' if the `currency_symbol' or
     `int_curr_symbol' strings should precede the value of a monetary
     amount, or `0' if the strings should follow the value.  The
     `p_cs_precedes' and `int_p_cs_precedes' members apply to positive
     amounts (or zero), and the `n_cs_precedes' and `int_n_cs_precedes'
     members apply to negative amounts.

     In the standard `C' locale, all of these members have a value of
     `CHAR_MAX', meaning "unspecified".  The ISO standard doesn't say
     what to do when you find this value.  We recommend printing the
     currency symbol before the amount, which is right for most
     countries.  In other words, treat all nonzero values alike in
     these members.

     The members with the `int_' prefix apply to the `int_curr_symbol'
     while the other two apply to `currency_symbol'.

`char p_sep_by_space'
`char n_sep_by_space'
`char int_p_sep_by_space'
`char int_n_sep_by_space'
     These members are `1' if a space should appear between the
     `currency_symbol' or `int_curr_symbol' strings and the amount, or
     `0' if no space should appear.  The `p_sep_by_space' and
     `int_p_sep_by_space' members apply to positive amounts (or zero),
     and the `n_sep_by_space' and `int_n_sep_by_space' members apply to
     negative amounts.

     In the standard `C' locale, all of these members have a value of
     `CHAR_MAX', meaning "unspecified".  The ISO standard doesn't say
     what you should do when you find this value; we suggest you treat
     it as 1 (print a space).  In other words, treat all nonzero values
     alike in these members.

     The members with the `int_' prefix apply to the `int_curr_symbol'
     while the other two apply to `currency_symbol'.  There is one
     specialty with the `int_curr_symbol', though.  Since all legal
     values contain a space at the end the string one either printf
     this space (if the currency symbol must appear in front and must
     be separated) or one has to avoid printing this character at all
     (especially when at the end of the string).

File: libc.info,  Node: Sign of Money Amount,  Prev: Currency Symbol,  Up: The Lame Way to Locale Data

7.7.1.3 Printing the Sign of a Monetary Amount
..............................................

These members of the `struct lconv' structure specify how to print the
sign (if any) of a monetary value.

`char *positive_sign'
`char *negative_sign'
     These are strings used to indicate positive (or zero) and negative
     monetary quantities, respectively.

     In the standard `C' locale, both of these members have a value of
     `""' (the empty string), meaning "unspecified".

     The ISO standard doesn't say what to do when you find this value;
     we recommend printing `positive_sign' as you find it, even if it is
     empty.  For a negative value, print `negative_sign' as you find it
     unless both it and `positive_sign' are empty, in which case print
     `-' instead.  (Failing to indicate the sign at all seems rather
     unreasonable.)

`char p_sign_posn'
`char n_sign_posn'
`char int_p_sign_posn'
`char int_n_sign_posn'
     These members are small integers that indicate how to position the
     sign for nonnegative and negative monetary quantities,
     respectively.  (The string used by the sign is what was specified
     with `positive_sign' or `negative_sign'.)  The possible values are
     as follows:

    `0'
          The currency symbol and quantity should be surrounded by
          parentheses.

    `1'
          Print the sign string before the quantity and currency symbol.

    `2'
          Print the sign string after the quantity and currency symbol.

    `3'
          Print the sign string right before the currency symbol.

    `4'
          Print the sign string right after the currency symbol.

    `CHAR_MAX'
          "Unspecified".  Both members have this value in the standard
          `C' locale.

     The ISO standard doesn't say what you should do when the value is
     `CHAR_MAX'.  We recommend you print the sign after the currency
     symbol.

     The members with the `int_' prefix apply to the `int_curr_symbol'
     while the other two apply to `currency_symbol'.

