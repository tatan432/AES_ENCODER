module AEScntx #(N=4) ( 
input clk, 
input start, 
input rstn, 
output accept, 
output reg [3:0] rndNo, 
output enbSB, 
output enbSR, 
output enbMC, 
output enbAR, 
output enbKS, 
//to testbench 
output done, 
output reg [9:0] completed_round 
); 

parameter CNT_WIDTH=$clog2(N);

reg [CNT_WIDTH-1:0] counter;
//reg [1:0] counter;

always @(posedge clk or negedge rstn) begin
   if(!rstn) begin
      rndNo<=0;
   end
   else  begin
     if(start==0)
        rndNo<=0;
     else if(start && rndNo<10 && counter==(N-1))
        rndNo<=rndNo+1;
     else if (start && rndNo==10 && counter==(N-1)) 
        rndNo<=0;
   end
end


always @(posedge clk or negedge rstn) begin
   if(!rstn) begin
      counter<=0;
   end
   else begin
      if(start==0)
        counter<=0;
      else if(start && counter<(N-1))
        counter<=counter+1;
      else if(counter==(N-1))
        counter<=0;
   end
end


always @* begin

   case(rndNo)
        4'd0: completed_round=10'b0000_0000_01; 
        4'd1: completed_round=10'b0000_0000_10;
        4'd2: completed_round=10'b0000_0001_00;
        4'd3: completed_round=10'b0000_0010_00;
        4'd4: completed_round=10'b0000_0100_00;
        4'd5: completed_round=10'b0000_1000_00;
        4'd6: completed_round=10'b0001_0000_00;
        4'd7: completed_round=10'b0010_0000_00;
        4'd8: completed_round=10'b0100_0000_00;
        4'd9:completed_round=10'b1000_0000_00;
        default: completed_round=10'b0000_0000_00;
   endcase
end

   assign enbSB = (rndNo>=1 && rndNo<=10);
   assign enbSR = (rndNo>=1 && rndNo<=10);
   assign enbMC = (rndNo>=1 && rndNo<=9);
   assign enbAR = (rndNo>=0 && rndNo<=10);
   assign enbKS = (rndNo>=0 && rndNo<=10);

   assign accept = start;
   assign done = (rndNo==4'd10);

endmodule
