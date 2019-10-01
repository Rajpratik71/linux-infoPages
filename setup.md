File: *manpages*,  Node: setup,  Up: (dir)

setup(1)                           setuptool                          setup(1)



NAME
       setup - A text mode system configuration tool

SYNOPSIS
       setup

DESCRIPTION
       The  setuptool  program (setup) is a front-end menu program for a group
       of other tools, mostly system-config-*-tui tools. The list  of  options
       which  it  presents  is  assembled  by  scanning  /etc/setuptool.d  and
       /usr/share/setuptool/setuptool.d for files.

       Each file in the directory should contain one or more  lines  of  text.
       Each  line  contains from one to four fields which are separated by "|"
       characters.  In order, they are:
         - the path to the binary to invoke (mandatory)
         - the untranslated name of the application which should be displayed
           (If unset, defaults to the path of the binary, but don't depend  on
       that.)
         -  the  gettext  textdomain in which a translation of the name of the
       application can be found
           (If unset, defaults to "setup".)
         - the directory in which translations for the textdomain can be found
           (If unset, defaults to "/usr/share/locale".)

       If multiple entries with the same  untranslated  name  exist,  the  one
       which was read FIRST takes precedence. Files are read in name collation
       order.

EXAMPLE
       A contrived example would create  /etc/setuptool.d/00bogus  with  these
       contents:

         /bin/ls --color; /bin/sleep 5|Example "ls" invocation.

       or

         /bin/ls --color; /bin/sleep 5|Give this help list|libc

       to use one of libc's (not meaningful here, but) translatable messages.



Linux                             2009-10-07                          setup(1)
SETUP(2)                   Linux Programmer's Manual                  SETUP(2)



NAME
       setup - setup devices and file systems, mount root file system

SYNOPSIS
       #include <unistd.h>

       int setup(void);

DESCRIPTION
       setup()  is  called  once from within linux/init/main.c.  It calls ini‐
       tialization functions for devices and file systems configured into  the
       kernel and then mounts the root file system.

       No  user  process  may  call setup().  Any user process, even a process
       with superuser permission, will receive EPERM.

RETURN VALUE
       setup() always returns -1 for a user process.

ERRORS
       EPERM  Always, for a user process.

VERSIONS
       Since Linux 2.1.121, no such function exists anymore.

CONFORMING TO
       This function is Linux-specific, and should not  be  used  in  programs
       intended to be portable, or indeed in any programs at all.

NOTES
       The  calling  sequence  varied: at some times setup () has had a single
       argument void *BIOS and at other times a single argument int magic.

COLOPHON
       This page is part of release 3.53 of the Linux  man-pages  project.   A
       description  of  the project, and information about reporting bugs, can
       be found at http://www.kernel.org/doc/man-pages/.



Linux                             2008-12-03                          SETUP(2)
