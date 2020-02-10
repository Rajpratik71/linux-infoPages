LOCALE(1)                                                                                   Linux User Manual                                                                                   LOCALE(1)

NAME
       locale - get locale-specific information

SYNOPSIS
       locale [option]
       locale [option] -a
       locale [option] -m
       locale [option] name...

DESCRIPTION
       The locale command displays information about the current locale, or all locales, on standard output.

       When  invoked  without arguments, locale displays the current locale settings for each locale category (see locale(5)), based on the settings of the environment variables that control the locale
       (see locale(7)).  Values for variables set in the environment are printed without double quotes, implied values are printed with double quotes.

       If either the -a or the -m option (or one of their long-format equivalents) is specified, the behavior is as follows:

       -a, --all-locales
              Display a list of all available locales.  The -v option causes the LC_IDENTIFICATION metadata about each locale to be included in the output.

       -m, --charmaps
              Display the available charmaps (character set description files).

       The locale command can also be provided with one or more arguments, which are the names of locale keywords (for example, date_fmt, ctype-class-names, yesexpr, or decimal_point) or  locale  cate‐
       gories (for example, LC_CTYPE or LC_TIME).  For each argument, the following is displayed:

       *  For a locale keyword, the value of that keyword to be displayed.

       *  For a locale category, the values of all keywords in that category are displayed.

       When arguments are supplied, the following options are meaningful:

       -c, --category-name
              For a category name argument, write the name of the locale category on a separate line preceding the list of keyword values for that category.

              For a keyword name argument, write the name of the locale category for this keyword on a separate line preceding the keyword value.

              This option improves readability when multiple name arguments are specified.  It can be combined with the -k option.

       -k, --keyword-name
              For each keyword whose value is being displayed, include also the name of that keyword, so that the output has the format:

                  keyword="value"

       The locale command also knows about the following options:

       -v, --verbose
              Display additional information for some command-line option and argument combinations.

       -?, --help
              Display a summary of command-line options and arguments and exit.

       --usage
              Display a short usage message and exit.

       -V, --version
              Display the program version and exit.

FILES
       /usr/lib/locale/locale-archive
              Usual default locale archive location.

       /usr/share/i18n/locales
              Usual default path for locale definition files.

CONFORMING TO
       POSIX.1-2001, POSIX.1-2008.

EXAMPLE
       $ locale
       LANG=en_US.UTF-8
       LC_CTYPE="en_US.UTF-8"
       LC_NUMERIC="en_US.UTF-8"
       LC_TIME="en_US.UTF-8"
       LC_COLLATE="en_US.UTF-8"
       LC_MONETARY="en_US.UTF-8"
       LC_MESSAGES="en_US.UTF-8"
       LC_PAPER="en_US.UTF-8"
       LC_NAME="en_US.UTF-8"
       LC_ADDRESS="en_US.UTF-8"
       LC_TELEPHONE="en_US.UTF-8"
       LC_MEASUREMENT="en_US.UTF-8"
       LC_IDENTIFICATION="en_US.UTF-8"
       LC_ALL=

       $ locale date_fmt
       %a %b %e %H:%M:%S %Z %Y

       $ locale -k date_fmt
       date_fmt="%a %b %e %H:%M:%S %Z %Y"

       $ locale -ck date_fmt
       LC_TIME
       date_fmt="%a %b %e %H:%M:%S %Z %Y"

       $ locale LC_TELEPHONE
       +%c (%a) %l
       (%a) %l
       11
       1
       UTF-8

       $ locale -k LC_TELEPHONE
       tel_int_fmt="+%c (%a) %l"
       tel_dom_fmt="(%a) %l"
       int_select="11"
       int_prefix="1"
       telephone-codeset="UTF-8"

       The  following example compiles a custom locale from the ./wrk directory with the localedef(1) utility under the $HOME/.locale directory, then tests the result with the date(1) command, and then
       sets the environment variables LOCPATH and LANG in the shell profile file so that the custom locale will be used in the subsequent user sessions:

       $ mkdir -p $HOME/.locale
       $ I18NPATH=./wrk/ localedef -f UTF-8 -i fi_SE $HOME/.locale/fi_SE.UTF-8
       $ LOCPATH=$HOME/.locale LC_ALL=fi_SE.UTF-8 date
       $ echo "export LOCPATH=\$HOME/.locale" >> $HOME/.bashrc
       $ echo "export LANG=fi_SE.UTF-8" >> $HOME/.bashrc

SEE ALSO
       localedef(1), charmap(5), locale(5), locale(7)

COLOPHON
       This page is part of release 4.04 of the Linux man-pages project.  A description of the project, information about reporting bugs,  and  the  latest  version  of  this  page,  can  be  found  at
       http://www.kernel.org/doc/man-pages/.

Linux                                                                                           2015-07-23                                                                                      LOCALE(1)
LOCALE(5)                                                                                   Linux User Manual                                                                                   LOCALE(5)

NAME
       locale - describes a locale definition file

DESCRIPTION
       The locale definition file contains all the information that the localedef(1) command needs to convert it into the binary locale database.

       The definition files consist of sections which each describe a locale category in detail.  See locale(7) for additional details for these categories.

   Syntax
       The locale definition file starts with a header that may consist of the following keywords:

       <escape_char>
              is  followed  by a character that should be used as the escape-character for the rest of the file to mark characters that should be interpreted in a special way.  It defaults to the back‐
              slash (\).

       <comment_char>
              is followed by a character that will be used as the comment-character for the rest of the file.  It defaults to the number sign (#).

       The locale definition has one part for each locale category.  Each part can be copied from another existing locale or can be defined from scratch.  If the category should  be  copied,  the  only
       valid  keyword in the definition is copy followed by the name of the locale in double quotes which should be copied.  The exceptions for this rule are LC_COLLATE and LC_CTYPE where a copy state‐
       ment can be followed by locale-specific rules and selected overrides.

       When defining a category from scratch, all field descriptors and strings should be defined as Unicode code points in angle brackets, unless otherwise stated below.  For example,  "€"  is  to  be
       presented as "<U20AC>", "%a" as "<U0025><U0061>", and "Monday" as "<U0053><U0075><U006E><U0064><U0061><U0079>".  Values defined as Unicode code points must be in double quotes, plain number val‐
       ues are not quoted (but LC_CTYPE and LC_COLLATE follow special formatting, see the system-provided locale files for examples).

   Locale category sections
       The following category sections are defined by POSIX:

       *  LC_CTYPE

       *  LC_COLLATE

       *  LC_MESSAGES

       *  LC_MONETARY

       *  LC_NUMERIC

       *  LC_TIME

       In addition, since version 2.2, the GNU C library supports the following nonstandard categories:

       *  LC_ADDRESS

       *  LC_IDENTIFICATION

       *  LC_MEASUREMENT

       *  LC_NAME

       *  LC_PAPER

       *  LC_TELEPHONE

       See locale(7) for a more detailed description of each category.

   LC_ADDRESS
       The definition starts with the string LC_ADDRESS in the first column.

       The following keywords are allowed:

       postal_fmt
              followed by a string containing field descriptors that define the format used for postal addresses in the locale.  The following field descriptors are recognized:

              %a  Care of person, or organization.

              %f  Firm name.

              %d  Department name.

              %b  Building name.

              %s  Street or block (e.g., Japanese) name.

              %h  House number or designation.

              %N  Insert an end-of-line if the previous descriptor's value was not an empty string; otherwise ignore.

              %t  Insert a space if the previous descriptor's value was not an empty string; otherwise ignore.

              %r  Room number, door designation.

              %e  Floor number.

              %C  Country designation, from the <country_post> keyword.

              %z  Zip number, postal code.

              %T  Town, city.

              %S  State, province, or prefecture.

              %c  Country, as taken from data record.

              Each field descriptor may have an 'R' after the '%' to specify that the information is taken from a Romanized version string of the entity.

       country_name
              followed by the country name in the language of the current document (e.g., "Deutschland" for the de_DE locale).

       country_post
              followed by the abbreviation of the country (see CERT_MAILCODES).

       country_ab2
              followed by the two-letter abbreviation of the country (ISO 3166).

       country_ab3
              followed by the three-letter abbreviation of the country (ISO 3166).

       country_num
              followed by the numeric country code as plain numbers (ISO 3166).

       country_car
              followed by the code for the country car number.

       country_isbn
              followed by the ISBN code (for books).

       lang_name
              followed by the language name in the language of the current document.

       lang_ab
              followed by the two-letter abbreviation of the language (ISO 639).

       lang_term
              followed by the three-letter abbreviation of the language (ISO 639-2/T).

       lang_lib
              followed by the three-letter abbreviation of the language for library use (ISO 639-2/B).  Applications should in general prefer lang_term over lang_lib.

       The LC_ADDRESS definition ends with the string END LC_ADDRESS.

   LC_CTYPE
       The definition starts with the string LC_CTYPE in the first column.

       The following keywords are allowed:

       upper  followed by a list of uppercase letters.  The letters A through Z are included automatically.  Characters also specified as cntrl, digit, punct, or space are not allowed.

       lower  followed by a list of lowercase letters.  The letters a through z are included automatically.  Characters also specified as cntrl, digit, punct, or space are not allowed.

       alpha  followed by a list of letters.  All character specified as either upper or lower are automatically included.  Characters also specified as cntrl, digit, punct, or space are not allowed.

       digit  followed by the characters classified as numeric digits.  Only the digits 0 through 9 are allowed.  They are included by default in this class.

       space  followed by a list of characters defined as white-space characters.  Characters also specified as upper, lower, alpha, digit, graph, or xdigit are not allowed.   The  characters  <space>,
              <form-feed>, <newline>, <carriage-return>, <tab>, and <vertical-tab> are automatically included.

       cntrl  followed by a list of control characters.  Characters also specified as upper, lower, alpha, digit, punct, graph, print, or xdigit are not allowed.

       punct  followed by a list of punctuation characters.  Characters also specified as upper, lower, alpha, digit, cntrl, xdigit, or the <space> character are not allowed.

       graph  followed  by  a  list  of  printable  characters, not including the <space> character.  The characters defined as upper, lower, alpha, digit, xdigit, and punct are automatically included.
              Characters also specified as cntrl are not allowed.

       print  followed by a list of printable characters, including the <space> character.  The characters defined as upper, lower, alpha, digit, xdigit, punct, and the <space> character are  automati‐
              cally included.  Characters also specified as cntrl are not allowed.

       xdigit followed  by  a  list of characters classified as hexadecimal digits.  The decimal digits must be included followed by one or more set of six characters in ascending order.  The following
              characters are included by default: 0 through 9, a through f, A through F.

       blank  followed by a list of characters classified as blank.  The characters <space> and <tab> are automatically included.

       charclass
              followed by a list of locale-specific character class names which are then to be defined in the locale.

       toupper
              followed by a list of mappings from lowercase to uppercase letters.  Each mapping is a pair of a lowercase and an uppercase letter separated with a , and  enclosed  in  parentheses.   The
              members of the list are separated with semicolons.

       tolower
              followed by a list of mappings from uppercase to lowercase letters.  If the keyword tolower is not present, the reverse of the toupper list is used.

       map totitle
              followed by a list of mapping pairs of characters and letters to be used in titles (headings).

       class  followed by a locale-specific character class definition, starting with the class name followed by the characters belonging to the class.

       charconv
              followed by a list of locale-specific character mapping names which are then to be defined in the locale.

       outdigit
              followed by a list of alternate output digits for the locale.

       map to_inpunct
              followed by a list of mapping pairs of alternate digits and separators for input digits for the locale.

       map to_outpunct
              followed by a list of mapping pairs of alternate separators for output for the locale.

       translit_start
              marks the start of the transliteration rules section.  The section can contain the include keyword in the beginning followed by locale-specific rules and overrides.  Any rule specified in
              the locale file will override any rule copied or included from other files.  In case of duplicate rule definitions in the locale file, only the first rule is used.

              A transliteration rule consist of a character to be transliterated followed by a list of transliteration targets separated by semicolons.  The first target which can be presented  in  the
              target character set is used, if none of them can be used the default_missing character will be used instead.

       include
              in the transliteration rules section includes a transliteration rule file (and optionally a repertoire map file).

       default_missing
              in the transliteration rules section defines the default character to be used for transliteration where none of the targets cannot be presented in the target character set.

       translit_end
              marks the end of the transliteration rules.

       The LC_CTYPE definition ends with the string END LC_CTYPE.

   LC_COLLATE
       Due to limitations of glibc not all POSIX-options are implemented.

       The definition starts with the string LC_COLLATE in the first column.

       The following keywords are allowed:

       collating-element
              followed by the definition of a collating-element symbol representing a multicharacter collating element.

       collating-symbol
              followed by the definition of a collating symbol that can be used in collation order statements.

       The order-definition starts with a line:

       order_start
              followed by a list of keywords chosen from forward, backward, or position.  The order definition consists of lines that describe the order and is terminated with the keyword order_end.

       The LC_COLLATE definition ends with the string END LC_COLLATE.

   LC_IDENTIFICATION
       The definition starts with the string LC_IDENTIFICATION in the first column.

       The values in this category are defined as plain strings.

       The following keywords are allowed:

       title  followed by the title of the locale document (e.g., "Maori language locale for New Zealand").

       source followed by the name of the organization that maintains this document.

       address
              followed by the address of the organization that maintains this document.

       contact
              followed by the name of the contact person at the organization that maintains this document.

       email  followed by the email address of the person or organization that maintains this document.

       tel    followed by the telephone number (in international format) of the organization that maintains this document.

       fax    followed by the fax number (in international format) of the organization that maintains this document.

       language
              followed by the name of the language to which this document applies.

       territory
              followed by the name of the country/geographic extent to which this document applies.

       audience
              followed by a description of the audience for which this document is intended.

       application
              followed by a description of any special application for which this document is intended.

       abbreviation
              followed by the short name for this document.

       revision
              followed by the revision number of this document.

       date   followed by the revision date of this document.

       In addition, for each of the categories defined by the document, there should be a line starting with the keyword category, followed by:

       *  a string that identifies this locale category definition,

       *  a semicolon, and

       *  one of the LC_* identifiers.

       The LC_IDENTIFICATION definition ends with the string END LC_IDENTIFICATION.

   LC_MESSAGES
       The definition starts with the string LC_MESSAGES in the first column.

       The following keywords are allowed:

       yesexpr
              followed by a regular expression that describes possible yes-responses.

       noexpr followed by a regular expression that describes possible no-responses.

       yesstr followed by the output string corresponding to "yes".

       nostr  followed by the output string corresponding to "no".

       The LC_MESSAGES definition ends with the string END LC_MESSAGES.

   LC_MEASUREMENT
       The definition starts with the string LC_MEASUREMENT in the first column.

       The following keywords are allowed:

       measurement
              followed by number identifying the standard used for measurement.  The following values are recognized:

              1   Metric.

              2   US customary measurements.

       The LC_MEASUREMENT definition ends with the string END LC_MEASUREMENT.

   LC_MONETARY
       The definition starts with the string LC_MONETARY in the first column.

       Values for int_curr_symbol, currency_symbol, mon_decimal_point, mon_thousands_sep, positive_sign, and negative_sign are defined as Unicode code points, the others as plain numbers.

       The following keywords are allowed:

       int_curr_symbol
              followed  by the international currency symbol.  This must be a 4-character string containing the international currency symbol as defined by the ISO 4217 standard (three characters) fol‐
              lowed by a separator.

       currency_symbol
              followed by the local currency symbol.

       mon_decimal_point
              followed by the string that will be used as the decimal delimiter when formatting monetary quantities.

       mon_thousands_sep
              followed by the string that will be used as a group separator when formatting monetary quantities.

       mon_grouping
              followed by a sequence of integers separated by semicolons that describe the formatting of monetary quantities.  See grouping below for details.

       positive_sign
              followed by a string that is used to indicate a positive sign for monetary quantities.

       negative_sign
              followed by a string that is used to indicate a negative sign for monetary quantities.

       int_frac_digits
              followed by the number of fractional digits that should be used when formatting with the int_curr_symbol.

       frac_digits
              followed by the number of fractional digits that should be used when formatting with the currency_symbol.

       p_cs_precedes
              followed by an integer that indicates the placement of currency_symbol for a nonnegative formatted monetary quantity:

              0   the symbol succeeds the value.

              1   the symbol precedes the value.

       p_sep_by_space
              followed by an integer that indicates the separation of currency_symbol, the sign string, and the value for a nonnegative formatted monetary quantity.  The  following  values  are  recog‐
              nized:

              0   No space separates the currency symbol and the value.

              1   If the currency symbol and the sign string are adjacent, a space separates them from the value; otherwise a space separates the currency symbol and the value.

              2   If the currency symbol and the sign string are adjacent, a space separates them from the value; otherwise a space separates the sign string and the value.

       n_cs_precedes
              followed by an integer that indicates the placement of currency_symbol for a negative formatted monetary quantity.  The same values are recognized as for p_cs_precedes.

       n_sep_by_space
              followed  by an integer that indicates the separation of currency_symbol, the sign string, and the value for a negative formatted monetary quantity.  The same values are recognized as for
              p_sep_by_space.

       p_sign_posn
              followed by an integer that indicates where the positive_sign should be placed for a nonnegative monetary quantity:

              0   Parentheses enclose the quantity and the currency_symbol or int_curr_symbol.

              1   The sign string precedes the quantity and the currency_symbol or the int_curr_symbol.

              2   The sign string succeeds the quantity and the currency_symbol or the int_curr_symbol.

              3   The sign string precedes the currency_symbol or the int_curr_symbol.

              4   The sign string succeeds the currency_symbol or the int_curr_symbol.

       n_sign_posn
              followed by an integer that indicates where the negative_sign should be placed for a negative monetary quantity.  The same values are recognized as for p_sign_posn.

       int_p_cs_precedes
              followed by an integer that indicates the placement of int_currency_symbol for a nonnegative internationally formatted monetary quantity.  The same values are recognized as for  p_cs_pre‐
              cedes.

       int_n_cs_precedes
              followed  by  an  integer  that indicates the placement of int_currency_symbol for a negative internationally formatted monetary quantity.  The same values are recognized as for p_cs_pre‐
              cedes.

       int_p_sep_by_space
              followed by an integer that indicates the separation of int_currency_symbol, the sign string, and the value for a nonnegative internationally formatted monetary quantity.  The same values
              are recognized as for p_sep_by_space.

       int_n_sep_by_space
              followed  by  an  integer that indicates the separation of int_currency_symbol, the sign string, and the value for a negative internationally formatted monetary quantity.  The same values
              are recognized as for p_sep_by_space.

       int_p_sign_posn
              followed by an integer that indicates where the positive_sign should be placed for a nonnegative internationally formatted monetary quantity.   The  same  values  are  recognized  as  for
              p_sign_posn.

       int_n_sign_posn
              followed  by  an  integer  that  indicates  where  the  negative_sign  should  be placed for a negative internationally formatted monetary quantity.  The same values are recognized as for
              p_sign_posn.

       The LC_MONETARY definition ends with the string END LC_MONETARY.

   LC_NAME
       The definition starts with the string LC_NAME in the first column.

       Various keywords are allowed, but only name_fmt is mandatory.  Other keywords are needed only if there is common convention to use the corresponding salutation in this locale.  The allowed  key‐
       words are as follows:

       name_fmt
              followed by a string containing field descriptors that define the format used for names in the locale.  The following field descriptors are recognized:

              %f  Family name(s).

              %F  Family names in uppercase.

              %g  First given name.

              %G  First given initial.

              %l  First given name with Latin letters.

              %o  Other shorter name.

              %m  Additional given name(s).

              %M  Initials for additional given name(s).

              %p  Profession.

              %s  Salutation, such as "Doctor".

              %S  Abbreviated salutation, such as "Mr." or "Dr.".

              %d  Salutation, using the FDCC-sets conventions.

              %t  If the preceding field descriptor resulted in an empty string, then the empty string, otherwise a space character.

       name_gen
              followed by the general salutation for any gender.

       name_mr
              followed by the salutation for men.

       name_mrs
              followed by the salutation for married women.

       name_miss
              followed by the salutation for unmarried women.

       name_ms
              followed by the salutation valid for all women.

       The LC_NAME definition ends with the string END LC_NAME.

   LC_NUMERIC
       The definition starts with the string LC_NUMERIC in the first column.

       The following keywords are allowed:

       decimal_point
              followed by the string that will be used as the decimal delimiter when formatting numeric quantities.

       thousands_sep
              followed by the string that will be used as a group separator when formatting numeric quantities.

       grouping
              followed by a sequence of integers as plain numbers separated by semicolons that describe the formatting of numeric quantities.

              Each integer specifies the number of digits in a group.  The first integer defines the size of the group immediately to the left of the decimal delimiter.  Subsequent integers define suc‐
              ceeding groups to the left of the previous group.  If the last integer is not -1, then the size of the previous group (if any) is repeatedly used for the remainder of the digits.  If  the
              last integer is -1, then no further grouping is performed.

       The LC_NUMERIC definition ends with the string END LC_NUMERIC.

   LC_PAPER
       The definition starts with the string LC_PAPER in the first column.

       Values in this category are defined as plain numbers.

       The following keywords are allowed:

       height followed by the height, in millimeters, of the standard paper format.

       width  followed by the width, in millimeters, of the standard paper format.

       The LC_PAPER definition ends with the string END LC_PAPER.

   LC_TELEPHONE
       The definition starts with the string LC_TELEPHONE in the first column.

       The following keywords are allowed:

       tel_int_fmt
              followed by a string that contains field descriptors that identify the format used to dial international numbers.  The following field descriptors are recognized:

              %a  Area code without nationwide prefix (the prefix is often "00").

              %A  Area code including nationwide prefix.

              %l  Local number (within area code).

              %e  Extension (to local number).

              %c  Country code.

              %C  Alternate carrier service code used for dialing abroad.

              %t  If the preceding field descriptor resulted in an empty string, then the empty string, otherwise a space character.

       tel_dom_fmt
              followed by a string that contains field descriptors that identify the format used to dial domestic numbers.  The recognized field descriptors are the same as for tel_int_fmt.

       int_select
              followed by the prefix used to call international phone numbers.

       int_prefix
              followed by the prefix used from other countries to dial this country.

       The LC_TELEPHONE definition ends with the string END LC_TELEPHONE.

   LC_TIME
       The definition starts with the string LC_TIME in the first column.

       The following keywords are allowed:

       abday  followed by a list of abbreviated names of the days of the week.  The list starts with the first day of the week as specified by week (Sunday by default).  See NOTES.

       day    followed by a list of names of the days of the week.  The list starts with the first day of the week as specified by week (Sunday by default).  See NOTES.

       abmon  followed by a list of abbreviated month names.

       mon    followed by a list of month names.

       d_t_fmt
              followed by the appropriate date and time format (for syntax, see strftime(3)).

       d_fmt  followed by the appropriate date format (for syntax, see strftime(3)).

       t_fmt  followed by the appropriate time format (for syntax, see strftime(3)).

       am_pm  followed by the appropriate representation of the am and pm strings.  This should be left empty for locales not using AM/PM convention.

       t_fmt_ampm
              followed by the appropriate time format (for syntax, see strftime(3)) when using 12h clock format.  This should be left empty for locales not using AM/PM convention.

       era    followed by semicolon-separated strings that define how years are counted and displayed for each era in the locale.  Each string has the following format:

              direction:offset:start_date:end_date:era_name:era_format

              The fields are to be defined as follows:

              direction
                  Either + or -.  + means the years closer to start_date have lower numbers than years closer to end_date.  - means the opposite.

              offset
                  The number of the year closest to start_date in the era, corresponding to the %Ey descriptor (see strptime(3)).

              start_date
                  The start of the era in the form of yyyy/mm/dd.  Years prior AD 1 are represented as negative numbers.

              end_date
                  The end of the era in the form of yyyy/mm/dd, or one of the two special values of -* or +*.  -* means the ending date is the beginning of time.  +* means the ending date is the end of
                  time.

              era_name
                  The name of the era corresponding to the %EC descriptor (see strptime(3)).

              era_format
                  The format of the year in the era corresponding to the %EY descriptor (see strptime(3)).

       era_d_fmt
              followed by the format of the date in alternative era notation, corresponding to the %Ex descriptor (see strptime(3)).

       era_t_fmt
              followed by the format of the time in alternative era notation, corresponding to the %EX descriptor (see strptime(3)).

       era_d_t_fmt
              followed by the format of the date and time in alternative era notation, corresponding to the %Ec descriptor (see strptime(3)).

       alt_digits
              followed by the alternative digits used for date and time in the locale.

       week   followed by a list of three values as plain numbers: The number of days in a week (by default 7), a date of beginning of the week (by default  corresponds  to  Sunday),  and  the  minimal
              length of the first week in year (by default 4).  Regarding the start of the week, 19971130 shall be used for Sunday and 19971201 shall be used for Monday.  See NOTES.

       first_weekday (since glibc 2.2)
              followed  by the number of the first day from the day list to be shown in calendar applications.  The default value of 1 (plain number) corresponds to either Sunday or Monday depending on
              the value of the second week list item.  See NOTES.

       first_workday (since glibc 2.2)
              followed by the number of the first working day from the day list.  The default value is 2 (plain number).  See NOTES.

       cal_direction
              followed by a plain number value that indicates the direction for the display of calendar dates, as follows:

              1   Left-right from top.

              2   Top-down from left.

              3   Right-left from top.

       date_fmt
              followed by the appropriate date representation for date(1) (for syntax, see strftime(3)).

       The LC_TIME definition ends with the string END LC_TIME.

FILES
       /usr/lib/locale/locale-archive
              Usual default locale archive location.

       /usr/share/i18n/locales
              Usual default path for locale definition files.

CONFORMING TO
       POSIX.2, ISO/IEC TR 14652.

NOTES
       The collective GNU C library community wisdom regarding abday, day, week, first_weekday, and first_workday states at https://sourceware.org/glibc/wiki/Locales the following:

       *  The value of the second week list item specifies the base of the abday and day lists.

       *  first_weekday specifies the offset of the first day-of-week in the abday and day lists.

       *  For compatibility reasons, all glibc locales should set the value of the second week list item to 19971130 (Sunday) and base the abday and day lists appropriately, and set  first_weekday  and
          first_workday to 1 or 2, depending on whether the week and work week actually starts on Sunday or Monday for the locale.

SEE ALSO
       iconv(1), locale(1), localedef(1), localeconv(3), newlocale(3), setlocale(3), strftime(3), strptime(3), uselocale(3), charmap(5), charsets(7), locale(7), unicode(7), utf-8(7)

COLOPHON
       This  page  is  part  of  release  4.04  of  the  Linux  man-pages  project.  A description of the project, information about reporting bugs, and the latest version of this page, can be found at
       http://www.kernel.org/doc/man-pages/.

Linux                                                                                           2015-07-23                                                                                      LOCALE(5)
LOCALE(7)                                                                               Linux Programmer's Manual                                                                               LOCALE(7)

NAME
       locale - description of multilanguage support

SYNOPSIS
       #include <locale.h>

DESCRIPTION
       A  locale is a set of language and cultural rules.  These cover aspects such as language for messages, different character sets, lexicographic conventions, and so on.  A program needs to be able
       to determine its locale and act accordingly to be portable to different cultures.

       The header <locale.h> declares data types, functions and macros which are useful in this task.

       The functions it declares are setlocale(3) to set the current locale, and localeconv(3) to get information about number formatting.

       There are different categories for locale information a program might need; they are declared as macros.  Using them as the first argument to the setlocale(3) function, it is possible to set one
       of these to the desired locale:

       LC_ADDRESS (GNU extension, since glibc 2.2)
              Change  settings that describe the formats (e.g., postal addresses) used to describe locations and geography-related items.  Applications that need this information can use nl_langinfo(3)
              to retrieve nonstandard elements, such as _NL_ADDRESS_COUNTRY_NAME (country name, in the language of the locale) and _NL_ADDRESS_LANG_NAME (language name, in the language of the  locale),
              which return strings such as "Deutschland" and "Deutsch" (for German-language locales).  (Other element names are listed in <langinfo.h>.)

       LC_COLLATE
              This  category  governs  the collation rules used for sorting and regular expressions, including character equivalence classes and multicharacter collating elements.  This locale category
              changes the behavior of the functions strcoll(3) and strxfrm(3), which are used to compare strings in the local alphabet.  For example, the German sharp s is sorted as "ss".

       LC_CTYPE
              This category determines the interpretation of byte sequences as characters (e.g., single versus multibyte characters), character classifications (e.g.,  alphabetic  or  digit),  and  the
              behavior  of  character  classes.  On glibc systems, this category also determines the character transliteration rules for iconv(1) and iconv(3).  It changes the behavior of the character
              handling and classification functions, such as isupper(3) and toupper(3), and the multibyte character functions such as mblen(3) or wctomb(3).

       LC_IDENTIFICATION (GNU extension, since glibc 2.2)
              Change settings that relate to the metadata for the locale.  Applications that need this information can use nl_langinfo(3) to  retrieve  nonstandard  elements,  such  as  _NL_IDENTIFICA‐
              TION_TITLE  (title  of  this  locale document) and _NL_IDENTIFICATION_TERRITORY (geographical territory to which this locale document applies), which might return strings such as "English
              locale for the USA" and "USA".  (Other element names are listed in <langinfo.h>.)

       LC_MONETARY
              This category determines the formatting used for monetary-related numeric values.  This changes the information returned by localeconv(3), which describes  the  way  numbers  are  usually
              printed, with details such as decimal point versus decimal comma.  This information is internally used by the function strfmon(3).

       LC_MESSAGES
              This  category  affects  the  language  in which messages are displayed and what an affirmative or negative answer looks like.  The GNU C library contains the gettext(3), ngettext(3), and
              rpmatch(3) functions to ease the use of this information.  The GNU gettext family of functions also obey the environment variable LANGUAGE (containing a colon-separated list  of  locales)
              if the category is set to a valid locale other than "C".  This category also affects the behavior of catopen(3).

       LC_MEASUREMENT (GNU extension, since glibc 2.2)
              Change  the  settings  relating to the measurement system in the locale (i.e., metric versus US customary units).  Applications can use nl_langinfo(3) to retrieve the nonstandard _NL_MEA‐
              SUREMENT_MEASUREMENT element, which returns a pointer to a character that has the value 1 (metric) or 2 (US customary units).

       LC_NAME (GNU extension, since glibc 2.2)
              Change settings that describe the formats used to address  persons.   Applications  that  need  this  information  can  use  nl_langinfo(3)  to  retrieve  nonstandard  elements,  such  as
              _NL_NAME_NAME_MR  (general  salutation for men) and _NL_NAME_NAME_MS (general salutation for women) elements, which return strings such as "Herr" and "Frau" (for German-language locales).
              (Other element names are listed in <langinfo.h>.)

       LC_NUMERIC
              This category determines the formatting rules used for nonmonetary numeric values—for example, the thousands separator and the radix character (a period  in  most  English-speaking  coun‐
              tries, but a comma in many other regions).  It affects functions such as printf(3), scanf(3), and strtod(3).  This information can also be read with the localeconv(3) function.

       LC_PAPER (GNU extension, since glibc 2.2)
              Change  the  settings  relating to the dimensions of the standard paper size (e.g., US letter versus A4).  Applications that need the dimensions can obtain them by using nl_langinfo(3) to
              retrieve the nonstandard _NL_PAPER_WIDTH and _NL_PAPER_HEIGHT elements, which return int values specifying the dimensions in millimeters.

       LC_TELEPHONE (GNU extension, since glibc 2.2)
              Change settings that describe the formats to be used with telephone services.  Applications that need this information can use nl_langinfo(3) to retrieve  nonstandard  elements,  such  as
              _NL_TELEPHONE_INT_PREFIX (international prefix used to call numbers in this locale), which returns a string such as "49" (for Germany).  (Other element names are listed in <langinfo.h>.)

       LC_TIME
              This  category  governs the formatting used for date and time values.  For example, most of Europe uses a 24-hour clock versus the 12-hour clock used in the United States.  The setting of
              this category affects the behavior of functions such as strftime(3) and strptime(3).

       LC_ALL All of the above.

       If the second argument to setlocale(3) is an empty string, "", for the default locale, it is determined using the following steps:

       1.     If there is a non-null environment variable LC_ALL, the value of LC_ALL is used.

       2.     If an environment variable with the same name as one of the categories above exists and is non-null, its value is used for that category.

       3.     If there is a non-null environment variable LANG, the value of LANG is used.

       Values about local numeric formatting is made available in a struct lconv returned by the localeconv(3) function, which has the following declaration:

         struct lconv {

             /* Numeric (nonmonetary) information */

             char *decimal_point;     /* Radix character */
             char *thousands_sep;     /* Separator for digit groups to left
                                         of radix character */
             char *grouping; /* Each element is the number of digits in a
                                group; elements with higher indices are
                                further left.  An element with value CHAR_MAX
                                means that no further grouping is done.  An
                                element with value 0 means that the previous
                                element is used for all groups further left. */

             /* Remaining fields are for monetary information */

             char *int_curr_symbol;   /* First three chars are a currency symbol
                                         from ISO 4217.  Fourth char is the
                                         separator.  Fifth char is '\0'. */
             char *currency_symbol;   /* Local currency symbol */
             char *mon_decimal_point; /* Radix character */
             char *mon_thousands_sep; /* Like thousands_sep above */
             char *mon_grouping;      /* Like grouping above */
             char *positive_sign;     /* Sign for positive values */
             char *negative_sign;     /* Sign for negative values */
             char  int_frac_digits;   /* International fractional digits */
             char  frac_digits;       /* Local fractional digits */
             char  p_cs_precedes;     /* 1 if currency_symbol precedes a
                                         positive value, 0 if succeeds */
             char  p_sep_by_space;    /* 1 if a space separates currency_symbol
                                         from a positive value */
             char  n_cs_precedes;     /* 1 if currency_symbol precedes a
                                         negative value, 0 if succeeds */
             char  n_sep_by_space;    /* 1 if a space separates currency_symbol
                                         from a negative value */
             /* Positive and negative sign positions:
                0 Parentheses surround the quantity and currency_symbol.
                1 The sign string precedes the quantity and currency_symbol.
                2 The sign string succeeds the quantity and currency_symbol.
                3 The sign string immediately precedes the currency_symbol.
                4 The sign string immediately succeeds the currency_symbol. */
             char  p_sign_posn;
             char  n_sign_posn;
         };

   POSIX.1-2008 extensions to the locale API
       POSIX.1-2008 standardized a number of extensions to the locale API, based on implementations that first appeared in version 2.3 of the GNU C library.  These extensions are  designed  to  address
       the problem that the traditional locale APIs do not mix well with multithreaded applications and with applications that must deal with multiple locales.

       The  extensions  take  the form of new functions for creating and manipulating locale objects (newlocale(3), freelocale(3), duplocale(3), and uselocale(3)) and various new library functions with
       the suffix "_l" (e.g., toupper_l(3)) that extend the traditional locale-dependent APIs (e.g., toupper(3)) to allow the specification of a locale object that should apply when executing the func‐
       tion.

ENVIRONMENT
       The following environment variable is used by newlocale(3) and setlocale(3), and thus affects all unprivileged localized programs:

       LOCPATH
              A list of pathnames, separated by colons (':'), that should be used to find locale data.  If this variable is set, only the individual compiled locale data files from LOCPATH and the sys‐
              tem default locale data path are used; any available locale archives are not used (see localedef(1)).  The individual compiled locale data files  are  searched  for  under  subdirectories
              which  depend  on  the currently used locale.  For example, when en_GB.UTF-8 is used for a category, the following subdirectories are searched for, in this order: en_GB.UTF-8, en_GB.utf8,
              en_GB, en.UTF-8, en.utf8, and en.

FILES
       /usr/lib/locale/locale-archive
              Usual default locale archive location.

       /usr/lib/locale
              Usual default path for compiled individual locale files.

CONFORMING TO
       POSIX.1-2001.

SEE ALSO
       iconv(1), locale(1), localedef(1), catopen(3), gettext(3), iconv(3), localeconv(3), mbstowcs(3), newlocale(3), ngettext(3),  nl_langinfo(3),  rpmatch(3),  setlocale(3),  strcoll(3),  strfmon(3),
       strftime(3), strxfrm(3), uselocale(3), wcstombs(3), locale(5), charsets(7), unicode(7), utf-8(7)

COLOPHON
       This  page  is  part  of  release  4.04  of  the  Linux  man-pages  project.  A description of the project, information about reporting bugs, and the latest version of this page, can be found at
       http://www.kernel.org/doc/man-pages/.

Linux                                                                                           2015-07-23                                                                                      LOCALE(7)
