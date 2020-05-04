export DESIGN_NICKNAME = aes
export DESIGN_NAME = aes_cipher_top
export PLATFORM    = gf14

export VERILOG_FILES = $(wildcard ./designs/src/aes/*.v)
export SDC_FILE      = ./designs/src/aes/aes_cipher_top.gf14.sdc

# These values must be multiples of placement site
export DIE_AREA    = 0 0 620 520.8
export CORE_AREA   = 10 12 610 511.2

