module sign_extender_16_to_32
(
	input [15:0] inp,
	output reg [31:0] sign_out
);

//This module is used for sign extending a 16-bit input to a 32-bit input

always @ (*) begin

	sign_out[15:0] = inp[15:0];
	if (inp[15] == 1'b1)
		sign_out[31:16] = 16'b1111111111111111;
	else
		sign_out[31:16] = 16'b0000000000000000;

end 

endmodule