module RFU(
	input clk,
	input reset,
	input [4:0]src_reg_1,//same as dest_reg
	input [4:0]src_reg_2,//same as dest reg
	input [4:0]dest_reg,//this must be provided by testbench to IFU->IMU(instruction_code)->RFU
	
	input load_inst,
	input store_inst,
	
	input [31:0]gen_purpose_reg_data_write,//this shoule be provided by ALU in top module
	input [31:0]dest_reg_data,//provided by ALU after calculations
	input [15:0]Imm_operand,//I type instruction (this is used here as address to direct memory address)
	
	output reg[31:0]gen_purpose_reg_data_read,//this should be provided to ALU in top module	
	output reg[31:0]rs,
	output reg[31:0]rt,
	output reg[31:0]rd
); 

reg [31:0] gen_purpose_reg [31:0];
integer i;

always@(posedge clk)
begin
	if(reset)
	begin
		for(i=0;i<32;i=i+1)
			gen_purpose_reg[i] <= i;
	end
	else
	begin
	
	rs = gen_purpose_reg[src_reg_1];
	rt = gen_purpose_reg[src_reg_2];
	
	if(!load_inst && !store_inst)
	begin
		gen_purpose_reg[dest_reg] = dest_reg_data; 
		rd = gen_purpose_reg[dest_reg];
	end
	
	if(store_inst)
		gen_purpose_reg[dest_reg] = gen_purpose_reg_data_write;
	else if(load_inst)
		gen_purpose_reg_data_read = gen_purpose_reg[dest_reg];
	end
end
endmodule