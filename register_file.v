module register_file
(
	input [4:0] read_adr_1, read_adr_2, write_adr,
	input [31:0] write_data,
	input RegWrite, Jal, clk,
	input [31:0] pc,
	output reg [31:0] read_data_1, read_data_2
);

// This module is used for modelling the register file of the processor

	reg [31:0] reg_file [31:0];
	
	initial begin
		$readmemb(".\\registers.mem", reg_file);  //initialization of register file
	end

	always @ (read_adr_1 or read_adr_2) begin
		read_data_1 <= reg_file[read_adr_1];
		read_data_2 <= reg_file[read_adr_2];
	end
	
	always @(posedge clk ) begin
		if (RegWrite) begin
			reg_file[write_adr] <= write_data;
		end
		
		if (Jal) begin
			reg_file[31] = pc + 2;
		end
	end
endmodule
