module top(CLOCK_50, KEY, LEDR, 
		PS2_CLK,PS2_DAT, 				// PS2 Port
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
	
	input [3:0]KEY;
	input CLOCK_50;

	inout PS2_CLK;
	inout PS2_DAT;
	
	output [9:0]LEDR;
	assign LEDR[9:7] = currentSequence;
	
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
	
	//for Processor ----------------------------------------------------------------------------------------//
	wire [6:0]connect_y;
	wire [7:0]connect_x;
	wire [2:0]connect_color;

	//for ListedParts ----------------------------------------------------------------------------------------//
	wire [7:0]X1,X2,X3,X4,X5,X6,X7,X8,X9,X10,X11,X12,X13,X14,X15;
	wire [2:0]color1, color2, color3, color4, color5, color6, color7, color8;
	wire [2:0]color9, color10, color11, color12, color13, color14, color15;
	wire [1:0]crtState1, crtState2, crtState3, crtState4, crtState5, crtState6, crtState7, crtState8;
	wire [1:0]crtState9, crtState10, crtState11, crtState12, crtState13, crtState14, crtState15; 
	wire [1:0]hitSignal1, hitSignal2, hitSignal3, hitSignal4, hitSignal5, hitSignal6, hitSignal7, hitSignal8;
	wire [1:0]hitSignal9, hitSignal10, hitSignal11, hitSignal12, hitSignal13, hitSignal14, hitSignal15; 
	
	//for ScoreBoard ---------------------------------------------------------------------------------//
	wire [7:0]ScoreX1,ScoreX2;
	wire[6:0]ScoreY1,ScoreY2;
	wire [2:0]ScoreColor1,ScoreColor2;
	
	//for BSM ----------------------------------------------------------------------------------------//
	wire [4:0]command;
	
	//for counter
	wire [7:0]C160_64Hz1, C160_64Hz2, C160_64Hz3, C160_64Hz4, C160_64Hz5, C160_64Hz6, C160_64Hz7, C160_64Hz8, C160_64Hz9, C160_64Hz10, C160_64Hz11, C160_64Hz12, C160_64Hz13, C160_64Hz14, C160_64Hz15;
	wire F64Hz;
	wire F4Hz;
	
	//for Background ---------------------------------------------------------------------------------//
	wire [7:0]BackgroundX;
	wire [6:0]BackgroundY;
	wire [2:0]BackgroundColor;
	wire [1:0]Back_state;
	
	//for sequence_counter ---------------------------------------------------------------------------//
	wire sequence_signal;
	wire scoreBoard_signal;
	
	//for address translator--------------------------------------------------------------------------//
	wire [14:0]address_to_buffer;
	wire [7:0]X_to_translate;
	wire [6:0]Y_to_translate;
	
	//for VGA_buffer ---------------------------------------------------------------------------------//
	wire VGA_display;
	wire [2:0]buffer_Output;
	wire [7:0]VGA_XX; 
	wire [6:0]VGA_YY;
	wire [14:0]use_address,address_to_access;
	wire VGA_fre;
	
	//for noteSequence -------------------------------------------------------------------------------//
	wire [9:0]address;
	wire [2:0]currentSequence;
	wire [2:0]seqSignal1, seqSignal2, seqSignal3, seqSignal4, seqSignal5, seqSignal6, seqSignal7, seqSignal8;
	wire [2:0]seqSignal9, seqSignal10, seqSignal11, seqSignal12, seqSignal13, seqSignal14, seqSignal15;
	
	//for sequenceManager ----------------------------------------------------------------------------//
	wire start1, start2, start3, start4, start5, start6, start7, start8, start9, start10, start11, start12, start13, start14, start15;
	
	//for PS/2 Input ---------------------------------------------------------------------------------//
	wire KEYn1,KEYn2,KEYn3,KEYn4;
	
	/************************************************************************/
	//module callList

	//*****************************************************************************************//
	halfmaxcounter Ha(CLOCK_50,scoreBoard_signal);
	//*****************************************************************************************//
	sequence_counter SE(CLOCK_50,sequence_signal);
	//*****************************************************************************************//
	drawS ScoreBoard(KEY[1],scoreBoard_signal,ScoreX1,ScoreX2,ScoreY1,ScoreY2,ScoreColor1,ScoreColor2);
	//*****************************************************************************************//
	drawB Background(Back_state,sequence_signal,BackgroundX,BackgroundY,BackgroundColor);
	//*****************************************************************************************//
	Screen vga_buffer(address_to_access,CLOCK_50,connect_color,~VGA_display,buffer_Output);
	//*****************************************************************************************//
	vga_address_translator address_translator(connect_x,connect_y,address_to_buffer);		
	//*****************************************************************************************//
	Newcounter VGA_position(CLOCK_50,VGA_XX,VGA_YY,use_address);
	//*****************************************************************************************//
	counter_60Hz VGA_frequency(CLOCK_50,VGA_fre);
	//*****************************************************************************************//
	choose_address Add(~VGA_display,address_to_buffer,use_address,address_to_access);

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
		.XfirstDigit(ScoreX1),
		.XsecondDigit(ScoreX2), 	                                  																		
		.YfirstDigit(ScoreY1),
		.YsecondDigit(ScoreY2),
		.Color1Digit(ScoreColor1),
		.Color2Digit(ScoreColor2),
		.Xbackground(BackgroundX),
		.Ybackground(BackgroundY),                               
		.BackgroundColor(BackgroundColor),
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
		.enable(1),
		.do_VGA(VGA_display));
	
	//sequence +++++++++++++++++++++++++++++++++++++
	draw_sequence D(
		.reset(KEY[2]),
		.command(command),
		.CLK(CLOCK_50),
		.choose(Back_state),
		.continue(~KEY[3]));
	
	ListedParts L1(
		/*Input*/
		.KEY1_n(KEYn1), 
		.KEY2_n(KEYn2), 
		.KEY3_n(KEYn3), 
		.KEY4_n(KEYn4),
		.GetSequence(seqSignal1),  
		.started(start1), 
		.counter160_4Hz(C160_64Hz1), 
		.CLOCK_50(CLOCK_50),
		/*Output*/ 
		.OutputX(X1), 
		.color(color1), 
		.currentState(crtState1),
		.hitSignal(hitSignal1),
		.LEDR());
	
	ListedParts L2(
		/*Input*/
		.KEY1_n(KEYn1), 
		.KEY2_n(KEYn2), 
		.KEY3_n(KEYn3), 
		.KEY4_n(KEYn4),
		.GetSequence(seqSignal2),
		.started(start2), 
		.counter160_4Hz(C160_64Hz2), 
		.CLOCK_50(CLOCK_50),
		/*Output*/ 
		.OutputX(X2), 
		.color(color2), 
		.currentState(crtState2), 
		.hitSignal(hitSignal2),
		.LEDR());
		
	ListedParts L3(
		/*Input*/ 
		.KEY1_n(KEYn1), 
		.KEY2_n(KEYn2), 
		.KEY3_n(KEYn3), 
		.KEY4_n(KEYn4),
		.GetSequence(seqSignal3),
		.started(start3), 
		.counter160_4Hz(C160_64Hz3), 
		.CLOCK_50(CLOCK_50),
		/*Output*/ 
		.OutputX(X3), 
		.color(color3), 
		.currentState(crtState3), 
		.hitSignal(hitSignal3),
		.LEDR());
		
	ListedParts L4(
		/*Input*/ 
		.KEY1_n(KEYn1), 
		.KEY2_n(KEYn2), 
		.KEY3_n(KEYn3), 
		.KEY4_n(KEYn4),
		.GetSequence(seqSignal4), 
		.started(start4), 
		.counter160_4Hz(C160_64Hz4), 
		.CLOCK_50(CLOCK_50),
		/*Output*/ 
		.OutputX(X4), 
		.color(color4), 
		.currentState(crtState4), 
		.hitSignal(hitSignal4),
		.LEDR());
	
	ListedParts L5(
		/*Input*/ 
		.KEY1_n(KEYn1), 
		.KEY2_n(KEYn2), 
		.KEY3_n(KEYn3), 
		.KEY4_n(KEYn4),
		.GetSequence(seqSignal5),
		.started(start5), 
		.counter160_4Hz(C160_64Hz5), 
		.CLOCK_50(CLOCK_50),
		/*Output*/ 
		.OutputX(X5), 
		.color(color5), 
		.currentState(crtState5), 
		.hitSignal(hitSignal5),
		.LEDR());
		
	ListedParts L6(
		/*Input*/ 
		.KEY1_n(KEYn1), 
		.KEY2_n(KEYn2), 
		.KEY3_n(KEYn3), 
		.KEY4_n(KEYn4),
		.GetSequence(seqSignal6),
		.started(start6), 
		.counter160_4Hz(C160_64Hz6), 
		.CLOCK_50(CLOCK_50),
		/*Output*/ 
		.OutputX(X6), 
		.color(color6), 
		.currentState(crtState6), 
		.hitSignal(hitSignal6),
		.LEDR());
		
	ListedParts L7(
		/*Input*/ 
		.KEY1_n(KEYn1), 
		.KEY2_n(KEYn2), 
		.KEY3_n(KEYn3), 
		.KEY4_n(KEYn4),
		.GetSequence(seqSignal7),
		.started(start7), 
		.counter160_4Hz(C160_64Hz7), 
		.CLOCK_50(CLOCK_50),
		/*Output*/ 
		.OutputX(X7), 
		.color(color7), 
		.currentState(crtState7), 
		.hitSignal(hitSignal7),
		.LEDR());
		
	ListedParts L8(
		/*Input*/ 
		.KEY1_n(KEYn1), 
		.KEY2_n(KEYn2), 
		.KEY3_n(KEYn3), 
		.KEY4_n(KEYn4),
		.GetSequence(seqSignal8),
		.started(start8), 
		.counter160_4Hz(C160_64Hz8), 
		.CLOCK_50(CLOCK_50),
		/*Output*/ 
		.OutputX(X8), 
		.color(color8), 
		.currentState(crtState8), 
		.hitSignal(hitSignal8),
		.LEDR());
		
	ListedParts L9(
		/*Input*/ 
		.KEY1_n(KEYn1), 
		.KEY2_n(KEYn2), 
		.KEY3_n(KEYn3), 
		.KEY4_n(KEYn4),
		.GetSequence(seqSignal9),
		.started(start9), 
		.counter160_4Hz(C160_64Hz9), 
		.CLOCK_50(CLOCK_50),
		/*Output*/ 
		.OutputX(X9), 
		.color(color9), 
		.currentState(crtState9), 
		.hitSignal(hitSignal9),
		.LEDR());
		
	ListedParts L10(
		/*Input*/ 
		.KEY1_n(KEYn1), 
		.KEY2_n(KEYn2), 
		.KEY3_n(KEYn3), 
		.KEY4_n(KEYn4),
		.GetSequence(seqSignal10),
		.started(start10), 
		.counter160_4Hz(C160_64Hz10), 
		.CLOCK_50(CLOCK_50),
		/*Output*/ 
		.OutputX(X10), 
		.color(color10), 
		.currentState(crtState10), 
		.hitSignal(hitSignal10),
		.LEDR());
		
	ListedParts L11(
		/*Input*/ 
		.KEY1_n(KEYn1), 
		.KEY2_n(KEYn2), 
		.KEY3_n(KEYn3), 
		.KEY4_n(KEYn4),
		.GetSequence(seqSignal11),
		.started(start11), 
		.counter160_4Hz(C160_64Hz11), 
		.CLOCK_50(CLOCK_50),
		/*Output*/ 
		.OutputX(X11), 
		.color(color11), 
		.currentState(crtState11), 
		.hitSignal(hitSignal11),
		.LEDR());
		
	ListedParts L12(
		/*Input*/ 
		.KEY1_n(KEYn1), 
		.KEY2_n(KEYn2), 
		.KEY3_n(KEYn3), 
		.KEY4_n(KEYn4),
		.GetSequence(seqSignal12),
		.started(start12), 
		.counter160_4Hz(C160_64Hz12), 
		.CLOCK_50(CLOCK_50),
		/*Output*/ 
		.OutputX(X12), 
		.color(color12), 
		.currentState(crtState12), 
		.hitSignal(hitSignal12),
		.LEDR());
		
	ListedParts L13(
		/*Input*/ 
		.KEY1_n(KEYn1), 
		.KEY2_n(KEYn2), 
		.KEY3_n(KEYn3), 
		.KEY4_n(KEYn4),
		.GetSequence(seqSignal3),
		.started(start14), 
		.counter160_4Hz(C160_64Hz13), 
		.CLOCK_50(CLOCK_50),
		/*Output*/ 
		.OutputX(X13), 
		.color(color13), 
		.currentState(crtState13), 
		.hitSignal(hitSignal13),
		.LEDR());
		
	ListedParts L14(
		/*Input*/ 
		.KEY1_n(KEYn1), 
		.KEY2_n(KEYn2), 
		.KEY3_n(KEYn3), 
		.KEY4_n(KEYn4),
		.GetSequence(seqSignal14),
		.started(start15), 
		.counter160_4Hz(C160_64Hz14), 
		.CLOCK_50(CLOCK_50),
		/*Output*/ 
		.OutputX(X14), 
		.color(color14), 
		.currentState(crtState14), 
		.hitSignal(hitSignal14),
		.LEDR());
		
	ListedParts L15(
		/*Input*/ 
		.KEY1_n(KEYn1), 
		.KEY2_n(KEYn2), 
		.KEY3_n(KEYn3), 
		.KEY4_n(KEYn4),
		.GetSequence(seqSignal15),
		.started(start15), 
		.counter160_4Hz(C160_64Hz15), 
		.CLOCK_50(CLOCK_50),
		/*Output*/ 
		.OutputX(X15), 
		.color(color15), 
		.currentState(crtState15), 
		.hitSignal(hitSignal15),
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
		
	counter_4Hz counter16(
		/*Input*/
		.CLK(CLOCK_50), 
		.resetn(1), 
		/*Output*/
		.EnableSignal(F4Hz));
		
	addressCounter counter18(
		/*Input*/
		.CLK(F4Hz),
		.resetn(1),
		/*Output*/	
		.address(address));
	
	//Note Sequence Info+++++++++++++++++++++++++++++++++++++
	noteSequence sequence(
		/*Input*/
		.address(address),
		.clock(CLOCK_50),
		.data(0),
		.wren(0),
		/*Output*/
		.q(currentSequence));
		
	sequenceManager sequenceMachine(
		/*Input*/
		.currentSequence(currentSequence), 
		.CLK(F4Hz), 
		.crtState1(crtState1),
		.crtState2(crtState2),
		.crtState3(crtState3), 
		.crtState4(crtState4), 
		.crtState5(crtState5), 
		.crtState6(crtState6), 
		.crtState7(crtState7), 
		.crtState8(crtState8),
		.crtState9(crtState9), 
		.crtState10(crtState10), 
		.crtState11(crtState11), 
		.crtState12(crtState12), 
		.crtState13(crtState13), 
		.crtState14(crtState14), 
		.crtState15(crtState15),
		/*Output*/
		.seqSignal1(seqSignal1), 
		.seqSignal2(seqSignal2), 
		.seqSignal3(seqSignal3), 
		.seqSignal4(seqSignal4), 
		.seqSignal5(seqSignal5), 
		.seqSignal6(seqSignal6), 
		.seqSignal7(seqSignal7), 
		.seqSignal8(seqSignal8),
		.seqSignal9(seqSignal9), 
		.seqSignal10(seqSignal10), 
		.seqSignal11(seqSignal11), 
		.seqSignal12(seqSignal12), 
		.seqSignal13(seqSignal13), 
		.seqSignal14(seqSignal14), 
		.seqSignal15(seqSignal15),
		
		.start1(start1),
		.start2(start2), 
		.start3(start3), 
		.start4(start4), 
		.start5(start5), 
		.start6(start6), 
		.start7(start7), 
		.start8(start8), 
		.start9(start9), 
		.start10(start10), 
		.start11(start11), 
		.start12(start12), 
		.start13(start13), 
		.start14(start14), 
		.start15(start15)
		
		);		
		
		
	//keyboard Part +++++++++++++++++++++++++++++++++++++
	KeyBoard PS2Input(
		.CLOCK_50(CLOCK_50),
		.PS2_CLK(PS2_CLK),
		.PS2_DAT(PS2_DAT), 
		.KEYn1(KEYn1), 
		.KEYn2(KEYn2), 
		.KEYn3(KEYn3), 
		.KEYn4(KEYn4));
	
	
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

			