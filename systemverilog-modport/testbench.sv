// Code your testbench here
// or browse Examples
interface mult_if (input logic clk, reset);
  logic [7:0] a, b;
  logic [15:0] out;
  logic en;
  logic ack;

  modport TB (output a,b, en, input out, ack);
  modport RTL (input clk, reset, a,b, en, output out, ack);

endinterface

module tb_top;
  bit clk;
  bit reset;

  always #2 clk = ~clk;

  initial begin
    clk = 0;
    reset = 1;
    #2;
    reset = 0;
  end 

  mult_if inf(clk, reset);
  multiplier DUT(inf);

  initial begin
    #5;
    inf.TB.a = 'd5; inf.TB.b = 'd6;
    inf.TB.en = 1;
    #10 inf.TB.en = 0;
    wait(inf.TB.ack);
    $display("time = %0t: a=%d b=%d, out=%d", $time, inf.TB.a,inf.TB.b,inf.TB.out);

    #25;
    inf.TB.a = 'd20; inf.TB.b = 'd7;
    #5ns inf.TB.en = 1;
    #6 inf.TB.en = 0;
    wait(inf.TB.ack);
    $display("time = %0t: a=%d b=%d, out=%d", $time, inf.TB.a,inf.TB.b,inf.TB.out);

    #25;
    inf.TB.a = 'd10; inf.TB.b = 'd4;
    #6ns inf.TB.en = 1;
    #5 inf.TB.en = 0;
    wait(inf.TB.ack);
    $display("time = %0t: a=%d b=%d, out=%d", $time, inf.TB.a,inf.TB.b,inf.TB.out);
    #10;
    $finish;
  end
  initial begin 
    $dumpfile("dump.vcd"); $dumpvars;
  end
endmodule
