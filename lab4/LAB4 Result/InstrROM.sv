// Company: 
// Engineer: 
// 
// Create Date:    15:50:22 11/02/2007 
// Design Name: 
// Module Name:    InstROM 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: This is a basic verilog module to behave as an instruction ROM
// 				 template.
//
// Dependencies: 
//
// Revision: 		2017.02.25
// Revision 0.01 - File Created
// Additional Comments: 
//
module InstrROM(
	input	[7:0] instr_address, 
	output logic [8:0] instruction_out
	);
	 
	// Instructions have [4bit opcode][3bit rs or rt][2bit rt, immediate, or branch target]
	logic [8:0] instructions[256];
	 
	always_comb begin 
		instruction_out = instructions[instr_address];
	end
	
	/*
		case (InstAddress)
			// opcode = 0 lhw, rs = 0, rt = 1
			0       : InstOut = 'b0000_000_01;  // load from address at reg 0 to reg 1  
	  
			// opcode = 1 addi, rs/rt = 1, immediate = 1
			1       : InstOut = 'b0010_010_01;  // addi reg 1 and 1
			// replace instruction 1 with the following to produce an infinite loop (shows branch working)
			//1 : InstOut = 'b001001000;  // addi reg 1 and 0

			// opcode = 2 shw, rs = 0, rt = 1
			2       : InstOut = 'b0010_000_01;  // sw reg 1 to address in reg 0

			// opcode = 3 beqz, rs = 1, target = 1
			3       : InstOut = 'b0110_010_01;  // beqz reg1 to absolute address 1

			// opcode = 15 halt
			4       : InstOut = 'b1111_111_11;  // halt
			default : InstOut = 'b0000_000_00;
		endcase
	*/


endmodule
