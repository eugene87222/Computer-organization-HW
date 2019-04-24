`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/20/2018 09:18:50 PM
// Design Name: 
// Module Name: question_mark
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:楊翔鈞(0516034) 陳柏翰(0516313)
// 
//////////////////////////////////////////////////////////////////////////////////


module question_mark(
    data0_i,
    data1_i,
    select_i,
    data_o
);
           

//I/O ports               
input   data0_i;          
input   data1_i;
input [2:0] select_i;
output  data_o; 

//Internal Signals
reg     data_o;

//Main function
always @ (data0_i or data1_i or select_i) begin
    // beq
    if(select_i == 3'b000) begin
        data_o <= data0_i;
      end
    // ble
    else if(select_i == 3'b001) begin
        if(data0_i || data1_i) begin
            data_o <= 1'b1;
          end
      end
    // bnez
    else if(select_i == 3'b010) begin
        data_o <= ~data0_i;
      end
    // bnez
    else if(select_i == 3'b011) begin
        data_o <= data1_i;
      end
  end
endmodule     