module rv_plic_reg_top (
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
	output wire [230:0] reg2hw;
	input wire [115:0] hw2reg;
	input devmode_i;
	localparam signed [31:0] NumSrc = 55;
	localparam signed [31:0] NumTarget = 1;
	parameter RV_PLIC_IP0_OFFSET = 9'h 0;
	parameter RV_PLIC_IP1_OFFSET = 9'h 4;
	parameter RV_PLIC_LE0_OFFSET = 9'h 8;
	parameter RV_PLIC_LE1_OFFSET = 9'h c;
	parameter RV_PLIC_PRIO0_OFFSET = 9'h 10;
	parameter RV_PLIC_PRIO1_OFFSET = 9'h 14;
	parameter RV_PLIC_PRIO2_OFFSET = 9'h 18;
	parameter RV_PLIC_PRIO3_OFFSET = 9'h 1c;
	parameter RV_PLIC_PRIO4_OFFSET = 9'h 20;
	parameter RV_PLIC_PRIO5_OFFSET = 9'h 24;
	parameter RV_PLIC_PRIO6_OFFSET = 9'h 28;
	parameter RV_PLIC_PRIO7_OFFSET = 9'h 2c;
	parameter RV_PLIC_PRIO8_OFFSET = 9'h 30;
	parameter RV_PLIC_PRIO9_OFFSET = 9'h 34;
	parameter RV_PLIC_PRIO10_OFFSET = 9'h 38;
	parameter RV_PLIC_PRIO11_OFFSET = 9'h 3c;
	parameter RV_PLIC_PRIO12_OFFSET = 9'h 40;
	parameter RV_PLIC_PRIO13_OFFSET = 9'h 44;
	parameter RV_PLIC_PRIO14_OFFSET = 9'h 48;
	parameter RV_PLIC_PRIO15_OFFSET = 9'h 4c;
	parameter RV_PLIC_PRIO16_OFFSET = 9'h 50;
	parameter RV_PLIC_PRIO17_OFFSET = 9'h 54;
	parameter RV_PLIC_PRIO18_OFFSET = 9'h 58;
	parameter RV_PLIC_PRIO19_OFFSET = 9'h 5c;
	parameter RV_PLIC_PRIO20_OFFSET = 9'h 60;
	parameter RV_PLIC_PRIO21_OFFSET = 9'h 64;
	parameter RV_PLIC_PRIO22_OFFSET = 9'h 68;
	parameter RV_PLIC_PRIO23_OFFSET = 9'h 6c;
	parameter RV_PLIC_PRIO24_OFFSET = 9'h 70;
	parameter RV_PLIC_PRIO25_OFFSET = 9'h 74;
	parameter RV_PLIC_PRIO26_OFFSET = 9'h 78;
	parameter RV_PLIC_PRIO27_OFFSET = 9'h 7c;
	parameter RV_PLIC_PRIO28_OFFSET = 9'h 80;
	parameter RV_PLIC_PRIO29_OFFSET = 9'h 84;
	parameter RV_PLIC_PRIO30_OFFSET = 9'h 88;
	parameter RV_PLIC_PRIO31_OFFSET = 9'h 8c;
	parameter RV_PLIC_PRIO32_OFFSET = 9'h 90;
	parameter RV_PLIC_PRIO33_OFFSET = 9'h 94;
	parameter RV_PLIC_PRIO34_OFFSET = 9'h 98;
	parameter RV_PLIC_PRIO35_OFFSET = 9'h 9c;
	parameter RV_PLIC_PRIO36_OFFSET = 9'h a0;
	parameter RV_PLIC_PRIO37_OFFSET = 9'h a4;
	parameter RV_PLIC_PRIO38_OFFSET = 9'h a8;
	parameter RV_PLIC_PRIO39_OFFSET = 9'h ac;
	parameter RV_PLIC_PRIO40_OFFSET = 9'h b0;
	parameter RV_PLIC_PRIO41_OFFSET = 9'h b4;
	parameter RV_PLIC_PRIO42_OFFSET = 9'h b8;
	parameter RV_PLIC_PRIO43_OFFSET = 9'h bc;
	parameter RV_PLIC_PRIO44_OFFSET = 9'h c0;
	parameter RV_PLIC_PRIO45_OFFSET = 9'h c4;
	parameter RV_PLIC_PRIO46_OFFSET = 9'h c8;
	parameter RV_PLIC_PRIO47_OFFSET = 9'h cc;
	parameter RV_PLIC_PRIO48_OFFSET = 9'h d0;
	parameter RV_PLIC_PRIO49_OFFSET = 9'h d4;
	parameter RV_PLIC_PRIO50_OFFSET = 9'h d8;
	parameter RV_PLIC_PRIO51_OFFSET = 9'h dc;
	parameter RV_PLIC_PRIO52_OFFSET = 9'h e0;
	parameter RV_PLIC_PRIO53_OFFSET = 9'h e4;
	parameter RV_PLIC_PRIO54_OFFSET = 9'h e8;
	parameter RV_PLIC_IE00_OFFSET = 9'h 100;
	parameter RV_PLIC_IE01_OFFSET = 9'h 104;
	parameter RV_PLIC_THRESHOLD0_OFFSET = 9'h 108;
	parameter RV_PLIC_CC0_OFFSET = 9'h 10c;
	parameter RV_PLIC_MSIP0_OFFSET = 9'h 110;
	localparam [255:0] RV_PLIC_PERMIT = {4'b 1111, 4'b 0111, 4'b 1111, 4'b 0111, 4'b 0001, 4'b 0001, 4'b 0001, 4'b 0001, 4'b 0001, 4'b 0001, 4'b 0001, 4'b 0001, 4'b 0001, 4'b 0001, 4'b 0001, 4'b 0001, 4'b 0001, 4'b 0001, 4'b 0001, 4'b 0001, 4'b 0001, 4'b 0001, 4'b 0001, 4'b 0001, 4'b 0001, 4'b 0001, 4'b 0001, 4'b 0001, 4'b 0001, 4'b 0001, 4'b 0001, 4'b 0001, 4'b 0001, 4'b 0001, 4'b 0001, 4'b 0001, 4'b 0001, 4'b 0001, 4'b 0001, 4'b 0001, 4'b 0001, 4'b 0001, 4'b 0001, 4'b 0001, 4'b 0001, 4'b 0001, 4'b 0001, 4'b 0001, 4'b 0001, 4'b 0001, 4'b 0001, 4'b 0001, 4'b 0001, 4'b 0001, 4'b 0001, 4'b 0001, 4'b 0001, 4'b 0001, 4'b 0001, 4'b 1111, 4'b 0111, 4'b 0001, 4'b 0001, 4'b 0001};
	localparam RV_PLIC_IP0 = 0;
	localparam RV_PLIC_IP1 = 1;
	localparam RV_PLIC_PRIO6 = 10;
	localparam RV_PLIC_PRIO7 = 11;
	localparam RV_PLIC_PRIO8 = 12;
	localparam RV_PLIC_PRIO9 = 13;
	localparam RV_PLIC_PRIO10 = 14;
	localparam RV_PLIC_PRIO11 = 15;
	localparam RV_PLIC_PRIO12 = 16;
	localparam RV_PLIC_PRIO13 = 17;
	localparam RV_PLIC_PRIO14 = 18;
	localparam RV_PLIC_PRIO15 = 19;
	localparam RV_PLIC_LE0 = 2;
	localparam RV_PLIC_PRIO16 = 20;
	localparam RV_PLIC_PRIO17 = 21;
	localparam RV_PLIC_PRIO18 = 22;
	localparam RV_PLIC_PRIO19 = 23;
	localparam RV_PLIC_PRIO20 = 24;
	localparam RV_PLIC_PRIO21 = 25;
	localparam RV_PLIC_PRIO22 = 26;
	localparam RV_PLIC_PRIO23 = 27;
	localparam RV_PLIC_PRIO24 = 28;
	localparam RV_PLIC_PRIO25 = 29;
	localparam RV_PLIC_LE1 = 3;
	localparam RV_PLIC_PRIO26 = 30;
	localparam RV_PLIC_PRIO27 = 31;
	localparam RV_PLIC_PRIO28 = 32;
	localparam RV_PLIC_PRIO29 = 33;
	localparam RV_PLIC_PRIO30 = 34;
	localparam RV_PLIC_PRIO31 = 35;
	localparam RV_PLIC_PRIO32 = 36;
	localparam RV_PLIC_PRIO33 = 37;
	localparam RV_PLIC_PRIO34 = 38;
	localparam RV_PLIC_PRIO35 = 39;
	localparam RV_PLIC_PRIO0 = 4;
	localparam RV_PLIC_PRIO36 = 40;
	localparam RV_PLIC_PRIO37 = 41;
	localparam RV_PLIC_PRIO38 = 42;
	localparam RV_PLIC_PRIO39 = 43;
	localparam RV_PLIC_PRIO40 = 44;
	localparam RV_PLIC_PRIO41 = 45;
	localparam RV_PLIC_PRIO42 = 46;
	localparam RV_PLIC_PRIO43 = 47;
	localparam RV_PLIC_PRIO44 = 48;
	localparam RV_PLIC_PRIO45 = 49;
	localparam RV_PLIC_PRIO1 = 5;
	localparam RV_PLIC_PRIO46 = 50;
	localparam RV_PLIC_PRIO47 = 51;
	localparam RV_PLIC_PRIO48 = 52;
	localparam RV_PLIC_PRIO49 = 53;
	localparam RV_PLIC_PRIO50 = 54;
	localparam RV_PLIC_PRIO51 = 55;
	localparam RV_PLIC_PRIO52 = 56;
	localparam RV_PLIC_PRIO53 = 57;
	localparam RV_PLIC_PRIO54 = 58;
	localparam RV_PLIC_IE00 = 59;
	localparam RV_PLIC_PRIO2 = 6;
	localparam RV_PLIC_IE01 = 60;
	localparam RV_PLIC_THRESHOLD0 = 61;
	localparam RV_PLIC_CC0 = 62;
	localparam RV_PLIC_MSIP0 = 63;
	localparam RV_PLIC_PRIO3 = 7;
	localparam RV_PLIC_PRIO4 = 8;
	localparam RV_PLIC_PRIO5 = 9;
	localparam AW = 9;
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
	wire ip0_p0_qs;
	wire ip0_p1_qs;
	wire ip0_p2_qs;
	wire ip0_p3_qs;
	wire ip0_p4_qs;
	wire ip0_p5_qs;
	wire ip0_p6_qs;
	wire ip0_p7_qs;
	wire ip0_p8_qs;
	wire ip0_p9_qs;
	wire ip0_p10_qs;
	wire ip0_p11_qs;
	wire ip0_p12_qs;
	wire ip0_p13_qs;
	wire ip0_p14_qs;
	wire ip0_p15_qs;
	wire ip0_p16_qs;
	wire ip0_p17_qs;
	wire ip0_p18_qs;
	wire ip0_p19_qs;
	wire ip0_p20_qs;
	wire ip0_p21_qs;
	wire ip0_p22_qs;
	wire ip0_p23_qs;
	wire ip0_p24_qs;
	wire ip0_p25_qs;
	wire ip0_p26_qs;
	wire ip0_p27_qs;
	wire ip0_p28_qs;
	wire ip0_p29_qs;
	wire ip0_p30_qs;
	wire ip0_p31_qs;
	wire ip1_p32_qs;
	wire ip1_p33_qs;
	wire ip1_p34_qs;
	wire ip1_p35_qs;
	wire ip1_p36_qs;
	wire ip1_p37_qs;
	wire ip1_p38_qs;
	wire ip1_p39_qs;
	wire ip1_p40_qs;
	wire ip1_p41_qs;
	wire ip1_p42_qs;
	wire ip1_p43_qs;
	wire ip1_p44_qs;
	wire ip1_p45_qs;
	wire ip1_p46_qs;
	wire ip1_p47_qs;
	wire ip1_p48_qs;
	wire ip1_p49_qs;
	wire ip1_p50_qs;
	wire ip1_p51_qs;
	wire ip1_p52_qs;
	wire ip1_p53_qs;
	wire ip1_p54_qs;
	wire le0_le0_qs;
	wire le0_le0_wd;
	wire le0_le0_we;
	wire le0_le1_qs;
	wire le0_le1_wd;
	wire le0_le1_we;
	wire le0_le2_qs;
	wire le0_le2_wd;
	wire le0_le2_we;
	wire le0_le3_qs;
	wire le0_le3_wd;
	wire le0_le3_we;
	wire le0_le4_qs;
	wire le0_le4_wd;
	wire le0_le4_we;
	wire le0_le5_qs;
	wire le0_le5_wd;
	wire le0_le5_we;
	wire le0_le6_qs;
	wire le0_le6_wd;
	wire le0_le6_we;
	wire le0_le7_qs;
	wire le0_le7_wd;
	wire le0_le7_we;
	wire le0_le8_qs;
	wire le0_le8_wd;
	wire le0_le8_we;
	wire le0_le9_qs;
	wire le0_le9_wd;
	wire le0_le9_we;
	wire le0_le10_qs;
	wire le0_le10_wd;
	wire le0_le10_we;
	wire le0_le11_qs;
	wire le0_le11_wd;
	wire le0_le11_we;
	wire le0_le12_qs;
	wire le0_le12_wd;
	wire le0_le12_we;
	wire le0_le13_qs;
	wire le0_le13_wd;
	wire le0_le13_we;
	wire le0_le14_qs;
	wire le0_le14_wd;
	wire le0_le14_we;
	wire le0_le15_qs;
	wire le0_le15_wd;
	wire le0_le15_we;
	wire le0_le16_qs;
	wire le0_le16_wd;
	wire le0_le16_we;
	wire le0_le17_qs;
	wire le0_le17_wd;
	wire le0_le17_we;
	wire le0_le18_qs;
	wire le0_le18_wd;
	wire le0_le18_we;
	wire le0_le19_qs;
	wire le0_le19_wd;
	wire le0_le19_we;
	wire le0_le20_qs;
	wire le0_le20_wd;
	wire le0_le20_we;
	wire le0_le21_qs;
	wire le0_le21_wd;
	wire le0_le21_we;
	wire le0_le22_qs;
	wire le0_le22_wd;
	wire le0_le22_we;
	wire le0_le23_qs;
	wire le0_le23_wd;
	wire le0_le23_we;
	wire le0_le24_qs;
	wire le0_le24_wd;
	wire le0_le24_we;
	wire le0_le25_qs;
	wire le0_le25_wd;
	wire le0_le25_we;
	wire le0_le26_qs;
	wire le0_le26_wd;
	wire le0_le26_we;
	wire le0_le27_qs;
	wire le0_le27_wd;
	wire le0_le27_we;
	wire le0_le28_qs;
	wire le0_le28_wd;
	wire le0_le28_we;
	wire le0_le29_qs;
	wire le0_le29_wd;
	wire le0_le29_we;
	wire le0_le30_qs;
	wire le0_le30_wd;
	wire le0_le30_we;
	wire le0_le31_qs;
	wire le0_le31_wd;
	wire le0_le31_we;
	wire le1_le32_qs;
	wire le1_le32_wd;
	wire le1_le32_we;
	wire le1_le33_qs;
	wire le1_le33_wd;
	wire le1_le33_we;
	wire le1_le34_qs;
	wire le1_le34_wd;
	wire le1_le34_we;
	wire le1_le35_qs;
	wire le1_le35_wd;
	wire le1_le35_we;
	wire le1_le36_qs;
	wire le1_le36_wd;
	wire le1_le36_we;
	wire le1_le37_qs;
	wire le1_le37_wd;
	wire le1_le37_we;
	wire le1_le38_qs;
	wire le1_le38_wd;
	wire le1_le38_we;
	wire le1_le39_qs;
	wire le1_le39_wd;
	wire le1_le39_we;
	wire le1_le40_qs;
	wire le1_le40_wd;
	wire le1_le40_we;
	wire le1_le41_qs;
	wire le1_le41_wd;
	wire le1_le41_we;
	wire le1_le42_qs;
	wire le1_le42_wd;
	wire le1_le42_we;
	wire le1_le43_qs;
	wire le1_le43_wd;
	wire le1_le43_we;
	wire le1_le44_qs;
	wire le1_le44_wd;
	wire le1_le44_we;
	wire le1_le45_qs;
	wire le1_le45_wd;
	wire le1_le45_we;
	wire le1_le46_qs;
	wire le1_le46_wd;
	wire le1_le46_we;
	wire le1_le47_qs;
	wire le1_le47_wd;
	wire le1_le47_we;
	wire le1_le48_qs;
	wire le1_le48_wd;
	wire le1_le48_we;
	wire le1_le49_qs;
	wire le1_le49_wd;
	wire le1_le49_we;
	wire le1_le50_qs;
	wire le1_le50_wd;
	wire le1_le50_we;
	wire le1_le51_qs;
	wire le1_le51_wd;
	wire le1_le51_we;
	wire le1_le52_qs;
	wire le1_le52_wd;
	wire le1_le52_we;
	wire le1_le53_qs;
	wire le1_le53_wd;
	wire le1_le53_we;
	wire le1_le54_qs;
	wire le1_le54_wd;
	wire le1_le54_we;
	wire [1:0] prio0_qs;
	wire [1:0] prio0_wd;
	wire prio0_we;
	wire [1:0] prio1_qs;
	wire [1:0] prio1_wd;
	wire prio1_we;
	wire [1:0] prio2_qs;
	wire [1:0] prio2_wd;
	wire prio2_we;
	wire [1:0] prio3_qs;
	wire [1:0] prio3_wd;
	wire prio3_we;
	wire [1:0] prio4_qs;
	wire [1:0] prio4_wd;
	wire prio4_we;
	wire [1:0] prio5_qs;
	wire [1:0] prio5_wd;
	wire prio5_we;
	wire [1:0] prio6_qs;
	wire [1:0] prio6_wd;
	wire prio6_we;
	wire [1:0] prio7_qs;
	wire [1:0] prio7_wd;
	wire prio7_we;
	wire [1:0] prio8_qs;
	wire [1:0] prio8_wd;
	wire prio8_we;
	wire [1:0] prio9_qs;
	wire [1:0] prio9_wd;
	wire prio9_we;
	wire [1:0] prio10_qs;
	wire [1:0] prio10_wd;
	wire prio10_we;
	wire [1:0] prio11_qs;
	wire [1:0] prio11_wd;
	wire prio11_we;
	wire [1:0] prio12_qs;
	wire [1:0] prio12_wd;
	wire prio12_we;
	wire [1:0] prio13_qs;
	wire [1:0] prio13_wd;
	wire prio13_we;
	wire [1:0] prio14_qs;
	wire [1:0] prio14_wd;
	wire prio14_we;
	wire [1:0] prio15_qs;
	wire [1:0] prio15_wd;
	wire prio15_we;
	wire [1:0] prio16_qs;
	wire [1:0] prio16_wd;
	wire prio16_we;
	wire [1:0] prio17_qs;
	wire [1:0] prio17_wd;
	wire prio17_we;
	wire [1:0] prio18_qs;
	wire [1:0] prio18_wd;
	wire prio18_we;
	wire [1:0] prio19_qs;
	wire [1:0] prio19_wd;
	wire prio19_we;
	wire [1:0] prio20_qs;
	wire [1:0] prio20_wd;
	wire prio20_we;
	wire [1:0] prio21_qs;
	wire [1:0] prio21_wd;
	wire prio21_we;
	wire [1:0] prio22_qs;
	wire [1:0] prio22_wd;
	wire prio22_we;
	wire [1:0] prio23_qs;
	wire [1:0] prio23_wd;
	wire prio23_we;
	wire [1:0] prio24_qs;
	wire [1:0] prio24_wd;
	wire prio24_we;
	wire [1:0] prio25_qs;
	wire [1:0] prio25_wd;
	wire prio25_we;
	wire [1:0] prio26_qs;
	wire [1:0] prio26_wd;
	wire prio26_we;
	wire [1:0] prio27_qs;
	wire [1:0] prio27_wd;
	wire prio27_we;
	wire [1:0] prio28_qs;
	wire [1:0] prio28_wd;
	wire prio28_we;
	wire [1:0] prio29_qs;
	wire [1:0] prio29_wd;
	wire prio29_we;
	wire [1:0] prio30_qs;
	wire [1:0] prio30_wd;
	wire prio30_we;
	wire [1:0] prio31_qs;
	wire [1:0] prio31_wd;
	wire prio31_we;
	wire [1:0] prio32_qs;
	wire [1:0] prio32_wd;
	wire prio32_we;
	wire [1:0] prio33_qs;
	wire [1:0] prio33_wd;
	wire prio33_we;
	wire [1:0] prio34_qs;
	wire [1:0] prio34_wd;
	wire prio34_we;
	wire [1:0] prio35_qs;
	wire [1:0] prio35_wd;
	wire prio35_we;
	wire [1:0] prio36_qs;
	wire [1:0] prio36_wd;
	wire prio36_we;
	wire [1:0] prio37_qs;
	wire [1:0] prio37_wd;
	wire prio37_we;
	wire [1:0] prio38_qs;
	wire [1:0] prio38_wd;
	wire prio38_we;
	wire [1:0] prio39_qs;
	wire [1:0] prio39_wd;
	wire prio39_we;
	wire [1:0] prio40_qs;
	wire [1:0] prio40_wd;
	wire prio40_we;
	wire [1:0] prio41_qs;
	wire [1:0] prio41_wd;
	wire prio41_we;
	wire [1:0] prio42_qs;
	wire [1:0] prio42_wd;
	wire prio42_we;
	wire [1:0] prio43_qs;
	wire [1:0] prio43_wd;
	wire prio43_we;
	wire [1:0] prio44_qs;
	wire [1:0] prio44_wd;
	wire prio44_we;
	wire [1:0] prio45_qs;
	wire [1:0] prio45_wd;
	wire prio45_we;
	wire [1:0] prio46_qs;
	wire [1:0] prio46_wd;
	wire prio46_we;
	wire [1:0] prio47_qs;
	wire [1:0] prio47_wd;
	wire prio47_we;
	wire [1:0] prio48_qs;
	wire [1:0] prio48_wd;
	wire prio48_we;
	wire [1:0] prio49_qs;
	wire [1:0] prio49_wd;
	wire prio49_we;
	wire [1:0] prio50_qs;
	wire [1:0] prio50_wd;
	wire prio50_we;
	wire [1:0] prio51_qs;
	wire [1:0] prio51_wd;
	wire prio51_we;
	wire [1:0] prio52_qs;
	wire [1:0] prio52_wd;
	wire prio52_we;
	wire [1:0] prio53_qs;
	wire [1:0] prio53_wd;
	wire prio53_we;
	wire [1:0] prio54_qs;
	wire [1:0] prio54_wd;
	wire prio54_we;
	wire ie00_e0_qs;
	wire ie00_e0_wd;
	wire ie00_e0_we;
	wire ie00_e1_qs;
	wire ie00_e1_wd;
	wire ie00_e1_we;
	wire ie00_e2_qs;
	wire ie00_e2_wd;
	wire ie00_e2_we;
	wire ie00_e3_qs;
	wire ie00_e3_wd;
	wire ie00_e3_we;
	wire ie00_e4_qs;
	wire ie00_e4_wd;
	wire ie00_e4_we;
	wire ie00_e5_qs;
	wire ie00_e5_wd;
	wire ie00_e5_we;
	wire ie00_e6_qs;
	wire ie00_e6_wd;
	wire ie00_e6_we;
	wire ie00_e7_qs;
	wire ie00_e7_wd;
	wire ie00_e7_we;
	wire ie00_e8_qs;
	wire ie00_e8_wd;
	wire ie00_e8_we;
	wire ie00_e9_qs;
	wire ie00_e9_wd;
	wire ie00_e9_we;
	wire ie00_e10_qs;
	wire ie00_e10_wd;
	wire ie00_e10_we;
	wire ie00_e11_qs;
	wire ie00_e11_wd;
	wire ie00_e11_we;
	wire ie00_e12_qs;
	wire ie00_e12_wd;
	wire ie00_e12_we;
	wire ie00_e13_qs;
	wire ie00_e13_wd;
	wire ie00_e13_we;
	wire ie00_e14_qs;
	wire ie00_e14_wd;
	wire ie00_e14_we;
	wire ie00_e15_qs;
	wire ie00_e15_wd;
	wire ie00_e15_we;
	wire ie00_e16_qs;
	wire ie00_e16_wd;
	wire ie00_e16_we;
	wire ie00_e17_qs;
	wire ie00_e17_wd;
	wire ie00_e17_we;
	wire ie00_e18_qs;
	wire ie00_e18_wd;
	wire ie00_e18_we;
	wire ie00_e19_qs;
	wire ie00_e19_wd;
	wire ie00_e19_we;
	wire ie00_e20_qs;
	wire ie00_e20_wd;
	wire ie00_e20_we;
	wire ie00_e21_qs;
	wire ie00_e21_wd;
	wire ie00_e21_we;
	wire ie00_e22_qs;
	wire ie00_e22_wd;
	wire ie00_e22_we;
	wire ie00_e23_qs;
	wire ie00_e23_wd;
	wire ie00_e23_we;
	wire ie00_e24_qs;
	wire ie00_e24_wd;
	wire ie00_e24_we;
	wire ie00_e25_qs;
	wire ie00_e25_wd;
	wire ie00_e25_we;
	wire ie00_e26_qs;
	wire ie00_e26_wd;
	wire ie00_e26_we;
	wire ie00_e27_qs;
	wire ie00_e27_wd;
	wire ie00_e27_we;
	wire ie00_e28_qs;
	wire ie00_e28_wd;
	wire ie00_e28_we;
	wire ie00_e29_qs;
	wire ie00_e29_wd;
	wire ie00_e29_we;
	wire ie00_e30_qs;
	wire ie00_e30_wd;
	wire ie00_e30_we;
	wire ie00_e31_qs;
	wire ie00_e31_wd;
	wire ie00_e31_we;
	wire ie01_e32_qs;
	wire ie01_e32_wd;
	wire ie01_e32_we;
	wire ie01_e33_qs;
	wire ie01_e33_wd;
	wire ie01_e33_we;
	wire ie01_e34_qs;
	wire ie01_e34_wd;
	wire ie01_e34_we;
	wire ie01_e35_qs;
	wire ie01_e35_wd;
	wire ie01_e35_we;
	wire ie01_e36_qs;
	wire ie01_e36_wd;
	wire ie01_e36_we;
	wire ie01_e37_qs;
	wire ie01_e37_wd;
	wire ie01_e37_we;
	wire ie01_e38_qs;
	wire ie01_e38_wd;
	wire ie01_e38_we;
	wire ie01_e39_qs;
	wire ie01_e39_wd;
	wire ie01_e39_we;
	wire ie01_e40_qs;
	wire ie01_e40_wd;
	wire ie01_e40_we;
	wire ie01_e41_qs;
	wire ie01_e41_wd;
	wire ie01_e41_we;
	wire ie01_e42_qs;
	wire ie01_e42_wd;
	wire ie01_e42_we;
	wire ie01_e43_qs;
	wire ie01_e43_wd;
	wire ie01_e43_we;
	wire ie01_e44_qs;
	wire ie01_e44_wd;
	wire ie01_e44_we;
	wire ie01_e45_qs;
	wire ie01_e45_wd;
	wire ie01_e45_we;
	wire ie01_e46_qs;
	wire ie01_e46_wd;
	wire ie01_e46_we;
	wire ie01_e47_qs;
	wire ie01_e47_wd;
	wire ie01_e47_we;
	wire ie01_e48_qs;
	wire ie01_e48_wd;
	wire ie01_e48_we;
	wire ie01_e49_qs;
	wire ie01_e49_wd;
	wire ie01_e49_we;
	wire ie01_e50_qs;
	wire ie01_e50_wd;
	wire ie01_e50_we;
	wire ie01_e51_qs;
	wire ie01_e51_wd;
	wire ie01_e51_we;
	wire ie01_e52_qs;
	wire ie01_e52_wd;
	wire ie01_e52_we;
	wire ie01_e53_qs;
	wire ie01_e53_wd;
	wire ie01_e53_we;
	wire ie01_e54_qs;
	wire ie01_e54_wd;
	wire ie01_e54_we;
	wire [1:0] threshold0_qs;
	wire [1:0] threshold0_wd;
	wire threshold0_we;
	wire [5:0] cc0_qs;
	wire [5:0] cc0_wd;
	wire cc0_we;
	wire cc0_re;
	wire msip0_qs;
	wire msip0_wd;
	wire msip0_we;
	prim_subreg #(
		.DW(1),
		.SWACCESS("RO"),
		.RESVAL(1'h0)
	) u_ip0_p0(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(1'b0),
		.wd(1'sb0),
		.de(hw2reg[6+:1]),
		.d(hw2reg[7+:1]),
		.qe(),
		.q(),
		.qs(ip0_p0_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RO"),
		.RESVAL(1'h0)
	) u_ip0_p1(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(1'b0),
		.wd(1'sb0),
		.de(hw2reg[8+:1]),
		.d(hw2reg[9+:1]),
		.qe(),
		.q(),
		.qs(ip0_p1_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RO"),
		.RESVAL(1'h0)
	) u_ip0_p2(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(1'b0),
		.wd(1'sb0),
		.de(hw2reg[10+:1]),
		.d(hw2reg[11+:1]),
		.qe(),
		.q(),
		.qs(ip0_p2_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RO"),
		.RESVAL(1'h0)
	) u_ip0_p3(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(1'b0),
		.wd(1'sb0),
		.de(hw2reg[12+:1]),
		.d(hw2reg[13+:1]),
		.qe(),
		.q(),
		.qs(ip0_p3_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RO"),
		.RESVAL(1'h0)
	) u_ip0_p4(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(1'b0),
		.wd(1'sb0),
		.de(hw2reg[14+:1]),
		.d(hw2reg[15+:1]),
		.qe(),
		.q(),
		.qs(ip0_p4_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RO"),
		.RESVAL(1'h0)
	) u_ip0_p5(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(1'b0),
		.wd(1'sb0),
		.de(hw2reg[16+:1]),
		.d(hw2reg[17+:1]),
		.qe(),
		.q(),
		.qs(ip0_p5_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RO"),
		.RESVAL(1'h0)
	) u_ip0_p6(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(1'b0),
		.wd(1'sb0),
		.de(hw2reg[18+:1]),
		.d(hw2reg[19+:1]),
		.qe(),
		.q(),
		.qs(ip0_p6_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RO"),
		.RESVAL(1'h0)
	) u_ip0_p7(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(1'b0),
		.wd(1'sb0),
		.de(hw2reg[20+:1]),
		.d(hw2reg[21+:1]),
		.qe(),
		.q(),
		.qs(ip0_p7_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RO"),
		.RESVAL(1'h0)
	) u_ip0_p8(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(1'b0),
		.wd(1'sb0),
		.de(hw2reg[22+:1]),
		.d(hw2reg[23+:1]),
		.qe(),
		.q(),
		.qs(ip0_p8_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RO"),
		.RESVAL(1'h0)
	) u_ip0_p9(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(1'b0),
		.wd(1'sb0),
		.de(hw2reg[24+:1]),
		.d(hw2reg[25+:1]),
		.qe(),
		.q(),
		.qs(ip0_p9_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RO"),
		.RESVAL(1'h0)
	) u_ip0_p10(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(1'b0),
		.wd(1'sb0),
		.de(hw2reg[26+:1]),
		.d(hw2reg[27+:1]),
		.qe(),
		.q(),
		.qs(ip0_p10_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RO"),
		.RESVAL(1'h0)
	) u_ip0_p11(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(1'b0),
		.wd(1'sb0),
		.de(hw2reg[28+:1]),
		.d(hw2reg[29+:1]),
		.qe(),
		.q(),
		.qs(ip0_p11_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RO"),
		.RESVAL(1'h0)
	) u_ip0_p12(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(1'b0),
		.wd(1'sb0),
		.de(hw2reg[30+:1]),
		.d(hw2reg[31+:1]),
		.qe(),
		.q(),
		.qs(ip0_p12_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RO"),
		.RESVAL(1'h0)
	) u_ip0_p13(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(1'b0),
		.wd(1'sb0),
		.de(hw2reg[32+:1]),
		.d(hw2reg[33+:1]),
		.qe(),
		.q(),
		.qs(ip0_p13_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RO"),
		.RESVAL(1'h0)
	) u_ip0_p14(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(1'b0),
		.wd(1'sb0),
		.de(hw2reg[34+:1]),
		.d(hw2reg[35+:1]),
		.qe(),
		.q(),
		.qs(ip0_p14_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RO"),
		.RESVAL(1'h0)
	) u_ip0_p15(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(1'b0),
		.wd(1'sb0),
		.de(hw2reg[36+:1]),
		.d(hw2reg[37+:1]),
		.qe(),
		.q(),
		.qs(ip0_p15_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RO"),
		.RESVAL(1'h0)
	) u_ip0_p16(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(1'b0),
		.wd(1'sb0),
		.de(hw2reg[38+:1]),
		.d(hw2reg[39+:1]),
		.qe(),
		.q(),
		.qs(ip0_p16_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RO"),
		.RESVAL(1'h0)
	) u_ip0_p17(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(1'b0),
		.wd(1'sb0),
		.de(hw2reg[40+:1]),
		.d(hw2reg[41+:1]),
		.qe(),
		.q(),
		.qs(ip0_p17_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RO"),
		.RESVAL(1'h0)
	) u_ip0_p18(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(1'b0),
		.wd(1'sb0),
		.de(hw2reg[42+:1]),
		.d(hw2reg[43+:1]),
		.qe(),
		.q(),
		.qs(ip0_p18_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RO"),
		.RESVAL(1'h0)
	) u_ip0_p19(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(1'b0),
		.wd(1'sb0),
		.de(hw2reg[44+:1]),
		.d(hw2reg[45+:1]),
		.qe(),
		.q(),
		.qs(ip0_p19_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RO"),
		.RESVAL(1'h0)
	) u_ip0_p20(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(1'b0),
		.wd(1'sb0),
		.de(hw2reg[46+:1]),
		.d(hw2reg[47+:1]),
		.qe(),
		.q(),
		.qs(ip0_p20_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RO"),
		.RESVAL(1'h0)
	) u_ip0_p21(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(1'b0),
		.wd(1'sb0),
		.de(hw2reg[48+:1]),
		.d(hw2reg[49+:1]),
		.qe(),
		.q(),
		.qs(ip0_p21_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RO"),
		.RESVAL(1'h0)
	) u_ip0_p22(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(1'b0),
		.wd(1'sb0),
		.de(hw2reg[50+:1]),
		.d(hw2reg[51+:1]),
		.qe(),
		.q(),
		.qs(ip0_p22_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RO"),
		.RESVAL(1'h0)
	) u_ip0_p23(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(1'b0),
		.wd(1'sb0),
		.de(hw2reg[52+:1]),
		.d(hw2reg[53+:1]),
		.qe(),
		.q(),
		.qs(ip0_p23_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RO"),
		.RESVAL(1'h0)
	) u_ip0_p24(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(1'b0),
		.wd(1'sb0),
		.de(hw2reg[54+:1]),
		.d(hw2reg[55+:1]),
		.qe(),
		.q(),
		.qs(ip0_p24_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RO"),
		.RESVAL(1'h0)
	) u_ip0_p25(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(1'b0),
		.wd(1'sb0),
		.de(hw2reg[56+:1]),
		.d(hw2reg[57+:1]),
		.qe(),
		.q(),
		.qs(ip0_p25_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RO"),
		.RESVAL(1'h0)
	) u_ip0_p26(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(1'b0),
		.wd(1'sb0),
		.de(hw2reg[58+:1]),
		.d(hw2reg[59+:1]),
		.qe(),
		.q(),
		.qs(ip0_p26_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RO"),
		.RESVAL(1'h0)
	) u_ip0_p27(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(1'b0),
		.wd(1'sb0),
		.de(hw2reg[60+:1]),
		.d(hw2reg[61+:1]),
		.qe(),
		.q(),
		.qs(ip0_p27_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RO"),
		.RESVAL(1'h0)
	) u_ip0_p28(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(1'b0),
		.wd(1'sb0),
		.de(hw2reg[62+:1]),
		.d(hw2reg[63+:1]),
		.qe(),
		.q(),
		.qs(ip0_p28_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RO"),
		.RESVAL(1'h0)
	) u_ip0_p29(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(1'b0),
		.wd(1'sb0),
		.de(hw2reg[64+:1]),
		.d(hw2reg[65+:1]),
		.qe(),
		.q(),
		.qs(ip0_p29_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RO"),
		.RESVAL(1'h0)
	) u_ip0_p30(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(1'b0),
		.wd(1'sb0),
		.de(hw2reg[66+:1]),
		.d(hw2reg[67+:1]),
		.qe(),
		.q(),
		.qs(ip0_p30_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RO"),
		.RESVAL(1'h0)
	) u_ip0_p31(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(1'b0),
		.wd(1'sb0),
		.de(hw2reg[68+:1]),
		.d(hw2reg[69+:1]),
		.qe(),
		.q(),
		.qs(ip0_p31_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RO"),
		.RESVAL(1'h0)
	) u_ip1_p32(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(1'b0),
		.wd(1'sb0),
		.de(hw2reg[70+:1]),
		.d(hw2reg[71+:1]),
		.qe(),
		.q(),
		.qs(ip1_p32_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RO"),
		.RESVAL(1'h0)
	) u_ip1_p33(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(1'b0),
		.wd(1'sb0),
		.de(hw2reg[72+:1]),
		.d(hw2reg[73+:1]),
		.qe(),
		.q(),
		.qs(ip1_p33_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RO"),
		.RESVAL(1'h0)
	) u_ip1_p34(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(1'b0),
		.wd(1'sb0),
		.de(hw2reg[74+:1]),
		.d(hw2reg[75+:1]),
		.qe(),
		.q(),
		.qs(ip1_p34_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RO"),
		.RESVAL(1'h0)
	) u_ip1_p35(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(1'b0),
		.wd(1'sb0),
		.de(hw2reg[76+:1]),
		.d(hw2reg[77+:1]),
		.qe(),
		.q(),
		.qs(ip1_p35_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RO"),
		.RESVAL(1'h0)
	) u_ip1_p36(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(1'b0),
		.wd(1'sb0),
		.de(hw2reg[78+:1]),
		.d(hw2reg[79+:1]),
		.qe(),
		.q(),
		.qs(ip1_p36_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RO"),
		.RESVAL(1'h0)
	) u_ip1_p37(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(1'b0),
		.wd(1'sb0),
		.de(hw2reg[80+:1]),
		.d(hw2reg[81+:1]),
		.qe(),
		.q(),
		.qs(ip1_p37_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RO"),
		.RESVAL(1'h0)
	) u_ip1_p38(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(1'b0),
		.wd(1'sb0),
		.de(hw2reg[82+:1]),
		.d(hw2reg[83+:1]),
		.qe(),
		.q(),
		.qs(ip1_p38_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RO"),
		.RESVAL(1'h0)
	) u_ip1_p39(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(1'b0),
		.wd(1'sb0),
		.de(hw2reg[84+:1]),
		.d(hw2reg[85+:1]),
		.qe(),
		.q(),
		.qs(ip1_p39_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RO"),
		.RESVAL(1'h0)
	) u_ip1_p40(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(1'b0),
		.wd(1'sb0),
		.de(hw2reg[86+:1]),
		.d(hw2reg[87+:1]),
		.qe(),
		.q(),
		.qs(ip1_p40_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RO"),
		.RESVAL(1'h0)
	) u_ip1_p41(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(1'b0),
		.wd(1'sb0),
		.de(hw2reg[88+:1]),
		.d(hw2reg[89+:1]),
		.qe(),
		.q(),
		.qs(ip1_p41_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RO"),
		.RESVAL(1'h0)
	) u_ip1_p42(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(1'b0),
		.wd(1'sb0),
		.de(hw2reg[90+:1]),
		.d(hw2reg[91+:1]),
		.qe(),
		.q(),
		.qs(ip1_p42_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RO"),
		.RESVAL(1'h0)
	) u_ip1_p43(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(1'b0),
		.wd(1'sb0),
		.de(hw2reg[92+:1]),
		.d(hw2reg[93+:1]),
		.qe(),
		.q(),
		.qs(ip1_p43_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RO"),
		.RESVAL(1'h0)
	) u_ip1_p44(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(1'b0),
		.wd(1'sb0),
		.de(hw2reg[94+:1]),
		.d(hw2reg[95+:1]),
		.qe(),
		.q(),
		.qs(ip1_p44_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RO"),
		.RESVAL(1'h0)
	) u_ip1_p45(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(1'b0),
		.wd(1'sb0),
		.de(hw2reg[96+:1]),
		.d(hw2reg[97+:1]),
		.qe(),
		.q(),
		.qs(ip1_p45_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RO"),
		.RESVAL(1'h0)
	) u_ip1_p46(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(1'b0),
		.wd(1'sb0),
		.de(hw2reg[98+:1]),
		.d(hw2reg[99+:1]),
		.qe(),
		.q(),
		.qs(ip1_p46_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RO"),
		.RESVAL(1'h0)
	) u_ip1_p47(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(1'b0),
		.wd(1'sb0),
		.de(hw2reg[100+:1]),
		.d(hw2reg[101+:1]),
		.qe(),
		.q(),
		.qs(ip1_p47_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RO"),
		.RESVAL(1'h0)
	) u_ip1_p48(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(1'b0),
		.wd(1'sb0),
		.de(hw2reg[102+:1]),
		.d(hw2reg[103+:1]),
		.qe(),
		.q(),
		.qs(ip1_p48_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RO"),
		.RESVAL(1'h0)
	) u_ip1_p49(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(1'b0),
		.wd(1'sb0),
		.de(hw2reg[104+:1]),
		.d(hw2reg[105+:1]),
		.qe(),
		.q(),
		.qs(ip1_p49_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RO"),
		.RESVAL(1'h0)
	) u_ip1_p50(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(1'b0),
		.wd(1'sb0),
		.de(hw2reg[106+:1]),
		.d(hw2reg[107+:1]),
		.qe(),
		.q(),
		.qs(ip1_p50_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RO"),
		.RESVAL(1'h0)
	) u_ip1_p51(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(1'b0),
		.wd(1'sb0),
		.de(hw2reg[108+:1]),
		.d(hw2reg[109+:1]),
		.qe(),
		.q(),
		.qs(ip1_p51_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RO"),
		.RESVAL(1'h0)
	) u_ip1_p52(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(1'b0),
		.wd(1'sb0),
		.de(hw2reg[110+:1]),
		.d(hw2reg[111+:1]),
		.qe(),
		.q(),
		.qs(ip1_p52_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RO"),
		.RESVAL(1'h0)
	) u_ip1_p53(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(1'b0),
		.wd(1'sb0),
		.de(hw2reg[112+:1]),
		.d(hw2reg[113+:1]),
		.qe(),
		.q(),
		.qs(ip1_p53_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RO"),
		.RESVAL(1'h0)
	) u_ip1_p54(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(1'b0),
		.wd(1'sb0),
		.de(hw2reg[114+:1]),
		.d(hw2reg[115+:1]),
		.qe(),
		.q(),
		.qs(ip1_p54_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RW"),
		.RESVAL(1'h0)
	) u_le0_le0(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(le0_le0_we),
		.wd(le0_le0_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[176+:1]),
		.qs(le0_le0_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RW"),
		.RESVAL(1'h0)
	) u_le0_le1(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(le0_le1_we),
		.wd(le0_le1_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[177+:1]),
		.qs(le0_le1_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RW"),
		.RESVAL(1'h0)
	) u_le0_le2(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(le0_le2_we),
		.wd(le0_le2_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[178+:1]),
		.qs(le0_le2_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RW"),
		.RESVAL(1'h0)
	) u_le0_le3(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(le0_le3_we),
		.wd(le0_le3_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[179+:1]),
		.qs(le0_le3_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RW"),
		.RESVAL(1'h0)
	) u_le0_le4(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(le0_le4_we),
		.wd(le0_le4_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[180+:1]),
		.qs(le0_le4_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RW"),
		.RESVAL(1'h0)
	) u_le0_le5(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(le0_le5_we),
		.wd(le0_le5_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[181+:1]),
		.qs(le0_le5_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RW"),
		.RESVAL(1'h0)
	) u_le0_le6(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(le0_le6_we),
		.wd(le0_le6_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[182+:1]),
		.qs(le0_le6_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RW"),
		.RESVAL(1'h0)
	) u_le0_le7(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(le0_le7_we),
		.wd(le0_le7_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[183+:1]),
		.qs(le0_le7_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RW"),
		.RESVAL(1'h0)
	) u_le0_le8(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(le0_le8_we),
		.wd(le0_le8_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[184+:1]),
		.qs(le0_le8_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RW"),
		.RESVAL(1'h0)
	) u_le0_le9(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(le0_le9_we),
		.wd(le0_le9_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[185+:1]),
		.qs(le0_le9_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RW"),
		.RESVAL(1'h0)
	) u_le0_le10(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(le0_le10_we),
		.wd(le0_le10_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[186+:1]),
		.qs(le0_le10_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RW"),
		.RESVAL(1'h0)
	) u_le0_le11(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(le0_le11_we),
		.wd(le0_le11_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[187+:1]),
		.qs(le0_le11_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RW"),
		.RESVAL(1'h0)
	) u_le0_le12(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(le0_le12_we),
		.wd(le0_le12_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[188+:1]),
		.qs(le0_le12_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RW"),
		.RESVAL(1'h0)
	) u_le0_le13(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(le0_le13_we),
		.wd(le0_le13_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[189+:1]),
		.qs(le0_le13_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RW"),
		.RESVAL(1'h0)
	) u_le0_le14(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(le0_le14_we),
		.wd(le0_le14_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[190+:1]),
		.qs(le0_le14_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RW"),
		.RESVAL(1'h0)
	) u_le0_le15(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(le0_le15_we),
		.wd(le0_le15_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[191+:1]),
		.qs(le0_le15_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RW"),
		.RESVAL(1'h0)
	) u_le0_le16(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(le0_le16_we),
		.wd(le0_le16_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[192+:1]),
		.qs(le0_le16_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RW"),
		.RESVAL(1'h0)
	) u_le0_le17(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(le0_le17_we),
		.wd(le0_le17_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[193+:1]),
		.qs(le0_le17_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RW"),
		.RESVAL(1'h0)
	) u_le0_le18(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(le0_le18_we),
		.wd(le0_le18_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[194+:1]),
		.qs(le0_le18_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RW"),
		.RESVAL(1'h0)
	) u_le0_le19(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(le0_le19_we),
		.wd(le0_le19_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[195+:1]),
		.qs(le0_le19_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RW"),
		.RESVAL(1'h0)
	) u_le0_le20(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(le0_le20_we),
		.wd(le0_le20_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[196+:1]),
		.qs(le0_le20_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RW"),
		.RESVAL(1'h0)
	) u_le0_le21(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(le0_le21_we),
		.wd(le0_le21_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[197+:1]),
		.qs(le0_le21_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RW"),
		.RESVAL(1'h0)
	) u_le0_le22(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(le0_le22_we),
		.wd(le0_le22_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[198+:1]),
		.qs(le0_le22_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RW"),
		.RESVAL(1'h0)
	) u_le0_le23(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(le0_le23_we),
		.wd(le0_le23_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[199+:1]),
		.qs(le0_le23_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RW"),
		.RESVAL(1'h0)
	) u_le0_le24(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(le0_le24_we),
		.wd(le0_le24_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[200+:1]),
		.qs(le0_le24_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RW"),
		.RESVAL(1'h0)
	) u_le0_le25(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(le0_le25_we),
		.wd(le0_le25_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[201+:1]),
		.qs(le0_le25_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RW"),
		.RESVAL(1'h0)
	) u_le0_le26(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(le0_le26_we),
		.wd(le0_le26_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[202+:1]),
		.qs(le0_le26_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RW"),
		.RESVAL(1'h0)
	) u_le0_le27(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(le0_le27_we),
		.wd(le0_le27_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[203+:1]),
		.qs(le0_le27_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RW"),
		.RESVAL(1'h0)
	) u_le0_le28(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(le0_le28_we),
		.wd(le0_le28_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[204+:1]),
		.qs(le0_le28_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RW"),
		.RESVAL(1'h0)
	) u_le0_le29(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(le0_le29_we),
		.wd(le0_le29_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[205+:1]),
		.qs(le0_le29_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RW"),
		.RESVAL(1'h0)
	) u_le0_le30(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(le0_le30_we),
		.wd(le0_le30_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[206+:1]),
		.qs(le0_le30_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RW"),
		.RESVAL(1'h0)
	) u_le0_le31(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(le0_le31_we),
		.wd(le0_le31_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[207+:1]),
		.qs(le0_le31_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RW"),
		.RESVAL(1'h0)
	) u_le1_le32(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(le1_le32_we),
		.wd(le1_le32_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[208+:1]),
		.qs(le1_le32_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RW"),
		.RESVAL(1'h0)
	) u_le1_le33(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(le1_le33_we),
		.wd(le1_le33_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[209+:1]),
		.qs(le1_le33_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RW"),
		.RESVAL(1'h0)
	) u_le1_le34(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(le1_le34_we),
		.wd(le1_le34_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[210+:1]),
		.qs(le1_le34_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RW"),
		.RESVAL(1'h0)
	) u_le1_le35(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(le1_le35_we),
		.wd(le1_le35_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[211+:1]),
		.qs(le1_le35_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RW"),
		.RESVAL(1'h0)
	) u_le1_le36(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(le1_le36_we),
		.wd(le1_le36_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[212+:1]),
		.qs(le1_le36_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RW"),
		.RESVAL(1'h0)
	) u_le1_le37(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(le1_le37_we),
		.wd(le1_le37_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[213+:1]),
		.qs(le1_le37_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RW"),
		.RESVAL(1'h0)
	) u_le1_le38(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(le1_le38_we),
		.wd(le1_le38_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[214+:1]),
		.qs(le1_le38_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RW"),
		.RESVAL(1'h0)
	) u_le1_le39(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(le1_le39_we),
		.wd(le1_le39_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[215+:1]),
		.qs(le1_le39_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RW"),
		.RESVAL(1'h0)
	) u_le1_le40(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(le1_le40_we),
		.wd(le1_le40_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[216+:1]),
		.qs(le1_le40_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RW"),
		.RESVAL(1'h0)
	) u_le1_le41(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(le1_le41_we),
		.wd(le1_le41_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[217+:1]),
		.qs(le1_le41_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RW"),
		.RESVAL(1'h0)
	) u_le1_le42(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(le1_le42_we),
		.wd(le1_le42_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[218+:1]),
		.qs(le1_le42_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RW"),
		.RESVAL(1'h0)
	) u_le1_le43(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(le1_le43_we),
		.wd(le1_le43_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[219+:1]),
		.qs(le1_le43_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RW"),
		.RESVAL(1'h0)
	) u_le1_le44(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(le1_le44_we),
		.wd(le1_le44_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[220+:1]),
		.qs(le1_le44_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RW"),
		.RESVAL(1'h0)
	) u_le1_le45(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(le1_le45_we),
		.wd(le1_le45_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[221+:1]),
		.qs(le1_le45_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RW"),
		.RESVAL(1'h0)
	) u_le1_le46(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(le1_le46_we),
		.wd(le1_le46_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[222+:1]),
		.qs(le1_le46_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RW"),
		.RESVAL(1'h0)
	) u_le1_le47(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(le1_le47_we),
		.wd(le1_le47_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[223+:1]),
		.qs(le1_le47_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RW"),
		.RESVAL(1'h0)
	) u_le1_le48(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(le1_le48_we),
		.wd(le1_le48_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[224+:1]),
		.qs(le1_le48_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RW"),
		.RESVAL(1'h0)
	) u_le1_le49(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(le1_le49_we),
		.wd(le1_le49_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[225+:1]),
		.qs(le1_le49_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RW"),
		.RESVAL(1'h0)
	) u_le1_le50(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(le1_le50_we),
		.wd(le1_le50_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[226+:1]),
		.qs(le1_le50_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RW"),
		.RESVAL(1'h0)
	) u_le1_le51(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(le1_le51_we),
		.wd(le1_le51_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[227+:1]),
		.qs(le1_le51_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RW"),
		.RESVAL(1'h0)
	) u_le1_le52(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(le1_le52_we),
		.wd(le1_le52_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[228+:1]),
		.qs(le1_le52_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RW"),
		.RESVAL(1'h0)
	) u_le1_le53(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(le1_le53_we),
		.wd(le1_le53_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[229+:1]),
		.qs(le1_le53_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RW"),
		.RESVAL(1'h0)
	) u_le1_le54(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(le1_le54_we),
		.wd(le1_le54_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[230+:1]),
		.qs(le1_le54_qs)
	);
	prim_subreg #(
		.DW(2),
		.SWACCESS("RW"),
		.RESVAL(2'h0)
	) u_prio0(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(prio0_we),
		.wd(prio0_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[175:174]),
		.qs(prio0_qs)
	);
	prim_subreg #(
		.DW(2),
		.SWACCESS("RW"),
		.RESVAL(2'h0)
	) u_prio1(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(prio1_we),
		.wd(prio1_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[173:172]),
		.qs(prio1_qs)
	);
	prim_subreg #(
		.DW(2),
		.SWACCESS("RW"),
		.RESVAL(2'h0)
	) u_prio2(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(prio2_we),
		.wd(prio2_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[171:170]),
		.qs(prio2_qs)
	);
	prim_subreg #(
		.DW(2),
		.SWACCESS("RW"),
		.RESVAL(2'h0)
	) u_prio3(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(prio3_we),
		.wd(prio3_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[169:168]),
		.qs(prio3_qs)
	);
	prim_subreg #(
		.DW(2),
		.SWACCESS("RW"),
		.RESVAL(2'h0)
	) u_prio4(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(prio4_we),
		.wd(prio4_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[167:166]),
		.qs(prio4_qs)
	);
	prim_subreg #(
		.DW(2),
		.SWACCESS("RW"),
		.RESVAL(2'h0)
	) u_prio5(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(prio5_we),
		.wd(prio5_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[165:164]),
		.qs(prio5_qs)
	);
	prim_subreg #(
		.DW(2),
		.SWACCESS("RW"),
		.RESVAL(2'h0)
	) u_prio6(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(prio6_we),
		.wd(prio6_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[163:162]),
		.qs(prio6_qs)
	);
	prim_subreg #(
		.DW(2),
		.SWACCESS("RW"),
		.RESVAL(2'h0)
	) u_prio7(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(prio7_we),
		.wd(prio7_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[161:160]),
		.qs(prio7_qs)
	);
	prim_subreg #(
		.DW(2),
		.SWACCESS("RW"),
		.RESVAL(2'h0)
	) u_prio8(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(prio8_we),
		.wd(prio8_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[159:158]),
		.qs(prio8_qs)
	);
	prim_subreg #(
		.DW(2),
		.SWACCESS("RW"),
		.RESVAL(2'h0)
	) u_prio9(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(prio9_we),
		.wd(prio9_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[157:156]),
		.qs(prio9_qs)
	);
	prim_subreg #(
		.DW(2),
		.SWACCESS("RW"),
		.RESVAL(2'h0)
	) u_prio10(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(prio10_we),
		.wd(prio10_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[155:154]),
		.qs(prio10_qs)
	);
	prim_subreg #(
		.DW(2),
		.SWACCESS("RW"),
		.RESVAL(2'h0)
	) u_prio11(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(prio11_we),
		.wd(prio11_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[153:152]),
		.qs(prio11_qs)
	);
	prim_subreg #(
		.DW(2),
		.SWACCESS("RW"),
		.RESVAL(2'h0)
	) u_prio12(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(prio12_we),
		.wd(prio12_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[151:150]),
		.qs(prio12_qs)
	);
	prim_subreg #(
		.DW(2),
		.SWACCESS("RW"),
		.RESVAL(2'h0)
	) u_prio13(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(prio13_we),
		.wd(prio13_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[149:148]),
		.qs(prio13_qs)
	);
	prim_subreg #(
		.DW(2),
		.SWACCESS("RW"),
		.RESVAL(2'h0)
	) u_prio14(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(prio14_we),
		.wd(prio14_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[147:146]),
		.qs(prio14_qs)
	);
	prim_subreg #(
		.DW(2),
		.SWACCESS("RW"),
		.RESVAL(2'h0)
	) u_prio15(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(prio15_we),
		.wd(prio15_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[145:144]),
		.qs(prio15_qs)
	);
	prim_subreg #(
		.DW(2),
		.SWACCESS("RW"),
		.RESVAL(2'h0)
	) u_prio16(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(prio16_we),
		.wd(prio16_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[143:142]),
		.qs(prio16_qs)
	);
	prim_subreg #(
		.DW(2),
		.SWACCESS("RW"),
		.RESVAL(2'h0)
	) u_prio17(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(prio17_we),
		.wd(prio17_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[141:140]),
		.qs(prio17_qs)
	);
	prim_subreg #(
		.DW(2),
		.SWACCESS("RW"),
		.RESVAL(2'h0)
	) u_prio18(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(prio18_we),
		.wd(prio18_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[139:138]),
		.qs(prio18_qs)
	);
	prim_subreg #(
		.DW(2),
		.SWACCESS("RW"),
		.RESVAL(2'h0)
	) u_prio19(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(prio19_we),
		.wd(prio19_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[137:136]),
		.qs(prio19_qs)
	);
	prim_subreg #(
		.DW(2),
		.SWACCESS("RW"),
		.RESVAL(2'h0)
	) u_prio20(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(prio20_we),
		.wd(prio20_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[135:134]),
		.qs(prio20_qs)
	);
	prim_subreg #(
		.DW(2),
		.SWACCESS("RW"),
		.RESVAL(2'h0)
	) u_prio21(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(prio21_we),
		.wd(prio21_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[133:132]),
		.qs(prio21_qs)
	);
	prim_subreg #(
		.DW(2),
		.SWACCESS("RW"),
		.RESVAL(2'h0)
	) u_prio22(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(prio22_we),
		.wd(prio22_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[131:130]),
		.qs(prio22_qs)
	);
	prim_subreg #(
		.DW(2),
		.SWACCESS("RW"),
		.RESVAL(2'h0)
	) u_prio23(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(prio23_we),
		.wd(prio23_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[129:128]),
		.qs(prio23_qs)
	);
	prim_subreg #(
		.DW(2),
		.SWACCESS("RW"),
		.RESVAL(2'h0)
	) u_prio24(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(prio24_we),
		.wd(prio24_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[127:126]),
		.qs(prio24_qs)
	);
	prim_subreg #(
		.DW(2),
		.SWACCESS("RW"),
		.RESVAL(2'h0)
	) u_prio25(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(prio25_we),
		.wd(prio25_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[125:124]),
		.qs(prio25_qs)
	);
	prim_subreg #(
		.DW(2),
		.SWACCESS("RW"),
		.RESVAL(2'h0)
	) u_prio26(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(prio26_we),
		.wd(prio26_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[123:122]),
		.qs(prio26_qs)
	);
	prim_subreg #(
		.DW(2),
		.SWACCESS("RW"),
		.RESVAL(2'h0)
	) u_prio27(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(prio27_we),
		.wd(prio27_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[121:120]),
		.qs(prio27_qs)
	);
	prim_subreg #(
		.DW(2),
		.SWACCESS("RW"),
		.RESVAL(2'h0)
	) u_prio28(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(prio28_we),
		.wd(prio28_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[119:118]),
		.qs(prio28_qs)
	);
	prim_subreg #(
		.DW(2),
		.SWACCESS("RW"),
		.RESVAL(2'h0)
	) u_prio29(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(prio29_we),
		.wd(prio29_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[117:116]),
		.qs(prio29_qs)
	);
	prim_subreg #(
		.DW(2),
		.SWACCESS("RW"),
		.RESVAL(2'h0)
	) u_prio30(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(prio30_we),
		.wd(prio30_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[115:114]),
		.qs(prio30_qs)
	);
	prim_subreg #(
		.DW(2),
		.SWACCESS("RW"),
		.RESVAL(2'h0)
	) u_prio31(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(prio31_we),
		.wd(prio31_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[113:112]),
		.qs(prio31_qs)
	);
	prim_subreg #(
		.DW(2),
		.SWACCESS("RW"),
		.RESVAL(2'h0)
	) u_prio32(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(prio32_we),
		.wd(prio32_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[111:110]),
		.qs(prio32_qs)
	);
	prim_subreg #(
		.DW(2),
		.SWACCESS("RW"),
		.RESVAL(2'h0)
	) u_prio33(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(prio33_we),
		.wd(prio33_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[109:108]),
		.qs(prio33_qs)
	);
	prim_subreg #(
		.DW(2),
		.SWACCESS("RW"),
		.RESVAL(2'h0)
	) u_prio34(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(prio34_we),
		.wd(prio34_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[107:106]),
		.qs(prio34_qs)
	);
	prim_subreg #(
		.DW(2),
		.SWACCESS("RW"),
		.RESVAL(2'h0)
	) u_prio35(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(prio35_we),
		.wd(prio35_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[105:104]),
		.qs(prio35_qs)
	);
	prim_subreg #(
		.DW(2),
		.SWACCESS("RW"),
		.RESVAL(2'h0)
	) u_prio36(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(prio36_we),
		.wd(prio36_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[103:102]),
		.qs(prio36_qs)
	);
	prim_subreg #(
		.DW(2),
		.SWACCESS("RW"),
		.RESVAL(2'h0)
	) u_prio37(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(prio37_we),
		.wd(prio37_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[101:100]),
		.qs(prio37_qs)
	);
	prim_subreg #(
		.DW(2),
		.SWACCESS("RW"),
		.RESVAL(2'h0)
	) u_prio38(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(prio38_we),
		.wd(prio38_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[99:98]),
		.qs(prio38_qs)
	);
	prim_subreg #(
		.DW(2),
		.SWACCESS("RW"),
		.RESVAL(2'h0)
	) u_prio39(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(prio39_we),
		.wd(prio39_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[97:96]),
		.qs(prio39_qs)
	);
	prim_subreg #(
		.DW(2),
		.SWACCESS("RW"),
		.RESVAL(2'h0)
	) u_prio40(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(prio40_we),
		.wd(prio40_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[95:94]),
		.qs(prio40_qs)
	);
	prim_subreg #(
		.DW(2),
		.SWACCESS("RW"),
		.RESVAL(2'h0)
	) u_prio41(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(prio41_we),
		.wd(prio41_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[93:92]),
		.qs(prio41_qs)
	);
	prim_subreg #(
		.DW(2),
		.SWACCESS("RW"),
		.RESVAL(2'h0)
	) u_prio42(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(prio42_we),
		.wd(prio42_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[91:90]),
		.qs(prio42_qs)
	);
	prim_subreg #(
		.DW(2),
		.SWACCESS("RW"),
		.RESVAL(2'h0)
	) u_prio43(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(prio43_we),
		.wd(prio43_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[89:88]),
		.qs(prio43_qs)
	);
	prim_subreg #(
		.DW(2),
		.SWACCESS("RW"),
		.RESVAL(2'h0)
	) u_prio44(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(prio44_we),
		.wd(prio44_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[87:86]),
		.qs(prio44_qs)
	);
	prim_subreg #(
		.DW(2),
		.SWACCESS("RW"),
		.RESVAL(2'h0)
	) u_prio45(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(prio45_we),
		.wd(prio45_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[85:84]),
		.qs(prio45_qs)
	);
	prim_subreg #(
		.DW(2),
		.SWACCESS("RW"),
		.RESVAL(2'h0)
	) u_prio46(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(prio46_we),
		.wd(prio46_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[83:82]),
		.qs(prio46_qs)
	);
	prim_subreg #(
		.DW(2),
		.SWACCESS("RW"),
		.RESVAL(2'h0)
	) u_prio47(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(prio47_we),
		.wd(prio47_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[81:80]),
		.qs(prio47_qs)
	);
	prim_subreg #(
		.DW(2),
		.SWACCESS("RW"),
		.RESVAL(2'h0)
	) u_prio48(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(prio48_we),
		.wd(prio48_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[79:78]),
		.qs(prio48_qs)
	);
	prim_subreg #(
		.DW(2),
		.SWACCESS("RW"),
		.RESVAL(2'h0)
	) u_prio49(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(prio49_we),
		.wd(prio49_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[77:76]),
		.qs(prio49_qs)
	);
	prim_subreg #(
		.DW(2),
		.SWACCESS("RW"),
		.RESVAL(2'h0)
	) u_prio50(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(prio50_we),
		.wd(prio50_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[75:74]),
		.qs(prio50_qs)
	);
	prim_subreg #(
		.DW(2),
		.SWACCESS("RW"),
		.RESVAL(2'h0)
	) u_prio51(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(prio51_we),
		.wd(prio51_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[73:72]),
		.qs(prio51_qs)
	);
	prim_subreg #(
		.DW(2),
		.SWACCESS("RW"),
		.RESVAL(2'h0)
	) u_prio52(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(prio52_we),
		.wd(prio52_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[71:70]),
		.qs(prio52_qs)
	);
	prim_subreg #(
		.DW(2),
		.SWACCESS("RW"),
		.RESVAL(2'h0)
	) u_prio53(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(prio53_we),
		.wd(prio53_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[69:68]),
		.qs(prio53_qs)
	);
	prim_subreg #(
		.DW(2),
		.SWACCESS("RW"),
		.RESVAL(2'h0)
	) u_prio54(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(prio54_we),
		.wd(prio54_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[67:66]),
		.qs(prio54_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RW"),
		.RESVAL(1'h0)
	) u_ie00_e0(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(ie00_e0_we),
		.wd(ie00_e0_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[11+:1]),
		.qs(ie00_e0_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RW"),
		.RESVAL(1'h0)
	) u_ie00_e1(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(ie00_e1_we),
		.wd(ie00_e1_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[12+:1]),
		.qs(ie00_e1_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RW"),
		.RESVAL(1'h0)
	) u_ie00_e2(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(ie00_e2_we),
		.wd(ie00_e2_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[13+:1]),
		.qs(ie00_e2_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RW"),
		.RESVAL(1'h0)
	) u_ie00_e3(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(ie00_e3_we),
		.wd(ie00_e3_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[14+:1]),
		.qs(ie00_e3_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RW"),
		.RESVAL(1'h0)
	) u_ie00_e4(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(ie00_e4_we),
		.wd(ie00_e4_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[15+:1]),
		.qs(ie00_e4_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RW"),
		.RESVAL(1'h0)
	) u_ie00_e5(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(ie00_e5_we),
		.wd(ie00_e5_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[16+:1]),
		.qs(ie00_e5_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RW"),
		.RESVAL(1'h0)
	) u_ie00_e6(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(ie00_e6_we),
		.wd(ie00_e6_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[17+:1]),
		.qs(ie00_e6_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RW"),
		.RESVAL(1'h0)
	) u_ie00_e7(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(ie00_e7_we),
		.wd(ie00_e7_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[18+:1]),
		.qs(ie00_e7_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RW"),
		.RESVAL(1'h0)
	) u_ie00_e8(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(ie00_e8_we),
		.wd(ie00_e8_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[19+:1]),
		.qs(ie00_e8_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RW"),
		.RESVAL(1'h0)
	) u_ie00_e9(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(ie00_e9_we),
		.wd(ie00_e9_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[20+:1]),
		.qs(ie00_e9_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RW"),
		.RESVAL(1'h0)
	) u_ie00_e10(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(ie00_e10_we),
		.wd(ie00_e10_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[21+:1]),
		.qs(ie00_e10_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RW"),
		.RESVAL(1'h0)
	) u_ie00_e11(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(ie00_e11_we),
		.wd(ie00_e11_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[22+:1]),
		.qs(ie00_e11_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RW"),
		.RESVAL(1'h0)
	) u_ie00_e12(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(ie00_e12_we),
		.wd(ie00_e12_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[23+:1]),
		.qs(ie00_e12_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RW"),
		.RESVAL(1'h0)
	) u_ie00_e13(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(ie00_e13_we),
		.wd(ie00_e13_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[24+:1]),
		.qs(ie00_e13_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RW"),
		.RESVAL(1'h0)
	) u_ie00_e14(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(ie00_e14_we),
		.wd(ie00_e14_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[25+:1]),
		.qs(ie00_e14_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RW"),
		.RESVAL(1'h0)
	) u_ie00_e15(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(ie00_e15_we),
		.wd(ie00_e15_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[26+:1]),
		.qs(ie00_e15_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RW"),
		.RESVAL(1'h0)
	) u_ie00_e16(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(ie00_e16_we),
		.wd(ie00_e16_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[27+:1]),
		.qs(ie00_e16_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RW"),
		.RESVAL(1'h0)
	) u_ie00_e17(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(ie00_e17_we),
		.wd(ie00_e17_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[28+:1]),
		.qs(ie00_e17_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RW"),
		.RESVAL(1'h0)
	) u_ie00_e18(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(ie00_e18_we),
		.wd(ie00_e18_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[29+:1]),
		.qs(ie00_e18_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RW"),
		.RESVAL(1'h0)
	) u_ie00_e19(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(ie00_e19_we),
		.wd(ie00_e19_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[30+:1]),
		.qs(ie00_e19_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RW"),
		.RESVAL(1'h0)
	) u_ie00_e20(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(ie00_e20_we),
		.wd(ie00_e20_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[31+:1]),
		.qs(ie00_e20_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RW"),
		.RESVAL(1'h0)
	) u_ie00_e21(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(ie00_e21_we),
		.wd(ie00_e21_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[32+:1]),
		.qs(ie00_e21_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RW"),
		.RESVAL(1'h0)
	) u_ie00_e22(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(ie00_e22_we),
		.wd(ie00_e22_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[33+:1]),
		.qs(ie00_e22_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RW"),
		.RESVAL(1'h0)
	) u_ie00_e23(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(ie00_e23_we),
		.wd(ie00_e23_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[34+:1]),
		.qs(ie00_e23_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RW"),
		.RESVAL(1'h0)
	) u_ie00_e24(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(ie00_e24_we),
		.wd(ie00_e24_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[35+:1]),
		.qs(ie00_e24_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RW"),
		.RESVAL(1'h0)
	) u_ie00_e25(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(ie00_e25_we),
		.wd(ie00_e25_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[36+:1]),
		.qs(ie00_e25_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RW"),
		.RESVAL(1'h0)
	) u_ie00_e26(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(ie00_e26_we),
		.wd(ie00_e26_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[37+:1]),
		.qs(ie00_e26_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RW"),
		.RESVAL(1'h0)
	) u_ie00_e27(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(ie00_e27_we),
		.wd(ie00_e27_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[38+:1]),
		.qs(ie00_e27_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RW"),
		.RESVAL(1'h0)
	) u_ie00_e28(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(ie00_e28_we),
		.wd(ie00_e28_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[39+:1]),
		.qs(ie00_e28_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RW"),
		.RESVAL(1'h0)
	) u_ie00_e29(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(ie00_e29_we),
		.wd(ie00_e29_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[40+:1]),
		.qs(ie00_e29_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RW"),
		.RESVAL(1'h0)
	) u_ie00_e30(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(ie00_e30_we),
		.wd(ie00_e30_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[41+:1]),
		.qs(ie00_e30_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RW"),
		.RESVAL(1'h0)
	) u_ie00_e31(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(ie00_e31_we),
		.wd(ie00_e31_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[42+:1]),
		.qs(ie00_e31_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RW"),
		.RESVAL(1'h0)
	) u_ie01_e32(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(ie01_e32_we),
		.wd(ie01_e32_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[43+:1]),
		.qs(ie01_e32_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RW"),
		.RESVAL(1'h0)
	) u_ie01_e33(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(ie01_e33_we),
		.wd(ie01_e33_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[44+:1]),
		.qs(ie01_e33_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RW"),
		.RESVAL(1'h0)
	) u_ie01_e34(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(ie01_e34_we),
		.wd(ie01_e34_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[45+:1]),
		.qs(ie01_e34_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RW"),
		.RESVAL(1'h0)
	) u_ie01_e35(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(ie01_e35_we),
		.wd(ie01_e35_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[46+:1]),
		.qs(ie01_e35_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RW"),
		.RESVAL(1'h0)
	) u_ie01_e36(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(ie01_e36_we),
		.wd(ie01_e36_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[47+:1]),
		.qs(ie01_e36_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RW"),
		.RESVAL(1'h0)
	) u_ie01_e37(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(ie01_e37_we),
		.wd(ie01_e37_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[48+:1]),
		.qs(ie01_e37_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RW"),
		.RESVAL(1'h0)
	) u_ie01_e38(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(ie01_e38_we),
		.wd(ie01_e38_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[49+:1]),
		.qs(ie01_e38_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RW"),
		.RESVAL(1'h0)
	) u_ie01_e39(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(ie01_e39_we),
		.wd(ie01_e39_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[50+:1]),
		.qs(ie01_e39_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RW"),
		.RESVAL(1'h0)
	) u_ie01_e40(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(ie01_e40_we),
		.wd(ie01_e40_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[51+:1]),
		.qs(ie01_e40_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RW"),
		.RESVAL(1'h0)
	) u_ie01_e41(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(ie01_e41_we),
		.wd(ie01_e41_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[52+:1]),
		.qs(ie01_e41_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RW"),
		.RESVAL(1'h0)
	) u_ie01_e42(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(ie01_e42_we),
		.wd(ie01_e42_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[53+:1]),
		.qs(ie01_e42_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RW"),
		.RESVAL(1'h0)
	) u_ie01_e43(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(ie01_e43_we),
		.wd(ie01_e43_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[54+:1]),
		.qs(ie01_e43_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RW"),
		.RESVAL(1'h0)
	) u_ie01_e44(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(ie01_e44_we),
		.wd(ie01_e44_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[55+:1]),
		.qs(ie01_e44_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RW"),
		.RESVAL(1'h0)
	) u_ie01_e45(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(ie01_e45_we),
		.wd(ie01_e45_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[56+:1]),
		.qs(ie01_e45_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RW"),
		.RESVAL(1'h0)
	) u_ie01_e46(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(ie01_e46_we),
		.wd(ie01_e46_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[57+:1]),
		.qs(ie01_e46_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RW"),
		.RESVAL(1'h0)
	) u_ie01_e47(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(ie01_e47_we),
		.wd(ie01_e47_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[58+:1]),
		.qs(ie01_e47_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RW"),
		.RESVAL(1'h0)
	) u_ie01_e48(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(ie01_e48_we),
		.wd(ie01_e48_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[59+:1]),
		.qs(ie01_e48_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RW"),
		.RESVAL(1'h0)
	) u_ie01_e49(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(ie01_e49_we),
		.wd(ie01_e49_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[60+:1]),
		.qs(ie01_e49_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RW"),
		.RESVAL(1'h0)
	) u_ie01_e50(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(ie01_e50_we),
		.wd(ie01_e50_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[61+:1]),
		.qs(ie01_e50_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RW"),
		.RESVAL(1'h0)
	) u_ie01_e51(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(ie01_e51_we),
		.wd(ie01_e51_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[62+:1]),
		.qs(ie01_e51_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RW"),
		.RESVAL(1'h0)
	) u_ie01_e52(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(ie01_e52_we),
		.wd(ie01_e52_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[63+:1]),
		.qs(ie01_e52_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RW"),
		.RESVAL(1'h0)
	) u_ie01_e53(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(ie01_e53_we),
		.wd(ie01_e53_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[64+:1]),
		.qs(ie01_e53_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RW"),
		.RESVAL(1'h0)
	) u_ie01_e54(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(ie01_e54_we),
		.wd(ie01_e54_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[65+:1]),
		.qs(ie01_e54_qs)
	);
	prim_subreg #(
		.DW(2),
		.SWACCESS("RW"),
		.RESVAL(2'h0)
	) u_threshold0(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(threshold0_we),
		.wd(threshold0_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[10:9]),
		.qs(threshold0_qs)
	);
	prim_subreg_ext #(.DW(6)) u_cc0(
		.re(cc0_re),
		.we(cc0_we),
		.wd(cc0_wd),
		.d(hw2reg[5:0]),
		.qre(reg2hw[1:1]),
		.qe(reg2hw[2:2]),
		.q(reg2hw[8:3]),
		.qs(cc0_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RW"),
		.RESVAL(1'h0)
	) u_msip0(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(msip0_we),
		.wd(msip0_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[0:0]),
		.qs(msip0_qs)
	);
	reg [63:0] addr_hit;
	always @(*) begin
		addr_hit = 1'sb0;
		addr_hit[0] = (reg_addr == RV_PLIC_IP0_OFFSET);
		addr_hit[1] = (reg_addr == RV_PLIC_IP1_OFFSET);
		addr_hit[2] = (reg_addr == RV_PLIC_LE0_OFFSET);
		addr_hit[3] = (reg_addr == RV_PLIC_LE1_OFFSET);
		addr_hit[4] = (reg_addr == RV_PLIC_PRIO0_OFFSET);
		addr_hit[5] = (reg_addr == RV_PLIC_PRIO1_OFFSET);
		addr_hit[6] = (reg_addr == RV_PLIC_PRIO2_OFFSET);
		addr_hit[7] = (reg_addr == RV_PLIC_PRIO3_OFFSET);
		addr_hit[8] = (reg_addr == RV_PLIC_PRIO4_OFFSET);
		addr_hit[9] = (reg_addr == RV_PLIC_PRIO5_OFFSET);
		addr_hit[10] = (reg_addr == RV_PLIC_PRIO6_OFFSET);
		addr_hit[11] = (reg_addr == RV_PLIC_PRIO7_OFFSET);
		addr_hit[12] = (reg_addr == RV_PLIC_PRIO8_OFFSET);
		addr_hit[13] = (reg_addr == RV_PLIC_PRIO9_OFFSET);
		addr_hit[14] = (reg_addr == RV_PLIC_PRIO10_OFFSET);
		addr_hit[15] = (reg_addr == RV_PLIC_PRIO11_OFFSET);
		addr_hit[16] = (reg_addr == RV_PLIC_PRIO12_OFFSET);
		addr_hit[17] = (reg_addr == RV_PLIC_PRIO13_OFFSET);
		addr_hit[18] = (reg_addr == RV_PLIC_PRIO14_OFFSET);
		addr_hit[19] = (reg_addr == RV_PLIC_PRIO15_OFFSET);
		addr_hit[20] = (reg_addr == RV_PLIC_PRIO16_OFFSET);
		addr_hit[21] = (reg_addr == RV_PLIC_PRIO17_OFFSET);
		addr_hit[22] = (reg_addr == RV_PLIC_PRIO18_OFFSET);
		addr_hit[23] = (reg_addr == RV_PLIC_PRIO19_OFFSET);
		addr_hit[24] = (reg_addr == RV_PLIC_PRIO20_OFFSET);
		addr_hit[25] = (reg_addr == RV_PLIC_PRIO21_OFFSET);
		addr_hit[26] = (reg_addr == RV_PLIC_PRIO22_OFFSET);
		addr_hit[27] = (reg_addr == RV_PLIC_PRIO23_OFFSET);
		addr_hit[28] = (reg_addr == RV_PLIC_PRIO24_OFFSET);
		addr_hit[29] = (reg_addr == RV_PLIC_PRIO25_OFFSET);
		addr_hit[30] = (reg_addr == RV_PLIC_PRIO26_OFFSET);
		addr_hit[31] = (reg_addr == RV_PLIC_PRIO27_OFFSET);
		addr_hit[32] = (reg_addr == RV_PLIC_PRIO28_OFFSET);
		addr_hit[33] = (reg_addr == RV_PLIC_PRIO29_OFFSET);
		addr_hit[34] = (reg_addr == RV_PLIC_PRIO30_OFFSET);
		addr_hit[35] = (reg_addr == RV_PLIC_PRIO31_OFFSET);
		addr_hit[36] = (reg_addr == RV_PLIC_PRIO32_OFFSET);
		addr_hit[37] = (reg_addr == RV_PLIC_PRIO33_OFFSET);
		addr_hit[38] = (reg_addr == RV_PLIC_PRIO34_OFFSET);
		addr_hit[39] = (reg_addr == RV_PLIC_PRIO35_OFFSET);
		addr_hit[40] = (reg_addr == RV_PLIC_PRIO36_OFFSET);
		addr_hit[41] = (reg_addr == RV_PLIC_PRIO37_OFFSET);
		addr_hit[42] = (reg_addr == RV_PLIC_PRIO38_OFFSET);
		addr_hit[43] = (reg_addr == RV_PLIC_PRIO39_OFFSET);
		addr_hit[44] = (reg_addr == RV_PLIC_PRIO40_OFFSET);
		addr_hit[45] = (reg_addr == RV_PLIC_PRIO41_OFFSET);
		addr_hit[46] = (reg_addr == RV_PLIC_PRIO42_OFFSET);
		addr_hit[47] = (reg_addr == RV_PLIC_PRIO43_OFFSET);
		addr_hit[48] = (reg_addr == RV_PLIC_PRIO44_OFFSET);
		addr_hit[49] = (reg_addr == RV_PLIC_PRIO45_OFFSET);
		addr_hit[50] = (reg_addr == RV_PLIC_PRIO46_OFFSET);
		addr_hit[51] = (reg_addr == RV_PLIC_PRIO47_OFFSET);
		addr_hit[52] = (reg_addr == RV_PLIC_PRIO48_OFFSET);
		addr_hit[53] = (reg_addr == RV_PLIC_PRIO49_OFFSET);
		addr_hit[54] = (reg_addr == RV_PLIC_PRIO50_OFFSET);
		addr_hit[55] = (reg_addr == RV_PLIC_PRIO51_OFFSET);
		addr_hit[56] = (reg_addr == RV_PLIC_PRIO52_OFFSET);
		addr_hit[57] = (reg_addr == RV_PLIC_PRIO53_OFFSET);
		addr_hit[58] = (reg_addr == RV_PLIC_PRIO54_OFFSET);
		addr_hit[59] = (reg_addr == RV_PLIC_IE00_OFFSET);
		addr_hit[60] = (reg_addr == RV_PLIC_IE01_OFFSET);
		addr_hit[61] = (reg_addr == RV_PLIC_THRESHOLD0_OFFSET);
		addr_hit[62] = (reg_addr == RV_PLIC_CC0_OFFSET);
		addr_hit[63] = (reg_addr == RV_PLIC_MSIP0_OFFSET);
	end
	assign addrmiss = ((reg_re || reg_we) ? ~|addr_hit : 1'b0);
	always @(*) begin
		wr_err = 1'b0;
		if (((addr_hit[0] && reg_we) && (RV_PLIC_PERMIT[252+:4] != (RV_PLIC_PERMIT[252+:4] & reg_be))))
			wr_err = 1'b1;
		if (((addr_hit[1] && reg_we) && (RV_PLIC_PERMIT[248+:4] != (RV_PLIC_PERMIT[248+:4] & reg_be))))
			wr_err = 1'b1;
		if (((addr_hit[2] && reg_we) && (RV_PLIC_PERMIT[244+:4] != (RV_PLIC_PERMIT[244+:4] & reg_be))))
			wr_err = 1'b1;
		if (((addr_hit[3] && reg_we) && (RV_PLIC_PERMIT[240+:4] != (RV_PLIC_PERMIT[240+:4] & reg_be))))
			wr_err = 1'b1;
		if (((addr_hit[4] && reg_we) && (RV_PLIC_PERMIT[236+:4] != (RV_PLIC_PERMIT[236+:4] & reg_be))))
			wr_err = 1'b1;
		if (((addr_hit[5] && reg_we) && (RV_PLIC_PERMIT[232+:4] != (RV_PLIC_PERMIT[232+:4] & reg_be))))
			wr_err = 1'b1;
		if (((addr_hit[6] && reg_we) && (RV_PLIC_PERMIT[228+:4] != (RV_PLIC_PERMIT[228+:4] & reg_be))))
			wr_err = 1'b1;
		if (((addr_hit[7] && reg_we) && (RV_PLIC_PERMIT[224+:4] != (RV_PLIC_PERMIT[224+:4] & reg_be))))
			wr_err = 1'b1;
		if (((addr_hit[8] && reg_we) && (RV_PLIC_PERMIT[220+:4] != (RV_PLIC_PERMIT[220+:4] & reg_be))))
			wr_err = 1'b1;
		if (((addr_hit[9] && reg_we) && (RV_PLIC_PERMIT[216+:4] != (RV_PLIC_PERMIT[216+:4] & reg_be))))
			wr_err = 1'b1;
		if (((addr_hit[10] && reg_we) && (RV_PLIC_PERMIT[212+:4] != (RV_PLIC_PERMIT[212+:4] & reg_be))))
			wr_err = 1'b1;
		if (((addr_hit[11] && reg_we) && (RV_PLIC_PERMIT[208+:4] != (RV_PLIC_PERMIT[208+:4] & reg_be))))
			wr_err = 1'b1;
		if (((addr_hit[12] && reg_we) && (RV_PLIC_PERMIT[204+:4] != (RV_PLIC_PERMIT[204+:4] & reg_be))))
			wr_err = 1'b1;
		if (((addr_hit[13] && reg_we) && (RV_PLIC_PERMIT[200+:4] != (RV_PLIC_PERMIT[200+:4] & reg_be))))
			wr_err = 1'b1;
		if (((addr_hit[14] && reg_we) && (RV_PLIC_PERMIT[196+:4] != (RV_PLIC_PERMIT[196+:4] & reg_be))))
			wr_err = 1'b1;
		if (((addr_hit[15] && reg_we) && (RV_PLIC_PERMIT[192+:4] != (RV_PLIC_PERMIT[192+:4] & reg_be))))
			wr_err = 1'b1;
		if (((addr_hit[16] && reg_we) && (RV_PLIC_PERMIT[188+:4] != (RV_PLIC_PERMIT[188+:4] & reg_be))))
			wr_err = 1'b1;
		if (((addr_hit[17] && reg_we) && (RV_PLIC_PERMIT[184+:4] != (RV_PLIC_PERMIT[184+:4] & reg_be))))
			wr_err = 1'b1;
		if (((addr_hit[18] && reg_we) && (RV_PLIC_PERMIT[180+:4] != (RV_PLIC_PERMIT[180+:4] & reg_be))))
			wr_err = 1'b1;
		if (((addr_hit[19] && reg_we) && (RV_PLIC_PERMIT[176+:4] != (RV_PLIC_PERMIT[176+:4] & reg_be))))
			wr_err = 1'b1;
		if (((addr_hit[20] && reg_we) && (RV_PLIC_PERMIT[172+:4] != (RV_PLIC_PERMIT[172+:4] & reg_be))))
			wr_err = 1'b1;
		if (((addr_hit[21] && reg_we) && (RV_PLIC_PERMIT[168+:4] != (RV_PLIC_PERMIT[168+:4] & reg_be))))
			wr_err = 1'b1;
		if (((addr_hit[22] && reg_we) && (RV_PLIC_PERMIT[164+:4] != (RV_PLIC_PERMIT[164+:4] & reg_be))))
			wr_err = 1'b1;
		if (((addr_hit[23] && reg_we) && (RV_PLIC_PERMIT[160+:4] != (RV_PLIC_PERMIT[160+:4] & reg_be))))
			wr_err = 1'b1;
		if (((addr_hit[24] && reg_we) && (RV_PLIC_PERMIT[156+:4] != (RV_PLIC_PERMIT[156+:4] & reg_be))))
			wr_err = 1'b1;
		if (((addr_hit[25] && reg_we) && (RV_PLIC_PERMIT[152+:4] != (RV_PLIC_PERMIT[152+:4] & reg_be))))
			wr_err = 1'b1;
		if (((addr_hit[26] && reg_we) && (RV_PLIC_PERMIT[148+:4] != (RV_PLIC_PERMIT[148+:4] & reg_be))))
			wr_err = 1'b1;
		if (((addr_hit[27] && reg_we) && (RV_PLIC_PERMIT[144+:4] != (RV_PLIC_PERMIT[144+:4] & reg_be))))
			wr_err = 1'b1;
		if (((addr_hit[28] && reg_we) && (RV_PLIC_PERMIT[140+:4] != (RV_PLIC_PERMIT[140+:4] & reg_be))))
			wr_err = 1'b1;
		if (((addr_hit[29] && reg_we) && (RV_PLIC_PERMIT[136+:4] != (RV_PLIC_PERMIT[136+:4] & reg_be))))
			wr_err = 1'b1;
		if (((addr_hit[30] && reg_we) && (RV_PLIC_PERMIT[132+:4] != (RV_PLIC_PERMIT[132+:4] & reg_be))))
			wr_err = 1'b1;
		if (((addr_hit[31] && reg_we) && (RV_PLIC_PERMIT[128+:4] != (RV_PLIC_PERMIT[128+:4] & reg_be))))
			wr_err = 1'b1;
		if (((addr_hit[32] && reg_we) && (RV_PLIC_PERMIT[124+:4] != (RV_PLIC_PERMIT[124+:4] & reg_be))))
			wr_err = 1'b1;
		if (((addr_hit[33] && reg_we) && (RV_PLIC_PERMIT[120+:4] != (RV_PLIC_PERMIT[120+:4] & reg_be))))
			wr_err = 1'b1;
		if (((addr_hit[34] && reg_we) && (RV_PLIC_PERMIT[116+:4] != (RV_PLIC_PERMIT[116+:4] & reg_be))))
			wr_err = 1'b1;
		if (((addr_hit[35] && reg_we) && (RV_PLIC_PERMIT[112+:4] != (RV_PLIC_PERMIT[112+:4] & reg_be))))
			wr_err = 1'b1;
		if (((addr_hit[36] && reg_we) && (RV_PLIC_PERMIT[108+:4] != (RV_PLIC_PERMIT[108+:4] & reg_be))))
			wr_err = 1'b1;
		if (((addr_hit[37] && reg_we) && (RV_PLIC_PERMIT[104+:4] != (RV_PLIC_PERMIT[104+:4] & reg_be))))
			wr_err = 1'b1;
		if (((addr_hit[38] && reg_we) && (RV_PLIC_PERMIT[100+:4] != (RV_PLIC_PERMIT[100+:4] & reg_be))))
			wr_err = 1'b1;
		if (((addr_hit[39] && reg_we) && (RV_PLIC_PERMIT[96+:4] != (RV_PLIC_PERMIT[96+:4] & reg_be))))
			wr_err = 1'b1;
		if (((addr_hit[40] && reg_we) && (RV_PLIC_PERMIT[92+:4] != (RV_PLIC_PERMIT[92+:4] & reg_be))))
			wr_err = 1'b1;
		if (((addr_hit[41] && reg_we) && (RV_PLIC_PERMIT[88+:4] != (RV_PLIC_PERMIT[88+:4] & reg_be))))
			wr_err = 1'b1;
		if (((addr_hit[42] && reg_we) && (RV_PLIC_PERMIT[84+:4] != (RV_PLIC_PERMIT[84+:4] & reg_be))))
			wr_err = 1'b1;
		if (((addr_hit[43] && reg_we) && (RV_PLIC_PERMIT[80+:4] != (RV_PLIC_PERMIT[80+:4] & reg_be))))
			wr_err = 1'b1;
		if (((addr_hit[44] && reg_we) && (RV_PLIC_PERMIT[76+:4] != (RV_PLIC_PERMIT[76+:4] & reg_be))))
			wr_err = 1'b1;
		if (((addr_hit[45] && reg_we) && (RV_PLIC_PERMIT[72+:4] != (RV_PLIC_PERMIT[72+:4] & reg_be))))
			wr_err = 1'b1;
		if (((addr_hit[46] && reg_we) && (RV_PLIC_PERMIT[68+:4] != (RV_PLIC_PERMIT[68+:4] & reg_be))))
			wr_err = 1'b1;
		if (((addr_hit[47] && reg_we) && (RV_PLIC_PERMIT[64+:4] != (RV_PLIC_PERMIT[64+:4] & reg_be))))
			wr_err = 1'b1;
		if (((addr_hit[48] && reg_we) && (RV_PLIC_PERMIT[60+:4] != (RV_PLIC_PERMIT[60+:4] & reg_be))))
			wr_err = 1'b1;
		if (((addr_hit[49] && reg_we) && (RV_PLIC_PERMIT[56+:4] != (RV_PLIC_PERMIT[56+:4] & reg_be))))
			wr_err = 1'b1;
		if (((addr_hit[50] && reg_we) && (RV_PLIC_PERMIT[52+:4] != (RV_PLIC_PERMIT[52+:4] & reg_be))))
			wr_err = 1'b1;
		if (((addr_hit[51] && reg_we) && (RV_PLIC_PERMIT[48+:4] != (RV_PLIC_PERMIT[48+:4] & reg_be))))
			wr_err = 1'b1;
		if (((addr_hit[52] && reg_we) && (RV_PLIC_PERMIT[44+:4] != (RV_PLIC_PERMIT[44+:4] & reg_be))))
			wr_err = 1'b1;
		if (((addr_hit[53] && reg_we) && (RV_PLIC_PERMIT[40+:4] != (RV_PLIC_PERMIT[40+:4] & reg_be))))
			wr_err = 1'b1;
		if (((addr_hit[54] && reg_we) && (RV_PLIC_PERMIT[36+:4] != (RV_PLIC_PERMIT[36+:4] & reg_be))))
			wr_err = 1'b1;
		if (((addr_hit[55] && reg_we) && (RV_PLIC_PERMIT[32+:4] != (RV_PLIC_PERMIT[32+:4] & reg_be))))
			wr_err = 1'b1;
		if (((addr_hit[56] && reg_we) && (RV_PLIC_PERMIT[28+:4] != (RV_PLIC_PERMIT[28+:4] & reg_be))))
			wr_err = 1'b1;
		if (((addr_hit[57] && reg_we) && (RV_PLIC_PERMIT[24+:4] != (RV_PLIC_PERMIT[24+:4] & reg_be))))
			wr_err = 1'b1;
		if (((addr_hit[58] && reg_we) && (RV_PLIC_PERMIT[20+:4] != (RV_PLIC_PERMIT[20+:4] & reg_be))))
			wr_err = 1'b1;
		if (((addr_hit[59] && reg_we) && (RV_PLIC_PERMIT[16+:4] != (RV_PLIC_PERMIT[16+:4] & reg_be))))
			wr_err = 1'b1;
		if (((addr_hit[60] && reg_we) && (RV_PLIC_PERMIT[12+:4] != (RV_PLIC_PERMIT[12+:4] & reg_be))))
			wr_err = 1'b1;
		if (((addr_hit[61] && reg_we) && (RV_PLIC_PERMIT[8+:4] != (RV_PLIC_PERMIT[8+:4] & reg_be))))
			wr_err = 1'b1;
		if (((addr_hit[62] && reg_we) && (RV_PLIC_PERMIT[4+:4] != (RV_PLIC_PERMIT[4+:4] & reg_be))))
			wr_err = 1'b1;
		if (((addr_hit[63] && reg_we) && (RV_PLIC_PERMIT[0+:4] != (RV_PLIC_PERMIT[0+:4] & reg_be))))
			wr_err = 1'b1;
	end
	assign le0_le0_we = ((addr_hit[2] & reg_we) & ~wr_err);
	assign le0_le0_wd = reg_wdata[0];
	assign le0_le1_we = ((addr_hit[2] & reg_we) & ~wr_err);
	assign le0_le1_wd = reg_wdata[1];
	assign le0_le2_we = ((addr_hit[2] & reg_we) & ~wr_err);
	assign le0_le2_wd = reg_wdata[2];
	assign le0_le3_we = ((addr_hit[2] & reg_we) & ~wr_err);
	assign le0_le3_wd = reg_wdata[3];
	assign le0_le4_we = ((addr_hit[2] & reg_we) & ~wr_err);
	assign le0_le4_wd = reg_wdata[4];
	assign le0_le5_we = ((addr_hit[2] & reg_we) & ~wr_err);
	assign le0_le5_wd = reg_wdata[5];
	assign le0_le6_we = ((addr_hit[2] & reg_we) & ~wr_err);
	assign le0_le6_wd = reg_wdata[6];
	assign le0_le7_we = ((addr_hit[2] & reg_we) & ~wr_err);
	assign le0_le7_wd = reg_wdata[7];
	assign le0_le8_we = ((addr_hit[2] & reg_we) & ~wr_err);
	assign le0_le8_wd = reg_wdata[8];
	assign le0_le9_we = ((addr_hit[2] & reg_we) & ~wr_err);
	assign le0_le9_wd = reg_wdata[9];
	assign le0_le10_we = ((addr_hit[2] & reg_we) & ~wr_err);
	assign le0_le10_wd = reg_wdata[10];
	assign le0_le11_we = ((addr_hit[2] & reg_we) & ~wr_err);
	assign le0_le11_wd = reg_wdata[11];
	assign le0_le12_we = ((addr_hit[2] & reg_we) & ~wr_err);
	assign le0_le12_wd = reg_wdata[12];
	assign le0_le13_we = ((addr_hit[2] & reg_we) & ~wr_err);
	assign le0_le13_wd = reg_wdata[13];
	assign le0_le14_we = ((addr_hit[2] & reg_we) & ~wr_err);
	assign le0_le14_wd = reg_wdata[14];
	assign le0_le15_we = ((addr_hit[2] & reg_we) & ~wr_err);
	assign le0_le15_wd = reg_wdata[15];
	assign le0_le16_we = ((addr_hit[2] & reg_we) & ~wr_err);
	assign le0_le16_wd = reg_wdata[16];
	assign le0_le17_we = ((addr_hit[2] & reg_we) & ~wr_err);
	assign le0_le17_wd = reg_wdata[17];
	assign le0_le18_we = ((addr_hit[2] & reg_we) & ~wr_err);
	assign le0_le18_wd = reg_wdata[18];
	assign le0_le19_we = ((addr_hit[2] & reg_we) & ~wr_err);
	assign le0_le19_wd = reg_wdata[19];
	assign le0_le20_we = ((addr_hit[2] & reg_we) & ~wr_err);
	assign le0_le20_wd = reg_wdata[20];
	assign le0_le21_we = ((addr_hit[2] & reg_we) & ~wr_err);
	assign le0_le21_wd = reg_wdata[21];
	assign le0_le22_we = ((addr_hit[2] & reg_we) & ~wr_err);
	assign le0_le22_wd = reg_wdata[22];
	assign le0_le23_we = ((addr_hit[2] & reg_we) & ~wr_err);
	assign le0_le23_wd = reg_wdata[23];
	assign le0_le24_we = ((addr_hit[2] & reg_we) & ~wr_err);
	assign le0_le24_wd = reg_wdata[24];
	assign le0_le25_we = ((addr_hit[2] & reg_we) & ~wr_err);
	assign le0_le25_wd = reg_wdata[25];
	assign le0_le26_we = ((addr_hit[2] & reg_we) & ~wr_err);
	assign le0_le26_wd = reg_wdata[26];
	assign le0_le27_we = ((addr_hit[2] & reg_we) & ~wr_err);
	assign le0_le27_wd = reg_wdata[27];
	assign le0_le28_we = ((addr_hit[2] & reg_we) & ~wr_err);
	assign le0_le28_wd = reg_wdata[28];
	assign le0_le29_we = ((addr_hit[2] & reg_we) & ~wr_err);
	assign le0_le29_wd = reg_wdata[29];
	assign le0_le30_we = ((addr_hit[2] & reg_we) & ~wr_err);
	assign le0_le30_wd = reg_wdata[30];
	assign le0_le31_we = ((addr_hit[2] & reg_we) & ~wr_err);
	assign le0_le31_wd = reg_wdata[31];
	assign le1_le32_we = ((addr_hit[3] & reg_we) & ~wr_err);
	assign le1_le32_wd = reg_wdata[0];
	assign le1_le33_we = ((addr_hit[3] & reg_we) & ~wr_err);
	assign le1_le33_wd = reg_wdata[1];
	assign le1_le34_we = ((addr_hit[3] & reg_we) & ~wr_err);
	assign le1_le34_wd = reg_wdata[2];
	assign le1_le35_we = ((addr_hit[3] & reg_we) & ~wr_err);
	assign le1_le35_wd = reg_wdata[3];
	assign le1_le36_we = ((addr_hit[3] & reg_we) & ~wr_err);
	assign le1_le36_wd = reg_wdata[4];
	assign le1_le37_we = ((addr_hit[3] & reg_we) & ~wr_err);
	assign le1_le37_wd = reg_wdata[5];
	assign le1_le38_we = ((addr_hit[3] & reg_we) & ~wr_err);
	assign le1_le38_wd = reg_wdata[6];
	assign le1_le39_we = ((addr_hit[3] & reg_we) & ~wr_err);
	assign le1_le39_wd = reg_wdata[7];
	assign le1_le40_we = ((addr_hit[3] & reg_we) & ~wr_err);
	assign le1_le40_wd = reg_wdata[8];
	assign le1_le41_we = ((addr_hit[3] & reg_we) & ~wr_err);
	assign le1_le41_wd = reg_wdata[9];
	assign le1_le42_we = ((addr_hit[3] & reg_we) & ~wr_err);
	assign le1_le42_wd = reg_wdata[10];
	assign le1_le43_we = ((addr_hit[3] & reg_we) & ~wr_err);
	assign le1_le43_wd = reg_wdata[11];
	assign le1_le44_we = ((addr_hit[3] & reg_we) & ~wr_err);
	assign le1_le44_wd = reg_wdata[12];
	assign le1_le45_we = ((addr_hit[3] & reg_we) & ~wr_err);
	assign le1_le45_wd = reg_wdata[13];
	assign le1_le46_we = ((addr_hit[3] & reg_we) & ~wr_err);
	assign le1_le46_wd = reg_wdata[14];
	assign le1_le47_we = ((addr_hit[3] & reg_we) & ~wr_err);
	assign le1_le47_wd = reg_wdata[15];
	assign le1_le48_we = ((addr_hit[3] & reg_we) & ~wr_err);
	assign le1_le48_wd = reg_wdata[16];
	assign le1_le49_we = ((addr_hit[3] & reg_we) & ~wr_err);
	assign le1_le49_wd = reg_wdata[17];
	assign le1_le50_we = ((addr_hit[3] & reg_we) & ~wr_err);
	assign le1_le50_wd = reg_wdata[18];
	assign le1_le51_we = ((addr_hit[3] & reg_we) & ~wr_err);
	assign le1_le51_wd = reg_wdata[19];
	assign le1_le52_we = ((addr_hit[3] & reg_we) & ~wr_err);
	assign le1_le52_wd = reg_wdata[20];
	assign le1_le53_we = ((addr_hit[3] & reg_we) & ~wr_err);
	assign le1_le53_wd = reg_wdata[21];
	assign le1_le54_we = ((addr_hit[3] & reg_we) & ~wr_err);
	assign le1_le54_wd = reg_wdata[22];
	assign prio0_we = ((addr_hit[4] & reg_we) & ~wr_err);
	assign prio0_wd = reg_wdata[1:0];
	assign prio1_we = ((addr_hit[5] & reg_we) & ~wr_err);
	assign prio1_wd = reg_wdata[1:0];
	assign prio2_we = ((addr_hit[6] & reg_we) & ~wr_err);
	assign prio2_wd = reg_wdata[1:0];
	assign prio3_we = ((addr_hit[7] & reg_we) & ~wr_err);
	assign prio3_wd = reg_wdata[1:0];
	assign prio4_we = ((addr_hit[8] & reg_we) & ~wr_err);
	assign prio4_wd = reg_wdata[1:0];
	assign prio5_we = ((addr_hit[9] & reg_we) & ~wr_err);
	assign prio5_wd = reg_wdata[1:0];
	assign prio6_we = ((addr_hit[10] & reg_we) & ~wr_err);
	assign prio6_wd = reg_wdata[1:0];
	assign prio7_we = ((addr_hit[11] & reg_we) & ~wr_err);
	assign prio7_wd = reg_wdata[1:0];
	assign prio8_we = ((addr_hit[12] & reg_we) & ~wr_err);
	assign prio8_wd = reg_wdata[1:0];
	assign prio9_we = ((addr_hit[13] & reg_we) & ~wr_err);
	assign prio9_wd = reg_wdata[1:0];
	assign prio10_we = ((addr_hit[14] & reg_we) & ~wr_err);
	assign prio10_wd = reg_wdata[1:0];
	assign prio11_we = ((addr_hit[15] & reg_we) & ~wr_err);
	assign prio11_wd = reg_wdata[1:0];
	assign prio12_we = ((addr_hit[16] & reg_we) & ~wr_err);
	assign prio12_wd = reg_wdata[1:0];
	assign prio13_we = ((addr_hit[17] & reg_we) & ~wr_err);
	assign prio13_wd = reg_wdata[1:0];
	assign prio14_we = ((addr_hit[18] & reg_we) & ~wr_err);
	assign prio14_wd = reg_wdata[1:0];
	assign prio15_we = ((addr_hit[19] & reg_we) & ~wr_err);
	assign prio15_wd = reg_wdata[1:0];
	assign prio16_we = ((addr_hit[20] & reg_we) & ~wr_err);
	assign prio16_wd = reg_wdata[1:0];
	assign prio17_we = ((addr_hit[21] & reg_we) & ~wr_err);
	assign prio17_wd = reg_wdata[1:0];
	assign prio18_we = ((addr_hit[22] & reg_we) & ~wr_err);
	assign prio18_wd = reg_wdata[1:0];
	assign prio19_we = ((addr_hit[23] & reg_we) & ~wr_err);
	assign prio19_wd = reg_wdata[1:0];
	assign prio20_we = ((addr_hit[24] & reg_we) & ~wr_err);
	assign prio20_wd = reg_wdata[1:0];
	assign prio21_we = ((addr_hit[25] & reg_we) & ~wr_err);
	assign prio21_wd = reg_wdata[1:0];
	assign prio22_we = ((addr_hit[26] & reg_we) & ~wr_err);
	assign prio22_wd = reg_wdata[1:0];
	assign prio23_we = ((addr_hit[27] & reg_we) & ~wr_err);
	assign prio23_wd = reg_wdata[1:0];
	assign prio24_we = ((addr_hit[28] & reg_we) & ~wr_err);
	assign prio24_wd = reg_wdata[1:0];
	assign prio25_we = ((addr_hit[29] & reg_we) & ~wr_err);
	assign prio25_wd = reg_wdata[1:0];
	assign prio26_we = ((addr_hit[30] & reg_we) & ~wr_err);
	assign prio26_wd = reg_wdata[1:0];
	assign prio27_we = ((addr_hit[31] & reg_we) & ~wr_err);
	assign prio27_wd = reg_wdata[1:0];
	assign prio28_we = ((addr_hit[32] & reg_we) & ~wr_err);
	assign prio28_wd = reg_wdata[1:0];
	assign prio29_we = ((addr_hit[33] & reg_we) & ~wr_err);
	assign prio29_wd = reg_wdata[1:0];
	assign prio30_we = ((addr_hit[34] & reg_we) & ~wr_err);
	assign prio30_wd = reg_wdata[1:0];
	assign prio31_we = ((addr_hit[35] & reg_we) & ~wr_err);
	assign prio31_wd = reg_wdata[1:0];
	assign prio32_we = ((addr_hit[36] & reg_we) & ~wr_err);
	assign prio32_wd = reg_wdata[1:0];
	assign prio33_we = ((addr_hit[37] & reg_we) & ~wr_err);
	assign prio33_wd = reg_wdata[1:0];
	assign prio34_we = ((addr_hit[38] & reg_we) & ~wr_err);
	assign prio34_wd = reg_wdata[1:0];
	assign prio35_we = ((addr_hit[39] & reg_we) & ~wr_err);
	assign prio35_wd = reg_wdata[1:0];
	assign prio36_we = ((addr_hit[40] & reg_we) & ~wr_err);
	assign prio36_wd = reg_wdata[1:0];
	assign prio37_we = ((addr_hit[41] & reg_we) & ~wr_err);
	assign prio37_wd = reg_wdata[1:0];
	assign prio38_we = ((addr_hit[42] & reg_we) & ~wr_err);
	assign prio38_wd = reg_wdata[1:0];
	assign prio39_we = ((addr_hit[43] & reg_we) & ~wr_err);
	assign prio39_wd = reg_wdata[1:0];
	assign prio40_we = ((addr_hit[44] & reg_we) & ~wr_err);
	assign prio40_wd = reg_wdata[1:0];
	assign prio41_we = ((addr_hit[45] & reg_we) & ~wr_err);
	assign prio41_wd = reg_wdata[1:0];
	assign prio42_we = ((addr_hit[46] & reg_we) & ~wr_err);
	assign prio42_wd = reg_wdata[1:0];
	assign prio43_we = ((addr_hit[47] & reg_we) & ~wr_err);
	assign prio43_wd = reg_wdata[1:0];
	assign prio44_we = ((addr_hit[48] & reg_we) & ~wr_err);
	assign prio44_wd = reg_wdata[1:0];
	assign prio45_we = ((addr_hit[49] & reg_we) & ~wr_err);
	assign prio45_wd = reg_wdata[1:0];
	assign prio46_we = ((addr_hit[50] & reg_we) & ~wr_err);
	assign prio46_wd = reg_wdata[1:0];
	assign prio47_we = ((addr_hit[51] & reg_we) & ~wr_err);
	assign prio47_wd = reg_wdata[1:0];
	assign prio48_we = ((addr_hit[52] & reg_we) & ~wr_err);
	assign prio48_wd = reg_wdata[1:0];
	assign prio49_we = ((addr_hit[53] & reg_we) & ~wr_err);
	assign prio49_wd = reg_wdata[1:0];
	assign prio50_we = ((addr_hit[54] & reg_we) & ~wr_err);
	assign prio50_wd = reg_wdata[1:0];
	assign prio51_we = ((addr_hit[55] & reg_we) & ~wr_err);
	assign prio51_wd = reg_wdata[1:0];
	assign prio52_we = ((addr_hit[56] & reg_we) & ~wr_err);
	assign prio52_wd = reg_wdata[1:0];
	assign prio53_we = ((addr_hit[57] & reg_we) & ~wr_err);
	assign prio53_wd = reg_wdata[1:0];
	assign prio54_we = ((addr_hit[58] & reg_we) & ~wr_err);
	assign prio54_wd = reg_wdata[1:0];
	assign ie00_e0_we = ((addr_hit[59] & reg_we) & ~wr_err);
	assign ie00_e0_wd = reg_wdata[0];
	assign ie00_e1_we = ((addr_hit[59] & reg_we) & ~wr_err);
	assign ie00_e1_wd = reg_wdata[1];
	assign ie00_e2_we = ((addr_hit[59] & reg_we) & ~wr_err);
	assign ie00_e2_wd = reg_wdata[2];
	assign ie00_e3_we = ((addr_hit[59] & reg_we) & ~wr_err);
	assign ie00_e3_wd = reg_wdata[3];
	assign ie00_e4_we = ((addr_hit[59] & reg_we) & ~wr_err);
	assign ie00_e4_wd = reg_wdata[4];
	assign ie00_e5_we = ((addr_hit[59] & reg_we) & ~wr_err);
	assign ie00_e5_wd = reg_wdata[5];
	assign ie00_e6_we = ((addr_hit[59] & reg_we) & ~wr_err);
	assign ie00_e6_wd = reg_wdata[6];
	assign ie00_e7_we = ((addr_hit[59] & reg_we) & ~wr_err);
	assign ie00_e7_wd = reg_wdata[7];
	assign ie00_e8_we = ((addr_hit[59] & reg_we) & ~wr_err);
	assign ie00_e8_wd = reg_wdata[8];
	assign ie00_e9_we = ((addr_hit[59] & reg_we) & ~wr_err);
	assign ie00_e9_wd = reg_wdata[9];
	assign ie00_e10_we = ((addr_hit[59] & reg_we) & ~wr_err);
	assign ie00_e10_wd = reg_wdata[10];
	assign ie00_e11_we = ((addr_hit[59] & reg_we) & ~wr_err);
	assign ie00_e11_wd = reg_wdata[11];
	assign ie00_e12_we = ((addr_hit[59] & reg_we) & ~wr_err);
	assign ie00_e12_wd = reg_wdata[12];
	assign ie00_e13_we = ((addr_hit[59] & reg_we) & ~wr_err);
	assign ie00_e13_wd = reg_wdata[13];
	assign ie00_e14_we = ((addr_hit[59] & reg_we) & ~wr_err);
	assign ie00_e14_wd = reg_wdata[14];
	assign ie00_e15_we = ((addr_hit[59] & reg_we) & ~wr_err);
	assign ie00_e15_wd = reg_wdata[15];
	assign ie00_e16_we = ((addr_hit[59] & reg_we) & ~wr_err);
	assign ie00_e16_wd = reg_wdata[16];
	assign ie00_e17_we = ((addr_hit[59] & reg_we) & ~wr_err);
	assign ie00_e17_wd = reg_wdata[17];
	assign ie00_e18_we = ((addr_hit[59] & reg_we) & ~wr_err);
	assign ie00_e18_wd = reg_wdata[18];
	assign ie00_e19_we = ((addr_hit[59] & reg_we) & ~wr_err);
	assign ie00_e19_wd = reg_wdata[19];
	assign ie00_e20_we = ((addr_hit[59] & reg_we) & ~wr_err);
	assign ie00_e20_wd = reg_wdata[20];
	assign ie00_e21_we = ((addr_hit[59] & reg_we) & ~wr_err);
	assign ie00_e21_wd = reg_wdata[21];
	assign ie00_e22_we = ((addr_hit[59] & reg_we) & ~wr_err);
	assign ie00_e22_wd = reg_wdata[22];
	assign ie00_e23_we = ((addr_hit[59] & reg_we) & ~wr_err);
	assign ie00_e23_wd = reg_wdata[23];
	assign ie00_e24_we = ((addr_hit[59] & reg_we) & ~wr_err);
	assign ie00_e24_wd = reg_wdata[24];
	assign ie00_e25_we = ((addr_hit[59] & reg_we) & ~wr_err);
	assign ie00_e25_wd = reg_wdata[25];
	assign ie00_e26_we = ((addr_hit[59] & reg_we) & ~wr_err);
	assign ie00_e26_wd = reg_wdata[26];
	assign ie00_e27_we = ((addr_hit[59] & reg_we) & ~wr_err);
	assign ie00_e27_wd = reg_wdata[27];
	assign ie00_e28_we = ((addr_hit[59] & reg_we) & ~wr_err);
	assign ie00_e28_wd = reg_wdata[28];
	assign ie00_e29_we = ((addr_hit[59] & reg_we) & ~wr_err);
	assign ie00_e29_wd = reg_wdata[29];
	assign ie00_e30_we = ((addr_hit[59] & reg_we) & ~wr_err);
	assign ie00_e30_wd = reg_wdata[30];
	assign ie00_e31_we = ((addr_hit[59] & reg_we) & ~wr_err);
	assign ie00_e31_wd = reg_wdata[31];
	assign ie01_e32_we = ((addr_hit[60] & reg_we) & ~wr_err);
	assign ie01_e32_wd = reg_wdata[0];
	assign ie01_e33_we = ((addr_hit[60] & reg_we) & ~wr_err);
	assign ie01_e33_wd = reg_wdata[1];
	assign ie01_e34_we = ((addr_hit[60] & reg_we) & ~wr_err);
	assign ie01_e34_wd = reg_wdata[2];
	assign ie01_e35_we = ((addr_hit[60] & reg_we) & ~wr_err);
	assign ie01_e35_wd = reg_wdata[3];
	assign ie01_e36_we = ((addr_hit[60] & reg_we) & ~wr_err);
	assign ie01_e36_wd = reg_wdata[4];
	assign ie01_e37_we = ((addr_hit[60] & reg_we) & ~wr_err);
	assign ie01_e37_wd = reg_wdata[5];
	assign ie01_e38_we = ((addr_hit[60] & reg_we) & ~wr_err);
	assign ie01_e38_wd = reg_wdata[6];
	assign ie01_e39_we = ((addr_hit[60] & reg_we) & ~wr_err);
	assign ie01_e39_wd = reg_wdata[7];
	assign ie01_e40_we = ((addr_hit[60] & reg_we) & ~wr_err);
	assign ie01_e40_wd = reg_wdata[8];
	assign ie01_e41_we = ((addr_hit[60] & reg_we) & ~wr_err);
	assign ie01_e41_wd = reg_wdata[9];
	assign ie01_e42_we = ((addr_hit[60] & reg_we) & ~wr_err);
	assign ie01_e42_wd = reg_wdata[10];
	assign ie01_e43_we = ((addr_hit[60] & reg_we) & ~wr_err);
	assign ie01_e43_wd = reg_wdata[11];
	assign ie01_e44_we = ((addr_hit[60] & reg_we) & ~wr_err);
	assign ie01_e44_wd = reg_wdata[12];
	assign ie01_e45_we = ((addr_hit[60] & reg_we) & ~wr_err);
	assign ie01_e45_wd = reg_wdata[13];
	assign ie01_e46_we = ((addr_hit[60] & reg_we) & ~wr_err);
	assign ie01_e46_wd = reg_wdata[14];
	assign ie01_e47_we = ((addr_hit[60] & reg_we) & ~wr_err);
	assign ie01_e47_wd = reg_wdata[15];
	assign ie01_e48_we = ((addr_hit[60] & reg_we) & ~wr_err);
	assign ie01_e48_wd = reg_wdata[16];
	assign ie01_e49_we = ((addr_hit[60] & reg_we) & ~wr_err);
	assign ie01_e49_wd = reg_wdata[17];
	assign ie01_e50_we = ((addr_hit[60] & reg_we) & ~wr_err);
	assign ie01_e50_wd = reg_wdata[18];
	assign ie01_e51_we = ((addr_hit[60] & reg_we) & ~wr_err);
	assign ie01_e51_wd = reg_wdata[19];
	assign ie01_e52_we = ((addr_hit[60] & reg_we) & ~wr_err);
	assign ie01_e52_wd = reg_wdata[20];
	assign ie01_e53_we = ((addr_hit[60] & reg_we) & ~wr_err);
	assign ie01_e53_wd = reg_wdata[21];
	assign ie01_e54_we = ((addr_hit[60] & reg_we) & ~wr_err);
	assign ie01_e54_wd = reg_wdata[22];
	assign threshold0_we = ((addr_hit[61] & reg_we) & ~wr_err);
	assign threshold0_wd = reg_wdata[1:0];
	assign cc0_we = ((addr_hit[62] & reg_we) & ~wr_err);
	assign cc0_wd = reg_wdata[5:0];
	assign cc0_re = (addr_hit[62] && reg_re);
	assign msip0_we = ((addr_hit[63] & reg_we) & ~wr_err);
	assign msip0_wd = reg_wdata[0];
	always @(*) begin
		reg_rdata_next = 1'sb0;
		case (1'b1)
			addr_hit[0]: begin
				reg_rdata_next[0] = ip0_p0_qs;
				reg_rdata_next[1] = ip0_p1_qs;
				reg_rdata_next[2] = ip0_p2_qs;
				reg_rdata_next[3] = ip0_p3_qs;
				reg_rdata_next[4] = ip0_p4_qs;
				reg_rdata_next[5] = ip0_p5_qs;
				reg_rdata_next[6] = ip0_p6_qs;
				reg_rdata_next[7] = ip0_p7_qs;
				reg_rdata_next[8] = ip0_p8_qs;
				reg_rdata_next[9] = ip0_p9_qs;
				reg_rdata_next[10] = ip0_p10_qs;
				reg_rdata_next[11] = ip0_p11_qs;
				reg_rdata_next[12] = ip0_p12_qs;
				reg_rdata_next[13] = ip0_p13_qs;
				reg_rdata_next[14] = ip0_p14_qs;
				reg_rdata_next[15] = ip0_p15_qs;
				reg_rdata_next[16] = ip0_p16_qs;
				reg_rdata_next[17] = ip0_p17_qs;
				reg_rdata_next[18] = ip0_p18_qs;
				reg_rdata_next[19] = ip0_p19_qs;
				reg_rdata_next[20] = ip0_p20_qs;
				reg_rdata_next[21] = ip0_p21_qs;
				reg_rdata_next[22] = ip0_p22_qs;
				reg_rdata_next[23] = ip0_p23_qs;
				reg_rdata_next[24] = ip0_p24_qs;
				reg_rdata_next[25] = ip0_p25_qs;
				reg_rdata_next[26] = ip0_p26_qs;
				reg_rdata_next[27] = ip0_p27_qs;
				reg_rdata_next[28] = ip0_p28_qs;
				reg_rdata_next[29] = ip0_p29_qs;
				reg_rdata_next[30] = ip0_p30_qs;
				reg_rdata_next[31] = ip0_p31_qs;
			end
			addr_hit[1]: begin
				reg_rdata_next[0] = ip1_p32_qs;
				reg_rdata_next[1] = ip1_p33_qs;
				reg_rdata_next[2] = ip1_p34_qs;
				reg_rdata_next[3] = ip1_p35_qs;
				reg_rdata_next[4] = ip1_p36_qs;
				reg_rdata_next[5] = ip1_p37_qs;
				reg_rdata_next[6] = ip1_p38_qs;
				reg_rdata_next[7] = ip1_p39_qs;
				reg_rdata_next[8] = ip1_p40_qs;
				reg_rdata_next[9] = ip1_p41_qs;
				reg_rdata_next[10] = ip1_p42_qs;
				reg_rdata_next[11] = ip1_p43_qs;
				reg_rdata_next[12] = ip1_p44_qs;
				reg_rdata_next[13] = ip1_p45_qs;
				reg_rdata_next[14] = ip1_p46_qs;
				reg_rdata_next[15] = ip1_p47_qs;
				reg_rdata_next[16] = ip1_p48_qs;
				reg_rdata_next[17] = ip1_p49_qs;
				reg_rdata_next[18] = ip1_p50_qs;
				reg_rdata_next[19] = ip1_p51_qs;
				reg_rdata_next[20] = ip1_p52_qs;
				reg_rdata_next[21] = ip1_p53_qs;
				reg_rdata_next[22] = ip1_p54_qs;
			end
			addr_hit[2]: begin
				reg_rdata_next[0] = le0_le0_qs;
				reg_rdata_next[1] = le0_le1_qs;
				reg_rdata_next[2] = le0_le2_qs;
				reg_rdata_next[3] = le0_le3_qs;
				reg_rdata_next[4] = le0_le4_qs;
				reg_rdata_next[5] = le0_le5_qs;
				reg_rdata_next[6] = le0_le6_qs;
				reg_rdata_next[7] = le0_le7_qs;
				reg_rdata_next[8] = le0_le8_qs;
				reg_rdata_next[9] = le0_le9_qs;
				reg_rdata_next[10] = le0_le10_qs;
				reg_rdata_next[11] = le0_le11_qs;
				reg_rdata_next[12] = le0_le12_qs;
				reg_rdata_next[13] = le0_le13_qs;
				reg_rdata_next[14] = le0_le14_qs;
				reg_rdata_next[15] = le0_le15_qs;
				reg_rdata_next[16] = le0_le16_qs;
				reg_rdata_next[17] = le0_le17_qs;
				reg_rdata_next[18] = le0_le18_qs;
				reg_rdata_next[19] = le0_le19_qs;
				reg_rdata_next[20] = le0_le20_qs;
				reg_rdata_next[21] = le0_le21_qs;
				reg_rdata_next[22] = le0_le22_qs;
				reg_rdata_next[23] = le0_le23_qs;
				reg_rdata_next[24] = le0_le24_qs;
				reg_rdata_next[25] = le0_le25_qs;
				reg_rdata_next[26] = le0_le26_qs;
				reg_rdata_next[27] = le0_le27_qs;
				reg_rdata_next[28] = le0_le28_qs;
				reg_rdata_next[29] = le0_le29_qs;
				reg_rdata_next[30] = le0_le30_qs;
				reg_rdata_next[31] = le0_le31_qs;
			end
			addr_hit[3]: begin
				reg_rdata_next[0] = le1_le32_qs;
				reg_rdata_next[1] = le1_le33_qs;
				reg_rdata_next[2] = le1_le34_qs;
				reg_rdata_next[3] = le1_le35_qs;
				reg_rdata_next[4] = le1_le36_qs;
				reg_rdata_next[5] = le1_le37_qs;
				reg_rdata_next[6] = le1_le38_qs;
				reg_rdata_next[7] = le1_le39_qs;
				reg_rdata_next[8] = le1_le40_qs;
				reg_rdata_next[9] = le1_le41_qs;
				reg_rdata_next[10] = le1_le42_qs;
				reg_rdata_next[11] = le1_le43_qs;
				reg_rdata_next[12] = le1_le44_qs;
				reg_rdata_next[13] = le1_le45_qs;
				reg_rdata_next[14] = le1_le46_qs;
				reg_rdata_next[15] = le1_le47_qs;
				reg_rdata_next[16] = le1_le48_qs;
				reg_rdata_next[17] = le1_le49_qs;
				reg_rdata_next[18] = le1_le50_qs;
				reg_rdata_next[19] = le1_le51_qs;
				reg_rdata_next[20] = le1_le52_qs;
				reg_rdata_next[21] = le1_le53_qs;
				reg_rdata_next[22] = le1_le54_qs;
			end
			addr_hit[4]: reg_rdata_next[1:0] = prio0_qs;
			addr_hit[5]: reg_rdata_next[1:0] = prio1_qs;
			addr_hit[6]: reg_rdata_next[1:0] = prio2_qs;
			addr_hit[7]: reg_rdata_next[1:0] = prio3_qs;
			addr_hit[8]: reg_rdata_next[1:0] = prio4_qs;
			addr_hit[9]: reg_rdata_next[1:0] = prio5_qs;
			addr_hit[10]: reg_rdata_next[1:0] = prio6_qs;
			addr_hit[11]: reg_rdata_next[1:0] = prio7_qs;
			addr_hit[12]: reg_rdata_next[1:0] = prio8_qs;
			addr_hit[13]: reg_rdata_next[1:0] = prio9_qs;
			addr_hit[14]: reg_rdata_next[1:0] = prio10_qs;
			addr_hit[15]: reg_rdata_next[1:0] = prio11_qs;
			addr_hit[16]: reg_rdata_next[1:0] = prio12_qs;
			addr_hit[17]: reg_rdata_next[1:0] = prio13_qs;
			addr_hit[18]: reg_rdata_next[1:0] = prio14_qs;
			addr_hit[19]: reg_rdata_next[1:0] = prio15_qs;
			addr_hit[20]: reg_rdata_next[1:0] = prio16_qs;
			addr_hit[21]: reg_rdata_next[1:0] = prio17_qs;
			addr_hit[22]: reg_rdata_next[1:0] = prio18_qs;
			addr_hit[23]: reg_rdata_next[1:0] = prio19_qs;
			addr_hit[24]: reg_rdata_next[1:0] = prio20_qs;
			addr_hit[25]: reg_rdata_next[1:0] = prio21_qs;
			addr_hit[26]: reg_rdata_next[1:0] = prio22_qs;
			addr_hit[27]: reg_rdata_next[1:0] = prio23_qs;
			addr_hit[28]: reg_rdata_next[1:0] = prio24_qs;
			addr_hit[29]: reg_rdata_next[1:0] = prio25_qs;
			addr_hit[30]: reg_rdata_next[1:0] = prio26_qs;
			addr_hit[31]: reg_rdata_next[1:0] = prio27_qs;
			addr_hit[32]: reg_rdata_next[1:0] = prio28_qs;
			addr_hit[33]: reg_rdata_next[1:0] = prio29_qs;
			addr_hit[34]: reg_rdata_next[1:0] = prio30_qs;
			addr_hit[35]: reg_rdata_next[1:0] = prio31_qs;
			addr_hit[36]: reg_rdata_next[1:0] = prio32_qs;
			addr_hit[37]: reg_rdata_next[1:0] = prio33_qs;
			addr_hit[38]: reg_rdata_next[1:0] = prio34_qs;
			addr_hit[39]: reg_rdata_next[1:0] = prio35_qs;
			addr_hit[40]: reg_rdata_next[1:0] = prio36_qs;
			addr_hit[41]: reg_rdata_next[1:0] = prio37_qs;
			addr_hit[42]: reg_rdata_next[1:0] = prio38_qs;
			addr_hit[43]: reg_rdata_next[1:0] = prio39_qs;
			addr_hit[44]: reg_rdata_next[1:0] = prio40_qs;
			addr_hit[45]: reg_rdata_next[1:0] = prio41_qs;
			addr_hit[46]: reg_rdata_next[1:0] = prio42_qs;
			addr_hit[47]: reg_rdata_next[1:0] = prio43_qs;
			addr_hit[48]: reg_rdata_next[1:0] = prio44_qs;
			addr_hit[49]: reg_rdata_next[1:0] = prio45_qs;
			addr_hit[50]: reg_rdata_next[1:0] = prio46_qs;
			addr_hit[51]: reg_rdata_next[1:0] = prio47_qs;
			addr_hit[52]: reg_rdata_next[1:0] = prio48_qs;
			addr_hit[53]: reg_rdata_next[1:0] = prio49_qs;
			addr_hit[54]: reg_rdata_next[1:0] = prio50_qs;
			addr_hit[55]: reg_rdata_next[1:0] = prio51_qs;
			addr_hit[56]: reg_rdata_next[1:0] = prio52_qs;
			addr_hit[57]: reg_rdata_next[1:0] = prio53_qs;
			addr_hit[58]: reg_rdata_next[1:0] = prio54_qs;
			addr_hit[59]: begin
				reg_rdata_next[0] = ie00_e0_qs;
				reg_rdata_next[1] = ie00_e1_qs;
				reg_rdata_next[2] = ie00_e2_qs;
				reg_rdata_next[3] = ie00_e3_qs;
				reg_rdata_next[4] = ie00_e4_qs;
				reg_rdata_next[5] = ie00_e5_qs;
				reg_rdata_next[6] = ie00_e6_qs;
				reg_rdata_next[7] = ie00_e7_qs;
				reg_rdata_next[8] = ie00_e8_qs;
				reg_rdata_next[9] = ie00_e9_qs;
				reg_rdata_next[10] = ie00_e10_qs;
				reg_rdata_next[11] = ie00_e11_qs;
				reg_rdata_next[12] = ie00_e12_qs;
				reg_rdata_next[13] = ie00_e13_qs;
				reg_rdata_next[14] = ie00_e14_qs;
				reg_rdata_next[15] = ie00_e15_qs;
				reg_rdata_next[16] = ie00_e16_qs;
				reg_rdata_next[17] = ie00_e17_qs;
				reg_rdata_next[18] = ie00_e18_qs;
				reg_rdata_next[19] = ie00_e19_qs;
				reg_rdata_next[20] = ie00_e20_qs;
				reg_rdata_next[21] = ie00_e21_qs;
				reg_rdata_next[22] = ie00_e22_qs;
				reg_rdata_next[23] = ie00_e23_qs;
				reg_rdata_next[24] = ie00_e24_qs;
				reg_rdata_next[25] = ie00_e25_qs;
				reg_rdata_next[26] = ie00_e26_qs;
				reg_rdata_next[27] = ie00_e27_qs;
				reg_rdata_next[28] = ie00_e28_qs;
				reg_rdata_next[29] = ie00_e29_qs;
				reg_rdata_next[30] = ie00_e30_qs;
				reg_rdata_next[31] = ie00_e31_qs;
			end
			addr_hit[60]: begin
				reg_rdata_next[0] = ie01_e32_qs;
				reg_rdata_next[1] = ie01_e33_qs;
				reg_rdata_next[2] = ie01_e34_qs;
				reg_rdata_next[3] = ie01_e35_qs;
				reg_rdata_next[4] = ie01_e36_qs;
				reg_rdata_next[5] = ie01_e37_qs;
				reg_rdata_next[6] = ie01_e38_qs;
				reg_rdata_next[7] = ie01_e39_qs;
				reg_rdata_next[8] = ie01_e40_qs;
				reg_rdata_next[9] = ie01_e41_qs;
				reg_rdata_next[10] = ie01_e42_qs;
				reg_rdata_next[11] = ie01_e43_qs;
				reg_rdata_next[12] = ie01_e44_qs;
				reg_rdata_next[13] = ie01_e45_qs;
				reg_rdata_next[14] = ie01_e46_qs;
				reg_rdata_next[15] = ie01_e47_qs;
				reg_rdata_next[16] = ie01_e48_qs;
				reg_rdata_next[17] = ie01_e49_qs;
				reg_rdata_next[18] = ie01_e50_qs;
				reg_rdata_next[19] = ie01_e51_qs;
				reg_rdata_next[20] = ie01_e52_qs;
				reg_rdata_next[21] = ie01_e53_qs;
				reg_rdata_next[22] = ie01_e54_qs;
			end
			addr_hit[61]: reg_rdata_next[1:0] = threshold0_qs;
			addr_hit[62]: reg_rdata_next[5:0] = cc0_qs;
			addr_hit[63]: reg_rdata_next[0] = msip0_qs;
			default: reg_rdata_next = 1'sb1;
		endcase
	end
endmodule
