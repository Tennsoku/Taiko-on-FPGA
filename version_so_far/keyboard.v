module KeyBoard(CLOCK_50,PS2_CLK,PS2_DAT, KEYn1, KEYn2, KEYn3, KEYn4);
	//-------------------------------------------------//
	input CLOCK_50;
	//-------------------------------------------------//
	inout PS2_CLK;
	inout PS2_DAT;
	//-------------------------------------------------//
	output KEYn1, KEYn2, KEYn3, KEYn4;
	//-------------------------------------------------//
	wire [7:0]last_data;
	wire data_received;
	//-------------------------------------------------//
	reg [7:0]get_data;
	//-------------------------------------------------//
	reg [2:0]current;
	reg [2:0]next;
	reg enablen1, enablen2, enablen3, enablen4; 
	
	assign KEYn1 = enablen1;
	assign KEYn2 = enablen2;
	assign KEYn3 = enablen3;
	assign KEYn4 = enablen4;
	
	//FSM-start------------------------------------------------------------------------//
	//Control path---------------------------------------------------------------------//
	parameter [2:0]prepare = 3'b000, enable = 3'b001, breakPoint = 3'b010, skip = 3'b011, endStep = 3'b100;

	always@(*)
		begin: state_table
			case(current[2:0])

				prepare:
				begin 
					if(get_data != 0)
						begin 
							next = enable;			
						end 
					else
						next = prepare;	
				end 

				enable:
				begin 
					if((get_data != 8'b11110000) & (get_data != 8'b00000000))
						next = enable;
					else if(get_data == 8'b11110000)
						next = breakPoint;
				end

				breakPoint:
				begin
					if((get_data != 8'b11110000) & (get_data != 8'b00000000))
						begin 
							 next = skip;
						end
					else 
						next = breakPoint;
				end
							 
				skip:
					next = endStep;
							
				endStep:
					begin
						if (get_data == 0)
							next = prepare;
					end
				
				default:
					begin
						next = prepare;
					end

			endcase 
		end 



	//Data path------------------------------------------------------------------------//

	always@(*)
		begin: output_logic
			case(current[2:0])

				prepare:
					begin
						enablen1 = 1;
						enablen2 = 1;
						enablen3 = 1;
						enablen4 = 1;
					end
					
				enable:
					begin
						if (get_data == 8'b00011100)
							enablen1 = 0;
						
						if (get_data == 8'b00011011)
							enablen2 = 0;
							
						if (get_data == 8'b00100011)
							enablen3 = 0;
							
						if (get_data == 8'b00101011)
							enablen4 = 0;
						
					end
				breakPoint:
					begin
						enablen1 = 1;
						enablen2 = 1;
						enablen3 = 1;
						enablen4 = 1;
					end

				skip:
					begin
						enablen1 = 1;
						enablen2 = 1;
						enablen3 = 1;
						enablen4 = 1;
					end

				endStep:
					begin
						enablen1 = 1;
						enablen2 = 1;
						enablen3 = 1;
						enablen4 = 1;
					end
				
				default: 
					begin
						enablen1 = 1;
						enablen2 = 1;
						enablen3 = 1;
						enablen4 = 1;
					end
				
			endcase 
		end 

	//Assigning next-------------------------------------------------------------------//
	always@(posedge CLOCK_50)
		begin: state_FFs
				current <= next;
		end 

		
	//Read the data from the keyboard---------------------------------------------------//
	always@(posedge CLOCK_50)
		begin 
			if(data_received)
				get_data <= last_data;
				
			if(current == endStep)
				get_data <= 0;
		end 




	//PS2 module-----------------------------------------------------------------------//
	PS2_Controller PS2(.CLOCK_50(CLOCK_50),
							 .reset(0),
							 .PS2_CLK(PS2_CLK),
							 .PS2_DAT(PS2_DAT),
							 .received_data(last_data),
							 .received_data_en(data_received));
							 
endmodule 




