File: *manpages*,  Node: ldns-compare-zones,  Up: (dir)

ldns-compare-zones(1)       General Commands Manual      ldns-compare-zones(1)



NAME
       ldns-compare-zones  -  read and compare two zonefiles and print differ‐
       ences

SYNOPSIS
       ldns-compare-zones [-c] [-i] [-d] [-z] [-s] ZONEFILE1 ZONEFILE2

DESCRIPTION
       ldns-compare-zones reads two DNS zone files and prints number  of  dif‐
       ferences.
       Output is formated to:
               +NUM_INS        -NUM_DEL        ~NUM_CHG

       The  major  comparison  is based on the owner name. If an owner name is
       present in zonefile 1, but not in zonefile 2, the resource records with
       this  owner  name are considered deleted, and counted as NUM_DEL. If an
       owner name is present in  zonefile  2,  but  not  in  zonefile  1,  the
       resource  records  with  this  owner  name are considered inserted, and
       counted as NUM_INS. If an owner name is present in both, but there is a
       difference  in  the amount or content of the records, these are consid‐
       ered changed, and counted as NUM_CHG.

OPTIONS
       -c     Print resource records whose owner names are in both zone files,
              but with different resource records. (a.k.a. changed)

       -i     Print  resource  records  whose  owner names are present only in
              ZONEFILE2 (a.k.a. inserted)

       -d     Print resource records whose owner names  are  present  only  in
              ZONEFILE1 (a.k.a. deleted)

       -a     Print  all changes. Specifying this option is the same as speci‐
              fying -c -i amd -d.

       -z     Suppress zone sorting; this option is not  recommended;  it  can
              cause  records to be incorrectly marked as changed, depending of
              the nature of the changes.

       -s     Do not exclude the SOA record  from  the  comparison.   The  SOA
              record  may  then show up as changed due to a new serial number.
              Off by default since you may be interested  to  know  if  (other
              zone apex elements) have changed.

       -h     Show usage and exit

       -v     Show the version and exit

AUTHOR
       Written  by  Ondřej  Surý <ondrej@sury.org> for CZ.NIC, z.s.p.o. (czech
       domain registry)

REPORTING BUGS
       Report bugs to <ondrej@sury.org>.

COPYRIGHT
       Copyright (C) 2005 CZ.NIC, z.s.p.o.. This is free software. There is NO
       warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PUR‐
       POSE.



                                  17 Oct 2007            ldns-compare-zones(1)
