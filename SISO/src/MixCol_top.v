module MixCol_top(
input [7:0] text_sr [15:0],
input enbmc,
output [7:0] text_mc [15:0]
);
wire [31:0] text_m0;
wire [31:0] text_m1;
wire [31:0] text_m2;
wire [31:0] text_m3;

matrix_mult m0(.ip({text_sr[0],text_sr[1], text_sr[2], text_sr[3]}),.op(text_m0));
matrix_mult m1(.ip({text_sr[4],text_sr[5], text_sr[6], text_sr[7]}),.op(text_m1));
matrix_mult m2(.ip({text_sr[8],text_sr[9], text_sr[10], text_sr[11]}),.op(text_m2));
matrix_mult m3(.ip({text_sr[12],text_sr[13], text_sr[14], text_sr[15]}),.op(text_m3));

assign text_mc[0] = (enbmc)? text_m0[31:24] : text_sr[0] ;
assign text_mc[1] = (enbmc)? text_m0[23:16] : text_sr[1] ;
assign text_mc[2] = (enbmc)? text_m0[15:8]  : text_sr[2] ;
assign text_mc[3] = (enbmc)? text_m0[7:0]   : text_sr[3] ;


assign text_mc[4] = (enbmc)? text_m1[31:24] : text_sr[4] ;
assign text_mc[5] = (enbmc)? text_m1[23:16] : text_sr[5] ;
assign text_mc[6] = (enbmc)? text_m1[15:8]  : text_sr[6] ;
assign text_mc[7] = (enbmc)? text_m1[7:0]   : text_sr[7] ;


assign text_mc[8] = (enbmc)? text_m2[31:24] : text_sr[8] ;
assign text_mc[9] = (enbmc)? text_m2[23:16] : text_sr[9] ;
assign text_mc[10] = (enbmc)? text_m2[15:8]  : text_sr[10] ;
assign text_mc[11] = (enbmc)? text_m2[7:0]   : text_sr[11] ;


assign text_mc[12] = (enbmc)? text_m3[31:24] : text_sr[12] ;
assign text_mc[13] = (enbmc)? text_m3[23:16] : text_sr[13] ;
assign text_mc[14] = (enbmc)? text_m3[15:8]  : text_sr[14] ;
assign text_mc[15] = (enbmc)? text_m3[7:0]   : text_sr[15] ;

endmodule  
