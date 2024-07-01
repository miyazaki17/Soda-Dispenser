// n = nickel, d = dime, q = quarter, nm = no money
// dis = dispense, rn = returnNickel, rd = returnDime, rtd = returnTwoDimes
module sodadispenser(input  logic clk,reset,
                     input  logic n,d,q,nm,
                     output logic dis,rn,rd,rtd);
							
	typedef enum logic[3:0]  {S0 =  4'b0000, 
                             S5 =  4'b0001,
                             S10 = 4'b0010,
                             S25 = 4'b0011,
                             S30 = 4'b0100,
                             S15 = 4'b0101,
                             S20 = 4'b0110,
                             S35 = 4'b0111,
                             S40 = 4'b1000,
                             S45 = 4'b1001} statetype;
   statetype state,nextstate;	
	
	// state register
	
	always_ff @(posedge clk, posedge reset)
	       if(reset) state <= S0;
			 else      state <= nextstate;
			 
  // next state logic
  
  always_comb
 
     case (state)
	   S0:   if(n)             nextstate = S5;
		      else if(d)        nextstate = S10;
				else if(q)        nextstate = S25;
				else              nextstate = S0;
				
		S5:   if(n)             nextstate = S10;
		      else if(d)        nextstate = S15;
				else if(q)        nextstate = S30;
				else if(nm)       nextstate = S0;
				else              nextstate = S5;
				
		S10:  if(n)             nextstate = S15;
		      else if(d)        nextstate = S20;
				else if(q)        nextstate = S35;
				else if(nm)       nextstate = S0;
				else              nextstate = S10;
				
		S15:  if(n)             nextstate = S20;
				else if(d)        nextstate = S25;
				else if(q)        nextstate = S40;
				else if(nm)       nextstate = S0;
				else              nextstate = S25;
		
		
		S20:  if(n)             nextstate = S25;
		      else if(d)        nextstate = S30;
				else if(q)        nextstate = S45;
				else if(nm)       nextstate = S0;
				else              nextstate = S20;
				
	   S25:  nextstate = S0;
		
		S30:  nextstate = S0;
		
		S35:  nextstate = S0;
		
		S40:  nextstate = S0;
		
		S45:  nextstate = S0;
		
	   default: nextstate = S0;
	  endcase
	
	  
	 //output logic
	 
	 assign dis = (state == S25)|(state == S30)|(state == S35)|(state == S40)|(state == S45);
	 assign rn  =  (state == S5 & nm) | (state == S15 & nm) | (state == S30) | (state == S40);
	 assign rd  = (state == S10 & nm) | (state == S15 & nm) | (state == S35) | (state == S40);
	 assign rtd = (state == S20 & nm) | (state == S45);
	 
endmodule
	 
							
							