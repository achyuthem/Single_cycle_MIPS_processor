module d_mem (
	input clk,
	input [31:0] mem_address, 
	input [31:0] write_data, 
	input MemRead, MemWrite, 
	output reg [31:0] read_data
);

//This module is used for modelling the data memory of processor 

reg [31:0] d_mem [255:0];

initial begin
	$readmemb(".\\data.mem", d_mem);     //initialization of data memory
end

always @(mem_address or MemRead) begin
	if (MemRead) begin
		read_data <= d_mem[mem_address];
	end
end

always @(posedge clk) begin
	if (MemWrite) begin
		d_mem[mem_address] <= write_data[31:0];
	end
end

endmodule