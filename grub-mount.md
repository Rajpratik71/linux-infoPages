Next: Invoking grub-probe,  Prev: Invoking grub-mkrescue,  Up: Top

28 Invoking grub-mount
**********************

The program 'grub-mount' performs a read-only mount of any file system
or file system image that GRUB understands, using GRUB's file system
drivers via FUSE. (It is only available if FUSE development files were
present when GRUB was built.)  This has a number of uses:

   * It provides a convenient way to check how GRUB will view a file
     system at boot time.  You can use normal command-line tools to
     compare that view with that of your operating system, making it
     easy to find bugs.

   * It offers true read-only mounts.  Linux does not have these for
     journalling file systems, because it will always attempt to replay
     the journal at mount time; while you can temporarily mark the block
     device read-only to avoid this, that causes the mount to fail.
     Since GRUB intentionally contains no code for writing to file
     systems, it can easily provide a guaranteed read-only mount
     mechanism.

   * It allows you to examine any file system that GRUB understands
     without needing to load additional modules into your running
     kernel, which may be useful in constrained environments such as
     installers.

   * Since it can examine file system images (contained in regular
     files) just as easily as file systems on block devices, you can use
     it to inspect any file system image that GRUB understands with only
     enough privileges to use FUSE, even if nobody has yet written a
     FUSE module specifically for that file system type.

   Using 'grub-mount' is normally as simple as:

     grub-mount /dev/sda1 /mnt

   'grub-mount' must be given one or more images and a mount point as
non-option arguments (if it is given more than one image, it will treat
them as a RAID set), and also accepts the following options:

'--help'
     Print a summary of the command-line options and exit.

'--version'
     Print the version number of GRUB and exit.

'-C'
'--crypto'
     Mount encrypted devices, prompting for a passphrase if necessary.

'-d STRING'
'--debug=STRING'
     Show debugging output for conditions matching STRING.

'-K prompt|FILE'
'--zfs-key=prompt|FILE'
     Load a ZFS encryption key.  If you use 'prompt' as the argument,
     'grub-mount' will read a passphrase from the terminal; otherwise,
     it will read key material from the specified file.

'-r DEVICE'
'--root=DEVICE'
     Set the GRUB root device to DEVICE.  You do not normally need to
     set this; 'grub-mount' will automatically set the root device to
     the root of the supplied file system.

     If DEVICE is just a number, then it will be treated as a partition
     number within the supplied image.  This means that, if you have an
     image of an entire disk in 'disk.img', then you can use this
     command to mount its second partition:

          grub-mount -r 2 disk.img mount-point

'-v'
'--verbose'
     Print verbose messages.

