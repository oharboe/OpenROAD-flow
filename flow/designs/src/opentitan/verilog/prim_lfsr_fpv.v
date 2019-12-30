module prim_lfsr_fpv (
	clk_i,
	rst_ni,
	en_i,
	data_i,
	data_o
);
	parameter [31:0] InDw = 1;
	parameter [31:0] OutDw = 1;
	parameter [31:0] GalXorMinLfsrDw = 4;
	parameter [31:0] GalXorMaxLfsrDw = 64;
	parameter [31:0] FibXnorMinLfsrDw = 3;
	parameter [31:0] FibXnorMaxLfsrDw = 168;
	parameter [31:0] NumDuts = (((((FibXnorMaxLfsrDw - FibXnorMinLfsrDw) + 1) + GalXorMaxLfsrDw) - GalXorMinLfsrDw) + 1);
	parameter [31:0] MaxLenSVAThresh = 10;
	input clk_i;
	input rst_ni;
	input [(NumDuts - 1):0] en_i;
	input [(((NumDuts - 1) >= 0) ? (((InDw - 1) >= 0) ? (((((NumDuts - 1) >= 0) ? NumDuts : (2 - NumDuts)) * (((InDw - 1) >= 0) ? InDw : (2 - InDw))) + -1) : (((((NumDuts - 1) >= 0) ? NumDuts : (2 - NumDuts)) * ((0 >= (InDw - 1)) ? (2 - InDw) : InDw)) + ((InDw - 1) - 1))) : (((InDw - 1) >= 0) ? ((((0 >= (NumDuts - 1)) ? (2 - NumDuts) : NumDuts) * (((InDw - 1) >= 0) ? InDw : (2 - InDw))) + (((NumDuts - 1) * (((InDw - 1) >= 0) ? InDw : (2 - InDw))) - 1)) : ((((0 >= (NumDuts - 1)) ? (2 - NumDuts) : NumDuts) * ((0 >= (InDw - 1)) ? (2 - InDw) : InDw)) + (((InDw - 1) + ((NumDuts - 1) * ((0 >= (InDw - 1)) ? (2 - InDw) : InDw))) - 1)))):(((NumDuts - 1) >= 0) ? (((InDw - 1) >= 0) ? 0 : (InDw - 1)) : (((InDw - 1) >= 0) ? ((NumDuts - 1) * (((InDw - 1) >= 0) ? InDw : (2 - InDw))) : ((InDw - 1) + ((NumDuts - 1) * ((0 >= (InDw - 1)) ? (2 - InDw) : InDw)))))] data_i;
	output wire [(((NumDuts - 1) >= 0) ? (((OutDw - 1) >= 0) ? (((((NumDuts - 1) >= 0) ? NumDuts : (2 - NumDuts)) * (((OutDw - 1) >= 0) ? OutDw : (2 - OutDw))) + -1) : (((((NumDuts - 1) >= 0) ? NumDuts : (2 - NumDuts)) * ((0 >= (OutDw - 1)) ? (2 - OutDw) : OutDw)) + ((OutDw - 1) - 1))) : (((OutDw - 1) >= 0) ? ((((0 >= (NumDuts - 1)) ? (2 - NumDuts) : NumDuts) * (((OutDw - 1) >= 0) ? OutDw : (2 - OutDw))) + (((NumDuts - 1) * (((OutDw - 1) >= 0) ? OutDw : (2 - OutDw))) - 1)) : ((((0 >= (NumDuts - 1)) ? (2 - NumDuts) : NumDuts) * ((0 >= (OutDw - 1)) ? (2 - OutDw) : OutDw)) + (((OutDw - 1) + ((NumDuts - 1) * ((0 >= (OutDw - 1)) ? (2 - OutDw) : OutDw))) - 1)))):(((NumDuts - 1) >= 0) ? (((OutDw - 1) >= 0) ? 0 : (OutDw - 1)) : (((OutDw - 1) >= 0) ? ((NumDuts - 1) * (((OutDw - 1) >= 0) ? OutDw : (2 - OutDw))) : ((OutDw - 1) + ((NumDuts - 1) * ((0 >= (OutDw - 1)) ? (2 - OutDw) : OutDw)))))] data_o;
	generate
		genvar gen_gal_xor_duts_k;
		for (gen_gal_xor_duts_k = GalXorMinLfsrDw; (gen_gal_xor_duts_k <= GalXorMaxLfsrDw); gen_gal_xor_duts_k = (gen_gal_xor_duts_k + 1)) begin : gen_gal_xor_duts
			prim_lfsr #(
				.LfsrType("GAL_XOR"),
				.LfsrDw(gen_gal_xor_duts_k),
				.InDw(InDw),
				.OutDw(OutDw),
				.Seed(1),
				.Custom(1'sb0),
				.MaxLenSVA((gen_gal_xor_duts_k <= MaxLenSVAThresh))
			) i_prim_lfsr(
				.clk_i(clk_i),
				.rst_ni(rst_ni),
				.en_i(en_i[(gen_gal_xor_duts_k - GalXorMinLfsrDw)]),
				.data_i(data_i[((((InDw - 1) >= 0) ? 0 : (InDw - 1)) + ((((NumDuts - 1) >= 0) ? (gen_gal_xor_duts_k - GalXorMinLfsrDw) : (0 - ((gen_gal_xor_duts_k - GalXorMinLfsrDw) - (NumDuts - 1)))) * (((InDw - 1) >= 0) ? InDw : (2 - InDw))))+:(((InDw - 1) >= 0) ? InDw : (2 - InDw))]),
				.data_o(data_o[((((OutDw - 1) >= 0) ? 0 : (OutDw - 1)) + ((((NumDuts - 1) >= 0) ? (gen_gal_xor_duts_k - GalXorMinLfsrDw) : (0 - ((gen_gal_xor_duts_k - GalXorMinLfsrDw) - (NumDuts - 1)))) * (((OutDw - 1) >= 0) ? OutDw : (2 - OutDw))))+:(((OutDw - 1) >= 0) ? OutDw : (2 - OutDw))])
			);
		end
	endgenerate
	generate
		genvar gen_fib_xnor_duts_k;
		for (gen_fib_xnor_duts_k = FibXnorMinLfsrDw; (gen_fib_xnor_duts_k <= FibXnorMaxLfsrDw); gen_fib_xnor_duts_k = (gen_fib_xnor_duts_k + 1)) begin : gen_fib_xnor_duts
			prim_lfsr #(
				.LfsrType("FIB_XNOR"),
				.LfsrDw(gen_fib_xnor_duts_k),
				.InDw(InDw),
				.OutDw(OutDw),
				.Seed(1),
				.Custom(1'sb0),
				.MaxLenSVA((gen_fib_xnor_duts_k <= MaxLenSVAThresh))
			) i_prim_lfsr(
				.clk_i(clk_i),
				.rst_ni(rst_ni),
				.en_i(en_i[((((gen_fib_xnor_duts_k - FibXnorMinLfsrDw) + GalXorMaxLfsrDw) - GalXorMinLfsrDw) + 1)]),
				.data_i(data_i[((((InDw - 1) >= 0) ? 0 : (InDw - 1)) + ((((NumDuts - 1) >= 0) ? ((((gen_fib_xnor_duts_k - FibXnorMinLfsrDw) + GalXorMaxLfsrDw) - GalXorMinLfsrDw) + 1) : (0 - (((((gen_fib_xnor_duts_k - FibXnorMinLfsrDw) + GalXorMaxLfsrDw) - GalXorMinLfsrDw) + 1) - (NumDuts - 1)))) * (((InDw - 1) >= 0) ? InDw : (2 - InDw))))+:(((InDw - 1) >= 0) ? InDw : (2 - InDw))]),
				.data_o(data_o[((((OutDw - 1) >= 0) ? 0 : (OutDw - 1)) + ((((NumDuts - 1) >= 0) ? ((((gen_fib_xnor_duts_k - FibXnorMinLfsrDw) + GalXorMaxLfsrDw) - GalXorMinLfsrDw) + 1) : (0 - (((((gen_fib_xnor_duts_k - FibXnorMinLfsrDw) + GalXorMaxLfsrDw) - GalXorMinLfsrDw) + 1) - (NumDuts - 1)))) * (((OutDw - 1) >= 0) ? OutDw : (2 - OutDw))))+:(((OutDw - 1) >= 0) ? OutDw : (2 - OutDw))])
			);
		end
	endgenerate
endmodule
