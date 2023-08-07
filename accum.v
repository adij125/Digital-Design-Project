`timescale 1ns/100ps

module accum(clk, areset, in, in2, acc); 

input clk, areset; 
input  [31:0] in; 
input  [31:0] in2;
output [31:0] acc;
wire   [31:0] add1_out;
wire   [31:0] add_out;
reg    [31:0] acc;


reg [95:0] sreg; 

wire[31:0] sout= sreg[95:64];

initial begin
 acc <= 32'd0;
 sreg <= 96'd0;
end
 
adder addition(.clk(clk), .areset(areset), .a(acc), .b(in), .q(add1_out)); 
 

adder addition2(.clk(clk), .areset(areset), .a(sout), .b(in2), .q(add_out));
 
always @(posedge clk) 

	begin 
	
		sreg[95:64]<=sreg[63:32];
		sreg[63:32]<=sreg[31:0];
		sreg[31:0]<=add1_out;
		
		if(areset) begin 
		acc <= 32'd0; 
		end else begin
		acc <= add_out;
	end
 end
  
endmodule 