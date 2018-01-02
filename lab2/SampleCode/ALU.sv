// Create Date:    18:04:22 10/27/2011 
// Design Name: 
// Module Name:    ALU 
// Project Name: 
//
// Dependencies: 
//
// Revision: 		  2017.02.25
// Revision 0.01 - File Created
// Additional Comments: 
//
// combinational (unclocked) unsigned ALU w/ carry-in and carry-out
import definitions::*;			      // includes package "definitions"
module ALU(
  input        [ 2:0] OP,		   	  // ALU opcode, part of microcode
  //input        [ 1:0] CI,             // shift or carry in from right (LSB side)
  input        [ 7:0] INPUTA,	   	  // data inputs
                      INPUTB,
  output logic [ 7:0] OUT,		      // or:  output reg [ 7:0] OUT,
  output logic        CO,             // shift or carry out to left (MSB side)
  //                    ZERO,			  // 1: OUT = 0
  output logic              EQUAL			  // 1: INPUTA = INPUTB
    );
	 
  assign EQUAL = (INPUTA == INPUTB) ? 1'b1 : 1'b0;	 // are inputs equal?
  op_mne op_mnemonic;			  // type enum: used for convenient waveform viewing
	
  always_comb begin
	case(OP)
	  kADD    : {CO,OUT} = INPUTA+INPUTB;    // A+B+CI
	  kSUB    : {CO,OUT} = INPUTA-INPUTB;	// A-B+CI
	  kAND    : {CO,OUT} = INPUTA&INPUTB;		// bitwise and: CO = 0 due to Verilog rules
	  kOR     : {CO,OUT} = INPUTA|INPUTB;
          kNOT    : {OUT} = ~INPUTA;
          kSL     : {OUT} = INPUTA<<INPUTB; //TODO
          kSR     : {OUT} = INPUTA>>INPUTB;
          kASR    : {OUT} = $signed(INPUTA)>>>INPUTB;
	//kSAL    : {CO,OUT} = {INPUTA,CI};			// shift A left, bringing in CI & driving CO
	  default : {CO,OUT} = 9'b0;
	endcase
//$display("ALU Out %d \n",OUT);
    op_mnemonic = op_mne'(OP);

  end

endmodule
