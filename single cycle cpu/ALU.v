//Subject:     CO project 2 - ALU
//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:      (0516034) (0516313)
//----------------------------------------------
//Date:        2018/4/25
//----------------------------------------------
//Description: 
//--------------------------------------------------------------------------------

module ALU(
    src1_i,
	src2_i,
	shamt_i,
	ctrl_i,
	result_o,
	zero_o
	);
     
//I/O ports
input  [32-1:0]  src1_i;
input  [32-1:0]	 src2_i;
input  [4-1:0]   ctrl_i;
input  [31:0] shamt_i;

output [32-1:0]	 result_o;
output           zero_o;

//Internal signals
reg    [32-1:0]  result_o;
wire             zero_o;

//Parameter

//Main function
assign zero_o = (result_o == 0) ;

always @(ctrl_i or src1_i or src2_i) begin
    case(ctrl_i)
        // and
        0: begin
					result_o <= src1_i & src2_i;
             end
        // or
        1: begin
					result_o <= src1_i | src2_i;
             end
        // addi, addu, lw, sw
        2: begin
					result_o <= src1_i + src2_i;
             end
        // lui
        3: begin
               result_o[31:16] <= src2_i[15:0];
               result_o[15:0] <= 0;
             end
        // 
        4: begin
               
             end
        // sra
        5: begin
               result_o <= $signed(src2_i) >>> shamt_i;
             end
        // beq, subu, bne
        6: begin
               result_o <= src1_i - src2_i;
            end
        // sltiu, slt
        7: begin
               result_o <= src1_i < src2_i ? 1 : 0;
             end
        // ori
        8: begin
               result_o[15:0] <= src1_i[15:0] | src2_i[15:0];
               result_o[31:16] <= src1_i[31:16];
             end
        // srav
        9: begin
               result_o <= $signed(src2_i) >>> src1_i;
             end
        // mul
        10: begin
               result_o <= src1_i * src2_i;
             end
        // nor
        12: begin
               result_o <= ~(src1_i | src2_i);
             end
        default: result_o <= 0;
      endcase
  end
    
endmodule





                    
                    