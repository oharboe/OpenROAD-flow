module prim_esc_rxtx_fpv (
	clk_i,
	rst_ni,
	resp_err_pi,
	resp_err_ni,
	esc_err_pi,
	esc_err_ni,
	esc_en_i,
	ping_en_i,
	ping_ok_o,
	integ_fail_o,
	esc_en_o
);
	localparam ImplGeneric = 0;
	localparam ImplXilinx = 1;
	input clk_i;
	input rst_ni;
	input resp_err_pi;
	input resp_err_ni;
	input esc_err_pi;
	input esc_err_ni;
	input esc_en_i;
	input ping_en_i;
	output wire ping_ok_o;
	output wire integ_fail_o;
	output wire esc_en_o;
	wire [1:0] esc_rx_in;
	wire [1:0] esc_rx_out;
	wire [1:0] esc_tx_in;
	wire [1:0] esc_tx_out;
	assign esc_rx_in[1:1] = (esc_rx_out[1:1] ^ resp_err_pi);
	assign esc_rx_in[0:0] = (esc_rx_out[0:0] ^ resp_err_ni);
	assign esc_tx_in[1:1] = (esc_tx_out[1:1] ^ esc_err_pi);
	assign esc_tx_in[0:0] = (esc_tx_out[0:0] ^ esc_err_ni);
	prim_esc_sender i_prim_esc_sender(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.ping_en_i(ping_en_i),
		.ping_ok_o(ping_ok_o),
		.integ_fail_o(integ_fail_o),
		.esc_en_i(esc_en_i),
		.esc_rx_i(esc_rx_in),
		.esc_tx_o(esc_tx_out)
	);
	prim_esc_receiver i_prim_esc_receiver(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.esc_en_o(esc_en_o),
		.esc_rx_o(esc_rx_out),
		.esc_tx_i(esc_tx_in)
	);
endmodule
