File: libc.info,  Node: Allocating Cleared Space,  Next: Efficiency and Malloc,  Prev: Changing Block Size,  Up: Unconstrained Allocation

3.2.2.5 Allocating Cleared Space
................................

The function 'calloc' allocates memory and clears it to zero.  It is
declared in 'stdlib.h'.

 -- Function: void * calloc (size_t COUNT, size_t ELTSIZE)
     Preliminary: | MT-Safe | AS-Unsafe lock | AC-Unsafe lock fd mem |
     *Note POSIX Safety Concepts::.

     This function allocates a block long enough to contain a vector of
     COUNT elements, each of size ELTSIZE.  Its contents are cleared to
     zero before 'calloc' returns.

   You could define 'calloc' as follows:

     void *
     calloc (size_t count, size_t eltsize)
     {
       size_t size = count * eltsize;
       void *value = malloc (size);
       if (value != 0)
         memset (value, 0, size);
       return value;
     }

   But in general, it is not guaranteed that 'calloc' calls 'malloc'
internally.  Therefore, if an application provides its own
'malloc'/'realloc'/'free' outside the C library, it should always define
'calloc', too.

