module usbuart (
	clk_i,
	clk_48mhz_i,
	rst_ni,
	tl_i,
	tl_o,
	cio_usb_dp_i,
	cio_usb_dp_o,
	cio_usb_dp_en_o,
	cio_usb_dn_i,
	cio_usb_dn_o,
	cio_usb_dn_en_o,
	cio_usb_sense_i,
	cio_pullup_o,
	cio_pullup_en_o,
	intr_tx_watermark_o,
	intr_rx_watermark_o,
	intr_tx_overflow_o,
	intr_rx_overflow_o,
	intr_rx_frame_err_o,
	intr_rx_break_err_o,
	intr_rx_timeout_o,
	intr_rx_parity_err_o
);
	localparam top_pkg_TL_AW = 32;
	localparam top_pkg_TL_DW = 32;
	localparam top_pkg_TL_AIW = 8;
	localparam top_pkg_TL_DIW = 1;
	localparam top_pkg_TL_DUW = 16;
	localparam top_pkg_TL_DBW = (top_pkg_TL_DW >> 3);
	localparam top_pkg_TL_SZW = $clog2(($clog2((32 >> 3)) + 1));
	input clk_i;
	input clk_48mhz_i;
	input rst_ni;
	input wire [(((((((7 + (((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW))) + top_pkg_TL_AIW) + top_pkg_TL_AW) + (((top_pkg_TL_DBW - 1) >= 0) ? top_pkg_TL_DBW : (2 - top_pkg_TL_DBW))) + top_pkg_TL_DW) + 17) - 1):0] tl_i;
	output wire [(((((((7 + (((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW))) + top_pkg_TL_AIW) + top_pkg_TL_DIW) + top_pkg_TL_DW) + top_pkg_TL_DUW) + 2) - 1):0] tl_o;
	input cio_usb_dp_i;
	output wire cio_usb_dp_o;
	output wire cio_usb_dp_en_o;
	input cio_usb_dn_i;
	output wire cio_usb_dn_o;
	output wire cio_usb_dn_en_o;
	input cio_usb_sense_i;
	output wire cio_pullup_o;
	output wire cio_pullup_en_o;
	output wire intr_tx_watermark_o;
	output wire intr_rx_watermark_o;
	output wire intr_tx_overflow_o;
	output wire intr_rx_overflow_o;
	output wire intr_rx_frame_err_o;
	output wire intr_rx_break_err_o;
	output wire intr_rx_timeout_o;
	output wire intr_rx_parity_err_o;
	parameter USBUART_INTR_STATE_OFFSET = 6'h 0;
	parameter USBUART_INTR_ENABLE_OFFSET = 6'h 4;
	parameter USBUART_INTR_TEST_OFFSET = 6'h 8;
	parameter USBUART_CTRL_OFFSET = 6'h c;
	parameter USBUART_STATUS_OFFSET = 6'h 10;
	parameter USBUART_RDATA_OFFSET = 6'h 14;
	parameter USBUART_WDATA_OFFSET = 6'h 18;
	parameter USBUART_FIFO_CTRL_OFFSET = 6'h 1c;
	parameter USBUART_FIFO_STATUS_OFFSET = 6'h 20;
	parameter USBUART_OVRD_OFFSET = 6'h 24;
	parameter USBUART_VAL_OFFSET = 6'h 28;
	parameter USBUART_TIMEOUT_CTRL_OFFSET = 6'h 2c;
	parameter USBUART_USBSTAT_OFFSET = 6'h 30;
	parameter USBUART_USBPARAM_OFFSET = 6'h 34;
	localparam [55:0] USBUART_PERMIT = {4'b 0001, 4'b 0001, 4'b 0001, 4'b 1111, 4'b 0001, 4'b 0001, 4'b 0001, 4'b 0001, 4'b 0111, 4'b 0001, 4'b 0011, 4'b 1111, 4'b 0111, 4'b 0111};
	localparam USBUART_INTR_STATE = 0;
	localparam USBUART_INTR_ENABLE = 1;
	localparam USBUART_VAL = 10;
	localparam USBUART_TIMEOUT_CTRL = 11;
	localparam USBUART_USBSTAT = 12;
	localparam USBUART_USBPARAM = 13;
	localparam USBUART_INTR_TEST = 2;
	localparam USBUART_CTRL = 3;
	localparam USBUART_STATUS = 4;
	localparam USBUART_RDATA = 5;
	localparam USBUART_WDATA = 6;
	localparam USBUART_FIFO_CTRL = 7;
	localparam USBUART_FIFO_STATUS = 8;
	localparam USBUART_OVRD = 9;
	wire [112:0] reg2hw;
	wire [106:0] hw2reg;
	usbuart_reg_top u_reg(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.tl_i(tl_i),
		.tl_o(tl_o),
		.reg2hw(reg2hw),
		.hw2reg(hw2reg),
		.devmode_i(1'b1)
	);
	wire usb_tx_en_o;
	assign cio_usb_dp_en_o = usb_tx_en_o;
	assign cio_usb_dn_en_o = usb_tx_en_o;
	assign cio_pullup_en_o = 1;
	usbuart_core usbuart_core(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.reg2hw(reg2hw),
		.hw2reg(hw2reg),
		.clk_usb_48mhz_i(clk_48mhz_i),
		.usb_dp_i(cio_usb_dp_i),
		.usb_dp_o(cio_usb_dp_o),
		.usb_dn_i(cio_usb_dn_i),
		.usb_dn_o(cio_usb_dn_o),
		.usb_tx_en_o(usb_tx_en_o),
		.usb_sense_i(cio_usb_sense_i),
		.usb_pullup_o(cio_pullup_o),
		.intr_tx_watermark_o(intr_tx_watermark_o),
		.intr_rx_watermark_o(intr_rx_watermark_o),
		.intr_tx_overflow_o(intr_tx_overflow_o),
		.intr_rx_overflow_o(intr_rx_overflow_o),
		.intr_rx_frame_err_o(intr_rx_frame_err_o),
		.intr_rx_break_err_o(intr_rx_break_err_o),
		.intr_rx_timeout_o(intr_rx_timeout_o),
		.intr_rx_parity_err_o(intr_rx_parity_err_o)
	);
endmodule
