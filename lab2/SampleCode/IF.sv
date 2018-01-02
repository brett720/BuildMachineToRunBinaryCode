// 
// Create Date:    17:44:49 02/16/2012 
// Design Name: 
// Module Name:    IF 
// Project Name: 
// Description: 
//
// Dependencies: 
//
// Revision: 		  2017.02.25
// Revision 0.01 - File Created
// Additional Comments: 
module IF(
  input Branch,
  input [7:0] Target,
  input Init,
  input Halt,
  input CLK,
  output logic[7:0] PC
  );
	 
  always @(posedge CLK)
	if(Init)
	  PC <= 0;
	else if(Halt)
	  PC <= PC;
	else if(Branch)
	  PC <= Target;
	else
	  PC <= PC+1;

endmodule
