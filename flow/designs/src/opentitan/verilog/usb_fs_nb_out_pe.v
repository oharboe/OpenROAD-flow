module usb_fs_nb_out_pe (
	clk_48mhz_i,
	rst_ni,
	link_reset_i,
	dev_addr_i,
	out_ep_current_o,
	out_ep_data_put_o,
	out_ep_put_addr_o,
	out_ep_data_o,
	out_ep_newpkt_o,
	out_ep_acked_o,
	out_ep_rollback_o,
	out_ep_setup_o,
	out_ep_full_i,
	out_ep_stall_i,
	rx_pkt_start_i,
	rx_pkt_end_i,
	rx_pkt_valid_i,
	rx_pid_i,
	rx_addr_i,
	rx_endp_i,
	rx_data_put_i,
	rx_data_i,
	tx_pkt_start_o,
	tx_pkt_end_i,
	tx_pid_o
);
	localparam [1:0] StIdle = 2'h0;
	localparam [1:0] StRcvdOut = 2'h1;
	localparam [1:0] StRcvdDataStart = 2'h2;
	localparam [1:0] StRcvdDataEnd = 2'h3;
	parameter NumOutEps = 1;
	parameter MaxOutPktSizeByte = 32;
	parameter PktW = $clog2(MaxOutPktSizeByte);
	parameter OutEpW = $clog2(NumOutEps);
	input clk_48mhz_i;
	input rst_ni;
	input link_reset_i;
	input [6:0] dev_addr_i;
	output reg [3:0] out_ep_current_o;
	output reg out_ep_data_put_o;
	output reg [(PktW - 1):0] out_ep_put_addr_o;
	output reg [7:0] out_ep_data_o;
	output reg out_ep_newpkt_o;
	output reg out_ep_acked_o;
	output wire out_ep_rollback_o;
	output reg [(NumOutEps - 1):0] out_ep_setup_o;
	input [(NumOutEps - 1):0] out_ep_full_i;
	input [(NumOutEps - 1):0] out_ep_stall_i;
	input rx_pkt_start_i;
	input rx_pkt_end_i;
	input rx_pkt_valid_i;
	input [3:0] rx_pid_i;
	input [6:0] rx_addr_i;
	input [3:0] rx_endp_i;
	input rx_data_put_i;
	input [7:0] rx_data_i;
	output reg tx_pkt_start_o;
	input tx_pkt_end_i;
	output reg [3:0] tx_pid_o;
	wire unused_1;
	assign unused_1 = tx_pkt_end_i;
	localparam [1:0] UsbPidTypeSpecial = 2'b00;
	localparam [1:0] UsbPidTypeToken = 2'b01;
	localparam [1:0] UsbPidTypeHandshake = 2'b10;
	localparam [1:0] UsbPidTypeData = 2'b11;
	localparam [3:0] UsbPidOut = 4'b0001;
	localparam [3:0] UsbPidAck = 4'b0010;
	localparam [3:0] UsbPidData0 = 4'b0011;
	localparam [3:0] UsbPidSof = 4'b0101;
	localparam [3:0] UsbPidNyet = 4'b0110;
	localparam [3:0] UsbPidData2 = 4'b0111;
	localparam [3:0] UsbPidIn = 4'b1001;
	localparam [3:0] UsbPidNak = 4'b1010;
	localparam [3:0] UsbPidData1 = 4'b1011;
	localparam [3:0] UsbPidSetup = 4'b1101;
	localparam [3:0] UsbPidStall = 4'b1110;
	localparam [3:0] UsbPidMData = 4'b1111;
	localparam [7:0] SetupGetStatus = 8'd0;
	localparam [7:0] DscrTypeDevice = 8'd1;
	localparam [7:0] SetupClearFeature = 8'd1;
	localparam [7:0] SetupGetInterface = 8'd10;
	localparam [7:0] SetupSetInterface = 8'd11;
	localparam [7:0] SetupSynchFrame = 8'd12;
	localparam [7:0] DscrTypeConfiguration = 8'd2;
	localparam [7:0] DscrTypeString = 8'd3;
	localparam [7:0] SetupSetFeature = 8'd3;
	localparam [7:0] DscrTypeInterface = 8'd4;
	localparam [7:0] DscrTypeEndpoint = 8'd5;
	localparam [7:0] SetupSetAddress = 8'd5;
	localparam [7:0] DscrTypeDevQual = 8'd6;
	localparam [7:0] SetupGetDescriptor = 8'd6;
	localparam [7:0] DscrTypeOthrSpd = 8'd7;
	localparam [7:0] SetupSetDescriptor = 8'd7;
	localparam [7:0] DscrTypeIntPwr = 8'd8;
	localparam [7:0] SetupGetConfiguration = 8'd8;
	localparam [7:0] SetupSetConfiguration = 8'd9;
	reg [1:0] out_xfr_state;
	reg [1:0] out_xfr_state_next;
	reg out_xfr_start;
	reg new_pkt_end;
	reg rollback_data;
	reg nak_out_transfer;
	reg [(NumOutEps - 1):0] data_toggle;
	wire [(OutEpW - 1):0] out_ep_index;
	assign out_ep_index = out_ep_current_o[0+:OutEpW];
	wire token_received;
	wire out_token_received;
	wire setup_token_received;
	wire invalid_packet_received;
	wire data_packet_received;
	wire non_data_packet_received;
	wire bad_data_toggle;
	wire [1:0] rx_pid_type;
	wire [3:0] rx_pid;
	assign rx_pid_type = rx_pid_i[1:0];
	assign rx_pid = rx_pid_i;
	assign token_received = ((((rx_pkt_end_i && rx_pkt_valid_i) && (rx_pid_type == UsbPidTypeToken)) && (rx_addr_i == dev_addr_i)) && (rx_endp_i < NumOutEps));
	assign out_token_received = (token_received && (rx_pid == UsbPidOut));
	assign setup_token_received = (token_received && (rx_pid == UsbPidSetup));
	assign invalid_packet_received = (rx_pkt_end_i && !rx_pkt_valid_i);
	assign data_packet_received = ((rx_pkt_end_i && rx_pkt_valid_i) && ((rx_pid == UsbPidData0) || (rx_pid == UsbPidData1)));
	assign non_data_packet_received = ((rx_pkt_end_i && rx_pkt_valid_i) && !((rx_pid == UsbPidData0) || (rx_pid == UsbPidData1)));
	assign bad_data_toggle = (data_packet_received && (rx_pid_i[3] != data_toggle[rx_endp_i[0+:OutEpW]]));
	always @(posedge clk_48mhz_i or negedge rst_ni)
		if (!rst_ni)
			out_ep_setup_o <= 0;
		else if (setup_token_received)
			out_ep_setup_o[rx_endp_i[0+:OutEpW]] <= 1;
		else if (out_token_received)
			out_ep_setup_o[rx_endp_i[0+:OutEpW]] <= 0;
	always @(posedge clk_48mhz_i)
		if (rx_data_put_i)
			out_ep_data_o <= rx_data_i;
	always @(*) begin
		out_ep_acked_o = 1'b0;
		out_xfr_start = 1'b0;
		out_xfr_state_next = out_xfr_state;
		tx_pkt_start_o = 1'b0;
		tx_pid_o = 4'b0000;
		new_pkt_end = 1'b0;
		rollback_data = 1'b0;
		case (out_xfr_state)
			StIdle:
				if ((out_token_received || setup_token_received)) begin
					out_xfr_state_next = StRcvdOut;
					out_xfr_start = 1'b1;
				end
				else
					out_xfr_state_next = StIdle;
			StRcvdOut:
				if (rx_pkt_start_i)
					out_xfr_state_next = StRcvdDataStart;
				else
					out_xfr_state_next = StRcvdOut;
			StRcvdDataStart:
				if (bad_data_toggle) begin
					out_xfr_state_next = StIdle;
					rollback_data = 1'b1;
					tx_pkt_start_o = 1'b1;
					tx_pid_o = UsbPidAck;
				end
				else if ((invalid_packet_received || non_data_packet_received)) begin
					out_xfr_state_next = StIdle;
					rollback_data = 1'b1;
				end
				else if (data_packet_received)
					out_xfr_state_next = StRcvdDataEnd;
				else
					out_xfr_state_next = StRcvdDataStart;
			StRcvdDataEnd: begin
				out_xfr_state_next = StIdle;
				tx_pkt_start_o = 1'b1;
				if (out_ep_stall_i[out_ep_index])
					tx_pid_o = UsbPidStall;
				else if (nak_out_transfer) begin
					tx_pid_o = UsbPidNak;
					rollback_data = 1'b1;
				end
				else begin
					tx_pid_o = UsbPidAck;
					new_pkt_end = 1'b1;
					out_ep_acked_o = 1'b1;
				end
			end
		endcase
	end
	assign out_ep_rollback_o = rollback_data;
	always @(posedge clk_48mhz_i or negedge rst_ni)
		if (!rst_ni)
			out_xfr_state <= StIdle;
		else
			out_xfr_state <= (link_reset_i ? StIdle : out_xfr_state_next);
	always @(posedge clk_48mhz_i or negedge rst_ni)
		if (!rst_ni)
			data_toggle <= 1'sb0;
		else if (link_reset_i)
			data_toggle <= 1'sb0;
		else if (setup_token_received)
			data_toggle[rx_endp_i[0+:OutEpW]] <= 1'b0;
		else if (new_pkt_end)
			data_toggle[out_ep_index] <= !data_toggle[out_ep_index];
	always @(posedge clk_48mhz_i or negedge rst_ni)
		if (!rst_ni) begin
			out_ep_newpkt_o <= 1'b0;
			out_ep_current_o <= 1'sb0;
		end
		else if (out_xfr_start) begin
			out_ep_newpkt_o <= 1'b1;
			out_ep_current_o <= rx_endp_i;
		end
		else
			out_ep_newpkt_o <= 1'b0;
	always @(posedge clk_48mhz_i or negedge rst_ni)
		if (!rst_ni)
			out_ep_data_put_o <= 1'b0;
		else
			out_ep_data_put_o <= ((out_xfr_state == StRcvdDataStart) && rx_data_put_i);
	always @(posedge clk_48mhz_i or negedge rst_ni)
		if (!rst_ni)
			nak_out_transfer <= 1'b0;
		else if (((out_xfr_state == StIdle) || (out_xfr_state == StRcvdOut)))
			nak_out_transfer <= 1'b0;
		else if ((out_ep_data_put_o && out_ep_full_i[out_ep_index]))
			nak_out_transfer <= 1'b1;
	wire increment_addr;
	assign increment_addr = ((!nak_out_transfer && ~&out_ep_put_addr_o) && out_ep_data_put_o);
	always @(posedge clk_48mhz_i or negedge rst_ni)
		if (!rst_ni)
			out_ep_put_addr_o <= 1'sb0;
		else if ((out_xfr_state == StRcvdOut))
			out_ep_put_addr_o <= 1'sb0;
		else if (((out_xfr_state == StRcvdDataStart) && increment_addr))
			out_ep_put_addr_o <= (out_ep_put_addr_o + 1'b1);
endmodule
