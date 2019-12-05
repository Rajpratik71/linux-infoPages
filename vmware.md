VMWARE(1)                                                                                BSD General Commands Manual                                                                                VMWARE(1)

NAME
     vmware — Intel(TM) x86(TM)-compatible virtual machine

SYNOPSIS
     vmware [-s name=value] [-n] [-t] [-x] [-X] [-q] [-v] [-W] [configfile] [-- <X toolkit options> <application loader options>]

COPYRIGHT
     Copyright (C) 1998-2012 VMware, Inc.  All rights reserved.

DESCRIPTION
     The vmware command starts an Intel or AMD X86-compatible or x86-64-compatible virtual machine.  Depending upon your hardware configuration, you can run a number of virtual machines simultaneously.

     This page describes options for starting virtual machines from the command line using vmware.  For more information, see the product documentation, available from the in-product Help menu and the
     VMware Web site at http://www.vmware.com/support.

     You can specify a virtual machine's configuration by setting parameters in a configuration file using the syntax name=value.  Parameters are set one-per-line.  Lines that begin with a number sign (#)
     are comments and are ignored.  To use a configuration file, specify it on the vmware command line.

     You can also change configuration variables on the command line using the -s option with the following syntax:

           name=value

     After a double-dash separator (--), X toolkit options may be passed as arguments, although some of them (in particular size and title) are ignored.  Application loader arguments may also be passed.

OPTIONS
     -s name=value
           Set the configuration variable name to value, overriding other definitions of name.

     -n    Open a new window.

     -t    Open a virtual machine or team in a new tab in an existing window.  Requires that you specify a configuration file on the command line.

     -x    Power on the virtual machine on startup. Equivalent to clicking the Power-On button after the program starts.  Requires that you specify a configuration file on the command line.

     -X    Power on and switch to full screen mode.  Same as -x, but switch to full screen mode after powering on.  Requires that you specify a configuration file on the command line.

     -q    Attempt to exit the virtual machine after powering off.  This is particularly useful when the guest operating system is capable of powering off the virtual machine.  Requires that you specify a
           configuration file on the command line.

     -v    Display the program version and exit without starting a virtual machine.

     -W    Starts a second instance of Workstation in a different X server.

     -- -h, --help
           Displays the help for the application loader.

     -- -l, --libdir
           Sets the library installation directory to load the application from.

ENVIRONMENT VARIABLES
     TMPDIR  Location of temporary files.  Defaults to /tmp.

FILES
     /etc/vmware  Record of where files are installed.
     /etc/vmware/config
                  Configuration default settings for the machine.
     ~/.vmware/config
                  User-specific configuration default settings.
     ~/.vmware/preferences
                  User-specific preferences.
     /etc/vmware  User license.
     /usr/lib/vmware (by default)
                  Library directory, possibly shared by several hosts.

SEE ALSO
     Most of the documentation for VMware products is available in the User's manual for that product, available from the in-product Help menu (run vmware and choose Help Topics or Online Documentation
     from the Help menu) and at http://www.vmware.com/support.

Linux                                                                                          August 27, 2012                                                                                          Linux
VMWARE(4)                                                                                  Kernel Interfaces Manual                                                                                 VMWARE(4)

NAME
       vmware - VMware SVGA video driver

SYNOPSIS
       Section "Device"
         Identifier "devname"
         Driver "vmware"
         ...
       EndSection

DESCRIPTION
       vmware is an Xorg driver for VMware virtual video cards.

MODESETTING, XINERAMA AND RANDR12
       If  the  driver  can connect to the "vmwgfx" kernel module on linux, it will attempt to use kernel modesetting and will then also use RandR12 for multiple output operation instead of Xinerama. The X
       server log or the "xrandr" application can be used to determine whether RandR12 or Xinerama is actually used.

3D ACCELERATION
       If the driver can connect to the "vmwgfx" kernel module on linux, and the Virtual Machine is set up to use 3D acceleration, the driver will try to use Gallium3D XA to accelerate  3D  operations.  It
       will  also  by  default  enable DRI, the Direct Rendering Infrastructure, primarily for accelerated OpenGL.  If 3D acceleration is available, the driver will in addition provide an additional XVideo
       adaptor for textured video. Gallium3D XA,ibxatracker.so" and the accelerated OpenGL driver, "vmwgfx_dri.so" is provided by the mesa distribution.

CONFIGURATION DETAILS
       Please refer to xorg.conf(5) for general configuration details.  This section only covers configuration details specific to this driver.

       The driver auto-detects the version of any virtual VMware SVGA adapter.

       The following driver Options are supported:

       Option "HWCursor" "boolean"
              Enable or disable the HW cursor.  Default: off.

       Option "Xinerama" "boolean"
              Disable or enable Xinerama support. Default: xinerama is enabled if the hardware supports it.

       Option "StaticXinerama" "string"
              Provide a static xinerama geometry that will be active at server startup and will not be overridden at runtime.  The format is  "Width1xHeight1+Xoffset1+Yoffset1;Width2xHeight2+Xoffset2+Yoff‐
              set2" and so on. Negative offsets are not supported. If the driver is using RandR12, this option should be used to place and enable outputs at driver startup time or else when VMware tools is
              not used for that purpose.  Also please see option "GuiLayout".

       Option "GuiLayout" "string"
              A synonym to option "StaticXinerama", since the latter name is somewhat misleading when RandR12 is favoured before Xinerarma.

       Option "AddDefaultMode" "boolean"
              Provide a default mode with a resolution identical to the resolution of the guest before the X server was started. The X server will thus try to start without  changing  resolution.  Default:
              on.

       Option "RenderAccel" "boolean"
              Try  to  accelerate render operations if the operations are reading from previously accelerated contents (3D or video). This option is needed for 3D support. Default: on if 3D acceleration is
              supported. Otherwise off.

       Option "DRI" "boolean"
              Enable the Direct Rendering Infrastructure. Default: on if 3D acceleration is supported and "RenderAccel" is enabled. Otherwise off.

       Option "DirectPresents" "boolean"
              Speed up OpenGL swapbuffers by skipping a copy operation. This provides some OpenGL swapbuffer speedups, but may cause performance degradation and rendering errors when 3D  contents  is  read
              back for mixing with software rendered contents. Default: off.

       Option "HwPresents" "boolean"
              This  is a developer convenience option and should not be used by distros or normal users. When enabled, it copies software rendered contents to a 3D surface before presenting it, so that the
              visible screen is always present on a 3D surface. Default: off.

       Option "RenderCheck" "boolean"
              This is a developer convenience option and should not be used by distros or normal users. When enabled, it tries to use 3D acceleration for all XRender operations  where  3D  acceleration  is
              supported, resulting in a considerable slowdown due to the increased number of readbacks of accelerated contents from host to guest. This option is used to verify that the accelerated Xrender
              paths works correctly with the "rendercheck" application. Default: off.

       SEE ALSO
              Xorg(1), xorg.conf(5), Xserver(1), X(7), xrandr(1)

AUTHORS
       Copyright (c) 1999-2007 VMware, Inc.

X Version 11                                                                               xf86-video-vmware 13.3.0                                                                                 VMWARE(4)
