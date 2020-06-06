File: *manpages*,  Node: swift-object-relinker,  Up: (dir)

SWIFT-OBJECT-RELINKER(1)    General Commands Manual   SWIFT-OBJECT-RELINKER(1)



NAME
       swift-object-relinker  -  relink and cleanup objects to increase parti‐
       tion power

SYNOPSIS
       swift-object-relinker [options] <command>


DESCRIPTION
       The relinker prepares an object server's  filesystem  for  a  partition
       power change by crawling the filesystem and linking existing objects to
       future partition directories.

       More information can be found at  https://docs.openstack.org/swift/lat‐
       est/ring_partpower.html


COMMANDS
       relink Relink files for partition power increase.


       cleanup
              Remove hard links in the old locations.


OPTIONS
       -h, --help
              Show this help message and exit


       --swift-dir SWIFT_DIR
              Path to swift directory


       --devices DEVICES
              Path to swift device directory


       --skip-mount-check
              Don't test if disk is mounted


       --logfile LOGFILE
              Set log file name


       --debug
              Enable debug mode


DOCUMENTATION
       More  in  depth  documentation  in regards to swift-object-relinker and
       also about OpenStack Swift as a whole can be found at http://docs.open‐
       stack.org/developer/swift/index.html and http://docs.openstack.org



OpenStack Swift                  December 2017        SWIFT-OBJECT-RELINKER(1)
