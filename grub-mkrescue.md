Next: Invoking grub-mount,  Prev: Invoking grub-mkrelpath,  Up: Top

27 Invoking grub-mkrescue
*************************

The program 'grub-mkrescue' generates a bootable GRUB rescue image
(*note Making a GRUB bootable CD-ROM::).

     grub-mkrescue -o grub.iso

   All arguments not explicitly listed as 'grub-mkrescue' options are
passed on directly to 'xorriso' in 'mkisofs' emulation mode.  Options
passed to 'xorriso' will normally be interpreted as 'mkisofs' options;
if the option '--' is used, then anything after that will be interpreted
as native 'xorriso' options.

   Non-option arguments specify additional source directories.  This is
commonly used to add extra files to the image:

     mkdir -p disk/boot/grub
     (add extra files to 'disk/boot/grub')
     grub-mkrescue -o grub.iso disk

   'grub-mkrescue' accepts the following options:

'--help'
     Print a summary of the command-line options and exit.

'--version'
     Print the version number of GRUB and exit.

'-o FILE'
'--output=FILE'
     Save output in FILE.  This "option" is required.

'--modules=MODULES'
     Pre-load the named GRUB modules in the image.  Multiple entries in
     MODULES should be separated by whitespace (so you will probably
     need to quote this for your shell).

'--rom-directory=DIR'
     If generating images for the QEMU or Coreboot platforms, copy the
     resulting 'qemu.img' or 'coreboot.elf' files respectively to the
     DIR directory as well as including them in the image.

'--xorriso=FILE'
     Use FILE as the 'xorriso' program, rather than the built-in
     default.

'--grub-mkimage=FILE'
     Use FILE as the 'grub-mkimage' program, rather than the built-in
     default.

