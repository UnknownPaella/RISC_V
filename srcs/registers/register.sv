

module register #(
    parameter int DATA_WIDTH = 32,
    parameter int INIT_VAL = 0
) (
    input clk,
    input [DATA_WIDTH - 1 : 0] data_in,
    input cs,
    output logic [DATA_WIDTH - 1 : 0] data_out
);

  reg [DATA_WIDTH - 1 : 0] data_tmp = INIT_VAL;

  always_ff @(posedge clk) begin
    if (cs) begin
      data_tmp <= data_in;
    end
  end

  assign data_out = data_tmp;

endmodule
