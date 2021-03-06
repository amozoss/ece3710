`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
//////////////////////////////////////////////////////////////////////////////////

// This module remembers a set of glyphs for each line.
// 80 glyphs per row, 27 memory addresses*3 = 81, but only 80
// can be displayed.  27 memory addresses*60 total lines = 1620 memory
// addresses for the full screen.
// 4096 memory addresses for this video memory
// 164 for the alphabet as written, so if we start at address 256,
// we stop at 1875
module pixelGen5( CLK, CLR, DEBUG, inst, r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15,
		readRegA, readRegB, loadReg, memAddr, data_addr, data_in, A, B, inst_addr, FLAGS, HPix, VPix, displayColor, textColor, displayBlack, RGB_out, lights );
	input CLK, CLR, DEBUG, lights;
	input [17:0] inst;
	input [15:0] r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15, data_addr, data_in, A, B, inst_addr;
	input [3:0] readRegA, readRegB, loadReg, memAddr;
	input [4:0] FLAGS;
	input [9:0] HPix, VPix;
	input [7:0] displayColor, textColor;
	input displayBlack;
	//input [17:0] gD_out1;
	//output reg [7:0] gAddr1;
	output reg [7:0] RGB_out;

	reg [12:0] addr2;
	reg [12:0] addr1;
	//wire [11:0] addr2;
	wire [17:0] d_out1, d_out2;
	//output [17:0] d_out2;
	//output [17:0] d_out1, d_out2;
	
	reg [17:0] d_in1, d_in2;
	
	reg w1, w2;
	//assign w1 = 0;
	//assign d_in1 = 0;
	//assign d_in2 = 0;

	parameter RTYPE = 4'b0000;
	parameter ADD = 4'b0101;
	parameter ADDU = 4'b0110;
	parameter ADDC = 4'b0111;
	parameter ADDCU = 4'b0100;
	parameter SUB = 4'b1001;
	parameter CMP = 4'b1011;
	parameter AND = 4'b0001;
	parameter OR = 4'b0010;
	parameter XOR = 4'b0011;
	parameter NOT = 4'b1111;
	parameter MOV = 4'b1101;
	
	parameter ADDI = 4'b0101;
	parameter ADDCUI = 4'b1010;
	parameter ADDCI = 4'b0111;
	parameter ADDUI = 8'b0110;
	parameter SUBI = 4'b1001;
	parameter MOVI = 4'b1101;
	parameter LUI = 4'b1111;
	parameter CMPI = 4'b1011;
	parameter CMPUI = 4'b1110;
	
	parameter SHIFT = 4'b1000;
	parameter LSH = 4'b0100;
	parameter LSHI = 4'b0000;
	parameter RSH = 4'b1100;
	parameter RSHI = 4'b0001;
	parameter ALSH = 4'b0101;
	parameter ARSH = 4'b1101;
	
	// MEM is the opcode, JCOND and SCOND are the secondary codes, JUC through BLE are stored in bits [3:0]
	parameter MEM = 4'b0100;
	parameter LOAD = 4'b0000;
	parameter STOR = 4'b0100;
	parameter JCOND = 4'b1100; // JCOND uses unsigned comparison for BEQ through BLT
	parameter JUC = 4'b1110; // JUC jumps directly 
	parameter BEQ = 4'b0000;
	parameter BNEQ = 4'b0001;
	parameter BGT = 4'b0110;
	parameter BLT = 4'b0111;
	parameter BGE = 4'b1101;
	parameter BLE = 4'b1100;
	
	parameter GSTOR = 4'b1100;
		
	debugMemory debug_mem(CLK, w1, addr1, d_in1, d_out1, CLK, w2, addr2, d_in2, d_out2);
	
	reg [7:0] gAddr1;//, gAddr2;
	//reg [17:0] gD_in1;//, gD_in2;
	reg [17:0] gD_out1;//, gD_out2;
	
	reg [17:0] glyph_mem [255:0];
	
	initial begin
		$readmemb("glyphs.mem", glyph_mem);
	end
	
	always @ (posedge CLK) begin
		if (CLR) begin gD_out1 = 18'b0; end
		else begin
			gD_out1 = glyph_mem[gAddr1];
		end
	end
	
//	always @ (posedge CLK) begin
//		if (CLR) begin gD_out2 = 18'b0; end
//		else begin
//			gD_out2 = glyph_mem[gAddr2];
//		end
//	end
	
	//glyphMemory glyph_mem(CLK, gW1, gAddr1, gD_in1, gD_out1, CLK, gW2, gAddr2, gD_in2, gD_out2);
	
	//assign addr1 = (HPix == 0 || VPix == 0) ? 12'b0000000000 : 4*((HPix - 1)/8) + (((VPix - 1) % 8)/2);
	
	// Find a way to set the correct address from the glyph map
	// so HPix 1 VPix 1 starts us with memory address 256
	
	// addr2 will be used to pull glyph row information from d_out2.  d_out2 will
	// be used to generate addr1 for all glyph pixel information to generate
	// RGB_out from d_out1
	
	// So, addr2 can be calculated by finding (HPix - 1) / 24 to get the first and second VPix rows,
	// but VPix will also have to be divided.  (VPix - 1) / 8 will give us the correct row, but we have to
	// multiple the result of that by 27 since there are 27 glyphs per row.
	// Once we add in our starting address, we should be good to go.
	
	// Get the correct glyph address
	 
	always @ (*) begin
		if (VPix > 0 && HPix > 0) begin
			if (DEBUG == 1'b1) begin
				addr2 = (HPix - 1'b1)/5'd24 + ((VPix - 1'b1)/4'd8)*5'd27;
			end
			else begin
				addr2 = 11'd1620 + (HPix - 1'b1)/5'd24 + ((VPix - 1'b1)/4'd8)*5'd27;
			end
		end
		else begin
			addr2 = 14'bz;
		end
	end
	//assign vaddr2 = (HPix - 1'b1)/5'd24 + ((VPix - 1'b1)/4'd8)*5'd27;
	
	// Now that addr2 has been set correctly, we need to get addr1 from d_out2
	// VPix has already been taken into account and ensures that we are on the
	// correct row, but we need to find out which character we are displaying.
	// (HPix - 1) % 24 will give us a number from 0-23 and depending on the
	// result, we can obtain the correct pixel.  Since glyphs consist of 6bits,
	// HPix 0-7 will correspond to the top 6 bits of the 18-bit data, or 17-12
	// HPix 8-15 will correspond to the second 6 bits of the 18-bit data, or 11-6
	// HPix 16-23 will correspond to the last 6 bits of the 18-bit data, or 5-0
	
	// Need to take into account VPix.  2 rows per address, 4 addresses per glyph.
	// Remember to multiply the glyph code by 4 (since each glyph takes up
	// 4 addresses.
	
	reg [5:0] val1, val2, val3, val4, val5, val6;
	
	always @ (*) begin
		if (count == 1 || count == 2) begin
					val1 = inst[17:16] + 1'b1;
					val2 = inst[15:12] + 1'b1;
					val3 = inst[11:8] + 1'b1;
					val4 = inst[7:4] + 1'b1;
					val5 = inst[3:0] + 1'b1;
					val6 = 6'b000000;
			end
			else if (count == 3 || count == 4) begin
					val1 = 1'b0;
					val2 = r0[15:12] + 1'b1;
					val3 = r0[11:8] + 1'b1;
					val4 = r0[7:4] + 1'b1;
					val5 = r0[3:0] + 1'b1;
					val6 = 6'b000000;
			end
			else if (count == 5 || count == 6) begin
					val1 = 1'b0;
					val2 = r1[15:12] + 1'b1;
					val3 = r1[11:8] + 1'b1;
					val4 = r1[7:4] + 1'b1;
					val5 = r1[3:0] + 1'b1;
					val6 = 6'b000000;
			end
			else if (count == 7 || count == 8) begin
					val1 = 1'b0;
					val2 = r2[15:12] + 1'b1;
					val3 = r2[11:8] + 1'b1;
					val4 = r2[7:4] + 1'b1;
					val5 = r2[3:0] + 1'b1;
					val6 = 6'b000000;
			end
			else if (count == 9 || count == 10) begin
					val1 = 1'b0;
					val2 = r3[15:12] + 1'b1;
					val3 = r3[11:8] + 1'b1;
					val4 = r3[7:4] + 1'b1;
					val5 = r3[3:0] + 1'b1;
					val6 = 6'b000000;
			end
			else if (count == 11 || count == 12) begin
					val1 = 1'b0;
					val2 = r4[15:12] + 1'b1;
					val3 = r4[11:8] + 1'b1;
					val4 = r4[7:4] + 1'b1;
					val5 = r4[3:0] + 1'b1;
					val6 = 6'b000000;
			end
			else if (count == 13 || count == 14) begin
					val1 = 1'b0;
					val2 = r5[15:12] + 1'b1;
					val3 = r5[11:8] + 1'b1;
					val4 = r5[7:4] + 1'b1;
					val5 = r5[3:0] + 1'b1;
					val6 = 6'b000000;
			end
			else if (count == 15 || count == 16) begin
					val1 = 1'b0;
					val2 = r6[15:12] + 1'b1;
					val3 = r6[11:8] + 1'b1;
					val4 = r6[7:4] + 1'b1;
					val5 = r6[3:0] + 1'b1;
					val6 = 6'b000000;
			end
			else if (count == 17 || count == 18) begin
					val1 = 1'b0;
					val2 = r7[15:12] + 1'b1;
					val3 = r7[11:8] + 1'b1;
					val4 = r7[7:4] + 1'b1;
					val5 = r7[3:0] + 1'b1;
					val6 = 6'b000000;
			end
			else if (count == 19 || count == 20) begin
					val1 = 1'b0;
					val2 = r8[15:12] + 1'b1;
					val3 = r8[11:8] + 1'b1;
					val4 = r8[7:4] + 1'b1;
					val5 = r8[3:0] + 1'b1;
					val6 = 6'b000000;
			end
			else if (count == 21 || count == 22) begin
					val1 = 1'b0;
					val2 = r9[15:12] + 1'b1;
					val3 = r9[11:8] + 1'b1;
					val4 = r9[7:4] + 1'b1;
					val5 = r9[3:0] + 1'b1;
					val6 = 6'b000000;
			end
			else if (count == 23 || count == 24) begin
					val1 = 1'b0;
					val2 = r10[15:12] + 1'b1;
					val3 = r10[11:8] + 1'b1;
					val4 = r10[7:4] + 1'b1;
					val5 = r10[3:0] + 1'b1;
					val6 = 6'b000000;
			end
			else if (count == 25 || count == 26) begin
					val1 = 1'b0;
					val2 = r11[15:12] + 1'b1;
					val3 = r11[11:8] + 1'b1;
					val4 = r11[7:4] + 1'b1;
					val5 = r11[3:0] + 1'b1;
					val6 = 6'b000000;
			end
			else if (count == 27 || count == 28) begin
					val1 = 1'b0;
					val2 = r12[15:12] + 1'b1;
					val3 = r12[11:8] + 1'b1;
					val4 = r12[7:4] + 1'b1;
					val5 = r12[3:0] + 1'b1;
					val6 = 6'b000000;
			end
			else if (count == 29 || count == 30) begin
					val1 = 1'b0;
					val2 = r13[15:12] + 1'b1;
					val3 = r13[11:8] + 1'b1;
					val4 = r13[7:4] + 1'b1;
					val5 = r13[3:0] + 1'b1;
					val6 = 6'b000000;
			end
			else if (count == 31 || count == 32) begin
					val1 = 1'b0;
					val2 = r14[15:12] + 1'b1;
					val3 = r14[11:8] + 1'b1;
					val4 = r14[7:4] + 1'b1;
					val5 = r14[3:0] + 1'b1;
					val6 = 6'b000000;
			end
			else if (count == 33 || count == 34) begin
					val1 = 1'b0;
					val2 = r15[15:12] + 1'b1;
					val3 = r15[11:8] + 1'b1;
					val4 = r15[7:4] + 1'b1;
					val5 = r15[3:0] + 1'b1;
					val6 = 6'b000000;
			end
			else if (count == 39 || count == 40) begin
				val1 = 1'b0;
				val2 = data_addr[15:12] + 1'b1;
				val3 = data_addr[11:8] + 1'b1;
				val4 = data_addr[7:4] + 1'b1;
				val5 = data_addr[3:0] + 1'b1;
				val6 = 6'b000000;
			end
			else if (count == 41 || count == 42) begin
				val1 = 1'b0;
				val2 = A[15:12] + 1'b1;
				val3 = A[11:8] + 1'b1;
				val4 = A[7:4] + 1'b1;
				val5 = A[3:0] + 1'b1;
				val6 = 6'b000000;
			end
			else if (count == 43 || count == 44) begin
				val1 = 1'b0;
				val2 = B[15:12] + 1'b1;
				val3 = B[11:8] + 1'b1;
				val4 = B[7:4] + 1'b1;
				val5 = B[3:0] + 1'b1;
				val6 = 6'b000000;
			end
			else if (count == 45 || count == 46) begin
				val1 = 1'b0;
				val2 = data_in[15:12] + 1'b1;
				val3 = data_in[11:8] + 1'b1;
				val4 = data_in[7:4] + 1'b1;
				val5 = data_in[3:0] + 1'b1;
				val6 = 6'b000000;
			end
			else if (count == 47 || count == 48) begin
				val1 = 1'b0;
				val2 = inst_addr[15:12] + 1'b1;
				val3 = inst_addr[11:8] + 1'b1;
				val4 = inst_addr[7:4] + 1'b1;
				val5 = inst_addr[3:0] + 1'b1;
				val6 = 6'b000000;
			end
			else if (count == 49 || count == 50) begin
				val1 = (FLAGS[4] == 1'b1) ? 6'b001101 : 6'b000000;
				val2 = (FLAGS[3] == 1'b1) ? 6'b010110 : 6'b000000;
				val3 = (FLAGS[2] == 1'b1) ? 6'b010000 : 6'b000000;
				val4 = (FLAGS[1] == 1'b1) ? 6'b100100 : 6'b000000;
				val5 = (FLAGS[0] == 1'b1) ? 6'b011000 : 6'b000000;
				val6 = 6'b000000;
			end
			else if (count == 51 || count == 52) begin
				case (inst[15:12])
					RTYPE: begin
						case (inst[7:4])
							ADD: begin
								val1 = 6'b001011;
								val2 = 6'b001110;
								val3 = 6'b001110;
								val4 = 6'b000000;
								val5 = 6'b000000;
								val6 = 6'b000000;
							end
							ADDU: begin
								val1 = 6'b001011;
								val2 = 6'b001110;
								val3 = 6'b001110;
								val4 = 6'b011111;
								val5 = 6'b000000;
								val6 = 6'b000000;
							end
							ADDC: begin
								val1 = 6'b001011;
								val2 = 6'b001110;
								val3 = 6'b001110;
								val4 = 6'b001101;
								val5 = 6'b000000;
								val6 = 6'b000000;
							end
							ADDCU: begin
								val1 = 6'b001011;
								val2 = 6'b001110;
								val3 = 6'b001110;
								val4 = 6'b001101;
								val5 = 6'b011111;
								val6 = 6'b000000;
							end
							SUB: begin
								val1 = 6'b011101;
								val2 = 6'b011111;
								val3 = 6'b001100;
								val4 = 6'b000000;
								val5 = 6'b000000;
								val6 = 6'b000000;
							end
							CMP: begin
								val1 = 6'b001101;
								val2 = 6'b010111;
								val3 = 6'b011010;
								val4 = 6'b000000;
								val5 = 6'b000000;
								val6 = 6'b000000;
							end
							AND: begin
								val1 = 6'b001011;
								val2 = 6'b011000;
								val3 = 6'b001110;
								val4 = 6'b000000;
								val5 = 6'b000000;
								val6 = 6'b000000;
							end
							OR: begin
								val1 = 6'b011001;
								val2 = 6'b011100;
								val3 = 6'b000000;
								val4 = 6'b000000;
								val5 = 6'b000000;
								val6 = 6'b000000;
							end
							XOR: begin
								val1 = 6'b100010;
								val2 = 6'b011001;
								val3 = 6'b011100;
								val4 = 6'b000000;
								val5 = 6'b000000;
								val6 = 6'b000000;
							end
							NOT: begin
								val1 = 6'b011000;
								val2 = 6'b011001;
								val3 = 6'b011110;
								val4 = 6'b000000;
								val5 = 6'b000000;
								val6 = 6'b000000;
							end
							MOV: begin
								val1 = 6'b010111;
								val2 = 6'b011001;
								val3 = 6'b100000;
								val4 = 6'b000000;
								val5 = 6'b000000;
								val6 = 6'b000000;
							end
							default: begin
								val1 = 6'b000000;
								val2 = 6'b000000;
								val3 = 6'b000000;
								val4 = 6'b000000;
								val5 = 6'b000000;
								val6 = 6'b000000;
							end
						endcase
					end
					SHIFT: begin
						case (inst[7:4])
							LSH: begin
								val1 = 6'b010110;
								val2 = 6'b011101;
								val3 = 6'b010010;
								val4 = 6'b000000;
								val5 = 6'b000000;
								val6 = 6'b000000;
							end
							LSHI: begin
								val1 = 6'b010110;
								val2 = 6'b011101;
								val3 = 6'b010010;
								val4 = 6'b010011;
								val5 = 6'b000000;
								val6 = 6'b000000;
							end
							RSH: begin
								val1 = 6'b011100;
								val2 = 6'b011101;
								val3 = 6'b010010;
								val4 = 6'b000000;
								val5 = 6'b000000;
								val6 = 6'b000000;
							end
							RSHI: begin
								val1 = 6'b011100;
								val2 = 6'b011101;
								val3 = 6'b010010;
								val4 = 6'b010011;
								val5 = 6'b000000;
								val6 = 6'b000000;
							end
							ALSH: begin
								val1 = 6'b001011;
								val2 = 6'b010110;
								val3 = 6'b011101;
								val4 = 6'b010010;
								val5 = 6'b000000;
								val6 = 6'b000000;
							end
							ARSH: begin
								val1 = 6'b001011;
								val2 = 6'b011100;
								val3 = 6'b011101;
								val4 = 6'b010010;
								val5 = 6'b000000;
								val6 = 6'b000000;
							end
							default: begin
								val1 = 6'b000000;
								val2 = 6'b000000;
								val3 = 6'b000000;
								val4 = 6'b000000;
								val5 = 6'b000000;
								val6 = 6'b000000;
							end
						endcase
					end
					MEM: begin
						case (inst[7:4])
							LOAD: begin
								val1 = 6'b010110;
								val2 = 6'b011001;
								val3 = 6'b001011;
								val4 = 6'b001110;
								val5 = 6'b000000;
								val6 = 6'b000000;
							end
							STOR: begin
								val1 = 6'b011101;
								val2 = 6'b011110;
								val3 = 6'b011001;
								val4 = 6'b011100;
								val5 = 6'b000000;
								val6 = 6'b000000;
							end
							JCOND: begin
								case (inst[3:0])
									JUC: begin
										val1 = 6'b010100;
										val2 = 6'b011111;
										val3 = 6'b001101;
										val4 = 6'b000000;
										val5 = 6'b000000;
										val6 = 6'b000000;
									end
									BEQ: begin
										val1 = 6'b001100;
										val2 = 6'b001111;
										val3 = 6'b011011;
										val4 = 6'b000000;
										val5 = 6'b000000;
										val6 = 6'b000000;
									end
									BNEQ: begin
										val1 = 6'b001100;
										val2 = 6'b011000;
										val3 = 6'b001111;
										val4 = 6'b011011;
										val5 = 6'b000000;
										val6 = 6'b000000;
									end
									BGE: begin
										val1 = 6'b001100;
										val2 = 6'b010001;
										val3 = 6'b001111;
										val4 = 6'b000000;
										val5 = 6'b000000;
										val6 = 6'b000000;
									end
									BLE: begin
										val1 = 6'b001100;
										val2 = 6'b010110;
										val3 = 6'b001111;
										val4 = 6'b000000;
										val5 = 6'b000000;
										val6 = 6'b000000;
									end
									BGT: begin
										val1 = 6'b001100;
										val2 = 6'b010001;
										val3 = 6'b011110;
										val4 = 6'b000000;
										val5 = 6'b000000;
										val6 = 6'b000000;
									end
									BLT: begin
										val1 = 6'b001100;
										val2 = 6'b010110;
										val3 = 6'b011110;
										val4 = 6'b000000;
										val5 = 6'b000000;
										val6 = 6'b000000;
									end
									default: begin
										val1 = 6'b000000;
										val2 = 6'b000000;
										val3 = 6'b000000;
										val4 = 6'b000000;
										val5 = 6'b000000;
										val6 = 6'b000000;
									end
								endcase
							end
							default: begin
								val1 = 6'b000000;
								val2 = 6'b000000;
								val3 = 6'b000000;
								val4 = 6'b000000;
								val5 = 6'b000000;
								val6 = 6'b000000;
							end
						endcase
					end
					ADDI: begin
						val1 = 6'b001011;
						val2 = 6'b001110;
						val3 = 6'b001110;
						val4 = 6'b010011;
						val5 = 6'b000000;
						val6 = 6'b000000;
					end
					ADDUI: begin
						val1 = 6'b001011;
						val2 = 6'b001110;
						val3 = 6'b001110;
						val4 = 6'b011111;
						val5 = 6'b010011;
						val6 = 6'b000000;
					end
					ADDCI: begin
						val1 = 6'b001011;
						val2 = 6'b001110;
						val3 = 6'b001110;
						val4 = 6'b001101;
						val5 = 6'b010011;
						val6 = 6'b000000;
					end
					ADDCUI: begin
						val1 = 6'b001011;
						val2 = 6'b001110;
						val3 = 6'b001110;
						val4 = 6'b001101;
						val5 = 6'b011111;
						val6 = 6'b010011;
					end
					SUBI: begin
						val1 = 6'b011101;
						val2 = 6'b011111;
						val3 = 6'b001100;
						val4 = 6'b010011;
						val5 = 6'b000000;
						val6 = 6'b000000;
					end
					MOVI: begin
						val1 = 6'b010111;
						val2 = 6'b011001;
						val3 = 6'b100000;
						val4 = 6'b010011;
						val5 = 6'b000000;
						val6 = 6'b000000;
					end
					LUI: begin
						val1 = 6'b010110;
						val2 = 6'b011111;
						val3 = 6'b010011;
						val4 = 6'b000000;
						val5 = 6'b000000;
						val6 = 6'b000000;
					end
					CMPI: begin
						val1 = 6'b001101;
						val2 = 6'b010111;
						val3 = 6'b011010;
						val4 = 6'b010011;
						val5 = 6'b000000;
						val6 = 6'b000000;
					end
					CMPUI: begin
						val1 = 6'b001101;
						val2 = 6'b010111;
						val3 = 6'b011010;
						val4 = 6'b011111;
						val5 = 6'b010011;
						val6 = 6'b000000;
					end
					GSTOR: begin
						val1 = 6'b010001;
						val2 = 6'b011101;
						val3 = 6'b011110;
						val4 = 6'b011001;
						val5 = 6'b011100;
						val6 = 6'b000000;
					end
					default: begin
						val1 = 6'b000000;
						val2 = 6'b000000;
						val3 = 6'b000000;
						val4 = 6'b000000;
						val5 = 6'b000000;
						val6 = 6'b000000;
					end
				endcase
			end
			else begin
					val1 = 0;
					val2 = 0;
					val3 = 0;
					val4 = 0;
					val5 = 0;
					val6 = 0;
			end
	end
	
	always @ (*) begin
		
		if ((VPix == 0 || HPix == 0) && DEBUG == 1'b1) begin
			w2 = 1;
			if (count < 35 || (count >= 39 && count < 53)) begin
				if (count % 2 == 1) begin
					d_in2 = {val1, val2, val3};
				end
				else begin
					d_in2 = {val4, val5, val6};
				end
			end
			else if (count == 35) d_in2 = { readRegA + 1'b1,12'b0};
			else if (count == 36) d_in2 = { readRegB + 1'b1, 12'b0};
			else if (count == 37) d_in2 = { loadReg + 1'b1, 12'b0};
			else if (count == 38) d_in2 = { memAddr + 1'b1, 12'b0};
			else d_in2 = 18'b0;
			// when HPix or VPix is 0, we can safely write to the memory
			// Instruction should be written at address 314
			// R0 should be written at 341
			// R1 should be written at 368
			// so add 27 to the previous register to display the values
			//
			// Write to the glyphMap memory module.  Subtract 256 from each address
			case (count)
				1: addr2 = 65;//321; // Inst display addresses.
				2: addr2 = 66;//322; // Display decoded instruction at 324
				3: addr2 = 85;//341; // r0 display addresses
				4: addr2 = 86;//342; 
				5: addr2 = 112;//368; // r1 display addresses
				6: addr2 = 113;//369; 
				7: addr2 = 139;//395; // r2 display addresses
				8: addr2 = 140;//396; 
				9: addr2 = 166;//422; // r3 display addresses
				10: addr2 = 167;//423;
				11: addr2 = 193;//449; // r4 display addresses
				12: addr2 = 194;//450; 
				13: addr2 = 220;//476; // r5 display addresses
				14: addr2 = 221;//477; 
				15: addr2 = 247;//503; // r6 display addresses
				16: addr2 = 248;//504;
				17: addr2 = 274;//530; // r7 display addresses
				18: addr2 = 275;//531;
				19: addr2 = 301;//557; // r8 display addresses
				20: addr2 = 302;//558;
				21: addr2 = 328;//584; // r9 display addresses
				22: addr2 = 329;//585;
				23: addr2 = 355;//611; // r10 display addresses
				24: addr2 = 356;//612;
				25: addr2 = 382;//638; // r11 display addresses
				26: addr2 = 383;//639;
				27: addr2 = 409;//665; // r12 display addresses
				28: addr2 = 410;//666;
				29: addr2 = 436;//692; // r13 display addresses
				30: addr2 = 437;//693;
				31: addr2 = 463;//719; // r14 display addresses
				32: addr2 = 464;//720;
				33: addr2 = 490;//746; // r15 display addresses
				34: addr2 = 491;//747; 
				35: addr2 = 92;//348; // Display RegA at 345.  Display RegA info at 348
				36: addr2 = 119;//375; // Display RegB at 372.  Display RegB info at 375
				37: addr2 = 146;//402; // Display loadReg at 399.  Display loadReg info at 402
				38: addr2 = 173;//429; // Display memAddr at 426.  Display memAddr info at 429
				39: addr2 = 226;//482; // Display addr1 at 480.  Display addr1 info at 482
				40: addr2 = 227;//483;
				41: addr2 = 96;//352; // Display ValA at 350.  Display ValA info at 352
				42: addr2 = 97;//353;
				43: addr2 = 123;//379; // Display ValB at 377.  Display ValB info at 379
				44: addr2 = 124;//380;
				45: addr2 = 231;//487; // Display data1 at 485.  Display data1 info at 487
				46: addr2 = 232;//488;
				47: addr2 = 58;//314; // Display PC at 314.  Display PC info at 315
				48: addr2 = 59;//315;
				49: addr2 = 281;//537; // Display FLAGS at 534.  Display FLAGS info at 536
				50: addr2 = 282;//538;
				51: addr2 = 68;//324; // Display decoded instruction text
				52: addr2 = 69;//325;
				default: addr2 = 1619;
			endcase
		end
		else begin
			addr2 = 14'bz;
			w2 = 0;
			d_in2 = 18'b0;
		end
	end
	
	always @ (*) begin
		if (inst[15:12] == MEM && inst[7:4] == STOR) begin
			if (data_addr[15:14] == 2'b10) begin
				addr1 = data_addr[12:0];
				w1 = 1'b1;
				d_in1 = {2'b0, data_in};
			end
			else begin
				addr1 = 0;
				w1 = 0;
				d_in1 = 18'b0;
			end
		end
		else if (inst[15:12] == GSTOR) begin
			addr1 = data_addr[12:0];
			w1 = 1'b1;
			d_in1 = {A[5:0], B[11:0]}; 
		end
		else begin
			addr1 = 0;
			w1 = 0;
			d_in1 = 18'b0;
		end
	end
	
	always @ (*) begin
		if ((HPix - 1) % 24 >= 16) begin
			// case for the last 6 bits of data
			gAddr1 = (d_out2[5:0])*4 + ((VPix - 1) % 8)/2;
			//gAddr2 = (vd_out2[5:0])*4 + ((VPix - 1) % 8)/2;
		end
		else if ((HPix - 1) % 24 >= 8) begin
			// case for the middle 6 bits of data
			gAddr1 = (d_out2[11:6])*4 + ((VPix - 1) % 8)/2;
			//gAddr2 = (vd_out2[11:6])*4 + ((VPix - 1) % 8)/2;
		end
		else begin
			// case for the first 6 bits of data
			gAddr1 = (d_out2[17:12])*4 + ((VPix - 1) % 8)/2;
			//gAddr2 = (vd_out2[17:12])*4 + ((VPix - 1) % 8)/2;
		end	
	end
	
	reg [6:0] count;
	
	always @ (posedge CLK) begin
		if (CLR) begin count = 0; end
		else begin
			if (VPix == 10'b0) begin
				if (count <= 53) begin
					count = count + 1'b1;
				end
				else begin
					count = 0;
				end
			end
			else begin
				count = 0;
			end
		end
	end
	
	// current glyph pixel location
	wire [2:0] currentX, currentY;
	assign currentX = (HPix - 1'b1) % 8;
	assign currentY = (VPix - 1'b1) % 8;
	
	// This is for the ROM-based light.  DOesn't provide any better performance -- Worse, in fact.
/*	reg [7:0] blueLight [127:0];
	
	initial begin
		$readmemb("bluelight.mem", blueLight);
	end
	
	wire [6:0] bAddr;
	assign bAddr = {lights, currentY, currentX};*/
	
	// Now we can safely set the pixels
	always @ (*) begin
		if (HPix == 0 || VPix == 0) begin RGB_out = 8'b00000000; end 
		else begin
			if (DEBUG == 1'b1) begin
				if (gD_out1[5'd17 - (2'd2 + ((HPix - 1'b1) % 4'd8 + (((VPix - 1'b1) % 2'd2) << 3)))] == 1) begin
					RGB_out = textColor;
				end
				else begin
					RGB_out = displayColor;
				end	
			end
			else begin
				if (displayBlack == 1'b1) begin
					RGB_out = 8'b00000000;
				end
				else begin
					if (gAddr1 > 8'd211) begin
						if (gAddr1 >= 224 && gAddr1 < 228) begin
							if (((currentX == 3'd1 || currentX == 3'd5) && (currentY >= 3'd2 && currentY <= 3'd6)) ||
								((currentX == 3'd3 || currentX == 3'd7) && (currentY >= 3'd1 && currentY <= 3'd5))) begin
								RGB_out = 8'b00000000;
							end
							else begin
								RGB_out = 8'b01101000;
							end
						end
						else if (gAddr1 >= 228 && gAddr1 < 232) begin
							RGB_out = 8'b00010000;
						end
						else if (gAddr1 >= 232 && gAddr1 < 236) begin
							if ((currentX == 3'd0 && currentY == 3'd1) ||
								((currentX == 3'd0 || currentX == 3'd1) && currentY == 3'd2) ||
								(currentX >= 3'd0 && currentX <= 3'd2 && currentY == 3'd3) ||
								(currentX >= 3'd0 && currentX <= 3'd3 && currentY == 3'd4) ||
								(currentX >= 3'd0 && currentX <= 3'd4 && currentY == 3'd5) ||
								(currentX >= 3'd0 && currentX <= 3'd5 && currentY == 3'd6) ||
								(currentX >= 3'd0 && currentX <= 3'd6 && currentY == 3'd7)) begin
								RGB_out = 8'b00010000;
							end
							else begin
								RGB_out = displayColor;
							end
						end
						else if (gAddr1 >= 236 && gAddr1 < 240) begin
							// This is a diagonal Tree glyph with the bottom right Green
							if ((currentX == 3'd7 && currentY == 3'd1) ||
								((currentX == 3'd6 || currentX == 3'd7) && currentY == 3'd2) ||
								(currentX >= 3'd5 && currentX <= 3'd7 && currentY == 3'd3) ||
								(currentX >= 3'd4 && currentX <= 3'd7 && currentY == 3'd4) ||
								(currentX >= 3'd3 && currentX <= 3'd7 && currentY == 3'd5) ||
								(currentX >= 3'd2 && currentX <= 3'd7 && currentY == 3'd6) ||
								(currentX >= 3'd1 && currentX <= 3'd7 && currentY == 3'd7)) begin
								RGB_out = 8'b00010000;
							end
							else begin
								RGB_out = displayColor;
							end
						end
						else if ((gAddr1 >= 240 && gAddr1 < 244) || (gAddr1 >= 220 && gAddr1 < 224)) begin
							/*RGB_out = blueLight[bAddr];*/
							// Characters normally store 2 lines per memory address, so
							// the minimum height for the patterns will be 2 pixels by 1 pixel.
							// We can achieve some interesting patterns this way, and store various colors
							// in up to 8 locations.  This information will be stored in LUTs
							// on the FPGA (ROM-type memory).  Address 240-243 will be the first non-character glyph
							// mapped to characters.  This corresponds to Glyph Address 60, or 6'b111100
							// currentX and currentY will be determining the colors and pattern
							// This is just a light, no tree background
							if (lights == 1'b1) begin
								if (((currentX >= 3'd3 && currentX <= 3'd5) && (currentY == 3'd1 || currentY == 3'd7)) || 
									((currentX >= 3'd2 && currentX <= 3'd6) && (currentY == 3'd2 || currentY == 3'd6)) || 
									((currentX == 3'd1 || currentX == 3'd2 || currentX == 3'd6 || currentX == 3'd7) && (currentY == 3'd3 || currentY == 3'd4 || currentY == 3'd5))) begin
									// not 0x2f == 8'b00101111
									RGB_out = 8'b00000011;
								end
								else if (((currentX >= 3'd3 && currentX <= 3'd5) && (currentY == 3'd3 || currentY == 3'd5)) ||
									((currentX == 3'd3 || currentX == 3'd5) && (currentY == 3'd4))) begin
									RGB_out = 8'b11011011;
								end
								else if (currentX == 3'd4 && currentY == 4) begin
									RGB_out = 8'b11111111;
								end
								else begin
									if (gAddr1 >= 220 && gAddr1 < 224) begin
										RGB_out = 8'b00010000;
									end
									else begin
										RGB_out = displayColor;
									end
								end
							end
							else begin
								if (((currentX >= 3'd3 && currentX <= 3'd5) && (currentY == 3'd1 || currentY == 3'd7)) || 
									((currentX >= 3'd2 && currentX <= 3'd6) && (currentY == 3'd2 || currentY == 3'd6)) || 
									((currentX >= 3'd1 && currentX <= 3'd7) && (currentY >= 3'd3 && currentY <= 3'd5))) begin
									// not 0x2f == 8'b00101111
									RGB_out = 8'b00000010;
								end
								else begin
									if (gAddr1 >= 220 && gAddr1 < 224) begin
										RGB_out = 8'b00010000;
									end
									else begin
										RGB_out = displayColor;
									end
								end
							end
						end
						else if ((gAddr1 >= 244 && gAddr1 < 248) || (gAddr1 >= 216 && gAddr1 < 220)) begin
							if (lights == 1'b1) begin
								if (((currentX >= 3'd3 && currentX <= 3'd5) && (currentY == 3'd1 || currentY == 3'd7)) || 
									((currentX >= 3'd2 && currentX <= 3'd6) && (currentY == 3'd2 || currentY == 3'd6)) || 
									((currentX == 3'd1 || currentX == 3'd2 || currentX == 3'd6 || currentX == 3'd7) && (currentY == 3'd3 || currentY == 3'd4 || currentY == 3'd5))) begin
									// not 0x2f == 8'b00101111
									RGB_out = 8'b11100000;
								end
								else if (((currentX >= 3'd3 && currentX <= 3'd5) && (currentY == 3'd3 || currentY == 3'd5)) ||
									((currentX == 3'd3 || currentX == 3'd5) && (currentY == 3'd4))) begin
									RGB_out = 8'b11110110;
								end
								else if (currentX == 3'd4 && currentY == 4) begin
									RGB_out = 8'b11111111;
								end
								else begin
									if (gAddr1 >= 216 && gAddr1 < 220) begin
										RGB_out = 8'b00010000;
									end
									else begin
										RGB_out = displayColor;
									end
								end
							end
							else begin
								if (((currentX >= 3'd3 && currentX <= 3'd5) && (currentY == 3'd1 || currentY == 3'd7)) || 
									((currentX >= 3'd2 && currentX <= 3'd6) && (currentY == 3'd2 || currentY == 3'd6)) || 
									((currentX >= 3'd1 && currentX <= 3'd7) && (currentY >= 3'd3 && currentY <= 3'd5))) begin
									// not 0x2f == 8'b00101111
									RGB_out = 8'b01000000;
								end
								else begin
									if (gAddr1 >= 216 && gAddr1 < 220) begin
										RGB_out = 8'b00010000;
									end
									else begin
										RGB_out = displayColor;
									end
								end
							end
						end
						else if ((gAddr1 >= 248 && gAddr1 < 252) || (gAddr1 >= 212 && gAddr1 < 216)) begin
							if (lights == 1'b1) begin
								if (((currentX >= 3'd3 && currentX <= 3'd5) && (currentY == 3'd1 || currentY == 3'd7)) || 
									((currentX >= 3'd2 && currentX <= 3'd6) && (currentY == 3'd2 || currentY == 3'd6)) || 
									((currentX == 3'd1 || currentX == 3'd2 || currentX == 3'd6 || currentX == 3'd7) && (currentY == 3'd3 || currentY == 3'd4 || currentY == 3'd5))) begin
									// not 0x2f == 8'b00101111
									RGB_out = 8'b11011001;
								end
								else if (((currentX >= 3'd3 && currentX <= 3'd5) && (currentY == 3'd3 || currentY == 3'd5)) ||
									((currentX == 3'd3 || currentX == 3'd5) && (currentY == 3'd4))) begin
									RGB_out = 8'b11111010;
								end
								else if (currentX == 3'd4 && currentY == 4) begin
									RGB_out = 8'b11111111;
								end
								else begin
									if (gAddr1 >= 212 && gAddr1 < 216) begin
										RGB_out = 8'b00010000;
									end
									else begin
										RGB_out = displayColor;
									end
								end
							end
							else begin
								if (((currentX >= 3'd3 && currentX <= 3'd5) && (currentY == 3'd1 || currentY == 3'd7)) || 
									((currentX >= 3'd2 && currentX <= 3'd6) && (currentY == 3'd2 || currentY == 3'd6)) || 
									((currentX >= 3'd1 && currentX <= 3'd7) && (currentY >= 3'd3 && currentY <= 3'd5))) begin
									// not 0x2f == 8'b00101111
									RGB_out = 8'b10010000;
								end
								else begin
									if (gAddr1 >= 212 && gAddr1 < 216) begin
										RGB_out = 8'b00010000;
									end
									else begin
										RGB_out = displayColor;
									end
								end
							end
						end
						else if (gAddr1 >= 252 && gAddr1 < 256) begin
							if (lights == 1'b1) begin
								if (((currentX >= 3'd3 && currentX <= 3'd5) && (currentY == 3'd1 || currentY == 3'd7)) || 
									((currentX >= 3'd2 && currentX <= 3'd6) && (currentY == 3'd2 || currentY == 3'd6)) || 
									((currentX == 3'd1 || currentX == 3'd2 || currentX == 3'd6 || currentX == 3'd7) && (currentY == 3'd3 || currentY == 3'd4 || currentY == 3'd5))) begin
									// not 0x2f == 8'b00101111
									RGB_out = 8'b00011100;
								end
								else if (((currentX >= 3'd3 && currentX <= 3'd5) && (currentY == 3'd3 || currentY == 3'd5)) ||
									((currentX == 3'd3 || currentX == 3'd5) && (currentY == 3'd4))) begin
									RGB_out = 8'b11011100;
								end
								else if (currentX == 3'd4 && currentY == 4) begin
									RGB_out = 8'b11111111;
								end
								else begin
									RGB_out = displayColor;
								end
							end
							else begin
								if (((currentX >= 3'd3 && currentX <= 3'd5) && (currentY == 3'd1 || currentY == 3'd7)) || 
									((currentX >= 3'd2 && currentX <= 3'd6) && (currentY == 3'd2 || currentY == 3'd6)) || 
									((currentX >= 3'd1 && currentX <= 3'd7) && (currentY >= 3'd3 && currentY <= 3'd5))) begin
									// not 0x2f == 8'b00101111
									RGB_out = 8'b00010000;
								end
								else begin
									RGB_out = displayColor;
								end
							end
						end
						else begin
							// In this case, we don't have any glyphs set up, so display the background color
							RGB_out = displayColor;
						end
					end
					else begin
						if (gD_out1[5'd17 - (2'd2 + ((HPix - 1'b1) % 4'd8 + (((VPix - 1'b1) % 2'd2) << 3)))] == 1) begin
							RGB_out = textColor;
						end
						else begin
							RGB_out = displayColor;
						end			
					end
				end
			end
		end
	end
	
endmodule
