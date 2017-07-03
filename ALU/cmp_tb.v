
module cmp_tb;
  
  reg[31:0] A,B,Bt;
  reg [5:0] ALUFun0,ALUFun1,ALUFun2,ALUFun3,ALUFun4,ALUFun5,ALUFun6;
  reg Sign;
  
  wire[31:0] Z1,Z2,Z3,Z4,Z5,Z6,Z0,Z01;
  wire z0,v0,n0,z1,v1,n1;
  
  initial begin
    A=32'b0000_0000_0000_0000_0000_0000_0000_1000;
    B=32'b1011_0011_1000_1111_0000_1111_1000_0011;
    Bt=0;
  
    Sign=1;
    
    ALUFun0=6'b000001;
    ALUFun1=6'b110011;
    ALUFun2=6'b110001;
    ALUFun3=6'b110101;
    ALUFun4=6'b111101;
    ALUFun5=6'b111011;
    ALUFun6=6'b111111;
  end
   
   ari a(.A(A),.B(B),.Sign(Sign),.ALUFun(ALUFun0),.S(Z0),.z(z0),.v(v0),.n(n0));
   ari b(.A(A),.B(Bt),.Sign(Sign),.ALUFun(ALUFun0),.S(Z01),.z(z1),.v(v1),.n(n1));

   CMP EQ(.z(z0),.v(v0),.n(n0),.ALUFun(ALUFun1),.S(Z1));
   CMP NEQ(.z(z0),.v(v0),.n(n0),.ALUFun(ALUFun2),.S(Z2));
   CMP LT(.z(z0),.v(v0),.n(n0),.ALUFun(ALUFun3),.S(Z3));
   CMP LEZ(.z(z1),.v(v1),.n(n1),.ALUFun(ALUFun4),.S(Z4));
   CMP LTZ(.z(z1),.v(v1),.n(n1),.ALUFun(ALUFun5),.S(Z5));
   CMP GTZ(.z(z1),.v(v1),.n(n1),.ALUFun(ALUFun6),.S(Z6));  
  
  always begin
    #2 begin
    A=~A;
    B=~B;
  end
  end
endmodule

