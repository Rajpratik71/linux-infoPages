HALT(8)                                                                halt                                                                HALT(8)

NAME
       halt, poweroff, reboot - Halt, power-off or reboot the machine

SYNOPSIS
       halt [OPTIONS...]

       poweroff [OPTIONS...]

       reboot [OPTIONS...]

DESCRIPTION
       halt, poweroff, reboot may be used to halt, power-off or reboot the machine.

OPTIONS
       The following options are understood:

       --help
           Print a short help text and exit.

       --halt
           Halt the machine, regardless of which one of the three commands is invoked.

       -p, --poweroff
           Power-off the machine, regardless of which one of the three commands is invoked.

       --reboot
           Reboot the machine, regardless of which one of the three commands is invoked.

       -f, --force
           Force immediate halt, power-off, reboot. Do not contact the init system.

       -w, --wtmp-only
           Only write wtmp shutdown entry, do not actually halt, power-off, reboot.

       -d, --no-wtmp
           Do not write wtmp shutdown entry.

       -n, --no-sync
           Don't sync hard disks/storage media before halt, power-off, reboot.

       --no-wall
           Do not send wall message before halt, power-off, reboot.

EXIT STATUS
       On success, 0 is returned, a non-zero failure code otherwise.

NOTES
       These are legacy commands available for compatibility only.

SEE ALSO
       systemd(1), systemctl(1), shutdown(8), wall(1)

systemd 233                                                                                                                                HALT(8)
halt(5)                                                            File Formats                                                            halt(5)

NAME
       halt - variables that affect the behavior of the shutdown scripts

DESCRIPTION
       The /etc/default/halt file contains variable settings in POSIX format:

            VAR=VAL

       Only one assignment is allowed per line.  Comments (starting with '#') are also allowed.

OPTIONS
       The following variables can be set.

       HALT   If set to poweroff the system will be powered down after it has been brought down. This is the default.
              If set to halt the system will only be halted after it has been brought down. What exactly this means depends on your hardware.

       NETDOWN
              Setting this to no prevents shutdown from shutting down the network intefaces.  This is necessary to use Wake-On-Lan.  Setting it to
              yes causes shutdown to also bring down the network interfaces (and thus prevent the machine from being woken up remotely).

SEE ALSO
       halt(8), shutdown(8).

AUTHOR
       Casper Gielen <casper@gielen.name>

COPYRIGHT
       This manual page is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as  published
       by the Free Software Foundation; either version 2 of the License, or (at your option) any later version.

       This  manual  page  is  distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MER‐
       CHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

       You should have received a copy of the GNU General Public License along with this manual page; if not, write to the Free  Software  Founda‐
       tion, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA

                                                                    16 Jan 2007                                                            halt(5)
