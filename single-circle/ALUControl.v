/* 
	This Part should be designed in detail after the ALU module
	is completed.
*/

module ALUControl(ALUOp, Funct, ALUCtl, Sign);
	input [3:0] ALUOp;
	input [5:0] Funct;
	output reg [4:0] ALUCtl;
	output Sign;
	
	parameter aluADD = 6'b00_0000;
	parameter aluSUB = 6'b00_0001;
	parameter aluAND = 6'b01_1000;
	parameter aluOR  = 6'b01_1110;
	parameter aluXOR = 6'b01_0110;
	parameter aluNOR = 5'b01_0001;
	parameter aluA   = 6'b01_1010;
	parameter aluSLL = 6'b10_0000;
	parameter aluSRL = 6'b10_0001;
	parameter aluSRA = 6'b10_0011;
	parameter aluEQ  = 6'b11_0011;
	parameter aluNEQ = 6'b11_0001;
	parameter aluLT  = 6'b11_0101;
	parameter aluLEZ = 6'b11_1101;
	parameter aluLTZ = 6'b11_1011;
	parameter aluGTZ = 6'b11_1111;
	
	assign Sign = (ALUOp[2:0] == 3'b010)? ~Funct[0]: ~ALUOp[3];
	
	reg [4:0] aluFunct;
	always @(*)
		case (Funct)
			6'b00_0000: aluFunct <= aluSLL;
			6'b00_0010: aluFunct <= aluSRL;
			6'b00_0011: aluFunct <= aluSRA;
			6'b10_0000: aluFunct <= aluADD;
			6'b10_0001: aluFunct <= aluADD;
			6'b10_0010: aluFunct <= aluSUB;
			6'b10_0011: aluFunct <= aluSUB;
			6'b10_0100: aluFunct <= aluAND;
			6'b10_0101: aluFunct <= aluOR;
			6'b10_0110: aluFunct <= aluXOR;
			6'b10_0111: aluFunct <= aluNOR;
			6'b10_1010: aluFunct <= aluSLT;
			6'b10_1011: aluFunct <= aluSLT;
			default: aluFunct <= aluADD;
		endcase
	
	always @(*)
		case (ALUOp[2:0])
			3'b000: ALUCtl <= aluADD;
			3'b001: ALUCtl <= aluSUB;
			3'b100: ALUCtl <= aluAND;
			3'b101: ALUCtl <= aluSLT;
			3'b010: ALUCtl <= aluFunct;
			default: ALUCtl <= aluADD;
		endcase

endmodule
