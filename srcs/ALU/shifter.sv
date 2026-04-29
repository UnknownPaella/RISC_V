
module shifter #(
    parameter int DATA_WIDTH = 32
) (
    input clk,
    input shift_dir,  // 0 = left, 1 = right
    input logicOrArith,  // 0 = logical shift, 1 = arithmetic shift
    input [4 : 0] shamt,
    input [DATA_WIDTH - 1 : 0] sh_data,
    output [DATA_WIDTH - 1 : 0] sh_output
);

  logic [DATA_WIDTH - 1 : 0] sh_in_reg;
  logic [4 : 0] shamt_reg;
  logic [DATA_WIDTH - 1 : 0] sh_left_reg;
  logic [DATA_WIDTH - 1 : 0] sh_right_reg;
  logic [DATA_WIDTH - 1 : 0] sh_out_reg;

  always_ff @(posedge clk) begin

    sh_in_reg   <= sh_data;
    shamt_reg   <= shamt;

    sh_left_reg <= sh_in_reg << shamt_reg;

    if (logicOrArith == 0) begin
      sh_right_reg <= sh_in_reg >> shamt_reg;
    end else begin
      sh_right_reg <= sh_in_reg >>> shamt_reg;
    end

    if (shiftDir == 0) begin
      sh_out_reg <= sh_left_reg;
    end else begin
      sh_out_reg <= sh_right_reg;
    end

  end

  assign sh_output = sh_out_reg;

endmodule
