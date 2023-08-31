module single_cycle_processor(clk);
input clk;

wire [31:0] instruction;
wire [31:0] read_data_1,read_data_2, write_reg_data;
wire [31:0] memory_out;
wire [31:0] pcWriteAdress;
wire [4:0] write_reg, read_adr_1, read_adr_2,shift;
wire [4:0] destination_reg;
wire [5:0] func;
wire [15:0] immi;
wire [25:0] address;
wire Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite, RegDst, Jump, Jal, Bneq;
wire [5:0] Opcode;
wire [3:0] ALUOp;
wire [31:0] extended_value, ALUInput, ALUResult;
wire zero;
wire overflow = 1'b0;



assign Opcode = instruction[31:26];
assign read_adr_1 = instruction[25:21]; // rs
assign read_adr_2 = instruction[20:16]; //rt
assign write_reg = instruction[15:11];  //rd
assign shift = instruction[10:6];
assign func = instruction[5:0];
assign address = instruction[25:0];
assign immi = instruction[15:0];



reg[31:0] PC = 32'b0;



// main control unit
main_control u1 (Opcode, func, RegDst, RegWrite, MemRead, MemtoReg, MemWrite, ALUSrc, Branch, Jump, Jal, Bneq, ALUOp);


// instruction fetch
instr_mem u2 (PC, instruction); 


// mux for selecting destination register
mux_5bit u3 (read_adr_2, write_reg, RegDst, destination_reg); 


// sign extension for immediate value
sign_extender_16_to_32 u4(immi, extended_value); 


// register file
register_file u5 (read_adr_1,read_adr_2,destination_reg,write_reg_data,RegWrite,Jal,clk,PC,read_data_1,read_data_2);


// mux for selecting ALU source
mux_32bit u6 (read_data_2, extended_value, ALUSrc, ALUInput); 


// ALU operation
ALU u7 (read_data_1, ALUInput, ALUOp, shift, ALUResult, zero, overflow);


// data memory
d_mem u8 (clk, ALUResult, read_data_2, MemRead, MemWrite, memory_out);



// mux is used for selecting data to write register
mux_32bit u9 (ALUResult, memory_out,MemtoReg,write_reg_data);



// sign extension used for Jump address
sign_extender_26_to_32 u10 (address, pcWriteAdress);


always @(posedge clk)
begin
	
	// deciding whether to branch or not
	if ((Branch && zero) || Bneq)
		PC = PC + extended_value + 1;
	
	// jr instruction
	else if (Jump && Opcode == 6'b000000)
		PC = read_data_1;
			
	// Jump instruction
	else if (Jump) 
		PC = pcWriteAdress;
		
	else 
		PC = PC+1;
end 

initial begin
$monitor("Time:%3d, Instruction: %h, Opcode: %6b, PC: %32b",$time,instruction, Opcode, PC);
end

endmodule
