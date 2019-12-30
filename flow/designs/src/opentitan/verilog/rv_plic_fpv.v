module rv_plic_fpv (
	clk_i,
	rst_ni,
	tl_i,
	tl_o,
	intr_src_i,
	irq_o,
	irq_id_o,
	msip_o
);
	localparam top_pkg_TL_AW = 32;
	localparam top_pkg_TL_DW = 32;
	localparam top_pkg_TL_AIW = 8;
	localparam top_pkg_TL_DIW = 1;
	localparam top_pkg_TL_DUW = 16;
	localparam top_pkg_TL_DBW = (top_pkg_TL_DW >> 3);
	localparam top_pkg_TL_SZW = $clog2(($clog2((32 >> 3)) + 1));
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
	localparam [31:0] NumInstances = 1;
	input clk_i;
	input rst_ni;
	input wire [(((((((7 + ((($clog2(($clog2((32 >> 3)) + 1)) - 1) >= 0) ? $clog2(($clog2((32 >> 3)) + 1)) : (2 - $clog2(($clog2((32 >> 3)) + 1))))) + 40) + ((((32 >> 3) - 1) >= 0) ? (32 >> 3) : (2 - (32 >> 3)))) + 49) - 1) >= 0) ? ((NumInstances * (((((((7 + ((($clog2(($clog2((32 >> 3)) + 1)) - 1) >= 0) ? $clog2(($clog2((32 >> 3)) + 1)) : (2 - $clog2(($clog2((32 >> 3)) + 1))))) + 40) + ((((32 >> 3) - 1) >= 0) ? (32 >> 3) : (2 - (32 >> 3)))) + 49) - 1) >= 0) ? ((((((7 + (((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW))) + top_pkg_TL_AIW) + top_pkg_TL_AW) + (((top_pkg_TL_DBW - 1) >= 0) ? top_pkg_TL_DBW : (2 - top_pkg_TL_DBW))) + top_pkg_TL_DW) + 17) : (2 - ((((((7 + (((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW))) + top_pkg_TL_AIW) + top_pkg_TL_AW) + (((top_pkg_TL_DBW - 1) >= 0) ? top_pkg_TL_DBW : (2 - top_pkg_TL_DBW))) + top_pkg_TL_DW) + 17)))) + -1) : ((NumInstances * ((0 >= (((((7 + ((($clog2(($clog2((32 >> 3)) + 1)) - 1) >= 0) ? $clog2(($clog2((32 >> 3)) + 1)) : (2 - $clog2(($clog2((32 >> 3)) + 1))))) + 40) + ((((32 >> 3) - 1) >= 0) ? (32 >> 3) : (2 - (32 >> 3)))) + 49) - 1)) ? (2 - ((((((7 + (((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW))) + top_pkg_TL_AIW) + top_pkg_TL_AW) + (((top_pkg_TL_DBW - 1) >= 0) ? top_pkg_TL_DBW : (2 - top_pkg_TL_DBW))) + top_pkg_TL_DW) + 17)) : ((((((7 + (((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW))) + top_pkg_TL_AIW) + top_pkg_TL_AW) + (((top_pkg_TL_DBW - 1) >= 0) ? top_pkg_TL_DBW : (2 - top_pkg_TL_DBW))) + top_pkg_TL_DW) + 17))) + ((((((((7 + (((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW))) + top_pkg_TL_AIW) + top_pkg_TL_AW) + (((top_pkg_TL_DBW - 1) >= 0) ? top_pkg_TL_DBW : (2 - top_pkg_TL_DBW))) + top_pkg_TL_DW) + 17) - 1) - 1))):(((((((7 + ((($clog2(($clog2((32 >> 3)) + 1)) - 1) >= 0) ? $clog2(($clog2((32 >> 3)) + 1)) : (2 - $clog2(($clog2((32 >> 3)) + 1))))) + 40) + ((((32 >> 3) - 1) >= 0) ? (32 >> 3) : (2 - (32 >> 3)))) + 49) - 1) >= 0) ? 0 : (((((((7 + (((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW))) + top_pkg_TL_AIW) + top_pkg_TL_AW) + (((top_pkg_TL_DBW - 1) >= 0) ? top_pkg_TL_DBW : (2 - top_pkg_TL_DBW))) + top_pkg_TL_DW) + 17) - 1))] tl_i;
	output wire [(((((7 + ((($clog2(($clog2((32 >> 3)) + 1)) - 1) >= 0) ? $clog2(($clog2((32 >> 3)) + 1)) : (2 - $clog2(($clog2((32 >> 3)) + 1))))) + 59) - 1) >= 0) ? ((NumInstances * (((((7 + ((($clog2(($clog2((32 >> 3)) + 1)) - 1) >= 0) ? $clog2(($clog2((32 >> 3)) + 1)) : (2 - $clog2(($clog2((32 >> 3)) + 1))))) + 59) - 1) >= 0) ? ((((((7 + (((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW))) + top_pkg_TL_AIW) + top_pkg_TL_DIW) + top_pkg_TL_DW) + top_pkg_TL_DUW) + 2) : (2 - ((((((7 + (((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW))) + top_pkg_TL_AIW) + top_pkg_TL_DIW) + top_pkg_TL_DW) + top_pkg_TL_DUW) + 2)))) + -1) : ((NumInstances * ((0 >= (((7 + ((($clog2(($clog2((32 >> 3)) + 1)) - 1) >= 0) ? $clog2(($clog2((32 >> 3)) + 1)) : (2 - $clog2(($clog2((32 >> 3)) + 1))))) + 59) - 1)) ? (2 - ((((((7 + (((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW))) + top_pkg_TL_AIW) + top_pkg_TL_DIW) + top_pkg_TL_DW) + top_pkg_TL_DUW) + 2)) : ((((((7 + (((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW))) + top_pkg_TL_AIW) + top_pkg_TL_DIW) + top_pkg_TL_DW) + top_pkg_TL_DUW) + 2))) + ((((((((7 + (((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW))) + top_pkg_TL_AIW) + top_pkg_TL_DIW) + top_pkg_TL_DW) + top_pkg_TL_DUW) + 2) - 1) - 1))):(((((7 + ((($clog2(($clog2((32 >> 3)) + 1)) - 1) >= 0) ? $clog2(($clog2((32 >> 3)) + 1)) : (2 - $clog2(($clog2((32 >> 3)) + 1))))) + 59) - 1) >= 0) ? 0 : (((((((7 + (((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW))) + top_pkg_TL_AIW) + top_pkg_TL_DIW) + top_pkg_TL_DW) + top_pkg_TL_DUW) + 2) - 1))] tl_o;
	input [((NumInstances * NumSrc) + -1):0] intr_src_i;
	output [((NumInstances * NumTarget) + -1):0] irq_o;
	output [((((((NumInstances * (2 - NumTarget)) + ((NumTarget - 1) - 1)) - (NumTarget - 1)) + 1) * 6) + (((NumTarget - 1) * 6) - 1)):((NumTarget - 1) * 6)] irq_id_o;
	output wire [((NumInstances * NumTarget) + -1):0] msip_o;
	rv_plic i_rv_plic(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.tl_i(tl_i[((((((((7 + ((($clog2(($clog2((32 >> 3)) + 1)) - 1) >= 0) ? $clog2(($clog2((32 >> 3)) + 1)) : (2 - $clog2(($clog2((32 >> 3)) + 1))))) + 40) + ((((32 >> 3) - 1) >= 0) ? (32 >> 3) : (2 - (32 >> 3)))) + 49) - 1) >= 0) ? 0 : (((((((7 + (((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW))) + top_pkg_TL_AIW) + top_pkg_TL_AW) + (((top_pkg_TL_DBW - 1) >= 0) ? top_pkg_TL_DBW : (2 - top_pkg_TL_DBW))) + top_pkg_TL_DW) + 17) - 1)) + (0 * (((((((7 + ((($clog2(($clog2((32 >> 3)) + 1)) - 1) >= 0) ? $clog2(($clog2((32 >> 3)) + 1)) : (2 - $clog2(($clog2((32 >> 3)) + 1))))) + 40) + ((((32 >> 3) - 1) >= 0) ? (32 >> 3) : (2 - (32 >> 3)))) + 49) - 1) >= 0) ? ((((((7 + (((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW))) + top_pkg_TL_AIW) + top_pkg_TL_AW) + (((top_pkg_TL_DBW - 1) >= 0) ? top_pkg_TL_DBW : (2 - top_pkg_TL_DBW))) + top_pkg_TL_DW) + 17) : (2 - ((((((7 + (((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW))) + top_pkg_TL_AIW) + top_pkg_TL_AW) + (((top_pkg_TL_DBW - 1) >= 0) ? top_pkg_TL_DBW : (2 - top_pkg_TL_DBW))) + top_pkg_TL_DW) + 17)))))+:(((((((7 + ((($clog2(($clog2((32 >> 3)) + 1)) - 1) >= 0) ? $clog2(($clog2((32 >> 3)) + 1)) : (2 - $clog2(($clog2((32 >> 3)) + 1))))) + 40) + ((((32 >> 3) - 1) >= 0) ? (32 >> 3) : (2 - (32 >> 3)))) + 49) - 1) >= 0) ? ((((((7 + (((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW))) + top_pkg_TL_AIW) + top_pkg_TL_AW) + (((top_pkg_TL_DBW - 1) >= 0) ? top_pkg_TL_DBW : (2 - top_pkg_TL_DBW))) + top_pkg_TL_DW) + 17) : (2 - ((((((7 + (((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW))) + top_pkg_TL_AIW) + top_pkg_TL_AW) + (((top_pkg_TL_DBW - 1) >= 0) ? top_pkg_TL_DBW : (2 - top_pkg_TL_DBW))) + top_pkg_TL_DW) + 17)))]),
		.tl_o(tl_o[((((((7 + ((($clog2(($clog2((32 >> 3)) + 1)) - 1) >= 0) ? $clog2(($clog2((32 >> 3)) + 1)) : (2 - $clog2(($clog2((32 >> 3)) + 1))))) + 59) - 1) >= 0) ? 0 : (((((((7 + (((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW))) + top_pkg_TL_AIW) + top_pkg_TL_DIW) + top_pkg_TL_DW) + top_pkg_TL_DUW) + 2) - 1)) + (0 * (((((7 + ((($clog2(($clog2((32 >> 3)) + 1)) - 1) >= 0) ? $clog2(($clog2((32 >> 3)) + 1)) : (2 - $clog2(($clog2((32 >> 3)) + 1))))) + 59) - 1) >= 0) ? ((((((7 + (((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW))) + top_pkg_TL_AIW) + top_pkg_TL_DIW) + top_pkg_TL_DW) + top_pkg_TL_DUW) + 2) : (2 - ((((((7 + (((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW))) + top_pkg_TL_AIW) + top_pkg_TL_DIW) + top_pkg_TL_DW) + top_pkg_TL_DUW) + 2)))))+:(((((7 + ((($clog2(($clog2((32 >> 3)) + 1)) - 1) >= 0) ? $clog2(($clog2((32 >> 3)) + 1)) : (2 - $clog2(($clog2((32 >> 3)) + 1))))) + 59) - 1) >= 0) ? ((((((7 + (((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW))) + top_pkg_TL_AIW) + top_pkg_TL_DIW) + top_pkg_TL_DW) + top_pkg_TL_DUW) + 2) : (2 - ((((((7 + (((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW))) + top_pkg_TL_AIW) + top_pkg_TL_DIW) + top_pkg_TL_DW) + top_pkg_TL_DUW) + 2)))]),
		.intr_src_i(intr_src_i[(0 + (0 * NumSrc))+:NumSrc]),
		.irq_o(irq_o[(0 + (0 * NumTarget))+:NumTarget]),
		.irq_id_o(irq_id_o[((6 * ((NumTarget - 1) + (0 * (2 - NumTarget)))) + 0)+:(6 * (2 - NumTarget))]),
		.msip_o(msip_o[(0 + (0 * NumTarget))+:NumTarget])
	);
endmodule
