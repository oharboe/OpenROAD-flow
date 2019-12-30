module aes_control (
	clk_i,
	rst_ni,
	mode_i,
	key_len_i,
	force_data_overwrite_i,
	manual_start_trigger_i,
	start_i,
	key_clear_i,
	data_out_clear_i,
	data_in_qe_i,
	key_init_qe_i,
	data_out_re_i,
	state_sel_o,
	state_we_o,
	add_rk_sel_o,
	key_expand_mode_o,
	key_full_sel_o,
	key_full_we_o,
	key_dec_sel_o,
	key_dec_we_o,
	key_expand_step_o,
	key_expand_clear_o,
	key_expand_round_o,
	key_words_sel_o,
	round_key_sel_o,
	data_out_we_o,
	start_o,
	start_we_o,
	key_clear_o,
	key_clear_we_o,
	data_out_clear_o,
	data_out_clear_we_o,
	output_valid_o,
	output_valid_we_o,
	input_ready_o,
	input_ready_we_o,
	idle_o,
	idle_we_o,
	stall_o,
	stall_we_o
);
	localparam [1:0] IDLE = 0;
	localparam [1:0] INIT = 1;
	localparam [1:0] ROUND = 2;
	localparam [1:0] FINISH = 3;
	parameter AES192Enable = 1;
	input wire clk_i;
	input wire rst_ni;
	input wire [0:0] mode_i;
	input wire [2:0] key_len_i;
	input wire force_data_overwrite_i;
	input wire manual_start_trigger_i;
	input wire start_i;
	input wire key_clear_i;
	input wire data_out_clear_i;
	input wire [3:0] data_in_qe_i;
	input wire [7:0] key_init_qe_i;
	input wire [3:0] data_out_re_i;
	output reg [1:0] state_sel_o;
	output reg state_we_o;
	output reg [1:0] add_rk_sel_o;
	output wire [0:0] key_expand_mode_o;
	output reg [1:0] key_full_sel_o;
	output reg key_full_we_o;
	output reg [0:0] key_dec_sel_o;
	output reg key_dec_we_o;
	output reg key_expand_step_o;
	output reg key_expand_clear_o;
	output wire [3:0] key_expand_round_o;
	output reg [1:0] key_words_sel_o;
	output reg [0:0] round_key_sel_o;
	output reg data_out_we_o;
	output wire start_o;
	output reg start_we_o;
	output wire key_clear_o;
	output reg key_clear_we_o;
	output wire data_out_clear_o;
	output reg data_out_clear_we_o;
	output wire output_valid_o;
	output wire output_valid_we_o;
	output wire input_ready_o;
	output wire input_ready_we_o;
	output reg idle_o;
	output reg idle_we_o;
	output reg stall_o;
	output reg stall_we_o;
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
	reg [1:0] aes_ctrl_ns;
	reg [1:0] aes_ctrl_cs;
	wire [3:0] data_in_new_d;
	reg [3:0] data_in_new_q;
	wire data_in_new;
	reg data_in_load;
	wire [7:0] key_init_new_d;
	reg [7:0] key_init_new_q;
	wire key_init_new;
	reg dec_key_gen;
	wire [3:0] data_out_read_d;
	reg [3:0] data_out_read_q;
	wire data_out_read;
	reg output_valid_q;
	reg [3:0] round_d;
	reg [3:0] round_q;
	reg [3:0] num_rounds_d;
	reg [3:0] num_rounds_q;
	wire [3:0] num_rounds_regular;
	reg dec_key_gen_d;
	reg dec_key_gen_q;
	wire start;
	wire finish;
	assign start = (manual_start_trigger_i ? start_i : data_in_new);
	assign finish = (force_data_overwrite_i ? 1'b1 : ~output_valid_q);
	always @(*) begin : aes_ctrl_fsm
		state_sel_o = STATE_ROUND;
		state_we_o = 1'b0;
		add_rk_sel_o = ADD_RK_ROUND;
		key_full_sel_o = KEY_FULL_ROUND;
		key_full_we_o = 1'b0;
		key_dec_sel_o = KEY_DEC_EXPAND;
		key_dec_we_o = 1'b0;
		key_expand_step_o = 1'b0;
		key_expand_clear_o = 1'b0;
		key_words_sel_o = KEY_WORDS_ZERO;
		round_key_sel_o = ROUND_KEY_DIRECT;
		start_we_o = 1'b0;
		key_clear_we_o = 1'b0;
		data_out_clear_we_o = 1'b0;
		idle_o = 1'b0;
		idle_we_o = 1'b0;
		stall_o = 1'b0;
		stall_we_o = 1'b0;
		dec_key_gen = 1'b0;
		data_in_load = 1'b0;
		data_out_we_o = 1'b0;
		aes_ctrl_ns = aes_ctrl_cs;
		round_d = round_q;
		num_rounds_d = num_rounds_q;
		dec_key_gen_d = dec_key_gen_q;
		case (aes_ctrl_cs)
			IDLE: begin
				idle_o = 1'b1;
				idle_we_o = 1'b1;
				stall_o = 1'b0;
				stall_we_o = 1'b1;
				dec_key_gen_d = 1'b0;
				if (start) begin
					dec_key_gen_d = (key_init_new & (mode_i == AES_DEC));
					state_sel_o = (dec_key_gen_d ? STATE_CLEAR : STATE_INIT);
					state_we_o = 1'b1;
					key_expand_clear_o = 1'b1;
					key_full_sel_o = (dec_key_gen_d ? KEY_FULL_ENC_INIT : ((mode_i == AES_ENC) ? KEY_FULL_ENC_INIT : KEY_FULL_DEC_INIT));
					key_full_we_o = 1'b1;
					round_d = 1'sb0;
					num_rounds_d = ((key_len_i == AES_128) ? 4'd10 : ((key_len_i == AES_192) ? 4'd12 : 4'd14));
					idle_o = 1'b0;
					idle_we_o = 1'b1;
					start_we_o = 1'b1;
					aes_ctrl_ns = INIT;
				end
				else begin
					if (key_clear_i) begin
						key_full_sel_o = KEY_FULL_CLEAR;
						key_full_we_o = 1'b1;
						key_dec_sel_o = KEY_DEC_CLEAR;
						key_dec_we_o = 1'b1;
						key_clear_we_o = 1'b1;
					end
					if (data_out_clear_i) begin
						add_rk_sel_o = ADD_RK_INIT;
						key_words_sel_o = KEY_WORDS_ZERO;
						round_key_sel_o = ROUND_KEY_DIRECT;
						data_out_we_o = 1'b1;
						data_out_clear_we_o = 1'b1;
					end
				end
			end
			INIT: begin
				state_we_o = ~dec_key_gen_q;
				add_rk_sel_o = ADD_RK_INIT;
				if (dec_key_gen_q)
					key_words_sel_o = KEY_WORDS_ZERO;
				else
					case (key_len_i)
						AES_128: key_words_sel_o = KEY_WORDS_0123;
						AES_192:
							if (AES192Enable)
								case (mode_i)
									AES_ENC: key_words_sel_o = KEY_WORDS_0123;
									AES_DEC: key_words_sel_o = KEY_WORDS_2345;
									default: key_words_sel_o = 1'bX;
								endcase
							else
								key_words_sel_o = 1'bX;
						AES_256:
							case (mode_i)
								AES_ENC: key_words_sel_o = KEY_WORDS_0123;
								AES_DEC: key_words_sel_o = KEY_WORDS_4567;
								default: key_words_sel_o = 1'bX;
							endcase
						default: key_words_sel_o = 1'bX;
					endcase
				if ((key_len_i != AES_256)) begin
					key_expand_step_o = 1'b1;
					key_full_we_o = 1'b1;
				end
				data_in_load = ~dec_key_gen_q;
				dec_key_gen = dec_key_gen_q;
				aes_ctrl_ns = ROUND;
			end
			ROUND: begin
				state_we_o = ~dec_key_gen_q;
				if (dec_key_gen_q)
					key_words_sel_o = KEY_WORDS_ZERO;
				else
					case (key_len_i)
						AES_128: key_words_sel_o = KEY_WORDS_0123;
						AES_192:
							if (AES192Enable)
								case (mode_i)
									AES_ENC: key_words_sel_o = KEY_WORDS_2345;
									AES_DEC: key_words_sel_o = KEY_WORDS_0123;
									default: key_words_sel_o = 1'bX;
								endcase
							else
								key_words_sel_o = 1'bX;
						AES_256:
							case (mode_i)
								AES_ENC: key_words_sel_o = KEY_WORDS_4567;
								AES_DEC: key_words_sel_o = KEY_WORDS_0123;
								default: key_words_sel_o = 1'bX;
							endcase
						default: key_words_sel_o = 1'bX;
					endcase
				key_expand_step_o = 1'b1;
				key_full_we_o = 1'b1;
				round_key_sel_o = ((mode_i == AES_ENC) ? ROUND_KEY_DIRECT : ROUND_KEY_MIXED);
				round_d = (round_q + 1);
				if ((round_q == num_rounds_regular))
					if (dec_key_gen_q) begin
						key_dec_we_o = 1'b1;
						dec_key_gen_d = 1'b0;
						aes_ctrl_ns = IDLE;
					end
					else
						aes_ctrl_ns = FINISH;
			end
			FINISH: begin
				if (dec_key_gen_q)
					key_words_sel_o = KEY_WORDS_ZERO;
				else
					case (key_len_i)
						AES_128: key_words_sel_o = KEY_WORDS_0123;
						AES_192:
							if (AES192Enable)
								case (mode_i)
									AES_ENC: key_words_sel_o = KEY_WORDS_2345;
									AES_DEC: key_words_sel_o = KEY_WORDS_0123;
									default: key_words_sel_o = 1'bX;
								endcase
							else
								key_words_sel_o = 1'bX;
						AES_256:
							case (mode_i)
								AES_ENC: key_words_sel_o = KEY_WORDS_4567;
								AES_DEC: key_words_sel_o = KEY_WORDS_0123;
								default: key_words_sel_o = 1'bX;
							endcase
						default: key_words_sel_o = 1'bX;
					endcase
				add_rk_sel_o = ADD_RK_FINAL;
				if (!finish) begin
					stall_o = 1'b1;
					stall_we_o = 1'b1;
				end
				else begin
					stall_o = 1'b0;
					stall_we_o = 1'b1;
					data_out_we_o = 1'b1;
					aes_ctrl_ns = IDLE;
					state_we_o = 1'b1;
					state_sel_o = STATE_CLEAR;
				end
			end
			default: aes_ctrl_ns = 1'bX;
		endcase
	end
	always @(posedge clk_i or negedge rst_ni) begin : reg_fsm
		if (!rst_ni) begin
			aes_ctrl_cs <= IDLE;
			round_q <= 1'sb0;
			num_rounds_q <= 1'sb0;
			dec_key_gen_q <= 1'b0;
		end
		else begin
			aes_ctrl_cs <= aes_ctrl_ns;
			round_q <= round_d;
			num_rounds_q <= num_rounds_d;
			dec_key_gen_q <= dec_key_gen_d;
		end
	end
	assign num_rounds_regular = (num_rounds_q - 4'd2);
	assign key_init_new_d = (dec_key_gen ? 1'sb0 : (key_init_new_q | key_init_qe_i));
	assign key_init_new = &key_init_new_d;
	assign data_in_new_d = (data_in_load ? 1'sb0 : (data_in_new_q | data_in_qe_i));
	assign data_in_new = &data_in_new_d;
	assign data_out_read_d = (data_out_we_o ? 1'sb0 : (data_out_read_q | data_out_re_i));
	assign data_out_read = &data_out_read_d;
	always @(posedge clk_i or negedge rst_ni) begin : reg_edge_detection
		if (!rst_ni) begin
			key_init_new_q <= 1'sb0;
			data_in_new_q <= 1'sb0;
			data_out_read_q <= 1'sb0;
		end
		else begin
			key_init_new_q <= key_init_new_d;
			data_in_new_q <= data_in_new_d;
			data_out_read_q <= data_out_read_d;
		end
	end
	assign output_valid_o = (data_out_we_o & ~data_out_clear_we_o);
	assign output_valid_we_o = ((data_out_we_o | data_out_read) | data_out_clear_we_o);
	always @(posedge clk_i or negedge rst_ni) begin : reg_output_valid
		if (!rst_ni)
			output_valid_q <= 1'sb0;
		else if (output_valid_we_o)
			output_valid_q <= output_valid_o;
	end
	assign input_ready_o = ~data_in_new;
	assign input_ready_we_o = (data_in_new | data_in_load);
	assign key_expand_mode_o = ((dec_key_gen_d || dec_key_gen_q) ? AES_ENC : mode_i);
	assign key_expand_round_o = round_d;
	assign start_o = 1'b0;
	assign key_clear_o = 1'b0;
	assign data_out_clear_o = 1'b0;
endmodule
