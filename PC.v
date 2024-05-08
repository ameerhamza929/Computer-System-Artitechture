module PC(input clk,input rst, 
	input [31:0]jump_address,
	input[31:0] alu_ou_result,
	input [31:0]alu_result,
	input [1:0]pc_source,
	input zero,
	input pcwrite ,
	//input pcwrite_cond,
	output reg [31:0] pc_out
    );
	 
	 wire pc_in;
	// assign pc_in=pcwrite||(zero&&pcwrite_cond);
	always@(posedge clk or posedge rst)begin
		if(rst)begin
			pc_out<=0;
		end
		else begin
			if(pcwrite)begin
				case(pc_source)
					00:pc_out<=pc_out+1;
					01:pc_out<=alu_ou_result;
					10:pc_out<=jump_address;
					default:pc_out<=alu_result;
				endcase
			end
		end
	end

endmodule
