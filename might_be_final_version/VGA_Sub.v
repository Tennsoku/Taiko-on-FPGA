//----------------------------------------------------------------------------------------------------------------------//
module VGA_controller(CLK,VGA_display,reading_X,reading_Y,sending_X,sending_Y,X_to_translate,Y_to_translate);
input VGA_display;
input CLK;
input [7:0]reading_X,sending_X;
input [6:0]reading_Y,sending_Y;
output reg [7:0]X_to_translate;
output reg [6:0]Y_to_translate;

always@(posedge CLK)
begin
	
	if(VGA_display==1'b1)
		begin 
		X_to_translate<=sending_X;
		Y_to_translate<=sending_Y;
		end
	else
		begin 
		X_to_translate<=reading_X;
		Y_to_translate<=reading_Y;
		end
 
end

endmodule 

//Address chooser-------------------------------------------------------------------------------------------------------//
module choose_address(VGA_display,storing_mode_address,displaying_mode_address,address_to_access);
input VGA_display;
input [14:0]storing_mode_address,displaying_mode_address;
output reg [14:0]address_to_access;
always@(*)
begin
	if(VGA_display)
	address_to_access=storing_mode_address;
	else
	address_to_access=displaying_mode_address;
end

endmodule 