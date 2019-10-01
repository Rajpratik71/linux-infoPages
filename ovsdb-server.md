File: *manpages*,  Node: ovsdb-server,  Up: (dir)

ovsdb-server(1)               Open vSwitch Manual              ovsdb-server(1)



NAME
       ovsdb-server - Open vSwitch database server

SYNOPSIS
       ovsdb-server [database]...  [--remote=remote]...  [--run=command]

       Daemon options:
              [--pidfile[=pidfile]]      [--overwrite-pidfile]      [--detach]
              [--no-chdir] [--no-self-confinement]

       Service options:
              [--service] [--service-monitor]

       Logging options:
              [-v[module[:destination[:level]]]]...
              [--verbose[=module[:destination[:level]]]]...
              [--log-file[=file]]

       Active-backup options:
              [--sync-from=server]     [--sync-exclude-tables=db:table[,db:ta‐
              ble]...]  [--active]

       Public key infrastructure options:
              [--private-key=privkey.pem]
              [--certificate=cert.pem]
              [--ca-cert=cacert.pem]
              [--bootstrap-ca-cert=cacert.pem]
              [--peer-ca-cert=peer-cacert.pem]

       SSL connection options:
              [--ssl-protocols=protocols]
              [--ssl-ciphers=ciphers]

       Runtime management options:
              --unixctl=socket

       Common options:
              [-h | --help] [-V | --version]


DESCRIPTION
       The  ovsdb-server  program  provides RPC interfaces to one or more Open
       vSwitch databases (OVSDBs).  It supports  JSON-RPC  client  connections
       over active or passive TCP/IP or Unix domain sockets.  For an introduc‐
       tion to OVSDB and its implementation in Open vSwitch, see ovsdb(7).

       Each OVSDB file may be specified on the command line as  database.   If
       none  is specified, the default is /etc/openvswitch/conf.db.  The data‐
       base files must already have been created and  initialized  using,  for
       example, ovsdb-tool's create, create-cluster, or join-cluster command.

       This OVSDB implementation supports standalone, active-backup, and clus‐
       tered database service models, as well as  database  replication.   See
       the Service Models section of ovsdb(7) for more information.

       For clustered databases, when the --detach option is used, ovsdb-server
       detaches without waiting for the server to successfully join a  cluster
       (if  the database file is freshly created with ovsdb-tool join-cluster)
       or connect to a cluster that it has already joined.   Use  ovsdb-client
       wait  (see  ovsdb-client(1))  to wait until the server has successfully
       joined and connected to a cluster.

       In addition to user-specified databases, ovsdb-server version  2.9  and
       later  also always hosts a built-in database named _Server.  Please see
       ovsdb-server(5) for documentation on this database's schema.

OPTIONS
       --remote=remote
              Adds remote as a connection method used  by  ovsdb-server.   The
              remote may be an OVSDB active or passive connection method, e.g.
              pssl:6640, as described in ovsdb(7).  The  following  additional
              form is also supported:

              db:db,table,column
                     Reads additional connection methods from column in all of
                     the rows in table within db.  As the contents  of  column
                     changes,  ovsdb-server  also  adds  and  drops connection
                     methods accordingly.

                     If column's type is string or set of  strings,  then  the
                     connection  methods  are  taken directly from the column.
                     The connection methods in the column must have one of the
                     forms described above.

                     If column's type is UUID or set of UUIDs and references a
                     table, then each UUID is looked up in the referenced  ta‐
                     ble  to  obtain a row.  The following columns in the row,
                     if present and of the correct type, configure  a  connec‐
                     tion method.  Any additional columns are ignored.

                     target (string)
                            Connection  method,  in one of the forms described
                            above.  This column is mandatory: if it is missing
                            or  empty then no connection method can be config‐
                            ured.

                     max_backoff (integer)
                            Maximum number of  milliseconds  to  wait  between
                            connection attempts.

                     inactivity_probe (integer)
                            Maximum  number  of  milliseconds  of idle time on
                            connection to client before sending an  inactivity
                            probe message.

                     read_only (boolean)
                            If  true,  only read-only transactions are allowed
                            on this connection.

                     It is an error for column to have another type.

              To connect or listen on multiple connection methods, use  multi‐
              ple --remote options.

       --run=command]
              Ordinarily  ovsdb-server  runs  forever,  or until it is told to
              exit (see RUNTIME MANAGEMENT COMMANDS below).  With this option,
              ovsdb-server  instead starts a shell subprocess running command.
              When the subprocess terminates, ovsdb-server also  exits  grace‐
              fully.   If the subprocess exits normally with exit code 0, then
              ovsdb-server exits with exit code 0 also;  otherwise,  it  exits
              with exit code 1.

              This option can be useful where a database server is needed only
              to    run    a    single     command,     e.g.:     ovsdb-server
              --remote=punix:socket   --run='ovsdb-client   dump   unix:socket
              Open_vSwitch'

              This option is not supported on Windows platform.

   Daemon Options
       The following options are valid on POSIX based platforms.

       --pidfile[=pidfile]
              Causes a file (by default, ovsdb-server.pid) to be created indi‐
              cating  the PID of the running process.  If the pidfile argument
              is not specified, or if it does not begin with  /,  then  it  is
              created in /var/run/openvswitch.

              If --pidfile is not specified, no pidfile is created.

       --overwrite-pidfile
              By  default,  when --pidfile is specified and the specified pid‐
              file  already  exists  and  is  locked  by  a  running  process,
              ovsdb-server  refuses  to start.  Specify --overwrite-pidfile to
              cause it to instead overwrite the pidfile.

              When --pidfile is not specified, this option has no effect.

       --detach
              Runs ovsdb-server as a background process.  The  process  forks,
              and  in  the  child it starts a new session, closes the standard
              file descriptors (which has the side effect of disabling logging
              to  the  console), and changes its current directory to the root
              (unless --no-chdir is specified).  After the child completes its
              initialization,  the  parent  exits.  ovsdb-server detaches only
              after it starts listening on all configured  remotes.   At  this
              point,  all standalone and active-backup databases are ready for
              use.  Clustered databases only become ready for use  after  they
              finish joining their clusters (which could have already happened
              in previous runs of ovsdb-server).

       --monitor
              Creates an additional process to monitor the  ovsdb-server  dae‐
              mon.   If  the daemon dies due to a signal that indicates a pro‐
              gramming error (SIGABRT, SIGALRM, SIGBUS, SIGFPE,  SIGILL,  SIG‐
              PIPE,  SIGSEGV,  SIGXCPU,  or  SIGXFSZ) then the monitor process
              starts a new copy of it.   If  the  daemon  dies  or  exits  for
              another reason, the monitor process exits.

              This  option  is  normally used with --detach, but it also func‐
              tions without it.

       --no-chdir
              By default, when --detach is specified, ovsdb-server changes its
              current  working  directory  to  the  root  directory  after  it
              detaches.  Otherwise, invoking ovsdb-server  from  a  carelessly
              chosen directory would prevent the administrator from unmounting
              the file system that holds that directory.

              Specifying  --no-chdir  suppresses  this  behavior,   preventing
              ovsdb-server  from changing its current working directory.  This
              may be useful for collecting core  files,  since  it  is  common
              behavior  to write core dumps into the current working directory
              and the root directory is not a good directory to use.

              This option has no effect when --detach is not specified.

       --no-self-confinement
              By default daemon will try to self-confine itself to  work  with
              files  under  well-know,  at build-time whitelisted directories.
              It is better to stick with this default behavior and not to  use
              this  flag  unless  some other Access Control is used to confine
              daemon.  Note that in contrast to other access control implemen‐
              tations  that are typically enforced from kernel-space (e.g. DAC
              or MAC), self-confinement is imposed from the user-space  daemon
              itself  and hence should not be considered as a full confinement
              strategy, but instead should be viewed as an additional layer of
              security.

       --user Causes  ovsdb-server  to  run  as  a different user specified in
              "user:group", thus dropping most of the root  privileges.  Short
              forms "user" and ":group" are also allowed, with current user or
              group are assumed respectively. Only daemons started by the root
              user accepts this argument.

              On   Linux,   daemons   will   be   granted   CAP_IPC_LOCK   and
              CAP_NET_BIND_SERVICES before dropping root  privileges.  Daemons
              that  interact  with  a  datapath, such as ovs-vswitchd, will be
              granted three  additional  capabilities,  namely  CAP_NET_ADMIN,
              CAP_NET_BROADCAST  and  CAP_NET_RAW.  The capability change will
              apply even if the new user is root.

              On Windows, this option is not currently supported. For security
              reasons,  specifying  this  option will cause the daemon process
              not to start.

   Service Options
       The following options are valid only on Windows platform.

       --service
              Causes ovsdb-server to run as a service in the  background.  The
              service  should already have been created through external tools
              like SC.exe.

       --service-monitor
              Causes the ovsdb-server service to be automatically restarted by
              the  Windows  services  manager if the service dies or exits for
              unexpected reasons.

              When --service is not specified, this option has no effect.

   Logging Options
       -v[spec]
       --verbose=[spec]
              Sets logging levels.  Without any spec, sets the log  level  for
              every  module and destination to dbg.  Otherwise, spec is a list
              of words separated by spaces or commas or colons, up to one from
              each category below:

              ·      A  valid  module name, as displayed by the vlog/list com‐
                     mand on ovs-appctl(8), limits the log level change to the
                     specified module.

              ·      syslog,  console,  or file, to limit the log level change
                     to only to the system log, to the console, or to a  file,
                     respectively.   (If  --detach  is specified, ovsdb-server
                     closes its standard file descriptors, so logging  to  the
                     console will have no effect.)

                     On  Windows platform, syslog is accepted as a word and is
                     only useful along with the  --syslog-target  option  (the
                     word has no effect otherwise).

              ·      off,  emer,  err,  warn, info, or dbg, to control the log
                     level.  Messages of the given severity or higher will  be
                     logged,  and  messages of lower severity will be filtered
                     out.  off filters out all  messages.   See  ovs-appctl(8)
                     for a definition of each log level.

              Case is not significant within spec.

              Regardless  of  the  log  levels set for file, logging to a file
              will not take place unless --log-file  is  also  specified  (see
              below).

              For compatibility with older versions of OVS, any is accepted as
              a word but has no effect.

       -v
       --verbose
              Sets the maximum logging verbosity level, equivalent  to  --ver‐
              bose=dbg.

       -vPATTERN:destination:pattern
       --verbose=PATTERN:destination:pattern
              Sets  the  log  pattern  for  destination  to pattern.  Refer to
              ovs-appctl(8) for a description of the valid syntax for pattern.

       -vFACILITY:facility
       --verbose=FACILITY:facility
              Sets the RFC5424 facility of the log message.  facility  can  be
              one  of kern, user, mail, daemon, auth, syslog, lpr, news, uucp,
              clock, ftp, ntp, audit, alert, clock2, local0,  local1,  local2,
              local3,  local4, local5, local6 or local7. If this option is not
              specified, daemon is used as the default for  the  local  system
              syslog  and local0 is used while sending a message to the target
              provided via the --syslog-target option.

       --log-file[=file]
              Enables logging to a file.  If file is  specified,  then  it  is
              used  as  the exact name for the log file.  The default log file
              name   used   if   file    is    omitted    is    /var/log/open‐
              vswitch/ovsdb-server.log.

       --syslog-target=host:port
              Send  syslog  messages  to  UDP port on host, in addition to the
              system syslog.  The host must be a numerical IP address,  not  a
              hostname.

       --syslog-method=method
              Specify method how syslog messages should be sent to syslog dae‐
              mon.  Following forms are supported:

              ·      libc, use libc syslog() function.  Downside of using this
                     options  is  that libc adds fixed prefix to every message
                     before it is actually sent  to  the  syslog  daemon  over
                     /dev/log UNIX domain socket.

              ·      unix:file, use UNIX domain socket directly.  It is possi‐
                     ble to specify arbitrary message format with this option.
                     However,  rsyslogd  8.9 and older versions use hard coded
                     parser function anyway that  limits  UNIX  domain  socket
                     use.   If  you  want to use arbitrary message format with
                     older rsyslogd versions, then use UDP socket to localhost
                     IP address instead.

              ·      udp:ip:port, use UDP socket.  With this method it is pos‐
                     sible to use arbitrary message  format  also  with  older
                     rsyslogd.   When  sending syslog messages over UDP socket
                     extra precaution needs to  be  taken  into  account,  for
                     example,  syslog  daemon needs to be configured to listen
                     on the specified  UDP  port,  accidental  iptables  rules
                     could  be interfering with local syslog traffic and there
                     are some security considerations that apply to UDP  sock‐
                     ets, but do not apply to UNIX domain sockets.

              ·      null, discards all messages logged to syslog.

              The  default  is  taken  from  the OVS_SYSLOG_METHOD environment
              variable; if it is unset, the default is libc.

   Active-Backup Options
       These options support the ovsdb-server active-backup service model  and
       database  replication.   These  options  apply only to databases in the
       format used for standalone and active-backup databases,  which  is  the
       database  format  created  by  ovsdb-tool  create.  By default, when it
       serves a database in this format, ovsdb-server  runs  as  a  standalone
       server.  These options can configure it for active-backup use:

       ·      Use  --sync-from=server  to start the server in the backup role,
              replicating data from server.  When ovsdb-server is running as a
              backup  server,  it rejects all transactions that can modify the
              database content, including lock commands.  The same form can be
              used to configure the local database as a replica of server.

       ·      Use  --sync-from=server  --active  to  start  the  server in the
              active role, but prepared to switch to the backup role in  which
              it  would replicate data from server.  When ovsdb-server runs in
              active mode, it allows all transactions,  including  those  that
              modify the database.

       At  runtime,  management commands can change a server's role and other‐
       wise manage active-backup features.  See Active-Backup Commands, below,
       for more information.

       --sync-from=server
              Sets up ovsdb-server to synchronize its databases with the data‐
              bases in server, which must be an active  connection  method  in
              one  of the forms documented in ovsdb-client(1).  Every transac‐
              tion committed by server will  be  replicated  to  ovsdb-server.
              This  option  makes  ovsdb-server  start as a backup server; add
              --active to make it start as an active server.

       --sync-exclude-tables=db:table[,db:table]...
              Causes the specified tables to be excluded from replication.

       --active
              By default, --sync-from makes ovsdb-server start up as a  backup
              for  server.   With --active, however, ovsdb-server starts as an
              active server.  Use this option to allow the syncing options  to
              be  specified  using command line options, yet start the server,
              as the default, active server.  To switch the running server  to
              backup  mode, use ovs-appctl(1) to execute the ovsdb-server/con‐
              nect-active-ovsdb-server command.

   Public Key Infrastructure Options
       The options described below for configuring the SSL public  key  infra‐
       structure  accept  a  special  syntax for obtaining their configuration
       from the database.  If any of these options is given db:db,table,column
       as  its  argument, then the actual file name is read from the specified
       column in table within the db database.   The  column  must  have  type
       string  or  set  of strings.  The first nonempty string in the table is
       taken as the file name.  (This means that ordinarily there should be at
       most one row in table.)

       -p privkey.pem
       --private-key=privkey.pem
              Specifies  a  PEM  file  containing  the  private  key  used  as
              ovsdb-server's identity for outgoing SSL connections.

       -c cert.pem
       --certificate=cert.pem
              Specifies a PEM file containing a certificate that certifies the
              private  key specified on -p or --private-key to be trustworthy.
              The certificate must be signed by the certificate authority (CA)
              that the peer in SSL connections will use to verify it.

       -C cacert.pem
       --ca-cert=cacert.pem
              Specifies   a  PEM  file  containing  the  CA  certificate  that
              ovsdb-server should use to verify certificates presented  to  it
              by  SSL peers.  (This may be the same certificate that SSL peers
              use to verify the certificate specified on -c or  --certificate,
              or  it  may  be  a different one, depending on the PKI design in
              use.)

       -C none
       --ca-cert=none
              Disables verification of certificates presented  by  SSL  peers.
              This  introduces a security risk, because it means that certifi‐
              cates cannot be verified to be those of known trusted hosts.

       --bootstrap-ca-cert=cacert.pem
              When cacert.pem exists, this option has the same effect as -C or
              --ca-cert.  If it does not exist, then ovsdb-server will attempt
              to obtain the CA certificate from the SSL peer on its first  SSL
              connection and save it to the named PEM file.  If it is success‐
              ful, it will immediately drop the connection and reconnect,  and
              from then on all SSL connections must be authenticated by a cer‐
              tificate signed by the CA certificate thus obtained.

              This option exposes the SSL connection  to  a  man-in-the-middle
              attack  obtaining the initial CA certificate, but it may be use‐
              ful for bootstrapping.

              This option is only useful if the SSL peer sends its CA certifi‐
              cate  as  part  of  the SSL certificate chain.  The SSL protocol
              does not require the server to send the CA certificate.

              This option is mutually exclusive with -C and --ca-cert.

       --peer-ca-cert=peer-cacert.pem
              Specifies a PEM file that contains one or more  additional  cer‐
              tificates  to  send to SSL peers.  peer-cacert.pem should be the
              CA certificate used to sign ovsdb-server's own certificate, that
              is,  the  certificate  specified  on  -c  or  --certificate.  If
              ovsdb-server's certificate is  self-signed,  then  --certificate
              and --peer-ca-cert should specify the same file.

              This  option  is not useful in normal operation, because the SSL
              peer must already have the CA certificate for the peer  to  have
              any confidence in ovsdb-server's identity.  However, this offers
              a way for a new installation to bootstrap the CA certificate  on
              its first SSL connection.

   SSL Connection Options
       --ssl-protocols=protocols
              Specifies,  in  a comma- or space-delimited list, the SSL proto‐
              cols ovsdb-server will enable for  SSL  connections.   Supported
              protocols  include  TLSv1,  TLSv1.1, and TLSv1.2.  Regardless of
              order, the highest protocol supported by both sides will be cho‐
              sen when making the connection.  The default when this option is
              omitted is TLSv1,TLSv1.1,TLSv1.2.

       --ssl-ciphers=ciphers
              Specifies,  in  OpenSSL  cipher  string  format,   the   ciphers
              ovsdb-server will support for SSL connections.  The default when
              this option is omitted is HIGH:!aNULL:!MD5.

   Other Options
       --unixctl=socket
              Sets the name of the control socket on which  ovsdb-server  lis‐
              tens  for  runtime  management  commands (see RUNTIME MANAGEMENT
              COMMANDS, below).  If socket does not begin with /, it is inter‐
              preted as relative to /var/run/openvswitch.  If --unixctl is not
              used   at   all,   the   default   socket   is    /var/run/open‐
              vswitch/ovsdb-server.pid.ctl,   where   pid   is  ovsdb-server's
              process ID.

              On Windows a local named pipe is used to listen for runtime man‐
              agement  commands.   A  file  is created in the absolute path as
              pointed by socket or if --unixctl is not used at all, a file  is
              created  as ovsdb-server.ctl in the configured OVS_RUNDIR direc‐
              tory.  The file exists just to mimic  the  behavior  of  a  Unix
              domain socket.

              Specifying none for socket disables the control socket feature.

       -h
       --help Prints a brief help message to the console.

       -V
       --version
              Prints version information to the console.

RUNTIME MANAGEMENT COMMANDS
       ovs-appctl(8) can send commands to a running ovsdb-server process.  The
       currently supported commands are described below.

   ovsdb-server Commands
       These commands are specific to ovsdb-server.

       exit   Causes ovsdb-server to gracefully terminate.

       ovsdb-server/compact [db]
              Compacts database db in-place.  If db is not specified, compacts
              every database in-place.  A database is also compacted automati‐
              cally when a transaction is logged if it  is  over  2  times  as
              large  as  its previous compacted size (and at least 10 MB), but
              not before 100 commits  have  been  added  or  10  minutes  have
              elapsed  since  the  last  compaction. It will also be compacted
              automatically after 24 hours since the last  compaction  if  100
              commits were added regardless of its size.

       ovsdb-server/reconnect
              Makes ovsdb-server drop all of the JSON-RPC connections to data‐
              base clients and reconnect.

              This command might be useful for debugging issues with  database
              clients.

       ovsdb-server/add-remote remote
              Adds  a  remote, as if --remote=remote had been specified on the
              ovsdb-server command line.  (If remote is already a remote, this
              command succeeds without changing the configuration.)

       ovsdb-server/remove-remote remote
              Removes  the  specified  remote  from the configuration, failing
              with an error if remote is not configured  as  a  remote.   This
              command  only  works with remotes that were named on --remote or
              ovsdb-server/add-remote, that is, it  will  not  remove  remotes
              added  indirectly  because  they  were read from the database by
              configuring a db:db,table,column  remote.   (You  can  remove  a
              database source with ovsdb-server/remove-remote db:db,table,col‐
              umn, but not individual remotes  found  indirectly  through  the
              database.)

       ovsdb-server/list-remotes
              Outputs  a  list  of  the  currently configured remotes named on
              --remote or ovsdb-server/add-remote, that is, it does  not  list
              remotes  added  indirectly because they were read from the data‐
              base by configuring a db:db,table,column remote.

       ovsdb-server/add-db database
              Adds the database to the  running  ovsdb-server.   The  database
              file  must  already have been created and initialized using, for
              example, ovsdb-tool create.

       ovsdb-server/remove-db database
              Removes database from the running ovsdb-server.   database  must
              be a database name as listed by ovsdb-server/list-dbs.

              If  a  remote  has  been configured that points to the specified
              database (e.g. --remote=db:database,... on  the  command  line),
              then  it  will  be disabled until another database with the same
              name is added again (with ovsdb-server/add-db).

              Any public key infrastructure  options  specified  through  this
              database  (e.g.  --private-key=db:database,...  on  the  command
              line) will be disabled until another database with the same name
              is added again (with ovsdb-server/add-db).

       ovsdb-server/list-dbs
              Outputs  a  list  of  the  currently  configured databases added
              either   through   the   command    line    or    through    the
              ovsdb-server/add-db command.

   Active-Backup Commands
       These  commands  query  and  update  the role of ovsdb-server within an
       active-backup pair of servers.  See Active-Backup Options,  above,  and
       Active-Backup Database Service Model in ovsdb(7) for more information.

       ovsdb-server/set-active-ovsdb-server server
              Sets  the active server from which ovsdb-server connects through
              ovsdb-server/connect-active-ovsdb-server.   This  overrides  the
              --sync-from command-line option.

       ovsdb-server/get-active-ovsdb-server
              Gets the active server from which ovsdb-server is currently syn‐
              chronizing its databases.

       ovsdb-server/connect-active-ovsdb-server
              Switches the server to a backup role.  The  server  starts  syn‐
              chronizing  its  databases  with  the active server specified by
              ovsdb-server/set-active-ovsdb-server (or  the  --sync-from  com‐
              mand-line  option)  and  closes all existing client connections,
              which requires clients to reconnect.

       ovsdb-server/disconnect-active-ovsdb-server
              Switches the server to an active role.  The  server  stops  syn‐
              chronizing  its  databases  with an active server and closes all
              existing client connections, which requires  clients  to  recon‐
              nect.

       ovsdb-server/set-sync-exclude-tables db:table[,db:table]...
              Sets the table within db that will be excluded from synchroniza‐
              tion.  This  overrides  the  --sync-exclude-tables  command-line
              option.

       ovsdb-server/get-sync-exclude-tables
              Gets  the  tables  that are currently excluded from synchroniza‐
              tion.

       ovsdb-server/sync-status
              Prints a summary of replication run time information. The  state
              information is always provided, indicating whether the server is
              running in the active or  the  backup  mode.   When  running  in
              backup  mode, replication connection status, which can be either
              connecting, replicating or error, are shown.  When  the  connec‐
              tion  is  in replicating state, further output shows the list of
              databases  currently  replicating,  and  the  tables  that   are
              excluded.

   Cluster Commands
       These  commands support the ovsdb-server clustered service model.  They
       apply only to databases in the format  used  for  clustered  databases,
       which  is  the database format created by ovsdb-tool create-cluster and
       ovsdb-tool join-cluster.

       cluster/cid db
              Prints the cluster ID for db, which is a  UUID  that  identifies
              the  cluster.   If  db is a database newly created by ovsdb-tool
              cluster-join that has not yet successfully joined  its  cluster,
              and  --cid  was  not specified on the cluster-join command line,
              then this command will report an error because the cluster ID is
              not yet known.

       cluster/sid db
              Prints  the  server  ID  for db, which is a UUID that identifies
              this server within the cluster.

       cluster/status db
              Prints this server's status within the cluster and the status of
              its connections to other servers in the cluster.

       cluster/leave db
              This  command  starts the server gracefully removing itself from
              its cluster.  At least one server must remain, and  the  cluster
              must  be  healthy,  that  is, over half of the cluster's servers
              must be up.

              When the server successfully leaves the cluster, it stops  serv‐
              ing db, as if ovsdb-server/remove-db db had been executed.

              Use  ovsdb-client  wait  (see ovsdb-client(1)) to wait until the
              server has left the cluster.

              Once a  server  leaves  a  cluster,  it  may  never  rejoin  it.
              Instead, create a new server and join it to the cluster.

       cluster/kick db server
              Start  graceful  removal of server from db's cluster, like clus‐
              ter/leave (without  --force)  except  that  it  can  remove  any
              server, not just this one.

              server  may  be  a  server ID, as printed by cluster/sid, or the
              server's local network address as passed  to  ovsdb-tool's  cre‐
              ate-cluster  or join-cluster command.  Use cluster/status to see
              a list of cluster members.

   VLOG COMMANDS
       These commands manage ovsdb-server's logging settings.

       vlog/set [spec]
              Sets logging levels.  Without any spec, sets the log  level  for
              every  module and destination to dbg.  Otherwise, spec is a list
              of words separated by spaces or commas or colons, up to one from
              each category below:

              ·      A  valid  module name, as displayed by the vlog/list com‐
                     mand on ovs-appctl(8), limits the log level change to the
                     specified module.

              ·      syslog,  console,  or file, to limit the log level change
                     to only to the system log, to the console, or to a  file,
                     respectively.

                     On  Windows platform, syslog is accepted as a word and is
                     only useful along with the  --syslog-target  option  (the
                     word has no effect otherwise).

              ·      off,  emer,  err,  warn, info, or dbg, to control the log
                     level.  Messages of the given severity or higher will  be
                     logged,  and  messages of lower severity will be filtered
                     out.  off filters out all  messages.   See  ovs-appctl(8)
                     for a definition of each log level.

              Case is not significant within spec.

              Regardless  of  the  log  levels set for file, logging to a file
              will not take place unless ovsdb-server  was  invoked  with  the
              --log-file option.

              For compatibility with older versions of OVS, any is accepted as
              a word but has no effect.

       vlog/set PATTERN:destination:pattern
              Sets the log pattern  for  destination  to  pattern.   Refer  to
              ovs-appctl(8) for a description of the valid syntax for pattern.

       vlog/list
              Lists the supported logging modules and their current levels.

       vlog/list-pattern
              Lists logging patterns used for each destination.

       vlog/close
              Causes  ovsdb-server to close its log file, if it is open.  (Use
              vlog/reopen to reopen it later.)

       vlog/reopen
              Causes ovsdb-server to close its log file, if it  is  open,  and
              then  reopen  it.   (This is useful after rotating log files, to
              cause a new log file to be used.)

              This has no effect unless  ovsdb-server  was  invoked  with  the
              --log-file option.

       vlog/disable-rate-limit [module]...
       vlog/enable-rate-limit [module]...
              By  default,  ovsdb-server limits the rate at which certain mes‐
              sages can be logged.  When a  message  would  appear  more  fre‐
              quently  than  the  limit,  it  is  suppressed.  This saves disk
              space, makes logs easier to read, and speeds up  execution,  but
              occasionally  troubleshooting  requires more detail.  Therefore,
              vlog/disable-rate-limit allows rate limits to be disabled at the
              level  of  an individual log module.  Specify one or more module
              names, as displayed by the vlog/list command.  Specifying either
              no  module  names at all or the keyword any disables rate limits
              for every log module.

              The vlog/enable-rate-limit command, whose syntax is the same  as
              vlog/disable-rate-limit,  can  be used to re-enable a rate limit
              that was previously disabled.

   MEMORY COMMANDS
       These commands report memory usage.

       memory/show
              Displays  some  basic  statistics  about  ovsdb-server's  memory
              usage.   ovsdb-server  also  logs  this  information  soon after
              startup and periodically as its memory consumption grows.

   COVERAGE COMMANDS
       These commands manage ovsdb-server's ``coverage counters,'' which count
       the  number of times particular events occur during a daemon's runtime.
       In addition to these commands, ovsdb-server automatically logs coverage
       counter  values,  at INFO level, when it detects that the daemon's main
       loop takes unusually long to run.

       Coverage counters are useful mainly for performance analysis and debug‐
       ging.

       coverage/show
              Displays the averaged per-second rates for the last few seconds,
              the last minute and the last hour, and the total counts  of  all
              of the coverage counters.

BUGS
       In  Open  vSwitch  before  version 2.4, when ovsdb-server sent JSON-RPC
       error responses to some requests, it incorrectly formulated  them  with
       the result and error swapped, so that the response appeared to indicate
       success (with a nonsensical result) rather than an error.  The requests
       that suffered from this problem were:

       transact
       get_schema
              Only if the request names a nonexistent database.

       monitor
       lock
       unlock In all error cases.

       Of  these  cases,  the  only  error  that a well-written application is
       likely to encounter in practice is monitor of tables or columns that do
       not  exist, in an situation where the application has been upgraded but
       the old database schema is still temporarily in use.   To  handle  this
       situation  gracefully, we recommend that clients should treat a monitor
       response with a result that contains an  error  key-value  pair  as  an
       error  (assuming  that  the database being monitored does not contain a
       table named error).

SEE ALSO
       ovsdb(7), ovsdb-tool(1), ovsdb-server(5), ovsdb-server(7).



Open vSwitch                        2.11.0                     ovsdb-server(1)
ovsdb-server(5)               Open vSwitch Manual              ovsdb-server(5)



NAME
       ovsdb-server - _Server database schema

       Every  ovsdb-server  (version 2.9 or later) always hosts an instance of
       this schema, which holds information on the status and configuration of
       the  server  itself. This database is read-only. This manpage describes
       the schema for this database.

TABLE SUMMARY
       The following list summarizes the purpose of each of the tables in  the
       _Server  database.   Each  table is described in more detail on a later
       page.

       Table     Purpose
       Database  Databases.

Database TABLE
       This table describes the databases hosted by the database server,  with
       one row per database. As its database configuration and status changes,
       the server automatically and immediately updates the table to match.

       The OVSDB protocol specified in RFC 7047 does not provide a way for  an
       OVSDB  client  to  find  out about some kinds of configuration changes,
       such as about databases added or removed while a client is connected to
       the  server, or databases changing between read/write and read-only due
       to a transition between active and backup roles. This table provides  a
       solution:  clients  can  monitor the table’s contents to find out about
       important changes.

       Traditionally, ovsdb-server disconnects all of its clients when a  sig‐
       nificant configuration change occurs, because this prompts a well-writ‐
       ten client to reassess what is available from the server when it recon‐
       nects.  Because  this  table provides an alternative and more efficient
       way to find out about  those  changes,  OVS  2.9  also  introduces  the
       set_db_change_aware   RPC,  documented  in  ovsdb-server(7),  to  allow
       clients to suppress this disconnection behavior.

       When a database is removed from the server, in addition to Database ta‐
       ble  updates,  the  server sends canceled messages, as described in RFC
       7047 section 4.1.4,  in  reply  to  outstanding  transactions  for  the
       removed  database.  The  server also cancels any outstanding monitoring
       initiated by monitor or monitor_cond requested on the removed database,
       sending  the  monitor_canceled  RPC  described in ovsdb-server(7). Only
       clients that disable  disconnection  with  set_db_change_aware  receive
       these messages.

       Clients  can use the _uuid column in this table as a generation number.
       The server generates a fresh _uuid every time it adds  a  database,  so
       that  removing  and  then re-adding a database to the server causes its
       row _uuid to change.

   Summary:
       name                          string
       model                         string, either clustered or standalone
       schema                        optional string
       Clustered Databases:
         connected                   boolean
         leader                      boolean
         cid                         optional uuid
         sid                         optional uuid
         index                       optional integer

   Details:
       name: string
              The database’s name, as specified in its schema.

       model: string, either clustered or standalone
              The storage model: standalone for a standalone or  active-backup
              database, clustered for a clustered database.

       schema: optional string
              The  database  schema,  as a JSON string. In the case of a clus‐
              tered database, this is empty  until  it  finishes  joining  its
              cluster.

     Clustered Databases:

       These  columns are most interesting and in some cases only relevant for
       clustered databases, that is, those where the  model  column  is  clus‐
       tered.

       connected: boolean
              True  if  the database is connected to its storage. A standalone
              or active-backup database is always connected. A clustered data‐
              base is connected if the server is in contact with a majority of
              its cluster. An unconnected database cannot be modified and  its
              data might be unavailable or stale.

       leader: boolean
              True  if the database is the leader in its cluster. For a stand‐
              alone or active-backup database, this is always true.

       cid: optional uuid
              The cluster ID for this database, which is the same for  all  of
              the  servers that host this particular clustered database. For a
              standalone or active-backup database, this is empty.

       sid: optional uuid
              The server ID for this database, different for each server  that
              hosts  a particular clustered database. A server that hosts more
              than one clustered database will have a different  sid  in  each
              one. For a standalone or active-backup database, this is empty.

       index: optional integer
              For  a  clustered database, the index of the log entry currently
              exposed to clients. For a given server, this increases monotoni‐
              cally.  When  a  client switches from one server to another in a
              cluster, it can ensure that it never sees an older  snapshot  of
              data  by  avoiding servers that have index less than the largest
              value they have already observed.

              For a standalone or active-backup database, this is empty.



Open vSwitch 2.11.0             DB Schema 1.1.0                ovsdb-server(5)
OVSDB-SERVER(7)                  Open vSwitch                  OVSDB-SERVER(7)



NAME
       ovsdb-server - Open vSwitch Database Server Protocol

DESCRIPTION
       ovsdb-server  implements  the  Open  vSwitch  Database (OVSDB) protocol
       specified in RFC 7047.  This document provides clarifications  for  how
       ovsdb-server  implements the protocol and describes the extensions that
       it provides beyond RFC 7047.  Numbers in section headings refer to cor‐
       responding sections in RFC 7047.

   3.1 JSON Usage
       RFC  4627  says  that names within a JSON object should be unique.  The
       Open vSwitch JSON parser discards all but the last  value  for  a  name
       that is specified more than once.

       The  definition  of <error> allows for implementation extensions.  Cur‐
       rently ovsdb-server uses the following additional error strings  (which
       might change in later releases):

       syntax error or unknown column
              The  request  could not be parsed as an OVSDB request.  An addi‐
              tional syntax member, whose value  is  a  string  that  contains
              JSON,  may  narrow  down the particular syntax that could not be
              parsed.

       internal error
              The request triggered a bug in ovsdb-server.

       ovsdb error
              A map or set contains a duplicate key.

       permission error
              The request was denied by the role-based access  control  exten‐
              sion, introduced in version 2.8.

   3.2 Schema Format
       RFC 7047 requires the version field in <database-schema>.  Current ver‐
       sions of ovsdb-server allow it  to  be  omitted  (future  versions  are
       likely to require it).

       RFC  7047  allows columns that contain weak references to be immutable.
       This raises the issue of the behavior of the weak  reference  when  the
       rows  that  it references are deleted.  Since version 2.6, ovsdb-server
       forces columns that contain weak references to be mutable.

       Since version 2.8, the table name RBAC_Role is used internally  by  the
       role-based  access  control extension to ovsdb-server and should not be
       used for purposes other than defining mappings of role names  to  table
       access  permissions.  This table has one row per role name and the fol‐
       lowing columns:

       name   The role name.

       permissions
              A map of table name to a reference to a row in a  separate  per‐
              mission table.

       The  separate RBAC permission table has one row per access control con‐
       figuration and the following columns:

       name   The name of the table to which the row applies.

       authorization
              The set of column names and column:key pairs to be compared with
              the  client ID in order to determine the authorization status of
              the requested operation.

       insert_delete
              A boolean value, true if authorized insertions and deletions are
              allowed, false if no insertions or deletions are allowed.

       update The  set  of  columns  and column:key pairs for which authorized
              update and mutate operations should be permitted.

   4 Wire Protocol
       The original OVSDB specifications included the following reasons, omit‐
       ted  from  RFC 7047, to operate JSON-RPC directly over a stream instead
       of over HTTP:

       · JSON-RPC is a peer-to-peer protocol, but HTTP is a client-server pro‐
         tocol,  which is a poor match.  Thus, JSON-RPC over HTTP requires the
         client to periodically poll the server to receive server requests.

       · HTTP is more complicated than stream connections and doesn’t  provide
         any corresponding advantage.

       · The JSON-RPC specification for HTTP transport is incomplete.

   4.1.3 Transact
       Since  version 2.8, role-based access controls can be applied to opera‐
       tions within a transaction that would modify the contents of the  data‐
       base  (these  operations include row insert, row delete, column update,
       and column mutate). Role-based access controls  are  applied  when  the
       database  schema  contains a table with the name RBAC_Role and the con‐
       nection on which the transaction request was received has an associated
       role  name  (from the role column in the remote connection table). When
       role-based access controls are enabled, transactions that are otherwise
       well-formed may be rejected depending on the client’s role, ID, and the
       contents of the RBAC_Role table and associated permissions table.

   4.1.5 Monitor
       For backward compatibility, ovsdb-server  currently  permits  a  single
       <monitor-request>  to  be  used instead of an array; it is treated as a
       single-element array.  Future versions  of  ovsdb-server  might  remove
       this compatibility feature.

       Because  the  <json-value> parameter is used to match subsequent update
       notifications (see below) to the request, it must be unique  among  all
       active  monitors.   ovsdb-server rejects attempt to create two monitors
       with the same identifier.

   4.1.7 Monitor Cancellation
       When a database monitored by a session is removed, and database  change
       awareness is enabled for the session (see Section 4.1.16), the database
       server spontaneously cancels all monitors (including conditional  moni‐
       tors  described  in Section 4.1.12) for the removed database.  For each
       canceled monitor, it issues a notification in the following form:

          "method": "monitor_canceled"
          "params": [<json-value>]
          "id": null

   4.1.12 Monitor_cond
       A new monitor method added in Open  vSwitch  version  2.6.   The  moni‐
       tor_cond request enables a client to replicate subsets of tables within
       an OVSDB database by requesting notifications of changes to rows match‐
       ing one of the conditions specified in where by receiving the specified
       contents of these rows when table  updates  occur.   monitor_cond  also
       allows   a  more  efficient  update  notifications  by  receiving  <ta‐
       ble-updates2> notifications (described below).

       The monitor method described in Section 4.1.5  also  applies  to  moni‐
       tor_cond, with the following exceptions:

       · RPC request method becomes monitor_cond.

       · Reply result follows <table-updates2>, described in Section 4.1.14.

       · Subsequent  changes  are sent to the client using the update2 monitor
         notification, described in Section 4.1.14

       · Update notifications are being sent only for rows  matching  [<condi‐
         tion>*].

       The request object has the following members:

          "method": "monitor_cond"
          "params": [<db-name>, <json-value>, <monitor-cond-requests>]
          "id": <nonnull-json-value>

       The <json-value> parameter is used to match subsequent update notifica‐
       tions (see below) to this request.  The <monitor-cond-requests>  object
       maps the name of the table to an array of <monitor-cond-request>.

       Each <monitor-cond-request> is an object with the following members:

          "columns": [<column>*]            optional
          "where": [<condition>*]           optional
          "select": <monitor-select>        optional

       The columns, if present, define the columns within the table to be mon‐
       itored that match conditions.  If not present, all  columns  are  moni‐
       tored.

       The  where, if present, is a JSON array of <condition> and boolean val‐
       ues.  If not present or condition is an empty array, implicit True will
       be considered and updates on all rows will be sent.

       <monitor-select> is an object with the following members:

          "initial": <boolean>              optional
          "insert": <boolean>               optional
          "delete": <boolean>               optional
          "modify": <boolean>               optional

       The  contents of this object specify how the columns or table are to be
       monitored as explained in more detail below.

       The response object has the following members:

          "result": <table-updates2>
          "error": null
          "id": same "id" as request

       The <table-updates2> object is described in detail in  Section  4.1.14.
       It  contains  the  contents  of  the  tables for which initial rows are
       selected.  If no tables initial contents are requested, then result  is
       an empty object.

       Subsequently,  when  changes to a specified table that match one of the
       conditions in <monitor-cond-request> are  committed,  the  changes  are
       automatically sent to the client using the update2 monitor notification
       (see Section 4.1.14).  This monitoring persists until the JSON-RPC ses‐
       sion  terminates  or  until  the client sends a monitor_cancel JSON-RPC
       request.

       Each <monitor-cond-request> specifies one or more  conditions  and  the
       manner in which the rows that match the conditions are to be monitored.
       The circumstances in which an update notification is  sent  for  a  row
       within the table are determined by <monitor-select>:

       · If  initial  is omitted or true, every row in the original table that
         matches one of the conditions is sent as part of the response to  the
         monitor_cond request.

       · If  insert is omitted or true, update notifications are sent for rows
         newly inserted into the table that match conditions or for rows modi‐
         fied in the table so that their old version does not match the condi‐
         tion and new version does.

       · If delete is omitted or true, update notifications are sent for  rows
         deleted  from the table that match conditions or for rows modified in
         the table so that their old version does match the conditions and new
         version does not.

       · If  modify is omitted or true, update notifications are sent whenever
         a row in the table that matches conditions in both old and  new  ver‐
         sion is modified.

       Both monitor and monitor_cond sessions can exist concurrently. However,
       monitor and monitor_cond shares the same <json-value> parameter  space;
       it must be unique among all monitor and monitor_cond sessions.

   4.1.13 Monitor_cond_change
       The  monitor_cond_change request enables a client to change an existing
       monitor_cond replication of the database by specifying a new  condition
       and  columns for each replicated table.  Currently changing the columns
       set is not supported.

       The request object has the following members:

          "method": "monitor_cond_change"
          "params": [<json-value>, <json-value>, <monitor-cond-update-requests>]
          "id": <nonnull-json-value>

       The <json-value> parameter should have a value of  an  existing  condi‐
       tional  monitoring session from this client. The second <json-value> in
       params array is the requested value for this  session.  This  value  is
       valid only after monitor_cond_change is committed. A user can use these
       values to distinguish between update messages before conditions  update
       and  after.  The <monitor-cond-update-requests> object maps the name of
       the table to  an  array  of  <monitor-cond-update-request>.   Monitored
       tables not included in <monitor-cond-update-requests> retain their cur‐
       rent conditions.

       Each <monitor-cond-update-request> is an object with the following mem‐
       bers:

          "columns": [<column>*]         optional
          "where": [<condition>*]        optional

       The  columns  specify  a new array of columns to be monitored, although
       this feature is not yet supported.

       The where specify a new array of conditions to be applied to this moni‐
       toring session.

       The response object has the following members:

          "result": null
          "error": null
          "id": same "id" as request

       Subsequent  <table-updates2>  notifications  are described in detail in
       Section 4.1.14 in the RFC.  If insert contents are requested by  origi‐
       nal monitor_cond request, <table-updates2> will contain rows that match
       the new condition and do not match the old condition.  If deleted  con‐
       tents  are  requested  by origin monitor request, <table-updates2> will
       contain any matched rows by old condition and not matched  by  the  new
       condition.

       Changes  according  to the new conditions are automatically sent to the
       client using the update2 monitor notification.  An update, if any, as a
       result  of  a  condition  change, will be sent to the client before the
       reply to the monitor_cond_change request.

   4.1.14 Update2 notification
       The update2 notification is sent by the server to the client to  report
       changes  in  tables  that  are being monitored following a monitor_cond
       request as described above. The notification has the following members:

          "method": "update2"
          "params": [<json-value>, <table-updates2>]
          "id": null

       The <json-value> in params is the same  as  the  value  passed  as  the
       <json-value>  in  params  for  the corresponding monitor request.  <ta‐
       ble-updates2> is an object that maps  from  a  table  name  to  a  <ta‐
       ble-update2>.  A <table-update2> is an object that maps from row’s UUID
       to a <row-update2> object. A <row-update2> is an object with one of the
       following members:

       "initial": <row>
              present for initial updates

       "insert": <row>
              present for insert updates

       "delete": <row>
              present for delete updates

       "modify": <row>"
              present for modify updates

       The format of <row> is described in Section 5.1.

       <row>  is  always  a  null  object for a delete update.  In initial and
       insert updates, <row> omits columns  whose  values  equal  the  default
       value of the column type.

       For a modify update, <row> contains only the columns that are modified.
       <row> stores the difference between the old and  new  value  for  those
       columns, as described below.

       For  columns  with single value, the difference is the value of the new
       column.

       The difference between two sets are all elements that  only  belong  to
       one of the sets.

       The  difference  between  two  maps  are all key-value pairs whose keys
       appears in only one of the maps, plus the key-value  pairs  whose  keys
       appear  in  both  maps  but with different values.  For the latter ele‐
       ments, <row> includes the value from the new column.

       Initial views of rows are not presented in update2  notifications,  but
       in  the response object to the monitor_cond request.  The formatting of
       the <table-updates2> object, however, is the same in either case.

   4.1.15 Get Server ID
       A new RPC method added in Open vSwitch version 2.7.  The  request  con‐
       tains the following members:

          "method": "get_server_id"
          "params": null
          "id": <nonnull-json-value>

       The response object contains the following members:

          "result": "<server_id>"
          "error": null
          "id": same "id" as request

       <server_id>  is  JSON string that contains a UUID that uniquely identi‐
       fies the running OVSDB server process.  A fresh UUID is generated  when
       the process restarts.

   4.1.16 Database Change Awareness
       RFC  7047  does  not  provide a way for a client to find out about some
       kinds of configuration  changes,  such  as  about  databases  added  or
       removed  while a client is connected to the server, or databases chang‐
       ing between read/write and read-only due to a transition between active
       and  backup  roles.  Traditionally, ovsdb-server disconnects all of its
       clients when this happens, because this prompts a  well-written  client
       to reassess what is available from the server when it reconnects.

       OVS  2.9  provides  a  way  for clients to keep track of these kinds of
       changes, by monitoring the  Database  table  in  the  _Server  database
       introduced  in  this  release  (see  ovsdb-server(5)  for details).  By
       itself, this does not  suppress  ovsdb-server  disconnection  behavior,
       because  a client might monitor this database without understanding its
       special semantics.  Instead, ovsdb-server provides a special request:

          "method": "set_db_change_aware"
          "params": [<boolean>]
          "id": <nonnull-json-value>

       If the boolean in the  request  is  true,  it  suppresses  the  connec‐
       tion-closing  behavior  for  the current connection, and false restores
       the default behavior.  The reply is always the same:

          "result": {}
          "error": null
          "id": same "id" as request

   4.1.17 Schema Conversion
       Open vSwitch 2.9 adds a new JSON-RPC request to convert an online data‐
       base  from  one  schema to another.  The request contains the following
       members:

          "method": "convert"
          "params": [<db-name>, <database-schema>]
          "id": <nonnull-json-value>

       Upon receipt, the server converts database <db-name> to  schema  <data‐
       base-schema>.   The schema’s name must be <db-name>.  The conversion is
       atomic, consistent, isolated, and durable.  The data  in  the  database
       must  be  valid when interpreted under <database-schema>, with only one
       exception: data for tables and columns that do not  exist  in  the  new
       schema are ignored.  Columns that exist in <database-schema> but not in
       the database are set to their default values.  All of the new  schema’s
       constraints apply in full.

       If  the  conversion is successful, the server notifies clients that use
       the set_db_change_aware RPC introduced in Open vSwitch 2.9 and  cancels
       their  outstanding  transactions  and monitors.  The server disconnects
       other clients, enabling them to notice the change when they  reconnect.
       The server sends the following reply:

          "result": {}
          "error": null
          "id": same "id" as request

       If  the  conversion  fails, then the server sends an error reply in the
       following form:

          "result": null
          "error": [<error>]
          "id": same "id" as request

   5.1 Notation
       For <condition>, RFC 7047 only allows the use of !=, ==, includes,  and
       excludes  operators  with set types.  Open vSwitch 2.4 and later extend
       <condition> to allow the use of <, <=, >=, and > operators with a  col‐
       umn with type “set of 0 or 1 integer” and an integer argument, and with
       “set of 0 or 1 real” and a real argument.  These conditions evaluate to
       false  when the column is empty, and otherwise as described in RFC 7047
       for integer and real types.

       <condition> is specified in Section 5.1 in the RFC with  the  following
       change:  A  condition can be either a 3-element JSON array as described
       in the RFC or a boolean value. In case of an empty  array  an  implicit
       true boolean value will be considered.

   5.2.6 Wait, 5.2.7 Commit, 5.2.9 Comment
       RFC  7047  says  that  the wait, commit, and comment operations have no
       corresponding result object.  This is not true.  Instead, when such  an
       operation is successful, it yields a result object with no members.

AUTHOR
       The Open vSwitch Development Community

COPYRIGHT
       2016, The Open vSwitch Development Community




2.11                             Mar 20, 2019                  OVSDB-SERVER(7)
