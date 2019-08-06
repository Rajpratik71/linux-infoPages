File: coreutils.info,  Node: File permissions,  Next: Date input formats,  Prev: Numeric operations,  Up: Top

26 File permissions
*******************

Each file has a set of "file mode bits" that control the kinds of
access that users have to that file.  They can be represented either in
symbolic form or as an octal number.

* Menu:

* Mode Structure::              Structure of file mode bits.
* Symbolic Modes::              Mnemonic representation of file mode bits.
* Numeric Modes::               File mode bits as octal numbers.
* Operator Numeric Modes::      ANDing, ORing, and setting modes octally.
* Directory Setuid and Setgid:: Set-user-ID and set-group-ID on directories.

File: coreutils.info,  Node: Mode Structure,  Next: Symbolic Modes,  Up: File permissions

26.1 Structure of File Mode Bits
================================

The file mode bits have two parts: the "file permission bits", which
control ordinary access to the file, and "special mode bits", which
affect only some files.

   There are three kinds of permissions that a user can have for a file:

  1. permission to read the file.  For directories, this means
     permission to list the contents of the directory.

  2. permission to write to (change) the file.  For directories, this
     means permission to create and remove files in the directory.

  3. permission to execute the file (run it as a program).  For
     directories, this means permission to access files in the
     directory.

   There are three categories of users who may have different
permissions to perform any of the above operations on a file:

  1. the file's owner;

  2. other users who are in the file's group;

  3. everyone else.

   Files are given an owner and group when they are created.  Usually
the owner is the current user and the group is the group of the
directory the file is in, but this varies with the operating system, the
file system the file is created on, and the way the file is created.
You can change the owner and group of a file by using the `chown' and
`chgrp' commands.

   In addition to the three sets of three permissions listed above, the
file mode bits have three special components, which affect only
executable files (programs) and, on most systems, directories:

  1. Set the process's effective user ID to that of the file upon
     execution (called the "set-user-ID bit", or sometimes the "setuid
     bit").  For directories on a few systems, give files created in
     the directory the same owner as the directory, no matter who
     creates them, and set the set-user-ID bit of newly-created
     subdirectories.

  2. Set the process's effective group ID to that of the file upon
     execution (called the "set-group-ID bit", or sometimes the "setgid
     bit").  For directories on most systems, give files created in the
     directory the same group as the directory, no matter what group
     the user who creates them is in, and set the set-group-ID bit of
     newly-created subdirectories.

  3. Prevent unprivileged users from removing or renaming a file in a
     directory unless they own the file or the directory; this is
     called the "restricted deletion flag" for the directory, and is
     commonly found on world-writable directories like `/tmp'.

     For regular files on some older systems, save the program's text
     image on the swap device so it will load more quickly when run;
     this is called the "sticky bit".

   In addition to the file mode bits listed above, there may be file
attributes specific to the file system, e.g., access control lists
(ACLs), whether a file is compressed, whether a file can be modified
(immutability), and whether a file can be dumped.  These are usually
set using programs specific to the file system.  For example:

ext2
     On GNU and GNU/Linux the file attributes specific to the ext2 file
     system are set using `chattr'.

FFS
     On FreeBSD the file flags specific to the FFS file system are set
     using `chflags'.

   Even if a file's mode bits allow an operation on that file, that
operation may still fail, because:

   * the file-system-specific attributes or flags do not permit it; or

   * the file system is mounted as read-only.

   For example, if the immutable attribute is set on a file, it cannot
be modified, regardless of the fact that you may have just run `chmod
a+w FILE'.

File: coreutils.info,  Node: Symbolic Modes,  Next: Numeric Modes,  Prev: Mode Structure,  Up: File permissions

26.2 Symbolic Modes
===================

"Symbolic modes" represent changes to files' mode bits as operations on
single-character symbols.  They allow you to modify either all or
selected parts of files' mode bits, optionally based on their previous
values, and perhaps on the current `umask' as well (*note Umask and
Protection::).

   The format of symbolic modes is:

     [ugoa...][-+=]PERMS...[,...]

where PERMS is either zero or more letters from the set `rwxXst', or a
single letter from the set `ugo'.

   The following sections describe the operators and other details of
symbolic modes.

* Menu:

* Setting Permissions::          Basic operations on permissions.
* Copying Permissions::          Copying existing permissions.
* Changing Special Mode Bits::   Special mode bits.
* Conditional Executability::    Conditionally affecting executability.
* Multiple Changes::             Making multiple changes.
* Umask and Protection::              The effect of the umask.

File: coreutils.info,  Node: Setting Permissions,  Next: Copying Permissions,  Up: Symbolic Modes

26.2.1 Setting Permissions
--------------------------

The basic symbolic operations on a file's permissions are adding,
removing, and setting the permission that certain users have to read,
write, and execute or search the file.  These operations have the
following format:

     USERS OPERATION PERMISSIONS

The spaces between the three parts above are shown for readability only;
symbolic modes cannot contain spaces.

   The USERS part tells which users' access to the file is changed.  It
consists of one or more of the following letters (or it can be empty;
*note Umask and Protection::, for a description of what happens then).
When more than one of these letters is given, the order that they are
in does not matter.

`u'
     the user who owns the file;

`g'
     other users who are in the file's group;

`o'
     all other users;

`a'
     all users; the same as `ugo'.

   The OPERATION part tells how to change the affected users' access to
the file, and is one of the following symbols:

`+'
     to add the PERMISSIONS to whatever permissions the USERS already
     have for the file;

`-'
     to remove the PERMISSIONS from whatever permissions the USERS
     already have for the file;

`='
     to make the PERMISSIONS the only permissions that the USERS have
     for the file.

   The PERMISSIONS part tells what kind of access to the file should be
changed; it is normally zero or more of the following letters.  As with
the USERS part, the order does not matter when more than one letter is
given.  Omitting the PERMISSIONS part is useful only with the `='
operation, where it gives the specified USERS no access at all to the
file.

`r'
     the permission the USERS have to read the file;

`w'
     the permission the USERS have to write to the file;

`x'
     the permission the USERS have to execute the file, or search it if
     it is a directory.

   For example, to give everyone permission to read and write a regular
file, but not to execute it, use:

     a=rw

   To remove write permission for all users other than the file's
owner, use:

     go-w

The above command does not affect the access that the owner of the file
has to it, nor does it affect whether other users can read or execute
the file.

   To give everyone except a file's owner no permission to do anything
with that file, use the mode below.  Other users could still remove the
file, if they have write permission on the directory it is in.

     go=

Another way to specify the same thing is:

     og-rwx

File: coreutils.info,  Node: Copying Permissions,  Next: Changing Special Mode Bits,  Prev: Setting Permissions,  Up: Symbolic Modes

26.2.2 Copying Existing Permissions
-----------------------------------

You can base a file's permissions on its existing permissions.  To do
this, instead of using a series of `r', `w', or `x' letters after the
operator, you use the letter `u', `g', or `o'.  For example, the mode

     o+g

adds the permissions for users who are in a file's group to the
permissions that other users have for the file.  Thus, if the file
started out as mode 664 (`rw-rw-r--'), the above mode would change it
to mode 666 (`rw-rw-rw-').  If the file had started out as mode 741
(`rwxr----x'), the above mode would change it to mode 745
(`rwxr--r-x').  The `-' and `=' operations work analogously.

File: coreutils.info,  Node: Changing Special Mode Bits,  Next: Conditional Executability,  Prev: Copying Permissions,  Up: Symbolic Modes

26.2.3 Changing Special Mode Bits
---------------------------------

In addition to changing a file's read, write, and execute/search
permissions, you can change its special mode bits.  *Note Mode
Structure::, for a summary of these special mode bits.

   To change the file mode bits to set the user ID on execution, use
`u' in the USERS part of the symbolic mode and `s' in the PERMISSIONS
part.

   To change the file mode bits to set the group ID on execution, use
`g' in the USERS part of the symbolic mode and `s' in the PERMISSIONS
part.

   To set both user and group ID on execution, omit the USERS part of
the symbolic mode (or use `a') and use `s' in the PERMISSIONS part.

   To change the file mode bits to set the restricted deletion flag or
sticky bit, omit the USERS part of the symbolic mode (or use `a') and
use `t' in the PERMISSIONS part.

   For example, to set the set-user-ID mode bit of a program, you can
use the mode:

     u+s

   To remove both set-user-ID and set-group-ID mode bits from it, you
can use the mode:

     a-s

   To set the restricted deletion flag or sticky bit, you can use the
mode:

     +t

   The combination `o+s' has no effect.  On GNU systems the
combinations `u+t' and `g+t' have no effect, and `o+t' acts like plain
`+t'.

   The `=' operator is not very useful with special mode bits.  For
example, the mode:

     o=t

does set the restricted deletion flag or sticky bit, but it also
removes all read, write, and execute/search permissions that users not
in the file's group might have had for it.

   *Note Directory Setuid and Setgid::, for additional rules concerning
set-user-ID and set-group-ID bits and directories.

File: coreutils.info,  Node: Conditional Executability,  Next: Multiple Changes,  Prev: Changing Special Mode Bits,  Up: Symbolic Modes

26.2.4 Conditional Executability
--------------------------------

There is one more special type of symbolic permission: if you use `X'
instead of `x', execute/search permission is affected only if the file
is a directory or already had execute permission.

   For example, this mode:

     a+X

gives all users permission to search directories, or to execute files if
anyone could execute them before.

File: coreutils.info,  Node: Multiple Changes,  Next: Umask and Protection,  Prev: Conditional Executability,  Up: Symbolic Modes

26.2.5 Making Multiple Changes
------------------------------

The format of symbolic modes is actually more complex than described
above (*note Setting Permissions::).  It provides two ways to make
multiple changes to files' mode bits.

   The first way is to specify multiple OPERATION and PERMISSIONS parts
after a USERS part in the symbolic mode.

   For example, the mode:

     og+rX-w

gives users other than the owner of the file read permission and, if it
is a directory or if someone already had execute permission to it,
gives them execute/search permission; and it also denies them write
permission to the file.  It does not affect the permission that the
owner of the file has for it.  The above mode is equivalent to the two
modes:

     og+rX
     og-w

   The second way to make multiple changes is to specify more than one
simple symbolic mode, separated by commas.  For example, the mode:

     a+r,go-w

gives everyone permission to read the file and removes write permission
on it for all users except its owner.  Another example:

     u=rwx,g=rx,o=

sets all of the permission bits for the file explicitly.  (It gives
users who are not in the file's group no permission at all for it.)

   The two methods can be combined.  The mode:

     a+r,g+x-w

gives all users permission to read the file, and gives users who are in
the file's group permission to execute/search it as well, but not
permission to write to it.  The above mode could be written in several
different ways; another is:

     u+r,g+rx,o+r,g-w

File: coreutils.info,  Node: Umask and Protection,  Prev: Multiple Changes,  Up: Symbolic Modes

26.2.6 The Umask and Protection
-------------------------------

If the USERS part of a symbolic mode is omitted, it defaults to `a'
(affect all users), except that any permissions that are _set_ in the
system variable `umask' are _not affected_.  The value of `umask' can
be set using the `umask' command.  Its default value varies from system
to system.

   Omitting the USERS part of a symbolic mode is generally not useful
with operations other than `+'.  It is useful with `+' because it
allows you to use `umask' as an easily customizable protection against
giving away more permission to files than you intended to.

   As an example, if `umask' has the value 2, which removes write
permission for users who are not in the file's group, then the mode:

     +w

adds permission to write to the file to its owner and to other users who
are in the file's group, but _not_ to other users.  In contrast, the
mode:

     a+w

ignores `umask', and _does_ give write permission for the file to all
users.

File: coreutils.info,  Node: Numeric Modes,  Next: Operator Numeric Modes,  Prev: Symbolic Modes,  Up: File permissions

26.3 Numeric Modes
==================

As an alternative to giving a symbolic mode, you can give an octal
(base 8) number that represents the mode.  This number is always
interpreted in octal; you do not have to add a leading `0', as you do
in C.  Mode `0055' is the same as mode `55'.  (However, modes of five
digits or more, such as `00055', are sometimes special.  *Note
Directory Setuid and Setgid::.)

   A numeric mode is usually shorter than the corresponding symbolic
mode, but it is limited in that normally it cannot take into account the
previous file mode bits; it can only set them absolutely.  The
set-user-ID and set-group-ID bits of directories are an exception to
this general limitation.  *Note Directory Setuid and Setgid::.  Also,
operator numeric modes can take previous file mode bits into account.
*Note Operator Numeric Modes::.

   The permissions granted to the user, to other users in the file's
group, and to other users not in the file's group each require three
bits, which are represented as one octal digit.  The three special mode
bits also require one bit each, and they are as a group represented as
another octal digit.  Here is how the bits are arranged, starting with
the lowest valued bit:

     Value in  Corresponding
     Mode      Mode Bit

               Other users not in the file's group:
        1      Execute/search
        2      Write
        4      Read

               Other users in the file's group:
       10      Execute/search
       20      Write
       40      Read

               The file's owner:
      100      Execute/search
      200      Write
      400      Read

               Special mode bits:
     1000      Restricted deletion flag or sticky bit
     2000      Set group ID on execution
     4000      Set user ID on execution

   For example, numeric mode `4755' corresponds to symbolic mode
`u=rwxs,go=rx', and numeric mode `664' corresponds to symbolic mode
`ug=rw,o=r'.  Numeric mode `0' corresponds to symbolic mode `a='.

File: coreutils.info,  Node: Operator Numeric Modes,  Next: Directory Setuid and Setgid,  Prev: Numeric Modes,  Up: File permissions

26.4 Operator Numeric Modes
===========================

An operator numeric mode is a numeric mode that is prefixed by a `-',
`+', or `=' operator, which has the same interpretation as in symbolic
modes.  For example, `+440' enables read permission for the file's
owner and group, `-1' disables execute permission for other users, and
`=600' clears all permissions except for enabling read-write
permissions for the file's owner.  Operator numeric modes can be
combined with symbolic modes by separating them with a comma; for
example, `=0,u+r' clears all permissions except for enabling read
permission for the file's owner.

   The commands `chmod =755 DIR' and `chmod 755 DIR' differ in that the
former clears the directory DIR's setuid and setgid bits, whereas the
latter preserves them.  *Note Directory Setuid and Setgid::.

   Operator numeric modes are a GNU extension.

File: coreutils.info,  Node: Directory Setuid and Setgid,  Prev: Operator Numeric Modes,  Up: File permissions

26.5 Directories and the Set-User-ID and Set-Group-ID Bits
==========================================================

On most systems, if a directory's set-group-ID bit is set, newly
created subfiles inherit the same group as the directory, and newly
created subdirectories inherit the set-group-ID bit of the parent
directory.  On a few systems, a directory's set-user-ID bit has a
similar effect on the ownership of new subfiles and the set-user-ID
bits of new subdirectories.  These mechanisms let users share files
more easily, by lessening the need to use `chmod' or `chown' to share
new files.

   These convenience mechanisms rely on the set-user-ID and set-group-ID
bits of directories.  If commands like `chmod' and `mkdir' routinely
cleared these bits on directories, the mechanisms would be less
convenient and it would be harder to share files.  Therefore, a command
like `chmod' does not affect the set-user-ID or set-group-ID bits of a
directory unless the user specifically mentions them in a symbolic
mode, or uses an operator numeric mode such as `=755', or sets them in
a numeric mode, or clears them in a numeric mode that has five or more
octal digits.  For example, on systems that support set-group-ID
inheritance:

     # These commands leave the set-user-ID and
     # set-group-ID bits of the subdirectories alone,
     # so that they retain their default values.
     mkdir A B C
     chmod 755 A
     chmod 0755 B
     chmod u=rwx,go=rx C
     mkdir -m 755 D
     mkdir -m 0755 E
     mkdir -m u=rwx,go=rx F

   If you want to try to set these bits, you must mention them
explicitly in the symbolic or numeric modes, e.g.:

     # These commands try to set the set-user-ID
     # and set-group-ID bits of the subdirectories.
     mkdir G
     chmod 6755 G
     chmod +6000 G
     chmod u=rwx,go=rx,a+s G
     mkdir -m 6755 H
     mkdir -m +6000 I
     mkdir -m u=rwx,go=rx,a+s J

   If you want to try to clear these bits, you must mention them
explicitly in a symbolic mode, or use an operator numeric mode, or
specify a numeric mode with five or more octal digits, e.g.:

     # These commands try to clear the set-user-ID
     # and set-group-ID bits of the directory D.
     chmod a-s D
     chmod -6000 D
     chmod =755 D
     chmod 00755 D

   This behavior is a GNU extension.  Portable scripts should not rely
on requests to set or clear these bits on directories, as POSIX allows
implementations to ignore these requests.  The GNU behavior with
numeric modes of four or fewer digits is intended for scripts portable
to systems that preserve these bits; the behavior with numeric modes of
five or more digits is for scripts portable to systems that do not
preserve the bits.

