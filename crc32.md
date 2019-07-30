CRC32(1)                                                      General Commands Manual                                                     CRC32(1)

NAME
       crc32 - compute CRC-32 checksums for the given files

SYNOPSIS
       crc32 filename [ filename ... ]

DESCRIPTION
       crc32 is a simple utility that calculates the CRC-32 checksum for each of the given files.

       Note  that  the  CRC-32  checksum  is merely used for error detection in transmission and storage.  It is not intended to guard against the
       malicious modification of files (i.e., it is not a cryptographic hash).

       This utility is supplied with the Archive::Zip module for Perl.

SEE ALSO
       Archive::Zip(3pm).

AUTHOR
       The Archive::Zip module was written by Ned Konz.
       This manual page was prepared by Ben Burton <bab@debian.org> for the Debian GNU/Linux system (but may be used by others).

                                                                   June 21, 2005                                                          CRC32(1)
crc32(3tcl)                                                  Cyclic Redundancy Checks                                                  crc32(3tcl)

__________________________________________________________________________________________________________________________________________________

NAME
       crc32 - Perform a 32bit Cyclic Redundancy Check

SYNOPSIS
       package require Tcl  8.2

       package require crc32  ?1.3.2?

       ::crc::crc32 ?-format format? ?-seed value? [ -channel chan | -filename file | message ]

       ::crc::Crc32Init ?seed?

       ::crc::Crc32Update token data

       ::crc::Crc32Final token

__________________________________________________________________________________________________________________________________________________

DESCRIPTION
       This  package  provides  a  Tcl  implementation  of  the  CRC-32  algorithm  based upon information provided at http://www.naaccr.org/stan‐
       dard/crc32/document.html If either the critcl package or the Trf package are available then a compiled version may be  used  internally  to
       accelerate the checksum calculation.

COMMANDS
       ::crc::crc32 ?-format format? ?-seed value? [ -channel chan | -filename file | message ]
              The  command  takes either string data or a channel or file name and returns a checksum value calculated using the CRC-32 algorithm.
              The result is formatted using the format(3tcl) specifier provided. The default is to return the value as an unsigned integer (format
              %u).

OPTIONS
       -channel name
              Return  a  checksum for the data read from a channel. The command will read data from the channel until the eof is true. If you need
              to be able to process events during this calculation see the PROGRAMMING INTERFACE section

       -filename name
              This is a convenience option that opens the specified file, sets the encoding to binary and then acts as if the -channel option  had
              been used. The file is closed on completion.

       -format string
              Return the checksum using an alternative format template.

       -seed value
              Select  an alternative seed value for the CRC calculation. The default is 0xffffffff. This can be useful for calculating the CRC for
              data structures without first converting the whole structure into a string. The CRC of the previous member can be used as  the  seed
              for  calculating  the CRC of the next member.  Note that the crc32 algorithm includes a final XOR step. If incremental processing is
              desired then this must be undone before using the output of the algorithm as the seed for further processing. A simpler  alternative
              is to use the PROGRAMMING INTERFACE which is intended for this mode of operation.

PROGRAMMING INTERFACE
       The  CRC-32  package implements the checksum using a context variable to which additional data can be added at any time. This is expecially
       useful in an event based environment such as a Tk application or a web server package. Data to be checksummed may be handled  incrementally
       during a fileevent handler in discrete chunks. This can improve the interactive nature of a GUI application and can help to avoid excessive
       memory consumption.

       ::crc::Crc32Init ?seed?
              Begins a new CRC32 context. Returns a token ID that must be used for the remaining functions. An optional seed may be  specified  if
              required.

       ::crc::Crc32Update token data
              Add  data  to  the  checksum identified by token. Calling Crc32Update $token "abcd" is equivalent to calling Crc32Update $token "ab"
              followed by Crc32Update $token "cb". See EXAMPLES.

       ::crc::Crc32Final token
              Returns the checksum value and releases any resources held by this token. Once this command completes the token will be invalid. The
              result is a 32 bit integer value.

EXAMPLES
              % crc::crc32 "Hello, World!"
              3964322768

              % crc::crc32 -format 0x%X "Hello, World!"
              0xEC4AC3D0

              % crc::crc32 -file crc32.tcl
              483919716

              % set tok [crc::Crc32Init]
              % crc::Crc32Update $tok "Hello, "
              % crc::Crc32Update $tok "World!"
              % crc::Crc32Final $tok
              3964322768

AUTHORS
       Pat Thoyts

BUGS, IDEAS, FEEDBACK
       This  document,  and the package it describes, will undoubtedly contain bugs and other problems.  Please report such in the category crc of
       the Tcllib Trackers [http://core.tcl.tk/tcllib/reportlist].  Please also report any ideas for enhancements you may have for either  package
       and/or documentation.

SEE ALSO
       cksum(3tcl), crc16(3tcl), sum(3tcl)

KEYWORDS
       checksum, cksum, crc, crc32, cyclic redundancy check, data integrity, security

CATEGORY
       Hashes, checksums, and encryption

COPYRIGHT
       Copyright (c) 2002, Pat Thoyts

tcllib                                                                 1.3.2                                                           crc32(3tcl)
