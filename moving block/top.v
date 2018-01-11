module top(SW,CLOCK_50,KEY,
		VGA_CLK,   						//	VGA Clock
		VGA_HS,							//	VGA H_SYNC
		VGA_VS,							//	VGA V_SYNC
		VGA_BLANK,						//	VGA BLANK
		VGA_SYNC,						//	VGA SYNC
		VGA_R,   						//	VGA Red[9:0]
		VGA_G,	 						//	VGA Green[9:0]
		VGA_B   							//	VGA Blue[9:0] 
		);
		
	/************************************************************************/
	//port info
	
	input [9:0]SW;
	input [3:0]KEY;
	input CLOCK_50;

	
	output			VGA_CLK;   				//	VGA Clock
	output			VGA_HS;					//	VGA H_SYNC
	output			VGA_VS;					//	VGA V_SYNC
	output			VGA_BLANK;				//	VGA BLANK
	output			VGA_SYNC;				//	VGA SYNC
	output	[9:0]	VGA_R;   				//	VGA Red[9:0]
	output	[9:0]	VGA_G;	 				//	VGA Green[9:0]
	output	[9:0]	VGA_B;   

	
	/************************************************************************/
	//wire info
	
	//for Processor
	wire [6:0]connect_y;
	wire [7:0]connect_x;
	wire [2:0]connect_color;
	
	//for ListedParts
	wire [7:0]X1,X2,X3,X4,X5,X6,X7,X8,X9,X10,X11,X12,X13,X14,X15;
	wire [2:0]color1, color2, color3, color4, color5, color6, color7, color8;
	wire [2:0]color9, color10, color11, color12, color13, color14, color15;
	wire [1:0]crtState1, crtState2, crtState3, crtState4, crtState5, crtState6, crtState7, crtState8;
	wire [1:0]crtState9, crtState10, crtState11, crtState12, crtState13, crtState14, crtState15; 
	
	//for BSM
	wire [3:0]command;
	
	//for counter
	wire [7:0]C160_64Hz1, C160_64Hz2, C160_64Hz3, C160_64Hz4, C160_64Hz5, C160_64Hz6, C160_64Hz7, C160_64Hz8, C160_64Hz9, C160_64Hz10, C160_64Hz11, C160_64Hz12, C160_64Hz13, C160_64Hz14, C160_64Hz15;
	wire F64Hz;
	
	/************************************************************************/
	//module callList
	
	//DrawPattern
//	Draw_circle draw(
//		.x_in(SW[6:0]),
//		.y_in(SW[6:0]),
//		.color(111),
//		.CLOCK_50(CLOCK_50),
//		.x_out(connect_x[7:0]),
//		.y_out(connect_y[6:0]),
//		.color_out(connect_color));
		
	//15 to 1 mux +++++++++++++++++++++++++++++++++++++
	Processor P(
	.X1(X1),
	.X2(X2),
	.X3(X3),
	.X4(X4),
	.X5(X5),
	.X6(X6),
	.X7(X7),
	.X8(X8),
	.X9(X9),
	.X10(X10),
	.X11(X11),
	.X12(X12),
	.X13(X13),
	.X14(X14),
	.X15(X15),
	.CLK(CLOCK_50),
	.command(command),
	.OutX(connect_x),
	.OutY(connect_y),
	.input_colour1(color1),
	.input_colour2(color2),
	.input_colour3(color3),
	.input_colour4(color4),
	.input_colour5(color5),
	.input_colour6(color6),
	.input_colour7(color7),
	.input_colour8(color8),
	.input_colour9(color9),
	.input_colour10(color10),
	.input_colour11(color11),
	.input_colour12(color12),
	.input_colour13(color13),
	.input_colour14(color14),
	.input_colour15(color15),
	.colour_to_draw(connect_color),
	.reset(1),
	.enable(1));
	
	//sequence +++++++++++++++++++++++++++++++++++++
	draw_sequence D(
	.reset(1),
	.command(command),
	.CLK(CLOCK_50));
	
	//15 Blocks +++++++++++++++++++++++++++++++++++++
	ListedParts L1(
		/*Input*/ 
		/*GetSequence, */ 
		.started(SW[0]), 
		.counter160_4Hz(C160_64Hz1), 
		.CLOCK_50(CLOCK_50),
		/*Output*/ 
		.OutputX(X1), 
		.color(color1), 
		.currentState(crtState1), 
		.LEDR());
	
	ListedParts L2(
		/*Input*/ 
		/*GetSequence, */ 
		.started(SW[1]), 
		.counter160_4Hz(C160_64Hz2), 
		.CLOCK_50(CLOCK_50),
		/*Output*/ 
		.OutputX(X2), 
		.color(color2), 
		.currentState(crtState2), 
		.LEDR());
		
	ListedParts L3(
		/*Input*/ 
		/*GetSequence, */ 
		.started(SW[2]), 
		.counter160_4Hz(C160_64Hz3), 
		.CLOCK_50(CLOCK_50),
		/*Output*/ 
		.OutputX(X3), 
		.color(color3), 
		.currentState(crtState3), 
		.LEDR());
		
	ListedParts L4(
		/*Input*/ 
		/*GetSequence, */ 
		.started(SW[3]), 
		.counter160_4Hz(C160_64Hz4), 
		.CLOCK_50(CLOCK_50),
		/*Output*/ 
		.OutputX(X4), 
		.color(color4), 
		.currentState(crtState4), 
		.LEDR());
	
	ListedParts L5(
		/*Input*/ 
		/*GetSequence, */ 
		.started(SW[4]), 
		.counter160_4Hz(C160_64Hz5), 
		.CLOCK_50(CLOCK_50),
		/*Output*/ 
		.OutputX(X5), 
		.color(color5), 
		.currentState(crtState5), 
		.LEDR());
		
	ListedParts L6(
		/*Input*/ 
		/*GetSequence, */ 
		.started(SW[5]), 
		.counter160_4Hz(C160_64Hz6), 
		.CLOCK_50(CLOCK_50),
		/*Output*/ 
		.OutputX(X6), 
		.color(color6), 
		.currentState(crtState6), 
		.LEDR());
		
	ListedParts L7(
		/*Input*/ 
		/*GetSequence, */ 
		.started(SW[6]), 
		.counter160_4Hz(C160_64Hz7), 
		.CLOCK_50(CLOCK_50),
		/*Output*/ 
		.OutputX(X7), 
		.color(color7), 
		.currentState(crtState7), 
		.LEDR());
		
	ListedParts L8(
		/*Input*/ 
		/*GetSequence, */ 
		.started(SW[7]), 
		.counter160_4Hz(C160_64Hz8), 
		.CLOCK_50(CLOCK_50),
		/*Output*/ 
		.OutputX(X8), 
		.color(color8), 
		.currentState(crtState8), 
		.LEDR());
		
	ListedParts L9(
		/*Input*/ 
		/*GetSequence, */ 
		.started(SW[8]), 
		.counter160_4Hz(C160_64Hz9), 
		.CLOCK_50(CLOCK_50),
		/*Output*/ 
		.OutputX(X9), 
		.color(color9), 
		.currentState(crtState9), 
		.LEDR());
		
	ListedParts L10(
		/*Input*/ 
		/*GetSequence, */ 
		.started(SW[9]), 
		.counter160_4Hz(C160_64Hz10), 
		.CLOCK_50(CLOCK_50),
		/*Output*/ 
		.OutputX(X10), 
		.color(color10), 
		.currentState(crtState10), 
		.LEDR());
		
	ListedParts L11(
		/*Input*/ 
		/*GetSequence, */ 
		.started(0), 
		.counter160_4Hz(C160_64Hz11), 
		.CLOCK_50(CLOCK_50),
		/*Output*/ 
		.OutputX(X11), 
		.color(color11), 
		.currentState(crtState11), 
		.LEDR());
		
	ListedParts L12(
		/*Input*/ 
		/*GetSequence, */ 
		.started(0), 
		.counter160_4Hz(C160_64Hz12), 
		.CLOCK_50(CLOCK_50),
		/*Output*/ 
		.OutputX(X12), 
		.color(color12), 
		.currentState(crtState12), 
		.LEDR());
		
	ListedParts L13(
		/*Input*/ 
		/*GetSequence, */ 
		.started(0), 
		.counter160_4Hz(C160_64Hz13), 
		.CLOCK_50(CLOCK_50),
		/*Output*/ 
		.OutputX(X13), 
		.color(color13), 
		.currentState(crtState13), 
		.LEDR());
		
	ListedParts L14(
		/*Input*/ 
		/*GetSequence, */ 
		.started(0), 
		.counter160_4Hz(C160_64Hz14), 
		.CLOCK_50(CLOCK_50),
		/*Output*/ 
		.OutputX(X14), 
		.color(color14), 
		.currentState(crtState14), 
		.LEDR());
		
	ListedParts L15(
		/*Input*/ 
		/*GetSequence, */ 
		.started(0), 
		.counter160_4Hz(C160_64Hz15), 
		.CLOCK_50(CLOCK_50),
		/*Output*/ 
		.OutputX(X15), 
		.color(color15), 
		.currentState(crtState15), 
		.LEDR());
		
	//counters +++++++++++++++++++++++++++++++++++++
	counter_64Hz C64Hz(
		/*Input*/
		.CLK(CLOCK_50), 
		.resetn(1),
		/*Output*/
		.EnableSignal(F64Hz));
	
	counter160_64Hz counter1(
		/*Input*/
		.Enable(F64Hz), 
		.Clock(CLOCK_50),
		.crtState(crtState1),
		/*Output*/
		.counter160(C160_64Hz1));
	
	counter160_64Hz counter2(
		/*Input*/
		.Enable(F64Hz), 
		.Clock(CLOCK_50),
		.crtState(crtState2),
		/*Output*/
		.counter160(C160_64Hz2));
	
	counter160_64Hz counter3(
		/*Input*/
		.Enable(F64Hz), 
		.Clock(CLOCK_50),
		.crtState(crtState3),
		/*Output*/
		.counter160(C160_64Hz3));
	
	counter160_64Hz counter4(
		/*Input*/
		.Enable(F64Hz), 
		.Clock(CLOCK_50),
		.crtState(crtState4),
		/*Output*/
		.counter160(C160_64Hz4));
	
	counter160_64Hz counter5(
		/*Input*/
		.Enable(F64Hz), 
		.Clock(CLOCK_50),
		.crtState(crtState5),
		/*Output*/
		.counter160(C160_64Hz5));
	
	counter160_64Hz counter6(
		/*Input*/
		.Enable(F64Hz), 
		.Clock(CLOCK_50),
		.crtState(crtState6),
		/*Output*/
		.counter160(C160_64Hz6));
	
	counter160_64Hz counter7(
		/*Input*/
		.Enable(F64Hz), 
		.Clock(CLOCK_50),
		.crtState(crtState7),
		/*Output*/
		.counter160(C160_64Hz7));
	
	counter160_64Hz counter8(
		/*Input*/
		.Enable(F64Hz), 
		.Clock(CLOCK_50),
		.crtState(crtState8),
		/*Output*/
		.counter160(C160_64Hz8));
	
	counter160_64Hz counter9(
		/*Input*/
		.Enable(F64Hz), 
		.Clock(CLOCK_50),
		.crtState(crtState9),
		/*Output*/
		.counter160(C160_64Hz9));
	
	counter160_64Hz counter10(
		/*Input*/
		.Enable(F64Hz), 
		.Clock(CLOCK_50),
		.crtState(crtState10),
		/*Output*/
		.counter160(C160_64Hz10));
	
	counter160_64Hz counter11(
		/*Input*/
		.Enable(F64Hz), 
		.Clock(CLOCK_50),
		.crtState(crtState11),
		/*Output*/
		.counter160(C160_64Hz11));
	
	counter160_64Hz counter12(
		/*Input*/
		.Enable(F64Hz), 
		.Clock(CLOCK_50),
		.crtState(crtState12),
		/*Output*/
		.counter160(C160_64Hz12));
	
	counter160_64Hz counter13(
		/*Input*/
		.Enable(F64Hz), 
		.Clock(CLOCK_50),
		.crtState(crtState13),
		/*Output*/
		.counter160(C160_64Hz13));
	
	counter160_64Hz counter14(
		/*Input*/
		.Enable(F64Hz), 
		.Clock(CLOCK_50),
		.crtState(crtState14),
		/*Output*/
		.counter160(C160_64Hz14));
	
	counter160_64Hz counter15(
		/*Input*/
		.Enable(F64Hz), 
		.Clock(CLOCK_50),
		.crtState(crtState15),
		/*Output*/
		.counter160(C160_64Hz15));
	
		

	
	
	//VGA Part +++++++++++++++++++++++++++++++++++++
	vga_adapter VGA(
			.resetn(KEY[0]),
			.clock(CLOCK_50),
			.colour(connect_color),
			.x(connect_x),
			.y(connect_y),
			.plot(1),
			/* Signals for the DAC to drive the monitor. */
			.VGA_R(VGA_R),
			.VGA_G(VGA_G),
			.VGA_B(VGA_B),
			.VGA_HS(VGA_HS),
			.VGA_VS(VGA_VS),
			.VGA_BLANK(VGA_BLANK),
			.VGA_SYNC(VGA_SYNC),
			.VGA_CLK(VGA_CLK));
			
		defparam VGA.RESOLUTION = "160x120";
		defparam VGA.MONOCHROME = "FALSE";
		defparam VGA.BITS_PER_COLOUR_CHANNEL = 1;
		defparam VGA.BACKGROUND_IMAGE = "black.mif";
		

endmodule




