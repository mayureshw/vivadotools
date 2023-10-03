# vivadotools

CLI interface for various flows in Vivado software 

This is a work in progress to build a CLI interface around Vivado software for FPGA development.

# System requirements

- Xilinx Vivado. The version used for development is 2022.2. It may possibly work on other versions.

- Unix like system, GNU make

- Might work with Cygwin on Windows. But it has not been tested.

# Installation

- Install Quartus Prime with ModelSim. Make sure that your PATH environment variable has 'bin' directories of both Quartus and ModelSim. For example, if your installation is in /opt, you may want to add something like following to your shell's rc file:

    - export PATH=/opt/intelFPGA_lite/20.1/quartus/bin:/opt/intelFPGA_lite/20.1/modelsim_ase/bin:$PATH

- Some quirks with Quartus that require manual intervention to the installation:

    - The Quartus installation is not required to be in the same login where you do your development. Typically it may be installed as root. Just ensure that appropriate permissions are set. Unfortunately executables under modelsim_ase/bin have strange permissions when you install Quartus i.e. they are not executable by 'other'. You may have to correct them manually (or change the owner of those files).

    - For ModelSim to work you may need to install package libxft2:i386 manually.

- Check out quartools package in a suitable directory. Again, it is not required to be in the same login where you normally work. It's better to keep it under at least a different path from your work directories. Set the environment variable VIVADOTOOLSDIR pointing to the root directory of the package. For example, if the package was cloned in $HOME/programs, you may want to add something like following to your shell's rc file:

    - export VIVADOTOOLSDIR=$HOME/programs/quartools

# Usage

1. Behavioral simulation using ModelSim

    See examples/bsimu.

    For your own programs, just set the SRCS and TOP variables in the Makefile. Both vhdl and verilog sources may be used together in one project and need to be specified in the same variable. vhdl sources must have .vhd or .vhdl extension and verilog sources must have .v extension.

    Run 'make bsimu' to run the simulation

    Use 'gtkwave dump.vcd' to view the waveforms.

1. Only analyze the code

    Run 'make analyze'

1. Launching modelsim simulator automatically

    In the Makefile set the following if you would like the simulator UI to come up automatically. If you have written a test bench, it would directly show you the waveforms of all the signals.

    LAUNCHSIM = Y

    IF you do not add this line, the UI will not be launched. In that case, you should typically have some report statements to get your messages on the console.

1. Compilation

    'make compile' would run the Quartus' 'compile' flow on the TOP module. Rest of the specification is similar to bsimu. Different frameworks may have different notions of the term 'compile' in HDLs. This flow runs the flow literally named as compile in Quartus parlance, using Quartus shell interface.

1. Clean the work area

    Use 'make clean' to get rid of the work area to reclaim space. You may also like to do this if you have renamed or removed your sources that you may have already compiled, to expunge the compiled modules with old name from the work area.

# Utilities

    To run the utility commands described here add $VIVADOTOOLSDIR/bin to your PATH environment variable.

    Utility commands can be run as 'vivsh <utility>' where utility is one of the following:

1. listips

    Lists the ips available with your installation

# Wish list

- More flows and configurable options to be added over time - typically in the form of more targets to the makefile. General structure of usage of the package is likely to remain same.

