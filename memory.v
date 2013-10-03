`timescale 1ns / 1ps

// this is an 18-kbit block ram instance
module memory(
	input CLK, CLR, w0, w1,
	input [9:0] addr0, addr1,
	input [17:0] data0, data1,
	output reg [17:0] out0, out1
	);
	
	reg [17:0] RAM [1023:0];
	
	always @ (posedge CLK) begin
		out0 <= RAM[addr0];
		out1 <= RAM[addr1];
	end
	
	always @ (posedge CLK) begin
		if (w0) RAM[addr0] <= data0;
		else RAM[addr0] <= RAM[addr0];
	end
	
	always @ (posedge CLK) begin
		if (w1) RAM[addr1] <= data1;
		else RAM[addr1] <= RAM[addr1];
	end
endmodule

module memory2(
	input CLK, CLR, w0, w1,
	input [14:0] addr0, addr1,
	input [17:0] data0, data1,
	output reg [17:0] out0, out1
	);
	
	reg w0_0, w0_1, w1_0, w1_1, w2_0, w2_1, w3_0, w3_1, w4_0, w4_1, w5_0, w5_1, w6_0, w6_1, w7_0, w7_1, w8_0, w8_1, w9_0, w9_1, 
			w10_0, w10_1, w11_0, w11_1, w12_0, w12_1, w13_0, w13_1, w14_0, w14_1, w15_0, w15_1, w16_0, w16_1, w17_0, w17_1, w18_0, w18_1, w19_0, w19_1, 
			w20_0, w20_1, w21_0, w21_1, w22_0, w22_1, w23_0, w23_1, w24_0, w24_1, w25_0, w25_1, w26_0, w26_1, w27_0, w27_1, w28_0, w28_1, w29_0, w29_1;
	
	wire [17:0] out0_0, out0_1, out1_0, out1_1, out2_0, out2_1, out3_0, out3_1, out4_0, out4_1, out5_0, out5_1, out6_0, out6_1, out7_0, out7_1, out8_0, out8_1, out9_0, out9_1, 
			out10_0, out10_1, out11_0, out11_1, out12_0, out12_1, out13_0, out13_1, out14_0, out14_1, out15_0, out15_1, out16_0, out16_1, out17_0, out17_1, out18_0, out18_1, out19_0, out19_1, 
			out20_0, out20_1, out21_0, out21_1, out22_0, out22_1, out23_0, out23_1, out24_0, out24_1, out25_0, out25_1, out26_0, out26_1, out27_0, out27_1, out28_0, out28_1, out29_0, out29_1;
	
	memory m0 (CLK, CLR, w0_0, w0_1, addr0, addr1, data0, data1, out0_0, out0_1);
	memory m1 (CLK, CLR, w1_0, w1_1, addr0, addr1, data0, data1, out1_0, out1_1);
	memory m2 (CLK, CLR, w2_0, w2_1, addr0, addr1, data0, data1, out2_0, out2_1);
	memory m3 (CLK, CLR, w3_0, w3_1, addr0, addr1, data0, data1, out3_0, out3_1);
	memory m4 (CLK, CLR, w4_0, w4_1, addr0, addr1, data0, data1, out4_0, out4_1);
	memory m5 (CLK, CLR, w5_0, w5_1, addr0, addr1, data0, data1, out5_0, out5_1);
	memory m6 (CLK, CLR, w6_0, w6_1, addr0, addr1, data0, data1, out6_0, out6_1);
	memory m7 (CLK, CLR, w7_0, w7_1, addr0, addr1, data0, data1, out7_0, out7_1);
	memory m8 (CLK, CLR, w8_0, w8_1, addr0, addr1, data0, data1, out8_0, out8_1);
	memory m9 (CLK, CLR, w9_0, w9_1, addr0, addr1, data0, data1, out9_0, out9_1);
	memory m10(CLK, CLR, w10_0, w10_1, addr0, addr1, data0, data1, out10_0, out10_1);
	memory m11(CLK, CLR, w11_0, w11_1, addr0, addr1, data0, data1, out11_0, out11_1);
	memory m12(CLK, CLR, w12_0, w12_1, addr0, addr1, data0, data1, out12_0, out12_1);
	memory m13(CLK, CLR, w13_0, w13_1, addr0, addr1, data0, data1, out13_0, out13_1);
	memory m14(CLK, CLR, w14_0, w14_1, addr0, addr1, data0, data1, out14_0, out14_1);
	memory m15(CLK, CLR, w15_0, w15_1, addr0, addr1, data0, data1, out15_0, out15_1);
	memory m16(CLK, CLR, w16_0, w16_1, addr0, addr1, data0, data1, out16_0, out16_1);
	memory m17(CLK, CLR, w17_0, w17_1, addr0, addr1, data0, data1, out17_0, out17_1);
	memory m18(CLK, CLR, w18_0, w18_1, addr0, addr1, data0, data1, out18_0, out18_1);
	memory m19(CLK, CLR, w19_0, w19_1, addr0, addr1, data0, data1, out19_0, out19_1);
	memory m20(CLK, CLR, w20_0, w20_1, addr0, addr1, data0, data1, out20_0, out20_1);
	memory m21(CLK, CLR, w21_0, w21_1, addr0, addr1, data0, data1, out21_0, out21_1);
	memory m22(CLK, CLR, w22_0, w22_1, addr0, addr1, data0, data1, out22_0, out22_1);
	memory m23(CLK, CLR, w23_0, w23_1, addr0, addr1, data0, data1, out23_0, out23_1);
	memory m24(CLK, CLR, w24_0, w24_1, addr0, addr1, data0, data1, out24_0, out24_1);
	memory m25(CLK, CLR, w25_0, w25_1, addr0, addr1, data0, data1, out25_0, out25_1);
	memory m26(CLK, CLR, w26_0, w26_1, addr0, addr1, data0, data1, out26_0, out26_1);
	memory m27(CLK, CLR, w27_0, w27_1, addr0, addr1, data0, data1, out27_0, out27_1);
	memory m28(CLK, CLR, w28_0, w28_1, addr0, addr1, data0, data1, out28_0, out28_1);
	memory m29(CLK, CLR, w29_0, w29_1, addr0, addr1, data0, data1, out29_0, out29_1);
	
	always begin
		case (addr0[14:10])
			0: begin w0_0 = w0; {w1_0, w2_0, w3_0, w4_0, w5_0, w6_0, w7_0, w8_0, w9_0,
										w10_0, w11_0, w12_0, w13_0, w14_0, w15_0, w16_0, w17_0, w18_0, w19_0,
										w20_0, w21_0, w22_0, w23_0, w24_0, w25_0, w26_0, w27_0, w28_0, w29_0} = 29'b0; 
					out0 = out0_0;
				end
			1: begin w1_0 = w0; {w0_0, w2_0, w3_0, w4_0, w5_0, w6_0, w7_0, w8_0, w9_0,
										w10_0, w11_0, w12_0, w13_0, w14_0, w15_0, w16_0, w17_0, w18_0, w19_0,
										w20_0, w21_0, w22_0, w23_0, w24_0, w25_0, w26_0, w27_0, w28_0, w29_0} = 29'b0; 
					out0 = out1_0;
				end
			2: begin w2_0 = w0; {w0_0, w1_0, w3_0, w4_0, w5_0, w6_0, w7_0, w8_0, w9_0,
										w10_0, w11_0, w12_0, w13_0, w14_0, w15_0, w16_0, w17_0, w18_0, w19_0,
										w20_0, w21_0, w22_0, w23_0, w24_0, w25_0, w26_0, w27_0, w28_0, w29_0} = 29'b0; 
					out0 = out2_0;
				end
			3: begin w3_0 = w0; {w0_0, w1_0, w2_0, w4_0, w5_0, w6_0, w7_0, w8_0, w9_0,
										w10_0, w11_0, w12_0, w13_0, w14_0, w15_0, w16_0, w17_0, w18_0, w19_0,
										w20_0, w21_0, w22_0, w23_0, w24_0, w25_0, w26_0, w27_0, w28_0, w29_0} = 29'b0; 
					out0 = out3_0;
				end
			4: begin w4_0 = w0; {w0_0, w1_0, w2_0, w3_0, w5_0, w6_0, w7_0, w8_0, w9_0,
										w10_0, w11_0, w12_0, w13_0, w14_0, w15_0, w16_0, w17_0, w18_0, w19_0,
										w20_0, w21_0, w22_0, w23_0, w24_0, w25_0, w26_0, w27_0, w28_0, w29_0} = 29'b0; 
					out0 = out4_0;
				end
			5: begin w5_0 = w0; {w0_0, w1_0, w2_0, w3_0, w4_0, w6_0, w7_0, w8_0, w9_0,
										w10_0, w11_0, w12_0, w13_0, w14_0, w15_0, w16_0, w17_0, w18_0, w19_0,
										w20_0, w21_0, w22_0, w23_0, w24_0, w25_0, w26_0, w27_0, w28_0, w29_0} = 29'b0; 
					out0 = out5_0;
				end
			6: begin w6_0 = w0; {w0_0, w1_0, w2_0, w3_0, w4_0, w5_0, w7_0, w8_0, w9_0,
										w10_0, w11_0, w12_0, w13_0, w14_0, w15_0, w16_0, w17_0, w18_0, w19_0,
										w20_0, w21_0, w22_0, w23_0, w24_0, w25_0, w26_0, w27_0, w28_0, w29_0} = 29'b0; 
					out0 = out6_0;
				end
			7: begin w7_0 = w0; {w0_0, w1_0, w2_0, w3_0, w4_0, w5_0, w6_0, w8_0, w9_0,
										w10_0, w11_0, w12_0, w13_0, w14_0, w15_0, w16_0, w17_0, w18_0, w19_0,
										w20_0, w21_0, w22_0, w23_0, w24_0, w25_0, w26_0, w27_0, w28_0, w29_0} = 29'b0; 
					out0 = out7_0;
				end
			8: begin w8_0 = w0; {w0_0, w1_0, w2_0, w3_0, w4_0, w5_0, w6_0, w7_0, w9_0,
										w10_0, w11_0, w12_0, w13_0, w14_0, w15_0, w16_0, w17_0, w18_0, w19_0,
										w20_0, w21_0, w22_0, w23_0, w24_0, w25_0, w26_0, w27_0, w28_0, w29_0} = 29'b0; 
					out0 = out8_0;
				end
			9: begin w9_0 = w0; {w0_0, w1_0, w2_0, w3_0, w4_0, w5_0, w6_0, w7_0, w8_0, 
										w10_0, w11_0, w12_0, w13_0, w14_0, w15_0, w16_0, w17_0, w18_0, w19_0,
										w20_0, w21_0, w22_0, w23_0, w24_0, w25_0, w26_0, w27_0, w28_0, w29_0} = 29'b0; 
					out0 = out9_0;
				end
			10: begin w10_0 = w0; {w0_0, w1_0, w2_0, w3_0, w4_0, w5_0, w6_0, w7_0, w8_0, w9_0,
										w11_0, w12_0, w13_0, w14_0, w15_0, w16_0, w17_0, w18_0, w19_0,
										w20_0, w21_0, w22_0, w23_0, w24_0, w25_0, w26_0, w27_0, w28_0, w29_0} = 29'b0; 
					out0 = out10_0;
				end
			11: begin w11_0 = w0; {w0_0, w1_0, w2_0, w3_0, w4_0, w5_0, w6_0, w7_0, w8_0, w9_0,
										w10_0, w12_0, w13_0, w14_0, w15_0, w16_0, w17_0, w18_0, w19_0,
										w20_0, w21_0, w22_0, w23_0, w24_0, w25_0, w26_0, w27_0, w28_0, w29_0} = 29'b0; 
					out0 = out11_0;
				end
			12: begin w12_0 = w0; {w0_0, w1_0, w2_0, w3_0, w4_0, w5_0, w6_0, w7_0, w8_0, w9_0,
										w10_0, w11_0, w13_0, w14_0, w15_0, w16_0, w17_0, w18_0, w19_0,
										w20_0, w21_0, w22_0, w23_0, w24_0, w25_0, w26_0, w27_0, w28_0, w29_0} = 29'b0; 
					out0 = out12_0;
				end
			13: begin w13_0 = w0; {w0_0, w1_0, w2_0, w3_0, w4_0, w5_0, w6_0, w7_0, w8_0, w9_0,
										w10_0, w11_0, w12_0, w14_0, w15_0, w16_0, w17_0, w18_0, w19_0,
										w20_0, w21_0, w22_0, w23_0, w24_0, w25_0, w26_0, w27_0, w28_0, w29_0} = 29'b0; 
					out0 = out13_0;
				end
			14: begin w14_0 = w0; {w0_0, w1_0, w2_0, w3_0, w4_0, w5_0, w6_0, w7_0, w8_0, w9_0,
										w10_0, w11_0, w12_0, w13_0, w15_0, w16_0, w17_0, w18_0, w19_0,
										w20_0, w21_0, w22_0, w23_0, w24_0, w25_0, w26_0, w27_0, w28_0, w29_0} = 29'b0; 
					out0 = out14_0;
				end
			15: begin w15_0 = w0; {w0_0, w1_0, w2_0, w3_0, w4_0, w5_0, w6_0, w7_0, w8_0, w9_0,
										w10_0, w11_0, w12_0, w13_0, w14_0, w16_0, w17_0, w18_0, w19_0,
										w20_0, w21_0, w22_0, w23_0, w24_0, w25_0, w26_0, w27_0, w28_0, w29_0} = 29'b0; 
					out0 = out15_0;
				end
			16: begin w16_0 = w0; {w0_0, w1_0, w2_0, w3_0, w4_0, w5_0, w6_0, w7_0, w8_0, w9_0,
										w10_0, w11_0, w12_0, w13_0, w14_0, w15_0, w17_0, w18_0, w19_0,
										w20_0, w21_0, w22_0, w23_0, w24_0, w25_0, w26_0, w27_0, w28_0, w29_0} = 29'b0; 
					out0 = out16_0;
				end
			17: begin w17_0 = w0; {w0_0, w1_0, w2_0, w3_0, w4_0, w5_0, w6_0, w7_0, w8_0, w9_0,
										w10_0, w11_0, w12_0, w13_0, w14_0, w15_0, w16_0, w18_0, w19_0,
										w20_0, w21_0, w22_0, w23_0, w24_0, w25_0, w26_0, w27_0, w28_0, w29_0} = 29'b0; 
					out0 = out17_0;
				end
			18: begin w18_0 = w0; {w0_0, w1_0, w2_0, w3_0, w4_0, w5_0, w6_0, w7_0, w8_0, w9_0,
										w10_0, w11_0, w12_0, w13_0, w14_0, w15_0, w16_0, w17_0, w19_0,
										w20_0, w21_0, w22_0, w23_0, w24_0, w25_0, w26_0, w27_0, w28_0, w29_0} = 29'b0; 
					out0 = out18_0;
				end
			19: begin w19_0 = w0; {w0_0, w1_0, w2_0, w3_0, w4_0, w5_0, w6_0, w7_0, w8_0, w9_0,
										w10_0, w11_0, w12_0, w13_0, w14_0, w15_0, w16_0, w17_0, w18_0, 
										w20_0, w21_0, w22_0, w23_0, w24_0, w25_0, w26_0, w27_0, w28_0, w29_0} = 29'b0; 
					out0 = out19_0;
				end
			20: begin w20_0 = w0; {w0_0, w1_0, w2_0, w3_0, w4_0, w5_0, w6_0, w7_0, w8_0, w9_0,
										w10_0, w11_0, w12_0, w13_0, w14_0, w15_0, w16_0, w17_0, w18_0, w19_0,
										w21_0, w22_0, w23_0, w24_0, w25_0, w26_0, w27_0, w28_0, w29_0} = 29'b0; 
					out0 = out20_0;
				end
			21: begin w21_0 = w0; {w0_0, w1_0, w2_0, w3_0, w4_0, w5_0, w6_0, w7_0, w8_0, w9_0,
										w10_0, w11_0, w12_0, w13_0, w14_0, w15_0, w16_0, w17_0, w18_0, w19_0,
										w20_0, w22_0, w23_0, w24_0, w25_0, w26_0, w27_0, w28_0, w29_0} = 29'b0; 
					out0 = out21_0;
				end
			22: begin w22_0 = w0; {w0_0, w1_0, w2_0, w3_0, w4_0, w5_0, w6_0, w7_0, w8_0, w9_0,
										w10_0, w11_0, w12_0, w13_0, w14_0, w15_0, w16_0, w17_0, w18_0, w19_0,
										w20_0, w21_0, w23_0, w24_0, w25_0, w26_0, w27_0, w28_0, w29_0} = 29'b0; 
					out0 = out22_0;
				end
			23: begin w23_0 = w0; {w0_0, w1_0, w2_0, w3_0, w4_0, w5_0, w6_0, w7_0, w8_0, w9_0,
										w10_0, w11_0, w12_0, w13_0, w14_0, w15_0, w16_0, w17_0, w18_0, w19_0,
										w20_0, w21_0, w22_0, w24_0, w25_0, w26_0, w27_0, w28_0, w29_0} = 29'b0; 
					out0 = out23_0;
				end
			24: begin w24_0 = w0; {w0_0, w1_0, w2_0, w3_0, w4_0, w5_0, w6_0, w7_0, w8_0, w9_0,
										w10_0, w11_0, w12_0, w13_0, w14_0, w15_0, w16_0, w17_0, w18_0, w19_0,
										w20_0, w21_0, w22_0, w23_0, w25_0, w26_0, w27_0, w28_0, w29_0} = 29'b0; 
					out0 = out24_0;
				end
			25: begin w25_0 = w0; {w0_0, w1_0, w2_0, w3_0, w4_0, w5_0, w6_0, w7_0, w8_0, w9_0,
										w10_0, w11_0, w12_0, w13_0, w14_0, w15_0, w16_0, w17_0, w18_0, w19_0,
										w20_0, w21_0, w22_0, w23_0, w24_0, w26_0, w27_0, w28_0, w29_0} = 29'b0; 
					out0 = out25_0;
				end
			26: begin w26_0 = w0; {w0_0, w1_0, w2_0, w3_0, w4_0, w5_0, w6_0, w7_0, w8_0, w9_0,
										w10_0, w11_0, w12_0, w13_0, w14_0, w15_0, w16_0, w17_0, w18_0, w19_0,
										w20_0, w21_0, w22_0, w23_0, w24_0, w25_0, w27_0, w28_0, w29_0} = 29'b0; 
					out0 = out26_0;
				end
			27: begin w27_0 = w0; {w0_0, w1_0, w2_0, w3_0, w4_0, w5_0, w6_0, w7_0, w8_0, w9_0,
										w10_0, w11_0, w12_0, w13_0, w14_0, w15_0, w16_0, w17_0, w18_0, w19_0,
										w20_0, w21_0, w22_0, w23_0, w24_0, w25_0, w26_0, w28_0, w29_0} = 29'b0; 
					out0 = out27_0;
				end
			28: begin w28_0 = w0; {w0_0, w1_0, w2_0, w3_0, w4_0, w5_0, w6_0, w7_0, w8_0, w9_0,
										w10_0, w11_0, w12_0, w13_0, w14_0, w15_0, w16_0, w17_0, w18_0, w19_0,
										w20_0, w21_0, w22_0, w23_0, w24_0, w25_0, w26_0, w27_0, w29_0} = 29'b0; 
					out0 = out28_0;
				end
			29: begin w29_0 = w0; {w0_0, w1_0, w2_0, w3_0, w4_0, w5_0, w6_0, w7_0, w8_0, w9_0,
										w10_0, w11_0, w12_0, w13_0, w14_0, w15_0, w16_0, w17_0, w18_0, w19_0,
										w20_0, w21_0, w22_0, w23_0, w24_0, w25_0, w26_0, w27_0, w28_0} = 29'b0; 
					out0 = out29_0;
				end
			default: begin {w0_0, w1_0, w2_0, w3_0, w4_0, w5_0, w6_0, w7_0, w8_0, w9_0,
										w10_0, w11_0, w12_0, w13_0, w14_0, w15_0, w16_0, w17_0, w18_0, w19_0,
										w20_0, w21_0, w22_0, w23_0, w24_0, w25_0, w26_0, w27_0, w28_0, w29_0} = 30'b0; 
					out0 = out0_0;
				end
		endcase
		case (addr1[14:10])
			0: begin w0_1 = w1; {w1_1, w2_1, w3_1, w4_1, w5_1, w6_1, w7_1, w8_1, w9_1,
										w10_1, w11_1, w12_1, w13_1, w14_1, w15_1, w16_1, w17_1, w18_1, w19_1,
										w20_1, w21_1, w22_1, w23_1, w24_1, w25_1, w26_1, w27_1, w28_1, w29_1} = 29'b0; 
					out1 = out0_1;
				end
			1: begin w1_1 = w1; {w0_1, w2_1, w3_1, w4_1, w5_1, w6_1, w7_1, w8_1, w9_1,
										w10_1, w11_1, w12_1, w13_1, w14_1, w15_1, w16_1, w17_1, w18_1, w19_1,
										w20_1, w21_1, w22_1, w23_1, w24_1, w25_1, w26_1, w27_1, w28_1, w29_1} = 29'b0; 
					out1 = out1_1;
				end
			2: begin w2_1 = w1; {w0_1, w1_1, w3_1, w4_1, w5_1, w6_1, w7_1, w8_1, w9_1,
										w10_1, w11_1, w12_1, w13_1, w14_1, w15_1, w16_1, w17_1, w18_1, w19_1,
										w20_1, w21_1, w22_1, w23_1, w24_1, w25_1, w26_1, w27_1, w28_1, w29_1} = 29'b0; 
					out1 = out2_1;
				end
			3: begin w3_1 = w1; {w0_1, w1_1, w2_1, w4_1, w5_1, w6_1, w7_1, w8_1, w9_1,
										w10_1, w11_1, w12_1, w13_1, w14_1, w15_1, w16_1, w17_1, w18_1, w19_1,
										w20_1, w21_1, w22_1, w23_1, w24_1, w25_1, w26_1, w27_1, w28_1, w29_1} = 29'b0; 
					out1 = out3_1;
				end
			4: begin w4_1 = w1; {w0_1, w1_1, w2_1, w3_1, w5_1, w6_1, w7_1, w8_1, w9_1,
										w10_1, w11_1, w12_1, w13_1, w14_1, w15_1, w16_1, w17_1, w18_1, w19_1,
										w20_1, w21_1, w22_1, w23_1, w24_1, w25_1, w26_1, w27_1, w28_1, w29_1} = 29'b0; 
					out1 = out4_1;
				end
			5: begin w5_1 = w1; {w0_1, w1_1, w2_1, w3_1, w4_1, w6_1, w7_1, w8_1, w9_1,
										w10_1, w11_1, w12_1, w13_1, w14_1, w15_1, w16_1, w17_1, w18_1, w19_1,
										w20_1, w21_1, w22_1, w23_1, w24_1, w25_1, w26_1, w27_1, w28_1, w29_1} = 29'b0; 
					out1 = out5_1;
				end
			6: begin w6_1 = w1; {w0_1, w1_1, w2_1, w3_1, w4_1, w5_1, w7_1, w8_1, w9_1,
										w10_1, w11_1, w12_1, w13_1, w14_1, w15_1, w16_1, w17_1, w18_1, w19_1,
										w20_1, w21_1, w22_1, w23_1, w24_1, w25_1, w26_1, w27_1, w28_1, w29_1} = 29'b0; 
					out1 = out6_1;
				end
			7: begin w7_1 = w1; {w0_1, w1_1, w2_1, w3_1, w4_1, w5_1, w6_1, w8_1, w9_1,
										w10_1, w11_1, w12_1, w13_1, w14_1, w15_1, w16_1, w17_1, w18_1, w19_1,
										w20_1, w21_1, w22_1, w23_1, w24_1, w25_1, w26_1, w27_1, w28_1, w29_1} = 29'b0; 
					out1 = out7_1;
				end
			8: begin w8_1 = w1; {w0_1, w1_1, w2_1, w3_1, w4_1, w5_1, w6_1, w7_1, w9_1,
										w10_1, w11_1, w12_1, w13_1, w14_1, w15_1, w16_1, w17_1, w18_1, w19_1,
										w20_1, w21_1, w22_1, w23_1, w24_1, w25_1, w26_1, w27_1, w28_1, w29_1} = 29'b0; 
					out1 = out8_1;
				end
			9: begin w9_1 = w1; {w0_1, w1_1, w2_1, w3_1, w4_1, w5_1, w6_1, w7_1, w8_1, 
										w10_1, w11_1, w12_1, w13_1, w14_1, w15_1, w16_1, w17_1, w18_1, w19_1,
										w20_1, w21_1, w22_1, w23_1, w24_1, w25_1, w26_1, w27_1, w28_1, w29_1} = 29'b0; 
					out1 = out9_1;
				end
			10: begin w10_1 = w1; {w0_1, w1_1, w2_1, w3_1, w4_1, w5_1, w6_1, w7_1, w8_1, w9_1,
										w11_1, w12_1, w13_1, w14_1, w15_1, w16_1, w17_1, w18_1, w19_1,
										w20_1, w21_1, w22_1, w23_1, w24_1, w25_1, w26_1, w27_1, w28_1, w29_1} = 29'b0; 
					out1 = out10_1;
				end
			11: begin w11_1 = w1; {w0_1, w1_1, w2_1, w3_1, w4_1, w5_1, w6_1, w7_1, w8_1, w9_1,
										w10_1, w12_1, w13_1, w14_1, w15_1, w16_1, w17_1, w18_1, w19_1,
										w20_1, w21_1, w22_1, w23_1, w24_1, w25_1, w26_1, w27_1, w28_1, w29_1} = 29'b0; 
					out1 = out11_1;
				end
			12: begin w12_1 = w1; {w0_1, w1_1, w2_1, w3_1, w4_1, w5_1, w6_1, w7_1, w8_1, w9_1,
										w10_1, w11_1, w13_1, w14_1, w15_1, w16_1, w17_1, w18_1, w19_1,
										w20_1, w21_1, w22_1, w23_1, w24_1, w25_1, w26_1, w27_1, w28_1, w29_1} = 29'b0; 
					out1 = out12_1;
				end
			13: begin w13_1 = w1; {w0_1, w1_1, w2_1, w3_1, w4_1, w5_1, w6_1, w7_1, w8_1, w9_1,
										w10_1, w11_1, w12_1, w14_1, w15_1, w16_1, w17_1, w18_1, w19_1,
										w20_1, w21_1, w22_1, w23_1, w24_1, w25_1, w26_1, w27_1, w28_1, w29_1} = 29'b0; 
					out1 = out13_1;
				end
			14: begin w14_1 = w1; {w0_1, w1_1, w2_1, w3_1, w4_1, w5_1, w6_1, w7_1, w8_1, w9_1,
										w10_1, w11_1, w12_1, w13_1, w15_1, w16_1, w17_1, w18_1, w19_1,
										w20_1, w21_1, w22_1, w23_1, w24_1, w25_1, w26_1, w27_1, w28_1, w29_1} = 29'b0; 
					out1 = out14_1;
				end
			15: begin w15_1 = w1; {w0_1, w1_1, w2_1, w3_1, w4_1, w5_1, w6_1, w7_1, w8_1, w9_1,
										w10_1, w11_1, w12_1, w13_1, w14_1, w16_1, w17_1, w18_1, w19_1,
										w20_1, w21_1, w22_1, w23_1, w24_1, w25_1, w26_1, w27_1, w28_1, w29_1} = 29'b0; 
					out1 = out15_1;
				end
			16: begin w16_1 = w1; {w0_1, w1_1, w2_1, w3_1, w4_1, w5_1, w6_1, w7_1, w8_1, w9_1,
										w10_1, w11_1, w12_1, w13_1, w14_1, w15_1, w17_1, w18_1, w19_1,
										w20_1, w21_1, w22_1, w23_1, w24_1, w25_1, w26_1, w27_1, w28_1, w29_1} = 29'b0; 
					out1 = out16_1;
				end
			17: begin w17_1 = w1; {w0_1, w1_1, w2_1, w3_1, w4_1, w5_1, w6_1, w7_1, w8_1, w9_1,
										w10_1, w11_1, w12_1, w13_1, w14_1, w15_1, w16_1, w18_1, w19_1,
										w20_1, w21_1, w22_1, w23_1, w24_1, w25_1, w26_1, w27_1, w28_1, w29_1} = 29'b0; 
					out1 = out17_1;
				end
			18: begin w18_1 = w1; {w0_1, w1_1, w2_1, w3_1, w4_1, w5_1, w6_1, w7_1, w8_1, w9_1,
										w10_1, w11_1, w12_1, w13_1, w14_1, w15_1, w16_1, w17_1, w19_1,
										w20_1, w21_1, w22_1, w23_1, w24_1, w25_1, w26_1, w27_1, w28_1, w29_1} = 29'b0; 
					out1 = out18_1;
				end
			19: begin w19_1 = w1; {w0_1, w1_1, w2_1, w3_1, w4_1, w5_1, w6_1, w7_1, w8_1, w9_1,
										w10_1, w11_1, w12_1, w13_1, w14_1, w15_1, w16_1, w17_1, w18_1, 
										w20_1, w21_1, w22_1, w23_1, w24_1, w25_1, w26_1, w27_1, w28_1, w29_1} = 29'b0; 
					out1 = out19_1;
				end
			20: begin w20_1 = w1; {w0_1, w1_1, w2_1, w3_1, w4_1, w5_1, w6_1, w7_1, w8_1, w9_1,
										w10_1, w11_1, w12_1, w13_1, w14_1, w15_1, w16_1, w17_1, w18_1, w19_1,
										w21_1, w22_1, w23_1, w24_1, w25_1, w26_1, w27_1, w28_1, w29_1} = 29'b0; 
					out1 = out20_1;
				end
			21: begin w21_1 = w1; {w0_1, w1_1, w2_1, w3_1, w4_1, w5_1, w6_1, w7_1, w8_1, w9_1,
										w10_1, w11_1, w12_1, w13_1, w14_1, w15_1, w16_1, w17_1, w18_1, w19_1,
										w20_1, w22_1, w23_1, w24_1, w25_1, w26_1, w27_1, w28_1, w29_1} = 29'b0; 
					out1 = out21_1;
				end
			22: begin w22_1 = w1; {w0_1, w1_1, w2_1, w3_1, w4_1, w5_1, w6_1, w7_1, w8_1, w9_1,
										w10_1, w11_1, w12_1, w13_1, w14_1, w15_1, w16_1, w17_1, w18_1, w19_1,
										w20_1, w21_1, w23_1, w24_1, w25_1, w26_1, w27_1, w28_1, w29_1} = 29'b0; 
					out1 = out22_1;
				end
			23: begin w23_1 = w1; {w0_1, w1_1, w2_1, w3_1, w4_1, w5_1, w6_1, w7_1, w8_1, w9_1,
										w10_1, w11_1, w12_1, w13_1, w14_1, w15_1, w16_1, w17_1, w18_1, w19_1,
										w20_1, w21_1, w22_1, w24_1, w25_1, w26_1, w27_1, w28_1, w29_1} = 29'b0; 
					out1 = out23_1;
				end
			24: begin w24_1 = w1; {w0_1, w1_1, w2_1, w3_1, w4_1, w5_1, w6_1, w7_1, w8_1, w9_1,
										w10_1, w11_1, w12_1, w13_1, w14_1, w15_1, w16_1, w17_1, w18_1, w19_1,
										w20_1, w21_1, w22_1, w23_1, w25_1, w26_1, w27_1, w28_1, w29_1} = 29'b0; 
					out1 = out24_1;
				end
			25: begin w25_1 = w1; {w0_1, w1_1, w2_1, w3_1, w4_1, w5_1, w6_1, w7_1, w8_1, w9_1,
										w10_1, w11_1, w12_1, w13_1, w14_1, w15_1, w16_1, w17_1, w18_1, w19_1,
										w20_1, w21_1, w22_1, w23_1, w24_1, w26_1, w27_1, w28_1, w29_1} = 29'b0; 
					out1 = out25_1;
				end
			26: begin w26_1 = w1; {w0_1, w1_1, w2_1, w3_1, w4_1, w5_1, w6_1, w7_1, w8_1, w9_1,
										w10_1, w11_1, w12_1, w13_1, w14_1, w15_1, w16_1, w17_1, w18_1, w19_1,
										w20_1, w21_1, w22_1, w23_1, w24_1, w25_1, w27_1, w28_1, w29_1} = 29'b0; 
					out1 = out26_1;
				end
			27: begin w27_1 = w1; {w0_1, w1_1, w2_1, w3_1, w4_1, w5_1, w6_1, w7_1, w8_1, w9_1,
										w10_1, w11_1, w12_1, w13_1, w14_1, w15_1, w16_1, w17_1, w18_1, w19_1,
										w20_1, w21_1, w22_1, w23_1, w24_1, w25_1, w26_1, w28_1, w29_1} = 29'b0; 
					out1 = out27_1;
				end
			28: begin w28_1 = w1; {w0_1, w1_1, w2_1, w3_1, w4_1, w5_1, w6_1, w7_1, w8_1, w9_1,
										w10_1, w11_1, w12_1, w13_1, w14_1, w15_1, w16_1, w17_1, w18_1, w19_1,
										w20_1, w21_1, w22_1, w23_1, w24_1, w25_1, w26_1, w27_1, w29_1} = 29'b0; 
					out1 = out28_1;
				end
			29: begin w29_1 = w1; {w0_1, w1_1, w2_1, w3_1, w4_1, w5_1, w6_1, w7_1, w8_1, w9_1,
										w10_1, w11_1, w12_1, w13_1, w14_1, w15_1, w16_1, w17_1, w18_1, w19_1,
										w20_1, w21_1, w22_1, w23_1, w24_1, w25_1, w26_1, w27_1, w28_1} = 29'b0; 
					out1 = out29_1;
				end
			default: begin {w0_1, w1_1, w2_1, w3_1, w4_1, w5_1, w6_1, w7_1, w8_1, w9_1,
										w10_1, w11_1, w12_1, w13_1, w14_1, w15_1, w16_1, w17_1, w18_1, w19_1,
										w20_1, w21_1, w22_1, w23_1, w24_1, w25_1, w26_1, w27_1, w28_1, w29_1} = 30'b0; 
					out1 = out0_1;
				end
			
		endcase
	end
endmodule