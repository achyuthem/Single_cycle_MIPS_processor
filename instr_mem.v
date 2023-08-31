module instr_mem 
(
	input [31:0] program_counter,
	output [31:0] instruction
);

//This module models the instruction memory of a single cycle MIPS processor

reg [31:0] i_mem [255:0];

initial begin
	$readmemb(".\\instruction.mem", i_mem);  //initialization of instruction memory
end

assign instruction = i_mem[program_counter];

endmodule
