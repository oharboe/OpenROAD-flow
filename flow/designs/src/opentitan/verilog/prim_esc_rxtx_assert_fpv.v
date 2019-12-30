module prim_esc_rxtx_assert_fpv (
	clk_i,
	rst_ni,
	resp_err_pi,
	resp_err_ni,
	esc_err_pi,
	esc_err_ni,
	esc_en_i,
	ping_en_i,
	ping_ok_o,
	integ_fail_o,
	esc_en_o
);
	input clk_i;
	input rst_ni;
	input resp_err_pi;
	input resp_err_ni;
	input esc_err_pi;
	input esc_err_ni;
	input esc_en_i;
	input ping_en_i;
	input ping_ok_o;
	input integ_fail_o;
	input esc_en_o;
	wire error_present;
	assign error_present = (((resp_err_pi | resp_err_ni) | esc_err_pi) | esc_err_ni);
endmodule
