module prim_generic_pad_wrapper (
	inout_io,
	in_o,
	out_i,
	oe_i,
	attr_i
);
	parameter [31:0] AttrDw = 6;
	inout wire inout_io;
	output wire in_o;
	input out_i;
	input oe_i;
	input [(AttrDw - 1):0] attr_i;
	wire kp;
	wire pu;
	wire pd;
	wire od;
	wire inv;
	wire [0:0] drv;
	assign {drv, kp, pu, pd, od, inv} = attr_i[5:0];
	assign in_o = (inv ^ inout_io);
	wire oe;
	wire out;
	assign out = (out_i ^ inv);
	assign oe = (oe_i & ((od & ~out) | ~od));
	assign inout_io = (oe ? out : 1'bz);
endmodule
