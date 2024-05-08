module Alu_Control(input clk,input rst,
	input [5:0]func,
	input[1:0]alu_op,
	output reg[3:0] alu_control
    );
	always @(*) begin
    if (rst) begin
        alu_control = 4'b0000;
    end
    else begin
        case (alu_op)
            2'b10: case (func)
                6'b000000: alu_control = 4'b0010;
                6'b000001: alu_control = 4'b0110;
                6'b000010: alu_control = 4'b0000;
                default: alu_control = 4'b0010;
            endcase
            2'b11: alu_control = 4'b0010;
            default: alu_control = 4'b0010;
        endcase
    end
end

endmodule
