File: macchanger.info,  Node: Top,  Next: Overview,  Up: (dir)

Stress
******

This manual documents MacChanger version 1.7.0, a utility for
viewing/manipulating the MAC address of network interfaces.

* Menu:

* Overview::                    Overview of 'macchanger'.
* Features::
* Invoking macchanger::         How to run 'macchanger'.
* Examples::                    Some example invocations.

File: macchanger.info,  Node: Overview,  Next: Features,  Prev: Top,  Up: Top

1 Overview of 'macchanger'
**************************

The GNU 'macchanger' utility helps to view and manipulate the MAC
address of network interfaces.

File: macchanger.info,  Node: Features,  Next: Invoking macchanger,  Prev: Overview,  Up: Top

2 Features
**********

   * Set specific MAC address of a network interface
   * Set the MAC randomly
   * Set a MAC of another vendor
   * Set another MAC of the same vendor
   * Set a MAC of the same kind (eg: wireless card)
   * Reset MAC address to its original, permanent hardware value
   * Display a vendor MAC list (more than 17000 items) to choose from

File: macchanger.info,  Node: Invoking macchanger,  Next: Examples,  Prev: Features,  Up: Top

3 Invoking macchanger
*********************

The program accepts the following options.

'-h'
'--help'
     Print a usage message briefly summarizing these command-line
     options and the bug-reporting address, then exit.

'-V'
'--version'
     Print the version number of 'macchanger' to the standard output
     stream.  This version number should be included in all bug reports.

'-s'
'--show'
     Print the current MAC address and exit.  This is the default action
     when no other option is specified.

'-e'
'--ending'
     Change the MAC address setting the same hardware vendor as the
     current.

'-a'
'--another'
     Change the MAC address setting a random vendor MAC of the same
     kind.  For example, if it's a wireless card, 'macchanger' will set
     another wireless MAC address.

'-A'
     Change the MAC address setting a random vendor MAC of any kind.

'-r'
'--random'
     Set fully random MAC address: Any kind and any vendor.

'-p'
'--permanent'
     Reset MAC address to its original, permanent hardware value.

'-l'
'--list[=KEYWORD]'
     Print known vendors.  If a key is spefified, 'macchanger' will
     print only vendor that matches the string.

'-b'
'--bia'
     When setting fully random MAC pretend to be a burned-in-address.
     If not used, the MAC will have the locally-administered bit set.

'-m'
'--mac=XX:XX:XX:XX:XX:XX'
     Set a specific MAC address.  Each XX must be an hexadecial value
     (00 to FF).

File: macchanger.info,  Node: Examples,  Prev: Invoking macchanger,  Up: Top

4 Example invocations
*********************

The simple case is that you just want change the hardware address of the
first ethernet network interface for a fully random one:

   # 'macchanger -r eth0'

   Long options are supported.  The following change the MAC address for
another one of the same kind (for example, wireless):

   # 'macchanger -a wifi0'

   To execute this examples, the interface must be down, otherwise
'macchanger' will be exit with an error message.


