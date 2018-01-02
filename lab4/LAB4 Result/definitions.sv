//This file defines the parameters used in the alu
package definitions;
    
// Instruction map
    const logic [2:0] kADD  = 'b000;
    const logic [2:0] kSUB  = 'b001;
    const logic [2:0] kAND  = 'b010;
    const logic [2:0] kOR  = 'b011;
    const logic [2:0] kNOT  = 'b100;
    const logic [2:0] kSL  = 'b101;
    const logic [2:0] kSR  = 'b110;
    const logic [2:0] kASR  = 'b111;

// mnemonics for display in waveform viewer    
    typedef enum logic[2:0] {
        ADDU    = 3'b000, 
        SUBU    = 3'b001, 
        AND     = 3'b010,
        OR      = 3'b011,
        NOT     = 3'b100,
	SL      = 3'b101,
	SR      = 3'b110,
	ASR     = 3'b111
    } op_mne;
    
endpackage // defintions
