module padctrl_assert_fpv (
	clk_i,
	rst_ni,
	tl_i,
	tl_o,
	mio_attr_o,
	dio_attr_o
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
	input clk_i;
	input rst_ni;
	input wire [(((((((7 + (((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW))) + top_pkg_TL_AIW) + top_pkg_TL_AW) + (((top_pkg_TL_DBW - 1) >= 0) ? top_pkg_TL_DBW : (2 - top_pkg_TL_DBW))) + top_pkg_TL_DW) + 17) - 1):0] tl_i;
	input wire [(((((((7 + (((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW))) + top_pkg_TL_AIW) + top_pkg_TL_DIW) + top_pkg_TL_DW) + top_pkg_TL_DUW) + 2) - 1):0] tl_o;
	input wire [((padctrl_reg_pkg_NMioPads * padctrl_reg_pkg_AttrDw) + -1):0] mio_attr_o;
	input wire [((padctrl_reg_pkg_NDioPads * padctrl_reg_pkg_AttrDw) + -1):0] dio_attr_o;
	localparam ImplGeneric = 0;
	localparam ImplXilinx = 1;
	wire [31:0] mio_sel;
	wire [31:0] dio_sel;
	generate
		if ((Impl == ImplGeneric)) ;
		else if ((Impl == ImplXilinx)) ;
	endgenerate
	generate
		if ((Impl == ImplGeneric)) ;
		else if ((Impl == ImplXilinx)) ;
	endgenerate
endmodule
