File: grub.info,  Node: Invoking grub-install,  Next: Invoking grub-mkconfig,  Prev: Troubleshooting,  Up: Top

23 Invoking grub-install
************************

The program 'grub-install' generates a GRUB core image using
'grub-mkimage' and installs it on your system.  You must specify the
device name on which you want to install GRUB, like this:

     grub-install INSTALL_DEVICE

   The device name INSTALL_DEVICE is an OS device name or a GRUB device
name.

   'grub-install' accepts the following options:

'--help'
     Print a summary of the command-line options and exit.

'--version'
     Print the version number of GRUB and exit.

'--boot-directory=DIR'
     Install GRUB images under the directory 'DIR/grub/' This option is
     useful when you want to install GRUB into a separate partition or a
     removable disk.  If this option is not specified then it defaults
     to '/boot', so

          grub-install /dev/sda

     is equivalent to

          grub-install --boot-directory=/boot/ /dev/sda

     Here is an example in which you have a separate "boot" partition
     which is mounted on '/mnt/boot':

          grub-install --boot-directory=/mnt/boot /dev/sdb

'--recheck'
     Recheck the device map, even if '/boot/grub/device.map' already
     exists.  You should use this option whenever you add/remove a disk
     into/from your computer.

'--no-rs-codes'
     By default on x86 BIOS systems, 'grub-install' will use some extra
     space in the bootloader embedding area for Reed-Solomon
     error-correcting codes.  This enables GRUB to still boot
     successfully if some blocks are corrupted.  The exact amount of
     protection offered is dependent on available space in the embedding
     area.  R sectors of redundancy can tolerate up to R/2 corrupted
     sectors.  This redundancy may be cumbersome if attempting to
     cryptographically validate the contents of the bootloader embedding
     area, or in more modern systems with GPT-style partition tables
     (*note BIOS installation::) where GRUB does not reside in any
     unpartitioned space outside of the MBR. Disable the Reed-Solomon
     codes with this option.

