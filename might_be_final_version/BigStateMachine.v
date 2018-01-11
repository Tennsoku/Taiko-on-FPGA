

module draw_sequence (reset,command,CLK,choose_out,continue);

	input CLK;
	input reset;
	input continue;

	output reg [4:0]command;
	output [3:0]choose_out;

	reg [3:0]choose;
	reg in_game;
	reg [4:0]current;
	reg [4:0]next;
	reg [16:0]counter;
	reg [14:0]back_state_counter; 
	reg [5:0]block_counter; 
	reg [8:0]scoreboard_counter; 
	reg [11:0]play_space_counter; 
	
	wire do_change;
	wire [3:0]wire_to_out;
	
	assign choose_out[3:0]=wire_to_out[3:0];

	parameter [4:0]starting_back_1=5'b00000,starting_back_2=5'b00001,One=5'b00010,Two=5'b00011,Three=5'b00100,Four=5'b00101,Five=5'b00110,Six=5'b00111,Seven=5'b01000,Eight=5'b01001,Nine=5'b01010,
	Ten=5'b01011,Eleven=5'b01100,Twelve=5'b01101,Thirteen=5'b01110,Fourteen=5'b01111,Fifteen=5'b10000,Score1=5'b10001,Score2=5'b10010,Background=5'b10011,play_clear=5'b10100,VGA_display=5'b10101,Stop=5'b10110, 
	
	fineLine1 = 5'b10111, fineLine2 = 5'b11000, perfectLine = 5'b11001;
	
	background_decide decider(do_change,in_game,choose,wire_to_out);
	
	four_hz_counter four_hz(CLK,do_change);
	
                                                                                                                                                                                                                      
	always@(posedge CLK)

	begin

	case(current[4:0])


	starting_back_1:
	begin
		if(continue)
			next=One;
		else 
			begin 
			
					back_state_counter=back_state_counter+1;
		
					if(back_state_counter!=15'b100101100000001)
						next=starting_back_1;
					else
						begin
						back_state_counter=0;
						next=starting_back_2;			
						end
			end			
				
	end
	  

	starting_back_2:
	begin
		if(continue)
			next=One;
		else 
			begin 
			
					back_state_counter=back_state_counter+1;
		
					if(back_state_counter!=15'b100101100000001)
						next=starting_back_2;
					else
						begin
						back_state_counter=0;
						next=starting_back_1;			
						end
			end			
				
	end
	  
	One:
	begin 

	  block_counter=block_counter+1;
	  if(block_counter!=6'b111111)
			next=One;
			
	  else 
		begin
			block_counter=0;
			next=Two;
		end 
	  
	end  

	Two:

	begin 

	  block_counter=block_counter+1;
	  if(block_counter!=6'b111111)
			next=Two;
			
	  else 
		begin
			block_counter=0;
			next=Three;
		end 
	  
	end 

	Three:

	begin 

	  block_counter=block_counter+1;
	  if(block_counter!=6'b100000)
			next=Three;
			
	  else 
		begin
			block_counter=0;
			next=Four;
		end 
	  
	end 

	Four:

	begin 

	  block_counter=block_counter+1;
	  if(block_counter!=6'b100000)
			next=Four;
			
	  else 
		begin
			block_counter=0;
			next=Five;
		end 
	  
	end

	Five:

	begin 

	  block_counter=block_counter+1;
	  if(block_counter!=6'b100000)
			next=Five;
			
	  else 
		begin
			block_counter=0;
			next=Six;
		end 
	  
	end

	Six:

	begin 

	  block_counter=block_counter+1;
	  if(block_counter!=6'b100000)
			next=Six;
			
	  else 
		begin
			block_counter=0;
			next=Seven;
		end 
	  
	end

	Seven:

	begin 

	  block_counter=block_counter+1;
	  if(block_counter!=6'b100000)
			next=Seven;
			
	  else 
		begin
			block_counter=0;
			next=Eight;
		end 
	  
	end

	Eight:

	begin 

	  block_counter=block_counter+1;
	  if(block_counter!=6'b100000)
			next=Eight;
			
	  else 
		begin
			block_counter=0;
			next=Nine;
		end 
	  
	end

	Nine:


	begin 

	  block_counter=block_counter+1;
	  if(block_counter!=6'b100000)
			next=Nine;
			
	  else 
		begin
			block_counter=0;
			next=Ten;
		end 
	  
	end

	Ten:

	begin 

	  block_counter=block_counter+1;
	  if(block_counter!=6'b100000)
			next=Ten;
			
	  else 
		begin
			block_counter=0;
			next=Eleven;
		end 
	  
	end

	Eleven:

	begin 

	  block_counter=block_counter+1;
	  if(block_counter!=6'b100000)
			next=Eleven;
			
	  else 
		begin
			block_counter=0;
			next=Twelve;
		end 
	  
	end


	Twelve:

	begin 

	  block_counter=block_counter+1;
	  if(block_counter!=6'b100000)
			next=Twelve;
			
	  else 
		begin
			block_counter=0;
			next=Thirteen;
		end 
	  
	end


	Thirteen:

	begin 

	  block_counter=block_counter+1;
	  if(block_counter!=6'b100000)
			next=Thirteen;
			
	  else 
		begin
			block_counter=0;
			next=Fourteen;
		end 
	  
	end


	Fourteen:

	begin 

	  block_counter=block_counter+1;
	  if(block_counter!=6'b100000)
			next=Fourteen;
			
	  else 
		begin
			block_counter=0;
			next=Fifteen;
		end 
	  
	end


	Fifteen:

	begin 

	  block_counter=block_counter+1;
	  if(block_counter!=6'b100000)
			next=Fifteen;
			
	  else 
		begin
			block_counter=0;
			next = Score1;
		end 
	  
	end


	Score1:

	begin 
		  scoreboard_counter=scoreboard_counter+1;
		  
		  if(scoreboard_counter!=9'd225)
			  next=Score1;
		  else 
			  begin
			  scoreboard_counter=0;
			  next=Score2;		  
			  end 
	end


	Score2:

	begin 
		  scoreboard_counter=scoreboard_counter+1;
		  
		  if(scoreboard_counter!=9'd225)
			  next=Score2;
		  else 
			  begin
			  scoreboard_counter=0;
			  next=Background;		  
			  end 
	end


	Background:
		begin 
			back_state_counter=back_state_counter+1;
		
			if(back_state_counter!=15'b100101100000001)
				next=Background;
			else
				begin
				back_state_counter=0;
				next=play_clear;			
				end
		end

	play_clear:
	begin
		 
			play_space_counter=play_space_counter+1; 
		  
		  if(play_space_counter!=12'b000010100000)
				next=play_clear;
		  else 
				begin
				play_space_counter=0;
				next=fineLine1;
				end 
		 end
		  
	VGA_display:
	begin 
			back_state_counter=back_state_counter+1;
		
			if(back_state_counter!=15'b100101100000001)
				next=VGA_display;
			else
				begin
				back_state_counter=0;
				next=Stop;			
				end
		end

	Stop:
	next=Stop;
	
	fineLine1:
		begin 

		  block_counter=block_counter+1;
		  if(block_counter!=6'b100000)
				next=fineLine1;
				
		  else 
			begin
				block_counter=0;
				next = fineLine2;
			end 
		  
		end
		
	fineLine2:
		begin 

		  block_counter=block_counter+1;
		  if(block_counter!=6'b100000)
				next=fineLine2;
				
		  else 
			begin
				block_counter=0;
				next = perfectLine;
			end 
		  
		end
	perfectLine:
		begin 

		  block_counter=block_counter+1;
		  if(block_counter!=6'b100000)
				next=perfectLine;
				
		  else 
			begin
				block_counter=0;
				next = One;
			end 
		  
		end

	default:
		begin
			next = starting_back_1;
			counter = 0;
		end

	endcase 

	end 




	always@(*)

	begin: output_logic  

	case(current[4:0])

	starting_back_1:
		begin
			in_game=0;
			choose=4'b0110;
			command=5'b00000;
		end
	starting_back_2:
		begin
			in_game=0;
			choose=4'b0111;
			command=5'b00001;
		end

	One:
	begin
   in_game=1;
	command=5'b00010;
	end

	Two:
	begin
   in_game=1;
	command=5'b00011;
	end



	Three:
	begin
   in_game=1;
	command=5'b00100;
	end


	Four:
	begin
   in_game=1;
	command=5'b00101;
	end



	Five:
   
	begin
   in_game=1;
	command=5'b00110;
	end



	Six:
   begin
   in_game=1;
	command=5'b00111;
	end

	

	Seven:
	begin
   in_game=1;
	command=5'b01000;
	end

	

	Eight:
   begin
   in_game=1;
	command=5'b01001;
	end


   
	Nine:
	begin
   in_game=1;
	
	command=5'b01010;
	end


	Ten:
	begin
   in_game=1;
	command=5'b01011;
	end

	

	Eleven:
	begin
   in_game=1;
	command=5'b01100;
	end

	

	Twelve:
	begin
   in_game=1;
	command=5'b01101;
	end

	

	Thirteen:
	begin
   in_game=1;
	command=5'b01110;
	end



	Fourteen:
	begin
   in_game=1;

	command=5'b01111;
	end


	Fifteen:
	begin
   in_game=1;
	command=5'b10000;
	end


	Score1:
   begin
   in_game=1;
	command=5'b10001;
	end



	Score2:
   begin
   in_game=1;
	command=5'b10010;
	end

	

	Background:
		begin
		   in_game=1;
			command=5'b10011;
		end
		
	play_clear:
   begin
	command=5'b10100;
   in_game=1;
	end 
	
	VGA_display:
	command=5'b10101;

	Stop:
	command=5'b10110;
	
	fineLine1:
	begin
		command=5'b10111;	
	   in_game=1;
	end
	  
	fineLine2:
	begin
		command=5'b11000;
		in_game=1;
	end
	perfectLine:
	begin 
		command=5'b11001;
		in_game=1;
	end


	default:
		begin
			command=0;
		end
		
	endcase 

	end 



	always@(posedge CLK)
	begin: state_FFs

	if(!reset)
	current=starting_back_1;
	else
	current=next;

	end

endmodule 
//-----------------------------------------------------------//

module background_decide(change,in_game,current_back,real_back);
input change;
input in_game;
input [3:0]current_back;

output reg [3:0]real_back;

reg [3:0]back_state;


always@(posedge change)
begin

if(in_game==1'b1)
begin 
   if(real_back>=4'b0101)
	begin
	back_state=0;
	real_back=back_state;
	end
	else
	begin
	back_state=back_state+1;
	real_back=back_state;
   end
	 

	
end

else
	begin
	real_back=current_back;
	end
	
end

endmodule 
//-------------------------------------------------------------//
module four_hz_counter(CLK,signal);
input CLK;
output reg signal;
reg [23:0]count; 

always@(posedge CLK)
begin
	if(count==24'b101111101011110000100000)
	begin
		count<=0;
		signal<=1;
	end
	else 
	begin
		count<=count+1;
		signal<=0;
	end 
 
end


endmodule 












