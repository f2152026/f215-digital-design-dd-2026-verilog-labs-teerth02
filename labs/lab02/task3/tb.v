module tb;
 reg  [1:0] A,B;
 wire  GT,LT,EQ;
  
  comp2 DUT(.A(A),
  .B(B),
  .GT(GT),
  .LT(LT),
  .EQ(EQ)
  );
  int error=0;
  wire gt,lt,eq;



   string vcd_file;
  initial begin
    if ($value$plusargs("vcd=%s", vcd_file)) begin
      $dumpfile(vcd_file);
      $dumpvars(0, DUT);
    end
  end
  initial begin
    A=2; B=3;
    #5 A=3; B=3;
    #5 A=3; B=2;
  end

assign eq = (A == B);
assign gt = (A > B);
assign lt = (A < B);

   
always@(*) begin
if ({GT, LT, EQ} !== {gt,lt,eq}) begin
  $display("FAIL at time %0t: A=%b B=%b  got GT=%1b LT=%b EQ=%b  expected GT=%1d LT=%1d EQ=%1d",
           $time, A, B, GT, LT, EQ, gt, lt, eq);
  error = error + 1;
end
end
    endmodule