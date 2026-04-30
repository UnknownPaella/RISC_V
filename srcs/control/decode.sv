
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
    output [REG_ADDR_WIDTH - 1 : 0] rs2_addr,
    output [REG_ADDR_WIDTH - 1 : 0] rd_addr,
    output [DATA_WIDTH - 1 : 0] imm,
    output [2 : 0] funct3,
    output [6 : 0] funct7,
    output [11 : 0] funct12
);

  localparam bit IMM_START = 31;  // also start of funct7
  localparam bit IMM_END = 25;  // also end of funct7

  localparam bit RS2_START = 24;
  localparam bit RS2_END = 20;  // also end of imm[11 : 0]

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
  logic [DATA_WIDTH - 1 : 0] imm_reg = 0;
  logic [4 : 0] rs1_addr_reg = 0;
  logic [4 : 0] rs2_addr_reg = 0;
  logic [4 : 0] rd_addr_reg = 0;
  logic [2 : 0] funct3_reg = 0;
  logic [11 : 0] funct12_reg = 0;


  always_ff @(posedge clk) begin : inst_decode
    case (inst_opcode)
      RV32I_REG: begin  // R-type inst
        funct7 <= inst[IMM_START : IMM_END];
        rs2_addr_reg <= inst[RS2_START : RS2_END];
        rs1_addr_reg <= inst[RS1_START : RS1_END];
        funct3_reg <= inst[FN3_START : FN3_END];
        rd_addr_reg <= inst[RD_START : RD_END];

        imm_reg <= 0;
      end
      RV32I_IMM: begin  // I-type inst
        imm_reg[11 : 0] <= inst[IMM_START : RS2_END];
        rs1_addr_reg <= inst[RS1_START : RS1_END];
        funct3_reg <= inst[FN3_START : FN3_END];
        rd_addr_reg <= inst[RD_START : RD_END];

        rs2_addr_reg <= 0;
        funct7 <= 0;

        imm_reg[31 : 12] <= {(31 - 12 + 1){inst[31]}};
      end
      RV32I_LDR: begin  // I-type inst
        imm_reg[11 : 0] <= inst[IMM_START : RS2_END];
        rs1_addr_reg <= inst[RS1_START : RS1_END];
        funct3_reg <= inst[FN3_START : FN3_END];
        rd_addr_reg <= inst[RD_START : RD_END];

        rs2_addr_reg <= 0;
        funct7 <= 0;

        imm_reg[31 : 12] <= {(31 - 12 + 1){inst[31]}};
      end
      RV32I_STR: begin  // S-type inst
        imm_reg[11 : 5] <= inst[IMM_START : IMM_END];
        rs2_addr_reg <= inst[RS2_START : RS2_END];
        rs1_addr_reg <= inst[RS1_START : RS1_END];
        funct3_reg <= inst[FN3_START : FN3_END];
        imm_reg[4 : 0] <= inst[RD_START : RD_END];

        rd_addr_reg <= 0;
        funct7 <= 0;

        imm_reg[31 : 12] <= {(31 - 12 + 1){inst[31]}};
      end
      RV32I_BRH: begin  // B-type inst
        imm_reg[12] <= inst[IMM_START];
        imm_reg[10 : 5] <= inst[IMM_START-1 : IMM_END];
        rs2_addr_reg <= inst[RS2_START : RS2_END];
        rs1_addr_reg <= inst[RS1_START : RS1_END];
        funct3_reg <= inst[FN3_START : FN3_END];
        imm_reg[4 : 1] <= inst[RD_START : RD_END+1];
        imm_reg[11] <= inst[RD_END];
        imm_reg[0] <= 0;

        rd_addr_reg <= 0;
        funct7 <= 0;

        imm_reg[31 : 13] <= {(31 - 13 + 1){inst[31]}};
      end
      RV32I_JAL: begin  // J-type inst
        imm_reg[20] <= inst[IMM_START];
        imm_reg[10 : 1] <= inst[IMM_START-1 : RS2_END+1];
        imm_reg[11] <= inst[RS2_END];
        imm_reg[19 : 12] <= inst[RS1_START : FN3_END];
        rd_addr_reg <= inst[RD_START : RD_END];
        imm_reg[0] <= 0;

        funct7 <= 0;
        rs2_addr_reg <= 0;
        rs1_addr_reg <= 0;
        funct3_reg <= 0;

        imm_reg[31 : 21] <= {(31 - 21 + 1){inst[31]}};
      end
      RV32I_JLR: begin  // I-type inst
        imm_reg[11 : 0] <= inst[IMM_START : RS2_END];
        rs1_addr_reg <= inst[RS1_START : RS1_END];
        funct3_reg <= inst[FN3_START : FN3_END];
        rd_addr_reg <= inst[RD_START : RD_END];

        rs2_addr_reg <= 0;
        funct7 <= 0;

        imm_reg[31 : 12] <= {(31 - 12 + 1){inst[31]}};
      end
      RV32I_ENV: begin  // I-type inst
        funct12_reg  <= inst[IMM_START : RS2_END];
        rs1_addr_reg <= inst[RS1_START : RS1_END];
        funct3_reg   <= inst[FN3_START : FN3_END];
        rd_addr_reg  <= inst[RD_START : RD_END];

        imm_reg <= 0;
      end
      RV32I_LUI: begin  // U-type inst
        imm_reg[31 : 12] <= inst[IMM_START : FN3_END];
        rd_addr_reg <= inst[RD_START : RD_END];

        imm_reg[11 : 0] <= {(11 - 0 + 1){1'b0}};
      end
      RV32I_AUI: begin  // U-type inst
        imm_reg[31 : 12] <= inst[IMM_START : FN3_END];
        rd_addr_reg <= inst[RD_START : RD_END];
      end
      default: ;
    endcase
  end

  assign inst_opcode = inst[OPCODE_START : OPCODE_END];

  assign rs1_addr = rs1_addr_reg;
  assign rs2_addr = rs2_addr_reg;
  assign rd_addr = rd_addr_reg;
  assign funct3 = funct3_reg;
  assign funct7 = funct7_reg;
  assign imm = imm_reg;

endmodule
