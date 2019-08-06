TZSELECT(1)                                                                          Debian Timezone Configuration                                                                         TZSELECT(1)

NAME
       tzselect - view timezones

SYNOPSIS
       tzselect

DESCRIPTION
       This  manual  page explains how you can use the tzselect utility to view the installed timezone. It comes handy when you want to know what time it is in other countries, or if you just wonder
       what timezones exist.

       tzselect is called without any parameters from the shell. It shows a list of about one dozen geographic areas one can roughly recognize as continents. After choosing a geographic area by num‐
       ber, a list of countries and cities in this area will be shown.

       You can press the Enter key to reprint the list. To choose a timezone, just press the number left to it.  If your input is invalid, the list will be reprinted.

       You may press Ctrl-C to interrupt the script at any time.

       Note that tzselect will not actually change the timezone for you. Use 'dpkg-reconfigure tzdata' to achieve this.

FILES
       /usr/share/zoneinfo/

SEE ALSO
       hwclock(8)

AUTHOR
       Copyright 1998 Marcus Brinkmann <brinkmd@debian.org>

       Please see nroff source for legal notice.

Debian                                                                                       12 June 1998                                                                                  TZSELECT(1)
TZSELECT(8)                                                                           Linux System Administration                                                                          TZSELECT(8)

NAME
       tzselect - select a timezone

SYNOPSIS
       tzselect

DESCRIPTION
       The tzselect program asks the user for information about the current location, and outputs the resulting timezone description to standard output.  The output is suitable as a value for the TZ
       environment variable.

       All interaction with the user is done via standard input and standard error.

EXIT STATUS
       The exit status is zero if a timezone was successfully obtained from the user, and is nonzero otherwise.

ENVIRONMENT
       AWK    Name of a POSIX-compliant awk program (default: awk).

       TZDIR  Name of the directory containing timezone data files (default: /usr/share/zoneinfo).

FILES
       TZDIR/iso3166.tab
              Table of ISO 3166 2-letter country codes and country names.

       TZDIR/zone.tab
              Table of country codes, latitude and longitude, TZ values, and descriptive comments.

       TZDIR/TZ
              Timezone data file for timezone TZ.

SEE ALSO
       tzfile(5), zdump(8), zic(8)

COLOPHON
       This page is part of release 4.15 of the Linux man-pages project.  A description of the project, information about reporting bugs, and the latest  version  of  this  page,  can  be  found  at
       https://www.kernel.org/doc/man-pages/.

                                                                                              2007-05-18                                                                                   TZSELECT(8)
