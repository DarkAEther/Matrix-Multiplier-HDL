`timescale 1 ns / 100 ps
`define TESTVECS 5

module tb;
  reg clk, reset;
  reg[3:0] a,b,c,d,e,f,g,h;
  wire [7:0] w,x,y,z;
  reg [31:0] test_vecs [0:(`TESTVECS-1)];
  integer i;
  initial begin $dumpfile("tb_mat_mult.vcd"); $dumpvars(0,tb); end
  initial begin reset = 1'b1; #12.5 reset = 1'b0; end
  initial clk = 1'b0; always #5 clk =~ clk;
  initial begin
test_vecs[0][31:0] = 32'h12345678;
test_vecs[1][31:0] = 32'hffffffff;
test_vecs[2][31:0] = 32'h12f45f78;
test_vecs[3][31:0] = 32'h43218765;
test_vecs[4][31:0] = 32'h01200120;
end
initial {a,b,c,d,e,f,g,h} = 0;
mat_2x2_multiplier m1(a,b,c,d,e,f,g,h,w,x,y,z);
initial begin
    #6 for(i=0;i<`TESTVECS;i=i+1)
      begin #10 {a,b,c,d,e,f,g,h}=test_vecs[i]; end
    #100 $finish;
end
endmodule
