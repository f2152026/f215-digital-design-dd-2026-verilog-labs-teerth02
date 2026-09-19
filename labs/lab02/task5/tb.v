module tb;

  reg [3:0] a, b;
  reg op;
  wire [3:0] result;

  int error = 0;
  reg [3:0] exp_result;

  int i, j, k;
  string vcd_file;

  alu DUT (
    .a(a),
    .b(b),
    .op(op),
    .result(result)
  );

  initial begin
    if ($value$plusargs("vcd=%s", vcd_file)) begin
      $dumpfile(vcd_file);
      $dumpvars(0, DUT);
    end
  end

  initial begin
    for (k = 0; k < 2; k++) begin
      for (i = 0; i < 16; i++) begin
        for (j = 0; j < 16; j++) begin

          a = i;
          b = j;
          op = k;

          if (op == 0)
            exp_result = a + b;
          else
            exp_result = a - b;

          #5;

          if (result !== exp_result) begin
            $display(
              "FAIL at time %0t: a=%b b=%b op=%b got=%b expected=%b",
              $time, a, b, op, result, exp_result
            );
            error++;
          end

        end
      end
    end

    $display("Simulation done. Total errors = %0d", error);
    $finish;
  end

endmodule