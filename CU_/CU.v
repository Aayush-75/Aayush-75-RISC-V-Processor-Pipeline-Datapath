module CU(
	input reset,
	input [5:0]opcode,		//for R,I,J
	input [4:0]shift_amt,		//for R
	input [5:0]opcode_ext,		//for R
	input [15:0]operand_offset,	//for I
	input [25:0]jump_target,	//for J
	input [31:0]pc, //provided by IFU in top module 
	
	output reg [5:0] alu_control,
	
	output reg load_inst,
	output reg store_inst,
	
	output reg bne_control,
	output reg beq_control,
	output reg bltz_control,
	output reg jump_control
);

integer prev_pc;
initial
	begin
		prev_pc = 0;
	end
	

always @(pc-prev_pc != 0)
begin
	if((opcode) >= 6'h00 && (opcode)<= 6'h14)//R type instruction
	begin
		load_inst = 0;
		store_inst = 0;
		jump_control = 0;
		bne_control = 0;
		beq_control = 0;
		bltz_control = 0;
		
		case(opcode>>2)
		//mfhi
		6'h00 : begin
		alu_control = 6'h00;
		end
		//mflo
		6'h01 : begin
		alu_control = 6'h01;
		end
		//add
		6'h02 : begin
		alu_control = 6'h02;
		end
		//addu
		6'h03 : begin
		alu_control = 6'h03;
		end
		//sub
		6'h04 : begin
		alu_control = 6'h04;
		end
		//subu
		6'h05 : begin
		alu_control = 6'h05;
		end
		//slt
		6'h06 : begin
		alu_control = 6'h06;
		end
		//mult
		6'h07 : begin
		alu_control = 6'h07;
		end
		//multu
		6'h08 : begin
		alu_control = 6'h08;
		end
		//div
		6'h09 : begin
		alu_control = 6'h09;
		end
		//divu
		6'h0A : begin
		alu_control = 6'h0A;
		end
		//sll
		6'h0B : begin
		alu_control = 6'h0B;
		end
		//srl
		6'h0C : begin
		alu_control = 6'h0C;
		end
		//sra
		6'h0D : begin
		alu_control = 6'h0D;
		end
		//sllv
		6'h0E : begin
		alu_control = 6'h0E;
		end
		//srlv
		6'h0F : begin
		alu_control = 6'h0F;
		end
		//srav
		6'h10 : begin
		alu_control = 6'h10;
		end
		//and
		6'h11 : begin
		alu_control = 6'h11;
		end
		//or
		6'h12 : begin
		alu_control = 6'h12;
		end
		//xor
		6'h13 : begin
		alu_control = 6'h13;
		end
		//nor
		6'h14 : begin
		alu_control = 6'h14;
		end
		endcase
	end
	else if((opcode)> 6'h14 && (opcode)<= 6'h20)//I type instruction
	begin
		load_inst = 0;
		store_inst = 0;
		jump_control = 0;
		bne_control = 0;
		beq_control = 0;
		bltz_control = 0;
		
		case(opcode>>2)
		//lui
		6'h15 : begin
		load_inst = 0;
		store_inst = 0;
		end
		//addi
		6'h16 : begin
		load_inst = 0;
		store_inst = 0;
		end
		//addiu
		6'h17 : begin
		load_inst = 0;
		store_inst = 0;		
		end
		//slti
		6'h18 : begin
		load_inst = 0;
		store_inst = 0;		
		end
		//andi
		6'h19 : begin
		load_inst = 0;
		store_inst = 0;
		end	
		//ori
		6'h1A : begin
		load_inst = 0;
		store_inst = 0;
		end	
		//xori
		6'h1B : begin
		load_inst = 0;
		store_inst = 0;
		end	
		//lw
		6'h1C : begin
		load_inst = 1;
		store_inst = 0;
		end	
		//lb
		6'h1D : begin
		load_inst = 1;
		store_inst = 0;
		end	
		//lbu
		6'h1E : begin
		load_inst = 1;
		store_inst = 0;
		end	
		//sw
		6'h1F : begin
		load_inst = 0;
		store_inst = 1;
		end
		//sb
		6'h20 : begin
		load_inst = 0;
		store_inst = 1;
		end		
		endcase
		alu_control = (opcode);
	end
	else if((opcode)> 6'h20 && (opcode)<= 6'h27)//J type instruction
	begin
		load_inst = 0;
		store_inst = 0;
		jump_control = 0;
		bne_control = 0;
		beq_control = 0;
		bltz_control = 0;
		
		case(opcode)
		//j-
		6'h21 : begin
		jump_control = 1;
		bne_control = 0;
		beq_control = 0;
		bltz_control = 0;
		end	
		//jal-
		6'h22 : begin
		jump_control = 1;
		bne_control = 0;
		beq_control = 0;
		bltz_control = 0;		
		end	
		//jr-
		6'h23 : begin
		jump_control = 1;
		bne_control = 0;
		beq_control = 0;
		bltz_control = 0;	
		end
		//bltz-
		6'h24 : begin
		bltz_control = 1;
		bne_control = 0;
		beq_control = 0;
		jump_control = 0;
		end	
		//beq
		6'h25 : begin
		beq_control = 1;
		bne_control = 0;
		jump_control = 0;
		bltz_control = 0;
		end	
		//bne
		6'h26 : begin
		bne_control = 1;
		jump_control = 0;
		beq_control = 0;
		bltz_control = 0;
		end	
		//syscall
		6'h27 : begin
		
		end	
		endcase
		alu_control = (opcode);
	end
	prev_pc = pc;
end

endmodule