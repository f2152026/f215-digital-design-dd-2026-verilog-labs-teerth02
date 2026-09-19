// tb.v
// Starter testbench template -- YOU complete this file.

module tb;

localparam WIDTH = 8;
localparam DEPTH = 8;
  reg [$clog2(DEPTH-1):0] t_sel;
  wire [WIDTH-1:0] t_dout;


lut # (.WIDTH(WIDTH), .DEPTH(DEPTH)) DUT (
  .sel  (t_sel),
  .dout (t_dout)
);



  // Waveform dump configuration (DO NOT CHANGE)
  string vcd_file;
  initial begin
    if ($value$plusargs("vcd=%s", vcd_file)) begin
      $dumpfile(vcd_file);
      $dumpvars(0, DUT);
    end
  end
  integer expected;

  initial begin
    t_sel=0;
    expected=0;
    for(int i=1;i<DEPTH;i++)begin
      #5 t_sel=i;
      expected=i*i;

    end


  end

  initial
    $monitor($time, " SEL=%b DOUT=%d EXP=%3d", t_sel, t_dout,expected); // change as required

endmodule
