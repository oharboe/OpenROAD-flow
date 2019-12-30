module usb_serial_ctrl_ep (
	clk_i,
	rst_ni,
	dev_addr,
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
	in_ep_data_done_o
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
	output wire [6:0] dev_addr;
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
	output reg in_ep_stall_o;
	output wire in_ep_has_data_o;
	output reg [7:0] in_ep_data_o;
	output wire in_ep_data_done_o;
	wire unused_1;
	wire [(PktW - 1):0] unused_2;
	assign unused_1 = in_ep_rollback_i;
	assign unused_2 = in_ep_get_addr_i;
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
	reg [2:0] ctrl_xfr_state;
	reg [2:0] ctrl_xfr_state_next;
	reg setup_stage_end;
	reg status_stage_end;
	reg send_zero_length_data_pkt;
	reg [6:0] dev_addr_int;
	reg [6:0] new_dev_addr;
	assign dev_addr = dev_addr_int;
	assign out_ep_stall_o = 1'b0;
	assign out_ep_full_o = 1'b0;
	wire pkt_start;
	wire pkt_end;
	assign pkt_start = ((out_ep_put_addr_i == 0) && out_ep_data_put_i);
	assign pkt_end = (out_ep_acked_i || out_ep_rollback_i);
	wire [7:0] bmRequestType;
	reg [7:0] raw_setup_data [0:(8 - 1)];
	wire [7:0] bRequest;
	wire [15:0] wValue;
	wire [15:0] wLength;
	wire setup_pkt_start;
	wire has_data_stage;
	wire out_data_stage;
	wire in_data_stage;
	assign setup_pkt_start = (pkt_start && out_ep_setup_i);
	assign has_data_stage = (wLength != 16'h0);
	assign out_data_stage = (has_data_stage && !bmRequestType[7]);
	assign in_data_stage = (has_data_stage && bmRequestType[7]);
	reg [7:0] bytes_sent;
	reg [6:0] rom_length;
	wire all_data_sent;
	wire more_data_to_send;
	wire in_data_transfer_done;
	assign all_data_sent = ((bytes_sent >= {1'b0, rom_length}) || (bytes_sent >= {|wLength[15:7], wLength[6:0]}));
	assign more_data_to_send = !all_data_sent;
	rising_edge_detector detect_in_data_transfer_done(
		.clk(clk_i),
		.in(all_data_sent),
		.out(in_data_transfer_done)
	);
	assign in_ep_has_data_o = (more_data_to_send || send_zero_length_data_pkt);
	assign in_ep_data_done_o = ((in_data_transfer_done && (ctrl_xfr_state == StDataIn)) || send_zero_length_data_pkt);
	reg [6:0] rom_addr;
	reg save_dev_addr;
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
				if (in_ep_stall_o) begin
					ctrl_xfr_state_next = StIdle;
					status_stage_end = 1'b1;
				end
				else if ((in_ep_acked_i && all_data_sent))
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
	wire unused_wValue;
	assign unused_bmR = bmRequestType[6:0];
	assign unused_wValue = wValue[7];
	always @(posedge clk_i)
		if (((out_ep_setup_i && out_ep_data_put_i) && (out_ep_put_addr_i[(PktW - 1):3] == 1'sb0)))
			raw_setup_data[out_ep_put_addr_i[2:0]] <= out_ep_data_i;
	always @(posedge clk_i or negedge rst_ni)
		if (!rst_ni) begin
			dev_addr_int <= 1'sb0;
			save_dev_addr <= 1'b0;
			in_ep_stall_o <= 1'b0;
		end
		else if (setup_stage_end) begin
			bytes_sent <= 1'sb0;
			case (bRequest)
				SetupGetDescriptor:
					case (wValue[15:8])
						DscrTypeDevice: begin
							in_ep_stall_o <= 1'b0;
							rom_addr <= 'h00;
							rom_length <= 'h12;
						end
						DscrTypeConfiguration: begin
							in_ep_stall_o <= 1'b0;
							rom_addr <= 'h12;
							rom_length <= (((9 + 9) + 7) + 7);
						end
						DscrTypeDevQual: begin
							in_ep_stall_o <= 1'b1;
							rom_addr <= 'h00;
							rom_length <= 'h00;
						end
						default: begin
						in_ep_stall_o <= 1'b0;
						rom_addr <= 'h00;
						rom_length <= 'h00;
					end
					endcase
				SetupSetAddress: begin
					in_ep_stall_o <= 1'b0;
					rom_addr <= 'h00;
					rom_length <= 'h00;
					save_dev_addr <= 1'b1;
					new_dev_addr <= wValue[6:0];
				end
				SetupSetConfiguration: begin
					in_ep_stall_o <= 1'b0;
					rom_addr <= 'h00;
					rom_length <= 'h00;
				end
				default: begin
				in_ep_stall_o <= 1'b0;
				rom_addr <= 'h00;
				rom_length <= 'h00;
			end
			endcase
		end
		else if ((((ctrl_xfr_state == StDataIn) && more_data_to_send) && in_ep_data_get_i)) begin
			rom_addr <= (rom_addr + 1'b1);
			bytes_sent <= (bytes_sent + 1'b1);
		end
		else if (status_stage_end) begin
			bytes_sent <= 1'sb0;
			rom_addr <= 1'sb0;
			rom_length <= 1'sb0;
			if (save_dev_addr) begin
				save_dev_addr <= 1'b0;
				dev_addr_int <= new_dev_addr;
			end
		end
	always @(*)
		case (rom_addr)
			'h000: in_ep_data_o = 8'd18;
			'h001: in_ep_data_o = DscrTypeDevice;
			'h002: in_ep_data_o = 8'h00;
			'h003: in_ep_data_o = 8'h02;
			'h004: in_ep_data_o = 8'h00;
			'h005: in_ep_data_o = 8'h00;
			'h006: in_ep_data_o = 8'h00;
			'h007: in_ep_data_o = 8'd32;
			'h008: in_ep_data_o = 8'hd1;
			'h009: in_ep_data_o = 8'h18;
			'h00A: in_ep_data_o = 8'h39;
			'h00B: in_ep_data_o = 8'h50;
			'h00C: in_ep_data_o = 8'h0;
			'h00D: in_ep_data_o = 8'h1;
			'h00E: in_ep_data_o = 8'h0;
			'h00F: in_ep_data_o = 8'h0;
			'h010: in_ep_data_o = 8'h0;
			'h011: in_ep_data_o = 8'h1;
			'h012: in_ep_data_o = 8'd9;
			'h013: in_ep_data_o = DscrTypeConfiguration;
			'h014: in_ep_data_o = sv2v_cast_8((((9 + 9) + 7) + 7));
			'h015: in_ep_data_o = 8'h0;
			'h016: in_ep_data_o = 8'h1;
			'h017: in_ep_data_o = 8'h1;
			'h018: in_ep_data_o = 8'h0;
			'h019: in_ep_data_o = 8'hC0;
			'h01A: in_ep_data_o = 8'd50;
			'h01B: in_ep_data_o = 8'd9;
			'h01C: in_ep_data_o = DscrTypeInterface;
			'h01D: in_ep_data_o = 8'h0;
			'h01E: in_ep_data_o = 8'h0;
			'h01F: in_ep_data_o = 8'h2;
			'h020: in_ep_data_o = 8'hff;
			'h021: in_ep_data_o = 8'h50;
			'h022: in_ep_data_o = 8'h1;
			'h023: in_ep_data_o = 8'h0;
			'h024: in_ep_data_o = 8'd7;
			'h025: in_ep_data_o = DscrTypeEndpoint;
			'h026: in_ep_data_o = 8'h1;
			'h027: in_ep_data_o = 8'h02;
			'h028: in_ep_data_o = 8'd32;
			'h029: in_ep_data_o = 8'h0;
			'h02A: in_ep_data_o = 8'h0;
			'h02B: in_ep_data_o = 8'd7;
			'h02C: in_ep_data_o = DscrTypeEndpoint;
			'h02D: in_ep_data_o = 8'h81;
			'h02E: in_ep_data_o = 8'h02;
			'h02F: in_ep_data_o = 8'd32;
			'h030: in_ep_data_o = 8'h0;
			'h031: in_ep_data_o = 8'h4;
			default: in_ep_data_o = 0;
		endcase
	function automatic [7:0] sv2v_cast_8;
		input reg [7:0] inp;
		sv2v_cast_8 = inp;
	endfunction
endmodule
