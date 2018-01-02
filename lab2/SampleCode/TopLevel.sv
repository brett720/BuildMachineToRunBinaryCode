// 
// Create Date:    18:37:58 02/16/2012 
// Design Name: 
// Module Name:    TopLevel 
// Project Name: 
// Description: 
//
// Dependencies: 
//
// Revision: 	   2017.02.25
// Revision 0.01 - File Created
// Additional Comments: 
module TopLevel(
  input     start,
  input     CLK,
  output    halt    );

	// control signals not defined as outputs
  wire MEM_READ,REG_DST,MEM_TO_REG,HALT;
  wire[8:0] Instruction;
  wire[7:0] PC,
            regWriteValue; 
  wire      REG_WRITE,
            MEM_WRITE;
  logic[15:0] InstCounter;
  wire [ 1:0] ALU_OP;
  wire [ 1:0] ALU_SRC_B;
 // ALU outputs
  wire ZERO, EQUAL;
  wire [ 7:0] ALUOut;
	 
  // Data mem wires
  wire [ 7:0] MemOut;
	 
	 // IF module inputs
  wire [ 7:0] Target;
	 
	 // Register File
	 
	 wire [ 7:0] ReadA;
	 wire [ 7:0] ReadB;
	 wire        carry_reg_D;
	 logic       carry_reg_Q;	 

	 // ALU wires
	 wire [ 7:0] SE_Immediate;
	 wire [ 7:0] IntermediateMux;
	 wire [ 7:0] ALUInputB;
	 wire [ 3:0] write_register;

	 // manage the write register and write data muxes
	 assign write_register = (REG_DST==1)?{1'b0,Instruction[2:0]}:{1'b0,Instruction[5:3]};
	 //assign regWriteValue = (MEM_TO_REG==1)?ALUOut:MemOut;
	 assign regWriteValue = ALUOut;
	 
	 // manage ALU SRC MUX
	 assign SE_Immediate = {{13{Instruction[2]}}, Instruction[2:0]};
	 assign IntermediateMux = (ALU_SRC_B==2'b01)?SE_Immediate:ReadB;
	 assign ALUInputB = (ALU_SRC_B==2'b10)?0  : IntermediateMux;
	 
	 // assign input to memory
	 assign memWriteValue = ReadB;
	 
	 // Fetch Module (really just PC, we could have incorporated InstRom here as well)
	 IF if_module (
		.Branch  (BRANCH & ZERO), 
		.Target  ({5'b00000,Instruction[2:0]}), 
		.Init    (start), 
		.Halt    (halt), 
		.CLK          , 
		.PC
	);

	// instruction ROM
	InstROM inst_module(
	.InstAddress   (PC), 
	.InstOut       (Instruction)
	);

	// Control module
	Control control_module (
		.OPCODE(Instruction[8:5]), 
		.ALU_OP               , 
		.ALU_SRC_B            , 
		.REG_WRITE            , 
		.BRANCH               , 
		.MEM_WRITE            , 
		.MEM_READ             , 
		.REG_DST              , 
		.MEM_TO_REG           , 
		.HALT(halt)
	);


	reg_file #(.W(8),.D(4)) register_module (
		.CLK                  , 
		.RegWrite  (REG_WRITE), 
		.srcA      ({1'b0,Instruction[5:3]}), //concatenate with 0 to give us 4 bits
		.srcB      ({1'b0,Instruction[2:0]}), 
		.writeReg  (write_register), 	  // mux above
		.writeValue(regWriteValue) , 
		.ReadA                     , 
		.ReadB
	);
	
	 ALU ALU_Module (
		.CI    (carry_reg_Q) ,
		.OP    (ALU_OP) , 
		.INPUTA(ReadA)  , 
		.INPUTB(ALUInputB), 
		.OUT   (ALUOut)  , 
		.CO    (carry_reg_D), 
		.ZERO            , 
		.EQUAL (EQ)
	);

	DataRAM Data_Module(
		.DataAddress  (ReadA), 
		.ReadMem      (MEM_READ), 
		.WriteMem     (MEM_WRITE), 
		.DataIn       (memWriteValue), 
		.DataOut      (MemOut), 
		.CLK 
	);
	
	// might help debug
	/*
	always@(SE_Immediate)
	begin
	$display("SE Immediate = %d",SE_Immediate);
	end
	*/
	always@(posedge CLK)
	if (start == 1)	begin
	  InstCounter <= 1'b0;
	  carry_reg_Q <= 1'b0;
	end
	else if(halt == 0) begin
	  InstCounter <= InstCounter+1;
      carry_reg_Q <= carry_reg_D; 
	end
endmodule
