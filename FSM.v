`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Plan B
// Module Name:    FSM 
// Description: FSM is a finite state machine which creates the first 15 numbers
//      in the fibonacci sequence
//
//////////////////////////////////////////////////////////////////////////////////
module FSM(
	 input clk,
	 input clr,
	 input [3:0] ext_input,
   output reg selectImm,
	output reg[4:0] loadReg,
   output reg[3:0] readRegA, readRegB,
   output reg[7:0] Imm, op
    );
	 

	 // Give names to states
	 parameter State0 = 0; parameter State1 = 1;
	 parameter State2 = 2; parameter State3 = 3; 
	 parameter State4 = 4; parameter State5 = 5;
	 parameter State6 = 6; parameter State7 = 7;
	 parameter State8 = 8; parameter State9 = 9;
	 parameter State10 = 10; parameter State11 = 11;
	 parameter State12 = 12; parameter State13 = 13;
	 parameter State14 = 14; parameter State15 = 15;
	 parameter State16 = 16;

   parameter ADD = 8'b00000101;
	parameter ADDI = 8'b01010000;
   parameter OR = 8'b00000010;

	 // Declare states
	 reg [5:0] PS, NS;

	// Output 
	always@(PS, ext_input) begin
		case(PS)
			State0 : begin
			  // load 1 into r0 
			  selectImm = 1'b1;
			  loadReg = 5'b00000; 
			  readRegA = 4'b0010;
			  readRegB = 4'b0010;
			  Imm = 8'b00000001;
			  op = ADDI;
			end
			State1 : begin
			  // Load 1 into r1
			  selectImm = 1'b1;
			  loadReg = 5'b00001; 
			  readRegA = 4'b0010;
			  readRegB = 4'b0010;
			  Imm = 8'b00000001;
			  op = ADDI;
			end
			State2 : begin
			  // r2 = r1 + r0
			  // 2  = 1  + 1
			  selectImm = 1'b0;
			  loadReg = 5'b00010; 
			  readRegA = 4'b0001;
			  readRegB = 4'b0000;
			  Imm = 8'b00000000;
			  op = ADD;
			end
			State3 : begin
			  // r3 = r2 + r1
			  // 3  = 2  + 1
			  selectImm = 1'b0;
			  loadReg = 5'b00011; 
			  readRegA = 4'b0010;
			  readRegB = 4'b0001;
			  Imm = 8'b00000000;
			  op = ADD;
			end
			State4 : begin
			  // r4 = r3 + r2
			  // 5  = 3  + 2
			  selectImm = 1'b0;
			  loadReg = 5'b00100; 
			  readRegA = 4'b0011;
			  readRegB = 4'b0010;
			  Imm = 8'b00000000;
			  op = ADD;
			end
			State5 : begin
			  // r5 = r4 + r3
			  // 8  = 5  + 3
			  selectImm = 1'b0;
			  loadReg = 5'b00101; 
			  readRegA = 4'b0100;
			  readRegB = 4'b0011;
			  Imm = 8'b00000000;
			  op = ADD;
			end
			State6 : begin
			  // r6 = r5 + r4
			  // 13 = 8  + 5
			  selectImm = 1'b0;
			  loadReg = 5'b00110; 
			  readRegA = 4'b0101;
			  readRegB = 4'b0100;
			  Imm = 8'b00000000;
			  op = ADD;
			end
			State7 : begin
			  // r7 = r6 + r5
			  // 21 = 13 + 8
			  selectImm = 1'b0;
			  loadReg = 5'b00111; 
			  readRegA = 4'b0110;
			  readRegB = 4'b0101;
			  Imm = 8'b00000000;
			  op = ADD;
			end
			State8 : begin
			  // r8 = r7 + r6
			  // 34 = 21 + 13
			  selectImm = 1'b0;
			  loadReg = 5'b01000; 
			  readRegA = 4'b0111;
			  readRegB = 4'b0110;
			  Imm = 8'b00000000;
			  op = ADD;
			end
			State9 : begin
			  // r9 = r8 + r7
			  // 55 = 34 + 21
			  selectImm = 1'b0;
			  loadReg = 5'b01001; 
			  readRegA = 4'b1000;
			  readRegB = 4'b0111;
			  Imm = 8'b00000000;
			  op = ADD;
			end
			State10 : begin
			  // r10 = r9 + r8
			  // 89 = 55 + 34
			  selectImm = 1'b0;
			  loadReg = 5'b01010; 
			  readRegA = 4'b1001;
			  readRegB = 4'b1000;
			  Imm = 8'b00000000;
			  op = ADD;
			end
			State11 : begin
			  // r11 = r10 + r9
			  // 144 = 89  + 55
			  selectImm = 1'b0;
			  loadReg = 5'b01011; 
			  readRegA = 4'b1010;
			  readRegB = 4'b1001;
			  Imm = 8'b00000000;
			  op = ADD;
			end
			State12 : begin
			  // r12 = r11 + r10
			  // 233 = 144 + 89
			  selectImm = 1'b0;
			  loadReg = 5'b01100; 
			  readRegA = 4'b1011;
			  readRegB = 4'b1010;
			  Imm = 8'b00000000;
			  op = ADD;
			end
			State13 : begin
			  // r13 = r12 + r11
			  // 377 = 233 + 144
			  selectImm = 1'b0;
			  loadReg = 5'b01101; 
			  readRegA = 4'b1100;
			  readRegB = 4'b1011;
			  Imm = 8'b00000000;
			  op = ADD;
			end
			State14 : begin
			  // r14 = r13 + r12
			  // 610 = 377 + 233
			  selectImm = 1'b0;
			  loadReg = 5'b01110; 
			  readRegA = 4'b1101;
			  readRegB = 4'b1100;
			  Imm = 8'b00000000;
			  op = ADD;
			end
			State15 : begin
			  // r15 = r14 + r13
			  // 987 = 610 + 377
			  selectImm = 1'b0;
			  loadReg = 5'b01111; 
			  readRegA = 4'b1110;
			  readRegB = 4'b1101;
			  Imm = 8'b00000000;
			  op = ADD;
			end
			State16 : begin
				// State16 is the final state in the Controller.
				// ext_input determines which register value to display on the 7 segment displays.
				// values of 0-15 on ext_input selects r0-r15
				selectImm = 1'b0;
				loadReg = 5'b10000;
				readRegA = ext_input;
				readRegB = ext_input;
				Imm = 8'b00000000;
				op = OR;
			end
			default: begin 
			  // r15 = r15 | r15
			  // 1597= 1597| 1597
			  selectImm = 1'b0;
			  loadReg = 5'b11111; 
			  readRegA = 4'b1111;
			  readRegB = 4'b1111;
			  Imm = 8'b00000000;
			  op = OR;
			end
		endcase
	end

	// Present state
	always@(posedge clk) begin
			if (clr)
				PS <= State0;
			else 
				PS <= NS;
	end
		
		// Next state
	always@(PS)
		case(PS)
			State0 : NS = State1;
			State1 : NS = State2;
			State2 : NS = State3;
			State3 : NS = State4;
			State4 : NS = State5;
			State5 : NS = State6;
			State6 : NS = State7;
			State7 : NS = State8;
			State8 : NS = State9;
			State9 : NS = State10;
			State10 : NS = State11;
			State11 : NS = State12;
			State12 : NS = State13;
			State13 : NS = State14;
			State14 : NS = State15;
			State15 : NS = State16;
			State16 : NS = State16;
			default : NS = State0;
		endcase
				
endmodule
