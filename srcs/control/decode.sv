
import RV_inst_types::*;
import RV32I_list::*;

module decode #(
    parameter int DATA_WIDTH = 32,
    parameter int ADDR_WIDTH = 32,
    localparam int REG_ADDR_WIDTH = $clog2(ADDR_WIDTH)
) (
    input clk,
    input [ADDR_WIDTH - 1 : 0] inst,
    output [REG_ADDR_WIDTH - 1 : 0] rs1_addr,
    output [REG_ADDR_WIDTH - 1 : 0] rs2_addr
);

  localparam bit IMM_11_5_START = 31;  // also start of funct7
  localparam bit IMM_11_5_END = 25;  // also end of funct7

  localparam bit RS2_START = 24;
  localparam bit RS2_END = 20; // also end of imm[11 : 0]

  localparam bit RS1_START = 19;
  localparam bit RS1_END = 15;

  localparam bit FN3_START = 14;
  localparam bit FN3_END = 12;

  localparam bit RD_START = 11;  // also start of imm[4 : 0]
  localparam bit RD_END = 7;  // also end of imm[4 : 0], and imm[11] for B-type

  localparam bit OPCODE_START = 6;
  localparam bit OPCODE_END = 0;

  logic [OPCODE_START : OPCODE_END] inst_opcode;

  logic [6 : 0] funct7_reg = 0;
  logic [19 : 0] imm_reg = 0;
  logic [4 : 0] rs1_reg = 0;
  logic [4 : 0] rs2_reg = 0;
  logic [4 : 0] rsd_reg = 0;
  logic [2 : 0] funct3_reg = 0;


  always_ff @(posedge clk) begin : inst_decode
    case (inst_opcode)
      RV32I_REG: begin

      end
      RV32I_IMM: begin
        imm_reg <= inst[IMM_11_5_START : RS2_END];
        
      end
      RV32I_LDR: begin

      end
      RV32I_STR: begin

      end
      RV32I_BRH: begin

      end
      RV32I_JAL: begin

      end
      RV32I_JLR: begin

      end
      RV32I_ENV: begin

      end
      RV32I_LUI: begin

      end
      RV32I_AUI: begin

      end
      default: ;
    endcase
  end

  assign inst_opcode = inst[OPCODE_START : OPCODE_END];

endmodule
