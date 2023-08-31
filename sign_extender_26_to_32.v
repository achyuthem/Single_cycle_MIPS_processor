module sign_extender_26_to_32
(
	input [25:0] inp,
	output reg [31:0] sign_out
);

//This module is used for sign extending a 26-bit input to a 32-bit input

always @ (*) begin

	sign_out[25:0] = inp[25:0];
	if (inp[15] == 1'b1)
		sign_out[31:26] = 16'b111111;
	else
		sign_out[31:26] = 16'b000000;

end 

endmodule
