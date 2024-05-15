module registerA(input clk,input rst, input [31:0]rs_data,
	output reg[31:0]A_out
    );
	always@(posedge clk or posedge rst)begin
		if(rst)
			A_out<=0;
		else
			A_out<=rs_data;
	end

endmodule
