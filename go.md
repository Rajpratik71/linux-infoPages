GO(1)                                  General Commands Manual                                  GO(1)

NAME
       go - tool for managing Go source code

SYNOPSIS
       go command [arguments]

DESCRIPTION
       The  Go  distribution  includes a command, named go, that automates the downloading, building,
       installation, and testing of Go packages and commands.

COMMANDS
       Each command is documented in its own manpage. For example, the build command is documented in
       go-build(1). The commands are:

       build  compile packages and dependencies

       clean  remove object files

       doc    run godoc on package sources

       env    print Go environment information

       fix    run go tool fix on packages

       fmt    run gofmt on package sources

       get    download and install packages and dependencies

       install
              compile and install packages and dependencies

       list   list packages

       run    compile and run Go program

       test   test packages

       tool   run specified go tool

       version
              print Go version

       vet    run go tool vet on packages

EXAMPLES
       TODO

SEE ALSO
       go-build(1), go-clean(1).

AUTHOR
       This  manual  page  was  written by Michael Stapelberg <stapelberg@debian.org>, for the Debian
       project (and may be used by others).

                                              2012-05-13                                        GO(1)
GO-PACKAGES(7)                     Miscellaneous Information Manual                    GO-PACKAGES(7)

NAME
       go - tool for managing Go source code

DESCRIPTION
       Many commands apply to a set of packages:

             go action [packages]

       Usually, [packages] is a list of import paths.

       An import path that is a rooted path or that begins with a . or .. element is interpreted as a
       file system path and denotes the package in that directory.

       Otherwise, the import path P denotes the package found in the directory DIR/src/P for some DIR
       listed in the GOPATH environment variable (see 'go help gopath').

       If no import paths are given, the action applies to the package in the current directory.

       The  special  import  path  "all"  expands  to all package directories found in all the GOPATH
       trees.  For example, 'go list all' lists all the packages on the local system.

       The special import path "std" is like all but expands to just the packages in the standard  Go
       library.

       An  import  path  is  a  pattern if it includes one or more "..." wildcards, each of which can
       match any string, including the empty string and strings containing slashes.  Such  a  pattern
       expands to all package directories found in the GOPATH trees with names matching the patterns.
       As a special case, x/... matches x as  well  as  x's  subdirectories.   For  example,  net/...
       expands to net and packages in its subdirectories.

       An  import  path  can  also name a package to be downloaded from a remote repository.  Run 'go
       help remote' for details.

       Every package in a program must have a unique import path.  By convention, this is arranged by
       starting  each  path with a unique prefix that belongs to you.  For example, paths used inter‐
       nally at Google all begin with 'google', and paths denoting remote repositories begin with the
       path to the code, such as 'code.google.com/p/project'.

       As  a  special  case,  if the package list is a list of .go files from a single directory, the
       command is applied to a single synthesized package made up of exactly  those  files,  ignoring
       any build constraints in those files and ignoring any other files in the directory.

AUTHOR
       This  manual  page  was  written by Michael Stapelberg <stapelberg@debian.org>, for the Debian
       project (and may be used by others).

                                              2012-05-13                               GO-PACKAGES(7)
