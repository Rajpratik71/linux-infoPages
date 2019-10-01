File: coreutils.info,  Node: shred invocation,  Prev: rm invocation,  Up: Basic operations

11.6 'shred': Remove files more securely
========================================

'shred' overwrites devices or files, to help prevent even very expensive
hardware from recovering the data.

   Ordinarily when you remove a file (*note rm invocation::), the data
is not actually destroyed.  Only the index listing where the file is
stored is destroyed, and the storage is made available for reuse.  There
are undelete utilities that will attempt to reconstruct the index and
can bring the file back if the parts were not reused.

   On a busy system with a nearly-full drive, space can get reused in a
few seconds.  But there is no way to know for sure.  If you have
sensitive data, you may want to be sure that recovery is not possible by
actually overwriting the file with non-sensitive data.

   However, even after doing that, it is possible to take the disk back
to a laboratory and use a lot of sensitive (and expensive) equipment to
look for the faint "echoes" of the original data underneath the
overwritten data.  If the data has only been overwritten once, it's not
even that hard.

   The best way to remove something irretrievably is to destroy the
media it's on with acid, melt it down, or the like.  For cheap removable
media like floppy disks, this is the preferred method.  However, hard
drives are expensive and hard to melt, so the 'shred' utility tries to
achieve a similar effect non-destructively.

   This uses many overwrite passes, with the data patterns chosen to
maximize the damage they do to the old data.  While this will work on
floppies, the patterns are designed for best effect on hard drives.  For
more details, see the source code and Peter Gutmann's paper 'Secure
Deletion of Data from Magnetic and Solid-State Memory'
(http://www.cs.auckland.ac.nz/~pgut001/pubs/secure_del.html), from the
proceedings of the Sixth USENIX Security Symposium (San Jose,
California, July 22-25, 1996).

   *Please note* that 'shred' relies on a very important assumption:
that the file system overwrites data in place.  This is the traditional
way to do things, but many modern file system designs do not satisfy
this assumption.  Exceptions include:

   * Log-structured or journaled file systems, such as those supplied
     with AIX and Solaris, and JFS, ReiserFS, XFS, Ext3 (in
     'data=journal' mode), BFS, NTFS, etc., when they are configured to
     journal _data_.

   * File systems that write redundant data and carry on even if some
     writes fail, such as RAID-based file systems.

   * File systems that make snapshots, such as Network Appliance's NFS
     server.

   * File systems that cache in temporary locations, such as NFS version
     3 clients.

   * Compressed file systems.

   In the particular case of ext3 file systems, the above disclaimer
applies (and 'shred' is thus of limited effectiveness) only in
'data=journal' mode, which journals file data in addition to just
metadata.  In both the 'data=ordered' (default) and 'data=writeback'
modes, 'shred' works as usual.  Ext3 journaling modes can be changed by
adding the 'data=something' option to the mount options for a particular
file system in the '/etc/fstab' file, as documented in the mount man
page (man mount).

   If you are not sure how your file system operates, then you should
assume that it does not overwrite data in place, which means that shred
cannot reliably operate on regular files in your file system.

   Generally speaking, it is more reliable to shred a device than a
file, since this bypasses the problem of file system design mentioned
above.  However, even shredding devices is not always completely
reliable.  For example, most disks map out bad sectors invisibly to the
application; if the bad sectors contain sensitive data, 'shred' won't be
able to destroy it.

   'shred' makes no attempt to detect or report this problem, just as it
makes no attempt to do anything about backups.  However, since it is
more reliable to shred devices than files, 'shred' by default does not
truncate or remove the output file.  This default is more suitable for
devices, which typically cannot be truncated and should not be removed.

   Finally, consider the risk of backups and mirrors.  File system
backups and remote mirrors may contain copies of the file that cannot be
removed, and that will allow a shredded file to be recovered later.  So
if you keep any data you may later want to destroy using 'shred', be
sure that it is not backed up or mirrored.

     shred [OPTION]... FILE[...]

   The program accepts the following options.  Also see *note Common
options::.

'-f'
'--force'
     Override file permissions if necessary to allow overwriting.

'-NUMBER'
'-n NUMBER'
'--iterations=NUMBER'
     By default, 'shred' uses 3 passes of overwrite.  You can reduce
     this to save time, or increase it if you think it's appropriate.
     After 25 passes all of the internal overwrite patterns will have
     been used at least once.

'--random-source=FILE'
     Use FILE as a source of random data used to overwrite and to choose
     pass ordering.  *Note Random sources::.

'-s BYTES'
'--size=BYTES'
     Shred the first BYTES bytes of the file.  The default is to shred
     the whole file.  BYTES can be followed by a size specification like
     'K', 'M', or 'G' to specify a multiple.  *Note Block size::.

'-u'
'--remove[=HOW]'
     After shredding a file, truncate it (if possible) and then remove
     it.  If a file has multiple links, only the named links will be
     removed.  Often the file name is less sensitive than the file data,
     in which case the optional HOW parameter gives control of how to
     more efficiently remove each directory entry.  The 'unlink'
     parameter will just use a standard unlink call, 'wipe' will also
     first obfuscate bytes in the name, and 'wipesync' will also sync
     each obfuscated byte in the name to disk.  Note 'wipesync' is the
     default method, but can be expensive, requiring a sync for every
     character in every file.  This can become significant with many
     files, or is redundant if your file system provides synchronous
     metadata updates.

'-v'
'--verbose'
     Display to standard error all status updates as sterilization
     proceeds.

'-x'
'--exact'
     By default, 'shred' rounds the size of a regular file up to the
     next multiple of the file system block size to fully erase the last
     block of the file.  Use '--exact' to suppress that behavior.  Thus,
     by default if you shred a 10-byte regular file on a system with
     512-byte blocks, the resulting file will be 512 bytes long.  With
     this option, shred does not increase the apparent size of the file.

'-z'
'--zero'
     Normally, the last pass that 'shred' writes is made up of random
     data.  If this would be conspicuous on your hard drive (for
     example, because it looks like encrypted data), or you just think
     it's tidier, the '--zero' option adds an additional overwrite pass
     with all zero bits.  This is in addition to the number of passes
     specified by the '--iterations' option.

   You might use the following command to erase all trace of the file
system you'd created on the floppy disk in your first drive.  That
command takes about 20 minutes to erase a "1.44MB" (actually 1440 KiB)
floppy.

     shred --verbose /dev/fd0

   Similarly, to erase all data on a selected partition of your hard
disk, you could give a command like this:

     shred --verbose /dev/sda5

   On modern disks, a single pass should be adequate, and it will take
one third the time of the default three-pass approach.

     # 1 pass, write pseudo-random data; 3x faster than the default
     shred --verbose -n1 /dev/sda5

   To be on the safe side, use at least one pass that overwrites using
pseudo-random data.  I.e., don't be tempted to use '-n0 --zero', in case
some disk controller optimizes the process of writing blocks of all
zeros, and thereby does not clear all bytes in a block.  Some SSDs may
do just that.

   A FILE of '-' denotes standard output.  The intended use of this is
to shred a removed temporary file.  For example:

     i=$(mktemp)
     exec 3<>"$i"
     rm -- "$i"
     echo "Hello, world" >&3
     shred - >&3
     exec 3>-

   However, the command 'shred - >file' does not shred the contents of
FILE, since the shell truncates FILE before invoking 'shred'.  Use the
command 'shred file' or (if using a Bourne-compatible shell) the command
'shred - 1<>file' instead.

   An exit status of zero indicates success, and a nonzero value
indicates failure.

