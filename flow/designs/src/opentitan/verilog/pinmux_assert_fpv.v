module pinmux_assert_fpv (
	clk_i,
	rst_ni,
	tl_i,
	tl_o,
	periph_to_mio_i,
	periph_to_mio_oe_i,
	mio_to_periph_o,
	mio_out_o,
	mio_oe_o,
	mio_in_i,
	periph_sel_i,
	mio_sel_i
);
	localparam signed [31:0] pinmux_reg_pkg_NPeriphIn = 32;
	localparam signed [31:0] pinmux_reg_pkg_NPeriphOut = 32;
	localparam signed [31:0] pinmux_reg_pkg_NMioPads = 32;
	localparam top_pkg_TL_AW = 32;
	localparam top_pkg_TL_DW = 32;
	localparam top_pkg_TL_AIW = 8;
	localparam top_pkg_TL_DIW = 1;
	localparam top_pkg_TL_DUW = 16;
	localparam top_pkg_TL_DBW = (top_pkg_TL_DW >> 3);
	localparam top_pkg_TL_SZW = $clog2(($clog2((32 >> 3)) + 1));
	input clk_i;
	input rst_ni;
	input wire [(((((((7 + (((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW))) + top_pkg_TL_AIW) + top_pkg_TL_AW) + (((top_pkg_TL_DBW - 1) >= 0) ? top_pkg_TL_DBW : (2 - top_pkg_TL_DBW))) + top_pkg_TL_DW) + 17) - 1):0] tl_i;
	input wire [(((((((7 + (((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW))) + top_pkg_TL_AIW) + top_pkg_TL_DIW) + top_pkg_TL_DW) + top_pkg_TL_DUW) + 2) - 1):0] tl_o;
	input [(pinmux_reg_pkg_NPeriphOut - 1):0] periph_to_mio_i;
	input [(pinmux_reg_pkg_NPeriphOut - 1):0] periph_to_mio_oe_i;
	input [(pinmux_reg_pkg_NPeriphIn - 1):0] mio_to_periph_o;
	input [(pinmux_reg_pkg_NMioPads - 1):0] mio_out_o;
	input [(pinmux_reg_pkg_NMioPads - 1):0] mio_oe_o;
	input [(pinmux_reg_pkg_NMioPads - 1):0] mio_in_i;
	input [(5 - 1):0] periph_sel_i;
	input [(5 - 1):0] mio_sel_i;
	wire [5:0] periph_insel;
	assign periph_insel = pinmux.reg2hw.periph_insel[periph_sel_i];
	wire [5:0] mio_outsel;
	assign mio_outsel = pinmux.reg2hw.mio_outsel[mio_sel_i];
endmodule
