File: *manpages*,  Node: uil,  Up: (dir)

uil(user cmd)                                                    uil(user cmd)



NAME
       uil — The user interface language compiler

SYNOPSIS
       uil [options ]  [file]

DESCRIPTION
       The  uil  command invokes the UIL compiler. The User Interface Language
       (UIL) is a specification language for describing the initial state of a
       user interface for a Motif application. The specification describes the
       objects (menus, dialog boxes, labels, push buttons, and so on) used  in
       the  interface  and specifies the routines to be called when the inter‐
       face changes state as a result of user interaction.

       file      Specifies the file to be compiled through the UIL compiler.

       options   Specifies one or more of the following options:

                 -Ipathname
                           This option causes the compiler to look for include
                           files  in  the  directory  specified if the include
                           files have not been found in the paths that already
                           were  searched.   Specify this option followed by a
                           pathname, with no intervening spaces.

                 -m        Machine code is listed. This directs  the  compiler
                           to  place  in the listing file a description of the
                           records that it added to the User  Interface  Data‐
                           base  (UID).  This  helps  you  isolate errors. The
                           default is no machine code.

                 -o file

                           Directs the compiler to produce a UID.  By default,
                           UIL  creates  a  UID with the name a.uid.  The file
                           specifies the filename for the UID.  No UID is pro‐
                           duced  if the compiler issues any diagnostics cate‐
                           gorized as error or severe. UIDs are portable  only
                           across same-size machine architectures.

                 -s        Directs  the compiler to set the locale before com‐
                           piling any files.  The locale is set in  an  imple‐
                           mentation-dependent  manner.   On ANSI C-based sys‐
                           tems, the locale is usually set by  calling  setlo‐
                           cale(LC_ALL, "").  If this option is not specified,
                           the compiler does not set the locale.

                 -v file   Directs the compiler to generate  a  listing.   The
                           file  specifies  the  filename for the listing.  If
                           the -v option is not present, no listing is  gener‐
                           ated by the compiler.  The default is no listing.

                 -w        Specifies  that  the  compiler suppress all warning
                           and informational messages.  If this option is  not
                           present,  all messages are generated, regardless of
                           the severity.

                 -wmd file Specifies a binary widget meta-language description
                           file  to  be  used  in  place  of  the  default WML
                           description.

RELATED INFORMATION
       X(1) and Uil(3).



                                                                 uil(user cmd)
Uil(library call)                                            Uil(library call)



NAME
       Uil — Invokes the UIL compiler from within an application

SYNOPSIS
       #include <uil/UilDef.h>

       Uil_status_type Uil(
       Uil_command_type *command_desc,
       Uil_compile_desc_type **compile_desc,
       Uil_continue_type (*message_cb) (),
       char *message_data,
       Uil_continue_type (*status_cb) (),
       char *status_data);

DESCRIPTION
       The  Uil function provides a callable entry point for the UIL compiler.
       The Uil callable interface can be used to process a UIL source file and
       to  generate UID files, as well as return a detailed description of the
       UIL source module in the form of a symbol table (parse tree).

       command_desc
                 Specifies the uil command line.

       compile_desc
                 Returns the results of the compilation.

       message_cb
                 Specifies a callback function that is called  when  the  com‐
                 piler encounters errors in the UIL source.

       message_data
                 Specifies  user  data  that is passed to the message callback
                 function (message_cb). Note that this argument is not  inter‐
                 preted  by UIL, and is used exclusively by the calling appli‐
                 cation.

       status_cb Specifies a callback function  that  is  called  to  allow  X
                 applications to service X events such as updating the screen.
                 This function is called at various check points,  which  have
                 been   hard   coded   into   the   UIL  compiler.   The  sta‐
                 tus_update_delay argument in command_desc specifies the  num‐
                 ber  of  check points to be passed before the status_cb func‐
                 tion is invoked.

       status_data
                 Specifies user data that is passed  to  the  status  callback
                 function  (status_cb).  Note that this argument is not inter‐
                 preted by the UIL compiler and is  used  exclusively  by  the
                 calling application.

       Following   are  the  data  structures  Uil_command_type  and  Uil_com‐
       pile_desc_type:

       typedef struct Uil_command_type {
       char *source_file;
           /* single source to compile */
       char *resource_file; /* name of output file */
       char *listing_file; /* name of listing file */
       unsigned int *include_dir_count;
           /* number of dirs. in include_dir */
       char *((*include_dir) []);
           /* dir. to search for include files */
       unsigned listing_file_flag: 1;
           /* produce a listing */
       unsigned resource_file_flag: 1;
           /* generate UID output */
       unsigned machine_code_flag: 1;
           /* generate machine code */
       unsigned report_info_msg_flag: 1;
           /* report info messages */
       unsigned report_warn_msg_flag: 1;
           /* report warnings */
       unsigned parse_tree_flag: 1;
           /* generate parse tree */
       unsigned int status_update_delay;
           /* number of times a status point is */
           /* passed before calling status_cb */
           /* function 0 means called every time */
       char *database;
           /* name of database file */
       unsigned database_flag: 1;
           /* read a new database file */
       unsigned use_setlocale_flag: 1;
           /* enable calls to setlocale */
       };
       typedef struct Uil_compile_desc_type {
       unsigned int compiler_version;
           /* version number of compiler */
       unsigned int data_version;
           /* version number of structures */
       char *parse_tree_root; /* parse tree output */
       unsigned int message_count [Uil_k_max_status+1];
       /* array of severity counts */
       };

       Following is a description of the message callback  function  specified
       by message_cb:

       Uil_continue_type (*message_cb) (message_data, message_number, severity, msg_buffer,
       src_buffer, ptr_buffer, loc_buffer, message_count)
               char *message_data;
               int message_number;
               int severity;
               char *msg_buffer, *src_buffer;
               char *ptr_buffer, *loc_buffer;
               int message_count[];

       This function specifies a callback function that UIL invokes instead of
       printing an error message when the compiler encounters an error in  the
       UIL source.  The callback should return one of the following values:

       Uil_k_terminate
                 Terminate processing of the source file

       Uil_k_continue
                 Continue processing the source file

       The arguments are

       message_data
                 Data supplied by the application as the message_data argument
                 to the Uil function.  UIL does not interpret this data in any
                 way; it just passes it to the callback.

       message_number
                 An  index  into  a table of error messages and severities for
                 internal use by UIL.

       severity  An integer that indicates the severity  of  the  error.   The
                 possible  values are the status constants returned by the Uil
                 function.  See Return Value for more information.

       msg_buffer
                 A string that describes the error.

       src_buffer
                 A string consisting  of  the  source  line  where  the  error
                 occurred.  This string is not always available. In this case,
                 the argument is NULL.

       ptr_buffer
                 A string consisting of whitespace and a printing character in
                 the  character  position  corresponding  to the column of the
                 source line where the error occurred.   This  string  may  be
                 printed  beneath  the source line to provide a visual indica‐
                 tion of the column where the error occurred.  This string  is
                 not always available. In this case, the argument is NULL.

       loc_buffer
                 A  string  identifying the line number and file of the source
                 line where the error occurred.  This is not always available;
                 the argument is then NULL.

       message_count
                 An array of integers containing the number of diagnostic mes‐
                 sages issued thus far for each severity level.  To  find  the
                 number of messages issued for the current severity level, use
                 the severity argument as the index into this array.

       Following is a description of the status callback function specified by
       status_cb:

       Uil_continue_type (*status_cb) (status_data, percent_complete,
               lines_processed, current_file, message_count)
               char *status_data;
               int percent_complete;
               int lines_processed;
               char *current_file;
               int message_count[];

       This  function specifies a callback function that is invoked to allow X
       applications to service X events such  as  updating  the  screen.   The
       callback should return one of the following values:

       Uil_k_terminate
                 Terminate processing of the source file

       Uil_k_continue
                 Continue processing the source file

       The arguments are

       status_data
                 Data  supplied by the application as the status_data argument
                 to the Uil function.  UIL does not interpret this data in any
                 way; it just passes it to the callback.

       percent_complete
                 An  integer  indicating what percentage of the current source
                 file has been processed so far.

       lines_processed
                 An integer indicating how many lines of  the  current  source
                 file have been read so far.

       current_file
                 A string containing the pathname of the current source file.

       message_count
                 An array of integers containing the number of diagnostic mes‐
                 sages issued thus far for each severity level.  To  find  the
                 number of messages issued for a given severity level, use the
                 severity level as the index into this  array.   The  possible
                 severity  levels are the status constants returned by the Uil
                 function.  See Return Value for more information.

RETURN
       This function returns one of the following status return constants:

       Uil_k_success_status
                 The operation succeeded.

       Uil_k_info_status
                 The  operation  succeeded.  An   informational   message   is
                 returned.

       Uil_k_warning_status
                 The operation succeeded. A warning message is returned.

       Uil_k_error_status
                 The operation failed due to an error.

       Uil_k_severe_status
                 The operation failed due to an error.

RELATED
       UilDumpSymbolTable(3) and uil(1).



                                                             Uil(library call)
UIL(file formats)                                            UIL(file formats)



NAME
       UIL — The user interface language file format

SYNOPSIS
       MODULE module_name
       [ NAMES = CASE_INSENSITIVE | CASE_SENSITIVE ]
       [ CHARACTER_SET = character_set ]
       [ OBJECTS = { widget_name = GADGET | WIDGET; [...] } ]
       { [
       [ value_section ] |
       [ procedure_section ] |
       [ list_section ] |
       [ object_section ] |
       [ identifier_section ]
       [ ... ]
       ] }
       END MODULE;

DESCRIPTION
       The  UIL  language  is  used for describing the initial state of a user
       interface for a widget based application.  UIL  describes  the  widgets
       used  in  the  interface, the resources of those widgets, and the call‐
       backs of those widgets. The UIL file is compiled into a UID file  using
       the  command uil or by the callable compiler Uil(). The contents of the
       compiled UID file can then be accessed by the  various  Motif  Resource
       Management (MRM) functions from within an application program.

       The  UID file is independent of the platform on which the Motif program
       will eventually be run. In other words, the same UID file can  be  used
       on any system that can run Motif.

   File
       A  UIL file consists of a single complete module, described in the syn‐
       tax description above, or, if the file is to be included  in  a  larger
       UIL  file,  one  complete  "section," as described below. UIL uses five
       different kinds of sections: value, procedure, list, object, and  iden‐
       tifier.

       UIL is a free-form language. This means that high-level constructs such
       as object and value declarations do not need to begin in any particular
       column  and  can span any number of lines. Low-level constructs such as
       keywords and punctuation characters can also begin in any column;  how‐
       ever, except for string literals and comments, they cannot span lines.

       The UIL compiler accepts input lines up to 132 characters in length.

       MODULE module_name
                 The  name  by  which the UIL module is known in the UID file.
                 This name is stored in the UID file  for  later  use  in  the
                 retrieval  of  resources  by  the  MRM.   This name is always
                 stored in uppercase in the UID file.

       NAMES = CASE_INSENSITIVE | CASE_SENSITIVE

                 Indicates whether names should be treated as  case  sensitive
                 or  case  insensitive.  The  default  is case sensitive.  The
                 case-sensitivity clause should be the  first  clause  in  the
                 module  header,  and  in  any case must precede any statement
                 that contains a name.  If names are case sensitive in  a  UIL
                 module,  UIL  keywords  in  that module must be in lowercase.
                 Each name is stored in the UIL file in the same  case  as  it
                 appears  in  the  UIL module.  If names are case insensitive,
                 then keywords can be in uppercase, lowercase, or mixed  case,
                 and  the  uppercase  equivalent of each name is stored in the
                 UID file.

       CHARACTER_SET = character_set

                 Specifies the default character set for  string  literals  in
                 the  module  that  do not explicitly set their character set.
                 The default character set, in the absence of this  clause  is
                 the  codeset  component  of the LANG environment variable, or
                 the value of XmFALLBACK_CHARSET if LANG is not set or has  no
                 codeset   component.   The  value  of  XmFALLBACK_CHARSET  is
                 defined by the UIL supplier, but is usually ISO8859-1 (equiv‐
                 alent  to  ISO_LATIN1).   Use  of  this  clause turns off all
                 localized string literal processing turned on by the compiler
                 flag  -s  or  the  Uil_command_type  data  structure  element
                 use_setlocale_flag.

       OBJECTS = { widget_name = GADGET | WIDGET; }

                 Indicates whether the widget or gadget form  of  the  control
                 specified  by widget_name is used by default.  By default the
                 widget form is used, so the gadget  keyword  is  usually  the
                 only  one used.  The specified control should be one that has
                 both a widget and gadget version:  XmCascadeButton,  XmLabel,
                 XmPushButton,  XmSeparator,  and XmToggleButton.  The form of
                 more than one control can be  specified  by  delimiting  them
                 with semicolons.  The gadget or widget form of an instance of
                 a control can be specified with the GADGET  and  WIDGET  key‐
                 words in a particular object declaration.

       value_section
                 Provides  a  way  to name a value expression or literal.  The
                 value name can then be referred to by declarations that occur
                 elsewhere  in the UIL module in any context where a value can
                 be used.  Values can be forward referenced.   Value  sections
                 are described in more detail later in the reference page.

       procedure_section
                 Defines  the  callback routines used by a widget and the cre‐
                 ation routines for user-defined  widgets.  These  definitions
                 are   used   for  error  checking.   Procedure  sections  are
                 described in more detail later in the reference page.

       list_section
                 Provides a way to group together a set of arguments, controls
                 (children), callbacks, or procedures for later use in the UIL
                 module.  Lists can contain other lists, so that you  can  set
                 up  a  hierarchy  to  clearly show which arguments, controls,
                 callbacks, and procedures are common to which widgets.   List
                 sections  are described in more detail later in the reference
                 page.

       object_section
                 Defines the objects that make up the user  interface  of  the
                 application.   You can reference the object names in declara‐
                 tions that occur elsewhere in the UIL module in  any  context
                 where  an object name can be used (for example, in a controls
                 list, as a symbolic reference to  a  widget  ID,  or  as  the
                 tag_value argument for a callback procedure).  Objects can be
                 forward referenced.  Object sections are  described  in  more
                 detail later in the reference page.

       identifier_section
                 Defines  a  run-time  binding of data to names that appear in
                 the UIL module.  Identifier sections are  described  in  more
                 detail later in the reference page.

       The  UIL  file  can also contain comments and include directives, which
       are described along with the main elements of the UIL  file  format  in
       the following sections.

   Comments
       Comments can take one of two forms, as follows:

          ·  The  comment  is  introduced with the sequence /* followed by the
             text of the comment and terminated with the  sequence  */.   This
             form of comment can span multiple source lines.

          ·  The comment is introduced with an ! (exclamation point), followed
             by the text of the comment and  terminated  by  the  end  of  the
             source line.

       Neither form of comment can be nested.

   Value sections
       A value section consists of the keyword VALUE followed by a sequence of
       value declarations. It has the following syntax:

       VALUE value_name : [ EXPORTED | PRIVATE ] value_expression  |  IMPORTED
       value_type ;

       Where  value_expression  is  assigned  to value_name or a value_type is
       assigned to an imported value name.  A value declaration provides a way
       to  name a value expression or literal.  The value name can be referred
       to by declarations that occur later in the UIL module  in  any  context
       where a value can be used.  Values can be forward referenced.

       EXPORTED  A value that you define as exported is stored in the UID file
                 as a named resource, and therefore can be referenced by  name
                 in  other UID files. When you define a value as exported, MRM
                 looks outside the module  in  which  the  exported  value  is
                 declared to get its value at run time.

       PRIVATE   A  private value is a value that is not imported or exported.
                 A value that you define as private is not stored  as  a  dis‐
                 tinct  resource in the UID file.  You can reference a private
                 value only in the UIL module containing  the  value  declara‐
                 tion.  The value or object is directly incorporated into any‐
                 thing in the UIL module that references the declaration.

       IMPORTED  A value that you define as imported is one that is defined as
                 a named resource in a UID file. MRM resolves this declaration
                 with the corresponding exported  declaration  at  application
                 run time.

       By default, values and objects are private.  The following is a list of
       the supported value types in UIL:

          ·  ANY

          ·  ARGUMENT

          ·  BOOLEAN

          ·  COLOR

          ·  COLOR_TABLE

          ·  COMPOUND_STRING

          ·  FLOAT

          ·  FONT

          ·  FONT_TABLE

          ·  FONTSET

          ·  ICON

          ·  INTEGER

          ·  INTEGER_TABLE

          ·  KEYSYM

          ·  REASON

          ·  SINGLE_FLOAT

          ·  STRING

          ·  STRING_TABLE

          ·  TRANSLATION_TABLE

          ·  WIDE_CHARACTER

          ·  WIDGET

   Procedure sections
       A procedure section consists of the keyword  PROCEDURE  followed  by  a
       sequence of procedure declarations. It has the following syntax:

       PROCEDURE
            procedure_name [ ( [ value_type ]) ];

       Use a procedure declaration to declare

          ·  A routine that can be used as a callback routine for a widget

          ·  The creation function for a user-defined widget

       You  can reference a procedure name in declarations that occur later in
       the UIL module in any context where a procedure can be used. Procedures
       can  be  forward referenced.  You cannot use a name you used in another
       context as a procedure name.

       In a procedure declaration, you have the option of  specifying  that  a
       parameter  will  be passed to the corresponding callback routine at run
       time. This parameter is called the callback tag. You  can  specify  the
       data  type  of the callback tag by putting the data type in parentheses
       following the procedure name. When you compile the module, the UIL com‐
       piler  checks that the argument you specify in references to the proce‐
       dure is of this type. Note that the data type of the callback tag  must
       be one of the valid UIL data types.  You can use a widget as a callback
       tag, as long as the widget is defined in the same widget  hierarchy  as
       the  callback,  that is they have a common ancestor that is in the same
       UIL hierarchy.

       The following list summarizes how the UIL compiler checks argument type
       and argument count, depending on the procedure declaration.

       No parameters
                 No  argument type or argument count checking occurs.  You can
                 supply either 0 or one arguments in the procedure reference.

       ( )       Checks that the argument count is 0 (zero).

       (ANY)     Checks that the argument count is 1. Does not check the argu‐
                 ment  type. Use the ANY type to prevent type checking on pro‐
                 cedure tags.

       (type)    Checks for one argument of the specified type.

       (class_name)
                 Checks for one widget argument of the specified widget class.

       While it is possible to use any UIL data type to specify the type of  a
       tag in a procedure declaration, you must be able to represent that data
       type in the programming language you are using. Some data  types  (such
       as  integer,  Boolean,  and string) are common data types recognized by
       most programming languages.  Other  UIL  data  types  (such  as  string
       tables)  are more complicated and may require that you set up an appro‐
       priate corresponding data structure in the application in order to pass
       a tag of that type to a callback routine.

       You  can also use a procedure declaration to specify the creation func‐
       tion for a user-defined widget. In this case,  you  specify  no  formal
       parameters.  The procedure is invoked with the standard three arguments
       passed to all widget creation functions.  (See the Motif Toolkit  docu‐
       mentation for more information about widget creation functions.)

   List sections
       A  list  section consists of the keyword LIST followed by a sequence of
       list declarations. It has the following syntax:

       LIST
            list_name: { list_item; [...] }
            [...]

       You can also use list sections to group together a  set  of  arguments,
       controls  (children), callbacks, or procedures for later use in the UIL
       module. Lists can contain other lists, so that you can set up a hierar‐
       chy  to  clearly  show which arguments, controls, callbacks, and proce‐
       dures are common to which widgets.  You cannot mix the different  types
       of  lists; a list of a particular type cannot contain entries of a dif‐
       ferent list type or reference the name of a  different  list  type.   A
       list  name is always private to the UIL module in which you declare the
       list and cannot be stored as a named resource in a UID file.

       The additional list types are described in the following sections.

       Arguments List Structure

       An arguments list defines which arguments are to be  specified  in  the
       arguments  list  parameter  when  the creation routine for a particular
       object is called at run time.  An arguments  list  also  specifies  the
       values for those arguments.  Argument lists have the following syntax:

       LIST
            list_name: ARGUMENTS {
                 argument_name = value_expression;
                 [...] }
       [...]

       The  argument  name  must be either a built-in argument name or a user-
       defined argument name that is specified with the ARGUMENT function.

       If you use a built-in argument name as an arguments list  entry  in  an
       object definition, the UIL compiler checks the argument name to be sure
       that it is supported by the type of object that you  are  defining.  If
       the  same  argument  name  appears  more than once in a given arguments
       list, the last entry that uses that argument name supersedes all previ‐
       ous entries with that name, and the compiler issues a message.

       Some  arguments,  such as XmNitems and XmNitemCount, are coupled by the
       UIL compiler.  When you specify one of the arguments, the compiler also
       sets the other. The coupled argument is not available to you.

       The  Motif  Toolkit  and  the X Toolkit (intrinsics) support constraint
       arguments.  A constraint argument is one that is passed to children  of
       an object, beyond those arguments normally available.  For example, the
       Form widget grants a set  of  constraint  arguments  to  its  children.
       These arguments control the position of the children within the Form.

       Unlike the arguments used to define the attributes of a particular wid‐
       get, constraint arguments are used  exclusively  to  define  additional
       attributes  of  the  children of a particular widget.  These attributes
       affect the behavior of the children within  their  parent.   To  supply
       constraint  arguments to the children, you include the arguments in the
       arguments list for the child.

       See Appendix B for information about which arguments are  supported  by
       which  widgets.  See  Appendix  C  for information about what the valid
       value type is for each built-in argument.

       Callbacks List Structure

       Use a callbacks list to define which callback reasons are  to  be  pro‐
       cessed  by  a  particular  widget at run time.  Callback lists have the
       following syntax:

       LIST list_name : CALLBACKS { reason_name = PROCEDURE procedure_name [ (
       [  value_expression  ]  )  ];  | reason_name = procedure_list ; [...] }
       [...]

       For Motif Toolkit widgets, the reason name must be  a  built-in  reason
       name.  For  a  user-defined  widget, you can use a reason name that you
       previously specified using the REASON function.  If you use a  built-in
       reason in an object definition, the UIL compiler ensures that reason is
       supported by the type of object you  are  defining.  Appendix  B  shows
       which reasons each object supports.

       If the same reason appears more than once in a callbacks list, the last
       entry referring to that name supersedes all previous entries using  the
       same reason, and the UIL compiler issues a diagnostic message.

       If you specify a named value for the procedure argument (callback tag),
       the data type of the value must match the type specified for the  call‐
       back tag in the corresponding procedure declaration.  When specifying a
       widget name as a procedure value expression you must also  specify  the
       type of the widget and a space before the name of the widget.

       Because the UIL compiler produces a UID file rather than an object mod‐
       ule (.o), the binding of the UIL name to the address of the entry point
       to  the  procedure is not done by the loader, but is established at run
       time with the MRM function MrmRegisterNames.  You  call  this  function
       before  fetching any objects, giving it both the UIL names and the pro‐
       cedure addresses of each callback. The name you register  with  MRM  in
       the  application program must match the name you specified for the pro‐
       cedure in the UIL module.

       Each callback procedure receives three arguments. The first  two  argu‐
       ments have the same form for each callback. The form of the third argu‐
       ment varies from object to object.

       The first argument is the address of the data structure  maintained  by
       the  Motif Toolkit for this object instance. This address is called the
       widget ID for this object.

       The second argument is the address of the value you  specified  in  the
       callbacks  list  for this procedure. If you do not specify an argument,
       the address is NULL.  Note that, in the case where the value you speci‐
       fied  is  a string or an XmString, the value specified in the callbacks
       list already represents an address rather than an actual value. In  the
       case  of  a simple string, for example, the value is the address of the
       first character of that string. In these cases,  UIL  does  not  add  a
       level of indirection, and the second argument to the callback procedure
       is simply the value as specified in the callbacks list.

       The third argument is the reason name you specified  in  the  callbacks
       list.

       Controls List Structure

       A  controls  list  defines which objects are children of, or controlled
       by, a particular object.  Each entry in a controls list has the follow‐
       ing syntax:

       LIST
            list_name: CONTROLS {
                 [child_name: ] [MANAGED | UNMANAGED] object_definition;
                 [...] }
            [...]

       If  you  specify the keyword MANAGED at run time, the object is created
       and managed; if you specify UNMANAGED at run time, the object  is  only
       created.  Objects are managed by default.

       You  can use child_name to specify resources for the automatically cre‐
       ated children of a particular control. Names for automatically  created
       children  are  formed by appending Xm_ to the name of the child widget.
       This name is specified in the documentation for the parent widget.

       Unlike the arguments list and the callbacks list, a controls list entry
       that  is  identical to a previous entry does not supersede the previous
       entry. At run time, each controls list entry causes a child to be  cre‐
       ated  when the parent is created. If the same object definition is used
       for multiple children, multiple instances of the child are  created  at
       run  time.  See Appendix B for a list of which widget types can be con‐
       trolled by which other widget types.

       Procedures List Structure

       You can specify multiple procedures for a callback  reason  in  UIL  by
       defining  a  procedures list. Just as with other list types, procedures
       lists can be defined in-line or in a list  section  and  referenced  by
       name.

       If  you define a reason more than once (for example, when the reason is
       defined both in a referenced procedures list and in the callbacks  list
       for the object), previous definitions are overridden by the latest def‐
       inition.  The syntax for a procedures list is as follows:

       LIST
            list_name: PROCEDURES {
                 procedure_name [ ( [ value_expression ]) ];
                 [...] }
            [...]

       When specifying a widget name as a procedure value expression you  must
       also  specify the type of the widget and a space before the name of the
       widget.

   Object Sections
       An object section consists of the keyword OBJECT followed by a sequence
       of object declarations. It has the following syntax:

       OBJECT object_name:
            [ EXPORTED | PRIVATE | IMPORTED ] object_type
                 [ PROCEDURE creation_function ]
                 [ object_name [ WIDGET | GADGET ] | {list_definitions } ]

       Use  an  object declaration to define the objects that are to be stored
       in the UID file. You can reference the object name in declarations that
       occur  elsewhere  in the UIL module in any context where an object name
       can be used (for example, in a controls list, as a  symbolic  reference
       to a widget ID, or as the tag_value argument for a callback procedure).
       Objects can be forward referenced; that is, you can declare  an  object
       name  after  you reference it. All references to an object name must be
       consistent with the type of the object, as specified in the object dec‐
       laration.  You can specify an object as exported, imported, or private.

       The  object  definition can contain a sequence of lists that define the
       arguments, hierarchy, and callbacks for the widget.   You  can  specify
       only  one  list  of  each type for an object.  When you declare a user-
       defined widget, you must include a reference  to  the  widget  creation
       function for the user-defined widget.

       Note:  Several  widgets  in  the  Motif Toolkit actually consist of two
       linked widgets. For example,  XmScrolledText  and  XmScrolledList  each
       consist  of children XmText and XmList widgets under a XmScrolledWindow
       widget. When such a widget is created, its resources are  available  to
       both  of  the underlying widgets. This can occasionally cause problems,
       as when the programmer wants a XmNdestroyCallback routine named to  act
       when  the widget is destroyed. In this case, the callback resource will
       be available to both sub-widgets, and will cause an error when the wid‐
       get  is destroyed. To avoid these problems, the programmer should sepa‐
       rately create the parent and child  widgets,  rather  than  relying  on
       these linked widgets.

       Use the GADGET or WIDGET keyword to specify the object type or to over‐
       ride the default variant for this object type.  You can use  the  Motif
       Toolkit  name of an object type that has a gadget variant (for example,
       XmLabelGadget)  as  an  attribute  of  an  object   declaration.    The
       object_type  can  be  any  object type, including gadgets.  You need to
       specify the GADGET or WIDGET keyword only  in  the  declaration  of  an
       object,  not when you reference the object. You cannot specify the GAD‐
       GET or WIDGET keyword for a user-defined object;  user-defined  objects
       are always widgets.

   Identifier sections
       The  identifier section allows you to define an identifier, a mechanism
       that achieves run-time binding of data to names that appear  in  a  UIL
       module.   The identifier section consists of the reserved keyword IDEN‐
       TIFIER, followed by a list of names, each name followed by a semicolon.

       IDENTIFIER identifier_name; [...;]

       You can later use these names in the UIL module as either the value  of
       an  argument  to  a widget or the tag value to a callback procedure. At
       run time, you use the MRM functions MrmRegisterNames  and  MrmRegister‐
       NamesInHierarchy  to bind the identifier name with the data (or, in the
       case of callbacks, with the address of the data)  associated  with  the
       identifier.

       Each  UIL  module  has a single name space; therefore, you cannot use a
       name you used for a value, object, or procedure as an  identifier  name
       in the same module.

       The  UIL  compiler  does not do any type checking on the use of identi‐
       fiers in a UIL module. Unlike a UIL value, an identifier does not  have
       a  UIL  type  associated  with it. Regardless of what particular type a
       widget argument or callback procedure tag is defined to be, you can use
       an  identifier  in that context instead of a value of the corresponding
       type.

       To reference these identifier names in a UIL module, you use  the  name
       of the identifier wherever you want its value to be used.

   Include directives
       The  include  directive  incorporates  the contents of a specified file
       into a UIL module. This mechanism allows several UIL modules  to  share
       common definitions. The syntax for the include directive is as follows:

       INCLUDE FILE file_name;

       The  UIL  compiler  replaces the include directive with the contents of
       the include file and processes it as if these contents had appeared  in
       the current UIL source file.

       You  can  nest  include  files;  that  is,  an include file can contain
       include directives.  The UIL compiler can process up to 100  references
       (including  the  file  containing  the  UIL module). Therefore, you can
       include up to 99 files in a single UIL module, including nested  files.
       Each time a file is opened counts as a reference, so including the same
       file twice counts as two references.

       The file_name is a simple string containing a file  specification  that
       identifies the file to be included. The rules for finding the specified
       file are similar to the rules for finding header, or .h files using the
       include  directive,  #include,  with a quoted string in C. The UIL uses
       the -I option for specifying a search directory for include files.

          ·  If you do not supply a directory, the UIL compiler  searches  for
             the include file in the directory of the main source file.

          ·  If  the  compiler  does not find the include file there, the com‐
             piler looks in the same directory as the source file.

          ·  If you supply a directory, the UIL compiler  searches  only  that
             directory for the file.

   Names and Strings
       Names  can  consist  of any of the characters A to Z, a to z, 0 to 9, $
       (dollar sign), and _ (underscore). Names cannot begin with a  digit  (0
       to 9). The maximum length of a name is 31 characters.

       UIL  gives  you  a  choice of either case-sensitive or case-insensitive
       names through a clause in the MODULE header.  For example, if names are
       case  sensitive, the names "sample" and "Sample" are distinct from each
       other. If names are case insensitive, these names are  treated  as  the
       same  name  and  can  be  used interchangeably. By default, UIL assumes
       names are case sensitive.

       In CASE-INSENSITIVE mode, the compiler outputs all  names  in  the  UID
       file  in  uppercase  form.  In CASE-SENSITIVE mode, names appear in the
       UIL file exactly as they appear in the source.

       The following table lists the reserved keywords, which are  not  avail‐
       able for defining programmer defined names.

       ┌───────────────────────────────────────────────┐
       │              Reserved Keywords                │
       ├───────────────────────────────────────────────┤
       │ARGUMENTS    CALLBACKS   CONTROLS   END        │
       │EXPORTED     FALSE       GADGET     IDENTIFIER │
       │INCLUDE      LIST        MODULE     OFF        │
       │ON           OBJECT      PRIVATE    PROCEDURE  │
       │PROCEDURES   TRUE        VALUE      WIDGET     │
       └───────────────────────────────────────────────┘
       The UIL unreserved keywords are described in the following list and ta‐
       ble.  These keywords can be used as programmer defined names,  however,
       if you use any keyword as a name, you cannot use the UIL-supplied usage
       of that keyword.

          ·  Built-in argument names (for example, XmNx, XmNheight)

          ·  Built-in reason names (for example, XmNactivateCallback, XmNhelp‐
             Callback)

          ·  Character set names (for example, ISO_LATIN1, ISO_HEBREW_LR)

          ·  Constant     value    names    (for    example,    XmMENU_OPTION,
             XmBROWSE_SELECT)

          ·  Object types (for example, XmPushButton, XmBulletinBoard)

             ┌───────────────────────────────────────────────────────────────────────┐
             │                         Unreserved Keywords                           │
             ├───────────────────────────────────────────────────────────────────────┤
             │ANY                         ARGUMENT                ASCIZ_STRING_TABLE │
             │ASCIZ_TABLE                 BACKGROUND              BOOLEAN            │
             │CASE_INSENSITIVE            CASE_SENSITIVE          CHARACTER_SET      │
             │COLOR                       COLOR_TABLE             COMPOUND_STRING    │
             │COMPOUND_STRING_COMPONENT   COMPOUND_STRING_TABLE   FILE               │
             │FLOAT                       FONT                    FONT_TABLE         │
             │FONTSET                     FOREGROUND              ICON               │
             │IMPORTED                    INTEGER                 INTEGER_TABLE      │
             │KEYSYM                      MANAGED                 NAMES              │
             │OBJECTS                     REASON                  RGB                │
             │RIGHT_TO_LEFT               SINGLE_FLOAT            STRING             │
             │STRING_TABLE                TRANSLATION_TABLE       UNMANAGED          │
             │USER_DEFINED                VERSION                 WIDE_CHARACTER     │
             │WIDGET                      XBITMAPFILE                                │
             └───────────────────────────────────────────────────────────────────────┘
       String literals can be composed of the uppercase and lowercase letters,
       digits,  and  punctuation  characters.   Spaces, tabs, and comments are
       special elements in the language. They are a means of delimiting  other
       elements,  such  as two names. One or more of these elements can appear
       before or after any other element in the  language.   However,  spaces,
       tabs,  and comments that appear in string literals are treated as char‐
       acter sequences rather than delimiters.

   Data Types
       UIL provides literals for several of the value types it supports.  Some
       of  the value types are not supported as literals (for example, pixmaps
       and string tables). You can specify values for  these  types  by  using
       functions  described  in  the Functions section.  UIL directly supports
       the following literal types:

          ·  String literal

          ·  Integer literal

          ·  Boolean literal

          ·  Floating-point literal

       UIL also includes the data type ANY, which is used to turn off  compile
       time checking of data types.

   String Literals
       A  string literal is a sequence of zero or more 8-bit or 16-bit charac‐
       ters or a combination delimited by '  (single  quotation  marks)  or  "
       (double  quotation  marks).  String literals can also contain multibyte
       characters delimited with double quotation marks.  String literals  can
       be no more than 2000 characters long.

       A  single-quoted string literal can span multiple source lines. To con‐
       tinue a single-quoted string literal, terminate the continued line with
       a  \ (backslash). The literal continues with the first character on the
       next line.

       Double-quoted  string  literals  cannot  span  multiple  source  lines.
       (Because  double-quoted  strings can contain escape sequences and other
       special characters, you cannot use the backslash character to designate
       continuation  of  the  string.)  To build a string value that must span
       multiple source lines, use the concatenation operator  described  later
       in this section.

       The syntax of a string literal is one of the following:

       '[character_string]'
       [#char_set]"[character_string]"

       Both  string  forms associate a character set with a string value.  UIL
       uses the following rules to determine the  character  set  and  storage
       format for string literals:

          ·  A    string    declared    as    'string'    is   equivalent   to
             #cur_charset"string", where cur_charset will be the codeset  por‐
             tion  of  the value of the LANG environment variable if it is set
             or the value of XmFALLBACK_CHARSET if LANG is not set or  has  no
             codeset  component.   By default, XmFALLBACK_CHARSET is ISO8859-1
             (equivalent to ISO_LATIN1), but vendors may  define  a  different
             default.

          ·  A  string declared as "string" is equivalent to #char_set"string"
             if you specified char_set as the default character  set  for  the
             module.   If  no default character set has been specified for the
             module, then if the -s option is provided to the uil  command  or
             the  use_setlocale_flag  is set for the callable compiler, Uil(),
             the string will be interpreted to be  a  string  in  the  current
             locale. This means that the string is parsed in the locale of the
             user by calling setlocale, its charset is XmFONTLIST_DEFAULT_TAG,
             and  that  if the string is converted to a compound string, it is
             stored as a locale encoded text segment.  Otherwise, "string"  is
             equivalent  to  #cur_charset"string", where cur_charset is inter‐
             preted as described for single quoted strings.

          ·  A string of the form "string" or #char_set"string" is stored as a
             null-terminated string.

       If the char_set in a string specified in the form above is not a built-
       in charset, and is not a  user-defined  charset,  the  charset  of  the
       string will be set to XmFONTLIST_DEFAULT_TAG, and an informational mes‐
       sage will be issued to the user to note that this substitution has been
       made.

       The  following table lists the character sets supported by the UIL com‐
       piler for string literals.  Note that several UIL names map to the same
       character set. In some cases, the UIL name influences how string liter‐
       als are read. For example, strings identified by a  UIL  character  set
       name ending in _LR are read left-to-right.  Names that end in a differ‐
       ent  number  reflect  different  fonts  (for  example,  ISO_LATIN1   or
       ISO_LATIN6).   All  character  sets  in this table are represented by 8
       bits.

       ┌──────────────────────────────────────────────────┐
       │            Supported Character Sets              │
       ├──────────────────────────────────────────────────┤
       │UIL Name        Description                       │
       ├──────────────────────────────────────────────────┤
       │ISO_LATIN1      GL: ASCII, GR: Latin-1 Supplement │
       │ISO_LATIN2      GL: ASCII, GR: Latin-2 Supplement │
       │ISO_ARABIC      GL: ASCII, GR: Latin-Arabic  Sup‐ │
       │                plement                           │
       │ISO_LATIN6      GL:  ASCII, GR: Latin-Arabic Sup‐ │
       │                plement                           │
       │ISO_GREEK       GL: ASCII, GR:  Latin-Greek  Sup‐ │
       │                plement                           │
       │ISO_LATIN7      GL:  ASCII,  GR: Latin-Greek Sup‐ │
       │                plement                           │
       │ISO_HEBREW      GL: ASCII, GR: Latin-Hebrew  Sup‐ │
       │                plement                           │
       │ISO_LATIN8      GL:  ASCII, GR: Latin-Hebrew Sup‐ │
       │                plement                           │
       │ISO_HEBREW_LR   GL: ASCII, GR: Latin-Hebrew  Sup‐ │
       │                plement                           │
       │ISO_LATIN8_LR   GL:  ASCII, GR: Latin-Hebrew Sup‐ │
       │                plement                           │
       │JIS_KATAKANA    GL: JIS Roman, GR: JIS Katakana   │
       └──────────────────────────────────────────────────┘
       Following are the parsing rules for each of the character sets:

       All character sets
                 Character codes in the range 00...1F,  7F,  and  80...9F  are
                 control characters including both bytes of 16-bit characters.
                 The compiler flags these as illegal characters.

       ISO_LATIN1 ISO_LATIN2 ISO_LATIN3 ISO_GREEK ISO_LATIN4
                 These sets  are  parsed  from  left  to  right.   The  escape
                 sequences  for  null-terminated strings are also supported by
                 these character sets.

       ISO_HEBREW ISO_ARABIC ISO_LATIN8
                 These sets are parsed from right to left.  For  example,  the
                 string  #ISO_HEBREW"012345"  will generate a primitive string
                 of "543210" with character set ISO_HEBREW. The string  direc‐
                 tion  for  such a string would be right-to-left, so when ren‐
                 dered,  the  string  will  appear  as  "012345."  The  escape
                 sequences  for  null-terminated strings are also supported by
                 these character sets, and the  characters  that  compose  the
                 escape sequences are in left-to-right order. For example, you
                 would enter \n, not n\.

       ISO_HEBREW_LR ISO_ARABIC_LR ISO_LATIN8_LR
                 These sets are parsed from left to right.  For  example,  the
                 string  #ISO_HEBREW_LR"012345"  generates  a primitive string
                 "012345" with character set ISO_HEBREW. The string  direction
                 for  such  a string would still be right-to-left, however, so
                 when rendered, it will appear as "543210."  In  other  words,
                 the  characters  were  originally  typed in the same order in
                 which they would have  been  typed  in  Hebrew  (although  in
                 Hebrew,  the  typist would have been using a text editor that
                 went from right to left). The escape sequences for  null-ter‐
                 minated strings are also supported by these character sets.

       JIS_KATAKANA
                 This  set  is parsed from left to right. The escape sequences
                 for null-terminated strings are also supported by this  char‐
                 acter  set. Note that the \ (backslash) may be displayed as a
                 yen symbol.

       In addition to designating parsing rules  for  strings,  character  set
       information  remains  an attribute of a compound string.  If the string
       is included in a string consisting of  several  concatenated  segments,
       the  character  set  information  is included with that string segment.
       This gives the Motif Toolkit the information it needs to  decipher  the
       compound string and choose a font to display the string.

       For  an  application  interface displayed only in English, UIL lets you
       ignore the distinctions between the two uses of strings.  The  compiler
       recognizes by context when a string must be passed as a null-terminated
       string or as a compound string.

       The UIL compiler recognizes enough about the various character sets  to
       correctly  parse  string  literals.  The compiler also issues errors if
       you use a compound string in a context that supports  only  null-termi‐
       nated strings.

       Since the character set names are keywords, you must put them in lower‐
       case if case-sensitive names are in force.  If names are case  insensi‐
       tive, character set names can be uppercase, lowercase, or mixed case.

       In  addition  to the built-in character sets recognized by UIL, you can
       define your own character sets with the CHARACTER_SET function. You can
       use  the  CHARACTER_SET function anywhere a character set can be speci‐
       fied.

       String literals can contain characters with the eighth (high-order) bit
       set. You cannot type control characters (00-1F, 7F, and 80-9F) directly
       in a single-quoted string literal. However,  you  can  represent  these
       characters  with  escape sequences. The following list shows the escape
       sequences for special characters.

       \b        Backspace

       \f        Form-feed

       \n        Newline

       \r        Carriage return

       \t        Horizontal tab

       \v        Vertical tab

       \'        Single quotation mark

       \"        Double quotation mark

       \\        Backslash

       \integer\ Character whose internal representation is given  by  integer
                 (in the range 0 to 255 decimal)

       Note  that escape sequences are processed literally in strings that are
       parsed in the current locale (localized strings).

       The UIL compiler  does  not  process  newline  characters  in  compound
       strings.   The  effect  of  a  newline  character  in a compound string
       depends only on the character set of the string, and the result is  not
       guaranteed to be a multiline string.

       Compound String Literals

       A  compound  string consists of a string of 8-bit, 16-bit, or multibyte
       characters, a named character set, and a  writing  direction.  Its  UIL
       data type is compound_string.

       The  writing direction of a compound string is implied by the character
       set specified for the string. You can explicitly set the writing direc‐
       tion for a compound string by using the COMPOUND_STRING function.

       A  compound  string  can consist of a sequence of concatenated compound
       strings, null-terminated strings, or a combination  of  both,  each  of
       which  can  have  a different character set property and writing direc‐
       tion. Use the concatenation operator & (ampersand) to create a sequence
       of compound strings.

       Each  string in the sequence is stored, including the character set and
       writing direction information.

       Generally, a string literal is stored in the UID  file  as  a  compound
       string when the literal consists of concatenated strings having differ‐
       ent character sets or writing directions, or when you use the string to
       specify  a value for an argument that requires a compound string value.
       If you want to guarantee that a string literal is stored as a  compound
       string, you must use the COMPOUND_STRING function.

       Data Storage Consumption for String Literals

       The  way  a string literal is stored in the UID file depends on how you
       declare and use the string. The UIL compiler automatically  converts  a
       null-terminated  string  to  a compound string if you use the string to
       specify the value of an argument that requires a compound string.  How‐
       ever, this conversion is costly in terms of storage consumption.

       PRIVATE,  EXPORTED,  and IMPORTED string literals require storage for a
       single allocation when the literal is declared; thereafter, storage  is
       required  for  each reference to the literal. Literals declared in-line
       require storage for both an allocation and a reference.

       The following table summarizes data storage consumption for string lit‐
       erals.  The  storage  requirement for an allocation consists of a fixed
       portion and a variable portion. The fixed portion of an  allocation  is
       roughly  the  same  as  the  storage requirement for a reference (a few
       bytes).  The storage consumed by the variable portion  depends  on  the
       size  of the literal value (that is, the length of the string). To con‐
       serve storage space, avoid  making  string  literal  declarations  that
       result in an allocation per use.

       ┌─────────────────────────────────────────────┐
       │Data Storage Consumption for String Literals │
       ├──────────┼───────────┼───────────┼──────────┤
       │          │           │           │          │
       │          │           │           │          │
       │          │           │           │          │
       │          │           │           │          │
       │          │           │           │          │
       │          │           │           │          │
       ├──────────┼───────────┼───────────┼──────────┤
       │          │           │           │          │
       │          │           │           │          │
       │          │           │           │          │
       │          │           │           │          │
       │          │           │           │          │
       │          │           │           │          │
       └──────────┴───────────┴───────────┴──────────┘
   Integer Literals
       An  integer  literal  represents  the value of a whole number.  Integer
       literals have the form of an optional sign followed by one or more dec‐
       imal  digits.   An  integer literal must not contain embedded spaces or
       commas.

       Integer literals are  stored  in  the  UID  file  as  32-bit  integers.
       Exported and imported integer literals require a single allocation when
       the literal is  declared;  thereafter,  a  few  bytes  of  storage  are
       required  for  each  reference to the literal. Private integer literals
       and those declared in-line require allocation and reference storage per
       use.  To  conserve storage space, avoid making integer literal declara‐
       tions that result in an allocation per use.

       The following table shows data storage consumption for  integer  liter‐
       als.

       ┌──────────────────────────────────────────────┐
       │Data Storage Consumption for Integer Literals │
       ├──────────────┬───────────────────────────────┤
       │Declaration   │Storage Requirements Per Use   │
       ├──────────────┼───────────────────────────────┤
       │In-line       │An  allocation  and a refer‐   │
       │              │ence (within the module)       │
       │Private       │An allocation and  a  refer‐   │
       │              │ence (within the module)       │
       │Exported      │A  reference (within the UID   │
       │              │hierarchy)                     │
       │Imported      │A reference (within the  UID   │
       │              │hierarchy)                     │
       └──────────────┴───────────────────────────────┘
   Boolean Literal
       A  Boolean  literal represents the value True (reserved keyword TRUE or
       On) or False (reserved keyword FALSE or Off).  These keywords are  sub‐
       ject to case-sensitivity rules.

       In  a UID file, TRUE is represented by the integer value 1 and FALSE is
       represented by the integer value 0 (zero).

       Data storage consumption for Boolean literals is the same as  that  for
       integer literals.

   Floating-Point Literal
       A floating-point literal represents the value of a real (or float) num‐
       ber.  Floating-point literals have the following form:

       [+|-][integer].integer[E|e[+|-]exponent]

       For maximum portability, a floating-point literal can represent  values
       in the range 1.0E-37 to 1.0E+37 with at least 6 significant digits.  On
       many machines this range will be wider, with more  significant  digits.
       A floating-point literal must not contain embedded spaces or commas.

       Floating-point literals are stored in the UID file as double-precision,
       floating-point numbers.  The following table gives  examples  of  valid
       and invalid floating-point notation for the UIL compiler.

       ┌────────────────────────────────────────────────────────────────┐
       │                    Floating Point Literals                     │
       ├────────────────────────────────────────────────────────────────┤
       │Valid Floating-Point Literals   Invalid Floating-Point Literals │
       ├────────────────────────────────────────────────────────────────┤
       │1.0                             1e1 (no decimal point)          │
       │3.1415E-2 (equals .031415)      2.87 e6 (embedded blanks)       │
       │-6.29e7 (equals -62900000)      2.0e100 (out of range)          │
       └────────────────────────────────────────────────────────────────┘
       Data  storage  consumption  for  floating-point literals is the same as
       that for integer literals.

       The purpose of the ANY data type is to shut off the data-type  checking
       feature  of  the  UIL  compiler.  You can use the ANY data type for the
       following:

          ·  Specifying the type of a callback procedure tag

          ·  Specifying the type of a user-defined argument

       You can use the ANY data type when you need to use a type not supported
       by the UIL compiler or when you want the data-type restrictions imposed
       by the compiler to be relaxed.  For example, you might want to define a
       widget  having  an  argument that can accept different types of values,
       depending on run-time circumstances.

       If you specify that an argument takes an ANY value, the  compiler  does
       not check the type of the value specified for that argument; therefore,
       you need to take care when specifying a value for an argument  of  type
       ANY.   You could get unexpected results at run time if you pass a value
       having a data type that the widget does not support for that argument.

   Expressions
       UIL includes compile-time value expressions. These expressions can con‐
       tain references to other UIL values, but cannot be forward referenced.

       The following table lists the set of operators in UIL that allow you to
       create integer, real, and Boolean values based on other values  defined
       with the UIL module. In the table, a precedence of 1 is the highest.

       ┌───────────────────────────────────────────────────────────┐
       │Valid Operators                                            │
       ├─────────┬─────────────────┬──────────────────┬────────────┤
       │Operator │ Operand Types   │ Meaning          │ Precedence │
       ├─────────┼─────────────────┼──────────────────┼────────────┤
       │   ~     │ Boolean         │ NOT              │     1      │
       │         │ integer         │ One's complement │            │
       │   -     │ float           │ Negate           │     1      │
       │         │ integer         │ Negate           │            │
       │   +     │ float           │ NOP              │     1      │
       │         │ integer         │ NOP              │            │
       │   *     │ float,float     │ Multiply         │     2      │
       │         │ integer,integer │ Multiply         │            │
       │   /     │ float,float     │ Divide           │     2      │
       │         │ integer,integer │ Divide           │            │
       │   +     │ float,float     │ Add              │     3      │
       │         │ integer,integer │ Add              │            │
       │   -     │ float,float     │ Subtract         │     3      │
       │         │ integer,integer │ Subtract         │            │
       │   >>    │ integer,integer │ Shift right      │     4      │
       │   <<    │ integer,integer │ Shift left       │     4      │
       │   &     │ Boolean,Boolean │ AND              │     5      │
       │         │ integer,integer │ Bitwise AND      │            │
       │         │ string,string   │ Concatenate      │            │
       │   |     │ Boolean,Boolean │ OR               │     6      │
       │         │ integer,integer │ Bitwise OR       │            │
       │   ^     │ Boolean,Boolean │ XOR              │     6      │
       │         │ integer,integer │ Bitwise XOR      │            │
       └─────────┴─────────────────┴──────────────────┴────────────┘
       A  string  can be either a single compound string or a sequence of com‐
       pound strings. If the two concatenated strings have  different  proper‐
       ties  (such  as  writing direction or character set), the result of the
       concatenation is a multisegment compound string.

       The string resulting from the concatenation is a null-terminated string
       unless one or more of the following conditions exists:

          ·  One of the operands is a compound string

          ·  The operands have different character set properties

          ·  The operands have different writing directions

       Then  the  resulting  string  is  a  compound  string.   You cannot use
       imported or exported values as operands of the concatenation operator.

       The result of each operator has the same type  as  its  operands.   You
       cannot mix types in an expression without using conversion routines.

       You can use parentheses to override the normal precedence of operators.
       In a sequence of unary  operators,  the  operations  are  performed  in
       right-to-left order. For example, - + -A is equivalent to -(+(-A)).  In
       a sequence of binary operators of the same precedence,  the  operations
       are  performed  in left-to-right order. For example, A*B/C*D is equiva‐
       lent to ((A*B)/C)*D.

       A value declaration gives a value a name. You cannot redefine the value
       of  that  name  in a subsequent value declaration.  You can use a value
       containing operators and functions anywhere you can use a  value  in  a
       UIL module.  You cannot use imported values as operands in expressions.

       Several  of  the  binary operators are defined for multiple data types.
       For example, the operator for multiplication (*) is  defined  for  both
       floating-point and integer operands.

       For  the UIL compiler to perform these binary operations, both operands
       must be of the same type.  If you supply  operands  of  different  data
       types,  the  UIL compiler automatically converts one of the operands to
       the type of the other according to the following conversions rules:

          ·  If the operands are an integer and a Boolean, the Boolean is con‐
             verted to an integer.

          ·  If  the operands are an integer and a floating-point, the integer
             is converted to an floating-point.

          ·  If the operands are a floating-point and a Boolean,  the  Boolean
             is converted to a floating-point.

       You  can  also explicitly convert the data type of a value by using one
       of the conversion functions INTEGER, FLOAT or SINGLE_FLOAT.

   Functions
       UIL provides functions to generate the following types of values:

          ·  Character sets

          ·  Keysyms

          ·  Colors

          ·  Pixmaps

          ·  Single-precision, floating-point numbers

          ·  Double-precision, floating-point numbers

          ·  Fonts

          ·  Fontsets

          ·  Font tables

          ·  Compound strings

          ·  Compound string tables

          ·  ASCIZ (null-terminated) string tables

          ·  Wide character strings

          ·  Widget class names

          ·  Integer tables

          ·  Arguments

          ·  Reasons

          ·  Translation tables

       Remember that all examples in the following sections assume case-insen‐
       sitive  mode.  Keywords  are  shown in uppercase letters to distinguish
       them from user-specified names, which are shown in  lowercase  letters.
       This use of uppercase letters is not required in case-insensitive mode.
       In case-sensitive mode, keywords must be in lowercase letters.

       CHARACTER_SET(string_expression[, property[, ...]])

                 You can define your own character sets with the CHARACTER_SET
                 function.  You  can use the CHARACTER_SET function anywhere a
                 character set can be specified.

                 The result of the CHARACTER_SET function is a  character  set
                 with  the name string_expression and the properties you spec‐
                 ify.  string_expression must be a null-terminated string. You
                 can  optionally  include one or both of the following clauses
                 to specify properties for the resulting character set:

       RIGHT_TO_LEFT = boolean_expression
       SIXTEEN_BIT = boolean_expression

                 The RIGHT_TO_LEFT clause sets the default  writing  direction
                 of  the  string  from  right to left if boolean_expression is
                 True, and right to left otherwise.

                 The SIXTEEN_BIT clause allows  the  strings  associated  with
                 this  character set to be interpreted as 16-bit characters if
                 boolean_expression is True, and 8-bit characters otherwise.

       KEYSYM(string_literal)

                 The KEYSYM function  is  used  to  specify  a  keysym  for  a
                 mnemonic  resource.   string_literal  must  contain  a  valid
                 KeySym name.  (See XStringToKeysym(3 X11) for  more  informa‐
                 tion.)

       COLOR(string_expression[,FOREGROUND|BACKGROUND])

                 The  COLOR function supports the definition of colors.  Using
                 the COLOR function, you can designate a value  to  specify  a
                 color and then use that value for arguments requiring a color
                 value.  The string expression names the  color  you  want  to
                 define; the optional keywords FOREGROUND and BACKGROUND iden‐
                 tify how the color is to be displayed on a monochrome  device
                 when the color is used in the definition of a color table.

                 The  UIL  compiler does not have built-in color names. Colors
                 are a server-dependent attribute of  an  object.  Colors  are
                 defined  on each server and may have different red-green-blue
                 (RGB) values on each server. The string you  specify  as  the
                 color argument must be recognized by the server on which your
                 application runs.

                 In a UID file, UIL represents a color as a character  string.
                 MRM  calls X translation routines that convert a color string
                 to the device-specific pixel value. If you are running  on  a
                 monochrome  server,  all  colors translate to black or white.
                 If you are on a color server, the color  names  translate  to
                 their proper colors if the following conditions are met:

                    ·  The color is defined.

                    ·  The color map is not yet full.

                 If  the  color  map  is  full, even valid colors translate to
                 black or white (foreground or background).

                 Interfaces do not, in general, specify colors for widgets, so
                 that  the  selection  of colors can be controlled by the user
                 through the .Xdefaults file.

                 To write an application that  runs  on  both  monochrome  and
                 color  devices,  you  need to specify which colors in a color
                 table (defined with the  COLOR_TABLE  function)  map  to  the
                 background  and which colors map to the foreground.  UIL lets
                 you use the COLOR function to designate this mapping  in  the
                 definition  of the color.  The following example shows how to
                 use the COLOR function to map the color red to the background
                 color on a monochrome device:

       VALUE c: COLOR ( 'red',BACKGROUND );

                 The  mapping  comes  into  play  only when the MRM is given a
                 color and the application is to be displayed on a  monochrome
                 device.  In  this case, each color is considered to be in one
                 of the following three categories:

                    ·  The color is mapped to  the  background  color  on  the
                       monochrome device.

                    ·  The  color  is  mapped  to  the foreground color on the
                       monochrome device.

                    ·  Monochrome mapping is undefined for this color.

                 If the color is mapped to the foreground or background color,
                 MRM  substitutes  the foreground or background color, respec‐
                 tively. If you do not specify the monochrome  mapping  for  a
                 color,  MRM  passes the color string to the Motif Toolkit for
                 mapping to the foreground or background color.

       RGB(red_integer, green_integer, blue_integer)

                 The three integers define the values for the red, green,  and
                 blue  components  of  the color, in that order. The values of
                 these components can range from 0 to 65,535, inclusive.   The
                 values may be represented as integer expressions.

                 In a UID file, UIL represents an RGB value as three integers.
                 MRM calls X translation routines that convert the integers to
                 the  device-specific  pixel  value.   If you are running on a
                 monochrome server, all colors translate to  black  or  white.
                 If  you  are on a color server, RGB values translate to their
                 proper colors if the colormap is not yet full.  If  the  col‐
                 ormap is full, values translate to black or white (foreground
                 or background).

       COLOR_TABLE(color_expression='character'[,...])

                 The color expression is a previously defined color,  a  color
                 defined  in line with the COLOR function, or the phrase BACK‐
                 GROUND COLOR or FOREGROUND COLOR. The character  can  be  any
                 valid UIL character.

                 The COLOR_TABLE function provides a device-independent way to
                 specify a set of colors.  The  COLOR_TABLE  function  accepts
                 either  previously  defined  UIL color names or in line color
                 definitions (using the COLOR function).  A color  table  must
                 be private because its contents must be known by the UIL com‐
                 piler to construct an icon. The colors within a color  table,
                 however, can be imported, exported, or private.

                 The single letter associated with each color is the character
                 you use to represent that color when creating an icon.   Each
                 letter  used  to  represent a color must be unique within the
                 color table.

       ICON([COLOR_TABLE=color_table_name,] row[,...)
                 color-table-name must refer to a previously defined color ta‐
                 ble,  and row is a character expression giving one row of the
                 icon.

                 The ICON function describes a rectangular icon that is x pix‐
                 els wide and y pixels high.  The strings surrounded by single
                 quotation marks describe the icon.  Each string represents  a
                 row  in  the  icon; each character in the string represents a
                 pixel.

                 The first row in an icon definition determines the  width  of
                 the  icon.   All rows must have the same number of characters
                 as the first row.  The height of the icon is dictated by  the
                 number of rows.  The maximum number of rows is 999.

                 The  first  argument  of  the  ICON function (the color table
                 specification) is optional and identifies the colors that are
                 available  in  this icon.  By using the single letter associ‐
                 ated with each color, you can specify the color of each pixel
                 in  the  icon.   The  icon  must be constructed of characters
                 defined in the specified color table.

                 A default color table is used if you omit the argument speci‐
                 fying  the  color table. To make use of the default color ta‐
                 ble, the rows of your  icon  must  contain  only  spaces  and
                 asterisks.  The default color table is defined as follows:

       COLOR_TABLE( BACKGROUND COLOR = ' ', FOREGROUND COLOR = '*')

                 You  can  define other characters to represent the background
                 color and foreground color by replacing the space and  aster‐
                 isk  in  the  BACKGROUND  COLOR  and FOREGROUND COLOR clauses
                 shown in the previous statement.  You can  specify  icons  as
                 private,  imported,  or  exported.  Use the MRM function Mrm‐
                 FetchIconLiteral to retrieve an exported icon at run time.

       XBITMAPFILE(string_expression)
                 The XBITMAPFILE function is similar to the ICON  function  in
                 that  both  describe a rectangular icon that is x pixels wide
                 and y pixels high.  However, XBITMAPFILE allows you to  spec‐
                 ify  an  external file containing the definition of an X bit‐
                 map, whereas all ICON  function  definitions  must  be  coded
                 directly  within UIL. X bitmap files can be generated by many
                 different X applications.  UIL reads these files through  the
                 XBITMAPFILE  function, but does not support creation of these
                 files.  The X bitmap file specified as the  argument  to  the
                 XBITMAPFILE function is read at application run time by MRM.

                 The  XBITMAPFILE  function returns a value of type pixmap and
                 can be used anywhere a pixmap data type is expected.

       SINGLE_FLOAT(real_number_literal)

                 The SINGLE_FLOAT function lets you store floating-point  lit‐
                 erals  in  UIL files as single-precision, floating-point num‐
                 bers.  Single-precision floating-point numbers can  often  be
                 stored  using  less  memory  than double-precision, floating-
                 point numbers.  The  real_number_literal  can  be  either  an
                 integer literal or a floating-point literal.

       FLOAT(real_number_literal)

                 The  FLOAT function lets you store floating-point literals in
                 UIL files as double-precision, floating-point  numbers.   The
                 real_number_literal  can  be  either  an integer literal or a
                 floating-point literal.

       FONT(string_expression[, CHARACTER_SET=char_set])

                 You define fonts with the  FONT  function.   Using  the  FONT
                 function,  you  designate  a value to specify a font and then
                 use that value for arguments that require a font value.   The
                 UIL compiler has no built-in fonts.

                 Each font makes sense only in the context of a character set.
                 The FONT function has an  additional  parameter  to  let  you
                 specify  the  character  set for the font.  This parameter is
                 optional; if you omit it, the default character  set  depends
                 on  the  value of the LANG environment variable if it is set,
                 or on the value of XmFALLBACK_CHARSET if LANG is not set.

                 string_expression specifies the name  of  the  font  and  the
                 clause  CHARACTER_SET  = char_set specifies the character set
                 for the font.  The string expression used in the  FONT  func‐
                 tion cannot be a compound string.

       FONTSET(string_expression[,...][, CHARACTER_SET=charset])

                 You  define  fontsets  with  the FONTSET function.  Using the
                 FONTSET function, you designate a set of  values  to  specify
                 fonts  and then use those values for arguments that require a
                 fontset.  The UIL compiler has no built-in fonts.

                 Each font makes sense only in the context of a character set.
                 The  FONTSET  function has an additional parameter to let you
                 specify the character set for the font.   This  parameter  is
                 optional;  if  you omit it, the default character set depends
                 on the value of the LANG environment variable if it  is  set,
                 or on the value of XmFALLBACK_CHARSET if LANG is not set.

                 The  string expression specifies the name of the font and the
                 clause CHARACTER_SET = char_set specifies the  character  set
                 for  the  font.   The  string  expression used in the FONTSET
                 function cannot be a compound string.

       FONT_TABLE(font_expression[,...])

                 A font table is a sequence of pairs of  fonts  and  character
                 sets.  At run time, when an object needs to display a string,
                 the object scans the font table for the  character  set  that
                 matches the character set of the string to be displayed.  UIL
                 provides the FONT_TABLE function to let you  supply  such  an
                 argument.   font_expression  is  created  with  the  FONT and
                 FONTSET functions.

                 If you specify a single font value  to  specify  an  argument
                 that  requires  a  font table, the UIL compiler automatically
                 converts a font value to a font table.

       COMPOUND_STRING(string_expression[,property[,...]])
                 Use the COMPOUND_STRING function to set properties of a null-
                 terminated  string  and to convert it into a compound string.
                 The properties you can set are the writing direction and sep‐
                 arator.

                 The  result  of  the  COMPOUND_STRING  function is a compound
                 string with the string  expression  as  its  value.  You  can
                 optionally  include  one  or more of the following clauses to
                 specify properties for the resulting compound string:

                 RIGHT_TO_LEFT = boolean_expression SEPARATE = boolean_expres‐
                 sion

                 The  RIGHT_TO_LEFT  clause  sets the writing direction of the
                 string from right to left if boolean_expression is True,  and
                 left  to  right otherwise.  Specifying this argument does not
                 cause the value of the string expression to change.   If  you
                 omit the RIGHT_TO_LEFT argument, the resulting string has the
                 same writing direction as string_expression.

                 The SEPARATE clause appends a separator to  the  end  of  the
                 compound  string  if  boolean_expression is True. If you omit
                 the SEPARATE clause, the resulting string  does  not  have  a
                 separator.

                 You cannot use imported or exported values as the operands of
                 the COMPOUND_STRING function.

       COMPOUND_STRING_COMPONENT(component_type [, {string | enumval}])
                 Use the COMPOUND_STRING_COMPONENT function to create compound
                 strings  in  UIL consisting of single components.  This func‐
                 tion is analagous to XmStringComponentCreate.  This  function
                 lets you create simple compound strings containing components
                 such as XmSTRING_COMPONENT_TAB and  XmSTRING_COMPONENT_RENDI‐
                 TION_BEGIN  which  are  not  produced  by the COMPOUND_STRING
                 function. These components can then be concatenated to  other
                 compound strings to build more complex compound strings.

                 The  first  argument must be an XmStringComponentType enumer‐
                 ated constant.  The type and  interpretation  of  the  second
                 argument  depends on the first argument.  For example, if you
                 specify any of the following  enumerated  constants  for  the
                 first  argument,  then  you should not specify a second argu‐
                 ment:  XmSTRING_COMPONENT_SEPARATOR,  XmSTRING_COMPONENT_LAY‐
                 OUT_POP,    XmSTRING_COMPONENT_TAB,    and    XmSTRING_COMPO‐
                 NENT_LOCALE.  However, if you specify an enumerated  constant
                 from  the  following  group, then you must supply a string as
                 the     second     argument:      XmSTRING_COMPONENT_CHARSET,
                 XmSTRING_COMPONENT_TEXT,      XmSTRING_COMPONENT_LOCALE_TEXT,
                 XmSTRING_COMPONENT_WIDECHAR_TEXT,   XmSTRING_COMPONENT_RENDI‐
                 TION_BEGIN,  and  XmSTRING_COMPONENT_RENDITION_END.   If  you
                 specify XmSTRING_COMPONENT_DIRECTION as the  first  argument,
                 then  you  must  specify an XmStringDirection enumerated con‐
                 stant as  the  second  argument.   Finally,  if  you  specify
                 XmSTRING_COMPONENT_LAYOUT_PUSH  as  the  first argument, then
                 you must specify an XmDirection enumerated  constant  as  the
                 second argument.

                 The   compound  string  components  XmSTRING_COMPONENT_RENDI‐
                 TION_BEGIN, and  XmSTRING_COMPONENT_RENDITION_END  take,  for
                 their  argument,  the "tag," or name, of a rendition from the
                 current render table. See  the  following  section  for  more
                 information about how to specify a render table.

       COMPOUND_STRING_TABLE(string_expression[,...])
                 A  compound  string  table  is  an array of compound strings.
                 Objects requiring a  list  of  string  values,  such  as  the
                 XmNitems  and XmNselectedItems arguments for the list widget,
                 use string table values. The  COMPOUND_STRING_TABLE  function
                 builds the values for these two arguments of the list widget.
                 The COMPOUND_STRING_TABLE function generates a value of  type
                 string_table.   The  name  STRING_TABLE is a synonym for COM‐
                 POUND_STRING_TABLE.

                 The strings inside the string table must be  simple  strings,
                 which  the  UIL  compiler  automatically converts to compound
                 strings.

       ASCIZ_STRING_TABLE(string_expression[,...])
                 An ASCIZ string table is an array of ASCIZ  (null-terminated)
                 string  values  separated by commas. This function allows you
                 to pass more than one ASCIZ string as a callback  tag  value.
                 The  ASCIZ_STRING_TABLE  function  generates  a value of type
                 asciz_table.   The  name  ASCIZ_TABLE  is   a   synonym   for
                 ASCIZ_STRING_TABLE.

       WIDE_CHARACTER(string_expression)

                 Use  the WIDE_CHARACTER function to generate a wide character
                 string from null-terminated string in the current locale.

       CLASS_REC_NAME(string_expression)

                 Use the CLASS_REC_NAME function to generate  a  widget  class
                 name.   For a widget class defined by the toolkit, the string
                 argument is the name of the class.  For a  user-defined  wid‐
                 get,  the string argument is the name of the creation routine
                 for the widget.

       INTEGER_TABLE(integer_expression[,...])
                 An integer table is an array of integer values  separated  by
                 commas.  This function allows you to pass more than one inte‐
                 ger per callback tag value.  The INTEGER_TABLE function  gen‐
                 erates a value of type integer_table.

       ARGUMENT(string_expression[, argument_type])

                 The ARGUMENT function defines the arguments to a user-defined
                 widget.  Each of the objects that can  be  described  by  UIL
                 permits  a  set of arguments, listed in Appendix B. For exam‐
                 ple, XmNheight is an argument to  most  objects  and  has  an
                 integer  data type. To specify height for a user-defined wid‐
                 get, you can use the built-in argument  name  XmNheight,  and
                 specify  an  integer  value when you declare the user-defined
                 widget.  You do not use  the  ARGUMENT  function  to  specify
                 arguments that are built into the UIL compiler.

                 The  string_expression name is the name the UIL compiler uses
                 for the argument in the UID file.  argument_type is the  type
                 of  value  that  can  be associated with the argument. If you
                 omit the second argument, the default  type  is  ANY  and  no
                 value type checking occurs. Use one of the following keywords
                 to specify the argument type:

                    ·  ANY

                    ·  ASCIZ_TABLE

                    ·  BOOLEAN

                    ·  COLOR

                    ·  COMPOUND_STRING

                    ·  FLOAT

                    ·  FONT

                    ·  FONT_TABLE

                    ·  FONTSET

                    ·  ICON

                    ·  INTEGER

                    ·  INTEGER_TABLE

                    ·  KEYSYM

                    ·  PIXMAP

                    ·  REASON

                    ·  SINGLE_FLOAT

                    ·  STRING

                    ·  STRING_TABLE

                    ·  TRANSLATION_TABLE

                    ·  WIDE_CHARACTER

                    ·  WIDGET

                 You can use the ARGUMENT function to allow the  UIL  compiler
                 to recognize extensions to the Motif Toolkit. For example, an
                 existing widget may accept a new argument. Using the ARGUMENT
                 function, you can make this new argument available to the UIL
                 compiler before  the  updated  version  of  the  compiler  is
                 released.

       REASON(string_expression)

                 The  REASON  function  is useful for defining new reasons for
                 user-defined widgets.

                 Each of the objects in the Motif Toolkit  defines  a  set  of
                 conditions  under  which  it  calls  a user-defined function.
                 These conditions are known as callback  reasons.   The  user-
                 defined  functions  are  termed callback procedures. In a UIL
                 module, you use a  callbacks  list  to  specify  which  user-
                 defined functions are to be called for which reasons.

                 Appendix  B lists the callback reasons supported by the Motif
                 Toolkit objects.

                 When you declare a user-defined widget, you can define  call‐
                 back  reasons for that widget using the REASON function.  The
                 string expression specifies the argument name stored  in  the
                 UID  file for the reason. This reason name is supplied to the
                 widget creation routine at run time.

       TRANSLATION_TABLE(string_expression[,...])

                 Each of the Motif Toolkit widgets  has  a  translation  table
                 that  maps  X  events  (for  example,  mouse  button  1 being
                 pressed) to a sequence of actions. Through widget  arguments,
                 such  as the common translations argument, you can specify an
                 alternate set of events or actions for a  particular  widget.
                 The  TRANSLATION_TABLE  function  creates a translation table
                 that can be used as the value of an argument that is  of  the
                 data type translation_table.

                 You can use one of the following translation table directives
                 with the TRANSLATION_TABLE function: #override, #augment,  or
                 #replace.   The  default  is #replace.  If you specify one of
                 these directives, it must be the first entry in the  transla‐
                 tion table.

                 The  #override directive causes any duplicate translations to
                 be ignored.  For example, if a translation for <Btn1Down>  is
                 already defined in the current translations for a PushButton,
                 the translation defined  by  new_translations  overrides  the
                 current  definition.  If the #augment directive is specified,
                 the current definition takes precedence.  The #replace direc‐
                 tive  replaces  all current translations with those specified
                 in the XmNtranslations resource.

   Renditions and Render Tables
       In addition to the string direction, each  compound  string  carries  a
       great  deal  of  information about how its text is to be rendered. Each
       compound string contains a "tag," identifying  the  "rendition"  to  be
       used  to  draw  that string. The rendition contains such information as
       the font, the size, the color, whether the text is to be underlined  or
       crossed  out,  and the position and style of any tab stops. Many rendi‐
       tions are combined into a "render table," which  is  specified  to  any
       widget  with  the XmNrenderTable resource, and in the widget's controls
       list.

       UIL implements render tables, renditions, tab lists, and tab stops as a
       special  class of objects, in a form similar to the widget class. These
       objects are not themselves widgets or gadgets, but the format  used  by
       UIL  to  specify  widget resources provides a convenient way to specify
       the qualities and dependencies of these objects.

       For example, a render table, included in some widget's  controls  list,
       must  also  have  a  controls list in its specification, containing the
       names of its member renditions. Each rendition, in  its  specification,
       will  contain  an arguments list specifying such qualities as the font,
       the color, and whether the text is to be underlined. Any of the  rendi‐
       tions may also control a tablist, which will itself control one or more
       tab stops.

       Please refer to the Motif Programmer's Guide for a complete description
       of  renditions and render tables, and for an example of how to use them
       in UIL.

RELATED INFORMATION
       uil(1), Uil(3)



                                                             UIL(file formats)
