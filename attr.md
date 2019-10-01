File: *manpages*,  Node: attr,  Up: (dir)

ATTR(1)                      XFS Compatibility API                     ATTR(1)



NAME
       attr - extended attributes on XFS filesystem objects

SYNOPSIS
       attr [ -LRSq ] -s attrname [ -V attrvalue ] pathname

       attr [ -LRSq ] -g attrname pathname

       attr [ -LRSq ] -r attrname pathname

       attr [ -LRSq ] -l pathname


OVERVIEW
       Extended  attributes  implement  the  ability  for  a  user  to  attach
       name:value pairs to objects within the XFS filesystem.

       This document describes the attr command, which  is  mostly  compatible
       with  the IRIX command of the same name.  It is thus aimed specifically
       at users of the XFS filesystem - for  filesystem  independent  extended
       attribute  manipulation,  consult the getfattr(1) and setfattr(1) docu‐
       mentation.

       Extended attributes can be used to  store  meta-information  about  the
       file.   For example "character-set=kanji" could tell a document browser
       to use the Kanji  character  set  when  displaying  that  document  and
       "thumbnail=..."  could  provide a reduced resolution overview of a high
       resolution graphic image.

       In the XFS filesystem, the names can be up to 256 bytes in length, ter‐
       minated  by  the  first  0  byte.  The intent is that they be printable
       ASCII (or other character set) names for the attribute.  The values can
       be up to 64KB of arbitrary binary data.

       Attributes  can  be attached to all types of XFS inodes: regular files,
       directories, symbolic links, device nodes, etc.

       XFS uses  2  disjoint  attribute  name  spaces  associated  with  every
       filesystem  object.   They  are  the root and user address spaces.  The
       root address space is accessible only to the superuser, and  then  only
       by  specifying  a flag argument to the function call.  Other users will
       not see or be able to modify attributes in the root address space.  The
       user  address  space is protected by the normal file permissions mecha‐
       nism, so the owner of the file can decide who is  able  to  see  and/or
       modify the value of attributes on any particular file.

DESCRIPTION
       The attr utility allows the manipulation of extended attributes associ‐
       ated with filesystem objects from within shell scripts.

       There are four main operations that attr can perform:

       GET    The -g attrname option tells attr to search the named object and
              print (to stdout) the value associated with that attribute name.
              With the -q flag, stdout will be exactly and only the  value  of
              the attribute, suitable for storage directly into a file or pro‐
              cessing via a piped command.

       LIST   The -l option tells attr to list the names of all the attributes
              that  are associated with the object, and the number of bytes in
              the value of each of those attributes.  With the -q flag, stdout
              will be a simple list of only the attribute names, one per line,
              suitable for input into a script.

       REMOVE The -r attrname option tells attr to remove  an  attribute  with
              the  given  name from the object if the attribute exists.  There
              is no output on successful completion.

       SET/CREATE
              The -s attrname option tells attr to set the named attribute  of
              the  object  to the value read from stdin.  If an attribute with
              that name already exists, its value will be replaced  with  this
              one.  If an attribute with that name does not already exist, one
              will be created with this value.  With the  -V  attrvalue  flag,
              the attribute will be set to have a value of attrvalue and stdin
              will not be read.  With the -q flag, stdout will  not  be  used.
              Without  the  -q  flag, a message showing the attribute name and
              the entire value will be printed.

       When the -L option is given and the named object is  a  symbolic  link,
       operate  on  the  attributes  of  the object referenced by the symbolic
       link.  Without this option, operate on the attributes of  the  symbolic
       link itself.

       When the -R option is given and the process has appropriate privileges,
       operate in the root attribute namespace rather that the USER  attribute
       namespace.

       The  -S  option  is  similar,  except  it specifies use of the security
       attribute namespace.

       When the -q option is given attr will try to keep quiet.  It will  out‐
       put  error  messages (to stderr) but will not print status messages (to
       stdout).

NOTES
       The standard file interchange/archive programs tar(1), and cpio(1) will
       not  archive  or restore extended attributes, while the xfsdump(8) pro‐
       gram will.

CAVEATS
       The list option present in the IRIX version of this command is not sup‐
       ported.  getfattr provides a mechanism to retrieve all of the attribute
       names.

SEE ALSO
       getfattr(1),  setfattr(1),  attr_get(3),  attr_set(3),   attr_multi(3),
       attr_remove(3), attr(5), and xfsdump(8).



Dec 2001                      Extended Attributes                      ATTR(1)
ATTR(5)                       File Formats Manual                      ATTR(5)



NAME
       attr - Extended attributes

DESCRIPTION
       Extended  attributes  are  name:value pairs associated permanently with
       files and directories, similar to the  environment  strings  associated
       with  a  process.   An attribute may be defined or undefined.  If it is
       defined, its value may be empty or non-empty.

       Extended attributes are extensions to the normal attributes  which  are
       associated with all inodes in the system (i.e. the stat(2) data).  They
       are often used to provide additional functionality to  a  filesystem  -
       for  example, additional security features such as Access Control Lists
       (ACLs) may be implemented using extended attributes.

       Users with search access to a file or directory may retrieve a list  of
       attribute names defined for that file or directory.

       Extended  attributes are accessed as atomic objects.  Reading retrieves
       the whole value of an attribute and stores it  in  a  buffer.   Writing
       replaces any previous value with the new value.

       Space consumed for extended attributes is counted towards the disk quo‐
       tas of the file owner and file group.

       Currently, support for extended attributes is implemented on  Linux  by
       the ext2, ext3, ext4, XFS, JFS and reiserfs filesystems.

EXTENDED ATTRIBUTE NAMESPACES
       Attribute  names  are  zero-terminated  strings.  The attribute name is
       always specified in the fully qualified namespace.attribute  form,  eg.
       user.mime_type,   trusted.md5sum,   system.posix_acl_access,  or  secu‐
       rity.selinux.

       The namespace mechanism is used to define different classes of extended
       attributes.   These  different  classes exist for several reasons, e.g.
       the permissions and capabilities  required  for  manipulating  extended
       attributes of one namespace may differ to another.

       Currently  the  security,  system, trusted, and user extended attribute
       classes are defined as described below. Additional classes may be added
       in the future.

   Extended security attributes
       The  security  attribute  namespace is used by kernel security modules,
       such as Security Enhanced Linux.  Read and write access permissions  to
       security  attributes depend on the policy implemented for each security
       attribute by the security module.  When no security module  is  loaded,
       all  processes  have  read  access to extended security attributes, and
       write access is limited to processes that have the CAP_SYS_ADMIN  capa‐
       bility.

   Extended system attributes
       Extended  system  attributes  are  used  by  the kernel to store system
       objects such as Access Control Lists and Capabilities.  Read and  write
       access  permissions  to  system  attributes depend on the policy imple‐
       mented for each system attribute implemented by filesystems in the ker‐
       nel.

   Trusted extended attributes
       Trusted  extended  attributes  are  visible and accessible only to pro‐
       cesses that have the CAP_SYS_ADMIN capability (the super  user  usually
       has  this  capability).  Attributes in this class are used to implement
       mechanisms in user space (i.e., outside the kernel) which keep informa‐
       tion in extended attributes to which ordinary processes should not have
       access.

   Extended user attributes
       Extended user attributes may be assigned to files and  directories  for
       storing arbitrary additional information such as the mime type, charac‐
       ter set or  encoding  of  a  file.  The  access  permissions  for  user
       attributes are defined by the file permission bits.

       The  file  permission  bits of regular files and directories are inter‐
       preted differently from the file permission bits of special  files  and
       symbolic  links.  For regular files and directories the file permission
       bits define access to the file's contents,  while  for  device  special
       files  they  define access to the device described by the special file.
       The file permissions of symbolic links are not used in  access  checks.
       These  differences would allow users to consume filesystem resources in
       a way not controllable by disk quotas for group or world writable  spe‐
       cial files and directories.

       For  this reason, extended user attributes are only allowed for regular
       files and directories,  and  access  to  extended  user  attributes  is
       restricted  to the owner and to users with appropriate capabilities for
       directories with the sticky bit set (see the chmod(1) manual  page  for
       an explanation of Sticky Directories).

FILESYSTEM DIFFERENCES
       The  kernel  and  the filesystem may place limits on the maximum number
       and size of extended attributes that can be  associated  with  a  file.
       Some  file systems, such as ext2/3 and reiserfs, require the filesystem
       to be mounted with the user_xattr mount option in  order  for  extended
       user attributes to be used.

       In  the  current  ext2,  ext3 and ext4 filesystem implementations, each
       extended attribute must fit on a single filesystem block (1024, 2048 or
       4096  bytes,  depending on the block size specified when the filesystem
       was created).

       In the XFS and reiserfs filesystem implementations, there is no practi‐
       cal  limit on the number or size of extended attributes associated with
       a file, and the algorithms used to store extended attribute information
       on disk are scalable.

       In  the JFS filesystem implementation, names can be up to 255 bytes and
       values up to 65,535 bytes.

ADDITIONAL NOTES
       Since the filesystems on which extended  attributes  are  stored  might
       also  be  used on architectures with a different byte order and machine
       word size, care should be taken to store attribute values in an  archi‐
       tecture independent format.

AUTHORS
       Andreas Gruenbacher, <a.gruenbacher@bestbits.at> and the SGI XFS devel‐
       opment team, <linux-xfs@oss.sgi.com>.

SEE ALSO
       getfattr(1), setfattr(1).



                                                                       ATTR(5)
