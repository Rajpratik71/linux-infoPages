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
       attribute  manipulation,  consult the getfattr(1) and setfattr(1) docu-
       mentation.

       Extended attributes can be used to  store  meta-information  about  the
       file.   For example "character-set=kanji" could tell a document browser
       to use the Kanji  character  set  when  displaying  that  document  and
       "thumbnail=..."  could  provide a reduced resolution overview of a high
       resolution graphic image.

       In the XFS filesystem, the names can be up to 256 bytes in length, ter-
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
       user  address  space is protected by the normal file permissions mecha-
       nism, so the owner of the file can decide who is  able  to  see  and/or
       modify the value of attributes on any particular file.

DESCRIPTION
       The attr utility allows the manipulation of extended attributes associ-
       ated with filesystem objects from within shell scripts.

       There are four main operations that attr can perform:

       GET    The -g attrname option tells attr to search the named object and
              print (to stdout) the value associated with that attribute name.
              With the -q flag, stdout will be exactly and only the  value  of
              the attribute, suitable for storage directly into a file or pro-
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

       When the -q option is given attr will try to keep quiet.  It will  out-
       put  error  messages (to stderr) but will not print status messages (to
       stdout).

NOTES
       The standard file interchange/archive programs tar(1), and cpio(1) will
       not  archive  or restore extended attributes, while the xfsdump(8) pro-
       gram will.

CAVEATS
       The list option present in the IRIX version of this command is not sup-
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

       Space consumed for extended attributes is counted towards the disk quo-
       tas of the file owner and file group.

       Currently, support for extended attributes is implemented on  Linux  by
       the ext2, ext3, ext4, XFS, JFS and reiserfs filesystems.

EXTENDED ATTRIBUTE NAMESPACES
       Attribute  names  are  zero-terminated  strings.  The attribute name is
       always specified in the fully qualified namespace.attribute  form,  eg.
       user.mime_type,   trusted.md5sum,   system.posix_acl_access,  or  secu-
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
       write access is limited to processes that have the CAP_SYS_ADMIN  capa-
       bility.

   Extended system attributes
       Extended  system  attributes  are  used  by  the kernel to store system
       objects such as Access Control Lists and Capabilities.  Read and  write
       access  permissions  to  system  attributes depend on the policy imple-
       mented for each system attribute implemented by filesystems in the ker-
       nel.

   Trusted extended attributes
       Trusted  extended  attributes  are  visible and accessible only to pro-
       cesses that have the CAP_SYS_ADMIN capability (the super  user  usually
       has  this  capability).  Attributes in this class are used to implement
       mechanisms in user space (i.e., outside the kernel) which keep informa-
       tion in extended attributes to which ordinary processes should not have
       access.

   Extended user attributes
       Extended user attributes may be assigned to files and  directories  for
       storing arbitrary additional information such as the mime type, charac-
       ter set or  encoding  of  a  file.  The  access  permissions  for  user
       attributes are defined by the file permission bits.

       The  file  permission  bits of regular files and directories are inter-
       preted differently from the file permission bits of special  files  and
       symbolic  links.  For regular files and directories the file permission
       bits define access to the file's contents,  while  for  device  special
       files  they  define access to the device described by the special file.
       The file permissions of symbolic links are not used in  access  checks.
       These  differences would allow users to consume filesystem resources in
       a way not controllable by disk quotas for group or world writable  spe-
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

       In the XFS and reiserfs filesystem implementations, there is no practi-
       cal  limit on the number or size of extended attributes associated with
       a file, and the algorithms used to store extended attribute information
       on disk are scalable.

       In  the JFS filesystem implementation, names can be up to 255 bytes and
       values up to 65,535 bytes.

ADDITIONAL NOTES
       Since the filesystems on which extended  attributes  are  stored  might
       also  be  used on architectures with a different byte order and machine
       word size, care should be taken to store attribute values in an  archi-
       tecture independent format.

AUTHORS
       Andreas Gruenbacher, <a.gruenbacher@bestbits.at> and the SGI XFS devel-
       opment team, <linux-xfs@oss.sgi.com>.

SEE ALSO
       getfattr(1), setfattr(1).



                                                                       ATTR(5)
XATTR(7)                   Linux Programmer's Manual                  XATTR(7)



NAME
       attr - Extended attributes

DESCRIPTION
       Extended  attributes  are  name:value pairs associated permanently with
       files and directories, similar to the  environment  strings  associated
       with  a  process.   An attribute may be defined or undefined.  If it is
       defined, its value may be empty or non-empty.

       Extended attributes are extensions to the normal attributes  which  are
       associated  with  all  inodes  in  the system (i.e., the stat(2) data).
       They are often used to provide additional functionality to  a  filesys-
       tem—for  example,  additional  security features such as Access Control
       Lists (ACLs) may be implemented using extended attributes.

       Users with search access to a file or directory may use listxattr(2) to
       retrieve a list of attribute names defined for that file or directory.

       Extended  attributes  are  accessed  as atomic objects.  Reading (getx-
       attr(2)) retrieves the whole value of an attribute and stores it  in  a
       buffer.  Writing (setxattr(2)) replaces any previous value with the new
       value.

       Space consumed for extended attributes may be counted towards the  disk
       quotas of the file owner and file group.

   Extended attribute namespaces
       Attribute  names  are  null-terminated  strings.  The attribute name is
       always specified in the fully qualified namespace.attribute  form,  for
       example,  user.mime_type,  trusted.md5sum,  system.posix_acl_access, or
       security.selinux.

       The namespace mechanism is used to define different classes of extended
       attributes.   These  different  classes  exist for several reasons; for
       example, the permissions and  capabilities  required  for  manipulating
       extended attributes of one namespace may differ to another.

       Currently,  the  security, system, trusted, and user extended attribute
       classes are defined as described  below.   Additional  classes  may  be
       added in the future.

   Extended security attributes
       The  security  attribute  namespace is used by kernel security modules,
       such as Security Enhanced Linux, and also to implement  file  capabili-
       ties (see capabilities(7)).  Read and write access permissions to secu-
       rity attributes depend on the  policy  implemented  for  each  security
       attribute  by  the security module.  When no security module is loaded,
       all processes have read access to  extended  security  attributes,  and
       write  access is limited to processes that have the CAP_SYS_ADMIN capa-
       bility.

   Extended system attributes
       Extended system attributes are used  by  the  kernel  to  store  system
       objects  such  as  Access Control Lists.  Read and write access permis-
       sions to system attributes depend on the policy  implemented  for  each
       system attribute implemented by filesystems in the kernel.

   Trusted extended attributes
       Trusted  extended  attributes  are  visible and accessible only to pro-
       cesses that have the  CAP_SYS_ADMIN  capability.   Attributes  in  this
       class are used to implement mechanisms in user space (i.e., outside the
       kernel) which keep information in extended attributes to which ordinary
       processes should not have access.

   Extended user attributes
       Extended  user  attributes may be assigned to files and directories for
       storing arbitrary additional information such as the mime type, charac-
       ter  set  or  encoding  of  a  file.   The  access permissions for user
       attributes are defined by the file permission bits: read permission  is
       required  to  retrieve  the  attribute  value, and writer permission is
       required to change it.

       The file permission bits of regular files and  directories  are  inter-
       preted  differently  from the file permission bits of special files and
       symbolic links.  For regular files and directories the file  permission
       bits  define  access  to  the file's contents, while for device special
       files they define access to the device described by the  special  file.
       The  file  permissions of symbolic links are not used in access checks.
       These differences would allow users to consume filesystem resources  in
       a  way not controllable by disk quotas for group or world writable spe-
       cial files and directories.

       For this reason, extended user attributes are allowed only for  regular
       files  and  directories,  and  access  to  extended  user attributes is
       restricted to the owner and to users with appropriate capabilities  for
       directories  with  the sticky bit set (see the chmod(1) manual page for
       an explanation of the sticky bit).

   Filesystem differences
       The kernel and the filesystem may place limits on  the  maximum  number
       and  size  of  extended  attributes that can be associated with a file.
       The VFS imposes limitations that an attribute names is limited  to  255
       bytes  and  an  attribute  value  is  limited  to  64  kB.  The list of
       attribute names that can be returned is also limited to 64 kB (see BUGS
       in listxattr(2)).

       Some  filesystems, such as Reiserfs (and, historically, ext2 and ext3),
       require the filesystem to be mounted with the user_xattr  mount  option
       in order for extended user attributes to be used.

       In  the  current  ext2,  ext3, and ext4 filesystem implementations, the
       total bytes used by the names and values of all  of  a  files  extended
       attributes  must  fit  in a single filesystem block (1024, 2048 or 4096
       bytes, depending on the block size specified when  the  filesystem  was
       created).

       In the Btrfs, XFS, and Reiserfs filesystem implementations, there is no
       practical limit on the number of extended attributes associated with  a
       file,  and  the algorithms used to store extended attribute information
       on disk are scalable.

       In the JFS, XFS, and Reiserfs filesystem implementations, the limit  on
       bytes used in an EA value is the ceiling imposed by the VFS.

       In  the  Btrfs  filesystem implementation, the total bytes used for the
       name, value, and  implementation  overhead  bytes  is  limited  to  the
       filesystem nodesize value (16 kB by default).

CONFORMING TO
       Extended  attributes  are not specified in POSIX.1, but some other sys-
       tems (e.g., the BSDs and Solaris) provide a similar feature.

NOTES
       Since the filesystems on which extended  attributes  are  stored  might
       also  be  used on architectures with a different byte order and machine
       word size, care should be taken to store attribute values in an  archi-
       tecture-independent format.

       This page was formerly named attr(5).

SEE ALSO
       getfattr(1),  setfattr(1),  getxattr(2),  listxattr(2), removexattr(2),
       setxattr(2), acl(5), capabilities(7)

COLOPHON
       This page is part of release 4.02 of the Linux  man-pages  project.   A
       description  of  the project, information about reporting bugs, and the
       latest    version    of    this    page,    can     be     found     at
       http://www.kernel.org/doc/man-pages/.



Linux                             2015-05-01                          XATTR(7)
attr(3NCURSES)                                                  attr(3NCURSES)



NAME
       attroff, wattroff, attron, wattron, attrset, wattrset, color_set,
       wcolor_set, standend, wstandend, standout, wstandout, attr_get,
       wattr_get, attr_off, wattr_off, attr_on, wattr_on, attr_set, wattr_set,
       chgat, wchgat, mvchgat, mvwchgat, PAIR_NUMBER - curses character and
       window attribute control routines

SYNOPSIS
       #include <ncurses/curses.h>
       int attroff(int attrs);
       int wattroff(WINDOW *win, int attrs);
       int attron(int attrs);
       int wattron(WINDOW *win, int attrs);
       int attrset(int attrs);
       int wattrset(WINDOW *win, int attrs);
       int color_set(short color_pair_number, void* opts);
       int wcolor_set(WINDOW *win, short color_pair_number,
             void* opts);
       int standend(void);
       int wstandend(WINDOW *win);
       int standout(void);
       int wstandout(WINDOW *win);
       int attr_get(attr_t *attrs, short *pair, void *opts);
       int wattr_get(WINDOW *win, attr_t *attrs, short *pair,
              void *opts);
       int attr_off(attr_t attrs, void *opts);
       int wattr_off(WINDOW *win, attr_t attrs, void *opts);
       int attr_on(attr_t attrs, void *opts);
       int wattr_on(WINDOW *win, attr_t attrs, void *opts);
       int attr_set(attr_t attrs, short pair, void *opts);
       int wattr_set(WINDOW *win, attr_t attrs, short pair, void *opts);
       int chgat(int n, attr_t attr, short color,
             const void *opts)
       int wchgat(WINDOW *win, int n, attr_t attr,
             short color, const void *opts)
       int mvchgat(int y, int x, int n, attr_t attr,
             short color, const void *opts)
       int mvwchgat(WINDOW *win, int y, int x, int n,
             attr_t attr, short color, const void *opts)

DESCRIPTION
       These  routines  manipulate the current attributes of the named window.
       The current attributes of a window apply to  all  characters  that  are
       written  into  the window with waddch, waddstr and wprintw.  Attributes
       are a property of the character, and move with  the  character  through
       any  scrolling and insert/delete line/character operations.  To the ex-
       tent possible, they are displayed as appropriate modifications  to  the
       graphic rendition of characters put on the screen.

       The  routine attrset sets the current attributes of the given window to
       attrs.  The routine attroff turns  off  the  named  attributes  without
       turning  any  other  attributes on or off.  The routine attron turns on
       the named attributes without affecting any others.  The routine  stand-
       out  is  the  same  as attron(A_STANDOUT).  The routine standend is the
       same as attrset(A_NORMAL) or attrset(0), that is, it turns off all  at-
       tributes.

       The attrset and related routines do not affect the attributes used when
       erasing portions of the window.  See bkgd(3NCURSES) for functions which
       modify the attributes used for erasing and clearing.

       The routine color_set sets the current color of the given window to the
       foreground/background combination described by  the  color_pair_number.
       The parameter opts is reserved for future use, applications must supply
       a null pointer.

       The routine wattr_get returns the current attribute and color pair  for
       the given window; attr_get returns the current attribute and color pair
       for stdscr.  The remaining attr_* functions operate  exactly  like  the
       corresponding  attr* functions, except that they take arguments of type
       attr_t rather than int.

       The routine chgat changes the attributes of a given number  of  charac-
       ters  starting  at  the current cursor location of stdscr.  It does not
       update the cursor and does not perform wrapping.  A character count  of
       -1  or  greater  than  the  remaining  window width means to change at-
       tributes all the way to the end of the current line.  The wchgat  func-
       tion  generalizes this to any window; the mvwchgat function does a cur-
       sor move before acting.  In these functions, the color  argument  is  a
       color-pair  index  (as  in  the  first  argument of init_pair, see col-
       or(3NCURSES)).  The opts argument is not presently  used,  but  is  re-
       served for the future (leave it NULL).

   Attributes
       The following video attributes, defined in <curses.h>, can be passed to
       the routines attron, attroff, and attrset, or OR'd with the  characters
       passed to addch.

              Name            Description
              ────────────────────────────────────────────────────────────
              A_NORMAL        Normal display (no highlight)
              A_STANDOUT      Best highlighting mode of the terminal.
              A_UNDERLINE     Underlining
              A_REVERSE       Reverse video
              A_BLINK         Blinking
              A_DIM           Half bright
              A_BOLD          Extra bright or bold
              A_PROTECT       Protected mode
              A_INVIS         Invisible or blank mode
              A_ALTCHARSET    Alternate character set
              A_ITALIC        Italics (non-X/Open extension)
              A_CHARTEXT      Bit-mask to extract a character
              COLOR_PAIR(n)   Color-pair number n

       These  video  attributes are supported by attr_on and related functions
       (which also support the attributes recognized by attron, etc.):

              Name            Description
              ─────────────────────────────────────────
              WA_HORIZONTAL   Horizontal highlight
              WA_LEFT         Left highlight
              WA_LOW          Low highlight
              WA_RIGHT        Right highlight
              WA_TOP          Top highlight
              WA_VERTICAL     Vertical highlight

       For consistency

       The following macro is the reverse of COLOR_PAIR(n):

       PAIR_NUMBER(attrs) Returns the pair number associated
                          with the COLOR_PAIR(n) attribute.

       The return values of many of these routines are  not  meaningful  (they
       are  implemented  as macro-expanded assignments and simply return their
       argument).  The SVr4 manual page claims (falsely) that  these  routines
       always return 1.

NOTES
       Note  that  attroff,  wattroff,  attron,  wattron,  attrset,  wattrset,
       standend and standout may be macros.

       COLOR_PAIR values can only be OR'd with attributes if the  pair  number
       is less than 256.  The alternate functions such as color_set can pass a
       color pair value directly.  However, ncurses ABI 4 and 5 simply OR this
       value  within  the  alternate functions.  You must use ncurses ABI 6 to
       support more than 256 color pairs.

PORTABILITY
       These functions are supported in the XSI Curses standard, Issue 4.  The
       standard  defined  the  dedicated type for highlights, attr_t, which is
       not defined in SVr4 curses. The functions taking attr_t  arguments  are
       not supported under SVr4.

       The  XSI  Curses standard states that whether the traditional functions
       attron/attroff/attrset can manipulate attributes  other  than  A_BLINK,
       A_BOLD,  A_DIM, A_REVERSE, A_STANDOUT, or A_UNDERLINE is "unspecified".
       Under this implementation as well as SVr4 curses, these functions  cor-
       rectly  manipulate  all  other  highlights (specifically, A_ALTCHARSET,
       A_PROTECT, and A_INVIS).

       This implementation provides the A_ITALIC attribute for terminals which
       have  the  enter_italics_mode (sitm) and exit_italics_mode (ritm) capa-
       bilities.  Italics are not mentioned in X/Open Curses.  Unlike the oth-
       er  video attributes, I_ITALIC is unrelated to the set_attributes capa-
       bilities.  This  implementation  makes  the  assumption  that  exit_at-
       tribute_mode may also reset italics.

       XSI Curses added the new entry points, attr_get, attr_on, attr_off, at-
       tr_set, wattr_on, wattr_off, wattr_get, wattr_set.  These are  intended
       to  work  with a new series of highlight macros prefixed with WA_.  The
       older macros have direct counterparts in the newer set of names:

              Name            Description
              ────────────────────────────────────────────────────────────
              WA_NORMAL       Normal display (no highlight)
              WA_STANDOUT     Best highlighting mode of the terminal.
              WA_UNDERLINE    Underlining
              WA_REVERSE      Reverse video
              WA_BLINK        Blinking
              WA_DIM          Half bright
              WA_BOLD         Extra bright or bold
              WA_ALTCHARSET   Alternate character set

       Older versions of this library did not force an update  of  the  screen
       when  changing  the  attributes.   Use  touchwin to force the screen to
       match the updated attributes.

       The XSI curses standard specifies that each pair  of  corresponding  A_
       and WA_-using functions operates on the same current-highlight informa-
       tion.

       The XSI standard extended conformance level adds new highlights A_HORI-
       ZONTAL,  A_LEFT,  A_LOW,  A_RIGHT, A_TOP, A_VERTICAL (and corresponding
       WA_ macros for each).  As of August 2013, no  known  terminal  provides
       these highlights (i.e., via the sgr1 capability).

RETURN VALUE
       All routines return the integer OK on success, or ERR on failure.

       X/Open does not define any error conditions.

       This  implementation  returns  an  error if the window pointer is null.
       The wcolor_set function returns an error if the color pair parameter is
       outside  the range 0..COLOR_PAIRS-1.  This implementation also provides
       getattrs for compatibility with older versions of curses.

       Functions with a "mv" prefix first  perform  a  cursor  movement  using
       wmove, and return an error if the position is outside the window, or if
       the window pointer is null.

SEE ALSO
       ncurses(3NCURSES), addch(3NCURSES),  addstr(3NCURSES),  bkgd(3NCURSES),
       printw(3NCURSES), curses_variables(3NCURSES)



                                                                attr(3NCURSES)
