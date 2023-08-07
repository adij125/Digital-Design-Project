`define K 22'b0010011011011101001110  // = 0.6072529350088814



module CORDIC1(
    clock,    // Master clock
    start,
	 reset,    // Master asynchronous reset (active-high)    // An input signal that the user of this module should set to high when computation should begin
    z, // Input angle
    cos_out  // Output value for cosine of angle
       // Output value for sine of angle
); 



input clock;
input reset;
input [21:0] z;
input  start;
output [21:0] cos_out; 

reg [21:0] cos; 



reg [21:0] angle;
reg [4:0] count;
reg state;

wire [21:0] cos_next;
reg [21:0] sin;
wire [21:0] sin_next;  
wire [21:0] angle_next;
wire [4:0] count_next; 

wire [21:0] cos_next2;
wire [21:0] sin_next2;  
wire [21:0] angle_next2;
wire [4:0] count_next2;

wire [21:0] cos_next3;
wire [21:0] sin_next3;  
wire [21:0] angle_next3;
wire [4:0] count_next3;

wire [21:0] cos_next4;
wire [21:0] sin_next4;  
wire [21:0] angle_next4;
wire [4:0] count_next4;



  reg [21:0] cos_start;         // Set up initial value for cos.
  reg [21:0] sin_start;
  reg [21:0] angle_start; // Latch input angle into the angle register.
  reg [4:0]  count_start;        // Set up counter.
        // Go to compute mode.
  reg			 en_start;
	reg new_start; 
	reg [21:0] prev_start ;


reg en_next;
reg en; 
reg state_start;
reg new_input;
reg input_next;

reg state_next;
reg [21:0] prev_input;
reg [21:0] cos_final;
reg [21:0] final_next; 

wire [21:0] cos_out = cos_final; 


cordicadder add1(.en(en),.cos(cos),.sin(sin),.angle(angle),.count(count),.cos_next(cos_next),.sin_next(sin_next),.angle_next(angle_next), 
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

 
initial begin
state<=0;
new_input<=1'b1;
input_next<=1'b1;
prev_input=22'd2;
end

always @(posedge clock or posedge reset) begin
    if (reset) begin
        cos <= 0;
        angle <= 0;
        count <= 0;
        state <= 0;
		  en<=0; 
		  new_input<=1;
	 end 
	 
	 
	 else if(~state&new_input)begin
       
		 cos<=cos_start; 
		 sin<=sin_start; 
		 angle<= angle_start; 
		 count<=count_start; 
		 state<=state_start;
		 en<=en_start;
		 new_input<=new_start;
		 prev_input<=prev_start;	

	end else begin
		  cos <= cos_next4;
        sin <= sin_next4;
        angle <= angle_next4;
        count <= count_next4;
        state <= state_next;
		  en<=en_next; 
		  prev_input<=z;
		  new_input<=input_next;
		  cos_final<=final_next;
		  end

		  
		  
		  end

//always @* begin
    // Set all logic regs to a value to prevent any of them holding the value
    // from last tick and hence being misinterpreted as hardware registers.
   // cos_next = cos;
   // sin_next = sin;
  //  angle_next = angle;
  //  count_next = count;
  //  state_next = state;



always@(*) begin

if(prev_input==z) begin
input_next=0;
end else begin 
input_next=1'b1;
end



if (state) begin
        // Compute mode.
        state_next<=1'b1; 
		  en_next<=1'b1;
			
		
		if (count_next4 == 5'd16) begin
            // If this is the last iteration, go back to the idle state.
            state_next <= 0;
        en_next<=1'b0;
		  final_next<=cos_next4;
		  end 

		  
    end else begin 
		if(start) begin 
		cos_start<=`K;
		sin_start<=0;
		angle_start<=z;
		new_start<=0; 
		prev_start<=z;
		en_start=1'b1;
		count_start<=0;
		state_start<=1;
		end else begin 
		state_start<=0; 
		new_start<=1'b1;

		end
		end 

 
end

endmodule