module Instruction_reg(input [31:0]instruction,
input IRwrite,
input clk,
input rst,
output reg[5:0]opcode,
output reg[5:0]func,
output reg[31:0]jump_address,
output reg[4:0]rs,
output reg[4:0]rt,
output reg[4:0]rd,
output reg[31:0]signextend
    );
always@(instruction or posedge rst)begin
	if(rst)begin
		opcode=0;
		rs=0;
		rt=0;
		rd=0;
	end	
	else begin
		if(IRwrite)begin
			opcode=instruction[31:26];
			rs=instruction[25:21];
			rt=instruction[20:16];
			rd=instruction[15:11];
			func=instruction[5:0];
			jump_address=instruction[15:0];
			signextend= {{16{instruction[15]}}, instruction[15:0]};
		end	
	end 
end

endmodule
