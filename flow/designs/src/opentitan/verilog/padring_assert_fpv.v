module padring_assert_fpv (
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
	input clk_pad_i;
	input rst_pad_ni;
	input clk_o;
	input rst_no;
	input [(padctrl_reg_pkg_NMioPads - 1):0] mio_pad_io;
	input [(padctrl_reg_pkg_NDioPads - 1):0] dio_pad_io;
	input [(padctrl_reg_pkg_NMioPads - 1):0] mio_out_i;
	input [(padctrl_reg_pkg_NMioPads - 1):0] mio_oe_i;
	input [(padctrl_reg_pkg_NMioPads - 1):0] mio_in_o;
	input [(padctrl_reg_pkg_NDioPads - 1):0] dio_out_i;
	input [(padctrl_reg_pkg_NDioPads - 1):0] dio_oe_i;
	input [(padctrl_reg_pkg_NDioPads - 1):0] dio_in_o;
	input [((padctrl_reg_pkg_NMioPads * padctrl_reg_pkg_AttrDw) + -1):0] mio_attr_i;
	input [((padctrl_reg_pkg_NDioPads * padctrl_reg_pkg_AttrDw) + -1):0] dio_attr_i;
	wire [31:0] mio_sel;
	wire [31:0] dio_sel;
	wire mio_output_value;
	assign mio_output_value = (mio_out_i[mio_sel] ^ mio_attr_i[((mio_sel * padctrl_reg_pkg_AttrDw) + 0)]);
	wire dio_output_value;
	assign dio_output_value = (dio_out_i[dio_sel] ^ dio_attr_i[((dio_sel * padctrl_reg_pkg_AttrDw) + 0)]);
endmodule
