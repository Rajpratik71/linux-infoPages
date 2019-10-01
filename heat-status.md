File: *manpages*,  Node: heat-status,  Up: (dir)

HEAT-STATUS(1)                  openstack-heat                  HEAT-STATUS(1)



NAME
       heat-status - Script to check status of Heat deployment.

SYNOPSIS
          heat-status <category> <command> [<args>]

DESCRIPTION
       heat-status is a tool that provides routines for checking the status of
       a Heat deployment.

OPTIONS
       The standard pattern for executing a heat-status command is:

          heat-status <category> <command> [<args>]

       Run without arguments to see a list of available command categories:

          heat-status

       Categories are:

       · upgrade

       Detailed descriptions are below.

       You can also run with a category argument such as upgrade to see a list
       of all commands in that category:

          heat-status upgrade

       These  sections  describe  the  available  categories and arguments for
       heat-status.

   Upgrade
       heat-status upgrade check
              Performs a release-specific readiness  check  before  restarting
              services  with  new  code. This command expects to have complete
              configuration and access to databases and services.

              Return Codes

                         ┌────────────┬────────────────────────────┐
                         │Return code │ Description                │
                         ├────────────┼────────────────────────────┤
                         │0           │ All   upgrade    readiness │
                         │            │ checks passed successfully │
                         │            │ and there  is  nothing  to │
                         │            │ do.                        │
                         ├────────────┼────────────────────────────┤
                         │1           │ At least one check encoun‐ │
                         │            │ tered   an    issue    and │
                         │            │ requires  further investi‐ │
                         │            │ gation. This is considered │
                         │            │ a  warning but the upgrade │
                         │            │ may be OK.                 │
                         └────────────┴────────────────────────────┘






                         │2           │ There was an upgrade  sta‐ │
                         │            │ tus   check  failure  that │
                         │            │ needs to be  investigated. │
                         │            │ This  should be considered │
                         │            │ something  that  stops  an │
                         │            │ upgrade.                   │
                         ├────────────┼────────────────────────────┤
                         │255         │ An     unexpected    error │
                         │            │ occurred.                  │
                         └────────────┴────────────────────────────┘

              History of Checks

              12.0.0 (Stein)

              · Placeholder to be filled in with checks as they are  added  in
                Stein.

AUTHOR
       Heat Developers

COPYRIGHT
       (c) 2012- Heat Developers




                                 Apr 10, 2019                   HEAT-STATUS(1)
