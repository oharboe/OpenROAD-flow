module usbdev (
	clk_i,
	rst_ni,
	clk_usb_48mhz_i,
	tl_d_i,
	tl_d_o,
	cio_usb_dp_i,
	cio_usb_dp_o,
	cio_usb_dp_en_o,
	cio_usb_dn_i,
	cio_usb_dn_o,
	cio_usb_dn_en_o,
	cio_usb_sense_i,
	cio_usb_pullup_o,
	cio_usb_pullup_en_o,
	intr_pkt_received_o,
	intr_pkt_sent_o,
	intr_disconnected_o,
	intr_host_lost_o,
	intr_link_reset_o,
	intr_link_suspend_o,
	intr_link_resume_o,
	intr_av_empty_o,
	intr_rx_full_o,
	intr_av_overflow_o
);
	localparam top_pkg_TL_AW = 32;
	localparam top_pkg_TL_DW = 32;
	localparam top_pkg_TL_AIW = 8;
	localparam top_pkg_TL_DIW = 1;
	localparam top_pkg_TL_DUW = 16;
	localparam top_pkg_TL_DBW = (top_pkg_TL_DW >> 3);
	localparam top_pkg_TL_SZW = $clog2(($clog2((32 >> 3)) + 1));
	input clk_i;
	input rst_ni;
	input clk_usb_48mhz_i;
	input wire [(((((((7 + (((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW))) + top_pkg_TL_AIW) + top_pkg_TL_AW) + (((top_pkg_TL_DBW - 1) >= 0) ? top_pkg_TL_DBW : (2 - top_pkg_TL_DBW))) + top_pkg_TL_DW) + 17) - 1):0] tl_d_i;
	output wire [(((((((7 + (((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW))) + top_pkg_TL_AIW) + top_pkg_TL_DIW) + top_pkg_TL_DW) + top_pkg_TL_DUW) + 2) - 1):0] tl_d_o;
	input cio_usb_dp_i;
	output wire cio_usb_dp_o;
	output wire cio_usb_dp_en_o;
	input cio_usb_dn_i;
	output wire cio_usb_dn_o;
	output wire cio_usb_dn_en_o;
	input cio_usb_sense_i;
	output wire cio_usb_pullup_o;
	output wire cio_usb_pullup_en_o;
	output wire intr_pkt_received_o;
	output wire intr_pkt_sent_o;
	output wire intr_disconnected_o;
	output wire intr_host_lost_o;
	output wire intr_link_reset_o;
	output wire intr_link_suspend_o;
	output wire intr_link_resume_o;
	output wire intr_av_empty_o;
	output wire intr_rx_full_o;
	output wire intr_av_overflow_o;
	parameter USBDEV_INTR_STATE_OFFSET = 12'h 0;
	parameter USBDEV_INTR_ENABLE_OFFSET = 12'h 4;
	parameter USBDEV_INTR_TEST_OFFSET = 12'h 8;
	parameter USBDEV_USBCTRL_OFFSET = 12'h c;
	parameter USBDEV_USBSTAT_OFFSET = 12'h 10;
	parameter USBDEV_AVBUFFER_OFFSET = 12'h 14;
	parameter USBDEV_RXFIFO_OFFSET = 12'h 18;
	parameter USBDEV_RXENABLE_OFFSET = 12'h 1c;
	parameter USBDEV_IN_SENT_OFFSET = 12'h 20;
	parameter USBDEV_STALL_OFFSET = 12'h 24;
	parameter USBDEV_CONFIGIN0_OFFSET = 12'h 28;
	parameter USBDEV_CONFIGIN1_OFFSET = 12'h 2c;
	parameter USBDEV_CONFIGIN2_OFFSET = 12'h 30;
	parameter USBDEV_CONFIGIN3_OFFSET = 12'h 34;
	parameter USBDEV_CONFIGIN4_OFFSET = 12'h 38;
	parameter USBDEV_CONFIGIN5_OFFSET = 12'h 3c;
	parameter USBDEV_CONFIGIN6_OFFSET = 12'h 40;
	parameter USBDEV_CONFIGIN7_OFFSET = 12'h 44;
	parameter USBDEV_CONFIGIN8_OFFSET = 12'h 48;
	parameter USBDEV_CONFIGIN9_OFFSET = 12'h 4c;
	parameter USBDEV_CONFIGIN10_OFFSET = 12'h 50;
	parameter USBDEV_CONFIGIN11_OFFSET = 12'h 54;
	localparam signed [31:0] SramDw = 32;
	localparam signed [31:0] SramDepth = 512;
	localparam signed [31:0] MaxPktSizeByte = 64;
	localparam signed [31:0] SramAw = 9;
	localparam signed [31:0] SizeWidth = 6;
	localparam signed [31:0] NBuf = ((SramDepth * SramDw) / (MaxPktSizeByte * 8));
	localparam signed [31:0] NBufWidth = 5;
	localparam signed [31:0] AVFifoWidth = NBufWidth;
	localparam signed [31:0] AVFifoDepth = 4;
	localparam signed [31:0] RXFifoWidth = (((NBufWidth + (1 + SizeWidth)) + 4) + 1);
	localparam signed [31:0] RXFifoDepth = 4;
	wire [278:0] reg2hw;
	wire [139:0] hw2reg;
	wire [(((((((7 + ((($clog2(($clog2((32 >> 3)) + 1)) - 1) >= 0) ? $clog2(($clog2((32 >> 3)) + 1)) : (2 - $clog2(($clog2((32 >> 3)) + 1))))) + 40) + ((((32 >> 3) - 1) >= 0) ? (32 >> 3) : (2 - (32 >> 3)))) + 49) - 1) >= 0) ? ((((((((7 + ((($clog2(($clog2((32 >> 3)) + 1)) - 1) >= 0) ? $clog2(($clog2((32 >> 3)) + 1)) : (2 - $clog2(($clog2((32 >> 3)) + 1))))) + 40) + ((((32 >> 3) - 1) >= 0) ? (32 >> 3) : (2 - (32 >> 3)))) + 49) - 1) >= 0) ? ((((((7 + (((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW))) + top_pkg_TL_AIW) + top_pkg_TL_AW) + (((top_pkg_TL_DBW - 1) >= 0) ? top_pkg_TL_DBW : (2 - top_pkg_TL_DBW))) + top_pkg_TL_DW) + 17) : (2 - ((((((7 + (((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW))) + top_pkg_TL_AIW) + top_pkg_TL_AW) + (((top_pkg_TL_DBW - 1) >= 0) ? top_pkg_TL_DBW : (2 - top_pkg_TL_DBW))) + top_pkg_TL_DW) + 17))) + -1) : (((0 >= (((((7 + ((($clog2(($clog2((32 >> 3)) + 1)) - 1) >= 0) ? $clog2(($clog2((32 >> 3)) + 1)) : (2 - $clog2(($clog2((32 >> 3)) + 1))))) + 40) + ((((32 >> 3) - 1) >= 0) ? (32 >> 3) : (2 - (32 >> 3)))) + 49) - 1)) ? (2 - ((((((7 + (((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW))) + top_pkg_TL_AIW) + top_pkg_TL_AW) + (((top_pkg_TL_DBW - 1) >= 0) ? top_pkg_TL_DBW : (2 - top_pkg_TL_DBW))) + top_pkg_TL_DW) + 17)) : ((((((7 + (((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW))) + top_pkg_TL_AIW) + top_pkg_TL_AW) + (((top_pkg_TL_DBW - 1) >= 0) ? top_pkg_TL_DBW : (2 - top_pkg_TL_DBW))) + top_pkg_TL_DW) + 17)) + ((((((((7 + (((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW))) + top_pkg_TL_AIW) + top_pkg_TL_AW) + (((top_pkg_TL_DBW - 1) >= 0) ? top_pkg_TL_DBW : (2 - top_pkg_TL_DBW))) + top_pkg_TL_DW) + 17) - 1) - 1))):(((((((7 + ((($clog2(($clog2((32 >> 3)) + 1)) - 1) >= 0) ? $clog2(($clog2((32 >> 3)) + 1)) : (2 - $clog2(($clog2((32 >> 3)) + 1))))) + 40) + ((((32 >> 3) - 1) >= 0) ? (32 >> 3) : (2 - (32 >> 3)))) + 49) - 1) >= 0) ? 0 : (((((((7 + (((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW))) + top_pkg_TL_AIW) + top_pkg_TL_AW) + (((top_pkg_TL_DBW - 1) >= 0) ? top_pkg_TL_DBW : (2 - top_pkg_TL_DBW))) + top_pkg_TL_DW) + 17) - 1))] tl_sram_h2d;
	wire [(((((7 + ((($clog2(($clog2((32 >> 3)) + 1)) - 1) >= 0) ? $clog2(($clog2((32 >> 3)) + 1)) : (2 - $clog2(($clog2((32 >> 3)) + 1))))) + 59) - 1) >= 0) ? ((((((7 + ((($clog2(($clog2((32 >> 3)) + 1)) - 1) >= 0) ? $clog2(($clog2((32 >> 3)) + 1)) : (2 - $clog2(($clog2((32 >> 3)) + 1))))) + 59) - 1) >= 0) ? ((((((7 + (((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW))) + top_pkg_TL_AIW) + top_pkg_TL_DIW) + top_pkg_TL_DW) + top_pkg_TL_DUW) + 2) : (2 - ((((((7 + (((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW))) + top_pkg_TL_AIW) + top_pkg_TL_DIW) + top_pkg_TL_DW) + top_pkg_TL_DUW) + 2))) + -1) : (((0 >= (((7 + ((($clog2(($clog2((32 >> 3)) + 1)) - 1) >= 0) ? $clog2(($clog2((32 >> 3)) + 1)) : (2 - $clog2(($clog2((32 >> 3)) + 1))))) + 59) - 1)) ? (2 - ((((((7 + (((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW))) + top_pkg_TL_AIW) + top_pkg_TL_DIW) + top_pkg_TL_DW) + top_pkg_TL_DUW) + 2)) : ((((((7 + (((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW))) + top_pkg_TL_AIW) + top_pkg_TL_DIW) + top_pkg_TL_DW) + top_pkg_TL_DUW) + 2)) + ((((((((7 + (((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW))) + top_pkg_TL_AIW) + top_pkg_TL_DIW) + top_pkg_TL_DW) + top_pkg_TL_DUW) + 2) - 1) - 1))):(((((7 + ((($clog2(($clog2((32 >> 3)) + 1)) - 1) >= 0) ? $clog2(($clog2((32 >> 3)) + 1)) : (2 - $clog2(($clog2((32 >> 3)) + 1))))) + 59) - 1) >= 0) ? 0 : (((((((7 + (((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW))) + top_pkg_TL_AIW) + top_pkg_TL_DIW) + top_pkg_TL_DW) + top_pkg_TL_DUW) + 2) - 1))] tl_sram_d2h;
	wire mem_a_req;
	wire mem_a_write;
	wire [(SramAw - 1):0] mem_a_addr;
	wire [(SramDw - 1):0] mem_a_wdata;
	wire mem_a_rvalid;
	wire [(SramDw - 1):0] mem_a_rdata;
	wire [1:0] mem_a_rerror;
	wire usb_mem_b_req;
	wire usb_mem_b_write;
	wire [(SramAw - 1):0] usb_mem_b_addr;
	wire [(SramDw - 1):0] usb_mem_b_wdata;
	wire [(SramDw - 1):0] usb_mem_b_rdata;
	wire usb_clr_devaddr;
	wire event_av_empty;
	wire event_av_overflow;
	wire event_rx_full;
	wire usb_event_link_reset;
	wire usb_event_link_suspend;
	wire usb_event_link_resume;
	wire usb_event_host_lost;
	wire usb_event_disconnect;
	wire event_link_reset;
	wire event_link_suspend;
	wire event_link_resume;
	wire event_host_lost;
	wire event_disconnect;
	wire av_fifo_wready;
	wire event_pkt_received;
	wire usbdev_rst_n;
	wire usb_av_rvalid;
	wire usb_av_rready;
	wire usb_rx_wvalid;
	wire usb_rx_wready;
	wire rx_fifo_rvalid;
	wire [(AVFifoWidth - 1):0] usb_av_rdata;
	wire [(RXFifoWidth - 1):0] usb_rx_wdata;
	wire [(RXFifoWidth - 1):0] rx_rdata;
	assign event_av_overflow = (reg2hw[225:225] & ~av_fifo_wready);
	assign usbdev_rst_n = rst_ni;
	assign hw2reg[93:93] = ~av_fifo_wready;
	assign hw2reg[89:89] = ~rx_fifo_rvalid;
	prim_fifo_async #(
		.Width(AVFifoWidth),
		.Depth(AVFifoDepth)
	) usbdev_avfifo(
		.clk_wr_i(clk_i),
		.rst_wr_ni(usbdev_rst_n),
		.wvalid(reg2hw[225:225]),
		.wready(av_fifo_wready),
		.wdata(reg2hw[230:226]),
		.wdepth(hw2reg[96:94]),
		.clk_rd_i(clk_usb_48mhz_i),
		.rst_rd_ni(usbdev_rst_n),
		.rvalid(usb_av_rvalid),
		.rready(usb_av_rready),
		.rdata(usb_av_rdata),
		.rdepth()
	);
	prim_fifo_async #(
		.Width(RXFifoWidth),
		.Depth(RXFifoDepth)
	) usbdev_rxfifo(
		.clk_wr_i(clk_usb_48mhz_i),
		.rst_wr_ni(usbdev_rst_n),
		.wvalid(usb_rx_wvalid),
		.wready(usb_rx_wready),
		.wdata(usb_rx_wdata),
		.wdepth(),
		.clk_rd_i(clk_i),
		.rst_rd_ni(usbdev_rst_n),
		.rvalid(rx_fifo_rvalid),
		.rready(reg2hw[219:219]),
		.rdata(rx_rdata),
		.rdepth(hw2reg[92:90])
	);
	assign hw2reg[75:72] = rx_rdata[16:13];
	assign hw2reg[76:76] = rx_rdata[12];
	assign hw2reg[83:77] = rx_rdata[11:5];
	assign hw2reg[88:84] = rx_rdata[4:0];
	assign event_pkt_received = rx_fifo_rvalid;
	wire [2:0] unused_re;
	assign unused_re = {reg2hw[204:204], reg2hw[209:209], reg2hw[211:211]};
	wire [(NBufWidth - 1):0] usb_in_buf [0:(12 - 1)];
	wire [SizeWidth:0] usb_in_size [0:(12 - 1)];
	wire [3:0] usb_in_endpoint;
	wire [11:0] ep_stall;
	wire [11:0] usb_in_rdy;
	reg [11:0] clear_rdybit;
	reg [11:0] set_sentbit;
	reg [11:0] update_pend;
	wire usb_out_clear_rdy;
	wire out_clear_rdy;
	wire usb_set_sent;
	wire set_sent;
	wire [11:0] enable_setup;
	wire [11:0] enable_out;
	assign enable_setup = {reg2hw[192:192], reg2hw[193:193], reg2hw[194:194], reg2hw[195:195], reg2hw[196:196], reg2hw[197:197], reg2hw[198:198], reg2hw[199:199], reg2hw[200:200], reg2hw[201:201], reg2hw[202:202], reg2hw[203:203]};
	assign enable_out = {reg2hw[180:180], reg2hw[181:181], reg2hw[182:182], reg2hw[183:183], reg2hw[184:184], reg2hw[185:185], reg2hw[186:186], reg2hw[187:187], reg2hw[188:188], reg2hw[189:189], reg2hw[190:190], reg2hw[191:191]};
	assign ep_stall = {reg2hw[168:168], reg2hw[169:169], reg2hw[170:170], reg2hw[171:171], reg2hw[172:172], reg2hw[173:173], reg2hw[174:174], reg2hw[175:175], reg2hw[176:176], reg2hw[177:177], reg2hw[178:178], reg2hw[179:179]};
	assign usb_in_buf[0] = reg2hw[167:163];
	assign usb_in_size[0] = reg2hw[162:156];
	assign usb_in_buf[1] = reg2hw[153:149];
	assign usb_in_size[1] = reg2hw[148:142];
	assign usb_in_buf[2] = reg2hw[139:135];
	assign usb_in_size[2] = reg2hw[134:128];
	assign usb_in_buf[3] = reg2hw[125:121];
	assign usb_in_size[3] = reg2hw[120:114];
	assign usb_in_buf[4] = reg2hw[111:107];
	assign usb_in_size[4] = reg2hw[106:100];
	assign usb_in_buf[5] = reg2hw[97:93];
	assign usb_in_size[5] = reg2hw[92:86];
	assign usb_in_buf[6] = reg2hw[83:79];
	assign usb_in_size[6] = reg2hw[78:72];
	assign usb_in_buf[7] = reg2hw[69:65];
	assign usb_in_size[7] = reg2hw[64:58];
	assign usb_in_buf[8] = reg2hw[55:51];
	assign usb_in_size[8] = reg2hw[50:44];
	assign usb_in_buf[9] = reg2hw[41:37];
	assign usb_in_size[9] = reg2hw[36:30];
	assign usb_in_buf[10] = reg2hw[27:23];
	assign usb_in_size[10] = reg2hw[22:16];
	assign usb_in_buf[11] = reg2hw[13:9];
	assign usb_in_size[11] = reg2hw[8:2];
	prim_flop_2sync #(.Width(12)) usbdev_rdysync(
		.clk_i(clk_usb_48mhz_i),
		.rst_ni(rst_ni),
		.d({reg2hw[0:0], reg2hw[14:14], reg2hw[28:28], reg2hw[42:42], reg2hw[56:56], reg2hw[70:70], reg2hw[84:84], reg2hw[98:98], reg2hw[112:112], reg2hw[126:126], reg2hw[140:140], reg2hw[154:154]}),
		.q(usb_in_rdy)
	);
	prim_pulse_sync usbdev_setsent(
		.clk_src_i(clk_usb_48mhz_i),
		.clk_dst_i(clk_i),
		.rst_src_ni(rst_ni),
		.rst_dst_ni(rst_ni),
		.src_pulse_i(usb_set_sent),
		.dst_pulse_o(set_sent)
	);
	always @(*) begin
		set_sentbit = 12'b0;
		if (set_sent)
			set_sentbit[usb_in_endpoint] = 1;
	end
	assign {hw2reg[48:48], hw2reg[50:50], hw2reg[52:52], hw2reg[54:54], hw2reg[56:56], hw2reg[58:58], hw2reg[60:60], hw2reg[62:62], hw2reg[64:64], hw2reg[66:66], hw2reg[68:68], hw2reg[70:70]} = set_sentbit;
	assign {hw2reg[49:49], hw2reg[51:51], hw2reg[53:53], hw2reg[55:55], hw2reg[57:57], hw2reg[59:59], hw2reg[61:61], hw2reg[63:63], hw2reg[65:65], hw2reg[67:67], hw2reg[69:69], hw2reg[71:71]} = 12'hfff;
	prim_pulse_sync usbdev_outrdyclr(
		.clk_src_i(clk_usb_48mhz_i),
		.clk_dst_i(clk_i),
		.rst_src_ni(rst_ni),
		.rst_dst_ni(rst_ni),
		.src_pulse_i(usb_out_clear_rdy),
		.dst_pulse_o(out_clear_rdy)
	);
	reg event_link_reset_q;
	always @(posedge clk_usb_48mhz_i or negedge rst_ni)
		if (!rst_ni)
			event_link_reset_q <= 0;
		else
			event_link_reset_q <= event_link_reset;
	always @(*) begin
		clear_rdybit = 12'b0;
		update_pend = 12'b0;
		if ((event_link_reset && !event_link_reset_q)) begin
			clear_rdybit = 12'hfff;
			update_pend = 12'hfff;
		end
		else begin
			clear_rdybit[usb_in_endpoint] = (set_sent | out_clear_rdy);
			update_pend[usb_in_endpoint] = out_clear_rdy;
		end
	end
	assign {hw2reg[0:0], hw2reg[4:4], hw2reg[8:8], hw2reg[12:12], hw2reg[16:16], hw2reg[20:20], hw2reg[24:24], hw2reg[28:28], hw2reg[32:32], hw2reg[36:36], hw2reg[40:40], hw2reg[44:44]} = clear_rdybit;
	assign {hw2reg[1:1], hw2reg[5:5], hw2reg[9:9], hw2reg[13:13], hw2reg[17:17], hw2reg[21:21], hw2reg[25:25], hw2reg[29:29], hw2reg[33:33], hw2reg[37:37], hw2reg[41:41], hw2reg[45:45]} = 12'b0;
	assign {hw2reg[2:2], hw2reg[6:6], hw2reg[10:10], hw2reg[14:14], hw2reg[18:18], hw2reg[22:22], hw2reg[26:26], hw2reg[30:30], hw2reg[34:34], hw2reg[38:38], hw2reg[42:42], hw2reg[46:46]} = update_pend;
	assign hw2reg[3:3] = (reg2hw[0:0] | reg2hw[1:1]);
	assign hw2reg[7:7] = (reg2hw[14:14] | reg2hw[15:15]);
	assign hw2reg[11:11] = (reg2hw[28:28] | reg2hw[29:29]);
	assign hw2reg[15:15] = (reg2hw[42:42] | reg2hw[43:43]);
	assign hw2reg[19:19] = (reg2hw[56:56] | reg2hw[57:57]);
	assign hw2reg[23:23] = (reg2hw[70:70] | reg2hw[71:71]);
	assign hw2reg[27:27] = (reg2hw[84:84] | reg2hw[85:85]);
	assign hw2reg[31:31] = (reg2hw[98:98] | reg2hw[99:99]);
	assign hw2reg[35:35] = (reg2hw[112:112] | reg2hw[113:113]);
	assign hw2reg[39:39] = (reg2hw[126:126] | reg2hw[127:127]);
	assign hw2reg[43:43] = (reg2hw[140:140] | reg2hw[141:141]);
	assign hw2reg[47:47] = (reg2hw[154:154] | reg2hw[155:155]);
	assign hw2reg[97:97] = cio_usb_sense_i;
	usbdev_usbif #(
		.AVFifoWidth(AVFifoWidth),
		.RXFifoWidth(RXFifoWidth),
		.MaxPktSizeByte(MaxPktSizeByte),
		.NBuf(NBuf),
		.SramAw(SramAw)
	) usbdev_impl(
		.clk_48mhz_i(clk_usb_48mhz_i),
		.rst_ni(usbdev_rst_n),
		.usb_dp_i(cio_usb_dp_i),
		.usb_dp_o(cio_usb_dp_o),
		.usb_dp_en_o(cio_usb_dp_en_o),
		.usb_dn_i(cio_usb_dn_i),
		.usb_dn_o(cio_usb_dn_o),
		.usb_dn_en_o(cio_usb_dn_en_o),
		.usb_sense_i(cio_usb_sense_i),
		.usb_pullup_o(cio_usb_pullup_o),
		.usb_pullup_en_o(cio_usb_pullup_en_o),
		.rx_setup_i(enable_setup),
		.rx_out_i(enable_out),
		.rx_stall_i(ep_stall),
		.av_rvalid_i(usb_av_rvalid),
		.av_rready_o(usb_av_rready),
		.av_rdata_i(usb_av_rdata),
		.event_av_empty_o(event_av_empty),
		.rx_wvalid_o(usb_rx_wvalid),
		.rx_wready_i(usb_rx_wready),
		.rx_wdata_o(usb_rx_wdata),
		.event_rx_full_o(event_rx_full),
		.out_clear_rdy_o(usb_out_clear_rdy),
		.out_endpoint_o(),
		.in_buf_i(usb_in_buf[usb_in_endpoint]),
		.in_size_i(usb_in_size[usb_in_endpoint]),
		.in_stall_i(ep_stall),
		.in_rdy_i(usb_in_rdy),
		.set_sent_o(usb_set_sent),
		.in_endpoint_o(usb_in_endpoint),
		.mem_req_o(usb_mem_b_req),
		.mem_write_o(usb_mem_b_write),
		.mem_addr_o(usb_mem_b_addr),
		.mem_wdata_o(usb_mem_b_wdata),
		.mem_rdata_i(usb_mem_b_rdata),
		.enable_i(reg2hw[238:238]),
		.devaddr_i(reg2hw[237:231]),
		.clr_devaddr_o(usb_clr_devaddr),
		.frame_o(hw2reg[111:101]),
		.link_state_o(hw2reg[99:98]),
		.link_disconnect_o(usb_event_disconnect),
		.link_reset_o(usb_event_link_reset),
		.link_suspend_o(usb_event_link_suspend),
		.link_resume_o(usb_event_link_resume),
		.host_lost_o(usb_event_host_lost)
	);
	usbdev_flop_2syncpulse #(.Width(4)) syncevent(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.d({usb_event_disconnect, usb_event_link_reset, usb_event_link_suspend, usb_event_host_lost}),
		.q({event_disconnect, event_link_reset, event_link_suspend, event_host_lost})
	);
	prim_pulse_sync usbdev_resume(
		.clk_src_i(clk_usb_48mhz_i),
		.clk_dst_i(clk_i),
		.rst_src_ni(rst_ni),
		.rst_dst_ni(rst_ni),
		.src_pulse_i(usb_event_link_resume),
		.dst_pulse_o(event_link_resume)
	);
	assign hw2reg[100:100] = event_host_lost;
	prim_pulse_sync usbdev_devclr(
		.clk_src_i(clk_usb_48mhz_i),
		.clk_dst_i(clk_i),
		.rst_src_ni(rst_ni),
		.rst_dst_ni(rst_ni),
		.src_pulse_i(usb_clr_devaddr),
		.dst_pulse_o(hw2reg[112:112])
	);
	assign hw2reg[119:113] = 1'sb0;
	wire unused_mem_a_rerror_d;
	tlul_adapter_sram #(.SramAw(SramAw)) u_tlul2sram(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.tl_i(tl_sram_h2d[(((((((7 + ((($clog2(($clog2((32 >> 3)) + 1)) - 1) >= 0) ? $clog2(($clog2((32 >> 3)) + 1)) : (2 - $clog2(($clog2((32 >> 3)) + 1))))) + 40) + ((((32 >> 3) - 1) >= 0) ? (32 >> 3) : (2 - (32 >> 3)))) + 49) - 1) >= 0) ? 0 : (((((((7 + (((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW))) + top_pkg_TL_AIW) + top_pkg_TL_AW) + (((top_pkg_TL_DBW - 1) >= 0) ? top_pkg_TL_DBW : (2 - top_pkg_TL_DBW))) + top_pkg_TL_DW) + 17) - 1))+:(((((((7 + ((($clog2(($clog2((32 >> 3)) + 1)) - 1) >= 0) ? $clog2(($clog2((32 >> 3)) + 1)) : (2 - $clog2(($clog2((32 >> 3)) + 1))))) + 40) + ((((32 >> 3) - 1) >= 0) ? (32 >> 3) : (2 - (32 >> 3)))) + 49) - 1) >= 0) ? ((((((7 + (((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW))) + top_pkg_TL_AIW) + top_pkg_TL_AW) + (((top_pkg_TL_DBW - 1) >= 0) ? top_pkg_TL_DBW : (2 - top_pkg_TL_DBW))) + top_pkg_TL_DW) + 17) : (2 - ((((((7 + (((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW))) + top_pkg_TL_AIW) + top_pkg_TL_AW) + (((top_pkg_TL_DBW - 1) >= 0) ? top_pkg_TL_DBW : (2 - top_pkg_TL_DBW))) + top_pkg_TL_DW) + 17)))]),
		.tl_o(tl_sram_d2h[(((((7 + ((($clog2(($clog2((32 >> 3)) + 1)) - 1) >= 0) ? $clog2(($clog2((32 >> 3)) + 1)) : (2 - $clog2(($clog2((32 >> 3)) + 1))))) + 59) - 1) >= 0) ? 0 : (((((((7 + (((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW))) + top_pkg_TL_AIW) + top_pkg_TL_DIW) + top_pkg_TL_DW) + top_pkg_TL_DUW) + 2) - 1))+:(((((7 + ((($clog2(($clog2((32 >> 3)) + 1)) - 1) >= 0) ? $clog2(($clog2((32 >> 3)) + 1)) : (2 - $clog2(($clog2((32 >> 3)) + 1))))) + 59) - 1) >= 0) ? ((((((7 + (((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW))) + top_pkg_TL_AIW) + top_pkg_TL_DIW) + top_pkg_TL_DW) + top_pkg_TL_DUW) + 2) : (2 - ((((((7 + (((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW))) + top_pkg_TL_AIW) + top_pkg_TL_DIW) + top_pkg_TL_DW) + top_pkg_TL_DUW) + 2)))]),
		.req_o(mem_a_req),
		.gnt_i(mem_a_req),
		.we_o(mem_a_write),
		.addr_o(mem_a_addr),
		.wdata_o(mem_a_wdata),
		.wmask_o(),
		.rdata_i(mem_a_rdata),
		.rvalid_i(mem_a_rvalid),
		.rerror_i(mem_a_rerror)
	);
	assign unused_mem_a_rerror_d = mem_a_rerror[1];
	prim_ram_2p_async_adv #(
		.Depth(SramDepth),
		.Width(SramDw),
		.CfgW(8),
		.EnableECC(1),
		.EnableParity(0),
		.EnableInputPipeline(0),
		.EnableOutputPipeline(0),
		.MemT("REGISTER")
	) u_memory_2p(
		.clk_a_i(clk_i),
		.clk_b_i(clk_usb_48mhz_i),
		.rst_ni(rst_ni),
		.a_req_i(mem_a_req),
		.a_write_i(mem_a_write),
		.a_addr_i(mem_a_addr),
		.a_wdata_i(mem_a_wdata),
		.a_rvalid_o(mem_a_rvalid),
		.a_rdata_o(mem_a_rdata),
		.a_rerror_o(mem_a_rerror),
		.b_req_i(usb_mem_b_req),
		.b_write_i(usb_mem_b_write),
		.b_addr_i(usb_mem_b_addr),
		.b_wdata_i(usb_mem_b_wdata),
		.b_rvalid_o(),
		.b_rdata_o(usb_mem_b_rdata),
		.b_rerror_o(),
		.cfg_i(1'sb0)
	);
	usbdev_reg_top u_reg(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.tl_i(tl_d_i),
		.tl_o(tl_d_o),
		.tl_win_o(tl_sram_h2d),
		.tl_win_i(tl_sram_d2h),
		.reg2hw(reg2hw),
		.hw2reg(hw2reg),
		.devmode_i(1'b1)
	);
	prim_intr_hw #(.Width(1)) intr_hw_pkt_received(
		.event_intr_i(event_pkt_received),
		.reg2hw_intr_enable_q_i(reg2hw[268:268]),
		.reg2hw_intr_test_q_i(reg2hw[258:258]),
		.reg2hw_intr_test_qe_i(reg2hw[257:257]),
		.reg2hw_intr_state_q_i(reg2hw[278:278]),
		.hw2reg_intr_state_de_o(hw2reg[138:138]),
		.hw2reg_intr_state_d_o(hw2reg[139:139]),
		.intr_o(intr_pkt_received_o)
	);
	prim_intr_hw #(.Width(1)) intr_hw_pkt_sent(
		.event_intr_i(set_sent),
		.reg2hw_intr_enable_q_i(reg2hw[267:267]),
		.reg2hw_intr_test_q_i(reg2hw[256:256]),
		.reg2hw_intr_test_qe_i(reg2hw[255:255]),
		.reg2hw_intr_state_q_i(reg2hw[277:277]),
		.hw2reg_intr_state_de_o(hw2reg[136:136]),
		.hw2reg_intr_state_d_o(hw2reg[137:137]),
		.intr_o(intr_pkt_sent_o)
	);
	prim_intr_hw #(.Width(1)) intr_disconnected(
		.event_intr_i(event_disconnect),
		.reg2hw_intr_enable_q_i(reg2hw[266:266]),
		.reg2hw_intr_test_q_i(reg2hw[254:254]),
		.reg2hw_intr_test_qe_i(reg2hw[253:253]),
		.reg2hw_intr_state_q_i(reg2hw[276:276]),
		.hw2reg_intr_state_de_o(hw2reg[134:134]),
		.hw2reg_intr_state_d_o(hw2reg[135:135]),
		.intr_o(intr_disconnected_o)
	);
	prim_intr_hw #(.Width(1)) intr_host_lost(
		.event_intr_i(event_host_lost),
		.reg2hw_intr_enable_q_i(reg2hw[265:265]),
		.reg2hw_intr_test_q_i(reg2hw[252:252]),
		.reg2hw_intr_test_qe_i(reg2hw[251:251]),
		.reg2hw_intr_state_q_i(reg2hw[275:275]),
		.hw2reg_intr_state_de_o(hw2reg[132:132]),
		.hw2reg_intr_state_d_o(hw2reg[133:133]),
		.intr_o(intr_host_lost_o)
	);
	prim_intr_hw #(.Width(1)) intr_link_reset(
		.event_intr_i(event_link_reset),
		.reg2hw_intr_enable_q_i(reg2hw[264:264]),
		.reg2hw_intr_test_q_i(reg2hw[250:250]),
		.reg2hw_intr_test_qe_i(reg2hw[249:249]),
		.reg2hw_intr_state_q_i(reg2hw[274:274]),
		.hw2reg_intr_state_de_o(hw2reg[130:130]),
		.hw2reg_intr_state_d_o(hw2reg[131:131]),
		.intr_o(intr_link_reset_o)
	);
	prim_intr_hw #(.Width(1)) intr_link_suspend(
		.event_intr_i(event_link_suspend),
		.reg2hw_intr_enable_q_i(reg2hw[263:263]),
		.reg2hw_intr_test_q_i(reg2hw[248:248]),
		.reg2hw_intr_test_qe_i(reg2hw[247:247]),
		.reg2hw_intr_state_q_i(reg2hw[273:273]),
		.hw2reg_intr_state_de_o(hw2reg[128:128]),
		.hw2reg_intr_state_d_o(hw2reg[129:129]),
		.intr_o(intr_link_suspend_o)
	);
	prim_intr_hw #(.Width(1)) intr_link_resume(
		.event_intr_i(event_link_resume),
		.reg2hw_intr_enable_q_i(reg2hw[262:262]),
		.reg2hw_intr_test_q_i(reg2hw[246:246]),
		.reg2hw_intr_test_qe_i(reg2hw[245:245]),
		.reg2hw_intr_state_q_i(reg2hw[272:272]),
		.hw2reg_intr_state_de_o(hw2reg[126:126]),
		.hw2reg_intr_state_d_o(hw2reg[127:127]),
		.intr_o(intr_link_resume_o)
	);
	prim_intr_hw #(.Width(1)) intr_av_empty(
		.event_intr_i(event_av_empty),
		.reg2hw_intr_enable_q_i(reg2hw[261:261]),
		.reg2hw_intr_test_q_i(reg2hw[244:244]),
		.reg2hw_intr_test_qe_i(reg2hw[243:243]),
		.reg2hw_intr_state_q_i(reg2hw[271:271]),
		.hw2reg_intr_state_de_o(hw2reg[124:124]),
		.hw2reg_intr_state_d_o(hw2reg[125:125]),
		.intr_o(intr_av_empty_o)
	);
	prim_intr_hw #(.Width(1)) intr_rx_full(
		.event_intr_i(event_rx_full),
		.reg2hw_intr_enable_q_i(reg2hw[260:260]),
		.reg2hw_intr_test_q_i(reg2hw[242:242]),
		.reg2hw_intr_test_qe_i(reg2hw[241:241]),
		.reg2hw_intr_state_q_i(reg2hw[270:270]),
		.hw2reg_intr_state_de_o(hw2reg[122:122]),
		.hw2reg_intr_state_d_o(hw2reg[123:123]),
		.intr_o(intr_rx_full_o)
	);
	prim_intr_hw #(.Width(1)) intr_av_overflow(
		.event_intr_i(event_av_overflow),
		.reg2hw_intr_enable_q_i(reg2hw[259:259]),
		.reg2hw_intr_test_q_i(reg2hw[240:240]),
		.reg2hw_intr_test_qe_i(reg2hw[239:239]),
		.reg2hw_intr_state_q_i(reg2hw[269:269]),
		.hw2reg_intr_state_de_o(hw2reg[120:120]),
		.hw2reg_intr_state_d_o(hw2reg[121:121]),
		.intr_o(intr_av_overflow_o)
	);
endmodule
