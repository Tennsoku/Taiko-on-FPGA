module ListedPart_test(CLOCK_50, KEY, HEX0, HEX1, HEX2, HEX4, HEX5, LEDR);
	input CLOCK_50;
	input [3:0] KEY;
	output [6:0] HEX0;
	output [6:0] HEX1;
	output [6:0] HEX2;
	output [6:0] HEX4;
	output [6:0] HEX5;
	output [9:0] LEDR;
	
	wire F4Hz;
	wire [7:0]C160_4Hz;
	wire CLK5Hz;
	wire [7:0]outputX;
	wire [2:0]color;
	wire [1:0]State;
	
	assign LEDR[0] = CLOCK_50;
	assign LEDR[1] = F4Hz;
	assign LEDR[9:7] = color;
	assign LEDR[5:4] = State;
	
		
	counter_4Hz counter1(
		.EnableSignal(F4Hz),
		.CLK(CLOCK_50),
		.resetn(KEY[0]));
		
	counter160_4Hz counter2(
		.Enable(F4Hz), 
		.counter160(C160_4Hz),
		.Clock(CLOCK_50));	
	

		
	ListedParts TEST(/*GetSequence, */ 
		.started(1), 
		.counter160_4Hz(C160_4Hz), 
		.CLOCK_50(CLOCK_50), 
		.OutputX(outputX), 
		.color(color),
		.currentState(State),
		.LEDR(LEDR[6]));

		
	decoder d0(
			.C1(C160_4Hz[3]),
			.C2(C160_4Hz[2]),
			.C3(C160_4Hz[1]),
			.C4(C160_4Hz[0]),
			.HEX0(HEX0[0]),
			.HEX1(HEX0[1]),
			.HEX2(HEX0[2]),
			.HEX3(HEX0[3]),
			.HEX4(HEX0[4]),
			.HEX5(HEX0[5]),
			.HEX6(HEX0[6])
		);

	decoder d1(
			.C1(C160_4Hz[7]),
			.C2(C160_4Hz[6]),
			.C3(C160_4Hz[5]),
			.C4(C160_4Hz[4]),
			.HEX0(HEX1[0]),
			.HEX1(HEX1[1]),
			.HEX2(HEX1[2]),
			.HEX3(HEX1[3]),
			.HEX4(HEX1[4]),
			.HEX5(HEX1[5]),
			.HEX6(HEX1[6])
		);
		
	decoder d4(
			.C1(outputX[3]),
			.C2(outputX[2]),
			.C3(outputX[1]),
			.C4(outputX[0]),

			.HEX0(HEX4[0]),
			.HEX1(HEX4[1]),
			.HEX2(HEX4[2]),
			.HEX3(HEX4[3]),
			.HEX4(HEX4[4]),
			.HEX5(HEX4[5]),
			.HEX6(HEX4[6])
		);
		
	decoder d5(
			.C1(outputX[7]),
			.C2(outputX[6]),
			.C3(outputX[5]),
			.C4(outputX[4]),
			.HEX0(HEX5[0]),
			.HEX1(HEX5[1]),
			.HEX2(HEX5[2]),
			.HEX3(HEX5[3]),
			.HEX4(HEX5[4]),
			.HEX5(HEX5[5]),
			.HEX6(HEX5[6])
		);
		
		

endmodule


module decoder(C1,C2,C3,C4,HEX0,HEX1,HEX2,HEX3,HEX4,HEX5,HEX6);
	input C1;
	input C2;
	input C3;
	input C4;
	output HEX0;
	output HEX1;
	output HEX2;
	output HEX3;
	output HEX4;
	output HEX5;
	output HEX6;
	

	assign HEX0 = (~C1&~C2&~C3&C4)|(~C1&C2&~C3&~C4)|(C1&~C2&C3&C4)|(C1&C2&~C3&C4);
	assign HEX1 = (~C1&C2&~C3&C4)|(~C1&C2&C3&~C4)|(C1&~C2&C3&C4)|(C1&C2&~C3&~C4)|(C1&C2&C3&~C4)|(C1&C2&C3&C4);
	assign HEX2 = (~C1&~C2&C3&~C4)|(C1&C2&~C3&~C4)|(C1&C2&C3&~C4)|(C1&C2&C3&C4);
	assign HEX3 = (~C1&~C2&~C3&C4)|(~C1&C2&~C3&~C4)|(~C1&C2&C3&C4)|(C1&~C2&C3&~C4)|(C1&C2&C3&C4);
	assign HEX4 = (~C1&~C2&~C3&C4)|(~C1&~C2&C3&C4)|(~C1&C2&~C3&~C4)|(~C1&C2&~C3&C4)|(~C1&C2&C3&C4)|(C1&~C2&~C3&C4);
	assign HEX5 = (~C1&~C2&~C3&C4)|(~C1&~C2&C3&~C4)|(~C1&~C2&C3&C4)|(~C1&C2&C3&C4)|(C1&C2&~C3&C4);
	assign HEX6 = (~C1&~C2&~C3&~C4)|(~C1&~C2&~C3&C4)|(~C1&C2&C3&C4)|(C1&C2&~C3&~C4);
	
	
endmodule




