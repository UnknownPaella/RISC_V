
import RV32I_list::*;
import ALU_ops::*;

module ALU #(
    parameter int DATA_WIDTH = 32,
    parameter int ADDR_WIDTH = 32,
    parameter int IMM_WIDTH = 32,
    parameter int REG_ADDR_WIDTH = 5
) (
    input clk,
    input [DATA_WIDTH - 1 : 0] rs1_data,
    input [DATA_WIDTH - 1 : 0] rs2_data,
    input [IMM_WIDTH - 1 : 0] imm,
    input enable,
    input [9 : 0] ALU_ctrl,
    output [DATA_WIDTH - 1 : 0] rd_data,
    output alu_status,
    output done

);

  logic [DATA_WIDTH - 1 : 0] imm_reg = 0;  // sign-extended immediate for arithmetic
  logic [DATA_WIDTH - 1 : 0] rs1_data_reg;  // rs1 hold register
  logic [DATA_WIDTH - 1 : 0] rs2_data_reg;  // rs2 hold register
  logic [DATA_WIDTH - 1 : 0] addr_out_reg;  // adder output register

  logic addOrSub = 0;

  logic shift_dir = 0;
  logic shift_logicOrArith = 0;
  logic [4 : 0] shamt = 0;
  logic [DATA_WIDTH - 1 : 0] shifter_out_reg = 0;

  logic [DATA_WIDTH - 1 : 0] logicComb_out_reg = 0;

  logic signComp = 0;
  logic [DATA_WIDTH - 1 : 0] comp_out_reg = 0;

  logic [DATA_WIDTH - 1 : 0] rd_data_reg = 0;

  always_ff @(posedge clk) begin : sign_extend_immediate
    if (enable) begin
      imm_reg <= imm;
    end
  end

  always_ff @(posedge clk) begin : load_regs
    if (enable) begin
      rs1_data_reg <= rs1_data;
      rs2_data_reg <= rs2_data;
    end
  end

  always @(ALU_ctrl) begin : ALU_decode
    case (ALU_ctrl)
      ADD, SUB: begin  // adder output
        case (ALU_ctrl)
          ADD: addOrSub <= 0;
          SUB: addOrSub <= 1;
          default: addOrSub <= 0;
        endcase

        rd_data_reg <= adder_out_reg;

      end
      XOR, OR, AND: begin  // logic unit output
        rd_data_reg <= logicComb_out_reg;
      end
      SLL, SRL, SRA: begin  // shifter output
        case (ALU_ctrl)
          SLL: begin
            shift_dir <= 0;
            shift_logicOrArith <= 0;
          end
          SRL: begin
            shift_dir <= 1;
            shift_logicOrArith <= 0;
          end
          SRA: begin
            shift_dir <= 1;
            shift_logicOrArith <= 1;
          end
          default: begin
            shift_dir <= 0;
            shift_logicOrArith <= 0;
          end
        endcase

        rd_data_reg <= shifter_out_reg;
      end
      SLT, SLTU: begin  // comparator output
        case (ALU_ctrl)
          SLT: signComp <= 0;
          SLTU: signComp <= 1;
          default: signComp <= 0;
        endcase

        rd_data_reg <= comp_out_reg;
      end
      default: ;
    endcase
  end

  // adding and subtracting module
  // requires 2 cycles
  adder #(
      .DATA_WIDTH(DATA_WIDTH)
  ) adder_inst (
      .clk(clk),
      .a(rs1_data_reg),
      .b(rs2_data_reg),
      .addOrSub(addOrSub),
      .f(adder_out_reg)
  );

  // shift left/right logical/arithmetic module
  // requires 2 cycles
  shifter #(
      .DATA_WIDTH(DATA_WIDTH)
  ) shifter_inst (
      .clk(clk),
      .shift_dir(shift_dir),
      .logicOrArith(shift_logicOrArith),
      .shamt(shamt),
      .sh_data(rs1_data_reg),
      .sh_output(shifter_out_reg)
  );

  logicComb #(
      .DATA_WIDTH(DATA_WIDTH)
  ) logicComb_inst (
      .clk(clk),
      .a(rs1_data_reg),
      .b(rs2_data_reg),
      .logicFunct(ALU_ctrl),
      .f(logicComb_out_reg)
  );

  comparator #(
      .DATA_WIDTH(DATA_WIDTH)
  ) comparator_inst (
      .clk(clk),
      .sign(signComp),
      .a(rs1_data_reg),
      .b(rs2_data_reg),
      .res(comp_out_reg)
  );

endmodule
