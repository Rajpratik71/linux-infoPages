File: coreutils.info,  Node: sha1sum invocation,  Next: sha2 utilities,  Prev: md5sum invocation,  Up: Summarizing files

6.6 ‘sha1sum’: Print or check SHA-1 digests
===========================================

‘sha1sum’ computes a 160-bit checksum for each specified FILE.  The
usage and options of this command are precisely the same as for
‘md5sum’.  *Note md5sum invocation::.

   Note: The SHA-1 digest is more reliable than a simple CRC (provided
by the ‘cksum’ command) for detecting accidental file corruption, as the
chances of accidentally having two files with identical SHA-1 are
vanishingly small.  However, it should not be considered secure against
malicious tampering: although finding a file with a given SHA-1
fingerprint is considered infeasible at the moment, it is known how to
modify certain files, including digital certificates, so that they
appear valid when signed with an SHA-1 digest.  For more secure hashes,
consider using SHA-2, or the newer ‘b2sum’ command.  *Note sha2
utilities::.  *Note b2sum invocation::.

