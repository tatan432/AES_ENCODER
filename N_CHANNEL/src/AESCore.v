module AESCore #(N=4) (
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
reg  [7:0] text_AR_d [16*N-1:0] ;
reg  [7:0] text_AR_w [15:0] ;
wire [7:0] text_AR [15:0];
wire [7:0] text_sb [15:0];
wire [7:0] text_sr [15:0];
wire [7:0] text_mc [15:0];
wire [7:0] op_key [15:0];
reg [7:0] cipher [15:0];
reg flag;
reg  [127:0] plain_text_d [N-1:0] ;
wire [127:0] plain_text_dw;
reg  [127:0] cipher_key_d [N-1:0] ;
wire [127:0] cipher_key_dw;
integer i,l;
subBytes_top sb1(.text_b(text),.text_b_round(text_AR_w),.enbsb(enbSB),.round(rndNo),.text_sb(text_sb));
shiftRows_top sr1(.text_sb(text_sb),.enbsr(enbSR),.text_sr(text_sr));
MixCol_top mc1(.text_sr(text_sr),.enbmc(enbMC),.text_mc(text_mc));
AddRndKey_top ar1(.text_mc(text_mc),.round_key(op_key),.enbAR(enbAR),.text_AR(text_AR));
KeySchedule_top ks1(.clk(clk),.rstn(rstn), .ip_key(cipher), .enaKS(enbKS), .rndNo(rndNo), .op_key(op_key));       
 
defparam ks1.N=N;


  always @(posedge clk or negedge rstn) begin
      if(!rstn) begin
         for (l=0;l<N;l=l+1) begin
            plain_text_d[l]<=128'b0;
         end
      end
      else begin
         for (l=0;l<N;l=l+1) begin
           if(l==0) begin //Nested Generate
             plain_text_d[l]<=plain_text;
           end
           else if(l>=1) begin //Generate Else
             plain_text_d[l]<=plain_text_d[l-1];
           end
         end
      end //else end
  end //alwyas end


  always @(posedge clk or negedge rstn) begin
      if(!rstn) begin
         for (l=0;l<N;l=l+1) begin
            cipher_key_d[l]<=128'b0;
         end
      end
      else begin
         for (l=0;l<N;l=l+1) begin
            if(l==0) begin //Nested Generate
              cipher_key_d[l]<=cipher_key;
            end
            else if(l>=1) begin //Generate Else
              cipher_key_d[l]<=cipher_key_d[l-1];
            end
         end
      end //else end
  end //always end


assign plain_text_dw=plain_text_d[N-1];
assign cipher_key_dw=cipher_key_d[N-1];

always @(*) begin
  if(accept) begin
   // if(flag==1) begin
   //   for(i=0; i<=15;i=i+1) begin
   //      text[15-i]= plain_text[(8*i) +:8];
   //   end
   // end
   // else begin
      for(i=0; i<=15;i=i+1) begin
         text[15-i]= plain_text_dw[(8*i) +:8];
      end
    end
  //end
  else begin
    for(i=0; i<=15;i=i+1) begin
        text[15-i]=8'b0;
    end
  end
end

always @* begin
  if(accept) begin
   // if(flag==1) begin
   //   for(i=0; i<=15;i=i+1) begin
   //     cipher[15-i]=cipher_key[(8*i) +:8];
   //   end
   // end
   // else begin
      for(i=0; i<=15;i=i+1) begin
         cipher[15-i]= cipher_key_dw[(8*i) +:8];
      end
    end
  //end
  else begin
    for(i=0; i<=15;i=i+1) begin
        cipher[15-i]=8'b0;
    end
  end
end


//Define A flag for initial Clock Cycle which is a special case to handle
always @(posedge clk or negedge rstn) begin
  if(!rstn) begin
    flag<=1'b1;
  end
  else begin
    if(accept==0) 
     flag<=1'b1;
    else
     flag<=1'b0;
  end
end



always @(posedge clk or negedge rstn) begin

     if(!rstn) begin
         for (l=0;l<16*N;l=l+1) begin
           text_AR_d[l]<=8'b0;
         end
     end
     else begin 
         for (l=0;l<16*N;l=l+1) begin

           if(l<16) begin 
             text_AR_d[l]<=text_AR[l];
           end
           else if(l>=16) begin 
             text_AR_d[l]<=text_AR_d[l-16];
           end
         end

     end
end


always @(*) begin

  for(i=0;i<16;i=i+1) begin
     text_AR_w[i]<=text_AR_d[16*(N-1)+i];
  end
end


assign cipher_text={text_AR[0], text_AR[1], text_AR[2], text_AR[3], text_AR[4], text_AR[5], text_AR[6], text_AR[7], text_AR[8], text_AR[9], text_AR[10], text_AR[11], text_AR[12], text_AR[13], text_AR[14], text_AR[15]};

endmodule
