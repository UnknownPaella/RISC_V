

module RISC_V_top (
    input clk
);

  memory #(
      .DATA_WIDTH(DATA_WIDTH),
      .ADDR_WIDTH(ADDR_WIDTH)
  ) memory_inst (
      .clk(clk),
      .rst(rst),
      .prog_cnt_en(prog_cnt_en),
      .imm_addr(imm_addr),
      .imm_wr(imm_wr),
      .inst_out(inst_out)
  );

  control # (
    .DATA_WIDTH(DATA_WIDTH),
    .ADDR_WIDTH(ADDR_WIDTH),
    .REG_ADDR_WIDTH(REG_ADDR_WIDTH)
  )
  control_inst (
    .clk(clk),
    .inst(inst),
    .rs1_addr(rs1_addr),
    .rs2_addr(rs2_addr),
    .rd_addr(rd_addr),
    .imm(imm),
    .funct3(funct3),
    .funct7(funct7)
  );

  registers #(
      .DATA_WIDTH(DATA_WIDTH),
      .ADDR_WIDTH(ADDR_WIDTH),
      .REG_ADDR_WIDTH(REG_ADDR_WIDTH)
  ) registers_inst (
      .clk(clk),
      .rst(rst),
      .rd_data(rd_data),
      .rd_addr(rd_addr),
      .rs1_addr(rs1_addr),
      .rs2_addr(rs2_addr),
      .rs1_data(rs1_data),
      .rs2_data(rs2_data)
  );

  ALU #(
      .DATA_WIDTH(DATA_WIDTH),
      .ADDR_WIDTH(ADDR_WIDTH),
      .IMM_WIDTH(IMM_WIDTH),
      .REG_ADDR_WIDTH(REG_ADDR_WIDTH)
  ) ALU_inst (
      .clk(clk),
      .rs1_data(rs1_data),
      .rs2_data(rs2_data),
      .imm(imm),
      .enable(enable),
      .funct3(funct3),
      .subOrSra(subOrSra),
      .rd_data(rd_data),
      .alu_status(alu_status),
      .done(done)
  );

endmodule
