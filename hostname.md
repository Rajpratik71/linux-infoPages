File: *manpages*,  Node: hostname,  Up: (dir)

HOSTNAME(1)                Linux Programmer's Manual               HOSTNAME(1)



NAME
       hostname - show or set the system's host name
       domainname - show or set the system's NIS/YP domain name
       dnsdomainname - show the system's DNS domain name
       nodename - show or set the system's DECnet node name


SYNOPSIS
       hostname  [-v] [-a] [--alias] [-d] [--domain] [-f] [--fqdn] [-i] [--ip-
       address] [--long] [-s] [--short] [-y] [-n] [--node]


       hostname [-v] [-F filename] [--file filename] [hostname]


       domainname [-v] [-F filename] [--file filename] [name]


       nodename [-v] [-F filename] [--file filename] [name]


       hostname [-v] [-h] [--help] [-V] [--version]


       dnsdomainname [-v]


DESCRIPTION
       Hostname is the program that is used to either set or display the  cur-
       rent  host, domain or node name of the system.  These names are used by
       many of the networking programs to identify  the  machine.  The  domain
       name is also used by NIS/YP.


   GET NAME
       When  called  without  any  arguments, the program displays the current
       names:


       hostname will print the name of the system as returned by the  gethost-
       name(2) function.


       nodename  will  print the DECnet node name of the system as returned by
       the getnodename(2) function.


       dnsdomainname will print the domain part of the FQDN  (Fully  Qualified
       Domain Name). The complete FQDN of the system is returned with hostname
       --fqdn.


       The function gethostname(2) is used to get the hostname.  Only when the
       hostname  -s is called will gethostbyname(3) be called.  The difference
       in gethostname(2) and gethostbyname(3) is that gethostbyname(3) is net-
       work  aware,  so  it  consults /etc/nsswitch.conf and /etc/host.conf to
       decide  whether  to  read  information  in  /etc/sysconfig/network   or
       /etc/hosts  the  hostname  is  also  set  when the network interface is
       brought up.


   SET NAME
       When called with one argument or with the --file option,  the  commands
       set the host name, the NIS/YP domain name or the node name.


       Note, that only the super-user can change the names.


       It is not possible to set the FQDN or the DNS domain name with the dns-
       domainname command (see THE FQDN below).


       The  host  name  is   usually   set   once   at   system   startup   in
       /etc/rc.d/rc.inet1  or  /etc/init.d/boot  (normally by reading the con-
       tents of a file which contains the host name, e.g.  /etc/hostname).


   THE FQDN
       You can't change the FQDN (as returned by hostname --fqdn) or  the  DNS
       domain  name (as returned by dnsdomainname) with this command. The FQDN
       of the system is the name that the resolver(3)  returns  for  the  host
       name.


       Technically: The FQDN is the name gethostbyname(2) returns for the host
       name returned by gethostname(2).  The DNS domain name is the part after
       the first dot.

       Therefore  it  depends on the configuration (usually in /etc/host.conf)
       how you can change it. Usually (if the hosts file is parsed before  DNS
       or NIS) you can change it in /etc/hosts.



OPTIONS
       -a, --alias
              Display the alias name of the host (if used).

       -d, --domain
              Display  the  name  of  the  DNS  domain.  Don't use the command
              domainname to get the DNS domain name because it will  show  the
              NIS  domain  name and not the DNS domain name. Use dnsdomainname
              instead.

       -F, --file filename
              Read the host name from  the  specified  file.  Comments  (lines
              starting with a `#') are ignored.

       -f, --fqdn, --long
              Display  the FQDN (Fully Qualified Domain Name). A FQDN consists
              of a short host name and the DNS domain  name.  Unless  you  are
              using  bind  or NIS for host lookups you can change the FQDN and
              the DNS  domain  name  (which  is  part  of  the  FQDN)  in  the
              /etc/hosts file.

       -h, --help
              Print a usage message and exit.

       -i, --ip-address
              Display the IP address(es) of the host.

       -n, --node
              Display the DECnet node name. If a parameter is given (or --file
              name ) the root can also set a new node name.

       -s, --short
              Display the short host name. This is the host name  cut  at  the
              first dot.

       -V, --version
              Print  version  information on standard output and exit success-
              fully.

       -v, --verbose
              Be verbose and tell what's going on.

FILES
       /etc/hosts

AUTHOR
       Peter Tobias, <tobias@et-inf.fho-emden.de>
       Bernd Eckenfels, <net-tools@lina.inka.de> (NIS and manpage).
       Steve Whitehouse, <SteveW@ACM.org> (DECnet support and manpage).




net-tools                         28 Jan 1996                      HOSTNAME(1)
HOSTNAME(5)                        hostname                        HOSTNAME(5)



NAME
       hostname - Local hostname configuration file

SYNOPSIS
       /etc/hostname

DESCRIPTION
       The /etc/hostname file configures the name of the local system that is
       set during boot using the sethostname(2) system call. It should contain
       a single newline-terminated hostname string. Comments (lines starting
       with a `#') are ignored. The hostname may be a free-form string up to
       64 characters in length; however, it is recommended that it consists
       only of 7-bit ASCII lower-case characters and no spaces or dots, and
       limits itself to the format allowed for DNS domain name labels, even
       though this is not a strict requirement.

       Depending on the operating system, other configuration files might be
       checked for configuration of the hostname as well, however only as
       fallback.

       You may use hostnamectl(1) to change the value of this file during
       runtime from the command line. Use systemd-firstboot(1) to initialize
       it on mounted (but not booted) system images.

HISTORY
       The simple configuration file format of /etc/hostname originates from
       Debian GNU/Linux.

SEE ALSO
       systemd(1), sethostname(2), hostname(1), hostname(7), machine-id(5),
       machine-info(5), hostnamectl(1), systemd-hostnamed.service(8), systemd-
       firstboot(1)



systemd 228                                                        HOSTNAME(5)
HOSTNAME(7)                Linux Programmer's Manual               HOSTNAME(7)



NAME
       hostname - hostname resolution description

DESCRIPTION
       Hostnames  are domains, where a domain is a hierarchical, dot-separated
       list of subdomains; for example, the machine  monet,  in  the  Berkeley
       subdomain  of  the  EDU  domain  would  be represented as "monet.Berke-
       ley.EDU".

       Hostnames are often used with network client and server programs, which
       must generally translate the name to an address for use.  (This task is
       generally performed by either getaddrinfo(3) or the obsolete gethostby-
       name(3).)   Hostnames are resolved by the Internet name resolver in the
       following fashion.

       If the name consists of a single component, that is, contains  no  dot,
       and  if  the  environment  variable HOSTALIASES is set to the name of a
       file, that file is searched for any string matching the input hostname.
       The  file  should consist of lines made up of two white-space separated
       strings, the first of which is the hostname alias, and  the  second  of
       which  is the complete hostname to be substituted for that alias.  If a
       case-insensitive match is found between the hostname to be resolved and
       the  first  field of a line in the file, the substituted name is looked
       up with no further processing.

       If the input name ends  with  a  trailing  dot,  the  trailing  dot  is
       removed,  and  the remaining name is looked up with no further process-
       ing.

       If the input name does not end with a trailing dot, it is looked up  by
       searching  through  a  list  of  domains  until  a match is found.  The
       default search list includes first the local domain,  then  its  parent
       domains  with at least 2 name components (longest first).  For example,
       in the domain CS.Berkeley.EDU, the name lithium.CChem will  be  checked
       first as lithium.CChem.CS.Berkeley.EDU and then as lithium.CChem.Berke-
       ley.EDU.  Lithium.CChem.EDU will not be tried, as  there  is  only  one
       component  remaining  from  the  local  domain.  The search path can be
       changed from the default  by  a  system-wide  configuration  file  (see
       resolver(5)).

SEE ALSO
       gethostbyname(3), resolver(5), mailaddr(7), named(8)

COLOPHON
       This  page  is  part of release 4.02 of the Linux man-pages project.  A
       description of the project, information about reporting bugs,  and  the
       latest     version     of     this    page,    can    be    found    at
       http://www.kernel.org/doc/man-pages/.



Linux                             2010-11-07                       HOSTNAME(7)
