import RV32I_list::*;

module logicComb #(
    parameter int DATA_WIDTH = 32
) (
    input clk,
    input [DATA_WIDTH - 1 : 0] a,
    input [DATA_WIDTH - 1 : 0] b,
    input [2 : 0] funct3,
    output [DATA_WIDTH - 1 : 0] f
);

  logic [DATA_WIDTH - 1 : 0] a_reg = 0;
  logic [DATA_WIDTH - 1 : 0] b_reg = 0;

  logic [DATA_WIDTH - 1 : 0] f_reg = 0;

  always_ff @(posedge clk) begin
    a_reg <= a;
    b_reg <= b;
    case (funct3)
      XOR_FN3: f_reg <= a_reg ^ b_reg;
      OR_FN3:  f_reg <= a_reg | b_reg;
      AND_FN3: f_reg <= a_reg & b_reg;
      default: f_reg <= a_reg;
    endcase

  end

endmodule
