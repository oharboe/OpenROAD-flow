export DESIGN_NAME ?= SPECIFY_DESIGN_NAME
export PLATFORM    = nangate45

export VERILOG_FILES ?= ./designs/src/harness/*.v
export SDC_FILE      = ./designs/src/harness/design.sdc

export MERGED_LEF = ./platforms/nangate45/NangateOpenCellLibrary.mod.lef
export LIB_FILES  = ./platforms/nangate45/NangateOpenCellLibrary_typical.lib
export GDS_FILES  = $(wildcard ./platforms/nangate45/gds/*)

# Infer memory with the make mem_map target
GENERATE_MEMORY = 1

# Automatically pick a reasonable area and utilization

# Reduce density from default, 0.30
export PLACE_DENSITY = 0.15

# Core utilization in %
export CORE_UTILIZATION = 10.0
# Core height / core width
export CORE_ASPECT_RATIO = 1.0
# Core margin in um
export CORE_MARGIN = 2.0

# Start with 250MHz for nangate45, relatively conservative
export CLOCK_PERIOD = 4
export CLOCK_PORT   = clock
