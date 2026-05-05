

module register #(
    parameter int DATA_WIDTH = 32,
    parameter int INIT_VAL   = 0
) (
    input clk,
    input rst,
    input [DATA_WIDTH - 1 : 0] data_in,
    input en,
    input write,
    input read,
    output logic [DATA_WIDTH - 1 : 0] data_out
);

  reg [DATA_WIDTH - 1 : 0] data_tmp = INIT_VAL;

  always_ff @(posedge clk, posedge rst) begin
    if (rst) begin
      data_tmp <= 0;
    end else if (en) begin
      if (write) begin
        data_tmp <= data_in;
      end
      if (read) begin
        data_out <= data_tmp;
      end else begin
        data_out <= 'Z;
      end
    end

  end

endmodule
