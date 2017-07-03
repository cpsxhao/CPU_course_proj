module Shift_Tb;
  reg [31:0] A1,B1;//A2,B2,A3,B3;
  reg [5:0] ALUFun1,ALUFun2,ALUFun3;
  
  wire[31:0] Z1,Z2,Z3;
  
  initial begin
    A1=32'b0000_0000_0000_0000_0000_0000_0000_1000;
    B1=32'b1011_0011_1000_1111_0000_1111_1000_0011;
    
    /*A2=32'b0000_0000_0000_0000_0000_0000_0000_1000;
    B2=32'b1011_0011_1000_1111_0000_1111_1000_0011;
    
    A3=32'b0000_0000_0000_0000_0000_0000_0000_1000;
    B3=32'b1011_0011_1000_1111_0000_1111_1000_0011;
    */
    ALUFun1=6'b100000;
    ALUFun2=6'b100001;
    ALUFun3=6'b100011;
  end
  
  Shift sll(.A(A1),.B(B1),.ALUFun(ALUFun1),.S(Z1));
  Shift srl(.A(A1),.B(B1),.ALUFun(ALUFun2),.S(Z2));
  Shift sra(.A(A1),.B(B1),.ALUFun(ALUFun3),.S(Z3));
  
  always begin
    #2 begin
    A1=~A1;
    B1=~B1;
    /*A2=~A2;
    B2=~B2;
    A3=~A3;
    B3=~B3;*/
  end
  end
endmodule
