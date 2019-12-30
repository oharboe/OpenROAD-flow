module tlul_adapter_sram (
	clk_i,
	rst_ni,
	tl_i,
	tl_o,
	req_o,
	gnt_i,
	we_o,
	addr_o,
	wdata_o,
	wmask_o,
	rdata_i,
	rvalid_i,
	rerror_i
);
	localparam top_pkg_TL_AW = 32;
	localparam top_pkg_TL_DW = 32;
	localparam top_pkg_TL_AIW = 8;
	localparam top_pkg_TL_DIW = 1;
	localparam top_pkg_TL_DUW = 16;
	localparam top_pkg_TL_DBW = (top_pkg_TL_DW >> 3);
	localparam top_pkg_TL_SZW = $clog2(($clog2((32 >> 3)) + 1));
	localparam [1:0] OpWrite = 0;
	localparam [1:0] OpRead = 1;
	parameter signed [31:0] SramAw = 12;
	parameter signed [31:0] SramDw = 32;
	parameter signed [31:0] Outstanding = 1;
	parameter ByteAccess = 1;
	parameter ErrOnWrite = 0;
	parameter ErrOnRead = 0;
	input clk_i;
	input rst_ni;
	input wire [(((((((7 + (((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW))) + top_pkg_TL_AIW) + top_pkg_TL_AW) + (((top_pkg_TL_DBW - 1) >= 0) ? top_pkg_TL_DBW : (2 - top_pkg_TL_DBW))) + top_pkg_TL_DW) + 17) - 1):0] tl_i;
	output wire [(((((((7 + (((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW))) + top_pkg_TL_AIW) + top_pkg_TL_DIW) + top_pkg_TL_DW) + top_pkg_TL_DUW) + 2) - 1):0] tl_o;
	output wire req_o;
	input gnt_i;
	output wire we_o;
	output wire [(SramAw - 1):0] addr_o;
	output wire [(SramDw - 1):0] wdata_o;
	output reg [(SramDw - 1):0] wmask_o;
	input [(SramDw - 1):0] rdata_i;
	input rvalid_i;
	input [1:0] rerror_i;
	localparam [2:0] AccessAck = 3'h 0;
	localparam [2:0] PutFullData = 3'h 0;
	localparam [2:0] AccessAckData = 3'h 1;
	localparam [2:0] PutPartialData = 3'h 1;
	localparam [2:0] Get = 3'h 4;
	localparam signed [31:0] SramByte = (SramDw / 8);
	localparam signed [31:0] DataBitWidth = $clog2((SramDw / 8));
	localparam signed [31:0] ReqFifoWidth = (((((3 + ((($clog2(($clog2((32 >> 3)) + 1)) - 1) >= 0) ? $clog2(($clog2((32 >> 3)) + 1)) : (2 - $clog2(($clog2((32 >> 3)) + 1))))) + 8) - 1) >= 0) ? ((3 + (((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW))) + top_pkg_TL_AIW) : (2 - ((3 + (((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW))) + top_pkg_TL_AIW)));
	localparam signed [31:0] RspFifoWidth = (((((((SramDw - 1) >= 0) ? SramDw : (2 - SramDw)) + 1) - 1) >= 0) ? ((((SramDw - 1) >= 0) ? SramDw : (2 - SramDw)) + 1) : (2 - ((((SramDw - 1) >= 0) ? SramDw : (2 - SramDw)) + 1)));
	wire reqfifo_wvalid;
	wire reqfifo_wready;
	wire reqfifo_rvalid;
	wire reqfifo_rready;
	wire [(((3 + (((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW))) + top_pkg_TL_AIW) - 1):0] reqfifo_wdata;
	wire [(((3 + (((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW))) + top_pkg_TL_AIW) - 1):0] reqfifo_rdata;
	wire rspfifo_wvalid;
	wire rspfifo_wready;
	wire rspfifo_rvalid;
	wire rspfifo_rready;
	wire [(((((SramDw - 1) >= 0) ? SramDw : (2 - SramDw)) + 1) - 1):0] rspfifo_wdata;
	wire [(((((SramDw - 1) >= 0) ? SramDw : (2 - SramDw)) + 1) - 1):0] rspfifo_rdata;
	wire error_internal;
	wire wr_attr_error;
	wire wr_vld_error;
	wire rd_vld_error;
	wire tlul_error;
	wire a_ack;
	wire d_ack;
	wire unused_sram_ack;
	assign a_ack = (tl_i[(1 + (3 + (3 + ((((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW)) + (top_pkg_TL_AIW + (top_pkg_TL_AW + ((((top_pkg_TL_DBW - 1) >= 0) ? top_pkg_TL_DBW : (2 - top_pkg_TL_DBW)) + (top_pkg_TL_DW + 16)))))))):(3 + (3 + ((((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW)) + (top_pkg_TL_AIW + (top_pkg_TL_AW + ((((top_pkg_TL_DBW - 1) >= 0) ? top_pkg_TL_DBW : (2 - top_pkg_TL_DBW)) + (top_pkg_TL_DW + 17)))))))] & tl_o[0:0]);
	assign d_ack = (tl_o[(1 + (3 + (3 + ((((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW)) + (top_pkg_TL_AIW + (top_pkg_TL_DIW + (top_pkg_TL_DW + (top_pkg_TL_DUW + 1)))))))):(3 + (3 + ((((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW)) + (top_pkg_TL_AIW + (top_pkg_TL_DIW + (top_pkg_TL_DW + (top_pkg_TL_DUW + 2)))))))] & tl_i[0:0]);
	assign unused_sram_ack = (req_o & gnt_i);
	reg d_valid;
	reg d_error;
	always @(*) begin
		d_valid = 1'b0;
		if (reqfifo_rvalid) begin
			if (reqfifo_rdata[(1 + ((((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW)) + (top_pkg_TL_AIW + -1))):((((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW)) + top_pkg_TL_AIW)])
				d_valid = 1'b1;
			else if ((reqfifo_rdata[(2 + (1 + ((((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW)) + (top_pkg_TL_AIW + -1)))):(1 + ((((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW)) + top_pkg_TL_AIW))] == OpRead))
				d_valid = rspfifo_rvalid;
			else
				d_valid = 1'b1;
		end
		else
			d_valid = 1'b0;
	end
	always @(*) begin
		d_error = 1'b0;
		if (reqfifo_rvalid) begin
			if ((reqfifo_rdata[(2 + (1 + ((((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW)) + (top_pkg_TL_AIW + -1)))):(1 + ((((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW)) + top_pkg_TL_AIW))] == OpRead))
				d_error = (rspfifo_rdata[0:0] | reqfifo_rdata[(1 + ((((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW)) + (top_pkg_TL_AIW + -1))):((((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW)) + top_pkg_TL_AIW)]);
			else
				d_error = reqfifo_rdata[(1 + ((((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW)) + (top_pkg_TL_AIW + -1))):((((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW)) + top_pkg_TL_AIW)];
		end
		else
			d_error = 1'b0;
	end
	assign tl_o = sv2v_struct_44CB9(d_valid, ((reqfifo_rdata[(2 + (1 + ((((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW)) + (top_pkg_TL_AIW + -1)))):(1 + ((((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW)) + top_pkg_TL_AIW))] != OpRead) ? AccessAck : AccessAckData), 1'sb0, reqfifo_rdata[((((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW)) + (top_pkg_TL_AIW + -1)):top_pkg_TL_AIW], reqfifo_rdata[(top_pkg_TL_AIW + -1):0], 1'b0, rspfifo_rdata[(((SramDw - 1) >= 0) ? SramDw : (2 - SramDw)):1], 1'sb0, d_error, ((gnt_i | error_internal) & reqfifo_wready));
	assign req_o = ((reqfifo_wready & tl_i[(1 + (3 + (3 + ((((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW)) + (top_pkg_TL_AIW + (top_pkg_TL_AW + ((((top_pkg_TL_DBW - 1) >= 0) ? top_pkg_TL_DBW : (2 - top_pkg_TL_DBW)) + (top_pkg_TL_DW + 16)))))))):(3 + (3 + ((((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW)) + (top_pkg_TL_AIW + (top_pkg_TL_AW + ((((top_pkg_TL_DBW - 1) >= 0) ? top_pkg_TL_DBW : (2 - top_pkg_TL_DBW)) + (top_pkg_TL_DW + 17)))))))]) & ~error_internal);
	assign we_o = (((tl_i[(3 + (3 + ((((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW)) + (top_pkg_TL_AIW + (top_pkg_TL_AW + ((((top_pkg_TL_DBW - 1) >= 0) ? top_pkg_TL_DBW : (2 - top_pkg_TL_DBW)) + (top_pkg_TL_DW + 16))))))):(3 + ((((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW)) + (top_pkg_TL_AIW + (top_pkg_TL_AW + ((((top_pkg_TL_DBW - 1) >= 0) ? top_pkg_TL_DBW : (2 - top_pkg_TL_DBW)) + (top_pkg_TL_DW + 17))))))] == PutFullData) || (tl_i[(3 + (3 + ((((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW)) + (top_pkg_TL_AIW + (top_pkg_TL_AW + ((((top_pkg_TL_DBW - 1) >= 0) ? top_pkg_TL_DBW : (2 - top_pkg_TL_DBW)) + (top_pkg_TL_DW + 16))))))):(3 + ((((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW)) + (top_pkg_TL_AIW + (top_pkg_TL_AW + ((((top_pkg_TL_DBW - 1) >= 0) ? top_pkg_TL_DBW : (2 - top_pkg_TL_DBW)) + (top_pkg_TL_DW + 17))))))] == PutPartialData)) ? 1'b1 : 1'b0);
	assign addr_o = tl_i[(DataBitWidth + (((32 + (((((32 >> 3) - 1) >= 0) ? (32 >> 3) : (2 - (32 >> 3))) + 48)) >= (((((32 >> 3) - 1) >= 0) ? (32 >> 3) : (2 - (32 >> 3))) + 49)) ? ((((top_pkg_TL_DBW - 1) >= 0) ? top_pkg_TL_DBW : (2 - top_pkg_TL_DBW)) + (top_pkg_TL_DW + 17)) : (top_pkg_TL_AW + ((((top_pkg_TL_DBW - 1) >= 0) ? top_pkg_TL_DBW : (2 - top_pkg_TL_DBW)) + (top_pkg_TL_DW + 16)))))+:SramAw];
	assign wdata_o = tl_i[(top_pkg_TL_DW + 16):17];
	always @(*) begin : sv2v_autoblock_1
		reg signed [31:0] i;
		for (i = 0; (i < (top_pkg_TL_DW / 8)); i = (i + 1))
			wmask_o[(8 * i)+:8] = {8 {tl_i[((top_pkg_TL_DW + 17) + i)]}};
	end
	assign wr_attr_error = (((tl_i[(3 + (3 + ((((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW)) + (top_pkg_TL_AIW + (top_pkg_TL_AW + ((((top_pkg_TL_DBW - 1) >= 0) ? top_pkg_TL_DBW : (2 - top_pkg_TL_DBW)) + (top_pkg_TL_DW + 16))))))):(3 + ((((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW)) + (top_pkg_TL_AIW + (top_pkg_TL_AW + ((((top_pkg_TL_DBW - 1) >= 0) ? top_pkg_TL_DBW : (2 - top_pkg_TL_DBW)) + (top_pkg_TL_DW + 17))))))] == PutFullData) || (tl_i[(3 + (3 + ((((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW)) + (top_pkg_TL_AIW + (top_pkg_TL_AW + ((((top_pkg_TL_DBW - 1) >= 0) ? top_pkg_TL_DBW : (2 - top_pkg_TL_DBW)) + (top_pkg_TL_DW + 16))))))):(3 + ((((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW)) + (top_pkg_TL_AIW + (top_pkg_TL_AW + ((((top_pkg_TL_DBW - 1) >= 0) ? top_pkg_TL_DBW : (2 - top_pkg_TL_DBW)) + (top_pkg_TL_DW + 17))))))] == PutPartialData)) ? ((ByteAccess == 0) ? ((tl_i[((((top_pkg_TL_DBW - 1) >= 0) ? top_pkg_TL_DBW : (2 - top_pkg_TL_DBW)) + (top_pkg_TL_DW + 16)):(top_pkg_TL_DW + 17)] != 1'sb1) || (tl_i[((((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW)) + (top_pkg_TL_AIW + (top_pkg_TL_AW + ((((top_pkg_TL_DBW - 1) >= 0) ? top_pkg_TL_DBW : (2 - top_pkg_TL_DBW)) + (top_pkg_TL_DW + 16))))):(top_pkg_TL_AIW + (top_pkg_TL_AW + ((((top_pkg_TL_DBW - 1) >= 0) ? top_pkg_TL_DBW : (2 - top_pkg_TL_DBW)) + (top_pkg_TL_DW + 17))))] != 2'h2)) : 1'b0) : 1'b0);
	generate
		if ((ErrOnWrite == 1)) begin : gen_no_writes
			assign wr_vld_error = (tl_i[(3 + (3 + ((((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW)) + (top_pkg_TL_AIW + (top_pkg_TL_AW + ((((top_pkg_TL_DBW - 1) >= 0) ? top_pkg_TL_DBW : (2 - top_pkg_TL_DBW)) + (top_pkg_TL_DW + 16))))))):(3 + ((((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW)) + (top_pkg_TL_AIW + (top_pkg_TL_AW + ((((top_pkg_TL_DBW - 1) >= 0) ? top_pkg_TL_DBW : (2 - top_pkg_TL_DBW)) + (top_pkg_TL_DW + 17))))))] != Get);
		end
		else begin : gen_writes_allowed
			assign wr_vld_error = 1'b0;
		end
	endgenerate
	generate
		if ((ErrOnRead == 1)) begin : gen_no_reads
			assign rd_vld_error = (tl_i[(3 + (3 + ((((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW)) + (top_pkg_TL_AIW + (top_pkg_TL_AW + ((((top_pkg_TL_DBW - 1) >= 0) ? top_pkg_TL_DBW : (2 - top_pkg_TL_DBW)) + (top_pkg_TL_DW + 16))))))):(3 + ((((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW)) + (top_pkg_TL_AIW + (top_pkg_TL_AW + ((((top_pkg_TL_DBW - 1) >= 0) ? top_pkg_TL_DBW : (2 - top_pkg_TL_DBW)) + (top_pkg_TL_DW + 17))))))] == Get);
		end
		else begin : gen_reads_allowed
			assign rd_vld_error = 1'b0;
		end
	endgenerate
	tlul_err u_err(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.tl_i(tl_i),
		.err_o(tlul_error)
	);
	assign error_internal = (((wr_attr_error | wr_vld_error) | rd_vld_error) | tlul_error);
	assign reqfifo_wvalid = a_ack;
	assign reqfifo_wdata = sv2v_struct_EA404(((tl_i[(3 + (3 + ((((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW)) + (top_pkg_TL_AIW + (top_pkg_TL_AW + ((((top_pkg_TL_DBW - 1) >= 0) ? top_pkg_TL_DBW : (2 - top_pkg_TL_DBW)) + (top_pkg_TL_DW + 16))))))):(3 + ((((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW)) + (top_pkg_TL_AIW + (top_pkg_TL_AW + ((((top_pkg_TL_DBW - 1) >= 0) ? top_pkg_TL_DBW : (2 - top_pkg_TL_DBW)) + (top_pkg_TL_DW + 17))))))] != Get) ? OpWrite : OpRead), error_internal, tl_i[((((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW)) + (top_pkg_TL_AIW + (top_pkg_TL_AW + ((((top_pkg_TL_DBW - 1) >= 0) ? top_pkg_TL_DBW : (2 - top_pkg_TL_DBW)) + (top_pkg_TL_DW + 16))))):(top_pkg_TL_AIW + (top_pkg_TL_AW + ((((top_pkg_TL_DBW - 1) >= 0) ? top_pkg_TL_DBW : (2 - top_pkg_TL_DBW)) + (top_pkg_TL_DW + 17))))], tl_i[(top_pkg_TL_AIW + (top_pkg_TL_AW + ((((top_pkg_TL_DBW - 1) >= 0) ? top_pkg_TL_DBW : (2 - top_pkg_TL_DBW)) + (top_pkg_TL_DW + 16)))):(top_pkg_TL_AW + ((((top_pkg_TL_DBW - 1) >= 0) ? top_pkg_TL_DBW : (2 - top_pkg_TL_DBW)) + (top_pkg_TL_DW + 17)))]);
	assign reqfifo_rready = d_ack;
	assign rspfifo_wvalid = (rvalid_i & reqfifo_rvalid);
	assign rspfifo_wdata = sv2v_struct_4FD15(rdata_i, rerror_i[1]);
	assign rspfifo_rready = (((reqfifo_rdata[(2 + (1 + ((((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW)) + (top_pkg_TL_AIW + -1)))):(1 + ((((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW)) + top_pkg_TL_AIW))] == OpRead) & ~reqfifo_rdata[(1 + ((((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW)) + (top_pkg_TL_AIW + -1))):((((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW)) + top_pkg_TL_AIW)]) ? reqfifo_rready : 1'b0);
	prim_fifo_sync #(
		.Width(ReqFifoWidth),
		.Pass(1'b0),
		.Depth((Outstanding + 1'b1))
	) u_reqfifo(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.clr_i(1'b0),
		.wvalid(reqfifo_wvalid),
		.wready(reqfifo_wready),
		.wdata(reqfifo_wdata),
		.depth(),
		.rvalid(reqfifo_rvalid),
		.rready(reqfifo_rready),
		.rdata(reqfifo_rdata)
	);
	prim_fifo_sync #(
		.Width(RspFifoWidth),
		.Pass(1'b1),
		.Depth(Outstanding)
	) u_rspfifo(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.clr_i(1'b0),
		.wvalid(rspfifo_wvalid),
		.wready(rspfifo_wready),
		.wdata(rspfifo_wdata),
		.depth(),
		.rvalid(rspfifo_rvalid),
		.rready(rspfifo_rready),
		.rdata(rspfifo_rdata)
	);
	function [(((((((7 + (((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW))) + (((top_pkg_TL_AIW - 1) >= 0) ? top_pkg_TL_AIW : (2 - top_pkg_TL_AIW))) + (((top_pkg_TL_DIW - 1) >= 0) ? top_pkg_TL_DIW : (2 - top_pkg_TL_DIW))) + (((top_pkg_TL_DW - 1) >= 0) ? top_pkg_TL_DW : (2 - top_pkg_TL_DW))) + (((top_pkg_TL_DUW - 1) >= 0) ? top_pkg_TL_DUW : (2 - top_pkg_TL_DUW))) + 2) - 1):0] sv2v_struct_44CB9;
		input reg d_valid;
		input reg [2:0] d_opcode;
		input reg [2:0] d_param;
		input reg [(top_pkg_TL_SZW - 1):0] d_size;
		input reg [(top_pkg_TL_AIW - 1):0] d_source;
		input reg [(top_pkg_TL_DIW - 1):0] d_sink;
		input reg [(top_pkg_TL_DW - 1):0] d_data;
		input reg [(top_pkg_TL_DUW - 1):0] d_user;
		input reg d_error;
		input reg a_ready;
		sv2v_struct_44CB9 = {d_valid, d_opcode, d_param, d_size, d_source, d_sink, d_data, d_user, d_error, a_ready};
	endfunction
	function [(((3 + (((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW))) + (((top_pkg_TL_AIW - 1) >= 0) ? top_pkg_TL_AIW : (2 - top_pkg_TL_AIW))) - 1):0] sv2v_struct_EA404;
		input reg [1:0] op;
		input reg error;
		input reg [(top_pkg_TL_SZW - 1):0] size;
		input reg [(top_pkg_TL_AIW - 1):0] source;
		sv2v_struct_EA404 = {op, error, size, source};
	endfunction
	function [(((((SramDw - 1) >= 0) ? SramDw : (2 - SramDw)) + 1) - 1):0] sv2v_struct_4FD15;
		input reg [(SramDw - 1):0] data;
		input reg error;
		sv2v_struct_4FD15 = {data, error};
	endfunction
endmodule
