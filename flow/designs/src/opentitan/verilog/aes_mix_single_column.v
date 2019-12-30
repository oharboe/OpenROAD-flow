module aes_mix_single_column (
	mode_i,
	data_i,
	data_o
);
	input wire [0:0] mode_i;
	input wire [31:0] data_i;
	output wire [31:0] data_o;
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
	wire [7:0] x [0:(4 - 1)];
	wire [7:0] y [0:(2 - 1)];
	wire [7:0] z [0:(2 - 1)];
	wire [7:0] x_mul2 [0:(4 - 1)];
	wire [7:0] y_pre_mul4 [0:(2 - 1)];
	wire [7:0] y2;
	wire [7:0] y2_pre_mul2;
	wire [7:0] z_muxed [0:(2 - 1)];
	assign x[0] = (data_i[24+:8] ^ data_i[0+:8]);
	assign x[1] = (data_i[0+:8] ^ data_i[8+:8]);
	assign x[2] = (data_i[8+:8] ^ data_i[16+:8]);
	assign x[3] = (data_i[16+:8] ^ data_i[24+:8]);
	generate
		genvar gen_x_mul2_i;
		for (gen_x_mul2_i = 0; (gen_x_mul2_i < 4); gen_x_mul2_i = (gen_x_mul2_i + 1)) begin : gen_x_mul2
			assign x_mul2[gen_x_mul2_i] = aes_mul2(x[gen_x_mul2_i]);
		end
	endgenerate
	assign y_pre_mul4[0] = (data_i[0+:8] ^ data_i[16+:8]);
	assign y_pre_mul4[1] = (data_i[8+:8] ^ data_i[24+:8]);
	generate
		genvar gen_mul4_i;
		for (gen_mul4_i = 0; (gen_mul4_i < 2); gen_mul4_i = (gen_mul4_i + 1)) begin : gen_mul4
			assign y[gen_mul4_i] = aes_mul4(y_pre_mul4[gen_mul4_i]);
		end
	endgenerate
	assign y2_pre_mul2 = (y[0] ^ y[1]);
	assign y2 = aes_mul2(y2_pre_mul2);
	assign z[0] = (y2 ^ y[0]);
	assign z[1] = (y2 ^ y[1]);
	assign z_muxed[0] = ((mode_i == AES_ENC) ? 8'b0 : z[0]);
	assign z_muxed[1] = ((mode_i == AES_ENC) ? 8'b0 : z[1]);
	assign data_o[24+:8] = (((data_i[16+:8] ^ x_mul2[3]) ^ x[1]) ^ z_muxed[1]);
	assign data_o[16+:8] = (((data_i[24+:8] ^ x_mul2[2]) ^ x[1]) ^ z_muxed[0]);
	assign data_o[8+:8] = (((data_i[0+:8] ^ x_mul2[1]) ^ x[3]) ^ z_muxed[1]);
	assign data_o[0+:8] = (((data_i[8+:8] ^ x_mul2[0]) ^ x[3]) ^ z_muxed[0]);
endmodule
