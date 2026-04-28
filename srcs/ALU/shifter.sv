
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

  logic [DATA_WIDTH - 1 : 0] sh_out_reg;

  always_ff @(posedge clk) begin
    if (shift_dir == 0) begin
      sh_out_reg <= sh_data << shamt;
    end else begin
      if (logicOrArith == 0) begin
        sh_out_reg <= sh_data >> shamt;
      end else begin
        sh_out_reg <= sh_data >>> shamt;
      end
    end
  end

  assign sh_output = sh_out_reg;

endmodule
