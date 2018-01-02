 // Create Date:    18:08:46 02/16/2012 
// Design Name: 
// Module Name:    Control 
// Project Name: 
// Description: 
//
// Dependencies: 
//
// Revision: 	  2017.02.25
// Revision 0.01 - File Created
// Additional Comments: 
//
import definitions::*;
module Control(
    input        [4:0] OPCODE,
    input        [3:0] function_register,
    input        [7:0] accumulator,
    output logic [2:0] ALU_OP,
    output logic [1:0] ALU_SRC_B,
    output logic       REG_WRITE,
    output logic       MEM_WRITE,
    output logic       MEM_READ,
    output logic       REG_DST,
    output logic       MEM_TO_REG,
    output logic       AccumulatorRead,
    output logic       AccumulatorWrite,
    output logic [7:0]      ALUInputA,
    output logic [7:0]      ALUInputB,
    output logic       Use_ReadA2,
    output logic       HALT,
    output logic       Jump
    );

	always_comb	begin
		
	  case(OPCODE)
	  	5'b10000 :	begin
			  REG_DST    = 1;
			  Jump     = 0;
			  ALU_SRC_B  = 2; 	 // 2 is 0 don't care
			  ALU_OP     = kADD; 
			  MEM_TO_REG = 0;	 // use mem read
			  MEM_READ   = 1;
			  MEM_WRITE  = 0;
			  REG_WRITE  = 1;
			  HALT       = 1;
			  AccumulatorRead = 0;
			  AccumulatorWrite = 1;
			  Use_ReadA2 = 1;

		 end
	  	5'b10001 :	begin
			  REG_DST    = 1;
			  Jump     = 0;
			  ALU_SRC_B  = 2; 	 // 2 is 0 don't care
			  ALU_OP     = kADD; 
			  MEM_TO_REG = 0;	 // use mem read
			  MEM_READ   = 0;
			  MEM_WRITE  = 0;
			  REG_WRITE  = 1;
			  HALT       = 0;
			  AccumulatorRead = 0;
			  AccumulatorWrite = 1;
			  Use_ReadA2 = 1;

		 end
                5'b10010 :	begin
			  REG_DST    = 1;
			  Jump     = 0;
			  ALU_SRC_B  = 2; 	 // 2 is 0 don't care
			  ALU_OP     = kSUB; 
			  MEM_TO_REG = 0;	 // use mem read
			  MEM_READ   = 0;
			  MEM_WRITE  = 0;
			  REG_WRITE  = 1;
			  HALT       = 0;
			  AccumulatorRead = 0;
			  AccumulatorWrite = 1;
			  Use_ReadA2 = 1;

		 end
                5'b10011 :	begin
			  REG_DST    = 1;
			  Jump     = 0;
			  ALU_SRC_B  = 2; 	 // 2 is 0 don't care
			  ALU_OP     = kADD; 
			  MEM_TO_REG = 0;	 // use mem read
			  MEM_READ   = 0;
			  MEM_WRITE  = 0;
			  REG_WRITE  = 1;
			  HALT       = 0;
			  AccumulatorRead = 1;
			  AccumulatorWrite = 0;
			  Use_ReadA2 = 0;

		 end
                 5'b10100 :	begin
			  REG_DST    = 1;
			  Jump     = 0;
			  ALU_SRC_B  = 2; 	 // 2 is 0 don't care
			  ALU_OP     = kADD; 
			  MEM_TO_REG = 1;	 // use mem read
			  MEM_READ   = 1;
			  MEM_WRITE  = 0;
			  REG_WRITE  = 1;
			  HALT       = 0;
			  AccumulatorRead = 1;
			  AccumulatorWrite = 0;
                          ALUInputA  = accumulator;
                          ALUInputB  = 8'b0;
			  Use_ReadA2 = 1;

		 end
		 5'b10101 :	begin
			  REG_DST    = 1;
			  Jump     = 1;
			  ALU_SRC_B  = 2; 	 // 2 is 0 don't care
			  ALU_OP     = kADD; 
			  MEM_TO_REG = 0;	 // use mem read
			  MEM_READ   = 0;
			  MEM_WRITE  = 0;
			  REG_WRITE  = 0;
			  HALT       = 0;
			  AccumulatorRead = 0;
			  AccumulatorWrite = 0;
			  Use_ReadA2 = 1;

		 end
                 5'b10110 :	begin
			  REG_DST    = 1;
			  Jump     = 0;
			  ALU_SRC_B  = 2; 	 // 2 is 0 don't care
			  ALU_OP     = kSUB; 
			  MEM_TO_REG = 0;	 // use mem read
			  MEM_READ   = 0;
			  MEM_WRITE  = 0;
			  REG_WRITE  = 0;
			  HALT       = 0;
			  AccumulatorRead = 1;
			  AccumulatorWrite = 0;
			  Use_ReadA2 = 1;

		 end
                 5'b10111 :	begin
			  REG_DST    = 1;
			  Jump = 0;
			  ALU_SRC_B  = 2; 	 // 2 is 0 don't care
			  ALU_OP     = kADD; 
			  MEM_TO_REG = 0;	 // use mem read
			  MEM_READ   = 0;
			  MEM_WRITE  = 0;
			  REG_WRITE  = 0;
			  HALT       = 0;
			  AccumulatorRead = 0;
			  AccumulatorWrite = 0;
			  Use_ReadA2 = 1;

		 end
                 5'b11000 :	begin
			  REG_DST    = 1;
			  Jump     = 0;
			  ALU_SRC_B  = 2; 	 // 2 is 0 don't care
			  ALU_OP     = kSL; 
			  MEM_TO_REG = 0;	 // use mem read
			  MEM_READ   = 0;
			  MEM_WRITE  = 0;
			  REG_WRITE  = 1;
			  HALT       = 0;
			  AccumulatorRead = 0;
			  AccumulatorWrite = 1;
			  Use_ReadA2 = 1;

		 end
                 5'b11001 :	begin
			  REG_DST    = 1;
			  Jump     = 0;
			  ALU_SRC_B  = 2; 	 // 2 is 0 don't care
			  ALU_OP     = kSR; 
			  MEM_TO_REG = 0;	 // use mem read
			  MEM_READ   = 0;
			  MEM_WRITE  = 0;
			  REG_WRITE  = 1;
			  HALT       = 0;
			  AccumulatorRead = 0;
			  AccumulatorWrite = 1;
			  Use_ReadA2 = 1;

		 end
                 5'b11010 :	begin
			  REG_DST    = 1;
			  Jump     = 0;
			  ALU_SRC_B  = 2; 	 // 2 is 0 don't care
			  ALU_OP     = kNOT; 
			  MEM_TO_REG = 0;	 // use mem read
			  MEM_READ   = 0;
			  MEM_WRITE  = 0;
			  REG_WRITE  = 1;
			  HALT       = 0;
			  AccumulatorRead = 0;
			  AccumulatorWrite = 0;
			  Use_ReadA2 = 1;

		 end
                 5'b11011 :	begin
			  REG_DST    = 1;
			  Jump     = 0;
			  ALU_SRC_B  = 2; 	 // 2 is 0 don't care
			  ALU_OP     = kOR; 
			  MEM_TO_REG = 0;	 // use mem read
			  MEM_READ   = 0;
			  MEM_WRITE  = 0;
			  REG_WRITE  = 1;
			  HALT       = 0;
			  AccumulatorRead = 1;
			  AccumulatorWrite = 1;
			  Use_ReadA2 = 1;

		 end
                 5'b11100 :	begin
			  REG_DST    = 1;
			  Jump     = 0;
			  ALU_SRC_B  = 2; 	 // 2 is 0 don't care
			  ALU_OP     = kAND; 
			  MEM_TO_REG = 0;	 // use mem read
			  MEM_READ   = 0;
			  MEM_WRITE  = 0;
			  REG_WRITE  = 1;
			  HALT       = 0;
			  AccumulatorRead = 1;
			  AccumulatorWrite = 1;
			  Use_ReadA2 = 1;

		 end
                 5'b11101 :	begin
			  REG_DST    = 1;
			  Jump     = 0;
			  ALU_SRC_B  = 2; 	 // 2 is 0 don't care
			  ALU_OP     = kSUB; 
			  MEM_TO_REG = 0;	 // use mem read
			  MEM_READ   = 0;
			  MEM_WRITE  = 0;
			  REG_WRITE  = 1;
			  HALT       = 0;
			  AccumulatorRead = 1;
			  AccumulatorWrite = 0;
			  Use_ReadA2 = 1;

		 end
                 5'b11110 :	begin
			  REG_DST    = 0;
			  Jump     = 0;
			  ALU_SRC_B  = 2; 	 // 2 is 0 don't care
			  ALU_OP     = kADD; 
			  MEM_TO_REG = 0;	 // use mem read
			  MEM_READ   = 0;
			  MEM_WRITE  = 1;
			  REG_WRITE  = 0;
			  HALT       = 0;
			  AccumulatorRead = 1;
			  AccumulatorWrite = 0;
			  Use_ReadA2 = 1;

		 end
                 5'b11111 :	begin
			  REG_DST    = 1;
			  Jump     = 0;
			  ALU_SRC_B  = 2; 	 // 2 is 0 don't care
			  ALU_OP     = kASR; 
			  MEM_TO_REG = 0;	 // use mem read
			  MEM_READ   = 0;
			  MEM_WRITE  = 0;
			  REG_WRITE  = 1;
			  HALT       = 0;
			  AccumulatorRead = 1;
			  AccumulatorWrite = 1;
			  Use_ReadA2 = 1;

		 end
		  default: begin
			  REG_DST    = 0;
			  Jump     = 0;
			  ALU_SRC_B  = 2; 	 // 2 is 0 don't care
			  ALU_OP     = kADD; 
			  MEM_TO_REG = 0;	 // use mem read
			  MEM_READ   = 0;
			  MEM_WRITE  = 0;
			  REG_WRITE  = 1;
			  HALT       = 0;
			  AccumulatorRead = 0;
			  AccumulatorWrite = 1;
			  Use_ReadA2 = 1;
			end
		endcase
	end

endmodule
