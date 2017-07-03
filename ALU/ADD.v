module ari(A,B,Sign,ALUFun,S,z,v,n);
  input [31:0] A,B;
  input [5:0] ALUFun;
  input Sign; //1???
  output reg [31:0] S;
  output z,v,n;
  
  reg z,v,n;
  wire [31:0] a,b;
  
  assign a=(A[31]==0)?A:(~A+1);
  assign b=(B[31]==0)?B:(~B+1);

  
  always @(*) begin
  case(ALUFun[0])
    1'b0:begin
      S=A+B;
      z=(S==0)?0:1;
      case(Sign)
      1'b1:begin
        v=(!A[31]&&!B[31]&&S[31])||(A[31]&&B[31]&&!S[31]);
        if(A[31]^B[31])
          n=S[31];
        else n=A[31];
        end
      1'b0:begin
        v=(A[31]&&B[31])||(((A[31]^B[31])&&!S[31]));
        n=0;
        end
      endcase
    end
    1'b1:begin
      S=a+b;//?????
      z=(S==0)?0:1;
      case(Sign)
      1'b1:begin
        v=((!A[31])&&(B[31])&&(S[31]))||((A[31])&&(!B[31])&&(!S[31]));
        if(!(A[31]^B[31]))
          n=S[31];
        else n=A[31];
        end
      1'b0:begin
        v=(!A[31]&&B[31])||(((A[31]^~B[31])&&S[31]));
        if(!(A[31]^B[31]))
          n=S[31];
        else n=A[31];
        end
      endcase
    end
  endcase
  end
endmodule

          
          
        