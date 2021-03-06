`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Plan B
//
// Module Name:    hexSpeak_with_dataPath 
// Description: hexSpeak_with_dataPath instantiates all modules for Lab 2.
//
//////////////////////////////////////////////////////////////////////////////////
module hexSpeak_with_dataPath(
    input clk,
    input reset,
	 input [3:0] ext_input,
    output [6:0] seg7,
	 output [15:0] A, B, Z,
	 output [4:0] flags,
    output [3:0] select
    );
	 
	wire selectImm;
	wire [3:0] readRegA, readRegB;
	wire [4:0] loadReg;
	wire [7:0] Imm, op;
	
	// Correct input/output ordering for FSM module
	// input clk,
	// input clr,
	// input [3:0] ext_input,
   	// output reg selectImm,
	// output reg[4:0] loadReg,
   	// output reg[3:0] readRegA, readRegB,
   	// output reg[7:0] Imm, op
	hexSpeak_FSM hexSpeak(clk, reset,ext_input, selectImm, loadReg, readRegA, readRegB, Imm, op);
	
	// Correct input/output ordering for datapath module
	//input CLK, CLR, selectImm,
	//input [4:0] loadReg,
	//input [3:0] readRegA, readRegB,
	//input [7:0] Imm, op,
	//output [15:0] A, B, Z,
	//output [4:0] flags
	dataPath data(clk, reset, selectImm, loadReg, readRegA, readRegB, Imm, op, A, B, Z, flags);
	
	// Correct input/output ordering for SSD_decoder module
	//input clk,
	// input clr,
   	// input [15:0] number,
   	// output reg [6:0] ssOut,
   	// output reg [3:0] select
	SSD_decoder decoder(clk, reset, Z, seg7, select);

endmodule
