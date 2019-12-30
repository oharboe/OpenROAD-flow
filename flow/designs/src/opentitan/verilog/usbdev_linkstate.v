module usbdev_linkstate (
	clk_48mhz_i,
	rst_ni,
	us_tick_i,
	usb_sense_i,
	usb_rx_dp_i,
	usb_rx_dn_i,
	sof_valid_i,
	link_disconnect_o,
	link_reset_o,
	link_suspend_o,
	link_resume_o,
	link_state_o,
	host_lost_o
);
	localparam [2:0] LinkReset = 3'b001;
	localparam [2:0] LinkSuspend = 3'b010;
	localparam [2:0] LinkActive = 3'b100;
	localparam [2:0] LinkWaitSuspend = 3'b101;
	localparam [2:0] LinkWaitReset = 3'b110;
	localparam [2:0] LinkDisconnect = 3'h000;
	input clk_48mhz_i;
	input rst_ni;
	input us_tick_i;
	input usb_sense_i;
	input usb_rx_dp_i;
	input usb_rx_dn_i;
	input sof_valid_i;
	output wire link_disconnect_o;
	output wire link_reset_o;
	output wire link_suspend_o;
	output reg link_resume_o;
	output wire [1:0] link_state_o;
	output wire host_lost_o;
	localparam SUSPEND_TIMEOUT = 12'd3000;
	localparam RESET_TIMEOUT = 12'd3;
	reg [2:0] link;
	reg [2:0] link_next;
	wire link_active;
	wire resume_next;
	wire rx_dp;
	wire rx_dn;
	wire line_se0;
	wire line_idle;
	wire see_se0;
	wire see_idle;
	reg [11:0] timeout;
	wire [11:0] timeout_next;
	reg time_expire;
	reg waiting;
	wire waiting_next;
	assign link_disconnect_o = (link == LinkDisconnect);
	assign link_reset_o = (link == LinkReset);
	assign link_suspend_o = (link == LinkSuspend);
	assign link_active = (((link == LinkActive) | (link == LinkWaitSuspend)) | (link == LinkWaitReset));
	assign link_state_o = (link_disconnect_o ? 2'h0 : (link_suspend_o ? 2'h2 : (link_reset_o ? 2'h1 : 2'h3)));
	prim_flop_2sync #(.Width(2)) syncrx(
		.clk_i(clk_48mhz_i),
		.rst_ni(rst_ni),
		.d({usb_rx_dp_i, usb_rx_dn_i}),
		.q({rx_dp, rx_dn})
	);
	assign line_se0 = ((rx_dp == 1'b0) & (rx_dn == 1'b0));
	assign line_idle = ((rx_dp == 1'b1) & (rx_dn == 1'b0));
	prim_filter #(.Cycles(6)) filter_se0(
		.clk_i(clk_48mhz_i),
		.rst_ni(rst_ni),
		.enable_i(1'b1),
		.filter_i(line_se0),
		.filter_o(see_se0)
	);
	prim_filter #(.Cycles(6)) filter_idle(
		.clk_i(clk_48mhz_i),
		.rst_ni(rst_ni),
		.enable_i(1'b1),
		.filter_i(line_idle),
		.filter_o(see_idle)
	);
	always @(*) begin
		link_next = link;
		if (!usb_sense_i)
			link_next = LinkDisconnect;
		else
			case (link)
				LinkDisconnect:
					if (usb_sense_i)
						link_next = LinkReset;
				LinkWaitReset:
					if (!see_se0)
						link_next = LinkActive;
					else if (time_expire)
						link_next = LinkReset;
				LinkReset:
					if (!see_se0)
						link_next = LinkActive;
				LinkWaitSuspend:
					if (!see_idle)
						link_next = LinkActive;
					else if (time_expire)
						link_next = LinkSuspend;
				LinkSuspend:
					if (!see_idle)
						link_next = LinkActive;
				LinkActive:
					if (see_se0)
						link_next = LinkWaitReset;
					else if (see_idle)
						link_next = LinkWaitSuspend;
				default: link_next = LinkDisconnect;
			endcase
	end
	assign waiting_next = ((link_next == LinkWaitReset) | (link_next == LinkWaitSuspend));
	assign timeout_next = ((link_next == LinkWaitReset) ? RESET_TIMEOUT : SUSPEND_TIMEOUT);
	assign resume_next = ((link == LinkSuspend) & (link_next == LinkActive));
	always @(posedge clk_48mhz_i or negedge rst_ni)
		if (!rst_ni) begin
			link <= LinkDisconnect;
			timeout <= 1'sb0;
			waiting <= 1'b0;
			link_resume_o <= 1'b0;
		end
		else begin
			link <= link_next;
			timeout <= timeout_next;
			waiting <= waiting_next;
			link_resume_o <= resume_next;
		end
	reg [11:0] activity_timer;
	always @(posedge clk_48mhz_i or negedge rst_ni)
		if (!rst_ni) begin
			activity_timer <= 1'sb0;
			time_expire <= 1'b0;
		end
		else if (!waiting) begin
			activity_timer <= 1'sb0;
			time_expire <= 1'b0;
		end
		else if ((activity_timer > timeout))
			time_expire <= 1'b1;
		else if (us_tick_i)
			activity_timer <= (activity_timer + 1'b1);
	reg [12:0] host_presence_timer;
	assign host_lost_o = host_presence_timer[12];
	always @(posedge clk_48mhz_i or negedge rst_ni)
		if (!rst_ni)
			host_presence_timer <= 1'sb0;
		else if ((sof_valid_i || !link_active))
			host_presence_timer <= 1'sb0;
		else if ((us_tick_i && !host_lost_o))
			host_presence_timer <= (host_presence_timer + 1'b1);
endmodule
