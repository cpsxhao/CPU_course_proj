module ALU_tb;
  reg [31:0] A,B;
  reg Sign;
  reg [5:0] ALUFun1,ALUFun2,ALUFun3,ALUFun4;
  
  wire [31:0] Z1,Z2,Z3,Z4;
  

  
  /*initial begin
    A=32'b1010_1010_1010_1010_1010_1011_1011_1011;
    B=32'b1111_0000_0000_0000_0000_0000_0000_0000;
    Sign=0;
    ALUFun=6'b000000;
end*///unsign big+big

/*initial begin
    A=32'b1011_1010_1010_1010_1010_1011_1011_1011;
    B=32'b0111_0101_0000_0000_0000_0000_0000_0000;
    Sign=0;
    ALUFun=6'b000000;
end*///unsign big+small

/*initial begin
    A=32'b1010_1010_1010_1010_1010_1011_1011_1011;
    B=32'b1101_0101_0000_0000_0000_0000_0000_0000;
    Sign=1;
    ALUFun=6'b000000;
end*/ //sign neg+neg 

initial begin
    B=32'b1111_1111_1111_1111_1111_1111_1111_1111;
    A=32'b0000_0000_0000_0000_0000_0000_0000_0001;
    Sign=0;
    ALUFun1=6'b000000;
    ALUFun2=6'b011000;
    ALUFun3=6'b100000;
    ALUFun4=6'b110011;
end  //sign pos+pos

ALU a1(.A(A),.B(B),.ALUFun(ALUFun1),.Sign(Sign),.Z(Z1));
ALU a2(.A(A),.B(B),.ALUFun(ALUFun2),.Sign(Sign),.Z(Z2));
ALU a3(.A(A),.B(B),.ALUFun(ALUFun3),.Sign(Sign),.Z(Z3));
ALU a4(.A(A),.B(B),.ALUFun(ALUFun4),.Sign(Sign),.Z(Z4));



always begin
#2 A=~A;
#2 B=~B;
end
endmodule