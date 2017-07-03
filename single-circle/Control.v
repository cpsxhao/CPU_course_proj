
module Control(OpCode, Funct,
	PCSrc, Branch, RegWrite, RegDst, 
	MemRead, MemWrite, MemtoReg, 
	ALUSrc1, ALUSrc2, ExtOp, ALUOp);
	input [5:0] OpCode;
	input [5:0] Funct;
	output [1:0] PCSrc;
	output Branch;
	output RegWrite;
	output [1:0] RegDst;
	output MemRead;
	output MemWrite;
	output [1:0] MemtoReg;
	output ALUSrc1;
	output ALUSrc2;
	output ExtOp;
	output [3:0] ALUOp;
	
	assign PCSrc[1:0] = 
		(OpCode == 6'h02)? 2'b01: 
		(OpCode == 6'h03)? 2'b01: 
		(OpCode == 6'h00 && Funct == 6'h08)? 2'b10: 
		(OpCode == 6'h00 && Funct == 6'h09)? 2'b10: 
		2'b00;

	assign Branch = 
		(OpCode == 6'h04)? 1'b1:
		(OpCode == 6'h05)? 1'b1:
		1'b0;

	assign RegWrite = 
		(OpCode == 6'h2b)? 1'b0: 
		(OpCode == 6'h04)? 1'b0:
		(OpCode == 6'h05)? 1'b0: 
		(OpCode == 6'h02)? 1'b0: 
		(OpCode == 6'h00 && Funct == 6'h08)? 1'b0: 
		1'b1;

	assign RegDst = 
		(OpCode == 6'h23)? 2'b00: 
		(OpCode == 6'h0f)? 2'b00: 
		(OpCode == 6'h08)? 2'b00: 
		(OpCode == 6'h09)? 2'b00:
		(OpCode == 6'h0c)? 2'b00:
		(OpCode == 6'h0a)? 2'b00:
		(OpCode == 6'h0b)? 2'b00:
		(OpCode == 6'h03)? 2'b00:
		(OpCode == 6'h00 && Funct == 6'h09)? 2'b10: 
		2'b01;

	assign MemRead = 
		(OpCode == 6'h2b)? 1'b0: 
		(OpCode == 6'h04)? 1'b0:
		(OpCpde == 6'h05)? 1'b0: 
		(OpCode == 6'h02)? 1'b0:
		(OpCode == 6'h03)? 1'b0:
		(OpCode == 6'h00 && Funct == 6'h08)? 1'b0:
		(OpCode == 6'h00 && Funct == 6'h09)? 1'b0: 
		1'b1;

	assign MemWrite = 
		(OpCode == 6'h2b)? 1'b1: 
		1'b0;

	assign MemtoReg = 
		(OpCode == 6'h23)? 2'b01: 
		(OpCode == 6'h0f)? 2'b01: 
		(OpCode == 6'h00 && Funct == 6'h09)? 2'b10:
		(OpCode == 6'h03)? 2'b10:
		2'b00;

	assign ALUSrc1 =
		(OpCode == 6'h00 && Funct == 6'h00)? 1'b1:
		(OpCode == 6'h00 && Funct == 6'h02)? 1'b1:
		(OpCode == 6'h00 && Funct == 6'h03)? 1'b1:
		1'b0;

	assign ALUSrc2 = 
		(OpCode == 6'h23)? 1'b1:
		(OpCode == 6'h2b)? 1'b1:
		(OpCode == 6'h0f)? 1'b1:
		(OpCode == 6'h08)? 1'b1:
		(OpCode == 6'h09)? 1'b1:
		(OpCode == 6'h0a)? 1'b1:
		(OpCode == 6'h0b)? 1'b1:
		1'b0;

	assign ExtOp = 
		(OpCode == 6'h23)? 1'b1:
		(OpCode == 6'h2b)? 1'b1:
		(OpCode == 6'h08)? 1'b1:
		(OpCode == 6'h0c)? 1'b1:
		(OpCode == 6'h0a)? 1'b1:
		(OpCode == 6'h04)? 1'b1:
		(OpCode == 6'h05)? 1'b1:
		1'b0;

	assign ALUSrc2 = 
		(OpCode == 6'h0f)? 1'b1:
		1'b0;
	
	assign ALUOp[2:0] = 
		(OpCode == 6'h00)? 3'b010: 
		(OpCode == 6'h04)? 3'b001: 
		(OpCode == 6'h05)? 3'b001:
		(OpCode == 6'h0c)? 3'b100: 
		(OpCode == 6'h0a || OpCode == 6'h0b)? 3'b101: 
		3'b000;
		
	assign ALUOp[3] = OpCode[0];
	
endmodule