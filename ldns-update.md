File: *manpages*,  Node: ldns-update,  Up: (dir)

ldns-update(1)              General Commands Manual             ldns-update(1)



NAME
       ldns-update - send a dynamic update packet

SYNOPSIS
       ldns-update [ zone ] ip [ tsig_name tsig_als tsig_hmac ]


DESCRIPTION
       ldns-update is used to send a dynamic update packet.


OPTIONS
       zone   Use  this  zone instead of trying to read it from the zonefile's
              SOA record.


       ip     Send the update to this IP address


       tsig_name tsig_alg tsig_hmac
              Use TSIG (rfc2845) to authenticate.


EXAMPLE
       ldns-update my.example.org 1.2.3.4


AUTHOR
       Written by Jakob Schlyter and Håkan Olsson, as an addition to the  ldns
       library from NLnet Labs.


REPORTING BUGS
       Report bugs to <ldns-team@nlnetlabs.nl>.


COPYRIGHT
       Copyright  (C) 2005 NLnet Labs. This is free software. There is NO war‐
       ranty; not even for MERCHANTABILITY or FITNESS FOR  A  PARTICULAR  PUR‐
       POSE.



                                  30 May 2005                   ldns-update(1)
