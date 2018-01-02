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
  wire MEM_READ,REG_DST,MEM_TO_REG,AccumulatorWrite,AccumulatorRead,Jump;
  

 
  wire[8:0] Instruction;
  wire[7:0] PC;
  logic[7:0] regWriteValue; 
  wire      REG_WRITE,
            MEM_WRITE;
  logic[15:0] InstCounter; //todo
  wire [ 2:0] ALU_OP; //todo
  wire [ 1:0] ALU_SRC_B;

/** for ROCK CPU **/
  wire [7:0] accumulator; 
  wire [7:0] reg1; //Rock CUP
  //wire jumpcase;
  //assign jumpcase = (Instruction[8:4] == 5'b10101)? 1'b1 : 1'b0;


 // ALU outputs
  wire ZERO, EQUAL; //no ZERO
  wire [ 7:0] ALUOut;
	 
  // Data mem wires
  wire [ 7:0] MemOut;
	 
	 // IF module inputs
  wire [ 7:0] Target;
  logic [ 7:0] r15; 
	 // Register File
	 logic Lessthan;
	 logic Check_EQ;
         logic Check_Lessthan;
         logic Branch;
	 wire [ 7:0] ReadA;
	 //wire [ 7:0] ReadB;
	 wire        carry_reg_D;
	 logic       carry_reg_Q;	 
         wire [7:0] ReadA2;
         wire [7:0] Imme;
         logic Use_ReadA2;
	 // ALU wires
	 wire [ 7:0] SE_Immediate;
	 wire [ 7:0] IntermediateMux;
	 logic [ 7:0] ALUInputA;
         logic [ 7:0] ALUInputB;
	 wire [ 3:0] write_register;
         logic[ 3:0] function_register;
	 logic r15Write;
         logic mux;
	 assign function_register = Instruction[3:0];
	 //assign Check_EQ = (Instruction[8:4] == 5'b10110) ? 1'b1 : 1'b0;
         assign Check_Lessthan = (Instruction[8:4] == 5'b11101) ? 1'b1 : 1'b0;
	 assign Branch = (Instruction[8:4] == 5'b10111) ? 1'b1 : 1'b0;
         assign r15Write = (Instruction[8:4] == 5'b10110) ? 1'b1 : 1'b0;
	 //assign regWriteValue = (Instruction[8] == 0) ? Instruction[7:0] : ALUOut;
         //assign halt = (Instruction[8:0] == 9'b100000000) ? 1'b1 : 1'b0;
         
	 assign Imme = {4'b0000, Instruction[3:0]};
	 // assign input to memory
	 //assign memWriteValue = ReadB;
         always_comb begin
           //if(Instruction[8:0]
           if(Instruction[8] == 0) begin
              regWriteValue = Instruction[7:0];
           end
           else if (Instruction[8:4] == 5'b10100) begin
              regWriteValue = MemOut;
           end
           else begin
              regWriteValue = ALUOut;
           end
         end

         always_comb begin
           //if(Instruction[8:0]
           if(Instruction[8:4] == 5'b11000 || Instruction[8:4] == 5'b11001 || Instruction[8:4] == 5'b11111) begin
               mux = 0;
			  end
			  else begin
			      mux = 1;
           end
         end
         assign ReadA2 = (mux == 1)? ReadA : Imme;
	 logic mux_mem;
	always_comb begin
           //if(Instruction[8:0]
           if(Instruction[8:4] == 5'b11110) begin
		mux_mem = 1;
	   end
	   else begin
		mux_mem = 0;
           end
         end
	 logic [7:0] Write_Mem_Value;
         assign Write_Mem_Value = (mux_mem == 1)? ReadA : accumulator;
	 // Fetch Module (really just PC, we could have incorporated InstRom here as well)
	 IF if_module (
		.offset  (accumulator), 
		.start    (start), 
		.halt    (halt), 
	        .jump    (Jump),
		.CLK          , 
		.EQUAL,
		.Branch,
		.r15,
		.PC
	);

	// instruction ROM
	InstrROM instr_module(
	.instr_address   (PC), 
	.instruction_out (Instruction)
	);

	// Control module
	Control control_module (
		.OPCODE(Instruction[8:4]),
                .function_register    , 
		.ALU_OP               , 
		.ALU_SRC_B            , 
		.REG_WRITE            ,  
		.MEM_WRITE            , 
		.MEM_READ             , 
		.REG_DST              , 
		.MEM_TO_REG           ,
                .AccumulatorWrite     ,
                .AccumulatorRead      ,
                .accumulator          ,
                .Jump                 ,
                .ALUInputA            ,
                .ALUInputB            ,
		.Use_ReadA2           ,
		.HALT(halt)
	);


	reg_file #(.W(8),.D(4)) register_module (
		.CLK                  , 
		.RegWrite  (REG_WRITE), 
		.srcA      (function_register), //concatenate with 0 to give us 4 bits
		.writeReg  (function_register), 	  // mux above
		.writeValue(regWriteValue) , 
		.AccumulatorWrite,
                .AccumulatorRead,
		.ReadA,
                .accumulator,
		.EQUAL,
		.r15Write,
		.r15                     
	);
	
	 ALU ALU_Module (
		.OP    (ALU_OP) , 
		.INPUTA(accumulator)  , 
		.INPUTB(ReadA2), 
		.OUT   (ALUOut)  , 
		.CO    (carry_reg_D), 
		.Use_ReadA2,
		.EQUAL,
                .Lessthan
	);

	DataRAM Data_Module(
		.DataAddress  (accumulator), 
		.ReadMem      (MEM_READ), 
		.WriteMem     (MEM_WRITE), 
		.DataIn       (Write_Mem_Value), 
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
	always@(posedge CLK) begin
        /*if (Instruction[8:0] == 9'b100000000) begin
          halt <= 1;
        end*/
	/*if (start == 1)	begin
	  InstCounter <= 1'b0;
	  //carry_reg_Q <= 1'b0;
	end
	else if(halt == 0) begin
	  InstCounter <= InstCounter+1;
        end  */
      //carry_reg_Q <= carry_reg_D; //todo, no Q
	end
endmodule
