module rv_plic (
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
	localparam signed [31:0] SRCW = 6;
	input clk_i;
	input rst_ni;
	input wire [(((((((7 + (((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW))) + top_pkg_TL_AIW) + top_pkg_TL_AW) + (((top_pkg_TL_DBW - 1) >= 0) ? top_pkg_TL_DBW : (2 - top_pkg_TL_DBW))) + top_pkg_TL_DW) + 17) - 1):0] tl_i;
	output wire [(((((((7 + (((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW))) + top_pkg_TL_AIW) + top_pkg_TL_DIW) + top_pkg_TL_DW) + top_pkg_TL_DUW) + 2) - 1):0] tl_o;
	input [(NumSrc - 1):0] intr_src_i;
	output [(NumTarget - 1):0] irq_o;
	output [(((2 - NumTarget) * SRCW) + (((NumTarget - 1) * SRCW) - 1)):((NumTarget - 1) * SRCW)] irq_id_o;
	output wire [(NumTarget - 1):0] msip_o;
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
	wire [230:0] reg2hw;
	wire [115:0] hw2reg;
	localparam signed [31:0] MAX_PRIO = 3;
	localparam signed [31:0] PRIOW = 2;
	wire [(NumSrc - 1):0] le;
	wire [(NumSrc - 1):0] ip;
	wire [(NumSrc - 1):0] ie [0:(NumTarget - 1)];
	wire [(NumTarget - 1):0] claim_re;
	wire [(SRCW - 1):0] claim_id [0:(NumTarget - 1)];
	reg [(NumSrc - 1):0] claim;
	wire [(NumTarget - 1):0] complete_we;
	wire [(SRCW - 1):0] complete_id [0:(NumTarget - 1)];
	reg [(NumSrc - 1):0] complete;
	wire [(((2 - NumTarget) * SRCW) + (((NumTarget - 1) * SRCW) - 1)):((NumTarget - 1) * SRCW)] cc_id;
	wire [((NumSrc * PRIOW) + -1):0] prio;
	wire [(PRIOW - 1):0] threshold [0:(NumTarget - 1)];
	assign cc_id = irq_id_o;
	always @(*) begin
		claim = 1'sb0;
		begin : sv2v_autoblock_1
			reg signed [31:0] i;
			for (i = 0; (i < NumTarget); i = (i + 1))
				if (claim_re[i])
					claim[(claim_id[i] - 1)] = 1'b1;
		end
	end
	always @(*) begin
		complete = 1'sb0;
		begin : sv2v_autoblock_2
			reg signed [31:0] i;
			for (i = 0; (i < NumTarget); i = (i + 1))
				if (complete_we[i])
					complete[(complete_id[i] - 1)] = 1'b1;
		end
	end
	assign prio[(0 + ((NumSrc - 1) * PRIOW))+:PRIOW] = reg2hw[175:174];
	assign prio[(0 + (((NumSrc - 1) - 1) * PRIOW))+:PRIOW] = reg2hw[173:172];
	assign prio[(0 + (((NumSrc - 1) - 2) * PRIOW))+:PRIOW] = reg2hw[171:170];
	assign prio[(0 + (((NumSrc - 1) - 3) * PRIOW))+:PRIOW] = reg2hw[169:168];
	assign prio[(0 + (((NumSrc - 1) - 4) * PRIOW))+:PRIOW] = reg2hw[167:166];
	assign prio[(0 + (((NumSrc - 1) - 5) * PRIOW))+:PRIOW] = reg2hw[165:164];
	assign prio[(0 + (((NumSrc - 1) - 6) * PRIOW))+:PRIOW] = reg2hw[163:162];
	assign prio[(0 + (((NumSrc - 1) - 7) * PRIOW))+:PRIOW] = reg2hw[161:160];
	assign prio[(0 + (((NumSrc - 1) - 8) * PRIOW))+:PRIOW] = reg2hw[159:158];
	assign prio[(0 + (((NumSrc - 1) - 9) * PRIOW))+:PRIOW] = reg2hw[157:156];
	assign prio[(0 + (((NumSrc - 1) - 10) * PRIOW))+:PRIOW] = reg2hw[155:154];
	assign prio[(0 + (((NumSrc - 1) - 11) * PRIOW))+:PRIOW] = reg2hw[153:152];
	assign prio[(0 + (((NumSrc - 1) - 12) * PRIOW))+:PRIOW] = reg2hw[151:150];
	assign prio[(0 + (((NumSrc - 1) - 13) * PRIOW))+:PRIOW] = reg2hw[149:148];
	assign prio[(0 + (((NumSrc - 1) - 14) * PRIOW))+:PRIOW] = reg2hw[147:146];
	assign prio[(0 + (((NumSrc - 1) - 15) * PRIOW))+:PRIOW] = reg2hw[145:144];
	assign prio[(0 + (((NumSrc - 1) - 16) * PRIOW))+:PRIOW] = reg2hw[143:142];
	assign prio[(0 + (((NumSrc - 1) - 17) * PRIOW))+:PRIOW] = reg2hw[141:140];
	assign prio[(0 + (((NumSrc - 1) - 18) * PRIOW))+:PRIOW] = reg2hw[139:138];
	assign prio[(0 + (((NumSrc - 1) - 19) * PRIOW))+:PRIOW] = reg2hw[137:136];
	assign prio[(0 + (((NumSrc - 1) - 20) * PRIOW))+:PRIOW] = reg2hw[135:134];
	assign prio[(0 + (((NumSrc - 1) - 21) * PRIOW))+:PRIOW] = reg2hw[133:132];
	assign prio[(0 + (((NumSrc - 1) - 22) * PRIOW))+:PRIOW] = reg2hw[131:130];
	assign prio[(0 + (((NumSrc - 1) - 23) * PRIOW))+:PRIOW] = reg2hw[129:128];
	assign prio[(0 + (((NumSrc - 1) - 24) * PRIOW))+:PRIOW] = reg2hw[127:126];
	assign prio[(0 + (((NumSrc - 1) - 25) * PRIOW))+:PRIOW] = reg2hw[125:124];
	assign prio[(0 + (((NumSrc - 1) - 26) * PRIOW))+:PRIOW] = reg2hw[123:122];
	assign prio[(0 + (((NumSrc - 1) - 27) * PRIOW))+:PRIOW] = reg2hw[121:120];
	assign prio[(0 + (((NumSrc - 1) - 28) * PRIOW))+:PRIOW] = reg2hw[119:118];
	assign prio[(0 + (((NumSrc - 1) - 29) * PRIOW))+:PRIOW] = reg2hw[117:116];
	assign prio[(0 + (((NumSrc - 1) - 30) * PRIOW))+:PRIOW] = reg2hw[115:114];
	assign prio[(0 + (((NumSrc - 1) - 31) * PRIOW))+:PRIOW] = reg2hw[113:112];
	assign prio[(0 + (((NumSrc - 1) - 32) * PRIOW))+:PRIOW] = reg2hw[111:110];
	assign prio[(0 + (((NumSrc - 1) - 33) * PRIOW))+:PRIOW] = reg2hw[109:108];
	assign prio[(0 + (((NumSrc - 1) - 34) * PRIOW))+:PRIOW] = reg2hw[107:106];
	assign prio[(0 + (((NumSrc - 1) - 35) * PRIOW))+:PRIOW] = reg2hw[105:104];
	assign prio[(0 + (((NumSrc - 1) - 36) * PRIOW))+:PRIOW] = reg2hw[103:102];
	assign prio[(0 + (((NumSrc - 1) - 37) * PRIOW))+:PRIOW] = reg2hw[101:100];
	assign prio[(0 + (((NumSrc - 1) - 38) * PRIOW))+:PRIOW] = reg2hw[99:98];
	assign prio[(0 + (((NumSrc - 1) - 39) * PRIOW))+:PRIOW] = reg2hw[97:96];
	assign prio[(0 + (((NumSrc - 1) - 40) * PRIOW))+:PRIOW] = reg2hw[95:94];
	assign prio[(0 + (((NumSrc - 1) - 41) * PRIOW))+:PRIOW] = reg2hw[93:92];
	assign prio[(0 + (((NumSrc - 1) - 42) * PRIOW))+:PRIOW] = reg2hw[91:90];
	assign prio[(0 + (((NumSrc - 1) - 43) * PRIOW))+:PRIOW] = reg2hw[89:88];
	assign prio[(0 + (((NumSrc - 1) - 44) * PRIOW))+:PRIOW] = reg2hw[87:86];
	assign prio[(0 + (((NumSrc - 1) - 45) * PRIOW))+:PRIOW] = reg2hw[85:84];
	assign prio[(0 + (((NumSrc - 1) - 46) * PRIOW))+:PRIOW] = reg2hw[83:82];
	assign prio[(0 + (((NumSrc - 1) - 47) * PRIOW))+:PRIOW] = reg2hw[81:80];
	assign prio[(0 + (((NumSrc - 1) - 48) * PRIOW))+:PRIOW] = reg2hw[79:78];
	assign prio[(0 + (((NumSrc - 1) - 49) * PRIOW))+:PRIOW] = reg2hw[77:76];
	assign prio[(0 + (((NumSrc - 1) - 50) * PRIOW))+:PRIOW] = reg2hw[75:74];
	assign prio[(0 + (((NumSrc - 1) - 51) * PRIOW))+:PRIOW] = reg2hw[73:72];
	assign prio[(0 + (((NumSrc - 1) - 52) * PRIOW))+:PRIOW] = reg2hw[71:70];
	assign prio[(0 + (((NumSrc - 1) - 53) * PRIOW))+:PRIOW] = reg2hw[69:68];
	assign prio[(0 + (((NumSrc - 1) - 54) * PRIOW))+:PRIOW] = reg2hw[67:66];
	generate
		genvar gen_ie0_s;
		for (gen_ie0_s = 0; (gen_ie0_s < 55); gen_ie0_s = (gen_ie0_s + 1)) begin : gen_ie0
			assign ie[0][gen_ie0_s] = reg2hw[(gen_ie0_s + 11)+:1];
		end
	endgenerate
	assign threshold[0] = reg2hw[10:9];
	assign claim_re[0] = reg2hw[1:1];
	assign claim_id[0] = irq_id_o[(0 + (0 * SRCW))+:SRCW];
	assign complete_we[0] = reg2hw[2:2];
	assign complete_id[0] = reg2hw[8:3];
	assign hw2reg[5:0] = cc_id[(0 + (0 * SRCW))+:SRCW];
	assign msip_o[0] = reg2hw[0:0];
	generate
		genvar gen_ip_s;
		for (gen_ip_s = 0; (gen_ip_s < 55); gen_ip_s = (gen_ip_s + 1)) begin : gen_ip
			assign hw2reg[((gen_ip_s * 2) + 6)+:1] = 1'b1;
			assign hw2reg[((gen_ip_s * 2) + 7)+:1] = ip[gen_ip_s];
		end
	endgenerate
	generate
		genvar gen_le_s;
		for (gen_le_s = 0; (gen_le_s < 55); gen_le_s = (gen_le_s + 1)) begin : gen_le
			assign le[gen_le_s] = reg2hw[(gen_le_s + 176)+:1];
		end
	endgenerate
	rv_plic_gateway #(.N_SOURCE(NumSrc)) u_gateway(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.src(intr_src_i),
		.le(le),
		.claim(claim),
		.complete(complete),
		.ip(ip)
	);
	generate
		genvar gen_target_i;
		for (gen_target_i = 0; (gen_target_i < NumTarget); gen_target_i = (gen_target_i + 1)) begin : gen_target
			rv_plic_target #(
				.N_SOURCE(NumSrc),
				.MAX_PRIO(MAX_PRIO)
			) u_target(
				.clk_i(clk_i),
				.rst_ni(rst_ni),
				.ip(ip),
				.ie(ie[gen_target_i]),
				.prio(prio),
				.threshold(threshold[gen_target_i]),
				.irq(irq_o[gen_target_i]),
				.irq_id(irq_id_o[(0 + (gen_target_i * SRCW))+:SRCW])
			);
		end
	endgenerate
	rv_plic_reg_top u_reg(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.tl_i(tl_i),
		.tl_o(tl_o),
		.reg2hw(reg2hw),
		.hw2reg(hw2reg),
		.devmode_i(1'b1)
	);
	generate
		genvar k;
		for (k = 0; (k < NumTarget); k = (k + 1)) ;
	endgenerate
endmodule
