ATTR(1)                                                                                   XFS Compatibility API                                                                                   ATTR(1)

NAME
       attr - extended attributes on XFS filesystem objects

SYNOPSIS
       attr [ -LRSq ] -s attrname [ -V attrvalue ] pathname

       attr [ -LRSq ] -g attrname pathname

       attr [ -LRSq ] -r attrname pathname

       attr [ -LRSq ] -l pathname

OVERVIEW
       Extended attributes implement the ability for a user to attach name:value pairs to objects within the XFS filesystem.

       This  document describes the attr command, which is mostly compatible with the IRIX command of the same name.  It is thus aimed specifically at users of the XFS filesystem - for filesystem inde‐
       pendent extended attribute manipulation, consult the getfattr(1) and setfattr(1) documentation.

       Extended attributes can be used to store meta-information about the file.  For example "character-set=kanji" could tell a document browser to use the Kanji character  set  when  displaying  that
       document and "thumbnail=..." could provide a reduced resolution overview of a high resolution graphic image.

       In  the  XFS filesystem, the names can be up to 256 bytes in length, terminated by the first 0 byte.  The intent is that they be printable ASCII (or other character set) names for the attribute.
       The values can be up to 64KB of arbitrary binary data.

       Attributes can be attached to all types of XFS inodes: regular files, directories, symbolic links, device nodes, etc.

       XFS uses 2 disjoint attribute name spaces associated with every filesystem object.  They are the root and user address spaces.  The root address space is accessible only to  the  superuser,  and
       then  only  by  specifying  a flag argument to the function call.  Other users will not see or be able to modify attributes in the root address space.  The user address space is protected by the
       normal file permissions mechanism, so the owner of the file can decide who is able to see and/or modify the value of attributes on any particular file.

DESCRIPTION
       The attr utility allows the manipulation of extended attributes associated with filesystem objects from within shell scripts.

       There are four main operations that attr can perform:

       GET    The -g attrname option tells attr to search the named object and print (to stdout) the value associated with that attribute name.  With the -q flag, stdout will be exactly  and  only  the
              value of the attribute, suitable for storage directly into a file or processing via a piped command.

       LIST   The  -l option tells attr to list the names of all the attributes that are associated with the object, and the number of bytes in the value of each of those attributes.  With the -q flag,
              stdout will be a simple list of only the attribute names, one per line, suitable for input into a script.

       REMOVE The -r attrname option tells attr to remove an attribute with the given name from the object if the attribute exists.  There is no output on successful completion.

       SET/CREATE
              The -s attrname option tells attr to set the named attribute of the object to the value read from stdin.  If an attribute with that name already exists, its value will  be  replaced  with
              this  one.  If an attribute with that name does not already exist, one will be created with this value.  With the -V attrvalue flag, the attribute will be set to have a value of attrvalue
              and stdin will not be read.  With the -q flag, stdout will not be used.  Without the -q flag, a message showing the attribute name and the entire value will be printed.

       When the -L option is given and the named object is a symbolic link, operate on the attributes of the object referenced by the symbolic link.  Without this option, operate on the  attributes  of
       the symbolic link itself.

       When the -R option is given and the process has appropriate privileges, operate in the root attribute namespace rather that the USER attribute namespace.

       The -S option is similar, except it specifies use of the security attribute namespace.

       When the -q option is given attr will try to keep quiet.  It will output error messages (to stderr) but will not print status messages (to stdout).

NOTES
       The standard file interchange/archive programs tar(1), and cpio(1) will not archive or restore extended attributes, while the xfsdump(8) program will.

CAVEATS
       The list option present in the IRIX version of this command is not supported.  getfattr provides a mechanism to retrieve all of the attribute names.

SEE ALSO
       getfattr(1), setfattr(1), attr_get(3), attr_set(3), attr_multi(3), attr_remove(3), attr(5), and xfsdump(8).

Dec 2001                                                                                   Extended Attributes                                                                                    ATTR(1)
ATTR(5)                                                                                    File Formats Manual                                                                                    ATTR(5)

NAME
       attr - Extended attributes

DESCRIPTION
       Extended  attributes  are  name:value pairs associated permanently with files and directories, similar to the environment strings associated with a process.  An attribute may be defined or unde‐
       fined.  If it is defined, its value may be empty or non-empty.

       Extended attributes are extensions to the normal attributes which are associated with all inodes in the system (i.e. the stat(2) data).  They are often used to provide  additional  functionality
       to a filesystem - for example, additional security features such as Access Control Lists (ACLs) may be implemented using extended attributes.

       Users with search access to a file or directory may retrieve a list of attribute names defined for that file or directory.

       Extended attributes are accessed as atomic objects.  Reading retrieves the whole value of an attribute and stores it in a buffer.  Writing replaces any previous value with the new value.

       Space consumed for extended attributes is counted towards the disk quotas of the file owner and file group.

       Currently, support for extended attributes is implemented on Linux by the ext2, ext3, ext4, XFS, JFS and reiserfs filesystems.

EXTENDED ATTRIBUTE NAMESPACES
       Attribute  names  are  zero-terminated  strings.   The  attribute  name  is  always  specified  in  the  fully  qualified  namespace.attribute  form,  eg.   user.mime_type,  trusted.md5sum, sys‐
       tem.posix_acl_access, or security.selinux.

       The namespace mechanism is used to define different classes of extended attributes.  These different classes exist for several reasons, e.g. the permissions and capabilities required for manipu‐
       lating extended attributes of one namespace may differ to another.

       Currently the security, system, trusted, and user extended attribute classes are defined as described below. Additional classes may be added in the future.

   Extended security attributes
       The  security  attribute namespace is used by kernel security modules, such as Security Enhanced Linux.  Read and write access permissions to security attributes depend on the policy implemented
       for each security attribute by the security module.  When no security module is loaded, all processes have read access to extended security attributes, and write access is limited  to  processes
       that have the CAP_SYS_ADMIN capability.

   Extended system attributes
       Extended  system  attributes  are  used by the kernel to store system objects such as Access Control Lists and Capabilities.  Read and write access permissions to system attributes depend on the
       policy implemented for each system attribute implemented by filesystems in the kernel.

   Trusted extended attributes
       Trusted extended attributes are visible and accessible only to processes that have the CAP_SYS_ADMIN capability (the super user usually has this capability).  Attributes in this class  are  used
       to implement mechanisms in user space (i.e., outside the kernel) which keep information in extended attributes to which ordinary processes should not have access.

   Extended user attributes
       Extended  user attributes may be assigned to files and directories for storing arbitrary additional information such as the mime type, character set or encoding of a file. The access permissions
       for user attributes are defined by the file permission bits.

       The file permission bits of regular files and directories are interpreted differently from the file permission bits of special files and symbolic links. For regular  files  and  directories  the
       file  permission bits define access to the file's contents, while for device special files they define access to the device described by the special file.  The file permissions of symbolic links
       are not used in access checks. These differences would allow users to consume filesystem resources in a way not controllable by disk quotas for group or world writable special files and directo‐
       ries.

       For  this  reason,  extended  user  attributes are only allowed for regular files and directories, and access to extended user attributes is restricted to the owner and to users with appropriate
       capabilities for directories with the sticky bit set (see the chmod(1) manual page for an explanation of Sticky Directories).

FILESYSTEM DIFFERENCES
       The kernel and the filesystem may place limits on the maximum number and size of extended attributes that can be associated with a file.  Some file systems, such as ext2/3 and reiserfs,  require
       the filesystem to be mounted with the user_xattr mount option in order for extended user attributes to be used.

       In the current ext2, ext3 and ext4 filesystem implementations, each extended attribute must fit on a single filesystem block (1024, 2048 or 4096 bytes, depending on the block size specified when
       the filesystem was created).

       In the XFS and reiserfs filesystem implementations, there is no practical limit on the number or size of extended attributes associated with a file, and the algorithms  used  to  store  extended
       attribute information on disk are scalable.

       In the JFS filesystem implementation, names can be up to 255 bytes and values up to 65,535 bytes.

ADDITIONAL NOTES
       Since  the filesystems on which extended attributes are stored might also be used on architectures with a different byte order and machine word size, care should be taken to store attribute val‐
       ues in an architecture independent format.

AUTHORS
       Andreas Gruenbacher, <a.gruenbacher@bestbits.at> and the SGI XFS development team, <linux-xfs@oss.sgi.com>.

SEE ALSO
       getfattr(1), setfattr(1).

                                                                                                                                                                                                  ATTR(5)
XATTR(7)                                                                                Linux Programmer's Manual                                                                                XATTR(7)

NAME
       attr - Extended attributes

DESCRIPTION
       Extended  attributes  are  name:value pairs associated permanently with files and directories, similar to the environment strings associated with a process.  An attribute may be defined or unde‐
       fined.  If it is defined, its value may be empty or non-empty.

       Extended attributes are extensions to the normal attributes which are associated with all inodes in the system (i.e., the stat(2) data).  They are often used to provide additional  functionality
       to a filesystem—for example, additional security features such as Access Control Lists (ACLs) may be implemented using extended attributes.

       Users with search access to a file or directory may use listxattr(2) to retrieve a list of attribute names defined for that file or directory.

       Extended attributes are accessed as atomic objects.  Reading (getxattr(2)) retrieves the whole value of an attribute and stores it in a buffer.  Writing (setxattr(2)) replaces any previous value
       with the new value.

       Space consumed for extended attributes may be counted towards the disk quotas of the file owner and file group.

   Extended attribute namespaces
       Attribute names are null-terminated strings.  The attribute name is always specified  in  the  fully  qualified  namespace.attribute  form,  for  example,  user.mime_type,  trusted.md5sum,  sys‐
       tem.posix_acl_access, or security.selinux.

       The namespace mechanism is used to define different classes of extended attributes.  These different classes exist for several reasons; for example, the permissions and capabilities required for
       manipulating extended attributes of one namespace may differ to another.

       Currently, the security, system, trusted, and user extended attribute classes are defined as described below.  Additional classes may be added in the future.

   Extended security attributes
       The security attribute namespace is used by kernel security modules, such as Security Enhanced Linux, and also to implement file capabilities (see capabilities(7)).  Read and write  access  per‐
       missions  to  security  attributes  depend  on  the  policy  implemented for each security attribute by the security module.  When no security module is loaded, all processes have read access to
       extended security attributes, and write access is limited to processes that have the CAP_SYS_ADMIN capability.

   Extended system attributes
       Extended system attributes are used by the kernel to store system objects such as Access Control Lists.  Read and write access permissions to system attributes depend on the  policy  implemented
       for each system attribute implemented by filesystems in the kernel.

   Trusted extended attributes
       Trusted  extended  attributes are visible and accessible only to processes that have the CAP_SYS_ADMIN capability.  Attributes in this class are used to implement mechanisms in user space (i.e.,
       outside the kernel) which keep information in extended attributes to which ordinary processes should not have access.

   Extended user attributes
       Extended user attributes may be assigned to files and directories for storing arbitrary additional information such as the mime type, character set or encoding of a file.  The access permissions
       for user attributes are defined by the file permission bits: read permission is required to retrieve the attribute value, and writer permission is required to change it.

       The  file  permission  bits of regular files and directories are interpreted differently from the file permission bits of special files and symbolic links.  For regular files and directories the
       file permission bits define access to the file's contents, while for device special files they define access to the device described by the special file.  The file permissions of symbolic  links
       are  not used in access checks.  These differences would allow users to consume filesystem resources in a way not controllable by disk quotas for group or world writable special files and direc‐
       tories.

       For this reason, extended user attributes are allowed only for regular files and directories, and access to extended user attributes is restricted to the owner  and  to  users  with  appropriate
       capabilities for directories with the sticky bit set (see the chmod(1) manual page for an explanation of the sticky bit).

   Filesystem differences
       The  kernel  and the filesystem may place limits on the maximum number and size of extended attributes that can be associated with a file.  The VFS imposes limitations that an attribute names is
       limited to 255 bytes and an attribute value is limited to 64 kB.  The list of attribute names that can be returned is also limited to 64 kB (see BUGS in listxattr(2)).

       Some filesystems, such as Reiserfs (and, historically, ext2 and ext3), require the filesystem to be mounted with the user_xattr mount option in order for extended user attributes to be used.

       In the current ext2, ext3, and ext4 filesystem implementations, the total bytes used by the names and values of all of a files extended attributes must fit in a single  filesystem  block  (1024,
       2048 or 4096 bytes, depending on the block size specified when the filesystem was created).

       In  the  Btrfs,  XFS,  and Reiserfs filesystem implementations, there is no practical limit on the number of extended attributes associated with a file, and the algorithms used to store extended
       attribute information on disk are scalable.

       In the JFS, XFS, and Reiserfs filesystem implementations, the limit on bytes used in an EA value is the ceiling imposed by the VFS.

       In the Btrfs filesystem implementation, the total bytes used for the name, value, and implementation overhead bytes is limited to the filesystem nodesize value (16 kB by default).

CONFORMING TO
       Extended attributes are not specified in POSIX.1, but some other systems (e.g., the BSDs and Solaris) provide a similar feature.

NOTES
       Since the filesystems on which extended attributes are stored might also be used on architectures with a different byte order and machine word size, care should be taken to store attribute  val‐
       ues in an architecture-independent format.

       This page was formerly named attr(5).

SEE ALSO
       getfattr(1), setfattr(1), getxattr(2), listxattr(2), removexattr(2), setxattr(2), acl(5), capabilities(7)

COLOPHON
       This  page  is  part  of  release  4.04  of  the  Linux  man-pages  project.  A description of the project, information about reporting bugs, and the latest version of this page, can be found at
       http://www.kernel.org/doc/man-pages/.

Linux                                                                                           2015-05-01                                                                                       XATTR(7)
