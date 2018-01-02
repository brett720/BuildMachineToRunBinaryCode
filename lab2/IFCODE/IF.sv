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
	input CLK,
	input start,
	input [7:0] start_address,
	input jump,
	input signed [7:0] offset,
	input halt,
	output logic[7:0] PC
);
	logic [7:0] programCounter;
	
	always_ff @(posedge CLK) begin
		if (start)
			programCounter <= start_address;
		else if (halt)
			programCounter <= programCounter;
		else if (jump)
			programCounter <= programCounter + offset;
		else
			programCounter <= programCounter + 8'd1;
	end

	always_comb begin
		PC = programCounter;
	end
	
endmodule
