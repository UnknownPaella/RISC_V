
package RV32I_list;

  // RV32I opcodes
  parameter bit RV32I_REG = 7'b0110011; // R_INST
  parameter bit RV32I_IMM = 7'b0010011; // I_INST
  parameter bit RV32I_LDR = 7'b0000011; // I_INST
  parameter bit RV32I_STR = 7'b0100011; // S_INST
  parameter bit RV32I_BRH = 7'b1100011; // B_INST
  parameter bit RV32I_JAL = 7'b1101111; // J_INST
  parameter bit RV32I_JLR = 7'b1100111; // I_INST
  parameter bit RV32I_ENV = 7'b1110011; // I_INST
  parameter bit RV32I_LUI = 7'b0110111; // U_INST
  parameter bit RV32I_AUI = 7'b0010111; // U_INST

  // RV32I_REG
  parameter bit ADDSUB_FN3 = 3'b000;  // ADD/SUB
  parameter bit XOR_FN3 = 3'b100;  // XOR
  parameter bit OR_FN3 = 3'b110;  // OR
  parameter bit AND_FN3 = 3'b111;  // AND
  parameter bit SLL_FN3 = 3'b001;  // Shift Left Logical
  parameter bit SR_FN3 = 3'b101;  // Shift Right Logical/Arithmetic
  parameter bit SLT_FN3 = 3'b010;  // Set Less Than
  parameter bit SLTU_FN3 = 3'b011;  // Set Less Than (Unsigned)

  parameter bit ADD_FN7 = 7'b0000000;  // ADD
  parameter bit SUB_FN7 = 7'b0100000;  // SUB
  parameter bit XOR_FN7 = 7'b0000000;  // XOR
  parameter bit OR_FN7 = 7'b0000000;  // OR
  parameter bit AND_FN7 = 7'b0000000;  // AND
  parameter bit SLL_FN7 = 7'b0000000;  // Shift Left Logical
  parameter bit SRL_FN7 = 7'b0000000;  // Shift Right Logical
  parameter bit SRA_FN7 = 7'b0100000;  // Shift Right Arithmetic
  parameter bit SLT_FN7 = 7'b0000000;  // Set Less Than
  parameter bit SLTU_FN7 = 7'b0000000;  // Set Less Than (Unsigned)

  // RV32I_IMM
  parameter bit ADDSUBI_FN3 = 3'b000;  // ADD/SUB immediate
  parameter bit XORI_FN3 = 3'b100;  // XOR immediate
  parameter bit ORI_FN3 = 3'b110;  // OR immediate
  parameter bit ANDI_FN3 = 3'b111;  // AND immediate
  parameter bit SLLI_FN3 = 3'b001;  // Shift Left Logical immediate
  parameter bit SRI_FN3 = 3'b101;  // Shift Right Logical/Arithmetic immediate
  parameter bit SLTI_FN3 = 3'b010;  // Set Less Than immediate
  parameter bit SLTIU_FN3 = 3'b011;  // Set Less Than immediate (Unsigned)

  parameter bit SLLI_FN7 = 7'b0000000;  // Shift Left Logical immediate
  parameter bit SRLI_FN7 = 7'b0000000;  // Shift Right Logical immediate
  parameter bit SRAI_FN7 = 7'b0100000;  // Shift Right Arithmetic immediate

  // RV32I_LDR
  parameter bit LBS_FN3 = 3'b000;  // Load Byte (signed)
  parameter bit LHS_FN3 = 3'b001;  // Load Half Byte (signed)
  parameter bit LWS_FN3 = 3'b010;  // Load Word (signed)
  parameter bit LBU_FN3 = 3'b100;  // Load Byte (unsigned)
  parameter bit LHU_FN3 = 3'b101;  // Load Half Byte (unisgned)

  // RV32I_STR
  parameter bit SB_FN3 = 3'b000;  // Store Byte (signed)
  parameter bit SH_FN3 = 3'b001;  // Store Half Byte (signed)
  parameter bit SW_FN3 = 3'b010;  // Store Word (signed)

  // RV32I_BRH
  parameter bit BEQ_FN3 = 3'b000;  // Branch ==
  parameter bit BNE_FN3 = 3'b001;  // Branch !=
  parameter bit BLT_FN3 = 3'b010;  // Branch <
  parameter bit BGE_FN3 = 3'b100;  // Branch >=
  parameter bit BLTU_FN3 = 3'b101;  // Branch < (unsigned)
  parameter bit BGEU_FN3 = 3'b101;  // Branch >= (unsigned)

  // RV32I_JMP
  parameter bit JALR_FN3 = 3'b000;  // Jump And Link Register

  // RV32I_ENV
  parameter bit ECALL_FN3 = 3'b000;  // Environment Call (transfer ctrl to OS)
  parameter bit EBREAK_FN3 = 3'b000;  // Environment Break (transfer ctrl to debugger)
  parameter bit ECALL_FN7 = 7'b0000000;  // Environment Call (transfer ctrl to OS)
  parameter bit EBREAK_FN7 = 7'b0000001;  // Environment Break (transfer ctrl to debugger)


endpackage
