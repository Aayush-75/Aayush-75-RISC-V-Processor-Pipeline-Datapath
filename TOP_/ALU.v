module ALU(
	input [31:0] rs1,		//R Type Instruction
	input [31:0] rs2,		//R,I Type Instruction
	input [31:0] Imm_operand,	//I Type Instruction(this is used here as value/operand and not as address it must be used as address in RFU) //it is provided directly from instruction code output of IMU
	input [6:0] alu_control,
	input [31:0] gen_purpose_reg_data_read,//data will come from RFU in top module
	input [31:0] pc,
	
	output reg [31:0] gen_purpose_reg_data_write,//this data will be provided to RFU in top module
	output reg [31:0] dest_reg_data,	//R,I Type Instruction
	output reg branch_control 
);


integer temp;

initial 
begin
	gen_purpose_reg_data_write = 0;
	dest_reg_data = 0;
	temp = 0;
	branch_control = 0;
end


always @(*)
begin
	if(branch_control == 1)
		branch_control = 0;
	
	case(alu_control)
	
		default : begin
		dest_reg_data = 0;
		end
		//addi
		1 : begin
		dest_reg_data = $signed(Imm_operand[11:0]) + $signed(rs1);
		end
		//slti
		2 : begin
			if($signed(rs1) < $signed(Imm_operand[11:0]))
				dest_reg_data = 1;
			else
				dest_reg_data = 0;
		end
		//sltiu
		3 : begin
			if($unsigned(rs1) < $signed(Imm_operand[11:0]))
				dest_reg_data = 1;
			else
				dest_reg_data = 0;
		end
		//andi
		4 : begin
		dest_reg_data = rs1 & ({{20{Imm_operand[11]}}, Imm_operand[11:0]});
		end
		//ori
		5 : begin
		dest_reg_data = rs1 | ({{20{Imm_operand[11]}}, Imm_operand[11:0]});
		end
		//xori
		6 : begin
		dest_reg_data = rs1 ^ ({{20{Imm_operand[11]}}, Imm_operand[11:0]});
		end
		//slli
		7 : begin
		dest_reg_data = rs1 << Imm_operand[4:0];
		end
		//srli
		8 : begin
		dest_reg_data = rs1 >> Imm_operand[4:0];
		end
		//srai
		9 : begin
		dest_reg_data = rs2 >>> Imm_operand[4:0];
		end
		//lui
		10 : begin
		dest_reg_data = {Imm_operand, 12'b0};
		end
		//auipc
		11:begin 
		dest_reg_data = {Imm_operand, 12'b0};
		end

		//add
		12 : begin
		dest_reg_data = (rs1) + (rs2);
		gen_purpose_reg_data_write = dest_reg_data;
		end
		//slti
		13 : begin
			if($signed(rs1) < $signed(rs2))
				dest_reg_data = 1;
			else
				dest_reg_data = 0;
		end
		//sltiu
		14 : begin
			if($unsigned(rs1) < $unsigned(rs2))
				dest_reg_data = 1;
			else
				dest_reg_data = 0;
		end
		//and
		15 : begin
		dest_reg_data = rs1 & rs2;
		end
		//or
		16 : begin
		dest_reg_data = rs1 | rs2;
		end
		//xor
		17 : begin
		dest_reg_data = rs1 ^ rs2;
		end
		//sll
		18 : begin
		dest_reg_data = rs1 << rs2;
		end
		//srl
		19 : begin
		dest_reg_data = rs1 >> rs2;
		end
		//sub
		20 : begin
		dest_reg_data = (rs1) - (rs2);
		end
		//sra
		21 : begin
		dest_reg_data = rs1 >>> rs2;
		end	
		//jal
		22: begin
		dest_reg_data <= pc+4;
		end
		//jalr
		23:begin
		dest_reg_data <= pc+4;
		end		
		//beq
		24 : 
		begin
			if(rs1==rs2)
			begin
				branch_control = 1;
			end	
		end
		//bne
		25 : 
		begin
			if(rs1!=rs2)
			begin
				branch_control = 1;
			end	
		end
		//blt-
		26 : 
		begin
			if(rs1<rs2)
			begin
				branch_control = 1;
			end
		end
		//bltu
		27 :
		begin
			if($unsigned(rs1) < $unsigned(rs2))
			begin
				branch_control = 1;
			end
		end
		//bge
		28 :
		begin
			if(rs1>=rs2)
				begin
					branch_control = 1;
				end
		end
		//bgeu
		29 :
		begin
			if($unsigned(rs1) >= $unsigned(rs2))
				begin
					branch_control = 1;
				end
		end
		
		
		
		//lw
		30 : begin
		dest_reg_data = $signed(gen_purpose_reg_data_read[31:0]);
		end
		//lh
		31 : begin
		dest_reg_data = $signed(gen_purpose_reg_data_read[15:0]);
		end		
		//lhu
		32 : begin
		dest_reg_data = $unsigned(gen_purpose_reg_data_read[15:0]);
		end		
		//lb
		33 : begin
		dest_reg_data = $signed(gen_purpose_reg_data_read[7:0]); 
		end	
		//lbu
		34 : begin
		dest_reg_data = $unsigned(gen_purpose_reg_data_read[7:0]); 
		end
		
		//sw
		35 : begin
		gen_purpose_reg_data_write = rs2[31:0];
		end
		//sh
		36 : begin
		gen_purpose_reg_data_write = rs2[15:0];
		end
		//sb
		37 : begin
		gen_purpose_reg_data_write = rs2[7:0];
		end
					
		endcase		
end

endmodule
