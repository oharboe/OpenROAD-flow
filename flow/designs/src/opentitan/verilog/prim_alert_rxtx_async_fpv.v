module prim_alert_rxtx_async_fpv (
	clk_i,
	rst_ni,
	ping_err_pi,
	ping_err_ni,
	ping_skew_i,
	ack_err_pi,
	ack_err_ni,
	ack_skew_i,
	alert_err_pi,
	alert_err_ni,
	alert_skew_i,
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
	input [1:0] ping_skew_i;
	input ack_err_pi;
	input ack_err_ni;
	input [1:0] ack_skew_i;
	input alert_err_pi;
	input alert_err_ni;
	input [1:0] alert_skew_i;
	input alert_i;
	input ping_en_i;
	output wire ping_ok_o;
	output wire integ_fail_o;
	output wire alert_o;
	localparam AsyncOn = 1'b1;
	wire ping_pd;
	wire ping_nd;
	wire ack_pd;
	wire ack_nd;
	wire alert_pd;
	wire alert_nd;
	wire [3:0] alert_rx_out;
	wire [3:0] alert_rx_in;
	wire [1:0] alert_tx_out;
	wire [1:0] alert_tx_in;
	reg [1:0] ping_pq;
	reg [1:0] ping_nq;
	reg [1:0] ack_pq;
	reg [1:0] ack_nq;
	reg [1:0] alert_pq;
	reg [1:0] alert_nq;
	assign ping_pd = alert_rx_out[3:3];
	assign ping_nd = alert_rx_out[2:2];
	assign ack_pd = alert_rx_out[1:1];
	assign ack_nd = alert_rx_out[0:0];
	assign alert_rx_in[3:3] = (ping_pq[ping_skew_i[0]] ^ ping_err_pi);
	assign alert_rx_in[2:2] = (ping_nq[ping_skew_i[1]] ^ ping_err_ni);
	assign alert_rx_in[1:1] = (ack_pq[ack_skew_i[0]] ^ ack_err_pi);
	assign alert_rx_in[0:0] = (ack_nq[ack_skew_i[1]] ^ ack_err_ni);
	assign alert_pd = alert_tx_out[1:1];
	assign alert_nd = alert_tx_out[0:0];
	assign alert_tx_in[1:1] = (alert_pq[alert_skew_i[0]] ^ alert_err_pi);
	assign alert_tx_in[0:0] = (alert_nq[alert_skew_i[1]] ^ alert_err_ni);
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
	always @(posedge clk_i or negedge rst_ni) begin : p_skew_delay
		if (!rst_ni) begin
			ping_pq <= 1'sb0;
			ping_nq <= 1'sb1;
			ack_pq <= 1'sb0;
			ack_nq <= 1'sb1;
			alert_pq <= 1'sb0;
			alert_nq <= 1'sb1;
		end
		else begin
			ping_pq <= {ping_pq[(1 - 1):0], ping_pd};
			ping_nq <= {ping_nq[(1 - 1):0], ping_nd};
			ack_pq <= {ack_pq[(1 - 1):0], ack_pd};
			ack_nq <= {ack_nq[(1 - 1):0], ack_nd};
			alert_pq <= {alert_pq[(1 - 1):0], alert_pd};
			alert_nq <= {alert_nq[(1 - 1):0], alert_nd};
		end
	end
endmodule
