File: *manpages*,  Node: PKICertImport,  Up: (dir)

PKICertImport(1)          PKI certificate import tool         PKICertImport(1)



NAME
       PKICertImport  -  Used  to safely validate and import certificates into
       the NSS database.


SYNOPSIS
       Usage: PKICertImport -d <location of nssdb> -i  <location  of  certifi‐
       cate>  -n  <nickname for certificate> -t <trust flags> -u <usage flags>
       [-h <hardware token name>] [-f <password file>] [-a]

       Validate and import a certificate into the specified NSS database. Ver‐
       ifies  signature, trust chain, trust, and usage flags. If a certificate
       is not valid, it will not be added to the NSS DB or specified  hardware
       token.


DESCRIPTION
       The certificate import utility validates signature, trust chain, trust,
       and usage flags before importing a certificate into the  specified  NSS
       database.  This  ensures that no certificate is used before its authen‐
       ticity has been verified. Unlike certutil, only one invocation is  nec‐
       essary to both validate and import certificates.

       See  certutil  for  more information about the parameters to PKICertIm‐
       port.


OPTIONS
       PKICertImport parameters:

       --ascii, -a
              The certificate is encoded in  ASCII  (PEM)  format  instead  of
              binary format. Optional.


       --database, -d <location of NSS db>
              The  directory  containing the NSS database. This is usually the
              client's personal directory. Required.


       --password, -f <location of password file>
              The path to a file containing the password to the NSS  database.
              Optional.


       --hsm, -h <hardware token name>
              Name of the token. By default it takes 'internal'. Optional.


       --certificate, -i <location of certificate>
              Path to the certificate to import. Required.


       --nickname, -n <nickname for the certificate>
              Nickname for the certificate in the NSS DB. Required.


       --trust, -t <NSS trust flags>
              Trust  flags for the certificate. See certutil for more informa‐
              tion about the available trust flags. Required.


       --usage, -u <NSS usage flags>
              Usage to validate the certificate against. See certutil for more
              information about available usage flags. Required.


AUTHORS
       Alexander Scheel <ascheel@redhat.com>.


COPYRIGHT
       Copyright (c) 2019 Red Hat, Inc. This is licensed under the GNU General
       Public License, version 2 (GPLv2). A copy of this license is  available
       at http://www.gnu.org/licenses/old-licenses/gpl-2.0.txt.



version 10.6                     Jan 30, 2019                 PKICertImport(1)
