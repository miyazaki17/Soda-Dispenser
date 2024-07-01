module testbench();

 logic clk,reset;
 logic n,d,q,nm;
 logic dis,rn,rd,rtd;
 logic dis_exp,rn_exp,rd_exp,rtd_exp;
 logic [31:0] vectornum, errors;
 logic [7:0] testvectors[10000:0]; 
 
 sodadispenser dut(clk,reset,n,d,q,nm,dis,rn,rd,rtd);
 
 always
  begin
    clk = 1; #5; clk = 0; #5;
  end
  
 initial
   begin
    $readmemb("sodadispenser.tv", testvectors);
    vectornum = 0; errors = 0;
    reset = 1; #27; reset = 0;
   end
	
  always @(posedge clk)
     begin
      #1; {n, d, q, nm, dis_exp, rn_exp, rd_exp, rtd_exp} = testvectors[vectornum];
     end
	  
  always @(negedge clk)
     if (~reset) begin // skip during reset
      if (dis !== dis_exp | rn !== rn_exp | rd !== rd_exp | rtd !== rtd_exp) begin // check result
        $display("Error: inputs = %b", {n, d, q, nm});
        $display(" outputs = %b (%b expected)", {dis,rn,rd,rtd}, {dis_exp,rn_exp,rd_exp,rtd_exp});
        errors = errors + 1;
      end
     vectornum = vectornum + 1;
     if (testvectors[vectornum] === 8'bx) begin
       $display("%d tests completed with %d errors",vectornum, errors);
       $finish;
     end
end
endmodule