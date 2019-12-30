module padctrl (
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
	output wire [(((((((7 + (((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW))) + top_pkg_TL_AIW) + top_pkg_TL_DIW) + top_pkg_TL_DW) + top_pkg_TL_DUW) + 2) - 1):0] tl_o;
	output wire [((padctrl_reg_pkg_NMioPads * padctrl_reg_pkg_AttrDw) + -1):0] mio_attr_o;
	output wire [((padctrl_reg_pkg_NDioPads * padctrl_reg_pkg_AttrDw) + -1):0] dio_attr_o;
	localparam ImplGeneric = 0;
	localparam ImplXilinx = 1;
	wire [(padctrl_reg_pkg_AttrDw - 1):0] warl_mask;
	generate
		if ((Impl == ImplGeneric)) begin : gen_generic
			assign warl_mask = sv2v_cast_B1C2D(6'h3F);
		end
		else if ((Impl == ImplXilinx)) begin : gen_xilinx
			assign warl_mask = sv2v_cast_B1C2D(2'h3);
		end
		else begin : gen_failure
			assign warl_mask = 1'sbX;
		end
	endgenerate
	wire [179:0] reg2hw;
	wire [159:0] hw2reg;
	padctrl_reg_top i_reg_top(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.tl_i(tl_i),
		.tl_o(tl_o),
		.reg2hw(reg2hw),
		.hw2reg(hw2reg),
		.devmode_i(1'b1)
	);
	reg [((padctrl_reg_pkg_NDioPads * padctrl_reg_pkg_AttrDw) + -1):0] dio_attr_q;
	reg [((padctrl_reg_pkg_NMioPads * padctrl_reg_pkg_AttrDw) + -1):0] mio_attr_q;
	always @(posedge clk_i or negedge rst_ni) begin : p_regs
		if (!rst_ni) begin
			dio_attr_q <= 1'sb0;
			mio_attr_q <= 1'sb0;
		end
		else begin
			begin : sv2v_autoblock_2
				reg signed [31:0] kk;
				for (kk = 0; (kk < padctrl_reg_pkg_NDioPads); kk = (kk + 1))
					if (reg2hw[((kk * 9) + 144)+:1])
						dio_attr_q[(0 + (kk * padctrl_reg_pkg_AttrDw))+:padctrl_reg_pkg_AttrDw] <= reg2hw[((kk * 9) + 145)+:8];
			end
			begin : sv2v_autoblock_3
				reg signed [31:0] kk;
				for (kk = 0; (kk < padctrl_reg_pkg_NMioPads); kk = (kk + 1))
					if (reg2hw[(kk * 9)+:1])
						mio_attr_q[(0 + (kk * padctrl_reg_pkg_AttrDw))+:padctrl_reg_pkg_AttrDw] <= reg2hw[((kk * 9) + 1)+:8];
			end
		end
	end
	generate
		genvar gen_dio_attr_k;
		for (gen_dio_attr_k = 0; (gen_dio_attr_k < padctrl_reg_pkg_NDioPads); gen_dio_attr_k = (gen_dio_attr_k + 1)) begin : gen_dio_attr
			assign dio_attr_o[(0 + (gen_dio_attr_k * padctrl_reg_pkg_AttrDw))+:padctrl_reg_pkg_AttrDw] = (dio_attr_q[(0 + (gen_dio_attr_k * padctrl_reg_pkg_AttrDw))+:padctrl_reg_pkg_AttrDw] & warl_mask);
			assign hw2reg[((gen_dio_attr_k * 8) + 128)+:8] = (dio_attr_q[(0 + (gen_dio_attr_k * padctrl_reg_pkg_AttrDw))+:padctrl_reg_pkg_AttrDw] & warl_mask);
		end
	endgenerate
	generate
		genvar gen_mio_attr_k;
		for (gen_mio_attr_k = 0; (gen_mio_attr_k < padctrl_reg_pkg_NMioPads); gen_mio_attr_k = (gen_mio_attr_k + 1)) begin : gen_mio_attr
			assign mio_attr_o[(0 + (gen_mio_attr_k * padctrl_reg_pkg_AttrDw))+:padctrl_reg_pkg_AttrDw] = (mio_attr_q[(0 + (gen_mio_attr_k * padctrl_reg_pkg_AttrDw))+:padctrl_reg_pkg_AttrDw] & warl_mask);
			assign hw2reg[(gen_mio_attr_k * 8)+:8] = (mio_attr_q[(0 + (gen_mio_attr_k * padctrl_reg_pkg_AttrDw))+:padctrl_reg_pkg_AttrDw] & warl_mask);
		end
	endgenerate
	function automatic [(padctrl_reg_pkg_AttrDw - 1):0] sv2v_cast_B1C2D;
		input reg [(padctrl_reg_pkg_AttrDw - 1):0] inp;
		sv2v_cast_B1C2D = inp;
	endfunction
endmodule
