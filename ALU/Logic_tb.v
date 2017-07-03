
module Logic_tb;
  
  reg[31:0] A,B;
  reg [5:0] ALUFun1,ALUFun2,ALUFun3,ALUFun4,ALUFun5;
  
  wire [31:0] S1,S2,S3,S4,S5;
  
  initial begin
    A=32'd1;
    B=32'd0;
    
    ALUFun1=6'b011000;
    ALUFun2=6'b011110;
    ALUFun3=6'b010110;
    ALUFun4=6'b010001;
    ALUFun5=6'b011010;
  end
  
  Logic AND(.A(A),.B(B),.ALUFun(ALUFun1),.S(S1));
  Logic OR(.A(A),.B(B),.ALUFun(ALUFun2),.S(S2));
  Logic XOR(.A(A),.B(B),.ALUFun(ALUFun3),.S(S3));
  Logic NOR(.A(A),.B(B),.ALUFun(ALUFun4),.S(S4));
  Logic a(.A(A),.B(B),.ALUFun(ALUFun5),.S(S5));
  
  always begin
    #2 begin
    A=~A;
    B=~B;
  end
  end
endmodule
