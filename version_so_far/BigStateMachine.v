

module draw_sequence (reset,command,CLK,choose,continue);

	input CLK;
	input reset;
	input continue;

	output reg [4:0]command;
	output reg [1:0]choose;

	reg [4:0]current;
	reg [4:0]next;
	reg [16:0]counter;
	reg [14:0]back_state_counter; 
	reg [5:0]block_counter; 
	reg [8:0]scoreboard_counter; 
	reg [11:0]play_space_counter; 

	parameter [4:0]starting_back_1=5'b00000,starting_back_2=5'b00001,One=5'b00010,Two=5'b00011,Three=5'b00100,Four=5'b00101,Five=5'b00110,Six=5'b00111,Seven=5'b01000,Eight=5'b01001,Nine=5'b01010,
	Ten=5'b01011,Eleven=5'b01100,Twelve=5'b01101,Thirteen=5'b01110,Fourteen=5'b01111,Fifteen=5'b10000,Score1=5'b10001,Score2=5'b10010,Background=5'b10011,play_clear=5'b10100,VGA_display=5'b10101,Stop=5'b10110, 
	
	fineLine1 = 5'b10111, fineLine2 = 5'b11000, perfectLine = 5'b11001;
                                                                                                                                                                                                                      
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
			next = fineLine1;
		end 
	  
	end


	Score1:

	begin 
		  scoreboard_counter=scoreboard_counter+1;
		  
		  if(scoreboard_counter!=9'b100101100)
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
		  
		  if(scoreboard_counter!=9'b100101100)
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
				next=One;
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
				next = Background;
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
			choose=2'b00;
			command=5'b00000;
		end
	starting_back_2:
		begin
			choose=2'b01;
			command=5'b00001;
		end

	One:
	command=5'b00010;

	Two:
	command=5'b00011;

	Three:
	command=5'b00100;

	Four:
	command=5'b00101;

	Five:

	command=5'b00110;

	Six:

	command=5'b00111;

	Seven:
	command=5'b01000;

	Eight:

	command=5'b01001;

	Nine:
	command=5'b01010;

	Ten:
	command=5'b01011;

	Eleven:
	command=5'b01100;

	Twelve:
	command=5'b01101;

	Thirteen:
	command=5'b01110;

	Fourteen:
	command=5'b01111;

	Fifteen:
	command=5'b10000;

	Score1:

	command=5'b10001;

	Score2:

	command=5'b10010;

	Background:
		begin
			choose=2'b10;
			command=5'b10011;
		end
	play_clear:

	command=5'b10100;

	VGA_display:
	command=5'b10101;

	Stop:
	command=5'b10110;
	
	fineLine1:
		command=5'b10111;	
	
	fineLine2:
		command=5'b11000;
	
	perfectLine:
		command=5'b11001;
	


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