

module adder #(
    parameter int DATA_WIDTH = 32
) (
    input clk,
    input [DATA_WIDTH - 1 : 0] a,
    input [DATA_WIDTH - 1 : 0] b,
    input addOrSub,  // 0 = add, 1 = subtract
    output [DATA_WIDTH - 1 : 0] f
);

  logic [DATA_WIDTH - 1 : 0] a_reg = 0;
  logic [DATA_WIDTH - 1 : 0] b_reg = 0;

  logic [DATA_WIDTH - 1 : 0] f_reg = 0;

  always_ff @(posedge clk) begin
    a_reg <= a;

    if (addOrSub == 0) begin
      b_reg <= b;
    end else begin
      b_reg <= (~b) + 1; // twos complement baby (subtraction)
    end

  end

  always_ff @(posedge clk) begin : add
    f_reg <= a_reg + b_reg;
  end

  assign f = f_reg;

endmodule
