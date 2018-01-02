module cordic_tb;

bit  signed [11:0] x;
bit  signed [11:0] y;
wire signed [15:0] r_beh;
wire [11:0] t_beh; 
logic signed [15:0] r_DUT;
logic [11:0] t_DUT; 
bit          clk, start;
wire         done;
bit  [  7:0] score;            // how many correct trials

// be sure to substitute the name of your top_level module here
// also, substitute names of your ports, as needed
TopLevel DUT(
  .CLK   (clk),
  .start (start),
  .halt  (done)
  );

// behavioral model to match
cordic DUT1(
	x,y,r_beh,t_beh
   );

initial begin
  #10ns  start = 1'b1;
  #10ns for (int i=0; i<256; i++)		 // clear data memory
	      DUT.Data_Module.my_memory[i] = 8'b0;
// you may preload any desired constants into your data_mem here
//    ...
// case 1
  x = 16'h100;
  y = 16'h100;
  DUT.Data_Module.my_memory[0] = 8'h10;
  DUT.Data_Module.my_memory[1] = 8'h0;
  DUT.Data_Module.my_memory[2] = 8'h10;
  DUT.Data_Module.my_memory[3] = 8'h0;

// clear reg. file -- you may load any constants you wish here     
  for(int i=0; i<16; i++)
	DUT.register_module.registers[i] = 8'b0;
// load instruction ROM	-- unfilled elements will get x's -- should be harmless
  $readmemb("instr.txt",DUT.instr_module.instructions);
//  monitor ("x%d,y=%d,r=%f, t=%f", x,y,r_beh*0.6074/16.0,lookup[t_beh]);
  #10ns start = 1'b0;
  #100ns wait(done);
  #10ns  r_DUT = {DUT.Data_Module.my_memory[7],DUT.Data_Module.my_memory[8]};
         t_DUT = {DUT.Data_Module.my_memory[9],DUT.Data_Module.my_memory[10][7:3]};
  #10ns  $display(r_beh,t_beh,r_DUT,t_DUT);
  if(r_beh == r_DUT && t_beh == t_DUT)	 // score another successful trial
    score++;

// case 2
  #10ns  start = 1'b1;
  #10ns x = 16'h100;
  y = 16'h50;
  DUT.Data_Module.my_memory[0] = 8'h10;
  DUT.Data_Module.my_memory[1] = 8'h0;
  DUT.Data_Module.my_memory[2] = 8'h5;
  DUT.Data_Module.my_memory[3] = 8'h0;

// clear reg. file -- you may load any constants you wish here     
  for(int i=0; i<16; i++)
	DUT.register_module.registers[i] = 8'b0;
// load instruction ROM	-- unfilled elements will get x's -- should be harmless
  $readmemb("instr.txt",DUT.instr_module.instructions);
//  monitor ("x%d,y=%d,r=%f, t=%f", x,y,r_beh*0.6074/16.0,lookup[t_beh]);
  #10ns start = 1'b0;
  #100ns wait(done);
  #10ns  r_DUT = {DUT.Data_Module.my_memory[7],DUT.Data_Module.my_memory[8]};
         t_DUT = {DUT.Data_Module.my_memory[9],DUT.Data_Module.my_memory[10][7:3]};
  #10ns  $display(r_beh,t_beh,r_DUT,t_DUT);
  if(r_beh == r_DUT && t_beh == t_DUT)	 // score another successful trial
    score++;

// case 3
  #10ns  start = 1'b1;
  #10ns x = 16'h50;
  y = 16'h100;
  DUT.Data_Module.my_memory[0] = 8'h5;
  DUT.Data_Module.my_memory[1] = 8'h0;
  DUT.Data_Module.my_memory[2] = 8'h10;
  DUT.Data_Module.my_memory[3] = 8'h0;

// clear reg. file -- you may load any constants you wish here     
  for(int i=0; i<16; i++)
	DUT.register_module.registers[i] = 8'b0;
// load instruction ROM	-- unfilled elements will get x's -- should be harmless
  $readmemb("instr.txt",DUT.instr_module.instructions);
//  monitor ("x%d,y=%d,r=%f, t=%f", x,y,r_beh*0.6074/16.0,lookup[t_beh]);
  #10ns start = 1'b0;
  #100ns wait(done);
  #10ns  r_DUT = {DUT.Data_Module.my_memory[7],DUT.Data_Module.my_memory[8]};
         t_DUT = {DUT.Data_Module.my_memory[9],DUT.Data_Module.my_memory[10][7:3]};
  #10ns  $display(r_beh,t_beh,r_DUT,t_DUT);
  if(r_beh == r_DUT && t_beh == t_DUT)	 // score another successful trial
    score++;

	// case 4
  #10ns  start = 1'b1;
  #10ns x = 16'h100;
  y = 0;
  DUT.Data_Module.my_memory[0] = 8'h10;
  DUT.Data_Module.my_memory[1] = 8'h0;
  DUT.Data_Module.my_memory[2] = 8'h0;
  DUT.Data_Module.my_memory[3] = 8'h0;

// clear reg. file -- you may load any constants you wish here     
  for(int i=0; i<16; i++)
	DUT.register_module.registers[i] = 8'b0;
// load instruction ROM	-- unfilled elements will get x's -- should be harmless
  $readmemb("instr.txt",DUT.instr_module.instructions);
//  monitor ("x%d,y=%d,r=%f, t=%f", x,y,r_beh*0.6074/16.0,lookup[t_beh]);
  #10ns start = 1'b0;
  #100ns wait(done);
  #10ns  r_DUT = {DUT.Data_Module.my_memory[7],DUT.Data_Module.my_memory[8]};
         t_DUT = {DUT.Data_Module.my_memory[9],DUT.Data_Module.my_memory[10][7:3]};
  #10ns  $display(r_beh,t_beh,r_DUT,t_DUT);
  if(r_beh == r_DUT && t_beh == t_DUT)	 // score another successful trial
    score++;

	
	#10ns	$stop;
end

always begin
  #5ns  clk = 1'b1;
  #5ns  clk = 1'b0;
end

endmodule
