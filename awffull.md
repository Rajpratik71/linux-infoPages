awffull(1)                                                                                                                              awffull(1)

NAME
       AWFFull - A Webalizer Fork, Full o' features

SYNOPSIS
       awffull [...] [log-file]

DESCRIPTION
       AWFFull  is  a web server log analysis program based on The Webalizer.  AWFFull produces usage statistics in HTML format for viewing with a
       browser. The results are presented in both columnar and graphical format, which facilitates  interpretation.  Yearly,  monthly,  daily  and
       hourly  usage  statistics  are  presented, along with the ability to display usage by site, URL, referrer, user agent (browser), user name,
       search strings, entry/exit pages, and country (some information may not be available if not present in the log file being processed).

       AWFFull supports the following log formats shown in the following variable list:

       CLF    (common log format) log files

       Combined
              log formats as defined by NCSA and others, and variations of these which it attempts to handle intelligently

       xferlog
              wu-ftpd formatted log files allowing analysis of ftp servers, and squid proxy logs.
              Note

              Logs may also be compressed, via gzip. If a compressed log file is detected, it will be automatically uncompressed while it is read.
              Compressed logs must have the standard gzip extension of .gz.

       This documentation applies to AWFFull Version 3.8.2

CHANGES FROM WEBALIZER
       AWFFull is based on The Webalizer code and has a number of large and small changes.  These include:

       · Beyond the raw statistics: Making use of published formulae to provide additional insights into site usage

       · GeoIP IP Address look-ups for more accurate country detection

       · Resizable graphs

       · Integration with GNU gettext allowing for ease of translations.  Currently 32 languages are supported.

       · Display more than 12 months of the site history on the front page.

       · Additional page count tracking and sort by same.

       · Some minor visual tweaks, including Geolizer's use of Kb, Mb etc for Volumes

       · Additional Pie Charts for URL counts, Entry and Exit Pages, and Sites

       · Horizontal lines on graphs that are more sensible and easier to read

       · User Agent and Referral tracking is now calculated via PAGES not HITS

       · GNU style long command line options are now supported (eg --help)

       · Can choose what is a page by excluding ‘what isn't’ vs the original ‘what is’ method

       · Requests to the site being analysed are displayed with the matching referring URL

       · A Table of 404 Errors, and the referring URL can be generated

       · An external CSS file can be used with the generated html

       · Manual performance optimisation of the config file is now easier with a post analysis summary output

       · Specified IP Addresses can be assigned to a given country

       · Additional Dump options for detailed analysis with other tools

       · Lotus Domino v6 logs are now detected and processed

       Additional changes and improvements are planned and undergoing implementation. See the TODO file for details.

NEW REPORT MEASUREMENTS
       With version 3.8.1 of AWFFull, several new measured results have been added to the detailed report monthly page.

       Single Access
              Single Access Pages - the only page seen within a given visit

       Stickiness
              How useful a given entry page is to draw Visitors deeper into your site

       Popularity
              The Ratio of Page Entries to Page Exits

       These  metrics  can  help towards improving insight in the usage of the processed web site. And hence allow the site owner to make positive
       change to make the site more useful to site visitors. All three metrics appear in the ‘Entry Pages’ Report. ‘Popularity’  is  also  on  the
       ‘Exit Pages’ Report.

       Single Access

       More  completely: ‘Single Access Pages’. This is a report on the number of times that a given page was the only page viewed within a Visit.
       Or in English, Someone came to your website. They only viewed one page. The number is the cumulative count of people who did this for  that
       particular  page.  Why  is this useful? Identifying those entry pages that don't draw visitors deeper into your site. Or seeing entry pages
       that shouldn't be entry pages. It's also a reality check against the next two values which are calculated from this number. The number gen‐
       erated should be a subset of the ‘Entry Page Views’ and/or ‘Exit Page Views’ metric. If it isn't? Let me know, we have a bug. :-)

       Stickiness

       Is calculated as 1 - (Single Access / Entry Page Views) expressed as a percentage. In essence Stickiness describes how useful a given entry
       page is to draw Visitors deeper into your site. The stickier the page, the more folk are caught by it. :-) The closer to 100%  the  better.
       Generally.   Certain pages within YOUR website may not make sense to have a high stickiness or even > 5%. This measurement is a clue to un‐
       derstanding how your site is used, it is not a rule. How is this useful? How and where are people entering your web site.  Does  that  make
       sense? Should it be here or there? What can you change to fix this and hence improve their use of your website.

       Popularity

       Popularity  is  the Ratio of Page Entries to Page Exits. o If it equals 1.0? Then the number of visitors to your site who started with that
       page, equals the number who left at that page. o If greater then 1.0, then more people entered here then left. o If less then 0? More  peo‐
       ple  left from here then entered. I personally find this metric one of the more useful "At a Glance: How are Pages Performing" metrics. One
       of the difficulties with using this particular metric is that certain numbers will NOT make sense for YOUR site. In  that  a  natural  exit
       page  would  expect to have a very low Popularity. It's an exit page, not an entry page. So if an exit page has a high popularity, then you
       have a real problem. Likewise, a low Popularity for an entry page is unlikely to be a Good Thing(tm).

       "Where & Why?" All three of these metrics are covered very nicely in Hack #58 from "Web Site Measurement Hacks" [1]. Which is where, credit
       where credit due, the inspiration to add these metrics came from.

RUNNING AWFFULL
       AWFFull is designed to be run from a Unix command line prompt or as a crond(8) job.  There is no need to run with super-user privleges, and
       indeed, is preferable NOT to.

       Once executed, the general flow of the program is:

       A default configuration file is scanned for, /etc/awffull/awffull.conf and, if found, is used.

       Any command line arguments given to the program are parsed. This may include the specification of one or more  configuration  files,  which
       are processed at the time it is encountered.

       It  can  be  useful to have multiple config files. A master used for multiple sites, and individualised config files. Do be aware that last
       option set wins. So last config file, or if after a config file, command line options. Useful if you desire to send the output to an alter‐
       nate directory.

       If  a  log  file  was  specified, it is opened and made ready for processing. If no log file was given, STDIN is used for input. If the log
       filename '-' is specified, STDIN will be forced.

       If an output directory was specified, AWFFull changes to that directory in preparation for generating output. If no  output  directory  was
       given, the current directory is used.

       If no hostname was given, the program attempts to get the hostname using a uname(2) system call. If that fails, localhost is used.

       A  history  file is searched for in the current directory (output directory) and read if found. This file keeps totals for previous months,
       which is used in the main index.html HTML document. Note: The file location can now be specified with the HistoryName configuration option.

       If incremental processing was specified, a data file is searched for and loaded if found, containing the 'internal state' data of the  pro‐
       gram at the end of a previous run. Note: The file location can now be specified with the IncrementalName configuration option.

       Main  processing  begins on the log file. If the log spans multiple months, a separate HTML document is created for each month.  After main
       processing, the main index.html page is created, which has totals by month and links to each months HTML document.

       A new history file is saved to disk, which includes totals generated by AWFFull during the current run.

       If incremental processing was specified, a data file is written that contains the 'internal state' data at the end of this run.

INCREMENTAL PROCESSING
       Version 1.2x of The Webalizer added incremental run capability.  Simply put, this allows processing large log files by breaking them up in‐
       to smaller pieces, and processing these pieces instead. What this means in real terms is that you can now rotate your log files as often as
       you want, and still be able to produce monthly usage statistics without the loss of any detail. Basically, AWFFull saves and  restores  all
       internal  data  in a file named awffull.current. This allows the program to 'start where it left off' so to speak, and allows the preserva‐
       tion of detail from one run to the next. The data file is placed in the current output directory, and is a plain ASCII text file  that  can
       be viewed with any standard text editor. It's location and name may be changed using the IncrementalName configuration keyword.

       Some special precautions need to be taken when using the incremental run capability of AWFFull. Configuration options should not be changed
       between runs, as that could cause corruption of the internal data stored. For example, changing the MangleAgents level will cause different
       representations of user agents to be stored, producing invalid results in the user agents section of the report. If you need to change con‐
       figuration options, do it at the end of the month after normal processing of the previous month and before processing  the  current  month.
       You may also want to delete the awffull.current file as well.

       AWFFull  also  attempts  to prevent data duplication by keeping track of the timestamp of the last record processed. This timestamp is then
       compared to current records being processed, and any records that were logged previous to that timestamp  are  ignored.  This,  in  theory,
       should  allow  you  to  re-process logs that have already been processed, or process logs that contain a mix of processed/not yet processed
       records, and not produce duplication of statistics.

       The only time this may break is if you have duplicate timestamps in two separate log files. Any records in the second log file that do have
       the  same  timestamp  as the last record in the previous log file processed, will be discarded as if they had already been processed. There
       are lots of ways to prevent this however, for example, stopping the web server before rotating logs will prevent this situation, or using a
       tool  such  as cronolog (⟨http://cronolog.org/⟩).  This setup also necessitates that you always process logs in chronological order, other‐
       wise data loss will occur as a result of the timestamp compare.

REVERSE DNS LOOKUPS
       AWFFull no longer supports DNS lookups. Please use an external program such as DNShistory or DNSTran instead.

       · ⟨http://www.summary.net/soft/dnstran.html⟩

       · ⟨http://www.stedee.id.au/dnshistory⟩

       With version 3.7.1 of AWFFull, GeoIP capability can be used for improved country detection.

COMMAND LINE OPTIONS
       AWFFull supports many different configuration options that will alter the way the program behaves and generates output. Most of  these  can
       be specified on the command line, while some can only be specified in a configuration file. The command line options are listed below, with
       references to the corresponding configuration file keywords. See also awffull.conf(5).

       General Options

       -h, --help
              Display all available command line options and exit program

       -V, --version
              Display program version and exit program

       -v --verbose
              Verbosity Display debugging information for errors and warnings. Multiple v's will increase the amount of information displayed.

       --match_counts
              Display optimisation useful information pertaining to the number of matches against various Group, Hide and Ignore options.

       -i --ignore_history
              IgnoreHist Ignore history. USE WITH CAUTION.  This will cause AWFFull to ignore any previous monthly history file only.  Incremental
              data (if present) is still processed.

       -p --preserve_state
              Incremental Preserve internal data between runs.

       -T --timing
              TimeMe. Force display of timing information at end of processing.

       -c --config=FILE
              Use configuration file FILE

       -n NAME
              HostName. Use the hostname NAME.

       -o --output=DIR
              OutputDir. Use output directory DIR.

       -t NAME
              ReportTitle. Use NAME for report title.

       F --logtype=TYPE
              LogType. Specify log type to be processed.  Value can be one of: auto, clf, combined, domino, ftp or squid format. If not specified,
              will default to auto format. FTP logs must be in standard wu-ftpd xferlog format. A value of ‘auto’ states that the log format auto‐
              matically ascertained.

       -f --fold
              FoldSeqErr.  Fold  out  of  sequence log records back into analysis, by treating as if they were the same date/time as the last good
              record. Normally, out of sequence log records are simply ignored.

       -Y     CountryGraph. Suppress country graph.

       -G     HourlyGraph. Suppress hourly graph.

       -x NAME
              HTMLExtension. Defines the HTML file extension to use on the created report files. If not specified, defaults to html.  Do  not  in‐
              clude the leading period.

       -H     HourlyStats. Suppress hourly statistics.

       -L     GraphLegend. Suppress color coded graph legends.

       -l NUM GraphLines.  Use background lines. The number of lines and where to place are automatically calculated. For backwards compatibility,
              any number > 0 enables. Use zero ('0') to disable the lines.

       -P NAME
              PageType. Specify file extensions that are considered pages. Sometimes referred to as pageviews.

       -m NUM VisitTimeout. Specify the Visit timeout period. Specified in number of seconds. Default is 1800 seconds (30 minutes). Sometimes  re‐
              ferred to as sessions.

       -I NAME
              IndexAlias. Use the filename name as an additional alias for index.

       -M NUM MangleAgents. Mangle user agent names according to the mangle level specified by num.

              Mangle levels are:

              5 - Browser name and major version

              4 - Browser name, major and minor version

              3 - Browser name, major version, minor version to two decimal places

              2 - Browser name, major and minor versions and sub-version

              1 - Browser name, version and machine type if possible

              0 - All information (left unchanged).

       -g NUM GroupDomains.  Automatically group sites by domain. The grouping level specified by num can be thought of as 'the number of dots' to
              display in the grouping. The default value of 0 disables any domain grouping.

       Hide Options

       -a NAME
              HideAgent. Hide user agents matching name.

       -r NAME
              HideReferrer. Hide referrer matching name.

       -s NAME
              HideSite. Hide site matching name.

       -X NAME
              HideAllSites. Hide all individual sites (only display groups).

       -u NAME
              HideURL. Hide URL matching name.

       Table size options

       -A --top_agents=NUM
              TopAgents. Display the top num user agents table.

       -R --top_refers=NUM
              TopReferrers. Display the top num referrers table.

       -S --top_sites=NUM
              TopSites. Display the top num sites table.

       -U --top_urls=NUM
              TopURLs. Display the top num URL's table.

       -C --top_countries=NUM
              TopCountries. Display the top num countries table.

       -e --top_entry=NUM
              TopEntry. Display the top num entry pages table.

       -E --top_exit=NUM
              TopExit. Display the top num exit pages table.

       Other Options

       --use_geoip
              Enables the use of the Maxmind GeoIP capability for more accurate detection of countries.

              NOTE! Do not enable GeoIP if you analyse files that have had the IP Address translated to a Fully Qualified Host Name.   Use  either
              raw IP Addresses and GeoIP, or Names and disable GeoIP.  ie. Don't use GeoIP AND DNShistory.

       --match_counts
              Display  the  various  Group/Hide  etc Match Counts. This option is ideal for optimisation of the awffull.conf file. Just be careful
              with optimising Agents in particular, as the order is typically important.

CONFIGURATION FILES
       See the awffull.conf(5) man page for complete details of all configuration options.

       Configuration files are standard ASCII(7) text files that may be created or edited using any standard editor.

       Blank lines and lines that begin with a pound sign ('#') are ignored.

       Any other lines are considered to be configuration lines, and have the form ‘Keyword Value’, where the ‘Keyword’ is one  of  the  currently
       available configuration keywords (see awffull.conf(5)), and ‘Value’ is the value to assign to that particular option.

       Any  text found after the keyword up to the end of the line is considered the keyword's value, so you should not include anything after the
       actual value on the line that is not actually part of the value being assigned. The file sample.conf provided with  the  distribution  con‐
       tains lots of useful documentation and examples as well.

       Certain  "Keywords"  will accept a 2nd value. In those situations, the first value may be enclosed in double quotes (") to allow for white‐
       space.

SEE ALSO
       awffull.conf(5)

BUGS
       None currently known. YMMV....

       Report bugs to ⟨https://bugs.launchpad.net/awffull⟩, or use the email discussion list: <awffull@stedee.id.au>

NOTES
       In case it is not obvious: AWFFull is a play/pun on the word ‘awful’, and is pronounced the same way. Yes it was deliberate.

REFERENCES
       [1] Web Site Measurement Hacks. Eric T. Peterson (and others).  O'Reilly. ISBN 0-596-00988-7.

                                                                    2008-Dec-13                                                         awffull(1)
awffull.conf(5)                                                                                                                    awffull.conf(5)

NAME
       AWFFull - A Webalizer Fork, Full o' features

DESCRIPTION
       awffull.conf  is  the configuration file for awffull(1). awffull.conf is a standard ASCII(7) text files that may be created or edited using
       any standard editor.

       Blank lines and lines that begin with a pound sign ('#') are ignored.

       Any other lines are considered to be configuration lines, and have the form ‘Keyword Value’, where the ‘Keyword’ is one  of  the  currently
       available configuration keywords, and ‘Value’ is the value to assign to that particular option.

       Any  text found after the keyword up to the end of the line is considered the keyword's value, so you should not include anything after the
       actual value on the line that is not actually part of the value being assigned. The file sample.conf provided with  the  distribution  con‐
       tains lots of useful documentation and examples as well.

       Some  ‘Keywords’  will  accept  a 2^nd value. In those situations, the first value may be enclosed in double quotes (") to allow for white‐
       space.

       Keywords are Case Insensitive. Values are Case Sensitive, with some gotchas: See Ignore* for details.

WILDCARDS
       Wildcards within AWFFull are a little non standard and may cause some confusion.

       Wildcards are only valid within the Value of certain keywords

       A Value can have either a leading or trailing '*' to signify a wildcard character. If no wildcard is found, a match can occur  anywhere  in
       the string. Given a string ‘www.yourmama.com’, the values ‘your’, ‘*mama.com’ and ‘www.your*’ will all match.

       Thus  the  use  of  the  wildcard  signifies  that the other end of the Value is anchored at the Beginning or End of a field to be searched
       against.

       eg. A Value of ‘Bot*’ implies that the field (probably UserAgent in this case) MUST start with the letters Bot. Or in the case of  a  Host‐
       name ‘*.gov.au’ implies a match ONLY against Australian Government hostnames.

RUN OPTIONS
       The  Run  Options  are the generic ones that tell AWFFull where stuff is and how to generally operate. Some of these can modify the results
       that AWFFull will produce.

       OutputDir
              OutputDir is where you want to put the output files. This should should be a full path name, however relative  ones  might  work  as
              well. If no output directory is specified, the current directory will be used.

       LogFile
              LogFile defines the web server log file to use. If not specified here or on on the command line, input will default to STDIN. If the
              log filename ends in '.gz' (ie: a gzip compressed file), it will be decompressed on the fly as it is being read.

       LogType
              LogType defines the log type being processed. Normally, AWFFull expects a CLF or Combined  web  server  log  as  input.  Using  this
              option,  you  can  process  ftp logs as well (xferlog as produced by wu-ftpd and others), or Squid native logs. Values can be 'auto'
              'clf', 'combined', 'ftp', 'domino' or 'squid', with 'auto' the default. The 'auto' value means that AWFFull will try  and  work  out
              what log format you are sending to it. If no joy, AWFFull will immediately exit.

       GeoIP  GeoIP  enables  or  disables the use of the GeoIP capability for more accurate detection of countries. Default is ‘no’. NOTE! Do not
              enable GeoIP if you analyse files that have had the IP Address translated to  a  Fully  Qualified  Host  Name.  Use  either  raw  IP
              Addresses and GeoIP, or Names and disable GeoIP. ie. Don't use GeoIP AND DNShistory.

       GeoIPDatabase
              GeoIPDatabase  is  the  location  of  the GeoIP database file. Default is /usr/share/GeoIP/GeoIP.dat, which is where a default GeoIP
              install will put it. Note that the database is updated monthly. For the details see: ⟨http://www.maxmind.com/app/geoip_country⟩

       Incremental
              Incremental processing allows multiple partial log files to be used instead of one huge one. Useful for large  sites  that  have  to
              rotate  their  log  files  more than once a month. AWFFull will save its internal state before exiting, and restore it the next time
              run, in order to continue processing where it left off. This mode also causes AWFFull to  scan  for  and  ignore  duplicate  records
              (records  already processed by a previous run). See the README file for additional information. The value may be 'yes' or 'no', with
              a default of 'no'. The file awffull.current is used to store the current state data, and is located in the output directory  of  the
              program  (unless  changed  with the IncrementalName option below). Please read at least the section on Incremental processing in the
              README file before you enable this option.

       TimeMe TimeMe allows you to force the display of timing information at the end of processing. A value of 'yes' will force the timing infor‐
              mation to be displayed. A value of 'no' has no effect.

       IgnoreHist
              IgnoreHist  should  not  be used in a standard configuration, but it is here because it is useful in certain analysis situations. If
              the history file is ignored, the main ‘index.html’ file will only report on the current log files  contents.  Incremental  data  (if
              present) is still processed. Useful when you want to reproduce the reports from scratch, for example. USE WITH CAUTION! Valid values
              are ‘yes’ or ‘no’. Default is ‘no’.

       IncrementalName
              IncrementalName allows you to specify the filename for saving the incremental data in. It is similar to the HistoryName option where
              the  name is relative to the specified output directory, unless an absolute filename is specified. The default is a file named ‘awf‐
              full.current’ kept in the normal output directory. If you don't specify Incremental as 'yes' then this option has no meaning.

       HistoryName
              HistoryName allows you to specify the name of the history file produced by AWFFull. The history file keeps the data  for  up  to  12
              months  worth  of logs, used for generating the main HTML page (index.html). The default is a file named awffull.hist, stored in the
              specified output directory. If you specify just the filename (without a path), it will be kept in the  specified  output  directory.
              Otherwise, the path is relative to the output directory, unless absolute (leading /).

ANALYSIS OPTIONS
       These are the basic analysis options that one can and should modify to start fine tuning AWFFull against a given website.

       PageType
              PageType  lets  you  tell  AWFFull  what types of URL's you consider a 'page'. Most people consider html and cgi documents as pages,
              while not images and audio files. If no types are specified, defaults will be used ('htm', 'html', 'cgi' and HTMLExtension  if  dif‐
              ferent for web logs, 'txt' for ftp logs). Putting the more likely page types first in the list should increase the speed of a run.

              Do Not Use Wildcards Here. It will not work.

       NotPageType
              NotPageType  is the direct and incompatible opposite of PageType. You can use one set or the other, but not both. PageType specifies
              what *is* a Page, NotPageType specifies what *isn't*, and hence by implication, everything else is a page. Neither method is more or
              lessor  correct than the other. It's more what is more accurate for *your* site. Do not add the "." or use any wildcards.  As a gen‐
              eral rule. There are some assumed internal optimisations that may otherwise break. Those who understand  pcre's  would  do  well  to
              examine the source of parser.c if they wish to extract greater flexibility from the below.

       FoldSeqErr
              FoldSeqErr forces AWFFull to ignore sequence errors. This is useful for Netscape and other web servers that cache the writing of log
              records and do not guarantee that they will be in chronological order. The use of the FoldSeqErr option will cause out  of  sequence
              log  records  to  be  treated  as  if  they had the same time stamp as the last valid record. The default action is to ignore out of
              sequence log records.

       SearchEngine
              The SearchEngine keywords allow specification of search engines and their query strings on the URL. These are  used  to  locate  and
              report  what search strings are used to find your site. The first word is a substring to match in the referrer field that identifies
              the search engine, and the second is the URL variable used by that search engine to define it's search terms.

       VisitTimeout
              VisitTimeout allows you to set the default timeout for a visit (sometimes called a 'session'). The  default  is  30  minutes,  which
              should be fine for most sites. Visits are determined by looking at the time of the current request, and the time of the last request
              from the site. If the time difference is greater than the VisitTimeout value, it is considered a new visit,  and  visit  totals  are
              incremented. Value is the number of seconds to timeout (default=1800=30min)

       TrackPartialRequests
              TrackPartialRequests  is  used  to  track  206  codes. This gives two additional columns in the Top URLs tables. The first to "Hits"
              counts the number of partial requests The second to "Volume" counts the volume in partial requests This option is  more  of  use  to
              those with lots of PDF's.

       MangleAgents
              The  MangleAgents  allows  you  to  specify  how much, if any, AWFFull should mangle user agent names. This allows several levels of
              detail to be produced when reporting user agent statistics. There are six levels that can be specified, which define different  lev‐
              els  of  detail  suppression.  Level  5 shows only the browser name (MSIE or Mozilla) and the major version number. Level 4 adds the
              minor version number (single decimal place). Level 3 displays the minor version to two decimal places. Level 2  will  add  any  sub-
              level  designation (such as Mozilla/3.01Gold or MSIE 3.0b). Level 1 will attempt to also add the system type if it is specified. The
              default Level 0 displays the full user agent field without modification and produces the greatest amount of detail. User agent names
              that can't be mangled will be left unmodified.

       AssignToCountry
              AssignToCountry  allows  a  form of override to force given domains to a specified country. Use the standard 2 letter country codes.
              Can also use org, com, net and so on, if more appropriate.  With judicious use of AllSites, GroupSite and 'whois',  this  can  cover
              the majority of your users without too much effort.

       IndexAlias
              AWFFull  normally  strips  the  string  'index.'  off  the  end  of  URL's  in order to consolidate URL totals. For example, the URL
              /somedir/index.html is turned into /somedir/ which is really the same URL. This option allows you to specify additional  strings  to
              treat  in  the  same  way. You don't need to specify 'index.' as it is always scanned for by AWFFull, this option is just to specify
              _additional_ strings if needed. If you don't need any, don't specify any as each string will be scanned for in EVERY log record... A
              bunch  of  them  will degrade performance. Also, the string is scanned for anywhere in the URL, so a string of 'home' would turn the
              URL /somedir/homepages/brad/home.html into just /somedir/ which is probably not what was intended.

       IgnoreIndexAlias
              The opposite (in a way) of IndexAlias is IgnoreIndexAlias.  This will STOP any URL variable  stripping,  as  well  as  ignoring  the
              default "index." setting, or any that you set above.

IGNORE* OPTIONS
       The Ignore* keywords allow you to completely ignore, or filter away, log records based on hostname, URL, user agent, referrer or user name.
       Use the same syntax as the Hide* keywords, where the value can have a leading or trailing wildcard '*'.

       IgnoreURL
              Filters out traffic accessing certain URLs. eg You may wish to avoid seeing traffic that  accesses  administration  functions,  thus
              "IgnoreURL /admin*". URLs are case sensitive.

       IgnoreSite
              Ignore  sites  that  visit  this website. Ignore by what is presented to awffull - name or IP Address. Sites are lowercased prior to
              filtering, so if Ignore'ing by name, do use a lowercased Value.

       IgnoreReferrer
              Ignore specified referrers. Very useful for filtering away SPAM Referrers. Referrers are partially case sensitive. \o/ The host por‐
              tion is lowercased; the URI is case sensitive.

       IgnoreUser
              Ignore specified users. User names are lowercased prior to filtering.

       IgnoreAgent
              Agents are case sensitive.

INCLUDE* OPTIONS
       The  Include*  keywords  allow  you  to  force  the inclusion of log records based on hostname, URL, user agent, referrer or user name. The
       Include* keywords take precedence over the Ignore* keywords.

       Note: Using Ignore/Include combinations to selectively process parts of a web site is _extremely inefficient_!!! Avoid doing so if possible
       ie: grep or gawk the records to a separate file if you really want that kind of report.

       IncludeURL

       IncludeSite

       IncludeReferrer

       IncludeUser

       IncludeAgent

SEGMENTING OPTIONS
       Segmenting  is  a  bit like the Ignore* and Include* keywords. Where it differs is in "remembering". Such that, as a ‘session’ (or ‘visit’)
       moves away from the original entry condition, that session is still tracked. So if you segment on a referal from Google, only sessions that
       were refered to the analysed website, from Google, will be tracked. Even as that same session accesses other pages within the website.

       eg. Google -> Site Page 1 -> Site Page 2 -> Site Page 3

       Whereas Ignore/Include would only filter the first interaction. eg.  Google -> Site Page 1

       By  "session"  (or  ‘visit’)  it is meant that the time limitation of a session (typically 30 minutes timeout) will impact. So in the above
       example from Google, if the last step (from Page 2 to Page 3) occured 31+ minutes after the Page 1 to Page 2 transition,  then  this  final
       step would NOT be included. The trail would be:

       Google -> Site Page 1 -> Site Page 2

       Please  do  be aware that currently AWFFull uses IP Addresses to determine the continuation of a given session. This will be most flawed if
       you have a user population that sits behind corporate firewalls, or ISP Proxies. To mention two major problem areas.

       Why do Segmenting?

       ⟨http://judah.webanalyticsdemystified.com/2007/11/a-few-tips-on-web-analytics-segmentation.html⟩

       ‘Segment analysis will tell you different things about your audience than you will realize from studying overall population metrics.’

       ‘The goal of segmentation is to maximize future value of that segment by optimizing your marketing mix.’

       With apologies to Judah for mixing his phrase order around.  :-)

       SegCountry
              Segment by Country: Only track sessions that come from the following countries. This will be determined by:

              1.  Use of AssignToCountry overrides

              2.  GeoIP lookups if so configured and enabled

              3.  Hostname TLD. eg .au

       The third option is generally going to be the worst for accuracy. eg. We have plenty of Australian IP addresses that otherwise  resolve  to
       .com or .net etc.

       It is strongly advised to enable GeoIP if you wish to use this option.

       SegReferer
              Segment by Referer: Only track sessions that originated from the following referers. NOTE!!!! SegReferer only works against the HOST
              name. Not the full URL.

DISPLAY OPTIONS
       The Display Options modify the resulting output that AWFFull produces. Things like HTML Headers and Footers to add  on  every  page.  These
       options don't change the numbers that AWFFull will calculate, but may change which ones appear, giving the illusion of a numerical change.

       ReportTitle
              ReportTitle is the text to display as the title. The hostname (unless blank) is appended to the end of this string (separated with a
              space) to generate the final full title string. Default is (for English) ‘Usage Statistics for’.

       HostName
              HostName defines the hostname for the report. This is used in the title, and is prepended to the URL table items. This allows click‐
              ing  on URL's in the report to go to the proper location in the event you are running the report on a 'virtual' web server, or for a
              server different than the one the report resides on. If not specified here, or on the command line, AWFFull  will  try  to  get  the
              hostname via a uname system call. If that fails, it will default to ‘localhost’.

       IndexMonths
              This option controls how many years worth of data to display on the front summary page. In months. eg: Display the last 5 years: 5 x
              12 = 60

       DailyStats
              DailyStats allows the daily statistics table to be disabled - not displayed. Values may be ‘yes’ or ‘no’. Default is ‘yes’ - do dis‐
              play the Daily Statistics table.

       HourlyStats
              HourlyGraph  and  HourlyStats  allows the hourly statistics graph and statistics table to be disabled (not displayed). Values may be
              "yes" or "no". Default is "yes".

       CSSFilename
              CSSFilename is used to set the name of the CSS file to use in conjunction with the generated html. An existing file is not overwrit‐
              ten, so feel free to make you own changes to the default file. The default is awffull.css.

       FlagsLocation
              FlagsLocation will enable the display of country flag pictures in the country table. The path is that for a webserver, not file sys‐
              tem. Can be relative or complete. The trailing slash is not necessary. The default location is not set and hence will not be used.

       YearlySubtotals
              YearlySubtotals will display the subtotal for a given year in the main page. This is in addition to the Grand Total of all years.

       GroupShading
              The GroupShading allows grouped rows to be shaded in the report. Useful if you have lots  of  groups  and  individual  records  that
              intermingle  in  the  report,  and you want to differentiate the group records a little more. Value can be ‘yes’ or ‘no’, with ‘yes’
              being the default.

       GroupHighlight
              GroupHighlight allows the group record to be displayed in BOLD. Can be either ‘yes’ or ‘no’ with the default being ‘yes’.

       HTMLExtension
              HTMLExtension allows you to specify the filename extension to use for generated HTML pages. Normally, this defaults to  "html",  but
              can be changed for sites who need it (like for PHP embedded pages).

       UseHTTPS
              UseHTTPS  should  be  used  if  the analysis is being run on a secure server, and links to urls should use ‘https://’ instead of the
              default ‘http://’. If you need this, set it to ‘yes’. Default is ‘no’. This only changes the behaviour of the ‘Top URLs’ table.

       Top*   The various ‘Top’ options below define the number of entries for each table. Tables may be disabled by using zero (0) for the value.

       TopURLs
              The most accessed URLs or Resources by number of requests (hits). Includes both Pages and Images, for example. Defaults to 30 URLs.

       TopKURLs
              The greatest volume generating URLs. Defaults to 10 URL's.

       TopEntry
              The most accessed initial URLs within a complete Visit. Will also display Single Access counts,  Stickiness  ration  and  Popularity
              ratio. Defaults to 10 URLs.

       TopExit
              The  most  accessed  last  URLs  within a complete Visit. ie: The last page recorded of a Visit. Also displays the Popularity ratio.
              Defaults to 10 URLs.

       Top404Errors
              The most seen error requests and a corresponding referring URL. Defaults to 0, ie not shown.

       TopSites
              Those Sites that have accessed the most Pages. Default is 30 Sites.

       TopKSites
              Those Sites that have downloaded the greatest Volume. Default is 10 Sites.

       TopReferrers
              Those local and remote URLs that refer the most requests.  Default is 30 Referrers.

       TopSearch
              Those words and phrases used at remote Search Engines to direct traffic here. Default is 20 Phrases.

       TopUsers
              Those logged in users who most use the site. Default is 20 Users.

       TopAgents
              The Browser Agents that are busiest against this site. Default is 15 Agents.

       TopCountries
              A view of all traffic against this site via country.

       All*   The All* keywords allow the display of all the below measures.  If enabled, a separate HTML page will be created, and a link will be
              added  to  the  bottom of the appropriate "Top" table. There are a couple of conditions for this to occur. First, there must be more
              items than will fit in the "Top" table (otherwise it would just be duplicating what is already displayed). Second, the listing  will
              only  show  those  items  that  are  normally visible, which means it will not show any hidden items. Grouped entries will be listed
              first, followed by individual items. The value for these keywords can be either 'yes' or 'no', with the default being  'no'.  Please
              be  aware that these pages can be quite large in size, particularly the sites page, and separate pages are generated for each month,
              which can consume quite a lot of disk space depending on the traffic to your site.

       AllURLs
              All accessed URLs

       AllEntryPages
              All Pages that initialised a Visit

       AllExitPages
              All the last or exit pages in all Visits.

       All404Errors
              All ErrorRequests and the corresponding referral URLs.

       AllSites
              All remote sites that accessed this website.

       AllReferrers
              All local and remote referring URLs

       AllSearchStr
              All Remote Search Engine words and Phrases used to refer traffic here.

       AllUsers
              All users who logged into this website.

       AllAgents
              All Browser Agents used to access this site. Useful for identifying robots.

       GMTTime
              GMTTime allows reports to show GMT (UTC) time instead of local time. Default is to display the time the report was generated in  the
              timezone  of  the local machine, such as EDT or PST. This keyword allows you to have times displayed in UTC instead. Use only if you
              really have a good reason, since it will probably screw up the reporting periods by however many hours your local time zone  is  off
              of GMT.

       HTMLPre
              HTMLPre  defines  HTML code to insert at the very beginning of the file. Default is the DOCTYPE line shown below. Max line length is
              80 characters, so use multiple HTMLPre lines if you need more.

       HTMLHead
              HTMLHead defines HTML code to insert within the <HEAD></HEAD> block, immediately after the <TITLE> line. Maximum line length  is  80
              characters, so use multiple lines if needed.

       HTMLBody
              HTMLBody defined the HTML code to be inserted, starting with the <BODY> tag. If not specified, the default is shown below.  If used,
              you MUST include your own <BODY> tag as the first line. Maximum line length is 80 char, use multiple lines if needed.

       HTMLPost
              HTMLPost defines the HTML code to insert immediately before the first <HR> on the document, which is just after the title and  "sum‐
              mary  period"-"Generated  on:"  lines.  If anything, this should be used to clean up in case an image was inserted with HTMLBody. As
              with HTMLHead, you can define as many of these as you want and they will be inserted in the output stream in  order  of  appearance.
              Max string size is 80 characters. Use multiple lines if you need to.

       HTMLTail
              HTMLTail  defines  the  HTML code to insert at the bottom of each HTML document, usually to include a link back to your home page or
              insert a small graphic. It is inserted as a table data element (ie: <TD> your code here </TD>) and is right aligned with  the  page.
              The maximum string size is 80 characters.

       HTMLEnd
              HTMLEnd  defines  the HTML code to add at the very end of the generated files. It defaults to what is shown below. If used, you MUST
              specify the </BODY> and </HTML> closing tags as the last lines. The maximum string length is 80 characters.

GRAPHING OPTIONS
       As distinct from the general Display Options, the Graphing Options focus on manipulating the various graphs produced.

       CountryGraph
              CountryGraph allows the usage by country graph to be disabled.  Values can be 'yes' or 'no', default is 'yes'.

       DailyGraph
              DailyGraph determines if the daily statistics graph will be displayed or not. Values may be "yes" or "no". Default  is  "yes"  -  do
              display the daily graph.

       HourlyGraph
              HourlyGraph  determines  if  the daily statistics graph will be displayed or not. Values may be "yes" or "no". Default is "yes" - do
              display the hourly graph.

       TopURLsbyHitsGraph
              Display a pie chart of the top URLs by HITS

       TopURLsbyVolGraph
              Display a pie chart of the top URLs by HITS

       TopExitPagesGraph
              Display Top Exit Pages Pie Chart. Values may be ‘hits’ or ‘visits’ or "no". Default is "no"

              ‘hits’ means order the graph by hits

              ‘visits’ means order the graph by visits

       TopEntryPagesGraph
              Display Top Entry Pages Pie Chart. Values may be ‘hits’ or ‘visits’ or "no". Default is "no"

              ‘hits’ means order the graph by hits

              ‘visits’ means order the graph by visits

       TopSitesbyPagesGraph
              Display a pie chart of the Top Sites by Page Impressions

       TopSitesbyVolGraph
              Display a pie chart of the Top Sites by Page Impressions

       TopAgentsGraph
              Display a pie chart of the Top User Agents (by pages)

       GraphLegend
              GraphLegend allows the color coded legends to be turned on or off in the graphs. The default is for them to be displayed. This  only
              toggles the color coded legends, the other legends are not changed. If you think they are hideous and ugly, say 'no' here :)

       GraphLines
              GraphLines allows you to have index lines drawn behind the graphs. Anything other than "no" will enable the lines.

       Graph*X and Graph*Y
              The  following  Graph*X  and Graph*Y options are used to modify the sizes of the created charts. The default settings are shown. The
              defaults are also the minimum settings. #define GRAPH_INDEX_X 512 /* px. Default X size (512) */ #define GRAPH_INDEX_Y  256  /*  px.
              Default  Y  size (256) */ #define GRAPH_DAILY_X 512 /* px. Daily X size (512) */ #define GRAPH_DAILY_Y 400 /* px. Daily Y size (400)
              */ #define GRAPH_HOURLY_X 512 /* px. Daily X size (512) */ #define  GRAPH_HOURLY_Y  400  /*  px.  Daily  Y  size  (400)  */  #define
              GRAPH_PIE_X 512 /* px. Pie X size (512) */ #define GRAPH_PIE_Y 300 /* px. Pie Y size (300) */

       GraphIndexX
              The main chart on the front page. Summary of all Months.  Default is 512 pixels.

       GraphIndexY
              Default is 256 pixels.

       GraphDailyX
              The Day by Day Summary graph at the start of each Months Summary. Default is 512 pixels.

       GraphDailyY
              Default is 400 pixels.

       GraphHourlyX
              The Hourly Average graph within each Months Summary. Default is 512 pixels.

       GraphHourlyY
              Default is 400 pixels.

       GraphPieX
              All pie charts are the same size. Default is 512 pixels.

       GraphPieY
              Default is 300 pixels.

       Graph and Table Colours
              The  custom  bar  graph  and pie Colours can be overridden with these options. Declare them in the standard hexadecimal way - as per
              HTML but without the '#'. If none are given, you will get the default AWFFull colors.

       ColorHit
              Default value is ‘00805C’ (dark green)

       ColorFile
              Default value is ‘0000FF’ (blue)

       ColorSite
              Default value is ‘FF8000’ (orange)

       ColorKbyte
              Default value is ‘FF0000’ (red)

       ColorPage
              Default value is ‘00E0FF’ (cyan)

       ColorVisit
              Default value is ‘FFFF00’ (yellow)

       PieColor1
              Default value is ‘00805C’ (dark green)

       PieColor2
              Default value is ‘0000FF’ (blue)

       PieColor3
              Default value is ‘FF8000’ (orange)

       PieColor4
              Default value is ‘FF0000’ (red)

GROUP* OPTIONS
       The Group* keywords permit the grouping of similar objects as if they were one. Grouped records are displayed in the ‘Top’ tables  and  can
       optionally  be  displayed in bold and/or shaded. Groups cannot be hidden, and are not counted in the main totals. The Group* options do not
       hide the individual items that are members of the Group. If you wish to hide the records that match - so just the grouping record  is  dis‐
       played  -  follow with an identical Hide* keyword with the same value. Or use the single GroupAndHide* keyword that matches, instead of the
       Group* and Hide* combination.

       Group* keywords may have an optional label which will be displayed instead of the keywords value. The label should be  separated  from  the
       value by at least one white-space character, such as a space or tab.

       The  Hide*,  Group*  and  Ignore* and Include* keywords allow you to change the way Sites, URL's, Referrers, User Agents and User names are
       manipulated. The Ignore* keywords will cause AWFFull to completely ignore records as if they didn't exist (and thus not counted in the main
       site  totals).  The  Hide*  keywords  will  prevent  things from being displayed in the 'Top' tables, but will still be counted in the main
       totals. The Group* keywords allow grouping similar objects as if they were one. Grouped records are displayed in the 'Top' tables  and  can
       optionally  be displayed in BOLD and/or shaded. Groups cannot be hidden, and are not counted in the main totals. The Group* options do not,
       by default, hide all the items that it matches. If you want to hide the records that match (so just the grouping record is displayed), fol‐
       low  with an identical Hide* keyword with the same value. (see example below) In addition, Group* keywords may have an optional label which
       will be displayed instead of the keywords value.  The label should be separated from the value by at  least  one  'white-space'  character,
       such as a space or tab.

       The  value can have either a leading or trailing '*' wildcard character. If no wildcard is found, a match can occur anywhere in the string.
       Given a string ‘www.yourmama.com’, the values ‘your’, ‘*mama.com’ and ‘www.your*’ will all match.

       GroupURL

       GroupSite

       GroupReferrer

       GroupUser

       GroupAgent

       GroupDomains
              The GroupDomains keyword allows you to group individual host names into their respective domains. The value specifies the  level  of
              grouping  to perform, and can be thought of as 'the number of dots' that will be displayed. For example, if a visiting host is named
              cust1.tnt.mia.uu.net, a domain grouping of 1 will result in just "uu.net" being displayed, while a 2 will  result  in  "mia.uu.net".
              The default value of zero disable this feature.  Domains will only be grouped if they do not match any existing "GroupSite" records,
              which allows overriding this feature with your own if desired.

HIDE* OPTIONS
       The Hide* keywords will prevent things from being displayed in the 'Top' tables. The hidden items will still be counted in the main totals.

       HideURL
              Hide URL matching name.

       HideSite
              Hide site matching name.

       HideReferrer
              Hide referrer matching name.

       HideUser

       HideAgent
              Hide user agents matching name.

       HideAllSites
              HideAllSites allows forcing individual sites to be hidden in the report. This is particularly useful when used in  conjunction  with
              the  "GroupDomain"  feature,  but  could  be useful in other situations as well, such as when you only want to display grouped sites
              (with the GroupSite keywords...). The value for this keyword can be either 'yes' or 'no', with 'no' the default, allowing individual
              sites to be displayed.

GROUPANDHIDE* OPTIONS
       All  the  Hide  and Group "name" options can be combined in a single config line. eg GroupAndHideURL. If you start using the Group* options
       you will find that you tend to match every Group* option with a corresponding Hide* option. The GroupAndHide* options simply short  circuit
       this unnecessary duplication.

       GroupAndHideURL

       GroupAndHideSite

       GroupAndHideReferrer

       GroupAndHideUser

       GroupAndHideAgent

DATA DUMP OPTIONS
       The  Dump*  keywords allow the dumping of Sites, URL's, Referrers User Agents, User names and Search strings to separate tab delimited text
       files, suitable for import into most database or spreadsheet programs.

       DumpPath
              DumpPath specifies the path to dump the files. If not specified, it will default to the current  output  directory.  Do  not  use  a
              trailing slash ('/').

       DumpHeader
              The  DumpHeader keyword specifies if a header record should be written to the file. A header record is the first record of the file,
              and contains the labels for each field written. Normally, files that are intended to be imported into a  database  system  will  not
              need a header record, while spreadsheets usually do. Value can be either 'yes' or 'no', with 'no' being the default.

       DumpExtension
              DumpExtension  allow  you to specify the dump filename extension to use. The default is "tab", but some programs are picky about the
              filenames they use, so you may change it here (for example, some people may prefer to use "csv").

       DumpURLs

       DumpEntryPages

       DumpExitPages

       DumpSites

       DumpReferrers

       DumpSearchStr

       DumpUsers

       DumpAgents

       DumpCountries

EXAMPLES
       Sample Extract of a configuration file:

       # The 'auto' value means that AWFFull will try and work out what log format
       # you are sending to it. If no joy, AWFFull will immediately exit.

       LogType        auto

       # OutputDir is where you want to put the output files.  This should
       # should be a full path name, however relative ones might work as well.
       # If no output directory is specified, the current directory will be used.

       OutputDir      .

       Minimal configuration file:

       # Sample *MINIMAL* AWFFull configuration file
       #
       # The below settings are the only ones you *really* need to worry about
       # when configuring AWFFull. See the sample.conf file for all options if
       # the below only serves to whet your appetite.
       #
       # See awfful(1) or sample.conf for full explanations.

       # We can do a little bit each day, or hour...
       Incremental             yes

       # Your server name to display
       HostName                www.my_example.site

       ##---------------------------
       # Use PageType OR NotPageType
       # I personally prefer NotPageType - YMMV!
       PageType                htm
       PageType                html
       PageType                php
       #PageType               pl
       #PageType               cfm
       #PageType               pdf
       #PageType               txt
       #PageType               cgi
       ### OR! ---------------------
       #NotPageType            gif
       #NotPageType            css
       #NotPageType            js
       #NotPageType            jpg
       #NotPageType            ico
       #NotPageType            png
       ##---------------------------

       # Should always fold in Sequence Errors. Logs can be messy...
       FoldSeqErr              yes

       # If you want to see the country flags, uncomment the following.
       # This is the, possibly relative, URL where the flag flies are located.
       #FlagsLocation          flags

       .fi

SEE ALSO
       awffull(1)

BUGS
       None currently known. YMMV....

       Report bugs to ⟨https://bugs.launchpad.net/awffull⟩, or use the email discussion list: <awffull@stedee.id.au>

NOTES
       In case it is not obvious: AWFFull is a play/pun on the word ‘awful’, and is pronounced the same way. Yes it was deliberate.

REFERENCES
       [1] Web Site Measurement Hacks. Eric T. Peterson (and others).  O'Reilly. ISBN 0-596-00988-7.

                                                                    2008-Dec-13                                                    awffull.conf(5)
