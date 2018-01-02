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
	input jump,
        input EQUAL,
	input Branch,
	input signed [7:0] offset,
	input halt,
	input logic [7:0] r15,
	output logic[7:0] PC
);
	logic [7:0] programCounter;
	logic should_jump;
	always_comb begin
	if ((jump == 1) || (Branch == 1 && r15 == 8'b00000001)) begin
		should_jump = 1'b1;
	end
	else begin
		should_jump = 1'b0;
	end
	end
	always_ff @(posedge CLK) begin
		if (start)
			programCounter <= 8'd0;
		else if (halt)
			programCounter <= 8'b0;
		else if (should_jump)
			programCounter <= programCounter + offset;
		else
			programCounter <= programCounter + 8'd1;
	end

	always_comb begin
		PC = programCounter;
	end
	
endmodule
