Next: sha2 utilities,  Prev: md5sum invocation,  Up: Summarizing files

6.5 ‘sha1sum’: Print or check SHA-1 digests
===========================================

‘sha1sum’ computes a 160-bit checksum for each specified FILE.  The
usage and options of this command are precisely the same as for
‘md5sum’.  *Note md5sum invocation::.

   Note: The SHA-1 digest is more secure than MD5, and no collisions of
it are known (different files having the same fingerprint).  However, it
is known that they can be produced with considerable, but not
unreasonable, resources.  For this reason, it is generally considered
that SHA-1 should be gradually phased out in favor of the more secure
SHA-2 hash algorithms.  *Note sha2 utilities::.

