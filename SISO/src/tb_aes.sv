module tb_aes();
parameter no_of_AES =1000;
bit clk;
bit start;
bit rstn;
bit [127:0] plain_text;
bit [127:0] cipher_key;
bit done;
bit [9:0] completed_round;
bit [127:0] cipher_text;
bit [127:0] plain_text_mem [no_of_AES];
bit [127:0] cipher_key_mem [no_of_AES];
bit [127:0] cipher_text_mem [no_of_AES];
bit [127:0] initial_round_data_mem [no_of_AES];
bit [127:0] round1_data_mem [no_of_AES];
bit [127:0] round2_data_mem [no_of_AES];
bit [127:0] round3_data_mem [no_of_AES];
bit [127:0] round4_data_mem [no_of_AES];
bit [127:0] round5_data_mem [no_of_AES];
bit [127:0] round6_data_mem [no_of_AES];
bit [127:0] round7_data_mem [no_of_AES];
bit [127:0] round8_data_mem [no_of_AES];
bit [127:0] round9_data_mem [no_of_AES];
bit [127:0] cipher_text_ref_mem [no_of_AES];
bit [31:0] random_number;
bit [127:0] random_number_bigger;

AES_top dut(.*);
int count;
int no_of_errors;
always begin
  #5 clk = ~clk;
end

initial begin
  

    //$dumpfile("results.vcd");
    //$dumpvars(0, PRGRM_CNT_TB);
    //$dumpon;
    $readmemh("../../ref/plain_text.txt",plain_text_mem);
    $readmemh("../../ref/cipher_key.txt",cipher_key_mem);
    $readmemh("../../ref/cipher_text.txt",cipher_text_ref_mem);
    //for (int i=0;i<no_of_AES;i++)
    //begin
    //  void'(randomize(random_number));
    //  random_number_bigger[31:0] = random_number; 
    //  void'(randomize(random_number));
    //  random_number_bigger[63:32] = random_number; 
    //  void'(randomize(random_number));
    //  random_number_bigger[95:64] = random_number; 
    //  void'(randomize(random_number));
    //  random_number_bigger[127:96] = random_number; 
    //  plain_text_mem[i] = random_number_bigger;
    //  void'(randomize(random_number));
    //  random_number_bigger[31:0] = random_number; 
    //  void'(randomize(random_number));
    //  random_number_bigger[63:32] = random_number; 
    //  void'(randomize(random_number));
    //  random_number_bigger[95:64] = random_number; 
    //  void'(randomize(random_number));
    //  random_number_bigger[127:96] = random_number; 
    //  cipher_key_mem[i] = random_number_bigger;
    //end


    $vcdplusfile("results.vpd");
    $vcdpluson(0, tb_aes);
    $vcdplusmemon(0,tb_aes);
    clk <= 1'b0;
    rstn <= 1'b0;
    start <= 1'b0;
    rstn <= #22 1'b1;
    start <= #32 1'b1;


    //#1000000;
    //$vcdplusoff(0, tb_aes_sayan);
    //$dumpoff;
    //$finish;
end

assign plain_text = plain_text_mem[count];
assign cipher_key = cipher_key_mem[count];

always@(negedge clk)
begin
  if (done) 
  begin
    count <= count+1;
    cipher_text_mem[count] <= cipher_text;
  end
  case(completed_round)
      'b0000000001:begin
        initial_round_data_mem[count] <= cipher_text;
      end
      'b0000000010:begin
        round1_data_mem[count] <= cipher_text;
      end
      'b0000000100:begin
        round2_data_mem[count] <= cipher_text;
      end
      'b0000001000:begin
        round3_data_mem[count] <= cipher_text;
      end
      'b0000010000:begin
        round4_data_mem[count] <= cipher_text;
      end
      'b0000100000:begin
        round5_data_mem[count] <= cipher_text;
      end
      'b0001000000:begin
        round6_data_mem[count] <= cipher_text;
      end
      'b0010000000:begin
        round7_data_mem[count] <= cipher_text;
      end
      'b0100000000:begin
        round8_data_mem[count] <= cipher_text;
      end
      'b1000000000:begin
        round9_data_mem[count] <= cipher_text;
      end
  endcase
  if (count == no_of_AES)
  begin
    //$writememh("plain_text.txt",plain_text_mem);
    //$writememh("cipher_key.txt",cipher_key_mem);
    //$writememh("cipher_text.txt",cipher_text_mem);
    //$writememh("initial_round_data.txt",initial_round_data_mem);
    //$writememh("round1_data.txt",round1_data_mem);
    //$writememh("round2_data.txt",round2_data_mem);
    //$writememh("round3_data.txt",round3_data_mem);
    //$writememh("round4_data.txt",round4_data_mem);
    //$writememh("round5_data.txt",round5_data_mem);
    //$writememh("round6_data.txt",round6_data_mem);
    //$writememh("round7_data.txt",round7_data_mem);
    //$writememh("round8_data.txt",round8_data_mem);
    //$writememh("round9_data.txt",round9_data_mem);
    for (int i = 0 ; i< no_of_AES; i++)
    begin
        if (cipher_text_mem[i] != cipher_text_ref_mem[i])
            no_of_errors =no_of_errors+1;
    end
    if (no_of_errors == 0)
    begin
        $display("Congratulations, your code passed all the tests for SISO...");
    end
    else
    begin
        $display("%d out of %d test cases failed",no_of_errors,no_of_AES);
    end
    $finish();
  end
end
endmodule
