Next: Invoking xargs,  Prev: Invoking locate,  Up: Reference

8.3 Invoking 'updatedb'
=======================

     updatedb [OPTION...]

   'updatedb' creates and updates the database of file names used by
'locate'.  'updatedb' generates a list of files similar to the output of
'find' and then uses utilities for optimizing the database for
performance.  'updatedb' is often run periodically as a 'cron' job and
configured with environment variables or command options.  Typically,
operating systems have a shell script that "exports" configurations for
variable definitions and uses another shell script that "sources" the
configuration file into the environment and then executes 'updatedb' in
the environment.

'--findoptions='OPTION...''
     Global options to pass on to 'find'.  The environment variable
     'FINDOPTIONS' also sets this value.  Default is none.

'--localpaths='PATH...''
     Non-network directories to put in the database.  Default is '/'.

'--netpaths='PATH...''
     Network (NFS, AFS, RFS, etc.)  directories to put in the database.
     The environment variable 'NETPATHS' also sets this value.  Default
     is none.

'--prunepaths='PATH...''
     Directories to omit from the database, which would otherwise be
     included.  The environment variable 'PRUNEPATHS' also sets this
     value.  Default is '/tmp /usr/tmp /var/tmp /afs'.  The paths are
     used as regular expressions (with 'find ... -regex', so you need to
     specify these paths in the same way that 'find' will encounter
     them.  This means for example that the paths must not include
     trailing slashes.

'--prunefs='PATH...''
     Filesystems to omit from the database, which would otherwise be
     included.  Note that files are pruned when a filesystem is reached;
     Any filesystem mounted under an undesired filesystem will be
     ignored.  The environment variable 'PRUNEFS' also sets this value.
     Default is 'nfs NFS proc'.

'--output=DBFILE'
     The database file to build.  The default is system-dependent, but
     when this document was formatted it was
     '/var/cache/locate/locatedb'.

'--localuser=USER'
     The user to search the non-network directories as, using 'su'.
     Default is to search the non-network directories as the current
     user.  You can also use the environment variable 'LOCALUSER' to set
     this user.

'--netuser=USER'
     The user to search network directories as, using 'su'.  Default
     'user' is 'daemon'.  You can also use the environment variable
     'NETUSER' to set this user.

'--dbformat=FORMAT'
     Generate the locate database in format 'FORMAT'.  Supported
     database formats include 'LOCATE02' (which is the default) and
     'slocate'.  The 'slocate' format exists for compatibility with
     'slocate'.  *Note Database Formats::, for a detailed description of
     each format.

'--help'
     Print a summary of the command line usage and exit.
'--version'
     Print the version number of 'updatedb' and exit.

