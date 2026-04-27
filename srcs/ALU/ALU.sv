

module ALU #(
    parameter int DATA_WIDTH = 32,
    parameter int ADDR_WIDTH = 32,
    localparam int REG_ADDR_WIDTH = $clog2(ADDR_WIDTH)
) (
    input clk,
    input [ADDR_WIDTH - 1 : 0] inst,
    input [DATA_WIDTH - 1 : 0] rs1_data,
    input [DATA_WIDTH - 1 : 0] rs2_data,
    output [REG_ADDR_WIDTH - 1 : 0] rs1_data,
    output [REG_ADDR_WIDTH - 1 : 0] rs2_data

);



endmodule
