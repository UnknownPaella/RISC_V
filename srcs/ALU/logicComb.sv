`include "../other/RV_inst_types.sv"
`include "../other/RV32I_list.sv"
import RV32I_list::*;
import ALU_ops::*;

module logicComb #(
    parameter int DATA_WIDTH = 32
) (
    input clk,
    input [DATA_WIDTH - 1 : 0] a,
    input [DATA_WIDTH - 1 : 0] b,
    input [9 : 0] logicFunct,
    output [DATA_WIDTH - 1 : 0] f
);

  logic [DATA_WIDTH - 1 : 0] a_reg = 0;
  logic [DATA_WIDTH - 1 : 0] b_reg = 0;

  logic [DATA_WIDTH - 1 : 0] f_reg = 0;

  always_ff @(posedge clk) begin
    a_reg <= a;
    b_reg <= b;
    case (logicFunct)
      XOR: f_reg <= a_reg ^ b_reg;
      OR:  f_reg <= a_reg | b_reg;
      AND: f_reg <= a_reg & b_reg;
      default: f_reg <= a_reg;
    endcase

  end

endmodule
