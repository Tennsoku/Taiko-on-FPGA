

module ListedParts(/*GetSequence, */ started, counter160_4Hz, CLOCK_50, OutputX, color, currentState, LEDR);

	input started, CLOCK_50;
	input [7:0]counter160_4Hz;
	output reg [1:0]currentState;
	output reg [7:0]OutputX;
	output reg [2:0]color;
	output LEDR;

	reg [1:0] nextState;
	reg Begin;
	
	assign LEDR = Begin;
	
	parameter reset = 2'b00, getSequence = 2'b01, computing = 2'b10;
	
	//controlPath
	//state table
	always@(*)
		begin: state_table
			case(currentState)
			
				reset:
					begin
						Begin = 0;
						if(started)
							nextState = getSequence;
						else 
							nextState = reset;
					end
				
				getSequence:
					begin
						Begin = 0;
						//add shifter output here
						nextState = computing;
					end
					
				computing:
					begin
						
						if(started)
							if(counter160_4Hz == 0)
								Begin = 1;
								
						if (Begin & ((OutputX == 0) /*| onHit == 1*/))
							nextState = reset;
						else nextState = computing;
					end

				default:
					begin
						Begin = 0;
						nextState = reset;
					end
							
			endcase
		end
			
			
	//dataPath
	always@(*)
		begin: output_logic
			case(currentState)
			
				reset:
					begin
						OutputX = 8'b10011111;
						color = 3'b000;
					end
				
				getSequence:
					begin
						OutputX = 8'b10011111;
						color = 3'b100;
					end
					
				computing:
					begin
						if(Begin)
							OutputX = 8'b10011111 - counter160_4Hz;
						color = 3'b100;
					end
					
				default:
					begin
						OutputX = 8'b10011111;
						color = 3'b000;
					end
					
			endcase
		end
		
	//state reg
	always @(posedge CLOCK_50)
		begin: state_FFs
			currentState <= nextState;
		end
				
endmodule


module counter_4Hz(EnableSignal, CLK, resetn); // 4Hz Enable
	output reg EnableSignal; 
	reg [23:0]cout;
	input CLK, resetn;
	
	always@(posedge CLK)
		begin 
			if(!resetn)
				begin
					cout <= 24'b0;
					EnableSignal <= 0;
				end

			else if(cout == 24'b101111101011110000100000)
				begin
					cout <= 24'b0;
					EnableSignal <= 1;
				end

			else
				begin
					cout <= cout + 1;
					EnableSignal <= 0;
				end

		end
endmodule 

module counter160_4Hz(Enable, counter160, Clock);
	input Enable, Clock;
	reg [7:0]temp;
	output [7:0]counter160;
	
	always @(posedge Clock)
		begin
		if(temp == 8'b10100000)
			temp <= 0;
		else
			if (Enable) 
				temp <= temp + 1;
		end
		
	assign counter160 = temp;
endmodule