//`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   17:47:30 02/16/2012
// Design Name:   IF
// Module Name:   /department/home/leporter/Desktop/basic_processor/IF_tb.v
// Project Name:  basic_processor
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: IF
//
// Dependencies:
// 
// Revision:

// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module IF_tb;

	// Inputs
	bit CLK;
	bit start;
	bit [7:0] start_address;
	bit jump;
	bit [7:0] offset;
	bit halt;
	int count; 

	// Outputs
	wire [7:0] PC;
	wire [8:0] instruction_out;

	// Instantiate the Unit Under Test (UUT)
	IF IF_DUT (
  	  .CLK, 
	  .start, 
	  .start_address, 
	  .jump, 
	  .offset, 
	  .halt,
	  .PC    
	);
	
	
	InstrROM InstrROM_DUT (
		.instr_address(PC),
		.instruction_out
	);

	initial begin
		$readmemb("C:/Users/y1qiao/Desktop/cse141/lab3/stringMatch_machine.txt", InstrROM_DUT.instructions);
	
// Wait 100 ns for global reset to finish
		#100ns;
		for (count = 0; count < 200; count = count + 1) begin 
			$display("InstructionRom[%d]: %b\n", count, InstrROM_DUT.instructions[count]);
 		end
// Add stimulus here
/*
		start = 1'd1;
		start_address = 8'd0;
		
		#20ns
		jump = 0;
		halt = 0;
		
		#100ns;
		jump = 1;
		offset = -4'd5;
		
		#20ns;
		jump = 1;
		offset = 4'd10;
		
		#100ns;
		jump = 1;
		offset = 4'd3;
		
		#20ns;
		halt = 1;
		
		#20ns;
		
*/		
//		$stop;
		
	end
      
	always begin
		#10ns  CLK = 0;
		#10ns  CLK = 1; // Toggle clock every 5 ticks
	end
		
endmodule

