module subBytes_top(
input [7:0] text_b [15:0],
input [7:0] text_b_round [15:0],
input enbsb,
input [3:0] round,
output [7:0] text_sb[15:0]
);

//Wire Declarations
wire [7:0] text_b_in [15:0];
wire [7:0] text_sb_pre[15:0];

assign text_b_in = (round==0)? text_b : text_b_round;
assign text_sb   = (enbsb)? text_sb_pre : text_b_in;

aes_sbox sb_sbox0(text_b_in[0], text_sb_pre[0]);
aes_sbox sb_sbox1(text_b_in[1], text_sb_pre[1]);
aes_sbox sb_sbox2(text_b_in[2], text_sb_pre[2]);
aes_sbox sb_sbox3(text_b_in[3], text_sb_pre[3]);
aes_sbox sb_sbox4(text_b_in[4], text_sb_pre[4]);
aes_sbox sb_sbox5(text_b_in[5], text_sb_pre[5]);
aes_sbox sb_sbox6(text_b_in[6], text_sb_pre[6]);
aes_sbox sb_sbox7(text_b_in[7], text_sb_pre[7]);
aes_sbox sb_sbox8(text_b_in[8], text_sb_pre[8]);
aes_sbox sb_sbox9(text_b_in[9], text_sb_pre[9]);
aes_sbox sb_sbox10(text_b_in[10], text_sb_pre[10]); 
aes_sbox sb_sbox11(text_b_in[11], text_sb_pre[11]);
aes_sbox sb_sbox12(text_b_in[12], text_sb_pre[12]);
aes_sbox sb_sbox13(text_b_in[13], text_sb_pre[13]);
aes_sbox sb_sbox14(text_b_in[14], text_sb_pre[14]);
aes_sbox sb_sbox15(text_b_in[15], text_sb_pre[15]);
  

  endmodule
