module mux_5bit
(
	input [4:0] inp1, 
	input [4:0] inp2,
	input mux_select,
	output reg [4:0] mux_out
);

//This module is used for selecting one of the inputs to the output

always @ (*) begin
	if (mux_select == 1'b0)
		mux_out = inp1;
	else	
		mux_out = inp2;
end


endmodule
