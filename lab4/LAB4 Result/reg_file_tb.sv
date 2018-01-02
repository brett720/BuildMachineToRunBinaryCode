module reg_file_tb;
	parameter DT = 4,
	          WT = 8;
// DUT Input Drivers
	bit          CLK;	      
    bit          RegWrite;  
	bit			 AccumulatorWrite;
	bit			 AccumulatorRead;
	bit [ DT-1:0] srcA,
	              writeReg;
	bit [ WT-1:0] writeValue;

// DUT Outputs
	wire [WT-1:0] ReadA,
                  accumulator;
	
	reg_file #(.W(WT),.D(DT)) uut(
	  .CLK        ,     // .CLK(CLK),
	  .RegWrite   , 
	  .AccumulatorWrite, 
	  .AccumulatorRead,
	  .srcA       , 
	  .writeReg   , 
	  .writeValue , 
	  .ReadA      , 
	  .accumulator      
	);

	initial begin
// Initialize Inputs done for us by "bit"

// Wait 100 ns for global reset to finish
	  #100ns;

// Add stimulus here
// check if write to reg[1] works, readA = reg[1]
	  srcA       =  1;
	  writeReg   =  1;
	  writeValue = 7;
	  RegWrite   =  1;
	
	  #20ns;
// verify writing const Value to accumulator
	  writeReg   =0;
	  AccumulatorWrite = 1;
	  writeValue = 5;
	 
	  #20ns;
//verify Reading data from reg[1] to readA. 
	  RegWrite   =  0;
	  AccumulatorRead = 0;
	  AccumulatorWrite = 0;
	  writeReg   =  0;
	  writeValue = 0;
	  srcA       =  1;
	#20ns;
// Read reg[1] to accumulator
	RegWrite = 0;
	writeReg = 0;
	writeValue = 0;
	srcA = 1;
	AccumulatorRead = 1;
	
	#20ns;
	
	// read value from reg3 to readA 
	  #20ns $stop;	
	end
always begin
  #10ns CLK = 1;
  #10ns CLK = 0;
end      
endmodule