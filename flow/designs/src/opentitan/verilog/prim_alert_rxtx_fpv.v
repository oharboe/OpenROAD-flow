module prim_alert_rxtx_fpv (
	clk_i,
	rst_ni,
	ping_err_pi,
	ping_err_ni,
	ack_err_pi,
	ack_err_ni,
	alert_err_pi,
	alert_err_ni,
	alert_i,
	ping_en_i,
	ping_ok_o,
	integ_fail_o,
	alert_o
);
	localparam ImplGeneric = 0;
	localparam ImplXilinx = 1;
	input clk_i;
	input rst_ni;
	input ping_err_pi;
	input ping_err_ni;
	input ack_err_pi;
	input ack_err_ni;
	input alert_err_pi;
	input alert_err_ni;
	input alert_i;
	input ping_en_i;
	output wire ping_ok_o;
	output wire integ_fail_o;
	output wire alert_o;
	localparam AsyncOn = 1'b0;
	wire [3:0] alert_rx_out;
	wire [3:0] alert_rx_in;
	wire [1:0] alert_tx_out;
	wire [1:0] alert_tx_in;
	assign alert_rx_in[3:3] = (alert_rx_out[3:3] ^ ping_err_pi);
	assign alert_rx_in[2:2] = (alert_rx_out[2:2] ^ ping_err_ni);
	assign alert_rx_in[1:1] = (alert_rx_out[1:1] ^ ack_err_pi);
	assign alert_rx_in[0:0] = (alert_rx_out[0:0] ^ ack_err_ni);
	assign alert_tx_in[1:1] = (alert_tx_out[1:1] ^ alert_err_pi);
	assign alert_tx_in[0:0] = (alert_tx_out[0:0] ^ alert_err_ni);
	prim_alert_sender #(.AsyncOn(AsyncOn)) i_prim_alert_sender(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.alert_i(alert_i),
		.alert_rx_i(alert_rx_in),
		.alert_tx_o(alert_tx_out)
	);
	prim_alert_receiver #(.AsyncOn(AsyncOn)) i_prim_alert_receiver(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.ping_en_i(ping_en_i),
		.ping_ok_o(ping_ok_o),
		.integ_fail_o(integ_fail_o),
		.alert_o(alert_o),
		.alert_rx_o(alert_rx_out),
		.alert_tx_i(alert_tx_in)
	);
endmodule
