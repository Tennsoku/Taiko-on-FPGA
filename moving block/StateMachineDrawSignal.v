
module Processor(X1,X2,X3,X4,X5,X6,X7,X8,X9,X10,X11,X12,X13,X14,X15,

             CLK,command,OutX,OutY,
				 
				 input_colour1, input_colour2, input_colour3, input_colour4, input_colour5, input_colour6, input_colour7, input_colour8,
				 input_colour9, input_colour10, input_colour11, input_colour12, input_colour13, input_colour14, input_colour15,
				 
				 colour_to_draw,reset,enable);


	input [7:0]X1,X2,X3,X4,X5,X6,X7,X8;
	input [7:0]X9,X10,X11,X12,X13,X14,X15;

	input CLK,reset,enable;

	input [2:0]input_colour1, input_colour2, input_colour3, input_colour4, input_colour5, input_colour6, input_colour7, input_colour8;
	input [2:0]input_colour9, input_colour10, input_colour11, input_colour12, input_colour13, input_colour14, input_colour15;

	input [4:0]command;


	output reg [7:0]OutX;
	output reg [6:0]OutY;

	output reg [2:0]colour_to_draw;


	reg [3:0]counter;
	reg ifclear;
	reg [7:0]tempX;
	reg [6:0]tempY;


	always@(posedge CLK) //50MHZ//


	begin
	case(command[3:0])  

		4'b0000:
			begin
				colour_to_draw<=input_colour1;     
				OutX<=X1+counter[1:0];
				OutY<=7'b1101110+counter[3:2];
				counter<=counter+1;          
			end


		4'b0001:
			begin
				colour_to_draw<=input_colour2;     
				OutX<=X2+counter[1:0];
				OutY<=7'b1101110+counter[3:2];
				counter<=counter+1;          
			end

		4'b0010:
			begin
				colour_to_draw<=input_colour3;     
				OutX<=X3+counter[1:0];
				OutY<=7'b1101110+counter[3:2];
				counter<=counter+1;          
			end

		4'b0011:
			begin
				colour_to_draw<=input_colour4;     
				OutX<=X4+counter[1:0];
				OutY<=7'b1101110+counter[3:2];
				counter<=counter+1;          
			end

		4'b0100:
			begin
				colour_to_draw<=input_colour5;     
				OutX<=X5+counter[1:0];
				OutY<=7'b1101110+counter[3:2];
				counter<=counter+1;          
			end

		4'b0101:
			begin
				colour_to_draw<=input_colour6;     
				OutX<=X6+counter[1:0];
				OutY<=7'b1101110+counter[3:2];
				counter<=counter+1;          
			end

		4'b0110:
			begin
				colour_to_draw<=input_colour7;     
				OutX<=X7+counter[1:0];
				OutY<=7'b1101110+counter[3:2];
				counter<=counter+1;          
			end

		4'b0111:
			begin
				colour_to_draw<=input_colour8;     
				OutX<=X8+counter[1:0];
				OutY<=7'b1101110+counter[3:2];
				counter<=counter+1;          
			end

		4'b1000:
			begin
				colour_to_draw<=input_colour9;     
				OutX<=X9+counter[1:0];
				OutY<=7'b1101110+counter[3:2];
				counter<=counter+1;          
			end

		4'b1001:
			begin
				colour_to_draw<=input_colour10;     
				OutX<=X10+counter[1:0];
				OutY<=7'b1101110+counter[3:2];
				counter<=counter+1;          
			end

		4'b1010:
			begin
				colour_to_draw<=input_colour11;     
				OutX<=X11+counter[1:0];
				OutY<=7'b1101110+counter[3:2];
				counter<=counter+1;          
			end


		4'b1011:
			begin
				colour_to_draw<=input_colour12;     
				OutX<=X12+counter[1:0];
				OutY<=7'b1101110+counter[3:2];
				counter<=counter+1;          
			end

		4'b1100:
			begin
				colour_to_draw<=input_colour13;     
				OutX<=X13+counter[1:0];
				OutY<=7'b1101110+counter[3:2];
				counter<=counter+1;          
			end

		4'b1101:
			begin
				colour_to_draw<=input_colour14;     
				OutX<=X14+counter[1:0];
				OutY<=7'b1101110+counter[3:2];
				counter<=counter+1;          
			end

		4'b1110:
			begin
				colour_to_draw<=input_colour15;     
				OutX<=X15+counter[1:0];
				OutY<=7'b1101110+counter[3:2];
				counter<=counter+1;          
			end

		4'b1111:
			begin
				colour_to_draw<=3'b000;
				OutX<=tempX;
				OutY<=tempY;
				if(tempX == 8'b10100001)
					tempX <= 0;
				else
					tempX <= tempX + 1;

				if(tempY == 7'b1111001)
					tempY <= 0;
				else
					if (tempX == 8'b10100000)
						tempY <= tempY + 1;
				
			end
	endcase 
	end


endmodule


