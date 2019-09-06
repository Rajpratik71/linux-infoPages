File: *manpages*,  Node: kdump,  Up: (dir)

KDUMP(5)                         User Manuals                         KDUMP(5)



NAME
       kdump - Configuration of kdump

SYNOPSIS
       /etc/sysconfig/kdump

DESCRIPTION
       This configuration file provides various options for the kdump loading
       and saving process. It’s mostly read by kdumptool(8) but also by the
       kdump init script.

OPTIONS
       The file format consists of shell variables (which means that the
       configuration file is actually parsed by a sh(1) compatible shell) that
       are described below. It’s recommended to use a pair of double quotes to
       assign values to that variables.

   KDUMP_KERNELVER
       Kernel Version string for the -kdump kernel, such as "2.6.25-5-kdump".
       The init script will use a kernel named
       /boot/vmlinu[zx]-$KDUMP_KERNELVER. Using "kdump" will default to the
       most recently installed kdump kernel (to which the symbolic link
       /boot/vmlinuz-kdump points).

       If no version is specified, then the init script will try to find a
       kdump kernel with the algorithm described below.

       Default is "" which means that the auto-detection described above is
       used.

       Kernel auto-detection
           Let’s assume that a kernel name KERNELRELEASE consists of
           BASEVERSION and a FLAVOUR on SUSE. For example consider the kernel
           release ("uname -r") "2.6.25.18-0.2-default". Then the BASEVERSION
           is "2.6.25.18-0.2" (but there are also BASEVERSION strings without
           a dash) and the FLAVOUR is "default".

           To find out if a kernel is suitable as capture kernel, there are
           strong and weak requirements. The strong requirements mean that you
           just cannot use the kernel as kdump kernel:

           ·   Either the kernel must be a special kdump kernel with a
               modified start address or

           ·   the kernel is relocatable.

           The weak requirements mean that a kernel is not good as kdump
           kernel so it should be avoided when better kernels are installed. A
           kernel does not fulfil that weak requirements when

           ·   It is a realtime kernel (since the interrupt handling is
               different and irqpoll has problems) or

           ·   the kernel is compiled for a huge number of CPUs (above 1024 in
               our case) since that means that the capure kernel needs more
               memory.

           After all that definition, the algorithm tries following kernels in
           that order:

            1. BASEVERSION-kdump (e.g. /boot/vmlinuz-2.6.27-rc1-kdump)

            2. kdump (e.g. /boot/vmlinuz-kdump)

            3. KERNELRELEASE (e.g. /boot/vmlinuz-2.6.27-rc1-kdump), strong
               check

            4. BASEVERSION-default (e.g. /boot/vmlinuz-2.6.27-rc1-default),
               strong check

            5. "" (e.g. /boot/vmlinuz), strong check

            6. KERNELRELEASE (e.g. /boot/vmlinuz-2.6.27-rc1-kdump), weak check

            7. "" (e.g. /boot/vmlinuz), weak check

           On each item, it tries:

            1. /boot/*vmlinuz

            2. /boot/*vmlinux

       Initrd
           For the initrd, if the kernel name already contains "kdump", then
           the initrd /boot/initrd-<kernelver> is used. Else, we use
           /boot/initrd-<kernelver>-kdump (the kernel flavour is not replaced,
           so for example this means /boot/initrd-2.6.25.9-0.2-default-kdump.
           This is because the initrd used for kdump always has to be special,
           and it makes no sense to load the normal initrd that would not save
           the dump.

   KDUMP_CPUS
       If dumping is CPU-bound on your system, you can parallelize it on an
       SMP system. Keep in mind that this increases the stress on the I/O
       subsystem, so you probably don’t get the maximum speed if you set this
       parameter to the number of CPUs in your system.

       This parameter modifies the maxcpus parameter of the kdump kernel and
       the number of makedumpfile(8) processes created.

       If the value is zero, all available CPUs are used, i.e. the maxcpus
       parameter is not added to the kdump kernel command line.

       Note: This parameter does not work properly for the ELF format, because
       makedumpfile(8) does not support split ELF dump files.

       Default is 1.

   KDUMP_COMMANDLINE
       Command line used to boot the kdump kernel. By default, the
       /etc/init.d/kdump script tries to build a command line automatically
       from the command line of the running system, preserving root partition,
       serial console, etc. If you manually create a command line, make sure
       to include:

       ·   the root parameter,

       ·   any console parameters (for serial console),

       ·   irqpoll,

       ·   reset_devices,

       ·   elevator=deadline to save the memory footprint.

       The last three parameters are special for kdump and should always be
       included, if you don’t have a good reason to exclude them.

       If you only want to extend the kernel command line with your own
       parameter(s), use KDUMP_COMMANDLINE_APPEND.

       Default is "".

   KDUMP_COMMANDLINE_APPEND
       This variable describes all command line parameters that are passed to
       the kdump kernel additionally to the default parameters.

       For network based dumping, you may have to add a net_delay parameter to
       specify the extra delay in seconds that is needed for the network
       device to become fully operational, e.g. net_delay=20 will wait 20
       seconds before continuing after the network device is configured. This
       parameter is used by the network setup code in the resulting initrd.

       See also KDUMP_COMMANDLINE.

       Default is "".

   KEXEC_OPTIONS
       Additional options for kexec(8).

       Default is "" except on IA64 where it is "--noio".

   MAKEDUMPFILE_OPTIONS
       Additional options for makedumpfile(8). makedumpfile will be used to
       save the dump if KDUMP_DUMPLEVEL is non-zero or KDUMP_DUMPFORMAT is not
       ELF. Normally, you don’t have to specify any options here, but you may
       be asked in Bugzilla to add the -D option for debugging.

       Default is "".

   KDUMP_IMMEDIATE_REBOOT
       Immediately reboot after saving the core in the kdump kernel? Use "yes"
       or "no".

       Default is "yes".

   KDUMP_TRANSFER
       A script or command executed to process and transfer the dump image. It
       can read the dump image either via /proc/vmcore or /dev/oldmem. Most
       other variables will have no effect if you use a custom command here.

       It’s important that all requirements including that script itself are
       included in KDUMP_REQUIRED_PROGRAMS.

       It’s strongly recommended that the default mechanism is used, it should
       provide everything that is needed, together with KDUMP_PRESCRIPT and
       KDUMP_POSTSCRIPT. We can’t support problems with using that variable.

       KDUMP_PRESCRIPT and KDUMP_POSTSCRIPT are not executed if KDUMP_TRANSFER
       is set.

       Default: "".

   KDUMP_SAVEDIR
       The directory where dumps are saved to. If the directory does not
       exist, it will be created. The directory is a URL and must conform to
       the syntax described in the section "URL FORMAT" below. If the
       directory does not exist, it will be created. (That is true for all
       targets, even network targets. Of course the user must have the
       permission to create directories.)

       Below that directory, for each dump a directory with a time stamp in
       the following format will be created: "YYYY-MM-TT-HH:MM". That
       directory contains the dump and various other files, depending which
       dump target will be used and which dump settings are made.

       If KDUMP_COPY_KERNEL is set, that directory will also contain the
       kernel.

       You can specify multiple targets separated by spaces. The dump will
       then be split and saved to all target directories in parallel. This is
       useful if the targets are on different storage devices, because their
       combined I/O bandwidth can be used. Note how this option interacts with
       KDUMP_CPUS. If you specify more CPUs than target locations, then they
       will be assigned to the available processes in a round-robin fashion
       (i.e. more than one process will be writing to the same directory). If
       you specify more locations than CPUs, then only the first KDUMP_CPUS
       locations will be used. This feature is supported only for local files
       using the kdump-compressed format.

       Default: "file:///var/log/dump".

   KDUMP_KEEP_OLD_DUMPS
       Number of old dumps to keep. That variable is only honored on local
       directories (i.e., if KDUMP_SAVEDIR starts with file) because we think
       it’s bad from a security point of view if other hosts delete stuff
       (that may be from another hosts) on a dump server. The deletion process
       takes place before the dumps are saved. So if you specify 3 here, then
       after the dump has been saved, 4 dumps are on disk.

       Set that variable to "0" to disable the deletion of dumps entirely, and
       set that variable to "-1" to delete all dumps, i.e. then only the just
       saved dump is on disk.

       Default: "5"

   KDUMP_FREE_DISK_SIZE
       Make sure that at least KDUMP_FREE_DISK_SIZE megabytes are free on the
       target partition after saving the dump file. Since the target dump file
       size may not be known (because of compression and/or filtering), kdump
       always attempts to save the dump, but checks remaining free space
       afterwards and deletes the dump directory again if remaining space is
       less than the value specified here.

       This option applies only to local file systems, i.e. KDUMP_SAVEDIR must
       start with file.

       Default: "64"

   KDUMP_VERBOSE
       Bit mask of several options that set the verbosity of the dump process.
       To apply several options, you have to add their value. The options are:

       1
           kdump command line is written to system log when executing
           /etc/init.d/kdump.

       2
           Progress is written to stdout while dumping.

       4
           kdump command line is written so standard output when executing
           /etc/init.d/kdump.

       8
           Debugging for kdump transfer mechanism. That is executed in initrd
           and generates lots of output. However, it’s very useful if
           something does not work.

       16
           Debugging when loading the kdump kernel. That creates lots of
           output to stdout, so only use if you really want to debug that. It
           is useful if kdump reports that it cannot find a suitable kernel
           but you think kdump is wrong.

       So, for example, if you want to have the command line on stdout when
       loading the kernel and also in the system log, just use KDUMP_VERBOSE =
       5 (i.e. 1 + 4).

       Default: "3".

   KDUMP_DUMPLEVEL
       Determines the dump level. If KDUMP_DUMPLEVEL is non-zero, then
       makedumpfile(8) is used to strip pages that may not be necessary for
       analysing. 0 means no stripping, and 31 is the maximum dump level, i.e.
       0 produces the largest dump files and 31 the smallest.

       The following table from makedumpfile(8) shows what each dump level
       means:

       ┌───────────┬───────────┬────────────┬─────────┬───────────┬───────────┐
       │dump level │ zero page │ cache page │ cache   │ user data │ free page │
       │           │           │            │ private │           │           │
       ├───────────┼───────────┼────────────┼─────────┼───────────┼───────────┤
       │         0 │           │            │         │           │           │
       ├───────────┼───────────┼────────────┼─────────┼───────────┼───────────┤
       │         1 │     X     │            │         │           │           │
       ├───────────┼───────────┼────────────┼─────────┼───────────┼───────────┤
       │         2 │           │     X      │         │           │           │
       ├───────────┼───────────┼────────────┼─────────┼───────────┼───────────┤
       │         3 │     X     │     X      │         │           │           │
       ├───────────┼───────────┼────────────┼─────────┼───────────┼───────────┤
       │         4 │           │     X      │    X    │           │           │
       ├───────────┼───────────┼────────────┼─────────┼───────────┼───────────┤
       │         5 │     X     │     X      │    X    │           │           │
       ├───────────┼───────────┼────────────┼─────────┼───────────┼───────────┤
       │         6 │           │     X      │    X    │           │           │
       ├───────────┼───────────┼────────────┼─────────┼───────────┼───────────┤
       │         7 │     X     │     X      │    X    │           │           │
       ├───────────┼───────────┼────────────┼─────────┼───────────┼───────────┤
       │         8 │           │            │         │     X     │           │
       ├───────────┼───────────┼────────────┼─────────┼───────────┼───────────┤
       │         9 │     X     │            │         │     X     │           │
       ├───────────┼───────────┼────────────┼─────────┼───────────┼───────────┤
       │        10 │           │     X      │         │     X     │           │
       ├───────────┼───────────┼────────────┼─────────┼───────────┼───────────┤
       │        11 │     X     │     X      │         │     X     │           │
       ├───────────┼───────────┼────────────┼─────────┼───────────┼───────────┤
       │        12 │           │     X      │    X    │     X     │           │
       ├───────────┼───────────┼────────────┼─────────┼───────────┼───────────┤
       │        13 │     X     │     X      │    X    │     X     │           │
       ├───────────┼───────────┼────────────┼─────────┼───────────┼───────────┤
       │        14 │           │     X      │    X    │     X     │           │
       ├───────────┼───────────┼────────────┼─────────┼───────────┼───────────┤
       │        15 │     X     │     X      │    X    │     X     │           │
       ├───────────┼───────────┼────────────┼─────────┼───────────┼───────────┤
       │        16 │           │            │         │           │     X     │
       ├───────────┼───────────┼────────────┼─────────┼───────────┼───────────┤
       │        17 │     X     │            │         │           │     X     │
       ├───────────┼───────────┼────────────┼─────────┼───────────┼───────────┤
       │        18 │           │     X      │         │           │     X     │
       ├───────────┼───────────┼────────────┼─────────┼───────────┼───────────┤
       │        19 │     X     │     X      │         │           │     X     │
       ├───────────┼───────────┼────────────┼─────────┼───────────┼───────────┤
       │        20 │           │     X      │    X    │           │     X     │
       ├───────────┼───────────┼────────────┼─────────┼───────────┼───────────┤
       │        21 │     X     │     X      │    X    │           │     X     │
       ├───────────┼───────────┼────────────┼─────────┼───────────┼───────────┤
       │        22 │           │     X      │    X    │           │     X     │
       ├───────────┼───────────┼────────────┼─────────┼───────────┼───────────┤
       │        23 │     X     │     X      │    X    │           │     X     │
       ├───────────┼───────────┼────────────┼─────────┼───────────┼───────────┤
       │        24 │           │            │         │     X     │     X     │
       ├───────────┼───────────┼────────────┼─────────┼───────────┼───────────┤
       │        25 │     X     │            │         │     X     │     X     │
       ├───────────┼───────────┼────────────┼─────────┼───────────┼───────────┤
       │        26 │           │     X      │         │     X     │     X     │
       ├───────────┼───────────┼────────────┼─────────┼───────────┼───────────┤
       │        27 │     X     │     X      │         │     X     │     X     │
       ├───────────┼───────────┼────────────┼─────────┼───────────┼───────────┤
       │        28 │           │     X      │    X    │     X     │     X     │
       ├───────────┼───────────┼────────────┼─────────┼───────────┼───────────┤
       │        29 │     X     │     X      │    X    │     X     │     X     │
       ├───────────┼───────────┼────────────┼─────────┼───────────┼───────────┤
       │        30 │           │     X      │    X    │     X     │     X     │
       ├───────────┼───────────┼────────────┼─────────┼───────────┼───────────┤
       │        31 │     X     │     X      │    X    │     X     │     X     │
       └───────────┴───────────┴────────────┴─────────┴───────────┴───────────┘

       Default: "31"

   KDUMP_DUMPFORMAT
       This variable specifies the dump format.

       none
           Do not generate any dump file. This is useful if you only want the
           kernel log buffer, because it minimizes disk space requirements and
           also greatly reduces the time involved in waiting for the dump to
           complete.

       ELF
           ELF has the advantage that it’s a standard format and GDB can be
           used to analyse the dumps. The disadvantage is that the dump files
           are larger.

       compressed
           compressed is the kdump compressed format that produces small
           dumps, see makedumpfile(8). However, only crash(8) can analyse the
           dumps and makedumpfile must be installed (but you need it anyway if
           you set KDUMP_DUMPLEVEL to non-zero before).

       lzo
           lzo is similar to compressed, but it uses the LZO compression
           algorithm instead of gzip. This usually results in slightly bigger
           files, but it is much faster. You will need crash(8) version 6.0.7
           or later to open the dump file.

       snappy
           snappy is very similar to lzo, but it uses the Snappy compression
           algorithm. It is usually considerably faster and achieves
           approximately the same compression ratio. Snappy is optimized for
           64-bit, little-endian architectures (e.g. x86_64).

       Default: "compressed"

   KDUMP_CONTINUE_ON_ERROR
       If something goes wrong while saving the dump or deleting old dumps in
       initrd, then kdumptool(8) normally tries to execute the next action.
       However, it can be useful to open a shell at that point in time and fix
       or debug the problem. This happens when KDUMP_CONTINUE_ON_ERROR is set
       to "false".

       Default: "true"

   KDUMP_REQUIRED_PROGRAMS
       This is a space-separated list of programs (full path) that are
       required by KDUMP_TRANSFER, KDUMP_PRESCRIPT or KDUMP_POSTSCRIPT.
       Dynamic libraries that are required by that programs don’t have to be
       included as they are resolved automatically. However, it’s necessary to
       include other runtime requirements because it’s not possible to resolve
       them automatically.

       Default: ""

   KDUMP_PRESCRIPT
       Program that is executed before taking the dump. You have to include
       that program in KDUMP_REQUIRED_PROGRAMS.

       Default: ""

   KDUMP_POSTSCRIPT
       Program that is executed after taking the dump and before the system is
       rebooted. You have to include that program in KDUMP_POSTSCRIPT.

       Default: ""

   KDUMP_COPY_KERNEL
       Not only copy the dump to KDUMP_SAVEDIR but also the installed kernel.
       Valid values are "yes" and "no". If you want to have the debugging
       information also copied, which is required to open the program, you
       also have to install the kernel-<flavour>-debuginfo package.

       Modules are not copied, only the kernel image and the debugging file.

       Default: "yes"

   KDUMPTOOL_FLAGS
       This is a space-separated list of flags to tweak the run-time behaviour
       of kdumptool(8). These flags are recognized:

       NOSPARSE
           Disable the creation of sparse-files. This flag is for debugging
           purposes, e.g. if the file system or network protocol has problems
           with sparse files. Because SFTP and FTP are not mounted, that
           option has no meaning when saving the dump to SFTP and FTP.

       SPLIT
           If KDUMP_CPUS>1, use the --split option of makedumpfile(8) instead
           of the default --num-threads.

       SINGLE
           Specify this flag to force the use of only one CPU for dumping,
           regardless of the value of KDUMP_CPUS. It disables the --split and
           --num-threads options of makedumpfile(8).

               For compatibility with older versions, *NOSPLIT* is an alias for *SINGLE*.
               Its use is deprecated.

       XENALLDOMAINS
           When dumping a Xen virtualization host, makedumpfile(8) is normally
           invoked with the -X option to exclude DomU pages. This flag can be
           used to include all pages in the dump.

       Default: ""

   KDUMP_NETCONFIG
       Network configuration for kdump. Because the dump process runs in
       initrd, the network configuration is different from the normal network
       configuration. Use auto to auto-detect the network configuration (see
       auto mode below). The interface with the default route will be used.
       This is the default.

       Auto-detection cannot be used to set up dual-stack (IPv4 and IPv6)
       hosts because of limitations in the implementation of the ip= initrd
       command line option.

       Use a netdevice:mode string to force a specific network device to be
       used. A netdevice is for example "eth0". The mode can be:

       static
           Always re-use the current configuration of netdevice (both IPv4 and
           IPv6). Note that only permanent global IPv6 addresses are stored,
           because temporary addresses are likely to expire before the system
           crashes, and link-local addresses are set up automatically.

       auto6
           Use IPv6 autoconfiguration to get an address on the interface.

       dhcp, dhcp4
           Use DHCP to configure an IPv4 address on the interface.

       dhcp6
           Use DHCP6 to configure an IPv6 address on the interface.

       auto
           Select the mode depending on the current state of the interface:

           ·   use DHCP4 if it has an IPv4 address (IPv6 not set up),

           ·   use DHCP6 if it has a permanent IPv6 address (IPv4 not set up),

           ·   use IPv6 auto-configuration if it has neither (IPv4 not set
               up).

       You can set KDUMP_NETCONFIG to "" if you want no network in initrd,
       i.e. you use disk dumping.

       Default: "auto"

   KDUMP_SMTP_SERVER
       If you want to get an email after the dump has been copied, you can
       specify an SMTP server here. It’s valid to specify a hostname, an IP
       address. Optionally, you can also specify a port with the usual :port
       syntax.

       Example: smtp.myprovider.de:25

       If you provide a username (KDUMP_SMTP_USER) and a password
       (KDUMP_SMTP_PASSWORD), then SMTP AUTH will be used. Otherwise, plain
       SMTP with no authentication will be used.

       Default: ""

   KDUMP_SMTP_USER
       Username used for SMTP authentication. Also specify KDUMP_SMTP_PASSWORD
       in that case. If no username and/or no password will be provided, plain
       SMTP will be used.

       Default: ""

   KDUMP_SMTP_PASSWORD
       Password used for SMTP authentication. Also specify KDUMP_SMTP_USER in
       that case. If no username and/or no password will be provided, plain
       SMTP will be used.

       Default: ""

   KDUMP_NOTIFICATION_TO
       Email address where notification mails should be sent to. Don’t specify
       a real name here, only an email address. You have to configure a SMTP
       server with KDUMP_SMTP_SERVER to use that feature.

       Example: john@myprovider.de

       Default: ""

   KDUMP_NOTIFICATION_CC
       Space-separated list of email addresses where notification mails should
       be sent to via Cc. Don’t specify real names here, only email addresses.
       You have to configure a SMTP server with KDUMP_SMTP_SERVER to use that
       feature.

       Example: "john@myprovider.de doe@myprovider.de"

       Default: ""

   KDUMP_SSH_HOST_KEY
       Target host key encoded with base64, i.e. as found in
       ~/.ssh/known_hosts. This is used for the SFTP transfer protocol to
       verify the authenticity of the remote host. If this field is left
       empty, the setup scripts will try to get it automatically using
       ssh-keygen -F $target_host.

       If you want to disable host key checking, set this variable to "*".

       Example (broken into lines for readability):

           AAAAB3NzaC1yc2EAAAABIwAAAIEAxIJIeuVX0F0u53wMgH22fdl62ifLXRwaPAXPsCr
           vyerMEb5DXHnIv1sYdzlJ1g/2Iw+ppjGDh1En/P12Dpl2uLBZh0MOrM71spTjvTwV2M
           KZtXrYjZUIPIZdd9vrI+/LEI0nw7LSdnKKgkAIXMhaRrq9N6uoZWe41ilU4NpnL/k=

       Default: ""

   KDUMP_SSH_IDENTITY
       List of SSH identity files for public key authentication. If empty,
       kdump will try all standard OpenSSH identities for the root user (rsa,
       dsa, ecdsa, ed25519, in this order). The path to every identity file is
       relative to ~root/.ssh, or an absolute path can be given.

       Example: "/root/.ssh/id_kdump_rsa"

       Default: ""

URL FORMAT
       In general, the URL format is

       protocol://specification

       where protocol is one of:

       ·   file,

       ·   ftp,

       ·   sftp (alias is scp),

       ·   ssh

       ·   nfs

       ·   cifs (alias is smb).

       The specification varies for each protocol.

   Local files (file)
       That type describes a local path.

       Format: [file://]/path

       As shown, the file prefix is optional, i.e. a simple path is still
       valid. The path must start with a leading slash (/), i.e. only absolute
       paths are allowed.

       Examples:

       ·   /var/log/dump

       ·   file:///var/log/dump

   File Transfer Protocol (ftp)
       This URL type is used to specify paths on a remote FTP server.

       Format: ftp://[user[:password]@]hostname[:port]/path

       The remote user is optional, if no user is specified, anonymous FTP is
       assumed. Even if a username is specified, the password is optional, if
       no password is specified, an empty password is used. When the username
       is "anonymous", then "$USER@$HOSTNAME" is used as password because some
       FTP servers deny anonymous FTP with empty passwords.

       hostname can be either a (DNS-)resolvable hostname, with or without a
       domain name, or an IP address in dotted decimal format. port can be
       used to specify the remote port, if no port is specified in the URL,
       the default FTP port is used. Finally, path must conform to the same
       rules as for local files (see above).

       Examples:

       ·   ftp://neptunium/var/log/dump

       ·   ftp://bwalle@neptunium.suse.de/var/log/dump

       ·   ftp://bwalle:dontsay@strauss.suse.de:123/var/log/dump

       ·   ftp://192.168.0.70/var/log/dump

   Secure File Transfer Protocol (sftp)
       This URL type is used to specify paths on a remote server that is
       reachable via SFTP. It’s important that an SFTP server must be running
       (which is the default on SUSE), the kdumptool does not use FISH (FIles
       transferred over SHell protocol).

       Format: sftp://[user@]hostname[:port]/path

       It’s possible to use "scp" as an alias for "sftp" (for backward
       compatibility), but it is a misnomer; kdumptool does not implement the
       SCP protocol and it will use SFTP instead.

       See the description of FTP for an explanation of the hostname and port
       elements.

       After a system crash, the crashed machine first verifies the identity
       of the target host to make sure it does not save the dump to an
       imposter. Then the target host verifies the identity of the crashed
       machine. SSH private/public key pairs are used in both cases.

       Server Identification
           Since system dumps may contain sensitive information, kdump uses
           strict host key checking for the target server. The SSH client must
           have a copy of the public part of the target server’s host key. The
           copy is kept in a known_hosts file on the client. Kdump will use
           the key found in ~root/.ssh/known_hosts when the kdump initrd is
           generated.

       Client Authentication
           The crashed system uses root’s private SSH key to login to the
           target system. The public part of that key must be copied to the
           target user’s ~/.ssh/authorized_keys on the target host.

       Example Setup
           To set up crasher for saving dumps over SFTP to dump@collector,
           follow these steps:

            1. Add the target host public key to ~root/.ssh/known_hosts on
               crasher, e.g.:

                   root@crasher:~# ssh-keyscan -t rsa,ecdsa,ed25519 collector \
                           >> ~/.ssh/known_hosts

               WARNING: Note that the above command accepts the identity of
               collector without any checking that it is genuine. This is a
               security risk unless the network connection between crasher and
               collector can be fully trusted when you run this command.

            2. Generate a private/public key pair for the root user on
               crasher, e.g. to make a 4096-bit RSA key, run this as root:

                   root@crasher:~# ssh-keygen -t rsa -b 4096 -N "" -f ~/.ssh/id_rsa

               Do not use any password to encrypt the key.  kdumptool is
               designed to be used non-interactively.

            3. Append the content of ~.ssh/id_rsa.pub to
               ~dump/.ssh/authorized_keys on collector:

                   root@crasher:~# ssh-copy-id dump@collector

           Examples:

           ·   sftp://dump@collector:22/var/log/dump

           ·   sftp://neptunium/var/log/dump

   Secure Shell Protocol (ssh)
       Unlike the sftp URL type, this protocol does not use SFTP, but rather
       transfers the data to a remote dd command.

       Format: ssh://[user@]hostname[:port]/path

       Most of the notes for SFTP also apply to SSH, except:

       ·   SFTP need not be configured on the target host.

       ·   Shell access must be granted to the dump user.

       ·   The shell must allow execution of mkdir, dd and mv.

       Examples:

       ·   ssh://kdump@crashdump/srv/www/dump/incoming

   Network File System (nfs)
       NFS is used to specify remote hosts that export their file system via
       NFS. NFS doesn’t use username and password. Also, the URL format cannot
       be used to specify options. As default, the nolock option is used.

       Format: nfs://host[:port]/path

       host is the hostname, port is optional (should not be used, it is only
       implemented for completeness with the other URL formats). path
       specifies the path that is exported via NFS in /etc/exports (or a
       subdirectory of a path that is exported).

       Examples:

       ·   nfs://neptunium/var/log/dump

       ·   nfs://10.10.2.120/var/log/dump

   Common Internet File System (cifs)
       CIFS is used to specify remote hosts that export a file system via
       CIFS, also known as SMB (although they are technically different, CIFS
       is the successor of SMB). This could be a Microsoft Windows server, or
       a Samba Server running on Unix or MacOS.

       Format: cifs://[user[:password]@]host/path

       Although it’s technically not 100 % correct, smb is used as an alias
       for cifs, so the program will always return cifs even if you specify
       smb.

       The parts of the URL are described in the FTP section above.

       Note: You have to use the slash as path separator, not the backslash as
       on Microsoft Windows.

       Examples:

       ·   cifs://neptunium/var/log/dump

       ·   cifs://bwalle:dontsay@neptunium:/var/log/dump

       ·   smb://bwalle@192.168.0.70:/var/log

BUGS
       Please report bugs and enhancement requests at
       https://bugzilla.novell.com.

COPYING
       Copyright (c) 2008 Bernhard Walle <bwalle@suse.de>. Free use of this
       software is granted under the terms of the GNU General Public License
       (GPL), version 2 or later.

SEE ALSO
       kexec(8), kdump(5), makedumpfile(8), mkdumprd(8)
       http://en.opensuse.org/Kdump

AUTHOR
       Bernhard Walle <bwalle@suse.de>
           Author.



kdump 0.8.16                      07/04/2017                          KDUMP(5)
KDUMP(7)                         User Manuals                         KDUMP(7)



NAME
       kdump - Saving kernel dumps in SUSE

SYNOPSIS
       (not applicable)

DESCRIPTION
       This manual page gives an overview about kdump configuration on SUSE.
       This version applies to SUSE LINUX Enterprise 11 and openSUSE 11.1.

       Kdump is a technology to save the memory contents of a crashed system
       and save it to disk or network to analyse it later and find the cause
       of the crash. When the system crashes, the mechanism uses kexec to boot
       a normal Linux kernel (that has been loaded into the system previously)
       which then has access to the old memory contents via /proc/vmcore
       interface and can save that away.

       After the memory has been saved, the system reboots (without kexec).

       As mentioned above, that panic kernel has to be loaded into the system.
       That is accomplished via kexec(8) in an init script at system bootup.
       To have memory for that panic kernel and also have RAM for the
       execution of that panic kernel, one has to reserve kernel memory with a
       special boot parameter (crashkernel).

       While it’s possible in theory to boot the full system by that panic
       kernel, on SUSE we use the approach of having a special initramfs that
       saves the dump to disk or network and then reboots. That has the
       advantage that less memory is necessary and the root file system also
       must not be intact if you save to another file system or to network.

AUTOMATIC CONFIGURATION WITH YAST
       A simple method to use kdump on SUSE is to use the YaST kdump module.
       Just install the package yast2-kdump (for example with

           # zypper install yast2-kdump

       and start the YaST2 module with

           # yast2 kdump

       Everything should be self-explanatory there.

MANUAL SETUP
       Following steps are needed to setup kdump manually (the description of
       the steps will follow):

        1. Install the required software packages,

        2. add the crashkernel parameter to bootloader configuration,

        3. enable the kdump service,

        4. configure kdump (/etc/sysconfig/kdump) and

        5. load the kdump kernel.

   Required software
       Following software packages are required for kdump:

       ·   kexec-tools

       ·   kdump

       ·   makedumpfile

       There is no special kernel-kdump required like in earlier versions of
       SUSE LINUX Enterprise. The technical reason is that the normal kernel
       is relocatable now and can be used as kdump kernel, i.e. it’s possible
       to load and execute the normal kernel at any address, not only the
       compiled-in address as before.

   Bootloader configuration
       It’s necessary to reserve a certain amount of memory in the normal
       system at boot time which will be used by kexec(8) to load the panic
       kernel. To achieve that, you have to add a parameter called crashkernel
       in bootloader configuration. The syntax is:

           crashkernel=size@offset

       The offset is the load offset, i.e. the physical base address on which
       the memory reservation area starts. Starting with version 2.6.27, it’s
       not necessary to specify that offset manually since the kernel chooses
       a suitable base address automatically.

       For the size, following values are recommended:

       ┌─────────────┬───────────────────────┐
       │Architecture │ Size                  │
       ├─────────────┼───────────────────────┤
       │i386         │ 64M                   │
       ├─────────────┼───────────────────────┤
       │x86_64       │ 64M or 128M on large  │
       │             │ machines              │
       ├─────────────┼───────────────────────┤
       │ppc64        │ 128M or 256M on large │
       │             │ machines              │
       ├─────────────┼───────────────────────┤
       │ia64         │ 512M (or more on very │
       │             │ large machines)       │
       └─────────────┴───────────────────────┘

       Example: crashkernel=64M (on a normal PC system)

           Note
           There’s also a more advanced syntax that makes the amount of memory
           dependent on system RAM. See the section called “Extended
           crashkernel commandline”.

   Enable kdump service
       The kdump runlevel script just loads the kdump kernel at boot. To
       enable it, use the YaST runlevel editor or simply

           # chkconfig boot.kdump on

       on a shell. You can also execute it manually with rckdump start.

   Configure kdump
       The default configuration should work out of the box. You can tweak
       several configuration options in the /etc/sysconfig/kdump configuration
       file.

           Important
           If you make changes in that configuration file, you always have to
           execute rckdump restart manually to make that changes apply. If you
           don’t, that changes will only apply after system reboot.

       See the section “CONFIGURATION” later and/or kdump(5) for a description
       of the configuration options.

   Load the kdump kernel
       As mentioned above, the init script /etc/init.d/boot.kdump takes the
       part of loading the kdump kernel. As kdump kernel, the normal system
       kernel is used, no special kernel image is required.

       However, as initramfs, a special initramfs is built by mkdumprd(8).
       Normally, you don’t have to take care about that step since the init
       script checks if the initramfs is up to date (reading the configuration
       file modification time) and rebuilds it if necessary.

       To manually load the kdump kernel (i.e, without the SUSE init script),
       you have to use the kexec(8) tool with the -p (panic kernel) parameter
       like:

           # kexec -p /boot/vmlinuz-version --initrd=/boot/initrd-version-kdump
           --reuse-cmdline

TESTING
       It perfectly makes sense to test the kdump configuration in a sane
       system state, i.e. not when the system really crashes but to trigger
       the dump manually. To perform that, use the SysRq mechanism, i.e. just
       execute

           # echo s > /proc/sysrq-trigger
           # echo u > /proc/sysrq-trigger
           # echo c > /proc/sysrq-trigger

       After that, the panic kernel should boot and the dump should be saved.

CONFIGURATION
       The configuration file is /etc/sysconfig/kdump. Just edit this file
       with a plain text editor to adjust the settings. You can also use the
       YaST2 sysconfig editor. All variables are described in kdump(5). Here’s
       a brief overview about some variables that are worth tweaking.

   Save Directory
       The most important setting is where the dump should be saved. Following
       methods are available:

       ·   local file,

       ·   FTP,

       ·   SFTP (SSH),

       ·   NFS,

       ·   CIFS.

       The recommendation is to use FTP or SFTP for network dumping or the
       local file dump. The configuration variable KDUMP_SAVEDIR has to be
       filled with a URL to where the dump should be saved. The syntax is
       described in kdump(5).

       If the directory does not exist, it will be created. Since the dump is
       taken in initrd, the network and mount configuration is a bit different
       from the normal system. However, the mkdumprd(8) script is designed to
       do everything automatically for you. If you would like to use a special
       network interface, see the KDUMP_NETCONFIG setting.

       Example:

       ·   file:///var/log/dump

       ·   ftp://user@host:server/incoming/dumps

           Note
           If you want to use SFTP with public key authentication, make sure
           to read the "Secure File Transfer Protocol" section in kdump(5).

   Deletion of old dumps
       If you save the dumps to your local file system, you may want that
       kdump deletes automatically old dumps. Set KDUMP_KEEP_OLD_DUMPS to the
       value how much old dumps should be preserved. To disable deletion of
       old dumps, set it to 0, and to delete all old dumps, set it to -1.

       If the partition has less than KDUMP_FREE_DISK_SIZE megabytes free disk
       space after saving the dump, the dump is not copied at all.

           Important
           That two options don’t apply to network dump targets.

   Dump Filtering and Compression
       The size of kernel dumps is uncompressed and unfiltered as large as
       your system has RAM. To get smaller files (for example, to send it to
       support), you can compress the whole dump file afterwards. However, the
       drawback is that the dump has to be uncompressed afterwards before
       opening, so the disk space needs to be there in any case.

       To use page compression which compresses every page and allows dynamic
       uncompression with the crash(8) debugging tool, set KDUMP_DUMPFORMAT to
       compressed (which is actually the default).

       To filter the dump, you have to set the KDUMP_DUMPLEVEL. Then not all
       memory is saved to disk but only memory that does not fulfil some
       criteria. I.e. you may want to leave out pages that are completely
       filled by zeroes as they don’t contain any useful information. The
       following table lists for each KDUMP_DUMPLEVEL the pages that are
       skipped, i.e. 0 produces a full dump and 31 is the smallest dump.

       ┌───────────┬───────────┬────────────┬─────────┬───────────┬───────────┐
       │dump level │ zero page │ cache page │ cache   │ user data │ free page │
       │           │           │            │ private │           │           │
       ├───────────┼───────────┼────────────┼─────────┼───────────┼───────────┤
       │         0 │           │            │         │           │           │
       ├───────────┼───────────┼────────────┼─────────┼───────────┼───────────┤
       │         1 │     X     │            │         │           │           │
       ├───────────┼───────────┼────────────┼─────────┼───────────┼───────────┤
       │         2 │           │     X      │         │           │           │
       ├───────────┼───────────┼────────────┼─────────┼───────────┼───────────┤
       │         3 │     X     │     X      │         │           │           │
       ├───────────┼───────────┼────────────┼─────────┼───────────┼───────────┤
       │         4 │           │     X      │    X    │           │           │
       ├───────────┼───────────┼────────────┼─────────┼───────────┼───────────┤
       │         5 │     X     │     X      │    X    │           │           │
       ├───────────┼───────────┼────────────┼─────────┼───────────┼───────────┤
       │         6 │           │     X      │    X    │           │           │
       ├───────────┼───────────┼────────────┼─────────┼───────────┼───────────┤
       │         7 │     X     │     X      │    X    │           │           │
       ├───────────┼───────────┼────────────┼─────────┼───────────┼───────────┤
       │         8 │           │            │         │     X     │           │
       ├───────────┼───────────┼────────────┼─────────┼───────────┼───────────┤
       │         9 │     X     │            │         │     X     │           │
       ├───────────┼───────────┼────────────┼─────────┼───────────┼───────────┤
       │        10 │           │     X      │         │     X     │           │
       ├───────────┼───────────┼────────────┼─────────┼───────────┼───────────┤
       │        11 │     X     │     X      │         │     X     │           │
       ├───────────┼───────────┼────────────┼─────────┼───────────┼───────────┤
       │        12 │           │     X      │    X    │     X     │           │
       ├───────────┼───────────┼────────────┼─────────┼───────────┼───────────┤
       │        13 │     X     │     X      │    X    │     X     │           │
       ├───────────┼───────────┼────────────┼─────────┼───────────┼───────────┤
       │        14 │           │     X      │    X    │     X     │           │
       ├───────────┼───────────┼────────────┼─────────┼───────────┼───────────┤
       │        15 │     X     │     X      │    X    │     X     │           │
       ├───────────┼───────────┼────────────┼─────────┼───────────┼───────────┤
       │        16 │           │            │         │           │     X     │
       ├───────────┼───────────┼────────────┼─────────┼───────────┼───────────┤
       │        17 │     X     │            │         │           │     X     │
       ├───────────┼───────────┼────────────┼─────────┼───────────┼───────────┤
       │        18 │           │     X      │         │           │     X     │
       ├───────────┼───────────┼────────────┼─────────┼───────────┼───────────┤
       │        19 │     X     │     X      │         │           │     X     │
       ├───────────┼───────────┼────────────┼─────────┼───────────┼───────────┤
       │        20 │           │     X      │    X    │           │     X     │
       ├───────────┼───────────┼────────────┼─────────┼───────────┼───────────┤
       │        21 │     X     │     X      │    X    │           │     X     │
       ├───────────┼───────────┼────────────┼─────────┼───────────┼───────────┤
       │        22 │           │     X      │    X    │           │     X     │
       ├───────────┼───────────┼────────────┼─────────┼───────────┼───────────┤
       │        23 │     X     │     X      │    X    │           │     X     │
       ├───────────┼───────────┼────────────┼─────────┼───────────┼───────────┤
       │        24 │           │            │         │     X     │     X     │
       ├───────────┼───────────┼────────────┼─────────┼───────────┼───────────┤
       │        25 │     X     │            │         │     X     │     X     │
       ├───────────┼───────────┼────────────┼─────────┼───────────┼───────────┤
       │        26 │           │     X      │         │     X     │     X     │
       ├───────────┼───────────┼────────────┼─────────┼───────────┼───────────┤
       │        27 │     X     │     X      │         │     X     │     X     │
       ├───────────┼───────────┼────────────┼─────────┼───────────┼───────────┤
       │        28 │           │     X      │    X    │     X     │     X     │
       ├───────────┼───────────┼────────────┼─────────┼───────────┼───────────┤
       │        29 │     X     │     X      │    X    │     X     │     X     │
       ├───────────┼───────────┼────────────┼─────────┼───────────┼───────────┤
       │        30 │           │     X      │    X    │     X     │     X     │
       ├───────────┼───────────┼────────────┼─────────┼───────────┼───────────┤
       │        31 │     X     │     X      │    X    │     X     │     X     │
       └───────────┴───────────┴────────────┴─────────┴───────────┴───────────┘

   Automatic Reboot and Error handling
       If you want to have your machine rebooted automatically after the dump
       has been copied, set KDUMP_IMMEDIATE_REBOOT to yes. The variable
       KDUMP_CONTINUE_ON_ERROR controls if a shell should be opened if
       something goes wrong while saving the dump to be able to fixup
       manually. This is mostly for debugging.

       In production, use that only if you have a serial console since VGA
       console and keyboard is not reliable in kdump environment.

   Notification
       If you enable notification support, then you get an email after the
       dump has been copied (and before the KDUMP_IMMEDIATE_REBOOT takes
       place). Because we don’t have a mail server running in initrd where the
       mail has to be sent, you have to configure a SMTP server:

       ·   KDUMP_SMTP_SERVER must hold a hostname (and an optional port,
           separated by a colon) to a SMTP server.

       ·   KDUMP_STMP_USER and KDUMP_SMTP_PASSWORD must be set to username and
           password if SMTP AUTH should be used, or empty otherwise (plain
           SMTP without authentication will be used).

       Then an email will be sent to the address in KDUMP_NOTIFICATION_TO
       (only one address possible) and KDUMP_NOTIFICATION_CC (multiple
       addresses possible).

   Debugging options
       If something goes wrong and you possibly opened a bug report, you may
       be asked to increase verbosity to report what’s going wrong. Also, this
       is useful if you would like to find the cause yourself.

       At first, you can increase KDUMP_VERBOSE. The maximum log level is 15.
       That gives both information when loading the dump kernel (i.e. the
       rckdump start command) and also when copying the dump in initrd.

           Warning
           If you use a VGA console and trigger the dump when X11 is running
           (i.e. your graphical desktop), you might not see any output. Use a
           serial console in that case, or try to trigger the dump from Linux
           console (i.e. press Ctrl-Alt-F1 in your graphical desktop and log
           in there).

       If the problem is the makedumpfile(8) filtering tool, then set
       MAKEDUMPFILE_OPTIONS to -D to get debugging output of makedumpfile.

ADVANCED CONFIGURATION
   Trigger Kdump on NMI (i386/x86_64 only)
       Some systems (mostly "Enterprise" servers) have a so-called NMI button
       (physically or via the remote management consoles) that triggers an NMI
       manually if the system hangs completely and even SysRQ does not work
       any more.

       If you want to trigger a kdump in that case, you have to execute

           # sysctl kernel.panic_on_unrecovered_nmi=1

       manually or (if you want to make that a permanent setting) add

           kernel.panic_on_unrecovered_nmi=1

       in /etc/sysctl.conf.

   Extended crashkernel commandline
       While the "crashkernel=size[@offset]" syntax is sufficient for most
       configurations, sometimes it’s handy to have the reserved memory
       dependent on the value of System RAM — that’s mostly for distributors
       that pre-setup the kernel command line to avoid a unbootable system
       after some memory has been removed from the machine.

       The syntax is:

           crashkernel=<range1>:<size1>[,<range2>:<size2>,...][@offset]
           range=start-[end]

       while start is inclusive and end is exclusive.

       For example:

           crashkernel=512M-2G:64M,2G-:128M

       This would mean:

        1. If the RAM is smaller than 512M, then don’t reserve anything (this
           is the "rescue" case).

        2. If the RAM size is between 512M and 2G (exclusive), then reserve
           64M.

        3. If the RAM size is larger than 2G, then reserve 128M.

BUGS
   Known Problems
       There are known problems when using Kdump on Xen.

        1. Dump filtering does not work. Use a KDUMP_DUMPLEVEL of 0 and set
           KDUMP_DUMPFORMAT to ELF. That are not the default settings, so you
           have to change that settings if you’re using Xen.

   New Bugs
       Please report bugs and enhancement requests at
       https://bugzilla.novell.com.

COPYING
       Copyright (c) 2008 Bernhard Walle <bwalle@suse.de>. Free use of this
       software is granted under the terms of the GNU General Public License
       (GPL), version 2 or later.

SEE ALSO
       kexec(8), kdump(5), makedumpfile(8), crash(8)
       http://en.opensuse.org/Kdump

AUTHOR
       Bernhard Walle <bwalle@suse.de>
           Author.



kdump 0.8.16                      07/04/2017                          KDUMP(7)
