module usbdev_reg_top (
	clk_i,
	rst_ni,
	tl_i,
	tl_o,
	tl_win_o,
	tl_win_i,
	reg2hw,
	hw2reg
);
	localparam [2:0] tlul_pkg_AccessAck = 3'h 0;
	localparam [2:0] tlul_pkg_PutFullData = 3'h 0;
	localparam [2:0] tlul_pkg_AccessAckData = 3'h 1;
	localparam [2:0] tlul_pkg_PutPartialData = 3'h 1;
	localparam [2:0] tlul_pkg_Get = 3'h 4;
	localparam top_pkg_TL_AW = 32;
	localparam top_pkg_TL_DW = 32;
	localparam top_pkg_TL_AIW = 8;
	localparam top_pkg_TL_DIW = 1;
	localparam top_pkg_TL_DUW = 16;
	localparam top_pkg_TL_DBW = (top_pkg_TL_DW >> 3);
	localparam top_pkg_TL_SZW = $clog2(($clog2((32 >> 3)) + 1));
	input clk_i;
	input rst_ni;
	input wire [(((((((7 + (((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW))) + top_pkg_TL_AIW) + top_pkg_TL_AW) + (((top_pkg_TL_DBW - 1) >= 0) ? top_pkg_TL_DBW : (2 - top_pkg_TL_DBW))) + top_pkg_TL_DW) + 17) - 1):0] tl_i;
	output wire [(((((((7 + (((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW))) + top_pkg_TL_AIW) + top_pkg_TL_DIW) + top_pkg_TL_DW) + top_pkg_TL_DUW) + 2) - 1):0] tl_o;
	output wire [(((((((7 + ((($clog2(($clog2((32 >> 3)) + 1)) - 1) >= 0) ? $clog2(($clog2((32 >> 3)) + 1)) : (2 - $clog2(($clog2((32 >> 3)) + 1))))) + 40) + ((((32 >> 3) - 1) >= 0) ? (32 >> 3) : (2 - (32 >> 3)))) + 49) - 1) >= 0) ? ((((((((7 + ((($clog2(($clog2((32 >> 3)) + 1)) - 1) >= 0) ? $clog2(($clog2((32 >> 3)) + 1)) : (2 - $clog2(($clog2((32 >> 3)) + 1))))) + 40) + ((((32 >> 3) - 1) >= 0) ? (32 >> 3) : (2 - (32 >> 3)))) + 49) - 1) >= 0) ? ((((((7 + (((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW))) + top_pkg_TL_AIW) + top_pkg_TL_AW) + (((top_pkg_TL_DBW - 1) >= 0) ? top_pkg_TL_DBW : (2 - top_pkg_TL_DBW))) + top_pkg_TL_DW) + 17) : (2 - ((((((7 + (((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW))) + top_pkg_TL_AIW) + top_pkg_TL_AW) + (((top_pkg_TL_DBW - 1) >= 0) ? top_pkg_TL_DBW : (2 - top_pkg_TL_DBW))) + top_pkg_TL_DW) + 17))) + -1) : (((0 >= (((((7 + ((($clog2(($clog2((32 >> 3)) + 1)) - 1) >= 0) ? $clog2(($clog2((32 >> 3)) + 1)) : (2 - $clog2(($clog2((32 >> 3)) + 1))))) + 40) + ((((32 >> 3) - 1) >= 0) ? (32 >> 3) : (2 - (32 >> 3)))) + 49) - 1)) ? (2 - ((((((7 + (((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW))) + top_pkg_TL_AIW) + top_pkg_TL_AW) + (((top_pkg_TL_DBW - 1) >= 0) ? top_pkg_TL_DBW : (2 - top_pkg_TL_DBW))) + top_pkg_TL_DW) + 17)) : ((((((7 + (((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW))) + top_pkg_TL_AIW) + top_pkg_TL_AW) + (((top_pkg_TL_DBW - 1) >= 0) ? top_pkg_TL_DBW : (2 - top_pkg_TL_DBW))) + top_pkg_TL_DW) + 17)) + ((((((((7 + (((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW))) + top_pkg_TL_AIW) + top_pkg_TL_AW) + (((top_pkg_TL_DBW - 1) >= 0) ? top_pkg_TL_DBW : (2 - top_pkg_TL_DBW))) + top_pkg_TL_DW) + 17) - 1) - 1))):(((((((7 + ((($clog2(($clog2((32 >> 3)) + 1)) - 1) >= 0) ? $clog2(($clog2((32 >> 3)) + 1)) : (2 - $clog2(($clog2((32 >> 3)) + 1))))) + 40) + ((((32 >> 3) - 1) >= 0) ? (32 >> 3) : (2 - (32 >> 3)))) + 49) - 1) >= 0) ? 0 : (((((((7 + (((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW))) + top_pkg_TL_AIW) + top_pkg_TL_AW) + (((top_pkg_TL_DBW - 1) >= 0) ? top_pkg_TL_DBW : (2 - top_pkg_TL_DBW))) + top_pkg_TL_DW) + 17) - 1))] tl_win_o;
	input wire [(((((7 + ((($clog2(($clog2((32 >> 3)) + 1)) - 1) >= 0) ? $clog2(($clog2((32 >> 3)) + 1)) : (2 - $clog2(($clog2((32 >> 3)) + 1))))) + 59) - 1) >= 0) ? ((((((7 + ((($clog2(($clog2((32 >> 3)) + 1)) - 1) >= 0) ? $clog2(($clog2((32 >> 3)) + 1)) : (2 - $clog2(($clog2((32 >> 3)) + 1))))) + 59) - 1) >= 0) ? ((((((7 + (((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW))) + top_pkg_TL_AIW) + top_pkg_TL_DIW) + top_pkg_TL_DW) + top_pkg_TL_DUW) + 2) : (2 - ((((((7 + (((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW))) + top_pkg_TL_AIW) + top_pkg_TL_DIW) + top_pkg_TL_DW) + top_pkg_TL_DUW) + 2))) + -1) : (((0 >= (((7 + ((($clog2(($clog2((32 >> 3)) + 1)) - 1) >= 0) ? $clog2(($clog2((32 >> 3)) + 1)) : (2 - $clog2(($clog2((32 >> 3)) + 1))))) + 59) - 1)) ? (2 - ((((((7 + (((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW))) + top_pkg_TL_AIW) + top_pkg_TL_DIW) + top_pkg_TL_DW) + top_pkg_TL_DUW) + 2)) : ((((((7 + (((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW))) + top_pkg_TL_AIW) + top_pkg_TL_DIW) + top_pkg_TL_DW) + top_pkg_TL_DUW) + 2)) + ((((((((7 + (((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW))) + top_pkg_TL_AIW) + top_pkg_TL_DIW) + top_pkg_TL_DW) + top_pkg_TL_DUW) + 2) - 1) - 1))):(((((7 + ((($clog2(($clog2((32 >> 3)) + 1)) - 1) >= 0) ? $clog2(($clog2((32 >> 3)) + 1)) : (2 - $clog2(($clog2((32 >> 3)) + 1))))) + 59) - 1) >= 0) ? 0 : (((((((7 + (((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW))) + top_pkg_TL_AIW) + top_pkg_TL_DIW) + top_pkg_TL_DW) + top_pkg_TL_DUW) + 2) - 1))] tl_win_i;
	output wire [278:0] reg2hw;
	input wire [139:0] hw2reg;
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
	localparam AW = 12;
	localparam IW = (((8 + (32 + (((((32 >> 3) - 1) >= 0) ? (32 >> 3) : (2 - (32 >> 3))) + 48))) >= (32 + (((((32 >> 3) - 1) >= 0) ? (32 >> 3) : (2 - (32 >> 3))) + 49))) ? (((top_pkg_TL_AIW + (top_pkg_TL_AW + ((((top_pkg_TL_DBW - 1) >= 0) ? top_pkg_TL_DBW : (2 - top_pkg_TL_DBW)) + (top_pkg_TL_DW + 16)))) - (top_pkg_TL_AW + ((((top_pkg_TL_DBW - 1) >= 0) ? top_pkg_TL_DBW : (2 - top_pkg_TL_DBW)) + (top_pkg_TL_DW + 17)))) + 1) : (((top_pkg_TL_AW + ((((top_pkg_TL_DBW - 1) >= 0) ? top_pkg_TL_DBW : (2 - top_pkg_TL_DBW)) + (top_pkg_TL_DW + 17))) - (top_pkg_TL_AIW + (top_pkg_TL_AW + ((((top_pkg_TL_DBW - 1) >= 0) ? top_pkg_TL_DBW : (2 - top_pkg_TL_DBW)) + (top_pkg_TL_DW + 16))))) + 1));
	localparam DW = 32;
	localparam DBW = (DW / 8);
	localparam [(2 - 1):0] FSZ = 2;
	wire reg_we;
	wire reg_re;
	wire [(AW - 1):0] reg_addr;
	wire [(DW - 1):0] reg_wdata;
	reg reg_valid;
	reg [(DW - 1):0] reg_rdata;
	reg tl_malformed;
	reg tl_addrmiss;
	reg [2:0] rsp_opcode;
	reg reqready;
	wire [(IW - 1):0] reqid;
	reg [(IW - 1):0] rspid;
	reg outstanding;
	wire [(((((((7 + (((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW))) + top_pkg_TL_AIW) + top_pkg_TL_AW) + (((top_pkg_TL_DBW - 1) >= 0) ? top_pkg_TL_DBW : (2 - top_pkg_TL_DBW))) + top_pkg_TL_DW) + 17) - 1):0] tl_reg_h2d;
	wire [(((((((7 + (((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW))) + top_pkg_TL_AIW) + top_pkg_TL_DIW) + top_pkg_TL_DW) + top_pkg_TL_DUW) + 2) - 1):0] tl_reg_d2h;
	wire [(((((((7 + ((($clog2(($clog2((32 >> 3)) + 1)) - 1) >= 0) ? $clog2(($clog2((32 >> 3)) + 1)) : (2 - $clog2(($clog2((32 >> 3)) + 1))))) + 40) + ((((32 >> 3) - 1) >= 0) ? (32 >> 3) : (2 - (32 >> 3)))) + 49) - 1) >= 0) ? ((2 * (((((((7 + ((($clog2(($clog2((32 >> 3)) + 1)) - 1) >= 0) ? $clog2(($clog2((32 >> 3)) + 1)) : (2 - $clog2(($clog2((32 >> 3)) + 1))))) + 40) + ((((32 >> 3) - 1) >= 0) ? (32 >> 3) : (2 - (32 >> 3)))) + 49) - 1) >= 0) ? ((((((7 + (((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW))) + top_pkg_TL_AIW) + top_pkg_TL_AW) + (((top_pkg_TL_DBW - 1) >= 0) ? top_pkg_TL_DBW : (2 - top_pkg_TL_DBW))) + top_pkg_TL_DW) + 17) : (2 - ((((((7 + (((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW))) + top_pkg_TL_AIW) + top_pkg_TL_AW) + (((top_pkg_TL_DBW - 1) >= 0) ? top_pkg_TL_DBW : (2 - top_pkg_TL_DBW))) + top_pkg_TL_DW) + 17)))) + -1) : ((2 * ((0 >= (((((7 + ((($clog2(($clog2((32 >> 3)) + 1)) - 1) >= 0) ? $clog2(($clog2((32 >> 3)) + 1)) : (2 - $clog2(($clog2((32 >> 3)) + 1))))) + 40) + ((((32 >> 3) - 1) >= 0) ? (32 >> 3) : (2 - (32 >> 3)))) + 49) - 1)) ? (2 - ((((((7 + (((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW))) + top_pkg_TL_AIW) + top_pkg_TL_AW) + (((top_pkg_TL_DBW - 1) >= 0) ? top_pkg_TL_DBW : (2 - top_pkg_TL_DBW))) + top_pkg_TL_DW) + 17)) : ((((((7 + (((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW))) + top_pkg_TL_AIW) + top_pkg_TL_AW) + (((top_pkg_TL_DBW - 1) >= 0) ? top_pkg_TL_DBW : (2 - top_pkg_TL_DBW))) + top_pkg_TL_DW) + 17))) + ((((((((7 + (((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW))) + top_pkg_TL_AIW) + top_pkg_TL_AW) + (((top_pkg_TL_DBW - 1) >= 0) ? top_pkg_TL_DBW : (2 - top_pkg_TL_DBW))) + top_pkg_TL_DW) + 17) - 1) - 1))):(((((((7 + ((($clog2(($clog2((32 >> 3)) + 1)) - 1) >= 0) ? $clog2(($clog2((32 >> 3)) + 1)) : (2 - $clog2(($clog2((32 >> 3)) + 1))))) + 40) + ((((32 >> 3) - 1) >= 0) ? (32 >> 3) : (2 - (32 >> 3)))) + 49) - 1) >= 0) ? 0 : (((((((7 + (((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW))) + top_pkg_TL_AIW) + top_pkg_TL_AW) + (((top_pkg_TL_DBW - 1) >= 0) ? top_pkg_TL_DBW : (2 - top_pkg_TL_DBW))) + top_pkg_TL_DW) + 17) - 1))] tl_socket_h2d;
	wire [(((((7 + ((($clog2(($clog2((32 >> 3)) + 1)) - 1) >= 0) ? $clog2(($clog2((32 >> 3)) + 1)) : (2 - $clog2(($clog2((32 >> 3)) + 1))))) + 59) - 1) >= 0) ? ((2 * (((((7 + ((($clog2(($clog2((32 >> 3)) + 1)) - 1) >= 0) ? $clog2(($clog2((32 >> 3)) + 1)) : (2 - $clog2(($clog2((32 >> 3)) + 1))))) + 59) - 1) >= 0) ? ((((((7 + (((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW))) + top_pkg_TL_AIW) + top_pkg_TL_DIW) + top_pkg_TL_DW) + top_pkg_TL_DUW) + 2) : (2 - ((((((7 + (((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW))) + top_pkg_TL_AIW) + top_pkg_TL_DIW) + top_pkg_TL_DW) + top_pkg_TL_DUW) + 2)))) + -1) : ((2 * ((0 >= (((7 + ((($clog2(($clog2((32 >> 3)) + 1)) - 1) >= 0) ? $clog2(($clog2((32 >> 3)) + 1)) : (2 - $clog2(($clog2((32 >> 3)) + 1))))) + 59) - 1)) ? (2 - ((((((7 + (((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW))) + top_pkg_TL_AIW) + top_pkg_TL_DIW) + top_pkg_TL_DW) + top_pkg_TL_DUW) + 2)) : ((((((7 + (((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW))) + top_pkg_TL_AIW) + top_pkg_TL_DIW) + top_pkg_TL_DW) + top_pkg_TL_DUW) + 2))) + ((((((((7 + (((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW))) + top_pkg_TL_AIW) + top_pkg_TL_DIW) + top_pkg_TL_DW) + top_pkg_TL_DUW) + 2) - 1) - 1))):(((((7 + ((($clog2(($clog2((32 >> 3)) + 1)) - 1) >= 0) ? $clog2(($clog2((32 >> 3)) + 1)) : (2 - $clog2(($clog2((32 >> 3)) + 1))))) + 59) - 1) >= 0) ? 0 : (((((((7 + (((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW))) + top_pkg_TL_AIW) + top_pkg_TL_DIW) + top_pkg_TL_DW) + top_pkg_TL_DUW) + 2) - 1))] tl_socket_d2h;
	reg [1:0] reg_steer;
	assign tl_reg_h2d = tl_socket_h2d[(((((((7 + ((($clog2(($clog2((32 >> 3)) + 1)) - 1) >= 0) ? $clog2(($clog2((32 >> 3)) + 1)) : (2 - $clog2(($clog2((32 >> 3)) + 1))))) + 40) + ((((32 >> 3) - 1) >= 0) ? (32 >> 3) : (2 - (32 >> 3)))) + 49) - 1) >= 0) ? 0 : (((((((7 + (((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW))) + top_pkg_TL_AIW) + top_pkg_TL_AW) + (((top_pkg_TL_DBW - 1) >= 0) ? top_pkg_TL_DBW : (2 - top_pkg_TL_DBW))) + top_pkg_TL_DW) + 17) - 1))+:(((((((7 + ((($clog2(($clog2((32 >> 3)) + 1)) - 1) >= 0) ? $clog2(($clog2((32 >> 3)) + 1)) : (2 - $clog2(($clog2((32 >> 3)) + 1))))) + 40) + ((((32 >> 3) - 1) >= 0) ? (32 >> 3) : (2 - (32 >> 3)))) + 49) - 1) >= 0) ? ((((((7 + (((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW))) + top_pkg_TL_AIW) + top_pkg_TL_AW) + (((top_pkg_TL_DBW - 1) >= 0) ? top_pkg_TL_DBW : (2 - top_pkg_TL_DBW))) + top_pkg_TL_DW) + 17) : (2 - ((((((7 + (((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW))) + top_pkg_TL_AIW) + top_pkg_TL_AW) + (((top_pkg_TL_DBW - 1) >= 0) ? top_pkg_TL_DBW : (2 - top_pkg_TL_DBW))) + top_pkg_TL_DW) + 17)))];
	assign tl_socket_d2h[(((((7 + ((($clog2(($clog2((32 >> 3)) + 1)) - 1) >= 0) ? $clog2(($clog2((32 >> 3)) + 1)) : (2 - $clog2(($clog2((32 >> 3)) + 1))))) + 59) - 1) >= 0) ? 0 : (((((((7 + (((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW))) + top_pkg_TL_AIW) + top_pkg_TL_DIW) + top_pkg_TL_DW) + top_pkg_TL_DUW) + 2) - 1))+:(((((7 + ((($clog2(($clog2((32 >> 3)) + 1)) - 1) >= 0) ? $clog2(($clog2((32 >> 3)) + 1)) : (2 - $clog2(($clog2((32 >> 3)) + 1))))) + 59) - 1) >= 0) ? ((((((7 + (((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW))) + top_pkg_TL_AIW) + top_pkg_TL_DIW) + top_pkg_TL_DW) + top_pkg_TL_DUW) + 2) : (2 - ((((((7 + (((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW))) + top_pkg_TL_AIW) + top_pkg_TL_DIW) + top_pkg_TL_DW) + top_pkg_TL_DUW) + 2)))] = tl_reg_d2h;
	assign tl_win_o[(((((((7 + ((($clog2(($clog2((32 >> 3)) + 1)) - 1) >= 0) ? $clog2(($clog2((32 >> 3)) + 1)) : (2 - $clog2(($clog2((32 >> 3)) + 1))))) + 40) + ((((32 >> 3) - 1) >= 0) ? (32 >> 3) : (2 - (32 >> 3)))) + 49) - 1) >= 0) ? 0 : (((((((7 + (((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW))) + top_pkg_TL_AIW) + top_pkg_TL_AW) + (((top_pkg_TL_DBW - 1) >= 0) ? top_pkg_TL_DBW : (2 - top_pkg_TL_DBW))) + top_pkg_TL_DW) + 17) - 1))+:(((((((7 + ((($clog2(($clog2((32 >> 3)) + 1)) - 1) >= 0) ? $clog2(($clog2((32 >> 3)) + 1)) : (2 - $clog2(($clog2((32 >> 3)) + 1))))) + 40) + ((((32 >> 3) - 1) >= 0) ? (32 >> 3) : (2 - (32 >> 3)))) + 49) - 1) >= 0) ? ((((((7 + (((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW))) + top_pkg_TL_AIW) + top_pkg_TL_AW) + (((top_pkg_TL_DBW - 1) >= 0) ? top_pkg_TL_DBW : (2 - top_pkg_TL_DBW))) + top_pkg_TL_DW) + 17) : (2 - ((((((7 + (((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW))) + top_pkg_TL_AIW) + top_pkg_TL_AW) + (((top_pkg_TL_DBW - 1) >= 0) ? top_pkg_TL_DBW : (2 - top_pkg_TL_DBW))) + top_pkg_TL_DW) + 17)))] = tl_socket_h2d[((((((((7 + ((($clog2(($clog2((32 >> 3)) + 1)) - 1) >= 0) ? $clog2(($clog2((32 >> 3)) + 1)) : (2 - $clog2(($clog2((32 >> 3)) + 1))))) + 40) + ((((32 >> 3) - 1) >= 0) ? (32 >> 3) : (2 - (32 >> 3)))) + 49) - 1) >= 0) ? 0 : (((((((7 + (((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW))) + top_pkg_TL_AIW) + top_pkg_TL_AW) + (((top_pkg_TL_DBW - 1) >= 0) ? top_pkg_TL_DBW : (2 - top_pkg_TL_DBW))) + top_pkg_TL_DW) + 17) - 1)) + (((((((7 + ((($clog2(($clog2((32 >> 3)) + 1)) - 1) >= 0) ? $clog2(($clog2((32 >> 3)) + 1)) : (2 - $clog2(($clog2((32 >> 3)) + 1))))) + 40) + ((((32 >> 3) - 1) >= 0) ? (32 >> 3) : (2 - (32 >> 3)))) + 49) - 1) >= 0) ? ((((((7 + (((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW))) + top_pkg_TL_AIW) + top_pkg_TL_AW) + (((top_pkg_TL_DBW - 1) >= 0) ? top_pkg_TL_DBW : (2 - top_pkg_TL_DBW))) + top_pkg_TL_DW) + 17) : (2 - ((((((7 + (((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW))) + top_pkg_TL_AIW) + top_pkg_TL_AW) + (((top_pkg_TL_DBW - 1) >= 0) ? top_pkg_TL_DBW : (2 - top_pkg_TL_DBW))) + top_pkg_TL_DW) + 17))))+:(((((((7 + ((($clog2(($clog2((32 >> 3)) + 1)) - 1) >= 0) ? $clog2(($clog2((32 >> 3)) + 1)) : (2 - $clog2(($clog2((32 >> 3)) + 1))))) + 40) + ((((32 >> 3) - 1) >= 0) ? (32 >> 3) : (2 - (32 >> 3)))) + 49) - 1) >= 0) ? ((((((7 + (((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW))) + top_pkg_TL_AIW) + top_pkg_TL_AW) + (((top_pkg_TL_DBW - 1) >= 0) ? top_pkg_TL_DBW : (2 - top_pkg_TL_DBW))) + top_pkg_TL_DW) + 17) : (2 - ((((((7 + (((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW))) + top_pkg_TL_AIW) + top_pkg_TL_AW) + (((top_pkg_TL_DBW - 1) >= 0) ? top_pkg_TL_DBW : (2 - top_pkg_TL_DBW))) + top_pkg_TL_DW) + 17)))];
	assign tl_socket_d2h[((((((7 + ((($clog2(($clog2((32 >> 3)) + 1)) - 1) >= 0) ? $clog2(($clog2((32 >> 3)) + 1)) : (2 - $clog2(($clog2((32 >> 3)) + 1))))) + 59) - 1) >= 0) ? 0 : (((((((7 + (((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW))) + top_pkg_TL_AIW) + top_pkg_TL_DIW) + top_pkg_TL_DW) + top_pkg_TL_DUW) + 2) - 1)) + (((((7 + ((($clog2(($clog2((32 >> 3)) + 1)) - 1) >= 0) ? $clog2(($clog2((32 >> 3)) + 1)) : (2 - $clog2(($clog2((32 >> 3)) + 1))))) + 59) - 1) >= 0) ? ((((((7 + (((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW))) + top_pkg_TL_AIW) + top_pkg_TL_DIW) + top_pkg_TL_DW) + top_pkg_TL_DUW) + 2) : (2 - ((((((7 + (((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW))) + top_pkg_TL_AIW) + top_pkg_TL_DIW) + top_pkg_TL_DW) + top_pkg_TL_DUW) + 2))))+:(((((7 + ((($clog2(($clog2((32 >> 3)) + 1)) - 1) >= 0) ? $clog2(($clog2((32 >> 3)) + 1)) : (2 - $clog2(($clog2((32 >> 3)) + 1))))) + 59) - 1) >= 0) ? ((((((7 + (((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW))) + top_pkg_TL_AIW) + top_pkg_TL_DIW) + top_pkg_TL_DW) + top_pkg_TL_DUW) + 2) : (2 - ((((((7 + (((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW))) + top_pkg_TL_AIW) + top_pkg_TL_DIW) + top_pkg_TL_DW) + top_pkg_TL_DUW) + 2)))] = tl_win_i[(((((7 + ((($clog2(($clog2((32 >> 3)) + 1)) - 1) >= 0) ? $clog2(($clog2((32 >> 3)) + 1)) : (2 - $clog2(($clog2((32 >> 3)) + 1))))) + 59) - 1) >= 0) ? 0 : (((((((7 + (((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW))) + top_pkg_TL_AIW) + top_pkg_TL_DIW) + top_pkg_TL_DW) + top_pkg_TL_DUW) + 2) - 1))+:(((((7 + ((($clog2(($clog2((32 >> 3)) + 1)) - 1) >= 0) ? $clog2(($clog2((32 >> 3)) + 1)) : (2 - $clog2(($clog2((32 >> 3)) + 1))))) + 59) - 1) >= 0) ? ((((((7 + (((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW))) + top_pkg_TL_AIW) + top_pkg_TL_DIW) + top_pkg_TL_DW) + top_pkg_TL_DUW) + 2) : (2 - ((((((7 + (((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW))) + top_pkg_TL_AIW) + top_pkg_TL_DIW) + top_pkg_TL_DW) + top_pkg_TL_DUW) + 2)))];
	tlul_socket_1n #(
		.N(2),
		.HReqPass(1'b1),
		.HRspPass(1'b1),
		.DReqPass({2 {1'b1}}),
		.DRspPass({2 {1'b1}}),
		.HReqDepth(4'h1),
		.HRspDepth(4'h1),
		.DReqDepth({2 {4'h1}}),
		.DRspDepth({2 {4'h1}})
	) u_socket(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.tl_h_i(tl_i),
		.tl_h_o(tl_o),
		.tl_d_o(tl_socket_h2d),
		.tl_d_i(tl_socket_d2h),
		.dev_select(reg_steer)
	);
	always @(*) begin
		reg_steer = 1;
		if (((tl_i[(((((top_pkg_TL_DBW - 1) >= 0) ? top_pkg_TL_DBW : (2 - top_pkg_TL_DBW)) + (top_pkg_TL_DW + 17)) + (AW - 1)):((((top_pkg_TL_DBW - 1) >= 0) ? top_pkg_TL_DBW : (2 - top_pkg_TL_DBW)) + (top_pkg_TL_DW + 17))] >= 2048) && (tl_i[(((((top_pkg_TL_DBW - 1) >= 0) ? top_pkg_TL_DBW : (2 - top_pkg_TL_DBW)) + (top_pkg_TL_DW + 17)) + (AW - 1)):((((top_pkg_TL_DBW - 1) >= 0) ? top_pkg_TL_DBW : (2 - top_pkg_TL_DBW)) + (top_pkg_TL_DW + 17))] < 4096)))
			reg_steer = 0;
	end
	assign reg_we = ((tl_reg_h2d[(1 + (3 + (3 + ((((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW)) + (top_pkg_TL_AIW + (top_pkg_TL_AW + ((((top_pkg_TL_DBW - 1) >= 0) ? top_pkg_TL_DBW : (2 - top_pkg_TL_DBW)) + (top_pkg_TL_DW + 16)))))))):(3 + (3 + ((((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW)) + (top_pkg_TL_AIW + (top_pkg_TL_AW + ((((top_pkg_TL_DBW - 1) >= 0) ? top_pkg_TL_DBW : (2 - top_pkg_TL_DBW)) + (top_pkg_TL_DW + 17)))))))] && tl_reg_d2h[0:0]) && ((tl_reg_h2d[(3 + (3 + ((((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW)) + (top_pkg_TL_AIW + (top_pkg_TL_AW + ((((top_pkg_TL_DBW - 1) >= 0) ? top_pkg_TL_DBW : (2 - top_pkg_TL_DBW)) + (top_pkg_TL_DW + 16))))))):(3 + ((((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW)) + (top_pkg_TL_AIW + (top_pkg_TL_AW + ((((top_pkg_TL_DBW - 1) >= 0) ? top_pkg_TL_DBW : (2 - top_pkg_TL_DBW)) + (top_pkg_TL_DW + 17))))))] == tlul_pkg_PutFullData) || (tl_reg_h2d[(3 + (3 + ((((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW)) + (top_pkg_TL_AIW + (top_pkg_TL_AW + ((((top_pkg_TL_DBW - 1) >= 0) ? top_pkg_TL_DBW : (2 - top_pkg_TL_DBW)) + (top_pkg_TL_DW + 16))))))):(3 + ((((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW)) + (top_pkg_TL_AIW + (top_pkg_TL_AW + ((((top_pkg_TL_DBW - 1) >= 0) ? top_pkg_TL_DBW : (2 - top_pkg_TL_DBW)) + (top_pkg_TL_DW + 17))))))] == tlul_pkg_PutPartialData)));
	assign reg_re = ((tl_reg_h2d[(1 + (3 + (3 + ((((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW)) + (top_pkg_TL_AIW + (top_pkg_TL_AW + ((((top_pkg_TL_DBW - 1) >= 0) ? top_pkg_TL_DBW : (2 - top_pkg_TL_DBW)) + (top_pkg_TL_DW + 16)))))))):(3 + (3 + ((((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW)) + (top_pkg_TL_AIW + (top_pkg_TL_AW + ((((top_pkg_TL_DBW - 1) >= 0) ? top_pkg_TL_DBW : (2 - top_pkg_TL_DBW)) + (top_pkg_TL_DW + 17)))))))] && tl_reg_d2h[0:0]) && (tl_reg_h2d[(3 + (3 + ((((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW)) + (top_pkg_TL_AIW + (top_pkg_TL_AW + ((((top_pkg_TL_DBW - 1) >= 0) ? top_pkg_TL_DBW : (2 - top_pkg_TL_DBW)) + (top_pkg_TL_DW + 16))))))):(3 + ((((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW)) + (top_pkg_TL_AIW + (top_pkg_TL_AW + ((((top_pkg_TL_DBW - 1) >= 0) ? top_pkg_TL_DBW : (2 - top_pkg_TL_DBW)) + (top_pkg_TL_DW + 17))))))] == tlul_pkg_Get));
	assign reg_addr = tl_reg_h2d[(((((top_pkg_TL_DBW - 1) >= 0) ? top_pkg_TL_DBW : (2 - top_pkg_TL_DBW)) + (top_pkg_TL_DW + 17)) + (AW - 1)):((((top_pkg_TL_DBW - 1) >= 0) ? top_pkg_TL_DBW : (2 - top_pkg_TL_DBW)) + (top_pkg_TL_DW + 17))];
	assign reg_wdata = tl_reg_h2d[(top_pkg_TL_DW + 16):17];
	assign tl_reg_d2h[(1 + (3 + (3 + ((((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW)) + (top_pkg_TL_AIW + (top_pkg_TL_DIW + (top_pkg_TL_DW + (top_pkg_TL_DUW + 1)))))))):(3 + (3 + ((((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW)) + (top_pkg_TL_AIW + (top_pkg_TL_DIW + (top_pkg_TL_DW + (top_pkg_TL_DUW + 2)))))))] = reg_valid;
	assign tl_reg_d2h[(3 + (3 + ((((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW)) + (top_pkg_TL_AIW + (top_pkg_TL_DIW + (top_pkg_TL_DW + (top_pkg_TL_DUW + 1))))))):(3 + ((((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW)) + (top_pkg_TL_AIW + (top_pkg_TL_DIW + (top_pkg_TL_DW + (top_pkg_TL_DUW + 2))))))] = rsp_opcode;
	assign tl_reg_d2h[(3 + ((((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW)) + (top_pkg_TL_AIW + (top_pkg_TL_DIW + (top_pkg_TL_DW + (top_pkg_TL_DUW + 1)))))):((((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW)) + (top_pkg_TL_AIW + (top_pkg_TL_DIW + (top_pkg_TL_DW + (top_pkg_TL_DUW + 2)))))] = 1'sb0;
	assign tl_reg_d2h[((((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW)) + (top_pkg_TL_AIW + (top_pkg_TL_DIW + (top_pkg_TL_DW + (top_pkg_TL_DUW + 1))))):(top_pkg_TL_AIW + (top_pkg_TL_DIW + (top_pkg_TL_DW + (top_pkg_TL_DUW + 2))))] = FSZ;
	assign tl_reg_d2h[(top_pkg_TL_AIW + (top_pkg_TL_DIW + (top_pkg_TL_DW + (top_pkg_TL_DUW + 1)))):(top_pkg_TL_DIW + (top_pkg_TL_DW + (top_pkg_TL_DUW + 2)))] = rspid;
	assign tl_reg_d2h[(top_pkg_TL_DIW + (top_pkg_TL_DW + (top_pkg_TL_DUW + 1))):(top_pkg_TL_DW + (top_pkg_TL_DUW + 2))] = 1'sb0;
	assign tl_reg_d2h[(top_pkg_TL_DW + (top_pkg_TL_DUW + 1)):(top_pkg_TL_DUW + 2)] = reg_rdata;
	assign tl_reg_d2h[(top_pkg_TL_DUW + 1):2] = 1'sb0;
	assign tl_reg_d2h[1:1] = (tl_malformed | tl_addrmiss);
	assign tl_reg_d2h[0:0] = reqready;
	assign reqid = tl_reg_h2d[(top_pkg_TL_AIW + (top_pkg_TL_AW + ((((top_pkg_TL_DBW - 1) >= 0) ? top_pkg_TL_DBW : (2 - top_pkg_TL_DBW)) + (top_pkg_TL_DW + 16)))):(top_pkg_TL_AW + ((((top_pkg_TL_DBW - 1) >= 0) ? top_pkg_TL_DBW : (2 - top_pkg_TL_DBW)) + (top_pkg_TL_DW + 17)))];
	always @(posedge clk_i or negedge rst_ni)
		if (!rst_ni)
			tl_malformed <= 1'b1;
		else if ((tl_reg_h2d[(1 + (3 + (3 + ((((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW)) + (top_pkg_TL_AIW + (top_pkg_TL_AW + ((((top_pkg_TL_DBW - 1) >= 0) ? top_pkg_TL_DBW : (2 - top_pkg_TL_DBW)) + (top_pkg_TL_DW + 16)))))))):(3 + (3 + ((((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW)) + (top_pkg_TL_AIW + (top_pkg_TL_AW + ((((top_pkg_TL_DBW - 1) >= 0) ? top_pkg_TL_DBW : (2 - top_pkg_TL_DBW)) + (top_pkg_TL_DW + 17)))))))] && tl_reg_d2h[0:0]))
			if ((((tl_reg_h2d[(3 + (3 + ((((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW)) + (top_pkg_TL_AIW + (top_pkg_TL_AW + ((((top_pkg_TL_DBW - 1) >= 0) ? top_pkg_TL_DBW : (2 - top_pkg_TL_DBW)) + (top_pkg_TL_DW + 16))))))):(3 + ((((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW)) + (top_pkg_TL_AIW + (top_pkg_TL_AW + ((((top_pkg_TL_DBW - 1) >= 0) ? top_pkg_TL_DBW : (2 - top_pkg_TL_DBW)) + (top_pkg_TL_DW + 17))))))] != tlul_pkg_Get) && (tl_reg_h2d[(3 + (3 + ((((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW)) + (top_pkg_TL_AIW + (top_pkg_TL_AW + ((((top_pkg_TL_DBW - 1) >= 0) ? top_pkg_TL_DBW : (2 - top_pkg_TL_DBW)) + (top_pkg_TL_DW + 16))))))):(3 + ((((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW)) + (top_pkg_TL_AIW + (top_pkg_TL_AW + ((((top_pkg_TL_DBW - 1) >= 0) ? top_pkg_TL_DBW : (2 - top_pkg_TL_DBW)) + (top_pkg_TL_DW + 17))))))] != tlul_pkg_PutFullData)) && (tl_reg_h2d[(3 + (3 + ((((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW)) + (top_pkg_TL_AIW + (top_pkg_TL_AW + ((((top_pkg_TL_DBW - 1) >= 0) ? top_pkg_TL_DBW : (2 - top_pkg_TL_DBW)) + (top_pkg_TL_DW + 16))))))):(3 + ((((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW)) + (top_pkg_TL_AIW + (top_pkg_TL_AW + ((((top_pkg_TL_DBW - 1) >= 0) ? top_pkg_TL_DBW : (2 - top_pkg_TL_DBW)) + (top_pkg_TL_DW + 17))))))] != tlul_pkg_PutPartialData)))
				tl_malformed <= 1'b1;
			else if (((tl_reg_h2d[((((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW)) + (top_pkg_TL_AIW + (top_pkg_TL_AW + ((((top_pkg_TL_DBW - 1) >= 0) ? top_pkg_TL_DBW : (2 - top_pkg_TL_DBW)) + (top_pkg_TL_DW + 16))))):(top_pkg_TL_AIW + (top_pkg_TL_AW + ((((top_pkg_TL_DBW - 1) >= 0) ? top_pkg_TL_DBW : (2 - top_pkg_TL_DBW)) + (top_pkg_TL_DW + 17))))] != FSZ) || (tl_reg_h2d[((((top_pkg_TL_DBW - 1) >= 0) ? top_pkg_TL_DBW : (2 - top_pkg_TL_DBW)) + (top_pkg_TL_DW + 16)):(top_pkg_TL_DW + 17)] != {DBW {1'b1}})))
				tl_malformed <= 1'b1;
			else if ((tl_reg_h2d[9:9] == 1'b1))
				tl_malformed <= 1'b1;
			else
				tl_malformed <= 1'b0;
	always @(posedge clk_i or negedge rst_ni)
		if (!rst_ni)
			reqready <= 1'b0;
		else if ((reg_we || reg_re))
			reqready <= 1'b0;
		else if ((outstanding == 1'b0))
			reqready <= 1'b1;
	always @(posedge clk_i or negedge rst_ni)
		if (!rst_ni)
			rspid <= 1'sb0;
		else if ((reg_we || reg_re))
			rspid <= reqid;
	wire intr_state_pkt_received_qs;
	wire intr_state_pkt_received_wd;
	wire intr_state_pkt_received_we;
	wire intr_state_pkt_sent_qs;
	wire intr_state_pkt_sent_wd;
	wire intr_state_pkt_sent_we;
	wire intr_state_disconnected_qs;
	wire intr_state_disconnected_wd;
	wire intr_state_disconnected_we;
	wire intr_state_host_lost_qs;
	wire intr_state_host_lost_wd;
	wire intr_state_host_lost_we;
	wire intr_state_link_reset_qs;
	wire intr_state_link_reset_wd;
	wire intr_state_link_reset_we;
	wire intr_state_link_suspend_qs;
	wire intr_state_link_suspend_wd;
	wire intr_state_link_suspend_we;
	wire intr_state_link_resume_qs;
	wire intr_state_link_resume_wd;
	wire intr_state_link_resume_we;
	wire intr_state_av_empty_qs;
	wire intr_state_av_empty_wd;
	wire intr_state_av_empty_we;
	wire intr_state_rx_full_qs;
	wire intr_state_rx_full_wd;
	wire intr_state_rx_full_we;
	wire intr_state_av_overflow_qs;
	wire intr_state_av_overflow_wd;
	wire intr_state_av_overflow_we;
	wire intr_enable_pkt_received_qs;
	wire intr_enable_pkt_received_wd;
	wire intr_enable_pkt_received_we;
	wire intr_enable_pkt_sent_qs;
	wire intr_enable_pkt_sent_wd;
	wire intr_enable_pkt_sent_we;
	wire intr_enable_disconnected_qs;
	wire intr_enable_disconnected_wd;
	wire intr_enable_disconnected_we;
	wire intr_enable_host_lost_qs;
	wire intr_enable_host_lost_wd;
	wire intr_enable_host_lost_we;
	wire intr_enable_link_reset_qs;
	wire intr_enable_link_reset_wd;
	wire intr_enable_link_reset_we;
	wire intr_enable_link_suspend_qs;
	wire intr_enable_link_suspend_wd;
	wire intr_enable_link_suspend_we;
	wire intr_enable_link_resume_qs;
	wire intr_enable_link_resume_wd;
	wire intr_enable_link_resume_we;
	wire intr_enable_av_empty_qs;
	wire intr_enable_av_empty_wd;
	wire intr_enable_av_empty_we;
	wire intr_enable_rx_full_qs;
	wire intr_enable_rx_full_wd;
	wire intr_enable_rx_full_we;
	wire intr_enable_av_overflow_qs;
	wire intr_enable_av_overflow_wd;
	wire intr_enable_av_overflow_we;
	wire intr_test_pkt_received_wd;
	wire intr_test_pkt_received_we;
	wire intr_test_pkt_sent_wd;
	wire intr_test_pkt_sent_we;
	wire intr_test_disconnected_wd;
	wire intr_test_disconnected_we;
	wire intr_test_host_lost_wd;
	wire intr_test_host_lost_we;
	wire intr_test_link_reset_wd;
	wire intr_test_link_reset_we;
	wire intr_test_link_suspend_wd;
	wire intr_test_link_suspend_we;
	wire intr_test_link_resume_wd;
	wire intr_test_link_resume_we;
	wire intr_test_av_empty_wd;
	wire intr_test_av_empty_we;
	wire intr_test_rx_full_wd;
	wire intr_test_rx_full_we;
	wire intr_test_av_overflow_wd;
	wire intr_test_av_overflow_we;
	wire usbctrl_enable_qs;
	wire usbctrl_enable_wd;
	wire usbctrl_enable_we;
	wire [6:0] usbctrl_device_address_qs;
	wire [6:0] usbctrl_device_address_wd;
	wire usbctrl_device_address_we;
	wire [10:0] usbstat_frame_qs;
	wire usbstat_frame_re;
	wire usbstat_host_lost_qs;
	wire usbstat_host_lost_re;
	wire [1:0] usbstat_link_state_qs;
	wire usbstat_link_state_re;
	wire usbstat_usb_sense_qs;
	wire usbstat_usb_sense_re;
	wire [2:0] usbstat_av_depth_qs;
	wire usbstat_av_depth_re;
	wire usbstat_av_full_qs;
	wire usbstat_av_full_re;
	wire [2:0] usbstat_rx_depth_qs;
	wire usbstat_rx_depth_re;
	wire usbstat_rx_empty_qs;
	wire usbstat_rx_empty_re;
	wire [4:0] avbuffer_wd;
	wire avbuffer_we;
	wire [4:0] rxfifo_buffer_qs;
	wire rxfifo_buffer_re;
	wire [6:0] rxfifo_size_qs;
	wire rxfifo_size_re;
	wire rxfifo_setup_qs;
	wire rxfifo_setup_re;
	wire [3:0] rxfifo_ep_qs;
	wire rxfifo_ep_re;
	wire rxenable_setup0_qs;
	wire rxenable_setup0_wd;
	wire rxenable_setup0_we;
	wire rxenable_setup1_qs;
	wire rxenable_setup1_wd;
	wire rxenable_setup1_we;
	wire rxenable_setup2_qs;
	wire rxenable_setup2_wd;
	wire rxenable_setup2_we;
	wire rxenable_setup3_qs;
	wire rxenable_setup3_wd;
	wire rxenable_setup3_we;
	wire rxenable_setup4_qs;
	wire rxenable_setup4_wd;
	wire rxenable_setup4_we;
	wire rxenable_setup5_qs;
	wire rxenable_setup5_wd;
	wire rxenable_setup5_we;
	wire rxenable_setup6_qs;
	wire rxenable_setup6_wd;
	wire rxenable_setup6_we;
	wire rxenable_setup7_qs;
	wire rxenable_setup7_wd;
	wire rxenable_setup7_we;
	wire rxenable_setup8_qs;
	wire rxenable_setup8_wd;
	wire rxenable_setup8_we;
	wire rxenable_setup9_qs;
	wire rxenable_setup9_wd;
	wire rxenable_setup9_we;
	wire rxenable_setup10_qs;
	wire rxenable_setup10_wd;
	wire rxenable_setup10_we;
	wire rxenable_setup11_qs;
	wire rxenable_setup11_wd;
	wire rxenable_setup11_we;
	wire rxenable_out0_qs;
	wire rxenable_out0_wd;
	wire rxenable_out0_we;
	wire rxenable_out1_qs;
	wire rxenable_out1_wd;
	wire rxenable_out1_we;
	wire rxenable_out2_qs;
	wire rxenable_out2_wd;
	wire rxenable_out2_we;
	wire rxenable_out3_qs;
	wire rxenable_out3_wd;
	wire rxenable_out3_we;
	wire rxenable_out4_qs;
	wire rxenable_out4_wd;
	wire rxenable_out4_we;
	wire rxenable_out5_qs;
	wire rxenable_out5_wd;
	wire rxenable_out5_we;
	wire rxenable_out6_qs;
	wire rxenable_out6_wd;
	wire rxenable_out6_we;
	wire rxenable_out7_qs;
	wire rxenable_out7_wd;
	wire rxenable_out7_we;
	wire rxenable_out8_qs;
	wire rxenable_out8_wd;
	wire rxenable_out8_we;
	wire rxenable_out9_qs;
	wire rxenable_out9_wd;
	wire rxenable_out9_we;
	wire rxenable_out10_qs;
	wire rxenable_out10_wd;
	wire rxenable_out10_we;
	wire rxenable_out11_qs;
	wire rxenable_out11_wd;
	wire rxenable_out11_we;
	wire in_sent_sent0_qs;
	wire in_sent_sent0_wd;
	wire in_sent_sent0_we;
	wire in_sent_sent1_qs;
	wire in_sent_sent1_wd;
	wire in_sent_sent1_we;
	wire in_sent_sent2_qs;
	wire in_sent_sent2_wd;
	wire in_sent_sent2_we;
	wire in_sent_sent3_qs;
	wire in_sent_sent3_wd;
	wire in_sent_sent3_we;
	wire in_sent_sent4_qs;
	wire in_sent_sent4_wd;
	wire in_sent_sent4_we;
	wire in_sent_sent5_qs;
	wire in_sent_sent5_wd;
	wire in_sent_sent5_we;
	wire in_sent_sent6_qs;
	wire in_sent_sent6_wd;
	wire in_sent_sent6_we;
	wire in_sent_sent7_qs;
	wire in_sent_sent7_wd;
	wire in_sent_sent7_we;
	wire in_sent_sent8_qs;
	wire in_sent_sent8_wd;
	wire in_sent_sent8_we;
	wire in_sent_sent9_qs;
	wire in_sent_sent9_wd;
	wire in_sent_sent9_we;
	wire in_sent_sent10_qs;
	wire in_sent_sent10_wd;
	wire in_sent_sent10_we;
	wire in_sent_sent11_qs;
	wire in_sent_sent11_wd;
	wire in_sent_sent11_we;
	wire stall_stall0_qs;
	wire stall_stall0_wd;
	wire stall_stall0_we;
	wire stall_stall1_qs;
	wire stall_stall1_wd;
	wire stall_stall1_we;
	wire stall_stall2_qs;
	wire stall_stall2_wd;
	wire stall_stall2_we;
	wire stall_stall3_qs;
	wire stall_stall3_wd;
	wire stall_stall3_we;
	wire stall_stall4_qs;
	wire stall_stall4_wd;
	wire stall_stall4_we;
	wire stall_stall5_qs;
	wire stall_stall5_wd;
	wire stall_stall5_we;
	wire stall_stall6_qs;
	wire stall_stall6_wd;
	wire stall_stall6_we;
	wire stall_stall7_qs;
	wire stall_stall7_wd;
	wire stall_stall7_we;
	wire stall_stall8_qs;
	wire stall_stall8_wd;
	wire stall_stall8_we;
	wire stall_stall9_qs;
	wire stall_stall9_wd;
	wire stall_stall9_we;
	wire stall_stall10_qs;
	wire stall_stall10_wd;
	wire stall_stall10_we;
	wire stall_stall11_qs;
	wire stall_stall11_wd;
	wire stall_stall11_we;
	wire [4:0] configin0_buffer0_qs;
	wire [4:0] configin0_buffer0_wd;
	wire configin0_buffer0_we;
	wire [6:0] configin0_size0_qs;
	wire [6:0] configin0_size0_wd;
	wire configin0_size0_we;
	wire configin0_pend0_qs;
	wire configin0_pend0_wd;
	wire configin0_pend0_we;
	wire configin0_rdy0_qs;
	wire configin0_rdy0_wd;
	wire configin0_rdy0_we;
	wire [4:0] configin1_buffer1_qs;
	wire [4:0] configin1_buffer1_wd;
	wire configin1_buffer1_we;
	wire [6:0] configin1_size1_qs;
	wire [6:0] configin1_size1_wd;
	wire configin1_size1_we;
	wire configin1_pend1_qs;
	wire configin1_pend1_wd;
	wire configin1_pend1_we;
	wire configin1_rdy1_qs;
	wire configin1_rdy1_wd;
	wire configin1_rdy1_we;
	wire [4:0] configin2_buffer2_qs;
	wire [4:0] configin2_buffer2_wd;
	wire configin2_buffer2_we;
	wire [6:0] configin2_size2_qs;
	wire [6:0] configin2_size2_wd;
	wire configin2_size2_we;
	wire configin2_pend2_qs;
	wire configin2_pend2_wd;
	wire configin2_pend2_we;
	wire configin2_rdy2_qs;
	wire configin2_rdy2_wd;
	wire configin2_rdy2_we;
	wire [4:0] configin3_buffer3_qs;
	wire [4:0] configin3_buffer3_wd;
	wire configin3_buffer3_we;
	wire [6:0] configin3_size3_qs;
	wire [6:0] configin3_size3_wd;
	wire configin3_size3_we;
	wire configin3_pend3_qs;
	wire configin3_pend3_wd;
	wire configin3_pend3_we;
	wire configin3_rdy3_qs;
	wire configin3_rdy3_wd;
	wire configin3_rdy3_we;
	wire [4:0] configin4_buffer4_qs;
	wire [4:0] configin4_buffer4_wd;
	wire configin4_buffer4_we;
	wire [6:0] configin4_size4_qs;
	wire [6:0] configin4_size4_wd;
	wire configin4_size4_we;
	wire configin4_pend4_qs;
	wire configin4_pend4_wd;
	wire configin4_pend4_we;
	wire configin4_rdy4_qs;
	wire configin4_rdy4_wd;
	wire configin4_rdy4_we;
	wire [4:0] configin5_buffer5_qs;
	wire [4:0] configin5_buffer5_wd;
	wire configin5_buffer5_we;
	wire [6:0] configin5_size5_qs;
	wire [6:0] configin5_size5_wd;
	wire configin5_size5_we;
	wire configin5_pend5_qs;
	wire configin5_pend5_wd;
	wire configin5_pend5_we;
	wire configin5_rdy5_qs;
	wire configin5_rdy5_wd;
	wire configin5_rdy5_we;
	wire [4:0] configin6_buffer6_qs;
	wire [4:0] configin6_buffer6_wd;
	wire configin6_buffer6_we;
	wire [6:0] configin6_size6_qs;
	wire [6:0] configin6_size6_wd;
	wire configin6_size6_we;
	wire configin6_pend6_qs;
	wire configin6_pend6_wd;
	wire configin6_pend6_we;
	wire configin6_rdy6_qs;
	wire configin6_rdy6_wd;
	wire configin6_rdy6_we;
	wire [4:0] configin7_buffer7_qs;
	wire [4:0] configin7_buffer7_wd;
	wire configin7_buffer7_we;
	wire [6:0] configin7_size7_qs;
	wire [6:0] configin7_size7_wd;
	wire configin7_size7_we;
	wire configin7_pend7_qs;
	wire configin7_pend7_wd;
	wire configin7_pend7_we;
	wire configin7_rdy7_qs;
	wire configin7_rdy7_wd;
	wire configin7_rdy7_we;
	wire [4:0] configin8_buffer8_qs;
	wire [4:0] configin8_buffer8_wd;
	wire configin8_buffer8_we;
	wire [6:0] configin8_size8_qs;
	wire [6:0] configin8_size8_wd;
	wire configin8_size8_we;
	wire configin8_pend8_qs;
	wire configin8_pend8_wd;
	wire configin8_pend8_we;
	wire configin8_rdy8_qs;
	wire configin8_rdy8_wd;
	wire configin8_rdy8_we;
	wire [4:0] configin9_buffer9_qs;
	wire [4:0] configin9_buffer9_wd;
	wire configin9_buffer9_we;
	wire [6:0] configin9_size9_qs;
	wire [6:0] configin9_size9_wd;
	wire configin9_size9_we;
	wire configin9_pend9_qs;
	wire configin9_pend9_wd;
	wire configin9_pend9_we;
	wire configin9_rdy9_qs;
	wire configin9_rdy9_wd;
	wire configin9_rdy9_we;
	wire [4:0] configin10_buffer10_qs;
	wire [4:0] configin10_buffer10_wd;
	wire configin10_buffer10_we;
	wire [6:0] configin10_size10_qs;
	wire [6:0] configin10_size10_wd;
	wire configin10_size10_we;
	wire configin10_pend10_qs;
	wire configin10_pend10_wd;
	wire configin10_pend10_we;
	wire configin10_rdy10_qs;
	wire configin10_rdy10_wd;
	wire configin10_rdy10_we;
	wire [4:0] configin11_buffer11_qs;
	wire [4:0] configin11_buffer11_wd;
	wire configin11_buffer11_we;
	wire [6:0] configin11_size11_qs;
	wire [6:0] configin11_size11_wd;
	wire configin11_size11_we;
	wire configin11_pend11_qs;
	wire configin11_pend11_wd;
	wire configin11_pend11_we;
	wire configin11_rdy11_qs;
	wire configin11_rdy11_wd;
	wire configin11_rdy11_we;
	prim_subreg #(
		.DW(1),
		.SWACCESS("W1C"),
		.RESVAL(1'h0)
	) u_intr_state_pkt_received(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(intr_state_pkt_received_we),
		.wd(intr_state_pkt_received_wd),
		.de(hw2reg[138:138]),
		.d(hw2reg[139:139]),
		.qe(),
		.q(reg2hw[278:278]),
		.qs(intr_state_pkt_received_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("W1C"),
		.RESVAL(1'h0)
	) u_intr_state_pkt_sent(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(intr_state_pkt_sent_we),
		.wd(intr_state_pkt_sent_wd),
		.de(hw2reg[136:136]),
		.d(hw2reg[137:137]),
		.qe(),
		.q(reg2hw[277:277]),
		.qs(intr_state_pkt_sent_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("W1C"),
		.RESVAL(1'h0)
	) u_intr_state_disconnected(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(intr_state_disconnected_we),
		.wd(intr_state_disconnected_wd),
		.de(hw2reg[134:134]),
		.d(hw2reg[135:135]),
		.qe(),
		.q(reg2hw[276:276]),
		.qs(intr_state_disconnected_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("W1C"),
		.RESVAL(1'h0)
	) u_intr_state_host_lost(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(intr_state_host_lost_we),
		.wd(intr_state_host_lost_wd),
		.de(hw2reg[132:132]),
		.d(hw2reg[133:133]),
		.qe(),
		.q(reg2hw[275:275]),
		.qs(intr_state_host_lost_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("W1C"),
		.RESVAL(1'h0)
	) u_intr_state_link_reset(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(intr_state_link_reset_we),
		.wd(intr_state_link_reset_wd),
		.de(hw2reg[130:130]),
		.d(hw2reg[131:131]),
		.qe(),
		.q(reg2hw[274:274]),
		.qs(intr_state_link_reset_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("W1C"),
		.RESVAL(1'h0)
	) u_intr_state_link_suspend(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(intr_state_link_suspend_we),
		.wd(intr_state_link_suspend_wd),
		.de(hw2reg[128:128]),
		.d(hw2reg[129:129]),
		.qe(),
		.q(reg2hw[273:273]),
		.qs(intr_state_link_suspend_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("W1C"),
		.RESVAL(1'h0)
	) u_intr_state_link_resume(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(intr_state_link_resume_we),
		.wd(intr_state_link_resume_wd),
		.de(hw2reg[126:126]),
		.d(hw2reg[127:127]),
		.qe(),
		.q(reg2hw[272:272]),
		.qs(intr_state_link_resume_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("W1C"),
		.RESVAL(1'h0)
	) u_intr_state_av_empty(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(intr_state_av_empty_we),
		.wd(intr_state_av_empty_wd),
		.de(hw2reg[124:124]),
		.d(hw2reg[125:125]),
		.qe(),
		.q(reg2hw[271:271]),
		.qs(intr_state_av_empty_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("W1C"),
		.RESVAL(1'h0)
	) u_intr_state_rx_full(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(intr_state_rx_full_we),
		.wd(intr_state_rx_full_wd),
		.de(hw2reg[122:122]),
		.d(hw2reg[123:123]),
		.qe(),
		.q(reg2hw[270:270]),
		.qs(intr_state_rx_full_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("W1C"),
		.RESVAL(1'h0)
	) u_intr_state_av_overflow(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(intr_state_av_overflow_we),
		.wd(intr_state_av_overflow_wd),
		.de(hw2reg[120:120]),
		.d(hw2reg[121:121]),
		.qe(),
		.q(reg2hw[269:269]),
		.qs(intr_state_av_overflow_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RW"),
		.RESVAL(1'h0)
	) u_intr_enable_pkt_received(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(intr_enable_pkt_received_we),
		.wd(intr_enable_pkt_received_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[268:268]),
		.qs(intr_enable_pkt_received_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RW"),
		.RESVAL(1'h0)
	) u_intr_enable_pkt_sent(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(intr_enable_pkt_sent_we),
		.wd(intr_enable_pkt_sent_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[267:267]),
		.qs(intr_enable_pkt_sent_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RW"),
		.RESVAL(1'h0)
	) u_intr_enable_disconnected(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(intr_enable_disconnected_we),
		.wd(intr_enable_disconnected_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[266:266]),
		.qs(intr_enable_disconnected_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RW"),
		.RESVAL(1'h0)
	) u_intr_enable_host_lost(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(intr_enable_host_lost_we),
		.wd(intr_enable_host_lost_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[265:265]),
		.qs(intr_enable_host_lost_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RW"),
		.RESVAL(1'h0)
	) u_intr_enable_link_reset(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(intr_enable_link_reset_we),
		.wd(intr_enable_link_reset_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[264:264]),
		.qs(intr_enable_link_reset_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RW"),
		.RESVAL(1'h0)
	) u_intr_enable_link_suspend(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(intr_enable_link_suspend_we),
		.wd(intr_enable_link_suspend_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[263:263]),
		.qs(intr_enable_link_suspend_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RW"),
		.RESVAL(1'h0)
	) u_intr_enable_link_resume(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(intr_enable_link_resume_we),
		.wd(intr_enable_link_resume_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[262:262]),
		.qs(intr_enable_link_resume_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RW"),
		.RESVAL(1'h0)
	) u_intr_enable_av_empty(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(intr_enable_av_empty_we),
		.wd(intr_enable_av_empty_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[261:261]),
		.qs(intr_enable_av_empty_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RW"),
		.RESVAL(1'h0)
	) u_intr_enable_rx_full(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(intr_enable_rx_full_we),
		.wd(intr_enable_rx_full_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[260:260]),
		.qs(intr_enable_rx_full_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RW"),
		.RESVAL(1'h0)
	) u_intr_enable_av_overflow(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(intr_enable_av_overflow_we),
		.wd(intr_enable_av_overflow_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[259:259]),
		.qs(intr_enable_av_overflow_qs)
	);
	prim_subreg_ext #(.DW(1)) u_intr_test_pkt_received(
		.re(1'b0),
		.we(intr_test_pkt_received_we),
		.wd(intr_test_pkt_received_wd),
		.d(1'sb0),
		.qre(),
		.qe(reg2hw[257:257]),
		.q(reg2hw[258:258]),
		.qs()
	);
	prim_subreg_ext #(.DW(1)) u_intr_test_pkt_sent(
		.re(1'b0),
		.we(intr_test_pkt_sent_we),
		.wd(intr_test_pkt_sent_wd),
		.d(1'sb0),
		.qre(),
		.qe(reg2hw[255:255]),
		.q(reg2hw[256:256]),
		.qs()
	);
	prim_subreg_ext #(.DW(1)) u_intr_test_disconnected(
		.re(1'b0),
		.we(intr_test_disconnected_we),
		.wd(intr_test_disconnected_wd),
		.d(1'sb0),
		.qre(),
		.qe(reg2hw[253:253]),
		.q(reg2hw[254:254]),
		.qs()
	);
	prim_subreg_ext #(.DW(1)) u_intr_test_host_lost(
		.re(1'b0),
		.we(intr_test_host_lost_we),
		.wd(intr_test_host_lost_wd),
		.d(1'sb0),
		.qre(),
		.qe(reg2hw[251:251]),
		.q(reg2hw[252:252]),
		.qs()
	);
	prim_subreg_ext #(.DW(1)) u_intr_test_link_reset(
		.re(1'b0),
		.we(intr_test_link_reset_we),
		.wd(intr_test_link_reset_wd),
		.d(1'sb0),
		.qre(),
		.qe(reg2hw[249:249]),
		.q(reg2hw[250:250]),
		.qs()
	);
	prim_subreg_ext #(.DW(1)) u_intr_test_link_suspend(
		.re(1'b0),
		.we(intr_test_link_suspend_we),
		.wd(intr_test_link_suspend_wd),
		.d(1'sb0),
		.qre(),
		.qe(reg2hw[247:247]),
		.q(reg2hw[248:248]),
		.qs()
	);
	prim_subreg_ext #(.DW(1)) u_intr_test_link_resume(
		.re(1'b0),
		.we(intr_test_link_resume_we),
		.wd(intr_test_link_resume_wd),
		.d(1'sb0),
		.qre(),
		.qe(reg2hw[245:245]),
		.q(reg2hw[246:246]),
		.qs()
	);
	prim_subreg_ext #(.DW(1)) u_intr_test_av_empty(
		.re(1'b0),
		.we(intr_test_av_empty_we),
		.wd(intr_test_av_empty_wd),
		.d(1'sb0),
		.qre(),
		.qe(reg2hw[243:243]),
		.q(reg2hw[244:244]),
		.qs()
	);
	prim_subreg_ext #(.DW(1)) u_intr_test_rx_full(
		.re(1'b0),
		.we(intr_test_rx_full_we),
		.wd(intr_test_rx_full_wd),
		.d(1'sb0),
		.qre(),
		.qe(reg2hw[241:241]),
		.q(reg2hw[242:242]),
		.qs()
	);
	prim_subreg_ext #(.DW(1)) u_intr_test_av_overflow(
		.re(1'b0),
		.we(intr_test_av_overflow_we),
		.wd(intr_test_av_overflow_wd),
		.d(1'sb0),
		.qre(),
		.qe(reg2hw[239:239]),
		.q(reg2hw[240:240]),
		.qs()
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RW"),
		.RESVAL(1'h0)
	) u_usbctrl_enable(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(usbctrl_enable_we),
		.wd(usbctrl_enable_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[238:238]),
		.qs(usbctrl_enable_qs)
	);
	prim_subreg #(
		.DW(7),
		.SWACCESS("RW"),
		.RESVAL(7'h0)
	) u_usbctrl_device_address(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(usbctrl_device_address_we),
		.wd(usbctrl_device_address_wd),
		.de(hw2reg[112:112]),
		.d(hw2reg[119:113]),
		.qe(),
		.q(reg2hw[237:231]),
		.qs(usbctrl_device_address_qs)
	);
	prim_subreg_ext #(.DW(11)) u_usbstat_frame(
		.re(usbstat_frame_re),
		.we(1'b0),
		.wd(1'sb0),
		.d(hw2reg[111:101]),
		.qre(),
		.qe(),
		.q(),
		.qs(usbstat_frame_qs)
	);
	prim_subreg_ext #(.DW(1)) u_usbstat_host_lost(
		.re(usbstat_host_lost_re),
		.we(1'b0),
		.wd(1'sb0),
		.d(hw2reg[100:100]),
		.qre(),
		.qe(),
		.q(),
		.qs(usbstat_host_lost_qs)
	);
	prim_subreg_ext #(.DW(2)) u_usbstat_link_state(
		.re(usbstat_link_state_re),
		.we(1'b0),
		.wd(1'sb0),
		.d(hw2reg[99:98]),
		.qre(),
		.qe(),
		.q(),
		.qs(usbstat_link_state_qs)
	);
	prim_subreg_ext #(.DW(1)) u_usbstat_usb_sense(
		.re(usbstat_usb_sense_re),
		.we(1'b0),
		.wd(1'sb0),
		.d(hw2reg[97:97]),
		.qre(),
		.qe(),
		.q(),
		.qs(usbstat_usb_sense_qs)
	);
	prim_subreg_ext #(.DW(3)) u_usbstat_av_depth(
		.re(usbstat_av_depth_re),
		.we(1'b0),
		.wd(1'sb0),
		.d(hw2reg[96:94]),
		.qre(),
		.qe(),
		.q(),
		.qs(usbstat_av_depth_qs)
	);
	prim_subreg_ext #(.DW(1)) u_usbstat_av_full(
		.re(usbstat_av_full_re),
		.we(1'b0),
		.wd(1'sb0),
		.d(hw2reg[93:93]),
		.qre(),
		.qe(),
		.q(),
		.qs(usbstat_av_full_qs)
	);
	prim_subreg_ext #(.DW(3)) u_usbstat_rx_depth(
		.re(usbstat_rx_depth_re),
		.we(1'b0),
		.wd(1'sb0),
		.d(hw2reg[92:90]),
		.qre(),
		.qe(),
		.q(),
		.qs(usbstat_rx_depth_qs)
	);
	prim_subreg_ext #(.DW(1)) u_usbstat_rx_empty(
		.re(usbstat_rx_empty_re),
		.we(1'b0),
		.wd(1'sb0),
		.d(hw2reg[89:89]),
		.qre(),
		.qe(),
		.q(),
		.qs(usbstat_rx_empty_qs)
	);
	prim_subreg #(
		.DW(5),
		.SWACCESS("WO"),
		.RESVAL(5'h0)
	) u_avbuffer(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(avbuffer_we),
		.wd(avbuffer_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(reg2hw[225:225]),
		.q(reg2hw[230:226]),
		.qs()
	);
	prim_subreg_ext #(.DW(5)) u_rxfifo_buffer(
		.re(rxfifo_buffer_re),
		.we(1'b0),
		.wd(1'sb0),
		.d(hw2reg[88:84]),
		.qre(reg2hw[219:219]),
		.qe(),
		.q(reg2hw[224:220]),
		.qs(rxfifo_buffer_qs)
	);
	prim_subreg_ext #(.DW(7)) u_rxfifo_size(
		.re(rxfifo_size_re),
		.we(1'b0),
		.wd(1'sb0),
		.d(hw2reg[83:77]),
		.qre(reg2hw[211:211]),
		.qe(),
		.q(reg2hw[218:212]),
		.qs(rxfifo_size_qs)
	);
	prim_subreg_ext #(.DW(1)) u_rxfifo_setup(
		.re(rxfifo_setup_re),
		.we(1'b0),
		.wd(1'sb0),
		.d(hw2reg[76:76]),
		.qre(reg2hw[209:209]),
		.qe(),
		.q(reg2hw[210:210]),
		.qs(rxfifo_setup_qs)
	);
	prim_subreg_ext #(.DW(4)) u_rxfifo_ep(
		.re(rxfifo_ep_re),
		.we(1'b0),
		.wd(1'sb0),
		.d(hw2reg[75:72]),
		.qre(reg2hw[204:204]),
		.qe(),
		.q(reg2hw[208:205]),
		.qs(rxfifo_ep_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RW"),
		.RESVAL(1'h0)
	) u_rxenable_setup0(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(rxenable_setup0_we),
		.wd(rxenable_setup0_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[203:203]),
		.qs(rxenable_setup0_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RW"),
		.RESVAL(1'h0)
	) u_rxenable_setup1(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(rxenable_setup1_we),
		.wd(rxenable_setup1_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[202:202]),
		.qs(rxenable_setup1_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RW"),
		.RESVAL(1'h0)
	) u_rxenable_setup2(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(rxenable_setup2_we),
		.wd(rxenable_setup2_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[201:201]),
		.qs(rxenable_setup2_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RW"),
		.RESVAL(1'h0)
	) u_rxenable_setup3(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(rxenable_setup3_we),
		.wd(rxenable_setup3_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[200:200]),
		.qs(rxenable_setup3_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RW"),
		.RESVAL(1'h0)
	) u_rxenable_setup4(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(rxenable_setup4_we),
		.wd(rxenable_setup4_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[199:199]),
		.qs(rxenable_setup4_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RW"),
		.RESVAL(1'h0)
	) u_rxenable_setup5(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(rxenable_setup5_we),
		.wd(rxenable_setup5_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[198:198]),
		.qs(rxenable_setup5_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RW"),
		.RESVAL(1'h0)
	) u_rxenable_setup6(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(rxenable_setup6_we),
		.wd(rxenable_setup6_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[197:197]),
		.qs(rxenable_setup6_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RW"),
		.RESVAL(1'h0)
	) u_rxenable_setup7(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(rxenable_setup7_we),
		.wd(rxenable_setup7_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[196:196]),
		.qs(rxenable_setup7_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RW"),
		.RESVAL(1'h0)
	) u_rxenable_setup8(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(rxenable_setup8_we),
		.wd(rxenable_setup8_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[195:195]),
		.qs(rxenable_setup8_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RW"),
		.RESVAL(1'h0)
	) u_rxenable_setup9(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(rxenable_setup9_we),
		.wd(rxenable_setup9_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[194:194]),
		.qs(rxenable_setup9_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RW"),
		.RESVAL(1'h0)
	) u_rxenable_setup10(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(rxenable_setup10_we),
		.wd(rxenable_setup10_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[193:193]),
		.qs(rxenable_setup10_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RW"),
		.RESVAL(1'h0)
	) u_rxenable_setup11(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(rxenable_setup11_we),
		.wd(rxenable_setup11_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[192:192]),
		.qs(rxenable_setup11_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RW"),
		.RESVAL(1'h0)
	) u_rxenable_out0(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(rxenable_out0_we),
		.wd(rxenable_out0_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[191:191]),
		.qs(rxenable_out0_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RW"),
		.RESVAL(1'h0)
	) u_rxenable_out1(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(rxenable_out1_we),
		.wd(rxenable_out1_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[190:190]),
		.qs(rxenable_out1_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RW"),
		.RESVAL(1'h0)
	) u_rxenable_out2(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(rxenable_out2_we),
		.wd(rxenable_out2_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[189:189]),
		.qs(rxenable_out2_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RW"),
		.RESVAL(1'h0)
	) u_rxenable_out3(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(rxenable_out3_we),
		.wd(rxenable_out3_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[188:188]),
		.qs(rxenable_out3_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RW"),
		.RESVAL(1'h0)
	) u_rxenable_out4(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(rxenable_out4_we),
		.wd(rxenable_out4_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[187:187]),
		.qs(rxenable_out4_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RW"),
		.RESVAL(1'h0)
	) u_rxenable_out5(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(rxenable_out5_we),
		.wd(rxenable_out5_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[186:186]),
		.qs(rxenable_out5_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RW"),
		.RESVAL(1'h0)
	) u_rxenable_out6(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(rxenable_out6_we),
		.wd(rxenable_out6_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[185:185]),
		.qs(rxenable_out6_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RW"),
		.RESVAL(1'h0)
	) u_rxenable_out7(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(rxenable_out7_we),
		.wd(rxenable_out7_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[184:184]),
		.qs(rxenable_out7_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RW"),
		.RESVAL(1'h0)
	) u_rxenable_out8(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(rxenable_out8_we),
		.wd(rxenable_out8_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[183:183]),
		.qs(rxenable_out8_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RW"),
		.RESVAL(1'h0)
	) u_rxenable_out9(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(rxenable_out9_we),
		.wd(rxenable_out9_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[182:182]),
		.qs(rxenable_out9_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RW"),
		.RESVAL(1'h0)
	) u_rxenable_out10(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(rxenable_out10_we),
		.wd(rxenable_out10_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[181:181]),
		.qs(rxenable_out10_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RW"),
		.RESVAL(1'h0)
	) u_rxenable_out11(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(rxenable_out11_we),
		.wd(rxenable_out11_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[180:180]),
		.qs(rxenable_out11_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("W1C"),
		.RESVAL(1'h0)
	) u_in_sent_sent0(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(in_sent_sent0_we),
		.wd(in_sent_sent0_wd),
		.de(hw2reg[70:70]),
		.d(hw2reg[71:71]),
		.qe(),
		.q(),
		.qs(in_sent_sent0_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("W1C"),
		.RESVAL(1'h0)
	) u_in_sent_sent1(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(in_sent_sent1_we),
		.wd(in_sent_sent1_wd),
		.de(hw2reg[68:68]),
		.d(hw2reg[69:69]),
		.qe(),
		.q(),
		.qs(in_sent_sent1_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("W1C"),
		.RESVAL(1'h0)
	) u_in_sent_sent2(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(in_sent_sent2_we),
		.wd(in_sent_sent2_wd),
		.de(hw2reg[66:66]),
		.d(hw2reg[67:67]),
		.qe(),
		.q(),
		.qs(in_sent_sent2_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("W1C"),
		.RESVAL(1'h0)
	) u_in_sent_sent3(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(in_sent_sent3_we),
		.wd(in_sent_sent3_wd),
		.de(hw2reg[64:64]),
		.d(hw2reg[65:65]),
		.qe(),
		.q(),
		.qs(in_sent_sent3_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("W1C"),
		.RESVAL(1'h0)
	) u_in_sent_sent4(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(in_sent_sent4_we),
		.wd(in_sent_sent4_wd),
		.de(hw2reg[62:62]),
		.d(hw2reg[63:63]),
		.qe(),
		.q(),
		.qs(in_sent_sent4_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("W1C"),
		.RESVAL(1'h0)
	) u_in_sent_sent5(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(in_sent_sent5_we),
		.wd(in_sent_sent5_wd),
		.de(hw2reg[60:60]),
		.d(hw2reg[61:61]),
		.qe(),
		.q(),
		.qs(in_sent_sent5_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("W1C"),
		.RESVAL(1'h0)
	) u_in_sent_sent6(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(in_sent_sent6_we),
		.wd(in_sent_sent6_wd),
		.de(hw2reg[58:58]),
		.d(hw2reg[59:59]),
		.qe(),
		.q(),
		.qs(in_sent_sent6_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("W1C"),
		.RESVAL(1'h0)
	) u_in_sent_sent7(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(in_sent_sent7_we),
		.wd(in_sent_sent7_wd),
		.de(hw2reg[56:56]),
		.d(hw2reg[57:57]),
		.qe(),
		.q(),
		.qs(in_sent_sent7_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("W1C"),
		.RESVAL(1'h0)
	) u_in_sent_sent8(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(in_sent_sent8_we),
		.wd(in_sent_sent8_wd),
		.de(hw2reg[54:54]),
		.d(hw2reg[55:55]),
		.qe(),
		.q(),
		.qs(in_sent_sent8_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("W1C"),
		.RESVAL(1'h0)
	) u_in_sent_sent9(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(in_sent_sent9_we),
		.wd(in_sent_sent9_wd),
		.de(hw2reg[52:52]),
		.d(hw2reg[53:53]),
		.qe(),
		.q(),
		.qs(in_sent_sent9_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("W1C"),
		.RESVAL(1'h0)
	) u_in_sent_sent10(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(in_sent_sent10_we),
		.wd(in_sent_sent10_wd),
		.de(hw2reg[50:50]),
		.d(hw2reg[51:51]),
		.qe(),
		.q(),
		.qs(in_sent_sent10_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("W1C"),
		.RESVAL(1'h0)
	) u_in_sent_sent11(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(in_sent_sent11_we),
		.wd(in_sent_sent11_wd),
		.de(hw2reg[48:48]),
		.d(hw2reg[49:49]),
		.qe(),
		.q(),
		.qs(in_sent_sent11_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RW"),
		.RESVAL(1'h0)
	) u_stall_stall0(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(stall_stall0_we),
		.wd(stall_stall0_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[179:179]),
		.qs(stall_stall0_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RW"),
		.RESVAL(1'h0)
	) u_stall_stall1(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(stall_stall1_we),
		.wd(stall_stall1_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[178:178]),
		.qs(stall_stall1_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RW"),
		.RESVAL(1'h0)
	) u_stall_stall2(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(stall_stall2_we),
		.wd(stall_stall2_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[177:177]),
		.qs(stall_stall2_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RW"),
		.RESVAL(1'h0)
	) u_stall_stall3(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(stall_stall3_we),
		.wd(stall_stall3_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[176:176]),
		.qs(stall_stall3_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RW"),
		.RESVAL(1'h0)
	) u_stall_stall4(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(stall_stall4_we),
		.wd(stall_stall4_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[175:175]),
		.qs(stall_stall4_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RW"),
		.RESVAL(1'h0)
	) u_stall_stall5(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(stall_stall5_we),
		.wd(stall_stall5_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[174:174]),
		.qs(stall_stall5_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RW"),
		.RESVAL(1'h0)
	) u_stall_stall6(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(stall_stall6_we),
		.wd(stall_stall6_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[173:173]),
		.qs(stall_stall6_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RW"),
		.RESVAL(1'h0)
	) u_stall_stall7(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(stall_stall7_we),
		.wd(stall_stall7_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[172:172]),
		.qs(stall_stall7_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RW"),
		.RESVAL(1'h0)
	) u_stall_stall8(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(stall_stall8_we),
		.wd(stall_stall8_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[171:171]),
		.qs(stall_stall8_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RW"),
		.RESVAL(1'h0)
	) u_stall_stall9(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(stall_stall9_we),
		.wd(stall_stall9_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[170:170]),
		.qs(stall_stall9_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RW"),
		.RESVAL(1'h0)
	) u_stall_stall10(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(stall_stall10_we),
		.wd(stall_stall10_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[169:169]),
		.qs(stall_stall10_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RW"),
		.RESVAL(1'h0)
	) u_stall_stall11(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(stall_stall11_we),
		.wd(stall_stall11_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[168:168]),
		.qs(stall_stall11_qs)
	);
	prim_subreg #(
		.DW(5),
		.SWACCESS("RW"),
		.RESVAL(5'h0)
	) u_configin0_buffer0(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(configin0_buffer0_we),
		.wd(configin0_buffer0_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[167:163]),
		.qs(configin0_buffer0_qs)
	);
	prim_subreg #(
		.DW(7),
		.SWACCESS("RW"),
		.RESVAL(7'h0)
	) u_configin0_size0(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(configin0_size0_we),
		.wd(configin0_size0_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[162:156]),
		.qs(configin0_size0_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("W1C"),
		.RESVAL(1'h0)
	) u_configin0_pend0(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(configin0_pend0_we),
		.wd(configin0_pend0_wd),
		.de(hw2reg[46:46]),
		.d(hw2reg[47:47]),
		.qe(),
		.q(reg2hw[155:155]),
		.qs(configin0_pend0_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RW"),
		.RESVAL(1'h0)
	) u_configin0_rdy0(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(configin0_rdy0_we),
		.wd(configin0_rdy0_wd),
		.de(hw2reg[44:44]),
		.d(hw2reg[45:45]),
		.qe(),
		.q(reg2hw[154:154]),
		.qs(configin0_rdy0_qs)
	);
	prim_subreg #(
		.DW(5),
		.SWACCESS("RW"),
		.RESVAL(5'h0)
	) u_configin1_buffer1(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(configin1_buffer1_we),
		.wd(configin1_buffer1_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[153:149]),
		.qs(configin1_buffer1_qs)
	);
	prim_subreg #(
		.DW(7),
		.SWACCESS("RW"),
		.RESVAL(7'h0)
	) u_configin1_size1(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(configin1_size1_we),
		.wd(configin1_size1_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[148:142]),
		.qs(configin1_size1_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("W1C"),
		.RESVAL(1'h0)
	) u_configin1_pend1(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(configin1_pend1_we),
		.wd(configin1_pend1_wd),
		.de(hw2reg[42:42]),
		.d(hw2reg[43:43]),
		.qe(),
		.q(reg2hw[141:141]),
		.qs(configin1_pend1_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RW"),
		.RESVAL(1'h0)
	) u_configin1_rdy1(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(configin1_rdy1_we),
		.wd(configin1_rdy1_wd),
		.de(hw2reg[40:40]),
		.d(hw2reg[41:41]),
		.qe(),
		.q(reg2hw[140:140]),
		.qs(configin1_rdy1_qs)
	);
	prim_subreg #(
		.DW(5),
		.SWACCESS("RW"),
		.RESVAL(5'h0)
	) u_configin2_buffer2(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(configin2_buffer2_we),
		.wd(configin2_buffer2_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[139:135]),
		.qs(configin2_buffer2_qs)
	);
	prim_subreg #(
		.DW(7),
		.SWACCESS("RW"),
		.RESVAL(7'h0)
	) u_configin2_size2(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(configin2_size2_we),
		.wd(configin2_size2_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[134:128]),
		.qs(configin2_size2_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("W1C"),
		.RESVAL(1'h0)
	) u_configin2_pend2(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(configin2_pend2_we),
		.wd(configin2_pend2_wd),
		.de(hw2reg[38:38]),
		.d(hw2reg[39:39]),
		.qe(),
		.q(reg2hw[127:127]),
		.qs(configin2_pend2_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RW"),
		.RESVAL(1'h0)
	) u_configin2_rdy2(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(configin2_rdy2_we),
		.wd(configin2_rdy2_wd),
		.de(hw2reg[36:36]),
		.d(hw2reg[37:37]),
		.qe(),
		.q(reg2hw[126:126]),
		.qs(configin2_rdy2_qs)
	);
	prim_subreg #(
		.DW(5),
		.SWACCESS("RW"),
		.RESVAL(5'h0)
	) u_configin3_buffer3(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(configin3_buffer3_we),
		.wd(configin3_buffer3_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[125:121]),
		.qs(configin3_buffer3_qs)
	);
	prim_subreg #(
		.DW(7),
		.SWACCESS("RW"),
		.RESVAL(7'h0)
	) u_configin3_size3(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(configin3_size3_we),
		.wd(configin3_size3_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[120:114]),
		.qs(configin3_size3_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("W1C"),
		.RESVAL(1'h0)
	) u_configin3_pend3(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(configin3_pend3_we),
		.wd(configin3_pend3_wd),
		.de(hw2reg[34:34]),
		.d(hw2reg[35:35]),
		.qe(),
		.q(reg2hw[113:113]),
		.qs(configin3_pend3_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RW"),
		.RESVAL(1'h0)
	) u_configin3_rdy3(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(configin3_rdy3_we),
		.wd(configin3_rdy3_wd),
		.de(hw2reg[32:32]),
		.d(hw2reg[33:33]),
		.qe(),
		.q(reg2hw[112:112]),
		.qs(configin3_rdy3_qs)
	);
	prim_subreg #(
		.DW(5),
		.SWACCESS("RW"),
		.RESVAL(5'h0)
	) u_configin4_buffer4(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(configin4_buffer4_we),
		.wd(configin4_buffer4_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[111:107]),
		.qs(configin4_buffer4_qs)
	);
	prim_subreg #(
		.DW(7),
		.SWACCESS("RW"),
		.RESVAL(7'h0)
	) u_configin4_size4(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(configin4_size4_we),
		.wd(configin4_size4_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[106:100]),
		.qs(configin4_size4_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("W1C"),
		.RESVAL(1'h0)
	) u_configin4_pend4(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(configin4_pend4_we),
		.wd(configin4_pend4_wd),
		.de(hw2reg[30:30]),
		.d(hw2reg[31:31]),
		.qe(),
		.q(reg2hw[99:99]),
		.qs(configin4_pend4_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RW"),
		.RESVAL(1'h0)
	) u_configin4_rdy4(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(configin4_rdy4_we),
		.wd(configin4_rdy4_wd),
		.de(hw2reg[28:28]),
		.d(hw2reg[29:29]),
		.qe(),
		.q(reg2hw[98:98]),
		.qs(configin4_rdy4_qs)
	);
	prim_subreg #(
		.DW(5),
		.SWACCESS("RW"),
		.RESVAL(5'h0)
	) u_configin5_buffer5(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(configin5_buffer5_we),
		.wd(configin5_buffer5_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[97:93]),
		.qs(configin5_buffer5_qs)
	);
	prim_subreg #(
		.DW(7),
		.SWACCESS("RW"),
		.RESVAL(7'h0)
	) u_configin5_size5(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(configin5_size5_we),
		.wd(configin5_size5_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[92:86]),
		.qs(configin5_size5_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("W1C"),
		.RESVAL(1'h0)
	) u_configin5_pend5(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(configin5_pend5_we),
		.wd(configin5_pend5_wd),
		.de(hw2reg[26:26]),
		.d(hw2reg[27:27]),
		.qe(),
		.q(reg2hw[85:85]),
		.qs(configin5_pend5_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RW"),
		.RESVAL(1'h0)
	) u_configin5_rdy5(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(configin5_rdy5_we),
		.wd(configin5_rdy5_wd),
		.de(hw2reg[24:24]),
		.d(hw2reg[25:25]),
		.qe(),
		.q(reg2hw[84:84]),
		.qs(configin5_rdy5_qs)
	);
	prim_subreg #(
		.DW(5),
		.SWACCESS("RW"),
		.RESVAL(5'h0)
	) u_configin6_buffer6(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(configin6_buffer6_we),
		.wd(configin6_buffer6_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[83:79]),
		.qs(configin6_buffer6_qs)
	);
	prim_subreg #(
		.DW(7),
		.SWACCESS("RW"),
		.RESVAL(7'h0)
	) u_configin6_size6(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(configin6_size6_we),
		.wd(configin6_size6_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[78:72]),
		.qs(configin6_size6_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("W1C"),
		.RESVAL(1'h0)
	) u_configin6_pend6(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(configin6_pend6_we),
		.wd(configin6_pend6_wd),
		.de(hw2reg[22:22]),
		.d(hw2reg[23:23]),
		.qe(),
		.q(reg2hw[71:71]),
		.qs(configin6_pend6_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RW"),
		.RESVAL(1'h0)
	) u_configin6_rdy6(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(configin6_rdy6_we),
		.wd(configin6_rdy6_wd),
		.de(hw2reg[20:20]),
		.d(hw2reg[21:21]),
		.qe(),
		.q(reg2hw[70:70]),
		.qs(configin6_rdy6_qs)
	);
	prim_subreg #(
		.DW(5),
		.SWACCESS("RW"),
		.RESVAL(5'h0)
	) u_configin7_buffer7(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(configin7_buffer7_we),
		.wd(configin7_buffer7_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[69:65]),
		.qs(configin7_buffer7_qs)
	);
	prim_subreg #(
		.DW(7),
		.SWACCESS("RW"),
		.RESVAL(7'h0)
	) u_configin7_size7(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(configin7_size7_we),
		.wd(configin7_size7_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[64:58]),
		.qs(configin7_size7_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("W1C"),
		.RESVAL(1'h0)
	) u_configin7_pend7(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(configin7_pend7_we),
		.wd(configin7_pend7_wd),
		.de(hw2reg[18:18]),
		.d(hw2reg[19:19]),
		.qe(),
		.q(reg2hw[57:57]),
		.qs(configin7_pend7_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RW"),
		.RESVAL(1'h0)
	) u_configin7_rdy7(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(configin7_rdy7_we),
		.wd(configin7_rdy7_wd),
		.de(hw2reg[16:16]),
		.d(hw2reg[17:17]),
		.qe(),
		.q(reg2hw[56:56]),
		.qs(configin7_rdy7_qs)
	);
	prim_subreg #(
		.DW(5),
		.SWACCESS("RW"),
		.RESVAL(5'h0)
	) u_configin8_buffer8(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(configin8_buffer8_we),
		.wd(configin8_buffer8_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[55:51]),
		.qs(configin8_buffer8_qs)
	);
	prim_subreg #(
		.DW(7),
		.SWACCESS("RW"),
		.RESVAL(7'h0)
	) u_configin8_size8(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(configin8_size8_we),
		.wd(configin8_size8_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[50:44]),
		.qs(configin8_size8_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("W1C"),
		.RESVAL(1'h0)
	) u_configin8_pend8(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(configin8_pend8_we),
		.wd(configin8_pend8_wd),
		.de(hw2reg[14:14]),
		.d(hw2reg[15:15]),
		.qe(),
		.q(reg2hw[43:43]),
		.qs(configin8_pend8_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RW"),
		.RESVAL(1'h0)
	) u_configin8_rdy8(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(configin8_rdy8_we),
		.wd(configin8_rdy8_wd),
		.de(hw2reg[12:12]),
		.d(hw2reg[13:13]),
		.qe(),
		.q(reg2hw[42:42]),
		.qs(configin8_rdy8_qs)
	);
	prim_subreg #(
		.DW(5),
		.SWACCESS("RW"),
		.RESVAL(5'h0)
	) u_configin9_buffer9(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(configin9_buffer9_we),
		.wd(configin9_buffer9_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[41:37]),
		.qs(configin9_buffer9_qs)
	);
	prim_subreg #(
		.DW(7),
		.SWACCESS("RW"),
		.RESVAL(7'h0)
	) u_configin9_size9(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(configin9_size9_we),
		.wd(configin9_size9_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[36:30]),
		.qs(configin9_size9_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("W1C"),
		.RESVAL(1'h0)
	) u_configin9_pend9(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(configin9_pend9_we),
		.wd(configin9_pend9_wd),
		.de(hw2reg[10:10]),
		.d(hw2reg[11:11]),
		.qe(),
		.q(reg2hw[29:29]),
		.qs(configin9_pend9_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RW"),
		.RESVAL(1'h0)
	) u_configin9_rdy9(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(configin9_rdy9_we),
		.wd(configin9_rdy9_wd),
		.de(hw2reg[8:8]),
		.d(hw2reg[9:9]),
		.qe(),
		.q(reg2hw[28:28]),
		.qs(configin9_rdy9_qs)
	);
	prim_subreg #(
		.DW(5),
		.SWACCESS("RW"),
		.RESVAL(5'h0)
	) u_configin10_buffer10(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(configin10_buffer10_we),
		.wd(configin10_buffer10_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[27:23]),
		.qs(configin10_buffer10_qs)
	);
	prim_subreg #(
		.DW(7),
		.SWACCESS("RW"),
		.RESVAL(7'h0)
	) u_configin10_size10(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(configin10_size10_we),
		.wd(configin10_size10_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[22:16]),
		.qs(configin10_size10_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("W1C"),
		.RESVAL(1'h0)
	) u_configin10_pend10(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(configin10_pend10_we),
		.wd(configin10_pend10_wd),
		.de(hw2reg[6:6]),
		.d(hw2reg[7:7]),
		.qe(),
		.q(reg2hw[15:15]),
		.qs(configin10_pend10_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RW"),
		.RESVAL(1'h0)
	) u_configin10_rdy10(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(configin10_rdy10_we),
		.wd(configin10_rdy10_wd),
		.de(hw2reg[4:4]),
		.d(hw2reg[5:5]),
		.qe(),
		.q(reg2hw[14:14]),
		.qs(configin10_rdy10_qs)
	);
	prim_subreg #(
		.DW(5),
		.SWACCESS("RW"),
		.RESVAL(5'h0)
	) u_configin11_buffer11(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(configin11_buffer11_we),
		.wd(configin11_buffer11_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[13:9]),
		.qs(configin11_buffer11_qs)
	);
	prim_subreg #(
		.DW(7),
		.SWACCESS("RW"),
		.RESVAL(7'h0)
	) u_configin11_size11(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(configin11_size11_we),
		.wd(configin11_size11_wd),
		.de(1'b0),
		.d(1'sb0),
		.qe(),
		.q(reg2hw[8:2]),
		.qs(configin11_size11_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("W1C"),
		.RESVAL(1'h0)
	) u_configin11_pend11(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(configin11_pend11_we),
		.wd(configin11_pend11_wd),
		.de(hw2reg[2:2]),
		.d(hw2reg[3:3]),
		.qe(),
		.q(reg2hw[1:1]),
		.qs(configin11_pend11_qs)
	);
	prim_subreg #(
		.DW(1),
		.SWACCESS("RW"),
		.RESVAL(1'h0)
	) u_configin11_rdy11(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.we(configin11_rdy11_we),
		.wd(configin11_rdy11_wd),
		.de(hw2reg[0:0]),
		.d(hw2reg[1:1]),
		.qe(),
		.q(reg2hw[0:0]),
		.qs(configin11_rdy11_qs)
	);
	reg [21:0] addr_hit;
	always @(*) begin
		addr_hit = 1'sb0;
		addr_hit[0] = (reg_addr == USBDEV_INTR_STATE_OFFSET);
		addr_hit[1] = (reg_addr == USBDEV_INTR_ENABLE_OFFSET);
		addr_hit[2] = (reg_addr == USBDEV_INTR_TEST_OFFSET);
		addr_hit[3] = (reg_addr == USBDEV_USBCTRL_OFFSET);
		addr_hit[4] = (reg_addr == USBDEV_USBSTAT_OFFSET);
		addr_hit[5] = (reg_addr == USBDEV_AVBUFFER_OFFSET);
		addr_hit[6] = (reg_addr == USBDEV_RXFIFO_OFFSET);
		addr_hit[7] = (reg_addr == USBDEV_RXENABLE_OFFSET);
		addr_hit[8] = (reg_addr == USBDEV_IN_SENT_OFFSET);
		addr_hit[9] = (reg_addr == USBDEV_STALL_OFFSET);
		addr_hit[10] = (reg_addr == USBDEV_CONFIGIN0_OFFSET);
		addr_hit[11] = (reg_addr == USBDEV_CONFIGIN1_OFFSET);
		addr_hit[12] = (reg_addr == USBDEV_CONFIGIN2_OFFSET);
		addr_hit[13] = (reg_addr == USBDEV_CONFIGIN3_OFFSET);
		addr_hit[14] = (reg_addr == USBDEV_CONFIGIN4_OFFSET);
		addr_hit[15] = (reg_addr == USBDEV_CONFIGIN5_OFFSET);
		addr_hit[16] = (reg_addr == USBDEV_CONFIGIN6_OFFSET);
		addr_hit[17] = (reg_addr == USBDEV_CONFIGIN7_OFFSET);
		addr_hit[18] = (reg_addr == USBDEV_CONFIGIN8_OFFSET);
		addr_hit[19] = (reg_addr == USBDEV_CONFIGIN9_OFFSET);
		addr_hit[20] = (reg_addr == USBDEV_CONFIGIN10_OFFSET);
		addr_hit[21] = (reg_addr == USBDEV_CONFIGIN11_OFFSET);
	end
	always @(posedge clk_i or negedge rst_ni)
		if (!rst_ni)
			tl_addrmiss <= 1'b0;
		else if ((reg_re || reg_we))
			tl_addrmiss <= ~|addr_hit;
	assign intr_state_pkt_received_we = (addr_hit[0] && reg_we);
	assign intr_state_pkt_received_wd = reg_wdata[0];
	assign intr_state_pkt_sent_we = (addr_hit[0] && reg_we);
	assign intr_state_pkt_sent_wd = reg_wdata[1];
	assign intr_state_disconnected_we = (addr_hit[0] && reg_we);
	assign intr_state_disconnected_wd = reg_wdata[2];
	assign intr_state_host_lost_we = (addr_hit[0] && reg_we);
	assign intr_state_host_lost_wd = reg_wdata[3];
	assign intr_state_link_reset_we = (addr_hit[0] && reg_we);
	assign intr_state_link_reset_wd = reg_wdata[4];
	assign intr_state_link_suspend_we = (addr_hit[0] && reg_we);
	assign intr_state_link_suspend_wd = reg_wdata[5];
	assign intr_state_link_resume_we = (addr_hit[0] && reg_we);
	assign intr_state_link_resume_wd = reg_wdata[6];
	assign intr_state_av_empty_we = (addr_hit[0] && reg_we);
	assign intr_state_av_empty_wd = reg_wdata[7];
	assign intr_state_rx_full_we = (addr_hit[0] && reg_we);
	assign intr_state_rx_full_wd = reg_wdata[8];
	assign intr_state_av_overflow_we = (addr_hit[0] && reg_we);
	assign intr_state_av_overflow_wd = reg_wdata[9];
	assign intr_enable_pkt_received_we = (addr_hit[1] && reg_we);
	assign intr_enable_pkt_received_wd = reg_wdata[0];
	assign intr_enable_pkt_sent_we = (addr_hit[1] && reg_we);
	assign intr_enable_pkt_sent_wd = reg_wdata[1];
	assign intr_enable_disconnected_we = (addr_hit[1] && reg_we);
	assign intr_enable_disconnected_wd = reg_wdata[2];
	assign intr_enable_host_lost_we = (addr_hit[1] && reg_we);
	assign intr_enable_host_lost_wd = reg_wdata[3];
	assign intr_enable_link_reset_we = (addr_hit[1] && reg_we);
	assign intr_enable_link_reset_wd = reg_wdata[4];
	assign intr_enable_link_suspend_we = (addr_hit[1] && reg_we);
	assign intr_enable_link_suspend_wd = reg_wdata[5];
	assign intr_enable_link_resume_we = (addr_hit[1] && reg_we);
	assign intr_enable_link_resume_wd = reg_wdata[6];
	assign intr_enable_av_empty_we = (addr_hit[1] && reg_we);
	assign intr_enable_av_empty_wd = reg_wdata[7];
	assign intr_enable_rx_full_we = (addr_hit[1] && reg_we);
	assign intr_enable_rx_full_wd = reg_wdata[8];
	assign intr_enable_av_overflow_we = (addr_hit[1] && reg_we);
	assign intr_enable_av_overflow_wd = reg_wdata[9];
	assign intr_test_pkt_received_we = (addr_hit[2] && reg_we);
	assign intr_test_pkt_received_wd = reg_wdata[0];
	assign intr_test_pkt_sent_we = (addr_hit[2] && reg_we);
	assign intr_test_pkt_sent_wd = reg_wdata[1];
	assign intr_test_disconnected_we = (addr_hit[2] && reg_we);
	assign intr_test_disconnected_wd = reg_wdata[2];
	assign intr_test_host_lost_we = (addr_hit[2] && reg_we);
	assign intr_test_host_lost_wd = reg_wdata[3];
	assign intr_test_link_reset_we = (addr_hit[2] && reg_we);
	assign intr_test_link_reset_wd = reg_wdata[4];
	assign intr_test_link_suspend_we = (addr_hit[2] && reg_we);
	assign intr_test_link_suspend_wd = reg_wdata[5];
	assign intr_test_link_resume_we = (addr_hit[2] && reg_we);
	assign intr_test_link_resume_wd = reg_wdata[6];
	assign intr_test_av_empty_we = (addr_hit[2] && reg_we);
	assign intr_test_av_empty_wd = reg_wdata[7];
	assign intr_test_rx_full_we = (addr_hit[2] && reg_we);
	assign intr_test_rx_full_wd = reg_wdata[8];
	assign intr_test_av_overflow_we = (addr_hit[2] && reg_we);
	assign intr_test_av_overflow_wd = reg_wdata[9];
	assign usbctrl_enable_we = (addr_hit[3] && reg_we);
	assign usbctrl_enable_wd = reg_wdata[0];
	assign usbctrl_device_address_we = (addr_hit[3] && reg_we);
	assign usbctrl_device_address_wd = reg_wdata[22:16];
	assign usbstat_frame_re = (addr_hit[4] && reg_re);
	assign usbstat_host_lost_re = (addr_hit[4] && reg_re);
	assign usbstat_link_state_re = (addr_hit[4] && reg_re);
	assign usbstat_usb_sense_re = (addr_hit[4] && reg_re);
	assign usbstat_av_depth_re = (addr_hit[4] && reg_re);
	assign usbstat_av_full_re = (addr_hit[4] && reg_re);
	assign usbstat_rx_depth_re = (addr_hit[4] && reg_re);
	assign usbstat_rx_empty_re = (addr_hit[4] && reg_re);
	assign avbuffer_we = (addr_hit[5] && reg_we);
	assign avbuffer_wd = reg_wdata[4:0];
	assign rxfifo_buffer_re = (addr_hit[6] && reg_re);
	assign rxfifo_size_re = (addr_hit[6] && reg_re);
	assign rxfifo_setup_re = (addr_hit[6] && reg_re);
	assign rxfifo_ep_re = (addr_hit[6] && reg_re);
	assign rxenable_setup0_we = (addr_hit[7] && reg_we);
	assign rxenable_setup0_wd = reg_wdata[0];
	assign rxenable_setup1_we = (addr_hit[7] && reg_we);
	assign rxenable_setup1_wd = reg_wdata[1];
	assign rxenable_setup2_we = (addr_hit[7] && reg_we);
	assign rxenable_setup2_wd = reg_wdata[2];
	assign rxenable_setup3_we = (addr_hit[7] && reg_we);
	assign rxenable_setup3_wd = reg_wdata[3];
	assign rxenable_setup4_we = (addr_hit[7] && reg_we);
	assign rxenable_setup4_wd = reg_wdata[4];
	assign rxenable_setup5_we = (addr_hit[7] && reg_we);
	assign rxenable_setup5_wd = reg_wdata[5];
	assign rxenable_setup6_we = (addr_hit[7] && reg_we);
	assign rxenable_setup6_wd = reg_wdata[6];
	assign rxenable_setup7_we = (addr_hit[7] && reg_we);
	assign rxenable_setup7_wd = reg_wdata[7];
	assign rxenable_setup8_we = (addr_hit[7] && reg_we);
	assign rxenable_setup8_wd = reg_wdata[8];
	assign rxenable_setup9_we = (addr_hit[7] && reg_we);
	assign rxenable_setup9_wd = reg_wdata[9];
	assign rxenable_setup10_we = (addr_hit[7] && reg_we);
	assign rxenable_setup10_wd = reg_wdata[10];
	assign rxenable_setup11_we = (addr_hit[7] && reg_we);
	assign rxenable_setup11_wd = reg_wdata[11];
	assign rxenable_out0_we = (addr_hit[7] && reg_we);
	assign rxenable_out0_wd = reg_wdata[16];
	assign rxenable_out1_we = (addr_hit[7] && reg_we);
	assign rxenable_out1_wd = reg_wdata[17];
	assign rxenable_out2_we = (addr_hit[7] && reg_we);
	assign rxenable_out2_wd = reg_wdata[18];
	assign rxenable_out3_we = (addr_hit[7] && reg_we);
	assign rxenable_out3_wd = reg_wdata[19];
	assign rxenable_out4_we = (addr_hit[7] && reg_we);
	assign rxenable_out4_wd = reg_wdata[20];
	assign rxenable_out5_we = (addr_hit[7] && reg_we);
	assign rxenable_out5_wd = reg_wdata[21];
	assign rxenable_out6_we = (addr_hit[7] && reg_we);
	assign rxenable_out6_wd = reg_wdata[22];
	assign rxenable_out7_we = (addr_hit[7] && reg_we);
	assign rxenable_out7_wd = reg_wdata[23];
	assign rxenable_out8_we = (addr_hit[7] && reg_we);
	assign rxenable_out8_wd = reg_wdata[24];
	assign rxenable_out9_we = (addr_hit[7] && reg_we);
	assign rxenable_out9_wd = reg_wdata[25];
	assign rxenable_out10_we = (addr_hit[7] && reg_we);
	assign rxenable_out10_wd = reg_wdata[26];
	assign rxenable_out11_we = (addr_hit[7] && reg_we);
	assign rxenable_out11_wd = reg_wdata[27];
	assign in_sent_sent0_we = (addr_hit[8] && reg_we);
	assign in_sent_sent0_wd = reg_wdata[0];
	assign in_sent_sent1_we = (addr_hit[8] && reg_we);
	assign in_sent_sent1_wd = reg_wdata[1];
	assign in_sent_sent2_we = (addr_hit[8] && reg_we);
	assign in_sent_sent2_wd = reg_wdata[2];
	assign in_sent_sent3_we = (addr_hit[8] && reg_we);
	assign in_sent_sent3_wd = reg_wdata[3];
	assign in_sent_sent4_we = (addr_hit[8] && reg_we);
	assign in_sent_sent4_wd = reg_wdata[4];
	assign in_sent_sent5_we = (addr_hit[8] && reg_we);
	assign in_sent_sent5_wd = reg_wdata[5];
	assign in_sent_sent6_we = (addr_hit[8] && reg_we);
	assign in_sent_sent6_wd = reg_wdata[6];
	assign in_sent_sent7_we = (addr_hit[8] && reg_we);
	assign in_sent_sent7_wd = reg_wdata[7];
	assign in_sent_sent8_we = (addr_hit[8] && reg_we);
	assign in_sent_sent8_wd = reg_wdata[8];
	assign in_sent_sent9_we = (addr_hit[8] && reg_we);
	assign in_sent_sent9_wd = reg_wdata[9];
	assign in_sent_sent10_we = (addr_hit[8] && reg_we);
	assign in_sent_sent10_wd = reg_wdata[10];
	assign in_sent_sent11_we = (addr_hit[8] && reg_we);
	assign in_sent_sent11_wd = reg_wdata[11];
	assign stall_stall0_we = (addr_hit[9] && reg_we);
	assign stall_stall0_wd = reg_wdata[0];
	assign stall_stall1_we = (addr_hit[9] && reg_we);
	assign stall_stall1_wd = reg_wdata[1];
	assign stall_stall2_we = (addr_hit[9] && reg_we);
	assign stall_stall2_wd = reg_wdata[2];
	assign stall_stall3_we = (addr_hit[9] && reg_we);
	assign stall_stall3_wd = reg_wdata[3];
	assign stall_stall4_we = (addr_hit[9] && reg_we);
	assign stall_stall4_wd = reg_wdata[4];
	assign stall_stall5_we = (addr_hit[9] && reg_we);
	assign stall_stall5_wd = reg_wdata[5];
	assign stall_stall6_we = (addr_hit[9] && reg_we);
	assign stall_stall6_wd = reg_wdata[6];
	assign stall_stall7_we = (addr_hit[9] && reg_we);
	assign stall_stall7_wd = reg_wdata[7];
	assign stall_stall8_we = (addr_hit[9] && reg_we);
	assign stall_stall8_wd = reg_wdata[8];
	assign stall_stall9_we = (addr_hit[9] && reg_we);
	assign stall_stall9_wd = reg_wdata[9];
	assign stall_stall10_we = (addr_hit[9] && reg_we);
	assign stall_stall10_wd = reg_wdata[10];
	assign stall_stall11_we = (addr_hit[9] && reg_we);
	assign stall_stall11_wd = reg_wdata[11];
	assign configin0_buffer0_we = (addr_hit[10] && reg_we);
	assign configin0_buffer0_wd = reg_wdata[4:0];
	assign configin0_size0_we = (addr_hit[10] && reg_we);
	assign configin0_size0_wd = reg_wdata[14:8];
	assign configin0_pend0_we = (addr_hit[10] && reg_we);
	assign configin0_pend0_wd = reg_wdata[30];
	assign configin0_rdy0_we = (addr_hit[10] && reg_we);
	assign configin0_rdy0_wd = reg_wdata[31];
	assign configin1_buffer1_we = (addr_hit[11] && reg_we);
	assign configin1_buffer1_wd = reg_wdata[4:0];
	assign configin1_size1_we = (addr_hit[11] && reg_we);
	assign configin1_size1_wd = reg_wdata[14:8];
	assign configin1_pend1_we = (addr_hit[11] && reg_we);
	assign configin1_pend1_wd = reg_wdata[30];
	assign configin1_rdy1_we = (addr_hit[11] && reg_we);
	assign configin1_rdy1_wd = reg_wdata[31];
	assign configin2_buffer2_we = (addr_hit[12] && reg_we);
	assign configin2_buffer2_wd = reg_wdata[4:0];
	assign configin2_size2_we = (addr_hit[12] && reg_we);
	assign configin2_size2_wd = reg_wdata[14:8];
	assign configin2_pend2_we = (addr_hit[12] && reg_we);
	assign configin2_pend2_wd = reg_wdata[30];
	assign configin2_rdy2_we = (addr_hit[12] && reg_we);
	assign configin2_rdy2_wd = reg_wdata[31];
	assign configin3_buffer3_we = (addr_hit[13] && reg_we);
	assign configin3_buffer3_wd = reg_wdata[4:0];
	assign configin3_size3_we = (addr_hit[13] && reg_we);
	assign configin3_size3_wd = reg_wdata[14:8];
	assign configin3_pend3_we = (addr_hit[13] && reg_we);
	assign configin3_pend3_wd = reg_wdata[30];
	assign configin3_rdy3_we = (addr_hit[13] && reg_we);
	assign configin3_rdy3_wd = reg_wdata[31];
	assign configin4_buffer4_we = (addr_hit[14] && reg_we);
	assign configin4_buffer4_wd = reg_wdata[4:0];
	assign configin4_size4_we = (addr_hit[14] && reg_we);
	assign configin4_size4_wd = reg_wdata[14:8];
	assign configin4_pend4_we = (addr_hit[14] && reg_we);
	assign configin4_pend4_wd = reg_wdata[30];
	assign configin4_rdy4_we = (addr_hit[14] && reg_we);
	assign configin4_rdy4_wd = reg_wdata[31];
	assign configin5_buffer5_we = (addr_hit[15] && reg_we);
	assign configin5_buffer5_wd = reg_wdata[4:0];
	assign configin5_size5_we = (addr_hit[15] && reg_we);
	assign configin5_size5_wd = reg_wdata[14:8];
	assign configin5_pend5_we = (addr_hit[15] && reg_we);
	assign configin5_pend5_wd = reg_wdata[30];
	assign configin5_rdy5_we = (addr_hit[15] && reg_we);
	assign configin5_rdy5_wd = reg_wdata[31];
	assign configin6_buffer6_we = (addr_hit[16] && reg_we);
	assign configin6_buffer6_wd = reg_wdata[4:0];
	assign configin6_size6_we = (addr_hit[16] && reg_we);
	assign configin6_size6_wd = reg_wdata[14:8];
	assign configin6_pend6_we = (addr_hit[16] && reg_we);
	assign configin6_pend6_wd = reg_wdata[30];
	assign configin6_rdy6_we = (addr_hit[16] && reg_we);
	assign configin6_rdy6_wd = reg_wdata[31];
	assign configin7_buffer7_we = (addr_hit[17] && reg_we);
	assign configin7_buffer7_wd = reg_wdata[4:0];
	assign configin7_size7_we = (addr_hit[17] && reg_we);
	assign configin7_size7_wd = reg_wdata[14:8];
	assign configin7_pend7_we = (addr_hit[17] && reg_we);
	assign configin7_pend7_wd = reg_wdata[30];
	assign configin7_rdy7_we = (addr_hit[17] && reg_we);
	assign configin7_rdy7_wd = reg_wdata[31];
	assign configin8_buffer8_we = (addr_hit[18] && reg_we);
	assign configin8_buffer8_wd = reg_wdata[4:0];
	assign configin8_size8_we = (addr_hit[18] && reg_we);
	assign configin8_size8_wd = reg_wdata[14:8];
	assign configin8_pend8_we = (addr_hit[18] && reg_we);
	assign configin8_pend8_wd = reg_wdata[30];
	assign configin8_rdy8_we = (addr_hit[18] && reg_we);
	assign configin8_rdy8_wd = reg_wdata[31];
	assign configin9_buffer9_we = (addr_hit[19] && reg_we);
	assign configin9_buffer9_wd = reg_wdata[4:0];
	assign configin9_size9_we = (addr_hit[19] && reg_we);
	assign configin9_size9_wd = reg_wdata[14:8];
	assign configin9_pend9_we = (addr_hit[19] && reg_we);
	assign configin9_pend9_wd = reg_wdata[30];
	assign configin9_rdy9_we = (addr_hit[19] && reg_we);
	assign configin9_rdy9_wd = reg_wdata[31];
	assign configin10_buffer10_we = (addr_hit[20] && reg_we);
	assign configin10_buffer10_wd = reg_wdata[4:0];
	assign configin10_size10_we = (addr_hit[20] && reg_we);
	assign configin10_size10_wd = reg_wdata[14:8];
	assign configin10_pend10_we = (addr_hit[20] && reg_we);
	assign configin10_pend10_wd = reg_wdata[30];
	assign configin10_rdy10_we = (addr_hit[20] && reg_we);
	assign configin10_rdy10_wd = reg_wdata[31];
	assign configin11_buffer11_we = (addr_hit[21] && reg_we);
	assign configin11_buffer11_wd = reg_wdata[4:0];
	assign configin11_size11_we = (addr_hit[21] && reg_we);
	assign configin11_size11_wd = reg_wdata[14:8];
	assign configin11_pend11_we = (addr_hit[21] && reg_we);
	assign configin11_pend11_wd = reg_wdata[30];
	assign configin11_rdy11_we = (addr_hit[21] && reg_we);
	assign configin11_rdy11_wd = reg_wdata[31];
	reg [(DW - 1):0] reg_rdata_next;
	always @(*) begin
		reg_rdata_next = 1'sb0;
		case (1'b1)
			addr_hit[0]: begin
				reg_rdata_next[0] = intr_state_pkt_received_qs;
				reg_rdata_next[1] = intr_state_pkt_sent_qs;
				reg_rdata_next[2] = intr_state_disconnected_qs;
				reg_rdata_next[3] = intr_state_host_lost_qs;
				reg_rdata_next[4] = intr_state_link_reset_qs;
				reg_rdata_next[5] = intr_state_link_suspend_qs;
				reg_rdata_next[6] = intr_state_link_resume_qs;
				reg_rdata_next[7] = intr_state_av_empty_qs;
				reg_rdata_next[8] = intr_state_rx_full_qs;
				reg_rdata_next[9] = intr_state_av_overflow_qs;
			end
			addr_hit[1]: begin
				reg_rdata_next[0] = intr_enable_pkt_received_qs;
				reg_rdata_next[1] = intr_enable_pkt_sent_qs;
				reg_rdata_next[2] = intr_enable_disconnected_qs;
				reg_rdata_next[3] = intr_enable_host_lost_qs;
				reg_rdata_next[4] = intr_enable_link_reset_qs;
				reg_rdata_next[5] = intr_enable_link_suspend_qs;
				reg_rdata_next[6] = intr_enable_link_resume_qs;
				reg_rdata_next[7] = intr_enable_av_empty_qs;
				reg_rdata_next[8] = intr_enable_rx_full_qs;
				reg_rdata_next[9] = intr_enable_av_overflow_qs;
			end
			addr_hit[2]: begin
				reg_rdata_next[0] = 1'sb0;
				reg_rdata_next[1] = 1'sb0;
				reg_rdata_next[2] = 1'sb0;
				reg_rdata_next[3] = 1'sb0;
				reg_rdata_next[4] = 1'sb0;
				reg_rdata_next[5] = 1'sb0;
				reg_rdata_next[6] = 1'sb0;
				reg_rdata_next[7] = 1'sb0;
				reg_rdata_next[8] = 1'sb0;
				reg_rdata_next[9] = 1'sb0;
			end
			addr_hit[3]: begin
				reg_rdata_next[0] = usbctrl_enable_qs;
				reg_rdata_next[22:16] = usbctrl_device_address_qs;
			end
			addr_hit[4]: begin
				reg_rdata_next[10:0] = usbstat_frame_qs;
				reg_rdata_next[11] = usbstat_host_lost_qs;
				reg_rdata_next[13:12] = usbstat_link_state_qs;
				reg_rdata_next[14] = usbstat_usb_sense_qs;
				reg_rdata_next[18:16] = usbstat_av_depth_qs;
				reg_rdata_next[23] = usbstat_av_full_qs;
				reg_rdata_next[26:24] = usbstat_rx_depth_qs;
				reg_rdata_next[31] = usbstat_rx_empty_qs;
			end
			addr_hit[5]: reg_rdata_next[4:0] = 1'sb0;
			addr_hit[6]: begin
				reg_rdata_next[4:0] = rxfifo_buffer_qs;
				reg_rdata_next[14:8] = rxfifo_size_qs;
				reg_rdata_next[19] = rxfifo_setup_qs;
				reg_rdata_next[23:20] = rxfifo_ep_qs;
			end
			addr_hit[7]: begin
				reg_rdata_next[0] = rxenable_setup0_qs;
				reg_rdata_next[1] = rxenable_setup1_qs;
				reg_rdata_next[2] = rxenable_setup2_qs;
				reg_rdata_next[3] = rxenable_setup3_qs;
				reg_rdata_next[4] = rxenable_setup4_qs;
				reg_rdata_next[5] = rxenable_setup5_qs;
				reg_rdata_next[6] = rxenable_setup6_qs;
				reg_rdata_next[7] = rxenable_setup7_qs;
				reg_rdata_next[8] = rxenable_setup8_qs;
				reg_rdata_next[9] = rxenable_setup9_qs;
				reg_rdata_next[10] = rxenable_setup10_qs;
				reg_rdata_next[11] = rxenable_setup11_qs;
				reg_rdata_next[16] = rxenable_out0_qs;
				reg_rdata_next[17] = rxenable_out1_qs;
				reg_rdata_next[18] = rxenable_out2_qs;
				reg_rdata_next[19] = rxenable_out3_qs;
				reg_rdata_next[20] = rxenable_out4_qs;
				reg_rdata_next[21] = rxenable_out5_qs;
				reg_rdata_next[22] = rxenable_out6_qs;
				reg_rdata_next[23] = rxenable_out7_qs;
				reg_rdata_next[24] = rxenable_out8_qs;
				reg_rdata_next[25] = rxenable_out9_qs;
				reg_rdata_next[26] = rxenable_out10_qs;
				reg_rdata_next[27] = rxenable_out11_qs;
			end
			addr_hit[8]: begin
				reg_rdata_next[0] = in_sent_sent0_qs;
				reg_rdata_next[1] = in_sent_sent1_qs;
				reg_rdata_next[2] = in_sent_sent2_qs;
				reg_rdata_next[3] = in_sent_sent3_qs;
				reg_rdata_next[4] = in_sent_sent4_qs;
				reg_rdata_next[5] = in_sent_sent5_qs;
				reg_rdata_next[6] = in_sent_sent6_qs;
				reg_rdata_next[7] = in_sent_sent7_qs;
				reg_rdata_next[8] = in_sent_sent8_qs;
				reg_rdata_next[9] = in_sent_sent9_qs;
				reg_rdata_next[10] = in_sent_sent10_qs;
				reg_rdata_next[11] = in_sent_sent11_qs;
			end
			addr_hit[9]: begin
				reg_rdata_next[0] = stall_stall0_qs;
				reg_rdata_next[1] = stall_stall1_qs;
				reg_rdata_next[2] = stall_stall2_qs;
				reg_rdata_next[3] = stall_stall3_qs;
				reg_rdata_next[4] = stall_stall4_qs;
				reg_rdata_next[5] = stall_stall5_qs;
				reg_rdata_next[6] = stall_stall6_qs;
				reg_rdata_next[7] = stall_stall7_qs;
				reg_rdata_next[8] = stall_stall8_qs;
				reg_rdata_next[9] = stall_stall9_qs;
				reg_rdata_next[10] = stall_stall10_qs;
				reg_rdata_next[11] = stall_stall11_qs;
			end
			addr_hit[10]: begin
				reg_rdata_next[4:0] = configin0_buffer0_qs;
				reg_rdata_next[14:8] = configin0_size0_qs;
				reg_rdata_next[30] = configin0_pend0_qs;
				reg_rdata_next[31] = configin0_rdy0_qs;
			end
			addr_hit[11]: begin
				reg_rdata_next[4:0] = configin1_buffer1_qs;
				reg_rdata_next[14:8] = configin1_size1_qs;
				reg_rdata_next[30] = configin1_pend1_qs;
				reg_rdata_next[31] = configin1_rdy1_qs;
			end
			addr_hit[12]: begin
				reg_rdata_next[4:0] = configin2_buffer2_qs;
				reg_rdata_next[14:8] = configin2_size2_qs;
				reg_rdata_next[30] = configin2_pend2_qs;
				reg_rdata_next[31] = configin2_rdy2_qs;
			end
			addr_hit[13]: begin
				reg_rdata_next[4:0] = configin3_buffer3_qs;
				reg_rdata_next[14:8] = configin3_size3_qs;
				reg_rdata_next[30] = configin3_pend3_qs;
				reg_rdata_next[31] = configin3_rdy3_qs;
			end
			addr_hit[14]: begin
				reg_rdata_next[4:0] = configin4_buffer4_qs;
				reg_rdata_next[14:8] = configin4_size4_qs;
				reg_rdata_next[30] = configin4_pend4_qs;
				reg_rdata_next[31] = configin4_rdy4_qs;
			end
			addr_hit[15]: begin
				reg_rdata_next[4:0] = configin5_buffer5_qs;
				reg_rdata_next[14:8] = configin5_size5_qs;
				reg_rdata_next[30] = configin5_pend5_qs;
				reg_rdata_next[31] = configin5_rdy5_qs;
			end
			addr_hit[16]: begin
				reg_rdata_next[4:0] = configin6_buffer6_qs;
				reg_rdata_next[14:8] = configin6_size6_qs;
				reg_rdata_next[30] = configin6_pend6_qs;
				reg_rdata_next[31] = configin6_rdy6_qs;
			end
			addr_hit[17]: begin
				reg_rdata_next[4:0] = configin7_buffer7_qs;
				reg_rdata_next[14:8] = configin7_size7_qs;
				reg_rdata_next[30] = configin7_pend7_qs;
				reg_rdata_next[31] = configin7_rdy7_qs;
			end
			addr_hit[18]: begin
				reg_rdata_next[4:0] = configin8_buffer8_qs;
				reg_rdata_next[14:8] = configin8_size8_qs;
				reg_rdata_next[30] = configin8_pend8_qs;
				reg_rdata_next[31] = configin8_rdy8_qs;
			end
			addr_hit[19]: begin
				reg_rdata_next[4:0] = configin9_buffer9_qs;
				reg_rdata_next[14:8] = configin9_size9_qs;
				reg_rdata_next[30] = configin9_pend9_qs;
				reg_rdata_next[31] = configin9_rdy9_qs;
			end
			addr_hit[20]: begin
				reg_rdata_next[4:0] = configin10_buffer10_qs;
				reg_rdata_next[14:8] = configin10_size10_qs;
				reg_rdata_next[30] = configin10_pend10_qs;
				reg_rdata_next[31] = configin10_rdy10_qs;
			end
			addr_hit[21]: begin
				reg_rdata_next[4:0] = configin11_buffer11_qs;
				reg_rdata_next[14:8] = configin11_size11_qs;
				reg_rdata_next[30] = configin11_pend11_qs;
				reg_rdata_next[31] = configin11_rdy11_qs;
			end
			default: reg_rdata_next = 1'sb1;
		endcase
	end
	always @(posedge clk_i or negedge rst_ni)
		if (!rst_ni) begin
			reg_valid <= 1'b0;
			reg_rdata <= 1'sb0;
			rsp_opcode <= tlul_pkg_AccessAck;
		end
		else if ((reg_re || reg_we)) begin
			reg_valid <= 1'b1;
			if (reg_re) begin
				reg_rdata <= reg_rdata_next;
				rsp_opcode <= tlul_pkg_AccessAckData;
			end
			else
				rsp_opcode <= tlul_pkg_AccessAck;
		end
		else if (tl_reg_h2d[0:0])
			reg_valid <= 1'b0;
	always @(posedge clk_i or negedge rst_ni)
		if (!rst_ni)
			outstanding <= 1'b0;
		else if ((tl_reg_h2d[(1 + (3 + (3 + ((((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW)) + (top_pkg_TL_AIW + (top_pkg_TL_AW + ((((top_pkg_TL_DBW - 1) >= 0) ? top_pkg_TL_DBW : (2 - top_pkg_TL_DBW)) + (top_pkg_TL_DW + 16)))))))):(3 + (3 + ((((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW)) + (top_pkg_TL_AIW + (top_pkg_TL_AW + ((((top_pkg_TL_DBW - 1) >= 0) ? top_pkg_TL_DBW : (2 - top_pkg_TL_DBW)) + (top_pkg_TL_DW + 17)))))))] && tl_reg_d2h[0:0]))
			outstanding <= 1'b1;
		else if ((tl_reg_d2h[(1 + (3 + (3 + ((((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW)) + (top_pkg_TL_AIW + (top_pkg_TL_DIW + (top_pkg_TL_DW + (top_pkg_TL_DUW + 1)))))))):(3 + (3 + ((((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW)) + (top_pkg_TL_AIW + (top_pkg_TL_DIW + (top_pkg_TL_DW + (top_pkg_TL_DUW + 2)))))))] && tl_reg_h2d[0:0]))
			outstanding <= 1'b0;
endmodule
