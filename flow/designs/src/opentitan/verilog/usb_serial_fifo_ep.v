module usb_serial_fifo_ep (
	clk_i,
	rst_ni,
	out_ep_data_put_i,
	out_ep_put_addr_i,
	out_ep_data_i,
	out_ep_acked_i,
	out_ep_rollback_i,
	out_ep_setup_i,
	out_ep_full_o,
	out_ep_stall_o,
	in_ep_rollback_i,
	in_ep_acked_i,
	in_ep_get_addr_i,
	in_ep_data_get_i,
	in_ep_stall_o,
	in_ep_has_data_o,
	in_ep_data_o,
	in_ep_data_done_o,
	tx_empty,
	rx_full,
	tx_read,
	rx_write,
	rx_err,
	rx_fifo_wdata,
	tx_fifo_rdata,
	baud_o,
	parity_o
);
	localparam [2:0] StIdle = 3'h0;
	localparam [2:0] StSetup = 3'h1;
	localparam [2:0] StDataIn = 3'h2;
	localparam [2:0] StDataOut = 3'h3;
	localparam [2:0] StStatusIn = 3'h4;
	localparam [2:0] StStatusOut = 3'h5;
	parameter MaxPktSizeByte = 32;
	parameter PktW = $clog2(MaxPktSizeByte);
	input clk_i;
	input rst_ni;
	input out_ep_data_put_i;
	input [(PktW - 1):0] out_ep_put_addr_i;
	input [7:0] out_ep_data_i;
	input out_ep_acked_i;
	input out_ep_rollback_i;
	input out_ep_setup_i;
	output wire out_ep_full_o;
	output wire out_ep_stall_o;
	input in_ep_rollback_i;
	input in_ep_acked_i;
	input [(PktW - 1):0] in_ep_get_addr_i;
	input in_ep_data_get_i;
	output wire in_ep_stall_o;
	output wire in_ep_has_data_o;
	output wire [7:0] in_ep_data_o;
	output wire in_ep_data_done_o;
	input tx_empty;
	input rx_full;
	output reg tx_read;
	output reg rx_write;
	output wire rx_err;
	output reg [7:0] rx_fifo_wdata;
	input [7:0] tx_fifo_rdata;
	output reg [15:0] baud_o;
	output reg [1:0] parity_o;
	wire do_setup;
	wire [7:0] in_setup_data;
	wire in_setup_has_data;
	wire in_setup_data_done;
	assign out_ep_stall_o = 1'b0;
	assign in_ep_stall_o = 1'b0;
	wire unused_1;
	assign unused_1 = in_ep_rollback_i;
	reg [7:0] out_pkt_buffer [0:(MaxPktSizeByte - 1)];
	reg [(PktW - 1):0] ob_rptr;
	reg [PktW:0] ob_max_used;
	reg ob_unload;
	always @(posedge clk_i)
		if (((!do_setup && out_ep_data_put_i) && !ob_unload)) begin
			if (!ob_max_used[PktW])
				out_pkt_buffer[out_ep_put_addr_i] <= out_ep_data_i;
			ob_max_used[0] <= ((ob_max_used[PktW] & ob_max_used[0]) ? 1'b1 : out_ep_put_addr_i[0]);
			ob_max_used[(PktW - 1):1] <= (ob_max_used[PktW] ? 0 : out_ep_put_addr_i[(PktW - 1):1]);
			ob_max_used[PktW] <= (&ob_max_used[(PktW - 1):0] | ob_max_used[PktW]);
		end
	always @(posedge clk_i or negedge rst_ni)
		if (!rst_ni)
			ob_unload <= 1'b0;
		else if ((!do_setup && out_ep_acked_i))
			ob_unload <= 1'b1;
		else if ((({1'b0, ob_rptr} == (ob_max_used - sv2v_cast_232C6(2))) && !rx_full))
			ob_unload <= 1'b0;
	always @(posedge clk_i or negedge rst_ni)
		if (!rst_ni) begin
			ob_rptr <= 1'sb0;
			rx_write <= 1'b0;
		end
		else if (!ob_unload) begin
			ob_rptr <= 1'sb0;
			rx_write <= 1'b0;
		end
		else if (!rx_full) begin
			rx_write <= 1'b1;
			rx_fifo_wdata <= out_pkt_buffer[ob_rptr];
			ob_rptr <= (ob_rptr + 1'b1);
		end
		else
			rx_write <= 1'b0;
	assign rx_err = 1'b0;
	assign out_ep_full_o = (~do_setup && ob_unload);
	reg [7:0] in_pkt_buffer [0:(MaxPktSizeByte - 1)];
	reg [PktW:0] pb_wptr;
	wire pb_freeze;
	wire pb_done;
	wire [7:0] pb_rdata;
	assign pb_rdata = in_pkt_buffer[in_ep_get_addr_i];
	assign pb_done = ((!do_setup && (pb_wptr != 1'sb0)) && ({1'b0, in_ep_get_addr_i} == pb_wptr));
	assign in_ep_data_o = (do_setup ? in_setup_data : pb_rdata);
	assign in_ep_data_done_o = (do_setup ? in_setup_data_done : pb_done);
	assign in_ep_has_data_o = (do_setup ? in_setup_has_data : (pb_wptr != 1'sb0));
	assign pb_freeze = pb_done;
	always @(posedge clk_i or negedge rst_ni)
		if (!rst_ni)
			tx_read <= 0;
		else
			tx_read <= ((((!tx_read && !tx_empty) && !pb_done) && !pb_freeze) && !pb_wptr[PktW]);
	always @(posedge clk_i or negedge rst_ni)
		if (!rst_ni)
			pb_wptr <= 1'sb0;
		else if (tx_read) begin
			in_pkt_buffer[pb_wptr[(PktW - 1):0]] <= tx_fifo_rdata;
			pb_wptr <= (pb_wptr + 1'b1);
		end
		else if ((!do_setup && in_ep_acked_i))
			pb_wptr <= 1'sb0;
	reg [2:0] ctrl_xfr_state;
	reg [2:0] ctrl_xfr_state_next;
	reg setup_stage_end;
	reg status_stage_end;
	reg send_zero_length_data_pkt;
	wire pkt_start;
	wire pkt_end;
	wire [7:0] bmRequestType;
	reg [7:0] raw_setup_data [0:(8 - 1)];
	wire [7:0] bRequest;
	wire [15:0] wValue;
	wire [15:0] wLength;
	assign pkt_start = ((out_ep_put_addr_i == 1'sb0) && out_ep_data_put_i);
	assign pkt_end = (out_ep_acked_i || out_ep_rollback_i);
	wire setup_pkt_start;
	wire has_data_stage;
	wire out_data_stage;
	wire in_data_stage;
	assign do_setup = (setup_pkt_start || (ctrl_xfr_state != StIdle));
	assign setup_pkt_start = (pkt_start && out_ep_setup_i);
	assign has_data_stage = (wLength != 16'h0);
	assign out_data_stage = (has_data_stage && !bmRequestType[7]);
	assign in_data_stage = (has_data_stage && bmRequestType[7]);
	reg [1:0] bytes_sent;
	reg [1:0] send_length;
	wire all_data_sent;
	wire more_data_to_send;
	wire in_data_transfer_done;
	assign all_data_sent = ((bytes_sent >= send_length) || (bytes_sent >= {|wLength[15:1], wLength[0]}));
	assign more_data_to_send = !all_data_sent;
	rising_edge_detector detect_in_data_transfer_done(
		.clk(clk_i),
		.in(all_data_sent),
		.out(in_data_transfer_done)
	);
	assign in_setup_has_data = (more_data_to_send || send_zero_length_data_pkt);
	assign in_setup_data_done = ((in_data_transfer_done && (ctrl_xfr_state == StDataIn)) || send_zero_length_data_pkt);
	always @(*) begin
		setup_stage_end = 1'b0;
		status_stage_end = 1'b0;
		send_zero_length_data_pkt = 1'b0;
		case (ctrl_xfr_state)
			StIdle:
				if (setup_pkt_start)
					ctrl_xfr_state_next = StSetup;
				else
					ctrl_xfr_state_next = StIdle;
			StSetup:
				if (pkt_end) begin
					if (out_ep_rollback_i)
						ctrl_xfr_state_next = StIdle;
					else if (in_data_stage) begin
						ctrl_xfr_state_next = StDataIn;
						setup_stage_end = 1'b1;
					end
					else if (out_data_stage) begin
						ctrl_xfr_state_next = StDataOut;
						setup_stage_end = 1'b1;
					end
					else begin
						ctrl_xfr_state_next = StStatusIn;
						send_zero_length_data_pkt = 1'b1;
						setup_stage_end = 1'b1;
					end
				end
				else
					ctrl_xfr_state_next = StSetup;
			StDataIn:
				if ((in_ep_acked_i && all_data_sent))
					ctrl_xfr_state_next = StStatusOut;
				else
					ctrl_xfr_state_next = StDataIn;
			StDataOut:
				if (out_ep_acked_i) begin
					ctrl_xfr_state_next = StStatusIn;
					send_zero_length_data_pkt = 1'b1;
				end
				else
					ctrl_xfr_state_next = StDataOut;
			StStatusIn:
				if (in_ep_acked_i) begin
					ctrl_xfr_state_next = StIdle;
					status_stage_end = 1'b1;
				end
				else begin
					ctrl_xfr_state_next = StStatusIn;
					send_zero_length_data_pkt = 1'b1;
				end
			StStatusOut:
				if (out_ep_acked_i) begin
					ctrl_xfr_state_next = StIdle;
					status_stage_end = 1'b1;
				end
				else
					ctrl_xfr_state_next = StStatusOut;
			default: ctrl_xfr_state_next = StIdle;
		endcase
	end
	always @(posedge clk_i or negedge rst_ni)
		if (!rst_ni)
			ctrl_xfr_state <= StIdle;
		else
			ctrl_xfr_state <= ctrl_xfr_state_next;
	assign bmRequestType = raw_setup_data[0];
	assign bRequest = raw_setup_data[1];
	assign wValue = {raw_setup_data[3][7:0], raw_setup_data[2][7:0]};
	assign wLength = {raw_setup_data[7][7:0], raw_setup_data[6][7:0]};
	wire [6:0] unused_bmR;
	assign unused_bmR = bmRequestType[6:0];
	always @(posedge clk_i)
		if (((out_ep_setup_i && out_ep_data_put_i) && (out_ep_put_addr_i[(PktW - 1):3] == 0)))
			raw_setup_data[out_ep_put_addr_i[2:0]] <= out_ep_data_i;
	reg [15:0] return_data;
	always @(posedge clk_i or negedge rst_ni)
		if (!rst_ni) begin
			baud_o <= 16'd1152;
			parity_o <= 1'b0;
			bytes_sent <= 1'sb0;
			send_length <= 1'sb0;
			return_data <= 1'sb0;
		end
		else if (setup_stage_end) begin
			bytes_sent <= 1'sb0;
			case (bRequest)
				'h00: begin
					return_data <= {14'b0, parity_o};
					send_length <= 'h2;
				end
				'h01: begin
					send_length <= 'h00;
					parity_o <= wValue[1:0];
				end
				'h02: begin
					return_data <= baud_o;
					send_length <= 'h2;
				end
				'h03: begin
					send_length <= 'h00;
					baud_o <= wValue;
				end
				default: send_length <= 'h00;
			endcase
		end
		else if ((((ctrl_xfr_state == StDataIn) && more_data_to_send) && in_ep_data_get_i))
			bytes_sent <= (bytes_sent + 1'b1);
		else if (status_stage_end)
			bytes_sent <= 1'sb0;
	assign in_setup_data = (bytes_sent[0] ? return_data[15:8] : return_data[7:0]);
	function automatic [(PktW - 1):0] sv2v_cast_232C6;
		input reg [(PktW - 1):0] inp;
		sv2v_cast_232C6 = inp;
	endfunction
endmodule
