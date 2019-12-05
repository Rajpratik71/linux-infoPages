lp(1)                                                                                             Apple Inc.                                                                                            lp(1)

NAME
       lp - print files

SYNOPSIS
       lp  [  -E  ] [ -U username ] [ -c ] [ -d destination[/instance] ] [ -h hostname[:port] ] [ -m ] [ -n num-copies ] [ -o option[=value] ] [ -q priority ] [ -s ] [ -t title ] [ -H handling ] [ -P page-
       list ] [ -- ] [ file(s) ]
       lp [ -E ] [ -U username ] [ -c ] [ -h hostname[:port] ] [ -i job-id ] [ -n num-copies ] [ -o option[=value] ] [ -q priority ] [ -t title ] [ -H handling ] [ -P page-list ]

DESCRIPTION
       lp submits files for printing or alters a pending job.  Use a filename of "-" to force printing from the standard input.

   THE DEFAULT DESTINATION
       CUPS provides many ways to set the default destination. The LPDEST and PRINTER environment variables are consulted first.  If neither are set, the current default set using the lpoptions(1)  command
       is used, followed by the default set using the lpadmin(8) command.

OPTIONS
       The following options are recognized by lp:

       --   Marks the end of options; use this to print a file whose name begins with a dash (-).

       -E   Forces encryption when connecting to the server.

       -U username
            Specifies the username to use when connecting to the server.

       -c   This  option  is  provided  for  backwards-compatibility only. On systems that support it, this option forces the print file to be copied to the spool directory before printing.  In CUPS, print
            files are always sent to the scheduler via IPP which has the same effect.

       -d destination
            Prints files to the named printer.

       -h hostname[:port]
            Chooses an alternate server.

       -i job-id
            Specifies an existing job to modify.

       -m   Sends an email when the job is completed.

       -n copies
            Sets the number of copies to print.

       -o "name=value [ ... name=value ]"
            Sets one or more job options.  See "COMMON JOB OPTIONS" below.

       -q priority
            Sets the job priority from 1 (lowest) to 100 (highest).  The default priority is 50.

       -s   Do not report the resulting job IDs (silent mode.)

       -t "name"
            Sets the job name.

       -H hh:mm

       -H hold

       -H immediate

       -H restart

       -H resume
            Specifies when the job should be printed.  A value of immediate will print the file immediately, a value of hold will hold the job indefinitely, and a UTC time value (HH:MM) will hold  the  job
            until the specified UTC (not local) time.  Use a value of resume with the -i option to resume a held job.  Use a value of restart with the -i option to restart a completed job.

       -P page-list
            Specifies  which  pages to print in the document.  The list can contain a list of numbers and ranges (#-#) separated by commas, e.g., "1,3-5,16".  The page numbers refer to the output pages and
            not the document's original pages - options like "number-up" can affect the numbering of the pages.

   COMMON JOB OPTIONS
       Aside from the printer-specific options reported by the lpoptions(1) command, the following generic options are available:

       -o collate=true
            Prints collated copies.

       -o fit-to-page
            Scales the print file to fit on the page.

       -o job-hold-until=when
            Holds the job until the specified local time.  "when" can be "indefinite" to hold the until released, "day-time" to print the job between 6am and 6pm local time, "night" to print  the  job  be‐
            tween  6pm  and 6am local time, "second-shift" to print the job between 4pm and 12am local time, "third-shift" to print the job between 12am and 8am local time, or "weekend" to print the job on
            Saturday or Sunday.

       -o job-hold-until=hh:mm
            Holds the job until the specified time in hours and minutes UTC.

       -o job-priority=priority
            Set the priority to a value from 1 (lowest) to 100 (highest), which influences when a job is scheduled for printing.  The default priority is typically 50.

       -o job-sheets=name
            Prints a cover page (banner) with the document.  The "name" can be "classified", "confidential", "secret", "standard", "topsecret", or "unclassified".

       -o job-sheets=start-name,end-name
            Prints cover pages (banners) with the document.

       -o media=size
            Sets the page size to size. Most printers support at least the size names "a4", "letter", and "legal".

       -o mirror
            Mirrors each page.

       -o number-up={2|4|6|9|16}
            Prints 2, 4, 6, 9, or 16 document (input) pages on each output page.

       -o number-up-layout=layout
            Specifies the layout of pages with the "number-up" option.  The "layout" string can be "btlr", "btrl", "lrbt", "lrtb", "rlbt", "rltb", "tblr", or "tbrl" - the first two  letters  determine  the
            column order while the second two letters determine the row order.  "bt" is bottom-to-top, "lr" is left-to-right, "rl" is right-to-left, and "tb" is top-to-bottom.

       -o orientation-requested=4
            Prints the job in landscape (rotated 90 degrees counter-clockwise).

       -o orientation-requested=5
            Prints the job in landscape (rotated 90 degrees clockwise).

       -o orientation-requested=6
            Prints the job in reverse portrait (rotated 180 degrees).

       -o outputorder=reverse
            Prints pages in reverse order.

       -o page-border=border
            Prints a border around each document page.  "border" is "double", "double-thick", "single", or "single-thick".

       -o page-ranges=page-list
            Specifies  which  pages to print in the document.  The list can contain a list of numbers and ranges (#-#) separated by commas, e.g., "1,3-5,16".  The page numbers refer to the output pages and
            not the document's original pages - options like "number-up" can affect the numbering of the pages.

       -o sides=one-sided
            Prints on one side of the paper.

       -o sides=two-sided-long-edge
            Prints on both sides of the paper for portrait output.

       -o sides=two-sided-short-edge
            Prints on both sides of the paper for landscape output.

CONFORMING TO
       Unlike the System V printing system, CUPS allows printer names to contain any printable character except SPACE, TAB, "/", or "#".  Also, printer and class names are not case-sensitive.

       The -q option accepts a different range of values than the Solaris lp command, matching the IPP job priority values (1-100, 100 is highest priority) instead of the Solaris values (0-39, 0 is highest
       priority).

EXAMPLES
       Print two copies of a document to the default printer:

           lp -n 2 filename

       Print a double-sided legal document to a printer called "foo":

           lp -d foo -o media=legal -o sides=two-sided-long-edge filename

       Print a presentation document 2-up to a printer called "foo":

           lp -d foo -o number-up=2 filename

SEE ALSO
       cancel(1), lpadmin(8), lpoptions(1), lpq(1), lpr(1), lprm(1), lpstat(1), CUPS Online Help (http://localhost:631/help)

COPYRIGHT
       Copyright © 2007-2017 by Apple Inc.

2 May 2016                                                                                           CUPS                                                                                               lp(1)
LP(4)                                                                                     Linux Programmer's Manual                                                                                     LP(4)

NAME
       lp - line printer devices

SYNOPSIS
       #include <linux/lp.h>

CONFIGURATION
       lp[0–2]  are  character  devices  for  the  parallel line printers; they have major number 6 and minor number 0–2.  The minor numbers correspond to the printer port base addresses 0x03bc, 0x0378 and
       0x0278.  Usually they have mode 220 and are owned by root and group lp.  You can use printer ports either with polling or with interrupts.  Interrupts are recommended when high traffic is  expected,
       for example, for laser printers.  For typical dot matrix printers, polling will usually be enough.  The default is polling.

DESCRIPTION
       The following ioctl(2) calls are supported:

       int ioctl(int fd, LPTIME, int arg)
              Sets  the  amount of time that the driver sleeps before rechecking the printer when the printer's buffer appears to be filled to arg.  If you have a fast printer, decrease this number; if you
              have a slow printer, then increase it.  This is in hundredths of a second, the default 2 being 0.02 seconds.  It influences only the polling driver.

       int ioctl(int fd, LPCHAR, int arg)
              Sets the maximum number of busy-wait iterations which the polling driver does while waiting for the printer to get ready for receiving a character to arg.  If printing is too  slow,  increase
              this number; if the system gets too slow, decrease this number.  The default is 1000.  It influences only the polling driver.

       int ioctl(int fd, LPABORT, int arg)
              If arg is 0, the printer driver will retry on errors, otherwise it will abort.  The default is 0.

       int ioctl(int fd, LPABORTOPEN, int arg)
              If arg is 0, open(2) will be aborted on error, otherwise error will be ignored.  The default is to ignore it.

       int ioctl(int fd, LPCAREFUL, int arg)
              If arg is 0, then the out-of-paper, offline, and error signals are required to be false on all writes, otherwise they are ignored.  The default is to ignore them.

       int ioctl(int fd, LPWAIT, int arg)
              Sets the number of busy waiting iterations to wait before strobing the printer to accept a just-written character, and the number of iterations to wait before turning the strobe off again, to
              arg.  The specification says this time should be 0.5 microseconds, but experience has shown the delay caused by the code is already enough.  For that reason, the default value is 0.  This  is
              used for both the polling and the interrupt driver.

       int ioctl(int fd, LPSETIRQ, int arg)
              This  ioctl(2)  requires  superuser  privileges.   It takes an int containing the new IRQ as argument.  As a side effect, the printer will be reset.  When arg is 0, the polling driver will be
              used, which is also default.

       int ioctl(int fd, LPGETIRQ, int *arg)
              Stores the currently used IRQ in arg.

       int ioctl(int fd, LPGETSTATUS, int *arg)
              Stores the value of the status port in arg.  The bits have the following meaning:

              LP_PBUSY     inverted busy input, active high
              LP_PACK      unchanged acknowledge input, active low
              LP_POUTPA    unchanged out-of-paper input, active high
              LP_PSELECD   unchanged selected input, active high
              LP_PERRORP   unchanged error input, active low

              Refer to your printer manual for the meaning of the signals.  Note that undocumented bits may also be set, depending on your printer.

       int ioctl(int fd, LPRESET)
              Resets the printer.  No argument is used.

FILES
       /dev/lp*

SEE ALSO
       chmod(1), chown(1), mknod(1), lpcntl(8), tunelp(8)

COLOPHON
       This page is part of release 5.02 of the Linux man-pages project.  A description of the project,  information  about  reporting  bugs,  and  the  latest  version  of  this  page,  can  be  found  at
       https://www.kernel.org/doc/man-pages/.

Linux                                                                                             1995-01-15                                                                                            LP(4)
