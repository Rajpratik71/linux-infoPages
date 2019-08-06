File: coreutils.info,  Node: hostid invocation,  Next: uptime invocation,  Prev: uname invocation,  Up: System context

21.5 `hostid': Print numeric host identifier
============================================

`hostid' prints the numeric identifier of the current host in
hexadecimal.  This command accepts no arguments.  The only options are
`--help' and `--version'.  *Note Common options::.

   For example, here's what it prints on one system I use:

     $ hostid
     1bac013d

   On that system, the 32-bit quantity happens to be closely related to
the system's Internet address, but that isn't always the case.

   `hostid' is installed only on systems that have the `gethostid'
function, so portable scripts should not rely on its existence.

   An exit status of zero indicates success, and a nonzero value
indicates failure.

