

module memory #(
    parameter int DATA_WIDTH = 32,
    parameter int ADDR_WIDTH = 32
) (
    input clk,
    input rst,
    input [ADDR_WIDTH - 1 : 0] addr,
    input prog_cnt_en,
    input [ADDR_WIDTH - 1 : 0] imm_addr,
    input imm_wr,
    output [DATA_WIDTH - 1 : 0] inst_out
);

  logic [ADDR_WIDTH - 1 : 0] PC = 0;
  logic [ADDR_WIDTH - 1 : 0] CAR = 0;

  logic [DATA_WIDTH - 1 : 0] MDR = 0;
  logic [DATA_WIDTH - 1 : 0] MDR_wire = 0;
  logic [DATA_WIDTH - 1 : 0] CIR = 0;

  always_ff @(posedge clk, posedge rst) begin : program_counter
    if (rst) begin
      PC <= 0;
    end else begin
      if (imm_wr) begin
        PC <= imm_addr;
      end else if (prog_cnt_en) begin
        PC <= PC + 1;
      end
    end

  end

  always_ff @(posedge clk, posedge rst) begin : mem_addr
    if (rst) begin
      CAR <= 0;
      MDR <= 0;
      CIR <= 0;
    end else begin
      CAR <= PC;
      MDR <= MDR_wire;
      CIR <= MDR;
    end

  end

  assign inst_out = CIR;

  rom #(
      .DATA_WIDTH(DATA_WIDTH),
      .ADDR_WIDTH(ADDR_WIDTH)
  ) rom_inst (
      .addr(CAR),
      .data(MDR_wire)
  );


endmodule
