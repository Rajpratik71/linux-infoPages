HDNG(1)                                                     BSD General Commands Manual                                                    HDNG(1)

NAME
     hdng — a hex dumper for the next generation

SYNOPSIS
     hdng {-h | -v}
     hdng {-X | -G} [-] [FILE ...]
     hdng [-oxsg] [-w WIDTH] [-] [FILE ...]

DESCRIPTION
     The basic concept for this utility is to emulate the base functionality of a hex dumper as found in bsdmainutil's hexdump(1) while providing
     better representation of the data. A special character set is used so that one might better observe patterns in the data. Additionally, the
     three areas of the hexdump(1) (offsets, hexits, glyphs) can be turned off and the width of data represented in each line of data can be
     changed.

     The available options are as follows:

     -h      usage information
     -v      the program's version
     -o      do not display offsets, including the total byte count
     -x      do not display hexits
     -s      do not abbreviate redundant data
     -g      do not display glyphs
     -w WIDTH
             the WIDTH of data to represent on each line of output
     FILE ...
             a list of files to dump.  ‘-’ may be used to signify stdin.  [default: stdin]

   Special Modes
     The following flags are mutually exclusive. When specified, hdng ignores all other flags.

     -X      turns on continuous hexdump mode
     -G      turns on continuous glyphdump mode

EXAMPLES
     With a file specified
           $ hdng data.bin

     As a filter
           $ ... | hdng | ...

SEE ALSO
     hexdump(1), repr(1), unhex(1), xor(1)

AUTHORS
     Zephyr ⟨zephyr@dirtbags.net⟩,
     pi-rho ⟨pi-rho@tyr.cx⟩

BUGS
     Bugs may be submitted at ⟨https://bugs.launchpad.net/netre-tools⟩

Network RE Toolkit 1.1337                                        February 1, 2013                                        Network RE Toolkit 1.1337
HD(4)                                                        Linux Programmer's Manual                                                       HD(4)

NAME
       hd - MFM/IDE hard disk devices

DESCRIPTION
       The  hd*  devices  are block devices to access MFM/IDE hard disk drives in raw mode.  The master drive on the primary IDE controller (major
       device number 3) is hda; the slave drive is hdb.  The master drive of the second controller (major device number 22) is hdc and  the  slave
       is hdd.

       General  IDE block device names have the form hdX, or hdXP, where X is a letter denoting the physical drive, and P is a number denoting the
       partition on that physical drive.  The first form, hdX, is used to address the whole drive.  Partition numbers are assigned  in  the  order
       the  partitions  are  discovered,  and only nonempty, nonextended partitions get a number.  However, partition numbers 1-4 are given to the
       four partitions described in the MBR (the "primary" partitions), regardless of whether they are unused or extended.  Thus, the first  logi‐
       cal  partition  will be hdX5.  Both DOS-type partitioning and BSD-disklabel partitioning are supported.  You can have at most 63 partitions
       on an IDE disk.

       For example, /dev/hda refers to all of the first IDE drive in the system; and /dev/hdb3 refers to the third DOS "primary" partition on  the
       second one.

       They are typically created by:

              mknod -m 660 /dev/hda b 3 0
              mknod -m 660 /dev/hda1 b 3 1
              mknod -m 660 /dev/hda2 b 3 2
              ...
              mknod -m 660 /dev/hda8 b 3 8
              mknod -m 660 /dev/hdb b 3 64
              mknod -m 660 /dev/hdb1 b 3 65
              mknod -m 660 /dev/hdb2 b 3 66
              ...
              mknod -m 660 /dev/hdb8 b 3 72
              chown root:disk /dev/hd*

FILES
       /dev/hd*

SEE ALSO
       chown(1), mknod(1), sd(4), mount(8)

COLOPHON
       This  page is part of release 4.04 of the Linux man-pages project.  A description of the project, information about reporting bugs, and the
       latest version of this page, can be found at http://www.kernel.org/doc/man-pages/.

Linux                                                               1992-12-17                                                               HD(4)
