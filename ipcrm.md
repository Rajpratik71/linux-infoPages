File: *manpages*,  Node: ipcrm,  Up: (dir)

IPCRM(1)                         User Commands                        IPCRM(1)



NAME
       ipcrm - remove a message queue, semaphore set or shared memory id

SYNOPSIS
       ipcrm [options]
       ipcrm {shm|msg|sem} id...

DESCRIPTION
       ipcrm  removes  System  V  interprocess communication (IPC) objects and
       associated data structures from the system.  In order  to  delete  such
       objects, you must be superuser, or the creator or owner of the object.

       System V IPC objects are of three types: shared memory, message queues,
       and semaphores.  Deletion of a message queue  or  semaphore  object  is
       immediate (regardless of whether any process still holds an IPC identi‐
       fier for the object).  A shared memory object is only removed after all
       currently  attached  processes have detached (shmdt(2)) the object from
       their virtual address space.

       Two syntax styles are supported.  The old Linux historical syntax spec‐
       ifies  a three letter keyword indicating which class of object is to be
       deleted, followed by one or more IPC identifiers for  objects  of  this
       type.

       The  SUS-compliant  syntax  allows  the  specification  of zero or more
       objects of all three types in a single command line, with objects spec‐
       ified either by key or by identifier. (See below.)  Both keys and iden‐
       tifiers may be specified in decimal,  hexadecimal  (specified  with  an
       initial '0x' or '0X'), or octal (specified with an initial '0').

OPTIONS
       -M, --shmem-key shmkey
              removes  the  shared memorysegment created with shmkey after the
              last detach is performed.

       -m, --shmem-id shmid
              removes the shared memory segment identified by shmid after  the
              last detach is performed.

       -Q, --queue-key msgkey
              removes the message queue created with msgkey.

       -q, --queue-id msgid
              removes the message queue identified by msgid.

       -S, --semaphore-key semkey
              removes the semaphore created with semkey.

       -s, --semaphore-id semid
              removes the semaphore identified by semid.

       -a, --all [shm msg sem]
              Remove  all  resources.  When  option  argument  is provided the
              removal is performed only to for the specified  resource  types.
              Warning!  Do not use -a if you are unsure how the software using
              resources might react on missing objects. Some  programs  create
              these  resources  at  start up and may not have any code to deal
              unexpected disappearance.

       The details of the removes are described in msgctl(2),  shmctl(2),  and
       semctl(2).  The identifiers and keys may be found by using ipcs(1).

NOTES
       In  its  first  Linux  implementation, ipcrm used the deprecated syntax
       shown in the SYNOPSIS.  Functionality present in other *nix implementa‐
       tions  of  ipcrm  has  since  been  added, namely the ability to delete
       resources by key (not just identifier), and to respect  the  same  com‐
       mand-line  syntax.  For  backward  compatibility the previous syntax is
       still supported.

SEE ALSO
       ipcs(1),  ipcmk(1),   msgctl(2),   msgget(2),   semctl(2),   semget(2),
       shmctl(2), shmdt(2), shmget(2), ftok(3)

AVAILABILITY
       The  ipcrm  command  is part of the util-linux package and is available
       from Linux Kernel  Archive  ⟨ftp://ftp.kernel.org/pub/linux/utils/util-
       linux/⟩.



util-linux                      September 2011                        IPCRM(1)
IPCRM(1P)                  POSIX Programmer's Manual                 IPCRM(1P)



PROLOG
       This  manual  page is part of the POSIX Programmer's Manual.  The Linux
       implementation of this interface may differ (consult the  corresponding
       Linux  manual page for details of Linux behavior), or the interface may
       not be implemented on Linux.

NAME
       ipcrm - remove an XSI message queue, semaphore set,  or  shared  memory
       segment identifier

SYNOPSIS
       ipcrm [ -q msgid | -Q msgkey | -s semid | -S semkey |
              -m shmid | -M shmkey ] ...

DESCRIPTION
       The  ipcrm  utility shall remove zero or more message queues, semaphore
       sets, or shared memory segments. The interprocess communication facili‐
       ties to be removed are specified by the options.

       Only  a  user  with appropriate privilege shall be allowed to remove an
       interprocess communication facility that was not created by or owned by
       the user invoking ipcrm.

OPTIONS
       The   ipcrm   facility   supports   the   Base  Definitions  volume  of
       IEEE Std 1003.1-2001, Section 12.2, Utility Syntax Guidelines.

       The following options shall be supported:

       -q  msgid
              Remove the message queue identifier msgid from  the  system  and
              destroy the message queue and data structure associated with it.

       -m  shmid
              Remove  the  shared memory identifier shmid from the system. The
              shared memory segment and  data  structure  associated  with  it
              shall be destroyed after the last detach.

       -s  semid
              Remove  the  semaphore  identifier  semid  from  the  system and
              destroy the set of semaphores and data structure associated with
              it.

       -Q  msgkey
              Remove  the  message  queue identifier, created with key msgkey,
              from the system and destroy the message queue and data structure
              associated with it.

       -M  shmkey
              Remove  the  shared  memory identifier, created with key shmkey,
              from the system. The shared memory segment  and  data  structure
              associated with it shall be destroyed after the last detach.

       -S  semkey
              Remove  the  semaphore identifier, created with key semkey, from
              the system and destroy the set of semaphores and data  structure
              associated with it.


OPERANDS
       None.

STDIN
       Not used.

INPUT FILES
       None.

ENVIRONMENT VARIABLES
       The  following  environment  variables  shall  affect  the execution of
       ipcrm:

       LANG   Provide a default value for the  internationalization  variables
              that  are  unset  or  null.  (See the Base Definitions volume of
              IEEE Std 1003.1-2001, Section  8.2,  Internationalization  Vari‐
              ables  for the precedence of internationalization variables used
              to determine the values of locale categories.)

       LC_ALL If set to a non-empty string value, override the values  of  all
              the other internationalization variables.

       LC_CTYPE
              Determine  the  locale  for  the  interpretation of sequences of
              bytes of text data as characters (for  example,  single-byte  as
              opposed to multi-byte characters in arguments).

       LC_MESSAGES
              Determine  the  locale  that should be used to affect the format
              and contents of diagnostic messages written to standard error.

       NLSPATH
              Determine the location of message catalogs for the processing of
              LC_MESSAGES .


ASYNCHRONOUS EVENTS
       Default.

STDOUT
       Not used.

STDERR
       The standard error shall be used only for diagnostic messages.

OUTPUT FILES
       None.

EXTENDED DESCRIPTION
       None.

EXIT STATUS
       The following exit values shall be returned:

        0     Successful completion.

       >0     An error occurred.


CONSEQUENCES OF ERRORS
       Default.

       The following sections are informative.

APPLICATION USAGE
       None.

EXAMPLES
       None.

RATIONALE
       None.

FUTURE DIRECTIONS
       None.

SEE ALSO
       ipcs,  the  System Interfaces volume of IEEE Std 1003.1-2001, msgctl(),
       semctl(), shmctl()

COPYRIGHT
       Portions of this text are reprinted and reproduced in  electronic  form
       from IEEE Std 1003.1, 2003 Edition, Standard for Information Technology
       -- Portable Operating System Interface (POSIX),  The  Open  Group  Base
       Specifications  Issue  6,  Copyright  (C) 2001-2003 by the Institute of
       Electrical and Electronics Engineers, Inc and The Open  Group.  In  the
       event of any discrepancy between this version and the original IEEE and
       The Open Group Standard, the original IEEE and The Open Group  Standard
       is  the  referee document. The original Standard can be obtained online
       at http://www.opengroup.org/unix/online.html .



IEEE/The Open Group                  2003                            IPCRM(1P)
