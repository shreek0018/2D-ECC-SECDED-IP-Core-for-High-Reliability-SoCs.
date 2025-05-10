module Decoding(input [31:0]X , output [15:0] final_out );
  wire [4:1] Ra,Rb,Rc,Rd;
  wire [4:1] D,P,RD,RP;
  wire [2:1] Ca,Cb,Cc,Cd;
  wire [2:1] RCa,RCb,RCc,RCd;
  wire [2:1] SCa,SCb,SCc,SCd;

  assign D={X[31],X[27],X[23],X[19]};
  assign P={X[30],X[26],X[22],X[18]};
  assign Ca={X[17],X[16]}; assign Cb={X[21],X[20]};
  assign Cc={X[25],X[24]}; assign Cd={X[29],X[28]};
  assign Ra={X[0],X[1],X[2],X[3]};
  assign Rb={X[4],X[5],X[6],X[7]};
  assign Rc={X[8],X[9],X[10],X[11]};
  assign Rd={X[12],X[13],X[14],X[15]};

  assign RD[1] = Ra[1]^Rb[2]^Ra[3]^Rb[4];
  assign RD[2] = Rb[1]^Ra[2]^Rb[3]^Ra[4];
  assign RD[3] = Rc[1]^Rd[2]^Rc[3]^Rd[4];
  assign RD[4] = Rd[1]^Rc[2]^Rd[3]^Rc[4];

  assign RP[1] = Ra[1]^Rb[1]^Rc[1]^Rd[1];
  assign RP[2] = Ra[2]^Rb[2]^Rc[2]^Rd[2];
  assign RP[3] = Ra[3]^Rb[3]^Rc[3]^Rd[3];
  assign RP[4] = Ra[4]^Rb[4]^Rc[4]^Rd[4];

  assign RCa = {Ra[1]^Ra[3],Ra[2]^Ra[4]};
  assign RCb = {Rb[1]^Rb[3],Rb[2]^Rb[4]};
  assign RCc = {Rc[1]^Rc[3],Rc[2]^Rc[4]};
  assign RCd = {Rd[1]^Rd[3],Rd[2]^Rd[4]};

  assign SCa = Ca ^ RCa;
  assign SCb = Cb ^ RCb;
  assign SCc = Cc ^ RCc;
  assign SCd = Cd ^ RCd;

  wire [4:1] Ea, Eb, Ec, Ed;
  assign Ea[1] = SCa[1] &  SP[1];
  //... (and so on for Eb, Ec, Ed as in your code)
  // correction masks and final assembly omitted for brevity

  assign final_out = { Qd[1],Qd[2],Qd[3],Qd[4], ... ,Qa[4] };
endmodule
