

module ListedParts( /*KEY Input*/ KEY1_n, KEY2_n, KEY3_n, KEY4_n,
	GetSequence, started, counter160_4Hz, CLOCK_50, OutputX, nowSequence, currentState, hitSignal);

	input started, CLOCK_50;
	input KEY1_n, KEY2_n, KEY3_n, KEY4_n;
	input [7:0]counter160_4Hz;
	input [2:0]GetSequence;
	
	
	output reg [1:0]currentState;
	output reg [7:0]OutputX;
	output [1:0]hitSignal;
	output reg [2:0]nowSequence;
	
	reg [1:0] nextState;
	reg [1:0] hitStatus;
	reg Begin;
	reg [2:0] color;

	
	assign LEDR = Begin;
	assign hitSignal = hitStatus;
	
	parameter reset = 2'b00, getSequence = 2'b01, computing = 2'b10, onHit = 2'b11;
	
	//controlPath
	//state table
	always@(*)
		begin: state_table
			case(currentState)
			
				reset:
					begin
						Begin = 0;
						hitStatus = 2'b00;
						if(started)
							nextState = getSequence;
						else 
							nextState = reset;
					end
				
				getSequence:
					begin
						Begin = 0;
						hitStatus = 2'b00;
						nextState = computing;
					end
					
				computing:
					begin
						
						if(started)
							if(counter160_4Hz == 0)
								Begin = 1;
								
						if (Begin & ((hitStatus == 2'b01) | (hitStatus == 2'b10)))
							nextState = reset;
						else if (Begin & (OutputX == 0))
							nextState = reset;
						else if (Begin) 
							nextState = onHit;
						else nextState = computing;
					end
					
				onHit:
					begin
						if (nowSequence == 3'b001)
							if ((!KEY2_n)|(!KEY3_n))
								begin
									if ((OutputX < 8'b00100001)&(OutputX > 8'b00011011))
										hitStatus = 2'b01;
									else if ((OutputX < 8'b00100101)&(OutputX > 8'b00011001))
										hitStatus = 2'b10;
									else hitStatus = 2'b00;
								end
							
						if (nowSequence == 3'b010)
							if ((!KEY1_n)|(!KEY4_n))
								begin
									if ((OutputX < 8'b00100001)&(OutputX > 8'b00011011))
										hitStatus = 2'b01;
									else if ((OutputX < 8'b00100101)&(OutputX > 8'b00011001))
										hitStatus = 2'b10;
									else hitStatus = 2'b00;
								end
							
						if (nowSequence == 3'b011)
							if ((!KEY2_n)&(!KEY3_n))
								begin
									if ((OutputX < 8'b00100001)&(OutputX > 8'b00011011))
										hitStatus = 2'b01;
									else if ((OutputX < 8'b00100101)&(OutputX > 8'b00011001))
										hitStatus = 2'b10;
									else hitStatus = 2'b00;
								end
							
						if (nowSequence == 3'b100)
							if ((!KEY1_n)&(!KEY4_n))
								begin
									if ((OutputX < 8'b00100001)&(OutputX > 8'b00011011))
										hitStatus = 2'b01;
									else if ((OutputX < 8'b00100101)&(OutputX > 8'b00011001))
										hitStatus = 2'b10;
									else hitStatus = 2'b00;
								end
								
						nextState = computing;
							
					end

				default:
					begin
						Begin = 0;
						hitStatus = 2'b00;;
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
						OutputX = 8'b10100000;
						color = 3'b000;
						nowSequence = 3'b000;
					end
				
				getSequence:
					begin
						OutputX = 8'b10100000;
						
						nowSequence = GetSequence;
						
						if ((nowSequence == 3'b001) | (nowSequence == 3'b011))
							color = 3'b100;
						else if ((nowSequence == 3'b010) | (nowSequence == 3'b100))
							color = 3'b011;
						else color = 3'b000;
					end
					
				computing:
					begin
						if(Begin)
							OutputX = 8'b10100000 - counter160_4Hz;
							
						if ((nowSequence == 3'b001) | (nowSequence == 3'b011))
							color = 3'b100;
						else if ((nowSequence == 3'b010) | (nowSequence == 3'b100))
							color = 3'b011;
						else color = 3'b000;
					end
				
				onHit:
					begin
						if(Begin)
							OutputX = 8'b10100000 - counter160_4Hz;
							
						if ((nowSequence == 3'b001) | (nowSequence == 3'b011))
							color = 3'b100;
						else if ((nowSequence == 3'b010) | (nowSequence == 3'b100))
							color = 3'b011;
						else color = 3'b000;
					end
					
				default:
					begin
						OutputX = 8'b10100000;
						color = 3'b000;
						nowSequence = 3'b000;
					end
					
			endcase
		end
		
	//state reg
	always @(posedge CLOCK_50)
		begin: state_FFs
			currentState <= nextState;
		end
				
endmodule


 