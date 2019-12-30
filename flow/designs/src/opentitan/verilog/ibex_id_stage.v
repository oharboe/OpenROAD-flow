module ibex_id_stage (
	clk_i,
	rst_ni,
	test_en_i,
	fetch_enable_i,
	ctrl_busy_o,
	core_ctrl_firstfetch_o,
	illegal_insn_o,
	instr_valid_i,
	instr_new_i,
	instr_rdata_i,
	instr_rdata_c_i,
	instr_is_compressed_i,
	instr_req_o,
	instr_valid_clear_o,
	id_in_ready_o,
	branch_decision_i,
	pc_set_o,
	pc_mux_o,
	exc_pc_mux_o,
	exc_cause_o,
	illegal_c_insn_i,
	instr_fetch_err_i,
	pc_id_i,
	ex_valid_i,
	lsu_valid_i,
	alu_operator_ex_o,
	alu_operand_a_ex_o,
	alu_operand_b_ex_o,
	mult_en_ex_o,
	div_en_ex_o,
	multdiv_operator_ex_o,
	multdiv_signed_mode_ex_o,
	multdiv_operand_a_ex_o,
	multdiv_operand_b_ex_o,
	csr_access_o,
	csr_op_o,
	csr_save_if_o,
	csr_save_id_o,
	csr_restore_mret_id_o,
	csr_save_cause_o,
	csr_mtval_o,
	priv_mode_i,
	csr_mstatus_tw_i,
	illegal_csr_insn_i,
	data_req_ex_o,
	data_we_ex_o,
	data_type_ex_o,
	data_sign_ext_ex_o,
	data_wdata_ex_o,
	lsu_addr_incr_req_i,
	lsu_addr_last_i,
	csr_mstatus_mie_i,
	csr_msip_i,
	csr_mtip_i,
	csr_meip_i,
	csr_mfip_i,
	irq_pending_i,
	irq_nm_i,
	lsu_load_err_i,
	lsu_store_err_i,
	debug_mode_o,
	debug_cause_o,
	debug_csr_save_o,
	debug_req_i,
	debug_single_step_i,
	debug_ebreakm_i,
	debug_ebreaku_i,
	regfile_wdata_lsu_i,
	regfile_wdata_ex_i,
	csr_rdata_i,
	perf_jump_o,
	perf_branch_o,
	perf_tbranch_o,
	instr_ret_o,
	instr_ret_compressed_o
);
	localparam [0:0] IDLE = 0;
	localparam [0:0] WAIT_MULTICYCLE = 1;
	parameter RV32E = 0;
	parameter RV32M = 1;
	input wire clk_i;
	input wire rst_ni;
	input wire test_en_i;
	input wire fetch_enable_i;
	output wire ctrl_busy_o;
	output wire core_ctrl_firstfetch_o;
	output wire illegal_insn_o;
	input wire instr_valid_i;
	input wire instr_new_i;
	input wire [31:0] instr_rdata_i;
	input wire [15:0] instr_rdata_c_i;
	input wire instr_is_compressed_i;
	output wire instr_req_o;
	output wire instr_valid_clear_o;
	output wire id_in_ready_o;
	input wire branch_decision_i;
	output wire pc_set_o;
	output wire [2:0] pc_mux_o;
	output wire [1:0] exc_pc_mux_o;
	output wire [5:0] exc_cause_o;
	input wire illegal_c_insn_i;
	input wire instr_fetch_err_i;
	input wire [31:0] pc_id_i;
	input wire ex_valid_i;
	input wire lsu_valid_i;
	output wire [4:0] alu_operator_ex_o;
	output wire [31:0] alu_operand_a_ex_o;
	output wire [31:0] alu_operand_b_ex_o;
	output wire mult_en_ex_o;
	output wire div_en_ex_o;
	output wire [1:0] multdiv_operator_ex_o;
	output wire [1:0] multdiv_signed_mode_ex_o;
	output wire [31:0] multdiv_operand_a_ex_o;
	output wire [31:0] multdiv_operand_b_ex_o;
	output wire csr_access_o;
	output wire [1:0] csr_op_o;
	output wire csr_save_if_o;
	output wire csr_save_id_o;
	output wire csr_restore_mret_id_o;
	output wire csr_save_cause_o;
	output wire [31:0] csr_mtval_o;
	input wire [1:0] priv_mode_i;
	input wire csr_mstatus_tw_i;
	input wire illegal_csr_insn_i;
	output wire data_req_ex_o;
	output wire data_we_ex_o;
	output wire [1:0] data_type_ex_o;
	output wire data_sign_ext_ex_o;
	output wire [31:0] data_wdata_ex_o;
	input wire lsu_addr_incr_req_i;
	input wire [31:0] lsu_addr_last_i;
	input wire csr_mstatus_mie_i;
	input wire csr_msip_i;
	input wire csr_mtip_i;
	input wire csr_meip_i;
	input wire [14:0] csr_mfip_i;
	input wire irq_pending_i;
	input wire irq_nm_i;
	input wire lsu_load_err_i;
	input wire lsu_store_err_i;
	output wire debug_mode_o;
	output wire [2:0] debug_cause_o;
	output wire debug_csr_save_o;
	input wire debug_req_i;
	input wire debug_single_step_i;
	input wire debug_ebreakm_i;
	input wire debug_ebreaku_i;
	input wire [31:0] regfile_wdata_lsu_i;
	input wire [31:0] regfile_wdata_ex_i;
	input wire [31:0] csr_rdata_i;
	output wire perf_jump_o;
	output reg perf_branch_o;
	output wire perf_tbranch_o;
	output reg instr_ret_o;
	output wire instr_ret_compressed_o;
	parameter [31:0] PMP_MAX_REGIONS = 16;
	parameter [31:0] PMP_CFG_W = 8;
	parameter [31:0] PMP_I = 0;
	parameter [31:0] PMP_D = 1;
	parameter [11:0] CSR_OFF_PMP_CFG = 12'h3A0;
	parameter [11:0] CSR_OFF_PMP_ADDR = 12'h3B0;
	parameter [11:0] CSR_OFF_MCOUNTER_SETUP = 12'h320;
	parameter [11:0] CSR_OFF_MCOUNTER = 12'hB00;
	parameter [11:0] CSR_OFF_MCOUNTERH = 12'hB80;
	parameter [11:0] CSR_MASK_MCOUNTER = 12'hFE0;
	parameter [31:0] CSR_MSTATUS_MIE_BIT = 3;
	parameter [31:0] CSR_MSTATUS_MPIE_BIT = 7;
	parameter [31:0] CSR_MSTATUS_MPP_BIT_LOW = 11;
	parameter [31:0] CSR_MSTATUS_MPP_BIT_HIGH = 12;
	parameter [31:0] CSR_MSTATUS_MPRV_BIT = 17;
	parameter [31:0] CSR_MSTATUS_TW_BIT = 21;
	parameter [31:0] CSR_MSIX_BIT = 3;
	parameter [31:0] CSR_MTIX_BIT = 7;
	parameter [31:0] CSR_MEIX_BIT = 11;
	parameter [31:0] CSR_MFIX_BIT_LOW = 16;
	parameter [31:0] CSR_MFIX_BIT_HIGH = 30;
	localparam [0:0] IMM_A_Z = 0;
	localparam [0:0] OP_B_REG_B = 0;
	localparam [1:0] CSR_OP_READ = 0;
	localparam [1:0] EXC_PC_EXC = 0;
	localparam [1:0] MD_OP_MULL = 0;
	localparam [1:0] OP_A_REG_A = 0;
	localparam [1:0] RF_WD_LSU = 0;
	localparam [2:0] IMM_B_I = 0;
	localparam [2:0] PC_BOOT = 0;
	localparam [4:0] ALU_ADD = 0;
	localparam [0:0] IMM_A_ZERO = 1;
	localparam [0:0] OP_B_IMM = 1;
	localparam [1:0] CSR_OP_WRITE = 1;
	localparam [1:0] EXC_PC_IRQ = 1;
	localparam [1:0] MD_OP_MULH = 1;
	localparam [1:0] OP_A_FWD = 1;
	localparam [1:0] RF_WD_EX = 1;
	localparam [2:0] IMM_B_S = 1;
	localparam [2:0] PC_JUMP = 1;
	localparam [4:0] ALU_SUB = 1;
	localparam [4:0] ALU_LE = 10;
	localparam [4:0] ALU_LEU = 11;
	localparam [4:0] ALU_GT = 12;
	localparam [11:0] CSR_MSTATUS = 12'h300;
	localparam [11:0] CSR_MISA = 12'h301;
	localparam [11:0] CSR_MIE = 12'h304;
	localparam [11:0] CSR_MTVEC = 12'h305;
	localparam [11:0] CSR_MCOUNTINHIBIT = 12'h320;
	localparam [11:0] CSR_MSCRATCH = 12'h340;
	localparam [11:0] CSR_MEPC = 12'h341;
	localparam [11:0] CSR_MCAUSE = 12'h342;
	localparam [11:0] CSR_MTVAL = 12'h343;
	localparam [11:0] CSR_MIP = 12'h344;
	localparam [11:0] CSR_PMPCFG0 = 12'h3A0;
	localparam [11:0] CSR_PMPCFG1 = 12'h3A1;
	localparam [11:0] CSR_PMPCFG2 = 12'h3A2;
	localparam [11:0] CSR_PMPCFG3 = 12'h3A3;
	localparam [11:0] CSR_PMPADDR0 = 12'h3B0;
	localparam [11:0] CSR_PMPADDR1 = 12'h3B1;
	localparam [11:0] CSR_PMPADDR2 = 12'h3B2;
	localparam [11:0] CSR_PMPADDR3 = 12'h3B3;
	localparam [11:0] CSR_PMPADDR4 = 12'h3B4;
	localparam [11:0] CSR_PMPADDR5 = 12'h3B5;
	localparam [11:0] CSR_PMPADDR6 = 12'h3B6;
	localparam [11:0] CSR_PMPADDR7 = 12'h3B7;
	localparam [11:0] CSR_PMPADDR8 = 12'h3B8;
	localparam [11:0] CSR_PMPADDR9 = 12'h3B9;
	localparam [11:0] CSR_PMPADDR10 = 12'h3BA;
	localparam [11:0] CSR_PMPADDR11 = 12'h3BB;
	localparam [11:0] CSR_PMPADDR12 = 12'h3BC;
	localparam [11:0] CSR_PMPADDR13 = 12'h3BD;
	localparam [11:0] CSR_PMPADDR14 = 12'h3BE;
	localparam [11:0] CSR_PMPADDR15 = 12'h3BF;
	localparam [11:0] CSR_DCSR = 12'h7b0;
	localparam [11:0] CSR_DPC = 12'h7b1;
	localparam [11:0] CSR_DSCRATCH0 = 12'h7b2;
	localparam [11:0] CSR_DSCRATCH1 = 12'h7b3;
	localparam [11:0] CSR_MCYCLE = 12'hB00;
	localparam [11:0] CSR_MINSTRET = 12'hB02;
	localparam [11:0] CSR_MCYCLEH = 12'hB80;
	localparam [11:0] CSR_MINSTRETH = 12'hB82;
	localparam [11:0] CSR_MHARTID = 12'hF14;
	localparam [4:0] ALU_GTU = 13;
	localparam [4:0] ALU_GE = 14;
	localparam [4:0] ALU_GEU = 15;
	localparam [4:0] ALU_EQ = 16;
	localparam [4:0] ALU_NE = 17;
	localparam [4:0] ALU_SLT = 18;
	localparam [4:0] ALU_SLTU = 19;
	localparam [1:0] CSR_OP_SET = 2;
	localparam [1:0] EXC_PC_DBD = 2;
	localparam [1:0] MD_OP_DIV = 2;
	localparam [1:0] OP_A_CURRPC = 2;
	localparam [1:0] RF_WD_CSR = 2;
	localparam [2:0] IMM_B_B = 2;
	localparam [2:0] PC_EXC = 2;
	localparam [4:0] ALU_XOR = 2;
	localparam [1:0] PMP_ACC_EXEC = 2'b00;
	localparam [1:0] PMP_MODE_OFF = 2'b00;
	localparam [1:0] PRIV_LVL_U = 2'b00;
	localparam [1:0] PMP_ACC_WRITE = 2'b01;
	localparam [1:0] PMP_MODE_TOR = 2'b01;
	localparam [1:0] PRIV_LVL_S = 2'b01;
	localparam [1:0] PMP_ACC_READ = 2'b10;
	localparam [1:0] PMP_MODE_NA4 = 2'b10;
	localparam [1:0] PRIV_LVL_H = 2'b10;
	localparam [1:0] PMP_MODE_NAPOT = 2'b11;
	localparam [1:0] PRIV_LVL_M = 2'b11;
	localparam [4:0] ALU_SLET = 20;
	localparam [4:0] ALU_SLETU = 21;
	localparam [1:0] CSR_OP_CLEAR = 3;
	localparam [1:0] EXC_PC_DBG_EXC = 3;
	localparam [1:0] MD_OP_REM = 3;
	localparam [1:0] OP_A_IMM = 3;
	localparam [2:0] IMM_B_U = 3;
	localparam [2:0] PC_ERET = 3;
	localparam [4:0] ALU_OR = 3;
	localparam [2:0] DBG_CAUSE_NONE = 3'h0;
	localparam [2:0] DBG_CAUSE_EBREAK = 3'h1;
	localparam [2:0] DBG_CAUSE_TRIGGER = 3'h2;
	localparam [2:0] DBG_CAUSE_HALTREQ = 3'h3;
	localparam [2:0] DBG_CAUSE_STEP = 3'h4;
	localparam [2:0] IMM_B_J = 4;
	localparam [2:0] PC_DRET = 4;
	localparam [4:0] ALU_AND = 4;
	localparam [3:0] XDEBUGVER_NO = 4'd0;
	localparam [3:0] XDEBUGVER_NONSTD = 4'd15;
	localparam [3:0] XDEBUGVER_STD = 4'd4;
	localparam [2:0] IMM_B_INCR_PC = 5;
	localparam [4:0] ALU_SRA = 5;
	localparam [2:0] IMM_B_INCR_ADDR = 6;
	localparam [4:0] ALU_SRL = 6;
	localparam [4:0] ALU_SLL = 7;
	localparam [6:0] OPCODE_LOAD = 7'h03;
	localparam [6:0] OPCODE_MISC_MEM = 7'h0f;
	localparam [6:0] OPCODE_OP_IMM = 7'h13;
	localparam [6:0] OPCODE_AUIPC = 7'h17;
	localparam [6:0] OPCODE_STORE = 7'h23;
	localparam [6:0] OPCODE_OP = 7'h33;
	localparam [6:0] OPCODE_LUI = 7'h37;
	localparam [6:0] OPCODE_BRANCH = 7'h63;
	localparam [6:0] OPCODE_JALR = 7'h67;
	localparam [6:0] OPCODE_JAL = 7'h6f;
	localparam [6:0] OPCODE_SYSTEM = 7'h73;
	localparam [4:0] ALU_LT = 8;
	localparam [4:0] ALU_LTU = 9;
	localparam [5:0] EXC_CAUSE_INSN_ADDR_MISA = {1'b0, 5'd00};
	localparam [5:0] EXC_CAUSE_INSTR_ACCESS_FAULT = {1'b0, 5'd01};
	localparam [5:0] EXC_CAUSE_ILLEGAL_INSN = {1'b0, 5'd02};
	localparam [5:0] EXC_CAUSE_BREAKPOINT = {1'b0, 5'd03};
	localparam [5:0] EXC_CAUSE_LOAD_ACCESS_FAULT = {1'b0, 5'd05};
	localparam [5:0] EXC_CAUSE_STORE_ACCESS_FAULT = {1'b0, 5'd07};
	localparam [5:0] EXC_CAUSE_ECALL_UMODE = {1'b0, 5'd08};
	localparam [5:0] EXC_CAUSE_ECALL_MMODE = {1'b0, 5'd11};
	localparam [5:0] EXC_CAUSE_IRQ_SOFTWARE_M = {1'b1, 5'd03};
	localparam [5:0] EXC_CAUSE_IRQ_TIMER_M = {1'b1, 5'd07};
	localparam [5:0] EXC_CAUSE_IRQ_EXTERNAL_M = {1'b1, 5'd11};
	localparam [5:0] EXC_CAUSE_IRQ_NM = {1'b1, 5'd31};
	wire illegal_insn_dec;
	wire ebrk_insn;
	wire mret_insn_dec;
	wire dret_insn_dec;
	wire ecall_insn_dec;
	wire wfi_insn_dec;
	wire branch_in_dec;
	reg branch_set_n;
	reg branch_set_q;
	wire jump_in_dec;
	wire jump_set;
	wire instr_executing;
	wire instr_multicycle;
	reg instr_multicycle_done_n;
	reg instr_multicycle_done_q;
	reg stall_lsu;
	reg stall_multdiv;
	reg stall_branch;
	reg stall_jump;
	wire [31:0] imm_i_type;
	wire [31:0] imm_s_type;
	wire [31:0] imm_b_type;
	wire [31:0] imm_u_type;
	wire [31:0] imm_j_type;
	wire [31:0] zimm_rs1_type;
	wire [31:0] imm_a;
	reg [31:0] imm_b;
	wire [4:0] regfile_raddr_a;
	wire [4:0] regfile_raddr_b;
	wire [4:0] regfile_waddr;
	wire [31:0] regfile_rdata_a;
	wire [31:0] regfile_rdata_b;
	reg [31:0] regfile_wdata;
	wire [1:0] regfile_wdata_sel;
	wire regfile_we;
	reg regfile_we_wb;
	wire regfile_we_dec;
	wire [4:0] alu_operator;
	wire [1:0] alu_op_a_mux_sel;
	wire [1:0] alu_op_a_mux_sel_dec;
	wire [0:0] alu_op_b_mux_sel;
	wire [0:0] alu_op_b_mux_sel_dec;
	wire [0:0] imm_a_mux_sel;
	wire [2:0] imm_b_mux_sel;
	wire [2:0] imm_b_mux_sel_dec;
	wire mult_en_id;
	wire mult_en_dec;
	wire div_en_id;
	wire div_en_dec;
	wire multdiv_en_dec;
	wire [1:0] multdiv_operator;
	wire [1:0] multdiv_signed_mode;
	wire data_we_id;
	wire [1:0] data_type_id;
	wire data_sign_ext_id;
	wire data_req_id;
	wire data_req_dec;
	wire csr_pipe_flush;
	reg [31:0] alu_operand_a;
	wire [31:0] alu_operand_b;
	assign alu_op_a_mux_sel = (lsu_addr_incr_req_i ? OP_A_FWD : alu_op_a_mux_sel_dec);
	assign alu_op_b_mux_sel = (lsu_addr_incr_req_i ? OP_B_IMM : alu_op_b_mux_sel_dec);
	assign imm_b_mux_sel = (lsu_addr_incr_req_i ? IMM_B_INCR_ADDR : imm_b_mux_sel_dec);
	assign imm_a = ((imm_a_mux_sel == IMM_A_Z) ? zimm_rs1_type : 1'sb0);
	always @(*) begin : alu_operand_a_mux
		case (alu_op_a_mux_sel)
			OP_A_REG_A: alu_operand_a = regfile_rdata_a;
			OP_A_FWD: alu_operand_a = lsu_addr_last_i;
			OP_A_CURRPC: alu_operand_a = pc_id_i;
			OP_A_IMM: alu_operand_a = imm_a;
			default: alu_operand_a = 1'sbX;
		endcase
	end
	always @(*) begin : immediate_b_mux
		case (imm_b_mux_sel)
			IMM_B_I: imm_b = imm_i_type;
			IMM_B_S: imm_b = imm_s_type;
			IMM_B_B: imm_b = imm_b_type;
			IMM_B_U: imm_b = imm_u_type;
			IMM_B_J: imm_b = imm_j_type;
			IMM_B_INCR_PC: imm_b = (instr_is_compressed_i ? 32'h2 : 32'h4);
			IMM_B_INCR_ADDR: imm_b = 32'h4;
			default: imm_b = 1'sbX;
		endcase
	end
	assign alu_operand_b = ((alu_op_b_mux_sel == OP_B_IMM) ? imm_b : regfile_rdata_b);
	assign regfile_we = ((illegal_csr_insn_i || !instr_executing) ? 1'b0 : ((data_req_dec || multdiv_en_dec) ? regfile_we_wb : regfile_we_dec));
	always @(*) begin : regfile_wdata_mux
		case (regfile_wdata_sel)
			RF_WD_EX: regfile_wdata = regfile_wdata_ex_i;
			RF_WD_LSU: regfile_wdata = regfile_wdata_lsu_i;
			RF_WD_CSR: regfile_wdata = csr_rdata_i;
			default: regfile_wdata = 1'sbX;
		endcase
	end
	ibex_register_file #(.RV32E(RV32E)) registers_i(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.test_en_i(test_en_i),
		.raddr_a_i(regfile_raddr_a),
		.rdata_a_o(regfile_rdata_a),
		.raddr_b_i(regfile_raddr_b),
		.rdata_b_o(regfile_rdata_b),
		.waddr_a_i(regfile_waddr),
		.wdata_a_i(regfile_wdata),
		.we_a_i(regfile_we)
	);
	ibex_decoder #(
		.RV32E(RV32E),
		.RV32M(RV32M)
	) decoder_i(
		.illegal_insn_o(illegal_insn_dec),
		.ebrk_insn_o(ebrk_insn),
		.mret_insn_o(mret_insn_dec),
		.dret_insn_o(dret_insn_dec),
		.ecall_insn_o(ecall_insn_dec),
		.wfi_insn_o(wfi_insn_dec),
		.jump_set_o(jump_set),
		.instr_new_i(instr_new_i),
		.instr_rdata_i(instr_rdata_i),
		.illegal_c_insn_i(illegal_c_insn_i),
		.imm_a_mux_sel_o(imm_a_mux_sel),
		.imm_b_mux_sel_o(imm_b_mux_sel_dec),
		.imm_i_type_o(imm_i_type),
		.imm_s_type_o(imm_s_type),
		.imm_b_type_o(imm_b_type),
		.imm_u_type_o(imm_u_type),
		.imm_j_type_o(imm_j_type),
		.zimm_rs1_type_o(zimm_rs1_type),
		.regfile_wdata_sel_o(regfile_wdata_sel),
		.regfile_we_o(regfile_we_dec),
		.regfile_raddr_a_o(regfile_raddr_a),
		.regfile_raddr_b_o(regfile_raddr_b),
		.regfile_waddr_o(regfile_waddr),
		.alu_operator_o(alu_operator),
		.alu_op_a_mux_sel_o(alu_op_a_mux_sel_dec),
		.alu_op_b_mux_sel_o(alu_op_b_mux_sel_dec),
		.mult_en_o(mult_en_dec),
		.div_en_o(div_en_dec),
		.multdiv_operator_o(multdiv_operator),
		.multdiv_signed_mode_o(multdiv_signed_mode),
		.csr_access_o(csr_access_o),
		.csr_op_o(csr_op_o),
		.csr_pipe_flush_o(csr_pipe_flush),
		.data_req_o(data_req_dec),
		.data_we_o(data_we_id),
		.data_type_o(data_type_id),
		.data_sign_extension_o(data_sign_ext_id),
		.jump_in_dec_o(jump_in_dec),
		.branch_in_dec_o(branch_in_dec)
	);
	assign illegal_insn_o = (instr_valid_i & (illegal_insn_dec | illegal_csr_insn_i));
	ibex_controller controller_i(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.fetch_enable_i(fetch_enable_i),
		.ctrl_busy_o(ctrl_busy_o),
		.first_fetch_o(core_ctrl_firstfetch_o),
		.illegal_insn_i(illegal_insn_o),
		.ecall_insn_i(ecall_insn_dec),
		.mret_insn_i(mret_insn_dec),
		.dret_insn_i(dret_insn_dec),
		.wfi_insn_i(wfi_insn_dec),
		.ebrk_insn_i(ebrk_insn),
		.csr_pipe_flush_i(csr_pipe_flush),
		.instr_valid_i(instr_valid_i),
		.instr_i(instr_rdata_i),
		.instr_compressed_i(instr_rdata_c_i),
		.instr_is_compressed_i(instr_is_compressed_i),
		.instr_fetch_err_i(instr_fetch_err_i),
		.pc_id_i(pc_id_i),
		.instr_valid_clear_o(instr_valid_clear_o),
		.id_in_ready_o(id_in_ready_o),
		.instr_req_o(instr_req_o),
		.pc_set_o(pc_set_o),
		.pc_mux_o(pc_mux_o),
		.exc_pc_mux_o(exc_pc_mux_o),
		.exc_cause_o(exc_cause_o),
		.lsu_addr_last_i(lsu_addr_last_i),
		.load_err_i(lsu_load_err_i),
		.store_err_i(lsu_store_err_i),
		.branch_set_i(branch_set_q),
		.jump_set_i(jump_set),
		.csr_mstatus_mie_i(csr_mstatus_mie_i),
		.csr_msip_i(csr_msip_i),
		.csr_mtip_i(csr_mtip_i),
		.csr_meip_i(csr_meip_i),
		.csr_mfip_i(csr_mfip_i),
		.irq_pending_i(irq_pending_i),
		.irq_nm_i(irq_nm_i),
		.csr_save_if_o(csr_save_if_o),
		.csr_save_id_o(csr_save_id_o),
		.csr_restore_mret_id_o(csr_restore_mret_id_o),
		.csr_save_cause_o(csr_save_cause_o),
		.csr_mtval_o(csr_mtval_o),
		.priv_mode_i(priv_mode_i),
		.csr_mstatus_tw_i(csr_mstatus_tw_i),
		.debug_mode_o(debug_mode_o),
		.debug_cause_o(debug_cause_o),
		.debug_csr_save_o(debug_csr_save_o),
		.debug_req_i(debug_req_i),
		.debug_single_step_i(debug_single_step_i),
		.debug_ebreakm_i(debug_ebreakm_i),
		.debug_ebreaku_i(debug_ebreaku_i),
		.stall_lsu_i(stall_lsu),
		.stall_multdiv_i(stall_multdiv),
		.stall_jump_i(stall_jump),
		.stall_branch_i(stall_branch),
		.perf_jump_o(perf_jump_o),
		.perf_tbranch_o(perf_tbranch_o)
	);
	assign multdiv_en_dec = (mult_en_dec | div_en_dec);
	assign instr_multicycle = (((data_req_dec | multdiv_en_dec) | branch_in_dec) | jump_in_dec);
	assign instr_executing = ((instr_new_i | (instr_multicycle & ~instr_multicycle_done_q)) & ~instr_fetch_err_i);
	assign data_req_id = (instr_executing ? data_req_dec : 1'b0);
	assign mult_en_id = (instr_executing ? mult_en_dec : 1'b0);
	assign div_en_id = (instr_executing ? div_en_dec : 1'b0);
	assign data_req_ex_o = data_req_id;
	assign data_we_ex_o = data_we_id;
	assign data_type_ex_o = data_type_id;
	assign data_sign_ext_ex_o = data_sign_ext_id;
	assign data_wdata_ex_o = regfile_rdata_b;
	assign alu_operator_ex_o = alu_operator;
	assign alu_operand_a_ex_o = alu_operand_a;
	assign alu_operand_b_ex_o = alu_operand_b;
	assign mult_en_ex_o = mult_en_id;
	assign div_en_ex_o = div_en_id;
	assign multdiv_operator_ex_o = multdiv_operator;
	assign multdiv_signed_mode_ex_o = multdiv_signed_mode;
	assign multdiv_operand_a_ex_o = regfile_rdata_a;
	assign multdiv_operand_b_ex_o = regfile_rdata_b;
	reg [0:0] id_wb_fsm_cs;
	reg [0:0] id_wb_fsm_ns;
	always @(posedge clk_i or negedge rst_ni) begin : id_wb_pipeline_reg
		if (!rst_ni) begin
			id_wb_fsm_cs <= IDLE;
			branch_set_q <= 1'b0;
			instr_multicycle_done_q <= 1'b0;
		end
		else begin
			id_wb_fsm_cs <= id_wb_fsm_ns;
			branch_set_q <= branch_set_n;
			instr_multicycle_done_q <= instr_multicycle_done_n;
		end
	end
	always @(*) begin : id_wb_fsm
		id_wb_fsm_ns = id_wb_fsm_cs;
		instr_multicycle_done_n = instr_multicycle_done_q;
		regfile_we_wb = 1'b0;
		stall_lsu = 1'b0;
		stall_multdiv = 1'b0;
		stall_jump = 1'b0;
		stall_branch = 1'b0;
		branch_set_n = 1'b0;
		perf_branch_o = 1'b0;
		instr_ret_o = 1'b0;
		case (id_wb_fsm_cs)
			IDLE:
				if ((instr_new_i & ~instr_fetch_err_i))
					case (1'b1)
						data_req_dec: begin
							id_wb_fsm_ns = WAIT_MULTICYCLE;
							stall_lsu = 1'b1;
							instr_multicycle_done_n = 1'b0;
						end
						multdiv_en_dec: begin
							id_wb_fsm_ns = WAIT_MULTICYCLE;
							stall_multdiv = 1'b1;
							instr_multicycle_done_n = 1'b0;
						end
						branch_in_dec: begin
							id_wb_fsm_ns = (branch_decision_i ? WAIT_MULTICYCLE : IDLE);
							stall_branch = branch_decision_i;
							instr_multicycle_done_n = ~branch_decision_i;
							branch_set_n = branch_decision_i;
							perf_branch_o = 1'b1;
							instr_ret_o = ~branch_decision_i;
						end
						jump_in_dec: begin
							id_wb_fsm_ns = WAIT_MULTICYCLE;
							stall_jump = 1'b1;
							instr_multicycle_done_n = 1'b0;
						end
						default: begin
						instr_multicycle_done_n = 1'b0;
						instr_ret_o = 1'b1;
					end
					endcase
			WAIT_MULTICYCLE:
				if (((data_req_dec & lsu_valid_i) | (~data_req_dec & ex_valid_i))) begin
					id_wb_fsm_ns = IDLE;
					instr_multicycle_done_n = 1'b1;
					regfile_we_wb = (regfile_we_dec & ~lsu_load_err_i);
					instr_ret_o = 1'b1;
				end
				else begin
					stall_lsu = data_req_dec;
					stall_multdiv = multdiv_en_dec;
					stall_branch = branch_in_dec;
					stall_jump = jump_in_dec;
				end
			default: id_wb_fsm_ns = 1'bX;
		endcase
	end
	assign instr_ret_compressed_o = (instr_ret_o & instr_is_compressed_i);
endmodule
