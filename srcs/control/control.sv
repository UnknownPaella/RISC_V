import RV32I_list::*;

module control #(
    parameter int DATA_WIDTH = 32,
    parameter int ADDR_WIDTH = 32,
    localparam int REG_ADDR_WIDTH = $clog2(ADDR_WIDTH)
) (
    input clk,
    input [ADDR_WIDTH - 1 : 0] inst
);



endmodule
