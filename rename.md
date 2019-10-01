File: libc.info,  Node: Renaming Files,  Next: Creating Directories,  Prev: Deleting Files,  Up: File System Interface

14.7 Renaming Files
===================

The 'rename' function is used to change a file's name.

 -- Function: int rename (const char *OLDNAME, const char *NEWNAME)
     Preliminary: | MT-Safe | AS-Safe | AC-Safe | *Note POSIX Safety
     Concepts::.

     The 'rename' function renames the file OLDNAME to NEWNAME.  The
     file formerly accessible under the name OLDNAME is afterwards
     accessible as NEWNAME instead.  (If the file had any other names
     aside from OLDNAME, it continues to have those names.)

     The directory containing the name NEWNAME must be on the same file
     system as the directory containing the name OLDNAME.

     One special case for 'rename' is when OLDNAME and NEWNAME are two
     names for the same file.  The consistent way to handle this case is
     to delete OLDNAME.  However, in this case POSIX requires that
     'rename' do nothing and report success--which is inconsistent.  We
     don't know what your operating system will do.

     If OLDNAME is not a directory, then any existing file named NEWNAME
     is removed during the renaming operation.  However, if NEWNAME is
     the name of a directory, 'rename' fails in this case.

     If OLDNAME is a directory, then either NEWNAME must not exist or it
     must name a directory that is empty.  In the latter case, the
     existing directory named NEWNAME is deleted first.  The name
     NEWNAME must not specify a subdirectory of the directory 'oldname'
     which is being renamed.

     One useful feature of 'rename' is that the meaning of NEWNAME
     changes "atomically" from any previously existing file by that name
     to its new meaning (i.e., the file that was called OLDNAME).  There
     is no instant at which NEWNAME is non-existent "in between" the old
     meaning and the new meaning.  If there is a system crash during the
     operation, it is possible for both names to still exist; but
     NEWNAME will always be intact if it exists at all.

     If 'rename' fails, it returns '-1'.  In addition to the usual file
     name errors (*note File Name Errors::), the following 'errno' error
     conditions are defined for this function:

     'EACCES'
          One of the directories containing NEWNAME or OLDNAME refuses
          write permission; or NEWNAME and OLDNAME are directories and
          write permission is refused for one of them.

     'EBUSY'
          A directory named by OLDNAME or NEWNAME is being used by the
          system in a way that prevents the renaming from working.  This
          includes directories that are mount points for filesystems,
          and directories that are the current working directories of
          processes.

     'ENOTEMPTY'
     'EEXIST'
          The directory NEWNAME isn't empty.  GNU/Linux and GNU/Hurd
          systems always return 'ENOTEMPTY' for this, but some other
          systems return 'EEXIST'.

     'EINVAL'
          OLDNAME is a directory that contains NEWNAME.

     'EISDIR'
          NEWNAME is a directory but the OLDNAME isn't.

     'EMLINK'
          The parent directory of NEWNAME would have too many links
          (entries).

     'ENOENT'
          The file OLDNAME doesn't exist.

     'ENOSPC'
          The directory that would contain NEWNAME has no room for
          another entry, and there is no space left in the file system
          to expand it.

     'EROFS'
          The operation would involve writing to a directory on a
          read-only file system.

     'EXDEV'
          The two file names NEWNAME and OLDNAME are on different file
          systems.

