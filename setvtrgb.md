SETVTRGB(1)                                                                                General Commands Manual                                                                                SETVTRGB(1)

NAME
       setvtrgb - customize the console color map

SYNOPSIS
       setvtrgb vga

       setvtrgb FILE|-

DESCRIPTION
       setvtrgb  sets the console color map in all virtual terminals according to custom values specified in a file or standard input.  With the `vga' parameter, it can also be used to restore the settings
       built into the kernel.

       When invoked with a filename or `-', setvtrgb expects input as follows:

         color0_r,color1_r,...,color15_r
         color0_g,color1_g,...,color15_g
         color0_b,color1_b,...,color15_b

       where colorN_{r,g,b} is the red/green/blue portion of the respective color in decimal notation in the 0..255 range.  To pre-seed a file in the correct format, you can use

         cat /sys/module/vt/parameters/default_{red,grn,blu}

       The meanings of the color values are defined as follows:

         +--------+--------+---------+
         | Normal | Bright | Color   |
         +--------+--------+---------+
         |      0 |      8 | Black   |
         |      1 |      9 | Red     |
         |      2 |     10 | Green   |
         |      3 |     11 | Yellow  |
         |      4 |     12 | Blue    |
         |      5 |     13 | Magenta |
         |      6 |     14 | Cyan    |
         |      7 |     15 | White   |
         +---------------------------+

AUTHOR
       setvtrgb is Copyright © 2011 Alexey Gladkov <gladkov.alexey@gmail.com>, with portions by Dustin Kirkland <kirkland@canonical.com> and Seth Forshee <seth.forshee@canonical.com> at Canonical Ltd.

       This manual page was written by Michael Schutte <michi@debian.org> for the Debian GNU/Linux system (but may be used by others).

                                                                                                  July 2011                                                                                       SETVTRGB(1)
SETVTRGB(8)                                                                                System Manager's Manual                                                                                SETVTRGB(8)

NAME
       setvtrgb - set the virtual terminal RGB colors

SYNOPSIS
       setvtrgb -h|-V|vga|FILE|-

DESCRIPTION
       The setvtrgb command takes a single argument, either the string vga , or a path to a file containing the red, green, and blue colors to be used by the Linux virtual terminals.

       If you use the FILE parameter, FILE should be exactly 3 lines of 16 comma-separated decimal values for RED, GREEN, and BLUE.

       To seed a valid FILE :
              cat /sys/module/vt/parameters/default_{red,grn,blu} > FILE

       And then edit the values in FILE

OTHER OPTIONS
       -h     Prints usage message and exits.

       -V     Prints version number and exists.

AUTHOR
       The utility is written by Alexey Gladkov, Seth Forshee, Dustin Kirkland.

DOCUMENTATION
       Documentation by Dustin Kirkland.

Set Virtual Terminal RGB Colors                                                                   3 Mar 2011                                                                                      SETVTRGB(8)
