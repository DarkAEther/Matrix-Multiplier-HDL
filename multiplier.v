module full_adder_8bit(input wire[7:0] a,b,output reg[7:0] sum,output reg cout);
        wire t[8:0];
        full_adder_single f1(a[0],b[0],1'b0,sum[0],t[0]);
        full_adder_single f2(a[1],b[1],t[0],sum[1],t[1]);
        full_adder_single f3(a[2],b[2],t[1],sum[2],t[2]);
        full_adder_single f4(a[3],b[3],t[2],sum[3],t[3]);
        full_adder_single f5(a[4],b[4],t[3],sum[4],t[4]);
        full_adder_single f6(a[5],b[5],t[4],sum[5],t[5]);
        full_adder_single f7(a[6],b[6],t[5],sum[6],t[6]);
        full_adder_single f8(a[7],b[7],t[6],sum[7],cout);
endmodule

module multiplier_4bit(input wire[3:0] a, b, output reg[7:0] product);
        wire t[20:0]; wire c[20:0];
        and2 a1(a[0],b[0],product[0]);

        and2 a2(a[1],b[0],t[0]);
        and2 a3(a[0],b[1],t[1]);
        half_adder_single h1(t[0],t[1],product[1],c[0]);

        and2 a4(a[2],b[0],t[2]);
        and2 a5(a[1],b[1],t[3]);
        and2 a6(a[0],b[2],t[4]);
        half_adder_single h2(t[2],t[3],c[1],c[2]);
        full_adder_single f1(t[4],c[1],c[0],product[2],c[3]);

        and2 a7(a[3],b[0],t[5]);
        and2 a8(a[2],b[1],t[6]);
        and2 a9(a[1],b[2],t[7]);
        and2 a10(a[0],b[3],t[8]);
        half_adder_single h3(t[5],t[6],c[4],c[5]);
        full_adder_single f2(c[4],t[7],c[2],c[6],c[7]);
        full_adder_single f3(c[6],t[8],c[3],product[3],c[8]);

        and2 a11(a[3],b[1],t[9]);
        and2 a12(a[2],b[2],t[10]);
        and2 a13(a[1],b[3],t[11]);
        full_adder_single f4(t[9],t[10],c[5],c[9],c[10]);
        full_adder_single f5(t[11],c[9],c[7],c[11],c[12]);
        half_adder_single h4(c[11],c[8],product[4],c[13]);

        and2 a14(a[3],b[2],t[12]);
        and2 a15(a[2],b[3],t[13]);
        full_adder_single f6(t[12],t[13],c[10],c[14],c[15]);
        full_adder_single f7(c[14],c[12],c[13],product[5],c[16]);

        and2 a16(a[3],b[3],t[14]);
        full_adder_single f8(t[14],c[15],c[16],product[6],product[7]);

endmodule

module full_adder_single(input wire a, b, cin output reg sum, cout);
        wire t[4:0];
        xor2 x1(a,b,t[0]);
        xor2 x2(t[0],cin,sum);
        and2 a1(a,b,t[1]);
        and2 a2(a,cin,t[2]);
        and2 a3(b,cin,t[3]);
        and2 a4(t[1],t[2],t[4]);
        and2 a5(t[4],t[3],cout);
endmodule

module half_adder_single(input wire a, b, output reg sum,cout);
        xor2 x1(a,b,sum);
        and2 a1(a,b,cout);
endmodule