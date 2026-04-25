

module rom #(
    parameter int DATA_WIDTH = 32,
    parameter int ADDR_WIDTH = 32
) (
    input  [ADDR_WIDTH - 1 : 0] addr,
    output [DATA_WIDTH - 1 : 0] data
);

  logic [DATA_WIDTH - 1 : 0] rom_arr[2**ADDR_WIDTH] = '{default: '{default: '0}};

  assign data = rom_arr[addr];

endmodule
