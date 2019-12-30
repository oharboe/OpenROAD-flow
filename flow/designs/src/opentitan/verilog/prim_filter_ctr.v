module prim_filter_ctr (
	clk_i,
	rst_ni,
	enable_i,
	filter_i,
	filter_o
);
	parameter Cycles = 4;
	input clk_i;
	input rst_ni;
	input enable_i;
	input filter_i;
	output filter_o;
	localparam CTR_WIDTH = $clog2(Cycles);
	localparam [(CTR_WIDTH - 1):0] CYCLESM1 = (Cycles - 1);
	reg [(CTR_WIDTH - 1):0] diff_ctr_q;
	wire [(CTR_WIDTH - 1):0] diff_ctr_d;
	reg filter_q;
	reg stored_value_q;
	wire update_stored_value;
	always @(posedge clk_i or negedge rst_ni)
		if (!rst_ni)
			filter_q <= 1'b0;
		else
			filter_q <= filter_i;
	always @(posedge clk_i or negedge rst_ni)
		if (!rst_ni)
			stored_value_q <= 1'b0;
		else if (update_stored_value)
			stored_value_q <= filter_i;
	always @(posedge clk_i or negedge rst_ni)
		if (!rst_ni)
			diff_ctr_q <= {CTR_WIDTH {1'b0}};
		else
			diff_ctr_q <= diff_ctr_d;
	assign diff_ctr_d = ((filter_i != filter_q) ? 1'sb0 : ((diff_ctr_q == CYCLESM1) ? CYCLESM1 : (diff_ctr_q + 1'b1)));
	assign update_stored_value = (diff_ctr_d == CYCLESM1);
	assign filter_o = (enable_i ? stored_value_q : filter_i);
endmodule
