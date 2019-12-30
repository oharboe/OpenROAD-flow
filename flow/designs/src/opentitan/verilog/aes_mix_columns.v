module aes_mix_columns (
	mode_i,
	data_i,
	data_o
);
	input wire [0:0] mode_i;
	input wire [127:0] data_i;
	output wire [127:0] data_o;
	generate
		genvar gen_mix_column_i;
		for (gen_mix_column_i = 0; (gen_mix_column_i < 4); gen_mix_column_i = (gen_mix_column_i + 1)) begin : gen_mix_column
			aes_mix_single_column aes_mix_column_i(
				.mode_i(mode_i),
				.data_i(data_i[(((8 * ((4 * gen_mix_column_i) + 3)) + ((((4 * gen_mix_column_i) >= ((4 * gen_mix_column_i) + 3)) ? (((4 * gen_mix_column_i) - ((4 * gen_mix_column_i) + 3)) + 1) : ((((4 * gen_mix_column_i) + 3) - (4 * gen_mix_column_i)) + 1)) * 8)) - 1):(8 * ((4 * gen_mix_column_i) + 3))]),
				.data_o(data_o[(((8 * ((4 * gen_mix_column_i) + 3)) + ((((4 * gen_mix_column_i) >= ((4 * gen_mix_column_i) + 3)) ? (((4 * gen_mix_column_i) - ((4 * gen_mix_column_i) + 3)) + 1) : ((((4 * gen_mix_column_i) + 3) - (4 * gen_mix_column_i)) + 1)) * 8)) - 1):(8 * ((4 * gen_mix_column_i) + 3))])
			);
		end
	endgenerate
endmodule
