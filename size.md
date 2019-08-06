File: binutils.info,  Node: size,  Next: strings,  Prev: ranlib,  Up: Top

6 size
******

     size [`-A'|`-B'|`--format='COMPATIBILITY]
          [`--help']
          [`-d'|`-o'|`-x'|`--radix='NUMBER]
          [`--common']
          [`-t'|`--totals']
          [`--target='BFDNAME] [`-V'|`--version']
          [OBJFILE...]

   The GNU `size' utility lists the section sizes--and the total
size--for each of the object or archive files OBJFILE in its argument
list.  By default, one line of output is generated for each object file
or each module in an archive.

   OBJFILE... are the object files to be examined.  If none are
specified, the file `a.out' will be used.

   The command line options have the following meanings:

`-A'
`-B'
`--format=COMPATIBILITY'
     Using one of these options, you can choose whether the output from
     GNU `size' resembles output from System V `size' (using `-A', or
     `--format=sysv'), or Berkeley `size' (using `-B', or
     `--format=berkeley').  The default is the one-line format similar
     to Berkeley's.

     Here is an example of the Berkeley (default) format of output from
     `size':
          $ size --format=Berkeley ranlib size
          text    data    bss     dec     hex     filename
          294880  81920   11592   388392  5ed28   ranlib
          294880  81920   11888   388688  5ee50   size

     This is the same data, but displayed closer to System V
     conventions:

          $ size --format=SysV ranlib size
          ranlib  :
          section         size         addr
          .text         294880         8192
          .data          81920       303104
          .bss           11592       385024
          Total         388392


          size  :
          section         size         addr
          .text         294880         8192
          .data          81920       303104
          .bss           11888       385024
          Total         388688

`--help'
     Show a summary of acceptable arguments and options.

`-d'
`-o'
`-x'
`--radix=NUMBER'
     Using one of these options, you can control whether the size of
     each section is given in decimal (`-d', or `--radix=10'); octal
     (`-o', or `--radix=8'); or hexadecimal (`-x', or `--radix=16').
     In `--radix=NUMBER', only the three values (8, 10, 16) are
     supported.  The total size is always given in two radices; decimal
     and hexadecimal for `-d' or `-x' output, or octal and hexadecimal
     if you're using `-o'.

`--common'
     Print total size of common symbols in each file.  When using
     Berkeley format these are included in the bss size.

`-t'
`--totals'
     Show totals of all objects listed (Berkeley format listing mode
     only).

`--target=BFDNAME'
     Specify that the object-code format for OBJFILE is BFDNAME.  This
     option may not be necessary; `size' can automatically recognize
     many formats.  *Note Target Selection::, for more information.

`-V'
`--version'
     Display the version number of `size'.

