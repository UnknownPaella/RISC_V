

module registers #(
    parameter int DATA_WIDTH = 32,
    parameter int ADDR_WIDTH = 32,
    localparam int REG_ADDR_WIDTH = $clog2(ADDR_WIDTH)
) (
    input clk,
    input [DATA_WIDTH - 1 : 0] data_in,
    input [REG_ADDR_WIDTH - 1 : 0] reg_wr_addr,
    input [REG_ADDR_WIDTH - 1 : 0] reg_rd_addr,
    output [DATA_WIDTH - 1 : 0] data_out
);

  logic [REG_ADDR_WIDTH - 1] reg_cs = 0;
  logic [DATA_WIDTH - 1 : 0] reg_data_out_arr[ADDR_WIDTH];

  genvar i;
  generate

    for (i = 0; i < ADDR_WIDTH; i++) begin : g_register_array

      // contents of x0 register is fixed to zeroes
      assign reg_cs[i] = i == 0 ? 0 : (reg_wr_addr == i);

      register #(
          .DATA_WIDTH(DATA_WIDTH),
          .INIT_VAL  (0)
      ) register_inst (
          .clk(clk),
          .data_in(data_in),
          .cs(reg_cs[i]),
          .data_out(reg_data_out_arr[i])
      );

    end

  endgenerate

  assign data_out = reg_data_out_arr[reg_rd_addr];

endmodule
