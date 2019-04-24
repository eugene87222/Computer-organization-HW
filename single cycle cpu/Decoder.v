//Subject:     CO project 2 - Decoder
//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:      楊翔鈞(0516034) 陳柏翰(0516313)
//----------------------------------------------
//Date:        2018/4/25
//----------------------------------------------
//Description: 
//--------------------------------------------------------------------------------

module Decoder(
    instr_op_i,
    funct_op_i,
    Branch_o,
    MemToReg_o,
    BranchType_o,
    Jump_o,
    MemRead_o,
    MemWrite_o,
	ALU_op_o,
	ALUSrc_o,
    RegWrite_o,
	RegDst_o
	);
     
//I/O ports
input  [6-1:0] instr_op_i;
input  [  5:0] funct_op_i;
output         RegWrite_o;
output [  1:0] MemToReg_o;
output [  2:0]  BranchType_o;
output         MemWrite_o;
output         MemRead_o;
output [  1:0] Jump_o;
output [3-1:0] ALU_op_o;
output         ALUSrc_o;
output [  1:0] RegDst_o;
output         Branch_o;
 
//Internal Signals
reg    [3-1:0] ALU_op_o;
reg            ALUSrc_o;
reg            RegWrite_o;
reg    [  1:0] RegDst_o;
reg            Branch_o;
reg    [  1:0] MemToReg_o;
reg    [  2:0]  BranchType_o;
reg            MemWrite_o;
reg            MemRead_o;
reg    [  1:0] Jump_o;

//Parameter


//Main function
always @ ( * ) begin
    if( instr_op_i[5:0] == 6'b000000) begin
        //nop
        if( funct_op_i[5:0] == 6'b000000 ) begin
            RegDst_o = 2'b00;
            ALUSrc_o = 1'b0;
            MemToReg_o = 2'b00;
            RegWrite_o = 1'b0;
            MemRead_o = 1'b0;
            MemWrite_o = 1'b0;
            Branch_o = 1'b0;
            ALU_op_o = 3'b000;
            Jump_o = 2'b00;
            BranchType_o = 3'b000;
          end        
        //jr  
        else if ( funct_op_i[5:0] == 6'b001000 ) begin
            RegDst_o = 2'b00;
            ALUSrc_o = 1'b0;
            MemToReg_o = 2'b00;
            RegWrite_o = 1'b0;
            MemRead_o = 1'b0;
            MemWrite_o = 1'b0;
            Branch_o = 1'b0;
            ALU_op_o = 3'b000;
            Jump_o = 2'b10;
            BranchType_o = 3'b000; 
          end
        // R-type
        else begin
            RegDst_o = 2'b01;
            ALUSrc_o = 1'b0;
            MemToReg_o = 2'b00;
            RegWrite_o = 1'b1;
            MemRead_o = 1'b0;
            MemWrite_o = 1'b0;
            Branch_o = 1'b0;
            ALU_op_o = 3'b010;
            Jump_o = 2'b00;
          end
      end
    // beq
    else if(instr_op_i[5:0] == 6'b000100) begin
        ALU_op_o[2:0] = 3'b001;
        ALUSrc_o = 1'b0;
        RegWrite_o = 1'b0;
        Branch_o = 1'b1; 
        BranchType_o = 3'b000;
      end
    // addi
    else if( instr_op_i[5:0] == 6'b001000) begin
        ALU_op_o[2:0] = 3'b101 ;
        RegDst_o = 2'b00;
        ALUSrc_o = 1'b1;
        RegWrite_o = 1'b1;
        Branch_o = 1'b0;
        MemToReg_o = 2'b00;
        MemRead_o = 1'b0;
        MemWrite_o = 1'b0;
        Jump_o = 2'b00;
      end
    // sltiu
    else if( instr_op_i[5:0] == 6'b001011) begin
        ALU_op_o[2:0] = 3'b111;
        RegDst_o = 2'b00;
        ALUSrc_o = 1'b1;
        RegWrite_o = 1'b1;
        Branch_o = 1'b0;
      end
    // ori
    else if( instr_op_i[5:0] == 6'b001101) begin
        ALU_op_o[2:0] = 3'b110;
        RegDst_o = 2'b00;
        ALUSrc_o = 1'b1;
        RegWrite_o = 1'b1;
        Branch_o = 1'b0;
      end
    // lui
//    else if( instr_op_i[5:0] == 6'b001111) begin
//        ALU_op_o[2:0] = 3'b011;
//        RegDst_o = 2'b00;
//        ALUSrc_o = 1'b1;
//        RegWrite_o = 1'b1;
//        Branch_o = 1'b0;
//      end
    // bne
    else if(instr_op_i[5:0] == 6'b000101) begin
        RegDst_o = 2'b00;
        ALUSrc_o = 1'b1;
        MemToReg_o = 2'b00;
        RegWrite_o = 1'b0;
        MemRead_o = 1'b0;
        MemWrite_o = 1'b0;
        Branch_o = 1'b1;
        ALU_op_o = 3'b001;
        Jump_o = 2'b00;
        BranchType_o = 3'b010;
      end
    // lw
    else if(instr_op_i[5:0] == 6'b100011) begin
        RegDst_o = 2'b00;
        ALUSrc_o = 1'b1;
        MemToReg_o = 2'b01;
        RegWrite_o = 1'b1;
        MemRead_o = 1'b1;
        MemWrite_o = 1'b0;
        Branch_o = 1'b0; 
        ALU_op_o = 3'b000;
        Jump_o = 2'b00;
      end
    // sw
    else if(instr_op_i[5:0] == 6'b101011) begin
        ALUSrc_o = 1'b1;
        RegWrite_o = 1'b0;
        MemRead_o = 1'b0;
        MemWrite_o = 1'b1;
        Branch_o = 1'b0; 
        ALU_op_o[2:0] = 3'b000;
        Jump_o = 2'b00;
      end
    // j
    else if(instr_op_i[5:0] == 6'b000010) begin
        RegDst_o = 2'b00;
        ALUSrc_o = 1'b0;
        MemToReg_o = 2'b00;
        RegWrite_o = 1'b0;
        MemRead_o = 1'b0;
        MemWrite_o = 1'b0;
        Branch_o = 1'b0;
        ALU_op_o = 3'b000;
        Jump_o = 2'b01;
      end
    // jal
    else if(instr_op_i[5:0] == 6'b000011) begin
        RegDst_o = 2'b10;
        ALUSrc_o = 1'b0;
        MemToReg_o = 2'b11;
        RegWrite_o = 1'b1;
        MemRead_o = 1'b0;
        MemWrite_o = 1'b0;
        Branch_o = 1'b0;
        ALU_op_o = 3'b000;
        Jump_o = 2'b01;
      end
    // ble
    else if(instr_op_i[5:0] == 6'b000110) begin
        RegDst_o = 2'b00;
        ALUSrc_o = 1'b1;
        MemToReg_o = 2'b00;
        RegWrite_o = 1'b0;
        MemRead_o = 1'b0;
        MemWrite_o = 1'b0;
        Branch_o = 1'b1;
        ALU_op_o = 3'b001;
        Jump_o = 2'b00;
        BranchType_o = 3'b001;
      end
    // bnez
    else if(instr_op_i[5:0] == 6'b000101) begin
        RegDst_o = 2'b00;
        ALUSrc_o = 1'b1;
        MemToReg_o = 2'b00;
        RegWrite_o = 1'b0;
        MemRead_o = 1'b0;
        MemWrite_o = 1'b0;
        Branch_o = 1'b1;
        ALU_op_o = 3'b001;
        Jump_o = 2'b00;
        BranchType_o = 3'b010;
      end
    // bltz
    else if(instr_op_i[5:0] == 6'b000001) begin
        RegDst_o = 2'b00;
        ALUSrc_o = 1'b1;
        MemToReg_o = 2'b00;
        RegWrite_o = 1'b0;
        MemRead_o = 1'b0;
        MemWrite_o = 1'b0;
        Branch_o = 1'b1;
        ALU_op_o = 3'b001;
        Jump_o = 2'b00;
        BranchType_o = 3'b011;
      end
    // li
    else if(instr_op_i[5:0] == 6'b001111) begin
        ALU_op_o[2:0] = 3'b101 ;
        RegDst_o = 2'b00;
        ALUSrc_o = 1'b1;
        RegWrite_o = 1'b1;
        Branch_o = 1'b0;
        MemToReg_o = 2'b00;
        MemRead_o = 1'b0;
        MemWrite_o = 1'b0;
        Jump_o = 2'b00;
        BranchType_o = 3'b000;
      end
  end

endmodule





                    
                    