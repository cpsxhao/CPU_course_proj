
module ALU(A,B,ALUFun,Sign,Z);
	input [31:0] A,B;
	input [5:0] ALUFun;
	input Sign;
	output [31:0] Z;
	
	wire z,v,n;
	wire z0,v0,n0,z1,v1,n1;
	wire [31:0] Z0,Z1,Z2,Z3,Z,Zt;
	
	wire [31:0] Bt;
	assign Bt=0;
		
	ari ia(.A(A),.B(B),.Sign(Sign),.ALUFun(ALUFun),.S(Zt),.z(z0),.v(v0),.n(n0));//EQ,NEQ,LT
	ari ai(.A(A),.B(Bt),.Sign(Sign),.ALUFun(ALUFun),.S(Zte),.z(z1),.v(v1),.n(n1)); ////LEZ LTZ GTZ
	
	ari ria(.A(A),.B(B),.Sign(Sign),.ALUFun(ALUFun),.S(Z0),.z(z),.v(v),.n(n));
	CMP cmp(.z(z0),.v(v0),.n(n0),.ALUFun(ALUFun),.S(Z1));
	Logic lo(.A(A),.B(B),.ALUFun(ALUFun),.S(Z2));
	Shift shi(.A(A),.B(B),.ALUFun(ALUFun),.S(Z3));
		
	assign Z=(ALUFun[5:4]==2'b00)?Z0:
		(ALUFun[5:4]==2'b11)?Z1:
		(ALUFun[5:4]==2'b01)?Z2:
		(ALUFun[5:4]==2'b10)?Z3:0;
		
endmodule
	
			