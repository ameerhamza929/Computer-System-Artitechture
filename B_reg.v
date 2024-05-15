
module registerB(input clk,input rst, input [31:0]rt_data,
	output reg[31:0]B_out
    );
	always@(posedge clk or posedge rst)begin
		if(rst)
			B_out<=0;
		else
			B_out<=rt_data;
	end

    


endmodule
