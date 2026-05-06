`include "./register.sv"

module registers #(
    parameter int DATA_WIDTH = 32,
    parameter int ADDR_WIDTH = 32,
    localparam int REG_ADDR_WIDTH = $clog2(ADDR_WIDTH)
) (
    input clk,
    input rst,
    input [DATA_WIDTH - 1 : 0] rd_data, // destination register data
    input [REG_ADDR_WIDTH - 1 : 0] rd_addr, // destination register address
    input [REG_ADDR_WIDTH - 1 : 0] rs1_addr, // source register 1 address
    input [REG_ADDR_WIDTH - 1 : 0] rs2_addr, // source register 2 address
    output [DATA_WIDTH - 1 : 0] rs1_data, // source register 1 data
    output [DATA_WIDTH - 1 : 0] rs2_data // source register 2 data
);

  logic [REG_ADDR_WIDTH - 1 : 0] reg_en = 0;

  logic [DATA_WIDTH - 1 : 0] reg_arr[ADDR_WIDTH];

  genvar i;
  generate

    for (i = 0; i < ADDR_WIDTH; i++) begin : g_register_array

      // contents of x0 register is fixed to zeroes
      assign reg_en[i] = i == 0 ? 0 : (rd_addr == i);

      register #(
          .DATA_WIDTH(DATA_WIDTH),
          .INIT_VAL  (0)
      ) register_inst (
          .clk(clk),
          .rst(rst),
          .data_in(rd_data),
          .en(reg_en[i]),
          .data_out(reg_arr[i])
      );

    end

  endgenerate

  assign rs1_data = reg_arr[rs1_addr];
  assign rs2_data = reg_arr[rs2_addr];

endmodule
