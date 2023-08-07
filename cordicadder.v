
`define BETA_0  22'b0011001001000011111101  // = atan 2^0     = 0.7853981633974483
`define BETA_1  22'b0001110110101100011001  // = atan 2^(-1)  = 0.4636476090008061
`define BETA_2  22'b0000111110101101101110 // = atan 2^(-2)  = 0.24497866312686414
`define BETA_3  22'b0000011111110101011011 // = atan 2^(-3)  = 0.12435499454676144
`define BETA_4  22'b0000001111111110101010 // = atan 2^(-4)  = 0.06241880999595735
`define BETA_5  22'b0000000111111111110101 // = atan 2^(-5)  = 0.031239833430268277
`define BETA_6  22'b0000000011111111111110  // = atan 2^(-6)  = 0.015623728620476831
`define BETA_7  22'b0000000001111111111111 // = atan 2^(-7)  = 0.007812341060101111
`define BETA_8  22'b0000000000111111111111  // = atan 2^(-8)  = 0.0039062301319669718
`define BETA_9  22'b0000000000011111111111 // = atan 2^(-9)  = 0.0019531225164788188
`define BETA_10 22'b0000000000001111111111 // = atan 2^(-10) = 0.0009765621895593195
`define BETA_11 22'b0000000000000111111111 // = atan 2^(-11) = 0.0004882812111948983
`define BETA_12 22'b0000000000000011111111  // = atan 2^(-12) = 0.00024414062014936177
`define BETA_13 22'b0000000000000001111111 // = atan 2^(-13) = 0.00012207031189367021
`define BETA_14 22'b0000000000000000111111 // = atan 2^(-14) = 6.103515617420877e-05
`define BETA_15 22'b0000000000000000011111  // = atan 2^(-15) = 3.0517578115526096e-05
`define BETA_16 22'b0000000000000000001111 // = atan 2^(-16) = 1.5258789061315762e-05






module cordicadder(en,cos,sin,angle,cos_next,sin_next,angle_next,count,count_next); 


input en;
input  [21:0] cos;  
input [21:0] sin;
input   [21:0] angle; 
input [4:0] count;

output reg [21:0] cos_next; 
output reg [21:0] sin_next; 
output reg [21:0] angle_next; 
output reg [4:0] count_next;








wire [21:0] cos_signbits = {22{cos[21]}}; 
wire [21:0] cos_shr = {cos_signbits, cos} >> count; 
wire [21:0] sin_signbits = {22{sin[21]}}; 
wire [21:0] sin_shr = {sin_signbits, sin} >> count;

wire direction_negative = angle[21]; 

wire [21:0] beta_lut [0:16];
assign beta_lut[0] = `BETA_0;
assign beta_lut[1] = `BETA_1;
assign beta_lut[2] = `BETA_2;
assign beta_lut[3] = `BETA_3;
assign beta_lut[4] = `BETA_4;
assign beta_lut[5] = `BETA_5;
assign beta_lut[6] = `BETA_6;
assign beta_lut[7] = `BETA_7;
assign beta_lut[8] = `BETA_8;
assign beta_lut[9] = `BETA_9;
assign beta_lut[10] = `BETA_10;
assign beta_lut[11] = `BETA_11;
assign beta_lut[12] = `BETA_12;
assign beta_lut[13] = `BETA_13;
assign beta_lut[14] = `BETA_14;
assign beta_lut[15] = `BETA_15;
assign beta_lut[16] = `BETA_16;


wire [21:0] beta = beta_lut[count]; 

 always @(*) begin       
		 
		 if(en==1'b1) begin
		  
		   
		  cos_next = cos + (direction_negative ? sin_shr : -sin_shr);
        sin_next = sin + (direction_negative ? -cos_shr : cos_shr);
		  angle_next = angle + (direction_negative ? beta : -beta);
        count_next = count + 5'd1;
	
		 
		 
end
		end 
		 endmodule 