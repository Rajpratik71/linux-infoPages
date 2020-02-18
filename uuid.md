UUID(1)               Universally Unique Identifier              UUID(1)

NAME
       uuid - Universally Unique Identifier Command-Line Tool

VERSION
       OSSP uuid 1.6.2 (04-Jul-2008)

SYNOPSIS
       uuid [-v version] [-m] [-n count] [-1] [-F format] [-o filename]
       [namespace name]

       uuid -d [-r] [-o filename] uuid

DESCRIPTION
       OSSP uuid is a ISO-C:1999 application programming interface (API)
       and corresponding command line interface (CLI) for the generation
       of DCE 1.1, ISO/IEC 11578:1996 and IETF RFC-4122 compliant
       Universally Unique Identifier (UUID). It supports DCE 1.1 variant
       UUIDs of version 1 (time and node based), version 3 (name based,
       MD5), version 4 (random number based) and version 5 (name based,
       SHA-1). Additional API bindings are provided for the languages
       ISO-C++:1998, Perl:5 and PHP:4/5. Optional backward compatibility
       exists for the ISO-C DCE-1.1 and Perl Data::UUID APIs.

       UUIDs are 128 bit numbers which are intended to have a high
       likelihood of uniqueness over space and time and are
       computationally difficult to guess. They are globally unique
       identifiers which can be locally generated without contacting a
       global registration authority. UUIDs are intended as unique
       identifiers for both mass tagging objects with an extremely short
       lifetime and to reliably identifying very persistent objects
       across a network.

       This is the command line interface (CLI) of OSSP uuid. For a
       detailed description of UUIDs see the documentation of the
       application programming interface (API) in uuid(3).

OPTIONS
       -v version
          Sets the version of the generated DCE 1.1 variant UUID.
          Supported are version "1", "3", "4" and "5". The default is
          "1".

          For version 3 and version 5 UUIDs the additional command line
          arguments namespace and name have to be given. The namespace
          is either a UUID in string representation or an identifier for
          internally pre-defined namespace UUIDs (currently known are
          "ns:DNS", "ns:URL", "ns:OID", and "ns:X500"). The name is a
          string of arbitrary length.

       -m Forces the use of a random multi-cast MAC address when
          generating version 1 UUIDs. By default the real physical MAC
          address of the system is used.

       -n count
          Generate count UUIDs instead of just a single one (the
          default).

       -1 If option -n is used with a count greater than 1, then this
          option can enforce the reset the UUID context for each
          generated UUID.  This makes no difference for version 3, 4 and
          5 UUIDs. But version 1 UUIDs are based on the previously
          generated UUID which is remembered in the UUID context of the
          API. Option -1 deletes the remembered UUID on each iteration.

       -F format
          Representation format for importing or exporting an UUID. The
          following (case insensitive) format identifiers are currently
          recognized:

          BIN (binary representation)
              This is the raw 128 bit network byte order binary
              representation of a UUID. Example is the octet stream 0xF8
              0x1D 0x4F 0xAE 0x7D 0xEC 0x11 0xD0 0xA7 0x65 0x00 0xA0
              0xC9 0x1E 0x6B 0xF6.

          STR (string representation)
              This is the 36 character hexadecimal ASCII string
              representation of a UUID. Example is the string
              "f81d4fae-7dec-11d0-a765-00a0c91e6bf6".

          SIV (single integer value representation)
              This is the maximum 39 character long single integer value
              representation of a UUID. Example is the string
              "329800735698586629295641978511506172918".

       -o filename
          Write output to filename instead of to stdout.

       -d Decode a given UUID (given as a command line argument or if
          the command line argument is "-" the UUID is read from stdin)
          and dump textual information about the UUID.

EXAMPLES
        # generate DCE 1.1 v1 UUID (time and node based)
        $ uuid -v1
        01c47915-4777-11d8-bc70-0090272ff725

        # decode and dump DCE 1.1 v1 UUID (time and node based)
        $ uuid -d 01c47915-4777-11d8-bc70-0090272ff725
        encode: STR:     01c47915-4777-11d8-bc70-0090272ff725
                SIV:     2349374037528578887923094374772111141
        decode: variant: DCE 1.1, ISO/IEC 11578:1996
                version: 1 (time and node based)
                content: time:  2004-01-15 16:22:26.376322.1 UTC
                         clock: 15472 (usually random)
                         node:  00:90:27:2f:f7:25 (global unicast)

        # generate DCE 1.1 v3 UUID (name based)
        $ uuid -v3 ns:URL http://www.ossp.org/
        02d9e6d5-9467-382e-8f9b-9300a64ac3cd

        # decode and dump DCE 1.1 v3 UUID (name based)
        $ uuid -d 02d9e6d5-9467-382e-8f9b-9300a64ac3cd
        encode: STR:     02d9e6d5-9467-382e-8f9b-9300a64ac3cd
                SIV:     3789866285607910888100818383505376205
        decode: variant: DCE 1.1, ISO/IEC 11578:1996
                version: 3 (name based, MD5)
                content: 02:D9:E6:D5:94:67:08:2E:0F:9B:93:00:A6:4A:C3:CD
                         (not decipherable: MD5 message digest only)

        # generate DCE 1.1 v4 UUID 4 (random data based)
        $ uuid -v4
        eb424026-6f54-4ef8-a4d0-bb658a1fc6cf

        # decode and dump DCE 1.1 v4 UUID 4 (random data based)
        $ uuid -d eb424026-6f54-4ef8-a4d0-bb658a1fc6cf
        encode: STR:     eb424026-6f54-4ef8-a4d0-bb658a1fc6cf
                SIV:     312712571721458096795100956955942831823
        decode: variant: DCE 1.1, ISO/IEC 11578:1996
                version: 4 (random data based)
                content: EB:42:40:26:6F:54:0E:F8:24:D0:BB:65:8A:1F:C6:CF
                         (no semantics: random data only)

SEE ALSO
       uuid(3), OSSP::uuid(3).

04-Jul-2008                  OSSP uuid 1.6.2                     UUID(1)
uuid(3tcl)                        uuid                        uuid(3tcl)

________________________________________________________________________

NAME
       uuid - UUID generation and comparison

SYNOPSIS
       package require Tcl  8.2

       package require uuid  ?1.0.4?

       ::uuid::uuid generate

       ::uuid::uuid equal id1 id2

________________________________________________________________________

DESCRIPTION
       This  package  provides a generator of universally unique identi‐
       fiers (UUID) also known as globally  unique  identifiers  (GUID).
       This  implementation  follows  the  draft  specification from (1)
       although this is actually an expired draft document.

COMMANDS
       ::uuid::uuid generate
              Creates a type 4 uuid by MD5 hashing a number of  bits  of
              variant data including the time and hostname.  Returns the
              string representation of the new uuid.

       ::uuid::uuid equal id1 id2
              Compares two uuids and returns true if both arguments  are
              the same uuid.

EXAMPLES
              % uuid::uuid generate
              b12dc22c-5c36-41d2-57da-e29d0ef5839c

REFERENCES
       [1]    Paul   J.   Leach,   "UUIDs  and  GUIDs",  February  1998.
              (http://www.opengroup.org/dce/info/draft-leach-uuids-
              guids-01.txt)

BUGS, IDEAS, FEEDBACK
       This  document,  and  the  package it describes, will undoubtedly
       contain bugs and other problems.  Please report such in the cate‐
       gory        uuid        of        the       Tcllib       Trackers
       [http://core.tcl.tk/tcllib/reportlist].  Please also  report  any
       ideas  for  enhancements  you  may have for either package and/or
       documentation.

KEYWORDS
       GUID, UUID

CATEGORY
       Hashes, checksums, and encryption

COPYRIGHT
       Copyright (c) 2004, Pat Thoyts <patthoyts@users.sourceforge.net>

tcllib                            1.0.4                       uuid(3tcl)
UUID(3pm)          User Contributed Perl Documentation         UUID(3pm)

NAME
       UUID - DCE compatible Universally Unique Identifier library for
       Perl

SYNOPSIS
           use UUID ':all';

           generate($uuid);               # generate binary UUID, prefer random
           generate_random($uuid);        # generate binary UUID, using random
           generate_time($uuid);          # generate binary UUID, using time

           $string = uuid();              # generate stringified UUID

           unparse($uuid, $string);       # change $uuid string
           unparse_lower($uuid, $string); # change $uuid to lowercase string
           unparse_upper($uuid, $string); # change $uuid to uppercase string

           $rc = parse($string, $uuid);   # map string to UUID, return -1 on error

           copy($dst, $src);              # copy binary UUID from $src to $dst
           compare($uuid1, $uuid2);       # compare binary UUIDs

           clear( $uuid );                # set binary UUID to NULL
           is_null( $uuid);               # compare binary UUID to NULL

DESCRIPTION
       The UUID library is used to generate unique identifiers for
       objects that may be accessible beyond the local system. For
       instance, they could be used to generate unique HTTP cookies
       across multiple web servers without communication between the
       servers, and without fear of a name clash.

       The generated UUIDs can be reasonably expected to be unique
       within a system, and unique across all systems, and are
       compatible with those created by the Open Software Foundation
       (OSF) Distributed Computing Environment (DCE) utility uuidgen.

FUNCTIONS
       Most of the UUID functions expose the underlying libuuid C
       interface rather directly. That is, many return their values in
       their parameters and nothing else.

       Not very Perlish, is it? It's been like that for a long time
       though, so not very likely to change any time soon.

       All take or return UUIDs in either binary or string format. The
       string format resembles the following:

           1b4e28ba-2fa1-11d2-883f-0016d3cca427

       Or, in terms of printf(3) format:

           "%08x-%04x-%04x-%04x-%012x"

       The binary format is simply a packed 16 byte binary value.

   generate( $uuid )
       Generates a new binary UUID based on high quality randomness from
       /dev/urandom, if available.

       Alternately, the current time, the local ethernet MAC address (if
       available), and random data generated using a pseudo-random
       generator are used.

       The previous content of $uuid, if any, is lost.

   generate_random( $uuid )
       Generates a new binary UUID but forces the use of the all-random
       algorithm, even if a high-quality random number generator (i.e.,
       /dev/urandom) is not available, in which case a pseudo-random
       generator is used.

       Note that the use of a pseudo-random generator may compromise the
       uniqueness of UUIDs generated in this fashion.

   generate_time( $uuid )
       Generates a new binary UUID but forces the use of the alternative
       algorithm which uses the current time and the local ethernet MAC
       address (if available).

       This algorithm used to be the default one used to generate UUIDs,
       but because of the use of the ethernet MAC address, it can leak
       information about when and where the UUID was generated.

       This can cause privacy problems in some applications, so the
       generate() function only uses this algorithm if a high-quality
       source of randomness is not available.

   unparse( $uuid, $string )
       Converts the binary UUID in $uuid to string format and returns in
       $string. The previous content of $string, if any, is lost.

       The case of the hex digits returned may be upper or lower case,
       and is dependent on the system-dependent local default.

   unparse_lower( $uuid, $string )
       Same as unparse() but $string is forced to lower case.

   unparse_upper( $uuid, $string )
       Same as unparse() but $string is forced to upper case.

   $rc = parse( $string, $uuid )
       Converts the string format UUID in $string to binary and returns
       in $uuid. The previous content of $uuid, if any, is lost.

       Returns 0 on success and -1 on failure. Additionally on failure,
       the content of $uuid is unchanged.

   clear( $uuid )
       Sets $uuid equal to the value of the NULL UUID.

   is_null( $uuid )
       Compares the value of $uuid to the NULL UUID.

       Returns 1 if NULL, and 0 otherwise.

   copy( $dst, $src )
       Copies the binary $src UUID to $dst.

       If $src isn't a UUID, $dst is set to the NULL UUID.

   compare( $uuid1, $uuid2 )
       Compares two binary UUIDs.

       Returns an integer less than, equal to, or greater than zero if
       $uuid1 is less than, equal to, or greater than $uuid2.

       However, if either operand is not a UUID, falls back to a simple
       string comparison returning similar values.

   $string = uuid()
       Creates a new string format UUID and returns it in a more Perlish
       way.

       Functionally the equivalent of calling generate() and then
       unparse(), but throwing away the intermediate binary UUID.

EXPORTS
       All functions may be imported in the usual manner, either
       individually or all at once using the ":all" tag.

TODO
       Need more tests and sanity checks.

COPYRIGHT AND LICENSE
       This software is Copyright (c) 2014, 2015 by Rick Myers.

       This is free software, licensed under:

         The Artistic License 2.0 (GPL Compatible)

       Details of this license can be found within the 'License' text
       file.

AUTHOR
       Current maintainer:

         Rick Myers <jrm@cpan.org>.

       Authors and/or previous maintainers:

         Lukas Zapletal <lzap@cpan.org>

         Joseph N. Hall <joseph.nathan.hall@gmail.com>

         Colin Faber <cfaber@clusterfs.com>

         Peter J. Braam <braam@mountainviewdata.com>

SEE ALSO
       uuid(3), uuid_clear(3), uuid_compare(3), uuid_copy(3),
       uuid_generate(3), uuid_is_null(3), uuid_parse(3),
       uuid_unparse(3), perl(1).

perl v5.22.1                   2015-12-17                      UUID(3pm)
