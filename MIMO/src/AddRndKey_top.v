module AddRndKey_top(
input [7:0] text_mc [15:0],
input [7:0] round_key [15:0],
input enbAR,
output reg [7:0] text_AR [15:0]
);
integer i;
always @* begin
  for(i=0; i<16;++i) begin 
    text_AR[i] = (enbAR) ? (text_mc[i]^round_key[i]) : 8'h0; // Need to check if this syntax will work
  end
end

endmodule
                    
