
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
			   do_VGA=0;
				colour_to_draw<=input_colour1;     
				OutX<=X1+counter[0];
				OutY<=7'b1101110+counter[3:1];
				counter<=counter+1;          
			end


		5'b00011:
			begin
			   do_VGA=0;
				colour_to_draw<=input_colour2;     
				OutX<=X2+counter[0];
				OutY<=7'b1101110+counter[3:1];
				counter<=counter+1;          
			end

		5'b00100:
			begin
			   do_VGA=0;
				colour_to_draw<=input_colour3;     
				OutX<=X3+counter[0];
				OutY<=7'b1101110+counter[3:1];
				counter<=counter+1;          
			end

		5'b00101:
			begin
			   do_VGA=0;
				colour_to_draw<=input_colour4;     
				OutX<=X4+counter[0];
				OutY<=7'b1101110+counter[3:1];
				counter<=counter+1;          
			end

		5'b00110:
			begin
			   do_VGA=0;
				colour_to_draw<=input_colour5;     
				OutX<=X5+counter[0];
				OutY<=7'b1101110+counter[3:1];
				counter<=counter+1;          
			end

		5'b00111:
			begin
			   do_VGA=0;
				colour_to_draw<=input_colour6;     
				OutX<=X6+counter[0];
				OutY<=7'b1101110+counter[3:1];
				counter<=counter+1;          
			end

		5'b01000:
			begin
			   do_VGA=0;
				colour_to_draw<=input_colour7;     
				OutX<=X7+counter[0];
				OutY<=7'b1101110+counter[3:1];
				counter<=counter+1;          
			end

		5'b01001:
			begin
			   do_VGA=0;
				colour_to_draw<=input_colour8;     
				OutX<=X8+counter[0];
				OutY<=7'b1101110+counter[3:1];
				counter<=counter+1;          
			end

		5'b01010:
			begin
			   do_VGA=0;
				colour_to_draw<=input_colour9;     
				OutX<=X9+counter[0];
				OutY<=7'b1101110+counter[3:1];
				counter<=counter+1;          
			end

		5'b01011:
			begin
			   do_VGA=0;
				colour_to_draw<=input_colour10;     
				OutX<=X10+counter[0];
				OutY<=7'b1101110+counter[3:1];
				counter<=counter+1;          
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
					tempY <=7'b1100100;
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


