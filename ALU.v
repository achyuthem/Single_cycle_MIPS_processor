module ALU
(
	input [31:0] input1, input2,
	input [3:0] ALUOp,
	input [4:0] shift,
	output reg [31:0] ALUOut,
	output reg zero,
	output reg overflow
);


// This module performs various arithemetic operations on the inputs according to the control input specified


always @ (*) begin

	case (ALUOp)
		4'b0001:		
					begin                                             //add
						ALUOut = $signed(input1) + $signed(input2);
						overflow = (input1[31] && input2[31] && ~ALUOut[31]) || (~input1[31] && ~input2[31] && ALUOut[31]);
					end					
		4'b0010:	ALUOut = $unsigned(input1) + $unsigned(input2);   //addu
		4'b1101:	begin
						ALUOut[31:16] = input1[15:0];                 //lui
						ALUOut[15:0] = 16'b0000000000000000;
					end
		4'b0011:	ALUOut = input1 & input2;                         //and
		4'b0101:	ALUOut = ~(input1 | input2);                      //nor
		4'b0100:	ALUOut = input1 | input2;                         //or
		4'b1001:	ALUOut = input2 >> shift;                         //right shift
		4'b1000:	ALUOut = input2 << shift;                         //left shift
		4'b0111: 	ALUOut = (input1 < input2);                       //slt
		4'b0110:	ALUOut = (input1 < input2);                       //sltu
		
		4'b1010:	begin
						ALUOut = $signed(input1) - $signed(input2);   //sub
						overflow = (input1[31] && input2[31] && ~ALUOut[31]) || (~input1[31] && ~input2[31] && ALUOut[31]);
					end
		4'b1100:	ALUOut = input2 >>> shift;	                      //sra
		4'b1011:	ALUOut = $unsigned(input1) - $unsigned(input2);   //subu
	endcase
	zero = (ALUOut == 32'b0) && (~overflow);
end

endmodule
