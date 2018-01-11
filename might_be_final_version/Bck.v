module drawB(Choose,CLOCK_50,finalx,finaly,finalColor);
		
	input [3:0]Choose;
	input CLOCK_50;	
	

	wire [7:0]Cx,Hx;
	wire [6:0]Cy,Hy;
	wire [14:0]ad,ad2;
	wire [2:0]gameBackground1,gameBackground2,gameBackground3,gameBackground4,gameBackground5,gameBackground6,colorH,starting_image,starting_image_letter;
	wire slower_signal;
	
	output [2:0]finalColor;
	output [7:0]finalx;
	output [6:0]finaly;
	


//-------------------------------------------------------------------------------------------//				
		counter c(CLOCK_50,Cx,Cy,ad); //counter for 160*120 size//
//-------------------------------------------------------------------------------------------//		  	
		x_ychooser choose(Choose,Cx,Cy,Cx,Cy,finalx,finaly,gameBackground1,gameBackground2,gameBackground3,gameBackground4,gameBackground5,gameBackground6,starting_image,starting_image_letter,finalColor);		
//-------------------------------------------------------------------------------------------//	
		Back1(ad,CLOCK_50,0,0,gameBackground1);
	   Back2(ad,CLOCK_50,0,0,gameBackground2);
		Back3(ad,CLOCK_50,0,0,gameBackground3);
		Back4(ad,CLOCK_50,0,0,gameBackground4);
		Back5(ad,CLOCK_50,0,0,gameBackground5);
		Back6(ad,CLOCK_50,0,0,gameBackground6);
				
//-------------------------------------------------------------------------------------------//		
		Sbackground start(ad,CLOCK_50,0,0,starting_image); //160*120 size//
//-------------------------------------------------------------------------------------------//		
      RamBack_withletter letter(ad,CLOCK_50,0,0,starting_image_letter);		
		
		
endmodule 

//.........................................................................//
		
module counter(CLOCK,x_out,y_out,ADDRESS);
	input CLOCK;
	output reg [7:0]x_out;
	output reg [6:0]y_out;
	output reg [14:0]ADDRESS;
		
		
	always@(posedge CLOCK)
		
		begin
         ADDRESS=ADDRESS+1;
			
			if(ADDRESS==15'b100101100000000)
				ADDRESS=0;
		
				
			x_out = x_out + 1;
  
			if(x_out == 8'b10100000)
			   begin
					x_out = 0;
					y_out =y_out+1;
								
			      if(y_out == 7'b1111000)
				    y_out = 0;
				
				end

			else
				begin
					    y_out = y_out ;	
				end
				
		
		

		end
		
endmodule



			
//..............................................................................................//		
			
module x_ychooser(command,xin1,yin1,xin2,yin2,out_x,out_y,color1in,color2in,color3in,color4in,color5in,color6in,color7in,color8in,colorout);

output reg [7:0]out_x;
output reg [6:0]out_y;

input [7:0]xin1,xin2;
input [6:0]yin1,yin2;
input [3:0]command;
input [2:0]color1in,color2in,color3in,color4in,color5in,color6in,color7in,color8in;

output reg [2:0]colorout;

	always@(*)
	begin
		case(command[3:0])
			4'b0000: 
			begin
			out_x=xin1;
			out_y=yin1;
			colorout=color1in;
			end

			4'b0001: 
			begin
			out_x=xin2;
			out_y=yin2;		
			colorout=color2in;
			end		
			
			4'b0010:
			begin
			out_x=xin2;
			out_y=yin2;		
			colorout=color3in;
			end
			
			4'b0011:
			begin
			out_x=xin2;
			out_y=yin2;		
			colorout=color4in;
			end

			4'b0100:
			begin
			out_x=xin2;
			out_y=yin2;		
			colorout=color5in;
			end

			
			4'b0101: 
			begin
			out_x=xin2;
			out_y=yin2;		
			colorout=color6in;
			end

			
			4'b0110: //Starting one//
			begin
			out_x=xin2;
			out_y=yin2;		
			colorout=color7in;
			end
				
			4'b0111: //Starting two//
			begin
			out_x=xin2;
			out_y=yin2;		
			colorout=color8in;
			end
			
			//4'b0111:
			//begin
			//out_x=xin2;
			//out_y=yin2;		
			//colorout=color3in;
			//end

			
			

		endcase		
	end

endmodule 		