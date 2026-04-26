
import RV_inst_types::*;

package RV32I_list;

  parameter bit RV32I_REG = {R_INST, 7'b0110011};
  parameter bit RV32I_IMM = {I_INST, 7'b0010011};
  parameter bit RV32I_LDR = {I_INST, 7'b0000011};
  parameter bit RV32I_STR = {S_INST, 7'b0100011};
  parameter bit RV32I_BRH = {B_INST, 7'b1100011};
  parameter bit RV32I_JAL = {J_INST, 7'b1101111};
  parameter bit RV32I_JLR = {I_INST, 7'b1100111};
  parameter bit RV32I_ENV = {I_INST, 7'b1110011};
  parameter bit RV32I_LUI = {U_INST, 7'b0110111};
  parameter bit RV32I_AUI = {U_INST, 7'b0010111};

  parameter bit ADD_FN3 = 3'b000;

endpackage
