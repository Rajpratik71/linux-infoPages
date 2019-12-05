File: coreutils.info,  Node: b2sum invocation,  Next: md5sum invocation,  Prev: cksum invocation,  Up: Summarizing files

6.4 ‘b2sum’: Print or check BLAKE2 digests
==========================================

‘b2sum’ computes a 512-bit checksum for each specified FILE.  The same
usage and options as the ‘md5sum’ command are supported.  *Note md5sum
invocation::.  In addition ‘b2sum’ supports the following options.

‘-l’
‘--length’
     Change (shorten) the default digest length.  This is specified in
     bits and thus must be a multiple of 8.  This option is ignored when
     ‘--check’ is specified, as the length is automatically determined
     when checking.

