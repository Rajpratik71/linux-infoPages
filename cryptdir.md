File: *manpages*,  Node: cryptdir,  Up: (dir)

CRYPTDIR(1)                 General Commands Manual                CRYPTDIR(1)



NAME
       cryptdir - encrypt/decrypt all files in a directory

SYNOPSIS
       cryptdir [ dir ]
       decryptdir [ dir ]

INTRODUCTION
       cryptdir  encrypts  all  files  in  the current directory (or the given
       directory if one is provided as an argument).  When called as  decrypt-
       dir (i.e., same program, different name), all files are decrypted.


NOTES
       When  encrypting,  you are prompted twice for the password as a precau-
       tionary measure.  It would be a disaster to encrypt files with a  pass-
       word that wasn't what you intended.

       In  contrast, when decrypting, you are only prompted once.  If it's the
       wrong password, no harm done.

       Encrypted files have the suffix .crypt appended.  This  prevents  files
       from  being  encrypted  twice.   The suffix is removed upon decryption.
       Thus, you can easily add files to an encrypted directory and run crypt-
       dir on it without worrying about the already encrypted files.

BUGS
       The man page is longer than the program.


SEE ALSO
       "Exploring  Expect: A Tcl-Based Toolkit for Automating Interactive Pro-
       grams" by Don Libes, O'Reilly and Associates, January 1995.

AUTHOR
       Don Libes, National Institute of Standards and Technology



                                1 January 1993                     CRYPTDIR(1)
