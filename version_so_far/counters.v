module counter_4Hz(CLK, resetn, EnableSignal); // 4Hz Enable
	output reg EnableSignal; 
	reg [23:0]cout;
	input CLK, resetn;
	
	always@(posedge CLK)
		begin 
			if(!resetn)
				begin
					cout <= 24'b0;
					EnableSignal <= 0;
				end

			else if(cout == 24'b101111101011110000100000)
				begin
					cout <= 24'b0;
					EnableSignal <= 1;
				end

			else
				begin
					cout <= cout + 1;
					EnableSignal <= 0;
				end

		end
endmodule 


module counter160_64Hz(Enable, Clock, crtState, counter160);
	input Enable, Clock;
	input [1:0]crtState;
	reg [7:0]temp;
	output [7:0]counter160;
	
	always @(posedge Clock)
		begin

		if (crtState ==2'b00)
			temp = 0;
		else 
			if(temp == 8'b10100001)
				begin
					temp <= 0;
				end
			else
				if (Enable) 
					temp <= temp + 1;
		end
		
	assign counter160 = temp;
endmodule

module counter_64Hz(CLK, resetn, EnableSignal); // 64Hz Enable
	output reg EnableSignal; 
	reg [19:0]cout;
	input CLK, resetn;
	
	always@(posedge CLK)
		begin 
			if(!resetn)
				begin
					cout <= 20'b0;
					EnableSignal <= 0;
				end

			else if(cout == 20'b10111110101111000010)
				begin
					cout <= 20'b0;
					EnableSignal <= 1;
				end

			else
				begin
					cout <= cout + 1;
					EnableSignal <= 0;
				end

		end
endmodule

module addressCounter(CLK, resetn, address);
	output reg [9:0]address;
	input CLK, resetn;
	
	always @(posedge CLK)
		begin
			if (!resetn)
				address <= 0;
			
			if (address == 10'b1111111111)
				address <= 0;
			else address <= address +1;
		end	
endmodule



//COUNTERS BY RUIZONG 

//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!


//Counter for background data sending out------------------------------------------------------------------------------//
module sequence_counter(CLOCK,signal);
	input CLOCK;
	output reg signal;
	reg [24:0]counter;
	always@(posedge CLOCK)
	begin
	if(counter==25'b0000000000000000001111100)
	    begin
		 counter<=0;
		 signal<=1;
		 end
		 
	else
		 begin 
		 counter<=counter+1;
		 signal<=0;
		 end
		 
		end
endmodule


//Couter for score board--------------------------------------------------------------------------------//
module halfmaxcounter(CLOCK,signal);
	input CLOCK;
	output reg signal;
	reg [24:0]counter;
	always@(posedge CLOCK)
	begin
	if(counter==25'b0000000000000000000000001)
	    begin
		 counter<=0;
		 signal<=1;
		 end
		 
	else
		 begin 
		 counter<=counter+1;
		 signal<=0;
		 end
		 
		end
endmodule


//Counter for background data sending out------------------------------------------------------------------------------//
module counter_60Hz(CLOCK,signal);
	input CLOCK;
	output reg signal;
	reg [24:0]counter;
	always@(posedge CLOCK)
	begin
	if(counter==25'd50000000)
	    begin
		 counter<=0;
		 signal<=1;
		 end
		 
	else
		 begin 
		 counter<=counter+1;
		 signal<=0;
		 end
		 
		end
endmodule
//------------------------------------------------------------------------------------------------------------//

module Newcounter(CLOCK,x_out,y_out,ADDRESS);
	input CLOCK;
	output reg [7:0]x_out;
	output reg [6:0]y_out;
	output reg [14:0]ADDRESS;
		
		
	always@(posedge CLOCK)
		
		begin
         
			if(ADDRESS==15'b100101100000000)
				ADDRESS=0;
				
			
  
			if(x_out == 8'b10011111)
				x_out <= 0;

			else
				x_out <= x_out + 1;

				
			if(y_out == 7'b1111000)
				y_out <= 0;

			else
				begin
						if (x_out == 8'b10011111)
						y_out <= y_out + 1;
				end
				
		
		ADDRESS=ADDRESS+1;

		end
		
endmodule