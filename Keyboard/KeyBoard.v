module KeyBoard(CLOCK_50,PS2_CLK,PS2_DAT,LEDR,KEY);
	//-------------------------------------------------//
	input CLOCK_50;
	input [0:0]KEY;
	//-------------------------------------------------//
	inout PS2_CLK;
	inout PS2_DAT;
	//-------------------------------------------------//
	output [9:0]LEDR;
	//-------------------------------------------------//
	wire [7:0]last_data;
	wire data_received;
	//-------------------------------------------------//
	reg [7:0]get_data;
	//-------------------------------------------------//
	reg [2:0]current;
	reg [2:0]next;
	reg enable1, enable2, enable3, enable4; 
	
	assign LEDR[0] = enable1;
	assign LEDR[1] = enable2;
	assign LEDR[2] = enable3;
	assign LEDR[3] = enable4;
	
	assign LEDR[9:7] = current;
	

	

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
//						if (last_data == 0)
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
						enable1 = 0;
						enable2 = 0;
						enable3 = 0;
						enable4 = 0;
					end
					
				enable:
					begin
						if (get_data == 8'b00011100)
							enable1 = 1;
						
						if (get_data == 8'b00011011)
							enable2 = 1;
							
						if (get_data == 8'b00100011)
							enable3 = 1;
							
						if (get_data == 8'b00101011)
							enable4 = 1;
						
					end
				breakPoint:
					begin
						enable1 = 0;
						enable2 = 0;
						enable3 = 0;
						enable4 = 0;
					end

				skip:
					begin
						enable1 = 0;
						enable2 = 0;
						enable3 = 0;
						enable4 = 0;
					end

				endStep:;
				
				default: 
					begin
						enable1 = 0;
						enable2 = 0;
						enable3 = 0;
						enable4 = 0;
					end
				
			endcase 
		end 

	//Assigning next-------------------------------------------------------------------//
	always@(posedge CLOCK_50)
		begin: state_FFs
			if(!KEY[0])
				current <= prepare;
			else 
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
							 .reset(~KEY[0]),
							 .PS2_CLK(PS2_CLK),
							 .PS2_DAT(PS2_DAT),
							 .received_data(last_data),
							 .received_data_en(data_received));
							 
endmodule 