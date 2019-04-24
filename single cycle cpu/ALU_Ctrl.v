//Subject:     CO project 2 - ALU Controller
//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:      楊翔鈞(0516034) 陳柏翰(0516313)
//----------------------------------------------
//Date:        2018/4/25
//----------------------------------------------
//Description: 
//--------------------------------------------------------------------------------

module ALU_Ctrl(
          funct_i,
          ALUOp_i,
          ALUCtrl_o
          );
          
//I/O ports 
input      [6-1:0] funct_i;
input      [3-1:0] ALUOp_i;

output     [4-1:0] ALUCtrl_o;    
     
//Internal Signals
reg        [4-1:0] ALUCtrl_o;

//Parameter

       
//Select exact operation
always @ ( funct_i or ALUOp_i ) begin
    if(ALUOp_i[2:0] == 3'b010) begin
        // addu
        if(funct_i[5:0] == 6'b100001) begin
            ALUCtrl_o[3:0] <= 4'd2;
          end
        // subu
        else if(funct_i[5:0] == 6'b100011) begin
            ALUCtrl_o[3:0] <= 4'd6;
          end
        // and
        else if(funct_i[5:0] == 6'b100100) begin
            ALUCtrl_o[3:0] <= 4'd0;
          end
        // or
        else if(funct_i[5:0] == 6'b100101) begin
            ALUCtrl_o[3:0] <= 4'd1;
          end
        // slt
        else if(funct_i[5:0] == 6'b101010) begin
            ALUCtrl_o[3:0] <= 4'd7;
          end
        // sra
        else if(funct_i[5:0] == 6'b000011) begin
            ALUCtrl_o[3:0] <= 4'd5;
          end
        // srav
        else if(funct_i[5:0] == 6'b000111) begin
            ALUCtrl_o[3:0] <= 4'd9;
          end
        // mul
        else if(funct_i[5:0] == 6'b011000) begin
            ALUCtrl_o[3:0] <= 4'd10;
          end
        else begin
        
          end
      end
    // beq, bne, ble, bnez
    else if(ALUOp_i[2:0] == 3'b001) begin
        ALUCtrl_o[3:0] <= 4'd6;
      end
    // sltiu
    else if(ALUOp_i[2:0] == 3'b111) begin
        ALUCtrl_o[3:0] <= 4'd7;
      end
    // addi
    else if(ALUOp_i[2:0] == 3'b101) begin
        ALUCtrl_o[3:0] <= 4'd2;
      end
    // ori
    else if(ALUOp_i[2:0] == 3'b110) begin
        ALUCtrl_o[3:0] <= 4'd8;
      end
    // lui
    else if(ALUOp_i[2:0] == 3'b011) begin
        ALUCtrl_o[3:0] <= 4'd3;
      end
    // 
    else if(ALUOp_i[2:0] == 3'b100) begin
        
      end
    // lw, sw
    else if(ALUOp_i[2:0] == 3'b000) begin
        ALUCtrl_o[3:0] <= 4'd2;
      end
    else begin
        
      end
  end
endmodule     





                    
                    