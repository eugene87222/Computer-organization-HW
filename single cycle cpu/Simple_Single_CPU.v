//Subject:     CO project 2 - Simple Single CPU
//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:      楊翔鈞(0516034) 陳柏翰(0516313)
//----------------------------------------------
//Date:        2018/4/25
//----------------------------------------------
//Description: 
//--------------------------------------------------------------------------------
module Simple_Single_CPU(
        clk_i,
		rst_i
		);
		
//I/O port
input         clk_i;
input         rst_i;

//Internal Signles

//Greate componentes
ProgramCounter PC(
        .clk_i(clk_i),      
	    .rst_i (rst_i),     
	    .pc_in_i(Mux_dirshift.data_o) ,   
	    .pc_out_o() 
	    );
	
Adder Adder1(
        .src1_i(32'd4),     
	    .src2_i(PC.pc_out_o),     
	    .sum_o()    
	    );
	
Instr_Memory IM(
        .addr_i(PC.pc_out_o),  
	    .instr_o()    
	    );

MUX_3to1 #(.size(5)) Mux_Write_Reg(
        .data0_i(IM.instr_o[20:16]),
        .data1_i(IM.instr_o[15:11]),
        .data2_i(5'b11111),
        .select_i(Decoder.RegDst_o),
        .data_o()
        );	
		
Reg_File RF(
        .clk_i(clk_i),      
	    .rst_i(rst_i) ,     
        .RSaddr_i(IM.instr_o[25:21]) ,  
        .RTaddr_i(IM.instr_o[20:16]) ,  
        .RDaddr_i(Mux_Write_Reg.data_o) ,  
        .RDdata_i(Mux_4to1.data_o)  , 
        .RegWrite_i (Decoder.RegWrite_o),
        .RSdata_o() ,  
        .RTdata_o()   
        );
	
Decoder Decoder(
        .instr_op_i(IM.instr_o[31:26]), 
        .funct_op_i(IM.instr_o[5:0]),
        .Branch_o(),
        .MemToReg_o(),
        .BranchType_o(),
        .Jump_o(),
        .MemRead_o(),
        .MemWrite_o(),
        .ALU_op_o(),
        .ALUSrc_o(),
        .RegWrite_o(),
        .RegDst_o()  
	    );

ALU_Ctrl AC(
        .funct_i(IM.instr_o[5:0]),   
        .ALUOp_i(Decoder.ALU_op_o),   
        .ALUCtrl_o() 
        );
	
Sign_Extend SE(
        .data_i(IM.instr_o[15:0]),
        .data_o()
        );

MUX_2to1 #(.size(32)) Mux_ALUSrc(
        .data0_i(RF.RTdata_o),
        .data1_i(SE.data_o),
        .select_i(Decoder.ALUSrc_o),
        .data_o()
        );	
		
ALU ALU(
        .src1_i(RF.RSdata_o),
	    .src2_i(Mux_ALUSrc.data_o),
	    .shamt_i(shamt.data_o),
	    .ctrl_i(AC.ALUCtrl_o),
	    .result_o(),
		.zero_o()
	    );
		
Adder Adder2(
        .src1_i(Adder1.sum_o),     
	    .src2_i(Shifter.data_o),     
	    .sum_o()      
	    );
		
Shift_Left_Two_32 Shifter(
        .data_i(SE.data_o),
        .data_o()
        ); 		
		
MUX_2to1 #(.size(32)) Mux_PC_Source(
        .data0_i(Adder1.sum_o),
        .data1_i(Adder2.sum_o),
        .select_i(Decoder.Branch_o & question_mark.data_o),
        .data_o()
        );	

shamt shamt(
        .data_i(IM.instr_o[10:6]),
        .data_o()
        );
        
dir_shift_left_2 dir_shifter(
                .data_i(IM.instr_o[25:0]),
                .pc_in(Adder1.sum_o[31:28]),
                .data_o()
                );

MUX_3to1 #(.size(32)) Mux_dirshift(
        .data0_i(Mux_PC_Source.data_o),
        .data1_i(dir_shifter.data_o),
        .data2_i(RF.RSdata_o),
        .select_i(Decoder.Jump_o),
        .data_o()
        );	

MUX_4to1 #(.size(32)) Mux_4to1(
        .data0_i(ALU.result_o),
        .data1_i(Data_Memory.data_o),
        .data2_i(SE.data_o),
        .data3_i(Adder1.sum_o),
        .select_i(Decoder.MemToReg_o),
        .data_o()
        );	

Data_Memory Data_Memory(
	.clk_i(clk_i),
	.addr_i(ALU.result_o),
	.data_i(RF.RTdata_o),
	.MemRead_i(Decoder.MemRead_o),
	.MemWrite_i(Decoder.MemWrite_o),
	.data_o()
);

question_mark question_mark(
    .data0_i(ALU.zero_o),
    .data1_i(ALU.result_o[31]),
    .select_i(Decoder.BranchType_o),
    .data_o()
);
       

endmodule
		  


