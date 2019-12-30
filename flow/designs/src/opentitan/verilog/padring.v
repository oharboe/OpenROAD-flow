module padring (
	clk_pad_i,
	rst_pad_ni,
	clk_o,
	rst_no,
	mio_pad_io,
	dio_pad_io,
	mio_out_i,
	mio_oe_i,
	mio_in_o,
	dio_out_i,
	dio_oe_i,
	dio_in_o,
	mio_attr_i,
	dio_attr_i
);
	localparam signed [31:0] padctrl_reg_pkg_NDioPads = 4;
	localparam signed [31:0] padctrl_reg_pkg_NMioPads = 16;
	localparam signed [31:0] padctrl_reg_pkg_AttrDw = 8;
	localparam prim_pkg_ImplGeneric = 0;
	parameter integer Impl = prim_pkg_ImplGeneric;
	input wire clk_pad_i;
	input wire rst_pad_ni;
	output wire clk_o;
	output wire rst_no;
	inout wire [(padctrl_reg_pkg_NMioPads - 1):0] mio_pad_io;
	inout wire [(padctrl_reg_pkg_NDioPads - 1):0] dio_pad_io;
	input [(padctrl_reg_pkg_NMioPads - 1):0] mio_out_i;
	input [(padctrl_reg_pkg_NMioPads - 1):0] mio_oe_i;
	output wire [(padctrl_reg_pkg_NMioPads - 1):0] mio_in_o;
	input [(padctrl_reg_pkg_NDioPads - 1):0] dio_out_i;
	input [(padctrl_reg_pkg_NDioPads - 1):0] dio_oe_i;
	output wire [(padctrl_reg_pkg_NDioPads - 1):0] dio_in_o;
	input [((padctrl_reg_pkg_NMioPads * padctrl_reg_pkg_AttrDw) + -1):0] mio_attr_i;
	input [((padctrl_reg_pkg_NDioPads * padctrl_reg_pkg_AttrDw) + -1):0] dio_attr_i;
	wire clk;
	wire rst_n;
	assign clk = clk_pad_i;
	assign rst_n = rst_pad_ni;
	prim_pad_wrapper #(
		.Impl(Impl),
		.AttrDw(padctrl_reg_pkg_AttrDw)
	) i_clk_pad(
		.inout_io(clk),
		.in_o(clk_o),
		.out_i(1'b0),
		.oe_i(1'b0),
		.attr_i(1'sb0)
	);
	prim_pad_wrapper #(
		.Impl(Impl),
		.AttrDw(padctrl_reg_pkg_AttrDw)
	) i_rst_pad(
		.inout_io(rst_n),
		.in_o(rst_no),
		.out_i(1'b0),
		.oe_i(1'b0),
		.attr_i(1'sb0)
	);
	generate
		genvar gen_mio_pads_k;
		for (gen_mio_pads_k = 0; (gen_mio_pads_k < padctrl_reg_pkg_NMioPads); gen_mio_pads_k = (gen_mio_pads_k + 1)) begin : gen_mio_pads
			prim_pad_wrapper #(
				.Impl(Impl),
				.AttrDw(padctrl_reg_pkg_AttrDw)
			) i_mio_pad(
				.inout_io(mio_pad_io[gen_mio_pads_k]),
				.in_o(mio_in_o[gen_mio_pads_k]),
				.out_i(mio_out_i[gen_mio_pads_k]),
				.oe_i(mio_oe_i[gen_mio_pads_k]),
				.attr_i(mio_attr_i[(0 + (gen_mio_pads_k * padctrl_reg_pkg_AttrDw))+:padctrl_reg_pkg_AttrDw])
			);
		end
	endgenerate
	generate
		genvar gen_dio_pads_k;
		for (gen_dio_pads_k = 0; (gen_dio_pads_k < padctrl_reg_pkg_NDioPads); gen_dio_pads_k = (gen_dio_pads_k + 1)) begin : gen_dio_pads
			prim_pad_wrapper #(
				.Impl(Impl),
				.AttrDw(padctrl_reg_pkg_AttrDw)
			) i_dio_pad(
				.inout_io(dio_pad_io[gen_dio_pads_k]),
				.in_o(dio_in_o[gen_dio_pads_k]),
				.out_i(dio_out_i[gen_dio_pads_k]),
				.oe_i(dio_oe_i[gen_dio_pads_k]),
				.attr_i(dio_attr_i[(0 + (gen_dio_pads_k * padctrl_reg_pkg_AttrDw))+:padctrl_reg_pkg_AttrDw])
			);
		end
	endgenerate
endmodule
