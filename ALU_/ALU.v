module ALU(
	input [31:0] rs,		//R Type Instruction
	input [31:0] rt,		//R,I Type Instruction
	input [15:0] Imm_operand,	//I Type Instruction(this is used here as value/operand and not as address it must be used as address in RFU) //it is provided directly from instruction code output of IMU
	input [5:0] shift_amt,		//R Type Instruction
	input [5:0] alu_control,
	
	input [31:0] gen_purpose_reg_data_read,//data will come from RFU in top module
	output reg [31:0] gen_purpose_reg_data_write,//this data will be provided to RFU in top module
	output reg [31:0] dest_reg_data	//R,I Type Instruction	
);

reg [31:0] Hi;
reg [31:0] Lo;
integer temp;

always @(*)
begin
	case(alu_control)
		//R type
		
		//mfhi
		6'h00 : begin
		dest_reg_data = Hi;
		end
		//mflo
		6'h01 : begin
		dest_reg_data = Lo;
		end
		//add
		6'h02 : begin
		dest_reg_data = $signed(rs) + $signed(rt);
		end
		//addu
		6'h03 : begin
		dest_reg_data = $unsigned(rs) + $unsigned(rt);
		end
		//sub
		6'h04 : begin
		dest_reg_data = $signed(rs) - $signed(rt);
		end
		//subu
		6'h05 : begin
		dest_reg_data = $unsigned(rs) - $unsigned(rt);
		end
		//slt
		6'h06 : begin
		if(rs < rt)
			dest_reg_data = 1;
		else
			dest_reg_data = 0;
		end
		//mult
		6'h07 : begin
		temp = $signed(rs)* $signed(rt);
		Lo = temp & 32'hFFFFFFFF;
		Hi = temp >> 32;
		end
		//multu
		6'h08 : begin
		temp = $unsigned(rs)* $unsigned(rt);
		Lo = temp & 32'hFFFFFFFF;
		Hi = temp >> 32;
		end
		//div
		6'h09 : begin
		Lo =  $signed(rs)/$signed(rt);
		Hi =  $signed(rs)%$signed(rt);
		end
		//divu
		6'h0A : begin
		Lo =  $unsigned(rs)/$unsigned(rt);
		Hi =  $unsigned(rs)%$unsigned(rt);
		end
		//sll
		6'h0B : begin
		dest_reg_data = rt << shift_amt;
		end
		//srl
		6'h0C : begin
		dest_reg_data = rt >> shift_amt;
		end
		//sra
		6'h0D : begin
		dest_reg_data = rt >>> shift_amt;
		end
		//sllv
		6'h0E : begin
		dest_reg_data = rt << rs;
		end
		//srlv
		6'h0F : begin
		dest_reg_data = rt >> rs;
		end
		//srav
		6'h10 : begin
		dest_reg_data = rt >>> rs;
		end
		//and
		6'h11 : begin
		dest_reg_data = rs & rt;
		end
		//or
		6'h12 : begin
		dest_reg_data = rs | rt;
		end
		//xor
		6'h13 : begin
		dest_reg_data = rs ^ rt;
		end
//chk		//nor
		6'h14 : begin
		dest_reg_data = ~(rs | rt);
		end
		
		//I type
		
		//lui
		6'h15 : begin
		dest_reg_data = 0;
		dest_reg_data = Imm_operand << 16;
		end
		//addi-
		6'h16 : begin
		dest_reg_data = $signed(rs) + $signed(Imm_operand);
		end
		//addiu-
		6'h17 : begin
		dest_reg_data = $unsigned(rs) + $unsigned(Imm_operand);
		end
		//slti-
		6'h18 : begin
		if(rs < Imm_operand)
			dest_reg_data = 1;
		else
			dest_reg_data = 0;
		end
		//andi-
		6'h19 : begin
		dest_reg_data = rs & Imm_operand;
		end	
		//ori-
		6'h1A : begin
		dest_reg_data = rs | Imm_operand;
		end	
		//xori
		6'h1B : begin
		dest_reg_data = rs ^ Imm_operand;
		end
		
		//lw
		6'h1C : begin
		dest_reg_data = (gen_purpose_reg_data_read & 16'hFFFF);
		dest_reg_data = {{16{dest_reg_data[15]}}, dest_reg_data}; 
		end	
		//lb
		6'h1D : begin
		dest_reg_data = (gen_purpose_reg_data_read & 8'hFF);
		dest_reg_data = {{24{dest_reg_data[7]}}, dest_reg_data}; 
		end	
		//lbu
		6'h1E : begin
		dest_reg_data = $unsigned(gen_purpose_reg_data_read & 8'hFF);
		end	
		//sw
		6'h1F : begin
		gen_purpose_reg_data_write = rt & 16'hFFFF;
		end
		//sb
		6'h20 : begin
		gen_purpose_reg_data_write = rt & 8'hFF;
		end
		
		//J type
		
		//bltz-
		6'h24 : begin
		
		end
		//beq
		6'h25 : begin

		end	
		//bne
		6'h26 : begin

		end	
		endcase		
end

endmodule