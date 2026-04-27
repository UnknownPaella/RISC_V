

module registers #(
    parameter int DATA_WIDTH = 32,
    parameter int ADDR_WIDTH = 32,
    localparam int REG_ADDR_WIDTH = $clog2(ADDR_WIDTH)
) (
    input clk,
    inout [DATA_WIDTH - 1 : 0] data,
    input [REG_ADDR_WIDTH - 1 : 0] reg_wr_addr,
    input [REG_ADDR_WIDTH - 1 : 0] reg_rd_addr
);

  logic [REG_ADDR_WIDTH - 1] reg_wr = 0;
  logic [REG_ADDR_WIDTH - 1] reg_rd = 0;

  genvar i;
  generate

    for (i = 0; i < ADDR_WIDTH; i++) begin : g_register_array

      // contents of x0 register is fixed to zeroes
      assign reg_wr[i] = i == 0 ? 0 : (reg_wr_addr == i);
      assign reg_rd[i] = (reg_rd_addr == i);

      register #(
          .DATA_WIDTH(DATA_WIDTH),
          .INIT_VAL  (0)
      ) register_inst (
          .clk(clk),
          .data_in(data),
          .wr(reg_wr[i]),
          .rd(reg_rd[i]),
          .data_out(data)
      );

    end

  endgenerate

endmodule
