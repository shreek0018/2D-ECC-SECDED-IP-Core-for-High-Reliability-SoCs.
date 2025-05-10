module Encoding(input [15:0]X, output [31:0] out );
  wire [4:1] a,b,c,d;
  wire [4:1] D , P; wire [2:1] Ca , Cb , Cc , Cd;

  assign a = {X[0],X[1],X[2],X[3]};
  assign b = {X[4],X[5],X[6],X[7]};
  assign c = {X[8],X[9],X[10],X[11]};
  assign d = {X[12],X[13],X[14],X[15]};

  assign D[1] = a[1]^b[2]^a[3]^b[4];
  assign D[2] = b[1]^a[2]^b[3]^a[4];
  assign D[3] = c[1]^d[2]^c[3]^d[4];
  assign D[4] = d[1]^c[2]^d[3]^c[4];

  assign P[1] = a[1]^b[1]^c[1]^d[1];
  assign P[2] = a[2]^b[2]^c[2]^d[2];
  assign P[3] = a[3]^b[3]^c[3]^d[3];
  assign P[4] = a[4]^b[4]^c[4]^d[4];

  assign Ca = {a[1]^a[3],a[2]^a[4]};
  assign Cb = {b[1]^b[3],b[2]^b[4]};
  assign Cc = {c[1]^c[3],c[2]^c[4]};
  assign Cd = {d[1]^d[3],d[2]^d[4]};

  assign out[15:0] = X[15:0];
  assign out[31:16] = {D[4],P[4],Cd,
                       D[3],P[3],Cc,
                       D[2],P[2],Cb,
                       D[1],P[1],Ca};
endmodule
