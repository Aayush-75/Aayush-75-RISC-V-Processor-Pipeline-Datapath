module IMU(
	input clk,
	input [31:0]pc,//it will be provided by IFU by incrementing it after fetching of machine code one by one
	//for r type instruction fetched from IFU in top module
	input [5:0]opcode,
	input [4:0]rs,
	input [4:0]rt,
	input [4:0]rd,
	input [4:0]shift_amt,
	//for i type instruction fetched from IFU in top module
	input [15:0]Imm_operand,
	//for j type instruction fetched from IFU in top module
	input [25:0]jump_target,
	output reg [31:0]instruction_code
);
reg [7:0] memory [159:0];
integer prev_pc;

initial 
begin
prev_pc = 0;
end

always @(posedge clk)
begin
	if(pc!=prev_pc)
	begin
		//R type instructions
		//mfhi-
		memory[3] = {6'h00, (rs[4:3])};
		memory[2] = {rs[2:0], rt};
		memory[1] = {rd, shift_amt[4:2]};
		memory[0] = {shift_amt[1:0], 6'h00};

		//mflo-
		memory[7] = {6'h01, (rs[4:3])};
		memory[6] = {rs[2:0], rt};
		memory[5] = {rd, shift_amt[4:2]};
		memory[4] = {shift_amt[1:0], 6'h00};

		//add-
		memory[11] = {6'h02, (rs[4:3])};
		memory[10] = {rs[2:0], rt};
		memory[9] = {rd, shift_amt[4:2]};
		memory[8] = {shift_amt[1:0], 6'h00};

		//addu-
		memory[15] = {6'h03, (rs[4:3])};
		memory[14] = {rs[2:0], rt};
		memory[13] = {rd, shift_amt[4:2]};
		memory[12] = {shift_amt[1:0], 6'h00};

		//sub-
		memory[19] = {6'h04, (rs[4:3])};
		memory[18] = {rs[2:0], rt};
		memory[17] = {rd, shift_amt[4:2]};
		memory[16] = {shift_amt[1:0], 6'h00};

		//subu-
		memory[23] = {6'h05, (rs[4:3])};
		memory[22] = {rs[2:0], rt};
		memory[21] = {rd, shift_amt[4:2]};
		memory[20] = {shift_amt[1:0], 6'h00};

		//slt-
		memory[27] = {6'h06, (rs[4:3])};
		memory[26] = {rs[2:0], rt};
		memory[25] = {rd, shift_amt[4:2]};
		memory[24] = {shift_amt[1:0], 6'h00};

		//mult-
		memory[31] = {6'h07, (rs[4:3])};
		memory[30] = {rs[2:0], rt};
		memory[29] = {rd, shift_amt[4:2]};
		memory[28] = {shift_amt[1:0], 6'h00};

		//multu-
		memory[35] = {6'h08, (rs[4:3])};
		memory[34] = {rs[2:0], rt};
		memory[33] = {rd, shift_amt[4:2]};
		memory[32] = {shift_amt[1:0], 6'h00};

		//div-
		memory[39] = {6'h09, (rs[4:3])};
		memory[38] = {rs[2:0], rt};
		memory[37] = {rd, shift_amt[4:2]};
		memory[36] = {shift_amt[1:0], 6'h00};

		//divu-
		memory[43] = {6'h0A, (rs[4:3])};
		memory[42] = {rs[2:0], rt};
		memory[41] = {rd, shift_amt[4:2]};
		memory[40] = {shift_amt[1:0], 6'h00};

		//sll-
		memory[47] = {6'h0B, (rs[4:3])};
		memory[46] = {rs[2:0], rt};
		memory[45] = {rd, shift_amt[4:2]};
		memory[44] = {shift_amt[1:0], 6'h00};

		//srl-
		memory[51] = {6'h0C, (rs[4:3])};
		memory[50] = {rs[2:0], rt};
		memory[49] = {rd, shift_amt[4:2]};
		memory[48] = {shift_amt[1:0], 6'h00};

		//sra-
		memory[55] = {6'h0D, (rs[4:3])};
		memory[54] = {rs[2:0], rt};
		memory[53] = {rd, shift_amt[4:2]};
		memory[52] = {shift_amt[1:0], 6'h00};

		//sllv-
		memory[59] = {6'h0E, (rs[4:3])};
		memory[58] = {rs[2:0], rt};
		memory[57] = {rd, shift_amt[4:2]};
		memory[56] = {shift_amt[1:0], 6'h00};

		//srlv-
		memory[63] = {6'h0F, (rs[4:3])};
		memory[62] = {rs[2:0], rt};
		memory[61] = {rd, shift_amt[4:2]};
		memory[60] = {shift_amt[1:0], 6'h00};

		//srav-
		memory[67] = {6'h10, (rs[4:3])};
		memory[66] = {rs[2:0], rt};
		memory[65] = {rd, shift_amt[4:2]};
		memory[64] = {shift_amt[1:0], 6'h00};

		//and-
		memory[71] = {6'h11, (rs[4:3])};
		memory[70] = {rs[2:0], rt};
		memory[69] = {rd, shift_amt[4:2]};
		memory[68] = {shift_amt[1:0], 6'h00};

		//or-
		memory[75] = {6'h12, (rs[4:3])};
		memory[74] = {rs[2:0], rt};
		memory[73] = {rd, shift_amt[4:2]};
		memory[72] = {shift_amt[1:0], 6'h00};

		//xor-
		memory[79] = {6'h13, (rs[4:3])};
		memory[78] = {rs[2:0], rt};
		memory[77] = {rd, shift_amt[4:2]};
		memory[76] = {shift_amt[1:0], 6'h00};

		//nor-
		memory[83] = {6'h14, (rs[4:3])};
		memory[82] = {rs[2:0], rt};
		memory[81] = {rd, shift_amt[4:2]};
		memory[80] = {shift_amt[1:0], 6'h00};

		//I type instructions
		//lui-
		memory[87] = {6'h15, (rs[4:3])};
		memory[86] = {rs[2:0], rt};
		memory[85] = Imm_operand[15:8];
		memory[84] = Imm_operand[7:0];
		//addi-
		memory[91] = {6'h16, rs[4:3]};
		memory[90] = {rs[2:0], rt};
		memory[89] = Imm_operand[15:8];
		memory[88] = Imm_operand[7:0];
		//addiu-
		memory[95] = {6'h17, rs[4:3]};
		memory[94] = {rs[2:0], rt};
		memory[93] = Imm_operand[15:8];
		memory[92] = Imm_operand[7:0];
		//slti-
		memory[99] = {6'h18, rs[4:3]};
		memory[98] = {rs[2:0], rt};
		memory[97] = Imm_operand[15:8];
		memory[96] = Imm_operand[7:0];
		//andi-
		memory[103] = {6'h19, rs[4:3]};
		memory[102] = {rs[2:0], rt};
		memory[101] = Imm_operand[15:8];
		memory[100] = Imm_operand[7:0];
		//ori-
		memory[107] = {6'h1A, rs[4:3]};
		memory[106] = {rs[2:0], rt};
		memory[105] = Imm_operand[15:8];
		memory[104] = Imm_operand[7:0];
		//xori-
		memory[111] = {6'h1B, rs[4:3]};
		memory[110] = {rs[2:0], rt};
		memory[109] = Imm_operand[15:8];
		memory[108] = Imm_operand[7:0];
		//lw-
		memory[115] = {6'h1C, rs[4:3]};
		memory[114] = {rs[2:0], rt};
		memory[113] = Imm_operand[15:8];
		memory[112] = Imm_operand[7:0];
		//lb-
		memory[119] = {6'h1D, rs[4:3]};
		memory[118] = {rs[2:0], rt};
		memory[117] = Imm_operand[15:8];
		memory[116] = Imm_operand[7:0];
		//lbu-
		memory[123] = {6'h1E, rs[4:3]};
		memory[122] = {rs[2:0], rt};
		memory[121] = Imm_operand[15:8];
		memory[120] = Imm_operand[7:0];
		//sw-
		memory[127] = {6'h1F, rs[4:3]};
		memory[126] = {rs[2:0], rt};
		memory[125] = Imm_operand[15:8];
		memory[124] = Imm_operand[7:0];
		//sb-
		memory[131] = {6'h20, rs[4:3]};
		memory[130] = {rs[2:0], rt};
		memory[129] = Imm_operand[15:8];
		memory[128] = Imm_operand[7:0];

		//J type instruction
		//j-
		memory[135] = {6'h21, jump_target[25:24]};
		memory[134] = jump_target[23:16];
		memory[133] = jump_target[15:8];
		memory[132] = jump_target[7:0];
		//jal-
		memory[139] = {6'h22, jump_target[25:24]};
		memory[138] = jump_target[23:16];
		memory[137] = jump_target[15:8];
		memory[136] = jump_target[7:0];
		//jr-
		memory[143] = {6'h23, jump_target[25:24]};
		memory[142] = jump_target[23:16];
		memory[141] = jump_target[15:8];
		memory[140] = jump_target[7:0];
		//bltz-
		memory[147] = {6'h24, jump_target[25:24]};
		memory[146] = jump_target[23:16];
		memory[145] = jump_target[15:8];
		memory[144] = jump_target[7:0];
		//beq-
		memory[151] = {6'h25, jump_target[25:24]};
		memory[150] = jump_target[23:16];
		memory[149] = jump_target[15:8];
		memory[148] = jump_target[7:0];
		//bne-
		memory[155] = {6'h26, jump_target[25:24]};
		memory[154] = jump_target[23:16];
		memory[153] = jump_target[15:8];
		memory[152] = jump_target[7:0];
		//syscall-
		memory[159] = {6'h27, jump_target[25:24]};
		memory[158] = jump_target[23:16];
		memory[157] = jump_target[15:8];
		memory[156] = jump_target[7:0];
		
		prev_pc = pc;
		instruction_code = {memory[(4*opcode)+3],memory[(4*opcode)+2],memory[(4*opcode)+1],memory[(4*opcode)]};
	end
end

endmodule