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