module AESCore(
//from testbench
input clk,
input rstn,
input [127:0] plain_text,
input [127:0] cipher_key,
//from controller
input accept,
input [3:0] rndNo,
input enbSB,
input enbSR,
input enbMC,
input enbAR,
input enbKS,
//to testbench
output [127:0] cipher_text
);
reg [7:0] text [15:0];
reg  [7:0] text_AR_d [15:0];
wire [7:0] text_AR [15:0];
wire [7:0] text_sb [15:0];
wire [7:0] text_sr [15:0];
wire [7:0] text_mc [15:0];
wire [7:0] op_key [15:0];
reg [7:0] cipher [15:0];
integer i;

subBytes_top sb1(.text_b(text),.text_b_round(text_AR_d),.enbsb(enbSB),.round(rndNo),.text_sb(text_sb));
shiftRows_top sr1(.text_sb(text_sb),.enbsr(enbSR),.text_sr(text_sr));
MixCol_top mc1(.text_sr(text_sr),.enbmc(enbMC),.text_mc(text_mc));
AddRndKey_top ar1(.text_mc(text_mc),.round_key(op_key),.enbAR(enbAR),.text_AR(text_AR));
KeySchedule_top ks1(.clk(clk),.rstn(rstn), .ip_key(cipher), .enaKS(enbKS), .rndNo(rndNo), .op_key(op_key));       
 

always @* begin
  if(accept) begin
    for(i=0; i<=15;i=i+1) begin
        text[15-i]= plain_text[(8*i) +:8];
      end
  end
  else begin
    for(i=0; i<=15;i=i+1) begin
        text[15-i]=8'b0;
    end
  end
end

always @* begin
  if(accept) begin
    for(i=0; i<=15;i=i+1) begin
        cipher[15-i]=cipher_key[(8*i) +:8];
    end
  end
  else begin
    for(i=0; i<=15;i=i+1) begin
        cipher[15-i]=8'b0;
    end
  end
end


//assign text[0] = accept? plain_text[7:0] : 7'b0;
//assign text[1] = accept? plain_text[15:8]: 7'b0;
//assign text[2] = accept? plain_text[23:16]:7'b0;
//assign text[3] = accept? plain_text[31:24]:7'b0;
//assign text[4] = accept? plain_text[39:32]:7'b0;
//assign text[5] = accept? plain_text[47:40]:7'b0;
//assign text[6] = accept? plain_text[55:48]:7'b0;
//assign text[7] = accept? plain_text[63:56]:7'b0;
//assign text[8] = accept? plain_text[71:64]:7'b0;
//assign text[9] = accept? plain_text[79:72]:7'b0;
//assign text[10]= accept? plain_text[87:80]:7'b0;
//assign text[11]= accept? plain_text[95:88]:7'b0;
//assign text[12]= accept? plain_text[103:96] :7'b0;
//assign text[13]= accept? plain_text[111:104]:7'b0;
//assign text[14]= accept? plain_text[119:112]:7'b0;
//assign text[15]= accept? plain_text[127:120]:7'b0;
//
//assign cipher[0] = accept? cipher_key[7:0] : 7'b0;
//assign cipher[1] = accept? cipher_key[15:8]: 7'b0;
//assign cipher[2] = accept? cipher_key[23:16]:7'b0;
//assign cipher[3] = accept? cipher_key[31:24]:7'b0;
//assign cipher[4] = accept? cipher_key[39:32]:7'b0;
//assign cipher[5] = accept? cipher_key[47:40]:7'b0;
//assign cipher[6] = accept? cipher_key[55:48]:7'b0;
//assign cipher[7] = accept? cipher_key[63:56]:7'b0;
//assign cipher[8] = accept? cipher_key[71:64]:7'b0;
//assign cipher[9] = accept? cipher_key[79:72]:7'b0;
//assign cipher[10]= accept? cipher_key[87:80]:7'b0;
//assign cipher[11]= accept? cipher_key[95:88]:7'b0;
//assign cipher[12]= accept? cipher_key[103:96] :7'b0;
//assign cipher[13]= accept? cipher_key[111:104]:7'b0;
//assign cipher[14]= accept? cipher_key[119:112]:7'b0;
//assign cipher[15]= accept? cipher_key[127:120]:7'b0;
//


always @(posedge clk or negedge rstn) begin
   if(!rstn) begin
       for(i=0;i<16;++i) begin
         text_AR_d[i]<=8'b0;
       end
   end
   else begin 
       for(i=0;i<16;++i) begin
         text_AR_d[i]<=text_AR[i];
       end

   end
end

assign cipher_text={text_AR[0], text_AR[1], text_AR[2], text_AR[3], text_AR[4], text_AR[5], text_AR[6], text_AR[7], text_AR[8], text_AR[9], text_AR[10], text_AR[11], text_AR[12], text_AR[13], text_AR[14], text_AR[15]};

endmodule
