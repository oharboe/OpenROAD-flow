module aes_sub_bytes (
	mode_i,
	data_i,
	data_o
);
	input wire [0:0] mode_i;
	input wire [127:0] data_i;
	output wire [127:0] data_o;
	generate
		genvar gen_sbox_i;
		for (gen_sbox_i = 0; (gen_sbox_i < 16); gen_sbox_i = (gen_sbox_i + 1)) begin : gen_sbox
			aes_sbox_lut aes_sbox_i(
				.mode_i(mode_i),
				.data_i(data_i[((15 - gen_sbox_i) * 8)+:8]),
				.data_o(data_o[((15 - gen_sbox_i) * 8)+:8])
			);
		end
	endgenerate
endmodule
