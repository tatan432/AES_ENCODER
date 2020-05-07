module shiftRows_top(
input [7:0] text_sb [15:0],
input enbsr,
output [7:0] text_sr [15:0]
);

//ROW Zero Unchaged
assign text_sr[0]= text_sb[0];
assign text_sr[4]= text_sb[4];
assign text_sr[8]= text_sb[8];
assign text_sr[12]= text_sb[12];

//ROW 1 the bytes are are left sifted by 1-byte
assign text_sr[13] = (enbsr) ? text_sb[1] : text_sb[13] ;
assign text_sr[1]  = (enbsr) ? text_sb[5] : text_sb[1]  ;
assign text_sr[5]  = (enbsr) ? text_sb[9] : text_sb[5]  ;
assign text_sr[9]  = (enbsr) ? text_sb[13]: text_sb[9]  ;

//ROW 2 the bytes area left shifted by 2-bytes
assign text_sr[10] = (enbsr) ? text_sb[2] : text_sb[10] ;
assign text_sr[14] = (enbsr) ? text_sb[6] : text_sb[14] ;
assign text_sr[2]  = (enbsr) ? text_sb[10] : text_sb[2] ;
assign text_sr[6]  = (enbsr) ? text_sb[14]: text_sb[6]  ;

//ROW 3 the bytes area left shifted by 3-bytes
assign text_sr[7]  = (enbsr) ? text_sb[3] : text_sb[7] ;
assign text_sr[11] = (enbsr) ? text_sb[7] : text_sb[11];
assign text_sr[15] = (enbsr) ? text_sb[11]: text_sb[15];
assign text_sr[3]  = (enbsr) ? text_sb[15]: text_sb[3] ;

endmodule
