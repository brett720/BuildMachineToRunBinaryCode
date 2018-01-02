////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   18:12:37 10/27/2011
// Design Name:   ALU
// Module Name:   /department/home/leporter/Xilinx/lab_basics/ALU_tb.v
// Project Name:  lab_basics
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: ALU
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////
import definitions::*;	               // brings in package called definitions
module ALU_tb;

// DUT Inputs
  bit [2:0] OP;					   // type "bit" self-initializes to 0
  //bit [1:0] CI;
  bit [7:0] INPUTA;
  bit [7:0] INPUTB;

// DUT Outputs
  wire [7:0] OUT;
  wire	      CO;
  //wire        ZERO;
  wire        EQUAL;

	// Instantiate the Unit Under Test (UUT)
  ALU uut (
		.OP, 
		.INPUTA, 
		.INPUTB, 
		.OUT,
                .CO,
                .EQUAL
	);

initial begin
// Wait 100 ns for global reset to finish
  #100ns;
        
// Add stimulus here
  INPUTA = 8'd5;
  INPUTB = 8'd3;
  #20ns  OP = kSUB;
  #20ns	 OP = kAND;
  #20ns	 INPUTB = 8'd1;
  OP = kNOT;
  #20ns  OP = kOR;
  #20ns	 INPUTA = 8'b11001111;
  INPUTB = 8'b00000001;
  #20ns OP = kSL;
  #20ns OP = kSR;
  #20ns OP = kSL;
  #20ns OP = kASR;
  #20ns OP = kADD;
  #20ns	 INPUTA = 8'b10000001;
  INPUTB = 8'b10000001;
  #20ns $stop;
end
					 
endmodule

