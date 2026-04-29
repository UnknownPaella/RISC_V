
import RV32I_list::*;

module ALU #(
    parameter int DATA_WIDTH = 32,
    parameter int ADDR_WIDTH = 32,
    parameter int IMM_WIDTH = 12,
    localparam int REG_ADDR_WIDTH = $clog2(ADDR_WIDTH)
) (
    input clk,
    input [DATA_WIDTH - 1 : 0] rs1_data,
    input [DATA_WIDTH - 1 : 0] rs2_data,
    input [IMM_WIDTH - 1 : 0] imm,
    input enable,
    input [2 : 0] funct3,
    input subOrSra,
    output [DATA_WIDTH - 1 : 0] rd_data,
    output alu_status,
    output done

);


  logic [DATA_WIDTH - 1 : 0] imm_ext = 0;  // sign-extended immediate for arithmetic
  logic [DATA_WIDTH - 1 : 0] rs1_data_reg;  // rs1 hold register
  logic [DATA_WIDTH - 1 : 0] rs2_data_reg;  // rs2 hold register
  logic [DATA_WIDTH - 1 : 0] addr_out_reg;  // adder output register

  logic shift_dir = 0;
  logic [4 : 0] shamt = 0;
  logic [DATA_WIDTH - 1 : 0] shifter_out_reg = 0;

  logic [DATA_WIDTH - 1 : 0] logicComb_out_reg = 0;

  logic signComp = 0;
  logic [DATA_WIDTH - 1 : 0] comp_out_reg = 0;

  logic [DATA_WIDTH - 1 : 0] rd_data_reg = 0;

  always_ff @(posedge clk) begin : sign_extend_immediate
    if (enable) begin
      imm_ext[DATA_WIDTH-1 : IMM_WIDTH] <= {(DATA_WIDTH - IMM_WIDTH) {imm[IMM_WIDTH-1]}};
      imm_ext[IMM_WIDTH-1 : 0] <= imm;
    end
  end

  always_ff @(posedge clk) begin : load_regs
    if (enable) begin
      rs1_data_reg <= rs1_data;
      rs2_data_reg <= rs2_data;
    end
  end

  always_ff @(posedge clk) begin : blockName
    case (funct3)
      ADDSUB_FN3, ADDSUBI_FN3: begin // adder output
        rd_data_reg <= adder_out_reg;
      end
      XOR_FN3, XORI_FN3, OR_FN3, ORI_FN3, AND_FN3, ANDI_FN3: begin // logic unit output
        rd_data_reg <= logicComb_out_reg;
      end
      SLL_FN3, SLLI_FN3, SR_FN3, SRI_FN3: begin // shifter output
        rd_data_reg <= shifter_out_reg;
      end
      SLT_FN3, SLTI_FN3, SLTU_FN3, SLTIU_FN3: begin // comparator output
        rd_data_reg <= comp_out_reg;
      end
      default: ;
    endcase
  end

  always @(funct3) begin : comparator_sign
    if (funct3 == SLTU_FN3 || funct3 == SLTIU_FN3) begin
      sign = 0;
    end else if (funct3 == SLT_FN3 || funct3 == SLTI_FN3) begin
      sign = 1;
    end
  end

  // adding and subtracting module
  // requires 2 cycles
  adder #(
      .DATA_WIDTH(DATA_WIDTH)
  ) adder_inst (
      .clk(clk),
      .a(rs1_data_reg),
      .b(rs2_data_reg),
      .addOrSub(subOrSra),
      .f(adder_out_reg)
  );

  // shift left/right logical/arithmetic module
  // requires 2 cycles
  shifter #(
      .DATA_WIDTH(DATA_WIDTH)
  ) shifter_inst (
      .clk(clk),
      .shift_dir(shift_dir),
      .logicOrArith(subOrSra),
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
      .funct3(funct3),
      .f(logicComb_out_reg)
  );

  comparator #(
      .DATA_WIDTH(DATA_WIDTH)
  ) comparator_inst (
      .clk(clk),
      .sign(sign),
      .a(rs1_data_reg),
      .b(rs2_data_reg),
      .res(comp_out_reg)
  );

endmodule
