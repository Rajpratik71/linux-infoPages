DWWW(1)                          Debian                          DWWW(1)

NAME
       dwww - access documentation via WWW

SYNOPSIS
       http://localhost/dwww/index.html
       dwww
       dwww program-name | package-name

DESCRIPTION
       A  typical Linux system has documentation in many formats (manual
       pages, info files, READMEs, and so on).  dwww makes  it  possible
       to  access  all  of  these via the same interface, a WWW browser.
       This makes it easier to use the documentation.

       To use dwww, load the URL given in the SYNOPSIS.  If you  have  a
       web  browser  installed,  you  can also just run the dwww command
       which loads the URL.  If BROWSER  environment  variable  is  set,
       dwww  uses  sensible-browser(1) to load the URL.  Otherwise, dwww
       first  tries  to  use  browser  specified  by   DWWW_BROWSER   or
       DWWW_X11_BROWSER configuration variable (cf.  dwww(7)), than will
       use sensible-browser(1) command.

       If optional argument program-name or package-name  is  specified,
       dwww  will  search  all documentation related to given program or
       package.

ENVIRONMENT
       BROWSER
              Program used to load the above mentioned URL.

FILES
       /etc/dwww/dwww.conf
              Configuration file for dwww.

SEE ALSO
       dwww-find(8), dwww(7), sensible-browser(1).

AUTHOR
       Lars  Wirzenius  <liw@iki.fi>.   Modified   by   Robert   Luberda
       <robert@debian.org>.
       Bugs  should  be  reported via the  Debian Bug Tracking System at
       <URL:http://bugs.debian.org/>.

       dwww is licensed via the GNU General Public  License.   While  it
       has  been  written  for  Debian,  porting  it to other systems is
       strongly encouraged.

dwww 1.11.1                February 15th, 2009                   DWWW(1)
DWWW(7)                          Debian                          DWWW(7)

NAME
       dwww - access documentation via WWW

SYNOPSIS
       http://localhost/dwww/index.html

DESCRIPTION
       A  typical Linux system has documentation in many formats (manual
       pages, Info files, READMEs, and so on).  dwww makes  it  possible
       to  access  all  of  these via the same interface, a WWW browser.
       This makes it easier to use the documentation.

       dwww consists of several programs:

       cgi-bin/dwww
              Run by the WWW server  when  user  requests  document  via
              dwww.   Parses  the  request  and  runs dwww-convert(8) or
              dwww-find(8) with suitable arguments.   Installed  in  the
              server's cgi-bin directory.

       dwww-convert(8)
              Converts any document to HTML.

       dwww-format-man(8)
              Auxiliary  program  to  convert man pages or text files to
              HTML.

       dwww-find(8)
              Searches for documentation.

       dwww-quickfind(8)
              Used by dwww-find(8) to quickly find which package a  pro‐
              gram belongs to.

       dwww-cache(8)
              Manages the cache of converted documents.

       dwww-refresh-cache(8)
              Cleans outdated documents from the cache.

       dwww-build(8)
              Builds  static  lists of manual pages.  Needs to be re-run
              whenever documents are installed or removed.  (In  default
              configuration is called by the dwww daily cron job).

       dwww-build-menu(8)
              Builds  the  Debian Documentation Menu pages.  Needs to be
              re-run whenever documents are installed or  removed.   (In
              default  configuration is called by the install-docs(8) or
              by the dwww daily  cron job).

       dwww-index++(8)
              Uses index++(1) to build index of the documentation regis‐
              tered  with  doc-base.  In default configuration is called
              be the dwww weekly cron job.

       For  speed  reasons,  the  converted  documents  are  stored   in
       /var/cache/dwww.   The  cache is cleaned by dwww-refresh-cache(8)
       of old documents to keep it from growing too large.

CONFIGURATION
       dwww is configured via the /etc/dwww/dwww.conf file.   That  file
       is  a  Bourne shell (/bin/sh) script that defines some or all the
       following variables (defaults are used if the file doesn't exist,
       or doesn't define the variable).

   Basic configuration variables
       These variables can be also configured by debconf script. You can
       change them using the following command:
           dpkg-reconfigure dwww

       DWWW_SERVERNAME
              Name of the www server.  Default is localhost.

       DWWW_SERVERPORT
              Port on which the www server listen to.  Default is 80.

       DWWW_USEHTTPS
              If  enabled,  dwww(1)   will   connect   to   DWWW_SERVER‐
              NAME:DWWW_SERVERPORT  through the HTTPS protocol.  Default
              is no.

       DWWW_DOCROOTDIR
              The document root for web server.  Default is /var/www.

       DWWW_CGIDIR
              The directory which contains the CGI scripts for your  web
              server.  Default is /usr/lib/cgi-bin.

       DWWW_CGIUSER
              Name  of  the user that the web server uses to execute CGI
              scripts.  Default is www-data.

   Browser variables
       DWWW_BROWSER
              Web-browser used by dwww(1) to load dwww main page.

       DWWW_X11_BROWSER
              Web-browser used by dwww(1) to load dwww main page when in
              X11.

   Path variables
       DWWW_DOCPATH
              Colon-delimited  list  of directories from which dwww-con‐
              vert(8) supplies files.  For  security  reasons,  it  will
              refuse  to  convert files outside the directories named by
              this           variable.             Default            is
              /usr/share/doc:/usr/share/info:/usr/share/man:
              /usr/local/share/doc:/usr/local/share/info:/usr/local/share/man:
              /usr/share/common-licenses.

       DWWW_ALLOWEDLINKPATH
              Colon-delimited  list  of directories which can be targets
              of symlinks from files from directories  inside  DWWW_DOC‐
              PATH.              Default             value            is
              /usr/share:/usr/lib:/usr/local/share:/var/www.
              For example, /usr/share/doc/package/foo.html may  be  sym‐
              linked  to  a  file  /usr/share/package/foo.html, and this
              file can be displayed by dwww.

   Cache files locations
       DWWW_QUICKFIND_DB
              Location of the  installed  packages  and  programs  cache
              file,  generated by dwww-refresh-cache(8) with the help of
              dwww-quickfind(8).   Default   is   /var/cache/dwww/quick‐
              find.dat.

       DWWW_DOCBASE2PKG_DB
              Location  of the cache file, which maps installed doc-base
              files to packages names, used by  the  dwww-build-menu(8).
              Default is /var/cache/dwww/docbase2pkg.dat.

       DWWW_REGDOCS_DB
              Location  of doc-base registered documents contents cache.
              The cache is generated by dwww-build-menu(8) and  read  by
              dwww-find(8) Default is /var/cache/dwww/regdocs.dat.

   Documentation indexing variables
       DWWW_INDEX_DOCUMENTATION
              If  this variable is set to yes (default), and the swish++
              package is installed, then dwww-index++(8)  will  generate
              index of registered documentation.

       DWWW_INDEX_FULL_TIME_INTERVAL
              Specifies  how often (in days) dwww-index++(8) will gener‐
              ate full index of documentation.  The default value is 28.

       DWWW_INDEX_INCREMENTAL_TIME_INTERVAL
              Specifies how often (in  days)  dwww-index++(8)  will  run
              incremental  indexing  of  new  documentation  files.  The
              default value is 7.

       DWWW_MERGE_MAN2HTML_INDEX
              If this variable is set  to  yes,  then  while  generating
              index  of  registered  documents, dwww-index++(8) will use
              man pages index generated by  man2html  package,  if  it's
              available.

   Other variables
       DWWW_KEEPDAYS
              How  many days should dwww-refresh-cache(8) keep documents
              that have not been accessed?  Default is 10 days.

       DWWW_TMPDIR
              Directory used by dwww-build(8) and dwww-build-menu(8)  to
              temporally  store  the web pages it generates.  Default is
              /var/lib/dwww.  For security reason  any  public  writable
              directory like /tmp should not be used.

       DWWW_USEFILEURL
              If  this  variable is set, dwww will use file:/ style URLs
              to access html files - bypassing the CGI script.  This  is
              faster  on slow machines.  Of course, you will not be able
              to read the html documentation  on  a  non-local  machine.
              Default is to not enable this feature.

       DWWW_TITLE
              Title to appear on dwww generated files.  Default is dwww:
              $(hostname)

       DWWW_USE_CACHE
              If this variable is set to yes (default), dwww will  cache
              accessed     documents    in    /var/cache/dwww/db.    See
              dwww-cache(8).

   Deprecated variables
       Since version 1.10, dwww no longer uses the following  variables:
       DWWW_HTMLDIR, DWWW_MAN2HTML, DWWW_TEXT2HTML, DWWW_DIR2HTML.

CUSTOMISING DWWW PAGES LAYOUT
       dwww uses a CSS file for managing the layout of the pages it gen‐
       erates.  The  file  is  built  from  two  other   files,   namely
       /usr/share/dwww/dwww.css,  which is a global one, provided by the
       package, and /etc/dwww/dwww-user.css, a local one,  that  can  be
       provided  by  the user to override settings from the former file.
       The latter file does not exist by default, but  when  it  exists,
       dwww-build(8)  will  append  its contents at the end of generated
       file.  Since web browsers  tend  to  use  the  last  one  setting
       defined  for a given CSS element, this has the expected effect of
       customisation.

   Example
       To use some image as a background  for  dwww  pages,  please  put
       something like this in /etc/dwww/dwww-user.css:

           body { background: url('http://host/path/to/background.png')
                  repeat; }
           table,pre,code,tt { opacity: 0.7; }

       Please make sure to run dwww-build(8) afterwards.

FILES
       /etc/dwww/dwww.conf
              Configuration  file for dwww.  It's not necessary for this
              file to exist, there are sensible defaults for everything.

       /etc/dwww/apache.conf
              Default configuration file for  various  apache-based  web
              servers.   The  dwww package post-installation script cre‐
              ates symlinks from /etc/apache*/conf.d/dwww to this file.

       /etc/dwww/dwww-user.css
              If such a file exists, its contents will  be  appended  to
              the  dwww.css  file.   This allows local administrators to
              customise dwww pages layout.

       /etc/cron.daily/dwww
              Dwww daily cron job, which rebuilds  cache  directory  and
              dwww HTML pages.

       /etc/cron.weekly/dwww
              Dwww weekly cron job. Uses dwww-index++(8) to rebuild reg‐
              istered documentation index.

       /var/cache/dwww
              Directory, where are placed various cache files  generated
              and used by dwww.

       /var/cache/dwww/db
              Cache for the converted documents.

       /usr/share/dwww
              Templates  for  the  dwww web pages (used by dwww-build(8)
              and others).

       /var/lib/dwww
              The dwww pages.   The  server's  document  root  directory
              should have a link to this directory.

SEE ALSO
       dwww(1),    dwww-build(8),   dwww-build-menu(8),   dwww-cache(8),
       dwww-convert(8),        dwww-find(8),         dwww-format-man(8),
       dwww-index++(8),     dwww-quickfind(8),    dwww-refresh-cache(8),
       dwww-txt2html(8).

AUTHOR
       Originally by Lars Wirzenius <liw@iki.fi>.  Modified by Jim  Pick
       <jim@jimpick.com>  and  Robert Luberda <robert@debian.org>.  Bugs
       should be reported via the normal Debian  bug  reporting  system,
       see  /usr/share/doc/debian/bug-reporting.txt file or reportbug(1)
       man page.

       dwww is licensed via the GNU General Public  License.   While  it
       has  been  written  for  Debian,  porting  it to other systems is
       strongly encouraged.

dwww 1.11.6                  June 26th, 2011                     DWWW(7)
