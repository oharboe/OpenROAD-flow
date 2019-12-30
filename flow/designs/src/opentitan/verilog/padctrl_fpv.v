module padctrl_fpv (
	clk_i,
	rst_ni,
	clk_o,
	rst_no,
	tl_i,
	tl_o,
	mio_pad_io,
	dio_pad_io,
	mio_out_i,
	mio_oe_i,
	mio_in_o,
	dio_out_i,
	dio_oe_i,
	dio_in_o
);
	localparam signed [31:0] padctrl_reg_pkg_NDioPads = 4;
	localparam signed [31:0] padctrl_reg_pkg_NMioPads = 16;
	localparam signed [31:0] padctrl_reg_pkg_AttrDw = 8;
	localparam prim_pkg_ImplGeneric = 0;
	localparam top_pkg_TL_AW = 32;
	localparam top_pkg_TL_DW = 32;
	localparam top_pkg_TL_AIW = 8;
	localparam top_pkg_TL_DIW = 1;
	localparam top_pkg_TL_DUW = 16;
	localparam top_pkg_TL_DBW = (top_pkg_TL_DW >> 3);
	localparam top_pkg_TL_SZW = $clog2(($clog2((32 >> 3)) + 1));
	parameter integer Impl = prim_pkg_ImplGeneric;
	input wire clk_i;
	input wire rst_ni;
	output wire clk_o;
	output wire rst_no;
	input wire [(((((((7 + (((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW))) + top_pkg_TL_AIW) + top_pkg_TL_AW) + (((top_pkg_TL_DBW - 1) >= 0) ? top_pkg_TL_DBW : (2 - top_pkg_TL_DBW))) + top_pkg_TL_DW) + 17) - 1):0] tl_i;
	output wire [(((((((7 + (((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW))) + top_pkg_TL_AIW) + top_pkg_TL_DIW) + top_pkg_TL_DW) + top_pkg_TL_DUW) + 2) - 1):0] tl_o;
	inout wire [(padctrl_reg_pkg_NMioPads - 1):0] mio_pad_io;
	inout wire [(padctrl_reg_pkg_NDioPads - 1):0] dio_pad_io;
	input [(padctrl_reg_pkg_NMioPads - 1):0] mio_out_i;
	input [(padctrl_reg_pkg_NMioPads - 1):0] mio_oe_i;
	output wire [(padctrl_reg_pkg_NMioPads - 1):0] mio_in_o;
	input [(padctrl_reg_pkg_NDioPads - 1):0] dio_out_i;
	input [(padctrl_reg_pkg_NDioPads - 1):0] dio_oe_i;
	output wire [(padctrl_reg_pkg_NDioPads - 1):0] dio_in_o;
	wire [((padctrl_reg_pkg_NMioPads * padctrl_reg_pkg_AttrDw) + -1):0] mio_attr;
	wire [((padctrl_reg_pkg_NDioPads * padctrl_reg_pkg_AttrDw) + -1):0] dio_attr;
	padctrl #(.Impl(Impl)) i_padctrl(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.tl_i(tl_i),
		.tl_o(tl_o),
		.mio_attr_o(mio_attr),
		.dio_attr_o(dio_attr)
	);
	padring #(.Impl(Impl)) i_padring(
		.clk_pad_i(clk_i),
		.rst_pad_ni(rst_ni),
		.clk_o(clk_o),
		.rst_no(rst_no),
		.mio_pad_io(mio_pad_io),
		.dio_pad_io(dio_pad_io),
		.mio_out_i(mio_out_i),
		.mio_oe_i(mio_oe_i),
		.mio_in_o(mio_in_o),
		.dio_out_i(dio_out_i),
		.dio_oe_i(dio_oe_i),
		.dio_in_o(dio_in_o),
		.mio_attr_i(mio_attr),
		.dio_attr_i(dio_attr)
	);
endmodule
