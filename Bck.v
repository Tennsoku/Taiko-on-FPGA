module draw(SW,KEY,LEDR,CLOCK_50,VGA_CLK,   						//	VGA Clock
		VGA_HS,							//	VGA H_SYNC
		VGA_VS,							//	VGA V_SYNC
		VGA_BLANK,						//	VGA BLANK
		VGA_SYNC,						//	VGA SYNC
		VGA_R,   						//	VGA Red[9:0]
		VGA_G,	 						//	VGA Green[9:0]
		VGA_B );//	VGA Blue[9:0]
		
	input [7:0]SW;	
   input [1:0]KEY;
	input CLOCK_50;	
	
	output			VGA_CLK;   				//	VGA Clock
	output			VGA_HS;					//	VGA H_SYNC
	output			VGA_VS;					//	VGA V_SYNC
	output			VGA_BLANK;				//	VGA BLANK
	output			VGA_SYNC;				//	VGA SYNC
	output	[9:0]	VGA_R;   				//	VGA Red[9:0]
	output	[9:0]	VGA_G;	 				//	VGA Green[9:0]
	output	[9:0]	VGA_B;   				//	VGA Blue[9:0]
	output [1:0]LEDR;
	
	wire [7:0]Cx,Hx;
	wire [6:0]Cy,Hy;
	wire [14:0]ad,ad2;
	wire [2:0]color1,colorH,starting_image,finalColor;
	wire slower_signal;
	wire [7:0]finalx;
	wire [6:0]finaly;
	
	assign LEDR[0]=Cx[0];
	assign LEDR[1]=Cy[0];
		
	   slower_counter s(CLOCK_50,slower_signal);
		
		counter c(CLOCK_50,Cx,Cy,ad); //counter for 160*120 size//
		counterHit(CLOCK_50,Hx,Hy,ad2); //counter for Hit image (20*10 size)//
		  
	
		x_ychooser choose(SW[2],Cx,Cy,Cx,Cy,finalx,finaly,color1,starting_image,finalColor);
		
		ramBackground ram(ad,CLOCK_50,0,0,color1); //160*120 size//
		ramHit H(ad2,CLOCK_50,0,0,colorH);
		Sbackground start(ad,CLOCK_50,0,0,starting_image); //160*120 size//
		
		vga_adapter VGA(
			.resetn(KEY[1]),
			.clock(CLOCK_50),
			.colour(finalColor),
			.x(finalx),
			.y(finaly),
			.plot(1),
			/* Signals for the DAC to drive the monitor. */
			.VGA_R(VGA_R),
			.VGA_G(VGA_G),
			.VGA_B(VGA_B),
			.VGA_HS(VGA_HS),
			.VGA_VS(VGA_VS),
			.VGA_BLANK(VGA_BLANK),
			.VGA_SYNC(VGA_SYNC),
			.VGA_CLK(VGA_CLK));
		defparam VGA.RESOLUTION = "160x120";
		defparam VGA.MONOCHROME = "FALSE";
		defparam VGA.BITS_PER_COLOUR_CHANNEL = 1;
		defparam VGA.BACKGROUND_IMAGE = "black.mif";
		
endmodule 
module  counterHit(CLOCK,x_out,y_out,ADDRESS);
input CLOCK;
output reg [7:0]x_out;
output reg [6:0]y_out;
output reg [6:0]ADDRESS;

always@(posedge CLOCK)
		
		begin
         
			if(ADDRESS==7'd200)
				ADDRESS=0;
				
			
  
			if(x_out == 8'd139)
				x_out <= 8'd120;

			else
				x_out <= x_out + 1;

				
			if(y_out == 7'd109)
				y_out <= 7'd100;

			else
				begin
						if (x_out == 8'd140)
						y_out <= y_out + 1;
				end
				
		
		ADDRESS=ADDRESS+1;

		end
		
endmodule

		
module counter(CLOCK,x_out,y_out,ADDRESS);
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
		
module slower_counter(CLOCK,signal);
	input CLOCK;
	output reg signal;
	reg [22:0]counter;
	always@(posedge CLOCK)
	begin
	if(counter==23'b00000000100101101000000)
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
		
module x_ychooser(command,xin1,yin1,xin2,yin2,out_x,out_y,color1in,color2in,colorout);
output reg [7:0]out_x;
output reg [6:0]out_y;
input [7:0]xin1,xin2;
input [6:0]yin1,yin2;
input command;
input [2:0]color1in,color2in;
output reg [2:0]colorout;
always@(*)
begin
case(command)
1'b1: 
begin
out_x=xin1;
out_y=yin1;
colorout=color1in;
end

1'b0: 
begin
out_x=xin2;
out_y=yin2;		
colorout=color2in;
end		

endcase		
end

endmodule 		