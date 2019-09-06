SPAMASSASSIN(1p)                                        User Contributed Perl Documentation                                       SPAMASSASSIN(1p)

NAME
       spamassassin - extensible email filter used to identify spam

DESCRIPTION
       SpamAssassin is an intelligent email filter which uses a diverse range of tests to identify unsolicited bulk email, more commonly known as
       "spam".  These tests are applied to email headers and content to classify email using advanced statistical methods.  In addition,
       SpamAssassin has a modular architecture that allows other technologies to be quickly wielded against spam and is designed for easy
       integration into virtually any email system.

SYNOPSIS
       For ease of access, the SpamAssassin manual has been split up into several sections.  If you're intending to read these straight through
       for the first time, the suggested order will tend to reduce the number of forward references.

       Extensive additional documentation for SpamAssassin is available, primarily on the SpamAssassin web site and wiki.

       You should be able to view SpamAssassin's documentation with your man(1) program or perldoc(1).

   OVERVIEW
           spamassassin              SpamAssassin overview (this section)

   CONFIGURATION
           Mail::SpamAssassin::Conf  SpamAssassin configuration files

   USAGE
           spamassassin-run          "spamassassin" front-end filtering script
           sa-learn                  train SpamAssassin's Bayesian classifier
           spamc                     client for spamd (faster than spamassassin)
           spamd                     spamassassin server (needed by spamc)

   DEFAULT PLUGINS
           Mail::SpamAssassin::Plugin::AskDNS
           Mail::SpamAssassin::Plugin::AutoLearnThreshold
           Mail::SpamAssassin::Plugin::Bayes
           Mail::SpamAssassin::Plugin::BodyEval
           Mail::SpamAssassin::Plugin::Check
           Mail::SpamAssassin::Plugin::DKIM
           Mail::SpamAssassin::Plugin::DNSEval
           Mail::SpamAssassin::Plugin::FreeMail
           Mail::SpamAssassin::Plugin::HTMLEval
           Mail::SpamAssassin::Plugin::HTTPSMismatch
           Mail::SpamAssassin::Plugin::Hashcash
           Mail::SpamAssassin::Plugin::HeaderEval
           Mail::SpamAssassin::Plugin::ImageInfo
           Mail::SpamAssassin::Plugin::MIMEEval
           Mail::SpamAssassin::Plugin::MIMEHeader
           Mail::SpamAssassin::Plugin::Pyzor
           Mail::SpamAssassin::Plugin::Razor2
           Mail::SpamAssassin::Plugin::RelayEval
           Mail::SpamAssassin::Plugin::ReplaceTags
           Mail::SpamAssassin::Plugin::SPF
           Mail::SpamAssassin::Plugin::SpamCop
           Mail::SpamAssassin::Plugin::URIDNSBL
           Mail::SpamAssassin::Plugin::URIDetail
           Mail::SpamAssassin::Plugin::URIEval
           Mail::SpamAssassin::Plugin::VBounce
           Mail::SpamAssassin::Plugin::WLBLEval
           Mail::SpamAssassin::Plugin::WhiteListSubject

WEB SITES
           SpamAssassin web site:     http://spamassassin.apache.org/
           Wiki-based documentation:  http://wiki.apache.org/spamassassin/

USER MAILING LIST
       A users mailing list exists where other experienced users are often able to help and provide tips and advice.  Subscription instructions
       are located on the SpamAssassin web site.

CONFIGURATION FILES
       The SpamAssassin rule base, text templates, and rule description text are loaded from configuration files.

       Default configuration data is loaded from the first existing directory in:

       /var/lib/spamassassin/3.004002
       /usr/share/spamassassin
       /usr/share/spamassassin
       /usr/local/share/spamassassin
       /usr/share/spamassassin

       Site-specific configuration data is used to override any values which had already been set.  This is loaded from the first existing
       directory in:

       /etc/spamassassin
       /usr/etc/mail/spamassassin
       /usr/etc/spamassassin
       /usr/local/etc/spamassassin
       /usr/pkg/etc/spamassassin
       /usr/etc/spamassassin
       /etc/mail/spamassassin
       /etc/spamassassin

       From those three directories, SpamAssassin will first read files ending in ".pre" in lexical order and then it will read files ending in
       ".cf" in lexical order (most files begin with two numbers to make the sorting order obvious).

       In other words, it will read init.pre first, then 10_default_prefs.cf before 50_scores.cf and 20_body_tests.cf before 20_head_tests.cf.
       Options in later files will override earlier files.

       Individual user preferences are loaded from the location specified on the "spamassassin", "sa-learn", or "spamd" command line (see
       respective manual page for details).  If the location is not specified, ~/.spamassassin/user_prefs is used if it exists.  SpamAssassin will
       create that file if it does not already exist, using user_prefs.template as a template.  That file will be looked for in:

       /etc/spamassassin
       /usr/etc/mail/spamassassin
       /usr/share/spamassassin
       /etc/spamassassin
       /etc/mail/spamassassin
       /usr/local/share/spamassassin
       /usr/share/spamassassin

TAGGING
       The following two sections detail the default tagging and markup that takes place for messages when running "spamassassin" or "spamc" with
       "spamd" in the default configuration.

       Note: before header modification and addition, all headers beginning with "X-Spam-" are removed to prevent spammer mischief and also to
       avoid potential problems caused by prior invocations of SpamAssassin.

   TAGGING FOR SPAM MAILS
       By default, all messages with a calculated score of 5.0 or higher are tagged as spam.

       If an incoming message is tagged as spam, instead of modifying the original message, SpamAssassin will create a new report message and
       attach the original message as a message/rfc822 MIME part (ensuring the original message is completely preserved and easier to recover).

       The new report message inherits the following headers (if they are present) from the original spam message:

       From: header
       To: header
       Cc: header
       Subject: header
       Date: header
       Message-ID: header

       The above headers can be modified if the relevant "rewrite_header" option is given (see "Mail::SpamAssassin::Conf" for more information).

       By default these message headers are added to spam:

       X-Spam-Flag: header
           Set to "YES".

       The headers that added are fully configurable via the "add_header" option (see "Mail::SpamAssassin::Conf" for more information).

       spam mail body text
           The SpamAssassin report is added to top of the mail message body, if the message is marked as spam.

   DEFAULT TAGGING FOR ALL MAILS
       These headers are added to all messages, both spam and ham (non-spam).

       X-Spam-Checker-Version: header
           The version and subversion of SpamAssassin and the host where SpamAssassin was run.

       X-Spam-Level: header
           A series of "*" charactes where each one represents a full score point.

       X-Spam-Status: header
           A string, "(Yes|No), score=nn required=nn tests=xxx,xxx autolearn=(ham|spam|no|unavailable|failed)" is set in this header to reflect
           the filter status.  For the first word, "Yes" means spam and "No" means ham (non-spam).

       The headers that added are fully configurable via the "add_header" option (see "Mail::SpamAssassin::Conf" for more information).

INSTALLATION
       The spamassassin command is part of the Mail::SpamAssassin Perl module.  Install this as a normal Perl module, using "perl -MCPAN -e
       shell", or by hand.

       Note that it is not possible to use the "PERL5LIB" environment variable to affect where SpamAssassin finds its perl modules, due to
       limitations imposed by perl's "taint" security checks.

       For further details on how to install, please read the "INSTALL" file from the SpamAssassin distribution.

DEVELOPER DOCUMENTATION
           Mail::SpamAssassin
               Spam detector and markup engine

           Mail::SpamAssassin::ArchiveIterator
               find and process messages one at a time

           Mail::SpamAssassin::AutoWhitelist
               auto-whitelist handler for SpamAssassin

           Mail::SpamAssassin::Bayes
               determine spammishness using a Bayesian classifier

           Mail::SpamAssassin::BayesStore
               Bayesian Storage Module

           Mail::SpamAssassin::BayesStore::SQL
               SQL Bayesian Storage Module Implementation

           Mail::SpamAssassin::Conf::LDAP
               load SpamAssassin scores from LDAP database

           Mail::SpamAssassin::Conf::Parser
               parse SpamAssassin configuration

           Mail::SpamAssassin::Conf::SQL
               load SpamAssassin scores from SQL database

           Mail::SpamAssassin::Message
               decode, render, and hold an RFC-2822 message

           Mail::SpamAssassin::Message::Metadata
               extract metadata from a message

           Mail::SpamAssassin::Message::Node
               decode, render, and make available MIME message parts

           Mail::SpamAssassin::PerMsgLearner
               per-message status (spam or not-spam)

           Mail::SpamAssassin::PerMsgStatus
               per-message status (spam or not-spam)

           Mail::SpamAssassin::PersistentAddrList
               persistent address list base class

           Mail::SpamAssassin::Plugin
               SpamAssassin plugin base class

           Mail::SpamAssassin::Plugin::Hashcash
               perform hashcash verification tests

           Mail::SpamAssassin::Plugin::RelayCountry
               add message metadata indicating the country code of each relay

           Mail::SpamAssassin::Plugin::SPF
               perform SPF verification tests

           Mail::SpamAssassin::Plugin::URIDNSBL
               look up URLs against DNS blocklists

           Mail::SpamAssassin::SQLBasedAddrList
               SpamAssassin SQL Based Auto Whitelist

BUGS
       See <http://issues.apache.org/SpamAssassin/>

AUTHORS
       The SpamAssassin(tm) Project <http://spamassassin.apache.org/>

COPYRIGHT AND LICENSE
       SpamAssassin is distributed under the Apache License, Version 2.0, as described in the file "LICENSE" included with the distribution.

       Copyright (C) 2015 The Apache Software Foundation

perl v5.22.1                                                        2018-11-06                                                    SPAMASSASSIN(1p)
spamassassin-run(3pm)                                   User Contributed Perl Documentation                                  spamassassin-run(3pm)

NAME
       spamassassin - simple front-end filtering script for SpamAssassin

SYNOPSIS
       spamassassin [options] [ < mailmessage | path ... ]

       spamassassin -d [ < mailmessage | path ... ]

       spamassassin -r [ < mailmessage | path ... ]

       spamassassin -k [ < mailmessage | path ... ]

       spamassassin -W|-R [ < mailmessage | path ... ]

       Options:

        -L, --local                       Local tests only (no online tests)
        -r, --report                      Report message as spam
        -k, --revoke                      Revoke message as spam
        -d, --remove-markup               Remove spam reports from a message
        -C path, --configpath=path, --config-file=path
                                          Path to standard configuration dir
        -p prefs, --prefspath=file, --prefs-file=file
                                          Set user preferences file
        --siteconfigpath=path             Path for site configs
                                          (def: /etc/spamassassin)
        --cf='config line'                Additional line of configuration
        -x, --nocreate-prefs              Don't create user preferences file
        -e, --exit-code                   Exit with a non-zero exit code if the
                                          tested message was spam
        --mbox                            read in messages in mbox format
        --mbx                             read in messages in UW mbx format
        -t, --test-mode                   Pipe message through and add extra
                                          report to the bottom
        --lint                            Lint the rule set: report syntax errors
        -W, --add-to-whitelist            Add addresses in mail to persistent address whitelist
        --add-to-blacklist                Add addresses in mail to persistent address blacklist
        -R, --remove-from-whitelist       Remove all addresses found in mail from
                                          persistent address list
        --add-addr-to-whitelist=addr      Add addr to persistent address whitelist
        --add-addr-to-blacklist=addr      Add addr to persistent address blacklist
        --remove-addr-from-whitelist=addr Remove addr from persistent address list
        -4 --ipv4only, --ipv4-only, --ipv4 Use IPv4, disable use of IPv6 for DNS etc.
        -6                                Use IPv6, disable use of IPv4 where possible
        --progress                        Print progress bar
        -D, --debug [area=n,...]          Print debugging messages
        -V, --version                     Print version
        -h, --help                        Print usage message

DESCRIPTION
       spamassassin is a simple front-end filter for SpamAssassin.

       Using the SpamAssassin rule base, it uses a wide range of heuristic tests on mail headers and body text to identify "spam", also known as
       unsolicited bulk email.  Once identified, the mail is then tagged as spam for later filtering using the user's own mail user-agent
       application.

       The default tagging operations that take place are detailed in "TAGGING" in spamassassin.

       By default, message(s) are read in from STDIN (< mailmessage), or from specified files and directories (path ...)  STDIN and files are
       assumed to be in file format, with a single message per file.  Directories are assumed to be in a format where each file in the directory
       contains only one message (directories are not recursed and filenames containing whitespace or beginning with "." or "," are skipped).  The
       options --mbox and --mbx can override the assumed format, see the appropriate OPTION information below.

       Please note that SpamAssassin is not designed to scan large messages. Don't feed messages larger than about 500 KB to SpamAssassin, as this
       will consume a huge amount of memory.

OPTIONS
       -e, --error-code, --exit-code
           Exit with a non-zero error code, if the message is determined to be spam.

       -h, --help
           Print help message and exit.

       -V, --version
           Print version and exit.

       -t, --test-mode
           Test mode.  Pipe message through and add extra report.  Note that the report text assumes that the message is spam, since in normal use
           it is only visible in this case.  Pay attention to the score instead.

           If you run this with -d, the message will first have SpamAssassin markup removed before being tested.

       -r, --report
           Report this message as manually-verified spam.  This will submit the mail message read from STDIN to various spam-blocker databases.
           Currently, these are the Distributed Checksum Clearinghouse "http://www.dcc-servers.net/dcc/", Pyzor "http://pyzor.org/", Vipul's Razor
           "http://razor.sourceforge.net/", and SpamCop "http://www.spamcop.net/".

           If the message contains SpamAssassin markup, the markup will be stripped out automatically before submission.  The support modules for
           DCC, Pyzor, and Razor must be installed for spam to be reported to each service.  SpamCop reports will have greater effect if you
           register and set the "spamcop_to_address" option.

           The message will also be submitted to SpamAssassin's learning systems; currently this is the internal Bayesian statistical-filtering
           system (the BAYES rules).  (Note that if you only want to perform statistical learning, and do not want to report mail to third-
           parties, you should use the "sa-learn" command directly instead.)

       -k, --revoke
           Revoke this message.  This will revoke the mail message read from STDIN from various spam-blocker databases.  Currently, these are
           Vipul's Razor.

           Revocation support for the Distributed Checksum Clearinghouse, Pyzor, and SpamCop is not currently available.

           If the message contains SpamAssassin markup, the markup will be stripped out automatically before submission.  The support modules for
           Razor must be installed for spam to be revoked from the service.

           The message will also be submitted as 'ham' (non-spam) to SpamAssassin's learning systems; currently this is the internal Bayesian
           statistical-filtering system (the BAYES rules).  (Note that if you only want to perform statistical learning, and do not want to report
           mail to third-parties, you should use the "sa-learn" command directly instead.)

       --lint
           Syntax check (lint) the rule set and configuration files, reporting typos and rules that do not compile correctly.  Exits with 0 if
           there are no errors, or greater than 0 if any errors are found.

       -W, --add-to-whitelist
           Add all email addresses, in the headers and body of the mail message read from STDIN, to a persistent address whitelist.  Note that you
           must be running "spamassassin" or "spamd" with a persistent address list plugin enabled for this to work.

       --add-to-blacklist
           Add all email addresses, in the headers and body of the mail message read from STDIN, to the persistent address blacklist.  Note that
           you must be running "spamassassin" or "spamd" with a persistent address list plugin enabled for this to work.

       -R, --remove-from-whitelist
           Remove all email addresses, in the headers and body of the mail message read from STDIN, from a persistent address list. STDIN must
           contain a full email message, so to remove a single address you should use --remove-addr-from-whitelist instead.

           Note that you must be running "spamassassin" or "spamd" with a persistent address list plugin enabled for this to work.

       --add-addr-to-whitelist
           Add the named email address to a persistent address whitelist.  Note that you must be running "spamassassin" or "spamd" with a
           persistent address list plugin enabled for this to work.

       --add-addr-to-blacklist
           Add the named email address to a persistent address blacklist.  Note that you must be running "spamassassin" or "spamd" with a
           persistent address list plugin enabled for this to work.

       --remove-addr-from-whitelist
           Remove the named email address from a persistent address whitelist.  Note that you must be running "spamassassin" or "spamd" with a
           persistent address list plugin enabled for this to work.

        --ipv4only, --ipv4-only, --ipv4
           Do not use IPv6 for DNS tests. Normally, SpamAssassin will try to detect if IPv6 is available, using only IPv4 if it is not. Use if the
           existing tests for IPv6 availability produce incorrect results or crashes.

       -L, --local
           Do only the ''local'' tests, ones that do not require an internet connection to operate.  Normally, SpamAssassin will try to detect
           whether you are connected to the net before doing these tests anyway, but for faster checks you may wish to use this.

           Note that SpamAssassin's network rules are run in parallel.  This can cause overhead in terms of the number of file descriptors
           required if --local is not used; it is recommended that the minimum limit on fds be raised to at least 256 for safety.

       -d, --remove-markup
           Remove SpamAssassin markup (the "SpamAssassin results" report, X-Spam-Status headers, etc.) from the mail message.  The resulting
           message, which will be more or less identical to the original, pre-SpamAssassin input, will be output to STDOUT.

           (Note: the message will not be exactly identical; some headers will be reformatted due to some features of the Mail::Internet package,
           but the body text will be.)

       -C path, --configpath=path, --config-file=path
           Use the specified path for locating the distributed configuration files.  Ignore the default directories (usually
           "/usr/share/spamassassin" or similar).

       --siteconfigpath=path
           Use the specified path for locating site-specific configuration files.  Ignore the default directories (usually "/etc/spamassassin" or
           similar).

       --cf='config line'
           Add additional lines of configuration directly from the command-line, parsed after the configuration files are read.   Multiple --cf
           arguments can be used, and each will be considered a separate line of configuration.  For example:

                   spamassassin -t --cf="body NEWRULE /text/" --cf="score NEWRULE 3.0"

       -p prefs, --prefspath=prefs, --prefs-file=prefs
           Read user score preferences from prefs (usually "$HOME/.spamassassin/user_prefs").

       --progress
           Prints a progress bar (to STDERR) showing the current progress.  This option will only be useful if you are redirecting STDOUT (and not
           STDERR).  In the case where no valid terminal is found this option will behave very much like the --showdots option in other
           SpamAssassin programs.

       -D [area,...], --debug [area,...]
           Produce debugging output. If no areas are listed, all debugging information is printed. Diagnostic output can also be enabled for each
           area individually; area is the area of the code to instrument. For example, to produce diagnostic output on bayes, learn, and dns, use:

                   spamassassin -D bayes,learn,dns

           Higher priority informational messages that are suitable for logging in normal circumstances are available with an area of "info".

           For more information about which areas (also known as channels) are available, please see the documentation at:

                   L<http://wiki.apache.org/spamassassin/DebugChannels>

       -x, --nocreate-prefs
           Disable creation of user preferences file.

       --mbox
           Specify that the input message(s) are in mbox format.  mbox is a standard Unix message folder format.

       --mbx
           Specify that the input message(s) are in UW .mbx format.  mbx is the mailbox format used within the University of Washington's IMAP
           implementation; see "http://www.washington.edu/imap/".

SEE ALSO
       sa-learn(1) spamd(1) spamc(1) Mail::SpamAssassin::Conf(3) Mail::SpamAssassin(3)

PREREQUISITES
       "Mail::SpamAssassin"

BUGS
       See <http://issues.apache.org/SpamAssassin/>

AUTHORS
       The SpamAssassin(tm) Project <http://spamassassin.apache.org/>

COPYRIGHT
       SpamAssassin is distributed under the Apache License, Version 2.0, as described in the file "LICENSE" included with the distribution.

perl v5.22.1                                                        2018-11-06                                               spamassassin-run(3pm)
