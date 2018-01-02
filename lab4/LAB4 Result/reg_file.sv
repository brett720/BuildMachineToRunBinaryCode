module reg_file #(parameter W=8, D=4)(
    input                 CLK,
	                  RegWrite,
			  AccumulatorWrite,     //check if we want to write to accumulator or reg
			  AccumulatorRead,		// 1: read from accumulator, and output accumulator
    input r15Write,
input EQUAL,
    input        [ D-1:0] srcA,					// read from register[src] 
                          writeReg, 			// which reg we want to write
    input        [ W-1:0] writeValue,			// what value we want to write
    output logic [ W-1:0] ReadA,
	output logic [W-1:0] accumulator,
    output logic [W-1:0] r15
    );

// W bits wide [W-1:0] and 2**4 registers deep or just [16]	 
logic [W-1:0] registers[2**D];
logic [W-1:0] acum;

// combinational reads to accumulator or readA output depends on instruction.
assign      ReadA = (srcA == 'b0)? 'b0 : registers[srcA];
assign r15 = registers[15];
//assign 
//assign  accumulator = (AccumulatorRead == 'b0)?  accumulator: registers[0];
/*
always_comb begin
	if (Check_EQ) begin
		registers[15] = EQUAL;
	end
	else if (Check_Lessthan) begin
		registers[15] = Lessthan;
	end
end
*/



// sequential (clocked) writes
always_ff @ (posedge CLK) begin
  if(AccumulatorWrite) begin
	 registers[0]<= writeValue;
         accumulator <= writeValue;
  end
  else if (r15Write) begin
	if(EQUAL) registers[15]<= 8'b00000001;
	else   registers[15]<= 8'b00000000;
  end
  else if (RegWrite && (writeReg != 'b0) && (writeReg != 8'b00001111))
    registers[writeReg] <= writeValue;
    //registers[writeReg] <= accumulator;
    //in store case, we need to assgin value in accumulator to the specific reg ,todo
end
endmodule