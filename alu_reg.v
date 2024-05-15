module ALUreg(input[31:0]alu_result,
	input clk,input rst,
	output reg[31:0]alu_ou_result
    );
	always@(posedge clk or posedge rst)begin
		if(rst)
			alu_ou_result<=0;
		else
			alu_ou_result<=alu_result;
	end


endmodule
