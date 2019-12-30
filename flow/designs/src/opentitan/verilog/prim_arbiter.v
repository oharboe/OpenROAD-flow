module prim_arbiter (
	clk_i,
	rst_ni,
	req,
	req_data,
	gnt,
	arb_valid,
	arb_data,
	arb_ready
);
	parameter N = 4;
	parameter DW = 32;
	input clk_i;
	input rst_ni;
	input [(N - 1):0] req;
	input [((0 >= (N - 1)) ? (((DW - 1) >= 0) ? ((((0 >= (N - 1)) ? (2 - N) : N) * (((DW - 1) >= 0) ? DW : (2 - DW))) + (((N - 1) * (((DW - 1) >= 0) ? DW : (2 - DW))) - 1)) : ((((0 >= (N - 1)) ? (2 - N) : N) * ((0 >= (DW - 1)) ? (2 - DW) : DW)) + (((DW - 1) + ((N - 1) * ((0 >= (DW - 1)) ? (2 - DW) : DW))) - 1))) : (((DW - 1) >= 0) ? (((((N - 1) >= 0) ? N : (2 - N)) * (((DW - 1) >= 0) ? DW : (2 - DW))) + -1) : (((((N - 1) >= 0) ? N : (2 - N)) * ((0 >= (DW - 1)) ? (2 - DW) : DW)) + ((DW - 1) - 1)))):((0 >= (N - 1)) ? (((DW - 1) >= 0) ? ((N - 1) * (((DW - 1) >= 0) ? DW : (2 - DW))) : ((DW - 1) + ((N - 1) * ((0 >= (DW - 1)) ? (2 - DW) : DW)))) : (((DW - 1) >= 0) ? 0 : (DW - 1)))] req_data;
	output wire [(N - 1):0] gnt;
	output wire arb_valid;
	output reg [(DW - 1):0] arb_data;
	input arb_ready;
	wire [(N - 1):0] masked_req;
	reg [(N - 1):0] ppc_out;
	wire [(N - 1):0] arb_req;
	reg [(N - 1):0] mask;
	wire [(N - 1):0] mask_next;
	wire [(N - 1):0] winner;
	assign masked_req = (mask & req);
	assign arb_req = (|masked_req ? masked_req : req);
	always @(*) begin
		ppc_out[0] = arb_req[0];
		begin : sv2v_autoblock_1
			reg signed [31:0] i;
			for (i = 1; (i < N); i = (i + 1))
				ppc_out[i] = (ppc_out[(i - 1)] | arb_req[i]);
		end
	end
	assign winner = (ppc_out ^ {ppc_out[(N - 2):0], 1'b0});
	assign gnt = (arb_ready ? winner : 1'sb0);
	assign arb_valid = |req;
	assign mask_next = {ppc_out[(N - 2):0], 1'b0};
	always @(posedge clk_i or negedge rst_ni)
		if (!rst_ni)
			mask <= 1'sb0;
		else if ((arb_valid && arb_ready))
			mask <= mask_next;
		else if ((arb_valid && !arb_ready))
			mask <= ppc_out;
	always @(*) begin
		arb_data = 1'sb0;
		begin : sv2v_autoblock_2
			reg signed [31:0] i;
			for (i = 0; (i < N); i = (i + 1))
				if (winner[i])
					arb_data = req_data[((((DW - 1) >= 0) ? 0 : (DW - 1)) + (((0 >= (N - 1)) ? i : ((N - 1) - i)) * (((DW - 1) >= 0) ? DW : (2 - DW))))+:(((DW - 1) >= 0) ? DW : (2 - DW))];
		end
	end
endmodule
