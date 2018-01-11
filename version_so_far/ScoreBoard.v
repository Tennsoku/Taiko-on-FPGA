module drawS(increment,CLOCK_50,Onex,Twox,Oney,Twoy,color1,color2);
	
   input increment;
	input CLOCK_50;	
	
	
	output [7:0]Onex,Twox;
	output [6:0]Oney,Twoy;
	output [2:0]color1,color2;
	
	wire  [8:0]Adnumber,AdnumberEmpty; //Numbers//
	wire [2:0]ZeroColor,OneColor,TwoColor,ThreeColor,FourColor,FiveColor,SixColor,SevenColor,EightColor,NineColor;
	wire [2:0]ZeroColor2,OneColor2,TwoColor2,ThreeColor2,FourColor2,FiveColor2,SixColor2,SevenColor2,EightColor2,NineColor2;
	wire slower_signal;//25MHZ//
	wire [3:0]DigitOne,DigitTwo;
	
	
	
	
	   slower_counter s(CLOCK_50,slower_signal);
		
		
		//..................................................................//
		ZeroIm Z(Adnumber,CLOCK_50,0,0,ZeroColor);
		OneIm O(Adnumber,CLOCK_50,0,0,OneColor);
		TwoIm T(Adnumber,CLOCK_50,0,0,TwoColor);
		ThreeIm TT(Adnumber,CLOCK_50,0,0,ThreeColor);
		FourIm F(Adnumber,CLOCK_50,0,0,FourColor);
		FiveIm FF(Adnumber,CLOCK_50,0,0,FiveColor);
		SixIm S(Adnumber,CLOCK_50,0,0,SixColor);
		SevenIm SS(Adnumber,CLOCK_50,0,0,SevenColor);
		EightIm E(Adnumber,CLOCK_50,0,0,EightColor);
		NineIm N(Adnumber,CLOCK_50,0,0,NineColor);
		
		
		//.................................................................//
		ZeroIm Z2(AdnumberEmpty,CLOCK_50,0,0,ZeroColor2);
		OneIm O2(AdnumberEmpty,CLOCK_50,0,0,OneColor2);
		TwoIm T2(AdnumberEmpty,CLOCK_50,0,0,TwoColor2);
		ThreeIm TT2(AdnumberEmpty,CLOCK_50,0,0,ThreeColor2);
		FourIm F2(AdnumberEmpty,CLOCK_50,0,0,FourColor2);
		FiveIm FF2(AdnumberEmpty,CLOCK_50,0,0,FiveColor2);
		SixIm S2(AdnumberEmpty,CLOCK_50,0,0,SixColor2);
		SevenIm SS2(AdnumberEmpty,CLOCK_50,0,0,SevenColor2);
		EightIm E2(AdnumberEmpty,CLOCK_50,0,0,EightColor2);
		NineIm N2(AdnumberEmpty,CLOCK_50,0,0,NineColor2);
		//....................................................................//
		
		NineNineCounter Nc(increment,DigitOne,DigitTwo);
		
		//.....................................................................//
		NineMux FirstDigit(ZeroColor,OneColor,TwoColor,ThreeColor,FourColor,FiveColor,SixColor,SevenColor,EightColor,NineColor,DigitOne,color1);
      NineMux SecondDigit(ZeroColor2,OneColor2,TwoColor2,ThreeColor2,FourColor2,FiveColor2,SixColor2,SevenColor2,EightColor2,NineColor2,DigitTwo,color2);
		
		//.......................................................................//
      NumberCounter First(8'b10001011,7'b0000000,CLOCK_50,Onex,Oney,Adnumber);		
		NumberCounter Second(8'b01110111,7'b0000000,CLOCK_50,Twox,Twoy,AdnumberEmpty);
		//139,15//
		//119,15//	   
		//............................................................................................//
		//DigitalChooser Ch(slower_signal,Onex,Oney,color1,Twox,Twoy,color2,FinalX,FinalY,FinalColor);
		
		
		
		
endmodule 

module DigitalChooser(CLK,FirstX,FirstY,FirstColor,SecondX,SecondY,SecondColor,FinalX,FinalY,FinalColor);
	input [7:0]FirstX,FirstY;
	input [6:0]SecondX,SecondY;
	input [2:0]FirstColor,SecondColor;
	input CLK;

	output reg [2:0]FinalColor;
	output reg [7:0]FinalX;
	output reg [6:0]FinalY;

	reg current;
	reg next;

		always@(*)

		begin

			case(current)
	
			1'b0: next=1'b1;

			1'b1: next=1'b0;

			default: next=1'b0;

			endcase 

		end

		always@(*)

		begin

			case(current)
			1'b0: 
			
			begin 
			FinalX=FirstX;
			FinalY=FirstY;
			FinalColor=FirstColor;
			end

			1'b1:
			begin 
			FinalX=SecondX;
			FinalY=SecondY;
			FinalColor=SecondColor;
			end

		endcase 

	end


		always@(posedge CLK)

		begin

			current<=next;

		end

endmodule 


module NumberCounter(X_p,Y_p,CLK,X_out,Y_out,Address);
input [7:0]X_p;
input [6:0]Y_p;
input CLK;
reg [4:0]x_counter;  
reg [3:0]y_counter;  

output reg [7:0]X_out; 
output reg [6:0]Y_out;
output reg [8:0]Address;

always@(posedge CLK)
begin

if(Address==9'b100101011)
Address<=0;
else
Address<=Address+1;

if(x_counter==5'b10011) //19//
begin
x_counter<=0;
y_counter<=y_counter+1;
end

else
x_counter<=x_counter+1;



X_out<=X_p+x_counter;
Y_out<=Y_p+y_counter;



if(y_counter==4'b1111) //15//
y_counter<=0;



end


endmodule 
		
//....................................................................................................................//		
		
module slower_counter(CLOCK,signal);
	input CLOCK;
	output reg signal;
	reg [24:0]counter;
	always@(posedge CLOCK)
	begin
	if(counter==25'b1011111010111100001000000)
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

//...............................................................................................................//
module NineMux(Zero,One,Two,Three,Four,Five,Six,Seven,Eight,Nine,Choose,NumberOut);
input [2:0]Zero,One,Two,Three,Four,Five,Six,Seven,Eight,Nine;
input [3:0]Choose;

output reg [2:0]NumberOut;

always@(*)
begin 
case(Choose[3:0])

	4'b0000:
		NumberOut=Zero;
	4'b0001:
		NumberOut=One;
	4'b0010:
		NumberOut=Two;
	4'b0011:
		NumberOut=Three;
	4'b0100:
		NumberOut=Four;
	4'b0101:
		NumberOut=Five;
	4'b0110:
		NumberOut=Six;
	4'b0111:
		NumberOut=Seven;
	4'b1000:
		NumberOut=Eight;
	4'b1001:
		NumberOut=Nine;
	default:
		NumberOut=Zero;

endcase 

end



endmodule 

//..............................................................................................................//

module NineNineCounter(getScore,FirstDigit,SecondDigit);
input getScore;
output reg[4:0]FirstDigit;
output reg[4:0]SecondDigit;
always@(posedge getScore)
	begin

			if(FirstDigit==4'b1001)
	
				begin
				FirstDigit=0;
				SecondDigit=SecondDigit+1;
				end		
			else
	
				FirstDigit=FirstDigit+1;

			if(SecondDigit==4'b1010)
				SecondDigit=0;

end

endmodule









