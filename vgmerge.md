File: *manpages*,  Node: vgmerge,  Up: (dir)

VGMERGE(8)                  System Manager's Manual                 VGMERGE(8)



NAME
       vgmerge — merge two volume groups

SYNOPSIS
       vgmerge    [-A|--autobackup   {y|n}]   [--commandprofile   ProfileName]
       [-d|--debug] [-h|-?|--help] [-l|--list] [-t|--test] [-v|--verbose] Des-
       tinationVolumeGroupName SourceVolumeGroupName

DESCRIPTION
       vgmerge  merges  two  existing  volume  groups. The inactive SourceVol-
       umeGroupName will be  merged  into  the  DestinationVolumeGroupName  if
       physical  extent  sizes  are equal and physical and logical volume sum-
       maries of both volume groups fit into DestinationVolumeGroupName's lim-
       its.

OPTIONS
       See lvm(8) for common options.

       -l, --list
              Display merged DestinationVolumeGroupName like vgdisplay -v.

       -t, --test
              Do a test run WITHOUT making any real changes.

Examples
       Merge  the inactive volume group named "my_vg" into the active or inac-
       tive volume group named "databases" giving verbose runtime information:

       vgmerge -v databases my_vg

SEE ALSO
       lvm(8), vgcreate(8), vgextend(8), vgreduce(8)



Sistina Software UK   LVM TOOLS 2.02.120(2) (2015-05-15)            VGMERGE(8)
