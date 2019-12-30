module padctrl_reg_top (
	clk_i,
	rst_ni,
	tl_i,
	tl_o,
	reg2hw,
	hw2reg,
	devmode_i
);
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
	output wire [(((((((7 + (((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW))) + top_pkg_TL_AIW) + top_pkg_TL_DIW) + top_pkg_TL_DW) + top_pkg_TL_DUW) + 2) - 1):0] tl_o;
	output wire [179:0] reg2hw;
	input wire [159:0] hw2reg;
	input devmode_i;
	localparam signed [31:0] NDioPads = 4;
	localparam signed [31:0] NMioPads = 16;
	localparam signed [31:0] AttrDw = 8;
	parameter PADCTRL_REGEN_OFFSET = 5'h 0;
	parameter PADCTRL_DIO_PADS_OFFSET = 5'h 4;
	parameter PADCTRL_MIO_PADS0_OFFSET = 5'h 8;
	parameter PADCTRL_MIO_PADS1_OFFSET = 5'h c;
	parameter PADCTRL_MIO_PADS2_OFFSET = 5'h 10;
	parameter PADCTRL_MIO_PADS3_OFFSET = 5'h 14;
	localparam [23:0] PADCTRL_PERMIT = {4'b 0001, 4'b 1111, 4'b 1111, 4'b 1111, 4'b 1111, 4'b 1111};
	localparam PADCTRL_REGEN = 0;
	localparam PADCTRL_DIO_PADS = 1;
	localparam PADCTRL_MIO_PADS0 = 2;
	localparam PADCTRL_MIO_PADS1 = 3;
	localparam PADCTRL_MIO_PADS2 = 4;
	localparam PADCTRL_MIO_PADS3 = 5;
	localparam AW = 5;
	localparam DW = 32;
	localparam DBW = (DW / 8);
	wire reg_we;
	wire reg_re;
	wire [(AW - 1):0] reg_addr;
	wire [(DW - 1):0] reg_wdata;
	wire [(DBW - 1):0] reg_be;
	wire [(DW - 1):0] reg_rdata;
	wire reg_error;
	wire addrmiss;
	reg wr_err;
	reg [(DW - 1):0] reg_rdata_next;
	wire [(((((((7 + (((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW))) + top_pkg_TL_AIW) + top_pkg_TL_AW) + (((top_pkg_TL_DBW - 1) >= 0) ? top_pkg_TL_DBW : (2 - top_pkg_TL_DBW))) + top_pkg_TL_DW) + 17) - 1):0] tl_reg_h2d;
	wire [(((((((7 + (((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW))) + top_pkg_TL_AIW) + top_pkg_TL_DIW) + top_pkg_TL_DW) + top_pkg_TL_DUW) + 2) - 1):0] tl_reg_d2h;
	assign tl_reg_h2d = tl_i;
	assign tl_o = tl_reg_d2h;
	tlul_adapter_reg #(
		.RegAw(AW),
		.RegDw(DW)
	) u_reg_if(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.tl_i(tl_reg_h2d),
		.tl_o(tl_reg_d2h),
		.we_o(reg_we),
		.re_o(reg_re),
		.addr_o(reg_addr),
		.wdata_o(reg_wdata),
		.be_o(reg_be),
		.rdata_i(reg_rdata),
		.error_i(reg_error)
	);
	assign reg_rdata = reg_rdata_next;
	assign reg_error = ((devmode_i & addrmiss) | wr_err);
	wire regen_qs;
	wire regen_wd;
	wire regen_we;
	wire [7:0] dio_pads_attr0_qs;
	wire [7:0] dio_pads_attr0_wd;
	wire dio_pads_attr0_we;
	wire dio_pads_attr0_re;
	wire [7:0] dio_pads_attr1_qs;
	wire [7:0] dio_pads_attr1_wd;
	wire dio_pads_attr1_we;
	wire dio_pads_attr1_re;
	wire [7:0] dio_pads_attr2_qs;
	wire [7:0] dio_pads_attr2_wd;
	wire dio_pads_attr2_we;
	wire dio_pads_attr2_re;
	wire [7:0] dio_pads_attr3_qs;
	wire [7:0] dio_pads_attr3_wd;
	wire dio_pads_attr3_we;
	wire dio_pads_attr3_re;
	wire [7:0] mio_pads0_attr0_qs;
	wire [7:0] mio_pads0_attr0_wd;
	wire mio_pads0_attr0_we;
	wire mio_pads0_attr0_re;
	wire [7:0] mio_pads0_attr1_qs;
	wire [7:0] mio_pads0_attr1_wd;
	wire mio_pads0_attr1_we;
	wire mio_pads0_attr1_re;
	wire [7:0] mio_pads0_attr2_qs;
	wire [7:0] mio_pads0_attr2_wd;
	wire mio_pads0_attr2_we;
	wire mio_pads0_attr2_re;
	wire [7:0] mio_pads0_attr3_qs;
	wire [7:0] mio_pads0_attr3_wd;
	wire mio_pads0_attr3_we;
	wire mio_pads0_attr3_re;
	wire [7:0] mio_pads1_attr4_qs;
	wire [7:0] mio_pads1_attr4_wd;
	wire mio_pads1_attr4_we;
	wire mio_pads1_attr4_re;
	wire [7:0] mio_pads1_attr5_qs;
	wire [7:0] mio_pads1_attr5_wd;
	wire mio_pads1_attr5_we;
	wire mio_pads1_attr5_re;
	wire [7:0] mio_pads1_attr6_qs;
	wire [7:0] mio_pads1_attr6_wd;
	wire mio_pads1_attr6_we;
	wire mio_pads1_attr6_re;
	wire [7:0] mio_pads1_attr7_qs;
	wire [7:0] mio_pads1_attr7_wd;
	wire mio_pads1_attr7_we;
	wire mio_pads1_attr7_re;
	wire [7:0] mio_pads2_attr8_qs;
	wire [7:0] mio_pads2_attr8_wd;
	wire mio_pads2_attr8_we;
	wire mio_pads2_attr8_re;
	wire [7:0] mio_pads2_attr9_qs;
	wire [7:0] mio_pads2_attr9_wd;
	wire mio_pads2_attr9_we;
	wire mio_pads2_attr9_re;
	wire [7:0] mio_pads2_attr10_qs;
	wire [7:0] mio_pads2_attr10_wd;
	wire mio_pads2_attr10_we;
	wire mio_pads2_attr10_re;
	wire [7:0] mio_pads2_attr11_qs;
	wire [7:0] mio_pads2_attr11_wd;
	wire mio_pads2_attr11_we;
	wire mio_pads2_attr11_re;
	wire [7:0] mio_pads3_attr12_qs;
	wire [7:0] mio_pads3_attr12_wd;
	wire mio_pads3_attr12_we;
	wire mio_pads3_attr12_re;
	wire [7:0] mio_pads3_attr13_qs;
	wire [7:0] mio_pads3_attr13_wd;
	wire mio_pads3_attr13_we;
	wire mio_pads3_attr13_re;
	wire [7:0] mio_pads3_attr14_qs;
	wire [7:0] mio_pads3_attr14_wd;
	wire mio_pads3_attr14_we;
	wire mio_pads3_attr14_re;
	wire [7:0] mio_pads3_attr15_qs;
	wire [7:0] mio_pads3_attr15_wd;
	wire mio_pads3_attr15_we;
	wire mio_pads3_attr15_re;
	prim_subreg #(
		.DW(1),
		.SWACCESS("W0C"),
		.RESVAL(1'h1)
	) u_regen(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(regen_we),
		.wd(regen_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(),
		.qs(regen_qs)
	);
	prim_subreg_ext #(.DW(8)) u_dio_pads_attr0(
		.re(dio_pads_attr0_re),
		.we((dio_pads_attr0_we & regen_qs)),
		.wd(dio_pads_attr0_wd),
		.d(hw2reg[128+:8]),
		.qre(),
		.qe(reg2hw[144+:1]),
		.q(reg2hw[145+:8]),
		.qs(dio_pads_attr0_qs)
	);
	prim_subreg_ext #(.DW(8)) u_dio_pads_attr1(
		.re(dio_pads_attr1_re),
		.we((dio_pads_attr1_we & regen_qs)),
		.wd(dio_pads_attr1_wd),
		.d(hw2reg[136+:8]),
		.qre(),
		.qe(reg2hw[153+:1]),
		.q(reg2hw[154+:8]),
		.qs(dio_pads_attr1_qs)
	);
	prim_subreg_ext #(.DW(8)) u_dio_pads_attr2(
		.re(dio_pads_attr2_re),
		.we((dio_pads_attr2_we & regen_qs)),
		.wd(dio_pads_attr2_wd),
		.d(hw2reg[144+:8]),
		.qre(),
		.qe(reg2hw[162+:1]),
		.q(reg2hw[163+:8]),
		.qs(dio_pads_attr2_qs)
	);
	prim_subreg_ext #(.DW(8)) u_dio_pads_attr3(
		.re(dio_pads_attr3_re),
		.we((dio_pads_attr3_we & regen_qs)),
		.wd(dio_pads_attr3_wd),
		.d(hw2reg[152+:8]),
		.qre(),
		.qe(reg2hw[171+:1]),
		.q(reg2hw[172+:8]),
		.qs(dio_pads_attr3_qs)
	);
	prim_subreg_ext #(.DW(8)) u_mio_pads0_attr0(
		.re(mio_pads0_attr0_re),
		.we((mio_pads0_attr0_we & regen_qs)),
		.wd(mio_pads0_attr0_wd),
		.d(hw2reg[0+:8]),
		.qre(),
		.qe(reg2hw[0+:1]),
		.q(reg2hw[1+:8]),
		.qs(mio_pads0_attr0_qs)
	);
	prim_subreg_ext #(.DW(8)) u_mio_pads0_attr1(
		.re(mio_pads0_attr1_re),
		.we((mio_pads0_attr1_we & regen_qs)),
		.wd(mio_pads0_attr1_wd),
		.d(hw2reg[8+:8]),
		.qre(),
		.qe(reg2hw[9+:1]),
		.q(reg2hw[10+:8]),
		.qs(mio_pads0_attr1_qs)
	);
	prim_subreg_ext #(.DW(8)) u_mio_pads0_attr2(
		.re(mio_pads0_attr2_re),
		.we((mio_pads0_attr2_we & regen_qs)),
		.wd(mio_pads0_attr2_wd),
		.d(hw2reg[16+:8]),
		.qre(),
		.qe(reg2hw[18+:1]),
		.q(reg2hw[19+:8]),
		.qs(mio_pads0_attr2_qs)
	);
	prim_subreg_ext #(.DW(8)) u_mio_pads0_attr3(
		.re(mio_pads0_attr3_re),
		.we((mio_pads0_attr3_we & regen_qs)),
		.wd(mio_pads0_attr3_wd),
		.d(hw2reg[24+:8]),
		.qre(),
		.qe(reg2hw[27+:1]),
		.q(reg2hw[28+:8]),
		.qs(mio_pads0_attr3_qs)
	);
	prim_subreg_ext #(.DW(8)) u_mio_pads1_attr4(
		.re(mio_pads1_attr4_re),
		.we((mio_pads1_attr4_we & regen_qs)),
		.wd(mio_pads1_attr4_wd),
		.d(hw2reg[32+:8]),
		.qre(),
		.qe(reg2hw[36+:1]),
		.q(reg2hw[37+:8]),
		.qs(mio_pads1_attr4_qs)
	);
	prim_subreg_ext #(.DW(8)) u_mio_pads1_attr5(
		.re(mio_pads1_attr5_re),
		.we((mio_pads1_attr5_we & regen_qs)),
		.wd(mio_pads1_attr5_wd),
		.d(hw2reg[40+:8]),
		.qre(),
		.qe(reg2hw[45+:1]),
		.q(reg2hw[46+:8]),
		.qs(mio_pads1_attr5_qs)
	);
	prim_subreg_ext #(.DW(8)) u_mio_pads1_attr6(
		.re(mio_pads1_attr6_re),
		.we((mio_pads1_attr6_we & regen_qs)),
		.wd(mio_pads1_attr6_wd),
		.d(hw2reg[48+:8]),
		.qre(),
		.qe(reg2hw[54+:1]),
		.q(reg2hw[55+:8]),
		.qs(mio_pads1_attr6_qs)
	);
	prim_subreg_ext #(.DW(8)) u_mio_pads1_attr7(
		.re(mio_pads1_attr7_re),
		.we((mio_pads1_attr7_we & regen_qs)),
		.wd(mio_pads1_attr7_wd),
		.d(hw2reg[56+:8]),
		.qre(),
		.qe(reg2hw[63+:1]),
		.q(reg2hw[64+:8]),
		.qs(mio_pads1_attr7_qs)
	);
	prim_subreg_ext #(.DW(8)) u_mio_pads2_attr8(
		.re(mio_pads2_attr8_re),
		.we((mio_pads2_attr8_we & regen_qs)),
		.wd(mio_pads2_attr8_wd),
		.d(hw2reg[64+:8]),
		.qre(),
		.qe(reg2hw[72+:1]),
		.q(reg2hw[73+:8]),
		.qs(mio_pads2_attr8_qs)
	);
	prim_subreg_ext #(.DW(8)) u_mio_pads2_attr9(
		.re(mio_pads2_attr9_re),
		.we((mio_pads2_attr9_we & regen_qs)),
		.wd(mio_pads2_attr9_wd),
		.d(hw2reg[72+:8]),
		.qre(),
		.qe(reg2hw[81+:1]),
		.q(reg2hw[82+:8]),
		.qs(mio_pads2_attr9_qs)
	);
	prim_subreg_ext #(.DW(8)) u_mio_pads2_attr10(
		.re(mio_pads2_attr10_re),
		.we((mio_pads2_attr10_we & regen_qs)),
		.wd(mio_pads2_attr10_wd),
		.d(hw2reg[80+:8]),
		.qre(),
		.qe(reg2hw[90+:1]),
		.q(reg2hw[91+:8]),
		.qs(mio_pads2_attr10_qs)
	);
	prim_subreg_ext #(.DW(8)) u_mio_pads2_attr11(
		.re(mio_pads2_attr11_re),
		.we((mio_pads2_attr11_we & regen_qs)),
		.wd(mio_pads2_attr11_wd),
		.d(hw2reg[88+:8]),
		.qre(),
		.qe(reg2hw[99+:1]),
		.q(reg2hw[100+:8]),
		.qs(mio_pads2_attr11_qs)
	);
	prim_subreg_ext #(.DW(8)) u_mio_pads3_attr12(
		.re(mio_pads3_attr12_re),
		.we((mio_pads3_attr12_we & regen_qs)),
		.wd(mio_pads3_attr12_wd),
		.d(hw2reg[96+:8]),
		.qre(),
		.qe(reg2hw[108+:1]),
		.q(reg2hw[109+:8]),
		.qs(mio_pads3_attr12_qs)
	);
	prim_subreg_ext #(.DW(8)) u_mio_pads3_attr13(
		.re(mio_pads3_attr13_re),
		.we((mio_pads3_attr13_we & regen_qs)),
		.wd(mio_pads3_attr13_wd),
		.d(hw2reg[104+:8]),
		.qre(),
		.qe(reg2hw[117+:1]),
		.q(reg2hw[118+:8]),
		.qs(mio_pads3_attr13_qs)
	);
	prim_subreg_ext #(.DW(8)) u_mio_pads3_attr14(
		.re(mio_pads3_attr14_re),
		.we((mio_pads3_attr14_we & regen_qs)),
		.wd(mio_pads3_attr14_wd),
		.d(hw2reg[112+:8]),
		.qre(),
		.qe(reg2hw[126+:1]),
		.q(reg2hw[127+:8]),
		.qs(mio_pads3_attr14_qs)
	);
	prim_subreg_ext #(.DW(8)) u_mio_pads3_attr15(
		.re(mio_pads3_attr15_re),
		.we((mio_pads3_attr15_we & regen_qs)),
		.wd(mio_pads3_attr15_wd),
		.d(hw2reg[120+:8]),
		.qre(),
		.qe(reg2hw[135+:1]),
		.q(reg2hw[136+:8]),
		.qs(mio_pads3_attr15_qs)
	);
	reg [5:0] addr_hit;
	always @(*) begin
		addr_hit = 1'sb0;
		addr_hit[0] = (reg_addr == PADCTRL_REGEN_OFFSET);
		addr_hit[1] = (reg_addr == PADCTRL_DIO_PADS_OFFSET);
		addr_hit[2] = (reg_addr == PADCTRL_MIO_PADS0_OFFSET);
		addr_hit[3] = (reg_addr == PADCTRL_MIO_PADS1_OFFSET);
		addr_hit[4] = (reg_addr == PADCTRL_MIO_PADS2_OFFSET);
		addr_hit[5] = (reg_addr == PADCTRL_MIO_PADS3_OFFSET);
	end
	assign addrmiss = ((reg_re || reg_we) ? ~|addr_hit : 1'b0);
	always @(*) begin
		wr_err = 1'b0;
		if (((addr_hit[0] && reg_we) && (PADCTRL_PERMIT[20+:4] != (PADCTRL_PERMIT[20+:4] & reg_be))))
			wr_err = 1'b1;
		if (((addr_hit[1] && reg_we) && (PADCTRL_PERMIT[16+:4] != (PADCTRL_PERMIT[16+:4] & reg_be))))
			wr_err = 1'b1;
		if (((addr_hit[2] && reg_we) && (PADCTRL_PERMIT[12+:4] != (PADCTRL_PERMIT[12+:4] & reg_be))))
			wr_err = 1'b1;
		if (((addr_hit[3] && reg_we) && (PADCTRL_PERMIT[8+:4] != (PADCTRL_PERMIT[8+:4] & reg_be))))
			wr_err = 1'b1;
		if (((addr_hit[4] && reg_we) && (PADCTRL_PERMIT[4+:4] != (PADCTRL_PERMIT[4+:4] & reg_be))))
			wr_err = 1'b1;
		if (((addr_hit[5] && reg_we) && (PADCTRL_PERMIT[0+:4] != (PADCTRL_PERMIT[0+:4] & reg_be))))
			wr_err = 1'b1;
	end
	assign regen_we = ((addr_hit[0] & reg_we) & ~wr_err);
	assign regen_wd = reg_wdata[0];
	assign dio_pads_attr0_we = ((addr_hit[1] & reg_we) & ~wr_err);
	assign dio_pads_attr0_wd = reg_wdata[7:0];
	assign dio_pads_attr0_re = (addr_hit[1] && reg_re);
	assign dio_pads_attr1_we = ((addr_hit[1] & reg_we) & ~wr_err);
	assign dio_pads_attr1_wd = reg_wdata[15:8];
	assign dio_pads_attr1_re = (addr_hit[1] && reg_re);
	assign dio_pads_attr2_we = ((addr_hit[1] & reg_we) & ~wr_err);
	assign dio_pads_attr2_wd = reg_wdata[23:16];
	assign dio_pads_attr2_re = (addr_hit[1] && reg_re);
	assign dio_pads_attr3_we = ((addr_hit[1] & reg_we) & ~wr_err);
	assign dio_pads_attr3_wd = reg_wdata[31:24];
	assign dio_pads_attr3_re = (addr_hit[1] && reg_re);
	assign mio_pads0_attr0_we = ((addr_hit[2] & reg_we) & ~wr_err);
	assign mio_pads0_attr0_wd = reg_wdata[7:0];
	assign mio_pads0_attr0_re = (addr_hit[2] && reg_re);
	assign mio_pads0_attr1_we = ((addr_hit[2] & reg_we) & ~wr_err);
	assign mio_pads0_attr1_wd = reg_wdata[15:8];
	assign mio_pads0_attr1_re = (addr_hit[2] && reg_re);
	assign mio_pads0_attr2_we = ((addr_hit[2] & reg_we) & ~wr_err);
	assign mio_pads0_attr2_wd = reg_wdata[23:16];
	assign mio_pads0_attr2_re = (addr_hit[2] && reg_re);
	assign mio_pads0_attr3_we = ((addr_hit[2] & reg_we) & ~wr_err);
	assign mio_pads0_attr3_wd = reg_wdata[31:24];
	assign mio_pads0_attr3_re = (addr_hit[2] && reg_re);
	assign mio_pads1_attr4_we = ((addr_hit[3] & reg_we) & ~wr_err);
	assign mio_pads1_attr4_wd = reg_wdata[7:0];
	assign mio_pads1_attr4_re = (addr_hit[3] && reg_re);
	assign mio_pads1_attr5_we = ((addr_hit[3] & reg_we) & ~wr_err);
	assign mio_pads1_attr5_wd = reg_wdata[15:8];
	assign mio_pads1_attr5_re = (addr_hit[3] && reg_re);
	assign mio_pads1_attr6_we = ((addr_hit[3] & reg_we) & ~wr_err);
	assign mio_pads1_attr6_wd = reg_wdata[23:16];
	assign mio_pads1_attr6_re = (addr_hit[3] && reg_re);
	assign mio_pads1_attr7_we = ((addr_hit[3] & reg_we) & ~wr_err);
	assign mio_pads1_attr7_wd = reg_wdata[31:24];
	assign mio_pads1_attr7_re = (addr_hit[3] && reg_re);
	assign mio_pads2_attr8_we = ((addr_hit[4] & reg_we) & ~wr_err);
	assign mio_pads2_attr8_wd = reg_wdata[7:0];
	assign mio_pads2_attr8_re = (addr_hit[4] && reg_re);
	assign mio_pads2_attr9_we = ((addr_hit[4] & reg_we) & ~wr_err);
	assign mio_pads2_attr9_wd = reg_wdata[15:8];
	assign mio_pads2_attr9_re = (addr_hit[4] && reg_re);
	assign mio_pads2_attr10_we = ((addr_hit[4] & reg_we) & ~wr_err);
	assign mio_pads2_attr10_wd = reg_wdata[23:16];
	assign mio_pads2_attr10_re = (addr_hit[4] && reg_re);
	assign mio_pads2_attr11_we = ((addr_hit[4] & reg_we) & ~wr_err);
	assign mio_pads2_attr11_wd = reg_wdata[31:24];
	assign mio_pads2_attr11_re = (addr_hit[4] && reg_re);
	assign mio_pads3_attr12_we = ((addr_hit[5] & reg_we) & ~wr_err);
	assign mio_pads3_attr12_wd = reg_wdata[7:0];
	assign mio_pads3_attr12_re = (addr_hit[5] && reg_re);
	assign mio_pads3_attr13_we = ((addr_hit[5] & reg_we) & ~wr_err);
	assign mio_pads3_attr13_wd = reg_wdata[15:8];
	assign mio_pads3_attr13_re = (addr_hit[5] && reg_re);
	assign mio_pads3_attr14_we = ((addr_hit[5] & reg_we) & ~wr_err);
	assign mio_pads3_attr14_wd = reg_wdata[23:16];
	assign mio_pads3_attr14_re = (addr_hit[5] && reg_re);
	assign mio_pads3_attr15_we = ((addr_hit[5] & reg_we) & ~wr_err);
	assign mio_pads3_attr15_wd = reg_wdata[31:24];
	assign mio_pads3_attr15_re = (addr_hit[5] && reg_re);
	always @(*) begin
		reg_rdata_next = 1'sb0;
		case (1'b1)
			addr_hit[0]: reg_rdata_next[0] = regen_qs;
			addr_hit[1]: begin
				reg_rdata_next[7:0] = dio_pads_attr0_qs;
				reg_rdata_next[15:8] = dio_pads_attr1_qs;
				reg_rdata_next[23:16] = dio_pads_attr2_qs;
				reg_rdata_next[31:24] = dio_pads_attr3_qs;
			end
			addr_hit[2]: begin
				reg_rdata_next[7:0] = mio_pads0_attr0_qs;
				reg_rdata_next[15:8] = mio_pads0_attr1_qs;
				reg_rdata_next[23:16] = mio_pads0_attr2_qs;
				reg_rdata_next[31:24] = mio_pads0_attr3_qs;
			end
			addr_hit[3]: begin
				reg_rdata_next[7:0] = mio_pads1_attr4_qs;
				reg_rdata_next[15:8] = mio_pads1_attr5_qs;
				reg_rdata_next[23:16] = mio_pads1_attr6_qs;
				reg_rdata_next[31:24] = mio_pads1_attr7_qs;
			end
			addr_hit[4]: begin
				reg_rdata_next[7:0] = mio_pads2_attr8_qs;
				reg_rdata_next[15:8] = mio_pads2_attr9_qs;
				reg_rdata_next[23:16] = mio_pads2_attr10_qs;
				reg_rdata_next[31:24] = mio_pads2_attr11_qs;
			end
			addr_hit[5]: begin
				reg_rdata_next[7:0] = mio_pads3_attr12_qs;
				reg_rdata_next[15:8] = mio_pads3_attr13_qs;
				reg_rdata_next[23:16] = mio_pads3_attr14_qs;
				reg_rdata_next[31:24] = mio_pads3_attr15_qs;
			end
			default: reg_rdata_next = 1'sb1;
		endcase
	end
endmodule
