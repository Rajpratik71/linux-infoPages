File: *manpages*,  Node: composite,  Up: (dir)

composite(1)                General Commands Manual               composite(1)



NAME
       composite -  overlaps one image over another.

SYNOPSIS
       composite  [  options ... ] change-file base-file [ mask-file ] output-
       image

OVERVIEW
       The composite program is a member of the ImageMagick(1) suite of tools.
       Use it to overlap one image over another.

       For more information about the composite command, point your browser to
       file:///usr/share/doc/ImageMagick-6.7.8/www/composite.html           or
       http://www.imagemagick.org/script/composite.php.

DESCRIPTION
       Image Settings:
         -affine matrix       affine transform matrix
         -alpha option        on, activate, off, deactivate, set, opaque, copy
                              transparent, extract, background, or shape
         -authenticate value  decrypt image with this password
         -blue-primary point  chromaticity blue primary point
         -channel type        apply option to select image channels
         -colorspace type     alternate image colorspace
         -comment string      annotate image with comment
         -compose operator    composite operator
         -compress type       type of pixel compression when writing the image
         -decipher filename   convert cipher pixels to plain pixels
         -define format:option
                              define one or more image format options
         -depth value         image depth
         -density geometry    horizontal and vertical density of the image
         -display server      get image or font from this X server
         -dispose method      layer disposal method
         -dither method       apply error diffusion to image
         -encipher filename   convert plain pixels to cipher pixels
         -encoding type       text encoding type
         -endian type         endianness (MSB or LSB) of the image
         -filter type         use this filter when resizing an image
         -font name           render text with this font
         -format "string"     output formatted image characteristics
         -gravity type        which direction to gravitate towards
         -green-primary point chromaticity green primary point
         -interlace type      type of image interlacing scheme
         -interpolate method  pixel color interpolation method
         -label string        assign a label to an image
         -limit type value    pixel cache resource limit
         -matte               store matte channel if the image has one
         -monitor             monitor progress
         -page geometry       size and location of an image canvas (setting)
         -pointsize value     font point size
         -quality value       JPEG/MIFF/PNG compression level
         -quiet               suppress all warning messages
         -red-primary point   chromaticity red primary point
         -regard-warnings     pay attention to warning messages
         -respect-parentheses  settings  remain  in  effect  until parenthesis
       boundary
         -sampling-factor geometry
                              horizontal and vertical sampling factor
         -scene value         image scene number
         -seed value          seed a new sequence of pseudo-random numbers
         -size geometry       width and height of image
         -support factor      resize support: > 1.0 is blurry, < 1.0 is sharp
         -synchronize         synchronize image to storage device
         -taint               declare the image as modified
         -transparent-color color
                              transparent color
         -treedepth value     color tree depth
         -tile                repeat composite operation across and down image
         -units type          the units of image resolution
         -verbose             print detailed information about the image
         -virtual-pixel method
                              virtual pixel access method
         -white-point point   chromaticity white point

       Image Operators:
         -blend geometry      blend images
         -border geometry     surround image with a border of color
         -bordercolor color   border color
         -colors value        preferred number of colors in the image
         -displace geometry   shift image pixels defined by a displacement map
         -dissolve value      dissolve the two images a given percent
         -distort geometry    shift lookup according to a absolute  distortion
       map
         -extract geometry    extract area from image
         -geometry geometry   location of the composite image
         -identify             identify  the format and characteristics of the
       image
         -monochrome          transform image to black and white
         -negate              replace each pixel with its complementary color
         -profile filename    add ICM or IPTC information profile to image
         -quantize colorspace reduce colors in this colorspace
         -repage geometry     size and location of an image canvas (operator)
         -rotate degrees      apply Paeth rotation to the image
         -resize geometry     resize the image
         -sharpen geometry    sharpen the image
         -shave geometry      shave pixels from the image edges
         -stegano offset      hide watermark within an image
         -stereo              combine two image to create a stereo anaglyph
         -strip               strip image of all profiles and comments
         -thumbnail geometry  create a thumbnail of the image
         -transform           affine transform image
         -type type           image type
         -unsharp geometry    sharpen the image
         -watermark geometry  percent brightness and saturation of a watermark
         -write filename      write images to this file

       Image Stack Operators:
         -swap indexes        swap two images in the image sequence

       Miscellaneous Options:
         -debug events        display copious debugging information
         -help                print program options
         -log format          format of debugging information
         -list type           print a list of supported option arguments
         -version             print version information

       By default, the image format of `file' is determined by its magic  num‐
       ber.   To  specify a particular image format, precede the filename with
       an image format name and a colon (i.e. ps:image) or specify  the  image
       type as the filename suffix (i.e. image.ps).  Specify 'file' as '-' for
       standard input or output.

SEE ALSO
       ImageMagick(1)


COPYRIGHT
       Copyright (C) 1999-2012 ImageMagick Studio LLC.  Additional  copyrights
       and       licenses      apply      to      this      software,      see
       file:///usr/share/doc/ImageMagick-6.7.8/www/license.html             or
       http://www.imagemagick.org/script/license.php



ImageMagick                Date: 2009/01/10 01:00:00              composite(1)
Composite(library call)                                Composite(library call)



NAME
       Composite — The Composite widget class

SYNOPSIS
       #include <Xm/Xm.h>

DESCRIPTION
       Composite  widgets  are intended to be containers for other widgets and
       can have  an  arbitrary  number  of  children.  Their  responsibilities
       (implemented  either  directly  by  the  widget  class or indirectly by
       Intrinsics functions) include:

          ·  Overall management of children from creation to destruction.

          ·  Destruction  of  descendants  when  the   composite   widget   is
             destroyed.

          ·  Physical  arrangement (geometry management) of a displayable sub‐
             set of managed children.

          ·  Mapping and unmapping  of  a  subset  of  the  managed  children.
             Instances of composite widgets need to specify the order in which
             their children are kept. For example, an application may  want  a
             set of command buttons in some logical order grouped by function,
             and it may want buttons that represent filenames to  be  kept  in
             alphabetical order.

   Classes
       Composite inherits behavior and resources from Core.

       The class pointer is compositeWidgetClass.

       The class name is Composite.

   New Resources
       The  following table defines a set of widget resources used by the pro‐
       grammer to specify data. The programmer can also set the resource  val‐
       ues  for  the  inherited  classes to set attributes for this widget. To
       reference a resource by name or by class in a .Xdefaults  file,  remove
       the  XmN or XmC prefix and use the remaining letters. To specify one of
       the defined values for a resource in a .Xdefaults file, remove  the  Xm
       prefix and use the remaining letters (in either lowercase or uppercase,
       but include any underscores between words).  The codes  in  the  access
       column  indicate if the given resource can be set at creation time (C),
       set by using XtSetValues (S), retrieved by using XtGetValues (G), or is
       not applicable (N/A).

       ┌───────────────────────────────────────────────────────────────────────┐
       │                  │     Composite Resource Set      │         │        │
       │Name              │ Class             │ Type        │ Default │ Access │
       ├──────────────────┼───────────────────┼─────────────┼─────────┼────────┤
       │XmNchildren       │ XmCReadOnly       │ WidgetList  │ NULL    │ G      │
       ├──────────────────┼───────────────────┼─────────────┼─────────┼────────┤
       │XmNinsertPosition │ XmCInsertPosition │ XtOrderProc │ NULL    │ CSG    │
       ├──────────────────┼───────────────────┼─────────────┼─────────┼────────┤
       │XmNnumChildren    │ XmCReadOnly       │ Cardinal    │ 0       │ G      │
       ├──────────────────┼───────────────────┼─────────────┼─────────┼────────┤
       └──────────────────┴───────────────────┴─────────────┴─────────┴────────┘
       XmNchildren
                 A read-only list of the children of the widget.

       XmNinsertPosition
                 Points to the XtOrderProc function described below.

       XmNnumChildren
                 A  read-only  resource  specifying  the length of the list of
                 children in XmNchildren.

       The following procedure pointer in a composite widget  instance  is  of
       type XtOrderProc:

       Cardinal (* XtOrderProc) (Widget w);

       w         Specifies the widget.

       Composite  widgets  that allow clients to order their children (usually
       homogeneous boxes) can call their widget  instance's  XmNinsertPosition
       procedure  from the class's insert_child procedure to determine where a
       new child should go in its children array. Thus, a client of a  compos‐
       ite  class  can apply different sorting criteria to widget instances of
       the class, passing in a different XmNinsertPosition procedure  when  it
       creates each composite widget instance.

       The  return value of the XmNinsertPosition procedure indicates how many
       children should go before the widget. A value  of  0  (zero)  indicates
       that  the  widget  should  go  before all other children; returning the
       value of XmNumChildren indicates that it  should  go  after  all  other
       children.   By default, unless a subclass or an application provides an
       XmNinsertPosition procedure, each child is inserted at the end  of  the
       XmNchildren list.  The XmNinsertPosition procedure can be overridden by
       a specific composite widget's resource list or  by  the  argument  list
       provided when the composite widget is created.

   Inherited Resources
       Composite inherits behavior and resources from the superclass described
       in the following table.  For a complete description of  each  resource,
       refer to the reference page for that superclass.

       ┌───────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
       │                              │               Core Resource Set                │                      │        │
       │Name                          │ Class                         │ Type           │ Default              │ Access │
       ├──────────────────────────────┼───────────────────────────────┼────────────────┼──────────────────────┼────────┤
       │XmNaccelerators               │ XmCAccelerators               │ XtAccelerators │ dynamic              │ CSG    │
       ├──────────────────────────────┼───────────────────────────────┼────────────────┼──────────────────────┼────────┤
       │XmNancestorSensitive          │ XmCSensitive                  │ Boolean        │ dynamic              │ G      │
       ├──────────────────────────────┼───────────────────────────────┼────────────────┼──────────────────────┼────────┤
       │XmNbackground                 │ XmCBackground                 │ Pixel          │ dynamic              │ CSG    │
       ├──────────────────────────────┼───────────────────────────────┼────────────────┼──────────────────────┼────────┤
       │XmNbackgroundPixmap           │ XmCPixmap                     │ Pixmap         │ XmUNSPECIFIED_PIXMAP │ CSG    │
       ├──────────────────────────────┼───────────────────────────────┼────────────────┼──────────────────────┼────────┤
       │XmNborderColor                │ XmCBorderColor                │ Pixel          │ XtDefaultForeground  │ CSG    │
       ├──────────────────────────────┼───────────────────────────────┼────────────────┼──────────────────────┼────────┤
       │XmNborderPixmap               │ XmCPixmap                     │ Pixmap         │ XmUNSPECIFIED_PIXMAP │ CSG    │
       ├──────────────────────────────┼───────────────────────────────┼────────────────┼──────────────────────┼────────┤
       │XmNborderWidth                │ XmCBorderWidth                │ Dimension      │ 1                    │ CSG    │
       ├──────────────────────────────┼───────────────────────────────┼────────────────┼──────────────────────┼────────┤
       │XmNcolormap                   │ XmCColormap                   │ Colormap       │ dynamic              │ CG     │
       ├──────────────────────────────┼───────────────────────────────┼────────────────┼──────────────────────┼────────┤
       │XmNdepth                      │ XmCDepth                      │ int            │ dynamic              │ CG     │
       ├──────────────────────────────┼───────────────────────────────┼────────────────┼──────────────────────┼────────┤
       │XmNdestroyCallback            │ XmCCallback                   │ XtCallbackList │ NULL                 │ C      │
       ├──────────────────────────────┼───────────────────────────────┼────────────────┼──────────────────────┼────────┤
       │XmNheight                     │ XmCHeight                     │ Dimension      │ dynamic              │ CSG    │
       ├──────────────────────────────┼───────────────────────────────┼────────────────┼──────────────────────┼────────┤
       │XmNinitialResourcesPersistent │ XmCInitialResourcesPersistent │ Boolean        │ True                 │ C      │
       ├──────────────────────────────┼───────────────────────────────┼────────────────┼──────────────────────┼────────┤
       │XmNmappedWhenManaged          │ XmCMappedWhenManaged          │ Boolean        │ True                 │ CSG    │
       ├──────────────────────────────┼───────────────────────────────┼────────────────┼──────────────────────┼────────┤
       │XmNscreen                     │ XmCScreen                     │ Screen *       │ dynamic              │ CG     │
       ├──────────────────────────────┼───────────────────────────────┼────────────────┼──────────────────────┼────────┤
       │XmNsensitive                  │ XmCSensitive                  │ Boolean        │ True                 │ CSG    │
       ├──────────────────────────────┼───────────────────────────────┼────────────────┼──────────────────────┼────────┤
       │XmNtranslations               │ XmCTranslations               │ XtTranslations │ dynamic              │ CSG    │
       ├──────────────────────────────┼───────────────────────────────┼────────────────┼──────────────────────┼────────┤
       │XmNwidth                      │ XmCWidth                      │ Dimension      │ dynamic              │ CSG    │
       ├──────────────────────────────┼───────────────────────────────┼────────────────┼──────────────────────┼────────┤
       │XmNx                          │ XmCPosition                   │ Position       │ 0                    │ CSG    │
       ├──────────────────────────────┼───────────────────────────────┼────────────────┼──────────────────────┼────────┤
       │XmNy                          │ XmCPosition                   │ Position       │ 0                    │ CSG    │
       ├──────────────────────────────┼───────────────────────────────┼────────────────┼──────────────────────┼────────┤
       └──────────────────────────────┴───────────────────────────────┴────────────────┴──────────────────────┴────────┘
   Translations
       There are no translations for Composite.

RELATED
       Core(3).



                                                       Composite(library call)
