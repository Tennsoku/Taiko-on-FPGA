

module draw_sequence (reset,command,CLK);

input CLK;
input reset;

output reg [3:0]command;

reg [3:0]current;

reg [3:0]next;

reg [3:0]return_state;



parameter [3:0]One=4'b0000,Two=4'b0001,Three=4'b0010,Four=4'b0011,Five=4'b0100,Six=4'b0101,Seven=4'b0110,Eight=4'b0111,Nine=4'b1000,Ten=4'b1001,Eleven=4'b1010,Twelve=4'b1011,Thirteen=4'b1100,Fourteen=4'b1101,Fifteen=4'b1110,Black=4'b1111;


always@(*)

begin

case(current[3:0])


One:

next=Black;

Two:

next=Black;

Three:

next=Black;

Four:

next=Black;

Five:

next=Black;

Six:

next=Black;

Seven:

next=Black;

Eight:

next=Black;

Nine:

next=Black;

Ten:

next=Black;

Eleven:

next=Black;

Twelve:

next=Black;

Thirteen:

next=Black;

Fourteen:

next=Black;

Fifteen:

next=Black;

Black:

next=return_state;


endcase 

end 




always@(*)

begin 

case(current[3:0])


One:
begin
command=4'b0000;

return_state=4'b0001;
end
Two:
begin
command=4'b0001;

return_state=4'b0010;;
end
Three:
begin
command=4'b0010;

return_state=4'b0011;
end
Four:
begin
command=4'b0011;

return_state=4'b0100;
end
Five:
begin
command=4'b0100;

return_state=4'b0101;
end
Six:
begin
command=4'b0101;

return_state=4'b0110;
end
Seven:
begin
command=4'b0110;

return_state=4'b0111;;
end
Eight:
begin
command=4'b0111;

return_state=4'b1000;
end
Nine:
begin
command=4'b1000;

return_state=4'b1001;
end
Ten:
begin
command=4'b1001;

return_state=4'b1010;
end
Eleven:
begin
command=4'b1010;

return_state=4'b1011;
end
Twelve:
begin
command=4'b1011;

return_state=4'b1100;
end
Thirteen:
begin
command=4'b1100;

return_state=4'b1101;
end
Fourteen:
begin
command=4'b1101;

return_state=4'b1110;
end
Fifteen:
begin

command=4'b1110;
return_state=4'b0000;

end


Black:
command=4'b1111;


endcase 

end 



always@(posedge CLK)
begin

if(!reset)
current=One;
else
current=next;

end

endmodule 