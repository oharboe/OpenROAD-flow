module aes_core (
	clk_i,
	rst_ni,
	reg2hw,
	hw2reg
);
	parameter AES192Enable = 1;
	input clk_i;
	input rst_ni;
	input wire [540:0] reg2hw;
	output wire [145:0] hw2reg;
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
	function automatic [7:0] aes_mul2;
		input reg [7:0] in;
		begin
			aes_mul2[7] = in[6];
			aes_mul2[6] = in[5];
			aes_mul2[5] = in[4];
			aes_mul2[4] = (in[3] ^ in[7]);
			aes_mul2[3] = (in[2] ^ in[7]);
			aes_mul2[2] = in[1];
			aes_mul2[1] = (in[0] ^ in[7]);
			aes_mul2[0] = in[7];
		end
	endfunction
	function automatic [7:0] aes_mul4;
		input reg [7:0] in;
		aes_mul4 = aes_mul2(aes_mul2(in));
	endfunction
	function automatic [7:0] aes_div2;
		input reg [7:0] in;
		begin
			aes_div2[7] = in[0];
			aes_div2[6] = in[7];
			aes_div2[5] = in[6];
			aes_div2[4] = in[5];
			aes_div2[3] = (in[4] ^ in[0]);
			aes_div2[2] = (in[3] ^ in[0]);
			aes_div2[1] = in[2];
			aes_div2[0] = (in[1] ^ in[0]);
		end
	endfunction
	localparam [0:0] KEY_DEC_EXPAND = 0;
	localparam [0:0] ROUND_KEY_DIRECT = 0;
	localparam [1:0] ADD_RK_INIT = 0;
	localparam [1:0] KEY_FULL_ENC_INIT = 0;
	localparam [1:0] KEY_WORDS_0123 = 0;
	localparam [1:0] STATE_INIT = 0;
	localparam [0:0] KEY_DEC_CLEAR = 1;
	localparam [0:0] ROUND_KEY_MIXED = 1;
	localparam [1:0] ADD_RK_ROUND = 1;
	localparam [1:0] KEY_FULL_DEC_INIT = 1;
	localparam [1:0] KEY_WORDS_2345 = 1;
	localparam [1:0] STATE_ROUND = 1;
	localparam [0:0] AES_ENC = 1'b0;
	localparam [0:0] AES_DEC = 1'b1;
	localparam [1:0] ADD_RK_FINAL = 2;
	localparam [1:0] KEY_FULL_ROUND = 2;
	localparam [1:0] KEY_WORDS_4567 = 2;
	localparam [1:0] STATE_CLEAR = 2;
	localparam [1:0] KEY_FULL_CLEAR = 3;
	localparam [1:0] KEY_WORDS_ZERO = 3;
	localparam [2:0] AES_128 = 3'b001;
	localparam [2:0] AES_192 = 3'b010;
	localparam [2:0] AES_256 = 3'b100;
	wire [31:0] data_in [0:(4 - 1)];
	wire [3:0] data_in_qe;
	wire [31:0] key_init [0:(8 - 1)];
	wire [7:0] key_init_qe;
	wire [0:0] mode;
	wire [0:0] key_expand_mode;
	wire [2:0] key_len_q;
	reg [2:0] key_len;
	reg [7:0] state_init [0:(16 - 1)];
	reg [127:0] state_d;
	reg [127:0] state_q;
	wire state_we;
	wire [1:0] state_sel;
	wire [127:0] sub_bytes_out;
	wire [127:0] shift_rows_out;
	wire [127:0] mix_columns_out;
	reg [127:0] add_round_key_in;
	reg [7:0] add_round_key_out [0:(16 - 1)];
	wire [1:0] add_round_key_in_sel;
	reg [255:0] key_full_d;
	reg [255:0] key_full_q;
	wire key_full_we;
	wire [1:0] key_full_sel;
	reg [255:0] key_dec_d;
	reg [255:0] key_dec_q;
	wire key_dec_we;
	wire [0:0] key_dec_sel;
	wire [255:0] key_expand_out;
	wire key_expand_step;
	wire key_expand_clear;
	wire [3:0] key_expand_round;
	wire [1:0] key_words_sel;
	reg [127:0] key_words;
	reg [127:0] key_bytes;
	wire [127:0] key_mix_columns_out;
	reg [127:0] round_key;
	wire [0:0] round_key_sel;
	reg [31:0] data_out_d [0:(4 - 1)];
	reg [127:0] data_out_q;
	wire data_out_we;
	wire [3:0] data_out_re;
	wire [31:0] unused_data_out_q [0:(4 - 1)];
	wire unused_mode_qe;
	wire unused_manual_start_trigger_qe;
	wire unused_force_data_overwrite_qe;
	assign key_init[0] = reg2hw[278+:32];
	assign key_init[1] = reg2hw[311+:32];
	assign key_init[2] = reg2hw[344+:32];
	assign key_init[3] = reg2hw[377+:32];
	assign key_init[4] = reg2hw[410+:32];
	assign key_init[5] = reg2hw[443+:32];
	assign key_init[6] = reg2hw[476+:32];
	assign key_init[7] = reg2hw[509+:32];
	assign key_init_qe = {reg2hw[508+:1], reg2hw[475+:1], reg2hw[442+:1], reg2hw[409+:1], reg2hw[376+:1], reg2hw[343+:1], reg2hw[310+:1], reg2hw[277+:1]};
	assign data_in[0] = reg2hw[146+:32];
	assign data_in[1] = reg2hw[179+:32];
	assign data_in[2] = reg2hw[212+:32];
	assign data_in[3] = reg2hw[245+:32];
	assign data_in_qe = {reg2hw[244+:1], reg2hw[211+:1], reg2hw[178+:1], reg2hw[145+:1]};
	always @(*) begin : conv_data_in_to_state
		begin : sv2v_autoblock_16
			reg signed [31:0] i;
			for (i = 0; (i < 4); i = (i + 1))
				begin
					state_init[((4 * i) + 0)] = data_in[i][7:0];
					state_init[((4 * i) + 1)] = data_in[i][15:8];
					state_init[((4 * i) + 2)] = data_in[i][23:16];
					state_init[((4 * i) + 3)] = data_in[i][31:24];
				end
		end
	end
	assign mode = reg2hw[12:12];
	assign key_len_q = reg2hw[10:8];
	always @(*) begin : get_key_len
		case (key_len_q)
			AES_128: key_len = AES_128;
			AES_256: key_len = AES_256;
			AES_192: key_len = (AES192Enable ? AES_192 : AES_128);
			default: key_len = AES_128;
		endcase
	end
	assign data_out_re = {reg2hw[112+:1], reg2hw[79+:1], reg2hw[46+:1], reg2hw[13+:1]};
	assign unused_data_out_q[0] = reg2hw[14+:32];
	assign unused_data_out_q[1] = reg2hw[47+:32];
	assign unused_data_out_q[2] = reg2hw[80+:32];
	assign unused_data_out_q[3] = reg2hw[113+:32];
	assign unused_mode_qe = reg2hw[11:11];
	assign unused_manual_start_trigger_qe = reg2hw[5:5];
	assign unused_force_data_overwrite_qe = reg2hw[3:3];
	always @(*) begin : state_mux
		case (state_sel)
			STATE_INIT: state_d = state_init;
			STATE_ROUND: state_d = add_round_key_out;
			STATE_CLEAR: state_d = {16 {1'sb0}};
			default: state_d = {16 {1'sbX}};
		endcase
	end
	always @(posedge clk_i or negedge rst_ni) begin : state_reg
		if (!rst_ni)
			state_q <= {16 {1'sb0}};
		else if (state_we)
			state_q <= state_d;
	end
	aes_sub_bytes aes_sub_bytes(
		.mode_i(mode),
		.data_i(state_q),
		.data_o(sub_bytes_out)
	);
	aes_shift_rows aes_shift_rows(
		.mode_i(mode),
		.data_i(sub_bytes_out),
		.data_o(shift_rows_out)
	);
	aes_mix_columns aes_mix_columns(
		.mode_i(mode),
		.data_i(shift_rows_out),
		.data_o(mix_columns_out)
	);
	always @(*) begin : add_round_key_in_mux
		case (add_round_key_in_sel)
			ADD_RK_INIT: add_round_key_in = state_q;
			ADD_RK_ROUND: add_round_key_in = mix_columns_out;
			ADD_RK_FINAL: add_round_key_in = shift_rows_out;
			default: add_round_key_in = {16 {1'sbX}};
		endcase
	end
	always @(*) begin : add_round_key
		begin : sv2v_autoblock_17
			reg signed [31:0] i;
			for (i = 0; (i < 16); i = (i + 1))
				add_round_key_out[i] = (add_round_key_in[((15 - i) * 8)+:8] ^ round_key[((15 - i) * 8)+:8]);
		end
	end
	always @(*) begin : key_full_mux
		case (key_full_sel)
			KEY_FULL_ENC_INIT: key_full_d = key_init;
			KEY_FULL_DEC_INIT: key_full_d = key_dec_q;
			KEY_FULL_ROUND: key_full_d = key_expand_out;
			KEY_FULL_CLEAR: key_full_d = {8 {1'sb0}};
			default: key_full_d = {8 {1'sbX}};
		endcase
	end
	always @(posedge clk_i or negedge rst_ni) begin : key_full_reg
		if (!rst_ni)
			key_full_q <= {8 {1'sb0}};
		else if (key_full_we)
			key_full_q <= key_full_d;
	end
	always @(*) begin : key_dec_mux
		case (key_dec_sel)
			KEY_DEC_EXPAND: key_dec_d = key_expand_out;
			KEY_DEC_CLEAR: key_dec_d = {8 {1'sb0}};
			default: key_dec_d = {8 {1'sbX}};
		endcase
	end
	always @(posedge clk_i or negedge rst_ni) begin : key_dec_reg
		if (!rst_ni)
			key_dec_q <= {8 {1'sb0}};
		else if (key_dec_we)
			key_dec_q <= key_dec_d;
	end
	aes_key_expand #(.AES192Enable(AES192Enable)) aes_key_expand(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.mode_i(key_expand_mode),
		.step_i(key_expand_step),
		.clear_i(key_expand_clear),
		.round_i(key_expand_round),
		.key_len_i(key_len),
		.key_i(key_full_q),
		.key_o(key_expand_out)
	);
	always @(*) begin : key_words_mux
		case (key_words_sel)
			KEY_WORDS_0123: begin
				key_words[96+:32] = key_full_q[224+:32];
				key_words[64+:32] = key_full_q[192+:32];
				key_words[32+:32] = key_full_q[160+:32];
				key_words[0+:32] = key_full_q[128+:32];
			end
			KEY_WORDS_2345:
				if (AES192Enable) begin
					key_words[96+:32] = key_full_q[160+:32];
					key_words[64+:32] = key_full_q[128+:32];
					key_words[32+:32] = key_full_q[96+:32];
					key_words[0+:32] = key_full_q[64+:32];
				end
				else
					key_words = {4 {1'sbX}};
			KEY_WORDS_4567: begin
				key_words[96+:32] = key_full_q[96+:32];
				key_words[64+:32] = key_full_q[64+:32];
				key_words[32+:32] = key_full_q[32+:32];
				key_words[0+:32] = key_full_q[0+:32];
			end
			KEY_WORDS_ZERO: key_words = {4 {1'sb0}};
			default: key_words = {4 {1'sbX}};
		endcase
	end
	always @(*) begin : conv_key_words_to_bytes
		begin : sv2v_autoblock_18
			reg signed [31:0] i;
			for (i = 0; (i < 4); i = (i + 1))
				begin
					key_bytes[((15 - (4 * i)) * 8)+:8] = key_words[((3 - i) * 32)+:8];
					key_bytes[((15 - ((4 * i) + 1)) * 8)+:8] = key_words[(((3 - i) * 32) + 8)+:8];
					key_bytes[((15 - ((4 * i) + 2)) * 8)+:8] = key_words[(((3 - i) * 32) + 16)+:8];
					key_bytes[((15 - ((4 * i) + 3)) * 8)+:8] = key_words[(((3 - i) * 32) + 24)+:8];
				end
		end
	end
	aes_mix_columns aes_key_mix_columns(
		.mode_i(AES_DEC),
		.data_i(key_bytes),
		.data_o(key_mix_columns_out)
	);
	always @(*) begin : round_key_mux
		case (round_key_sel)
			ROUND_KEY_DIRECT: round_key = key_bytes;
			ROUND_KEY_MIXED: round_key = key_mix_columns_out;
			default: round_key = {16 {1'sbX}};
		endcase
	end
	always @(*) begin : conv_add_rk_out_to_data_out
		begin : sv2v_autoblock_19
			reg signed [31:0] i;
			for (i = 0; (i < 4); i = (i + 1))
				data_out_d[i] = {add_round_key_out[((4 * i) + 3)], add_round_key_out[((4 * i) + 2)], add_round_key_out[((4 * i) + 1)], add_round_key_out[((4 * i) + 0)]};
		end
	end
	always @(posedge clk_i or negedge rst_ni) begin : data_out_reg
		if (!rst_ni)
			data_out_q <= {4 {1'sb0}};
		else if (data_out_we)
			data_out_q <= data_out_d;
	end
	aes_control #(.AES192Enable(AES192Enable)) aes_control(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.mode_i(mode),
		.key_len_i(key_len),
		.force_data_overwrite_i(reg2hw[4:4]),
		.manual_start_trigger_i(reg2hw[6:6]),
		.start_i(reg2hw[2:2]),
		.key_clear_i(reg2hw[1:1]),
		.data_out_clear_i(reg2hw[0:0]),
		.data_in_qe_i(data_in_qe),
		.key_init_qe_i(key_init_qe),
		.data_out_re_i(data_out_re),
		.state_sel_o(state_sel),
		.state_we_o(state_we),
		.add_rk_sel_o(add_round_key_in_sel),
		.key_expand_mode_o(key_expand_mode),
		.key_full_sel_o(key_full_sel),
		.key_full_we_o(key_full_we),
		.key_dec_sel_o(key_dec_sel),
		.key_dec_we_o(key_dec_we),
		.key_expand_step_o(key_expand_step),
		.key_expand_clear_o(key_expand_clear),
		.key_expand_round_o(key_expand_round),
		.key_words_sel_o(key_words_sel),
		.round_key_sel_o(round_key_sel),
		.data_out_we_o(data_out_we),
		.start_o(hw2reg[13:13]),
		.start_we_o(hw2reg[12:12]),
		.key_clear_o(hw2reg[11:11]),
		.key_clear_we_o(hw2reg[10:10]),
		.data_out_clear_o(hw2reg[9:9]),
		.data_out_clear_we_o(hw2reg[8:8]),
		.output_valid_o(hw2reg[3:3]),
		.output_valid_we_o(hw2reg[2:2]),
		.input_ready_o(hw2reg[1:1]),
		.input_ready_we_o(hw2reg[0:0]),
		.idle_o(hw2reg[7:7]),
		.idle_we_o(hw2reg[6:6]),
		.stall_o(hw2reg[5:5]),
		.stall_we_o(hw2reg[4:4])
	);
	assign hw2reg[18+:32] = data_out_q[96+:32];
	assign hw2reg[50+:32] = data_out_q[64+:32];
	assign hw2reg[82+:32] = data_out_q[32+:32];
	assign hw2reg[114+:32] = data_out_q[0+:32];
	assign hw2reg[17:15] = key_len;
	assign hw2reg[14:14] = reg2hw[7:7];
endmodule
