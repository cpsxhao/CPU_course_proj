module CMP(z,v,n,ALUFun,S);
  input z,v,n;
  input [5:0]ALUFun;//[3:1]
  output reg [31:0] S;
  
  //reg S;
  
  always @(*) begin
  case(ALUFun[3:1])
    3'b001:S=(z==0)?1:0;
    3'b000:S=(z==0)?0:1;
    3'b010:S=(n==1)?1:0;
    //LEZ LTZ GTZ question...
    3'b110:S=(n==1||z==0)?1:0;
    3'b101:S=(n==1)?1:0;
    3'b111:S=((n==0)&&(z==1))?1:0;
    default:S=0;
  endcase
end

endmodule
