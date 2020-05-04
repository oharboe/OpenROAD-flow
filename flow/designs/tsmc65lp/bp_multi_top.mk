export DESIGN_NICKNAME = bp_multi
export DESIGN_NAME = bp_multi_top
export PLATFORM    = tsmc65lp

export VERILOG_FILES = ./designs/src/bp_multi_top/pickled.v \
                       ./designs/src/bp_multi_top/tsmc65lp_macros.v
export SDC_FILE      = ./designs/src/bp_multi_top/design.sdc

export ADDITIONAL_LEFS = ./platforms/tsmc65lp/lef/tsmc65lp_1rf_lg6_w16_bit.lef \
                         ./platforms/tsmc65lp/lef/tsmc65lp_1rf_lg6_w8_bit.lef \
                         ./platforms/tsmc65lp/lef/tsmc65lp_1rf_lg6_w96_bit.lef \
                         ./platforms/tsmc65lp/lef/tsmc65lp_1rf_lg9_w64_bit.lef \
                         ./platforms/tsmc65lp/lef/tsmc65lp_1rf_lg8_w96_all.lef \
                         ./platforms/tsmc65lp/lef/tsmc65lp_1rf_lg9_w64_all.lef \
                         ./platforms/tsmc65lp/lef/tsmc65lp_2rf_lg5_w64_all.lef
export ADDITIONAL_LIBS = ./platforms/tsmc65lp/lib/tsmc65lp_1rf_lg6_w16_bit_ss_1p08v_1p08v_125c.lib \
                         ./platforms/tsmc65lp/lib/tsmc65lp_1rf_lg6_w8_bit_ss_1p08v_1p08v_125c.lib \
                         ./platforms/tsmc65lp/lib/tsmc65lp_1rf_lg6_w96_bit_ss_1p08v_1p08v_125c.lib \
                         ./platforms/tsmc65lp/lib/tsmc65lp_1rf_lg9_w64_bit_ss_1p08v_1p08v_125c.lib \
                         ./platforms/tsmc65lp/lib/tsmc65lp_1rf_lg8_w96_all_ss_1p08v_1p08v_125c.lib \
                         ./platforms/tsmc65lp/lib/tsmc65lp_1rf_lg9_w64_all_ss_1p08v_1p08v_125c.lib \
                         ./platforms/tsmc65lp/lib/tsmc65lp_2rf_lg5_w64_all_ss_1p08v_1p08v_125c.lib
export ADDITIONAL_GDS  = ./platforms/tsmc65lp/gds/tsmc65lp_1rf_lg6_w16_bit.gds2 \
                         ./platforms/tsmc65lp/gds/tsmc65lp_1rf_lg6_w8_bit.gds2 \
                         ./platforms/tsmc65lp/gds/tsmc65lp_1rf_lg6_w96_bit.gds2 \
                         ./platforms/tsmc65lp/gds/tsmc65lp_1rf_lg9_w64_bit.gds2 \
                         ./platforms/tsmc65lp/gds/tsmc65lp_1rf_lg8_w96_all.gds2 \
                         ./platforms/tsmc65lp/gds/tsmc65lp_1rf_lg9_w64_all.gds2 \
                         ./platforms/tsmc65lp/gds/tsmc65lp_2rf_lg5_w64_all.gds2


# These values must be multiples of placement site
export DIE_AREA    = 0 0 2200 2000.8
export CORE_AREA   = 10 12 2190 1991.2

