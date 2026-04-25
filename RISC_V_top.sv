

module RISC_V_top (
    input clk
);

  registers registers_inst ();

  ALU ALU_inst ();

  memory memory_inst ();

  control control_inst ();

endmodule
