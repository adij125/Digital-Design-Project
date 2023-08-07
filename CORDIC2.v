`define K 22'b0010011011011101001110  // = 0.6072529350088814



module CORDIC2(
    clock,    // Master clock
    reset,    // Master asynchronous reset (active-high)
    start,    // An input signal that the user of this module should set to high when computation should begin
    z, // Input angle
    cos_out  // Output value for cosine of angle
       // Output value for sine of angle
); 




input clock;
input reset;
input start;
input [21:0] z;
output [21:0] cos_out; 





reg state;
reg en;

/*reg [21:0]  sreg2cos; 
reg [21:0]	sreg2sin;
reg [4:0]	sreg2count;
reg [21:0]	sreg2angle; 
*/

reg [21:0]  sreg4cos; 
reg [21:0]	sreg4sin;
reg [4:0]	sreg4count;
reg [21:0]	sreg4angle; 

/*reg [21:0]  sreg6cos; 
reg [21:0]	sreg6sin;
reg [4:0]	sreg6count;
reg [21:0]	sreg6angle; 
*/
reg [21:0]  sreg8cos; 
reg [21:0]	sreg8sin;
reg [4:0]	sreg8count;
reg [21:0]	sreg8angle;
/*
reg [21:0]  sreg10cos; 
reg [21:0]	sreg10sin;
reg [4:0]	sreg10count;
reg [21:0]	sreg10angle;
*/
reg [21:0]  sreg12cos; 
reg [21:0]	sreg12sin;
reg [4:0]	sreg12count;
reg [21:0]	sreg12angle;
/*
reg [21:0]  sreg14cos; 
reg [21:0]	sreg14sin;
reg [4:0]	sreg14count;
reg [21:0]	sreg14angle;
*/
reg [21:0]  sreg16cos; 
reg [21:0]	sreg16sin;
reg [4:0]	sreg16count;
reg [21:0]	sreg16angle;
/*wire [21:0] cosout2=sreg2cos; 
wire [21:0] sinout2=sreg2sin; 
wire [4:0] countout2=sreg2count; 
wire [21:0] angleout2=sreg2angle; 
*/
wire [21:0] cosout4=sreg4cos; 
wire [21:0] sinout4=sreg4sin; 
wire [4:0] countout4=sreg4count; 
wire [21:0] angleout4=sreg4angle;

/*wire [21:0] cosout6=sreg6cos; 
wire [21:0] sinout6=sreg6sin; 
wire [4:0] countout6=sreg6count; 
wire [21:0] angleout6=sreg6angle; 
*/
wire [21:0] cosout8=sreg8cos; 
wire [21:0] sinout8=sreg8sin; 
wire [4:0] countout8=sreg8count; 
wire [21:0] angleout8=sreg8angle; 

/*wire [21:0] cosout10=sreg10cos; 
wire [21:0] sinout10=sreg10sin; 
wire [4:0] countout10=sreg10count; 
wire [21:0] angleout10=sreg10angle; 
*/
wire [21:0] cosout12=sreg12cos; 
wire [21:0] sinout12=sreg12sin; 
wire [4:0] countout12=sreg12count; 
wire [21:0] angleout12=sreg12angle; 

/*wire [21:0] cosout16=sreg16cos; 
wire [21:0] sinout16=sreg16sin; 
wire [4:0] countout16=sreg16count; 
wire [21:0] angleout16=sreg16angle;
*/







wire [21:0] angle_next;
wire [21:0] sin_next;
wire [21:0] cos_next;
wire [4:0] count_next; 

wire [21:0] angle_next2;
wire [21:0] sin_next2;
wire [21:0] cos_next2;
wire [4:0] count_next2; 

wire [21:0] angle_next3;
wire [21:0] sin_next3;
wire [21:0] cos_next3;
wire [4:0] count_next3;  

wire [21:0] angle_next4;
wire [21:0] sin_next4;
wire [21:0] cos_next4;
wire [4:0] count_next4; 

wire [21:0] angle_next5;
wire [21:0] sin_next5;
wire [21:0] cos_next5;
wire [4:0] count_next5; 

wire [21:0] angle_next6;
wire [21:0] sin_next6;
wire [21:0] cos_next6;
wire [4:0] count_next6; 

wire [21:0] angle_next7;
wire [21:0] sin_next7;
wire [21:0] cos_next7;
wire [4:0] count_next7; 

wire [21:0] angle_next8;
wire [21:0] sin_next8;
wire [21:0] cos_next8;
wire [4:0] count_next8; 

wire [21:0] angle_next9;
wire [21:0] sin_next9;
wire [21:0] cos_next9;
wire [4:0] count_next9;

wire [21:0] angle_next10;
wire [21:0] sin_next10;
wire [21:0] cos_next10;
wire [4:0] count_next10; 


wire [21:0] angle_next11;
wire [21:0] sin_next11;
wire [21:0] cos_next11;
wire [4:0] count_next11; 


wire [21:0] angle_next12;
wire [21:0] sin_next12;
wire [21:0] cos_next12;
wire [4:0] count_next12; 


wire [21:0] angle_next13;
wire [21:0] sin_next13;
wire [21:0] cos_next13;
wire [4:0] count_next13; 


wire [21:0] angle_next14;
wire [21:0] sin_next14;
wire [21:0] cos_next14;
wire [4:0] count_next14; 


wire [21:0] angle_next15;
wire [21:0] sin_next15;
wire [21:0] cos_next15;
wire [4:0] count_next15; 


wire [21:0] angle_next16;
wire [21:0] sin_next16;
wire [21:0] cos_next16;
wire [4:0] count_next16; 




wire [21:0] cos_out = cos_next16;

cordicadder add1(.en(en),.cos(`K),.sin(0),.angle(z),.count(0),.cos_next(cos_next),.sin_next(sin_next),.angle_next(angle_next), 
.count_next(count_next)); 

cordicadder add2(.en(en),.cos(cos_next),.sin(sin_next),.angle(angle_next),.count(count_next),.cos_next(cos_next2),.sin_next(sin_next2),
.angle_next(angle_next2), 
.count_next(count_next2)); 

cordicadder add3(.en(en),.cos(cos_next2),.sin(sin_next2),.angle(angle_next2),.count(count_next2),.cos_next(cos_next3),.sin_next(sin_next3),
.angle_next(angle_next3), 
.count_next(count_next3)); 

cordicadder add4(.en(en),.cos(cos_next3),.sin(sin_next3),.angle(angle_next3),.count(count_next3),.cos_next(cos_next4),.sin_next(sin_next4),
.angle_next(angle_next4), 
.count_next(count_next4));  

cordicadder add5(.en(en),.cos(cosout4),.sin(sinout4),.angle(angleout4),.count(countout4),.cos_next(cos_next5),.sin_next(sin_next5),
.angle_next(angle_next5), 
.count_next(count_next5)); 

cordicadder add6(.en(en),.cos(cos_next5),.sin(sin_next5),.angle(angle_next5),.count(count_next5),.cos_next(cos_next6),.sin_next(sin_next6),
.angle_next(angle_next6), 
.count_next(count_next6)); 

cordicadder add7(.en(en),.cos(cos_next6),.sin(sin_next6),.angle(angle_next6),.count(count_next6),.cos_next(cos_next7),.sin_next(sin_next7),
.angle_next(angle_next7), 
.count_next(count_next7)); 

cordicadder add8(.en(en),.cos(cos_next7),.sin(sin_next7),.angle(angle_next7),.count(count_next7),.cos_next(cos_next8),.sin_next(sin_next8),
.angle_next(angle_next8), 
.count_next(count_next8)); 

cordicadder add9(.en(en),.cos(cosout8),.sin(sinout8),.angle(angleout8),.count(countout8),.cos_next(cos_next9),.sin_next(sin_next9),
.angle_next(angle_next9), 
.count_next(count_next9)); 

cordicadder add10(.en(en),.cos(cos_next9),.sin(sin_next9),.angle(angle_next9),.count(count_next9),.cos_next(cos_next10),.sin_next(sin_next10),
.angle_next(angle_next10), 
.count_next(count_next10)); 

cordicadder add11(.en(en),.cos(cos_next10),.sin(sin_next10),.angle(angle_next10),.count(count_next10),.cos_next(cos_next11),.sin_next(sin_next11),
.angle_next(angle_next11), 
.count_next(count_next11));  

cordicadder add12(.en(en),.cos(cos_next11),.sin(sin_next11),.angle(angle_next11),.count(count_next11),.cos_next(cos_next12),.sin_next(sin_next12),
.angle_next(angle_next12), 
.count_next(count_next12)); 

cordicadder add13(.en(en),.cos(cosout12),.sin(sinout12),.angle(angleout12),.count(countout12),.cos_next(cos_next13),.sin_next(sin_next13),
.angle_next(angle_next13), 
.count_next(count_next13)); 

cordicadder add14(.en(en),.cos(cos_next13),.sin(sin_next13),.angle(angle_next13),.count(count_next13),.cos_next(cos_next14),.sin_next(sin_next14),
.angle_next(angle_next14), 
.count_next(count_next14)); 

cordicadder add15(.en(en),.cos(cos_next14),.sin(sin_next14),.angle(angle_next14),.count(count_next14),.cos_next(cos_next15),.sin_next(sin_next15),
.angle_next(angle_next15), 
.count_next(count_next15)); 
 
cordicadder add16(.en(en),.cos(cos_next15),.sin(sin_next15),.angle(angle_next15),.count(count_next15),.cos_next(cos_next16),.sin_next(sin_next16),
.angle_next(angle_next16), 
.count_next(count_next16)); 



initial begin
	
//	sreg2cos=22'b0; 
	//sreg2sin=22'b0;
//	sreg2count=0;
//	sreg2angle=0;

	sreg4cos=22'b0; 
	sreg4sin=22'b0;
	sreg4count=0;
	sreg4angle=0;

/*	sreg6cos=22'b0; 
	sreg6sin=22'b0;
	sreg6count=0;
	sreg6angle=0;
*/
	 sreg8cos=0;
	 sreg8sin=0;
	 sreg8count=0;
	 sreg8angle=0; 
	 
/*	sreg10cos=22'b0; 
	sreg10sin=22'b0;
	sreg10count=0;
	sreg10angle=0;

*/	 
	 sreg12cos=0;
	 sreg12sin=0;
	 sreg12count=0;
	 sreg12angle=0;
	
	/*sreg16cos=22'b0; 
	sreg16sin=22'b0;
	sreg16count=0;
	sreg16angle=0;
*/
	end
always @(posedge clock or posedge reset) begin
    
	 
	 
	 
/*	 sreg2cos<=cos_next2;
	 sreg2sin<=sin_next2;
	 sreg2count<=count_next2;
	 sreg2angle<=angle_next2; 
	 
	*/ 
	 sreg4cos<=cos_next4;
	 sreg4sin<=sin_next4;
	 sreg4count<=count_next4;
	 sreg4angle<=angle_next4; 
	 
/*	 sreg6cos<=cos_next6;
	 sreg6sin<=sin_next6;
	 sreg6count<=count_next6;
	 sreg6angle<=angle_next6; 
*/	 
	 
	 sreg8cos<=cos_next8;
	 sreg8sin<=sin_next8;
	 sreg8count<=count_next8;
	 sreg8angle<=angle_next8; 
	 
	 sreg12cos<=cos_next12;
	 sreg12sin<=sin_next12;
	 sreg12count<=count_next12;
	 sreg12angle<=angle_next12; 
	 
//	 sreg14cos<=cos_next14;
//	 sreg14sin<=sin_next14;
//	 sreg14count<=count_next14;
//	 sreg14angle<=angle_next14; 
	/* sreg16cos<=cos_next16;
	 sreg16sin<=sin_next16;
	 sreg16count<=count_next16;
	 sreg16angle<=angle_next16;
	 */
	 
	 
	 if (reset) begin
        state <= 0;
		  en<=1'b0;
	 end  
   

else if(state) begin 
		 // cos <= count_next5;
       //sin <= sin_next5;
       // angle <= angle_next5;
       // count <= count_next5;
        en<=1'b1;
end 
else if(start) begin 
		
		en<=1'b1;
		state<=1'b1;

		end

end
endmodule