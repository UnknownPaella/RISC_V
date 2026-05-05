

module RISC_V_top #(
    parameter int DATA_WIDTH = 32,
    parameter int ADDR_WIDTH = 32
) (
    input clk,
    input rst
);

  localparam int REG_ADDR_WIDTH = $clog2(ADDR_WIDTH);

  logic [DATA_WIDTH - 1 : 0] imm;
  logic [ADDR_WIDTH - 1 : 0] inst;

  logic [REG_ADDR_WIDTH - 1 : 0] rs1_addr;
  logic [REG_ADDR_WIDTH - 1 : 0] rs2_addr;
  logic [REG_ADDR_WIDTH - 1 : 0] rd_addr;

  logic [DATA_WIDTH - 1 : 0] rs1_data;
  logic [DATA_WIDTH - 1 : 0] rs2_data;
  logic [DATA_WIDTH - 1 : 0] rd_data;
  logic [DATA_WIDTH - 1 : 0] rd_data_reg;

  logic [2 : 0] funct3;
  logic [6 : 0] funct7;


  memory #(
      .DATA_WIDTH(DATA_WIDTH),
      .ADDR_WIDTH(ADDR_WIDTH)
  ) memory_inst (
      .clk(clk),
      .rst(rst),
      .prog_cnt_en(prog_cnt_en),
      .imm_addr(imm),
      .imm_wr(imm_wr),
      .inst_out(inst)
  );

  decode #(
      .DATA_WIDTH(DATA_WIDTH),
      .ADDR_WIDTH(ADDR_WIDTH),
      .REG_ADDR_WIDTH(REG_ADDR_WIDTH)
  ) decode_inst (
      .clk(clk),
      .inst(inst),
      .rs1_addr(rs1_addr),
      .rs2_addr(rs2_addr),
      .rd_addr(rd_addr),
      .imm(imm),
      .ALU_ctrl(ALU_ctrl),
      .alu_use_imm(alu_use_imm),
      .jmp_imm(jmp_imm),
      .load_reg(load_reg),
      .store_reg(store_reg)
  );

  registers #(
      .DATA_WIDTH(DATA_WIDTH),
      .ADDR_WIDTH(ADDR_WIDTH),
      .REG_ADDR_WIDTH(REG_ADDR_WIDTH)
  ) registers_inst (
      .clk(clk),
      .rst(rst),
      .rd_data(rd_data),
      .rd_addr(rd_addr),
      .rs1_addr(rs1_addr),
      .rs2_addr(rs2_addr),
      .rs1_data(rs1_data),
      .rs2_data(rs2_data)
  );

  ALU #(
      .DATA_WIDTH(DATA_WIDTH),
      .ADDR_WIDTH(ADDR_WIDTH),
      .IMM_WIDTH(IMM_WIDTH),
      .REG_ADDR_WIDTH(REG_ADDR_WIDTH)
  ) ALU_inst (
      .clk(clk),
      .rs1_data(rs1_data),
      .rs2_data(rs2_data),
      .imm(imm),
      .enable(enable),
      .ALU_ctrl(ALU_ctrl),
      .use_imm(alu_use_imm),
      .alu_out(rd_data_reg),
      .alu_status(alu_status),
      .done(done)
  );

endmodule
