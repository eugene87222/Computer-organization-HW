//Subject:     CO project 2 - Sign extend
//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:      楊翔鈞(0516034) 陳柏翰(0516313)
//----------------------------------------------
//Date:        2018/4/25
//----------------------------------------------
//Description: 
//--------------------------------------------------------------------------------

module Sign_Extend(
    data_i,
    data_o
    );
               
//I/O ports
input   [16-1:0] data_i;
output  [32-1:0] data_o;

//Internal Signals
reg     [32-1:0] data_o;

//Sign extended
always @ ( data_i ) begin
    if(data_i[15] == 1'b1) begin
        data_o[31:16] <= 16'b1111111111111111;
      end
    else begin
        data_o[31:16] <= 16'b0000000000000000;    
      end
    data_o[15:0] <= data_i[15:0];
  end      
endmodule      
     