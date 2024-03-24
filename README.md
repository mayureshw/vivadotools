# vivadotools

CLI interface for various flows in Vivado software 

This is a work in progress to build a CLI interface around Vivado software for FPGA development.

# System requirements

- Xilinx Vivado. The version used for development is 2022.2. It may possibly work on other versions.

- Unix like system, GNU make

- Might work with Cygwin on Windows. But it has not been tested.

# Installation


Clone this repository and set following environment variables

    - Set VIVADOTOOLSDIR to point to the directory you checked out from it
    - E.g. export VIVADOTOOLSDIR=$HOME/programs/vivadotools
    - Add $VIVADOTOOLSDIR/bin to your PATH
    - E.g. export PATH=$PATH:$VIVADOTOOLSDIR/bin

# Usage

Write your project Makefile and include $(VIVADOTOOLSDIR)/Makefile.vivadotools in it.

Refer documentation in Makefile.vivadotools to see which variables need to be defined.

# Utilities (other than those integrated with Makefile.vivadotools)

To run the utility commands described here add $VIVADOTOOLSDIR/bin to your PATH environment variable.

Utility commands can be run as 'vivsh <utility>' where utility is one of the following:

1. iplist

    Lists the ips available with your installation

1. iphelp <ip vlnv>

    Prints help about the properties of ip identified by vlnv string (use iplist to see vlnv strings). The help includes the configurable properties and supported targets of the ip.

1. ipgen <ip vlnv> <target> <modulename> [ { param val } ... ]

    Generates a given target such as testbench, examples, simulation, synthesis etc as supported by the IP with given modulename for a given ip vlnv. To know supported targets of IPs use iphelp. Configurable parameters of IPs are a space separated list of parameter and its value (e.g. CONFIG.Operation_Type Divide). See iphelp for a list of configurable parameters with default values. Refer to the IP documentation for domain of parameter values.

    For using the ips, use the xci file generated into your SRCS variable in your Makefile. Do not move the xci file as Vivado seems fussy about its location

    For options available for each parameter, check the <ip>.xml in respective ip directory (see choice_list).

1. ipxci2dcp <xci file>

    Generates a .dcp file for the ip which can be used by dcp2vhdl to generate vhdl. Such vhdl can be used only for simulation. See ipgen for generation of configured IP in the form of xci file.

1. ipdcp2vhdl <dcp file>

    Generates a <ipname>.vhdl file from a given dcp file produced by ipxci2dcp.

1. xcidiff.sh <xcfile1> <xcifile2>

    Runs sdiff -s to highlight differencesa between configurable parameter valuesa of two xci files

1. xcicat.sh <xcifile>

    Dumps component parameters and values of a configured ip (xci file) in sorted order. Supports both xml and json forms. This is typically useful for comparing two ip configurations.

# Wish list

- More flows and configurable options to be added over time - typically in the form of more targets to the makefile. General structure of usage of the package is likely to remain same.

