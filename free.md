File: libc.info,  Node: Freeing after Malloc,  Next: Changing Block Size,  Prev: Malloc Examples,  Up: Unconstrained Allocation

3.2.2.3 Freeing Memory Allocated with `malloc'
..............................................

When you no longer need a block that you got with `malloc', use the
function `free' to make the block available to be allocated again.  The
prototype for this function is in `stdlib.h'.  

 -- Function: void free (void *PTR)
     Preliminary: | MT-Safe | AS-Unsafe lock | AC-Unsafe lock fd mem |
     *Note POSIX Safety Concepts::.

     The `free' function deallocates the block of memory pointed at by
     PTR.

 -- Function: void cfree (void *PTR)
     Preliminary: | MT-Safe | AS-Unsafe lock | AC-Unsafe lock fd mem |
     *Note POSIX Safety Concepts::.

     This function does the same thing as `free'.  It's provided for
     backward compatibility with SunOS; you should use `free' instead.

   Freeing a block alters the contents of the block.  *Do not expect to
find any data (such as a pointer to the next block in a chain of
blocks) in the block after freeing it.*  Copy whatever you need out of
the block before freeing it!  Here is an example of the proper way to
free all the blocks in a chain, and the strings that they point to:

     struct chain
       {
         struct chain *next;
         char *name;
       }

     void
     free_chain (struct chain *chain)
     {
       while (chain != 0)
         {
           struct chain *next = chain->next;
           free (chain->name);
           free (chain);
           chain = next;
         }
     }

   Occasionally, `free' can actually return memory to the operating
system and make the process smaller.  Usually, all it can do is allow a
later call to `malloc' to reuse the space.  In the meantime, the space
remains in your program as part of a free-list used internally by
`malloc'.

   There is no point in freeing blocks at the end of a program, because
all of the program's space is given back to the system when the process
terminates.

