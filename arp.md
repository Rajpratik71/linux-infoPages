ARP(8)                                                                               Linux System Administrator's Manual                                                                               ARP(8)

NAME
       arp - manipulate the system ARP cache

SYNOPSIS
       arp [-vn] [-H type] [-i if] [-ae] [hostname]

       arp [-v] [-i if] -d hostname [pub]

       arp [-v] [-H type] [-i if] -s hostname hw_addr [temp]

       arp [-v] [-H type] [-i if] -s hostname hw_addr [netmask nm] pub

       arp [-v] [-H type] [-i if] -Ds hostname ifname [netmask nm] pub

       arp [-vnD] [-H type] [-i if] -f [filename]

DESCRIPTION
       Arp manipulates or displays the kernel's IPv4 network neighbour cache. It can add entries to the table, delete one or display the current content.

       ARP stands for Address Resolution Protocol, which is used to find the media access control address of a network neighbour for a given IPv4 Address.

MODES
       arp with no mode specifier will print the current content of the table. It is possible to limit the number of entries printed, by specifying an hardware address type, interface name or host address.

       arp  -d  address will delete a ARP table entry. Root or netadmin privilege is required to do this. The entry is found by IP address. If a hostname is given, it will be resolved before looking up the
       entry in the ARP table.

       arp -s address hw_addr is used to set up a new table entry. The format of the hw_addr parameter is dependent on the hardware class, but for most classes one can assume that  the  usual  presentation
       can be used.  For the Ethernet class, this is 6 bytes in hexadecimal, separated by colons. When adding proxy arp entries (that is those with the publish flag set) a netmask may be specified to proxy
       arp for entire subnets. This is not good practice, but is supported by older kernels because it can be useful. If the temp flag is not supplied entries will be permanent stored into the  ARP  cache.
       To  simplify  setting up entries for one of your own network interfaces, you can use the arp -Ds address ifname form. In that case the hardware address is taken from the interface with the specified
       name.

OPTIONS
       -v, --verbose
              Tell the user what is going on by being verbose.

       -n, --numeric
              shows numerical addresses instead of trying to determine symbolic host, port or user names.

       -H type, --hw-type type, -t type
              When setting or reading the ARP cache, this optional parameter tells arp which class of entries it should check for.  The default value of this parameter is ether (i.e. hardware code 0x01 for
              IEEE 802.3 10Mbps Ethernet).  Other values might include network technologies such as ARCnet (arcnet) , PROnet (pronet) , AX.25 (ax25) and NET/ROM (netrom).

       -a     Use alternate BSD style output format (with no fixed columns).

       -e     Use default Linux style output format (with fixed columns).

       -D, --use-device
              Instead  of  a  hw_addr, the given argument is the name of an interface.  arp will use the MAC address of that interface for the table entry. This is usually the best option to set up a proxy
              ARP entry to yourself.

       -i If, --device If
              Select an interface. When dumping the ARP cache only entries matching the specified interface will be printed. When setting a permanent or temp ARP entry this  interface  will  be  associated
              with the entry; if this option is not used, the kernel will guess based on the routing table. For pub entries the specified interface is the interface on which ARP requests will be answered.
              NOTE:  This has to be different from the interface to which the IP datagrams will be routed.  NOTE: As of kernel 2.2.0 it is no longer possible to set an ARP entry for an entire subnet. Linux
              instead does automagic proxy arp when a route exists and it is forwarding. See arp(7) for details. Also the dontpub option which is available for delete and set operations cannot be used with
              2.4 and newer kernels.

       -f filename, --file filename
              Similar  to  the  -s  option, only this time the address info is taken from file filename.  This can be used if ARP entries for a lot of hosts have to be set up.  The name of the data file is
              very often /etc/ethers, but this is not official. If no filename is specified /etc/ethers is used as default.

              The format of the file is simple; it only contains ASCII text lines with a hostname, and a hardware address separated by whitespace. Additionally the pub, temp and netmask flags can be used.

       In all places where a hostname is expected, one can also enter an IP address in dotted-decimal notation.

       As a special case for compatibility the order of the hostname and the hardware address can be exchanged.

       Each complete entry in the ARP cache will be marked with the C flag. Permanent entries are marked with M and published entries have the P flag.

EXAMPLES
       /usr/sbin/arp -i eth0 -Ds 10.0.0.2 eth1 pub

       This will answer ARP requests for 10.0.0.2 on eth0 with the MAC address for eth1.

       /usr/sbin/arp -i eth1 -d 10.0.0.1

       Delete the ARP table entry for 10.0.0.1 on interface eth1. This will match published proxy ARP entries and permanent entries.

FILES
       /proc/net/arp
       /etc/networks
       /etc/hosts
       /etc/ethers

SEE ALSO
       rarp(8), route(8), ifconfig(8), netstat(8)

AUTHORS
       Fred N. van Kempen <waltje@uwalt.nl.mugnet.org>, Bernd Eckenfels <net-tools@lina.inka.de>.

net-tools                                                                                         2008-10-03                                                                                           ARP(8)
ARP(7)                                                                                    Linux Programmer's Manual                                                                                    ARP(7)

NAME
       arp - Linux ARP kernel module.

DESCRIPTION
       This  kernel protocol module implements the Address Resolution Protocol defined in RFC 826.  It is used to convert between Layer2 hardware addresses and IPv4 protocol addresses on directly connected
       networks.  The user normally doesn't interact directly with this module except to configure it; instead it provides a service for other protocols in the kernel.

       A user process can receive ARP packets by using packet(7) sockets.  There is also a mechanism for managing the ARP cache in user-space by using netlink(7) sockets.  The ARP table can  also  be  con‐
       trolled via ioctl(2) on any AF_INET socket.

       The  ARP module maintains a cache of mappings between hardware addresses and protocol addresses.  The cache has a limited size so old and less frequently used entries are garbage-collected.  Entries
       which are marked as permanent are never deleted by the garbage-collector.  The cache can be directly manipulated by the use of ioctls and its behavior can be tuned by the /proc interfaces  described
       below.

       When  there  is  no  positive  feedback  for an existing mapping after some time (see the /proc interfaces below), a neighbor cache entry is considered stale.  Positive feedback can be gotten from a
       higher layer; for example from a successful TCP ACK.  Other protocols can signal forward progress using the MSG_CONFIRM flag to sendmsg(2).  When there is no forward progress, ARP tries to  reprobe.
       It  first  tries  to  ask a local arp daemon app_solicit times for an updated MAC address.  If that fails and an old MAC address is known, a unicast probe is sent ucast_solicit times.  If that fails
       too, it will broadcast a new ARP request to the network.  Requests are sent only when there is data queued for sending.

       Linux will automatically add a nonpermanent proxy arp entry when it receives a request for an address it forwards to and proxy arp is enabled on the receiving interface.   When  there  is  a  reject
       route for the target, no proxy arp entry is added.

   Ioctls
       Three ioctls are available on all AF_INET sockets.  They take a pointer to a struct arpreq as their argument.

           struct arpreq {
               struct sockaddr arp_pa;      /* protocol address */
               struct sockaddr arp_ha;      /* hardware address */
               int             arp_flags;   /* flags */
               struct sockaddr arp_netmask; /* netmask of protocol address */
               char            arp_dev[16];
           };

       SIOCSARP,  SIOCDARP and SIOCGARP respectively set, delete and get an ARP mapping.  Setting and deleting ARP maps are privileged operations and may be performed only by a process with the CAP_NET_AD‐
       MIN capability or an effective UID of 0.

       arp_pa must be an AF_INET address and arp_ha must have the same type as the device which is specified in arp_dev.  arp_dev is a zero-terminated string which names a device.

              ┌─────────────────────────────────────┐
              │             arp_flags               │
              ├────────────────┬────────────────────┤
              │flag            │ meaning            │
              ├────────────────┼────────────────────┤
              │ATF_COM         │ Lookup complete    │
              ├────────────────┼────────────────────┤
              │ATF_PERM        │ Permanent entry    │
              ├────────────────┼────────────────────┤
              │ATF_PUBL        │ Publish entry      │
              ├────────────────┼────────────────────┤
              │ATF_USETRAILERS │ Trailers requested │
              ├────────────────┼────────────────────┤
              │ATF_NETMASK     │ Use a netmask      │
              ├────────────────┼────────────────────┤
              │ATF_DONTPUB     │ Don't answer       │
              └────────────────┴────────────────────┘
       If the ATF_NETMASK flag is set, then arp_netmask should be valid.  Linux 2.2 does not support proxy network ARP entries, so this should be set to 0xffffffff, or 0 to remove an existing proxy arp en‐
       try.  ATF_USETRAILERS is obsolete and should not be used.

   /proc interfaces
       ARP  supports  a  range  of /proc interfaces to configure parameters on a global or per-interface basis.  The interfaces can be accessed by reading or writing the /proc/sys/net/ipv4/neigh/*/* files.
       Each interface in the system has its own directory in /proc/sys/net/ipv4/neigh/.  The setting in the "default" directory is used for all newly created devices.  Unless otherwise specified,  time-re‐
       lated interfaces are specified in seconds.

       anycast_delay (since Linux 2.2)
              The maximum number of jiffies to delay before replying to a IPv6 neighbor solicitation message.  Anycast support is not yet implemented.  Defaults to 1 second.

       app_solicit (since Linux 2.2)
              The maximum number of probes to send to the user space ARP daemon via netlink before dropping back to multicast probes (see mcast_solicit).  Defaults to 0.

       base_reachable_time (since Linux 2.2)
              Once  a  neighbor  has  been found, the entry is considered to be valid for at least a random value between base_reachable_time/2 and 3*base_reachable_time/2.  An entry's validity will be ex‐
              tended if it receives positive feedback from higher level protocols.  Defaults to 30 seconds.  This file is now obsolete in favor of base_reachable_time_ms.

       base_reachable_time_ms (since Linux 2.6.12)
              As for base_reachable_time, but measures time in milliseconds.  Defaults to 30000 milliseconds.

       delay_first_probe_time (since Linux 2.2)
              Delay before first probe after it has been decided that a neighbor is stale.  Defaults to 5 seconds.

       gc_interval (since Linux 2.2)
              How frequently the garbage collector for neighbor entries should attempt to run.  Defaults to 30 seconds.

       gc_stale_time (since Linux 2.2)
              Determines how often to check for stale neighbor entries.  When a neighbor entry is considered stale, it is resolved again before sending data to it.  Defaults to 60 seconds.

       gc_thresh1 (since Linux 2.2)
              The minimum number of entries to keep in the ARP cache.  The garbage collector will not run if there are fewer than this number of entries in the cache.  Defaults to 128.

       gc_thresh2 (since Linux 2.2)
              The soft maximum number of entries to keep in the ARP cache.  The garbage collector will allow the number of entries to exceed this for 5 seconds before collection  will  be  performed.   De‐
              faults to 512.

       gc_thresh3 (since Linux 2.2)
              The hard maximum number of entries to keep in the ARP cache.  The garbage collector will always run if there are more than this number of entries in the cache.  Defaults to 1024.

       locktime (since Linux 2.2)
              The  minimum  number  of jiffies to keep an ARP entry in the cache.  This prevents ARP cache thrashing if there is more than one potential mapping (generally due to network misconfiguration).
              Defaults to 1 second.

       mcast_solicit (since Linux 2.2)
              The maximum number of attempts to resolve an address by multicast/broadcast before marking the entry as unreachable.  Defaults to 3.

       proxy_delay (since Linux 2.2)
              When an ARP request for a known proxy-ARP address is received, delay up to proxy_delay jiffies before replying.  This is used to prevent network flooding in some cases.  Defaults to 0.8  sec‐
              onds.

       proxy_qlen (since Linux 2.2)
              The maximum number of packets which may be queued to proxy-ARP addresses.  Defaults to 64.

       retrans_time (since Linux 2.2)
              The number of jiffies to delay before retransmitting a request.  Defaults to 1 second.  This file is now obsolete in favor of retrans_time_ms.

       retrans_time_ms (since Linux 2.6.12)
              The number of milliseconds to delay before retransmitting a request.  Defaults to 1000 milliseconds.

       ucast_solicit (since Linux 2.2)
              The maximum number of attempts to send unicast probes before asking the ARP daemon (see app_solicit).  Defaults to 3.

       unres_qlen (since Linux 2.2)
              The maximum number of packets which may be queued for each unresolved address by other network layers.  Defaults to 3.

VERSIONS
       The struct arpreq changed in Linux 2.0 to include the arp_dev member and the ioctl numbers changed at the same time.  Support for the old ioctls was dropped in Linux 2.2.

       Support for proxy arp entries for networks (netmask not equal 0xffffffff) was dropped in Linux 2.2.  It is replaced by automatic proxy arp setup by the kernel for all reachable hosts on other inter‐
       faces (when forwarding and proxy arp is enabled for the interface).

       The neigh/* interfaces did not exist before Linux 2.2.

BUGS
       Some timer settings are specified in jiffies, which is architecture- and kernel version-dependent; see time(7).

       There is no way to signal positive feedback from user space.  This means connection-oriented protocols implemented in user space will generate excessive ARP traffic,  because  ndisc  will  regularly
       reprobe the MAC address.  The same problem applies for some kernel protocols (e.g., NFS over UDP).

       This man page mashes together functionality that is IPv4-specific with functionality that is shared between IPv4 and IPv6.

SEE ALSO
       capabilities(7), ip(7), arpd(8)

       RFC 826 for a description of ARP.  RFC 2461 for a description of IPv6 neighbor discovery and the base algorithms used.  Linux 2.2+ IPv4 ARP uses the IPv6 algorithms when applicable.

COLOPHON
       This  page  is  part  of  release  5.02  of  the  Linux  man-pages  project.   A  description  of  the project, information about reporting bugs, and the latest version of this page, can be found at
       https://www.kernel.org/doc/man-pages/.

Linux                                                                                             2017-09-15                                                                                           ARP(7)
ARP(3pm)                                                                             User Contributed Perl Documentation                                                                             ARP(3pm)

NAME
       ARP - Perl extension for creating ARP packets

SYNOPSIS
         use Net::ARP;
         Net::ARP::send_packet('lo',                 # Device
                               '127.0.0.1',          # Source IP
                               '127.0.0.1',          # Destination IP
                               'aa:bb:cc:aa:bb:cc',  # Source MAC
                               'aa:bb:cc:aa:bb:cc',  # Destinaton MAC
                               'reply');             # ARP operation

       $mac = Net::ARP::get_mac("eth0");

       print "$mac\n";

       $mac = Net::ARP::arp_lookup($dev,"192.168.1.1");

       print "192.168.1.1 has got mac $mac\n";

   IMPORTANT
       Version 1.0 will break with the API of PRE-1.0 versions, because the return value of arp_lookup() and get_mac() will no longer be passed as parameter, but returned!  I hope this decision is ok as
       long as we get a cleaner and more perlish API.

   DESCRIPTION
       This module can be used to create and send ARP packets and to get the mac address of an ethernet interface or ip address.

       send_packet()
             Net::ARP::send_packet('lo',                 # Device
                                   '127.0.0.1',          # Source IP
                                   '127.0.0.1',          # Destination IP
                                   'aa:bb:cc:aa:bb:cc',  # Source MAC
                                   'aa:bb:cc:aa:bb:cc',  # Destinaton MAC
                                   'reply');             # ARP operation

             I think this is self documentating.
             ARP operation can be one of the following values:
             request, reply, revrequest, revreply, invrequest, invreply.

       get_mac()
             $mac = Net::ARP::get_mac("eth0");

             This gets the MAC address of the eth0 interface and stores
             it in the variable $mac. The return value is "unknown" if
             the mac cannot be looked up.

       arp_lookup()
             $mac = Net::ARP::arp_lookup($dev,"192.168.1.1");

             This looks up the MAC address for the ip address 192.168.1.1
             and stores it in the variable $mac. The return value is
             "unknown" if the mac cannot be looked up.

SEE ALSO
        man -a arp

AUTHOR
        Bastian Ballmann [ balle@codekid.net ]
        http://www.codekid.net

COPYRIGHT AND LICENSE
       Copyright (C) 2004-2013 by Bastian Ballmann

       License: GPLv2

perl v5.28.0                                                                                      2018-11-03                                                                                         ARP(3pm)
