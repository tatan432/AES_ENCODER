
module AES_top #(N=4) (
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


wire [3:0] rndNo_N [N-1:0];
wire [3:0] rndNo;

wire accept;
wire enbSB;
wire enbSR;
wire enbMC;
wire enbAR;
wire enbKS;


genvar i;
generate


for (i=0; i<N;i++) begin
   
   AESCore core(
   .clk(clk), 
   .rstn(rstn ), 
   .plain_text(plain_text[128*i +: 128]), 
   .cipher_key(cipher_key[128*i +: 128]), 
   .accept(accept), 
   .rndNo(rndNo), 
   .enbSB(enbSB),
   .enbSR(enbSR),
   .enbMC(enbMC),
   .enbAR(enbAR),
   .enbKS(enbKS),
   .cipher_text(cipher_text[128*i +: 128])
   );
end
endgenerate

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
