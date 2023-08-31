module main_control
(
	input [5:0] Opcode, func,
	output reg RegDst, RegWrite, MemRead, MemtoReg, MemWrite, ALUSrc, Branch, Jump, Jal, Bneq,
	output reg [3:0] ALUOp
);
	
// This module is used for generating control signals for different instructions performed by the processor  	
	
	always @ (*) begin
	
		// R-type 
		if (Opcode == 6'b000000) begin		
			RegDst = 1'b1;
			RegWrite = 1'b1;
			MemRead = 1'b0;
			MemtoReg = 1'b0;
			MemWrite = 1'b0;
			ALUSrc = 1'b0;
			Branch = 1'b0;
			Jump = 1'b0;
			Jal = 1'b0;
			Bneq = 1'b0;
				
			if (func == 6'b100000)
				ALUOp = 4'b0001; 
				// add 
			else if (func == 6'b100010)
				ALUOp = 4'b1010; 
				// sub
			else if (func == 6'b100001) 
				ALUOp = 4'b0010; 
				// addu
			else if (func == 6'b100011) 
				ALUOp = 4'b1011;
				// subu
			else if (func == 6'b100100)
				ALUOp = 4'b0011; 
				// and	
			else if (func == 6'b100101) 
				ALUOp = 4'b0100; 
				// or
			else if (func == 6'b100111) 
				ALUOp = 4'b0101; 
				// nor 
			else if (func == 6'b101010) 
				ALUOp = 4'b0111; 
				// slt
			else if (func == 6'b101011) 
				ALUOp = 4'b0110; 
				// sltu
			else if (func == 6'b000000)
				ALUOp = 4'b1000;  
				// sll
			else if (func == 6'b000010) 
				ALUOp = 4'b1001;  
				// srl	 
			else if (func == 6'b000011)
				ALUOp = 4'b1100;
				// sra
			else if (func == 6'b001000) 
				ALUOp = 4'b0000; 
				// jr
		end
		
		// Jump(J-type)
		else if (Opcode == 6'b000010) begin
			RegDst = 1'b0;
			RegWrite = 1'b0;
			MemRead = 1'b0;
			MemtoReg = 1'b0;
			MemWrite = 1'b0;
			ALUSrc = 1'b0;
			ALUOp = 4'b0000;
			Branch = 1'b0;
			Jump = 1'b1;
			Jal = 1'b0;
			Bneq = 1'b0;
		end
		
		// Jal (J-type)
		else if (Opcode == 6'b000011) begin
			RegDst = 1'b0;
			RegWrite = 1'b0;
			MemRead = 1'b0;
			MemtoReg = 1'b0;
			MemWrite = 1'b0;
			ALUSrc = 1'b0;
			ALUOp = 4'b0000;
			Branch = 1'b0;
			Jump = 1'b1;
			Jal = 1'b1;
			Bneq = 1'b0;
		end
		
		// I-Type Instructions
		
		// addi 
		else if (Opcode == 6'b001000) begin
			RegDst = 1'b0;
			RegWrite = 1'b1;
			MemRead = 1'b0;
			MemtoReg = 1'b0;
			MemWrite = 1'b0;
			ALUSrc = 1'b1;
			ALUOp = 4'b0001;
			Branch = 1'b0;
			Jump = 1'b0;
			Jal = 1'b0;
			Bneq = 1'b0;
		end
		
		// addiu 
		else if (Opcode == 6'b001001) begin
			RegDst = 1'b0;
			RegWrite = 1'b1;
			MemRead = 1'b0;
			MemtoReg = 1'b0;
			MemWrite = 1'b0;
			ALUSrc = 1'b1;
			ALUOp = 4'b0010;
			Branch = 1'b0;
			Jump = 1'b0;
			Jal = 1'b0;
			Bneq = 1'b0;
		end
		
		// andi 
		else if (Opcode == 6'b001100) begin
			RegDst = 1'b0;
			RegWrite = 1'b1;
			MemRead = 1'b0;
			MemtoReg = 1'b0;
			MemWrite = 1'b0;
			ALUSrc = 1'b1;
			ALUOp = 4'b0011;
			Branch = 1'b0;
			Jump = 1'b0;
			Jal = 1'b0;
			Bneq = 1'b0;			
		end
		
		// ori 
		else if (Opcode == 6'b001101) begin
			RegDst = 1'b0;
			RegWrite = 1'b1;
			MemRead = 1'b0;
			MemtoReg = 1'b0;
			MemWrite = 1'b0;
			ALUSrc = 1'b1;
			ALUOp = 4'b0100;
			Branch = 1'b0;
			Jump = 1'b0;
			Jal = 1'b0;
			Bneq = 1'b0;
		end
		
		// slti 
		else if (Opcode == 6'b001010) begin
			RegDst = 1'b0;
			RegWrite = 1'b1;
			MemRead = 1'b0;
			MemtoReg = 1'b0;
			MemWrite = 1'b0;
			ALUSrc = 1'b1;
			ALUOp = 4'b0111;
			Branch = 1'b0;
			Jump = 1'b0;
			Jal = 1'b0;
			Bneq = 1'b0;
		end
		
		// sltui 
		else if (Opcode == 6'b001011) begin
			RegDst = 1'b0;
			RegWrite = 1'b1;
			MemRead = 1'b0;
			MemtoReg = 1'b0;
			MemWrite = 1'b0;
			ALUSrc = 1'b1;
			ALUOp = 4'b0110;
			Branch = 1'b0;
			Jump = 1'b0;
			Jal = 1'b0;
			Bneq = 1'b0;
		end
		
		// beq
		else if (Opcode == 6'b000100) begin
			RegDst = 1'b0;
			RegWrite = 1'b0;
			MemRead = 1'b0;
			MemtoReg = 1'b0;
			MemWrite = 1'b0;
			ALUSrc = 1'b0;			
			ALUOp = 4'b1010;
			Branch = 1'b1;
			Jump = 1'b0;
			Jal = 1'b0;
			Bneq = 1'b0;			
		end
		
		// bneq 
		else if (Opcode == 6'b000101) begin
			RegDst = 1'b0;
			RegWrite = 1'b0;
			MemRead = 1'b0;
			MemtoReg = 1'b0;
			MemWrite = 1'b0;
			ALUSrc = 1'b1;
			ALUOp = 4'b1010;
			Branch = 1'b1;
			Jump = 1'b0;
			Jal = 1'b0;
			Bneq = 1'b1;
		end
		
		// ll
		else if (Opcode == 6'b110000) begin
			RegDst = 1'b0;
			RegWrite = 1'b1;
			MemRead = 1'b0;
			MemtoReg = 1'b0;
			MemWrite = 1'b0;
			ALUSrc = 1'b1;
			ALUOp = 4'b1001;
			Branch = 1'b0;
			Jump = 1'b0;
			Jal = 1'b0;
			Bneq = 1'b0;
		end
		
		// lui
		else if (Opcode == 6'b001111) begin
			RegDst = 1'b0;
			RegWrite = 1'b1;
			MemRead = 1'b0;
			MemtoReg = 1'b0;
			MemWrite = 1'b0;
			ALUSrc = 1'b1;
			ALUOp = 4'b1101;
			Branch = 1'b0;
			Jump = 1'b0;
			Jal = 1'b0;
			Bneq = 1'b0;
		end
		
		// lw 
		else if (Opcode == 6'b100011) begin
			RegDst = 1'b0;
			RegWrite = 1'b1;
			MemRead = 1'b1;
			MemtoReg = 1'b1;
			MemWrite = 1'b0;
			ALUSrc = 1'b1;
			ALUOp = 4'b0001;
			Branch = 1'b0;
			Jump = 1'b0;
			Jal = 1'b0;
			Bneq = 1'b0;
		end
		
		// sw
		else if (Opcode == 6'b101011) begin
			RegDst = 1'b0;
			RegWrite = 1'b0;
			MemRead = 1'b0;
			MemtoReg = 1'b0;
			MemWrite = 1'b1;
			ALUSrc = 1'b1;
			ALUOp = 4'b0001;
			Branch = 1'b0;
			Jump = 1'b0;
			Jal = 1'b0;
			Bneq = 1'b0;
		end
	end
endmodule
