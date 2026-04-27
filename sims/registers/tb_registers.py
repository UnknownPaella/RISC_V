import cocotb
import logging

from dataclasses import dataclass
from cocotb.triggers import Timer
from cocotb.clock import Clock
from typing import Any


@dataclass
class Register:
    clk: Any
    data: Any
    reg_wr_addr: Any
    reg_rd_addr: Any


async def gen_clk(dut: Register):
    Clock(dut.clk, 1, unit="ns").start()


@cocotb.test()
async def tb_registers(dut: Register):

    cocotb.start_soon(gen_clk(dut))
