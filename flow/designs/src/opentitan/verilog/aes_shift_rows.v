module aes_shift_rows (
	mode_i,
	data_i,
	data_o
);
	input wire [0:0] mode_i;
	input wire [127:0] data_i;
	output reg [127:0] data_o;
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
	always @(*) data_o[120+:8] = data_i[120+:8];
	always @(*) data_o[88+:8] = data_i[88+:8];
	always @(*) data_o[56+:8] = data_i[56+:8];
	always @(*) data_o[24+:8] = data_i[24+:8];
	always @(*) data_o[104+:8] = data_i[40+:8];
	always @(*) data_o[72+:8] = data_i[8+:8];
	always @(*) data_o[40+:8] = data_i[104+:8];
	always @(*) data_o[8+:8] = data_i[72+:8];
	always @(*) begin : shift_row_1_3
		if ((mode_i == AES_ENC)) begin
			data_o[112+:8] = data_i[80+:8];
			data_o[80+:8] = data_i[48+:8];
			data_o[48+:8] = data_i[16+:8];
			data_o[16+:8] = data_i[112+:8];
			data_o[96+:8] = data_i[0+:8];
			data_o[64+:8] = data_i[96+:8];
			data_o[32+:8] = data_i[64+:8];
			data_o[0+:8] = data_i[32+:8];
		end
		else begin
			data_o[112+:8] = data_i[16+:8];
			data_o[80+:8] = data_i[112+:8];
			data_o[48+:8] = data_i[80+:8];
			data_o[16+:8] = data_i[48+:8];
			data_o[96+:8] = data_i[64+:8];
			data_o[64+:8] = data_i[32+:8];
			data_o[32+:8] = data_i[0+:8];
			data_o[0+:8] = data_i[96+:8];
		end
	end
endmodule
