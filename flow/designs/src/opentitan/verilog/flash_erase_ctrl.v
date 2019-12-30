module flash_erase_ctrl (
	op_start_i,
	op_type_i,
	op_addr_i,
	op_done_o,
	op_err_o,
	flash_req_o,
	flash_addr_o,
	flash_op_o,
	flash_done_i,
	flash_error_i
);
	localparam top_pkg_FLASH_BANKS = 2;
	localparam top_pkg_FLASH_PAGES_PER_BANK = 256;
	parameter signed [31:0] AddrW = 10;
	parameter signed [31:0] WordsPerPage = 256;
	parameter signed [31:0] PagesPerBank = 256;
	parameter signed [31:0] EraseBitWidth = 1;
	input op_start_i;
	input [(EraseBitWidth - 1):0] op_type_i;
	input [(AddrW - 1):0] op_addr_i;
	output wire op_done_o;
	output wire op_err_o;
	output wire flash_req_o;
	output wire [(AddrW - 1):0] flash_addr_o;
	output wire [(EraseBitWidth - 1):0] flash_op_o;
	input flash_done_i;
	input flash_error_i;
	localparam signed [31:0] FlashTotalPages = (top_pkg_FLASH_BANKS * top_pkg_FLASH_PAGES_PER_BANK);
	localparam signed [31:0] AllPagesW = 9;
	localparam [0:0] PageErase = 0;
	localparam [0:0] BankErase = 1;
	localparam [0:0] WriteDir = 1'b0;
	localparam [0:0] ReadDir = 1'b1;
	localparam [1:0] FlashRead = 2'h0;
	localparam [1:0] FlashProg = 2'h1;
	localparam [1:0] FlashErase = 2'h2;
	localparam signed [31:0] WordsBitWidth = $clog2(WordsPerPage);
	localparam signed [31:0] PagesBitWidth = $clog2(PagesPerBank);
	localparam [(AddrW - 1):0] PageAddrMask = ~(('h1 << WordsBitWidth) - 1'b1);
	localparam [(AddrW - 1):0] BankAddrMask = ~(('h1 << (PagesBitWidth + WordsBitWidth)) - 1'b1);
	assign op_done_o = (flash_req_o & flash_done_i);
	assign op_err_o = (flash_req_o & flash_error_i);
	assign flash_req_o = op_start_i;
	assign flash_op_o = op_type_i;
	assign flash_addr_o = ((op_type_i == PageErase) ? (op_addr_i & PageAddrMask) : (op_addr_i & BankAddrMask));
	wire [(WordsBitWidth - 1):0] unused_addr_i;
	assign unused_addr_i = op_addr_i[(WordsBitWidth - 1):0];
endmodule
