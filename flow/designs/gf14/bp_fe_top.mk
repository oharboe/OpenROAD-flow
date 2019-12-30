export DESIGN_NAME = bp_fe_top
export PLATFORM    = gf14

export VERILOG_FILES = ./designs/src/bp_fe_top/pickled.v \
                       ./designs/src/bp_fe_top/gf14_macros.v
export SDC_FILE      = ./designs/src/bp_fe_top/design.sdc


export TECH_LEF = ./platforms/gf14/lef/generic_node_tech_lef.lef
export SC_LEF = ./platforms/gf14/lef/generic_node_merged.lef
# export ADDITIONAL_LEFS = ./platforms/tsmc65lp/tsmc65lp_1rf_lg6_w8_bit.lef \
#                          ./platforms/tsmc65lp/tsmc65lp_1rf_lg6_w96_bit.lef \
#                          ./platforms/tsmc65lp/tsmc65lp_1rf_lg9_w64_bit.lef \
#                          ./platforms/tsmc65lp/tsmc65lp_1rf_lg9_w64_all.lef
# export ADDITIONAL_LIBS = ./platforms/tsmc65lp/lib/tsmc65lp_1rf_lg6_w8_bit_ss_1p08v_1p08v_125c.lib \
#                          ./platforms/tsmc65lp/lib/tsmc65lp_1rf_lg6_w96_bit_ss_1p08v_1p08v_125c.lib \
#                          ./platforms/tsmc65lp/lib/tsmc65lp_1rf_lg9_w64_bit_ss_1p08v_1p08v_125c.lib \
#                          ./platforms/tsmc65lp/lib/tsmc65lp_1rf_lg9_w64_all_ss_1p08v_1p08v_125c.lib
# export ADDITIONAL_GDS  = ./platforms/tsmc65lp/gds/tsmc65lp_1rf_lg6_w8_bit.gds2 \
#                          ./platforms/tsmc65lp/gds/tsmc65lp_1rf_lg6_w96_bit.gds2 \
#                          ./platforms/tsmc65lp/gds/tsmc65lp_1rf_lg9_w64_bit.gds2 \
                         # ./platforms/tsmc65lp/gds/tsmc65lp_1rf_lg9_w64_all.gds2

export LIB_FILES  = $(sort $(wildcard ./platforms/gf14/lib/*.lib))
export GDS_FILES  = $(sort $(wildcard ./platforms/gf14/gds/*.gds2))
export RUN_MACRO_PLACEMENT = 1

# These values must be multiples of placement site
export DIE_AREA    = 0 0 1200 1000.8
export CORE_AREA   = 10 12 1190 991.2
export CORE_WIDTH  = 1180
export CORE_HEIGHT = 979.2

export CLOCK_PERIOD = 5.600
export CLOCK_PORT   = clk_i

