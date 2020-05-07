module KeySchedule_top #(N=4) (
input clk,
input rstn,
input [7:0] ip_key [15:0], 
input enaKS,                 
input [3:0] rndNo, 

output [7:0] op_key [15:0]       
); 

wire [7:0] round_info [3:0];
wire [7:0] ip_key_r [3:0];
wire [7:0] next_key [15:0];
wire [7:0] ip_key_sub [3:0];
reg  [7:0] rcon;
reg  [7:0] key [15:0];
reg  [7:0] key_array [16*N-1:0] ;
integer i,l;
aes_sbox sb_sbox0(ip_key_r[0], ip_key_sub[0]);
aes_sbox sb_sbox1(ip_key_r[1], ip_key_sub[1]);
aes_sbox sb_sbox2(ip_key_r[2], ip_key_sub[2]);
aes_sbox sb_sbox3(ip_key_r[3], ip_key_sub[3]);


always @(*) begin
   case(rndNo)
     4'd1: rcon=8'h1;
     4'd2: rcon=8'h2;
     4'd3: rcon=8'h4;
     4'd4: rcon=8'h8;
     4'd5: rcon=8'h10;
     4'd6: rcon=8'h20;
     4'd7: rcon=8'h40;
     4'd8: rcon=8'h80;
     4'd9: rcon=8'h1B;
     4'd10: rcon=8'h36;
     default: rcon=0;
   endcase

end

//Rotaion Operation

assign ip_key_r[0] = key[13];
assign ip_key_r[1] = key[14];
assign ip_key_r[2] = key[15];
assign ip_key_r[3] = key[12];

// RCON Vector Calculation
assign round_info[0] = {rcon};
assign round_info[1] = 8'h0;
assign round_info[2] = 8'h0;
assign round_info[3] = 8'h0;


assign {next_key[3],next_key[2],next_key[1],next_key[0]} = {key[3], key[2], key[1], key[0]} ^ {ip_key_sub[3], ip_key_sub[2], ip_key_sub[1], ip_key_sub[0]} ^ {round_info[3], round_info[2], round_info[1], round_info[0]}; 
assign {next_key[7],next_key[6],next_key[5],next_key[4]} = {key[7], key[6], key[5], key[4]} ^ {next_key[3],next_key[2],next_key[1],next_key[0]};
assign {next_key[11],next_key[10],next_key[9],next_key[8]} ={key[11], key[10], key[9], key[8]} ^ {next_key[7],next_key[6],next_key[5],next_key[4]}; 
assign {next_key[15],next_key[14],next_key[13],next_key[12]} = {key[15], key[14], key[13], key[12]} ^ {next_key[11],next_key[10],next_key[9],next_key[8]}; 




   always @(posedge clk or negedge rstn) begin
      if (!rstn) begin
         for (l=0;l<16*N;l=l+1) begin
            key_array[l]<=8'h0;
         end
      end
      else begin

        if(rndNo==0) begin
          for (l=0;l<16*N;l=l+1) begin
             if(l<16) begin
               key_array[l]<=ip_key[l];
             end
             else if(l>=16) begin
               key_array[l]<=key_array[l-16];
             end
           end
        end
        else begin
          for (l=0;l<16*N;l=l+1) begin
             if(l<16) begin
               key_array[l]<=next_key[l];
             end
             else if(l>=16) begin
               key_array[l]<=key_array[l-16];
             end
           end
        end

      end //RSTN ELSE END
   end //Always END



always @(*) begin

  for(i=0;i<16;i=i+1) begin
     key[i]<=key_array[16*(N-1)+i];
  end
  
end




assign op_key=((rndNo==0) & enaKS) ? ip_key: next_key;


endmodule



