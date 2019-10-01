File: libc.info,  Node: Argp Parser Functions,  Next: Argp Children,  Prev: Argp Option Vectors,  Up: Argp Parsers

25.3.5 Argp Parser Functions
----------------------------

The function pointed to by the 'parser' field in a 'struct argp' (*note
Argp Parsers::) defines what actions take place in response to each
option or argument parsed.  It is also used as a hook, allowing a parser
to perform tasks at certain other points during parsing.

   Argp parser functions have the following type signature:

     error_t PARSER (int KEY, char *ARG, struct argp_state *STATE)

where the arguments are as follows:

KEY
     For each option that is parsed, PARSER is called with a value of
     KEY from that option's 'key' field in the option vector.  *Note
     Argp Option Vectors::.  PARSER is also called at other times with
     special reserved keys, such as 'ARGP_KEY_ARG' for non-option
     arguments.  *Note Argp Special Keys::.

ARG
     If KEY is an option, ARG is its given value.  This defaults to zero
     if no value is specified.  Only options that have a non-zero 'arg'
     field can ever have a value.  These must _always_ have a value
     unless the 'OPTION_ARG_OPTIONAL' flag is specified.  If the input
     being parsed specifies a value for an option that doesn't allow
     one, an error results before PARSER ever gets called.

     If KEY is 'ARGP_KEY_ARG', ARG is a non-option argument.  Other
     special keys always have a zero ARG.

STATE
     STATE points to a 'struct argp_state', containing useful
     information about the current parsing state for use by PARSER.
     *Note Argp Parsing State::.

   When PARSER is called, it should perform whatever action is
appropriate for KEY, and return '0' for success, 'ARGP_ERR_UNKNOWN' if
the value of KEY is not handled by this parser function, or a unix error
code if a real error occurred.  *Note Error Codes::.

 -- Macro: int ARGP_ERR_UNKNOWN
     Argp parser functions should return 'ARGP_ERR_UNKNOWN' for any KEY
     value they do not recognize, or for non-option arguments ('KEY ==
     ARGP_KEY_ARG') that they are not equipped to handle.

   A typical parser function uses a switch statement on KEY:

     error_t
     parse_opt (int key, char *arg, struct argp_state *state)
     {
       switch (key)
         {
         case OPTION_KEY:
           ACTION
           break;
         ...
         default:
           return ARGP_ERR_UNKNOWN;
         }
       return 0;
     }

* Menu:

* Keys: Argp Special Keys.           Special values for the KEY argument.
* State: Argp Parsing State.         What the STATE argument refers to.
* Functions: Argp Helper Functions.  Functions to help during argp parsing.

File: libc.info,  Node: Argp Special Keys,  Next: Argp Parsing State,  Up: Argp Parser Functions

25.3.5.1 Special Keys for Argp Parser Functions
...............................................

In addition to key values corresponding to user options, the KEY
argument to argp parser functions may have a number of other special
values.  In the following example ARG and STATE refer to parser function
arguments.  *Note Argp Parser Functions::.

'ARGP_KEY_ARG'
     This is not an option at all, but rather a command line argument,
     whose value is pointed to by ARG.

     When there are multiple parser functions in play due to argp
     parsers being combined, it's impossible to know which one will
     handle a specific argument.  Each is called until one returns 0 or
     an error other than 'ARGP_ERR_UNKNOWN'; if an argument is not
     handled, 'argp_parse' immediately returns success, without parsing
     any more arguments.

     Once a parser function returns success for this key, that fact is
     recorded, and the 'ARGP_KEY_NO_ARGS' case won't be used.
     _However_, if while processing the argument a parser function
     decrements the 'next' field of its STATE argument, the option won't
     be considered processed; this is to allow you to actually modify
     the argument, perhaps into an option, and have it processed again.

'ARGP_KEY_ARGS'
     If a parser function returns 'ARGP_ERR_UNKNOWN' for 'ARGP_KEY_ARG',
     it is immediately called again with the key 'ARGP_KEY_ARGS', which
     has a similar meaning, but is slightly more convenient for
     consuming all remaining arguments.  ARG is 0, and the tail of the
     argument vector may be found at 'STATE->argv + STATE->next'.  If
     success is returned for this key, and 'STATE->next' is unchanged,
     all remaining arguments are considered to have been consumed.
     Otherwise, the amount by which 'STATE->next' has been adjusted
     indicates how many were used.  Here's an example that uses both,
     for different args:

          ...
          case ARGP_KEY_ARG:
            if (STATE->arg_num == 0)
              /* First argument */
              first_arg = ARG;
            else
              /* Let the next case parse it.  */
              return ARGP_KEY_UNKNOWN;
            break;
          case ARGP_KEY_ARGS:
            remaining_args = STATE->argv + STATE->next;
            num_remaining_args = STATE->argc - STATE->next;
            break;

'ARGP_KEY_END'
     This indicates that there are no more command line arguments.
     Parser functions are called in a different order, children first.
     This allows each parser to clean up its state for the parent.

'ARGP_KEY_NO_ARGS'
     Because it's common to do some special processing if there aren't
     any non-option args, parser functions are called with this key if
     they didn't successfully process any non-option arguments.  This is
     called just before 'ARGP_KEY_END', where more general validity
     checks on previously parsed arguments take place.

'ARGP_KEY_INIT'
     This is passed in before any parsing is done.  Afterwards, the
     values of each element of the 'child_input' field of STATE, if any,
     are copied to each child's state to be the initial value of the
     'input' when _their_ parsers are called.

'ARGP_KEY_SUCCESS'
     Passed in when parsing has successfully been completed, even if
     arguments remain.

'ARGP_KEY_ERROR'
     Passed in if an error has occurred and parsing is terminated.  In
     this case a call with a key of 'ARGP_KEY_SUCCESS' is never made.

'ARGP_KEY_FINI'
     The final key ever seen by any parser, even after
     'ARGP_KEY_SUCCESS' and 'ARGP_KEY_ERROR'.  Any resources allocated
     by 'ARGP_KEY_INIT' may be freed here.  At times, certain resources
     allocated are to be returned to the caller after a successful
     parse.  In that case, those particular resources can be freed in
     the 'ARGP_KEY_ERROR' case.

   In all cases, 'ARGP_KEY_INIT' is the first key seen by parser
functions, and 'ARGP_KEY_FINI' the last, unless an error was returned by
the parser for 'ARGP_KEY_INIT'.  Other keys can occur in one the
following orders.  OPT refers to an arbitrary option key:

OPT... 'ARGP_KEY_NO_ARGS' 'ARGP_KEY_END' 'ARGP_KEY_SUCCESS'
     The arguments being parsed did not contain any non-option
     arguments.

( OPT | 'ARGP_KEY_ARG' )... 'ARGP_KEY_END' 'ARGP_KEY_SUCCESS'
     All non-option arguments were successfully handled by a parser
     function.  There may be multiple parser functions if multiple argp
     parsers were combined.

( OPT | 'ARGP_KEY_ARG' )... 'ARGP_KEY_SUCCESS'
     Some non-option argument went unrecognized.

     This occurs when every parser function returns 'ARGP_KEY_UNKNOWN'
     for an argument, in which case parsing stops at that argument if
     ARG_INDEX is a null pointer.  Otherwise an error occurs.

   In all cases, if a non-null value for ARG_INDEX gets passed to
'argp_parse', the index of the first unparsed command-line argument is
passed back in that value.

   If an error occurs and is either detected by argp or because a parser
function returned an error value, each parser is called with
'ARGP_KEY_ERROR'.  No further calls are made, except the final call with
'ARGP_KEY_FINI'.

File: libc.info,  Node: Argp Parsing State,  Next: Argp Helper Functions,  Prev: Argp Special Keys,  Up: Argp Parser Functions

25.3.5.2 Argp Parsing State
...........................

The third argument to argp parser functions (*note Argp Parser
Functions::) is a pointer to a 'struct argp_state', which contains
information about the state of the option parsing.

 -- Data Type: struct argp_state
     This structure has the following fields, which may be modified as
     noted:

     'const struct argp *const root_argp'
          The top level argp parser being parsed.  Note that this is
          often _not_ the same 'struct argp' passed into 'argp_parse' by
          the invoking program.  *Note Argp::.  It is an internal argp
          parser that contains options implemented by 'argp_parse'
          itself, such as '--help'.

     'int argc'
     'char **argv'
          The argument vector being parsed.  This may be modified.

     'int next'
          The index in 'argv' of the next argument to be parsed.  This
          may be modified.

          One way to consume all remaining arguments in the input is to
          set 'STATE->next = STATE->argc', perhaps after recording the
          value of the 'next' field to find the consumed arguments.  The
          current option can be re-parsed immediately by decrementing
          this field, then modifying 'STATE->argv[STATE->next]' to
          reflect the option that should be reexamined.

     'unsigned flags'
          The flags supplied to 'argp_parse'.  These may be modified,
          although some flags may only take effect when 'argp_parse' is
          first invoked.  *Note Argp Flags::.

     'unsigned arg_num'
          While calling a parsing function with the KEY argument
          'ARGP_KEY_ARG', this represents the number of the current arg,
          starting at 0.  It is incremented after each 'ARGP_KEY_ARG'
          call returns.  At all other times, this is the number of
          'ARGP_KEY_ARG' arguments that have been processed.

     'int quoted'
          If non-zero, the index in 'argv' of the first argument
          following a special '--' argument.  This prevents anything
          that follows from being interpreted as an option.  It is only
          set after argument parsing has proceeded past this point.

     'void *input'
          An arbitrary pointer passed in from the caller of
          'argp_parse', in the INPUT argument.

     'void **child_inputs'
          These are values that will be passed to child parsers.  This
          vector will be the same length as the number of children in
          the current parser.  Each child parser will be given the value
          of 'STATE->child_inputs[I]' as _its_ 'STATE->input' field,
          where I is the index of the child in the this parser's
          'children' field.  *Note Argp Children::.

     'void *hook'
          For the parser function's use.  Initialized to 0, but
          otherwise ignored by argp.

     'char *name'
          The name used when printing messages.  This is initialized to
          'argv[0]', or 'program_invocation_name' if 'argv[0]' is
          unavailable.

     'FILE *err_stream'
     'FILE *out_stream'
          The stdio streams used when argp prints.  Error messages are
          printed to 'err_stream', all other output, such as '--help'
          output) to 'out_stream'.  These are initialized to 'stderr'
          and 'stdout' respectively.  *Note Standard Streams::.

     'void *pstate'
          Private, for use by the argp implementation.

File: libc.info,  Node: Argp Helper Functions,  Prev: Argp Parsing State,  Up: Argp Parser Functions

25.3.5.3 Functions For Use in Argp Parsers
..........................................

Argp provides a number of functions available to the user of argp (*note
Argp Parser Functions::), mostly for producing error messages.  These
take as their first argument the STATE argument to the parser function.
*Note Argp Parsing State::.

 -- Function: void argp_usage (const struct argp_state *STATE)
     Preliminary: | MT-Unsafe race:argpbuf env locale | AS-Unsafe heap
     i18n corrupt | AC-Unsafe mem corrupt lock | *Note POSIX Safety
     Concepts::.

     Outputs the standard usage message for the argp parser referred to
     by STATE to 'STATE->err_stream' and terminate the program with
     'exit (argp_err_exit_status)'.  *Note Argp Global Variables::.

 -- Function: void argp_error (const struct argp_state *STATE, const
          char *FMT, ...)
     Preliminary: | MT-Unsafe race:argpbuf env locale | AS-Unsafe heap
     i18n corrupt | AC-Unsafe mem corrupt lock | *Note POSIX Safety
     Concepts::.

     Prints the printf format string FMT and following args, preceded by
     the program name and ':', and followed by a 'Try ... --help'
     message, and terminates the program with an exit status of
     'argp_err_exit_status'.  *Note Argp Global Variables::.

 -- Function: void argp_failure (const struct argp_state *STATE, int
          STATUS, int ERRNUM, const char *FMT, ...)
     Preliminary: | MT-Safe | AS-Unsafe corrupt heap | AC-Unsafe lock
     corrupt mem | *Note POSIX Safety Concepts::.

     Similar to the standard gnu error-reporting function 'error', this
     prints the program name and ':', the printf format string FMT, and
     the appropriate following args.  If it is non-zero, the standard
     unix error text for ERRNUM is printed.  If STATUS is non-zero, it
     terminates the program with that value as its exit status.

     The difference between 'argp_failure' and 'argp_error' is that
     'argp_error' is for _parsing errors_, whereas 'argp_failure' is for
     other problems that occur during parsing but don't reflect a
     syntactic problem with the input, such as illegal values for
     options, bad phase of the moon, etc.

 -- Function: void argp_state_help (const struct argp_state *STATE, FILE
          *STREAM, unsigned FLAGS)
     Preliminary: | MT-Unsafe race:argpbuf env locale | AS-Unsafe heap
     i18n corrupt | AC-Unsafe mem corrupt lock | *Note POSIX Safety
     Concepts::.

     Outputs a help message for the argp parser referred to by STATE, to
     STREAM.  The FLAGS argument determines what sort of help message is
     produced.  *Note Argp Help Flags::.

   Error output is sent to 'STATE->err_stream', and the program name
printed is 'STATE->name'.

   The output or program termination behavior of these functions may be
suppressed if the 'ARGP_NO_EXIT' or 'ARGP_NO_ERRS' flags are passed to
'argp_parse'.  *Note Argp Flags::.

   This behavior is useful if an argp parser is exported for use by
other programs (e.g., by a library), and may be used in a context where
it is not desirable to terminate the program in response to parsing
errors.  In argp parsers intended for such general use, and for the case
where the program _doesn't_ terminate, calls to any of these functions
should be followed by code that returns the appropriate error code:

     if (BAD ARGUMENT SYNTAX)
       {
          argp_usage (STATE);
          return EINVAL;
       }

If a parser function will _only_ be used when 'ARGP_NO_EXIT' is not set,
the return may be omitted.

