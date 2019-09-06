File: binutils.info,  Node: elfedit,  Next: Common Options,  Prev: readelf,  Up: Top

16 elfedit
**********

     elfedit [`--input-mach='MACHINE]
             [`--input-type='TYPE]
             [`--input-osabi='OSABI]
             `--output-mach='MACHINE
             `--output-type='TYPE
             `--output-osabi='OSABI
             [`-v'|`--version']
             [`-h'|`--help']
             ELFFILE...

   `elfedit' updates the ELF header of ELF files which have the
matching ELF machine and file types.  The options control how and which
fields in the ELF header should be updated.

   ELFFILE... are the ELF files to be updated.  32-bit and 64-bit ELF
files are supported, as are archives containing ELF files.

   The long and short forms of options, shown here as alternatives, are
equivalent. At least one of the `--output-mach', `--output-type' and
`--output-osabi' options must be given.

`--input-mach=MACHINE'
     Set the matching input ELF machine type to MACHINE.  If
     `--input-mach' isn't specified, it will match any ELF machine
     types.

     The supported ELF machine types are, I386, IAMCU, L1OM, K1OM and
     X86-64.

`--output-mach=MACHINE'
     Change the ELF machine type in the ELF header to MACHINE.  The
     supported ELF machine types are the same as `--input-mach'.

`--input-type=TYPE'
     Set the matching input ELF file type to TYPE.  If `--input-type'
     isn't specified, it will match any ELF file types.

     The supported ELF file types are, REL, EXEC and DYN.

`--output-type=TYPE'
     Change the ELF file type in the ELF header to TYPE.  The supported
     ELF types are the same as `--input-type'.

`--input-osabi=OSABI'
     Set the matching input ELF file OSABI to OSABI.  If
     `--input-osabi' isn't specified, it will match any ELF OSABIs.

     The supported ELF OSABIs are, NONE, HPUX, NETBSD, GNU, LINUX
     (alias for GNU), SOLARIS, AIX, IRIX, FREEBSD, TRU64, MODESTO,
     OPENBSD, OPENVMS, NSK, AROS and FENIXOS.

`--output-osabi=OSABI'
     Change the ELF OSABI in the ELF header to OSABI.  The supported
     ELF OSABI are the same as `--input-osabi'.

`-v'
`--version'
     Display the version number of `elfedit'.

`-h'
`--help'
     Display the command line options understood by `elfedit'.


