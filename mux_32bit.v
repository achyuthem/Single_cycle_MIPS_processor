module mux_32bit
(
	input [31:0] inp1,
	input [31:0] inp2,
	input mux_select,
	output reg [31:0] mux_out
);

//This module is used for selecting one of the 32-bit inputs to the output 

always @ (*) begin

if (mux_select == 1'b0)
	mux_out = inp1;
else	
	mux_out = inp2;
	
end
endmodule
