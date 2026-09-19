module tb;
  reg [3:0] a, b;
  reg op;
  wire [3:0] result;

  alu DUT(
    .a(a),
    .b(b),
    .op(op),
    .result(result)
  );

  int error = 0;
  reg [3:0] exp_result;

  string vcd_file;
  initial begin
    if ($value$plusargs("vcd=%s", vcd_file)) begin
      $dumpfile(vcd_file);
      $dumpvars(0, DUT);
    end
  end

  int i, j, k;
  initial begin
    for (k = 0; k < 2; k++) begin
      for (i = 0; i < 16; i++) begin
        for (j = 0; j < 16; j++) begin
          a = i; b = j; op = k;
          #5;
        end
      end
    end
    #5;
    $display("Simulation done. Total errors = %0d", error);
    $finish;
  end

  always @(*) begin
    if (op == 0)
      exp_result = a + b;
    else
      exp_result = a - b;

    if ({result} !== {exp_result}) begin
      $display("FAIL at time %0t: a=%b b=%b op=%b got result=%b expected result=%b",
                $time, a, b, op, result, exp_result);
      error = error  + 1;
    end
  end

endmodule