
import RV32I_list::*;

module ALU #(
    parameter int DATA_WIDTH = 32,
    parameter int ADDR_WIDTH = 32,
    parameter int IMM_WIDTH = 12,
    localparam int REG_ADDR_WIDTH = $clog2(ADDR_WIDTH)
) (
    input clk,
    input [DATA_WIDTH - 1 : 0] rs1_data,
    input [DATA_WIDTH - 1 : 0] rs2_data,
    input [IMM_WIDTH - 1 : 0] imm,
    input enable,
    input [2 : 0] funct3,
    input subOrSra,
    output [REG_ADDR_WIDTH - 1 : 0] rs1_addr,
    output [REG_ADDR_WIDTH - 1 : 0] rs2_addr,
    output alu_status,
    output done

);

  logic [DATA_WIDTH - 1 : 0] imm_ext = 0;  // sign-extended immediate for arithmetic
  logic [DATA_WIDTH - 1 : 0] rs1_data_reg;  // rs1 hold register
  logic [DATA_WIDTH - 1 : 0] rs2_data_reg;  // rs2 hold register
  logic [DATA_WIDTH - 1 : 0] addr_out_reg;  // adder output register

  always_ff @(posedge clk) begin : sign_extend_immediate
    if (enable) begin
      imm_ext[DATA_WIDTH-1 : IMM_WIDTH] <= {(DATA_WIDTH - IMM_WIDTH) {imm[IMM_WIDTH-1]}};
      imm_ext[IMM_WIDTH-1 : 0] <= imm;
    end
  end

  always_ff @(posedge clk) begin : load_regs
    if (enable) begin
      rs1_data_reg <= rs1_data;
      rs2_data_reg <= rs2_data;
    end
  end

  always_ff @(posedge clk) begin : blockName
    if (enable) begin
        
    end
  end

  // adding and subtracting module
  adder #(
      .DATA_WIDTH(DATA_WIDTH)
  ) adder_inst (
      .clk(clk),
      .a(rs1_data_reg),
      .b(rs2_data_reg),
      .addOrSub(subOrSra),
      .f(adder_out_reg)
  );

endmodule
