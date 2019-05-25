module mat_4x4_multiplier(input wire[3:0] a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,a1,b1,c1,d1,e1,f1,g1,h1,i1,j1,k1,l1,m1,n1,o1,p1, output wire[7:0] q,r,s,t,u,v,w,x,y,z,a2,b2,c2,d2,e2,f2);
        wire [7:0] tv[32:0];
        mat_2x2_multiplier mk1(a,b,e,f,a1,b1,e1,f1,tv[0],tv[1],tv[2],tv[3]);
        mat_2x2_multiplier mk2(c,d,g,h,i1,j1,m1,n1,tv[4],tv[5],tv[6],tv[7]);
        mat_2x2_adder ak1(tv[0],tv[1],tv[2],tv[3],tv[4],tv[5],tv[6],tv[7],q,r,u,v);

        mat_2x2_multiplier mk3(a,b,e,f,c1,d1,g1,h1, tv[8],tv[9],tv[10],tv[11]);
        mat_2x2_multiplier mk4(c,d,g,h,k1,l1,o1,p1, tv[12],tv[13],tv[14],tv[15]);
        mat_2x2_adder ak2(tv[8],tv[9],tv[10],tv[11],tv[12],tv[13],tv[14],tv[15],s,t,w,x);

        mat_2x2_multiplier mk5(i,j,m,n,a1,b1,e1,f1, tv[16],tv[17],tv[18],tv[19]);
        mat_2x2_multiplier mk6(k,l,o,p,i1,j1,m1,n1, tv[20],tv[21],tv[22],tv[23]);
        mat_2x2_adder ak3(tv[16],tv[17],tv[18],tv[19],tv[20],tv[21],tv[22],tv[23],y,z,c2,d2);

        mat_2x2_multiplier mk7(i,j,m,n,c1,d1,g1,h1, tv[24],tv[25],tv[26],tv[27]);
        mat_2x2_multiplier mk8(k,l,o,p,k1,l1,o1,p1, tv[28],tv[29],tv[30],tv[31]);
        mat_2x2_adder ak4(tv[24],tv[25],tv[26],tv[27],tv[28],tv[29],tv[30],tv[31],a2,b2,e2,f2);
endmodule

module mat_2x2_adder(input wire[7:0] a,b,c,d,e,f,g,h,output wire[7:0] w,x,y,z);
        wire [4:0] t;
        full_adder_8bit f1(a,e,w,t[0]);
        full_adder_8bit f2(b,f,x,t[1]);
        full_adder_8bit f3(c,g,y,t[2]);
        full_adder_8bit f4(d,h,z,t[3]);
endmodule

module mat_2x2_multiplier(input wire[3:0] a,b,c,d,e,f,g,h,output wire[7:0] w,x,y,z);
        wire[7:0] p,q,r,s,t,u,v,k; wire[7:0] temp;
        multiplier_4bit m1(a,e,p);
        multiplier_4bit m2(b,g,q);
        full_adder_8bit f1(p,q,w,temp[0]);

        multiplier_4bit m3(a,f,r);
        multiplier_4bit m4(b,h,s);
        full_adder_8bit f2(r,s,x,temp[1]);

        multiplier_4bit m5(c,e,t);
        multiplier_4bit m6(d,g,u);
        full_adder_8bit f3(t,u,y,temp[2]);

        multiplier_4bit m7(c,f,v);
        multiplier_4bit m8(d,h,k);
        full_adder_8bit f4(v,k,z,temp[3]);
endmodule

module full_adder_8bit(input wire[7:0] a,b,output wire[7:0] sum,output wire cout);
        wire[8:0] t;
        full_adder_single f1(a[0],b[0],1'b0,sum[0],t[0]);
        full_adder_single f2(a[1],b[1],t[0],sum[1],t[1]);
        full_adder_single f3(a[2],b[2],t[1],sum[2],t[2]);
        full_adder_single f4(a[3],b[3],t[2],sum[3],t[3]);
        full_adder_single f5(a[4],b[4],t[3],sum[4],t[4]);
        full_adder_single f6(a[5],b[5],t[4],sum[5],t[5]);
        full_adder_single f7(a[6],b[6],t[5],sum[6],t[6]);
        full_adder_single f8(a[7],b[7],t[6],sum[7],cout);
endmodule

module full_adder_4bit(input wire[3:0] a,b,output wire[3:0] sum,output wire cout);
        wire[3:0] t;
        full_adder_single f1(a[0],b[0],1'b0,sum[0],t[0]);
        full_adder_single f2(a[1],b[1],t[0],sum[1],t[1]);
        full_adder_single f3(a[2],b[2],t[1],sum[2],t[2]);
        full_adder_single f4(a[3],b[3],t[2],sum[3],cout);
endmodule
module multiplier_4bit(input wire[3:0] a, b, output wire[7:0] product);
        wire[20:0] t; wire[20:0] c;
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

module full_adder_single(input wire a, b, cin, output wire sum, cout);
        wire[4:0] t;
        xor2 x1(a,b,t[0]);
        xor2 x2(t[0],cin,sum);
        and2 a1(a,b,t[1]);
        and2 a2(a,cin,t[2]);
        and2 a3(b,cin,t[3]);
        or2 a4(t[1],t[2],t[4]);
        or2 a5(t[4],t[3],cout);
endmodule

module half_adder_single(input wire a, b, output wire sum,cout);
        xor2 x1(a,b,sum);
        and2 a1(a,b,cout);
endmodule