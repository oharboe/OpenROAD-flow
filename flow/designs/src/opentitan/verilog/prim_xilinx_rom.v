module prim_xilinx_rom (
	clk_i,
	addr_i,
	cs_i,
	dout_o,
	dvalid_o
);
	parameter signed [31:0] Width = 32;
	parameter signed [31:0] Depth = 2048;
	parameter signed [31:0] Aw = $clog2(Depth);
	input clk_i;
	input [(Aw - 1):0] addr_i;
	input cs_i;
	output reg [(Width - 1):0] dout_o;
	output reg dvalid_o;
	always @(posedge clk_i) dout_o <= 1'sbx;
	always @(posedge clk_i) dvalid_o <= cs_i;
endmodule
