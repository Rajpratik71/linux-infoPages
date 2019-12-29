RUN-MAILCAP(1)                           Run Mailcap Programs                           RUN-MAILCAP(1)

NAME
       run-mailcap, view, see, edit, compose, print - execute programs via entries in the mailcap file

SYNOPSIS
       run-mailcap --action=ACTION [--option[=value]] [MIME-TYPE:[ENCODING:]]FILE [...]

       The see, edit, compose and print versions are just aliases that default to the view, edit, com‐
       pose, and print actions (respectively).

DESCRIPTION
       run-mailcap (or any of its aliases) will use the given action to process each mime-type/file in
       turn.   Each  file is specified as its mime-type, its encoding (e.g. compression), and filename
       together, separated by colons.  If the mime-type is omitted, an attempt to determine  the  type
       is  made  by  trying  to  match the file's extension with those in the mime.types files.  If no
       mime-type is found, a last attempt will be done by running the file command, if available.   If
       the encoding is omitted, it will also be determined from the file's extensions.  Currently sup‐
       ported encodings are gzip (.gz), bzip2 (.bz2), xz (.xz), and compress (.Z).  A filename of  "-"
       can be used to mean "standard input", but then a mime-type must be specified.

       Both  the  user's  files  (~/.mailcap;  ~/.mime.types)  and  the  system  files  (/etc/mailcap;
       /etc/mime.types) are searched in turn for information.

   EXAMPLES
         see picture.jpg
         print output.ps.gz
         compose text/html:index.htm
         extract-mail-attachment msg.txt | see image/tiff:gzip:-

   OPTIONS
       All options are in the form --<opt>=<value>.

       --action=<action>
              Performs the specified action on the files.  Valid actions are view, cat (uses only "co‐
              piousoutput"  rules and sends output to STDOUT) , compose, composetyped, edit and print.
              If no action is specified, the action will be determined by how the program was called.

       --debug
              Turns on extra information to find out what is happening.

       --nopager
              Ignores any "copiousoutput" directive and sends output to STDOUT.

       --norun
              Displays the found command without actually executing it.

SECURITY
       A temporary copy of the file is opened if the file name matches  the  Perl  regular  expression
       "[^[:alnum:],.:/@%^+=_-]",  in  order  to  protect from the injection of shell commands, and to
       make sure that the name can always be displayed in the current locale.  In addition,  the  file
       is  opened  using its absolute path to prevent the injection of command-line arguments, for in‐
       stance using file names starting with dashes.

SEE ALSO
       file(1) mailcap(5) mailcap.order(5) update-mime(8)

AUTHOR
       run-mailcap (and its aliases) was written by Brian White <bcwhite@pobox.com>.

COPYRIGHT
       run-mailcap (and its aliases) is in the public domain (the only true "free").

Debian Project                               1st Jan 2008                               RUN-MAILCAP(1)
Compose(5)                                File Formats Manual                               Compose(5)

NAME
       Compose - X client mappings for multi-key input sequences

DESCRIPTION
       The  X  library, libX11, provides a simple input method for characters beyond those represented
       on typical keyboards using sequences of key strokes that are combined to enter a single charac‐
       ter.

       The compose file is searched for in  the following order:

       -      If  the  environment variable $XCOMPOSEFILE is set, its value is used as the name of the
              Compose file.

       -      If the user's home directory has a file named .XCompose, it is used as the Compose file.

       -      The system provided compose file is used by mapping the locale to a  compose  file  from
              the list in /usr/share/X11/locale/compose.dir.

       Compose  files can use an "include" instruction.  This allows local modifications to be made to
       existing compose files without including all of the content directly.  For  example,  the  sys‐
       tem's iso8859-1 compose file can be included with a line like this:
           include "%S/iso8859-1/Compose"

       There are several substitutions that can be made in the file name of the include instruction:

       %H  expands to the user's home directory (the $HOME environment variable)

       %L  expands  to the name of the locale specific Compose file (i.e., "/usr/share/X11/locale/<lo‐
           calename>/Compose")

       %S  expands to the name of the system directory for Compose  files  (i.e.,  "/usr/share/X11/lo‐
           cale")

       For example, you can include in your compose file the default Compose file by using:
              include "%L"
       and  then  rewrite only the few rules that you need to change.  New compose rules can be added,
       and previous ones replaced.

FILE FORMAT
       Compose files are plain text files, with a separate line for each compose sequence.    Comments
       begin  with  # characters.   Each compose sequence specifies one or more events and a resulting
       input sequence, with an optional comment at the end of the line:
              EVENT [EVENT...] : RESULT [# COMMENT]

       Each event consists of a specified input keysym, and optional modifier states:
              [([!] ([~] MODIFIER)...) | None] <keysym>

       If the modifier list is preceded by "!" it must match exactly.  MODIFIER may be  one  of  Ctrl,
       Lock,  Caps,  Shift, Alt or Meta.  Each modifier may be preceded by a "~" character to indicate
       that the modifier must not be present. If "None" is specified, no modifier may be present.

       The result specifies a string, keysym, or both, that the X client receives as  input  when  the
       sequence of events is input:
              "STRING" | keysym | "STRING" keysym

       Keysyms are specified without the XK_ prefix.

       Strings  may  be direct text encoded in the locale for which the compose file is to be used, or
       an escaped octal or hexadecimal character code.   Octal codes are specified as "\123" and hexa‐
       decimal  codes  as "\x3a".  It is not necessary to specify in the right part of a rule a locale
       encoded string in addition to the keysym name.  If the string is omitted, Xlib figures  it  out
       from the keysym according to the current locale.  I.e., if a rule looks like:
              <dead_grave> <A> : "\300" Agrave
       the result of the composition is always the letter with the "\300" code.  But if the rule is:
              <dead_grave> <A> : Agrave
       the result depends on how Agrave is mapped in the current locale.

ENVIRONMENT
       XCOMPOSEFILE
              File to use for compose sequences.

       XCOMPOSECACHE
              Directory to use for caching compiled compose files.

FILES
       $HOME/.XCompose
              User default compose file if XCOMPOSEFILE is not set.

       /usr/share/X11/locale/compose.dir
              File listing the compose file path to use for each locale.

       /usr/share/X11/locale/<localemapping>/Compose
              System default compose file for the locale, mapped via compose.dir.

       /var/cache/libx11/compose/
              System-wide cache directory for compiled compose files.

       $HOME/.compose-cache/
              Per-user cache directory for compiled compose files.

SEE ALSO
       XLookupString(3),   XmbLookupString(3),  XwcLookupString(3),  Xutf8LookupString(3),  mkcompose‐
       cache(1), locale(7).
       Xlib - C Language X Interface

X Version 11                                 libX11 1.6.8                                   Compose(5)
