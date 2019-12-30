module aes_reg_top (
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
	output wire [540:0] reg2hw;
	input wire [145:0] hw2reg;
	input devmode_i;
	localparam signed [31:0] NumRegsKey = 8;
	localparam signed [31:0] NumRegsData = 4;
	parameter AES_KEY0_OFFSET = 7'h 0;
	parameter AES_KEY1_OFFSET = 7'h 4;
	parameter AES_KEY2_OFFSET = 7'h 8;
	parameter AES_KEY3_OFFSET = 7'h c;
	parameter AES_KEY4_OFFSET = 7'h 10;
	parameter AES_KEY5_OFFSET = 7'h 14;
	parameter AES_KEY6_OFFSET = 7'h 18;
	parameter AES_KEY7_OFFSET = 7'h 1c;
	parameter AES_DATA_IN0_OFFSET = 7'h 20;
	parameter AES_DATA_IN1_OFFSET = 7'h 24;
	parameter AES_DATA_IN2_OFFSET = 7'h 28;
	parameter AES_DATA_IN3_OFFSET = 7'h 2c;
	parameter AES_DATA_OUT0_OFFSET = 7'h 30;
	parameter AES_DATA_OUT1_OFFSET = 7'h 34;
	parameter AES_DATA_OUT2_OFFSET = 7'h 38;
	parameter AES_DATA_OUT3_OFFSET = 7'h 3c;
	parameter AES_CTRL_OFFSET = 7'h 40;
	parameter AES_TRIGGER_OFFSET = 7'h 44;
	parameter AES_STATUS_OFFSET = 7'h 48;
	localparam [75:0] AES_PERMIT = {4'b 1111, 4'b 1111, 4'b 1111, 4'b 1111, 4'b 1111, 4'b 1111, 4'b 1111, 4'b 1111, 4'b 1111, 4'b 1111, 4'b 1111, 4'b 1111, 4'b 1111, 4'b 1111, 4'b 1111, 4'b 1111, 4'b 0001, 4'b 0001, 4'b 0001};
	localparam AES_KEY0 = 0;
	localparam AES_KEY1 = 1;
	localparam AES_DATA_IN2 = 10;
	localparam AES_DATA_IN3 = 11;
	localparam AES_DATA_OUT0 = 12;
	localparam AES_DATA_OUT1 = 13;
	localparam AES_DATA_OUT2 = 14;
	localparam AES_DATA_OUT3 = 15;
	localparam AES_CTRL = 16;
	localparam AES_TRIGGER = 17;
	localparam AES_STATUS = 18;
	localparam AES_KEY2 = 2;
	localparam AES_KEY3 = 3;
	localparam AES_KEY4 = 4;
	localparam AES_KEY5 = 5;
	localparam AES_KEY6 = 6;
	localparam AES_KEY7 = 7;
	localparam AES_DATA_IN0 = 8;
	localparam AES_DATA_IN1 = 9;
	localparam AW = 7;
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
	wire [31:0] key0_wd;
	wire key0_we;
	wire [31:0] key1_wd;
	wire key1_we;
	wire [31:0] key2_wd;
	wire key2_we;
	wire [31:0] key3_wd;
	wire key3_we;
	wire [31:0] key4_wd;
	wire key4_we;
	wire [31:0] key5_wd;
	wire key5_we;
	wire [31:0] key6_wd;
	wire key6_we;
	wire [31:0] key7_wd;
	wire key7_we;
	wire [31:0] data_in0_wd;
	wire data_in0_we;
	wire [31:0] data_in1_wd;
	wire data_in1_we;
	wire [31:0] data_in2_wd;
	wire data_in2_we;
	wire [31:0] data_in3_wd;
	wire data_in3_we;
	wire [31:0] data_out0_qs;
	wire data_out0_re;
	wire [31:0] data_out1_qs;
	wire data_out1_re;
	wire [31:0] data_out2_qs;
	wire data_out2_re;
	wire [31:0] data_out3_qs;
	wire data_out3_re;
	wire ctrl_mode_qs;
	wire ctrl_mode_wd;
	wire ctrl_mode_we;
	wire [2:0] ctrl_key_len_qs;
	wire [2:0] ctrl_key_len_wd;
	wire ctrl_key_len_we;
	wire ctrl_manual_start_trigger_qs;
	wire ctrl_manual_start_trigger_wd;
	wire ctrl_manual_start_trigger_we;
	wire ctrl_force_data_overwrite_qs;
	wire ctrl_force_data_overwrite_wd;
	wire ctrl_force_data_overwrite_we;
	wire trigger_start_qs;
	wire trigger_start_wd;
	wire trigger_start_we;
	wire trigger_key_clear_qs;
	wire trigger_key_clear_wd;
	wire trigger_key_clear_we;
	wire trigger_data_out_clear_qs;
	wire trigger_data_out_clear_wd;
	wire trigger_data_out_clear_we;
	wire status_idle_qs;
	wire status_stall_qs;
	wire status_output_valid_qs;
	wire status_input_ready_qs;
	prim_subreg #(
		.DW(32),
		.SWACCESS("WO"),
		.RESVAL(32'h0)
	) u_key0(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(key0_we),
		.wd(key0_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(reg2hw[277+:1]),
		.q(reg2hw[278+:32]),
		.qs()
	);
	prim_subreg #(
		.DW(32),
		.SWACCESS("WO"),
		.RESVAL(32'h0)
	) u_key1(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(key1_we),
		.wd(key1_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(reg2hw[310+:1]),
		.q(reg2hw[311+:32]),
		.qs()
	);
	prim_subreg #(
		.DW(32),
		.SWACCESS("WO"),
		.RESVAL(32'h0)
	) u_key2(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(key2_we),
		.wd(key2_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(reg2hw[343+:1]),
		.q(reg2hw[344+:32]),
		.qs()
	);
	prim_subreg #(
		.DW(32),
		.SWACCESS("WO"),
		.RESVAL(32'h0)
	) u_key3(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(key3_we),
		.wd(key3_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(reg2hw[376+:1]),
		.q(reg2hw[377+:32]),
		.qs()
	);
	prim_subreg #(
		.DW(32),
		.SWACCESS("WO"),
		.RESVAL(32'h0)
	) u_key4(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(key4_we),
		.wd(key4_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(reg2hw[409+:1]),
		.q(reg2hw[410+:32]),
		.qs()
	);
	prim_subreg #(
		.DW(32),
		.SWACCESS("WO"),
		.RESVAL(32'h0)
	) u_key5(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(key5_we),
		.wd(key5_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(reg2hw[442+:1]),
		.q(reg2hw[443+:32]),
		.qs()
	);
	prim_subreg #(
		.DW(32),
		.SWACCESS("WO"),
		.RESVAL(32'h0)
	) u_key6(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(key6_we),
		.wd(key6_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(reg2hw[475+:1]),
		.q(reg2hw[476+:32]),
		.qs()
	);
	prim_subreg #(
		.DW(32),
		.SWACCESS("WO"),
		.RESVAL(32'h0)
	) u_key7(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(key7_we),
		.wd(key7_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(reg2hw[508+:1]),
		.q(reg2hw[509+:32]),
		.qs()
	);
	prim_subreg #(
		.DW(32),
		.SWACCESS("WO"),
		.RESVAL(32'h0)
	) u_data_in0(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(data_in0_we),
		.wd(data_in0_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(reg2hw[145+:1]),
		.q(reg2hw[146+:32]),
		.qs()
	);
	prim_subreg #(
		.DW(32),
		.SWACCESS("WO"),
		.RESVAL(32'h0)
	) u_data_in1(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(data_in1_we),
		.wd(data_in1_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(reg2hw[178+:1]),
		.q(reg2hw[179+:32]),
		.qs()
	);
	prim_subreg #(
		.DW(32),
		.SWACCESS("WO"),
		.RESVAL(32'h0)
	) u_data_in2(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(data_in2_we),
		.wd(data_in2_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(reg2hw[211+:1]),
		.q(reg2hw[212+:32]),
		.qs()
	);
	prim_subreg #(
		.DW(32),
		.SWACCESS("WO"),
		.RESVAL(32'h0)
	) u_data_in3(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(data_in3_we),
		.wd(data_in3_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(reg2hw[244+:1]),
		.q(reg2hw[245+:32]),
		.qs()
	);
	prim_subreg_ext #(.DW(32)) u_data_out0(
		.re(data_out0_re),
		.we(1'b0),
		.wd(1'sb0),
		.d(hw2reg[18+:32]),
		.qre(reg2hw[13+:1]),
		.qe(),
		.q(reg2hw[14+:32]),
		.qs(data_out0_qs)
	);
	prim_subreg_ext #(.DW(32)) u_data_out1(
		.re(data_out1_re),
		.we(1'b0),
		.wd(1'sb0),
		.d(hw2reg[50+:32]),
		.qre(reg2hw[46+:1]),
		.qe(),
		.q(reg2hw[47+:32]),
		.qs(data_out1_qs)
	);
	prim_subreg_ext #(.DW(32)) u_data_out2(
		.re(data_out2_re),
		.we(1'b0),
		.wd(1'sb0),
		.d(hw2reg[82+:32]),
		.qre(reg2hw[79+:1]),
		.qe(),
		.q(reg2hw[80+:32]),
		.qs(data_out2_qs)
	);
	prim_subreg_ext #(.DW(32)) u_data_out3(
		.re(data_out3_re),
		.we(1'b0),
		.wd(1'sb0),
		.d(hw2reg[114+:32]),
		.qre(reg2hw[112+:1]),
		.qe(),
		.q(reg2hw[113+:32]),
		.qs(data_out3_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RW"),
		.RESVAL(1'h0)
	) u_ctrl_mode(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(ctrl_mode_we),
		.wd(ctrl_mode_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(reg2hw[11:11]),
		.q(reg2hw[12:12]),
		.qs(ctrl_mode_qs)
	);
	prim_subreg #(
		.DW(3),
		.SWACCESS("RW"),
		.RESVAL(3'h1)
	) u_ctrl_key_len(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(ctrl_key_len_we),
		.wd(ctrl_key_len_wd),
		.de(hw2reg[14:14]),
		.d(hw2reg[17:15]),
		.qe(reg2hw[7:7]),
		.q(reg2hw[10:8]),
		.qs(ctrl_key_len_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RW"),
		.RESVAL(1'h0)
	) u_ctrl_manual_start_trigger(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(ctrl_manual_start_trigger_we),
		.wd(ctrl_manual_start_trigger_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(reg2hw[5:5]),
		.q(reg2hw[6:6]),
		.qs(ctrl_manual_start_trigger_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RW"),
		.RESVAL(1'h0)
	) u_ctrl_force_data_overwrite(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(ctrl_force_data_overwrite_we),
		.wd(ctrl_force_data_overwrite_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(reg2hw[3:3]),
		.q(reg2hw[4:4]),
		.qs(ctrl_force_data_overwrite_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RW"),
		.RESVAL(1'h0)
	) u_trigger_start(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(trigger_start_we),
		.wd(trigger_start_wd),
		.de(hw2reg[12:12]),
		.d(hw2reg[13:13]),
		.qe(),
		.q(reg2hw[2:2]),
		.qs(trigger_start_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RW"),
		.RESVAL(1'h0)
	) u_trigger_key_clear(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(trigger_key_clear_we),
		.wd(trigger_key_clear_wd),
		.de(hw2reg[10:10]),
		.d(hw2reg[11:11]),
		.qe(),
		.q(reg2hw[1:1]),
		.qs(trigger_key_clear_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RW"),
		.RESVAL(1'h0)
	) u_trigger_data_out_clear(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(trigger_data_out_clear_we),
		.wd(trigger_data_out_clear_wd),
		.de(hw2reg[8:8]),
		.d(hw2reg[9:9]),
		.qe(),
		.q(reg2hw[0:0]),
		.qs(trigger_data_out_clear_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RO"),
		.RESVAL(1'h0)
	) u_status_idle(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(1'b0),
		.wd(1'sb0),
		.de(hw2reg[6:6]),
		.d(hw2reg[7:7]),
		.qe(),
		.q(),
		.qs(status_idle_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RO"),
		.RESVAL(1'h0)
	) u_status_stall(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(1'b0),
		.wd(1'sb0),
		.de(hw2reg[4:4]),
		.d(hw2reg[5:5]),
		.qe(),
		.q(),
		.qs(status_stall_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RO"),
		.RESVAL(1'h0)
	) u_status_output_valid(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(1'b0),
		.wd(1'sb0),
		.de(hw2reg[2:2]),
		.d(hw2reg[3:3]),
		.qe(),
		.q(),
		.qs(status_output_valid_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RO"),
		.RESVAL(1'h1)
	) u_status_input_ready(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(1'b0),
		.wd(1'sb0),
		.de(hw2reg[0:0]),
		.d(hw2reg[1:1]),
		.qe(),
		.q(),
		.qs(status_input_ready_qs)
	);
	reg [18:0] addr_hit;
	always @(*) begin
		addr_hit = 1'sb0;
		addr_hit[0] = (reg_addr == AES_KEY0_OFFSET);
		addr_hit[1] = (reg_addr == AES_KEY1_OFFSET);
		addr_hit[2] = (reg_addr == AES_KEY2_OFFSET);
		addr_hit[3] = (reg_addr == AES_KEY3_OFFSET);
		addr_hit[4] = (reg_addr == AES_KEY4_OFFSET);
		addr_hit[5] = (reg_addr == AES_KEY5_OFFSET);
		addr_hit[6] = (reg_addr == AES_KEY6_OFFSET);
		addr_hit[7] = (reg_addr == AES_KEY7_OFFSET);
		addr_hit[8] = (reg_addr == AES_DATA_IN0_OFFSET);
		addr_hit[9] = (reg_addr == AES_DATA_IN1_OFFSET);
		addr_hit[10] = (reg_addr == AES_DATA_IN2_OFFSET);
		addr_hit[11] = (reg_addr == AES_DATA_IN3_OFFSET);
		addr_hit[12] = (reg_addr == AES_DATA_OUT0_OFFSET);
		addr_hit[13] = (reg_addr == AES_DATA_OUT1_OFFSET);
		addr_hit[14] = (reg_addr == AES_DATA_OUT2_OFFSET);
		addr_hit[15] = (reg_addr == AES_DATA_OUT3_OFFSET);
		addr_hit[16] = (reg_addr == AES_CTRL_OFFSET);
		addr_hit[17] = (reg_addr == AES_TRIGGER_OFFSET);
		addr_hit[18] = (reg_addr == AES_STATUS_OFFSET);
	end
	assign addrmiss = ((reg_re || reg_we) ? ~|addr_hit : 1'b0);
	always @(*) begin
		wr_err = 1'b0;
		if (((addr_hit[0] && reg_we) && (AES_PERMIT[72+:4] != (AES_PERMIT[72+:4] & reg_be))))
			wr_err = 1'b1;
		if (((addr_hit[1] && reg_we) && (AES_PERMIT[68+:4] != (AES_PERMIT[68+:4] & reg_be))))
			wr_err = 1'b1;
		if (((addr_hit[2] && reg_we) && (AES_PERMIT[64+:4] != (AES_PERMIT[64+:4] & reg_be))))
			wr_err = 1'b1;
		if (((addr_hit[3] && reg_we) && (AES_PERMIT[60+:4] != (AES_PERMIT[60+:4] & reg_be))))
			wr_err = 1'b1;
		if (((addr_hit[4] && reg_we) && (AES_PERMIT[56+:4] != (AES_PERMIT[56+:4] & reg_be))))
			wr_err = 1'b1;
		if (((addr_hit[5] && reg_we) && (AES_PERMIT[52+:4] != (AES_PERMIT[52+:4] & reg_be))))
			wr_err = 1'b1;
		if (((addr_hit[6] && reg_we) && (AES_PERMIT[48+:4] != (AES_PERMIT[48+:4] & reg_be))))
			wr_err = 1'b1;
		if (((addr_hit[7] && reg_we) && (AES_PERMIT[44+:4] != (AES_PERMIT[44+:4] & reg_be))))
			wr_err = 1'b1;
		if (((addr_hit[8] && reg_we) && (AES_PERMIT[40+:4] != (AES_PERMIT[40+:4] & reg_be))))
			wr_err = 1'b1;
		if (((addr_hit[9] && reg_we) && (AES_PERMIT[36+:4] != (AES_PERMIT[36+:4] & reg_be))))
			wr_err = 1'b1;
		if (((addr_hit[10] && reg_we) && (AES_PERMIT[32+:4] != (AES_PERMIT[32+:4] & reg_be))))
			wr_err = 1'b1;
		if (((addr_hit[11] && reg_we) && (AES_PERMIT[28+:4] != (AES_PERMIT[28+:4] & reg_be))))
			wr_err = 1'b1;
		if (((addr_hit[12] && reg_we) && (AES_PERMIT[24+:4] != (AES_PERMIT[24+:4] & reg_be))))
			wr_err = 1'b1;
		if (((addr_hit[13] && reg_we) && (AES_PERMIT[20+:4] != (AES_PERMIT[20+:4] & reg_be))))
			wr_err = 1'b1;
		if (((addr_hit[14] && reg_we) && (AES_PERMIT[16+:4] != (AES_PERMIT[16+:4] & reg_be))))
			wr_err = 1'b1;
		if (((addr_hit[15] && reg_we) && (AES_PERMIT[12+:4] != (AES_PERMIT[12+:4] & reg_be))))
			wr_err = 1'b1;
		if (((addr_hit[16] && reg_we) && (AES_PERMIT[8+:4] != (AES_PERMIT[8+:4] & reg_be))))
			wr_err = 1'b1;
		if (((addr_hit[17] && reg_we) && (AES_PERMIT[4+:4] != (AES_PERMIT[4+:4] & reg_be))))
			wr_err = 1'b1;
		if (((addr_hit[18] && reg_we) && (AES_PERMIT[0+:4] != (AES_PERMIT[0+:4] & reg_be))))
			wr_err = 1'b1;
	end
	assign key0_we = ((addr_hit[0] & reg_we) & ~wr_err);
	assign key0_wd = reg_wdata[31:0];
	assign key1_we = ((addr_hit[1] & reg_we) & ~wr_err);
	assign key1_wd = reg_wdata[31:0];
	assign key2_we = ((addr_hit[2] & reg_we) & ~wr_err);
	assign key2_wd = reg_wdata[31:0];
	assign key3_we = ((addr_hit[3] & reg_we) & ~wr_err);
	assign key3_wd = reg_wdata[31:0];
	assign key4_we = ((addr_hit[4] & reg_we) & ~wr_err);
	assign key4_wd = reg_wdata[31:0];
	assign key5_we = ((addr_hit[5] & reg_we) & ~wr_err);
	assign key5_wd = reg_wdata[31:0];
	assign key6_we = ((addr_hit[6] & reg_we) & ~wr_err);
	assign key6_wd = reg_wdata[31:0];
	assign key7_we = ((addr_hit[7] & reg_we) & ~wr_err);
	assign key7_wd = reg_wdata[31:0];
	assign data_in0_we = ((addr_hit[8] & reg_we) & ~wr_err);
	assign data_in0_wd = reg_wdata[31:0];
	assign data_in1_we = ((addr_hit[9] & reg_we) & ~wr_err);
	assign data_in1_wd = reg_wdata[31:0];
	assign data_in2_we = ((addr_hit[10] & reg_we) & ~wr_err);
	assign data_in2_wd = reg_wdata[31:0];
	assign data_in3_we = ((addr_hit[11] & reg_we) & ~wr_err);
	assign data_in3_wd = reg_wdata[31:0];
	assign data_out0_re = (addr_hit[12] && reg_re);
	assign data_out1_re = (addr_hit[13] && reg_re);
	assign data_out2_re = (addr_hit[14] && reg_re);
	assign data_out3_re = (addr_hit[15] && reg_re);
	assign ctrl_mode_we = ((addr_hit[16] & reg_we) & ~wr_err);
	assign ctrl_mode_wd = reg_wdata[0];
	assign ctrl_key_len_we = ((addr_hit[16] & reg_we) & ~wr_err);
	assign ctrl_key_len_wd = reg_wdata[3:1];
	assign ctrl_manual_start_trigger_we = ((addr_hit[16] & reg_we) & ~wr_err);
	assign ctrl_manual_start_trigger_wd = reg_wdata[4];
	assign ctrl_force_data_overwrite_we = ((addr_hit[16] & reg_we) & ~wr_err);
	assign ctrl_force_data_overwrite_wd = reg_wdata[5];
	assign trigger_start_we = ((addr_hit[17] & reg_we) & ~wr_err);
	assign trigger_start_wd = reg_wdata[0];
	assign trigger_key_clear_we = ((addr_hit[17] & reg_we) & ~wr_err);
	assign trigger_key_clear_wd = reg_wdata[1];
	assign trigger_data_out_clear_we = ((addr_hit[17] & reg_we) & ~wr_err);
	assign trigger_data_out_clear_wd = reg_wdata[2];
	always @(*) begin
		reg_rdata_next = 1'sb0;
		case (1'b1)
			addr_hit[0]: reg_rdata_next[31:0] = 1'sb0;
			addr_hit[1]: reg_rdata_next[31:0] = 1'sb0;
			addr_hit[2]: reg_rdata_next[31:0] = 1'sb0;
			addr_hit[3]: reg_rdata_next[31:0] = 1'sb0;
			addr_hit[4]: reg_rdata_next[31:0] = 1'sb0;
			addr_hit[5]: reg_rdata_next[31:0] = 1'sb0;
			addr_hit[6]: reg_rdata_next[31:0] = 1'sb0;
			addr_hit[7]: reg_rdata_next[31:0] = 1'sb0;
			addr_hit[8]: reg_rdata_next[31:0] = 1'sb0;
			addr_hit[9]: reg_rdata_next[31:0] = 1'sb0;
			addr_hit[10]: reg_rdata_next[31:0] = 1'sb0;
			addr_hit[11]: reg_rdata_next[31:0] = 1'sb0;
			addr_hit[12]: reg_rdata_next[31:0] = data_out0_qs;
			addr_hit[13]: reg_rdata_next[31:0] = data_out1_qs;
			addr_hit[14]: reg_rdata_next[31:0] = data_out2_qs;
			addr_hit[15]: reg_rdata_next[31:0] = data_out3_qs;
			addr_hit[16]: begin
				reg_rdata_next[0] = ctrl_mode_qs;
				reg_rdata_next[3:1] = ctrl_key_len_qs;
				reg_rdata_next[4] = ctrl_manual_start_trigger_qs;
				reg_rdata_next[5] = ctrl_force_data_overwrite_qs;
			end
			addr_hit[17]: begin
				reg_rdata_next[0] = trigger_start_qs;
				reg_rdata_next[1] = trigger_key_clear_qs;
				reg_rdata_next[2] = trigger_data_out_clear_qs;
			end
			addr_hit[18]: begin
				reg_rdata_next[0] = status_idle_qs;
				reg_rdata_next[1] = status_stall_qs;
				reg_rdata_next[2] = status_output_valid_qs;
				reg_rdata_next[3] = status_input_ready_qs;
			end
			default: reg_rdata_next = 1'sb1;
		endcase
	end
endmodule
