// Create Date:    19:25:24 11/16/2006
// Design Name:
// Module Name:    DataRAM
// Project Name:
// Description:
//
// Dependencies:
//
// Revision:  2017.02.25
// Revision 0.01 - File Created
// Additional Comments:
// default width = 8 bits; depth = 256 elements (8-bit address)
module DataRAM #(parameter D=8, W=8)(
  input                CLK,			      // writes (stores) are clocked
  input        [D-1:0] DataAddress,
  input                ReadMem,
                       WriteMem,
  input        [W-1:0] DataIn,
  output logic [W-1:0] DataOut);

  logic [W-1:0] my_memory [2**D];	      // 2-D array:  W x (2**D)

//  could put internal pre-load here -- handled by test bench
//    initial 
//        $readmemh("dataram_init.list", my_memory);

  always_comb			                  // reads are combinational
    if(ReadMem) begin
      DataOut = my_memory[DataAddress];
//  	  $display("Memory read M[%d] = %d",DataAddress,DataOut);
    end 
    else 
      DataOut = 'bZ;              		  // automatically sizes string of hi-Z to width W

  always_ff @ (posedge CLK)				  // writes are clocked (sequential)
    if(WriteMem) begin
      my_memory[DataAddress] = DataIn;
//  	$display("Memory write M[%d] = %d",DataAddress,DataIn);
    end

endmodule
