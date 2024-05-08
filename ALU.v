module ALU(alu_result,zero,inputA,inputB,signextend,pc,alu_control,alu_src_A,alu_src_B);
  output reg [31:0] alu_result;
  output reg zero;
  input wire [31:0] inputA,inputB;
  input wire [31:0] signextend;
  input wire [31:0]pc;
  input wire [3:0] alu_control;
  input wire alu_src_A;
  input wire [1:0]alu_src_B;
 reg [31:0] input1,input2;
	
 initial
    begin
        alu_result = 32'h0000_0000;
        zero = 1'b0;
    end
    
  always@(*)begin
	if(alu_src_A)
		input1=inputA;
	else
		input1=pc;
  end
  always@(*)begin
	case(alu_src_B)
		00:input2=inputB;
		01:input2=1;
		10:input2=signextend;
	endcase	
  end

  always @(alu_control,input1,input2)
      begin
          case (alu_control)
          4'b0010: alu_result = input1 + input2;//add
          4'b0110: alu_result = input1 - input2;//sub
          4'b0000: alu_result = input1 & input2;//AND
          4'b0001: alu_result = input1 | input2;//OR
          4'b1100: alu_result = ~(input1 | input2);//NOR
          4'b1001: alu_result = input2 << input1 ;//sll
       endcase
       
      end
       
  always@(alu_result)       
    begin
      if(alu_result == 32'h0000_0000)
            zero = 1'b1;
        else
            zero = 1'b0;
    end
endmodule

