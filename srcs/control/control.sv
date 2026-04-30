import RV32I_list::*;

module control #(
    parameter int DATA_WIDTH = 32,
    parameter int ADDR_WIDTH = 32,
    localparam int REG_ADDR_WIDTH = $clog2(ADDR_WIDTH)
) (
    input clk,
    input [ADDR_WIDTH - 1 : 0] inst,
    output [REG_ADDR_WIDTH - 1 : 0] rs1_addr,
    output [REG_ADDR_WIDTH - 1 : 0] rs2_addr,
    output [REG_ADDR_WIDTH - 1 : 0] rd_addr,
    output [DATA_WIDTH - 1 : 0] imm,
    output [2 : 0] funct3,
    output [6 : 0] funct7
);

  logic [REG_ADDR_WIDTH - 1 : 0] rs1_addr_wire;
  logic [REG_ADDR_WIDTH - 1 : 0] rs2_addr_wire;
  logic [REG_ADDR_WIDTH - 1 : 0] rd_addr_wire;
  logic [DATA_WIDTH - 1 : 0] imm_wire;
  logic [2 : 0] funct3_wire;
  logic [6 : 0] funct7_wire;
  logic [11 : 0] funct12_wire;

  assign rs1_addr = rs1_addr_wire;
  assign rs2_addr = rs2_addr_wire;
  assign rd_addr = rd_addr_wire;
  assign imm = imm_wire;

  assign funct3 = funct3_wire;
  assign funct7 = funct7_wire;

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
      .funct3(funct3_wire),
      .funct7(funct7_wire),
      .funct12(funct12_wire)
  );

endmodule
