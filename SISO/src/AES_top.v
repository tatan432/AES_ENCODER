
module AES_top #(N = 1)(
//from testbench
input clk,
input start,
input rstn,
input [128*N-1:0] plain_text,
input [128*N-1:0] cipher_key,
//to testbench
output done,
output [9:0] completed_round,
output [128*N-1:0] cipher_text
);


wire [3:0] rndNo;

AESCore core1(
.clk(clk), 
.rstn(rstn ), 
.plain_text(plain_text), 
.cipher_key(cipher_key), 
.accept(accept), 
.rndNo(rndNo), 
.enbSB(enbSB),
.enbSR(enbSR),
.enbMC(enbMC),
.enbAR(enbAR),
.enbKS(enbKS),
.cipher_text(cipher_text)
);

AEScntx ctrl1(
.clk                   (clk   ), 
.start                 (start ),
.rstn                  (rstn  ), 
.accept                (accept),
.rndNo                 (rndNo ),
.enbSB                 (enbSB ),
.enbSR                 (enbSR ),  
.enbMC                 (enbMC ),
.enbAR                 (enbAR ),   
.enbKS                 (enbKS ), 
.done                  (done  ),
.completed_round       (completed_round) 
); 



endmodule
