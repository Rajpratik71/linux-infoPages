File: libc.info,  Node: Setting Groups,  Next: Enable/Disable Setuid,  Prev: Setting User ID,  Up: Users and Groups

30.7 Setting the Group IDs
==========================

This section describes the functions for altering the group IDs (real
and effective) of a process.  To use these facilities, you must include
the header files 'sys/types.h' and 'unistd.h'.

 -- Function: int setegid (gid_t NEWGID)
     Preliminary: | MT-Safe | AS-Unsafe lock | AC-Unsafe lock | *Note
     POSIX Safety Concepts::.

     This function sets the effective group ID of the process to NEWGID,
     provided that the process is allowed to change its group ID. Just
     as with 'seteuid', if the process is privileged it may change its
     effective group ID to any value; if it isn't, but it has a file
     group ID, then it may change to its real group ID or file group ID;
     otherwise it may not change its effective group ID.

     Note that a process is only privileged if its effective _user_ ID
     is zero.  The effective group ID only affects access permissions.

     The return values and error conditions for 'setegid' are the same
     as those for 'seteuid'.

     This function is only present if '_POSIX_SAVED_IDS' is defined.

 -- Function: int setgid (gid_t NEWGID)
     Preliminary: | MT-Safe | AS-Unsafe lock | AC-Unsafe lock | *Note
     POSIX Safety Concepts::.

     This function sets both the real and effective group ID of the
     process to NEWGID, provided that the process is privileged.  It
     also deletes the file group ID, if any.

     If the process is not privileged, then 'setgid' behaves like
     'setegid'.

     The return values and error conditions for 'setgid' are the same as
     those for 'seteuid'.

 -- Function: int setregid (gid_t RGID, gid_t EGID)
     Preliminary: | MT-Safe | AS-Unsafe lock | AC-Unsafe lock | *Note
     POSIX Safety Concepts::.

     This function sets the real group ID of the process to RGID and the
     effective group ID to EGID.  If RGID is '-1', it means not to
     change the real group ID; likewise if EGID is '-1', it means not to
     change the effective group ID.

     The 'setregid' function is provided for compatibility with 4.3 BSD
     Unix, which does not support file IDs.  You can use this function
     to swap the effective and real group IDs of the process.
     (Privileged processes are not limited to this usage.)  If file IDs
     are supported, you should use that feature instead of using this
     function.  *Note Enable/Disable Setuid::.

     The return values and error conditions for 'setregid' are the same
     as those for 'setreuid'.

   'setuid' and 'setgid' behave differently depending on whether the
effective user ID at the time is zero.  If it is not zero, they behave
like 'seteuid' and 'setegid'.  If it is, they change both effective and
real IDs and delete the file ID. To avoid confusion, we recommend you
always use 'seteuid' and 'setegid' except when you know the effective
user ID is zero and your intent is to change the persona permanently.
This case is rare--most of the programs that need it, such as 'login'
and 'su', have already been written.

   Note that if your program is setuid to some user other than 'root',
there is no way to drop privileges permanently.

   The system also lets privileged processes change their supplementary
group IDs.  To use 'setgroups' or 'initgroups', your programs should
include the header file 'grp.h'.

 -- Function: int setgroups (size_t COUNT, const gid_t *GROUPS)
     Preliminary: | MT-Safe | AS-Unsafe lock | AC-Unsafe lock | *Note
     POSIX Safety Concepts::.

     This function sets the process's supplementary group IDs.  It can
     only be called from privileged processes.  The COUNT argument
     specifies the number of group IDs in the array GROUPS.

     This function returns '0' if successful and '-1' on error.  The
     following 'errno' error conditions are defined for this function:

     'EPERM'
          The calling process is not privileged.

 -- Function: int initgroups (const char *USER, gid_t GROUP)
     Preliminary: | MT-Safe locale | AS-Unsafe dlopen plugin heap lock |
     AC-Unsafe corrupt mem fd lock | *Note POSIX Safety Concepts::.

     The 'initgroups' function sets the process's supplementary group
     IDs to be the normal default for the user name USER.  The group
     GROUP is automatically included.

     This function works by scanning the group database for all the
     groups USER belongs to.  It then calls 'setgroups' with the list it
     has constructed.

     The return values and error conditions are the same as for
     'setgroups'.

   If you are interested in the groups a particular user belongs to, but
do not want to change the process's supplementary group IDs, you can use
'getgrouplist'.  To use 'getgrouplist', your programs should include the
header file 'grp.h'.

 -- Function: int getgrouplist (const char *USER, gid_t GROUP, gid_t
          *GROUPS, int *NGROUPS)
     Preliminary: | MT-Safe locale | AS-Unsafe dlopen plugin heap lock |
     AC-Unsafe corrupt mem fd lock | *Note POSIX Safety Concepts::.

     The 'getgrouplist' function scans the group database for all the
     groups USER belongs to.  Up to *NGROUPS group IDs corresponding to
     these groups are stored in the array GROUPS; the return value from
     the function is the number of group IDs actually stored.  If
     *NGROUPS is smaller than the total number of groups found, then
     'getgrouplist' returns a value of '-1' and stores the actual number
     of groups in *NGROUPS.  The group GROUP is automatically included
     in the list of groups returned by 'getgrouplist'.

     Here's how to use 'getgrouplist' to read all supplementary groups
     for USER:

          gid_t *
          supplementary_groups (char *user)
          {
            int ngroups = 16;
            gid_t *groups
              = (gid_t *) xmalloc (ngroups * sizeof (gid_t));
            struct passwd *pw = getpwnam (user);

            if (pw == NULL)
              return NULL;

            if (getgrouplist (pw->pw_name, pw->pw_gid, groups, &ngroups) < 0)
              {
                groups = xrealloc (ngroups * sizeof (gid_t));
                getgrouplist (pw->pw_name, pw->pw_gid, groups, &ngroups);
              }
            return groups;
          }

