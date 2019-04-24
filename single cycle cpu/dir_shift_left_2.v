`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/20/2018 08:29:32 PM
// Design Name: 
// Module Name: dir_shift_left_2
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module dir_shift_left_2(
    data_i,
    pc_in,
    data_o
);

//I/O ports                    
input [25:0] data_i;
input [3:0] pc_in;
output [31:0] data_o;

//shift left 2
assign data_o[31:28] = pc_in[3:0]; 
assign data_o[27:2] = data_i[25:0];
assign data_o[1:0] = 2'b00;
endmodule