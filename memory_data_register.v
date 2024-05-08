module memory_data_register(input [31:0]data_in,
	input clk,input rst,
	output reg [31:0]mdr_result
    );
	always@(data_in or posedge rst)begin
		if(rst)begin
			mdr_result=0;
		end
		else
			mdr_result=data_in;
	end

endmodule
