File: *manpages*,  Node: update-xml-catalog,  Up: (dir)

update-xml-catalog(1)        XML catalog generator       update-xml-catalog(1)



NAME
       update-xml-catalog  - generate full XML catalogs from parts in a direc-
       tory

SYNOPSIS
       update-xml-catalog --version
       update-xml-catalog -h|--help
       update-xml-catalog [--] [catalogfile] [directory]


DESCRIPTION
       Generates "/etc/xml/catalog-d.xml" from the  files  in  "/etc/xml/cata-
       log.d"

       The  output file can be overwritten by setting the first parameter, the
       input directory as second parameter.

OPTIONS
       -h, --help Display help and usage information  --version  Show  version
       information

EXAMPLE
       # update-xml-catalog

       $ update-xml-catalog /tmp/tmpcatalog.xml

       $ update-xml-catalog /tmp/tmpcatalog.xml /tmp/tmpcatalog.d

AUTHOR
       Fabian Vogt <fvogt@suse.com>



0.6                              16 Juni 2016            update-xml-catalog(1)
