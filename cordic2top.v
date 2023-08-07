module cordic2top(clk, reset, start, a, float);

input clk;
input reset;
input start;
input [31:0] a;

wire [21:0] z;
wire [21:0] cos_out;
output [31:0] float;

reg [2:0] sreg; 

initial sreg=3'b0;

wire sout=sreg[2];

floattofix flfxp(.clk(clk), .areset(reset), .a(a), .q(z));
	
CORDIC2 cordic(.clock(clk), .reset(reset), .start(sout), .z(z), .cos_out(cos_out)); 
	
fixtofloat fxpfl(.clk(clk), .areset(reset), .a(cos_out), .q(float));

always @(posedge clk) begin 
	sreg[2]<=sreg[1];
	sreg[1]<=sreg[0];
	sreg[0]<=start;
	end
	
	
	
	
	endmodule