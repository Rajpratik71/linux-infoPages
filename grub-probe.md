File: grub.info,  Node: Invoking grub-probe,  Next: Invoking grub-script-check,  Prev: Invoking grub-mount,  Up: Top

29 Invoking grub-probe
**********************

The program 'grub-probe' probes device information for a given path or
device.

     grub-probe --target=fs /boot/grub
     grub-probe --target=drive --device /dev/sda1

   'grub-probe' must be given a path or device as a non-option argument,
and also accepts the following options:

'--help'
     Print a summary of the command-line options and exit.

'--version'
     Print the version number of GRUB and exit.

'-d'
'--device'
     If this option is given, then the non-option argument is a system
     device name (such as '/dev/sda1'), and 'grub-probe' will print
     information about that device.  If it is not given, then the
     non-option argument is a filesystem path (such as '/boot/grub'),
     and 'grub-probe' will print information about the device containing
     that part of the filesystem.

'-m FILE'
'--device-map=FILE'
     Use FILE as the device map (*note Device map::) rather than the
     default, usually '/boot/grub/device.map'.

'-t TARGET'
'--target=TARGET'
     Print information about the given path or device as defined by
     TARGET.  The available targets and their meanings are:

     'fs'
          GRUB filesystem module.
     'fs_uuid'
          Filesystem Universally Unique Identifier (UUID).
     'fs_label'
          Filesystem label.
     'drive'
          GRUB device name.
     'device'
          System device name.
     'partmap'
          GRUB partition map module.
     'abstraction'
          GRUB abstraction module (e.g.  'lvm').
     'cryptodisk_uuid'
          Crypto device UUID.
     'msdos_parttype'
          MBR partition type code (two hexadecimal digits).
     'hints_string'
          A string of platform search hints suitable for passing to the
          'search' command (*note search::).
     'bios_hints'
          Search hints for the PC BIOS platform.
     'ieee1275_hints'
          Search hints for the IEEE1275 platform.
     'baremetal_hints'
          Search hints for platforms where disks are addressed directly
          rather than via firmware.
     'efi_hints'
          Search hints for the EFI platform.
     'arc_hints'
          Search hints for the ARC platform.
     'compatibility_hint'
          A guess at a reasonable GRUB drive name for this device, which
          may be used as a fallback if the 'search' command fails.
     'disk'
          System device name for the whole disk.

'-v'
'--verbose'
     Print verbose messages.

