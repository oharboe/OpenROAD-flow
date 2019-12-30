###################################################################

# Created by write_sdc on Mon Dec 9 09:08:23 2019

###################################################################
set sdc_version 2.1

set_units -time ns -resistance kOhm -capacitance pF -voltage V -current mA
create_clock [get_ports clk_i]  -name mainClock  -period 10000  -waveform {0 5000}
