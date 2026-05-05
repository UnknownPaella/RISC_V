import RV32I_list::*;
import ALU_ops::*;

module control #(
    parameter int DATA_WIDTH = 32,
    parameter int ADDR_WIDTH = 32,
    parameter int REG_ADDR_WIDTH = 5
) (
    input                           clk,
    input  [    ADDR_WIDTH - 1 : 0] inst,
    output [REG_ADDR_WIDTH - 1 : 0] rs1_addr,
    output [REG_ADDR_WIDTH - 1 : 0] rs2_addr,
    output [REG_ADDR_WIDTH - 1 : 0] rd_addr,
    output [    DATA_WIDTH - 1 : 0] imm,
    output [                 9 : 0] ALU_ctrl,
    output                          alu_use_imm,
    output                          jmp_imm
);

  logic [REG_ADDR_WIDTH - 1 : 0] rs1_addr_wire;
  logic [REG_ADDR_WIDTH - 1 : 0] rs2_addr_wire;
  logic [REG_ADDR_WIDTH - 1 : 0] rd_addr_wire;
  logic [    DATA_WIDTH - 1 : 0] imm_wire;
  logic [                 9 : 0] ALU_ctrl_wire;
  logic                          alu_use_imm_wire;
  logic                          jmp_imm_wire;


  decode #(
      .DATA_WIDTH(DATA_WIDTH),
      .ADDR_WIDTH(ADDR_WIDTH),
      .REG_ADDR_WIDTH(REG_ADDR_WIDTH)
  ) decode_inst (
      .clk(clk),
      .inst(inst),
      .rs1_addr(rs1_addr_wire),
      .rs2_addr(rs2_addr_wire),
      .rd_addr(rd_addr_wire),
      .imm(imm_wire),
      .ALU_ctrl(ALU_ctrl_wire),
      .alu_use_imm(alu_use_imm_wire),
      .jmp_imm(jmp_imm_wire)
  );

endmodule
