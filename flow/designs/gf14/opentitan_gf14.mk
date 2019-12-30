export DESIGN_NAME = top_earlgrey
export PLATFORM    = gf14

export VERILOG_FILES = ./designs/src/opentitan/top_earlgrey.rvt.nl.v
export SDC_FILE      = ./designs/src/opentitan/top_earlgrey.sdc

export TECH_LEF = ./platforms/gf14/lef/generic_node_tech_lef.lef
export SC_LEF = ./platforms/gf14/lef/generic_node_merged.lef



export LIB_FILES  = $(sort $(wildcard ./platforms/gf14/lib/*.lib))
export GDS_FILES  = $(sort $(wildcard ./platforms/gf14/gds/*.gds2))

# These values must be multiples of placement site

export PLACE_DENSITY=0.4

export DIE_AREA    = 0 0 525 596.8
export CORE_AREA   = 10 12 515 586.2
export CORE_WIDTH  = 505
export CORE_HEIGHT = 584.8

export CLOCK_PERIOD = 10000.000
export CLOCK_PORT   = clk_i

