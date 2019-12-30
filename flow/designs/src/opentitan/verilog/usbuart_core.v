module usbuart_core (
	clk_i,
	rst_ni,
	reg2hw,
	hw2reg,
	clk_usb_48mhz_i,
	usb_dp_i,
	usb_dp_o,
	usb_dn_i,
	usb_dn_o,
	usb_tx_en_o,
	usb_sense_i,
	usb_pullup_o,
	intr_tx_watermark_o,
	intr_rx_watermark_o,
	intr_tx_overflow_o,
	intr_rx_overflow_o,
	intr_rx_frame_err_o,
	intr_rx_break_err_o,
	intr_rx_timeout_o,
	intr_rx_parity_err_o
);
	input clk_i;
	input rst_ni;
	input wire [112:0] reg2hw;
	output wire [106:0] hw2reg;
	input clk_usb_48mhz_i;
	input usb_dp_i;
	output wire usb_dp_o;
	input usb_dn_i;
	output wire usb_dn_o;
	output wire usb_tx_en_o;
	input usb_sense_i;
	output wire usb_pullup_o;
	output wire intr_tx_watermark_o;
	output wire intr_rx_watermark_o;
	output wire intr_tx_overflow_o;
	output wire intr_rx_overflow_o;
	output wire intr_rx_frame_err_o;
	output wire intr_rx_break_err_o;
	output wire intr_rx_timeout_o;
	output wire intr_rx_parity_err_o;
	parameter USBUART_INTR_STATE_OFFSET = 6'h 0;
	parameter USBUART_INTR_ENABLE_OFFSET = 6'h 4;
	parameter USBUART_INTR_TEST_OFFSET = 6'h 8;
	parameter USBUART_CTRL_OFFSET = 6'h c;
	parameter USBUART_STATUS_OFFSET = 6'h 10;
	parameter USBUART_RDATA_OFFSET = 6'h 14;
	parameter USBUART_WDATA_OFFSET = 6'h 18;
	parameter USBUART_FIFO_CTRL_OFFSET = 6'h 1c;
	parameter USBUART_FIFO_STATUS_OFFSET = 6'h 20;
	parameter USBUART_OVRD_OFFSET = 6'h 24;
	parameter USBUART_VAL_OFFSET = 6'h 28;
	parameter USBUART_TIMEOUT_CTRL_OFFSET = 6'h 2c;
	parameter USBUART_USBSTAT_OFFSET = 6'h 30;
	parameter USBUART_USBPARAM_OFFSET = 6'h 34;
	localparam [55:0] USBUART_PERMIT = {4'b 0001, 4'b 0001, 4'b 0001, 4'b 1111, 4'b 0001, 4'b 0001, 4'b 0001, 4'b 0001, 4'b 0111, 4'b 0001, 4'b 0011, 4'b 1111, 4'b 0111, 4'b 0111};
	localparam USBUART_INTR_STATE = 0;
	localparam USBUART_INTR_ENABLE = 1;
	localparam USBUART_VAL = 10;
	localparam USBUART_TIMEOUT_CTRL = 11;
	localparam USBUART_USBSTAT = 12;
	localparam USBUART_USBPARAM = 13;
	localparam USBUART_INTR_TEST = 2;
	localparam USBUART_CTRL = 3;
	localparam USBUART_STATUS = 4;
	localparam USBUART_RDATA = 5;
	localparam USBUART_WDATA = 6;
	localparam USBUART_FIFO_CTRL = 7;
	localparam USBUART_FIFO_STATUS = 8;
	localparam USBUART_OVRD = 9;
	wire [7:0] uart_rdata;
	wire tx_fifo_rst_n;
	wire rx_fifo_rst_n;
	wire [5:0] tx_fifo_depth;
	wire [5:0] rx_fifo_depth;
	reg [5:0] rx_fifo_depth_prev;
	reg [23:0] rx_timeout_count;
	wire [23:0] rx_timeout_count_next;
	wire [23:0] uart_rxto_val;
	wire rx_fifo_depth_changed;
	wire uart_rxto_en;
	wire tx_enable;
	wire rx_enable;
	wire sys_loopback;
	wire uart_fifo_rxrst;
	wire uart_fifo_txrst;
	wire [2:0] uart_fifo_rxilvl;
	wire [1:0] uart_fifo_txilvl;
	wire [7:0] usb_tx_fifo_rdata;
	wire usb_tx_rready;
	wire usb_if_tx_read;
	wire usb_tx_rvalid;
	wire tx_fifo_wready;
	reg lb_data_move;
	wire [7:0] usb_rx_fifo_wdata;
	wire [7:0] usb_if_rx_fifo_wdata;
	wire usb_rx_wvalid;
	wire usb_if_rx_write;
	wire rx_fifo_rvalid;
	wire usb_rx_wready;
	reg event_tx_watermark;
	reg event_rx_watermark;
	wire event_tx_overflow;
	wire event_rx_overflow;
	wire event_rx_frame_err;
	wire event_rx_break_err;
	wire event_rx_timeout;
	wire event_rx_parity_err;
	wire host_lost;
	wire host_timeout;
	assign tx_enable = reg2hw[80:80];
	assign rx_enable = reg2hw[79:79];
	assign sys_loopback = reg2hw[77:77];
	assign usb_pullup_o = (tx_enable | rx_enable);
	reg [2:0] rxres_cnt;
	reg [2:0] txres_cnt;
	wire uart_start_rxrst;
	wire uart_start_txrst;
	assign uart_start_rxrst = (reg2hw[37:37] & reg2hw[36:36]);
	assign uart_start_txrst = (reg2hw[35:35] & reg2hw[34:34]);
	assign uart_fifo_rxrst = ~rxres_cnt[2];
	assign uart_fifo_txrst = ~txres_cnt[2];
	always @(posedge clk_i or negedge rst_ni)
		if (!rst_ni) begin
			txres_cnt <= 3'h0;
			rxres_cnt <= 3'h0;
		end
		else begin
			if (uart_start_txrst)
				txres_cnt <= 3'b0;
			else if (uart_fifo_txrst)
				txres_cnt <= (txres_cnt + 1);
			if (uart_start_rxrst)
				rxres_cnt <= 3'b0;
			else if (uart_fifo_rxrst)
				rxres_cnt <= (rxres_cnt + 1);
		end
	assign uart_fifo_rxilvl = reg2hw[33:31];
	assign uart_fifo_txilvl = reg2hw[29:28];
	assign hw2reg[53:38] = 16'b0;
	assign hw2reg[84:77] = uart_rdata;
	assign hw2reg[85:85] = ~rx_fifo_rvalid;
	assign hw2reg[86:86] = ~rx_fifo_rvalid;
	assign hw2reg[87:87] = ~usb_tx_rvalid;
	assign hw2reg[88:88] = ~usb_tx_rvalid;
	assign hw2reg[89:89] = ~usb_rx_wready;
	assign hw2reg[90:90] = ~tx_fifo_wready;
	assign hw2reg[65:60] = tx_fifo_depth;
	assign hw2reg[59:54] = rx_fifo_depth;
	assign hw2reg[75:75] = reg2hw[37:37];
	assign hw2reg[76:76] = 1'b0;
	assign hw2reg[73:73] = reg2hw[35:35];
	assign hw2reg[74:74] = 1'b0;
	assign hw2reg[69:69] = 1'b0;
	assign hw2reg[72:70] = 3'h0;
	assign hw2reg[66:66] = 1'b0;
	assign hw2reg[68:67] = 2'h0;
	reg [16:0] nco_sum;
	wire tick_baud_x16;
	always @(posedge clk_i or negedge rst_ni)
		if (!rst_ni)
			nco_sum <= 17'h0;
		else if ((tx_enable || rx_enable))
			nco_sum <= ({1'b0, nco_sum[15:0]} + {1'b0, reg2hw[71:56]});
	assign tick_baud_x16 = nco_sum[16];
	assign tx_fifo_rst_n = (rst_ni & ~uart_fifo_txrst);
	prim_fifo_async #(
		.Width(8),
		.Depth(32)
	) usbuart_txfifo(
		.clk_wr_i(clk_i),
		.rst_wr_ni(tx_fifo_rst_n),
		.wvalid(reg2hw[38:38]),
		.wready(tx_fifo_wready),
		.wdata(reg2hw[46:39]),
		.wdepth(tx_fifo_depth),
		.clk_rd_i(clk_usb_48mhz_i),
		.rst_rd_ni(tx_fifo_rst_n),
		.rvalid(usb_tx_rvalid),
		.rready(usb_tx_rready),
		.rdata(usb_tx_fifo_rdata),
		.rdepth()
	);
	wire [5:0] usb_rx_wdepth;
	wire usb_rx_oflw;
	assign rx_fifo_rst_n = (rst_ni & ~uart_fifo_rxrst);
	prim_fifo_async #(
		.Width(8),
		.Depth(32)
	) usbuart_rxfifo(
		.clk_wr_i(clk_usb_48mhz_i),
		.rst_wr_ni(rx_fifo_rst_n),
		.wvalid(usb_rx_wvalid),
		.wready(usb_rx_wready),
		.wdata(usb_rx_fifo_wdata),
		.wdepth(usb_rx_wdepth),
		.clk_rd_i(clk_i),
		.rst_rd_ni(rx_fifo_rst_n),
		.rvalid(rx_fifo_rvalid),
		.rready(reg2hw[47:47]),
		.rdata(uart_rdata),
		.rdepth(rx_fifo_depth)
	);
	always @(posedge clk_usb_48mhz_i) lb_data_move <= (((sys_loopback & usb_tx_rvalid) & usb_rx_wready) & ~lb_data_move);
	assign usb_tx_rready = (sys_loopback ? lb_data_move : usb_if_tx_read);
	assign usb_rx_wvalid = (sys_loopback ? lb_data_move : usb_if_rx_write);
	assign usb_rx_fifo_wdata = (sys_loopback ? usb_tx_fifo_rdata : usb_if_rx_fifo_wdata);
	usbuart_usbif usbuart_usbif(
		.clk_48mhz_i(clk_usb_48mhz_i),
		.rst_ni((rst_ni & usb_sense_i)),
		.usb_dp_o(usb_dp_o),
		.usb_dn_o(usb_dn_o),
		.usb_dp_i(usb_dp_i),
		.usb_dn_i(usb_dn_i),
		.usb_tx_en_o(usb_tx_en_o),
		.tx_empty((~usb_tx_rvalid & ~sys_loopback)),
		.rx_full((~usb_rx_wready & ~sys_loopback)),
		.tx_read(usb_if_tx_read),
		.rx_write(usb_if_rx_write),
		.rx_err(usb_rx_oflw),
		.rx_fifo_wdata(usb_if_rx_fifo_wdata),
		.tx_fifo_rdata(usb_tx_fifo_rdata),
		.rx_fifo_wdepth(usb_rx_wdepth),
		.status_frame_o(hw2reg[37:27]),
		.status_host_lost_o(host_lost),
		.status_host_timeout_o(host_timeout),
		.status_device_address_o(hw2reg[24:18]),
		.parity_o(hw2reg[1:0]),
		.baud_o(hw2reg[17:2])
	);
	assign hw2reg[25:25] = host_lost;
	assign hw2reg[26:26] = host_timeout;
	always @(*)
		case (uart_fifo_txilvl)
			2'h0: event_tx_watermark = (tx_fifo_depth >= 6'd1);
			2'h1: event_tx_watermark = (tx_fifo_depth >= 6'd4);
			2'h2: event_tx_watermark = (tx_fifo_depth >= 6'd8);
			default: event_tx_watermark = (tx_fifo_depth >= 6'd16);
		endcase
	always @(*)
		case (uart_fifo_rxilvl)
			3'h0: event_rx_watermark = (rx_fifo_depth >= 6'd1);
			3'h1: event_rx_watermark = (rx_fifo_depth >= 6'd4);
			3'h2: event_rx_watermark = (rx_fifo_depth >= 6'd8);
			3'h3: event_rx_watermark = (rx_fifo_depth >= 6'd16);
			3'h4: event_rx_watermark = (rx_fifo_depth >= 6'd30);
			default: event_rx_watermark = 1'b0;
		endcase
	assign uart_rxto_en = reg2hw[0:0];
	assign uart_rxto_val = reg2hw[24:1];
	assign rx_fifo_depth_changed = (rx_fifo_depth != rx_fifo_depth_prev);
	assign rx_timeout_count_next = ((uart_rxto_en == 1'b0) ? 24'd0 : (event_rx_timeout ? 24'd0 : (rx_fifo_depth_changed ? 24'd0 : ((rx_fifo_depth == 6'd0) ? 24'd0 : ((rx_timeout_count == uart_rxto_val) ? rx_timeout_count : (tick_baud_x16 ? (rx_timeout_count + 24'd1) : rx_timeout_count))))));
	assign event_rx_timeout = ((rx_timeout_count == uart_rxto_val) & uart_rxto_en);
	always @(posedge clk_i or negedge rst_ni)
		if (!rst_ni) begin
			rx_timeout_count <= 24'd0;
			rx_fifo_depth_prev <= 6'd0;
		end
		else begin
			rx_timeout_count <= rx_timeout_count_next;
			rx_fifo_depth_prev <= rx_fifo_depth;
		end
	assign event_rx_overflow = usb_rx_oflw;
	assign event_tx_overflow = (reg2hw[38:38] & ~tx_fifo_wready);
	assign event_rx_break_err = ((~usb_sense_i | (reg2hw[73:72] == 0)) ? host_lost : host_timeout);
	assign event_rx_frame_err = 0;
	assign event_rx_parity_err = 0;
	prim_intr_hw #(.Width(1)) intr_hw_tx_watermark(
		.event_intr_i(event_tx_watermark),
		.reg2hw_intr_enable_q_i(reg2hw[104:104]),
		.reg2hw_intr_test_q_i(reg2hw[96:96]),
		.reg2hw_intr_test_qe_i(reg2hw[95:95]),
		.reg2hw_intr_state_q_i(reg2hw[112:112]),
		.hw2reg_intr_state_de_o(hw2reg[105:105]),
		.hw2reg_intr_state_d_o(hw2reg[106:106]),
		.intr_o(intr_tx_watermark_o)
	);
	prim_intr_hw #(.Width(1)) intr_hw_rx_watermark(
		.event_intr_i(event_rx_watermark),
		.reg2hw_intr_enable_q_i(reg2hw[103:103]),
		.reg2hw_intr_test_q_i(reg2hw[94:94]),
		.reg2hw_intr_test_qe_i(reg2hw[93:93]),
		.reg2hw_intr_state_q_i(reg2hw[111:111]),
		.hw2reg_intr_state_de_o(hw2reg[103:103]),
		.hw2reg_intr_state_d_o(hw2reg[104:104]),
		.intr_o(intr_rx_watermark_o)
	);
	prim_intr_hw #(.Width(1)) intr_hw_tx_overflow(
		.event_intr_i(event_tx_overflow),
		.reg2hw_intr_enable_q_i(reg2hw[102:102]),
		.reg2hw_intr_test_q_i(reg2hw[92:92]),
		.reg2hw_intr_test_qe_i(reg2hw[91:91]),
		.reg2hw_intr_state_q_i(reg2hw[110:110]),
		.hw2reg_intr_state_de_o(hw2reg[101:101]),
		.hw2reg_intr_state_d_o(hw2reg[102:102]),
		.intr_o(intr_tx_overflow_o)
	);
	prim_intr_hw #(.Width(1)) intr_hw_rx_overflow(
		.event_intr_i(event_rx_overflow),
		.reg2hw_intr_enable_q_i(reg2hw[101:101]),
		.reg2hw_intr_test_q_i(reg2hw[90:90]),
		.reg2hw_intr_test_qe_i(reg2hw[89:89]),
		.reg2hw_intr_state_q_i(reg2hw[109:109]),
		.hw2reg_intr_state_de_o(hw2reg[99:99]),
		.hw2reg_intr_state_d_o(hw2reg[100:100]),
		.intr_o(intr_rx_overflow_o)
	);
	prim_intr_hw #(.Width(1)) intr_hw_rx_frame_err(
		.event_intr_i(event_rx_frame_err),
		.reg2hw_intr_enable_q_i(reg2hw[100:100]),
		.reg2hw_intr_test_q_i(reg2hw[88:88]),
		.reg2hw_intr_test_qe_i(reg2hw[87:87]),
		.reg2hw_intr_state_q_i(reg2hw[108:108]),
		.hw2reg_intr_state_de_o(hw2reg[97:97]),
		.hw2reg_intr_state_d_o(hw2reg[98:98]),
		.intr_o(intr_rx_frame_err_o)
	);
	prim_intr_hw #(.Width(1)) intr_hw_rx_break_err(
		.event_intr_i(event_rx_break_err),
		.reg2hw_intr_enable_q_i(reg2hw[99:99]),
		.reg2hw_intr_test_q_i(reg2hw[86:86]),
		.reg2hw_intr_test_qe_i(reg2hw[85:85]),
		.reg2hw_intr_state_q_i(reg2hw[107:107]),
		.hw2reg_intr_state_de_o(hw2reg[95:95]),
		.hw2reg_intr_state_d_o(hw2reg[96:96]),
		.intr_o(intr_rx_break_err_o)
	);
	prim_intr_hw #(.Width(1)) intr_hw_rx_timeout(
		.event_intr_i(event_rx_timeout),
		.reg2hw_intr_enable_q_i(reg2hw[98:98]),
		.reg2hw_intr_test_q_i(reg2hw[84:84]),
		.reg2hw_intr_test_qe_i(reg2hw[83:83]),
		.reg2hw_intr_state_q_i(reg2hw[106:106]),
		.hw2reg_intr_state_de_o(hw2reg[93:93]),
		.hw2reg_intr_state_d_o(hw2reg[94:94]),
		.intr_o(intr_rx_timeout_o)
	);
	prim_intr_hw #(.Width(1)) intr_hw_rx_parity_err(
		.event_intr_i(event_rx_parity_err),
		.reg2hw_intr_enable_q_i(reg2hw[97:97]),
		.reg2hw_intr_test_q_i(reg2hw[82:82]),
		.reg2hw_intr_test_qe_i(reg2hw[81:81]),
		.reg2hw_intr_state_q_i(reg2hw[105:105]),
		.hw2reg_intr_state_de_o(hw2reg[91:91]),
		.hw2reg_intr_state_d_o(hw2reg[92:92]),
		.intr_o(intr_rx_parity_err_o)
	);
endmodule
