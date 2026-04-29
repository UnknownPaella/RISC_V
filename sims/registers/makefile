# Makefile

# defaults
SIM ?= icarus
TOPLEVEL_LANG ?= verilog


VERILOG_SOURCES += ../../srcs/registers/registers.sv
VERILOG_SOURCES += ../../srcs/registers/register.sv
# use VHDL_SOURCES for VHDL files

# COCOTB_TOPLEVEL is the name of the toplevel module in your Verilog or VHDL file
COCOTB_TOPLEVEL = registers

# COCOTB_TEST_MODULES is the basename of the Python test file(s)
COCOTB_TEST_MODULES = tb_registers

# include cocotb's make rules to take care of the simulator setup
include $(shell cocotb-config --makefiles)/Makefile.sim