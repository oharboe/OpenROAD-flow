module tlul_fifo_sync (
	clk_i,
	rst_ni,
	tl_h_i,
	tl_h_o,
	tl_d_o,
	tl_d_i,
	spare_req_i,
	spare_req_o,
	spare_rsp_i,
	spare_rsp_o
);
	localparam top_pkg_TL_AW = 32;
	localparam top_pkg_TL_DW = 32;
	localparam top_pkg_TL_AIW = 8;
	localparam top_pkg_TL_DIW = 1;
	localparam top_pkg_TL_DUW = 16;
	localparam top_pkg_TL_DBW = (top_pkg_TL_DW >> 3);
	localparam top_pkg_TL_SZW = $clog2(($clog2((32 >> 3)) + 1));
	parameter ReqPass = 1'b1;
	parameter RspPass = 1'b1;
	parameter ReqDepth = 2;
	parameter RspDepth = 2;
	parameter SpareReqW = 1;
	parameter SpareRspW = 1;
	input clk_i;
	input rst_ni;
	input wire [(((((((7 + (((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW))) + top_pkg_TL_AIW) + top_pkg_TL_AW) + (((top_pkg_TL_DBW - 1) >= 0) ? top_pkg_TL_DBW : (2 - top_pkg_TL_DBW))) + top_pkg_TL_DW) + 17) - 1):0] tl_h_i;
	output wire [(((((((7 + (((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW))) + top_pkg_TL_AIW) + top_pkg_TL_DIW) + top_pkg_TL_DW) + top_pkg_TL_DUW) + 2) - 1):0] tl_h_o;
	output wire [(((((((7 + (((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW))) + top_pkg_TL_AIW) + top_pkg_TL_AW) + (((top_pkg_TL_DBW - 1) >= 0) ? top_pkg_TL_DBW : (2 - top_pkg_TL_DBW))) + top_pkg_TL_DW) + 17) - 1):0] tl_d_o;
	input wire [(((((((7 + (((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW))) + top_pkg_TL_AIW) + top_pkg_TL_DIW) + top_pkg_TL_DW) + top_pkg_TL_DUW) + 2) - 1):0] tl_d_i;
	input [(SpareReqW - 1):0] spare_req_i;
	output [(SpareReqW - 1):0] spare_req_o;
	input [(SpareRspW - 1):0] spare_rsp_i;
	output [(SpareRspW - 1):0] spare_rsp_o;
	localparam REQFIFO_WIDTH = (((((((((7 + ((($clog2(($clog2((32 >> 3)) + 1)) - 1) >= 0) ? $clog2(($clog2((32 >> 3)) + 1)) : (2 - $clog2(($clog2((32 >> 3)) + 1))))) + 40) + ((((32 >> 3) - 1) >= 0) ? (32 >> 3) : (2 - (32 >> 3)))) + 49) - 1) >= 0) ? ((((((7 + (((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW))) + top_pkg_TL_AIW) + top_pkg_TL_AW) + (((top_pkg_TL_DBW - 1) >= 0) ? top_pkg_TL_DBW : (2 - top_pkg_TL_DBW))) + top_pkg_TL_DW) + 17) : (2 - ((((((7 + (((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW))) + top_pkg_TL_AIW) + top_pkg_TL_AW) + (((top_pkg_TL_DBW - 1) >= 0) ? top_pkg_TL_DBW : (2 - top_pkg_TL_DBW))) + top_pkg_TL_DW) + 17))) - 2) + SpareReqW);
	prim_fifo_sync #(
		.Width(REQFIFO_WIDTH),
		.Pass(ReqPass),
		.Depth(ReqDepth)
	) reqfifo(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.clr_i(1'b0),
		.wvalid(tl_h_i[(1 + (3 + (3 + ((((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW)) + (top_pkg_TL_AIW + (top_pkg_TL_AW + ((((top_pkg_TL_DBW - 1) >= 0) ? top_pkg_TL_DBW : (2 - top_pkg_TL_DBW)) + (top_pkg_TL_DW + 16)))))))):(3 + (3 + ((((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW)) + (top_pkg_TL_AIW + (top_pkg_TL_AW + ((((top_pkg_TL_DBW - 1) >= 0) ? top_pkg_TL_DBW : (2 - top_pkg_TL_DBW)) + (top_pkg_TL_DW + 17)))))))]),
		.wready(tl_h_o[0:0]),
		.wdata({tl_h_i[(3 + (3 + ((((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW)) + (top_pkg_TL_AIW + (top_pkg_TL_AW + ((((top_pkg_TL_DBW - 1) >= 0) ? top_pkg_TL_DBW : (2 - top_pkg_TL_DBW)) + (top_pkg_TL_DW + 16))))))):(3 + ((((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW)) + (top_pkg_TL_AIW + (top_pkg_TL_AW + ((((top_pkg_TL_DBW - 1) >= 0) ? top_pkg_TL_DBW : (2 - top_pkg_TL_DBW)) + (top_pkg_TL_DW + 17))))))], tl_h_i[(3 + ((((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW)) + (top_pkg_TL_AIW + (top_pkg_TL_AW + ((((top_pkg_TL_DBW - 1) >= 0) ? top_pkg_TL_DBW : (2 - top_pkg_TL_DBW)) + (top_pkg_TL_DW + 16)))))):((((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW)) + (top_pkg_TL_AIW + (top_pkg_TL_AW + ((((top_pkg_TL_DBW - 1) >= 0) ? top_pkg_TL_DBW : (2 - top_pkg_TL_DBW)) + (top_pkg_TL_DW + 17)))))], tl_h_i[((((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW)) + (top_pkg_TL_AIW + (top_pkg_TL_AW + ((((top_pkg_TL_DBW - 1) >= 0) ? top_pkg_TL_DBW : (2 - top_pkg_TL_DBW)) + (top_pkg_TL_DW + 16))))):(top_pkg_TL_AIW + (top_pkg_TL_AW + ((((top_pkg_TL_DBW - 1) >= 0) ? top_pkg_TL_DBW : (2 - top_pkg_TL_DBW)) + (top_pkg_TL_DW + 17))))], tl_h_i[(top_pkg_TL_AIW + (top_pkg_TL_AW + ((((top_pkg_TL_DBW - 1) >= 0) ? top_pkg_TL_DBW : (2 - top_pkg_TL_DBW)) + (top_pkg_TL_DW + 16)))):(top_pkg_TL_AW + ((((top_pkg_TL_DBW - 1) >= 0) ? top_pkg_TL_DBW : (2 - top_pkg_TL_DBW)) + (top_pkg_TL_DW + 17)))], tl_h_i[(top_pkg_TL_AW + ((((top_pkg_TL_DBW - 1) >= 0) ? top_pkg_TL_DBW : (2 - top_pkg_TL_DBW)) + (top_pkg_TL_DW + 16))):((((top_pkg_TL_DBW - 1) >= 0) ? top_pkg_TL_DBW : (2 - top_pkg_TL_DBW)) + (top_pkg_TL_DW + 17))], tl_h_i[((((top_pkg_TL_DBW - 1) >= 0) ? top_pkg_TL_DBW : (2 - top_pkg_TL_DBW)) + (top_pkg_TL_DW + 16)):(top_pkg_TL_DW + 17)], tl_h_i[(top_pkg_TL_DW + 16):17], tl_h_i[16:1], spare_req_i}),
		.depth(),
		.rvalid(tl_d_o[(1 + (3 + (3 + ((((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW)) + (top_pkg_TL_AIW + (top_pkg_TL_AW + ((((top_pkg_TL_DBW - 1) >= 0) ? top_pkg_TL_DBW : (2 - top_pkg_TL_DBW)) + (top_pkg_TL_DW + 16)))))))):(3 + (3 + ((((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW)) + (top_pkg_TL_AIW + (top_pkg_TL_AW + ((((top_pkg_TL_DBW - 1) >= 0) ? top_pkg_TL_DBW : (2 - top_pkg_TL_DBW)) + (top_pkg_TL_DW + 17)))))))]),
		.rready(tl_d_i[0:0]),
		.rdata({tl_d_o[(3 + (3 + ((((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW)) + (top_pkg_TL_AIW + (top_pkg_TL_AW + ((((top_pkg_TL_DBW - 1) >= 0) ? top_pkg_TL_DBW : (2 - top_pkg_TL_DBW)) + (top_pkg_TL_DW + 16))))))):(3 + ((((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW)) + (top_pkg_TL_AIW + (top_pkg_TL_AW + ((((top_pkg_TL_DBW - 1) >= 0) ? top_pkg_TL_DBW : (2 - top_pkg_TL_DBW)) + (top_pkg_TL_DW + 17))))))], tl_d_o[(3 + ((((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW)) + (top_pkg_TL_AIW + (top_pkg_TL_AW + ((((top_pkg_TL_DBW - 1) >= 0) ? top_pkg_TL_DBW : (2 - top_pkg_TL_DBW)) + (top_pkg_TL_DW + 16)))))):((((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW)) + (top_pkg_TL_AIW + (top_pkg_TL_AW + ((((top_pkg_TL_DBW - 1) >= 0) ? top_pkg_TL_DBW : (2 - top_pkg_TL_DBW)) + (top_pkg_TL_DW + 17)))))], tl_d_o[((((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW)) + (top_pkg_TL_AIW + (top_pkg_TL_AW + ((((top_pkg_TL_DBW - 1) >= 0) ? top_pkg_TL_DBW : (2 - top_pkg_TL_DBW)) + (top_pkg_TL_DW + 16))))):(top_pkg_TL_AIW + (top_pkg_TL_AW + ((((top_pkg_TL_DBW - 1) >= 0) ? top_pkg_TL_DBW : (2 - top_pkg_TL_DBW)) + (top_pkg_TL_DW + 17))))], tl_d_o[(top_pkg_TL_AIW + (top_pkg_TL_AW + ((((top_pkg_TL_DBW - 1) >= 0) ? top_pkg_TL_DBW : (2 - top_pkg_TL_DBW)) + (top_pkg_TL_DW + 16)))):(top_pkg_TL_AW + ((((top_pkg_TL_DBW - 1) >= 0) ? top_pkg_TL_DBW : (2 - top_pkg_TL_DBW)) + (top_pkg_TL_DW + 17)))], tl_d_o[(top_pkg_TL_AW + ((((top_pkg_TL_DBW - 1) >= 0) ? top_pkg_TL_DBW : (2 - top_pkg_TL_DBW)) + (top_pkg_TL_DW + 16))):((((top_pkg_TL_DBW - 1) >= 0) ? top_pkg_TL_DBW : (2 - top_pkg_TL_DBW)) + (top_pkg_TL_DW + 17))], tl_d_o[((((top_pkg_TL_DBW - 1) >= 0) ? top_pkg_TL_DBW : (2 - top_pkg_TL_DBW)) + (top_pkg_TL_DW + 16)):(top_pkg_TL_DW + 17)], tl_d_o[(top_pkg_TL_DW + 16):17], tl_d_o[16:1], spare_req_o})
	);
	localparam RSPFIFO_WIDTH = (((((((7 + ((($clog2(($clog2((32 >> 3)) + 1)) - 1) >= 0) ? $clog2(($clog2((32 >> 3)) + 1)) : (2 - $clog2(($clog2((32 >> 3)) + 1))))) + 59) - 1) >= 0) ? ((((((7 + (((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW))) + top_pkg_TL_AIW) + top_pkg_TL_DIW) + top_pkg_TL_DW) + top_pkg_TL_DUW) + 2) : (2 - ((((((7 + (((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW))) + top_pkg_TL_AIW) + top_pkg_TL_DIW) + top_pkg_TL_DW) + top_pkg_TL_DUW) + 2))) - 2) + SpareRspW);
	prim_fifo_sync #(
		.Width(RSPFIFO_WIDTH),
		.Pass(RspPass),
		.Depth(RspDepth)
	) rspfifo(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.clr_i(1'b0),
		.wvalid(tl_d_i[(1 + (3 + (3 + ((((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW)) + (top_pkg_TL_AIW + (top_pkg_TL_DIW + (top_pkg_TL_DW + (top_pkg_TL_DUW + 1)))))))):(3 + (3 + ((((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW)) + (top_pkg_TL_AIW + (top_pkg_TL_DIW + (top_pkg_TL_DW + (top_pkg_TL_DUW + 2)))))))]),
		.wready(tl_d_o[0:0]),
		.wdata({tl_d_i[(3 + (3 + ((((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW)) + (top_pkg_TL_AIW + (top_pkg_TL_DIW + (top_pkg_TL_DW + (top_pkg_TL_DUW + 1))))))):(3 + ((((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW)) + (top_pkg_TL_AIW + (top_pkg_TL_DIW + (top_pkg_TL_DW + (top_pkg_TL_DUW + 2))))))], tl_d_i[(3 + ((((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW)) + (top_pkg_TL_AIW + (top_pkg_TL_DIW + (top_pkg_TL_DW + (top_pkg_TL_DUW + 1)))))):((((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW)) + (top_pkg_TL_AIW + (top_pkg_TL_DIW + (top_pkg_TL_DW + (top_pkg_TL_DUW + 2)))))], tl_d_i[((((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW)) + (top_pkg_TL_AIW + (top_pkg_TL_DIW + (top_pkg_TL_DW + (top_pkg_TL_DUW + 1))))):(top_pkg_TL_AIW + (top_pkg_TL_DIW + (top_pkg_TL_DW + (top_pkg_TL_DUW + 2))))], tl_d_i[(top_pkg_TL_AIW + (top_pkg_TL_DIW + (top_pkg_TL_DW + (top_pkg_TL_DUW + 1)))):(top_pkg_TL_DIW + (top_pkg_TL_DW + (top_pkg_TL_DUW + 2)))], tl_d_i[(top_pkg_TL_DIW + (top_pkg_TL_DW + (top_pkg_TL_DUW + 1))):(top_pkg_TL_DW + (top_pkg_TL_DUW + 2))], tl_d_i[(top_pkg_TL_DW + (top_pkg_TL_DUW + 1)):(top_pkg_TL_DUW + 2)], tl_d_i[(top_pkg_TL_DUW + 1):2], tl_d_i[1:1], spare_rsp_i}),
		.depth(),
		.rvalid(tl_h_o[(1 + (3 + (3 + ((((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW)) + (top_pkg_TL_AIW + (top_pkg_TL_DIW + (top_pkg_TL_DW + (top_pkg_TL_DUW + 1)))))))):(3 + (3 + ((((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW)) + (top_pkg_TL_AIW + (top_pkg_TL_DIW + (top_pkg_TL_DW + (top_pkg_TL_DUW + 2)))))))]),
		.rready(tl_h_i[0:0]),
		.rdata({tl_h_o[(3 + (3 + ((((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW)) + (top_pkg_TL_AIW + (top_pkg_TL_DIW + (top_pkg_TL_DW + (top_pkg_TL_DUW + 1))))))):(3 + ((((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW)) + (top_pkg_TL_AIW + (top_pkg_TL_DIW + (top_pkg_TL_DW + (top_pkg_TL_DUW + 2))))))], tl_h_o[(3 + ((((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW)) + (top_pkg_TL_AIW + (top_pkg_TL_DIW + (top_pkg_TL_DW + (top_pkg_TL_DUW + 1)))))):((((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW)) + (top_pkg_TL_AIW + (top_pkg_TL_DIW + (top_pkg_TL_DW + (top_pkg_TL_DUW + 2)))))], tl_h_o[((((top_pkg_TL_SZW - 1) >= 0) ? top_pkg_TL_SZW : (2 - top_pkg_TL_SZW)) + (top_pkg_TL_AIW + (top_pkg_TL_DIW + (top_pkg_TL_DW + (top_pkg_TL_DUW + 1))))):(top_pkg_TL_AIW + (top_pkg_TL_DIW + (top_pkg_TL_DW + (top_pkg_TL_DUW + 2))))], tl_h_o[(top_pkg_TL_AIW + (top_pkg_TL_DIW + (top_pkg_TL_DW + (top_pkg_TL_DUW + 1)))):(top_pkg_TL_DIW + (top_pkg_TL_DW + (top_pkg_TL_DUW + 2)))], tl_h_o[(top_pkg_TL_DIW + (top_pkg_TL_DW + (top_pkg_TL_DUW + 1))):(top_pkg_TL_DW + (top_pkg_TL_DUW + 2))], tl_h_o[(top_pkg_TL_DW + (top_pkg_TL_DUW + 1)):(top_pkg_TL_DUW + 2)], tl_h_o[(top_pkg_TL_DUW + 1):2], tl_h_o[1:1], spare_rsp_o})
	);
endmodule
