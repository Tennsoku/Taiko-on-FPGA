module top(SW,CLOCK_50,KEY,
		VGA_CLK,   						//	VGA Clock
		VGA_HS,							//	VGA H_SYNC
		VGA_VS,							//	VGA V_SYNC
		VGA_BLANK,						//	VGA BLANK
		VGA_SYNC,						//	VGA SYNC
		VGA_R,   						//	VGA Red[9:0]
		VGA_G,	 						//	VGA Green[9:0]
		VGA_B   						//	VGA Blue[9:0] 
		);
		
	input [6:0]SW;
	input [1:0]KEY;
	input CLOCK_50;
	wire [6:0]connect_y;
	wire [7:0]connect_x;
	wire [2:0]connect_color;
	
	output			VGA_CLK;   				//	VGA Clock
	output			VGA_HS;					//	VGA H_SYNC
	output			VGA_VS;					//	VGA V_SYNC
	output			VGA_BLANK;				//	VGA BLANK
	output			VGA_SYNC;				//	VGA SYNC
	output	[9:0]	VGA_R;   				//	VGA Red[9:0]
	output	[9:0]	VGA_G;	 				//	VGA Green[9:0]
	output	[9:0]	VGA_B;   

	Draw_circle draw(SW[6:0],SW[6:0],111,CLOCK_50,connect_x[7:0],connect_y[6:0],connect_color);
	
	
	vga_adapter VGA(
			.resetn(KEY[0]),
			.clock(CLOCK_50),
			.colour(connect_color),
			.x(connect_x),
			.y(connect_y),
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

module Draw_circle(x_in,y_in,color,CLOCK_50,x_out,y_out,color_out);
	input CLOCK_50;
	input [7:0]x_in;
	input [6:0]y_in;
	input [2:0]color;
	output reg [7:0]x_out;
	output reg [6:0]y_out;
	output reg [2:0]color_out;

	reg [2:0]count_x;
	reg [2:0]count_y;
	reg [1:0]width;

	always@(posedge CLOCK_50)
		begin	
			
			if(count_y==3'b000|count_y==3'b110)
				width = 2'b10;
			else if(count_y==3'b001|count_y==3'b101)
				width = 2'b01;
			else
				width = 2'b00;
				
			if ((count_x < width)|((3'b110-width)<count_x))
				color_out = 3'b000;
			else
				color_out = color;

				
			x_out[7:0] = x_in[7:0] + count_x[2:0];
			y_out[6:0] = y_in[6:0] + count_y[2:0];
				
				
			//////	

			if(count_x==3'b110)
			begin
				count_x<=0;
				if(count_y!=3'b110)
					count_y<=count_y+1;
			end
			else 
				count_x<=count_x+1;
			 
			if(count_y==3'b111)
				count_y<=0;
						
			
			/////
				
				

		end
endmodule



