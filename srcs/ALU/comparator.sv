`include "../other/RV_inst_types.sv"
`include "../other/RV32I_list.sv"
import RV32I_list::*;

module comparator #(
    parameter int DATA_WIDTH = 32
) (
    input clk,
    input [2 : 0] funct3,  // unsigned = 0, signed = 1
    input [DATA_WIDTH - 1 : 0] a,
    input [DATA_WIDTH - 1 : 0] b,
    output res
);

  logic [DATA_WIDTH - 1 : 0] a_reg;
  logic [DATA_WIDTH - 1 : 0] b_reg;

  logic [DATA_WIDTH - 1 : 0] res_reg;

  always_ff @(posedge clk) begin
    if (sign == 0) begin  // unsigned compare
      if (a_reg < b_reg) begin
        res_reg[0] <= 1;
      end else begin
        res_reg[0] <= 0;
      end
    end else begin
      if ($signed(a_reg) < $signed(b_reg)) begin
        res_reg[0] <= 1;
      end else begin
        res_reg[0] <= 0;
      end
    end
    res_reg[DATA_WIDTH-1 : 1] <= 0;
  end

  assign res = res_reg;

endmodule
