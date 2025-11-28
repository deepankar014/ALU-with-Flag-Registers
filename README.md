# Pipelined 8-Bit ALU (Verilog + GDSII)

## Project Summary

This project presents the design and implementation of a high-performance pipelined 8-bit Arithmetic Logic Unit (ALU) using Verilog HDL. The architecture follows a structured RTL-to-GDSII workflow, utilizing open-source VLSI tools for synthesis, placement, routing, and layout generation. The final design successfully produces a verified GDSII file suitable for fabrication.

The work highlights the complete ASIC design cycle, starting from RTL coding and simulation to physical layout verification.

---

## Key Highlights

* 3-stage pipelined ALU structure for improved throughput
* Configurable data width (default set to 8-bit)
* Supports arithmetic and logical functions
* Status flags implemented: Zero, Carry, Negative, Overflow
* Fully synthesizable and compatible with OpenLane flow
* Layout verified using Magic and KLayout

---

## ALU Functionality

| Opcode | Operation | Description     |
| ------ | --------- | --------------- |
| 000    | ADD       | Result = A + B  |
| 001    | SUB       | Result = A - B  |
| 010    | AND       | Bitwise AND     |
| 011    | OR        | Bitwise OR      |
| 100    | XOR       | Bitwise XOR     |
| 101    | NOT A     | Inverts input A |
| 110    | NOT B     | Inverts input B |
| 111    | NOP       | No operation    |

---

## Status Flags

* Z – Indicates zero result
* C – Carry output
* N – Sign indicator for negative result
* V – Overflow detection

---

## Pipeline Structure

To enhance timing and performance, the ALU is divided into three clocked stages:

| Stage   | Function                      | Registers                  |
| ------- | ----------------------------- | -------------------------- |
| Stage 1 | Input capturing               | A_reg, B_reg, opcode_reg   |
| Stage 2 | Computation & flag generation | result_reg, c_temp, v_temp |
| Stage 3 | Output stabilization          | z_reg, n_reg               |

This staged approach ensures reliable signal propagation and better timing closure in post-synthesis implementation.

---

## Simulation Flow

Simulation can be carried out using Icarus Verilog:

Compile:

```
iverilog -o alu_sim ALU.v testbench.v
```

Execute:

```
vvp alu_sim
```

Waveform View:

```
gtkwave alu.vcd
```

The testbench allows expansion for exhaustive opcode and flag verification.

---

## Physical Design Workflow

### Synthesis (Yosys)

```
yosys -s synth.ys
```

### OpenLane Implementation

```
./flow.tcl -design ALU -tag final_run -overwrite
```

### Layout Verification

* DRC and LVS checks performed using Magic
* Final GDSII inspected in KLayout

---

## Layout Preview

Screenshots can be included here to showcase different stages:

* Post-Placement (OpenLane)
* Post-Routing (OpenLane)
* Final GDSII View (KLayout)

(Replace with your actual image files.)

---

## Learning Outcomes

* Implemented a pipelined ALU using Verilog HDL
* Gained hands-on experience with flag logic and register staging
* Completed full ASIC flow using open-source tools
* Developed understanding of RTL-to-GDSII design methodology

---

## Future Improvements

* Scale design to 16-bit or 32-bit width
* Incorporate multiplication and division operations
* Integrate ALU into a RISC-based processor pipeline
* Implement faster adder architectures (CLA)

---

## Author

**Deepankar Maji**
Electronics and Communication Engineering Student
Focus Areas: VLSI Design, Digital Systems, and ASIC Development
