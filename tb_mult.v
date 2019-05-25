`timescale 1 ns / 100 ps
`define TESTVECS 5

module tb;
  reg clk, reset;
  reg[3:0] a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,a1,b1,c1,d1,e1,f1,g1,h1,i1,j1,k1,l1,m1,n1,o1,p1;
  wire [7:0] q,r,s,t,u,v,w,x,y,z,a2,b2,c2,d2,e2,f2;
  reg [31:0] test_vecs [0:(`TESTVECS-1)];
  integer ic;
  initial begin $dumpfile("tb_mat_mult.vcd"); $dumpvars(0,tb); end
  initial begin reset = 1'b1; #12.5 reset = 1'b0; end
  initial clk = 1'b0; always #5 clk =~ clk;
  initial begin
test_vecs[0][127:0] = 128'h123456781234567812f45f7812f45f78;
test_vecs[1][127:0] = 128'hffffffffffffffffffffffffffffffff;
test_vecs[2][127:0] = 128'h12f45f7812f45f7812f45f7812f45f78;
test_vecs[3][127:0] = 128'h43218765432187654321876543218765;
test_vecs[4][127:0] = 128'h01200120012001200120012001200120;
end
initial {a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,a1,b1,c1,d1,e1,f1,g1,h1,i1,j1,k1,l1,m1,n1,o1,p1} = 0;
mat_4x4_multiplier mk1(a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,a1,b1,c1,d1,e1,f1,g1,h1,i1,j1,k1,l1,m1,n1,o1,p1,q,r,s,t,u,v,w,x,y,z,a2,b2,c2,d2,e2,f2);
initial begin
    #6 for(ic=0;ic<`TESTVECS;ic=ic+1)
      begin #10 {a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,a1,b1,c1,d1,e1,f1,g1,h1,i1,j1,k1,l1,m1,n1,o1,p1}=test_vecs[ic]; end
    #100 $finish;
end
endmodule
