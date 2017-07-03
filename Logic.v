module Logic(A,B,ALUFun,S);
  input [31:0] A,B;
  input [5:0] ALUFun;//[3:0]
  output reg[31:0] S;
  
  //reg S;
  
  always @(*) begin
    case(ALUFun[3:0])
      4'b1000:S=A&&B;
      4'b1110:S=A||B;
      4'b0110:S=A^B;
      4'b0001:S=!(A||B);
      4'b1010:S=A;
    endcase
  end
endmodule
  
