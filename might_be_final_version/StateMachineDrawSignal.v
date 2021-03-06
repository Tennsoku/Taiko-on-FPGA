
module Processor(X1,X2,X3,X4,X5,X6,X7,X8,X9,X10,X11,X12,X13,X14,X15,XfirstDigit,XsecondDigit,YfirstDigit,YsecondDigit,Color1Digit,Color2Digit,
             Xbackground,Ybackground,BackgroundColor,
             CLK,command,OutX,OutY,				 
				 input_colour1, input_colour2, input_colour3, input_colour4, input_colour5, input_colour6, input_colour7, input_colour8,
				 input_colour9, input_colour10, input_colour11, input_colour12, input_colour13, input_colour14, input_colour15,				 
				 colour_to_draw,reset,enable,do_VGA);

//----------------------------------------------------------------------------------//
	input [7:0]X1,X2,X3,X4,X5,X6,X7,X8;
	input [7:0]X9,X10,X11,X12,X13,X14,X15;
	input [7:0]XfirstDigit,XsecondDigit,Xbackground;
	input [6:0]YfirstDigit,YsecondDigit,Ybackground;
//------------------------------------------------------------------------------------//
				
	input CLK,reset,enable;
//------------------------------------------------------------------------------------//
	input [2:0]input_colour1, input_colour2, input_colour3, input_colour4, input_colour5, input_colour6, input_colour7, input_colour8;
	input [2:0]input_colour9, input_colour10, input_colour11, input_colour12, input_colour13, input_colour14, input_colour15;
	input [2:0]Color1Digit,BackgroundColor,Color2Digit;
	input [4:0]command;
//------------------------------------------------------------------------------------//
	output reg [7:0]OutX;
	output reg [6:0]OutY;
	output reg [2:0]colour_to_draw;
	output reg do_VGA;
//------------------------------------------------------------------------------------//
	reg [3:0]counter;
	reg twoBitCounter;
	reg ifclear;
	reg [7:0]tempX;
	reg [6:0]tempY;
//------------------------------------------------------------------------------------//
wire [7:0]big_wire; 
wire [6:0]small_wire;
wire [3:0]small_x,small_y,big_x,big_y;
wire [2:0]red_small_colour,blue_small_colour;
wire [2:0]red_big_colour,blue_big_colour;
//Menmery block-----------------------------------------------------------------------//
red_face_small(small_wire,CLK,0,0,red_small_colour);
blue_face_small(small_wire,CLK,0,0,blue_small_colour);
face_red_big(big_wire,CLK,0,0,red_big_colour);
blue_face_big(big_wire,CLK,0,0,blue_big_colour);
//Counter-----------------------------------------------------------------------------//
small_counter small_counter(CLK,small_x,small_y,small_wire);
big_counter big_counter(CLK,big_x,big_y,big_wire);

	always@(posedge CLK) //50MHZ//


	begin
	case(command[4:0])  

	   5'b00000:
			begin
		      do_VGA=0;
			   colour_to_draw<=BackgroundColor;
				OutX<=Xbackground;
				OutY<=Ybackground;
		   end
		
		5'b00001:
			begin
            do_VGA=0;
			   colour_to_draw<=BackgroundColor;
				OutX<=Xbackground;
				OutY<=Ybackground;
			end
       
	
		5'b00010:
			begin
				if(input_colour1==3'b000)
					begin
						do_VGA=0;
						colour_to_draw<=input_colour1;     
						OutX<=X1+counter[0];
						OutY<=7'b1101110+counter[3:1];
						counter<=counter+1;
					end
			
				else if(input_colour1==3'b001)
					begin
						do_VGA=0;
						colour_to_draw<=red_small_colour;     
						OutX<=X1+small_x[3:0];
						OutY<=7'b1101110+small_y[3:0];
					end
			
				else if(input_colour1==3'b010)
					begin
						do_VGA=0;
						colour_to_draw<=blue_small_colour;     
						OutX<=X1+small_x[3:0];
						OutY<=7'b1101110+small_y[3:0];
					end
			   
				else if(input_colour1==3'b011)
					begin
						do_VGA=0;
						colour_to_draw<=red_big_colour;     
						OutX<=X1+big_x[3:0];
						OutY<=7'b1101110+big_y[3:0];
					end
				else
				   begin
						do_VGA=0;
						colour_to_draw<=blue_big_colour;     
						OutX<=X1+big_x[3:0];
						OutY<=7'b1101110+big_y[3:0];
					end
				
							 
			end


		5'b00011:
			begin
			   if(input_colour2==3'b000)
					begin
						do_VGA=0;
						colour_to_draw<=input_colour2;     
						OutX<=X2+counter[0];
						OutY<=7'b1101110+counter[3:1];
						counter<=counter+1;
					end
			
				else if(input_colour2==3'b001)
					begin
						do_VGA=0;
						colour_to_draw<=red_small_colour;     
						OutX<=X2+small_x[3:0];
						OutY<=7'b1101110+small_y[3:0];
					end
			
				else if(input_colour2==3'b010)
					begin
						do_VGA=0;
						colour_to_draw<=blue_small_colour;     
						OutX<=X2+small_x[3:0];
						OutY<=7'b1101110+small_y[3:0];
					end
			   
				else if(input_colour2==3'b011)
					begin
						do_VGA=0;
						colour_to_draw<=red_big_colour;     
						OutX<=X2+big_x[3:0];
						OutY<=7'b1101110+big_y[3:0];
					end
				else
				   begin
						do_VGA=0;
						colour_to_draw<=blue_big_colour;     
						OutX<=X2+big_x[3:0];
						OutY<=7'b1101110+big_y[3:0];
					end          
			end

		5'b00100:
			begin
			   if(input_colour3==3'b000)
					begin
						do_VGA=0;
						colour_to_draw<=input_colour1;     
						OutX<=X3+counter[0];
						OutY<=7'b1101110+counter[3:1];
						counter<=counter+1;
					end
			
				else if(input_colour3==3'b001)
					begin
						do_VGA=0;
						colour_to_draw<=red_small_colour;     
						OutX<=X3+small_x[3:0];
						OutY<=7'b1101110+small_y[3:0];
					end
			
				else if(input_colour3==3'b010)
					begin
						do_VGA=0;
						colour_to_draw<=blue_small_colour;     
						OutX<=X3+small_x[3:0];
						OutY<=7'b1101110+small_y[3:0];
					end
			   
				else if(input_colour3==3'b011)
					begin
						do_VGA=0;
						colour_to_draw<=red_big_colour;     
						OutX<=X3+big_x[3:0];
						OutY<=7'b1101110+big_y[3:0];
					end
				else
				   begin
						do_VGA=0;
						colour_to_draw<=blue_big_colour;     
						OutX<=X3+big_x[3:0];
						OutY<=7'b1101110+big_y[3:0];
					end          
			end

		5'b00101:
			begin
			 if(input_colour4==3'b000)
					begin
						do_VGA=0;
						colour_to_draw<=input_colour1;     
						OutX<=X4+counter[0];
						OutY<=7'b1101110+counter[3:1];
						counter<=counter+1;
					end
			
				else if(input_colour4==3'b001)
					begin
						do_VGA=0;
						colour_to_draw<=red_small_colour;     
						OutX<=X4+small_x[3:0];
						OutY<=7'b1101110+small_y[3:0];
					end
			
				else if(input_colour4==3'b010)
					begin
						do_VGA=0;
						colour_to_draw<=blue_small_colour;     
						OutX<=X4+small_x[3:0];
						OutY<=7'b1101110+small_y[3:0];
					end
			   
				else if(input_colour4==3'b011)
					begin
						do_VGA=0;
						colour_to_draw<=red_big_colour;     
						OutX<=X4+big_x[3:0];
						OutY<=7'b1101110+big_y[3:0];
					end
				else
				   begin
						do_VGA=0;
						colour_to_draw<=blue_big_colour;     
						OutX<=X4+big_x[3:0];
						OutY<=7'b1101110+big_y[3:0];
					end        
			end

		5'b00110:
			begin
			   if(input_colour5==3'b000)
					begin
						do_VGA=0;
						colour_to_draw<=input_colour1;     
						OutX<=X5+counter[0];
						OutY<=7'b1101110+counter[3:1];
						counter<=counter+1;
					end
			
				else if(input_colour5==3'b001)
					begin
						do_VGA=0;
						colour_to_draw<=red_small_colour;     
						OutX<=X5+small_x[3:0];
						OutY<=7'b1101110+small_y[3:0];
					end
			
				else if(input_colour5==3'b010)
					begin
						do_VGA=0;
						colour_to_draw<=blue_small_colour;     
						OutX<=X5+small_x[3:0];
						OutY<=7'b1101110+small_y[3:0];
					end
			   
				else if(input_colour5==3'b011)
					begin
						do_VGA=0;
						colour_to_draw<=red_big_colour;     
						OutX<=X5+big_x[3:0];
						OutY<=7'b1101110+big_y[3:0];
					end
				else
				   begin
						do_VGA=0;
						colour_to_draw<=blue_big_colour;     
						OutX<=X5+big_x[3:0];
						OutY<=7'b1101110+big_y[3:0];
					end          
			end

		5'b00111:
			begin
			   if(input_colour6==3'b000)
					begin
						do_VGA=0;
						colour_to_draw<=input_colour1;     
						OutX<=X6+counter[0];
						OutY<=7'b1101110+counter[3:1];
						counter<=counter+1;
					end
			
				else if(input_colour6==3'b001)
					begin
						do_VGA=0;
						colour_to_draw<=red_small_colour;     
						OutX<=X6+small_x[3:0];
						OutY<=7'b1101110+small_y[3:0];
					end
			
				else if(input_colour6==3'b010)
					begin
						do_VGA=0;
						colour_to_draw<=blue_small_colour;     
						OutX<=X6+small_x[3:0];
						OutY<=7'b1101110+small_y[3:0];
					end
			   
				else if(input_colour6==3'b011)
					begin
						do_VGA=0;
						colour_to_draw<=red_big_colour;     
						OutX<=X6+big_x[3:0];
						OutY<=7'b1101110+big_y[3:0];
					end
				else
				   begin
						do_VGA=0;
						colour_to_draw<=blue_big_colour;     
						OutX<=X6+big_x[3:0];
						OutY<=7'b1101110+big_y[3:0];
					end          
			end

		5'b01000:
			begin
			   if(input_colour7==3'b000)
					begin
						do_VGA=0;
						colour_to_draw<=input_colour1;     
						OutX<=X7+counter[0];
						OutY<=7'b1101110+counter[3:1];
						counter<=counter+1;
					end
			
				else if(input_colour7==3'b001)
					begin
						do_VGA=0;
						colour_to_draw<=red_small_colour;     
						OutX<=X7+small_x[3:0];
						OutY<=7'b1101110+small_y[3:0];
					end
			
				else if(input_colour7==3'b010)
					begin
						do_VGA=0;
						colour_to_draw<=blue_small_colour;     
						OutX<=X7+small_x[3:0];
						OutY<=7'b1101110+small_y[3:0];
					end
			   
				else if(input_colour7==3'b011)
					begin
						do_VGA=0;
						colour_to_draw<=red_big_colour;     
						OutX<=X7+big_x[3:0];
						OutY<=7'b1101110+big_y[3:0];
					end
				else
				   begin
						do_VGA=0;
						colour_to_draw<=blue_big_colour;     
						OutX<=X7+big_x[3:0];
						OutY<=7'b1101110+big_y[3:0];
					end        
			end

		5'b01001:
			begin
			   if(input_colour8==3'b000)
					begin
						do_VGA=0;
						colour_to_draw<=input_colour1;     
						OutX<=X8+counter[0];
						OutY<=7'b1101110+counter[3:1];
						counter<=counter+1;
					end
			
				else if(input_colour8==3'b001)
					begin
						do_VGA=0;
						colour_to_draw<=red_small_colour;     
						OutX<=X8+small_x[3:0];
						OutY<=7'b1101110+small_y[3:0];
					end
			
				else if(input_colour8==3'b010)
					begin
						do_VGA=0;
						colour_to_draw<=blue_small_colour;     
						OutX<=X8+small_x[3:0];
						OutY<=7'b1101110+small_y[3:0];
					end
			   
				else if(input_colour8==3'b011)
					begin
						do_VGA=0;
						colour_to_draw<=red_big_colour;     
						OutX<=X8+big_x[3:0];
						OutY<=7'b1101110+big_y[3:0];
					end
				else
				   begin
						do_VGA=0;
						colour_to_draw<=blue_big_colour;     
						OutX<=X8+big_x[3:0];
						OutY<=7'b1101110+big_y[3:0];
					end        
			end

		5'b01010:
			begin
			   if(input_colour9==3'b000)
					begin
						do_VGA=0;
						colour_to_draw<=input_colour1;     
						OutX<=X9+counter[0];
						OutY<=7'b1101110+counter[3:1];
						counter<=counter+1;
					end
			
				else if(input_colour9==3'b001)
					begin
						do_VGA=0;
						colour_to_draw<=red_small_colour;     
						OutX<=X9+small_x[3:0];
						OutY<=7'b1101110+small_y[3:0];
					end
			
				else if(input_colour9==3'b010)
					begin
						do_VGA=0;
						colour_to_draw<=blue_small_colour;     
						OutX<=X9+small_x[3:0];
						OutY<=7'b1101110+small_y[3:0];
					end
			   
				else if(input_colour9==3'b011)
					begin
						do_VGA=0;
						colour_to_draw<=red_big_colour;     
						OutX<=X9+big_x[3:0];
						OutY<=7'b1101110+big_y[3:0];
					end
				else
				   begin
						do_VGA=0;
						colour_to_draw<=blue_big_colour;     
						OutX<=X9+big_x[3:0];
						OutY<=7'b1101110+big_y[3:0];
					end          
			end

		5'b01011:
			begin
			   if(input_colour10==3'b000)
					begin
						do_VGA=0;
						colour_to_draw<=input_colour1;     
						OutX<=X10+counter[0];
						OutY<=7'b1101110+counter[3:1];
						counter<=counter+1;
					end
			
				else if(input_colour10==3'b001)
					begin
						do_VGA=0;
						colour_to_draw<=red_small_colour;     
						OutX<=X10+small_x[3:0];
						OutY<=7'b1101110+small_y[3:0];
					end
			
				else if(input_colour10==3'b010)
					begin
						do_VGA=0;
						colour_to_draw<=blue_small_colour;     
						OutX<=X10+small_x[3:0];
						OutY<=7'b1101110+small_y[3:0];
					end
			   
				else if(input_colour10==3'b011)
					begin
						do_VGA=0;
						colour_to_draw<=red_big_colour;     
						OutX<=X10+big_x[3:0];
						OutY<=7'b1101110+big_y[3:0];
					end
				else
				   begin
						do_VGA=0;
						colour_to_draw<=blue_big_colour;     
						OutX<=X10+big_x[3:0];
						OutY<=7'b1101110+big_y[3:0];
					end       
			end

		5'b01100:
			begin
			   do_VGA=0;
				colour_to_draw<=input_colour11;     
				OutX<=X11+counter[0];
				OutY<=7'b1101110+counter[3:1];
				counter<=counter+1;          
			end


		5'b01101:
			begin
			   do_VGA=0;
				colour_to_draw<=input_colour12;     
				OutX<=X12+counter[0];
				OutY<=7'b1101110+counter[3:1];
				counter<=counter+1;          
			end

		5'b01110:
			begin
			   do_VGA=0;
				colour_to_draw<=input_colour13;     
				OutX<=X13+counter[0];
				OutY<=7'b1101110+counter[3:1];
				counter<=counter+1;          
			end

		5'b01111:
			begin
			   do_VGA=0;
				colour_to_draw<=input_colour14;     
				OutX<=X14+counter[0];
				OutY<=7'b1101110+counter[3:1];
				counter<=counter+1;          
			end

		5'b10000:
			begin
			   do_VGA=0;
				colour_to_draw<=input_colour15;     
				OutX<=X15+counter[0];
				OutY<=7'b1101110+counter[3:1];
				counter<=counter+1;          
			end
			
	   5'b10001:
		   begin
			   do_VGA=0;
			   colour_to_draw<=Color1Digit;
				OutX<=XfirstDigit;
				OutY<=YfirstDigit;				
			end
		
		 5'b10010:
		   begin
			   do_VGA=0;
			   colour_to_draw<=Color2Digit;
				OutX<=XsecondDigit;
				OutY<=YsecondDigit;				
			end
		
			
		5'b10011:
		   begin
			   do_VGA=0;
			   colour_to_draw<=BackgroundColor;
				OutX<=Xbackground;
				OutY<=Ybackground;				
			end
		5'b10100:
		
		   begin
			   do_VGA=0;
				colour_to_draw<=3'b000;
				OutX<=tempX;
				OutY<=tempY;
				if(tempX == 8'b10100001)
					tempX <= 0;
				else
					tempX <= tempX + 1;

				if(tempY == 7'b1110111)
					tempY <=7'b1101010;
				else
					if (tempX == 8'b10100000)
						tempY <= tempY + 1;
				
		    end
		
		5'b10101:
		       do_VGA=1;
				 
	   5'b10110:;
		
		5'b10111:
		
			begin
			   do_VGA=0;
				colour_to_draw<=3'b111;     
				OutX<=8'b00011001;
				OutY<=7'b1101000+counter[3:0];
				counter<=counter+1;          
			end
		
		5'b11000:
			begin
			   do_VGA=0;
				colour_to_draw <= 3'b111;     
				OutX<=8'b00100100;
				OutY<=7'b1101000+counter[3:0];
				counter<=counter+1;          
			end
		
		5'b11001:
			begin
			   do_VGA=0;
				colour_to_draw<=3'b111;     
				OutX<=8'b00011110 + twoBitCounter;
				OutY<=7'b1101000+counter[3:0];
				twoBitCounter <= twoBitCounter + 1;
				counter<=counter + 1; 

			end
				 
	
		
	endcase 
	end


endmodule

//--------------------------------------------------------------------------------//
module small_counter(CLK,x_p,y_p,small_address);

input CLK;

output reg[6:0]small_address; 
output reg [3:0]x_p,y_p; 

always@(posedge CLK)
begin

small_address=small_address+1;

if(small_address==9'd81)
small_address=0;

x_p=x_p+1;

if(x_p==4'd9) //8//
	begin
		x_p=0;
		y_p=y_p+1;

		if(y_p==4'd9) //9//
			y_p=0;
	end

else
begin
y_p=y_p;
end





end


endmodule 
		

module big_counter(CLK,x_p,y_p,big_address);

input CLK;

output reg[7:0]big_address; 
output reg [3:0]x_p,y_p; 

always@(posedge CLK)
begin

big_address<=big_address+1;

if(big_address==9'd169)
big_address<=0;

x_p=x_p+1;

if(x_p==4'd13) //12//
	begin
		x_p=0;
		y_p=y_p+1;
	end

		if(y_p==4'd13) //13//
			y_p=0;
  
else
y_p=y_p;




end


endmodule 
		












